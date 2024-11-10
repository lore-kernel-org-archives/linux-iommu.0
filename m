Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93841C94
	for <iommu@lists.linux.dev>; Sun, 10 Nov 2024 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731212192; cv=none; b=G+XdnU12dcUKdo3RvcTLMO9ssjIBi2TGtJejvFhYY6N473ULWFks5bcd3ohw7qrwC0Bq5eZ4aqNug7ysmaIK8fJdzfDIXVr1LKxRcyAEHMIkbvyh6VSzod3pCJDvG35WgXvgN3nq9NHFWhBojXoyAu7cyBzB+LhuZQLfY8aULto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731212192; c=relaxed/simple;
	bh=VqhPhaEvvJFiGRzcKSoEuhmpIU7/gc+vywtAOPWZNlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKcMsOBiXSjUTvLAu1Hs9gy7yX0cCZF7sUyAIvcD9WjoyZiajhmGNG/HjUFNqBcK7lFitNMNFkAT5TMQZWryLeUaE/6EpTISPVHOYAcwlZy7NCdV6XpzoArOfZJcgSOE/hSIcN9MGmLpFDvP+njlIPEmGiPeO9FQm1EXp1i4Ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iy4HqPUy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iy4HqPUy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731212190; x=1762748190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VqhPhaEvvJFiGRzcKSoEuhmpIU7/gc+vywtAOPWZNlc=;
  b=iy4HqPUy/k/9Drxr37njBLsO4B3ofhuhR9QACgFxSyzbj6tSYq1M5TSy
   5V+VnCeAX1NWRpHMNhIw8k6GgFQWcT/amMS6ei+urj9iRhrICddwr2cEU
   7J/MBEngpRZM/zfw0Mef7QhM72QPZbng/0rKdkSBuCbAD344RHgeDWmoV
   zriHmp7dlHNx8NB52IZCpBTZy6vmTnPm0qzB/IN56+TF9BK0UIsogIaoN
   BsJcRoFsTxLaWog+dbLkWbZIwR1CaZ0rqlOhXDiityAzd432H6Cpu7QJX
   IVXNwQqZ5AiuQK30PAlP6bpygEIdU64PiEBYNOPk/tIpyak5yStGZZ9QX
   w==;
X-CSE-ConnectionGUID: ByM0wI8dThufxyaBhQV+Ww==
X-CSE-MsgGUID: eBMAxhA4QhikgKktIEeT9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11251"; a="41662370"
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="41662370"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 20:16:29 -0800
X-CSE-ConnectionGUID: wZBR3UxaSpil9xZzscA5XA==
X-CSE-MsgGUID: SVSN/Tz5SX2Vuz3WPFw6SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="86197944"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 20:16:26 -0800
Message-ID: <64e190bd-6d4a-4d43-b908-222e0bc766c5@linux.intel.com>
Date: Sun, 10 Nov 2024 12:15:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] iommu: Detaching pasid by attaching to the
 blocked_domain
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, willy@infradead.org
References: <20241108120427.13562-1-yi.l.liu@intel.com>
 <20241108120427.13562-4-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241108120427.13562-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 20:04, Yi Liu wrote:
> The iommu drivers are on the way to detach pasid by attaching to the blocked
> domain. However, this cannot be done in one shot. During the transition, iommu
> core would select between the remove_dev_pasid op and the blocked domain.
> 
> Suggested-by: Kevin Tian<kevin.tian@intel.com>
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Reviewed-by: Vasant Hegde<vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommu.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

with a minor comment below

> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 819c6e0188d5..6fd4b904f270 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3302,8 +3302,18 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>   				   struct iommu_domain *domain)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	struct iommu_domain *blocked_domain = ops->blocked_domain;
> +	int ret = 1;
>   
> -	ops->remove_dev_pasid(dev, pasid, domain);
> +	if (blocked_domain && blocked_domain->ops->set_dev_pasid) {
> +		ret = blocked_domain->ops->set_dev_pasid(blocked_domain,
> +							 dev, pasid, domain);

How about removing "ret" and just add a WARN_ON around the return of
setting blocking domain?

	/* Driver should never fail to set a blocking domain. */
	WARN_ON(blocked_domain->ops->set_dev_pasid(...));

> +	} else {
> +		ops->remove_dev_pasid(dev, pasid, domain);
> +		ret = 0;
> +	}
> +
> +	WARN_ON(ret);
>   }

--
baolu
