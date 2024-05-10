Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF04495F0
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370531; cv=none; b=Sf5/yIatx9SEUgnUIyoqOY03V4qd8Yf1+Vvv6JGpwMvxNwviBvkawHncLPVvB33sqyF6uVnEgE+UK1Qlmn/5SGrJgK1tQnAxBL3VVwuAexI/BK+sU1Z5pnvdMlSIE8beXydEGlOx3qbDhXoLgdy61flHX+zS2D46WVmLUhDoWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370531; c=relaxed/simple;
	bh=3XqgSEObDOCeJPpka9l8ocfh+GOn8nUFYBHjQqb8m+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ep2blxkFRAoKrFe0mD4+/N8pg0dJB9Eh+QnEt6ZyVW7g9mO/66IG9ZIyx1UXsN0hcbdExESEkl3+SQyPNeK8EUiGv3IDUXOdz5pKzduDIQSXe3fcvr871V+9PCnosuhaXtjE3kN3ifdGUX29DnjbipTwOeJwXcfebTaaEPizEG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxIau8hn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxIau8hn"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59c0a6415fso695477966b.1
        for <iommu@lists.linux.dev>; Fri, 10 May 2024 12:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715370528; x=1715975328; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAF1txzMebY/xPXBik7+S3gqJe3LUJLfPmgTaHM48fg=;
        b=FxIau8hnVusr4RddfoDj+Ilb4OehUQbpB7sTFHIeqh3HJ+TP8+tVAsZxGim1tdM937
         JRXb6wDw3P3lK9KZBhY0ipdtozxwpwXF9uhiIyl6A/ia5tLn3wz3KAnv8bPNX4fEExmv
         5acUjsHC142Kqj/Fz3GK1weIajdey6eEWGpk7DWOxG+3FIEepGQlPDG83ARlHu4Yko/0
         9rld0NLGMoqNpE7lVmJ0GMYl8xH1ClsRQUntpRZd9zOqXShC3MbXGr3S+283jEiqeEQO
         tDY42ULwHf058DOpoNWAW742pRQxyzPW2gY/2PvptMvbpjKtzmkeMcMBR5gvgdXGRlM0
         cenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715370528; x=1715975328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAF1txzMebY/xPXBik7+S3gqJe3LUJLfPmgTaHM48fg=;
        b=EMT8y9769enmRDUhjatRR2oVA8+MVxAEyg0n2i4U3+uF+01xZtlcwo20dXnbYTtMSL
         tCVwoZlFr3pf8XhA7ydpES94O5wGdMi0FMpBhNq5XW7iDFdRA2jfze320i/9I9PvUyfY
         cpfjPa7UATg5SaOTHB62IUwJJ9gVsrmHS34YRGolHFvRIJJb1VPQhS04nNQYB7LIU24u
         ZOQ4f71f4LAVF95lgNUxdP0vBdBDoK9e4rcczF9jRO+QD4sh6kVSExg1wnUKayXHnaXi
         KR1tLjvrpoLfNRUx6Z/jvhooY4zzA9WzOU9AKDWUCPavFp+28ltxas3QsodCYRoIUDhp
         q77Q==
X-Forwarded-Encrypted: i=1; AJvYcCUviaszBRtTgG/xJzwD7G2ic6lJQEadf3QjWPfLjTW3L7KiccGIafyCnrNQBQQObjBBSxOSg2VxItZQWo0ZyL3RsczVLUw=
X-Gm-Message-State: AOJu0Yy5AVObq2hMqGVhaELF0Hy8ZhuumXgZy54nwuG2T6gfHgGZ4DnM
	Tqjco59DG/fo7+HSCQawhKDSL2DGg1ASK7Xfm5PLJy07NxChJN0LQcjWRxTZ71UWNDpungGpb2l
	x2dcrtpSsGlzerSmlJVPMwBabYmk=
X-Google-Smtp-Source: AGHT+IEChyfEy75A1yLV7r286DTdXiPj99++sZ6PpOSlu7hC0fo011UDBXquc6NgqpTc6nmkLuXvpsBlDu/hiTHYjlw=
X-Received: by 2002:a50:d496:0:b0:572:93fa:d6fa with SMTP id
 4fb4d7f45d1cf-5734d43e905mr2321977a12.0.1715370527239; Fri, 10 May 2024
 12:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-4-quic_bibekkum@quicinc.com> <CAF6AEGs3_wBNo58EbGicFoQuq8--fDohTGv1JSFgoViygLS5Lg@mail.gmail.com>
 <f2222714-1e00-424e-946d-c314d55541b8@quicinc.com>
In-Reply-To: <f2222714-1e00-424e-946d-c314d55541b8@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 10 May 2024 12:48:22 -0700
Message-ID: <CAF6AEGtm-KweFdMFvahH1pWmpOq7dW_p0Xe_13aHGWt0jSbg8w@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org, jsnitsel@redhat.com, 
	quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com, 
	robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org, 
	vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 5:52=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 5/1/2024 12:30 AM, Rob Clark wrote:
