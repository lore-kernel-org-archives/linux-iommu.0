Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB84A15
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193745; cv=none; b=WrhebhTJPFJxa/hcpOLTEGqVj/R2jTwwta1yh5QUEskpv/BOs1U4ANpeafeVIgJJ7+gGHXCmNduMmJKP4UoKHXMzAOY/CWbApxJuEg/llHpJmtrU56iQJHnOGpZd7rzMuxPrKP6s3J/RZBI00kB3WnOz6J0BPWzgToAkH3xhojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193745; c=relaxed/simple;
	bh=EZ1ZWf3HFGrqpZuOSge3UCh9v/JlK9Q9pPrz8P3c/hQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GVWekcPoGDRARIkSPHJo2LtHo3CNjgcsdB+k+Dc5ZLXr9BD0IuqkQXXD/c9GuGNQIDSIe4/eK7U/A/2u4gIkF2bU56Q4yUrVAAWIDsyBzmOXdCp5SpGaBiz7smjWs5Du/vmfpJJKLEEbTC5fugiD0yWfwMlXILYwKeOJ2nGQ7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tex9e+7f; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tex9e+7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726193744; x=1757729744;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EZ1ZWf3HFGrqpZuOSge3UCh9v/JlK9Q9pPrz8P3c/hQ=;
  b=Tex9e+7fys7eTasz4P2azEzJyLSZoVbJkPw3fpCqCXaYLD4XecLRqonY
   Yxk5xrqP+UegsbI+HEprj0xD4NFHqzw/M8EmBIKdgvzBdyfBpsKxW8wO7
   Yar578dvXj+k9vwT8OHmM5edpHzJiQWeg7SKGA1H/JmH5QpwtaWkLiYry
   5vHjKoIRmdsBhiM/G0wmm8JwksML3Wndtq7kibxQV3UNHt8AFG23USpJJ
   0t4qwh3AjniQbgOH/diaPEsrWP+tgDNmDkyOGug5Ekg++BUmhu6cvRl3f
   lZz0yJ5avGVN8dCHodMadjTFXkDXBHseGfRSWxS94WWVHQJCqST4/PKCH
   Q==;
X-CSE-ConnectionGUID: y0pcfSPLTl679Xso1+AlOw==
X-CSE-MsgGUID: 1fXTdY75T8i3z21pq/TFZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="28976358"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="28976358"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 19:15:42 -0700
X-CSE-ConnectionGUID: J2pOJcNMSK2Jez2jLDoGfw==
X-CSE-MsgGUID: JuOmGkevQlW+ne0g+PVHWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="72256205"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 12 Sep 2024 19:15:38 -0700
Message-ID: <841a6de1-b7b1-4424-a73a-a7400db33299@linux.intel.com>
Date: Fri, 13 Sep 2024 10:11:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, zhenzhong.duan@intel.com,
 linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [PATCH v2 2/6] iommu/vt-d: Move intel_drain_pasid_prq() into
 intel_pasid_tear_down_entry()
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-3-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240912130427.10119-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 9:04 PM, Yi Liu wrote:
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index b51fc268dc84..ceb9c5274a39 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -236,8 +236,13 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>   		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
>   }
>   
> +/*
> + * Not all PASID entry destroy requires PRQ drain as it can be handled in
> + * the remove_dev_pasid path. Caller should be clear about it and set the
> + * @flags properly.
> + */
>   void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
> -				 u32 pasid, bool fault_ignore)
> +				 u32 pasid, u32 flags)

As a generic opt-in bit flags, why not using 'unsigned int'?

Thanks,
baolu
