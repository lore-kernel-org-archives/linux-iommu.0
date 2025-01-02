Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60838F5B
	for <iommu@lists.linux.dev>; Thu,  2 Jan 2025 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735787751; cv=none; b=PO0WLQ0b2yw3NTShOemwX9Idp69q6BJuzndGcDfGa98wNB8rWY/guLCPyWSUNf9i/498J+OdUNITN+TMVM5mgJFY6+mPCu34Ce+v7/g5ZlrySxK55qxy3U9XPDkAxvBT3DJaRqZPTIc1ZD5Lpzoa2bl5zjcAQThU1+GT3FwCe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735787751; c=relaxed/simple;
	bh=2wbmftJym0yyymB+UYPZydgGM44Lq28ISsDSJcaq6LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8wGdakh6BsBF6A+0NnI5yzogOiuOe+eUww9mNAXFtPNM3oCkJuSLRKq4KqiU+k2JfsLZa2atZ3BAXzkeMQHv8oAG1QIqoZdrGWaQxckdSkJL2hqlY4kwh5Oo5j72nZu+FoKeuwxgEDVSXObdcoc6R4HyPvmFWFGWiqZos6du2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lw/fTnl4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lw/fTnl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735787749; x=1767323749;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2wbmftJym0yyymB+UYPZydgGM44Lq28ISsDSJcaq6LA=;
  b=Lw/fTnl4Yo17lxF1+8sf4tvVRVG76Sxyrc6ksaVu016HcOSbjW417s84
   dO5Ij5UYXt3svgmFo9veWJJqBcF9yVEYNSt5+ADVKpGURwo/ai8yxQ4SY
   UL5KLyqu0VnKJ/6WWc7/MalEDAr0Ni8393LNbvmAkoe4TgjUz7nePvky2
   bYZhKJhpIr0eLywdxnYOyjn9XOfL9zwvIlPbsXo3LVuhDveY2Kp1DEdL+
   OUnq1yW3nw7PGvuN+Cu4fsEjyK0RtUkVoL2PGr2qtAZ7GdWX4jvUDARA8
   WA8kMTYRarSml2IQfGuukqWCdsY9/dD+HqX5As7F9czdmoaU1ZktbpcZa
   A==;
X-CSE-ConnectionGUID: vnqVyEXYSx+Dm0rMB6IBNw==
X-CSE-MsgGUID: whHHtbfoRDuKY8YWvNHF6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="47015028"
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="47015028"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:15:48 -0800
X-CSE-ConnectionGUID: 2UEzaTBtSgaf0gVoHcjEHQ==
X-CSE-MsgGUID: bl2aJrsTTAqMwSD4uA/k1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102238929"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:15:47 -0800
Message-ID: <a623fb4b-ce39-4a53-9bed-8568bc3fd076@linux.intel.com>
Date: Thu, 2 Jan 2025 11:13:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Draining PRQ in sva unbind path when FPD
 bit set
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241217024240.139615-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241217024240.139615-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:42, Lu Baolu wrote:
> When a device uses a PASID for SVA (Shared Virtual Address), it's possible
> that the PASID entry is marked as non-present and FPD bit set before the
> device flushes all ongoing DMA requests and removes the SVA domain. This
> can occur when an exception happens and the process terminates before the
> device driver stops DMA and calls the iommu driver to unbind the PASID.
> 
> There's no need to drain the PRQ in the mm release path. Instead, the PRQ
> will be drained in the SVA unbind path. But in such case,
> intel_pasid_tear_down_entry() only checks the presence of the pasid entry
> and returns directly.
> 
> Add the code to clear the FPD bit and drain the PRQ.
> 
> Suggested-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 22 +++++++++++++++++++++-
>   drivers/iommu/intel/pasid.h |  6 ++++++
>   2 files changed, 27 insertions(+), 1 deletion(-)

Queued for v6.14.
