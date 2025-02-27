Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62F1581E5
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627102; cv=none; b=If8JbRc0Wl7ICjCx4FXLY+nAdtKIfHER1sg0JyNKVuikF6gOOhQHArzNJV3uiTJy1JS+RA1YRz9KIZGCf6r6yjO++EVJKdBACG+cQztOcYPjV0MS1l+GGOJjO48xY0QOmPafpOSpQPg8axiXG803M9cocTaGtt+yUPaPwODrjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627102; c=relaxed/simple;
	bh=+Jelc1uVMZBZQRMDSrl2Adj6j0Seg3ZfvADmUrM0e8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AV67I/gGZFTlgzbWHldwiR+aC0IimBI6mgXjalN1ykeijfkKewM9yU+KB/OaU3UJRxM2aX214vTDvY2uPTzWZMx8su0jH38yCMWb0helSmaHp1H9onjfvwT2df1vNjs6PFfbuEc+IwOoJCGr3dAdhU+x3PE6C8F4RpdXQZBLRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBsxsQBG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBsxsQBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740627100; x=1772163100;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Jelc1uVMZBZQRMDSrl2Adj6j0Seg3ZfvADmUrM0e8Y=;
  b=ZBsxsQBGVDRYHdaVJ7ang7qMTo1XKi3SMgYvy//CMaux09Jx0QOoyeNp
   ISmwY3neXxdWIpz3wy0RqBM+0wufK1GsoEnM5/0aUfhUl5L6h12KMuAGB
   lPYYnpXPl/t/WI8osL2CrGuA2+iHAw+CzJUdlcr9zopvob222zHfUmqm/
   Fo9LFRECzqLTli6gJPLH94XWZhJ0YtBrhs9Z6CLqKy/PjhR8GjVjaHW0u
   AY7JHv+BaDDMe1FTM6a5RF34x97bXapHGCOGydMuov1uPPuhR6IHdOX6m
   z2lBKKQwdDVRWvgaNy4eVl4n4kNMHv2z8uVvbh6K58QdPwa1V8Dx/CtV9
   Q==;
X-CSE-ConnectionGUID: nMt93XgmT0i35qgx+fZFCA==
X-CSE-MsgGUID: +YzicQ4kSCOONPyiAmy6Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41385339"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41385339"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:31:36 -0800
X-CSE-ConnectionGUID: J397P9TpQfOHhHdYTe7HZA==
X-CSE-MsgGUID: hZyJ3MkCQQKmhEv0Sd51AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121496074"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:09:24 -0800
Message-ID: <32982ad3-98c1-4a75-aaab-a42d557dc498@linux.intel.com>
Date: Thu, 27 Feb 2025 11:06:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/12] iommufd: Mark PASID-compatible domain
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-6-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250226114032.4591-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 19:40, Yi Liu wrote:
> AMD IOMMU requires attaching PASID-compatible domains to PASID-capable
> devices. This includes the domains attached to RID and PASIDs. Related
> discussions in link [1] and [2]. ARM also has such a requirement, Intel
> does not need it, but can live up with it. Hence, iommufd is going to
> enforce this requirement as it is not harmful to vendors that do not
> need it.
> 
> Mark the PASID-capable domains to prepare for adding this enforcement
> when iommufd PASID support is added.
> 
> [1]https://lore.kernel.org/linux-iommu/20240709182303.GK14050@ziepe.ca/
> [2]https://lore.kernel.org/linux-iommu/20240822124433.GD3468552@ziepe.ca/
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
