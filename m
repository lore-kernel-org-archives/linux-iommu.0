Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF5AC2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 14:03:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7846021734
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 14:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jVhuBoPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7846021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0381886AEE;
	Wed,  4 Nov 2020 14:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UQznZL0x6QoQ; Wed,  4 Nov 2020 14:03:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2623D869BD;
	Wed,  4 Nov 2020 14:03:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0283C0889;
	Wed,  4 Nov 2020 14:03:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF369C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 14:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DD30087514
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 14:03:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CH5LvnLyEAV5 for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 14:02:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 53644874EA
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 14:02:59 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4DsuoD112289;
 Wed, 4 Nov 2020 14:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=co77JaRJ5bF4cYzdCBPJuo/NyzpVk8qYpRiUCdlnp68=;
 b=jVhuBoPc/dJ+iGyewioD5U7LQ3IeSTP587CVWuXApuERGNRAL+7fS27R7ef0ch8tnyWd
 gZ5sSOV3SuvTV7/6FlY5sBNh337J620i2ZInM/EnkbJEvAtR7q2oJ5VBEpO5c2plxBUZ
 AczmPAqHZ7dy9av2C/jYX8xIJ2rKtRYSwNOXczHaU7wy2OjpVOXFcqUDtE4RXJPdGaIe
 gEhBv6gISN1YEgdxfafSqu2yjasV77DQgr/+bou+BP1G41QwnSJET9OnxuIIBSOt2lrr
 Wb9784lVSgtAAs8p/ECZ/w9Xw9onIViN/QhaW6WkhLJNe5amtRFI4EQJAyvt6lijWXkx hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 34hhw2pud5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 04 Nov 2020 14:02:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4E0jWQ009726;
 Wed, 4 Nov 2020 14:02:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 34hw0fjnn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Nov 2020 14:02:55 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A4E2pcr004324;
 Wed, 4 Nov 2020 14:02:52 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Nov 2020 06:02:51 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 8D47C6A00F9; Wed,  4 Nov 2020 09:04:38 -0500 (EST)
Date: Wed, 4 Nov 2020 09:04:38 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH for-5.10] swiotlb: remove the tbl_dma_addr argument to
 swiotlb_tbl_map_single
Message-ID: <20201104140438.GA16892@char.us.oracle.com>
References: <20201023063309.3472987-1-hch@lst.de>
 <20201103094643.GA18936@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103094643.GA18936@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040104
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 Stefano Stabellini <sstabellini@kernel.org>
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

On Tue, Nov 03, 2020 at 10:46:43AM +0100, Christoph Hellwig wrote:
> ping?

Hopefully this goes through. I am in the process of testing it but ran
into testing issues that I believe are unrelated.


> 
> On Fri, Oct 23, 2020 at 08:33:09AM +0200, Christoph Hellwig wrote:
> > The tbl_dma_addr argument is used to check the DMA boundary for the
> > allocations, and thus needs to be a dma_addr_t.  swiotlb-xen instead
> > passed a physical address, which could lead to incorrect results for
> > strange offsets.  Fix this by removing the parameter entirely and hard
> > code the DMA address for io_tlb_start instead.
> > 
> > Fixes: 91ffe4ad534a ("swiotlb-xen: introduce phys_to_dma/dma_to_phys translations")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > ---
> >  drivers/iommu/intel/iommu.c |  5 ++---
> >  drivers/xen/swiotlb-xen.c   |  3 +--
> >  include/linux/swiotlb.h     | 10 +++-------
> >  kernel/dma/swiotlb.c        | 16 ++++++----------
> >  4 files changed, 12 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 8651f6d4dfa032..6b560e6f193096 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -3815,9 +3815,8 @@ bounce_map_single(struct device *dev, phys_addr_t paddr, size_t size,
> >  	 * page aligned, we don't need to use a bounce page.
> >  	 */
> >  	if (!IS_ALIGNED(paddr | size, VTD_PAGE_SIZE)) {
> > -		tlb_addr = swiotlb_tbl_map_single(dev,
> > -				phys_to_dma_unencrypted(dev, io_tlb_start),
> > -				paddr, size, aligned_size, dir, attrs);
> > +		tlb_addr = swiotlb_tbl_map_single(dev, paddr, size,
> > +				aligned_size, dir, attrs);
> >  		if (tlb_addr == DMA_MAPPING_ERROR) {
> >  			goto swiotlb_error;
> >  		} else {
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index 71ce1b7a23d1cc..2b385c1b4a99cb 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -395,8 +395,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
> >  	 */
> >  	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
> >  
> > -	map = swiotlb_tbl_map_single(dev, virt_to_phys(xen_io_tlb_start),
> > -				     phys, size, size, dir, attrs);
> > +	map = swiotlb_tbl_map_single(dev, phys, size, size, dir, attrs);
> >  	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
> >  		return DMA_MAPPING_ERROR;
> >  
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 513913ff748626..3bb72266a75a1d 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -45,13 +45,9 @@ enum dma_sync_target {
> >  	SYNC_FOR_DEVICE = 1,
> >  };
> >  
> > -extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> > -					  dma_addr_t tbl_dma_addr,
> > -					  phys_addr_t phys,
> > -					  size_t mapping_size,
> > -					  size_t alloc_size,
> > -					  enum dma_data_direction dir,
> > -					  unsigned long attrs);
> > +phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
> > +		size_t mapping_size, size_t alloc_size,
> > +		enum dma_data_direction dir, unsigned long attrs);
> >  
> >  extern void swiotlb_tbl_unmap_single(struct device *hwdev,
> >  				     phys_addr_t tlb_addr,
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index b4eea0abc3f002..92e2f54f24c01b 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -441,14 +441,11 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
> >  	}
> >  }
> >  
> > -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> > -				   dma_addr_t tbl_dma_addr,
> > -				   phys_addr_t orig_addr,
> > -				   size_t mapping_size,
> > -				   size_t alloc_size,
> > -				   enum dma_data_direction dir,
> > -				   unsigned long attrs)
> > +phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
> > +		size_t mapping_size, size_t alloc_size,
> > +		enum dma_data_direction dir, unsigned long attrs)
> >  {
> > +	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
> >  	unsigned long flags;
> >  	phys_addr_t tlb_addr;
> >  	unsigned int nslots, stride, index, wrap;
> > @@ -667,9 +664,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
> >  	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size,
> >  			      swiotlb_force);
> >  
> > -	swiotlb_addr = swiotlb_tbl_map_single(dev,
> > -			phys_to_dma_unencrypted(dev, io_tlb_start),
> > -			paddr, size, size, dir, attrs);
> > +	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, dir,
> > +			attrs);
> >  	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
> >  		return DMA_MAPPING_ERROR;
> >  
> > -- 
> > 2.28.0
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
