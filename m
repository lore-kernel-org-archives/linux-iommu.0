From: Manfred Schwarb <manfred99-OI3hZJvNYWs@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Add quirk for broken Marvell 88SE91xx SATA
Date: Fri, 02 Aug 2013 12:19:04 +0200
Message-ID: <51FB8798.70908@gmx.ch>
References: <519A93F0.8070606@gmx.ch> <20130521203526.GE7424@8bytes.org>
	<51D3E691.8030307@gmx.ch> <20130730113659.GJ28811@8bytes.org>
	<51F92832.2070102@gmx.ch> <51FB7C08.40708@gmx.ch>
	<20130802094326.GM28811@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030600050206040005090108"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130802094326.GM28811-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------030600050206040005090108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Am 02.08.2013 11:43, schrieb Joerg Roedel:
> Hi Manfred,
>
> On Fri, Aug 02, 2013 at 11:29:44AM +0200, Manfred Schwarb wrote:
>> Sorry, I completely goofed my testing, my apology.
>> I thought both disks I looked at were hanging on the builtin Marvell 88SE9172,
>> but one disk is attached to a Marvell 88SE9123 PCIe card.
>>
>> So the picture is much clearer now:
>>
>> The disk hanging on the Marvell 88SE9123 PCIe card gives without the patch
>>    ata14.00 failed to IDENTIFY(I/O Error, err_mask=0x4)
>> With the patch, this controller works flawless.
>>
>> The disk hanging on the built-in Marvell 88SE9172 (soldered on the mainboard)
>> gives with and without the patch
>>    ata20.00 failed to IDENTIFY(INIT_DEV_PARAMS failed, err_mask=0x80)
>>
>> So the patch works for my PCIe card, but not for my mainboard controller.
>
> Thanks for testing the patch. Can you please find out the PCI vendor and
> device-ids for the on-board and the PCIe STATA controlers? A dmesg after
> the boot would also be helpful. In short I need the output of (as root):
>
> # dmesg
> # lscpi -vvv
> # lspci -nvvv
>

See attachments, produced with iommu on, with linux 3.11rc3 in failsafe boot mode.

Cheers,
Manfred


>
> Thanks,
>
> 	Joerg
>
>
>


--------------030600050206040005090108
Content-Type: text/plain; charset=ISO-8859-1;
 name="lspci-vvv.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lspci-vvv.txt"

02:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9123 PCIe SATA 6.0 Gb/s controller (rev 11) (prog-if 01 [AHCI 1.0])
	Subsystem: Marvell Technology Group Ltd. 88SE9123 PCIe SATA 6.0 Gb/s controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 40
	Region 0: I/O ports at cf00 [size=8]
	Region 1: I/O ports at ce00 [size=4]
	Region 2: I/O ports at cd00 [size=8]
	Region 3: I/O ports at cc00 [size=4]
	Region 4: I/O ports at cb00 [size=16]
	Region 5: Memory at fddff000 (32-bit, non-prefetchable) [size=2K]
	[virtual] Expansion ROM at fdc00000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0800c  Data: 4159
	Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: ahci

02:00.1 IDE interface: Marvell Technology Group Ltd. 88SE91A4 SATA 6Gb/s Controller (rev 11) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Marvell Technology Group Ltd. 88SE91A4 SATA 6Gb/s Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at ca00 [size=8]
	Region 1: I/O ports at c900 [size=4]
	Region 2: I/O ports at c800 [size=8]
	Region 3: I/O ports at c700 [size=4]
	Region 4: I/O ports at c600 [size=16]
	Region 5: Memory at fddfe000 (32-bit, non-prefetchable) [size=16]
	[virtual] Expansion ROM at fdc10000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: pata_marvell

04:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11) (prog-if 01 [AHCI 1.0])
	Subsystem: Giga-byte Technology Device b000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 41
	Region 0: I/O ports at af00 [size=8]
	Region 1: I/O ports at ae00 [size=4]
	Region 2: I/O ports at ad00 [size=8]
	Region 3: I/O ports at ac00 [size=4]
	Region 4: I/O ports at ab00 [size=16]
	Region 5: Memory at fd9ff000 (32-bit, non-prefetchable) [size=512]
	[virtual] Expansion ROM at fd800000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: feeff00c  Data: 4161
	Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: ahci

0a:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11) (prog-if 01 [AHCI 1.0])
	Subsystem: Giga-byte Technology Device b000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 43
	Region 0: I/O ports at 5f00 [size=8]
	Region 1: I/O ports at 5e00 [size=4]
	Region 2: I/O ports at 5d00 [size=8]
	Region 3: I/O ports at 5c00 [size=4]
	Region 4: I/O ports at 5b00 [size=16]
	Region 5: Memory at fd0ff000 (32-bit, non-prefetchable) [size=512]
	[virtual] Expansion ROM at fcf00000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0100c  Data: 4171
	Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: ahci


--------------030600050206040005090108
Content-Type: text/plain; charset=ISO-8859-1;
 name="lspci-nvvv.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lspci-nvvv.txt"

02:00.0 0106: 1b4b:9123 (rev 11) (prog-if 01 [AHCI 1.0])
	Subsystem: 1b4b:9123
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 40
	Region 0: I/O ports at cf00 [size=8]
	Region 1: I/O ports at ce00 [size=4]
	Region 2: I/O ports at cd00 [size=8]
	Region 3: I/O ports at cc00 [size=4]
	Region 4: I/O ports at cb00 [size=16]
	Region 5: Memory at fddff000 (32-bit, non-prefetchable) [size=2K]
	[virtual] Expansion ROM at fdc00000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0800c  Data: 4159
	Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: ahci

02:00.1 0101: 1b4b:91a4 (rev 11) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: 1b4b:91a4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at ca00 [size=8]
	Region 1: I/O ports at c900 [size=4]
	Region 2: I/O ports at c800 [size=8]
	Region 3: I/O ports at c700 [size=4]
	Region 4: I/O ports at c600 [size=16]
	Region 5: Memory at fddfe000 (32-bit, non-prefetchable) [size=16]
	[virtual] Expansion ROM at fdc10000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: pata_marvell

04:00.0 0106: 1b4b:9172 (rev 11) (prog-if 01 [AHCI 1.0])
	Subsystem: 1458:b000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 41
	Region 0: I/O ports at af00 [size=8]
	Region 1: I/O ports at ae00 [size=4]
	Region 2: I/O ports at ad00 [size=8]
	Region 3: I/O ports at ac00 [size=4]
	Region 4: I/O ports at ab00 [size=16]
	Region 5: Memory at fd9ff000 (32-bit, non-prefetchable) [size=512]
	[virtual] Expansion ROM at fd800000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: feeff00c  Data: 4161
	Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: ahci

0a:00.0 0106: 1b4b:9172 (rev 11) (prog-if 01 [AHCI 1.0])
	Subsystem: 1458:b000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 43
	Region 0: I/O ports at 5f00 [size=8]
	Region 1: I/O ports at 5e00 [size=4]
	Region 2: I/O ports at 5d00 [size=8]
	Region 3: I/O ports at 5c00 [size=4]
	Region 4: I/O ports at 5b00 [size=16]
	Region 5: Memory at fd0ff000 (32-bit, non-prefetchable) [size=512]
	[virtual] Expansion ROM at fcf00000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0100c  Data: 4171
	Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: ahci


