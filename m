Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB0335555
	for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774209085; cv=none; b=uGT3b7nWn+znfdVp7W46QPHGv76Eun3DqjB+u/bWkk/ggiX+pCDB/+9AONRAW4m6GFXKeEPMWPLYVFNyTe9nyAnHsd9vtUAO42Cu2PNvhZbwMMQA6K8V3aG5M/vEVDhY2XhmIONgXn0M3+El20lzcewzLkbBa8c3oLHSTzuUcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774209085; c=relaxed/simple;
	bh=H8bMlrg1SKZbRX70SdACGTVtsstYeoPjG91B26C0V3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPXhbxP+zj9m06mu9cGP3cA4t6JN4w5k3vDms4VRmX1BzksrOfA6ChHjDwieOxx+BFdaDTIICZI6B/mIFQm/XXPjA/U8GNG8peIDmbLIZFOG48E1ElGkp4FNv6AnV0GrQzTyKqCVSa09zl/60HcoJz0/oT0m4XA+kwM2+Qur1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaDnPMnK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaDnPMnK"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b052ec7176so110265ad.1
        for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774209081; x=1774813881; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aCThL1ZhFYzRAJQi2DmCEV8P9ItXpR5lKi0AST7r2K0=;
        b=iaDnPMnK6x2mSMkICLY6B2oiw9FplDcp2hJBhQUkU72jCQgjl5lTL3SWq+5GY+AUgR
         NT7cUlap7d1J63fjqYdmE/+//uqbYgAvd7SRVs8zd4lTTkeIWSiUDo8Okzt1U6R9ATvC
         xIGcqGkJrYr56K7sPZiSC0PI7HWyTE91bp8bhGCh7iXpQ6HssvwjyGdVjK/mOtDcn8nf
         wKCPYDs/dyPavq1tE8LB01lJAeCFrOxTiXGy57xlJO/FuWN9OuwkWMgRAySO3jaJNSpi
         JnjTB7gQDo2wCRTmq+9QXRT1AnPCh/bOkA6UF+y8QqafuWs/aR0ZuJYuBCKbSXr5j5hH
         7Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774209081; x=1774813881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCThL1ZhFYzRAJQi2DmCEV8P9ItXpR5lKi0AST7r2K0=;
        b=XiTg4zXGGI3LDT+WDzO/cWCKfTi2H/4Ms8pWFNq/OR3mOfToRk0IFlAxagELfeFyLN
         SzrJAhWk62J0Yx++BRawmNqwHozJqWMgtJH5RGfeWsrJAwILYTnqKr9YcgXfBP0VyS+G
         sfpZTSOMrxEGuyZ+DqCiIMYyyGMOtFRICnjAsEjVSNU1lopIQiBO7cDR0lg46VIAspTy
         JDFRz97PAs+RkYUlBxRgRwB24PeBUPJuG48MPN5Uy5w60lZfg0dUN7DIZAsE5E9JebN6
         MDUTFYJoMBPmrwsxAiNcR+Gufuh4/2VlBi38wHlrDXykvJa+X2mF/CW/Bd+h2v5N1PtL
         0GAg==
X-Forwarded-Encrypted: i=1; AJvYcCWkdIT0rJN05TRFA6yTTCiuifB3MIBH2pTq1laQOTieVSLJZHiLpJwuBe4mHbQyZIc2GJe69Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8iG8+fwvRv73s0KmiKIvoNqjOzWqjSxxfw2LjtXSYzqI8AxUn
	J73k0LY/sf+1aVtluKu2ynRZmhHQfPyc/B8EwODzjvhSYW41HZVTA6vERkigrGnczw==
X-Gm-Gg: ATEYQzynZrA5M4uuGIL7Q0MqW/JOIa4AvfsMR7cBXK5QJLlLVh3HSFXI8pO/x1J8aFs
	KgmQzA1rJKj42tcqDnmhp1ILXlgTIHH//oFdXz9HRbVSsdQ/OKrGTcnkf7vhSb6m0NfS3sxQ2XH
	KEn5eXal4dJ1yjppx5yw/Ev5dfgNdaz3H6ITp9DpWDOxn+kHgFWzb0LixtvJ7oqtpVwmch/Tytn
	eWjRUTf2jUhJN6uKljr60xSwcSogRyA7HrcNqzEPjg0GKXcICiIFJW3hsfquV0EMJb8NntNMTR/
	9ao8wnGJliYWC0Bk9qxYgXmm21wUSFcubudUa9fZDRPM+b/w3xVpLu1wphpEUN+e7C7N2jGpgXJ
	6SPE7iNmGtac2RSaWDwUPoiv/0QL8kD6bAsQKb+mtO1izRMIy99a2JFnEGp9Z4RUZBGrS6z3K64
	6n2erOVmtGNPftVgCdAyT1wdVjfDadxCx0XtjxAzYE2pKF/rX0661MSP3uoA==
