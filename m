Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E67FC433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 01:22:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C172B23B1F
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 01:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C172B23B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2EB2C20466;
	Thu, 10 Dec 2020 01:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HxtT2nxW9u3t; Thu, 10 Dec 2020 01:22:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A51D42041D;
	Thu, 10 Dec 2020 01:22:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86DC2C0893;
	Thu, 10 Dec 2020 01:22:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B5CEC013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 01:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 55AD687947
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 01:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ua2pjsKsRq55 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 01:22:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 689208733A
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 01:22:12 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id x16so4978065ejj.7
 for <iommu@lists.linux-foundation.org>; Wed, 09 Dec 2020 17:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1RvR2QPPiPyu+6Jv4jWyGokFplcRpCGGMGXA++YNtNY=;
 b=hLlhVWiZHkRszGDN0QvNv3k5cDa7NBwZGJhnG+u6snpj/DqWm97HsIYwTJsnjvT1vM
 lqLgTToh0Yl0+7UdLKf0OJc3R9/7th3uREf05mUHcpVQ/dGI9wmQMaG7b8tJQr7VzCU6
 n7TG/Q+F4n+X2SsRVoAlKSheAcmCFeTxkrOIXFDWuvtQdZWTf7ANt2zcUkpZxBGmjkXa
 wO9mFNtjhCJhXDZ9MpC+XSEcdnWG+j3g1YG8jxS+Jo15C0UFtAA2umrf/tujow1hZuMc
 f9OtadNZ60HDDPjDjL1evB3x/w7Ymxm2RXqqrVLk5LCk3Du/muGWXQQZ7gJkcfcPQvRI
 RABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1RvR2QPPiPyu+6Jv4jWyGokFplcRpCGGMGXA++YNtNY=;
 b=iqbZdvlBPq7stck5cDHAlYp5LLMMPWhYJelh6chro9Z/peEU4t/Ufy0a/vc8rbFY9J
 AwV5Etr7ZKZzpnBww3bIa0f8/1AdSbMTgioKQMuBaa7hfWwRuHgYaBFE6yd34QrzVDO7
 zDJTeLTenOwZzt6EJBvsmsZQiqBtXQKfVorkA0P+0XIhCXw2OH3vqk9NvCn43XiiqPYW
 Q/MaRnUFTaWwoRai8sR8g2C7wDZaUo8HecW7FUGjhdGyx0Ubl8sDhBVXO0odLGVWIq6U
 FbjV63NlIApiQsiv3ZNMP4ABM8SNsoPsa0dRd1HY1u7P6lRWgok90Sw6Xiy9RbMRCn/T
 DG6g==
X-Gm-Message-State: AOAM531FtvJAVDz3yp5Uc4JW5J0UK2Sqre8EyCPdABKoKZuDV7wzSlCJ
 n+UxhlMXQkiPazgDOBnVNmYOuXs6E/acDW7ZDYj2TQ==
X-Google-Smtp-Source: ABdhPJyAwcrv2J7//UeT/BRlFkXF6BfuHfPDxCDsLChk0w8jJb7pNGsjyGRaIu9jO63Jp7V2CJR6QsUNyeoJndfV6A8=
X-Received: by 2002:a17:906:a29a:: with SMTP id
 i26mr4331316ejz.45.1607563330752; 
 Wed, 09 Dec 2020 17:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-5-logang@deltatee.com>
 <20201109091258.GB28918@lst.de>
 <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
In-Reply-To: <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 9 Dec 2020 17:22:09 -0800
Message-ID: <CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Linux PCI <linux-pci@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Ira Weiny <iweiny@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, John Hubbard <jhubbard@nvidia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>
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

On Mon, Nov 9, 2020 at 8:47 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-11-09 2:12 a.m., Christoph Hellwig wrote:
> > On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
> >> We make use of the top bit of the dma_length to indicate a P2PDMA
> >> segment.
> >
> > I don't think "we" can.  There is nothing limiting the size of a SGL
> > segment.
>
> Yes, I expected this would be the unacceptable part. Any alternative ideas?

Why is the SG_P2PDMA_FLAG needed as compared to checking the SGL
segment-pages for is_pci_p2pdma_page()?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
