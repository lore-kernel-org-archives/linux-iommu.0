From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: source-id verification failures
Date: Thu, 4 Oct 2018 15:07:46 -0700
Message-ID: <20181004150746.4a243396@jacob-builder>
References: <20181002172529.fjapu46h5y57m3f7@cantor>
	<20181004090753.GC3630@8bytes.org>
	<20181004205724.4kqntecb6m7gcgu6@cantor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181004205724.4kqntecb6m7gcgu6@cantor>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 4 Oct 2018 13:57:24 -0700
Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Thu Oct 04 18, Joerg Roedel wrote:
> >Hi Jerry,
> >
> >thanks for the report.
> >
> >On Tue, Oct 02, 2018 at 10:25:29AM -0700, Jerry Snitselaar wrote:  
> >> I've been trying to track down a problem where an hp dl380 gen8
> >> with a Cavium QLogic BR-1860 Fabric Adapter is getting source-id
> >> verification failures when running dhclient against that
> >> interface. This started showing up when I backported the iova
> >> deferred flushing patches. So far this has only been seen on this
> >> one system, but I'm trying to understand why it appears with the
> >> new deferred flushing code. I also see it with both 4.18.10, and
> >> 4.19.0-rc6 kernels.
> >>
> >> [35645.282021] bna 0000:24:00.1 ens5f1: link down
> >> [35645.298396] bna 0000:24:00.0 ens5f0: link down
> >> [35650.313210] DMAR: DRHD: handling fault status reg 2
> >> [35650.332477] DMAR: [INTR-REMAP] Request device [24:00.0] fault
> >> index 14 [fault reason 38] Blocked an interrupt request due to
> >> source-id verification failure [35655.137667] bna 0000:24:00.0
> >> ens5f0: link up [35657.532454] bna 0000:24:00.1 ens5f1: link up
> >> [35664.281563] bna 0000:24:00.1 ens5f1: link down [35664.298103]
> >> bna 0000:24:00.0 ens5f0: link down [35669.313568] DMAR: DRHD:
> >> handling fault status reg 102 [35669.333198] DMAR: [INTR-REMAP]
> >> Request device [24:00.0] fault index 14 [fault reason 38] Blocked
> >> an interrupt request due to source-id verification failure
> >> [35674.081212] bna 0000:24:00.0 ens5f0: link up [35674.981280] bna
> >> 0000:24:00.1 ens5f1: link up
> >>
> >>
> >> Any ideas?  
> >
> >No, not yet. Can you please post the output of lscpi -vvv?
> >
> >Jacob, can you or someone from your team please also have a look into
> >this problem report?
> >
yep.
+Ashok

Jerry,
Could you also dump the interrupt remapping table with this patchset?
https://lkml.org/lkml/2018/9/12/44

Thanks,

Jacob

