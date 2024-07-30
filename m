Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B2D192B74
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329415; cv=none; b=sVnnGLP3QKe3rZnT9SSGHwuRtnfHXFBYj2ffVBPduX/udVtyWsULCVcJJE9DpZ+h6gNoTHPtSIJJPN1eD6H606Oe45XSXSRaMeefpjSpmWIvDEhFhUWW4oa9o957ryQWQ3UsHRMy3OQaJr5OEGv8rvRDH7Sz+Bf7hmAhgfPw5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329415; c=relaxed/simple;
	bh=uXUztFw01QkDqDbe0WWySrnr+7BYRZVCE4VrF++FLAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASEewLRFG9SSoHniZSbrleiFlgMQeBGHODv181cNdym+RwwTWeH24YYN1kdxunGsC/eJpmeyJ5S6A1MWbLBz9bV0g5L9dVC9IHjSQXharLYfEg3GUg6lRZZdTnJCnRLbCrjXcywgq8KhwFvj3q33JJShoz7qceF1f1XoDI533lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y859+oJb; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y859+oJb"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-66acac24443so29547597b3.1
        for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722329412; x=1722934212; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssng55bauDabcCAYBu4bB+fRXg++qWCVvTBlTDvO6F8=;
        b=y859+oJbScRMyCdpDYZ6nlrkFssmlVFP6Pj3GQFx4GjLqd0c5hMdFQT4U51JmWy8In
         R1trKm9CneWpYw5DxcXfcMrEgyf9Y61DLV5xGwclNC+wndxaZCgoBmsuSUoW24K3yxtX
         JzMXZPrnEAZt6mlZBoYpaIkwB45lvLqkizsq1a9mug05MCIYacsM/9qZ8xIjwwMwerba
         hH+K7okvTIwaDTTYzLm7jxehJol/K+mSAC0SSOs1DF53r/nA+EcurNgR0fQDwV1RQgNK
         Gibfs2/8QnR72A9LX8nPQ1CH/cFxvKuqZWAvUD+3j7jmz7fhZUmoayoMLJG4G1pCHRfj
         fYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722329412; x=1722934212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssng55bauDabcCAYBu4bB+fRXg++qWCVvTBlTDvO6F8=;
        b=gCtVSQAYFzNuDJDHl01teCCcO3i1EYgd7E8w/2hGD6wFrzV/MShI1WAu4yFouaW/ly
         Wv/744DYKfZL2XVnfzd3+4HLoM1csy85qyIO225Du46K0P5Q0u3THDGDOKWg/t1ANVlL
         6FH4xioJuS5jhZwuEAVKKoIfLX0joqJesVmv9NQ/V/S8Ar/2jljLAudDSHzv7yTSuVd2
         L9VI3Iy3BFkY1mGnlpWV6IFSXGgVGlU70jBBai1vDik7cnN1KGtSKgWigdavPTjRHWyn
         +KYdZzxyj4nn4Ocwby0ppTVl7jRG1FAXrn8s0IN3RFcDEhkaJoQnY3QrowWn+129fvut
         0WBw==
X-Forwarded-Encrypted: i=1; AJvYcCWXTnwsPd+QtkGypLYqRT9AuPv9xrQLy88U3RiXL97io6FebYkryYa4dFIndWJIAxuff2yC+5U2L33Y+eIVNxnyHs4iLe4=
X-Gm-Message-State: AOJu0YwFFX/4xLkLNeYywM6tk3e90l4qXJboKqSY9JIbWi8vhq6DnCoB
	7hY2zl/1Y0d2sVcdBSRJpxc0JqWhKgNWl48RH0qB2fWxIYArf7ncIkOMxDrHehQ4GoCqt51cHVd
	7pWnun9b3xClFH8DJu4/sOTmOEASXcqtrqKAjHw==
X-Google-Smtp-Source: AGHT+IF4zkK+9qcTrEHm26uzBQdqcNqen5+pNAcmX4VX/yw1jKxwy5wBWP+dUke1z+UX+tjIaoXTMqgAaXp37jXJLeI=
X-Received: by 2002:a81:8184:0:b0:65f:a486:5a61 with SMTP id
 00721157ae682-67a05c8a4a8mr115235097b3.10.1722329412113; Tue, 30 Jul 2024
 01:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729-topic-845_gpu_smmu-v1-1-8e372abbde41@kernel.org>
 <osxynb352ubxgcb5tv3u7mskkon23nmm3gxkfiiiqss5zp67jf@fv5d6bob2rgp>
 <CAF6AEGuWULwrJDWW37nQhByTpc-2bBYVv3b_Ac6OCwaJ83Ed9w@mail.gmail.com>
 <CAA8EJpp9zaQSKbis7J9kYTudTt=RFhfbzeayz3b-VbGQENtqeA@mail.gmail.com> <3332c732-4555-46bf-af75-aa36ce2d58df@gmail.com>
