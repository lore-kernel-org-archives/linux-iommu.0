Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C6C433B4
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:34:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F2161355
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F2161355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA09B40599;
	Thu,  1 Apr 2021 15:34:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QcxDmDpidPYg; Thu,  1 Apr 2021 15:34:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9459B4058C;
	Thu,  1 Apr 2021 15:34:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61D05C000B;
	Thu,  1 Apr 2021 15:34:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C714CC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2C58848B6
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vrs0-iBL5wJA for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 15:33:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95DD5848B5
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:33:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83ECD161B;
 Thu,  1 Apr 2021 08:33:58 -0700 (PDT)
Received: from [10.57.24.208] (unknown [10.57.24.208])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8995E3F719;
 Thu,  1 Apr 2021 08:33:57 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] Optimization for unmapping iommu mapped buffers
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
References: <20210331030042.13348-1-isaacm@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f4931afb-7530-ff96-44e0-25e3e86de336@arm.com>
Date: Thu, 1 Apr 2021 16:33:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331030042.13348-1-isaacm@codeaurora.org>
Content-Language: en-GB
Cc: pratikp@codeaurora.org, will@kernel.org
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

On 2021-03-31 04:00, Isaac J. Manjarres wrote:
> When unmapping a buffer from an IOMMU domain, the IOMMU framework unmaps
> the buffer at a granule of the largest page size that is supported by
> the IOMMU hardware and fits within the buffer. For every block that
> is unmapped, the IOMMU framework will call into the IOMMU driver, and
> then the io-pgtable framework to walk the page tables to find the entry
> that corresponds to the IOVA, and then unmaps the entry.
> 
> This can be suboptimal in scenarios where a buffer or a piece of a
> buffer can be split into several contiguous page blocks of the same size.
> For example, consider an IOMMU that supports 4 KB page blocks, 2 MB page
> blocks, and 1 GB page blocks, and a buffer that is 4 MB in size is being
> unmapped at IOVA 0. The current call-flow will result in 4 indirect calls,
> and 2 page table walks, to unmap 2 entries that are next to each other in
> the page-tables, when both entries could have been unmapped in one shot
> by clearing both page table entries in the same call.

s/unmap/map/ and s/clear/set/ and those two paragraphs are still just as 
valid. I'd say If it's worth doing anything at all then it's worth doing 
more than just half the job ;)

> These patches implement a callback called unmap_pages to the io-pgtable
> code and IOMMU drivers which unmaps an IOVA range that consists of a
> number of pages of the same page size that is supported by the IOMMU
> hardware, and allows for clearing multiple entries in the same set of
> indirect calls. The reason for introducing unmap_pages is to give
> other IOMMU drivers/io-pgtable formats time to change to using the new
> unmap_pages callback, so that the transition to using this approach can be
> done piecemeal.
> 
> The same optimization is applicable for mapping buffers, however, the
> error handling in the io-pgtable layer couldn't be handled cleanly, as we
> would need to invoke iommu_unmap to unmap the parts of the buffer that
> were mapped, and then do any TLB maintenance. However, that seemed like a
> layering violation.

Why couldn't it just return the partial mapping and let the caller roll 
it back?

Note that having a weird asymmetric interface was how things started out 
way back when - see bd13969b9524 ("iommu: Split iommu_unmaps") for context.

> Any feedback is very much appreciated.

Do you have any real-world performance figures? I proposed this as an 
approach because it was clear it could give *some* benefit for 
relatively low impact, but I'm curious to find out exactly how much, and 
in particular whether it appears to leave anything on the table vs. 
punting the entire operation down into the drivers.

Robin.

> Thanks,
> Isaac
> 
> Isaac J. Manjarres (5):
>    iommu/io-pgtable: Introduce unmap_pages() as a page table op
>    iommu: Add an unmap_pages() op for IOMMU drivers
>    iommu: Add support for the unmap_pages IOMMU callback
>    iommu/io-pgtable-arm: Implement arm_lpae_unmap_pages()
>    iommu/arm-smmu: Implement the unmap_pages IOMMU driver callback
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu.c |  19 +++++
>   drivers/iommu/io-pgtable-arm.c        | 114 +++++++++++++++++++++-----
>   drivers/iommu/iommu.c                 |  44 ++++++++--
>   include/linux/io-pgtable.h            |   4 +
>   include/linux/iommu.h                 |   4 +
>   5 files changed, 159 insertions(+), 26 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
