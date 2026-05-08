Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF32D8796
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227295; cv=none; b=gApNH9aw1Z6TYFoXysF7eZPCqUkJXaXLyYPY0yCtaJ4D2aJvAElVLdKbTIcRa6wAgvEdTEFs/7XeNa0qQCK+UViRf2RnOnCOhL/EHRuOUr7lc+Sv9o2yXFMRH2J+55CoAAQgGh/ewa1ww5Rn4mb8JX+kC+He48gWbKpCtymW2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227295; c=relaxed/simple;
	bh=6eYoFwW6TCSolMpVR9E4N/qZiMtJQ1oUW9oYr82KxMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAILOHfY8x1fWtwjDVPVEKiikcG4pPUo5Y3/Xz0J6Q0HzrcLVQde5O2f0Pm/wuCMi92HlJoqa2nb44wz4VDlUqL+FmAmwX3O6jOh53AXmUrkgFZ0VmMPHHOLPhKofXiqdr2KzylQAGjyl8i/HC7I1oi052Jrq1lqIgmb6nXM+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AR6kgVsv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR6kgVsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778227294; x=1809763294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6eYoFwW6TCSolMpVR9E4N/qZiMtJQ1oUW9oYr82KxMg=;
  b=AR6kgVsvyB1LaqA667VQhJX9gD4qjSFu0jprCdY5XaFIR9CGcCKQ24uZ
   ujCa7c8vcoT1t6U8/xsQNnMVSBcSl127w7RuVp7B6y1apfhZC5wwPQ9ku
   or67UYWG5dZQJruvkPmlTubC7O3lCE1slX+mpD63iTmQHBpdbheifiaIg
   eNKazE7qX24/w47iSnnVAwZR6ZIrHi7RQrDefJnsKLoCa9qz1mBmjOwsJ
   kz3z+j67wazrf13EMtAuCHXgcsDl1ygsZTPwRZ6tQjZ48rrOztEU3U12Z
   Bhf4bQ6tgg/0iK4x51+9h2PzEJAjPDJMfmO5epUKWlkebxroWTy7CkyV9
   w==;
X-CSE-ConnectionGUID: ij31tEDrQ+aXGaC14M9JKw==
X-CSE-MsgGUID: +//CFMYMRrymZKaHBYhlDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90570349"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90570349"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:01:33 -0700
X-CSE-ConnectionGUID: WI1NBQ9USn68EAEP6BVvsA==
X-CSE-MsgGUID: 9L56hdfCQ8aEkRQhnASXVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241049763"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:01:31 -0700
Message-ID: <97de9061-b78f-4401-ac43-4679ac65c3f9@linux.intel.com>
Date: Fri, 8 May 2026 15:59:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Avoid NULL pointer dereference or refcount
 corruption
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, Kevin Tian <kevin.tian@intel.com>,
 Kees Bakker <kees@ijzerbout.nl>, Joerg Roedel <jroedel@suse.de>
References: <20260422033538.95000-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260422033538.95000-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/26 11:35, Zhenzhong Duan wrote:
> Commit 60f030f7418d ("iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE")
> fixed a NULL pointer dereference in an unlikely situation partly.
> 
> If dev_pasid is not found in the dev_pasids list, it remains NULL.
> However, the teardown operations are executed unconditionally, this lead
> to a NULL pointer dereference or refcount corruption.
> 
> If the domain was never attached to this IOMMU, info will be NULL, which
> would cause an immediate dereference when checking --info->refcnt.
> 
> Even if info is not NULL, decrementing the refcount without having removed
> a valid PASID might unbalance the count. This could lead to premature
> dropping of the refcount to 0, potentially causing a use-after-free for the
> remaining active devices sharing the domain.
> 
> Fix it by returning early if dev_pasid is NULL, before executing the
> teardown operations.
> 
> Issue found by AI review and suggested by Kevin Tian.
> https://sashiko.dev/#/patchset/20260421031347.1408890-1- 
> zhenzhong.duan%40intel.com
> 
> Fixes: 60f030f7418d ("iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE")
> Suggested-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Queued for v7.1-rc. Thanks!
