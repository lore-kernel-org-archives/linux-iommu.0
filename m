Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6B3546E3
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608784; cv=none; b=l8Bgz+v2ZEWsUuI9fhvy16t5oG4h8J2hA2g0SXTArYgabPYkhdbeL370lSbrXTSxEFGS+jlEPBbGgvEkTYCITU97hF/YSRItJf+sxb1L18cXJB68ZdNA9Xe1BVTVzLeWJ9cOJT/nl004nU35ccz5H3E3E4I2/7N2cN1Qv+fX+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608784; c=relaxed/simple;
	bh=qxyxGlGH1q7rXedTeXx9vy2IzfXs4LzCPDw6OGl/M3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=MBI18VRo7+bdRBy1jR/heTdImUd7Oy2MJhvH86T1E4IUj5lTjy0J9qu6Dhv0jnf/l79kTOkjgTnbS0JMsFJvHUwmSSYEjL+GP62tq6ySd1FEILMZW7zlHRwYYwdLc+DxTyEHn1GUZKjjfsM2NoylMEDvPqwOOXxxPUzX6lA3uas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JZJcbuh+; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JZJcbuh+"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260709145259euoutp016cd4c690c809cf75e269023c108d2c47~AprwScKWv1135111351euoutp01F
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 14:52:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260709145259euoutp016cd4c690c809cf75e269023c108d2c47~AprwScKWv1135111351euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783608779;
	bh=VbcQinm1ir2cnNxHai9S8ANC35SAlosUx9BiSNrciNA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JZJcbuh+XEF/Rxz9JQiWmNTbh71UejfZ9FAt4Ihf+GiH1kCZi4L8GZL32BRyuW8X8
	 Bi7abpFZltqCvuO25lR9cUe7S8ohfkBeOKhlea1rXhD5l2xRjKEBHhi4tmrMorC4QC
	 tE3ZnZzK9FNGNtTJAzNqni03G+Tf3L7YHjFPabu4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260709145258eucas1p19aea9c490fa5391bc3ace98311d5b5f9~AprwD58j_0159201592eucas1p1x;
	Thu,  9 Jul 2026 14:52:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260709145258eusmtip10c913639bdf775987108b68bb002773b~AprvjZhdE1710917109eusmtip1y;
	Thu,  9 Jul 2026 14:52:58 +0000 (GMT)
Message-ID: <baf08834-6b1b-4b24-858b-eb0d5ef124f6@samsung.com>
Date: Thu, 9 Jul 2026 16:52:57 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] swiotlb: introduce Kconfig option for compile-time
 default pool size
To: bibek.patro@oss.qualcomm.com, Robin Murphy <robin.murphy@arm.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Jagadeesh Pagadala
	<jpagadal@qti.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260702-swiotlb-v2-1-9205f3ba5408@oss.qualcomm.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260709145258eucas1p19aea9c490fa5391bc3ace98311d5b5f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260702140941eucas1p22e5e3363c7e9338f18b2e050b0ef564a
X-EPHeader: CA
X-CMS-RootMailID: 20260702140941eucas1p22e5e3363c7e9338f18b2e050b0ef564a
References: <CGME20260702140941eucas1p22e5e3363c7e9338f18b2e050b0ef564a@eucas1p2.samsung.com>
	<20260702-swiotlb-v2-1-9205f3ba5408@oss.qualcomm.com>

On 02.07.2026 16:09, bibek.patro@oss.qualcomm.com wrote:
> From: Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
>
> The SWIOTLB bounce buffer pool size is hardcoded at 64 MB via
> IO_TLB_DEFAULT_SIZE with no compile-time knob to adjust it. On
> memory-constrained embedded or mobile platforms equipped with a
> hardware IOMMU (e.g., ARM SMMU) covering most DMA-capable devices,
> reserving 64 MB at boot is unnecessarily wasteful — the SWIOTLB is
> only exercised for devices that bypass the IOMMU or have restricted
> DMA address ranges.
>
> Introduce CONFIG_SWIOTLB_DEFAULT_SIZE_MB, an integer Kconfig option
> (range 1–64 MB, default 64) that allows platforms to set a smaller
> compile-time default. IO_TLB_DEFAULT_SIZE is updated to derive from
> this value when CONFIG_SWIOTLB is enabled, preserving the existing
> 64 MB default when the option is not configured.
>
> The runtime "swiotlb=<nslabs>" kernel parameter override remains
> fully supported and takes precedence over the compile-time default.
>
> Signed-off-by: Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
> The SWIOTLB bounce buffer pool size is hardcoded at 64 MB. On
> memory-constrained platforms with a hardware IOMMU (e.g., ARM SMMU),
> this reservation is wasteful as SWIOTLB is only needed for devices
> that bypass the IOMMU or have restricted DMA address ranges.
>
> Introduce CONFIG_SWIOTLB_DEFAULT_SIZE_MB (range 1–64 MB, default 64)
> to allow a smaller compile-time default. The runtime "swiotlb="
> parameter override remains supported and takes precedence.
>
> Before (default 64 MB):
>   [    0.000000] software IO TLB: area num 8.
>   [    0.000000] software IO TLB: mapped [mem 0x00000000fbfff000-0x00000000fffff000] (64MB)
>
> After (CONFIG_SWIOTLB_DEFAULT_SIZE_MB=1, 8 CPUs):
>   [    0.000000] software IO TLB: area num 8.
>   [    0.000000] software IO TLB: SWIOTLB bounce buffer size roundup to 2MB
>   [    0.000000] software IO TLB: mapped [mem 0x00000000ffdff000-0x00000000fffff000] (2MB)
>
> After (CONFIG_SWIOTLB_DEFAULT_SIZE_MB=2, 8 CPUs):
>   [    0.000000] software IO TLB: area num 8.
>   [    0.000000] software IO TLB: mapped [mem 0x00000000ffdff000-0x00000000fffff000] (2MB)
> ---
> Changes in v2:
> - Fix incorrect boot log label in cover letter: the roundup message is
>   produced by CONFIG_SWIOTLB_DEFAULT_SIZE_MB=1 (not =2) with 8 CPUs.
> - Update Documentation/core-api/swiotlb.rst to mention
>   CONFIG_SWIOTLB_DEFAULT_SIZE_MB as per Michael's suggestion.
> - Link to v1: https://protect2.fireeye.com/v1/url?k=7033f7b3-114e1d30-70327cfc-74fe48600158-fc2eb93dd6453735&q=1&e=44bf9751-f859-48d6-aee0-ebe8bab9d273&u=https%3A%2F%2Fpatch.msgid.link%2F20260617-swiotlb-v1-1-abfee3faf4ea%40oss.qualcomm.com
>
> To: Jonathan Corbet <corbet@lwn.net>
> To: Shuah Khan <skhan@linuxfoundation.org>
> To: Marek Szyprowski <m.szyprowski@samsung.com>
> To: Robin Murphy <robin.murphy@arm.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: iommu@lists.linux.dev
> ---
>  Documentation/core-api/swiotlb.rst |  7 +++++--

