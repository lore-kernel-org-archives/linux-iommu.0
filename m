Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A4217F5D
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577759; cv=none; b=SMTuvxr2tgY+N6qSEpuKa3ysiXDFPnLs/0dtqh9FsZVlXKWZEJYUD9l+HIljOPpfz4KkdnNFHjud7A6iolBiJfgK7W0RYo6wNW+ZCZCt2Lf0HLgCbHcjZ6EDoebv3gn6UZDIl79RAeWMHGcn5d4lZ2uHhefNqrANPeOORaTG6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577759; c=relaxed/simple;
	bh=ogBovnddapZBBMQp+oqs7dCukwN2p//glvOycR/yIK0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J850xL6dIT94iFXrrNgA9E6SVt3/eVpV5PDug+pc2sn5r2jpoOSKOCqmLm+gdJqm1B/FoJHRj9Z6MtcvHglflW5z5qy9Qwq7i0Dq004hL6YItWFAdPSVdaPGjjM4bJSNua+i2N9pN9UrUQkhF3JB0GMuiBqEgLFEkUg2Mxr+Qro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgcN8API; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgcN8API"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740577758; x=1772113758;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ogBovnddapZBBMQp+oqs7dCukwN2p//glvOycR/yIK0=;
  b=mgcN8API62cjk0smMg/pw42kX0Wymoy5PiOYi6NugMgrCG95aIdEMm9Q
   XkdzcOFUY7y09YMS2g+IfUPPiQzFdUJfaUUaYL9QCjepjfqS3dAaZZl6u
   6Z+ZQo2njaEJHpAUnrNnGLAbT2O0q+vLigG910rFLNk65+VrPc3DGi6CT
   oJ1wxOCL9vPtsDhZ4X8OGol4DNLRucyr8Mk9FN6du8EeDEJ+5a/eqLCMy
   GRnezym6MNzsuyu4mGpg/ARu6vxE6ifSBK850hksmq10N+67BQJz2sRZ6
   z4kUEKcFYoWnsw1s9LszoenyNTEwGW9RWG4btG5u7nto4z2lAVaBBF1il
   Q==;
X-CSE-ConnectionGUID: zOct0l+rRyGlLgPxql23kw==
X-CSE-MsgGUID: gCK2S3Y4SJe8AYVBW5t59Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="29015846"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="29015846"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:49:17 -0800
X-CSE-ConnectionGUID: F0kjfIdyS4mzNDXjoTtASg==
X-CSE-MsgGUID: k4qsKWhfRXi9InQ4n9Rcow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116716280"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.105]) ([10.124.240.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:49:15 -0800
Message-ID: <4caac118-8a30-4340-b2e6-ee9934f58a7e@linux.intel.com>
Date: Wed, 26 Feb 2025 21:49:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, robin.murphy@arm.com,
 nicolinc@nvidia.com, will@kernel.org, joro@8bytes.org, vasant.hegde@amd.com
Subject: Re: [PATCH] iommufd: Disallow allocating nested parent domain with
 fault ID
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
References: <20250226104012.82079-1-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250226104012.82079-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/26 18:40, Yi Liu wrote:
> Allocating a domain with a fault ID indicates that the domain is faultable.
> However, there is a gap for the nested parent domain to support PRI. Some
> hardware lacks the capability to distinguish whether PRI occurs at stage 1
> or stage 2. This limitation may require software-based page table walking
> to resolve. Since no in-tree IOMMU driver currently supports this
> functionality, it is disallowed. For more details, refer to the related
> discussion at [1].
> 
> [1]https://lore.kernel.org/linux-iommu/bd1655c6-8b2f-4cfa-adb1- 
> badc00d01811@intel.com/
> 
> Suggested-by: Lu Baolu<baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
