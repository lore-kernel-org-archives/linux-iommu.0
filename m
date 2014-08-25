From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Mon, 25 Aug 2014 19:16:25 +0800
Message-ID: <53FB1B09.5070209@huawei.com>
References: <1408949099-18677-1-git-send-email-wangyijing@huawei.com>
	<20140825091531.GG16329@8bytes.org>
	<8dada92a-19af-4b77-b917-f2d97291abbe@CMEXHTCAS2.ad.emulex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070609030207060109020109"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8dada92a-19af-4b77-b917-f2d97291abbe-3RiH6ntJJkOPfaB/Gd0HpljyZtpTMMwT@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sathya Perla <Sathya.Perla-iH1Dq9VlAzfQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Subramanian Seetharaman <subbu.seetharaman-laKkSmNT4hbQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--------------070609030207060109020109
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 2014/8/25 17:32, Sathya Perla wrote:
>> -----Original Message-----
>> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
>>
>> [Adding the Emulex driver developers to Cc for some input on the device,
>>  and why it might use wrong request ids]
>>
>> On Mon, Aug 25, 2014 at 02:44:59PM +0800, Yijing Wang wrote:
>>> We found some strange devices in HP C7000 and Huawei Storage Server.
>> These
>>> devices can not be enumerated by OS, but they still did DMA read/write
>>> without OS management. Because iommu will not create the DMA
>> mapping for
>>> these devices, the DMA read/write will be blocked by iommu hardware.
> 
> Hi Wang, could you please share the lspci -vvv output and the kernel log too.
> Thanks!

Hi Sathya,  I attached lspci info and dmesg at the end.

Thanks!
Yijing.

> 
>>>
>>> Eg.
>>> in HP C7000:
>>>  \-[0000:00]-+-00.0  Intel Corporation Xeon E5/Core i7 DMI2
>>>              +-01.0-[11]--
>>> 			 +-01.1-[02]--
>>> 			 +-02.0-[04]--+-00.0  Emulex Corporation OneConnect
>> 10Gb NIC (be3)
>>> 	         |            +-00.1  Emulex Corporation OneConnect 10Gb NIC (be3)
>>> 	         |            +-00.2  Emulex Corporation OneConnect 10Gb iSCSI
>> Initiator (be3)
>>> 	         |            \-00.3  Emulex Corporation OneConnect 10Gb iSCSI
>> Initiator (be3)
>>> 	         +-02.1-[12]--
>>> Kernel only found four devices in bus 0x04, but we found following DMA
>> errors in dmesg.
>>>
>>> [ 1438.477262] DRHD: handling fault status reg 402
>>> [ 1438.498278] DMAR:[DMA Write] Request device [04:00.4] fault addr
>> bdf70000
>>> [ 1438.498280] DMAR:[fault reason 02] Present bit in context entry is clear
>>> [ 1438.566458] DMAR:[DMA Write] Request device [04:00.5] fault addr
>> bdf70000
>>> [ 1438.566460] DMAR:[fault reason 02] Present bit in context entry is clear
>>> [ 1438.635211] DMAR:[DMA Write] Request device [04:00.6] fault addr
>> bdf70000
>>> [ 1438.635213] DMAR:[fault reason 02] Present bit in context entry is clear
>>> [ 1438.703849] DMAR:[DMA Write] Request device [04:00.7] fault addr
>> bdf70000
>>> [ 1438.703851] DMAR:[fault reason 02] Present bit in context entry is clear
>>>
>>> This patch add a kernel boot command parameter
>> iommu=pt_force=domain:busnum
>>> that based iommu identity mapping and force to create identity for all
>> devfn in
>>> the specific bus number to fix this issue.
>>
>> No! If the device really uses request-ids it shouldn't use please add a
>> DMA alias quirk instead. A new kernel parameter will not work out of the
>> box for other users of this device.
> 
> .
> 


-- 
Thanks!
Yijing

--------------070609030207060109020109
Content-Type: text/plain; charset="gb18030"; name="lspci_vvv-hpc7000.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci_vvv-hpc7000.log"

00:00.0 Host bridge: Intel Corporation Xeon E5/Core i7 DMI2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 0
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [144 v1] Vendor Specific Information: ID=0004 Rev=1 Len=03c <?>
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>

