Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB319C433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 16:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72A63417C7;
	Tue,  3 May 2022 16:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sy5VVBT0-uiz; Tue,  3 May 2022 16:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0FC4D417C2;
	Tue,  3 May 2022 16:35:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCEB9C0032;
	Tue,  3 May 2022 16:35:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B92F0C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A86BC8329D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yk-oZFRo3MhA for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:35:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C45A18281A
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:35:40 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt58y5jtkz67kFH;
 Wed,  4 May 2022 00:32:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 18:35:38 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 17:35:31 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v12 9/9] iommu/arm-smmu: Get associated RMR info and install
 bypass SMR
Date: Tue, 3 May 2022 17:33:30 +0100
Message-ID: <20220503163330.509-10-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, guohanjun@huawei.com,
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
Tested-by: Steven Price <steven.price@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 568cce590ccc..e02cc2d4fb4e 100644
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
+		struct iommu_iort_rmr_data *rmr;
+		int i;
+
+		rmr = container_of(e, struct iommu_iort_rmr_data, rr);
+		for (i = 0; i < rmr->num_sids; i++) {
+			idx = arm_smmu_find_sme(smmu, rmr->sids[i], ~0);
+			if (idx < 0)
+				continue;
+
+			if (smmu->s2crs[idx].count == 0) {
+				smmu->smrs[idx].id = rmr->sids[i];
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
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