In-Reply-To: <3332c732-4555-46bf-af75-aa36ce2d58df@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Jul 2024 11:50:01 +0300
Message-ID: <CAA8EJppZsNTqh_KxD=BWXjmedA1ogeMa74cA=vVbCWAU7A-qgQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/
 16K pages
To: Konrad Dybcio <konradybcio@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 at 11:08, Konrad Dybcio <konradybcio@gmail.com> wrote:
>
> On 29.07.2024 11:21 PM, Dmitry Baryshkov wrote:
> > On Tue, 30 Jul 2024 at 00:08, Rob Clark <robdclark@gmail.com> wrote:
> >>
> >> On Mon, Jul 29, 2024 at 1:14=E2=80=AFPM Dmitry Baryshkov
> >> <dmitry.baryshkov@linaro.org> wrote:
> >>>
> >>> On Mon, Jul 29, 2024 at 10:37:48AM GMT, Konrad Dybcio wrote:
> >>>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>>
> >>>> SDM845's Adreno SMMU is unique in that it actually advertizes suppor=
t
> >>>> for 16K (and 32M) pages, which doesn't hold for newer SoCs.
> >>>>
> >>>> This however, seems either broken in the hardware implementation, th=
e
> >>>> hypervisor middleware that abstracts the SMMU, or there's a bug in t=
he
> >>>> Linux kernel somewhere down the line that nobody managed to track do=
wn.
> >>>>
> >>>> Booting SDM845 with 16K page sizes and drm/msm results in:
> >>>>
> >>>> *** gpu fault: ttbr0=3D0000000000000000 iova=3D000100000000c000 dir=
=3DREAD
> >>>> type=3DTRANSLATION source=3DCP (0,0,0,0)
> >>>>
> >>>> right after loading the firmware. The GPU then starts spitting out
> >>>> illegal intstruction errors, as it's quite obvious that it got a
> >>>> bogus pointer.
> >>>>
> >>>> Hide 16K support on SDM845's Adreno SMMU to work around this.
> >>>>
> >>>> Reported-by: Sumit Semwal <sumit.semwal@linaro.org>
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>> ---
> >>>> There's a mismatch in sender/committer addresses but that's "fine":
> >>>> https://lore.kernel.org/linux-usb/2024072734-scenic-unwilling-71ea@g=
regkh/
> >>>> ---
> >>>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 10 ++++++++++
> >>>>  1 file changed, 10 insertions(+)
> >>>>
> >>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/io=
mmu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> index 36c6b36ad4ff..d25825c05817 100644
> >>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> @@ -338,6 +338,15 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_=
device *smmu)
> >>>>       return 0;
> >>>>  }
> >>>>
> >>>> +static int qcom_adreno_smmuv2_cfg_probe(struct arm_smmu_device *smm=
u)
> >>>> +{
> >>>> +     /* SDM845 Adreno SMMU advertizes 16K pages support, but someth=
ing is broken */
> >>>> +     if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-s=
mmu-v2"))
> >>>> +             smmu->features &=3D ~ARM_SMMU_FEAT_FMT_AARCH64_16K;
> >>>
> >>> Shouldn't we hide that uncoditionally as it's likely that none of v2
> >>> Adreno SMMUs support 16k pages?
> >>
> >> Hmm, that would be unfortunate to have the GPU not supporting the CPU
> >> page size.  I guess we could still map 16k pages as multiple 4k pages,
> >> but that is a bit sad..
> >
> > For now this might be limited to older platforms (v2 vs -500)
>
> In the commit message:
>
> >>>> SDM845's Adreno SMMU is unique in that it actually advertizes suppor=
t
> >>>> for 16K (and 32M) pages, which doesn't hold for newer SoCs.

My question is about forbidding 16k pages for sdm845 only or for other
chips too. I'd assume that it shouldn't also work for other smmu-v2
platforms.

--=20
With best wishes
Dmitry
