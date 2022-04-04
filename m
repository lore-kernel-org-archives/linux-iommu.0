Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7B3C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7612482662;
	Mon,  4 Apr 2022 10:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9fJPETNGuAU; Mon,  4 Apr 2022 10:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E5DB825D3;
	Mon,  4 Apr 2022 10:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08551C002C;
	Mon,  4 Apr 2022 10:05:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DD89C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D7A8825BF
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DywwG1pLgLGc for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:05:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AAB782572
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krSSp49H1jDB5BHd1XZ0Ka+rpYxsec3QEZJ+N3d9Up0DN5jmkpgyiMPPDize7375xf8BzWPpzcAr5jQpHh+LzGvEtgkGPSj78HGo2OnOYrmt6+tVb+gZan6n4vuRzFmIKKk2+vqYcsnZp5O+twK0IynCaOELMdENzL8JNMTtX1fdUVMLWjJNvrQ7g+xjgJgywOWebHPxHKofgj7y8+F9Ize3wKyUfxOVRhXkYUwrVX1Y2ExMiqdc+19RMGhlmCa3QQ6Q7g9TPUikZMp+A6Gnyle1Wj7UtX0vyutmPe+cO9O75eG/x1bbWXjmysL8hx6bwj3MjTudaoqxrl66tufADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhMP9xQMUPaoXfowTRE8Dva3fYys9wQ19ThBNbCK6hA=;
 b=ED5h0XEdByfZ0nCuQNNhAs/cT12+/MgNLYt1xI134chjafYv0ESYvylHaWq9Mlx+O93qKXw7CVv68PG240HbnGschWt71MRnQarEHjPqA1G2mTfvSFb8d38NfApEl80/H8toWPFHTR9X+lxVwl5ecSrGg7+tGsx5RIib+yzzmwC8kHXeTaq+EFgOb/l1CUfv4omnas7vcreDdMTMh1bjeuDY2qgSAYco9LPGOsVV9sFtX7GCCgsmjxWWCKvZ23T1RRjIcN7Kzy2xo6Pip4TcICUxGJNFtHLCAt5wwUk6A01GSl4mhyW2lPipndRsXqyCNAHEEjUvnZF28Ymvcv5U2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhMP9xQMUPaoXfowTRE8Dva3fYys9wQ19ThBNbCK6hA=;
 b=j+Kdj5sjrffZ0R6+g28/1RglRrwMkvfD1bmbIz+r4Euy0262PKNjb/92YkNPDHNYERhxRn8uSv0DPYidAgB7uI9/XTblcZbsQSKhZgbjdUDExYslKTN9sc2jrQzGpeTikN5OKiqDqqF75Z9bnK1Xa8sbu/Q0hoZvjpiuY251+j8=
Received: from BN9PR03CA0329.namprd03.prod.outlook.com (2603:10b6:408:112::34)
 by BN6PR1201MB0114.namprd12.prod.outlook.com (2603:10b6:405:4d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:05:21 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::73) by BN9PR03CA0329.outlook.office365.com
 (2603:10b6:408:112::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:05:20 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:05:17 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 18/37] iommu/amd: Update amd_irte_ops functions
