Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E6A548E0
	for <iommu@lists.linux.dev>; Mon, 15 Jul 2024 20:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074071; cv=none; b=sMsWdoCQlHUKKBalgm3Us7GCQQ6noMPBRrhX9TJapRp6hXcS7Td6v9/RncopKOZ4r8AuLsyK+0E2hVVJOEOCzvYJ3siyAXdpl/yKoQRAgEhvbNUCajGLNVVz2XSyZbFAsd1TohMoib8ypxA/CuI/RddaVtFfuYkU4akg3Kh08to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074071; c=relaxed/simple;
	bh=smNoOR1WfG8U0nJ9uwY1nKMtiBp2xaLK64Na6SVXqlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwHvQpw1TwrcFWLflo7rHmmgR/4iFXszx24bsFLmNMrVleFLZmeKqYOe3jC1G5Q85NRu1JtJ2oc7ier5aRhG074rfSwUdR30TT8XDgRux8lCWT/G8xssRR0hGKjgmWemqPsnZffh4+eyTUU0w9lyj7Y01T252VRO8xjaAjTV8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNDc6xbX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNDc6xbX"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-595856e2332so6225642a12.1
        for <iommu@lists.linux.dev>; Mon, 15 Jul 2024 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721074066; x=1721678866; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFcPtfKIWUo+oou6jTVAoopedeIN0y6MfDYKdozdUY4=;
        b=ZNDc6xbXBESRNT4jy0K8mVnsFSfAZ7C/L+HFW9uK1ymbmvn/7NLmoiqY1r/JXsWjEt
         KgXZ2aqyQvufLEDctk/61eEkRQf46XzFQPTzkWoPSh4dzcWKzi1dj2v7QHsYf14lpglY
         RaUsplxeD8JOydGjEQhoih/hoDmTnWOE1dZp5IzXxTdbWJ2tAOanlEMFFfjhwt46IvUK
         TIa0fS57mc/4L+7GUg4s7rHPzTDQb1g8dTypn3WBM9jaMEPdpYPSYw57bBa/iwHLzgBq
         Vo/9GMZY1e8ucojgQfROlHmCEKOXaacIAoFYGyvN5GZdOchtG7jM0Gr1Yc/BAytlwl33
         iE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074066; x=1721678866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFcPtfKIWUo+oou6jTVAoopedeIN0y6MfDYKdozdUY4=;
        b=AmgUIIOtUfVW+FYpAOR4XXG3XlmZ7eyD7Shq0Xq1cVZbfCiq+00ryg7A65rQy/wI4m
         bddPvoisQu0z3OrEGxYHxA3Pdkw8FNBtIOlcxs/VXNudc/mcmcNHKm6or03u1Gbf1FI1
         8RrjOEm/8RUpfIDxzEaWCjutkKUHtspIkWO31ObTzPIKTUyrpiNbqueIcIjill10a0sw
         kQgdls6t/kAtEVnCg2IHGltGDYDiomcMcmXi91BypP55eDSr4h3s4b/dnr44dRToIegs
         N8IvleY954dUWGLXPzhjtWEAx5qEcUUbsdcCS4ftJot7Im9IoreHgpNrRVmV140XUVvl
         SmQw==
X-Forwarded-Encrypted: i=1; AJvYcCW93j5j/TMTwl/duloRYcAxG7nFBjJXQ6fSifneCdhmgLsvobGFzLyUXZ2R/VDrDDaEJTihkgJuZ1siPx+LDEaL0Wr9CUE=
X-Gm-Message-State: AOJu0YxeeMi4nDDXZzN7ezt4ZTC/Bq82rROjgimkxi0e2Va1PcAJ5AIC
	nTnarEJLfEZ3foVYmavLXTxjhzVqcQFPROWLlK28pzLLQeljmUNoeNysUzQ2a6U1plWYfAXBsmw
	4yKA3cXWIw34k1mwXdiMSy6OpkGs=
X-Google-Smtp-Source: AGHT+IF4dqWiiEvCQQPUbtuUSNGA0DiOxqxNR6ObGUUaH1SmHhMLQhxrPQsJ2kyJ8tLapSPLJttezXo6iXC6qVd49NY=
X-Received: by 2002:a05:6402:278f:b0:57c:7486:3f7d with SMTP id
 4fb4d7f45d1cf-59e97812082mr707453a12.19.1721074066441; Mon, 15 Jul 2024
 13:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
 <20240628140435.1652374-7-quic_bibekkum@quicinc.com> <CAF6AEGvroi8rJimFv95tkWmRFa5_aTpBJ7GFcRAuZpLGdSyEYQ@mail.gmail.com>
 <0650ba0a-4453-4e2d-8a76-0f396ac1999c@quicinc.com> <CAF6AEGv_9e-TDW1r0N4-db6pY_aV_EZFqrpNbATVS5Vy6+fs1g@mail.gmail.com>
 <4a5f54c7-120e-427d-8a0a-9fb83e13a72e@quicinc.com> <CAF6AEGtrtFNxDWtuADA4oOHhZJ=dJZcGaJ1XLFJt4fe4Xp=pTA@mail.gmail.com>
 <3b7c05b1-8f36-4c81-a55c-dbb467314099@quicinc.com> <CAF6AEGuRKU+DkL0-b3xdR1R45_MiiKQYRRXEXYz-xohu8rUaEQ@mail.gmail.com>
 <CAF6AEGtbw06-gOSvX9gAbi=SA801gmD3_8c5xkOU-G9g2qKptQ@mail.gmail.com>
 <9509f256-04a4-4907-98fc-148c5087d74d@quicinc.com> <CAF6AEGuLwZ0yFGWMKX-O1VjQB2M57K+CsyJ=7PCKXE=b=VsSNg@mail.gmail.com>
 <3382aaca-4ca1-46e5-a445-dcb115ff206f@quicinc.com>
In-Reply-To: <3382aaca-4ca1-46e5-a445-dcb115ff206f@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 15 Jul 2024 13:07:34 -0700
Message-ID: <CAF6AEGu0uH7GuNb3SJVk0cPDUwkYZ6NTG1ze+wmc1OjsaownwA@mail.gmail.com>
Subject: Re: [PATCH v13 6/6] iommu/arm-smmu: add support for PRR bit setup
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org, 
	konrad.dybcio@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 4:00=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 7/10/2024 10:31 PM, Rob Clark wrote:
> > On Tue, Jul 9, 2024 at 12:43=E2=80=AFPM Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 7/4/2024 9:28 PM, Rob Clark wrote:
> >>> On Thu, Jul 4, 2024 at 7:46=E2=80=AFAM Rob Clark <robdclark@gmail.com=
> wrote:
> >>>>
> >>>> On Wed, Jul 3, 2024 at 4:38=E2=80=AFAM Bibek Kumar Patro
> >>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 7/2/2024 2:01 AM, Rob Clark wrote:
> >>>>>> On Mon, Jul 1, 2024 at 4:01=E2=80=AFAM Bibek Kumar Patro
> >>>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 6/28/2024 9:14 PM, Rob Clark wrote:
> >>>>>>>> On Fri, Jun 28, 2024 at 8:10=E2=80=AFAM Bibek Kumar Patro
> >>>>>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 6/28/2024 7:47 PM, Rob Clark wrote:
> >>>>>>>>>> On Fri, Jun 28, 2024 at 7:05=E2=80=AFAM Bibek Kumar Patro
> >>>>>>>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> Add an adreno-smmu-priv interface for drm/msm to call
> >>>>>>>>>>> into arm-smmu-qcom and initiate the PRR bit setup or reset
> >>>>>>>>>>> sequence as per request.
> >>>>>>>>>>>
> >>>>>>>>>>> This will be used by GPU to setup the PRR bit and related
> >>>>>>>>>>> configuration registers through adreno-smmu private
> >>>>>>>>>>> interface instead of directly poking the smmu hardware.
> >>>>>>>>>>>
> >>>>>>>>>>> Suggested-by: Rob Clark <robdclark@gmail.com>
> >>>>>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>       drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 23 +++++++=
+++++++++++++++
> >>>>>>>>>>>       drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
> >>>>>>>>>>>       include/linux/adreno-smmu-priv.h           |  6 +++++-
> >>>>>>>>>>>       3 files changed, 30 insertions(+), 1 deletion(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/dri=
vers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>>>>> index bd101a161d04..64571a1c47b8 100644
> >>>>>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>>>>> @@ -28,6 +28,7 @@
> >>>>>>>>>>>       #define PREFETCH_SHALLOW       (1 << PREFETCH_SHIFT)
> >>>>>>>>>>>       #define PREFETCH_MODERATE      (2 << PREFETCH_SHIFT)
> >>>>>>>>>>>       #define PREFETCH_DEEP          (3 << PREFETCH_SHIFT)
> >>>>>>>>>>> +#define GFX_ACTLR_PRR          (1 << 5)
> >>>>>>>>>>>
> >>>>>>>>>>>       static const struct actlr_config sc7280_apps_actlr_cfg[=
] =3D {
> >>>>>>>>>>>              { 0x0800, 0x04e0, PREFETCH_DEFAULT | CMTLB },
> >>>>>>>>>>> @@ -235,6 +236,27 @@ static void qcom_adreno_smmu_resume_tran=
slation(const void *cookie, bool termina
> >>>>>>>>>>>              arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_=
RESUME, reg);
> >>>>>>>>>>>       }
> >>>>>>>>>>>
> >>>>>>>>>>> +static void qcom_adreno_smmu_set_prr(const void *cookie, phy=
s_addr_t page_addr, bool set)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +       struct arm_smmu_domain *smmu_domain =3D (void *)cooki=
e;
> >>>>>>>>>>> +       struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> >>>>>>>>>>> +       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >>>>>>>>>>> +       u32 reg =3D 0;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       writel_relaxed(lower_32_bits(page_addr),
> >>>>>>>>>>> +                               smmu->base + ARM_SMMU_GFX_PRR=
_CFG_LADDR);
> >>>>>>>>>>> +
> >>>>>>>>>>> +       writel_relaxed(upper_32_bits(page_addr),
> >>>>>>>>>>> +                               smmu->base + ARM_SMMU_GFX_PRR=
_CFG_UADDR);
> >>>>>>>>>>> +
> >>>>>>>>>>> +       reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_=
CB_ACTLR);
> >>>>>>>>>>> +       reg &=3D ~GFX_ACTLR_PRR;
> >>>>>>>>>>> +       if (set)
> >>>>>>>>>>> +               reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> >>>>>>>>>>> +       arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR=
, reg);
> >>>>>>>>>>> +
> >>>>>>>>>>
> >>>>>>>>>> nit, extra line
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Ack, will remove this. Thanks for pointing out.
> >>>>>>>>>
> >>>>>>>>>> Also, if you passed a `struct page *` instead, then you could =
drop the
> >>>>>>>>>> bool param, ie. passing NULL for the page would disable PRR.  =
But I
> >>>>>>>>>> can go either way if others have a strong preference for phys_=
addr_t.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Oh okay, this looks simple to reset the prr bit.
> >>>>>>>>> But since this page is allocated and is used inside gfx driver
> >>>>>>>>> before being utilized for prr bit operation, would it be safe f=
or
> >>>>>>>>> drm/gfx driver to keep a reference to this page in smmu driver?
> >>>>>>>>>
> >>>>>>>>> Since we only need the page address for configuring the
> >>>>>>>>> CFG_UADDR/CFG_LADDR registers so passed the phys_addr_t.
> >>>>>>>>
> >>>>>>>> I don't think the smmu driver needs to keep a reference to the p=
age..
> >>>>>>>> we can just say it is the responsibility of the drm driver to ca=
ll
> >>>>>>>> set_prr(NULL) before freeing the page
> >>>>>>>>
> >>>>>>>
> >>>>>>> That makes sense. If we go by this NULL page method to disable th=
e PRR,
> >>>>>>> we would have to set the address registers to reset value as well=
.
> >>>>>>>
> >>>>>>> The sequence would be like the following as per my understaning:
> >>>>>>> - Check if it's NULL page
> >>>>>>> - Set the PRR_CFG_UADDR/PRR_CFG_LADDR to reset values i.e - 0x0 f=
or
> >>>>>>>       these registers
> >>>>>>> - Reset the PRR bit in actlr register
> >>>>>>>
> >>>>>>> Similar to this snippet:
> >>>>>>>
> >>>>>>> #PRR_RESET_ADDR 0x0
> >>>>>>>
> >>>>>>> --------------
> >>>>>>> reg =3D  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR);
> >>>>>>> reg &=3D ~GFX_ACTLR_PRR;
> >>>>>>> arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
> >>>>>>>
> >>>>>>> if (!prr_page) {
> >>>>>>>            writel_relaxed(PRR_RESET_ADDR,
> >>>>>>>                            smmu->base + ARM_SMMU_GFX_PRR_CFG_LADD=
R);
> >>>>>>>            writel_relaxed(PRR_RESET_ADDR),
> >>>>>>>                             smmu->base + ARM_SMMU_GFX_PRR_CFG_UAD=
DR);
> >>>>>>>            return;
> >>>>>>> }
> >>>>>>>
> >>>>>>>
> >>>>>>> writel_relaxed(lower_32_bits(page_to_phys(prr_page)),
> >>>>>>>                    smmu->base + ARM_SMMU_GFX_PRR_CFG_LADDR);
> >>>>>>>
> >>>>>>> writel_relaxed(upper_32_bits(page_to_phys(prr_page)),
> >>>>>>>                    smmu->base + ARM_SMMU_GFX_PRR_CFG_UADDR);
> >>>>>>>
> >>>>>>> reg |=3D FIELD_PREP(GFX_ACTLR_PRR, 1);
> >>>>>>> arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
> >>>>>>> -----------------
> >>>>>>>
> >>>>>>> If looks good, will implement the same in next version.
> >>>>>>
> >>>>>> yeah, that looks like it could work..
> >>>>>>
> >>>>>> you probably don't need to zero out the PRR_CFG_*ADDR when disabli=
ng,
> >>>>>> and probably could avoid double writing ACTLR, but that is getting
> >>>>>> into bikeshedding
> >>>>>>
> >>>>>
> >>>>> Actually Rob, since you rightly pointed this out.
> >>>>> I crosschecked again on these registers.
> >>>>> PRR_CFG_*ADDR is a global register in SMMU space but
> >>>>> ACTLR register including PRR bit is a per-domain register.
> >>>>> There might also be a situation where PRR feature need to be
> >>>>> disabled or enabled separately for each domain.
> >>>>> So I think it would be cleaner to have two apis, set_prr_addr(),
> >>>>> set_prr_bit().
> >>>>> set_prr_addr() will be used only to set this PRR_CFG_*ADDR
> >>>>> register by passing a 'struct page *'
> >>>>> set_prr_bit() will be used as a switch for PRR feature,
> >>>>> where required smmu_domain will be passed along with
> >>>>> the bool value to set/reset the PRR bit depending on which this
> >>>>> feature will be enabled/disabled for the selected domain.
> >>>>
> >>>> on a related note, adreno has been using arm-smmu for a number of
> >>>> generations, I guess not all support PRR?  The drm driver will need =
to
> >>>> know whether PRR is supported (and expose that to userspace to let t=
he
> >>>> UMD know whether to expose certain extensions).  How should this wor=
k?
> >>>
> >>> So, I noticed in the x1e80100.dtsi that there is a gpu_prr_mem
> >>> reserved section..  maybe we should be connecting this to the smmu
> >>> driver in dt, and using that to detect presence of PRR?  Ie. the smmu
> >>> driver would configure PRR_CFG_*ADDR based on the reserved mem, and
> >>> the interface to drm would just be to enable/disable PRR, returning a=
n
> >>> error code if the reserved mem section isn't there.
> >>>
> >>> This simplifies the interface, and handles the question of how to
> >>> detect if PRR is supported.
> >>>
> >>> BR,
> >>> -R
> >>>
> >>
> >> As I checked gpu_prr_mem reserved mem section is not used for mobile
> >> targets hence not present for other DT only compute targets like
> >> x1e80100.dtsi has the same. PRR looks to be smmu version specific
> >> property.
> >
> > I only see it in gpu_prr_mem in x1e80100.dtsi, but not documented
> > anywhere.  I'm only assuming based on the name that it is intended to
> > be for PRR (but not sure why it is larger than 0x1000).  Are the
> > PRR_CFG_*ADDR regs programmed by the fw (and access blocked in EL1) on
> > this device?
> >
>
> As I checked, if the drm/gfx driver allocates the page for drm, then
> this reserved-memory region is not required.
>
> PRR_CFG_*ADDR regs have read and write access in EL1 only for this
> device, behavior is same as other devices as well. These are not
> programmed by fw.

