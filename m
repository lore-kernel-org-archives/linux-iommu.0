Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2A4C7D
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446441; cv=none; b=sngyj1Su2LON5iR5QJSjGrKoGXsHRPi25olmSUO8FQmuBV7ukNayqJN2zknBdzaQd0QMOvXI4zH4HY+SPAIYQw/aMmj3V3DYvMGRaVgjXg13R3yBexXl++K7TlooKZEcQp9bCVkQxHTDs8y8Mutd+bfJsdruA8Zors5j2oabGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446441; c=relaxed/simple;
	bh=vOlXiYGORA3BXGxaBgPZFSP7oBz/ZSa4sAjqdxZ6nhM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Eh0oSiKIvUbS/aLxuaFUhc5tT3jJpKAWFbXyf5uxwEdeO/yNXrww5sRGeW8JThAEacLRsnOdwuRPMILfGReYCdBuTzDAmX1/hXxjq2o1lgoiJ+xnv+OrP1CuvUH4+rFdoD5K42CUXfsoa5rikY2iuvIasStlXVq0LU1ts7LmshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fee8/Yr5; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fee8/Yr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707446439; x=1738982439;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=vOlXiYGORA3BXGxaBgPZFSP7oBz/ZSa4sAjqdxZ6nhM=;
  b=Fee8/Yr5/Xjj+xhmzcLwIXyFhlf1F5kWPkgZfUkOXHywmP1XucGLdKgt
   mzQYT9wEnfttj1cvJ6tN1mt384013q1Cx6cY2AK2VaELR8WfWWEyfp7P9
   M7hlgrWrTZ/XIrL/snorNdNe4EmCg/VvoakkPgVjOKSUuTwdTP/79JNW6
   rG1+2gHuALJnc5qB0YHtQrQXtTULX00/e8anOF1badP9HIx5Rkm4ZFuTg
   CLcZDSDlpj36gkyuEBG8ITlYH3JwHCFMTgJX0+I/FGZ7EK/8GOWya/Stj
   04/y5vyf0DvSFKB0RZcpP89Rz8gcShic750ZDfDrOsQgIcNg5B6sV3qcL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="436494622"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="436494622"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:40:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="6488690"
Received: from lshui-mobl1.ccr.corp.intel.com (HELO [10.249.170.42]) ([10.249.170.42])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:40:35 -0800
Message-ID: <43887410-6a3c-4d1e-b1fc-abb0da1a0ad3@linux.intel.com>
Date: Fri, 9 Feb 2024 10:40:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Set SSADE when attaching to a parent with
 dirty tracking
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 robin.murphy@arm.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, zhenzhong.duan@intel.com,
 joao.m.martins@oracle.com
References: <20240208091414.28133-1-yi.l.liu@intel.com>
Content-Language: en-US
In-Reply-To: <20240208091414.28133-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/8 17:14, Yi Liu wrote:
> Should set the SSADE (Second Stage Access/Dirty bit Enable) bit of the
> pasid entry when attaching a device to a nested domain if its parent
> has already enabled dirty tracking.
> 
> Fixes: 111bf85c68f6 ("iommu/vt-d: Add helper to setup pasid nested translation")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
> base commit: 547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3
> ---
>   drivers/iommu/intel/pasid.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 3239cefa4c33..9be24bb762cf 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -658,6 +658,8 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
>   	pasid_set_domain_id(pte, did);
>   	pasid_set_address_width(pte, s2_domain->agaw);
>   	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> +	if (s2_domain->dirty_tracking)
> +		pasid_set_ssade(pte);
>   	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
>   	pasid_set_present(pte);
>   	spin_unlock(&iommu->lock);

The same fix should also be applied to the intel_pasid_setup_second()
path. Specifically, if a second-stage domain with dirty tracking enabled
attaches to a device, the corresponding entry in the pasid table should
also have the SSADE bit set.

Best regards,
baolu
