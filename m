Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92B242930
	for <iommu@lists.linux.dev>; Thu,  3 Apr 2025 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668759; cv=pass; b=qW4RNrqRrGmVOKl00lduuZRx5P7ZHF6e9hT35nQIgog9J97aY9xNGihRQsdOE5ladOUwl+z4L2LdEnn8SUXY3CJ6pqfBLUUnUrfWBVB5Hdf3Z49gWzngV1nR7UIZqWbvspTUiVQ4/rQQvfexqooqUGY/2VXEQtZenoB9Ic7twI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668759; c=relaxed/simple;
	bh=YmcnUU2RHsake0F5bwSYRtWQbHUB/J3dNDmbOALD5h8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A7mYESSHSGshFxvYLxAJ7Ly8ssM8Lk+nm1XNL9eItpLngIV5hPpG53Yl+F3PiF9pZhv95AmegaM2CHdK9npElX0C1ZvXMvhxYjmDleuaVMRnWwoMtZb9EU+CeGig77GLUbUm/L+Qjs+cs9j/hyhAXBnRqfm7CqUahzF4nUDPvF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=BKCdpZnP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="BKCdpZnP"
ARC-Seal: i=1; a=rsa-sha256; t=1743668738; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gULdN2NgtippGbI0HnDol1JLfPWnoGSilWIfoTy7fsux81+gXUKR95H89ZFQKp83CLoLGfszsNv3oJ2FUZpoDAHNAgPReFlWVXlc32B5SvqBdSsqRyH+v636MMhZmxEshSJXIXbjzNcskNW6B682V3ACymCshRodidPqJVFpWCM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743668738; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YmcnUU2RHsake0F5bwSYRtWQbHUB/J3dNDmbOALD5h8=; 
	b=k3ZnTWIVLCyxZr637iG8ArARVdjXwW0jDJUCLWXmTBW78uqI0Kxukx09eQCZLFJOhxtDYQgNdmMvqA/eZwC2EKoMkWb5mHpcpnCoehRO4dNAZnys7k7K7ktIBnTlSpWRuDplhgz8cAVJbw1l3gHEoxx7HdppnmuO6hDJJ5/3C48=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743668738;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=YmcnUU2RHsake0F5bwSYRtWQbHUB/J3dNDmbOALD5h8=;
	b=BKCdpZnPeMBPz94d7cz29WIq2OTNzn3odzzxCZLrWwOKOKyu/KnX30f8zwltXGbN
	LT7GGRov+qGYkJ8Z7sVTxeNf7LMyrWe0hMimvw4fwYqDO2Z8xzfFPebVgeNaIDD8eER
	ivZehYLP625ELyK75l0vaHD6ZEPvjIFvWog+SzJc=
Received: by mx.zohomail.com with SMTPS id 1743668736253113.89827285780632;
	Thu, 3 Apr 2025 01:25:36 -0700 (PDT)
Message-ID: <f3091f6b15f9dd92325dbd3db36c43019718bff7.camel@collabora.com>
Subject: Re: [PATCH] iommu/mediatek: Fix NULL pointer deference in
 mtk_iommu_device_group
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Yong Wu =?UTF-8?Q?=28=E5=90=B4=E5=8B=87=29?= <Yong.Wu@mediatek.com>, 
 "robin.murphy@arm.com"	 <robin.murphy@arm.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "robh@kernel.org"	 <robh@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,  "bhelgaas@google.com"	
 <bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "will@kernel.org" <will@kernel.org>
Cc: "jroedel@suse.de" <jroedel@suse.de>, "kernel@collabora.com"	
 <kernel@collabora.com>, "linux-mediatek@lists.infradead.org"	
 <linux-mediatek@lists.infradead.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
 "linux-arm-kernel@lists.infradead.org"	
 <linux-arm-kernel@lists.infradead.org>
Date: Thu, 03 Apr 2025 10:25:31 +0200
In-Reply-To: <ffb19b2e42d3e99990cddaa13264e87561ab26d4.camel@mediatek.com>
References: <20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com>
	 <ffb19b2e42d3e99990cddaa13264e87561ab26d4.camel@mediatek.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi,

