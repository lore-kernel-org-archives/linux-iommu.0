Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061471862B7
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427616; cv=none; b=o7G0jVNcWpN5jpzHLrhph9dOsomGeOR3b1EL4EQdm7lrdkupv/0bGQdxJU1uZfMlPIRYjLTdF7i4U6MDpIzMPJEbzz4dy4QTZV9qvc54lr7RlZYCXkfCaXwiS2CYWoD24b2q7jgq0P1gdRCfPiH+9LWBQvmM9epUhi37e4uVDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427616; c=relaxed/simple;
	bh=hCP2/cOIMfXKaR4773l0cPM0s+a5YSCE6aMXJzq+FCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUj6l7jeNriutYHDAdl47RIktLdxYntW41r1NNMWvlX7ryaJ39aXeL/DPfPCkp0VCG3p34zoYXajFMTOdgvX3aMO6B1AH4Z0NIimcpYapiRMgKxRGD917YWD9a01fclT1UiGflVSy18+0LfL83riRYdh5wFbxvE686O+YtoZHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKXrCjhx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKXrCjhx"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so990247a12.1
        for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719427611; x=1720032411; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05xs0UPmY5E+F63kUKej/aI4513YNXTW11SYkWXrW+o=;
        b=bKXrCjhxSIyl4x2t4XJZrwxawTPu1H1sursvncLMG7dvl7YyWJolyCpYh1nCJkdrS5
         N7fHyT51YK2ceAgsGPVSEbocV65QQNndIPJYWG/HYsOZRl4ug0E8DEK31G7jW15KIAEZ
         ZGBUwwcYxyfqqOZTmpk0zucvyYVixl1GGLIJTdX/eTDuC85Ki1Zs6x8nPRmZZqArOCSa
         5YHZeLZI6Gy+r3D4B5GkPTb2CM6y3w0iByvEGwrdcNZvIlqGrT8ngDHo5r5c7Qqip+Ty
         Ioa8ijgcyz3To2bzQdFJvwcwVap3Y+RsNF+dUgVIxlZiMagPgLbdNwsWYHHTKpYa5UJ4
         0NsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719427611; x=1720032411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05xs0UPmY5E+F63kUKej/aI4513YNXTW11SYkWXrW+o=;
        b=udq/FFFyaOKTn4DE4sIcOMDVB1MTi/wh/+YAY/1g7a6v28LjiCza05PcPrqyNEV/js
         0OOdkrqpaFjH85RbIuz9GTRrevi5/wAsEGBJUKdPtN64xrEerzaS656zWqaTtcZtA1Ry
         LWSuwmAyvgjem4ZK+oaYpII4qyLTvJU1/zSFOMWZH1ejwjvpNH9u/8llceF2dabLIiQZ
         krflc5BksIsPX0p2fuKt14EXFt9ONaZH03rt12oCOqEKHo3CmwaZdSMdi0ocdQFwwtPn
         OvqR3nlUv6Gpfrw7RFywkyDUtWPoa5YfZUbmczW72hXKQh+QB3qn0xisdSs+Rfap/hEB
         3ukA==
X-Forwarded-Encrypted: i=1; AJvYcCVqJQNt7szxIh2ltLhsNh+awwTRw87oQMLjes8o45OjGitrC6nqVwr2RbdnHMK+Ollfd9GiGXRS6O2O0wx5nZ0HIYQ/6XI=
X-Gm-Message-State: AOJu0YyjZ4yytqlvRQ9jy/9mWf+GM5Kj7y58GbJ7thY4NRbwz7USVtc8
	Q0BWg0UiEaNcufdwD6dw8HrqE3t9vfN5RL4/VjQsEUz//WL8/11mlN7+9hYlheo5pt5uBhxxQk/
	XKiRtUzXPHiG9I84wkLqJwhr523A=
