Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9225EA934
	for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724378883; cv=none; b=SU35NXSnkLrcmlia19Qd0zNV9p6bZ3eaGY/1h++77Z4txBnU86x+3e5Jfeb0HhICePxQXmtYc3PQjktxadlfqN3oUHN4HssRqUd6Pdys/bouvsCbGbvRhyoKu9DgQjOmrenJtWM9+luU+9jACjh4P8+2RDQ0iMHHCdxRjGvKwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724378883; c=relaxed/simple;
	bh=/uTfRhhPb0PeT5OfPqqz6WsG14q0H3SJgfpdxwTiSUo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O0yvVo3ne31J9UFxw6w8o4Yky2dvuB7xjhBVghYXzp7UpgmJgmt/b7yxFgtI3PTVugO9x/puJvbpC4vD72zUBVy47ohqRbjr46NATCf3rEommqi5zEHlvQ9m0FCna2WDFN0qv0fM8wOa5e+bgT0Vvu4sQbrSh3JM6WN5eeM2gmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bL3dsPdU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bL3dsPdU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724378881; x=1755914881;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/uTfRhhPb0PeT5OfPqqz6WsG14q0H3SJgfpdxwTiSUo=;
  b=bL3dsPdUHaPpnncCCoLzn7nrt+VYl4jL0F8STbt+StebbLcd7m53iRnX
   /MKrVSsLThppdRVMPENV2BlI96YZ2zNuMT3UbMKjmz8dW2PVx29AKHvwe
   ir5gHzU0wLWI5w0F8H4jwkyidX/8L/mauMXu+LfersyWBGVDADaVFSQ7q
   DiJClW06SKOB6B8oYPCa/i8dljW6neB/UJp7Hdu2uzSu6OaCa2Dtmd1Ts
   LSOpMqsRwXx5NV4PYbucZINEYXzA2RcDWP9PkJGXpYChHQygJ9EYT9vba
   9FF8K9SkXIsBjG5078J2qpzxEqFJX9iJRDAndwhcuyc1HxWUqT9g2axgp
   g==;
X-CSE-ConnectionGUID: OC6/UCvRQymkKqpqUcHe1Q==
X-CSE-MsgGUID: iiojyN3ORsWYwGFUsRp7Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33494483"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="33494483"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 19:08:01 -0700
X-CSE-ConnectionGUID: wWDZqf7dRZibPmp6u754vw==
X-CSE-MsgGUID: lmfjIZpwTD+4ADj+DC9GMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="66474015"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 22 Aug 2024 19:07:58 -0700
Message-ID: <16249f39-e148-40d4-91f4-af9147a5f56b@linux.intel.com>
Date: Fri, 23 Aug 2024 10:04:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Vasant Hegde <vasant.hegde@amd.com>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <a85e4bc3-0046-46fd-91e4-bac451574d11@linux.intel.com>
 <20240822124021.GB3468552@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240822124021.GB3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 8:40 PM, Jason Gunthorpe wrote:
> On Thu, Aug 22, 2024 at 09:38:31AM +0800, Baolu Lu wrote:
> 
>>> -EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
>>> +EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
>> Some external modules are still using iommu_paging_domain_alloc(). Would
>> it break the kernel build if you simply remove it here?
> modules have to be recompiled if the kernel is changed, they will pick
> up the inline in the header and shift to this API. But generally we
> don't worry about external/out of tree modules..

I see. I overlooked below inline helper.

+static inline struct iommu_domain *iommu_paging_domain_alloc(struct 
device *dev)
+{
+	return iommu_paging_domain_alloc_flags(dev, 0);
+}

Thanks,
baolu
