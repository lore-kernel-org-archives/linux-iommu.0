Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72A221FDA
	for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180505; cv=none; b=FDVWagCkJzp4N2/Sl6VrYt029u2UMfHsD2AxaGXi4go80MmipIzobRMjj/VFzvwEWmNPPYucrFTOkvF4BlUU6QW3xm4WPv5vDrelwUKMLtTkdPYWNGYTnzE4islyGvDKSIWck2MiD7W/6PnH9Yf7sbs6m240bHGDQ70JJdXNqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180505; c=relaxed/simple;
	bh=kdJSX/lZkMJ2HXzf6ZMUXp+3dHa/KkEbPCIjLVJceLg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dk/glcq6EuULkYFYz6oXu6cn5ZWw1SSy/IKlm5S4u6S3b/NJvoV0FL4DdDvn2jXEOMzXTOYS5Aq5n04kwrhB1i6A6sutsoCVVLgeF67PeGQvCTmfFZq7kOGNCbRsAHC29GsFdNIhRU13bdNBnMwqFDxvDI0USGQttezjJOFAAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OJjhkPd6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OJjhkPd6"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747c2cc3419so4695071b3a.2
        for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750180503; x=1750785303; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XshdD0HOSCL/eYF9vVTULSvUerzYDX2e/b8Ax35nwt0=;
        b=OJjhkPd6qPqgY0BKlq94kmOJkL0Kw0f8qMEJPfyyyVB4vSWCANOjVnKbV2yH/Kd/xC
         YNZnD5I9roiTJhFWqza9106oNP8LAbmRfRk9AiMuWvu4hgTnnYJR1kl7bGMZ7l6RfJ5y
         i705Y1uwvOACuB2edK6tZi4WIfL2Q4OZzSS1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750180503; x=1750785303;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XshdD0HOSCL/eYF9vVTULSvUerzYDX2e/b8Ax35nwt0=;
        b=YFfOgGSiw8cJ+lNf9MpLLX7yI7JIh4Be28gjRj6n+kuGkGgQ1ThWAzz7mSS8g7HEDA
         AE71ZRS9vLbsMN/YMw6q1sh35hO3ConRJsfoATPeENIYmyoYirWllh1NPiiMW/yvLieS
         V0hzdUP79isrwejn5YTTR9erInUloJ7ibwqK4cLnsL1NxYxevVWJabhPoKyDkTsD6o2O
         HpH+iYj1WN5JNq9UJTHdhqfJ384YsD5AiWw8gVTFfh8qX++iatQ7+GpREsi7cWOYy/DV
         nbKKoL2y3e+NNYLgBQdn+nZUpZG2uTT0ThybiI8/ZOY6WSKMMWS9ivkj1Hfl7yhRK5UM
         gwXA==
X-Forwarded-Encrypted: i=1; AJvYcCUyQldMpN/xp+ukPkB3bNadJ2YzV9bTeHh9g6mbtf84elWNdvqf+t1UiBpqKAvGSEkVgiIimw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxenZJ5nj5vqzUUHEwX2OUSnHqxiiwcXzMhq+bcuTO6u/DB4MSQ
	Fq822YDm3V3OH2W29hAi7zU4otsXfzBS4kyyzsSskQW4W/36CnSG5bfks2nqR4rioaYg3fdSpLO
	BLb4=
X-Gm-Gg: ASbGncs9zhJnt3LVU2eDo9+7H0v8XHd9Cv+FzIGKzH04//QXwhj4cE29oDviTCU0CJn
	3jmjliI6Ntc8RzVpoZjZC7E/Nh197F3xs0TSXMJo/gfQGlt+081cgXAgyxF/jrXj5jPkLFCQTA2
	v3TTShSRAlnGPExKBQjKwhG3v6DDuhMVCIGKbPwH/7H4in6bOHVhlTlOFEWAKq5l+RuVfUD8pc2
	2b95cG8tD0sw4eZklmKTbFOMWt93vC9AKZEOX579vn/XyQJdmhwyF25ssenVPaqHjlBNgOB3Hyz
	IKwvNQVACB+OMQfK7yfKRN0q6TRnb+GpAbfkPOGHHNJfRpBJ+hnFVuVG+X1AQFj8lfQk9lAjC78
	7DzXLWuLus70I
