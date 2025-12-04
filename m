Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24612C11F6
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764830895; cv=none; b=d9bXH7lSIqPwxT00TTF0FdKsRCkqGfueea1dw1UhUoFbvf137ijflssMzd2vnw6TpFil0mW0pDxy4IZ688J4xRNIy3m1wFiRYwkN+mIpLcGf8NuJy/+dlYF+nYYMHEVgnrRqHT3NqLCk4bEupESo1D0XYz1q2HyPiRJbMCq1jOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764830895; c=relaxed/simple;
	bh=/0Fd9BRwvenWOb5NUDU4hkYMAK72J2r7D7RQ/FooTKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ON116mcrxQDE9C9oPHE4Zracxc2jhu6/BUbeBGQh61oGQD8+JumenX9zGum0c/8SGvnB6ImRKSZMvls6H5gwtNw7Jg+xoX3+S9rLMk8BSIC0xVPTAOojk1oZXnNi5TdDv+3zb0kuDwtmgiA28ebeF3EUwdBn+QNSU6Unfv5lqYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5Pg7CAv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5Pg7CAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764830894; x=1796366894;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/0Fd9BRwvenWOb5NUDU4hkYMAK72J2r7D7RQ/FooTKo=;
  b=K5Pg7CAv4gLanEAxELrK3RsS0bGeOx6oJHGuVmGIJSUxZUYlbVE6andc
   931bxGXUeETguU3gxG1Xki5jV/d4NIEUU4EOcxMy+MfdpVQF5gSxgDhl4
   GJSHPEHzcUUMLMJHdlgwfrunH+LEtu0nQZT95ZvpqcBq/waTfN+MXygWZ
   IBo9N5oovjmt2vFOR8wg0V3n47LRkdNZq8ofvAt3KVehp3FZ9bEdR6eL6
   Dn1nyyqKmghaoA5fNzpnefInuMuaKgXEdvfyTYYS9Bw7TIDh/gL+ShF7S
   ui8c5BRMhcuoomH+GubV/nq18hu3/TOKmtdQhH3hMRiJqWDXu0GuaXkN0
   A==;
X-CSE-ConnectionGUID: q3syBwjpT1i5JmOoPNS2tQ==
X-CSE-MsgGUID: cYOs3ruISOmzcAHu0IdIUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66801538"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="66801538"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 22:48:13 -0800
X-CSE-ConnectionGUID: /FOaJp/ZRLKvDAWFCJrS7A==
X-CSE-MsgGUID: ALQEnVsaQ/qlcD6+Dr72Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="225570968"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 22:48:07 -0800
Message-ID: <b05a1dd0-9692-4bf7-8fa0-0b3857178d1b@linux.intel.com>
Date: Thu, 4 Dec 2025 14:43:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 24/32] iommu/vt-d: restore state of the preserved
 IOMMU
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav
 <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Vipin Sharma <vipinsh@google.com>,
 dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>,
 Chris Li <chrisl@kernel.org>, praan@google.com
References: <20251202230303.1017519-1-skhawaja@google.com>
 <20251202230303.1017519-25-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251202230303.1017519-25-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:02, Samiullah Khawaja wrote:
