Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4D9C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E9E20830
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E9E20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DD8A91B8C;
	Wed, 10 Apr 2019 16:55:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 592081B41
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 16:54:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 639CA855
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 16:54:43 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id F078A67358; Wed, 10 Apr 2019 18:54:30 +0200 (CEST)
Date: Wed, 10 Apr 2019 18:54:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: davem@davemloft.net
Subject: Re: [PATCH] sparc64/pci_sun4v: fix ATU checks for large DMA masks
Message-ID: <20190410165430.GA7538@lst.de>
References: <20190404162538.22428-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190404162538.22428-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org,
	mroos@linux.ee
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
Message-ID: <20190410165430.c5eRmBzEYR375rlq-4Hz4qy-k-c7ffUGO70zqltTj30@z>

Dave, are you going to pick this up through the sparc tree, or do
you expect me to send it through the dma-mapping one?

On Thu, Apr 04, 2019 at 06:25:38PM +0200, Christoph Hellwig wrote:
> Now that we allow drivers to always need to set larger than required
> DMA masks we need to be a little more careful in the sun4v PCI iommu
> driver to chose when to select the ATU support - a larger DMA mask
> can be set even when the platform does not support ATU, so we always
> have to check if it is avaiable before using it.  Add a little helper
> for that and use it in all the places where we make ATU usage decisions
> based on the DMA mask.
> 
> Fixes: 24132a419c68 ("sparc64/pci_sun4v: allow large DMA masks")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Meelis Roos <mroos@linux.ee>
> ---
>  arch/sparc/kernel/pci_sun4v.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
> index a8af6023c126..14b93c5564e3 100644
> --- a/arch/sparc/kernel/pci_sun4v.c
> +++ b/arch/sparc/kernel/pci_sun4v.c
> @@ -73,6 +73,11 @@ static inline void iommu_batch_start(struct device *dev, unsigned long prot, uns
>  	p->npages	= 0;
>  }
>  
> +static inline bool iommu_use_atu(struct iommu *iommu, u64 mask)
> +{
> +	return iommu->atu && mask > DMA_BIT_MASK(32);
> +}
> +
>  /* Interrupts must be disabled.  */
>  static long iommu_batch_flush(struct iommu_batch *p, u64 mask)
>  {
> @@ -92,7 +97,7 @@ static long iommu_batch_flush(struct iommu_batch *p, u64 mask)
>  		prot &= (HV_PCI_MAP_ATTR_READ | HV_PCI_MAP_ATTR_WRITE);
>  
>  	while (npages != 0) {
> -		if (mask <= DMA_BIT_MASK(32) || !pbm->iommu->atu) {
> +		if (!iommu_use_atu(pbm->iommu, mask)) {
>  			num = pci_sun4v_iommu_map(devhandle,
>  						  HV_PCI_TSBID(0, entry),
>  						  npages,
> @@ -179,7 +184,6 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
>  	unsigned long flags, order, first_page, npages, n;
>  	unsigned long prot = 0;
>  	struct iommu *iommu;
> -	struct atu *atu;
>  	struct iommu_map_table *tbl;
>  	struct page *page;
>  	void *ret;
> @@ -205,13 +209,11 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
>  	memset((char *)first_page, 0, PAGE_SIZE << order);
>  
>  	iommu = dev->archdata.iommu;
> -	atu = iommu->atu;
> -
>  	mask = dev->coherent_dma_mask;
> -	if (mask <= DMA_BIT_MASK(32) || !atu)
> +	if (!iommu_use_atu(iommu, mask))
>  		tbl = &iommu->tbl;
>  	else
> -		tbl = &atu->tbl;
> +		tbl = &iommu->atu->tbl;
>  
>  	entry = iommu_tbl_range_alloc(dev, tbl, npages, NULL,
>  				      (unsigned long)(-1), 0);
> @@ -333,7 +335,7 @@ static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
>  	atu = iommu->atu;
>  	devhandle = pbm->devhandle;
>  
> -	if (dvma <= DMA_BIT_MASK(32)) {
> +	if (!iommu_use_atu(iommu, dvma)) {
>  		tbl = &iommu->tbl;
>  		iotsb_num = 0; /* we don't care for legacy iommu */
>  	} else {
> @@ -374,7 +376,7 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
>  	npages >>= IO_PAGE_SHIFT;
>  
>  	mask = *dev->dma_mask;
> -	if (mask <= DMA_BIT_MASK(32))
> +	if (!iommu_use_atu(iommu, mask))
>  		tbl = &iommu->tbl;
>  	else
>  		tbl = &atu->tbl;
> @@ -510,7 +512,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
>  				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
>  
>  	mask = *dev->dma_mask;
> -	if (mask <= DMA_BIT_MASK(32))
> +	if (!iommu_use_atu(iommu, mask))
>  		tbl = &iommu->tbl;
>  	else
>  		tbl = &atu->tbl;
> -- 
> 2.20.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
