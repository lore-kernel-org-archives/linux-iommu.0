Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4437C926
	for <iommu@lists.linux.dev>; Sun, 12 Apr 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776000188; cv=pass; b=NdddlL14tECoMYpKqXC/AOpq2JsysG9vhkD7ay9Lz9F6QCwBoAv7UHof5dEphYwDlKfw5NldiG+F4vkuD/iJNUVo2jXDa3+9ix6G27uDHkYiA1Px73MAYuGWJWT1gGQEQCQkeNBb6/No+raaQpVJZ4WDBlXq6mPkex06PUC50sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776000188; c=relaxed/simple;
	bh=1p6x7PvyQL+5PGqdAnx23TY8v0cVXdqCOnUZdmPD2Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3G1bkxJCBx6Jzb5/KUJVDWxGskEy49ReyW5OARjycUHa9TI+PRt+rVvwFGsDxrvbZgS59LspWYDk/aKxaBwsZqxUvCTT8TCDoY7Pq36P2OmcP+RrWmDqyDxYz72spiDMJYXbhu777txFnUsdbkqdDRC6QRHrJh1TvRqg1W35pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5/cDF1v; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5/cDF1v"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6717ead1d6aso229992a12.0
        for <iommu@lists.linux.dev>; Sun, 12 Apr 2026 06:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776000183; cv=none;
        d=google.com; s=arc-20240605;
        b=c5EiY7I/s1xklfYvltJLRwbK6p+DmV3yjNQolOeNAHz5sIHcTyzddNksnG7HQicG91
         f/mSIHh5dZE4+4urP2mVacVpvD8pDhQWZIdbeK489KICsaV8bADorucbL/Lml3EMkGf7
         6NJbRXYE6PZGUkJSHvXxy/czMn4K3SNfREnh6/+lKmdev/sfXPmJ59ZzU4xUQ3CcqyPy
         Foew4EfhKLRlALBdbaRzi1KfZO3Cu0XrdihQVms7s9fPMARi4cJlqTPxsyn/TUyZ137R
         Kva4wGPaMjwGPxhD2yGrF+1jjoT1J3E+fuJkUGj5Pz6o/Zus0nEACfcY6wb5y7kkxTTk
         R5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        fh=MP5rsbKmdky+gvQcqVGZ89p1YmUIZnttk6UcFjBIfNU=;
        b=JNzEUtgO65VOTl+nVeBfz91Tvp4ZDYOu3dnohzHe3zFPlottwLOzcqoJCDy+tDgQim
         rF6XXM2VHyti9jbkg+9DTVBTS686kTp8+Kp67G+aRa9xgEZKs4i2h7rUb/C8xV+ckCJo
         s2En5bgD5Nr7IFtYkEmw6Ojc9Vf4tdlor/71RDQ89FQ6OTn8gexcSyBgp2TL0jSza8iD
         QPm45odgGeuvF2yUiP6OYHVK2y9YLU+gcKUUwaz5BG1HQqJQnnBg/6LnR7a/C4kTFBFz
         3a+aBsUssy1FBYdbWBI9ULqBK0tT3oqtfA0FDhKYQ3m1sbQ0I+K0oElj7g7F6J21oE5N
         JL0w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776000183; x=1776604983; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=X5/cDF1vlPO3SRArCCvdx9L191BAbqdDJW/GnFDOwD8F6oyzeqRAZdo9dTWXlUlEHF
         +xNxJtujaNqf51jGhTv0i5MHpVMtm88KUy/HeKH6C2vRbMtkAhSAZPtQTDT6xNPTkROk
         MCO/GJU96foyd16u630qrjayud9Nw+OizbVW6f3v5wCnF43kQxqTjLtHiuxGsHSg88Zi
         UpFHMHn4AsbCPAiSCSkic8/ClkyvXOBfuO1oRE77K41NTlP8fQUApaoJjqnCQTWJj2nf
         BDyPwAWpsC2bWF41cmztu4V2Wc+TyI8gjb04/K8gZcUMBeyEjFEucd3ajlboWd2/Qxor
         HIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776000183; x=1776604983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=J4fAcDIn1FR4/BnrccAxRpfyEGtfAXYzlJk7n7fq59nH7J+27NBHxhwZPsjBzWj+VO
         hzqKeYskzGUAHX/TZ+29KxesscY4GuomQxNuL11XDr53jX7l9gfgbbtqaY3hm2jhHnCt
         1JaiEaMUkzApWAPFJvyyWbl8RwbH8TUo4ZQEmQvnpYX8j3uVqIMd8+lMv8yuflfZJF+X
         H6ULtKyMoO3pUcrHioX/xgCRwwBKxD6mBh5h0YdCs+KIei15VZWtGoCtxmbeZBaOP0zE
         jj8v6DuJNcxZFy6OuoZO7mdx3pqetgoaJf6hnug2EHJAOMTDQxpr3Qr04R38NzSlcVq1
         bIOA==
X-Forwarded-Encrypted: i=1; AJvYcCXNgS4OLW68u7+Lzug5XdWPWC6oqf0ehiFb4eYJwq+82AjDeeTlYX6BXoRwNVgyQrCCsJsGlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhwHlLC89Hl+xApA9DHHVns0P4eY+CU8Ese8PK7JQuixC08KBx
	xUdgeqRlApCPTVOvkdCOjSWuREcHmh0J95T+IGqHmN5WMBbJkQgDz2k3t3qzCgjRAj6hvh6xboM
	W07rEfTe5cfzUnA7ICdQ3NZRaHMjhL64=
X-Gm-Gg: AeBDies+wd05Ii+2gJHedCFHZnl2oDljMeSfu9jZls5JTd2aYtL5dZAT4dLE2k+LMB3
	utSZ5zqczKoJLwf4CmeQnxCOHR0EvaRDoNvtLtVeDSlAh0/hTHgonFsfci88NLcpQOegyVXB0Yc
	eSzaX8Lo9c2pfgGqpsB0anobXoOZoPcFHUTlhNAOwbdb/Y7nR7+fe1/Rhg4FU45Y/d0Be3YVcwq
	nszchBJ5ODTrVUL5kFSRyNPotqhPTf621Ldc2r5IxYQwLXtX9wozJ63Db0z9d7Ap+0IRDxBO194
	cm67SLUaCV5Z3jDlqpazQ1qxlo8ksB9ggwnaEGlD
X-Received: by 2002:a17:907:e113:b0:b9c:6ef1:ed18 with SMTP id
 a640c23a62f3a-b9d727aa4fdmr352963766b.25.1776000183133; Sun, 12 Apr 2026
 06:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.131582521@kernel.org>
In-Reply-To: <20260410120319.131582521@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 12 Apr 2026 15:22:51 +0200
X-Gm-Features: AQROBzAeMsaeSVePCJ__tEd4f2rWAY6MixXzp_fii2b8vyUpLt4xjSbtYzENFaw
Message-ID: <CA+=Fv5S68wZQapeaYTspOfsuGk=nBj60sx-ojHBSqrxV59Q+ZA@mail.gmail.com>
Subject: Re: [patch 23/38] alpha: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 2:36=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch alpha over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/Kconfig              |    1 +
>  arch/alpha/include/asm/random.h |   14 ++++++++++++++
>  arch/alpha/include/asm/timex.h  |   26 --------------------------
>  3 files changed, 15 insertions(+), 26 deletions(-)

Hi,

The Alpha side looks fine to me.

I've applied this patch on top of v7.0-rc7, built a kernel successfully,
boot-tested it on an Alpha UP2000+ (SMP) without issues.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
