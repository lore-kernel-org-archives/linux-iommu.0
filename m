Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4022FDE4
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549335; cv=none; b=Y6ZoHAVZ89JT6yPCaEXeVPzOY53CCxZLltLazfa10FMigKw166waIDtMEj1F23tjAeeKowjWI9JDq6Tjwzylre0+uVY1ZUq1iQ9uLonUBT7OVybK1doBLpSWccUr27TaSlEtQ37z2RpV8EHCEUmPzOWeZAk/QyaXw775Ig0y9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549335; c=relaxed/simple;
	bh=vaKDR9hbngLiZGD+p2sJcDm1T1lwxYB0m6SR8CKiniM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTwwOa5fMPAHouDlBheerltQ7I92uy9rQWPDuBmphApuKrwUFg0LWzqlXwH3OHLZH/Y6Hl8ctaOhYLl9iRWkULTBLZ4ClaFnECoe2oB6nNQK7Cb92AUkH1gjYB1SYMOvUytbCu/y9sxrFQXXirbsuUCeh/wNXs91SFC8YR60A6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJL2ZaKb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJL2ZaKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740549333; x=1772085333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vaKDR9hbngLiZGD+p2sJcDm1T1lwxYB0m6SR8CKiniM=;
  b=GJL2ZaKbmqHLDxU79vOCmotSChyxtqazqfXQjhMMby5+4er74ScX4N4O
   MrhA0JUV5ELgRh3b3OH2wV5xOXqsllXITPAH1NKaiQ3gEIKnx+1MaC0Zh
   1pefWN2xrWAs40csaKyALydWMVZQBWqiPIC3lEPsxLuOcMJBcc2UOkgfK
   GxsA1+gYb0tNd2Q9bUanFaw7Wn8r+11sgpYHHkiSq79iuWWzHb3zvc4f1
   XtgekUasIEoGs+BnHNR1Ydrdv4Feb+cge0WU1MVQI1JjweQEQvH1biTwo
   1lGtJ6ka6wC0V0h/rfx2VFMovrLJKyohsCTph1zIijKe6qTcW1OVz2jgX
   A==;
X-CSE-ConnectionGUID: zLLeRkFSSfa0PiCOphkxpw==
X-CSE-MsgGUID: Q9MOGHUFR9SarxiMEpMwGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52018650"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52018650"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:55:33 -0800
X-CSE-ConnectionGUID: ngLwMS7AQDizina2Nsdrgw==
X-CSE-MsgGUID: SC0JhgYBRIOsgWTqvRAPvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121599573"
Received: from unknown (HELO [10.238.129.135]) ([10.238.129.135])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:55:30 -0800
Message-ID: <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
Date: Wed, 26 Feb 2025 13:55:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/2/26 13:18, Baolu Lu 写道:
> On 2/26/25 11:50, Ethan Zhao wrote:
>>>>>>
>>> If the schedular doesn't run how did we get from 4 -> 5?
>>>
>>> Maybe the issue is the shutdown handler here is running in the wrong
>>> time and it should not be running after the scheduler has been shut
>>> down.
>>>
>>> I don't think removing the lock is a great idea without more
>>> explanation.
>>
>> Seems it is not so simple job to explain why there is no race window 
>> between
>> this iommu_shutdown() and following dmar_global_lock holders.
>>
>> 1. PCIe hotplug dmar_pci_bus_notifier()
>>
>> 2. mm_core_init detect_intel_iommu()
>>
>> 3. late_initcall dmar_free_unused_resources()
>>
>> 4. acpi attach dmar_device_hotplug()
>>
>> 5. pci_iommu_init intel_iommu_init() init_dmars()
>>
>> 6. rootfs_initcall ir_dev_scope_init()
>>
>> though here is the last stage of reboot. then how about we turn back 
>> to v1
>>
>> Just repalce with own_write() with down_write_trylock().
>
> I don't think trylock is a reasonable solution. intel_iommu_shutdown()
> should not become a no-op simply because it cannot acquire a lock
> immediately.

No other CPUs is holding lock after they were brought down by sync call to

functionnative_stop_other_cpus(1).

So actually it wouldn't fail to acquire a lock.  this is also the reason why we don't

need to down_write() thedmar_global_lock.

>
> The lock here is to protect the drhd (representation of iommu hardware)
> list. It needs protection because this driver supports iommu hot-add and
> remove, which is triggered by an ACPI event for I/O board hotplug.

Yup, the lock is used to protect the global listdmar_drhd_units.

but here all IOAPIC/LAPIC are brought down, hotplug interrupts couldn't 
happend either. (only legacy and NMI are alive).

> Provided the system does not respond to those events when this function
> is called, it's fine to remove the lock.
I agree.
>
> Thanks,
> baolu

-- 
"firm, enduring, strong, and long-lived"

