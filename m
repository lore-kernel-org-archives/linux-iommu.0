Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E838BC433E3
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 17:17:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B0A20775
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F24pSJOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B0A20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 394F5881A0;
	Mon, 27 Jul 2020 17:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NfSk29qaESku; Mon, 27 Jul 2020 17:17:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E7EC287C14;
	Mon, 27 Jul 2020 17:17:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5F51C0050;
	Mon, 27 Jul 2020 17:17:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF9E9C004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 17:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AA4932210F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 17:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7za1EoB25aD3 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 17:17:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by silver.osuosl.org (Postfix) with ESMTPS id B205E220E5
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 17:16:59 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id y10so17886591eje.1
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=PREIfXCCu3w1zcBtJb3ZfAXkGKdy/WRW+EQjYoFwzm4=;
 b=F24pSJOzxR93pXUjPELGLKNFTxodoWPLieXhqKUPwLg97sRqzlE5ptMk35Oc4I5j4a
 KIZKItREVsjuKFstTDkN5Bq3Yg2q8RxjCFMF1vbNY1jFTCD8s83ZeqdbNKK9tl7KfZqc
 3anCw9ggQa/ztFKkplOS4fMk8ajdOblfS39laN+5fEFZWjGLHYlSVH+I4668V2pKN4zg
 SZlun5SnBlxktflp9/sZEBIaUVhlBr4RNB9IhVMXDS/f0eJtOaz8EjfDOMs18WHpqBut
 hs+9QOcI3gKHpy9lcqG9Npensg702r4NPeGV1Aqt0l5byDWRc7y7JmHia+3geElXvUoq
 8gQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=PREIfXCCu3w1zcBtJb3ZfAXkGKdy/WRW+EQjYoFwzm4=;
 b=QzpUDiDR/KnCN3TZk/vvZs2gK6z8DfI7dDe7GFpLczthnh5jfE/wlHuKI6BtLPx1VJ
 AWM6g7oVjCfOY3ut3dRdsL72KpEesozMdwZdIbpF4fIqETZvijXoNX0SalWgsr2Wq/g2
 d/AUfUz5u8C/JokBW5eEy9r7msRjb+z0tjQIqZwj6+NM9R9ZVahhu6FNr1rC7obIEx6O
 76TxoqFzPLdVDpb7uRAjZ8Gh4jOHd7a+I0Jzv7GuiXO7LffHGM7+cjbKyiEPMa+WzyD3
 tIvDURfrsqwpUJzFRHO8oTNyk88WtPLttCxtWzLKD/gQWf2eaa72buY2ZKwlCGAvmGNa
 +9iA==
X-Gm-Message-State: AOAM530Rk5BrFc8+a8N778ksBNBZPS5tqULlr6yH7Xu+f82on5zveCRL
 P1N/QLvCqeGY/fuzbsFEhjOikUBZvCQFrbQTU5Y=
X-Google-Smtp-Source: ABdhPJyxEC0OlYV19Te3075t4r3dMqI3c7X3WZxvviw+ElGVcW4TpojtZCtLSkOF9Djzm34h9tn1ayXMOw1jKl9ILaI=
X-Received: by 2002:a17:906:f199:: with SMTP id
 gs25mr6047791ejb.161.1595870218000; 
 Mon, 27 Jul 2020 10:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200720154047.3611092-1-jcrouse@codeaurora.org>
 <20200720154047.3611092-7-jcrouse@codeaurora.org>
 <CAF6AEGuF_fC4=vBKr24HogE-d3KkXUQivOpVde9iqf+RvRzNtA@mail.gmail.com>
 <20200727150306.GB32521@jcrouse1-lnx.qualcomm.com>
In-Reply-To: <20200727150306.GB32521@jcrouse1-lnx.qualcomm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 27 Jul 2020 10:17:36 -0700
Message-ID: <CAF6AEGtdO=d2r7dvLFNJ02nUDbKBm0J7O-i9=kxjWTr9NK=ecg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v10 06/13] iommu/arm-smmu-qcom: Get and set
 the pagetable config for split pagetables
To: Rob Clark <robdclark@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, 
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 freedreno <freedreno@lists.freedesktop.org>, 
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Bjorn Andersson <bjorn.andersson@linaro.org>, 
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, 
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

