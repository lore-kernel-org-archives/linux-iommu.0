Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D3146A87
	for <iommu@lists.linux.dev>; Fri,  6 Dec 2024 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498351; cv=none; b=APt8NpkBWxaHHgqle8+cGhd/zWxmUIPStZ9r67QDePoDfv3JzYYZMlUnn5J4w8LI1G/IoLRnHCamph9PDAGbDlX9uVeq/ZtjVYZt+aJpErAXjGwcdtEahNu3r3CWzcGKVSWJaXGiGi8X7M4dc/dwkk35R/Z8JZ2eC09Ov4NWVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498351; c=relaxed/simple;
	bh=iNq+jv5jBtKbndIi5q7TmW7aPg2Ei2t2YqIIatcB2f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S47VPkKR/rwmPmHIVxaaikK0KKjQ1xFcH+KLyiwe/MtByYEJ5WOVlGdgNjz4c9VezVlLzpQTLzCs2UJ7rFqw2k9Pn7qSb3W8qhw3i5xQxOtNX2W1dDiMMv8zxxLUj5bY4Ds+FueAgFq0lGgiQZAsNfBlH0Fn1rs98KH+ukxqH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4Qj986h; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4Qj986h"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8419f5baedcso70462339f.2
        for <iommu@lists.linux.dev>; Fri, 06 Dec 2024 07:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733498348; x=1734103148; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtkfBG555A8avR1tfdNJHmNz49+zpVcRzzVowDg50dQ=;
        b=I4Qj986h+IsKqTviqLf9GX7qQg+oc3eC2VkutOmjxvcZXeyUHawRJQ6NL4RYdN2PRN
         5ZrUFWQKDVFlf8EyNhI+23ndnDgu+zVPl0AyVnTSZ7n8hnHGa0GEL0SPeYHKcC93E1T+
         b0CaO3G4jl9lFcMvqlHBLrRK1IJGha4aQVVtLDh5Erlvq1hyL92z2q5BLAplOpb0C/P1
         6d6J5o1DsyRapeWCA/F62CIytXHX/pi0FEllqX7Tp+lGtYJJra62v5HDlXIVM2c6Ks3l
         h/EUluZDNnoLWNR6V5F6XjkrPo4oIoS0SEHZOC+8DZEurkBYWnB4SCbhx8o99bCX+64j
         0IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498348; x=1734103148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtkfBG555A8avR1tfdNJHmNz49+zpVcRzzVowDg50dQ=;
        b=PRk+4PTR6yg+PKEWdYF3SmqJFIizIRmlFQmy4Vgo3aVm4Y/bVQChGj2q8qj7dSHot0
         dMkk10ZwWCj0Huub4JAwTnGbYxsO2PCKwUfKavwd8V6nqedjwobF0K7NhoEZfTkMUhho
         5NwYqbsex/wj39lne9xE3KvWwoXPSYEiDDfHSnjArC0qzgduBLzhE6rOtD/3oWOZS3KK
         ztg58hrGr9rvOlUAb81TmG2PYhMjleoc++dxzMf8IB7R04WW6neeewzErom3RSBIYlgK
         J8MkPNZb5X+XpvTjKr//jwgKur5FJgAY78FpUagloI6gSUv+szDRJ9gZUFm49XklzxTX
         5AjA==
X-Forwarded-Encrypted: i=1; AJvYcCXCnilSgq5gSrDnHzJ5LKxIDIMNIwEp0RHDICRCKdn6A/JjM0uzDtwdADIuAe35RXcx0+NWLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNFZw1fKW7RYkWg3YdRF4GK+6JCKS0jxckaTBQjdDsxC3+/Xek
	cX9RYTOmVNCrBpwNY0okkYKSVpRPPfVUi5aua3B7NxtOYigA3VzMh3vhRYcMMGn1GNQVYBSJpPu
	hf3Z1LN4Xg4jwaU7nm5mRP07ihQI=
X-Gm-Gg: ASbGncvGoWJRr2Mk0Lx+f5aUH9rj0KguVxrwYtOkyWOcc2kJZ1Gm+/iSUcWElIgo/lD
	OhPeoUvY6PPzyH/klxORXVBiFjFUl4j1ginmF8rBaywIc55ATgBbRXRxyQCT4oA==
X-Google-Smtp-Source: AGHT+IE6wDTpl4P3rhaUL73igzu8F5reTb8UP7PyzKCfU47jXhpJZ3hUhL5iPh8mtwewugxaFzRiTkQiyUpsK9pZ+OA=
X-Received: by 2002:a05:6602:6b8c:b0:835:4931:b110 with SMTP id
 ca18e2360f4ac-8447e21faa8mr518775739f.5.1733498347943; Fri, 06 Dec 2024
 07:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241114160721.1527934-1-quic_bibekkum@quicinc.com>
 <20241114160721.1527934-4-quic_bibekkum@quicinc.com> <CAF6AEGuwWsAkRyF-h5Aj3KzM7iksb12HsfJ5Ks+-P8hv60MWFg@mail.gmail.com>
 <CAF6AEGvVteuOOMod6yw9_6eOn2PxAx+BR8sVOHAHp7Ts8XigBw@mail.gmail.com>
 <5696afa2-c4ab-42fe-b29a-6ecee622fbb4@quicinc.com> <CAF6AEGuMmdnOmATMy8f+YgGxfrYb5mkG_qgy870wZPebKaZjVQ@mail.gmail.com>
 <04da6036-56c4-4b8c-b75b-b5e96a089efc@quicinc.com> <CAF6AEGt-e_4kGyfiO=_oCLX8E3z76zeZ2MbRe1GicZj4hTEu+g@mail.gmail.com>
 <808e1041-0d61-4ee8-9778-0f9b7d0fb719@quicinc.com>
In-Reply-To: <808e1041-0d61-4ee8-9778-0f9b7d0fb719@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 6 Dec 2024 07:18:56 -0800
Message-ID: <CAF6AEGtyc+_2V6qoZCwvRQ_QcC+uCXFXcWRpsQemEfd+rC6R+A@mail.gmail.com>
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

