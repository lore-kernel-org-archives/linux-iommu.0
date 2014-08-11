From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Mon, 11 Aug 2014 12:56:10 +0800
Message-ID: <53E84CEA.7080402@linux.intel.com>
References: <1407725674-27271-1-git-send-email-wangyijing@huawei.com>
	<53E8355C.4010906@linux.intel.com> <53E83C9E.9060405@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53E83C9E.9060405-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Yijing,
	These devices don't support Phantom Function (PhantFunc 0).
Could you please help to provide full dmesg, /proc/iomem, and ACPI
DMAR table? You may get DMAR table by:
acpidump > acpi.bin
acpixtract -a acpib.bin
iasl -d DMAR.dat
Thanks!
Gerry

On 2014/8/11 11:46, Yijing Wang wrote:
> On 2014/8/11 11:15, Jiang Liu wrote:
>> Hi Yijing,
>> 	Could you please help to provide detail information about the
>> PCI device, such as "lscpi -vvv"? It seems like that "Phantom
>> Functions" is enabled with these PCI devices.
>> Thanks!
>> Gerry
> 
> My pleasure!
> 
> Gerry, the lspci info is below:
> 
> HP C7000 Server:  The problem devices id: 04:00.4 04:00.5 04:00.6 04:00.7
> 
> 04:00.0 Ethernet controller: Emulex Corporation OneConnect 10Gb NIC (be3) (rev 01)
> 	Subsystem: Hewlett-Packard Company Device 337b
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 32
> 	Region 0: Memory at ebff0000 (64-bit, non-prefetchable) [size=16K]
> 	Region 2: Memory at ebfc0000 (64-bit, non-prefetchable) [size=128K]
> 	Region 4: Memory at ebfa0000 (64-bit, non-prefetchable) [size=128K]
> 	[virtual] Expansion ROM at dc000000 [disabled] [size=256K]
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [48] MSI-X: Enable+ Count=32 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [c0] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <16us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> 		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
> 			MaxPayload 256 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L1 <16us
> 			ClockPM- Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [b8] Vital Product Data
> 		Product Name: 647586-B21, NIC PF
> 		Read-only fields:
> 			[PN] Part number: 647584-001
> 			[SN] Serial number: H3534360ZX
> 			[V0] Vendor specific: VA00000000
> 			[EC] Engineering changes: A-5120
> 			[FN] Unknown: 36 34 39 39 34 30 2d 30 30 31 0d
> 			[VA] Vendor specific: 649940-001\x0d
> 			[VB] Vendor specific: PW=10W; PCIE X8 GEN 2
> 			[V1] Vendor specific: HP FlexFabric 10Gb 2-port 554FLB Adapter
> 			[V2] Vendor specific: 554FLB
> 			[V4] Vendor specific: 0
> 			[V5] Vendor specific: OCl11102-F4-HP
> 			[V6] Vendor specific: A0:1,D0:1
> 			[RV] Reserved: checksum good, 42 byte(s) reserved
> 		End
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP- ECRC- UnsupReq+ ACSViol-
> 		UESvrt:	DLP- SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
> 		IOVCap:	Migration-, Interrupt Message Number: 000
> 		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
> 		IOVSta:	Migration-
> 		Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 00
> 		VF offset: 0, stride: 1, Device ID: 0710
> 		Supported Page Size: 00000557, System Page Size: 00000001
> 		Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
> 		VF Migration: offset: 00000000, BIR: 0
> 	Capabilities: [160 v1] Alternative Routing-ID Interpretation (ARI)
> 		ARICap:	MFVC- ACS-, Next Function: 1
> 		ARICtl:	MFVC- ACS-, Function Group: 0
> 	Capabilities: [168 v1] Device Serial Number f0-92-1c-ff-fe-16-8d-48
> 	Capabilities: [12c v1] Transaction Processing Hints
> 		No steering table available
> 	Kernel driver in use: be2net
> 	Kernel modules: be2net
> 
> 04:00.1 Ethernet controller: Emulex Corporation OneConnect 10Gb NIC (be3) (rev 01)
> 	Subsystem: Hewlett-Packard Company Device 337b
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin B routed to IRQ 36
> 	Region 0: Memory at ebf90000 (64-bit, non-prefetchable) [size=16K]
> 	Region 2: Memory at ebf60000 (64-bit, non-prefetchable) [size=128K]
> 	Region 4: Memory at ebf40000 (64-bit, non-prefetchable) [size=128K]
> 	[virtual] Expansion ROM at dc040000 [disabled] [size=256K]
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [48] MSI-X: Enable+ Count=32 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [c0] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <16us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> 		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
> 			MaxPayload 256 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L1 <16us
> 			ClockPM- Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [b8] Vital Product Data
> 		Product Name: 647586-B21, NIC PF
> 		Read-only fields:
> 			[PN] Part number: 647584-001
> 			[SN] Serial number: H3534360ZX
> 			[V0] Vendor specific: VA00000000
> 			[EC] Engineering changes: A-5120
> 			[FN] Unknown: 36 34 39 39 34 30 2d 30 30 31 0d
> 			[VA] Vendor specific: 649940-001\x0d
> 			[VB] Vendor specific: PW=10W; PCIE X8 GEN 2
> 			[V1] Vendor specific: HP FlexFabric 10Gb 2-port 554FLB Adapter
> 			[V2] Vendor specific: 554FLB
> 			[V4] Vendor specific: 1
> 			[V5] Vendor specific: OCl11102-F4-HP
> 			[V6] Vendor specific: A0:1,D0:1
> 			[RV] Reserved: checksum good, 42 byte(s) reserved
> 		End
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP- ECRC- UnsupReq+ ACSViol-
> 		UESvrt:	DLP- SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
> 		IOVCap:	Migration-, Interrupt Message Number: 000
> 		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
> 		IOVSta:	Migration-
> 		Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 01
> 		VF offset: 0, stride: 1, Device ID: 0710
> 		Supported Page Size: 00000557, System Page Size: 00000001
> 		Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
> 		VF Migration: offset: 00000000, BIR: 0
> 	Capabilities: [160 v1] Alternative Routing-ID Interpretation (ARI)
> 		ARICap:	MFVC- ACS-, Next Function: 2
> 		ARICtl:	MFVC- ACS-, Function Group: 0
> 	Capabilities: [168 v1] Device Serial Number f0-92-1c-ff-fe-16-8d-48
> 	Capabilities: [12c v1] Transaction Processing Hints
> 		No steering table available
> 	Kernel driver in use: be2net
> 	Kernel modules: be2net
> 
> 04:00.2 Mass storage controller: Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3) (rev 01)
> 	Subsystem: Hewlett-Packard Company Device 337b
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin C routed to IRQ 37
> 	Region 0: Memory at ebf30000 (64-bit, non-prefetchable) [size=16K]
> 	Region 2: Memory at ebf00000 (64-bit, non-prefetchable) [size=128K]
> 	Region 4: Memory at ebee0000 (64-bit, non-prefetchable) [size=128K]
> 	[virtual] Expansion ROM at dc080000 [disabled] [size=256K]
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [48] MSI-X: Enable- Count=8 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [c0] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <16us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
> 			MaxPayload 256 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L1 <16us
> 			ClockPM- Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [b8] Vital Product Data
> 		Product Name: 647586-B21, iSCSI PF
> 		Read-only fields:
> 			[PN] Part number: 647584-001
> 			[SN] Serial number: H3534360ZX
> 			[V0] Vendor specific: VA00000000
> 			[EC] Engineering changes: A-5120
> 			[FN] Unknown: 36 34 39 39 34 30 2d 30 30 31 0d
> 			[VA] Vendor specific: 649940-001\x0d
> 			[VB] Vendor specific: PW=10W; PCIE X8 GEN 2
> 			[V1] Vendor specific: HP FlexFabric 10Gb 2-port 554FLB Adapter
> 			[V2] Vendor specific: 554FLB
> 			[V4] Vendor specific: 0
> 			[V5] Vendor specific: OCl11102-F4-HP
> 			[V6] Vendor specific: A0:1,D0:1
> 			[RV] Reserved: checksum good, 40 byte(s) reserved
> 		End
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP- ECRC- UnsupReq+ ACSViol-
> 		UESvrt:	DLP- SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
> 		IOVCap:	Migration-, Interrupt Message Number: 000
> 		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
> 		IOVSta:	Migration-
> 		Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 02
> 		VF offset: 0, stride: 1, Device ID: 0712
> 		Supported Page Size: 00000557, System Page Size: 00000001
> 		Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
> 		VF Migration: offset: 00000000, BIR: 0
> 	Capabilities: [160 v1] Alternative Routing-ID Interpretation (ARI)
> 		ARICap:	MFVC- ACS-, Next Function: 3
> 		ARICtl:	MFVC- ACS-, Function Group: 0
> 	Capabilities: [168 v1] Device Serial Number f0-92-1c-ff-fe-16-8d-48
> 	Capabilities: [12c v1] Transaction Processing Hints
> 		No steering table available
> 	Kernel driver in use: be2iscsi
> 	Kernel modules: be2iscsi
> 
> 04:00.3 Mass storage controller: Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3) (rev 01)
> 	Subsystem: Hewlett-Packard Company Device 337b
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin D routed to IRQ 38
> 	Region 0: Memory at ebed0000 (64-bit, non-prefetchable) [size=16K]
> 	Region 2: Memory at ebea0000 (64-bit, non-prefetchable) [size=128K]
> 	Region 4: Memory at ebe80000 (64-bit, non-prefetchable) [size=128K]
> 	[virtual] Expansion ROM at dc0c0000 [disabled] [size=256K]
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [48] MSI-X: Enable- Count=8 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	Capabilities: [c0] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <16us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> 		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
> 			MaxPayload 256 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L1 <16us
> 			ClockPM- Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [b8] Vital Product Data
> 		Product Name: 647586-B21, iSCSI PF
> 		Read-only fields:
> 			[PN] Part number: 647584-001
> 			[SN] Serial number: H3534360ZX
> 			[V0] Vendor specific: VA00000000
> 			[EC] Engineering changes: A-5120
> 			[FN] Unknown: 36 34 39 39 34 30 2d 30 30 31 0d
> 			[VA] Vendor specific: 649940-001\x0d
> 			[VB] Vendor specific: PW=10W; PCIE X8 GEN 2
> 			[V1] Vendor specific: HP FlexFabric 10Gb 2-port 554FLB Adapter
> 			[V2] Vendor specific: 554FLB
> 			[V4] Vendor specific: 1
> 			[V5] Vendor specific: OCl11102-F4-HP
> 			[V6] Vendor specific: A0:1,D0:1
> 			[RV] Reserved: checksum good, 40 byte(s) reserved
> 		End
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP- ECRC- UnsupReq+ ACSViol-
> 		UESvrt:	DLP- SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
> 		IOVCap:	Migration-, Interrupt Message Number: 000
> 		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
> 		IOVSta:	Migration-
> 		Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 03
> 		VF offset: 0, stride: 1, Device ID: 0712
> 		Supported Page Size: 00000557, System Page Size: 00000001
> 		Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
> 		VF Migration: offset: 00000000, BIR: 0
> 	Capabilities: [160 v1] Alternative Routing-ID Interpretation (ARI)
> 		ARICap:	MFVC- ACS-, Next Function: 0
> 		ARICtl:	MFVC- ACS-, Function Group: 0
> 	Capabilities: [168 v1] Device Serial Number f0-92-1c-ff-fe-16-8d-48
> 	Capabilities: [12c v1] Transaction Processing Hints
> 		No steering table available
> 	Kernel driver in use: be2iscsi
> 	Kernel modules: be2iscsi
> 
> Huawei Storage Server: devices id: 03:07.1 03:07.2 03:07.3
> 
> 03:00.0 Bridge: PLX Technology, Inc. Device 8725 (rev ca)
> 	Subsystem: PLX Technology, Inc. Device 87b0
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 94
> 	Region 0: Memory at 94100000 (32-bit, non-prefetchable) [size=256K]
> 	Region 2: Memory at 180000000000 (64-bit, prefetchable) [size=4T]
> 	Region 4: Memory at 90000000 (32-bit, non-prefetchable) [size=64M]
> 	Region 5: Memory at 94000000 (32-bit, non-prefetchable) [size=1M]
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
> 		Address: 00000000fee00000  Data: 4063
> 		Masking: 000000fe  Pending: 00000000
> 	Capabilities: [68] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 256 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> 		LnkCap:	Port #1, Speed 8GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L1 <4us
> 			ClockPM- Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [c8] Vendor Specific Information: Len=00 <?>
> 	Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
> 	Capabilities: [fb4 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [148 v1] Virtual Channel
> 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=Fixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 	Capabilities: [c34 v1] Vendor Specific Information: ID=0003 Rev=0 Len=078 <?>
> 	Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 Len=010 <?>
> 
> Thanks!
> Yijing.
> 
> 
>>
>> On 2014/8/11 10:54, Yijing Wang wrote:
>>> We found some strange devices in HP C7000 and Huawei Server. These devices
>>> can not be enumerated by OS, but they still did DMA read/write without OS 
>>> management. Because iommu will not create the DMA mapping for these devices,
>>> the DMA read/write will be blocked by iommu hardware.
>>>
>>> Eg.
>>>  \-[0000:00]-+-00.0  Intel Corporation Xeon E5/Core i7 DMI2
>>>              +-01.0-[11]--
>>> 			 +-01.1-[02]--
>>> 			 +-02.0-[04]--+-00.0  Emulex Corporation OneConnect 10Gb NIC (be3)
>>> 	         |            +-00.1  Emulex Corporation OneConnect 10Gb NIC (be3)
>>> 	         |            +-00.2  Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3)
>>> 	         |            \-00.3  Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3)
>>> 	         +-02.1-[12]--
>>> Kernel only found four devices in bus 0x04, but we found following DMA errors in dmesg.
>>>
>>> [ 1438.477262] DRHD: handling fault status reg 402
>>> [ 1438.498278] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70000 
>>> [ 1438.498280] DMAR:[fault reason 02] Present bit in context entry is clear
>>> [ 1438.566458] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70000 
>>> [ 1438.566460] DMAR:[fault reason 02] Present bit in context entry is clear
>>> [ 1438.635211] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70000 
>>> [ 1438.635213] DMAR:[fault reason 02] Present bit in context entry is clear
>>> [ 1438.703849] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70000 
>>> [ 1438.703851] DMAR:[fault reason 02] Present bit in context entry is clear
>>>
>>> Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  arch/x86/include/asm/iommu.h |    2 ++
>>>  arch/x86/kernel/pci-dma.c    |    8 ++++++++
>>>  drivers/iommu/intel-iommu.c  |   41 +++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 51 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
>>> index 345c99c..5e3a2d8 100644
>>> --- a/arch/x86/include/asm/iommu.h
>>> +++ b/arch/x86/include/asm/iommu.h
>>> @@ -5,6 +5,8 @@ extern struct dma_map_ops nommu_dma_ops;
>>>  extern int force_iommu, no_iommu;
>>>  extern int iommu_detected;
>>>  extern int iommu_pass_through;
>>> +extern int iommu_pt_force_bus;
>>> +extern int iommu_pt_force_domain;
>>>  
>>>  /* 10 seconds */
>>>  #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
>>> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
>>> index a25e202..bf21d97 100644
>>> --- a/arch/x86/kernel/pci-dma.c
>>> +++ b/arch/x86/kernel/pci-dma.c
>>> @@ -44,6 +44,8 @@ int iommu_detected __read_mostly = 0;
>>>   * guests and not for driver dma translation.
>>>   */
>>>  int iommu_pass_through __read_mostly;
>>> +int iommu_pt_force_bus = -1;
>>> +int iommu_pt_force_domain = -1;
>>>  
>>>  extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
>>>  
>>> @@ -146,6 +148,7 @@ void dma_generic_free_coherent(struct device *dev, size_t size, void *vaddr,
>>>   */
>>>  static __init int iommu_setup(char *p)
>>>  {
>>> +	char *end;
>>>  	iommu_merge = 1;
>>>  
>>>  	if (!p)
>>> @@ -192,6 +195,11 @@ static __init int iommu_setup(char *p)
>>>  #endif
>>>  		if (!strncmp(p, "pt", 2))
>>>  			iommu_pass_through = 1;
>>> +		if (!strncmp(p, "pt_force=", 9)) {
>>> +			iommu_pass_through = 1;
>>> +			iommu_pt_force_domain = simple_strtol(p+9, &end, 0);
>>> +			iommu_pt_force_bus = simple_strtol(end+1, NULL, 0);
>>> +		}
>>>  
>>>  		gart_parse_options(p);
>>>  
>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>> index d1f5caa..49757f1 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -2705,6 +2705,47 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
>>>  				return ret;
>>>  		}
>>>  
>>> +	/* We found some strange devices in HP c7000 and other platforms that
>>> +	 * can not be enumerated by OS, but they did DMA read/write without
>>> +	 * driver management, so we should create the pt mapping for these
>>> +	 * devices to avoid DMA errors. Add iommu=pt_force=segment:busnum to
>>> +	 * force to do pt context mapping in the bus number.
>>> +	 */
>>> +	if (iommu_pt_force_bus >= 0 && iommu_pt_force_bus >= 0) {
>>> +		int found = 0;
>>> +
>>> +		iommu = NULL;
>>> +		for_each_active_iommu(iommu, drhd) {
>>> +			if (iommu_pt_force_domain != drhd->segment)
>>> +				continue;
>>> +
>>> +			for_each_active_dev_scope(drhd->devices, drhd->devices_cnt, i, dev) {
>>> +				if (!dev_is_pci(dev))
>>> +					continue;
>>> +
>>> +				pdev = to_pci_dev(dev);
>>> +				if (pdev->bus->number == iommu_pt_force_bus ||
>>> +						(pdev->subordinate
>>> +						 && pdev->subordinate->number <= iommu_pt_force_bus
>>> +						 && pdev->subordinate->busn_res.end >= iommu_pt_force_bus)) {
>>> +					found = 1;
>>> +					break;
>>> +				}
>>> +			}
>>> +
>>> +			if (drhd->include_all) {
>>> +				found = 1;
>>> +				break;
>>> +			}
>>> +		}
>>> +
>>> +		if (found && iommu)
>>> +			for (i = 0; i < 256; i++)
>>> +				domain_context_mapping_one(si_domain, iommu, iommu_pt_force_bus,
>>> +						i,  hw ? CONTEXT_TT_PASS_THROUGH :
>>> +						CONTEXT_TT_MULTI_LEVEL);
>>> +	}
>>> +
>>>  	return 0;
>>>  }
>>>  
>>>
>>
>> .
>>
> 
> 
