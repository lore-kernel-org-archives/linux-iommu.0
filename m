Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC80C83007
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 08:02:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A197206B9
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 08:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AkRzSgUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A197206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 54D88864C1;
	Tue, 28 Apr 2020 08:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rqadX9WJNX8b; Tue, 28 Apr 2020 08:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B66C585BCC;
	Tue, 28 Apr 2020 08:02:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8671C0863;
	Tue, 28 Apr 2020 08:02:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9501C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A76DC85A96
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iWKozsmXAgoZ for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 08:02:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2C31385A60
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0Gc8wiZaH5vxzoL7Y4RD61mnokWImM3/OUm105M5x4Q=; b=AkRzSgUBS3spTGGb1FU2ZdnFp4
 7BKimlNU77GlBbuUM/8B5MPQQ/E6pQxNnqbGv+7iaZdB1yzXSBR4E6U5GIwvyG6VLpIOzmZt8b+Af
 FhXp4/msJvZ5wc9Q/RiSGYZjj5WugzIgMCgyvRtTHLiMoRI/isejvWR1rP9hHQqpa9qWD+mUpziT9
 uaVqa13Hhc/t59XAU11bOMVnUb4ynS0/3sHmfE672BTSnYmRzfdf+63SFCOFf2DKOM2/lg8NAzimF
 fD0PTuRTAIjTIr+c2X26hXxC4p/Xa5P+lwbVfvO9LSTlCL0fe8zEy86Odd6yWyhlALdnxCk28aydq
 KqW8hdGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jTLBy-0000XO-Ed; Tue, 28 Apr 2020 08:02:10 +0000
Date: Tue, 28 Apr 2020 01:02:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: peng.fan@nxp.com
Subject: Re: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
Message-ID: <20200428080210.GA25643@infradead.org>
References: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: jgross@suse.com, sstabellini@kernel.org, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-imx@nxp.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
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

On Tue, Apr 28, 2020 at 03:33:45PM +0800, peng.fan@nxp.com wrote:
> 
> In xen_swiotlb_alloc_coherent, if !(dev_addr + size - 1 <= dma_mask) or
> range_straddles_page_boundary(phys, size) are true, it will
> create contiguous region. So when free, we need to free contiguous
> region use upper check condition.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/xen/swiotlb-xen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index b6d27762c6f8..ab96e468584f 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -346,8 +346,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> -	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
> -		     range_straddles_page_boundary(phys, size)) &&
> +	if (((dev_addr + size - 1 > dma_mask) ||
> +	    range_straddles_page_boundary(phys, size)) &&
>  	    TestClearPageXenRemapped(virt_to_page(vaddr)))

No need for the inner braces.

But more importantly please factor our a helper that can be used by
alloc and free to make sure that they always stay in sync.  Something
like:

static inline bool xen_swiotlb_need_contiguous_region(struct device *dev,
		phys_addr_t phys, size_t size)
{
	
	return xen_phys_to_bus(phys) + size - 1 > dev->coherent_dma_mask ||
		range_straddles_page_boundary(phys, size))
}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
