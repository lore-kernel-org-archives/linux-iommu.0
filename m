Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68B621
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205849; cv=none; b=cDpqZCggREV+J0wLCl9pKjCVQA2Ezr3wR6l+Ym6HE/rz1G3Unqav0c2V9LS1PirT+A4SO+1vfLCSnaEh6+RsYzMou49JnNzbiu0vpcl9QHY3CSuf64g34aqoRbvf/6gz81Jw+lWxq6F/72e37fIArRsWQWWCge7T15G/Ihk4Ujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205849; c=relaxed/simple;
	bh=kHO9+y+7OXx7Ghu75JEWBRe7qLEnGO57+FKtHZ4Uzs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOwvgfZGY42wmQdKuDxDfvZ56DAhmJBA2LKzDvGFtKNOupiGVH0bwK4DFE6WQwrnIauaXizUZ24NHNBUSJVJ979k1xWV43EbgZyvMdvb/GU2/m+1dxwd+Hx7e0X8rxsYlFILTYyltBZTeuTxo0xxOLevC5aHZBQROzuqpG3UZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e59a9496f9so59423807b3.0
        for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 05:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730205844; x=1730810644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b2eTSuBpsKs+zsM04Td+yKMnYBh99CZfDnOEK6kD/w=;
        b=NrQ5izafZQZPLruvPSTC0ChemJvE9LY3NvdEFjMblId98PGjtyGxjhJxeCsqUbt2x/
         IQqGtGY7dHLyMtDB7WgOEAJrlr1kR+apYux7Ki1OaJHNm2tj2wZCycdnvNueFptcsdeZ
         uiForrOxT/A3DGwoHlVcrfv53XOTRX0jFkIICI5uZLGBl5qZH/ycF7pJnCS4/pjdE4+N
         I0ECsifcCfGba5n5Lo4Cho/vTV3GhtLtFj8K2M34wghU55pcNBbcQgxpKwZ+zAe1VVEa
         PqreiHqIzXIDZ2eCvm/YkDFVtIPjyLbA0wZ/YuDcFwuwWHNU1JRkxZ+oXEUHmYlJdMEJ
         cPHw==
X-Forwarded-Encrypted: i=1; AJvYcCUbRxRgaqkbxx6x1nTSMdtcrLGRJub09Z71rgxZO08CIR2Lnk5oW5fQ62ulYOlSqB6F4c65PQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/+SKR9HGlhhOaWfCLUQT9dPv6bMkc/XT8L2AAcfsOPOoGrCKf
	iZOXhtj+pp951Brg5dvQqVl4oeaw1BgS3pXE8yllJHm0v2ZNkivEtIeCxoik
X-Google-Smtp-Source: AGHT+IG9aatwBwWe70qz2W7LNRjZY6gmywM006v520WPu2Ss1c9wB9UywBY3ZmLDvCz2AUMDJXkbag==
X-Received: by 2002:a05:690c:ecd:b0:6e5:d35b:ca80 with SMTP id 00721157ae682-6e9d88fd872mr102663377b3.5.1730205843524;
        Tue, 29 Oct 2024 05:44:03 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c968acsm19041857b3.106.2024.10.29.05.44.03
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:44:03 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e59a9496f9so59423297b3.0
        for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 05:44:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj6nDKsCA+4oBWx+RlCeEN/uMj5FG6T1N3FoX2Zv5qsAg4SNVI8mAC+3LyN1E+imDcpO+90w==@lists.linux.dev
X-Received: by 2002:a05:690c:94:b0:6e2:f61e:c53 with SMTP id
 00721157ae682-6e9d8ab3cd6mr94479907b3.29.1730205842645; Tue, 29 Oct 2024
 05:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241008220624.551309-1-quic_obabatun@quicinc.com>
 <20241008220624.551309-2-quic_obabatun@quicinc.com> <CAMuHMdUXj4QiSKdhf61xdDeu94=Hv0BXuCxykDpQwdY81_h2vw@mail.gmail.com>
