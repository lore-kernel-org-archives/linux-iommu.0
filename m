Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617A1A0707
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011258; cv=none; b=Dv+XboRX3Y4qvqH45EalPnH5itVunNPK3Z8dWfa/euGoC5skkUZviuG+eb5Xz1nTdqJ3bFRNPDANxwHZ3tBgOdkfq8hPCkdaYFG/h3z9AzlLACfQ+yZ8zrO+zI0yH4Bf/NHhZ9/CVG7yafFFWsB/kypdHWlI/LfQKvB9YZ85RfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011258; c=relaxed/simple;
	bh=kzB24mEuUPTDSRo+OopxR81otdeY8W2AbnIwcZW9Mqc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iDTSD9KC0C18w/20rR7n0GOMJsxGcVWZlE9GsIfRcuCQJJlGTGDQlGFZFWZJtsrDkd+1EI8Aia5cMGF21r4o+UWALBYamCRAHY1fOKpMwR7+vlCciZiUw7T+JwqoaHKiyX3+fbrhz4Y7sioHEt5/B6tl1A+EDul9hZU2J/AVZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5KxDYju; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5KxDYju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723011256; x=1754547256;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kzB24mEuUPTDSRo+OopxR81otdeY8W2AbnIwcZW9Mqc=;
  b=Z5KxDYjuudQ3kCYCpMl4N4I8gVvIG4nXX0dmh8PCiuNIkgQk6Fe14D7i
   UmINCAogYeJygONPph0IrOG7AIHNgM8gKFiWlMypKmT1iHZObDVX8/nVQ
   EL13pFYhHP1xYPGfcgrfoLVywKeWojgKDK0dX93OUA6bfYU+A63dxzpVg
   HgJY+ia4d/Wf6YRdgWdvW3aHYpY2R+qr1EaIiNt6/l9vDurhdqK3gXvbE
   PBFFmhEwT22cgBRnX08eW0A3xAdZa87j33EBGBpLSQ6P6kfvuRPyDzvSy
   soJGUyMzw8WjfJyCdeSR8T3cJDOSLJsOguwmXTTeodR4MvE5ThYR3+lw0
   g==;
X-CSE-ConnectionGUID: 9xNOoYFcQ0eqdRHBLitqyA==
X-CSE-MsgGUID: tPBndyLCQ4KeNlfM1wpFKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32466268"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="32466268"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 23:14:15 -0700
X-CSE-ConnectionGUID: sNYYDmbIT0qVr8bRycs+/w==
X-CSE-MsgGUID: 4EMsCG5lTXaS7EWz/bb0Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="56409205"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 23:14:14 -0700
Message-ID: <3af0ac5a-ec1b-464b-bacc-29d2aa491a79@linux.intel.com>
Date: Wed, 7 Aug 2024 14:14:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iommu/vt-d: Remove identity mappings from
 si_domain
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-3-baolu.lu@linux.intel.com>
 <20240806170529.GK676757@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240806170529.GK676757@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/7 1:05, Jason Gunthorpe wrote:
> On Tue, Aug 06, 2024 at 10:39:36AM +0800, Lu Baolu wrote:
>> As the driver has enforced DMA domains for devices managed by an IOMMU
>> hardware that doesn't support passthrough translation mode, there is no
>> need for static identity mappings in the si_domain. Remove the identity
>> mapping code to avoid dead code.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 122 ++----------------------------------
>>   1 file changed, 4 insertions(+), 118 deletions(-)
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> 
> I always wondered why this was so fine grained, I would have expected
> it to work on blocks of 512 x 1G, once you allocate a memory for the
> 1G table level you may as well fill it with identity IOPTEs. The only
> optimization point is how many blocks of 512x1G are needed..

I am not sure whether or not those early hardware support super pages.
  :-).

Thanks,
baolu
