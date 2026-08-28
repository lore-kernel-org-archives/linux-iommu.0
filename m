Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889A1A38F9
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881381; cv=none; b=gcFvnBTWot3QOpwP2TqoP3JFysSdQzAB6/5Kd74gsxP5rlGkaop7wXjAf/XVUyAb50VEiyZTa5hr1xZL9rYZzo9SVxyEfZZBGFHIVQFsJf62G8j15aDMNCwh8bDvlvMYmE94g0h4ZhsJsjNpfTDzvZHNR5A7KaRefzL0WTDeD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881381; c=relaxed/simple;
	bh=vqaChCZkyZZZIvsTx/SEe3/93qR/OjmGOLlRobYJrM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mR2sdpuoCwiT12gcG7ZyN/2R5XflJZgHCXnMqxbWXr9LBIxNhjZNUJej/Su01Do6QelMXGceeEFWg9A0VmTfutldkMq/fQ+RHJaQ56YFr5ugs3ZZPQ57TldrHau9VeOM77D4TjRmTngd8QK8pSahamSEe2amnA+/Ua4HUO2nqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Syw0EC8U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Syw0EC8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787881380; x=1819417380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vqaChCZkyZZZIvsTx/SEe3/93qR/OjmGOLlRobYJrM0=;
  b=Syw0EC8UIxZ5iayRqddt3/WncL5gzCHT44e7av3tvzd5N8DhUCXXbC0A
   Ejzw8K35VTL6rScvE0SW6MnHmrmpZydFZg96EHqN5jjj4m/IRP2jnpPPJ
   oSJmfdJb38ebg13VayVLn7x3ofhFbwV1Y7Stiy7cLrneVyVc12fXYgDR4
   tASCZsisHcuefhvZRS7YBE8AjPKq/k9ogogCRNoy+qmCucvqa5K2sTRH+
   V2ktBdm9Ick+5xRRhoGxs5UvmsXrnnIRZXX6NVdg8XKmebVaEeztj/7RG
   /W+QT1IF6Qz2drQ71p9gm3R38Ep9ee1v8i5KzrtznZ2xkEKm83jlEWUYR
   g==;
X-CSE-ConnectionGUID: BNpxi365QleUCDT8Qm1dlg==
X-CSE-MsgGUID: +YUbrmnYQ76KaZs53I92yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92074066"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="92074066"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 18:43:00 -0700
X-CSE-ConnectionGUID: Xgwwq5bnRCKnKggV6d4E0g==
X-CSE-MsgGUID: +JgdhPQqSEOJuQsCaeqAPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="264256923"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 18:42:56 -0700
Message-ID: <1849b176-4aa4-437f-8dd1-b91993f73b4d@linux.intel.com>
Date: Fri, 28 Aug 2026 09:42:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
 domain
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
 <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
 <apBso6So7UqwR3AX@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <apBso6So7UqwR3AX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/26 01:52, Samiullah Khawaja wrote:
>>> +
>>> +static int domain_reattach_iommu(struct dmar_domain *domain,
>>> +                 struct intel_iommu *iommu,
>>> +                 struct iommu_device_ser *device_ser)
>>> +{
>>> +    struct iommu_domain_info *info, *curr;
>>> +    int restored_did;
>>> +    int ret;
>>> +
>>> +    if (!iommu_domain_restored_state(&domain->domain))
>>> +        return -EINVAL;
>>> +
>>> +    restored_did = device_ser->domain_iommu_ser.attachment_id;
>>> +    if (!ida_exists(&iommu->domain_ida, restored_did))
>>> +        return -EINVAL;
>>
>> It seems that checking only whether the domain ID is reserved on this
>> IOMMU may not be sufficient. It would be safer to also verify that:
>>
>> - device_ser->domain_iommu_ser.iommu_phys matches iommu->reg_phys, and
>> - device_ser->domain_iommu_ser.domain_phys matches @domain.
>>
>> ?
> 
> Interesting.. The caller of this attach from core fetches the correct
> domain based on the checks you mentioned. But you are right, adding a
> check here makes sense to prevent anyone else calling attach with a
> mismatch.

If the iommu core has already verified the domain-device relationship,
then we probably don’t need to duplicate that check in the iommu driver.
Maybe just add a short comment above this function stating that
validation is done by the iommu core?

Thanks,
baolu
