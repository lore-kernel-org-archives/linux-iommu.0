Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F6313E19
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982663; cv=none; b=G4PI6R3p6baVgzMqkSkjTe94xu3ugqCW7ZBcOsBNk58VLdxIhqG22xE1LJ9ej3N54kGypcDA787gW+I6qW/cZLU8iDQ6ZNXCtawk6x2NycLBCYbjfn/iG7hwRDB+izys1GC4c83rVq+ILj1w2M9cMettCgWhkJMAs4bsAN42kVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982663; c=relaxed/simple;
	bh=0F70Ko3PBMOj4OvAJaw+lR+DFMv5QNSqKWvGUMIM7tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i45e2OHGxq2Y5tbiJWszIQE57m7fJGspyLpYqk+PBrpK7P2HR0t9hAp4f4nGYhzhos4KlucEBLSEFf5ZYB6Td4FkKJU8DLUC/LvTKGQke5RZVThtcJx8mOdwUB5VK3TMRr/QfK/cM9cO6z0X+E5IG08wrDu55eF0sdWXC7QgNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwhP3aDb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwhP3aDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768982660; x=1800518660;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0F70Ko3PBMOj4OvAJaw+lR+DFMv5QNSqKWvGUMIM7tg=;
  b=JwhP3aDbIRENlLwKWtyXlzmln1olHB/U6jpoS7FhOI33hdr4QKb6TgWF
   gwuwTprTeDdkH+t5dG+I9cTKruf5Zo2NAb/XcQZcZhNO4MSy3CzXNCSBa
   IgJmxqiuoXCAfguP/BcYgCk2LUPDTumP/2yqvOjm1nt4MnOLUCm0RqqMR
   c07NSXFSpNppwe4BKPvc7PHbQdL0zoZsWagXWJtu/beAB7Gi023YapRax
   bvlSn5GjGV7asfDR9AivQLfEdG6OkWg0+8jmEfQag4bm8xIcxqeNp8AUb
   S8MCAaA1jwKhswdaYvbpWnU7TbEvc081lqpyD/ml95NrnmqvQ0PqzQNUf
   g==;
X-CSE-ConnectionGUID: vRZOrbA+Q8qycDSPZ0swtw==
X-CSE-MsgGUID: yah1sZ1NQZ2gLB3nwy8Zow==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80508393"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80508393"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:04:19 -0800
X-CSE-ConnectionGUID: CnSkpCdbSL6IoyApM0Z81g==
X-CSE-MsgGUID: ZTJmP39aTPG7aobSaXn2gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206797213"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:04:16 -0800
Message-ID: <f5b1aa1a-5d20-40c8-9f3f-5bc37766fe75@linux.intel.com>
Date: Wed, 21 Jan 2026 16:04:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down
 context entry
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
 Samiullah Khawaja <skhawaja@google.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
 <20260120061816.2132558-3-baolu.lu@linux.intel.com>
 <BL1PR11MB5271F1F4DF8B6D4052D626088C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <a2c1531a-f720-412f-9f39-6a6b9fabe5e7@linux.intel.com>
 <BL1PR11MB5271D3AE08DAF677E44449B78C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB5271D3AE08DAF677E44449B78C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/21/26 15:50, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, January 21, 2026 3:29 PM
>>
>> On 1/21/26 14:23, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, January 20, 2026 2:18 PM
>>>>
>>>> When tearing down a context entry, the current implementation zeros
>> the
>>>> entire 128-bit entry using multiple 64-bit writes. This creates a window
>>>> where the hardware can fetch a "torn" entry — where some fields are
>>>> already zeroed while the 'Present' bit is still set — leading to
>>>> unpredictable behavior or spurious faults.
>>>>
>>>> While x86 provides strong write ordering, the compiler may reorder
>> writes
>>>> to the two 64-bit halves of the context entry. Even without compiler
>>>> reordering, the hardware fetch is not guaranteed to be atomic with
>>>> respect to multiple CPU writes.
>>>>
>>>> Align with the "Guidance to Software for Invalidations" in the VT-d spec
>>>> (Section 6.5.3.3) by implementing the recommended ownership
>> handshake:
>>>>
>>>> 1. Clear only the 'Present' (P) bit of the context entry first to
>>>>      signal the transition of ownership from hardware to software.
>>>> 2. Use dma_wmb() to ensure the cleared bit is visible to the IOMMU.
>>>> 3. Perform the required cache and context-cache invalidation to ensure
>>>>      hardware no longer has cached references to the entry.
>>>> 4. Fully zero out the entry only after the invalidation is complete.
>>>>
>>>> Also, add a dma_wmb() to context_set_present() to ensure the entry
>>>> is fully initialized before the 'Present' bit becomes visible.
>>>>
>>>> Fixes: ba39592764ed2 ("Intel IOMMU: Intel IOMMU driver")
>>>> Reported-by: Dmytro Maluka <dmaluka@chromium.org>
>>>> Closes: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>>
>>> btw there is a context_clear_entry() for copied context entry in
>>> device_pasid_table_setup(), but this patch doesn't touch that
>>> path. It seems to assume that no in-flight DMA will exist at that
>>> point:
>>>
>>>           if (context_copied(iommu, bus, devfn)) {
>>>                   context_clear_entry(context);
>>>                   ...
>>>                   /*
>>>                    * At this point, the device is supposed to finish reset at
>>>                    * its driver probe stage, so no in-flight DMA will exist,
>>>                    * and we don't need to worry anymore hereafter.
>>>                    */
>>>                   clear_context_copied(iommu, bus, devfn);
>>>
>>> Is that guaranteed by all devices? from kdump feature p.o.v. if
>>> that assumption is broken it just means potential DMA errors
>>> in this transition window. But regarding to the issue which this
>>> patch tries to fix, in-fly DMAs may lead to undesired behaviors
>>> including memory corruption etc.
>>>
>>> So, should it be fixed too?
>>
>> This path is triggered when the device driver has probed the device
>> (ensuring it has been reset) and then calls the kernel DMA API for the
>> first time. At this stage, there should be no in-flight DMAs. We can
>> apply the same logic here to improve code readability, but this is not a
>> bug that requires a fix. Or not?
>>
> 
> device could be in whatever state when kdump is triggered. I'm not
> sure whether all device drivers will reset the device at probe time.

Okay, agreed.

> Just thought that applying the same due diligence here could prevent
> any undesired damage just in case. Not exactly for backporting, but
> it's always good to have consistent logic to avoid special case based
> on subtle assumptions...

So I will add the following additional change:

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 34f4af4e9b5c..b63a71904cfb 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -840,7 +840,7 @@ static int device_pasid_table_setup(struct device 
*dev, u8 bus, u8 devfn)
         }

         if (context_copied(iommu, bus, devfn)) {
-               context_clear_entry(context);
+               context_clear_present(context);
                 __iommu_flush_cache(iommu, context, sizeof(*context));

                 /*
@@ -860,6 +860,9 @@ static int device_pasid_table_setup(struct device 
*dev, u8 bus, u8 devfn)
                 iommu->flush.flush_iotlb(iommu, 0, 0, 0, 
DMA_TLB_GLOBAL_FLUSH);
                 devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);

+               context_clear_entry(context);
+               __iommu_flush_cache(iommu, context, sizeof(*context));
+
                 /*
                  * At this point, the device is supposed to finish reset at
                  * its driver probe stage, so no in-flight DMA will exist,

Appears good to you?

Thanks,
baolu
