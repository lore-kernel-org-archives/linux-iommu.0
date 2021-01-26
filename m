Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836DDC433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 16:03:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2B8221EC
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 16:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2B8221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 10D872045B;
	Tue, 26 Jan 2021 16:03:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kjFOMNMviVwd; Tue, 26 Jan 2021 16:02:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6406120459;
	Tue, 26 Jan 2021 16:02:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48FF2C08A1;
	Tue, 26 Jan 2021 16:02:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9918C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 16:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A5652045B
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 16:02:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X7yYkRAdaBgc for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 16:02:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by silver.osuosl.org (Postfix) with ESMTPS id E97C220459
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 16:02:53 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id a1so17035108wrq.6
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 08:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aFlkAZerFpubxAazxTKAQZiW3bP9g1vSTNyeVcwXgCE=;
 b=aBw/JDFrBqZFKzZalG1z+Wb4/+GgcVhr54M6uiiMeHFwIJXxlGmcEGPJnj6HRbHp9C
 zNqOuhijks7nnjWG6pF47YRh9kAwruR5/e27KtkTBwWhE9iePzD8OXy94OwEdaGH4VzP
 70byPjqbRRMme2c1dgi3ddgLyRjoGxIqNEl+qlls2IDVhgs/6J+9xNsox7gc+IqFsCai
 tSNnuxp4TmyJ3Sv8k7s0PKSIhGLe1azsxVDdgTqg5OnUxEWWT4/wZZAR61X3vW6u7lD2
 x+DCP5UJd5BJd55BZBdjeVw4CwsiWHK6OL7jP+9iyghthfZzI5sOJb1tqasDkykOjqIw
 ckLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aFlkAZerFpubxAazxTKAQZiW3bP9g1vSTNyeVcwXgCE=;
 b=NfAwSSuBAT1rPnWp/vpR89K2xVsqQDVUO0QMzjU4w2JylCzmvQCVf3JS5SmrkYSBya
 TuIk3QfkMHdeuZQOusgZ+NYGOuoq7rprwnkPBAO0PZLwVYLMXYkhjAgZa+0BpAuiIuUk
 4OQ7LqA4tFhgHPcdXwnsHdkM6oYLi12k9NkkMNrFb8MVoc4NH4hVVknssiQp9YCkk3Mi
 2dV4dzJxTPea4tFRkz8W7Na9JamKtpI6Ftma0gZMziptCZyf83JMwNilaVuixPkQJ07Z
 n8733QeMdJpiz2La4cigjJLvIvVtQVmQznZAWhJnbkqu1LaIEzk/I5i+NzIPPyoQL+6B
 JroQ==
X-Gm-Message-State: AOAM532g19lwTbdbMUfs5BLW7dvkynGPOLZ+KnLDo950aQiNBf+DfO/k
 H4IWRnj2w7+JIzOlhhTenRilkhnFAu+b6wCxBuo=
X-Google-Smtp-Source: ABdhPJyFUDHBfbCHody9k+wZ4aFvotJCowWDiLs9lQv0qzCYaPV/BTpIS5La53v3bCrhePCsoAkHsSRmcBPQzE+OeII=
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr1812596wrq.132.1611676972399; 
 Tue, 26 Jan 2021 08:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20201124191600.2051751-1-jcrouse@codeaurora.org>
 <20201124191600.2051751-2-jcrouse@codeaurora.org>
 <20210122124125.GA24102@willie-the-truck>
 <8ba2f53d-abbf-af7f-07f6-48ad7f383a37@arm.com>
 <20210125215107.GB16374@jcrouse1-lnx.qualcomm.com>
 <dc035204-ade7-03ec-0b82-2ecedc856d42@arm.com>
In-Reply-To: <dc035204-ade7-03ec-0b82-2ecedc856d42@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 26 Jan 2021 08:05:26 -0800
Message-ID: <CAF6AEGtfm=vO6s3vQLNotz=spM9EdXbuNi_vfmCqVd7DmyEMCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iommu/arm-smmu: Add support for driver IOMMU fault
 handlers
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>,
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

