package kmeans;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Vector;

import javax.xml.stream.events.StartDocument;

import kmeans.NlpirMethod;

public class MyKMeans {
	
	private static String defaultPath = "E:\\java_Eclipse\\K_Means\\文档";
	private static File traningTextDir;// 存放待聚类文本的目录
	private static String[] traningFileClassifications;//每篇文章的文件名
	private static Vector<String> allDoc = new Vector<String>();
	private static Map<String, Integer> wordMap = new HashMap<String, Integer>();//单词映射表
	private static int[][] doc_word_num;//存储每篇文章每个词出现的次数
	private static String[][] doc_device_word;//存储每篇文章分出来的词
	private static int[] num_of_doc_contain_word;//存储包含给定词的文章数目
	private static double[][]tfidf;
	//private static Vector<Vector<Integer>> each_means = new Vector<Vector<Integer>>();
	private static Means[] means;
	public static void install() throws IOException{
		NlpirMethod.Nlpir_init();//初始化分词器以便后面用以分词
		traningTextDir = new File(defaultPath);
        if (!traningTextDir.isDirectory()) 
        {
            throw new IllegalArgumentException("训练语料库搜索失败！ [" +defaultPath + "]");
        }
        traningFileClassifications = traningTextDir.list();//罗列出训练集的所有类别
        doc_device_word = new String[traningFileClassifications.length][];
        
        int index = 0;
        for(int i = 0; i < traningFileClassifications.length; i++){
        	InputStreamReader isReader =new InputStreamReader(new FileInputStream(traningTextDir.getPath() + File.separator +traningFileClassifications[i]),"GBK");
        	BufferedReader reader = new BufferedReader(isReader);
            String aline;
            StringBuilder sb = new StringBuilder();
            while ((aline = reader.readLine()) != null)
            {
                sb.append(aline + " ");
            }
            isReader.close();
            reader.close();
            allDoc.add(sb.toString());
            String []temp = NlpirMethod.NLPIR_ParagraphProcess(allDoc.get(i), 0).split(" ");
            doc_device_word[i] = temp;
            for(int j = 0; j < temp.length; j++){
            	if(wordMap.get(temp[j]) == null){
            		wordMap.put(temp[j], index);
            		index++;
            	}
            }
		}//for循环结束后allDoc中存储了所有的待聚类文章,wordMap为单词映射表
        
        doc_word_num = new int[traningFileClassifications.length][wordMap.size()];
        num_of_doc_contain_word = new int[wordMap.size()];
        
        for(int i = 0; i < traningFileClassifications.length; i++){
        	HashSet<String> tempSet = new HashSet<String>();
        	for(int j = 0; j < doc_device_word[i].length; j++){
        		if(wordMap.get(doc_device_word[i][j])!=null){
        			doc_word_num[i][wordMap.get(doc_device_word[i][j])]++;
        			tempSet.add(doc_device_word[i][j]);
        		}
        	}
        	for(int k = 0; k < tempSet.size(); k++){
        		num_of_doc_contain_word[wordMap.get(tempSet.toArray()[k])]++;
        	}
        	
        }//for循环结束后doc_word_num中存储了所有文章每个词的词频,num_of_doc_contain_word存储了包含每个词的文章的个数
        
        tfidf = new double[traningFileClassifications.length][wordMap.size()];
        for(int i = 0; i < traningFileClassifications.length;i++){
        	for(int j = 0; j < wordMap.size(); j++){
        		tfidf[i][j] = ((double)doc_word_num[i][j]/(double)doc_device_word[i].length)*(Math.log(traningFileClassifications.length/(double)num_of_doc_contain_word[j]));
        	}
        }//for循环结束后tfidf存储了每篇文章的tfidf值
	}