00:01.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 1a (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=11, subordinate=11, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #8, Speed 5GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:01.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 1b (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #9, Speed 5GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled+ Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 2a (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ebd00000-ebffffff
	Prefetchable memory behind bridge: 00000000dc000000-00000000dc0fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #16, Speed 8GT/s, Width x8, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd+
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 2b (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=12, subordinate=12, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.2 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 2c (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: ebb00000-ebcfffff
	Prefetchable memory behind bridge: 00000000dc100000-00000000dc1fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #18, Speed 8GT/s, Width x8, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.3 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 2d (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=13, subordinate=13, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:03.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 3a in PCI Express Mode (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dc200000-dc2fffff
	Prefetchable memory behind bridge: 00000000def00000-00000000ea7fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #24, Speed 5GT/s, Width x16, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd+
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:03.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 3b (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:03.2 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 3c (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:03.3 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 3d (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=16, subordinate=16, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:04.0 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at eacf0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:04.1 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 7
	Region 0: Memory at eace0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:04.2 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at eacd0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:04.3 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 3 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at eacc0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:04.4 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 4 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at eacb0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:04.5 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 5 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 7
	Region 0: Memory at eaca0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:04.6 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 6 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at eac90000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:04.7 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 7 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at eac80000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:05.0 System peripheral: Intel Corporation Xeon E5/Core i7 Address Map, VTd_Misc, System Management (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

00:05.2 System peripheral: Intel Corporation Xeon E5/Core i7 Control Status and Global Errors (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr+ FatalErr+ UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

00:05.4 PIC: Intel Corporation Xeon E5/Core i7 I/O APIC (rev 07) (prog-if 20 [IO(X)-APIC])
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: Memory at eac70000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [6c] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:11.0 PCI bridge: Intel Corporation C600/X79 series chipset PCI Express Virtual Root Port (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=18, subordinate=18, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #17, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled+ Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] Subsystem: Hewlett-Packard Company Device 18a9
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [138 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1a.0 USB controller: Intel Corporation C600/X79 series chipset USB2 Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company Device 18a9
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at eac60000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:1c.0 PCI bridge: Intel Corporation C600/X79 series chipset PCI Express Root Port 1 (rev b5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0 <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled+ Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train+ SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Hewlett-Packard Company Device 18a9
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.7 PCI bridge: Intel Corporation C600/X79 series chipset PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: ead00000-ebafffff
	Prefetchable memory behind bridge: 00000000dd000000-00000000ddffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Hewlett-Packard Company Device 18a9
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation C600/X79 series chipset USB2 Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company Device 18a9
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at eac50000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=17, subordinate=17, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: Hewlett-Packard Company Device 18a9

00:1f.0 ISA bridge: Intel Corporation C600/X79 series chipset LPC Controller (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel modules: iTCO_wdt

01:00.0 System peripheral: Hewlett-Packard Company Integrated Lights-Out Standard Slave Instrumentation & System Support (rev 05)
	Subsystem: Hewlett-Packard Company iLO4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 3000 [size=256]
	Region 1: Memory at ebaf0000 (32-bit, non-prefetchable) [size=512]
	Region 2: I/O ports at 3400 [size=256]
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: hpwdt
	Kernel modules: hpwdt

01:00.1 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200EH (prog-if 00 [VGA controller])
	Subsystem: Hewlett-Packard Company iLO4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 7
	Region 0: Memory at dd000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at ebae0000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at eb000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [a8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel modules: mgag200

01:00.2 System peripheral: Hewlett-Packard Company Integrated Lights-Out Standard Management Processor Support and Messaging (rev 05)
	Subsystem: Hewlett-Packard Company iLO4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 16
	Region 0: I/O ports at 3800 [size=256]
	Region 1: Memory at eaff0000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at eae00000 (32-bit, non-prefetchable) [size=1M]
	Region 3: Memory at ead80000 (32-bit, non-prefetchable) [size=512K]
	Region 4: Memory at ead70000 (32-bit, non-prefetchable) [size=32K]
	Region 5: Memory at ead60000 (32-bit, non-prefetchable) [size=32K]
	[virtual] Expansion ROM at ead00000 [disabled] [size=64K]
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: hpilo
	Kernel modules: hpilo

01:00.4 USB controller: Hewlett-Packard Company Integrated Lights-Out Standard Virtual USB Controller (rev 02) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company iLO4
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 16
	Region 4: I/O ports at 3c00 [size=32]
	Capabilities: [70] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [80] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [f0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

03:00.0 RAID bus controller: Hewlett-Packard Company Smart Array Gen8 Controllers (rev 01)
	Subsystem: Hewlett-Packard Company P220i
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 34
	Region 0: Memory at ebc00000 (64-bit, non-prefetchable) [size=1M]
	Region 2: Memory at ebbf0000 (64-bit, non-prefetchable) [size=1K]
	Region 4: I/O ports at 4000 [size=256]
	[virtual] Expansion ROM at dc100000 [disabled] [size=512K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable- Count=1/32 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [b0] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM unknown, Latency L0 unlimited, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [300 v1] #19
	Kernel driver in use: hpsa
	Kernel modules: hpsa

04:00.0 Ethernet controller: Emulex Corporation OneConnect 10Gb NIC (be3) (rev 01)
	Subsystem: Hewlett-Packard Company Device 337b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at ebff0000 (64-bit, non-prefetchable) [size=16K]
	Region 2: Memory at ebfc0000 (64-bit, non-prefetchable) [size=128K]
	Region 4: Memory at ebfa0000 (64-bit, non-prefetchable) [size=128K]
	[virtual] Expansion ROM at dc000000 [disabled] [size=256K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI-X: Enable+ Count=32 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <16us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b8] Vital Product Data
		Product Name: 647586-B21, NIC PF
		Read-only fields:
			[PN] Part number: 647584-001
			[SN] Serial number: H3534360ZX
			[V0] Vendor specific: VA00000000
			[EC] Engineering changes: A-5120
			[FN] Unknown: 36 34 39 39 34 30 2d 30 30 31 0d
			[VA] Vendor specific: 649940-001\x0d
			[VB] Vendor specific: PW=10W; PCIE X8 GEN 2
			[V1] Vendor specific: HP FlexFabric 10Gb 2-port 554FLB Adapter
			[V2] Vendor specific: 554FLB
			[V4] Vendor specific: 0
			[V5] Vendor specific: OCl11102-F4-HP
			[V6] Vendor specific: A0:1,D0:1
			[RV] Reserved: checksum good, 42 byte(s) reserved
		End
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 0, stride: 1, Device ID: 0710
		Supported Page Size: 00000557, System Page Size: 00000001
		Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [160 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [168 v1] Device Serial Number f0-92-1c-ff-fe-16-8d-48
	Capabilities: [12c v1] Transaction Processing Hints
		No steering table available
	Kernel driver in use: be2net
	Kernel modules: be2net

04:00.1 Ethernet controller: Emulex Corporation OneConnect 10Gb NIC (be3) (rev 01)
	Subsystem: Hewlett-Packard Company Device 337b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 36
	Region 0: Memory at ebf90000 (64-bit, non-prefetchable) [size=16K]
	Region 2: Memory at ebf60000 (64-bit, non-prefetchable) [size=128K]
	Region 4: Memory at ebf40000 (64-bit, non-prefetchable) [size=128K]
	[virtual] Expansion ROM at dc040000 [disabled] [size=256K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI-X: Enable+ Count=32 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <16us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b8] Vital Product Data
		Product Name: 647586-B21, NIC PF
		Read-only fields:
			[PN] Part number: 647584-001
			[SN] Serial number: H3534360ZX
			[V0] Vendor specific: VA00000000
			[EC] Engineering changes: A-5120
			[FN] Unknown: 36 34 39 39 34 30 2d 30 30 31 0d
			[VA] Vendor specific: 649940-001\x0d
			[VB] Vendor specific: PW=10W; PCIE X8 GEN 2
			[V1] Vendor specific: HP FlexFabric 10Gb 2-port 554FLB Adapter
			[V2] Vendor specific: 554FLB
			[V4] Vendor specific: 1
			[V5] Vendor specific: OCl11102-F4-HP
			[V6] Vendor specific: A0:1,D0:1
			[RV] Reserved: checksum good, 42 byte(s) reserved
		End
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 01
		VF offset: 0, stride: 1, Device ID: 0710
		Supported Page Size: 00000557, System Page Size: 00000001
		Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [160 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 2
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [168 v1] Device Serial Number f0-92-1c-ff-fe-16-8d-48
	Capabilities: [12c v1] Transaction Processing Hints
		No steering table available
	Kernel driver in use: be2net
	Kernel modules: be2net

04:00.2 Mass storage controller: Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3) (rev 01)
	Subsystem: Hewlett-Packard Company Device 337b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 37
	Region 0: Memory at ebf30000 (64-bit, non-prefetchable) [size=16K]
	Region 2: Memory at ebf00000 (64-bit, non-prefetchable) [size=128K]
	Region 4: Memory at ebee0000 (64-bit, non-prefetchable) [size=128K]
	[virtual] Expansion ROM at dc080000 [disabled] [size=256K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI-X: Enable- Count=8 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <16us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b8] Vital Product Data
		Product Name: 647586-B21, iSCSI PF
		Read-only fields:
			[PN] Part number: 647584-001
			[SN] Serial number: H3534360ZX
			[V0] Vendor specific: VA00000000
			[EC] Engineering changes: A-5120
			[FN] Unknown: 36 34 39 39 34 30 2d 30 30 31 0d
			[VA] Vendor specific: 649940-001\x0d
			[VB] Vendor specific: PW=10W; PCIE X8 GEN 2
			[V1] Vendor specific: HP FlexFabric 10Gb 2-port 554FLB Adapter
			[V2] Vendor specific: 554FLB
			[V4] Vendor specific: 0
			[V5] Vendor specific: OCl11102-F4-HP
			[V6] Vendor specific: A0:1,D0:1
			[RV] Reserved: checksum good, 40 byte(s) reserved
		End
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 02
		VF offset: 0, stride: 1, Device ID: 0712
		Supported Page Size: 00000557, System Page Size: 00000001
		Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [160 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 3
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [168 v1] Device Serial Number f0-92-1c-ff-fe-16-8d-48
	Capabilities: [12c v1] Transaction Processing Hints
		No steering table available
	Kernel driver in use: be2iscsi
	Kernel modules: be2iscsi

04:00.3 Mass storage controller: Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3) (rev 01)
	Subsystem: Hewlett-Packard Company Device 337b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 38
	Region 0: Memory at ebed0000 (64-bit, non-prefetchable) [size=16K]
	Region 2: Memory at ebea0000 (64-bit, non-prefetchable) [size=128K]
	Region 4: Memory at ebe80000 (64-bit, non-prefetchable) [size=128K]
	[virtual] Expansion ROM at dc0c0000 [disabled] [size=256K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI-X: Enable- Count=8 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <16us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b8] Vital Product Data
		Product Name: 647586-B21, iSCSI PF
		Read-only fields:
			[PN] Part number: 647584-001
			[SN] Serial number: H3534360ZX
			[V0] Vendor specific: VA00000000
			[EC] Engineering changes: A-5120
			[FN] Unknown: 36 34 39 39 34 30 2d 30 30 31 0d
			[VA] Vendor specific: 649940-001\x0d
			[VB] Vendor specific: PW=10W; PCIE X8 GEN 2
			[V1] Vendor specific: HP FlexFabric 10Gb 2-port 554FLB Adapter
			[V2] Vendor specific: 554FLB
			[V4] Vendor specific: 1
			[V5] Vendor specific: OCl11102-F4-HP
			[V6] Vendor specific: A0:1,D0:1
			[RV] Reserved: checksum good, 40 byte(s) reserved
		End
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 03
		VF offset: 0, stride: 1, Device ID: 0712
		Supported Page Size: 00000557, System Page Size: 00000001
		Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [160 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [168 v1] Device Serial Number f0-92-1c-ff-fe-16-8d-48
	Capabilities: [12c v1] Transaction Processing Hints
		No steering table available
	Kernel driver in use: be2iscsi
	Kernel modules: be2iscsi

05:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM57810 10 Gigabit Ethernet (rev 10)
	Subsystem: Hewlett-Packard Company Device 17a5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at ea000000 (64-bit, prefetchable) [size=8M]
	Region 2: Memory at e9800000 (64-bit, prefetchable) [size=8M]
	Region 4: Memory at e97f0000 (64-bit, prefetchable) [size=64K]
	[virtual] Expansion ROM at def00000 [disabled] [size=256K]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: HP Flex-10 10Gb 2-port 530M Adapter
		Read-only fields:
			[PN] Part number: 631882-001
			[EC] Engineering changes: A
			[MN] Manufacture ID: 31 30 33 43
			[V0] Vendor specific: 12W PCIeGen3
			[V1] Vendor specific: N/A
			[V2] Vendor specific: 01234
			[V3] Vendor specific: 7.0.49
			[V6] Vendor specific: 7.0.51
			[RV] Reserved: checksum good, 243 byte(s) reserved
		End
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00001000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <1us, L1 <2us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [13c v1] Device Serial Number a0-d3-c1-ff-fe-f5-06-18
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [1b8 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [220 v1] #15
	Capabilities: [300 v1] #19
	Kernel driver in use: bnx2x
	Kernel modules: bnx2x

05:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM57810 10 Gigabit Ethernet (rev 10)
	Subsystem: Hewlett-Packard Company Device 17a5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 44
	Region 0: Memory at e8800000 (64-bit, prefetchable) [size=8M]
	Region 2: Memory at e8000000 (64-bit, prefetchable) [size=8M]
	Region 4: Memory at e7ff0000 (64-bit, prefetchable) [size=64K]
	[virtual] Expansion ROM at def40000 [disabled] [size=256K]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: HP Flex-10 10Gb 2-port 530M Adapter
		Read-only fields:
			[PN] Part number: 631882-001
			[EC] Engineering changes: A
			[MN] Manufacture ID: 31 30 33 43
			[V0] Vendor specific: 12W PCIeGen3
			[V1] Vendor specific: N/A
			[V2] Vendor specific: 01234
			[V3] Vendor specific: 7.0.49
			[V6] Vendor specific: 7.0.51
			[RV] Reserved: checksum good, 243 byte(s) reserved
		End
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00001000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <1us, L1 <2us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [13c v1] Device Serial Number a0-d3-c1-ff-fe-f5-06-1c
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [1b8 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 2
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [220 v1] #15
	Kernel driver in use: bnx2x
	Kernel modules: bnx2x

1f:08.0 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:08.3 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link Reut 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v0] Vendor Specific Information: ID=0001 Rev=0 Len=0f0 <?>

1f:08.4 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link Reut 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:09.0 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:09.3 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link Reut 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v0] Vendor Specific Information: ID=0001 Rev=0 Len=0f0 <?>

1f:09.4 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link Reut 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:0a.0 System peripheral: Intel Corporation Xeon E5/Core i7 Power Control Unit 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0a.1 System peripheral: Intel Corporation Xeon E5/Core i7 Power Control Unit 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0a.2 System peripheral: Intel Corporation Xeon E5/Core i7 Power Control Unit 2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0a.3 System peripheral: Intel Corporation Xeon E5/Core i7 Power Control Unit 3 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0b.0 System peripheral: Intel Corporation Xeon E5/Core i7 Interrupt Control Registers (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0b.3 System peripheral: Intel Corporation Xeon E5/Core i7 Semaphore and Scratchpad Configuration Registers (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0c.0 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0c.1 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0c.2 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0c.3 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0c.6 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller System Address Decoder 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0c.7 System peripheral: Intel Corporation Xeon E5/Core i7 System Address Decoder (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0d.0 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0d.1 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0d.2 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0d.3 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0d.6 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller System Address Decoder 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0e.0 System peripheral: Intel Corporation Xeon E5/Core i7 Processor Home Agent (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:0e.1 Performance counters: Intel Corporation Xeon E5/Core i7 Processor Home Agent Performance Monitoring (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: snbep_uncore

1f:0f.0 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Registers (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:0f.1 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller RAS Registers (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:0f.2 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Target Address Decoder 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:0f.3 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Target Address Decoder 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:0f.4 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Target Address Decoder 2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:0f.5 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Target Address Decoder 3 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:0f.6 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Target Address Decoder 4 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:10.0 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Channel 0-3 Thermal Control 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: snbep_uncore

1f:10.1 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Channel 0-3 Thermal Control 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: snbep_uncore

1f:10.2 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller ERROR Registers 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:10.3 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller ERROR Registers 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:10.4 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Channel 0-3 Thermal Control 2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: snbep_uncore

1f:10.5 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Channel 0-3 Thermal Control 3 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: snbep_uncore

1f:10.6 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller ERROR Registers 2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:10.7 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller ERROR Registers 3 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

1f:11.0 System peripheral: Intel Corporation Xeon E5/Core i7 DDRIO (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:13.0 System peripheral: Intel Corporation Xeon E5/Core i7 R2PCIe (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:13.1 Performance counters: Intel Corporation Xeon E5/Core i7 Ring to PCI Express Performance Monitor (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: snbep_uncore

1f:13.4 Performance counters: Intel Corporation Xeon E5/Core i7 QuickPath Interconnect Agent Ring Registers (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

1f:13.5 Performance counters: Intel Corporation Xeon E5/Core i7 Ring to QuickPath Interconnect Link 0 Performance Monitor (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: snbep_uncore

1f:13.6 System peripheral: Intel Corporation Xeon E5/Core i7 Ring to QuickPath Interconnect Link 1 Performance Monitor (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: snbep_uncore

20:00.0 PCI bridge: Intel Corporation Xeon E5/Core i7 DMI2 in PCI Express Mode (rev 07) (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=20, secondary=2d, subordinate=2d, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+ ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:01.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 1a (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=20, secondary=24, subordinate=24, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:01.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 1b (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=20, secondary=25, subordinate=25, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:02.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 2a (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=20, secondary=26, subordinate=26, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:02.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 2b (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=20, secondary=27, subordinate=27, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:02.2 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 2c (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=20, secondary=28, subordinate=28, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:02.3 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 2d (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=20, secondary=29, subordinate=29, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:03.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 3a in PCI Express Mode (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=20, secondary=21, subordinate=21, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ec000000-ec0fffff
	Prefetchable memory behind bridge: 00000000eff00000-00000000fb7fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #24, Speed 5GT/s, Width x16, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd+
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:03.1 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 3b (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=20, secondary=2a, subordinate=2a, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:03.2 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 3c (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=20, secondary=2b, subordinate=2b, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:03.3 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root Port 3d (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=20, secondary=2c, subordinate=2c, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Device 18a8
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 unlimited, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

20:04.0 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at fbff0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

20:04.1 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 7
	Region 0: Memory at fbfe0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

20:04.2 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at fbfd0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

20:04.3 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 3 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at fbfc0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

20:04.4 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 4 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at fbfb0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

20:04.5 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 5 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 7
	Region 0: Memory at fbfa0000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

20:04.6 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 6 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at fbf90000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

20:04.7 System peripheral: Intel Corporation Xeon E5/Core i7 DMA Channel 7 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at fbf80000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

20:05.0 System peripheral: Intel Corporation Xeon E5/Core i7 Address Map, VTd_Misc, System Management (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

20:05.2 System peripheral: Intel Corporation Xeon E5/Core i7 Control Status and Global Errors (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr+ FatalErr+ UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

20:05.4 PIC: Intel Corporation Xeon E5/Core i7 I/O APIC (rev 07) (prog-if 20 [IO(X)-APIC])
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: Memory at fbf70000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [6c] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

21:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM57810 10 Gigabit Ethernet (rev 10)
	Subsystem: Hewlett-Packard Company Device 17a5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 64
	Region 0: Memory at fb000000 (64-bit, prefetchable) [size=8M]
	Region 2: Memory at fa800000 (64-bit, prefetchable) [size=8M]
	Region 4: Memory at fa7f0000 (64-bit, prefetchable) [size=64K]
	[virtual] Expansion ROM at eff00000 [disabled] [size=256K]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: HP Flex-10 10Gb 2-port 530M Adapter
		Read-only fields:
			[PN] Part number: 631882-001
			[EC] Engineering changes: A
			[MN] Manufacture ID: 31 30 33 43
			[V0] Vendor specific: 12W PCIeGen3
			[V1] Vendor specific: N/A
			[V2] Vendor specific: 01234
			[V3] Vendor specific: 7.0.49
			[V6] Vendor specific: 7.0.51
			[RV] Reserved: checksum good, 243 byte(s) reserved
		End
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00001000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <1us, L1 <2us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [13c v1] Device Serial Number 2c-44-fd-ff-fe-8d-ff-88
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [1b8 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [220 v1] #15
	Capabilities: [300 v1] #19
	Kernel driver in use: bnx2x
	Kernel modules: bnx2x

21:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM57810 10 Gigabit Ethernet (rev 10)
	Subsystem: Hewlett-Packard Company Device 17a5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 68
	Region 0: Memory at f9800000 (64-bit, prefetchable) [size=8M]
	Region 2: Memory at f9000000 (64-bit, prefetchable) [size=8M]
	Region 4: Memory at f8ff0000 (64-bit, prefetchable) [size=64K]
	[virtual] Expansion ROM at eff40000 [disabled] [size=256K]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: HP Flex-10 10Gb 2-port 530M Adapter
		Read-only fields:
			[PN] Part number: 631882-001
			[EC] Engineering changes: A
			[MN] Manufacture ID: 31 30 33 43
			[V0] Vendor specific: 12W PCIeGen3
			[V1] Vendor specific: N/A
			[V2] Vendor specific: 01234
			[V3] Vendor specific: 7.0.49
			[V6] Vendor specific: 7.0.51
			[RV] Reserved: checksum good, 243 byte(s) reserved
		End
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00001000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <1us, L1 <2us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [13c v1] Device Serial Number 2c-44-fd-ff-fe-8d-ff-8c
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [1b8 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 2
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [220 v1] #15
	Kernel driver in use: bnx2x
	Kernel modules: bnx2x

3f:08.0 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:08.3 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link Reut 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v0] Vendor Specific Information: ID=0001 Rev=0 Len=0f0 <?>

3f:08.4 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link Reut 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:09.0 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:09.3 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link Reut 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v0] Vendor Specific Information: ID=0001 Rev=0 Len=0f0 <?>

3f:09.4 System peripheral: Intel Corporation Xeon E5/Core i7 QPI Link Reut 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:0a.0 System peripheral: Intel Corporation Xeon E5/Core i7 Power Control Unit 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0a.1 System peripheral: Intel Corporation Xeon E5/Core i7 Power Control Unit 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0a.2 System peripheral: Intel Corporation Xeon E5/Core i7 Power Control Unit 2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0a.3 System peripheral: Intel Corporation Xeon E5/Core i7 Power Control Unit 3 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0b.0 System peripheral: Intel Corporation Xeon E5/Core i7 Interrupt Control Registers (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0b.3 System peripheral: Intel Corporation Xeon E5/Core i7 Semaphore and Scratchpad Configuration Registers (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0c.0 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0c.1 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0c.2 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0c.3 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0c.6 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller System Address Decoder 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0c.7 System peripheral: Intel Corporation Xeon E5/Core i7 System Address Decoder (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0d.0 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0d.1 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0d.2 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0d.3 System peripheral: Intel Corporation Xeon E5/Core i7 Unicast Register 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0d.6 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller System Address Decoder 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0e.0 System peripheral: Intel Corporation Xeon E5/Core i7 Processor Home Agent (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:0e.1 Performance counters: Intel Corporation Xeon E5/Core i7 Processor Home Agent Performance Monitoring (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: snbep_uncore

3f:0f.0 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Registers (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:0f.1 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller RAS Registers (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:0f.2 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Target Address Decoder 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:0f.3 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Target Address Decoder 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:0f.4 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Target Address Decoder 2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:0f.5 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Target Address Decoder 3 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:0f.6 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Target Address Decoder 4 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:10.0 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Channel 0-3 Thermal Control 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: snbep_uncore

3f:10.1 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Channel 0-3 Thermal Control 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: snbep_uncore

3f:10.2 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller ERROR Registers 0 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:10.3 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller ERROR Registers 1 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:10.4 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Channel 0-3 Thermal Control 2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: snbep_uncore

3f:10.5 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller Channel 0-3 Thermal Control 3 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: snbep_uncore

3f:10.6 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller ERROR Registers 2 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:10.7 System peripheral: Intel Corporation Xeon E5/Core i7 Integrated Memory Controller ERROR Registers 3 (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

3f:11.0 System peripheral: Intel Corporation Xeon E5/Core i7 DDRIO (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:13.0 System peripheral: Intel Corporation Xeon E5/Core i7 R2PCIe (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:13.1 Performance counters: Intel Corporation Xeon E5/Core i7 Ring to PCI Express Performance Monitor (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: snbep_uncore

3f:13.4 Performance counters: Intel Corporation Xeon E5/Core i7 QuickPath Interconnect Agent Ring Registers (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

3f:13.5 Performance counters: Intel Corporation Xeon E5/Core i7 Ring to QuickPath Interconnect Link 0 Performance Monitor (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: snbep_uncore

3f:13.6 System peripheral: Intel Corporation Xeon E5/Core i7 Ring to QuickPath Interconnect Link 1 Performance Monitor (rev 07)
	Subsystem: Hewlett-Packard Company Device 18a8
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: snbep_uncore


--------------070609030207060109020109
Content-Type: text/plain; charset="gb18030"; name="dmesg-IOMMU.log"
Content-Disposition: attachment; filename="dmesg-IOMMU.log"
Content-Transfer-Encoding: quoted-printable

izing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.93-0.8-default (geeko@buildhost)  #1 SMP=
 Tue Aug 27 08:44:18 UTC 2013 (70ed288)
[    0.000000] Command line: noexec=3Don nmi_watchdog=3D1 pci=3Drealloc c=
onsole=3Dtty0 console=3DttyS0,115200 crashkernel=3D192M@48M nohz=3Doff hi=
ghres=3Don intel_iommu=3Don selinux=3D0 hpet=3Dverbose audit=3D1 elevator=
=3Dnoop hugepages=3D100 hugepagesz=3D1G default_hugepagesz=3D1G
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009cc00 (usable)
[    0.000000]  BIOS-e820: 000000000009cc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bddac000 (usable)
[    0.000000]  BIOS-e820: 00000000bddac000 - 00000000bddde000 (ACPI data=
)
[    0.000000]  BIOS-e820: 00000000bddde000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fee10000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000203ffff000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.7 present.
[    0.000000] DMI: HP ProLiant BL460c Gen8, BIOS I31 09/18/2013
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (us=
able) =3D=3D> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (us=
able)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn =3D 0x203ffff max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000C0000000 mask 3FFFC0000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600=
070106
[    0.000000] last_pfn =3D 0xbddac max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000f4f80] f4f80
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 20=
480
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: 0000000000000000-00000000bddac000
[    0.000000]  0000000000 - 0080000000 page 1G
[    0.000000]  0080000000 - 00bdc00000 page 2M
[    0.000000]  00bdc00000 - 00bddac000 page 4k
[    0.000000] kernel direct mapping tables up to 0xbddabfff @ [mem 0x1ff=
fd000-0x1fffffff]
[    0.000000] init_memory_mapping: 0000000100000000-000000203ffff000
[    0.000000]  0100000000 - 2000000000 page 1G
[    0.000000]  2000000000 - 203fe00000 page 2M
[    0.000000]  203fe00000 - 203ffff000 page 4k
[    0.000000] kernel direct mapping tables up to 0x203fffefff @ [mem 0xb=
dda9000-0xbddabfff]
[    0.000000] nmi ring buffer: 262144
[    0.000000] RAMDISK: 37ab7000 - 37ff0000
[    0.000000] Reserving 192MB of memory at 48MB for crashkernel (System =
RAM: 132095MB)
[    0.000000] ACPI: RSDP 00000000000f4f00 00024 (v02 HP    )
[    0.000000] ACPI: XSDT 00000000bddaed00 000EC (v01 HP     ProLiant 000=
00002   =D2? 0000162E)
[    0.000000] ACPI: FACP 00000000bddaee40 000F4 (v03 HP     ProLiant 000=
00002   =D2? 0000162E)
[    0.000000] ACPI Warning: Invalid length for Pm1aControlBlock: 32, usi=
ng default 16 (20110413/tbfadt-611)
[    0.000000] ACPI Warning: Invalid length for Pm2ControlBlock: 32, usin=
g default 8 (20110413/tbfadt-611)
[    0.000000] ACPI: DSDT 00000000bddaef40 026DC (v01 HP         DSDT 000=
00001 INTL 20030228)
[    0.000000] ACPI: FACS 00000000bddac140 00040
[    0.000000] ACPI: SPCR 00000000bddac180 00050 (v01 HP     SPCRRBSU 000=
00001   =D2? 0000162E)
[    0.000000] ACPI: MCFG 00000000bddac200 0003C (v01 HP     ProLiant 000=
00001      00000000)
[    0.000000] ACPI: HPET 00000000bddac240 00038 (v01 HP     ProLiant 000=
00002   =D2? 0000162E)
[    0.000000] ACPI: FFFF 00000000bddac280 00064 (v02 HP     ProLiant 000=
00002   =D2? 0000162E)
[    0.000000] ACPI: SPMI 00000000bddac300 00040 (v05 HP     ProLiant 000=
00001   =D2? 0000162E)
[    0.000000] ACPI: ERST 00000000bddac340 00230 (v01 HP     ProLiant 000=
00001   =D2? 0000162E)
[    0.000000] ACPI: APIC 00000000bddac580 0026A (v01 HP     ProLiant 000=
00002      00000000)
[    0.000000] ACPI: SRAT 00000000bddac800 00750 (v01 HP     Proliant 000=
00001   =D2? 0000162E)
[    0.000000] ACPI: FFFF 00000000bddacf80 00176 (v01 HP     ProLiant 000=
00001   =D2? 0000162E)
[    0.000000] ACPI: BERT 00000000bddad100 00030 (v01 HP     ProLiant 000=
00001   =D2? 0000162E)
[    0.000000] ACPI: HEST 00000000bddad140 000BC (v01 HP     ProLiant 000=
00001   =D2? 0000162E)
[    0.000000] ACPI: DMAR 00000000bddad200 0060C (v01 HP     ProLiant 000=
00001   =D2? 0000162E)
[    0.000000] ACPI: FFFF 00000000bddaec40 00030 (v01 HP     ProLiant 000=
00001      00000000)
[    0.000000] ACPI: PCCT 00000000bddaec80 0006E (v01 HP     Proliant 000=
00001   PH 0000504D)
[    0.000000] ACPI: SSDT 00000000bddb1640 007EA (v01     HP DEV_PCI1 000=
00001 INTL 20120503)
[    0.000000] ACPI: SSDT 00000000bddb1e40 00166 (v03     HP  CRSPCI0 000=
00002   HP 00000001)
[    0.000000] ACPI: SSDT 00000000bddb1fc0 000C7 (v03     HP  CRSPCI1 000=
00002   HP 00000001)
[    0.000000] ACPI: SSDT 00000000bddb20c0 00413 (v03     HP embedded 000=
00002 INTL 20030228)
[    0.000000] ACPI: SSDT 00000000bddb2500 0038A (v02     HP   riser0 000=
00002 INTL 20030228)
[    0.000000] ACPI: SSDT 00000000bddb28c0 00263 (v03     HP embedde2 000=
00002 INTL 20030228)
[    0.000000] ACPI: SSDT 00000000bddb2b40 00BB9 (v01     HP      pcc 000=
00001 INTL 20120503)
[    0.000000] ACPI: SSDT 00000000bddb3700 00377 (v01     HP     pmab 000=
00001 INTL 20120503)
[    0.000000] ACPI: SSDT 00000000bddb3a80 05524 (v01     HP     pcc2 000=
00001 INTL 20120503)
[    0.000000] ACPI: SSDT 00000000bddb8fc0 04E84 (v01 INTEL  PPM RCM  000=
00001 INTL 20061109)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0f -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x20 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x21 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x22 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x23 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x28 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x29 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2a -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2b -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2c -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2d -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2e -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2f -> Node 1
[    0.000000] SRAT: Node 0 PXM 0 0-1040000000
[    0.000000] SRAT: Node 1 PXM 1 1040000000-2040000000
[    0.000000] Initmem setup node 0 0000000000000000-0000001040000000
[    0.000000]   NODE_DATA [000000103ffd9000 - 000000103fffffff]
[    0.000000] Initmem setup node 1 0000001040000000-000000203ffff000
[    0.000000]   NODE_DATA [000000203ff98080 - 000000203ffbf07f]
[    0.000000]  [ffffea0000000000-ffffea0038dfffff] PMD -> [ffff880fffe00=
000-ffff881037dfffff] on node 0
[    0.000000]  [ffffea0038e00000-ffffea0070dfffff] PMD -> [ffff881fff600=
000-ffff8820375fffff] on node 1
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0203ffff
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009c
[    0.000000]     0: 0x00000100 -> 0x000bddac
[    0.000000]     0: 0x00100000 -> 0x01040000
[    0.000000]     1: 0x01040000 -> 0x0203ffff
[    0.000000] On node 0 totalpages: 16768312
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3919 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 759268 pages, LIFO batch:31
[    0.000000]   Normal zone: 218624 pages used for memmap
[    0.000000]   Normal zone: 15772160 pages, LIFO batch:31
[    0.000000] On node 1 totalpages: 16777215
[    0.000000]   Normal zone: 229376 pages used for memmap
[    0.000000]   Normal zone: 16547839 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x908
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x08] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x0a] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x0c] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0e] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x20] lapic_id[0x20] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x22] lapic_id[0x22] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x24] lapic_id[0x24] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x26] lapic_id[0x26] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x28] lapic_id[0x28] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2a] lapic_id[0x2a] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2c] lapic_id[0x2c] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2e] lapic_id[0x2e] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x09] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x0b] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x0d] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0f] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x21] lapic_id[0x21] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x23] lapic_id[0x23] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x25] lapic_id[0x25] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x27] lapic_id[0x27] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x29] lapic_id[0x29] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2b] lapic_id[0x2b] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2d] lapic_id[0x2d] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2f] lapic_id[0x2f] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI =
0-23
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec10000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 0, version 32, address 0xfec10000, GSI =
24-47
[    0.000000] ACPI: IOAPIC (id[0x0a] address[0xfec40000] gsi_base[48])
[    0.000000] IOAPIC[2]: apic_id 10, version 32, address 0xfec40000, GSI=
 48-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level=
)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 64 CPUs, 32 hotplug CPUs
[    0.000000] nr_irqs_gsi: 88
[    0.000000] PM: Registered nosave memory: 000000000009c000 - 000000000=
009d000
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 000000000=
00a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 000000000=
00e8000
[    0.000000] PM: Registered nosave memory: 00000000000e8000 - 000000000=
0100000
[    0.000000] PM: Registered nosave memory: 00000000bddac000 - 00000000b=
ddde000
[    0.000000] PM: Registered nosave memory: 00000000bddde000 - 00000000d=
0000000
[    0.000000] PM: Registered nosave memory: 00000000d0000000 - 00000000f=
ec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000f=
ee10000
[    0.000000] PM: Registered nosave memory: 00000000fee10000 - 00000000f=
f800000
[    0.000000] PM: Registered nosave memory: 00000000ff800000 - 000000010=
0000000
[    0.000000] Allocating PCI resources starting at d0000000 (gap: d00000=
00:2ec00000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:4096 nr_cpumask_bits:64 nr_cpu_ids:6=
4 nr_node_ids:2
[    0.000000] PERCPU: Embedded 26 pages/cpu @ffff88103fa00000 s75264 r81=
92 d23040 u131072
[    0.000000] pcpu-alloc: s75264 r8192 d23040 u131072 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 16 17 18 19 20 21 =
22 23=20
[    0.000000] pcpu-alloc: [0] 32 34 36 38 40 42 44 46 48 50 52 54 56 58 =
60 62=20
[    0.000000] pcpu-alloc: [1] 08 09 10 11 12 13 14 15 24 25 26 27 28 29 =
30 31=20
[    0.000000] pcpu-alloc: [1] 33 35 37 39 41 43 45 47 49 51 53 55 57 59 =
61 63=20
[    0.000000] Built 2 zonelists in Zone order, mobility grouping on.  To=
tal pages: 33083186
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: noexec=3Don nmi_watchdog=3D1 pci=3Dre=
alloc console=3Dtty0 console=3DttyS0,115200 crashkernel=3D192M@48M nohz=3D=
off highres=3Don intel_iommu=3Don selinux=3D0 hpet=3Dverbose audit=3D1 el=
evator=3Dnoop hugepages=3D100 hugepagesz=3D1G default_hugepagesz=3D1G
[    0.000000] Intel-IOMMU: enabled
[    0.000000] audit: enabled (after initialization)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Queued invalidation will be enabled to support x2apic and =
Intr-remapping.
[    0.000000] Memory: 132054084k/135266300k available (4524k kernel code=
, 1084192k absent, 2128024k reserved, 7613k data, 1364k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:262400 nr_irqs:2008 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] allocated 1073741824 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't w=
ant memory cgroups
[    0.000000] hpet: hpet_enable(921):
[    0.000000] hpet: ID: 0x8086a701, PERIOD: 0x429b17f
[    0.000000] hpet: CFG: 0x0, STATUS: 0x0
[    0.000000] hpet: COUNTER_l: 0x0, COUNTER_h: 0x0
[    0.000000] hpet: T0: CFG_l: 0x8030, CFG_h: 0xf00000
[    0.000000] hpet: T0: CMP_l: 0xffffffff, CMP_h: 0xffffffff
[    0.000000] hpet: T0 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T1: CFG_l: 0x8000, CFG_h: 0xf00000
[    0.000000] hpet: T1: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T1 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T2: CFG_l: 0x8000, CFG_h: 0xf00800
[    0.000000] hpet: T2: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T2 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T3: CFG_l: 0x8000, CFG_h: 0xf01000
[    0.000000] hpet: T3: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T3 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T4: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T4: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T4 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T5: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T5: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T5 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T6: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T6: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T6 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T7: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T7: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T7 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: hpet_enable(960):
[    0.000000] hpet: ID: 0x8086a701, PERIOD: 0x429b17f
[    0.000000] hpet: CFG: 0x0, STATUS: 0x0
[    0.000000] hpet: COUNTER_l: 0x0, COUNTER_h: 0x0
[    0.000000] hpet: T0: CFG_l: 0x8030, CFG_h: 0xf00000
[    0.000000] hpet: T0: CMP_l: 0xffffffff, CMP_h: 0xffffffff
[    0.000000] hpet: T0 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T1: CFG_l: 0x8000, CFG_h: 0xf00000
[    0.000000] hpet: T1: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T1 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T2: CFG_l: 0x8000, CFG_h: 0xf00800
[    0.000000] hpet: T2: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T2 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T3: CFG_l: 0x8000, CFG_h: 0xf01000
[    0.000000] hpet: T3: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T3 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T4: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T4: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T4 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T5: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T5: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T5 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T6: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T6: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T6 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T7: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T7: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T7 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: hpet_set_mode(401):
[    0.000000] hpet: ID: 0x8086a701, PERIOD: 0x429b17f
[    0.000000] hpet: CFG: 0x3, STATUS: 0x0
[    0.000000] hpet: COUNTER_l: 0xed54, COUNTER_h: 0x0
[    0.000000] hpet: T0: CFG_l: 0x813c, CFG_h: 0xf00000
[    0.000000] hpet: T0: CMP_l: 0x1c417, CMP_h: 0x0
[    0.000000] hpet: T0 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T1: CFG_l: 0x8000, CFG_h: 0xf00000
[    0.000000] hpet: T1: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T1 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T2: CFG_l: 0x8000, CFG_h: 0xf00800
[    0.000000] hpet: T2: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T2 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T3: CFG_l: 0x8000, CFG_h: 0xf01000
[    0.000000] hpet: T3: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T3 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T4: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T4: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T4 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T5: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T5: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T5 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T6: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T6: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T6 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet: T7: CFG_l: 0xc000, CFG_h: 0x0
[    0.000000] hpet: T7: CMP_l: 0xffffffff, CMP_h: 0x0
[    0.000000] hpet: T7 ROUTE_l: 0x0, ROUTE_h: 0x0
[    0.000000] hpet clockevent registered
[    0.004000] Fast TSC calibration using PIT
[    0.008000] Detected 2600.105 MHz processor.
[    0.000026] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 5200.21 BogoMIPS (lpj=3D10400420)
[    0.003556] pid_max: default: 65536 minimum: 512
[    0.005254] kdb version 4.4 by Keith Owens, Scott Lurndal. Copyright S=
GI, All Rights Reserved
[    0.015635] Security Framework initialized
[    0.017022] AppArmor: AppArmor initialized
[    0.024811] Dentry cache hash table entries: 16777216 (order: 15, 1342=
17728 bytes)
[    0.050370] Inode-cache hash table entries: 8388608 (order: 14, 671088=
64 bytes)
[    0.062929] Mount-cache hash table entries: 256
[    0.064916] Initializing cgroup subsys cpuacct
[    0.066379] Initializing cgroup subsys memory
[    0.067910] Initializing cgroup subsys devices
[    0.069336] Initializing cgroup subsys freezer
[    0.070766] Initializing cgroup subsys net_cls
[    0.072232] Initializing cgroup subsys blkio
[    0.073988] Initializing cgroup subsys perf_event
[    0.075556] CPU: Physical Processor ID: 0
[    0.076938] CPU: Processor Core ID: 0
[    0.078160] ENERGY_PERF_BIAS: Is set to 'performance'
[    0.078161] ENERGY_PERF_BIAS: View and update with cpupower-set(8)
[    0.083074] mce: CPU supports 20 MCE banks
[    0.084443] CPU0: Thermal monitoring enabled (TM1)
[    0.085997] using mwait in idle threads.
[    0.088022] ACPI: Core revision 20110413
[    0.094037] DMAR: Host address width 46
[    0.095347] DMAR: DRHD base: 0x000000f8efe000 flags: 0x0
[    0.097030] IOMMU 0: reg_base_addr f8efe000 ver 1:0 cap d2078c106f0462=
 ecap f020fe
[    0.099513] DMAR: DRHD base: 0x000000f1ffe000 flags: 0x1
[    0.101202] IOMMU 1: reg_base_addr f1ffe000 ver 1:0 cap d2078c106f0462=
 ecap f020fe
[    0.103623] DMAR: RMRR base: 0x000000bdffd000 end: 0x000000bdffffff
[    0.105551] DMAR: RMRR base: 0x000000bdff6000 end: 0x000000bdffcfff
[    0.107517] DMAR: RMRR base: 0x000000bdf83000 end: 0x000000bdf84fff
[    0.109430] DMAR: RMRR base: 0x000000bdf7f000 end: 0x000000bdf82fff
[    0.111343] DMAR: RMRR base: 0x000000bdf6f000 end: 0x000000bdf7efff
[    0.113345] DMAR: RMRR base: 0x000000bdf6e000 end: 0x000000bdf6efff
[    0.115382] DMAR: RMRR base: 0x000000000f4000 end: 0x000000000f4fff
[    0.117362] DMAR: RMRR base: 0x000000000e8000 end: 0x000000000e8fff
[    0.119326] DMAR: RMRR base: 0x000000bddde000 end: 0x000000bdddefff
[    0.121268] DMAR: ATSR flags: 0x0
[    0.122512] IOAPIC id 10 under DRHD base  0xf8efe000 IOMMU 0
[    0.124273] IOAPIC id 8 under DRHD base  0xf1ffe000 IOMMU 1
[    0.126000] IOAPIC id 0 under DRHD base  0xf1ffe000 IOMMU 1
[    0.127705] HPET id 0 under DRHD base 0xf1ffe000
[    0.129262] BIOS requests to not use x2apic
[    0.129262] Use 'intremap=3Dno_x2apic_optout' to override BIOS request
[    0.133253] Enabled IRQ remapping in xapic mode
[    0.135842] x2apic not enabled, IRQ remapping is in xapic mode
[    0.138028] Switched APIC routing to physical flat.
[    0.140253] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.181870] CPU0: Intel(R) Xeon(R) CPU E5-2670 0 @ 2.60GHz stepping 07
[    0.288744] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge e=
vents, Broken BIOS detected, complain to your hardware vendor.
[    0.292977] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (M=
SR 38d is 330)
[    0.295383] Intel PMU driver.
[    0.297378] ... version:                3
[    0.299494] ... bit width:              48
[    0.300830] ... generic registers:      4
[    0.302153] ... value mask:             0000ffffffffffff
[    0.303863] ... max period:             000000007fffffff
[    0.305521] ... fixed-purpose events:   3
[    0.306915] ... event mask:             000000070000000f
[    0.309579] NMI watchdog enabled, takes one hw-pmu counter.
[    0.311642] Booting Node   0, Processors  #1
[    0.313502] smpboot cpu 1: start_ip =3D 97000
[    0.348751] NMI watchdog enabled, takes one hw-pmu counter.
[    0.350869]  #2
[    0.351452] smpboot cpu 2: start_ip =3D 97000
[    0.383213] NMI watchdog enabled, takes one hw-pmu counter.
[    0.385247]  #3
[    0.385799] smpboot cpu 3: start_ip =3D 97000
[    0.417645] NMI watchdog enabled, takes one hw-pmu counter.
[    0.420129]  #4
[    0.420696] smpboot cpu 4: start_ip =3D 97000
[    0.452507] NMI watchdog enabled, takes one hw-pmu counter.
[    0.455964]  #5
[    0.456521] smpboot cpu 5: start_ip =3D 97000
[    0.487828] NMI watchdog enabled, takes one hw-pmu counter.
[    0.489838]  #6
[    0.490397] smpboot cpu 6: start_ip =3D 97000
[    0.521704] NMI watchdog enabled, takes one hw-pmu counter.
[    0.523715]  #7
[    0.524295] smpboot cpu 7: start_ip =3D 97000
[    0.555608] NMI watchdog enabled, takes one hw-pmu counter.
[    0.557657]  Ok.
[    0.558352] Booting Node   1, Processors  #8
[    0.559726] smpboot cpu 8: start_ip =3D 97000
[    0.719882] NMI watchdog enabled, takes one hw-pmu counter.
[    0.721937]  #9
[    0.722501] smpboot cpu 9: start_ip =3D 97000
[    0.754300] NMI watchdog enabled, takes one hw-pmu counter.
[    0.757008]  #10
[    0.757619] smpboot cpu 10: start_ip =3D 97000
[    0.789397] NMI watchdog enabled, takes one hw-pmu counter.
[    0.791362]  #11
[    0.791939] smpboot cpu 11: start_ip =3D 97000
[    0.823715] NMI watchdog enabled, takes one hw-pmu counter.
[    0.825676]  #12
[    0.826269] smpboot cpu 12: start_ip =3D 97000
[    0.858060] NMI watchdog enabled, takes one hw-pmu counter.
[    0.860045]  #13
[    0.860685] smpboot cpu 13: start_ip =3D 97000
[    0.892395] NMI watchdog enabled, takes one hw-pmu counter.
[    0.895570]  #14
[    0.896315] smpboot cpu 14: start_ip =3D 97000
[    0.928003] NMI watchdog enabled, takes one hw-pmu counter.
[    0.929996]  #15
[    0.930709] smpboot cpu 15: start_ip =3D 97000
[    1.010911] NMI watchdog enabled, takes one hw-pmu counter.
[    1.013140]  Ok.
[    1.013806] Booting Node   0, Processors  #16
[    1.015185] smpboot cpu 16: start_ip =3D 97000
[    1.046591] NMI watchdog enabled, takes one hw-pmu counter.
[    1.048546]  #17
[    1.049134] smpboot cpu 17: start_ip =3D 97000
[    1.080451] NMI watchdog enabled, takes one hw-pmu counter.
[    1.082402]  #18
[    1.082990] smpboot cpu 18: start_ip =3D 97000
[    1.114310] NMI watchdog enabled, takes one hw-pmu counter.
[    1.117121]  #19
[    1.117816] smpboot cpu 19: start_ip =3D 97000
[    1.149596] NMI watchdog enabled, takes one hw-pmu counter.
[    1.151631]  #20
[    1.152192] smpboot cpu 20: start_ip =3D 97000
[    1.183499] NMI watchdog enabled, takes one hw-pmu counter.
[    1.185426]  #21
[    1.186334] smpboot cpu 21: start_ip =3D 97000
[    1.217693] NMI watchdog enabled, takes one hw-pmu counter.
[    1.219833]  #22
[    1.220820] smpboot cpu 22: start_ip =3D 97000
[    1.252138] NMI watchdog enabled, takes one hw-pmu counter.
[    1.254101]  #23
[    1.254775] smpboot cpu 23: start_ip =3D 97000
[    1.286097] NMI watchdog enabled, takes one hw-pmu counter.
[    1.288116]  Ok.
[    1.288815] Booting Node   1, Processors  #24
[    1.290273] smpboot cpu 24: start_ip =3D 97000
[    1.321950] NMI watchdog enabled, takes one hw-pmu counter.
[    1.323881]  #25
[    1.324468] smpboot cpu 25: start_ip =3D 97000
[    1.356250] NMI watchdog enabled, takes one hw-pmu counter.
[    1.358443]  #26
[    1.359023] smpboot cpu 26: start_ip =3D 97000
[    1.390816] NMI watchdog enabled, takes one hw-pmu counter.
[    1.392761]  #27
[    1.393374] smpboot cpu 27: start_ip =3D 97000
[    1.425149] NMI watchdog enabled, takes one hw-pmu counter.
[    1.427225]  #28
[    1.427945] smpboot cpu 28: start_ip =3D 97000
[    1.508236] NMI watchdog enabled, takes one hw-pmu counter.
[    1.510279]  #29
[    1.510863] smpboot cpu 29: start_ip =3D 97000
[    1.542641] NMI watchdog enabled, takes one hw-pmu counter.
[    1.544568]  #30
[    1.545152] smpboot cpu 30: start_ip =3D 97000
[    1.576835] NMI watchdog enabled, takes one hw-pmu counter.
[    1.578792]  #31
[    1.579400] smpboot cpu 31: start_ip =3D 97000
[    1.611105] NMI watchdog enabled, takes one hw-pmu counter.
[    1.612962] Brought up 32 CPUs
[    1.613997] Total of 32 processors activated (166447.04 BogoMIPS).
[    1.652288] devtmpfs: initialized
[    1.671378] print_constraints: dummy:=20
[    1.673056] Time: 14:28:29  Date: 07/17/14
[    1.674629] NET: Registered protocol family 16
[    1.676758] ACPI FADT declares the system doesn't support PCIe ASPM, s=
o disable it
[    1.680011] ACPI: bus type pci registered
[    1.681461] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc00000=
00-0xcfffffff] (base 0xc0000000)
[    1.684467] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E=
820
[    1.715128] PCI: Using configuration type 1 for base access
[    1.724208] bio: create slab <bio-0> at 0
[    1.727029] ACPI: EC: Look up EC in DSDT
[    1.738070] ACPI: Interpreter enabled
[    1.739932] ACPI: (supports S0 S4 S5)
[    1.741502] ACPI: Using IOAPIC for interrupt routing
[    1.748758] ACPI: No dock devices found.
[    1.750147] HEST: Table parsing has been initialized.
[    1.752173] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3Dnocrs" and report a bug
[    1.755108] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    1.757132] pci_root PNP0A08:00: host bridge window [mem 0xf0000000-0x=
f7ffffff]
[    1.759525] pci_root PNP0A08:00: host bridge window [mem 0xf0000000-0x=
f7ffffff]
[    1.761846] pci_root PNP0A08:00: host bridge window [io  0x1000-0x7fff=
]
[    1.763982] pci_root PNP0A08:00: host bridge window [io  0x0000-0x03af=
]
[    1.766064] pci_root PNP0A08:00: host bridge window [io  0x03e0-0x0cf7=
]
[    1.768554] pci_root PNP0A08:00: host bridge window [io  0x0d00-0x0fff=
]
[    1.771161] pci_root PNP0A08:00: host bridge window [mem 0xfed00000-0x=
fed03fff]
[    1.773505] pci_root PNP0A08:00: host bridge window [mem 0xfed40000-0x=
fed44fff]
[    1.775962] pci_root PNP0A08:00: host bridge window [io  0x03b0-0x03bb=
]
[    1.779131] pci_root PNP0A08:00: host bridge window [io  0x03c0-0x03df=
]
[    1.781353] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x=
000bffff]
[    1.784097] pci_root PNP0A08:00: host bridge window expanded to [mem 0=
xf0000000-0xf7ffffff]; [mem 0xf0000000-0xf7ffffff] ignored
[    1.787711] pci 0000:00:00.0: [8086:3c00] type 0 class 0x000600
[    1.787765] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.787768] pci 0000:00:00.0: PME# disabled
[    1.787793] pci 0000:00:01.0: [8086:3c02] type 1 class 0x000604
[    1.787853] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.787856] pci 0000:00:01.0: PME# disabled
[    1.787882] pci 0000:00:01.1: [8086:3c03] type 1 class 0x000604
[    1.787941] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    1.787945] pci 0000:00:01.1: PME# disabled
[    1.787978] pci 0000:00:02.0: [8086:3c04] type 1 class 0x000604
[    1.788037] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.788040] pci 0000:00:02.0: PME# disabled
[    1.788065] pci 0000:00:02.1: [8086:3c05] type 1 class 0x000604
[    1.788124] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    1.788127] pci 0000:00:02.1: PME# disabled
[    1.788155] pci 0000:00:02.2: [8086:3c06] type 1 class 0x000604
[    1.788214] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    1.788217] pci 0000:00:02.2: PME# disabled
[    1.788243] pci 0000:00:02.3: [8086:3c07] type 1 class 0x000604
[    1.788302] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    1.788305] pci 0000:00:02.3: PME# disabled
[    1.788335] pci 0000:00:03.0: [8086:3c08] type 1 class 0x000604
[    1.788394] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.788397] pci 0000:00:03.0: PME# disabled
[    1.788422] pci 0000:00:03.1: [8086:3c09] type 1 class 0x000604
[    1.788481] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    1.788484] pci 0000:00:03.1: PME# disabled
[    1.788511] pci 0000:00:03.2: [8086:3c0a] type 1 class 0x000604
[    1.788570] pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
[    1.788573] pci 0000:00:03.2: PME# disabled
[    1.788607] pci 0000:00:03.3: [8086:3c0b] type 1 class 0x000604
[    1.788666] pci 0000:00:03.3: PME# supported from D0 D3hot D3cold
[    1.788669] pci 0000:00:03.3: PME# disabled
[    1.788698] pci 0000:00:04.0: [8086:3c20] type 0 class 0x000880
[    1.788711] pci 0000:00:04.0: reg 10: [mem 0xf6cf0000-0xf6cf3fff 64bit=
]
[    1.788786] pci 0000:00:04.1: [8086:3c21] type 0 class 0x000880
[    1.788798] pci 0000:00:04.1: reg 10: [mem 0xf6ce0000-0xf6ce3fff 64bit=
]
[    1.788872] pci 0000:00:04.2: [8086:3c22] type 0 class 0x000880
[    1.788885] pci 0000:00:04.2: reg 10: [mem 0xf6cd0000-0xf6cd3fff 64bit=
]
[    1.788961] pci 0000:00:04.3: [8086:3c23] type 0 class 0x000880
[    1.788974] pci 0000:00:04.3: reg 10: [mem 0xf6cc0000-0xf6cc3fff 64bit=
]
[    1.789048] pci 0000:00:04.4: [8086:3c24] type 0 class 0x000880
[    1.789061] pci 0000:00:04.4: reg 10: [mem 0xf6cb0000-0xf6cb3fff 64bit=
]
[    1.789135] pci 0000:00:04.5: [8086:3c25] type 0 class 0x000880
[    1.789148] pci 0000:00:04.5: reg 10: [mem 0xf6ca0000-0xf6ca3fff 64bit=
]
[    1.789222] pci 0000:00:04.6: [8086:3c26] type 0 class 0x000880
[    1.789234] pci 0000:00:04.6: reg 10: [mem 0xf6c90000-0xf6c93fff 64bit=
]
[    1.789309] pci 0000:00:04.7: [8086:3c27] type 0 class 0x000880
[    1.789322] pci 0000:00:04.7: reg 10: [mem 0xf6c80000-0xf6c83fff 64bit=
]
[    1.789394] pci 0000:00:05.0: [8086:3c28] type 0 class 0x000880
[    1.789470] pci 0000:00:05.2: [8086:3c2a] type 0 class 0x000880
[    1.789540] pci 0000:00:05.4: [8086:3c2c] type 0 class 0x000800
[    1.789552] pci 0000:00:05.4: reg 10: [mem 0xf6c70000-0xf6c70fff]
[    1.789626] pci 0000:00:11.0: [8086:1d3e] type 1 class 0x000604
[    1.789714] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[    1.789718] pci 0000:00:11.0: PME# disabled
[    1.789770] pci 0000:00:1a.0: [8086:1d2d] type 0 class 0x000c03
[    1.789789] pci 0000:00:1a.0: reg 10: [mem 0xf6c60000-0xf6c603ff]
[    1.789875] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.789879] pci 0000:00:1a.0: PME# disabled
[    1.789901] pci 0000:00:1c.0: [8086:1d10] type 1 class 0x000604
[    1.789976] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.789979] pci 0000:00:1c.0: PME# disabled
[    1.790008] pci 0000:00:1c.7: [8086:1d1e] type 1 class 0x000604
[    1.790075] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    1.790078] pci 0000:00:1c.7: PME# disabled
[    1.790104] pci 0000:00:1d.0: [8086:1d26] type 0 class 0x000c03
[    1.790124] pci 0000:00:1d.0: reg 10: [mem 0xf6c50000-0xf6c503ff]
[    1.790210] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.790213] pci 0000:00:1d.0: PME# disabled
[    1.790232] pci 0000:00:1e.0: [8086:244e] type 1 class 0x000604
[    1.790292] pci 0000:00:1f.0: [8086:1d41] type 0 class 0x000601
[    1.790440] pci 0000:00:01.0: PCI bridge to [bus 11-11]
[    1.792116] pci 0000:00:01.0:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.792119] pci 0000:00:01.0:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.792124] pci 0000:00:01.0:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.792161] pci 0000:00:01.1: PCI bridge to [bus 02-02]
[    1.793862] pci 0000:00:01.1:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.793865] pci 0000:00:01.1:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.793870] pci 0000:00:01.1:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.793935] pci 0000:04:00.0: [19a2:0710] type 0 class 0x000200
[    1.793950] pci 0000:04:00.0: reg 10: [mem 0xf7ff0000-0xf7ff3fff 64bit=
]
[    1.793962] pci 0000:04:00.0: reg 18: [mem 0xf7fc0000-0xf7fdffff 64bit=
]
[    1.793974] pci 0000:04:00.0: reg 20: [mem 0xf7fa0000-0xf7fbffff 64bit=
]
[    1.793983] pci 0000:04:00.0: reg 30: [mem 0x00000000-0x0003ffff pref]
[    1.794024] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    1.794028] pci 0000:04:00.0: PME# disabled
[    1.794069] pci 0000:04:00.1: [19a2:0710] type 0 class 0x000200
[    1.794084] pci 0000:04:00.1: reg 10: [mem 0xf7f90000-0xf7f93fff 64bit=
]
[    1.794096] pci 0000:04:00.1: reg 18: [mem 0xf7f60000-0xf7f7ffff 64bit=
]
[    1.794108] pci 0000:04:00.1: reg 20: [mem 0xf7f40000-0xf7f5ffff 64bit=
]
[    1.794117] pci 0000:04:00.1: reg 30: [mem 0x00000000-0x0003ffff pref]
[    1.794157] pci 0000:04:00.1: PME# supported from D3hot D3cold
[    1.794161] pci 0000:04:00.1: PME# disabled
[    1.794195] pci 0000:04:00.2: [19a2:0712] type 0 class 0x000180
[    1.794210] pci 0000:04:00.2: reg 10: [mem 0xf7f30000-0xf7f33fff 64bit=
]
[    1.794222] pci 0000:04:00.2: reg 18: [mem 0xf7f00000-0xf7f1ffff 64bit=
]
[    1.794235] pci 0000:04:00.2: reg 20: [mem 0xf7ee0000-0xf7efffff 64bit=
]
[    1.794243] pci 0000:04:00.2: reg 30: [mem 0x00000000-0x0003ffff pref]
[    1.794284] pci 0000:04:00.2: PME# supported from D3hot D3cold
[    1.794287] pci 0000:04:00.2: PME# disabled
[    1.794321] pci 0000:04:00.3: [19a2:0712] type 0 class 0x000180
[    1.794336] pci 0000:04:00.3: reg 10: [mem 0xf7ed0000-0xf7ed3fff 64bit=
]
[    1.794349] pci 0000:04:00.3: reg 18: [mem 0xf7ea0000-0xf7ebffff 64bit=
]
[    1.794361] pci 0000:04:00.3: reg 20: [mem 0xf7e80000-0xf7e9ffff 64bit=
]
[    1.794369] pci 0000:04:00.3: reg 30: [mem 0x00000000-0x0003ffff pref]
[    1.794410] pci 0000:04:00.3: PME# supported from D3hot D3cold
[    1.794413] pci 0000:04:00.3: PME# disabled
[    1.801474] pci 0000:00:02.0: PCI bridge to [bus 04-04]
[    1.803186] pci 0000:00:02.0:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.803190] pci 0000:00:02.0:   bridge window [mem 0xf7d00000-0xf7ffff=
ff]
[    1.803195] pci 0000:00:02.0:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.803232] pci 0000:00:02.1: PCI bridge to [bus 12-12]
[    1.804853] pci 0000:00:02.1:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.804857] pci 0000:00:02.1:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.804861] pci 0000:00:02.1:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.804923] pci 0000:03:00.0: [103c:323b] type 0 class 0x000104
[    1.804933] pci 0000:03:00.0: reg 10: [mem 0xf7c00000-0xf7cfffff 64bit=
]
[    1.804941] pci 0000:03:00.0: reg 18: [mem 0xf7bf0000-0xf7bf03ff 64bit=
]
[    1.804947] pci 0000:03:00.0: reg 20: [io  0x4000-0x40ff]
[    1.804956] pci 0000:03:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[    1.804982] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    1.804984] pci 0000:03:00.0: PME# disabled
[    1.809438] pci 0000:00:02.2: PCI bridge to [bus 03-03]
[    1.812241] pci 0000:00:02.2:   bridge window [io  0x4000-0x4fff]
[    1.812244] pci 0000:00:02.2:   bridge window [mem 0xf7b00000-0xf7cfff=
ff]
[    1.812249] pci 0000:00:02.2:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.812287] pci 0000:00:02.3: PCI bridge to [bus 13-13]
[    1.814529] pci 0000:00:02.3:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.814532] pci 0000:00:02.3:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.814537] pci 0000:00:02.3:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.814589] pci 0000:05:00.0: [14e4:168e] type 0 class 0x000200
[    1.814601] pci 0000:05:00.0: reg 10: [mem 0xf6000000-0xf67fffff 64bit=
 pref]
