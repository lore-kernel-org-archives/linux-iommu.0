Return-Path: <SRS0=/T8B=3Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A1BC2D0B1
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 14:54:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B802C20674
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 14:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JhQK0V3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B802C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B69D86B58;
	Tue,  4 Feb 2020 14:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RObAEnmWDf1h; Tue,  4 Feb 2020 14:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F200386961;
	Tue,  4 Feb 2020 14:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7B47C0177;
	Tue,  4 Feb 2020 14:54:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E61FC0174
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 14:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7A97281AE7
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 14:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i1-ldKyPLs3N for <iommu@lists.linux-foundation.org>;
 Tue,  4 Feb 2020 14:54:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4BFED816FA
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 14:54:34 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014ErLF3020718;
 Tue, 4 Feb 2020 14:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=PnHO58KkdOmLOUFqyqRVGS49sqyf4ovWpRs+KKa4/o4=;
 b=JhQK0V3A8oIpLxSYd8jsf6S9ATpcLlaOajW1tfiLP9eQ6tlSvhv6e3+D53EcXcmQ6Lxv
 Pkx2RI2X6vsSkp3CBhTbdaDpv3+xiflCUEFc5YyMZggV854dZOVgXNJ/FY4Y3Xrhr7xD
 oWhsxe4SB6gKMAK54nJ4U1s2b9+j5YErJq2hj8Kq6MVBMUdGF3l5Y8c1vjBAflb0K5ZC
 na7r3qxKN8ZGOuNQuGlFdCCJdUt/RCiPAbENlOt+JBV8ph1gvxsUDlCDEJzO8bJ5tm67
 SqEOt1xMa+y9ArmSu2Jy32cDUiXe4TwrWc5BB5yU7bhYFs7G/uRGGIHW1VID8cVdZ+37 Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2xw0ru75sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2020 14:54:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014ErtxY009369;
 Tue, 4 Feb 2020 14:54:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2xxvurxdfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2020 14:54:31 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014EsT7R020598;
 Tue, 4 Feb 2020 14:54:29 GMT
Received: from localhost.localdomain (/172.58.219.138)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 04 Feb 2020 06:54:28 -0800
Date: Tue, 4 Feb 2020 09:54:26 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-direct: improve swiotlb error reporting
Message-ID: <20200204145426.GB5400@localhost.localdomain>
References: <20200204063205.652456-1-hch@lst.de>
 <20200204063205.652456-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200204063205.652456-2-hch@lst.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040104
Cc: iommu@lists.linux-foundation.org
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

On Tue, Feb 04, 2020 at 07:32:04AM +0100, Christoph Hellwig wrote:
> Untangle the way how dma_direct_map_page calls into swiotlb to be able
> to properly report errors where the swiotlb DMA address overflows the
> mask separately from overflows in the !swiotlb case.  This means that
> siotlb_map now has to do a little more work that duplicates
> dma_direct_map_page, but doing so greatly simplifies the calling
> convention.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Konrad Rzeszutek Wilk <konrad@darnok.org>

