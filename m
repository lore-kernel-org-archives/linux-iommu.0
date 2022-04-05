Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1C5C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 13:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42ED860B15;
	Tue,  5 Apr 2022 13:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id InCS9g_Fn6Ut; Tue,  5 Apr 2022 13:46:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 03BDC60A6C;
	Tue,  5 Apr 2022 13:46:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBCFDC002C;
	Tue,  5 Apr 2022 13:46:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58CE3C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E70440940
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 31i1tq4coC1r for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 13:46:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39C0C405AE
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:46:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76DA0D6E;
 Tue,  5 Apr 2022 06:46:35 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEAE63F5A1;
 Tue,  5 Apr 2022 06:46:34 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: ogabbay@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: Stop using iommu_present()
Date: Tue,  5 Apr 2022 14:46:31 +0100
Message-Id: <8201946a5b8b26dab35738b87da24ff27a9f9270.1649166391.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Even if an IOMMU might be present for some PCI segment in the system,
that doesn't necessarily mean it provides translation for the device
we care about. Replace iommu_present() with a more appropriate check.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 8 ++++----
 drivers/misc/habanalabs/goya/goya.c   | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 21c2b678ff72..5dc66dc7618e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6133,7 +6133,7 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 
 		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
 
@@ -6176,7 +6176,7 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 
 		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 
@@ -6223,7 +6223,7 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 
 		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
 
@@ -6268,7 +6268,7 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 
 		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ec9358bcbf0b..0c455bf460f4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4309,7 +4309,7 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
 
 	} else {
@@ -4369,7 +4369,7 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 
 	} else {
@@ -4418,7 +4418,7 @@ static int goya_debugfs_read64(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
 
 	} else {
@@ -4465,7 +4465,7 @@ static int goya_debugfs_write64(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 
 	} else {
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
