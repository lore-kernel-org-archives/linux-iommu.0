Return-Path: <SRS0=PKzM=EC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DE9C388F9
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 21:54:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AAF20829
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 21:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOuhydjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AAF20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 21711872B2;
	Tue, 27 Oct 2020 21:54:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0b3AervCpfUU; Tue, 27 Oct 2020 21:54:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7126C872AF;
	Tue, 27 Oct 2020 21:54:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60B72C088B;
	Tue, 27 Oct 2020 21:54:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84A2FC0051
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 21:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 64C542042C
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 21:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 98A-g3qGJSvX for <iommu@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 21:54:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 10E7F20425
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 21:54:00 +0000 (UTC)
Received: from sstabellini-ThinkPad-T480s (c-24-130-65-46.hsd1.ca.comcast.net
 [24.130.65.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7224220759;
 Tue, 27 Oct 2020 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603835639;
 bh=hLuBGmvknLJruJYQUNZGkX4EVqyzQJamlMv7F6lFoho=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=vOuhydjw9vlxiSuYbstg3MW2oGhlejZ8GriRzNfLn4RdkjVwbV2wc643qtmaqkPBj
 fxNpyuRws07osa8Ikr3w7OWn6YN3ZIzLEsVSiqxn0xhx/2Ll93BusC3uRUEkjfDNRi
 Ln94Z4m4p0cL6QbfhDQL50xIrZkIz0HWmJIOUVkM=
Date: Tue, 27 Oct 2020 14:53:58 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] fix swiotlb panic on Xen
In-Reply-To: <20201027192726.GA13396@char.us.oracle.com>
Message-ID: <alpine.DEB.2.21.2010271453480.12247@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2010261653320.12247@sstabellini-ThinkPad-T480s>
 <20201027175114.GA32110@mattapan.m5p.com>
 <20201027192726.GA13396@char.us.oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Stefano Stabellini <sstabellini@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 Elliott Mitchell <ehem+undef@m5p.com>, hch@lst.de
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

On Tue, 27 Oct 2020, Konrad Rzeszutek Wilk wrote:
> > As the person who first found this and then confirmed this fixes a bug:
> > 
> > Tested-by: Elliott Mitchell <ehem+xen@m5p.com>
> 
> Thank you!!
> 
> I changed the title and added the various tags and will put it in
> linux-next later this week.

Looks fine, thank you


> >From a1eb2768bf5954d25aa0f0136b38f0aa5d92d984 Mon Sep 17 00:00:00 2001
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Date: Mon, 26 Oct 2020 17:02:14 -0700
> Subject: [PATCH] swiotlb: fix "x86: Don't panic if can not alloc buffer for
>  swiotlb"
> 
> kernel/dma/swiotlb.c:swiotlb_init gets called first and tries to
> allocate a buffer for the swiotlb. It does so by calling
> 
>   memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
> 
> If the allocation must fail, no_iotlb_memory is set.
> 
> Later during initialization swiotlb-xen comes in
> (drivers/xen/swiotlb-xen.c:xen_swiotlb_init) and given that io_tlb_start
> is != 0, it thinks the memory is ready to use when actually it is not.
> 
> When the swiotlb is actually needed, swiotlb_tbl_map_single gets called
> and since no_iotlb_memory is set the kernel panics.
> 
> Instead, if swiotlb-xen.c:xen_swiotlb_init knew the swiotlb hadn't been
> initialized, it would do the initialization itself, which might still
> succeed.
> 
> Fix the panic by setting io_tlb_start to 0 on swiotlb initialization
> failure, and also by setting no_iotlb_memory to false on swiotlb
> initialization success.
> 
> Fixes: ac2cbab21f31 ("x86: Don't panic if can not alloc buffer for swiotlb")
> 
> Reported-by: Elliott Mitchell <ehem+xen@m5p.com>
> Tested-by: Elliott Mitchell <ehem+xen@m5p.com>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> CC: stable@vger.kernel.org
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  kernel/dma/swiotlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 465a567678d9..e08cac39c0ba 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -229,6 +229,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
>  	}
>  	io_tlb_index = 0;
> +	no_iotlb_memory = false;
>  
>  	if (verbose)
>  		swiotlb_print_info();
> @@ -260,9 +261,11 @@ swiotlb_init(int verbose)
>  	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
>  		return;
>  
> -	if (io_tlb_start)
> +	if (io_tlb_start) {
>  		memblock_free_early(io_tlb_start,
>  				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
> +		io_tlb_start = 0;
> +	}
>  	pr_warn("Cannot allocate buffer");
>  	no_iotlb_memory = true;
>  }
> @@ -360,6 +363,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
>  	}
>  	io_tlb_index = 0;
> +	no_iotlb_memory = false;
>  
>  	swiotlb_print_info();
>  
> -- 
> 2.13.6
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
