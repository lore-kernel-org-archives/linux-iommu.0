Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB122069A
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874189; cv=none; b=Xn+u3yOlN/lJ/DlDKkLz0ZHz61WTRW0KqE/HBZ7/4hJPAujWS/0Up872I5NyTqxKFKmCxN0Ibsxmz1cNxByy1JPyMaIGveQHsSthnkbyXXfeozz8a0xQwpGGhxTlvhi3WzVcdqg15BXjD7oKCMsfPggv0JzU+AxW+5oTfasAER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874189; c=relaxed/simple;
	bh=qqIUQ9QIcZhmGXl17HdzCq7eHSn5RW4buAwRdLV5Ez8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8yZQpA8leuHz5JVqjD8kCX6TtJi1WV3e4Dq0HKTUiGKXutfoyEb/TS6XmCblExCwuJEdma3/exvAonCZQeHZ81tN9RDKzSOMY8GZNx8/AzRkrfbBMGIk/cCKn4Wa/TFAcWQi/YDjLpuD1l6eU3dDikbwaDDdRKaMN7oDyJhs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kuyi7xKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kuyi7xKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752874186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrWlbpRkRAWEEZSZUXR7gkDwQXPo2XGHR6bPglMnBt8=;
	b=Kuyi7xKbbl5YhhAZeYphI+Q4a2Dfg5xPORsRDnlAw1iZB+ih8S0XJPBy33z0c9nhLOcMPR
	L0hype1lSue67woGmGImlGjPrT7zJmE/+fIcbMras/8/r7CPFbDRl63rr2zL4d1DFBUPco
	0iKvUW9EdWJaHnk/aLuWTFmpsZ7oR24=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-PSk2UkspPQiqd0lPMHkpoA-1; Fri, 18 Jul 2025 17:29:39 -0400
X-MC-Unique: PSk2UkspPQiqd0lPMHkpoA-1
X-Mimecast-MFC-AGG-ID: PSk2UkspPQiqd0lPMHkpoA_1752874178
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e0564038f5so4192555ab.1
        for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 14:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752874178; x=1753478978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrWlbpRkRAWEEZSZUXR7gkDwQXPo2XGHR6bPglMnBt8=;
        b=lDCvIoCP1KPVz8liQrmHXtJFP/nkkmmzVESp3/rKILUUuvBz4doMMA9tT+IauuNS9i
         gv28UK2WRbvV82Fyz7yfdLcwNs/8wx90n0eXS/YQ2yVcJLvoWuCm8mED49ErQCyRqzDy
         YSEjTSPZ2PybTK7GlQNi3jbxyUmoQbdbIWIPZxpObE5ONmBKRW8o34u0uQciNPGiooZF
         gDuyTKC7hJRx8OQNmnc3/dCHlU20W5CPGRhVCm2DsZ05q4H7RuE6xg1Iw13majTY7WgG
         y4moMKkSAn9Dwc621+lCAfmnfkJhZYcvjLiKbHYiJOtlyJcMTD28i4fSA1pnp2H7J2gd
         afHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtkg/ozDhLyBGZTOGGFcuKAuHm/2Jj0xJQPc+nppb8TgWoquQjLbKB0lF+ugk9XQVc6bOQEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/W4lx4NkWc5noONpjEb8qM/GqrwYdg53gb8z/KnyQQo60oe7n
	IBeC/2XsQNZnRNJt7oi/Ns/e3Sr1NETGnzRv6qKkJiD8e1qqe7TjmfL6ZxHlUCN7o6B2rkFFH1H
	VCDuqfNHhpAJo1V13c2wJOI0aVuIueJR1ZfIq/XvLcrlQlCbiAzQ3JPhW
X-Gm-Gg: ASbGnctFM2cF/5s3kTpwCxePlrpjk+HV5YZquxewCDchgrwHCnlmKXody0BuK2yiUt8
	niFtX6gPOsxhBlp4wEAQXVpasp+asnXeEBpa77XaPl7zzDpnbJdlbaFC+dhGAEkaPB4nj4gmoYb
	HB3E4gc2oY3FgdlW19dAhuSXyYPFR2s2ciwIBUTCytxFFU3IMf6qsy2OgQ/GPXIpKDCwbgpOHsx
	I5+xs21f9xNF4aya+qMIvsZKGJQOjwiXBn8doQHqqUvLkOrteOhk63q4KwuOlgEVfuJ1uZVk67F
	aHN5mbzekH28r2IFzXzle8hQ8D6DVLvJ99w3YcEmT+o=
