Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409510;
	b=ZWjrGcfyptmG8lmzzq5rhmkJ1ZFBK1KOICkTYUnHmgTsoV3VSrRM3Fn0+NK6WLrVM/kW
	 cEpWtpNi9KNYNRH4Yg6vW+QD5BbpaosINvGfyXGWJWgNlqSf7AUc+fkL3Y/hQXbRW2oyz
	 HM/Mk0esn9COws0+yfDB+drNWC8bpuGs0hBL2HRT0XxooxxmbGPTlLsoujnOZwXY+H8jC
	 LqG5L0NgXpzsd3yaz/bGr/3A+tipV1pkBSpYyh5dpQsQQ8MGavLMLjnjhEjzGhrlVggin
	 QcbGLhPmFdqGcphoyDMKBCXLXFWOXwF93u811xc+rEjX2UXRtmyj3keeH7wEn5CL9Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409510;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7fAmMaiUPDgzxUIirHcZv/9ixx+ut7rJdqmw0V+8t2o=;
	b=L/UNgFViURKIQT0Y2iKSc2eGB0c8FLYMnWHOk4cCVk16CVfTMtundUTvSzDr/5qfd75o
	 PJiD/FKiIhseN8gUAbt3uOvn9KptcXNwOPymhPDZbBLNaMYTlSmK6IloCyAAjaGIFMju+
	 M01dsC0sFLBjLO7yUN4P2RWhLA/dJpyHOaSJWXATIH9YDkkaSS7WXF93p/nATAkU+tIPI
	 oiKShM5WLm+CxudNo50V2nAB2O9WIBusZR2B8zub9Y6gCOJzTreJ3QFwOXvum9zT55YTB
	 GxrBCC6mnI2WLtVAx2M0z8uKKWKYn1LJARibX4+K+UO2OBq4wfRN5wewv+bVlU0DQoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kQDCD6cU;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799E606A327;
	Mon, 23 Nov 2026 04:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C799E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kQDCD6cU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795409510; x=1826945510;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WzLuMbzuFNFek+LLgWAg5DpJARYEwx2sHm0/ACrnLYg=;
  b=kQDCD6cUtq7WVvjYawr6vHvBgNdHDVihyt30JF42cWu0EOZ5MnlETLJn
   UB3+YEyRPKTEmKMw90I3X/bP6Dwlyq6MtxyHBn8qvWDpvXTAd+M4+iR+s
   VLW/3sQcWUHQNPkJMkB5tZIPUzm8xwO1QZPtc48+cNbj1jGEKPUTrhBXf
   m6YHEnQ+LW8Kx5yO5JO1/hONh3rn7N5uB/zlhTPJV302a0PoeKp7WU6ZY
   8S9ZfYDW+Rtzw/h9kww36MbGYPUftfYUkW6CUA+wdoqwEwJ/pDqRY4Qlv
   Zte5yZ3HcMDKvsiHetpbOtH+vXroh9BMwrAFHWsPYVBWy6kImzU8E998q
   A==;
X-CSE-ConnectionGUID: bfDSvRNhTJe/aXs3Xjn2Pg==
X-CSE-MsgGUID: h2PttUIrROusnxw6tXiutw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4306973"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4306973"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 20:51:49 -0800
X-CSE-ConnectionGUID: cYq88QI+RfaykNMl2xLLUg==
X-CSE-MsgGUID: YQGrMIldTtWxBDJt+fPyrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11619999"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 20:51:45 -0800
Message-ID: <479a91e0-fe36-43ac-b915-c839afe1672b@linux.intel.com>
Date: Mon, 23 Nov 2026 12:51:43 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, yilun.xu@linux.intel.com,
 xiaoyao.li@intel.com, Binbin Wu <binbin.wu@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] coco/tdx-host: Enable trusted DMA on IOMMUs on
 device connect
To: Chao Gao <chao.gao@intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-10-baolu.lu@linux.intel.com>
 <av1dr3IGMqWA1-7r@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <av1dr3IGMqWA1-7r@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/2026 4:11 PM, Chao Gao wrote:
