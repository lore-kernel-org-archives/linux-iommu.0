Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C24C072B5
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 16:27:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299AB20851
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 16:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299AB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E2942F11;
	Fri, 24 May 2019 16:27:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 10F51B0B
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 16:15:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A5CBCF4
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 16:15:24 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 May 2019 09:15:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,507,1549958400"; d="scan'208";a="177765957"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
	by fmsmga002.fm.intel.com with ESMTP; 24 May 2019 09:15:23 -0700
Date: Fri, 24 May 2019 09:16:19 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 2/2] dma-contiguous: Use fallback alloc_pages for
	single pages
Message-ID: <20190524161618.GB23100@iweiny-DESK2.sc.intel.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
	<20190524040633.16854-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190524040633.16854-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Mailman-Approved-At: Fri, 24 May 2019 16:27:52 +0000
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	jcmvbkbc@gmail.com, hch@lst.de, sfr@canb.auug.org.au,
	dann.frazier@canonical.com, linux@armlinux.org.uk,
	treding@nvidia.com, linux-xtensa@linux-xtensa.org,
	keescook@chromium.org, akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, chris@zankel.net,
	wsa+renesas@sang-engineering.com, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	iamjoonsoo.kim@lge.com, dwmw2@infradead.org
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

On Thu, May 23, 2019 at 09:06:33PM -0700, Nicolin Chen wrote:
> The addresses within a single page are always contiguous, so it's
> not so necessary to always allocate one single page from CMA area.
> Since the CMA area has a limited predefined size of space, it may
> run out of space in heavy use cases, where there might be quite a
> lot CMA pages being allocated for single pages.
> 
> However, there is also a concern that a device might care where a
> page comes from -- it might expect the page from CMA area and act
> differently if the page doesn't.

How does a device know, after this call, if a CMA area was used?  From the
patches I figured a device should not care.

> 
> This patch tries to use the fallback alloc_pages path, instead of
> one-page size allocations from the global CMA area in case that a
> device does not have its own CMA area. This'd save resources from
> the CMA global area for more CMA allocations, and also reduce CMA
> fragmentations resulted from trivial allocations.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  kernel/dma/contiguous.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 21f39a6cb04f..6914b92d5c88 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -223,14 +223,23 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>   * This function allocates contiguous memory buffer for specified device. It
>   * first tries to use device specific contiguous memory area if available or
>   * the default global one, then tries a fallback allocation of normal pages.
> + *
> + * Note that it byapss one-page size of allocations from the global area as
> + * the addresses within one page are always contiguous, so there is no need
> + * to waste CMA pages for that kind; it also helps reduce fragmentations.
>   */
>  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  {
>  	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
>  	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	size_t align = get_order(PAGE_ALIGN(size));
> -	struct cma *cma = dev_get_cma_area(dev);
>  	struct page *page = NULL;
> +	struct cma *cma = NULL;
> +
> +	if (dev && dev->cma_area)
> +		cma = dev->cma_area;
> +	else if (count > 1)
> +		cma = dma_contiguous_default_area;

Doesn't dev_get_dma_area() already do this?

Ira

>  
>  	/* CMA can be used only in the context which permits sleeping */
>  	if (cma && gfpflags_allow_blocking(gfp)) {
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