X-Google-Smtp-Source: AGHT+IHJ0F4Enzf2yLbiiSyTojIMcYDPSLWbCzVCLD0RoRm8PhgRa10ATzP7wZ6aChnnmejSikpq9w==
X-Received: by 2002:a05:6a00:1793:b0:747:b043:41e8 with SMTP id d2e1a72fcca58-7489cfff39amr17719706b3a.15.1750180502882;
        Tue, 17 Jun 2025 10:15:02 -0700 (PDT)
Received: from [10.58.33.30] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecd13sm9164767b3a.34.2025.06.17.10.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 10:15:02 -0700 (PDT)
Message-ID: <5aa94f41-c689-443b-8665-c6913ff5ba8f@broadcom.com>
Date: Tue, 17 Jun 2025 10:15:01 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: William Zhang <william.zhang@broadcom.com>
Subject: Re: [PATCH v10 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, robh@kernel.org
Cc: aisheng.dong@nxp.com, andy@black.fi.intel.com, catalin.marinas@arm.com,
 devicetree@vger.kernel.org, hch@lst.de, iommu@lists.linux.dev,
 kernel@quicinc.com, klarasmodin@gmail.com, linux-kernel@vger.kernel.org,
 m.szyprowski@samsung.com, quic_ninanaik@quicinc.com, robin.murphy@arm.com,
 saravanak@google.com, will@kernel.org
References: <20241008220624.551309-1-quic_obabatun@quicinc.com>
 <20241008220624.551309-2-quic_obabatun@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241008220624.551309-2-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oreoluwa,

On 10/8/2024 3:06 PM, Oreoluwa Babatunde wrote:
> Reserved memory regions defined in the devicetree can be broken up into
> two groups:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a static start address and size using the
>       "reg" property.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying an address range where they can be
>       placed in memory using the "alloc_ranges" and "size" properties.
> 
> These regions are processed and set aside at boot time.
> This is done in two stages as seen below:
> 
> Stage 1:
> At this stage, fdt_scan_reserved_mem() scans through the child nodes of
> the reserved_memory node using the flattened devicetree and does the
> following:
> 
> 1) If the node represents a statically-placed reserved memory region,
>     i.e. if it is defined using the "reg" property:
>     - Call memblock_reserve() or memblock_mark_nomap() as needed.
>     - Add the information for that region into the reserved_mem array
>       using fdt_reserved_mem_save_node().
>       i.e. fdt_reserved_mem_save_node(node, name, base, size).
> 
> 2) If the node represents a dynamically-placed reserved memory region,
>     i.e. if it is defined using "alloc-ranges" and "size" properties:
>     - Add the information for that region to the reserved_mem array with
>       the starting address and size set to 0.
>       i.e. fdt_reserved_mem_save_node(node, name, 0, 0).
>     Note: This region is saved to the array with a starting address of 0
>     because a starting address is not yet allocated for it.
> 
> Stage 2:
> After iterating through all the reserved memory nodes and storing their
> relevant information in the reserved_mem array,fdt_init_reserved_mem() is
> called and does the following:
> 
> 1) For statically-placed reserved memory regions:
>     - Call the region specific init function using
>       __reserved_mem_init_node().
> 2) For dynamically-placed reserved memory regions:
>     - Call __reserved_mem_alloc_size() which is used to allocate memory
>       for each of these regions, and mark them as nomap if they have the
>       nomap property specified in the DT.
>     - Call the region specific init function.
> 
> The current size of the resvered_mem array is 64 as is defined by
> MAX_RESERVED_REGIONS. This means that there is a limitation of 64 for
> how many reserved memory regions can be specified on a system.
> As systems continue to grow more and more complex, the number of
> reserved memory regions needed are also growing and are starting to hit
> this 64 count limit, hence the need to make the reserved_mem array
> dynamically sized (i.e. dynamically allocating memory for the
> reserved_mem array using membock_alloc_*).
> 
> On architectures such as arm64, memory allocated using memblock is
> writable only after the page tables have been setup. This means that if
> the reserved_mem array is going to be dynamically allocated, it needs to
> happen after the page tables have been setup, not before.
> 
> Since the reserved memory regions are currently being processed and
> added to the array before the page tables are setup, there is a need to
> change the order in which some of the processing is done to allow for
> the reserved_mem array to be dynamically sized.
> 
> It is possible to process the statically-placed reserved memory regions
> without needing to store them in the reserved_mem array until after the
> page tables have been setup because all the information stored in the
> array is readily available in the devicetree and can be referenced at
> any time.
> Dynamically-placed reserved memory regions on the other hand get
> assigned a start address only at runtime, and hence need a place to be
> stored once they are allocated since there is no other referrence to the
> start address for these regions.
> 
> Hence this patch changes the processing order of the reserved memory
> regions in the following ways:
> 
> Step 1:
> fdt_scan_reserved_mem() scans through the child nodes of
> the reserved_memory node using the flattened devicetree and does the
> following:
> 
> 1) If the node represents a statically-placed reserved memory region,
>     i.e. if it is defined using the "reg" property:
>     - Call memblock_reserve() or memblock_mark_nomap() as needed.
> 
> 2) If the node represents a dynamically-placed reserved memory region,
>     i.e. if it is defined using "alloc-ranges" and "size" properties:
>     - Call __reserved_mem_alloc_size() which will:
>       i) Allocate memory for the reserved region and call
>       memblock_mark_nomap() as needed.
>       ii) Call the region specific initialization function using
>       fdt_init_reserved_mem_node().
>       iii) Save the region information in the reserved_mem array using
>       fdt_reserved_mem_save_node().
> 
> Step 2:
> 1) This stage of the reserved memory processing is now only used to add
>     the statically-placed reserved memory regions into the reserved_mem
>     array using fdt_scan_reserved_mem_reg_nodes(), as well as call their
>     region specific initialization functions.
> 
> 2) This step has also been moved to be after the page tables are
>     setup. Moving this will allow us to replace the reserved_mem
>     array with a dynamically sized array before storing the rest of
>     these regions.
I am running into a call trace with this order change on armv7 chip when 
I tried to allocate dma coherent memory from the device reserved memory. 
The issue does not happen on armv8 chips.

[    0.000000] Reserved memory: created CMA memory pool at 0x1e000000, 
size 32 MiB
[    0.000000] OF: reserved mem: initialized node dt_reserved_cma, 
compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x1e000000..0x1fffffff (32768 KiB) map 
reusable dt_reserved_cma
....

[    0.445322] ------------[ cut here ]------------
[    0.445353] WARNING: CPU: 0 PID: 1 at mm/memory.c:3069 
__apply_to_page_range+0x380/0x388
[    0.488911] Modules linked in:
[    0.492027] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.16.0-rc1-g27605c8c0f69-dirty #3 NONE
[    0.501174] Hardware name: Generic DT based system
[    0.505965] Call trace:
[    0.505985]  unwind_backtrace from show_stack+0x10/0x14
[    0.513764]  show_stack from dump_stack_lvl+0x54/0x68
[    0.518834]  dump_stack_lvl from __warn+0x7c/0x128
[    0.523639]  __warn from warn_slowpath_fmt+0x184/0x18c
[    0.527676] Freeing initrd memory: 65536K
[    0.532788]  warn_slowpath_fmt from __apply_to_page_range+0x380/0x388
[    0.539242]  __apply_to_page_range from apply_to_page_range+0x1c/0x24
[    0.545689]  apply_to_page_range from __alloc_from_contiguous+0xc0/0x14c
[    0.552398]  __alloc_from_contiguous from cma_allocator_alloc+0x34/0x3c
[    0.559016]  cma_allocator_alloc from arch_dma_alloc+0x11c/0x2ac
[    0.565025]  arch_dma_alloc from dma_alloc_attrs+0x90/0x2e8
[    0.570603]  dma_alloc_attrs from dmydev_probe+0x8c/0xe8
[    0.575919]  dmydev_probe from platform_probe+0x5c/0xb0
[    0.581152]  platform_probe from really_probe+0xc8/0x2c8
[    0.586467]  really_probe from __driver_probe_device+0x88/0x19c
[    0.592387]  __driver_probe_device from driver_probe_device+0x30/0x104
[    0.598915]  driver_probe_device from __driver_attach+0x90/0x178
[    0.604921]  __driver_attach from bus_for_each_dev+0x7c/0xcc
[    0.610582]  bus_for_each_dev from bus_add_driver+0xcc/0x1ec
[    0.616241]  bus_add_driver from driver_register+0x7c/0x114
[    0.621814]  driver_register from dmydev_init+0x20/0x28
[    0.627045]  dmydev_init from do_one_initcall+0x58/0x200
[    0.632363]  do_one_initcall from kernel_init_freeable+0x1cc/0x228
[    0.638550]  kernel_init_freeable from kernel_init+0x1c/0x12c
[    0.644299]  kernel_init from ret_from_fork+0x14/0x28
[    0.649351] Exception stack(0xe0819fb0 to 0xe0819ff8)
[    0.654401] 9fa0:                                     00000000 
00000000 00000000 00000000
[    0.662575] 9fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    0.670747] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.677403] ---[ end trace 0000000000000000 ]---
[    0.682083] dmydev dmy_device: Allocate dma memory at 0xde000000 dma 
addr 0x1e000000

