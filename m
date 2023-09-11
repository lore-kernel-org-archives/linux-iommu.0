Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6317FF
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 03:38:09 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d7e387c33f3so3418508276.1
        for <iommu@lists.linux.dev>; Sun, 10 Sep 2023 20:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694403489; x=1695008289; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf5/72cEyXh/otCP5GEtNvT8Yo1Q6f6tgLH7UuB7aPo=;
        b=YYMJLFW7KbXFBNR4qsLFYygRSBCLTbYAvKuLlYDwBgykixsIIeejifXBXqWycNvH2/
         8GqZH5AqvjQQL5yobjYCVpxeYS/6+75Y2PAnTUXXoAskFCDC9IhxwvBAxFU/JbSKDVOV
         8W0OZu0dEDd8INGie+njo3aav64aivvpfrmRq5ThGbRzCZhFSA53Pdby6jqz9YErva8x
         K3ymWNblQ4kT5RukNdefW5riadHym5smrMvmT2Kmwtglc4Cij3+Q8RejTD/OHvh8x/zf
         S48JAux3QN+0TEW76xITN4AIsYl513x9xvI74wGFQcetL2k/cdBaifA5SnqBm9A8JLHl
         iBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694403489; x=1695008289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vf5/72cEyXh/otCP5GEtNvT8Yo1Q6f6tgLH7UuB7aPo=;
        b=XIREv/GrqS7T9pmdTGzYFta57x8fHTg2ZFOA9NtchZGhV+vNdbi3uuv5sWPL87uoLc
         qzZ5dFWebkLM2L4askpyzu4a0tmtJiQgrClRWsvaOXcCjzo5Q49tB/9cklF94/UWpb9m
         jWLaGfRrDQ1TV8LUtxtnKyeRet03j2niVwp9DxUaH7o22gPOB0qkdiXHwQMqI+/CeIF5
         y8K0jkj65AtSNkE441fGyCANulglNfmH9hJ36qJ/3iLMwVEUehow+qUEvKUGJUcFD7jA
         XCbuB0FHBfGNmLYrPw+xGVU5dLFGVB/VWoQttv8nCNzxyaaGPpic45pXIAoEuuOS1wDT
         Nv9w==
X-Gm-Message-State: AOJu0YyFz4fuUBcbTRfTQKMJwjZSj1Ux7HAnj2HKfckg0MNoHPmFB4zP
	D3y+Sc09z9MKPb2UXpHqmAGbjRFjwEbl0Tglzvg=
X-Google-Smtp-Source: AGHT+IHzd8IRDWnZfIvH7OvoFVXeXw3VRmLqT49x+NxkYLHJQSBg8EFPWgpR4s4mn+49GPRFICk6DWLdCRj9dqIocBA=
X-Received: by 2002:a25:ef4d:0:b0:d1c:5049:687b with SMTP id
 w13-20020a25ef4d000000b00d1c5049687bmr7449851ybm.16.1694403488756; Sun, 10
 Sep 2023 20:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230726142823.6356-1-l3b2w1@gmail.com> <8c3fe8ce-4716-73f0-fb8a-ee982f212371@arm.com>
In-Reply-To: <8c3fe8ce-4716-73f0-fb8a-ee982f212371@arm.com>
From: binglei wang <l3b2w1@gmail.com>
Date: Mon, 11 Sep 2023 11:37:57 +0800
Message-ID: <CAJ3C4Ky+sz0+gzJkmcGj6JOoA9iLnNoB5JEApxT467FU-2oXLQ@mail.gmail.com>
Subject: Re: [PATCH v3] cma: check for memory region overlapping
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000e0fdc06050d0edd"

--0000000000000e0fdc06050d0edd
Content-Type: multipart/alternative; boundary="0000000000000e0fda06050d0edb"

--0000000000000e0fda06050d0edb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Murphy:

Thanks for your reply.

This patch just want to print a warning message when detecting that dts cma
area overlaps with kernel code/data memory region.
If overlapping detected, it will fall back to default cma area selected by
kernel automatically.
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

when system boot, we get panic "Unable to handle kernel write to read-only
memory at virtual address ffff0000010c0000"

[    0.000000] Booting Linux on physical CPU 0x0000000201 [0x700f3034]
[    0.000000] Linux version 6.5.2 (linux@ubuntu) (aarch64-linux-gnu-gcc
(Linaro GCC 7.5-2019.12) 7.5.0, GNU ld (Linaro_Binutils-2019.12)
2.28.2.20170706) #2 SMP PREEMPT Mon Sep 11 10:45:07 CST 2023
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: E2000Q DEMO DDR4
[    0.000000] earlycon: pl11 at MMIO 0x000000002800d000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created CMA memory pool at
0x0000000081000000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id
shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000081000000..0x0000000081ffffff
(16384 KiB) map reusable linux,cma
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
[    0.000000] Initmem setup node 0 [mem
0x0000000080000000-0x00000000fbffffff]
[    0.000000] On node 0, zone DMA: 16384 pages in unavailable ranges
......
[    1.854067] Unable to handle kernel write to read-only memory at virtual
address ffff0000010c0000
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
[    1.954730] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS
BTYPE=3D--)
[    1.961681] pc : __memset+0x16c/0x188
[    1.965339] lr : dma_direct_alloc+0xfc/0x344
[    1.969602] sp : ffff80008004b870
[    1.972905] x29: ffff80008004b870 x28: ffff0000038ba480 x27:
ffff800081520a90
[    1.980033] x26: ffff000002f19010 x25: ffff800080195d74 x24:
fffffc0000043000
[    1.987160] x23: ffff000002f19010 x22: ffff0000010c0000 x21:
0000000000017000
[    1.994287] x20: ffff80008004b9e0 x19: ffff800081ad2000 x18:
fffffc0000044008
[    2.001413] x17: 0000000000000040 x16: 0000000000000001 x15:
fffffc0000000000
[    2.008540] x14: 00000000f0000080 x13: 00000000f0000000 x12:
ffff800081ad3000
[    2.015667] x11: 0000000000000129 x10: 0000000000000008 x9 :
0000000000000000
[    2.022794] x8 : ffff0000010c0000 x7 : 0000000000000000 x6 :
000000000000003f
[    2.029921] x5 : 0000000000000040 x4 : 0000000000000000 x3 :
0000000000000004
[    2.037047] x2 : 0000000000016fc0 x1 : 0000000000000000 x0 :
ffff0000010c0000
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
[    2.179741] ---[ end Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x0000000b ]---

Best wishes.
Binglei Wang.

Robin Murphy <robin.murphy@arm.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=887=E6=97=
=A5=E5=91=A8=E5=9B=9B 20:57=E5=86=99=E9=81=93=EF=BC=9A

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
> >      v1: return -EBUSY when detect overlapping and handle the return
> case.
> >
> >   kernel/dma/contiguous.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 6ea80ae42..dc6d2af1e 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct
> reserved_mem *rmem)
> >               return -EBUSY;
> >       }
> >
> > +     if (memblock_is_region_reserved(rmem->base, rmem->size)) {
> > +             pr_info("Reserved memory: overlap with other memblock
> reserved region\n");
> > +             return -EBUSY;
> > +     }
> > +
> >       if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
> >           of_get_flat_dt_prop(node, "no-map", NULL))
> >               return -EINVAL;
>

--0000000000000e0fda06050d0edb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Murphy:<div><br></div><div>Thanks for your reply.=C2=A0=
</div><div><br></div><div>This patch just want to print a warning message w=
hen detecting that dts cma area overlaps with kernel code/data memory regio=
n.</div><div>If overlapping detected, it will fall back to default cma area=
 selected by kernel automatically.</div><div>The attachment is the full sta=
rtup log.</div><div><br></div><div>for example cma setup in dts as follow:=
=C2=A0<br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 reserved-memory {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #address-cells =3D &lt=
;0x00000002&gt;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 #size-cells =3D &lt;0x00000002&gt;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ranges;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 phandle =3D &lt;0x0000014e&gt;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linux,cma {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;shared-dma-pool&quot;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inactive;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reusable;<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 reg =3D &lt;0x00000000 0x81000000 0x00000000 0x01000000&gt;; // =
this area will be reserved successfully.=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linux,cma-defau=
lt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 };<br></div><div><br></div><div>when system boot, we =
get panic &quot;Unable to handle kernel write to read-only memory at virtua=
l address ffff0000010c0000&quot;</div><div><br></div><div>[ =C2=A0 =C2=A00.=
000000] Booting Linux on physical CPU 0x0000000201 [0x700f3034]<br>[ =C2=A0=
 =C2=A00.000000] Linux version 6.5.2 (linux@ubuntu) (aarch64-linux-gnu-gcc =
(Linaro GCC 7.5-2019.12) 7.5.0, GNU ld (Linaro_Binutils-2019.12) 2.28.2.201=
70706) #2 SMP PREEMPT Mon Sep 11 10:45:07 CST 2023<br>[ =C2=A0 =C2=A00.0000=
00] KASLR disabled due to lack of seed<br>[ =C2=A0 =C2=A00.000000] Machine =
model: E2000Q DEMO DDR4<br>[ =C2=A0 =C2=A00.000000] earlycon: pl11 at MMIO =
0x000000002800d000 (options &#39;&#39;)<br>[ =C2=A0 =C2=A00.000000] printk:=
 bootconsole [pl11] enabled<br>[ =C2=A0 =C2=A00.000000] efi: UEFI not found=
.<br>[ =C2=A0 =C2=A00.000000] Reserved memory: created CMA memory pool at 0=
x0000000081000000, size 16 MiB=C2=A0<br>[ =C2=A0 =C2=A00.000000] OF: reserv=
ed mem: initialized node linux,cma, compatible id shared-dma-pool<br>[ =C2=
=A0 =C2=A00.000000] OF: reserved mem: 0x0000000081000000..0x0000000081fffff=
f (16384 KiB) map reusable linux,cma<br>[ =C2=A0 =C2=A00.000000] NUMA: No N=
UMA configuration found<br>[ =C2=A0 =C2=A00.000000] NUMA: Faking a node at =
[mem 0x0000000080000000-0x00000000fbffffff]<br>[ =C2=A0 =C2=A00.000000] NUM=
A: NODE_DATA [mem 0xfbbfb9c0-0xfbbfdfff]<br>[ =C2=A0 =C2=A00.000000] Zone r=
anges:<br>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA =C2=A0 =C2=A0 =C2=A0[mem 0x00=
00000080000000-0x00000000fbffffff]<br>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA32=
 =C2=A0 =C2=A0empty<br>[ =C2=A0 =C2=A00.000000] =C2=A0 Normal =C2=A0 empty<=
br>[ =C2=A0 =C2=A00.000000] Movable zone start for each node<br>[ =C2=A0 =
=C2=A00.000000] Early memory node ranges<br>[ =C2=A0 =C2=A00.000000] =C2=A0=
 node =C2=A0 0: [mem 0x0000000080000000-0x00000000fbffffff]<br>[ =C2=A0 =C2=
=A00.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000fbfffff=
f]<br>[ =C2=A0 =C2=A00.000000] On node 0, zone DMA: 16384 pages in unavaila=
ble ranges<br></div><div>......=C2=A0</div><div>[ =C2=A0 =C2=A01.854067] Un=
able to handle kernel write to read-only memory at virtual address ffff0000=
010c0000<br>[ =C2=A0 =C2=A01.862342] Initramfs unpacking failed: invalid ma=
gic at start of compressed archive<br>[ =C2=A0 =C2=A01.862937] Mem abort in=
fo:<br>[ =C2=A0 =C2=A01.873450] =C2=A0 ESR =3D 0x000000009600004e<br>[ =C2=
=A0 =C2=A01.877191] =C2=A0 EC =3D 0x25: DABT (current EL), IL =3D 32 bits<b=
r>[ =C2=A0 =C2=A01.882494] =C2=A0 SET =3D 0, FnV =3D 0<br>[ =C2=A0 =C2=A01.=
885539] =C2=A0 EA =3D 0, S1PTW =3D 0<br>[ =C2=A0 =C2=A01.888668] =C2=A0 FSC=
 =3D 0x0e: level 2 permission fault<br>[ =C2=A0 =C2=A01.893450] Data abort =
info:<br>[ =C2=A0 =C2=A01.896319] =C2=A0 ISV =3D 0, ISS =3D 0x0000004e, ISS=
2 =3D 0x00000000<br>[ =C2=A0 =C2=A01.898409] Freeing initrd memory: 117760K=
<br>[ =C2=A0 =C2=A01.901794] =C2=A0 CM =3D 0, WnR =3D 1, TnD =3D 0, TagAcce=
ss =3D 0<br>[ =C2=A0 =C2=A01.901797] =C2=A0 GCS =3D 0, Overlay =3D 0, Dirty=
Bit =3D 0, Xs =3D 0<br>[ =C2=A0 =C2=A01.901799] swapper pgtable: 4k pages, =
48-bit VAs, pgdp=3D0000000081b59000<br>[ =C2=A0 =C2=A01.901802] [ffff000001=
0c0000] pgd=3D18000000fbff7803, p4d=3D18000000fbff7803, pud=3D18000000fbff6=
803, pmd=3D0060000081000f81<br>[ =C2=A0 =C2=A01.933524] Internal error: Oop=
s: 000000009600004e [#1] PREEMPT SMP<br>[ =C2=A0 =C2=A01.939780] Modules li=
nked in:<br>[ =C2=A0 =C2=A01.942825] CPU: 2 PID: 1 Comm: swapper/0 Tainted:=
 G S =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.5.2 #2<br>[ =
=C2=A0 =C2=A01.950124] Hardware name: E2000Q DEMO DDR4 (DT)<br>[ =C2=A0 =C2=
=A01.954730] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D=
--)<br>[ =C2=A0 =C2=A01.961681] pc : __memset+0x16c/0x188<br>[ =C2=A0 =C2=
=A01.965339] lr : dma_direct_alloc+0xfc/0x344<br>[ =C2=A0 =C2=A01.969602] s=
p : ffff80008004b870<br>[ =C2=A0 =C2=A01.972905] x29: ffff80008004b870 x28:=
 ffff0000038ba480 x27: ffff800081520a90<br>[ =C2=A0 =C2=A01.980033] x26: ff=
ff000002f19010 x25: ffff800080195d74 x24: fffffc0000043000<br>[ =C2=A0 =C2=
=A01.987160] x23: ffff000002f19010 x22: ffff0000010c0000 x21: 0000000000017=
000<br>[ =C2=A0 =C2=A01.994287] x20: ffff80008004b9e0 x19: ffff800081ad2000=
 x18: fffffc0000044008<br>[ =C2=A0 =C2=A02.001413] x17: 0000000000000040 x1=
6: 0000000000000001 x15: fffffc0000000000<br>[ =C2=A0 =C2=A02.008540] x14: =
00000000f0000080 x13: 00000000f0000000 x12: ffff800081ad3000<br>[ =C2=A0 =
=C2=A02.015667] x11: 0000000000000129 x10: 0000000000000008 x9 : 0000000000=
000000<br>[ =C2=A0 =C2=A02.022794] x8 : ffff0000010c0000 x7 : 0000000000000=
000 x6 : 000000000000003f<br>[ =C2=A0 =C2=A02.029921] x5 : 0000000000000040=
 x4 : 0000000000000000 x3 : 0000000000000004<br>[ =C2=A0 =C2=A02.037047] x2=
 : 0000000000016fc0 x1 : 0000000000000000 x0 : ffff0000010c0000<br>[ =C2=A0=
 =C2=A02.044174] Call trace:<br>[ =C2=A0 =C2=A02.046610] =C2=A0__memset+0x1=
6c/0x188<br>[ =C2=A0 =C2=A02.049915] =C2=A0dma_alloc_attrs+0x88/0x104<br>[ =
=C2=A0 =C2=A02.053741] =C2=A0dmam_alloc_attrs+0x70/0xc8<br>[ =C2=A0 =C2=A02=
.057568] =C2=A0ahci_port_start+0xa4/0x238<br>[ =C2=A0 =C2=A02.061396] =C2=
=A0ata_host_start.part.36+0x100/0x21c<br>[ =C2=A0 =C2=A02.065918] =C2=A0ata=
_host_activate+0x6c/0x148<br>[ =C2=A0 =C2=A02.069917] =C2=A0ahci_host_activ=
ate+0x18c/0x1f0<br>[ =C2=A0 =C2=A02.074090] =C2=A0ahci_platform_init_host+0=
x2b0/0x2f0<br>[ =C2=A0 =C2=A02.078697] =C2=A0ahci_probe+0xb8/0xe0<br>[ =C2=
=A0 =C2=A02.082003] =C2=A0platform_probe+0x68/0xd8<br>[ =C2=A0 =C2=A02.0856=
56] =C2=A0really_probe+0x150/0x2a4<br>[ =C2=A0 =C2=A02.089308] =C2=A0__driv=
er_probe_device+0x7c/0x130<br>[ =C2=A0 =C2=A02.093653] =C2=A0driver_probe_d=
evice+0x38/0x114<br>[ =C2=A0 =C2=A02.097825] =C2=A0__driver_attach+0xac/0x1=
34<br>[ =C2=A0 =C2=A02.101649] =C2=A0bus_for_each_dev+0x7c/0xdc<br>[ =C2=A0=
 =C2=A02.105477] =C2=A0driver_attach+0x24/0x30<br>[ =C2=A0 =C2=A02.109042] =
=C2=A0bus_add_driver+0xf0/0x20c<br>[ =C2=A0 =C2=A02.112782] =C2=A0driver_re=
gister+0x60/0x128<br>[ =C2=A0 =C2=A02.116607] =C2=A0__platform_driver_regis=
ter+0x28/0x34<br>[ =C2=A0 =C2=A02.121301] =C2=A0ahci_driver_init+0x1c/0x28<=
br>[ =C2=A0 =C2=A02.125128] =C2=A0do_one_initcall+0x60/0x1d4<br>[ =C2=A0 =
=C2=A02.128955] =C2=A0kernel_init_freeable+0x1d8/0x2a0<br>[ =C2=A0 =C2=A02.=
133304] =C2=A0kernel_init+0x24/0x130<br>[ =C2=A0 =C2=A02.136783] =C2=A0ret_=
from_fork+0x10/0x20<br>[ =C2=A0 =C2=A02.140350] Code: 91010108 54ffff4a 8b0=
40108 cb050042 (d50b7428)<br>[ =C2=A0 =C2=A02.146433] ---[ end trace 000000=
0000000000 ]---<br>[ =C2=A0 =C2=A02.151061] Kernel panic - not syncing: Att=
empted to kill init! exitcode=3D0x0000000b<br>[ =C2=A0 =C2=A02.158706] SMP:=
 stopping secondary CPUs<br>[ =C2=A0 =C2=A02.162620] Kernel Offset: 0x80000=
 from 0xffff800080000000<br>[ =C2=A0 =C2=A02.168094] PHYS_OFFSET: 0x8000000=
