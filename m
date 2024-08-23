Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0EB18BBB1
	for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433317; cv=none; b=UnUbrTnGZvbtbCpnjTS2yJ5bYuiHKMIU2ga7ETw75pe0tGNJzsBMdZpfYKcaAQNXVydcEwbwSEXFV6mnRKAcGGQEGtZNf9aWsCCDQ8V9eVQRq7FpmyRvXFFN0+iYdXUZNci4TU7ff+R5nlBh5CCnsMQQyqjxlbKKpa3LHciljYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433317; c=relaxed/simple;
	bh=BeQ2C/a6Nik0iT5adRG+M6HWcI94cjAt0cYwTtfYctw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwnwLVwWTeTk67y01R9K4IsKszC6JctHHeC95wOwc9e+zrqUFcmjO6xfccup8X5NYptb9CEWzRZE+Wm0sI4JhjH+sZS/leRqV4VPaXHu5ZeyqrXFJblBu3Z6/XoQbeHSGGXiLelCCarD4Cx9Jb19TJmq8/69PggWyZwYPql7CFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpNQTv23; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpNQTv23"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso3591004a12.1
        for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724433314; x=1725038114; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0bo3lj17iVnA90Gvdqs2ukstbOsPzvxj83rTZR10+A=;
        b=BpNQTv23KnfZ1zKk+tgM8FKFHO5bkFz8rDUyYp60JY3VbsEd/R8K1Btn6dOnMAKSc9
         QIIi7OjlS1AUXI6tS2wS9YrCKROThhXSeVBx35ht8yYFsgvw9hvI9iQEiTHl1J8dXbHU
         d8E75syuKbw33PZHl5pqxkhIc+2sGoUCM+gf+lbaaWOdrfIJAZatXSq18GFooG2Xjw1F
         eFhSnZNNomLaC4gfSZRXLzu89wVfm0cwVEjJWvScuIihoJ2/Lf5rqGa99WVSxby27Ild
         BHYlB8+5B8CwqfsSBHgFUHFjUkqdmKS2QyuQYSzoeVUfNaUmV3X2PayA+HKc8p2TxFXw
         0oKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724433314; x=1725038114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0bo3lj17iVnA90Gvdqs2ukstbOsPzvxj83rTZR10+A=;
        b=sL7FarIx+b2mySrEiOoqkOlCY0S3OnaIyfRCqVJQvnI3OaVXPO/c4FEkr196z5FjfC
         eq3x6txrmdWZ9NG17Y/EbWDYpJN2H1kHKzcN6jnTpX6m5wzsyP0mPb2Fm1XSOXB08gVQ
         CH8v81x+XdlwQBkns2gJhxlX/pgcM5u605D5XgcS/5rs2uSoa42C3EoKM7/bV4FEcFYb
         aN9P4p5RO5NwxdrVR7ur0UpxG0R+gdFxAv9HfFgtvL+oLQ5t6GMfyOTc2REQxX2Or3kp
         z0HofLR8iyzmZecN0EOrKFtMUxY+4dbICnAhchExZHj7KCXMvCFfSVZAF56Aym9RG8r+
         s+HA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Go6fHd9ZAMAX/mGT5g66Xa8mWWGO3Xav5Vgdv9jaEYMGGt/7fQgoAU/2K16smpd144wyjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFOHWrsT0XBLavg0UecSXFmVLWmoL+ii+2PX1tGL1NLvkLRGv+
	ExgwxX7IONqYhAXYP6zG1KM/hIuT+C+ugiizQbDzKxKo3mWVSqyJpDg0RneFzSCL8E45+EHjNkZ
	JxHTYmuqiBt0hM6iGH822toSBHVCISdoB
X-Google-Smtp-Source: AGHT+IE6MvFowzN02CjJzPs0k5dyUkv2PK0G9MOkRAFWX+bbxCEs/JW0C5fXEAC/8Vjdnp4s4/NyulPlrSAm5z/s8jI=
X-Received: by 2002:a05:6402:42c7:b0:5be:e9f8:9bbf with SMTP id
 4fb4d7f45d1cf-5c089164ac8mr2279242a12.9.1724433313417; Fri, 23 Aug 2024
 10:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729-topic-845_gpu_smmu-v1-1-8e372abbde41@kernel.org>
 <osxynb352ubxgcb5tv3u7mskkon23nmm3gxkfiiiqss5zp67jf@fv5d6bob2rgp>
 <CAF6AEGuWULwrJDWW37nQhByTpc-2bBYVv3b_Ac6OCwaJ83Ed9w@mail.gmail.com>
 <CAA8EJpp9zaQSKbis7J9kYTudTt=RFhfbzeayz3b-VbGQENtqeA@mail.gmail.com>
 <3332c732-4555-46bf-af75-aa36ce2d58df@gmail.com> <CAA8EJppZsNTqh_KxD=BWXjmedA1ogeMa74cA=vVbCWAU7A-qgQ@mail.gmail.com>
 <d766e2e8-9f3f-af3a-bb5e-633b11bce941@quicinc.com> <20240823152147.GA396@willie-the-truck>
In-Reply-To: <20240823152147.GA396@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 23 Aug 2024 10:15:00 -0700
Message-ID: <CAF6AEGvd6a4a2Wbm_D2mhg+i7bapDadgnaOQZU7m68uA8SS5Jw@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/
 16K pages
To: Will Deacon <will@kernel.org>
Cc: Trilok Soni <quic_tsoni@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Konrad Dybcio <konradybcio@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 8:21=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Jul 30, 2024 at 10:16:00AM -0700, Trilok Soni wrote:
> > On 7/30/2024 1:50 AM, Dmitry Baryshkov wrote:
> > >>>>>> SDM845's Adreno SMMU is unique in that it actually advertizes su=
pport
> > >>>>>> for 16K (and 32M) pages, which doesn't hold for newer SoCs.
> > > My question is about forbidding 16k pages for sdm845 only or for othe=
r
> > > chips too. I'd assume that it shouldn't also work for other smmu-v2
> > > platforms.
> >
> > Yes, my understanding was that SMMUv2 based IPs doesn't have 16k suppor=
t
> > and it is only starting from SMMUv3.
>
> I'm not sure about that. The architecture doc for SMMUv2 talks about the
> AArch64 translation regime in section 1.5 and bit 13 of SMMU_IDR2 says:
>
>   | PTFSv8_16kB, bit[13]
>   | Support for 16KB translation granule size. The possible values of thi=
s bit are:
>   | 0   The 16KB translation granule is not supported.
>   | 1   The 16KB translation granule is supported.
>   | In SMMUv1, this bit is reserved.
>
> so I think Konrad's patch is about right, but if you want to extend it
> to cover other implementations then that's fine too.
>

Perhaps that should have been "qcom's SMMUv2 based IPs doesn't have
16k support"?

At any rate, 16k sizes don't appear to work on sc7180 as well.  I
don't really have any other data points but it wouldn't really
surprise me if this applied to all qc smmu-v2

BR,
-R
