Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FA1E103C
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149987; cv=none; b=PyIqEx7lh9TsFC5tEDqkOYp2LlCgx/wGXKdjCqI7lLdpk+YaUMLIr2gkAFIHkk7npWoHG9t4zF+Ymnhql/UQjucvoKjoXn9nK7kIlTDDyefOnvq+b8Em3QzzKuB5zoPcERucBSEgNcR/Zt1PROF5edHBAl96cf4y5NZYVNFUfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149987; c=relaxed/simple;
	bh=LtDo0HGH4GpIxcwqQ01+oiXVCwL4cBQIntMkKU4bWpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzyvY3W08ubvUJy57+zvHktVCybYpMh+101ooxP4HKdm9IQDZyx+DnAj4i7X9a2XCTFH4qo/chKFUXQH7Fqo1HzdnzWCx10n2DeqXdFdId7m+TqxmPiD1e7Z2aJLlAwKKPRxw+frXu+0+Ej8yT9SMvTzzbGJXrJW2yS4pBnRkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP9cT0JG; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP9cT0JG"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a398638ff9so18055165ab.3
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730149985; x=1730754785; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgydGo78UUNFcEV6DKA5ytibdOMHFroL34YfVzKhiUs=;
        b=RP9cT0JGH3Fzpx/+m854T4h6vSSZ6oyCu4HF0Ok2HkeErFox2qXzeSx8lcyKWoXkas
         6YkwB0RL1LttUjLobfcOauRR1zh8uif24hVs7MM+Z+k9ZOR7DT/oi5qi5lwTCPVS+55Z
         /QEZU4JeNrKR+mZ888MIuPsCl/DgS6B4gOzS69xUUSxVeEloeOjIC7cvddWQTfuUqCyq
         5D7JZNtMZ19uP3sufmRaI5yb4Ne7vGsye1TYmVfnFeW2Td/O2VdL2NE2PxVSgd0G6wFr
         n4YBYlGhwHeFJTL6EcJ48o7cWw4N0nYid6jW49L6Mt5rXB1viYjNpc9e+bDoYfAffi+e
         uwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730149985; x=1730754785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgydGo78UUNFcEV6DKA5ytibdOMHFroL34YfVzKhiUs=;
        b=TwHyV3X00/nJjXErj3jm8I7JCsly4t1SGij8fuB2CCpAb9eu/PocXghDWKb8zN2Jpb
         oQtiwTqffkTFrRanrSoHKhrx5vwQJo1e0qbxLm43nDtOB6F+6YXtUxOq0kK1isAB1Fsa
         L1rhqQCfRUIfapENrIMXDiGLE+6kfuDg1qgfz+9WtdgvvTr9K3ArhppcJTIMChI9Ngd4
         hAyJ0Pz/NZc2JlEFaLcBwsJ9e8EP8NwjbLbixtX6Lwj5I6LoB8YmiY8HEg/IJ0KsnhDn
         06ALRO1dAdDQxtv290nPQ6Mpx5JtrRjg+p6LuWCHcz5PEcL9LTkoVaHIm8zAkdHcndM0
         0njA==
X-Forwarded-Encrypted: i=1; AJvYcCXUFk1rauO+Dhqls/GW+DD2VL5iAdTO8F3sEhnwoYv7cisVrxej9Merriw/cMlOV2YPEmUt/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz5+UEJ9Hf8o+p8/rp9wj7w1fzEHKAF9dIS1iDnLIoHXiwScV+
	Y6OYr4YlroJWnB5xQfnJmOzgG0vTdPtwC5PJooQf/2X/onjDK1u/2dZ4MFeZuyl0ZMDxkUYtIuN
	JbXD5/z7Wk3um4uuV2VnZy2NcMiM=
