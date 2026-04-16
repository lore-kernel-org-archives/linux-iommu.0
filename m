Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28A18050
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338537; cv=none; b=vF42EXP1P5jcoO7M5N4ysRSXhTP6aOhn5lMN9i1qQGAN35u+hiyZdzsPGYhXS4B0tUh7yX5bGUz2TWO5dfibo7P63egM8MYG8U7elJNEXkCwDwE9V76AdtcPR79qQBrmXOwMU3CAXQym5HYaKHExsxUjUTRVbXrM2/AiuUkC0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338537; c=relaxed/simple;
	bh=FSgVIzpnraycKQsxAztrNgNSM9On/XU1ftEj+pCL/gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJP6RNzgWhnTUQfGwxUC0Eyo97XTt6Al9Nxyzb5B0R/onyjaNJG3rQsW+pxdcgXhsmkTZ8m9G5Qm5v4S3ixn3PRxYoPKEBppE4ZSihxEy9eoQvwQHLuUIPU0oMNQa2zNkvb0Ec8sQT0q0UWKTHroLm4xci9e6DJ1wCvNMr5RPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5637886c92aso3304256e0c.0
        for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 04:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338534; x=1776943334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AptjVPQ97g683jPGYCmYUacoTRTAG/3/TQY5t1TSdkk=;
        b=pFEeKMmni2GNpLm8eOh9IIdbDgB+SCTAKsPbimysYMIM9nGj5+tkTXOvatmiFrvTxv
         TZQUtt4Tuw30kcO96sQ3RthZTyXEpDqXb2DUb9ThjSyeOcL2ifM/FWdYfSNLUR485LSC
         kBVX3/5ZwGX2jqBOud2eJr4fhJNGTD4jp+y57zQDi+ZrdbDI1KhRvRtcpR5I7omNwebW
         GFDp6hures3V2QTfT7mY3l0K5F3+tlgvJFqeU0O3tbxzCtsX6aQnnite97KXitbNjjVV
         NAF+ubC2taD+iiFzoG9TJiQbdsh2yHCPEtZyhUSPbDRc/jpRrO4/jF4XA4pqgBNYJEar
         l/GQ==
X-Forwarded-Encrypted: i=1; AFNElJ8LQLUwQB81WSxx+dt4Lf8eFcdB1eumkZFjJ9ViU/NKW2A6uVway17LAQwxl26bZND5Sox1aA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb6oU27J33CswxWbcoMeeR1eXT4i7cH/AXdd627GXfJ8WaD2h2
	cukux4nLEjzOYr33g73D8+IdXafRXsS1argCBBkqj6BDGnof2EVvG6pOLKzWDhGd
X-Gm-Gg: AeBDieuxrADxotu6xPPyh6rSXWFzpXMI9aMUuh5vTzsaa3uGgqIeJN/KGyiMzaZ+m78
	/ARPrgbsOJ3xXGl2z8S+j3NBhdqpgdSAktGmuvKu67qiO/+hI4/V7L3byU2O3YWQrEvG2fLxvAY
	R3baTKlVOSAdAwCOjuPTZUpWv85qayxIXxAmz4fi5ibzcJ49UtwpRsR8imPvWcLbS8mWSQjUuNN
	ODCsMc/Z79hNHu7dIdpqNyxZLACDf0pmTjCkO/R4una0olLgxFdkSQjsVkRxyBhCO2ERY/43dRG
	7TGZLqm+xd5t+Eb7qN5cnFoRU8BxqSFjIDHnx2A54TBNrBIzdrwX6KZ15O34vYTtQ1xYRmaQK6O
	TLoGRME5tpQFmJtExb4JP8crQpWRtr6G9MmGru8YMWZNpngpo9Ur987YMfPQwi33tg0/hf/00Ma
	KtnBqyaQORVMCCaYAlRona1mkX83WPPHw8ZfCtE807t/mO63OPNQkzRLDTegAOVw90HuVnTEvLl
	/rfZ7DBlqAHMg==
X-Received: by 2002:a05:6122:21a7:b0:56d:b4d1:3c3a with SMTP id 71dfb90a1353d-56f3b986645mr602982e0c.0.1776338533707;
        Thu, 16 Apr 2026 04:22:13 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f89feb56esm2836915e0c.15.2026.04.16.04.22.13
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:22:13 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56d89f35940so2673671e0c.2
        for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 04:22:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9hgScRmYm8AmSbmN9PGsYnSVLGthfKVNoaE5GvGva3GABUij82XCoS6gMqwJhNxrNrnYE3Aw==@lists.linux.dev
X-Received: by 2002:a05:6122:788:b0:56f:1ed6:1d29 with SMTP id
 71dfb90a1353d-56f3bca6059mr11244615e0c.9.1776338533353; Thu, 16 Apr 2026
 04:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120317.910770161@kernel.org>
In-Reply-To: <20260410120317.910770161@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
X-Gm-Features: AQROBzBwwjc8yd10cT00Tu5Dl2qrCYQStWr3Lcobhh8coMrpPeCH9vhBSNokYJk
Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
Subject: Re: [patch 05/38] treewide: Remove CLOCK_TICK_RATE
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
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
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:18, Thomas Gleixner <tglx@kernel.org> wrote:
> This has been scheduled for removal more than a decade ago and the comments
> related to it have been dutifully ignored. The last dependencies are gone.
>
> Remove it along with various now empty asm/timex.h files.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h       |   15 ---------------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
