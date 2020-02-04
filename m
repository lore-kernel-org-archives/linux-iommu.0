Return-Path: <SRS0=/T8B=3Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48137C2D0B1
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 14:55:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD7920674
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IlLDSS7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD7920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4E0EB2002E;
	Tue,  4 Feb 2020 14:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gz261qur+P2j; Tue,  4 Feb 2020 14:55:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 48257203CC;
	Tue,  4 Feb 2020 14:55:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 356D4C0177;
	Tue,  4 Feb 2020 14:55:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E250BC0174
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 14:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DEDDA844E7
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 14:55:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TYByOHHBctF1 for <iommu@lists.linux-foundation.org>;
 Tue,  4 Feb 2020 14:55:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 64D2384481
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 14:55:29 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014ErGnh006974;
 Tue, 4 Feb 2020 14:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=472KVVITZrZgKe2UcQ3H4GcCCMtpRSLOZXx9ZMV5B0I=;
 b=IlLDSS7nRj2Wn+evlXtMg16N+ekxW8kL+yMuQkamcUD+vYfK2haYBVaJx/esSBoqJZw7
 TYjCCxRerXYU9MUTJNzigPmFRVlLQNdG+cGE1wDDLypAhWlBr3SSRxiA/2RApZ2yGsVh
 zqGFwpBonvxsoO19w4uqUD5TjQxSN12xLq+03lm4ZbpeYEaUuDzOIs/q14+mnAhbEo5X
 cGp6DUy2lCBOibowqDONzzbVEuu0TBffEo5VohqatAswErHNGtPgY58dm4QKf/C4Hfv+
 mvBWSQd2hbO9lU++J0qtyeEi0a8o3RUXH5B92PiGG/GW5wbZ7ODCuROUtBO4Ws4i+P7I Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2xwyg9kcnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2020 14:55:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014Ertss009442;
 Tue, 4 Feb 2020 14:55:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2xxvurxhck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2020 14:55:28 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014EtQQN021322;
 Tue, 4 Feb 2020 14:55:26 GMT
Received: from localhost.localdomain (/172.58.219.138)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 04 Feb 2020 06:55:26 -0800
Date: Tue, 4 Feb 2020 09:55:24 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] dma-direct: improve DMA mask overflow reporting
Message-ID: <20200204145524.GC5400@localhost.localdomain>
References: <20200204063205.652456-1-hch@lst.de>
 <20200204063205.652456-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200204063205.652456-3-hch@lst.de>
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

On Tue, Feb 04, 2020 at 07:32:05AM +0100, Christoph Hellwig wrote:
> Remove the unset dma_mask case as that won't get into mapping calls
> anymore, and also report the other errors unconditonally and with a
> slightly improved message.  Remove the now pointless report_addr helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Reviewed-by: Konrad Rzeszutek Wilk <konrad@darnok.org>

> ---
>  kernel/dma/direct.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 82ad50aaf42c..04f308a47fc3 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -23,18 +23,6 @@
>   */
>  unsigned int zone_dma_bits __ro_after_init = 24;
>  
> -static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
> -{
> -	if (!dev->dma_mask) {
> -		dev_err_once(dev, "DMA map on device without dma_mask\n");
> -	} else if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_limit) {
> -		dev_err_once(dev,
> -			"overflow %pad+%zu of DMA mask %llx bus limit %llx\n",
> -			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
> -	}
> -	WARN_ON_ONCE(1);
> -}
> -
>  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>  		phys_addr_t phys)
>  {
> @@ -371,7 +359,10 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
>  		if (swiotlb_force != SWIOTLB_NO_FORCE)
>  			return swiotlb_map(dev, phys, size, dir, attrs);
>  
> -		report_addr(dev, dma_addr, size);
> +		dev_err_once(dev,
> +			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
> +			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
> +		WARN_ON_ONCE(1);
>  		return DMA_MAPPING_ERROR;
>  	}
>  
> @@ -409,7 +400,10 @@ dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
>  	dma_addr_t dma_addr = paddr;
>  
>  	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
> -		report_addr(dev, dma_addr, size);
> +		dev_err_once(dev,
> +			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
> +			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
> +		WARN_ON_ONCE(1);
>  		return DMA_MAPPING_ERROR;
>  	}
>  
> -- 
> 2.24.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
