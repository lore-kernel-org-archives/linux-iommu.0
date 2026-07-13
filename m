Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25862EEE84
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922427; cv=none; b=cM6lp3P6mgZh76ldnl3yJIYG/70XFv1C6hr08Xf3kGLSjNWlQNamrZ8HKRtgm1aUFabhdKxx8rPn5TxZtofi95icfPA+Z9slJkc8DGBhDQk/Yhq+giQ22iz0MS059aateTvgkdAjbdsnrf+/TqHAd3H6ugGMzRN9gYkKWoqsFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922427; c=relaxed/simple;
	bh=kEnXfjp0fB+NOAyrqx57XLwA3+Z7s1TSVi+KYTvMoLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz+DNGJcfeTTPRn6iW1ISkrxGvYxf+r42zKP5EQgqyktRNBF5AZ5Ot3mxMQOk85KhHolM3s1AVdmwZH3kCPhOl0VL+1bK2dHYgH5EVQhuljl0vGok2iRASlF385+IjxOvbWRkYuKxXdrSc4x/rv2W+0oywD1gveG1Dr+8b+3VvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HoHuNKbB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HoHuNKbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783922425; x=1815458425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kEnXfjp0fB+NOAyrqx57XLwA3+Z7s1TSVi+KYTvMoLU=;
  b=HoHuNKbBQIMWvYsJW+uRdlg0sxLIKIR64MrzlHBp0+EUwLWyhpZuYedG
   LHb/J6hkYOW75xQuTybaotyrNN32nEIyWVYE0nACZIEarDKzdaM0QyRr4
   H6wy3sCusg/dyInL8I6mQrXNiXpqx+JbgeOUW42Evs7sr/0iyTi9L0eTT
   UTThrAekEZTZHO5TmygZmKweZWUDS/nnxEoWqgQf/Pzk2tX+6cLx7Jukv
   0sfLYqtyWJ3EvoPM0By7FUGpnomkRl/scTP826Z73hhMhLH92Vx3/XP9Z
   ZL3kwFg/MClCuX8A/IA/ZJzfb2OU1S+NN967/qnDeDlgiz7+0p76uLHU5
   g==;
X-CSE-ConnectionGUID: BnGEEohpQzawcj8Frm0SkA==
X-CSE-MsgGUID: UEknmciqRFeK52DIk9Yrsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84542322"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84542322"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:00:25 -0700
X-CSE-ConnectionGUID: jOjIs9VrR0moXBKd2/0f0A==
X-CSE-MsgGUID: fNwrl5MnRh+AXC654m1byw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="279863040"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:00:22 -0700
Message-ID: <6e3e3279-fcf0-41a8-92c6-f533d1dda422@linux.intel.com>
Date: Mon, 13 Jul 2026 13:58:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iommu/vt-d: Convert nested cache invalidation to
 the core array loop
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1783539724.git.nicolinc@nvidia.com>
 <15bf2bf57e7bca35fdfd8262d2524026bb7574d3.1783539724.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <15bf2bf57e7bca35fdfd8262d2524026bb7574d3.1783539724.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 03:44, Nicolin Chen wrote:
> intel_nested_cache_invalidate_user() used to walk the whole request array
> on its own, copying and then flushing one single entry at a time.
> 
> The iommufd core now iterates the request array itself and re-invokes the
> op with the not-yet-handled sub-array, so handle just a single request per
> call out of the front of that sub-array and report one handled entry via
> the array->entry_num. An empty array keeps returning a success, used as a
> probe of IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 support.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Assisted-by:Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/intel/nested.c | 54 ++++++++++++++++++++----------------
>   1 file changed, 30 insertions(+), 24 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
