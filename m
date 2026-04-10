Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE43DA5D2
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835133; cv=pass; b=gapwQh5Hp+m4vRTjlhT7TB8PSBNnts9q2ewcfDIwehtsEqCy1va46FrxWP73c6VItye8gESrtkqowHjX8MT26DVuotAkTNvrwNs2t1VeFvj8HGo/JmoolgCFPH7+gOVqwNqKL3dPjwa948YOn99EWVw2v8V+dUDCNYaPJpUiSjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835133; c=relaxed/simple;
	bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQEcVluRzq/5194PqeO3Fq4KS1hdM8QQklAzH6EXvmELEJOkk/1IUrKU/qYvXcFoet0d7se4RccrkB3GE7w5l5NDLSDXahzDWE1z8wKbl6vuv4Rsp5wqhp1cDf/GG8hjmUgB7vhWZJOYcUSC97IsNhhQLdRZektrrlB+M938yqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=tVGKk/pS; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="tVGKk/pS"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271257ae53so9590772c88.1
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 08:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775835131; cv=none;
        d=google.com; s=arc-20240605;
        b=aIX4IURE5YSsuBxJrKGFYGPYz/6Lrn0YrQ4SDWp7rRWsYGx+hOUNleSDyYzBPxiCRx
         BKEGyak9jspNlcca27zIKswyd5XnXXu0rqg/xstX+Z/2CP+LgEcevA8ELRsBHh5srV8G
         bVn6hlTKw4enrCd20Abv9wJ3okUEGfTEUgM8vR9IlP5AMMJncyejV4sQW8//MGTbEIZ6
         6hEd8QSGUjURx9SS4JPBtNcsg6LiExV1INq8+Q1KkWceO877HGoXg5pAQE1HMwJd7Liy
         9mktiD/l9dG5hPqWKhHUplqSuMxw8yyxozlOtkFhGDYFAhx6pWrUuTWav4cds/L6Lvb1
         dD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        fh=KemwaQb3WAZVCGI0xbbWbFQs35g8FRZRLIyzO+VHd8Y=;
        b=YsJaTqS1ergcT0QgwWb2bC7MpSuHrHVyCBTFBq4ahrMtMLD6jCzwIkJjBCmPI9MsgX
         rTqRe5xr+Y0FyrzULIbOY2hsFdCybZsRRoqfZwjzfDgd2skjw9sVkbnKwWaQNDM0x21g
         fK6BjgZ6ZODzG6GmuQnOKgQcPNnWfkuMO1MIonxoe7+fQuD1o5es4ccaV2+xu8PFKwyc
         9fTp4zIlHqQz5KZdtP3Lb6PqTuRamy6utCl6fD9xY02HLfTSduDDQGL2As8jl6AyNk67
         BC32oY8CSxcz4WFhtoFBjxdu399lfNQjG0riq0hSXoI6y+Ma/oWBqXlMVU9d48ROz4e3
         7gOw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1775835131; x=1776439931; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=tVGKk/pShOrXGqzk6PJ3Nc3BFXNTo5KoR0jQxMAmm/EUhDukyaPPowEZeDsH2W0gmD
         fnGI2GPoM2GQEsHzTGX6m4nwYsDPY30G1fAqw3oi8wfdShSYky62zbwVmKYCa0lHo1W1
         Fl7q9CE3YI5VXO2I7qTtuYnHV/NCr+YWJwih8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835131; x=1776439931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=OS1j8Zmr1DG+uiclBpwheJDsQEoTcKcTSCPO2nyShOcbEiZAXerGV2iUGQi5qkLHEO
         6Yt8Gh4jjo9ttomlxZqeYbSfWve/3oJfFfrR2x7NGu2ABdlW+2Nc184Wfi4gt8Psrqmb
         5OBvD9JFlVLu0W3MaxaDiotKCpmFpAfVY/gGGmYcttF431pQUCL4qklRyQu2TqCu9GSw
         /A+/XQbSRelLzIAVxAPjPdCg0d841DezbI3V1i3MNjIBPfX6MuAbiiKqSIt8jnUZFbCJ
         cbzAwyoFNBMdgxN8FlW1BcoA+t9EbIVqeFUlfyowNeeqhiHdhLPDPM8KWG9TBrrEkvmy
         8TwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqTbAOQE2Yv6jky+l4dCg9iur4guS+PezeTYxPPUwNTwwjoq16iqokEWwLHGNrFW8BSYu+eA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkPQHkFLpo7kfCjHUbG/ZmGn9Uetj+fAktnjo8bKWKH+UgDacL
	SGTqewyboo7JiJ1BffEycNbzs3U+k4xGZgQJNifHdDojYT+9+KjN2Yhjr4vcVTUhCBhqFan3Lqr
	B2T4WjG6nWYM2moEjB4LhtXZURhVa9u+l3esGr6p7lQ==
X-Gm-Gg: AeBDiesurIWp3z+TzoXO02wexx4K+Lgu2Kr8S1z0j9Jbw7+3EJkOpngfGrsAqLYBMFD
	KSeo7JMnQ79zRiRqRbGfi23l8zPMkjfHOfbLKJ6JoXcq2jEL9jUbQsTaI+S71haBsqmJVFDdYPV
	S7RkESA1eyLcHyOAbGvrpKvb80F7cVuutQiAPybmCerx6MPEV2Zt4ud6M/ZRjtBboUYmD8QJb7r
	8hGzLyBCQUiBpABDZcQGzHRXj6xdQ5ApWYlqLsA2RD3ed8TUDHmmpeyVMC1U77nS5bOaBnxh3e8
	rcPK
X-Received: by 2002:a05:7022:6097:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-12c34f069f8mr2159203c88.34.1775835130696; Fri, 10 Apr 2026
 08:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 11 Apr 2026 00:31:59 +0900
X-Gm-Features: AQROBzAnX-XEClLFV-qWYFUzCuq4P43sNZviESiWFI1yCPXm2VtVZ2QkaUGJoPY
Message-ID: <CAFr9PXk7qK8-2JWrrfgXHoS9JWTRL+WobLjmAesyCE9VLL8ZyQ@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, 10 Apr 2026 at 21:39, Thomas Gleixner <tglx@kernel.org> wrote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.

I have built and booted this on my Amiga 4000 and it apparently still
works so FWIW:

Tested-by: Daniel Palmer <daniel@thingy.jp>
