Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F1524BBE1
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752183; cv=none; b=iHIgbrIU210OqRX9cqhZVZCxmQtyoj2HbxnztoJI1Pnqh7oqsps1JsXSiXz0KJqvSx3xHw+7Hzi6urXt5cE0EgGeR51OUzvmIfXkyd3WQl3+ANmbTAd9qIA2QLZHxr0umWCicMDD5Hdrk0zH2hp2X9cod1GXnX+gFGJG4HawOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752183; c=relaxed/simple;
	bh=3M48Bi0RAMhbjAINU8Rj4l8VTLi4EPIWgknw+A4XTeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2vMKZMvB04e+ItG8HME2qXVn8k2+bkhIBjzUjOyd1BNEXKOUWRsFOkjepfTOmdFH369k9jd8at69jmIXq0wFAonKw5WrXZtdk624MM6nb/e/Ba1/rqVwMcIdKfNxLU+jVkx0OBfRkchaqo/iuP86Rb5crXwzbrc6Sd/PlhYXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMSuzqpS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMSuzqpS"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30eccc61eacso369618a91.3
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747752181; x=1748356981; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL9VnS5cf/6NW/p94tIKHT/4gGzvfJ3RyyiZ0fUNEek=;
        b=mMSuzqpSfOZ/MdWyt7FHOSgdA34CqZLC2VKbpFoqy18joRQYmxQweB+UdGB6tAM3JJ
         2tXPZtNmL6IMAZFNm4LpLIP6RKfakc0YBeF6olc8+jixpyhF4wwUYAHpRgOLx65DX8En
         eELsG5mQcBliG/MDJ+yiy/RGas6ZUHyGIWJcdc8+vmpEEFSZHSHNvDHWeAeNKuyZAUem
         M7m6caYWI0sxruWvQWNdNkTFTmN5hhXGEWn0Q5BS4tqwWO4Qd5w/OkA2DbKNl5+o9xcx
         zm5a6qIE5ojYkhW+gLcJ17SxoFVxRSHRKZj73cAbK5awUZsSBS1fmTwa/6TksMf0vlqa
         i8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752181; x=1748356981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NL9VnS5cf/6NW/p94tIKHT/4gGzvfJ3RyyiZ0fUNEek=;
        b=OwmqvgA30wKvbc2OpHb/TR1p+ss4bZM9emxs1x5YT8Nm8ibDY1rCWRBzvzIG9nj4t0
         vzUwMfYhVV4JpBBgTS7NGpj9ZKDgnipawNLqmKxGbHO5ZkYSOsFM1ELRHZpmB546lwZY
         earfIKu60waGH1y/sXR7SAf/3jZax5CNkgIne9XMZhMXqIjvalZHA3gtpbMUI5TnWgQT
         moWjGoxDZA3z+fC6pQVYyr22at5OoMS7RL5ioDxjmgBOSNgZsbriNedFI96ewGUlW7Fv
         PoP7Wp5u+MWFNe8hNKrSAGRcN1Ll687MM7QzcknHOXkjTj5rU3bB8dJ1llDeOi5TJ6cc
         vcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvlDtANi53rUy4PQkJMY0usItGDBPJg9CWun50+Qaai1bEHlHGfSNZwvsC5zBIFE7pR+eFlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMouHWdNqrH44Y2v57+a0UNRQZfnWU/e7uTdlwyEHtnfw0Zmd3
	5mhXMSpahkMiXEv2PcBZinbI2a+SwabGDZ2vOzjQYRYGtF+Qy5BjanUALxK5v8hGRdKzFBrA5+1
	bSmIAFp30Sxwt+TPt9TS3KlaWATw+ruo=
X-Gm-Gg: ASbGncuEELFomeHHA03QONaGrR8Kn2hHRU6f84L3uc/wOPzb7RCL9M+pzahW2DaioYb
	5na0Fndb2qN3JK39R4B22pS5BalKo1zQ+4qP72OI6UXj+LP/snRRRxPLRHv05+XhzhY3liDzsSs
	NMp2KBVfj+Q/BLRNOfeY9MalwOpeKousDQ
X-Google-Smtp-Source: AGHT+IF/aCn3KuIR/kknx0aBZr7IzoK3GvwOK/L+4l4anpA0Ks1VE8JmQjWR6x3bz5ayRXEdRHZ1M4ocBueOSYEkMnU=
X-Received: by 2002:a17:90b:3b48:b0:30c:4b09:5f3d with SMTP id
 98e67ed59e1d1-30e7d61316bmr10052600a91.8.1747752181324; Tue, 20 May 2025
 07:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250515-msm-gpu-fault-fixes-next-v6-0-4fe2a583a878@gmail.com> <20250520141857.GC18711@willie-the-truck>
In-Reply-To: <20250520141857.GC18711@willie-the-truck>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 20 May 2025 10:42:49 -0400
X-Gm-Features: AX0GCFsH2VOZ8YMhHMV3BqM8wqyCOVzoUFywTVBwakEJMPVYAMwwsNIEoTGSpRU
Message-ID: <CACu1E7HdJvbx_6L9KvX3n78_cbkrey8npo=O=AkEzg335wJC=g@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] iommu/arm-smmu, drm/msm: Fixes for stall-on-fault
To: Will Deacon <will@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 10:19=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
>
> Hi Connor,
>
> On Thu, May 15, 2025 at 03:58:42PM -0400, Connor Abbott wrote:
> > drm/msm uses the stall-on-fault model to record the GPU state on the
> > first GPU page fault to help debugging. On systems where the GPU is
> > paired with a MMU-500, there were two problems:
> >
> > 1. The MMU-500 doesn't de-assert its interrupt line until the fault is
> >    resumed, which led to a storm of interrupts until the fault handler
> >    was called. If we got unlucky and the fault handler was on the same
> >    CPU as the interrupt, there was a deadlock.
> > 2. The GPU is capable of generating page faults much faster than we can
> >    resume them. GMU (GPU Management Unit) shares the same context bank
> >    as the GPU, so if there was a sudden spurt of page faults it would b=
e
> >    effectively starved and would trigger a watchdog reset, made even
> >    worse because the GPU cannot be reset while there's a pending
> >    transaction leaving the GPU permanently wedged.
> >
> > Patches 1-2 and 4 fix the first problem by switching the IRQ to be a
> > threaded IRQ and then making drm/msm do its devcoredump work
> > synchronously in the threaded IRQ. Patch 4 is dependent on patches 1-2.
> > Patch 6 fixes the second problem and is dependent on patch 3. Patch 5 i=
s
> > a cleanup for patch 4 and patch 7 is a subsequent further cleanup to ge=
t
> > rid of the resume_fault() callback once we switch resuming to being don=
e
> > by the SMMU's fault handler.
>
> Thanks for reworking this; I think it looks much better now from the
> SMMU standpoint.
>
> > I've organized the series in the order that it should be picked up:
> >
> > - Patches 1-3 need to be applied to the iommu tree first.
>
> Which kernel version did you base these on? I can't see to apply the
> second patch, as you seem to have a stale copy of arm-smmu-qcom.c?
>
> Will

Sorry about that, for the next version I'll rebase on linux-next. I
was using an older version of msm-next for a while now.

Connor
