Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E5DC433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA25E401C6;
	Wed, 11 May 2022 07:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h1bh8h9LXY4n; Wed, 11 May 2022 07:26:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2E9E9415A2;
	Wed, 11 May 2022 07:26:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 084A1C0039;
	Wed, 11 May 2022 07:26:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D733C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CEB580C28
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:26:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x1EsoLie0Qg0 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:26:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::623])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2831780BEC
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igOGrnmRlbVqAuFL5FP8LsnzSlQFlv3VHsOntkuNEvHLXS5WOclnYdL/zV+IkdrLdd4xgQkHtUrOjK9L8Xj52ONZYAu87ie9KhwgOat1u3/ddejDbkNMpk9RVTqrFF+VMbExw/FbIfrVjPYrH3rzFq2Tp7w4O3n9ZwbVA5h5P9TBCx42lm0UPb6v7zw2Yoyir+yCopy8YAekOxnfzQ/P716A8vAhJD72K6QJ9MMoEGSgi/5m+n+k3uGExtzhiwsYf+bPiyv3r2MKhyTJSzNKfjptAxvGrvfSsB4ND5Pm1DNO8ex9rgUtPpkSWJpJ9I3rOXJbzwD+7szge68UCu0eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OF8uy77WD0wk8lqQ5svlunpF2WaC5fgEV/xWfJ5gB2U=;
 b=Geqfw6rRbv5aWy6HGexCbAnZjI5K6qzIaS32myF3eEJGhqV+IloATl45JlUz+x8WbAFqGNzF6FFyd7BeppLbJ7ds0aKUKeTo1DpQCbc8FFjNokfOR4T6m17BnYyzCESF+0HuG7muvLH5q9N0W5PQR1/1v4JfJ6R8fvvO9f0EvmKzjFj1MRmSY/jH3hUKOCkR649s3TUuOzbQf1qxVurI4PSeHVkZCSJ2AgHDR2KharlsGFa9zcV2dn8IRF6rNMn5LqmoF+0nRYiTM50Zq8c9ntZ5OxyX3FlzjyPEZ9aJ3bdbkGYSJh+h2dU+xbffdSFbObwBFaFCT28zOuIs6YY4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF8uy77WD0wk8lqQ5svlunpF2WaC5fgEV/xWfJ5gB2U=;
 b=X7Xc+Z8//FoKYiqGS/qEya2qK5mbp5kiSbvRhVINH2E97DiPZ7nkq57nxQ+qDwNapL0Z6qhUwKwU++FlO1efWS6CrdlisFl8+0GooPaD2BoECm9hwCbRfDalcc1/quumtGB1BgD1Bv+KwxyIIpgtA9XLdPfcBiqa1JcXQpSHBM0=
Received: from DM6PR04CA0008.namprd04.prod.outlook.com (2603:10b6:5:334::13)
 by CY4PR1201MB0021.namprd12.prod.outlook.com (2603:10b6:910:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 07:26:47 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::be) by DM6PR04CA0008.outlook.office365.com
 (2603:10b6:5:334::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 07:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:26:46 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:26:44 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 18/35] iommu/amd: Update amd_irte_ops functions
Date: Wed, 11 May 2022 12:51:24 +0530
Message-ID: <20220511072141.15485-19-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ee8e47d-2c5f-41c9-5c0a-08da331f9b5b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0021:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0021D3ED005A736F9711238187C89@CY4PR1201MB0021.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyG40uID6DhNAu1McTQm4pUufMzXuA5hFvq6x3Ob8eVPbYmokrfS3++R/V9yaKzL8PxKO1Isukfbb9rNOQf5i20xi2QNl0sMypnq6fVpm0d+3dBcifY1N81k+DvrP+1ZQC4JN/1yai+qLhDoECHficGwwbF6RCkqe9fz7FCsIenVmj1CDJjcygoov/rX22PznYLhPFSvGuxnvA3oWVGXzpT2qGZbBFrs/TMEkrJU2HDvBeoUnQcoBLh+9p9ieR5FnUhMZK45bjUYzyIm1I4Zxlyf7VdZsxismT0RIgIQSoJETAH3moFpYt/DLsGscfyKxblzzudk0+6r9vw+G3rxFCeMQMlYdEV24f/HhM2eF9LfDpzchiJmDeV3tMSNgUhoc69dZw0eWcDgAE7pb1uLB9g+wbODR51AxkYpiyIDJ1vEFlDUVdmKxz+zkQyYhAvcHY/20f8YXXYa7kW+rtZQUKD95aavWmuywdpOqukzV7kckpn4H9T+Skug2WKy3E1fg+5a3f3pOD3FpQP7Xpf5zBPPLKnkcf/o19Wzdx5FU8tZzq7APexu73XiJdD+HDvb1IxguDOU75cvpzO6fhzA9xh7IYnxQZF2HwboD9+GRmfl4p7z9Fx3Bx7m4vzr3EoQ1AcXXc9FXvCKefxqLtzJJoB6CoTs6qNWL9KF1FB4dAy2AByWeAPO8kfpAdKbco7XI9v7Vz/KnibGeq1+ZZhotQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(5660300002)(426003)(82310400005)(336012)(1076003)(86362001)(36756003)(7696005)(26005)(186003)(356005)(16526019)(81166007)(6666004)(44832011)(47076005)(8936002)(2906002)(36860700001)(6916009)(54906003)(316002)(15650500001)(8676002)(2616005)(70586007)(508600001)(4326008)(70206006)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:26:46.8867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee8e47d-2c5f-41c9-5c0a-08da331f9b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0021
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
index aee923f8ef9e..553e9910e91d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -1003,9 +1003,9 @@ struct amd_ir_data {
 
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
index 935e12fb6db4..2023bb7c2c3a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2932,19 +2932,14 @@ static int alloc_irq_index(u16 devid, int count, bool align,
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
@@ -2976,16 +2971,12 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
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
@@ -3047,49 +3038,49 @@ static void irte_ga_prepare(void *entry,
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
@@ -3100,7 +3091,7 @@ static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
 					APICID_TO_IRTE_DEST_LO(dest_apicid);
 		irte->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(dest_apicid);
-		modify_irte_ga(devid, index, irte, NULL);
+		modify_irte_ga(iommu, devid, index, irte, NULL);
 	}
 }
 
@@ -3389,7 +3380,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
 	if (!iommu)
 		return 0;
 
-	iommu->irte_ops->activate(data->entry, irte_info->devid,
+	iommu->irte_ops->activate(iommu, data->entry, irte_info->devid,
 				  irte_info->index);
 	amd_ir_update_irte(irq_data, iommu, data, irte_info, cfg);
 	return 0;
@@ -3403,7 +3394,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 	struct amd_iommu *iommu = data->iommu;
 
 	if (iommu)
-		iommu->irte_ops->deactivate(data->entry, irte_info->devid,
+		iommu->irte_ops->deactivate(iommu, data->entry, irte_info->devid,
 					    irte_info->index);
 }
 
@@ -3458,7 +3449,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	return modify_irte_ga(ir_data->irq_2_irte.devid,
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
@@ -3488,7 +3479,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	entry->hi.fields.destination =
 				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 
-	return modify_irte_ga(ir_data->irq_2_irte.devid,
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
@@ -3560,7 +3551,7 @@ static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
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
