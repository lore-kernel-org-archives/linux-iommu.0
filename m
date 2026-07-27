Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05742ECE86
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119876; cv=none; b=FzdwCITP41GHhM96Rr+Lm2s/4scpyYSuahh2+LnqNN40b9yWXlsn5mHvMsWGSuhcVk2iI0+dZIa88R9uf3fVsfyoaFFEEUqzv/n5YM3WZ0wB1/zBdt0WpBEo7rpFCik2/b2vhXyv7T9eXprsnEKt/2VeOJsFSOR3tAyhGbX+ofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119876; c=relaxed/simple;
	bh=aP0qLOZl1PzfxWPBivw5C/1NXthjEtgKyWNBW2M5eiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwaGc8q8NhvJSYzLx4r+IaNHAkpPhB+BEXEOJRoy7jtB6R+xPaD/O1+fzOKV+Q9mYp5mVyxmpTPHN8xpgsThKatjDm256R4obwEKceXxIvWKJlPmCDCTS8CTynY2jAdYVRy/IDg8JAv8fXN7atX1aUYywsgDYSn2SKKYIxxn0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aL8yWDgM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aL8yWDgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785119874; x=1816655874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aP0qLOZl1PzfxWPBivw5C/1NXthjEtgKyWNBW2M5eiM=;
  b=aL8yWDgMcBpBKAHfvgS1jbXbzg2q7a+tr/fZklxobdxDUDsEIFNVGGdW
   XpUvKY+ZsDbafdweG48Tq+NVAs2wuLx8sDjJbWCS+rtNrX2/guZ0ijzK+
   TlG6kvU2hAM43+h9mB/pp3UvCKiPQVqqKD7Hlj2uOOWKEO2uFmpHAHuvQ
   6hw6w2yF5iC+bV34nCOvC9+zTLGWrg/Mz2CHirmC/GaXLNNgR47rp05Kz
   sWaq90VxZF9Wwyb7efF+ALvGHpcht4RXQwj9ANQMkBU8ZEQjIAOsdNJYn
   rsVjuCoL0puNZjfzHUWo34czbQpqCEzlw/CYXo0dzfhB8SQx+DFSce/zN
   w==;
X-CSE-ConnectionGUID: xP35RV5jThSTPEze+YP/3g==
X-CSE-MsgGUID: tGzmcAgvRCWcaZzBpTTZ2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="97057599"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="97057599"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 19:37:53 -0700
X-CSE-ConnectionGUID: 5Fcq6kv5RhO6xS+Ng+ou1g==
X-CSE-MsgGUID: 81p+kK4HQfWn6YMOt+MyoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="263577431"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 19:37:51 -0700
Message-ID: <b0878360-92d6-4f1a-b70b-f1ed212c2d71@linux.intel.com>
Date: Mon, 27 Jul 2026 10:36:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Make DMA-fault page-table dump
 user-selectable
To: Ahmed Abdelraoof <araoof@amazon.de>, David Woodhouse
 <dwmw2@infradead.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Ahmed Abdelraoof <araoof@amazon.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260609143806.69403-1-araoof@amazon.de>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260609143806.69403-1-araoof@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/26 22:37, Ahmed Abdelraoof wrote:
> From: Ahmed Abdelraoof <araoof@amazon.com>
> 
> The page-table dump was gated behind the hidden CONFIG_DMAR_DEBUG
> symbol, only reachable by enabling the full INTEL_IOMMU_DEBUGFS
> interface. That interface is explicitly flagged as not for production
> and exposes far more IOMMU internals than a fault dump needs, so there
> was no way to get this diagnostic from menuconfig on production kernel
> without taking on the rest.
> 
> This patch renames it to CONFIG_DMAR_FAULT_DEBUG with a prompt and help
> text so the fault dump can be enabled on its own, and updates all
> references in iommu.c and dmar.h. INTEL_IOMMU_DEBUGFS still selects it,
> so existing configs are unaffected; no functional change otherwise.

pgtable_walk() is not safe or robust enough to expose in production
environments; that is why it is currently limited to CONFIG_DMAR_DEBUG.

Intel IOMMU hardware walks multiple page-table formats. Some are managed
by the IOMMU subsystem (iommupt), while others are shared with CPU page
tables and managed outside the IOMMU subsystem. In the near future,
there may also be page tables managed by the TDX module in private
memory that the IOMMU driver cannot access.

Another issue is that pgtable_walk() lacks proper locking to protect
against concurrent page-table updates. This makes it fragile and can
potentially lead to UAF issues.

> 
> Signed-off-by: Ahmed Abdelraoof <araoof@amazon.com>
> ---
>   drivers/iommu/intel/Kconfig | 11 ++++++++---
>   drivers/iommu/intel/iommu.c |  2 +-
>   include/linux/dmar.h        |  2 +-
>   3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 5471f814e073..59a05cefa728 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -6,8 +6,13 @@ config DMAR_TABLE
>   config DMAR_PERF
>   	bool
>   
> -config DMAR_DEBUG
> -	bool
> +config DMAR_FAULT_DEBUG
> +	bool "Dump Intel IOMMU page tables on DMA fault"
> +	depends on INTEL_IOMMU
> +	help
> +	  On a DMA Remapping (DMAR) fault, walk the Root / Context /
> +	  PASID / second-level page-table entries for the faulting
> +	  source-id and IOVA and emit them via pr_info.
>   
>   config INTEL_IOMMU
>   	bool "Support for Intel IOMMU using DMA Remapping Devices"
> @@ -39,7 +44,7 @@ config INTEL_IOMMU_DEBUGFS
>   	bool "Export Intel IOMMU internals in Debugfs"
>   	depends on IOMMU_DEBUGFS
>   	select DMAR_PERF
> -	select DMAR_DEBUG
> +	select DMAR_FAULT_DEBUG
>   	help
>   	  !!!WARNING!!!
>   
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4d0e65bc131d..7c28ef700dda 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -549,7 +549,7 @@ static void free_context_table(struct intel_iommu *iommu)
>   	iommu->root_entry = NULL;
>   }
>   
> -#ifdef CONFIG_DMAR_DEBUG
> +#ifdef CONFIG_DMAR_FAULT_DEBUG
>   static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
>   			 u8 bus, u8 devfn, struct dma_pte *parent, int level)
>   {
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 692b2b445761..199cf01284fe 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -126,7 +126,7 @@ static inline int dmar_res_noop(struct acpi_dmar_header *hdr, void *arg)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_DMAR_DEBUG
> +#ifdef CONFIG_DMAR_FAULT_DEBUG
>   void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>   			  unsigned long long addr, u32 pasid);
>   #else

Thanks,
baolu

