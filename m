Return-Path: <SRS0=5lac=W6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC135C3A5A8
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 06:51:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0EE21883
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 06:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0EE21883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 662E6CA1;
	Tue,  3 Sep 2019 06:51:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4E994C97
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 06:51:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C359E88E
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 06:51:38 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 6F0BF84B5CCF034E3493;
	Tue,  3 Sep 2019 14:51:36 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
	(10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
	14:51:29 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
Subject: [PATCH v2 -next] iommu/arm-smmu-v3: Fix build error without
	CONFIG_PCI_ATS
Date: Tue, 3 Sep 2019 14:50:56 +0800
Message-ID: <20190903065056.17988-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190903024212.20300-1-yuehaibing@huawei.com>
References: <20190903024212.20300-1-yuehaibing@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, YueHaibing <yuehaibing@huawei.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

If CONFIG_PCI_ATS is not set, building fails:

drivers/iommu/arm-smmu-v3.c: In function arm_smmu_ats_supported:
drivers/iommu/arm-smmu-v3.c:2325:35: error: struct pci_dev has no member named ats_cap; did you mean msi_cap?
  return !pdev->untrusted && pdev->ats_cap;
                                   ^~~~~~~

ats_cap should only used when CONFIG_PCI_ATS is defined,
so use #ifdef block to guard this.

Fixes: bfff88ec1afe ("iommu/arm-smmu-v3: Rework enabling/disabling of ATS for PCI masters")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: Add arm_smmu_ats_supported() of no CONFIG_PCI_ATS
---
 drivers/iommu/arm-smmu-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 66bf641..8da93e7 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2311,6 +2311,7 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	}
 }
 
+#ifdef CONFIG_PCI_ATS
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
 	struct pci_dev *pdev;
@@ -2324,6 +2325,12 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	pdev = to_pci_dev(master->dev);
 	return !pdev->untrusted && pdev->ats_cap;
 }
+#else
+static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
+{
+	return false;
+}
+#endif
 
 static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
-- 
2.7.4


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
