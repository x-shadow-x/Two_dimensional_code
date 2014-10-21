package kmeans;

import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;

import com.sun.jna.Library;
import com.sun.jna.Native;

public class NlpirLibrary {

	// ����ӿ�CLibrary���̳���com.sun.jna.Library
	public interface CLibraryNlpir extends Library {
		// ���岢��ʼ���ӿڵľ�̬������ͨ��JNA����NLPIR.dll;
		CLibraryNlpir Instance = (CLibraryNlpir) Native.loadLibrary("NLPIR",
				CLibraryNlpir.class);

		/**
		 * 
		 * @param sDataPath
		 *            ϵͳ�ļ���Data�ĸ�Ŀ¼��һ����Ϊ��������ʾѰ����Ŀ�µ�Data�ļ���
		 * @param encoding
		 *            ���÷ִʱ��룬ֻ�ܴ�����Ӧ��ʼ������ļ�.
		 *            Ĭ��ΪGBK��0��GBK��1��UTF-8;2:BIG5;3:GBK_FANTI
		 * @param sLicenceCode
		 *            licenseCodeĬ��Ϊ"0"
		 * @return Return true if init succeed. Otherwise return false
		 */
		public int NLPIR_Init(String sDataPath, int encoding,
				String sLicenceCode);

		public String NLPIR_GetLastErrorMsg();

		/**
		 * 
		 * @param sSrc
		 *            :The source paragraph(��Ҫ�ִʵ����ݣ�
		 * @param bPOSTagged
		 *            :Judge whether need POS tagging, 0 for no tag; 1 for
		 *            tagging���Ƿ��д��Ա�ע��
		 * @return:�����ķִʽ��
		 */
		public String NLPIR_ParagraphProcess(String sSrc, int bPOSTagged);

		/**
		 * 
		 * @param sSourceFilename
		 *            :The source file name to be analysized;����Ҫ������ļ����ƣ�
		 * @param sResultFilename
		 *            :The result file name to store the results.�����������ݵı���·����
		 * @param bPOStagged
		 *            : Judge whether need POS tagging, 0 for no tag; 1 for
		 *            tagging; default:1.���Ƿ��д��Ա�ע��
		 * @return��Return true if processing succeed. Otherwise return false.
		 */
		public double NLPIR_FileProcess(String sSourceFilename,
				String sResultFilename, int bPOStagged);

		/**
		 * 
		 * @param sLine
		 *            ��the input text.����Ҫ��ȡ�ؼ��ʵ��ı���
		 * @param nMaxKeyLimit
		 *            ��the maximum number of key words.���ؼ��ʵ����������
		 * @param bWeightOut
		 *            �� whether the keyword weight output or not���ؼ��ʵ�Ȩ���Ƿ������
		 * @return:Return the keywords list if excute succeed. otherwise return
		 *                NULL.(���عؼ��ʼ���
		 */
		public String NLPIR_GetKeyWords(String sLine, int nMaxKeyLimit,
				boolean bWeightOut);

		/**
		 * 
		 * @param sLine
		 *            ��the input text.����Ҫ��ȡ�´ʵ��ı���
		 * @param nMaxKeyLimit
		 *            ��the maximum number of key words.���ؼ��ʵ����������
		 * @param bWeightOut
		 *            �� whether the keyword weight output or not���ؼ��ʵ�Ȩ���Ƿ������
		 * @return:Return the new words list if excute succeed. otherwise return
		 *                NULL.(�����´ʼ���
		 */
		public String NLPIR_GetNewWords(String sLine, int nMaxKeyLimit,
				boolean bWeightOut);

		public String NLPIR_GetFileKeyWords(String string, int nMaxKeyLimit,
				boolean bWeightOut);

		public String NLPIR_GetFileNewWords(String string, int nMaxKeyLimit,
				boolean bWeightOut);
        public int NLPIR_AddUserWord(String userWord);
    	public int NLPIR_ImportUserDict(String dictFileName);
		public void NLPIR_Exit();
	}	
}

