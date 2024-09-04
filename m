Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C41DC078;
	Wed,  4 Sep 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461982; cv=none; b=fB6vZiLpBP6QtlkoT7YKo92zJtuSb8Yg4TtmnRaIBdQF3j254bCf1MwSBoWLBKwEm8nFDMg8dXE2ImkI2N2dKrZ4zJcQz4XonWelqStj1CZSc359oxyTU/xaH14g7Xu/wDlpBIgSSaFdBUdcOmVjU/1tibA6XuKcg1c6HOh7QZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461982; c=relaxed/simple;
	bh=un8Ep5MZe8u3hniH8cbxJUJwLU4jDlXGHUAN0L4HI0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEjkWnPrbiCHiFR8F3kQI9diMjmDRevZaA3Mdm6SxJ9w/l5UmP4JT+RDK+eI/pzhaZC25tyae1oLVNvF7hb5pOAZ0SxLxxnmjEYvczHy5bqNOUG/mIDhRkLjFIA8ZarmaY56yYJGaLTu9FNf+4BgjL315kTEQGJTdUuDP0qBNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dk0Gkft5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dk0Gkft5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725461977;
	bh=un8Ep5MZe8u3hniH8cbxJUJwLU4jDlXGHUAN0L4HI0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk0Gkft5rcrtZdfjiqMcr0oDrSCNuMgFxap/sNFLJnMvND2nKf/va+cLk+PgpQ9+v
	 LqZXFZgFksy7UC/S5B14DKgBe9ZFbbVz0TJuRht+rmCIqngELplbLyiatEW0iJ15qO
	 /XSsHXg3jf2ESrN58o8eNQQB+9O5tp0CwpWXBL5FFfP9ozQcvYphLul7KLci7uonX8
	 jMtGd8Bm7gRcpKatdpycE6VuvKZTi/8hDBW+cTbnQMrCS9MICx5657lQK3O/Pd6wlc
	 EONQTVN/jqynTCVTUneFQbc82988ILWzeXKCwKpvxoYCkBO3Ko2V/oZenwET+CWprs
	 NT1nnCMEQx6sg==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8C8D817E1167;
	Wed,  4 Sep 2024 16:59:35 +0200 (CEST)
Date: Wed, 4 Sep 2024 10:59:33 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	regressions@lists.linux.dev, kernelci@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <10431dfd-ce04-4e0f-973b-c78477303c18@notapiano>
References: <cover.1721818168.git.leon@kernel.org>
 <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>

On Wed, Jul 24, 2024 at 09:04:49PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Most of the arch DMA ops (which often, but not always, involve
> some sort of IOMMU) are using the same DMA operations, but for all
> modern platforms dma-iommu implementation is really matters.
> 
> So let's make sure to call them directly without need to perform
> function pointers dereference.
> 
> During system initialization, the arch can set its own DMA and in such
> case, the default DMA operations will be overridden.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> ---

Hi,

KernelCI has identified a boot regression originating from this patch. I've
verified that reverting the patch fixes the issue.

Affected platforms:
* sc7180-trogdor-kingoftown
* sc7180-trogdor-lazor-limozeen

Relevant kernel log:

