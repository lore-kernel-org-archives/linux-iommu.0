Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EA5C433FE
	for <iommu@archiver.kernel.org>; Sat, 30 Apr 2022 05:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E57581427;
	Sat, 30 Apr 2022 05:12:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MdO1TUSfQ-qh; Sat, 30 Apr 2022 05:12:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8FF2581424;
	Sat, 30 Apr 2022 05:12:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C96CC0032;
	Sat, 30 Apr 2022 05:12:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FD5FC002D
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 05:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 673B041298
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 05:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4hJ23CQ7jIAG for <iommu@lists.linux-foundation.org>;
 Sat, 30 Apr 2022 05:12:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EC2B4091A
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 05:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651295532; x=1682831532;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PFNU2NL6HfP9hCxoyhIj2wN4qSRTLERQuZemWbYd7+U=;
 b=KY61iebD3UFzHrjnHuPE4GRBTX7uTdQ5rPKsm3yyhtGfSSI2nLMVUClQ
 xO2E4ZuXRTxNI8YxUuFt68RrO78b4P7YuI8bUqp3GGjZOt6p/wR/joGWt
 ORywvyBq9vqmggqAe+7Kz+yAKC7LHGLzklCeJKftvXpVekVwnE+fZCeb3
 2GGDFI2IicVc6BpE6SOnyA+kxKM9pHIxzPFMmiweSGw1CasExQIr2IBKd
 LzsuDF4ZJ5xFQ8hh56K5M4pHUndPwCyUYTZziAESMd51WpVnSCSJbuozJ
 tN210bbkMZCvxYTnQthTJ0SvkX2mci+ULIX1tzodHI45cMXjINGHPWa+G Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="329788081"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; d="scan'208";a="329788081"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 22:12:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; d="scan'208";a="582603000"
Received: from aliu1-mobl.ccr.corp.intel.com (HELO [10.255.30.71])
 ([10.255.30.71])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 22:12:06 -0700
Message-ID: <42b4cd96-dda3-9d00-a684-121129aa1af6@linux.intel.com>
Date: Sat, 30 Apr 2022 13:12:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 04/19] iommu: Add an unmap API that returns dirtied
 IOPTEs
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux-foundation.org
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-5-joao.m.martins@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220428210933.3583-5-joao.m.martins@oracle.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On 2022/4/29 05:09, Joao Martins wrote:
> Today, the dirty state is lost and the page wouldn't be migrated to
> destination potentially leading the guest into error.
> 
> Add an unmap API that reads the dirty bit and sets it in the
> user passed bitmap. This unmap iommu API tackles a potentially
> racy update to the dirty bit *when* doing DMA on a iova that is
> being unmapped at the same time.
> 
> The new unmap_read_dirty/unmap_pages_read_dirty does not replace
> the unmap pages, but rather only when explicit called with an dirty
> bitmap data passed in.
> 
> It could be said that the guest is buggy and rather than a special unmap
> path tackling the theoretical race ... it would suffice fetching the
> dirty bits (with GET_DIRTY_IOVA), and then unmap the IOVA.

I am not sure whether this API could solve the race.

size_t iommu_unmap(struct iommu_domain *domain,
                    unsigned long iova, size_t size)
{
         struct iommu_iotlb_gather iotlb_gather;
         size_t ret;

         iommu_iotlb_gather_init(&iotlb_gather);
         ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
         iommu_iotlb_sync(domain, &iotlb_gather);

         return ret;
}

The PTEs are cleared before iotlb invalidation. What if a DMA write
happens after PTE clearing and before the iotlb invalidation with the
PTE happening to be cached?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
