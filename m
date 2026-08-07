Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B062EEE86
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113474; cv=pass; b=eBh4tdhifttWD1yztTL9yBIEO8OOUBontspJSBQ4ifdUjto0cV8AuGDTElqyFzXaJemOwu7ruIgKxw0IXW0IT8n7zeGOp81S7IBVhQlDNYJCe5V1YO7NzqPzvl8yiO8SWV05T5UsMM60GC3ZlMYbszYRCGDPxJ0w5dSnmZpLxho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113474; c=relaxed/simple;
	bh=eHqINAXxshzohPgUMprofaAZiRaC00jZPRTFSLbKNUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DisuzKe7tEpOA6GDvDjcjGOVEKglfKPrhsK4ytUWGbJdPAfkVIcPcxzhsQyxyO/MGMj31R1Zmu8Am02b/rGI4stwBI7ICeKZz18CJxOMX2YBibcklg/NxX6JzL5vQIGl3ADnkoeR+SSwKsH9E4yJn+Jg2zoHgZU0y9EfQSGZiNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVofxGuL; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVofxGuL"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a14f762de4so4571707a12.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 07:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786113470; cv=none;
        d=google.com; s=arc-20260327;
        b=qC6EwcuW8cHlSvs6L68r2MJFg63GFqm4WVP3MuwT7b9vCipCUVWa/g2aGLp+BKKsAZ
         yg04jSBnwoL98zP1zayCRi3KWFNHcAhLDGATpgPAac5cWT+i6Bi+e27LuUKoz3p9BTcW
         PqrIe3rVshhsGIxUmVECHNLXfAOrEjR5WBKUnadfjWESOI40tb3nliBkdslyq4HbUk7C
         xPR2/fywXlZgDanT2wHq4NSY9/1zg+ax3/1Rzp8WR7He4aCO5X69oxjElwHPbUk3FmkB
         lYSxDYf065FpN3hEzay9usjMFpwZElPJaMWK5/uKLuLQijaxK4znHGHVaih1StvQ9zKz
         yTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W6m06+tQ3UmcgbeeK1HTCPK9otwtvhbVRYnkmzJl8qA=;
        fh=UUViTfN5o1WOh4ND+E9qtKVVchyzND/8TojQtZUG3V0=;
        b=iIwETdBPdzvXRi7uP9RsrOwLmAjHVZ2UmY3oeg/Z2uaolHyiD2GTp0GTmKhWHlSehp
         CTNYKpiCz4lgHKYKkVgW5bGtu9NN/xh6vlHYPRJJhQnznXdrQSvHtEBz6eSfCToahuoR
         qHeTMfk2vc6NVL+aUSc/bnJsafRVYRpuPrOkHdF+4x59rh0BxMRaA49zQAOo3Ci+EgVX
         NryxjLE55aK78e5hb9/SYtGNbshaTyjGdvmbOoc1g7J0EQ+/AQYakm+EmwpF9s6QIrqU
         zcBsFqwszwF5mUTaP54+jzMGkPKPMAQdcoTqmXs6NUQX46gwAAyAyOtxyGCsGyrQ7feC
         2lcw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786113470; x=1786718270; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W6m06+tQ3UmcgbeeK1HTCPK9otwtvhbVRYnkmzJl8qA=;
        b=oVofxGuLEKxzSAaz4567acghBBoPbpbwWF36HgAVSL5tQEkHrPiZ/XR7Lpiw873t2k
         fLh9CNOt33Ut73b0F/iOqI8daugGJcO9O6t3XJvj+nVHtVp1YiqzspxyQPOKKFQLSzg6
         4KeiRcTPg5C2fxqT1+lUzmjm3Bd6FRxsbNw57K2AIDXDOXX3j2raSK94oiPO6kRql25P
         nAUcND0pUnEMBcQCU2KldcnxNPenLO+4pKOh3Tce1SkR/ut8gPx77mp25BiJMHlZq2zP
         L8Z6CcgJWtQr0GQqU4WMTq8g3CubeaXOwo7+G1CEeYu/ddCK7ofUioFCqEiqtUA+QLcS
         8awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113470; x=1786718270;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W6m06+tQ3UmcgbeeK1HTCPK9otwtvhbVRYnkmzJl8qA=;
        b=Yf9Ihj2c1DUgmx117sEdRis1DYt7QTswPkjcvdEaQoyO0sLAhl238M+GDUfLjm2M7b
         OpktRNQiqxilopJ3F7J4e7xd3r45jSOfG9sF8DGrGTVlcmPdJr46MOAi0pFgYf6LhZpd
         VJkT1/O2JNuPSft3D+V6dZiWeCgulLKI/LjvRSXZKANq6NbbEcbZcc+kkEvBlrCp6TAR
         SKd9VLmP3X9VmTr1/5rmQMIr1ufLnci6wm1anmlLaim9oH6ZoG+tbA26XZc32m0clIYo
         l1c3GG+weUnsjgerH7FpfNLyDiz+qy5U2QCDiCUxU+9okgkyUOXZEyeiqfbZTGGz3FMI
         K80g==
