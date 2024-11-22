Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B722339
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295001; cv=none; b=UQRy9DFODJAxwB3RGP/UOc+0P/Y/+ns5LdT1GBcbOiKDl+0NKTwkxUR2V/als5ef/8o2tpF4dBLOpNJSRzURxKKoMoLpRBkUYkKU9ItAmdugz1H6tW1ouehnS7FRb6ikvVebSOTxkwpcUbCnot7pLE8MJ9o+egVYgP6EQ/OETI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295001; c=relaxed/simple;
	bh=DSYLBok206YMcDOpRKLHJN0uDpz/Et0VqSkIPiZx8cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U86cFjBT4nZ1QUKj+dW0QATP/CDgjOYPk1BizhOMGgs91iWWSlJXEBlsdKLLHBVlZGPiWFNP8P8fz/7hFyx1oKgGkfB8/5Jku15/yYtVnlaf81vj2Yz7ws8tBGHuw3r+Q62qo2JwuQK9ee+zDXmbSkdHhT+Dg49ybgqq2NxKU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1sjYj5K; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1sjYj5K"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83ab21c269eso86855439f.2
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732294999; x=1732899799; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv3fgfAKB0pYrr8UPsqM1aMmtycm9HlM7s6qGZwm3kA=;
        b=m1sjYj5KDiF62qqwqNYei8H7IHIVBfU6SMNZmiFq8T/Bn3ZjMX7EtksozjA9yofLuz
         Z1XN5iJCilbLGSNNkvGPJRpQFKlGKgKy+w/aHdOeLuFJDIf4WuDYSIVpNkLgGvHxuS9R
         HY+G5HbEdj8GZTrRBp6RtEz/VMnwa+V/cKLRmLDR61FtwNLay1h6xJbuidD1qLd0s9k1
         0JAvvkh5p4KkVHW0ehWhv6FX1NReLC+l4Pv094pQOnmt4W3nLi83fMoslzs0bvwc7vLd
         /tELV9BNjOyY1h/zlUJal53s1XegSVcINjED4eAYJ/G3pRNcudzs9YEoutIZBsjiqwHi
         MYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732294999; x=1732899799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv3fgfAKB0pYrr8UPsqM1aMmtycm9HlM7s6qGZwm3kA=;
        b=cv5whlH9Ljtemwdb558zbzKC0hK1+i/xppuae0aaWdJAq+6ZBz7qeVWRanU5j15MGC
         t85SiI0jEePbs7V0nrQpuz35IpD+dnA7cKE6IYgoTTu85zpQmqg2lPpUQZ1EsUBXWQAs
         eC1jgdlJCu6rZBDH5J0BwkeZAz28xVZ9EAc3Pwpa5NW0Bq91rJYxMw+ip/o1ih5dLMY2
         CxK5DDulBwtSiwcyShHZuhIIar29k9Coiz7maEOXmPSBlWEEGHGGU2ifelbgpggtkbiB
         Eb7TJcvqyazbXQsJVWiS1EF5wIGf8A4rLypsAWfb6hOqVn9VN0M5ZuM/GLbpMqDAXAD6
         DVgA==
X-Forwarded-Encrypted: i=1; AJvYcCV7uDg5LSx1xQKY4tF2zXemolmU8fI9ArfVsQjBUWm/vbT5rpzMJtLt4vEN43uF/zptBsezpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjvfZ77si6XLawj+rqSx7xicf6S0R+W4IEtUaRqtAaGF++Ge+N
	JuwfNxr1QAmEquU03xlV9tOteEikRfNNaJlXBB8WJR5Hb/gKpeenN5T55v5qgObXkQJuddaF1VL
	sTJUVi2b5V2Kq6vsqjxAhBWGQ8Io=
X-Gm-Gg: ASbGnctrP4ofv68bp2/h/5SbGtkEYkbu2Lb0riq8QnZAoraTLGGVdnNO/2TI023YJV2
	L5O0Xgz6K5me8k83aiSL8XrNEK6Mw8wlYoVh6fLBKk2hcqD2dNdMaK5Rx4IVSYA==
X-Google-Smtp-Source: AGHT+IHNX7XBAn3wnPiLxXNWpHHx9iKOcEAYOqcO3+I/1rgxgip7FuRZP5VM6fHOHXEgVIN8PnpSdl2S3PKe/oRYz9Q=
X-Received: by 2002:a05:6602:29c3:b0:837:7f1a:40af with SMTP id
 ca18e2360f4ac-83ecdd2ed74mr438512139f.14.1732294998538; Fri, 22 Nov 2024
 09:03:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241114160721.1527934-1-quic_bibekkum@quicinc.com>
 <20241114160721.1527934-4-quic_bibekkum@quicinc.com> <CAF6AEGuwWsAkRyF-h5Aj3KzM7iksb12HsfJ5Ks+-P8hv60MWFg@mail.gmail.com>
 <9beca099-5cf3-42b5-b1f9-fb1551219b18@quicinc.com>
