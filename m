Return-Path: <SRS0=+KpI=US=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41D3C31E5D
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 14:27:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE912182B
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 14:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ee01PXdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE912182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8647FCBA;
	Wed, 19 Jun 2019 14:27:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 35EBAC37
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 14:27:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B7290831
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 14:27:07 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x5JEJnSt019625; Wed, 19 Jun 2019 14:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=yttiPRpSZZrH5iMOgXU87rDYVYrhNSlNRuXPD3dcjrE=;
	b=ee01PXdUFHKCRVZQBbEAuCNZzx/GyLgDcSp/TKtQkXY2DMJxqiwBR1/8P0+sL4K7a7B5
	XBiVILXz095aw8/e6KKqFdA92dOWJ9NRuqgr3rzp/z5XdzYzghRlSDmatpVrzRNszK9L
	IA7sytloqzLGbCju3v6Y+DAtd1dkwMsoJy+qeIbqYkrDQau5vE+Tq1tbXa/ZUbqGM6T2
	vRv1dnJOcHl5uvsyOSEbxBMlJSVlD+OWu8UlPgmk5QI2J8Fq5K95dgsj/UPmz39xrdUU
	uM1ORIHpFA675tloJYNLnO0fWJkls2vhwdz7OkpFgWmyaSZBm9OfHBVa/rC2fGJjLrA+
	PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2t7809btkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2019 14:26:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x5JEQTAe194064; Wed, 19 Jun 2019 14:26:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 2t77ynvp68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2019 14:26:57 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JEQm9v015046;
	Wed, 19 Jun 2019 14:26:48 GMT
Received: from char.us.oracle.com (/10.152.32.25)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 19 Jun 2019 07:26:47 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
	id 434C96A0136; Wed, 19 Jun 2019 10:28:12 -0400 (EDT)
Date: Wed, 19 Jun 2019 10:28:12 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] swiotlb: fix phys_addr_t overflow warning
Message-ID: <20190619142812.GM10432@char.us.oracle.com>
References: <20190617132946.2817440-1-arnd@arndb.de>
	<alpine.DEB.2.21.1906170913080.2072@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906170913080.2072@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906190118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906190118
Cc: Juergen Gross <jgross@suse.com>, Joerg Roedel <jroedel@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@linux.ibm.com>, iommu@lists.linux-foundation.org,
	Jesper Dangaard Brouer <brouer@redhat.com>, xen-devel@lists.xenproject.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, Jun 17, 2019 at 09:13:16AM -0700, Stefano Stabellini wrote:
> On Mon, 17 Jun 2019, Arnd Bergmann wrote:
> > On architectures that have a larger dma_addr_t than phys_addr_t,
> > the swiotlb_tbl_map_single() function truncates its return code
> > in the failure path, making it impossible to identify the error
> > later, as we compare to the original value:
> > 
> > kernel/dma/swiotlb.c:551:9: error: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to 'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]
> >         return DMA_MAPPING_ERROR;
> > 
> > Use an explicit typecast here to convert it to the narrower type,
> > and use the same expression in the error handling later.
> > 
> > Fixes: b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Stefano Stabellini <sstabellini@kernel.org>

queued.
> 
> 
> > ---
> > I still think that reverting the original commit would have
> > provided clearer semantics for this corner case, but at least
> > this patch restores the correct behavior.
> > ---
> >  drivers/xen/swiotlb-xen.c | 2 +-
> >  kernel/dma/swiotlb.c      | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index d53f3493a6b9..cfbe46785a3b 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -402,7 +402,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
> >  
> >  	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
> >  				     attrs);
> > -	if (map == DMA_MAPPING_ERROR)
> > +	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
> >  		return DMA_MAPPING_ERROR;
> >  
> >  	dev_addr = xen_phys_to_bus(map);
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index e906ef2e6315..a3be651973ad 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -548,7 +548,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> >  	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
> >  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
> >  			 size, io_tlb_nslabs, tmp_io_tlb_used);
> > -	return DMA_MAPPING_ERROR;
> > +	return (phys_addr_t)DMA_MAPPING_ERROR;
> >  found:
> >  	io_tlb_used += nslots;
> >  	spin_unlock_irqrestore(&io_tlb_lock, flags);
> > @@ -666,7 +666,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
> >  	/* Oh well, have to allocate and map a bounce buffer. */
> >  	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
> >  			*phys, size, dir, attrs);
> > -	if (*phys == DMA_MAPPING_ERROR)
> > +	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
> >  		return false;
> >  
> >  	/* Ensure that the address returned is DMA'ble */
> > -- 
> > 2.20.0
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
