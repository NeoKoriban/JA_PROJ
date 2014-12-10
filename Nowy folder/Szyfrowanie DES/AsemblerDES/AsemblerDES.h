// The following ifdef block is the standard way of creating macros which make exporting 
// from a DLL simpler. All files within this DLL are compiled with the ASEMBLERDES_EXPORTS
// symbol defined on the command line. This symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see 
// ASEMBLERDES_API functions as being imported from a DLL, whereas this DLL sees symbols
// defined with this macro as being exported.
#ifdef ASEMBLERDES_EXPORTS
#define ASEMBLERDES_API __declspec(dllexport)
#else
#define ASEMBLERDES_API __declspec(dllimport)
#endif

// This class is exported from the AsemblerDES.dll
class ASEMBLERDES_API CAsemblerDES {
public:
	CAsemblerDES(void);
	// TODO: add your methods here.
};

extern ASEMBLERDES_API int nAsemblerDES;

ASEMBLERDES_API int fnAsemblerDES(void);
