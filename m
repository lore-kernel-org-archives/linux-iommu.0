Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81EC14F;
	Wed, 26 Jun 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414985; cv=none; b=tH2s73X/HYY1jepOWjjWfWXkGtW6HpIN3lRMFRE1h64i9JBxsZ30F2xFhD8WDVhlYaQV+/NENDqt7uyEb+/nKiKiGzO5GfagsoyISNQ9xqybdnHD+s1rWyyxEQhAfqpqj9qU5oG9dbpdLt1cqibw04fggzPvC9FN6fxi01TYJew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414985; c=relaxed/simple;
	bh=6GNBJ+7jHRYD1oE2SiKaXDu31KTzkNF12N1DEiP7LhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ0Ple0YYAeeZZZkk3gbsNmMhWDAQv8SjF6bnYoO0Qbqua5yAA9hzfhuGV9T+X4FjzyR+gusTio+toU3vyfe8WWPVrOWFgTO+8koZ7nD0EdqYfMd3yU/dZK5VigRV1wUlFUoV0hI+b/yw2LXDI6e72uakvoFtU36fySrWfB6N6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACLGUs5/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACLGUs5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB53C116B1;
	Wed, 26 Jun 2024 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414984;
	bh=6GNBJ+7jHRYD1oE2SiKaXDu31KTzkNF12N1DEiP7LhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACLGUs5/j6UrxCJOi41ZfiWpeKwtmeNO1jl0fvJwo2lWW6F2lHavOaL7AMRMu7EpP
	 gLK9q6yzhpaQbwgpgesZRerhYV9/VdvJuoHzafTYOxZoCYx+Hu2ByOi3wFI+82vQT+
	 VQOLObGZ3Y2wtXKVMdUQgx6oyrsTJSAIv/tF9UXn8fi60PIdAbNbQEi5ZIdSLeUMHT
	 R8hr/YuYfmvxcWxSm7sWqlx7LR7dWk+S7YBdxKJvRt200iCiUnwVU1fUbHpo8jh8y/
	 AkIUXxkKCeawUDhARiIuKFTogzHPUauot/me/3Qax3ZXZgKCs+tV+9evb7EibxNpUg
	 nRQffMAddW9hQ==
Date: Wed, 26 Jun 2024 09:16:22 -0600
From: Rob Herring <robh@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: broonie@kernel.org, catalin.marinas@arm.com, conor@kernel.org,
	devicetree@vger.kernel.org, hch@lst.de, iommu@lists.linux.dev,
	kernel@quicinc.com, linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com, nathan@kernel.org,
	oe-kbuild-all@lists.linux.dev, robin.murphy@arm.com,
	saravanak@google.com, will@kernel.org
Subject: Re: [PATCH v2] of: reserved_mem: Restructure code to call reserved
 mem init functions earlier
Message-ID: <20240626151622.GA3139921-robh@kernel.org>
References: <202406181626.126X1Nbz-lkp@intel.com>
 <20240620001027.2326275-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620001027.2326275-1-quic_obabatun@quicinc.com>

On Wed, Jun 19, 2024 at 05:10:27PM -0700, Oreoluwa Babatunde wrote:
> After all the reserved memory regions have been added to the
> reserved_mem array, a region specific initialization function is called
> on each of reserved memory regions in a loop to initialize them.
> 
> With recent changes made to allow the reserved_mem array be dynamically
> allocated, the cma reserved memory regions are not initialized until
> after the page tables are setup. This causes the warning seen in the
> dump stack below:
> 
> 	WARNING: CPU: 0 PID: 1 at mm/memory.c:2789 __apply_to_page_range+0x360/0x380
> 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc1-00007-ga46cccb0ee2d #1
> 	Hardware name: Generic DT based system
> 	Call trace:
> 	unwind_backtrace from show_stack+0x18/0x1c
> 	show_stack from dump_stack_lvl+0x54/0x68
> 	dump_stack_lvl from __warn+0x74/0x114
> 	__warn from warn_slowpath_fmt+0x13c/0x1c0
> 	warn_slowpath_fmt from __apply_to_page_range+0x360/0x380
> 	__apply_to_page_range from apply_to_page_range+0x24/0x2c
> 	apply_to_page_range from __alloc_from_contiguous+0xc4/0x158
> 	__alloc_from_contiguous from cma_allocator_alloc+0x3c/0x44
> 	cma_allocator_alloc from arch_dma_alloc+0x128/0x2b4
> 	arch_dma_alloc from dma_alloc_attrs+0x90/0x150
> 	dma_alloc_attrs from drm_gem_dma_create+0xa4/0x13c
> 	drm_gem_dma_create from drm_gem_dma_create_with_handle+0x24/0xac
> 	drm_gem_dma_create_with_handle from drm_gem_dma_dumb_create+0x44/0x50
> 	drm_gem_dma_dumb_create from drm_client_framebuffer_create+0x9c/0x164
> 	drm_client_framebuffer_create from drm_fbdev_dma_helper_fb_probe+0x84/0x23c
> 	drm_fbdev_dma_helper_fb_probe from __drm_fb_helper_initial_config_and_unlock+0x2e4/0x4f8
> 	__drm_fb_helper_initial_config_and_unlock from drm_fbdev_dma_client_hotplug+0x74/0xb8
> 	drm_fbdev_dma_client_hotplug from drm_client_register+0x5c/0x98
> 	drm_client_register from aspeed_gfx_probe+0x278/0x3c0
> 	aspeed_gfx_probe from platform_probe+0x60/0xb8
> 	platform_probe from really_probe+0xd4/0x3b4
> 	really_probe from __driver_probe_device+0x90/0x1dc
> 	__driver_probe_device from driver_probe_device+0x38/0xd0
> 	driver_probe_device from __driver_attach+0x118/0x1dc
> 	__driver_attach from bus_for_each_dev+0x84/0xd4
> 	bus_for_each_dev from bus_add_driver+0xec/0x1f0
> 	bus_add_driver from driver_register+0x84/0x11c
> 	driver_register from do_one_initcall+0x84/0x1c8
> 	do_one_initcall from kernel_init_freeable+0x1a4/0x230
> 	kernel_init_freeable from kernel_init+0x1c/0x138
> 	kernel_init from ret_from_fork+0x14/0x28
> 	Exception stack(0x9f015fb0 to 0x9f015ff8)
> 	5fa0:                                     00000000 00000000 00000000 00000000
> 	5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 	5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 	---[ end trace 0000000000000000 ]---
> 	aspeed_gfx 1e6e6000.display: [drm] fb0: aspeed-gfx-drmd frame buffer device
> 
> Hence, restructure the code to initialize the regions as soon as each
> of them are added to the reserved_mem array.
> 
> Fixes: a46cccb0ee2d ("of: reserved_mem: Restruture how the reserved memory regions are processed")
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
> v2:
> - Fix kernel-doc for of_init_reserved_mem_node() in response to the
>   below warning from v1:
>   https://lore.kernel.org/all/202406181626.126X1Nbz-lkp@intel.com/
> 
> v1:
>   https://lore.kernel.org/all/20240617193357.3929092-1-quic_obabatun@quicinc.com/
> 
>  drivers/of/fdt.c             |  2 +-
>  drivers/of/of_private.h      |  2 +-
>  drivers/of/of_reserved_mem.c | 83 +++++++++++++++++++++---------------
>  3 files changed, 50 insertions(+), 37 deletions(-)

Applied.

In the future, do not send fixes or new versions as replies to previous 
threads. The default behavior of b4 is to apply v6 of the series because 
that is the 'newest' version.

Rob
