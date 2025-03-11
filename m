Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4C1925AF
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722173; cv=none; b=qZTDLESju6xbiZ7bC8qjDsJDAmI9fjnXqsSx9S7IXKzRwelNzm/6HSz90E2KEPJIHb1HLMuuX7jjaN+PChawfZatK9XFBmuBZqbpocTBenQlOG34mXwVqcUNBSxcX66cH/ZtdaY2Hc8iwkEC7VMbYxT1OnL8M2ozsXS0voena6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722173; c=relaxed/simple;
	bh=1KA72Lm2RCHKFh/p6H4nke2mfI5zVmemdmoVecWMp2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTFCuiO3YxQJaMeKK9b/+pjT1lw+bfr/GT/vA4TGtNKUOOrEGiwEtRUBLzdo6mytRVWFEicwhDXhLdSveLqyMwP14gIXAf2VnVIOX3sTBa1Vdo9YG42u5OmHd7P1H6gPsXKIAYcWU9gZk3VFmRJ7XW/gBOsnfzGiltVHgpZFpWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URh04ZO3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URh04ZO3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de10eso13982965ad.1
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741722171; x=1742326971; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N/4+Bu0y09vjMihB3VFFSKzM9LtDAemE75jVPYGVnw=;
        b=URh04ZO3fRGaHc7505AYgxHnon/9yAZOZwWftfraacyQIvecEaupZMgX2NU0ZrrK7M
         uKaqG6/Noujk/liOUxwC6e7Y05c5OYp1PJRUqO4RgonbhsjFYZSL5aL8chgiBAJt23Eo
         WR5cDPGHy4vh6k0BRtjnWntvtZxQm5qCFxgoQEVWN8IDW9fvagtQQhD//c2VsLm5MNXk
         gJUFRqWJ9IUeuQpNsiRoDaxrMCYhTsmctU97AAJVi7ZIPLB0GQITbJCjkq9eYrban7uG
         si7f4IJJoeq5In29fEH7b68vTxJzwOEqtKSUcyr096T8G3tAb4RdQhU5xi/plOu5xxES
         9Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722171; x=1742326971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N/4+Bu0y09vjMihB3VFFSKzM9LtDAemE75jVPYGVnw=;
        b=eNukqcgw8RKTGReqKxV4VkBW91GAz1jtHBXGKtyF0u9K0CDVEy/y7FQ3TxapVLuCZF
         KR2bLXOM3yFJgIDGuHfSDaPLrG4mAhxHbD2HLFrTFuWmlJNIOfLNLPgHYSlt6T4YQ7fC
         aDYNkhEwdsJRAtTFMm42UF0Kyh/WP34rdTvQqDzf+TDHgvbEqcr1SG9ppCTPLH1bNQuP
         I3sKOx7PXHhLWjVtI2XunPznIWrno4iK7zP3vhZzR/At1MkPDuXiqQY55Fk6bVHHAZU1
         kld65SBadKVuYULkvzQbQStaOW+xIu1dUEynLarhfOzJ9zVd//BnrDKjtM8GAtvhyxqx
         ByiA==
X-Forwarded-Encrypted: i=1; AJvYcCXaboNR7xJH5k3KxX46u+QModv4jxgLXU+jGWtMmq1hOVd07OV4dQv3BrPnO8A9sG0Vqk19jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbZkf0wOWeHpKSdMensG2D8zYwA5BI4RI01BzgETjqrcwKKrNp
	qr9gMIEnQ/53GJVqXDBfuFz75jEs9swQ8OaACVAhlNAKc9Ds3W3Yx1cD14//bEL8CCbipR1yA4w
	ioZVL/upzeQe5G/YQkY+8pdPKO8o=
X-Gm-Gg: ASbGnct3DF/0JLmsgjqKZg3J62OciKvlkFopndhEz/nUijwoPoDOgvFPoV0cDEHt127
	SaNKitq/KKo+eylFnHf5U4wNYC+t7ZpAOQmQSbOu645UEoZi0awx2m3AD6OIiZTp0EM/G9z/xdd
	Q4oIlB8ZiIy5WdC2QFkWm2jC3guykdU/GAvvGx
