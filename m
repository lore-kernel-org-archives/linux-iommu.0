Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5407A38C
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726276089; cv=none; b=MqwgDTsvnOZrq+ys+uklJvyo1T7oma085BIK35PrZNDTorzMld2B6cxEhch+d5BcyjALthbvgilSWgCedIu5w0iGKhrbVpPl2RUcZ54QHkay6mlVN5YZsrxidSIIjNM1kBWolzvNRcYjn5HLZz6Bza02c885rIfE6XwxedbtBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726276089; c=relaxed/simple;
	bh=zGY/mIkGG5qxKcLcXnttn2C3bfVA0AUr+zNVXxjp8tg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pW9Uc4RfzaybXK/FHs3IhL/NlrEMw9tHvrVQGNVd3Bf+QLBLaM5I6loq6gyEpbj91w49JWJJcUhg6pJeqaWeXWSyfIjQ6ZY24QDKYKOxbcIuDBwOyjsGooQKP7b1QE9dkgYd0QFly8SQBaZGuFsA/5QmhRY3T5c+4rMfYRHB0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1gWI6qz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1gWI6qz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726276087; x=1757812087;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zGY/mIkGG5qxKcLcXnttn2C3bfVA0AUr+zNVXxjp8tg=;
  b=V1gWI6qzOpFrraxSQMwUk9OFjbR3ugZVjAZ57XblLqmrti54Yu/h5sUt
   vv/4FVkBz/T0A65O6I7DtzT26PuNrx2a5xlI+ZscjaZqvl2Azqkcyk5Hf
   6D4IplM96TySYYKbjlQR3zIDo9Qqvrt8omX6sizL+Co7MKKGNaNw0Y6lI
   v+kvLpUrgmxWZuZMTsRqLK3phdtmLMou4hq1cMcVUNMK6yK3O3Wdg9PzH
   9dc1IxgO/jMtMCyAT96R5ldltFiSueSLYJvBNyuJW+Lx1KrrByasRPETR
   ur5EHjqiBvbEiWH6GbDqizxIKtbTtN/XBfwVsp8XNB8rymo9y6e1fLK4r
   Q==;
X-CSE-ConnectionGUID: NUUTokGyQ7+v207nNZQ9XA==
X-CSE-MsgGUID: FgzaI3vtTbqwqG5F3yqspw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25345601"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25345601"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 18:08:06 -0700
X-CSE-ConnectionGUID: 9hVOxyxqQ2SMpBezbcXUWQ==
X-CSE-MsgGUID: /U6k5pabRHKfxZ5lNCIqBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="68500892"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 13 Sep 2024 18:08:03 -0700
Message-ID: <735498cd-1e5a-496e-8f0c-09c09ffb7db2@linux.intel.com>
Date: Sat, 14 Sep 2024 09:03:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, zhenzhong.duan@intel.com,
 linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-4-yi.l.liu@intel.com>
 <08e6739e-762f-4552-adbe-52259747c813@linux.intel.com>
 <69398a64-6c2a-40a0-a088-5fdde956f9da@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <69398a64-6c2a-40a0-a088-5fdde956f9da@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/13/24 8:21 PM, Yi Liu wrote:
> On 2024/9/13 09:42, Baolu Lu wrote:
>> On 9/12/24 9:04 PM, Yi Liu wrote:
>>> @@ -4325,24 +4363,18 @@ static int intel_iommu_set_dev_pasid(struct 
>>> iommu_domain *domain,
>>>           ret = intel_pasid_setup_second_level(iommu, dmar_domain,
>>>                                dev, pasid);
>>>       if (ret)
>>> -        goto out_unassign_tag;
>>> +        goto out_undo_dev_pasid;
>>> -    dev_pasid->dev = dev;
>>> -    dev_pasid->pasid = pasid;
>>> -    spin_lock_irqsave(&dmar_domain->lock, flags);
>>> -    list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>>> -    spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>> +    if (old)
>>> +        domain_remove_dev_pasid(old, dev, pasid);
>>>       if (domain->type & __IOMMU_DOMAIN_PAGING)
>>>           intel_iommu_debugfs_create_dev_pasid(dev_pasid);
>>>       return 0;
>>> -out_unassign_tag:
>>> -    cache_tag_unassign_domain(dmar_domain, dev, pasid);
>>> -out_detach_iommu:
>>> -    domain_detach_iommu(dmar_domain, iommu);
>>> -out_free:
>>> -    kfree(dev_pasid);
>>> +
>>> +out_undo_dev_pasid:
>>> +    domain_remove_dev_pasid(domain, dev, pasid);
>>>       return ret;
>>>   }
>>
>> Do you need to re-install the old domain to the pasid entry in the
>> failure path?
> 
> yes, but no. The old domain is still installed in the pasid entry
> when the failure happened. :)

I am afraid not. The old domain has already been cleaned up by
intel_pasid_tear_down_entry(). Or not?

Thanks,
baolu
