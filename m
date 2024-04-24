Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779285C59
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930382; cv=none; b=KrSZgE4Wlsotcv5ugiYCFscdaZRtw2PLlI1hAPbhGuFBwI7ORFHSADQ0WrVkSNHx3giZnS2AdSsNA+2YewyIhfcZrOZyzTySH4yzoBt1vMMQOv5klYzwZsJVdydl3rs68uN9X3vl7vAuo2TbdojIjOjJff/+Hl8/Hv+cq0tbt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930382; c=relaxed/simple;
	bh=9f1FqymkcY84ZRJChezdXFafCZhSRXFxINpKY9hyCAg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iF4SpOL51idn09rZpx3s04DV+G2QVDD+vzMZ16E4xjUyu9UZHGC6aessySSGN5fK0aUWR4yxqRvLXFQbz7RlI2H2QuwAhi3xCJN2mTy/AKIblzo9EqRJG74/KeQBb4Ytl+CaPIWvyxvww7Q4WNm/bpbc0NBcrJ5dR+hB2Pbu0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4WSNwAt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4WSNwAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713930381; x=1745466381;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9f1FqymkcY84ZRJChezdXFafCZhSRXFxINpKY9hyCAg=;
  b=D4WSNwAtQ1/6MvMjc1dG1DAFbUdL2/zQnqdSof4kAa0T0H3gvNC885e1
   7PUa6LCXm0dZQV+9uGWv3UIsxHWF9v1ssdqbgcYljzOUaV73a+0kd3qHj
   D0Uksp8aQ92aGmBbc0L+Vr5G5B5hxU3ba5YNojszKlDU5FJFstTuk46Sc
   hW7kMr/ylObSjDY9udtSFknkmXsrUl7UgxaT1bvzn0yQt7rQjDPTGjcER
   fLC3rIwxfb4z86RtAi4pMnGjABBbgkb1e6l3aw0cdmJqTdM0ZPBfSEjlD
   Df/NIcyMHF8Z9J2FgUbusQewkdcoyC+PYH3++AYINjrafX3IwwVh8cVPc
   w==;
X-CSE-ConnectionGUID: XzLjaqCcTDeVTCigCNJ14A==
X-CSE-MsgGUID: cOtwmvOgQB6oe3G0xv+tHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9371167"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9371167"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 20:46:21 -0700
X-CSE-ConnectionGUID: UsrwtcwLSFSwEOQCIfOuhQ==
X-CSE-MsgGUID: M5Zm/i5fT9SMPRe7FENI/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="25089694"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 23 Apr 2024 20:46:19 -0700
Message-ID: <4b3f6af7-d40e-4910-8e6d-449c59ab0dd2@linux.intel.com>
Date: Wed, 24 Apr 2024 11:44:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/intel: Use try_cmpxchg64{,_local}() in iommu.c
To: Uros Bizjak <ubizjak@gmail.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240414162454.49584-1-ubizjak@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240414162454.49584-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 12:23 AM, Uros Bizjak wrote:
> Replace this pattern in iommu.c:
> 
>      cmpxchg64{,_local}(*ptr, 0, new) != 0
> 
> .. with the simpler and faster:
> 
>      !try_cmpxchg64{,_local}(*ptr, &tmp, new)
> 
> The x86 CMPXCHG instruction returns success in the ZF flag, so this change
> saves a compare after the CMPXCHG.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak<ubizjak@gmail.com>
> Cc: David Woodhouse<dwmw2@infradead.org>
> Cc: Lu Baolu<baolu.lu@linux.intel.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc: Will Deacon<will@kernel.org>
> Cc: Robin Murphy<robin.murphy@arm.com>
> ---
>   drivers/iommu/intel/iommu.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Patch has been queued for iommu/vt-d.

Best regards,
baolu