X-Google-Smtp-Source: AGHT+IETQNXUS47G9SKDmicHSxSQjk2HxvylV+/jMNFioWMi2SJd15y2W6PAAa5jrnbbG4eLxU+17nmW168V2EDC/W4=
X-Received: by 2002:a05:6e02:1546:b0:3a0:8eb3:5154 with SMTP id
 e9e14a558f8ab-3a4ed275c09mr80530505ab.4.1730149984571; Mon, 28 Oct 2024
 14:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com> <20241008125410.3422512-2-quic_bibekkum@quicinc.com>
In-Reply-To: <20241008125410.3422512-2-quic_bibekkum@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 28 Oct 2024 14:12:52 -0700
Message-ID: <CAF6AEGtKP8EGp7iLMomTAFvaUOAPNeu6YiJ=e=MLvBAsA_yHdA@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:54=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Default MMU-500 reset operation disables context caching in
> prefetch buffer. It is however expected for context banks using
> the ACTLR register to retain their prefetch value during reset
> and runtime suspend.
>
> Replace default MMU-500 reset operation with Qualcomm specific reset
> operation which envelope the default reset operation and re-enables
> context caching in prefetch buffer for Qualcomm SoCs.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 45 ++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index 087fb4f6f4d3..0cb10b354802 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -16,6 +16,16 @@
>
>  #define QCOM_DUMMY_VAL -1
>
> +/*
> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
> + * buffer). The remaining bits are implementation defined and vary acros=
s
> + * SoCs.
> + */
> +
> +#define CPRE                   (1 << 1)
> +#define CMTLB                  (1 << 0)
> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>         return container_of(smmu, struct qcom_smmu, smmu);
> @@ -396,11 +406,40 @@ static int qcom_smmu_def_domain_type(struct device =
*dev)
>         return match ? IOMMU_DOMAIN_IDENTITY : 0;
>  }
>
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +       int ret;
> +       u32 val;
> +       int i;
> +
> +       ret =3D arm_mmu500_reset(smmu);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * arm_mmu500_reset() disables CPRE which is re-enabled here.
> +        * The errata for MMU-500 before the r2p2 revision requires CPRE =
to be
> +        * disabled. The arm_mmu500_reset function disables CPRE to accom=
modate all
> +        * RTL revisions. Since all Qualcomm SoCs are on the r2p4 revisio=
n, where
> +        * the CPRE bit can be enabled, the qcom_smmu500_reset function r=
e-enables
> +        * the CPRE bit for the next-page prefetcher to retain the prefet=
ch value
> +        * during reset and runtime suspend operations.
> +        */
> +
> +       for (i =3D 0; i < smmu->num_context_banks; ++i) {
> +               val =3D arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> +               val |=3D CPRE;
> +               arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, val);
> +       }
> +
> +       return 0;
> +}
> +
>  static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>  {
>         int ret;
>
> -       arm_mmu500_reset(smmu);
> +       qcom_smmu500_reset(smmu);
>
>         /*
>          * To address performance degradation in non-real time clients,
> @@ -427,7 +466,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl =
=3D {
>         .init_context =3D qcom_smmu_init_context,
>         .cfg_probe =3D qcom_smmu_cfg_probe,
>         .def_domain_type =3D qcom_smmu_def_domain_type,
> -       .reset =3D arm_mmu500_reset,
> +       .reset =3D qcom_smmu500_reset,
>         .write_s2cr =3D qcom_smmu_write_s2cr,
>         .tlb_sync =3D qcom_smmu_tlb_sync,
>  #ifdef CONFIG_ARM_SMMU_QCOM_DEBUG
> @@ -461,7 +500,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2=
_impl =3D {
>  static const struct arm_smmu_impl qcom_adreno_smmu_500_impl =3D {
>         .init_context =3D qcom_adreno_smmu_init_context,
>         .def_domain_type =3D qcom_smmu_def_domain_type,
> -       .reset =3D arm_mmu500_reset,
> +       .reset =3D qcom_smmu500_reset,
>         .alloc_context_bank =3D qcom_adreno_smmu_alloc_context_bank,
>         .write_sctlr =3D qcom_adreno_smmu_write_sctlr,
>         .tlb_sync =3D qcom_smmu_tlb_sync,
> --
> 2.34.1
>
