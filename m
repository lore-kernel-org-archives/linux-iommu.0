Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32472F34
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 04:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252741; cv=none; b=HaqobJ4VSNn5qw9ijxzZvGoWm4v1nNLA/RsJS7gVuH5iPc+SmvBClclH5Dv9WMcGxWXevs+yL2ZAwyMSNb1sBOC2ZlBoQ1TXCyCNye5AvyqOZcSwIVAojzxGvtEOTB4cJ2AyzD+vJ7PCboUSpOwc2ggTHYkJw2soyLBas6+QDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252741; c=relaxed/simple;
	bh=zX+jRNQ+a555huSmEGAMNFubMd0Bt5uQ73a96jcFDzY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XH+X+rZlOhDn5hJ0g7C6d4E0A/6t8yJkohj8DkcBAtSYSHrEpysdwWJlNCC5RXLthWzEX659kScn3WiExPAx1qYMoBfbOBULsq3YoPr5bVRsWeM+r/+dU8hZ6kJFLEpp5gTRre4DORHrzOeAMOSeKcoBW1fRXXoqLyoZtPJCsY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlCHHpsT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlCHHpsT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718252740; x=1749788740;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zX+jRNQ+a555huSmEGAMNFubMd0Bt5uQ73a96jcFDzY=;
  b=DlCHHpsThk+XQ2QpA+fQwa20qX2yRlOsSbP/40MSQLhwtIP6V3ZO09GS
   uz0VMtR0xmsWNapE3oWzABIK0NhqxxfHAwBRvD82GvhYxW77WblQWuyzJ
   4Q7CcE9qdn2itO3tRhn8KsX4CQagTLfMGWn827uk5CqEAUyDfT2LFoYi8
   5IM8zz54Amj9LpbHWa5mfFgklCLACb4D6MhXeHREiqt81bhfAXb4E01uu
   4JII6d9dH550uFpriSFRTzlfTzferGJ2H3WmXpaizKx9dchWcLw9/zQ1+
   rzrIvX7Jl7STGHrfqDlfzgzHU90DnmhUnRl84yP7U342Kpp2qjRB56U07
   Q==;
X-CSE-ConnectionGUID: jIwfrxwFRgORQYYVLpmZQg==
X-CSE-MsgGUID: p+qO9r0xRHaA6pOaAv4mhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26163598"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="26163598"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 21:25:39 -0700
X-CSE-ConnectionGUID: NlmSv4PPSdG4CIIC18aTtQ==
X-CSE-MsgGUID: 3ZXeQl4SSWaRGvJB4ZZZFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39969433"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 12 Jun 2024 21:25:35 -0700
Message-ID: <013afe9a-756f-4c85-baa1-977bea6be395@linux.intel.com>
Date: Thu, 13 Jun 2024 12:23:17 +0800
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
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
 <20240612133732.GW791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612133732.GW791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:37 PM, Jason Gunthorpe wrote:
> On Mon, May 27, 2024 at 12:05:10PM +0800, Lu Baolu wrote:
>> @@ -206,20 +182,49 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>>   	if (group == &abort_group)
>>   		goto err_abort;
>>   
>> -	group->domain = get_domain_for_iopf(dev, fault);
>> -	if (!group->domain)
>> +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
>> +		group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
>> +							       fault->prm.pasid,
>> +							       0);
>> +		if (IS_ERR(group->attach_handle)) {
>> +			if (!device_iommu_capable(dev, IOMMU_CAP_USER_IOASID_TABLE))
>> +				goto err_abort;
> 
> I'm not excited about calling a function pointer on every fault. Let's
> just add a constant flag to iommu_ops?

Yes, it's reasonable given this is a critical path. How about below
additional change?

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 16b3a2da91ef..69ea4d0374b9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -253,12 +253,6 @@ enum iommu_cap {
          */
         IOMMU_CAP_DEFERRED_FLUSH,
         IOMMU_CAP_DIRTY_TRACKING,       /* IOMMU supports dirty tracking */
-       /*
-        * IOMMU driver supports user-managed IOASID table. There is no
-        * user domain for each PASID and the I/O page faults are forwarded
-        * through the user domain attached to the device RID.
-        */
-       IOMMU_CAP_USER_IOASID_TABLE,
  };

  /* These are the possible reserved region types */
@@ -557,6 +551,10 @@ static inline int __iommu_copy_struct_from_user_array(
   * @default_domain: If not NULL this will always be set as the default 
domain.
   *                  This should be an IDENTITY/BLOCKED/PLATFORM domain.
   *                  Do not use in new drivers.
+ * @user_pasid_table: IOMMU driver supports user-managed PASID table. 
There is
+ *                    no user domain for each PASID and the I/O page 
faults are
+ *                    forwarded through the user domain attached to the 
device
+ *                    RID.
   */
  struct iommu_ops {
         bool (*capable)(struct device *dev, enum iommu_cap);
@@ -600,6 +598,7 @@ struct iommu_ops {
         struct iommu_domain *blocked_domain;
         struct iommu_domain *release_domain;
         struct iommu_domain *default_domain;
+       bool user_pasid_table;
  };

  /**
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index a629d8a93614..cd679c13752e 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -189,7 +189,9 @@ void iommu_report_device_fault(struct device *dev, 
struct iopf_fault *evt)
 
fault->prm.pasid,
                                                                0);
                 if (IS_ERR(group->attach_handle)) {
-                       if (!device_iommu_capable(dev, 
IOMMU_CAP_USER_IOASID_TABLE))
+                       const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+                       if (!ops->user_pasid_table)
                                 goto err_abort;

Best regards,
baolu