(Pick whichever tag you want :-))
> ---
>  include/linux/swiotlb.h | 11 +++--------
>  kernel/dma/direct.c     | 16 +++++++--------
>  kernel/dma/swiotlb.c    | 43 +++++++++++++++++++++++------------------
>  3 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index cde3dc18e21a..046bb94bd4d6 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -64,6 +64,9 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
>  				    size_t size, enum dma_data_direction dir,
>  				    enum dma_sync_target target);
>  
> +dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs);
> +
>  #ifdef CONFIG_SWIOTLB
>  extern enum swiotlb_force swiotlb_force;
>  extern phys_addr_t io_tlb_start, io_tlb_end;
> @@ -73,8 +76,6 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
>  	return paddr >= io_tlb_start && paddr < io_tlb_end;
>  }
>  
> -bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs);
>  void __init swiotlb_exit(void);
>  unsigned int swiotlb_max_segment(void);
>  size_t swiotlb_max_mapping_size(struct device *dev);
> @@ -85,12 +86,6 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
>  {
>  	return false;
>  }
> -static inline bool swiotlb_map(struct device *dev, phys_addr_t *phys,
> -		dma_addr_t *dma_addr, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -	return false;
> -}
>  static inline void swiotlb_exit(void)
>  {
>  }
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 6af7ae83c4ad..82ad50aaf42c 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -357,13 +357,6 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  EXPORT_SYMBOL(dma_direct_unmap_sg);
>  #endif
>  
> -static inline bool dma_direct_possible(struct device *dev, dma_addr_t dma_addr,
> -		size_t size)
> -{
> -	return swiotlb_force != SWIOTLB_FORCE &&
> -		dma_capable(dev, dma_addr, size, true);
> -}
> -
>  dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
>  		unsigned long offset, size_t size, enum dma_data_direction dir,
>  		unsigned long attrs)
> @@ -371,8 +364,13 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
>  	phys_addr_t phys = page_to_phys(page) + offset;
>  	dma_addr_t dma_addr = phys_to_dma(dev, phys);
>  
> -	if (unlikely(!dma_direct_possible(dev, dma_addr, size)) &&
> -	    !swiotlb_map(dev, &phys, &dma_addr, size, dir, attrs)) {
> +	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
> +		return swiotlb_map(dev, phys, size, dir, attrs);
> +
> +	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> +		if (swiotlb_force != SWIOTLB_NO_FORCE)
> +			return swiotlb_map(dev, phys, size, dir, attrs);
> +
>  		report_addr(dev, dma_addr, size);
>  		return DMA_MAPPING_ERROR;
>  	}
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 9280d6f8271e..589bb9a40f21 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -22,6 +22,7 @@
>  
>  #include <linux/cache.h>
>  #include <linux/dma-direct.h>
> +#include <linux/dma-noncoherent.h>
>  #include <linux/mm.h>
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
> @@ -656,35 +657,39 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
>  }
>  
>  /*
> - * Create a swiotlb mapping for the buffer at @phys, and in case of DMAing
> + * Create a swiotlb mapping for the buffer at @paddr, and in case of DMAing
>   * to the device copy the data into it as well.
>   */
> -bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
> +		enum dma_data_direction dir, unsigned long attrs)
>  {
> -	trace_swiotlb_bounced(dev, *dma_addr, size, swiotlb_force);
> +	phys_addr_t swiotlb_addr;
> +	dma_addr_t dma_addr;
>  
> -	if (unlikely(swiotlb_force == SWIOTLB_NO_FORCE)) {
> -		dev_warn_ratelimited(dev,
> -			"Cannot do DMA to address %pa\n", phys);
> -		return false;
> -	}
> +	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size,
> +			      swiotlb_force);
>  
> -	/* Oh well, have to allocate and map a bounce buffer. */
> -	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
> -			*phys, size, size, dir, attrs);
> -	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
> -		return false;
> +	swiotlb_addr = swiotlb_tbl_map_single(dev,
> +			__phys_to_dma(dev, io_tlb_start),
> +			paddr, size, size, dir, attrs);
> +	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
> +		return DMA_MAPPING_ERROR;
>  
>  	/* Ensure that the address returned is DMA'ble */
> -	*dma_addr = __phys_to_dma(dev, *phys);
> -	if (unlikely(!dma_capable(dev, *dma_addr, size, true))) {
> -		swiotlb_tbl_unmap_single(dev, *phys, size, size, dir,
> +	dma_addr = __phys_to_dma(dev, swiotlb_addr);
> +	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> +		swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, size, dir,
>  			attrs | DMA_ATTR_SKIP_CPU_SYNC);
> -		return false;
> +		dev_err_once(dev,
> +			"swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
> +			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
> +		WARN_ON_ONCE(1);
> +		return DMA_MAPPING_ERROR;
>  	}
>  
> -	return true;
> +	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		arch_sync_dma_for_device(swiotlb_addr, size, dir);
> +	return dma_addr;
>  }
>  
>  size_t swiotlb_max_mapping_size(struct device *dev)
> -- 
> 2.24.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
