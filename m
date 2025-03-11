Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7554422F169
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723423; cv=none; b=XEF65j20HMXpXB87kIQgdwmJipozdOHQSML+X51HqZA2e8x3pav1qneyfEe+vrfeBQaiwgQT0nsDBEVySpi9xMmK/A5qdj/JecW/4Ym5XN91gBs/xDIK4l0TxCi/GfdXd79dH41yh0gQRDT3N+ndz54vYSKPqUNyvVJRlUbzPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723423; c=relaxed/simple;
	bh=/Y1uKhocepPEVr4gRndRQFJfp4PlO9xpVDQBkK0VWtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ1mZ59CRdHNmCffvjo0czCdb/HSOeyclRU8/2Yh4n+VbBPwD3HI73Ypi6jxtwGNTRfiq5PmPp78YsPD2Op8VFNW2zS5hJj+2ONtD+CtHUdKmX03i3cR5HiyeUrRRrsaf/ATAxOfDsJ8ZxuQjiwn4wZzqwmHGb5xgxS4NAvZMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2TpPXcr; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2TpPXcr"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d46693a5e9so13798735ab.3
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741723421; x=1742328221; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GW523EAS3Rk6Z2Gf4pN5+J61D3es3lTSy0uI9oNxP9Q=;
        b=G2TpPXcrpFW+/YAERJl5vKsbHVJdRGtq36EOTC2DotcaMtTPXQ9I8txeU/hylo5Ey4
         X7wcnQsdhbhsbptIYvgXA3hgPI6XHvXj18ahjjWVwAJKDU66buEL4f3hxUabT4sDQQCO
         tu84hTk8Pju1V122BGsza2k+xQw8m7mnwrr9Kw0Te62Pr4DmiJ+1bhCOi1rKDZCUUPEn
         ep3YnW0k3FJXxxnypmRbRA40xc8G81Jpoj4ZbvonE++5otgR7mXWULZijrdyBLFacAF/
         BxdWxQgEgiwboU8wCnnThXjRpo5pDwsA4O2nL+sgj+7fnTnfPAYgH0elatTxz2pImwpZ
         gsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741723421; x=1742328221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW523EAS3Rk6Z2Gf4pN5+J61D3es3lTSy0uI9oNxP9Q=;
        b=Lmxg91ndXHuiUmhUAMRugNagKS8KNw+8nZfZhLJnPl6RpI2QlQEYk0njfGH/CsiPmc
         ezPklkYZ7z0mArntNk+cokof5XEG1UES2ugNYOiLUNd1onVcj9y/0zwVCWe5Fmua7+IX
         Hz6Wssop1AtEV0hCVZkZ16jzDYTVAz2dmlLU9XGl+ZYsmkZQqI2sLsUPb6E/H6WhAivV
         47QA3a1LhD0xc6mhToFBBKEU2MCkGA4V0gJyQ55AwPj2IfI0kl47PsHvT7vyi+7p+Kjl
         9n09uCHkdgS+gXq/tRKBApqTaT4wy8iyKXGEjVFEDhFOU2YRBWLmiFnxPO2myGd0witR
         v36Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8lwvlGY8JUeAkgw47MyORRT1fCinn5Coa2u7VdlzQziUlqHlQ43ObAKedVHQhmytAtHgW/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh5mn4f4vp/CBQ8ACGAJno2eRfFgZEWLPnJ0tJgEPWnLbcSXUo
	HyuwzPAe6XuQXJ5y5Ve5JJnPSFQ+JBsgXz2K+5sDSW37KUXYbhzLTCd0DYS3JE/6D4qn5U/Pg9x
	Wub7dtduJJue7w3QAHh6G8kD7uE4=
X-Gm-Gg: ASbGncurmtsQmGqWBBBOfUogzT8cQg782XTsIHoVh/yJxTab0d8rQh1JZT6fevfYfYm
	ACELhwK/Lk3lcaMi19q06N6XI+lxzlS5mnpIA0fcpeissa3fA9Eo3PnVRM/JvA1kEWoynnosVFX
	MQ6to8TLfVFPcT4SZ9Ihr1VUBM8ghQtz8ac5EhY8Dvcr6y19N8eieahG5k
X-Google-Smtp-Source: AGHT+IFYEIdqAXj57O99Zh2iip2gE6hYr3XolthP5tdHAJes3eWs+x8BQxcINUUI2peKOTGt7uFekvG8SKVQk3DUgs8=
X-Received: by 2002:a05:6e02:174a:b0:3d3:e296:1c1c with SMTP id
 e9e14a558f8ab-3d468921f95mr51075145ab.9.1741723421512; Tue, 11 Mar 2025
 13:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
 <173625436399.258197.10961901698600591079.b4-ty@kernel.org> <20250311175528.GA5216@willie-the-truck>
In-Reply-To: <20250311175528.GA5216@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 11 Mar 2025 13:03:29 -0700
X-Gm-Features: AQ5f1JrHvI_RF7xvW5BrP_PBmrcW3VTWeSbeCSaeqxqwJS9gRSEMDCWlVX4sKfA
Message-ID: <CAF6AEGvDyPtXN7Cn98BKsTM9GjUzy1sTEOsLiz-cdvaZ14qWyA@mail.gmail.com>
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

On Tue, Mar 11, 2025 at 10:55=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
>
> On Tue, Jan 07, 2025 at 04:42:39PM +0000, Will Deacon wrote:
> > On Thu, 12 Dec 2024 20:43:57 +0530, Bibek Kumar Patro wrote:
> > > This patch series consist of six parts and covers the following:
> > >
> > > 1. Provide option to re-enable context caching to retain prefetcher
> > >    settings during reset and runtime suspend.
> > >
> > > 2. Remove cfg inside qcom_smmu structure and replace it with single
> > >    pointer to qcom_smmu_match_data avoiding replication of multiple
> > >    members from same.
> > >
> > > [...]
> >
> > Applied to iommu (arm/smmu/updates), thanks!
> >
> > [1/5] iommu/arm-smmu: Re-enable context caching in smmu reset operation
> >       https://git.kernel.org/iommu/c/ef4144b1b47d
> > [2/5] iommu/arm-smmu: Refactor qcom_smmu structure to include single po=
inter
> >       https://git.kernel.org/iommu/c/445d7a8ed90e
> > [3/5] iommu/arm-smmu: Add support for PRR bit setup
> >       https://git.kernel.org/iommu/c/7f2ef1bfc758
> > [4/5] iommu/arm-smmu: Introduce ACTLR custom prefetcher settings
> >       https://git.kernel.org/iommu/c/9fe18d825a58
> > [5/5] iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500
> >       https://git.kernel.org/iommu/c/3e35c3e725de
>
> Hrm. I'm not seeing any user of the new ->set_prr*_() functions in
> linux-next yet. Is there something under review, or should I revert this
> for now?

It is WIP, part of a larger patchset adding sparse binding support in
drm/msm.  Please do not revert.

BR,
-R
