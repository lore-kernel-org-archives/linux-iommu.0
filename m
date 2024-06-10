Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381311422A8;
	Mon, 10 Jun 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055246; cv=none; b=JyOPeRSC87BnOajJ+GWfHNNK4JsTYa6NLdm4QeuFTdaGVn3pmVTrXiC+CWfBAE6Y1CXA07wF63HQXyNg1b7kexq9iWJcQ3LwoKEHPEBUPjvuScXu5w/8SnAny/jabNzYA7HvyTgglQFlYre4nweuGPipYBTiGezQgl4sBWH2zyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055246; c=relaxed/simple;
	bh=jDKiK3w7+t+K2nGUMmbtPcgCVbtXoOyg53dh7b6Ygsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNQXbRWLlTe173CfNtXNSKxZecOujr2sIccspd9qOP+F1E6ZuBIUBmGa5CqAANEpdJCAisjOwpeeiWylnu8Mce192O6a1tUtKdcR5vAo2zoJS2sQSv+D+FoAC8BIBnzLuURHtcsyzPSGjOtRwhnCDIpMZiijYsAITgtFv7xJMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJX6FmMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJX6FmMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC79C4AF48;
	Mon, 10 Jun 2024 21:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055245;
	bh=jDKiK3w7+t+K2nGUMmbtPcgCVbtXoOyg53dh7b6Ygsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJX6FmMDTdkOoMPIxa/KzCv68R+7Q2vLkjx+p/3lN4VelFPAA2ZDO1nd0rFNp/0i9
	 UO8Tqtmu8SZGTNi86515KPoOKzDMqMIhbK5sUOqnks9dJXBGCfmqgUvpZLah1GIG3V
	 roeG5AtSNmUB/CrcisepMqmoZMcdFyP/IDkPIO+47+3a9/IUyaaR9Rqr9zk38Kdb55
	 /4Ty/+ga5XWrRBVm84rSJYkYU+pX192ZBaCODcQSCyajcHYYxYRb26zSiBp7gdWMpM
	 aaaoJChvYab6QjBWidQubLGjJiBxZKf16ukR2lNfv3gJ+WE6aPSdZ/zFdu5UZGAN3l
	 j6cD1vmfSNAkQ==
Date: Mon, 10 Jun 2024 14:34:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: robh@kernel.org, saravanak@google.com, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com, will@kernel.org,
	catalin.marinas@arm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	kernel@quicinc.com
Subject: Re: [PATCH v6 1/4] of: reserved_mem: Restruture how the reserved
 memory regions are processed
Message-ID: <20240610213403.GA1697364@thelio-3990X>
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
 <20240528223650.619532-2-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528223650.619532-2-quic_obabatun@quicinc.com>

Hi Oreoluwa,

On Tue, May 28, 2024 at 03:36:47PM -0700, Oreoluwa Babatunde wrote:
> The current implementation processes the reserved memory regions in two
> stages which are done with two separate functions within the
> early_init_fdt_scan_reserved_mem() function.
> 
> Within the two stages of processing, the reserved memory regions are
> broken up into two groups which are processed differently:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a static start address and size using the
>      "reg" property in the DT.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying a range of addresses where they can
>      be placed in memory using the "alloc_ranges" and "size" properties
>      in the DT.
> 
> Stage 1: fdt_scan_reserved_mem()
> This stage of the reserved memory processing is used to scan through the
> reserved memory nodes defined in the devicetree and do the following on
> each of the nodes:
> 
> 1) If the node represents a statically-placed reserved memory region,
>    i.e. it is defined using the "reg" property:
>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
>    - Add the information for the reserved region to the reserved_mem
>      array.
>      eg: fdt_reserved_mem_save_node(node, name, base, size);
> 
> 2) If the node represents a dynamically-placed reserved memory region,
>    i.e. it is defined using "alloc-ranges" and "size" properties:
>    - Add the information for the region to the reserved_mem array with
>      the starting address and size set to 0.
>      eg: fdt_reserved_mem_save_node(node, name, 0, 0);
> 
> Stage 2: fdt_init_reserved_mem()
> This stage of the reserved memory processing is used to iterate through
> the reserved_mem array which was populated in stage 1 and do the
> following on each of the entries:
> 
> 1) If the entry represents a statically-placed reserved memory region:
>    - Call the region specific init function.
> 2) If the entry represents a dynamically-placed reserved memory region:
>    - Call __reserved_mem_alloc_size() which is used to allocate memory
>      for the region using memblock_phys_alloc_range(), and call
>      memblock_mark_nomap() on the allocated region if the region is
>      specified as a no-map region.
>    - Call the region specific init function.
> 
> On architectures such as arm64, the dynamic allocation of the
> reserved_mem array needs to be done after the page tables have been
> setup because memblock allocated memory is not writable until then. This
> means that the reserved_mem array will not be available to store any
> reserved memory information until after the page tables have been setup.
> 
> It is possible to call memblock_reserve() and memblock_mark_nomap() on
> the statically-placed reserved memory regions and not need to save them
> to the reserved_mem array until later. This is because all the
> information we need is present in the devicetree.
> Dynamically-placed reserved memory regions on the other hand get
> assigned a start address only at runtime, and since memblock_reserve()
> and memblock_mark_nomap() need to be called before the memory mappings
> are created, the allocation needs to happen before the page tables are
> setup.
> 
> To make it easier to handle dynamically-placed reserved memory regions
> before the page tables are setup, this patch makes changes to the steps
> above to process the reserved memory regions in the following ways:
> 
> Step 1: fdt_scan_reserved_mem()
> This stage of the reserved memory processing is used to scan through the
> reserved memory nodes defined in the devicetree and do the following on
> each of the nodes:
> 
> 1) If the node represents a statically-placed reserved memory region,
>    i.e. it is defined using the "reg" property:
>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
> 
> 2) If the node represents a dynamically-placed reserved memory region,
>    i.e. it is defined using "alloc-ranges" and "size" properties:
>    - Call __reserved_mem_alloc_size() which will:
>      i) Allocate memory for the reserved memory region.
>      ii) Call memblock_mark_nomap() as needed.
>      Note: There is no need to explicitly call memblock_reserve() here
>      because it is already called by memblock when the memory for the
>      region is being allocated.
>      iii) Save the information for the region in the reserved_mem array.
> 
> Step 2: fdt_init_reserved_mem()
> This stage of the reserved memory processing is used to:
> 
> 1) Add the information for the statically-placed reserved memory into
>    the reserved_mem array.
> 
> 2) Iterate through all the entries in the array and call the region
>    specific init function for each of them.
> 
> fdt_init_reserved_mem() is also now called from within the
> unflatten_device_tree() function so that this step happens after the
> page tables have been setup.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>

I am seeing a warning when booting aspeed_g5_defconfig in QEMU that I
bisected to this change in -next as commit a46cccb0ee2d ("of:
reserved_mem: Restruture how the reserved memory regions are
processed").

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- aspeed_g5_defconfig zImage aspeed/aspeed-bmc-opp-romulus.dtb

$ qemu-system-arm \
    -display none \
    -nodefaults \
    -no-reboot \
    -machine romulus-bmc \
    -dtb arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dtb \
    -kernel arch/arm/boot/zImage \
    -initrd rootfs.cpio \
    -m 512m \
    -serial mon:stdio
...
[    0.000000] Linux version 6.10.0-rc1-00007-ga46cccb0ee2d (nathan@thelio-3990X) (arm-linux-gnueabi-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP Mon Jun 10 14:20:06 MST 2024
...
[    0.623194] [drm] Initialized aspeed-gfx-drm 1.0.0 20180319 for 1e6e6000.display on minor 0
[    0.636348] ------------[ cut here ]------------
[    0.636613] WARNING: CPU: 0 PID: 1 at mm/memory.c:2789 __apply_to_page_range+0x360/0x380
[    0.637601] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc1-00007-ga46cccb0ee2d #1
[    0.638001] Hardware name: Generic DT based system
[    0.638298] Call trace:
[    0.638743]  unwind_backtrace from show_stack+0x18/0x1c
[    0.639163]  show_stack from dump_stack_lvl+0x54/0x68
[    0.639374]  dump_stack_lvl from __warn+0x74/0x114
[    0.639590]  __warn from warn_slowpath_fmt+0x13c/0x1c0
[    0.639855]  warn_slowpath_fmt from __apply_to_page_range+0x360/0x380
[    0.640110]  __apply_to_page_range from apply_to_page_range+0x24/0x2c
[    0.640356]  apply_to_page_range from __alloc_from_contiguous+0xc4/0x158
[    0.640619]  __alloc_from_contiguous from cma_allocator_alloc+0x3c/0x44
[    0.640870]  cma_allocator_alloc from arch_dma_alloc+0x128/0x2b4
[    0.641100]  arch_dma_alloc from dma_alloc_attrs+0x90/0x150
[    0.641318]  dma_alloc_attrs from drm_gem_dma_create+0xa4/0x13c
[    0.641553]  drm_gem_dma_create from drm_gem_dma_create_with_handle+0x24/0xac
[    0.641833]  drm_gem_dma_create_with_handle from drm_gem_dma_dumb_create+0x44/0x50
[    0.642122]  drm_gem_dma_dumb_create from drm_client_framebuffer_create+0x9c/0x164
[    0.642410]  drm_client_framebuffer_create from drm_fbdev_dma_helper_fb_probe+0x84/0x23c
[    0.642724]  drm_fbdev_dma_helper_fb_probe from __drm_fb_helper_initial_config_and_unlock+0x2e4/0x4f8
[    0.643076]  __drm_fb_helper_initial_config_and_unlock from drm_fbdev_dma_client_hotplug+0x74/0xb8
[    0.643416]  drm_fbdev_dma_client_hotplug from drm_client_register+0x5c/0x98
[    0.643696]  drm_client_register from aspeed_gfx_probe+0x278/0x3c0
[    0.643935]  aspeed_gfx_probe from platform_probe+0x60/0xb8
[    0.644192]  platform_probe from really_probe+0xd4/0x3b4
[    0.644434]  really_probe from __driver_probe_device+0x90/0x1dc
[    0.644697]  __driver_probe_device from driver_probe_device+0x38/0xd0
[    0.644978]  driver_probe_device from __driver_attach+0x118/0x1dc
[    0.645246]  __driver_attach from bus_for_each_dev+0x84/0xd4
[    0.645498]  bus_for_each_dev from bus_add_driver+0xec/0x1f0
[    0.645755]  bus_add_driver from driver_register+0x84/0x11c
[    0.645999]  driver_register from do_one_initcall+0x84/0x1c8
[    0.646351]  do_one_initcall from kernel_init_freeable+0x1a4/0x230
[    0.646624]  kernel_init_freeable from kernel_init+0x1c/0x138
[    0.646885]  kernel_init from ret_from_fork+0x14/0x28
[    0.647154] Exception stack(0x9f015fb0 to 0x9f015ff8)
[    0.647535] 5fa0:                                     00000000 00000000 00000000 00000000
[    0.647895] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.648237] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.648730] ---[ end trace 0000000000000000 ]---
[    0.653499] aspeed_gfx 1e6e6000.display: [drm] fb0: aspeed-gfx-drmd frame buffer device
...

The rootfs is from [1] if you should need it (arm-rootfs.cpio.zst,
decompress with zstd first). I am more than happy to provide any
additional information or test patches as necessary.

[1]: https://github.com/ClangBuiltLinux/boot-utils/releases

Cheers,
Nathan

# bad: [d35b2284e966c0bef3e2182a5c5ea02177dd32e4] Add linux-next specific files for 20240607
# good: [8a92980606e3585d72d510a03b59906e96755b8a] Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect start 'd35b2284e966c0bef3e2182a5c5ea02177dd32e4' '8a92980606e3585d72d510a03b59906e96755b8a'
# good: [faef37a085e57f29479f853624948cdc7df6e366] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect good faef37a085e57f29479f853624948cdc7df6e366
# good: [822946749b5f02d9f49dde4b4cb8f2535c247ce5] Merge branch 'drm-xe-next' of https://gitlab.freedesktop.org/drm/xe/kernel
git bisect good 822946749b5f02d9f49dde4b4cb8f2535c247ce5
# bad: [9ffebdc86bc23fdf0622eb0c38d395c2b99b7f32] Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
git bisect bad 9ffebdc86bc23fdf0622eb0c38d395c2b99b7f32
# bad: [9a85e49be89a9150fd2ec9964f48013a00c261d1] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect bad 9a85e49be89a9150fd2ec9964f48013a00c261d1
# good: [bd8c07372f9f6b8e496b7f1f0dcc287dd81c0706] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
git bisect good bd8c07372f9f6b8e496b7f1f0dcc287dd81c0706
# good: [a93b9dea60d7c46dca8de8d5180f3ceb3696ab8a] Merge branch 'apparmor-next' of git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
git bisect good a93b9dea60d7c46dca8de8d5180f3ceb3696ab8a
# good: [c1b93986dfb2a31b0528fe929d574843801089f5] spi: pxa2xx: Remove hard coded number of chip select pins
git bisect good c1b93986dfb2a31b0528fe929d574843801089f5
# good: [76a621455f7be3d9c963c8a1a27b234d27d14f16] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
git bisect good 76a621455f7be3d9c963c8a1a27b234d27d14f16
# bad: [16227bf21dff0905bfa303f8cbd9a2f7ca51f883] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
git bisect bad 16227bf21dff0905bfa303f8cbd9a2f7ca51f883
# good: [77b023ba4f45ce2bf26edb095b4a81829c9e621b] media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G2UL CSI-2 block
git bisect good 77b023ba4f45ce2bf26edb095b4a81829c9e621b
# bad: [b8ffe4a11001660522ccc5b2cc892cf8aa03a62e] of: reserved_mem: Add code to dynamically allocate reserved_mem array
git bisect bad b8ffe4a11001660522ccc5b2cc892cf8aa03a62e
# bad: [a46cccb0ee2d62206f6db5e3b85fdd9e2760ee1a] of: reserved_mem: Restruture how the reserved memory regions are processed
git bisect bad a46cccb0ee2d62206f6db5e3b85fdd9e2760ee1a
# good: [83138f8fb798627531be3b5627af4a6008a7bbd6] media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G2UL CRU block
git bisect good 83138f8fb798627531be3b5627af4a6008a7bbd6
# first bad commit: [a46cccb0ee2d62206f6db5e3b85fdd9e2760ee1a] of: reserved_mem: Restruture how the reserved memory regions are processed
