Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C5C48BD1
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 03:11:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA5761359
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 03:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA5761359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DD1D606F5;
	Fri, 11 Jun 2021 03:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id baUEuBy3lDiu; Fri, 11 Jun 2021 03:11:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0B7DC606EE;
	Fri, 11 Jun 2021 03:11:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC0A8C000D;
	Fri, 11 Jun 2021 03:11:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7426CC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 03:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 567E983B5F
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 03:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yCPSL6O8evgy for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 03:11:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B1D683B5E
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 03:11:38 +0000 (UTC)
IronPort-SDR: QBKtr6ikPpdX9rv3223c7q06HtoNzZN4H+qqZHgfjyewBqHyN39kSDP11D2s6oh/oOAz8+DpQe
 6ShUB7vJ3Cow==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185825668"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; d="scan'208";a="185825668"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2021 20:11:36 -0700
IronPort-SDR: NrlyWs9r8kQf8R98k7/rsDSXLJggMO9rtZcVpA5z+deX5aK3ORb8MLRNBpl1nVCSEeR1jSa4Y6
 n5VKlMC1MxxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; d="scan'208";a="553280078"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2021 20:11:34 -0700
Subject: Re: [RFC PATCH v5 00/15] Optimizing iommu_[map/unmap] performance
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
References: <20210408171402.12607-1-isaacm@codeaurora.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <405c06b2-0f5e-0d9e-5a11-1523522f9d55@linux.intel.com>
Date: Fri, 11 Jun 2021 11:10:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210408171402.12607-1-isaacm@codeaurora.org>
Content-Language: en-US
Cc: robin.murphy@arm.com, will@kernel.org, pratikp@codeaurora.org
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

Hi Isaac,

Any update for this series? The iommu core part looks good to me and I
also have some patches for Intel IOMMU implementation of [un]map_pages.
Just wonder when could iommu core have this optimization.

Best regards,
baolu

On 4/9/21 1:13 AM, Isaac J. Manjarres wrote:
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
> 
> The same optimization is applicable to mapping buffers as well, so
> these patches implement a set of callbacks called unmap_pages and
> map_pages to the io-pgtable code and IOMMU drivers which unmaps or maps
> an IOVA range that consists of a number of pages of the same
> page size that is supported by the IOMMU hardware, and allows for
> manipulating multiple page table entries in the same set of indirect
> calls. The reason for introducing these callbacks is to give other IOMMU
> drivers/io-pgtable formats time to change to using the new callbacks, so
> that the transition to using this approach can be done piecemeal.
> 
> Changes since V4:
> 
> * Fixed type for addr_merge from phys_addr_t to unsigned long so
>    that GENMASK() can be used.
> * Hooked up arm_v7s_[unmap/map]_pages to the io-pgtable ops.
> * Introduced a macro for calculating the number of page table entries
>    for the ARM LPAE io-pgtable format.
> 
> Changes since V3:
> 
> * Removed usage of ULL variants of bitops from Will's patches, as
>    they were not needed.
> * Instead of unmapping/mapping pgcount pages, unmap_pages() and
>    map_pages() will at most unmap and map pgcount pages, allowing
>    for part of the pages in pgcount to be mapped and unmapped. This
>    was done to simplify the handling in the io-pgtable layer.
> * Extended the existing PTE manipulation methods in io-pgtable-arm
>    to handle multiple entries, per Robin's suggestion, eliminating
>    the need to add functions to clear multiple PTEs.
> * Implemented a naive form of [map/unmap]_pages() for ARM v7s io-pgtable
>    format.
> * arm_[v7s/lpae]_[map/unmap] will call
>    arm_[v7s/lpae]_[map_pages/unmap_pages] with an argument of 1 page.
> * The arm_smmu_[map/unmap] functions have been removed, since they
>    have been replaced by arm_smmu_[map/unmap]_pages.
> 
> Changes since V2:
> 
> * Added a check in __iommu_map() to check for the existence
>    of either the map or map_pages callback as per Lu's suggestion.
> 
> Changes since V1:
> 
> * Implemented the map_pages() callbacks
> * Integrated Will's patches into this series which
>    address several concerns about how iommu_pgsize() partitioned a
>    buffer (I made a minor change to the patch which changes
>    iommu_pgsize() to use bitmaps by using the ULL variants of
>    the bitops)
> 
> Isaac J. Manjarres (12):
>    iommu/io-pgtable: Introduce unmap_pages() as a page table op
>    iommu: Add an unmap_pages() op for IOMMU drivers
>    iommu/io-pgtable: Introduce map_pages() as a page table op
>    iommu: Add a map_pages() op for IOMMU drivers
>    iommu: Add support for the map_pages() callback
>    iommu/io-pgtable-arm: Prepare PTE methods for handling multiple
>      entries
>    iommu/io-pgtable-arm: Implement arm_lpae_unmap_pages()
>    iommu/io-pgtable-arm: Implement arm_lpae_map_pages()
>    iommu/io-pgtable-arm-v7s: Implement arm_v7s_unmap_pages()
>    iommu/io-pgtable-arm-v7s: Implement arm_v7s_map_pages()
>    iommu/arm-smmu: Implement the unmap_pages() IOMMU driver callback
>    iommu/arm-smmu: Implement the map_pages() IOMMU driver callback
> 
> Will Deacon (3):
>    iommu: Use bitmap to calculate page size in iommu_pgsize()
>    iommu: Split 'addr_merge' argument to iommu_pgsize() into separate
>      parts
>    iommu: Hook up '->unmap_pages' driver callback
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu.c |  18 +--
>   drivers/iommu/io-pgtable-arm-v7s.c    |  50 ++++++-
>   drivers/iommu/io-pgtable-arm.c        | 189 +++++++++++++++++---------
>   drivers/iommu/iommu.c                 | 130 +++++++++++++-----
>   include/linux/io-pgtable.h            |   8 ++
>   include/linux/iommu.h                 |   9 ++
>   6 files changed, 289 insertions(+), 115 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
