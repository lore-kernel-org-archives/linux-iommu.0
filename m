Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774044;
	b=DbnC76kE0iHMR1UvlSAmMytFa87hyqk0mEUBCOSWI1hVVKr6SAZ+E72FXbofr4ufr+t8
	 0TOk541mFWyTn7wggjJckeYWxzsvaLy7Mf4ECaFxYv0OkK3d/vovxwxD1pUtjNS0IyzKb
	 0Jsjb2Ox3hvIFd3ZvirDsuwy3U0iLoNSPc73TTfvQ9QOVNxi/tTbt702t8MhR9ULyQvD8
	 aEW2aufplLn3rFQMNBryXXil4Z8eSXFIiakw7amXG96AkGxzhztShH8t4S9OHY2i62tU4
	 i1oFFew7r7iPHcWtribPniPILKidU3Q0xcFMx+8iEzNOPz0paXwWnWNuBG5WKc+QA3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774044;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nQh0HxRZJOo1g9eMX3ok2krtTe6kcOHVKe01GJEuzZg=;
	b=iC0m/lCPFbKvu59ohMTmqUjG3qVY3l3gMhAVYhiMrCVqUEsoyUD1OFj764lrbLpwZkzQ
	 4j2esLkRGt3hyMenxnPMDcuDH+IBRGe8wyty0w69sUMWXwGtFvrbe8tz7+YXO352elQwo
	 m8llitJSUbfVD1CJ0DHYLzQYCtDboapNBBxJT4tlUL6Ihi6q8D3pIR6eBfJSkN08UqvcM
	 4WQ/8Tpr9Sgsm+BBy5K297VYIRPjUeU5iyHu/I+SFONMFWEsfTMMdta9NBfz69c8xjPKy
	 nJ/eZdmgufnQLvF63BkwYgMDoAV6ffAYYT5d3oTJXzjaP3G1PB1O2MNF1ukBPFEL/fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n0yxHqZl;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132E606A331;
	Fri, 27 Nov 2026 10:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1132E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n0yxHqZl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795774044; x=1827310044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SIdNDwakLoJc/r9zzh1dEftOcZlld4iiIQC3fzpqKBg=;
  b=n0yxHqZl3aKlOz2Pv8TEcxpjNeslA8sJYdLs1oK5lhfFyG9nvm8Ds2jL
   GMU3xwO6gmevk7TZgFq1DkNc89ACP1vZDABbbdjuFv2IyjxRACHwPWUvZ
   8FpzCEOpYyyV7Vsm1LbXBJPC7JsGxTHDBDCAJdEU6YX9iph41i0NMmkX/
   zuKuFLtjWiG68KnnBHlXShLl2ct19mx/JhdiDJIUDQcP1IyIOtrkkQPrZ
   DC76P3Vai023/paBJwTCu1LGZf8pRsV4MN7kQA/GFM8ruy1Xny3LCxSeA
   rib1jg6ho9s9ixfvH64dAXfX7IOyX9wsFgbj5NcdUsr/ltt1x1oDuygDs
   g==;
X-CSE-ConnectionGUID: V6oGyEGfTRq1xCQ0wIojBg==
X-CSE-MsgGUID: XAbmtlH4SNmFnnWNbGCR2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4652120"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4652120"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 02:07:23 -0800
X-CSE-ConnectionGUID: AhC/xHkBRQyccQuyLWfOqw==
X-CSE-MsgGUID: yUV2kTuURSaC3NtYCKVqwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12512273"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa001.jf.intel.com with ESMTP; 27 Nov 2026 02:07:20 -0800
Date: Fri, 27 Nov 2026 17:57:07 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] coco/tdx-host: Enable trusted DMA on IOMMUs on
 device connect
Message-ID: <awlT8wJYM3q1xMr7@yilunxu-OptiPlex-7050>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-10-baolu.lu@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112043054.2664857-10-baolu.lu@linux.intel.com>

>  static int tdx_tsm_link_connect(struct pci_dev *pdev)
>  {
> +	int ret;
> +
> +	ret = tdx_iommu_get(pdev);
> +	if (ret)
> +		return ret;
> +
> +	/* TDISP connect is not implemented yet. */
> +	tdx_iommu_put(pdev);

In TDX, usually we prevent the on-going feature implementation from
reachable by a stub and finally enable it when full support lands,
like 1e3d79135327. So can we do like that?

Oh, we've already done this in Patch 7.

>  	return -ENXIO;
>  }

[...]

> +/* These describe the trusted invalidation queue buffers. */
> +#define IQ_BUFFER_PAGES		2
> +#define IQ_BUFFER_SIZE		SZ_8K

I don't think we have to define 2 instant values, how about?

  #define IQ_BUFFER_SIZE		IQ_BUFFER_PAGES * SZ_4K

> +
> +/*
> + * Represents a list of pages for TDX module defined IOMMU_MT object.
> + * Typically it uses a "root page" as the medium to exchange a list of
> + * data pages between host and TDX module.
> + */
> +struct tdx_iommu_pages {
> +	struct tdx_iommu_mt_param *root;
> +	void **pages;
> +	unsigned int nr_entries;
> +};
> +
> +/**
> + * struct tdx_iommu - Host state of an IOMMU in Secure TDX Mode
> + * @node: Link in tdx_iommu_list
> + * @params: IOMMU information from the VT-d driver
> + * @tdx_iommu_id: Identifier returned by TDH.IOMMU.SETUP
> + * @mt_pages: Pages handed to the TDX module by TDH.IOMMU.SETUP
> + * @users: Number of devices using trusted DMA through this IOMMU
> + * @stuck: TDH.IOMMU.CLEAR failed. The TDX module may still own
> + *	   @mt_pages, so they are leaked and the IOMMU is not reused.
> + */
> +struct tdx_iommu {
> +	struct list_head node;
> +	struct dmar_tdxc_params params;
> +	u64 tdx_iommu_id;
> +	struct tdx_iommu_pages *mt_pages;
> +	unsigned int users;
> +	bool stuck;
> +};
> +
> +/*
> + * Serializes the refcounts together with TDH.IOMMU.SETUP and
> + * TDH.IOMMU.CLEAR, so a device can't join an IOMMU that is being
> + * cleared, or one whose setup hasn't finished.
> + */
> +static DEFINE_MUTEX(tdx_iommu_lock);
> +static LIST_HEAD(tdx_iommu_list);
> +
> +static void *tdx_iommu_alloc_pages(int node, size_t size)
> +{
> +	struct folio *folio;
> +
> +	if (node == NUMA_NO_NODE)
> +		node = numa_mem_id();
> +
> +	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, get_order(size), node);
> +	if (!folio)
> +		return NULL;
> +
> +	return folio_address(folio);
> +}
> +
> +static void tdx_iommu_free_pages(void *virt)
> +{
> +	if (!virt)
> +		return;
> +
> +	folio_put(virt_to_folio(virt));
> +}
> +
> +/* Number of 4K pages backing IOMMU_MT entry @i. */
> +static unsigned int mt_entry_nr_pages(unsigned int i)
> +{
> +	return i < TDX_IOMMU_MT_IQ_NR ? IQ_BUFFER_SIZE >> PAGE_SHIFT : 1;
> +}
> +

[...]

