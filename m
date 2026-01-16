Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49961281376
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577293; cv=pass; b=TugJJ1uUC2QaJgKxpNZmte/LPCPMpllWZw9BQU5Ndd7QVe+0afRAw4WN5rYdV2WxFqeAxgG3LW4SG0RO40yO9VCRr7LuMNcXH7trNA5Kk4TkWaDj4tuLXksmTxcqrFdaPnKlrk4pMQpLN4o1c8UttLqYJLZX86LNzhTyl6dPN74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577293; c=relaxed/simple;
	bh=1qElG8X2umkIbf03aR+EqOOQskFCiq/AFRNxGOfGRIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+EVXBqfxN8Ezp9qGJGiMYQ+rCtTyMglUemeh4MieBHJ4Gnsy/nvqRGkwiyGoqDzlcuJa9frtCGaGVSzxbsfBYFIi66AeCvjXGRRSRevOAj4uv64PhXRv+61InLbJl33mYv+7sTQj8OQGkxTcvDAXYUjPaWnFhMQGbtUaQvz5t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bzb9OoIL; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzb9OoIL"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6a868ad45so156151eec.0
        for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 07:28:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768577291; cv=none;
        d=google.com; s=arc-20240605;
        b=AmL1dGiO8NZ2DRrtZgW5tHOtUbm1MAPK9O8jXeKKE99Ij/p4lYLbNUva+4+8dZjUP1
         4URfqwzDKXuPwJw0sbW5IvybgbXbINN2mvbbV8ulCQjFIXA+xnmf8CfYejGgHS//h6iZ
         HtpEU1Zf4D4hlCPUm4UR5/Mn41ryBDf/7CkGTGkfylnx1Pt2xGUug+847aD/uIZ63PND
         d2elq4OiIiCecOoQhFScWAYhYLbCsAFdIQ3Q8b2U5KHRIZrL5w8z0yO83nI2pYX4WulT
         eNb9ZmfS/FB/rFEJhxqNCshJqJ7/cbmnzMD5q//MAPu/z72JfDrazNzzdREKvI9wNILi
         mmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qElG8X2umkIbf03aR+EqOOQskFCiq/AFRNxGOfGRIs=;
        fh=Nh0b56iHp0DSa3APmMNxPd/Pi8Kea0dDq93n4FBK/+c=;
        b=BRDsrOcuLVCCaiOK1mgRLZDUNBHzumKo9xRYymAapzrEfr735tfUp+9DM5iyHhPclo
         HgkBeqnrbCqmqe61WxSNLPtOjvTpvUBn+lCM1fx9RrQuz3+S8CAg9OLl6ef2j/lm2KLT
         4C05DkmJBQy5e+VMlifdXt97jxugYO5iXL6045ln3B+nc0TbOJ9Cljl8HNRE2ER5hjHt
         lsETf3K1YWUanqUMkmLUYPUuKkyao6ehlDZEFGUAvB2Y6ZhPdkeCXPcPReKcoQYnQQvW
         tg/YRttsrA8+KxkcR0HSnirGbw5KgkjR83dvB7R2M/OESk2+Up65GnTSV5+f5vrELV/x
         3b1w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768577291; x=1769182091; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qElG8X2umkIbf03aR+EqOOQskFCiq/AFRNxGOfGRIs=;
        b=Bzb9OoILP7YLxj7/2D8EA2ink9x5fQeVhb49chVnupKoMNkQfGh2dZM0BNrc90pimX
         LRmglWOHo+0PN3hVKpG6WtBGC2Q1qWIvHB6iTnIgRtnBX151X4vTzRWNX1uPi0QFEjt5
         2au+pyGpu7F6HzVw6ijvdu9OBrKXepyU7iU7MAT35TgJUbWsRJfiXW2vp37TwxEwQsfL
         WkHCj0lkot0CQknPnyML+W8kHMNooRhEKR8n+mrc2x8+yep+4SI+i7n9cFrzlbXmcn9V
         5+/uQJjRDgESjmskk7LFnJn8fMUpZCB3Q4D8IDhgXko7nbmgDkXrV3CI8UMXp3D4GXBf
         /SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768577291; x=1769182091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qElG8X2umkIbf03aR+EqOOQskFCiq/AFRNxGOfGRIs=;
        b=CWJ9P9zw9d6GIp5PNQU5DYyX5EEIu6W7dH0ncqoQ1aTiDw6kJXQvhtD1HhFcLNZGKa
         D/ybky+VsfpTkroKYhOki+0ZnwBrvl+m7NRHMNTwhRnpQhP1A+/QHhMG8BFX1kXaSlEB
         /YLyOlXvMl0vZUFbuxbwqidkPCvd/+IX74zF/MJdeJBlTbYtcaSKKNwmnZuHrymroS49
         nn0/kpx/oBN9ajq1Xr2Us2Bm4El5M4iVX1BvdypodQ61HRbBg09K1FaYuC9wOSci6HgV
         JoGOlf+GY5gfpQrzBu6rz3PWZ1eSSQHQ3Hd3SeJYSas125HAwBGJylGj8T7NbGilObim
         OWQw==
