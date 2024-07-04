Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23B1AC230
	for <iommu@lists.linux.dev>; Thu,  4 Jul 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092375; cv=none; b=YDP4dzyNLMdiqJEcgKajNK1K42L82Jg184j4E+tyXKEmLdFbSdHyZfGNJ5nLhLyt8Xa1Q8EsKtyywWKNp1n/r+PcCxb3BIeDCmudf/evXYyHl/OdNcd3uMbntieD1LUSgEJsJAvfzU9OnPDJ6aCwzqxHtcX+DDEQjJFSzs3im6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092375; c=relaxed/simple;
	bh=Dg3JTq0ZBWP2D2Vr8U1r3aGFATnfejdOWc8Xk9rIx4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LN1yDEmpmjHzizucX/OsD9DeiAWCbROeq02oP+tqS5nEy62ai2qXPeI8uO/lsz/tt1p2mLVdroQ3H9Hv54nWt18b3BP5FenhjUcg4xja4fnu6DjDjHoZilTP0BjGIX4u3R2HLQiuDTF4CY5rGejk5OzTgGw1qhG4R7nh8oNGM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J7Sa/Knn; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7Sa/Knn"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-64f4c11d2c9so4701227b3.2
        for <iommu@lists.linux.dev>; Thu, 04 Jul 2024 04:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720092373; x=1720697173; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz4auga2ihI3UY4J8JDbIVFDxmJf4jQfyvh3R1LfKJQ=;
        b=J7Sa/Knnwk26SD9m3cRRhlIvP91NPQfeUksmZtaBJfMwPJK0pSvS3Q/VLKUgbPuPjs
         NzF5bnqtmAg1PPG3ctq3fkMvQPwat+Fj6frrJlUc9XBh+e/e4OAb78cfZhrxC8Agt6nx
         Mdy4HMCbu4NuSAxITfgwr4ZzILQoNy9W37GloCkn8nGI6xMqC0RE4SSnskl5Qiv8MuYS
         g49rmm2XDWM996UWTU1w/PsVTsuUItBuF2ZgZhi3s0LBoYXEYDx2vqW7UOhOFSB7LOeV
         BEIV2pW5jnR2LpsNOQDpKGeolfcrLeBZjAvGNURFyQVc9CYJwjov0+a+/RUiZDcEl6G9
         QgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720092373; x=1720697173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz4auga2ihI3UY4J8JDbIVFDxmJf4jQfyvh3R1LfKJQ=;
        b=pm/HT2x7xNue4nEotVObZrAvTuhACmDL2CwU+1yDqhaNAct4QdD43iqU6ASOfTK3xC
         J43DAZUzxI8ws1SECFHiZU68Q3YhttFDAq39383A355x2MVdG/zqBXMqR97b/tLPFAv8
         kMsxtMUhcFaIsO0AFdT4974ZjD77pncTiAKHY9+9MEKmZ6WYqXjDy0w9MoopdzBAFJOY
         HbN9TWERcZd2NpgE7Nm+BMKnXoXLL4FT+ozX9Fm590dDQ5uWd/ymapw1iUAXVX7CiyTp
         B1TpDXrniN34Iew+4FBo/jhsDvSrZPgay7hHZl/KhyiZjfxhIUp01Eu5s0H9Td0hPZt0
         c+1w==
X-Forwarded-Encrypted: i=1; AJvYcCUR9Ho4PGKLgDrmVMGP7gBpwkltbqvGt4zjJYonzvjXCVpb9+2RHds+XZvOM/yzWjbSwA6BH1S/ZwU0SwKoSMwRqGHXcv4=
X-Gm-Message-State: AOJu0YyHJRZP00KkXjGkqVGnQaZKX5oMw/8LKbOxm2tBaTuMAttkj7V9
	FkRtPIh2/0H/a/dZxkFLkTtdC04x0Iib7SlwRuKNdIbvoq6msR173T5is67RE8i9XWzCM7PMYT6
	iS8Hc5G8/j2sL/++J99q6Mqr3IanAS2yhm+2Q4w==
X-Google-Smtp-Source: AGHT+IGUuy8LiMm7CRx7RcUn3ERP1YBHOTaS7EuRnYAtXbHY8JFSwXprjEPPOPd0GIcSCtt0Mrw7VgCiJ21+Ale1Jug=
X-Received: by 2002:a05:690c:6801:b0:62c:f82b:553f with SMTP id
 00721157ae682-652d62e4a62mr15119967b3.31.1720092372647; Thu, 04 Jul 2024
 04:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
 <20240628140435.1652374-5-quic_bibekkum@quicinc.com> <ueuhu5xfzp2rnuxzeqqd6cho476adidztgx7oq2tbiufauv6h4@obblpxvqwnno>
 <6da77880-2ba4-4b02-8b3e-cb0fbd0a9daf@quicinc.com> <20240703130209.GA5750@willie-the-truck>
 <6ad2e62d-8672-4b64-848a-6634d7a9410e@quicinc.com>
