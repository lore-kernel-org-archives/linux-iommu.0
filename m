Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA717333E
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912560; cv=none; b=HxE7t4GBLeEQFS+5tXzaxNZs1DxbFP2q8b4coFRMNHm0bmU+tngtARLQZSGKXxC8zWmsRqra30bZ/bt4Anl7gQTJnc9iUIxjCX2D86tizf5gIAXVec+Z+VDhoUgmUhzZPTM/0RSUYZVEGCBX4NBCXKutJBapIxqJKlp5DCUvYM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912560; c=relaxed/simple;
	bh=bDYuIgQuv3MhFs8SVJuTlfnd4RnjBYwOgR5EG+5wd58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAHnoSGHqZAuEOQVoebMFVHERI1T3mwoq/jGXxWN8ExR0C5b68IgcMGlRYlppuALwL8Js9LYIceYK/gUH9Vv1FgQGMNF0jzZhOR2WCmFVAQpfulcmrRP+B55Aqv/7/ievNcocaHo4ONh0u1xi2EwGAtYineEm/uTDmFK6eVE+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u8MgjVk5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8MgjVk5"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f966840af7so860964b3a.2
        for <iommu@lists.linux.dev>; Tue, 28 May 2024 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716912558; x=1717517358; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/T5d6c9CKWOo6KiywfsZr/KUsXoqKTqM2ZtZzV03hwQ=;
        b=u8MgjVk5luMChFeas8ARHBp6ArSiGF8zytYMRozX/gpjdbIZkITx6a31N/ooblJ9br
         zD/auu9gokhXRqjMBCPLr9yFGdrHZwqYMpQNVMVhU9iGnfMcYVaq3810mvzcnYIfgISZ
         IuTdA8XXsnZ82cNxyBnSRPa1cNIAGaQ+UroxZNjA4cvF8Nms6Y1Nuwqw1eT9PnUSJDtV
         RCvnJkMvNNWvHU3Ozz8teTzlOfjE9KxMu+/Yr0xD6x8Og7YB/I62Dlqc8Dft+BZyIbUJ
         GqJZPlVI9WQZ7K0FVTOtgomcAqPhtxLSBo8Ex2rz1vgQAqkVRpc4XyprE93awJDSPj5D
         JMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716912558; x=1717517358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/T5d6c9CKWOo6KiywfsZr/KUsXoqKTqM2ZtZzV03hwQ=;
        b=Vc8R6879GYTrPy5BANfOpnAo789WeqmFBAu7stGidrCqpx0AJhK2yjTMI6sSdmBfLq
         lt1mXsWTc8s3aKcgG+DLmw9w90tSmAIe4tznxsQoAC46E3cqpbamDfHm2N++aqgY8dLT
         R2Cq0uW0dIcGKkDk0zJV23JT/6Phdvd6e8QM67Xe4uhdWJmpjA1/MYV2ljBGBGsUnK7Y
         t3On9riefEy8Ec/8UvXTkmV2iIART4B0Gf1p6LEVSifRENsX8NMoObzS4/2u6eUJao63
         ssKqkA79fD/bAOB7I3buSWSdB7RxoWMPjSWiWNhcguP4FXXYnrH8tzVwPtleJZUrrPwb
         ZVtw==
X-Forwarded-Encrypted: i=1; AJvYcCXalsdw55MdIwg+5BJwPEvWcz5w/i9puVhjADefV3QkTnfpnv3+z+ld4bhledXoStIarRNW0d059oY0RCNoJdRWQ01aDfU=
X-Gm-Message-State: AOJu0Yy8Fr8hurErxcPuzCluNwStW8+puVDygpsVfQOU9Vecybb8VReN
	MeVO4bbN3l/4lOVp9LYnqotuHzrcLcdN4I5WR9pSjmICy8rpyHy48ZhKwjVKAd7eW5bh36mO5Ui
	3v36r5UKu3MSYZxjX6TeIEuW5QQumDBTDAinumw==
X-Google-Smtp-Source: AGHT+IF7Y4UTjK7B9c7gQCgmKZJrzKmO7YzaO50rJedO1tvD04WxzrFxX+TEhHVj+99gHywgOVea6bGHRNcMFkS6QhE=
X-Received: by 2002:a17:902:d492:b0:1f4:a057:f927 with SMTP id
 d9443c01a7336-1f4a058014cmr62152365ad.45.1716912557839; Tue, 28 May 2024
 09:09:17 -0700 (PDT)
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
 <omswcicgc2kqd6gp4bebd43sklfs2wqyaorhfyb2wumoeo6v74@gaay3p5m46xi> <CAF6AEGub2b5SRw7kDUGfKQQ35VSsMkQ9LNExSkyHHczdFa2T4Q@mail.gmail.com>
