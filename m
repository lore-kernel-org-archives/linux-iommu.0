Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC14C49ED8
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 15:15:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798B5206A5
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 15:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aKfiTFQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798B5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4437BD8B;
	Tue, 10 Sep 2019 15:15:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 81251C74
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 15:15:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B3E478A2
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 15:15:03 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x8AF86si176710; Tue, 10 Sep 2019 15:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2019-08-05;
	bh=87N8U/k4TqTdd6nekxQxe24VbE8lpU4BMVpFYqe0QJQ=;
	b=aKfiTFQ59IdJsWLn4WX21dXc9FVQy7Zcsr0/BIaQ2Z8ce09woYnRACi02coqR4ZoLyna
	le51j6Sw4SjRdOeyYczrjTrFuEKkxLU2oQ4qsL2LlvCEyoHtY7ah4Qu6Ay8YkhLBnLVJ
	59qRFAG8+mLgksxLcNXMEbgUegWAPHQs/ALymWY8OSRL592/xsgLoXT2CQix8TBmGIaC
	ao4Jpe/bdJFgK29qbK9MC0ZXYzHv5APC1g/dS1Z/gSs9f9TQf0UOXH9ZqYLXnCPrzOGv
	1mq6m9++FSnbMJOYQABFLgz3T39EzZ9urAto22yX+cmqKPo8uHtkSQO4GWFGknGdTlf0
	sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 2uw1jy45t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2019 15:14:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x8AF3gb2071729; Tue, 10 Sep 2019 15:14:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 2uxd6ck7hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2019 15:14:06 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8AFE0hj031186;
	Tue, 10 Sep 2019 15:14:00 GMT
Received: from char.us.oracle.com (/10.152.32.25)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 10 Sep 2019 08:14:00 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
	id 819AB6A010E; Tue, 10 Sep 2019 11:15:44 -0400 (EDT)
Date: Tue, 10 Sep 2019 11:15:44 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 1/5] swiotlb: Split size parameter to map/unmap APIs
Message-ID: <20190910151544.GA7585@char.us.oracle.com>
References: <20190906061452.30791-1-baolu.lu@linux.intel.com>
	<20190906061452.30791-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190906061452.30791-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1906280000 definitions=main-1909100146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
	definitions=main-1909100146
Cc: Juergen Gross <jgross@suse.com>, kevin.tian@intel.com,
	Stefano Stabellini <sstabellini@kernel.org>,
	mika.westerberg@linux.intel.com, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, alan.cox@intel.com,
	Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	pengfei.xu@intel.com, Ingo Molnar <mingo@redhat.com>,
	jacob.jun.pan@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Fri, Sep 06, 2019 at 02:14:48PM +0800, Lu Baolu wrote:
> This splits the size parameter to swiotlb_tbl_map_single() and
> swiotlb_tbl_unmap_single() into an alloc_size and a mapping_size
> parameter, where the latter one is rounded up to the iommu page
> size.

