Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21664176248
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658261; cv=none; b=to7bQxCS3chijEog32Ohck9uVxJ0c0QYewChnDS1+vqR4KPqQjgFUAs2t2F82IDgouryuiWcxJKlAY5CGOdNgvYpzTehztkud1CWykckRmIAJ2oIDRlXfdn/oqRc9cBA9UHFDlXMY5pLAYpGtorzVqVUq3YeJBVKhaZtw1/DMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658261; c=relaxed/simple;
	bh=IF+uOHS1Yh3wSLzJpiC0yW+gJj7j6acT0GmLW0UFFLA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qPy5WnRWVkXOm/s0qJX7l00D73J2AouunpZsyB8VSKvoywS92pa1Rlk/TXCj+aNM2QaHd94a3Obw7AtM5dpMgGqoF2oFhsif8VMD7bw8WmX81zGlsn8ouMzxpy6OV6lLyh9XCrzCQ3kyfwsE7gS0MPoN7oI+4J6bvO8ensGOgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIjHGc2Z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIjHGc2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726658259; x=1758194259;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IF+uOHS1Yh3wSLzJpiC0yW+gJj7j6acT0GmLW0UFFLA=;
  b=eIjHGc2ZMYuoxgrTAzy1P5Wzp3h9cYR5PyvuY7kPg3vRT2Nsw61bHFso
   Qv/9veFcWeVV6MioI1KW23HJ7EmZzDVqFKCj/Ye4x1gG2bFMVMElWV/9U
   CED2RfZeNUAY33cDe/u89DhDTv6recmafIhb8FssD9r8ep+rfPMLL2hGs
   4rFNWxAJ6wW8eCSpdE5+F4pbci3j+NuPdjv/S/z/1S1VeJCzwSVkNK9vM
   nM4FMxm2Kvqwye3SmXji3HUUfWQgDaG6hJobjOYoK+DBtII5aStOs643D
   gE5uOctjMs44bBb15rvMiUH/287E4PZn9nlrmAAFkdDCXVhnDkrc3v7oO
   w==;
X-CSE-ConnectionGUID: RzCsjcm2QRmG/a3CFFA+hg==
X-CSE-MsgGUID: fCwEbETuSoCYWPFFhTvuwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="13573471"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="13573471"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 04:17:37 -0700
X-CSE-ConnectionGUID: Mw4BS6K6QoSJ3dKK+PlNmw==
X-CSE-MsgGUID: +xWHocPeQYqfXr9ZKsA4xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="100340582"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 04:17:35 -0700
Message-ID: <c54a15d8-fe60-480c-9156-bd77114c196c@linux.intel.com>
Date: Wed, 18 Sep 2024 19:17:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "j.granados@samsung.com" <j.granados@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen <its@irrelevant.dk>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
 <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
 <BN9PR11MB52769D1D1FEA9BAF0E6D19718C622@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769D1D1FEA9BAF0E6D19718C622@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/18 16:20, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Saturday, September 14, 2024 1:50 PM
>>
>> On 2024/9/14 10:53, Tian, Kevin wrote:
>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>> Sent: Saturday, September 14, 2024 9:18 AM
>>>>
>>>> On 9/14/24 8:52 AM, Tian, Kevin wrote:
>>>>>> From: Joel Granados via B4 Relay
>>>>>> <devnull+j.granados.samsung.com@kernel.org>
>>>>>>
>>>>>> From: Joel Granados<j.granados@samsung.com>
>>>>>>
>>>>>> IO page faults are no longer dependent on
>> CONFIG_INTEL_IOMMU_SVM.
>>>>>> Move
>>>>>> all Page Request Queue (PRQ) functions that handle prq events to a
>> new
>>>>>> file in drivers/iommu/intel/prq.c. The page_req_des struct is now
>>>>>> declared in drivers/iommu/intel/prq.c.
>>>>>>
>>>>>> No functional changes are intended. This is a preparation patch to
>>>>>> enable the use of IO page faults outside the SVM/PASID use cases.
>>>>> Do we want to guard it under a new config option e.g.
>>>>> CONFIG_INTEL_IOMMU_IOPF? it's unnecessary to allocate resources
>>>>> for the majority usages which don't require IOPF.
>>>>>
>>>>> Baolu?
>>>> The OS builder doesn't know if Linux will run on a platform with PRI-
>>>> capable devices. They'll probably always enable this option if we
>>>> provide it.
>>> hmm then why do we need a SVM option? In reality I haven't seen
>>> a platform which supports IOPF but no pasid/SVM. so the reason
>>> for whether to have an option should be same between IOPF/SVM.
>>>
>>> IMHO the point of options is to allow reducing footprint of the kernel
>>> image and many options are probably always enabled in distributions...
>> To be honest, I would hope to remove the SVM option some day. It's
>> nothing special except listening to an external notification and
>> synchronize the caches when the page table is updated.
> more than that... for each IOMMU the current code allocates 16 pages
> and 1 hwirq. Those are unnecessary burdens in majority deployments
> which don't support/require I/O page faults.

Yeah! I only focused on the kernel binary size but ignored these system
resources consumed by IOPF. Then, perhaps

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index f52fb39c968e..847a5c43c9dc 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -97,4 +97,7 @@ config INTEL_IOMMU_PERF_EVENTS
           to aid performance tuning and debug. These are available on 
modern
           processors which support Intel VT-d 4.0 and later.

+config INTEL_IOMMU_IOPF
+       depends on IOMMUFD || INTEL_IOMMU_SVM
+
  endif # INTEL_IOMMU
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index c8beb0281559..c382307ae7aa 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
  obj-$(CONFIG_DMAR_PERF) += perf.o
  obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
  obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
+obj-$(CONFIG_INTEL_IOMMU_IOPF) += prq.o
  ifdef CONFIG_INTEL_IOMMU
  obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
  endif

?

Thanks,
baolu
