Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20417FF
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 03:43:42 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d7eccc1b8c6so3721895276.0
        for <iommu@lists.linux.dev>; Sun, 10 Sep 2023 20:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694403821; x=1695008621; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/A0+Q/JKZUt0hgBHJHGOo4adaIlNnlFRTqpKY4rTnI=;
        b=IS1pHbh0rcVuqya2cDoqI66khONoh76XMVftCMm7PEXhu7WTONRSUQ6Xqt0sZ46M3G
         0ltz8XR4D27c8jbsow1uFB2xj7KUgB9xDVbBOhf5jh5OXj7SFbMFtPbXP6pyWgymlWgH
         f9wns/zZRX4RuUJThoZeUWA//1aaPLcXdo6YENI/Ag5wn39JMWRlP1ABqZzGUbV1RcVW
         IUYDl9rW2wBZ6UoUtHcIYMDZeMfzTvayam3mh2a8Yd2twHNE9HzSvHvcnWfLpAPzNP/m
         /3HBsHdMMatWC+AzyYJ36CYdmG1dMA2rSusxX1LSsd+5RVW4HBjAo4BSEJOSsMFSWHvg
         w0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694403821; x=1695008621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/A0+Q/JKZUt0hgBHJHGOo4adaIlNnlFRTqpKY4rTnI=;
        b=bWVriPf/RfELwj/KHpDdOGgf2oiEqLHdlrZMz1oMhaT2zFFAEcCN4MXtOCHzy6oBvU
         ERWw/9nIVnAdZhxvvApjmNjJypO+i1zHK8weCjjSdCgxHD55vEtl+n3/HuvhI3qWxlGo
         Lucvsj/Gp1yN3h8TXRK7qZeuBza73S2phHCdlSpihTadpCxfZN5WRaqjPchc1/diV5TX
         d+G/upywJdSNUk3nuddAo0wl1PZuoJS3Y3nKjGK+nbKdp7lVmvhORW1Spio0w5kk2Yel
         8vjELXZpWOwr2TMB5d2BTLc68b8+n/ILZErqxMtrMY+HfCoqOLxzvmA0XqoFOp2TU9Hp
         wP2A==
X-Gm-Message-State: AOJu0Yydjmp2a3cX9QIKvu+Ndwjgs8uR1UhU+78n99HWFb0HpkNcW0B/
	TtIVrKjwZiHJtPz65YjeRcs+qqDgMp0lWvJIIRw=
X-Google-Smtp-Source: AGHT+IEn9RWnqeL5Hq8eEsJ3qj42E3U3Zw9Hx5jf9g/hYYKL/Sp3rNoe/D+yDp11vXGlXX/alCwCTiOtiZ1CI7NEqS4=
X-Received: by 2002:a25:680e:0:b0:d4d:b6de:69bd with SMTP id
 d14-20020a25680e000000b00d4db6de69bdmr7880693ybc.23.1694403821413; Sun, 10
 Sep 2023 20:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230726142823.6356-1-l3b2w1@gmail.com> <8c3fe8ce-4716-73f0-fb8a-ee982f212371@arm.com>
In-Reply-To: <8c3fe8ce-4716-73f0-fb8a-ee982f212371@arm.com>
From: binglei wang <l3b2w1@gmail.com>
Date: Mon, 11 Sep 2023 11:43:30 +0800
Message-ID: <CAJ3C4Kz+sRrBmz0ivEzrkR+g0toi+3ozheo+Xm9Zbo_6JuQieA@mail.gmail.com>
Subject: Re: [PATCH v3] cma: check for memory region overlapping
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Murphy:

Thanks for your reply.

This patch just want to print a warning message when detecting that
dts cma area overlaps with kernel code/data memory region.
If overlapping detected, it will fall back to default cma area
selected by kernel automatically.
The attachment is the full startup log.

for example cma setup in dts as follow:
        reserved-memory {
                #address-cells =3D <0x00000002>;
                #size-cells =3D <0x00000002>;
                ranges;
                phandle =3D <0x0000014e>;
                linux,cma {
                        compatible =3D "shared-dma-pool";
                        inactive;
                        reusable;
                        reg =3D <0x00000000 0x81000000 0x00000000
0x01000000>; // this area will be reserved successfully.
                        linux,cma-default;
                };
        };

