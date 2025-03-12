Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E7256C7F
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793863; cv=none; b=CU5oI4XGZvnnIe0wPTfuPJSiU10sZHNfm9r2Qjgm/J8pPJbNTVnBy4+0shdxJIzGJEikSxNu/fotf7SCKnw6iVB3Qtic19d9jyxkgIjPCuyQzofa7wV/yKL8Cq9QviWjSu4qgSofemV0uWijw52gAYMZzhl2E8/MUOdA07edskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793863; c=relaxed/simple;
	bh=SDFKqepfa7fKYb89hzpnUMj8TGStA88aAw1BI2H78eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kn9GYokRF0yvcv2shhcg8CN9sS1UzZMm1D9kJRybak2C9pvW2x5BgMIrE/PrhaeDnF7MNmlncmyU7oGRfGHubPwq7+ooYA3tLO6MCvq1OfIj1UQbNJ3D3MTW2LYrOa00xX/kgjntKS4ClTM8GWvONjT4tBriNjLoshDnviske9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcizQ1ai; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcizQ1ai"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso52713745ab.1
        for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741793860; x=1742398660; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMrlZ7TtkaQuy37XoBmFTMRDwm8cFmyklhT5/AoAOS0=;
        b=YcizQ1aiN3I1TurJC/cnr8g3eUnveGa3KwQg3HB5MRsdhGGjIXWGhxXJP0VHb8lLVt
         HyaoJmbLHQoOIX7Z912Epph1Bkc78fBQL37BDInKGk0lawOBG3+S3swgNhVayhzorgHD
         TnBN2H/S8z2Wk0TB32mdmc5bis3OQgKifZ/wWOfsZZpRjsK4fG37H0dj51JsmePc7Dy0
         b4496+GrwZNYF708MF/eIcpgtzIBh9GZFFw/ixz0JbtcB+GJ+tKxKWgPQcJh50n1wOO/
         zi0QZHARxClwSF1UE437RLgjiVczaX6dzdb3/3+aoQ41Bum5ai75iidrOKjDordN96oT
         R5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793860; x=1742398660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMrlZ7TtkaQuy37XoBmFTMRDwm8cFmyklhT5/AoAOS0=;
        b=LFXVWKqZuXa69Kac67aO8Z3t/19ihWyBpfi9njvSTebeHffdqTWvZQx7Tx6dHIotUn
         mVLLN0rl1N41XLIYMc1MWizbX2UAQDfWF09NsWPDzKtfbKrudWfeFdmJgYq+0LwTKh8M
         pESLco61oNWDZcKxYTv/5rZ4cN3fEqrPCPWkm+xFTNgWAfSymRngK//K8VM+qTbLFH2E
         3cMa2RnvH44usMivv3bDfWjT3LKUgT5B1cmdCdeyu+2ACsmVkPwv3T0brW60Rf7NSU7O
         55RaQnt1z7ya+GkFZOzzcdP8ZCn5C5x0OXcVVd1IrM6GzK/tZ70qkXA5QbEXUDAc0giR
         +azg==
X-Forwarded-Encrypted: i=1; AJvYcCWHKMRx5KMEgM2VOiCSQ8qYrg+vrPyxQgOh+JBDGHbMfkXWltZwJT7roNKB61T3ctOJ40uaxg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp0n410THFnYFKwc2eFRyEMYf/u12FZjDVnPCeiGHZd09ChH+h
	IYfHwQ0mEpZo3n8XOYgN0pJZOgTYYGWQ9mdl1cuCcL724o2BNQ2FZLe291eGkeRVhFFTXl1FxRw
	QrC0R8X6DC+1D2mNbvvj9rIDmuvs=
X-Gm-Gg: ASbGncsivGjJkdkKP6TGWWmQzY59IGPTQFco3Jhnj3GbIEKjr3MeADrzW6zB1P6OTzo
	Xz8K5X9d/3RFJ2MDXs8tvq4d8NKdRyF8kq//8YpR4tK5kPEUM5JY+UxzdkoZawufSWhvPuxpcYn
	HEP802iM+oEJSV4EYVQd2uSHzeOzunDOqWxMwBi4EVoeoiGSVuDODaSl0VKMUOYec0Wug=
