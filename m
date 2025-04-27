Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063A19D06A
	for <iommu@lists.linux.dev>; Sun, 27 Apr 2025 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745730878; cv=none; b=Dhdn3M70XZEY6IguXdKgAvYwXzGjkmrI9zIqaD2hPCVa7uqLgv07uNQhvx1UvT13ucE7OD9KUEBQ+iCug3jbHZ9HH3hYAajQlccqdx/fmDQYdJbd3YombL9qinPcZsHBdYn4w0nZSd+D/YSR4LNbmSCxbWLAYdjnhNOTV12a8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745730878; c=relaxed/simple;
	bh=jkBLzN2drb+fa2jLDURCQoV3/FrHTdVbdplP8s7EN14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GE6Njw/ybIH+MXa3rs7s/IWkWabMJI+rxgJDDGSrr1PyH5FZqB5Eac3clYbCOWvs7lj3wSUsirghngcw5QHFcOhLWibzmR4cff2S1I6mv3LI46AmRubr5GULQxvj6xOH2TSaWuqLifVWOosBssZj5c39C+dvXPqb8+BeRUTvoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4I025Hw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4I025Hw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745730877; x=1777266877;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jkBLzN2drb+fa2jLDURCQoV3/FrHTdVbdplP8s7EN14=;
  b=k4I025Hwq9gzeVbOyMeh0LxgGg/6IUBkRKBSYym8lQlsIjeGNTmO3dJy
   PIAqMtxIJbz9EAi9L77A5cixBEi/E5+rQ8w2n9Yz0d8zODXBVI8X74Yyl
   C70e+Rmuv6qlj+5wzOEiePZXuhbD2JgoRpmu30XMdo4ldH+u/shTzspmt
   wAD1OPG9HhSBsBZMep590yJafOLBQMHPhdJAAbxWQLTVbo4Q+x867EI9s
   /zKPWRhTika5LU0P693N17EP3Lh3Fdvi+qDX1ayxT4CDFwULR6LK8igzz
   zgZLH8uD40gy7yqB9XmzHndI/IFH2KONwtcEJeNN/J0H0aEvfCapFZlKJ
   w==;
X-CSE-ConnectionGUID: DLY/+0IKRR2Rka1q+Bxk8Q==
X-CSE-MsgGUID: ia/SIyoaSyOqJi1ceCdMvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="34956139"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="34956139"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 22:14:36 -0700
X-CSE-ConnectionGUID: 4+peumw0T/SilcU3U+0Ezg==
X-CSE-MsgGUID: IGh30APlRTq38v9Kp8sAgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="133758639"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 22:14:33 -0700
Message-ID: <8373789b-929e-4ad9-ab0b-6ec620719a7e@linux.intel.com>
Date: Sun, 27 Apr 2025 13:10:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu/vt-d: Simplify domain_attach_iommu()
To: Dan Williams <dan.j.williams@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
 <20250423031020.2189546-4-baolu.lu@linux.intel.com>
 <680bd94098249_1d522945b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <680bd94098249_1d522945b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 02:49, Dan Williams wrote:
> Lu Baolu wrote:
>> Use the __free(kfree) attribute with kzalloc() to automatically handle
>> the freeing of the allocated struct iommu_domain_info on error or early
>> exit paths, eliminating the need for explicit kfree() calls in error
>> handling branches.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 29 ++++++++---------------------
>>   1 file changed, 8 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 3a9ea0ad2cd3..12382c85495f 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1337,13 +1337,14 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>>   
>>   int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>>   {
>> -	struct iommu_domain_info *info, *curr;
>> -	int num, ret = -ENOSPC;
>> +	struct iommu_domain_info *curr;
>> +	int num;
>>   
>>   	if (domain->domain.type == IOMMU_DOMAIN_SVA)
>>   		return 0;
>>   
>> -	info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +	struct iommu_domain_info *info __free(kfree) =
>> +		kzalloc(sizeof(*info), GFP_KERNEL);
>>   	if (!info)
>>   		return -ENOMEM;
>>   
>> @@ -1351,34 +1352,20 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
> [..]
>> -err_clear:
>> -	ida_free(&iommu->domain_ida, info->did);
>> -err_unlock:
>> -	kfree(info);
>> -	return ret;
>> +	return xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
>> +			       no_free_ptr(info), GFP_KERNEL));
>>   }
> 
> This pattern looks like it wants a "xa_store_or_{reset,kfree}()" helper that
> handles both canceling a scope based cleanup and taking responsibility for
> error-exit-freeing @info in one statement.
> 
> I.e. this is similar to a:
> 
> 	"return devm_add_action_or_reset(..., no_free_ptr(obj), ...)"
> 
> ...pattern.
> 

Yes. Perhaps adding a xa_store variant would be beneficial in all
places that require this pattern.

Something like this?

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 78eede109b1a..efbdff7ebda4 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -626,6 +626,35 @@ static inline void *xa_store_irq(struct xarray *xa, 
unsigned long index,
         return curr;
  }

+/**
+ * xa_store_or_kfree() - Store this entry in the XArray.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @entry: New entry.
+ * @gfp: Memory allocation flags.
+ *
+ * This function is like calling xa_store() except it kfrees the new
+ * entry if an error happened.
+ *
+ * Context: Process context. Any context. Takes and releases the xa_lock.
+ * May sleep if the @gfp flags permit.
+ * Return: The old entry at this index or xa_err() if an error happened.
+ */
+static inline void *xa_store_or_kfree(struct xarray *xa, unsigned long 
index,
+               void *entry, gfp_t gfp)
+{
+       void *curr;
+
+       xa_lock(xa);
+       curr = __xa_store(xa, index, entry, gfp);
+       xa_unlock(xa);
+
+       if (xa_err(curr))
+               kfree(entry);
+
+       return curr;
+}
+
  /**
   * xa_erase_bh() - Erase this entry from the XArray.
   * @xa: XArray.

Thanks,
baolu
