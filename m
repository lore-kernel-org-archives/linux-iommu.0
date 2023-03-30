Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B631C05
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 07:07:47 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5445009c26bso338072437b3.8
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 00:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680160066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx/OPeSP/6JGscUKbwjWV1A44GfF+C/voNDzk4y2Gmk=;
        b=b1HRbokrMFgBVPL5Xax6QBr+0ImJuzJLf54h30Ebhsb0dUWKmoCVfn4DjIsnCHSzoJ
         usHm9zPnDk5SuZ+XuF/AM/awfGhJTGpxo62pQ+ieydIe8gpoiShTAQNg7h/GbODTJSL4
         KJ3h50MVsPqzZp/7wg+gI4V3NTDY1vPtDQ5nei69C40iSXprApi1dELv9k68wZmwmF1i
         /8lDQRXtyMU4+Kge1kaIhNC4QKpApesRP0Zx7Z+xqbwQt+PW4XWDRxH98nLxTyqkRNim
         UR5iU1mj+0QUNDT9D+8dSO+R3Q2EkzOnTV8KmhxcMCYnhdji4yf7Eblp4iz1MLsDeiKi
         WpUg==
X-Gm-Message-State: AAQBX9f48qNQIAeJtjP5gkyhmffDUERttInhq7CzqRw8NOfgF8n3kjt+
	C5F7Vf8fIjf8OlWZZR+RAeEfFi3/EKjomg==
X-Google-Smtp-Source: AKy350Yag4rMiABMPGw8UNJPviSZlrQeUwAXzg319gu6HQ22Rq0Il2lFCAPGwiTmCnBdstsvj7Kj0Q==
X-Received: by 2002:a81:6746:0:b0:545:a7a4:c6a with SMTP id b67-20020a816746000000b00545a7a40c6amr20127246ywc.41.1680160065996;
        Thu, 30 Mar 2023 00:07:45 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id bq8-20020a05690c060800b005463239c01esm548624ywb.51.2023.03.30.00.07.45
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:07:45 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-545e907790fso222399717b3.3
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 00:07:45 -0700 (PDT)
X-Received: by 2002:a81:a7c4:0:b0:546:264:a375 with SMTP id
 e187-20020a81a7c4000000b005460264a375mr5797313ywh.4.1680160065429; Thu, 30
 Mar 2023 00:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230329071405.1568021-1-geert+renesas@glider.be> <ZCTOxOGDPoJoZDNW@infradead.org>
In-Reply-To: <ZCTOxOGDPoJoZDNW@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Mar 2023 09:07:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWV0GzA91MNuZVqs1B_8jry=fUGPgL4hSxtGLNF=Gj1Sw@mail.gmail.com>
Message-ID: <CAMuHMdWV0GzA91MNuZVqs1B_8jry=fUGPgL4hSxtGLNF=Gj1Sw@mail.gmail.com>
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
To: Christoph Hellwig <hch@infradead.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Desnes Nunes <desnesn@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, noreply@ellerman.id.au, Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Thu, Mar 30, 2023 at 1:50=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
> I've applied this as it is the first fix I got into my mailbox for it.

Thank you!

> Arnd sent one a little later, which uses %pap instead of %pa, which
> confused me a bit.  The documentation seems to allow both without
> any recommendation which one to use, which confuses me even further.

The "%pa" class supports two variants: "%pad" (for dma_addr_t) and
"%pap" (for phys_addr_t). "%pa" is a shortcut for the latter, cfr.
https://elixir.bootlin.com/linux/latest/source/lib/vsprintf.c#L1792

The default exists because "%pa" was fist, cfr. commit aaf07621b8bbfdc0
("vsprintf: add %pad extension for dma_addr_t use"), and I don't think
we can easily remove it. The default is shorter (saves one byte, even
compared to %llx"), so why not use it?

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
