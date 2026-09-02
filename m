Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797473515CC
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313034; cv=none; b=LdnFehebnxaUJUOsA1YUrdaptCBKX3l/Et1SqhbFHz4FUSLA5BvtOv52BCQbx2l2PHD37Bb+GvLdfWR7wz6SdkR6lRXMtXf6jZBlx2zGc0i7BAb+JXapQsT93K2abnATLhQ07ESPAKGLvZDia61eDHHPYgtHDssAYfUfHDQuKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313034; c=relaxed/simple;
	bh=bs9bhKkHlLjxsVIdPhNefhVuC7ny4CRn4sjjxmGBbzw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D+teL14E1yodhhFU4yb2IVefb4Eg7RcMYt/3EFmt8zYOHpBrapmaAtqDYs8BFpUH0VWDexzGTW6McDT0DSMC0yrNEQ585r14Im1wphrJemtAZTDhXFdpcpcvk2oxqj1wgtrIQXNZqJqltrSh0hE9T+5+gP1oM0kqKD4T+zRlp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFhqs9zB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFhqs9zB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788313029; x=1819849029;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bs9bhKkHlLjxsVIdPhNefhVuC7ny4CRn4sjjxmGBbzw=;
  b=bFhqs9zBlvmQW3m7GeCH7afYL9MfpF7ObxW5A+TCON16XOBecSHP/fzS
   L3WrqL9K5S9s0eGTJooe0vqtqXm1QKhe57jQ4hU2DDOlqw/Q0Uzhsl1OB
   Trta8qMoo5i93bt0GOssHqjPZ49xNkf8kRXuOHyOhziJUtzM4YuDpUgFs
   hhXLcRck4TTzUfS9m07DXIq1VyNxw5c651OJRLa1b0nJ+BYycYNxXFPG+
   WHDmTs4YDrs2V9cYTCG3AtGmcqsGz2+3RDJA/ElKUgVuN+Y4L5glU9CS4
   7hohZhYdRAOtK3tibj3VFPOKU629Z80MesYlqbOizGCh1/wPOixTMUBx4
   Q==;
X-CSE-ConnectionGUID: odZ/R2paQeqoFlVkKFzoWg==
X-CSE-MsgGUID: GL+uQh+pTaqxxLw5QrlurA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="111530241"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="111530241"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 18:37:06 -0700
X-CSE-ConnectionGUID: 8K5ZbrpRT2aABIcLFKzl+Q==
X-CSE-MsgGUID: cPOStOv/TSCSwL1qhx92Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="271219997"
Received: from unknown (HELO [10.238.1.188]) ([10.238.1.188])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 18:37:04 -0700
Message-ID: <19132505-225a-45fb-a507-b916a718dccc@linux.intel.com>
Date: Wed, 2 Sep 2026 09:37:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/sva: remove iommu_sva_present flag
To: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com
References: <aoq8VGFL/Mdjd/M5@hostpc>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aoq8VGFL/Mdjd/M5@hostpc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/2026 5:24 PM, Zhaoyu Liu wrote:
> The global iommu_sva_present bool merely mirrors
> !list_empty(&iommu_sva_mms) under the same mutex. Remove it and rely
> on list_for_each_entry to handle the empty list case, which is a no-op.
> 
> Signed-off-by: Zhaoyu Liu<liuzhaoyu.zackary@picoheart.com>
> ---
>   drivers/iommu/iommu-sva.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