> +static void free_mt_pages(struct tdx_iommu_pages *array)
> +{
> +	unsigned int i;
> +
> +	if (IS_ERR_OR_NULL(array))
> +		return;
> +
> +	mt_pamt_put(array, UINT_MAX);
> +
> +	for (i = 0; i < array->nr_entries; i++)
> +		tdx_iommu_free_pages(array->pages[i]);
> +
> +	tdx_iommu_free_pages(array->root);

The root page is just to hold ABI params, doesn't have to be kept until
we exit TDX mode.

> +	kfree(array->pages);
> +	kfree(array);

Maybe we don't need so many objects to hold mt page info, see below...

> +}
> +
> +DEFINE_FREE(free_mt_pages, struct tdx_iommu_pages *, free_mt_pages(_T))
> +
> +static void **alloc_mt_pages(unsigned int nr_entries, int node)
> +{
> +	unsigned int i;
> +	void **pages;
> +	void *vaddr;
> +
> +	pages = kzalloc_objs(*pages, nr_entries);
> +	if (!pages)
> +		return NULL;
> +
> +	/* Allocate two contiguous buffers for the invalidation queue. */
> +	pages[0] = tdx_iommu_alloc_pages(node, IQ_BUFFER_SIZE);
> +	if (!pages[0])
> +		goto free_pages;
> +
> +	pages[1] = tdx_iommu_alloc_pages(node, IQ_BUFFER_SIZE);
> +	if (!pages[1])
> +		goto free_pages;
> +
> +	/* Allocate the required number of pages for the IOMMU metadata. */
> +	for (i = TDX_IOMMU_MT_IQ_NR; i < nr_entries; i++) {
> +		vaddr = tdx_iommu_alloc_pages(node, SZ_4K);
> +		if (!vaddr)
> +			goto free_pages;
> +		pages[i] = vaddr;
> +	}

I'm wondering if we could make the page allocation/free/populate simpler,
how about allocating a contiguous page bulk, like:

  unsigned int nr_pages = sysinfo->tdx_connect.iommu_mt_page_count +
				TDX_IOMMU_MT_IQ_NR * IQ_BUFFER_PAGES;
  void *iommu_mt_pages;

  iommu_mt_pages = alloc_pages_exact_nid(node, nr_pages, ...);

Making all pages contiguous is more than needed but it saves a lot of LOC,
is it? We don't need to allocate void **pages, maybe we don't even need
to define struct tdx_iommu_pages.

> +
> +	return pages;
> +
> +free_pages:
> +	for (i = 0; i < nr_entries; i++)
> +		tdx_iommu_free_pages(pages[i]);
> +	kfree(pages);
> +
> +	return NULL;
> +}
> +
> +static void populate_mt_pages(struct tdx_iommu_pages *array)
> +{
> +	struct tdx_iommu_mt_param *param = array->root;
> +	void **pages = array->pages;
> +	unsigned int i;
> +
> +	for (i = 0; i < TDX_IOMMU_MT_IQ_NR; i++)
> +		param->iq[i] = __pa(pages[i]) | IQ_BUFFER_PAGES;
> +
> +	for (; i < array->nr_entries; i++)
> +		param->mt[i - TDX_IOMMU_MT_IQ_NR] = __pa(pages[i]);
> +}
> +
> +/* Allocate the IOMMU_MT pages with PAMT backing. Free with free_mt_pages(). */
> +static struct tdx_iommu_pages *alloc_iommu_mt(int node, unsigned int nr_mt_pages)
> +{
> +	unsigned int nr_entries = nr_mt_pages + TDX_IOMMU_MT_IQ_NR;
> +	struct tdx_iommu_pages *array;
> +	unsigned int i;
> +	int ret = -ENOMEM;
> +
> +	if (!nr_mt_pages || nr_mt_pages > TDX_IOMMU_MT_MAX_PAGES)
> +		return ERR_PTR(-EINVAL);
> +
> +	array = kzalloc_obj(*array);
> +	if (!array)
> +		return ERR_PTR(-ENOMEM);
> +
> +	array->root = tdx_iommu_alloc_pages(node, sizeof(*array->root));

The root page is just to hold the ABI parameter, doesn't have to
allocate per node, is it?

> +	if (!array->root)
> +		goto free_array;
> +
> +	array->nr_entries = nr_entries;
> +	array->pages = alloc_mt_pages(nr_entries, node);
> +	if (!array->pages)
> +		goto free_root;
> +
> +	populate_mt_pages(array);
> +
> +	ret = mt_pamt_get(array);
> +	if (ret)
> +		goto free_pages;
> +
> +	return array;
> +
> +free_pages:
> +	for (i = 0; i < nr_entries; i++)
> +		tdx_iommu_free_pages(array->pages[i]);
> +	kfree(array->pages);
> +free_root:
> +	tdx_iommu_free_pages(array->root);
> +free_array:
> +	kfree(array);
> +	return ERR_PTR(ret);
> +}
> +
> +static struct tdx_iommu *tdx_iommu_find(u64 reg_base_addr)
> +{
> +	struct tdx_iommu *tiommu;
> +
> +	lockdep_assert_held(&tdx_iommu_lock);
> +
> +	list_for_each_entry(tiommu, &tdx_iommu_list, node)
> +		if (tiommu->params.reg_base_addr == reg_base_addr)
> +			return tiommu;
> +
> +	return NULL;
> +}
> +
> +/* Allocate the IOMMU_MT pages and issue TDH.IOMMU.SETUP. */
> +static int tdx_iommu_setup(struct pci_dev *pdev, struct tdx_iommu *tiommu)
> +{
> +	const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
> +	struct dmar_tdxc_params *params = &tiommu->params;
> +	u64 r, tdx_iommu_id;
> +	int ret;
> +
> +	if (!sysinfo)
> +		return -ENXIO;
> +
> +	struct tdx_iommu_pages *mt __free(free_mt_pages) =
> +			alloc_iommu_mt(params->node,
> +				       sysinfo->tdx_connect.iommu_mt_page_count);
> +	if (IS_ERR(mt))
> +		return PTR_ERR(mt);
> +
> +	ret = dmar_tdxc_acquire(pdev, params);
> +	if (ret)
> +		return ret;
> +
> +	r = tdh_iommu_setup(params->reg_base_addr, mt->root, &tdx_iommu_id);
> +	if (r) {
> +		dmar_tdxc_release(pdev, params);
> +		pr_err("TDH.IOMMU.SETUP failed, regbase 0x%llx status 0x%llx\n",
> +		       params->reg_base_addr, r);
> +		return -EIO;
> +	}
> +
> +	tiommu->tdx_iommu_id = tdx_iommu_id;
> +	tiommu->mt_pages = no_free_ptr(mt);
> +
> +	pr_info("Trusted DMA initialized, regbase 0x%llx\n", params->reg_base_addr);
> +
> +	return 0;
> +}
> +
> +/* Issue TDH.IOMMU.CLEAR and release what TDH.IOMMU.SETUP took. */
> +static int tdx_iommu_clear(struct pci_dev *pdev, struct tdx_iommu *tiommu)
> +{
> +	u64 r;
> +
> +	r = tdh_iommu_clear(tiommu->tdx_iommu_id);
> +	if (r) {
> +		pr_err("TDH.IOMMU.CLEAR failed, regbase 0x%llx tdx_iommu_id 0x%llx status 0x%llx\n",
> +		       tiommu->params.reg_base_addr, tiommu->tdx_iommu_id, r);
> +		/* The pages and their PAMT backing stay with the TDX module. */
> +		return -EIO;
> +	}
> +
> +	dmar_tdxc_release(pdev, &tiommu->params);
> +	free_mt_pages(tiommu->mt_pages);
> +	tiommu->mt_pages = NULL;
> +
> +	return 0;
> +}
> +
> +/*
> + * tdx_iommu_get() - Enable trusted DMA on the IOMMU translating a device
> + * @pdev: PCI device that will use trusted DMA
> + *
> + * The first device behind an IOMMU transitions that IOMMU into Secure
> + * TDX Mode. Later devices only take a reference. Every successful call
> + * must be balanced by tdx_iommu_put().
> + *
> + * Return: 0 on success and error number on failure.
> + */
> +int tdx_iommu_get(struct pci_dev *pdev)
> +{
> +	struct dmar_tdxc_params params;
> +	struct tdx_iommu *tiommu;
> +	int ret;
> +
> +	ret = dmar_tdxc_get_params(pdev, &params);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&tdx_iommu_lock);
> +
> +	tiommu = tdx_iommu_find(params.reg_base_addr);
> +	if (tiommu) {
> +		if (tiommu->stuck)
> +			return -EBUSY;
> +		if (WARN_ON(tiommu->users == UINT_MAX))
> +			return -EOVERFLOW;
> +		tiommu->users++;
> +		return 0;
> +	}
> +
> +	tiommu = kzalloc_obj(*tiommu);
> +	if (!tiommu)
> +		return -ENOMEM;
> +
> +	tiommu->params = params;
> +	ret = tdx_iommu_setup(pdev, tiommu);
> +	if (ret) {
> +		kfree(tiommu);
> +		return ret;
> +	}
> +
> +	tiommu->users = 1;
> +	list_add(&tiommu->node, &tdx_iommu_list);
> +
> +	return 0;
> +}
> +
> +/*
> + * tdx_iommu_put() - Drop a reference taken by tdx_iommu_get()
> + * @pdev: Same device passed to tdx_iommu_get()
> + *
> + * The last device behind an IOMMU takes that IOMMU out of Secure TDX

I'm wondering if we really needs to take the IOMMU out of TDX mode when
all devices are disconnected. Imagine people connect a device,
disconnect and reconnect because of link error, why bother switch TDX
mode and reserve/release DomainIDs again and again?

Previously we setup TDX mode for all IOMMUs at tdx-host probe, that's
not a bad idea except quite a waste of resouces (e.g. DomainID). There
may even be no TSM capable device plugged.

Now we setup TDX mode per IOMMU on-demand, that solves the concern. We
don't really need runtime switch off. We don't have to let another device
gets a big DID then fail the reconnect.

How about we only exit TDX mode for all IOMMUs on module unload, can
that simplify some logic like user count, stuck? and locking? There will
be no connect after we unregister TSM.

Thanks

> + * Mode. If TDH.IOMMU.CLEAR fails, the TDX module may still own the
> + * IOMMU_MT pages, so they are leaked. The IOMMU then stays in Secure TDX
> + * Mode, later tdx_iommu_get() calls for it fail, and the module can no
> + * longer be unloaded.
> + */
> +void tdx_iommu_put(struct pci_dev *pdev)
> +{
> +	struct dmar_tdxc_params params;
> +	struct tdx_iommu *tiommu;
> +
> +	if (WARN_ON(dmar_tdxc_get_params(pdev, &params)))
> +		return;
> +
> +	guard(mutex)(&tdx_iommu_lock);
> +
> +	tiommu = tdx_iommu_find(params.reg_base_addr);
> +	if (WARN_ON(!tiommu || tiommu->stuck || !tiommu->users))
> +		return;
> +
> +	if (--tiommu->users)
> +		return;
> +
> +	if (tdx_iommu_clear(pdev, tiommu)) {
> +		/* VT-d still sees it acquired; don't let unload forget it. */
> +		if (try_module_get(THIS_MODULE)) {
> +			tiommu->stuck = true;
> +			return;
> +		}
> +		/* Unloading: free the entry; IOMMU_MT pages stay leaked. */
> +	}
> +
> +	list_del(&tiommu->node);
> +	kfree(tiommu);
> +}
> -- 
> 2.43.0
> 
