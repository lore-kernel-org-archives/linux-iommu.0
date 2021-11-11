Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802C5C433EF
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 09:53:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2C361207
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 09:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B2C361207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D905160B1C;
	Thu, 11 Nov 2021 09:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrpoH2AyI3wN; Thu, 11 Nov 2021 09:53:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B7E1B60B20;
	Thu, 11 Nov 2021 09:53:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E19AC0035;
	Thu, 11 Nov 2021 09:53:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71321C001E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 09:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4948840459
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 09:53:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mlp5QXq0ZYQd for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 09:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14F004015F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 09:53:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="232826937"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; d="scan'208";a="232826937"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 01:53:02 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; d="scan'208";a="733137980"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314)
 ([10.237.222.51])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 01:53:00 -0800
Date: Thu, 11 Nov 2021 09:52:53 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] iommu/vt-d: Fix unmap_pages support
Message-ID: <YYzn9bJzJ1lyRG1k@silpixa00400314>
References: <163659074748.1617923.12716161410774184024.stgit@omen>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <163659074748.1617923.12716161410774184024.stgit@omen>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org
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

I was able to hit the issue that this patch is fixing using the memory
allocator in QATlib (https://github.com/intel/qatlib/) which uses vfio
to map and unmap memory.

This patch fixes the problem.

On Wed, Nov 10, 2021 at 05:32:50PM -0700, Alex Williamson wrote:
> When supporting only the .map and .unmap callbacks of iommu_ops,
> the IOMMU driver can make assumptions about the size and alignment
> used for mappings based on the driver provided pgsize_bitmap.  VT-d
> previously used essentially PAGE_MASK for this bitmap as any power
> of two mapping was acceptably filled by native page sizes.
> 
> However, with the .map_pages and .unmap_pages interface we're now
> getting page-size and count arguments.  If we simply combine these
> as (page-size * count) and make use of the previous map/unmap
> functions internally, any size and alignment assumptions are very
> different.
> 
> As an example, a given vfio device assignment VM will often create
> a 4MB mapping at IOVA pfn [0x3fe00 - 0x401ff].  On a system that
> does not support IOMMU super pages, the unmap_pages interface will
> ask to unmap 1024 4KB pages at the base IOVA.  dma_pte_clear_level()
> will recurse down to level 2 of the page table where the first half
> of the pfn range exactly matches the entire pte level.  We clear the
> pte, increment the pfn by the level size, but (oops) the next pte is
> on a new page, so we exit the loop an pop back up a level.  When we
> then update the pfn based on that higher level, we seem to assume
> that the previous pfn value was at the start of the level.  In this
> case the level size is 256K pfns, which we add to the base pfn and
> get a results of 0x7fe00, which is clearly greater than 0x401ff,
> so we're done.  Meanwhile we never cleared the ptes for the remainder
> of the range.  When the VM remaps this range, we're overwriting valid
> ptes and the VT-d driver complains loudly, as reported by the user
> report linked below.
> 
> The fix for this seems relatively simple, if each iteration of the
> loop in dma_pte_clear_level() is assumed to clear to the end of the
> level pte page, then our next pfn should be calculated from level_pfn
> rather than our working pfn.
> 
> Fixes: 3f34f1259776 ("iommu/vt-d: Implement map/unmap_pages() iommu_ops callback")
> Reported-by: Ajay Garg <ajaygargnsit@gmail.com>
> Link: https://lore.kernel.org/all/20211002124012.18186-1-ajaygargnsit@gmail.com/
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
