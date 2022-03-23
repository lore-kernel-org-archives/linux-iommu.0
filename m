Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D51C433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 12:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E85240354;
	Wed, 23 Mar 2022 12:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XPWKu5bxaFq6; Wed, 23 Mar 2022 12:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CB78F40AB8;
	Wed, 23 Mar 2022 12:19:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3612AC000B;
	Wed, 23 Mar 2022 12:19:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B48EBC000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 07:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A37F80D8A
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 07:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d5v855ApTUiU for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 07:28:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A6DC80C33
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 07:28:30 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5C8386164F;
 Wed, 23 Mar 2022 07:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3822C340E8;
 Wed, 23 Mar 2022 07:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648020508;
 bh=hKNgS86ZsDxy6XOWOVYZ4mXSoI2JeEPeXjYKqdb3U/g=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=mvilRrJh2Xh3sYVP75oDnkZonVy/ryJJtSI8z90QiLrFVbjYSWkaVUVlTbWcpgcL9
 WGNyFDQXKH7lwjYnbAPc/O2uuRo8YZurdS9AHiVPpbHmSDXAgBkr9FtO2panArUiks
 8U5oNTgQgK4Sgl+oFFaaU+Qxikoap7zp60ceW1t9xvFEw+EV2flAYrl/Wel2pELyfl
 Kx4W/EyS3zjqeAITrFoQlZPInv2XvFbIbVoFRptXDrcOpQnS00jrxPA6Axoa154b6O
 lmjVViEC13FzBd8r5PLlGmbE52GD7f+BUxEyqR/dDPYk2KhKLZqw2Aw4QA8th2p3M9
 pDt0RUc4D24BA==
From: Kalle Valo <kvalo@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
References: <1812355.tdWV9SEqCh@natalenko.name>
Date: Wed, 23 Mar 2022 09:28:20 +0200
In-Reply-To: <1812355.tdWV9SEqCh@natalenko.name> (Oleksandr Natalenko's
 message of "Wed, 23 Mar 2022 08:19:24 +0100")
Message-ID: <874k3pm8kr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 23 Mar 2022 12:19:03 +0000
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Halil Pasic <pasic@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Olha Cherevyk <olha.cherevyk@gmail.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Adding regressions list so that this can be tracked properly, including
the full report below.

Oleksandr Natalenko <oleksandr@natalenko.name> writes:

> Hello.
>
> The following upstream commits:
>
> aa6f8dcbab47 swiotlb: rework "fix info leak with DMA_FROM_DEVICE"
> ddbd89deb7d3 swiotlb: fix info leak with DMA_FROM_DEVICE
>
> break ath9k-based Wi-Fi access point for me. The AP emits beacons, but no client can connect to it, either from the very beginning, or shortly after start. These are the only symptoms I've noticed (i.e., no BUG/WARNING messages in `dmesg` etc).
>
> The hardware is:
>
> ```
> $ dmesg | grep -i swiotlb
> [    0.426785] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>
> BIOS Information
>     Vendor: American Megatrends Inc.
>     Version: P1.50
>     Release Date: 04/16/2018
>
> Base Board Information
>     Manufacturer: ASRock
>     Product Name: J3710-ITX
>
> 02:00.0 Network controller: Qualcomm Atheros AR9462 Wireless Network Adapter (rev 01)
> 	Subsystem: Lite-On Communications Inc Device 6621
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 17
> 	Region 0: Memory at 81400000 (64-bit, non-prefetchable) [size=512K]
> 	Expansion ROM at 81480000 [disabled] [size=64K]
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
> 		Address: 0000000000000000  Data: 0000
> 		Masking: 00000000  Pending: 00000000
> 	Capabilities: [70] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W
> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
> 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
> 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP- LTR-
> 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
> 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> 			 FRS- TPHComp- ExtTPHComp-
> 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
> 			 AtomicOpsCtl: ReqEn-
> 		LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 2Retimers- DRS-
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
> 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> 			 Retimer- 2Retimers- CrosslinkRes: unsupported
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
> 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> 		HeaderLog: 00000000 00000000 00000000 00000000
> 	Capabilities: [140 v1] Virtual Channel
> 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=Fixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> 			Status:	NegoPending- InProgress-
> 	Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
> 	Kernel driver in use: ath9k
> 	Kernel modules: ath9k
> ```
>
> These commits appeared in v5.17 and v5.16.15, and both kernels are broken for me. I'm pretty confident these commits make the difference since I've built both v5.17 and v5.16.15 without them, and it fixed the issue.
>
> The machine has also got another Wi-Fi card that acts as a 802.11ax AP, and it is not affected:
>
> ```
> 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax PCI Express Wireless Network Adapter (prog-if 80)
> ```
>
> So, I do understand this might be an issue with regard to SG I/O handling in ath9k, hence relevant people in Cc.
>
> Please suggest on how to deal with this. Both me and Olha (in Cc) will be glad to test patches if needed. In case any extra info is required, please also let me know.
>
> Thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
