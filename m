Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921A172799
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912522; cv=none; b=bHlqFw64FfnpRCqWZtoYPgpHHgKd4YdwHjzkbtRtYFMoXYE266U5hQi1ubkNBPYaH6sidPP1bYtBokuQV7UIsA3LlF3jRze/ki5dFN9nZwCcG3D0m/VEQ8IFMnCNCRttiLskdDH9YV3sObRMGI8S/jRvYdNFa1PhaUWZcVIk36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912522; c=relaxed/simple;
	bh=98Dp7GRPIN0v3q4FFW0kItcSjOoGd3KVZoxUHaBLd/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHbRCkWQSN/ncNu4YSIiFAcnWqpt1M31qeQxNpI1riDX9u2KN1d6P/uHyKnPKinDNwNYwqhmJmw7xO5GFzE6DZJNY2Y/Zz0K8IKh3EXicj+q/VCgvzQNwwxjJcRenHjIve75KD1/Azq9qyQ+3smebqpCJt+AfBgM66b2Od3AgTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfH9L+9r; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfH9L+9r"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5238b5c080cso1204019e87.1
        for <iommu@lists.linux.dev>; Tue, 28 May 2024 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716912517; x=1717517317; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdTwRGM/xFqjxVW5C5kGI3vl1niJryR3wCIYGtbgqIg=;
        b=kfH9L+9rWmDVruTZWqbRYJdx2loKhUvjwgJEr4EGN51sS4XRetM91+e3VTaj//3pUk
         nX4+ryBwm4/lpnstPk4emh/kXH+u6Vbj5M+ASUSR/JrIl3Mn803B3YhoHhukP+Y3Xegd
         0X0gugaXjpXuoMnNpVZzOHFijd+x97bXcCK01c6nmFY01AMqj2BmInXT7BRTXhRldtSj
         cCmDFR4nc9rCasgEaIZ1yDyc27zh7vU3ITwQcelkh4r3qGx+3UARJcwzHY6XWDoirXbj
         JJKgk39vuEhv8jTbFnWjz8oaC3bKDCuEv/F1kLpY4q2zls6VoE4V2+DhAPJxD77Uf+oB
         tNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716912517; x=1717517317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdTwRGM/xFqjxVW5C5kGI3vl1niJryR3wCIYGtbgqIg=;
        b=jyarLp1GVHI2PA8bBtlNv7DJO4fQLax1lNvhkc1eA6tXrYOJ1YpGH2P65vce9U5LLq
         V1BFy4+t8P55CmTqaRWskCL052XgwRUMLGlpAFt0XQBWFDCMxkoR+QhXbpIcRYEezfu2
         X/tCmKSaR4nlg7C/u6qXpad7/wEIFk1JBU86Pb1Ul6WZ2fcB+J7362rEvAGwqpVzltTD
         7ZxoRrVwtn82eFAPFDWgYr5BarFxhJTF++6RGa71Cc8O7Z1uPv8Xev59jxswphJ8mfHx
         Rl4vnZWU2P5OsprVk4I53lr0SXjJBg7bVZYRJe53SXNzn88ies3/h9tPLV5pLHte/2xI
         9qaw==
X-Forwarded-Encrypted: i=1; AJvYcCVbhy/epQD0YWm0MoOMb6bFjXx1qryVQYG6tBEKtITk9du9hDXmSpcy5Pw2vFygS3LY2T/YGQbgtoUg41r3bkyIO6vFGDM=
X-Gm-Message-State: AOJu0Yz98pWfRTqxWTfbFI+BC9/WrXcPBF5ECaadjZkXno/vrNWzcXnr
	T2ZJAjRSHesWNHMT4FT7GTbybKKhCAJ9b+TubfvxRRsmFR2GERiX0443BUPIAMKfm8fu5p9qDhA
	SPFyUutWuqFjbly5LVod/JpFhhs4=
X-Google-Smtp-Source: AGHT+IHkbvIXIXu+5/5Gdku0yLRzuydR2yNEkuXj2vzbrAYf44o6AovU7HmCw8vuwPdsBodoWDuNTvCqOlo+fhGDHEM=
X-Received: by 2002:a19:8c47:0:b0:529:3da2:ad01 with SMTP id
 2adb3069b0e04-5296410a314mr8054332e87.12.1716912517068; Tue, 28 May 2024
 09:08:37 -0700 (PDT)
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
In-Reply-To: <omswcicgc2kqd6gp4bebd43sklfs2wqyaorhfyb2wumoeo6v74@gaay3p5m46xi>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 28 May 2024 09:08:24 -0700
Message-ID: <CAF6AEGub2b5SRw7kDUGfKQQ35VSsMkQ9LNExSkyHHczdFa2T4Q@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, jsnitsel@redhat.com, 
	quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com, 
	robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org, 
	vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 6:06=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, May 28, 2024 at 02:59:51PM +0200, Konrad Dybcio wrote:
