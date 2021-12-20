Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DB3C433FE
	for <iommu@archiver.kernel.org>; Mon, 20 Dec 2021 01:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1B6C41709;
	Mon, 20 Dec 2021 01:18:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yrwoO3PoSsqb; Mon, 20 Dec 2021 01:18:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8284416DF;
	Mon, 20 Dec 2021 01:18:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EAC8C002F;
	Mon, 20 Dec 2021 01:18:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF317C0012
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 01:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C595240164
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 01:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j-pbnYu6YV8f for <iommu@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 01:18:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6BAB400E9
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 01:18:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="326370530"
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; d="scan'208";a="326370530"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2021 17:18:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; d="scan'208";a="507496332"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 19 Dec 2021 17:18:51 -0800
Subject: Re: [PATCH v3 6/9] iommu/vt-d: Use put_pages_list
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1639753638.git.robin.murphy@arm.com>
 <2115b560d9a0ce7cd4b948bd51a2b7bde8fdfd59.1639753638.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1df4cd6c-7f70-4358-e57f-754d98807abe@linux.intel.com>
Date: Mon, 20 Dec 2021 09:18:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2115b560d9a0ce7cd4b948bd51a2b7bde8fdfd59.1639753638.git.robin.murphy@arm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, hch@lst.de
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

Hi Robin,

On 12/17/21 11:31 PM, Robin Murphy wrote:
> From: "Matthew Wilcox (Oracle)"<willy@infradead.org>
> 
> page->freelist is for the use of slab.  We already have the ability
> to free a list of pages in the core mm, but it requires the use of a
> list_head and for the pages to be chained together through page->lru.
> Switch the Intel IOMMU and IOVA code over to using free_pages_list().
> 
> Signed-off-by: Matthew Wilcox (Oracle)<willy@infradead.org>
> [rm: split from original patch, cosmetic tweaks, fix fq entries]
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

I had boot tests on my development machines with both strict and lazy
flushing modes. I didn't see any regression, the disk i/o and network
i/o worked good for me.

For changes in iommu/vt-d:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
