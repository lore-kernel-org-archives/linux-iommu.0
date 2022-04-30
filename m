Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871E7C433EF
	for <iommu@archiver.kernel.org>; Sat, 30 Apr 2022 06:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 21C1F40D99;
	Sat, 30 Apr 2022 06:13:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MPVsjTDHONeZ; Sat, 30 Apr 2022 06:13:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D901B40D96;
	Sat, 30 Apr 2022 06:13:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB3C3C0039;
	Sat, 30 Apr 2022 06:13:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73235C002D
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 06:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C11F60B14
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 06:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OwaUusQwMF8R for <iommu@lists.linux-foundation.org>;
 Sat, 30 Apr 2022 06:13:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4C2C60B0D
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 06:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651299186; x=1682835186;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bduZeRhtcqMCTEtbZUvcivc11HeyoC6C/e3RwE5iqPo=;
 b=YknFpzfAniVh3X9WVFA6vq9Dzk7aGNv46XWAE/R0yOzf+/iKrR4pG3kL
 8c8GioB8TnquKuEhEiGQFwDB9qg8kX7laaxrdY0rdh5+joF2P2Y1tw3hn
 lWtysdWRtCKOXa0nXHT5xxQw3CevGx2W3suayLgeObTtc9wynrXFBS/zN
 EXIXmDSQ6YdJRRWmGhLoNyOdrHWkJdMKS+yJM0eacutTLj+uI9odWUOji
 MAczht3eIzXEErUc+lqQraHmkctpE3iugA6IiNo2joraOj7WQHuQ1sU8G
 /4a3DcEJprbHR1WeA6F/9VrrbIhY7ijR2cSq7B3kTOLjQ+wMbrwtI1l5s g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="264426267"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; d="scan'208";a="264426267"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 23:13:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; d="scan'208";a="582625957"
Received: from aliu1-mobl.ccr.corp.intel.com (HELO [10.255.30.71])
 ([10.255.30.71])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 23:13:01 -0700
Message-ID: <b214e55d-a1aa-4681-22fe-8f4fc03ca8df@linux.intel.com>
Date: Sat, 30 Apr 2022 14:12:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 18/19] iommu/intel: Access/Dirty bit support for SL
 domains
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux-foundation.org
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-19-joao.m.martins@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220428210933.3583-19-joao.m.martins@oracle.com>
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
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5089,6 +5089,113 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
>   	}
>   }
>   
> +static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
> +					  bool enable)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	unsigned long flags;
> +	int ret = -EINVAL;

	if (domain_use_first_level(dmar_domain))
		return -EOPNOTSUPP;

> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	if (list_empty(&dmar_domain->devices)) {
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +		return ret;
> +	}

I agreed with Kevin's suggestion in his reply.

> +
> +	list_for_each_entry(info, &dmar_domain->devices, link) {
> +		if (!info->dev || (info->domain != dmar_domain))
> +			continue;

This check is redundant.

> +
> +		/* Dirty tracking is second-stage level SM only */
> +		if ((info->domain && domain_use_first_level(info->domain)) ||
> +		    !ecap_slads(info->iommu->ecap) ||
> +		    !sm_supported(info->iommu) || !intel_iommu_sm) {
> +			ret = -EOPNOTSUPP;
> +			continue;

Perhaps break and return -EOPNOTSUPP directly here? We are not able to
support a mixed mode, right?

> +		}
> +
> +		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->domain,
> +						     info->dev, PASID_RID2PASID,
> +						     enable);
> +		if (ret)
> +			break;
> +	}
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	/*
> +	 * We need to flush context TLB and IOTLB with any cached translations
> +	 * to force the incoming DMA requests for have its IOTLB entries tagged
> +	 * with A/D bits
> +	 */
> +	intel_flush_iotlb_all(domain);
> +	return ret;
> +}

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
