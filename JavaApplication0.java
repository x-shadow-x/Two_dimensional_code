package javaapplication0;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

public class JavaApplication0 {

    public static HashSet<String> set_d = new HashSet<String>();//存储词典
    public static Map<String, Double> map_w = new HashMap<String, Double>();//存储属性集以及包含该单词的文档数
    public static Map<Integer, String> map_w1 = new HashMap<Integer, String>();//用以遍历map_w中的键值
    public static int num = 0;
    public static Object[] o = new Object[50];//记录每篇文章的词的tf-idf值
    public static Object[] o1 = new Object[50];//待删~用以查看o[]中是否存了正确的文章
    public static int num_text = 50;
    public static String[] str = {"IT", "财经", "健康", "教育", "军事", "旅游", "汽车", "体育", "文化", "招聘"};

    public static void main(String[] args) throws FileNotFoundException, IOException {
        getdictionary();

        int index = 0;
        String path_head = "E:\\java\\JavaApplication8\\搜狗语料库\\SogouC.mini\\Sample\\";
        for (int i = 0; i < str.length; i++) {
            for (int j = 10; j < 15; j++) {
                String text = gettext(path_head + str[i] + "\\" + j + ".txt");
                devide(text, index);//将各文章分词后保存词频并完成总属性集合
                index++;
            }
        }//的数目,这些单词如果有重复那只算一次,所以如果文本越多，向量的维数将会越大)
        System.out.println("==================================================");
//        for(int i = 0;i < index;i++){
//            for(int j = 0;j < map_w1.size();j++){
//                if(((HashMap)o[i]).get(map_w1.get(j))==null)
//                    ((HashMap)o[i]).put(map_w1.get(j),(double)0);
//            }
//            System.out.println();
//        }
//        for(int i = 0;i < index;i++){
//            for(int j = 0;j < map_w1.size();j++){
//                System.out.print(((HashMap)o[i]).get(map_w1.get(j)));
//            }
//            System.out.println();
//        }
        getTF_IDF();
        for(int i = 0;i < index;i++){
            for(int j = 0;j < map_w1.size();j++){
                System.out.print(((HashMap)o[i]).get(map_w1.get(j))+"  ");
            }
            System.out.println();
        }//查看tf-idf值
//        int[] index_of_centence_text = {0, 5, 10, 15, 20, 25, 30, 35, 40, 45};
//        for(int i = 0;i < 10;i++){
//            System.out.println(o1[index_of_centence_text[i]]);
//        }
        k_means();
    }

    public static void getdictionary() throws FileNotFoundException, IOException {
        File file = new File("E:\\学习文档\\数据挖掘\\暑假作业\\Group NLP 暑假作业\\词典\\chineseDic.txt");
        InputStream fin = new FileInputStream(file);
        BufferedReader buff = new BufferedReader(new InputStreamReader(fin));
        StringBuffer buf = new StringBuffer();
        String line1 = "";
        String line2 = "";
        while ((line1 = buff.readLine()) != null) {
            line2 = line1.replaceAll(",.*", "");
            set_d.add(line2);
        }
    }

    public static String gettext(String file_path) throws FileNotFoundException, IOException {
        File file = new File(file_path);
        InputStream in_st = new FileInputStream(file);
        BufferedReader buff = new BufferedReader(new InputStreamReader(in_st));
        StringBuffer res = new StringBuffer();
        String line = "";
        while ((line = buff.readLine()) != null) {
            res.append(line);
        }
        return res.toString();
    }