> On Thu, Nov 12, 2026 at 12:30:54PM +0800, Lu Baolu wrote:
>> Assigning a device to a TD for private memory access requires that DMA
>>from that device be translated by structures the TDX module controls.
>> An Intel IOMMU that implements the trusted DMA extension provides a
>> parallel set of translation and invalidation resources for this purpose.
>> They become usable once TDH.IOMMU.SETUP puts the IOMMU into Secure TDX
>> Mode and the TDX module initializes them. The host keeps the regular
>> translation path.
>>
>> Issue TDH.IOMMU.SETUP on demand, when the first device behind an IOMMU
>> is connected through the TSM, rather than for every capable IOMMU at
>> probe time. Secure TDX Mode costs host resources: the TDX module's
>> metadata pages and half of the IOMMU's domain ID space. That cost should
>> only be paid for IOMMUs that actually serve such devices.
>>
>> tdx_iommu_get() and tdx_iommu_put() keep a per-IOMMU refcount. The first
>> get() issues TDH.IOMMU.SETUP and the last put() issues TDH.IOMMU.CLEAR.
>> A single mutex covers both the refcount and the SEAMCALL that follows,
>> so a device cannot join an IOMMU that is being cleared or whose setup
>> has not finished. The refcount lives here rather than in the VT-d
>> driver because tdx-host already owns the per-IOMMU state that must
>> outlive TDH.IOMMU.SETUP: the IOMMU_MT pages and the TDX IOMMU ID.
>>
>> The IOMMU_MT parameter page lists two contiguous buffers for the
>> trusted invalidation queue, followed by the metadata pages. The TDX
>> module reports how many metadata pages it needs in its global metadata.
>>
>> With Dynamic PAMT, every 4K page given to the TDX module needs PAMT
>> backing first. Take it for each page of the invalidation queue buffers
>> and the metadata pages before TDH.IOMMU.SETUP, and drop it if setup
>> fails or once TDH.IOMMU.CLEAR succeeds. The parameter page itself only
>> carries the page list into the SEAMCALL and needs no backing.
>>
>> If TDH.IOMMU.CLEAR fails, the TDX module may still reference the
>> IOMMU_MT pages, so they are leaked together with their PAMT backing,
>> and the IOMMU is marked unusable. Later get() calls for that IOMMU fail
>> with -EBUSY rather than reuse an IOMMU in an unknown state. tdx-host
>> pins itself while such an IOMMU exists, so unloading can't lose track
>> of it. If the failure happens during unload itself, only the tracking
>> entry is freed; the VT-d driver still has the IOMMU acquired and keeps
>> rejecting it.
> 
> If the pin can fail anyway, what's the point of taking it at all?
> 
> If tdx-host is reloaded, we can rely on the VT-d driver or the TDX module
> to reject transitioning the IOMMU to secure mode.

You are right. VT-d already refuses to reuse an IOMMU whose clear
failed, even after tdx-host is reloaded. I will drop this.

>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>> drivers/virt/coco/tdx-host/Kconfig   |   5 +
>> drivers/virt/coco/tdx-host/Makefile  |   1 +
>> drivers/virt/coco/tdx-host/private.h |  21 ++
>> drivers/virt/coco/tdx-host/main.c    |  11 +
>> drivers/virt/coco/tdx-host/viommu.c  | 401 +++++++++++++++++++++++++++
>> 5 files changed, 439 insertions(+)
>> create mode 100644 drivers/virt/coco/tdx-host/private.h
>> create mode 100644 drivers/virt/coco/tdx-host/viommu.c
>>
>> diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
>> index f8c8cc29d46c..1395929f05bb 100644
>> --- a/drivers/virt/coco/tdx-host/Kconfig
>> +++ b/drivers/virt/coco/tdx-host/Kconfig
>> @@ -6,3 +6,8 @@ config TDX_HOST_SERVICES
>> 	select FW_UPLOAD
>> 	select PCI_TSM
>> 	default m
>> +
>> +config TDX_CONNECT
>> +	def_bool y
>> +	depends on TDX_HOST_SERVICES
>> +	depends on INTEL_IOMMU
> 
> Do we need this TDX_CONNECT config? We can just add "depends on
> INTEL_IOMMU" to TDX_HOST_SERVICES, and then drop the stub functions
> in private.h. Patch 7 already makes TDX_HOST_SERVICES depend on PCI
> in the same way.
> 
> The cost is that without INTEL_IOMMU, none of the tdx-host services
> are available, including TDX module updates. But I doubt anyone would
> want to launch CoCo VMs while compiling out INTEL_IOMMU entirely.
> 
> We can always add this option back if such a configuration turns out
> to be practical.

I'd like to accept this unless anyone has concerns about the downside.

> 
>> +/*
>> + * Serializes the refcounts together with TDH.IOMMU.SETUP and
>> + * TDH.IOMMU.CLEAR, so a device can't join an IOMMU that is being
>> + * cleared, or one whose setup hasn't finished.
>> + */
>> +static DEFINE_MUTEX(tdx_iommu_lock);
>> +static LIST_HEAD(tdx_iommu_list);
>> +
>> +static void *tdx_iommu_alloc_pages(int node, size_t size)
>> +{
>> +	struct folio *folio;
>> +
>> +	if (node == NUMA_NO_NODE)
>> +		node = numa_mem_id();
>> +
>> +	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, get_order(size), node);
> 
> Would kzalloc_node() work here? kzalloc_node() handles NUMA_NO_NODE
> itself, and there's no need to convert between folios and void *.

Yes. kzalloc_node() returns naturally aligned buffers for power-of-two
sizes, which covers the 4K and 8K allocations here. Will switch to it in
the next version.

