Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9506C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 12:29:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE802250F
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 12:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE802250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C0E88857D6;
	Wed, 20 Jan 2021 12:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T0DWlsQaWyGk; Wed, 20 Jan 2021 12:29:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D16685A4B;
	Wed, 20 Jan 2021 12:29:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72A32C08A1;
	Wed, 20 Jan 2021 12:29:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3177C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 12:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A40DC203E0
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 12:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m5e8qWX2zB04 for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 12:29:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 82023203B9
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 12:29:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9747D6E;
 Wed, 20 Jan 2021 04:29:47 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3030F3F66E;
 Wed, 20 Jan 2021 04:29:46 -0800 (PST)
Subject: Re: [RFC PATCH V2 2/2] iommu: add Unisoc iommu basic driver
To: Chunyan Zhang <zhang.lyra@gmail.com>
References: <20210108113851.354947-1-zhang.lyra@gmail.com>
 <20210108113851.354947-3-zhang.lyra@gmail.com>
 <47f73502-15fe-5d65-6fc9-22eb078d7797@arm.com>
 <CAAfSe-vd5eRopOBZMuTi8vq1FqY1qAVSdMHscVuA+uHtL2H=gw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3a2561fc-65a6-4c68-fdb7-a5b670706f43@arm.com>
Date: Wed, 20 Jan 2021 12:29:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAAfSe-vd5eRopOBZMuTi8vq1FqY1qAVSdMHscVuA+uHtL2H=gw@mail.gmail.com>
Content-Language: en-GB
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Kevin Tang <kevin.tang@unisoc.com>, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>
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

On 2021-01-20 11:40, Chunyan Zhang wrote:
[...]
>>> +     pgt_base_iova = dom->pgt_va +
>>> +             ((iova - mdata->iova_start) >> SPRD_IOMMU_PAGE_SHIFT);
>>> +
>>> +     spin_lock_irqsave(&dom->pgtlock, flags);
>>> +     for (i = 0; i < page_num; i++) {
>>> +             pgt_base_iova[i] = pabase >> SPRD_IOMMU_PAGE_SHIFT;
>>
>> Out of curiosity, is the pagetable walker cache-coherent, or is this
>> currently managing to work by pure chance and natural cache churn?
> 
> ->iotlb_sync_map() was implemented in this driver, I guess that has
> done what you say here?

No, sync_map only ensures that the previous (invalid) PTE isn't held in 
the IOMMU's TLB. If pgt_va is a regular page allocation then you're 
writing the new PTE to normal kernel memory, with nothing to guarantee 
that write goes any further than the CPU's L1 cache. Thus either the 
IOMMU has capable of snooping the CPU caches in order to see the updated 
PTE value (rather than refetching the stale value from DRAM), or you're 
just incredibly lucky that by the time the IOMMU *does* go to fetch the 
PTE for that address, that updated cache line has already been evicted 
out to DRAM naturally.

This is not an issue if you use the proper DMA allocator, since that 
will ensure you get a non-cacheable buffer if you need one.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
