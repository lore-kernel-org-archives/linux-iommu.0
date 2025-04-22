Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1915A856
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333192; cv=none; b=U+oxxk88UBv2q/Kf/sCtJmfBv6V4PYJGAhKj5Ru2OMTkj21VgjMGz15XnlpEg1QmuZLIeH76b267XoUaYPJ4T8G/kWgs9SeVFEmqUBYQ6h6+pWc7N3Crz6F4DaKA3b0Qf2YVKBacAW2kdpugD5KR6/8Htg6fETn5/hIPMPflqT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333192; c=relaxed/simple;
	bh=4ZOxOHGaYZ7XnNdBiJCPQxJUvP74KyPgI+gTEuJB1zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnfTl5wCRLwG5yjEkUzy0I/jrkHIEDp1HOr8dIpus1c4WWviy7Z9bn9cV4sNZXxrqkPrONyfXSwuJ2fIboVXi02EdSSC3LGPaSe9qUh4W48bapK3/XDg3nqmkqHWViPDk2aUkMKYyQtRiWPdXljaDLNFgbwc1LQymvXZJumbmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K82VEGXY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K82VEGXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745333190; x=1776869190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4ZOxOHGaYZ7XnNdBiJCPQxJUvP74KyPgI+gTEuJB1zQ=;
  b=K82VEGXYLxU3g8Q/vA9sqXdLhqOoivm7AnMnA3UPC6C1ARSEtNp3jMlB
   VBJ40u4O1DBP9Q0Dn97kV1XbHWxgeTAbHGfTgkElUQRuNmHSWY/In4feh
   5X3zLl9SSlbU84DW6+GyFslp0rzKSI21EmOIRht/TkyWZjZRwh7Z0b4c7
   d+dj9rxz5yuXH0vuEuwm/fMC1s9hqLdVnyWCxSVm8a6mWsk4+cqJ7UOxO
   8B1gcG/5nPlyPRwUE1LlpppIXBe24piNlmOvpHx8rETCJ6FupeIg3XU/s
   5WvBMsnEtmZg2m1KIhESUwbvHVRUcUwnWFpUvZ/3JW0LGbeJZNmi3SPIZ
   g==;
X-CSE-ConnectionGUID: wbLt7fXTQgenq9TiQOT3bA==
X-CSE-MsgGUID: ZPtEeA7eSLOrs+x/Kp7yoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57086525"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="57086525"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 07:46:30 -0700
X-CSE-ConnectionGUID: ZZQ3jrKsQ5akuS+ddnGxrA==
X-CSE-MsgGUID: PtZkqb46R2eCWWoIkHHL0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="163085646"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.111.159]) ([10.125.111.159])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 07:46:28 -0700
Message-ID: <9dda1860-2919-434b-9d85-71b79296f1f2@intel.com>
Date: Tue, 22 Apr 2025 07:46:27 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Assign owner to the static identity
 domain
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, shangsong2@lenovo.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250422075422.2084548-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250422075422.2084548-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 12:54 AM, Lu Baolu wrote:
> The idxd driver attaches the default domain to a PASID of the device to
> perform kernel DMA using that PASID. The domain is attached to the
> device's PASID through iommu_attach_device_pasid(), which checks if the
> domain->owner matches the iommu_ops retrieved from the device. If they
> do not match, it returns a failure.
> 
>         if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>                 return -EINVAL;
> 
> The static identity domain implemented by the intel iommu driver doesn't
> specify the domain owner. Therefore, kernel DMA with PASID doesn't work
> for the idxd driver if the device translation mode is set to passthrough.
> 
> Fix this by specifying the domain owner for the static identity domain.
> 
> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/iommu/intel/iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cb0b993bebb4..63c9c97ccf69 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4385,6 +4385,7 @@ static struct iommu_domain identity_domain = {
>  		.attach_dev	= identity_domain_attach_dev,
>  		.set_dev_pasid	= identity_domain_set_dev_pasid,
>  	},
> +	.owner = &intel_iommu_ops,
>  };
>  
>  const struct iommu_ops intel_iommu_ops = {

