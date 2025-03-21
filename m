Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11AD2FB
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527057; cv=none; b=LoRf1AShl34g6rVNmEcQvsqeFEReKscgADvRORuZtWWe7B78ZpsBFeXziFYdMvcq15myt38V892a8e7HOE7iRCUqWXws8/MWJFIzstB7nheqBzemBnIFuSWUDp0Fe8NMsyQHclm2GTAkryuXX+QWq9/i/cmUGQ64ebjJDZtOnL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527057; c=relaxed/simple;
	bh=6YAy+0rgqbi4Rd2xzWAaYpU4WQ+NuxBqD+7efIMlqBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8ENXiOVAljEpthhwXxAgDFJjz+QtCS1jOTgo3zvT0lrDAq3IzQFm0VLyNi6LS58ZHbtWNYZeAoTPok+/hkgXcArxDTqHtQe+SaeauNVwgQcpJ7tJ3T5yJ8jppw1hQepuxiixGerevx2sUYjTYE/jYgySUGeRwZZT+CDPOBLDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/t/HeQG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/t/HeQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742527055; x=1774063055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6YAy+0rgqbi4Rd2xzWAaYpU4WQ+NuxBqD+7efIMlqBg=;
  b=O/t/HeQGf7W4eAef/xQiM6Nz0i/VgJtgtCUTReZRoqxYbHqflRepajJy
   GB0uPWb6MAiFYLXNYfTUVAaX9m1/cLn9U3SmU+ZkJe2mwM7KgenYVGHcy
   7b6ltMHgq/34l8qPeRrB1ox2/4s6tvSaSoWGD6pjGyR0sjl1Uet6EQ/qL
   8hOpzyrwbRAatzZVy6p3OEKny3xYyBsQ7vMocs1C4li4ucJ2JpBowvGCF
   OrVkWNOeenpg4Xf2VI9Qi50F4nkzWmZbB1/B6f4s5iK1xefNotoxNAcoD
   SYXWoT3WS1MmN7b4p9b6c6K580keFtHGLxf0iBkv+O6P8US63l5U1bfot
   g==;
X-CSE-ConnectionGUID: pzclH986T7GG6jnd3SeA5A==
X-CSE-MsgGUID: IrmROzdrRECy8rRbv9kJiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43515986"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43515986"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:17:35 -0700
X-CSE-ConnectionGUID: iQHFqwQvSNC9AqR8nzGAVw==
X-CSE-MsgGUID: Vt98RrhWS9SAVOKLRhqmeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123732900"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:17:33 -0700
Message-ID: <730f4648-ac1d-4eab-a6d5-da99008b5fa4@linux.intel.com>
Date: Fri, 21 Mar 2025 11:14:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/18] iommufd/device: Only add reserved_iova in
 non-pasid path
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-5-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250320134744.5777-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 21:47, Yi Liu wrote:
> As the pasid is passed through the attach/replace/detach helpers, it is
> necessary to ensure only the non-pasid path adds reserved_iova.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Reviewed-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
