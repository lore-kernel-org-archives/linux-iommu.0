Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7684C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 951B2410E5;
	Mon,  4 Apr 2022 10:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AlUr1D11j4o9; Mon,  4 Apr 2022 10:05:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 009EC4091C;
	Mon,  4 Apr 2022 10:05:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBA43C002C;
	Mon,  4 Apr 2022 10:05:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F968C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB5A440498
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AH1Zdh34OE77 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:05:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::615])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 067934048B
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZkn43/no2VIQCB1Y7AJUpakL608xlU6Tldp0jFX+PJOuwsNAaxKOH36XN26tRkGx0CmuqSf8f/NyPRPbc7gvxZGYemMG6chGzEf5s00duGN+w60oXHUmTf7AAYdnIGv/VdYmzQBes4UBLQ/w+ebMWo9NaicZ/cCsBm89TKX03tuvpbadzqfMkTfePog+P//3IC6kHaPfO4UgMmP4w9HnIiEN1j0NhWTk3tyVexvCbT0UOE1kDdBZr4GEK9WsFOfS0XnW2dHj+LebkWsAQIEGRkWZsnGSrj1n78rmrQzEMBtmigCHYay2vilbHK3dv1uFfweQIVPWVLydZ2aeiA4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7f45+s4y2xE5D/y6p2aOwxLVCL07F5Q2Li6Y3xzCi4=;
 b=RiRBIBL/E2mr/nii/VYV+vPhjXcUIpF6jlADlPMG3pl/A7K6rAZ+amPgIrt2TgZJ8NYRXNQWP+veY9BOvK4ThIdy4oD/w6AoAJowsedyzSDtIDMoEI8ko4FMlf7H4hyMlioZiDVpKpsZhV40wQmje/VUsJzecLtcGWMEEY6FQthZ6mwI990ZFj+EfY3vtIXQ1L8EnwkIZu7RrHvExmrdxgU6SPNNkU0VwDVLrG6Ld04elULMURsaXZcOm6sdZTb/aY9IOFXAQDbq48Ouj12i8IWm9G3Dq69F8ptMchlcT1M1ixZQazucmgAolG9/5G9vhNEStjF5nLKFV/6+gIgL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7f45+s4y2xE5D/y6p2aOwxLVCL07F5Q2Li6Y3xzCi4=;
 b=sHNgrHYu5ywy5s3HHYNtQapqgQz+hzlI6oAV0/uKgTjaM37o3ji5Nx1zUQdHhpcs6U30beE3M0WNb5pb3wzF8fyPvV8PME3pbtOxL60w+25jOvObu+t3oolVI7JpZHorHND9uwbcdONH8uOWoS+HSS6rn2VMd077lRdco6OYwxc=
Received: from BN6PR22CA0060.namprd22.prod.outlook.com (2603:10b6:404:ca::22)
 by BYAPR12MB4632.namprd12.prod.outlook.com (2603:10b6:a03:110::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:05:05 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::34) by BN6PR22CA0060.outlook.office365.com
 (2603:10b6:404:ca::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:05:04 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:05:02 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 17/37] iommu/amd: Introduce struct amd_ir_data.iommu
