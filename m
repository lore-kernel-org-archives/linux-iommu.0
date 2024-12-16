Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7F1D54D1
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382498; cv=none; b=vCXLLvMhdV1PARafeU7s7LUxGQA/z+lT97HSHbPaoU482K2ZjCl70QPqJyhYTtBfQsgZbASlzF3s/SPngBed25CF2p+NRo1qQfgw+aWI/YQ2QPuEwF/dM2ZvJNDS0sQb+qItzfVBCFBxY9fS63e/uU+XiuQ+tEIOqbthnUB4OJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382498; c=relaxed/simple;
	bh=geG/YKx27V/zlwg0MEi0DPulSqUKvqAC78Zqn7duPTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrI7XrFBPtYQnDORpxpvcEUtJTjmjFiIIbUFS8BY3AlPgOy6gNGE9FFWkwZh+2ZdEw+Bjje9EmdtLb6xubPphEY9AqI2C83Se91rXzOZJLTchdho/oEH+DzRLt61lj+2xAPFouWv2jNDf33iQEihxfDAWoujzmEVq6d82ohRtoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/lg907P; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/lg907P"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a813899384so15467995ab.1
        for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 12:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734382496; x=1734987296; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGu56YKO1XlSS7wwJkm05qsGyYVWIdWmEMISHyf2DmA=;
        b=d/lg907PycfqT87CDt2WqKJ2QCZvmsREvZoLzwmLgwQ1XJYTsNoLlDEK5YMhlYgICb
         SumqH9874b2S5uQbm3q7S2YsTutkN/fp5JRYKVBRC7yy0lXy0vMqYOlYwa+Ym2cm+umT
         ScKU12uNqNiug2KXxFXS4HhOnms++imZgpaE/zoVJKxrz27KUpV/uJWGCPxEoqYrrHeQ
         vnTWZcN18NJgJ6Fv7o0cC92Ahy7yqwj9tDq39dryfUdQC73o1G9FsrkYXBrTOYnMQHBP
         g7Ma/EIyKgbqWpD+wwwJkcmmiXTSpEaJTtqfaawVdyBRTQjajwwHa7B0EiAa8Up7ryIa
         sdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382496; x=1734987296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGu56YKO1XlSS7wwJkm05qsGyYVWIdWmEMISHyf2DmA=;
        b=jMD+fL0pOUbyR/eT9+47D7EmvglzM7/wwMMXRYcDjI0jYLfljJbY60fqx4tY1btdGT
         4Ph+/O5+OmPP2axux5RtVAn94KI9k/DAH0wcK/mcq/40aJ+27ofsCoEhH4AeNE3qrL4N
         yu4w9DyJwQPgmbj4nDCkoOxYSQXPE76b/OpW0h2p8GmjrzM9OS/msHfd4h5cNHkjuLWR
         qaRRv5mRVcLpnowANFG6HKzNmTuQmfqj7QRii0bX95T2kO+pnqzZfkwu8QJTjA6J0G+w
         z7a8YQEWsHSipcaEKvrgUn3v4GsaqnzH+7A60kaqvuXkeWKv3cgyLiQjfqFaSSpAN4b6
         k2Mw==
X-Gm-Message-State: AOJu0Yx0JCS4oH8LYJYVEFmwdEi/02LmM/+NDpaudOMudn4vbFUvbhE0
	Ou19t8jtPeQTUYj2uT7/7Lh2Pw3DIK8oGEz4VE74HlX1qM3wFYbD5VJlPNzGbCn0mj0RxeC8fEr
	EfauHEODfzrMKsTzhGV8U3LolNR0=
X-Gm-Gg: ASbGncs5QX/mHpDeZ0/VUiPCN7+Ba6zpZQyeDM7iXH4CzVbVhk4vohGYleuwOxTB89I
	CBUc9YvvZfnXmRemqIOMdUDISkYJndGvqSPaRpuZwPvqxLNLvrFHc3pncDqb9errFqSgf
X-Google-Smtp-Source: AGHT+IE6NSDPDfv/Nr17YFiwuwQ8NV0QFzK1yfUD5+dRWkpGvLeKWKyM4SsI5zKJl53NjUsanNs56HL6Xdim8pgvJWw=
X-Received: by 2002:a05:6e02:1a07:b0:3ab:4bea:df97 with SMTP id
 e9e14a558f8ab-3affbbb656fmr160374485ab.23.1734382495871; Mon, 16 Dec 2024
 12:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216171017.4881-1-robdclark@gmail.com> <a15a7594-8793-478b-a86e-81a06812e4ff@quicinc.com>
In-Reply-To: <a15a7594-8793-478b-a86e-81a06812e4ff@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 16 Dec 2024 12:54:43 -0800
Message-ID: <CAF6AEGsFeibyH5_a7m=9PMKReD4Xb+c=dEGsbCN0_UHiJK1vbA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Only enable stall on smmu-v2
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 12:28=E2=80=AFPM Akhil P Oommen
<quic_akhilpo@quicinc.com> wrote:
>
> On 12/16/2024 10:40 PM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > On mmu-500, stall-on-fault seems to stall all context banks, causing th=
e
> > GMU to misbehave.  So limit this feature to smmu-v2 for now.
> >
> > This fixes an issue with an older mesa bug taking outo the system
> > because of GMU going off into the year.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu=
/arm/arm-smmu/arm-smmu-qcom.c
> > index c4c52f7bd09a..1c881e88fc4d 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -331,8 +331,10 @@ static int qcom_adreno_smmu_init_context(struct ar=
m_smmu_domain *smmu_domain,
> >       priv->get_ttbr1_cfg =3D qcom_adreno_smmu_get_ttbr1_cfg;
> >       priv->set_ttbr0_cfg =3D qcom_adreno_smmu_set_ttbr0_cfg;
> >       priv->get_fault_info =3D qcom_adreno_smmu_get_fault_info;
> > -     priv->set_stall =3D qcom_adreno_smmu_set_stall;
> > -     priv->resume_translation =3D qcom_adreno_smmu_resume_translation;
> > +     if (of_device_is_compatible(np, "qcom,smmu-v2")) {
> > +             priv->set_stall =3D qcom_adreno_smmu_set_stall;
> > +             priv->resume_translation =3D qcom_adreno_smmu_resume_tran=
slation;
> > +     }
>
> Shall we disable this from the driver instead? A debugfs knob to trigger
> coredump after a pagefault is very convenient.

It would require the driver to find the compatible for the smmu, so it
could differentiate btwn smmu-v2 and mmu-500, which seemed like it
might be a bit uglier.

Ideally/hopefully we could figure out how to make GMU a bit more
resilient in the face of stalled translations, because it is useful to
get accurate devcore dumps on smmu faults.  At that point we could
revert this change.

BR,
-R

>
> -Akhil
>
> >       priv->set_prr_bit =3D NULL;
> >       priv->set_prr_addr =3D NULL;
> >
>
