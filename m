Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907820C00E
	for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072575; cv=none; b=sM9Bwz6WBkK6ZpzUaKwqxSXnVDwr5mDrg7cYSFQUhX4hxsLeJesvHr8Ki/fsXaIbSyI85PRvF0YL4bqjRBy+a/bG0X2Hla2m1WUWrR7pxXdHIBv39f+zEKU+wFEBjApDR1BOEVghYPLZxXgMFX0i8xlYDWaX4SgeYoIsGVe90yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072575; c=relaxed/simple;
	bh=ZQJOYU8kp75wJ6bJBfkmh7nas29NmT9KXFpPF8iGxAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri2xKlvQ2BX4ghB2S20Z8D6Qq43QM+CgymyDhX2rUP22QeGCEGIbdSFsQAvgbm/JcJq3zTRHRLTimaCxfGShBjXJTKr6nKYrv5VZWpb7P5yyXDT/HTzr+uxuhfRC4bUGoLUT74I8xTATQXJ+PMvrfSoNg+cBXIZbPt1jQfo8hO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M38bRAmh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M38bRAmh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1743072571;
	bh=ZQJOYU8kp75wJ6bJBfkmh7nas29NmT9KXFpPF8iGxAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M38bRAmhZxxB+SLBpACUIBktJDUwtUoi1dl0Kw6tO3FynO/IVEou4EKeitANYWQg4
	 R6eTA3pGRWwrskYquhesZ1Az9UaAK8RFFj7P/A6HbvNDx6e3q/YV7NrNMIiMjM7y3k
	 NY5zGAmC1uUrjPIihMwxXZR8sv8tpnetItbWNEAcXypdpxu/cdBCRNXKw/iBqbC6AO
	 t3uS949uB3n2IUvwUbKabgZ8SKKROF1VSKUsGJt4MFpZOL/0V6/YiDJ0d0/g7Ta+vB
	 rq8eo6yKa4y3ms5W6kcXEWR61T4GcbloRpLcdOk6z8138YcYYEWRnM4Brr8VE+6XgX
	 yiQyfiMj5MLCQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A4DC17E0FF6;
	Thu, 27 Mar 2025 11:49:30 +0100 (CET)
Message-ID: <838c8e29-50c3-445c-9099-2a7c37453059@collabora.com>
Date: Thu, 27 Mar 2025 11:49:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/mediatek: Fix NULL pointer deference in
 mtk_iommu_device_group
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: kernel@collabora.com, Joerg Roedel <jroedel@suse.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>
References: <20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/03/25 11:46, Louis-Alexis Eyraud ha scritto:
> Currently, mtk_iommu calls during probe iommu_device_register before
> the hw_list from driver data is initialized. Since iommu probing issue
> fix, it leads to NULL pointer dereference in mtk_iommu_device_group when
> hw_list is accessed with list_first_entry (not null safe).
> 
> So, change the call order to ensure iommu_device_register is called
> after the driver data are initialized.
> 
> Fixes: 9e3a2a643653 ("iommu/mediatek: Adapt sharing and non-sharing pgtable case")
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

On MT8195 Tomato, MT8395 Radxa NIO-12L, MT8390 Genio 700 EVK:
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

