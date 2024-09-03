Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE81A7254
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369245; cv=none; b=lVV3GWE1J8AY25YidINIU5SoPJjO97anhiOMosFQ9wVk79qXm5mg9ottOAC+tUOO59/ZqQaEMeGwWSSmT/BR3XPSwxb3JCktXttqk1vM9NGHTwPXFq8GEcUXjWi65giDT9UVbX2f/ZJHw8S4zItv9Y8jkg72FeS/wnQmodZWKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369245; c=relaxed/simple;
	bh=osk6WofS+aFUFMMllGU0mNRzQNPp1Qatzi2MSDn6RaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdtXYY9LEKzkT9dLFCV8m4QhoBbFR4gDKuzVzzfuxVgC4kdZbtjuZiCpS7s7J0nEkOPA4slk5w/ooMvvelg+NNV81r/xL8+dM9A4KI5R1iqJQC5ZtjORD1ZPf8mQJshE/H/pNFRTPsCJx1W6kwUsB+YJe8UFEnQxiE8P9ct3cug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxMphlFg; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxMphlFg"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b5b65b1b9fso41638657b3.2
        for <iommu@lists.linux.dev>; Tue, 03 Sep 2024 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725369241; x=1725974041; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aieioXdBWwbtfxf4c7Swz7Bu9HwgmhP2hJRdgaMP0AQ=;
        b=sxMphlFgNrT18N1FEsVsB0+a+sfH4PSikaPosnkWzrgD1ebWDAqw8pHu9dSk4yPEmZ
         x+MxF0ELmdwcOoGYJv3qnALGQcdktLWAbHSvgMg4n5DFw5TBimNXFzNrKJJDJ+r65TkC
         mNZ8HwyGqZE3mH4X32PZ08XNK6n5e1fmX2Kv5SRN8xc3JWxMncyyPVBjSnpOSEPAjyMC
         q5PEaajNxEn0YV1XXp5HOM+/SwWAW6TZHf8dUu1JDwxvOEEJrVreuQf6l5aQQJXU00QP
         tig8MuPxFYbTXJVRiE7OY5WrYM8E0fwyyvtmc1hLVvyxbbyqVJbuw+NgCRYhkM8gmyHi
         m9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725369241; x=1725974041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aieioXdBWwbtfxf4c7Swz7Bu9HwgmhP2hJRdgaMP0AQ=;
        b=Bo3uQc1DMDh/t8h7zAo5g36ZXywwPAEnIYJNBMw0qFKcBv/y204z2HE0ZbXaLIx3Zt
         89yMmNkQmKq/YeWfZoY6d7KZ9lCwetVrJXWkgWl6Ztb6LOuthLvkJnHAdulMNiTZ/oBt
         vVgxtL5NVTJlv7jIySktx54+Zr6crvah3V0abb2bWZHZEwrJtrjRAJCGyUXHNTANhWan
         SxPKU7oS1kZtYz8Gx76xNf8myUIdOVgXFGkWkBakt905IudckFbHrVxpuyfCgGGLy44v
         kGpPtYmXH62SWOp5F4sMJ2kI31cZy64SwS4aAJOTI6GZ9z6oDxmuWued05nN/6qBPE97
         uMeA==
X-Forwarded-Encrypted: i=1; AJvYcCUYTSfSi1ab+xvY1y03Ab2TG4XSCFWFiJCpkplAi/s51m12Q43d34LjKz6pol3O+fNv/2Ut9A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb0Vfx7jnrOlO7RwwtNWqfl2BNLdaWdMi16pMqA3PMU2K2GrlC
	5uHW7qU/wrXgitKkpRvpTo6Wi7Lyuc88iQyEm9rZLNZoBrr6lZoHhczX4CB/heh+J3tdiGM8e9b
	H5fB55PPq9pa0lCnEXUf5BLgyuukWLRA/IHgO5w==
X-Google-Smtp-Source: AGHT+IHWGp0sSdmRKGXXhqLX/pfDauo1J5cCvK8HcPkWNkLSzA7X4J59dVMwMvto/PiVODxpuK+dgugIvQlS/8Q/gVw=
X-Received: by 2002:a05:690c:f0e:b0:6be:54e1:f1f3 with SMTP id
 00721157ae682-6d40b0f8dacmr158100417b3.0.1725369240962; Tue, 03 Sep 2024
 06:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240816174259.2056829-1-quic_bibekkum@quicinc.com>
 <20240816174259.2056829-6-quic_bibekkum@quicinc.com> <20240823155918.GD525@willie-the-truck>
 <3ae75a75-1717-40b6-9149-bc3673d520d6@quicinc.com> <20240827124714.GB4772@willie-the-truck>
 <b335452a-977e-41cc-9424-a2244fbe20de@quicinc.com> <35849d74-1197-446b-9a4c-1b8aabb38427@arm.com>
 <a882d634-85b3-4c5b-8309-348b4b3d9f0a@quicinc.com>
