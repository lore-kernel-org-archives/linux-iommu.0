Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CC1C433F5
	for <iommu@archiver.kernel.org>; Wed, 13 Apr 2022 01:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E22856100A;
	Wed, 13 Apr 2022 01:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSKy4TYosbfv; Wed, 13 Apr 2022 01:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC01560E9B;
	Wed, 13 Apr 2022 01:02:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD6F0C0033;
	Wed, 13 Apr 2022 01:02:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1791AC002C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 01:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A26C40447
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 01:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DNabYWFn4jRt for <iommu@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 01:02:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 815DF4024B
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 01:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649811730; x=1681347730;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jCOzTEFGDySWdZhcnJIZg2QMTm3MGx0Arwq3UD8MWIw=;
 b=CworA0DHvy2hXeChSYv0FJE30iYCDwVThvcyL176pIKvLfPuPi8IpH7U
 mLBgQHz6XTuG1pzZu8zkRZglPBNzHRCkECqvLhsgF7RD2eUoESRdV82Zs
 nRvb1GHOmPY9SNKcicVIfgeviESi8rTFNKzdaXZCI87AOEKFX7SVNMOyI
 JApzYeoQys6t5fTpOrtSvfNjsrninDdJGcH8zruLdEr0dbh/76e2CAin1
 e5/qbv5949ioq80JXVLdPRcUdfOZcQuS9WTY9cgO8wNik0TZzEBx1/LZ+
 Tv6Tu5v1CDfbkPDYB4v1mbK63mkbk+e4bCV3MVl6n7dcOsUdEjOzUMtGU A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261390458"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; d="scan'208";a="261390458"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 18:02:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; d="scan'208";a="551987361"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.23])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 18:02:07 -0700
Date: Wed, 13 Apr 2022 09:02:02 +0800
From: Chao Gao <chao.gao@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Message-ID: <20220413010157.GA10502@gao-cwp>
References: <20220412113805.3210-1-chao.gao@intel.com>
 <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Kevin Tian <kevin.tian@intel.com>,
 Wang Zhaoyang1 <zhaoyang1.wang@intel.com>, linux-kernel@vger.kernel.org,
 Gao Liang <liang.gao@intel.com>, iommu@lists.linux-foundation.org, hch@lst.de
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

On Tue, Apr 12, 2022 at 02:33:05PM +0100, Robin Murphy wrote:
>On 12/04/2022 12:38 pm, Chao Gao wrote:
>> When we looked into FIO performance with swiotlb enabled in VM, we found
>> swiotlb_bounce() is always called one more time than expected for each DMA
>> read request.
>> 
>> It turns out that the bounce buffer is copied to original DMA buffer twice
>> after the completion of a DMA request (one is done by in
>> dma_direct_sync_single_for_cpu(), the other by swiotlb_tbl_unmap_single()).
>> But the content in bounce buffer actually doesn't change between the two
>> rounds of copy. So, one round of copy is redundant.
>> 
>> Pass DMA_ATTR_SKIP_CPU_SYNC flag to swiotlb_tbl_unmap_single() to
>> skip the memory copy in it.
>
>It's still a little suboptimal and non-obvious to call into SWIOTLB twice
>though - even better might be for SWIOTLB to call arch_sync_dma_for_cpu() at
>the appropriate place internally,

Hi Robin,

dma_direct_sync_single_for_cpu() also calls arch_sync_dma_for_cpu_all()
and arch_dma_mark_clean() in some cases. if SWIOTLB does sync internally,
should these two functions be called by SWIOTLB?

Personally, it might be better if swiotlb can just focus on bounce buffer
alloc/free. Adding more DMA coherence logic into swiotlb will make it
a little complicated.

How about an open-coded version of dma_direct_sync_single_for_cpu
in dma_direct_unmap_page with swiotlb_sync_single_for_cpu replaced by
swiotlb_tbl_unmap_single?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
