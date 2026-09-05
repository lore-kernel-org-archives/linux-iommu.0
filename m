Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52936A35C
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633548; cv=none; b=Mne4c6WCsCXfoGMWehh7bxmu5CsLDJ8dmwyjYVKVYuP8Yz68sZw7kLqelg4iEIIPzlDV2/oANflb/1EIGI4tKg28zKadxy6uaIrq4sUb5s7QZyKYQTt8J0TaMUApl3kIkKFRB4mpUq38E6xdMlsM8oA+9HDrvV6Jb5GG2gXwkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633548; c=relaxed/simple;
	bh=xYGYa9Hek/Obo34kwAq80rWFnedafs19PROnm7BcfPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j4ZGZh/+b0QgI+npmWTSq09bHFSF0XUxYjPqls9vAwd3wioLk0ZlF9rJv/JqrO45KebyP7KgFNWiSBj1qw8HSQNO2BWbV017v6HB/oItQcQ+//LD1oD1hoMDwUFZo5WjZXePNdtaCLeOkrInelpnH1GYh8fYvKwMJlcOVHSUyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=VmlBupvG; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="VmlBupvG"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4caa43901;
	Sun, 6 Sep 2026 02:38:50 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] iommu/vsi: Fix use-after-free during module unload
Date: Sun,  6 Sep 2026 02:38:34 +0800
Message-Id: <20260905183834.3447662-1-lhfff@tju.edu.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa072ddc17603a1kunm5373407b79fa9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSk0fVkoaSk9CGkhIHxpKSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=VmlBupvGNP5sT1YTTDm8c/ZyiJKLmZrzlFLGrlWvNhurMYrxJsFTGAV4EovS7riY1H0AUw6fiIKDKw50aU9GBmtvzEFXA4gxVBfz2tsG4RypMCDQsjevgkcMfBiEecR++WVC9Dq6nP9XdkZwe0GPY953AVd2o4Ls4TAhIPleZlU=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=SBfpfvviXC7wJ6dAgnKEWOLkJQUtf7iwlRWX3rcK50o=;
	h=date:mime-version:subject:message-id:from;

iommu_device_register() links the embedded iommu_device into the IOMMU
core's global device list. The VSI driver can be built as a module, but
has no remove callback to unregister the device before devres frees the
containing struct vsi_iommu.

With no attached consumer holding a module reference, unloading
vsi-iommu.ko succeeds. A later platform device registration enters the
IOMMU bus notifier and scans the stale list entry. KASAN reports a
slab-use-after-free in __iommu_probe_device().

The missing unregister operation on driver unbind was also noted during
review of the driver's fwnode lookup lifetime handling.

Add the missing remove callback. Unregister the IOMMU device and remove
its sysfs object while the provider is still alive. Release the exact
shared IRQ action before forcing runtime suspend, then unprepare the
clocks acquired during probe.

The failure was reproduced on the 2026-08-11 IOMMU next snapshot with
real module load and unload syscalls. With the same KASAN kernel, the
unmodified driver produced two invalid reads from the same freed list
entry. The patched driver removed the entry, completed the later device
registration and produced no KASAN, WARNING, Oops or panic.

The remove callback also builds with W=1 for arm64 with
ARCH_ROCKCHIP=y and CONFIG_PM=y, and for the arm64 COMPILE_TEST path
with CONFIG_PM=n.

A standalone reproducer, the vulnerable and fixed serial logs, and
their checksums are available at:

https://github.com/kimaiden1984-boop/linux-vsi-iommu-unload-uaf-reproducer

Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
Link: https://lore.kernel.org/0e405cb3-1227-4ad2-96ff-aa0db3124381@arm.com/
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
The QEMU helper supplies the platform device, MMIO resource, IRQ and
firmware node normally provided by RK3588 hardware. The failing access
occurs while the IOMMU core scans its provider list, before VSI register
access.

Not tested on physical RK3588 hardware: removal with an attached
decoder, a runtime-active device, or concurrent interrupt delivery.

 drivers/iommu/vsi-iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 42c424496..7fa7ee8cf 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -728,6 +728,17 @@ static int vsi_iommu_probe(struct platform_device *pdev)
 	return err;
 }
 
+static void vsi_iommu_remove(struct platform_device *pdev)
+{
+	struct vsi_iommu *iommu = platform_get_drvdata(pdev);
+
+	iommu_device_unregister(&iommu->iommu);
+	iommu_device_sysfs_remove(&iommu->iommu);
+	devm_free_irq(&pdev->dev, iommu->irq, iommu);
+	pm_runtime_force_suspend(&pdev->dev);
+	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
+}
+
 static void vsi_iommu_shutdown(struct platform_device *pdev)
 {
 	struct vsi_iommu *iommu = platform_get_drvdata(pdev);
@@ -776,6 +787,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(vsi_iommu_pm_ops,
 
 static struct platform_driver rockchip_vsi_iommu_driver = {
 	.probe = vsi_iommu_probe,
+	.remove = vsi_iommu_remove,
 	.shutdown = vsi_iommu_shutdown,
 	.driver = {
 		   .name = "vsi_iommu",
-- 
2.39.5