On Thu, 2025-04-03 at 07:25 +0000, Yong Wu (=E5=90=B4=E5=8B=87) wrote:
> On Thu, 2025-03-27 at 11:46 +0100, Louis-Alexis Eyraud wrote:
> > External email : Please do not click links or open attachments
> > until
> > you have verified the sender or the content.
> >=20
> >=20
> > Currently, mtk_iommu calls during probe iommu_device_register
> > before
> > the hw_list from driver data is initialized. Since iommu probing
> > issue
> > fix, it leads to NULL pointer dereference in mtk_iommu_device_group
> > when
> > hw_list is accessed with list_first_entry (not null safe).
> >=20
> > So, change the call order to ensure iommu_device_register is called
> > after the driver data are initialized.
> >=20
> > Fixes: 9e3a2a643653 ("iommu/mediatek: Adapt sharing and non-sharing
> > pgtable case")
> > Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
> > probe path")
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
> > ---
> > This patch fixes a NULL pointer dereference that occurs during the
> > mtk_iommu driver probe and observed at least on several Mediatek
> > Genio boards:
> > ```
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 0000000000000000
> > Mem abort info:
> > =C2=A0 ESR =3D 0x0000000096000004
> > =C2=A0 EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > =C2=A0 SET =3D 0, FnV =3D 0
> > =C2=A0 EA =3D 0, S1PTW =3D 0
> > =C2=A0 FSC =3D 0x04: level 0 translation fault
> > Data abort info:
> > =C2=A0 ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > =C2=A0 CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > =C2=A0 GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000101380000
> > [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000000000000
> > Internal error: Oops: 0000000096000004 [#1]=C2=A0 SMP
> > Modules linked in: btusb btrtl mt6315_regulator btintel
> > mtk_vcodec_dec
> > =C2=A0 btmtk v4l2_vp9 btbcm mtk_vcodec_enc v4l2_h264 mtk_vcodec_dbgfs
> > =C2=A0 bluetooth mtk_jpeg ecdh_generic mtk_vcodec_common mtk_jpeg_enc_h=
w
> > =C2=A0 mtk_jpeg_dec_hw ecc v4l2_mem2mem rfkill videobuf2_dma_contig
> > =C2=A0 videobuf2_memops videobuf2_v4l2 videodev videobuf2_common mc
> > =C2=A0 mt6360_charger mcp251xfd it5205 goodix_ts can_dev panfrost
> > =C2=A0 drm_shmem_helper gpu_sched lvts_thermal mtk_svs mtk_adsp_mailbox
> > =C2=A0 snd_soc_dmic mtk_scp mtk_rpmsg mtk_scp_ipi mtk_cmdq_mailbox
> > =C2=A0 mediatek_cpufreq_hw spmi_mtk_pmif fuse dm_mod ip_tables x_tables
> > =C2=A0 ipv6 mediatek_drm tcpci_mt6360 drm_display_helper drm_client_lib
> > =C2=A0 tcpci drm_dma_helper drm_kms_helper tcpm drm mtk_mutex mtk_mmsys
> > =C2=A0 typec rtc_mt6397 mtk_cmdq_helper phy_mtk_pcie pcie_mediatek_gen3
> > =C2=A0 dwmac_mediatek stmmac_platform stmmac pwm_mtk_disp pcs_xpcs
> > pwm_bl
> > =C2=A0 backlight
> > CPU: 5 UID: 0 PID: 12 Comm: kworker/u32:0 Not tainted 6.14.0-next-
> > 20250326 #4 PREEMPT
> > Hardware name: MediaTek Genio 1200 EVK-P1V2-EMMC (DT)
> > Workqueue: events_unbound deferred_probe_work_func
> > pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : mtk_iommu_device_group+0x2c/0xe0
> > lr : __iommu_probe_device+0x130/0x490
> > sp : ffff8000827b3970
> > x29: ffff8000827b3970 x28: ffff0000c0028000 x27: ffff80008164f2b8
> > x26: ffff0000cbc47130 x25: ffff80008096a9f0 x24: ffff80008164f5a8
> > x23: ffff800082684b60 x22: ffff8000827b3a80 x21: ffff0000cbc47130
> > x20: ffffffffffffffed x19: ffff0000c117c010 x18: 0000000000000000
> > x17: 6f702d616d642d64 x16: 6574636972747365 x15: 0000000000000002
> > x14: 0000000000000000 x13: 0000000000128d55 x12: 6f632d616d642e30
> > x11: 0000000000000100 x10: 0000000000000001 x9 : 0000000000000220
> > x8 : 0101010101010101 x7 : ffff0000c117c010 x6 : 306c766f2c727461
> > x5 : 0000000000000000 x4 : ffff0000c10a2de8 x3 : ffff0000c10a2e70
> > x2 : ffff0000c01a4600 x1 : 0000000000000000 x0 : ffff0000c65470c0
> > Call trace:
> > =C2=A0mtk_iommu_device_group+0x2c/0xe0 (P)
> > =C2=A0__iommu_probe_device+0x130/0x490
> > =C2=A0probe_iommu_group+0x3c/0x70
> > =C2=A0bus_for_each_dev+0x7c/0xe0
> > =C2=A0iommu_device_register+0xd8/0x22c
> > =C2=A0mtk_iommu_probe+0x270/0x53c
> > =C2=A0platform_probe+0x68/0xd8
> > =C2=A0really_probe+0xbc/0x2c0
> > =C2=A0__driver_probe_device+0x78/0x120
> > =C2=A0driver_probe_device+0x3c/0x154
> > =C2=A0__device_attach_driver+0xb8/0x140
> > =C2=A0bus_for_each_drv+0x88/0xe8
> > =C2=A0__device_attach+0xa0/0x190
> > =C2=A0device_initial_probe+0x14/0x20
> > =C2=A0bus_probe_device+0xb4/0xc0
> > =C2=A0deferred_probe_work_func+0x90/0xc8
> > =C2=A0process_one_work+0x148/0x284
> > =C2=A0worker_thread+0x2cc/0x3cc
> > =C2=A0kthread+0x12c/0x204
> > =C2=A0ret_from_fork+0x10/0x20
> > Code: b4000500 f9401c01 92800254 f9409821 (f9400035)
> > ---[ end trace 0000000000000000 ]---
> > ```
> >=20
> > I've tested this patch on Mediatek Genio 510-EVK and 1200-EVK
> > boards
> > with a kernel based on linux-next (tag: next-20250327).
> > ---
> > =C2=A0drivers/iommu/mtk_iommu.c | 25 +++++++++++++------------
> > =C2=A01 file changed, 13 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index
> > 034b0e670384a24df10130cbbff95ce8e0bc092d..14adb96a37bb0d84b631188e4
> > 8d
> > d8b936821a717 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -1372,15 +1372,6 @@ static int mtk_iommu_probe(struct
> > platform_device *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 platform_set_drvdata(pdev, d=
ata);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&data->mutex);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iommu_device_sysfs_add(&d=
ata->iommu, dev, NULL,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mtk-iom=
mu.%pa", &ioaddr);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out_link_remove;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iommu_device_register(&da=
ta->iommu, &mtk_iommu_ops,
> > dev);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out_sysfs_remove;
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (MTK_IOMMU_HAS_FLAG(data-=
>plat_data, SHARE_PGTABLE)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list_add_tail(&data->list, data->plat_data-
> > >hw_list);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->hw_list =3D data->plat_data->hw_list;
> > @@ -1390,18 +1381,28 @@ static int mtk_iommu_probe(struct
> > platform_device *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->hw_list =3D &data->hw_list_head;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iommu_device_sysfs_add(&d=
ata->iommu, dev, NULL,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mtk-iom=
mu.%pa", &ioaddr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out_list_del;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iommu_device_register(&da=
ta->iommu, &mtk_iommu_ops,
> > dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out_link_remove;
>=20
>=20
> Typo here. Use out_sysfs_remove instead and remove out_link_remove
> label. Then,
>=20
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
>=20
> Thanks very much for this patch.
>=20
thanks for the review and detecting this issue in the patch.
I'll send a v2 to fix it.

Regards,
Louis-Alexis
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (MTK_IOMMU_IS_TYPE(data->=
plat_data, MTK_IOMMU_TYPE_MM))
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D component_master_add_with_match(dev,
> > &mtk_iommu_com_ops, match);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_li=
st_del;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_de=
vice_unregister;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >=20
> > -out_list_del:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&data->list);
> > +out_device_unregister:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iommu_device_unregister(&dat=
a->iommu);
> > =C2=A0out_sysfs_remove:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iommu_device_sysfs_remove(&d=
ata->iommu);
> > +out_list_del:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&data->list);
> > =C2=A0out_link_remove:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (MTK_IOMMU_IS_TYPE(data->=
plat_data, MTK_IOMMU_TYPE_MM))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 device_link_remove(data->smicomm_dev, dev);
> >=20
> > ---
> > base-commit: bc960e3e32c8b940c10b14557271355f66ae4db1
> > change-id: 20250327-fix-mtk-iommu-error-af6ec347d057
> >=20
> > Best regards,
> > --
> > Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> >=20

