Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B04C4740C
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 00:18:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79C921670
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 00:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICKCzJ/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79C921670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DFDC5BA0;
	Tue, 10 Sep 2019 00:18:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 01ECCB8A
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 00:18:34 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3BA6976F
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 00:18:33 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 993D421924;
	Tue, 10 Sep 2019 00:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568074713;
	bh=dKUKP3JPu7hVaTGP/S7YYTxBafVoENZ0MqGtavG/XfE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ICKCzJ/tQcgzvr4AuWWrSSWAMgo/0zHUMkF/TlGCj70+2xzfS3uf/i3xzDUbh8xmQ
	1Z6ktOKxbMzN89BMGZl+7e6Jg3qHxS/ZguCel7w3EqnaqShpDKLeJnt3o/I8SLqYfH
	gqdTVOzVv1KrLeujtImQbq/9LKuweVBSM8lx0hkw=
Date: Mon, 9 Sep 2019 17:18:32 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/11] xen/arm: consolidate page-coherent.h
In-Reply-To: <20190905113408.3104-3-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1909091701030.29131@sstabellini-ThinkPad-T480s>
References: <20190905113408.3104-1-hch@lst.de>
	<20190905113408.3104-3-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, gross@suse.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
	boris.ostrovsky@oracle.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, 5 Sep 2019, Christoph Hellwig wrote:
