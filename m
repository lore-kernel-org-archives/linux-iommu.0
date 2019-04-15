Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA3C282DA
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 22:55:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F82320880
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 22:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9XA429Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F82320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 22DBECB2;
	Mon, 15 Apr 2019 22:55:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2051FCA8
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 22:55:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 93F7B2C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 22:55:25 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D8A2E20854;
	Mon, 15 Apr 2019 22:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555368925;
	bh=js5bvjA0nzgx2XC9yVTzbOWG3i5fe6edHcYz6nrpovI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=N9XA429Zj8gSNYepsV9rlu5XZ2plyupWHwkuBWe4QVqPayX/ovaK3xgC5Ze6cuB2t
	KfvfAEseR3aeN+vBbV5LWyPONhHDL9x5xlN7FudL+376tqdYy7EUh/XFTeysNWD8en
	ubUREYUwsq+85+7LayAO0rUKZtNQdwitN/xPe/J0=
Date: Mon, 15 Apr 2019 15:55:24 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] swiotlb-xen: make instances match their method names
In-Reply-To: <20190411072000.4306-2-hch@lst.de>
Message-ID: <alpine.DEB.2.10.1904151534390.29275@sstabellini-ThinkPad-X260>
References: <20190411072000.4306-1-hch@lst.de>
	<20190411072000.4306-2-hch@lst.de>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
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
Message-ID: <20190415225524.AWApijTcTS6tKqGRaYoemZe_tyQLDIEDiBTJ9_pBBio@z>

On Thu, 11 Apr 2019, Christoph Hellwig wrote:
> Just drop two pointless _attrs prefixes to make the code a little
> more grep-able.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  drivers/xen/swiotlb-xen.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 877baf2a94f4..d4bc3aabd44d 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -504,9 +504,8 @@ xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
>   * concerning calls here are the same as for swiotlb_unmap_page() above.
>   */
>  static void
> -xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
> -			   int nelems, enum dma_data_direction dir,
> -			   unsigned long attrs)
> +xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
> +		enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct scatterlist *sg;
>  	int i;
> @@ -535,9 +534,8 @@ xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
>   * same here.
>   */
>  static int
> -xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
> -			 int nelems, enum dma_data_direction dir,
> -			 unsigned long attrs)
> +xen_swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
> +		enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct scatterlist *sg;
>  	int i;
> @@ -562,8 +560,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
>  				/* Don't panic here, we expect map_sg users
>  				   to do proper error handling. */
>  				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> -				xen_swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
> -							   attrs);
> +				xen_swiotlb_unmap_sg(hwdev, sgl, i, dir, attrs);
>  				sg_dma_len(sgl) = 0;
>  				return 0;
>  			}
> @@ -690,8 +687,8 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
>  	.sync_single_for_device = xen_swiotlb_sync_single_for_device,
>  	.sync_sg_for_cpu = xen_swiotlb_sync_sg_for_cpu,
>  	.sync_sg_for_device = xen_swiotlb_sync_sg_for_device,
> -	.map_sg = xen_swiotlb_map_sg_attrs,
> -	.unmap_sg = xen_swiotlb_unmap_sg_attrs,
> +	.map_sg = xen_swiotlb_map_sg,
> +	.unmap_sg = xen_swiotlb_unmap_sg,
>  	.map_page = xen_swiotlb_map_page,
>  	.unmap_page = xen_swiotlb_unmap_page,
>  	.dma_supported = xen_swiotlb_dma_supported,
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
