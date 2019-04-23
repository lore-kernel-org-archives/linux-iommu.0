Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59BFC10F14
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 11:16:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74628217D9
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 11:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSZwv/BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74628217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4A63C1016;
	Tue, 23 Apr 2019 11:16:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 846471014
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 11:16:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
	[209.85.166.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9D44B82E
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 11:16:31 +0000 (UTC)
Received: by mail-it1-f193.google.com with SMTP id e13so3640131itk.4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=mDddDEFyx868qYQMU+NLd8y62RLBKhnM110YJ+t7rgE=;
	b=uSZwv/BBFoYksCDLwSYQpDDmO61r1XBzWNz1XEhBNxWVSTqBLMsr1K6PQVhXdfA7Sh
	csOv1UJ4LZBs1VmQ15/3U+T7e2dI/asioCNOmIpLp+iHltsX1OXtLAamQ8i96GhXoB2I
	oe8S7nCX16mwgcOyKLQ9TqYpXZraDfPzacZAHbdUd64/yX1WnfD+Dp/D7rdZVfPwWQrY
	/4AoJWdr7PQa9d8PI/4vOQOi3vP7Kt08Fwd3AoU76O5gHH/JrQ5sszIxINnitgtOKqzI
	8yQEpO8kmoIdNSlWPL9MbSnkIjp7zq6flscJyEHl7VikaD8df/uVY1EKEhUmlltPf6cY
	B8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=mDddDEFyx868qYQMU+NLd8y62RLBKhnM110YJ+t7rgE=;
	b=R+4k9QuDyKrojks+3ljEwEq+MxS9xwLesRuI6m7WskVVpMyKjbpqp+r+4hRyI4wGxq
	F+y3sCouonzOo3sRbF5+Sg23crUbLkxyeDjfc57HubvgL6zhADmzSyQzEnzx3PFpPtHl
	IrBXNt5oFXvXbp66lN4h1ELpC0XVoD5dT/zsbxHFicgSxtw94KclirfSXaBcd0BkK8b9
	pZHzSbC9rhffzvod1MrzTVTbMz0UB1qBMu26vqA0i7p6yZGXfKc14E1Ig9orqNzb2JNu
	An+IiaGf57kuTLnk2yBL0r4slGc2jNLtIPwnl+o9yzaI+PJpIJJ8Iu1DIe5c/WhTrf/i
	7KQw==
X-Gm-Message-State: APjAAAWi0CNu62kauM+ab3FIkk9FUO1h8+6RCLXK8bJb1aYFsLl2fbXl
	lwDxdQtWzr1wzXFZWvxr/e8cbYXqmLs6b215oPQ9PA==
X-Google-Smtp-Source: APXvYqyZLJQ2lAZMUR1Kvlscipudkp0AUkQIT2gBYuIMUAkZki5oyQezsgAw87+7hLYAcprER+aozpjBP72Ib2VXLhA=
X-Received: by 2002:a24:1312:: with SMTP id 18mr1366425itz.121.1556018190857; 
	Tue, 23 Apr 2019 04:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190422071036.32671-1-vivek.gautam@codeaurora.org>
	<149dee19-e2eb-0b27-3df0-c99a05e8bea1@arm.com>
In-Reply-To: <149dee19-e2eb-0b27-3df0-c99a05e8bea1@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 23 Apr 2019 13:16:18 +0200
Message-ID:
 <CAKv+Gu-W4x-8Aha6vV6xjfmkt1X+Yhb_hjxXTsqdUyCpb4XHHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu: Log CBFRSYNRA register on context
	fault
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423111618.Q0df64wd1A7tC1llJ3YxgnpRY814NTc9XyNsUzBKSBQ@z>

On Tue, 23 Apr 2019 at 13:13, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 22/04/2019 08:10, Vivek Gautam wrote:
> > Bits[15:0] in CBFRSYNRA register contain information about
> > StreamID of the incoming transaction that generated the
> > fault. Dump CBFRSYNRA register to get this info.
> > This is specially useful in a distributed SMMU architecture
> > where multiple masters are connected to the SMMU.
> > SID information helps to quickly identify the faulting
> > master device.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v1:
> >   - Addressed review comments, given by Bjorn, for nits.
> >
> >   drivers/iommu/arm-smmu-regs.h | 2 ++
> >   drivers/iommu/arm-smmu.c      | 7 +++++--
> >   2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> > index a1226e4ab5f8..e9132a926761 100644
> > --- a/drivers/iommu/arm-smmu-regs.h
> > +++ b/drivers/iommu/arm-smmu-regs.h
> > @@ -147,6 +147,8 @@ enum arm_smmu_s2cr_privcfg {
> >   #define CBAR_IRPTNDX_SHIFT          24
> >   #define CBAR_IRPTNDX_MASK           0xff
> >
> > +#define ARM_SMMU_GR1_CBFRSYNRA(n)    (0x400 + ((n) << 2))
> > +
> >   #define ARM_SMMU_GR1_CBA2R(n)               (0x800 + ((n) << 2))
> >   #define CBA2R_RW64_32BIT            (0 << 0)
> >   #define CBA2R_RW64_64BIT            (1 << 0)
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 045d93884164..e000473f8205 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -575,7 +575,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> >       struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +     void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
> >       void __iomem *cb_base;
> > +     u32 cbfrsynra;
>
> Nit: I would simply add to the existing "u32 fsr, fsynr;" declaration,
> but that's the sort of thing that could hopefully be fixed up when
> applying (or otherwise I might bulldoze it anyway in my eventual rework
> of register accesses throughout the driver). Regardless,
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> >       cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
> >       fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
> > @@ -585,10 +587,11 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >
> >       fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
> >       iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
> > +     cbfrsynra = readl_relaxed(gr1_base + ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
> >
> >       dev_err_ratelimited(smmu->dev,
> > -     "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> > -                         fsr, iova, fsynr, cfg->cbndx);
> > +     "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> > +                         fsr, iova, fsynr, cbfrsynra, cfg->cbndx);
> >
> >       writel(fsr, cb_base + ARM_SMMU_CB_FSR);
> >       return IRQ_HANDLED;
> >
>

This is something I've had to hack up locally in the past, so

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
