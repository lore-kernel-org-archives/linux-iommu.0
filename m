Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1B3A6EF6
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338545; cv=none; b=GALcXB8d6PRD/vzsZg+5FWJPMY4HY/yCoUYS9ftn1tGwFbPwUB7fEVWGF0KZeOAUZaMTVW+Aiacmn6ecKYuD+3CAip5VUnMO81ZGcvcYCElbvzJpSLbFHvmaFtOBtEyFwmI8WKaDv8qrz2eTkn/2+7cXn3MaSCIZ7d+/uXVo6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338545; c=relaxed/simple;
	bh=onL90hyVAUlPY0ASaWQwK2lX8QEYr5m106IAfPoIE0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvKvwSbzliqujrHNz1BOP+oKxaH1oG/NJvQiwbRGdt517DIGuc1VSk/awCeKJpk18gBbqEAdNA3m3jTO9kmeaLmlv66/z8djZl8SXLy4HmPKe1jqiOCUFsnF1GDk7EYAfTuzocM8Ottvg2N0AhSrnFkJvPrbToH1Ekm4Duv/irQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-61399bdd395so403419137.2
        for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 04:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338541; x=1776943341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N28AiHhMQm9a3ncbvMl4jwXcNZbOrN6OiiJm2DjJOE=;
        b=OskXENe1BrglV4kkMUSOCuHon6/Xk4n87RVaeaTnMi72tZth7xfnMOuuWxf3bQmLeu
         OK508f7ebROzZ7qGGe/Z0GHLyUbkRDEnjw5M+K550ydZWg4ik04jB14Govsy3PgqwnCf
         PRNVhveGmV1V0gBT8xxrnIFgzzwkah5tPUi42ZyCzXqWPldIl39lQGSZHECSsAKZhLKK
         uYaL1ioSdLuyXEKBPTGkkFuLx9kWzDZioryOqbq7cugFR6sHQK0BKM8mrY37sPQJhRih
         uagpMcU7w5kXdaYEwjQxzZZfmwietmPFWgTtLUcdgp0wcFG8JyaXJn5JFriKQ7n5dfFs
         em8A==
X-Forwarded-Encrypted: i=1; AFNElJ+WScGEHnVHFmpaN/q+JrX/ltt/pweU+4P+9OYdpAkfMbh8qjAMaBgDzi98cl+2K3+qQrFhyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjXJ7iQwtx+srg0RXkVkQ2zDZqDtl+bkLQhnQM6f3tt/h7oFiZ
	klsD3jrklIasU1/k9XuyPa57WeGS5xQhQootlEymtG2fQBE+VuurgJEstjW2Qrwe
X-Gm-Gg: AeBDiesEpkUMbv74xbT9q/y4lfBSz+kWybchccKJOx9B5Y2HpNan6mBAVTUj6eiYdKx
	ZdBHDG+HekMh8HquWCVJieW9JabsX3Hg6ndC4TYbS+g86wayj16Bjw8nS3Kxdc4Yd4F1849XHol
	Aw0PqSbOG0o+pMJkT8vJ0kwPrCXNI8R37Y0yCmuVeTKBP074jtJxKT/DXlaV8y/y3K5tDSB6Vki
	GkrKEHxuf/GNgCAdniZme/Ho3UvaecjhsrcuUchDdiQPYC500dDc2c0GBi7ST07HEco9XP/kiFn
	WMi5EAyRfYM/md3x0GfzVkOlH3eEPE5ulAbaOvuW0gbnB8j+ZXoVeS+jd1uKL9ULArJjr5wujJa
	R5tRWorLAQWZhTuk3+NLfMRXZhtz2jKZs1lx9yBopC4TV5qQBd4AQWPbO+ZO7lXZUKExAzwTq9h
	n8eOJzxY6znhHHYaLJjrmSbPnwTdfJUYkunp7hEC+5Cdq4GjJ3Ed1sZ8wAibXuosFATmVXYb4=
X-Received: by 2002:a05:6102:ccd:b0:612:529c:abae with SMTP id ada2fe7eead31-612529cca48mr3856042137.31.1776338541287;
        Thu, 16 Apr 2026 04:22:21 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-612ccb2498dsm2238762137.1.2026.04.16.04.22.21
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:22:21 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95673f7b5baso1463196241.1
        for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 04:22:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+KqIY5FOGW9GUvDn62f77DCs19wleGim/YAnoGeXAUFGMLMUk1ovLWnVY6f4AdJsZsF87HEA==@lists.linux.dev
X-Received: by 2002:a05:6102:3fa2:b0:608:1b6e:f4dc with SMTP id
 ada2fe7eead31-609ff0c50e9mr11028119137.11.1776338540828; Thu, 16 Apr 2026
 04:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.045532623@kernel.org>
In-Reply-To: <20260410120318.045532623@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
X-Gm-Features: AQROBzCyA8BqoTVnHFn7fWQMKVWyMF2wrQlYn44P8f0X0RsdCOwGnnxui8decDA
Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
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
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:19, Thomas Gleixner <tglx@kernel.org> wrote:
> Most architectures define cycles_t as unsigned long execpt:
>
>  - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
>
>  - parisc and mips define it as unsigned int
>
>    parisc has no real reason to do so as there are only a few usage sites
>    which either expand it to a 64-bit value or utilize only the lower
>    32bits.
>
>    mips has no real requirement either.
>
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h      |    2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