In-Reply-To: <CAMuHMdUXj4QiSKdhf61xdDeu94=Hv0BXuCxykDpQwdY81_h2vw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Oct 2024 13:43:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-mcC3ZJ1sb22K2bVnRxr8Df=ku0WRppZx0uxjGB6NBA@mail.gmail.com>
Message-ID: <CAMuHMdX-mcC3ZJ1sb22K2bVnRxr8Df=ku0WRppZx0uxjGB6NBA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: robh@kernel.org, aisheng.dong@nxp.com, andy@black.fi.intel.com, 
	catalin.marinas@arm.com, devicetree@vger.kernel.org, hch@lst.de, 
	iommu@lists.linux.dev, kernel@quicinc.com, klarasmodin@gmail.com, 
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, 
	quic_ninanaik@quicinc.com, robin.murphy@arm.com, saravanak@google.com, 
	will@kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC linux-renesas-soc

On Tue, Oct 29, 2024 at 1:41=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, Oct 9, 2024 at 12:08=E2=80=AFAM Oreoluwa Babatunde
> <quic_obabatun@quicinc.com> wrote:
> > Reserved memory regions defined in the devicetree can be broken up into
> > two groups:
> > i) Statically-placed reserved memory regions
> > i.e. regions defined with a static start address and size using the
> >      "reg" property.
> > ii) Dynamically-placed reserved memory regions.
> > i.e. regions defined by specifying an address range where they can be
> >      placed in memory using the "alloc_ranges" and "size" properties.
> >
> > These regions are processed and set aside at boot time.
> > This is done in two stages as seen below:
> >
> > Stage 1:
> > At this stage, fdt_scan_reserved_mem() scans through the child nodes of
> > the reserved_memory node using the flattened devicetree and does the
> > following:
> >
> > 1) If the node represents a statically-placed reserved memory region,
> >    i.e. if it is defined using the "reg" property:
> >    - Call memblock_reserve() or memblock_mark_nomap() as needed.
> >    - Add the information for that region into the reserved_mem array
> >      using fdt_reserved_mem_save_node().
> >      i.e. fdt_reserved_mem_save_node(node, name, base, size).
> >
> > 2) If the node represents a dynamically-placed reserved memory region,
> >    i.e. if it is defined using "alloc-ranges" and "size" properties:
> >    - Add the information for that region to the reserved_mem array with
> >      the starting address and size set to 0.
> >      i.e. fdt_reserved_mem_save_node(node, name, 0, 0).
> >    Note: This region is saved to the array with a starting address of 0
> >    because a starting address is not yet allocated for it.
> >
> > Stage 2:
> > After iterating through all the reserved memory nodes and storing their
> > relevant information in the reserved_mem array,fdt_init_reserved_mem() =
is
> > called and does the following:
> >
> > 1) For statically-placed reserved memory regions:
> >    - Call the region specific init function using
> >      __reserved_mem_init_node().
> > 2) For dynamically-placed reserved memory regions:
> >    - Call __reserved_mem_alloc_size() which is used to allocate memory
> >      for each of these regions, and mark them as nomap if they have the
> >      nomap property specified in the DT.
> >    - Call the region specific init function.
> >
> > The current size of the resvered_mem array is 64 as is defined by
> > MAX_RESERVED_REGIONS. This means that there is a limitation of 64 for
> > how many reserved memory regions can be specified on a system.
> > As systems continue to grow more and more complex, the number of
> > reserved memory regions needed are also growing and are starting to hit
> > this 64 count limit, hence the need to make the reserved_mem array
> > dynamically sized (i.e. dynamically allocating memory for the
> > reserved_mem array using membock_alloc_*).
> >
> > On architectures such as arm64, memory allocated using memblock is
> > writable only after the page tables have been setup. This means that if
> > the reserved_mem array is going to be dynamically allocated, it needs t=
o
> > happen after the page tables have been setup, not before.
> >
> > Since the reserved memory regions are currently being processed and
> > added to the array before the page tables are setup, there is a need to
> > change the order in which some of the processing is done to allow for
> > the reserved_mem array to be dynamically sized.
> >
> > It is possible to process the statically-placed reserved memory regions
> > without needing to store them in the reserved_mem array until after the
> > page tables have been setup because all the information stored in the
> > array is readily available in the devicetree and can be referenced at
> > any time.
> > Dynamically-placed reserved memory regions on the other hand get
> > assigned a start address only at runtime, and hence need a place to be
> > stored once they are allocated since there is no other referrence to th=
e
> > start address for these regions.
> >
> > Hence this patch changes the processing order of the reserved memory
> > regions in the following ways:
> >
> > Step 1:
> > fdt_scan_reserved_mem() scans through the child nodes of
> > the reserved_memory node using the flattened devicetree and does the
> > following:
> >
> > 1) If the node represents a statically-placed reserved memory region,
> >    i.e. if it is defined using the "reg" property:
> >    - Call memblock_reserve() or memblock_mark_nomap() as needed.
> >
> > 2) If the node represents a dynamically-placed reserved memory region,
> >    i.e. if it is defined using "alloc-ranges" and "size" properties:
> >    - Call __reserved_mem_alloc_size() which will:
> >      i) Allocate memory for the reserved region and call
> >      memblock_mark_nomap() as needed.
> >      ii) Call the region specific initialization function using
> >      fdt_init_reserved_mem_node().
> >      iii) Save the region information in the reserved_mem array using
> >      fdt_reserved_mem_save_node().
> >
> > Step 2:
> > 1) This stage of the reserved memory processing is now only used to add
> >    the statically-placed reserved memory regions into the reserved_mem
> >    array using fdt_scan_reserved_mem_reg_nodes(), as well as call their
> >    region specific initialization functions.
> >
> > 2) This step has also been moved to be after the page tables are
> >    setup. Moving this will allow us to replace the reserved_mem
> >    array with a dynamically sized array before storing the rest of
> >    these regions.
> >
> > Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>
> Thanks for your patch, which is now commit 8a6e02d0c00e7b62
> ("of: reserved_mem: Restructure how the reserved memory regions
> are processed") in dt-rh/for-next.
>
> I have bisected a boot issue on RZ/Five to this commit.
> With "earlycon keep_bootcon" (else there is no output):
>
>     Oops - store (or AMO) access fault [#1]
>     CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted
> 6.12.0-rc1-00015-g8a6e02d0c00e #201
>     Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
>     epc : __memset+0x60/0x100
>      ra : __dma_alloc_from_coherent+0x150/0x17a
>     epc : ffffffff8062d2bc ra : ffffffff80053a94 sp : ffffffc60000ba20
>      gp : ffffffff812e9938 tp : ffffffd601920000 t0 : ffffffc6000d0000
>      t1 : 0000000000000000 t2 : ffffffffe9600000 s0 : ffffffc60000baa0
>      s1 : ffffffc6000d0000 a0 : ffffffc6000d0000 a1 : 0000000000000000
>      a2 : 0000000000001000 a3 : ffffffc6000d1000 a4 : 0000000000000000
>      a5 : 0000000000000000 a6 : ffffffd601adacc0 a7 : ffffffd601a841a8
>      s2 : ffffffd6018573c0 s3 : 0000000000001000 s4 : ffffffd6019541e0
>      s5 : 0000000200000022 s6 : ffffffd6018f8410 s7 : ffffffd6018573e8
>      s8 : 0000000000000001 s9 : 0000000000000001 s10: 0000000000000010
>      s11: 0000000000000000 t3 : 0000000000000000 t4 : ffffffffdefe62d1
>      t5 : 000000001cd6a3a9 t6 : ffffffd601b2aad6
>     status: 0000000200000120 badaddr: ffffffc6000d0000 cause: 00000000000=
00007
>     [<ffffffff8062d2bc>] __memset+0x60/0x100
>     [<ffffffff80053e1a>] dma_alloc_from_global_coherent+0x1c/0x28
>     [<ffffffff80053056>] dma_direct_alloc+0x98/0x112
>     [<ffffffff8005238c>] dma_alloc_attrs+0x78/0x86
>     [<ffffffff8035fdb4>] rz_dmac_probe+0x3f6/0x50a
>     [<ffffffff803a0694>] platform_probe+0x4c/0x8a
>     [<ffffffff8039ea16>] really_probe+0xe4/0x1c8
>     [<ffffffff8039ebc4>] __driver_probe_device+0xca/0xce
>     [<ffffffff8039ec48>] driver_probe_device+0x34/0x92
>     [<ffffffff8039ede8>] __driver_attach+0xb4/0xbe
>     [<ffffffff8039ce58>] bus_for_each_dev+0x60/0xa0
>     [<ffffffff8039e26a>] driver_attach+0x1a/0x22
>     [<ffffffff8039dc20>] bus_add_driver+0xa4/0x184
>     [<ffffffff8039f65c>] driver_register+0x8a/0xb4
>     [<ffffffff803a051c>] __platform_driver_register+0x1c/0x24
>     [<ffffffff808202f6>] rz_dmac_driver_init+0x1a/0x22
>     [<ffffffff80800ef6>] do_one_initcall+0x64/0x134
>     [<ffffffff8080122e>] kernel_init_freeable+0x200/0x202
>     [<ffffffff80638126>] kernel_init+0x1e/0x10a
>     [<ffffffff8063d58e>] ret_from_fork+0xe/0x18
>     Code: 1007 82b3 40e2 0797 0000 8793 00e7 8305 97ba 8782 (b023) 00b2
>     ---[ end trace 0000000000000000 ]---
>     Kernel panic - not syncing: Fatal exception in interrupt
>     ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]--=
-
>
> Nothing really stands out in the kernel log, except for a delayed
> initialization of the reserved mem nodes (they are the same
> before/after):
>
>  printk: debug: ignoring loglevel setting.
> -OF: reserved mem: 0x0000000000030000..0x000000000003ffff (64 KiB)
> nomap non-reusable mmode_resv0@30000
> -OF: reserved mem: 0x0000000000040000..0x000000000004ffff (64 KiB)
> nomap non-reusable mmode_resv1@40000
> -OF: reserved mem: 0x0000000044000000..0x000000004403ffff (256 KiB)
> nomap non-reusable mmode_resv3@44000000
> -OF: reserved mem: 0x0000000044040000..0x000000004405ffff (128 KiB)
> nomap non-reusable mmode_resv2@44040000
> +earlycon: scif0 at MMIO 0x000000001004b800 (options '115200n8')
> +printk: legacy bootconsole [scif0] enabled
> +printk: debug: skip boot console de-registration.
>  Reserved memory: created DMA memory pool at 0x0000000058000000, size 128=
 MiB
>  OF: reserved mem: initialized node pma_resv0@58000000, compatible id
> shared-dma-pool
>  OF: reserved mem: 0x0000000058000000..0x000000005fffffff (131072 KiB)
> nomap non-reusable pma_resv0@58000000
> +OF: reserved mem: 0x0000000000030000..0x000000000003ffff (64 KiB)
> nomap non-reusable mmode_resv0@30000
> +OF: reserved mem: 0x0000000000040000..0x000000000004ffff (64 KiB)
> nomap non-reusable mmode_resv1@40000
> +OF: reserved mem: 0x0000000044040000..0x000000004405ffff (128 KiB)
> nomap non-reusable mmode_resv2@44040000
> +OF: reserved mem: 0x0000000044000000..0x000000004403ffff (256 KiB)
> nomap non-reusable mmode_resv3@44000000
>  Zone ranges:
>    DMA32    [mem 0x0000000048000000-0x000000007fffffff]
>    Normal   empty
>
> Reverting commits 00c9a452a235c61f ("of: reserved_mem: Add code to
> dynamically allocate reserved_mem array") and 8a6e02d0c00e7b62 fixes
> the issue.
>
> root@smarc-rzfive:/sys/firmware/devicetree/base/reserved-memory# ls -l
> total 0
> -r--r--r-- 1 root root  4 Oct 29 12:37 #address-cells
> -r--r--r-- 1 root root  4 Oct 29 12:37 #size-cells
> drwxr-xr-x 2 root root  0 Oct 29 12:37 mmode_resv0@30000
> drwxr-xr-x 2 root root  0 Oct 29 12:37 mmode_resv1@40000
> drwxr-xr-x 2 root root  0 Oct 29 12:37 mmode_resv2@44040000
> drwxr-xr-x 2 root root  0 Oct 29 12:37 mmode_resv3@44000000
> -r--r--r-- 1 root root 16 Oct 29 12:37 name
> drwxr-xr-x 2 root root  0 Oct 29 12:37 pma_resv0@58000000
> -r--r--r-- 1 root root  0 Oct 29 12:37 ranges
>
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 4d528c10df3a..d0dbc8183ac4 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -511,8 +511,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
> >                         break;
> >                 memblock_reserve(base, size);
> >         }
> > -
> > -       fdt_init_reserved_mem();
> >  }
> >
> >  /**
> > @@ -1212,6 +1210,9 @@ void __init unflatten_device_tree(void)
> >  {
> >         void *fdt =3D initial_boot_params;
> >
> > +       /* Save the statically-placed regions in the reserved_mem array=
 */
