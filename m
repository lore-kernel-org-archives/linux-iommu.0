Return-Path: <SRS0=m57D=Z3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1C8C43603
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 02:53:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BE1206DB
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 02:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWEOu984"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BE1206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A8CB988057;
	Thu,  5 Dec 2019 02:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PVLrjhFmT90; Thu,  5 Dec 2019 02:53:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD41E87FF2;
	Thu,  5 Dec 2019 02:53:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2F02C1DD6;
	Thu,  5 Dec 2019 02:53:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD5A1C077D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 02:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 956F9886BB
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 02:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id veFdtofeONxN for <iommu@lists.linux-foundation.org>;
 Thu,  5 Dec 2019 02:53:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3523F8867D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 02:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575514408;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qu2CPsEVPYKzObNHq0AoY+H/6ZGFfsokMxeeCVsqqNM=;
 b=eWEOu984/8wc3312Q+7fhQpwkXAHTdwFPxMS7wbU/gZd+R9En8vqcXatm0cBhbyWtwBzb3
 32WMMC/D67lNX3OQJSEyOPuxNKCKI5+lqFBqhVqajriAxHWAGeM0zZLAUeWBakcfdG1JOB
 xiHmXklJJMzXqMgHvM9i8WfNM3rK+V8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-nBFv3z0IMOursztVTAuEsA-1; Wed, 04 Dec 2019 21:53:25 -0500
Received: by mail-ot1-f70.google.com with SMTP id g17so1092204otg.10
 for <iommu@lists.linux-foundation.org>; Wed, 04 Dec 2019 18:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=X/BLisvEbcJNvVJkaUzgqj6l1bMevf1AacS6xlBtllw=;
 b=Ni6zuMMtwreF66OmxnoVc77H46Y47ZKebq1CxftP5mQL6wvcISfGSqZtYRR/HSk9C9
 nYSSdHZukV6ESjP61Yofaf9uxaDiv2GipRVvh7NEwKJoFqTZKZRcrD/MLM+Vv5y9WbRa
 jqroV26jE5NOi7dJTlSVmHu3l+fXRBFjJNCyHnwaOrWR/WvGANJX5oqmqE6Yi9B/2/ID
 t5dhWZaxXwJkUfxJEo0y90B5cHDN3hkn14xWNrsg8EwmUbVKeiTgf/zbP5zrnE2A+pt3
 LAHuScQx6yxPyhnpHOpzVt4Jc0vHWDdpuxXwDNhz+HsdhK/A17y/PctgkUmxO9AfgA3w
 bQyQ==
X-Gm-Message-State: APjAAAXb5sDvnXZvSTRaNIFWvp+PwsnGYuBo1tIb0iFvL+tEIKZf+lfZ
 eWeSLiK0XS9o8d7hAdnO+PFwdhak2VQN85jFbGwcK6Bl3AqmWdqUIXCq8bK+LmoxUOaOaxETW8U
 lyz0gkvubYjeZu6ZRxbMYGxCGdDNs+Q==
X-Received: by 2002:aca:ed81:: with SMTP id l123mr5492629oih.129.1575514404941; 
 Wed, 04 Dec 2019 18:53:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9E7r68b+ELFbcHEm6zmzRVJII2m6uUNJu4OPPsAfxYYEX2S2fs1Lt+bYwvzhWKgn9WFk0eg==
X-Received: by 2002:aca:ed81:: with SMTP id l123mr5492619oih.129.1575514404554; 
 Wed, 04 Dec 2019 18:53:24 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id m2sm3033425oim.13.2019.12.04.18.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 18:53:23 -0800 (PST)
Date: Wed, 4 Dec 2019 19:53:20 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191205025320.oiulo3msfcggdlv5@cantor>
References: <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
 <20191202071406.jpq5qobbtnwhktlc@cantor>
 <20191202161332.ctc3y5cvdgqwnz7l@cantor>
 <14bbe41c-61e9-d2b6-31cb-67c0b1ad11da@linux.intel.com>
 <20191203095636.epmuinnrpykecfda@cantor>
 <5ce8d57e-25f0-5d28-7408-92c650ba54aa@linux.intel.com>
 <20191204205300.4jiexjqfpnqlcagu@cantor>
 <2d4e0c05-f0ee-d4b1-d2ed-24197811b097@linux.intel.com>
 <20191205022551.janpwjvr4kei5r7c@cantor>
 <d5981dee-d37b-a725-ed94-8864f3dd7602@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <d5981dee-d37b-a725-ed94-8864f3dd7602@linux.intel.com>