> During boot fetch the preserved state of IOMMU unit and if found then
> restore the state. Reuse the root_table that was preserved in the
> previous kernel.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      | 30 ++++++++++++++++++++++++------
>   drivers/iommu/intel/iommu.h      |  2 ++
>   drivers/iommu/intel/liveupdate.c | 30 ++++++++++++++++++++++++++++++
>   3 files changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 84fef81ecf4d..888351f91918 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -224,12 +224,12 @@ static void clear_translation_pre_enabled(struct intel_iommu *iommu)
>   	iommu->flags &= ~VTD_FLAG_TRANS_PRE_ENABLED;
>   }
>   
> -static void init_translation_status(struct intel_iommu *iommu)
> +static void init_translation_status(struct intel_iommu *iommu, bool restoring)
>   {
>   	u32 gsts;
>   
>   	gsts = readl(iommu->reg + DMAR_GSTS_REG);
> -	if (gsts & DMA_GSTS_TES)
> +	if (!restoring && (gsts & DMA_GSTS_TES))
>   		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
>   }
>   
> @@ -672,10 +672,18 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>   #endif
>   
>   /* iommu handling */
> -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
> +static int iommu_alloc_root_entry(struct intel_iommu *iommu, struct iommu_ser *restored_state)
>   {
>   	struct root_entry *root;
>   
> +#if CONFIG_LIVEUPDATE

nit: Is it possible to hide the "IS_ENABLED(CONFIG_LIVEUPDATE)" and "#if
CONFIG_LIVEUPDATE" checks within the header files?

> +	if (restored_state) {
> +		intel_iommu_liveupdate_restore_root_table(iommu, restored_state);
> +		/* Should not be needed since the entries are already cleaned in last kernel. */
> +		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
> +		return 0;
> +	}
> +#endif
>   	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
>   	if (!root) {
>   		pr_err("Allocating root entry for %s failed\n",
> @@ -1616,6 +1624,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>   
>   static int __init init_dmars(void)
>   {
> +	struct iommu_ser *iommu_ser = NULL;
>   	struct dmar_drhd_unit *drhd;
>   	struct intel_iommu *iommu;
>   	int ret;
> @@ -1638,8 +1647,12 @@ static int __init init_dmars(void)
>   						   intel_pasid_max_id);
>   		}
>   
> +#if IS_ENABLED(CONFIG_LIVEUPDATE)
> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> +#endif
> +
>   		intel_iommu_init_qi(iommu);
> -		init_translation_status(iommu);
> +		init_translation_status(iommu, !!iommu_ser);
>   
>   		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>   			iommu_disable_translation(iommu);
> @@ -1653,7 +1666,7 @@ static int __init init_dmars(void)
>   		 * we could share the same root & context tables
>   		 * among all IOMMU's. Need to Split it later.
>   		 */
> -		ret = iommu_alloc_root_entry(iommu);
> +		ret = iommu_alloc_root_entry(iommu, iommu_ser);
>   		if (ret)
>   			goto free_iommu;
>   
> @@ -2112,6 +2125,7 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
>   static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>   {
>   	struct intel_iommu *iommu = dmaru->iommu;
> +	struct iommu_ser *iommu_ser = NULL;
>   	int ret;
>   
>   	/*
> @@ -2120,7 +2134,11 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>   	if (iommu->gcmd & DMA_GCMD_TE)
>   		iommu_disable_translation(iommu);
>   
> -	ret = iommu_alloc_root_entry(iommu);
> +#if IS_ENABLED(CONFIG_LIVEUPDATE)
> +	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> +#endif
> +
> +	ret = iommu_alloc_root_entry(iommu, iommu_ser);
>   	if (ret)
>   		goto out;
>   
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 1eb60ce1300f..b0c56e27f167 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1283,6 +1283,8 @@ int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_se
>   void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser);
>   int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
>   void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +					       struct iommu_ser *iommu_ser);
>   bool intel_iommu_liveupdate_clear_context_entries(struct intel_iommu *iommu);
>   #endif
>   
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 3f8c7f15bc36..140887187084 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -73,6 +73,36 @@ static int preserve_iommu_context(struct intel_iommu *iommu)
>   	return ret;
>   }
>   
> +static void restore_iommu_context(struct intel_iommu *iommu)
> +{
> +	struct context_entry *context;
> +	int i;
> +
> +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
> +		context = iommu_context_addr(iommu, i, 0, 0);
> +		if (context)
> +			BUG_ON(!kho_restore_folio(virt_to_phys(context)));
> +
> +		if (!sm_supported(iommu))
> +			continue;
> +
> +		context = iommu_context_addr(iommu, i, 0x80, 0);
> +		if (context)
> +			BUG_ON(!kho_restore_folio(virt_to_phys(context)));
> +	}
> +}
> +
> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +					       struct iommu_ser *iommu_ser)
> +{
> +	BUG_ON(!kho_restore_folio(iommu_ser->intel.root_table));
> +	iommu->root_entry = __va(iommu_ser->intel.root_table);
> +
> +	restore_iommu_context(iommu);
> +	pr_info("Restored IOMMU[0x%llx] Root Table at: 0x%llx\n",
> +		iommu->reg_phys, iommu_ser->intel.root_table);
> +}
> +
>   int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);

Thanks,
baolu
