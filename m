Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8BE2F30
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 15:34:37 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5445009c26bso299746527b3.8
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 08:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUMIPPhWmbOod7a8dH8XtYFyKZRtnp1P9P4vDBHhORY=;
        b=Ib9bytx46d92x2B6KkGtndhw0DGZeht6NgXZqT8LPer2rpRGAjsjEM7kfNWnW6V+li
         3RggfdsH2EOZGeqDlxJ7gRhFd8f/5Fg2V14Af2AcnthDSossdgkJyHzdE7d+mP6hV7h/
         kdS3Yz/ci5Kmf0Jk2nZB5EP+AqSoZh4+M4dXTC8DxY/PAl+/RqWdamNcuoFkcSu+y5am
         RKevAYfFCEGRYdbsQW+dR7bxZEYP4aQlwCRqQbRoRo96b0n4ctMBWOtAatZFabo1/TK1
         dIkgPvew1+LoSBRDvErKL/NDJ4kgQL7r29j624hh7fGKEnGWB6a38CVZ103IP0Zi/B4G
         s8ZQ==
X-Gm-Message-State: AAQBX9e7yG1RuDLqXvY90C6bSQSME8oJtJRjeo5u7uikigGWtlj1Rhpa
	j+6kpT6VoyYidD4jh4QFc768VBIFhMGhsw==
X-Google-Smtp-Source: AKy350bQZYyULN2OXivueeoFZ4Z7MzW/RVehRseHSfpcG36qheosGOcumQohUsbYR5BiSNndBmIV9A==
X-Received: by 2002:a81:834f:0:b0:544:943a:adda with SMTP id t76-20020a81834f000000b00544943aaddamr18342552ywf.48.1680104076613;
        Wed, 29 Mar 2023 08:34:36 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id e188-20020a81a7c5000000b005460412e2fcsm1136063ywh.70.2023.03.29.08.34.35
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:34:36 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-54184571389so299982167b3.4
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 08:34:35 -0700 (PDT)
X-Received: by 2002:a05:690c:b94:b0:541:698b:7bdb with SMTP id
 ck20-20020a05690c0b9400b00541698b7bdbmr1638553ywb.2.1680104074757; Wed, 29
 Mar 2023 08:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230329071405.1568021-1-geert+renesas@glider.be> <2w7rzdbzbii4ewliym6qw4svf2mzptsccz23yms5lsdioflcti@w63kwgzkra6r>
In-Reply-To: <2w7rzdbzbii4ewliym6qw4svf2mzptsccz23yms5lsdioflcti@w63kwgzkra6r>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Mar 2023 17:34:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVRqbe4Af72H0uqYrRJHJweiMYawUn4vK-9Xt7b7FLDfQ@mail.gmail.com>
Message-ID: <CAMuHMdVRqbe4Af72H0uqYrRJHJweiMYawUn4vK-9Xt7b7FLDfQ@mail.gmail.com>
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Desnes Nunes <desnesn@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, noreply@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerry,

On Wed, Mar 29, 2023 at 5:03=E2=80=AFPM Jerry Snitselaar <jsnitsel@redhat.c=
om> wrote:
> On Wed, Mar 29, 2023 at 09:14:05AM +0200, Geert Uytterhoeven wrote:
> > On 32-bit without LPAE:
> >
> >     kernel/dma/debug.c: In function =E2=80=98debug_dma_dump_mappings=E2=
=80=99:
> >     kernel/dma/debug.c:537:7: warning: format =E2=80=98%llx=E2=80=99 ex=
pects argument of type =E2=80=98long long unsigned int=E2=80=99, but argume=
nt 9 has type =E2=80=98phys_addr_t=E2=80=99 {aka =E2=80=98unsigned int=E2=
=80=99} [-Wformat=3D]
> >     kernel/dma/debug.c: In function =E2=80=98dump_show=E2=80=99:
> >     kernel/dma/debug.c:568:59: warning: format =E2=80=98%llx=E2=80=99 e=
xpects argument of type =E2=80=98long long unsigned int=E2=80=99, but argum=
ent 11 has type =E2=80=98phys_addr_t=E2=80=99 {aka =E2=80=98unsigned int=E2=
=80=99} [-Wformat=3D]
> >
> > Fixes: bd89d69a529fbef3 ("dma-debug: add cacheline to user/kernel space=
 dump messages")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/r/202303160548.ReyuTsGD-lkp@intel.com
> > Reported-by: noreply@ellerman.id.au
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
=3D
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -534,11 +534,11 @@ void debug_dma_dump_mappings(struct device *dev)
> >                       if (!dev || dev =3D=3D entry->dev) {
> >                               cln =3D to_cacheline_number(entry);
> >                               dev_info(entry->dev,
> > -                                      "%s idx %d P=3D%llx N=3D%lx D=3D=
%llx L=3D%llx cln=3D%llx %s %s\n",
> > +                                      "%s idx %d P=3D%llx N=3D%lx D=3D=
%llx L=3D%llx cln=3D%pa %s %s\n",
> >                                        type2name[entry->type], idx,
> >                                        phys_addr(entry), entry->pfn,
> >                                        entry->dev_addr, entry->size,
> > -                                      cln, dir2name[entry->direction],
> > +                                      &cln, dir2name[entry->direction]=
,
>
> Won't this just print out the address of cln declared at the beginning of=
 debug_dma_dump_mappings() each time, instead of the value
> returned from to_cacheline_entry() ?

The physical address is passed by reference, cfr.
https://elixir.bootlin.com/linux/latest/source/Documentation/core-api/print=
k-formats.rst#L231

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
