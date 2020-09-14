Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794AEC433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 07:11:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D096C2192A
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 07:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X55de4su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D096C2192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6BF8086F81;
	Mon, 14 Sep 2020 07:11:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sf83QBpCKszH; Mon, 14 Sep 2020 07:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DF41086E48;
	Mon, 14 Sep 2020 07:11:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE933C0859;
	Mon, 14 Sep 2020 07:11:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4566AC0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 07:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3AC1E86E64
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 07:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bUCnLvKDTP3Z for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 07:11:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 539F886E48
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 07:11:23 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id c18so17413008wrm.9
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zCeerB1JSj7Ad5/NePzzCyRJn16Be5wrFWWH1CWiDP0=;
 b=X55de4su8ACUlJzml7jbOdk740UeBZL1QwYX0385QEl8yyFdpcIvMBswozXI9Iwi5d
 KjGu3pvIc/WJcfXlGJT3CCBr1yU4aa2EKuwMrNk2rw0TaoYVpguYEZkjcxyC+HxICaqj
 fPaATeZl5KF7sn+32WoC+XjDF0l4B0XagqZDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zCeerB1JSj7Ad5/NePzzCyRJn16Be5wrFWWH1CWiDP0=;
 b=L/HIYRi2UMXXSQ8DyFF4ezuw9tIm7KkA2vB5n+EQzqRjFyHEd71bxsjuhaEaQdd6sC
 j/Kv0fNpLO1KSbOYMjL6lWGsLvWo3TjTCTQaaoFvNPJIs7EOXnH2K1bTrhGMkpRJd7Z8
 CTn3uTk7BJMjfWUnknm7JiNjJ7YcFV8Ye9UeJe6A9sgrHXY0/ZKdldnikGq3b0eh7Vih
 srO2vo3tZa9xe/KFJULdypPxFJBfBKF0a8Cc0Mdpf9h9U/U8uCq8+jSrRqgC8LSIRKIV
 zjtaLnFpZNYGJwxvZ61WO9d6H0DqttpwHTPI3UtjLXlMPL6rpGmij0L9hzmMCLu9jS9L
 jmxQ==
X-Gm-Message-State: AOAM531oadCnPORzPN59jtMFkIKwTykGq5SAM9ptqEaXJVwvpNjMY/wr
 MMJTmrH2gJW3Hm9tpeEu9sUscT9OROUCY5s5Dr3Rxw==
X-Google-Smtp-Source: ABdhPJx1POr9ptHGzWWSxkqesqTMHmNyfnUZTuDp4ZxAnJYirIn+uphhC/pcSaZjMrvjb+RpqSRrO0hwrCGElxPN/YY=
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr14188706wrt.366.1600067481657; 
 Mon, 14 Sep 2020 00:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200911102534.25218-1-srinath.mannam@broadcom.com>
 <20200911151659.GA868760@bjorn-Precision-5520>
In-Reply-To: <20200911151659.GA868760@bjorn-Precision-5520>
Date: Mon, 14 Sep 2020 12:41:10 +0530
Message-ID: <CABe79T7sdW7GBhNR=VQ9kXY1JOOimY3wsQZ0xxTbN9rz2j5z5w@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/dma: Fix IOVA reserve dma ranges
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: poza@codeaurora.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
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
From: Srinath Mannam via iommu <iommu@lists.linux-foundation.org>
Reply-To: Srinath Mannam <srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Sep 11, 2020 at 8:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
Hi Bjorn,
Thanks for review.
> On Fri, Sep 11, 2020 at 03:55:34PM +0530, Srinath Mannam wrote:
> > Fix IOVA reserve failure in the case when address of first memory region
> > listed in dma-ranges is equal to 0x0.
> >
> > Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > ---
> > Changes from v1:
> >    Removed unnecessary changes based on Robin's review comments.
> >
> >  drivers/iommu/dma-iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 5141d49a046b..682068a9aae7 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -217,7 +217,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
> >                       lo = iova_pfn(iovad, start);
> >                       hi = iova_pfn(iovad, end);
> >                       reserve_iova(iovad, lo, hi);
> > -             } else {
> > +             } else if (end < start) {
> >                       /* dma_ranges list should be sorted */
> >                       dev_err(&dev->dev, "Failed to reserve IOVA\n");
>
It is very unlikely to come to this error, dma_ranges list is sorted
in "devm_of_pci_get_host_bridge_resources" function.
> You didn't actually change the error message, but the message would be
> way more useful if it included the IOVA address range, e.g., the
> format used in pci_register_host_bridge():
>
>   bus address [%#010llx-%#010llx]
I will add this change and send the next patchset.

Thanks & Regards,
Srinath.
>
> Incidentally, the pr_err() in copy_reserved_iova() looks bogus; it
> prints iova->pfn_low twice, when it should probably print the base and
> size or (my preference) something like the above:
>
>         pr_err("Reserve iova range %lx@%lx failed\n",
>                iova->pfn_lo, iova->pfn_lo);
>
> >                       return -EINVAL;
> > --
> > 2.17.1
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