Date: Mon, 4 Apr 2022 15:30:03 +0530
Message-ID: <20220404100023.324645-18-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21f342a9-0c1a-48b3-2765-08da1622973d
X-MS-TrafficTypeDiagnostic: BYAPR12MB4632:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4632EE3E425F9BF1194E4D4287E59@BYAPR12MB4632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjSV3jmX9baysi6kMSECRMcxIVMsnBgxihcC3Jx20RDW1kW4ocG3l55lO0CQrlr3AwpqGxiUc283ZvKyN/sbWpGEOQg/H2/8jL0ryCyeh1yBBi+Hg20REGUAPLZs9ENyQlatem8cFt1J7T3NqHT837+vIYe1Z5LWj8WjHA+fOwLyTFwaImRYbVCHMiYUbH+BBYPB4x11wd5no//zV6hD5i59Lu2A+1FquaORHFXR9ZGwszFX8xyPPD90gWM2cM3YRc/psVtlIXJQjKX4VZcYckAeyQ3ekppZjjTLK12URf69FeCkG6jZdvV7UFuVHh8hEw0TZbFVn5lQVhVEq0Yb8vhN5yX/l3U7XmeVSdMlvn0RgQB7gxEynLxejVWT97uIpSAyXVWHrMPTeFcW3drpYg4rsC7IUztJKVcA256e0b7YOF8Den0vAVB0gDyYgG4Lrn9QrbK8Is93XZ1tKGu/K9NJtpliqd4U3LR332uY0LslZ5TWFYa6ayOYvq/XAN/jI0NPExMX9Sl+mwd/a12kaEoeRIuh8+M3OW4ZRofJ+GgC3fBdVt23s2R06EgXv+X/gSMY659FjcL5QJlhQnCrtBJe51O2B2n7cSx9xcanZ9CZy59aaJl1AcliWBWEBoyo1v3W/SRu1uin+EWpH0LRYuk/hltV4rA2ub02t5UrgLv65BzxDJhHW+Yf9qf8BK76v8R0TeBZ+1Y1oNx3rhDlEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(40460700003)(110136005)(16526019)(316002)(54906003)(26005)(186003)(2616005)(36756003)(1076003)(508600001)(83380400001)(426003)(82310400004)(86362001)(70586007)(36860700001)(5660300002)(81166007)(356005)(2906002)(47076005)(44832011)(8936002)(70206006)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:05:04.7788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f342a9-0c1a-48b3-2765-08da1622973d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4632
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
index c3941e342fb2..0800d69ef7b4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2997,16 +2997,11 @@ static int modify_irte(u16 devid, int index, union irte *irte)
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
@@ -3190,7 +3185,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 				       int devid, int index, int sub_handle)
 {
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+	struct amd_iommu *iommu = data->iommu;
 
 	if (!iommu)
 		return;
@@ -3331,6 +3326,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 			goto out_free_data;
 		}
 
+		data->iommu = iommu;
 		irq_data->hwirq = (devid << 16) + i;
 		irq_data->chip_data = data;
 		irq_data->chip = &amd_ir_chip;
@@ -3347,7 +3343,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 			kfree(irq_data->chip_data);
 	}
 	for (i = 0; i < nr_irqs; i++)
-		free_irte(devid, index + i);
+		free_irte(iommu, devid, index + i);
 out_free_parent:
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 	return ret;
@@ -3366,7 +3362,7 @@ static void irq_remapping_free(struct irq_domain *domain, unsigned int virq,
 		if (irq_data && irq_data->chip_data) {
 			data = irq_data->chip_data;
 			irte_info = &data->irq_2_irte;
-			free_irte(irte_info->devid, irte_info->index);
+			free_irte(data->iommu, irte_info->devid, irte_info->index);
 			kfree(data->entry);
 			kfree(data);
 		}
@@ -3384,7 +3380,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
 {
 	struct amd_ir_data *data = irq_data->chip_data;
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = data->iommu;
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 
 	if (!iommu)
@@ -3401,7 +3397,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 {
 	struct amd_ir_data *data = irq_data->chip_data;
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = data->iommu;
 
 	if (iommu)
 		iommu->irte_ops->deactivate(data->entry, irte_info->devid,
@@ -3497,12 +3493,16 @@ EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
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
@@ -3524,10 +3524,6 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 		pi_data->is_guest_mode = false;
 	}
 
-	iommu = amd_iommu_rlookup_table[irte_info->devid];
-	if (iommu == NULL)
-		return -EINVAL;
-
 	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
 		ir_data->ga_root_ptr = (pi_data->base >> 12);
@@ -3573,7 +3569,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct irq_data *parent = data->parent_data;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = ir_data->iommu;
 	int ret;
 
 	if (!iommu)
@@ -3643,7 +3639,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
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