when system boot, we get panic "Unable to handle kernel write to
read-only memory at virtual address ffff0000010c0000"

[    0.000000] Booting Linux on physical CPU 0x0000000201 [0x700f3034]
[    0.000000] Linux version 6.5.2 (linux@ubuntu)
(aarch64-linux-gnu-gcc (Linaro GCC 7.5-2019.12) 7.5.0, GNU ld
(Linaro_Binutils-2019.12) 2.28.2.20170706) #2 SMP PREEMPT Mon Sep 11
10:45:07 CST 2023
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: E2000Q DEMO DDR4
[    0.000000] earlycon: pl11 at MMIO 0x000000002800d000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created CMA memory pool at
0x0000000081000000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma,
compatible id shared-dma-pool
[    0.000000] OF: reserved mem:
0x0000000081000000..0x0000000081ffffff (16384 KiB) map reusable
linux,cma
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000080000000-0x00000000fbffffff]
[    0.000000] NUMA: NODE_DATA [mem 0xfbbfb9c0-0xfbbfdfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000fbffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000fbffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000fbfff=
fff]
[    0.000000] On node 0, zone DMA: 16384 pages in unavailable ranges
......
[    1.854067] Unable to handle kernel write to read-only memory at
virtual address ffff0000010c0000
[    1.862342] Initramfs unpacking failed: invalid magic at start of
compressed archive
[    1.862937] Mem abort info:
[    1.873450]   ESR =3D 0x000000009600004e
[    1.877191]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    1.882494]   SET =3D 0, FnV =3D 0
[    1.885539]   EA =3D 0, S1PTW =3D 0
[    1.888668]   FSC =3D 0x0e: level 2 permission fault
[    1.893450] Data abort info:
[    1.896319]   ISV =3D 0, ISS =3D 0x0000004e, ISS2 =3D 0x00000000
[    1.898409] Freeing initrd memory: 117760K
[    1.901794]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
[    1.901797]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[    1.901799] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000081b590=
00
[    1.901802] [ffff0000010c0000] pgd=3D18000000fbff7803,
p4d=3D18000000fbff7803, pud=3D18000000fbff6803, pmd=3D0060000081000f81
[    1.933524] Internal error: Oops: 000000009600004e [#1] PREEMPT SMP
[    1.939780] Modules linked in:
[    1.942825] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S
   6.5.2 #2
[    1.950124] Hardware name: E2000Q DEMO DDR4 (DT)
[    1.954730] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    1.961681] pc : __memset+0x16c/0x188
[    1.965339] lr : dma_direct_alloc+0xfc/0x344
[    1.969602] sp : ffff80008004b870
[    1.972905] x29: ffff80008004b870 x28: ffff0000038ba480 x27: ffff8000815=
20a90
[    1.980033] x26: ffff000002f19010 x25: ffff800080195d74 x24: fffffc00000=
43000
[    1.987160] x23: ffff000002f19010 x22: ffff0000010c0000 x21: 00000000000=
17000
[    1.994287] x20: ffff80008004b9e0 x19: ffff800081ad2000 x18: fffffc00000=
44008
[    2.001413] x17: 0000000000000040 x16: 0000000000000001 x15: fffffc00000=
00000
[    2.008540] x14: 00000000f0000080 x13: 00000000f0000000 x12: ffff800081a=
d3000
[    2.015667] x11: 0000000000000129 x10: 0000000000000008 x9 : 00000000000=
00000
[    2.022794] x8 : ffff0000010c0000 x7 : 0000000000000000 x6 : 00000000000=
0003f
[    2.029921] x5 : 0000000000000040 x4 : 0000000000000000 x3 : 00000000000=
00004
[    2.037047] x2 : 0000000000016fc0 x1 : 0000000000000000 x0 : ffff0000010=
c0000
[    2.044174] Call trace:
[    2.046610]  __memset+0x16c/0x188
[    2.049915]  dma_alloc_attrs+0x88/0x104
[    2.053741]  dmam_alloc_attrs+0x70/0xc8
[    2.057568]  ahci_port_start+0xa4/0x238
[    2.061396]  ata_host_start.part.36+0x100/0x21c
[    2.065918]  ata_host_activate+0x6c/0x148
[    2.069917]  ahci_host_activate+0x18c/0x1f0
[    2.074090]  ahci_platform_init_host+0x2b0/0x2f0
[    2.078697]  ahci_probe+0xb8/0xe0
[    2.082003]  platform_probe+0x68/0xd8
[    2.085656]  really_probe+0x150/0x2a4
[    2.089308]  __driver_probe_device+0x7c/0x130
[    2.093653]  driver_probe_device+0x38/0x114
[    2.097825]  __driver_attach+0xac/0x134
[    2.101649]  bus_for_each_dev+0x7c/0xdc
[    2.105477]  driver_attach+0x24/0x30
[    2.109042]  bus_add_driver+0xf0/0x20c
[    2.112782]  driver_register+0x60/0x128
[    2.116607]  __platform_driver_register+0x28/0x34
[    2.121301]  ahci_driver_init+0x1c/0x28
[    2.125128]  do_one_initcall+0x60/0x1d4
[    2.128955]  kernel_init_freeable+0x1d8/0x2a0
[    2.133304]  kernel_init+0x24/0x130
[    2.136783]  ret_from_fork+0x10/0x20
[    2.140350] Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428)
[    2.146433] ---[ end trace 0000000000000000 ]---
[    2.151061] Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x0000000b
[    2.158706] SMP: stopping secondary CPUs
[    2.162620] Kernel Offset: 0x80000 from 0xffff800080000000
[    2.168094] PHYS_OFFSET: 0x80000000
[    2.171570] CPU features: 0x00000000,80010000,0800421b
[    2.176697] Memory Limit: none
[    2.179741] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=3D0x0000000b ]---

