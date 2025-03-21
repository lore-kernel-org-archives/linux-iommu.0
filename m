Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD66D208A7
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524719; cv=none; b=lexhlvAqdFVIFJgyEjt+g/LEgS1CkEjPPr4D2PoFddI+uLcTJSXZEtZk8U0ws336z+z+nvqpZ+M1YzLXoNG7B6aLgR3wIQDr1/Q9Lv1ROKzLfV43+QIi4SjY8UTxFNubugPq5b3kC+NOQcrcd3rZ4dDks1PK6/OztFyxY2xiKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524719; c=relaxed/simple;
	bh=7otnum2HADT5v51vgk7kPiPrxCwKd8aUg/nXHGgNSx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2B8gDoM2iYuozbRvi1YbI15t9TfxU4J2ATfmSyLAL1u3qFdqtj1WJt+GfoonK5bU/t46vUqVwMkP78tpywwfzdlmdPMIQNeRMatVHTl+D9j1XeTSqVC/9r0cILj0e8hikyV4l9luA5+9AKmSDVbldluAoB6OpLourreGVviypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfV75xaK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfV75xaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742524717; x=1774060717;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7otnum2HADT5v51vgk7kPiPrxCwKd8aUg/nXHGgNSx8=;
  b=OfV75xaKp5oifPtNfRphT/iWNZKWOklCevNBKkfehyuqnLptRj43ih7S
   d7czpNxfxJ76fqqTjip9GtFJm6UCHkVHlwrQKJNvHFo8vKZLzCTTclq2v
   C/6cMF9JI+KMddxTSPDrts+6sC0UQ1RdjChuktgnQpQ96luU5P3ha5o1Z
   CMi8yL07JO7QKGwz+T2hHJf5QjBonGwk9P/YZaXuqLJVyBDjVn7gk5Akl
   hb4uFEJholCJXsqga001Xrgq4x/yT02vUL9hVRW5hhK+DhxbZsR93xrQI
   zI/lgg5PzePaYsS/V14hWXlwtXRfZv3/v0mbrgm45NYdWazVQOY7TQ1a+
   w==;
X-CSE-ConnectionGUID: bVqtrYx/RQahzhLeunb3jQ==
X-CSE-MsgGUID: nAI7yZpqSjWhgUlr3aP9CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43898555"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43898555"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:38:36 -0700
X-CSE-ConnectionGUID: oO62M0lTQUO2/HIJjRclTA==
X-CSE-MsgGUID: +a2NgMwYTbG8pHiSVacJFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="128336765"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:38:35 -0700
Message-ID: <79799a94-3434-40b1-8d05-c40547c32638@linux.intel.com>
Date: Fri, 21 Mar 2025 10:35:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/18] iommu: Require passing new handles to APIs
 supporting handle
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250320134744.5777-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 21:47, Yi Liu wrote:
> Add kdoc to highligt the caller of iommu_[attach|replace]_group_handle()
> and iommu_attach_device_pasid() should always provide a new handle.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

I supposed that we could add a line of code to check and enforce this.
But anyway it's fine to make it mandatory in the kdoc.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu
