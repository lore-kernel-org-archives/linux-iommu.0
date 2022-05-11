Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B955C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37BF580C80;
	Wed, 11 May 2022 07:26:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rn0Q79mBQ0dm; Wed, 11 May 2022 07:26:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED1CD80BEC;
	Wed, 11 May 2022 07:26:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8A20C0039;
	Wed, 11 May 2022 07:26:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66CFAC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47A6D605AE
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oZtHv7caj_PJ for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:26:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 635086058B
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR+baFMDWZKiCmiIxFnl+mWnno0fp3fd/dwNw/ErRwtwjeVa4QViTioNADd7rOLC6eZAMbW1+cX0YqEb9LvLJZi5uy2/8Ty+k1dViwX6xdtP0Gly9lNp1O8sFC3X8gbYTArv47Ju3F0LX5JglMPVUHxkzc6VOYPLOIF1oLVnkxxe2zsF8rZgHMw9fXGXcLcgNusJDgYJsQOAGc89LK3cZUWAt+3TmoGJpTTtWsDZVNvAPeE777Z09B4KqClRdKZ6PtnuRweeIbANBd3oFKaQS+ZL6TYuYnROVrfu+YjY0YpmssxSET44WyNp6xCMk1XYtB8coXWbrUDvt4x5fWY/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCkMISpSSKJbEsPDTwT5tOP204wvarp4H5u46vx3EWk=;
 b=gwdcA/+RKHUfvIqUrXVB0Kk95bKgY+8LYXNP319UxsI8AnsbuQifdGMLfJkgJe7r01OangktqV+2Z9epSikX8sx28I7gNPFRnVPK1oj7drZDm+fqRW6ZMTwL2oAj6d8wpqa7h1H+ThnsZPfjwZsRX73BuIcxtOmpXeVKcF55iw1nrg0k7eQTPMBgLotWuqegOD2eqZJNRTHzRSUvoRiY4axU0Hq6V4ZegMsTGcCDIOjhl7u4VerMr4D5gr1JPcOHbIqiN4WQzV0Q/nd+G/GxwLDYltrV6m9yOoQ6CC46mdKnvHrkhgnLB3pzX8zV89xo7lJQhVMnvfD+m/SPnQHZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCkMISpSSKJbEsPDTwT5tOP204wvarp4H5u46vx3EWk=;
 b=mq92IJosbI/27F4KN5nhJ/0qyjh01psR83zQVxHTHGUx5AKP/xWT8YwNfFTadPC6l7BNp32w2cImQYGWaz81OXDxbXwKTEwZcqztSK6tdJ+48zegPeKAdkVN8C++EFbsP1+iJBFXERdaaRwwnv1VELbJqCjDEkL07bmCqakvZak=
Received: from DS7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::11) by
 MWHPR1201MB2477.namprd12.prod.outlook.com (2603:10b6:300:e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:26:31 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::6c) by DS7P222CA0009.outlook.office365.com
 (2603:10b6:8:2e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 07:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:26:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:26:29 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 17/35] iommu/amd: Introduce struct amd_ir_data.iommu
Date: Wed, 11 May 2022 12:51:23 +0530
Message-ID: <20220511072141.15485-18-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db2c994-9132-45e2-04e9-08da331f9228
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2477:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB24778A367ABE5D8D139F192587C89@MWHPR1201MB2477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQMaiAYOpfyJPBIpSMPd/Vun4lyjWiYQWyCS+UU5jUDAgJLqrxLH9dY13u+6bmG6MGeJNEVEIGMOZuH9Y09z8NUlKnl2uVJtaSHxS/piNGKEWSUUJSsxDE9NbtkiibIAx4Gz1xZ7tpbpDTUTQVsu87WA4bs33t1KA3aQViaQCdWaPi7JBGZe0GDy9RSEQVYvHm1yF1DySoO+Wg78pd5L7YTEqSyD5UQOO0gk80qD0Xcy853DUroDpeoWFM0TRFGnHNM1vI//vCPpsOHW2pk9IbSeU6pNuOZIMsKbVrslyFUNhqOlhzoB7FnbcSk3/CVX3svS7eWCUqL887WYkHuxTLhX3Ta9Hx3iE+Q+uILsU29xh7GxbgtOn98bC8MUEUyFLUuIN5g6mTjFFYbAWbByIzX5PIiC6v6cU6/JaJVOE3QlTMqJKBgmg5g+167L12eKkJ1032DwCdB4qzQe++rSACcSMDP6lpu8aaCEdR+L9rwUaqybpbsXm4ylkbRXWuLht/rFReBA6nUlLbQnrhrOeck6mkY7ai8nwop49ncMQFwS9UmJ9DIf/zUAv9nx2RElrLVwzwCMa4SVWRGC+1r4ppcpGbakW1Ev7Ug/MutuM48ve3RIREv9AKFZoSth+heOLJNJa8UnHTIp7mEBzUxkIQFDaGxpt706ekflQQqvzaDkUmH9z8Knm1hPeW6XjD9qiCd1v8duOYUkQsQmM8SSKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(8936002)(2906002)(356005)(81166007)(36756003)(7696005)(6666004)(508600001)(5660300002)(86362001)(44832011)(54906003)(6916009)(83380400001)(316002)(36860700001)(82310400005)(40460700003)(70586007)(47076005)(336012)(426003)(8676002)(4326008)(70206006)(16526019)(2616005)(1076003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:26:31.4508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db2c994-9132-45e2-04e9-08da331f9228
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2477
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
index 79c44f6033e0..aee923f8ef9e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -985,6 +985,7 @@ struct irq_2_irte {
 
 struct amd_ir_data {
 	u32 cached_ga_tag;
+	struct amd_iommu *iommu;
 	struct irq_2_irte irq_2_irte;
 	struct msi_msg msi_entry;
 	void *entry;    /* Pointer to union irte or struct irte_ga */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 502e66d09c61..935e12fb6db4 100644
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