On Fri, Dec 6, 2024 at 4:36=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 12/4/2024 8:54 PM, Rob Clark wrote:
> > On Wed, Dec 4, 2024 at 3:28=E2=80=AFAM Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 11/22/2024 10:04 PM, Rob Clark wrote:
> >>> On Fri, Nov 22, 2024 at 8:20=E2=80=AFAM Bibek Kumar Patro
> >>> <quic_bibekkum@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 11/21/2024 3:40 AM, Rob Clark wrote:
> >>>>> On Wed, Nov 20, 2024 at 9:17=E2=80=AFAM Rob Clark <robdclark@gmail.=
com> wrote:
> >>>>>>
> >>>>>> On Thu, Nov 14, 2024 at 8:10=E2=80=AFAM Bibek Kumar Patro
> >>>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>>
> >>>>>>> Add an adreno-smmu-priv interface for drm/msm to call
> >>>>>>> into arm-smmu-qcom and initiate the PRR bit setup or reset
> >>>>>>> sequence as per request.
> >>>>>>>
> >>>>>>> This will be used by GPU to setup the PRR bit and related
> >>>>>>> configuration registers through adreno-smmu private
> >>>>>>> interface instead of directly poking the smmu hardware.
> >>>>>>>
> >>>>>>> Suggested-by: Rob Clark <robdclark@gmail.com>
> >>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>>>>> ---
> >>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 37 +++++++++++++=
+++++++++
> >>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
> >>>>>>>     include/linux/adreno-smmu-priv.h           | 14 ++++++++
> >>>>>>>     3 files changed, 53 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers=
/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>> index d26f5aea248e..0e4f3fbda961 100644
> >>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>> @@ -16,6 +16,8 @@
> >>>>>>>
> >>>>>>>     #define QCOM_DUMMY_VAL -1
> >>>>>>>
> >>>>>>> +#define GFX_ACTLR_PRR          (1 << 5)
> >>>>>>> +
> >>>>>>>     static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device =
*smmu)
> >>>>>>>     {
> >>>>>>>            return container_of(smmu, struct qcom_smmu, smmu);
> >>>>>>> @@ -99,6 +101,32 @@ static void qcom_adreno_smmu_resume_translati=
on(const void *cookie, bool termina
> >>>>>>>            arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME=
, reg);
> >>>>>>>     }
> >>>>>>>
> >>>>>>> +static void qcom_adreno_smmu_set_prr_bit(const void *cookie, boo=
l set)
> >>>>>>> +{
> >>>>>>> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> >>>>>>> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >>>>>>> +       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> >>>>>>> +       u32 reg =3D 0;
> >>>>>>> +
> >>>>>>> +       reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_A=
CTLR);
> >>>>>>> +       reg &=3D ~GFX_ACTLR_PRR;
> >>>>>>> +       if (set)
> >>>>>>> +               reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> >>>>>>> +       arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, re=
g);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void qcom_adreno_smmu_set_prr_addr(const void *cookie, ph=
ys_addr_t page_addr)
> >>>>>>> +{
> >>>>>>> +       struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> >>>>>>> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >>>>>>> +
> >>>>>>> +       writel_relaxed(lower_32_bits(page_addr),
> >>>>>>> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG=
_LADDR);
> >>>>>>> +
> >>>>>>> +       writel_relaxed(upper_32_bits(page_addr),
> >>>>>>> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG=
_UADDR);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>     #define QCOM_ADRENO_SMMU_GPU_SID 0
> >>>>>>>
> >>>>>>>     static bool qcom_adreno_smmu_is_gpu_device(struct device *dev=
)
> >>>>>>> @@ -210,6 +238,7 @@ static bool qcom_adreno_can_do_ttbr1(struct a=
rm_smmu_device *smmu)
> >>>>>>>     static int qcom_adreno_smmu_init_context(struct arm_smmu_doma=
in *smmu_domain,
> >>>>>>>                    struct io_pgtable_cfg *pgtbl_cfg, struct devic=
e *dev)
> >>>>>>>     {
> >>>>>>> +       const struct device_node *np =3D smmu_domain->smmu->dev->=
of_node;
> >>>>>>>            struct adreno_smmu_priv *priv;
> >>>>>>>
> >>>>>>>            smmu_domain->cfg.flush_walk_prefer_tlbiasid =3D true;
> >>>>>>> @@ -239,6 +268,14 @@ static int qcom_adreno_smmu_init_context(str=
uct arm_smmu_domain *smmu_domain,
> >>>>>>>            priv->get_fault_info =3D qcom_adreno_smmu_get_fault_in=
fo;
> >>>>>>>            priv->set_stall =3D qcom_adreno_smmu_set_stall;
> >>>>>>>            priv->resume_translation =3D qcom_adreno_smmu_resume_t=
ranslation;
> >>>>>>> +       priv->set_prr_bit =3D NULL;
> >>>>>>> +       priv->set_prr_addr =3D NULL;
> >>>>>>> +
> >>>>>>> +       if (of_device_is_compatible(np, "qcom,smmu-500") &&
> >>>>>>> +                       of_device_is_compatible(np, "qcom,adreno-=
smmu")) {
> >>>>>>
> >>>>>> fwiw, it seems like PRR actually works on sc7180, which is _not_
> >>>>>> mmu-500, so I guess the support actually goes back further.
> >>>>>>
> >>>>>> I'm curious if we can just rely on this being supported by any hw =
that
> >>>>>> has a6xx or newer?
> >>>>>
> >>>>>
> >>>>> Also, unrelated, but we can't assume the smmu is powered when drm
> >>>>> driver calls set_prr_bit/addr, could you add in runpm get/put aroun=
d
> >>>>> the register access?
> >>>>>
> >>>>
> >>>> I see, thanks for this observation.
> >>>> It's surely a possible case, when they access these registers
> >>>> SMMU state is off.
> >>>> I will add the suggested runpm ops around the register access.
> >>>>
> >>>>> Otherwise Conner and I have vk sparse residency working now
> >>>>>
> >>>>
> >>>> Sorry, could not get this. Did you mean that vk sparse residency
> >>>> is working now using this patch?
> >>>
> >>> Yes, vk sparse residency is working with this patch (plus addition of
> >>> runpm get/put, plus drm/msm patches plus turnip patches) ;-)
> >>>
> >>
> >> Thanks for testing the sparse residency feature with our patch Rob,
> >> I have an additional query regarding the adreno private interfaces.
> >> Specifically, I was referring to other interfaces such as
> >> qcom_adreno_smmu_get_fault_info [1]. It appears that we do not have a
> >> runpm get/put around the register access in this context.
> >
> > get_fault_info() is called from the iommu fault handler callback, so
> > from the fault irq handler, which is why it didn't need the runpm
> > get/put.  Maybe it is bad to make this assumption about usage, but
> > then again adreno_smmu_priv isn't really a general purpose interface.
> >
>
> Ah okay, got it.
> I was just going through all the adreno_smmmu_priv interfaces just
> to get a better understanding of it's interaction with smmu and it seems
> like apart from PRR and get_fault_info(), set_ttbr0_cfg(),
> resume_translation() is also having reg access but not voting.
> Should we put runpm_put/get here as well or these can be excluded.
> <Just curious about the thought process behind this, is it because of
> some sequence when to put a vote, like reg access in middle of smmu
> power cycle and not in beginning or end.>

I think we just haven't needed it, or noticed that we needed it,
outside of setting up prr.

As I mentioned, get_fault_info() is called from the fault irq, so we
know the smmu is already powered.

As far as set_ttbr0_cfg(), it probably works just because
arm_smmu_write_context_bank() ends up getting called again in the
resume path, so if the smmu is suspended when set_ttbr0_cfg() is
called, the writes just get ignored.  But the updated cfg is
re-applied to the hw when it is resumed.  Probably the same situation
with resume_translation().. ie. if the smmu is suspended there are no
translations to resume.

Maybe it would be more correct in set_ttbr0_cfg() and
resume_translation() to do a pm_runtime_get_if_in_use() and skip the
hw writes if the smmu is suspended.

>
> >> Could you please clarify whether we need an SMMU vote around register
> >> access in the case of PRR? IMO, should the users of this callback ensu=
re
> >> they put a vote before accessing the cb?
> >
> > How can drm vote for the smmu device?  I guess it could power up
> > itself and rely on device-link.. but that is pretty overkill to power
> > up the entire gpu in this case.  I think it is best for the vote to
> > happen in the PRR callbacks.
> >
>
> Okay I see, GPU can only power itself up through <gpu_state_get I
> assume> but won't have exclusive access to power on the smmu only.
>
> Incase we go forward to put vote in PRR callback for SMMU, I was
> planning that we can refactor existing arm_smmu_rpm_put/get() from
> arm_smmu.c to it's header file so that the same can be used in
> arm_smmu_qcom.c ? What's your thoughts on this?

I had briefly thought of doing the same.  But the main reason for
those helpers is common arm-smmu code that is used on non-qcom
platforms where runpm is not enabled.  In arm-smmu-qcom.c, we know
that runpm is enabled, so we could just use  return
pm_runtime_resume_and_get()/pm_runtime_put_autosuspend() directly.

BR,
-R

> Thanks & regards,
> Bibek
>
> > BR,
> > -R
> >
> >> [1]:
> >> https://lore.kernel.org/all/20210610214431.539029-1-robdclark@gmail.co=
m/
> >>
> >> Thanks & regards,
> >> Bibek
> >>
> >>> BR,
> >>> -R
> >>>
> >>>> Thanks & regards,
> >>>> Bibek
> >>>>
> >>>>> BR,
> >>>>> -R
> >>>>>
> >>>>>>
> >>>>>>> +               priv->set_prr_bit =3D qcom_adreno_smmu_set_prr_bi=
t;
> >>>>>>> +               priv->set_prr_addr =3D qcom_adreno_smmu_set_prr_a=
ddr;
> >>>>>>> +       }
> >>>>>>>
> >>>>>>>            return 0;
> >>>>>>>     }
> >>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iomm=
u/arm/arm-smmu/arm-smmu.h
> >>>>>>> index e2aeb511ae90..2dbf3243b5ad 100644
> >>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>>>>>> @@ -154,6 +154,8 @@ enum arm_smmu_cbar_type {
> >>>>>>>     #define ARM_SMMU_SCTLR_M               BIT(0)
> >>>>>>>
> >>>>>>>     #define ARM_SMMU_CB_ACTLR              0x4
> >>>>>>> +#define ARM_SMMU_GFX_PRR_CFG_LADDR     0x6008
> >>>>>>> +#define ARM_SMMU_GFX_PRR_CFG_UADDR     0x600C
> >>>>>>>
> >>>>>>>     #define ARM_SMMU_CB_RESUME             0x8
> >>>>>>>     #define ARM_SMMU_RESUME_TERMINATE      BIT(0)
> >>>>>>> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adr=
eno-smmu-priv.h
> >>>>>>> index c637e0997f6d..614665153b3e 100644
> >>>>>>> --- a/include/linux/adreno-smmu-priv.h
> >>>>>>> +++ b/include/linux/adreno-smmu-priv.h
> >>>>>>> @@ -50,6 +50,18 @@ struct adreno_smmu_fault_info {
> >>>>>>>      *                 the GPU driver must call resume_translatio=
n()
> >>>>>>>      * @resume_translation: Resume translation after a fault
> >>>>>>>      *
> >>>>>>> + * *CAUTION* : PRR callbacks (set_prr_bit/set_prr_addr) are NULL=
 terminated for
> >>>>>>> + *             targets without PRR support. Exercise caution and=
 verify target
> >>>>>>> + *             capabilities before invoking these callbacks to p=
revent potential
> >>>>>>> + *             runtime errors or unexpected behavior.
> >>>>>>> + *
> >>>>>>> + * @set_prr_bit:   Extendible interface to be used by GPU to mod=
ify the
> >>>>>>> + *                ACTLR register bits, currently used to configu=
re
> >>>>>>> + *                Partially-Resident-Region (PRR) bit for featur=
e's
> >>>>>>> + *                setup and reset sequence as requested.
> >>>>>>> + * @set_prr_addr:  Configure the PRR_CFG_*ADDR register with the
> >>>>>>> + *                physical address of PRR page passed from
> >>>>>>> + *                GPU driver.
> >>>>>>>      *
> >>>>>>>      * The GPU driver (drm/msm) and adreno-smmu work together for=
 controlling
> >>>>>>>      * the GPU's SMMU instance.  This is by necessity, as the GPU=
 is directly
> >>>>>>> @@ -67,6 +79,8 @@ struct adreno_smmu_priv {
> >>>>>>>         void (*get_fault_info)(const void *cookie, struct adreno_=
smmu_fault_info *info);
> >>>>>>>         void (*set_stall)(const void *cookie, bool enabled);
> >>>>>>>         void (*resume_translation)(const void *cookie, bool termi=
nate);
> >>>>>>> +    void (*set_prr_bit)(const void *cookie, bool set);
> >>>>>>> +    void (*set_prr_addr)(const void *cookie, phys_addr_t page_ad=
dr);
> >>>>>>>     };
> >>>>>>>
> >>>>>>>     #endif /* __ADRENO_SMMU_PRIV_H */
> >>>>>>> --
> >>>>>>> 2.34.1
> >>>>>>>
> >>>>
> >>
>
