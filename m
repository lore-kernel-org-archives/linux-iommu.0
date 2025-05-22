Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A11C5499;
	Thu, 22 May 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907993; cv=none; b=ugPp7rLpmaxmLQT2HZd1KQ+30vIMmnRDeJubZ5kBbUrv9CTB61pvsFyRGV0ITAPcBM93hI0zRReyhyQ1nF6tGvWdF4pL6d1GaXqQf41PI2+ghWtWiir2NnTaND+Cj9JNlYzVrZBF9F/vj62mQfIKt3X51KUZnDEfzFsRkDAIbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907993; c=relaxed/simple;
	bh=x8CYXIzaf4EKaaDd6/bDNuyCNj4yw8LM1r/2pOVDoX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcSKC0BmSxbEIkbvsW8S2xlhYtKaIILZJHjcejWnd9678hd1sCLaoxGwLePgDuWhhoAuDhAh82PRo1HHO4/kzCok0QeV6h8AlQNh3a0nehbxsKucRO4Aw5MRO5a7FmwUHdepH1K8noXIo2pWu132egbkh/b1EOTom+zG6wTQCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAqo/eO1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAqo/eO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0083DC4CEE4;
	Thu, 22 May 2025 09:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747907993;
	bh=x8CYXIzaf4EKaaDd6/bDNuyCNj4yw8LM1r/2pOVDoX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAqo/eO1C6pDU6rx7Z5KCfz+VSGQBDnkmrq99T2Lx8YwGZ/vy0FOZGgXDrdKUt7IF
	 QxEGCZ4HjF/tYTU2Z8SsjhYNNG1x3FDFZL4DBzmJWIIFDYHs+vLc4PXiDmA2xEBWkI
	 Ynl6BY3mltwIwn7DNI4cbH0lfHg433DpO2iuZptjSodD9eamIZCBXJ4ref82xB/oxH
	 o7Seeh7wWpIahu8Ykot9YnezJpCyOKeVvQdvxZ97TTw2OyQ+qHtThlxGrNPoNuwRf7
	 RECoNY9Eo6fY1EH7IBuu6ozzV/C1jisIHzGOULg0xnLG1E77u/ZkpMml4DIo4NaHPc
	 pyB/l8bFaOy1w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uI2iM-000000008G6-078y;
	Thu, 22 May 2025 11:59:50 +0200
Date: Thu, 22 May 2025 11:59:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>, regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Avoid introducing more races
Message-ID: <aC71lkTn7_xfuivy@hovoldconsulting.com>
References: <09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com>