X-Google-Smtp-Source: AGHT+IEage29NdSXqvdACNgm4MEoYcHlZ/Kmc6Dcz8VCYvHNGZ0kgMyfqB5MA0odYqhcBx1HpvIgMAGBW3xPbx2snB4=
X-Received: by 2002:a50:a452:0:b0:57c:a4a3:f1fe with SMTP id
 4fb4d7f45d1cf-5847c0a639cmr336979a12.17.1719427611109; Wed, 26 Jun 2024
 11:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240605121713.3596499-1-quic_bibekkum@quicinc.com>
 <20240605121713.3596499-7-quic_bibekkum@quicinc.com> <CAF6AEGtSCfQVtNTmwB4Jkec5rDmZsr59z2717H76kwWu0wovsw@mail.gmail.com>
 <ae35bf9b-4401-4a99-abd7-c0d9d399a46b@quicinc.com>
In-Reply-To: <ae35bf9b-4401-4a99-abd7-c0d9d399a46b@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 26 Jun 2024 11:46:39 -0700
Message-ID: <CAF6AEGtDvMR3LNwfMOBa9rNzS4gH0Lb_+AgFJrkALPB2GPh+4Q@mail.gmail.com>
Subject: Re: [PATCH v11 6/6] iommu/arm-smmu: add support for PRR bit setup
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org, 
	konrad.dybcio@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 1:11=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 6/12/2024 12:32 AM, Rob Clark wrote:
