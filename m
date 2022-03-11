Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CF7C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18A0A611FA;
	Fri, 11 Mar 2022 09:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30osBkHDk1tf; Fri, 11 Mar 2022 09:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C151A611D9;
	Fri, 11 Mar 2022 09:56:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA4FEC0012;
	Fri, 11 Mar 2022 09:56:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B6AEC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B1B1418F1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LVCVo--JXOQ9 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:56:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::617])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52C01418E6
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdcFqBPdFPkwhM7RkmAelAowdO1eTxZYYgUbcwkof+NCd7vgLmwtWK4//eZJE0AkqgURMKXMN8I0OkhGAbXhlOgOybbC1+TooydqtyxNBOlY2m+h/uLtqZmZfho1qscMj1XBvG5GxqM5YfudYJpzamiQRyZ7bBm+u4z+p09MxaQgkDIfJWPv4zQHvWQyEGe1SnZ0B2NYFcSwWDXqCtKn4+mxjx6hW4qHD+p1y/K3nFoC4bKzh3/JfO29BiZ3G96PywrZa/LuYDdxoDUyOe/vbu4E/InTc6EodEHZqq8CCPqxOp+ViZbr+iis3jfmN4+ObGGEM+CMt+07Z36EaGyunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xfBJ1hj/y6HEMHuZJG4QaSe+Y26ZRRUCRrOuukHw1c=;
 b=a2W2/NSRqrMHwwhoEjMlmC2xcQ+GWtX8ZZhQnds2pdeUV9WbKfWqf5U1wgtr+LF+prylS3UmHSUKNUA3I4NZ0kPRvNh52a14apN4L/gGVrW06mP0t4dLSjQ+GzBG5qtQ5mB5mkUbUQyDcZsywjH+KI9rWsI7N63E9fQL9eHk/zyzpgxGlJ9Nyc4V+9B61n4jxHO75nP5qVV8UZaZ24A4Yf3dwarC+hZOlzW8kyXsmmHBrfTMvrEuFwbWqMdKhRzt/Sxq2VUXK2jJ+CInhJIGGI+KQdJzDfwRa6Lp6ZYyxfk/NtAp2PZQVzG1w+ad98zCrnF31WeM4LQ1nz87GLJHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xfBJ1hj/y6HEMHuZJG4QaSe+Y26ZRRUCRrOuukHw1c=;
 b=x5e6OIpZlvhnhkwjS4N1UXoFZ74zZd49ffb6596dgGcM/k4vBPleaddIWemmGVbvXBGPYafMNH0kI2vl0WLjonuorri1cLU5oX3/mBvicAi76PTnuU8XgYOKyh5jcyLrPAd6muF6RHCMxJTlWS6O00f2ey6A+fnjbKwfFrdb9f0=
Received: from DM5PR19CA0072.namprd19.prod.outlook.com (2603:10b6:3:116::34)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 09:56:25 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::a3) by DM5PR19CA0072.outlook.office365.com
 (2603:10b6:3:116::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Fri, 11 Mar 2022 09:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:56:25 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:56:21 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 16/36] iommu/amd: Introduce struct amd_ir_data.iommu
