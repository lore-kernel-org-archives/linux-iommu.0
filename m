Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859051;
	b=bC2s69R+sS78cVo9QhdysdZt2zq1lQWG9iAQsgksYM0OyFNfYDl+cFk3vUVVk00uAQUR
	 dbaGQPKySaSxIB0Z/hVoTl2uD1mctu2PbeQ/cCkL/dtUIkPf7INcaHL1Yr7vOiJ4Nljk1
	 EdQtjOKeTB3sVE32XjVTsyITtBQWzJo+ccvT8PLXxWi0hnsWI5qe6VMX1ylKvqswuAGB3
	 GaDzeMEwWW11igf6ghiGgVxAuCzluJeHiRY8bwAJf/aTeNMXU9YCUbS+Yuq9KgQDQgms3
	 Vkz/DI2v4yQNg3kSX7Xvo3C7UnLTzgCg4a75PksCE2pCSTZVlPZYAmFceHzJrmlHZhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859051;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+5BTrBne3OQ1DvExgeoc8tKlSX9T8xOtBCF+DWKH+FQ=;
	b=tiZozTnDnMrl6Hvxiu3i74666BrFzAFh6voIQAWAi6W0ZYmxdt/t2kZ+kHv49jAtTkB4
	 vvuCN9SChUrSsdr/hJT9oJfl8Xt0/fdSKwF1jSwF+43e2td5v4vczZ7xXwCBLYZHOySes
	 v+BmVzPrxElDFB/AsaFYnGIdjKwqkLuPijV7Pei3rRt6IE5xMlMSphUwlC0VTVh0e8vOv
	 ytpjuoDiunoidmMsfnU1Ux50KjxE3fILs2UiZyI0GStLlPEK672phxR+RitnGJeeOUSnX
	 Odj4JJMatqSEkx5EKsJJElrzZdhT6KtdPuHn7TYO58+mac6//H/hi5u/vKB0D86yang==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bng7nz7Y;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506E606A31B;
	Thu,  5 Nov 2026 06:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8506E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bng7nz7Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793859050; x=1825395050;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=baB3kBDGVPEF+a5Is1SFhYiKMmbqMXCz7Q2FtU0s8D4=;
  b=Bng7nz7YZBg9sceE8w7hBkmKDt6uonJfUFqqLRbur33eUhybSyGb0sZk
   wNlAPUWSKnPBXndhPfA4RXYJ5KVyGte95xihgYSD3A7Ca/6YkM6Sfq5un
   8pNQZQuUMD0IQM+Azgfpd08XnzmDHWrQPnyBvUOxk1WkxLwdpSfS0ljlj
   4KyY0fhfYg/SrNzOcIwFGWNHW5riMxbqQh15gAywDpjyt5DzvAdAOK//S
   4UdGI+0vL4/6mYxaZsO0Afo5DbCQGrVIlLejslzjxaRgt7c0VeOSGkVU4
   8Xj2LanCbpdAuc7E8yZB0b3sTSQkUaApWgXnc9sS6FAaD27BaECp5Uad9
   A==;
X-CSE-ConnectionGUID: 7I5irVrOS8yoyGgvhCFRng==
X-CSE-MsgGUID: 88504i0jRJqqe9SUZVHXuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2672477"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2672477"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:10:50 -0800
X-CSE-ConnectionGUID: 2YwIL/d2QmiYsRKmhMHdQg==
X-CSE-MsgGUID: pj4yiNuLRi6ZKOjNbx1kyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8688640"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:10:46 -0800
Message-ID: <f60d1d10-b2cb-465d-8588-a61d26bbd648@linux.intel.com>
Date: Thu, 5 Nov 2026 14:10:44 +0800
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
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Kiryl Shutsemau
 <kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050> <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
 <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
 <23a3c630-a3ad-4874-b13c-b8795cd194a6@linux.intel.com>
 <CO1PR11MB48354B1C84A6BD16CA2FFCA88C652@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB48354B1C84A6BD16CA2FFCA88C652@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/2026 12:07 PM, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Monday, October 19, 2026 4:12 PM
>>
>> On 10/16/2026 3:17 PM, Tian, Kevin wrote:
>>>>     - The TDX Connect architecture places requirements on the host
>>>>       iommu driver while the secure IOMMU is being set up. For example,
>>>>       the host iommu driver must block the enhanced command (ECMD)
>>>>       interface while the TDH.IOMMU.SETUP SEAMCALL runs, and it must
>>>>       reserve the upper half of the domain ID space. These steps have
>>>>       to happen atomically under the iommu driver's own locks. As a
>>>>       result, the Intel iommu driver needs to merge the two steps above
>>>>       into one.
>>> Didn't get this. Both ECMD and DID reservation are TDX specific things.
>>> How are they related to the two steps in the ARM sides and why calls
>>> for merging?
>>>
>>> and why are they must be done atomically? they are conditions to
>>> execute TDH.IOMMU.SETUP, but it is perfectly fine to reserve DID
>>> at an early point then block ECMD later...
>> You are right, "atomically" was too strong. Only the ECMD block has to
>> bracket TDH.IOMMU.SETUP. So I plan to restructure it as follows:
>>
>> - dmar_tdxcs_init_prepare(dev, &params): resolve the device's DRHD and
>>     take a reference on its secure-mode state. For the first user,
>>     validate the preconditions (TE/QI/SM enabled), reserve the upper half
>>     of the DID space (failing with -EBUSY if any of it is in use), block
>>     ECMD and return what tdx-host needs (register base, NUMA node, etc).
>>     If the unit is already in Secure TDX mode, just report that so
>>     tdx-host skips TDH.IOMMU.SETUP.
>>
>> - dmar_tdxcs_init_done(dev, result): unblock ECMD, then either mark the
>>     unit as being in Secure TDX mode or roll back (including the DID
>>     reservation), based on the SEAMCALL result. It must be called
>>     whenever init_prepare() returns success.
> We should continue blocking ECMD after the IOMMU successfully
> enters the TDX mode.

Updated.

Thanks,
baolu
