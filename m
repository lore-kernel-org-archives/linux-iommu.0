Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED7A927
	for <iommu@lists.linux.dev>; Thu,  2 Jan 2025 03:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735787597; cv=none; b=drotnBL+d5P29CNAFI9P+jrTRasUWinw+IfwG8yzY9rGr7cvE3T0LycKBDV1ZbJ/mscgCMWywWF9hVPRywLoHH5ytWqW/YXCyvrhDQoC0ykTxHdJ6Qj2Ry25iog3ncs2wZJmjFTDeRPaBX3gWVaCtF9grCJXPVYCEirHBplG95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735787597; c=relaxed/simple;
	bh=GrK7X2RWGuwyU71KuFjemlSleteRU0fGnr0dG0tU3yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9yQ8c3X8kNJ7CJJf5rVB02qwlOs3iiqxS5Gp44JAE83gUL03c+cTnUgAonpGHehxTY+8z4u9fyI3peYlttvuroojB257+5jAokL5K/CGC26eu70chaeHxg8mTN/d9KtbUA0bF1aOVVjLfFFI3rX08ekG18N2+cDBzTmn/azwnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVXgerjA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVXgerjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735787596; x=1767323596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GrK7X2RWGuwyU71KuFjemlSleteRU0fGnr0dG0tU3yE=;
  b=gVXgerjAnYvbbJytflS+DzDgZMsfL16aLdzVcT9JLQBuW0Th9BhFpo/J
   KiCFfixLtRmmsOnRwTh2IZpj42ohRnPsMl5YK8oDD76cOq3dFVAFAifnz
   jm3THL7/f+HgpuWM5YoCqfjgA0Se0pFQXJc86H0mU0emgwQ5IUjbmv/yA
   BBT5B/9zy2rm/htNEjnyoym/s50aduq1NjgeUEp3bD0dakZhQFwwTgvlZ
   PmuKsYZ4rKZzcUj6VIdnoK4Ghl/CZAAXjXuifnETaIebRz/bXAbaEdNAX
   sjIztfpVS+i/QEo6LTz+GYu4pv8o3BmdKQGQiIiyTg3tCMT6xr2mNdMVU
   A==;
X-CSE-ConnectionGUID: LwhLnEzaTymRRZDSmDQs2w==
X-CSE-MsgGUID: /k635eWvTuarMr1qu0kIJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="35326928"
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="35326928"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:13:15 -0800
X-CSE-ConnectionGUID: GDZlJSifQKCOB76Ftr6cdg==
X-CSE-MsgGUID: UAapIAtzQMKs3Kb0m63c1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="101883905"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:13:13 -0800
Message-ID: <769bba44-9426-4950-b6db-3f021501095e@linux.intel.com>
Date: Thu, 2 Jan 2025 11:11:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE
To: Kees Bakker <kees@ijzerbout.nl>, iommu@lists.linux.dev,
 Tian Kevin <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org
References: <20241218201048.E544818E57E@bout3.ijzerbout.nl>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241218201048.E544818E57E@bout3.ijzerbout.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/24 02:46, Kees Bakker wrote:
> There is a WARN_ON_ONCE to catch an unlikely situation when
> domain_remove_dev_pasid can't find the `pasid`. In case it nevertheless
> happens we must avoid using a NULL pointer.
> 
> Signed-off-by: Kees Bakker<kees@ijzerbout.nl>
> ---
>   v1 -> v2: change subject to use 'iommu/vt-d:' prefix
> 
>   drivers/iommu/intel/iommu.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Queued for v6.14. Thanks!
