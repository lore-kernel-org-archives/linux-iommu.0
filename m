Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE43F2AE9F;
	Wed,  4 Sep 2024 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472926; cv=none; b=hSWwDxNxnwT1cWIqaeKqFzUqXsqbcm+EzBkoqiWrsBrGZ5UvLRbOXFihIKc9rUveGrlGnUf8B2YkWU8JwgIsZj5FU+Chn33CgN6ICI/J9vXt52x28G5zUUmeHZIedwoVUk3bcDJ8+Kzo2wfe0ByyilVr8RZSGXC4HDn/KFKcDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472926; c=relaxed/simple;
	bh=UMPt90iX+zouFx9RY9Xx20PaJkUiEYb81VHFcIzRgzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMZyJDpWQduJ1b0dCez5WMd+zAxpK9b9UEQeO3hVUWmoSc6XT15/2kJViU9FFdEsr9IQ3q+M9jpL7jPiad7yppvxjr18kNXKsBhZHgC1m55R0et5+5KcWSxbgJVAovkLpDJUV9Fh3J8J1UirMy12N4ykXZlZcWt9Ab0UXiW29yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSS0SXD8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSS0SXD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9795BC4CEC2;
	Wed,  4 Sep 2024 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725472926;
	bh=UMPt90iX+zouFx9RY9Xx20PaJkUiEYb81VHFcIzRgzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSS0SXD87TcCL1Pq5Owr4FF0VOuFtE6qasNAwaKG2IyDZwSM8LZ+Cy+RPWti5TQYy
	 WSYv3BHvUjiSi5M7sXFPhBH/CZJv6h8mNic8uGPWHyhUERCK/kYem+Fa4LIP0z1/xx
	 EHWKhVsuv+LWu3S0rutgMo8f4VOY9gnPmc37Ujwsr2G5syycEJRIiJZ8wqYqCdkOz1
	 F1jyKVrdPEjhGwJplcWBFfBr1iZZT22IdH7B+hJLA/hZgFCssF6fw94ni/DgQMqdrF
	 0zhTiMbQ+bl3Bll6bjtK3ypkT1qkVDfscvXZLo9FeZtRCpqHZLBZrsl8PLPN1MKI2C
	 WJfcXEI0kwpPw==
Date: Wed, 4 Sep 2024 21:02:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	regressions@lists.linux.dev, kernelci@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <20240904180201.GQ4026@unreal>
References: <cover.1721818168.git.leon@kernel.org>
 <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>
 <10431dfd-ce04-4e0f-973b-c78477303c18@notapiano>
 <20240904154529.GP4026@unreal>
 <7e8a6a4e-eb9e-438b-a366-f95de4e88bf8@notapiano>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e8a6a4e-eb9e-438b-a366-f95de4e88bf8@notapiano>

