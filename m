Return-Path: <SRS0=os8Q=PV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5552C433F5
	for <iommu@archiver.kernel.org>; Tue,  2 Nov 2021 07:26:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA6660F02
	for <iommu@archiver.kernel.org>; Tue,  2 Nov 2021 07:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BA6660F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6165380C6D;
	Tue,  2 Nov 2021 07:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HsehJ5pKb4hP; Tue,  2 Nov 2021 07:26:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6155D80C15;
	Tue,  2 Nov 2021 07:26:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 347A4C0012;
	Tue,  2 Nov 2021 07:26:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BCF5C000E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Nov 2021 07:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0EEF80C5A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Nov 2021 07:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sXWgX1LTYiAl for <iommu@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:26:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 09F9080C15
 for <iommu@lists.linux-foundation.org>; Tue,  2 Nov 2021 07:26:17 +0000 (UTC)
X-UUID: e7445f08e2964818a4e40bd383f7fff4-20211102
X-UUID: e7445f08e2964818a4e40bd383f7fff4-20211102
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <walter-zh.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1610379575; Tue, 02 Nov 2021 15:26:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 2 Nov 2021 15:26:12 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 2 Nov 2021 15:26:12 +0800
Message-ID: <c5036587af69e70a60f6187048be1991bb2d7e7b.camel@mediatek.com>
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
From: Walter Wu <walter-zh.wu@mediatek.com>
To: Christoph Hellwig <hch@lst.de>
Date: Tue, 2 Nov 2021 15:26:12 +0800
In-Reply-To: <20211102064155.GA27749@lst.de>
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
 <20211102064155.GA27749@lst.de>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream <wsd_upstream@mediatek.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Hi Christoph,

I am sorry, fix my typo.


Walter

On Tue, 2021-11-02 at 07:41 +0100, Christoph Hellwig wrote:
> As others pointed out, DMA_ATTR_NO_KERNEL_MAPPING just means the
> caller can't rely on a kernel mapping.  So the "fix" here is
> wrong.  That being said for cases where we can easily remove a page
> from the kernel mapping it would be nice to do to:
> 
>  a) improve security
>  b) as a debug check to see that no one actually tries to access it
> 
> > +		/* remove kernel mapping for pages */
> > +		set_memory_valid((unsigned
> > long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
> 
> Please avoid overly long lines.  Also this function only exists for
> arm64
> also and others pointed out won't work for all cases.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
