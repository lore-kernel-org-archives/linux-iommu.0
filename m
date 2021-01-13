Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC8C433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 11:50:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65576233ED
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 11:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65576233ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C6141233A6;
	Wed, 13 Jan 2021 11:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J789O7HrAJ2F; Wed, 13 Jan 2021 11:50:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D085120361;
	Wed, 13 Jan 2021 11:50:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4752C0893;
	Wed, 13 Jan 2021 11:50:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1404CC013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 11:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 02A688629C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 11:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rUOH8-_TPm6I for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 11:50:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 72E75855D7
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 11:50:36 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id AA26B68AFE; Wed, 13 Jan 2021 12:50:31 +0100 (CET)
Date: Wed, 13 Jan 2021 12:50:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [RFC PATCH v3 1/6] swiotlb: Add io_tlb_mem struct
Message-ID: <20210113115031.GA29376@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-2-tientzu@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-2-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 frowand.list@gmail.com, mingo@kernel.org, sstabellini@kernel.org,
 saravanak@google.com, mpe@ellerman.id.au, rafael.j.wysocki@intel.com,
 hch@lst.de, bgolaszewski@baylibre.com, xen-devel@lists.xenproject.org,
 treding@nvidia.com, devicetree@vger.kernel.org, will@kernel.org,
 konrad.wilk@oracle.com, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org, boris.ostrovsky@oracle.com,
 andriy.shevchenko@linux.intel.com, jgross@suse.com, drinkcat@chromium.org,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 xypron.glpk@gmx.de, robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jan 06, 2021 at 11:41:19AM +0800, Claire Chang wrote:
> Added a new struct, io_tlb_mem, as the IO TLB memory pool descriptor and
> moved relevant global variables into that struct.
> This will be useful later to allow for restricted DMA pool.

I like where this is going, but a few comments.

Mostly I'd love to be able to entirely hide io_tlb_default_mem
and struct io_tlb_mem inside of swiotlb.c.

> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -55,8 +55,8 @@ void __init svm_swiotlb_init(void)
>  	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, false))
>  		return;
>  
> -	if (io_tlb_start)
> -		memblock_free_early(io_tlb_start,
> +	if (io_tlb_default_mem.start)
> +		memblock_free_early(io_tlb_default_mem.start,
>  				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));

I think this should switch to use the local vstart variable in
prep patch.

>  	panic("SVM: Cannot allocate SWIOTLB buffer");
>  }
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 2b385c1b4a99..4d17dff7ffd2 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -192,8 +192,8 @@ int __ref xen_swiotlb_init(int verbose, bool early)
>  	/*
>  	 * IO TLB memory already allocated. Just use it.
>  	 */
> -	if (io_tlb_start != 0) {
> -		xen_io_tlb_start = phys_to_virt(io_tlb_start);
> +	if (io_tlb_default_mem.start != 0) {
> +		xen_io_tlb_start = phys_to_virt(io_tlb_default_mem.start);
>  		goto end;

xen_io_tlb_start is interesting. It is used only in two functions:

 1) is_xen_swiotlb_buffer, where I think we should be able to just use
    is_swiotlb_buffer instead of open coding it with the extra
    phys_to_virt/virt_to_phys cycle.
 2) xen_swiotlb_init, where except for the assignment it only is used
    locally for the case not touched above and could this be replaced
    with a local variable.

Konrad, does this make sense to you?

>  static inline bool is_swiotlb_buffer(phys_addr_t paddr)
>  {
> -	return paddr >= io_tlb_start && paddr < io_tlb_end;
> +	struct io_tlb_mem *mem = &io_tlb_default_mem;
> +
> +	return paddr >= mem->start && paddr < mem->end;

We'd then have to move this out of line as well.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
