Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4E1E1C3F
	for <iommu@lists.linux.dev>; Thu,  3 Apr 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675850; cv=none; b=d4xMc2gAfuOV5IDsuzUxADB32AM1vtsqvMms3kOdkOqHSNRbYjizqYC5YwFSEiof4C1g2e/BojnSce9iItpuVweojdOUnGAN9VovDZsnR8aLITmXC6N0jfswlLPL+NJxe1E5MyQyl7IdO3/ZB5j8xHXzXTnc/oQOASRoackshZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675850; c=relaxed/simple;
	bh=8AG+2LWdLaSd+aliWaEjofMuTJ1H/+03MA/augLE7Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WySHpRZwfHccIXyOwqUDgtSCNeCseAJ/0mO98Db2Wz2CYbR6cTVnlsXSwZF9VPvqnUXuR/P6o1ExnYOQLUE4s9+PS9HxqDsrNtK+mpZgVDlv+EzibkrkSLNZhRLl0ZhfCZ+iiVJMlWX/rON65kLCRn/NPEI/GGTudsVUbyc8fVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ST3w5R7u; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ST3w5R7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1743675846;
	bh=8AG+2LWdLaSd+aliWaEjofMuTJ1H/+03MA/augLE7Wg=;
	h=From:Date:Subject:To:Cc:From;
	b=ST3w5R7ughHTcw/YCcLjgMOtCfeGQcrsJ1pFVgae8BwV2B0ZuX7Qhq6/Ir/VRm5fP
	 uh3J1kV2NxWsyYS1+F7TXxiwA6uDKGYMOKX9GMJYIAV3sAe3+WzD/oABvyL+BUtAK4
	 1wmGS6XsFhzMmzQsTzENMIExbbvH+/ChwTuhVPAblcq0wO5tx+7m7FTYTzULutrRpG
	 eScBJtMOi382DWGjWhxB/zYKGnL6Fvj4vlvXBDIYZzNgiSqdrYxw+/bsHrZ7rnp1uC
	 wuZ6acnAb4nQKiAEMy8A8KjgrgRVWdhuF5EJA+MyAghRbYCMnERP/y5skQaMqaNU6u
	 cpQ9zK9S55ngQ==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 03FAA17E0B0B;
	Thu,  3 Apr 2025 12:24:05 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 03 Apr 2025 12:22:12 +0200
Subject: [PATCH v2] iommu/mediatek: Fix NULL pointer deference in
 mtk_iommu_device_group
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-fix-mtk-iommu-error-v2-1-fe8b18f8b0a8@collabora.com>
X-B4-Tracking: v=1; b=H4sIAFNh7mcC/32OQQ6CMBBFr0Jm7RhahCor72FYFBikEahOC8EQ7
 m6FuHX5JvP+/ws4YkMO8mgBpsk4Y4cA8hBB1erhTmjqwCBjmcaJVNiYGXv/QGP7fkRitoy6yah
 KTqqOUwXBfDKFty31VuzM9BpDuN+PUGpHWIUI4/NooNnjrwC+Qmuct/zeVk1iM/4OmAQKrJtLd
 hHpmVQqr5XtOl1a1sfQAsW6rh9UL3Tm6wAAAA==
X-Change-ID: 20250327-fix-mtk-iommu-error-af6ec347d057
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: kernel@collabora.com, Joerg Roedel <jroedel@suse.de>, 
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743675845; l=6730;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=8AG+2LWdLaSd+aliWaEjofMuTJ1H/+03MA/augLE7Wg=;
 b=VsLUqYCMVKpmxxuQ0+wKCboWg904K1pf0PqhTi8d6F/b1Dsl5lKqgLH9Ikh/1uXPoIwacTs/b
 Dde9fCu0ifXDM//zDO5pwE/TwKphKLkblRC27fbvhgYIfRCa46awoUF
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Currently, mtk_iommu calls during probe iommu_device_register before
the hw_list from driver data is initialized. Since iommu probing issue
fix, it leads to NULL pointer dereference in mtk_iommu_device_group when
hw_list is accessed with list_first_entry (not null safe).

So, change the call order to ensure iommu_device_register is called
after the driver data are initialized.