--------------030600050206040005090108
Content-Type: text/plain; charset=ISO-8859-1;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.11.0-rc3-1.29-default (root@linux) (gcc version 4.6.2 (SUSE Linux) ) #1 SMP Wed Jul 31 08:39:31 GMT 2013
[    0.000000] Command line: root=/dev/disk/by-id/ata-WDC_WD5002ABYS-01B1B0_WD-WCASY2034065-part7 loglevel=6 apm=off noresume edd=off powersaved=off nohz=off highres=off processor.max_cstate=1 nomodeset x11failsafe vga=0x31a
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000094fff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cfd9ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cfda0000-0x00000000cfdd0fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cfdd1000-0x00000000cfdfffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cfe00000-0x00000000cfefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000042effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. GA-990FXA-UD5/GA-990FXA-UD5, BIOS F12a 01/24/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x42f000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000000]   3 base 0000CFE00000 mask FFFFFFE00000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000042f000000 aka 17136M
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820: update [mem 0xcfe00000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xcfda0 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f4cd0-0x000f4cdf] mapped at [ffff8800000f4cd0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff88000008f000] 8f000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01d8e000, 0x01d8efff] PGTABLE
[    0.000000] BRK [0x01d8f000, 0x01d8ffff] PGTABLE
[    0.000000] BRK [0x01d90000, 0x01d90fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x42ee00000-0x42effffff]
[    0.000000]  [mem 0x42ee00000-0x42effffff] page 2M
[    0.000000] BRK [0x01d91000, 0x01d91fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x42c000000-0x42edfffff]
[    0.000000]  [mem 0x42c000000-0x42edfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x400000000-0x42bffffff]
[    0.000000]  [mem 0x400000000-0x42bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xcfd9ffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0xbfffffff] page 1G
[    0.000000]  [mem 0xc0000000-0xcfbfffff] page 2M
[    0.000000]  [mem 0xcfc00000-0xcfd9ffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x3ffffffff]
[    0.000000]  [mem 0x100000000-0x3ffffffff] page 1G
[    0.000000] RAMDISK: [mem 0x358e5000-0x37feffff]
[    0.000000] ACPI: RSDP 00000000000f6bf0 00014 (v00 GBT   )
[    0.000000] ACPI: RSDT 00000000cfdd1000 00050 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: FACP 00000000cfdd1080 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: DSDT 00000000cfdd1100 07997 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
[    0.000000] ACPI: FACS 00000000cfda0000 00040
[    0.000000] ACPI: MSDM 00000000cfdd8b80 00055 (v03 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: HPET 00000000cfdd8c00 00038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
[    0.000000] ACPI: MCFG 00000000cfdd8c40 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: EUDS 00000000cfdd8cc0 00740 (v01 GBT             00000000      00000000)
[    0.000000] ACPI: MATS 00000000cfdd9400 00034 (v01 GBT             00000000      00000000)
[    0.000000] ACPI: TAMG 00000000cfdd9470 00182 (v01 GBT    GBT   B0 5455312E BG?? 53450101)
[    0.000000] ACPI: APIC 00000000cfdd8ac0 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: MATS 00000000cfdd9600 066BB (v01        MATS RCM 80000001 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000cfddfd30 01714 (v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: IVRS 00000000cfde14c0 00108 (v01  AMD     RD890S 00202031 AMD  00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000042effffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x42effffff]
[    0.000000]   NODE_DATA [mem 0x42efea000-0x42effdfff]
[    0.000000]  [ffffea0000000000-ffffea000ebfffff] PMD -> [ffff88041e600000-ffff88042c7fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x42effffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x00094fff]
[    0.000000]   node   0: [mem 0x00100000-0xcfd9ffff]
[    0.000000]   node   0: [mem 0x100000000-0x42effffff]
[    0.000000] On node 0 totalpages: 4189492
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3988 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11584 pages used for memmap
[    0.000000]   DMA32 zone: 847264 pages, LIFO batch:31
[    0.000000]   Normal zone: 45640 pages used for memmap
[    0.000000]   Normal zone: 3338240 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10b9a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: [mem 0x00095000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcfda0000-0xcfdd0fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcfdd1000-0xcfdfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcfe00000-0xcfefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcff00000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xffffffff]
[    0.000000] e820: [mem 0xcff00000-0xdfffffff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88042ec00000 s81024 r8192 d21376 u262144
[    0.000000] pcpu-alloc: s81024 r8192 d21376 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 4132191
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/disk/by-id/ata-WDC_WD5002ABYS-01B1B0_WD-WCASY2034065-part7 loglevel=6 apm=off noresume edd=off powersaved=off nohz=off highres=off processor.max_cstate=1 nomodeset x11failsafe vga=0x31a
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Node 0: aperture @ c4000000 size 32 MB
[    0.000000] Aperture pointing to e820 RAM. Ignoring.
[    0.000000] Your BIOS doesn't leave a aperture memory hole
[    0.000000] Please enable the IOMMU option in the BIOS setup
[    0.000000] This costs you 64 MB of RAM
[    0.000000] Mapping aperture over 65536 KB of RAM @ c4000000
[    0.000000] PM: Registered nosave memory: [mem 0xc4000000-0xc7ffffff]
[    0.000000] Memory: 16339792K/16757968K available (5911K kernel code, 751K rwdata, 2804K rodata, 1264K init, 1588K bss, 418176K reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.000000] NR_IRQS:33024 nr_irqs:744 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.004000] tsc: Detected 3624.330 MHz processor
[    0.000002] Calibrating delay loop (skipped), value calculated using timer frequency.. 7248.66 BogoMIPS (lpj=14497320)
[    0.000005] pid_max: default: 32768 minimum: 301
[    0.000030] Security Framework initialized
[    0.000040] AppArmor: AppArmor initialized
[    0.000991] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.004678] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.006269] Mount-cache hash table entries: 256
[    0.006417] Initializing cgroup subsys devices
[    0.006419] Initializing cgroup subsys freezer
[    0.006420] Initializing cgroup subsys net_cls
[    0.006421] Initializing cgroup subsys blkio
[    0.006423] Initializing cgroup subsys perf_event
[    0.006440] tseg: 00cff00000
[    0.006442] CPU: Physical Processor ID: 0
[    0.006442] CPU: Processor Core ID: 0
[    0.006444] mce: CPU supports 7 MCE banks
[    0.006450] LVT offset 1 assigned for vector 0xf9
[    0.006454] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.006454] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.006454] tlb_flushall_shift: 5
[    0.006514] Freeing SMP alternatives memory: 24K (ffffffff81bf9000 - ffffffff81bff000)
[    0.006515] ACPI: Core revision 20130517
[    0.009453] ACPI: All ACPI Tables successfully acquired
[    0.074543] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.114295] smpboot: CPU0: AMD FX(tm)-8150 Eight-Core Processor (fam: 15, model: 01, stepping: 02)
[    0.220254] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.220258] ... version:                0
[    0.220259] ... bit width:              48
[    0.220260] ... generic registers:      6
[    0.220261] ... value mask:             0000ffffffffffff
[    0.220262] ... max period:             00007fffffffffff
[    0.220263] ... fixed-purpose events:   0
[    0.220264] ... event mask:             000000000000003f
[    0.220703] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.220783] smpboot: Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 OK
[    0.313195] Brought up 8 CPUs
[    0.313198] smpboot: Total of 8 processors activated (57989.28 BogoMIPS)
[    0.326301] devtmpfs: initialized
[    0.328625] PM: Registering ACPI NVS region [mem 0xcfda0000-0xcfdd0fff] (200704 bytes)
[    0.328810] regulator-dummy: no parameters
[    0.328834] RTC time: 10:03:39, date: 08/02/13
[    0.328885] NET: Registered protocol family 16
[    0.329042] ACPI: bus type PCI registered
[    0.329089] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.329092] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.339770] PCI: Using configuration type 1 for base access
[    0.340816] bio: create slab <bio-0> at 0
[    0.340981] ACPI: Added _OSI(Module Device)
[    0.340983] ACPI: Added _OSI(Processor Device)
[    0.340984] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.340986] ACPI: Added _OSI(Processor Aggregator Device)
[    0.341601] ACPI: EC: Look up EC in DSDT
[    0.350332] ACPI BIOS Warning (bug): Incorrect checksum in table [TAMG] - 0xD2, should be 0xD1 (20130517/tbprint-204)
[    0.350492] ACPI: Interpreter enabled
[    0.350498] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20130517/hwxface-571)
[    0.350504] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20130517/hwxface-571)
[    0.350518] ACPI: (supports S0 S3 S4 S5)
[    0.350520] ACPI: Using IOAPIC for interrupt routing
[    0.350550] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.350628] ACPI: No dock devices found.
[    0.496250] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.496382] PCI host bridge to bus 0000:00
[    0.496385] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.496387] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.496389] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.496391] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.496392] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.496394] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff]
[    0.496396] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xfebfffff]
[    0.496406] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    0.496417] pci 0000:00:00.0: reg 0x1c: [mem 0xe0000000-0xffffffff 64bit]
[    0.496524] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    0.496634] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    0.496664] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.496705] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.496734] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    0.496763] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.496805] pci 0000:00:04.0: System wakeup disabled by ACPI
[    0.496835] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
[    0.496867] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.496915] pci 0000:00:09.0: System wakeup disabled by ACPI
[    0.496941] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    0.496970] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.497019] pci 0000:00:0a.0: System wakeup disabled by ACPI
[    0.497047] pci 0000:00:0c.0: [1002:5a20] type 01 class 0x060400
[    0.497076] pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
[    0.497130] pci 0000:00:0c.0: System wakeup disabled by ACPI
[    0.497157] pci 0000:00:0d.0: [1002:5a1e] type 01 class 0x060400
[    0.497186] pci 0000:00:0d.0: PME# supported from D0 D3hot D3cold
[    0.497240] pci 0000:00:0d.0: System wakeup disabled by ACPI
[    0.497273] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    0.497287] pci 0000:00:11.0: reg 0x10: [io  0xff00-0xff07]
[    0.497294] pci 0000:00:11.0: reg 0x14: [io  0xfe00-0xfe03]
[    0.497301] pci 0000:00:11.0: reg 0x18: [io  0xfd00-0xfd07]
[    0.497309] pci 0000:00:11.0: reg 0x1c: [io  0xfc00-0xfc03]
[    0.497316] pci 0000:00:11.0: reg 0x20: [io  0xfb00-0xfb0f]
[    0.497323] pci 0000:00:11.0: reg 0x24: [mem 0xfdfff000-0xfdfff3ff]
[    0.497401] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.497411] pci 0000:00:12.0: reg 0x10: [mem 0xfdffe000-0xfdffefff]
[    0.497463] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.497495] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.497509] pci 0000:00:12.2: reg 0x10: [mem 0xfdffd000-0xfdffd0ff]
[    0.497569] pci 0000:00:12.2: supports D1 D2
[    0.497570] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.497590] pci 0000:00:12.2: System wakeup disabled by ACPI
[    0.497626] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.497636] pci 0000:00:13.0: reg 0x10: [mem 0xfdffc000-0xfdffcfff]
[    0.497690] pci 0000:00:13.0: System wakeup disabled by ACPI
[    0.497722] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.497736] pci 0000:00:13.2: reg 0x10: [mem 0xfdffb000-0xfdffb0ff]
[    0.497795] pci 0000:00:13.2: supports D1 D2
[    0.497797] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.497819] pci 0000:00:13.2: System wakeup disabled by ACPI
[    0.497851] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.497930] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.497945] pci 0000:00:14.2: reg 0x10: [mem 0xfdff4000-0xfdff7fff 64bit]
[    0.497993] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.498019] pci 0000:00:14.2: System wakeup disabled by ACPI
[    0.498047] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.498145] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.498200] pci 0000:00:14.4: System wakeup disabled by ACPI
[    0.498227] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.498237] pci 0000:00:14.5: reg 0x10: [mem 0xfdffa000-0xfdffafff]
[    0.498297] pci 0000:00:14.5: System wakeup disabled by ACPI
[    0.498329] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
[    0.498381] pci 0000:00:15.0: supports D1 D2
[    0.498420] pci 0000:00:15.0: System wakeup disabled by ACPI
[    0.498455] pci 0000:00:15.1: [1002:43a1] type 01 class 0x060400
[    0.498507] pci 0000:00:15.1: supports D1 D2
[    0.498546] pci 0000:00:15.1: System wakeup disabled by ACPI
[    0.498579] pci 0000:00:15.2: [1002:43a2] type 01 class 0x060400
[    0.498632] pci 0000:00:15.2: supports D1 D2
[    0.498672] pci 0000:00:15.2: System wakeup disabled by ACPI
[    0.498702] pci 0000:00:15.3: [1002:43a3] type 01 class 0x060400
[    0.498754] pci 0000:00:15.3: supports D1 D2
[    0.498795] pci 0000:00:15.3: System wakeup disabled by ACPI
[    0.498826] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    0.498836] pci 0000:00:16.0: reg 0x10: [mem 0xfdff9000-0xfdff9fff]
[    0.498895] pci 0000:00:16.0: System wakeup disabled by ACPI
[    0.498927] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    0.498941] pci 0000:00:16.2: reg 0x10: [mem 0xfdff8000-0xfdff80ff]
[    0.499001] pci 0000:00:16.2: supports D1 D2
[    0.499003] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.499028] pci 0000:00:16.2: System wakeup disabled by ACPI
[    0.499058] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.499138] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.499213] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.499288] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.499365] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.499440] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.499557] pci 0000:01:00.0: [10de:01d1] type 00 class 0x030000
[    0.499566] pci 0000:01:00.0: reg 0x10: [mem 0xf9000000-0xf9ffffff]
[    0.499574] pci 0000:01:00.0: reg 0x14: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.499582] pci 0000:01:00.0: reg 0x1c: [mem 0xfa000000-0xfaffffff 64bit]
[    0.499593] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.499645] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.499651] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.499654] pci 0000:00:02.0:   bridge window [io  0xd000-0xdfff]
[    0.499656] pci 0000:00:02.0:   bridge window [mem 0xf9000000-0xfbffffff]
[    0.499659] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.499700] pci 0000:02:00.0: [1b4b:9123] type 00 class 0x010601
[    0.499708] pci 0000:02:00.0: reg 0x10: [io  0xcf00-0xcf07]
[    0.499714] pci 0000:02:00.0: reg 0x14: [io  0xce00-0xce03]
[    0.499720] pci 0000:02:00.0: reg 0x18: [io  0xcd00-0xcd07]
[    0.499727] pci 0000:02:00.0: reg 0x1c: [io  0xcc00-0xcc03]
[    0.499733] pci 0000:02:00.0: reg 0x20: [io  0xcb00-0xcb0f]
[    0.499739] pci 0000:02:00.0: reg 0x24: [mem 0xfddff000-0xfddff7ff]
[    0.499745] pci 0000:02:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.499771] pci 0000:02:00.0: PME# supported from D3hot
[    0.499812] pci 0000:02:00.1: [1b4b:91a4] type 00 class 0x01018f
[    0.499820] pci 0000:02:00.1: reg 0x10: [io  0xca00-0xca07]
[    0.499827] pci 0000:02:00.1: reg 0x14: [io  0xc900-0xc903]
[    0.499833] pci 0000:02:00.1: reg 0x18: [io  0xc800-0xc807]
[    0.499839] pci 0000:02:00.1: reg 0x1c: [io  0xc700-0xc703]
[    0.499845] pci 0000:02:00.1: reg 0x20: [io  0xc600-0xc60f]
[    0.499851] pci 0000:02:00.1: reg 0x24: [mem 0xfddfe000-0xfddfe00f]
[    0.499857] pci 0000:02:00.1: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.499884] pci 0000:02:00.1: PME# supported from D3hot
[    0.504894] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.504898] pci 0000:00:04.0:   bridge window [io  0xc000-0xcfff]
[    0.504900] pci 0000:00:04.0:   bridge window [mem 0xfdd00000-0xfddfffff]
[    0.504903] pci 0000:00:04.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
[    0.504951] pci 0000:03:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.504966] pci 0000:03:00.0: reg 0x10: [mem 0xfdbf8000-0xfdbfffff 64bit]
[    0.505030] pci 0000:03:00.0: supports D1 D2
[    0.505031] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.512912] pci 0000:00:09.0: PCI bridge to [bus 03]
[    0.512915] pci 0000:00:09.0:   bridge window [io  0xb000-0xbfff]
[    0.512918] pci 0000:00:09.0:   bridge window [mem 0xfdb00000-0xfdbfffff]
[    0.512921] pci 0000:00:09.0:   bridge window [mem 0xfda00000-0xfdafffff 64bit pref]
[    0.512965] pci 0000:04:00.0: [1b4b:9172] type 00 class 0x010601
[    0.512974] pci 0000:04:00.0: reg 0x10: [io  0xaf00-0xaf07]
[    0.512980] pci 0000:04:00.0: reg 0x14: [io  0xae00-0xae03]
[    0.512986] pci 0000:04:00.0: reg 0x18: [io  0xad00-0xad07]
[    0.512992] pci 0000:04:00.0: reg 0x1c: [io  0xac00-0xac03]
[    0.512998] pci 0000:04:00.0: reg 0x20: [io  0xab00-0xab0f]
[    0.513004] pci 0000:04:00.0: reg 0x24: [mem 0xfd9ff000-0xfd9ff1ff]
[    0.513010] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.513038] pci 0000:04:00.0: PME# supported from D3hot
[    0.520927] pci 0000:00:0a.0: PCI bridge to [bus 04]
[    0.520931] pci 0000:00:0a.0:   bridge window [io  0xa000-0xafff]
[    0.520933] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
[    0.520936] pci 0000:00:0a.0:   bridge window [mem 0xfd800000-0xfd8fffff 64bit pref]
[    0.520994] pci 0000:05:00.0: [8086:10d3] type 00 class 0x020000
[    0.521014] pci 0000:05:00.0: reg 0x10: [mem 0xfd5c0000-0xfd5dffff]
[    0.521028] pci 0000:05:00.0: reg 0x14: [mem 0xfd500000-0xfd57ffff]
[    0.521041] pci 0000:05:00.0: reg 0x18: [io  0x9f00-0x9f1f]
[    0.521055] pci 0000:05:00.0: reg 0x1c: [mem 0xfd5fc000-0xfd5fffff]
[    0.521093] pci 0000:05:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    0.521167] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.528950] pci 0000:00:0c.0: PCI bridge to [bus 05]
[    0.528953] pci 0000:00:0c.0:   bridge window [io  0x9000-0x9fff]
[    0.528956] pci 0000:00:0c.0:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.528959] pci 0000:00:0c.0:   bridge window [mem 0xfcc00000-0xfccfffff 64bit pref]
[    0.529005] pci 0000:06:00.0: [197b:2363] type 00 class 0x010601
[    0.529069] pci 0000:06:00.0: reg 0x24: [mem 0xfcbff000-0xfcbff1ff]
[    0.529079] pci 0000:06:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.529126] pci 0000:06:00.0: PME# supported from D3hot
[    0.529183] pci 0000:06:00.1: [197b:0368] type 00 class 0x010185
[    0.529198] pci 0000:06:00.1: reg 0x10: [io  0xef00-0xef07]
[    0.529208] pci 0000:06:00.1: reg 0x14: [io  0xee00-0xee03]
[    0.529218] pci 0000:06:00.1: reg 0x18: [io  0xed00-0xed07]
[    0.529228] pci 0000:06:00.1: reg 0x1c: [io  0xec00-0xec03]
[    0.529238] pci 0000:06:00.1: reg 0x20: [io  0xeb00-0xeb0f]
[    0.536967] pci 0000:00:0d.0: PCI bridge to [bus 06]
[    0.536970] pci 0000:00:0d.0:   bridge window [io  0xe000-0xefff]
[    0.536973] pci 0000:00:0d.0:   bridge window [mem 0xfcb00000-0xfcbfffff]
[    0.536976] pci 0000:00:0d.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
[    0.537020] pci 0000:07:06.0: [8086:107c] type 00 class 0x020000
[    0.537041] pci 0000:07:06.0: reg 0x10: [mem 0xfd7a0000-0xfd7bffff]
[    0.537051] pci 0000:07:06.0: reg 0x14: [mem 0xfd7c0000-0xfd7dffff]
[    0.537061] pci 0000:07:06.0: reg 0x18: [io  0x8f00-0x8f3f]
[    0.537096] pci 0000:07:06.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.537136] pci 0000:07:06.0: PME# supported from D0 D3hot D3cold
[    0.537188] pci 0000:07:0e.0: [1106:3044] type 00 class 0x0c0010
[    0.537206] pci 0000:07:0e.0: reg 0x10: [mem 0xfd7ff000-0xfd7ff7ff]
[    0.537218] pci 0000:07:0e.0: reg 0x14: [io  0x8e00-0x8e7f]
[    0.537292] pci 0000:07:0e.0: supports D2
[    0.537294] pci 0000:07:0e.0: PME# supported from D2 D3hot D3cold
[    0.537345] pci 0000:00:14.4: PCI bridge to [bus 07] (subtractive decode)
[    0.537348] pci 0000:00:14.4:   bridge window [io  0x8000-0x8fff]
[    0.537352] pci 0000:00:14.4:   bridge window [mem 0xfd700000-0xfd7fffff]
[    0.537355] pci 0000:00:14.4:   bridge window [mem 0xfd600000-0xfd6fffff pref]
[    0.537357] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.537358] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.537360] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.537361] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.537363] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed44fff] (subtractive decode)
[    0.537364] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfffff] (subtractive decode)
[    0.537427] pci 0000:08:00.0: [10ec:8168] type 00 class 0x020000
[    0.537442] pci 0000:08:00.0: reg 0x10: [io  0x7e00-0x7eff]
[    0.537466] pci 0000:08:00.0: reg 0x18: [mem 0xfd3ff000-0xfd3fffff 64bit pref]
[    0.537482] pci 0000:08:00.0: reg 0x20: [mem 0xfd3f8000-0xfd3fbfff 64bit pref]
[    0.537547] pci 0000:08:00.0: supports D1 D2
[    0.537549] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.544986] pci 0000:00:15.0: PCI bridge to [bus 08]
[    0.544991] pci 0000:00:15.0:   bridge window [io  0x7000-0x7fff]
[    0.544994] pci 0000:00:15.0:   bridge window [mem 0xfd400000-0xfd4fffff]
[    0.544998] pci 0000:00:15.0:   bridge window [mem 0xfd300000-0xfd3fffff 64bit pref]
[    0.545063] pci 0000:09:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.545082] pci 0000:09:00.0: reg 0x10: [mem 0xfd2f8000-0xfd2fffff 64bit]
[    0.545169] pci 0000:09:00.0: supports D1 D2
[    0.545171] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.553003] pci 0000:00:15.1: PCI bridge to [bus 09]
[    0.553008] pci 0000:00:15.1:   bridge window [io  0x6000-0x6fff]
[    0.553011] pci 0000:00:15.1:   bridge window [mem 0xfd200000-0xfd2fffff]
[    0.553015] pci 0000:00:15.1:   bridge window [mem 0xfd100000-0xfd1fffff 64bit pref]
[    0.553076] pci 0000:0a:00.0: [1b4b:9172] type 00 class 0x010601
[    0.553088] pci 0000:0a:00.0: reg 0x10: [io  0x5f00-0x5f07]
[    0.553097] pci 0000:0a:00.0: reg 0x14: [io  0x5e00-0x5e03]
[    0.553105] pci 0000:0a:00.0: reg 0x18: [io  0x5d00-0x5d07]
[    0.553113] pci 0000:0a:00.0: reg 0x1c: [io  0x5c00-0x5c03]
[    0.553122] pci 0000:0a:00.0: reg 0x20: [io  0x5b00-0x5b0f]
[    0.553130] pci 0000:0a:00.0: reg 0x24: [mem 0xfd0ff000-0xfd0ff1ff]
[    0.553139] pci 0000:0a:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.553178] pci 0000:0a:00.0: PME# supported from D3hot
[    0.561019] pci 0000:00:15.2: PCI bridge to [bus 0a]
[    0.561024] pci 0000:00:15.2:   bridge window [io  0x5000-0x5fff]
[    0.561027] pci 0000:00:15.2:   bridge window [mem 0xfd000000-0xfd0fffff]
[    0.561031] pci 0000:00:15.2:   bridge window [mem 0xfcf00000-0xfcffffff 64bit pref]
[    0.561080] pci 0000:00:15.3: PCI bridge to [bus 0b]
[    0.561084] pci 0000:00:15.3:   bridge window [io  0x3000-0x3fff]
[    0.561087] pci 0000:00:15.3:   bridge window [mem 0xfce00000-0xfcefffff]
[    0.561091] pci 0000:00:15.3:   bridge window [mem 0xfcd00000-0xfcdfffff 64bit pref]
[    0.561118] acpi PNP0A03:00: ACPI _OSC support notification failed, disabling PCIe ASPM
[    0.561120] acpi PNP0A03:00: Unable to request _OSC control (_OSC support mask: 0x08)
[    0.609229] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
[    0.609288] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
[    0.609345] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
[    0.609403] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
[    0.609459] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
[    0.609514] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
[    0.609568] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
[    0.609623] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
[    0.610046] ACPI: \_SB_.PCI0: notify handler is installed
[    0.610074] Found 1 acpi root devices
[    0.610146] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.610149] vgaarb: loaded
[    0.610150] vgaarb: bridge control possible 0000:01:00.0
[    0.610269] SCSI subsystem initialized
[    0.610273] ACPI: bus type ATA registered
[    0.610327] libata version 3.00 loaded.
[    0.610412] PCI: Using ACPI for IRQ routing
[    0.616342] PCI: pci_cache_line_size set to 64 bytes
[    0.616350] pci 0000:00:00.0: no compatible bridge window for [mem 0xe0000000-0xffffffff 64bit]
[    0.616425] e820: reserve RAM buffer [mem 0x00095000-0x0009ffff]
[    0.616427] e820: reserve RAM buffer [mem 0xcfda0000-0xcfffffff]
[    0.616429] e820: reserve RAM buffer [mem 0x42f000000-0x42fffffff]
[    0.616500] NetLabel: Initializing
[    0.616501] NetLabel:  domain hash size = 128
[    0.616502] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.616511] NetLabel:  unlabeled traffic allowed by default
[    0.616544] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.616546] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.618613] Switched to clocksource hpet
[    0.620705] AppArmor: AppArmor Filesystem Enabled
[    0.620725] pnp: PnP ACPI init
[    0.620735] ACPI: bus type PNP registered
[    0.620824] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.620827] system 00:00: [io  0x0220-0x0225] has been reserved
[    0.620829] system 00:00: [io  0x0290-0x0294] has been reserved
[    0.620831] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.668036] pnp 00:01: disabling [mem 0x00000000-0x00000fff window] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
[    0.668063] pnp 00:01: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:01:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
[    0.668072] pnp 00:01: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:02:00.0 BAR 6 [mem 0x00000000-0x0000ffff pref]
[    0.668080] pnp 00:01: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:02:00.1 BAR 6 [mem 0x00000000-0x0000ffff pref]
[    0.668088] pnp 00:01: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:04:00.0 BAR 6 [mem 0x00000000-0x0000ffff pref]
[    0.668094] pnp 00:01: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:05:00.0 BAR 6 [mem 0x00000000-0x0003ffff pref]
[    0.668099] pnp 00:01: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:06:00.0 BAR 6 [mem 0x00000000-0x0000ffff pref]
[    0.668108] pnp 00:01: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:07:06.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
[    0.668118] pnp 00:01: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:0a:00.0 BAR 6 [mem 0x00000000-0x0000ffff pref]
[    0.668142] system 00:01: [io  0x0900-0x091f] has been reserved
[    0.668145] system 00:01: [io  0x0228-0x022f] has been reserved
[    0.668147] system 00:01: [io  0x040b] has been reserved
[    0.668149] system 00:01: [io  0x04d6] has been reserved
[    0.668151] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.668153] system 00:01: [io  0x0c14] has been reserved
[    0.668154] system 00:01: [io  0x0c50-0x0c52] has been reserved
[    0.668156] system 00:01: [io  0x0c6c-0x0c6d] has been reserved
[    0.668158] system 00:01: [io  0x0c6f] has been reserved
[    0.668160] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.668161] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.668163] system 00:01: [io  0x0cd4-0x0cdf] has been reserved
[    0.668165] system 00:01: [io  0x0800-0x08fe] could not be reserved
[    0.668167] system 00:01: [io  0x0a10-0x0a17] has been reserved
[    0.668169] system 00:01: [io  0x0b00-0x0b0f] has been reserved
[    0.668170] system 00:01: [io  0x0b10-0x0b1f] has been reserved
[    0.668172] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.668174] system 00:01: [mem 0xfee00400-0xfee00fff window] has been reserved
[    0.668177] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.668284] pnp 00:02: [dma 4]
[    0.668302] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.668380] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.668426] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.668447] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.668473] pnp 00:06: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.668828] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.668925] system 00:08: [mem 0xe0000000-0xefffffff] has been reserved
[    0.668927] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.669113] pnp 00:09: disabling [mem 0x000de000-0x000dffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
[    0.669119] pnp 00:09: disabling [mem 0x000f0000-0x000f7fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
[    0.669124] pnp 00:09: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
[    0.669128] pnp 00:09: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
[    0.669133] pnp 00:09: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
[    0.669137] pnp 00:09: disabling [mem 0x00100000-0xcfd9ffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
[    0.669192] system 00:09: [mem 0xcfda0000-0xcfdfffff] could not be reserved
[    0.669194] system 00:09: [mem 0xffff0000-0xffffffff] has been reserved
[    0.669196] system 00:09: [mem 0xcfe00000-0xcfefffff] has been reserved
[    0.669198] system 00:09: [mem 0xcff00000-0xcfffffff] could not be reserved
[    0.669200] system 00:09: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.669202] system 00:09: [mem 0xfee00000-0xfee00fff] could not be reserved
[    0.669203] system 00:09: [mem 0xfff80000-0xfffeffff] has been reserved
[    0.669205] system 00:09: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.669226] pnp: PnP ACPI: found 10 devices
[    0.669227] ACPI: bus type PNP unregistered
[    0.675239] pci 0000:01:00.0: BAR 6: assigned [mem 0xfb000000-0xfb01ffff pref]
[    0.675242] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.675244] pci 0000:00:02.0:   bridge window [io  0xd000-0xdfff]
[    0.675246] pci 0000:00:02.0:   bridge window [mem 0xf9000000-0xfbffffff]
[    0.675249] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.675252] pci 0000:02:00.0: BAR 6: assigned [mem 0xfdc00000-0xfdc0ffff pref]
[    0.675255] pci 0000:02:00.1: BAR 6: assigned [mem 0xfdc10000-0xfdc1ffff pref]
[    0.675257] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.675259] pci 0000:00:04.0:   bridge window [io  0xc000-0xcfff]
[    0.675261] pci 0000:00:04.0:   bridge window [mem 0xfdd00000-0xfddfffff]
[    0.675263] pci 0000:00:04.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
[    0.675266] pci 0000:00:09.0: PCI bridge to [bus 03]
[    0.675268] pci 0000:00:09.0:   bridge window [io  0xb000-0xbfff]
[    0.675270] pci 0000:00:09.0:   bridge window [mem 0xfdb00000-0xfdbfffff]
[    0.675272] pci 0000:00:09.0:   bridge window [mem 0xfda00000-0xfdafffff 64bit pref]
[    0.675276] pci 0000:04:00.0: BAR 6: assigned [mem 0xfd800000-0xfd80ffff pref]
[    0.675277] pci 0000:00:0a.0: PCI bridge to [bus 04]
[    0.675279] pci 0000:00:0a.0:   bridge window [io  0xa000-0xafff]
[    0.675281] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
[    0.675283] pci 0000:00:0a.0:   bridge window [mem 0xfd800000-0xfd8fffff 64bit pref]
[    0.675287] pci 0000:05:00.0: BAR 6: assigned [mem 0xfcc00000-0xfcc3ffff pref]
[    0.675288] pci 0000:00:0c.0: PCI bridge to [bus 05]
[    0.675290] pci 0000:00:0c.0:   bridge window [io  0x9000-0x9fff]
[    0.675292] pci 0000:00:0c.0:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.675294] pci 0000:00:0c.0:   bridge window [mem 0xfcc00000-0xfccfffff 64bit pref]
[    0.675297] pci 0000:06:00.0: BAR 6: assigned [mem 0xfde00000-0xfde0ffff pref]
[    0.675299] pci 0000:00:0d.0: PCI bridge to [bus 06]
[    0.675301] pci 0000:00:0d.0:   bridge window [io  0xe000-0xefff]
[    0.675303] pci 0000:00:0d.0:   bridge window [mem 0xfcb00000-0xfcbfffff]
[    0.675305] pci 0000:00:0d.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
[    0.675308] pci 0000:07:06.0: BAR 6: assigned [mem 0xfd600000-0xfd61ffff pref]
[    0.675310] pci 0000:00:14.4: PCI bridge to [bus 07]
[    0.675312] pci 0000:00:14.4:   bridge window [io  0x8000-0x8fff]
[    0.675316] pci 0000:00:14.4:   bridge window [mem 0xfd700000-0xfd7fffff]
[    0.675318] pci 0000:00:14.4:   bridge window [mem 0xfd600000-0xfd6fffff pref]
[    0.675323] pci 0000:00:15.0: PCI bridge to [bus 08]
[    0.675325] pci 0000:00:15.0:   bridge window [io  0x7000-0x7fff]
[    0.675328] pci 0000:00:15.0:   bridge window [mem 0xfd400000-0xfd4fffff]
[    0.675331] pci 0000:00:15.0:   bridge window [mem 0xfd300000-0xfd3fffff 64bit pref]
[    0.675335] pci 0000:00:15.1: PCI bridge to [bus 09]
[    0.675337] pci 0000:00:15.1:   bridge window [io  0x6000-0x6fff]
[    0.675340] pci 0000:00:15.1:   bridge window [mem 0xfd200000-0xfd2fffff]
[    0.675343] pci 0000:00:15.1:   bridge window [mem 0xfd100000-0xfd1fffff 64bit pref]
[    0.675347] pci 0000:0a:00.0: BAR 6: assigned [mem 0xfcf00000-0xfcf0ffff pref]
[    0.675348] pci 0000:00:15.2: PCI bridge to [bus 0a]
[    0.675350] pci 0000:00:15.2:   bridge window [io  0x5000-0x5fff]
[    0.675354] pci 0000:00:15.2:   bridge window [mem 0xfd000000-0xfd0fffff]
[    0.675356] pci 0000:00:15.2:   bridge window [mem 0xfcf00000-0xfcffffff 64bit pref]
[    0.675360] pci 0000:00:15.3: PCI bridge to [bus 0b]
[    0.675362] pci 0000:00:15.3:   bridge window [io  0x3000-0x3fff]
[    0.675365] pci 0000:00:15.3:   bridge window [mem 0xfce00000-0xfcefffff]
[    0.675368] pci 0000:00:15.3:   bridge window [mem 0xfcd00000-0xfcdfffff 64bit pref]
[    0.676440] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.676442] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.676443] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.676445] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
[    0.676446] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff]
[    0.676448] pci_bus 0000:00: resource 9 [mem 0xd0000000-0xfebfffff]
[    0.676450] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.676451] pci_bus 0000:01: resource 1 [mem 0xf9000000-0xfbffffff]
[    0.676453] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.676454] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
[    0.676456] pci_bus 0000:02: resource 1 [mem 0xfdd00000-0xfddfffff]
[    0.676457] pci_bus 0000:02: resource 2 [mem 0xfdc00000-0xfdcfffff 64bit pref]
[    0.676459] pci_bus 0000:03: resource 0 [io  0xb000-0xbfff]
[    0.676460] pci_bus 0000:03: resource 1 [mem 0xfdb00000-0xfdbfffff]
[    0.676462] pci_bus 0000:03: resource 2 [mem 0xfda00000-0xfdafffff 64bit pref]
[    0.676463] pci_bus 0000:04: resource 0 [io  0xa000-0xafff]
[    0.676465] pci_bus 0000:04: resource 1 [mem 0xfd900000-0xfd9fffff]
[    0.676466] pci_bus 0000:04: resource 2 [mem 0xfd800000-0xfd8fffff 64bit pref]
[    0.676468] pci_bus 0000:05: resource 0 [io  0x9000-0x9fff]
[    0.676469] pci_bus 0000:05: resource 1 [mem 0xfd500000-0xfd5fffff]
[    0.676471] pci_bus 0000:05: resource 2 [mem 0xfcc00000-0xfccfffff 64bit pref]
[    0.676472] pci_bus 0000:06: resource 0 [io  0xe000-0xefff]
[    0.676474] pci_bus 0000:06: resource 1 [mem 0xfcb00000-0xfcbfffff]
[    0.676475] pci_bus 0000:06: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
[    0.676477] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
[    0.676478] pci_bus 0000:07: resource 1 [mem 0xfd700000-0xfd7fffff]
[    0.676479] pci_bus 0000:07: resource 2 [mem 0xfd600000-0xfd6fffff pref]
[    0.676481] pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7]
[    0.676482] pci_bus 0000:07: resource 5 [io  0x0d00-0xffff]
[    0.676484] pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff]
[    0.676485] pci_bus 0000:07: resource 7 [mem 0x000c0000-0x000dffff]
[    0.676487] pci_bus 0000:07: resource 8 [mem 0xfed40000-0xfed44fff]
[    0.676488] pci_bus 0000:07: resource 9 [mem 0xd0000000-0xfebfffff]
[    0.676489] pci_bus 0000:08: resource 0 [io  0x7000-0x7fff]
[    0.676491] pci_bus 0000:08: resource 1 [mem 0xfd400000-0xfd4fffff]
[    0.676492] pci_bus 0000:08: resource 2 [mem 0xfd300000-0xfd3fffff 64bit pref]
[    0.676494] pci_bus 0000:09: resource 0 [io  0x6000-0x6fff]
[    0.676495] pci_bus 0000:09: resource 1 [mem 0xfd200000-0xfd2fffff]
[    0.676497] pci_bus 0000:09: resource 2 [mem 0xfd100000-0xfd1fffff 64bit pref]
[    0.676498] pci_bus 0000:0a: resource 0 [io  0x5000-0x5fff]
[    0.676500] pci_bus 0000:0a: resource 1 [mem 0xfd000000-0xfd0fffff]
[    0.676501] pci_bus 0000:0a: resource 2 [mem 0xfcf00000-0xfcffffff 64bit pref]
[    0.676503] pci_bus 0000:0b: resource 0 [io  0x3000-0x3fff]
[    0.676504] pci_bus 0000:0b: resource 1 [mem 0xfce00000-0xfcefffff]
[    0.676505] pci_bus 0000:0b: resource 2 [mem 0xfcd00000-0xfcdfffff 64bit pref]
[    0.676575] NET: Registered protocol family 2
[    0.676835] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[    0.677254] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.677430] TCP: Hash tables configured (established 131072 bind 65536)
[    0.677456] TCP: reno registered
[    0.677473] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.677536] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.677658] NET: Registered protocol family 1
[    0.968965] pci 0000:01:00.0: Boot video device
[    0.969107] PCI: CLS 64 bytes, default 64
[    0.969145] Unpacking initramfs...
[    1.574782] Freeing initrd memory: 39980K (ffff8800358e5000 - ffff880037ff0000)
[    1.650996] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.651001] pci 0000:00:00.2: PCI INT A: no GSI
[    1.651012] AMD-Vi: Applying merge-fn quirk for device 0000:02:00.0
[    1.651014] AMD-Vi: Applying merge-fn quirk for device 0000:04:00.0
[    1.651017] AMD-Vi: Applying merge-fn quirk for device 0000:0a:00.0
[    1.651213] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.651230] pci 0000:00:00.2: irq 40 for MSI/MSI-X
[    1.661000] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.736869] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.736872] software IO TLB [mem 0xcbda0000-0xcfda0000] (64MB) mapped at [ffff8800cbda0000-ffff8800cfd9ffff]
[    1.737121] perf: AMD NB counters detected
[    1.737144] LVT offset 0 assigned for vector 0x400
[    1.737162] perf: AMD IBS detected (0x000000ff)
[    1.737377] Scanning for low memory corruption every 60 seconds
[    1.737626] audit: initializing netlink socket (disabled)
[    1.737636] type=2000 audit(1375437820.556:1): initialized
[    1.757567] bounce pool size: 64 pages
[    1.757573] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.758411] VFS: Disk quotas dquot_6.5.2
[    1.758435] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.758677] msgmni has been set to 31991
[    1.758829] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.758861] io scheduler noop registered
[    1.758862] io scheduler deadline registered
[    1.758880] io scheduler cfq registered (default)
[    1.759234] vesafb: mode is 1280x1024x16, linelength=2560, pages=1
[    1.759235] vesafb: scrolling: redraw
[    1.759237] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    1.759463] vesafb: framebuffer at 0xd0000000, mapped to 0xffffc90011c80000, using 5120k, total 131072k
[    1.785901] Console: switching to colour frame buffer device 160x64
[    1.812272] fb0: VESA VGA frame buffer device
[    1.812298] GHES: HEST is not enabled!
[    1.812332] Serial: 8250/16550 driver, 32 ports, IRQ sharing disabled
[    1.832711] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.833808] Non-volatile memory driver v1.3
[    1.833810] Linux agpgart interface v0.103
[    1.833917] ahci 0000:00:11.0: version 3.0
[    1.834127] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    1.834130] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    1.834719] scsi0 : ahci
[    1.834791] scsi1 : ahci
[    1.834842] scsi2 : ahci
[    1.834890] scsi3 : ahci
[    1.834939] scsi4 : ahci
[    1.834986] scsi5 : ahci
[    1.835039] ata1: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff100 irq 19
[    1.835041] ata2: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff180 irq 19
[    1.835043] ata3: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff200 irq 19
[    1.835045] ata4: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff280 irq 19
[    1.835047] ata5: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff300 irq 19
[    1.835049] ata6: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff380 irq 19
[    1.835126] ahci 0000:02:00.0: irq 41 for MSI/MSI-X
[    1.835137] ahci 0000:02:00.0: controller can do FBS, turning on CAP_FBS
[    1.847773] ahci 0000:02:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[    1.847776] ahci 0000:02:00.0: flags: 64bit ncq fbs pio 
[    1.848521] scsi6 : ahci
[    1.848571] scsi7 : ahci
[    1.848621] scsi8 : ahci
[    1.848669] scsi9 : ahci
[    1.848720] scsi10 : ahci
[    1.848768] scsi11 : ahci
[    1.848815] scsi12 : ahci
[    1.848863] scsi13 : ahci
[    1.848896] ata7: SATA max UDMA/133 abar m2048@0xfddff000 port 0xfddff100 irq 41
[    1.848898] ata8: SATA max UDMA/133 abar m2048@0xfddff000 port 0xfddff180 irq 41
[    1.848900] ata9: SATA max UDMA/133 abar m2048@0xfddff000 port 0xfddff200 irq 41
[    1.848902] ata10: SATA max UDMA/133 abar m2048@0xfddff000 port 0xfddff280 irq 41
[    1.848903] ata11: SATA max UDMA/133 abar m2048@0xfddff000 port 0xfddff300 irq 41
[    1.848905] ata12: SATA max UDMA/133 abar m2048@0xfddff000 port 0xfddff380 irq 41
[    1.848907] ata13: SATA max UDMA/133 abar m2048@0xfddff000 port 0xfddff400 irq 41
[    1.848908] ata14: SATA max UDMA/133 abar m2048@0xfddff000 port 0xfddff480 irq 41
[    1.848994] ahci 0000:04:00.0: irq 42 for MSI/MSI-X
[    1.849036] ahci 0000:04:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.849038] ahci 0000:04:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.849262] scsi14 : ahci
[    1.849308] scsi15 : ahci
[    1.849338] ata15: SATA max UDMA/133 abar m512@0xfd9ff000 port 0xfd9ff100 irq 42
[    1.849340] ata16: SATA max UDMA/133 abar m512@0xfd9ff000 port 0xfd9ff180 irq 42
[    1.849401] ahci 0000:06:00.0: irq 43 for MSI/MSI-X
[    1.849453] ahci 0000:06:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    1.849455] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    1.849675] scsi16 : ahci
[    1.849723] scsi17 : ahci
[    1.849755] ata17: SATA max UDMA/133 abar m512@0xfcbff000 port 0xfcbff100 irq 43
[    1.849757] ata18: SATA max UDMA/133 abar m512@0xfcbff000 port 0xfcbff180 irq 43
[    1.849816] ahci 0000:0a:00.0: irq 44 for MSI/MSI-X
[    1.849861] ahci 0000:0a:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.849863] ahci 0000:0a:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.850083] scsi18 : ahci
[    1.850130] scsi19 : ahci
[    1.850160] ata19: SATA max UDMA/133 abar m512@0xfd0ff000 port 0xfd0ff100 irq 44
[    1.850162] ata20: SATA max UDMA/133 abar m512@0xfd0ff000 port 0xfd0ff180 irq 44
[    1.850222] libphy: Fixed MDIO Bus: probed
[    1.850246] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    1.883454] i8042: Failed to disable AUX port, but continuing anyway... Is this a SiS?
[    1.883687] i8042: If AUX port is really absent please use the 'i8042.noaux' option
[    1.895196] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040440 flags=0x0070]
[    1.895514] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040450 flags=0x0070]
[    2.136327] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.136412] mousedev: PS/2 mouse device common for all mice
[    2.136483] rtc_cmos 00:04: RTC can wake from S4
[    2.136578] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    2.136598] rtc_cmos 00:04: alarms up to one month, 242 bytes nvram, hpet irqs
[    2.136604] cpuidle: using governor ladder
[    2.136605] cpuidle: using governor menu
[    2.136617] hidraw: raw HID events driver (C) Jiri Kosina
[    2.136750] TCP: cubic registered
[    2.136804] NET: Registered protocol family 10
[    2.136950] Key type dns_resolver registered
[    2.137075] Key type ceph registered
[    2.137216] libceph: loaded (mon/osd proto 15/24)
[    2.137526] registered taskstats version 1
[    2.138609]   Magic number: 9:732:71
[    2.138653] memory memory99: hash matches
[    2.138685] rtc_cmos 00:04: setting system clock to 2013-08-02 10:03:41 UTC (1375437821)
[    2.176335] ata5: SATA link down (SStatus 0 SControl 300)
[    2.192354] ata15: SATA link down (SStatus 0 SControl 300)
[    2.192377] ata18: SATA link down (SStatus 0 SControl 300)
[    2.192866] ata8: SATA link down (SStatus 0 SControl 300)
[    2.193861] ata11: SATA link down (SStatus 0 SControl 300)
[    2.193873] ata16: SATA link down (SStatus 0 SControl 300)
[    2.194216] ata9: SATA link down (SStatus 0 SControl 300)
[    2.194232] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.195242] ata12: SATA link down (SStatus 0 SControl 300)
[    2.195253] ata19: SATA link down (SStatus 0 SControl 300)
[    2.195264] ata10: SATA link down (SStatus 0 SControl 300)
[    2.201867] ata13: SATA link down (SStatus 0 SControl 300)
[    2.202220] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.202283] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
[    2.202386] ata14.00: configured for UDMA/66
[    2.206156] ata7.00: ATA-8: OCZ-VERTEX3 MI, 2.22, max UDMA/133
[    2.206158] ata7.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.216079] ata7.00: configured for UDMA/133
[    2.222999] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040440 flags=0x0070]
[    2.223315] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040450 flags=0x0070]
[    2.348618] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.349379] ata6.00: ATA-8: WDC WD1002FBYS-02A6B0, 03.00C06, max UDMA/133
[    2.349382] ata6.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    2.350220] ata6.00: configured for UDMA/133
[    2.350557] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.350574] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.350591] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.351442] ata1.00: ATA-8: WDC WD5002ABYS-01B1B0, 02.03B02, max UDMA/133
[    2.351444] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    2.351523] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.352374] ata1.00: configured for UDMA/133
[    2.352486] scsi 0:0:0:0: Direct-Access     ATA      WDC WD5002ABYS-0 02.0 PQ: 0 ANSI: 5
[    2.352848] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    2.353156] sd 0:0:0:0: [sda] Write Protect is off
[    2.353180] ata4.00: ATA-8: WDC WD1003FBYX-01Y7B1, 01.01V02, max UDMA/133
[    2.353182] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    2.353298] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.353325] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.354758] ata3.00: ATA-8: WDC WD2003FYYS-02W0B1, 01.01D02, max UDMA/133
[    2.354761] ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    2.355413] ata2.00: ATA-8: WDC WD2003FYYS-02W0B1, 01.01D02, max UDMA/133
[    2.355415] ata2.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    2.355481] ata4.00: configured for UDMA/133
[    2.358778] ata3.00: configured for UDMA/133
[    2.359419] ata2.00: configured for UDMA/133
[    2.359508] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2003FYYS-0 01.0 PQ: 0 ANSI: 5
[    2.359833] sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[    2.359940] scsi 2:0:0:0: Direct-Access     ATA      WDC WD2003FYYS-0 01.0 PQ: 0 ANSI: 5
[    2.360044] sd 2:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[    2.360128] sd 2:0:0:0: [sdc] Write Protect is off
[    2.360130] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.360158] scsi 3:0:0:0: Direct-Access     ATA      WDC WD1003FBYX-0 01.0 PQ: 0 ANSI: 5
[    2.360162] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.360262] sd 3:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    2.360386] sd 3:0:0:0: [sdd] Write Protect is off
[    2.360387] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.360419] scsi 5:0:0:0: Direct-Access     ATA      WDC WD1002FBYS-0 03.0 PQ: 0 ANSI: 5
[    2.360420] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.360527] sd 5:0:0:0: [sde] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    2.360618] scsi 6:0:0:0: Direct-Access     ATA      OCZ-VERTEX3 MI   2.22 PQ: 0 ANSI: 5
[    2.360660] sd 5:0:0:0: [sde] Write Protect is off
[    2.360662] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    2.360690] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.360705] sd 6:0:0:0: [sdf] 234441648 512-byte logical blocks: (120 GB/111 GiB)
[    2.360822] sd 6:0:0:0: [sdf] Write Protect is off
[    2.360824] sd 6:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    2.360855] sd 6:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.360920] scsi 13:0:0:0: Processor         Marvell  91xx Config      1.01 PQ: 0 ANSI: 5
[    2.362571]  sdf: sdf1
[    2.362869] sd 6:0:0:0: [sdf] Attached SCSI disk
[    2.364023] sd 1:0:0:0: [sdb] Write Protect is off
[    2.364164] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.364189] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.367090] ata17: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.367579] ata20: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.368224] ata20.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[    2.368218] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040420 flags=0x0070]
[    2.368754] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040430 flags=0x0070]
[    2.369071] ata17.00: ATAPI: TSSTcorpDVD-ROM SH-D163C, SB02, max UDMA/100
[    2.369074] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x00000000000583a0 flags=0x0070]
[    2.369393] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x00000000000403e0 flags=0x0070]
[    2.369712] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000058580 flags=0x0070]
[    2.371618] ata17.00: configured for UDMA/100
[    2.372897]  sde: sde1
[    2.373161] sd 5:0:0:0: [sde] Attached SCSI disk
[    2.377549]  sdc: sdc1
[    2.377811] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.378872]  sdb: sdb1
[    2.379115]  sdd: sdd1
[    2.379131] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.379338] sd 3:0:0:0: [sdd] Attached SCSI disk
[    2.392532]  sda: sda1 < sda5 sda6 sda7 sda8 sda9 > sda2 sda3
[    2.392958] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.432757] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x00000000000583c0 flags=0x0070]
[    2.443194] scsi 16:0:0:0: CD-ROM            TSSTcorp DVD-ROM SH-D163C SB02 PQ: 0 ANSI: 5
[    2.443180] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000058400 flags=0x0070]
[    2.464133] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000058440 flags=0x0070]
[    2.474801] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000058480 flags=0x0070]
[    2.485293] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x00000000000584c0 flags=0x0070]
[    2.495610] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000058500 flags=0x0070]
[    2.505749] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000058540 flags=0x0070]
[    2.780451] tsc: Refined TSC clocksource calibration: 3624.293 MHz
[    2.780489] Switched to clocksource tsc
[    7.397307] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040440 flags=0x0070]
[    7.407105] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040450 flags=0x0070]
[    7.725172] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040440 flags=0x0070]
[    7.734611] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040450 flags=0x0070]
[    7.868318] ata20: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.868942] ata20.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[    7.868945] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040420 flags=0x0070]
[    7.868947] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040430 flags=0x0070]
[    7.868948] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x00000000000593a0 flags=0x0070]
[    7.868949] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x00000000000403e0 flags=0x0070]
[    7.868950] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000059580 flags=0x0070]
[    7.868951] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x00000000000593c0 flags=0x0070]
[    7.868952] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x00000000000594c0 flags=0x0070]
[    7.868952] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000059400 flags=0x0070]
[    7.868953] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000059500 flags=0x0070]
[    7.868954] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000059440 flags=0x0070]
[    7.868955] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000059540 flags=0x0070]
[    7.868956] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000059480 flags=0x0070]
[    7.984075] ata20: limiting SATA link speed to 1.5 Gbps
[   12.899726] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040440 flags=0x0070]
[   12.907931] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040450 flags=0x0070]
[   13.228601] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040440 flags=0x0070]
[   13.236540] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040450 flags=0x0070]
[   13.371033] ata20: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   13.371650] ata20.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   13.371646] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040420 flags=0x0070]
[   13.387304] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040430 flags=0x0070]
[   13.395352] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x000000000005a3a0 flags=0x0070]
[   13.403240] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x000000000005a3c0 flags=0x0070]
[   13.411009] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x000000000005a400 flags=0x0070]
[   13.418640] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x000000000005a440 flags=0x0070]
[   13.426088] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x000000000005a480 flags=0x0070]
[   13.433376] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x000000000005a4c0 flags=0x0070]
[   13.440546] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x000000000005a500 flags=0x0070]
[   13.447569] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x000000000005a540 flags=0x0070]
[   13.454406] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x00000000000403e0 flags=0x0070]
[   13.461088] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x000000000005a580 flags=0x0070]
[   18.402109] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040440 flags=0x0070]
[   18.408508] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040450 flags=0x0070]
[   18.730997] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040440 flags=0x0070]
[   18.737104] AMD-Vi: Event logged [IO_PAGE_FAULT device=0a:00.1 domain=0x0000 address=0x0000000000040450 flags=0x0070]
[   18.873749] ata20: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   18.874863] Freeing unused kernel memory: 1264K (ffffffff81abd000 - ffffffff81bf9000)
[   18.874865] Write protecting the kernel read-only data: 10240k
[   18.875471] Freeing unused kernel memory: 224K (ffff8800015c8000 - ffff880001600000)
[   18.878266] Freeing unused kernel memory: 1292K (ffff8800018bd000 - ffff880001a00000)
[   18.912815] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
[   18.913108] scsi20 : pata_jmicron
[   18.913154] scsi21 : pata_jmicron
[   18.913182] ata21: PATA max UDMA/100 cmd 0xef00 ctl 0xee00 bmdma 0xeb00 irq 18
[   18.913184] ata22: PATA max UDMA/100 cmd 0xed00 ctl 0xec00 bmdma 0xeb08 irq 18
[   19.273734] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[   19.293826] ACPI: processor limited to max C-state 1
[   19.303263] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[   19.303265] EDD information not available.
[   19.331251] udevd[189]: starting version 173
[   19.345537] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[   19.345599] ACPI: Power Button [PWRB]
[   19.345669] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[   19.345707] ACPI: Power Button [PWRF]
[   19.346196] wmi: Mapper loaded
[   19.354482] [drm] Initialized drm 1.1.0 20060810
[   20.324517] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: (null)
[   20.471803] EXT4-fs (sda7): re-mounted. Opts: (null)
[   21.858698] udevd[514]: starting version 173
[   22.540064] acpi-cpufreq: overriding BIOS provided _PSD data
[   22.558087] input: PC Speaker as /devices/platform/pcspkr/input/input2
[   22.751884] MCE: In-kernel MCE decoding enabled.
[   22.777971] EDAC MC: Ver: 3.0.0
[   22.840665] scsi22 : pata_marvell
[   22.840801] scsi23 : pata_marvell
[   22.840915] ata23: PATA max UDMA/100 cmd 0xca00 ctl 0xc900 bmdma 0xc600 irq 17
[   22.840920] ata24: PATA max UDMA/133 cmd 0xc800 ctl 0xc700 bmdma 0xc608 irq 17
[   22.862262] pps_core: LinuxPPS API ver. 1 registered
[   22.862267] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[   22.867667] PTP clock support registered
[   22.932429] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[   22.932434] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   22.964858] ALSA sound/pci/hda/hda_intel.c:3317 0000:00:14.2: Using LPIB position fix
[   22.986772] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   22.994910] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   22.998321] ALSA sound/pci/hda/hda_intel.c:1787 0000:00:14.2: Enable sync_write for stable communication
[   23.003258] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   23.004341] sr0: scsi3-mmc drive: 1x/32x cd/rw xa/form2 cdda tray
[   23.004343] cdrom: Uniform CD-ROM driver Revision: 3.20
[   23.004645] sr 16:0:0:0: Attached scsi CD-ROM sr0
[   23.019994] sd 3:0:0:0: Attached scsi generic sg3 type 0
[   23.028608] sd 5:0:0:0: Attached scsi generic sg4 type 0
[   23.037209] sd 6:0:0:0: Attached scsi generic sg5 type 0
[   23.045871] scsi 13:0:0:0: Attached scsi generic sg6 type 3
[   23.054541] ALSA sound/pci/hda/patch_realtek.c:418 SKU: Nid=0x1d sku_cfg=0x4005e601
[   23.054548] ALSA sound/pci/hda/patch_realtek.c:420 SKU: port_connectivity=0x1
[   23.054552] ALSA sound/pci/hda/patch_realtek.c:421 SKU: enable_pcbeep=0x0
[   23.054555] ALSA sound/pci/hda/patch_realtek.c:422 SKU: check_sum=0x00000005
[   23.054558] ALSA sound/pci/hda/patch_realtek.c:423 SKU: customization=0x000000e6
[   23.054561] ALSA sound/pci/hda/patch_realtek.c:424 SKU: external_amp=0x0
[   23.054564] ALSA sound/pci/hda/patch_realtek.c:425 SKU: platform_type=0x0
[   23.054569] ALSA sound/pci/hda/patch_realtek.c:426 SKU: swap=0x0
[   23.054572] ALSA sound/pci/hda/patch_realtek.c:427 SKU: override=0x1
[   23.054625] sr 16:0:0:0: Attached scsi generic sg7 type 5
[   23.063384] ALSA sound/pci/hda/hda_auto_parser.c:393 autoconfig: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   23.063389] ALSA sound/pci/hda/hda_auto_parser.c:397    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   23.063394] ALSA sound/pci/hda/hda_auto_parser.c:401    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   23.063397] ALSA sound/pci/hda/hda_auto_parser.c:402    mono: mono_out=0x0
[   23.063400] ALSA sound/pci/hda/hda_auto_parser.c:405    dig-out=0x11/0x1e
[   23.063403] ALSA sound/pci/hda/hda_auto_parser.c:406    inputs:
[   23.063407] ALSA sound/pci/hda/hda_auto_parser.c:410      Front Mic=0x19
[   23.063411] ALSA sound/pci/hda/hda_auto_parser.c:410      Rear Mic=0x18
[   23.063415] ALSA sound/pci/hda/hda_auto_parser.c:410      Line=0x1a
[   23.063419] ALSA sound/pci/hda/patch_realtek.c:490 realtek: No valid SSID, checking pincfg 0x4005e601 for NID 0x1d
[   23.063423] ALSA sound/pci/hda/patch_realtek.c:506 realtek: Enabling init ASM_ID=0xe601 CODEC_ID=10ec0889
[   23.094045] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input3
[   23.094355] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input4
[   23.094589] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input5
[   23.094805] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input6
[   23.094930] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[   23.095047] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[   23.095166] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[   23.095283] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[   23.095777] ACPI Warning: 0x0000000000000b00-0x0000000000000b07 SystemIO conflicts with Region \SOR1 1 (20130517/utaddress-251)
[   23.104495] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   23.136730] AMD64 EDAC driver v3.4.0
[   23.136913] EDAC amd64: DRAM ECC disabled.
[   23.136943] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[   23.136943]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
[   23.136943]  (Note that use of the override may cause unknown side effects.)
[   23.303992] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[   23.303997] e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
[   23.304042] e1000e 0000:05:00.0: Disabling ASPM L0s L1
[   23.304047] e1000e 0000:05:00.0: can't disable ASPM; OS doesn't have ASPM control
[   23.313465] e1000e 0000:05:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   23.313503] e1000e 0000:05:00.0: irq 45 for MSI/MSI-X
[   23.313518] e1000e 0000:05:00.0: irq 46 for MSI/MSI-X
[   23.313531] e1000e 0000:05:00.0: irq 47 for MSI/MSI-X
[   23.364025] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[   23.364128] sp5100_tco: PCI Revision ID: 0x42
[   23.364168] sp5100_tco: Using 0xfed80b00 for watchdog MMIO address
[   23.364180] sp5100_tco: Last reboot was not triggered by watchdog.
[   23.364297] sp5100_tco: initialized (0xffffc90001872b00). heartbeat=60 sec (nowayout=0)
[   23.390840] e1000 0000:07:06.0 eth0: (PCI:33MHz:32-bit) 00:1b:21:56:a6:0b
[   23.390852] e1000 0000:07:06.0 eth0: Intel(R) PRO/1000 Network Connection
[   23.462226] firewire_ohci 0000:07:0e.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x11
[   23.488763] e1000e 0000:05:00.0 eth0: registered PHC clock
[   23.488770] e1000e 0000:05:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 00:1b:21:bc:62:a0
[   23.488775] e1000e 0000:05:00.0 eth0: Intel(R) PRO/1000 Network Connection
[   23.488789] e1000e 0000:05:00.0 eth0: MAC: 3, PHY: 8, PBA No: E46981-005
[   23.501939] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   23.501963] r8169 0000:08:00.0: can't disable ASPM; OS doesn't have ASPM control
[   23.511364] r8169 0000:08:00.0: irq 48 for MSI/MSI-X
[   23.511658] r8169 0000:08:00.0 eth2: RTL8168evl/8111evl at 0xffffc90001876000, 1c:6f:65:f9:13:61, XID 0c900800 IRQ 48
[   23.511663] r8169 0000:08:00.0 eth2: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   23.792642] ACPI: bus type USB registered
[   23.792698] usbcore: registered new interface driver usbfs
[   23.792739] usbcore: registered new interface driver hub
[   23.792838] usbcore: registered new device driver usb
[   23.855243] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   23.894841] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   23.900148] ehci-pci: EHCI PCI platform driver
[   23.900580] ehci-pci 0000:00:12.2: EHCI Host Controller
[   23.900596] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[   23.900626] QUIRK: Enable AMD PLL fix
[   23.900630] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   23.900645] ehci-pci 0000:00:12.2: debug port 1
[   23.900682] ehci-pci 0000:00:12.2: irq 17, io mem 0xfdffd000
[   23.914219] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[   23.914262] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   23.914267] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.914272] usb usb1: Product: EHCI Host Controller
[   23.914276] usb usb1: Manufacturer: Linux 3.11.0-rc3-1.29-default ehci_hcd
[   23.914279] usb usb1: SerialNumber: 0000:00:12.2
[   23.914501] hub 1-0:1.0: USB hub found
[   23.914510] hub 1-0:1.0: 5 ports detected
[   23.914728] xhci_hcd 0000:03:00.0: xHCI Host Controller
[   23.914744] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 2
[   23.914873] xhci_hcd 0000:03:00.0: irq 49 for MSI/MSI-X
[   23.914957] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[   23.914962] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.914966] usb usb2: Product: xHCI Host Controller
[   23.914969] usb usb2: Manufacturer: Linux 3.11.0-rc3-1.29-default xhci_hcd
[   23.914973] usb usb2: SerialNumber: 0000:03:00.0
[   23.915274] xHCI xhci_add_endpoint called for root hub
[   23.915281] xHCI xhci_check_bandwidth called for root hub
[   23.915355] hub 2-0:1.0: USB hub found
[   23.915369] hub 2-0:1.0: 2 ports detected
[   23.915607] xhci_hcd 0000:03:00.0: xHCI Host Controller
[   23.915620] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 3
[   23.915637] ehci-pci 0000:00:13.2: EHCI Host Controller
[   23.915682] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003
[   23.915687] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.915691] usb usb3: Product: xHCI Host Controller
[   23.915694] usb usb3: Manufacturer: Linux 3.11.0-rc3-1.29-default xhci_hcd
[   23.915698] usb usb3: SerialNumber: 0000:03:00.0
[   23.915855] ohci-pci: OHCI PCI platform driver
[   23.915898] xHCI xhci_add_endpoint called for root hub
[   23.915903] xHCI xhci_check_bandwidth called for root hub
[   23.915986] hub 3-0:1.0: USB hub found
[   23.915997] hub 3-0:1.0: 2 ports detected
[   23.916142] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 4
[   23.916152] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   23.916170] ehci-pci 0000:00:13.2: debug port 1
[   23.916209] ehci-pci 0000:00:13.2: irq 17, io mem 0xfdffb000
[   23.928708] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[   23.928747] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[   23.928752] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.928756] usb usb4: Product: EHCI Host Controller
[   23.928760] usb usb4: Manufacturer: Linux 3.11.0-rc3-1.29-default ehci_hcd
[   23.928763] usb usb4: SerialNumber: 0000:00:13.2
[   23.928965] hub 4-0:1.0: USB hub found
[   23.928973] hub 4-0:1.0: 5 ports detected
[   23.929189] xhci_hcd 0000:09:00.0: xHCI Host Controller
[   23.929206] xhci_hcd 0000:09:00.0: new USB bus registered, assigned bus number 5
[   23.929361] xhci_hcd 0000:09:00.0: irq 50 for MSI/MSI-X
[   23.929446] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[   23.929450] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.929454] usb usb5: Product: xHCI Host Controller
[   23.929458] usb usb5: Manufacturer: Linux 3.11.0-rc3-1.29-default xhci_hcd
[   23.929462] usb usb5: SerialNumber: 0000:09:00.0
[   23.929611] xHCI xhci_add_endpoint called for root hub
[   23.929615] xHCI xhci_check_bandwidth called for root hub
[   23.929679] hub 5-0:1.0: USB hub found
[   23.929692] hub 5-0:1.0: 2 ports detected
[   23.929845] xhci_hcd 0000:09:00.0: xHCI Host Controller
[   23.929852] xhci_hcd 0000:09:00.0: new USB bus registered, assigned bus number 6
[   23.929872] ehci-pci 0000:00:16.2: EHCI Host Controller
[   23.929888] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003
[   23.929893] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.929896] usb usb6: Product: xHCI Host Controller
[   23.929900] usb usb6: Manufacturer: Linux 3.11.0-rc3-1.29-default xhci_hcd
[   23.929903] usb usb6: SerialNumber: 0000:09:00.0
[   23.930024] xHCI xhci_add_endpoint called for root hub
[   23.930028] xHCI xhci_check_bandwidth called for root hub
[   23.930089] hub 6-0:1.0: USB hub found
[   23.930102] hub 6-0:1.0: 2 ports detected
[   23.930229] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 7
[   23.930236] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[   23.930251] ehci-pci 0000:00:16.2: debug port 1
[   23.930290] ehci-pci 0000:00:16.2: irq 17, io mem 0xfdff8000
[   23.940722] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[   23.940759] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002
[   23.940764] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.940769] usb usb7: Product: EHCI Host Controller
[   23.940772] usb usb7: Manufacturer: Linux 3.11.0-rc3-1.29-default ehci_hcd
[   23.940776] usb usb7: SerialNumber: 0000:00:16.2
[   23.941138] hub 7-0:1.0: USB hub found
[   23.941146] hub 7-0:1.0: 4 ports detected
[   23.941769] ohci-pci 0000:00:12.0: OHCI PCI host controller
[   23.941784] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 8
[   23.941815] ohci-pci 0000:00:12.0: irq 18, io mem 0xfdffe000
[   23.982017] firewire_core 0000:07:0e.0: created device fw0: GUID 00656f1cf0e5cb00, S400
[   24.002926] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[   24.002934] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.002939] usb usb8: Product: OHCI PCI host controller
[   24.002943] usb usb8: Manufacturer: Linux 3.11.0-rc3-1.29-default ohci_hcd
[   24.002946] usb usb8: SerialNumber: 0000:00:12.0
[   24.003163] hub 8-0:1.0: USB hub found
[   24.003174] hub 8-0:1.0: 5 ports detected
[   24.003710] ohci-pci 0000:00:13.0: OHCI PCI host controller
[   24.003721] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 9
[   24.003749] ohci-pci 0000:00:13.0: irq 18, io mem 0xfdffc000
[   24.067089] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001
[   24.067097] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.067102] usb usb9: Product: OHCI PCI host controller
[   24.067106] usb usb9: Manufacturer: Linux 3.11.0-rc3-1.29-default ohci_hcd
[   24.067110] usb usb9: SerialNumber: 0000:00:13.0
[   24.067328] hub 9-0:1.0: USB hub found
[   24.067339] hub 9-0:1.0: 5 ports detected
[   24.067877] ohci-pci 0000:00:14.5: OHCI PCI host controller
[   24.067890] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 10
[   24.067918] ohci-pci 0000:00:14.5: irq 18, io mem 0xfdffa000
[   24.131210] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001
[   24.131218] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.131223] usb usb10: Product: OHCI PCI host controller
[   24.131227] usb usb10: Manufacturer: Linux 3.11.0-rc3-1.29-default ohci_hcd
[   24.131231] usb usb10: SerialNumber: 0000:00:14.5
[   24.131500] hub 10-0:1.0: USB hub found
[   24.131513] hub 10-0:1.0: 2 ports detected
[   24.131990] ohci-pci 0000:00:16.0: OHCI PCI host controller
[   24.132001] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 11
[   24.132030] ohci-pci 0000:00:16.0: irq 18, io mem 0xfdff9000
[   24.194848] usb usb11: New USB device found, idVendor=1d6b, idProduct=0001
[   24.194855] usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.194861] usb usb11: Product: OHCI PCI host controller
[   24.194865] usb usb11: Manufacturer: Linux 3.11.0-rc3-1.29-default ohci_hcd
[   24.194869] usb usb11: SerialNumber: 0000:00:16.0
[   24.195089] hub 11-0:1.0: USB hub found
[   24.195099] hub 11-0:1.0: 4 ports detected
[   24.391668] md: bind<sdb1>
[   24.396711] md: bind<sdd1>
[   24.400667] md: bind<sdc1>
[   24.532215] md: raid1 personality registered for level 1
[   24.532660] md/raid1:md2: active with 2 out of 2 mirrors
[   24.532698] md2: detected capacity change from 0 to 2000396697600
[   24.535959] md: bind<sde1>
[   24.539176] md/raid1:md3: active with 2 out of 2 mirrors
[   24.539210] md3: detected capacity change from 0 to 1000202649600
[   24.546183]  md2: unknown partition table
[   24.554282]  md3: unknown partition table
[   24.680916] Adding 6244040k swap on /dev/sda6.  Priority:-1 extents:1 across:6244040k 
[   25.088812] usb 9-2: new full-speed USB device number 2 using ohci-pci
[   25.273099] usb 9-2: New USB device found, idVendor=1690, idProduct=0102
[   25.273106] usb 9-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   25.273112] usb 9-2: Product: V.90/K56flex USB MODEM COMM DEVICE CLASS
[   25.273116] usb 9-2: Manufacturer: ROCKWELL            
[   25.355308] cdc_acm 9-2:1.0: ttyACM0: USB ACM device
[   25.358370] usbcore: registered new interface driver cdc_acm
[   25.358375] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[   25.545826] usb 9-3: new full-speed USB device number 3 using ohci-pci
[   25.717820] usb 9-3: New USB device found, idVendor=051d, idProduct=0003
[   25.717827] usb 9-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   25.717832] usb 9-3: Product: Smart-UPS 750 FW:COM 02.1 / UPS.05.I
[   25.717837] usb 9-3: Manufacturer: American Power Conversion
[   25.717840] usb 9-3: SerialNumber: AS1114124214  
[   25.799186] hid-generic 0003:051D:0003.0001: hiddev0,hidraw0: USB HID v1.00 Device [American Power Conversion Smart-UPS 750 FW:COM 02.1 / UPS.05.I] on usb-0000:00:13.0-3/input0
[   25.799244] usbcore: registered new interface driver usbhid
[   25.799247] usbhid: USB HID core driver
[   25.856491] usb 8-4: new low-speed USB device number 2 using ohci-pci
[   26.030329] usb 8-4: New USB device found, idVendor=046a, idProduct=0011
[   26.030337] usb 8-4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   26.044827] input: HID 046a:0011 as /devices/pci0000:00/0000:00:12.0/usb8/8-4/8-4:1.0/input/input11
[   26.045012] hid-generic 0003:046A:0011.0002: input,hidraw1: USB HID v1.11 Keyboard [HID 046a:0011] on usb-0000:00:12.0-4/input0
[   76.312771] EXT4-fs (sda5): Mount option "nouser_xattr" will be removed by 3.5
[   76.312771] Contact linux-ext4-u79uwXL29TY76Z2rM5mHXA@public.gmane.org if you think we should keep it.
[   76.312771] 
[   76.338226] EXT4-fs (sda5): Mount option "noacl" will be removed by 3.5
[   76.338226] Contact linux-ext4-u79uwXL29TY76Z2rM5mHXA@public.gmane.org if you think we should keep it.
[   76.338226] 
[   76.363647] EXT4-fs (sda5): mounting ext2 file system using the ext4 subsystem
[   76.367852] EXT4-fs (sda5): mounted filesystem without journal. Opts: nouser_xattr,noacl
[   76.405375] EXT4-fs (sda8): mounted filesystem with ordered data mode. Opts: (null)
[   76.420071] XFS (sda9): Mounting Filesystem
[   76.497285] XFS (sda9): Ending clean mount
[   76.513090] XFS (sda2): Mounting Filesystem
[   76.711694] XFS (sda2): Ending clean mount
[   76.732102] XFS (sda3): Mounting Filesystem
[   76.837846] XFS (sda3): Ending clean mount
[   76.838577] XFS (md2): Mounting Filesystem
[   76.983524] XFS (md2): Ending clean mount
[   76.984251] XFS (md3): Mounting Filesystem
[   77.145470] XFS (md3): Ending clean mount
[   77.185672] EXT4-fs (sdf1): Mount option "nouser_xattr" will be removed by 3.5
[   77.185672] Contact linux-ext4-u79uwXL29TY76Z2rM5mHXA@public.gmane.org if you think we should keep it.
[   77.185672] 
[   77.210653] EXT4-fs (sdf1): Mount option "noacl" will be removed by 3.5
[   77.210653] Contact linux-ext4-u79uwXL29TY76Z2rM5mHXA@public.gmane.org if you think we should keep it.
[   77.210653] 
[   77.238393] EXT4-fs (sdf1): mounted filesystem with ordered data mode. Opts: nouser_xattr,noacl
[   77.408076] RPC: Registered named UNIX socket transport module.
[   77.408081] RPC: Registered udp transport module.
[   77.408084] RPC: Registered tcp transport module.
[   77.408087] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   77.524243] FS-Cache: Loaded
[   77.601212] FS-Cache: Netfs 'nfs' registered for caching
[   77.669066] NFS: Registering the id_resolver key type
[   77.676945] Key type id_resolver registered
[   77.684688] Key type id_legacy registered

--------------030600050206040005090108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030600050206040005090108--
