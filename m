Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C4C2FE
	for <iommu@lists.linux.dev>; Wed, 17 Jan 2024 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477218; cv=none; b=pCScVBvdE1ZlZgchr8eSXdXyWRFxcAtcSihtxmlLUCyQzjwnI7rtPPzmkMS7Qp0uULIbEX60e5q/WLgtGsaAMCrhth0ZclZm3CIis7LtZAEgULC6p0vt1milNLy3jGvD1chbvzwSVFtIxAUz5sZaiGMESnmJQTZ5lChwqQAW/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477218; c=relaxed/simple;
	bh=UpDvkvPZgNPbQ9d4O7i5SY1Ti0NctL74gDzpCO8Bl5Q=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Cc:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=sEzogkfAWTdJJn1DzgNjwH6RcRjqY1hizB+ObdlKPUcyik3vBPl2NkFri7jxWkMdpK41aESssdYzKeDgpP4mdZGYl230LLexCwCcjHW2c2IhiLju7vlrySlFuIdTrfNGVyczVSfe7XCoYzUuTMffecoXJiZ/5VXc74Y6+GrdNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIWQ1qSF; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIWQ1qSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705477217; x=1737013217;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UpDvkvPZgNPbQ9d4O7i5SY1Ti0NctL74gDzpCO8Bl5Q=;
  b=eIWQ1qSFvYghQwaojFeA0A3ZB6TlGhlMQr0yIq6aXWkW4dJPlBlXMN3G
   2NUIzjqsomvB+0VVo6DIsbO588SuI9u6GIIkXoHf8slh/zbNQGAm6n5dL
   qWcTsV5SdcvSutOsHKCoAGpohdSUi26j0VB4PWn937FYA+HhMSaoRMy2P
   7N6Um2ilq5fIuMlAzh1zb2bM7t0xvrOjzIoZF95Rr2tDEPu1vxph32Pqq
   51sLekbXBVxnpOro5mLcII16VS3Cv/XgvIcEh4224ZuEMkYGQAGU0n+eR
   NComJ+bPKDM7lzl/enVKML5eJ+ynY/pof+Xr15qBhMrGcLXbMgqr0/il3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="403855493"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="403855493"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:40:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="818430571"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="818430571"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.146]) ([10.249.171.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:40:15 -0800
Message-ID: <5f57c685-04ab-4c70-b305-aa42b97b703a@linux.intel.com>
Date: Wed, 17 Jan 2024 15:40:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 09/11] iommu/vt-d: Reuse intel_iommu_set_dev_pasid
 function
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-10-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240116011146.18645-10-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/16 9:11, Tina Zhang wrote:
> Refactor intel_iommu_set_dev_pasid() and make it be reused by sva domain
> as the set_dev_pasid operation.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 43 ++++++++++++++++++++++++++-----------
>   drivers/iommu/intel/iommu.h |  2 ++
>   drivers/iommu/intel/svm.c   | 42 +-----------------------------------
>   3 files changed, 33 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index af466ba301b7..8d1b9de78a43 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4574,7 +4574,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   	intel_drain_pasid_prq(dev, pasid);
>   }
>   
> -static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> +int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>   				     struct device *dev, ioasid_t pasid)
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
> @@ -4593,31 +4593,48 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>   	if (context_copied(iommu, info->bus, info->devfn))
>   		return -EBUSY;
>   
> -	ret = prepare_domain_attach_device(domain, dev);
> -	if (ret)
> -		return ret;
> -
>   	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
>   	if (!dev_pasid)
>   		return -ENOMEM;
>   
> -	ret = domain_attach_iommu(dmar_domain, iommu);
> -	if (ret)
> -		goto out_free;
> +	dev_pasid->dev = dev;
> +	dev_pasid->pasid = pasid;
> +	if (domain_type_is_sva(dmar_domain)) {
> +		dev_pasid->did = FLPT_DEFAULT_DID;
> +		dev_pasid->sid = PCI_DEVID(info->bus, info->devfn);
> +		if (info->ats_enabled) {
> +			dev_pasid->qdep = info->ats_qdep;
> +			if (dev_pasid->qdep >= QI_DEV_EIOTLB_MAX_INVS)
> +				dev_pasid->qdep = 0;
> +		}

This is generic device information. There's no need to do it only for
the SVA domain; otherwise, you'll have to check the domain type every
time you use these fields.

> +	} else {
> +		ret = prepare_domain_attach_device(domain, dev);

The prepare_domain_attach_device() function is called to check whether
the device is compatible with the domain to be attached. You could make
it work for the SVA domain as well, rather than ignoring it.

> +		if (ret)
> +			goto out_free;
> +
> +		ret = domain_attach_iommu(dmar_domain, iommu);

The same here.

The domain_attach_iommu() is called to setup the relationship between a
domain and an iommu. You should make it compatible with sva domain as
well.

Best regards,
baolu