X-Forwarded-Encrypted: i=1; AJvYcCW9SKGT6qiadWMv5QE2wis1hwX5hNythMJ7sgsLEi8yM7zHUsrzq2DKvKDcO6X+oz2Kau60SA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5xkDYBRiKEDYCfRpcjVzBNhckX64U2Z1djZRsq+Vghu+Hnonv
	ZYBFCOOY6PCiLRwyDQ1CUlTkmP1qYHfSgVZjVY2o98zy/uyO6nBIJMu5nq9CSS2svKJo9oajitT
	ygrSGhi7ptV+PPFjOfA5XA9ffJakdeB48sg==
X-Gm-Gg: AY/fxX4FgisZ6DMVxxeok/3q8PdIW1pzdM1a/Ipmb4Uz/+om8aXTbKhsVt6PpgnVuvS
	QHZybRJHPawDZEIQ0ka4F+3teaa95FNqi6TwiFXKSFxrbx3kah+rMTFQPBaa5Z5mXSYsDN94Ipu
	meu8RXZ8jpG02aPNl88JOK5N0UjUVG1dda1SKfblPuQGdkSr4jU4ebyHgVRFL6j1+8N8OoEQwrB
	Uh1wFeW66cnipZNgSBUeb8oO95yAEY+p0DFJfJjIEJeC98KPutgdLnUm0OkCqrulJJD+ar1
X-Received: by 2002:a05:7300:aa8d:b0:2ae:5d59:3ef6 with SMTP id
 5a478bee46e88-2b6b410a06bmr1345513eec.9.1768577289827; Fri, 16 Jan 2026
 07:28:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
 <20250418080130.1844424-3-baolu.lu@linux.intel.com> <ygaqzsib7bc.fsf@localhost>
 <20251230011916.GB23056@nvidia.com> <yga3445n4wt.fsf@localhost>
In-Reply-To: <yga3445n4wt.fsf@localhost>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Jan 2026 10:27:56 -0500
X-Gm-Features: AZwV_QgWpPav71ZZWpsTh0CgMtSK2L4MVlujgmnMBgyJFyhEizbG3LABS0iTRc4
Message-ID: <CADnq5_NH0DiyE0M44AzaEQhmSksj13wVwEK_Y2JHj3OLEPs9Mg@mail.gmail.com>
Subject: Re: amdxdna breaks suspend (was: Re: [PATCH v5 2/8] iommu: Remove IOMMU_DEV_FEAT_SVA)
To: Linus Heckemann <linus@schreibt.jetzt>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Min Ma <min.ma@amd.com>, Lizhi Hou <lizhi.hou@amd.com>, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:12=E2=80=AFAM Linus Heckemann <linus@schreibt.je=
tzt> wrote:
>
> Jason Gunthorpe <jgg@nvidia.com> writes:
>
> > On Thu, Dec 25, 2025 at 10:05:59PM +0100, Linus Heckemann wrote:
> >> It appears the code removed here was not in fact entirely dead; my 202=
4
> >> gpd win mini ("G1617-01", with a Ryzen 8840U) fails to suspend
> >> correctly, and I bisected the issue to this commit.
> >
> > The only behavior change this patch had that could be relavent to a
> > Ryzen was in drivers/accel/amdxdna/aie2_pci.c - are you using this
> > driver?
> >
> > Prior to this patch amdxdna would have failed to load in configs
> > without an iommu as iommu_dev_enable_feature() would have
> > failed. After this patch it will load successfully.
> >
> > If so then that driver presmuably doesn't have working power
> > management in your system.
>
> You're right, blacklisting the amdxdna driver fixes suspend, thanks for
> the pointer!
>
> @Min Ma, Lizhi Hou, dri-devel: do you have any insight into why this
> might be happening?

The xdna driver requires SVA and the IOMMU.

Alex
