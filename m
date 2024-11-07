Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B928689
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948290; cv=none; b=kscjUm23jvyyORlF+qBf5Nupi9UttL0RF9Oq1ojIO33ogokMcl+QgoYXucQNYGO4vbWy2KgHOWtszOBxCqS6BtjwjXfzjOqjhkyykgu4M1KirL+vC3E/yPF4mNmHZLLuLEMWY6ArgqfclurR+R3w8hs1htaXIjSKjmonHJ1VvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948290; c=relaxed/simple;
	bh=94PKgaKfWOHAXdSd2MtMBjDFznqUJObjfasieQkDFdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuDPdkNdzbU2uOWiNrzgC4tprrz765GN+n7ISYkYwWCcIzdYNyoIbN1i46iV/Yx4gItVjQAEcpxlpdaI7IsKMGBWqwXWMLookOvtrAzExIqmagHyyH9/xKIpL/lUbRUmxZr736HsXL62fEhxwlPmP9gODoo2ie4Y29EeL0D/WrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsyYexAQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsyYexAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730948288; x=1762484288;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=94PKgaKfWOHAXdSd2MtMBjDFznqUJObjfasieQkDFdU=;
  b=GsyYexAQc5mvAja4rl09L8b1N9iY2541gV/o8EznL+rtUbUjgrPZPQNs
   bTxwrOi59l1TR3C0nTCFlPLSHQx8X7PX8IjzqzVrBLi8aMN436bS3J9lq
   5WDGpXw+vafndoJvpf/+xkSZk4gtS1T+To+RmtsIZr/1sYAfpj+AoUR3C
   z+DiCmshq9EQxHphRafWw4PAYPX84vCwlVNV5kVJ+0f+f+3qw58rpv47v
   1j3nvRq1yipYp7g9P5jM969TR2Vzr1+iBxVOP/GpaK+rJDcHuvzcJ0Nla
   zvYdN7cIZl39C82zuP1rx3wG1RYf1CFJ51YMamZCKgtYSiP0g3JINr1Kw
   Q==;
X-CSE-ConnectionGUID: 7+GkrpUwS/Kpq1J8r9SQIQ==
X-CSE-MsgGUID: D1ZvvgV9Rk6ZLYkmaEzruQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="42177848"
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="42177848"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 18:58:08 -0800
X-CSE-ConnectionGUID: XEByOHGSTkihLFelApb1HA==
X-CSE-MsgGUID: 33576pdsRqSYpOrS32QyBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="84518924"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 18:58:05 -0800
Message-ID: <0ab4e27c-0ebc-4062-bf5a-121e4e95a16a@linux.intel.com>
Date: Thu, 7 Nov 2024 10:57:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] iommu/vt-d: Add pasid replace helpers
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, willy@infradead.org
References: <20241106154606.9564-1-yi.l.liu@intel.com>
 <20241106154606.9564-5-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241106154606.9564-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 23:45, Yi Liu wrote:
> +int intel_pasid_replace_second_level(struct intel_iommu *iommu,
> +				     struct dmar_domain *domain,
> +				     struct device *dev, u16 old_did,
> +				     u32 pasid)
> +{
> +	struct pasid_entry *pte;
> +	struct dma_pte *pgd;
> +	u64 pgd_val;
> +	int agaw;
> +	u16 did;
> +
> +	/*
> +	 * If hardware advertises no support for second level
> +	 * translation, return directly.
> +	 */
> +	if (!ecap_slts(iommu->ecap)) {
> +		pr_err("No second level translation support on %s\n",
> +		       iommu->name);
> +		return -EINVAL;
> +	}
> +
> +	pgd = domain->pgd;
> +	pgd_val = virt_to_phys(pgd);
> +	did = domain_id_iommu(domain, iommu);
> +
> +	spin_lock(&iommu->lock);
> +	pte = intel_pasid_get_entry(dev, pasid);
> +	if (!pte) {
> +		spin_unlock(&iommu->lock);
> +		return -ENODEV;
> +	}
> +
> +	if (!pasid_pte_is_present(pte)) {
> +		spin_unlock(&iommu->lock);
> +		return -EINVAL;
> +	}
> +
> +	WARN_ON(old_did != pasid_get_domain_id(pte));
> +
> +	pasid_pte_config_second_level(iommu, pte, pgd_val, agaw,
> +				      did, domain->dirty_tracking);
> +	spin_unlock(&iommu->lock);
> +
> +	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> +	intel_iommu_drain_pasid_prq(dev, pasid);
> +
> +	return 0;
> +}

0day robot complains:

 >> drivers/iommu/intel/pasid.c:540:53: warning: variable 'agaw' is 
uninitialized when used here [-Wuninitialized]
      540 |         pasid_pte_config_second_level(iommu, pte, pgd_val, agaw,
          |                                                            ^~~~
    drivers/iommu/intel/pasid.c:509:10: note: initialize the variable 
'agaw' to silence this warning
      509 |         int agaw;
          |                 ^
          |                  = 0

The right fix could be like this:

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 777e70b539b1..69f12b1b8a2b 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -506,7 +506,6 @@ int intel_pasid_replace_second_level(struct 
intel_iommu *iommu,
         struct pasid_entry *pte;
         struct dma_pte *pgd;
         u64 pgd_val;
-       int agaw;
         u16 did;

         /*
@@ -537,7 +536,7 @@ int intel_pasid_replace_second_level(struct 
intel_iommu *iommu,

         WARN_ON(old_did != pasid_get_domain_id(pte));

-       pasid_pte_config_second_level(iommu, pte, pgd_val, agaw,
+       pasid_pte_config_second_level(iommu, pte, pgd_val, domain->agaw,
                                       did, domain->dirty_tracking);
         spin_unlock(&iommu->lock);

--
baolu
