Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32336C282DA
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E3321734
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E3321734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7C53DDA5;
	Tue,  9 Apr 2019 17:02:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D223DDA3
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:02:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 71D62F4
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:02:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3782115BE;
	Tue,  9 Apr 2019 10:02:06 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com
	[10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D13263F68F; 
	Tue,  9 Apr 2019 10:02:03 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: will.deacon@arm.com
Subject: [PATCH v2 3/7] iommu/arm-smmu-v3: Store SteamIDs in master
Date: Tue,  9 Apr 2019 17:52:41 +0100
Message-Id: <20190409165245.26500-4-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Cc: zhongmiao@hisilicon.com, okaya@kernel.org, rjw@rjwysocki.net,
	linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
	sudeep.holla@arm.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409165241.7zzRMna3MWt6JSzPi953kjHBrtbrIR1m-fv5lHgwAqc@z>

Simplify the attach/detach code a bit by keeping a pointer to the stream
IDs in the master structure. Although not completely obvious here, it does
make the subsequent support for ATS, PRI and PASID a bit simpler.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 50cb037f3d8a..25ba546cae7f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -594,6 +594,8 @@ struct arm_smmu_device {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_strtab_ent	ste;
+	u32				*sids;
+	unsigned int			num_sids;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -1688,19 +1690,18 @@ static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	return step;
 }
 
-static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
+static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 {
 	int i, j;
-	struct arm_smmu_master *master = fwspec->iommu_priv;
 	struct arm_smmu_device *smmu = master->smmu;
 
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		u32 sid = fwspec->ids[i];
+	for (i = 0; i < master->num_sids; ++i) {
+		u32 sid = master->sids[i];
 		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
-			if (fwspec->ids[j] == sid)
+			if (master->sids[j] == sid)
 				break;
 		if (j < i)
 			continue;
@@ -1709,13 +1710,10 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 	}
 }
 
-static void arm_smmu_detach_dev(struct device *dev)
+static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct arm_smmu_master *master = fwspec->iommu_priv;
-
 	master->ste.assigned = false;
-	arm_smmu_install_ste_for_dev(fwspec);
+	arm_smmu_install_ste_for_dev(master);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -1736,7 +1734,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	/* Already attached to a different domain? */
 	if (ste->assigned)
-		arm_smmu_detach_dev(dev);
+		arm_smmu_detach_dev(master);
 
 	mutex_lock(&smmu_domain->init_mutex);
 
@@ -1770,7 +1768,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ste->s2_cfg = &smmu_domain->s2_cfg;
 	}
 
-	arm_smmu_install_ste_for_dev(fwspec);
+	arm_smmu_install_ste_for_dev(master);
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
@@ -1883,12 +1881,14 @@ static int arm_smmu_add_device(struct device *dev)
 			return -ENOMEM;
 
 		master->smmu = smmu;
+		master->sids = fwspec->ids;
+		master->num_sids = fwspec->num_ids;
 		fwspec->iommu_priv = master;
 	}
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
-	for (i = 0; i < fwspec->num_ids; i++) {
-		u32 sid = fwspec->ids[i];
+	for (i = 0; i < master->num_sids; i++) {
+		u32 sid = master->sids[i];
 
 		if (!arm_smmu_sid_in_range(smmu, sid))
 			return -ERANGE;
@@ -1922,7 +1922,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	master = fwspec->iommu_priv;
 	smmu = master->smmu;
 	if (master && master->ste.assigned)
-		arm_smmu_detach_dev(dev);
+		arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
 	kfree(master);
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