X-Received: by 2002:a05:6e02:3e03:b0:3dd:c927:3b4f with SMTP id e9e14a558f8ab-3e2822ea512mr31320065ab.2.1752874178314;
        Fri, 18 Jul 2025 14:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsXml8xvO+E+R9hAay3c6AEsvzRM4HktRe693pIg5RRbn8ITcNmOIWJ6JbB3lZ/WFgJul1Sw==
X-Received: by 2002:a05:6e02:3e03:b0:3dd:c927:3b4f with SMTP id e9e14a558f8ab-3e2822ea512mr31319925ab.2.1752874177726;
        Fri, 18 Jul 2025 14:29:37 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca6314csm512735173.125.2025.07.18.14.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:29:36 -0700 (PDT)
Date: Fri, 18 Jul 2025 15:29:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, linux-pci@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, galshalom@nvidia.com, Joerg Roedel
 <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 maorg@nvidia.com, patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu
 <tony.zhu@intel.com>
Subject: Re: [PATCH v2 00/16] Fix incorrect iommu_groups with PCIe ACS
Message-ID: <20250718152934.0cdb768f.alex.williamson@redhat.com>
In-Reply-To: <0-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
References: <0-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YCXgkpEXNB4NUQGl4U1p3_P4qsApdzgwGSyp7XKntXo_1752874178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 11:52:03 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> The series patches have extensive descriptions as to the problem and
> solution, but in short the ACS flags are not analyzed according to the
> spec to form the iommu_groups that VFIO is expecting for security.
> 
> ACS is an egress control only. For a path the ACS flags on each hop only
> effect what other devices the TLP is allowed to reach. It does not prevent
> other devices from reaching into this path.
> 
> For VFIO if device A is permitted to access device B's MMIO then A and B
> must be grouped together. This says that even if a path has isolating ACS
> flags on each hop, off-path devices with non-isolating ACS can still reach
> into that path and must be grouped gother.
> 
> For switches, a PCIe topology like:
> 
>                                -- DSP 02:00.0 -> End Point A
>  Root 00:00.0 -> USP 01:00.0 --|
>                                -- DSP 02:03.0 -> End Point B
> 
> Will generate unique single device groups for every device even if ACS is
> not enabled on the two DSP ports. It should at least group A/B together
> because no ACS means A can reach the MMIO of B. This is a serious failure
> for the VFIO security model.
> 
> For multi-function-devices, a PCIe topology like:
> 
>                   -- MFD 00:1f.0 ACS != REQ_ACS_FLAGS
>   Root 00:00.00 --|- MFD 00:1f.2 ACS != REQ_ACS_FLAGS
>                   |- MFD 00:1f.6 ACS = REQ_ACS_FLAGS
> 
> Will group [1f.0, 1f.2] and 1f.6 gets a single device group. In many cases
> we suspect that the MFD actually doesn't need ACS, so this is probably not
> as important a security failure, but from a spec perspective the correct
> answer is one group of [1f.0, 1f.2, 1f.6] beacuse 1f.0/2 have no ACS
> preventing them from reaching the MMIO of 1f.6.

This will break various LOM configurations where the NIC is a function
within a MFD RCiEP which has or quirks ACS while the other functions
have no ACS.

> There is also some confusing spec language about how ACS and SRIOV works
> which this series does not address.
> 
> This entire series goes further and makes some additional improvements to
> the ACS validation found while studying this problem. The groups around a
> PCIe to PCI bridge are shrunk to not include the PCIe bridge.
> 
> The last patches implement "ACS Enhanced" on top of it. Due to how ACS
> Enhanced was defined as a non-backward compatible feature it is important
> to get SW support out there.
> 
> Due to the potential of iommu_groups becoming winder and thus non-usable
> for VFIO this should go to a linux-next tree to give it some more
> exposure.
> 
> I have now tested this a few systems I could get:
> 
>  - Various Intel client systems:
>    * Raptor Lake, with VMD enabled and using the real_dev mechanism
>    * 6/7th generation 100 Series/C320
>    * 5/6th generation 100 Series/C320 with a NIC MFD quirk
>    * Tiger Lake
>    * 5/6th generation Sunrise Point
>   No change in grouping on any of these systems

Sorry I haven't had much time to look at this, but it would still cause
a regression on my AlderLake system.  I get the following new
mega-group:

IOMMU Group 12:
	0000:00:1c.0 PCI bridge [0604]: Intel Corporation Raptor Lake PCI Express Root Port #1 [8086:7a38] (rev 11)
		Express Root Port (Slot+)
	0000:00:1c.1 PCI bridge [0604]: Intel Corporation Device [8086:7a39] (rev 11)
		Express Root Port (Slot+)
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	0000:00:1c.2 PCI bridge [0604]: Intel Corporation Raptor Point-S PCH - PCI Express Root Port 3 [8086:7a3a] (rev 11)
		Express Root Port (Slot+)
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	0000:00:1c.3 PCI bridge [0604]: Intel Corporation Raptor Lake PCI Express Root Port #4 [8086:7a3b] (rev 11)
		Express Root Port (Slot+)
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	0000:00:1c.1/06:00.0 USB controller [0c03]: Fresco Logic FL1100 USB 3.0 Host Controller [1b73:1100] (rev 10)
		Express Endpoint
	0000:00:1c.2/07:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller [10ec:8125] (rev 05)
		Express Endpoint
	0000:00:1c.3/08:00.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EL/SL PCIe2 4-Port/4-Lane Packet Switch [12d8:2404] (rev 05)
		Express Upstream Port
	0000:00:1c.3/08:00.0/09:01.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EL/SL PCIe2 4-Port/4-Lane Packet Switch [12d8:2404] (rev 05)
		Express Downstream Port (Slot-)
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	0000:00:1c.3/08:00.0/09:02.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EL/SL PCIe2 4-Port/4-Lane Packet Switch [12d8:2404] (rev 05)
		Express Downstream Port (Slot+)
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	0000:00:1c.3/08:00.0/09:03.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EL/SL PCIe2 4-Port/4-Lane Packet Switch [12d8:2404] (rev 05)
		Express Downstream Port (Slot-)
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	0000:00:1c.3/08:00.0/09:01.0/0a:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 07)
		Express Endpoint
	0000:00:1c.3/08:00.0/09:03.0/0c:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 07)
		Express Endpoint

The source of the issue is the root port at 00:1c.0, which does not
have ACS support, claims that it has a slot but there is none, and
therefore has no subordinate DMA capable devices, nor does the root
port itself have an MMIO BAR.  I don't know if there's something we can
key on for the root port to mark it isolated.

00:1c.0 PCI bridge [0604]: Intel Corporation Raptor Lake PCI Express Root Port #1 [8086:7a38] (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 125
	IOMMU group: 12
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 6000-6fff [size=4K] [16-bit]
	Memory behind bridge: 40800000-411fffff [size=10M] [32-bit]
	Prefetchable memory behind bridge: 60e0000000-60e09fffff [size=10M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, LnkDisable- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
		LnkSta:	Speed 2.5GT/s, Width x0
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 0W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 2
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer+ 2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002b8  Data: 0000
	Capabilities: [90] Null
	Kernel driver in use: pcieport

This is seen on a Gigabyte B760M DS3H DDR4 motherboard.  There's a
version of this board with wifi whereas this one has empty pads where
that m.2 slot might go.  I'd guess wifi might sit downstream of this
port if it were present, but I don't know how it'd change the feature
set of the root port.  The populated root ports show a more reasonable
set of capabilities:

00:1c.1 PCI bridge [0604]: Intel Corporation Device [8086:7a39] (rev 11) (prog-if 00 [Normal decode])
	Subsystem: Gigabyte Technology Co., Ltd Device [1458:5001]
	Flags: bus master, fast devsel, latency 0, IRQ 126, IOMMU group 12
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: [disabled] [16-bit]
	Memory behind bridge: 41800000-419fffff [size=2M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Capabilities: [40] Express Root Port (Slot+), IntMsgNum 0
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [98] Subsystem: Gigabyte Technology Co., Ltd Device [1458:5001]
	Capabilities: [a0] Power Management version 3
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [220] Access Control Services
	Capabilities: [200] L1 PM Substates
	Capabilities: [150] Precision Time Measurement
	Capabilities: [a30] Secondary PCI Express
	Capabilities: [a90] Data Link Feature <?>
	Kernel driver in use: pcieport

I can't say that the proposed code here is doing the wrong thing by
propagating the lack of isolation, but it's gratuitous when there is no
DMA initiator on the non-isolated branch and it causes a significant
usage problem for vfio.  Thanks,

Alex

