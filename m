Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792790019;
	b=ztidF+I8YJWQf2aVGXfOsRJpX0xavH/LcIUZ1r4I/OV4/Wz9bbgvuDPjKbUhh+SN2Ddc
	 W5UTFuQkhfUUyPDt+kvpmtejmxplBnER3QTLY/Lf2gklyxD8JTcHzpzOD3lgN6XqV6vBD
	 fnIyNJuCk9mRESyOo8+cU0nxaNjrEpELuBuzzDyRtXgkBqmCQMxihqMi9klrBJj0we+1v
	 COmAWclaVmTDFi9arWVyPyGsyPQ26Cs9cPiVxT39RYVoQVxIC4//2qmPuI4GxYZfTBPuO
	 NDHc/ZDzP0SbLVAq6LXnOJuepUuQAVPuIlSr5hfJP6+orRJ9Co9WKsIbxtR0msvTFpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JUnmhWE/6nuKeVluLworAnQepkBWhUtRWFlIO5F95AY=;
	b=zsn7XR+dPLf+WGAEPzi9PXB4Bvh4uUHJd/qkij4v55zFR3WdSOPHaCtBP3Lu1aJGLx2e
	 eal+rdeyKB2tD0k+hOuQuIcE8GQvjeo0klPhLzfYeBiSySG0wVL4F8Mo0a60VhGFtXEpe
	 zIGd5ItwmKJcIa9HBQHZspZv6ClEchGE416rzvUqj+pQ2I6AvIW2oan+8QXMXEkkO6jn8
	 Fe9Q0L6/G5tIajA9XqPb/SaVJ/58JVHZ8KdiQhxs3snOD5RXBs6x/1Q0ukZjJIUZtbz+D
	 RhzEeYU1oaOzDS6cdblsjwzDQNt1QMwMwh9JZDHX3bUrlBHL2UFRVmqtjoJ32VwwRdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fMWpLq4f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644C606A31B
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 21:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6644C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fMWpLq4f
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ac65e845a8so11680781fa.1
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 14:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792790017; cv=none;
        d=google.com; s=arc-20260327;
        b=JtSr/QPX2clstSreBqWkAQI1TMOW7QUrFb4mPOeR5NJbIc4q5LsWCrStiOwQHs/zb/
         FeIHXYGj1LAWhjK4VH2HTDAS4dF9fIeA204jORuIuY6aLLMC02CHHD92BCVBx6xdqQw3
         Q3yYWosmv6y7U1hqY0ijloTOYm/YP5gLZDbc/AmsZk12M+lCVf5ZGYrTgp17mQy7AYkA
         Dt/5rhzJu+2LKS54CW64jJhx1Mfyj1vlmgOpLmcaW0ZnKu/RQHcEHhVSx62BKTK58LBf
         mqeXj1yLAIrZe4N2zjDo19oiiMrONkMAhey/0iyxncteMe4z6n5+Ra8QXc5RdU2U5kpk
         Wv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JUnmhWE/6nuKeVluLworAnQepkBWhUtRWFlIO5F95AY=;
        fh=fYszpnfmpzkBtbXu93+LEJ+CUUAnQeiCEOhK/3fXzlg=;
        b=GoLdcvZfyOmS3U2UqpyHGnq67/IRi+LYFQ/lcAMNty23Lc1DJ+rxWW61bsdYp1aP72
         hEkhJKnrx8ZT58a8Vj4RBbpMhhV1N5GraWt9Zw0FsTv21sW0gEpGwwtnu/uTXeTvZC3O
         2JcxnSn87YMjPbIJM6iNyBT3nMRcr/zg13PnISjETdAyx2SmEH2QQ1ciQBoc9LZgagbe
         bqVsMZe1UHXEXpJJQz8/Tw+spbM/6GwoQkGJWRD6xtewr/TCCi9chPZYk6TYjNS+AdsX
         BAQRlnDW2ppVFiBiEaB25YNNaf2kFaMaamBMg+w2wZ3O3y/b114J4VCPYniGpay7qF5P
         TknA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790017; x=1793394817; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUnmhWE/6nuKeVluLworAnQepkBWhUtRWFlIO5F95AY=;
        b=fMWpLq4fVm3cFTHpIkF0WA34OaEv5NXhsix83LJ2suFg1BrdWU5Y2+eK+KNk3H8Lw2
         RmmQN8G2sUA5mgmVCTY7UYLdx7s2kAyXlE1sMFAUWtSt8WwkzhQt1uBdq9ex7A5wQ/7V
         OORAn0PRFk0UUMboyXt5Ru4iFjTmIn4p2oKyZCYCUHo++skrd7MnLy2NV4rFZ3vB1a1H
         4MbooFdOnoiJDlVzheuCVJROF5tpxAtyljH9u26y+7klJ39Ls40KOOAdoX5otFKQQ/GE
         /TdHPVwPHJJVfinRg+Y78TRXhkr91fxmXhRac9HZfenlrNWTE7i6UDMzl2dL38pnQtpq
         sk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790017; x=1793394817;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JUnmhWE/6nuKeVluLworAnQepkBWhUtRWFlIO5F95AY=;
        b=GW4U5yEuj41jPmG4qjz/QQaSDO2FSzALaEpB0mhkpS/iuur7RjyBdlCKSexhMKwIbw
         Ge3FXg4SXbt6zic9cZWCzD42UK2pxPqrVgEZBG7RezWy456v9fECoLRP4/MNP26dtrTq
         nZUkqgJ9yQVV2weRma8WY8gThPIlYZl/QZ3vKBABq4qBklnyY/c8onrWQljF4uCSBcl3
         uaCDV0p9dL+ZJMRLHwuvfgDWhPeIkYG0Q05Y0OQrYMQydBwLQynpsFmv3o4S2hxmOfLC
         iDk1HaHOaQUgo1cQf7l7gCMxvMae5WpH/ogIC1N6/B0QeNAqIVKoiQgp6lXCcuDX5zpq
         fYDw==