On Wed, Sep 04, 2024 at 01:58:16PM -0400, Nícolas F. R. A. Prado wrote:
> On Wed, Sep 04, 2024 at 06:45:29PM +0300, Leon Romanovsky wrote:
> > On Wed, Sep 04, 2024 at 10:59:33AM -0400, Nícolas F. R. A. Prado wrote:
> > > On Wed, Jul 24, 2024 at 09:04:49PM +0300, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > Most of the arch DMA ops (which often, but not always, involve
> > > > some sort of IOMMU) are using the same DMA operations, but for all
> > > > modern platforms dma-iommu implementation is really matters.
> > > > 
> > > > So let's make sure to call them directly without need to perform
> > > > function pointers dereference.
> > > > 
> > > > During system initialization, the arch can set its own DMA and in such
> > > > case, the default DMA operations will be overridden.
> > > > 
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leon@kernel.org>
> > > > ---
> > > 
> > > Hi,
> > > 
> > > KernelCI has identified a boot regression originating from this patch. I've
> > > verified that reverting the patch fixes the issue.
> > > 
> > > Affected platforms:
> > > * sc7180-trogdor-kingoftown
> > > * sc7180-trogdor-lazor-limozeen
> > > 
> > > Relevant kernel log:
> > > 
> > > [    5.790809] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000040
> > > [    5.799844] Mem abort info:
> > > [    5.799846]   ESR = 0x0000000096000006
> > > [    5.808708]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [    5.808712]   SET = 0, FnV = 0
> > > [    5.808714]   EA = 0, S1PTW = 0
> > > [    5.818465]   FSC = 0x06: level 2 translation fault
> > > [    5.818468] Data abort info:
> > > [    5.818469]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
> > > [    5.827063]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > > [    5.827065]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > [    5.838768] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000d20bb000
> > > [    5.838771] [0000000000000040] pgd=08000000d20c1003
> > > [    5.863071] , p4d=08000000d20c1003
> > > [    5.898011] , pud=08000000d20c2003, pmd=0000000000000000
> > > [    5.898014] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> > > [    5.898016] Modules linked in: ipv6 hci_uart venus_core btqca v4l2_mem2mem btrtl qcom_spmi_adc5 sbs_battery btbcm qcom_vadc_common cros_ec_typec videobuf2_v4l2 leds_cros_ec cros_kbd_led_backlight cros_ec_chardev videodev elan_i2c videobuf2_common qcom_stats mc bluetooth coresight_stm stm_core ecdh_generic ecc pwrseq_core panel_edp icc_bwmon ath10k_snoc ath10k_core ath mac80211 phy_qcom_qmp_combo aux_bridge libarc4 coresight_replicator coresight_etm4x coresight_tmc coresight_funnel cfg80211 rfkill coresight qcom_wdt cbmem ramoops reed_solomon pwm_bl coreboot_table backlight crct10dif_ce
> > > [    5.898057] CPU: 7 UID: 0 PID: 70 Comm: kworker/u32:4 Not tainted 6.11.0-rc6-next-20240903-00003-gdfc6015d0711 #660
> > > [    5.898061] Hardware name: Google Lazor Limozeen without Touchscreen (rev5 - rev8) (DT)
> > > [    5.898062] Workqueue: events_unbound deferred_probe_work_func
> > > [    5.904227] hub 2-1:1.0: 4 ports detected
> > > [    5.906827]
> > > [    5.906828] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [    5.906831] pc : dma_common_alloc_pages+0x54/0x1b4
> > > [    5.906837] lr : dma_common_alloc_pages+0x4c/0x1b4
> > > [    5.906839] sp : ffff8000807d3730
> > > [    5.906840] x29: ffff8000807d3730 x28: ffff02a7d312f880 x27: 0000000000000001
> > > [    5.906843] x26: 000000000000c000 x25: 0000000000000000 x24: 0000000000000001
> > > [    5.906845] x23: ffff02a7d23b6898 x22: 0000000000006cc0 x21: 000000000000c000
> > > [    5.906847] x20: ffff02a7858bf410 x19: fffffe0a60006000 x18: 0000000000000001
> > > [    5.906850] x17: 00000000000000d5 x16: 1fffe054f0bcc261 x15: 0000000000000001
> > > [    5.906852] x14: ffff02a7844dc680 x13: 0000000000100180 x12: dead000000000100
> > > [    5.906855] x11: dead000000000122 x10: 00000000001001ff x9 : ffff02a87f7b7b00
> > > [    5.906857] x8 : ffff02a87f7b7b00 x7 : ffff405977d6b000 x6 : ffff8000807d3310
> > > [    5.906860] x5 : ffff02a87f6b6398 x4 : 0000000000000001 x3 : ffff405977d6b000
> > > [    6.092491] x2 : ffff02a7844dc600 x1 : 0000000100000000 x0 : fffffe0a60006000
> > > [    6.099809] Call trace:
> > > [    6.102327]  dma_common_alloc_pages+0x54/0x1b4
> > > [    6.106895]  __dma_alloc_pages+0x68/0x90
> > > [    6.110921]  dma_alloc_pages+0x10/0x1c
> > > [    6.114772]  snd_dma_noncoherent_alloc+0x28/0x8c
> > > [    6.119514]  __snd_dma_alloc_pages+0x30/0x50
> > > [    6.123897]  snd_dma_alloc_dir_pages+0x40/0x80
> > > [    6.128465]  do_alloc_pages+0xb8/0x13c
> > > [    6.132315]  preallocate_pcm_pages+0x6c/0xf8
> > > [    6.132317]  preallocate_pages+0x160/0x1a4
> > > [    6.132319]  snd_pcm_set_managed_buffer_all+0x64/0xb0
> > > [    6.152964]  lpass_platform_pcm_new+0xc0/0xe8
> > > [    6.157443]  snd_soc_pcm_component_new+0x3c/0xc8
> > > [    6.162184]  soc_new_pcm+0x4fc/0x668
> > > [    6.165853]  snd_soc_bind_card+0xabc/0xbac
> > > [    6.170063]  snd_soc_register_card+0xf0/0x108
> > > [    6.174533]  devm_snd_soc_register_card+0x4c/0xa4
> > > [    6.179361]  sc7180_snd_platform_probe+0x180/0x224
> > > [    6.184285]  platform_probe+0x68/0xc0
> > > [    6.188050]  really_probe+0xbc/0x298
> > > [    6.191717]  __driver_probe_device+0x78/0x12c
> > > [    6.196186]  driver_probe_device+0x3c/0x15c
> > > [    6.200481]  __device_attach_driver+0xb8/0x134
> > > [    6.205047]  bus_for_each_drv+0x84/0xe0
> > > [    6.208985]  __device_attach+0x9c/0x188
> > > [    6.212924]  device_initial_probe+0x14/0x20
> > > [    6.217219]  bus_probe_device+0xac/0xb0
> > > [    6.221157]  deferred_probe_work_func+0x88/0xc0
> > > [    6.225810]  process_one_work+0x14c/0x28c
> > > [    6.229923]  worker_thread+0x2cc/0x3d4
> > > [    6.233773]  kthread+0x114/0x118
> > > [    6.237093]  ret_from_fork+0x10/0x20
> > > [    6.240763] Code: f9411c19 940000c9 aa0003f3 b4000460 (f9402326)
> > > [    6.247012] ---[ end trace 0000000000000000 ]---
> > > 
> > > See below for the suspicious hunk.
> > > 
> > > [..]
> > > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > > index 6832fd6f0796..02451e27e0b1 100644
> > > > --- a/kernel/dma/mapping.c
> > > > +++ b/kernel/dma/mapping.c
> > > [..]
> > > > @@ -611,6 +662,8 @@ static struct page *__dma_alloc_pages(struct device *dev, size_t size,
> > > >  	size = PAGE_ALIGN(size);
> > > >  	if (dma_alloc_direct(dev, ops))
> > > >  		return dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
> > > > +	if (use_dma_iommu(dev))
> > > > +		return dma_common_alloc_pages(dev, size, dma_handle, dir, gfp);
> > > 
> > > Is this check correct? dma_common_alloc_pages uses the dma_ops, but the comment
> > > in dma_iommu said it meant that dma_ops wouldn't be used.
> > > 
> > > And similarly for dma_common_free_pages below.
> > > 
> > > >  	if (!ops->alloc_pages_op)
> > > >  		return NULL;
> > > >  	return ops->alloc_pages_op(dev, size, dma_handle, dir, gfp);
> > > > @@ -635,6 +688,8 @@ static void __dma_free_pages(struct device *dev, size_t size, struct page *page,
> > > >  	size = PAGE_ALIGN(size);
> > > >  	if (dma_alloc_direct(dev, ops))
> > > >  		dma_direct_free_pages(dev, size, page, dma_handle, dir);
> > > > +	else if (use_dma_iommu(dev))
> > > > +		dma_common_free_pages(dev, size, page, dma_handle, dir);
> > > >  	else if (ops->free_pages)
> > > >  		ops->free_pages(dev, size, page, dma_handle, dir);
> > > >  }
> > > [..]
> > > 
> > > Please add
> > > Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> > > when fixing this.
> > > 
> > > Happy to provide any other details necessary.
> > 
> > Thanks for the report, can you try the following patch?
> > I'll prepare patch later today.
> > 
> > diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
> > index af4a6ef48ce0..7e2b36cba61e 100644
> > --- a/kernel/dma/ops_helpers.c
> > +++ b/kernel/dma/ops_helpers.c
> > @@ -4,6 +4,7 @@
> >   * the allocated memory contains normal pages in the direct kernel mapping.
> >   */
> >  #include <linux/dma-map-ops.h>
> > +#include <linux/iommu-dma.h>
> >  
> >  static struct page *dma_common_vaddr_to_page(void *cpu_addr)
> >  {
> > @@ -70,8 +71,12 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
> >  	if (!page)
> >  		return NULL;
> >  
> > -	*dma_handle = ops->map_page(dev, page, 0, size, dir,
> > -				    DMA_ATTR_SKIP_CPU_SYNC);
> > +	if (dev->dma_iommu)
> > +		*dma_handle = iommu_dma_map_page(dev, page, 0, size, dir,
> > +						 DMA_ATTR_SKIP_CPU_SYNC);
> > +	else
> > +		*dma_handle = ops->map_page(dev, page, 0, size, dir,
> > +					    DMA_ATTR_SKIP_CPU_SYNC);
> >  	if (*dma_handle == DMA_MAPPING_ERROR) {
> >  		dma_free_contiguous(dev, page, size);
> >  		return NULL;
> > @@ -86,7 +91,10 @@ void dma_common_free_pages(struct device *dev, size_t size, struct page *page,
> >  {
> >  	const struct dma_map_ops *ops = get_dma_ops(dev);
> >  
> > -	if (ops->unmap_page)
> > +	if (dev->dma_iommu)
> > +		iommu_dma_unmap_page(dev, dma_handle, size, dir,
> > +				     DMA_ATTR_SKIP_CPU_SYNC);
> > +	else if (ops->unmap_page)
> >  		ops->unmap_page(dev, dma_handle, size, dir,
> >  				DMA_ATTR_SKIP_CPU_SYNC);
> >  	dma_free_contiguous(dev, page, size);
> 
> Hi,
> 
> Indeed this patch fixes the issue.
> 
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks a lot for the quick test, I'll prepare the patch and send it.

> 
> Thanks,
> Nícolas