The reason is that now reserved memory's fixup function 
dma_contiguous_early_fixup is called after the page table is 
initialized. This fixup function increases the dma_mmu_remap count for 
each reserved memory. And the dma_contiguous_remap function depends on 
it to properly set up the reserved memory mmu table entry. Before this 
change, the paging_init function calls dma_contiguous_remap and it 
founds the reserved memory and set it up properly.  After the change, 
this function found there is no reserved memory so skip any 
initialization hence causes the crash later on when my driver tries to 
allocate dma memory from the reserved memory.

My workaround below is to move the dma_contiguous_remap out from the 
paging_init function to the place right after unflatten_device_tree 
where the dma_mmu_remap count is correctly set. But this is not ideal 
solution and would like to see if you have any better way to solve the 
issue.

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index a41c93988d2c..535d1bf44529 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1079,6 +1079,7 @@ void __init hyp_mode_check(void)
  #endif
  }

+void __init dma_contiguous_remap(void);
  static void (*__arm_pm_restart)(enum reboot_mode reboot_mode, const 
char *cmd);

  static int arm_restart(struct notifier_block *nb, unsigned long action,
@@ -1164,6 +1165,7 @@ void __init setup_arch(char **cmdline_p)
         }

         unflatten_device_tree();
+       dma_contiguous_remap();

         arm_dt_init_cpu_maps();
         psci_dt_init();
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index edb7f56b7c91..1828c8737d70 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1773,7 +1773,6 @@ void __init paging_init(const struct machine_desc 
*mdesc)
          * be used
          */
         map_kernel();
-       dma_contiguous_remap();
         early_fixmap_shutdown();
         devicemaps_init(mdesc);
         kmap_init();

You can reproduce the issue on any v7 devices by adding these nodes to 
the device tree
+       reserved-memory {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               ranges;
+
+               dt_reserved_cma: dt_reserved_cma {
+                       compatible = "shared-dma-pool";
+                       reusable;
+
+                       reg = <0x1e000000 0x2000000>;
+               };
+       };
+
+       dmy_device {
+               compatible = "xyz,dmydev";
+               memory-region = <&dt_reserved_cma>;
+       };

