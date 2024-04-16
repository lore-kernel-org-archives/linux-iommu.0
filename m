Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C3FBA42
	for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233348; cv=none; b=I3aPsQx2XPAWKx0I6HCiV2NnQcQpfE53zsSPY4WfyvCEZ2NZBlfbik++NZqyUWY5mSrR0T5OO2xoJCa4mvKziMvPpYtIxfJhXncWiPSW//uLX8ytfyuPv6lbseSiTQkDIjPK44CzxBSDY1a5bnxGJ+e4qyLqiIIi9FOyK3eLAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233348; c=relaxed/simple;
	bh=wYX7r+H/n87U0T/1+MFb0+1Mg6uryXz1ZJumcyRTdmg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l8QPdZXsLb2JMX5HjKNSuC9zMuFUlK+r0VSzbPakypluDJTvOuNycS7EADrrOLKu09MW0LgYWowtFeW5UTLNVnw50tzGeifWL9e/RIhaAM3FnXP3lZHQnJ/NVp9Q0yOMNAsDnVTsTQsNIs4Q6H50GY+rpi4yhO2Ron5nWn8vJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdkKtFxN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdkKtFxN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713233347; x=1744769347;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wYX7r+H/n87U0T/1+MFb0+1Mg6uryXz1ZJumcyRTdmg=;
  b=MdkKtFxN5NcR5MYnDgiUva2PK0t8+8sFtlTHoMGO1dxSW7WIdXcdSaqj
   /EjJXFOzNlCn9LB5MDnrsuQl+9dZ7GFhkzJM55gQehYD0iQS6RfsEvGhP
   b7PxWRJJ5ZAmWGSjLNun1Zd1QQL3nXxroHPgqv5IIJnu8zQSwgzJteaEn
   Mv8sSADIhu3cQ6kOwYGf+hGE/Lmn+TYS43KS+je56QHczJzjLErn+R+Q4
   9bcY3zEGZ5YG7pqH/fnV+TqSV1iC+MDDMCz5yXtrISAx/jiPcc4XU5hth
   QYmCPMFw37s8SAKEb4C3qzAEHY1KeKGcK6N/tPO4oFYW4Z32oL+8WxobV
   g==;
X-CSE-ConnectionGUID: yiIfs1/dRDy3TgruSUIG2g==
X-CSE-MsgGUID: OtwCLRIES3yZiCItjKHf0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8529136"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8529136"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 19:09:06 -0700
X-CSE-ConnectionGUID: 5UGfSHfpSCmBMSGGKu20EA==
X-CSE-MsgGUID: jaUFcifbTHmwJTBuWpzgcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22175137"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 15 Apr 2024 19:09:02 -0700
Message-ID: <4f570287-cd11-4c89-9dd2-9bb106e343c1@linux.intel.com>
Date: Tue, 16 Apr 2024 10:07:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
 kevin.tian@intel.com, alex.williamson@redhat.com, robin.murphy@arm.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 01/12] iommu: Pass old domain to set_dev_pasid op
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20240412081516.31168-1-yi.l.liu@intel.com>
 <20240412081516.31168-2-yi.l.liu@intel.com>
 <3cfb2bb1-3d66-450d-b561-f8f0939645ba@linux.intel.com>
 <20240415115442.GA3637727@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240415115442.GA3637727@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 7:54 PM, Jason Gunthorpe wrote:
> On Mon, Apr 15, 2024 at 01:32:03PM +0800, Baolu Lu wrote:
>> On 4/12/24 4:15 PM, Yi Liu wrote:
>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>> index 40dd439307e8..1e5e9249c93f 100644
>>> --- a/include/linux/iommu.h
>>> +++ b/include/linux/iommu.h
>>> @@ -631,7 +631,7 @@ struct iommu_ops {
>>>    struct iommu_domain_ops {
>>>    	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>>>    	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
>>> -			     ioasid_t pasid);
>>> +			     ioasid_t pasid, struct iommu_domain *old);
>> Is it possible to add another op to replace a domain for pasid? For
>> example,
>>
>> 	int (*replace_dev_pasid)(domain, dev, pasid, old_domain)
> We haven't needed that in the normal case, what would motivate it
> here?

My understanding of the difference between set_dev_pasid and
replace_dev_pasid is that the former assumes that there is no domain
attached to the pasid yet, so it sets the passed domain to it. For the
latter, it simply replaces the existing domain with a new one.

The set_dev_pasid doesn't need an old domain because it's assumed that
the existing domain is NULL. The replace_dev_pasid could have an
existing domain as its input.

Replace also implies an atomic switch between different domains. This
makes it subtly different from a set operation.

Best regards,
baolu
