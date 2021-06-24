Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F37C49EA5
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 10:47:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255EF61406
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 10:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255EF61406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB6B9401A4;
	Thu, 24 Jun 2021 10:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pv1vi7Eh1WMO; Thu, 24 Jun 2021 10:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B5CCD4011B;
	Thu, 24 Jun 2021 10:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E45DC0010;
	Thu, 24 Jun 2021 10:47:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A006C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 10:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3ADB5414B8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 10:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dLic4knbXcbP for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 10:47:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31008414B5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 10:47:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A05231B;
 Thu, 24 Jun 2021 03:47:38 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E5F73F718;
 Thu, 24 Jun 2021 03:47:36 -0700 (PDT)
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
To: Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@infradead.org>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org> <20210624092930.GA802261@MiWiFi-R3L-srv>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
Date: Thu, 24 Jun 2021 11:47:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210624092930.GA802261@MiWiFi-R3L-srv>
Content-Language: en-GB
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, rientjes@google.com
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

On 2021-06-24 10:29, Baoquan He wrote:
> On 06/24/21 at 08:40am, Christoph Hellwig wrote:
>> So reduce the amount allocated.  But the pool is needed for proper
>> operation on systems with memory encryption.  And please add the right
>> maintainer or at least mailing list for the code you're touching next
>> time.
> 
> Oh, I thoutht it's memory issue only, should have run
> ./scripts/get_maintainer.pl. sorry.
> 
> About reducing the amount allocated, it may not help. Because on x86_64,
> kdump kernel doesn't put any page of memory into buddy allocator of DMA
> zone. Means it will defenitely OOM for atomic_pool_dma initialization.
> 
> Wondering in which case or on which device the atomic pool is needed on
> AMD system with mem encrytion enabled. As we can see, the OOM will
> happen too in kdump kernel on Intel system, even though it's not
> necessary.

Hmm, I think the Kconfig reshuffle has actually left a slight wrinkle 
here. For DMA_DIRECT_REMAP=y we can assume an atomic pool is always 
needed, since that was the original behaviour anyway. However the 
implications of AMD_MEM_ENCRYPT=y are different - even if support is 
enabled, it still should only be relevant if mem_encrypt_active(), so it 
probably does make sense to have an additional runtime gate on that.

 From a quick scan, use of dma_alloc_from_pool() already depends on 
force_dma_unencrypted() so that's probably fine already, but I think 
we'd need a bit of extra protection around dma_free_from_pool() to 
prevent gen_pool_has_addr() dereferencing NULL if the pools are 
uninitialised, even with your proposed patch as it is. Presumably 
nothing actually called dma_direct_free() when you tested this?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