X-Google-Smtp-Source: AGHT+IH8sNbtyRtPBc86b6yqtNTtxLe+g14B50y3MAoRxzA6AkWmg3s1QxxNYTJ6OnJNaPf6hfx0HKWOAGJrh4dWDCY=
X-Received: by 2002:a05:6e02:1a05:b0:3d3:d067:73f8 with SMTP id
 e9e14a558f8ab-3d4418d0596mr221485665ab.11.1741793859848; Wed, 12 Mar 2025
 08:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
 <173625436399.258197.10961901698600591079.b4-ty@kernel.org>
 <20250311175528.GA5216@willie-the-truck> <CAF6AEGvDyPtXN7Cn98BKsTM9GjUzy1sTEOsLiz-cdvaZ14qWyA@mail.gmail.com>
 <20250312130846.GE6181@willie-the-truck>
In-Reply-To: <20250312130846.GE6181@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 12 Mar 2025 08:37:28 -0700
X-Gm-Features: AQ5f1JovmMWQD_O1PD6cpwLN-pH1HxH4w3bZZDBIgzK7Opj6tqGtZU_Fkjgi4xs
Message-ID: <CAF6AEGtrUKybxPZMxkUgjg8JCxPr7-pRe0noS7=y6UrbHxDzZw@mail.gmail.com>
Subject: Re: [PATCH v18 0/5] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Will Deacon <will@kernel.org>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, 
	robh@kernel.org, krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, 
	dmitry.baryshkov@linaro.org, Bibek Kumar Patro <quic_bibekkum@quicinc.com>, 
	catalin.marinas@arm.com, kernel-team@android.com, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 6:08=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Mar 11, 2025 at 01:03:29PM -0700, Rob Clark wrote:
> > On Tue, Mar 11, 2025 at 10:55=E2=80=AFAM Will Deacon <will@kernel.org> =
wrote:
> > >
> > > On Tue, Jan 07, 2025 at 04:42:39PM +0000, Will Deacon wrote:
> > > > On Thu, 12 Dec 2024 20:43:57 +0530, Bibek Kumar Patro wrote:
> > > > > This patch series consist of six parts and covers the following:
> > > > >
> > > > > 1. Provide option to re-enable context caching to retain prefetch=
er
> > > > >    settings during reset and runtime suspend.
> > > > >
> > > > > 2. Remove cfg inside qcom_smmu structure and replace it with sing=
le
> > > > >    pointer to qcom_smmu_match_data avoiding replication of multip=
le
> > > > >    members from same.
> > > > >
> > > > > [...]
> > > >
> > > > Applied to iommu (arm/smmu/updates), thanks!
> > > >
> > > > [1/5] iommu/arm-smmu: Re-enable context caching in smmu reset opera=
tion
> > > >       https://git.kernel.org/iommu/c/ef4144b1b47d
> > > > [2/5] iommu/arm-smmu: Refactor qcom_smmu structure to include singl=
e pointer
> > > >       https://git.kernel.org/iommu/c/445d7a8ed90e
> > > > [3/5] iommu/arm-smmu: Add support for PRR bit setup
> > > >       https://git.kernel.org/iommu/c/7f2ef1bfc758
> > > > [4/5] iommu/arm-smmu: Introduce ACTLR custom prefetcher settings
> > > >       https://git.kernel.org/iommu/c/9fe18d825a58
> > > > [5/5] iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500
> > > >       https://git.kernel.org/iommu/c/3e35c3e725de
> > >
> > > Hrm. I'm not seeing any user of the new ->set_prr*_() functions in
> > > linux-next yet. Is there something under review, or should I revert t=
his
> > > for now?
> >
> > It is WIP, part of a larger patchset adding sparse binding support in
> > drm/msm.  Please do not revert.
>
> Sure, if it's actively being worked on then I'll leave the hooks in
> place.
>
> Do you have a link to the patchset so that I can follow along, please?
>
> Will

https://patchwork.freedesktop.org/series/142263/

I'm currently working on resolving the shrinker hack, which is the
remaining TODO.  So I'll hopefully be able to drop the RFC tag and
post a new version in a couple of weeks.

BR,
-R