On Tue, Jan 26, 2021 at 3:41 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-01-25 21:51, Jordan Crouse wrote:
> > On Fri, Jan 22, 2021 at 12:53:17PM +0000, Robin Murphy wrote:
> >> On 2021-01-22 12:41, Will Deacon wrote:
> >>> On Tue, Nov 24, 2020 at 12:15:58PM -0700, Jordan Crouse wrote:
> >>>> Call report_iommu_fault() to allow upper-level drivers to register their
> >>>> own fault handlers.
> >>>>
> >>>> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> >>>> ---
> >>>>
> >>>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 16 +++++++++++++---
> >>>>   1 file changed, 13 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>>> index 0f28a8614da3..7fd18bbda8f5 100644
> >>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>>> @@ -427,6 +427,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >>>>    struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >>>>    struct arm_smmu_device *smmu = smmu_domain->smmu;
> >>>>    int idx = smmu_domain->cfg.cbndx;
> >>>> +  int ret;
> >>>>    fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> >>>>    if (!(fsr & ARM_SMMU_FSR_FAULT))
> >>>> @@ -436,11 +437,20 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >>>>    iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> >>>>    cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
> >>>> -  dev_err_ratelimited(smmu->dev,
> >>>> -  "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> >>>> +  ret = report_iommu_fault(domain, dev, iova,
> >>>> +          fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> >>>> +
> >>>> +  if (ret == -ENOSYS)
> >>>> +          dev_err_ratelimited(smmu->dev,
> >>>> +          "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> >>>>                        fsr, iova, fsynr, cbfrsynra, idx);
> >>>> -  arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> >>>> +  /*
> >>>> +   * If the iommu fault returns an error (except -ENOSYS) then assume that
> >>>> +   * they will handle resuming on their own
> >>>> +   */
> >>>> +  if (!ret || ret == -ENOSYS)
> >>>> +          arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> >>>
> >>> Hmm, I don't grok this part. If the fault handler returned an error and
> >>> we don't clear the FSR, won't we just re-take the irq immediately?
> >>
> >> If we don't touch the FSR at all, yes. Even if we clear the fault indicator
> >> bits, the interrupt *might* remain asserted until a stalled transaction is
> >> actually resolved - that's that lovely IMP-DEF corner.
> >>
> >> Robin.
> >>
> >
> > This is for stall-on-fault. The idea is that if the developer chooses to do so
> > we would stall the GPU after a fault long enough to take a picture of it with
> > devcoredump and then release the FSR. Since we can't take the devcoredump from
> > the interrupt handler we schedule it in a worker and then return an error
> > to let the main handler know that we'll come back around clear the FSR later
> > when we are done.
>
> Sure, but clearing FSR is not writing to RESUME to resolve the stalled
> transaction(s). You can already snarf the FSR contents from your
> report_iommu_fault() handler if you want to, so either way I don't see
> what's gained by not clearing it as expected at the point where we've
> handled the *interrupt*, even if it will take longer to decide what to
> do with the underlying *fault* that it signalled. I'm particularly not
> keen on having unusual behaviour in the core interrupt handling which
> callers may unwittingly trigger, for the sake of one
> very-very-driver-specific flow having a slightly richer debugging
> experience.

Tbf, "slightly" is an understatement.. it is a big enough improvement
that I've hacked up deferred resume several times to debug various
issues. ;-)

(Which is always a bit of a PITA because of things moving around in
arm-smmu as well as the drm side of things.)

But from my recollection, we can clear FSR immediately, all we need to
do is defer writing ARM_SMMU_CB_RESUME

BR,
-R

>
> For actually *handling* faults, I thought we were going to need to hook
> up the new IOPF fault queue stuff anyway?
>
> Robin.
>
> > It is assumed that we'll have to turn off interrupts in our handler to allow
> > this to work. Its all very implementation specific, but then again we're
> > assuming that if you want to do this then you know what you are doing.
> >
> > In that spirit the error that skips the FSR should probably be something
> > specific instead of "all errors" - that way a well meaning handler that returns
> > a -EINVAL doesn't accidentally break itself.
> >
> > Jordan
> >
> >>> I think
> >>> it would be better to do this unconditionally, and print the "Unhandled
> >>> context fault" message for any non-zero value of ret.
> >
> >>>
> >>> Will
> >>>
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
