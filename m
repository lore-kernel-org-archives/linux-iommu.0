Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793424435;
	b=rJf4Vb78UtQ9CpkbDOqsd1tCsIPY4WyLh3D06Ejtexd9wkQvanrD6Vx14aMxnTreBnKl
	 nspHSdONXwhAdZonPbU+gqUXPr29WhKWjOlyDvoLWmBlz+RHG/8rwXXBBEsJoJlzBl2yE
	 qTpCwLNi7IGh+0914nQTDEay87KbMYSyC6MBeSoM51Z7v0Tpp66IETKd3QmeyPPQAe8cT
	 3gZ58Y8x/LmRIJ5RCBuwelpgbDEwm52dmBa3+n8+00wDTibhbtyJsIEN3/6s9wAGs0XqV
	 wrjgbp3UTatmg4vKPUhwKdEh7Mgqo8WIlv3m8OVCqAnBkVHMrpoWfzr+DeGXHf+e0rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793424435;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sJ1i2sB19WjZsWpCLPMyCnOc+WH6sAraGwOCsPP3qWk=;
	b=Cn5T6RDMQIf+KRYUPVYuPKF1BpInZhLpnIM6yurI8XHYOwjdQaExfHPRUur2LZUfbXH6
	 vtpP84jG8e4aKieEouzlficqPw8wrphnHbkFtMTDZ/fRntJ6weon11KZA0EJ75GpYMNaj
	 hEVwx0kBLyYpJcNl7TxTYuCVRK8D4OMRLMwPPS/RPFSwqtymGzRcw4BBezjxwRLaUPaLl
	 tMDmugDFzqpRvvHlCjT3NcyYGowpMQMtZPgxx32ONDQuhn+1oRvwzUpHQRmXs9PBdsGVd
	 zAeJ7p2UG8Alvk8ul7Fly9Ad/N4nrU36CCchLFHERLnlK3gx/YforK+/SmE0O5Bcrdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U6+0nqv7;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD819606A31D
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 05:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD819606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U6+0nqv7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793424434; x=1824960434;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HorgvWPM7Wg7lJRLSZ/w7jpsG9fGBf5ZSc6uneNyf3A=;
  b=U6+0nqv72QIpc2fEPdQxl37/PzV5q2/hD5yxHH5Pv2zSceIHN9INyYgS
   GeWvVCoE+7qGre8nwfmQqLglY1uvkIhU4pp09yX2Y6uLM46IpmSBPEKPA
   0uCt0gYW6u6vR7CFequC9rX90OuIBAPWsoB83tgGBGmhVHAZLckcm0ql+
   usgS672L6VWm6s8Dx48tBpxmcn+mM3CO1PY25R2H4dZThy0dE3pDB7aSG
   gWxwjQ9XR1H98x/M9xXAi9wl6HxxGvk6gFTBTlsiavg/f6LNfnKEBee0E
   HmaPzgHhe0vWc0U2oEQV1T/mRg/684wkVcrr50KMbGuPY2rTb9Ef9tGma
   Q==;
X-CSE-ConnectionGUID: +b/Klh89Sy6fijkMwo/lfA==
X-CSE-MsgGUID: AzkfFCiZSCCH82WbTTrAhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2069154"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2069154"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 22:27:13 -0700
X-CSE-ConnectionGUID: CpMzmVyzRTmwuefiKAjO9A==
X-CSE-MsgGUID: uS7oy4RhQLqJhtXiqh+oLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5994163"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 22:27:08 -0700
Message-ID: <7b059c0e-3b60-4d8c-b7d2-7dcb89a51c6f@linux.intel.com>
Date: Sat, 31 Oct 2026 13:27:05 +0800
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
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 05/18] iommu: Implement device and IOMMU HW
 preservation
To: Samiullah Khawaja <skhawaja@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-6-skhawaja@google.com>
 <df75f891-05a0-4d47-8705-d6a00c81ff97@linux.intel.com>
 <auTzN4NWuKsBvIZU@google.com>
 <51b23019-8ac2-4f6b-9be7-29f3635b472e@linux.intel.com>
 <auVfqaDhk25JUkYd@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <auVfqaDhk25JUkYd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/2026 11:39 AM, Samiullah Khawaja wrote:
