Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D33A7F5F
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144724; cv=none; b=aUI+H3hJSUTr/p1uVJRBbDGhtjmq1W4O1ESzJM6HwJXF2GJRNu0IQEuHkELQdvtTnHYYY//9bpoRi/MzKaMGzEc3qMQ27Qv3g3Vb+/pefWBAKU3wTOGyYwl57pUGIkGsuXTH6CU/zcPcuzimWsaME8rqVw9LSrnIejI8J47mPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144724; c=relaxed/simple;
	bh=urMm9QHvMt26Vg3gkkRj33qfSQ4pD/CUxXveH/XzMmY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rjP8fSjn9yqw76Ao62oqstD34LMXxHXvuwfS0W4QHFML6iOHPTYifE8meqwHe0//xn5u5ukWe07QB0BRhwFNNh6Ul9wf7pKsJ76a90Kq3VIoFvhQUOfKnwuamtxR+pl5zFE2/XD0fW99c2/ujx3j6JkT9w4OV9yO8dgcvG/Y1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0ntcFYW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0ntcFYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778144720; x=1809680720;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=urMm9QHvMt26Vg3gkkRj33qfSQ4pD/CUxXveH/XzMmY=;
  b=W0ntcFYWKVek2vER61kxSV6yOU5nN5bI8MIGkzeR41VQYKgiBIPGg+67
   kkJJ5hEuBP2uOOv8JjRPIiFhAu4/E4Nc6ytrDWA+uCjoiCadOesjFkGnZ
   RE4swfhqJgrTqs49drUCw439rxUOlVHVKyvGaJcrKzq7nifnJLoTBj2AP
   qJ6eGV4yo/ijoKAxaC/+r5RMz/B0GTuGL+872tG9oGXOutvdQV4/j1d6s
   x3OoQBF/Ss7dLzhUFiLNe+xONBUOSxpxzyf160ZlQoY2ogSwa1h6ZOcI/
   0+c1WvXa8TW86AKt4aozZM/Hx9IAtYmPYNgozSqJBiRyTaHGU2UwI7gQ6
   g==;
X-CSE-ConnectionGUID: 0iO7yRj5SV6t/MZ2WAONAg==
X-CSE-MsgGUID: QFxNXgS0SkarTrtucXrUQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89785038"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="89785038"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:05:15 -0700
X-CSE-ConnectionGUID: 21NdPKWYTEK3fWqGKg/nUg==
X-CSE-MsgGUID: zzXtSJlVSpW4mlIhk4zNPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="231865139"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:05:10 -0700
Message-ID: <ad4f1b2c-a79a-4dce-b891-c0df92664a56@linux.intel.com>
Date: Thu, 7 May 2026 17:05:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 09/16] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-10-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260427175633.1978233-10-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/2026 1:56 AM, Samiullah Khawaja wrote:
> During boot fetch the preserved state of IOMMU unit and if found then
> restore the state.
> 
> - Reuse the root_table that was preserved in the previous kernel.
> - Reclaim the domain ids of the preserved domains for each preserved
>    devices so these are not acquired by another domain.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      | 55 ++++++++++++++++++++++--------
>   drivers/iommu/intel/iommu.h      |  7 ++++
>   drivers/iommu/intel/liveupdate.c | 57 ++++++++++++++++++++++++++++++++
>   3 files changed, 105 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 68fecd4e57fa..4118a0861f38 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -670,10 +670,17 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>   #endif
>   
>   /* iommu handling */
> -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
> +static int iommu_alloc_root_entry(struct intel_iommu *iommu,
> +				  struct iommu_hw_ser *iommu_ser)
>   {
>   	struct root_entry *root;
>   
> +	if (iommu_ser) {
> +		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
> +		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);

The root table is already active and being used by the hardware at this
point, correct? Since the CPU should not be modifying an active table,
the __iommu_flush_cache() call seems unnecessary and potentially risky.

Furthermore, if the iommu state has been restored, is it necessary to
call iommu_set_root_entry()? Calling it would essentially replace an
active, in-use root table with an identical one, which appears
redundant.

> +		return 0;
> +	}
> +
>   	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
>   	if (!root) {
>   		pr_err("Allocating root entry for %s failed\n",

Thanks,
baolu
