Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C3AC4332F
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 01:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFCB182884;
	Thu, 10 Feb 2022 01:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id den6cBnynHSZ; Thu, 10 Feb 2022 01:21:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D7E3B8272D;
	Thu, 10 Feb 2022 01:21:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF176C0011;
	Thu, 10 Feb 2022 01:21:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32F8BC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 01:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1298682883
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 01:21:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zxdw8JWdzbHR for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 01:21:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E9428272D
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 01:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644456065; x=1675992065;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xwE1+7sMycEL12v2IFo1+/lSPYpAhi5LFao4nn13fD8=;
 b=BpK2yLJa/KjhPp6QwyOvoyMzaaZr7FQrbaN6wWPz5ZfIPiVpamaZdwaz
 Sz18WT4ijWQfipVDGAchIPaeslp47FB/NLJFlrq4/p49G/N0hydbMl4LJ
 8Bgae38zVl4qtpudgYQ8wL3YKlVKGXZm4J8cb2S4P4Y+fg/tY6M9M0chy
 92248znlDBF5s3Nvo8R8RwmsRN7B97i3njpRusp2gNfuSIXNNrAtikUZ9
 voylm17ASuc6fBze3VCK2ft1Q/szf2tKQJ+6CUsBYZNvpjHJkVNTVlK6F
 gl7D88lP9rrkXpy0PZ0aa6sabnEhXh5BansQOAErd6t36vqE9pztQdKLN g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="229351395"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="229351395"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 17:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="678975431"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 17:21:02 -0800
Message-ID: <16e2142d-30cf-a4e2-c010-b58301b5392e@linux.intel.com>
Date: Thu, 10 Feb 2022 09:19:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/1] iommu/vt-d: Don't cast parameter in
 for_each_set_bit()
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20220209174913.4319-1-andriy.shevchenko@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220209174913.4319-1-andriy.shevchenko@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>
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

Hi Andy,

On 2/10/22 1:49 AM, Andy Shevchenko wrote:
> While in this particular case it would not be a (critical) issue,
> the pattern itself is bad and error prone in case the location
> of the parameter is changed.
> 
> Don't cast parameter to unsigned long pointer in for_each_set_bit().
> Instead copy to a local variable on stack of a proper type and use.
> 
> Fixes: 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fbbb11..777e81b8f4f5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4973,6 +4973,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>   	struct device_domain_info *info;
>   	struct intel_iommu *iommu;
> +	unsigned long cache_bits;
>   	unsigned long flags;
>   	int cache_type;
>   	u8 bus, devfn;
> @@ -5008,9 +5009,8 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   		size = to_vtd_size(inv_info->granu.addr_info.granule_size,
>   				   inv_info->granu.addr_info.nb_granules);
>   
> -	for_each_set_bit(cache_type,
> -			 (unsigned long *)&inv_info->cache,
> -			 IOMMU_CACHE_INV_TYPE_NR) {
> +	cache_bits = inv_info->cache;
> +	for_each_set_bit(cache_type, &cache_bits, IOMMU_CACHE_INV_TYPE_NR) {
>   		int granu = 0;
>   		u64 pasid = 0;
>   		u64 addr = 0;

Thanks for your patch. The function that you are changing becomes dead
code (nobody uses it and there's no plan to use it anymore) now. I
already have a patch to remove this function.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