Best wishes.
Binglei Wang.


Robin Murphy <robin.murphy@arm.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=887=E6=97=
=A5=E5=91=A8=E5=9B=9B 20:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On 26/07/2023 3:28 pm, Binglei Wang wrote:
> > From: Binglei Wang <l3b2w1@gmail.com>
> >
> > In the process of parsing the DTS, checks
> > whether the memory region specified by the DTS CMA node area
> > overlaps with the kernel text memory space reserved by memblock
> > before calling early_init_fdt_scan_reserved_mem.
>
> This description bears no relation to what the code actually does.
> rmem_cma_setup() happens well after parsing the DTS, as it is that
> initial parsing process in fdt_scan_reserved_mem() which *makes* the
> memblock reservations in the first place. Thus, as the revert patch
> demonstrates, by the time we get here to start *using* the reserved
> region via fdt_init_reserved_mem(), it is always guaranteed to overlap a
> reserved region because it trivially overlaps with itself.
>
> Furthermore, even if the bootloader does stupidly load a non-relocatable
> kernel into memory that it's described as reserved, the kernel text
> pages should not be available for CMA to allocate from - and if they
> were, that would be a far more fundamental bug elsewhere - so what is
> the exact problem you're trying to solve here?
>
> Thanks,
> Robin.
>
> > Maybe it's better to have some warning prompts printed.
> >
> > Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> > ---
> >
> > Notes:
> >      v3: fix compile error.
> >      v2: delete the logic code for handling return -EBUSY.
> >      v1: return -EBUSY when detect overlapping and handle the return ca=
se.
> >
> >   kernel/dma/contiguous.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 6ea80ae42..dc6d2af1e 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_m=
em *rmem)
> >               return -EBUSY;
> >       }
> >
> > +     if (memblock_is_region_reserved(rmem->base, rmem->size)) {
> > +             pr_info("Reserved memory: overlap with other memblock res=
erved region\n");
> > +             return -EBUSY;
> > +     }
> > +
> >       if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
> >           of_get_flat_dt_prop(node, "no-map", NULL))
> >               return -EINVAL;