[    5.790809] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000040
[    5.799844] Mem abort info:
[    5.799846]   ESR = 0x0000000096000006
[    5.808708]   EC = 0x25: DABT (current EL), IL = 32 bits
[    5.808712]   SET = 0, FnV = 0
[    5.808714]   EA = 0, S1PTW = 0
[    5.818465]   FSC = 0x06: level 2 translation fault
[    5.818468] Data abort info:
[    5.818469]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[    5.827063]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    5.827065]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    5.838768] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000d20bb000
[    5.838771] [0000000000000040] pgd=08000000d20c1003
[    5.863071] , p4d=08000000d20c1003
[    5.898011] , pud=08000000d20c2003, pmd=0000000000000000
[    5.898014] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[    5.898016] Modules linked in: ipv6 hci_uart venus_core btqca v4l2_mem2mem btrtl qcom_spmi_adc5 sbs_battery btbcm qcom_vadc_common cros_ec_typec videobuf2_v4l2 leds_cros_ec cros_kbd_led_backlight cros_ec_chardev videodev elan_i2c videobuf2_common qcom_stats mc bluetooth coresight_stm stm_core ecdh_generic ecc pwrseq_core panel_edp icc_bwmon ath10k_snoc ath10k_core ath mac80211 phy_qcom_qmp_combo aux_bridge libarc4 coresight_replicator coresight_etm4x coresight_tmc coresight_funnel cfg80211 rfkill coresight qcom_wdt cbmem ramoops reed_solomon pwm_bl coreboot_table backlight crct10dif_ce
[    5.898057] CPU: 7 UID: 0 PID: 70 Comm: kworker/u32:4 Not tainted 6.11.0-rc6-next-20240903-00003-gdfc6015d0711 #660
[    5.898061] Hardware name: Google Lazor Limozeen without Touchscreen (rev5 - rev8) (DT)
[    5.898062] Workqueue: events_unbound deferred_probe_work_func
[    5.904227] hub 2-1:1.0: 4 ports detected
[    5.906827]
[    5.906828] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    5.906831] pc : dma_common_alloc_pages+0x54/0x1b4
[    5.906837] lr : dma_common_alloc_pages+0x4c/0x1b4
[    5.906839] sp : ffff8000807d3730
[    5.906840] x29: ffff8000807d3730 x28: ffff02a7d312f880 x27: 0000000000000001
[    5.906843] x26: 000000000000c000 x25: 0000000000000000 x24: 0000000000000001
[    5.906845] x23: ffff02a7d23b6898 x22: 0000000000006cc0 x21: 000000000000c000
[    5.906847] x20: ffff02a7858bf410 x19: fffffe0a60006000 x18: 0000000000000001
[    5.906850] x17: 00000000000000d5 x16: 1fffe054f0bcc261 x15: 0000000000000001
[    5.906852] x14: ffff02a7844dc680 x13: 0000000000100180 x12: dead000000000100
[    5.906855] x11: dead000000000122 x10: 00000000001001ff x9 : ffff02a87f7b7b00
[    5.906857] x8 : ffff02a87f7b7b00 x7 : ffff405977d6b000 x6 : ffff8000807d3310
[    5.906860] x5 : ffff02a87f6b6398 x4 : 0000000000000001 x3 : ffff405977d6b000
[    6.092491] x2 : ffff02a7844dc600 x1 : 0000000100000000 x0 : fffffe0a60006000
[    6.099809] Call trace:
[    6.102327]  dma_common_alloc_pages+0x54/0x1b4
[    6.106895]  __dma_alloc_pages+0x68/0x90
[    6.110921]  dma_alloc_pages+0x10/0x1c
[    6.114772]  snd_dma_noncoherent_alloc+0x28/0x8c
[    6.119514]  __snd_dma_alloc_pages+0x30/0x50
[    6.123897]  snd_dma_alloc_dir_pages+0x40/0x80
[    6.128465]  do_alloc_pages+0xb8/0x13c
[    6.132315]  preallocate_pcm_pages+0x6c/0xf8
[    6.132317]  preallocate_pages+0x160/0x1a4
[    6.132319]  snd_pcm_set_managed_buffer_all+0x64/0xb0
[    6.152964]  lpass_platform_pcm_new+0xc0/0xe8
[    6.157443]  snd_soc_pcm_component_new+0x3c/0xc8
[    6.162184]  soc_new_pcm+0x4fc/0x668
[    6.165853]  snd_soc_bind_card+0xabc/0xbac
[    6.170063]  snd_soc_register_card+0xf0/0x108
[    6.174533]  devm_snd_soc_register_card+0x4c/0xa4
[    6.179361]  sc7180_snd_platform_probe+0x180/0x224
[    6.184285]  platform_probe+0x68/0xc0
[    6.188050]  really_probe+0xbc/0x298
[    6.191717]  __driver_probe_device+0x78/0x12c
[    6.196186]  driver_probe_device+0x3c/0x15c
[    6.200481]  __device_attach_driver+0xb8/0x134
[    6.205047]  bus_for_each_drv+0x84/0xe0
[    6.208985]  __device_attach+0x9c/0x188
[    6.212924]  device_initial_probe+0x14/0x20
[    6.217219]  bus_probe_device+0xac/0xb0
[    6.221157]  deferred_probe_work_func+0x88/0xc0
[    6.225810]  process_one_work+0x14c/0x28c
[    6.229923]  worker_thread+0x2cc/0x3d4
[    6.233773]  kthread+0x114/0x118
[    6.237093]  ret_from_fork+0x10/0x20
[    6.240763] Code: f9411c19 940000c9 aa0003f3 b4000460 (f9402326)
[    6.247012] ---[ end trace 0000000000000000 ]---

See below for the suspicious hunk.

[..]
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 6832fd6f0796..02451e27e0b1 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
[..]
> @@ -611,6 +662,8 @@ static struct page *__dma_alloc_pages(struct device *dev, size_t size,
>  	size = PAGE_ALIGN(size);
>  	if (dma_alloc_direct(dev, ops))
>  		return dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
> +	if (use_dma_iommu(dev))
> +		return dma_common_alloc_pages(dev, size, dma_handle, dir, gfp);

Is this check correct? dma_common_alloc_pages uses the dma_ops, but the comment
in dma_iommu said it meant that dma_ops wouldn't be used.

And similarly for dma_common_free_pages below.

>  	if (!ops->alloc_pages_op)
>  		return NULL;
>  	return ops->alloc_pages_op(dev, size, dma_handle, dir, gfp);
> @@ -635,6 +688,8 @@ static void __dma_free_pages(struct device *dev, size_t size, struct page *page,
>  	size = PAGE_ALIGN(size);
>  	if (dma_alloc_direct(dev, ops))
>  		dma_direct_free_pages(dev, size, page, dma_handle, dir);
> +	else if (use_dma_iommu(dev))
> +		dma_common_free_pages(dev, size, page, dma_handle, dir);
>  	else if (ops->free_pages)
>  		ops->free_pages(dev, size, page, dma_handle, dir);
>  }
[..]

Please add
Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
when fixing this.

Happy to provide any other details necessary.

#regzbot introduced: next-20240822..20240823
#regzbot title: Null pointer dereference in dma_common_alloc_pages() for sc7180 platforms

Thanks,
Nícolas