[    1.814611] pci 0000:05:00.0: reg 18: [mem 0xf5800000-0xf5ffffff 64bit=
 pref]
[    1.814621] pci 0000:05:00.0: reg 20: [mem 0xf57f0000-0xf57fffff 64bit=
 pref]
[    1.814628] pci 0000:05:00.0: reg 30: [mem 0x00000000-0x0003ffff pref]
[    1.814665] pci 0000:05:00.0: PME# supported from D0 D3hot
[    1.814668] pci 0000:05:00.0: PME# disabled
[    1.814703] pci 0000:05:00.1: [14e4:168e] type 0 class 0x000200
[    1.814715] pci 0000:05:00.1: reg 10: [mem 0xf4800000-0xf4ffffff 64bit=
 pref]
[    1.814725] pci 0000:05:00.1: reg 18: [mem 0xf4000000-0xf47fffff 64bit=
 pref]
[    1.814735] pci 0000:05:00.1: reg 20: [mem 0xf3ff0000-0xf3ffffff 64bit=
 pref]
[    1.814742] pci 0000:05:00.1: reg 30: [mem 0x00000000-0x0003ffff pref]
[    1.814779] pci 0000:05:00.1: PME# supported from D0 D3hot
[    1.814782] pci 0000:05:00.1: PME# disabled
[    1.821408] pci 0000:00:03.0: PCI bridge to [bus 05-05]
[    1.823115] pci 0000:00:03.0:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.823119] pci 0000:00:03.0:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.823124] pci 0000:00:03.0:   bridge window [mem 0xf3f00000-0xf67fff=
ff 64bit pref]
[    1.823162] pci 0000:00:03.1: PCI bridge to [bus 14-14]
[    1.825470] pci 0000:00:03.1:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.825474] pci 0000:00:03.1:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.825479] pci 0000:00:03.1:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.825516] pci 0000:00:03.2: PCI bridge to [bus 15-15]
[    1.827171] pci 0000:00:03.2:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.827174] pci 0000:00:03.2:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.827179] pci 0000:00:03.2:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.827238] pci 0000:00:03.3: PCI bridge to [bus 16-16]
[    1.829252] pci 0000:00:03.3:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.829255] pci 0000:00:03.3:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.829260] pci 0000:00:03.3:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.829324] pci 0000:00:11.0: PCI bridge to [bus 18-18]
[    1.830952] pci 0000:00:11.0:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.830956] pci 0000:00:11.0:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.830962] pci 0000:00:11.0:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.831021] pci 0000:00:1c.0: PCI bridge to [bus 08-08]
[    1.832632] pci 0000:00:1c.0:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.832636] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.832642] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.832718] pci 0000:01:00.0: [103c:3306] type 0 class 0x000880
[    1.832737] pci 0000:01:00.0: reg 10: [io  0x3000-0x30ff]
[    1.832751] pci 0000:01:00.0: reg 14: [mem 0xf7af0000-0xf7af01ff]
[    1.832765] pci 0000:01:00.0: reg 18: [io  0x3400-0x34ff]
[    1.832923] pci 0000:01:00.1: [102b:0533] type 0 class 0x000300
[    1.832942] pci 0000:01:00.1: reg 10: [mem 0xf2000000-0xf2ffffff pref]
[    1.832956] pci 0000:01:00.1: reg 14: [mem 0xf7ae0000-0xf7ae3fff]
[    1.832970] pci 0000:01:00.1: reg 18: [mem 0xf7000000-0xf77fffff]
[    1.833134] pci 0000:01:00.2: [103c:3307] type 0 class 0x000880
[    1.833153] pci 0000:01:00.2: reg 10: [io  0x3800-0x38ff]
[    1.833167] pci 0000:01:00.2: reg 14: [mem 0xf6ff0000-0xf6ff00ff]
[    1.833181] pci 0000:01:00.2: reg 18: [mem 0xf6e00000-0xf6efffff]
[    1.833195] pci 0000:01:00.2: reg 1c: [mem 0xf6d80000-0xf6dfffff]
[    1.833209] pci 0000:01:00.2: reg 20: [mem 0xf6d70000-0xf6d77fff]
[    1.833222] pci 0000:01:00.2: reg 24: [mem 0xf6d60000-0xf6d67fff]
[    1.833237] pci 0000:01:00.2: reg 30: [mem 0x00000000-0x0000ffff pref]
[    1.833303] pci 0000:01:00.2: PME# supported from D0 D3hot D3cold
[    1.833307] pci 0000:01:00.2: PME# disabled
[    1.833349] pci 0000:01:00.4: [103c:3300] type 0 class 0x000c03
[    1.833420] pci 0000:01:00.4: reg 20: [io  0x3c00-0x3c1f]
[    1.841383] pci 0000:00:1c.7: PCI bridge to [bus 01-01]
[    1.843063] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    1.843066] pci 0000:00:1c.7:   bridge window [mem 0xf6d00000-0xf7afff=
ff]
[    1.843071] pci 0000:00:1c.7:   bridge window [mem 0xf2000000-0xf2ffff=
ff 64bit pref]
[    1.843135] pci 0000:00:1e.0: PCI bridge to [bus 17-17] (subtractive d=
ecode)
[    1.846050] pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.846054] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.846059] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.846061] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xf7ffff=
ff] (subtractive decode)
[    1.846064] pci 0000:00:1e.0:   bridge window [io  0x1000-0x7fff] (sub=
tractive decode)
[    1.846066] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af] (sub=
tractive decode)
[    1.846068] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7] (sub=
tractive decode)
[    1.846070] pci 0000:00:1e.0:   bridge window [io  0x0d00-0x0fff] (sub=
tractive decode)
[    1.846072] pci 0000:00:1e.0:   bridge window [mem 0xfed00000-0xfed03f=
ff] (subtractive decode)
[    1.846074] pci 0000:00:1e.0:   bridge window [mem 0xfed40000-0xfed44f=
ff] (subtractive decode)
[    1.846076] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03bb] (sub=
tractive decode)
[    1.846078] pci 0000:00:1e.0:   bridge window [io  0x03c0-0x03df] (sub=
tractive decode)
[    1.846080] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bff=
ff] (subtractive decode)
[    1.846131] pci_bus 0000:00: on NUMA node 0 (pxm 0)
[    1.846135] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.846302] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.IPT1._PRT]
[    1.846497] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.IPT8._PRT]
[    1.846548] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.VRP1._PRT]
[    1.846593] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PT1A._PRT]
[    1.846637] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PT1B._PRT]
[    1.846679] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PT2A._PRT]
[    1.846759] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PT2B._PRT]
[    1.846804] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PT2C._PRT]
[    1.846847] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PT2D._PRT]
[    1.846890] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PT3A._PRT]
[    1.847059] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PT3B._PRT]
[    1.847101] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PT3C._PRT]
[    1.847144] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PT3D._PRT]
[    1.847246]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    1.849112]  pci0000:00: ACPI _OSC request failed (AE_SUPPORT), return=
ed control mask: 0x00
[    1.851765] ACPI _OSC control for PCIe not granted, disabling ASPM
[    1.860864] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 20-3f])
[    1.862942] pci_root PNP0A08:01: host bridge window [mem 0xf8000000-0x=
fbffffff]
[    1.865349] pci_root PNP0A08:01: host bridge window [mem 0xf8000000-0x=
fbffffff]
[    1.867764] pci_root PNP0A08:01: host bridge window [io  0x8000-0xffff=
]
[    1.869967] pci_root PNP0A08:01: host bridge window expanded to [mem 0=
xf8000000-0xfbffffff]; [mem 0xf8000000-0xfbffffff] ignored
[    1.873517] pci 0000:20:00.0: [8086:3c01] type 1 class 0x000604
[    1.873584] pci 0000:20:00.0: PME# supported from D0 D3hot D3cold
[    1.873588] pci 0000:20:00.0: PME# disabled
[    1.873635] pci 0000:20:01.0: [8086:3c02] type 1 class 0x000604
[    1.873702] pci 0000:20:01.0: PME# supported from D0 D3hot D3cold
[    1.873705] pci 0000:20:01.0: PME# disabled
[    1.873734] pci 0000:20:01.1: [8086:3c03] type 1 class 0x000604
[    1.873800] pci 0000:20:01.1: PME# supported from D0 D3hot D3cold
[    1.873804] pci 0000:20:01.1: PME# disabled
[    1.873839] pci 0000:20:02.0: [8086:3c04] type 1 class 0x000604
[    1.873905] pci 0000:20:02.0: PME# supported from D0 D3hot D3cold
[    1.873908] pci 0000:20:02.0: PME# disabled
[    1.873937] pci 0000:20:02.1: [8086:3c05] type 1 class 0x000604
[    1.874003] pci 0000:20:02.1: PME# supported from D0 D3hot D3cold
[    1.874007] pci 0000:20:02.1: PME# disabled
[    1.874037] pci 0000:20:02.2: [8086:3c06] type 1 class 0x000604
[    1.874103] pci 0000:20:02.2: PME# supported from D0 D3hot D3cold
[    1.874106] pci 0000:20:02.2: PME# disabled
[    1.874136] pci 0000:20:02.3: [8086:3c07] type 1 class 0x000604
[    1.874204] pci 0000:20:02.3: PME# supported from D0 D3hot D3cold
[    1.874207] pci 0000:20:02.3: PME# disabled
[    1.874241] pci 0000:20:03.0: [8086:3c08] type 1 class 0x000604
[    1.874307] pci 0000:20:03.0: PME# supported from D0 D3hot D3cold
[    1.874310] pci 0000:20:03.0: PME# disabled
[    1.874340] pci 0000:20:03.1: [8086:3c09] type 1 class 0x000604
[    1.874406] pci 0000:20:03.1: PME# supported from D0 D3hot D3cold
[    1.874409] pci 0000:20:03.1: PME# disabled
[    1.874439] pci 0000:20:03.2: [8086:3c0a] type 1 class 0x000604
[    1.874505] pci 0000:20:03.2: PME# supported from D0 D3hot D3cold
[    1.874508] pci 0000:20:03.2: PME# disabled
[    1.874539] pci 0000:20:03.3: [8086:3c0b] type 1 class 0x000604
[    1.874605] pci 0000:20:03.3: PME# supported from D0 D3hot D3cold
[    1.874608] pci 0000:20:03.3: PME# disabled
[    1.874641] pci 0000:20:04.0: [8086:3c20] type 0 class 0x000880
[    1.874655] pci 0000:20:04.0: reg 10: [mem 0xfbff0000-0xfbff3fff 64bit=
]
[    1.874738] pci 0000:20:04.1: [8086:3c21] type 0 class 0x000880
[    1.874752] pci 0000:20:04.1: reg 10: [mem 0xfbfe0000-0xfbfe3fff 64bit=
]
[    1.874835] pci 0000:20:04.2: [8086:3c22] type 0 class 0x000880
[    1.874849] pci 0000:20:04.2: reg 10: [mem 0xfbfd0000-0xfbfd3fff 64bit=
]
[    1.874932] pci 0000:20:04.3: [8086:3c23] type 0 class 0x000880
[    1.874946] pci 0000:20:04.3: reg 10: [mem 0xfbfc0000-0xfbfc3fff 64bit=
]
[    1.875028] pci 0000:20:04.4: [8086:3c24] type 0 class 0x000880
[    1.875042] pci 0000:20:04.4: reg 10: [mem 0xfbfb0000-0xfbfb3fff 64bit=
]
[    1.875125] pci 0000:20:04.5: [8086:3c25] type 0 class 0x000880
[    1.875139] pci 0000:20:04.5: reg 10: [mem 0xfbfa0000-0xfbfa3fff 64bit=
]
[    1.875224] pci 0000:20:04.6: [8086:3c26] type 0 class 0x000880
[    1.875237] pci 0000:20:04.6: reg 10: [mem 0xfbf90000-0xfbf93fff 64bit=
]
[    1.875321] pci 0000:20:04.7: [8086:3c27] type 0 class 0x000880
[    1.875334] pci 0000:20:04.7: reg 10: [mem 0xfbf80000-0xfbf83fff 64bit=
]
[    1.875416] pci 0000:20:05.0: [8086:3c28] type 0 class 0x000880
[    1.875496] pci 0000:20:05.2: [8086:3c2a] type 0 class 0x000880
[    1.875575] pci 0000:20:05.4: [8086:3c2c] type 0 class 0x000800
[    1.875587] pci 0000:20:05.4: reg 10: [mem 0xfbf70000-0xfbf70fff]
[    1.875705] pci 0000:20:00.0: PCI bridge to [bus 2d-2d]
[    1.877439] pci 0000:20:00.0:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.877443] pci 0000:20:00.0:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.877448] pci 0000:20:00.0:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.877489] pci 0000:20:01.0: PCI bridge to [bus 24-24]
[    1.879232] pci 0000:20:01.0:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.879235] pci 0000:20:01.0:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.879241] pci 0000:20:01.0:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.879289] pci 0000:20:01.1: PCI bridge to [bus 25-25]
[    1.880918] pci 0000:20:01.1:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.880922] pci 0000:20:01.1:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.880927] pci 0000:20:01.1:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.880969] pci 0000:20:02.0: PCI bridge to [bus 26-26]
[    1.883913] pci 0000:20:02.0:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.883917] pci 0000:20:02.0:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.883922] pci 0000:20:02.0:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.883963] pci 0000:20:02.1: PCI bridge to [bus 27-27]
[    1.885634] pci 0000:20:02.1:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.885638] pci 0000:20:02.1:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.885643] pci 0000:20:02.1:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.885684] pci 0000:20:02.2: PCI bridge to [bus 28-28]
[    1.888409] pci 0000:20:02.2:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.888413] pci 0000:20:02.2:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.888419] pci 0000:20:02.2:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.888460] pci 0000:20:02.3: PCI bridge to [bus 29-29]
[    1.890163] pci 0000:20:02.3:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.890167] pci 0000:20:02.3:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.890172] pci 0000:20:02.3:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.890230] pci 0000:21:00.0: [14e4:168e] type 0 class 0x000200
[    1.890243] pci 0000:21:00.0: reg 10: [mem 0xfb000000-0xfb7fffff 64bit=
 pref]
[    1.890253] pci 0000:21:00.0: reg 18: [mem 0xfa800000-0xfaffffff 64bit=
 pref]
[    1.890264] pci 0000:21:00.0: reg 20: [mem 0xfa7f0000-0xfa7fffff 64bit=
 pref]
[    1.890271] pci 0000:21:00.0: reg 30: [mem 0x00000000-0x0003ffff pref]
[    1.890312] pci 0000:21:00.0: PME# supported from D0 D3hot
[    1.890315] pci 0000:21:00.0: PME# disabled
[    1.890354] pci 0000:21:00.1: [14e4:168e] type 0 class 0x000200
[    1.890367] pci 0000:21:00.1: reg 10: [mem 0xf9800000-0xf9ffffff 64bit=
 pref]
[    1.890377] pci 0000:21:00.1: reg 18: [mem 0xf9000000-0xf97fffff 64bit=
 pref]
[    1.890388] pci 0000:21:00.1: reg 20: [mem 0xf8ff0000-0xf8ffffff 64bit=
 pref]