X-MC-Unique: nBFv3z0IMOursztVTAuEsA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu Dec 05 19, Lu Baolu wrote:
>Hi,
>
>On 12/5/19 10:25 AM, Jerry Snitselaar wrote:
>>>
>>>It seems that iommu pci bus probe didn't enumerate device [01:00.2] and
>>>[02:00.0], the corresponding context entries were not setup. Hence dma
>>>fault generated when devices access the memory.
>>>
>>>Do these two devices show in "lspci" output? How do these devices get
>>>enumerated by the system?
>>>
>>>Best regards,
>>>baolu
>>>
>>
>>They are there in the output, but it seems out of order:
>
>
>[   23.446201] pci 0000:01:00.0: Adding to iommu group 25
>[   23.448949] pci 0000:01:00.0: Using iommu dma mapping
>[   23.450807] pci 0000:01:00.1: Adding to iommu group 25
>[   23.452666] pci 0000:01:00.1: DMAR: Device uses a private identity 
>domain.
>[   23.455063] pci 0000:01:00.2: Adding to iommu group 25
>[   23.456881] pci 0000:01:00.4: Adding to iommu group 25
>[   23.458693] pci 0000:01:00.4: DMAR: Device uses a private identity 
>domain.
>
>Oh, yes!
>
>So device 01:00.0 01:00.1 01:00.2 01:00.4 share a single group. The
>default domain for this group has been set to DMA although iommu=pt has
>been set. As the result, .0 .2 use DMA, but .1, .4 use IDENTITY. This is
>not a valid configuration since all devices in a group should use a same
>domain.
>
>Do you mind posting the "lspci -vvv" output of these devices? I want to
>figure out why these devices request different domain type.
>
>Best regards,
>baolu
>

01:00.0 System peripheral: Hewlett-Packard Company Integrated Lights-Out Standard Slave Instrumentation & System Support (rev 05)
	Subsystem: Hewlett-Packard Company iLO4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	NUMA node: 0
	Region 0: I/O ports at 3000 [size=256]
	Region 1: Memory at f7bf0000 (32-bit, non-prefetchable) [size=512]
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
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <4us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: hpwdt
	Kernel modules: hpwdt

01:00.1 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200EH (prog-if 00 [VGA controller])
	Subsystem: Hewlett-Packard Company iLO4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 16
	NUMA node: 0
	Region 0: Memory at f5000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at f7be0000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at f7000000 (32-bit, non-prefetchable) [size=8M]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
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
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <4us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: mgag200
	Kernel modules: mgag200

01:00.2 System peripheral: Hewlett-Packard Company Integrated Lights-Out Standard Management Processor Support and Messaging (rev 05)
	Subsystem: Hewlett-Packard Company iLO4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 16
	NUMA node: 0
	Region 0: I/O ports at 3800 [size=256]
	Region 1: Memory at f6ff0000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at f6e00000 (32-bit, non-prefetchable) [size=1M]
	Region 3: Memory at f6d80000 (32-bit, non-prefetchable) [size=512K]
	Region 4: Memory at f6d70000 (32-bit, non-prefetchable) [size=32K]
	Region 5: Memory at f6d60000 (32-bit, non-prefetchable) [size=32K]
	[virtual] Expansion ROM at f6d00000 [disabled] [size=64K]
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
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <4us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
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
	NUMA node: 0
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
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <4us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [f0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: uhci_hcd

02:00.0 RAID bus controller: Hewlett-Packard Company Smart Array Gen8 Controllers (rev 01)
	Subsystem: Hewlett-Packard Company P420i
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 52
	NUMA node: 0
	Region 0: Memory at f7d00000 (64-bit, non-prefetchable) [size=1M]
	Region 2: Memory at f7cf0000 (64-bit, non-prefetchable) [size=1K]
	Region 4: I/O ports at 5000 [size=256]
	[virtual] Expansion ROM at f7c00000 [disabled] [size=512K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [b0] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM not supported
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via message
			 AtomicOpsCap: 32bit+ 64bit+ 128bitCAS+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
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
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] #19
	Kernel driver in use: hpsa
	Kernel modules: hpsa

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
