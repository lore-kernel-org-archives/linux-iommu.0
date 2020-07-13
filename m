Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EA6C433E2
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 17:36:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C00D206F5
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 17:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TnmnJ93e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C00D206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2D25523236;
	Mon, 13 Jul 2020 17:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3csMxhOEsbkW; Mon, 13 Jul 2020 17:36:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 53FD22156F;
	Mon, 13 Jul 2020 17:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E442C0888;
	Mon, 13 Jul 2020 17:36:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A407C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 17:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F1AE723236
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 17:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hs6AzQEnUEF7 for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 17:36:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by silver.osuosl.org (Postfix) with ESMTPS id 585342156F
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 17:36:03 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1594661763; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=CvfZlugoNU5o1IHqBOpfgXsjwJUiIn6R8RJDOiGc4Ho=;
 b=TnmnJ93eGn9miX2e+V7EMLyo4tCNa9CXp8c1iddfyRJlMr8Ki297xtoGZ/H3vWpEdVXEbxUW
 HL1CCCGgLfrwQ4hYgVANGPpkoObsIlUfP047whA4/Fr5/luZUOj/fafE0q2MdqROxdrAVKMg
 z4gW9cAh2ERuF4lNvzbh6zF4udM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5f0c9b82e3bee12510cb588b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Jul 2020 17:36:02
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 6824CC43391; Mon, 13 Jul 2020 17:36:01 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id CE555C433C6;
 Mon, 13 Jul 2020 17:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE555C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 13 Jul 2020 11:35:56 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [Freedreno] [PATCH v2 1/6] iommu/arm-smmu: Add auxiliary domain
 support for arm-smmuv2
Message-ID: <20200713173556.GC3815@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, 
 John Stultz <john.stultz@linaro.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20200626200414.14382-1-jcrouse@codeaurora.org>
 <20200626200414.14382-2-jcrouse@codeaurora.org>
 <9943752c-9e0b-3d11-cba9-ee579d449e30@arm.com>
 <CAF6AEGvZ+HSwvf+N=fYjkB6FKfFSVPM5G6QqkFh8NOT6d2urgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGvZ+HSwvf+N=fYjkB6FKfFSVPM5G6QqkFh8NOT6d2urgw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: freedreno <freedreno@lists.freedesktop.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 John Stultz <john.stultz@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
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

On Tue, Jul 07, 2020 at 08:09:41AM -0700, Rob Clark wrote:
> On Tue, Jul 7, 2020 at 5:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2020-06-26 21:04, Jordan Crouse wrote:
> > > Support auxiliary domains for arm-smmu-v2 to initialize and support
> > > multiple pagetables for a single SMMU context bank. Since the smmu-v2
> > > hardware doesn't have any built in support for switching the pagetable
> > > base it is left as an exercise to the caller to actually use the pagetable.
> >
> > Hmm, I've still been thinking that we could model this as supporting
> > exactly 1 aux domain iff the device is currently attached to a primary
> > domain with TTBR1 enabled. Then supporting multiple aux domains with
> > magic TTBR0 switching is the Adreno-specific extension on top of that.
> >
> > And if we don't want to go to that length, then - as I think Will was
> > getting at - I'm not sure it's worth bothering at all. There doesn't
> > seem to be any point in half-implementing a pretend aux domain interface
> > while still driving a bus through the rest of the abstractions - it's
> > really the worst of both worlds. If we're going to hand over the guts of
> > io-pgtable to the GPU driver then couldn't it just use
> > DOMAIN_ATTR_PGTABLE_CFG bidirectionally to inject a TTBR0 table straight
> > into the TTBR1-ified domain?
> 
> So, something along the lines of:
> 
> 1) qcom_adreno_smmu_impl somehow tells core arms-smmu that we want
>    to use TTBR1 instead of TTBR0
> 
> 2) gpu driver uses iommu_domain_get_attr(PGTABLE_CFG) to snapshot
>    the initial pgtable cfg.  (Btw, I kinda feel like we should add
>    io_pgtable_fmt to io_pgtable_cfg to make it self contained.)
> 
> 3) gpu driver constructs pgtable_ops for TTBR0, and then kicks
>    arm-smmu to do the initial setup to enable TTBR0 with
>    iommu_domain_set_attr(PGTABLE_CFG, &ttbr0_pgtable_cfg)


There being no objections, I'm going to start going in this direction.
I think we should have a quirk on the arm-smmu device to allow the PGTABLE_CFG
to be set otherwise there is a chance for abuse. Ideally we would filter this
behavior on a stream ID basis if we come up with a scheme to do that cleanly
based on Will's comments in [1].