Date: Mon, 4 Apr 2022 15:30:04 +0530
Message-ID: <20220404100023.324645-19-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d4ab4be-e3f6-4b2e-c108-08da1622a050
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0114:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0114CE0AC7460C9523D668DE87E59@BN6PR1201MB0114.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lz2COLsYEs1O6OZZ5TaqQlQYFJL3ASUSPPQgAwjPGNrQFGuBvvuFT3tkkFv3/Yt7BCtl7O1oopArmkd6yuqYl/QXwWASOgt3BkzhDSQxe5LWPEfT9ZfWMRmlJIh1DW7puZdEpC6p1sS9Hs3djz6ZikjV5PiJqD3o+U4QyGEEbVk11X+l939YP/ngD/lutoSxI+CzO23xLMxpE+XicaOUMM3z3SbLZn5+vdGhO3bH4DHSYFDDQQmkkywXv3PSwzogp8R1Jdm80R5b10d6u5ZJJvH0SDRllC3cvQAoS9iPYh7gkQM4xHwycU3PJNq13Z+9FIOMrFfOygCnXv3bm0tsPBzZEfwF8wOTO48HsfKaaFcoxeuApC+b813wpfULamPxN6yiOUby89+6HVj9bSh0+R/ccclGM77QlYWFyQkBCcLxuOi40gE6CWfX4W3LDAlOv7lGS2c4SAHbY+tupnXV8FrRR6gbBIAbhNqI47wnTRFlFBe/a53as8/Fkj+Sbfh/D4FyVOeSi5s2K7QdA2bIs5vIN0W5pqCVs+uqwKFT2SgSRg+cPgzYQwMAi6tXW0jDF1MT0Q/JjAFo/Lx+dV9FpLmIMId+AHfIhXOBQnDKgKppZwzKJwxRrZkhoOrQ1u+DC/gdjJsZzbZ/ptmM8o9kO/UssP4yGo+G8EH4EiD2lSbnboy5VX2B1R9I9N7nE2vfd3eKgxNfTXknM7BhMmgZAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(110136005)(8676002)(4326008)(40460700003)(316002)(54906003)(44832011)(15650500001)(70206006)(2906002)(8936002)(82310400004)(5660300002)(47076005)(70586007)(36860700001)(336012)(186003)(36756003)(6666004)(86362001)(356005)(81166007)(83380400001)(16526019)(2616005)(426003)(1076003)(508600001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:05:20.0067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4ab4be-e3f6-4b2e-c108-08da1622a050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0114
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

Pass amd_iommu structure as one of the parameter to amd_irte_ops functions
since its needed to activate/deactivate the iommu.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++--
 drivers/iommu/amd/iommu.c           | 51 ++++++++++++-----------------
 2 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0ef9ecb8d3fc..990272a470aa 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -999,9 +999,9 @@ struct amd_ir_data {
 
 struct amd_irte_ops {
 	void (*prepare)(void *, u32, bool, u8, u32, int);
-	void (*activate)(void *, u16, u16);
-	void (*deactivate)(void *, u16, u16);
-	void (*set_affinity)(void *, u16, u16, u8, u32);
+	void (*activate)(struct amd_iommu *iommu, void *, u16, u16);
+	void (*deactivate)(struct amd_iommu *iommu, void *, u16, u16);
+	void (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8, u32);
 	void *(*get)(struct irq_remap_table *, int);
 	void (*set_allocated)(struct irq_remap_table *, int);
 	bool (*is_allocated)(struct irq_remap_table *, int);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0800d69ef7b4..33b69843b860 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2929,19 +2929,14 @@ static int alloc_irq_index(u16 devid, int count, bool align,
 	return index;
 }
 
-static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
-			  struct amd_ir_data *data)
+static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
+			  struct irte_ga *irte, struct amd_ir_data *data)
 {
 	bool ret;
 	struct irq_remap_table *table;
-	struct amd_iommu *iommu;
 	unsigned long flags;
 	struct irte_ga *entry;
 
-	iommu = amd_iommu_rlookup_table[devid];
-	if (iommu == NULL)
-		return -EINVAL;
-
 	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
@@ -2973,16 +2968,12 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	return 0;
 }
 
-static int modify_irte(u16 devid, int index, union irte *irte)
+static int modify_irte(struct amd_iommu *iommu,
+		       u16 devid, int index, union irte *irte)
 {
 	struct irq_remap_table *table;
-	struct amd_iommu *iommu;
 	unsigned long flags;
 
-	iommu = amd_iommu_rlookup_table[devid];
-	if (iommu == NULL)
-		return -EINVAL;
-
 	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
@@ -3044,49 +3035,49 @@ static void irte_ga_prepare(void *entry,
 	irte->lo.fields_remap.valid       = 1;
 }
 
-static void irte_activate(void *entry, u16 devid, u16 index)
+static void irte_activate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
 {
 	union irte *irte = (union irte *) entry;
 
 	irte->fields.valid = 1;
-	modify_irte(devid, index, irte);
+	modify_irte(iommu, devid, index, irte);
 }
 
-static void irte_ga_activate(void *entry, u16 devid, u16 index)
+static void irte_ga_activate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
 
 	irte->lo.fields_remap.valid = 1;
-	modify_irte_ga(devid, index, irte, NULL);
+	modify_irte_ga(iommu, devid, index, irte, NULL);
 }
 
-static void irte_deactivate(void *entry, u16 devid, u16 index)
+static void irte_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
 {
 	union irte *irte = (union irte *) entry;
 
 	irte->fields.valid = 0;
-	modify_irte(devid, index, irte);
+	modify_irte(iommu, devid, index, irte);
 }
 
-static void irte_ga_deactivate(void *entry, u16 devid, u16 index)
+static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
 
 	irte->lo.fields_remap.valid = 0;
-	modify_irte_ga(devid, index, irte, NULL);
+	modify_irte_ga(iommu, devid, index, irte, NULL);
 }
 
-static void irte_set_affinity(void *entry, u16 devid, u16 index,
+static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
 			      u8 vector, u32 dest_apicid)
 {
 	union irte *irte = (union irte *) entry;
 
 	irte->fields.vector = vector;
 	irte->fields.destination = dest_apicid;
-	modify_irte(devid, index, irte);
+	modify_irte(iommu, devid, index, irte);
 }
 
-static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
+static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
 				 u8 vector, u32 dest_apicid)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
@@ -3097,7 +3088,7 @@ static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
 					APICID_TO_IRTE_DEST_LO(dest_apicid);
 		irte->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(dest_apicid);
-		modify_irte_ga(devid, index, irte, NULL);
+		modify_irte_ga(iommu, devid, index, irte, NULL);
 	}
 }
 
@@ -3386,7 +3377,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
 	if (!iommu)
 		return 0;
 
-	iommu->irte_ops->activate(data->entry, irte_info->devid,
+	iommu->irte_ops->activate(iommu, data->entry, irte_info->devid,
 				  irte_info->index);
 	amd_ir_update_irte(irq_data, iommu, data, irte_info, cfg);
 	return 0;
@@ -3400,7 +3391,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 	struct amd_iommu *iommu = data->iommu;
 
 	if (iommu)
-		iommu->irte_ops->deactivate(data->entry, irte_info->devid,
+		iommu->irte_ops->deactivate(iommu, data->entry, irte_info->devid,
 					    irte_info->index);
 }
 
@@ -3455,7 +3446,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	return modify_irte_ga(ir_data->irq_2_irte.devid,
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
@@ -3485,7 +3476,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	entry->hi.fields.destination =
 				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 
-	return modify_irte_ga(ir_data->irq_2_irte.devid,
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
@@ -3557,7 +3548,7 @@ static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
 	 * Atomically updates the IRTE with the new destination, vector
 	 * and flushes the interrupt entry cache.
 	 */
-	iommu->irte_ops->set_affinity(ir_data->entry, irte_info->devid,
+	iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
 				      irte_info->index, cfg->vector,
 				      cfg->dest_apicid);
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