    public static void devide(String text, int index) {
        HashSet<String> set_temp = new HashSet<String>();
        HashMap<String, Double> map_t = new HashMap<String, Double>();//存储该篇文章的词频
        String substring = "";
        StringBuffer buf = new StringBuffer();
        int max_length = 4;
        int temp_length = max_length + 1;
        int begin_index = 0;

        while (begin_index < text.length()) {
            //经过下面的while循环进行匹配
            while (temp_length > 1) {
                temp_length = temp_length - 1;
                if ((begin_index + temp_length) > text.length()) {
                    temp_length = text.length() - begin_index;
                }
                substring = text.substring(begin_index, begin_index + temp_length);
                if (temp_length > 1) {//否则已经是一个字符了~就不在字典中寻找了
                    if (set_d.contains(substring)) {//在词典中找到了该词
                        if (map_t.containsKey(substring)) {//map_t已经有这个词了~更新其出现的次数
                            double count = 1 + map_t.get(substring);
                            map_t.put(substring, count);
                        } else {//map_t没有这个词，加入map_t出现次数为1
                            map_t.put(substring, (double) 1);
                        }
                        set_temp.add(substring);
                        substring = substring + "\r\n";
                        buf.append(substring);
                        begin_index = begin_index + temp_length;
                        temp_length = -1;
                    }
                }
                if (temp_length == 1) {//temp_length的长度为1则不管词典中有没有这个词都单字为词
                    if (map_t.containsKey(substring)) {
                        double count = 1 + map_t.get(substring);
                        map_t.put(substring, count);
                    } else {
                        map_t.put(substring, (double) 1);
                    }
                    set_temp.add(substring);
                    buf.append(text.charAt(begin_index));
                    begin_index = begin_index + 1;
                }
            }
            System.out.println(substring);
            temp_length = max_length + 1;
        }//buf中保存了分好词的新闻
        
        o1[index] = text;
        o[index] = map_t;//将一篇文章的词的词频存进数组保存
        //更新属性集合
        for (int i = 0; i < set_temp.size(); i++) {
            if (map_w.containsKey((String) set_temp.toArray()[i])) {
                double count = 1 + map_w.get((String) set_temp.toArray()[i]);
                map_w.put((String) set_temp.toArray()[i], count);
            } else {//这个词是新的，存入map_w,同时更新map_w1  
                map_w.put((String) set_temp.toArray()[i], (double)1);
                map_w1.put(num, (String) set_temp.toArray()[i]);
                num++;
            }
        }
    }

    public static void getTF_IDF() {
        int indexi = 0;
        int indexj = 0;
        try {
            for (int i = 0; i < o.length; i++) {
                indexi = i;
                //System.out.println(map_w1.get("***"));
                for (int j = 0; j < map_w1.size(); j++) {
                    System.out.println(i + "@" + j + map_w1.get(j));
                    indexj = j;
                    if (((HashMap) o[i]).containsKey(map_w1.get(j))) {//这篇文章中找到了这个词，开始计算tf-idf值
                        double idf = Math.log10(num_text/map_w.get(map_w1.get(j)));
                        double tempdouble = Double.parseDouble(((HashMap) o[i]).get(map_w1.get(j)).toString());
                        double tf = tempdouble / num_text;
                        double tf_idf = tf * idf;
                        ((HashMap) o[i]).put(map_w1.get(j), tf_idf);
                    } else {//这篇文章中没有找到这个词，tf-idf值为0
                        ((HashMap) o[i]).put(map_w1.get(j), (double) 0);
                    }
                }
            }
        }
        catch (NullPointerException ex) {
            //Logger.getLogger(JavaApplication0.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println( ((HashMap)o[indexi]).containsKey(map_w1.get(indexj)));
            System.out.println("###"+map_w1.get(indexj));
            System.out.println("#######");
            System.out.println(indexi);
            System.out.println( ((HashMap)o[indexi]).containsKey(map_w1.get(indexj)));
        }
    }

