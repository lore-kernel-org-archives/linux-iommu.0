Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980718C02E
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882125; cv=none; b=Pn9Vki1OMQCViOQwFs/9wY9qJG2EH/5Kihete1KUxDwo3kP9HlPyXxUR1CtWMu+Rgc2+h2kGMMe6W1mJ19h4Jm5AVOfVPIyHdAA8gmR/r016Wh3u7PhjTdI5Y4YEH17PUY83WvFgX0aszrpCUoVtU9t7yYl7fbVVZyzaU3CmFqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882125; c=relaxed/simple;
	bh=3ItJv2/BgJAJIxN6gLlBx+JbCzAhh2cpkuLbg+YZXHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVHHoiyacmYFdIDwkxHmNt7CcgZfSlvBFDi/3HMPYQCyUXDMsEMIvqalxsjuCkr5qYDdNb38SO3lrQRtUn7qzSaDR7o/r4bdEfToh9NdXzK35v96OBhWSut0t9Mwikx+9qkyWPc5vqllIK/uaiV4SDNOWHsU9RhvX5Z8SWN+IlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/gGhC6j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/gGhC6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787882125; x=1819418125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ItJv2/BgJAJIxN6gLlBx+JbCzAhh2cpkuLbg+YZXHg=;
  b=l/gGhC6jQFX+DwFuupZu7e35Q/qHQJEa2YuaHJUueJF9Zz2YHagr2cWy
   PXOLF+Vgli/b/Eg+hVzpeWzkneL3ZzrO+EKufH6YBcVtO+GYXd/1JpPhI
   g6B6oDHg7PY2cfiyZh1yIe4ORDi+jJA3efWEjlHL7fe8FVWwJqaXmMdws
   eaTwaZnEmiNJWrQ2KZestYGOmi/qqC9be+MLddpoimETa09IqKcBpBiyj
   jYwhr6oXvXmEu0ndRhzoCxvMbamUZ3ILIgSWvJeVXpdTt0L7q7MDTJ/lU
   oX6ssK/eFACGcqRfZsUneAKJ+y+HgB/j+U8nR9mOjUsCi3nnR5F50B1RS
   g==;
X-CSE-ConnectionGUID: J28XU+MYR7OkQ7myTJnOTQ==
X-CSE-MsgGUID: 78TZUKbaRxGXEm7lLT1rbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="105763894"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="105763894"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 18:55:24 -0700
X-CSE-ConnectionGUID: 0a9MWnyBTTinWhFKyQ9mUQ==
X-CSE-MsgGUID: htKevwVMSUyWlskwe4Lr0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="291520749"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 18:55:20 -0700
Message-ID: <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>
Date: Fri, 28 Aug 2026 09:55:18 +0800
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
>>> +    ret = domain_reattach_iommu(dmar_domain, iommu, device_ser);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    info->domain = dmar_domain;
>>> +    info->domain_attached = true;
>>> +    spin_lock_irqsave(&dmar_domain->lock, flags);
>>> +    list_add(&info->link, &dmar_domain->devices);
>>> +    spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>> +
>>> +    if (!sm_supported(iommu))
>>> +        intel_iommu_enable_pci_ats(info);
>>
>> Could you please clarify the PCI ATS behavior across live update?
>>
>> My understanding is that PCI devices may bypass reset during kexec and
>> are then re-initialized by the new kernel (is that correct?). If so, ATS
>> state in hardware would depend on its state before kexec in the old
>> kernel.
>>
>> In a normal reboot, ATS is expected to be disabled and the device ATC is
>> empty. But that assumption may not hold for live update. If that is
>> true, can we still use the same approach to keep hardware ATS state and
>> info->ats_enabled in sync?
> 
> Regarding ATS, it remains enabled in the preserved device during kexec
> and we should keep it in sync with the info->ats_enabled here. We might
> have to disable it in the next kernel if it is unsupported (or disabled
> globally) in the next kernel. I will put those changes here in next
> revision.

That looks reasonable to me. I have no concerns about keeping ATS
enabled on preserved devices across kexec reboot, as long as the
software state is synchronized in the new kernel.

By the way, is disabling ATS an option? The current design already
requires disabling PCI/PRI during kexec, right? If so, nothing
functionally depends on ATS at that point. Maybe we should apply the
same policy to ATS as well (i.e., disable ATS and PRI at the same time)?

Thanks,
baolu