In-Reply-To: <9beca099-5cf3-42b5-b1f9-fb1551219b18@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 22 Nov 2024 09:03:06 -0800
Message-ID: <CAF6AEGvAOswFTpS5PHrgCsG_2-QN_Bi4YjZbPpV+r3x=9D2aUQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v17 3/5] iommu/arm-smmu: add support for PRR bit setup
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 8:19=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 11/20/2024 10:47 PM, Rob Clark wrote:
> > On Thu, Nov 14, 2024 at 8:10=E2=80=AFAM Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >> Add an adreno-smmu-priv interface for drm/msm to call
> >> into arm-smmu-qcom and initiate the PRR bit setup or reset
> >> sequence as per request.
> >>
> >> This will be used by GPU to setup the PRR bit and related
> >> configuration registers through adreno-smmu private
> >> interface instead of directly poking the smmu hardware.
> >>
> >> Suggested-by: Rob Clark <robdclark@gmail.com>
> >> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 37 ++++++++++++++++++++=
++
> >>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
> >>   include/linux/adreno-smmu-priv.h           | 14 ++++++++
> >>   3 files changed, 53 insertions(+)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iomm=
u/arm/arm-smmu/arm-smmu-qcom.c
> >> index d26f5aea248e..0e4f3fbda961 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> @@ -16,6 +16,8 @@
> >>
> >>   #define QCOM_DUMMY_VAL -1
> >>
> >> +#define GFX_ACTLR_PRR          (1 << 5)
> >> +
> >>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> >>   {
> >>          return container_of(smmu, struct qcom_smmu, smmu);
> >> @@ -99,6 +101,32 @@ static void qcom_adreno_smmu_resume_translation(co=
nst void *cookie, bool termina
> >>          arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
> >>   }
> >>
> >> +static void qcom_adreno_smmu_set_prr_bit(const void *cookie, bool set=
)
> >> +{
> >> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> >> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >> +       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> >> +       u32 reg =3D 0;
> >> +
> >> +       reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR)=
;
> >> +       reg &=3D ~GFX_ACTLR_PRR;
> >> +       if (set)
> >> +               reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> >> +       arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
> >> +}
> >> +
> >> +static void qcom_adreno_smmu_set_prr_addr(const void *cookie, phys_ad=
dr_t page_addr)
> >> +{
> >> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> >> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >> +
> >> +       writel_relaxed(lower_32_bits(page_addr),
> >> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG_LADD=
R);
> >> +
> >> +       writel_relaxed(upper_32_bits(page_addr),
> >> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG_UADD=
R);
> >> +}
> >> +
> >>   #define QCOM_ADRENO_SMMU_GPU_SID 0
> >>
> >>   static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> >> @@ -210,6 +238,7 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_sm=
mu_device *smmu)
> >>   static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smm=
u_domain,
> >>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
> >>   {
> >> +       const struct device_node *np =3D smmu_domain->smmu->dev->of_no=
de;
> >>          struct adreno_smmu_priv *priv;
> >>
> >>          smmu_domain->cfg.flush_walk_prefer_tlbiasid =3D true;
> >> @@ -239,6 +268,14 @@ static int qcom_adreno_smmu_init_context(struct a=
rm_smmu_domain *smmu_domain,
> >>          priv->get_fault_info =3D qcom_adreno_smmu_get_fault_info;
> >>          priv->set_stall =3D qcom_adreno_smmu_set_stall;
> >>          priv->resume_translation =3D qcom_adreno_smmu_resume_translat=
ion;
> >> +       priv->set_prr_bit =3D NULL;
> >> +       priv->set_prr_addr =3D NULL;
> >> +
> >> +       if (of_device_is_compatible(np, "qcom,smmu-500") &&
> >> +                       of_device_is_compatible(np, "qcom,adreno-smmu"=
)) {
> >
> > fwiw, it seems like PRR actually works on sc7180, which is _not_
> > mmu-500, so I guess the support actually goes back further.
> >
>
> As I checked sc7180 was on previous variant of SMMU,
> so targets on this variant have different steps to set PRR bit.
> <Do not have both prr bit and PRR page registers>.

Experimentally, I have to set both the PRR LADDR/UADDR regs and
ACTLR.PRR bit on sc7180 to get the sparse-residency tests passing.  So
the underlying hw seems to work in the same way as mmu-500.  _But_
this is on a sc7180 chromebook, the situation might be different
depending on fw on things that have QC hyp.

> It's MMU-500 targets only where PRR support is with both PRR bit
> and PRR page addr registers. As I was re-visiting our discussions on v13
> regarding this - I remember that's why we started using the SMMU-
> compatible string based PRR procedure selection instead of the reserved-
> memory node. [1] i.e Based on SMMU variant (as selected by compatible
> string), specific sequence will be selected.
>
> So for now only MMU-500 based selection has been supported as part of
> this series and will add subsequent support for other SMMU-variants
> thereafter.
>
> > I'm curious if we can just rely on this being supported by any hw that
> > has a6xx or newer?
> >
>
> I'd need to check on targets which will be based on a6xx onwards, on
> what will be the procedure planned to support PRR feature. I'll update
> the information over this space.

One of the open questions about the drm/msm sparse-memory patchset is
whether we need to expose to userspace whether PRR is supported, or if
we can just rely on sparse-binding support implying sparse residency
(ie, PRR) support.  All a6xx devices support per-process pgtables,
which is the only requirement for basic sparseBinding support.  But
PRR is required to additionally expose
sparseResidencyBuffer/sparseResidencyImage2D.

I think, long term, turnip probably will want to drop support for
older kernels and remove support for legacy buffer mapping.  But if we
have some a6xx devices without PRR, then to do that we'd need to
decouple sparse binding and sparse residency.  (Vulkan allows a driver
to expose the former without the latter.)

BR,
-R

> [1]:
> https://lore.kernel.org/all/5790afa3-f9c0-4720-9804-8a7ff3d91854@quicinc.=
com/#:~:text=3D%3E%20I%20guess%20if,part%20as%20well.
>
> Thanks & regards,
> Bibek
>
> > BR,
> > -R
> >
> >> +               priv->set_prr_bit =3D qcom_adreno_smmu_set_prr_bit;
> >> +               priv->set_prr_addr =3D qcom_adreno_smmu_set_prr_addr;
> >> +       }
> >>
> >>          return 0;
> >>   }
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm=
/arm-smmu/arm-smmu.h
> >> index e2aeb511ae90..2dbf3243b5ad 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >> @@ -154,6 +154,8 @@ enum arm_smmu_cbar_type {
> >>   #define ARM_SMMU_SCTLR_M               BIT(0)
> >>
> >>   #define ARM_SMMU_CB_ACTLR              0x4
> >> +#define ARM_SMMU_GFX_PRR_CFG_LADDR     0x6008
> >> +#define ARM_SMMU_GFX_PRR_CFG_UADDR     0x600C
> >>
> >>   #define ARM_SMMU_CB_RESUME             0x8
> >>   #define ARM_SMMU_RESUME_TERMINATE      BIT(0)
> >> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-s=
mmu-priv.h
> >> index c637e0997f6d..614665153b3e 100644
> >> --- a/include/linux/adreno-smmu-priv.h
> >> +++ b/include/linux/adreno-smmu-priv.h
> >> @@ -50,6 +50,18 @@ struct adreno_smmu_fault_info {
> >>    *                 the GPU driver must call resume_translation()
> >>    * @resume_translation: Resume translation after a fault
> >>    *
> >> + * *CAUTION* : PRR callbacks (set_prr_bit/set_prr_addr) are NULL term=
inated for
> >> + *             targets without PRR support. Exercise caution and veri=
fy target
> >> + *             capabilities before invoking these callbacks to preven=
t potential
> >> + *             runtime errors or unexpected behavior.
> >> + *
> >> + * @set_prr_bit:   Extendible interface to be used by GPU to modify t=
he
> >> + *                ACTLR register bits, currently used to configure
> >> + *                Partially-Resident-Region (PRR) bit for feature's
> >> + *                setup and reset sequence as requested.
> >> + * @set_prr_addr:  Configure the PRR_CFG_*ADDR register with the
> >> + *                physical address of PRR page passed from
> >> + *                GPU driver.
> >>    *
> >>    * The GPU driver (drm/msm) and adreno-smmu work together for contro=
lling
> >>    * the GPU's SMMU instance.  This is by necessity, as the GPU is dir=
ectly
> >> @@ -67,6 +79,8 @@ struct adreno_smmu_priv {
> >>       void (*get_fault_info)(const void *cookie, struct adreno_smmu_fa=
ult_info *info);
> >>       void (*set_stall)(const void *cookie, bool enabled);
> >>       void (*resume_translation)(const void *cookie, bool terminate);
> >> +    void (*set_prr_bit)(const void *cookie, bool set);
> >> +    void (*set_prr_addr)(const void *cookie, phys_addr_t page_addr);
> >>   };
> >>
> >>   #endif /* __ADRENO_SMMU_PRIV_H */
> >> --
> >> 2.34.1
> >>
>
