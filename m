Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B44C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A43F460BEF;
	Mon, 25 Apr 2022 11:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LKxPH6k3XTHK; Mon, 25 Apr 2022 11:39:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 67A6C60B2C;
	Mon, 25 Apr 2022 11:39:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40F68C0039;
	Mon, 25 Apr 2022 11:39:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9A98C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88FBB404F7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9VlgfekP7Uq for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:39:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::607])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54C33400CE
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsxsrPevC3S6jeV2q32+KlgIRnIBXbH3IrigQmEwOrD/2e+nJdz4Hsk3as0f1ECLjnmQ+ilByIwgjGWi32C80NGtKfEU0RNdTRh04T+RURGAoIa3qgn93UeX+rWyYkqXKcBuUHTZYgpdHx28haluebxxWtuiQ/54L3q+mG7dx1eMlKvgjEPZ/WwjXhmTX42nTMikM78+8i6okdAMFCLvSmGU31J6DgkKtPGN6RAQ64HWZnnBMKCti3a+hI4040fheRfMcx/QVhJmB9YUrT9RorKIBhkJsm7cWXbhGr/0nKjf6qnBq6uTo1ZEmRCIItWYyCsr7r5BlvRBKgt3jF7aMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeAf5lB25ObCZ9EVYN+3IknbD6ehm6yy/8WUXhMTJdc=;
 b=Vbh4rTNXpCLG/6RCVbbwt6GQ3Km5p9K2R08F7Yl6oNSK1vfK3uBKUOks84tAU8oLqed7CCsHZRyj/EyhlizXh71jTbG6QNkDnMy63EAc3uxTxIoXzEHVBYKdE6yCdAeTaToTf+WuKkdvLAsY/PceFK84dIRVl3Kc3ZXXRs/8MQV22AmQLBEOPLS+jAo2c8qKMBPweQv8DhqXJfA6vPW6QpVY2BcHEpru2NHtEidQot41jEMjr9YAZSDDxpiThM1qVmMniK3x0xjAvvqeeOaK0vaO7fGNSBoE5POioxyPNwokpmihyyccttBto0lCYAMsV7uTl7fbu30oL1CIdMrxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeAf5lB25ObCZ9EVYN+3IknbD6ehm6yy/8WUXhMTJdc=;
 b=Iot2zd8OEctMihia4uhyuvQOd4LnuHB0v8Vlklu+AzeqL4VeyjQ38n2jPLMWfU8LQbTJwGI59u6YB4s/p3kNaQU0/dqvxaIdyLy5sorujTFxYQipYO4cYWC2MEShmgQK6LSgp9s6jHzyC48wt+h85CbAvjxzlljXyjNACWnCxDY=
Received: from BN1PR10CA0022.namprd10.prod.outlook.com (2603:10b6:408:e0::27)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Mon, 25 Apr
 2022 11:39:16 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::eb) by BN1PR10CA0022.outlook.office365.com
 (2603:10b6:408:e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:39:16 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:39:14 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 17/37] iommu/amd: Introduce struct amd_ir_data.iommu