Date: Fri, 11 Mar 2022 15:18:34 +0530
Message-ID: <20220311094854.31595-17-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5677012-9905-4795-c669-08da034567d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB421931EB03CD3D9D7B6C6A15870C9@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIgW1esbFlz8KlhPMpEcjSY6El5xvAqf0NrggVM/6V5t9veJHuFuJXynGX4/yWivB8Fpn1IirUaDfu/Lvy3iR/m+MlbexU7CwnbmQnuBpX80lA9QD2EW/PFu4E5VmRWWRlHLJVBiL/Jpe++/pjuLux7OAB7caCSBMLKFyGOltwrIyJOKk2R8MljZzoWStFwfYBIeyk1u3EEWlcTIoOhvjr9Qn6S3CTVBYHwjrCdXv9cPGnyof9XTeMbZyGuj/Pi7RTk9rtCStsygh9A2kGsBvD9xRJMQRcu6KinIhghUQZ3so6Yl+h9rM+0A83gDgsIesXsVKT4K6gBc/1JWtjnaua9bzsY565CLml0YfWpchzdcSHMF0fZOF0Z1agsi3qFNegHi3XYMkPcA8JbqwGPFM8CrvLo5UefYkmK2yk+C4qYhl1L8gebxcgTlfrGXVz9gO3JayKBuqwo7boOOFZfe3qDmFX/NbkPd+0MuEys6nwEP+P4S1MVbnF3iS+hDMlVjUmFicqFICoBLiYic+CFE85BuVpFA6RuTFLp03ZZm6UX5Urq2nASFHmBfVNECNMkT1HMOF3D7YDHJqwieM/936hqlD/chz0tCw/W9L2UZZ1+KwTbkQTDWuNIcRYfLjIvLrZLjpclLpnBc29Fxt2/fDxC5LaCxPQI5plOO8H2h2k9YufgaRD6MH9Fxm06ZEiUtCu+L8Zd7NZlDn1uLJViVYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(1076003)(336012)(2906002)(186003)(82310400004)(426003)(40460700003)(8676002)(6666004)(5660300002)(508600001)(86362001)(8936002)(70586007)(44832011)(47076005)(70206006)(4326008)(316002)(36860700001)(2616005)(36756003)(81166007)(356005)(110136005)(16526019)(26005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:56:25.4877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5677012-9905-4795-c669-08da034567d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
index 484d73dcbe6c..fad9f7a10413 100644
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
index 124346161258..8edf334ce7f4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2993,16 +2993,11 @@ static int modify_irte(u16 devid, int index, union irte *irte)
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
@@ -3186,7 +3181,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 				       int devid, int index, int sub_handle)
 {
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+	struct amd_iommu *iommu = data->iommu;
 
 	if (!iommu)
 		return;
@@ -3327,6 +3322,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 			goto out_free_data;
 		}
 
+		data->iommu = iommu;
 		irq_data->hwirq = (devid << 16) + i;
 		irq_data->chip_data = data;
 		irq_data->chip = &amd_ir_chip;
@@ -3343,7 +3339,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 			kfree(irq_data->chip_data);
 	}
 	for (i = 0; i < nr_irqs; i++)
-		free_irte(devid, index + i);
+		free_irte(iommu, devid, index + i);
 out_free_parent:
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 	return ret;
@@ -3362,7 +3358,7 @@ static void irq_remapping_free(struct irq_domain *domain, unsigned int virq,
 		if (irq_data && irq_data->chip_data) {
 			data = irq_data->chip_data;
 			irte_info = &data->irq_2_irte;
-			free_irte(irte_info->devid, irte_info->index);
+			free_irte(data->iommu, irte_info->devid, irte_info->index);
 			kfree(data->entry);
 			kfree(data);
 		}
@@ -3380,7 +3376,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
 {
 	struct amd_ir_data *data = irq_data->chip_data;
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = data->iommu;
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 
 	if (!iommu)
@@ -3397,7 +3393,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 {
 	struct amd_ir_data *data = irq_data->chip_data;
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = data->iommu;
 
 	if (iommu)
 		iommu->irte_ops->deactivate(data->entry, irte_info->devid,
@@ -3493,12 +3489,16 @@ EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
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
@@ -3520,10 +3520,6 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 		pi_data->is_guest_mode = false;
 	}
 
-	iommu = amd_iommu_rlookup_table[irte_info->devid];
-	if (iommu == NULL)
-		return -EINVAL;
-
 	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
 		ir_data->ga_root_ptr = (pi_data->base >> 12);
@@ -3569,7 +3565,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct irq_data *parent = data->parent_data;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = ir_data->iommu;
 	int ret;
 
 	if (!iommu)
@@ -3639,7 +3635,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
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
