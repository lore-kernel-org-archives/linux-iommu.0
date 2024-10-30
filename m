Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868721730F
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307533; cv=none; b=MaAwxOxsOGg+Kwhr4IV7kx+SuN6aanSFIRwhNAVFWno5NeUt/rvX79OGbjL5C2WRNecbuFkVXH4OMTnkwMVzNKipX5FOtWDCDIohuWQnLe9AK3SWylhY4tjlRVcN4SI/ofBQqhn8Qg5aw1zi7Sy4LWoAHg/0Mz/gvHdc7uMa6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307533; c=relaxed/simple;
	bh=ZaNj72bHwwAgPrYGtNeBr2dlriKJWTyEW9RryZ6X9Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0jftW0n/ceL2gE0diQNRb+heoaTyJrCGmpKAJLbQTxSeabhMMMFevwsQ7YB4sReYJImhnvz06CooisoYlm9/eqQBbIgX1UpB2P7rBGYH3iWKGp151KBggLoEUB2KRCskAZwYr69xfGDmPVoPFXAm8N3BIl3wM8Gzsw0AO2zbEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMXKUzFK; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMXKUzFK"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83abe7fc77eso594639f.0
        for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730307530; x=1730912330; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSgEGqLSHYW5dJnL+akJvNntnbwcTcLxiNTHrobsiFM=;
        b=IMXKUzFKZNTX/xFrWCFJxBUTiGos1P3FFgzKN4bmmdUkATFfT+942GfIEHHhAyHdmx
         Ub9IVAoFK0CxkLyPJZUx7yFsG3wJ3h82njDE8jrsMJPJnC6lATCgYCqLTER244t5m9P4
         ui97tj7L+Dtpr8uL/3D5KSHAhyLnXd0KppAGxlNfdwGhpgFMAnK2+SnaySnK7xWyIo7U
         dGSbq2VzkH4Z6Q7C4z28fMTyiX+tWx744+Ja6BJZag3VxCDqPcun7NkSWo2x6g1FNkHJ
         u3Mp5BucM/vzkKqnl3CP0FImhJDe+tQoRjNn0z5BtYRcCUEOVpBzmSWH8ERVj0FZxSbP
         yNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730307530; x=1730912330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSgEGqLSHYW5dJnL+akJvNntnbwcTcLxiNTHrobsiFM=;
        b=oZ9dncXJ8BJrk6qk0wTENK4KnTd1fg1vys55R8WGg/XqbuzmVZ4jgtFXGfugwUx3tV
         VJYArSR6bi+zUtDpcZIsqOtcBAJ55Fm3qcHBZnLnXyML8IwqBfq1zHD9jtTa8kdtYCon
         DG3DlXMdoax0Ts3JLZ07yZqn7EZ0s0JmHbq7jip0gkZaTfNu7KcJOKqfHeX1YWsut6y0
         85plutti4nlQWsx6mKUdZoCLGNNYz4F25GHHHSirqiU/XFdUMY1mnmrelRRUtYuapRDX
         KFTTxF0L0V2FtVO1T85JE9oI3vqWb5vthVHcvn51ByWp+wc3XEombYtQiyGi7ZcHYhAq
         Wu6g==
X-Forwarded-Encrypted: i=1; AJvYcCWmtZPZc70kh7RzvHrbpKA/il7qJBwWHEF155lf0WDasJdqRhn3K2t9uz+PU4qLtCOAXX0G7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxILhWDK0fSi9sYlwd5C6Mc4CDuZHAKplaWaBupyyMkRZj1Q1xz
	2m/9djoW6HipzoEh0Zsn7Mbm9RHKnn7k1CjPno47K5FsWv6TyYWHdBGrWo4zyeH7Cvt8wX8TMi4
	FRZDILS3Hnr7LOwn51UIFFWW5jIZfwg==
X-Google-Smtp-Source: AGHT+IGmbmSXox8oAVQKBdxqprSBcxGpJ91Xocq6QrwRiJgePmhF7ve9q4dPiAMajWeQWmKzteD5uHeTwomcrUrLAXY=
X-Received: by 2002:a05:6e02:1a4e:b0:3a3:b4ec:b400 with SMTP id
 e9e14a558f8ab-3a4ed2df0f2mr181154985ab.17.1730307530123; Wed, 30 Oct 2024
 09:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com>
 <20241008125410.3422512-4-quic_bibekkum@quicinc.com> <2d651f1b-4f51-4984-903f-7f5a14151f84@arm.com>
 <531d0144-e027-4589-b4ef-79f02583df8b@quicinc.com> <65132b36-49f6-4b08-8e7d-6d6cb8da5960@arm.com>
