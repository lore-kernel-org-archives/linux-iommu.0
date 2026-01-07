Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B98F48
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767764905; cv=none; b=UF9eEV67jIN77BoZ3Xz7VzlL1tuuhp3T+9y2NVmBoECsp7MYnBxa+IndQga/LsM55HPs5iKCdATiPWqknGy96KjFz1axOSY2wooj/FjQCwqOMgY0/TwLRSrhOClc90EfTufXIY6ogHxan+wIZ1gpo8AhSvcxUKWtOaZWufzudyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767764905; c=relaxed/simple;
	bh=0+FZ1WtgSm/nAQySSzMyq7NKTbNcf9U1vfmunxR5udI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVGd/rwQyrvABbUOD5xYJVqx1frpUbSB1Yl72i7RBNu7K5e15c0FbzrFMZgBGNo/MeLftgyS2ahutcwFt2ex/NpjfC6CvocRJ7kbnKy1ne8sPeR17csZbuzZ2bRRyOUFg/fh4HQm1nfhHfEvhylty45IceeObm8gklLowANIJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPu7NGZp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPu7NGZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767764904; x=1799300904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0+FZ1WtgSm/nAQySSzMyq7NKTbNcf9U1vfmunxR5udI=;
  b=ZPu7NGZpxRx4Qvvb8rPvWXGZyiGWVfAtXVXNHoHusIOjp4Si8/e8l1ba
   GbSudx6pyFndubHojVlj39GBftN9G4X/K6DPR/nTANl/pwzm7B7LxtI2C
   jY/qGeBgB0K6ncapfsUmvgAi3iWtrZbyZZfyFxBDxx7Oxx25VEK1LJGvw
   o0yFk6JpiAVjTMVPu3xkOXO1e16LZcvxjRifLB3zJgUeYxr177bXLIhw2
   tlfD/Ojv3my/xw6MIcGBCQZktbiltEsSQpshgYjpvXNCa4ubZX7R7AMMQ
   +yrY+49MelCDimDhc1adREYIQTCZprN+oDRQuUmcmg5H5X8JN/Cph6oDF
   Q==;
X-CSE-ConnectionGUID: iXSS/ZMsQ7OinRsmr49QHA==
X-CSE-MsgGUID: Pi0IjrmbRviK0Rz+L38Lnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="91787712"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="91787712"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 21:48:23 -0800
X-CSE-ConnectionGUID: FcRaYlxlSW+Fp91un03Hpw==
X-CSE-MsgGUID: JDHktlI+Rq+auVfXD+19TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="233978337"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 21:48:18 -0800
Message-ID: <390a15a8-e530-46ee-a42c-cbb3170692df@linux.intel.com>
Date: Wed, 7 Jan 2026 13:48:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com, rdunlap@infradead.org
References: <20260106162200.2223655-1-smostafa@google.com>
 <20260106162200.2223655-3-smostafa@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260106162200.2223655-3-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/26 00:21, Mostafa Saleh wrote:
> Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
> - iommu_debug_init: Enable the debug mode if configured by the user.
> - iommu_debug_map: Track iommu pages mapped, using physical address.
> - iommu_debug_unmap_begin: Track start of iommu unmap operation, with
>    IOVA and size.
> - iommu_debug_unmap_end: Track the end of unmap operation, passing the
>    actual unmapped size versus the tracked one at unmap_begin.
> 
> We have to do the unmap_begin/end as once pages are unmapped we lose
> the information of the physical address.
> This is racy, but the API is racy by construction as it uses refcounts
> and doesn't attempt to lock/synchronize with the IOMMU API as that will
> be costly, meaning that possibility of false negative exists.
> 
> Signed-off-by: Mostafa Saleh<smostafa@google.com>
> ---
>   drivers/iommu/iommu-debug-pagealloc.c | 28 +++++++++++++
>   drivers/iommu/iommu-priv.h            | 58 +++++++++++++++++++++++++++
>   drivers/iommu/iommu.c                 | 11 ++++-
>   include/linux/iommu-debug-pagealloc.h |  1 +
>   4 files changed, 96 insertions(+), 2 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
