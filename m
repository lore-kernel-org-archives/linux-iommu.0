Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507A1E22E8
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476994; cv=none; b=GJuPHmL3Cn9CQdk4BIQdsE3okN9+rg1P3wMWaQgP9MdmZWL4lgOm86pcJOhHLiB4M0/Uus+SBXtca4rOSUXBqJeqJQnDnI6TspbwAEG5IORo+pkp8IGGrDa1RaJzshZw29Qr6B+JhegilONUx6jOncCnT+nVy6W0mwoARm1+gAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476994; c=relaxed/simple;
	bh=Opi8OtnSondO+9qN+ZEH8fkz1P+xjDvA6Uo8hvdNKFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFL9PpkMwDBkyoV70MjInFec96nltVa657/STsUE+QPvl5LD4DVxliHZkpiwHiuuSn7K2zZGFFSNAKJiszN6mfiPS6U1NDf1WrElzim5+HTdsuisIOobwpuULeg2gFNVB7I89KBcq19tgrdFWnwXcYqiaTfOK3W0SVZEnBjxHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geNY7z6s; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geNY7z6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736476993; x=1768012993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Opi8OtnSondO+9qN+ZEH8fkz1P+xjDvA6Uo8hvdNKFs=;
  b=geNY7z6sojXM5XfzH5gYc/J0DswWyO1jVnhAUG7P0em4px5nMD9HbXwH
   i9uH++oLRoSZO42SvYxx9Vx8BYBOERwGW/BR9fnfnjAxu/IrjtiQR1i2Z
   L43TWoM/9rbZSYiEuNVjZpc71wA5rJPLItrAWEA+pJyzd7/57GvNnwDZl
   UC7if8+3QQGCx+R0mcln/Cxr0yh9brEs1Z4QibLtpze6xJuSnjxjJk2Yh
   GBu/1Nq6tS+A1jbBtEXMh0juZaW6NEqeMvCsnwfjwEVfnAazr2k2v2xdc
   8pUFUEADY8PbwNzObzTf075ZQmU6tWKi8ZZ3IOd0Lw+QNYgzVSElnUpjC
   Q==;
X-CSE-ConnectionGUID: 5MuIKvCwQl6e1HsztBdSLQ==
X-CSE-MsgGUID: UvI6bFZNSiqdhQnosqtKZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36924292"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36924292"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 18:43:12 -0800
X-CSE-ConnectionGUID: 4fv1R9YVRwurBdlP3JCZQA==
X-CSE-MsgGUID: sMQMK1UVTpe4tzsdcS9sXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="134439169"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 18:43:10 -0800
Message-ID: <c907f620-6f83-4c01-ad50-cc369763b8cc@linux.intel.com>
Date: Fri, 10 Jan 2025 10:41:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, vasant.hegde@amd.com, will@kernel.org
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <20250109152713.GB5556@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250109152713.GB5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/25 23:27, Jason Gunthorpe wrote:
> On Mon, Dec 23, 2024 at 10:51:50AM +0800, Baolu Lu wrote:
>>> @@ -198,7 +198,7 @@ intel_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
>>>    	struct dmar_domain *domain;
>>>    	int ret;
>>> -	if (!nested_supported(iommu) || flags)
>>> +	if (!nested_supported(iommu) || flags & ~IOMMU_HWPT_ALLOC_PASID)
>>>    		return ERR_PTR(-EOPNOTSUPP);
>>>    	/* Must be nested domain */
>> It's better to abort and fail a domain allocation when
>> IOMMU_HWPT_ALLOC_PASID is set but the iommu lacks pasid support?
> With multi-instances of iommus in the system you still want to succeed
> creating a PASID capable domain even on instances that don't support
> PASID since it may end up being used on an other instances too.

Okay, so this flag is just a hint that "this domain will probably be
attached to a pasid of a device", NOT a requirement of "this domain
necessitates hardware support for the PASID feature".

---
baolu