[1] https://lists.linuxfoundation.org/pipermail/iommu/2020-July/046488.html

Jordan

> if I understood you properly, that sounds simpler.
> 
> > Much as I like the idea of the aux domain abstraction and making this
> > fit semi-transparently into the IOMMU API, if an almost entirely private
> > interface will be the simplest and cleanest way to get it done then at
> > this point also I'm starting to lean towards just getting it done. But
> > if some other mediated-device type case then turns up that doesn't quite
> > fit that private interface, we revisit the proper abstraction again and
> > I reserve the right to say "I told you so" ;)
> 
> I'm on board with not trying to design this too generically until
> there is a second user
> 
> BR,
> -R
> 
> 
> >
> > Robin.
> >
> > > Aux domains are supported if split pagetable (TTBR1) support has been
> > > enabled on the master domain.  Each auxiliary domain will reuse the
> > > configuration of the master domain. By default the a domain with TTBR1
> > > support will have the TTBR0 region disabled so the first attached aux
> > > domain will enable the TTBR0 region in the hardware and conversely the
> > > last domain to be detached will disable TTBR0 translations.  All subsequent
> > > auxiliary domains create a pagetable but not touch the hardware.
> > >
> > > The leaf driver will be able to query the physical address of the
> > > pagetable with the DOMAIN_ATTR_PTBASE attribute so that it can use the
> > > address with whatever means it has to switch the pagetable base.
> > >
> > > Following is a pseudo code example of how a domain can be created
> > >
> > >   /* Check to see if aux domains are supported */
> > >   if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
> > >        iommu = iommu_domain_alloc(...);
> > >
> > >        if (iommu_aux_attach_device(domain, dev))
> > >                return FAIL;
> > >
> > >       /* Save the base address of the pagetable for use by the driver
> > >       iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
> > >   }
> > >
> > > Then 'domain' can be used like any other iommu domain to map and
> > > unmap iova addresses in the pagetable.
> > >
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >
> > >   drivers/iommu/arm-smmu.c | 219 ++++++++++++++++++++++++++++++++++++---
> > >   drivers/iommu/arm-smmu.h |   1 +
> > >   2 files changed, 204 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index 060139452c54..ce6d654301bf 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -91,6 +91,7 @@ struct arm_smmu_cb {
> > >       u32                             tcr[2];
> > >       u32                             mair[2];
> > >       struct arm_smmu_cfg             *cfg;
> > > +     atomic_t                        aux;
> > >   };
> > >
> > >   struct arm_smmu_master_cfg {
> > > @@ -667,6 +668,86 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> > >       arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
> > >   }
> > >
> > > +/*
> > > + * Update the context context bank to enable TTBR0. Assumes AARCH64 S1
> > > + * configuration.
> > > + */
> > > +static void arm_smmu_context_set_ttbr0(struct arm_smmu_cb *cb,
> > > +             struct io_pgtable_cfg *pgtbl_cfg)
> > > +{
> > > +     u32 tcr = cb->tcr[0];
> > > +
> > > +     /* Add the TCR configuration from the new pagetable config */
> > > +     tcr |= arm_smmu_lpae_tcr(pgtbl_cfg);
> > > +
> > > +     /* Make sure that both TTBR0 and TTBR1 are enabled */
> > > +     tcr &= ~(ARM_SMMU_TCR_EPD0 | ARM_SMMU_TCR_EPD1);
> > > +
> > > +     /* Udate the TCR register */
> > > +     cb->tcr[0] = tcr;
> > > +
> > > +     /* Program the new TTBR0 */
> > > +     cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> > > +     cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
> > > +}
> > > +
> > > +/*
> > > + * Thus function assumes that the current model only allows aux domains for
> > > + * AARCH64 S1 configurations
> > > + */
> > > +static int arm_smmu_aux_init_domain_context(struct iommu_domain *domain,
> > > +             struct arm_smmu_device *smmu, struct arm_smmu_cfg *master)
> > > +{
> > > +     struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > > +     struct io_pgtable_ops *pgtbl_ops;
> > > +     struct io_pgtable_cfg pgtbl_cfg;
> > > +
> > > +     mutex_lock(&smmu_domain->init_mutex);
> > > +
> > > +     /* Copy the configuration from the master */
> > > +     memcpy(&smmu_domain->cfg, master, sizeof(smmu_domain->cfg));
> > > +
> > > +     smmu_domain->flush_ops = &arm_smmu_s1_tlb_ops;
> > > +     smmu_domain->smmu = smmu;
> > > +
> > > +     pgtbl_cfg = (struct io_pgtable_cfg) {
> > > +             .pgsize_bitmap = smmu->pgsize_bitmap,
> > > +             .ias = smmu->va_size,
> > > +             .oas = smmu->ipa_size,
> > > +             .coherent_walk = smmu->features & ARM_SMMU_FEAT_COHERENT_WALK,
> > > +             .tlb = smmu_domain->flush_ops,
> > > +             .iommu_dev = smmu->dev,
> > > +             .quirks = 0,
> > > +     };
> > > +
> > > +     if (smmu_domain->non_strict)
> > > +             pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> > > +
> > > +     pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1, &pgtbl_cfg,
> > > +             smmu_domain);
> > > +     if (!pgtbl_ops) {
> > > +             mutex_unlock(&smmu_domain->init_mutex);
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> > > +
> > > +     domain->geometry.aperture_end = (1UL << smmu->va_size) - 1;
> > > +     domain->geometry.force_aperture = true;
> > > +
> > > +     /* enable TTBR0 when the the first aux domain is attached */
> > > +     if (atomic_inc_return(&smmu->cbs[master->cbndx].aux) == 1) {
> > > +             arm_smmu_context_set_ttbr0(&smmu->cbs[master->cbndx],
> > > +                     &pgtbl_cfg);
> > > +             arm_smmu_write_context_bank(smmu, master->cbndx);
> > > +     }
> > > +
> > > +     smmu_domain->pgtbl_ops = pgtbl_ops;
> > > +     mutex_unlock(&smmu_domain->init_mutex);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >   static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> > >                                       struct arm_smmu_device *smmu,
> > >                                       struct device *dev)
> > > @@ -871,36 +952,70 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> > >       return ret;
> > >   }
> > >
> > > +static void
> > > +arm_smmu_destroy_aux_domain_context(struct arm_smmu_domain *smmu_domain)
> > > +{
> > > +     struct arm_smmu_device *smmu = smmu_domain->smmu;
> > > +     struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> > > +     int ret;
> > > +
> > > +     /*
> > > +      * If this is the last aux domain to be freed, disable TTBR0 by turning
> > > +      * off translations and clearing TTBR0
> > > +      */
> > > +     if (atomic_dec_return(&smmu->cbs[cfg->cbndx].aux) == 0) {
> > > +             /* Clear out the T0 region */
> > > +             smmu->cbs[cfg->cbndx].tcr[0] &= ~GENMASK(15, 0);
> > > +             /* Disable TTBR0 translations */
> > > +             smmu->cbs[cfg->cbndx].tcr[0] |= ARM_SMMU_TCR_EPD0;
> > > +             /* Clear the TTBR0 pagetable address */
> > > +             smmu->cbs[cfg->cbndx].ttbr[0] =
> > > +                     FIELD_PREP(ARM_SMMU_TTBRn_ASID, cfg->asid);
> > > +
> > > +             ret = arm_smmu_rpm_get(smmu);
> > > +             if (!ret) {
> > > +                     arm_smmu_write_context_bank(smmu, cfg->cbndx);
> > > +                     arm_smmu_rpm_put(smmu);
> > > +             }
> > > +     }
> > > +
> > > +}
> > > +
> > >   static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
> > >   {
> > >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > >       struct arm_smmu_device *smmu = smmu_domain->smmu;
> > >       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> > > -     int ret, irq;
> > >
> > >       if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
> > >               return;
> > >
> > > -     ret = arm_smmu_rpm_get(smmu);
> > > -     if (ret < 0)
> > > -             return;
> > > +     if (smmu_domain->aux)
> > > +             arm_smmu_destroy_aux_domain_context(smmu_domain);
> > >
> > > -     /*
> > > -      * Disable the context bank and free the page tables before freeing
> > > -      * it.
> > > -      */
> > > -     smmu->cbs[cfg->cbndx].cfg = NULL;
> > > -     arm_smmu_write_context_bank(smmu, cfg->cbndx);
> > > +     /* Check if the last user is done with the context bank */
> > > +     if (atomic_read(&smmu->cbs[cfg->cbndx].aux) == 0) {
> > > +             int ret = arm_smmu_rpm_get(smmu);
> > > +             int irq;
> > >
> > > -     if (cfg->irptndx != ARM_SMMU_INVALID_IRPTNDX) {
> > > -             irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> > > -             devm_free_irq(smmu->dev, irq, domain);
> > > +             if (ret < 0)
> > > +                     return;
> > > +
> > > +             /* Disable the context bank */
> > > +             smmu->cbs[cfg->cbndx].cfg = NULL;
> > > +             arm_smmu_write_context_bank(smmu, cfg->cbndx);
> > > +
> > > +             if (cfg->irptndx != ARM_SMMU_INVALID_IRPTNDX) {
> > > +                     irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> > > +                     devm_free_irq(smmu->dev, irq, domain);
> > > +             }
> > > +
> > > +             __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> > > +             arm_smmu_rpm_put(smmu);
> > >       }
> > >
> > > +     /* Destroy the pagetable */
> > >       free_io_pgtable_ops(smmu_domain->pgtbl_ops);
> > > -     __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> > > -
> > > -     arm_smmu_rpm_put(smmu);
> > >   }
> > >
> > >   static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> > > @@ -1161,6 +1276,74 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
> > >       return 0;
> > >   }
> > >
> > > +static bool arm_smmu_dev_has_feat(struct device *dev,
> > > +             enum iommu_dev_features feat)
> > > +{
> > > +     if (feat != IOMMU_DEV_FEAT_AUX)
> > > +             return false;
> > > +
> > > +     return true;
> > > +}
> > > +
> > > +static int arm_smmu_dev_enable_feat(struct device *dev,
> > > +             enum iommu_dev_features feat)
> > > +{
> > > +     /* aux domain support is always available */
> > > +     if (feat == IOMMU_DEV_FEAT_AUX)
> > > +             return 0;
> > > +
> > > +     return -ENODEV;
> > > +}
> > > +
> > > +static int arm_smmu_dev_disable_feat(struct device *dev,
> > > +             enum iommu_dev_features feat)
> > > +{
> > > +     return -EBUSY;
> > > +}
> > > +
> > > +static int arm_smmu_aux_attach_dev(struct iommu_domain *domain,
> > > +             struct device *dev)
> > > +{
> > > +     struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > > +     struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> > > +     struct arm_smmu_device *smmu = cfg->smmu;
> > > +     struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > > +     struct arm_smmu_cb *cb;
> > > +     int idx, i, ret, cbndx = -1;
> > > +
> > > +     /* Try to find the context bank configured for this device */
> > > +     for_each_cfg_sme(cfg, fwspec, i, idx) {
> > > +             if (idx != INVALID_SMENDX) {
> > > +                     cbndx = smmu->s2crs[idx].cbndx;
> > > +                     break;
> > > +             }
> > > +     }
> > > +
> > > +     if (cbndx == -1)
> > > +             return -ENODEV;
> > > +
> > > +     cb = &smmu->cbs[cbndx];
> > > +
> > > +     /* Aux domains are only supported for AARCH64 configurations */
> > > +     if (cb->cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64)
> > > +             return -EINVAL;
> > > +
> > > +     /* Make sure that TTBR1 is enabled in the hardware */
> > > +     if ((cb->tcr[0] & ARM_SMMU_TCR_EPD1))
> > > +             return -EINVAL;
> > > +
> > > +     smmu_domain->aux = true;
> > > +
> > > +     ret = arm_smmu_rpm_get(smmu);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     ret = arm_smmu_aux_init_domain_context(domain, smmu, cb->cfg);
> > > +
> > > +     arm_smmu_rpm_put(smmu);
> > > +     return ret;
> > > +}
> > > +
> > >   static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >   {
> > >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > > @@ -1653,6 +1836,10 @@ static struct iommu_ops arm_smmu_ops = {
> > >       .get_resv_regions       = arm_smmu_get_resv_regions,
> > >       .put_resv_regions       = generic_iommu_put_resv_regions,
> > >       .def_domain_type        = arm_smmu_def_domain_type,
> > > +     .dev_has_feat           = arm_smmu_dev_has_feat,
> > > +     .dev_enable_feat        = arm_smmu_dev_enable_feat,
> > > +     .dev_disable_feat       = arm_smmu_dev_disable_feat,
> > > +     .aux_attach_dev         = arm_smmu_aux_attach_dev,
> > >       .pgsize_bitmap          = -1UL, /* Restricted during device attach */
> > >   };
> > >
> > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > index c417814f1d98..79d441024043 100644
> > > --- a/drivers/iommu/arm-smmu.h
> > > +++ b/drivers/iommu/arm-smmu.h
> > > @@ -346,6 +346,7 @@ struct arm_smmu_domain {
> > >       spinlock_t                      cb_lock; /* Serialises ATS1* ops and TLB syncs */
> > >       struct iommu_domain             domain;
> > >       struct device                   *dev;   /* Device attached to this domain */
> > > +     bool                            aux;
> > >   };
> > >
> > >   static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
> > >
> > _______________________________________________
> > Freedreno mailing list
> > Freedreno@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