> Shared the duplicate arm/arm64 code in include/xen/arm/page-coherent.h.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/arm/include/asm/xen/page-coherent.h   | 75 --------------------
>  arch/arm64/include/asm/xen/page-coherent.h | 75 --------------------
>  include/xen/arm/page-coherent.h            | 80 ++++++++++++++++++++++
>  3 files changed, 80 insertions(+), 150 deletions(-)
> 
> diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
> index 602ac02f154c..27e984977402 100644
> --- a/arch/arm/include/asm/xen/page-coherent.h
> +++ b/arch/arm/include/asm/xen/page-coherent.h
> @@ -1,77 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_ARM_XEN_PAGE_COHERENT_H
> -#define _ASM_ARM_XEN_PAGE_COHERENT_H
> -
> -#include <linux/dma-mapping.h>
> -#include <asm/page.h>
>  #include <xen/arm/page-coherent.h>
> -
> -static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
> -{
> -	return dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
> -}
> -
> -static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
> -		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	dma_direct_free(hwdev, size, cpu_addr, dma_handle, attrs);
> -}
> -
> -static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -
> -	if (pfn_valid(pfn))
> -		dma_direct_sync_single_for_cpu(hwdev, handle, size, dir);
> -	else
> -		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
> -}
> -
> -static inline void xen_dma_sync_single_for_device(struct device *hwdev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -	if (pfn_valid(pfn))
> -		dma_direct_sync_single_for_device(hwdev, handle, size, dir);
> -	else
> -		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
> -}
> -
> -static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> -	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> -	     enum dma_data_direction dir, unsigned long attrs)
> -{
> -	unsigned long page_pfn = page_to_xen_pfn(page);
> -	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
> -	unsigned long compound_pages =
> -		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
> -	bool local = (page_pfn <= dev_pfn) &&
> -		(dev_pfn - page_pfn < compound_pages);
> -
> -	if (local)
> -		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
> -	else
> -		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
> -}
> -
> -static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -	/*
> -	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
> -	 * multiple Xen page, it's not possible to have a mix of local and
> -	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
> -	 * foreign mfn will always return false. If the page is local we can
> -	 * safely call the native dma_ops function, otherwise we call the xen
> -	 * specific function.
> -	 */
> -	if (pfn_valid(pfn))
> -		dma_direct_unmap_page(hwdev, handle, size, dir, attrs);
> -	else
> -		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
> -}
> -
> -#endif /* _ASM_ARM_XEN_PAGE_COHERENT_H */
> diff --git a/arch/arm64/include/asm/xen/page-coherent.h b/arch/arm64/include/asm/xen/page-coherent.h
> index d88e56b90b93..27e984977402 100644
> --- a/arch/arm64/include/asm/xen/page-coherent.h
> +++ b/arch/arm64/include/asm/xen/page-coherent.h
> @@ -1,77 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_ARM64_XEN_PAGE_COHERENT_H
> -#define _ASM_ARM64_XEN_PAGE_COHERENT_H
> -
> -#include <linux/dma-mapping.h>
> -#include <asm/page.h>
>  #include <xen/arm/page-coherent.h>
> -
> -static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
> -{
> -	return dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
> -}
> -
> -static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
> -		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	dma_direct_free(hwdev, size, cpu_addr, dma_handle, attrs);
> -}
> -
> -static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -
> -	if (pfn_valid(pfn))
> -		dma_direct_sync_single_for_cpu(hwdev, handle, size, dir);
> -	else
> -		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
> -}
> -
> -static inline void xen_dma_sync_single_for_device(struct device *hwdev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -	if (pfn_valid(pfn))
> -		dma_direct_sync_single_for_device(hwdev, handle, size, dir);
> -	else
> -		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
> -}
> -
> -static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> -	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> -	     enum dma_data_direction dir, unsigned long attrs)
> -{
> -	unsigned long page_pfn = page_to_xen_pfn(page);
> -	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
> -	unsigned long compound_pages =
> -		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
> -	bool local = (page_pfn <= dev_pfn) &&
> -		(dev_pfn - page_pfn < compound_pages);
> -
> -	if (local)
> -		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
> -	else
> -		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
> -}
> -
> -static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -	/*
> -	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
> -	 * multiple Xen page, it's not possible to have a mix of local and
> -	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
> -	 * foreign mfn will always return false. If the page is local we can
> -	 * safely call the native dma_ops function, otherwise we call the xen
> -	 * specific function.
> -	 */
> -	if (pfn_valid(pfn))
> -		dma_direct_unmap_page(hwdev, handle, size, dir, attrs);
> -	else
> -		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
> -}
> -
> -#endif /* _ASM_ARM64_XEN_PAGE_COHERENT_H */
> diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
> index 2ca9164a79bf..a840d6949a87 100644
> --- a/include/xen/arm/page-coherent.h
> +++ b/include/xen/arm/page-coherent.h
> @@ -2,6 +2,9 @@
>  #ifndef _XEN_ARM_PAGE_COHERENT_H
>  #define _XEN_ARM_PAGE_COHERENT_H
>  
> +#include <linux/dma-mapping.h>
> +#include <asm/page.h>
> +
>  void __xen_dma_map_page(struct device *hwdev, struct page *page,
>  	     dma_addr_t dev_addr, unsigned long offset, size_t size,
>  	     enum dma_data_direction dir, unsigned long attrs);
> @@ -13,4 +16,81 @@ void __xen_dma_sync_single_for_cpu(struct device *hwdev,
>  void __xen_dma_sync_single_for_device(struct device *hwdev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir);
>  
> +static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
> +{
> +	return dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
> +}
> +
> +static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
> +		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
> +{
> +	dma_direct_free(hwdev, size, cpu_addr, dma_handle, attrs);
> +}
> +
> +static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +
> +	if (pfn_valid(pfn))
> +		dma_direct_sync_single_for_cpu(hwdev, handle, size, dir);
> +	else
> +		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
> +}
> +
> +static inline void xen_dma_sync_single_for_device(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	if (pfn_valid(pfn))
> +		dma_direct_sync_single_for_device(hwdev, handle, size, dir);
> +	else
> +		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
> +}
> +
> +static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> +	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> +	     enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned long page_pfn = page_to_xen_pfn(page);
> +	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
> +	unsigned long compound_pages =
> +		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
> +	bool local = (page_pfn <= dev_pfn) &&
> +		(dev_pfn - page_pfn < compound_pages);
> +
> +	/*
> +	 * Dom0 is mapped 1:1, while the Linux page can span across
> +	 * multiple Xen pages, it's not possible for it to contain a
> +	 * mix of local and foreign Xen pages. So if the first xen_pfn
> +	 * == mfn the page is local otherwise it's a foreign page
> +	 * grant-mapped in dom0. If the page is local we can safely
> +	 * call the native dma_ops function, otherwise we call the xen
> +	 * specific function.
> +	 */
> +	if (local)
> +		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
> +	else
> +		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
> +}
> +
> +static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	/*
> +	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
> +	 * multiple Xen page, it's not possible to have a mix of local and
> +	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
> +	 * foreign mfn will always return false. If the page is local we can
> +	 * safely call the native dma_ops function, otherwise we call the xen
> +	 * specific function.
> +	 */
> +	if (pfn_valid(pfn))
> +		dma_direct_unmap_page(hwdev, handle, size, dir, attrs);
> +	else
> +		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
> +}
> +
>  #endif /* _XEN_ARM_PAGE_COHERENT_H */
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
