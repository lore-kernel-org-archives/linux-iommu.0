Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413A8C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 13:53:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88F321D92
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 13:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88F321D92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5959085455;
	Wed, 23 Sep 2020 13:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kwZoYi-NrhuP; Wed, 23 Sep 2020 13:53:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B638784DBD;
	Wed, 23 Sep 2020 13:53:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9618AC0889;
	Wed, 23 Sep 2020 13:53:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B32EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 13:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 06B2284DBD
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 13:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MExRzRq4LHCL for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 13:53:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id E3D9884CE1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 13:53:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00AC811D4;
 Wed, 23 Sep 2020 06:53:28 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7964E3F73B;
 Wed, 23 Sep 2020 06:53:27 -0700 (PDT)
Subject: Re: dma_alloc_coherent not allocating memory from CMA Reserved
To: sathya.m@samsung.com,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <CGME20200923074314epcms5p8cfc65267615d27472df670f5806cb5a4@epcms5p8>
 <20200923074314epcms5p8cfc65267615d27472df670f5806cb5a4@epcms5p8>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3a6c71c4-0d39-9e5a-5af3-807a72e0eb4c@arm.com>
Date: Wed, 23 Sep 2020 14:53:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200923074314epcms5p8cfc65267615d27472df670f5806cb5a4@epcms5p8>
Content-Language: en-GB
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-09-23 08:43, Sathyavathi M wrote:
> Hi All,
> 
> I am trying to allocate coherent memory for 33 MB in kerenl driver. and for that
> i have reserved CMA of 1024 MB, but from dmesg, i can see that address reserved
> for cma is different and what i get with dma_alloc_coherent is different. My pc
> is intel x86 machine and tried in different motherboard, but this issue is
> occuring in some specific PCs. please help me in debugging the actual issue,
> below are kernel bootup logs
> 
> 
> [ 0.014362] No NUMA configuration found
> [ 0.014363] Faking a node at [mem 0x0000000000000000-0x000000021edfffff]
> [ 0.014374] NODE_DATA(0) allocated [mem 0x21edd5000-0x21edfffff]
> [ 0.014538] *cma: Reserved 400 MiB at 0x0000000205c00000*
> [ 0.014541] Reserving 640MB of memory at 2512MB for crashkernel (System RAM: 8046MB)
> [ 0.014553] Zone ranges:
> [ 0.014554] DMA [mem 0x0000000000001000-0x0000000000ffffff]
> [ 0.014554] DMA32 [mem 0x0000000001000000-0x00000000ffffffff]
> [ 0.014555] Normal [mem 0x0000000100000000-0x000000021edfffff]
> 
> 
> *at dma_alloc_coherent call
> [ 27.816062] dev->dma_33M_addr is f8000000*

I'm confused - if you got a DMA address back, then the allocation must 
have succeeded, so what exactly is the issue there? If the allocator 
managed to find a suitable amount of memory that your device can 
address, does it really matter exactly where it came from?

Also bear in mind that a DMA address is not necessarily the same as a 
physical address anyway, if for instance you have an IOMMU or other 
forms of interconnect translation. In fact the default behaviour of the 
intel-iommu driver for a PCI device is to allocate DMA addresses in 
naturally-aligned regions downwards from 4GB - if the first request in 
an empty address space was for 33MB, it would get rounded up to 64MB, 
wouldn't fit at 4GB - 64MB (0xfc000000) because that would clash with 
the IOAPIC region, so would end up at 4GB - 128MB (0xf8000000). Now 
where have I seen that before?...

Robin.

> ---------------------------------------------------------------------------------------------------------------
> and below are the logs in working case, at driver dma_alloc_coherent api call we
> have address which is in range of what reserved for cma.
> at boot i get..
> Faking a node at [mem 0x0000000000000000-0x000000019fdfffff]
> NODE_DATA(0) allocated [mem 0x19fdd3000-0x19fdfdfff]
> *cma: Reserved 800 MiB at 0x000000016dc00000*
> Reserving 640MB of memory at 1792MB for crashkernel (System RAM: 6016MB)
> Zone ranges:
> DMA [mem 0x0000000000001000-0x0000000000ffffff]
> DMA32 [mem 0x0000000001000000-0x00000000ffffffff]
> Normal [mem 0x0000000100000000-0x000000019fdfffff]
> 
> *at dma_alloc_coherent call
> dev->dma_33M_addr is 16e200000*
> 
> Please help me in solving this iissue, or can suggest any alternative way to
> allocate big coherent memory.
> 
> Regards,
> 
> Sathya
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
