Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7778EC433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Dec 2021 17:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ECEA408BF;
	Thu, 23 Dec 2021 17:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EmFndC4eCG0x; Thu, 23 Dec 2021 17:37:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1942240284;
	Thu, 23 Dec 2021 17:37:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3B7BC002F;
	Thu, 23 Dec 2021 17:37:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A105C0012
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 17:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49663408BF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 17:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SVUr3NnbjOhu for <iommu@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 17:37:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90BAE40284
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 17:37:23 +0000 (UTC)
Received: by mail-yb1-xb2f.google.com with SMTP id g17so18453921ybe.13
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KUeVodc32xriSm1pts3x5c9nn/1tURjzxfW/sn365PQ=;
 b=pUhYAX/xZmgCQH10337pELpQwQeqYlsrNaSrJZpIiPKfCv2VZngQDBpaelUOctwRmA
 fMtJpgbEovFrAn7Ot6fv6ujwLBpifVJ0C1ZyGGOJ7Y2hK45Xd8pBWRfEw2JT+3+j968v
 4YT3bxpFsoPhvoXKxbJC2lUrlk7KHXCfeKJoJbwhefbBm8KFrX6TjECv/N5vHTj06nde
 wYDllw8uCKfuPCElnv+gNk2zP94g2ne/LlvxK68l/xdu2a/inS2gCaSJ9slb5vToqOwQ
 16OeASno9PbnY4U2kcO36hCGwtJUCuXAn6WH05Wa9Ciunc7FLb37OPNQ7wfUnB1GvJDj
 5Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KUeVodc32xriSm1pts3x5c9nn/1tURjzxfW/sn365PQ=;
 b=d9cpeZQLjDFyuTBt8n0nLUh4g16Xvn8wj+Uo6m5ENhtDzVhVTZP884tJQWAPPvnHkV
 ktx8Mw384Gn6GpMiIFxGsDRzmyymNBX6TbDv772k/AvW0QXTfmInwBlNnqRCasOqM8xx
 WkKPbIFrnwX1ksmqFfqrWoD0F9Ez3b46xEvQUsTzQMaq99IDB/f8JrY7ZY2mWcGYqBEo
 Rqsj6Q54xLLvZHMC3MFeq2JxEWcXE7Q3M5TMXHKbteQuv+y+iyCJgaRQwVmmKevDftUA
 HdgJptB9xbRsSi2PZuHX3E/iehSrc008kPOse+ZbdA9yc2aQljztKqGV9zOPggIICJxR
 gQBw==
X-Gm-Message-State: AOAM531lbPcr1Q0orf9xoDBw2hFXKhf4OG+QJQE6zDGdabpmps99CKb0
 FJ5wqj/nakJIBziktZHIY/ak0p6+hJ+svZEJyDU=
X-Google-Smtp-Source: ABdhPJwGp0CD0g7j0WHniWa/we1JWICoA+6kOxGAF1A+2M8FxbUKy01MKjP6qea2hb9gkJFTI8naq162/Tn1tOLAmVc=
X-Received: by 2002:a25:98c4:: with SMTP id m4mr4574126ybo.613.1640281042468; 
 Thu, 23 Dec 2021 09:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
In-Reply-To: <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 23 Dec 2021 17:36:56 +0000
Message-ID: <CA+V-a8vqpX=z9a+s=pgCY07EE6=uhdtq_NJOr+8VoGZ21kUmLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu: Use platform_irq_count() to get the
 interrupt count
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Clark <robdclark@chromium.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>, Xin Tan <tanxin.ctf@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>
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

Hi Robin,

Thank you for the review.

On Thu, Dec 23, 2021 at 2:14 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-12-23 13:00, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_count().
>
> Nit: platform_irq_count()
>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 4bc75c4ce402..4844cd075644 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -2105,12 +2105,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >       if (IS_ERR(smmu))
> >               return PTR_ERR(smmu);
> >
> > -     num_irqs = 0;
> > -     while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
> > -             num_irqs++;
> > -             if (num_irqs > smmu->num_global_irqs)
> > -                     smmu->num_context_irqs++;
> > -     }
> > +     num_irqs = platform_irq_count(pdev);
> > +     if (num_irqs < 0)
> > +             return num_irqs;
> > +
> > +     if (num_irqs > smmu->num_global_irqs)
> > +             smmu->num_context_irqs += (num_irqs - smmu->num_global_irqs);
>
> This seems a bit overcomplicated. I reckon:
>
>         smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
>         if (num_irqs <= smmu->num_global_irqs) {
>                 dev_err(...
>
> should do it.
>
Agreed.

> However, FYI I have some patches refactoring most of the IRQ stuff here
> that I plan to post next cycle (didn't quite have time to get them done
> for 5.17 as I'd hoped...), so unless this needs to go in right now as an
> urgent fix, I'm happy to take care of removing platform_get_resource()
> as part of that if it's easier.
>
Fine by me, let me know if it gets any later than planned I'll send a v2.

Cheers,
Prabhakar
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
