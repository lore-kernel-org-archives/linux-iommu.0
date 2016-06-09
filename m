From: Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [E1000-devel] AMD-Vi: Event logged IO_PAGE_FAULT - ixgbe Detected
	Tx Unit Hang - Reset adapter - master disable timed out
Date: Thu, 9 Jun 2016 09:03:40 -0700
Message-ID: <CAKgT0UeFM1jYTU83YFohxUHWuJeTYfWDpdFM2CDQCutmf_vXvA@mail.gmail.com>
References: <loom.20160606T232112-817@post.gmane.org>
	<CAKgT0UfEGS_QzM1phGKRV1hDgcnAwX-BqMkyQ6KJUOv82_kCiA@mail.gmail.com>
	<nj64hf$9v5$1@ger.gmane.org>
	<CAKgT0UfKUkrsXqLm4KdjXgLZ6QXZp5Rf-yYA3pBSzc1=ghJ4CQ@mail.gmail.com>
	<njbvjb$40r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <njbvjb$40r$1@ger.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lutz Vieweg <lvml-i6VILw57VWU@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org
Cc: "e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 9, 2016 at 7:48 AM, Lutz Vieweg <lvml-i6VILw57VWU@public.gmane.org> wrote:
> Bad news: It happened again today:
>> Jun  9 14:40:09 computer kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=04:00.0 domain=0x000e address=0x00000000000178c0 flags=0x0050]
>> Jun  9 14:40:09 computer kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=04:00.0 domain=0x000e address=0x0000000000017900 flags=0x0050]
>> Jun  9 14:40:13 computer kernel: ixgbe 0000:04:00.0 enp4s0: Detected Tx Unit Hang#012  Tx Queue             <2>#012  TDH, TDT             <186>, <194>#012  next_to_use          <194>#012  next_to_clean        <186>#012tx_buffer_info[next_to_clean]#012  time_stamp           <11df79bf7>#012  jiffies              <11df7aac8>
>> Jun  9 14:40:13 computer kernel: ixgbe 0000:04:00.0 enp4s0: Detected Tx Unit Hang#012  Tx Queue             <3>#012  TDH, TDT             <1e4>, <2>#012  next_to_use          <2>#012  next_to_clean        <1e4>#012tx_buffer_info[next_to_clean]#012  time_stamp           <11df79a0f>#012  jiffies              <11df7aac8>
>> Jun  9 14:40:13 computer kernel: ixgbe 0000:04:00.0 enp4s0: tx hang 1 detected on queue 3, resetting adapter
>> Jun  9 14:40:13 computer kernel: ixgbe 0000:04:00.0 enp4s0: Detected Tx Unit Hang#012  Tx Queue             <24>#012  TDH, TDT             <1ec>, <2>#012  next_to_use          <2>#012  next_to_clean        <1ec>#012tx_buffer_info[next_to_clean]#012  time_stamp           <11df79a0f>#012  jiffies              <11df7aac8>
>> Jun  9 14:40:13 computer kernel: ixgbe 0000:04:00.0 enp4s0: initiating reset due to tx timeout
>> Jun  9 14:40:13 computer kernel: ixgbe 0000:04:00.0 enp4s0: tx hang 1 detected on queue 24, resetting adapter
>> Jun  9 14:40:13 computer kernel: ixgbe 0000:04:00.0 enp4s0: initiating reset due to tx timeout
>> Jun  9 14:40:13 computer kernel: ixgbe 0000:04:00.0 enp4s0: Reset adapter
>> Jun  9 14:40:13 computer kernel: ixgbe 0000:04:00.0 enp4s0: tx hang 2 detected on queue 2, resetting adapter
>> Jun  9 14:40:14 computer kernel: ixgbe 0000:04:00.0: master disable timed out
>   ...
>
> And today, no other NIC connected to the same switch saw any "glitch".
>
> I got you an "lspci -vvv" output, however, some interesting
>> "pcilib: sysfs_read_vpd: read failed: Input/output error"
> message is reported while lspci is emitting data on the NIC:
>
>> 04:00.0 Ethernet controller: Intel Corporation Ethernet Controller 10-Gigabit X540-AT2 (rev 01)
>>         Subsystem: Intel Corporation Ethernet Converged Network Adapter X540-T1
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort+ <MAbort- >SERR- <PERR- INTx-
>>         Latency: 0, Cache Line Size: 64 bytes
>>         Interrupt: pin A routed to IRQ 59
>>         Region 0: Memory at dce00000 (64-bit, prefetchable) [size=2M]
>>         Region 4: Memory at dcdfc000 (64-bit, prefetchable) [size=16K]
>>         Expansion ROM at dfd80000 [disabled] [size=512K]
>>         Capabilities: [40] Power Management version 3
>>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>>                 Address: 0000000000000000  Data: 0000
>>                 Masking: 00000000  Pending: 00000000
>>         Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
>>                 Vector table: BAR=4 offset=00000000
>>                 PBA: BAR=4 offset=00002000
>>         Capabilities: [a0] Express (v2) Endpoint, MSI 00
>>                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
>>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
>>                 LnkCap: Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <1us, L1 <8us
>>                         ClockPM- Surprise- LLActRep- BwNot-
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                 LnkSta: Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
>>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>>                          Compliance De-emphasis: -6dB
>>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
>>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>>         Capabilities: [100 v2] Advanced Error Reporting
>>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>                 AERCap: First Error Pointer: 00, Gpcilib: sysfs_read_vpd: read failed: Input/output error
>> enCap+ CGenEn- ChkCap+ ChkEn-
>>         Capabilities: [140 v1] Device Serial Number a0-36-9f-ff-ff-80-xx-xx
>>         Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
>>                 ARICap: MFVC- ACS-, Next Function: 0
>>                 ARICtl: MFVC- ACS-, Function Group: 0
>>         Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
>>                 IOVCap: Migration-, Interrupt Message Number: 000
>>                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+
>>                 IOVSta: Migration-
>>                 Initial VFs: 64, Total VFs: 64, Number of VFs: 0, Function Dependency Link: 00
>>                 VF offset: 128, stride: 2, Device ID: 1515
>>                 Supported Page Size: 00000553, System Page Size: 00000001
>>                 Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
>>                 Region 3: Memory at 0000000000000000 (64-bit, non-prefetchable)
>>                 VF Migration: offset: 00000000, BIR: 0
>>         Capabilities: [1d0 v1] Access Control Services
>>                 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
>>                 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
>>         Kernel driver in use: ixgbe
>
> This time I'll reboot the machine, and also try "iommu=pt" as suggested
> in different places for use with 10G NICs.

That might be a good place to start.

I'm adding, or at least attempting to, the mailing list and maintainer
for the IOMMU code.  You might want to check with the AMD-Vi IOMMU
maintainers to see if they have any other advice as this seems like
something that may have been introduced with changes to the IOMMU as
the ixgbe driver hasn't had any updates to the DMA mapping/unmapping
code in some time and it was working in the 4.4 kernel series and
still works on my system which runs an Intel IOMMU so I am wondering
if this may be something specifically related to changes in the AMD
IOMMU code.

- Alex