In-Reply-To: <6ad2e62d-8672-4b64-848a-6634d7a9410e@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 4 Jul 2024 14:26:01 +0300
Message-ID: <CAA8EJpqDFeCVEiuVM4RJoYPVjRn+PNRAYbe3RcFdDsDTj_Gkwg@mail.gmail.com>
Subject: Re: [PATCH v13 4/6] iommu/arm-smmu: add ACTLR data and support for SM8550
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: Will Deacon <will@kernel.org>, robdclark@gmail.com, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, 
	konrad.dybcio@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jul 2024 at 12:12, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 7/3/2024 6:32 PM, Will Deacon wrote:
> > On Wed, Jul 03, 2024 at 05:45:23PM +0530, Bibek Kumar Patro wrote:
> >>
> >>
> >> On 7/2/2024 12:04 AM, Dmitry Baryshkov wrote:
> >>> On Fri, Jun 28, 2024 at 07:34:33PM GMT, Bibek Kumar Patro wrote:
> >>>> Add ACTLR data table for SM8550 along with support for
> >>>> same including SM8550 specific implementation operations.
> >>>>
> >>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>> ---
> >>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89 +++++++++++++++++=
+++++
> >>>>    1 file changed, 89 insertions(+)
> >>>>
> >>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/io=
mmu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> index 77c9abffe07d..b4521471ffe9 100644
> >>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> @@ -23,6 +23,85 @@
> >>>>
> >>>>    #define CPRE                    (1 << 1)
> >>>>    #define CMTLB                   (1 << 0)
> >>>> +#define PREFETCH_SHIFT            8
> >>>> +#define PREFETCH_DEFAULT  0
> >>>> +#define PREFETCH_SHALLOW  (1 << PREFETCH_SHIFT)
> >>>> +#define PREFETCH_MODERATE (2 << PREFETCH_SHIFT)
> >>>> +#define PREFETCH_DEEP             (3 << PREFETCH_SHIFT)
> >>>> +
> >>>> +static const struct actlr_config sm8550_apps_actlr_cfg[] =3D {
> >>>> +  { 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>> +  { 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>> +  { 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
> >>>> +  { 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
> >>>> +  { 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
> >>>> +  { 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
> >>>> +  { 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> >>>
> >>> - Please keep the list sorted
> >>
> >> Sure Dmitry, will sort this list in reverse-christmas-tree order
> >> in next iteration. Thanks for this input.
> >>
> >>> - Please comment, which devices use these settings.
> >>
> >> As discussed in earlier versions of this patch, these table entries
> >> are kind of just blind values for SMMU device, where SMMU do not have
> >> idea on which SID belong to which client. During probe time when the
> >> clients' Stream-ID has corresponding ACTLR entry then the driver would
> >> set value in register.
> >
> > I'm still firmly of the opinion that this stuff needs a higher-level
> > description in the device-tree and should not be hard-coded in the driv=
er
> > like this. It's not just a list of opaque values; it describes
> > SoC-specific topological information that should not be this rigid.
> >
>
> As per my understanding since ACTLR register is an implementation
> defined register,
> so I think the placement can also depend on factor of how these
> registers are used?
>
> For Qualcomm SoCs, it stores prefetch values for each client, improving
> performance without defining hardware design.
> Even without setting this value, clients on these Stream-IDs would still
> function, albeit with reduced performance.
>
> The SteamID/Mask pair in first two columns <which is a SoC topology> is
> only used as reference to find preferred prefetch setting for the
> corresponding client on this StreamID
>
> To refer initial discussion and Robin's thoughts on device-tree approach
> for this property which we proposed as a part of RFC:
> https://lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.=
com/
>
> " On 9/18/2023 4:49 PM, Robin Murphy wrote: "
>  >
>  > At the very least this would need to be in a implementation-specific
>  > backend, since everything about ACTLR is implementation-defined; there
>  > could be bits in there that the driver needs to manage itself and
>  > clients have absolutely no business overriding (e.g. the MMU-500 errat=
a
>  > workarounds). The generic driver can't know what's valid, nor what the
>  > consequences are of not being able to satisfy a particular setting. Th=
en
>  > there's still the question of what if two clients ask for different
>  > settings but want to attach to the same context?
>  >
>  > It's also questionable whether this would belong in DT at all, since i=
t
>  > has a bit of a smell of software policv about it.
>  >
>  > If it could be
>  > sufficiently justified then it would need a proper binding proposal, a=
nd
>  > "write this opaque value into this register" type properties are
>  > generally not approved of.
>  >
>  > Thanks,
>  > Robin.
>  >
>
> So as per the initial discussions it felt right to have this data stored
> inside driver.
> One potential downside is that the driver file could become cluttered
> with this data, but this can be mitigated by storing the table in a
> separate file if necessary.
>
> For use cases or vendor that implement the ACTLR register differently,
> deeply involving SoC topology values or defining hardware design
> (something similar to Stream Matching Register),then it might be more
> appropriate to place it in the devicetree?
>
> This is just my understanding. I=E2=80=99d appreciate your further though=
ts on
> this - Will, Robin, Dmitry, Rob.

My understanding was that DT should be a place for variable
information. In this case the mapping between Stream-IDs and the
corresponding register programming is more or less fixed for a
particular Soc.
Probably the only way this can be handled outside of the driver is by
increasing #iommu-cells and encoding these values in this extra IOMMU
cell.

--=20
With best wishes
Dmitry