[    1.890396] pci 0000:21:00.1: reg 30: [mem 0x00000000-0x0003ffff pref]
[    1.890436] pci 0000:21:00.1: PME# supported from D0 D3hot
[    1.890439] pci 0000:21:00.1: PME# disabled
[    1.897246] pci 0000:20:03.0: PCI bridge to [bus 21-21]
[    1.899826] pci 0000:20:03.0:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.899830] pci 0000:20:03.0:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.899835] pci 0000:20:03.0:   bridge window [mem 0xf8f00000-0xfb7fff=
ff 64bit pref]
[    1.899877] pci 0000:20:03.1: PCI bridge to [bus 2a-2a]
[    1.901677] pci 0000:20:03.1:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.901680] pci 0000:20:03.1:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.901686] pci 0000:20:03.1:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.901727] pci 0000:20:03.2: PCI bridge to [bus 2b-2b]
[    1.903426] pci 0000:20:03.2:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.903429] pci 0000:20:03.2:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.903434] pci 0000:20:03.2:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.903475] pci 0000:20:03.3: PCI bridge to [bus 2c-2c]
[    1.905122] pci 0000:20:03.3:   bridge window [io  0xf000-0x0000] (dis=
abled)
[    1.905125] pci 0000:20:03.3:   bridge window [mem 0xfff00000-0x000fff=
ff] (disabled)
[    1.905131] pci 0000:20:03.3:   bridge window [mem 0xfff00000-0x000fff=
ff pref] (disabled)
[    1.905182] pci_bus 0000:20: on NUMA node 1 (pxm 1)
[    1.905185] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
[    1.905271] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PT1A._PRT]
[    1.905316] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PT1B._PRT]
[    1.905360] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PT2A._PRT]
[    1.905402] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PT2B._PRT]
[    1.905444] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PT2C._PRT]
[    1.905486] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PT2D._PRT]
[    1.905528] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PT3A._PRT]
[    1.905960] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PT3B._PRT]
[    1.906004] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PT3C._PRT]
[    1.906062] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PT3D._PRT]
[    1.906157]  pci0000:20: Requesting ACPI _OSC control (0x1d)
[    1.908187]  pci0000:20: ACPI _OSC request failed (AE_SUPPORT), return=
ed control mask: 0x00
[    1.910853] ACPI _OSC control for PCIe not granted, disabling ASPM
[    1.915916] ACPI: PCI Interrupt Link [LNKA] (IRQs *5 7 10 11)
[    1.918264] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *7 10 11)
[    1.920644] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 *10 11)
[    1.923702] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 *10 11)
[    1.926091] ACPI: PCI Interrupt Link [LNKE] (IRQs *5 7 10 11)
[    1.928635] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 *7 10 11)
[    1.931020] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 7 10 11) *0, disab=
led.
[    1.935497] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 7 10 11) *0, disab=
led.
[    1.938883] vgaarb: device added: PCI:0000:01:00.1,decodes=3Dio+mem,ow=
ns=3Dio+mem,locks=3Dnone
[    1.941590] vgaarb: loaded
[    1.942803] PCI: Using ACPI for IRQ routing
[    1.945028] PCI: Discovered peer bus 1f
[    1.946347] pci 0000:1f:08.0: [8086:3c80] type 0 class 0x000880
[    1.946386] pci 0000:1f:08.3: [8086:3c83] type 0 class 0x000880
[    1.946431] pci 0000:1f:08.4: [8086:3c84] type 0 class 0x000880
[    1.946481] pci 0000:1f:09.0: [8086:3c90] type 0 class 0x000880
[    1.946517] pci 0000:1f:09.3: [8086:3c93] type 0 class 0x000880
[    1.946563] pci 0000:1f:09.4: [8086:3c94] type 0 class 0x000880
[    1.946613] pci 0000:1f:0a.0: [8086:3cc0] type 0 class 0x000880
[    1.946644] pci 0000:1f:0a.1: [8086:3cc1] type 0 class 0x000880
[    1.946674] pci 0000:1f:0a.2: [8086:3cc2] type 0 class 0x000880
[    1.946704] pci 0000:1f:0a.3: [8086:3cd0] type 0 class 0x000880
[    1.946736] pci 0000:1f:0b.0: [8086:3ce0] type 0 class 0x000880
[    1.946765] pci 0000:1f:0b.3: [8086:3ce3] type 0 class 0x000880
[    1.946795] pci 0000:1f:0c.0: [8086:3ce8] type 0 class 0x000880
[    1.946824] pci 0000:1f:0c.1: [8086:3ce8] type 0 class 0x000880
[    1.946852] pci 0000:1f:0c.2: [8086:3ce8] type 0 class 0x000880
[    1.946881] pci 0000:1f:0c.3: [8086:3ce8] type 0 class 0x000880
[    1.946911] pci 0000:1f:0c.6: [8086:3cf4] type 0 class 0x000880
[    1.946940] pci 0000:1f:0c.7: [8086:3cf6] type 0 class 0x000880
[    1.946969] pci 0000:1f:0d.0: [8086:3ce8] type 0 class 0x000880
[    1.947000] pci 0000:1f:0d.1: [8086:3ce8] type 0 class 0x000880
[    1.947029] pci 0000:1f:0d.2: [8086:3ce8] type 0 class 0x000880
[    1.947059] pci 0000:1f:0d.3: [8086:3ce8] type 0 class 0x000880
[    1.947088] pci 0000:1f:0d.6: [8086:3cf5] type 0 class 0x000880
[    1.947118] pci 0000:1f:0e.0: [8086:3ca0] type 0 class 0x000880
[    1.947152] pci 0000:1f:0e.1: [8086:3c46] type 0 class 0x001101
[    1.947191] pci 0000:1f:0f.0: [8086:3ca8] type 0 class 0x000880
[    1.947236] pci 0000:1f:0f.1: [8086:3c71] type 0 class 0x000880
[    1.947280] pci 0000:1f:0f.2: [8086:3caa] type 0 class 0x000880
[    1.947324] pci 0000:1f:0f.3: [8086:3cab] type 0 class 0x000880
[    1.947368] pci 0000:1f:0f.4: [8086:3cac] type 0 class 0x000880
[    1.947412] pci 0000:1f:0f.5: [8086:3cad] type 0 class 0x000880
[    1.947455] pci 0000:1f:0f.6: [8086:3cae] type 0 class 0x000880
[    1.947492] pci 0000:1f:10.0: [8086:3cb0] type 0 class 0x000880
[    1.947537] pci 0000:1f:10.1: [8086:3cb1] type 0 class 0x000880
[    1.947581] pci 0000:1f:10.2: [8086:3cb2] type 0 class 0x000880
[    1.947626] pci 0000:1f:10.3: [8086:3cb3] type 0 class 0x000880
[    1.947670] pci 0000:1f:10.4: [8086:3cb4] type 0 class 0x000880
[    1.947715] pci 0000:1f:10.5: [8086:3cb5] type 0 class 0x000880
[    1.947760] pci 0000:1f:10.6: [8086:3cb6] type 0 class 0x000880
[    1.947805] pci 0000:1f:10.7: [8086:3cb7] type 0 class 0x000880
[    1.947847] pci 0000:1f:11.0: [8086:3cb8] type 0 class 0x000880
[    1.947887] pci 0000:1f:13.0: [8086:3ce4] type 0 class 0x000880
[    1.947916] pci 0000:1f:13.1: [8086:3c43] type 0 class 0x001101
[    1.947947] pci 0000:1f:13.4: [8086:3ce6] type 0 class 0x001101
[    1.947976] pci 0000:1f:13.5: [8086:3c44] type 0 class 0x001101
[    1.948006] pci 0000:1f:13.6: [8086:3c45] type 0 class 0x000880
[    1.949189] PCI: Discovered peer bus 3f
[    1.950518] pci 0000:3f:08.0: [8086:3c80] type 0 class 0x000880
[    1.950563] pci 0000:3f:08.3: [8086:3c83] type 0 class 0x000880
[    1.950615] pci 0000:3f:08.4: [8086:3c84] type 0 class 0x000880
[    1.950674] pci 0000:3f:09.0: [8086:3c90] type 0 class 0x000880
[    1.950717] pci 0000:3f:09.3: [8086:3c93] type 0 class 0x000880
[    1.950769] pci 0000:3f:09.4: [8086:3c94] type 0 class 0x000880
[    1.950826] pci 0000:3f:0a.0: [8086:3cc0] type 0 class 0x000880
[    1.950862] pci 0000:3f:0a.1: [8086:3cc1] type 0 class 0x000880
[    1.950897] pci 0000:3f:0a.2: [8086:3cc2] type 0 class 0x000880
[    1.950933] pci 0000:3f:0a.3: [8086:3cd0] type 0 class 0x000880
[    1.950970] pci 0000:3f:0b.0: [8086:3ce0] type 0 class 0x000880
[    1.951004] pci 0000:3f:0b.3: [8086:3ce3] type 0 class 0x000880
[    1.951043] pci 0000:3f:0c.0: [8086:3ce8] type 0 class 0x000880
[    1.951077] pci 0000:3f:0c.1: [8086:3ce8] type 0 class 0x000880
[    1.951114] pci 0000:3f:0c.2: [8086:3ce8] type 0 class 0x000880
[    1.951149] pci 0000:3f:0c.3: [8086:3ce8] type 0 class 0x000880
[    1.951185] pci 0000:3f:0c.6: [8086:3cf4] type 0 class 0x000880
[    1.951221] pci 0000:3f:0c.7: [8086:3cf6] type 0 class 0x000880
[    1.951255] pci 0000:3f:0d.0: [8086:3ce8] type 0 class 0x000880
[    1.951290] pci 0000:3f:0d.1: [8086:3ce8] type 0 class 0x000880
[    1.951325] pci 0000:3f:0d.2: [8086:3ce8] type 0 class 0x000880
[    1.951360] pci 0000:3f:0d.3: [8086:3ce8] type 0 class 0x000880
[    1.951396] pci 0000:3f:0d.6: [8086:3cf5] type 0 class 0x000880
[    1.951432] pci 0000:3f:0e.0: [8086:3ca0] type 0 class 0x000880
[    1.951474] pci 0000:3f:0e.1: [8086:3c46] type 0 class 0x001101
[    1.951523] pci 0000:3f:0f.0: [8086:3ca8] type 0 class 0x000880
[    1.951575] pci 0000:3f:0f.1: [8086:3c71] type 0 class 0x000880
[    1.951627] pci 0000:3f:0f.2: [8086:3caa] type 0 class 0x000880
[    1.951679] pci 0000:3f:0f.3: [8086:3cab] type 0 class 0x000880
[    1.951731] pci 0000:3f:0f.4: [8086:3cac] type 0 class 0x000880
[    1.951782] pci 0000:3f:0f.5: [8086:3cad] type 0 class 0x000880
[    1.951833] pci 0000:3f:0f.6: [8086:3cae] type 0 class 0x000880
[    1.951876] pci 0000:3f:10.0: [8086:3cb0] type 0 class 0x000880
[    1.951928] pci 0000:3f:10.1: [8086:3cb1] type 0 class 0x000880
[    1.951981] pci 0000:3f:10.2: [8086:3cb2] type 0 class 0x000880
[    1.952034] pci 0000:3f:10.3: [8086:3cb3] type 0 class 0x000880
[    1.952087] pci 0000:3f:10.4: [8086:3cb4] type 0 class 0x000880
[    1.952140] pci 0000:3f:10.5: [8086:3cb5] type 0 class 0x000880
[    1.952194] pci 0000:3f:10.6: [8086:3cb6] type 0 class 0x000880
[    1.952247] pci 0000:3f:10.7: [8086:3cb7] type 0 class 0x000880
[    1.952297] pci 0000:3f:11.0: [8086:3cb8] type 0 class 0x000880
[    1.952344] pci 0000:3f:13.0: [8086:3ce4] type 0 class 0x000880
[    1.952378] pci 0000:3f:13.1: [8086:3c43] type 0 class 0x001101
[    1.952415] pci 0000:3f:13.4: [8086:3ce6] type 0 class 0x001101
[    1.952450] pci 0000:3f:13.5: [8086:3c44] type 0 class 0x001101
[    1.952485] pci 0000:3f:13.6: [8086:3c45] type 0 class 0x000880
[    1.958521] PCI: pci_cache_line_size set to 64 bytes
[    1.958884] reserve RAM buffer: 000000000009cc00 - 000000000009ffff=20
[    1.958887] reserve RAM buffer: 00000000bddac000 - 00000000bfffffff=20
[    1.958890] reserve RAM buffer: 000000203ffff000 - 000000203fffffff=20
[    1.958998] NetLabel: Initializing
[    1.961165] NetLabel:  domain hash size =3D 128
[    1.962615] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    1.964207] NetLabel:  unlabeled traffic allowed by default
[    1.965972] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.968694] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.972792] hpet: hpet_late_init(1007):
[    1.974078] hpet: ID: 0x8086a701, PERIOD: 0x429b17f
[    1.975687] hpet: CFG: 0x3, STATUS: 0x0
[    1.976950] hpet: COUNTER_l: 0x1d62600, COUNTER_h: 0x0
[    1.978666] hpet: T0: CFG_l: 0x8138, CFG_h: 0xf00000
[    1.980259] hpet: T0: CMP_l: 0x1d70d0f, CMP_h: 0x0
[    1.981838] hpet: T0 ROUTE_l: 0x0, ROUTE_h: 0x0
[    1.983277] hpet: T1: CFG_l: 0x8000, CFG_h: 0xf00000
[    1.984837] hpet: T1: CMP_l: 0xffffffff, CMP_h: 0x0
[    1.986373] hpet: T1 ROUTE_l: 0x0, ROUTE_h: 0x0
[    1.987920] hpet: T2: CFG_l: 0x8000, CFG_h: 0xf00800
[    1.989557] hpet: T2: CMP_l: 0x3aa41ce, CMP_h: 0x0
[    1.991082] hpet: T2 ROUTE_l: 0x0, ROUTE_h: 0x0
[    1.992509] hpet: T3: CFG_l: 0x8000, CFG_h: 0xf01000
[    1.994081] hpet: T3: CMP_l: 0xffffffff, CMP_h: 0x0
[    1.995608] hpet: T3 ROUTE_l: 0x0, ROUTE_h: 0x0
[    1.997083] hpet: T4: CFG_l: 0xc000, CFG_h: 0x0
[    1.998627] hpet: T4: CMP_l: 0xffffffff, CMP_h: 0x0
[    2.000466] hpet: T4 ROUTE_l: 0x0, ROUTE_h: 0x0
[    2.001985] hpet: T5: CFG_l: 0xc000, CFG_h: 0x0
[    2.003411] hpet: T5: CMP_l: 0xffffffff, CMP_h: 0x0
[    2.005086] hpet: T5 ROUTE_l: 0x0, ROUTE_h: 0x0
[    2.006529] hpet: T6: CFG_l: 0xc000, CFG_h: 0x0
[    2.007979] hpet: T6: CMP_l: 0xffffffff, CMP_h: 0x0
[    2.009669] hpet: T6 ROUTE_l: 0x0, ROUTE_h: 0x0
[    2.012596] hpet: T7: CFG_l: 0xc000, CFG_h: 0x0
[    2.014078] hpet: T7: CMP_l: 0xffffffff, CMP_h: 0x0
[    2.015661] hpet: T7 ROUTE_l: 0x0, ROUTE_h: 0x0
[    2.017198] Switching to clocksource hpet
[    2.021696] AppArmor: AppArmor Filesystem Enabled
[    2.023340] pnp: PnP ACPI init
[    2.024432] ACPI: bus type pnp registered
[    2.025908] pnp 00:00: [bus 00-1f]
[    2.025913] pnp 00:00: [mem 0xf0000000-0xf7ffffff window]
[    2.025917] pnp 00:00: [mem 0xf0000000-0xf7ffffff window]
[    2.025920] pnp 00:00: [io  0x1000-0x7fff window]
[    2.025924] pnp 00:00: [io  0x0000-0x03af window]
[    2.025927] pnp 00:00: [io  0x03e0-0x0cf7 window]
[    2.025931] pnp 00:00: [io  0x0d00-0x0fff window]
[    2.025934] pnp 00:00: [mem 0xfed00000-0xfed03fff window]
[    2.025938] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    2.025941] pnp 00:00: [io  0x03b0-0x03bb window]
[    2.025944] pnp 00:00: [io  0x03c0-0x03df window]
[    2.025948] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    2.026158] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 =
(active)
[    2.026462] pnp 00:01: [mem 0xf1ffe000-0xf1ffffff]
[    2.026771] system 00:01: [mem 0xf1ffe000-0xf1ffffff] has been reserve=
d
[    2.029024] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    2.029199] pnp 00:02: [io  0x0070-0x0077]
[    2.029202] pnp 00:02: [io  0x0408-0x040f]
[    2.029205] pnp 00:02: [io  0x04d0-0x04d1]
[    2.029208] pnp 00:02: [io  0x0020-0x003f]
[    2.029211] pnp 00:02: [io  0x00a0-0x00bf]
[    2.029214] pnp 00:02: [io  0x0090-0x009f]
[    2.029217] pnp 00:02: [io  0x0050-0x0053]
[    2.029220] pnp 00:02: [io  0x0310-0x0315]
[    2.029224] pnp 00:02: [io  0x0316-0x0317]
[    2.029227] pnp 00:02: [io  0x0700-0x071f]
[    2.029231] pnp 00:02: [io  0x0880-0x08ff]
[    2.029234] pnp 00:02: [io  0x0900-0x097f]
[    2.029237] pnp 00:02: [io  0x0010-0x001f]
[    2.029240] pnp 00:02: [io  0x0cd4-0x0cd7]
[    2.029243] pnp 00:02: [io  0x0cd0-0x0cd3]
[    2.029246] pnp 00:02: [io  0x0f50-0x0f58]
[    2.029249] pnp 00:02: [io  0x00f0]
[    2.029253] pnp 00:02: [io  0x0ca0-0x0ca1]
[    2.029256] pnp 00:02: [io  0x0ca4-0x0ca5]
[    2.029259] pnp 00:02: [mem 0xc0000000-0xcfffffff]
[    2.029263] pnp 00:02: [mem 0xfe000000-0xfebfffff]
[    2.029266] pnp 00:02: [mem 0xfc000000-0xfc000fff]
[    2.029270] pnp 00:02: [mem 0xfed1c000-0xfed1ffff]
[    2.029273] pnp 00:02: [mem 0xfed30000-0xfed3ffff]
[    2.029276] pnp 00:02: [mem 0xfee00000-0xfee00fff]
[    2.029279] pnp 00:02: [mem 0xff800000-0xffffffff]
[    2.029283] pnp 00:02: [io  0x03f8-0x03ff]
[    2.029565] system 00:02: [io  0x0408-0x040f] has been reserved
[    2.031731] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    2.033614] system 00:02: [io  0x0310-0x0315] has been reserved
[    2.035560] system 00:02: [io  0x0316-0x0317] has been reserved
[    2.038443] system 00:02: [io  0x0700-0x071f] has been reserved
[    2.040357] system 00:02: [io  0x0880-0x08ff] has been reserved
[    2.042794] system 00:02: [io  0x0900-0x097f] has been reserved
[    2.044746] system 00:02: [io  0x0cd4-0x0cd7] has been reserved
[    2.047106] system 00:02: [io  0x0cd0-0x0cd3] has been reserved
[    2.049280] system 00:02: [io  0x0f50-0x0f58] has been reserved
[    2.051234] system 00:02: [io  0x0ca0-0x0ca1] has been reserved
[    2.053376] system 00:02: [io  0x0ca4-0x0ca5] has been reserved
[    2.055343] system 00:02: [io  0x03f8-0x03ff] has been reserved
[    2.057426] system 00:02: [mem 0xc0000000-0xcfffffff] has been reserve=
d
[    2.060299] system 00:02: [mem 0xfe000000-0xfebfffff] has been reserve=
d
[    2.062542] system 00:02: [mem 0xfc000000-0xfc000fff] has been reserve=
d
[    2.064653] system 00:02: [mem 0xfed1c000-0xfed1ffff] has been reserve=
d
[    2.066945] system 00:02: [mem 0xfed30000-0xfed3ffff] has been reserve=
d
[    2.069396] system 00:02: [mem 0xfee00000-0xfee00fff] has been reserve=
d
[    2.071710] system 00:02: [mem 0xff800000-0xffffffff] has been reserve=
d
[    2.073953] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    2.073987] pnp 00:03: [io  0x0ca2-0x0ca3]
[    2.074075] pnp 00:03: Plug and Play ACPI device, IDs IPI0001 (active)
[    2.074129] pnp 00:04: [mem 0xfed00000-0xfed003ff]
[    2.074215] pnp 00:04: Plug and Play ACPI device, IDs PNP0103 (active)
[    2.074236] pnp 00:05: [dma 7]
[    2.074239] pnp 00:05: [io  0x0000-0x000f]
[    2.074243] pnp 00:05: [io  0x0080-0x008f]
[    2.074246] pnp 00:05: [io  0x00c0-0x00df]
[    2.074328] pnp 00:05: Plug and Play ACPI device, IDs PNP0200 (active)
[    2.074346] pnp 00:06: [io  0x0061]
[    2.074425] pnp 00:06: Plug and Play ACPI device, IDs PNP0800 (active)
[    2.074444] pnp 00:07: [io  0x002e-0x002f]
[    2.074528] pnp 00:07: Plug and Play ACPI device, IDs PNP0a06 (active)
[    2.074768] pnp 00:08: [irq 3]
[    2.074773] pnp 00:08: [io  0x02f8-0x02ff]
[    2.075010] pnp 00:08: Plug and Play ACPI device, IDs PNP0501 PNP0500 =
(active)
[    2.075033] pnp 00:09: [io  0x0070-0x0071]
[    2.075117] pnp 00:09: Plug and Play ACPI device, IDs PNP0b00 (active)
[    2.075137] pnp 00:0a: [io  0x0060]
[    2.075140] pnp 00:0a: [io  0x0064]
[    2.075154] pnp 00:0a: [irq 1]
[    2.075236] pnp 00:0a: Plug and Play ACPI device, IDs PNP0303 (active)
[    2.075269] pnp 00:0b: [irq 12]
[    2.075354] pnp 00:0b: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e =
(active)
[    2.075692] pnp 00:0c: [bus 20-3f]
[    2.075696] pnp 00:0c: [mem 0xf8000000-0xfbffffff window]
[    2.075700] pnp 00:0c: [mem 0xf8000000-0xfbffffff window]
[    2.075704] pnp 00:0c: [io  0x8000-0xffff window]
[    2.075807] pnp 00:0c: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 =
(active)
[    2.075952] pnp 00:0d: [mem 0xf8efe000-0xf8efffff]
[    2.076200] system 00:0d: [mem 0xf8efe000-0xf8efffff] has been reserve=
d
[    2.078336] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    2.078431] pnp: PnP ACPI: found 14 devices
[    2.079830] ACPI: ACPI bus type pnp unregistered
[    2.088368] PCI: max bus depth: 1 pci_try_num: 2
[    2.088590] pci 0000:00:02.0: BAR 15: assigned [mem 0xf0000000-0xf00ff=
fff pref]
[    2.091019] pci 0000:00:02.2: BAR 15: assigned [mem 0xf0100000-0xf01ff=
fff pref]
[    2.093358] pci 0000:00:03.0: BAR 14: assigned [mem 0xf0200000-0xf02ff=
fff]
[    2.095488] pci 0000:00:01.0: PCI bridge to [bus 11-11]
[    2.097166] pci 0000:00:01.0:   bridge window [io  disabled]
[    2.099088] pci 0000:00:01.0:   bridge window [mem disabled]
[    2.101023] pci 0000:00:01.0:   bridge window [mem pref disabled]
[    2.102959] pci 0000:00:01.1: PCI bridge to [bus 02-02]
[    2.104625] pci 0000:00:01.1:   bridge window [io  disabled]
[    2.106396] pci 0000:00:01.1:   bridge window [mem disabled]
[    2.108246] pci 0000:00:01.1:   bridge window [mem pref disabled]
[    2.110865] pci 0000:04:00.0: BAR 6: assigned [mem 0xf0000000-0xf003ff=
ff pref]
[    2.113956] pci 0000:04:00.1: BAR 6: assigned [mem 0xf0040000-0xf007ff=
ff pref]
[    2.116370] pci 0000:04:00.2: BAR 6: assigned [mem 0xf0080000-0xf00bff=
ff pref]
[    2.118780] pci 0000:04:00.3: BAR 6: assigned [mem 0xf00c0000-0xf00fff=
ff pref]
[    2.121152] pci 0000:00:02.0: PCI bridge to [bus 04-04]
[    2.122891] pci 0000:00:02.0:   bridge window [io  disabled]
[    2.124695] pci 0000:00:02.0:   bridge window [mem 0xf7d00000-0xf7ffff=
ff]
[    2.126800] pci 0000:00:02.0:   bridge window [mem 0xf0000000-0xf00fff=
ff pref]
[    2.129174] pci 0000:00:02.1: PCI bridge to [bus 12-12]
[    2.130879] pci 0000:00:02.1:   bridge window [io  disabled]
[    2.132777] pci 0000:00:02.1:   bridge window [mem disabled]
[    2.134617] pci 0000:00:02.1:   bridge window [mem pref disabled]
[    2.136529] pci 0000:03:00.0: BAR 6: assigned [mem 0xf0100000-0xf017ff=
ff pref]
[    2.138950] pci 0000:00:02.2: PCI bridge to [bus 03-03]
[    2.140667] pci 0000:00:02.2:   bridge window [io  0x4000-0x4fff]
[    2.142564] pci 0000:00:02.2:   bridge window [mem 0xf7b00000-0xf7cfff=
ff]
[    2.144666] pci 0000:00:02.2:   bridge window [mem 0xf0100000-0xf01fff=
ff pref]
[    2.146999] pci 0000:00:02.3: PCI bridge to [bus 13-13]
[    2.148834] pci 0000:00:02.3:   bridge window [io  disabled]
[    2.150662] pci 0000:00:02.3:   bridge window [mem disabled]
[    2.152425] pci 0000:00:02.3:   bridge window [mem pref disabled]
[    2.154329] pci 0000:05:00.0: BAR 6: assigned [mem 0xf3f00000-0xf3f3ff=
ff pref]
[    2.157689] pci 0000:05:00.1: BAR 6: assigned [mem 0xf3f40000-0xf3f7ff=
ff pref]
[    2.160302] pci 0000:00:03.0: PCI bridge to [bus 05-05]
[    2.162476] pci 0000:00:03.0:   bridge window [io  disabled]
[    2.164416] pci 0000:00:03.0:   bridge window [mem 0xf0200000-0xf02fff=
ff]
[    2.166699] pci 0000:00:03.0:   bridge window [mem 0xf3f00000-0xf67fff=
ff 64bit pref]
[    2.169259] pci 0000:00:03.1: PCI bridge to [bus 14-14]
[    2.170983] pci 0000:00:03.1:   bridge window [io  disabled]
[    2.172793] pci 0000:00:03.1:   bridge window [mem disabled]
[    2.174661] pci 0000:00:03.1:   bridge window [mem pref disabled]
[    2.176658] pci 0000:00:03.2: PCI bridge to [bus 15-15]
[    2.178464] pci 0000:00:03.2:   bridge window [io  disabled]
[    2.180438] pci 0000:00:03.2:   bridge window [mem disabled]
[    2.182339] pci 0000:00:03.2:   bridge window [mem pref disabled]
[    2.185080] pci 0000:00:03.3: PCI bridge to [bus 16-16]
[    2.187255] pci 0000:00:03.3:   bridge window [io  disabled]
[    2.189306] pci 0000:00:03.3:   bridge window [mem disabled]
[    2.191234] pci 0000:00:03.3:   bridge window [mem pref disabled]
[    2.193124] pci 0000:00:11.0: PCI bridge to [bus 18-18]
[    2.195043] pci 0000:00:11.0:   bridge window [io  disabled]
[    2.196967] pci 0000:00:11.0:   bridge window [mem disabled]
[    2.198880] pci 0000:00:11.0:   bridge window [mem pref disabled]
[    2.200762] pci 0000:00:1c.0: PCI bridge to [bus 08-08]
[    2.202399] pci 0000:00:1c.0:   bridge window [io  disabled]
[    2.204151] pci 0000:00:1c.0:   bridge window [mem disabled]
[    2.205923] pci 0000:00:1c.0:   bridge window [mem pref disabled]
[    2.207844] pci 0000:01:00.2: BAR 6: assigned [mem 0xf6d00000-0xf6d0ff=
ff pref]
[    2.210117] pci 0000:00:1c.7: PCI bridge to [bus 01-01]
[    2.211761] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    2.213725] pci 0000:00:1c.7:   bridge window [mem 0xf6d00000-0xf7afff=
ff]
[    2.215812] pci 0000:00:1c.7:   bridge window [mem 0xf2000000-0xf2ffff=
ff 64bit pref]
[    2.218254] pci 0000:00:1e.0: PCI bridge to [bus 17-17]
[    2.219955] pci 0000:00:1e.0:   bridge window [io  disabled]
[    2.221882] pci 0000:00:1e.0:   bridge window [mem disabled]
[    2.223755] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    2.225871] pci 0000:20:03.0: BAR 14: assigned [mem 0xf8000000-0xf80ff=
fff]
[    2.228133] pci 0000:20:00.0: PCI bridge to [bus 2d-2d]
[    2.229843] pci 0000:20:00.0:   bridge window [io  disabled]
[    2.232546] pci 0000:20:00.0:   bridge window [mem disabled]
[    2.235000] pci 0000:20:00.0:   bridge window [mem pref disabled]
[    2.236975] pci 0000:20:01.0: PCI bridge to [bus 24-24]
[    2.238965] pci 0000:20:01.0:   bridge window [io  disabled]
[    2.240756] pci 0000:20:01.0:   bridge window [mem disabled]
[    2.242533] pci 0000:20:01.0:   bridge window [mem pref disabled]
[    2.244535] pci 0000:20:01.1: PCI bridge to [bus 25-25]
[    2.246162] pci 0000:20:01.1:   bridge window [io  disabled]
[    2.248004] pci 0000:20:01.1:   bridge window [mem disabled]
[    2.251452] pci 0000:20:01.1:   bridge window [mem pref disabled]
[    2.253400] pci 0000:20:02.0: PCI bridge to [bus 26-26]
[    2.255048] pci 0000:20:02.0:   bridge window [io  disabled]
[    2.257418] pci 0000:20:02.0:   bridge window [mem disabled]
[    2.259406] pci 0000:20:02.0:   bridge window [mem pref disabled]
[    2.262053] pci 0000:20:02.1: PCI bridge to [bus 27-27]
[    2.263953] pci 0000:20:02.1:   bridge window [io  disabled]
[    2.265970] pci 0000:20:02.1:   bridge window [mem disabled]
[    2.267832] pci 0000:20:02.1:   bridge window [mem pref disabled]
[    2.269856] pci 0000:20:02.2: PCI bridge to [bus 28-28]
[    2.271650] pci 0000:20:02.2:   bridge window [io  disabled]
[    2.273642] pci 0000:20:02.2:   bridge window [mem disabled]
[    2.275440] pci 0000:20:02.2:   bridge window [mem pref disabled]
[    2.277441] pci 0000:20:02.3: PCI bridge to [bus 29-29]
[    2.279113] pci 0000:20:02.3:   bridge window [io  disabled]
[    2.280851] pci 0000:20:02.3:   bridge window [mem disabled]
[    2.282716] pci 0000:20:02.3:   bridge window [mem pref disabled]
[    2.284783] pci 0000:21:00.0: BAR 6: assigned [mem 0xf8f00000-0xf8f3ff=
ff pref]
[    2.287057] pci 0000:21:00.1: BAR 6: assigned [mem 0xf8f40000-0xf8f7ff=
ff pref]
[    2.289533] pci 0000:20:03.0: PCI bridge to [bus 21-21]
[    2.291239] pci 0000:20:03.0:   bridge window [io  disabled]
[    2.293146] pci 0000:20:03.0:   bridge window [mem 0xf8000000-0xf80fff=
ff]
[    2.295262] pci 0000:20:03.0:   bridge window [mem 0xf8f00000-0xfb7fff=
ff 64bit pref]
[    2.297802] pci 0000:20:03.1: PCI bridge to [bus 2a-2a]
[    2.299559] pci 0000:20:03.1:   bridge window [io  disabled]
[    2.301365] pci 0000:20:03.1:   bridge window [mem disabled]
[    2.303166] pci 0000:20:03.1:   bridge window [mem pref disabled]
[    2.305099] pci 0000:20:03.2: PCI bridge to [bus 2b-2b]
[    2.306830] pci 0000:20:03.2:   bridge window [io  disabled]
[    2.309979] pci 0000:20:03.2:   bridge window [mem disabled]
[    2.312245] pci 0000:20:03.2:   bridge window [mem pref disabled]
[    2.314141] pci 0000:20:03.3: PCI bridge to [bus 2c-2c]
[    2.315784] pci 0000:20:03.3:   bridge window [io  disabled]
[    2.317604] pci 0000:20:03.3:   bridge window [mem disabled]
[    2.319402] pci 0000:20:03.3:   bridge window [mem pref disabled]
[    2.321336] pci 0000:00:01.0: PCI INT A -> GSI 45 (level, low) -> IRQ =
45
[    2.323407] pci 0000:00:01.0: setting latency timer to 64
[    2.323412] pci 0000:00:01.1: PCI INT A -> GSI 45 (level, low) -> IRQ =
45
[    2.325574] pci 0000:00:01.1: setting latency timer to 64
[    2.325579] pci 0000:00:02.0: PCI INT A -> GSI 45 (level, low) -> IRQ =
45
[    2.327750] pci 0000:00:02.0: setting latency timer to 64
[    2.327755] pci 0000:00:02.1: PCI INT A -> GSI 45 (level, low) -> IRQ =
45
[    2.329813] pci 0000:00:02.1: setting latency timer to 64
[    2.329818] pci 0000:00:02.2: PCI INT A -> GSI 45 (level, low) -> IRQ =
45
[    2.331880] pci 0000:00:02.2: setting latency timer to 64
[    2.331884] pci 0000:00:02.3: PCI INT A -> GSI 45 (level, low) -> IRQ =
45
[    2.334160] pci 0000:00:02.3: setting latency timer to 64
[    2.334165] pci 0000:00:03.0: PCI INT A -> GSI 45 (level, low) -> IRQ =
45
[    2.336812] pci 0000:00:03.0: setting latency timer to 64
[    2.336817] pci 0000:00:03.1: PCI INT A -> GSI 45 (level, low) -> IRQ =
45
[    2.339005] pci 0000:00:03.1: setting latency timer to 64
[    2.339010] pci 0000:00:03.2: PCI INT A -> GSI 45 (level, low) -> IRQ =
45
[    2.341352] pci 0000:00:03.2: setting latency timer to 64
[    2.341356] pci 0000:00:03.3: PCI INT A -> GSI 45 (level, low) -> IRQ =
45
[    2.343433] pci 0000:00:03.3: setting latency timer to 64
[    2.343459] pci 0000:00:11.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    2.345556] pci 0000:00:11.0: setting latency timer to 64
[    2.345562] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
[    2.347670] pci 0000:00:1c.0: setting latency timer to 64
[    2.347688] pci 0000:00:1c.7: PCI INT D -> GSI 19 (level, low) -> IRQ =
19
[    2.349751] pci 0000:00:1c.7: setting latency timer to 64
[    2.349764] pci 0000:00:1e.0: setting latency timer to 64
[    2.349784] pci 0000:20:00.0: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.351857] pci 0000:20:00.0: setting latency timer to 64
[    2.351862] pci 0000:20:01.0: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.353916] pci 0000:20:01.0: setting latency timer to 64
[    2.353920] pci 0000:20:01.1: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.356133] pci 0000:20:01.1: setting latency timer to 64
[    2.356137] pci 0000:20:02.0: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.358394] pci 0000:20:02.0: setting latency timer to 64
[    2.358398] pci 0000:20:02.1: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.360813] pci 0000:20:02.1: setting latency timer to 64
[    2.360818] pci 0000:20:02.2: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.363062] pci 0000:20:02.2: setting latency timer to 64
[    2.363066] pci 0000:20:02.3: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.365181] pci 0000:20:02.3: setting latency timer to 64
[    2.365186] pci 0000:20:03.0: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.367318] pci 0000:20:03.0: setting latency timer to 64
[    2.367323] pci 0000:20:03.1: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.369504] pci 0000:20:03.1: setting latency timer to 64
[    2.369509] pci 0000:20:03.2: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.371606] pci 0000:20:03.2: setting latency timer to 64
[    2.371611] pci 0000:20:03.3: PCI INT A -> GSI 69 (level, low) -> IRQ =
69
[    2.373891] pci 0000:20:03.3: setting latency timer to 64
[    2.373896] pci_bus 0000:00: resource 4 [mem 0xf0000000-0xf7ffffff]
[    2.373898] pci_bus 0000:00: resource 5 [io  0x1000-0x7fff]
[    2.373900] pci_bus 0000:00: resource 6 [io  0x0000-0x03af]
[    2.373902] pci_bus 0000:00: resource 7 [io  0x03e0-0x0cf7]
[    2.373903] pci_bus 0000:00: resource 8 [io  0x0d00-0x0fff]
[    2.373905] pci_bus 0000:00: resource 9 [mem 0xfed00000-0xfed03fff]
[    2.373906] pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed44fff]
[    2.373908] pci_bus 0000:00: resource 11 [io  0x03b0-0x03bb]
[    2.373910] pci_bus 0000:00: resource 12 [io  0x03c0-0x03df]
[    2.373911] pci_bus 0000:00: resource 13 [mem 0x000a0000-0x000bffff]
[    2.373913] pci_bus 0000:04: resource 1 [mem 0xf7d00000-0xf7ffffff]
[    2.373915] pci_bus 0000:04: resource 2 [mem 0xf0000000-0xf00fffff pre=
f]
[    2.373917] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    2.373919] pci_bus 0000:03: resource 1 [mem 0xf7b00000-0xf7cfffff]
[    2.373921] pci_bus 0000:03: resource 2 [mem 0xf0100000-0xf01fffff pre=
f]
[    2.373923] pci_bus 0000:05: resource 1 [mem 0xf0200000-0xf02fffff]
[    2.373924] pci_bus 0000:05: resource 2 [mem 0xf3f00000-0xf67fffff 64b=
it pref]
[    2.373927] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    2.373928] pci_bus 0000:01: resource 1 [mem 0xf6d00000-0xf7afffff]
[    2.373930] pci_bus 0000:01: resource 2 [mem 0xf2000000-0xf2ffffff 64b=
it pref]
[    2.373932] pci_bus 0000:17: resource 4 [mem 0xf0000000-0xf7ffffff]
[    2.373934] pci_bus 0000:17: resource 5 [io  0x1000-0x7fff]
[    2.373935] pci_bus 0000:17: resource 6 [io  0x0000-0x03af]
[    2.373937] pci_bus 0000:17: resource 7 [io  0x03e0-0x0cf7]
[    2.373939] pci_bus 0000:17: resource 8 [io  0x0d00-0x0fff]
[    2.373940] pci_bus 0000:17: resource 9 [mem 0xfed00000-0xfed03fff]
[    2.373942] pci_bus 0000:17: resource 10 [mem 0xfed40000-0xfed44fff]
[    2.373944] pci_bus 0000:17: resource 11 [io  0x03b0-0x03bb]
[    2.373945] pci_bus 0000:17: resource 12 [io  0x03c0-0x03df]
[    2.373947] pci_bus 0000:17: resource 13 [mem 0x000a0000-0x000bffff]
[    2.373949] pci_bus 0000:20: resource 4 [mem 0xf8000000-0xfbffffff]
[    2.373951] pci_bus 0000:20: resource 5 [io  0x8000-0xffff]
[    2.373953] pci_bus 0000:21: resource 1 [mem 0xf8000000-0xf80fffff]
[    2.373955] pci_bus 0000:21: resource 2 [mem 0xf8f00000-0xfb7fffff 64b=
it pref]
[    2.373957] pci_bus 0000:1f: resource 0 [io  0x0000-0xffff]
[    2.373959] pci_bus 0000:1f: resource 1 [mem 0x00000000-0x3fffffffffff=
]
[    2.373962] pci_bus 0000:3f: resource 0 [io  0x0000-0xffff]
[    2.373963] pci_bus 0000:3f: resource 1 [mem 0x00000000-0x3fffffffffff=
]
[    2.374333] NET: Registered protocol family 2
[    2.376292] IP route cache hash table entries: 524288 (order: 10, 4194=
304 bytes)
[    2.380461] TCP established hash table entries: 524288 (order: 11, 838=
8608 bytes)
[    2.384269] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s)
[    2.387697] TCP: Hash tables configured (established 524288 bind 65536=
)
[    2.390249] TCP reno registered
[    2.391467] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[    2.394081] UDP-Lite hash table entries: 65536 (order: 9, 2097152 byte=
s)
[    2.397289] NET: Registered protocol family 1
[    2.398841] pci 0000:00:1a.0: PCI INT A -> GSI 21 (level, low) -> IRQ =
21
[    2.414048] pci 0000:00:1a.0: PCI INT A disabled
[    2.415935] pci 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ =
20
[    2.434000] pci 0000:00:1d.0: PCI INT A disabled
[    2.435627] pci 0000:01:00.1: Boot video device
[    2.435640] pci 0000:01:00.4: PCI INT B -> GSI 16 (level, low) -> IRQ =
16
[    2.438006] pci 0000:01:00.4: PCI INT B disabled
[    2.439733] PCI: CLS 64 bytes, default 64
[    2.439798] Unpacking initramfs...
[    2.545853] Freeing initrd memory: 5348k freed
[    2.548209] DMAR: Device scope device [0000:02:00.00] not found
[    2.550133] DMAR: Device scope device [0000:00:00.00] not found
[    2.551988] DMAR: Device scope device [0000:00:1f.02] not found
[    2.553842] DMAR: Device scope device [0000:00:1f.02] not found
[    2.555689] DMAR: Device scope device [0000:00:1f.05] not found
[    2.557562] DMAR: Device scope device [0000:00:1f.05] not found
[    2.559752] DMAR: Device scope device [0000:02:00.00] not found
[    2.561587] DMAR: Device scope device [0000:00:00.00] not found
[    2.563421] DMAR: Device scope device [0000:00:1f.02] not found
[    2.565252] DMAR: Device scope device [0000:00:1f.02] not found
[    2.567303] DMAR: Device scope device [0000:00:1f.05] not found
[    2.569190] DMAR: Device scope device [0000:00:1f.05] not found
[    2.571166] DMAR: Device scope device [0000:02:00.00] not found
[    2.573089] DMAR: Device scope device [0000:00:00.00] not found
[    2.574968] DMAR: Device scope device [0000:00:1f.02] not found
[    2.576862] DMAR: Device scope device [0000:00:1f.02] not found
[    2.578725] DMAR: Device scope device [0000:00:1f.05] not found
[    2.580591] DMAR: Device scope device [0000:00:1f.05] not found
[    2.582403] DMAR: Device scope device [0000:02:00.00] not found
[    2.584271] DMAR: Device scope device [0000:00:00.00] not found
[    2.586158] DMAR: Device scope device [0000:00:1f.02] not found
[    2.588081] DMAR: Device scope device [0000:00:1f.02] not found
[    2.589934] DMAR: Device scope device [0000:00:1f.05] not found
[    2.591793] DMAR: Device scope device [0000:00:1f.05] not found
[    2.593642] DMAR: Device scope device [0000:02:00.00] not found
[    2.595464] DMAR: Device scope device [0000:00:00.00] not found
[    2.597382] DMAR: Device scope device [0000:00:1f.02] not found
[    2.599304] DMAR: Device scope device [0000:00:1f.02] not found
[    2.601239] DMAR: Device scope device [0000:00:1f.05] not found
[    2.603133] DMAR: Device scope device [0000:00:1f.05] not found
[    2.605052] DMAR: Device scope device [0000:02:00.00] not found
[    2.606997] DMAR: Device scope device [0000:00:00.00] not found
[    2.608979] DMAR: Device scope device [0000:00:1f.02] not found
[    2.610834] DMAR: Device scope device [0000:00:1f.02] not found
[    2.612686] DMAR: Device scope device [0000:00:1f.05] not found
[    2.614527] DMAR: Device scope device [0000:00:1f.05] not found
[    2.616717] IOMMU 0 0xf8efe000: using Queued invalidation
[    2.618579] IOMMU 1 0xf1ffe000: using Queued invalidation
[    2.621361] IOMMU: Setting RMRR:
[    2.622669] IOMMU: Setting identity map for device 0000:01:00.0 [0xbdd=
de000 - 0xbdddefff]
[    2.625283] IOMMU: Setting identity map for device 0000:01:00.2 [0xbdd=
de000 - 0xbdddefff]
[    2.627973] IOMMU: Setting identity map for device 0000:01:00.4 [0xbdd=
de000 - 0xbdddefff]
[    2.630905] IOMMU: Setting identity map for device 0000:03:00.0 [0xe80=
00 - 0xe8fff]
[    2.633651] IOMMU: Setting identity map for device 0000:01:00.0 [0xe80=
00 - 0xe8fff]
[    2.636233] IOMMU: Setting identity map for device 0000:01:00.2 [0xe80=
00 - 0xe8fff]
[    2.639063] IOMMU: Setting identity map for device 0000:04:00.0 [0xe80=
00 - 0xe8fff]
[    2.641663] IOMMU: Setting identity map for device 0000:04:00.1 [0xe80=
00 - 0xe8fff]
[    2.644138] IOMMU: Setting identity map for device 0000:04:00.2 [0xe80=
00 - 0xe8fff]
[    2.646620] IOMMU: Setting identity map for device 0000:04:00.3 [0xe80=
00 - 0xe8fff]
[    2.649152] IOMMU: Setting identity map for device 0000:05:00.0 [0xe80=
00 - 0xe8fff]
[    2.651625] IOMMU: Setting identity map for device 0000:05:00.1 [0xe80=
00 - 0xe8fff]
[    2.654037] IOMMU: Setting identity map for device 0000:21:00.0 [0xe80=
00 - 0xe8fff]
[    2.656762] IOMMU: Setting identity map for device 0000:21:00.1 [0xe80=
00 - 0xe8fff]
[    2.659226] IOMMU: Setting identity map for device 0000:03:00.0 [0xf40=
00 - 0xf4fff]
[    2.661640] IOMMU: Setting identity map for device 0000:01:00.0 [0xf40=
00 - 0xf4fff]
[    2.664125] IOMMU: Setting identity map for device 0000:01:00.2 [0xf40=
00 - 0xf4fff]
[    2.666784] IOMMU: Setting identity map for device 0000:04:00.0 [0xf40=
00 - 0xf4fff]
[    2.669214] IOMMU: Setting identity map for device 0000:04:00.1 [0xf40=
00 - 0xf4fff]
[    2.671642] IOMMU: Setting identity map for device 0000:04:00.2 [0xf40=
00 - 0xf4fff]
[    2.674204] IOMMU: Setting identity map for device 0000:04:00.3 [0xf40=
00 - 0xf4fff]
[    2.676634] IOMMU: Setting identity map for device 0000:05:00.0 [0xf40=
00 - 0xf4fff]
[    2.679178] IOMMU: Setting identity map for device 0000:05:00.1 [0xf40=
00 - 0xf4fff]
[    2.681771] IOMMU: Setting identity map for device 0000:21:00.0 [0xf40=
00 - 0xf4fff]
[    2.684482] IOMMU: Setting identity map for device 0000:21:00.1 [0xf40=
00 - 0xf4fff]
[    2.686904] IOMMU: Setting identity map for device 0000:03:00.0 [0xbdf=
6e000 - 0xbdf6efff]
[    2.689477] IOMMU: Setting identity map for device 0000:01:00.0 [0xbdf=
6e000 - 0xbdf6efff]
[    2.692019] IOMMU: Setting identity map for device 0000:01:00.2 [0xbdf=
6e000 - 0xbdf6efff]
[    2.695951] IOMMU: Setting identity map for device 0000:04:00.0 [0xbdf=
6e000 - 0xbdf6efff]
[    2.698637] IOMMU: Setting identity map for device 0000:04:00.1 [0xbdf=
6e000 - 0xbdf6efff]
[    2.702551] IOMMU: Setting identity map for device 0000:04:00.2 [0xbdf=
6e000 - 0xbdf6efff]
[    2.705134] IOMMU: Setting identity map for device 0000:04:00.3 [0xbdf=
6e000 - 0xbdf6efff]
[    2.707785] IOMMU: Setting identity map for device 0000:05:00.0 [0xbdf=
6e000 - 0xbdf6efff]
[    2.710409] IOMMU: Setting identity map for device 0000:05:00.1 [0xbdf=
6e000 - 0xbdf6efff]
[    2.713150] IOMMU: Setting identity map for device 0000:21:00.0 [0xbdf=
6e000 - 0xbdf6efff]
[    2.715936] IOMMU: Setting identity map for device 0000:21:00.1 [0xbdf=
6e000 - 0xbdf6efff]
[    2.718809] IOMMU: Setting identity map for device 0000:03:00.0 [0xbdf=
6f000 - 0xbdf7efff]
[    2.721391] IOMMU: Setting identity map for device 0000:01:00.0 [0xbdf=
6f000 - 0xbdf7efff]
[    2.723923] IOMMU: Setting identity map for device 0000:01:00.2 [0xbdf=
6f000 - 0xbdf7efff]
[    2.726478] IOMMU: Setting identity map for device 0000:04:00.0 [0xbdf=
6f000 - 0xbdf7efff]
[    2.729037] IOMMU: Setting identity map for device 0000:04:00.1 [0xbdf=
6f000 - 0xbdf7efff]
[    2.731590] IOMMU: Setting identity map for device 0000:04:00.2 [0xbdf=
6f000 - 0xbdf7efff]
[    2.734215] IOMMU: Setting identity map for device 0000:04:00.3 [0xbdf=
6f000 - 0xbdf7efff]
[    2.736831] IOMMU: Setting identity map for device 0000:05:00.0 [0xbdf=
6f000 - 0xbdf7efff]
[    2.739389] IOMMU: Setting identity map for device 0000:05:00.1 [0xbdf=
6f000 - 0xbdf7efff]
[    2.741931] IOMMU: Setting identity map for device 0000:21:00.0 [0xbdf=
6f000 - 0xbdf7efff]
[    2.744462] IOMMU: Setting identity map for device 0000:21:00.1 [0xbdf=
6f000 - 0xbdf7efff]
[    2.747021] IOMMU: Setting identity map for device 0000:03:00.0 [0xbdf=
7f000 - 0xbdf82fff]
[    2.749583] IOMMU: Setting identity map for device 0000:01:00.0 [0xbdf=
7f000 - 0xbdf82fff]
[    2.752161] IOMMU: Setting identity map for device 0000:01:00.2 [0xbdf=
7f000 - 0xbdf82fff]
[    2.754733] IOMMU: Setting identity map for device 0000:04:00.0 [0xbdf=
7f000 - 0xbdf82fff]
[    2.757379] IOMMU: Setting identity map for device 0000:04:00.1 [0xbdf=
7f000 - 0xbdf82fff]
[    2.759936] IOMMU: Setting identity map for device 0000:04:00.2 [0xbdf=
7f000 - 0xbdf82fff]
[    2.762476] IOMMU: Setting identity map for device 0000:04:00.3 [0xbdf=
7f000 - 0xbdf82fff]
[    2.764998] IOMMU: Setting identity map for device 0000:05:00.0 [0xbdf=
7f000 - 0xbdf82fff]
[    2.767597] IOMMU: Setting identity map for device 0000:05:00.1 [0xbdf=
7f000 - 0xbdf82fff]
[    2.770617] IOMMU: Setting identity map for device 0000:21:00.0 [0xbdf=
7f000 - 0xbdf82fff]
[    2.773442] IOMMU: Setting identity map for device 0000:21:00.1 [0xbdf=
7f000 - 0xbdf82fff]
[    2.777817] IOMMU: Setting identity map for device 0000:03:00.0 [0xbdf=
83000 - 0xbdf84fff]
[    2.780406] IOMMU: Setting identity map for device 0000:01:00.0 [0xbdf=
83000 - 0xbdf84fff]
[    2.783233] IOMMU: Setting identity map for device 0000:01:00.2 [0xbdf=
83000 - 0xbdf84fff]
[    2.785818] IOMMU: Setting identity map for device 0000:04:00.0 [0xbdf=
83000 - 0xbdf84fff]
[    2.788587] IOMMU: Setting identity map for device 0000:04:00.1 [0xbdf=
83000 - 0xbdf84fff]
[    2.791233] IOMMU: Setting identity map for device 0000:04:00.2 [0xbdf=
83000 - 0xbdf84fff]
[    2.793805] IOMMU: Setting identity map for device 0000:04:00.3 [0xbdf=
83000 - 0xbdf84fff]
[    2.796722] IOMMU: Setting identity map for device 0000:05:00.0 [0xbdf=
83000 - 0xbdf84fff]
[    2.799371] IOMMU: Setting identity map for device 0000:05:00.1 [0xbdf=
83000 - 0xbdf84fff]
[    2.802100] IOMMU: Setting identity map for device 0000:21:00.0 [0xbdf=
83000 - 0xbdf84fff]
[    2.804721] IOMMU: Setting identity map for device 0000:21:00.1 [0xbdf=
83000 - 0xbdf84fff]
[    2.807717] IOMMU: Setting identity map for device 0000:01:00.0 [0xbdf=
f6000 - 0xbdffcfff]
[    2.810427] IOMMU: Setting identity map for device 0000:01:00.2 [0xbdf=
f6000 - 0xbdffcfff]
[    2.813140] IOMMU: Setting identity map for device 0000:01:00.4 [0xbdf=
f6000 - 0xbdffcfff]
[    2.815824] IOMMU: Setting identity map for device 0000:00:1d.0 [0xbdf=
fd000 - 0xbdffffff]
[    2.818713] IOMMU: Setting identity map for device 0000:00:1a.0 [0xbdf=
fd000 - 0xbdffffff]
[    2.821377] IOMMU: Prepare 0-16MiB unity mapping for LPC
[    2.823142] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0 -=
 0xffffff]
[    2.825489] PCI-DMA: Intel(R) Virtualization Technology for Directed I=
/O
[    2.832383] Initialise module verification
[    2.833951] audit: initializing netlink socket (enabled)
[    2.835681] type=3D2000 audit(1405607308.200:1): initialized
[    2.859622] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    2.872854] VFS: Disk quotas dquot_6.5.2
[    2.874482] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.876740] msgmni has been set to 32768
[    2.878498] alg: No test for stdrng (krng)
[    2.879944] Asymmetric key parser 'x509' registered
[    2.881591] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 252)
[    2.884037] io scheduler noop registered (default)
[    2.885570] io scheduler deadline registered
[    2.887147] io scheduler cfq registered
[    2.890451] intel_idle: MWAIT substates: 0x21120
[    2.890453] intel_idle: v0.4 model 0x2D
[    2.890454] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.890628] APEI: Can not request [mem 0x000e8024-0x000e804f] for APEI=
 ERST registers
[    2.893609] GHES: APEI firmware first mode is enabled by APEI bit and =
WHEA _OSC.
[    2.896132] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    2.898335] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    2.913064] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    3.013010] 00:08: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    3.025039] Non-volatile memory driver v1.3
[    3.026554] Linux agpgart interface v0.103
[    3.028143] Fixed MDIO Bus: probed
[    3.029443] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at =
0x60,0x64 irq 1,12
[    3.033584] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.035229] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.037102] mousedev: PS/2 mouse device common for all mice
[    3.040421] cpuidle: using governor ladder
[    3.044187] cpuidle: using governor menu
[    3.045613] EFI Variables Facility v0.08 2004-May-17
[    3.047809] TCP cubic registered
[    3.049031] Registering the dns_resolver key type
[    3.050783] Loading module verification certificates
[    3.052701] MODSIGN: Loaded cert 'SUSE Linux Enterprise Secure Boot Si=
gnkey: 3fb077b6cebc6ff2522e1c148c57c777c788e3e7'
[    3.056633] MODSIGN: Loaded cert 'Euler:ServerDom0:V1R3C10:kvm OBS Pro=
ject: 5663f86f130da2c623b35daabd63b68fbe3fc52d'
[    3.060376] PM: Hibernation image not present or could not be loaded.
[    3.060393] registered taskstats version 1
[    3.071605]   Magic number: 6:693:485
[    3.077833] Freeing unused kernel memory: 1364k freed
[    3.103832] Write protecting the kernel read-only data: 10240k
[    3.138706] Freeing unused kernel memory: 1600k freed
[    3.167236] Freeing unused kernel memory: 936k freed
[    3.291971] SCSI subsystem initialized
[    3.311298] rdac: device handler registered
[    3.346403] alua: device handler registered
[    3.374577] hp_sw: device handler registered
[    3.403625] emc: device handler registered
[    3.428435] udev: starting version 147
[    3.452886] ACPI: acpi_idle yielding to intel_idle
[    3.466123] thermal LNXTHERM:00: registered as thermal_zone0
[    3.492233] ACPI: Thermal Zone [THM0] (8 C)
[    3.511239] HP HPSA Driver (v 3.2.0)
[    3.527739] hpsa 0000:03:00.0: PCI INT A -> GSI 34 (level, low) -> IRQ=
 34
[    3.559036] hpsa 0000:03:00.0: setting latency timer to 64
[    3.559055] hpsa 0000:03:00.0: MSIX
[    3.575085] hpsa 0000:03:00.0: irq 90 for MSI/MSI-X
[    3.575104] hpsa 0000:03:00.0: irq 91 for MSI/MSI-X
[    3.575122] hpsa 0000:03:00.0: irq 92 for MSI/MSI-X
[    3.575137] hpsa 0000:03:00.0: irq 93 for MSI/MSI-X
[    3.575185] hpsa 0000:03:00.0: irq 94 for MSI/MSI-X
[    3.575203] hpsa 0000:03:00.0: irq 95 for MSI/MSI-X
[    3.575221] hpsa 0000:03:00.0: irq 96 for MSI/MSI-X
[    3.575237] hpsa 0000:03:00.0: irq 97 for MSI/MSI-X
[    3.575301] usbcore: registered new interface driver usbfs
[    3.595244] hpsa 0000:03:00.0: hpsa0: <0x323b> at IRQ 90 using DAC
[    3.615382] scsi0 : hpsa
[    3.640357] usbcore: registered new interface driver hub
[    3.643176] hpsa 0000:03:00.0: RAID              device c0b3t0l0 added=
.
[    3.643180] hpsa 0000:03:00.0: Direct-Access     device c0b0t0l0 added=
.
[    3.643420] scsi 0:3:0:0: RAID              HP       P220i            =
4.68 PQ: 0 ANSI: 5
[    3.643715] scsi 0:0:0:0: Direct-Access     HP       LOGICAL VOLUME   =
4.68 PQ: 0 ANSI: 5
[    3.799374] usbcore: registered new device driver usb
[    3.823846] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.850953] Refined TSC clocksource calibration: 2599.999 MHz.
[    3.850957] Switching to clocksource tsc
[    3.898279] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 21 (level, low) ->=
 IRQ 21
[    3.930913] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    3.930917] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    3.955477] sd 0:0:0:0: [sda] 585871964 512-byte logical blocks: (299 =
GB/279 GiB)
[    3.955481] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bu=
s number 1
[    3.955536] ehci_hcd 0000:00:1a.0: debug port 2
[    3.959403] ehci_hcd 0000:00:1a.0: cache line size of 64 is not suppor=
ted
[    3.959421] ehci_hcd 0000:00:1a.0: irq 21, io mem 0xf6c60000
[    3.974337] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    3.974373] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.974376] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    3.974378] usb usb1: Product: EHCI Host Controller
[    3.974380] usb usb1: Manufacturer: Linux 3.0.93-0.8-default ehci_hcd
[    3.974382] usb usb1: SerialNumber: 0000:00:1a.0
[    3.974499] hub 1-0:1.0: USB hub found
[    3.974505] hub 1-0:1.0: 2 ports detected
[    3.974843] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) ->=
 IRQ 20
[    3.974884] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.974888] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    3.974898] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bu=
s number 2
[    3.974952] ehci_hcd 0000:00:1d.0: debug port 2
[    3.978832] ehci_hcd 0000:00:1d.0: cache line size of 64 is not suppor=
ted
[    3.978849] ehci_hcd 0000:00:1d.0: irq 20, io mem 0xf6c50000
[    3.994296] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    3.994329] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.994331] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    3.994334] usb usb2: Product: EHCI Host Controller
[    3.994336] usb usb2: Manufacturer: Linux 3.0.93-0.8-default ehci_hcd
[    3.994337] usb usb2: SerialNumber: 0000:00:1d.0
[    3.994476] hub 2-0:1.0: USB hub found
[    3.994484] hub 2-0:1.0: 2 ports detected
[    4.286416] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    4.307803] sd 0:0:0:0: [sda] Write Protect is off
[    4.307806] sd 0:0:0:0: [sda] Mode Sense: 73 00 00 08
[    4.307937] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabl=
ed, doesn't support DPO or FUA
[    4.308455]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    4.308951] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.672289] uhci_hcd: USB Universal Host Controller Interface driver
[    4.787184] uhci_hcd 0000:01:00.4: PCI INT B -> GSI 16 (level, low) ->=
 IRQ 16
[    4.819806] uhci_hcd 0000:01:00.4: setting latency timer to 64
[    4.819810] uhci_hcd 0000:01:00.4: UHCI Host Controller
[    4.844745] uhci_hcd 0000:01:00.4: new USB bus registered, assigned bu=
s number 3
[    4.878317] uhci_hcd 0000:01:00.4: port count misdetected? forcing to =
2 ports
[    4.911677] uhci_hcd 0000:01:00.4: irq 16, io base 0x00003c00
[    4.938996] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    4.970489] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    5.004856] usb usb3: Product: UHCI Host Controller
[    5.027794] usb usb3: Manufacturer: Linux 3.0.93-0.8-default uhci_hcd
[    5.027816] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024
[    5.027818] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    5.130508] usb usb3: SerialNumber: 0000:01:00.4
[    5.130550] hub 1-1:1.0: USB hub found
[    5.174129] hub 1-1:1.0: 6 ports detected
[    5.174173] hub 3-0:1.0: USB hub found
[    5.174176] hub 3-0:1.0: 2 ports detected
[    5.339432] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    5.468459] [drm] Initialized drm 1.1.0 20060810
[    5.493564] This driver is only used in secure boot mode as default
[    5.499407] usb 2-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024
[    5.499413] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    5.499722] hub 2-1:1.0: USB hub found
[    5.499781] hub 2-1:1.0: 8 ports detected
[    5.610812] usb 3-1: new full-speed USB device number 2 using uhci_hcd
[    5.756686] usb 3-1: New USB device found, idVendor=3D03f0, idProduct=3D=
7029
[    5.790214] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    5.823534] usb 3-1: Product: Virtual Keyboard=20
[    5.846384] usb 3-1: Manufacturer: HP=20
[    5.873956] input: HP  Virtual Keyboard  as /devices/pci0000:00/0000:0=
0:1c.7/0000:01:00.4/usb3/3-1/3-1:1.0/input/input0
[    5.926341] generic-usb 0003:03F0:7029.0001: input,hidraw0: USB HID v1=
.01 Keyboard [HP  Virtual Keyboard ] on usb-0000:01:00.4-1/input0
[    5.984635] input: HP  Virtual Keyboard  as /devices/pci0000:00/0000:0=
0:1c.7/0000:01:00.4/usb3/3-1/3-1:1.1/input/input1
[    6.037041] generic-usb 0003:03F0:7029.0002: input,hidraw1: USB HID v1=
.01 Mouse [HP  Virtual Keyboard ] on usb-0000:01:00.4-1/input1
[    6.093951] usbcore: registered new interface driver usbhid
[    6.119614] usbhid: USB HID core driver
[    6.119626] usb 2-1.3: new high-speed USB device number 3 using ehci_h=
cd
[    6.261823] usb 2-1.3: New USB device found, idVendor=3D0424, idProduc=
t=3D2660
[    6.261826] usb 2-1.3: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
[    6.262135] hub 2-1.3:1.0: USB hub found
[    6.262264] hub 2-1.3:1.0: 2 ports detected
[    6.373352] kjournald starting.  Commit interval 15 seconds
[    6.373547] EXT3-fs (sda2): using internal journal
[    6.373555] EXT3-fs (sda2): mounted filesystem with ordered data mode
[    7.436236] udev: starting version 147
[    7.517753] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/in=
put/input2
[    7.554395] ACPI: Power Button [PWRF]
[    7.574991] Disabling lock debugging due to kernel taint
[    7.600552] be2net 0000:04:00.0: PCI INT A -> GSI 32 (level, low) -> I=
RQ 32
[    7.600565] iTCO_vendor_support: vendor-support=3D0
[    7.601008] power_meter ACPI000D:00: Found ACPI power meter.
[    7.601086] [Firmware Bug]: ACPI(VGA0) defines _DOD but not _DOS
[    7.601099] power_meter ACPI000D:00: Ignoring unsafe software power ca=
p!
[    7.601196] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A=
08:00/device:20/LNXVIDEO:00/input/input3
[    7.601280] ACPI: Video Device [VGA0] (multi-head: yes  rom: no  post:=
 no)
[    7.601350] [Firmware Bug]: ACPI(VGA0) defines _DOD but not _DOS
[    7.601426] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A=
08:01/device:32/LNXVIDEO:01/input/input4
[    7.601483] ACPI: Video Device [VGA0] (multi-head: yes  rom: no  post:=
 no)
[    7.936395] be2net 0000:04:00.0: setting latency timer to 64
[    7.936764] hpilo 0000:01:00.2: PCI INT B -> GSI 16 (level, low) -> IR=
Q 16
[    7.968536] hpilo 0000:01:00.2: setting latency timer to 64
[    7.970061] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    8.002506] Loading iSCSI transport class v2.0-870.
[    8.025250] scsi 0:3:0:0: Attached scsi generic sg0 type 12
[    8.053407] sd 0:0:0:0: Attached scsi generic sg1 type 0
[    8.078344] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[    8.104287] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled =
by hardware/BIOS
[    8.144316] rtc_cmos 00:09: RTC can wake from S4
[    8.165781] rtc_cmos 00:09: rtc core: registered rtc_cmos as rtc0
[    8.197419] rtc0: alarms up to one day, 114 bytes nvram, hpet irqs
[    8.226042] hpwdt 0000:01:00.0: PCI INT A -> GSI 19 (level, low) -> IR=
Q 19
[    8.259173] hpwdt: New timer passed in is 30 seconds.
[    8.259481] hpwdt 0000:01:00.0: HP Watchdog Timer Driver: NMI decoding=
 initialized, allow kernel dump: ON (default =3D 0/OFF), priority: LAST (=
default =3D 0/LAST).
[    8.325859] hpwdt 0000:01:00.0: HP Watchdog Timer Driver: 1.3.0, timer=
 margin: 30 seconds (nowayout=3D0).
[    8.393173] bnx2x: Broadcom NetXtreme II 5771x/578xx 10/20-Gigabit Eth=
ernet Driver bnx2x 1.78.00-0 (2012/09/27)
[    8.443145] iscsi: registered transport (be2iscsi)
[    8.466364] In beiscsi_module_init, tt=3Dffffffffa062b040
[    8.493643] bnx2x 0000:05:00.0: PCI INT A -> GSI 40 (level, low) -> IR=
Q 40
[    8.527646] bnx2x 0000:05:00.0: setting latency timer to 64
[    8.528865] bnx2x 0000:05:00.0: part number 0-0-0-0
[    8.553331] be2net 0000:04:00.0: irq 98 for MSI/MSI-X
[    8.553346] be2net 0000:04:00.0: enabled 1 MSI-x vector(s)
[    8.581554] NET: Registered protocol family 10
[    8.644459] loaded kvm module (kvm-kmod-3.6)
[    8.652255] be2net 0000:04:00.0: created 0 RSS queue(s) and 1 default =
RX queue
[    8.717071] tun: Universal TUN/TAP device driver, 1.6
[    8.740496] tun: (C) 1999-2004 Max Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
[    8.758833] be2net 0000:04:00.0: created 1 TX queue(s)
[    8.763821] be2net 0000:04:00.0: Emulex OneConnect(be3): 10Gbps NIC  "=
554FLB" PF FLEX 10 port 0
[    8.764016] be2net 0000:04:00.1: PCI INT B -> GSI 36 (level, low) -> I=
RQ 36
[    8.764026] be2net 0000:04:00.1: setting latency timer to 64
[    8.875947] be2net 0000:04:00.1: irq 99 for MSI/MSI-X
[    8.875973] be2net 0000:04:00.1: enabled 1 MSI-x vector(s)
[    8.955591] be2net 0000:04:00.1: created 0 RSS queue(s) and 1 default =
RX queue
[    8.990289] bnx2x 0000:05:00.0: irq 100 for MSI/MSI-X
[    8.990313] bnx2x 0000:05:00.0: irq 101 for MSI/MSI-X
[    8.990358] bnx2x 0000:05:00.0: irq 102 for MSI/MSI-X
[    8.990383] bnx2x 0000:05:00.0: irq 103 for MSI/MSI-X
[    8.990409] bnx2x 0000:05:00.0: irq 104 for MSI/MSI-X
[    8.990429] bnx2x 0000:05:00.0: irq 105 for MSI/MSI-X
[    8.990455] bnx2x 0000:05:00.0: irq 106 for MSI/MSI-X
[    8.990475] bnx2x 0000:05:00.0: irq 107 for MSI/MSI-X
[    8.990500] bnx2x 0000:05:00.0: irq 108 for MSI/MSI-X
[    8.990526] bnx2x 0000:05:00.0: irq 109 for MSI/MSI-X
[    8.991889] bnx2x 0000:05:00.1: PCI INT B -> GSI 44 (level, low) -> IR=
Q 44
[    9.025982] bnx2x 0000:05:00.1: setting latency timer to 64
[    9.028393] bnx2x 0000:05:00.1: part number 0-0-0-0
[    9.052679] Loading kernel module for a network device with CAP_SYS_MO=
DULE (deprecated).  Use CAP_NET_ADMIN and alias netdev-eth1 instead
[    9.166507] be2net 0000:04:00.1: created 1 TX queue(s)
[    9.211862] udev: renamed network interface eth1 to eth2
[    9.213185] be2net 0000:04:00.1: Emulex OneConnect(be3): 10Gbps NIC  "=
554FLB" PF FLEX 10 port 1
[    9.280183] be2iscsi 0000:04:00.2: PCI INT C -> GSI 37 (level, low) ->=
 IRQ 37
[    9.316106] be2iscsi 0000:04:00.2: setting latency timer to 64
[    9.316312] bnx2x 0000:05:00.1: irq 110 for MSI/MSI-X
[    9.316337] bnx2x 0000:05:00.1: irq 111 for MSI/MSI-X
[    9.316359] bnx2x 0000:05:00.1: irq 112 for MSI/MSI-X
[    9.316380] bnx2x 0000:05:00.1: irq 113 for MSI/MSI-X
[    9.316401] bnx2x 0000:05:00.1: irq 114 for MSI/MSI-X
[    9.316420] bnx2x 0000:05:00.1: irq 115 for MSI/MSI-X
[    9.316441] bnx2x 0000:05:00.1: irq 116 for MSI/MSI-X
[    9.316463] bnx2x 0000:05:00.1: irq 117 for MSI/MSI-X
[    9.316484] bnx2x 0000:05:00.1: irq 118 for MSI/MSI-X
[    9.316504] bnx2x 0000:05:00.1: irq 119 for MSI/MSI-X
[    9.317643] scsi1 : Emulex 10Gbe open-iscsi Initiator Driver
[    9.317800] bnx2x 0000:21:00.0: PCI INT A -> GSI 64 (level, low) -> IR=
Q 64
[    9.317817] bnx2x 0000:21:00.0: setting latency timer to 64
[    9.319962] bnx2x 0000:21:00.0: part number 0-0-0-0
[    9.666468] bnx2x 0000:21:00.0: irq 120 for MSI/MSI-X
[    9.666493] bnx2x 0000:21:00.0: irq 121 for MSI/MSI-X
[    9.666516] bnx2x 0000:21:00.0: irq 122 for MSI/MSI-X
[    9.666539] bnx2x 0000:21:00.0: irq 123 for MSI/MSI-X
[    9.666564] bnx2x 0000:21:00.0: irq 124 for MSI/MSI-X
[    9.666585] bnx2x 0000:21:00.0: irq 125 for MSI/MSI-X
[    9.666606] bnx2x 0000:21:00.0: irq 126 for MSI/MSI-X
[    9.666627] bnx2x 0000:21:00.0: irq 127 for MSI/MSI-X
[    9.666649] bnx2x 0000:21:00.0: irq 128 for MSI/MSI-X
[    9.666671] bnx2x 0000:21:00.0: irq 129 for MSI/MSI-X
[    9.668316] bnx2x 0000:21:00.1: PCI INT B -> GSI 68 (level, low) -> IR=
Q 68
[    9.699994] bnx2x 0000:21:00.1: setting latency timer to 64
[    9.702100] bnx2x 0000:21:00.1: part number 0-0-0-0
[    9.761579] scsi host1: BM_3651 : No boot session
[    9.837209] be2iscsi 0000:04:00.3: PCI INT D -> GSI 38 (level, low) ->=
 IRQ 38
[    9.870475] be2iscsi 0000:04:00.3: setting latency timer to 64
[    9.870604] scsi2 : Emulex 10Gbe open-iscsi Initiator Driver
[   10.029667] bnx2x 0000:21:00.1: irq 130 for MSI/MSI-X
[   10.029696] bnx2x 0000:21:00.1: irq 131 for MSI/MSI-X
[   10.029717] bnx2x 0000:21:00.1: irq 132 for MSI/MSI-X
[   10.029740] bnx2x 0000:21:00.1: irq 133 for MSI/MSI-X
[   10.029761] bnx2x 0000:21:00.1: irq 134 for MSI/MSI-X
[   10.029782] bnx2x 0000:21:00.1: irq 135 for MSI/MSI-X
[   10.029804] bnx2x 0000:21:00.1: irq 136 for MSI/MSI-X
[   10.029826] bnx2x 0000:21:00.1: irq 137 for MSI/MSI-X
[   10.029853] bnx2x 0000:21:00.1: irq 138 for MSI/MSI-X
[   10.029876] bnx2x 0000:21:00.1: irq 139 for MSI/MSI-X
[   10.254483] scsi host2: BM_3651 : No boot session
[   10.831192] loop: module loaded
[   10.867766] kjournald starting.  Commit interval 15 seconds
[   10.867890] EXT3-fs (sda1): using internal journal
[   10.867897] EXT3-fs (sda1): mounted filesystem with ordered data mode
[   10.868925] kjournald starting.  Commit interval 15 seconds
[   10.869014] EXT3-fs (sda5): using internal journal
[   10.869019] EXT3-fs (sda5): mounted filesystem with ordered data mode
[   10.869759] kjournald starting.  Commit interval 15 seconds
[   10.869854] EXT3-fs (sda3): using internal journal
[   10.869859] EXT3-fs (sda3): mounted filesystem with ordered data mode
[   12.005373] Rounding down aligned max_sectors from 4294967295 to 42949=
67288
[   13.116201] console [kbox0] enabled
[   13.180547] kbox: kbox module init success
[   13.180957] SIGKILL_catch: Planted jprobe at ffffffff81074b90, handler=
 addr ffffffffa044d7b0
[   17.160360] device-mapper: uevent: version 1.0.3
[   17.160670] device-mapper: ioctl: 4.23.0-ioctl (2012-07-25) initialise=
d: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[   30.772760] pcc-cpufreq: (v1.10.00) driver loaded with frequency limit=
s: 1200 MHz, 2600 MHz
[   32.898948] NET: Registered protocol family 17
[   32.933874] be2net 0000:04:00.0: eth0: Link down
[   32.940528] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   61.228303] be2net 0000:04:00.1: eth1: Link up
[   63.103173] ipmi message handler version 39.2
[   63.132161] IPMI System Interface driver.
[   63.132236] ipmi_si: probing via ACPI
[   63.132307] ipmi_si 00:03: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq=
 0
[   63.132311] ipmi_si: Adding ACPI-specified kcs state machine
[   63.132341] ipmi_si: probing via SMBIOS
[   63.132347] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   63.132351] ipmi_si: Adding SMBIOS-specified kcs state machine duplica=
te interface
[   63.132358] ipmi_si: probing via SPMI
[   63.132363] ipmi_si: SPMI: io 0xca2 regsize 2 spacing 2 irq 0
[   63.132367] ipmi_si: Adding SPMI-specified kcs state machine duplicate=
 interface
[   63.132374] ipmi_si: Trying ACPI-specified kcs state machine at i/o ad=
dress 0xca2, slave address 0x0, irq 0
[   63.290971] ipmi_si 00:03: Found new BMC (man_id: 0x00000b, prod_id: 0=
x2020, dev_id: 0x13)
[   63.290986] ipmi_si 00:03: IPMI kcs interface initialized
[   63.296326] ipmi device interface
[   64.117253] Dump module init successful
[   64.783455] Ebtables v2.0 registered
[   64.823599] ip_tables: (C) 2000-2006 Netfilter Core Team
[   64.828877] type=3D1325 audit(1405607370.331:2): table=3Dfilter family=
=3D2 entries=3D0
[   64.828958] type=3D1300 audit(1405607370.331:2): arch=3Dc000003e sysca=
ll=3D175 success=3Dyes exit=3D0 a0=3D7f28f8407000 a1=3D1ea6 a2=3D61e220 a=
3=3D7fff76af8d40 items=3D0 ppid=3D10071 pid=3D10072 auid=3D4294967295 uid=
=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D=
(none) ses=3D4294967295 comm=3D"modprobe" exe=3D"/sbin/modprobe" key=3D(n=
ull)
[   64.845876] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   64.850795] type=3D1325 audit(1405607370.351:3): table=3Dfilter family=
=3D10 entries=3D0
[   64.850876] type=3D1300 audit(1405607370.351:3): arch=3Dc000003e sysca=
ll=3D175 success=3Dyes exit=3D0 a0=3D7fb49f81d000 a1=3D1e8e a2=3D61e220 a=
3=3D7fff5d5018c0 items=3D0 ppid=3D10077 pid=3D10078 auid=3D4294967295 uid=
=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D=
(none) ses=3D4294967295 comm=3D"modprobe" exe=3D"/sbin/modprobe" key=3D(n=
ull)
[   65.149769] 2014-07-17 14:29:30: libvirtd[10036] try to send SIGKILL t=
o qemu-kvm[10088]
[   65.294836] type=3D1325 audit(1405607370.795:4): table=3Dfilter family=
=3D2 entries=3D0
[   65.294950] type=3D1325 audit(1405607370.795:4): table=3Dfilter family=
=3D10 entries=3D0
[   65.295550] type=3D1300 audit(1405607370.795:4): arch=3Dc000003e sysca=
ll=3D56 success=3Dyes exit=3D10116 a0=3D6c020011 a1=3D7f463001fe80 a2=3D8=
 a3=3D0 items=3D0 ppid=3D1 pid=3D10036 auid=3D4294967295 uid=3D0 gid=3D0 =
euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D=
4294967295 comm=3D"libvirtd" exe=3D"/usr/sbin/libvirtd" key=3D(null)
[   65.295605] type=3D1300 audit(1405607370.795:5): arch=3Dc000003e sysca=
ll=3D56 success=3Dyes exit=3D0 a0=3D6c020011 a1=3D7f463001fe80 a2=3D8 a3=3D=
0 items=3D0 ppid=3D10036 pid=3D10116 auid=3D4294967295 uid=3D0 gid=3D0 eu=
id=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D=
4294967295 comm=3D"libvirtd" exe=3D"/usr/sbin/libvirtd" key=3D(null)
[   65.295618] type=3D1317 audit(1405607370.795:5): fd0=3D0 fd1=3D0
[   69.276656] type=3D2404 audit(1405607374.787:6): user pid=3D10362 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dserver fp=
=3Dbe:ad:b5:d8:34:7b:18:09:48:73:0a:d0:f7:09:1a:e0 [MD5] direction=3D? sp=
id=3D10362 suid=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.15=
6.2.180, terminal=3D? res=3Dsuccess)'
[   72.083643] eth1: no IPv6 routers present
[   74.387848] audit_printk_skb: 12 callbacks suppressed
[   74.411257] type=3D1100 audit(1405607379.911:11): user pid=3D10135 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:authentication ac=
ct=3D"root" exe=3D"/bin/login" (hostname=3D?, addr=3D?, terminal=3D/dev/t=
ty1 res=3Dfailed)'
[   74.411414] type=3D1112 audit(1405607379.935:12): user pid=3D10135 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dlogin acct=3D"root" e=
xe=3D"/bin/login" (hostname=3D?, addr=3D?, terminal=3Dtty1 res=3Dfailed)'
[   85.149239] type=3D1100 audit(1405607390.695:13): user pid=3D10135 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:authentication ac=
ct=3D"root" exe=3D"/bin/login" (hostname=3D?, addr=3D?, terminal=3D/dev/t=
ty1 res=3Dfailed)'
[   85.149303] type=3D1112 audit(1405607390.695:14): user pid=3D10135 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dlogin acct=3D"root" e=
xe=3D"/bin/login" (hostname=3D?, addr=3D?, terminal=3Dtty1 res=3Dfailed)'
[   90.089681] type=3D2404 audit(1405607395.647:15): user pid=3D10621 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dserver=
 fp=3Dbe:ad:b5:d8:34:7b:18:09:48:73:0a:d0:f7:09:1a:e0 [MD5] direction=3D?=
 spid=3D10621 suid=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156=
.156.2.180, terminal=3D? res=3Dsuccess)'
[   90.089808] type=3D2404 audit(1405607395.647:16): user pid=3D10621 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dserver=
 fp=3D35:88:b2:86:82:a2:e8:a9:ef:3b:83:96:63:a9:f6:d3 [MD5] direction=3D?=
 spid=3D10621 suid=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156=
.156.2.180, terminal=3D? res=3Dsuccess)'
[   90.090008] type=3D2404 audit(1405607395.647:17): user pid=3D10621 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dserver=
 fp=3Dbb:ef:77:ed:c1:8b:8d:53:73:48:02:d2:e6:e3:00:60 [MD5] direction=3D?=
 spid=3D10621 suid=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156=
.156.2.180, terminal=3D? res=3Dsuccess)'
[   90.090494] type=3D2407 audit(1405607395.647:18): user pid=3D10620 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dstart direction=3Dfro=
m-client cipher=3Daes256-ctr ksize=3D256 spid=3D10621 suid=3D71 rport=3D5=
9176 laddr=3D156.4.110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D=
?, addr=3D156.156.2.180, terminal=3D? res=3Dsuccess)'
[   90.090639] type=3D2407 audit(1405607395.647:19): user pid=3D10620 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dstart direction=3Dfro=
m-server cipher=3Daes256-ctr ksize=3D256 spid=3D10621 suid=3D71 rport=3D5=
9176 laddr=3D156.4.110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D=
?, addr=3D156.156.2.180, terminal=3D? res=3Dsuccess)'
[   96.263375] type=3D1101 audit(1405607401.831:20): user pid=3D10734 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[   96.263424] type=3D1101 audit(1405607401.831:21): user pid=3D10735 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[   96.263445] type=3D1101 audit(1405607401.831:22): user pid=3D10733 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[   96.263462] type=3D1103 audit(1405607401.831:23): user pid=3D10734 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[   96.263506] type=3D1103 audit(1405607401.831:24): user pid=3D10735 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[   96.263521] type=3D1103 audit(1405607401.831:25): user pid=3D10733 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[   96.263556] type=3D1006 audit(1405607401.835:26): login pid=3D10734 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D1
[   96.263600] type=3D1006 audit(1405607401.835:27): login pid=3D10735 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D2
[   96.263617] type=3D1006 audit(1405607401.835:28): login pid=3D10733 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D3
[   96.272232] type=3D1105 audit(1405607401.843:29): user pid=3D10733 uid=
=3D0 auid=3D0 ses=3D3 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D"/=
usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  156.253472] audit_printk_skb: 63 callbacks suppressed
[  156.278591] type=3D1101 audit(1405607461.951:51): user pid=3D11609 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  156.278618] type=3D1101 audit(1405607461.979:52): user pid=3D11610 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  156.278688] type=3D1103 audit(1405607461.979:53): user pid=3D11609 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[  156.278708] type=3D1103 audit(1405607461.979:54): user pid=3D11610 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[  156.278801] type=3D1006 audit(1405607461.979:55): login pid=3D11610 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D5
[  156.278817] type=3D1006 audit(1405607461.979:56): login pid=3D11609 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D6
[  156.279127] type=3D1105 audit(1405607461.979:57): user pid=3D11610 uid=
=3D0 auid=3D0 ses=3D5 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D"/=
usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  156.279317] type=3D1105 audit(1405607461.979:58): user pid=3D11609 uid=
=3D0 auid=3D0 ses=3D6 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D"/=
usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  156.282452] type=3D1104 audit(1405607461.983:59): user pid=3D11610 uid=
=3D0 auid=3D0 ses=3D5 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr/s=
bin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  156.282736] type=3D1106 audit(1405607461.983:60): user pid=3D11610 uid=
=3D0 auid=3D0 ses=3D5 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D"=
/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  173.475748] DRHD: handling fault status reg 2
[  173.495919] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[  173.495921] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  173.562686] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[  173.562687] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  173.630269] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[  173.630271] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  173.697341] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[  173.697342] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  215.349947] audit_printk_skb: 45 callbacks suppressed
[  215.373454] type=3D1101 audit(1405607521.175:76): user pid=3D12415 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  215.373548] type=3D1103 audit(1405607521.199:77): user pid=3D12415 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[  215.373677] type=3D1006 audit(1405607521.199:78): login pid=3D12415 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D8
[  215.374107] type=3D1105 audit(1405607521.199:79): user pid=3D12415 uid=
=3D0 auid=3D0 ses=3D8 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D"/=
usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  215.377416] type=3D1104 audit(1405607521.203:80): user pid=3D12415 uid=
=3D0 auid=3D0 ses=3D8 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr/s=
bin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  215.377611] type=3D1106 audit(1405607521.203:81): user pid=3D12415 uid=
=3D0 auid=3D0 ses=3D8 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D"=
/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  275.251799] type=3D1101 audit(1405607581.207:82): user pid=3D13151 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  275.251877] type=3D1103 audit(1405607581.207:83): user pid=3D13151 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[  275.251968] type=3D1006 audit(1405607581.207:84): login pid=3D13151 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D9
[  275.252278] type=3D1105 audit(1405607581.207:85): user pid=3D13151 uid=
=3D0 auid=3D0 ses=3D9 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D"/=
usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  275.255545] type=3D1104 audit(1405607581.211:86): user pid=3D13151 uid=
=3D0 auid=3D0 ses=3D9 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr/s=
bin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  275.255735] type=3D1106 audit(1405607581.211:87): user pid=3D13151 uid=
=3D0 auid=3D0 ses=3D9 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D"=
/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  283.239739] type=3D2404 audit(1405607589.211:88): user pid=3D13246 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dserver=
 fp=3Dbe:ad:b5:d8:34:7b:18:09:48:73:0a:d0:f7:09:1a:e0 [MD5] direction=3D?=
 spid=3D13246 suid=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156=
.156.2.176, terminal=3D? res=3Dsuccess)'
[  283.239870] type=3D2404 audit(1405607589.211:89): user pid=3D13246 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dserver=
 fp=3D35:88:b2:86:82:a2:e8:a9:ef:3b:83:96:63:a9:f6:d3 [MD5] direction=3D?=
 spid=3D13246 suid=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156=
.156.2.176, terminal=3D? res=3Dsuccess)'
[  283.240067] type=3D2404 audit(1405607589.211:90): user pid=3D13246 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dserver=
 fp=3Dbb:ef:77:ed:c1:8b:8d:53:73:48:02:d2:e6:e3:00:60 [MD5] direction=3D?=
 spid=3D13246 suid=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156=
.156.2.176, terminal=3D? res=3Dsuccess)'
[  283.240550] type=3D2407 audit(1405607589.211:91): user pid=3D13245 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dstart direction=3Dfro=
m-client cipher=3Daes256-ctr ksize=3D256 spid=3D13246 suid=3D71 rport=3D6=
1280 laddr=3D156.4.110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D=
?, addr=3D156.156.2.176, terminal=3D? res=3Dsuccess)'
[  283.240697] type=3D2407 audit(1405607589.211:92): user pid=3D13245 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dstart direction=3Dfro=
m-server cipher=3Daes256-ctr ksize=3D256 spid=3D13246 suid=3D71 rport=3D6=
1280 laddr=3D156.4.110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D=
?, addr=3D156.156.2.176, terminal=3D? res=3Dsuccess)'
[  284.169211] type=3D1100 audit(1405607590.143:93): user pid=3D13254 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:authentication ac=
ct=3D"root" exe=3D"/usr/sbin/sshd" (hostname=3D156.156.2.176, addr=3D156.=
156.2.176, terminal=3Dssh res=3Dsuccess)'
[  284.169349] type=3D1101 audit(1405607590.143:94): user pid=3D13254 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/sshd" (hostname=3D156.156.2.176, addr=3D156.156.2=
.176, terminal=3Dssh res=3Dsuccess)'
[  284.245192] type=3D2404 audit(1405607590.219:95): user pid=3D13245 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dsessio=
n fp=3D? direction=3Dboth spid=3D13246 suid=3D71 rport=3D61280 laddr=3D15=
6.4.110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156=
.156.2.176, terminal=3D? res=3Dsuccess)'
[  284.245790] type=3D1100 audit(1405607590.219:96): user pid=3D13245 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dsuccess acct=3D"root"=
 exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156.2.176, terminal=3Ds=
sh res=3Dsuccess)'
[  284.246142] type=3D1103 audit(1405607590.219:97): user pid=3D13245 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/sshd" (hostname=3D156.156.2.176, addr=3D156.156.2.1=
76, terminal=3Dssh res=3Dsuccess)'
[  335.129914] audit_printk_skb: 24 callbacks suppressed
[  335.153341] type=3D1101 audit(1405607641.215:106): user pid=3D13940 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  335.153427] type=3D1103 audit(1405607641.239:107): user pid=3D13940 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  335.153519] type=3D1006 audit(1405607641.239:108): login pid=3D13940 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
11
[  335.153855] type=3D1105 audit(1405607641.239:109): user pid=3D13940 ui=
d=3D0 auid=3D0 ses=3D11 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  335.157057] type=3D1104 audit(1405607641.239:110): user pid=3D13940 ui=
d=3D0 auid=3D0 ses=3D11 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  335.157270] type=3D1106 audit(1405607641.243:111): user pid=3D13940 ui=
d=3D0 auid=3D0 ses=3D11 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  354.237427] DRHD: handling fault status reg 402
[  354.258474] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[  354.258477] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  354.327010] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[  354.327011] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  354.401175] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[  354.401177] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  354.472394] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[  354.472395] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  395.031420] type=3D1101 audit(1405607701.243:112): user pid=3D14682 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  395.031496] type=3D1103 audit(1405607701.243:113): user pid=3D14682 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  395.031586] type=3D1006 audit(1405607701.243:114): login pid=3D14682 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
12
[  395.031894] type=3D1105 audit(1405607701.243:115): user pid=3D14682 ui=
d=3D0 auid=3D0 ses=3D12 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  395.035111] type=3D1104 audit(1405607701.247:116): user pid=3D14682 ui=
d=3D0 auid=3D0 ses=3D12 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  395.035319] type=3D1106 audit(1405607701.247:117): user pid=3D14682 ui=
d=3D0 auid=3D0 ses=3D12 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  454.909457] type=3D1101 audit(1405607761.251:118): user pid=3D15409 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  454.909536] type=3D1103 audit(1405607761.251:119): user pid=3D15409 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  454.909624] type=3D1006 audit(1405607761.251:120): login pid=3D15409 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
13
[  454.909931] type=3D1105 audit(1405607761.251:121): user pid=3D15409 ui=
d=3D0 auid=3D0 ses=3D13 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  454.913194] type=3D1104 audit(1405607761.255:122): user pid=3D15409 ui=
d=3D0 auid=3D0 ses=3D13 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  454.913391] type=3D1106 audit(1405607761.255:123): user pid=3D15409 ui=
d=3D0 auid=3D0 ses=3D13 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  514.787511] type=3D1101 audit(1405607821.259:124): user pid=3D16114 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  514.787586] type=3D1103 audit(1405607821.259:125): user pid=3D16114 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  514.787676] type=3D1006 audit(1405607821.259:126): login pid=3D16114 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
14
[  514.787984] type=3D1105 audit(1405607821.259:127): user pid=3D16114 ui=
d=3D0 auid=3D0 ses=3D14 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  514.791267] type=3D1104 audit(1405607821.263:128): user pid=3D16114 ui=
d=3D0 auid=3D0 ses=3D14 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  514.791467] type=3D1106 audit(1405607821.263:129): user pid=3D16114 ui=
d=3D0 auid=3D0 ses=3D14 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  534.988908] DRHD: handling fault status reg 2
[  535.009152] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[  535.009155] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  535.078104] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[  535.078113] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  535.147867] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[  535.147869] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  535.220080] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[  535.220082] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  574.665573] type=3D1101 audit(1405607881.267:130): user pid=3D16843 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  574.665649] type=3D1103 audit(1405607881.267:131): user pid=3D16843 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  574.665737] type=3D1006 audit(1405607881.267:132): login pid=3D16843 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
15
[  574.666078] type=3D1105 audit(1405607881.267:133): user pid=3D16843 ui=
d=3D0 auid=3D0 ses=3D15 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  574.669262] type=3D1104 audit(1405607881.267:134): user pid=3D16843 ui=
d=3D0 auid=3D0 ses=3D15 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  574.669471] type=3D1106 audit(1405607881.271:135): user pid=3D16843 ui=
d=3D0 auid=3D0 ses=3D15 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  634.543510] type=3D1101 audit(1405607941.271:136): user pid=3D17570 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  634.543584] type=3D1103 audit(1405607941.271:137): user pid=3D17570 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  634.543672] type=3D1006 audit(1405607941.271:138): login pid=3D17570 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
16
[  634.543981] type=3D1105 audit(1405607941.271:139): user pid=3D17570 ui=
d=3D0 auid=3D0 ses=3D16 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  634.547228] type=3D1104 audit(1405607941.275:140): user pid=3D17570 ui=
d=3D0 auid=3D0 ses=3D16 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  634.547418] type=3D1106 audit(1405607941.275:141): user pid=3D17570 ui=
d=3D0 auid=3D0 ses=3D16 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  694.421479] type=3D1101 audit(1405608001.279:142): user pid=3D18274 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  694.421554] type=3D1103 audit(1405608001.279:143): user pid=3D18274 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  694.421643] type=3D1006 audit(1405608001.279:144): login pid=3D18274 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
17
[  694.421948] type=3D1105 audit(1405608001.279:145): user pid=3D18274 ui=
d=3D0 auid=3D0 ses=3D17 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  694.425212] type=3D1104 audit(1405608001.283:146): user pid=3D18274 ui=
d=3D0 auid=3D0 ses=3D17 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  694.425421] type=3D1106 audit(1405608001.283:147): user pid=3D18274 ui=
d=3D0 auid=3D0 ses=3D17 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  715.451118] DRHD: handling fault status reg 402
[  715.472156] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[  715.472158] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  715.534930] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[  715.534932] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  715.597477] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[  715.597479] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  715.660394] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[  715.660396] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  754.299578] type=3D1101 audit(1405608061.287:148): user pid=3D19008 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  754.299653] type=3D1103 audit(1405608061.287:149): user pid=3D19008 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  754.299743] type=3D1006 audit(1405608061.287:150): login pid=3D19008 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
18
[  754.300051] type=3D1105 audit(1405608061.287:151): user pid=3D19008 ui=
d=3D0 auid=3D0 ses=3D18 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  754.303354] type=3D1104 audit(1405608061.291:152): user pid=3D19008 ui=
d=3D0 auid=3D0 ses=3D18 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  754.303550] type=3D1106 audit(1405608061.291:153): user pid=3D19008 ui=
d=3D0 auid=3D0 ses=3D18 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  814.177631] type=3D1101 audit(1405608121.295:154): user pid=3D19728 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  814.177707] type=3D1103 audit(1405608121.295:155): user pid=3D19728 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  814.177798] type=3D1006 audit(1405608121.295:156): login pid=3D19728 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
19
[  814.178125] type=3D1105 audit(1405608121.295:157): user pid=3D19728 ui=
d=3D0 auid=3D0 ses=3D19 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  814.181406] type=3D1104 audit(1405608121.295:158): user pid=3D19728 ui=
d=3D0 auid=3D0 ses=3D19 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  814.181657] type=3D1106 audit(1405608121.299:159): user pid=3D19728 ui=
d=3D0 auid=3D0 ses=3D19 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  874.055772] type=3D1101 audit(1405608181.299:160): user pid=3D20455 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  874.055846] type=3D1103 audit(1405608181.299:161): user pid=3D20455 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  874.055937] type=3D1006 audit(1405608181.299:162): login pid=3D20455 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
20
[  874.056244] type=3D1105 audit(1405608181.299:163): user pid=3D20455 ui=
d=3D0 auid=3D0 ses=3D20 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  874.059487] type=3D1104 audit(1405608181.303:164): user pid=3D20455 ui=
d=3D0 auid=3D0 ses=3D20 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  874.059679] type=3D1106 audit(1405608181.303:165): user pid=3D20455 ui=
d=3D0 auid=3D0 ses=3D20 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  896.212497] DRHD: handling fault status reg 2
[  896.234503] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[  896.234505] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  896.310159] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[  896.310161] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  896.383462] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[  896.383464] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  896.455233] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[  896.455235] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[  933.933807] type=3D1101 audit(1405608241.307:166): user pid=3D21167 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  933.933882] type=3D1103 audit(1405608241.307:167): user pid=3D21167 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  933.933972] type=3D1006 audit(1405608241.307:168): login pid=3D21167 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
21
[  933.934281] type=3D1105 audit(1405608241.307:169): user pid=3D21167 ui=
d=3D0 auid=3D0 ses=3D21 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  933.937497] type=3D1104 audit(1405608241.311:170): user pid=3D21167 ui=
d=3D0 auid=3D0 ses=3D21 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  933.937708] type=3D1106 audit(1405608241.311:171): user pid=3D21167 ui=
d=3D0 auid=3D0 ses=3D21 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  993.811869] type=3D1101 audit(1405608301.315:172): user pid=3D21932 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  993.811922] type=3D1101 audit(1405608301.315:173): user pid=3D21933 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  993.811946] type=3D1103 audit(1405608301.315:174): user pid=3D21932 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  993.811996] type=3D1103 audit(1405608301.315:175): user pid=3D21933 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  993.812037] type=3D1006 audit(1405608301.315:176): login pid=3D21932 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
22
[  993.812083] type=3D1006 audit(1405608301.315:177): login pid=3D21933 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
23
[  993.812187] type=3D1101 audit(1405608301.315:178): user pid=3D21934 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[  993.812262] type=3D1103 audit(1405608301.315:179): user pid=3D21934 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[  993.812353] type=3D1105 audit(1405608301.315:180): user pid=3D21932 ui=
d=3D0 auid=3D0 ses=3D22 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[  993.812361] type=3D1006 audit(1405608301.315:181): login pid=3D21934 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
24
[ 1053.727066] audit_printk_skb: 24 callbacks suppressed
[ 1053.750452] type=3D1101 audit(1405608361.359:190): user pid=3D22679 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1053.750477] type=3D1101 audit(1405608361.383:191): user pid=3D22680 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1053.750561] type=3D1103 audit(1405608361.383:192): user pid=3D22679 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1053.750579] type=3D1103 audit(1405608361.383:193): user pid=3D22680 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1053.750674] type=3D1006 audit(1405608361.383:194): login pid=3D22680 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
25
[ 1053.750688] type=3D1006 audit(1405608361.383:195): login pid=3D22679 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
26
[ 1053.750980] type=3D1105 audit(1405608361.383:196): user pid=3D22680 ui=
d=3D0 auid=3D0 ses=3D25 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1053.751192] type=3D1105 audit(1405608361.383:197): user pid=3D22679 ui=
d=3D0 auid=3D0 ses=3D26 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1053.754278] type=3D1104 audit(1405608361.387:198): user pid=3D22680 ui=
d=3D0 auid=3D0 ses=3D25 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1053.754479] type=3D1106 audit(1405608361.387:199): user pid=3D22680 ui=
d=3D0 auid=3D0 ses=3D25 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1076.964015] DRHD: handling fault status reg 402
[ 1076.984935] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 1076.984937] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1077.053758] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 1077.053760] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1077.122764] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 1077.122766] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1077.192944] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 1077.192946] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1113.681802] audit_printk_skb: 6 callbacks suppressed
[ 1113.704897] type=3D1101 audit(1405608421.443:202): user pid=3D23414 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1113.704995] type=3D1103 audit(1405608421.467:203): user pid=3D23414 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1113.705107] type=3D1006 audit(1405608421.467:204): login pid=3D23414 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
27
[ 1113.705448] type=3D1105 audit(1405608421.467:205): user pid=3D23414 ui=
d=3D0 auid=3D0 ses=3D27 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1113.708681] type=3D1104 audit(1405608421.471:206): user pid=3D23414 ui=
d=3D0 auid=3D0 ses=3D27 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1113.708890] type=3D1106 audit(1405608421.471:207): user pid=3D23414 ui=
d=3D0 auid=3D0 ses=3D27 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1173.582991] type=3D1101 audit(1405608481.471:208): user pid=3D24142 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1173.583065] type=3D1103 audit(1405608481.471:209): user pid=3D24142 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1173.583155] type=3D1006 audit(1405608481.471:210): login pid=3D24142 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
28
[ 1173.583471] type=3D1105 audit(1405608481.471:211): user pid=3D24142 ui=
d=3D0 auid=3D0 ses=3D28 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1173.586708] type=3D1104 audit(1405608481.475:212): user pid=3D24142 ui=
d=3D0 auid=3D0 ses=3D28 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1173.586901] type=3D1106 audit(1405608481.475:213): user pid=3D24142 ui=
d=3D0 auid=3D0 ses=3D28 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1233.461012] type=3D1101 audit(1405608541.479:214): user pid=3D24869 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1233.461090] type=3D1103 audit(1405608541.479:215): user pid=3D24869 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1233.461180] type=3D1006 audit(1405608541.479:216): login pid=3D24869 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
29
[ 1233.461487] type=3D1105 audit(1405608541.479:217): user pid=3D24869 ui=
d=3D0 auid=3D0 ses=3D29 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1233.464732] type=3D1104 audit(1405608541.483:218): user pid=3D24869 ui=
d=3D0 auid=3D0 ses=3D29 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1233.464928] type=3D1106 audit(1405608541.483:219): user pid=3D24869 ui=
d=3D0 auid=3D0 ses=3D29 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1257.726004] DRHD: handling fault status reg 2
[ 1257.745905] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 1257.745907] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1257.814858] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 1257.814860] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1257.886046] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 1257.886048] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1257.957446] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 1257.957448] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1293.339087] type=3D1101 audit(1405608601.487:220): user pid=3D25589 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1293.339161] type=3D1103 audit(1405608601.487:221): user pid=3D25589 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1293.339252] type=3D1006 audit(1405608601.487:222): login pid=3D25589 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
30
[ 1293.339558] type=3D1105 audit(1405608601.487:223): user pid=3D25589 ui=
d=3D0 auid=3D0 ses=3D30 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1293.342892] type=3D1104 audit(1405608601.491:224): user pid=3D25589 ui=
d=3D0 auid=3D0 ses=3D30 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1293.343088] type=3D1106 audit(1405608601.491:225): user pid=3D25589 ui=
d=3D0 auid=3D0 ses=3D30 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1353.217184] type=3D1101 audit(1405608661.495:226): user pid=3D26301 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1353.217257] type=3D1103 audit(1405608661.495:227): user pid=3D26301 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1353.217369] type=3D1006 audit(1405608661.495:228): login pid=3D26301 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
31
[ 1353.217675] type=3D1105 audit(1405608661.495:229): user pid=3D26301 ui=
d=3D0 auid=3D0 ses=3D31 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1353.220885] type=3D1104 audit(1405608661.499:230): user pid=3D26301 ui=
d=3D0 auid=3D0 ses=3D31 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1353.221075] type=3D1106 audit(1405608661.499:231): user pid=3D26301 ui=
d=3D0 auid=3D0 ses=3D31 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1413.095152] type=3D1101 audit(1405608721.499:232): user pid=3D27053 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1413.095227] type=3D1103 audit(1405608721.499:233): user pid=3D27053 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1413.095315] type=3D1006 audit(1405608721.499:234): login pid=3D27053 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
32
[ 1413.095623] type=3D1105 audit(1405608721.499:235): user pid=3D27053 ui=
d=3D0 auid=3D0 ses=3D32 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1413.098897] type=3D1104 audit(1405608721.503:236): user pid=3D27053 ui=
d=3D0 auid=3D0 ses=3D32 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1413.099088] type=3D1106 audit(1405608721.503:237): user pid=3D27053 ui=
d=3D0 auid=3D0 ses=3D32 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1438.477262] DRHD: handling fault status reg 402
[ 1438.498278] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 1438.498280] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1438.566458] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 1438.566460] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1438.635211] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 1438.635213] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1438.703849] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 1438.703851] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1472.973244] type=3D1101 audit(1405608781.507:238): user pid=3D27846 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1472.973319] type=3D1103 audit(1405608781.507:239): user pid=3D27846 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1472.973412] type=3D1006 audit(1405608781.507:240): login pid=3D27846 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
33
[ 1472.973727] type=3D1105 audit(1405608781.507:241): user pid=3D27846 ui=
d=3D0 auid=3D0 ses=3D33 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1472.976970] type=3D1104 audit(1405608781.511:242): user pid=3D27846 ui=
d=3D0 auid=3D0 ses=3D33 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1472.977166] type=3D1106 audit(1405608781.511:243): user pid=3D27846 ui=
d=3D0 auid=3D0 ses=3D33 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1532.851264] type=3D1101 audit(1405608841.515:244): user pid=3D28550 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1532.851337] type=3D1103 audit(1405608841.515:245): user pid=3D28550 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1532.851427] type=3D1006 audit(1405608841.515:246): login pid=3D28550 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
34
[ 1532.851734] type=3D1105 audit(1405608841.515:247): user pid=3D28550 ui=
d=3D0 auid=3D0 ses=3D34 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1532.855001] type=3D1104 audit(1405608841.519:248): user pid=3D28550 ui=
d=3D0 auid=3D0 ses=3D34 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1532.855217] type=3D1106 audit(1405608841.519:249): user pid=3D28550 ui=
d=3D0 auid=3D0 ses=3D34 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1592.729344] type=3D1101 audit(1405608901.523:250): user pid=3D29277 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1592.729419] type=3D1103 audit(1405608901.523:251): user pid=3D29277 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1592.729528] type=3D1006 audit(1405608901.523:252): login pid=3D29277 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
35
[ 1592.729841] type=3D1105 audit(1405608901.523:253): user pid=3D29277 ui=
d=3D0 auid=3D0 ses=3D35 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1592.733073] type=3D1104 audit(1405608901.527:254): user pid=3D29277 ui=
d=3D0 auid=3D0 ses=3D35 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1592.733264] type=3D1106 audit(1405608901.527:255): user pid=3D29277 ui=
d=3D0 auid=3D0 ses=3D35 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1619.238616] DRHD: handling fault status reg 2
[ 1619.258942] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 1619.258945] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1619.331099] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 1619.331101] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1619.403716] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 1619.403718] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1619.475130] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 1619.475132] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1652.607393] type=3D1101 audit(1405608961.527:256): user pid=3D30017 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1652.607472] type=3D1103 audit(1405608961.527:257): user pid=3D30017 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1652.607562] type=3D1006 audit(1405608961.527:258): login pid=3D30017 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
36
[ 1652.607873] type=3D1105 audit(1405608961.527:259): user pid=3D30017 ui=
d=3D0 auid=3D0 ses=3D36 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1652.611159] type=3D1104 audit(1405608961.531:260): user pid=3D30017 ui=
d=3D0 auid=3D0 ses=3D36 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1652.611353] type=3D1106 audit(1405608961.531:261): user pid=3D30017 ui=
d=3D0 auid=3D0 ses=3D36 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1712.485434] type=3D1101 audit(1405609021.535:262): user pid=3D30723 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1712.485509] type=3D1103 audit(1405609021.535:263): user pid=3D30723 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1712.485597] type=3D1006 audit(1405609021.535:264): login pid=3D30723 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
37
[ 1712.485905] type=3D1105 audit(1405609021.535:265): user pid=3D30723 ui=
d=3D0 auid=3D0 ses=3D37 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1712.489170] type=3D1104 audit(1405609021.539:266): user pid=3D30723 ui=
d=3D0 auid=3D0 ses=3D37 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1712.489360] type=3D1106 audit(1405609021.539:267): user pid=3D30723 ui=
d=3D0 auid=3D0 ses=3D37 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1772.363517] type=3D1101 audit(1405609081.543:268): user pid=3D31488 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1772.363591] type=3D1103 audit(1405609081.543:269): user pid=3D31488 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1772.363680] type=3D1006 audit(1405609081.543:270): login pid=3D31488 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
38
[ 1772.363993] type=3D1105 audit(1405609081.543:271): user pid=3D31488 ui=
d=3D0 auid=3D0 ses=3D38 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1772.367250] type=3D1104 audit(1405609081.547:272): user pid=3D31488 ui=
d=3D0 auid=3D0 ses=3D38 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1772.367444] type=3D1106 audit(1405609081.547:273): user pid=3D31488 ui=
d=3D0 auid=3D0 ses=3D38 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1800.000489] DRHD: handling fault status reg 402
[ 1800.021541] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 1800.021543] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1800.091690] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 1800.091692] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1800.163050] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 1800.163052] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1800.234259] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 1800.234261] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1832.241594] type=3D1101 audit(1405609141.551:274): user pid=3D32270 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1832.241669] type=3D1103 audit(1405609141.551:275): user pid=3D32270 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1832.241783] type=3D1006 audit(1405609141.551:276): login pid=3D32270 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
39
[ 1832.242093] type=3D1105 audit(1405609141.551:277): user pid=3D32270 ui=
d=3D0 auid=3D0 ses=3D39 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1832.245347] type=3D1104 audit(1405609141.555:278): user pid=3D32270 ui=
d=3D0 auid=3D0 ses=3D39 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1832.245541] type=3D1106 audit(1405609141.555:279): user pid=3D32270 ui=
d=3D0 auid=3D0 ses=3D39 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1892.119680] type=3D1101 audit(1405609201.555:280): user pid=3D33036 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1892.119735] type=3D1101 audit(1405609201.555:281): user pid=3D33037 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1892.119755] type=3D1103 audit(1405609201.555:282): user pid=3D33036 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1892.119809] type=3D1103 audit(1405609201.555:283): user pid=3D33037 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1892.119844] type=3D1006 audit(1405609201.555:284): login pid=3D33036 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
40
[ 1892.119898] type=3D1006 audit(1405609201.555:285): login pid=3D33037 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
41
[ 1892.119983] type=3D1101 audit(1405609201.555:286): user pid=3D33038 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1892.120060] type=3D1103 audit(1405609201.555:287): user pid=3D33038 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1892.120151] type=3D1006 audit(1405609201.555:288): login pid=3D33038 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
42
[ 1892.120159] type=3D1105 audit(1405609201.555:289): user pid=3D33036 ui=
d=3D0 auid=3D0 ses=3D40 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1952.034809] audit_printk_skb: 24 callbacks suppressed
[ 1952.058277] type=3D1101 audit(1405609261.599:298): user pid=3D33768 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1952.058306] type=3D1101 audit(1405609261.623:299): user pid=3D33769 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 1952.058393] type=3D1103 audit(1405609261.623:300): user pid=3D33769 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1952.058409] type=3D1103 audit(1405609261.623:301): user pid=3D33768 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 1952.058486] type=3D1006 audit(1405609261.623:302): login pid=3D33769 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
43
[ 1952.058503] type=3D1006 audit(1405609261.623:303): login pid=3D33768 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
44
[ 1952.058796] type=3D1105 audit(1405609261.623:304): user pid=3D33769 ui=
d=3D0 auid=3D0 ses=3D43 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1952.058812] type=3D1105 audit(1405609261.623:305): user pid=3D33768 ui=
d=3D0 auid=3D0 ses=3D44 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1952.062193] type=3D1104 audit(1405609261.627:306): user pid=3D33769 ui=
d=3D0 auid=3D0 ses=3D43 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1952.062384] type=3D1106 audit(1405609261.627:307): user pid=3D33769 ui=
d=3D0 auid=3D0 ses=3D43 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 1980.751842] DRHD: handling fault status reg 2
[ 1980.772115] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 1980.772117] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1980.841550] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 1980.841552] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1980.913924] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 1980.913926] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 1980.985694] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 1980.985696] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2011.988914] audit_printk_skb: 6 callbacks suppressed
[ 2012.012315] type=3D1101 audit(1405609321.683:310): user pid=3D34518 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2012.012460] type=3D1103 audit(1405609321.707:311): user pid=3D34518 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2012.012599] type=3D1006 audit(1405609321.707:312): login pid=3D34518 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
45
[ 2012.012913] type=3D1105 audit(1405609321.707:313): user pid=3D34518 ui=
d=3D0 auid=3D0 ses=3D45 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2012.016187] type=3D1104 audit(1405609321.711:314): user pid=3D34518 ui=
d=3D0 auid=3D0 ses=3D45 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2012.016381] type=3D1106 audit(1405609321.711:315): user pid=3D34518 ui=
d=3D0 auid=3D0 ses=3D45 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2071.890589] type=3D1101 audit(1405609381.715:316): user pid=3D35328 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2071.890675] type=3D1103 audit(1405609381.715:317): user pid=3D35328 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2071.890765] type=3D1006 audit(1405609381.715:318): login pid=3D35328 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
46
[ 2071.891080] type=3D1105 audit(1405609381.715:319): user pid=3D35328 ui=
d=3D0 auid=3D0 ses=3D46 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2071.894339] type=3D1104 audit(1405609381.719:320): user pid=3D35328 ui=
d=3D0 auid=3D0 ses=3D46 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2071.894532] type=3D1106 audit(1405609381.719:321): user pid=3D35328 ui=
d=3D0 auid=3D0 ses=3D46 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2131.768632] type=3D1101 audit(1405609441.723:322): user pid=3D36033 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2131.768728] type=3D1103 audit(1405609441.723:323): user pid=3D36033 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2131.768821] type=3D1006 audit(1405609441.723:324): login pid=3D36033 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
47
[ 2131.769128] type=3D1105 audit(1405609441.723:325): user pid=3D36033 ui=
d=3D0 auid=3D0 ses=3D47 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2131.772400] type=3D1104 audit(1405609441.727:326): user pid=3D36033 ui=
d=3D0 auid=3D0 ses=3D47 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2131.772591] type=3D1106 audit(1405609441.727:327): user pid=3D36033 ui=
d=3D0 auid=3D0 ses=3D47 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2161.513224] DRHD: handling fault status reg 402
[ 2161.534349] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 2161.534352] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2161.603361] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 2161.603363] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2161.675464] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 2161.675466] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2161.747014] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 2161.747016] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2191.646679] type=3D1101 audit(1405609501.727:328): user pid=3D36838 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2191.646756] type=3D1103 audit(1405609501.727:329): user pid=3D36838 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2191.646846] type=3D1006 audit(1405609501.727:330): login pid=3D36838 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
48
[ 2191.647157] type=3D1105 audit(1405609501.727:331): user pid=3D36838 ui=
d=3D0 auid=3D0 ses=3D48 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2191.650451] type=3D1104 audit(1405609501.731:332): user pid=3D36838 ui=
d=3D0 auid=3D0 ses=3D48 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2191.650659] type=3D1106 audit(1405609501.731:333): user pid=3D36838 ui=
d=3D0 auid=3D0 ses=3D48 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2251.524020] type=3D1101 audit(1405609561.735:334): user pid=3D45856 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2251.524074] type=3D1103 audit(1405609561.735:335): user pid=3D45856 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2251.524127] type=3D1006 audit(1405609561.735:336): login pid=3D45856 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
49
[ 2251.524311] type=3D1105 audit(1405609561.735:337): user pid=3D45856 ui=
d=3D0 auid=3D0 ses=3D49 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2251.547734] type=3D1104 audit(1405609561.759:338): user pid=3D45856 ui=
d=3D0 auid=3D0 ses=3D49 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2251.547852] type=3D1106 audit(1405609561.759:339): user pid=3D45856 ui=
d=3D0 auid=3D0 ses=3D49 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2292.147935] type=3D1100 audit(1405609602.447:340): user pid=3D11250 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:authentication a=
cct=3D"root" exe=3D"/bin/login" (hostname=3D?, addr=3D?, terminal=3D/dev/=
tty1 res=3Dfailed)'
[ 2292.148500] type=3D1112 audit(1405609602.447:341): user pid=3D11250 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dlogin acct=3D"root" =
exe=3D"/bin/login" (hostname=3D?, addr=3D?, terminal=3Dtty1 res=3Dfailed)=
'
[ 2299.085868] type=3D2404 audit(1405609609.399:342): user pid=3D8041 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dserver=
 fp=3Dbe:ad:b5:d8:34:7b:18:09:48:73:0a:d0:f7:09:1a:e0 [MD5] direction=3D?=
 spid=3D8041 suid=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.=
