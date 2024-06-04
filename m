Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC2213D88D
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717526969; cv=none; b=KA4lcQS3bOUhD3NzlGd4xVWtLgHwXhkdJa3j95NH+kqJCc1pOnlSbENLCN2czaIpUVmTGA7LzCk+jBmkC17lC76Cx9zHwt/tRZQOkk0tDhhUDWs1i8E3xfJ8uufAKmmPb8mBNcIEH+5agz7PSJW7hCDPmL9eh+hbC0stxMd9N24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717526969; c=relaxed/simple;
	bh=a1zun8HL6lepv1ujLISq6+xEZ0ZnO4qy/lSJiqqhavo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANWGwA2j9xAYuVLkLLKw/q9L3x4eLRgkTAMf4KXF/0ooxz2ac6iNnW7q3b7mmilrU1cBgYT3mBChyMJS5+KYKAkNLIMaxakjJsGmYoCr60FgwF4ddB0UjSz3bh2fX4PR+3vqSY9KVAloAN6x6o+lYZSZPMp0XuH/QS3tHM87xvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nksJllJi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nksJllJi"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so215481a12.1
        for <iommu@lists.linux.dev>; Tue, 04 Jun 2024 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717526966; x=1718131766; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bb27sFgRlG0Tk9BuaJtsYRuhNJ3jYbY3tEhCWfnKOSg=;
        b=nksJllJiX2xVc1gQFrSSMzqEbeyKOAT5DgYZaKspp702v9SWESuS1ZiP7QvGQYIxnS
         /EUkov8dD/w+NF+ggfAqSgRQQFJPPT+qKdmS/mzAOCHQM5/RPv3uGFb0QNyZaILpYwLx
         Zjq6C0fX2zZkajjjt65WCgx55jMl0PmLmWtWz5huU8hb77i7vLIir4xHXdl29VWEHE+m
         uQ1zMDPYBdARTTVarB+vLyQ4zXwUl1HNVnhrOD2sUNqQ/OqYh5MLTD2oyk48D/2CVT5S
         qFoDcQYc3yVKaY52cyvA7HD+Ir0PnAA8XCDngORg2cu/dw2duOGyrj0RehRzzBvVU6xh
         lZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717526966; x=1718131766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bb27sFgRlG0Tk9BuaJtsYRuhNJ3jYbY3tEhCWfnKOSg=;
        b=lXa9k3GXp1WoHia+qJCRdpZX71CW7dSgDWOdtVXMGd7w2QHMhElRYPmIY1zjH1VAsa
         ohGPUcpO1YPog3Lcb3bqhxvAV/mlC4g7O4Q3ui5AqJKH1QMuFR3yD9j4WiFucfuWbP/z
         XDqu9bhjqUd7bOyP8Jjle1WxrEIeEFd9OeawHP7STjvzjKQbhGKjJsJuni246Ti9uoQ4
         1KLtj+G3vzR3Z1ye2Ktw8xpfSh13fDYYtlMoYoRqoKFcFso9fnMxG+z37v9s9vA3CIM9
         mqUR96CUVhyXFU/qqF0Z/TMiTd7mnps0SRPhRUBUaAzDQYHD8Y3SsVA3rvDufBi2rUzy
         rCKg==
X-Forwarded-Encrypted: i=1; AJvYcCX6SConKaVl9Nvj9WKr6VVZz+CVEYB+GCPNX72Z6hd8/PQPY1RB3A4g8STPCaywovjbTzYmP1SadOEH4+6VPxqFghTzETI=
X-Gm-Message-State: AOJu0Ywmz4zRj8JA6TZLV0j/GMq06gwbwP41EHLC+7RJmdY0x/XlZ+K5
	5JGIj7VmbQ64zpdaNeIhx4VCWJ+mFRuye4vHhh817K5x9U4sa69U5eAD757fvRdaiFWW/M8usAJ
	Q+qoIMymrB1HW5KXGJvwi6KtV2Dk=
