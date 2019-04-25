Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7F8C10F03
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 09:14:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5608E218B0
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 09:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5608E218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5A9781BB6;
	Thu, 25 Apr 2019 09:14:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E638419D1
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 09:13:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from prv1-mh.provo.novell.com (prv1-mh.provo.novell.com
	[137.65.248.33])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 152EB74A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 09:13:55 +0000 (UTC)
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
	with Novell_GroupWise; Thu, 25 Apr 2019 02:53:44 -0600
Message-Id: <5CC175950200007800228E80@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date: Thu, 25 Apr 2019 02:53:41 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Juergen Gross" <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH 1/3] xen/swiotlb: fix condition for
	calling xen_destroy_contiguous_region()
References: <20190423105457.17502-1-jgross@suse.com>
	<20190423105457.17502-2-jgross@suse.com>
In-Reply-To: <20190423105457.17502-2-jgross@suse.com>
Mime-Version: 1.0
Content-Disposition: inline
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	xen-devel <xen-devel@lists.xenproject.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
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
Message-ID: <20190425085341.w39SrsrwTdWsLWFCf9QbtURuXr4rSkY-E6_OAyyuGiA@z>

>>> On 23.04.19 at 12:54, <jgross@suse.com> wrote:
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -360,8 +360,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> -	if (((dev_addr + size - 1 <= dma_mask)) ||
> -	    range_straddles_page_boundary(phys, size))
> +	if ((dev_addr + size - 1 <= dma_mask) &&
> +	    !WARN_ON(range_straddles_page_boundary(phys, size)))
>  		xen_destroy_contiguous_region(phys, order);

On the allocation side we have

	if (((dev_addr + size - 1 <= dma_mask)) &&
	    !range_straddles_page_boundary(phys, size))
		*dma_handle = dev_addr;
	else {
		if (xen_create_contiguous_region(phys, order,
						 fls64(dma_mask), dma_handle) != 0) {
			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
			return NULL;
		}
	}

which is (as far as the function call is concerned)

	if ((dev_addr + size - 1 > dma_mask) ||
	    range_straddles_page_boundary(phys, size))
		xen_create_contiguous_region(...);

So I don't think your transformation is correct. Even worse, both
parts of the condition in xen_swiotlb_free_coherent() act on an
address that is the _result_ of the prior
xen_create_contiguous_region(), i.e. the address should always
match _both_ criteria anyway. Whereas what you really want is
undo the xen_create_contiguous_region() only when it actually
was called. Otherwise you also shatter contiguous allocations
that were contiguous already for other reasons (perhaps just
luck).

Jan


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