156.2.180, terminal=3D? res=3Dsuccess)'
[ 2299.085957] type=3D2404 audit(1405609609.399:343): user pid=3D8041 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dserver=
 fp=3D35:88:b2:86:82:a2:e8:a9:ef:3b:83:96:63:a9:f6:d3 [MD5] direction=3D?=
 spid=3D8041 suid=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.=
156.2.180, terminal=3D? res=3Dsuccess)'
[ 2299.086095] type=3D2404 audit(1405609609.399:344): user pid=3D8041 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dserver=
 fp=3Dbb:ef:77:ed:c1:8b:8d:53:73:48:02:d2:e6:e3:00:60 [MD5] direction=3D?=
 spid=3D8041 suid=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.=
156.2.180, terminal=3D? res=3Dsuccess)'
[ 2299.086719] type=3D2407 audit(1405609609.399:345): user pid=3D7988 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dstart direction=3Dfro=
m-client cipher=3Daes256-ctr ksize=3D256 spid=3D8041 suid=3D71 rport=3D60=
977 laddr=3D156.4.110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D=
?, addr=3D156.156.2.180, terminal=3D? res=3Dsuccess)'
[ 2299.086807] type=3D2407 audit(1405609609.399:346): user pid=3D7988 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dstart direction=3Dfro=
m-server cipher=3Daes256-ctr ksize=3D256 spid=3D8041 suid=3D71 rport=3D60=
977 laddr=3D156.4.110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D=
?, addr=3D156.156.2.180, terminal=3D? res=3Dsuccess)'
[ 2305.812769] type=3D1100 audit(1405609616.139:347): user pid=3D9028 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:authentication ac=
ct=3D"root" exe=3D"/usr/sbin/sshd" (hostname=3D156.156.2.180, addr=3D156.=
156.2.180, terminal=3Dssh res=3Dsuccess)'
[ 2305.812991] type=3D1101 audit(1405609616.139:348): user pid=3D9028 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/sshd" (hostname=3D156.156.2.180, addr=3D156.156.2=
.180, terminal=3Dssh res=3Dsuccess)'
[ 2305.883013] type=3D2404 audit(1405609616.211:349): user pid=3D7988 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Ddestroy kind=3Dsessio=
n fp=3D? direction=3Dboth spid=3D8041 suid=3D71 rport=3D60977 laddr=3D156=
.4.110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.=
156.2.180, terminal=3D? res=3Dsuccess)'
[ 2305.884127] type=3D1100 audit(1405609616.211:350): user pid=3D7988 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3Dsuccess acct=3D"root"=
 exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156.2.180, terminal=3Ds=
sh res=3Dsuccess)'
[ 2305.884566] type=3D1103 audit(1405609616.211:351): user pid=3D7988 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/sshd" (hostname=3D156.156.2.180, addr=3D156.156.2.1=
80, terminal=3Dssh res=3Dsuccess)'
[ 2305.884660] type=3D1006 audit(1405609616.211:352): login pid=3D7988 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D5=
0
[ 2305.885019] type=3D1105 audit(1405609616.211:353): user pid=3D7988 uid=
=3D0 auid=3D0 ses=3D50 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D"=
/usr/sbin/sshd" (hostname=3D156.156.2.180, addr=3D156.156.2.180, terminal=
=3Dssh res=3Dsuccess)'
[ 2306.025761] type=3D1112 audit(1405609616.355:354): user pid=3D10889 ui=
d=3D0 auid=3D0 ses=3D50 msg=3D'op=3Dlogin id=3D0 exe=3D"/usr/sbin/sshd" (=
hostname=3D156.156.2.180, addr=3D156.156.2.180, terminal=3D/dev/pts/2 res=
=3Dsuccess)'
[ 2306.025851] type=3D1105 audit(1405609616.355:355): user pid=3D10889 ui=
d=3D0 auid=3D0 ses=3D50 msg=3D'op=3Dlogin id=3D0 exe=3D"/usr/sbin/sshd" (=
hostname=3D156.156.2.180, addr=3D156.156.2.180, terminal=3D/dev/pts/2 res=
=3Dsuccess)'
[ 2306.026133] type=3D2404 audit(1405609616.355:356): user pid=3D10889 ui=
d=3D0 auid=3D0 ses=3D50 msg=3D'op=3Ddestroy kind=3Dserver fp=3Dbe:ad:b5:d=
8:34:7b:18:09:48:73:0a:d0:f7:09:1a:e0 [MD5] direction=3D? spid=3D10889 su=
id=3D0 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156.2.180, term=
inal=3Dpts/2 res=3Dsuccess)'
[ 2311.422087] audit_printk_skb: 9 callbacks suppressed
[ 2311.445105] type=3D1101 audit(1405609621.763:360): user pid=3D11010 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2311.445203] type=3D1103 audit(1405609621.783:361): user pid=3D11010 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2311.445308] type=3D1006 audit(1405609621.787:362): login pid=3D11010 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
51
[ 2311.445622] type=3D1105 audit(1405609621.787:363): user pid=3D11010 ui=
d=3D0 auid=3D0 ses=3D51 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2311.449000] type=3D1104 audit(1405609621.787:364): user pid=3D11010 ui=
d=3D0 auid=3D0 ses=3D51 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2311.449190] type=3D1106 audit(1405609621.787:365): user pid=3D11010 ui=
d=3D0 auid=3D0 ses=3D51 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2342.263898] DRHD: handling fault status reg 2
[ 2342.284314] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 2342.284316] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2342.353664] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 2342.353666] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2342.423658] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 2342.423660] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2342.494997] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 2342.494999] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2371.323430] type=3D1101 audit(1405609681.791:366): user pid=3D14247 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2371.323508] type=3D1103 audit(1405609681.791:367): user pid=3D14247 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2371.323600] type=3D1006 audit(1405609681.791:368): login pid=3D14247 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
52
[ 2371.323912] type=3D1105 audit(1405609681.791:369): user pid=3D14247 ui=
d=3D0 auid=3D0 ses=3D52 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2371.327239] type=3D1104 audit(1405609681.795:370): user pid=3D14247 ui=
d=3D0 auid=3D0 ses=3D52 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2371.327431] type=3D1106 audit(1405609681.795:371): user pid=3D14247 ui=
d=3D0 auid=3D0 ses=3D52 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2431.201668] type=3D1101 audit(1405609741.799:372): user pid=3D15028 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2431.201745] type=3D1103 audit(1405609741.799:373): user pid=3D15028 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2431.201837] type=3D1006 audit(1405609741.799:374): login pid=3D15028 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
53
[ 2431.202152] type=3D1105 audit(1405609741.799:375): user pid=3D15028 ui=
d=3D0 auid=3D0 ses=3D53 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2431.205423] type=3D1104 audit(1405609741.803:376): user pid=3D15028 ui=
d=3D0 auid=3D0 ses=3D53 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2431.205611] type=3D1106 audit(1405609741.803:377): user pid=3D15028 ui=
d=3D0 auid=3D0 ses=3D53 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2491.079875] type=3D1101 audit(1405609801.807:378): user pid=3D21481 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2491.079953] type=3D1103 audit(1405609801.807:379): user pid=3D21481 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2491.080044] type=3D1006 audit(1405609801.807:380): login pid=3D21481 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
54
[ 2491.080354] type=3D1105 audit(1405609801.807:381): user pid=3D21481 ui=
d=3D0 auid=3D0 ses=3D54 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2491.083695] type=3D1104 audit(1405609801.811:382): user pid=3D21481 ui=
d=3D0 auid=3D0 ses=3D54 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2491.083911] type=3D1106 audit(1405609801.811:383): user pid=3D21481 ui=
d=3D0 auid=3D0 ses=3D54 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2522.723761] DRHD: handling fault status reg 402
[ 2522.744868] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 2522.744870] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2522.815472] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 2522.815474] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2522.887219] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 2522.887221] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2522.958521] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 2522.958523] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2545.772480] kjournald starting.  Commit interval 15 seconds
[ 2545.772704] EXT3-fs (sda6): using internal journal
[ 2545.772710] EXT3-fs (sda6): recovery complete
[ 2545.772755] EXT3-fs (sda6): mounted filesystem with ordered data mode
[ 2550.958112] type=3D1101 audit(1405609861.815:384): user pid=3D22285 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2550.958187] type=3D1103 audit(1405609861.815:385): user pid=3D22285 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2550.958276] type=3D1006 audit(1405609861.815:386): login pid=3D22285 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
55
[ 2550.958596] type=3D1105 audit(1405609861.815:387): user pid=3D22285 ui=
d=3D0 auid=3D0 ses=3D55 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2550.961825] type=3D1104 audit(1405609861.819:388): user pid=3D22285 ui=
d=3D0 auid=3D0 ses=3D55 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2550.962032] type=3D1106 audit(1405609861.819:389): user pid=3D22285 ui=
d=3D0 auid=3D0 ses=3D55 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2610.836290] type=3D1101 audit(1405609921.819:390): user pid=3D23065 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2610.836368] type=3D1103 audit(1405609921.819:391): user pid=3D23065 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2610.836458] type=3D1006 audit(1405609921.819:392): login pid=3D23065 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
56
[ 2610.836780] type=3D1105 audit(1405609921.823:393): user pid=3D23065 ui=
d=3D0 auid=3D0 ses=3D56 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2610.840220] type=3D1104 audit(1405609921.823:394): user pid=3D23065 ui=
d=3D0 auid=3D0 ses=3D56 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2610.840417] type=3D1106 audit(1405609921.823:395): user pid=3D23065 ui=
d=3D0 auid=3D0 ses=3D56 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2610.849300] 01m (23067): dropped kernel caches: 3
[ 2670.823463] type=3D1101 audit(1405609981.939:396): user pid=3D23733 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2670.823566] type=3D1103 audit(1405609981.939:397): user pid=3D23733 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2670.823663] type=3D1006 audit(1405609981.939:398): login pid=3D23733 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
57
[ 2670.839974] type=3D1105 audit(1405609981.955:399): user pid=3D23733 ui=
d=3D0 auid=3D0 ses=3D57 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2670.847203] type=3D1104 audit(1405609981.959:400): user pid=3D23733 ui=
d=3D0 auid=3D0 ses=3D57 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2670.847421] type=3D1106 audit(1405609981.963:401): user pid=3D23733 ui=
d=3D0 auid=3D0 ses=3D57 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2670.878900] 01m (23750): dropped kernel caches: 3
[ 2703.485272] DRHD: handling fault status reg 2
[ 2703.505090] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 2703.505092] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2703.575208] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 2703.575210] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2703.648140] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 2703.648142] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2703.719141] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 2703.719143] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2730.824473] type=3D1101 audit(1405610042.067:402): user pid=3D24465 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2730.824553] type=3D1103 audit(1405610042.067:403): user pid=3D24465 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2730.824646] type=3D1006 audit(1405610042.067:404): login pid=3D24465 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
58
[ 2730.829056] type=3D1105 audit(1405610042.071:405): user pid=3D24465 ui=
d=3D0 auid=3D0 ses=3D58 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2730.839166] type=3D1104 audit(1405610042.083:406): user pid=3D24465 ui=
d=3D0 auid=3D0 ses=3D58 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2730.839358] type=3D1106 audit(1405610042.083:407): user pid=3D24465 ui=
d=3D0 auid=3D0 ses=3D58 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2789.721588] type=3D1101 audit(1405610101.091:408): user pid=3D50224 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2789.721640] type=3D1103 audit(1405610101.091:409): user pid=3D50224 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2789.721697] type=3D1006 audit(1405610101.091:410): login pid=3D50224 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
59
[ 2789.721895] type=3D1105 audit(1405610101.091:411): user pid=3D50224 ui=
d=3D0 auid=3D0 ses=3D59 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2789.723482] type=3D1101 audit(1405610101.095:412): user pid=3D50223 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2789.723528] type=3D1103 audit(1405610101.095:413): user pid=3D50223 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2789.723580] type=3D1006 audit(1405610101.095:414): login pid=3D50223 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
60
[ 2789.723983] type=3D1105 audit(1405610101.095:415): user pid=3D50223 ui=
d=3D0 auid=3D0 ses=3D60 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2789.725526] type=3D1101 audit(1405610101.095:416): user pid=3D50225 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2789.725571] type=3D1103 audit(1405610101.095:417): user pid=3D50225 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2849.908188] audit_printk_skb: 24 callbacks suppressed
[ 2849.931452] type=3D1101 audit(1405610161.407:426): user pid=3D18001 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2849.931482] type=3D1101 audit(1405610161.431:427): user pid=3D18000 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2849.931572] type=3D1103 audit(1405610161.431:428): user pid=3D18000 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2849.931636] type=3D1006 audit(1405610161.431:429): login pid=3D18000 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
62
[ 2849.931849] type=3D1105 audit(1405610161.431:430): user pid=3D18000 ui=
d=3D0 auid=3D0 ses=3D62 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2849.931875] type=3D1103 audit(1405610161.431:431): user pid=3D18001 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2849.931956] type=3D1006 audit(1405610161.431:432): login pid=3D18001 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
63
[ 2849.932264] type=3D1105 audit(1405610161.431:433): user pid=3D18001 ui=
d=3D0 auid=3D0 ses=3D63 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2849.940453] type=3D1104 audit(1405610161.439:434): user pid=3D18001 ui=
d=3D0 auid=3D0 ses=3D63 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2849.940596] type=3D1106 audit(1405610161.439:435): user pid=3D18001 ui=
d=3D0 auid=3D0 ses=3D63 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2849.948720] 01m (18017): dropped kernel caches: 3
[ 2884.235088] DRHD: handling fault status reg 402
[ 2884.256117] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 2884.256119] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2884.323853] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 2884.323855] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2884.393390] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 2884.393392] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2884.462803] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 2884.462805] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 2910.358210] audit_printk_skb: 6 callbacks suppressed
[ 2910.380882] type=3D1101 audit(1405610221.987:438): user pid=3D44415 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2910.380979] type=3D1103 audit(1405610222.011:439): user pid=3D44415 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2910.381080] type=3D1006 audit(1405610222.011:440): login pid=3D44415 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
64
[ 2910.397389] type=3D1105 audit(1405610222.027:441): user pid=3D44415 ui=
d=3D0 auid=3D0 ses=3D64 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2910.405951] type=3D1104 audit(1405610222.035:442): user pid=3D44415 ui=
d=3D0 auid=3D0 ses=3D64 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2910.406147] type=3D1106 audit(1405610222.035:443): user pid=3D44415 ui=
d=3D0 auid=3D0 ses=3D64 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2969.282566] type=3D1101 audit(1405610281.039:444): user pid=3D45119 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 2969.282643] type=3D1103 audit(1405610281.039:445): user pid=3D45119 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 2969.282735] type=3D1006 audit(1405610281.039:446): login pid=3D45119 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
65
[ 2969.283050] type=3D1105 audit(1405610281.039:447): user pid=3D45119 ui=
d=3D0 auid=3D0 ses=3D65 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2969.286382] type=3D1104 audit(1405610281.043:448): user pid=3D45119 ui=
d=3D0 auid=3D0 ses=3D65 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 2969.286574] type=3D1106 audit(1405610281.043:449): user pid=3D45119 ui=
d=3D0 auid=3D0 ses=3D65 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3029.160752] type=3D1101 audit(1405610341.047:450): user pid=3D45859 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3029.160827] type=3D1103 audit(1405610341.047:451): user pid=3D45859 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3029.160916] type=3D1006 audit(1405610341.047:452): login pid=3D45859 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
66
[ 3029.161222] type=3D1105 audit(1405610341.047:453): user pid=3D45859 ui=
d=3D0 auid=3D0 ses=3D66 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3029.164567] type=3D1104 audit(1405610341.051:454): user pid=3D45859 ui=
d=3D0 auid=3D0 ses=3D66 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3029.164760] type=3D1106 audit(1405610341.051:455): user pid=3D45859 ui=
d=3D0 auid=3D0 ses=3D66 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3064.993189] DRHD: handling fault status reg 2
[ 3065.013527] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 3065.013529] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3065.076118] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 3065.076120] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3065.140089] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 3065.140091] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3065.205147] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 3065.205149] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3089.038900] type=3D1101 audit(1405610401.055:456): user pid=3D46577 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3089.038975] type=3D1103 audit(1405610401.055:457): user pid=3D46577 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3089.039065] type=3D1006 audit(1405610401.055:458): login pid=3D46577 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
67
[ 3089.039399] type=3D1105 audit(1405610401.055:459): user pid=3D46577 ui=
d=3D0 auid=3D0 ses=3D67 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3089.042631] type=3D1104 audit(1405610401.055:460): user pid=3D46577 ui=
d=3D0 auid=3D0 ses=3D67 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3089.042842] type=3D1106 audit(1405610401.059:461): user pid=3D46577 ui=
d=3D0 auid=3D0 ses=3D67 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3148.916950] type=3D1101 audit(1405610461.059:462): user pid=3D47422 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3148.917027] type=3D1103 audit(1405610461.059:463): user pid=3D47422 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3148.917117] type=3D1006 audit(1405610461.059:464): login pid=3D47422 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
68
[ 3148.917426] type=3D1105 audit(1405610461.059:465): user pid=3D47422 ui=
d=3D0 auid=3D0 ses=3D68 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3148.920724] type=3D1104 audit(1405610461.063:466): user pid=3D47422 ui=
d=3D0 auid=3D0 ses=3D68 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3148.920933] type=3D1106 audit(1405610461.063:467): user pid=3D47422 ui=
d=3D0 auid=3D0 ses=3D68 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3208.795188] type=3D1101 audit(1405610521.067:468): user pid=3D48244 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3208.795266] type=3D1103 audit(1405610521.067:469): user pid=3D48244 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3208.795357] type=3D1006 audit(1405610521.067:470): login pid=3D48244 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
69
[ 3208.795674] type=3D1105 audit(1405610521.067:471): user pid=3D48244 ui=
d=3D0 auid=3D0 ses=3D69 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3208.798999] type=3D1104 audit(1405610521.071:472): user pid=3D48244 ui=
d=3D0 auid=3D0 ses=3D69 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3208.799213] type=3D1106 audit(1405610521.071:473): user pid=3D48244 ui=
d=3D0 auid=3D0 ses=3D69 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3208.807962] 01m (48246): dropped kernel caches: 3
[ 3245.743936] DRHD: handling fault status reg 402
[ 3245.765005] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 3245.765007] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3245.827726] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 3245.827728] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3245.890464] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 3245.890466] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3245.953433] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 3245.953435] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3268.770061] type=3D1101 audit(1405610581.171:474): user pid=3D49059 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3268.770137] type=3D1103 audit(1405610581.171:475): user pid=3D49059 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3268.770232] type=3D1006 audit(1405610581.171:476): login pid=3D49059 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
70
[ 3268.780550] type=3D1105 audit(1405610581.183:477): user pid=3D49059 ui=
d=3D0 auid=3D0 ses=3D70 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3268.787808] type=3D1104 audit(1405610581.191:478): user pid=3D49059 ui=
d=3D0 auid=3D0 ses=3D70 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3268.788021] type=3D1106 audit(1405610581.191:479): user pid=3D49059 ui=
d=3D0 auid=3D0 ses=3D70 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3328.662181] type=3D1101 audit(1405610641.191:480): user pid=3D49798 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3328.662256] type=3D1103 audit(1405610641.191:481): user pid=3D49798 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3328.662345] type=3D1006 audit(1405610641.191:482): login pid=3D49798 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
71
[ 3328.662651] type=3D1105 audit(1405610641.191:483): user pid=3D49798 ui=
d=3D0 auid=3D0 ses=3D71 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3328.665950] type=3D1104 audit(1405610641.195:484): user pid=3D49798 ui=
d=3D0 auid=3D0 ses=3D71 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3328.666141] type=3D1106 audit(1405610641.195:485): user pid=3D49798 ui=
d=3D0 auid=3D0 ses=3D71 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3388.540298] type=3D1101 audit(1405610701.199:486): user pid=3D50528 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3388.540372] type=3D1103 audit(1405610701.199:487): user pid=3D50528 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3388.540463] type=3D1006 audit(1405610701.199:488): login pid=3D50528 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
72
[ 3388.540772] type=3D1105 audit(1405610701.199:489): user pid=3D50528 ui=
d=3D0 auid=3D0 ses=3D72 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3388.544070] type=3D1104 audit(1405610701.203:490): user pid=3D50528 ui=
d=3D0 auid=3D0 ses=3D72 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3388.544263] type=3D1106 audit(1405610701.203:491): user pid=3D50528 ui=
d=3D0 auid=3D0 ses=3D72 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3426.505661] DRHD: handling fault status reg 2
[ 3426.526695] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 3426.526698] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3426.589398] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 3426.589400] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3426.651968] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 3426.651970] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3426.714528] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 3426.714530] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3448.418444] type=3D1101 audit(1405610761.207:492): user pid=3D51233 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3448.418519] type=3D1103 audit(1405610761.207:493): user pid=3D51233 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3448.418608] type=3D1006 audit(1405610761.207:494): login pid=3D51233 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
73
[ 3448.418915] type=3D1105 audit(1405610761.207:495): user pid=3D51233 ui=
d=3D0 auid=3D0 ses=3D73 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3448.422204] type=3D1104 audit(1405610761.211:496): user pid=3D51233 ui=
d=3D0 auid=3D0 ses=3D73 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3448.422395] type=3D1106 audit(1405610761.211:497): user pid=3D51233 ui=
d=3D0 auid=3D0 ses=3D73 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3508.296905] type=3D1101 audit(1405610821.215:498): user pid=3D51987 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3508.296993] type=3D1103 audit(1405610821.215:499): user pid=3D51987 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3508.297094] type=3D1006 audit(1405610821.215:500): login pid=3D51987 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
74
[ 3508.297440] type=3D1105 audit(1405610821.215:501): user pid=3D51987 ui=
d=3D0 auid=3D0 ses=3D74 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3508.301165] type=3D1104 audit(1405610821.219:502): user pid=3D51987 ui=
d=3D0 auid=3D0 ses=3D74 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3508.301361] type=3D1106 audit(1405610821.219:503): user pid=3D51987 ui=
d=3D0 auid=3D0 ses=3D74 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3568.175601] type=3D1101 audit(1405610881.223:504): user pid=3D52722 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3568.175708] type=3D1103 audit(1405610881.223:505): user pid=3D52722 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3568.175822] type=3D1006 audit(1405610881.223:506): login pid=3D52722 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
75
[ 3568.176182] type=3D1105 audit(1405610881.223:507): user pid=3D52722 ui=
d=3D0 auid=3D0 ses=3D75 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3568.179510] type=3D1104 audit(1405610881.227:508): user pid=3D52722 ui=
d=3D0 auid=3D0 ses=3D75 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3568.179706] type=3D1106 audit(1405610881.227:509): user pid=3D52722 ui=
d=3D0 auid=3D0 ses=3D75 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3568.188667] 01m (52724): dropped kernel caches: 3
[ 3607.266845] DRHD: handling fault status reg 402
[ 3607.287928] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 3607.287930] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3607.351368] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 3607.351370] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3607.416346] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 3607.416348] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3607.479197] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 3607.479199] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3628.311790] type=3D1101 audit(1405610941.487:510): user pid=3D53449 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3628.311866] type=3D1103 audit(1405610941.487:511): user pid=3D53449 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3628.311963] type=3D1006 audit(1405610941.487:512): login pid=3D53449 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
76
[ 3628.329652] type=3D1105 audit(1405610941.507:513): user pid=3D53449 ui=
d=3D0 auid=3D0 ses=3D76 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3628.337758] type=3D1104 audit(1405610941.515:514): user pid=3D53449 ui=
d=3D0 auid=3D0 ses=3D76 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3628.337960] type=3D1106 audit(1405610941.515:515): user pid=3D53449 ui=
d=3D0 auid=3D0 ses=3D76 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3688.212132] type=3D1101 audit(1405611001.515:516): user pid=3D54215 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3688.212187] type=3D1101 audit(1405611001.515:517): user pid=3D54216 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3688.212210] type=3D1103 audit(1405611001.515:518): user pid=3D54215 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3688.212263] type=3D1103 audit(1405611001.515:519): user pid=3D54216 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3688.212301] type=3D1006 audit(1405611001.515:520): login pid=3D54215 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
77
[ 3688.212351] type=3D1006 audit(1405611001.515:521): login pid=3D54216 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
78
[ 3688.212424] type=3D1101 audit(1405611001.519:522): user pid=3D54217 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3688.212505] type=3D1103 audit(1405611001.519:523): user pid=3D54217 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3688.212597] type=3D1006 audit(1405611001.519:524): login pid=3D54217 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
79
[ 3688.212630] type=3D1105 audit(1405611001.519:525): user pid=3D54215 ui=
d=3D0 auid=3D0 ses=3D77 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3716.494725] audit_printk_skb: 24 callbacks suppressed
[ 3716.518114] type=3D2407 audit(1405611029.859:534): user pid=3D10361 ui=
d=3D0 auid=3D0 ses=3D7 msg=3D'op=3Dstart direction=3Dfrom-client cipher=3D=
aes256-ctr ksize=3D256 spid=3D10361 suid=3D0 rport=3D59148 laddr=3D156.4.=
110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156=
.2.180, terminal=3D? res=3Dsuccess)'
[ 3716.518204] type=3D2407 audit(1405611029.883:535): user pid=3D10361 ui=
d=3D0 auid=3D0 ses=3D7 msg=3D'op=3Dstart direction=3Dfrom-server cipher=3D=
aes256-ctr ksize=3D256 spid=3D10361 suid=3D0 rport=3D59148 laddr=3D156.4.=
110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156=
.2.180, terminal=3D? res=3Dsuccess)'
[ 3717.486334] type=3D2404 audit(1405611030.855:536): user pid=3D10361 ui=
d=3D0 auid=3D0 ses=3D7 msg=3D'op=3Ddestroy kind=3Dsession fp=3D? directio=
n=3Dfrom-client spid=3D10361 suid=3D0 rport=3D59148 laddr=3D156.4.110.210=
 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156.2.180,=
 terminal=3D? res=3Dsuccess)'
