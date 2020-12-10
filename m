Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BF3C4361B
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 04:04:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D1F23A02
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 04:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D1F23A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E76DD85EBE;
	Thu, 10 Dec 2020 04:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 37NHXs3xqqyo; Thu, 10 Dec 2020 04:04:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 30060859E6;
	Thu, 10 Dec 2020 04:04:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 298C7C0893;
	Thu, 10 Dec 2020 04:04:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 334D6C013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 04:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1474687551
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 04:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E8AjjqXMCECF for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 04:04:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0D0628749D
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 04:04:04 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id w1so717235ejf.11
 for <iommu@lists.linux-foundation.org>; Wed, 09 Dec 2020 20:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aiXzNIBEdezK7LvwdToUmyEveX4RTWL1Q1rKEHzG6GY=;
 b=V12HS7Wn+bctaIkufygbNwtKV1pkBbE9hHZV8Lf9tSE5VPt6nBit0Nb1HWPIB+8XdO
 UwbjHDBYoCvlSOrafC5rCuQbCx1D+/3PDyFehNe398RSQzHQ1rPu9pgXYXyg3wMVKY7l
 FuBEUYEFzcobG0z1knWel86vWiyTyuA3aX6iyNBGyPUSEugrsJ77EmD5w3Zhr4gllpgD
 NDD0P3wO1Rjasg3bPJKXdNNtxJFUZzyODiRBozAcezwWwmKvGT1tnVg88ssqoLYPKQyE
 vxZa8+AdNxohhjfYmcfYxPAKri7o/zxhpGNApPEe/Ugj0ylq5uh8h/HdVnA0K5L3ljWV
 0UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aiXzNIBEdezK7LvwdToUmyEveX4RTWL1Q1rKEHzG6GY=;
 b=VXjEk54v8eFu8nHUmsQ4KJaYOxaYkTkFPynWuei6Hq3pK/cq7nfZ16ovV/hlDAB6B5
 vKo/rRnMQq38UbqptDxCH6Dcx+7OVm/KmFZ1kKion+MIcOijb/n8tvlix6IJPj7rx69p
 ccK+9rN9REaj973955KadmUCxYhbZ/1Cds47fW37HTlzoITJ6dmWBifYUNLoe5z02ZpB
 b2oIYKRMg+jIYF6fOgTm9IToml87ykug3ROl8E9t3kDH8uoW2F7Sy+0KA0jiL91pvaGP
 EeJbFg6pM5kvFahyHqYrSAKL6quMo9Du7xA+4QGpu0e0pnDqmDFmDuIsaHm4I1g3oyfE
 suKg==
X-Gm-Message-State: AOAM532441jxAzKP+E1iHN/ntcDSDyqs4nTWWMHKsBpW5FPyRJDGnJ4w
 dAEhSm6y2IPT6uaUvQB5iLa3yDZi7MUTVKXQImOpBw==
X-Google-Smtp-Source: ABdhPJz4kqsM2zajOVSAKgswV7LD/u9Of8EB4mcOSELuzl9N3rbE8Zn+Vb136NhMCEF83xMViBOj9nm8pJkMBp6g77Y=
X-Received: by 2002:a17:906:518a:: with SMTP id
 y10mr4811157ejk.323.1607573042542; 
 Wed, 09 Dec 2020 20:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-5-logang@deltatee.com>
 <20201109091258.GB28918@lst.de>
 <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
 <CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com>
 <fba1022b-1425-bb79-9af8-fe68e6f2c56e@deltatee.com>
In-Reply-To: <fba1022b-1425-bb79-9af8-fe68e6f2c56e@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 9 Dec 2020 20:04:00 -0800
Message-ID: <CAPcyv4hr=kM6--OUdK+6XAAEVzENJmy-uD78yK-p62bW8vbu9g@mail.gmail.com>
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

On Wed, Dec 9, 2020 at 6:07 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-12-09 6:22 p.m., Dan Williams wrote:
> > On Mon, Nov 9, 2020 at 8:47 AM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >>
> >>
> >> On 2020-11-09 2:12 a.m., Christoph Hellwig wrote:
> >>> On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
> >>>> We make use of the top bit of the dma_length to indicate a P2PDMA
> >>>> segment.
> >>>
> >>> I don't think "we" can.  There is nothing limiting the size of a SGL
> >>> segment.
> >>
> >> Yes, I expected this would be the unacceptable part. Any alternative ideas?
> >
> > Why is the SG_P2PDMA_FLAG needed as compared to checking the SGL
> > segment-pages for is_pci_p2pdma_page()?
>
> Because the DMA and page segments in the SGL aren't necessarily aligned...
>
> The IOMMU implementations can coalesce multiple pages into fewer DMA
> address ranges, so the page pointed to by sg->page_link may not be the
> one that corresponds to the address in sg->dma_address for a given segment.
>
> If that makes sense -- it's not the easiest thing to explain.

It does...

Did someone already grab, or did you already consider the 3rd
available bit in page_link? AFAICS only SG_CHAIN and SG_END are
reserved. However, if you have a CONFIG_64BIT dependency for
user-directed p2pdma that would seem to allow SG_P2PDMA_FLAG to be
(0x4) in page_link.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
