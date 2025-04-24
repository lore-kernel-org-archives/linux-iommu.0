Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424BD1E7C12
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745486574; cv=none; b=dndpR39XmE7oiJp/gudHPkwzKZ7D9feivSyBgX70OClYkIrPbHA7GXNOrGw/FGVo55b37VujmLc6iisswlHb0dApaAESKXeN96iRNrgF/Ua62bOMDQSGdHjN8PxlkuX0hr09mQtVbb2iNA3X0IlippoIRl5wu5YbLybb7mi2oZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745486574; c=relaxed/simple;
	bh=NpXitcQTmASm/c5fQevG5nSI/zUrUzZXxechrmShP0Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DHN9XtlJP/reFPWu40UltNZxhbFV+ROs/VLLTNObs72/gGJoR1zHNywczayvMvD7bUkwk+33bQwiGhXbtkUl1ZdlfEa9GOHAj+ubaZr392zkx35LFVUsZMEfHaEo5Z6WqXi7PkIS682AA397dG77JdWy5F7iOCJiztqMHdUnMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5VlDh/D; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5VlDh/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745486573; x=1777022573;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NpXitcQTmASm/c5fQevG5nSI/zUrUzZXxechrmShP0Q=;
  b=L5VlDh/DHNRdgkBvqyw+qGj4OPY0dO9CkZAsxegDEgvsm2CXtqglBCzH
   NOGHWp8JlTkWVbq2RAwJOb3/vEWCUguefur4dv7hGjH1Y7FIIOlgajuC1
   EJ5Bg9xgoa7oBm4A6ohOi6Vg7oMNIOflMHNPSN8O5TfPAr2ZUvHreDOEU
   1sOD+E8E5vLJB+4JnS4CNGI4YnR5GeEw+QpAAt3LCTLSp4VEQC6UBv7aT
   6puMkNk9SNDRFozm8VdnIG0bBjTUsyUTg4P3fnhbwBWxNkG/U9v79Z3WO
   OUzbXYekUGQt8AAc2UnHIyMrGDpmFvKM3v2oZbruggKFpw6Pdd1+62Vv+
   Q==;
X-CSE-ConnectionGUID: eOHfiUGjRrG7Frd8imW5hw==
X-CSE-MsgGUID: SictcbgUQV2qDRW9XmT+LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58101585"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="58101585"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 02:22:53 -0700
X-CSE-ConnectionGUID: A8dkvlIOSASNjeRxkDt+GQ==
X-CSE-MsgGUID: wOtGZ1fgRDKn6IpHeaPYmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="137414077"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.159]) ([10.124.243.159])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 02:22:51 -0700
Message-ID: <42e8c668-e72d-490a-8a5e-8e94af90fda4@linux.intel.com>
Date: Thu, 24 Apr 2025 17:22:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu/vt-d: Simplify domain_attach_iommu()
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
 <20250423031020.2189546-4-baolu.lu@linux.intel.com>
 <BN9PR11MB527619613B8615A94A01FF598C852@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527619613B8615A94A01FF598C852@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/2025 3:46 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 23, 2025 11:10 AM
>>
>>   	num = ida_alloc_range(&iommu->domain_ida, FLPT_DEFAULT_DID +
>> 1,
>>   			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>> -	if (num < 0) {
>> -		pr_err("%s: No free domain ids\n", iommu->name);
> 
> this error message could be kept.

Okay.

> 
>> -		goto err_unlock;
>> -	}
>> +	if (num < 0)
>> +		return num;
>>
>>   	info->refcnt	= 1;
>>   	info->did	= num;
>>   	info->iommu	= iommu;
>> -	curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
>> -			  NULL, info, GFP_KERNEL);
>> -	if (curr) {
>> -		ret = xa_err(curr) ? : -EBUSY;
>> -		goto err_clear;
>> -	}
>>
>> -	return 0;
>> -
>> -err_clear:
>> -	ida_free(&iommu->domain_ida, info->did);
>> -err_unlock:
>> -	kfree(info);
>> -	return ret;
>> +	return xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
>> +			       no_free_ptr(info), GFP_KERNEL));
>>   }
> 
> no_free_ptr() should be used before successful return. Here xa_store()
> could return error but at that point no auto free as no_free_ptr() already
> changes 'info' to NULL. then memory leak.
Hmm, I've considered this. My thought was that xa_store() failure only
occurs due to the system running out of memory, and the Linux kernel
can't recover from it. In that case, the system is already broken;
hence, handling the failure case here doesn't make things better.

Thanks,
baolu
