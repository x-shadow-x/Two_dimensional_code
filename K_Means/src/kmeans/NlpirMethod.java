package kmeans;

import kmeans.NlpirLibrary.CLibraryNlpir;

import org.apache.log4j.Logger;



public class NlpirMethod {
	private static Logger logger = Logger.getLogger(NlpirMethod.class.getName());
	private static final int GBK_CODE = 0;// Ĭ��֧��GBK����
	private static final int UTF8_CODE = 1;// UTF8����
	private static final int BIG5_CODE = 2;// BIG5����
	private static final int GBK_FANTI_CODE = 3;// GBK���룬�������������
	
	
	public static void main(String[]arg){
		Nlpir_init();
		System.out.println(NLPIR_ParagraphProcess("Ĭ��֧��GBK����",0));
	}
	public static boolean Nlpir_init(){
		logger.debug("��ʼ����ʼ");
		String argu="";
		int init_flag = CLibraryNlpir.Instance.NLPIR_Init(// .getBytes(system_charset)
				argu, UTF8_CODE, "0");
		if (0 == init_flag) {
			logger.debug("��ʼ��ʧ�ܣ�");
			return false;
		}
		logger.debug("��ʼ���ɹ�������");
		return true;
		
	}
	/**
	 * ͨ�������ַ������зִ�
	 * @param sSrc
	 * @param bPOSTagged
	 * @return
	 */
	public static String NLPIR_ParagraphProcess(String sSrc, int bPOSTagged){
		String ParticipleResult=CLibraryNlpir.Instance.NLPIR_ParagraphProcess(sSrc, bPOSTagged);
		//logger.debug("�ִʽ���");
		return ParticipleResult;
	}
	/**
	 * ͨ�������������ƽ��зִ�
	 * @param sSourceFilename
	 * @param sResultFilename
	 * @param bPOStagged
	 * @return
	 */
	public static double NLPIR_FileProcess(String sSourceFilename,
			String sResultFilename, int bPOStagged){
		double d=CLibraryNlpir.Instance.NLPIR_FileProcess(sSourceFilename, sResultFilename, bPOStagged);
		return d;
	}
	/**
	 * ��װΪ�����������Ĺؼ�����ȡ
	 * @param sLine
	 * @param nMaxKeyLimit
	 * @param bWeightOut
	 * @return
	 */
	public static String NLPIR_GetKeyWords(String sLine, int nMaxKeyLimit,
			boolean bWeightOut){
		String strOfKeyword="";
		if(sLine.length() < 100){
			logger.debug("��Ҫ��ȡ�ؼ��ʵ��ı�����̫��");
		}else{
	     strOfKeyword=CLibraryNlpir.Instance.NLPIR_GetKeyWords(sLine, nMaxKeyLimit, bWeightOut);
		}
	     return strOfKeyword;
	}
	/**
	 * ��װΪֻ��һ�������Ĺؼ�����ȡ����
	 * @param sLine:Ҫ��ȡ�ؼ��ʵ��ı�
	 *    ����Ϊ��nMaxKeyLimit=10;  bWeightOut=false;
	 * @return
	 */
	public static String NLPIR_GetKeyWords(String sLine){
		int nMaxKeyLimit=10;
		boolean bWeightOut=false;
		String strOfKeyword="";
		if(sLine.length() < 100){
			logger.debug("��Ҫ��ȡ�ؼ��ʵ��ı�����̫��");
		}else{
	     strOfKeyword=CLibraryNlpir.Instance.NLPIR_GetKeyWords(sLine, nMaxKeyLimit, bWeightOut);
		}
	     return strOfKeyword;
	}
	/**
	 * ��װΪ�������������´���ȡ����
	 * @param sLine
	 * @param nMaxKeyLimit
	 * @param bWeightOut
	 * @return
	 */
	public static String NLPIR_GetNewWords(String sLine, int nMaxKeyLimit,
			boolean bWeightOut){
		
		String strOfNewword="";
		if(sLine.length() < 100){
			logger.debug("��Ҫ��ȡ�´ʵ��ı�����̫��");
		}else{
			strOfNewword=CLibraryNlpir.Instance.NLPIR_GetNewWords(sLine, nMaxKeyLimit, bWeightOut);
		}
	     return strOfNewword;
	}
	/**
	 * ��װΪ��һ���������´���ȡ����
	 * @param sLine
	 * @return
	 */
	public static String NLPIR_GetNewWords(String sLine){
		int nMaxKeyLimit=10;
		boolean bWeightOut=false;
		String strOfNewword="";
		if(sLine.length() < 100){
			logger.debug("��Ҫ��ȡ�´ʵ��ı�����̫��");
		}else{
			strOfNewword=CLibraryNlpir.Instance.NLPIR_GetNewWords(sLine, nMaxKeyLimit, bWeightOut);
		}
	     return strOfNewword;
	}
	/**
	 * ��װΪ��������������ͨ�������ļ�·������ȡ�ؼ��ʵķ���
	 * @param filePath���ļ�·��
	 * @param nMaxKeyLimit
	 * @param bWeightOut
	 * @return
	 */
	public static String NLPIR_GetFileKeyWords(String filePath, int nMaxKeyLimit,
			boolean bWeightOut){
		   String strOfKeyWord=CLibraryNlpir.Instance.NLPIR_GetFileKeyWords(filePath, nMaxKeyLimit, bWeightOut);
		   return strOfKeyWord;
		
	}
	/**
	 * ��װΪ����һ��������ͨ�������ļ�·�������´ʵķ���
	 * @param filePath���ļ�·��
	 * @return���ؼ��ʽ����
	 */
	public static String NLPIR_GetFileKeyWords(String filePath){
		   int nMaxKeyLimit=10;
		   boolean bWeightOut=false;
		   String strOfKeyWord=CLibraryNlpir.Instance.NLPIR_GetFileKeyWords(filePath, nMaxKeyLimit, bWeightOut);
		   return strOfKeyWord;
		
	}
	/**
	 * ��װΪ��������������ͨ�������ļ�·������ȡ�´ʵķ���
	 * @param filePath���ļ�·��
	 * @param nMaxKeyLimit:����´���
	 * @param bWeightOut���Ƿ����Ȩ��
	 * @return���´ʽ����
	 */
	public static String NLPIR_GetFileNewWords(String filePath, int nMaxKeyLimit,
			boolean bWeightOut){
		   String strOfNewWord=CLibraryNlpir.Instance.NLPIR_GetFileNewWords(filePath, nMaxKeyLimit, bWeightOut);
		   return strOfNewWord;
		
	}
	/**
	 * ��װΪ����һ��������ͨ�������ļ�·������ȡ�´ʵķ���
	 * @param filePath ���ļ�·��
	 * @return���´ʽ����
	 */
	public static String NLPIR_GetFileNewWords(String filePath){
		   int nMaxKeyLimit=10;
		   boolean bWeightOut=false;
		   String strOfNewWord=CLibraryNlpir.Instance.NLPIR_GetFileNewWords(filePath, nMaxKeyLimit, bWeightOut);
		   return strOfNewWord;
		
	}
	public static int NLPIR_AddUserWord(String userWord){
		return CLibraryNlpir.Instance.NLPIR_AddUserWord(userWord);
	}
	/**
	 * 
	 * @param dictFileName:�û��Զ���ʵ�·��
	 * @return �Ƿ���ӳɹ�
	 */
	public static int NLPIR_ImportUserDict(String dictFileName){
		return CLibraryNlpir.Instance.NLPIR_ImportUserDict(dictFileName);
	}
	
}
