Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434450A62
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915987; cv=none; b=T7PdlAyAorWnF99wREGPEaU5hzyFY4Zgo8jetT1BeaZvGl1/pbI+/T30ZzELGeO+0+EEsAnSmx258R6ldyWaiZfkbJK3Qxay/OFI3tnKG/4zdRdvgqzCIir++DmDQvVTpjQNgrXuqa114KBEm+MILQmIf2esK6EiaCowMRMNgS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915987; c=relaxed/simple;
	bh=xe0CLiytQL+w07wMVqUc1rJS0v+e/Ti6ErqFWmVCp7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHEz5DQ/8oo1+OzyR3Kt/JD58Ke2b0XLAuQH8yKwnhj3d+V+4Pu4pZnYRVqmNJGsFEuhUZrecgXQIL0O3Zq3zrseowVhaQgSUPK6omG5aZFeO4JmIzQxoTHnGZT9MaTbA9gzqQ/lM9pGyfSHMWIusi8U4292Xm6abeb2f7wY+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=evWcu3lu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="evWcu3lu"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso190206166b.3
        for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 13:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718915984; x=1719520784; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w6VZWpwlG7GhpGptpxtkhZuBw3s+vrw3bJ0KsbwAf6c=;
        b=evWcu3lu8cWYe1RvM0XQSVkju1Aj/H8s4G2qxTdUYIJJWueC8PZRK3qE6zqCncWORX
         UY9vBrgOcsneWjVUabVlZyyUJC5tYxyyJ3d1FByX3tVV5+j1kMNpKKT3YTNp0zyWGOsQ
         IGYnwmeEyzKJpMmXY0nA7/ODQax4aKZPJinoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718915984; x=1719520784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6VZWpwlG7GhpGptpxtkhZuBw3s+vrw3bJ0KsbwAf6c=;
        b=D2TNHXVoSBFS3Zc0DDnzdTEqS4/OanNg39/5pR1ooz5bWwC7VvCDcBpMuNE4foUPl2
         L+cKP5mMk5KfztiIEuLcAixRlHtrYW5gE3NIwWciCWIP9pN8TyCFu2m9jH6bHnA5u9wl
         JzcLP3ApLqnmAzEPS4nbCNNr7rXpQahrG57fWReQK8bGb0DhmLDLx5Qe1m9X1qGrxzQK
         B9K3ujJm+Tc5T5vwSrm2QhzxqZesxgXh9dB+Vvn/vZdLiTHD/dSsO23zBIN+tJd3OZQN
         g1vKWWz8jP2GNuTka0tNOI5zIIJiFvOev9mM/M1m1IMuzFPkNEkpzZmMwyQJL2kasBz4
         ahaA==
X-Forwarded-Encrypted: i=1; AJvYcCXJoldifkt/OSxrRPK6zVcqdmelR4yvpCR9xtPkVsffr8MzOWxoffArVyBdaeT0q4vq8Jug82cl6GXhmEKI4vsYexN+oR4=
X-Gm-Message-State: AOJu0YwKOv4g6tAXN4M2IaNIknfM0mg9zx6abhvXeb6jDpG/XvUsSllK
	rqVKIjG2WRkH1VWvXS2SVGLymCCKMb6NJiyqgJTUQL7JTidc+kk3nMJXB8erlAhK8mxX70wlPnp
	SK+vR2CXM
X-Google-Smtp-Source: AGHT+IFamkewMuBz+bvctD4mct9iR4ZIzVplKgmaNUDNnXvC8fu5PQdzUMeb70gzkTWMoIWlIoZlbg==
X-Received: by 2002:a17:907:7a94:b0:a6f:b58f:ae3c with SMTP id a640c23a62f3a-a6fb58fba03mr284972366b.26.1718915984203;
        Thu, 20 Jun 2024 13:39:44 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf489e4asm8261266b.50.2024.06.20.13.39.43
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 13:39:43 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-424720e73e0so13324025e9.0
        for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 13:39:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVl9UxSztwNWhKkqpCDAP6Dr7cB6mXk4/yQo+SrcFMeMvVCnuQEz9cO8j4K9A5egKgeIyp+e0BcJ/fVhhqecNxR2WwHKDU=
X-Received: by 2002:a17:906:1348:b0:a6e:2a67:7899 with SMTP id
 a640c23a62f3a-a6fab63aaabmr312193466b.35.1718915542284; Thu, 20 Jun 2024
 13:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240620175703.605111-1-yury.norov@gmail.com> <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
 <ZnR1tQN01kN97G_F@yury-ThinkPad> <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
 <ZnSPBFW5wL0D0b86@yury-ThinkPad>
In-Reply-To: <ZnSPBFW5wL0D0b86@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 13:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2R7-jyoOw27Svf1PmfDFQgBWVAH3DP5CXO+JF-BeFZA@mail.gmail.com>
Message-ID: <CAHk-=wi2R7-jyoOw27Svf1PmfDFQgBWVAH3DP5CXO+JF-BeFZA@mail.gmail.com>
Subject: Re: [PATCH v4 00/40] lib/find: add atomic find_bit() primitives
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Borislav Petkov <bp@alien8.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Disseldorp <ddiss@suse.de>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregory Greenman <gregory.greenman@intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, 
	Jiri Pirko <jiri@resnulli.us>, Jiri Slaby <jirislaby@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, Karsten Keil <isdn@linux-pingi.de>, 
	Kees Cook <keescook@chromium.org>, Leon Romanovsky <leon@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Neukum <oneukum@suse.com>, Paolo Abeni <pabeni@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ping-Ke Shih <pkshih@realtek.com>, Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	GR-QLogic-Storage-Upstream@marvell.com, alsa-devel@alsa-project.org, 
	ath10k@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	mpi3mr-linuxdrv.pdl@broadcom.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 13:20, Yury Norov <yury.norov@gmail.com> wrote:
>
> FORCE_NR_CPUS helped to generate a better code for me back then. I'll
> check again against the current kernel.

Of _course_ it generates better code.

But when "better code" is a source of bugs, and isn't actually useful
in general, it's not better, is it.

> The 5d272dd1b343 is wrong. Limiting FORCE_NR_CPUS to UP case makes no
> sense because in UP case nr_cpu_ids is already a compile-time macro:

Yury, I'm very aware. That was obviously intentional. the whole point
of the commit is to just disable the the whole thing as useless and
problematic.

I could have just ripped it out entirely. I ended up doing a one-liner instead.

                Linus