X-Forwarded-Encrypted: i=1; AHgh+RqMOXej4ZElCrco+qUXXVHzA71i0V9yiVCAkDKpKUuMXt7dS5hi3gvlB2wH2gLZSfgP3gRQnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKYiESpVf19iKPSFu2xzen/ZUv/UnQmaq++IDp9uy//DRalryY
	7ZEALGrmAbLOYGyHJgtuWG/wK1emjEjh0bF7BgNhFadf+kDrhcdGgoCmjqejUHETlc59h0ujpQR
	wBdrI6IE87mB8y20w0iqX86y4QRZB/9llu/Zv8s/L2g==
X-Gm-Gg: AR+sD12ess3KQ/Rvy66OHDXodQWO1Ci29jESMakt6klRDnq7DXB5FormZE0REF9B2+j
	NOQ94cywU07zTVfPLcrguYvm4GkxT0NmhUbFALNS2Ugfp0fvbl3IdZ/Lj131MkOnzXOj69gzdex
	ttBpcEh+OGhd6N/g8ZAyuhBOmG3aL+OY/PcXBa3eX0c3Fq3a3AM8CKvC0G1V8L+HU/562LPYNpS
	wO+OBrA/8IbqPPJ0TSUw13YIFnRE1aBQmCnGwpO5RTegbwyMpqfR9ZCmJWusSLKopw/3QunncCW
	7FcWYxsNOILIt8xnaDwcBwdzCDKtTKes959K34Np/CqsBkNTcbYj6IxmQWOb028q/8hmTlwpSg7
	ALCY=
X-Received: by 2002:a05:6402:380a:b0:6a1:1e25:143e with SMTP id
 4fb4d7f45d1cf-6a14f07aa0emr11843889a12.3.1786113469730; Fri, 07 Aug 2026
 07:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <20260724-arm-smmu-v3-instcfg-override-v1-2-e7acf4a8a525@linaro.org> <amOpSPmc36+YXgCQ@nvidia.com>
In-Reply-To: <amOpSPmc36+YXgCQ@nvidia.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 7 Aug 2026 15:37:37 +0100
X-Gm-Features: AUfX_mycW6Onnp9fcyEmhcQ210POYMAQz3QVnbQpiqAFr05Ok_wIMchvSKnA5X0
Message-ID: <CADrjBPoOctsStZn84vtCymdKen2R9XcM880=wxXSv1tpQ5+vyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Override for Inst/Data attribute
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Mostafa Saleh <smostafa@google.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
	jyescas@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Nicolin,

Thank you for your review feedback.

On Fri, 24 Jul 2026 at 19:05, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Fri, Jul 24, 2026 at 01:39:43PM +0100, Peter Griffin wrote:
> > @@ -1206,7 +1207,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
> >                       cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
> >                                   STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
> >                                   STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
> > -                                 STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
> > +                                 STRTAB_STE_1_EATS | STRTAB_STE_1_MEV |
> > +                                 STRTAB_STE_1_INSTCFG);
> >               used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);
> >
> >               /*
> > @@ -1222,7 +1224,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
> >       if (cfg & BIT(1)) {
> >               used_bits[1] |=
> >                       cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
> > -                                 STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
> > +                                 STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV |
> > +                                 STRTAB_STE_1_INSTCFG);
> >               used_bits[2] |=
> >                       cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
> >                                   STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
>
> This adds for "stage-1" and "stage-2", while missing "bypass"?

I need to follow up again on this point, but I don't believe currently
we require the override for Laguna when it's in bypass.

>
> > @@ -1835,7 +1838,11 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
> >                        STRTAB_STE_1_S1STALLD :
> >                        0) |
> >               FIELD_PREP(STRTAB_STE_1_EATS,
> > -                        ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
> > +                        ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0)) |
> > +             FIELD_PREP(STRTAB_STE_1_INSTCFG,
> > +                        smmu->options & ARM_SMMU_OPT_OVR_INSTCFG_DATA ?
> > +                                STRTAB_STE_1_INSTCFG_DATA :
> > +                                STRTAB_STE_1_INSTCFG_INCOMING);
>
> Sashiko pointed out that this prematurely closes the cpu_to_le64()
> macro.

Will fix in v2

>
> > @@ -1887,7 +1894,11 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> >
> >       target->data[1] = cpu_to_le64(
> >               FIELD_PREP(STRTAB_STE_1_EATS,
> > -                        ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
> > +                        ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
> > +             FIELD_PREP(STRTAB_STE_1_INSTCFG,
> > +                        smmu->options & ARM_SMMU_OPT_OVR_INSTCFG_DATA ?
> > +                                STRTAB_STE_1_INSTCFG_DATA :
> > +                                STRTAB_STE_1_INSTCFG_INCOMING));
>
> You might need to set in arm_smmu_make_bypass_ste() too.
>
> > @@ -5087,6 +5098,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
> >       if (smmu->sid_bits <= STRTAB_SPLIT)
> >               smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
> >
> > +     if (reg & IDR1_ATTR_PERMS_OVR) {
> > +             smmu->features |= ARM_SMMU_FEAT_PERMS_OVR;
>
> Where does this new feature bit get used?

Good point, the feature flag isn't actually used anywhere else except
here. The intention is to ensure the DT property
"arm,instdata-override" is not specified for a SMMU which doesn't
support the override feature. But we can perform that test without
adding a feature flag that is otherwise unused. Will fix in the next
version.

Thanks,

Peter
