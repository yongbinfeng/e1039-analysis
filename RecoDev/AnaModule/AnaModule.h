#ifndef _ANA_Module__H_
#define _ANA_Module__H_

#include <map>
#include <fun4all/SubsysReco.h>
#include <TString.h>
#include <TVector3.h>
#include <ktracker/SRecEvent.h>

class TFile;
class TTree;
class SQHitVector;

class AnaModule: public SubsysReco 
{
public:
  AnaModule() {;}
  virtual ~AnaModule() {;}

  int Init(PHCompositeNode* topNode);
  int InitRun(PHCompositeNode* topNode);
  int process_event(PHCompositeNode* topNode);
  int End(PHCompositeNode* topNode);

  void set_output_filename(const TString& n);

private:
  int GetNodes(PHCompositeNode* topNode);
  void MakeTree();

  // Input
  SQHitVector* hitVector;
  SRecEvent* recEvent;

  // Output
  TString saveName;
  TFile* saveFile;
  TTree* saveTree;

  int eventID;
  TVector3* pos1;
  TVector3* pos2;
  TVector3* pos3;
  TVector3* mom1;
  TVector3* mom2;
  TVector3* mom3;
  TVector3* mom;
};

#endif
