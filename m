Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600E8F5B
	for <iommu@lists.linux.dev>; Thu,  2 Jan 2025 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735787795; cv=none; b=mVf4nqiSwUgiEKJJi1meQ23SBVo58C4nHFs3zlhp1oWyg7FJJbia4YYj58p1UD9zc1lswdlNiYs2bAQeyaCRgziJbeH3a66U2Y0XiyIAp2X8y2CJ9KpuhiNznBZsiC1VkDcsLpTn8eZlkyOwdPnIx9zCI7ceoGyQjh7VEwCgo7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735787795; c=relaxed/simple;
	bh=v4sh3stxwm0IX1oo0VYd8crmRdPfutxapnjnCxc8FuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+ctRiL0wiWXNuL8k/cvF0sIopTWHbmycLxhG5Sy5ck4/C1mLJym2hTdnTzAVqjQe8IOccIAR79B90EipeDcHhSnLiQdVuwISN4QcHlixVhYSvsAq8SMQ4pHCdECG820XDoOa1fTP0rNS4lxkoVsHoPsRysx/Ro5r1pO+NVHjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jk9nc9bv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jk9nc9bv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735787794; x=1767323794;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v4sh3stxwm0IX1oo0VYd8crmRdPfutxapnjnCxc8FuU=;
  b=jk9nc9bvOf7MTkLeQCw+oeyBKiph+L48oPawXPOHOUDiPLmJwrTgIaPl
   iQo/NcEX4hnzdAzA8mQ+enmzXXMYI380wixo2p7LIolpd3pa27KDnCutt
   iHvwjPPNVyrBPcSCHTEToB7X0EMFjkuDl+BPttQ0UoRlRR0+4AER6qL0e
   Bt0EY8THk3bahMXo1ZZeX7GnaY7s9VErnJJkrKWBPgPeHN4+QZz5q0+/9
   3uvsLAMtDPD2e0d58l8dWBavEanuJXcdS7fnys11q4TvyXv3pJkyHOwTV
   EWGk9bq7y9AYcT/+7vqgxTjz/lKhqowgMPe4lvYDCNf9tDqfNt5Rb3M76
   A==;
X-CSE-ConnectionGUID: 4h/WUeVsQP2WJXDnmnaB7g==
X-CSE-MsgGUID: 5p+giP73QKmYF6FvZ71fbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="47015078"
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="47015078"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:16:33 -0800
X-CSE-ConnectionGUID: qrbxU08dSKy5Lw7htzZqlg==
X-CSE-MsgGUID: cKoAIC2gQf6pwGxGx5DJ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102239019"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:16:31 -0800
Message-ID: <7fe65fd2-40db-45bc-aa18-953e9717b685@linux.intel.com>
Date: Thu, 2 Jan 2025 11:14:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: Link cache tags of same iommu unit
 together
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Cc: dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20241219054358.8654-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241219054358.8654-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/24 13:43, Zhenzhong Duan wrote:
> Cache tag invalidation requests for a domain are accumulated until a
> different iommu unit is found when traversing the cache_tags linked list.
> But cache tags of same iommu unit can be distributed in the linked list,
> this make batched flush less efficient. E.g., one device backed by iommu0
> is attached to a domain in between two devices attaching backed by iommu1.
> 
> Group cache tags together for same iommu unit in cache_tag_assign() to
> maximize the performance of batched flush.
> 
> Co-developed-by: Lu Baolu<baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@intel.com>
> ---
> v2: avoid getting cache tag struct from list head (Baolu)
> 
>   drivers/iommu/intel/cache.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)

Queued for v6.14. Thanks!