On Mon, Jul 27, 2020 at 8:03 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Sun, Jul 26, 2020 at 10:03:07AM -0700, Rob Clark wrote:
> > On Mon, Jul 20, 2020 at 8:41 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > >
> > > The Adreno GPU has the capability to manage its own pagetables and switch
> > > them dynamically from the hardware. To do this the GPU uses TTBR1 for
> > > "global" GPU memory and creates local pagetables for each context and
> > > switches them dynamically with the GPU.
> > >
> > > Use DOMAIN_ATTR_PGTABLE_CFG to get the current configuration for the
> > > TTBR1 pagetable from the smmu driver so the leaf driver can create
> > > compatible pagetables for use with TTBR0.
> > >
> > > Because TTBR0 is disabled by default when TTBR1 is enabled the GPU
> > > driver can pass the configuration of one of the newly created pagetables
> > > back through DOMAIN_ATTR_PGTABLE_CFG as a trigger to enable translation on
> > > TTBR0.
> > >
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >
> > >  drivers/iommu/arm-smmu-qcom.c | 47 +++++++++++++++++++++++++++++++++++
> > >  drivers/iommu/arm-smmu.c      | 32 ++++++++++++++++++------
> > >  drivers/iommu/arm-smmu.h      | 10 ++++++++
> > >  3 files changed, 81 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> > > index b9a5c5369e86..9a0c64ca9cb6 100644
> > > --- a/drivers/iommu/arm-smmu-qcom.c
> > > +++ b/drivers/iommu/arm-smmu-qcom.c
> > > @@ -34,6 +34,52 @@ static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> > >         return false;
> > >  }
> > >
> > > +/*
> > > + * Local implementation to configure TTBR0 wil the specified pagetable config.
> > > + * The GPU driver will call this to enable TTBR0 when per-instance pagetables
> > > + * are active
> > > + */
> > > +static int qcom_adreno_smmu_set_pgtable_cfg(struct arm_smmu_domain *smmu_domain,
> > > +               struct io_pgtable_cfg *pgtbl_cfg)
> > > +{
> > > +       struct io_pgtable *pgtable = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
> > > +       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> > > +       struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
> > > +
> > > +       /* The domain must have split pagetables already enabled */
> > > +       if (cb->tcr[0] & ARM_SMMU_TCR_EPD1)
> > > +               return -EINVAL;
> > > +
> > > +       /* If the pagetable config is NULL, disable TTBR0 */
> > > +       if (!pgtbl_cfg) {
> > > +               /* Do nothing if it is already disabled */
> > > +               if ((cb->tcr[0] & ARM_SMMU_TCR_EPD0))
> > > +                       return -EINVAL;
> > > +
> > > +               /* Set TCR to the original configuration */
> > > +               cb->tcr[0] = arm_smmu_lpae_tcr(&pgtable->cfg);
> > > +               cb->ttbr[0] = FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
> > > +       } else {
> > > +               u32 tcr = cb->tcr[0];
> > > +
> > > +               /* FIXME: What sort of validation do we need to do here? */
> > > +
> > > +               /* Don't call this again if TTBR0 is already enabled */
> > > +               if (!(cb->tcr[0] & ARM_SMMU_TCR_EPD0))
> > > +                       return -EINVAL;
> > > +
> > > +               tcr |= arm_smmu_lpae_tcr(pgtbl_cfg);
> > > +               tcr &= ~(ARM_SMMU_TCR_EPD0 | ARM_SMMU_TCR_EPD1);
> > > +
> > > +               cb->tcr[0] = tcr;
> > > +               cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> > > +               cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
> > > +       }
> > > +
> > > +       arm_smmu_write_context_bank(smmu_domain->smmu, cb->cfg->cbndx);
> > > +       return 0;
> > > +}
> > > +
> > >  static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
> > >                 struct device *dev, int start, int count)
> > >  {
> > > @@ -131,6 +177,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
> > >         .def_domain_type = qcom_smmu_def_domain_type,
> > >         .reset = qcom_smmu500_reset,
> > >         .alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
> > > +       .set_pgtable_cfg = qcom_adreno_smmu_set_pgtable_cfg,
> > >  };
> > >
> > >  static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index fff536a44faa..e1036ae54a8d 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -86,13 +86,6 @@ struct arm_smmu_smr {
> > >         bool                            valid;
> > >  };
> > >
> > > -struct arm_smmu_cb {
> > > -       u64                             ttbr[2];
> > > -       u32                             tcr[2];
> > > -       u32                             mair[2];
> > > -       struct arm_smmu_cfg             *cfg;
> > > -};
> > > -
> > >  static bool using_legacy_binding, using_generic_binding;
> > >
> > >  static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> > > @@ -558,7 +551,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
> > >         }
> > >  }
> > >
> > > -static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> > > +void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> > >  {
> > >         u32 reg;
> > >         bool stage1;
> > > @@ -1515,6 +1508,18 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> > >                 case DOMAIN_ATTR_NESTING:
> > >                         *(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
> > >                         return 0;
> > > +               case DOMAIN_ATTR_PGTABLE_CFG: {
> > > +                       struct io_pgtable *pgtable;
> > > +                       struct io_pgtable_cfg *dest = data;
> > > +
> > > +                       if (!smmu_domain->pgtbl_ops)
> > > +                               return -ENODEV;
> > > +
> > > +                       pgtable = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
> > > +
> > > +                       memcpy(dest, &pgtable->cfg, sizeof(*dest));
> > > +                       return 0;
> > > +               }
> >
> > hmm, maybe it would make sense to have impl hooks for get/set_attr, so
> > we could handle DOMAIN_ATTR_PGTABLE_CFG inside the adreno_smmu_impl?
> >
> > Having impl specific domain attrs would be useful for what I have in
> > mind to enable stall/resume support, so we can hook in devcoredump to
> > iova faults (which would be a huge improvement for debugability, right
> > now iova faults are somewhat harder to debug than needed).  My rough
> > idea was to add DOMAIN_ATTR_RESUME, which could be used with
> > set_attr() to (1) enable STALL and let drm/msm know whether the iommu
> > supports it, and (2) resume translation from wq context after
> > devcoredump snapshot is collected.
>
> Expanding on that, maybe a DOMAIN_ATTR_IMPL with struct { int subtype; void
> *data } as the payload would let us add things without having to populate the
> generic enum.  That would force us to export an arm-smmu header but at this
> point it might be such a bad thing.

That feels a bit like overkill to me, I don't expect there to be that
many custom things.  But I'll defer to the iommu folks as to which
they prefer.

BR,
-R

> Jordan
>
>
> > BR,
> > -R
> >
> > >                 default:
> > >                         return -ENODEV;
> > >                 }
> > > @@ -1555,6 +1560,17 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
> > >                         else
> > >                                 smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
> > >                         break;
> > > +               case DOMAIN_ATTR_PGTABLE_CFG: {
> > > +                       struct arm_smmu_device *smmu = smmu_domain->smmu;
> > > +
> > > +                       ret = -EPERM;
> > > +
> > > +                       if (smmu)
> > > +                               if (smmu->impl && smmu->impl->set_pgtable_cfg)
> > > +                                       ret = smmu->impl->set_pgtable_cfg(smmu_domain,
> > > +                                               data);
> > > +                       }
> > > +                       break;
> > >                 default:
> > >                         ret = -ENODEV;
> > >                 }
> > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > index 9f81c1fffe1e..9325fc28d24a 100644
> > > --- a/drivers/iommu/arm-smmu.h
> > > +++ b/drivers/iommu/arm-smmu.h
> > > @@ -328,6 +328,13 @@ struct arm_smmu_cfg {
> > >  };
> > >  #define ARM_SMMU_INVALID_IRPTNDX       0xff
> > >
> > > +struct arm_smmu_cb {
> > > +       u64                             ttbr[2];
> > > +       u32                             tcr[2];
> > > +       u32                             mair[2];
> > > +       struct arm_smmu_cfg             *cfg;
> > > +};
> > > +
> > >  enum arm_smmu_domain_stage {
> > >         ARM_SMMU_DOMAIN_S1 = 0,
> > >         ARM_SMMU_DOMAIN_S2,
> > > @@ -408,6 +415,8 @@ struct arm_smmu_impl {
> > >         int (*def_domain_type)(struct device *dev);
> > >         int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
> > >                         struct device *dev, int start, int max);
> > > +       int (*set_pgtable_cfg)(struct arm_smmu_domain *smmu_domain,
> > > +                       struct io_pgtable_cfg *cfg);
> > >  };
> > >
> > >  #define INVALID_SMENDX                 -1
> > > @@ -493,6 +502,7 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
> > >  struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
> > >  struct arm_smmu_device *qcom_adreno_smmu_impl_init(struct arm_smmu_device *smmu);
> > >
> > > +void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
> > >  int arm_mmu500_reset(struct arm_smmu_device *smmu);
> > >
> > >  #endif /* _ARM_SMMU_H */
> > > --
> > > 2.25.1
> > >
> > > _______________________________________________
> > > Freedreno mailing list
> > > Freedreno@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/freedreno
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