In-Reply-To: <a882d634-85b3-4c5b-8309-348b4b3d9f0a@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Sep 2024 16:13:50 +0300
Message-ID: <CAA8EJpo4rX=FwAwoocbys4-sv9gzPz6wwgFVyW1x4J7TU_JTgg@mail.gmail.com>
Subject: Re: [PATCH v14 5/6] iommu/arm-smmu: add ACTLR data and support for SC7280
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, robdclark@gmail.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, 
	konrad.dybcio@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sept 2024 at 15:59, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 8/30/2024 6:01 PM, Robin Murphy wrote:
> > On 30/08/2024 11:00 am, Bibek Kumar Patro wrote:
> >>
> >>
> >> On 8/27/2024 6:17 PM, Will Deacon wrote:
> >>> On Mon, Aug 26, 2024 at 04:33:24PM +0530, Bibek Kumar Patro wrote:
> >>>>
> >>>>
> >>>> On 8/23/2024 9:29 PM, Will Deacon wrote:
> >>>>> On Fri, Aug 16, 2024 at 11:12:58PM +0530, Bibek Kumar Patro wrote:
> >>>>>> Add ACTLR data table for SC7280 along with support for
> >>>>>> same including SC7280 specific implementation operations.
> >>>>>>
> >>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>>>> ---
> >>>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 58
> >>>>>> +++++++++++++++++++++-
> >>>>>>    1 file changed, 57 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>> index dc143b250704..a776c7906c76 100644
> >>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>> @@ -31,6 +31,55 @@
> >>>>>>    #define PREFETCH_MODERATE    (2 << PREFETCH_SHIFT)
> >>>>>>    #define PREFETCH_DEEP        (3 << PREFETCH_SHIFT)
> >>>>>>
> >>>>>> +static const struct actlr_config sc7280_apps_actlr_cfg[] =3D {
> >>>>>> +    { 0x0800, 0x04e0, PREFETCH_DEFAULT | CMTLB },
> >>>>>> +    { 0x0900, 0x0402, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>>>> +    { 0x0901, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>>>> +    { 0x0d01, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>>>> +    { 0x1181, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x1182, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x1183, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x1184, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x1185, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x1186, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x1187, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x1188, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x1189, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x118b, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x118c, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x118d, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x118e, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x118f, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +    { 0x2000, 0x0020, PREFETCH_DEFAULT | CMTLB },
> >>>>>> +    { 0x2040, 0x0000, PREFETCH_DEFAULT | CMTLB },
> >>>>>> +    { 0x2062, 0x0000, PREFETCH_DEFAULT | CMTLB },
> >>>>>> +    { 0x2080, 0x0020, PREFETCH_DEFAULT | CMTLB },
> >>>>>> +    { 0x20c0, 0x0020, PREFETCH_DEFAULT | CMTLB },
> >>>>>> +    { 0x2100, 0x0020, PREFETCH_DEFAULT | CMTLB },
> >>>>>> +    { 0x2140, 0x0000, PREFETCH_DEFAULT | CMTLB },
> >>>>>> +    { 0x2180, 0x0020, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>>>> +    { 0x2181, 0x0004, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>>>> +    { 0x2183, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>>>> +    { 0x2184, 0x0020, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>>>> +    { 0x2187, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>>>> +};
> >>>>>> +
> >>>>>> +static const struct actlr_config sc7280_gfx_actlr_cfg[] =3D {
> >>>>>> +    { 0x0000, 0x07ff, PREFETCH_DEEP | CPRE | CMTLB },
> >>>>>> +};
> >>>>>
> >>>>> It's Will "stuck record" Deacon here again to say that I don't thin=
k
> >>>>> this data belongs in the driver.
> >>>>>
> >>>>
> >>>> Hi Will,
> >>>>
> >>>> It will be difficult to reach a consensus here, with Robin and the
> >>>> DT folks
> >>>> okay to keep it in the driver, while you believe it doesn't belong
> >>>> there.
> >>>>
> >>>> Robin, Rob, could you please share your thoughts on concluding the
> >>>> placement
> >>>> of this prefetch data?
> >>>>
> >>>> As discussed earlier [1], the prefetch value for each client doesn=
=E2=80=99t
> >>>> define
> >>>> the hardware topology and is implementation-defined register writes
> >>>> used by
> >>>> the software driver.
> >>>
> >>> It does reflect the hardware topology though, doesn't it? Those magic
> >>> hex
> >>> masks above refer to stream ids, so the table is hard-coding the
> >>> prefetch
> >>> values for particular matches.
> >>
> >> That is correct in the sense that stream id is mapped to context bank
> >> where these configurations are applied.
> >> However the other part of it is implementation-defined register/values
> >> for which community opinion was register/value kind of data, should no=
t
> >> belong to device tree and are not generally approved of.
> >>
> >> Would also like to point out that the prefetch values are recommended
> >> settings and doesn=E2=80=99t mean these are the only configuration whi=
ch would
> >> work for the soc.
> >> So the SID-to-prefetch isn't strictly SoC defined but is a software
> >> configuration, IMO.
> >
> > What's particularly confusing is that most of the IDs encoded here don'=
t
> > actually seem to line up with what's in the respective SoC DTSIs...
> >
> > However by this point I'm wary of whether we've lost sight of *why*
> > we're doing this, and that we're deep into begging the question of
> > whether identifying devices by StreamID is the right thing to do in the
> > first place. For example, as best I can tell from a quick skim, we have
> > over 2 dozen lines of data here which all serve the exact same purpose
> > of applying PREFETCH_DEEP | CPRE | CMTLB to instances of
> > "qcom,fastrpc-compute-cb". In general it seems unlikely that the same
> > device would want wildly different prefetch settings across different
> > SoCs, or even between different instances in the same SoC, so I'm reall=
y
> > coming round to the conclusion that this data would probably be best
> > handled as an extension of the existing qcom_smmu_client_of_match
> > mechanism.
> >
>
> As per your design idea,do you mean to use qcom_smmu_client_of_match to
> identify the device using compatible string and apply the device
> specific settings for all the SoCs (instead of StreamID based device
> identification) ?
>
> something like this rough snippet(?):
>
> qcom_smmu_find_actlr_client(struct device *dev)
> {
>
>         if (of_match_device(qcom_smmu_client_of_match, dev) =3D=3D
> qcom,fastrpc-compute-cb )
>                 qcom_smmu_set_actlr_value(dev, (PREFETCH_DEEP | CPRE | CM=
TLB));
> /*where (PREFETCH_DEEP | CPRE | CMTLB) is used for compute-cb client.*/
>
>         else if (of_match_device(qcom_smmu_client_of_match, dev) =3D=3D q=
com,adreno )
>                 qcom_smmu_set_actlr_value(dev, (PREFETCH_SHALLOW | CPRE |=
 CMTLB));
> /*Where (PREFETCH_SHALLOW | CPRE | CMTLB) is for adreno client. */

I like this idea, especially once it gets converted into a per-SoC
table of compatibles.

>
> }
>
> Let me know if my understanding is incorrect.
> Then in this case if different SoC would have a different settings for
> same device, then everytime a new compatible would be necessary for same
> device on different SoC?
>
> On similar lines there is another TBU based approach which I can think
> of. Identify the TBU -> Identify clients from TopoID derived from SID
> range specified in qcom,stream-id-range -> Apply the client
> specific settings ?
>
> Both approaches would be driver-based, as they are now.
>
> Also I'd like to point out that in the current design, since we fixed
> the smr_is_subset arguments to make the stream IDs a subset of entries
> in the actlr_cfg table, we can reduce the number of entries in the
> table. This way, fewer SID-mask pairs can accommodate several stream IDs.
>
> Thanks & regards,
> Bibek
>
> > Thanks,
> > Robin.
> >
> >>
> >>> If I run on a different SoC configuration > with the same table, then
> >>> the prefetch settings will be applied to the
> >>> wrong devices. How is that not hardware topology?
> >>>
> >>
> >> The configuration table is tied to SoC compatible string however as I
> >> mentioned above, its basically a s/w recommended setting.
> >> (using prefetch settings other than the recommended values e.g
> >> PREFECH_DEFAULT instead of PREFETCH_DEEP would not render the device
> >> unusable unlike changing stream-ids which can make it unusable).
> >>
> >> Since it is implementation specific we cannot have a generic DT bindin=
g,
> >> tying stream ids to these recommended settings.
> >> Even with qcom specific binding due to dependency on implementation, n=
ot
> >> sure if we would be able to maintain consistency.
> >>
> >> So from maintenance perspective carrying these in driver appear to be
> >> simpler/flexible. And if it doesn=E2=80=99t violate existing precedenc=
e, we
> >> would prefer to carry it that way.
> >>
> >> This parallels how _"QoS settings"_ are handled within the driver
> >> (similar to this example [1]).
> >>
> >> [1].
> >> https://lore.kernel.org/linux-arm-msm/20231030-sc8280xp-dpu-safe-lut-v=
1-1-6d485d7b428f@quicinc.com/#t
> >>
> >> Thanks & regards,
> >> Bibek
> >>
> >>> WIll



--=20
With best wishes
Dmitry