> > +       fdt_scan_reserved_mem_reg_nodes();
> > +
> >         /* Don't use the bootloader provided DTB if ACPI is enabled */
> >         if (!acpi_disabled)
> >                 fdt =3D NULL;
> > diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> > index 04aa2a91f851..29525c0b9939 100644
> > --- a/drivers/of/of_private.h
> > +++ b/drivers/of/of_private.h
> > @@ -9,6 +9,7 @@
> >   */
> >
> >  #define FDT_ALIGN_SIZE 8
> > +#define MAX_RESERVED_REGIONS    64
> >
> >  /**
> >   * struct alias_prop - Alias property in 'aliases' node
> > @@ -180,7 +181,7 @@ static inline struct device_node *__of_get_dma_pare=
nt(const struct device_node *
> >  #endif
> >
> >  int fdt_scan_reserved_mem(void);
> > -void fdt_init_reserved_mem(void);
> > +void __init fdt_scan_reserved_mem_reg_nodes(void);
> >
> >  bool of_fdt_device_is_available(const void *blob, unsigned long node);
> >
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.=
c
> > index 46e1c3fbc769..2011174211f9 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -27,7 +27,6 @@
> >
> >  #include "of_private.h"
> >
> > -#define MAX_RESERVED_REGIONS   64
> >  static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
> >  static int reserved_mem_count;
> >
> > @@ -56,6 +55,7 @@ static int __init early_init_dt_alloc_reserved_memory=
_arch(phys_addr_t size,
> >         return err;
> >  }
> >
> > +static void __init fdt_init_reserved_mem_node(struct reserved_mem *rme=
m);
> >  /*
> >   * fdt_reserved_mem_save_node() - save fdt node for second pass initia=
lization
> >   */
> > @@ -74,6 +74,9 @@ static void __init fdt_reserved_mem_save_node(unsigne=
d long node, const char *un
> >         rmem->base =3D base;
> >         rmem->size =3D size;
> >
> > +       /* Call the region specific initialization function */
> > +       fdt_init_reserved_mem_node(rmem);
> > +
> >         reserved_mem_count++;
> >         return;
> >  }
> > @@ -106,7 +109,6 @@ static int __init __reserved_mem_reserve_reg(unsign=
ed long node,
> >         phys_addr_t base, size;
> >         int len;
> >         const __be32 *prop;
> > -       int first =3D 1;
> >         bool nomap;
> >
> >         prop =3D of_get_flat_dt_prop(node, "reg", &len);
> > @@ -134,10 +136,6 @@ static int __init __reserved_mem_reserve_reg(unsig=
ned long node,
> >                                uname, &base, (unsigned long)(size / SZ_=
1M));
> >
> >                 len -=3D t_len;
> > -               if (first) {
> > -                       fdt_reserved_mem_save_node(node, uname, base, s=
ize);
> > -                       first =3D 0;
> > -               }
> >         }
> >         return 0;
> >  }
> > @@ -165,12 +163,77 @@ static int __init __reserved_mem_check_root(unsig=
ned long node)
> >         return 0;
> >  }
> >
> > +static void __init __rmem_check_for_overlap(void);
> > +
> > +/**
> > + * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" define=
d
> > + * reserved memory regions.
> > + *
> > + * This function is used to scan through the DT and store the
> > + * information for the reserved memory regions that are defined using
> > + * the "reg" property. The region node number, name, base address, and
> > + * size are all stored in the reserved_mem array by calling the
> > + * fdt_reserved_mem_save_node() function.
> > + */
> > +void __init fdt_scan_reserved_mem_reg_nodes(void)
> > +{
> > +       int t_len =3D (dt_root_addr_cells + dt_root_size_cells) * sizeo=
f(__be32);
> > +       const void *fdt =3D initial_boot_params;
> > +       phys_addr_t base, size;
> > +       const __be32 *prop;
> > +       int node, child;
> > +       int len;
> > +
> > +       if (!fdt)
> > +               return;
> > +
> > +       node =3D fdt_path_offset(fdt, "/reserved-memory");
> > +       if (node < 0) {
> > +               pr_info("Reserved memory: No reserved-memory node in th=
e DT\n");
> > +               return;
> > +       }
> > +
> > +       if (__reserved_mem_check_root(node)) {
> > +               pr_err("Reserved memory: unsupported node format, ignor=
ing\n");
> > +               return;
> > +       }
> > +
> > +       fdt_for_each_subnode(child, fdt, node) {
> > +               const char *uname;
> > +
> > +               prop =3D of_get_flat_dt_prop(child, "reg", &len);
> > +               if (!prop)
> > +                       continue;
> > +               if (!of_fdt_device_is_available(fdt, child))
> > +                       continue;
> > +
> > +               uname =3D fdt_get_name(fdt, child, NULL);
> > +               if (len && len % t_len !=3D 0) {
> > +                       pr_err("Reserved memory: invalid reg property i=
n '%s', skipping node.\n",
> > +                              uname);
> > +                       continue;
> > +               }
> > +               base =3D dt_mem_next_cell(dt_root_addr_cells, &prop);
> > +               size =3D dt_mem_next_cell(dt_root_size_cells, &prop);
> > +
> > +               if (size)
> > +                       fdt_reserved_mem_save_node(child, uname, base, =
size);
> > +       }
> > +
> > +       /* check for overlapping reserved regions */
> > +       __rmem_check_for_overlap();
> > +}
> > +
> > +static int __init __reserved_mem_alloc_size(unsigned long node, const =
char *uname);
> > +
> >  /*
> >   * fdt_scan_reserved_mem() - scan a single FDT node for reserved memor=
y
> >   */
> >  int __init fdt_scan_reserved_mem(void)
> >  {
> >         int node, child;
> > +       int dynamic_nodes_cnt =3D 0;
> > +       int dynamic_nodes[MAX_RESERVED_REGIONS];
> >         const void *fdt =3D initial_boot_params;
> >
> >         node =3D fdt_path_offset(fdt, "/reserved-memory");
> > @@ -192,8 +255,24 @@ int __init fdt_scan_reserved_mem(void)
> >                 uname =3D fdt_get_name(fdt, child, NULL);
> >
> >                 err =3D __reserved_mem_reserve_reg(child, uname);
> > -               if (err =3D=3D -ENOENT && of_get_flat_dt_prop(child, "s=
ize", NULL))
> > -                       fdt_reserved_mem_save_node(child, uname, 0, 0);
> > +               /*
> > +                * Save the nodes for the dynamically-placed regions
> > +                * into an array which will be used for allocation righ=
t
> > +                * after all the statically-placed regions are reserved
> > +                * or marked as no-map. This is done to avoid dynamical=
ly
> > +                * allocating from one of the statically-placed regions=
.
> > +                */
> > +               if (err =3D=3D -ENOENT && of_get_flat_dt_prop(child, "s=
ize", NULL)) {
> > +                       dynamic_nodes[dynamic_nodes_cnt] =3D child;
> > +                       dynamic_nodes_cnt++;
> > +               }
> > +       }
> > +       for (int i =3D 0; i < dynamic_nodes_cnt; i++) {
> > +               const char *uname;
> > +
> > +               child =3D dynamic_nodes[i];
> > +               uname =3D fdt_get_name(fdt, child, NULL);
> > +               __reserved_mem_alloc_size(child, uname);
> >         }
> >         return 0;
> >  }
> > @@ -253,8 +332,7 @@ static int __init __reserved_mem_alloc_in_range(phy=
s_addr_t size,
> >   * __reserved_mem_alloc_size() - allocate reserved memory described by
> >   *     'size', 'alignment'  and 'alloc-ranges' properties.
> >   */
> > -static int __init __reserved_mem_alloc_size(unsigned long node,
> > -       const char *uname, phys_addr_t *res_base, phys_addr_t *res_size=
)
> > +static int __init __reserved_mem_alloc_size(unsigned long node, const =
char *uname)
> >  {
> >         int t_len =3D (dt_root_addr_cells + dt_root_size_cells) * sizeo=
f(__be32);
> >         phys_addr_t start =3D 0, end =3D 0;
> > @@ -334,9 +412,8 @@ static int __init __reserved_mem_alloc_size(unsigne=
d long node,
> >                 return -ENOMEM;
> >         }
> >
> > -       *res_base =3D base;
> > -       *res_size =3D size;
> > -
> > +       /* Save region in the reserved_mem array */
> > +       fdt_reserved_mem_save_node(node, uname, base, size);
> >         return 0;
> >  }
> >
> > @@ -425,48 +502,37 @@ static void __init __rmem_check_for_overlap(void)
> >  }
> >
> >  /**
> > - * fdt_init_reserved_mem() - allocate and init all saved reserved memo=
ry regions
> > + * fdt_init_reserved_mem_node() - Initialize a reserved memory region
> > + * @rmem: reserved_mem struct of the memory region to be initialized.
> > + *
> > + * This function is used to call the region specific initialization
> > + * function for a reserved memory region.
> >   */
> > -void __init fdt_init_reserved_mem(void)
> > +static void __init fdt_init_reserved_mem_node(struct reserved_mem *rme=
m)
> >  {
> > -       int i;
> > -
> > -       /* check for overlapping reserved regions */
> > -       __rmem_check_for_overlap();
> > -
> > -       for (i =3D 0; i < reserved_mem_count; i++) {
> > -               struct reserved_mem *rmem =3D &reserved_mem[i];
> > -               unsigned long node =3D rmem->fdt_node;
> > -               int err =3D 0;
> > -               bool nomap;
> > +       unsigned long node =3D rmem->fdt_node;
> > +       int err =3D 0;
> > +       bool nomap;
> >
> > -               nomap =3D of_get_flat_dt_prop(node, "no-map", NULL) !=
=3D NULL;
> > +       nomap =3D of_get_flat_dt_prop(node, "no-map", NULL) !=3D NULL;
> >
> > -               if (rmem->size =3D=3D 0)
> > -                       err =3D __reserved_mem_alloc_size(node, rmem->n=
ame,
> > -                                                &rmem->base, &rmem->si=
ze);
> > -               if (err =3D=3D 0) {
> > -                       err =3D __reserved_mem_init_node(rmem);
> > -                       if (err !=3D 0 && err !=3D -ENOENT) {
> > -                               pr_info("node %s compatible matching fa=
il\n",
> > -                                       rmem->name);
> > -                               if (nomap)
> > -                                       memblock_clear_nomap(rmem->base=
, rmem->size);
> > -                               else
> > -                                       memblock_phys_free(rmem->base,
> > -                                                          rmem->size);
> > -                       } else {
> > -                               phys_addr_t end =3D rmem->base + rmem->=
size - 1;
> > -                               bool reusable =3D
> > -                                       (of_get_flat_dt_prop(node, "reu=
sable", NULL)) !=3D NULL;
> > -
> > -                               pr_info("%pa..%pa (%lu KiB) %s %s %s\n"=
,
> > -                                       &rmem->base, &end, (unsigned lo=
ng)(rmem->size / SZ_1K),
> > -                                       nomap ? "nomap" : "map",
> > -                                       reusable ? "reusable" : "non-re=
usable",
> > -                                       rmem->name ? rmem->name : "unkn=
own");
> > -                       }
> > -               }
> > +       err =3D __reserved_mem_init_node(rmem);
> > +       if (err !=3D 0 && err !=3D -ENOENT) {
> > +               pr_info("node %s compatible matching fail\n", rmem->nam=
e);
> > +               if (nomap)
> > +                       memblock_clear_nomap(rmem->base, rmem->size);
> > +               else
> > +                       memblock_phys_free(rmem->base, rmem->size);
> > +       } else {
> > +               phys_addr_t end =3D rmem->base + rmem->size - 1;
> > +               bool reusable =3D
> > +                       (of_get_flat_dt_prop(node, "reusable", NULL)) !=
=3D NULL;
> > +
> > +               pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
> > +                       &rmem->base, &end, (unsigned long)(rmem->size /=
 SZ_1K),
> > +                       nomap ? "nomap" : "map",
> > +                       reusable ? "reusable" : "non-reusable",
> > +                       rmem->name ? rmem->name : "unknown");
> >         }
> >  }

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
