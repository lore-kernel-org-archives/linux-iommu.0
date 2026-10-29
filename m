Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317143;
	b=HEvmrjxJdVM27YEKbok6UOxfRiqrGiOG4RoVMWsWk5utrbstByc0In8QbuEad8UbBjN8
	 fXdR/5gr/Kh6/tukc6c6jFZSnBnRvWCedtF8smNatY1s49jJHRHAdeez694OhkE6osE0W
	 1U+z7ECCq80TlH1g/35dbaLprKEQ/zc3Xt8kRZMh/JD7Kz+x0qfYs7fPl94WDuDuPy3F9
	 PsCPUXPLXVBWgYK4v6Pc5vFVQ2SpcbI3giwwXvIApHxNHQTxvWfvjXkAzZmWDO76in9nG
	 8tMhoyo9+H+tsuXxV/vt2Hz0VRgn4dXeAABPidBzBKrENTOUAqefwn4fDtmiGxA3TFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317143;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MayldR3d8IBms4sVIuPTrWKB+Oa3RX5tIH6ZU2Vm3LE=;
	b=L7kWQrfRVSDKES8LUA9frKnckBhmju3jMuOuV+h0am7ccIcQCkL8tAk+2+miPkF2y9z/
	 GYEJHSjeZDnVQlC+Ne8gZYf5VACyp2Ko6OIQrb3Bh9aQ6N/lrGE0nhQcgbnMGvZf3EXNF
	 U+cAQglgwbbEA9coCw2whZFWVCWU1eWKWa/MA/EvesLY+N9lL4djpUFgBLw/+YqhxS3/6
	 rD1d2JGBF2xy3Rt2m8SBByMp2lf1eBXbZNzyW4FED3jMfm/borYdu1Ow2cXT93EiaFsb6
	 xVT0EG40f0vrkpIy6EvYHttY84q/oxRdRnaOdYhbnDyxDFzVQp1cZfbK6SCgjENXXPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MK0gWIIa;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F9606A31D
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 23:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE1F9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MK0gWIIa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793317142; x=1824853142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GNvLU2yIbeuFnhRZLILES5O2I5YTIoobPa6rjUCSEeQ=;
  b=MK0gWIIawDVpyTainvGL0I7vuosxQ3oDHbHzsx4O18s85C8EirIRXvZt
   gQ8NbbfSJfSs2++XWurpUZiTTho1ZynQygJGyW1PH2xdQEgksnqw8nMiH
   8DbADNrB0BWDa/9voWG76G4SUw46+DzrqBQBagsJci6LzXyNQW4CWGVVZ
   R59493a+6q3qeMl3gaUtKPVjPcwG5644IQSjsN9U1eUuHuN37FUrhZuPu
   SvjUl3i6s1kMcftFfpCoJiw1J5LOF2kttmeQQRtRewrb8LDbEpe1PTvgD
   3J84qnOTAMV+bCq5QwcmLjr9bteYNwRz1qiYid5q1jq4aSjJcT7igsbRI
   g==;
X-CSE-ConnectionGUID: QrFVcQ3FRRikvclgRVIFDQ==
X-CSE-MsgGUID: p3/kQek0RmWi6+TxIU9aHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1977209"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1977209"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:39:01 -0700
X-CSE-ConnectionGUID: PdH2IR+CRvSD3D3BEWZMZQ==
X-CSE-MsgGUID: ONzVjv/3Si2P4nSEocDSlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5614172"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:38:57 -0700
Message-ID: <84fe2789-7bbc-436e-9141-e879d2e90ef9@linux.intel.com>
Date: Fri, 30 Oct 2026 07:38:54 +0800
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
Subject: Re: [PATCH v6 13/18] iommu/vt-d: Handle reattach of the restored
 domain
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-14-skhawaja@google.com>
 <faeedd16-a271-4ced-be1a-7bd70860bcdc@linux.intel.com>
 <auPC2pByvuW5uHyH@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <auPC2pByvuW5uHyH@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/26 06:34, Samiullah Khawaja wrote:
>>> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/ 
>>> liveupdate.c
>>> index 36816d3651e6..665ebb81bd61 100644
>>> --- a/drivers/iommu/intel/liveupdate.c
>>> +++ b/drivers/iommu/intel/liveupdate.c
>>> @@ -394,6 +394,137 @@ void 
>>> intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
>>>                iommu->name);
>>>  }
>>> +static void domain_detach_restored_iommu(struct dmar_domain *domain,
>>> +                     struct intel_iommu *iommu)
>>> +{
>>> +    struct iommu_domain_info *info;
>>> +
>>> +    guard(mutex)(&iommu->did_lock);
>>> +    info = xa_load(&domain->iommu_array, iommu->seq_id);
>>> +    if (--info->refcnt == 0) {
>>> +        xa_erase(&domain->iommu_array, iommu->seq_id);
>>> +        kfree(info);
>>> +    }
>>
>> This seems to be different from normal domain_detach_iommu(), which
>> looks like this,
>>
>>        if (--info->refcnt == 0) {
>>                ida_free(&iommu->domain_ida, info->did);
>>                xa_erase(&domain->iommu_array, iommu->seq_id);
>>                kfree(info);
>>        }
>>
>> why ida_free() is skipped in the restored path?
> 
> The restored device can be removed and probed again while the PASID and
> context entries stay intact. So the restored did is not freed in this
> path. Once the domain is reclaimed by the iommufd, then it takes the
> normal detach path.

Can you please add a comment to explain this?

Thanks,
baolu
