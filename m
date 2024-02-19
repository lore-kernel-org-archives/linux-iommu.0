Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34269B65A
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708320816; cv=none; b=kbfJjntaItcf1dvVRNOEofasni00lBxvDJFxUNETbcOp/Rl8h/HIYveCSPNW5WbY35t+90/GCL/SnICNygA19XVUtFhbMIbd6rbZXbTUHV9JokPK5FRG6GWubvY40plp5oPwqszFnuxkju5DJhcYQhO0VV+OrgbLM7z+jWn1Y+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708320816; c=relaxed/simple;
	bh=I1Jfd/8FIBp70O+sFzRnE2xgDFNHERXYc1sStRHBxtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKlIpT/me4Q90lMgK2vdsgQXdOe+qn5u5SHwTYGAnv11XE4f6v0YVS8CdkSofF8rdqhKTpczxQbaY5Gi2fgIG4zCk1AEGDfBdBFC0KVu/2cQjzK0loaPMJbP1YtYEi3DdeO0tA2dEXO2sSCRgASyfDWJ6vv9pQbWzvQ/W/QWZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEwmBkUl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEwmBkUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708320815; x=1739856815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I1Jfd/8FIBp70O+sFzRnE2xgDFNHERXYc1sStRHBxtA=;
  b=kEwmBkUljHugpZobXTbdHKigBqktt/cTsv8THOC0wMR85OSKyeZrWIs0
   vC3jdqXMzu1xdL23kFDQ3T9A14IqOaWASh7egYzRuwHLFPlrptsT6MbmO
   CLhmfIKXt2s0PDaJUHbI5WXe/deMK5iTiPszmjSYth2UkJe86BvQbaUtG
   OgJKdqDs1O8o/DHkNpPUyKdzC2n+/LUfwkV7FjlhTqVPbIVBYrVuamTW5
   gotz18ga6B49V3nnVb2QBuH/iX966jdPriiqIJ6+yGcPc0eUzZxOsJ2t1
   ys+yBw8XZ9MTUYnkdvyEIvvxo7MtdVyqKHw/rIx1h6T65G/DtlP6A4W6m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="12933036"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="12933036"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 21:33:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="826950509"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="826950509"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.209.179]) ([10.254.209.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 21:33:31 -0800
Message-ID: <ba137a34-68d1-4f61-a6dd-30841610c079@linux.intel.com>
Date: Mon, 19 Feb 2024 13:33:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/vt-d: Use rbtree to track iommu probed devices
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Huang Jiaqing <jiaqing.huang@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-2-baolu.lu@linux.intel.com>
 <eace2ec0-0b8b-450d-b05f-7b7ca3e473a7@linux.intel.com>
 <942dd645-7475-4c43-99c6-304601fb09eb@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <942dd645-7475-4c43-99c6-304601fb09eb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/2024 12:04 PM, Baolu Lu wrote:
> On 2024/2/19 10:45, Ethan Zhao wrote:
>>> @@ -4264,25 +4313,34 @@ static struct iommu_device 
>>> *intel_iommu_probe_device(struct device *dev)
>>>       }
>>>       dev_iommu_priv_set(dev, info);
>>> +    ret = device_rbtree_insert(iommu, info);
>>> +    if (ret)
>>> +        goto free;
>>>       if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>>>           ret = intel_pasid_alloc_table(dev);
>>>           if (ret) {
>>>               dev_err(dev, "PASID table allocation failed\n");
>>> -            kfree(info);
>>> -            return ERR_PTR(ret);
>>> +            goto clear_rbtree;
>>>           }
>>>       }
>>>       intel_iommu_debugfs_create_dev(info);
>>>       return &iommu->iommu;
>>> +clear_rbtree:
>>> +    device_rbtree_remove(info);
>>> +free:
>>> +    kfree(info);
>>> +
>>> +    return ERR_PTR(ret);
>>>   }
>>>   static void intel_iommu_release_device(struct device *dev)
>>>   {
>>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>> +    device_rbtree_remove(info);
>>
>> Perhpas too early here to remove dev from the rbtree, if it is wanted in
>> devTLB invalidation steps in intel_pasid_tear_down_entry().
>
> Perhaps the caller of device_rbtree_find() should not depend on the

I didn't catch up here. seems have to maintain the lifecycle as PCI subsystem
does, or there would be mutli instances for the same BDF(e.g. the device is
removed then plugged, again and again.....in the same slot) in the rbtree ?

> order in the release_device callback. For the device TLB invalidation
> timed-out case, probably it could be checked in this way:
>
>     struct device *dev = device_rbtree_find(iommu, ite_sid);
>     if (!dev || !pci_device_is_present(to_pci_dev(dev)))
>         return -ETIMEDOUT;

looks much advanced with such infrastructure !

Thanks,
Ethan

>
> Best regards,
> baolu
