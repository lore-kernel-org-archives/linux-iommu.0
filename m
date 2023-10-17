Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D808F38F91
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7af52ee31so68582137b3.2
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 06:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548356; x=1698153156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrjVOTU4vVWhg8rZEFBUd1El+uZlCjcijcwvkBEbBus=;
        b=QsS21aZ3n+jr8wjIojjTJBNlvE34krhtiR++Z4H8AP9cMV7L8Aa5H3jQnBkY9mGM+d
         /m0PwVm+MqRtivtTWDvnuLsP3FW+TLRARRczvUkBr9rZfP2FMu6PKqybOGeqv5Or5UYG
         krgu1GdzNKWiw2Pd3T+BpGtSN6/R9t0mANTExM8K+xoyFCccKK3zNHhcb4AVkcQYJnIt
         y6oPwq28cgXQx4WzdTnt+uM0L+EWhHhZnMitwzZ1b5Dei5GkEm6P2dhcYeKkUZuhQ5Xl
         2OCELJnTLsQojCpw22cjasrRliB1dQrbt7SK6zNqXRVp0eieTLMn6eZA7shi5eM8ik9W
         vpaQ==
X-Gm-Message-State: AOJu0YzrTOoA5j7HaZQQQ3lPxAgQq7vhXh1hn00nIbupx+m2wM+Plr/a
	FqJuJPV6UwJfUFsputrYkYpSBqylxpbiwQ==
X-Google-Smtp-Source: AGHT+IEv1eQAbZB7zwb4VxwvjQhq3lanymlHAWImjqeEExgf8R1wKMLrUplBF7mkcdw+EE5ckzxEIw==
X-Received: by 2002:a81:6cc5:0:b0:5a7:c973:c82 with SMTP id h188-20020a816cc5000000b005a7c9730c82mr2098211ywc.13.1697548355677;
        Tue, 17 Oct 2023 06:12:35 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id r1-20020a818101000000b0059b50f126fbsm592205ywf.114.2023.10.17.06.12.35
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 06:12:35 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7af52ee31so68581897b3.2
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 06:12:35 -0700 (PDT)
X-Received: by 2002:a0d:cb10:0:b0:5a7:afcc:80fe with SMTP id
 n16-20020a0dcb10000000b005a7afcc80femr2307771ywd.3.1697548354803; Tue, 17 Oct
 2023 06:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-5-hch@lst.de>
 <20231016-pantyhose-tall-7565b6b20fb9@wendy> <20231016131745.GB26484@lst.de>
 <CAMuHMdXVZz=YWMAgzUzme-U3qxYeLdi66xw2CGubpesGy+ZjRw@mail.gmail.com> <20231017124608.GA4386@lst.de>
In-Reply-To: <20231017124608.GA4386@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Oct 2023 15:12:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVavDc4g3ALqxFRn45ySCJ16F-Ay72=P3fxXipk0uXFiQ@mail.gmail.com>
Message-ID: <CAMuHMdVavDc4g3ALqxFRn45ySCJ16F-Ay72=P3fxXipk0uXFiQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] soc: renesas: select RISCV_DMA_NONCOHERENT from ARCH_R9A07G043
To: Christoph Hellwig <hch@lst.de>
Cc: Conor Dooley <conor.dooley@microchip.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>, arm-soc <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Tue, Oct 17, 2023 at 2:46=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> On Tue, Oct 17, 2023 at 12:44:41PM +0200, Geert Uytterhoeven wrote:
> > On Mon, Oct 16, 2023 at 3:17=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> > > On Mon, Oct 16, 2023 at 01:52:57PM +0100, Conor Dooley wrote:
> > > > > +   select RISCV_DMA_NONCOHERENT
> > > > >     select ERRATA_ANDES if RISCV_SBI
> > > > >     select ERRATA_ANDES_CMO if ERRATA_ANDES
> > > >
> > > > Since this Kconfig menu has changed a bit in linux-next, the select=
s
> > > > are unconditional here, and ERRATA_ANDES_CMO will in turn select
> > > > RISCV_DMA_NONCOHERENT.
> > >
> > > Oh, looks like another patch landed there in linux-next.  I had
> > > waited for the previous one go go upstream in -rc6.  Not sure
> > > how to best handle this conflict.
> >
> > I think the easiest is to ask soc to apply this series?
>
> I don't think pulling all the DMA bits into a random other tree
> would be a good idea.   I can hand off the first few bits, but I'd
> need a stable branch to pull in after that.  Which of the half a dozen
> soc trees we have in linux-next is this anyway?

The one and only https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.gi=
t/

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
