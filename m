Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D63382E9
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280507; cv=none; b=mg9Y7l/h9Tp2X6pOKc23EopDOzii11Oys7zKEj+MjEr7iqeXaN5qQTrxbNUiBCpOM0SZYiyPqvDzqWq/iW/vm783TUH/C00beTmlRRpOlyZHU+132PQc6h/YiYKE/NPpKRkZD37aELUozHmVm9486XD0Xae150hKS9rWj1Ob6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280507; c=relaxed/simple;
	bh=q63NRiQFMNefhufXmtClaqhgJ+NKaVDqRu5jcnIvITs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eq3VfXl1CME0/KoYKP5aATaLYhyOdCGm+k5egtuVpfqhQWaiwCXdFqEFLGSFGQ+KfQm264JS4QvAvJBrgqbF1C1gU07MRBqXMeR7FXPpBlKDfxXhIHSIKogvNnEeGhojEWNgeiDdlYf1IHbKPUdwCjesG1WNQeb+iFWeyaVWazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BT9iU8Cz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BT9iU8Cz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770280508; x=1801816508;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q63NRiQFMNefhufXmtClaqhgJ+NKaVDqRu5jcnIvITs=;
  b=BT9iU8Czz+XCCtC/mbCa39uTp+05VFv1PLFW5JppOoPp12L5EepSEhO8
   cGmHj7X0lKELmey2nTQb+3hzP93LQitm6WvhcMfCOpaZM07H5mWOjMHIf
   aiXVbvZ2dUK61n+/BJ6BRAvaO6MBLnus+svLSziFjsSBb+D8MoKORk6Sz
   Ny/iUtpivg7pk6vpP2CGIQpbmK6gY9rXZRHndkhEyqmjmkrVYWQYupsy/
   CRaBNwfQBXETV/G6jfmt3czVQaQ2n3BoTXlcF+Qiq5G3Ni1nTaLxnieOM
   eHS3X/25GoZQSxDvlQ2tsMXA5PY+BTvambKt1AthNXjx+owMbUBTMKI/j
   w==;
X-CSE-ConnectionGUID: fRdBGYGbTauo3OLhDgIq9w==
X-CSE-MsgGUID: f+29wpdjS3KzqxgUPFneNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75328238"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="75328238"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:35:07 -0800
X-CSE-ConnectionGUID: POH0r+qwSq+Qj/nmjBb6wg==
X-CSE-MsgGUID: D337wJtAQ6OD+asbHtvGGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="209724675"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:35:05 -0800
Message-ID: <ec1c5a6c-53d3-46e5-8f6f-e12ee49dc0b9@linux.intel.com>
Date: Thu, 5 Feb 2026 16:34:33 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Treat PAGE_SNOOP and PWSNP separately
To: Viktor Kleen <viktor@kleen.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260202192109.1665799-1-viktor@kleen.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260202192109.1665799-1-viktor@kleen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/26 03:21, Viktor Kleen wrote:
> The PASID_FLAG_PAGE_SNOOP and PASID_FLAG_PWSNP constants are identical.
> This will cause the pasid code to always set both or neither of the
> PGSNP and PWSNP bits in PASID table entries. However, PWSNP is a
> reserved bit if SMPWC is not set in the IOMMU's extended capability
> register, even if SC is supported.
> 
> This has resulted in DMAR errors when testing the iommufd code on an
> Arrow Lake platform. With this patch, those errors disappear and the
> PASID table entries look correct.
> 
> Fixes: 101a2854110fa ("iommu/vt-d: Follow PT_FEAT_DMA_INCOHERENT into the PASID entry")
> Signed-off-by: Viktor Kleen<viktor@kleen.org>
> ---
>   drivers/iommu/intel/pasid.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued for iommu/vt-d.

Thanks,
baolu