In-Reply-To: <CAF6AEGub2b5SRw7kDUGfKQQ35VSsMkQ9LNExSkyHHczdFa2T4Q@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 19:09:04 +0300
Message-ID: <CAA8EJprW8fTf0tWDWq+aVVauJnK0NqBke-JNELm_GMPvoWa7vA@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Rob Clark <robdclark@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, jsnitsel@redhat.com, 
	quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com, 
	robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org, 
	vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2024 at 19:08, Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, May 28, 2024 at 6:06=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, May 28, 2024 at 02:59:51PM +0200, Konrad Dybcio wrote:
> > >
> > >
> > > On 5/15/24 15:59, Bibek Kumar Patro wrote:
> > > >
> > > >
> > > > On 5/10/2024 6:32 PM, Konrad Dybcio wrote:
> > > > > On 10.05.2024 2:52 PM, Bibek Kumar Patro wrote:
> > > > > >
> > > > > >
> > > > > > On 5/1/2024 12:30 AM, Rob Clark wrote:
> > > > > > > On Tue, Jan 23, 2024 at 7:00=E2=80=AFAM Bibek Kumar Patro
> > > > > > > <quic_bibekkum@quicinc.com> wrote:
> > > > > > > >
> > > > > > > > Currently in Qualcomm  SoCs the default prefetch is set to =
1 which allows
> > > > > > > > the TLB to fetch just the next page table. MMU-500 features=
 ACTLR
> > > > > > > > register which is implementation defined and is used for Qu=
alcomm SoCs
> > > > > > > > to have a custom prefetch setting enabling TLB to prefetch =
the next set
> > > > > > > > of page tables accordingly allowing for faster translations=
.
> > > > > > > >
> > > > > > > > ACTLR value is unique for each SMR (Stream matching registe=
r) and stored
> > > > > > > > in a pre-populated table. This value is set to the register=
 during
> > > > > > > > context bank initialisation.
> > > > > > > >
> > > > > > > > Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com=
>
> > > > > > > > ---
> > > > >
> > > > > [...]
> > > > >
> > > > > > > > +
> > > > > > > > +               for_each_cfg_sme(cfg, fwspec, j, idx) {
> > > > > > > > +                       smr =3D &smmu->smrs[idx];
> > > > > > > > +                       if (smr_is_subset(smr, id, mask)) {
> > > > > > > > +                               arm_smmu_cb_write(smmu, cbn=
dx, ARM_SMMU_CB_ACTLR,
> > > > > > > > +                                               actlrcfg[i]=
.actlr);
> > > > > > >
> > > > > > > So, this makes ACTLR look like kind of a FIFO.  But I'm looki=
ng at
> > > > > > > downstream kgsl's PRR thing (which we'll need to implement vu=
lkan
> > > > > > > sparse residency), and it appears to be wanting to set BIT(5)=
 in ACTLR
> > > > > > > to enable PRR.
> > > > > > >
> > > > > > >           val =3D KGSL_IOMMU_GET_CTX_REG(ctx, KGSL_IOMMU_CTX_=
ACTLR);
> > > > > > >           val |=3D FIELD_PREP(KGSL_IOMMU_ACTLR_PRR_ENABLE, 1)=
;
> > > > > > >           KGSL_IOMMU_SET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR, v=
al);
> > > > > > >
> > > > > > > Any idea how this works?  And does it need to be done before =
or after
> > > > > > > the ACTLR programming done in this patch?
> > > > > > >
> > > > > > > BR,
> > > > > > > -R
> > > > > > >
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > Can you please help provide some more clarification on the FIFO=
 part? By FIFO are you referring to the storing of ACTLR data in the table?
> > > > > >
> > > > > > Thanks for pointing to the downstream implementation of kgsl dr=
iver for
> > > > > > the PRR bit. Since kgsl driver is already handling this PRR bit=
's
> > > > > > setting, this makes setting the PRR BIT(5) by SMMU driver redun=
dant.
> > > > >
> > > > > The kgsl driver is not present upstream.
> > > > >
> > > >
> > > > Right kgsl is not present upstream, it would be better to avoid con=
figuring the PRR bit and can be handled by kgsl directly in downstream.
> > >
> > > No! Upstream is not a dumping ground to reduce your technical debt.
> > >
> > > There is no kgsl driver upstream, so this ought to be handled here, i=
n
> > > the iommu driver (as poking at hardware A from driver B is usually no=
t good
> > > practice).
> >
> > I'd second the request here. If another driver has to control the
> > behaviour of another driver, please add corresponding API for that.
>
> We have adreno_smmu_priv for this purpose ;-)

Exactly

>
> BR,
> -R
>
> > >
> > > >
> > > > > > Thanks for bringing up this point.
> > > > > > I will send v10 patch series removing this BIT(5) setting from =
the ACTLR
> > > > > > table.
> > > > >
> > > > > I think it's generally saner to configure the SMMU from the SMMU =
driver..
> > > >
> > > > Yes, agree on this. But since PRR bit is not directly related to SM=
MU
> > > > configuration so I think it would be better to remove this PRR bit
> > > > setting from SMMU driver based on my understanding.
> > >
> > > Why is it not related? We still don't know what it does.
> > >
> > > Konrad
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry
