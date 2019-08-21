Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5040C3A59E
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 15:19:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C148E216F4
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 15:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C148E216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4A9D1EEF;
	Wed, 21 Aug 2019 15:19:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7DCB0E93
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 15:19:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0A66DE6
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 15:19:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA1E15A2;
	Wed, 21 Aug 2019 08:19:25 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C759F3F718; 
	Wed, 21 Aug 2019 08:19:24 -0700 (PDT)
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 5/8] iommu/arm-smmu-v3: Rework enabling/disabling of ATS
	for PCI masters
Date: Wed, 21 Aug 2019 16:17:46 +0100
Message-Id: <20190821151749.23743-6-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190821151749.23743-1-will@kernel.org>
References: <20190821151749.23743-1-will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

To prevent any potential issues arising from speculative Address
Translation Requests from an ATS-enabled PCIe endpoint, rework our ATS
enabling/disabling logic so that we enable ATS at the SMMU before we
enable it at the endpoint, and disable things in the opposite order.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 47 +++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b7b3b0ff8ed6..d7c65dfe42dc 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2286,44 +2286,52 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	}
 }
 
-static int arm_smmu_enable_ats(struct arm_smmu_master *master)
+static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
-	int ret;
-	size_t stu;
 	struct pci_dev *pdev;
 	struct arm_smmu_device *smmu = master->smmu;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
 	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
-		return -ENXIO;
+		return false;
 
 	pdev = to_pci_dev(master->dev);
-	if (pdev->untrusted)
-		return -EPERM;
+	return !pdev->untrusted && pdev->ats_cap;
+}
 
-	/* Smallest Translation Unit: log2 of the smallest supported granule */
-	stu = __ffs(smmu->pgsize_bitmap);
+static void arm_smmu_enable_ats(struct arm_smmu_master *master)
+{
+	size_t stu;
+	struct pci_dev *pdev;
+	struct arm_smmu_device *smmu = master->smmu;
 
-	ret = pci_enable_ats(pdev, stu);
-	if (ret)
-		return ret;
+	/* Don't enable ATS at the endpoint if it's not enabled in the STE */
+	if (!master->ats_enabled)
+		return;
 
-	master->ats_enabled = true;
-	return 0;
+	/* Smallest Translation Unit: log2 of the smallest supported granule */
+	stu = __ffs(smmu->pgsize_bitmap);
+	pdev = to_pci_dev(master->dev);
+	if (pci_enable_ats(pdev, stu))
+		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
 
 static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 {
 	struct arm_smmu_cmdq_ent cmd;
 
-	if (!master->ats_enabled || !dev_is_pci(master->dev))
+	if (!master->ats_enabled)
 		return;
 
+	pci_disable_ats(to_pci_dev(master->dev));
+	/*
+	 * Ensure ATS is disabled at the endpoint before we issue the
+	 * ATC invalidation via the SMMU.
+	 */
+	wmb();
 	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
 	arm_smmu_atc_inv_master(master, &cmd);
-	pci_disable_ats(to_pci_dev(master->dev));
-	master->ats_enabled = false;
 }
 
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
@@ -2338,10 +2346,10 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	list_del(&master->domain_head);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
+	arm_smmu_disable_ats(master);
 	master->domain = NULL;
+	master->ats_enabled = false;
 	arm_smmu_install_ste_for_dev(master);
-
-	arm_smmu_disable_ats(master);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -2386,12 +2394,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
-		arm_smmu_enable_ats(master);
+		master->ats_enabled = arm_smmu_ats_supported(master);
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
 		arm_smmu_write_ctx_desc(smmu, &smmu_domain->s1_cfg);
 
 	arm_smmu_install_ste_for_dev(master);
+	arm_smmu_enable_ats(master);
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
