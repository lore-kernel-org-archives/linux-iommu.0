Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D27C10F03
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 17:06:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D91218D2
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 17:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzTSDLON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D91218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 417CDCD4;
	Tue, 23 Apr 2019 17:06:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 93284CCB
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 17:06:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 45F3BF4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 17:06:08 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B075821850;
	Tue, 23 Apr 2019 17:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556039168;
	bh=i2JIjq6aZqmQv7kstuBZrccA+R9sQNWobjLeh+18V/c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kzTSDLONeEaMkdNJaBpJTVTxUi+JRdWZL1srIKm1BwEa7hE/v6ODhR8nbhgBcoPV2
	D1k5kEj+JoiESav7hOBHHdfBDpl5MVGxwuicWbeF+Db629CAgchY99DQ5GTJJFMwrX
	j/5/0K6m7DUqpkm5w+odQmi4iMADi08L+czZz7Jo=
Date: Tue, 23 Apr 2019 10:05:54 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 3/3] xen/swiotlb: remember having called
	xen_create_contiguous_region()
In-Reply-To: <20190423105457.17502-4-jgross@suse.com>
Message-ID: <alpine.DEB.2.10.1904230955190.24598@sstabellini-ThinkPad-X260>
References: <20190423105457.17502-1-jgross@suse.com>
	<20190423105457.17502-4-jgross@suse.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Cc: sstabellini@kernel.org, konrad.wilk@oracle.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423170554.Ko59k97b2SiXxBSGAh9wX1tOG1DeojtP2BsEkZHpQts@z>

On Tue, 23 Apr 2019, Juergen Gross wrote:
> Instead of always calling xen_destroy_contiguous_region() in case the
> memory is DMA-able for the used device, do so only in case it has been
> made DMA-able via xen_create_contiguous_region() before.
> 
> This will avoid a lot of xen_destroy_contiguous_region() calls for
> 64-bit capable devices.
> 
> As the memory in question is owned by swiotlb-xen the PG_owner_priv_1
> flag of the first allocated page can be used for remembering.

Although the patch looks OK, this sentence puzzles me. Why do you say
that the memory in question is owned by swiotlb-xen? Because it was
returned by xen_alloc_coherent_pages? Both the x86 and the Arm
implementation return fresh new memory, hence, it should be safe to set
the PageOwnerPriv1 flag?

My concern with this approach is with the semantics of PG_owner_priv_1.
Is a page marked with PG_owner_priv_1 only supposed to be used by the
owner?


> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/xen/swiotlb-xen.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 43b6e65ae256..a72f181d8e20 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -321,6 +321,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
>  			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
>  			return NULL;
>  		}
> +		SetPageOwnerPriv1(virt_to_page(ret));
>  	}
>  	memset(ret, 0, size);
>  	return ret;
> @@ -344,9 +345,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> -	if ((dev_addr + size - 1 <= dma_mask) &&
> -	    !WARN_ON(range_straddles_page_boundary(phys, size)))
> -		xen_destroy_contiguous_region(phys, order);
> +	if (PageOwnerPriv1(virt_to_page(vaddr))) {
> +		if (!WARN_ON(range_straddles_page_boundary(phys, size)))
> +			xen_destroy_contiguous_region(phys, order);
> +		ClearPageOwnerPriv1(virt_to_page(vaddr));
> +	}
>  
>  	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
>  }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
