Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892DD21ABD4
	for <iommu@lists.linux.dev>; Sat, 28 Jun 2025 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751144698; cv=none; b=IZbK5HZhb1AaZYla/GaVfI0ReAHJKdH5F8ln98Y3aB3DRHRBclwXAFx80jl06IzhIlcNe3mpMl9qn38Fe23Uf01XHg4eQgDoEWfMHMzrhebXPIrnAQwedTaoSz65uXi66fFKPHY/SCNDIVmp7zgrB4eG6NeJFLNa8pmKdLSe40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751144698; c=relaxed/simple;
	bh=Oi/Sens/TuaG8WmM0iaglArv7/6ZokXrxaAjghZYg8Q=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ji86r8R4Xnri0jbES0UaGwO4Fvdmch+eOuIr1zoZdq5awTBHtkv891iw7Bns6Ponz4xfjyw8tIBAIk4fn6mva7gQlzOcK0LQ7nFN7VTK2zf2M6EeqUzVx55Cx5/GRM15kTYXoA4Q9sI0ZaFXGyERLcTgchx/J4fzJzdVR82XN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cPB+f0LF; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cPB+f0LF"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e7feaae0e1so639207137.2
        for <iommu@lists.linux.dev>; Sat, 28 Jun 2025 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751144694; x=1751749494; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXsCxEckYxfvcQxDjkjJDTClxJL/fJNZWKljg2hE9ks=;
        b=cPB+f0LFb1Yf0KyqX78jDDVDpnDJX5orXCQfQPMk3DJh7p6GeP4r9ov23YtXXf0i5e
         57dGEEJ9mHW3/mxyjcPBnHVXxdnB4bKqQD5z3bLXpnNYuURHpoDAFDZdh0zwUMO+NX47
         q4/GcoZRFGsF3EXOMBee6i4g20XXMgUfrsYlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751144694; x=1751749494;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXsCxEckYxfvcQxDjkjJDTClxJL/fJNZWKljg2hE9ks=;
        b=cG3htg5Rc3K0MZIaPxDzb3g+WgQHOZEmIP0C3r/7reF/9CMsGw33LetCkUae6vlTwM
         GGnoPFrtTDyQdRkuh/VaorxAEeMARnCKayfVLBnXLR2ZWLBPPTPRZBJAwm+krzqx/pIL
         SpJ/sFHsg1qRGDxWz2Zl9C9a3c0BDVugOMNRR4hACFW8VxmVRfy1C8PBpMR55VjJ3+7l
         n1AlUtvbNCwGGDy2mf7e83X1vsqwjNnUB9uLcLucnoS2edmZV7MS9N5uEgEAe3UTp8LO
         WanEdRqgen8cCjg+YWUpUMM/iX/fjwy9eBTBjKvuDUTpDXxLC5YWQR02zwsG2Dxtx+7V
         OjxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxbdMT6KrAPHTR3mXpvTfUzmRtGzBYCIMffemVE4cPQmenV8rjxWZxY4gZG6wbirQPx7CfmA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyks8zwJyBtCzy+PHiynxc2L+fjPYZeuCqvNBlhDFNQhHRf4k0t
	pCH+EqdPmMcUW1V1DnVprTTh/LnyN1795/qukNo8gfeAmNgTjoYN6NmbDss6ZU8Rg9ndlXD6FKn
	47bagYrIyFRmXLRs+1Fgnx6QBph89st6PYYtyPuyH
X-Gm-Gg: ASbGncuW/bxbpfoNHx/TNMgU9ldGoJOvPTNWc25YTjZ3VBhHKZiF8yBbXdIxDFR2j8w
	WsaHncNOah6CvFn8X53taNcZVHmCES5X3i5h+pt0nMXftgtGq22/TfuPlPpK9sLEq+71d+JnxBd
	SwrHgwlJnYZ15HKSqOr2oxSXXKQSNnUthlJAetUOcDoEA=
X-Google-Smtp-Source: AGHT+IEf8MTC8INCsdzuwX64xKkx87pBwQx1t/+/gX5WGZaLs+vxQcM12D78yarV5SmU1sdNOa3HksJitwJV2f031XM=
X-Received: by 2002:a05:6102:548c:b0:4e5:9b5f:a7a2 with SMTP id
 ada2fe7eead31-4ee4f698992mr5652292137.9.1751144694135; Sat, 28 Jun 2025
 14:04:54 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20241008220624.551309-1-quic_obabatun@quicinc.com>
 <20241008220624.551309-2-quic_obabatun@quicinc.com> <5aa94f41-c689-443b-8665-c6913ff5ba8f@broadcom.com>
 <CAHi4H7G9GpR5O+o+mmdCgSJ5M5ewrsHH24nVJ6s3AGyaycfrhw@mail.gmail.com> <0eede1f8-cbbc-4694-a91f-92002def33b7@quicinc.com>