In-Reply-To: <65132b36-49f6-4b08-8e7d-6d6cb8da5960@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 30 Oct 2024 09:58:38 -0700
Message-ID: <CAF6AEGvAYeY-fuk1Dg-0gsrod7Dy91qifKvChCd03=bs_zfs-g@mail.gmail.com>
Subject: Re: [PATCH v16 3/5] iommu/arm-smmu: add support for PRR bit setup
To: Robin Murphy <robin.murphy@arm.com>
Cc: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org, joro@8bytes.org, 
	jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, 
	dmitry.baryshkov@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:23=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 30/10/2024 1:14 pm, Bibek Kumar Patro wrote:
> >
> >
> > On 10/29/2024 6:59 PM, Robin Murphy wrote:
> >> On 2024-10-08 1:54 pm, Bibek Kumar Patro wrote:
> >>> Add an adreno-smmu-priv interface for drm/msm to call
> >>> into arm-smmu-qcom and initiate the PRR bit setup or reset
> >>> sequence as per request.
> >>>
> >>> This will be used by GPU to setup the PRR bit and related
> >>> configuration registers through adreno-smmu private
> >>> interface instead of directly poking the smmu hardware.
> >>>
> >>> Suggested-by: Rob Clark <robdclark@gmail.com>
> >>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>> ---
> >>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 37 +++++++++++++++++++=
+++
> >>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
> >>>   include/linux/adreno-smmu-priv.h           | 10 +++++-
> >>>   3 files changed, 48 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/
> >>> iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> index 6e0a2a43e45a..38ac9cab763b 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> @@ -25,6 +25,7 @@
> >>>
> >>>   #define CPRE            (1 << 1)
> >>>   #define CMTLB            (1 << 0)
> >>> +#define GFX_ACTLR_PRR        (1 << 5)
> >>>
> >>>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> >>>   {
> >>> @@ -109,6 +110,40 @@ static void
> >>> qcom_adreno_smmu_resume_translation(const void *cookie, bool termina
> >>>       arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
> >>>   }
> >>>
> >>> +static void qcom_adreno_smmu_set_prr_bit(const void *cookie, bool se=
t)
> >>> +{
> >>> +    struct arm_smmu_domain *smmu_domain =3D (void *)cookie;
> >>> +    struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> >>> +    const struct device_node *np =3D smmu->dev->of_node;
> >>> +    struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> >>> +    u32 reg =3D 0;
> >>> +
> >>> +    if (of_device_is_compatible(np, "qcom,smmu-500") &&
> >>> +            of_device_is_compatible(np, "qcom,adreno-smmu")) {
> >>
> >> These conditions aren't going to change between calls - wouldn't it
> >> make more sense to conditionally assign the callbacks in the first
> >> place? Not the biggest deal if this is a one-off context-setup type
> >> thing, just that it looks a little funky.
> >>
> >
> > Let me know if you want to pursue this still.
> >  From the current PRR implementation in the graphics
> > vendor layer, this seems to be just setup kind-of thing.
> > Also if we keep this conditional check before assigning callbacks,
> > and vendor layer caller won't be having any such check,
> > wouldn't it be an issue in unsupported platforms (!qcom,smmu-500 or
> > !qcom,adreno-smmu)
> > as the callbacks won't be assigned?
> > So as per my understanding I think it would be safe to keep the
> > condition check here?
>
> Like I say, it makes more sense to me personally if SMMUs which don't
> have a PRR don't offer a callback for setting the PRR which they don't
> have, and for it to be the caller's responsibility not to call a NULL
> callback where they wouldn't need to call one anyway. But the
> adreno_priv interface is kind of Rob's thing, so I'll leave it to his
> preference.

We can go the route of NULL cb if it is not supported (but should make
note of that in the adreno-smmu-priv.h header comment)

BR,
-R

> Thanks,
> Robin.
