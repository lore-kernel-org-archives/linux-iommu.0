Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15919415D
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523768; cv=none; b=enapwA9vTXZLmUa9NEop1HLn5rUxS4uaVtgaQEbMZAx5Ij05chgQm0LlrFtTSq+vH80kicCfWKGHnqX2zAipPN1Cb7Z6TUz3iJJ9DpcmXg2SnMA2SWLnTNEvkqEGUJd6kNUjElWMbw4WMiLrN2NwgbJi9b9Qxt/Kolm8bi/38QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523768; c=relaxed/simple;
	bh=VgW/YMWVB9c2TEU8uwWcFzi5gZTQfcExZdh3NdYEqw0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M80IgrUqfR71q31eAB0EasgJ5g+KoaJoBgfZ68x/Am7KJzsZ/4ylMmq9wGV9HdC/8iQ/2BmkQtUeyQ2UfBubfBzzP2Gl5SsdyyOfyTpzh+o9pE6+hy71qhBd+RILP40/JP6twTXy+LduwjWz6YdPrxrh81aH6xyg8uzMtu4r8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkNj4RPV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkNj4RPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725523767; x=1757059767;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VgW/YMWVB9c2TEU8uwWcFzi5gZTQfcExZdh3NdYEqw0=;
  b=XkNj4RPV5HQwqSZjg7PlITmPFKRM8taJ3qCKNiZFdpJT27tbmPT64+1s
   BEaoY7q6HbtKA88yHhlQW+04m6x/9oneJVWYuxj1zbHVXxs5Bu8QR8AqT
   y2I7s9cqFR9tdCQ1iByU1tHXgtjrTIhawFx523Oli6DRqHhhrH5XjtnlB
   AhS+a9bPCduSfci1Ce/OrEj6qqEoeqqpsV/18Rrhiih9WNEhJiQKQOumZ
   Rdxe3D7ZT2jbs2fbD4BlproeNanM855AbyxoVtnnR81yHPivYX5VTOD/Q
   Kj8mlM0w3cUb3xE/cYAiViSR8z8Ck6CfeYMko5TP4BvwA0704xyAJsBsU
   Q==;
X-CSE-ConnectionGUID: OJHd1xF4SK+FgNmT9QpMlw==
X-CSE-MsgGUID: 2JgabvQHTEOYQvhc1t5MEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24176427"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24176427"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:09:27 -0700
X-CSE-ConnectionGUID: mR7oE9suQhG1l60K8dW2bA==
X-CSE-MsgGUID: 1GrQ96QEROyohU5mNEAKMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65528234"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:09:24 -0700
Message-ID: <f32b22d3-bb8b-4bc1-90be-54dd2c862da5@linux.intel.com>
Date: Thu, 5 Sep 2024 16:09:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Add kernel parameters to limit V1 page-sizes
To: Joerg Roedel <joro@8bytes.org>
References: <20240905072240.253313-1-joro@8bytes.org>
 <45a3ae40-6e59-43b4-ae57-d159bd2b54df@linux.intel.com>
 <Ztle72HfrjBjlJGa@8bytes.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Ztle72HfrjBjlJGa@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/5 15:34, Joerg Roedel wrote:
> On Thu, Sep 05, 2024 at 03:31:08PM +0800, Baolu Lu wrote:
>> Is it possible to consolidate these two into a single
>> "iommu.nohugepages=1"?
> Generally yes, but that requires to touch all drivers to make the
> behavior consistent. We can start this effort on-top of this change, if
> desired.

Yeah! That works too.

Thanks,
baolu
