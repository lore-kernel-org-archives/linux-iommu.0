Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7D1F5435
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495194; cv=none; b=YoR02R5SdCQgcGa/sekaI9kF9Qou2oE5RWZBXxI9qMGWuK6f3zSGtFQhQSSw8fLxkF4YZbYyxWTKzrsxBo+EAx+shQX/WaETsOSdG/4x2ZPd8me5WVoow4qQfCvWpjjKB4b6dRicAgSMHHibIJbp2b3h2L/QN2frnP2w9AQckwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495194; c=relaxed/simple;
	bh=DFUI3MpGGkbseTkztZ+yIQpjol+PGIuUpMv3ocf4nfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHQFI4tzmQ9w7Qq7zePx83qqJaCVKVJTvwh/3JQ/Bvnn7Kguabu5frhsqW0GnDLyWqupqqCZEF4hgiRRHxQwZtiUw4dNFtSzauSoPWeUgXJGeV9mQuOIXRfnPSbhfm8GvqsvaNGYJXk8V2Ao0dshFKmyDiTUJkedYMm0GslqhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjZmPb/0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjZmPb/0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee94a2d8d0so1268141a91.2
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 13:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737495192; x=1738099992; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFUI3MpGGkbseTkztZ+yIQpjol+PGIuUpMv3ocf4nfE=;
        b=RjZmPb/06SWbM2mv7+RBc+WG5hBeM9SDPXhMswzqU31Hn6yP8C+FQlwB+UqjL7RItP
         R5EY8/lcU8eJ3Gl0iMyQ//tKg7phisjyZ8TahG2r7tXpk2wz1yy/UkflsPQZ9DRTP32x
         CNCR4aIMTuHmlaaFwsdd9t9Q91jcWx7Q+a7ZsIU6siUdFqd2TCEvoB+8yfCm4qeQUSaT
         szk7a111CPhm+4g/DKQgoy9+Psz20AHydsqMMb1C5kPD4l1AfWGC65KKZaVFGgaIxHeJ
         /65hiQyrESlzyNz4udbdAfTPmeb9QvvY7CtCmpXrWb8IOubzNmSBI6HUXnqPLgZbV5VC
         dN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737495192; x=1738099992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFUI3MpGGkbseTkztZ+yIQpjol+PGIuUpMv3ocf4nfE=;
        b=myvRX4/1ACEtHTLhvR3NJO7tB8hYyP7qUJq3A/M62ILRM8NGbSYIrZ8y/7x2UbKv5E
         i4QPlllD0VaRQIlnh9JeRFAoC2SLbfHuCVfTzinvCNN+7BTwGNdb0rFN9nhN9NZjKPfx
         gIM9Tsvf17DrFKFpH8ah+RWKAxoI+NZrlUNvggAaR76zbQ8yfIkNCEtdScpdrguDwjKK
         jQ51VXaMnJYX3XxyId5NxY8pFTuWd6r21vnQ0OsuYD1AXsSifgDffS9R0OtAvYqPgBss
         gKYViF8aGD/l0EgI7Z0juSLgfCPTOFQ/t/At+WIyoU8pAa59/myRlDX+Aik2S888qWmT
         aO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8CeUgAMe4wIObJ3kR9ulRxwyhRuu7ubd/NFxTSmuKBfj9QQWcbyxISKQFAaiordJbcVImvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6aqcKs4ggS4oe4+i8rbgBAgYo/8qILDAhxfJaVh6IoIO5sPRR
	T2g/H0hMgfraztLA/1shQvy0ULWWbVL2Nlo/6u0Ypg8VVaaK1XTvAob0ohG5mG9FOE1T06xvSIx
	+r9g0vC3nta/nirsZ1oUJji7u/Bk=
X-Gm-Gg: ASbGncv/NLDO9YN/gxXmo+vRumYHn1rE2CxpWYK56zL0NWFKNzt8klWtzW9c9MnEpNi
	it3RxazV/tAR8vLvFtkfKHzb08gf4WMggf1cNSo8bdQXZ9ka3V70=
X-Google-Smtp-Source: AGHT+IEcjzdGu7qYqGn5N4xEYIBOsyWiwpCUBMJHTPuLbHn2zBtCvYF5lxRNHxNZ86fRxljxMK5FHYvAnIcG7/4OKIA=
X-Received: by 2002:a05:6a00:2e14:b0:725:e499:5b9d with SMTP id
 d2e1a72fcca58-72f6ab9b6f0mr666087b3a.3.1737495191872; Tue, 21 Jan 2025
 13:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250120-msm-gpu-fault-fixes-next-v2-0-d636c4027042@gmail.com>
 <20250120-msm-gpu-fault-fixes-next-v2-3-d636c4027042@gmail.com> <20250121210818.GS674319@ziepe.ca>
In-Reply-To: <20250121210818.GS674319@ziepe.ca>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 21 Jan 2025 16:33:01 -0500
X-Gm-Features: AbW1kvb6ejz0Edpb-LSeUnSnuaoYq5_MYqcriJkrf00pfJrPDWvH4y-7_JTCMIM
Message-ID: <CACu1E7EgYzsU1AJfi7MJ9QjX8mypPw0mxcCkX-H59hSaDFnd5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/msm: Temporarily disable stall-on-fault after
 a page fault
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 4:08=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Jan 20, 2025 at 10:46:47AM -0500, Connor Abbott wrote:
>
> > To work around these problem, disable stall-on-fault as soon as we get =
a
> > page fault until a cooldown period after pagefaults stop. This allows
> > the GMU some guaranteed time to continue working. We also keep it
> > disabled so long as the current devcoredump hasn't been deleted, becaus=
e
> > in that case we likely won't capture another one if there's a fault.
>
> I don't have any particular interest here, but I'm surprised to read
> this paragraph, maybe you could explain this some more in the commit
> message?
>
> I would think terminating transactions and returning a failure to the
> GPU would be fatal to the GPU operating model when the entire point of
> stall and fault handling is to make OS paging transparent to the GPU??
>
> What happens on the GPU side when it gets this spurious failure?
>
> Jason

It's touched on in an earlier commit, but OS paging is not (yet?)
transparent to the GPU, and we aren't using stall-on-fault for that.
Instead we're (ab)using it to stall the GPU while we capture a
devcoredump with the state of the GPU when it first faults. Stalling
prevents the GPU from moving onto another job while we capture the
devcoredump. We only keep one devcoredump at a time, so we don't care
about subsequent faults until it's read and deleted by userspace. This
idea is taken directly from downstream, which I suspect is why the old
Qualcomm MMU used before MMU-500 violates spec and terminates
subsequent transactions after the first one stalls - it's helping
downstream implement devcoredump without this workaround.

I can add some of that context to the commit message.

Connor
