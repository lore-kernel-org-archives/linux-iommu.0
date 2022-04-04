Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DE1C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 458DE40376;
	Mon,  4 Apr 2022 09:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iOMoNP3XcghE; Mon,  4 Apr 2022 09:44:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DD62740145;
	Mon,  4 Apr 2022 09:44:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C63EDC002C;
	Mon,  4 Apr 2022 09:44:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4F95C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2CF160C34
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F2a7iS51Za_H for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:44:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::613])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0A3B60A80
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3SGyG6e9tgqy08SFawmGemeZY2xW7vpZ0uwzJkYayRj6fOJ0IxeX6DyfobvGp7mTy20XzoB/cGHFLSL+4QQi+O+AWlj7DF6J9Yd3tC4DVA30JDHAwDoqYUuF1NaU2P3nTbg/7GWHNsoYTbJT96u8uYLIQPfCs7BNA1wcqGRwxG6JckzWKOx4/gSXcdh1lfJcp6ZxOy0aPh2YKqqRjL5HnoDxZvEKTEQ/g7KFIAaCQcM+SCZIK0yKyQgI8rbD+KRxfLzSo+BclGIGXGCw1qRsjSoll66jsc6U2XDqX54V21IJdgrduVoCEu1F9vM/DiSuUcFQkHZK16f4qlvPgbepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yxUfGvZScc85o3KvRMacIDzekVO6qudJBGtuPWvQ/Q=;
 b=EJBb18I2Jn6+wy/Tu2rH3gfTbgG8Wx620uCDtu1kePAi/DINmhxarbtRE1MWZLL2/yyMVSs/pBbnpYdGGOnSfHRjx5Fhe7ZUD38FPWDJsqGUKTWXZAOA8ktFPGgvFXk1xt3XjeQsZJPE3ssuo3xlPjiHoxG6Bjh1I7JhOrnHSrsrU+eio5mRHLlsaLbG3Wk42jRTRFJYboMH0pbYZUTVFoGTg6V13GxjzE5z4R+zTW3JN/lImlxzVGQmhVkM6swIJfzBSZ2WETi2jvWFSwlDrWVBfrNdpTr8WsCd9HhnRGfTE/WbFVJm/EJILFQIphXVoyu9KLEO8ueHemQixGEQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yxUfGvZScc85o3KvRMacIDzekVO6qudJBGtuPWvQ/Q=;
 b=kKs7FNw4bCNFyV7bUqxnikB9P7mgoMflYjTTYMKFth0pPKWALqxciXVwNDl43JI3cCWafdtujWhUCUGKd+HM3VSoJdYPLMXr9CcgrflnW0SWt5+1x0X7yBhwRnJOvMZS03Uqs5iI/POsPTm6J1bIVAbz+3q5pAp7R7PSov/BvbU=
Received: from MW4PR04CA0347.namprd04.prod.outlook.com (2603:10b6:303:8a::22)
 by DM5PR12MB1417.namprd12.prod.outlook.com (2603:10b6:3:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:44:48 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::72) by MW4PR04CA0347.outlook.office365.com
 (2603:10b6:303:8a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 09:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:44:47 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:44:45 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 06/37] iommu/amd: Introduce per PCI segment dev_data_list