X-Forwarded-Encrypted: i=1; AKwUvBwHKWbfgIdRqOVwh7QCpq3WhzxZUPqsClskl2kNnS37FaD0orgWaTcld/LZwdOXweZCbfsn3g==@lists.linux.dev
X-Gm-Message-State: AFq9FYK0ujbxs73YV/P9+TBbW9CqvlZkNwSpcYBKw+RdNfjxqsUt74L0
	sa/UuNtEH1A6DNj2bBklA0e8dywpj4VbG890yPacVzIWU6lByCcafXovlKhfqGHflFofT8UACq7
	2+dfMV80j2Ny4530ezmUYwV1eC4oWo6Y=
X-Gm-Gg: AYBFou0sZANiaV20vSvTvYgKFFNZkv5RnFJYZU7TsqCfonUrFIJDpb151FN7yhLMMhv
	M5mkycUqr4iO1jX+xwO5/4fmtOQcNZ5PI+In7LUVAwiO+I/B95D2c9WBwK33AhdgI+Z8iF5wEXv
	ASZdlgxce85Pnp075d1aDSoIazBg5wLYZo5OPGea75ihwddKRb2Gsml1mITu+PgS/XuerIEfyoq
	gMu+gzea4ClrcNzHvXYG/7aI5HvJuOdIzTsvGu8FYeEWqvKZeaO91fTqQV+jP9vI4DAZdF+w1gr
	rbrNxmHLL9eKEX7lQ09/ADC/YzMuvbyvGrq40U9zE9T17kkMNUfXN16i+bwRvF57GaFSA9x3Tft
	e/5djrulFJCqvJZzgInvbzNPhjHg4bU2CKrE=
X-Received: by 2002:a05:651c:31c2:b0:3ab:1dcd:934c with SMTP id
 38308e7fff4ca-3ac6fde7f59mr807181fa.1.1792790017198; Fri, 23 Oct 2026
 14:13:37 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261020053435.1179054-4-oss.patchbox@gmail.com>
 <20261020053435.1179054-5-oss.patchbox@gmail.com> <20261023133546.GK3381610@ziepe.ca>
In-Reply-To: <20261023133546.GK3381610@ziepe.ca>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Fri, 23 Oct 2026 17:13:25 -0400
X-Gm-Features: AclHuK-BL1qI8bRaWELf_dQ7T0J3FzJ5N6gMRBUwAUZwcBedJJGHcJxZ4v19rv8
Message-ID: <CAGG=RgB9QziCsSXxqY0ZLYGyWhDhoqhOzxRx-W8Jomw=kCrb9Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iommu/riscv: Keep page table pages when IOTLB
 invalidation fails
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Fangyu Yu <fangyu.yu@linux.alibaba.com>, Zong Li <zong.li@sifive.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 at 09:35, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Invalidation is not allowed to fail. Drivers always have to free the
> pages.
>
> The system is irrecoverably broken if the iommu driver blows up so
> much it cannot invalidate.

Thank you for explaining this, Jason. I'll drop this series.

Thanks,
Yuho
