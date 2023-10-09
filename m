Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36B800
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59e77e4f707so51823437b3.0
        for <iommu@lists.linux.dev>; Mon, 09 Oct 2023 01:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696840770; x=1697445570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCa60SJYenNTin9ORA6mgu5HPNBKWXiBobv0OFeXlBg=;
        b=wJRjHl6jW3Xcb8Zt7O6l/2buKTf4ZMZwvdK3SLwEU2165a4kzgQ5rgott9aEoggH99
         aPR7L680gLc+KhPO9NgygtxIhb1952N8U0zVlap8Qux9eYxNMwqqr3QuHvcSdcXu5KY3
         75RpVqLw9Ej9k2N9P585yi5gerrLeDGkgY5Zgr7+zrLsYHuos1kJsjAXoVqjjMbnEGpx
         wO5OmeZ5vhbdWtH1IheYxfAj+mMe6ZB7T3QqK2yPdhzjHarMEXPJwZizYwyoi5zMyrP0
         /Ht2+LhO/v3/4eQ2UcXWJ+P+P3TmG81/GqzuTQ4aXQMFVFvhDbzjLqAh2w4qKyY2L1v5
         OwEA==
X-Gm-Message-State: AOJu0YwbX3y/N+eAXWN+wFeYfGlOn8XdYq4PuQro9ydR2uHMLwTSpbJ5
	ReC2FBQJQ8qD3Y5DrGAvlEyv/BoRnLzT8g==
X-Google-Smtp-Source: AGHT+IGQXZC49O3+ZiaW06/uCgZaKOOcPN+rPlv/Lw/NbWsX/zJ+/ciP1RxjVQGjY7EYZi2lDVQioA==
X-Received: by 2002:a0d:dec7:0:b0:59e:9a44:9db9 with SMTP id h190-20020a0ddec7000000b0059e9a449db9mr14266868ywe.26.1696840770358;
        Mon, 09 Oct 2023 01:39:30 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id i8-20020a819108000000b0059f802fad40sm3511800ywg.22.2023.10.09.01.39.29
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 01:39:30 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59f1dff5298so51596807b3.3
        for <iommu@lists.linux.dev>; Mon, 09 Oct 2023 01:39:29 -0700 (PDT)
X-Received: by 2002:a0d:d443:0:b0:5a2:3734:507 with SMTP id
 w64-20020a0dd443000000b005a237340507mr16135074ywd.21.1696840769802; Mon, 09
 Oct 2023 01:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231009074121.219686-1-hch@lst.de>
In-Reply-To: <20231009074121.219686-1-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Oct 2023 10:39:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU281a+=9SApaCRy5os3k73HGZhQ=Fsv58OD4C430iDDg@mail.gmail.com>
Message-ID: <CAMuHMdU281a+=9SApaCRy5os3k73HGZhQ=Fsv58OD4C430iDDg@mail.gmail.com>
Subject: Re: fix the non-coherent coldfire dma_alloc_coherent
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Greg

On Mon, Oct 9, 2023 at 9:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
> this is the next attempt to not return memory that is not DMA coherent
> on coldfire/m68knommu.  The last one needed more fixups in the fec
> driver, which this versions includes.  On top of that I've also added
> a few more cleanups to the core dma allocation code.
>
> Jim: any work to support the set_uncached and remap method for arm32
> should probably be based on this, and patch 3 should make that
> selection a little easier.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
