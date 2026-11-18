Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988178;
	b=3HztTtKqWIBfZqUWUU2Feu9FbbVcX7sDjbnOEXfHxWa+644SnEciSrUswIsB85gzpZgy
	 2uZtWWrGrbxBQJ86N8eBPKCRLpouFSB+EqUQYSw162T3i3ZDqPcOuBw0HpxF+VutgPTvw
	 Dki9pgayWC3gVFhQiOb4zlHxoJgWkC0cNgEe3ed4Bei+wOWjroAXWu6RzJ5S5yBZja/ww
	 g0UPu1wiEzDHcHcrg77gPnhpznbhdWiDyNS6tc7SHQ12zk2c6J5Jv0I3pc70oCVPt8CfR
	 ys31MQRspRwjIIstuaZkJoVcRt9A96X0UUv0sImKFgWOelXanfkktrSUKVihDmRSWzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988178;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ESPCsoEPtuCXM1f1Dh5TyCaDd7FuNNWEbBXa4uabGnQ=;
	b=MxAB3JxIQ8YMNiautGZ5OzV1KWRoFfq9OPfASWHY9v3D4GolZovj6GSCD3S7ORjyXI/W
	 9u010rB+aLG1cPXcgSutoJ3J1ghz0+fyYneG8ojP6jnjjc3kI7tRISbQ9lKcEKqK9KtB6
	 viuXTAyY7cJzcen/Ll6VadiizpXDHfXKmBT9zkWI+lWTHW34n4gOTvx3Wf2HckG0/Ba6v
	 KhgzdHIBRIJjj/xOiDCMpO7Q4Zo2JjRvOsM6uSYiDPiBpnN0wPqvuURrdUlDPakVn3loB
	 5UhQqE1reKi+qGU71lcA+DzDTHo1GEm0Kah9w1mG5+t9GVeukBjadP7iCjGYwvo2Svw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YAr8hA5N;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D5606A31C
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 07:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E5D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YAr8hA5N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794988177; x=1826524177;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C3BJLvclQYCeUdc56oRM38yDtB84CMxhqig1w0q6W7I=;
  b=YAr8hA5Na1JuGU4kb/wRc5rJOxIDQYI2xWYbywKPePjN8MsnManET6ny
   kjF8XonC16IwfzgWOeL98YNuBNg5+EPruGc/6JERV90MKJrGOKpsehpJY
   4RYo+XbXL7MBoelalmn/2HEtwOdiwP0sjYUrW1WBfaCaMQzLGQx4s/HPY
   6Z0+/y+islLbiWeQFjeaJX47SCuNCVYMfF3so7VfnJwvunP+eAnHqIlZl
   teXnMpBvkR8t+cm/Vjj6oi7XLyORoIiX13I2o72Xiv8Z2NUlLzrG64uUF
   Su9SsEIGHSr277tmx6cNfq16KbxrWkE8Qniy1yJJD7MsdGcK1yfYcd5wX
   Q==;
X-CSE-ConnectionGUID: JmmMuR9jSMGl/6wKbbHK2w==
X-CSE-MsgGUID: JcuILXwCS1WceFsUKVavsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3679531"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3679531"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:49:36 -0800
X-CSE-ConnectionGUID: ebXOhVNTRZ6lgBbDHIlbqA==
X-CSE-MsgGUID: sJzLRkfxSJCmG5AMr6tPag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9866875"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:49:32 -0800
Message-ID: <19551f22-84cd-4256-a24b-f26c61502368@linux.intel.com>
Date: Wed, 18 Nov 2026 15:49:30 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Danny Gonzalez <digonzal@google.com>, David Decotigny <decot@google.com>,
 Sheena Mohan <sheenamo@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20261117180122.GA427856@bhelgaas>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261117180122.GA427856@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/2026 2:01 AM, Bjorn Helgaas wrote:
> [+cc Danny and others because this is related to ongoing work at
> https://lore.kernel.org/all/20261020181053.2646782-1-digonzal@google.com/]
> 
> On Sun, Apr 07, 2024 at 09:14:29AM +0800, Lu Baolu wrote:
>> Commit 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
>> devices") adds all devices probed by the iommu driver in a rbtree
>> indexed by the source ID of each device. It assumes that each device
>> has a unique source ID. This assumption is incorrect and the VT-d
>> spec doesn't state this requirement either.
>> ...
> 
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4299,9 +4299,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>>        }
>>   
>>        dev_iommu_priv_set(dev, info);
>> -     ret = device_rbtree_insert(iommu, info);
>> -     if (ret)
>> -             goto free;
>> +     if (pdev && pci_ats_supported(pdev)) {
>> +             ret = device_rbtree_insert(iommu, info);
>> +             if (ret)
>> +                     goto free;
>> +     }
> 
> This change is upstream as 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in
> iommu probe path"), but I think there's a problem here.  Previously
> the rbtree insertion was unconditional, so the unconditional remove in
> the error path was correct.
> 
> After 89436f4f5412, the rbtree insertion is conditional.  If
> intel_pasid_alloc_table() fails, we try to remove it even though it
> may never have been inserted:

info->node is initialized with RB_CLEAR_NODE() before the insertion, and
the remove helper checks RB_EMPTY_NODE() before erasing. If insertion
was skipped, removal is a no-op, so this error path does not need
another state check.

> 
>>        if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>>                ret = intel_pasid_alloc_table(dev);
>                  if (ret) {
>                          dev_err(dev, "PASID table allocation failed\n");
>                          goto clear_rbtree;
>                  }
>      ...
>      clear_rbtree:
>          device_rbtree_remove(info);
>      free:
>          kfree(info);
> 
>> @@ -4336,7 +4338,8 @@ static void intel_iommu_release_device(struct device *dev)
>>        struct intel_iommu *iommu = info->iommu;
>>   
>>        mutex_lock(&iommu->iopf_lock);
>> -     device_rbtree_remove(info);
>> +     if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
>> +             device_rbtree_remove(info);
> 
> This is also somewhat problematic because it relies on the assumption
> that pci_ats_supported(X) always returns the same value it returned in
> intel_iommu_probe_device().  That may be true today, but I don't think
> you should rely on it.

Agreed. The release path should not re-evaluate pci_ats_supported().

> I think both issues could be solved if intel/iommu.c kept track of the
> rbtree insertion itself, e.g., with a bit in struct
> device_domain_info.

Sure. I will address this with a follow-up patch.

> 
>>        mutex_unlock(&iommu->iopf_lock);
>>   
>>        if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
>> -- 
>> 2.34.1
>>

Thanks,
baolu