Jonathan: could You ack the Documentation change, so I will take this to dma-mapping-for-next ?


>  include/linux/swiotlb.h            |  8 ++++++--
>  kernel/dma/Kconfig                 | 22 ++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
> index 9e0fe027dd3b..71b4e4c27eb5 100644
> --- a/Documentation/core-api/swiotlb.rst
> +++ b/Documentation/core-api/swiotlb.rst
> @@ -140,8 +140,11 @@ Data structures concepts
>  ------------------------
>  Memory used for swiotlb bounce buffers is allocated from overall system memory
>  as one or more "pools". The default pool is allocated during system boot with a
> -default size of 64 MiB. The default pool size may be modified with the
> -"swiotlb=" kernel boot line parameter. The default size may also be adjusted
> +default size of 64 MiB, which can be changed at compile time via
> +CONFIG_SWIOTLB_DEFAULT_SIZE_MB. The default pool size may also be
> +modified at runtime with the "swiotlb=" kernel boot line parameter,
> +which takes precedence over the compile-time default. The default size
> +may also be adjusted
>  due to other conditions, such as running in a CoCo VM, as described above. If
>  CONFIG_SWIOTLB_DYNAMIC is enabled, additional pools may be allocated later in
>  the life of the system. Each pool must be a contiguous range of physical
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..1665a9ce8f94 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -32,8 +32,12 @@ struct scatterlist;
>  #define IO_TLB_SHIFT 11
>  #define IO_TLB_SIZE (1 << IO_TLB_SHIFT)
>  
> -/* default to 64MB */
> -#define IO_TLB_DEFAULT_SIZE (64UL<<20)
> +/* compile-time default; overridable via CONFIG_SWIOTLB_DEFAULT_SIZE_MB */
> +#ifdef CONFIG_SWIOTLB
> +#define IO_TLB_DEFAULT_SIZE ((unsigned long)CONFIG_SWIOTLB_DEFAULT_SIZE_MB << 20)
> +#else
> +#define IO_TLB_DEFAULT_SIZE (64UL << 20)
> +#endif
>  
>  unsigned long swiotlb_size_or_default(void);
>  void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 0a4ba21a57a7..3830a63ae032 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -86,6 +86,28 @@ config SWIOTLB
>  	bool
>  	select NEED_DMA_MAP_STATE
>  
> +config SWIOTLB_DEFAULT_SIZE_MB
> +	int "Default SWIOTLB bounce buffer size in MB"
> +	depends on SWIOTLB
> +	range 1 64
> +	default 64
> +	help
> +	  Sets the default size of the software IO TLB (SWIOTLB) bounce buffer
> +	  pool allocated at boot time. The default is 64 MB.
> +
> +	  On memory-constrained embedded or mobile platforms (e.g., those with
> +	  a hardware IOMMU such as ARM SMMU covering most DMA-capable devices),
> +	  a smaller value such as 4 or 8 MB may be sufficient. The SWIOTLB is
> +	  then only needed for devices that bypass the IOMMU or have restricted
> +	  DMA address ranges.
> +
> +	  The minimum allowed value is 1 MB. This compile-time default can be
> +	  overridden at runtime using the "swiotlb=<nslabs>" kernel command line
> +	  parameter. Refer to Documentation/admin-guide/kernel-parameters.txt
> +	  for details.
> +
> +	  If unsure, leave at the default value of 64.
> +
>  config SWIOTLB_DYNAMIC
>  	bool "Dynamic allocation of DMA bounce buffers"
>  	default n
>
> ---
> base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
> change-id: 20260617-swiotlb-c215ce0b23f7
>
> Best regards,
> --  
> Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