On Tue, Mar 11, 2025 at 03:19:25PM +0000, Robin Murphy wrote:
> Although the lock-juggling is only a temporary workaround, we don't want
> it to make things avoidably worse. Jason was right to be nervous, since
> bus_iommu_probe() doesn't care *which* IOMMU instance it's probing for,
> so it probably is possible for one walk to finish a probe which a
> different walk started, thus we do want to check for that.
> 
> Also there's no need to drop the lock just to have of_iommu_configure()
> do nothing when a fwspec already exists; check that directly and avoid
> opening a window at all in that (still somewhat likely) case.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> I was rather expecting to send a v3 of "iommu: Get DT/ACPI parsing into
> the proper probe path", so I'm grateful that v2 was picked up, thanks!
> This is the difference as a fix/squash commit instead.
> ---
>  drivers/iommu/iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d824fa5166e3..c6d40abe577e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -415,13 +415,15 @@ static int iommu_init_device(struct device *dev)
>  	 * is buried in the bus dma_configure path. Properly unpicking that is
>  	 * still a big job, so for now just invoke the whole thing. The device
>  	 * already having a driver bound means dma_configure has already run and
> -	 * either found no IOMMU to wait for, or we're in its replay call right
> -	 * now, so either way there's no point calling it again.
> +	 * found no IOMMU to wait for, so there's no point calling it again.
>  	 */
> -	if (!dev->driver && dev->bus->dma_configure) {
> +	if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
>  		mutex_unlock(&iommu_probe_device_lock);
>  		dev->bus->dma_configure(dev);
>  		mutex_lock(&iommu_probe_device_lock);
> +		/* If another instance finished the job for us, skip it */
> +		if (!dev->iommu || dev->iommu_group)
> +			return -ENODEV;
>  	}
>  	/*
>  	 * At this point, relevant devices either now have a fwspec which will

I hit the below NULL-pointer dereference with 6.15-rc7 (when booting the
x1e80100-crd) and it looks like this fix would have prevented it, but
it's currently only queued for 6.16-rc1.

It looks like the gpu smmu probe is racing with fastrpc probe and the
latter proceeds with iommu probe when the former temporarily releases
the iommu probe mutex. Note that the iommu->ready flag added by [1] does
not help since the apps smmu has already been probed.

When the probe mutex is later reacquired, symlink creation fails and the
tear down path sets the iommu_dev pointer to NULL, which in turn
triggers the NULL pointer dereference in iommu_probe_device() when
calling probe_finalize().

[ Or something along those lines (e.g. as I'm not seeing the "something
fishy" warning in the manually saved serial console log). ]

I've only seen this once, but it's clear that this is a regression in
6.15 due to the iommu rework. If you agree that this fix would have
prevented it then perhaps we should try to get it into 6.15 final (or at
least backport it when 6.16-rc1 is out).

Johan

[1] https://lore.kernel.org/lkml/88d54c1b48fed8279aa47d30f3d75173685bb26a.1745516488.git.robin.murphy@arm.com/

#regzbot ^introduced: bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c

[    7.759456] arm-smmu 3da0000.iommu: probing hardware configuration...
[    7.792360] arm-smmu 3da0000.iommu: SMMUv2 with:
[    7.802065] arm-smmu 3da0000.iommu:  stage 1 translation
[    7.811229] arm-smmu 3da0000.iommu:  coherent table walk
[    7.811233] arm-smmu 3da0000.iommu:  stream matching with 24 register groups
[    7.811272] arm-smmu 3da0000.iommu:  22 context banks (0 stage-2 only)
[    7.820512] remoteproc remoteproc0: remote processor adsp is now up
[    7.821538] arm-smmu 3da0000.iommu:  Supported page sizes: 0x61311000
[    7.845913] qcom,fastrpc 6800000.remoteproc:glink-edge.fastrpcglink-apps-dsp.-1.-1: no reserved DMA memory for FASTRPC
[    7.851687] qcom,apr 6800000.remoteproc:glink-edge.adsp_apps.-1.-1: Adding APR/GPR dev: gprsvc:service:2:1
[    7.852191] qcom,apr 6800000.remoteproc:glink-edge.adsp_apps.-1.-1: Adding APR/GPR dev: gprsvc:service:2:2
[    7.852301] arm-smmu 3da0000.iommu:  Stage-1: 48-bit VA -> 40-bit IPA
[    7.853963] remoteproc remoteproc1: remote processor cdsp is now up
[    7.857232] qcom,fastrpc 32300000.remoteproc:glink-edge.fastrpcglink-apps-dsp.-1.-1: no reserved DMA memory for FASTRPC
[    7.861182] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@1: Adding to iommu group 9
[    7.865501] arm-smmu 3da0000.iommu:  preserved 0 boot mappings
[    7.977602] platform 6800000.remoteproc:glink-edge:fastrpc:compute-cb@3: Adding to iommu group 10
[    7.991605] platform 3d00000.gpu: Adding to iommu group 11
[    7.998389] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@2: Adding to iommu group 12
[    8.008816] platform 3d6a000.gmu: Adding to iommu group 13
[    8.016577] platform 6800000.remoteproc:glink-edge:fastrpc:compute-cb@4: Adding to iommu group 14
[    8.027036] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@3: Adding to iommu group 15
[    8.037840] platform 6800000.remoteproc:glink-edge:fastrpc:compute-cb@5: Adding to iommu group 16
[    8.048473] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@4: Adding to iommu group 17
[    8.068429] platform 6800000.remoteproc:glink-edge:fastrpc:compute-cb@6: Adding to iommu group 18
[    8.106128] sysfs: cannot create duplicate filename '/devices/platform/soc@0/15000000.iommu/iommu/smmu.0x00000000150
00000/devices/6800000.remoteproc:glink-edge:fastrpc:compute-cb@6'

[    8.129705] CPU: 9 UID: 0 PID: 131 Comm: kworker/u50:4 Not tainted 6.15.0-rc7 #8 PREEMPT
[    8.129708] Hardware name: Qualcomm CRD, BIOS 6.0.241007.BOOT.MXF.2.4-00534.1-HAMOA-1 10/ 7/2024
[    8.129709] Workqueue: events_unbound deferred_probe_work_func
[    8.129715] Call trace:
[    8.129716]  show_stack+0x18/0x24 (C)
[    8.129719]  dump_stack_lvl+0xc0/0xd0
[    8.129722]  dump_stack+0x18/0x24
[    8.129724]  sysfs_warn_dup+0x64/0x80
[    8.129727]  sysfs_do_create_link_sd+0xf0/0xf8
[    8.129729]  sysfs_create_link_sd+0x14/0x20
[    8.129730]  sysfs_add_link_to_group+0x3c/0x68
[    8.129732]  iommu_device_link+0x40/0xb8
[    8.129735]  __iommu_probe_device+0x158/0x4b8
[    8.129737]  probe_iommu_group+0x3c/0x64
[    8.129739]  bus_for_each_dev+0x74/0xd0
[    8.129741]  iommu_device_register+0xd8/0x23c
[    8.129743]  arm_smmu_device_probe+0xc08/0xe94
[    8.129745]  platform_probe+0x68/0xd8
[    8.129747]  really_probe+0xc0/0x38c
[    8.129750]  __driver_probe_device+0x7c/0x160
[    8.129753]  driver_probe_device+0x40/0x110
[    8.129754]  __device_attach_driver+0xbc/0x158
[    8.129756]  bus_for_each_drv+0x80/0xdc
[    8.129754]  __device_attach_driver+0xbc/0x158
[    8.129756]  bus_for_each_drv+0x80/0xdc
[    8.129758]  __device_attach+0xa8/0x1d4
[    8.129759]  device_initial_probe+0x14/0x20
[    8.129761]  bus_probe_device+0xb0/0xb4
[    8.129763]  deferred_probe_work_func+0xa0/0xf4
[    8.129766]  process_one_work+0x20c/0x610
[    8.129769]  worker_thread+0x244/0x388
[    8.129771]  kthread+0x150/0x220
[    8.129773]  ret_from_fork+0x10/0x20
[    8.129808] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
[    8.131501] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@5: Adding to iommu group 11
[    8.131551] arm-smmu 3da0000.iommu: error -EEXIST: Failed to register iommu
[    8.131574] arm-smmu 3da0000.iommu: probe with driver arm-smmu failed with error -17
[    8.138242] Mem abort info:
[    8.138244]   ESR = 0x0000000096000004
[    8.138246]   EC = 0x25: DABT (current EL), IL = 32 bits
[    8.149780] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@6: Adding to iommu group 13
[    8.150537] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@7: Adding to iommu group 19
[    8.151166] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@8: Adding to iommu group 20
[    8.152079] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@10: Adding to iommu group 21
[    8.152765] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@11: Adding to iommu group 22
[    8.153281]   SET = 0, FnV = 0
[    8.153283]   EA = 0, S1PTW = 0
[    8.153284]   FSC = 0x04: level 0 translation fault
[    8.153286] Data abort info:
[    8.153287]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    8.153387] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@12: Adding to iommu group 23
[    8.154013] platform 32300000.remoteproc:glink-edge:fastrpc:compute-cb@13: Adding to iommu group 24
[    8.159590]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    8.159592]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    8.225170] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000883bb6000
[    8.233976] [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
[    8.234001] Internal error: Oops: 0000000096000004 [#1]  SMP

[    8.446080] CPU: 5 UID: 0 PID: 406 Comm: (udev-worker) Not tainted 6.15.0-rc7 #8 PREEMPT
[    8.446082] Hardware name: Qualcomm CRD, BIOS 6.0.241007.BOOT.MXF.2.4-00534.1-HAMOA-1 10/ 7/2024
[    8.459940] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    8.459942] pc : iommu_probe_device+0x50/0x7c
[    8.488201] lr : iommu_probe_device+0x44/0x7c
[    8.488203] sp : ffff800082543210
[    8.488204] x29: ffff800082543210 x28: 000000000000000c x27: 0000000000000001
[    8.488206] x26: 0000000000000000 x25: ffffd3551bac57c8 x24: 0000000000000000
[    8.502233] x23: 0000000000000002 x22: ffffd3551c0407c0 x21: ffffd3551c0407c0
[    8.502235] x20: 0000000000000000 x19: ffff23ce85720010 x18: 0000000000069e00
[    8.502237] x17: 0000000000000028 x16: 0000000000000000
[    8.523033]  x15: ffffd3551c1a5920
[    8.523035] x14: ffffd3551c20f720 x13: ffff23ce811c5ba0 x12: ffff23ce90b70568
[    8.523037] x11: ffffd3551c819960 x10: 0000000000000000 x9 : 0000000000000000
[    8.543927] x8 : ffffd3551c103000 x7 : ffff8000825430a0 x6 : ffff800082543030
[    8.543929] x5 : ffff800082544000 x4 : 0000000000000002 x3 : 0000000000000000
[    8.556981] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[    8.556983] Call trace:
[    8.556984]  iommu_probe_device+0x50/0x7c (P)
[    8.582047]  of_iommu_configure+0x188/0x26c
[    8.582050]  of_dma_configure_id+0xcc/0x300
[    8.582053]  platform_dma_configure+0x80/0xa4
[    8.582054]  really_probe+0x74/0x38c
[    8.595015]  __driver_probe_device+0x7c/0x160
[    8.595017]  driver_probe_device+0x40/0x110
[    8.595019]  __device_attach_driver+0xbc/0x158
[    8.631849]  bus_for_each_drv+0x80/0xdc
[    8.631852]  __device_attach+0xa8/0x1d4
[    8.631853]  device_initial_probe+0x14/0x20
[    8.631855]  bus_probe_device+0xb0/0xb4
[    8.631857]  device_add+0x57c/0x784
[    8.653367]  of_device_add+0x44/0x60
[    8.653369]  of_platform_device_create_pdata+0x98/0x140
[    8.653371]  of_platform_bus_create+0x1b0/0x4d4
[    8.653372]  of_platform_populate+0x60/0x14c
[    8.653374]  fastrpc_rpmsg_probe+0x254/0x3d8 [fastrpc]
[    8.661542]  rpmsg_dev_probe+0xc0/0x1e0 [rpmsg_core]
[    8.671574]  really_probe+0xc0/0x38c
[    8.671577]  __driver_probe_device+0x7c/0x160
[    8.691391]  driver_probe_device+0x40/0x110
[    8.691391]  driver_probe_device+0x40/0x110
[    8.691392]  __driver_attach+0xfc/0x208
[    8.691393]  bus_for_each_dev+0x74/0xd0
[    8.691395]  driver_attach+0x24/0x30
[    8.691398]  bus_add_driver+0x110/0x234
[    8.715663]  driver_register+0x60/0x128
[    8.715665]  __register_rpmsg_driver+0x1c/0x28 [rpmsg_core]
[    8.715667]  fastrpc_init+0x40/0xb8 [fastrpc]
[    8.715669]  do_one_initcall+0x64/0x30c
[    8.730854]  do_init_module+0x58/0x204
[    8.730857]  load_module+0x1e24/0x1f6c
[    8.743016]  init_module_from_file+0x88/0xc4
[    8.743017]  idempotent_init_module+0x188/0x27c
[    8.743019]  __arm64_sys_finit_module+0x6c/0xec
[    8.743020]  invoke_syscall+0x48/0x110
[    8.743023]  el0_svc_common.constprop.0+0xc0/0xe0
[    8.760436]  do_el0_svc+0x1c/0x28
[    8.760438]  el0_svc+0x48/0x114
[    8.760441]  el0t_64_sync_handler+0xc8/0xcc
[    8.760443]  el0t_64_sync+0x198/0x19c
[    8.760445] Code: 940dd1a3 35000114 f9423260 f9405000 (f9400800)
[    8.760446] ---[ end trace 0000000000000000 ]---