> ---
> This patch fixes a NULL pointer dereference that occurs during the
> mtk_iommu driver probe and observed at least on several Mediatek Genio boards:
> ```
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Mem abort info:
>    ESR = 0x0000000096000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x04: level 0 translation fault
> Data abort info:
>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101380000
> [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1]  SMP
> Modules linked in: btusb btrtl mt6315_regulator btintel mtk_vcodec_dec
>    btmtk v4l2_vp9 btbcm mtk_vcodec_enc v4l2_h264 mtk_vcodec_dbgfs
>    bluetooth mtk_jpeg ecdh_generic mtk_vcodec_common mtk_jpeg_enc_hw
>    mtk_jpeg_dec_hw ecc v4l2_mem2mem rfkill videobuf2_dma_contig
>    videobuf2_memops videobuf2_v4l2 videodev videobuf2_common mc
>    mt6360_charger mcp251xfd it5205 goodix_ts can_dev panfrost
>    drm_shmem_helper gpu_sched lvts_thermal mtk_svs mtk_adsp_mailbox
>    snd_soc_dmic mtk_scp mtk_rpmsg mtk_scp_ipi mtk_cmdq_mailbox
>    mediatek_cpufreq_hw spmi_mtk_pmif fuse dm_mod ip_tables x_tables
>    ipv6 mediatek_drm tcpci_mt6360 drm_display_helper drm_client_lib
>    tcpci drm_dma_helper drm_kms_helper tcpm drm mtk_mutex mtk_mmsys
>    typec rtc_mt6397 mtk_cmdq_helper phy_mtk_pcie pcie_mediatek_gen3
>    dwmac_mediatek stmmac_platform stmmac pwm_mtk_disp pcs_xpcs pwm_bl
>    backlight
> CPU: 5 UID: 0 PID: 12 Comm: kworker/u32:0 Not tainted 6.14.0-next-20250326 #4 PREEMPT
> Hardware name: MediaTek Genio 1200 EVK-P1V2-EMMC (DT)
> Workqueue: events_unbound deferred_probe_work_func
> pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mtk_iommu_device_group+0x2c/0xe0
> lr : __iommu_probe_device+0x130/0x490
> sp : ffff8000827b3970
> x29: ffff8000827b3970 x28: ffff0000c0028000 x27: ffff80008164f2b8
> x26: ffff0000cbc47130 x25: ffff80008096a9f0 x24: ffff80008164f5a8
> x23: ffff800082684b60 x22: ffff8000827b3a80 x21: ffff0000cbc47130
> x20: ffffffffffffffed x19: ffff0000c117c010 x18: 0000000000000000
> x17: 6f702d616d642d64 x16: 6574636972747365 x15: 0000000000000002
> x14: 0000000000000000 x13: 0000000000128d55 x12: 6f632d616d642e30
> x11: 0000000000000100 x10: 0000000000000001 x9 : 0000000000000220
> x8 : 0101010101010101 x7 : ffff0000c117c010 x6 : 306c766f2c727461
> x5 : 0000000000000000 x4 : ffff0000c10a2de8 x3 : ffff0000c10a2e70
> x2 : ffff0000c01a4600 x1 : 0000000000000000 x0 : ffff0000c65470c0
> Call trace:
>   mtk_iommu_device_group+0x2c/0xe0 (P)
>   __iommu_probe_device+0x130/0x490
>   probe_iommu_group+0x3c/0x70
>   bus_for_each_dev+0x7c/0xe0
>   iommu_device_register+0xd8/0x22c
>   mtk_iommu_probe+0x270/0x53c
>   platform_probe+0x68/0xd8
>   really_probe+0xbc/0x2c0
>   __driver_probe_device+0x78/0x120
>   driver_probe_device+0x3c/0x154
>   __device_attach_driver+0xb8/0x140
>   bus_for_each_drv+0x88/0xe8
>   __device_attach+0xa0/0x190
>   device_initial_probe+0x14/0x20
>   bus_probe_device+0xb4/0xc0
>   deferred_probe_work_func+0x90/0xc8
>   process_one_work+0x148/0x284
>   worker_thread+0x2cc/0x3cc
>   kthread+0x12c/0x204
>   ret_from_fork+0x10/0x20
> Code: b4000500 f9401c01 92800254 f9409821 (f9400035)
> ---[ end trace 0000000000000000 ]---
> ```
> 
> I've tested this patch on Mediatek Genio 510-EVK and 1200-EVK boards
> with a kernel based on linux-next (tag: next-20250327).
> ---
>   drivers/iommu/mtk_iommu.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 034b0e670384a24df10130cbbff95ce8e0bc092d..14adb96a37bb0d84b631188e48dd8b936821a717 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1372,15 +1372,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, data);
>   	mutex_init(&data->mutex);
>   
> -	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
> -				     "mtk-iommu.%pa", &ioaddr);
> -	if (ret)
> -		goto out_link_remove;
> -
> -	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
> -	if (ret)
> -		goto out_sysfs_remove;
> -
>   	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE)) {
>   		list_add_tail(&data->list, data->plat_data->hw_list);
>   		data->hw_list = data->plat_data->hw_list;
> @@ -1390,18 +1381,28 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   		data->hw_list = &data->hw_list_head;
>   	}
>   
> +	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
> +				     "mtk-iommu.%pa", &ioaddr);
> +	if (ret)
> +		goto out_list_del;
> +
> +	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
> +	if (ret)
> +		goto out_link_remove;
> +
>   	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
>   		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
>   		if (ret)
> -			goto out_list_del;
> +			goto out_device_unregister;
>   	}
>   	return ret;
>   
> -out_list_del:
> -	list_del(&data->list);
> +out_device_unregister:
>   	iommu_device_unregister(&data->iommu);
>   out_sysfs_remove:
>   	iommu_device_sysfs_remove(&data->iommu);
> +out_list_del:
> +	list_del(&data->list);
>   out_link_remove:
>   	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
>   		device_link_remove(data->smicomm_dev, dev);
> 
> ---
> base-commit: bc960e3e32c8b940c10b14557271355f66ae4db1
> change-id: 20250327-fix-mtk-iommu-error-af6ec347d057
> 
> Best regards,