    public static void k_means() throws FileNotFoundException, IOException {
        int time = 6;
        int indexi = 0;
        int k = 10;
        int index = 0;
        double min = Double.MAX_VALUE;
        boolean iscontinue = true;
        double[][] centence_tf_idf = new double[k][map_w1.size()];
        double[][] centence_tf_idf2 = new double[k][map_w1.size()];

        int[] index_of_centence_text = {0, 5, 10, 15, 20, 25, 30, 35, 40, 45};
        int[][] centence = new int[k][50];//记录每篇文章的归属
        int[] style_num = new int[k];//记录中心中包含的元素的个数

        try{
        for (int i = 0; i < k; i++) {
            indexi = i;
            for (int j = 0; j < map_w1.size(); j++) {
                centence_tf_idf[i][j] = Double.parseDouble(((HashMap) o[index_of_centence_text[i]]).get(map_w1.get(j)).toString());
            }
        }//做完后centence_tf_idf中保存了中心点的tf-idf值
        }
        catch (ArrayIndexOutOfBoundsException ex) {
            System.out.println(index_of_centence_text[indexi]);
        }
        for (int i = 0; i < k; i++) {
            for (int j = 0; j < map_w1.size(); j++) {
                centence_tf_idf2[i][j] = centence_tf_idf[i][j];
            }
        }//保存中心值的副本用以判断是否需要继续迭代

        while (iscontinue && (time >= 1)) {
            for (int i = 0; i < o.length; i++) {
                for (int j = 0; j < k; j++) {//循环找出最近的中心点
                    double temp = 0;
                    for (int m = 0; m < map_w1.size(); m++) {
                        System.out.println("第"+i+"篇");
//                        double t1 = Double.parseDouble(((HashMap) o[i]).get(map_w1.get(m)).toString());
//                        double t2 = Double.parseDouble(((HashMap) o[index_of_centence_text[m]]).get(map_w1.get(m)).toString());
                        double t1 = Double.parseDouble(((HashMap) o[i]).get(map_w1.get(m)).toString());//第i篇文章第m个词的tf-idf值
                        double t2 = centence_tf_idf[j][m];//第j个中心点第m个词的tf-idf值         
                        temp = temp + (t1 - t2) * (t1 - t2);
 
                    }//for循环做完后temp保存的是距离的平方
                    if (temp < min) {//说明这篇文章离当前的中心即j中心更近
                        index = j;
                        min = temp;
                    }
                }
                centence[index][style_num[index]] = i;//跳出上面的for循环后得到文章i离index中心最近
                style_num[index] = style_num[index] + 1;
                min = Double.MAX_VALUE;
            }//完成一次聚类
            //更新中心点
            for (int i = 0; i < k; i++) {
                for (int j = 0; j < map_w1.size(); j++) {//计算第i个中心的第j维tf-idf值
                    double sum = 0;
                    for (int m = 0; m < style_num[i]; m++) {//第i个中心点包含了style_num[i]篇文章
                        sum = sum + Double.parseDouble(((HashMap) o[centence[i][m]]).get(map_w1.get(j)).toString());
                    }
                    centence_tf_idf[i][j] = sum / style_num[i];
                }
            }

            //判断是否需要继续
            iscontinue = false;
            for (int i = 0; i < k; i++) {
                for (int j = 0; j < map_w1.size(); j++) {
                    if (centence_tf_idf[i][j] != centence_tf_idf2[i][j]) {
                        iscontinue = true;
                    }
                }
            }
            time--;
            if ((iscontinue == true)&&(time >=1)) {//若为true~中心点和上一次不一样~应继续迭代~更新centence_tf_idf2用以下一次判断
                
                for (int i = 0; i < k; i++) {
                    for (int j = 0; j < map_w1.size(); j++) {
                        centence_tf_idf2[i][j] = centence_tf_idf[i][j];
                    }
                }
                for (int i = 0; i < k; i++) {
                    for (int j = 0; j < num_text; j++) {
                        centence[i][j] = 0;
                    }
                }
                for (int i = 0; i < k; i++) {
                    style_num[i] = 0;
                }
            }
            System.out.println(iscontinue);
        }//迭代结束~存储结果

//        for (int i = 0; i < k; i++) {
//            for (int j = 0; j < style_num[i]; j++) {
//                String h = "E:\\java\\JavaApplication8\\搜狗语料库\\SogouC.mini\\Sample\\";
//                String file_path = h + str[centence[i][j] / 5] + "\\" + (10 + centence[i][j] % 5) + ".txt";
//                File file = new File(file_path);
//                InputStream in_st = new FileInputStream(file);
//                BufferedReader buff = new BufferedReader(new InputStreamReader(in_st));
//                StringBuffer res = new StringBuffer();
//                String line = "";
//                while ((line = buff.readLine()) != null) {
//                    res.append(line);
//                }
//                File file2 = new File("E:\\java\\JavaApplication8\\分类\\" + i + "\\" + j + ".txt");
//                file2.createNewFile();
//                OutputStreamWriter fon = new OutputStreamWriter(new FileOutputStream(file));
//                fon.write(res.toString());
//                fon.close();
//            }
//        }
        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        for(int i = 0;i < k;i++){
            for(int j = 0;j < style_num[i];j++){
                System.out.print(centence[i][j]+"  ");
            }
            System.out.println();
        }
        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        for(int i = 0;i < k;i++){
            for(int j = 0;j < style_num[i];j++){
                File file = new File("E:\\java\\JavaApplication8\\分类\\" + i + "\\" + j + ".txt");
                OutputStreamWriter fon = new OutputStreamWriter(new FileOutputStream(file));
                fon.write(o1[centence[i][j]].toString());
                fon.close();
            }
        }
    }
}