X-Google-Smtp-Source: AGHT+IFUV+t76koSVwvfP0DiZwzaDgX4TU97m1RDJMgX9rF6Maeao/NZF5n1twVNajoiVfnFuWNdcIiFIJEURljqxUQ=
X-Received: by 2002:a05:6a00:3e04:b0:730:9989:d2d4 with SMTP id
 d2e1a72fcca58-736eba65be7mr2466708b3a.3.1741722171206; Tue, 11 Mar 2025
 12:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
 <20250304-msm-gpu-fault-fixes-next-v4-2-be14be37f4c3@gmail.com> <20250311180807.GC5216@willie-the-truck>
In-Reply-To: <20250311180807.GC5216@willie-the-truck>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 11 Mar 2025 15:42:38 -0400
X-Gm-Features: AQ5f1Jpiv6Ky6TiyCXBXNy8BjxnsE1wP6MKIErri1CZPIQdm5BNmyqGHT0u49Nw
Message-ID: <CACu1E7Hw6vGbTQ7t-Hj3ziycZhPxtOGSDkt7o4fNUx91KDcXfg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] iommu/arm-smmu-qcom: Don't read fault registers directly
To: Will Deacon <will@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:08=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Mar 04, 2025 at 11:56:48AM -0500, Connor Abbott wrote:
> > In some cases drm/msm has to resume a stalled transaction directly in
> > its fault handler. Experimentally this doesn't work on SMMU500 if the
> > fault hasn't already been acknowledged by clearing FSR. Rather than
> > trying to clear FSR in msm's fault handler and implementing a
> > tricky handshake to avoid accidentally clearing FSR twice, we want to
> > clear FSR before calling the fault handlers, but this means that the
> > contents of registers can change underneath us in the fault handler and
> > msm currently uses a private function to read the register contents for
> > its own purposes in its fault handler, such as using the
> > implementation-defined FSYNR1 to determine which block caused the fault=
.
> > Fix this by making msm use the register values already read by arm-smmu
> > itself before clearing FSR rather than messing around with reading
> > registers directly.
> >
> > Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 19 +++++++++----------
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 14 +++++++-------
> >  drivers/iommu/arm/arm-smmu/arm-smmu.h      | 21 +++++++++++----------
> >  3 files changed, 27 insertions(+), 27 deletions(-)
>
> [...]
>
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/=
arm-smmu/arm-smmu.h
> > index d3bc77dcd4d40f25bc70f3289616fb866649b022..411d807e0a7033833716635=
efb3968a0bd3ff237 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > @@ -373,6 +373,16 @@ enum arm_smmu_domain_stage {
> >       ARM_SMMU_DOMAIN_NESTED,
> >  };
> >
> > +struct arm_smmu_context_fault_info {
> > +     unsigned long iova;
> > +     u64 ttbr0;
> > +     u32 fsr;
> > +     u32 fsynr0;
> > +     u32 fsynr1;
> > +     u32 cbfrsynra;
> > +     u32 contextidr;
> > +};
> > +
> >  struct arm_smmu_domain {
> >       struct arm_smmu_device          *smmu;
> >       struct io_pgtable_ops           *pgtbl_ops;
> > @@ -380,6 +390,7 @@ struct arm_smmu_domain {
> >       const struct iommu_flush_ops    *flush_ops;
> >       struct arm_smmu_cfg             cfg;
> >       enum arm_smmu_domain_stage      stage;
> > +     struct arm_smmu_context_fault_info cfi;
>
> Does this mean we have to serialise all faults for a given domain? That
> can't be right...
>
> Will

They are already serialized? There's only one of each register per
context bank, so you can only have one context fault at a time per
context bank, and AFAIK a context bank is 1:1 with a domain. Also this
struct is only written and then read inside the context bank's
interrupt handler, and you can only have one interrupt at a time, no?

Connor