> >Thanks,
> >
> >	Joerg  
> 
> 
> # lspci -vvv
> 00:00.0 Host bridge: Intel Corporation Xeon E5/Core i7 DMI2 (rev 07)
> 	Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Interrupt: pin A routed to IRQ 0 NUMA node: 0
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 2.5GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed unknown, Width x0, TrErr- Train-
> SlotClk- DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible- RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd- DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 2.5GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [144 v1] Vendor
> Specific Information: ID=0004 Rev=1 Len=03c <?> Capabilities: [1d0
> v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2
> Len=018 <?>
> 
> 00:01.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 1a (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 24 NUMA
> node: 0 Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
> 	I/O behind bridge: 00006000-00006fff
> 	Memory behind bridge: f7800000-f7ffffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #8, Speed 8GT/s,
> Width x8, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive+ BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 00:01.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 1b (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 24 NUMA
> node: 0 Bus: primary=00, secondary=13, subordinate=13, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 00:02.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 2a (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 24 NUMA
> node: 0 Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: f4000000-f40fffff
> 	Prefetchable memory behind bridge:
> 00000000f6300000-00000000f63fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #16, Speed 8GT/s,
> Width x8, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk+ ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive+ BWMgmt+ ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 00:02.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 2b (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 24 NUMA
> node: 0 Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 00:02.2 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 2c (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 24 NUMA
> node: 0 Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> 	I/O behind bridge: 00005000-00005fff
> 	Memory behind bridge: f7600000-f77fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #18, Speed 8GT/s,
> Width x8, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot- ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 8GT/s, Width x8, TrErr- Train-
> SlotClk+ DLActive+ BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete+, EqualizationPhase1+ EqualizationPhase2+,
> EqualizationPhase3+, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 00:02.3 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 2d (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 24 NUMA
> node: 0 Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot- ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 8GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 00:03.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 3a in PCI Express Mode (rev 07) (prog-if 00 [Normal
> decode]) Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed
> to IRQ 24 NUMA node: 0 Bus: primary=00, secondary=04, subordinate=04,
> sec-latency=0 I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag+ RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #24, Speed 8GT/s,
> Width x16, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 00:03.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 3b (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 24 NUMA
> node: 0 Bus: primary=00, secondary=16, subordinate=16, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 00:03.2 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 3c (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 24 NUMA
> node: 0 Bus: primary=00, secondary=17, subordinate=17, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot- ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 00:03.3 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 3d (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 24 NUMA
> node: 0 Bus: primary=00, secondary=18, subordinate=18, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot- ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 00:04.0 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed
> to IRQ 268 NUMA node: 0
> 	Region 0: Memory at f64f0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 00:04.1 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 1 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin B routed
> to IRQ 270 NUMA node: 0
> 	Region 0: Memory at f64e0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 00:04.2 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 2 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin C routed
> to IRQ 268 NUMA node: 0
> 	Region 0: Memory at f64d0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 00:04.3 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 3 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin D routed
> to IRQ 270 NUMA node: 0
> 	Region 0: Memory at f64c0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 00:04.4 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 4 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed
> to IRQ 268 NUMA node: 0
> 	Region 0: Memory at f64b0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 00:04.5 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 5 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin B routed
> to IRQ 270 NUMA node: 0
> 	Region 0: Memory at f64a0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 00:04.6 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 6 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin C routed
> to IRQ 268 NUMA node: 0
> 	Region 0: Memory at f6490000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 00:04.7 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 7 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin D routed
> to IRQ 270 NUMA node: 0
> 	Region 0: Memory at f6480000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 00:05.0 System peripheral: Intel Corporation Xeon E5/Core i7 Address
> Map, VTd_Misc, System Management (rev 07) Subsystem: Hewlett-Packard
> Company Device 18a8 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
> VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+
> 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx- NUMA node: 0 Capabilities: [40] Express (v2) Root
> >Complex Integrated Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis-, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> 
> 00:05.2 System peripheral: Intel Corporation Xeon E5/Core i7 Control
> Status and Global Errors (rev 07) Subsystem: Hewlett-Packard Company
> Device 18a8 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
> VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+
> 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx- NUMA node: 0 Capabilities: [40] Express (v2) Root
> >Complex Integrated Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr+ UncorrErr+ FatalErr+
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis-, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> 
> 00:05.4 PIC: Intel Corporation Xeon E5/Core i7 I/O APIC (rev 07)
> (prog-if 20 [IO(X)-APIC]) Subsystem: Hewlett-Packard Company Device
> 18a8 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes NUMA node: 0
> 	Region 0: Memory at f6470000 (32-bit, non-prefetchable)
> [size=4K] Capabilities: [6c] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME-
> 
> 00:11.0 PCI bridge: Intel Corporation C600/X79 series chipset PCI
> Express Virtual Root Port (rev 05) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
> Stepping- SERR+ FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ
> 16 NUMA node: 0 Bus: primary=00, secondary=1a, subordinate=1a,
> sec-latency=0 I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Express (v2) Root Port (Slot-), MSI 00 DevCap:	MaxPayload
> 128 bytes, PhantFunc 0 ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #17, Speed 2.5GT/s,
> Width x1, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us ClockPM-
> Surprise- LLActRep- BwNot- ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled+ CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible- RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Not Supported,
> TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS- Compliance De-emphasis: -6dB LnkSta2: Current
> De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] Power Management version 3 Flags: PMEClk- DSI- D1-
> D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3
> NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME- Capabilities: [88]
> Subsystem: Hewlett-Packard Company Device 18a9 Capabilities: [90]
> MSI: Enable- Count=1/1 Maskable- 64bit- Address: 00000000  Data: 0000
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UESvrt:	DLP+ SDES-
> TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP- ECRC-
> UnsupReq- ACSViol- CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- AERCap:	First Error Pointer: 00, GenCap-
> CGenEn- ChkCap- ChkEn- Capabilities: [138 v1] Access Control Services
> ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans+ ACSCtl:	SrcValid+ TransBlk- ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- Kernel driver in
> use: pcieport
> 
> 00:1a.0 USB controller: Intel Corporation C600/X79 series chipset
> USB2 Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
> Subsystem: Hewlett-Packard Company Device 18a9 Control: I/O- Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0 Interrupt: pin A routed to IRQ 21 NUMA node: 0
> 	Region 0: Memory at f6460000 (32-bit, non-prefetchable)
> [size=1K] Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst- PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [58] Debug port: BAR=1 offset=00a0
> 	Capabilities: [98] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: ehci-pci
> 
> 00:1c.0 PCI bridge: Intel Corporation C600/X79 series chipset PCI
> Express Root Port 1 (rev b5) (prog-if 00 [Normal decode]) Control:
> I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping-
> SERR+ FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 16 NUMA
> node: 0 Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Express (v2) Root Port (Slot-), MSI 00 DevCap:	MaxPayload
> 128 bytes, PhantFunc 0 ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr+ TransPend- LnkCap:	Port #1, Speed 5GT/s,
> Width x4, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us ClockPM-
> Surprise- LLActRep+ BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train+
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible- RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BC, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd- DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 2.5GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [80] MSI:
> Enable- Count=1/1 Maskable- 64bit- Address: 00000000  Data: 0000
> 	Capabilities: [90] Subsystem: Hewlett-Packard Company Device
> 18a9 Capabilities: [a0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst- PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UESvrt:	DLP- SDES-
> TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq- ACSViol- CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- AERCap:	First Error Pointer: 00, GenCap-
> CGenEn- ChkCap- ChkEn- Kernel driver in use: pcieport
> 
> 00:1c.7 PCI bridge: Intel Corporation C600/X79 series chipset PCI
> Express Root Port 8 (rev b5) (prog-if 00 [Normal decode]) Control:
> I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping-
> SERR+ FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin D routed to IRQ 19 NUMA
> node: 0 Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 00003000-00003fff
> 	Memory behind bridge: f6500000-f75fffff
> 	Prefetchable memory behind bridge:
> 00000000f5000000-00000000f5ffffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Express (v2) Root Port (Slot-), MSI 00 DevCap:	MaxPayload
> 128 bytes, PhantFunc 0 ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr+ TransPend- LnkCap:	Port #8, Speed 5GT/s,
> Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us ClockPM-
> Surprise- LLActRep+ BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+ DLActive+ BWMgmt+ ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible- RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BC, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd- DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 5GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [80] MSI:
> Enable- Count=1/1 Maskable- 64bit- Address: 00000000  Data: 0000
> 	Capabilities: [90] Subsystem: Hewlett-Packard Company Device
> 18a9 Capabilities: [a0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst- PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UESvrt:	DLP- SDES-
> TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq- ACSViol- CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- AERCap:	First Error Pointer: 00, GenCap-
> CGenEn- ChkCap- ChkEn- Kernel driver in use: pcieport
> 
> 00:1d.0 USB controller: Intel Corporation C600/X79 series chipset
> USB2 Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
> Subsystem: Hewlett-Packard Company Device 18a9 Control: I/O- Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0 Interrupt: pin A routed to IRQ 20 NUMA node: 0
> 	Region 0: Memory at f6450000 (32-bit, non-prefetchable)
> [size=1K] Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst- PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [58] Debug port: BAR=1 offset=00a0
> 	Capabilities: [98] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: ehci-pci
> 
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5)
> (prog-if 01 [Subtractive decode]) Control: I/O+ Mem+ BusMaster+
> SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency: 0 NUMA node: 0
> 	Bus: primary=00, secondary=19, subordinate=19, sec-latency=32
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B+
> ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [50] Subsystem: Hewlett-Packard Company Device 18a9
> 
> 00:1f.0 ISA bridge: Intel Corporation C600/X79 series chipset LPC
> Controller (rev 05) Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx- Status: Cap+
> 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx- Latency: 0 NUMA node: 0
> 	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> 	Kernel driver in use: lpc_ich
> 	Kernel modules: lpc_ich
> 
> 00:1f.2 IDE interface: Intel Corporation C600/X79 series chipset
> 4-Port SATA IDE Controller (rev 05) (prog-if 8f [PCI native mode
> controller, supports both channels switched to ISA compatibility
> mode, supports bus mastering]) Subsystem: Hewlett-Packard Company
> Device 18a9 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx- Status: Cap+
> 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx- Latency: 0 Interrupt: pin B routed to IRQ 17 NUMA
> >node: 0 Region 0: I/O ports at 4000 [size=8]
> 	Region 1: I/O ports at 4008 [size=4]
> 	Region 2: I/O ports at 4010 [size=8]
> 	Region 3: I/O ports at 4018 [size=4]
> 	Region 4: I/O ports at 4020 [size=16]
> 	Region 5: I/O ports at 4030 [size=16]
> 	Capabilities: [70] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [b0] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: ata_piix
> 	Kernel modules: ata_piix, pata_acpi, ata_generic
> 
> 01:00.0 System peripheral: Hewlett-Packard Company Integrated
> Lights-Out Standard Slave Instrumentation & System Support (rev 05)
> Subsystem: Hewlett-Packard Company iLO4 Control: I/O+ Mem+ BusMaster+
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency: 0, Cache Line
> >Size: 64 bytes Interrupt: pin A routed to IRQ 19
> 	NUMA node: 0
> 	Region 0: I/O ports at 3000 [size=256]
> 	Region 1: Memory at f75f0000 (32-bit, non-prefetchable)
> [size=512] Region 2: I/O ports at 3400 [size=256]
> 	Capabilities: [78] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [b0] MSI: Enable- Count=1/1
> Maskable- 64bit+ Address: 0000000000000000  Data: 0000
> 	Capabilities: [c0] Express (v1) Legacy Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0,
> Latency L0s unlimited, L1 unlimited ExtTag- AttnBtn- AttnInd- PwrInd-
> RBE+ FLReset- DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq+ AuxPwr- TransPend- LnkCap:	Port #0, Speed 2.5GT/s,
> Width x1, ASPM L0s, Exit Latency L0s <4us, L1 <4us ClockPM- Surprise-
> LLActRep- BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64
> bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk- DLActive- BWMgmt- ABWMgmt- Kernel driver in use: hpwdt
> 	Kernel modules: hpwdt
> 
> 01:00.1 VGA compatible controller: Matrox Electronics Systems Ltd.
> MGA G200EH (prog-if 00 [VGA controller]) Subsystem: Hewlett-Packard
> Company iLO4 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx- Status: Cap+
> 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt:
> >pin B routed to IRQ 16
> 	NUMA node: 0
> 	Region 0: Memory at f5000000 (32-bit, prefetchable) [size=16M]
> 	Region 1: Memory at f75e0000 (32-bit, non-prefetchable)
> [size=16K] Region 2: Memory at f6800000 (32-bit, non-prefetchable)
> [size=8M] [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
> 	Capabilities: [a8] Power Management version 3
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [b0] MSI: Enable- Count=1/1
> Maskable- 64bit+ Address: 0000000000000000  Data: 0000
> 	Capabilities: [c0] Express (v1) Legacy Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0,
> Latency L0s unlimited, L1 unlimited ExtTag- AttnBtn- AttnInd- PwrInd-
> RBE+ FLReset- DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq+ AuxPwr- TransPend- LnkCap:	Port #0, Speed 2.5GT/s,
> Width x1, ASPM L0s, Exit Latency L0s <4us, L1 <4us ClockPM- Surprise-
> LLActRep- BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64
> bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk- DLActive- BWMgmt- ABWMgmt- Kernel driver in use: mgag200
> 	Kernel modules: mgag200
> 
> 01:00.2 System peripheral: Hewlett-Packard Company Integrated
> Lights-Out Standard Management Processor Support and Messaging (rev
> 05) Subsystem: Hewlett-Packard Company iLO4 Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin B routed to IRQ 16 NUMA
> node: 0 Region 0: I/O ports at 3800 [size=256]
> 	Region 1: Memory at f67f0000 (32-bit, non-prefetchable)
> [size=256] Region 2: Memory at f6600000 (32-bit, non-prefetchable)
> [size=1M] Region 3: Memory at f6580000 (32-bit, non-prefetchable)
> [size=512K] Region 4: Memory at f6570000 (32-bit, non-prefetchable)
> [size=32K] Region 5: Memory at f6560000 (32-bit, non-prefetchable)
> [size=32K] [virtual] Expansion ROM at f6500000 [disabled] [size=64K]
> 	Capabilities: [78] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [b0] MSI: Enable- Count=1/1
> Maskable- 64bit+ Address: 0000000000000000  Data: 0000
> 	Capabilities: [c0] Express (v1) Legacy Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0,
> Latency L0s unlimited, L1 unlimited ExtTag- AttnBtn- AttnInd- PwrInd-
> RBE+ FLReset- DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq+ AuxPwr- TransPend- LnkCap:	Port #0, Speed 2.5GT/s,
> Width x1, ASPM L0s, Exit Latency L0s <4us, L1 <4us ClockPM- Surprise-
> LLActRep- BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64
> bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk- DLActive- BWMgmt- ABWMgmt- Kernel driver in use: hpilo
> 	Kernel modules: hpilo
> 
> 01:00.4 USB controller: Hewlett-Packard Company Integrated Lights-Out
> Standard Virtual USB Controller (rev 02) (prog-if 00 [UHCI])
> Subsystem: Hewlett-Packard Company iLO4 Control: I/O+ Mem- BusMaster+
> SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency: 0, Cache Line
> >Size: 64 bytes Interrupt: pin B routed to IRQ 16
> 	NUMA node: 0
> 	Region 4: I/O ports at 3c00 [size=32]
> 	Capabilities: [70] MSI: Enable- Count=1/1 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [80] Express (v1) Legacy Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0,
> Latency L0s unlimited, L1 unlimited ExtTag- AttnBtn- AttnInd- PwrInd-
> RBE+ FLReset- DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq+ AuxPwr- TransPend- LnkCap:	Port #0, Speed 2.5GT/s,
> Width x1, ASPM L0s, Exit Latency L0s <4us, L1 <4us ClockPM- Surprise-
> LLActRep- BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64
> bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk- DLActive- BWMgmt- ABWMgmt- Capabilities: [f0] Power
> Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Kernel driver in use: uhci_hcd
> 
> 02:00.0 RAID bus controller: Hewlett-Packard Company Smart Array Gen8
> Controllers (rev 01) Subsystem: Hewlett-Packard Company P420i
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed
> to IRQ 28 NUMA node: 0
> 	Region 0: Memory at f7700000 (64-bit, non-prefetchable)
> [size=1M] Region 2: Memory at f76f0000 (64-bit, non-prefetchable)
> [size=1K] Region 4: I/O ports at 5000 [size=256]
> 	[virtual] Expansion ROM at f7600000 [disabled] [size=512K]
> 	Capabilities: [80] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1+,D2-,D3hot+,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [90] MSI: Enable- Count=1/32
> Maskable- 64bit+ Address: 0000000000000000  Data: 0000
> 	Capabilities: [b0] MSI-X: Enable+ Count=64 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [c0] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 512 bytes, PhantFunc 0,
> Latency L0s <4us, L1 <1us ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
> FLReset- SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable- Non-Fatal+ Fatal+ Unsupported- RlxdOrd+ ExtTag+
> PhantFunc- AuxPwr- NoSnoop+ MaxPayload 256 bytes, MaxReadReq 4096
> bytes DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend- LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM not
> supported, Exit Latency L0s unlimited, L1 <64us ClockPM- Surprise-
> LLActRep- BwNot- ASPMOptComp+ LnkCtl:	ASPM Disabled; RCB 64
> bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 8GT/s, Width x8, TrErr- Train-
> SlotClk- DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range B, TimeoutDis+, LTR+, OBFF Via message DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkCtl2:
> Target Link Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin:
> Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB LnkSta2: Current De-emphasis Level:
> -3.5dB, EqualizationComplete+, EqualizationPhase1+
> EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
> Capabilities: [100 v2] Advanced Error Reporting UESta:	DLP-
> SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:	RxErr- BadTLP-
> BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:	RxErr- BadTLP-
> BadDLLP- Rollover- Timeout- NonFatalErr- AERCap:	First Error
> Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn- Capabilities: [300 v1]
> #19 Kernel driver in use: hpsa Kernel modules: hpsa
> 
> 03:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> BCM5719 Gigabit Ethernet PCIe (rev 01) Subsystem: Hewlett-Packard
> Company Ethernet 1Gb 4-port 331FLR Adapter Control: I/O- Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR-
> FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 27 NUMA
> node: 0 Region 0: Memory at f63f0000 (64-bit, prefetchable) [size=64K]
> 	Region 2: Memory at f63e0000 (64-bit, prefetchable) [size=64K]
> 	Region 4: Memory at f63d0000 (64-bit, prefetchable) [size=64K]
> 	[virtual] Expansion ROM at f4000000 [disabled] [size=256K]
> 	Capabilities: [48] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=1 PME- Capabilities: [50] Vital Product Data
> 		Product Name: HP Ethernet 1Gb 4-port 331FLR Adapter
> 		Read-only fields:
> 			[PN] Part number: 629133-002
> 			[EC] Engineering changes: A-5608
> 			[MN] Manufacture ID: 31 30 33 43
> 			[V0] Vendor specific: 5W PCIeGen2
> 			[V1] Vendor specific: 17.4.1
> 			[V3] Vendor specific: 1.46
> 			[V5] Vendor specific: 0A
> 			[V6] Vendor specific: 17.2.1
> 			[V7] Vendor specific: 331FLR
> 			[VA] Vendor specific: 17.4.41
> 			[RV] Reserved: checksum good, 219 byte(s)
> reserved End
> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
> 		Vector table: BAR=4 offset=00000000
> 		PBA: BAR=4 offset=00001000
> 	Capabilities: [ac] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0,
> Latency L0s <4us, L1 <64us ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset+ SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable- Non-Fatal+ Fatal+ Unsupported- RlxdOrd- ExtTag-
> PhantFunc- AuxPwr+ NoSnoop- FLReset- MaxPayload 256 bytes, MaxReadReq
> 4096 bytes DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+ TransPend- LnkCap:	Port #0, Speed 5GT/s, Width x4,
> ASPM L0s L1, Exit Latency L0s <1us, L1 <2us ClockPM+ Surprise-
> LLActRep- BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64
> bytes Disabled- CommClk+ ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkCtl2:
> Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis- Transmit
> Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS- Compliance De-emphasis: -6dB LnkSta2: Current
> De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v1] Advanced Error Reporting UESta:	DLP-
> SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq+ ACSViol- UEMsk:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:	RxErr- BadTLP-
> BadDLLP- Rollover- Timeout- NonFatalErr+ CEMsk:	RxErr- BadTLP-
> BadDLLP- Rollover- Timeout- NonFatalErr- AERCap:	First Error
> Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn- Capabilities: [13c v1]
> Device Serial Number 00-00-2c-44-fd-7e-50-98 Capabilities: [150 v1]
> Power Budgeting <?> Capabilities: [160 v1] Virtual Channel
> Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1 Arb:	Fixed-
> WRR32- WRR64- WRR128- Ctrl:	ArbSelect=Fixed Status:
> InProgress- VC0:	Caps:	PATOffset=00 MaxTimeSlots=1
> RejSnoopTrans- Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128-
> WRR256- Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 	Kernel driver in use: tg3
> 	Kernel modules: tg3
> 
> 03:00.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> BCM5719 Gigabit Ethernet PCIe (rev 01) Subsystem: Hewlett-Packard
> Company Ethernet 1Gb 4-port 331FLR Adapter Control: I/O- Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR-
> FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin B routed to IRQ 182 NUMA
> node: 0 Region 0: Memory at f63c0000 (64-bit, prefetchable) [size=64K]
> 	Region 2: Memory at f63b0000 (64-bit, prefetchable) [size=64K]
> 	Region 4: Memory at f63a0000 (64-bit, prefetchable) [size=64K]
> 	[virtual] Expansion ROM at f4040000 [disabled] [size=256K]
> 	Capabilities: [48] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=1 PME- Capabilities: [50] Vital Product Data
> 		Product Name: HP Ethernet 1Gb 4-port 331FLR Adapter
> 		Read-only fields:
> 			[PN] Part number: 629133-002
> 			[EC] Engineering changes: A-5608
> 			[MN] Manufacture ID: 31 30 33 43
> 			[V0] Vendor specific: 5W PCIeGen2
> 			[V1] Vendor specific: 17.4.1
> 			[V3] Vendor specific: 1.46
> 			[V5] Vendor specific: 0A
> 			[V6] Vendor specific: 17.2.1
> 			[V7] Vendor specific: 331FLR
> 			[VA] Vendor specific: 17.4.41
> 			[RV] Reserved: checksum good, 219 byte(s)
> reserved End
> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
> 		Vector table: BAR=4 offset=00000000
> 		PBA: BAR=4 offset=00001000
> 	Capabilities: [ac] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0,
> Latency L0s <4us, L1 <64us ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset+ SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable- Non-Fatal+ Fatal+ Unsupported- RlxdOrd- ExtTag-
> PhantFunc- AuxPwr+ NoSnoop- FLReset- MaxPayload 256 bytes, MaxReadReq
> 4096 bytes DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+ TransPend- LnkCap:	Port #0, Speed 5GT/s, Width x4,
> ASPM L0s L1, Exit Latency L0s <1us, L1 <2us ClockPM+ Surprise-
> LLActRep- BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64
> bytes Disabled- CommClk+ ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkSta2:
> Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1- EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest- Capabilities: [100 v1] Advanced Error
> Reporting UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UEMsk:	DLP-
> SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq+ ACSViol- UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
> ChkEn- Capabilities: [13c v1] Device Serial Number
> 00-00-2c-44-fd-7e-50-99 Capabilities: [150 v1] Power Budgeting <?>
> Capabilities: [160 v1] Virtual Channel Caps:	LPEVC=0
> RefClk=100ns PATEntryBits=1 Arb:	Fixed- WRR32- WRR64- WRR128-
> Ctrl:	ArbSelect=Fixed Status:	InProgress- VC0:
> Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans- Arb:
> Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256- Ctrl:	Enable+
> ID=0 ArbSelect=Fixed TC/VC=ff Status:	NegoPending- InProgress-
> 	Kernel driver in use: tg3
> 	Kernel modules: tg3
> 
> 03:00.2 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> BCM5719 Gigabit Ethernet PCIe (rev 01) Subsystem: Hewlett-Packard
> Company Ethernet 1Gb 4-port 331FLR Adapter Control: I/O- Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR-
> FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 27 NUMA
> node: 0 Region 0: Memory at f6390000 (64-bit, prefetchable) [size=64K]
> 	Region 2: Memory at f6380000 (64-bit, prefetchable) [size=64K]
> 	Region 4: Memory at f6370000 (64-bit, prefetchable) [size=64K]
> 	[virtual] Expansion ROM at f4080000 [disabled] [size=256K]
> 	Capabilities: [48] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=1 PME- Capabilities: [50] Vital Product Data
> 		Product Name: HP Ethernet 1Gb 4-port 331FLR Adapter
> 		Read-only fields:
> 			[PN] Part number: 629133-002
> 			[EC] Engineering changes: A-5608
> 			[MN] Manufacture ID: 31 30 33 43
> 			[V0] Vendor specific: 5W PCIeGen2
> 			[V1] Vendor specific: 17.4.1
> 			[V3] Vendor specific: 1.46
> 			[V5] Vendor specific: 0A
> 			[V6] Vendor specific: 17.2.1
> 			[V7] Vendor specific: 331FLR
> 			[VA] Vendor specific: 17.4.41
> 			[RV] Reserved: checksum good, 219 byte(s)
> reserved End
> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
> 		Vector table: BAR=4 offset=00000000
> 		PBA: BAR=4 offset=00001000
> 	Capabilities: [ac] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0,
> Latency L0s <4us, L1 <64us ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset+ SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable- Non-Fatal+ Fatal+ Unsupported- RlxdOrd- ExtTag-
> PhantFunc- AuxPwr+ NoSnoop- FLReset- MaxPayload 256 bytes, MaxReadReq
> 4096 bytes DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+ TransPend- LnkCap:	Port #0, Speed 5GT/s, Width x4,
> ASPM L0s L1, Exit Latency L0s <1us, L1 <2us ClockPM+ Surprise-
> LLActRep- BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64
> bytes Disabled- CommClk+ ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkSta2:
> Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1- EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest- Capabilities: [100 v1] Advanced Error
> Reporting UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UEMsk:	DLP-
> SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq+ ACSViol- UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
> ChkEn- Capabilities: [13c v1] Device Serial Number
> 00-00-2c-44-fd-7e-50-9a Capabilities: [150 v1] Power Budgeting <?>
> Capabilities: [160 v1] Virtual Channel Caps:	LPEVC=0
> RefClk=100ns PATEntryBits=1 Arb:	Fixed- WRR32- WRR64- WRR128-
> Ctrl:	ArbSelect=Fixed Status:	InProgress- VC0:
> Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans- Arb:
> Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256- Ctrl:	Enable+
> ID=0 ArbSelect=Fixed TC/VC=ff Status:	NegoPending- InProgress-
> 	Kernel driver in use: tg3
> 	Kernel modules: tg3
> 
> 03:00.3 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> BCM5719 Gigabit Ethernet PCIe (rev 01) Subsystem: Hewlett-Packard
> Company Ethernet 1Gb 4-port 331FLR Adapter Control: I/O- Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR-
> FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin B routed to IRQ 182 NUMA
> node: 0 Region 0: Memory at f6360000 (64-bit, prefetchable) [size=64K]
> 	Region 2: Memory at f6350000 (64-bit, prefetchable) [size=64K]
> 	Region 4: Memory at f6340000 (64-bit, prefetchable) [size=64K]
> 	[virtual] Expansion ROM at f40c0000 [disabled] [size=256K]
> 	Capabilities: [48] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=1 PME- Capabilities: [50] Vital Product Data
> 		Product Name: HP Ethernet 1Gb 4-port 331FLR Adapter
> 		Read-only fields:
> 			[PN] Part number: 629133-002
> 			[EC] Engineering changes: A-5608
> 			[MN] Manufacture ID: 31 30 33 43
> 			[V0] Vendor specific: 5W PCIeGen2
> 			[V1] Vendor specific: 17.4.1
> 			[V3] Vendor specific: 1.46
> 			[V5] Vendor specific: 0A
> 			[V6] Vendor specific: 17.2.1
> 			[V7] Vendor specific: 331FLR
> 			[VA] Vendor specific: 17.4.41
> 			[RV] Reserved: checksum good, 219 byte(s)
> reserved End
> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
> 		Vector table: BAR=4 offset=00000000
> 		PBA: BAR=4 offset=00001000
> 	Capabilities: [ac] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0,
> Latency L0s <4us, L1 <64us ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset+ SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable- Non-Fatal+ Fatal+ Unsupported- RlxdOrd- ExtTag-
> PhantFunc- AuxPwr+ NoSnoop- FLReset- MaxPayload 256 bytes, MaxReadReq
> 4096 bytes DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+ TransPend- LnkCap:	Port #0, Speed 5GT/s, Width x4,
> ASPM L0s L1, Exit Latency L0s <1us, L1 <2us ClockPM+ Surprise-
> LLActRep- BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64
> bytes Disabled- CommClk+ ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkSta2:
> Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1- EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest- Capabilities: [100 v1] Advanced Error
> Reporting UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UEMsk:	DLP-
> SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq+ ACSViol- UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
> ChkEn- Capabilities: [13c v1] Device Serial Number
> 00-00-2c-44-fd-7e-50-9b Capabilities: [150 v1] Power Budgeting <?>
> Capabilities: [160 v1] Virtual Channel Caps:	LPEVC=0
> RefClk=100ns PATEntryBits=1 Arb:	Fixed- WRR32- WRR64- WRR128-
> Ctrl:	ArbSelect=Fixed Status:	InProgress- VC0:
> Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans- Arb:
> Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256- Ctrl:	Enable+
> ID=0 ArbSelect=Fixed TC/VC=ff Status:	NegoPending- InProgress-
> 	Kernel driver in use: tg3
> 	Kernel modules: tg3
> 
> 07:00.0 Ethernet controller: QLogic Corp. 10GbE Converged Network
> Adapter (TCP/IP Networking) (rev 02) Subsystem: QLogic Corp. Device
> 017a Physical Slot: 2
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed
> to IRQ 26 NUMA node: 0
> 	Region 0: I/O ports at 6000 [size=256]
> 	Region 1: Memory at f7ff0000 (64-bit, non-prefetchable)
> [size=16K] Region 3: Memory at f7e00000 (64-bit, non-prefetchable)
> [size=1M] [virtual] Expansion ROM at f7900000 [disabled] [size=256K]
> 	Capabilities: [44] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [4c] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 1024 bytes, PhantFunc 0,
> Latency L0s <4us, L1 <1us ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset+ SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable- Non-Fatal+ Fatal+ Unsupported- RlxdOrd+ ExtTag-
> PhantFunc- AuxPwr- NoSnoop+ FLReset- MaxPayload 256 bytes, MaxReadReq
> 4096 bytes DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+
> AuxPwr- TransPend- LnkCap:	Port #0, Speed 5GT/s, Width x8,
> ASPM L0s, Exit Latency L0s <2us, L1 <2us ClockPM- Surprise- LLActRep-
> BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64 bytes
> Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range B, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkCtl2:
> Target Link Speed: 5GT/s, EnterCompliance- SpeedDis- Transmit Margin:
> Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB LnkSta2: Current De-emphasis Level:
> -6dB, EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [88] MSI:
> Enable- Count=1/32 Maskable- 64bit+ Address: 0000000000000000  Data:
> 0000 Capabilities: [98] Vital Product Data
> 		Product Name: PCIe Dual Port 10GbE Adapter
> 		Read-only fields:
> 			[PN] Part number: QLE8142
> 			[SN] Serial number: RFE1016A10727
> 			[V0] Vendor specific: PW=11W
> 			[MN] Manufacture ID: 46 45 30 32 31 30 34 30
> 32 2d 30 37 20 20 46 [RM] Unknown: 30 32 30 30 37 31
> 			[YA] Asset tag:                 
> 			[RV] Reserved: checksum good, 0 byte(s)
> reserved End
> 	Capabilities: [a0] MSI-X: Enable+ Count=128 Masked-
> 		Vector table: BAR=1 offset=00002000
> 		PBA: BAR=1 offset=00003000
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UESvrt:	DLP- SDES+
> TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq- ACSViol- CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr+ CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- AERCap:	First Error Pointer: 00, GenCap+
> CGenEn- ChkCap+ ChkEn- Capabilities: [138 v1] Device Serial Number
> 00-c0-dd-ff-fe-14-bc-bc Capabilities: [144 v1] Power Budgeting <?>
> Kernel driver in use: qlge Kernel modules: qlge
> 
> 07:00.1 Ethernet controller: QLogic Corp. 10GbE Converged Network
> Adapter (TCP/IP Networking) (rev 02) Subsystem: QLogic Corp. Device
> 017a Physical Slot: 2
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin B routed
> to IRQ 95 NUMA node: 0
> 	Region 0: I/O ports at 6400 [size=256]
> 	Region 1: Memory at f7df0000 (64-bit, non-prefetchable)
> [size=16K] Region 3: Memory at f7c00000 (64-bit, non-prefetchable)
> [size=1M] [virtual] Expansion ROM at f7940000 [disabled] [size=256K]
> 	Capabilities: [44] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [4c] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 1024 bytes, PhantFunc 0,
> Latency L0s <4us, L1 <1us ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset+ SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable- Non-Fatal+ Fatal+ Unsupported- RlxdOrd+ ExtTag-
> PhantFunc- AuxPwr- NoSnoop+ FLReset- MaxPayload 256 bytes, MaxReadReq
> 4096 bytes DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+
> AuxPwr- TransPend- LnkCap:	Port #0, Speed 5GT/s, Width x8,
> ASPM L0s, Exit Latency L0s <2us, L1 <2us ClockPM- Surprise- LLActRep-
> BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64 bytes
> Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range B, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkSta2:
> Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1- EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest- Capabilities: [88] MSI: Enable- Count=1/32
> Maskable- 64bit+ Address: 0000000000000000  Data: 0000 Capabilities:
> [98] Vital Product Data Product Name: PCIe Dual Port 10GbE Adapter
> 		Read-only fields:
> 			[PN] Part number: QLE8142
> 			[SN] Serial number: RFE1016A10727
> 			[V0] Vendor specific: PW=11W
> 			[MN] Manufacture ID: 46 45 30 32 31 30 34 30
> 32 2d 30 37 20 20 46 [RM] Unknown: 30 32 30 30 37 31
> 			[YA] Asset tag:                 
> 			[RV] Reserved: checksum good, 0 byte(s)
> reserved End
> 	Capabilities: [a0] MSI-X: Enable+ Count=128 Masked-
> 		Vector table: BAR=1 offset=00002000
> 		PBA: BAR=1 offset=00003000
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UESvrt:	DLP- SDES+
> TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq- ACSViol- CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr+ CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- AERCap:	First Error Pointer: 00, GenCap+
> CGenEn- ChkCap+ ChkEn- Capabilities: [138 v1] Device Serial Number
> 00-c0-dd-ff-fe-14-bc-bc Capabilities: [144 v1] Power Budgeting <?>
> Kernel driver in use: qlge Kernel modules: qlge
> 
> 07:00.2 Fibre Channel: QLogic Corp. 10GbE Converged Network Adapter
> (FCoE) (rev 02) Subsystem: QLogic Corp. Device 0179
> 	Physical Slot: 2
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin C routed
> to IRQ 115 NUMA node: 0
> 	Region 0: I/O ports at 6800 [size=256]
> 	Region 1: Memory at f7bf0000 (64-bit, non-prefetchable)
> [size=16K] Region 3: Memory at f7a00000 (64-bit, non-prefetchable)
> [size=1M] [virtual] Expansion ROM at f7980000 [disabled] [size=256K]
> 	Capabilities: [44] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [4c] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 1024 bytes, PhantFunc 0,
> Latency L0s <4us, L1 <1us ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset+ SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable+ Non-Fatal+ Fatal+ Unsupported+ RlxdOrd+ ExtTag-
> PhantFunc- AuxPwr- NoSnoop+ FLReset- MaxPayload 256 bytes, MaxReadReq
> 4096 bytes DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+
> AuxPwr- TransPend- LnkCap:	Port #0, Speed 5GT/s, Width x8,
> ASPM L0s, Exit Latency L0s <2us, L1 <2us ClockPM- Surprise- LLActRep-
> BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64 bytes
> Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range B, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkSta2:
> Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1- EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest- Capabilities: [88] MSI: Enable- Count=1/32
> Maskable- 64bit+ Address: 0000000000000000  Data: 0000 Capabilities:
> [98] Vital Product Data Product Name: QLogic PCI-Express Dual Channel
> 10GbE CNA Read-only fields:
> 			[PN] Part number: QLE8142
> 			[SN] Serial number: RFE1016A10727
> 			[V0] Vendor specific: PW=11W
> 			[MN] Manufacture ID: 46 45 30 32 31 30 34 30
> 32 2d 30 37 20 20 46 [V1] Vendor specific: 03.41
> 			[V3] Vendor specific: 05.09.00
> 			[V4] Vendor specific: 03.18
> 			[V5] Vendor specific: 03.19
> 			[RM] Unknown: 30 32 30 30 37 31
> 			[YA] Asset tag:                 
> 			[RV] Reserved: checksum good, 0 byte(s)
> reserved End
> 	Capabilities: [a0] MSI-X: Enable+ Count=128 Masked-
> 		Vector table: BAR=1 offset=00002000
> 		PBA: BAR=1 offset=00003000
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UESvrt:	DLP- SDES+
> TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq- ACSViol- CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr+ CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- AERCap:	First Error Pointer: 00, GenCap+
> CGenEn- ChkCap+ ChkEn- Capabilities: [138 v1] Device Serial Number
> 00-c0-dd-ff-fe-14-bc-bc Capabilities: [144 v1] Power Budgeting <?>
> Kernel driver in use: qla2xxx Kernel modules: qla2xxx
> 
> 07:00.3 Fibre Channel: QLogic Corp. 10GbE Converged Network Adapter
> (FCoE) (rev 02) Subsystem: QLogic Corp. Device 0179
> 	Physical Slot: 2
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin D routed
> to IRQ 201 NUMA node: 0
> 	Region 0: I/O ports at 6c00 [size=256]
> 	Region 1: Memory at f79f0000 (64-bit, non-prefetchable)
> [size=16K] Region 3: Memory at f7800000 (64-bit, non-prefetchable)
> [size=1M] [virtual] Expansion ROM at f7b00000 [disabled] [size=256K]
> 	Capabilities: [44] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [4c] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 1024 bytes, PhantFunc 0,
> Latency L0s <4us, L1 <1us ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset+ SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable+ Non-Fatal+ Fatal+ Unsupported+ RlxdOrd+ ExtTag-
> PhantFunc- AuxPwr- NoSnoop+ FLReset- MaxPayload 256 bytes, MaxReadReq
> 4096 bytes DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+
> AuxPwr- TransPend- LnkCap:	Port #0, Speed 5GT/s, Width x8,
> ASPM L0s, Exit Latency L0s <2us, L1 <2us ClockPM- Surprise- LLActRep-
> BwNot- ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64 bytes
> Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range B, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkSta2:
> Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1- EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest- Capabilities: [88] MSI: Enable- Count=1/32
> Maskable- 64bit+ Address: 0000000000000000  Data: 0000 Capabilities:
> [98] Vital Product Data Product Name: QLogic PCI-Express Dual Channel
> 10GbE CNA Read-only fields:
> 			[PN] Part number: QLE8142
> 			[SN] Serial number: RFE1016A10727
> 			[V0] Vendor specific: PW=11W
> 			[MN] Manufacture ID: 46 45 30 32 31 30 34 30
> 32 2d 30 37 20 20 46 [V1] Vendor specific: 03.41
> 			[V3] Vendor specific: 05.09.00
> 			[V4] Vendor specific: 03.18
> 			[V5] Vendor specific: 03.19
> 			[RM] Unknown: 30 32 30 30 37 31
> 			[YA] Asset tag:                 
> 			[RV] Reserved: checksum good, 0 byte(s)
> reserved End
> 	Capabilities: [a0] MSI-X: Enable+ Count=128 Masked-
> 		Vector table: BAR=1 offset=00002000
> 		PBA: BAR=1 offset=00003000
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UESvrt:	DLP- SDES+
> TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq- ACSViol- CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr+ CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- AERCap:	First Error Pointer: 00, GenCap+
> CGenEn- ChkCap+ ChkEn- Capabilities: [138 v1] Device Serial Number
> 00-c0-dd-ff-fe-14-bc-bc Capabilities: [144 v1] Power Budgeting <?>
> Kernel driver in use: qla2xxx Kernel modules: qla2xxx
> 
> 1f:08.0 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:08.3 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> Reut 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Capabilities: [40] Express (v1) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE- DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- Capabilities: [100 v0] Vendor Specific
> Information: ID=0001 Rev=0 Len=0f0 <?>
> 
> 1f:08.4 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> Reut 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Capabilities: [40] Express (v1) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE- DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 1f:09.0 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> 1 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:09.3 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> Reut 1 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Capabilities: [40] Express (v1) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE- DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- Capabilities: [100 v0] Vendor Specific
> Information: ID=0001 Rev=0 Len=0f0 <?>
> 
> 1f:09.4 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> Reut 1 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Capabilities: [40] Express (v1) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE- DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 1f:0a.0 System peripheral: Intel Corporation Xeon E5/Core i7 Power
> Control Unit 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0a.1 System peripheral: Intel Corporation Xeon E5/Core i7 Power
> Control Unit 1 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0a.2 System peripheral: Intel Corporation Xeon E5/Core i7 Power
> Control Unit 2 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0a.3 System peripheral: Intel Corporation Xeon E5/Core i7 Power
> Control Unit 3 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0b.0 System peripheral: Intel Corporation Xeon E5/Core i7
> Interrupt Control Registers (rev 07) Subsystem: Hewlett-Packard
> Company Device 18a8 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
> VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap-
> 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx-
> 
> 1f:0b.3 System peripheral: Intel Corporation Xeon E5/Core i7
> Semaphore and Scratchpad Configuration Registers (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 1f:0c.0 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0c.1 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0c.2 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0c.6 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller System Address Decoder 0 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 1f:0c.7 System peripheral: Intel Corporation Xeon E5/Core i7 System
> Address Decoder (rev 07) Subsystem: Hewlett-Packard Company Device
> 18a8 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0d.0 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0d.1 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0d.2 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:0d.6 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller System Address Decoder 1 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 1f:0e.0 System peripheral: Intel Corporation Xeon E5/Core i7
> Processor Home Agent (rev 07) Subsystem: Hewlett-Packard Company
> Device 18a8 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
> VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap-
> 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx-
> 
> 1f:0e.1 Performance counters: Intel Corporation Xeon E5/Core i7
> Processor Home Agent Performance Monitoring (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Kernel driver in use:
> >snbep_uncore
> 
> 1f:0f.0 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Registers (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 1f:0f.1 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller RAS Registers (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 1f:0f.2 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Target Address Decoder 0 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend-
> 
> 1f:0f.3 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Target Address Decoder 1 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend-
> 
> 1f:0f.4 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Target Address Decoder 2 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend-
> 
> 1f:0f.5 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Target Address Decoder 3 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend-
> 
> 1f:0f.6 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Target Address Decoder 4 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 1f:10.0 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Channel 0-3 Thermal Control 0 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend- Kernel driver in use:
> snbep_uncore
> 
> 1f:10.1 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Channel 0-3 Thermal Control 1 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend- Kernel driver in use:
> snbep_uncore
> 
> 1f:10.2 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller ERROR Registers 0 (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 1f:10.3 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller ERROR Registers 1 (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 1f:10.4 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Channel 0-3 Thermal Control 2 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend- Kernel driver in use:
> snbep_uncore
> 
> 1f:10.5 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Channel 0-3 Thermal Control 3 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend- Kernel driver in use:
> snbep_uncore
> 
> 1f:10.6 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller ERROR Registers 2 (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 1f:10.7 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller ERROR Registers 3 (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 1f:11.0 System peripheral: Intel Corporation Xeon E5/Core i7 DDRIO
> (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:13.0 System peripheral: Intel Corporation Xeon E5/Core i7 R2PCIe
> (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 1f:13.1 Performance counters: Intel Corporation Xeon E5/Core i7 Ring
> to PCI Express Performance Monitor (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Kernel driver in use:
> >snbep_uncore
> 
> 1f:13.4 Performance counters: Intel Corporation Xeon E5/Core i7
> QuickPath Interconnect Agent Ring Registers (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 1f:13.5 Performance counters: Intel Corporation Xeon E5/Core i7 Ring
> to QuickPath Interconnect Link 0 Performance Monitor (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Kernel
> driver in use: snbep_uncore
> 
> 1f:13.6 System peripheral: Intel Corporation Xeon E5/Core i7 Ring to
> QuickPath Interconnect Link 1 Performance Monitor (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Kernel driver in use:
> >snbep_uncore
> 
> 20:00.0 PCI bridge: Intel Corporation Xeon E5/Core i7 DMI2 in PCI
> Express Mode (rev 07) (prog-if 00 [Normal decode]) Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Interrupt:
> pin A routed to IRQ 25 NUMA node: 1 Bus: primary=20, secondary=31,
> subordinate=31, sec-latency=0 I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 2.5GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible- RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd- DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis+, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 5GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [280 v1] Vendor Specific Information:
> ID=0004 Rev=2 Len=018 <?> Kernel driver in use: pcieport
> 
> 20:01.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 1a (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 25 NUMA
> node: 1 Bus: primary=20, secondary=2a, subordinate=2a, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 20:01.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 1b (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 25 NUMA
> node: 1 Bus: primary=20, secondary=2b, subordinate=2b, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 20:02.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 2a (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 25 NUMA
> node: 1 Bus: primary=20, secondary=27, subordinate=27, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #16, Speed 8GT/s,
> Width x8, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 20:02.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 2b (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 25 NUMA
> node: 1 Bus: primary=20, secondary=2c, subordinate=2c, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 20:02.2 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 2c (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 25 NUMA
> node: 1 Bus: primary=20, secondary=24, subordinate=24, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fbe00000-fbffffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #18, Speed 8GT/s,
> Width x8, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot- ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 5GT/s, Width x8, TrErr- Train-
> SlotClk+ DLActive+ BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd+ LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 20:02.3 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 2d (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 25 NUMA
> node: 1 Bus: primary=20, secondary=2d, subordinate=2d, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot- ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 20:03.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 3a in PCI Express Mode (rev 07) (prog-if 00 [Normal
> decode]) Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed
> to IRQ 25 NUMA node: 1 Bus: primary=20, secondary=21, subordinate=21,
> sec-latency=0 I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag+ RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #24, Speed 8GT/s,
> Width x16, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 20:03.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 3b (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 25 NUMA
> node: 1 Bus: primary=20, secondary=2e, subordinate=2e, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot+ ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 20:03.2 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 3c (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 25 NUMA
> node: 1 Bus: primary=20, secondary=2f, subordinate=2f, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot- ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 20:03.3 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express
> Root Port 3d (rev 07) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
> BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency:
> 0, Cache Line Size: 64 bytes Interrupt: pin A routed to IRQ 25 NUMA
> node: 1 Bus: primary=20, secondary=30, subordinate=30, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff Secondary status: 66MHz- FastB2B-
> ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn- Capabilities:
> [40] Subsystem: Hewlett-Packard Company Device 18a8 Capabilities:
> [60] MSI: Enable- Count=1/2 Maskable+ 64bit- Address: 00000000  Data:
> 0000 Masking: 00000000  Pending: 00000000
> 	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- LnkCap:	Port #0, Speed 8GT/s,
> Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <16us ClockPM-
> Surprise+ LLActRep+ BwNot- ASPMOptComp+ LnkCtl:	ASPM Disabled;
> RCB 64 bytes Disabled- CommClk- ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt- LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- RootCtl: ErrCorrectable-
> ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible+ RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BCD, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+ DevCtl2: Completion Timeout: 50us to
> 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd- LnkCtl2: Target Link
> Speed: 8GT/s, EnterCompliance- SpeedDis- Transmit Margin: Normal
> Operating Range, EnterModifiedCompliance- ComplianceSOS- Compliance
> De-emphasis: -6dB LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [e0]
> Power Management version 3 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D3 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Capabilities: [100 v1] Vendor Specific
> Information: ID=0002 Rev=0 Len=00c <?> Capabilities: [110 v1] Access
> Control Services ACSCap:	SrcValid+ TransBlk+ ReqRedir+
> CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans- ACSCtl:
> SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans- Capabilities: [148 v1] Advanced Error Reporting
> UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- UEMsk:	DLP- SDES- TLP-
> FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+
> ACSViol- UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol- CESta:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr- CEMsk:
> RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn- Capabilities: [1d0 v1] Vendor Specific Information: ID=0003
> Rev=1 Len=00a <?> Capabilities: [250 v1] #19 Capabilities: [280 v1]
> Vendor Specific Information: ID=0004 Rev=2 Len=018 <?> Kernel driver
> in use: pcieport
> 
> 20:04.0 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed
> to IRQ 278 NUMA node: 1
> 	Region 0: Memory at fbdf0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 20:04.1 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 1 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin B routed
> to IRQ 280 NUMA node: 1
> 	Region 0: Memory at fbde0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 20:04.2 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 2 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin C routed
> to IRQ 278 NUMA node: 1
> 	Region 0: Memory at fbdd0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 20:04.3 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 3 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin D routed
> to IRQ 280 NUMA node: 1
> 	Region 0: Memory at fbdc0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 20:04.4 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 4 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed
> to IRQ 278 NUMA node: 1
> 	Region 0: Memory at fbdb0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 20:04.5 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 5 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin B routed
> to IRQ 280 NUMA node: 1
> 	Region 0: Memory at fbda0000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 20:04.6 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 6 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin C routed
> to IRQ 278 NUMA node: 1
> 	Region 0: Memory at fbd90000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 20:04.7 System peripheral: Intel Corporation Xeon E5/Core i7 DMA
> Channel 7 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin D routed
> to IRQ 280 NUMA node: 1
> 	Region 0: Memory at fbd80000 (64-bit, non-prefetchable)
> [size=16K] Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [90] Express (v2) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled Capabilities:
> [e0] Power Management version 3 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+
> PME-Enable- DSel=0 DScale=0 PME- Kernel driver in use: ioatdma
> 	Kernel modules: ioatdma
> 
> 20:05.0 System peripheral: Intel Corporation Xeon E5/Core i7 Address
> Map, VTd_Misc, System Management (rev 07) Subsystem: Hewlett-Packard
> Company Device 18a8 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
> VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+
> 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx- NUMA node: 1 Capabilities: [40] Express (v2) Root
> >Complex Integrated Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis-, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> 
> 20:05.2 System peripheral: Intel Corporation Xeon E5/Core i7 Control
> Status and Global Errors (rev 07) Subsystem: Hewlett-Packard Company
> Device 18a8 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
> VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+
> 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx- NUMA node: 1 Capabilities: [40] Express (v2) Root
> >Complex Integrated Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal+
> Fatal+ Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr+ UncorrErr+ FatalErr+
> UnsuppReq- AuxPwr- TransPend- DevCap2: Completion Timeout: Not
> Supported, TimeoutDis-, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> 
> 20:05.4 PIC: Intel Corporation Xeon E5/Core i7 I/O APIC (rev 07)
> (prog-if 20 [IO(X)-APIC]) Subsystem: Hewlett-Packard Company Device
> 18a8 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes NUMA node: 1
> 	Region 0: Memory at fbd70000 (32-bit, non-prefetchable)
> [size=4K] Capabilities: [6c] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME-
> 
> 24:00.0 Ethernet controller: Cavium QLogic BR-1860 Fabric Adapter
> (rev 01) Subsystem: Cavium QLogic 10Gbps CNA - LL
> 	Physical Slot: 5
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed
> to IRQ 96 NUMA node: 1
> 	Region 0: Memory at fbfc0000 (64-bit, non-prefetchable)
> [size=256K] Region 2: Memory at fbfb0000 (64-bit, non-prefetchable)
> [size=64K] Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=1 PME- Capabilities: [50] MSI-X: Enable+ Count=64
> Masked- Vector table: BAR=2 offset=00000000
> 		PBA: BAR=2 offset=00008000
> 	Capabilities: [60] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 2048 bytes, PhantFunc 0,
> Latency L0s <256ns, L1 <64us ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset- SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable- Non-Fatal+ Fatal+ Unsupported- RlxdOrd+ ExtTag-
> PhantFunc- AuxPwr- NoSnoop+ MaxPayload 256 bytes, MaxReadReq 4096
> bytes DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
> TransPend- LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s,
> Exit Latency L0s <256ns, L1 <64us ClockPM- Surprise- LLActRep- BwNot-
> ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled-
> CommClk- ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range ABC, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkCtl2:
> Target Link Speed: 5GT/s, EnterCompliance- SpeedDis- Transmit Margin:
> Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB LnkSta2: Current De-emphasis Level:
> -6dB, EqualizationComplete-, EqualizationPhase1- EqualizationPhase2-,
> EqualizationPhase3-, LinkEqualizationRequest- Capabilities: [a0]
> Vital Product Data pcilib: sysfs_read_vpd: read failed: Input/output
> error Not readable
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UESvrt:	DLP- SDES+
> TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq- ACSViol- CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr+ CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- AERCap:	First Error Pointer: 00, GenCap+
> CGenEn- ChkCap+ ChkEn- Capabilities: [140 v1] Virtual Channel
> Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1 Arb:	Fixed-
> WRR32- WRR64- WRR128- Ctrl:	ArbSelect=Fixed Status:
> InProgress- VC0:	Caps:	PATOffset=00 MaxTimeSlots=1
> RejSnoopTrans- Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128-
> WRR256- Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 	Capabilities: [180 v1] Power Budgeting <?>
> 	Capabilities: [190 v1] Alternative Routing-ID Interpretation
> (ARI) ARICap:	MFVC- ACS-, Next Function: 1
> 		ARICtl:	MFVC- ACS-, Function Group: 0
> 	Capabilities: [1a0 v1] Single Root I/O Virtualization (SR-IOV)
> 		IOVCap:	Migration-, Interrupt Message Number:
> 000 IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
> 		IOVSta:	Migration-
> 		Initial VFs: 4, Total VFs: 4, Number of VFs: 0,
> Function Dependency Link: 00 VF offset: 8, stride: 1, Device ID: 0022
> 		Supported Page Size: 00000553, System Page Size:
> 00000001 Region 0: Memory at 00000000fbf70000 (64-bit,
> non-prefetchable) Region 2: Memory at 00000000fbf30000 (64-bit,
> non-prefetchable) VF Migration: offset: 00000000, BIR: 0
> 	Capabilities: [270 v1] Device Serial Number
> 00-25-2b-ff-7c-8c-00-10 Capabilities: [280 v1] Address Translation
> Service (ATS) ATSCap:	Invalidate Queue Depth: 04
> 		ATSCtl:	Enable+, Smallest Translation Unit: 00
> 	Kernel driver in use: bna
> 	Kernel modules: bna
> 
> 24:00.1 Ethernet controller: Cavium QLogic BR-1860 Fabric Adapter
> (rev 01) Subsystem: Cavium QLogic 10Gbps CNA - LL
> 	Physical Slot: 5
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 64 bytes Interrupt: pin A routed
> to IRQ 96 NUMA node: 1
> 	Region 0: Memory at fbec0000 (64-bit, non-prefetchable)
> [size=256K] Region 2: Memory at fbeb0000 (64-bit, non-prefetchable)
> [size=64K] Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=1 PME- Capabilities: [50] MSI-X: Enable+ Count=64
> Masked- Vector table: BAR=2 offset=00000000
> 		PBA: BAR=2 offset=00008000
> 	Capabilities: [60] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 2048 bytes, PhantFunc 0,
> Latency L0s <256ns, L1 <64us ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset- SlotPowerLimit 0.000W DevCtl:	Report errors:
> Correctable- Non-Fatal+ Fatal+ Unsupported- RlxdOrd+ ExtTag-
> PhantFunc- AuxPwr- NoSnoop+ MaxPayload 256 bytes, MaxReadReq 4096
> bytes DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
> TransPend- LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s,
> Exit Latency L0s <256ns, L1 <64us ClockPM- Surprise- LLActRep- BwNot-
> ASPMOptComp- LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled-
> CommClk- ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt- DevCap2: Completion Timeout:
> Range ABC, TimeoutDis+, LTR-, OBFF Not Supported DevCtl2: Completion
> Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled LnkSta2:
> Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1- EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest- Capabilities: [a0] Vital Product Data
> pcilib: sysfs_read_vpd: read failed: Input/output error Not readable
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO-
> CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol- UESvrt:	DLP- SDES+
> TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-
> UnsupReq- ACSViol- CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr+ CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr- AERCap:	First Error Pointer: 00, GenCap+
> CGenEn- ChkCap+ ChkEn- Capabilities: [180 v1] Power Budgeting <?>
> Capabilities: [190 v1] Alternative Routing-ID Interpretation (ARI)
> ARICap:	MFVC- ACS-, Next Function: 2 ARICtl:	MFVC-
> ACS-, Function Group: 0 Capabilities: [1a0 v1] Single Root I/O
> Virtualization (SR-IOV) IOVCap:	Migration-, Interrupt Message
> Number: 000 IOVCtl:	Enable- Migration- Interrupt- MSE-
> ARIHierarchy- IOVSta:	Migration- Initial VFs: 4, Total VFs: 4,
> Number of VFs: 0, Function Dependency Link: 01 VF offset: 11, stride:
> 1, Device ID: 0022 Supported Page Size: 00000553, System Page Size:
> 00000001 Region 0: Memory at 00000000fbe70000 (64-bit,
> non-prefetchable) Region 2: Memory at 00000000fbe30000 (64-bit,
> non-prefetchable) VF Migration: offset: 00000000, BIR: 0
> 	Capabilities: [270 v1] Device Serial Number
> 00-25-2b-ff-7c-8c-00-10 Capabilities: [280 v1] Address Translation
> Service (ATS) ATSCap:	Invalidate Queue Depth: 04
> 		ATSCtl:	Enable+, Smallest Translation Unit: 00
> 	Kernel driver in use: bna
> 	Kernel modules: bna
> 
> 3f:08.0 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:08.3 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> Reut 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Capabilities: [40] Express (v1) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE- DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- Capabilities: [100 v0] Vendor Specific
> Information: ID=0001 Rev=0 Len=0f0 <?>
> 
> 3f:08.4 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> Reut 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Capabilities: [40] Express (v1) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE- DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 3f:09.0 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> 1 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:09.3 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> Reut 1 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Capabilities: [40] Express (v1) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE- DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend- Capabilities: [100 v0] Vendor Specific
> Information: ID=0001 Rev=0 Len=0f0 <?>
> 
> 3f:09.4 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link
> Reut 1 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Capabilities: [40] Express (v1) Root Complex Integrated
> Endpoint, MSI 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE- DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 3f:0a.0 System peripheral: Intel Corporation Xeon E5/Core i7 Power
> Control Unit 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0a.1 System peripheral: Intel Corporation Xeon E5/Core i7 Power
> Control Unit 1 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0a.2 System peripheral: Intel Corporation Xeon E5/Core i7 Power
> Control Unit 2 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0a.3 System peripheral: Intel Corporation Xeon E5/Core i7 Power
> Control Unit 3 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0b.0 System peripheral: Intel Corporation Xeon E5/Core i7
> Interrupt Control Registers (rev 07) Subsystem: Hewlett-Packard
> Company Device 18a8 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
> VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap-
> 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx-
> 
> 3f:0b.3 System peripheral: Intel Corporation Xeon E5/Core i7
> Semaphore and Scratchpad Configuration Registers (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 3f:0c.0 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0c.1 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0c.2 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0c.6 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller System Address Decoder 0 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 3f:0c.7 System peripheral: Intel Corporation Xeon E5/Core i7 System
> Address Decoder (rev 07) Subsystem: Hewlett-Packard Company Device
> 18a8 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0d.0 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0d.1 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0d.2 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast
> Register 0 (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:0d.6 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller System Address Decoder 1 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 3f:0e.0 System peripheral: Intel Corporation Xeon E5/Core i7
> Processor Home Agent (rev 07) Subsystem: Hewlett-Packard Company
> Device 18a8 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
> VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap-
> 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
> >SERR- <PERR- INTx-
> 
> 3f:0e.1 Performance counters: Intel Corporation Xeon E5/Core i7
> Processor Home Agent Performance Monitoring (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Kernel driver in use:
> >snbep_uncore
> 
> 3f:0f.0 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Registers (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 3f:0f.1 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller RAS Registers (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 3f:0f.2 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Target Address Decoder 0 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend-
> 
> 3f:0f.3 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Target Address Decoder 1 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend-
> 
> 3f:0f.4 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Target Address Decoder 2 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend-
> 
> 3f:0f.5 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Target Address Decoder 3 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend-
> 
> 3f:0f.6 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Target Address Decoder 4 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 3f:10.0 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Channel 0-3 Thermal Control 0 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend- Kernel driver in use:
> snbep_uncore
> 
> 3f:10.1 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Channel 0-3 Thermal Control 1 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend- Kernel driver in use:
> snbep_uncore
> 
> 3f:10.2 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller ERROR Registers 0 (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 3f:10.3 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller ERROR Registers 1 (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 3f:10.4 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Channel 0-3 Thermal Control 2 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend- Kernel driver in use:
> snbep_uncore
> 
> 3f:10.5 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller Channel 0-3 Thermal Control 3 (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI
> 00 DevCap:	MaxPayload 128 bytes, PhantFunc 0 ExtTag- RBE-
> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- MaxPayload
> 128 bytes, MaxReadReq 128 bytes DevSta:	CorrErr- UncorrErr-
> FatalErr- UnsuppReq- AuxPwr- TransPend- Kernel driver in use:
> snbep_uncore
> 
> 3f:10.6 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller ERROR Registers 2 (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 3f:10.7 System peripheral: Intel Corporation Xeon E5/Core i7
> Integrated Memory Controller ERROR Registers 3 (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Capabilities: [40]
> >Express (v1) Root Complex Integrated Endpoint, MSI 00 DevCap:
> >MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported- RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr-
> UnsuppReq- AuxPwr- TransPend-
> 
> 3f:11.0 System peripheral: Intel Corporation Xeon E5/Core i7 DDRIO
> (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:13.0 System peripheral: Intel Corporation Xeon E5/Core i7 R2PCIe
> (rev 07) Subsystem: Hewlett-Packard Company Device 18a8
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx- Status: Cap- 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx-
> 
> 3f:13.1 Performance counters: Intel Corporation Xeon E5/Core i7 Ring
> to PCI Express Performance Monitor (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Kernel driver in use:
> >snbep_uncore
> 
> 3f:13.4 Performance counters: Intel Corporation Xeon E5/Core i7
> QuickPath Interconnect Agent Ring Registers (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 3f:13.5 Performance counters: Intel Corporation Xeon E5/Core i7 Ring
> to QuickPath Interconnect Link 0 Performance Monitor (rev 07)
> Subsystem: Hewlett-Packard Company Device 18a8 Control: I/O- Mem-
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Kernel
> driver in use: snbep_uncore
> 
> 3f:13.6 System peripheral: Intel Corporation Xeon E5/Core i7 Ring to
> QuickPath Interconnect Link 1 Performance Monitor (rev 07) Subsystem:
> Hewlett-Packard Company Device 18a8 Control: I/O- Mem- BusMaster-
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Kernel driver in use:
> >snbep_uncore

[Jacob Pan]