In-Reply-To: <0eede1f8-cbbc-4694-a91f-92002def33b7@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDmI1rNENpO0NyITBDy/BVFgzIiRAF5Mp5uAexA3vECJGyOVgKU0SVPtcOjZGA=
Date: Sat, 28 Jun 2025 14:04:53 -0700
X-Gm-Features: Ac12FXzxR0sFkGCvcKmuzlL17l7DGmnjpzLvv7EexVIPXslw6hUSUde32gi1efw
Message-ID: <229857ad19690de7d6ec3590c3a37cb6@mail.gmail.com>
Subject: RE: [PATCH v10 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, robh@kernel.org
Cc: aisheng.dong@nxp.com, andy@black.fi.intel.com, catalin.marinas@arm.com, 
	devicetree@vger.kernel.org, hch@lst.de, iommu@lists.linux.dev, 
	kernel@quicinc.com, klarasmodin@gmail.com, linux-kernel@vger.kernel.org, 
	m.szyprowski@samsung.com, quic_ninanaik@quicinc.com, robin.murphy@arm.com, 
	saravanak@google.com, will@kernel.org, oreoluwa.babatunde@oss.qualcomm.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000799cf30638a825db"

--000000000000799cf30638a825db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> Sent: Friday, June 27, 2025 11:02 AM
> To: William Zhang <william.zhang@broadcom.com>; robh@kernel.org
> Cc: aisheng.dong@nxp.com; andy@black.fi.intel.com;
> catalin.marinas@arm.com; devicetree@vger.kernel.org; hch@lst.de;
> iommu@lists.linux.dev; kernel@quicinc.com; klarasmodin@gmail.com; linux-
> kernel@vger.kernel.org; m.szyprowski@samsung.com;
> quic_ninanaik@quicinc.com; robin.murphy@arm.com; saravanak@google.com;
> will@kernel.org; oreoluwa.babatunde@oss.qualcomm.com
> Subject: Re: [PATCH v10 1/2] of: reserved_mem: Restruture how the reserve=
d
> memory regions are processed
>
>
>
> On 6/22/2025 6:24 PM, William Zhang wrote:
> > On Tue, Jun 17, 2025 at 10:15=E2=80=AFAM William Zhang
> > <william.zhang@broadcom.com> wrote:
> >>
> >> Hi Oreoluwa,
> >>
> >> On 10/8/2024 3:06 PM, Oreoluwa Babatunde wrote:
> >>> Reserved memory regions defined in the devicetree can be broken up
> >>> into
> >>> two groups:
> >>> i) Statically-placed reserved memory regions
> >>> i.e. regions defined with a static start address and size using the
> >>>       "reg" property.
> >>> ii) Dynamically-placed reserved memory regions.
> >>> i.e. regions defined by specifying an address range where they can be
> >>>       placed in memory using the "alloc_ranges" and "size" properties=
.
> >>>
> >>> These regions are processed and set aside at boot time.
> >>> This is done in two stages as seen below:
> >>>
> >>> Stage 1:
> >>> At this stage, fdt_scan_reserved_mem() scans through the child nodes
> >>> of
> >>> the reserved_memory node using the flattened devicetree and does the
> >>> following:
> >>>
> >>> 1) If the node represents a statically-placed reserved memory region,
> >>>     i.e. if it is defined using the "reg" property:
> >>>     - Call memblock_reserve() or memblock_mark_nomap() as needed.
> >>>     - Add the information for that region into the reserved_mem array
> >>>       using fdt_reserved_mem_save_node().
> >>>       i.e. fdt_reserved_mem_save_node(node, name, base, size).
> >>>
> >>> 2) If the node represents a dynamically-placed reserved memory region=
,
> >>>     i.e. if it is defined using "alloc-ranges" and "size" properties:
> >>>     - Add the information for that region to the reserved_mem array
> >>> with
> >>>       the starting address and size set to 0.
> >>>       i.e. fdt_reserved_mem_save_node(node, name, 0, 0).
> >>>     Note: This region is saved to the array with a starting address o=
f
> >>> 0
> >>>     because a starting address is not yet allocated for it.
> >>>
> >>> Stage 2:
> >>> After iterating through all the reserved memory nodes and storing
> >>> their
> >>> relevant information in the reserved_mem array,fdt_init_reserved_mem(=
)
> >>> is
> >>> called and does the following:
> >>>
> >>> 1) For statically-placed reserved memory regions:
> >>>     - Call the region specific init function using
> >>>       __reserved_mem_init_node().
> >>> 2) For dynamically-placed reserved memory regions:
> >>>     - Call __reserved_mem_alloc_size() which is used to allocate
> >>> memory
> >>>       for each of these regions, and mark them as nomap if they have
> >>> the
> >>>       nomap property specified in the DT.
> >>>     - Call the region specific init function.
> >>>
> >>> The current size of the resvered_mem array is 64 as is defined by
> >>> MAX_RESERVED_REGIONS. This means that there is a limitation of 64 for
> >>> how many reserved memory regions can be specified on a system.
> >>> As systems continue to grow more and more complex, the number of
> >>> reserved memory regions needed are also growing and are starting to
> >>> hit
> >>> this 64 count limit, hence the need to make the reserved_mem array
> >>> dynamically sized (i.e. dynamically allocating memory for the
> >>> reserved_mem array using membock_alloc_*).
> >>>
> >>> On architectures such as arm64, memory allocated using memblock is
> >>> writable only after the page tables have been setup. This means that
> >>> if
> >>> the reserved_mem array is going to be dynamically allocated, it needs
> >>> to
> >>> happen after the page tables have been setup, not before.
> >>>
> >>> Since the reserved memory regions are currently being processed and
> >>> added to the array before the page tables are setup, there is a need
> >>> to
> >>> change the order in which some of the processing is done to allow for
> >>> the reserved_mem array to be dynamically sized.
> >>>
> >>> It is possible to process the statically-placed reserved memory
> >>> regions
> >>> without needing to store them in the reserved_mem array until after
> >>> the
> >>> page tables have been setup because all the information stored in the
> >>> array is readily available in the devicetree and can be referenced at
> >>> any time.
> >>> Dynamically-placed reserved memory regions on the other hand get
> >>> assigned a start address only at runtime, and hence need a place to b=
e
> >>> stored once they are allocated since there is no other referrence to
> >>> the
> >>> start address for these regions.
> >>>
> >>> Hence this patch changes the processing order of the reserved memory
> >>> regions in the following ways:
> >>>
> >>> Step 1:
> >>> fdt_scan_reserved_mem() scans through the child nodes of
> >>> the reserved_memory node using the flattened devicetree and does the
> >>> following:
> >>>
> >>> 1) If the node represents a statically-placed reserved memory region,
> >>>     i.e. if it is defined using the "reg" property:
> >>>     - Call memblock_reserve() or memblock_mark_nomap() as needed.
> >>>
> >>> 2) If the node represents a dynamically-placed reserved memory region=
,
> >>>     i.e. if it is defined using "alloc-ranges" and "size" properties:
> >>>     - Call __reserved_mem_alloc_size() which will:
> >>>       i) Allocate memory for the reserved region and call
> >>>       memblock_mark_nomap() as needed.
> >>>       ii) Call the region specific initialization function using
> >>>       fdt_init_reserved_mem_node().
> >>>       iii) Save the region information in the reserved_mem array usin=
g
> >>>       fdt_reserved_mem_save_node().
> >>>
> >>> Step 2:
> >>> 1) This stage of the reserved memory processing is now only used to
> >>> add
> >>>     the statically-placed reserved memory regions into the
> >>> reserved_mem
> >>>     array using fdt_scan_reserved_mem_reg_nodes(), as well as call
> >>> their
> >>>     region specific initialization functions.
> >>>
> >>> 2) This step has also been moved to be after the page tables are
> >>>     setup. Moving this will allow us to replace the reserved_mem
> >>>     array with a dynamically sized array before storing the rest of
> >>>     these regions.
> >> I am running into a call trace with this order change on armv7 chip
> >> when
> >> I tried to allocate dma coherent memory from the device reserved
> >> memory.
> >> The issue does not happen on armv8 chips.
> >>
> >> [    0.000000] Reserved memory: created CMA memory pool at 0x1e000000,
> >> size 32 MiB
> >> [    0.000000] OF: reserved mem: initialized node dt_reserved_cma,
> >> compatible id shared-dma-pool
> >> [    0.000000] OF: reserved mem: 0x1e000000..0x1fffffff (32768 KiB) ma=
p
> >> reusable dt_reserved_cma
> >> ....
> >>
> >> [    0.445322] ------------[ cut here ]------------
> >> [    0.445353] WARNING: CPU: 0 PID: 1 at mm/memory.c:3069
> >> __apply_to_page_range+0x380/0x388
> >> [    0.488911] Modules linked in:
> >> [    0.492027] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> >> 6.16.0-rc1-g27605c8c0f69-dirty #3 NONE
> >> [    0.501174] Hardware name: Generic DT based system
> >> [    0.505965] Call trace:
> >> [    0.505985]  unwind_backtrace from show_stack+0x10/0x14
> >> [    0.513764]  show_stack from dump_stack_lvl+0x54/0x68
> >> [    0.518834]  dump_stack_lvl from __warn+0x7c/0x128
> >> [    0.523639]  __warn from warn_slowpath_fmt+0x184/0x18c
> >> [    0.527676] Freeing initrd memory: 65536K
> >> [    0.532788]  warn_slowpath_fmt from
> __apply_to_page_range+0x380/0x388
> >> [    0.539242]  __apply_to_page_range from
> apply_to_page_range+0x1c/0x24
> >> [    0.545689]  apply_to_page_range from
> __alloc_from_contiguous+0xc0/0x14c
> >> [    0.552398]  __alloc_from_contiguous from
> cma_allocator_alloc+0x34/0x3c
> >> [    0.559016]  cma_allocator_alloc from arch_dma_alloc+0x11c/0x2ac
> >> [    0.565025]  arch_dma_alloc from dma_alloc_attrs+0x90/0x2e8
> >> [    0.570603]  dma_alloc_attrs from dmydev_probe+0x8c/0xe8
> >> [    0.575919]  dmydev_probe from platform_probe+0x5c/0xb0
> >> [    0.581152]  platform_probe from really_probe+0xc8/0x2c8
> >> [    0.586467]  really_probe from __driver_probe_device+0x88/0x19c
> >> [    0.592387]  __driver_probe_device from
> >> driver_probe_device+0x30/0x104
> >> [    0.598915]  driver_probe_device from __driver_attach+0x90/0x178
> >> [    0.604921]  __driver_attach from bus_for_each_dev+0x7c/0xcc
> >> [    0.610582]  bus_for_each_dev from bus_add_driver+0xcc/0x1ec
> >> [    0.616241]  bus_add_driver from driver_register+0x7c/0x114
> >> [    0.621814]  driver_register from dmydev_init+0x20/0x28
> >> [    0.627045]  dmydev_init from do_one_initcall+0x58/0x200
> >> [    0.632363]  do_one_initcall from kernel_init_freeable+0x1cc/0x228
> >> [    0.638550]  kernel_init_freeable from kernel_init+0x1c/0x12c
> >> [    0.644299]  kernel_init from ret_from_fork+0x14/0x28
> >> [    0.649351] Exception stack(0xe0819fb0 to 0xe0819ff8)
> >> [    0.654401] 9fa0:                                     00000000
> >> 00000000 00000000 00000000
> >> [    0.662575] 9fc0: 00000000 00000000 00000000 00000000 00000000
> >> 00000000 00000000 00000000
> >> [    0.670747] 9fe0: 00000000 00000000 00000000 00000000 00000013
> 00000000
> >> [    0.677403] ---[ end trace 0000000000000000 ]---
> >> [    0.682083] dmydev dmy_device: Allocate dma memory at 0xde000000 dm=
a
> >> addr 0x1e000000
> >>
> >> The reason is that now reserved memory's fixup function
> >> dma_contiguous_early_fixup is called after the page table is
> >> initialized. This fixup function increases the dma_mmu_remap count for
> >> each reserved memory. And the dma_contiguous_remap function depends
> on
> >> it to properly set up the reserved memory mmu table entry. Before this
> >> change, the paging_init function calls dma_contiguous_remap and it
> >> founds the reserved memory and set it up properly.  After the change,
> >> this function found there is no reserved memory so skip any
> >> initialization hence causes the crash later on when my driver tries to
> >> allocate dma memory from the reserved memory.
> >>
> >> My workaround below is to move the dma_contiguous_remap out from the
> >> paging_init function to the place right after unflatten_device_tree
> >> where the dma_mmu_remap count is correctly set. But this is not ideal
> >> solution and would like to see if you have any better way to solve the
> >> issue.
> >>
> >> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> >> index a41c93988d2c..535d1bf44529 100644
> >> --- a/arch/arm/kernel/setup.c
> >> +++ b/arch/arm/kernel/setup.c
> >> @@ -1079,6 +1079,7 @@ void __init hyp_mode_check(void)
> >>   #endif
> >>   }
> >>
> >> +void __init dma_contiguous_remap(void);
> >>   static void (*__arm_pm_restart)(enum reboot_mode reboot_mode, const
> >> char *cmd);
> >>
> >>   static int arm_restart(struct notifier_block *nb, unsigned long
> >> action,
> >> @@ -1164,6 +1165,7 @@ void __init setup_arch(char **cmdline_p)
> >>          }
> >>
> >>          unflatten_device_tree();
> >> +       dma_contiguous_remap();
> >>
> >>          arm_dt_init_cpu_maps();
> >>          psci_dt_init();
> >> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> >> index edb7f56b7c91..1828c8737d70 100644
> >> --- a/arch/arm/mm/mmu.c
> >> +++ b/arch/arm/mm/mmu.c
> >> @@ -1773,7 +1773,6 @@ void __init paging_init(const struct machine_des=
c
> >> *mdesc)
> >>           * be used
> >>           */
> >>          map_kernel();
> >> -       dma_contiguous_remap();
> >>          early_fixmap_shutdown();
> >>          devicemaps_init(mdesc);
> >>          kmap_init();
> >>
> >> You can reproduce the issue on any v7 devices by adding these nodes to
> >> the device tree
> >> +       reserved-memory {
> >> +               #address-cells =3D <1>;
> >> +               #size-cells =3D <1>;
> >> +               ranges;
> >> +
> >> +               dt_reserved_cma: dt_reserved_cma {
> >> +                       compatible =3D "shared-dma-pool";
> >> +                       reusable;
> >> +
> >> +                       reg =3D <0x1e000000 0x2000000>;
> >> +               };
> >> +       };
> >> +
> >> +       dmy_device {
> >> +               compatible =3D "xyz,dmydev";
> >> +               memory-region =3D <&dt_reserved_cma>;
> >> +       };
> >>
> >> And use this test driver to trigger the call stack:
> >> diff --git a/drivers/char/dmydev.c b/drivers/char/dmydev.c
> >> new file mode 100644
> >> index 000000000000..1dd52ec492eb
> >> --- /dev/null
> >> +++ b/drivers/char/dmydev.c
> >> @@ -0,0 +1,67 @@
> >> +#include<linux/module.h>
> >> +#include<linux/kernel.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_reserved_mem.h>
> >> +#include <linux/dma-mapping.h>
> >> +
> >> +static int dmydev_probe(struct platform_device *pdev)
> >> +{
> >> +       void* virt_addr;
> >> +       dma_addr_t dma_addr;
> >> +       int ret;
> >> +
> >> +       printk(KERN_ALERT "dmydev_probe called\n");
> >> +
> >> +       ret =3D of_reserved_mem_device_init(&pdev->dev);
> >> +       if (ret && ret !=3D -ENODEV) {
> >> +               dev_err(&pdev->dev, "Couldn't assign reserve memory to
> >> device ret =3D %d\n", ret);
> >> +                       return ret;
> >> +       }
> >> +
> >> +       virt_addr =3D dma_alloc_coherent(&pdev->dev, 0x800000, &dma_ad=
dr,
> >> GFP_KERNEL);
> >> +       if (virt_addr =3D=3D NULL) {
> >> +               dev_err(&pdev->dev,"Failed to allocated cma memory\n")=
;
> >> +               ret =3D -ENOMEM;
> >> +       }
> >> +       else
> >> +               dev_err(&pdev->dev,"Allocate dma memory at 0x%px dma
> >> addr %pad\n", virt_addr, &dma_addr);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static void dmydev_remove(struct platform_device *pdev)
> >> +{
> >> +}
> >> +
> >> +static const struct of_device_id dmydev_of_match[] =3D {
> >> +       {.compatible =3D "xyz,dmydev"},
> >> +       {}
> >> +};
> >> +MODULE_DEVICE_TABLE(of, dmydev_of_match);
> >>
> >> Let me know if you need more info.
> >>
> >>>
> >>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> >>> ---
> >>>   drivers/of/fdt.c             |   5 +-
> >>>   drivers/of/of_private.h      |   3 +-
> >>>   drivers/of/of_reserved_mem.c | 168
> >>> ++++++++++++++++++++++++----------
> -
> >>>   3 files changed, 122 insertions(+), 54 deletions(-)
> >>>
> >>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> >>> index 4d528c10df3a..d0dbc8183ac4 100644
> >>> --- a/drivers/of/fdt.c
> >>> +++ b/drivers/of/fdt.c
> >>> @@ -511,8 +511,6 @@ void __init early_init_fdt_scan_reserved_mem(void=
)
> >>>                       break;
> >>>               memblock_reserve(base, size);
> >>>       }
> >>> -
> >>> -     fdt_init_reserved_mem();
> >>>   }
> >>>
> >>>   /**
> >>> @@ -1212,6 +1210,9 @@ void __init unflatten_device_tree(void)
> >>>   {
> >>>       void *fdt =3D initial_boot_params;
> >>>
> >>> +     /* Save the statically-placed regions in the reserved_mem array
> >>> */
> >>> +     fdt_scan_reserved_mem_reg_nodes();
> >>> +
> >>>       /* Don't use the bootloader provided DTB if ACPI is enabled */
> >>>       if (!acpi_disabled)
> >>>               fdt =3D NULL;
> >>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> >>> index 04aa2a91f851..29525c0b9939 100644
> >>> --- a/drivers/of/of_private.h
> >>> +++ b/drivers/of/of_private.h
> >>> @@ -9,6 +9,7 @@
> >>>    */
> >>>
> >>>   #define FDT_ALIGN_SIZE 8
> >>> +#define MAX_RESERVED_REGIONS    64
> >>>
> >>>   /**
> >>>    * struct alias_prop - Alias property in 'aliases' node
> >>> @@ -180,7 +181,7 @@ static inline struct device_node
> *__of_get_dma_parent(const struct device_node *
> >>>   #endif
> >>>
> >>>   int fdt_scan_reserved_mem(void);
> >>> -void fdt_init_reserved_mem(void);
> >>> +void __init fdt_scan_reserved_mem_reg_nodes(void);
> >>>
> >>>   bool of_fdt_device_is_available(const void *blob, unsigned long
> >>> node);
> >>>
> >>> diff --git a/drivers/of/of_reserved_mem.c
> >>> b/drivers/of/of_reserved_mem.c
> >>> index 46e1c3fbc769..2011174211f9 100644
> >>> --- a/drivers/of/of_reserved_mem.c
> >>> +++ b/drivers/of/of_reserved_mem.c
> >>> @@ -27,7 +27,6 @@
> >>>
> >>>   #include "of_private.h"
> >>>
> >>> -#define MAX_RESERVED_REGIONS 64
> >>>   static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
> >>>   static int reserved_mem_count;
> >>>
> >>> @@ -56,6 +55,7 @@ static int __init
> early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
> >>>       return err;
> >>>   }
> >>>
> >>> +static void __init fdt_init_reserved_mem_node(struct reserved_mem
> *rmem);
> >>>   /*
> >>>    * fdt_reserved_mem_save_node() - save fdt node for second pass
> initialization
> >>>    */
> >>> @@ -74,6 +74,9 @@ static void __init
> fdt_reserved_mem_save_node(unsigned long node, const char *un
> >>>       rmem->base =3D base;
> >>>       rmem->size =3D size;
> >>>
> >>> +     /* Call the region specific initialization function */
> >>> +     fdt_init_reserved_mem_node(rmem);
> >>> +
> >>>       reserved_mem_count++;
> >>>       return;
> >>>   }
> >>> @@ -106,7 +109,6 @@ static int __init
> __reserved_mem_reserve_reg(unsigned long node,
> >>>       phys_addr_t base, size;
> >>>       int len;
> >>>       const __be32 *prop;
> >>> -     int first =3D 1;
> >>>       bool nomap;
> >>>
> >>>       prop =3D of_get_flat_dt_prop(node, "reg", &len);
> >>> @@ -134,10 +136,6 @@ static int __init
> __reserved_mem_reserve_reg(unsigned long node,
> >>>                              uname, &base, (unsigned long)(size /
> >>> SZ_1M));
> >>>
> >>>               len -=3D t_len;
> >>> -             if (first) {
> >>> -                     fdt_reserved_mem_save_node(node, uname, base,
> >>> size);
> >>> -                     first =3D 0;
> >>> -             }
> >>>       }
> >>>       return 0;
> >>>   }
> >>> @@ -165,12 +163,77 @@ static int __init
> __reserved_mem_check_root(unsigned long node)
> >>>       return 0;
> >>>   }
> >>>
> >>> +static void __init __rmem_check_for_overlap(void);
> >>> +
> >>> +/**
> >>> + * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg"
> >>> defined
> >>> + * reserved memory regions.
> >>> + *
> >>> + * This function is used to scan through the DT and store the
> >>> + * information for the reserved memory regions that are defined usin=
g
> >>> + * the "reg" property. The region node number, name, base address,
> >>> and
> >>> + * size are all stored in the reserved_mem array by calling the
> >>> + * fdt_reserved_mem_save_node() function.
> >>> + */
> >>> +void __init fdt_scan_reserved_mem_reg_nodes(void)
> >>> +{
> >>> +     int t_len =3D (dt_root_addr_cells + dt_root_size_cells) *
> >>> sizeof(__be32);
> >>> +     const void *fdt =3D initial_boot_params;
> >>> +     phys_addr_t base, size;
> >>> +     const __be32 *prop;
> >>> +     int node, child;
> >>> +     int len;
> >>> +
> >>> +     if (!fdt)
> >>> +             return;
> >>> +
> >>> +     node =3D fdt_path_offset(fdt, "/reserved-memory");
> >>> +     if (node < 0) {
> >>> +             pr_info("Reserved memory: No reserved-memory node in th=
e
> DT\n");
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     if (__reserved_mem_check_root(node)) {
> >>> +             pr_err("Reserved memory: unsupported node format,
> >>> ignoring\n");
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     fdt_for_each_subnode(child, fdt, node) {
> >>> +             const char *uname;
> >>> +
> >>> +             prop =3D of_get_flat_dt_prop(child, "reg", &len);
> >>> +             if (!prop)
> >>> +                     continue;
> >>> +             if (!of_fdt_device_is_available(fdt, child))
> >>> +                     continue;
> >>> +
> >>> +             uname =3D fdt_get_name(fdt, child, NULL);
> >>> +             if (len && len % t_len !=3D 0) {
> >>> +                     pr_err("Reserved memory: invalid reg property i=
n
> >>> '%s', skipping
> node.\n",
> >>> +                            uname);
> >>> +                     continue;
> >>> +             }
> >>> +             base =3D dt_mem_next_cell(dt_root_addr_cells, &prop);
> >>> +             size =3D dt_mem_next_cell(dt_root_size_cells, &prop);
> >>> +
> >>> +             if (size)
> >>> +                     fdt_reserved_mem_save_node(child, uname, base,
> >>> size);
> >>> +     }
> >>> +
> >>> +     /* check for overlapping reserved regions */
> >>> +     __rmem_check_for_overlap();
> >>> +}
> >>> +
> >>> +static int __init __reserved_mem_alloc_size(unsigned long node, cons=
t
> char *uname);
> >>> +
> >>>   /*
> >>>    * fdt_scan_reserved_mem() - scan a single FDT node for reserved
> >>> memory
> >>>    */
> >>>   int __init fdt_scan_reserved_mem(void)
> >>>   {
> >>>       int node, child;
> >>> +     int dynamic_nodes_cnt =3D 0;
> >>> +     int dynamic_nodes[MAX_RESERVED_REGIONS];
> >>>       const void *fdt =3D initial_boot_params;
> >>>
> >>>       node =3D fdt_path_offset(fdt, "/reserved-memory");
> >>> @@ -192,8 +255,24 @@ int __init fdt_scan_reserved_mem(void)
> >>>               uname =3D fdt_get_name(fdt, child, NULL);
> >>>
> >>>               err =3D __reserved_mem_reserve_reg(child, uname);
> >>> -             if (err =3D=3D -ENOENT && of_get_flat_dt_prop(child, "s=
ize",
> >>> NULL))
> >>> -                     fdt_reserved_mem_save_node(child, uname, 0, 0);
> >>> +             /*
> >>> +              * Save the nodes for the dynamically-placed regions
> >>> +              * into an array which will be used for allocation righ=
t
> >>> +              * after all the statically-placed regions are reserved
> >>> +              * or marked as no-map. This is done to avoid
> >>> dynamically
> >>> +              * allocating from one of the statically-placed regions=
.
> >>> +              */
> >>> +             if (err =3D=3D -ENOENT && of_get_flat_dt_prop(child, "s=
ize",
> >>> NULL)) {
> >>> +                     dynamic_nodes[dynamic_nodes_cnt] =3D child;
> >>> +                     dynamic_nodes_cnt++;
> >>> +             }
> >>> +     }
> >>> +     for (int i =3D 0; i < dynamic_nodes_cnt; i++) {
> >>> +             const char *uname;
> >>> +
> >>> +             child =3D dynamic_nodes[i];
> >>> +             uname =3D fdt_get_name(fdt, child, NULL);
> >>> +             __reserved_mem_alloc_size(child, uname);
> >>>       }
> >>>       return 0;
> >>>   }
> >>> @@ -253,8 +332,7 @@ static int __init
> __reserved_mem_alloc_in_range(phys_addr_t size,
> >>>    * __reserved_mem_alloc_size() - allocate reserved memory described
> >>> by
> >>>    *  'size', 'alignment'  and 'alloc-ranges' properties.
> >>>    */
> >>> -static int __init __reserved_mem_alloc_size(unsigned long node,
> >>> -     const char *uname, phys_addr_t *res_base, phys_addr_t *res_size=
)
> >>> +static int __init __reserved_mem_alloc_size(unsigned long node, cons=
t
> char *uname)
> >>>   {
> >>>       int t_len =3D (dt_root_addr_cells + dt_root_size_cells) *
> >>> sizeof(__be32);
> >>>       phys_addr_t start =3D 0, end =3D 0;
> >>> @@ -334,9 +412,8 @@ static int __init
> __reserved_mem_alloc_size(unsigned long node,
> >>>               return -ENOMEM;
> >>>       }
> >>>
> >>> -     *res_base =3D base;
> >>> -     *res_size =3D size;
> >>> -
> >>> +     /* Save region in the reserved_mem array */
> >>> +     fdt_reserved_mem_save_node(node, uname, base, size);
> >>>       return 0;
> >>>   }
> >>>
> >>> @@ -425,48 +502,37 @@ static void __init
> __rmem_check_for_overlap(void)
> >>>   }
> >>>
> >>>   /**
> >>> - * fdt_init_reserved_mem() - allocate and init all saved reserved
> >>> memory
> regions
> >>> + * fdt_init_reserved_mem_node() - Initialize a reserved memory regio=
n
> >>> + * @rmem: reserved_mem struct of the memory region to be initialized=
.
> >>> + *
> >>> + * This function is used to call the region specific initialization
> >>> + * function for a reserved memory region.
> >>>    */
> >>> -void __init fdt_init_reserved_mem(void)
> >>> +static void __init fdt_init_reserved_mem_node(struct reserved_mem
> *rmem)
> >>>   {
> >>> -     int i;
> >>> -
> >>> -     /* check for overlapping reserved regions */
> >>> -     __rmem_check_for_overlap();
> >>> -
> >>> -     for (i =3D 0; i < reserved_mem_count; i++) {
> >>> -             struct reserved_mem *rmem =3D &reserved_mem[i];
> >>> -             unsigned long node =3D rmem->fdt_node;
> >>> -             int err =3D 0;
> >>> -             bool nomap;
> >>> +     unsigned long node =3D rmem->fdt_node;
> >>> +     int err =3D 0;
> >>> +     bool nomap;
> >>>
> >>> -             nomap =3D of_get_flat_dt_prop(node, "no-map", NULL) !=
=3D
> >>> NULL;
> >>> +     nomap =3D of_get_flat_dt_prop(node, "no-map", NULL) !=3D NULL;
> >>>
> >>> -             if (rmem->size =3D=3D 0)
> >>> -                     err =3D __reserved_mem_alloc_size(node,
> >>> rmem->name,
> >>> -                                              &rmem->base,
> >>> &rmem->size);
> >>> -             if (err =3D=3D 0) {
> >>> -                     err =3D __reserved_mem_init_node(rmem);
> >>> -                     if (err !=3D 0 && err !=3D -ENOENT) {
> >>> -                             pr_info("node %s compatible matching
> >>> fail\n",
> >>> -                                     rmem->name);
> >>> -                             if (nomap)
> >>> -                                     memblock_clear_nomap(rmem->base=
,
> >>> rmem->size);
> >>> -                             else
> >>> -                                     memblock_phys_free(rmem->base,
> >>> -                                                        rmem->size);
> >>> -                     } else {
> >>> -                             phys_addr_t end =3D rmem->base +
> >>> rmem->size - 1;
> >>> -                             bool reusable =3D
> >>> -                                     (of_get_flat_dt_prop(node,
> >>> "reusable", NULL)) !=3D
> NULL;
> >>> -
> >>> -                             pr_info("%pa..%pa (%lu KiB) %s %s %s\n"=
,
> >>> -                                     &rmem->base, &end, (unsigned
> >>> long)(rmem->size /
> SZ_1K),
> >>> -                                     nomap ? "nomap" : "map",
> >>> -                                     reusable ? "reusable" :
> >>> "non-reusable",
> >>> -                                     rmem->name ? rmem->name :
> >>> "unknown");
> >>> -                     }
> >>> -             }
> >>> +     err =3D __reserved_mem_init_node(rmem);
> >>> +     if (err !=3D 0 && err !=3D -ENOENT) {
> >>> +             pr_info("node %s compatible matching fail\n",
> >>> rmem->name);
> >>> +             if (nomap)
> >>> +                     memblock_clear_nomap(rmem->base, rmem->size);
> >>> +             else
> >>> +                     memblock_phys_free(rmem->base, rmem->size);
> >>> +     } else {
> >>> +             phys_addr_t end =3D rmem->base + rmem->size - 1;
> >>> +             bool reusable =3D
> >>> +                     (of_get_flat_dt_prop(node, "reusable", NULL)) !=
=3D
> >>> NULL;
> >>> +
> >>> +             pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
> >>> +                     &rmem->base, &end, (unsigned long)(rmem->size /
> >>> SZ_1K),
> >>> +                     nomap ? "nomap" : "map",
> >>> +                     reusable ? "reusable" : "non-reusable",
> >>> +                     rmem->name ? rmem->name : "unknown");
> >>>       }
> >>>   }
> >>>
> >>
> > Just want to follow up on this issue.  Do you need any further detail
> > or clarification?
> > Any ARM memory manage guru on this thread can comment?
> > Or is my workaround acceptable as a patch?
>
>
> Hi William,
>
> Sorry about the delay in getting back to you.
>
> Instead of moving dma_contiguous_remap(), I suggest moving
> dma_contiguous_early_fixup()
> to the function that parses the reserved regions so that it is done befor=
e
> paging_init.
>
> Here is what that could look like. Can you please give this a try?
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 77016c0cc296..132d2c66cafc 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -25,6 +25,7 @@
>  #include <linux/memblock.h>
>  #include <linux/kmemleak.h>
>  #include <linux/cma.h>
> +#include <linux/dma-map-ops.h>
>
>  #include "of_private.h"
>
> @@ -175,13 +176,17 @@ static int __init
> __reserved_mem_reserve_reg(unsigned long node,
>                 base =3D dt_mem_next_cell(dt_root_addr_cells, &prop);
>                 size =3D dt_mem_next_cell(dt_root_size_cells, &prop);
>
> -               if (size &&
> -                   early_init_dt_reserve_memory(base, size, nomap) =3D=
=3D 0)
> +               if (size && early_init_dt_reserve_memory(base, size,
> nomap) =3D=3D 0) {
> +                       /* Architecture specific contiguous memory fixup.
> */
> +                       if (of_flat_dt_is_compatible(node,
> "shared-dma-pool"))
> +                               dma_contiguous_early_fixup(base, size);
> +
>                         pr_debug("Reserved memory: reserved region for
> node '%s':
> base %pa, size %lu MiB\n",
>                                 uname, &base, (unsigned long)(size /
> SZ_1M));
> -               else
> +               } else {
>                         pr_err("Reserved memory: failed to reserve memory
> for node '%s':
> base %pa, size %lu MiB\n",
>                                uname, &base, (unsigned long)(size /
> SZ_1M));
> +               }
>
>                 len -=3D t_len;
>         }
> @@ -472,6 +477,9 @@ static int __init __reserved_mem_alloc_size(unsigned
> long node, const char *unam
>                        uname, (unsigned long)(size / SZ_1M));
>                 return -ENOMEM;
>         }
> +       /* Architecture specific contiguous memory fixup. */
> +       if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
> +               dma_contiguous_early_fixup(base, size);
>         /* Save region in the reserved_mem array */
>         fdt_reserved_mem_save_node(node, uname, base, size);
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 8df0dfaaca18..9e5d63efe7c5 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -480,8 +480,6 @@ static int __init rmem_cma_setup(struct reserved_mem
> *rmem)
>                 pr_err("Reserved memory: unable to setup CMA region\n");
>                 return err;
>         }
> -       /* Architecture specific contiguous memory fixup. */
> -       dma_contiguous_early_fixup(rmem->base, rmem->size);
>
>         if (default_cma)
>                 dma_contiguous_default_area =3D cma;
>
> Regards,
> Oreoluwa

Thank you Oreoluwa!  Your patch fixed the issue too and it looks a more
localized and better fix!

--000000000000799cf30638a825db
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJg
MIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIDOdnJJsTXP7Iglws5L5ARzxg3h1
Nf2hYz0cmTfrW/35MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDYyODIxMDQ1NFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBAHqHafy765Iymr73L+KC99cfr2LB9eEWk4HqG6qfLMy0xl+tPIguScVbUBpvFNln
9UwhbWKKEGgzT+X5VW5E/w7KoObaXVInAO0vaGJQ7kCjYvlXnr9vqUZ7A7qNal7g6obitttYj8+A
pFBat6GHtHA8hvJLDuwXAtCtz1sUTaxN7r96FAg9Vrs1X5grE5tHMaiQ2vSPut1La7/gYl1qFJdH
Mwpw8svltsXkNWbB6Y7dmBQt8eGiwgSwJtzdmHWtCgJ6wzzkt9t4ai18ZWNJTAGI52Cbj5zWPImr
g4+E4wPOQ9DSykvJNJFyN8D99193wFz6jOaYqxSDEt5vRtmLH1Y=
--000000000000799cf30638a825db--