It does a bit more too. You have the WARN_ON. Can you make it be
more  verbose (as in details of which device requested it) and also use printk_once or so please?
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/xen/swiotlb-xen.c |  8 ++++----
>  include/linux/swiotlb.h   |  8 ++++++--
>  kernel/dma/direct.c       |  2 +-
>  kernel/dma/swiotlb.c      | 30 +++++++++++++++++++-----------
>  4 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index ae1df496bf38..adcabd9473eb 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -386,8 +386,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	 */
>  	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
>  
> -	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
> -				     attrs);
> +	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys,
> +				     size, size, dir, attrs);
>  	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return DMA_MAPPING_ERROR;
>  
> @@ -397,7 +397,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	 * Ensure that the address returned is DMA'ble
>  	 */
>  	if (unlikely(!dma_capable(dev, dev_addr, size))) {
> -		swiotlb_tbl_unmap_single(dev, map, size, dir,
> +		swiotlb_tbl_unmap_single(dev, map, size, size, dir,
>  				attrs | DMA_ATTR_SKIP_CPU_SYNC);
>  		return DMA_MAPPING_ERROR;
>  	}
> @@ -433,7 +433,7 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
>  
>  	/* NOTE: We use dev_addr here, not paddr! */
>  	if (is_xen_swiotlb_buffer(dev_addr))
> -		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
> +		swiotlb_tbl_unmap_single(hwdev, paddr, size, size, dir, attrs);
>  }
>  
>  static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 361f62bb4a8e..cde3dc18e21a 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -46,13 +46,17 @@ enum dma_sync_target {
>  
>  extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  					  dma_addr_t tbl_dma_addr,
> -					  phys_addr_t phys, size_t size,
> +					  phys_addr_t phys,
> +					  size_t mapping_size,
> +					  size_t alloc_size,
>  					  enum dma_data_direction dir,
>  					  unsigned long attrs);
>  
>  extern void swiotlb_tbl_unmap_single(struct device *hwdev,
>  				     phys_addr_t tlb_addr,
> -				     size_t size, enum dma_data_direction dir,
> +				     size_t mapping_size,
> +				     size_t alloc_size,
> +				     enum dma_data_direction dir,
>  				     unsigned long attrs);
>  
>  extern void swiotlb_tbl_sync_single(struct device *hwdev,
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 706113c6bebc..8402b29c280f 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -305,7 +305,7 @@ void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
>  		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
>  
>  	if (unlikely(is_swiotlb_buffer(phys)))
> -		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> +		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
>  }
>  EXPORT_SYMBOL(dma_direct_unmap_page);
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 9de232229063..89066efa3840 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -444,7 +444,9 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>  
>  phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  				   dma_addr_t tbl_dma_addr,
> -				   phys_addr_t orig_addr, size_t size,
> +				   phys_addr_t orig_addr,
> +				   size_t mapping_size,
> +				   size_t alloc_size,
>  				   enum dma_data_direction dir,
>  				   unsigned long attrs)
>  {
> @@ -464,6 +466,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  		pr_warn_once("%s is active and system is using DMA bounce buffers\n",
>  			     sme_active() ? "SME" : "SEV");
>  
> +	if (WARN_ON(mapping_size > alloc_size))
> +		return (phys_addr_t)DMA_MAPPING_ERROR;
> +
>  	mask = dma_get_seg_boundary(hwdev);
>  
>  	tbl_dma_addr &= mask;
> @@ -481,8 +486,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  	 * For mappings greater than or equal to a page, we limit the stride
>  	 * (and hence alignment) to a page size.
>  	 */
> -	nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> -	if (size >= PAGE_SIZE)
> +	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> +	if (alloc_size >= PAGE_SIZE)
>  		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
>  	else
>  		stride = 1;
> @@ -547,7 +552,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
> -			 size, io_tlb_nslabs, tmp_io_tlb_used);
> +			 alloc_size, io_tlb_nslabs, tmp_io_tlb_used);
>  	return (phys_addr_t)DMA_MAPPING_ERROR;
>  found:
>  	io_tlb_used += nslots;
> @@ -562,7 +567,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>  	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
> -		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
> +		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
>  
>  	return tlb_addr;
>  }
> @@ -571,21 +576,24 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>   * tlb_addr is the physical address of the bounce buffer to unmap.
>   */
>  void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
> -			      size_t size, enum dma_data_direction dir,
> -			      unsigned long attrs)
> +			      size_t mapping_size, size_t alloc_size,
> +			      enum dma_data_direction dir, unsigned long attrs)
>  {
>  	unsigned long flags;
> -	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> +	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
>  	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
>  	phys_addr_t orig_addr = io_tlb_orig_addr[index];
>  
> +	if (WARN_ON(mapping_size > alloc_size))
> +		return;
> +
>  	/*
>  	 * First, sync the memory before unmapping the entry
>  	 */
>  	if (orig_addr != INVALID_PHYS_ADDR &&
>  	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>  	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
> -		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_FROM_DEVICE);
> +		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
>  
>  	/*
>  	 * Return the buffer to the free list by setting the corresponding
> @@ -665,14 +673,14 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
>  
>  	/* Oh well, have to allocate and map a bounce buffer. */
>  	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
> -			*phys, size, dir, attrs);
> +			*phys, size, size, dir, attrs);
>  	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return false;
>  
>  	/* Ensure that the address returned is DMA'ble */
>  	*dma_addr = __phys_to_dma(dev, *phys);
>  	if (unlikely(!dma_capable(dev, *dma_addr, size))) {
> -		swiotlb_tbl_unmap_single(dev, *phys, size, dir,
> +		swiotlb_tbl_unmap_single(dev, *phys, size, size, dir,
>  			attrs | DMA_ATTR_SKIP_CPU_SYNC);
>  		return false;
>  	}
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