0<br>[ =C2=A0 =C2=A02.171570] CPU features: 0x00000000,80010000,0800421b<br=
>[ =C2=A0 =C2=A02.176697] Memory Limit: none<br>[ =C2=A0 =C2=A02.179741] --=
-[ end Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x000=
0000b ]---<br></div><div><br></div><div>Best wishes.</div><div>Binglei Wang=
.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">Robin Murphy &lt;<a href=3D"mailto:robin.murphy@arm.com">robin.murph=
y@arm.com</a>&gt; =E4=BA=8E2023=E5=B9=B49=E6=9C=887=E6=97=A5=E5=91=A8=E5=9B=
=9B 20:57=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On 26/07/2023 3:28 pm, Binglei Wang wrote:<br>
&gt; From: Binglei Wang &lt;<a href=3D"mailto:l3b2w1@gmail.com" target=3D"_=
blank">l3b2w1@gmail.com</a>&gt;<br>
&gt; <br>
&gt; In the process of parsing the DTS, checks<br>
&gt; whether the memory region specified by the DTS CMA node area<br>
&gt; overlaps with the kernel text memory space reserved by memblock<br>
&gt; before calling early_init_fdt_scan_reserved_mem.<br>
<br>
This description bears no relation to what the code actually does. <br>
rmem_cma_setup() happens well after parsing the DTS, as it is that <br>
initial parsing process in fdt_scan_reserved_mem() which *makes* the <br>
memblock reservations in the first place. Thus, as the revert patch <br>
demonstrates, by the time we get here to start *using* the reserved <br>
region via fdt_init_reserved_mem(), it is always guaranteed to overlap a <b=
r>
reserved region because it trivially overlaps with itself.<br>
<br>
Furthermore, even if the bootloader does stupidly load a non-relocatable <b=
r>
kernel into memory that it&#39;s described as reserved, the kernel text <br=
>
pages should not be available for CMA to allocate from - and if they <br>
were, that would be a far more fundamental bug elsewhere - so what is <br>
the exact problem you&#39;re trying to solve here?<br>
<br>
Thanks,<br>
Robin.<br>
<br>
&gt; Maybe it&#39;s better to have some warning prompts printed.<br>
&gt; <br>
&gt; Signed-off-by: Binglei Wang &lt;<a href=3D"mailto:l3b2w1@gmail.com" ta=
rget=3D"_blank">l3b2w1@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Notes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 v3: fix compile error.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 v2: delete the logic code for handling return -EBU=
SY.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 v1: return -EBUSY when detect overlapping and hand=
le the return case.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0kernel/dma/contiguous.c | 5 +++++<br>
&gt;=C2=A0 =C2=A01 file changed, 5 insertions(+)<br>
&gt; <br>
&gt; diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c<br>
&gt; index 6ea80ae42..dc6d2af1e 100644<br>
&gt; --- a/kernel/dma/contiguous.c<br>
&gt; +++ b/kernel/dma/contiguous.c<br>
&gt; @@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_=
mem *rmem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (memblock_is_region_reserved(rmem-&gt;base, rm=
em-&gt;size)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_info(&quot;Reserve=
d memory: overlap with other memblock reserved region\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!of_get_flat_dt_prop(node, &quot;reusabl=
e&quot;, NULL) ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of_get_flat_dt_prop(node, &quo=
t;no-map&quot;, NULL))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
</blockquote></div>

--0000000000000e0fda06050d0edb--
--0000000000000e0fdc06050d0edd
Content-Type: application/octet-stream; name="cma.log"
Content-Disposition: attachment; filename="cma.log"
Content-Transfer-Encoding: base64
Content-ID: <f_lmebx06b0>
X-Attachment-Id: f_lmebx06b0

WyAgICAwLjAwMDAwMF0gQm9vdGluZyBMaW51eCBvbiBwaHlzaWNhbCBDUFUgMHgwMDAwMDAwMjAx
IFsweDcwMGYzMDM0XQ0KWyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA2LjUuMiAobGludXhA
dWJ1bnR1KSAoYWFyY2g2NC1saW51eC1nbnUtZ2NjIChMaW5hcm8gR0NDIDcuNS0yMDE5LjEyKSA3
LjUuMCwgR05VIGxkIChMaW5hcm9fQmludXRpbHMtMjAxOS4xMikgMi4yOC4yLjIwMTcwNzA2KSAj
MiBTTVAgUFJFRU1QVCBNb24gU2VwIDExIDEwOjQ1OjA3IENTVCAyMDIzDQpbICAgIDAuMDAwMDAw
XSBLQVNMUiBkaXNhYmxlZCBkdWUgdG8gbGFjayBvZiBzZWVkDQpbICAgIDAuMDAwMDAwXSBNYWNo
aW5lIG1vZGVsOiBFMjAwMFEgREVNTyBERFI0DQpbICAgIDAuMDAwMDAwXSBlYXJseWNvbjogcGwx
MSBhdCBNTUlPIDB4MDAwMDAwMDAyODAwZDAwMCAob3B0aW9ucyAnJykNClsgICAgMC4wMDAwMDBd
IHByaW50azogYm9vdGNvbnNvbGUgW3BsMTFdIGVuYWJsZWQNClsgICAgMC4wMDAwMDBdIGVmaTog
VUVGSSBub3QgZm91bmQuDQpbICAgIDAuMDAwMDAwXSBSZXNlcnZlZCBtZW1vcnk6IGNyZWF0ZWQg
Q01BIG1lbW9yeSBwb29sIGF0IDB4MDAwMDAwMDA4MTAwMDAwMCwgc2l6ZSAxNiBNaUINClsgICAg
MC4wMDAwMDBdIE9GOiByZXNlcnZlZCBtZW06IGluaXRpYWxpemVkIG5vZGUgbGludXgsY21hLCBj
b21wYXRpYmxlIGlkIHNoYXJlZC1kbWEtcG9vbA0KWyAgICAwLjAwMDAwMF0gT0Y6IHJlc2VydmVk
IG1lbTogMHgwMDAwMDAwMDgxMDAwMDAwLi4weDAwMDAwMDAwODFmZmZmZmYgKDE2Mzg0IEtpQikg
bWFwIHJldXNhYmxlIGxpbnV4LGNtYQ0KWyAgICAwLjAwMDAwMF0gTlVNQTogTm8gTlVNQSBjb25m
aWd1cmF0aW9uIGZvdW5kDQpbICAgIDAuMDAwMDAwXSBOVU1BOiBGYWtpbmcgYSBub2RlIGF0IFtt
ZW0gMHgwMDAwMDAwMDgwMDAwMDAwLTB4MDAwMDAwMDBmYmZmZmZmZl0NClsgICAgMC4wMDAwMDBd
IE5VTUE6IE5PREVfREFUQSBbbWVtIDB4ZmJiZmI5YzAtMHhmYmJmZGZmZl0NClsgICAgMC4wMDAw
MDBdIFpvbmUgcmFuZ2VzOg0KWyAgICAwLjAwMDAwMF0gICBETUEgICAgICBbbWVtIDB4MDAwMDAw
MDA4MDAwMDAwMC0weDAwMDAwMDAwZmJmZmZmZmZdDQpbICAgIDAuMDAwMDAwXSAgIERNQTMyICAg
IGVtcHR5DQpbICAgIDAuMDAwMDAwXSAgIE5vcm1hbCAgIGVtcHR5DQpbICAgIDAuMDAwMDAwXSBN
b3ZhYmxlIHpvbmUgc3RhcnQgZm9yIGVhY2ggbm9kZQ0KWyAgICAwLjAwMDAwMF0gRWFybHkgbWVt
b3J5IG5vZGUgcmFuZ2VzDQpbICAgIDAuMDAwMDAwXSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAw
MDA4MDAwMDAwMC0weDAwMDAwMDAwZmJmZmZmZmZdDQpbICAgIDAuMDAwMDAwXSBJbml0bWVtIHNl
dHVwIG5vZGUgMCBbbWVtIDB4MDAwMDAwMDA4MDAwMDAwMC0weDAwMDAwMDAwZmJmZmZmZmZdDQpb
ICAgIDAuMDAwMDAwXSBPbiBub2RlIDAsIHpvbmUgRE1BOiAxNjM4NCBwYWdlcyBpbiB1bmF2YWls
YWJsZSByYW5nZXMNClsgICAgMC4wMDAwMDBdIHBzY2k6IHByb2JpbmcgZm9yIGNvbmR1aXQgbWV0
aG9kIGZyb20gRFQuDQpbICAgIDAuMDAwMDAwXSBwc2NpOiBQU0NJdjEuMSBkZXRlY3RlZCBpbiBm
aXJtd2FyZS4NClsgICAgMC4wMDAwMDBdIHBzY2k6IFVzaW5nIHN0YW5kYXJkIFBTQ0kgdjAuMiBm
dW5jdGlvbiBJRHMNClsgICAgMC4wMDAwMDBdIHBzY2k6IE1JR1JBVEVfSU5GT19UWVBFIG5vdCBz
dXBwb3J0ZWQuDQpbICAgIDAuMDAwMDAwXSBwc2NpOiBTTUMgQ2FsbGluZyBDb252ZW50aW9uIHYx
LjINClsgICAgMC4wMDAwMDBdIHBlcmNwdTogRW1iZWRkZWQgMjIgcGFnZXMvY3B1IHM1MDQwOCBy
ODE5MiBkMzE1MTIgdTkwMTEyDQpbICAgIDAuMDAwMDAwXSBwY3B1LWFsbG9jOiBzNTA0MDggcjgx
OTIgZDMxNTEyIHU5MDExMiBhbGxvYz0yMio0MDk2DQpbICAgIDAuMDAwMDAwXSBwY3B1LWFsbG9j
OiBbMF0gMCBbMF0gMSBbMF0gMiBbMF0gMw0KWyAgICAwLjAwMDAwMF0gRGV0ZWN0ZWQgVklQVCBJ
LWNhY2hlIG9uIENQVTANClsgICAgMC4wMDAwMDBdIENQVSBmZWF0dXJlczogZGV0ZWN0ZWQ6IEdJ
QyBzeXN0ZW0gcmVnaXN0ZXIgQ1BVIGludGVyZmFjZQ0KWyAgICAwLjAwMDAwMF0gQ1BVIGZlYXR1
cmVzOiBkZXRlY3RlZDogS2VybmVsIHBhZ2UgdGFibGUgaXNvbGF0aW9uIChLUFRJKQ0KWyAgICAw
LjAwMDAwMF0gYWx0ZXJuYXRpdmVzOiBhcHBseWluZyBib290IGFsdGVybmF0aXZlcw0KWyAgICAw
LjAwMDAwMF0gS2VybmVsIGNvbW1hbmQgbGluZTogcmRpbml0PS9saW51eHJjIGxvZ2xldmVsPTEw
IGVhcmx5Y29uPXBsMDExLDB4MjgwMGQwMDAgZGVidWcgcm9vdGZzdHlwZT10bXBmcyBkeW5kYmc9
ImZpbGUgKiArcCIgY29uc29sZT10dHlBTUExLDExNTIwMCBhDQpbICAgIDAuMDAwMDAwXSBVbmtu
b3duIGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1ldGVycyAiYSBkeW5kYmc9ZmlsZSAqICtwIiwg
d2lsbCBiZSBwYXNzZWQgdG8gdXNlciBzcGFjZS4NClsgICAgMC4wMDAwMDBdIERlbnRyeSBjYWNo
ZSBoYXNoIHRhYmxlIGVudHJpZXM6IDI2MjE0NCAob3JkZXI6IDksIDIwOTcxNTIgYnl0ZXMsIGxp
bmVhcikNClsgICAgMC4wMDAwMDBdIElub2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTMx
MDcyIChvcmRlcjogOCwgMTA0ODU3NiBieXRlcywgbGluZWFyKQ0KWyAgICAwLjAwMDAwMF0gRmFs
bGJhY2sgb3JkZXIgZm9yIE5vZGUgMDogMA0KWyAgICAwLjAwMDAwMF0gQnVpbHQgMSB6b25lbGlz
dHMsIG1vYmlsaXR5IGdyb3VwaW5nIG9uLiAgVG90YWwgcGFnZXM6IDQ5OTk2OA0KWyAgICAwLjAw
MDAwMF0gUG9saWN5IHpvbmU6IERNQQ0KWyAgICAwLjAwMDAwMF0gbWVtIGF1dG8taW5pdDogc3Rh
Y2s6b2ZmLCBoZWFwIGFsbG9jOm9mZiwgaGVhcCBmcmVlOm9mZg0KWyAgICAwLjAwMDAwMF0gc29m
dHdhcmUgSU8gVExCOiBhcmVhIG51bSA0Lg0KWyAgICAwLjAwMDAwMF0gc29mdHdhcmUgSU8gVExC
OiBtYXBwZWQgW21lbSAweDAwMDAwMDAwZjU4MDAwMDAtMHgwMDAwMDAwMGY5ODAwMDAwXSAoNjRN
QikNClsgICAgMC4wMDAwMDBdIE1lbW9yeTogMTc2NTgxNksvMjAzMTYxNksgYXZhaWxhYmxlICgx
Njg5Nksga2VybmVsIGNvZGUsIDQxNjJLIHJ3ZGF0YSwgMTA0NzZLIHJvZGF0YSwgODk2MEsgaW5p
dCwgNjIySyBic3MsIDI0OTQxNksgcmVzZXJ2ZWQsIDE2Mzg0SyBjbWEtcmVzZXJ2ZWQpDQpbICAg
IDAuMDAwMDAwXSBTTFVCOiBIV2FsaWduPTY0LCBPcmRlcj0wLTMsIE1pbk9iamVjdHM9MCwgQ1BV
cz00LCBOb2Rlcz0xDQpbICAgIDAuMDAwMDAwXSByY3U6IFByZWVtcHRpYmxlIGhpZXJhcmNoaWNh
bCBSQ1UgaW1wbGVtZW50YXRpb24uDQpbICAgIDAuMDAwMDAwXSByY3U6ICAgICBSQ1UgZXZlbnQg
dHJhY2luZyBpcyBlbmFibGVkLg0KWyAgICAwLjAwMDAwMF0gcmN1OiAgICAgUkNVIHJlc3RyaWN0
aW5nIENQVXMgZnJvbSBOUl9DUFVTPTI1NiB0byBucl9jcHVfaWRzPTQuDQpbICAgIDAuMDAwMDAw
XSAgVHJhbXBvbGluZSB2YXJpYW50IG9mIFRhc2tzIFJDVSBlbmFibGVkLg0KWyAgICAwLjAwMDAw
MF0gIFRyYWNpbmcgdmFyaWFudCBvZiBUYXNrcyBSQ1UgZW5hYmxlZC4NClsgICAgMC4wMDAwMDBd
IHJjdTogUkNVIGNhbGN1bGF0ZWQgdmFsdWUgb2Ygc2NoZWR1bGVyLWVubGlzdG1lbnQgZGVsYXkg
aXMgMjUgamlmZmllcy4NClsgICAgMC4wMDAwMDBdIHJjdTogQWRqdXN0aW5nIGdlb21ldHJ5IGZv
ciByY3VfZmFub3V0X2xlYWY9MTYsIG5yX2NwdV9pZHM9NA0KWyAgICAwLjAwMDAwMF0gTlJfSVJR
UzogNjQsIG5yX2lycXM6IDY0LCBwcmVhbGxvY2F0ZWQgaXJxczogMA0KWyAgICAwLjAwMDAwMF0g
R0lDdjM6IEdJQzogVXNpbmcgc3BsaXQgRU9JL0RlYWN0aXZhdGUgbW9kZQ0KWyAgICAwLjAwMDAw
MF0gR0lDdjM6IDI1NiBTUElzIGltcGxlbWVudGVkDQpbICAgIDAuMDAwMDAwXSBHSUN2MzogMCBF
eHRlbmRlZCBTUElzIGltcGxlbWVudGVkDQpbICAgIDAuMDAwMDAwXSBSb290IElSUSBoYW5kbGVy
OiBnaWNfaGFuZGxlX2lycQ0KWyAgICAwLjAwMDAwMF0gR0lDdjM6IEdJQ3YzIGZlYXR1cmVzOiAx
NiBQUElzDQpbICAgIDAuMDAwMDAwXSBHSUN2MzogQ1BVMDogZm91bmQgcmVkaXN0cmlidXRvciAy
MDEgcmVnaW9uIDA6MHgwMDAwMDAwMDMwOGUwMDAwDQpbICAgIDAuMDAwMDAwXSBJVFMgW21lbSAw
eDMwODIwMDAwLTB4MzA4M2ZmZmZdDQpbICAgIDAuMDAwMDAwXSBJVFNAMHgwMDAwMDAwMDMwODIw
MDAwOiBhbGxvY2F0ZWQgNjU1MzYgRGV2aWNlcyBAODJjODAwMDAgKGZsYXQsIGVzeiA4LCBwc3og
NjRLLCBzaHIgMCkNClsgICAgMC4wMDAwMDBdIElUUzogdXNpbmcgY2FjaGUgZmx1c2hpbmcgZm9y
IGNtZCBxdWV1ZQ0KWyAgICAwLjAwMDAwMF0gR0lDdjM6IHVzaW5nIExQSSBwcm9wZXJ0eSB0YWJs
ZSBAMHgwMDAwMDAwMDgyYzQwMDAwDQpbICAgIDAuMDAwMDAwXSBHSUM6IHVzaW5nIGNhY2hlIGZs
dXNoaW5nIGZvciBMUEkgcHJvcGVydHkgdGFibGUNClsgICAgMC4wMDAwMDBdIEdJQ3YzOiBDUFUw
OiB1c2luZyBhbGxvY2F0ZWQgTFBJIHBlbmRpbmcgdGFibGUgQDB4MDAwMDAwMDA4MmM1MDAwMA0K
WyAgICAwLjAwMDAwMF0gcmN1OiBzcmN1X2luaXQ6IFNldHRpbmcgc3JjdV9zdHJ1Y3Qgc2l6ZXMg
YmFzZWQgb24gY29udGVudGlvbi4NClsgICAgMC4wMDAwMDBdIGFyY2hfdGltZXI6IGNwMTUgdGlt
ZXIocykgcnVubmluZyBhdCA1MC4wME1IeiAocGh5cykuDQpbICAgIDAuMDAwMDAwXSBjbG9ja3Nv
dXJjZTogYXJjaF9zeXNfY291bnRlcjogbWFzazogMHhmZmZmZmZmZmZmZmZmZiBtYXhfY3ljbGVz
OiAweGI4ODEyNzM2YiwgbWF4X2lkbGVfbnM6IDQ0MDc5NTIwMjY1NSBucw0KWyAgICAwLjAwMDAw
MF0gc2NoZWRfY2xvY2s6IDU2IGJpdHMgYXQgNTBNSHosIHJlc29sdXRpb24gMjBucywgd3JhcHMg
ZXZlcnkgNDM5ODA0NjUxMTEwMG5zDQpbICAgIDAuMDA4Njk4XSBDb25zb2xlOiBjb2xvdXIgZHVt
bXkgZGV2aWNlIDgweDI1DQpbICAgIDAuMDEzMjQwXSBDYWxpYnJhdGluZyBkZWxheSBsb29wIChz
a2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0aW1lciBmcmVxdWVuY3kuLiAxMDAuMDAg
Qm9nb01JUFMgKGxwaj0yMDAwMDApDQpbICAgIDAuMDIzNzcxXSBwaWRfbWF4OiBkZWZhdWx0OiAz
Mjc2OCBtaW5pbXVtOiAzMDENClsgICAgMC4wMjg0ODBdIExTTTogaW5pdGlhbGl6aW5nIGxzbT1j
YXBhYmlsaXR5LGludGVncml0eQ0KWyAgICAwLjAzMzc0MV0gTW91bnQtY2FjaGUgaGFzaCB0YWJs
ZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogMywgMzI3NjggYnl0ZXMsIGxpbmVhcikNClsgICAgMC4w
NDEyMDZdIE1vdW50cG9pbnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjog
MywgMzI3NjggYnl0ZXMsIGxpbmVhcikNClsgICAgMC4wNTA0MzhdIFJDVSBUYXNrczogU2V0dGlu
ZyBzaGlmdCB0byAyIGFuZCBsaW0gdG8gMSByY3VfdGFza19jYl9hZGp1c3Q9MS4NClsgICAgMC4w
NTc2NDhdIFJDVSBUYXNrcyBUcmFjZTogU2V0dGluZyBzaGlmdCB0byAyIGFuZCBsaW0gdG8gMSBy
Y3VfdGFza19jYl9hZGp1c3Q9MS4NClsgICAgMC4wNjU0NDVdIHJjdTogSGllcmFyY2hpY2FsIFNS
Q1UgaW1wbGVtZW50YXRpb24uDQpbICAgIDAuMDcwMjg4XSByY3U6ICAgICBNYXggcGhhc2Ugbm8t
ZGVsYXkgaW5zdGFuY2VzIGlzIDEwMDAuDQpbICAgIDAuMDc1NzY0XSBQbGF0Zm9ybSBNU0k6IGdp
Yy1pdHNAMzA4MjAwMDAgZG9tYWluIGNyZWF0ZWQNClsgICAgMC4wODEzMzNdIFBDSS9NU0k6IC9p
bnRlcnJ1cHQtY29udHJvbGxlckAzMDgwMDAwMC9naWMtaXRzQDMwODIwMDAwIGRvbWFpbiBjcmVh
dGVkDQpbICAgIDAuMDg5MTE4XSBmc2wtbWMgTVNJOiBnaWMtaXRzQDMwODIwMDAwIGRvbWFpbiBj
cmVhdGVkDQpbICAgIDAuMDk1Mjg1XSBFRkkgc2VydmljZXMgd2lsbCBub3QgYmUgYXZhaWxhYmxl
Lg0KWyAgICAwLjEwMDA5OF0gc21wOiBCcmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAuLi4NClsg
ICAgMC4xMTUyODldIERldGVjdGVkIFZJUFQgSS1jYWNoZSBvbiBDUFUxDQpbICAgIDAuMTE1MzU2
XSBHSUN2MzogQ1BVMTogZm91bmQgcmVkaXN0cmlidXRvciAyMDAgcmVnaW9uIDA6MHgwMDAwMDAw
MDMwOGMwMDAwDQpbICAgIDAuMTE1MzcwXSBHSUN2MzogQ1BVMTogdXNpbmcgYWxsb2NhdGVkIExQ
SSBwZW5kaW5nIHRhYmxlIEAweDAwMDAwMDAwODJjNjAwMDANClsgICAgMC4xMTU0MDldIENQVTE6
IEJvb3RlZCBzZWNvbmRhcnkgcHJvY2Vzc29yIDB4MDAwMDAwMDIwMCBbMHg3MDBmMzAzNF0NClsg
ICAgMC4xMjYxMjFdIERldGVjdGVkIFBJUFQgSS1jYWNoZSBvbiBDUFUyDQpbICAgIDAuMTI2MTMw
XSBDUFUgZmVhdHVyZXM6IFNBTklUWSBDSEVDSzogVW5leHBlY3RlZCB2YXJpYXRpb24gaW4gU1lT
X0lEX0FBNjRJU0FSMF9FTDEuIEJvb3QgQ1BVOiAweDAwMDExMTAwMDEyMTIwLCBDUFUyOiAweDAw
MDAwMTAwMDEyMTIwDQpbICAgIDAuMTI2MTQzXSBDUFUgZmVhdHVyZXM6IFNBTklUWSBDSEVDSzog
VW5leHBlY3RlZCB2YXJpYXRpb24gaW4gU1lTX01WRlIwX0VMMS4gQm9vdCBDUFU6IDB4MDAwMDAw
MTAxMTAyMjIsIENQVTI6IDB4MDAwMDAwMTAxMTEyMjINClsgICAgMC4xMjYxNDddIENQVSBmZWF0
dXJlczogVW5zdXBwb3J0ZWQgQ1BVIGZlYXR1cmUgdmFyaWF0aW9uIGRldGVjdGVkLg0KWyAgICAw
LjEyNjE3Ml0gR0lDdjM6IENQVTI6IGZvdW5kIHJlZGlzdHJpYnV0b3IgMCByZWdpb24gMDoweDAw
MDAwMDAwMzA4ODAwMDANClsgICAgMC4xMjYxNzldIEdJQ3YzOiBDUFUyOiB1c2luZyBhbGxvY2F0
ZWQgTFBJIHBlbmRpbmcgdGFibGUgQDB4MDAwMDAwMDA4MmM3MDAwMA0KWyAgICAwLjEyNjIwMF0g
Q1BVMjogQm9vdGVkIHNlY29uZGFyeSBwcm9jZXNzb3IgMHgwMDAwMDAwMDAwIFsweDcwMWY2NjQz
XQ0KWyAgICAwLjEzNjgwMF0gRGV0ZWN0ZWQgUElQVCBJLWNhY2hlIG9uIENQVTMNClsgICAgMC4x
MzY4MDZdIENQVSBmZWF0dXJlczogU0FOSVRZIENIRUNLOiBVbmV4cGVjdGVkIHZhcmlhdGlvbiBp
biBTWVNfSURfQUE2NElTQVIwX0VMMS4gQm9vdCBDUFU6IDB4MDAwMTExMDAwMTIxMjAsIENQVTM6
IDB4MDAwMDAxMDAwMTIxMjANClsgICAgMC4xMzY4MTZdIENQVSBmZWF0dXJlczogU0FOSVRZIENI
RUNLOiBVbmV4cGVjdGVkIHZhcmlhdGlvbiBpbiBTWVNfTVZGUjBfRUwxLiBCb290IENQVTogMHgw
MDAwMDAxMDExMDIyMiwgQ1BVMzogMHgwMDAwMDAxMDExMTIyMg0KWyAgICAwLjEzNjgzN10gR0lD
djM6IENQVTM6IGZvdW5kIHJlZGlzdHJpYnV0b3IgMTAwIHJlZ2lvbiAwOjB4MDAwMDAwMDAzMDhh
MDAwMA0KWyAgICAwLjEzNjg0NF0gR0lDdjM6IENQVTM6IHVzaW5nIGFsbG9jYXRlZCBMUEkgcGVu
ZGluZyB0YWJsZSBAMHgwMDAwMDAwMDgyZDAwMDAwDQpbICAgIDAuMTM2ODYwXSBDUFUzOiBCb290
ZWQgc2Vjb25kYXJ5IHByb2Nlc3NvciAweDAwMDAwMDAxMDAgWzB4NzAxZjY2NDNdDQpbICAgIDAu
MTM2OTE0XSBzbXA6IEJyb3VnaHQgdXAgMSBub2RlLCA0IENQVXMNClsgICAgMC4yNzA1MjldIFNN
UDogVG90YWwgb2YgNCBwcm9jZXNzb3JzIGFjdGl2YXRlZC4NClsgICAgMC4yNzUyNzVdIENQVSBm
ZWF0dXJlczogZGV0ZWN0ZWQ6IDMyLWJpdCBFTDAgU3VwcG9ydA0KWyAgICAwLjI4MDQ2Ml0gQ1BV
IGZlYXR1cmVzOiBkZXRlY3RlZDogMzItYml0IEVMMSBTdXBwb3J0DQpbICAgIDAuMjg1NjQyXSBD
UFUgZmVhdHVyZXM6IGRldGVjdGVkOiBDUkMzMiBpbnN0cnVjdGlvbnMNClsgICAgMC4yOTM2NDBd
IENQVTogQWxsIENQVShzKSBzdGFydGVkIGF0IEVMMg0KWyAgICAwLjI5NzgxMF0gYWx0ZXJuYXRp
dmVzOiBhcHBseWluZyBzeXN0ZW0td2lkZSBhbHRlcm5hdGl2ZXMNClsgICAgMC4zMDUwODJdIGRl
dnRtcGZzOiBpbml0aWFsaXplZA0KWyAgICAwLjMxMjM2OF0gY2xvY2tzb3VyY2U6IGppZmZpZXM6
IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczogMHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDc2
NDUwNDE3ODUxMDAwMDAgbnMNClsgICAgMC4zMjIyMjldIGZ1dGV4IGhhc2ggdGFibGUgZW50cmll
czogMTAyNCAob3JkZXI6IDQsIDY1NTM2IGJ5dGVzLCBsaW5lYXIpDQpbICAgIDAuMzI5Njc0XSBw
aW5jdHJsIGNvcmU6IGluaXRpYWxpemVkIHBpbmN0cmwgc3Vic3lzdGVtDQpbICAgIDAuMzM2MTkw
XSBETUkgbm90IHByZXNlbnQgb3IgaW52YWxpZC4NClsgICAgMC4zNDA3MDJdIE5FVDogUmVnaXN0
ZXJlZCBQRl9ORVRMSU5LL1BGX1JPVVRFIHByb3RvY29sIGZhbWlseQ0KWyAgICAwLjM0NzQ2M10g
RE1BOiBwcmVhbGxvY2F0ZWQgMjU2IEtpQiBHRlBfS0VSTkVMIHBvb2wgZm9yIGF0b21pYyBhbGxv
Y2F0aW9ucw0KWyAgICAwLjM1NDY2OV0gRE1BOiBwcmVhbGxvY2F0ZWQgMjU2IEtpQiBHRlBfS0VS
TkVMfEdGUF9ETUEgcG9vbCBmb3IgYXRvbWljIGFsbG9jYXRpb25zDQpbICAgIDAuMzYyNTY3XSBE
TUE6IHByZWFsbG9jYXRlZCAyNTYgS2lCIEdGUF9LRVJORUx8R0ZQX0RNQTMyIHBvb2wgZm9yIGF0
b21pYyBhbGxvY2F0aW9ucw0KWyAgICAwLjM3MDYyMl0gYXVkaXQ6IGluaXRpYWxpemluZyBuZXRs
aW5rIHN1YnN5cyAoZGlzYWJsZWQpDQpbICAgIDAuMzc2MTY3XSBhdWRpdDogdHlwZT0yMDAwIGF1
ZGl0KDAuMjEyOjEpOiBzdGF0ZT1pbml0aWFsaXplZCBhdWRpdF9lbmFibGVkPTAgcmVzPTENClsg
ICAgMC4zNzcwMzJdIHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJub3IgJ3N0
ZXBfd2lzZScNClsgICAgMC4zODM5OTBdIHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwg
Z292ZXJub3IgJ3Bvd2VyX2FsbG9jYXRvcicNClsgICAgMC4zOTAxMDJdIGNwdWlkbGU6IHVzaW5n
IGdvdmVybm9yIG1lbnUNClsgICAgMC40MDA4OTldIGh3LWJyZWFrcG9pbnQ6IGZvdW5kIDYgYnJl
YWtwb2ludCBhbmQgNCB3YXRjaHBvaW50IHJlZ2lzdGVycy4NClsgICAgMC40MDc4MTNdIEFTSUQg
YWxsb2NhdG9yIGluaXRpYWxpc2VkIHdpdGggMzI3NjggZW50cmllcw0KWyAgICAwLjQxNDc2Nl0g
U2VyaWFsOiBBTUJBIFBMMDExIFVBUlQgZHJpdmVyDQpbICAgIDAuNDIwNzQxXSBPRjogL3NvYy9n
cGlvQDI4MDM0MDAwL3BvcnRhOiBjb3VsZCBub3QgZ2V0ICNncGlvLWNlbGxzIGZvciAvaW50ZXJy
dXB0LWNvbnRyb2xsZXJAMzA4MDAwMDAvZ2ljLWl0c0AzMDgyMDAwMA0KWyAgICAwLjQzMTc0Ml0g
T0Y6IC9zb2MvZ3Bpb0AyODAzNTAwMC9wb3J0YTogY291bGQgbm90IGdldCAjZ3Bpby1jZWxscyBm
b3IgL2ludGVycnVwdC1jb250cm9sbGVyQDMwODAwMDAwL2dpYy1pdHNAMzA4MjAwMDANClsgICAg
MC40NDI3MzBdIE9GOiAvc29jL2dwaW9AMjgwMzYwMDAvcG9ydGE6IGNvdWxkIG5vdCBnZXQgI2dw
aW8tY2VsbHMgZm9yIC9pbnRlcnJ1cHQtY29udHJvbGxlckAzMDgwMDAwMC9naWMtaXRzQDMwODIw
MDAwDQpbICAgIDAuNDUzNjQzXSBPRjogL3NvYy9ncGlvQDI4MDM3MDAwL3BvcnRhOiBjb3VsZCBu
b3QgZ2V0ICNncGlvLWNlbGxzIGZvciAvaW50ZXJydXB0LWNvbnRyb2xsZXJAMzA4MDAwMDAvZ2lj
LWl0c0AzMDgyMDAwMA0KWyAgICAwLjQ2NDU1M10gT0Y6IC9zb2MvZ3Bpb0AyODAzODAwMC9wb3J0
YTogY291bGQgbm90IGdldCAjZ3Bpby1jZWxscyBmb3IgL2ludGVycnVwdC1jb250cm9sbGVyQDMw
ODAwMDAwL2dpYy1pdHNAMzA4MjAwMDANClsgICAgMC40NzU0NjVdIE9GOiAvc29jL2dwaW9AMjgw
MzkwMDAvcG9ydGE6IGNvdWxkIG5vdCBnZXQgI2dwaW8tY2VsbHMgZm9yIC9pbnRlcnJ1cHQtY29u
dHJvbGxlckAzMDgwMDAwMC9naWMtaXRzQDMwODIwMDAwDQpbICAgIDAuNDg4NDU3XSAyODAwZDAw
MC51YXJ0OiB0dHlBTUExIGF0IE1NSU8gMHgyODAwZDAwMCAoaXJxID0gMTQsIGJhc2VfYmF1ZCA9
IDApIGlzIGEgUEwwMTEgcmV2Mw0KWyAgICAwLjQ5NzI3NV0gcHJpbnRrOiBjb25zb2xlIFt0dHlB
TUExXSBlbmFibGVkDQpbICAgIDAuNDk3Mjc1XSBwcmludGs6IGNvbnNvbGUgW3R0eUFNQTFdIGVu
YWJsZWQNClsgICAgMC41MDYwMTVdIHByaW50azogYm9vdGNvbnNvbGUgW3BsMTFdIGRpc2FibGVk
DQpbICAgIDAuNTA2MDE1XSBwcmludGs6IGJvb3Rjb25zb2xlIFtwbDExXSBkaXNhYmxlZA0KWyAg
ICAwLjUxNjgwNl0gMjgwMGUwMDAudWFydDogdHR5QU1BMiBhdCBNTUlPIDB4MjgwMGUwMDAgKGly
cSA9IDE1LCBiYXNlX2JhdWQgPSAwKSBpcyBhIFBMMDExIHJldjMNClsgICAgMC41MzQ2NDFdIE1v
ZHVsZXM6IDIyNDMyIHBhZ2VzIGluIHJhbmdlIGZvciBub24tUExUIHVzYWdlDQpbICAgIDAuNTM0
NjUwXSBNb2R1bGVzOiA1MTM5NTIgcGFnZXMgaW4gcmFuZ2UgZm9yIFBMVCB1c2FnZQ0KWyAgICAw
LjU0MDcxM10gSHVnZVRMQjogcmVnaXN0ZXJlZCAxLjAwIEdpQiBwYWdlIHNpemUsIHByZS1hbGxv
Y2F0ZWQgMCBwYWdlcw0KWyAgICAwLjU1MjgxNl0gSHVnZVRMQjogMCBLaUIgdm1lbW1hcCBjYW4g
YmUgZnJlZWQgZm9yIGEgMS4wMCBHaUIgcGFnZQ0KWyAgICAwLjU1OTA3OV0gSHVnZVRMQjogcmVn
aXN0ZXJlZCAzMi4wIE1pQiBwYWdlIHNpemUsIHByZS1hbGxvY2F0ZWQgMCBwYWdlcw0KWyAgICAw
LjU2NTg2MF0gSHVnZVRMQjogMCBLaUIgdm1lbW1hcCBjYW4gYmUgZnJlZWQgZm9yIGEgMzIuMCBN
aUIgcGFnZQ0KWyAgICAwLjU3MjEyMV0gSHVnZVRMQjogcmVnaXN0ZXJlZCAyLjAwIE1pQiBwYWdl
IHNpemUsIHByZS1hbGxvY2F0ZWQgMCBwYWdlcw0KWyAgICAwLjU3ODkwMl0gSHVnZVRMQjogMCBL
aUIgdm1lbW1hcCBjYW4gYmUgZnJlZWQgZm9yIGEgMi4wMCBNaUIgcGFnZQ0KWyAgICAwLjU4NTE2
NF0gSHVnZVRMQjogcmVnaXN0ZXJlZCA2NC4wIEtpQiBwYWdlIHNpemUsIHByZS1hbGxvY2F0ZWQg
MCBwYWdlcw0KWyAgICAwLjU5MTk0NV0gSHVnZVRMQjogMCBLaUIgdm1lbW1hcCBjYW4gYmUgZnJl
ZWQgZm9yIGEgNjQuMCBLaUIgcGFnZQ0KWyAgICAwLjU5OTM2OF0gQUNQSTogSW50ZXJwcmV0ZXIg
ZGlzYWJsZWQuDQpbICAgIDAuNjA0NjgzXSBpb21tdTogRGVmYXVsdCBkb21haW4gdHlwZTogVHJh
bnNsYXRlZA0KWyAgICAwLjYwOTQ4N10gaW9tbXU6IERNQSBkb21haW4gVExCIGludmFsaWRhdGlv
biBwb2xpY3k6IHN0cmljdCBtb2RlDQpbICAgIDAuNjE1OTA4XSBTQ1NJIHN1YnN5c3RlbSBpbml0
aWFsaXplZA0KWyAgICAwLjYxOTczOF0gbGliYXRhIHZlcnNpb24gMy4wMCBsb2FkZWQuDQpbICAg
IDAuNjIzNzI5XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYmZz
DQpbICAgIDAuNjI5MjMwXSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVy
IGh1Yg0KWyAgICAwLjYzNDU2M10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgZGV2aWNlIGRyaXZl
ciB1c2INClsgICAgMC42NDAyNDZdIHBwc19jb3JlOiBMaW51eFBQUyBBUEkgdmVyLiAxIHJlZ2lz
dGVyZWQNClsgICAgMC42NDUyMTNdIHBwc19jb3JlOiBTb2Z0d2FyZSB2ZXIuIDUuMy42IC0gQ29w
eXJpZ2h0IDIwMDUtMjAwNyBSb2RvbGZvIEdpb21ldHRpIDxnaW9tZXR0aUBsaW51eC5pdD4NClsg
ICAgMC42NTQzNDddIFBUUCBjbG9jayBzdXBwb3J0IHJlZ2lzdGVyZWQNClsgICAgMC42NTgzNjFd
IEVEQUMgTUM6IFZlcjogMy4wLjANClsgICAgMC42NjIwNDVdIHNjbWlfY29yZTogU0NNSSBwcm90
b2NvbCBidXMgcmVnaXN0ZXJlZA0KWyAgICAwLjY2NzQxMl0gRlBHQSBtYW5hZ2VyIGZyYW1ld29y
aw0KWyAgICAwLjY3MDg3N10gQWR2YW5jZWQgTGludXggU291bmQgQXJjaGl0ZWN0dXJlIERyaXZl
ciBJbml0aWFsaXplZC4NClsgICAgMC42Nzc4NjJdIHZnYWFyYjogbG9hZGVkDQpbICAgIDAuNjgx
MTcyXSBjbG9ja3NvdXJjZTogU3dpdGNoZWQgdG8gY2xvY2tzb3VyY2UgYXJjaF9zeXNfY291bnRl
cg0KWyAgICAwLjY4NzQ3MV0gVkZTOiBEaXNrIHF1b3RhcyBkcXVvdF82LjYuMA0KWyAgICAwLjY5
MTQxOV0gVkZTOiBEcXVvdC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDUxMiAob3JkZXIgMCwg
NDA5NiBieXRlcykNClsgICAgMC42OTg0MjhdIHBucDogUG5QIEFDUEk6IGRpc2FibGVkDQpbICAg
IDAuNzA2ODE1XSBORVQ6IFJlZ2lzdGVyZWQgUEZfSU5FVCBwcm90b2NvbCBmYW1pbHkNClsgICAg
MC43MTE4MzBdIElQIGlkZW50cyBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4IChvcmRlcjogNiwg
MjYyMTQ0IGJ5dGVzLCBsaW5lYXIpDQpbICAgIDAuNzIwNDQ4XSB0Y3BfbGlzdGVuX3BvcnRhZGRy
X2hhc2ggaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRlcjogMiwgMTYzODQgYnl0ZXMsIGxp
bmVhcikNClsgICAgMC43MjkwMDhdIFRhYmxlLXBlcnR1cmIgaGFzaCB0YWJsZSBlbnRyaWVzOiA2
NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRlcywgbGluZWFyKQ0KWyAgICAwLjczNjc2MV0gVENQ
IGVzdGFibGlzaGVkIGhhc2ggdGFibGUgZW50cmllczogMTYzODQgKG9yZGVyOiA1LCAxMzEwNzIg
Ynl0ZXMsIGxpbmVhcikNClsgICAgMC43NDQ3NThdIFRDUCBiaW5kIGhhc2ggdGFibGUgZW50cmll
czogMTYzODQgKG9yZGVyOiA3LCA1MjQyODggYnl0ZXMsIGxpbmVhcikNClsgICAgMC43NTIzODFd
IFRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAoZXN0YWJsaXNoZWQgMTYzODQgYmluZCAxNjM4
NCkNClsgICAgMC43NTkwMjJdIFVEUCBoYXNoIHRhYmxlIGVudHJpZXM6IDEwMjQgKG9yZGVyOiAz
LCAzMjc2OCBieXRlcywgbGluZWFyKQ0KWyAgICAwLjc2NTc2M10gVURQLUxpdGUgaGFzaCB0YWJs
ZSBlbnRyaWVzOiAxMDI0IChvcmRlcjogMywgMzI3NjggYnl0ZXMsIGxpbmVhcikNClsgICAgMC43
NzMwMzRdIE5FVDogUmVnaXN0ZXJlZCBQRl9VTklYL1BGX0xPQ0FMIHByb3RvY29sIGZhbWlseQ0K
WyAgICAwLjc3ODkyOF0gUlBDOiBSZWdpc3RlcmVkIG5hbWVkIFVOSVggc29ja2V0IHRyYW5zcG9y
dCBtb2R1bGUuDQpbICAgIDAuNzg0ODU1XSBSUEM6IFJlZ2lzdGVyZWQgdWRwIHRyYW5zcG9ydCBt
b2R1bGUuDQpbICAgIDAuNzg5NTU1XSBSUEM6IFJlZ2lzdGVyZWQgdGNwIHRyYW5zcG9ydCBtb2R1
bGUuDQpbICAgIDAuNzk0MjU0XSBSUEM6IFJlZ2lzdGVyZWQgdGNwLXdpdGgtdGxzIHRyYW5zcG9y
dCBtb2R1bGUuDQpbICAgIDAuNzk5NzM0XSBSUEM6IFJlZ2lzdGVyZWQgdGNwIE5GU3Y0LjEgYmFj
a2NoYW5uZWwgdHJhbnNwb3J0IG1vZHVsZS4NClsgICAgMC44MDYxODBdIFBDSTogQ0xTIDAgYnl0
ZXMsIGRlZmF1bHQgNjQNClsgICAgMC44MTAyODJdIFVucGFja2luZyBpbml0cmFtZnMuLi4NClsg
ICAgMC44MjEzMTBdIGt2bSBbMV06IElQQSBTaXplIExpbWl0OiA0MCBiaXRzDQpbICAgIDAuODI2
MzMwXSBrdm0gWzFdOiB2Z2ljLXYyQDMwODYwMDAwDQpbICAgIDAuODI5OTk5XSBrdm0gWzFdOiBH
SUMgc3lzdGVtIHJlZ2lzdGVyIENQVSBpbnRlcmZhY2UgZW5hYmxlZA0KWyAgICAwLjgzNTgzNl0g
a3ZtIFsxXTogdmdpYyBpbnRlcnJ1cHQgSVJROQ0KWyAgICAwLjgzOTc2Nl0ga3ZtIFsxXTogSHlw
IG1vZGUgaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5DQpbICAgIDAuODQ1NTgwXSBJbml0aWFsaXNl
IHN5c3RlbSB0cnVzdGVkIGtleXJpbmdzDQpbICAgIDAuODUwMTUxXSB3b3JraW5nc2V0OiB0aW1l
c3RhbXBfYml0cz00MiBtYXhfb3JkZXI9MTkgYnVja2V0X29yZGVyPTANClsgICAgMC44NTY3NDZd
IHNxdWFzaGZzOiB2ZXJzaW9uIDQuMCAoMjAwOS8wMS8zMSkgUGhpbGxpcCBMb3VnaGVyDQpbICAg
IDAuODYyNzQ1XSBORlM6IFJlZ2lzdGVyaW5nIHRoZSBpZF9yZXNvbHZlciBrZXkgdHlwZQ0KWyAg
ICAwLjg2NzgwOF0gS2V5IHR5cGUgaWRfcmVzb2x2ZXIgcmVnaXN0ZXJlZA0KWyAgICAwLjg3MTk4
NF0gS2V5IHR5cGUgaWRfbGVnYWN5IHJlZ2lzdGVyZWQNClsgICAgMC44NzU5OTRdIG5mczRmaWxl
bGF5b3V0X2luaXQ6IE5GU3Y0IEZpbGUgTGF5b3V0IERyaXZlciBSZWdpc3RlcmluZy4uLg0KWyAg
ICAwLjg4MjY5MF0gbmZzNGZsZXhmaWxlbGF5b3V0X2luaXQ6IE5GU3Y0IEZsZXhmaWxlIExheW91
dCBEcml2ZXIgUmVnaXN0ZXJpbmcuLi4NClsgICAgMC44OTAxNjddIDlwOiBJbnN0YWxsaW5nIHY5
ZnMgOXAyMDAwIGZpbGUgc3lzdGVtIHN1cHBvcnQNClsgICAgMC45MDUxMThdIEtleSB0eXBlIGFz
eW1tZXRyaWMgcmVnaXN0ZXJlZA0KWyAgICAwLjkwOTIwOF0gQXN5bW1ldHJpYyBrZXkgcGFyc2Vy
ICd4NTA5JyByZWdpc3RlcmVkDQpbICAgIDAuOTE0MTAwXSBCbG9jayBsYXllciBTQ1NJIGdlbmVy
aWMgKGJzZykgZHJpdmVyIHZlcnNpb24gMC40IGxvYWRlZCAobWFqb3IgMjQ1KQ0KWyAgICAwLjky
MTQ4OF0gaW8gc2NoZWR1bGVyIG1xLWRlYWRsaW5lIHJlZ2lzdGVyZWQNClsgICAgMC45MjYwMTFd
IGlvIHNjaGVkdWxlciBreWJlciByZWdpc3RlcmVkDQpbICAgIDAuOTMwMDI5XSBpbyBzY2hlZHVs
ZXIgYmZxIHJlZ2lzdGVyZWQNClsgICAgMC45MzgxNDJdIHBjaS1ob3N0LWdlbmVyaWMgNDAwMDAw
MDAucGNpZTogaG9zdCBicmlkZ2UgL3NvYy9wY2llQDQwMDAwMDAwIHJhbmdlczoNClsgICAgMC45
NDU3MzJdIHBjaS1ob3N0LWdlbmVyaWMgNDAwMDAwMDAucGNpZTogICAgICAgSU8gMHgwMDUwMDAw
MDAwLi4weDAwNTBlZmZmZmYgLT4gMHgwMDAwMDAwMDAwDQpbICAgIDAuOTU0NDMzXSBwY2ktaG9z
dC1nZW5lcmljIDQwMDAwMDAwLnBjaWU6ICAgICAgTUVNIDB4MDA1ODAwMDAwMC4uMHgwMDdmZmZm
ZmZmIC0+IDB4MDA1ODAwMDAwMA0KWyAgICAwLjk2MzEyN10gcGNpLWhvc3QtZ2VuZXJpYyA0MDAw
MDAwMC5wY2llOiAgICAgIE1FTSAweDEwMDAwMDAwMDAuLjB4MWZmZmZmZmZmZiAtPiAweDEwMDAw
MDAwMDANClsgICAgMC45NzE4NDBdIHBjaS1ob3N0LWdlbmVyaWMgNDAwMDAwMDAucGNpZTogTWVt
b3J5IHJlc291cmNlIHNpemUgZXhjZWVkcyBtYXggZm9yIDMyIGJpdHMNClsgICAgMC45Nzk5NDVd
IHBjaS1ob3N0LWdlbmVyaWMgNDAwMDAwMDAucGNpZTogRUNBTSBhdCBbbWVtIDB4NDAwMDAwMDAt
MHg0ZmZmZmZmZl0gZm9yIFtidXMgMDAtZmZdDQpbICAgIDAuOTg4NzYxXSBwY2ktaG9zdC1nZW5l
cmljIDQwMDAwMDAwLnBjaWU6IFBDSSBob3N0IGJyaWRnZSB0byBidXMgMDAwMDowMA0KWyAgICAw
Ljk5NTYzMV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbYnVzIDAwLWZmXQ0K
WyAgICAxLjAwMTEwOV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4
MDAwMC0weGVmZmZmZl0NClsgICAgMS4wMDc0NTVdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMg
cmVzb3VyY2UgW21lbSAweDU4MDAwMDAwLTB4N2ZmZmZmZmZdDQpbICAgIDEuMDE0MzIxXSBwY2lf
YnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0gMHgxMDAwMDAwMDAwLTB4MWZmZmZm
ZmZmZl0NClsgICAgMS4wMjE1NDddIHBjaSAwMDAwOjAwOjAwLjA6IFsxZGI3OmRjMDFdIHR5cGUg
MDEgY2xhc3MgMHgwNjA0MDANClsgICAgMS4wMjc1NTFdIHBjaSAwMDAwOjAwOjAwLjA6IHJlZyAw
eDEwOiBbbWVtIDB4NTgwMDAwMDAtMHg1ODAwMGZmZl0NClsgICAgMS4wMzM4NDJdIHBjaSAwMDAw
OjAwOjAwLjA6IHN1cHBvcnRzIEQxIEQyDQpbICAgIDEuMDM4MTA1XSBwY2kgMDAwMDowMDowMC4w
OiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQxIEQyIEQzaG90IEQzY29sZA0KWyAgICAxLjA0NDgy
MV0gcGNpIDAwMDA6MDA6MDEuMDogWzFkYjc6ZGMwMV0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMA0K
WyAgICAxLjA1MDgzMV0gcGNpIDAwMDA6MDA6MDEuMDogcmVnIDB4MTA6IFttZW0gMHgxMDAwMDAw
MDAwLTB4MTAwMDBmZmZmZiA2NGJpdCBwcmVmXQ0KWyAgICAxLjA1ODQyMF0gcGNpIDAwMDA6MDA6
MDEuMDogc3VwcG9ydHMgRDEgRDINClsgICAgMS4wNjI2ODJdIHBjaSAwMDAwOjAwOjAxLjA6IFBN
RSMgc3VwcG9ydGVkIGZyb20gRDAgRDEgRDIgRDNob3QgRDNjb2xkDQpbICAgIDEuMDY5Mzc2XSBw
Y2kgMDAwMDowMDowMi4wOiBbMWRiNzpkYzAxXSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAwDQpbICAg
IDEuMDc1MzgyXSBwY2kgMDAwMDowMDowMi4wOiByZWcgMHgxMDogW21lbSAweDEwMDAxMDAwMDAt
MHgxMDAwMWZmZmZmIDY0Yml0IHByZWZdDQpbICAgIDEuMDgyOTc2XSBwY2kgMDAwMDowMDowMi4w
OiBzdXBwb3J0cyBEMSBEMg0KWyAgICAxLjA4NzIzOF0gcGNpIDAwMDA6MDA6MDIuMDogUE1FIyBz
dXBwb3J0ZWQgZnJvbSBEMCBEMSBEMiBEM2hvdCBEM2NvbGQNClsgICAgMS4wOTM5MzFdIHBjaSAw
MDAwOjAwOjAzLjA6IFsxZGI3OmRjMDFdIHR5cGUgMDEgY2xhc3MgMHgwNjA0MDANClsgICAgMS4w
OTk5MzhdIHBjaSAwMDAwOjAwOjAzLjA6IHJlZyAweDEwOiBbbWVtIDB4MTAwMDIwMDAwMC0weDEw
MDAyZmZmZmYgNjRiaXQgcHJlZl0NClsgICAgMS4xMDc1MzFdIHBjaSAwMDAwOjAwOjAzLjA6IHN1
cHBvcnRzIEQxIEQyDQpbICAgIDEuMTExNzkzXSBwY2kgMDAwMDowMDowMy4wOiBQTUUjIHN1cHBv
cnRlZCBmcm9tIEQwIEQxIEQyIEQzaG90IEQzY29sZA0KWyAgICAxLjExODUwNF0gcGNpIDAwMDA6
MDA6MDQuMDogWzFkYjc6ZGMwMV0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMA0KWyAgICAxLjEyNDUz
Ml0gcGNpIDAwMDA6MDA6MDQuMDogcmVnIDB4MTA6IFttZW0gMHgxMDAwMzAwMDAwLTB4MTAwMDNm
ZmZmZiA2NGJpdCBwcmVmXQ0KWyAgICAxLjEzMjEyOV0gcGNpIDAwMDA6MDA6MDQuMDogc3VwcG9y
dHMgRDEgRDINClsgICAgMS4xMzYzOTFdIHBjaSAwMDAwOjAwOjA0LjA6IFBNRSMgc3VwcG9ydGVk
IGZyb20gRDAgRDEgRDIgRDNob3QgRDNjb2xkDQpbICAgIDEuMTQzMDkxXSBwY2kgMDAwMDowMDow
NS4wOiBbMWRiNzpkYzAxXSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAwDQpbICAgIDEuMTQ5MDk3XSBw
Y2kgMDAwMDowMDowNS4wOiByZWcgMHgxMDogW21lbSAweDEwMDA0MDAwMDAtMHgxMDAwNGZmZmZm
IDY0Yml0IHByZWZdDQpbICAgIDEuMTU2NjkxXSBwY2kgMDAwMDowMDowNS4wOiBzdXBwb3J0cyBE
MSBEMg0KWyAgICAxLjE2MDk1M10gcGNpIDAwMDA6MDA6MDUuMDogUE1FIyBzdXBwb3J0ZWQgZnJv
bSBEMCBEMSBEMiBEM2hvdCBEM2NvbGQNClsgICAgMS4xNjgwMzZdIHBjaSAwMDAwOjAxOjAwLjA6
IFsxZjBhOjY4MDFdIHR5cGUgMDAgY2xhc3MgMHgwMjAwMDANClsgICAgMS4xNzQwNzBdIHBjaSAw
MDAwOjAxOjAwLjA6IHJlZyAweDEwOiBbbWVtIDB4NTgxMDAwMDAtMHg1ODEwM2ZmZiA2NGJpdF0N
ClsgICAgMS4xODA4ODldIHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDIwOiBbaW8gIDB4MTAwMC0w
eDEwZmZdDQpbICAgIDEuMTg2NTg5XSBwY2kgMDAwMDowMTowMC4wOiBzdXBwb3J0cyBEMQ0KWyAg
ICAxLjE5MDU5MF0gcGNpIDAwMDA6MDE6MDAuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEMSBE
M2hvdCBEM2NvbGQNClsgICAgMS4yMDUyMTBdIHBjaV9idXMgMDAwMDowMTogYnVzbl9yZXM6IFti
dXMgMDEtZmZdIGVuZCBpcyB1cGRhdGVkIHRvIDAxDQpbICAgIDEuMjExODc4XSBwY2lfYnVzIDAw
MDA6MDI6IGJ1c25fcmVzOiBbYnVzIDAyLWZmXSBlbmQgaXMgdXBkYXRlZCB0byAwMg0KWyAgICAx
LjIxODUzN10gcGNpX2J1cyAwMDAwOjAzOiBidXNuX3JlczogW2J1cyAwMy1mZl0gZW5kIGlzIHVw
ZGF0ZWQgdG8gMDMNClsgICAgMS4yMjUxOTVdIHBjaV9idXMgMDAwMDowNDogYnVzbl9yZXM6IFti
dXMgMDQtZmZdIGVuZCBpcyB1cGRhdGVkIHRvIDA0DQpbICAgIDEuMjMxODY2XSBwY2kgMDAwMDow
NTowMC4wOiBbMWYwYTo2ODAxXSB0eXBlIDAwIGNsYXNzIDB4MDIwMDAwDQpbICAgIDEuMjM3ODk4
XSBwY2kgMDAwMDowNTowMC4wOiByZWcgMHgxMDogW21lbSAweDU4MjAwMDAwLTB4NTgyMDNmZmYg
NjRiaXRdDQpbICAgIDEuMjQ0NzE3XSBwY2kgMDAwMDowNTowMC4wOiByZWcgMHgyMDogW2lvICAw
eDIwMDAtMHgyMGZmXQ0KWyAgICAxLjI1MDQxOV0gcGNpIDAwMDA6MDU6MDAuMDogc3VwcG9ydHMg
RDENClsgICAgMS4yNTQ0MjFdIHBjaSAwMDAwOjA1OjAwLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20g
RDAgRDEgRDNob3QgRDNjb2xkDQpbICAgIDEuMjY5MjEwXSBwY2lfYnVzIDAwMDA6MDU6IGJ1c25f
cmVzOiBbYnVzIDA1LWZmXSBlbmQgaXMgdXBkYXRlZCB0byAwNQ0KWyAgICAxLjI3NTg4NV0gcGNp
IDAwMDA6MDY6MDAuMDogWzFmMGE6NjgwMV0gdHlwZSAwMCBjbGFzcyAweDAyMDAwMA0KWyAgICAx
LjI4MTkxOV0gcGNpIDAwMDA6MDY6MDAuMDogcmVnIDB4MTA6IFttZW0gMHg1ODMwMDAwMC0weDU4
MzAzZmZmIDY0Yml0XQ0KWyAgICAxLjI4ODczOV0gcGNpIDAwMDA6MDY6MDAuMDogcmVnIDB4MjA6
IFtpbyAgMHgzMDAwLTB4MzBmZl0NClsgICAgMS4yOTQ0NDJdIHBjaSAwMDAwOjA2OjAwLjA6IHN1
cHBvcnRzIEQxDQpbICAgIDEuMjk4NDQzXSBwY2kgMDAwMDowNjowMC4wOiBQTUUjIHN1cHBvcnRl
ZCBmcm9tIEQwIEQxIEQzaG90IEQzY29sZA0KWyAgICAxLjMxMzIwOV0gcGNpX2J1cyAwMDAwOjA2
OiBidXNuX3JlczogW2J1cyAwNi1mZl0gZW5kIGlzIHVwZGF0ZWQgdG8gMDYNClsgICAgMS4zMTk4
MzhdIHBjaSAwMDAwOjAwOjAwLjA6IEJBUiAxNDogYXNzaWduZWQgW21lbSAweDU4MDAwMDAwLTB4
NTgxZmZmZmZdDQpbICAgIDEuMzI2NzA5XSBwY2kgMDAwMDowMDowMC4wOiBCQVIgMTU6IGFzc2ln
bmVkIFttZW0gMHgxMDAwMDAwMDAwLTB4MTAwMDFmZmZmZiA2NGJpdCBwcmVmXQ0KWyAgICAxLjMz
NDg4MF0gcGNpIDAwMDA6MDA6MDEuMDogQkFSIDA6IGFzc2lnbmVkIFttZW0gMHgxMDAwMjAwMDAw
LTB4MTAwMDJmZmZmZiA2NGJpdCBwcmVmXQ0KWyAgICAxLjM0Mjk2NF0gcGNpIDAwMDA6MDA6MDEu
MDogQkFSIDE0OiBhc3NpZ25lZCBbbWVtIDB4NTgyMDAwMDAtMHg1ODNmZmZmZl0NClsgICAgMS4z
NDk4MzFdIHBjaSAwMDAwOjAwOjAxLjA6IEJBUiAxNTogYXNzaWduZWQgW21lbSAweDEwMDAzMDAw
MDAtMHgxMDAwNGZmZmZmIDY0Yml0IHByZWZdDQpbICAgIDEuMzU4MDAwXSBwY2kgMDAwMDowMDow
Mi4wOiBCQVIgMDogYXNzaWduZWQgW21lbSAweDEwMDA1MDAwMDAtMHgxMDAwNWZmZmZmIDY0Yml0
IHByZWZdDQpbICAgIDEuMzY2MDg0XSBwY2kgMDAwMDowMDowMi4wOiBCQVIgMTQ6IGFzc2lnbmVk
IFttZW0gMHg1ODQwMDAwMC0weDU4NWZmZmZmXQ0KWyAgICAxLjM3Mjk1MV0gcGNpIDAwMDA6MDA6
MDIuMDogQkFSIDE1OiBhc3NpZ25lZCBbbWVtIDB4MTAwMDYwMDAwMC0weDEwMDA3ZmZmZmYgNjRi
aXQgcHJlZl0NClsgICAgMS4zODExMTldIHBjaSAwMDAwOjAwOjAzLjA6IEJBUiAwOiBhc3NpZ25l
ZCBbbWVtIDB4MTAwMDgwMDAwMC0weDEwMDA4ZmZmZmYgNjRiaXQgcHJlZl0NClsgICAgMS4zODky
MDNdIHBjaSAwMDAwOjAwOjAzLjA6IEJBUiAxNDogYXNzaWduZWQgW21lbSAweDU4NjAwMDAwLTB4
NTg3ZmZmZmZdDQpbICAgIDEuMzk2MDcwXSBwY2kgMDAwMDowMDowMy4wOiBCQVIgMTU6IGFzc2ln
bmVkIFttZW0gMHgxMDAwOTAwMDAwLTB4MTAwMGFmZmZmZiA2NGJpdCBwcmVmXQ0KWyAgICAxLjQw
NDI0MF0gcGNpIDAwMDA6MDA6MDQuMDogQkFSIDA6IGFzc2lnbmVkIFttZW0gMHgxMDAwYjAwMDAw
LTB4MTAwMGJmZmZmZiA2NGJpdCBwcmVmXQ0KWyAgICAxLjQxMjMyNV0gcGNpIDAwMDA6MDA6MDQu
MDogQkFSIDE0OiBhc3NpZ25lZCBbbWVtIDB4NTg4MDAwMDAtMHg1ODlmZmZmZl0NClsgICAgMS40
MTkxOTFdIHBjaSAwMDAwOjAwOjA0LjA6IEJBUiAxNTogYXNzaWduZWQgW21lbSAweDEwMDBjMDAw
MDAtMHgxMDAwZGZmZmZmIDY0Yml0IHByZWZdDQpbICAgIDEuNDI3MzU5XSBwY2kgMDAwMDowMDow
NS4wOiBCQVIgMDogYXNzaWduZWQgW21lbSAweDEwMDBlMDAwMDAtMHgxMDAwZWZmZmZmIDY0Yml0
IHByZWZdDQpbICAgIDEuNDM1NDQzXSBwY2kgMDAwMDowMDowNS4wOiBCQVIgMTQ6IGFzc2lnbmVk
IFttZW0gMHg1OGEwMDAwMC0weDU4YmZmZmZmXQ0KWyAgICAxLjQ0MjMxM10gcGNpIDAwMDA6MDA6
MDUuMDogQkFSIDE1OiBhc3NpZ25lZCBbbWVtIDB4MTAwMGYwMDAwMC0weDEwMDEwZmZmZmYgNjRi
aXQgcHJlZl0NClsgICAgMS40NTA0ODJdIHBjaSAwMDAwOjAwOjAwLjA6IEJBUiAwOiBhc3NpZ25l
ZCBbbWVtIDB4NThjMDAwMDAtMHg1OGMwMGZmZl0NClsgICAgMS40NTcyNjJdIHBjaSAwMDAwOjAw
OjAwLjA6IEJBUiAxMzogYXNzaWduZWQgW2lvICAweDEwMDAtMHgxZmZmXQ0KWyAgICAxLjQ2MzQz
NF0gcGNpIDAwMDA6MDA6MDEuMDogQkFSIDEzOiBhc3NpZ25lZCBbaW8gIDB4MjAwMC0weDJmZmZd
DQpbICAgIDEuNDY5NjA1XSBwY2kgMDAwMDowMDowMi4wOiBCQVIgMTM6IGFzc2lnbmVkIFtpbyAg
MHgzMDAwLTB4M2ZmZl0NClsgICAgMS40NzU3NzZdIHBjaSAwMDAwOjAwOjAzLjA6IEJBUiAxMzog
YXNzaWduZWQgW2lvICAweDQwMDAtMHg0ZmZmXQ0KWyAgICAxLjQ4MTk0OF0gcGNpIDAwMDA6MDA6
MDQuMDogQkFSIDEzOiBhc3NpZ25lZCBbaW8gIDB4NTAwMC0weDVmZmZdDQpbICAgIDEuNDg4MTE5
XSBwY2kgMDAwMDowMDowNS4wOiBCQVIgMTM6IGFzc2lnbmVkIFtpbyAgMHg2MDAwLTB4NmZmZl0N
ClsgICAgMS40OTQyOTVdIHBjaSAwMDAwOjAxOjAwLjA6IEJBUiAwOiBhc3NpZ25lZCBbbWVtIDB4
NTgwMDAwMDAtMHg1ODAwM2ZmZiA2NGJpdF0NClsgICAgMS41MDE2MDhdIHBjaSAwMDAwOjAxOjAw
LjA6IEJBUiA0OiBhc3NpZ25lZCBbaW8gIDB4MTAwMC0weDEwZmZdDQpbICAgIDEuNTA3Njk5XSBw
Y2kgMDAwMDowMDowMC4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDFdDQpbICAgIDEuNTEyNjU4XSBw
Y2kgMDAwMDowMDowMC4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDEwMDAtMHgxZmZmXQ0KWyAg
ICAxLjUxODc0NV0gcGNpIDAwMDA6MDA6MDAuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg1ODAw
MDAwMC0weDU4MWZmZmZmXQ0KWyAgICAxLjUyNTUyNF0gcGNpIDAwMDA6MDA6MDAuMDogICBicmlk
Z2Ugd2luZG93IFttZW0gMHgxMDAwMDAwMDAwLTB4MTAwMDFmZmZmZiA2NGJpdCBwcmVmXQ0KWyAg
ICAxLjUzMzYwNl0gcGNpIDAwMDA6MDA6MDEuMDogUENJIGJyaWRnZSB0byBbYnVzIDAyXQ0KWyAg
ICAxLjUzODU2Ml0gcGNpIDAwMDA6MDA6MDEuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHgyMDAw
LTB4MmZmZl0NClsgICAgMS41NDQ2NDddIHBjaSAwMDAwOjAwOjAxLjA6ICAgYnJpZGdlIHdpbmRv
dyBbbWVtIDB4NTgyMDAwMDAtMHg1ODNmZmZmZl0NClsgICAgMS41NTE0MjddIHBjaSAwMDAwOjAw
OjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4MTAwMDMwMDAwMC0weDEwMDA0ZmZmZmYgNjRi
aXQgcHJlZl0NClsgICAgMS41NTk1MDldIHBjaSAwMDAwOjAwOjAyLjA6IFBDSSBicmlkZ2UgdG8g
W2J1cyAwM10NClsgICAgMS41NjQ0NjRdIHBjaSAwMDAwOjAwOjAyLjA6ICAgYnJpZGdlIHdpbmRv
dyBbaW8gIDB4MzAwMC0weDNmZmZdDQpbICAgIDEuNTcwNTUxXSBwY2kgMDAwMDowMDowMi4wOiAg
IGJyaWRnZSB3aW5kb3cgW21lbSAweDU4NDAwMDAwLTB4NTg1ZmZmZmZdDQpbICAgIDEuNTc3MzMx
XSBwY2kgMDAwMDowMDowMi4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDEwMDA2MDAwMDAtMHgx
MDAwN2ZmZmZmIDY0Yml0IHByZWZdDQpbICAgIDEuNTg1NDE0XSBwY2kgMDAwMDowMDowMy4wOiBQ
Q0kgYnJpZGdlIHRvIFtidXMgMDRdDQpbICAgIDEuNTkwMzY5XSBwY2kgMDAwMDowMDowMy4wOiAg
IGJyaWRnZSB3aW5kb3cgW2lvICAweDQwMDAtMHg0ZmZmXQ0KWyAgICAxLjU5NjQ1NF0gcGNpIDAw
MDA6MDA6MDMuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg1ODYwMDAwMC0weDU4N2ZmZmZmXQ0K
WyAgICAxLjYwMzIzNF0gcGNpIDAwMDA6MDA6MDMuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHgx
MDAwOTAwMDAwLTB4MTAwMGFmZmZmZiA2NGJpdCBwcmVmXQ0KWyAgICAxLjYxMTMxOF0gcGNpIDAw
MDA6MDU6MDAuMDogQkFSIDA6IGFzc2lnbmVkIFttZW0gMHg1ODgwMDAwMC0weDU4ODAzZmZmIDY0
Yml0XQ0KWyAgICAxLjYxODYzMl0gcGNpIDAwMDA6MDU6MDAuMDogQkFSIDQ6IGFzc2lnbmVkIFtp
byAgMHg1MDAwLTB4NTBmZl0NClsgICAgMS42MjQ3MjVdIHBjaSAwMDAwOjAwOjA0LjA6IFBDSSBi
cmlkZ2UgdG8gW2J1cyAwNV0NClsgICAgMS42Mjk2ODFdIHBjaSAwMDAwOjAwOjA0LjA6ICAgYnJp
ZGdlIHdpbmRvdyBbaW8gIDB4NTAwMC0weDVmZmZdDQpbICAgIDEuNjM1NzY3XSBwY2kgMDAwMDow
MDowNC4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDU4ODAwMDAwLTB4NTg5ZmZmZmZdDQpbICAg
IDEuNjQyNTQ2XSBwY2kgMDAwMDowMDowNC4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDEwMDBj
MDAwMDAtMHgxMDAwZGZmZmZmIDY0Yml0IHByZWZdDQpbICAgIDEuNjUwNjMwXSBwY2kgMDAwMDow
NjowMC4wOiBCQVIgMDogYXNzaWduZWQgW21lbSAweDU4YTAwMDAwLTB4NThhMDNmZmYgNjRiaXRd
DQpbICAgIDEuNjU3OTQ0XSBwY2kgMDAwMDowNjowMC4wOiBCQVIgNDogYXNzaWduZWQgW2lvICAw
eDYwMDAtMHg2MGZmXQ0KWyAgICAxLjY2NDAzMl0gcGNpIDAwMDA6MDA6MDUuMDogUENJIGJyaWRn
ZSB0byBbYnVzIDA2XQ0KWyAgICAxLjY2ODk4OF0gcGNpIDAwMDA6MDA6MDUuMDogICBicmlkZ2Ug
d2luZG93IFtpbyAgMHg2MDAwLTB4NmZmZl0NClsgICAgMS42NzUwNzNdIHBjaSAwMDAwOjAwOjA1
LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4NThhMDAwMDAtMHg1OGJmZmZmZl0NClsgICAgMS42
ODE4NTJdIHBjaSAwMDAwOjAwOjA1LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4MTAwMGYwMDAw
MC0weDEwMDEwZmZmZmYgNjRiaXQgcHJlZl0NClsgICAgMS42OTAxMjNdIHBjaWVwb3J0IDAwMDA6
MDA6MDAuMDogUE1FOiBTaWduYWxpbmcgd2l0aCBJUlEgMTcNClsgICAgMS42OTYwMzNdIHBjaWVw
b3J0IDAwMDA6MDA6MDAuMDogQUVSOiBlbmFibGVkIHdpdGggSVJRIDE3DQpbICAgIDEuNzAxNzc0
XSBwY2llcG9ydCAwMDAwOjAwOjAxLjA6IFBNRTogU2lnbmFsaW5nIHdpdGggSVJRIDE4DQpbICAg
IDEuNzA3NjY3XSBwY2llcG9ydCAwMDAwOjAwOjAxLjA6IEFFUjogZW5hYmxlZCB3aXRoIElSUSAx
OA0KWyAgICAxLjcxMzQwNF0gcGNpZXBvcnQgMDAwMDowMDowMi4wOiBQTUU6IFNpZ25hbGluZyB3
aXRoIElSUSAxOQ0KWyAgICAxLjcxOTMxN10gcGNpZXBvcnQgMDAwMDowMDowMi4wOiBBRVI6IGVu
YWJsZWQgd2l0aCBJUlEgMTkNClsgICAgMS43MjUwNThdIHBjaWVwb3J0IDAwMDA6MDA6MDMuMDog
UE1FOiBTaWduYWxpbmcgd2l0aCBJUlEgMjANClsgICAgMS43MzA5NjNdIHBjaWVwb3J0IDAwMDA6
MDA6MDMuMDogQUVSOiBlbmFibGVkIHdpdGggSVJRIDIwDQpbICAgIDEuNzM2NzA1XSBwY2llcG9y
dCAwMDAwOjAwOjA0LjA6IFBNRTogU2lnbmFsaW5nIHdpdGggSVJRIDIxDQpbICAgIDEuNzQyNjE1
XSBwY2llcG9ydCAwMDAwOjAwOjA0LjA6IEFFUjogZW5hYmxlZCB3aXRoIElSUSAyMQ0KWyAgICAx
Ljc0ODM1MF0gcGNpZXBvcnQgMDAwMDowMDowNS4wOiBQTUU6IFNpZ25hbGluZyB3aXRoIElSUSAy
Mg0KWyAgICAxLjc1NDI2N10gcGNpZXBvcnQgMDAwMDowMDowNS4wOiBBRVI6IGVuYWJsZWQgd2l0
aCBJUlEgMjINClsgICAgMS43NjA3MTBdIEVJTko6IEFDUEkgZGlzYWJsZWQuDQpbICAgIDEuNzc1
MDQ0XSBTZXJpYWw6IDgyNTAvMTY1NTAgZHJpdmVyLCA0IHBvcnRzLCBJUlEgc2hhcmluZyBlbmFi
bGVkDQpbICAgIDEuNzgyODUwXSBTdXBlckggKEgpU0NJKEYpIGRyaXZlciBpbml0aWFsaXplZA0K
WyAgICAxLjc4NzU5Nl0gbXNtX3NlcmlhbDogZHJpdmVyIGluaXRpYWxpemVkDQpbICAgIDEuNzkx
OTc0XSBTVE0zMiBVU0FSVCBkcml2ZXIgaW5pdGlhbGl6ZWQNClsgICAgMS43OTk1NzhdIGxvb3A6
IG1vZHVsZSBsb2FkZWQNClsgICAgMS44MDMyNjddIG1lZ2FzYXM6IDA3LjcyNS4wMS4wMC1yYzEN
ClsgICAgMS44MDcyMTRdIGFoY2kgMzFhNDAwMDAuc2F0YTogc3VwcGx5IGFoY2kgbm90IGZvdW5k
LCB1c2luZyBkdW1teSByZWd1bGF0b3INClsgICAgMS44MTQzMTJdIGFoY2kgMzFhNDAwMDAuc2F0
YTogc3VwcGx5IHBoeSBub3QgZm91bmQsIHVzaW5nIGR1bW15IHJlZ3VsYXRvcg0KWyAgICAxLjgy
MTI4N10gYWhjaSAzMWE0MDAwMC5zYXRhOiBzdXBwbHkgdGFyZ2V0IG5vdCBmb3VuZCwgdXNpbmcg
ZHVtbXkgcmVndWxhdG9yDQpbICAgIDEuODI4NTgzXSBhaGNpIDMxYTQwMDAwLnNhdGE6IFNTUyBm
bGFnIHNldCwgcGFyYWxsZWwgYnVzIHNjYW4gZGlzYWJsZWQNClsgICAgMS44MzUyODZdIGFoY2kg
MzFhNDAwMDAuc2F0YTogQUhDSSAwMDAxLjAzMDEgMzIgc2xvdHMgMSBwb3J0cyA2IEdicHMgMHgx
IGltcGwgcGxhdGZvcm0gbW9kZQ0KWyAgICAxLjg0MzgwNF0gYWhjaSAzMWE0MDAwMC5zYXRhOiBm
bGFnczogNjRiaXQgbmNxIHNudGYgc3RhZyBwbSBsZWQgY2xvIG9ubHkgcG1wIHBpbyBzbHVtIHBh
cnQgY2NjIHNhZG0gc2RzIGFwc3QNClsgICAgMS44NTQwNjddIFVuYWJsZSB0byBoYW5kbGUga2Vy
bmVsIHdyaXRlIHRvIHJlYWQtb25seSBtZW1vcnkgYXQgdmlydHVhbCBhZGRyZXNzIGZmZmYwMDAw
MDEwYzAwMDANClsgICAgMS44NjIzNDJdIEluaXRyYW1mcyB1bnBhY2tpbmcgZmFpbGVkOiBpbnZh
bGlkIG1hZ2ljIGF0IHN0YXJ0IG9mIGNvbXByZXNzZWQgYXJjaGl2ZQ0KWyAgICAxLjg2MjkzN10g
TWVtIGFib3J0IGluZm86DQpbICAgIDEuODczNDUwXSAgIEVTUiA9IDB4MDAwMDAwMDA5NjAwMDA0
ZQ0KWyAgICAxLjg3NzE5MV0gICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMy
IGJpdHMNClsgICAgMS44ODI0OTRdICAgU0VUID0gMCwgRm5WID0gMA0KWyAgICAxLjg4NTUzOV0g
ICBFQSA9IDAsIFMxUFRXID0gMA0KWyAgICAxLjg4ODY2OF0gICBGU0MgPSAweDBlOiBsZXZlbCAy
IHBlcm1pc3Npb24gZmF1bHQNClsgICAgMS44OTM0NTBdIERhdGEgYWJvcnQgaW5mbzoNClsgICAg
MS44OTYzMTldICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDA0ZSwgSVNTMiA9IDB4MDAwMDAwMDAN
ClsgICAgMS44OTg0MDldIEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogMTE3NzYwSw0KWyAgICAxLjkw
MTc5NF0gICBDTSA9IDAsIFduUiA9IDEsIFRuRCA9IDAsIFRhZ0FjY2VzcyA9IDANClsgICAgMS45
MDE3OTddICAgR0NTID0gMCwgT3ZlcmxheSA9IDAsIERpcnR5Qml0ID0gMCwgWHMgPSAwDQpbICAg
IDEuOTAxNzk5XSBzd2FwcGVyIHBndGFibGU6IDRrIHBhZ2VzLCA0OC1iaXQgVkFzLCBwZ2RwPTAw
MDAwMDAwODFiNTkwMDANClsgICAgMS45MDE4MDJdIFtmZmZmMDAwMDAxMGMwMDAwXSBwZ2Q9MTgw
MDAwMDBmYmZmNzgwMywgcDRkPTE4MDAwMDAwZmJmZjc4MDMsIHB1ZD0xODAwMDAwMGZiZmY2ODAz
LCBwbWQ9MDA2MDAwMDA4MTAwMGY4MQ0KWyAgICAxLjkzMzUyNF0gSW50ZXJuYWwgZXJyb3I6IE9v
cHM6IDAwMDAwMDAwOTYwMDAwNGUgWyMxXSBQUkVFTVBUIFNNUA0KWyAgICAxLjkzOTc4MF0gTW9k
dWxlcyBsaW5rZWQgaW46DQpbICAgIDEuOTQyODI1XSBDUFU6IDIgUElEOiAxIENvbW06IHN3YXBw
ZXIvMCBUYWludGVkOiBHIFMgICAgICAgICAgICAgICAgIDYuNS4yICMyDQpbICAgIDEuOTUwMTI0
XSBIYXJkd2FyZSBuYW1lOiBFMjAwMFEgREVNTyBERFI0IChEVCkNClsgICAgMS45NTQ3MzBdIHBz
dGF0ZTogNDAwMDAwMDUgKG5aY3YgZGFpZiAtUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTIEJUWVBF
PS0tKQ0KWyAgICAxLjk2MTY4MV0gcGMgOiBfX21lbXNldCsweDE2Yy8weDE4OA0KWyAgICAxLjk2
NTMzOV0gbHIgOiBkbWFfZGlyZWN0X2FsbG9jKzB4ZmMvMHgzNDQNClsgICAgMS45Njk2MDJdIHNw
IDogZmZmZjgwMDA4MDA0Yjg3MA0KWyAgICAxLjk3MjkwNV0geDI5OiBmZmZmODAwMDgwMDRiODcw
IHgyODogZmZmZjAwMDAwMzhiYTQ4MCB4Mjc6IGZmZmY4MDAwODE1MjBhOTANClsgICAgMS45ODAw
MzNdIHgyNjogZmZmZjAwMDAwMmYxOTAxMCB4MjU6IGZmZmY4MDAwODAxOTVkNzQgeDI0OiBmZmZm
ZmMwMDAwMDQzMDAwDQpbICAgIDEuOTg3MTYwXSB4MjM6IGZmZmYwMDAwMDJmMTkwMTAgeDIyOiBm
ZmZmMDAwMDAxMGMwMDAwIHgyMTogMDAwMDAwMDAwMDAxNzAwMA0KWyAgICAxLjk5NDI4N10geDIw
OiBmZmZmODAwMDgwMDRiOWUwIHgxOTogZmZmZjgwMDA4MWFkMjAwMCB4MTg6IGZmZmZmYzAwMDAw
NDQwMDgNClsgICAgMi4wMDE0MTNdIHgxNzogMDAwMDAwMDAwMDAwMDA0MCB4MTY6IDAwMDAwMDAw
MDAwMDAwMDEgeDE1OiBmZmZmZmMwMDAwMDAwMDAwDQpbICAgIDIuMDA4NTQwXSB4MTQ6IDAwMDAw
MDAwZjAwMDAwODAgeDEzOiAwMDAwMDAwMGYwMDAwMDAwIHgxMjogZmZmZjgwMDA4MWFkMzAwMA0K
WyAgICAyLjAxNTY2N10geDExOiAwMDAwMDAwMDAwMDAwMTI5IHgxMDogMDAwMDAwMDAwMDAwMDAw
OCB4OSA6IDAwMDAwMDAwMDAwMDAwMDANClsgICAgMi4wMjI3OTRdIHg4IDogZmZmZjAwMDAwMTBj
MDAwMCB4NyA6IDAwMDAwMDAwMDAwMDAwMDAgeDYgOiAwMDAwMDAwMDAwMDAwMDNmDQpbICAgIDIu
MDI5OTIxXSB4NSA6IDAwMDAwMDAwMDAwMDAwNDAgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDog
MDAwMDAwMDAwMDAwMDAwNA0KWyAgICAyLjAzNzA0N10geDIgOiAwMDAwMDAwMDAwMDE2ZmMwIHgx
IDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IGZmZmYwMDAwMDEwYzAwMDANClsgICAgMi4wNDQxNzRd
IENhbGwgdHJhY2U6DQpbICAgIDIuMDQ2NjEwXSAgX19tZW1zZXQrMHgxNmMvMHgxODgNClsgICAg
Mi4wNDk5MTVdICBkbWFfYWxsb2NfYXR0cnMrMHg4OC8weDEwNA0KWyAgICAyLjA1Mzc0MV0gIGRt
YW1fYWxsb2NfYXR0cnMrMHg3MC8weGM4DQpbICAgIDIuMDU3NTY4XSAgYWhjaV9wb3J0X3N0YXJ0
KzB4YTQvMHgyMzgNClsgICAgMi4wNjEzOTZdICBhdGFfaG9zdF9zdGFydC5wYXJ0LjM2KzB4MTAw
LzB4MjFjDQpbICAgIDIuMDY1OTE4XSAgYXRhX2hvc3RfYWN0aXZhdGUrMHg2Yy8weDE0OA0KWyAg
ICAyLjA2OTkxN10gIGFoY2lfaG9zdF9hY3RpdmF0ZSsweDE4Yy8weDFmMA0KWyAgICAyLjA3NDA5
MF0gIGFoY2lfcGxhdGZvcm1faW5pdF9ob3N0KzB4MmIwLzB4MmYwDQpbICAgIDIuMDc4Njk3XSAg
YWhjaV9wcm9iZSsweGI4LzB4ZTANClsgICAgMi4wODIwMDNdICBwbGF0Zm9ybV9wcm9iZSsweDY4
LzB4ZDgNClsgICAgMi4wODU2NTZdICByZWFsbHlfcHJvYmUrMHgxNTAvMHgyYTQNClsgICAgMi4w
ODkzMDhdICBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg3Yy8weDEzMA0KWyAgICAyLjA5MzY1M10g
IGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgzOC8weDExNA0KWyAgICAyLjA5NzgyNV0gIF9fZHJpdmVy
X2F0dGFjaCsweGFjLzB4MTM0DQpbICAgIDIuMTAxNjQ5XSAgYnVzX2Zvcl9lYWNoX2RldisweDdj
LzB4ZGMNClsgICAgMi4xMDU0NzddICBkcml2ZXJfYXR0YWNoKzB4MjQvMHgzMA0KWyAgICAyLjEw
OTA0Ml0gIGJ1c19hZGRfZHJpdmVyKzB4ZjAvMHgyMGMNClsgICAgMi4xMTI3ODJdICBkcml2ZXJf
cmVnaXN0ZXIrMHg2MC8weDEyOA0KWyAgICAyLjExNjYwN10gIF9fcGxhdGZvcm1fZHJpdmVyX3Jl
Z2lzdGVyKzB4MjgvMHgzNA0KWyAgICAyLjEyMTMwMV0gIGFoY2lfZHJpdmVyX2luaXQrMHgxYy8w
eDI4DQpbICAgIDIuMTI1MTI4XSAgZG9fb25lX2luaXRjYWxsKzB4NjAvMHgxZDQNClsgICAgMi4x
Mjg5NTVdICBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDFkOC8weDJhMA0KWyAgICAyLjEzMzMwNF0g
IGtlcm5lbF9pbml0KzB4MjQvMHgxMzANClsgICAgMi4xMzY3ODNdICByZXRfZnJvbV9mb3JrKzB4
MTAvMHgyMA0KWyAgICAyLjE0MDM1MF0gQ29kZTogOTEwMTAxMDggNTRmZmZmNGEgOGIwNDAxMDgg
Y2IwNTAwNDIgKGQ1MGI3NDI4KQ0KWyAgICAyLjE0NjQzM10gLS0tWyBlbmQgdHJhY2UgMDAwMDAw
MDAwMDAwMDAwMCBdLS0tDQpbICAgIDIuMTUxMDYxXSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2lu
ZzogQXR0ZW1wdGVkIHRvIGtpbGwgaW5pdCEgZXhpdGNvZGU9MHgwMDAwMDAwYg0KWyAgICAyLjE1
ODcwNl0gU01QOiBzdG9wcGluZyBzZWNvbmRhcnkgQ1BVcw0KWyAgICAyLjE2MjYyMF0gS2VybmVs
IE9mZnNldDogMHg4MDAwMCBmcm9tIDB4ZmZmZjgwMDA4MDAwMDAwMA0KWyAgICAyLjE2ODA5NF0g
UEhZU19PRkZTRVQ6IDB4ODAwMDAwMDANClsgICAgMi4xNzE1NzBdIENQVSBmZWF0dXJlczogMHgw
MDAwMDAwMCw4MDAxMDAwMCwwODAwNDIxYg0KWyAgICAyLjE3NjY5N10gTWVtb3J5IExpbWl0OiBu
b25lDQpbICAgIDIuMTc5NzQxXSAtLS1bIGVuZCBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzog
QXR0ZW1wdGVkIHRvIGtpbGwgaW5pdCEgZXhpdGNvZGU9MHgwMDAwMDAwYiBdLS0tDQo=
--0000000000000e0fdc06050d0edd--
