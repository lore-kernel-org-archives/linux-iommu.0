Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD4CC433F5
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 06:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97B288440C;
	Thu, 19 May 2022 06:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QnyQ5p-PozoK; Thu, 19 May 2022 06:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7868284402;
	Thu, 19 May 2022 06:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D441C0039;
	Thu, 19 May 2022 06:41:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C06C9C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 06:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 996D840338
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 06:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zm-1WS3RUqNz for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 06:41:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6614A40593
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 06:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652942474; x=1684478474;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iZMFcG0XywxoHyOC1CFZNXhVD9jrMWWC6XRQyrV/69k=;
 b=ekykT+GSnHGE03dx9ijsW9xlHtP0n3t/Sh05CGYg42yjfv2GL3hLUhDY
 CCI5nsLBbFnwOunDOYjt+pTUdMSpowAwssC7Cik/GFQxauxx4lddeO7id
 RtNUMjKkRBa6i4sZVxsyQphNv5Bij6tCVPTWZrkCUduq2A6i+JX7k9sgj
 pGTncxRSh9o1VhhpjB/dNzgMv1ZAJ7Ij2uaCtGPwqWJ0VxskLT/KSkwut
 x+aRd3q59tK8sWdFS1C4vdhNTGdGMvwg8kBh9YcfnEGAvWSe6C5qh/Rhz
 7fLs/amTYCtKA+0uurCrsBOwy5wNQ8hYzSogVyGGSiw1WfS/q+gMzVcvn g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="254097898"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; d="scan'208";a="254097898"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 23:41:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; d="scan'208";a="742749075"
Received: from zhongz9x-mobl.ccr.corp.intel.com (HELO [10.255.28.182])
 ([10.255.28.182])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 23:41:08 -0700
Message-ID: <41c717e3-2965-67ac-9140-72f4b071cd9a@linux.intel.com>
Date: Thu, 19 May 2022 14:41:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 vkoul@kernel.org, robin.murphy@arm.com, will@kernel.org
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>
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

On 2022/5/19 02:21, Jacob Pan wrote:
> IOMMU group maintains a PASID array which stores the associated IOMMU
> domains. This patch introduces a helper function to do domain to PASID
> look up. It will be used by TLB flush and device-PASID attach verification.

Do you really need this?

The IOMMU driver has maintained a device tracking list for each domain.
It has been used for cache invalidation when unmap() is called against
dma domain.

Best regards,
baolu

> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
>   include/linux/iommu.h |  6 +++++-
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 00d0262a1fe9..22f44833db64 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3199,3 +3199,25 @@ struct iommu_domain *iommu_get_domain_for_iopf(struct device *dev,
>   
>   	return domain;
>   }
> +
> +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain)
> +{
> +	struct iommu_domain *tdomain;
> +	struct iommu_group *group;
> +	unsigned long index;
> +	ioasid_t pasid = INVALID_IOASID;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return pasid;
> +
> +	xa_for_each(&group->pasid_array, index, tdomain) {
> +		if (domain == tdomain) {
> +			pasid = index;
> +			break;
> +		}
> +	}
> +	iommu_group_put(group);
> +
> +	return pasid;
> +}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 36ad007084cc..c0440a4be699 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -694,7 +694,7 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>   			       struct device *dev, ioasid_t pasid);
>   struct iommu_domain *
>   iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid);
> -
> +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain);
>   #else /* CONFIG_IOMMU_API */
>   
>   struct iommu_ops {};
> @@ -1070,6 +1070,10 @@ iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid)
>   {
>   	return NULL;
>   }
> +static ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain)
> +{
> +	return INVALID_IOASID;
> +}
>   #endif /* CONFIG_IOMMU_API */
>   
>   #ifdef CONFIG_IOMMU_SVA

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