Fixes: 9e3a2a643653 ("iommu/mediatek: Adapt sharing and non-sharing pgtable case")
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org> # MT8183 Juniper, MT8186 Tentacruel
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
This patch fixes a NULL pointer dereference that occurs during the
mtk_iommu driver probe and observed at least on several Mediatek Genio boards:
```
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101380000
[0000000000000000] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in: btusb btrtl mt6315_regulator btintel mtk_vcodec_dec
  btmtk v4l2_vp9 btbcm mtk_vcodec_enc v4l2_h264 mtk_vcodec_dbgfs 
  bluetooth mtk_jpeg ecdh_generic mtk_vcodec_common mtk_jpeg_enc_hw 
  mtk_jpeg_dec_hw ecc v4l2_mem2mem rfkill videobuf2_dma_contig 
  videobuf2_memops videobuf2_v4l2 videodev videobuf2_common mc 
  mt6360_charger mcp251xfd it5205 goodix_ts can_dev panfrost 
  drm_shmem_helper gpu_sched lvts_thermal mtk_svs mtk_adsp_mailbox
  snd_soc_dmic mtk_scp mtk_rpmsg mtk_scp_ipi mtk_cmdq_mailbox 
  mediatek_cpufreq_hw spmi_mtk_pmif fuse dm_mod ip_tables x_tables 
  ipv6 mediatek_drm tcpci_mt6360 drm_display_helper drm_client_lib 
  tcpci drm_dma_helper drm_kms_helper tcpm drm mtk_mutex mtk_mmsys 
  typec rtc_mt6397 mtk_cmdq_helper phy_mtk_pcie pcie_mediatek_gen3 
  dwmac_mediatek stmmac_platform stmmac pwm_mtk_disp pcs_xpcs pwm_bl
  backlight
CPU: 5 UID: 0 PID: 12 Comm: kworker/u32:0 Not tainted 6.14.0-next-20250326 #4 PREEMPT 
Hardware name: MediaTek Genio 1200 EVK-P1V2-EMMC (DT)
Workqueue: events_unbound deferred_probe_work_func
pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mtk_iommu_device_group+0x2c/0xe0
lr : __iommu_probe_device+0x130/0x490
sp : ffff8000827b3970
x29: ffff8000827b3970 x28: ffff0000c0028000 x27: ffff80008164f2b8
x26: ffff0000cbc47130 x25: ffff80008096a9f0 x24: ffff80008164f5a8
x23: ffff800082684b60 x22: ffff8000827b3a80 x21: ffff0000cbc47130
x20: ffffffffffffffed x19: ffff0000c117c010 x18: 0000000000000000
x17: 6f702d616d642d64 x16: 6574636972747365 x15: 0000000000000002
x14: 0000000000000000 x13: 0000000000128d55 x12: 6f632d616d642e30
x11: 0000000000000100 x10: 0000000000000001 x9 : 0000000000000220
x8 : 0101010101010101 x7 : ffff0000c117c010 x6 : 306c766f2c727461
x5 : 0000000000000000 x4 : ffff0000c10a2de8 x3 : ffff0000c10a2e70
x2 : ffff0000c01a4600 x1 : 0000000000000000 x0 : ffff0000c65470c0
Call trace:
 mtk_iommu_device_group+0x2c/0xe0 (P)
 __iommu_probe_device+0x130/0x490
 probe_iommu_group+0x3c/0x70
 bus_for_each_dev+0x7c/0xe0
 iommu_device_register+0xd8/0x22c
 mtk_iommu_probe+0x270/0x53c
 platform_probe+0x68/0xd8
 really_probe+0xbc/0x2c0
 __driver_probe_device+0x78/0x120
 driver_probe_device+0x3c/0x154
 __device_attach_driver+0xb8/0x140
 bus_for_each_drv+0x88/0xe8
 __device_attach+0xa0/0x190
 device_initial_probe+0x14/0x20
 bus_probe_device+0xb4/0xc0
 deferred_probe_work_func+0x90/0xc8
 process_one_work+0x148/0x284
 worker_thread+0x2cc/0x3cc
 kthread+0x12c/0x204
 ret_from_fork+0x10/0x20
Code: b4000500 f9401c01 92800254 f9409821 (f9400035) 
---[ end trace 0000000000000000 ]---
```

I've tested this patch on Mediatek Genio 510-EVK and 1200-EVK boards
with a kernel based on linux-next (tag: next-20250327).
---
Changes in v2:
- Fix goto label usage in device registration error case
- Add review and test trailers
- Link to v1: https://lore.kernel.org/r/20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com
---
 drivers/iommu/mtk_iommu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 034b0e670384a24df10130cbbff95ce8e0bc092d..df98d0c65f5469c6803cd9d151c85ad855558cf5 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1372,15 +1372,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 	mutex_init(&data->mutex);
 
-	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
-				     "mtk-iommu.%pa", &ioaddr);
-	if (ret)
-		goto out_link_remove;
-
-	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
-	if (ret)
-		goto out_sysfs_remove;
-
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE)) {
 		list_add_tail(&data->list, data->plat_data->hw_list);
 		data->hw_list = data->plat_data->hw_list;
@@ -1390,19 +1381,28 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		data->hw_list = &data->hw_list_head;
 	}
 
+	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
+				     "mtk-iommu.%pa", &ioaddr);
+	if (ret)
+		goto out_list_del;
+
+	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
+	if (ret)
+		goto out_sysfs_remove;
+
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 		if (ret)
-			goto out_list_del;
+			goto out_device_unregister;
 	}
 	return ret;
 
-out_list_del:
-	list_del(&data->list);
+out_device_unregister:
 	iommu_device_unregister(&data->iommu);
 out_sysfs_remove:
 	iommu_device_sysfs_remove(&data->iommu);
-out_link_remove:
+out_list_del:
+	list_del(&data->list);
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
 		device_link_remove(data->smicomm_dev, dev);
 out_runtime_disable:

---
base-commit: bc960e3e32c8b940c10b14557271355f66ae4db1
change-id: 20250327-fix-mtk-iommu-error-af6ec347d057

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

