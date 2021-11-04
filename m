Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A80C433F5
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:18:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F2660FE3
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7F2660FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E622403A3;
	Thu,  4 Nov 2021 12:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hWGgx_fVvdak; Thu,  4 Nov 2021 12:18:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C4F47402BC;
	Thu,  4 Nov 2021 12:18:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A83EDC0019;
	Thu,  4 Nov 2021 12:18:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41B9BC000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D8C7400DA
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:18:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16iKvHudmEG6 for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 12:18:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E19D040015
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:18:38 +0000 (UTC)
X-UUID: 731cec951b914e8b9b791b1b4e1d014f-20211104
X-UUID: 731cec951b914e8b9b791b1b4e1d014f-20211104
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <walter-zh.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1409694579; Thu, 04 Nov 2021 20:18:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Thu, 4 Nov 2021 20:18:33 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 4 Nov 2021 20:18:33 +0800
Message-ID: <f890498e474b48f017ec763cf866f7ddd1cc40c4.camel@mediatek.com>
Subject: Re: [PATCH v2] dma-direct: improve DMA_ATTR_NO_KERNEL_MAPPING
From: Walter Wu <walter-zh.wu@mediatek.com>
To: Christoph Hellwig <hch@lst.de>
Date: Thu, 4 Nov 2021 20:18:33 +0800
In-Reply-To: <20211104085336.GA24260@lst.de>
References: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
 <20211104085336.GA24260@lst.de>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream <wsd_upstream@mediatek.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Thu, 2021-11-04 at 09:53 +0100, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 10:32:21AM +0800, Walter Wu wrote:
> > diff --git a/include/linux/set_memory.h
> > b/include/linux/set_memory.h
> > index f36be5166c19..6c7d1683339c 100644
> > --- a/include/linux/set_memory.h
> > +++ b/include/linux/set_memory.h
> > @@ -7,11 +7,16 @@
> >  
> >  #ifdef CONFIG_ARCH_HAS_SET_MEMORY
> >  #include <asm/set_memory.h>
> > +
> > +#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED
> 
> This is an arm64-specific symbol, and one that only controls a
> default.  I don't think it is suitable to key off stubs in common
> code.
> 

ok

> > +static inline int set_memory_valid(unsigned long addr, int
> > numpages, int enable) { return 0; }
> 
> Pleae avoid overly long lines.
> 
> > +		if (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED)) {
> > +			kaddr = (unsigned
> > long)phys_to_virt(dma_to_phys(dev, *dma_handle));
> 
> This can just use page_address.
> 
> > +			/* page remove kernel mapping for arm64 */
> > +			set_memory_valid(kaddr, size >> PAGE_SHIFT, 0);
> > +		}
> 
> But more importantly:  set_memory_valid only exists on arm64, this
> will break compile everywhere else.  And this API is complete crap.
> Passing kernel virtual addresses as unsigned long just sucks, and
> passing an integer argument for valid/non-valid also is a horrible
> API.
> 

Would you think __kernel_map_page() is ok?
Many arch support it, and only pass page and page number. but need to
depend CONFIG_DEBUG_PAGEALLOC.

Thanks.
Walter


> Not to mention the overly long line.  Same on the free side.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