> On Sat, Oct 31, 2026 at 11:04:22AM +0800, Baolu Lu wrote:
>> On 10/31/2026 9:45 AM, Samiullah Khawaja wrote:
>>>>> +
>>>>>  #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
>>>>>  void iommu_device_unregister_bus(struct iommu_device *iommu,
>>>>>                   const struct bus_type *bus,
>>>>> @@ -626,8 +668,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>>>>>  static int __iommu_probe_device(struct device *dev, struct 
>>>>> list_head *group_list)
>>>>>  {
>>>>> +    struct group_device *gdev, *gdev2;
>>>>>      struct iommu_group *group;
>>>>> -    struct group_device *gdev;
>>>>>      int ret;
>>>>>      /*
>>>>> @@ -661,6 +703,13 @@ static int __iommu_probe_device(struct device 
>>>>> *dev, struct list_head *group_list
>>>>>          goto err_put_group;
>>>>>      }
>>>>> +    for_each_group_device(group, gdev2) {
>>>>> +        if (dev_iommu_has_preserved_state(gdev2->dev)) {
>>>>> +            ret = -EBUSY;
>>>>> +            goto err_free_gdev;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>>      /*
>>>>>       * The gdev must be in the list before calling
>>>>>       * iommu_setup_default_domain()
>>>>> @@ -697,6 +746,7 @@ static int __iommu_probe_device(struct device 
>>>>> *dev, struct list_head *group_list
>>>>>  err_remove_gdev:
>>>>>      list_del(&gdev->list);
>>>>> +err_free_gdev:
>>>>>      __iommu_group_free_device(group, gdev);
>>>>>  err_put_group:
>>>>>      iommu_deinit_device(dev);
>>>>> @@ -3543,6 +3593,26 @@ bool iommu_group_dma_owner_claimed(struct 
>>>>> iommu_group *group)
>>>>>  }
>>>>>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>>>>> +/**
>>>>> + * iommu_group_is_singleton() - Query if group contains exactly 
>>>>> one device
>>>>> + * @group: The group.
>>>>> + *
>>>>> + * Return: true if group contains exactly 1 device, false otherwise.
>>>>> + */
>>>>
>>>> We discussed this interface before, and the consensus was that such an
>>>> interface is not feasible, because the membership of an iommu_group is
>>>> not fixed, given the hot-plug support of buses like PCI.
>>>>
>>>> I am fine with the usage model of ensuring the iommu group of a
>>>> preserved device to be a singleton, but I don't think we even need such
>>>> a kAPI. It should be handled case by case.
>>>
>>> The iommu_group membership can change, this is why we check it in two
>>> places, both under group->mutex:
>>>
>>> - During preservation we check that the group is a singleton, and check
>>>   again after setting device_ser.
>>> - During probe we refuse to add a device to a group that has a preserved
>>>   device.
>>>
>>> So if a device is added to the group while we are preserving, either the
>>> probe fails because the group already has a preserved device, or the
>>> preservation fails because the group is no longer a singleton. Could you
>>> please elaborate what you mean by handling it case by case?
>>
>> I am fine with the singleton-group checking logic you described above,
>> but I don't think we need a helper like iommu_group_is_singleton(). It
>> drops group->mutex before returning, so its result may already be stale
>> when the caller uses it. That makes it easy to misuse in the future.
>>
>> I'd prefer to open-code the check where group->mutex is already held, as
>> iommu_attach_device() does today:
> 
> struct iommu_group is private to drivers/iommu/iommu.c, and
> iommu_preserve_device() is in liveupdate.c, so open coding it there is
> tricky.
> 
> You are correct that it drops the lock before returning. That is why I
> recheck the singleton state after setting device_ser, which handles the
> race.
> 
> I was thinking of adding something like iommu_group_lock() and
> iommu_group_unlock() for this, but the number of devices check also
> needs struct iommu_group definition.
> 
> To avoid misuse, I can add a comment on iommu_group_is_singleton() that
> the result may be stale and the caller must recheck. What do you think?

I would suggest something like this:

size_t iommu_group_device_count(struct iommu_group *group)
{
         size_t count;

         mutex_lock(&group->mutex);
         count = list_count_nodes(&group->devices);
         mutex_unlock(&group->mutex);

         return count;
}

and, add a comment stating that the device count may change after the
function returns, so the caller must recheck it.

Thanks,
baolu
