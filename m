Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306518990C
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139434; cv=none; b=QYfdfu/e3CPa5R5JkcxrULDPmqxXcIcMDywxzWwVkLpVpqWRF89XSquYaC0pqluKY7r0Z+y8okjtvcPXZodTTGXqJxLNUSnroNUPqU0JupzBT26W/sWucxX8OB6afBup78B2l2s5MPN3irE3KauolFLOdTQdpvYZub+zVBSM08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139434; c=relaxed/simple;
	bh=jm2Ah0QcIsof5GMklMqVLfJgTDJic0oUv2HMzEC5O6g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vy+wxX3iPU/LwXpkKxs9TorLBYp9lxTieu1rN2KKpvOlSd+ISdEqD/PYaP3IuWHu617DZXvo6c4LAUfoJV6ZIQUtWQG0ETs7g/dNtq1PwwGsV4XLitmznlfiz1lMCdRt2YTDlJjTRU2p0shwDQO09shFOGEpG7SLVy1XslSOnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7Fz8YMD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7Fz8YMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724139433; x=1755675433;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jm2Ah0QcIsof5GMklMqVLfJgTDJic0oUv2HMzEC5O6g=;
  b=Z7Fz8YMDk8hz7VqzKBlNeLgAVMVZMY3pgMq4a9CoUzdU5po5SSWp/SO2
   Ykw5/m3KkGwLunrA+gN0llTmK5/fztykxYFbZw7ZgPrzUuDLS4AqjNOkl
   95Kna3L+6PxsYgZ53p8yttZ8iMGVYPiNrqZLqnJ+62X8AiycaEfgwMnaf
   EiZVGsK6sQdzeFw9g4ZZ0edh6UmUPSB5me7hmtHRLQabXciPI+BEF0Js9
   LEQkotyKzoPqg0zLmJ1dgqq11rKnjjxmToeH1NIVOddI6lo0CY/q1jRiY
   PsChE8++XQVdPTBB/b+Qq7epfOrjKairsN8D8KcEHpZEQGGAaocjP3BT3
   Q==;
X-CSE-ConnectionGUID: Vfi0E1zbRa+kJmqrnE4qMQ==
X-CSE-MsgGUID: JyjBZArnTRGL5DqEbCjtOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22390298"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22390298"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:37:12 -0700
X-CSE-ConnectionGUID: ImAwxkwSREuls58B7C1TRg==
X-CSE-MsgGUID: 53piYitRRMezrL9Lsu5tBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="64821022"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:37:09 -0700
Message-ID: <f9ee4657-eea5-4a82-8e01-0396948ed755@linux.intel.com>
Date: Tue, 20 Aug 2024 15:37:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Unconditionally flush device TLB for
 pasid table updates
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
References: <20240820030208.20020-1-baolu.lu@linux.intel.com>
 <9047e540-a993-473c-9d24-8359cec67b5b@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9047e540-a993-473c-9d24-8359cec67b5b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/20 15:09, Yi Liu wrote:
> On 2024/8/20 11:02, Lu Baolu wrote:
>> The caching mode of an IOMMU is irrelevant to the behavior of the device
>> TLB. Previously, commit <304b3bde24b5> ("iommu/vt-d: Remove caching mode
>> check before device TLB flush") removed this redundant check in the
>> domain unmap path.
>>
>> Checking the caching mode before flushing the device TLB after a pasid
>> table entry is updated is unnecessary and can lead to inconsistent
>> behavior.
>>
>> Extends this consistency by removing the caching mode check in the pasid
>> table update path.
> 
> I'm wondering if a fix tag is needed here. Before this patch, the guest
> kernel does not issue device TLB invalidation. This may be a problem for
> the emulated devices that support ATS capability. The cache in device
> side would be stale. Although some vIOMMU like QEMU virtual VT-d would
> notify the emulated devices to flush their cache when handling the unmap
> event. [1]. But this is not required by VT-d spec. So it's possible that
> other vIOMMU may not do it. So this patch appears to fix an issue, so a fix
> tag may be necessary. How about your thought?

It depends on whether this solves any real or potential issues.

Thanks,
baolu
