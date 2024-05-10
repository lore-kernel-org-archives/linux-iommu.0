Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEDA2E3E8
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351418; cv=none; b=H5EF7PFYB5RWRnM4YEP3MwNWoPyOIBGpMxnZkC6cNI7+VsEDv0WcVsbcUvxq8rObz7pU1gU88rugvHa/lBLzINY0MCPEPi5sq72OmCsxXGNjtmu1uSl9VHHHJacgUg45y8rWBZBfql8UCEKoyqxlCjPijAaPstIVSRQqH8qiq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351418; c=relaxed/simple;
	bh=LIbQqBfXiUQWjgKPgqrUUa+UphuLCLU3qDB80BDLpXQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U2tUNvNJtgP8NYorNZrqoriaMejWhXvkjHErcd5yhCN8zhvp9HB8PFYQ5Uf1WUTV/MBURuTfp0Uq1uWjXdc8jBedgFJL4K4lk60M6+xmzDCnqZniEuzTLv8PXBBPzQLoOwMFAg8UAlqiBBwnEcEipa0c08NpP8OenKJpzrDjqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giAE+TPP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giAE+TPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715351417; x=1746887417;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LIbQqBfXiUQWjgKPgqrUUa+UphuLCLU3qDB80BDLpXQ=;
  b=giAE+TPPAv+GjGGCjwmsJSmM1sZ5uAWU9C2p5qaYVcvpLKCihDbw6vk8
   NoleWiRm5OOjr29e7k2F5w/XNUUcY8upgvGWC09IMIKzU7hyogU87nf+B
   0XFuAYYeixO6rp+Yh4cNqGANSvs4J5XfbfW/3mnMSawFm+/pJGXIVtw9V
   FhJf03QZP/RkWVgudVCXqpstfmAcF6HHo98ZK4uHAT7DKRlB8pR605yZb
   hA/EoS7g5vJBv2hy4lFUMgnvUOVr3R4rQ8ibAa0tJn9EyaQeSBuY0IynD
   yXg/rVNlH9Cx0QPt2Cy+Oeee0SY4xWoUvQOTv+qmA0Ew1nsSpJObrUb0K
   A==;
X-CSE-ConnectionGUID: Ybv6ygDTRuGDWTgQBqAr6A==
X-CSE-MsgGUID: 90PpcNbnS7qRkZl0/Qtnow==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11183763"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11183763"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:30:16 -0700
X-CSE-ConnectionGUID: HTI9vF/7RI2VfKszHrCNuw==
X-CSE-MsgGUID: WxrUp9inRAi5T4Vg+dNe/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34147847"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:30:14 -0700
Message-ID: <0de7c71f-571a-4800-8f2b-9eda0c6b75de@linux.intel.com>
Date: Fri, 10 May 2024 22:30:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
 <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
 <20240510133824.GW4718@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240510133824.GW4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/10 21:38, Jason Gunthorpe wrote:
> On Fri, May 10, 2024 at 11:14:20AM +0800, Baolu Lu wrote:
>> On 5/8/24 8:04 AM, Jason Gunthorpe wrote:
>>> On Tue, Apr 30, 2024 at 10:57:04PM +0800, Lu Baolu wrote:
>>>> @@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>>>>    	if (group == &abort_group)
>>>>    		goto err_abort;
>>>> -	group->domain = get_domain_for_iopf(dev, fault);
>>>> -	if (!group->domain)
>>>> +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
>>>> +	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
>>>> +		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);
>>> That seems a bit weird looking?
>> Agreed.
>>
>>> get_attach_handle_for_iopf(dev,
>>>      (fault->prm.flags &
>>>      IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ? fault->prm.pasid : IOMMU_NO_PASID,
>>>      group);
>> The logic here is that it tries the PASID domain and if it doesn't
>> exist, then tries the RID domain as well. I explained this in the commit
>> message:
>>
>> "
>> ... if the pasid table of a device is wholly managed by user space,
>> there is no domain attached to the PASID of the device ...
>> "
> Okay, it needs a comment in the code, and the RID fallback should be
> based aroudn checking for a NESTING domain type which includes the
> PASID table. (ie ARM and AMD not Intel)
It appears that Intel is just special. ARM, AMD, and RISC-V all support
a NESTING domain which includes the PASID table. So, how about defining
a special NESTING domain type for Intel? Like this,

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 35ae9a6f73d3..09b4e671dcee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -173,6 +173,8 @@ struct iommu_domain_geometry {

  #define __IOMMU_DOMAIN_NESTED  (1U << 6)  /* User-managed address 
space nested
                                               on a stage-2 translation 
       */
+#define __IOMMU_DOMAIN_PASID   (1U << 7)  /* User-managed domain for a
+                                             specific PASID*/

  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
  /*
@@ -204,6 +206,9 @@ struct iommu_domain_geometry {
  #define IOMMU_DOMAIN_SVA       (__IOMMU_DOMAIN_SVA)
  #define IOMMU_DOMAIN_PLATFORM  (__IOMMU_DOMAIN_PLATFORM)
  #define IOMMU_DOMAIN_NESTED    (__IOMMU_DOMAIN_NESTED)
+#define IOMMU_DOMAIN_NESTED_PASID                              \
+                               (__IOMMU_DOMAIN_NESTED |        \
+                                __IOMMU_DOMAIN_PASID)

And current IOMMU_DOMAIN_NESTED domain type is just for a nesting domain
with PASID table.

The Intel IOMMU driver will convert to use IOMMU_DOMAIN_NESTED_PASID in
the PASID interface series.

> We shouldn't just elevate a random PASID to the RID if it isn't
> approprite..

If above propose looks good to you, then I just need to add a domain
type check before RID fallback.

Best regards,
baolu