	private static Means[] culturate_k_means(int k,Means []eachmeans){
		for(int i = 0; i < means.length; i++){
			
			for(int j = 0; j < tfidf[i].length; j++){
				double sum = 0.0d;
			    double avg = 0.0;
				for(int q = 0; q < eachmeans[i].vector.size(); q++){
					sum = sum + tfidf[(eachmeans[i].vector.get(q)).intValue()][j];
				}
				avg = sum/eachmeans[i].vector.size();
				means[i].vector.remove(j);
				means[i].vector.insertElementAt(avg, j);
			}
		}//更新簇中心
		/*for(int i = 0; i < k; i++){
			System.out.println("++++++++++++++++++++++++++");
			for(int  j =0; j < 30; j++){
				System.out.print(means[i].vector.get(j)+"--");
			}
			System.out.println("++++++++++++++++++++++++++");
		}*/
		for(int i = 0; i < eachmeans.length; i++){
			for(int  j = 0; j < eachmeans[i].vector.size(); j++){
				eachmeans[i].vector.removeAllElements();
			}
		}
		//下面计算相似度
		for(int i = 0; i < traningFileClassifications.length; i++){
			double tempsimilar = 0.0d;
			int index = 0;
			for(int j = 0; j < k; j++){
				double sum1 = 0.0d;
			    double sum2 = 0.0d;
			    double sum3 = 0.0d;
				for(int q = 0; q < tfidf[i].length; q++){
					sum1 = sum1 + tfidf[i][q] * tfidf[i][q];
					sum2 = sum2 + means[j].vector.get(q)*means[j].vector.get(q);
					sum3 = sum3 + tfidf[i][q] * means[j].vector.get(q);
				}
				sum1 = Math.sqrt(sum1);
				sum2 = Math.sqrt(sum2);
				double denom  = sum1 * sum2;
				if(tempsimilar < (sum3/denom)){
					tempsimilar = sum3/denom;
					index = j;
				}
			}
			eachmeans[index].vector.add((double)i);
		}
		return eachmeans;
	}
	
	public static Means[] Start(int k,Means []eachmeans){
		Means []m = eachmeans;
		int num = 0;
		while(num < 10){
			num++;
			m = culturate_k_means(k,m);
		}
		return m;
	}
	
	public static void main(String[]args) throws IOException{
		install();
		int k = 3;
		Means []eachmeans = new Means[k];
		means = new Means[k];
		
		for(int i = 0; i < k; i++){
			means[i] = new Means();
			means[i].vector = new Vector<Double>();
			eachmeans[i] = new Means();
			eachmeans[i].vector = new Vector<Double>();
			
			int firstmeans = (int)(Math.random()*traningFileClassifications.length);

			eachmeans[i].vector.add((double)firstmeans);
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			for(int qq = 0; qq < 30; qq++){
				System.out.print(tfidf[firstmeans][qq]+"--");
			}
			System.out.println();
			for(int j = 0; j < tfidf[firstmeans].length; j++){
				means[i].vector.add(tfidf[firstmeans][j]);
			}			
		}//初始化好中心以及各个簇的初始成员
		
		/*///////////////////////////////////////////////////////////////////////////
		means[0] = new Means();
		means[0].vector = new Vector<Double>();
		eachmeans[0] = new Means();
		eachmeans[0].vector = new Vector<Double>();
		means[1] = new Means();
		means[1].vector = new Vector<Double>();
		eachmeans[1] = new Means();
		eachmeans[1].vector = new Vector<Double>();
		means[2] = new Means();
		means[2].vector = new Vector<Double>();
		eachmeans[2] = new Means();
		eachmeans[2].vector = new Vector<Double>();
		eachmeans[0].vector.add((double)27);
		eachmeans[1].vector.add((double)6);
		eachmeans[2].vector.add((double)14);
		for(int j = 0; j < tfidf[0].length; j++){
			means[0].vector.add(tfidf[0][j]);
		}
		for(int j = 0; j < tfidf[0].length; j++){
			means[1].vector.add(tfidf[3][j]);
		}
		for(int j = 0; j < tfidf[0].length; j++){
			means[2].vector.add(tfidf[14][j]);
		}
		////////////////////////////////////////////////////////////////////////////
		 * */
		
		for(int i = 0; i < means.length; i++){
			System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
			for(int j = 0; j < 30; j++){
				System.out.print(means[i].vector.get(j)+"--");
			}
			System.out.println();
		}
		
		eachmeans = Start(k,eachmeans);
    	for(int i = 0; i < eachmeans.length; i++){
    		System.out.println("====================================");
    		System.out.println("=========" + eachmeans[i].vector.size() + "===========");
    		for(int j = 0; j < eachmeans[i].vector.size(); j++){
    			System.out.println(eachmeans[i].vector.get(j));
    		}
    	}
	}
}