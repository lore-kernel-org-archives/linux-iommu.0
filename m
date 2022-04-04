Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22B8C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 12:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B8BE605A1;
	Mon,  4 Apr 2022 12:44:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tj1wCaDLB17; Mon,  4 Apr 2022 12:44:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A4F37600C9;
	Mon,  4 Apr 2022 12:44:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A4EAC001D;
	Mon,  4 Apr 2022 12:44:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 551F4C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBE4D40320
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SU-Uix-7rFbA for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 12:44:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0BC4540492
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:44:49 +0000 (UTC)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX9QC3msTz67wsC;
 Mon,  4 Apr 2022 20:41:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 14:44:46 +0200
Received: from A2006125610.china.huawei.com (10.47.93.34) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:44:38 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v9 11/11] iommu/arm-smmu: Get associated RMR info and install
 bypass SMR
Date: Mon, 4 Apr 2022 13:42:09 +0100
Message-ID: <20220404124209.1086-12-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.93.34]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Jon Nettleton <jon@solid-run.com>

Check if there is any RMR info associated with the devices behind
the SMMU and if any, install bypass SMRs for them. This is to
keep any ongoing traffic associated with these devices alive
when we enable/reset SMMU during probe().

Signed-off-by: Jon Nettleton <jon@solid-run.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 9a5b785d28fd..d1d0473b8b88 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2068,6 +2068,54 @@ err_reset_platform_ops: __maybe_unused;
 	return err;
 }
 
+static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
+{
+	struct list_head rmr_list;
+	struct iommu_resv_region *e;
+	int idx, cnt = 0;
+	u32 reg;
+
+	INIT_LIST_HEAD(&rmr_list);
+	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
+
+	/*
+	 * Rather than trying to look at existing mappings that
+	 * are setup by the firmware and then invalidate the ones
+	 * that do no have matching RMR entries, just disable the
+	 * SMMU until it gets enabled again in the reset routine.
+	 */
+	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
+	reg |= ARM_SMMU_sCR0_CLIENTPD;
+	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);
+
+	list_for_each_entry(e, &rmr_list, list) {
+		const u32 *sids = e->fw_data.rmr.sids;
+		u32 num_sids = e->fw_data.rmr.num_sids;
+		int i;
+
+		for (i = 0; i < num_sids; i++) {
+			idx = arm_smmu_find_sme(smmu, sids[i], ~0);
+			if (idx < 0)
+				continue;
+
+			if (smmu->s2crs[idx].count == 0) {
+				smmu->smrs[idx].id = sids[i];
+				smmu->smrs[idx].mask = 0;
+				smmu->smrs[idx].valid = true;
+			}
+			smmu->s2crs[idx].count++;
+			smmu->s2crs[idx].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[idx].privcfg = S2CR_PRIVCFG_DEFAULT;
+
+			cnt++;
+		}
+	}
+
+	dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
+		   cnt == 1 ? "" : "s");
+	iort_put_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -2189,6 +2237,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, smmu);
+
+	/* Check for RMRs and install bypass SMRs if any */
+	arm_smmu_rmr_install_bypass_smr(smmu);
+
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
