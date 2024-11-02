Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AD1DFE4
	for <iommu@lists.linux.dev>; Sat,  2 Nov 2024 03:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730517398; cv=none; b=IDTBC2hLqytk3hGJ8Zjg+Fo48/tFLdWtIUMCwJ8XFpaK0eITUu42Nz0PVX7fq1Q0jBvr6Yba5viKS2CHiGRX8KnnEcEMj83H18tAaK31Zy+dkC8lpHT4+5OuGmIv8GHrOft63uP1rWOIMDxQcGBNVDJzqWG+EztUljHxnuFXucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730517398; c=relaxed/simple;
	bh=JLf1d2rcHZPfTu4+sQqdx7rv/1Zldu1BXB03Fy3MSnQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GfPqePcwl3ZUembAKJT+AP0Pq6RtA6ILKQXk+z9M29niCu+UotGUaKqKjSptaJGsKckBjf6hGKBMLFUFYaHOFjtrO7DhYo83EK1bu9t+uiUh85PzO9eM9oFDim2dfIDStjvF5wHl8oUGOnrEE5eMeg6sdegaZgBCMTWd8K7syzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrNu/TA8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrNu/TA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730517397; x=1762053397;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JLf1d2rcHZPfTu4+sQqdx7rv/1Zldu1BXB03Fy3MSnQ=;
  b=VrNu/TA8jZkTFqluzzip0ALUvIdNPmNK+F3AYr6zFZmChijgCMJjBCFB
   sZ8GlYmy1Ume38oTwCCOhEVznOiC5QV3pSvlzJtYnhbM/8x2F2VukDQYf
   4fecQcOGfG+tIyI9w52XJerSHegY+otUZJTcHZ2Kwo8D6fauf+fFEYxtd
   dkPic0Qw1p8zQEnZVYwI7zNPhOsCevRxZeAOdp0BnysgaAJX0v4LIcYV/
   +ejDXAt9pDoR0SmQweETbjMbdsIPOcnGnOR9vk2BL6DQAH8oi67gMzzBa
   1a4ufaPYbBqztos/fsTexIjQ8RVzFeEqf+NdtIsuo/pwpgWeWFGzq5XC6
   w==;
X-CSE-ConnectionGUID: Cj0AZQM4SUCUEvu8mmb4lA==
X-CSE-MsgGUID: /F6kSh7MRBCQmgwnlaneUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="41655313"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="41655313"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 20:16:36 -0700
X-CSE-ConnectionGUID: 8VmEhZSgSg6sZeqv1s65qA==
X-CSE-MsgGUID: LcKtmxflRnGT/bASqnWMzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="83484394"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 20:16:33 -0700
Message-ID: <76d4ab22-c3b9-47d8-9bb8-0430be05fee0@linux.intel.com>
Date: Sat, 2 Nov 2024 11:16:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joel Granados <joel.granados@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Drain PRQs when domain removed from
 RID
To: iommu@lists.linux.dev
References: <20241101045543.70086-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241101045543.70086-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/1 12:55, Lu Baolu wrote:
> As this iommu driver now supports page faults for requests without
> PASID, page requests should be drained when a domain is removed from
> the RID2PASID entry.
> 
> This results in the intel_iommu_drain_pasid_prq() call being moved to
> intel_pasid_tear_down_entry(). This indicates that when a translation
> is removed from any PASID entry and the PRI has been enabled on the
> device, page requests are drained in the domain detachment path.
> 
> The intel_iommu_drain_pasid_prq() helper has been modified to support
> sending device TLB invalidation requests for both PASID and non-PASID
> cases.
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c |  1 -
>   drivers/iommu/intel/pasid.c |  1 +
>   drivers/iommu/intel/prq.c   | 26 +++++++++-----------------
>   3 files changed, 10 insertions(+), 18 deletions(-)

Queued for v6.13.

--
baolu
