Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B72FC433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B331404F0;
	Wed, 11 May 2022 07:25:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sKu25FS1moWM; Wed, 11 May 2022 07:25:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 18E884056F;
	Wed, 11 May 2022 07:25:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC820C0039;
	Wed, 11 May 2022 07:25:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8E85C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A63C960BB8
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sc-AmWD9QQkB for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:25:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E37A160B1C
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMNsmVLdecvutNGvZeEBex3U7NsGAG+0VX2ATZjvVXPfY6HxSBGYLJmJFi4nM1oh1WWCe2w18hYsUNqZ0LWvvuR+VoTvmZXrmdxn+Bwj3puG7yAd1hbj90mVu5ZSIkxyu9vB/afTgXSjxEZHqqdzHzJ3dr13fM48U7JtI7IWY5F4Z7fqIwviA0Ba9dbS5dI9QPphQo8troI2zYjL1G3lKjpLJb8jIZeses9gi13mIHEqr45SVd+D+VUxxD6hlX2LLPGZDAiFfZnRlUxa5Z0Ios+6E+alN0h5CkoyfZDMBVGdQaW+cwmpGLHfSEBSXU63iS0m3eAhOl1LDJAKz36iVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NJMD3d9O0W4Fe5eGBhlpzxy1V7An3s0kj4kMabNU78=;
 b=geyqQV83vceSPo6JGvdtQ31QoLv01iSQLn8XJ85a9JsXKNLKxXUQ5LcUBiNRoJpNw+Zby1wqOXTIBJB4duyYpawWIOTLEGg+LyDyVfk3Cj+nFotvCOx0FGlirU1W0ondYi4tMvNOT5m9GlRbZuKBRFfZ569xw/5NHHoU2m7fb7gyXCl4mSvmi+JhcDyQtJW2rqCD7P6HyrT/3zsbcu4zJvHLIQ97oWlXzN8/gky1BNda6P8HFnGmYXzM/nHKNLX/Oi/b8k395lwuJvT0SukLNNbCdYCQYN5axT93klI8lXj/qGNHXVup7jpSg69Fu6q2vwuyRjSUQY/DBqo6LDwFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NJMD3d9O0W4Fe5eGBhlpzxy1V7An3s0kj4kMabNU78=;
 b=Ixe5hTuOSiuXFSqpX5nO9/+qdLmtk8LUM51XxQwAEQlbO7k271gxdpKkpOnaBiYxDcRSOY5kecQYsKgbqLQL2l6z5k52xvC73HxLQGyTXOYEJdPFfJLnWMwG+ncKg39REs+lXMXQdU5OXCOq8sYKv/CGkbzglpsYSxletH35aVo=
Received: from DM6PR12CA0030.namprd12.prod.outlook.com (2603:10b6:5:1c0::43)
 by DM5PR12MB1756.namprd12.prod.outlook.com (2603:10b6:3:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 07:25:31 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::4f) by DM6PR12CA0030.outlook.office365.com
 (2603:10b6:5:1c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 07:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:25:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:25:28 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 13/35] iommu/amd: Introduce per PCI segment rlookup table
 size
Date: Wed, 11 May 2022 12:51:19 +0530
Message-ID: <20220511072141.15485-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 814b1c29-41de-4e2c-aa50-08da331f6e20
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1756649B5EDDFABD0DCD906E87C89@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fR5jM4Aj6n/f5Z/ECt0ANat0/+mknK1WsVuK+Ipa2VZB9kNo+Dr+jV/77OZ5pvhc+VaUwPVBHQL9i8VdZAFD6cgOA8ci5h1hH1VguQIj6Eg26fL3RSK8SU47XPPRJlTUjNlepAXZl1ClC4/gWAWsnDiujOJOQe0x05fccYhLFS/Zc9dnraXqSpKzKOqNcwPhLi9iZQZLpZIkJcl+lvp17nFJhN/DTldTXSbF1/u+F8eI0Yj/I4HI9Og0ODozAa8GgFvICsAXmgvP8BLC/SQmv0sVeCo6Bq9gV0LFY7Yu1uL2rILgOiNo27/rik56s3TEovKpOzG1ft7JWd3S9giBYLYhhPeuRvaSn08p6xD1ejtd6RlgtmIW0XFupxiOHASo/N7AvEAC0tHiL5YygmQEUwdMWllEuCf4h3eSvWJYQYtm9EgeIxBvbg08gJ4F2O2djkmVd4pP3oZTC9dklF9s63qFmJAvruzHW0Kj8XFBvplmmyoviDA9JRA+HEMf9A5xNPzZBo6W4QZEjxkk/q+1GMAIY2aYiWdbfrwf+kj45K3Ljgwgq1YzR1UJttdeaK3XwkeDFKqcfTtQOoEV+vlj69jsIMxAHxaf5mW6mT3aYO/Jdv+F1NlNquXVNagpWXi+ZLqVSLbobH15r5ioXnqWQwzXFxxCT4IyonxHKXVGvlMl+Oij3Obof78b8qWZCxrYeczLixGAFU9VeXBDCYlTpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(36860700001)(40460700003)(26005)(4326008)(6916009)(8676002)(36756003)(82310400005)(1076003)(47076005)(336012)(16526019)(186003)(426003)(316002)(70206006)(54906003)(70586007)(5660300002)(508600001)(2906002)(86362001)(6666004)(7696005)(8936002)(81166007)(356005)(83380400001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:25:31.0046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 814b1c29-41de-4e2c-aa50-08da331f6e20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
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

It will replace global "rlookup_table_size" variable.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4912e1913b96..cf3157ba1225 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -557,6 +557,9 @@ struct amd_iommu_pci_seg {
 	/* Size of the alias table */
 	u32 alias_table_size;
 
+	/* Size of the rlookup table */
+	u32 rlookup_table_size;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0d9126a92cff..018dfd0370c6 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -670,7 +670,7 @@ static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	pci_seg->rlookup_table = (void *)__get_free_pages(
 						GFP_KERNEL | __GFP_ZERO,
-						get_order(rlookup_table_size));
+						get_order(pci_seg->rlookup_table_size));
 	if (pci_seg->rlookup_table == NULL)
 		return -ENOMEM;
 
@@ -680,7 +680,7 @@ static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	free_pages((unsigned long)pci_seg->rlookup_table,
-		   get_order(rlookup_table_size));
+		   get_order(pci_seg->rlookup_table_size));
 	pci_seg->rlookup_table = NULL;
 }
 
@@ -688,9 +688,9 @@ static inline int __init alloc_irq_lookup_table(struct amd_iommu_pci_seg *pci_se
 {
 	pci_seg->irq_lookup_table = (void *)__get_free_pages(
 					     GFP_KERNEL | __GFP_ZERO,
-					     get_order(rlookup_table_size));
+					     get_order(pci_seg->rlookup_table_size));
 	kmemleak_alloc(pci_seg->irq_lookup_table,
-		       rlookup_table_size, 1, GFP_KERNEL);
+		       pci_seg->rlookup_table_size, 1, GFP_KERNEL);
 	if (pci_seg->irq_lookup_table == NULL)
 		return -ENOMEM;
 
@@ -701,7 +701,7 @@ static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	kmemleak_free(pci_seg->irq_lookup_table);
 	free_pages((unsigned long)pci_seg->irq_lookup_table,
-		   get_order(rlookup_table_size));
+		   get_order(pci_seg->rlookup_table_size));
 	pci_seg->irq_lookup_table = NULL;
 }
 
@@ -1582,6 +1582,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
 	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
+	pci_seg->rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
