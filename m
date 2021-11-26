Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDC0C433EF
	for <iommu@archiver.kernel.org>; Fri, 26 Nov 2021 12:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4AE824014A;
	Fri, 26 Nov 2021 12:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UPZq5_ARc54U; Fri, 26 Nov 2021 12:47:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E163340102;
	Fri, 26 Nov 2021 12:47:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B06FCC001E;
	Fri, 26 Nov 2021 12:47:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 331D1C0012
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 12:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13699826D5
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 12:47:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NpXWpQ89_DXd for <iommu@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 12:47:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 352898267F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 12:47:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="299062970"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; d="scan'208";a="299062970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2021 04:47:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; d="scan'208";a="510631193"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.4])
 ([10.254.210.4])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2021 04:47:08 -0800
Message-ID: <79b1fe69-9672-6cb7-88b1-f4eaffa7add9@linux.intel.com>
Date: Fri, 26 Nov 2021 20:47:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] iommu/vt-d: Fix unmap_pages support
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20211122032458.2549761-1-baolu.lu@linux.intel.com>
 <20211122032458.2549761-3-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20211122032458.2549761-3-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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

On 2021/11/22 11:24, Lu Baolu wrote:
> From: Alex Williamson<alex.williamson@redhat.com>
> 
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
> Reported-by: Ajay Garg<ajaygargnsit@gmail.com>
> Signed-off-by: Alex Williamson<alex.williamson@redhat.com>
> Tested-by: Giovanni Cabiddu<giovanni.cabiddu@intel.com>
> Link:https://lore.kernel.org/all/20211002124012.18186-1-ajaygargnsit@gmail.com/
> Link:https://lore.kernel.org/r/163659074748.1617923.12716161410774184024.stgit@omen
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

0-day build robot reported an error on this patch.

"drivers/iommu/intel/iommu.c:1344:7: warning: variable 'level_pfn' is 
used uninitialized whenever 'if' condition is true 
[-Wsometimes-uninitialized]
"

I will send a v2 of this patch. Sorry for the inconvenience.

Best regards
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