> > On Wed, Jun 5, 2024 at 5:18=E2=80=AFAM Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >> Add an adreno-smmu-priv interface for drm/msm to call
> >> into arm-smmu-qcom and initiate the PRR bit setup or reset
> >> sequence as per request.
> >>
> >> This will be used by GPU side to setup the PRR bit and
> >> related configuration registers through adreno-smmu private
> >> interface instead of directly poking the smmu hardware.
> >>
> >> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 21 ++++++++++++++++++++=
+
> >>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
> >>   include/linux/adreno-smmu-priv.h           |  5 ++++-
> >>   3 files changed, 27 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iomm=
u/arm/arm-smmu/arm-smmu-qcom.c
> >> index 8dabc26fa10e..2f4ee22f740a 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> @@ -28,6 +28,7 @@
> >>   #define PREFETCH_SHALLOW       (1 << PREFETCH_SHIFT)
> >>   #define PREFETCH_MODERATE      (2 << PREFETCH_SHIFT)
> >>   #define PREFETCH_DEEP          (3 << PREFETCH_SHIFT)
> >> +#define GFX_ACTLR_PRR          (1 << 5)
> >>
> >>   static const struct actlr_config sc7280_apps_actlr_cfg[] =3D {
> >>          { 0x0800, 0x24e1, PREFETCH_DEFAULT | CMTLB },
> >> @@ -212,6 +213,25 @@ static void qcom_adreno_smmu_resume_translation(c=
onst void *cookie, bool termina
> >>          arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
> >>   }
> >>
> >> +static void qcom_adreno_smmu_set_actlr_bit(const void *cookie, phys_a=
ddr_t page_addr, bool set)
> >> +{
> >
> > _set_actlr_bit() is a bit more of an implementation detail.  Maybe
> > _set_prr() would be a better name?
> >
>
> Yes set_prr sounds more explanatory. Infact Initially planned to name it
> as set_actlr_prr() but later changed it to set_actlr_bit() so to keep
> this interface extendible.
> Incase if gfx driver in future wants to control some other ACTLR bit as
> well along with PRR bit, then we can extend this same interface to
> handle other bits.
> So any additional adreno-smmu-priv interface would note be needed, and
> set_actlr_bit can itself be used for gfx handling of all required ACTLR
> bits.
> I think we can name it set_actlr_prr() for now, and later can change the
> name incase we extend it. What's your thought on this?

I think set_prr() or set_acltr_prr() is fine.. we can worry about
making it more generic if and when there are other ACLTR bits the gpu
wants to control

> > Also, the version of this patch that I typed up (but haven't sent to
> > list yet) took a `struct page *` instead of a phys_addr_t.. passing
> > NULL would disable PRR, so I didn't need the third arg
> >
> >> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> >> +       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> >> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >> +       u32 reg =3D 0;
> >> +
> >> +       writel_relaxed(lower_32_bits(page_addr),
> >> +                               (void *)smmu->ioaddr + ARM_SMMU_GFX_PR=
R_CFG_LADDR);
> >> +
> >> +       writel_relaxed(upper_32_bits(page_addr),
> >> +                               (void *)smmu->ioaddr + ARM_SMMU_GFX_PR=
R_CFG_UADDR);
> >
> > I know downstream writes it as upper+lower, but I'd guess we could
> > just writeq, couldn't we?
> >
>
> Actually ARM_SMMU_GFX_PRR_CFG_LADDR, ARM_SMMU_GFX_PRR_CFG_UADDR both are
> separate 32 bit registers. So I think writeq for 64bit write might not
> work, as these are not 64 bit registers nor these two are separated by
> 64 aligned address.

ahh, ok

> >> +
> >> +       reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR)=
;
> >> +       reg |=3D FIELD_PREP(GFX_ACTLR_PRR, set ? 1 : 0);
> >
> > this won't clear the ENABLE_PRR bit if we try to disable it after
> > enabling (unless this bit is read-as-zero
> >
>
> Ah okay right, got it. Thanks for pointing this out.
> Will take care of this in next version.
> will use set/reset in side if() instead with different
> bitwise ops for set and reset.
>
>
> > Also, can we give a name to PRR?  I'm guessing it is something like
> > physical-range-remap?
>
> Yes sure. I checked on this, PRR here actually stands for
> partially-resident-region.

ahh, ok, that makes sense

> So would be better If we add expansion for PRR in a comment ?
> Because if we expand PRR in variables/defines then wouldn't
> the names become too long?

Yeah, I was just thinking to mention it in the comment for set_prr()

BR,
-R

>
> Thanks & regards,
> Bibek
>
> >
> > BR,
> > -R
> >
> >> +       arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
> >> +
> >> +}
> >> +
> >>   #define QCOM_ADRENO_SMMU_GPU_SID 0
> >>
> >>   static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> >> @@ -384,6 +404,7 @@ static int qcom_adreno_smmu_init_context(struct ar=
m_smmu_domain *smmu_domain,
> >>          priv->get_fault_info =3D qcom_adreno_smmu_get_fault_info;
> >>          priv->set_stall =3D qcom_adreno_smmu_set_stall;
> >>          priv->resume_translation =3D qcom_adreno_smmu_resume_translat=
ion;
> >> +       priv->set_actlr_bit =3D qcom_adreno_smmu_set_actlr_bit;
> >>
> >>          actlrvar =3D qsmmu->data->actlrvar;
> >>          if (!actlrvar)
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm=
/arm-smmu/arm-smmu.h
> >> index d9c2ef8c1653..3076bef49e20 100644
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
> >> index c637e0997f6d..448e191eeb52 100644
> >> --- a/include/linux/adreno-smmu-priv.h
> >> +++ b/include/linux/adreno-smmu-priv.h
> >> @@ -49,7 +49,9 @@ struct adreno_smmu_fault_info {
> >>    *                 before set_ttbr0_cfg().  If stalling on fault is =
enabled,
> >>    *                 the GPU driver must call resume_translation()
> >>    * @resume_translation: Resume translation after a fault
> >> - *
> >> + * @set_actlr_bits: Extendible interface to be used  by GPU to modify=
 the
> >> + *                 ACTLR bits, currently used to intitate PRR bit set=
up or
> >> + *                 reset sequence for ACTLR registers as requested.
> >>    *
> >>    * The GPU driver (drm/msm) and adreno-smmu work together for contro=
lling
> >>    * the GPU's SMMU instance.  This is by necessity, as the GPU is dir=
ectly
> >> @@ -67,6 +69,7 @@ struct adreno_smmu_priv {
> >>       void (*get_fault_info)(const void *cookie, struct adreno_smmu_fa=
ult_info *info);
> >>       void (*set_stall)(const void *cookie, bool enabled);
> >>       void (*resume_translation)(const void *cookie, bool terminate);
> >> +    void (*set_actlr_bit)(const void *cookie, phys_addr_t page_addr, =
bool set);
> >>   };
> >>
> >>   #endif /* __ADRENO_SMMU_PRIV_H */
> >> --
> >> 2.34.1
> >>
