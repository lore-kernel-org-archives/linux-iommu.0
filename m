Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5DAD2F
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736125724; cv=none; b=o7lAzJQdfJEsTL7qBHbJDafqg38M6JiS+hf3VwA/Tkv03V0B3HYpVs36KRlnLY3d+Z6mbl0tnZ1sFb3RbQ1s9sZEBzS1YCpwYdI/xg54nM+o3LCCJ7V+PK+ez36nbqNxfgUd1oEaKESyKbFNGN9W5r366xtHD9O1nj+w8jqDh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736125724; c=relaxed/simple;
	bh=VWlVIuKtEIxXnv9q7aCn1fqeKxCyPSSDedImcb8I3zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E9zwtUWCf6X1RkhI8qbBDFK46Xj5fZJGINvNiypKPXF355XFFrbtDqTJO/RD20VZLYysLrc7scp8azvKkxmuWkeaFxHpRKDcuWi72QztuOmZaWc/DUwP7F3uWJrhxhF7EqgzFBItFQolVFhFtAjGRtZws58csjPf2JP9fG71OhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EolMqjGD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EolMqjGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736125723; x=1767661723;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=VWlVIuKtEIxXnv9q7aCn1fqeKxCyPSSDedImcb8I3zI=;
  b=EolMqjGDO/0Z8C9IgL72S7KphvtR+8NdGm10uq+hiMAlbxctjCMTzkwl
   CExkxmUY0v/je7+yqA6p+8RIoibaYBGrHb2SXBYDhI4QdJXsjNX9QdTba
   JX61pfnhGKQEWAFS316W6LMrmotRt32v4fRYhjmUg+bETDZRYiQ8FtXs3
   Pp9/YjrGkzRDQFa3N214Gtm0NvYe58lgcu/znhBgXmseEhzKQmukyZ3O0
   YBw1xdnP0Ir2PZD5dQQ8LSmcdshvHHe54RFGrhKQcVK4jkgE2w3NCpYwZ
   gKn/56HeKXrWhDhudK4abwK0y1jIt51X1EejbxRGYq/XvIHR8l9MqFRWL
   A==;
X-CSE-ConnectionGUID: o4wEFjBATamsVAvkPrrzKg==
X-CSE-MsgGUID: lwwUAadoST+KMMkPXCsEiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="36384346"
X-IronPort-AV: E=Sophos;i="6.12,291,1728975600"; 
   d="scan'208";a="36384346"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 17:08:43 -0800
X-CSE-ConnectionGUID: DZKyi/1RTRaIufEv376weQ==
X-CSE-MsgGUID: Lzh7GqnoT9iQaFie8tGFPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,291,1728975600"; 
   d="scan'208";a="102095767"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 17:08:40 -0800
Message-ID: <69605061-50d9-42da-a716-1bff626ab685@linux.intel.com>
Date: Mon, 6 Jan 2025 09:06:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: move the adding group info to proper place
To: Li RongQing <lirongqing@baidu.com>, iommu@lists.linux.dev,
 robin.murphy@arm.com, will@kernel.org, joro@8bytes.org
References: <20250103052811.39544-1-lirongqing@baidu.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250103052811.39544-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/25 13:28, Li RongQing wrote:
> After commit fa0828036488 ("iommu: Split iommu_group_add_device()"), the
> adding group information is left in iommu_group_alloc_device, but which
> only allocate group device, not attach the device to iommu group;
> 
> so move the print to iommu probing and adding functions
> 
> Signed-off-by: Li RongQing<lirongqing@baidu.com>
> ---
>   drivers/iommu/iommu.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
