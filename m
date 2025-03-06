Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247AD2FF
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741237147; cv=none; b=gRyJbb5Uyb65ZUkJvNANN/Z0aSUZFiaox4mz7aFLP+c29HUpjfK0/sNTtlmz7EZLBK6NHWXnmC6n9XejR+AqtlkcqsWuVLTYCI/n/sT+VO8dTEJFAGzycRx7ouas6YLd0iFs6mAgf12QQa+RT9XFWlODMlq5ik54GLx2e8I1Pfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741237147; c=relaxed/simple;
	bh=6DFcHrjyAVT+x8rFYae3VKjTeDYdGETxckvdehSuxh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbwhb0iqngu7wtOjfK3tB6X/cfRzUHPymP2KJbMgp3Ec/CTWyG5m7PGzfVBfTQ37mBjiNpenjYXDITwDdgKzl5MACW96o+zRX5eY+g01gBid3RdLIhET2dTn6jO+RWd7ahdnjVJwA+mnac21kxCgEBUzptWP+EZZYrRWxBOf37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUVd2WDq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUVd2WDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741237146; x=1772773146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6DFcHrjyAVT+x8rFYae3VKjTeDYdGETxckvdehSuxh4=;
  b=CUVd2WDqIIPGf5UMC9kwbE+r3PX/421qbi51nXbuNifZMoe7nwk0u6eG
   Z9KcxBPfsrUPbXs5QQw9nB+St5sG+owo5Dr26jAxTpUoPHqrh9IDHuHKL
   xrBw35g76dSbmHdQgV2HdQ7H5bjiYYhk5XiJ7XnW7/YPMekjKuIyvrokG
   cXfaTcXwlHHGn92HAkHAjvbPg+RZKxOf0QAm7RzxXz0KwTP6gu8XZby1A
   T8gQTyPNNdsaFmGU9jNvLVBZiksOZGgG1P1/Z5tVxLZBrLW+tKm3sXkGg
   N/hmZ0ZLSoMtj/pV1JULApiRv3La8zezH/dwFW2UWlTFOhQXxOenMmtsv
   w==;
X-CSE-ConnectionGUID: evdFrxczRVuBE2h9HLYObQ==
X-CSE-MsgGUID: UluWoehzQZW1BtkGJgF2nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42091666"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42091666"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 20:59:05 -0800
X-CSE-ConnectionGUID: ZCk1EDTRQQy33OuSKGNzNw==
X-CSE-MsgGUID: Onrlqb3sTJuypBmXsVbWQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118707708"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 20:59:04 -0800
Message-ID: <90bc8ef7-3e53-4d02-b1bc-2db7f6943429@linux.intel.com>
Date: Thu, 6 Mar 2025 12:55:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
 <20250305171838.GC133783@nvidia.com>
 <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d4da9e8a-e393-487d-ae4c-892fc139f2b3@intel.com>
 <BN9PR11MB52760A7D6D2A5680A3DC240C8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760A7D6D2A5680A3DC240C8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 12:10, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, March 6, 2025 11:30 AM
>>
>> On 2025/3/6 11:10, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>> Sent: Thursday, March 6, 2025 1:19 AM
>>>>
>>>> I'm confused about how that can even work if the RID is erased in the
>>>> fabric, how do we deliver the PRI response to the correct entity?
>>>>
>>
>> If the RID is detached, kernel should response any pending PRIs. If user
>> sends a response, it won't suit any pending PRI then dropped.
>>
> 
> Jason talked about the case where the iommu group is created e.g
> for a legacy PCI bridge, with all devices behind sharing a same RID.
> Then there is no way to know which device should receive the response.

The PCI spec requires,

"It (ATS) is permitted to be implemented by Endpoints or RCiEPs."

... but DMA aliases could also be created by pci_add_dma_alias().

Thanks,
baolu
