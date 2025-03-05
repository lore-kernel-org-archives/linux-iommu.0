Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778114B976
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141496; cv=none; b=EuUnIPnS6EJl21SS4EIXDxQhxi7ucvkX/1i53wScQmY0IUV2IJymSt665gPpaOIYk2hpI61kpFAYj9juCoyXmO7r/OhQXmT3FNLpwQqSybjrCT0eRtdPTSlKxG4Qy+hmFYxIP485uf/aSKT9BjhBfy+EvnjGoYCY1VtaGnqBkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141496; c=relaxed/simple;
	bh=GSgAqk9yvA1DXvwWKyeI0fJEO1h1TplFSVnjk/scBB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSMpp3HQ9L9TAVfbX5BYl5dO3vasPdfMXuivG/s5EqDYAvkOTth6GEOdqQC1T1SfMQOughQNQFeyqmr8AiNhLieF5I+CFeo0V/A8pfNbHmKN404z0zVf0FSF0wUQ7Rx5105c7cg78toQsN23+mXVUY3gkHlCCWFtf6anjDxpV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fl+VHX73; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fl+VHX73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741141494; x=1772677494;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GSgAqk9yvA1DXvwWKyeI0fJEO1h1TplFSVnjk/scBB8=;
  b=Fl+VHX73oewUgtVFnbB8Y7SQqfzhDVdVPP+4kb6pNKWWDZzrR5DJyAZd
   Tj4CYL6/98+qrtgcBqmhiJYXQwaRB2EBY/aV2TiJA07zNw7ASW5xeHcwY
   ASoZbdUSmtc3m0F3IpGSMie8aBBQjtP8utko0RFo+jEZ8OXhmyAXedr6M
   o3WY/OcBeXM5DHYJyEpkaTeKWg6y0D6hJ6UgTJx7gWJMub3+6HS+oIrgD
   HUyL8H0tmfrtymwWCLM2sY73Bk0Lymrml8qaGxUA2QAjlTN/SwrhIAuk7
   9RfRGzKQ5AvkxgHkFWd+HmX9+FFvdhPx8g8sDcY2cm6TPLAeBBLnzwLrg
   g==;
X-CSE-ConnectionGUID: p+aBV6nyR2KdQV/aunhc1g==
X-CSE-MsgGUID: W5NM05GKSPuVO98edZOilg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52727136"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="52727136"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:24:54 -0800
X-CSE-ConnectionGUID: sezbqabCR+y7DRXQkkd3wg==
X-CSE-MsgGUID: iEGEkacMRV+US2HDWxAfNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="118273495"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:24:51 -0800
Message-ID: <51cb2ef8-3cce-4af7-b6ce-c3e3d490e6a3@linux.intel.com>
Date: Wed, 5 Mar 2025 10:21:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] iommu/vt-d: Cleanup
 intel_context_flush_present()
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-7-baolu.lu@linux.intel.com>
 <f7d84e3d-a648-4292-a652-408f704411c7@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f7d84e3d-a648-4292-a652-408f704411c7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 16:43, Yi Liu wrote:
> On 2025/2/24 13:16, Lu Baolu wrote:
>> The intel_context_flush_present() is called in places where either the
>> scalable mode is disabled, or scalable mode is enabled but all PASID
>> entries are known to be non-present. In these cases, the flush_domains
>> path within intel_context_flush_present() will never execute. This dead
>> code is therefore removed.
> 
> The reason for this path is the remaining caller of
> intel_context_flush_present() is only the domain_context_clear_one() which
> is called in legacy mode path. Is it?
> If so, it seems unnecessary to keep __context_flush_dev_iotlb(info); in the
> end of the new intel_context_flush_present(). Also, since this helper is 
> more for legacy mode, might be good to move it out of pasid.c.:)

This helper is for invalidating various caches when a context entry is
present and certain fields are changed. It is used in both legacy and
scalable modes.

In the past, this helper would work even if some PASIDs were still in
use. After the changes introduced in this series, this PASID-in-use case
is removed. So remove the dead code.

Thanks,
baolu