X-Received: by 2002:a17:902:cf05:b0:2b0:4613:2e35 with SMTP id d9443c01a7336-2b08afa63f3mr3419215ad.0.1774209080552;
        Sun, 22 Mar 2026 12:51:20 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd412b73bsm7031592a91.15.2026.03.22.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 12:51:19 -0700 (PDT)
Date: Sun, 22 Mar 2026 19:51:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 07/14] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <acBIL052TH39FpNK@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-8-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-8-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:41PM +0000, Samiullah Khawaja wrote:
> During boot fetch the preserved state of IOMMU unit and if found then
> restore the state.
> 
> - Reuse the root_table that was preserved in the previous kernel.
> - Reclaim the domain ids of the preserved domains for each preserved
>   devices so these are not acquired by another domain.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/iommu.c      | 26 +++++++++++++++------
>  drivers/iommu/intel/iommu.h      |  7 ++++++
>  drivers/iommu/intel/liveupdate.c | 40 ++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c95de93fb72f..8acb7f8a7627 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -222,12 +222,12 @@ static void clear_translation_pre_enabled(struct intel_iommu *iommu)
>  	iommu->flags &= ~VTD_FLAG_TRANS_PRE_ENABLED;
>  }
>  
> -static void init_translation_status(struct intel_iommu *iommu)
> +static void init_translation_status(struct intel_iommu *iommu, bool restoring)
>  {
>  	u32 gsts;
>  
>  	gsts = readl(iommu->reg + DMAR_GSTS_REG);
> -	if (gsts & DMA_GSTS_TES)
> +	if (!restoring && (gsts & DMA_GSTS_TES))
>  		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
>  }
>  
> @@ -670,10 +670,16 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>  #endif
>  
>  /* iommu handling */
> -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
> +static int iommu_alloc_root_entry(struct intel_iommu *iommu, struct iommu_ser *restored_state)
>  {
>  	struct root_entry *root;
>  
> +	if (restored_state) {
> +		intel_iommu_liveupdate_restore_root_table(iommu, restored_state);
> +		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
> +		return 0;
> +	}

Instead of putting this inside the allocator, shouldn't init_dmars and
intel_iommu_add check for iommu_ser and call 
intel_iommu_liveupdate_restore_root_table() directly, bypassing the 
allocation entirely? This looks like it could be a stand-alone function
which has nothing to do with allocation.

> +
>  	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
>  	if (!root) {
>  		pr_err("Allocating root entry for %s failed\n",
> @@ -1614,6 +1620,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>  
>  static int __init init_dmars(void)
>  {
> +	struct iommu_ser *iommu_ser = NULL;
>  	struct dmar_drhd_unit *drhd;
>  	struct intel_iommu *iommu;
>  	int ret;
> @@ -1636,8 +1643,10 @@ static int __init init_dmars(void)
>  						   intel_pasid_max_id);
>  		}
>  
> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> +
>  		intel_iommu_init_qi(iommu);
> -		init_translation_status(iommu);
> +		init_translation_status(iommu, !!iommu_ser);
>  
>  		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>  			iommu_disable_translation(iommu);
> @@ -1651,7 +1660,7 @@ static int __init init_dmars(void)
>  		 * we could share the same root & context tables
>  		 * among all IOMMU's. Need to Split it later.
>  		 */
> -		ret = iommu_alloc_root_entry(iommu);
> +		ret = iommu_alloc_root_entry(iommu, iommu_ser);
>  		if (ret)
>  			goto free_iommu;
>  
> @@ -2110,15 +2119,18 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
>  static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>  {
>  	struct intel_iommu *iommu = dmaru->iommu;
> +	struct iommu_ser *iommu_ser = NULL;
>  	int ret;
>  

Nit: Add: /* Fetch the preserved context using MMIO base as a token */ ?

> +	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> +
>  	/*
>  	 * Disable translation if already enabled prior to OS handover.
>  	 */
> -	if (iommu->gcmd & DMA_GCMD_TE)
> +	if (!iommu_ser && iommu->gcmd & DMA_GCMD_TE)
>  		iommu_disable_translation(iommu);
>  
> -	ret = iommu_alloc_root_entry(iommu);
> +	ret = iommu_alloc_root_entry(iommu, iommu_ser);

I understand that iommu_get_preserved_data() will eventually return NULL
after the flb_finish op has executed (based on the LUO IOCTLs dropping
the incoming state), but I'm sensing a potential UAF/double-restore
issue here that could happen during the boot window.

I believe we could restore the same context multiple times? I see 
intel_iommu_add() is called from both dmar_device_add() and 
dmar_device_remove() paths, and the ACPI probe has the following 
sequence [1]:

static int acpi_pci_root_add(struct acpi_device *device, ...)
{
	// ...
	if (hotadd && dmar_device_add(handle)) {
		result = -ENXIO;
		goto end;
	}

	// ...
	root->bus = pci_acpi_scan_root(root);
	if (!root->bus) {
		// ...
		result = -ENODEV;
		goto remove_dmar;
	}
	// ...

remove_dmar:
	if (hotadd)
		dmar_device_remove(handle);
end:
	return result;
}

If we successfully restored a domain during dmar_device_add(), but the
ACPI probe fails later (e.g., pci_acpi_scan_root fails), we jump to 
remove_dmar. This tears down the DMAR unit, it unwinds via 
dmar_device_remove() which eventually calls dmar_iommu_hotplug(false)
where we:

	disable_dmar_iommu(iommu);
	free_dmar_iommu(iommu);

At this point, the root table folios are freed back to the allocator.

However, if a re-scan is then triggered before the FLB drops the 
incoming state, we would call:

dmar_device_add() -> intel_iommu_add() -> iommu_alloc_root_entry() again

Because the KHO state wasn't marked as deleted/consumed, 
iommu_get_preserved_data() will hand us the exact same iommu_ser pointer?

In which case, we'd call kho_restore_folio(iommu_ser->intel.root_table)
on a physical page that might have already been reallocated?

Shouldn't the restored state be explicitly marked as consumed
(obj.deleted = 1), and shouldn't the driver properly unpreserve/clean up
the KHO tracking during the free_dmar_iommu() teardown path?

>  	if (ret)
>  		goto out;
>  
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 70032e86437d..d7bf63aff17d 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1283,6 +1283,8 @@ int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_se
>  void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser);
>  int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
>  void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +					       struct iommu_ser *iommu_ser);
>  #else
>  static inline int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
>  {
> @@ -1301,6 +1303,11 @@ static inline int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_
>  static inline void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser)
>  {
>  }
> +
> +static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +							     struct iommu_ser *iommu_ser)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 82ba1daf1711..6dcb5783d1db 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -73,6 +73,46 @@ static int preserve_iommu_context(struct intel_iommu *iommu)
>  	return ret;
>  }
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
> +static int __restore_used_domain_ids(struct device_ser *ser, void *arg)
> +{
> +	int id = ser->domain_iommu_ser.did;
> +	struct intel_iommu *iommu = arg;
> +

Shouldn't we check if the did actually belongs to the iommu instance?
iommu_for_each_preserved_device() iterates over all preserved devices in
the system. However, here (__restore_used_domain_ids) we allocate the 
device's did in the current iommu->domain_ida without checking if that
device actually belongs to the current IOMMU?

On multi-IOMMU systems, this will cause every IOMMU's IDA to be
cross-polluted with the domain IDs of devices attached to other IOMMUs.
We must verify the device belongs to this specific IOMMU first, maybe:

if (ser->domain_iommu_ser.iommu_phys != iommu->reg_phys)
		return 0;

> +	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
> +	return 0;
> +}
> +
> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +					       struct iommu_ser *iommu_ser)
> +{
> +	BUG_ON(!kho_restore_folio(iommu_ser->intel.root_table));
> +	iommu->root_entry = __va(iommu_ser->intel.root_table);
> +
> +	restore_iommu_context(iommu);
> +	iommu_for_each_preserved_device(__restore_used_domain_ids, iommu);
> +	pr_info("Restored IOMMU[0x%llx] Root Table at: 0x%llx\n",
> +		iommu->reg_phys, iommu_ser->intel.root_table);
> +}
> +
>  int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.0-rc4/source/drivers/acpi/pci_root.c#L728