[ 3718.019962] type=3D2404 audit(1405611031.387:537): user pid=3D10361 ui=
d=3D0 auid=3D0 ses=3D7 msg=3D'op=3Ddestroy kind=3Dsession fp=3D? directio=
n=3Dfrom-server spid=3D10361 suid=3D0 rport=3D59148 laddr=3D156.4.110.210=
 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156.2.180,=
 terminal=3D? res=3Dsuccess)'
[ 3736.919988] type=3D2407 audit(1405611050.331:538): user pid=3D10620 ui=
d=3D0 auid=3D0 ses=3D4 msg=3D'op=3Dstart direction=3Dfrom-client cipher=3D=
aes256-ctr ksize=3D256 spid=3D10620 suid=3D0 rport=3D59176 laddr=3D156.4.=
110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156=
.2.180, terminal=3D? res=3Dsuccess)'
[ 3736.920069] type=3D2407 audit(1405611050.331:539): user pid=3D10620 ui=
d=3D0 auid=3D0 ses=3D4 msg=3D'op=3Dstart direction=3Dfrom-server cipher=3D=
aes256-ctr ksize=3D256 spid=3D10620 suid=3D0 rport=3D59176 laddr=3D156.4.=
110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156=
.2.180, terminal=3D? res=3Dsuccess)'
[ 3737.230763] type=3D2404 audit(1405611050.639:540): user pid=3D10620 ui=
d=3D0 auid=3D0 ses=3D4 msg=3D'op=3Ddestroy kind=3Dsession fp=3D? directio=
n=3Dfrom-client spid=3D10620 suid=3D0 rport=3D59176 laddr=3D156.4.110.210=
 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156.2.180,=
 terminal=3D? res=3Dsuccess)'
[ 3737.469659] type=3D2404 audit(1405611050.879:541): user pid=3D10620 ui=
d=3D0 auid=3D0 ses=3D4 msg=3D'op=3Ddestroy kind=3Dsession fp=3D? directio=
n=3Dfrom-server spid=3D10620 suid=3D0 rport=3D59176 laddr=3D156.4.110.210=
 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156.2.180,=
 terminal=3D? res=3Dsuccess)'
[ 3748.282920] type=3D1101 audit(1405611061.715:542): user pid=3D54996 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3748.283001] type=3D1103 audit(1405611061.715:543): user pid=3D54996 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3748.283022] type=3D1101 audit(1405611061.715:544): user pid=3D54997 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3748.283097] type=3D1103 audit(1405611061.719:545): user pid=3D54997 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3748.283104] type=3D1006 audit(1405611061.719:546): login pid=3D54996 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
80
[ 3748.283200] type=3D1006 audit(1405611061.719:547): login pid=3D54997 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
81
[ 3748.283416] type=3D1105 audit(1405611061.719:548): user pid=3D54996 ui=
d=3D0 auid=3D0 ses=3D80 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3748.283508] type=3D1105 audit(1405611061.719:549): user pid=3D54997 ui=
d=3D0 auid=3D0 ses=3D81 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3748.286843] type=3D1104 audit(1405611061.719:550): user pid=3D54997 ui=
d=3D0 auid=3D0 ses=3D81 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3748.287048] type=3D1106 audit(1405611061.723:551): user pid=3D54997 ui=
d=3D0 auid=3D0 ses=3D81 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3788.018220] DRHD: handling fault status reg 2
[ 3788.043079] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 3788.043081] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3788.105818] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 3788.105820] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3788.168802] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 3788.168804] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3788.231521] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 3788.231523] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3808.306224] audit_printk_skb: 6 callbacks suppressed
[ 3808.329427] type=3D1101 audit(1405611121.871:554): user pid=3D55746 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3808.329513] type=3D1103 audit(1405611121.891:555): user pid=3D55746 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3808.329603] type=3D1006 audit(1405611121.891:556): login pid=3D55746 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
82
[ 3808.329924] type=3D1105 audit(1405611121.895:557): user pid=3D55746 ui=
d=3D0 auid=3D0 ses=3D82 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3808.333292] type=3D1104 audit(1405611121.895:558): user pid=3D55746 ui=
d=3D0 auid=3D0 ses=3D82 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3808.333481] type=3D1106 audit(1405611121.895:559): user pid=3D55746 ui=
d=3D0 auid=3D0 ses=3D82 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3868.207626] type=3D1101 audit(1405611181.899:560): user pid=3D56458 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3868.207705] type=3D1103 audit(1405611181.899:561): user pid=3D56458 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3868.207794] type=3D1006 audit(1405611181.899:562): login pid=3D56458 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
83
[ 3868.208104] type=3D1105 audit(1405611181.899:563): user pid=3D56458 ui=
d=3D0 auid=3D0 ses=3D83 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3868.211374] type=3D1104 audit(1405611181.903:564): user pid=3D56458 ui=
d=3D0 auid=3D0 ses=3D83 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3868.211588] type=3D1106 audit(1405611181.903:565): user pid=3D56458 ui=
d=3D0 auid=3D0 ses=3D83 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3878.239615] type=3D2407 audit(1405611191.955:566): user pid=3D13245 ui=
d=3D0 auid=3D0 ses=3D10 msg=3D'op=3Dstart direction=3Dfrom-client cipher=3D=
aes256-ctr ksize=3D256 spid=3D13245 suid=3D0 rport=3D61280 laddr=3D156.4.=
110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156=
.2.176, terminal=3D? res=3Dsuccess)'
[ 3878.239699] type=3D2407 audit(1405611191.955:567): user pid=3D13245 ui=
d=3D0 auid=3D0 ses=3D10 msg=3D'op=3Dstart direction=3Dfrom-server cipher=3D=
aes256-ctr ksize=3D256 spid=3D13245 suid=3D0 rport=3D61280 laddr=3D156.4.=
110.210 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156=
.2.176, terminal=3D? res=3Dsuccess)'
[ 3878.590984] type=3D2404 audit(1405611192.307:568): user pid=3D13245 ui=
d=3D0 auid=3D0 ses=3D10 msg=3D'op=3Ddestroy kind=3Dsession fp=3D? directi=
on=3Dfrom-client spid=3D13245 suid=3D0 rport=3D61280 laddr=3D156.4.110.21=
0 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156.2.176=
, terminal=3D? res=3Dsuccess)'
[ 3878.838300] type=3D2404 audit(1405611192.555:569): user pid=3D13245 ui=
d=3D0 auid=3D0 ses=3D10 msg=3D'op=3Ddestroy kind=3Dsession fp=3D? directi=
on=3Dfrom-server spid=3D13245 suid=3D0 rport=3D61280 laddr=3D156.4.110.21=
0 lport=3D22 : exe=3D"/usr/sbin/sshd" (hostname=3D?, addr=3D156.156.2.176=
, terminal=3D? res=3Dsuccess)'
[ 3928.085838] type=3D1101 audit(1405611241.907:570): user pid=3D57199 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3928.085914] type=3D1103 audit(1405611241.907:571): user pid=3D57199 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3928.086007] type=3D1006 audit(1405611241.907:572): login pid=3D57199 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
84
[ 3928.086321] type=3D1105 audit(1405611241.907:573): user pid=3D57199 ui=
d=3D0 auid=3D0 ses=3D84 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3928.089577] type=3D1104 audit(1405611241.911:574): user pid=3D57199 ui=
d=3D0 auid=3D0 ses=3D84 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3928.089773] type=3D1106 audit(1405611241.911:575): user pid=3D57199 ui=
d=3D0 auid=3D0 ses=3D84 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3968.480330] DRHD: handling fault status reg 402
[ 3968.501346] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 3968.501348] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3968.564080] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 3968.564082] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3968.626674] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 3968.626676] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3968.689254] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 3968.689255] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 3987.964020] type=3D1101 audit(1405611301.915:576): user pid=3D57946 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 3987.964100] type=3D1103 audit(1405611301.915:577): user pid=3D57946 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 3987.964191] type=3D1006 audit(1405611301.915:578): login pid=3D57946 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
85
[ 3987.964504] type=3D1105 audit(1405611301.915:579): user pid=3D57946 ui=
d=3D0 auid=3D0 ses=3D85 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3987.967783] type=3D1104 audit(1405611301.919:580): user pid=3D57946 ui=
d=3D0 auid=3D0 ses=3D85 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3987.967974] type=3D1106 audit(1405611301.919:581): user pid=3D57946 ui=
d=3D0 auid=3D0 ses=3D85 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 3987.976792] 01m (57948): dropped kernel caches: 3
[ 4047.973055] type=3D1101 audit(1405611362.051:582): user pid=3D58668 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4047.973132] type=3D1103 audit(1405611362.051:583): user pid=3D58668 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4047.973231] type=3D1006 audit(1405611362.051:584): login pid=3D58668 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
86
[ 4047.988130] type=3D1105 audit(1405611362.067:585): user pid=3D58668 ui=
d=3D0 auid=3D0 ses=3D86 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4047.993888] type=3D1104 audit(1405611362.075:586): user pid=3D58668 ui=
d=3D0 auid=3D0 ses=3D86 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4047.994096] type=3D1106 audit(1405611362.075:587): user pid=3D58668 ui=
d=3D0 auid=3D0 ses=3D86 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4084.978061] usb 3-1: USB disconnect, device number 2
[ 4106.870412] type=3D1101 audit(1405611421.075:588): user pid=3D59398 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4106.870487] type=3D1103 audit(1405611421.075:589): user pid=3D59398 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4106.870577] type=3D1006 audit(1405611421.075:590): login pid=3D59398 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
87
[ 4106.870895] type=3D1105 audit(1405611421.079:591): user pid=3D59398 ui=
d=3D0 auid=3D0 ses=3D87 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4106.874199] type=3D1104 audit(1405611421.079:592): user pid=3D59398 ui=
d=3D0 auid=3D0 ses=3D87 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4106.874391] type=3D1106 audit(1405611421.079:593): user pid=3D59398 ui=
d=3D0 auid=3D0 ses=3D87 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4106.883664] 01m (59400): dropped kernel caches: 3
[ 4149.231789] DRHD: handling fault status reg 2
[ 4149.251713] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 4149.251715] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4149.315770] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 4149.315772] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4149.378515] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 4149.378517] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4149.444227] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 4149.444229] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4166.815168] type=3D1101 audit(1405611481.151:594): user pid=3D60125 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4166.815247] type=3D1103 audit(1405611481.151:595): user pid=3D60125 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4166.815341] type=3D1006 audit(1405611481.151:596): login pid=3D60125 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
88
[ 4166.820758] type=3D1105 audit(1405611481.155:597): user pid=3D60125 ui=
d=3D0 auid=3D0 ses=3D88 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4166.828070] type=3D1104 audit(1405611481.163:598): user pid=3D60125 ui=
d=3D0 auid=3D0 ses=3D88 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4166.828265] type=3D1106 audit(1405611481.163:599): user pid=3D60125 ui=
d=3D0 auid=3D0 ses=3D88 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4226.702433] type=3D1101 audit(1405611541.167:600): user pid=3D60837 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4226.702507] type=3D1103 audit(1405611541.167:601): user pid=3D60837 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4226.702596] type=3D1006 audit(1405611541.167:602): login pid=3D60837 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
89
[ 4226.702901] type=3D1105 audit(1405611541.167:603): user pid=3D60837 ui=
d=3D0 auid=3D0 ses=3D89 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4226.706227] type=3D1104 audit(1405611541.171:604): user pid=3D60837 ui=
d=3D0 auid=3D0 ses=3D89 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4226.706420] type=3D1106 audit(1405611541.171:605): user pid=3D60837 ui=
d=3D0 auid=3D0 ses=3D89 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4286.580590] type=3D1101 audit(1405611601.175:606): user pid=3D61559 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4286.580667] type=3D1103 audit(1405611601.175:607): user pid=3D61559 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4286.580758] type=3D1006 audit(1405611601.175:608): login pid=3D61559 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
90
[ 4286.581063] type=3D1105 audit(1405611601.175:609): user pid=3D61559 ui=
d=3D0 auid=3D0 ses=3D90 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4286.584346] type=3D1104 audit(1405611601.179:610): user pid=3D61559 ui=
d=3D0 auid=3D0 ses=3D90 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4286.584539] type=3D1106 audit(1405611601.179:611): user pid=3D61559 ui=
d=3D0 auid=3D0 ses=3D90 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4329.993660] DRHD: handling fault status reg 402
[ 4330.014352] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 4330.014354] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4330.076958] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 4330.076960] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4330.140558] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 4330.140560] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4330.203332] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 4330.203334] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4346.458645] type=3D1101 audit(1405611661.179:612): user pid=3D62286 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4346.458719] type=3D1103 audit(1405611661.179:613): user pid=3D62286 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4346.458808] type=3D1006 audit(1405611661.179:614): login pid=3D62286 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
91
[ 4346.459129] type=3D1105 audit(1405611661.183:615): user pid=3D62286 ui=
d=3D0 auid=3D0 ses=3D91 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4346.462515] type=3D1104 audit(1405611661.183:616): user pid=3D62286 ui=
d=3D0 auid=3D0 ses=3D91 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4346.462709] type=3D1106 audit(1405611661.183:617): user pid=3D62286 ui=
d=3D0 auid=3D0 ses=3D91 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4406.336858] type=3D1101 audit(1405611721.187:618): user pid=3D63000 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4406.336937] type=3D1103 audit(1405611721.187:619): user pid=3D63000 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4406.337028] type=3D1006 audit(1405611721.187:620): login pid=3D63000 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
92
[ 4406.337336] type=3D1105 audit(1405611721.187:621): user pid=3D63000 ui=
d=3D0 auid=3D0 ses=3D92 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4406.340585] type=3D1104 audit(1405611721.191:622): user pid=3D63000 ui=
d=3D0 auid=3D0 ses=3D92 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4406.340779] type=3D1106 audit(1405611721.191:623): user pid=3D63000 ui=
d=3D0 auid=3D0 ses=3D92 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4466.214915] type=3D1101 audit(1405611781.195:624): user pid=3D63739 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4466.214991] type=3D1103 audit(1405611781.195:625): user pid=3D63739 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4466.215083] type=3D1006 audit(1405611781.195:626): login pid=3D63739 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
93
[ 4466.215394] type=3D1105 audit(1405611781.195:627): user pid=3D63739 ui=
d=3D0 auid=3D0 ses=3D93 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4466.218749] type=3D1104 audit(1405611781.199:628): user pid=3D63739 ui=
d=3D0 auid=3D0 ses=3D93 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4466.218946] type=3D1106 audit(1405611781.199:629): user pid=3D63739 ui=
d=3D0 auid=3D0 ses=3D93 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4510.754841] DRHD: handling fault status reg 2
[ 4510.774717] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 4510.774719] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4510.837185] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 4510.837187] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4510.899475] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 4510.899477] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4510.964850] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 4510.964852] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4526.093100] type=3D1101 audit(1405611841.203:630): user pid=3D64458 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4526.093176] type=3D1103 audit(1405611841.203:631): user pid=3D64458 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4526.093264] type=3D1006 audit(1405611841.203:632): login pid=3D64458 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
94
[ 4526.093571] type=3D1105 audit(1405611841.203:633): user pid=3D64458 ui=
d=3D0 auid=3D0 ses=3D94 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4526.096871] type=3D1104 audit(1405611841.207:634): user pid=3D64458 ui=
d=3D0 auid=3D0 ses=3D94 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4526.097060] type=3D1106 audit(1405611841.207:635): user pid=3D64458 ui=
d=3D0 auid=3D0 ses=3D94 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4585.971178] type=3D1101 audit(1405611901.211:636): user pid=3D65208 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4585.971260] type=3D1103 audit(1405611901.211:637): user pid=3D65208 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4585.971296] type=3D1101 audit(1405611901.211:638): user pid=3D65209 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4585.971352] type=3D1006 audit(1405611901.211:639): login pid=3D65208 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
95
[ 4585.971370] type=3D1103 audit(1405611901.211:640): user pid=3D65209 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4585.971459] type=3D1006 audit(1405611901.211:641): login pid=3D65209 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
96
[ 4585.971531] type=3D1101 audit(1405611901.211:642): user pid=3D65210 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4585.971611] type=3D1103 audit(1405611901.211:643): user pid=3D65210 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"=
root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=
=3Dsuccess)'
[ 4585.971700] type=3D1105 audit(1405611901.211:644): user pid=3D65208 ui=
d=3D0 auid=3D0 ses=3D95 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4585.971708] type=3D1006 audit(1405611901.211:645): login pid=3D65210 u=
id=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D=
97
[ 4646.061438] audit_printk_skb: 24 callbacks suppressed
[ 4646.084400] type=3D1101 audit(1405611961.427:654): user pid=3D732 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[ 4646.084425] type=3D1101 audit(1405611961.451:655): user pid=3D733 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[ 4646.084513] type=3D1103 audit(1405611961.451:656): user pid=3D733 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"root=
" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Ds=
uccess)'
[ 4646.084532] type=3D1103 audit(1405611961.451:657): user pid=3D732 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"root=
" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Ds=
uccess)'
[ 4646.084605] type=3D1006 audit(1405611961.451:658): login pid=3D733 uid=
=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D98
[ 4646.084664] type=3D1006 audit(1405611961.451:659): login pid=3D732 uid=
=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D99
[ 4646.084919] type=3D1105 audit(1405611961.451:660): user pid=3D733 uid=3D=
0 auid=3D0 ses=3D98 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D"/us=
r/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4646.085155] type=3D1105 audit(1405611961.451:661): user pid=3D732 uid=3D=
0 auid=3D0 ses=3D99 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D"/us=
r/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4646.088191] type=3D1104 audit(1405611961.455:662): user pid=3D733 uid=3D=
0 auid=3D0 ses=3D98 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr/sbi=
n/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4646.088388] type=3D1106 audit(1405611961.455:663): user pid=3D733 uid=3D=
0 auid=3D0 ses=3D98 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D"/u=
sr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4691.506170] DRHD: handling fault status reg 402
[ 4691.526814] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 4691.526816] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4691.587884] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 4691.587886] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4691.649203] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 4691.649205] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4691.710542] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 4691.710544] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4706.129031] audit_printk_skb: 6 callbacks suppressed
[ 4706.151499] type=3D1101 audit(1405612021.627:666): user pid=3D1501 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4706.151586] type=3D1103 audit(1405612021.647:667): user pid=3D1501 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[ 4706.151680] type=3D1006 audit(1405612021.647:668): login pid=3D1501 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D1=
00
[ 4706.151988] type=3D1105 audit(1405612021.647:669): user pid=3D1501 uid=
=3D0 auid=3D0 ses=3D100 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4706.155353] type=3D1104 audit(1405612021.651:670): user pid=3D1501 uid=
=3D0 auid=3D0 ses=3D100 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4706.155551] type=3D1106 audit(1405612021.651:671): user pid=3D1501 uid=
=3D0 auid=3D0 ses=3D100 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4766.029744] type=3D1101 audit(1405612081.655:672): user pid=3D2227 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4766.029822] type=3D1103 audit(1405612081.655:673): user pid=3D2227 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[ 4766.029913] type=3D1006 audit(1405612081.655:674): login pid=3D2227 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D1=
01
[ 4766.030220] type=3D1105 audit(1405612081.655:675): user pid=3D2227 uid=
=3D0 auid=3D0 ses=3D101 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4766.033454] type=3D1104 audit(1405612081.659:676): user pid=3D2227 uid=
=3D0 auid=3D0 ses=3D101 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4766.033643] type=3D1106 audit(1405612081.659:677): user pid=3D2227 uid=
=3D0 auid=3D0 ses=3D101 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4825.907818] type=3D1101 audit(1405612141.663:678): user pid=3D2939 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4825.907895] type=3D1103 audit(1405612141.663:679): user pid=3D2939 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[ 4825.907986] type=3D1006 audit(1405612141.663:680): login pid=3D2939 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D1=
02
[ 4825.908296] type=3D1105 audit(1405612141.663:681): user pid=3D2939 uid=
=3D0 auid=3D0 ses=3D102 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4825.911548] type=3D1104 audit(1405612141.667:682): user pid=3D2939 uid=
=3D0 auid=3D0 ses=3D102 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4825.911740] type=3D1106 audit(1405612141.667:683): user pid=3D2939 uid=
=3D0 auid=3D0 ses=3D102 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4872.267827] DRHD: handling fault status reg 2
[ 4872.287695] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 4872.287698] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4872.349052] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 4872.349054] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4872.410484] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 4872.410486] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4872.472119] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 4872.472121] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 4885.785952] type=3D1101 audit(1405612201.671:684): user pid=3D3666 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4885.786048] type=3D1103 audit(1405612201.671:685): user pid=3D3666 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[ 4885.786142] type=3D1006 audit(1405612201.671:686): login pid=3D3666 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D1=
03
[ 4885.786457] type=3D1105 audit(1405612201.671:687): user pid=3D3666 uid=
=3D0 auid=3D0 ses=3D103 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4885.789707] type=3D1104 audit(1405612201.675:688): user pid=3D3666 uid=
=3D0 auid=3D0 ses=3D103 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4885.789900] type=3D1106 audit(1405612201.675:689): user pid=3D3666 uid=
=3D0 auid=3D0 ses=3D103 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4945.664062] type=3D1101 audit(1405612261.675:690): user pid=3D4385 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 4945.664136] type=3D1103 audit(1405612261.675:691): user pid=3D4385 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[ 4945.664225] type=3D1006 audit(1405612261.675:692): login pid=3D4385 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D1=
04
[ 4945.664534] type=3D1105 audit(1405612261.679:693): user pid=3D4385 uid=
=3D0 auid=3D0 ses=3D104 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4945.667767] type=3D1104 audit(1405612261.679:694): user pid=3D4385 uid=
=3D0 auid=3D0 ses=3D104 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 4945.667956] type=3D1106 audit(1405612261.679:695): user pid=3D4385 uid=
=3D0 auid=3D0 ses=3D104 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 5005.542164] type=3D1101 audit(1405612321.683:696): user pid=3D5198 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting acct=3D=
"root" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron re=
s=3Dsuccess)'
[ 5005.542239] type=3D1103 audit(1405612321.683:697): user pid=3D5198 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred acct=3D"r=
oot" exe=3D"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3D=
success)'
[ 5005.542332] type=3D1006 audit(1405612321.683:698): login pid=3D5198 ui=
d=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D4294967295 new ses=3D1=
05
[ 5005.542646] type=3D1105 audit(1405612321.683:699): user pid=3D5198 uid=
=3D0 auid=3D0 ses=3D105 msg=3D'op=3DPAM:session_open acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 5005.545944] type=3D1104 audit(1405612321.687:700): user pid=3D5198 uid=
=3D0 auid=3D0 ses=3D105 msg=3D'op=3DPAM:setcred acct=3D"root" exe=3D"/usr=
/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 5005.546155] type=3D1106 audit(1405612321.687:701): user pid=3D5198 uid=
=3D0 auid=3D0 ses=3D105 msg=3D'op=3DPAM:session_close acct=3D"root" exe=3D=
"/usr/sbin/cron" (hostname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)'
[ 5052.729728] DRHD: handling fault status reg 402
[ 5052.750403] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70=
000=20
[ 5052.750405] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 5052.812530] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70=
000=20
[ 5052.812532] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 5052.886214] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70=
000=20
[ 5052.886217] DMAR:[fault reason 02] Present bit in context entry is cle=
ar
[ 5052.952299] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70=
000=20
[ 5052.952300] DMAR:[fault reason 02] Present bit in context entry is cle=
ar

--------------070609030207060109020109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070609030207060109020109--
