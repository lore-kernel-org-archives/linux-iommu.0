Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83364A8D
	for <iommu@lists.linux.dev>; Sat, 20 Jun 2026 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781924364; cv=none; b=Y7puvXbTAWrjadJH0qHWe+5+3JUOkOgmT/mDyhKZ2d9Z35BLy2p0kJW/fAWMpW7D8RgmoWn9N59AFyZY1hhxsOXO1tqLsdrjJDondceG8eIs5h+PXy1oQzwxJ0y4OSvvalL6CRB//kYQJ1GOso3hHMVolCsrXrtzy/G8RutM2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781924364; c=relaxed/simple;
	bh=UmPtjBut7fRlomTktEPZP2/QK02/tX9jHh+mq/JQfZI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ivset695d1IPVjjJiMsA9raxAB9gx0fJiKO63xgJR2Tc3/mirGM+fYhKHLIJ2Pigjp5MJUDDhvL0FxNuwAp/yVLbMgFZA5V5nRu5g92IF6uDcvv0RPXBXpJybTQ2djteSZ6kYkxDr51ZD8eFTYKTZa7KEaGhkTvrikjDewGXvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBsN42fq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBsN42fq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781924362; x=1813460362;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UmPtjBut7fRlomTktEPZP2/QK02/tX9jHh+mq/JQfZI=;
  b=eBsN42fqaj24W9kAJyOnvTwFNUcyhX9Uua9lkm9tQTCbZl9E38uBU5Cb
   0WOhMFBN/xayvXN711Ky3VLF4nC2dlizR7y0ibedD625j8jUjDQoxjjsE
   y1PQ2Bv+/Q9C8BQ9r7yP5GTbOHdx12Nt90EI+SW4xkYEIUNiV16lJwzYB
   H3Hrr06hoxTP82z/pSJ4e9B3sFxqufE5YdGXegDaCiqo/UQsyRMLJrXqW
   dEwqwOr+toT7rE31iglmguHhz1CWoBTUPucIicQleWuEdpJe8kRhS3FVt
   WaY2yoPyPNLxkwiCIH48wN5H46ylm8RTAkOjOBx7DrwQiJqfGBlNjx8Ab
   Q==;
X-CSE-ConnectionGUID: xu7lZtMjQiCFuHdrsWQpYg==
X-CSE-MsgGUID: 8nPoTdM8TmiWLgbUpQfX/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11822"; a="94148461"
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="94148461"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 19:59:22 -0700
X-CSE-ConnectionGUID: 1a6PYKeuQTqistR/Zr3rQg==
X-CSE-MsgGUID: foN/t8V3TYGqMSZiRjf0aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="244591251"
Received: from unknown (HELO [10.238.9.114]) ([10.238.9.114])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 19:59:20 -0700
Message-ID: <ce40dd72-a56c-4827-aaee-02a5d21e9766@linux.intel.com>
Date: Sat, 20 Jun 2026 10:59:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBpb21tdS9pbnRlbDogUHJldmVudCB2?=
 =?UTF-8?Q?ariable_pollution_in_cache=5Ftag=5Fflush=5Frange=28=29?=
To: "Li,Rongqing" <lirongqing@baidu.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260605003950.1720-1-lirongqing@baidu.com>
 <2ffd9844662a46d6acb975d14d14947b@baidu.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2ffd9844662a46d6acb975d14d14947b@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/2026 3:51 PM, Li,Rongqing wrote:
>> From: Li RongQing<lirongqing@baidu.com>
>>
>> The loop in cache_tag_flush_range() modifies local 'addr' and 'mask'
>> variables that persist across iterations. When CACHE_TAG_NESTING_DEVTLB
>> overrides them for a full flush and falls through, subsequent tags incorrectly
>> receive the modified values instead of the original range.
>>
>> Fix by creating per-iteration local copies initialized from the original parameters,
>> ensuring each tag processes the intended flush range.
>>
>> Signed-off-by: Li RongQing<lirongqing@baidu.com>
> Ping

Thanks for the patch. It's now in my queue for the next merge window. I
will let you know when I include it in my pull request for Joerg.

Thanks,
baolu