And use this test driver to trigger the call stack:
diff --git a/drivers/char/dmydev.c b/drivers/char/dmydev.c
new file mode 100644
index 000000000000..1dd52ec492eb
--- /dev/null
+++ b/drivers/char/dmydev.c
@@ -0,0 +1,67 @@
+#include<linux/module.h>
+#include<linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/dma-mapping.h>
+
+static int dmydev_probe(struct platform_device *pdev)
+{
+       void* virt_addr;
+       dma_addr_t dma_addr;
+       int ret;
+
+       printk(KERN_ALERT "dmydev_probe called\n");
+
+       ret = of_reserved_mem_device_init(&pdev->dev);
+       if (ret && ret != -ENODEV) {
+               dev_err(&pdev->dev, "Couldn't assign reserve memory to 
device ret = %d\n", ret);
+                       return ret;
+       }
+
+       virt_addr = dma_alloc_coherent(&pdev->dev, 0x800000, &dma_addr, 
GFP_KERNEL);
+       if (virt_addr == NULL) {
+               dev_err(&pdev->dev,"Failed to allocated cma memory\n");
+               ret = -ENOMEM;
+       }
+       else
+               dev_err(&pdev->dev,"Allocate dma memory at 0x%px dma 
addr %pad\n", virt_addr, &dma_addr);
+
+       return ret;
+}
+
+static void dmydev_remove(struct platform_device *pdev)
+{
+}
+
+static const struct of_device_id dmydev_of_match[] = {
+       {.compatible = "xyz,dmydev"},
+       {}
+};
+MODULE_DEVICE_TABLE(of, dmydev_of_match);

Let me know if you need more info.

> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>   drivers/of/fdt.c             |   5 +-
>   drivers/of/of_private.h      |   3 +-
>   drivers/of/of_reserved_mem.c | 168 ++++++++++++++++++++++++-----------
>   3 files changed, 122 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4d528c10df3a..d0dbc8183ac4 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -511,8 +511,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
>   			break;
>   		memblock_reserve(base, size);
>   	}
> -
> -	fdt_init_reserved_mem();
>   }
>   
>   /**
> @@ -1212,6 +1210,9 @@ void __init unflatten_device_tree(void)
>   {
>   	void *fdt = initial_boot_params;
>   
> +	/* Save the statically-placed regions in the reserved_mem array */
> +	fdt_scan_reserved_mem_reg_nodes();
> +
>   	/* Don't use the bootloader provided DTB if ACPI is enabled */
>   	if (!acpi_disabled)
>   		fdt = NULL;
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 04aa2a91f851..29525c0b9939 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -9,6 +9,7 @@
>    */
>   
>   #define FDT_ALIGN_SIZE 8
> +#define MAX_RESERVED_REGIONS    64
>   
>   /**
>    * struct alias_prop - Alias property in 'aliases' node
> @@ -180,7 +181,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
>   #endif
>   
>   int fdt_scan_reserved_mem(void);
> -void fdt_init_reserved_mem(void);
> +void __init fdt_scan_reserved_mem_reg_nodes(void);
>   
>   bool of_fdt_device_is_available(const void *blob, unsigned long node);
>   
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 46e1c3fbc769..2011174211f9 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -27,7 +27,6 @@
>   
>   #include "of_private.h"
>   
> -#define MAX_RESERVED_REGIONS	64
>   static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
>   static int reserved_mem_count;
>   
> @@ -56,6 +55,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>   	return err;
>   }
>   
> +static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem);
>   /*
>    * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
>    */
> @@ -74,6 +74,9 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
>   	rmem->base = base;
>   	rmem->size = size;
>   
> +	/* Call the region specific initialization function */
> +	fdt_init_reserved_mem_node(rmem);
> +
>   	reserved_mem_count++;
>   	return;
>   }
> @@ -106,7 +109,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>   	phys_addr_t base, size;
>   	int len;
>   	const __be32 *prop;
> -	int first = 1;
>   	bool nomap;
>   
>   	prop = of_get_flat_dt_prop(node, "reg", &len);
> @@ -134,10 +136,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>   			       uname, &base, (unsigned long)(size / SZ_1M));
>   
>   		len -= t_len;
> -		if (first) {
> -			fdt_reserved_mem_save_node(node, uname, base, size);
> -			first = 0;
> -		}
>   	}
>   	return 0;
>   }
> @@ -165,12 +163,77 @@ static int __init __reserved_mem_check_root(unsigned long node)
>   	return 0;
>   }
>   
> +static void __init __rmem_check_for_overlap(void);
> +
> +/**
> + * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
> + * reserved memory regions.
> + *
> + * This function is used to scan through the DT and store the
> + * information for the reserved memory regions that are defined using
> + * the "reg" property. The region node number, name, base address, and
> + * size are all stored in the reserved_mem array by calling the
> + * fdt_reserved_mem_save_node() function.
> + */
> +void __init fdt_scan_reserved_mem_reg_nodes(void)
> +{
> +	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
> +	const void *fdt = initial_boot_params;
> +	phys_addr_t base, size;
> +	const __be32 *prop;
> +	int node, child;
> +	int len;
> +
> +	if (!fdt)
> +		return;
> +
> +	node = fdt_path_offset(fdt, "/reserved-memory");
> +	if (node < 0) {
> +		pr_info("Reserved memory: No reserved-memory node in the DT\n");
> +		return;
> +	}
> +
> +	if (__reserved_mem_check_root(node)) {
> +		pr_err("Reserved memory: unsupported node format, ignoring\n");
> +		return;
> +	}
> +
> +	fdt_for_each_subnode(child, fdt, node) {
> +		const char *uname;
> +
> +		prop = of_get_flat_dt_prop(child, "reg", &len);
> +		if (!prop)
> +			continue;
> +		if (!of_fdt_device_is_available(fdt, child))
> +			continue;
> +
> +		uname = fdt_get_name(fdt, child, NULL);
> +		if (len && len % t_len != 0) {
> +			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
> +			       uname);
> +			continue;
> +		}
> +		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +		size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +
> +		if (size)
> +			fdt_reserved_mem_save_node(child, uname, base, size);
> +	}
> +
> +	/* check for overlapping reserved regions */
> +	__rmem_check_for_overlap();
> +}
> +
> +static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
> +
>   /*
>    * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
>    */
>   int __init fdt_scan_reserved_mem(void)
>   {
>   	int node, child;
> +	int dynamic_nodes_cnt = 0;
> +	int dynamic_nodes[MAX_RESERVED_REGIONS];
>   	const void *fdt = initial_boot_params;
>   
>   	node = fdt_path_offset(fdt, "/reserved-memory");
> @@ -192,8 +255,24 @@ int __init fdt_scan_reserved_mem(void)
>   		uname = fdt_get_name(fdt, child, NULL);
>   
>   		err = __reserved_mem_reserve_reg(child, uname);
> -		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
> -			fdt_reserved_mem_save_node(child, uname, 0, 0);
> +		/*
> +		 * Save the nodes for the dynamically-placed regions
> +		 * into an array which will be used for allocation right
> +		 * after all the statically-placed regions are reserved
> +		 * or marked as no-map. This is done to avoid dynamically
> +		 * allocating from one of the statically-placed regions.
> +		 */
> +		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL)) {
> +			dynamic_nodes[dynamic_nodes_cnt] = child;
> +			dynamic_nodes_cnt++;
> +		}
> +	}
> +	for (int i = 0; i < dynamic_nodes_cnt; i++) {
> +		const char *uname;
> +
> +		child = dynamic_nodes[i];
> +		uname = fdt_get_name(fdt, child, NULL);
> +		__reserved_mem_alloc_size(child, uname);
>   	}
>   	return 0;
>   }
> @@ -253,8 +332,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
>    * __reserved_mem_alloc_size() - allocate reserved memory described by
>    *	'size', 'alignment'  and 'alloc-ranges' properties.
>    */
> -static int __init __reserved_mem_alloc_size(unsigned long node,
> -	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
> +static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
>   {
>   	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
>   	phys_addr_t start = 0, end = 0;
> @@ -334,9 +412,8 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
>   		return -ENOMEM;
>   	}
>   
> -	*res_base = base;
> -	*res_size = size;
> -
> +	/* Save region in the reserved_mem array */
> +	fdt_reserved_mem_save_node(node, uname, base, size);
>   	return 0;
>   }
>   
> @@ -425,48 +502,37 @@ static void __init __rmem_check_for_overlap(void)
>   }
>   
>   /**
> - * fdt_init_reserved_mem() - allocate and init all saved reserved memory regions
> + * fdt_init_reserved_mem_node() - Initialize a reserved memory region
> + * @rmem: reserved_mem struct of the memory region to be initialized.
> + *
> + * This function is used to call the region specific initialization
> + * function for a reserved memory region.
>    */
> -void __init fdt_init_reserved_mem(void)
> +static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem)
>   {
> -	int i;
> -
> -	/* check for overlapping reserved regions */
> -	__rmem_check_for_overlap();
> -
> -	for (i = 0; i < reserved_mem_count; i++) {
> -		struct reserved_mem *rmem = &reserved_mem[i];
> -		unsigned long node = rmem->fdt_node;
> -		int err = 0;
> -		bool nomap;
> +	unsigned long node = rmem->fdt_node;
> +	int err = 0;
> +	bool nomap;
>   
> -		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
> +	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
>   
> -		if (rmem->size == 0)
> -			err = __reserved_mem_alloc_size(node, rmem->name,
> -						 &rmem->base, &rmem->size);
> -		if (err == 0) {
> -			err = __reserved_mem_init_node(rmem);
> -			if (err != 0 && err != -ENOENT) {
> -				pr_info("node %s compatible matching fail\n",
> -					rmem->name);
> -				if (nomap)
> -					memblock_clear_nomap(rmem->base, rmem->size);
> -				else
> -					memblock_phys_free(rmem->base,
> -							   rmem->size);
> -			} else {
> -				phys_addr_t end = rmem->base + rmem->size - 1;
> -				bool reusable =
> -					(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
> -
> -				pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
> -					&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
> -					nomap ? "nomap" : "map",
> -					reusable ? "reusable" : "non-reusable",
> -					rmem->name ? rmem->name : "unknown");
> -			}
> -		}
> +	err = __reserved_mem_init_node(rmem);
> +	if (err != 0 && err != -ENOENT) {
> +		pr_info("node %s compatible matching fail\n", rmem->name);
> +		if (nomap)
> +			memblock_clear_nomap(rmem->base, rmem->size);
> +		else
> +			memblock_phys_free(rmem->base, rmem->size);
> +	} else {
> +		phys_addr_t end = rmem->base + rmem->size - 1;
> +		bool reusable =
> +			(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
> +
> +		pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
> +			&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
> +			nomap ? "nomap" : "map",
> +			reusable ? "reusable" : "non-reusable",
> +			rmem->name ? rmem->name : "unknown");
>   	}
>   }
>   

