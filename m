Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6348E0DE;
	Thu, 15 Oct 2026 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053348; cv=none; b=JrkQ/TGovqjfTw2BHlKZiWnAKmuYr3EIjG1yauor48259Z9ovBVNChBGf6C4EO3KHSxy8Ew5lp0SAVYhG+N/tc7LdNBsWLj1tpL2osY9U7hC9dB5CwTfaySj0oXGJNvgLhzhnoMlIluW6oOyk0pbgmrDgyg0kEcAj71327LboSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053348; c=relaxed/simple;
	bh=jsAyffWac3S0pjRkbN+9fHBRvD+lojAJez5nsr6g6FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyTQU2a3D85+1VwP40UWZ5qs1iT1t/qKUf8/Ew3wuS8gu0SlgnEQLN1iAOxKKFUkIunCOu992PA7V4XwvsGttx92lr0BmtZjiKq/vM6Y65kN/u7ze2HnaMNKjxWjp8y0pmwQwyc07shDLWT0VDNTb88cGxKE6qmH2+RsSW0On4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvRJk11d; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvRJk11d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792053345; x=1823589345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jsAyffWac3S0pjRkbN+9fHBRvD+lojAJez5nsr6g6FI=;
  b=QvRJk11dywpf9MXcufZTXtWPafFj1SrhrE79WJsCxrWjnh04xRI3ec9x
   cGuAIY8L0fhk3VTwYgWa5Otunx+EZquvI+2RuAmBx4l22ZXQf9lkoNwYv
   X/3X5heHIqveVDC2+FPtUiAVmK2c3JvVzyX/IzDxUMJkJu/KvI8XuN4NK
   LJTEJdtydrHHGloC0wgkSvKBLRFoZtZy8g8/4qeer3STEXske+mQHjGky
   WeyPIwfflePXM8Pa4x28krrbXjqNKkTa0W6XquLps9PboHWE0u/dOlU5P
   VIPsQkoCRbE+Rgwsq06oD6iBMPQ5xPeBmA8Lu+pVAVr4MX34o0ud2vSJ4
   A==;
X-CSE-ConnectionGUID: 3+1q7xudT4urutsWzxr3Bg==
X-CSE-MsgGUID: lWKkq/LeRkiyHwNygAGmbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="803654"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="803654"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 01:35:44 -0700
X-CSE-ConnectionGUID: rKUolCNlT4WsZ8d+hbkpnw==
X-CSE-MsgGUID: xIyRtnMWREKJj3Y09eEkeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1525166"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa007.jf.intel.com with ESMTP; 15 Oct 2026 01:35:42 -0700
Date: Thu, 15 Oct 2026 16:31:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Message-ID: <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015010705.1973284-5-baolu.lu@linux.intel.com>

On Thu, Oct 15, 2026 at 09:07:05AM +0800, Lu Baolu wrote:
> Assigning a device to a TD for private memory access requires that DMA
> from that device be translated by structures the TDX module controls.
> An Intel IOMMU that implements the trusted DMA extension provides a
> parallel set of translation and invalidation resources for this purpose.
> These become usable only after the TDX module has placed the IOMMU into
> TDX mode, at which point the trusted resources belong exclusively to the

I think at this point we first need to reason about the connection between
IOMMU TDX mode and the PCIe link encryption. The device private memory
access can be placed in cover-letter as the big picture of TDISP.

I can see we may need to touch a bit about trusted DMA translation at
this phase, because the TDH.IOMMU.SETUP requires the VMM to provide 2
contiguous Invalidation Queue buffers, which leaks the trusted DMA
internals a bit. But I feel this should not be a first topic.

