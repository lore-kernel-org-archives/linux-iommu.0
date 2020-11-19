Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA2FC63697
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 17:00:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E70E24654
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 17:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E70E24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C75B387450;
	Thu, 19 Nov 2020 17:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YAHJgx9-Mtrn; Thu, 19 Nov 2020 17:00:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C9E8587459;
	Thu, 19 Nov 2020 17:00:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FDBDC1836;
	Thu, 19 Nov 2020 17:00:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73E24C0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 17:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6004B86D86
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 17:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CM-blXx7f1DK for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 17:00:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 513EF86D84
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 17:00:40 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcQsY5PPyzhdHQ;
 Fri, 20 Nov 2020 01:00:17 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.210.168.73) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 01:00:22 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH] iommu: Check return of __iommu_attach_device()
Date: Thu, 19 Nov 2020 16:58:46 +0000
Message-ID: <20201119165846.34180-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.210.168.73]
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, linuxarm@huawei.com
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

Currently iommu_create_device_direct_mappings() is called
without checking the return of __iommu_attach_device(). This
may result in failures in iommu driver if dev attach returns
error.

Fixes: ce574c27ae27("iommu: Move iommu_group_create_direct_mappings() out of iommu_group_add_device()")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
Crash log:
[   31.353605] hns3 0000:7d:00.3: Adding to iommu group 10
[   31.358822] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
[   31.367567] Mem abort info:
[   31.370350]   ESR = 0x96000004
[   31.373391]   EC = 0x25: DABT (current EL), IL = 32 bits
[   31.378680]   SET = 0, FnV = 0
[   31.381720]   EA = 0, S1PTW = 0
[   31.384847] Data abort info:
[   31.387716]   ISV = 0, ISS = 0x00000004
[   31.391535]   CM = 0, WnR = 0
[   31.394491] [0000000000000018] user address but active_mm is swapper
[   31.400818] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   31.406365] Modules linked in:
[   31.409409] CPU: 21 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc4-00008-gdd5aba9d719-dirty #79
[   31.417980] Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, BIOS 2280-V2 CS V3.B220.01 03/19/2020
[   31.427588] pstate: 00c00009 (nzcv daif +PAN +UAO -TCO BTYPE=--)
[   31.433566] pc : arm_smmu_tlb_inv_range+0x178/0x1f0
[   31.438422] lr : arm_smmu_tlb_inv_range+0x5c/0x1f0
[   31.443190] sp : ffff80001043b4e0
...
[   31.531175] Call trace:
[   31.533613]  arm_smmu_tlb_inv_range+0x178/0x1f0
[   31.538122]  arm_smmu_iotlb_sync+0x2c/0x38
[   31.542200]  iommu_unmap+0x60/0x90
[   31.545585]  __iommu_map+0x110/0x1f0
[   31.549144]  iommu_create_device_direct_mappings.isra.34+0x1ac/0x250
[   31.555468]  iommu_probe_device+0x6c/0x110
[   31.559551]  iort_iommu_configure_id+0x114/0x218
[   31.564148]  acpi_dma_configure_id+0x94/0xe0
[   31.568402]  pci_dma_configure+0xc8/0xf0
[   31.572310]  really_probe+0xd4/0x3e0
[   31.575871]  driver_probe_device+0x5c/0xc0

---
 drivers/iommu/iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b53446bb8c6b..0f4dc25d46c9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -264,16 +264,18 @@ int iommu_probe_device(struct device *dev)
 	 */
 	iommu_alloc_default_domain(group, dev);
 
-	if (group->default_domain)
+	if (group->default_domain) {
 		ret = __iommu_attach_device(group->default_domain, dev);
+		if (ret) {
+			iommu_group_put(group);
+			goto err_release;
+		}
+	}
 
 	iommu_create_device_direct_mappings(group, dev);
 
 	iommu_group_put(group);
 
-	if (ret)
-		goto err_release;
-
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