> 
>> +	if (!folio)
>> +		return NULL;
>> +
>> +	return folio_address(folio);
>> +}
>> +
>> +static void tdx_iommu_free_pages(void *virt)
>> +{
>> +	if (!virt)
>> +		return;
>> +
>> +	folio_put(virt_to_folio(virt));
>> +}
>> +
>> +/* Number of 4K pages backing IOMMU_MT entry @i. */
>> +static unsigned int mt_entry_nr_pages(unsigned int i)
>> +{
>> +	return i < TDX_IOMMU_MT_IQ_NR ? IQ_BUFFER_SIZE >> PAGE_SHIFT : 1;
>> +}
>> +
>> +/*
>> + * Drop the PAMT backing of the first @nr 4K pages handed to the TDX
>> + * module, in the order mt_pamt_get() took it. Pass UINT_MAX for all.
>> + */
>> +static void mt_pamt_put(struct tdx_iommu_pages *mt, unsigned int nr)
>> +{
>> +	unsigned int i, j;
>> +
>> +	for (i = 0; i < mt->nr_entries && nr; i++) {
>> +		unsigned long pfn = PHYS_PFN(__pa(mt->pages[i]));
>> +
>> +		for (j = 0; j < mt_entry_nr_pages(i) && nr; j++, nr--)
>> +			tdx_pamt_put(pfn + j);
>> +	}
>> +}
>> +
>> +/*
>> + * With Dynamic PAMT, every 4K page handed to the TDX module needs PAMT
>> + * backing first. This covers the IQ buffers and the metadata pages, not
>> + * the root page, which only carries the list of pages into the
>> + * SEAMCALL. tdx_pamt_get() is a no-op without Dynamic PAMT.
>> + */
>> +static int mt_pamt_get(struct tdx_iommu_pages *mt)
>> +{
>> +	unsigned int i, j, nr = 0;
>> +	int ret;
>> +
>> +	for (i = 0; i < mt->nr_entries; i++) {
>> +		unsigned long pfn = PHYS_PFN(__pa(mt->pages[i]));
>> +
>> +		for (j = 0; j < mt_entry_nr_pages(i); j++) {
>> +			ret = tdx_pamt_get(pfn + j, NULL);
>> +			if (ret) {
>> +				mt_pamt_put(mt, nr);
>> +				return ret;
>> +			}
>> +			nr++;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void free_mt_pages(struct tdx_iommu_pages *array)
>> +{
>> +	unsigned int i;
>> +
>> +	if (IS_ERR_OR_NULL(array))
>> +		return;
>> +
>> +	mt_pamt_put(array, UINT_MAX);
>> +
>> +	for (i = 0; i < array->nr_entries; i++)
>> +		tdx_iommu_free_pages(array->pages[i]);
>> +
>> +	tdx_iommu_free_pages(array->root);
>> +	kfree(array->pages);
>> +	kfree(array);
>> +}
>> +
>> +DEFINE_FREE(free_mt_pages, struct tdx_iommu_pages *, free_mt_pages(_T))
>> +
>> +static void **alloc_mt_pages(unsigned int nr_entries, int node)
>> +{
>> +	unsigned int i;
>> +	void **pages;
>> +	void *vaddr;
>> +
>> +	pages = kzalloc_objs(*pages, nr_entries);
>> +	if (!pages)
>> +		return NULL;
>> +
>> +	/* Allocate two contiguous buffers for the invalidation queue. */
>> +	pages[0] = tdx_iommu_alloc_pages(node, IQ_BUFFER_SIZE);
>> +	if (!pages[0])
>> +		goto free_pages;
>> +
>> +	pages[1] = tdx_iommu_alloc_pages(node, IQ_BUFFER_SIZE);
>> +	if (!pages[1])
>> +		goto free_pages;
> 
> You can use mt_entry_nr_pages() to fold the two IQ buffer allocations
> into the loop below.

Good point. I'll fold them into a single loop, using mt_entry_nr_pages()
for the size.

     for (i = 0; i < nr_entries; i++) {
         pages[i] = kzalloc_node(mt_entry_nr_pages(i) << PAGE_SHIFT,
                     GFP_KERNEL, node);
         if (!pages[i])
             goto free_pages;
     }

> 
>> +
>> +	/* Allocate the required number of pages for the IOMMU metadata. */
>> +	for (i = TDX_IOMMU_MT_IQ_NR; i < nr_entries; i++) {
>> +		vaddr = tdx_iommu_alloc_pages(node, SZ_4K);
>> +		if (!vaddr)
>> +			goto free_pages;
>> +		pages[i] = vaddr;
>> +	}
>> +
>> +	return pages;
>> +
>> +free_pages:
>> +	for (i = 0; i < nr_entries; i++)
>> +		tdx_iommu_free_pages(pages[i]);
>> +	kfree(pages);
>> +
>> +	return NULL;
>> +}

Thanks,
baolu
