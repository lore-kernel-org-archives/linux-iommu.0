Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA2DC43461
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 18:55:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08A361363
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 18:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08A361363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7325C6061F;
	Tue, 11 May 2021 18:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uZyAnN6N1gcV; Tue, 11 May 2021 18:55:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B440605A7;
	Tue, 11 May 2021 18:55:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07AFCC000E;
	Tue, 11 May 2021 18:55:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47B61C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 18:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D35082D49
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 18:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cu9WYkp0ATxj for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 18:55:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEE0B82D45
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 18:55:53 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id t18so21181274wry.1
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Zs2w1HOP/qUoGoZPFD129RRQnAW6mhOM8nlH2tVXXm0=;
 b=U9VKy9xefUTo0JPaWnmt30KRBSx0FFWjTyU5ynccfCcKLBvhVjyiGw1DKfuVNALdpO
 ylLstzc11KlvCRQC28txPn0l2ENDMcUk84uNYCVYz13fFW57tz0ro3bpcm4MavuqPhdQ
 67khLKO4CWEEbLV8Mq1MlUx4VIzMwAgdFx3xgPVJn3CAGq7nZUb1J8WeZxoGiQRAtcPd
 557lg5tlghwF7DDzCYbKR+WAJlbgMUWEK5hn93p2AzO9qSsYMAO3vH25Tnwh/5x+pW3P
 c0rRBNDJn6xtBfJsuSbSCGaaylw4Adx8CvLc4cccqnl+YgTpJRFHpFDIMQ4247mZsMO0
 4+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Zs2w1HOP/qUoGoZPFD129RRQnAW6mhOM8nlH2tVXXm0=;
 b=hsAkQerKbmmvkIIsp8R4L/dMEuyfGXM3+9fMN8PWT8QODK9vxTuZ39tgj9drMKUm4y
 qOyUeSRhco43qMFQent/DsNr8u2xF5kGp024aaY8SUXV12J80M6HqiSjIHrLTRe0twWt
 7gl/EizTm6YYWdXOg7d+/SFdbGqHSFXwX3iX3GnkwEK+XlOrLEpUFwUlTo9+KduWEFw4
 FFGPgZIuBWDwUyfHo4vp6p1NRqoeX+U7uDKqRcreQiJt7w5EtvhfzgoMKVNBUJ0w3JLR
 m12WEL08rSGcUPdyUMXzjswr7W8AKpqaYTq+aMaN1ewmPyy7/6BDFPbqSf9hc43Q9QMg
 hcaQ==
X-Gm-Message-State: AOAM533EyUowQerIAsQSSjw6DNQy3MV/JzLOuugcfIsNui3vvBlWQJ+H
 8TeGjQZAp1061+88V3bSSpFWcnIBs52lBXfFUM4=
X-Google-Smtp-Source: ABdhPJyakjIL56t5dhmPl//cGax6lJy/o0FLjV2gh72JwcB7alCTdlfruKiiPv6bYQhv49TrcFtQmAilkW7Onv68xVM=
X-Received: by 2002:adf:f74d:: with SMTP id z13mr39583073wrp.147.1620759351799; 
 Tue, 11 May 2021 11:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210225175135.91922-1-jcrouse@codeaurora.org>
 <20210225175135.91922-2-jcrouse@codeaurora.org>
 <2d3c7595-0186-7231-96dc-ae52414480ee@arm.com>
 <20210302155423.3e7xlal3phcz26bh@cosmicpenguin.net>
In-Reply-To: <20210302155423.3e7xlal3phcz26bh@cosmicpenguin.net>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 11 May 2021 11:59:33 -0700
Message-ID: <CAF6AEGsCbYDsLLPdVdJHdQbd9xrO==UMWMQVkwhuG8gdp3gd+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iommu/arm-smmu: Add support for driver IOMMU fault
 handlers
To: Robin Murphy <robin.murphy@arm.com>, Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, 
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Tue, Mar 2, 2021 at 7:54 AM Jordan Crouse <jordan@cosmicpenguin.net> wrote:
>
> On Tue, Mar 02, 2021 at 12:17:24PM +0000, Robin Murphy wrote:
> > On 2021-02-25 17:51, Jordan Crouse wrote:
> > > Call report_iommu_fault() to allow upper-level drivers to register their
> > > own fault handlers.
> > >
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >
> > >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > index d8c6bfde6a61..0f3a9b5f3284 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > @@ -408,6 +408,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> > >     struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > >     struct arm_smmu_device *smmu = smmu_domain->smmu;
> > >     int idx = smmu_domain->cfg.cbndx;
> > > +   int ret;
> > >     fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> > >     if (!(fsr & ARM_SMMU_FSR_FAULT))
> > > @@ -417,8 +418,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> > >     iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> > >     cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
> > > -   dev_err_ratelimited(smmu->dev,
> > > -   "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> > > +   ret = report_iommu_fault(domain, dev, iova,
> >
> > Beware that "dev" here is not a struct device, so this isn't right. I'm not
> > entirely sure what we *should* be passing here, since we can't easily
> > attribute a context fault to a specific client device, and passing the IOMMU
> > device seems a bit dubious too, so maybe just NULL?
>
> Agreed. The GPU doesn't use it and I doubt anything else would either since the
> SMMU device is opaque to the leaf driver.

Looks like other iommu drivers use a fun mix of attached device (for
ones that can make assumptions about one device per domain) and the
iommu dev ptr.. probably NULL is the right answer..

BR,
-R

> Jordan
>
> > Robin.
> >
> > > +           fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> > > +
> > > +   if (ret == -ENOSYS)
> > > +           dev_err_ratelimited(smmu->dev,
> > > +           "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> > >                         fsr, iova, fsynr, cbfrsynra, idx);
> > >     arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> > >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