X-Google-Smtp-Source: AGHT+IFWkdL+wQ72daSRO1P7tTzDvc9m9YMF90o5MlhZaIpy3wrX/gSyeDidoV+f0/qTjEPQhAglVyN6XWP5BsXJN00=
X-Received: by 2002:a50:8a92:0:b0:574:ec3d:262a with SMTP id
 4fb4d7f45d1cf-57a8b6a4d4emr430003a12.5.1717526965479; Tue, 04 Jun 2024
 11:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-4-quic_bibekkum@quicinc.com> <CAF6AEGs3_wBNo58EbGicFoQuq8--fDohTGv1JSFgoViygLS5Lg@mail.gmail.com>
 <f2222714-1e00-424e-946d-c314d55541b8@quicinc.com> <51b2bd40-888d-4ee4-956f-c5239c5be9e9@linaro.org>
 <0a867cd1-8d99-495e-ae7e-a097fc9c00e9@quicinc.com> <7140cdb8-eda4-4dcd-b5e3-c4acdd01befb@linaro.org>
 <omswcicgc2kqd6gp4bebd43sklfs2wqyaorhfyb2wumoeo6v74@gaay3p5m46xi>
 <CAF6AEGub2b5SRw7kDUGfKQQ35VSsMkQ9LNExSkyHHczdFa2T4Q@mail.gmail.com> <9992067e-51c5-4a55-8d66-55a102a001b6@quicinc.com>
In-Reply-To: <9992067e-51c5-4a55-8d66-55a102a001b6@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 4 Jun 2024 11:49:13 -0700
Message-ID: <CAF6AEGsxKwzX6it4vipggOdGqNVzPbwMj6a0h871a=GfwUp0Cg@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jsnitsel@redhat.com, 
	quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com, 
	robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org, 
	vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 2:22=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 5/28/2024 9:38 PM, Rob Clark wrote:
> > On Tue, May 28, 2024 at 6:06=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> >>
> >> On Tue, May 28, 2024 at 02:59:51PM +0200, Konrad Dybcio wrote:
> >>>
> >>>
> >>> On 5/15/24 15:59, Bibek Kumar Patro wrote:
> >>>>
> >>>>
> >>>> On 5/10/2024 6:32 PM, Konrad Dybcio wrote:
> >>>>> On 10.05.2024 2:52 PM, Bibek Kumar Patro wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 5/1/2024 12:30 AM, Rob Clark wrote:
> >>>>>>> On Tue, Jan 23, 2024 at 7:00=E2=80=AFAM Bibek Kumar Patro
> >>>>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>>>
> >>>>>>>> Currently in Qualcomm  SoCs the default prefetch is set to 1 whi=
ch allows
> >>>>>>>> the TLB to fetch just the next page table. MMU-500 features ACTL=
R
> >>>>>>>> register which is implementation defined and is used for Qualcom=
m SoCs
> >>>>>>>> to have a custom prefetch setting enabling TLB to prefetch the n=
ext set
> >>>>>>>> of page tables accordingly allowing for faster translations.
> >>>>>>>>
> >>>>>>>> ACTLR value is unique for each SMR (Stream matching register) an=
d stored
> >>>>>>>> in a pre-populated table. This value is set to the register duri=
ng
> >>>>>>>> context bank initialisation.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>>>>>> ---
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>>> +
> >>>>>>>> +               for_each_cfg_sme(cfg, fwspec, j, idx) {
> >>>>>>>> +                       smr =3D &smmu->smrs[idx];
> >>>>>>>> +                       if (smr_is_subset(smr, id, mask)) {
> >>>>>>>> +                               arm_smmu_cb_write(smmu, cbndx, A=
RM_SMMU_CB_ACTLR,
> >>>>>>>> +                                               actlrcfg[i].actl=
r);
> >>>>>>>
> >>>>>>> So, this makes ACTLR look like kind of a FIFO.  But I'm looking a=
t
> >>>>>>> downstream kgsl's PRR thing (which we'll need to implement vulkan
> >>>>>>> sparse residency), and it appears to be wanting to set BIT(5) in =
ACTLR
> >>>>>>> to enable PRR.
> >>>>>>>
> >>>>>>>            val =3D KGSL_IOMMU_GET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACT=
LR);
> >>>>>>>            val |=3D FIELD_PREP(KGSL_IOMMU_ACTLR_PRR_ENABLE, 1);
> >>>>>>>            KGSL_IOMMU_SET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR, val)=
;
> >>>>>>>
> >>>>>>> Any idea how this works?  And does it need to be done before or a=
fter
> >>>>>>> the ACTLR programming done in this patch?
> >>>>>>>
> >>>>>>> BR,
> >>>>>>> -R
> >>>>>>>
> >>>>>>
> >>>>>> Hi Rob,
> >>>>>>
> >>>>>> Can you please help provide some more clarification on the FIFO pa=
rt? By FIFO are you referring to the storing of ACTLR data in the table?
> >>>>>>
> >>>>>> Thanks for pointing to the downstream implementation of kgsl drive=
r for
> >>>>>> the PRR bit. Since kgsl driver is already handling this PRR bit's
> >>>>>> setting, this makes setting the PRR BIT(5) by SMMU driver redundan=
t.
> >>>>>
> >>>>> The kgsl driver is not present upstream.
> >>>>>
> >>>>
> >>>> Right kgsl is not present upstream, it would be better to avoid conf=
iguring the PRR bit and can be handled by kgsl directly in downstream.
> >>>
> >>> No! Upstream is not a dumping ground to reduce your technical debt.
> >>>
> >>> There is no kgsl driver upstream, so this ought to be handled here, i=
n
> >>> the iommu driver (as poking at hardware A from driver B is usually no=
t good
> >>> practice).
> >>
> >> I'd second the request here. If another driver has to control the
> >> behaviour of another driver, please add corresponding API for that.
> >
> > We have adreno_smmu_priv for this purpose ;-)
> >
>
> Thanks Rob for pointing to this private interface structure between smmu
> and gpu. I think it's similar to what you're trying to implement here
> https://lore.kernel.org/all/CAF6AEGtm-KweFdMFvahH1pWmpOq7dW_p0Xe_13aHGWt0=
jSbg8w@mail.gmail.com/#t
> I can add an api "set_actlr_prr()" with smmu_domain cookie, page pointer
> as two parameters. This api then can be used by drm/msm driver to carry
> out the prr implementation by simply calling this.
> Would this be okay Rob,Konrad,Dmitry?
> Let me know if any other suggestions you have in mind as well regarding
> parameters and placement.

Hey Bibek, quick question.. is ACTLR preserved across a suspend/resume
cycle?  Or does it need to be reprogrammed on resume?  And same
question for these two PRR related regs:

  /* Global SMMU register offsets */
  #define KGSL_IOMMU_PRR_CFG_LADDR        0x6008
  #define KGSL_IOMMU_PRR_CFG_UADDR        0x600c

(ie. high/low 32b of the PRR page)

I was starting to type up a patch to add PRR configuration, but
depending on whether it interacts with suspend/resume, it might be
better form arm-smmu-qcom.c to just always enable and configure PRR
(including allocating a page to have an address to program into
PRR_CFG_LADDR/UADDR), and instead add an interface to return the PRR
page?  I think there is no harm in unconditionally configuring PRR for
gpu smmu.

BR,
-R

> Thanks & regards,
> Bibek
>
> > BR,
> > -R
> >
> >>>
> >>>>
> >>>>>> Thanks for bringing up this point.
> >>>>>> I will send v10 patch series removing this BIT(5) setting from the=
 ACTLR
> >>>>>> table.
> >>>>>
> >>>>> I think it's generally saner to configure the SMMU from the SMMU dr=
iver..
> >>>>
> >>>> Yes, agree on this. But since PRR bit is not directly related to SMM=
U
> >>>> configuration so I think it would be better to remove this PRR bit
> >>>> setting from SMMU driver based on my understanding.
> >>>
> >>> Why is it not related? We still don't know what it does.
> >>>
> >>> Konrad
> >>
> >> --
> >> With best wishes
> >> Dmitry
