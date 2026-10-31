Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793415871;
	b=Q61Vc4E025P0X7GdD9NXfLdMoQ1EniYAZxrE+St51rRB0EyQvzp9XSGB+9qZux96YxkZ
	 z+bwZPu/Vv/AXIn8d/KbbRqTtW46m5y94RtpwwucSHYS/bV0gtfriPsE4g3TpiqeoCLYQ
	 dWFgX7eUcYtam7M1RUz4mY0overtqTlv34jSyIrXoHB39gB9RKQtS9LGEp3cdVO0JF/0Z
	 ohZpdoRCA0YzsiDhIWbcUmiLcII0Duh3DHSPuayV5Pko3+RP3SABlszPg7MXA0L/yv1aJ
	 PI4ZE4bW/QAxeyelL0K6LPk0uI6gDM50AQmtcgUtpAy7VP2E61Zqk0LMe5Pp7dCez7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793415871;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3YgTZfTBPM4eMDGzEAhi2Dp4kfn7QE5y0ZrKAUvpyTM=;
	b=LcOvAF0AZagLt3BzQRS6tyWbYl/3I3CRpBH9WOvc7raxDvtmvmT417lvQcT5IrgWlzjK
	 xjUKea7P5bKC2Z3eyP8AgfYnoaJEcrX+OE8uEZ06hH4vG4OiS95qUcehDDh/C1s19dGgD
	 x29kO29qhBd8s2zQxLMklI29HDYSK1W5iXTyLCV0MAMiaK5iiiavEcCgqfAPqYZTwVPl9
	 1JXy15MvWxyiyNN1sI+RWcRc/DLZciOkZ7z9KPE3hI2BurO/ydNHSHjMTjVlpwDVPgcZM
	 dfP4I3kFXz9ABkZYFir+vVkTXOWR+QOnvGEPh7MlmzZ7bC4LjetplvHcsoXzAmPRDLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="nTMo/PAz";
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B3606A31A
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 03:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C8B3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nTMo/PAz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793415870; x=1824951870;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nenY67vOpzs+Xp4QoMffKUCUDUputbOBuu37QyGRUFg=;
  b=nTMo/PAzAtxBIFq9+ufVFVB1cy62bJDG/tYzu4aHQ9SvXPjeP3kiUnUl
   5yQhYprJSpkl8Q4tz/9Gmf6KjTXQksIAdCe+L/JQ05zzNoXAJAZQ2kO+9
   OrHPmg8Jd8Qcf1/MPNK6ZqVvBT+JiJ85LSBVodiZJU1uHS5jTQrDQ3BmK
   gyU4u+zzh4+8XftUk7x2kgAQ+NU2G33CasHJWOQ0j45dd7lnbdQO+cGQc
   V/26/DcUbIJNZRXxHY4vx9kxnbJqh4+HOu++doFuJvRFCp6v53zOLUNiQ
   RorI8ORCJCkzq1NOYoo3QDR3XL294Qk7CgJU5njIULJKP6EFD6ZWQjuqh
   A==;
X-CSE-ConnectionGUID: F+EJe8YvRjCatuLl8Ny26A==
X-CSE-MsgGUID: N6mmQhVvSZaIrKr4yFkcZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2195975"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2195975"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 20:04:29 -0700
X-CSE-ConnectionGUID: hU+Xx/n+Sm6qqo+QmDycWQ==
X-CSE-MsgGUID: O9ItPWDiTuSaE/mUJW4+nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5481030"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 20:04:24 -0700
Message-ID: <51b23019-8ac2-4f6b-9be7-29f3635b472e@linux.intel.com>
Date: Sat, 31 Oct 2026 11:04:22 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <auTzN4NWuKsBvIZU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/2026 9:45 AM, Samiullah Khawaja wrote:
>>> +
>>>  #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
>>>  void iommu_device_unregister_bus(struct iommu_device *iommu,
>>>                   const struct bus_type *bus,
>>> @@ -626,8 +668,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>>>  static int __iommu_probe_device(struct device *dev, struct list_head 
>>> *group_list)
>>>  {
>>> +    struct group_device *gdev, *gdev2;
>>>      struct iommu_group *group;
>>> -    struct group_device *gdev;
>>>      int ret;
>>>      /*
>>> @@ -661,6 +703,13 @@ static int __iommu_probe_device(struct device 
>>> *dev, struct list_head *group_list
>>>          goto err_put_group;
>>>      }
>>> +    for_each_group_device(group, gdev2) {
>>> +        if (dev_iommu_has_preserved_state(gdev2->dev)) {
>>> +            ret = -EBUSY;
>>> +            goto err_free_gdev;
>>> +        }
>>> +    }
>>> +
>>>      /*
>>>       * The gdev must be in the list before calling
>>>       * iommu_setup_default_domain()
>>> @@ -697,6 +746,7 @@ static int __iommu_probe_device(struct device 
>>> *dev, struct list_head *group_list
>>>  err_remove_gdev:
>>>      list_del(&gdev->list);
>>> +err_free_gdev:
>>>      __iommu_group_free_device(group, gdev);
>>>  err_put_group:
>>>      iommu_deinit_device(dev);
>>> @@ -3543,6 +3593,26 @@ bool iommu_group_dma_owner_claimed(struct 
>>> iommu_group *group)
>>>  }
>>>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>>> +/**
>>> + * iommu_group_is_singleton() - Query if group contains exactly one 
>>> device
>>> + * @group: The group.
>>> + *
>>> + * Return: true if group contains exactly 1 device, false otherwise.
>>> + */
>>
>> We discussed this interface before, and the consensus was that such an
>> interface is not feasible, because the membership of an iommu_group is
>> not fixed, given the hot-plug support of buses like PCI.
>>
>> I am fine with the usage model of ensuring the iommu group of a
>> preserved device to be a singleton, but I don't think we even need such
>> a kAPI. It should be handled case by case.
> 
> The iommu_group membership can change, this is why we check it in two
> places, both under group->mutex:
> 
> - During preservation we check that the group is a singleton, and check
>    again after setting device_ser.
> - During probe we refuse to add a device to a group that has a preserved
>    device.
> 
> So if a device is added to the group while we are preserving, either the
> probe fails because the group already has a preserved device, or the
> preservation fails because the group is no longer a singleton. Could you
> please elaborate what you mean by handling it case by case?

I am fine with the singleton-group checking logic you described above,
but I don't think we need a helper like iommu_group_is_singleton(). It
drops group->mutex before returning, so its result may already be stale
when the caller uses it. That makes it easy to misuse in the future.

I'd prefer to open-code the check where group->mutex is already held, as
iommu_attach_device() does today:

int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
{
         /* Caller must be a probed driver on dev */
         struct iommu_group *group = dev->iommu_group;
         int ret;

         if (!group)
                 return -ENODEV;

         /*
          * Lock the group to make sure the device-count doesn't
          * change while we are attaching
          */
         mutex_lock(&group->mutex);
         ret = -EINVAL;
         if (list_count_nodes(&group->devices) != 1)
                 goto out_unlock;

         ret = __iommu_attach_group(domain, group);

out_unlock:
         mutex_unlock(&group->mutex);
         return ret;

}
EXPORT_SYMBOL_GPL(iommu_attach_device);

Thanks,
baolu
