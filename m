Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613639D6FE
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338554; cv=none; b=VhYqGWC22gLlRkBK/BSLVI73/bfiUEKmlFAmyd8Drctw0BNfE24V0e4EHluibiO129xCKipn1ZgkxJVHJDWW0le9ZpuZL+hgiw6DZ0A4RzPhExP5+DXtkUnCLgwmn/knC8q21QR3vpjv0x+aHDV6EqsZuR9wBjms6JC4nf7YKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338554; c=relaxed/simple;
	bh=5RcGmn3E6IkK/4PLTUVN24XJ2jAiV11BodM4t9S5uGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/DeNVoZT2R4jeVUWwe6DBv3AKb7zaWUaNQK6TH52h4UqeYKdA4mHmNlzQZkzs9enwYqNHUi5YQradXDUM2HnsaYd09tR9ufdRlpQhFYLxAwHG44LSpG+Qj0rSGU29bbAhqJcBgQobum6QVdrreMiaMPu4N3Ex2NVlcZ/Nt4luA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso5891045e0c.3
        for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 04:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338547; x=1776943347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6jqlHRyBmHp78NPQbVn/INUSPCxYZ/sUXVIyq1nXfE=;
        b=JI8InOqGTHxyspWcMeVTFAugHLHFeslwjIFdm1breSdT8vTG10S0vfJZBf8FW2EbOA
         soMH/wku3FG5MI9jOMtjxkcPdqOVaxHffq0eX31lCR4AhJtKqJAqoLbCuOWJQ5Wu9JBl
         MDRa3KY6iybhMvU+xIk8zWpZb8MoQ9iErywog9BXzUShZwoxfiaUrCaNwihmTx/0j/MA
         5PhWY2m/LieysN3bbGnVyXT1MDhkXvG+P4+3sayvgOyoe6yOBwD8YXMKKCLqEDpHKLlv
         rkYasAwhgn4s39Qq40CKnzTE7ozRBlVXIV2LNv240JMJf5NdkzVOoU1hJHNsN6gIMjCr
         ZtZg==
X-Forwarded-Encrypted: i=1; AFNElJ8cFLYrhwM90DADq2GjnIwmgLdVIgHhpMIQ6R9xRGaUEl3Co1NJIhRrQAcklxj6V1seD58v5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRfsMOW44GtH2d7Jn023jQS3OkJFKHYZThos9RcXHEO+4nl/Nj
	qS0HWbbiLSInK1a96GGIcw0x2QlWncWe44tI0/Ini0XVoT2VDmIwS0HUdGaxwq78
X-Gm-Gg: AeBDiestccUdxfygeh5bs9XRLaz8vjztgUxDTQWhQDnOeuTpHC5t3tNr3jIuL5oFMpf
	DwtzWQIjVeniP/yQY3Hh1Ejq8CHmmEODUTivWzhKdJcp/LmKylshWOIEkybar2QBdtTXX9Xn1Yf
	ReVtEA/1kEc5tZKIpIRgT6qkrvnBvcFnk0sCHmNrbs+DbJzQfK0gu+uPrEE+vTjpWMVUk1vV1+m
	3on7vp2Y/xHOdNsgQJE/obysrucB2Oj1t1NMliHwOxrhMiIa/6vMMyyyzGQganKhMn8AW3MJyH1
	OUK8TuRmpT0QOv58KT58liQhBb7H1U6WyU4darCkC8X5mSpaz77/bTV9OSauS3GrA8d165mlCh/
	WuZNT9fJYy1VRRhFszYixHguarA1xUjQh7WLoiR+u2czhtac4Z+uA61PCNhPLW4VN4GlNNXp+UB
	uMYLt8YnQc84r/UaQ/lmBOibq25cY0v797MTtNrsqvZBj63p1G+rstfzZHEj9WVXLUB7lICfU=
X-Received: by 2002:a05:6122:65a1:b0:56d:b337:4709 with SMTP id 71dfb90a1353d-56f3bc536f7mr12697514e0c.6.1776338547652;
        Thu, 16 Apr 2026 04:22:27 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f8a007d0csm2864187e0c.16.2026.04.16.04.22.27
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:22:27 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-6137374b106so812556137.1
        for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 04:22:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8YJqyGeez8Um/BZAWDLYFt0k93bbLw1hiRqXTe2txOCBvbZxfg4uD66RuH4gnU8xapeElIdw==@lists.linux.dev
X-Received: by 2002:a05:6102:6044:b0:5ff:c64d:2283 with SMTP id
 ada2fe7eead31-60a0157295cmr11348128137.30.1776338547396; Thu, 16 Apr 2026
 04:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
X-Gm-Features: AQROBzCJ6rVnwwfhi99PI36wWXAFQ5DEgo1zw3RhVwYNSXoxkTYAcgIxt5Z0K1g
Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, 
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

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