> TDX module, while the host retains control of the regular translation
> path. The transition is performed by TDH.IOMMU.SETUP, which takes the
> register base address of the target IOMMU together with a parameter
> page describing memory the host has allocated for the TDX module to
> manage trusted DMA on that unit.
> 
> Perform this initialization from the tdx-host driver by walking every
> IOMMU unit through dmar_tdxcs_iommu_init() and initialize the ones whose
> IOMMU implements the extension.
> 
> For each such unit the driver builds the IOMMU_MT parameter layout that
> TDH.IOMMU.SETUP expects: two contiguous buffers for the trusted
> invalidation queue, followed by the number of metadata pages the TDX
> module reports in its global metadata. The pages are allocated on the
> NUMA node of the IOMMU. The root page is passed to the TDX module, which
> returns an identifier naming the initialized IOMMU. That identifier and
> the pages backing it are tracked so the state can be released later.
> 
> Releasing the state is the reverse: TDH.IOMMU.CLEAR tears down the
> trusted DMA resources established by TDH.IOMMU.SETUP, after which the
> metadata pages can be freed and the VT-d driver told to lift the domain
> ID restriction applied during initialization. If TDH.IOMMU.CLEAR fails
> the pages are not freed, as the TDX module may still hold references to
> them.
> 
> Rename tdx-host.c to main.c and build the module from a tdx-host-y
> object list instead. New functionality can then be added as separate
> source files instead of putting everything in a single file.
> 
> The code is built only when its dependencies are present, gated by
> CONFIG_TDX_CONNECT.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/virt/coco/tdx-host/Kconfig            |   6 +
>  drivers/virt/coco/tdx-host/Makefile           |   3 +
>  drivers/virt/coco/tdx-host/private.h          |  33 +++
>  drivers/virt/coco/tdx-host/iommu.c            | 255 ++++++++++++++++++
>  .../virt/coco/tdx-host/{tdx-host.c => main.c} |  21 +-
>  5 files changed, 317 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/virt/coco/tdx-host/private.h
>  create mode 100644 drivers/virt/coco/tdx-host/iommu.c
>  rename drivers/virt/coco/tdx-host/{tdx-host.c => main.c} (92%)
> 
> diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
> index 57d0c01a4357..62d91d4b41fa 100644
> --- a/drivers/virt/coco/tdx-host/Kconfig
> +++ b/drivers/virt/coco/tdx-host/Kconfig
> @@ -4,3 +4,9 @@ config TDX_HOST_SERVICES
>  	select FW_LOADER
>  	select FW_UPLOAD
>  	default m
> +
> +config TDX_CONNECT

Maybe we don't need the configuration. Now we turn on all TDX features
that Linux knows about all the time.

Architecturally, TDX Connect is an default-off feature. But Linux enables
it regardlessly. It is questionable we then have a configuration that
disable the driver that supports the feature.

> +	def_bool y
> +	depends on TDX_HOST_SERVICES
> +	depends on PCI_TSM
> +	depends on INTEL_IOMMU

[..]

> +static int tdx_iommu_setup(struct dmar_drhd_unit *drhd)
> +{
> +	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
> +	unsigned int mt_page_count = tdx_sysinfo->tdx_connect.iommu_mt_page_count;
> +	struct tdx_iommu_state *state;
> +	u64 r, tdx_iommu_id;
> +	int ret;
> +
> +	struct tdx_iommu_state *iommu_state __free(kfree) = kzalloc_obj(*iommu_state);
> +	if (!iommu_state)
> +		return -ENOMEM;
> +
> +	struct tdx_iommu_pages *iommu_mt __free(free_mt_pages) =
> +			tdx_iommu_alloc_mt_pages(drhd, mt_page_count);
> +	if (!iommu_mt)
> +		return -ENOMEM;
> +
> +	r = tdh_iommu_setup(drhd->reg_base_addr, iommu_mt->root, &tdx_iommu_id);
> +	/* TDX Extension is not supported on this IOMMU. Nothing to do. */
> +	if ((r & TDX_SEAMCALL_STATUS_MASK) == TDX_OPERAND_INVALID)
> +		return -EOPNOTSUPP;

Enable all IOMMUs regardless brings this problem. We need to try on
every IOMMU, check the TDX error code to see if it is not supported (then
skip) or failed. It's also sad to me that -EOPNOTSUPP is defined as the
API between tdx-host and intel iommu driver.

An alternative could be, bringing up one IOMMU when an associated
device requests link encryption. Then a no-tdx-support iommu fails the
encryption request naturally.

Open to discussion.