If there is any device which _doesn't_ have EL1 access to these regs,
I think going the reserved memory route seems more future proof?
Otherwise we later on have to deal with two different ways to do
things.  But I'm not sure if there is any such device or risk.

BR,
-R

> > As far as other DT, we haven't enabled PRR anywhere yet.  I think it
> > would be perfectly valid to require a new reserved-memory node to
> > enable PRR.
> >
>
> As mentioned above reserved-memory region is not required if gfx/drm
> allocates the page.
>
> >> This feature is present in all the targets using SMMU-500,
> >> I am still checking for targets using versions prior to smmu-500.
> >> Then maybe we can use the smmu compatible string itself (e.g.
> >> qcom,smmu-500 && qcom,adreno-smmu) to connect to smmu driver for
> >> checking the presence of PRR ?
> >
> > If there is a clean break, such as all smmu-500 have PRR and all
> > smmu-v2 do not, then it would be reasonable to use the compat strings.
> > If not, I think we need a different way.
> >
>
> Yes, from SMMU block perspective PRR bit is present for ACTLR register
> on targets with MMU-500, so feature support is available. So I think we
> can just use the mmu-500 compatible string.
>
> Thanks & regards,
> Bibek
>
> > BR,
> > -R
> >
> >> And if the compatible string is different then we can return the
> >> error code signifying PRR feature is not supported on the particular
> >> smmu version.
> >>
> >> Thanks & regards,
> >> Bibek
> >>
> >>>> BR,
> >>>> -R
> >>>>
> >>>>> Thanks & regards,
> >>>>> Bibek
> >>>>>
> >>>>>> BR,
> >>>>>> -R
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks & regards,
> >>>>>>> Bibek
> >>>>>>>
> >>>>>>>> BR,
> >>>>>>>> -R
> >>>>>>>>
> >>>>>>>>>> Otherwise, lgtm
> >>>>>>>>>>
> >>>>>>>>>> BR,
> >>>>>>>>>> -R
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Thanks & regards,
> >>>>>>>>> Bibek
> >>>>>>>>>
> >>>>>>>>>>> +}
> >>>>>>>>>>> +
> >>>>>>>>>>>       #define QCOM_ADRENO_SMMU_GPU_SID 0
> >>>>>>>>>>>
> >>>>>>>>>>>       static bool qcom_adreno_smmu_is_gpu_device(struct devic=
e *dev)
> >>>>>>>>>>> @@ -407,6 +429,7 @@ static int qcom_adreno_smmu_init_context(=
struct arm_smmu_domain *smmu_domain,
> >>>>>>>>>>>              priv->get_fault_info =3D qcom_adreno_smmu_get_fa=
ult_info;
> >>>>>>>>>>>              priv->set_stall =3D qcom_adreno_smmu_set_stall;
> >>>>>>>>>>>              priv->resume_translation =3D qcom_adreno_smmu_re=
sume_translation;
> >>>>>>>>>>> +       priv->set_prr =3D qcom_adreno_smmu_set_prr;
> >>>>>>>>>>>
> >>>>>>>>>>>              actlrvar =3D qsmmu->data->actlrvar;
> >>>>>>>>>>>              if (!actlrvar)
> >>>>>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/=
iommu/arm/arm-smmu/arm-smmu.h
> >>>>>>>>>>> index d9c2ef8c1653..3076bef49e20 100644
> >>>>>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>>>>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>>>>>>>>>> @@ -154,6 +154,8 @@ enum arm_smmu_cbar_type {
> >>>>>>>>>>>       #define ARM_SMMU_SCTLR_M               BIT(0)
> >>>>>>>>>>>
> >>>>>>>>>>>       #define ARM_SMMU_CB_ACTLR              0x4
> >>>>>>>>>>> +#define ARM_SMMU_GFX_PRR_CFG_LADDR     0x6008
> >>>>>>>>>>> +#define ARM_SMMU_GFX_PRR_CFG_UADDR     0x600C
> >>>>>>>>>>>
> >>>>>>>>>>>       #define ARM_SMMU_CB_RESUME             0x8
> >>>>>>>>>>>       #define ARM_SMMU_RESUME_TERMINATE      BIT(0)
> >>>>>>>>>>> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux=
/adreno-smmu-priv.h
> >>>>>>>>>>> index c637e0997f6d..d6e2ca9f8d8c 100644
> >>>>>>>>>>> --- a/include/linux/adreno-smmu-priv.h
> >>>>>>>>>>> +++ b/include/linux/adreno-smmu-priv.h
> >>>>>>>>>>> @@ -49,7 +49,10 @@ struct adreno_smmu_fault_info {
> >>>>>>>>>>>        *                 before set_ttbr0_cfg().  If stalling=
 on fault is enabled,
> >>>>>>>>>>>        *                 the GPU driver must call resume_tran=
slation()
> >>>>>>>>>>>        * @resume_translation: Resume translation after a faul=
t
> >>>>>>>>>>> - *
> >>>>>>>>>>> + * @set_prr:      Extendible interface to be used by GPU to =
modify the
> >>>>>>>>>>> + *                 ACTLR register bits, currently used to co=
nfigure
> >>>>>>>>>>> + *                 Partially-Resident-Region (PRR) feature's
> >>>>>>>>>>> + *                 setup and reset sequence as requested.
> >>>>>>>>>>>        *
> >>>>>>>>>>>        * The GPU driver (drm/msm) and adreno-smmu work togeth=
er for controlling
> >>>>>>>>>>>        * the GPU's SMMU instance.  This is by necessity, as t=
he GPU is directly
> >>>>>>>>>>> @@ -67,6 +70,7 @@ struct adreno_smmu_priv {
> >>>>>>>>>>>           void (*get_fault_info)(const void *cookie, struct a=
dreno_smmu_fault_info *info);
> >>>>>>>>>>>           void (*set_stall)(const void *cookie, bool enabled)=
;
> >>>>>>>>>>>           void (*resume_translation)(const void *cookie, bool=
 terminate);
> >>>>>>>>>>> +    void (*set_prr)(const void *cookie, phys_addr_t page_add=
r, bool set);
> >>>>>>>>>>>       };
> >>>>>>>>>>>
> >>>>>>>>>>>       #endif /* __ADRENO_SMMU_PRIV_H */
> >>>>>>>>>>> --
> >>>>>>>>>>> 2.34.1
> >>>>>>>>>>>