> >
> >
> > On 5/15/24 15:59, Bibek Kumar Patro wrote:
> > >
> > >
> > > On 5/10/2024 6:32 PM, Konrad Dybcio wrote:
> > > > On 10.05.2024 2:52 PM, Bibek Kumar Patro wrote:
> > > > >
> > > > >
> > > > > On 5/1/2024 12:30 AM, Rob Clark wrote:
> > > > > > On Tue, Jan 23, 2024 at 7:00=E2=80=AFAM Bibek Kumar Patro
> > > > > > <quic_bibekkum@quicinc.com> wrote:
> > > > > > >
> > > > > > > Currently in Qualcomm  SoCs the default prefetch is set to 1 =
which allows
> > > > > > > the TLB to fetch just the next page table. MMU-500 features A=
CTLR
> > > > > > > register which is implementation defined and is used for Qual=
comm SoCs
> > > > > > > to have a custom prefetch setting enabling TLB to prefetch th=
e next set
> > > > > > > of page tables accordingly allowing for faster translations.
> > > > > > >
> > > > > > > ACTLR value is unique for each SMR (Stream matching register)=
 and stored
> > > > > > > in a pre-populated table. This value is set to the register d=
uring
> > > > > > > context bank initialisation.
> > > > > > >
> > > > > > > Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> > > > > > > ---
> > > >
> > > > [...]
> > > >
> > > > > > > +
> > > > > > > +               for_each_cfg_sme(cfg, fwspec, j, idx) {
> > > > > > > +                       smr =3D &smmu->smrs[idx];
> > > > > > > +                       if (smr_is_subset(smr, id, mask)) {
> > > > > > > +                               arm_smmu_cb_write(smmu, cbndx=
, ARM_SMMU_CB_ACTLR,
> > > > > > > +                                               actlrcfg[i].a=
ctlr);
> > > > > >
> > > > > > So, this makes ACTLR look like kind of a FIFO.  But I'm looking=
 at
> > > > > > downstream kgsl's PRR thing (which we'll need to implement vulk=
an
> > > > > > sparse residency), and it appears to be wanting to set BIT(5) i=
n ACTLR
> > > > > > to enable PRR.
> > > > > >
> > > > > >           val =3D KGSL_IOMMU_GET_CTX_REG(ctx, KGSL_IOMMU_CTX_AC=
TLR);
> > > > > >           val |=3D FIELD_PREP(KGSL_IOMMU_ACTLR_PRR_ENABLE, 1);
> > > > > >           KGSL_IOMMU_SET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR, val=
);
> > > > > >
> > > > > > Any idea how this works?  And does it need to be done before or=
 after
> > > > > > the ACTLR programming done in this patch?
> > > > > >
> > > > > > BR,
> > > > > > -R
> > > > > >
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > Can you please help provide some more clarification on the FIFO p=
art? By FIFO are you referring to the storing of ACTLR data in the table?
> > > > >
> > > > > Thanks for pointing to the downstream implementation of kgsl driv=
er for
> > > > > the PRR bit. Since kgsl driver is already handling this PRR bit's
> > > > > setting, this makes setting the PRR BIT(5) by SMMU driver redunda=
nt.
> > > >
> > > > The kgsl driver is not present upstream.
> > > >
> > >
> > > Right kgsl is not present upstream, it would be better to avoid confi=
guring the PRR bit and can be handled by kgsl directly in downstream.
> >
> > No! Upstream is not a dumping ground to reduce your technical debt.
> >
> > There is no kgsl driver upstream, so this ought to be handled here, in
> > the iommu driver (as poking at hardware A from driver B is usually not =
good
> > practice).
>
> I'd second the request here. If another driver has to control the
> behaviour of another driver, please add corresponding API for that.

We have adreno_smmu_priv for this purpose ;-)

BR,
-R

> >
> > >
> > > > > Thanks for bringing up this point.
> > > > > I will send v10 patch series removing this BIT(5) setting from th=
e ACTLR
> > > > > table.
> > > >
> > > > I think it's generally saner to configure the SMMU from the SMMU dr=
iver..
> > >
> > > Yes, agree on this. But since PRR bit is not directly related to SMMU
> > > configuration so I think it would be better to remove this PRR bit
> > > setting from SMMU driver based on my understanding.
> >
> > Why is it not related? We still don't know what it does.
> >
> > Konrad
>
> --
> With best wishes
> Dmitry