> > On Tue, Jan 23, 2024 at 7:00=E2=80=AFAM Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >> Currently in Qualcomm  SoCs the default prefetch is set to 1 which all=
ows
> >> the TLB to fetch just the next page table. MMU-500 features ACTLR
> >> register which is implementation defined and is used for Qualcomm SoCs
> >> to have a custom prefetch setting enabling TLB to prefetch the next se=
t
> >> of page tables accordingly allowing for faster translations.
> >>
> >> ACTLR value is unique for each SMR (Stream matching register) and stor=
ed
> >> in a pre-populated table. This value is set to the register during
> >> context bank initialisation.
> >>
> >> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 61 ++++++++++++++++++++=
++
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h | 16 +++++-
> >>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +-
> >>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
> >>   4 files changed, 84 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iomm=
u/arm/arm-smmu/arm-smmu-qcom.c
> >> index 333daeb18c1c..6004c6d9a7b2 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> @@ -215,10 +215,42 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_=
smmu_device *smmu)
> >>          return true;
> >>   }
> >>
> >> +static void qcom_smmu_set_actlr(struct device *dev, struct arm_smmu_d=
evice *smmu, int cbndx,
> >> +               const struct actlr_config *actlrcfg, const size_t num_=
actlrcfg)
> >> +{
> >> +       struct arm_smmu_master_cfg *cfg =3D dev_iommu_priv_get(dev);
> >> +       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> >> +       struct arm_smmu_smr *smr;
> >> +       u16 mask;
> >> +       int idx;
> >> +       u16 id;
> >> +       int i;
> >> +       int j;
> >> +
> >> +       for (i =3D 0; i < num_actlrcfg; i++) {
> >> +               id =3D actlrcfg[i].sid;
> >> +               mask =3D actlrcfg[i].mask;
> >> +
> >> +               for_each_cfg_sme(cfg, fwspec, j, idx) {
> >> +                       smr =3D &smmu->smrs[idx];
> >> +                       if (smr_is_subset(smr, id, mask)) {
> >> +                               arm_smmu_cb_write(smmu, cbndx, ARM_SMM=
U_CB_ACTLR,
> >> +                                               actlrcfg[i].actlr);
> >
> > So, this makes ACTLR look like kind of a FIFO.  But I'm looking at
> > downstream kgsl's PRR thing (which we'll need to implement vulkan
> > sparse residency), and it appears to be wanting to set BIT(5) in ACTLR
> > to enable PRR.
> >
> >          val =3D KGSL_IOMMU_GET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR);
> >          val |=3D FIELD_PREP(KGSL_IOMMU_ACTLR_PRR_ENABLE, 1);
> >          KGSL_IOMMU_SET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR, val);
> >
> > Any idea how this works?  And does it need to be done before or after
> > the ACTLR programming done in this patch?
> >
> > BR,
> > -R
> >
>
> Hi Rob,
>
> Can you please help provide some more clarification on the FIFO part? By
> FIFO are you referring to the storing of ACTLR data in the table?

Yeah, I mean it is writing the same ACTLR register multiple times to
program the table.  I'm wondering if that means we need to program the
table in a particular order compared to setting the PRR bit?  Like do
we need to program PRR bit first, or last?

I'm planning on adding an adreno_smmu_priv interface so that drm/msm
can call into arm-smmu-qcom to setup the PRR bit and the related
PRR_CFG_LADDR/PRR_CFG_UADDR registers.  And I'm just wondering if
there is an ordering constraint wrt. when qcom_smmu_set_actlr() is
called?

BR,
-R

> Thanks for pointing to the downstream implementation of kgsl driver for
> the PRR bit. Since kgsl driver is already handling this PRR bit's
> setting, this makes setting the PRR BIT(5) by SMMU driver redundant.
> Thanks for bringing up this point.
> I will send v10 patch series removing this BIT(5) setting from the ACTLR
> table.
>
> Thanks & regards,
> Bibek
>
> >> +                               break;
> >> +                       }
> >> +               }
> >> +       }
> >> +}
> >> +
> >>   static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smm=
u_domain,
> >>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
> >>   {
> >> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >> +       struct qcom_smmu *qsmmu =3D to_qcom_smmu(smmu);
> >> +       const struct actlr_variant *actlrvar;
> >> +       int cbndx =3D smmu_domain->cfg.cbndx;
> >>          struct adreno_smmu_priv *priv;
> >> +       int i;
> >>
> >>          smmu_domain->cfg.flush_walk_prefer_tlbiasid =3D true;
> >>
> >> @@ -248,6 +280,18 @@ static int qcom_adreno_smmu_init_context(struct a=
rm_smmu_domain *smmu_domain,
> >>          priv->set_stall =3D qcom_adreno_smmu_set_stall;
> >>          priv->resume_translation =3D qcom_adreno_smmu_resume_translat=
ion;
> >>
> >> +       actlrvar =3D qsmmu->data->actlrvar;
> >> +       if (!actlrvar)
> >> +               return 0;
> >> +
> >> +       for (i =3D 0; i < qsmmu->data->num_smmu ; i++) {
> >> +               if (actlrvar[i].io_start =3D=3D smmu->ioaddr) {
> >> +                       qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar=
[i].actlrcfg,
> >> +                                      actlrvar[i].num_actlrcfg);
> >> +                       break;
> >> +               }
> >> +       }
> >> +
> >>          return 0;
> >>   }
> >>
> >> @@ -274,7 +318,24 @@ static const struct of_device_id qcom_smmu_client=
_of_match[] __maybe_unused =3D {
> >>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domai=
n,
> >>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
> >>   {
> >> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >> +       struct qcom_smmu *qsmmu =3D to_qcom_smmu(smmu);
> >> +       const struct actlr_variant *actlrvar;
> >> +       int cbndx =3D smmu_domain->cfg.cbndx;
> >> +       int i;
> >> +
> >>          smmu_domain->cfg.flush_walk_prefer_tlbiasid =3D true;
> >> +       actlrvar =3D qsmmu->data->actlrvar;
> >> +       if (!actlrvar)
> >> +               return 0;
> >> +
> >> +       for (i =3D 0; i < qsmmu->data->num_smmu ; i++) {
> >> +               if (actlrvar[i].io_start =3D=3D smmu->ioaddr) {
> >> +                       qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar=
[i].actlrcfg,
> >> +                                      actlrvar[i].num_actlrcfg);
> >> +                       break;
> >> +               }
> >> +       }
> >>
> >>          return 0;
> >>   }
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iomm=
u/arm/arm-smmu/arm-smmu-qcom.h
> >> index f3b91963e234..3f651242de7c 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> >> @@ -1,6 +1,6 @@
> >>   /* SPDX-License-Identifier: GPL-2.0-only */
> >>   /*
> >> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights re=
served.
> >> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All righ=
ts reserved.
> >>    */
> >>
> >>   #ifndef _ARM_SMMU_QCOM_H
> >> @@ -24,8 +24,22 @@ struct qcom_smmu_config {
> >>          const u32 *reg_offset;
> >>   };
> >>
> >> +struct actlr_config {
> >> +       u16 sid;
> >> +       u16 mask;
> >> +       u32 actlr;
> >> +};
> >> +
> >> +struct actlr_variant {
> >> +       const resource_size_t io_start;
> >> +       const struct actlr_config * const actlrcfg;
> >> +       const size_t num_actlrcfg;
> >> +};
> >> +
> >>   struct qcom_smmu_match_data {
> >> +       const struct actlr_variant * const actlrvar;
> >>          const struct qcom_smmu_config *cfg;
> >> +       const size_t num_smmu;
> >>          const struct arm_smmu_impl *impl;
> >>          const struct arm_smmu_impl *adreno_impl;
> >>   };
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm=
/arm-smmu/arm-smmu.c
> >> index d6d1a2a55cc0..0c7f700b27dd 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >> @@ -990,9 +990,10 @@ static int arm_smmu_find_sme(struct arm_smmu_devi=
ce *smmu, u16 id, u16 mask)
> >>                   * expect simply identical entries for this case, but=
 there's
> >>                   * no harm in accommodating the generalisation.
> >>                   */
> >> -               if ((mask & smrs[i].mask) =3D=3D mask &&
> >> -                   !((id ^ smrs[i].id) & ~smrs[i].mask))
> >> +
> >> +               if (smr_is_subset(&smrs[i], id, mask))
> >>                          return i;
> >> +
> >>                  /*
> >>                   * If the new entry has any other overlap with an exi=
sting one,
> >>                   * though, then there always exists at least one stre=
am ID
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm=
/arm-smmu/arm-smmu.h
> >> index 703fd5817ec1..2e4f65412c6b 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smm=
u_device *smmu, int page,
> >>                  writeq_relaxed(val, arm_smmu_page(smmu, page) + offse=
t);
> >>   }
> >>
> >> +static inline bool smr_is_subset(struct arm_smmu_smr *smrs, u16 id, u=
16 mask)
> >> +{
> >> +       return (mask & smrs->mask) =3D=3D mask && !((id ^ smrs->id) & =
~smrs->mask);
> >> +}
> >> +
> >>   #define ARM_SMMU_GR0           0
> >>   #define ARM_SMMU_GR1           1
> >>   #define ARM_SMMU_CB(s, n)      ((s)->numpage + (n))
> >> --
> >> 2.17.1
> >>
> >>
