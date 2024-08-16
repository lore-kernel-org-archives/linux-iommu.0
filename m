Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A81B86F2
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813752; cv=none; b=SRo4W7KNpoI08Pf6Ekw1ARROTSWBhNR/LW1TWprM2gTqBxpLqzaiAHGXLI5WVNMBEJQJwh4M9J6xmxoK7+zwbmTv9YsVBKxJB26YtN9enWQOHP2ocNLD9PscCv9zA5tGi50QEzxMiACemdmTDzLGf5G/dx3mMCWSdnh1de19/iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813752; c=relaxed/simple;
	bh=RWcQLwO01wO7lZK+4TH1HBDdeNFGrYDvAOx+heLlZhM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lZOqPTbcjRMQ9A2H8S1QUsdZobLJmSxFRPF+GKO6NcvB5Vah6drBqiSukT57M1T9HOBeqGfx8BFoG6QMI+fwwGV1J//a1JqNYpk6OBDm40+yv2bgB5mZ5IOU0zhyH4V9dBRxzZgMPvRDnZleiSor9KJpIUCSzDv+7CwQSfPAbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZmwuaT0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZmwuaT0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723813751; x=1755349751;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RWcQLwO01wO7lZK+4TH1HBDdeNFGrYDvAOx+heLlZhM=;
  b=lZmwuaT0sHNcjd3LLswcrAFIPOMh75OsyI4Uw9WtruOXIRPD2VO6k+Ed
   6Fn1EF4ICBVCJsj/MHYmtf85LVv5vcwB982RGNMN196CJ4mcO882YkrUa
   sVrZ3xV4ixHICA6gBxa2kBKCKhuXu4ItXoMmOV64hyyV9hvVXTt4eqqbE
   jSsvyYQe2/wuTH6ncqRW99zWIYn1qfLpc+05UWDfA9nZRYEckfXBVo4e9
   LMo2CiFU/ND2VaDc/48Jna2lZjOVoaJJOYUsf7K+KqqYoxVrETRAk+3vr
   jzN2Rxe9cIK0op8D8pibLzrMrSzE/yGWCfkIbLbDoO/xCr9Uw2x082Eqv
   g==;
X-CSE-ConnectionGUID: rtk1A+ogSYGgCjnU6+RiUA==
X-CSE-MsgGUID: PW8093VfQdOdHwDxYdymdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21985625"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="21985625"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:09:10 -0700
X-CSE-ConnectionGUID: 4domtbMSRG+FxjIiCA7yZw==
X-CSE-MsgGUID: SotT63MOQwaC6BH65Zz7bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64557821"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:09:07 -0700
Message-ID: <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
Date: Fri, 16 Aug 2024 21:09:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/16 20:16, Vasant Hegde wrote:
> On 8/16/2024 4:19 PM, Lu Baolu wrote:
>> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
>> attached to the device and disabled when the device transitions to block
>> translation mode. This approach is inappropriate as PCI PASID is a device
>> feature independent of the type of the attached domain.
> Reading through other thread, I thought we want to enable both PASID and PRI in
> device probe path. Did I miss something?

PRI is different. PRI should be enabled when the first iopf-capable
domain is attached to device or its PASID, and disabled when the last
such domain is detached.

Thanks,
baolu
