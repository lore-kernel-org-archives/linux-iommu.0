Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EE9C433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 19:36:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F2964E50
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 19:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F2964E50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C2DB85B8D;
	Mon,  1 Feb 2021 19:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MS5WKUXE5hdO; Mon,  1 Feb 2021 19:36:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A35C18589A;
	Mon,  1 Feb 2021 19:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 997D7C0FA7;
	Mon,  1 Feb 2021 19:36:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A401CC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 19:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7A9DB2052E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 19:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lQUJnZFSnb4X for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 19:36:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by silver.osuosl.org (Postfix) with ESMTPS id 932A91FEDF
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 19:36:05 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id n42so17468088ota.12
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 11:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JWBkNAaNFyDailoNLvfd01F/RWQlC5hp7A6f+h/cyqY=;
 b=TZxvbVNiXKihvb482TRxj/6WLckWUH8R84HUFz+GyZcJj4bDdqokogc8XZdjFuz66J
 B5QIJRO4vCDoGUNuyOgOqgmW4qpUurcYdQlvQjwMAo1AQsqhPVzf3x57z1YVHxjLLjMw
 BBPPaSfpe8ATUSfRZboIsbLfkbp2hi++WS0OCvjShV6qCf3THh8G2i3/vW4NTkCUBy83
 qtF4MRc/5EkX8POcuGFwClV2jvLeIQ/dCU/onWhEa3tZJ/1pr/lwn/AauK+RlpCaSDdu
 vD0tFxi8yEzu4n2K4AQ2p2GH3p6j7qrx3lQADHKCizJNfZatHNzTyRm4avKI55+xUqZn
 kkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JWBkNAaNFyDailoNLvfd01F/RWQlC5hp7A6f+h/cyqY=;
 b=kpWwMagCWVSrYhiAw1LPwwETSDYsPIaHKkRR0DmtKX6CNZcfl8bHE5hau4AarVl32N
 Y9Dii3hS7qQl7ne98X4wL3ac00naiVGciVDWtIOO2o77ycKI4GtQ7fwJxOk6PEodT9jj
 bFY3ELtI5YO3fikDaPvIMxvVGCeJs/4DrRI3xLSlEhk/khuHoMJYr7yD7E/XknTXdoF9
 EnAhBzdJ/IDAFQdrRiqtF5HdQ1jFxrVJTQCRRR2aiO6RYMzTWltXfrY9FwlWITLkxP+I
 dlX1eYHLWO1KP/V45OkWI5XtXQJVFZeHjMLcFq1NAk3IOUk9qWoiQCl1uPGLGsfPnUro
 vCPQ==
X-Gm-Message-State: AOAM530ag45XrkeLahtP12h1dC+Cit8/T/uXgZO0uluxT2xEYOOJyiIg
 SMfSbsDyEEA1J7RCuaccJ1k/KIbW4IVoMyTA7IRnIA==
X-Google-Smtp-Source: ABdhPJzyuAUli/LaOAe8RusYWEo21XH5hUPI02qphfk+PAI/Wvf6MAfQb2fhO5ryBBYE9EV4k+dZ9B02fM5dWCkJKOo=
X-Received: by 2002:a9d:7d12:: with SMTP id v18mr12655165otn.205.1612208164558; 
 Mon, 01 Feb 2021 11:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <YBhOrK+kea7PNmXn@smile.fi.intel.com>
In-Reply-To: <YBhOrK+kea7PNmXn@smile.fi.intel.com>
Date: Mon, 1 Feb 2021 11:35:52 -0800
Message-ID: <CAMGD6P0qc0FZagmimTCuYsbJXo-WBHjtgoWSRzs63EULybTzNg@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, jroedel@suse.de, dan.j.williams@intel.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Feb 1, 2021 at 10:56 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 01, 2021 at 10:30:17AM -0800, Jianxiong Gao wrote:
> > NVMe driver relies on the address offset to function properly.
> > This patch adds the offset preserve mask to NVMe driver when mapping
> > via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
> > depends on the page size defined by CC.MPS register of NVMe
> > controller.
>
> ...
>
> >       if (is_pci_p2pdma_page(sg_page(iod->sg)))
> >               nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
> >                               iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
> >       else
> >               nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
> >                                            rq_dma_dir(req), DMA_ATTR_NO_WARN);
> > +
> > +     offset_ret = dma_set_min_align_mask(dev->dev, 0);
> > +     if (offset_ret) {
> > +             dev_warn(dev->dev, "dma_set_min_align_mask failed to reset offset\n");
> > +             goto out_free_sg;
> > +     }
>
> Seems like rebasing effect which makes empty line goes in the middle of some
> other group of code lines.
>
> >       if (!nr_mapped)
> >               goto out_free_sg;
>
> Perhaps it should be here?
Yes you are correct, it should be

     else
              nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
                                           rq_dma_dir(req), DMA_ATTR_NO_WARN);
      if (!nr_mapped)
              goto out_free_sg;
+
+     offset_ret = dma_set_min_align_mask(dev->dev, 0);
+     if (offset_ret) {
+             dev_warn(dev->dev, "dma_set_min_align_mask failed to
reset offset\n");
+             goto out_free_sg;
+     }

Thanks for pointing it out.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


-- 
Jianxiong Gao
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
