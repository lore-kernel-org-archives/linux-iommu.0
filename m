Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF2A28C86D
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138165; cv=none; b=pDyvDUUTD1tAGVv9XZG60hAqHvh3l+BxaNdIPpWca88WzxrWmsAqCbm8SYlDboicwS7HGxsA8T14L53T8J1XFfMLBHSq4SCadIPdhHqPC5RjwK1EGbDyONtQq3hLNUF/pNywGzXK8BXAyP1uM5WadoaiwU2IXcsLW+jckODuD1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138165; c=relaxed/simple;
	bh=rnbYzhcyqsM7Cur/yLDLwbaGlPGjk71MN1i+Sn6PF7U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cDioIFtwxM561uM4XZGIGIPihpGv7JIrqn7awEAnFXZi6KV4YecqfrGyDz9IAavhd0ERK1n1mkLM/fbxkzrQ973n5IK1gJ3pczlyJbebeCiFqZf3urSyT6kYMBoL1RNvwkiogYy1mk5DLsLA+RC9hzFDH74r20GJl4rsO4InUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqH2zbZv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqH2zbZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752138165; x=1783674165;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rnbYzhcyqsM7Cur/yLDLwbaGlPGjk71MN1i+Sn6PF7U=;
  b=EqH2zbZvi/+CHxVzqBIOLYPJI0LN4D1rpKQHcH/MAKn6uusYwFUY6NPd
   NEChlpti97FUi3i61XLo4n+9GW0g8kr8tmNMT3ZMs7lMseEX0eL3bfYCB
   lH0CN6wtl+447afZMd1VbrM/Yr3gA2UoxAy84/VVVwkesuzepLrOuj9sN
   lneEl9IYoErT8QBtEwVeBIRJTkedgtcfe150C+7hc43dmfPZeYLFL/nrd
   W5zqq1Yz2bvLe+1LG0yR5J+FwkyzdpSawloon3GlYEI0x3ifzJNryuQEG
   h7G2slHnZPRovCLTL6CogyQ9sNNW+c4GNBl2lACubCnvJ513GJU3xL8rz
   Q==;
X-CSE-ConnectionGUID: yJ1SMTMqRWyz74i8AOvOnw==
X-CSE-MsgGUID: MhAYAdtWRFupDJgMrmwhLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71860151"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="71860151"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:02:44 -0700
X-CSE-ConnectionGUID: jrT2+QECRDy8xPWYHiH2Lw==
X-CSE-MsgGUID: 9a685G4zTluEDerg8XAcAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="179718270"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.252]) ([10.124.243.252])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:02:41 -0700
Message-ID: <5a713081-7a1a-4ff2-8212-cbd4a6c63fc0@linux.intel.com>
Date: Thu, 10 Jul 2025 17:02:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Deduplicate cache_tag_flush_all by
 reusing flush_range
To: Ethan MILON <ethan.milon@eviden.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250708214821.30967-1-ethan.milon@eviden.com>
 <20250708214821.30967-2-ethan.milon@eviden.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250708214821.30967-2-ethan.milon@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/2025 5:48 AM, Ethan MILON wrote:
> The logic in cache_tag_flush_all() to iterate over cache tags and issue
> TLB invalidations is largely duplicated in cache_tag_flush_range(), with
> the only difference being the range parameters.
> 
> Extend cache_tag_flush_range() to handle a full address space flush when
> called with start = 0 and end = ULONG_MAX. This allows
> cache_tag_flush_all() to simply delegate to cache_tag_flush_range()
> 
> Signed-off-by: Ethan Milon<ethan.milon@eviden.com>

The same issue as the PATCH 1/2.

Thanks,
baplu