Date: Mon, 4 Apr 2022 15:10:58 +0530
Message-ID: <20220404094129.323642-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dbe1927-1a1d-4aef-9ea3-08da161fc20b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1417:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1417F90F0F84AF60BD4285D787E59@DM5PR12MB1417.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9rYJIOA+go+jeMDczJf0eMr4hlZ6AntVPmWmgMpGyWVJz94Z95a5PGrd513eO1JmHfeX/GIIRCJTDoY7dC8YfAwI8pU2xpit8xz5Od8YjW3mnpd2BnTjy4zqnLiu8/Qs3aBkZgg9LjiInGsKnfX3ZNYcc3XLE8xkSTK7r4ybbGBh+ychGsvywwawSCWu+4NIDzOqHZiAwiNsVTc2EA9DCAR1PXWkOn791nMHa1jI7GiK6cqtoku8UXEqU0mdMQ2nnnquhcKkIsDynlATMr+kLpCsiVboO6KR25Wv/kMFzhsWkNH7sLzdSkBSMgCyhYSATZtZKPLIGHN+aOh+e65MR/u2LkRJW2REVY/INkkZVG3ux545mY1C3FG7pw1NlXtuG9Sc6Nxf7VyivZ/9QifMCf1O8dhnSeo8aL59XXF/mciiohOjMfMQfK/t/usvKua2b/kitVwaIZ6reZiqDqzGU7f7jFzJ3FBvPzASVEnuQKzorC61PM3bfW8SXkK/R70dlxCygEfL3cZGlyDXerDxFwmDHQ9bh6u/zFD6vZ8SCOUs6OQzTgJU+SYUTH8HSCM/PW3AdLtyymrFOLI5mHcb1A29hlOXLnyYCR6hzGrslp+MMfR4ATzSCLAgpVc3LV/YRztNX1HSTcKOqOpUSHwU2v4SgS4ZtTiKNZXzkjxh1J7J4d6otg20geQ5xbgV+6GqtDi0Ln1NG1fHLMCQHwZXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(44832011)(81166007)(36860700001)(8676002)(47076005)(4326008)(5660300002)(8936002)(40460700003)(2906002)(86362001)(186003)(83380400001)(26005)(1076003)(16526019)(36756003)(2616005)(70206006)(70586007)(6666004)(54906003)(110136005)(82310400004)(426003)(336012)(508600001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:44:47.9810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbe1927-1a1d-4aef-9ea3-08da161fc20b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1417
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

This will replace global dev_data_list.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            |  1 +
 drivers/iommu/amd/iommu.c           | 21 ++++++++++-----------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d507c96598a7..7bf35e3a1ed6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -538,6 +538,9 @@ struct protection_domain {
 struct amd_iommu_pci_seg {
 	struct list_head list;
 
+	/* List of all available dev_data structures */
+	struct llist_head dev_data_list;
+
 	/* PCI segment number */
 	u16 id;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 48db6c3164aa..27785a558d9c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1525,6 +1525,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 		return NULL;
 
 	pci_seg->id = id;
+	init_llist_head(&pci_seg->dev_data_list);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a8baa64c8f9c..2bea72f388b2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -62,9 +62,6 @@
 
 static DEFINE_SPINLOCK(pd_bitmap_lock);
 
-/* List of all available dev_data structures */
-static LLIST_HEAD(dev_data_list);
-
 LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
@@ -195,9 +192,10 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 	return container_of(dom, struct protection_domain, domain);
 }
 
-static struct iommu_dev_data *alloc_dev_data(u16 devid)
+static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
 	if (!dev_data)
@@ -207,19 +205,20 @@ static struct iommu_dev_data *alloc_dev_data(u16 devid)
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
-	llist_add(&dev_data->dev_data_list, &dev_data_list);
+	llist_add(&dev_data->dev_data_list, &pci_seg->dev_data_list);
 	return dev_data;
 }
 
-static struct iommu_dev_data *search_dev_data(u16 devid)
+static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct llist_node *node;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
-	if (llist_empty(&dev_data_list))
+	if (llist_empty(&pci_seg->dev_data_list))
 		return NULL;
 
-	node = dev_data_list.first;
+	node = pci_seg->dev_data_list.first;
 	llist_for_each_entry(dev_data, node, dev_data_list) {
 		if (dev_data->devid == devid)
 			return dev_data;
@@ -287,10 +286,10 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
 	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
-	dev_data = search_dev_data(devid);
+	dev_data = search_dev_data(iommu, devid);
 
 	if (dev_data == NULL) {
-		dev_data = alloc_dev_data(devid);
+		dev_data = alloc_dev_data(iommu, devid);
 		if (!dev_data)
 			return NULL;
 
@@ -3461,7 +3460,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	struct vcpu_data *vcpu_pi_info = pi_data->vcpu_data;
 	struct amd_ir_data *ir_data = data->chip_data;
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
-	struct iommu_dev_data *dev_data = search_dev_data(irte_info->devid);
+	struct iommu_dev_data *dev_data = search_dev_data(NULL, irte_info->devid);
 
 	/* Note:
 	 * This device has never been set up for guest mode.
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
