Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91176C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 11:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B91E60AAC;
	Wed,  4 May 2022 11:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ms9TWfZU50O0; Wed,  4 May 2022 11:49:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 006B360B00;
	Wed,  4 May 2022 11:49:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEF34C0039;
	Wed,  4 May 2022 11:49:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40AA2C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20C8060B00
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id emaFbS2WsriL for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 11:49:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 573C960AAC
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651664956; x=1683200956;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=aK1l0rCkiCVuwvhMHCLNjidnHMRCRhIJ4+KFRoQvpco=;
 b=XtnapNq86bUi2JDANRha2o34LUJP7bQlUkSTLjwBBio4uKETNHqWcZIh
 XuLbtve/RHSqfVtwnm/iQwXGK1D6of3qrTUlLPdlCZsv+BMaG021SYZb2
 Yg948Uoqa1EbcOFP9IpJBFC7bze6Mrrm9ruYYs9K8k+eWHNhE5vKsQfl8
 qFwbxBuinGw+xvYTxhER5fKxK44ZkCQr2b9jKtmaSdAVo9D3d3derx+S/
 RWnw14nD5yMl1VFY0Pd1U7AsLujpOAaM3eozaKtGhmB62Vpm2hMo3+XHi
 IwEOu0w+sIyXp1Ebw+/srLPiOmdhFFGTVNnRnK+51ckGj9tBo11jG9I0h w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="249723298"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; d="scan'208";a="249723298"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 04:49:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; d="scan'208";a="734368850"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223])
 ([10.255.30.223])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 04:49:00 -0700
Message-ID: <f213ba6f-2cbc-e4b2-c510-16ef8ef0a337@linux.intel.com>
Date: Wed, 4 May 2022 19:48:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign a
 domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux-foundation.org,
 Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>
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

Hi Jason,

On 2022/5/4 08:11, Jason Gunthorpe wrote:
> +static int __iommu_group_attach_domain(struct iommu_group *group,
> +				       struct iommu_domain *new_domain)
>   {
>   	int ret;
>   
> +	if (group->domain == new_domain)
> +		return 0;
> +
>   	/*
> -	 * If the group has been claimed already, do not re-attach the default
> -	 * domain.
> +	 * A NULL domain means to call the detach_dev() op. New drivers should
> +	 * use a IOMMU_DOMAIN_IDENTITY domain instead of a NULL default_domain
> +	 * and detatch_dev().
>   	 */
> -	if (!group->default_domain || group->owner) {
> -		__iommu_group_for_each_dev(group, domain,
> +	if (!new_domain) {
> +		WARN_ON(!group->domain->ops->detach_dev);
> +		__iommu_group_for_each_dev(group, group->domain,
>   					   iommu_group_do_detach_device);
>   		group->domain = NULL;
> -		return;
> +		return 0;
>   	}
>   
> -	if (group->domain == group->default_domain)
> -		return;
> -
> -	/* Detach by re-attaching to the default domain */
> +	/*
> +	 * New drivers do not implement detach_dev, so changing the domain is
> +	 * done by calling attach on the new domain. Drivers should implement
> +	 * this so that DMA is always translated by either the new, old, or a
> +	 * blocking domain. DMA should never become untranslated.
> +	 *
> +	 * Note that this is called in error unwind paths, attaching to a
> +	 * domain that has already been attached cannot fail.
> +	 */
>   	ret = __iommu_group_for_each_dev(group, group->default_domain,
						^^^^^^^^^^^^^^^^^^^^^^

I suppose this should be @new_domain, right?

>   					 iommu_group_do_attach_device);
> -	if (ret != 0)
> -		WARN_ON(1);
> +	if (ret)
> +		return ret;
> +	group->domain = new_domain;
> +	return 0;
> +}

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
