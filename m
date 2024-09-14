Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235AC2564
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726276959; cv=none; b=TKzCEl7rJQsMMyEj9hrTHuC/S77vbbVSdr2ZlDjd9Nh+KaZsXrqmEcIBnrlI20nhMAJ2Y5ZarI+2SmBp1x5niMBnm7+QsFYAKisxzVUoWH2Iu3uB09DQ6aRPygViM/piraaxX82q9czrbfktv/2J7hXkidaTp8ifz864aPH2RyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726276959; c=relaxed/simple;
	bh=mbnFinhAOf9HlLpqZUuO+D7AGKTVBYcGBW7LKflYPUg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DUv+fIN3AXb8iQ3jcsiIfP9DUklGTgvWYqEBpH1ZNJOdCTdlNYUn3PQLsHbnaUUUB4kHypkr8Q9SlhCz7WQcvvOyQWj8Ph47yznyKlJ+H3i/CSiu+t4w1cjhvR3RdEV0mvU2Qx/tX5EXuRzs+L8TvWnnvRtIDCgeRFznpRtHLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnmjKRVJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnmjKRVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726276958; x=1757812958;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mbnFinhAOf9HlLpqZUuO+D7AGKTVBYcGBW7LKflYPUg=;
  b=hnmjKRVJS2PIQZj1MEgloi0aaJogeN1j+asuUFEUsGqboNu4Pkcb2ZBm
   Xk9JIcyyDjMgbl1BahsgOS09rXrxo34zuB6TVnwB0TR0v/vatQtw+pc8N
   S4oM5a2qXtnLJMi4sudMK3mVs+3YpoPmzofpLmqkB0S66+YLLR+SBhvdX
   y3SzDKY1UYFkHbbTPWIG65drsln8ZiyuOkspVuAQbLA9mGiFauVMxTZz7
   m7llis+8njUUyQJ3sgfTGMBerwHbnervw/okmUsV6Af640T+jo+wUiooI
   A49i5kNf62HkE0/XWgKACwzWBnTVIg5ku4b2uGz0/1UUhCm/XSeQ8JpeP
   Q==;
X-CSE-ConnectionGUID: +w/MiW/sQ22WZPEOj8kseg==
X-CSE-MsgGUID: nGVhmRK8TJC5cgIvy/1WYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="35865433"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="35865433"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 18:22:37 -0700
X-CSE-ConnectionGUID: 82VriwB8QO+C4lKPLmjc8A==
X-CSE-MsgGUID: 2bUzYFz5QTiMPvELkofjZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="68125533"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 13 Sep 2024 18:22:34 -0700
Message-ID: <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
Date: Sat, 14 Sep 2024 09:18:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "j.granados@samsung.com" <j.granados@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen <its@irrelevant.dk>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/24 8:52 AM, Tian, Kevin wrote:
>> From: Joel Granados via B4 Relay
>> <devnull+j.granados.samsung.com@kernel.org>
>>
>> From: Joel Granados<j.granados@samsung.com>
>>
>> IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM.
>> Move
>> all Page Request Queue (PRQ) functions that handle prq events to a new
>> file in drivers/iommu/intel/prq.c. The page_req_des struct is now
>> declared in drivers/iommu/intel/prq.c.
>>
>> No functional changes are intended. This is a preparation patch to
>> enable the use of IO page faults outside the SVM/PASID use cases.
> Do we want to guard it under a new config option e.g.
> CONFIG_INTEL_IOMMU_IOPF? it's unnecessary to allocate resources
> for the majority usages which don't require IOPF.
> 
> Baolu?

The OS builder doesn't know if Linux will run on a platform with PRI-
capable devices. They'll probably always enable this option if we
provide it.

This option could be useful for embedded systems, but I'm not sure if
any embedded systems have VT-d hardware, which is mainly for high-end
PCs or cloud servers.

So, maybe we could leave it as is for now and add it later if we see a
real use case.

Thanks,
baolu