Date: Mon, 25 Apr 2022 17:03:55 +0530
Message-ID: <20220425113415.24087-18-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4d4a1a-3d28-4155-4791-08da26b03a4f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4518:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB451823015576352EF68DBA5687F89@MN2PR12MB4518.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIp/8GbkF8LA9vmcIiRlsKq78FTukHzrQIOePAs/VArUz7GdE/d3W9Pp6ByP80bYdEL5z6qW/1BQoXiElO3vJiarjTNlQBtBWgU1268G4hR82xBH70JP4zKcljdImcnibS4lEW/wwz1RybMo3PVxcV4prAGS1Q+m/lrOjUxM+YTnrW/AK1KN7Kol0TjkY2cF4700jZphIqyl05KwXWBiQjF0Xdu5YS1Wz2aYfOq/85ciJBcGVGvgxI87/feWtaehjG1oeEfULaf0XMk4tRmSXA52qYE7TWCYIxNXhBeZ1H7tbf1uXypzSdUpoPXRaQE/wKXR+SVMJxsWLQQ4DjOcfHHIbjkw+Qr7kmBRaScFEa02TSNE4t5BQwUbudlrMQ273n7/JIHmWIXnGwFl5TvWdWb3ib/VGimaTAauUBEcwtHdFTJe6l0vJKAm1WMPbufWI1uovfByBnvXpfUb1Ae0iOBQv9NnQjkA+SFqVYDcdZ1LW2bt2xD7C7xsWpVZH2AAly7pY6u64C62xgeLf2sfMz9OwnaNqkd3gz3TWHEw6+BSqHaDwltMGN267/Ulh26XdpRZYY+5ANX7dDwFRE9hfucl5Q+mBh4lOiIDnJiqMXlZWizPgZoa6CLzf5RI80frDp6btLH0txDjWOi83U59Dh/f78dan6fiYPEZzE5hn4gVynYMCjwypfyJAc/k3nUYlQyf2Q1I/rO1wtkq6rTQEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(83380400001)(316002)(2616005)(426003)(1076003)(336012)(47076005)(81166007)(6666004)(356005)(5660300002)(16526019)(186003)(508600001)(86362001)(26005)(8936002)(36860700001)(40460700003)(82310400005)(6916009)(36756003)(44832011)(54906003)(70206006)(8676002)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:39:16.0095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4d4a1a-3d28-4155-4791-08da26b03a4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add a pointer to struct amd_iommu to amd_ir_data structure, which
can be used to correlate interrupt remapping data to a per-PCI-segment
interrupt remapping table.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 34 +++++++++++++----------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index badf49d2371c..0ef9ecb8d3fc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -981,6 +981,7 @@ struct irq_2_irte {
 
 struct amd_ir_data {
 	u32 cached_ga_tag;
+	struct amd_iommu *iommu;
 	struct irq_2_irte irq_2_irte;
 	struct msi_msg msi_entry;
 	void *entry;    /* Pointer to union irte or struct irte_ga */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c6b8a1f95b55..b34d0851866b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3000,16 +3000,11 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	return 0;
 }
 
-static void free_irte(u16 devid, int index)
+static void free_irte(struct amd_iommu *iommu, u16 devid, int index)
 {
 	struct irq_remap_table *table;
-	struct amd_iommu *iommu;
 	unsigned long flags;
 
-	iommu = amd_iommu_rlookup_table[devid];
-	if (iommu == NULL)
-		return;
-
 	table = get_irq_table(iommu, devid);
 	if (!table)
 		return;
@@ -3193,7 +3188,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 				       int devid, int index, int sub_handle)
 {
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+	struct amd_iommu *iommu = data->iommu;
 
 	if (!iommu)
 		return;
@@ -3334,6 +3329,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 			goto out_free_data;
 		}
 
+		data->iommu = iommu;
 		irq_data->hwirq = (devid << 16) + i;
 		irq_data->chip_data = data;
 		irq_data->chip = &amd_ir_chip;
@@ -3350,7 +3346,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 			kfree(irq_data->chip_data);
 	}
 	for (i = 0; i < nr_irqs; i++)
-		free_irte(devid, index + i);
+		free_irte(iommu, devid, index + i);
 out_free_parent:
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 	return ret;
@@ -3369,7 +3365,7 @@ static void irq_remapping_free(struct irq_domain *domain, unsigned int virq,
 		if (irq_data && irq_data->chip_data) {
 			data = irq_data->chip_data;
 			irte_info = &data->irq_2_irte;
-			free_irte(irte_info->devid, irte_info->index);
+			free_irte(data->iommu, irte_info->devid, irte_info->index);
 			kfree(data->entry);
 			kfree(data);
 		}
@@ -3387,7 +3383,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
 {
 	struct amd_ir_data *data = irq_data->chip_data;
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = data->iommu;
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 
 	if (!iommu)
@@ -3404,7 +3400,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 {
 	struct amd_ir_data *data = irq_data->chip_data;
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = data->iommu;
 
 	if (iommu)
 		iommu->irte_ops->deactivate(data->entry, irte_info->devid,
@@ -3500,12 +3496,16 @@ EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
 static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 {
 	int ret;
-	struct amd_iommu *iommu;
 	struct amd_iommu_pi_data *pi_data = vcpu_info;
 	struct vcpu_data *vcpu_pi_info = pi_data->vcpu_data;
 	struct amd_ir_data *ir_data = data->chip_data;
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
-	struct iommu_dev_data *dev_data = search_dev_data(NULL, irte_info->devid);
+	struct iommu_dev_data *dev_data;
+
+	if (ir_data->iommu == NULL)
+		return -EINVAL;
+
+	dev_data = search_dev_data(ir_data->iommu, irte_info->devid);
 
 	/* Note:
 	 * This device has never been set up for guest mode.
@@ -3527,10 +3527,6 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 		pi_data->is_guest_mode = false;
 	}
 
-	iommu = amd_iommu_rlookup_table[irte_info->devid];
-	if (iommu == NULL)
-		return -EINVAL;
-
 	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
 		ir_data->ga_root_ptr = (pi_data->base >> 12);
@@ -3576,7 +3572,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct irq_data *parent = data->parent_data;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = ir_data->iommu;
 	int ret;
 
 	if (!iommu)
@@ -3646,7 +3642,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	    !ref || !entry || !entry->lo.fields_vapic.guest_mode)
 		return 0;
 
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = ir_data->iommu;
 	if (!iommu)
 		return -ENODEV;
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
