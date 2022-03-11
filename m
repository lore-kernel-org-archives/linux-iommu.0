Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC25C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24BE681322;
	Fri, 11 Mar 2022 09:58:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oAXmR4eRW2hB; Fri, 11 Mar 2022 09:58:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E26DE8100D;
	Fri, 11 Mar 2022 09:58:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4C9AC0033;
	Fri, 11 Mar 2022 09:58:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89D38C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78D04605B7
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 508qL_qdLmPK for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:58:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::618])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE22F6058D
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a70SWfrRnEmQZnszW06YnUrUqLJICSpGLGvUL1kIT33ZK9hK0iOXdyQq7QCE7B4n81WBEnh3QIttQKJmDVQxsmkTDRuFEa4L5c6qm5WyIlUXXH03Adlpt4KEg/lOxGuMzZcmq8rpFYSk3LkVh+GyoydZR+Xj2NpXTPc8vMjO7VwqkROkSxTN1ppTD4cImn/LG+SHxqzfpVZ7n1SITu1pfFU6OybIlqsH2tQ8HY8oSuiTub5jRy1BVrO3OrgEQWZB9/R52GYtb1JB6H01ncs54oaznF8JQ93IdRIG5QTju8FBbfueX+zGGwPU/kQ7HFMWuEog9+mf1sa6cbeLTmVY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jROKs5veUOck1k39C92o7li4HZLcyBAuGp6+CgkWNTw=;
 b=fv7PsgUEJhJeLH9zvNWP/L/mNxN3/NftSWhEVCqVL/b29LX0gDohT++lIuGvTc68Z9PcBIx7uw1g8sxz8KJ+/woqGxWsJpuV5lDTnbTyaRuTxEamMz4JGmbhpGaAybKvteCl8SJinLPzFKCo1JV07fwOUIFINzY4iox8uJypXEwR22d7XWnQVbFkMAfsKCXJDTccH6lvNBxxzpQbxKQnNffBwx/G/S+lgNJwioDYlDx1zpsnMuh4U6B2L/pnlYD9vBeFQ8MA4XaDOQ6/RZcvHBAuh0DipMSB8RbHA3gU4KM5mSd0d8mUTuOvP9VhMCFQduPVxe1PTdl0IIdjg6jt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jROKs5veUOck1k39C92o7li4HZLcyBAuGp6+CgkWNTw=;
 b=ICJgMXjpYn0XS7a0CjNuwNlt6obPVFtHSXz2oJNQu1uDY8KpHOmwyqlfWt/e+2AAfgin7yK3gPR+G+K0MRjVeoP8kq38C6XR92h7yWjlNdzoJUieLgxKNwDDaQgJhxRX1yN+fysJruxvQXgB8SLM9PrT7fouR31HrNfZla4mFRs=
Received: from DM6PR13CA0024.namprd13.prod.outlook.com (2603:10b6:5:bc::37) by
 BY5PR12MB3987.namprd12.prod.outlook.com (2603:10b6:a03:1a8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 09:58:43 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::23) by DM6PR13CA0024.outlook.office365.com
 (2603:10b6:5:bc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.9 via Frontend
 Transport; Fri, 11 Mar 2022 09:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:58:42 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:58:11 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 23/36] iommu/amd: Update set_dte_irq_entry
Date: Fri, 11 Mar 2022 15:18:41 +0530
Message-ID: <20220311094854.31595-24-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae849c29-d165-4727-ae78-08da0345b9af
X-MS-TrafficTypeDiagnostic: BY5PR12MB3987:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3987C1EE17089127E9152876870C9@BY5PR12MB3987.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1tvGodEqT4wbx10wAPgyqZEDfVRAzFF1s+aPFuvkxcXpg+OsVlS+jmFZPr4J59x/Vesf1addwvuQCzOiXlh8TwPWpSTJ55Bom5YJRIBh9AmsfGSTPXoZP3TpQLnC2HueBKihAOele0Wf66XPSzwnUnqLriKjc1a4SlhtccsS6QAj0iGWJbbA8Mi/NuPgM/fAKHM/DJ3feyWVGPTxicoff75c0qz0FXI6MOsxBkHw/TdHuZdR1oGLHIabk7oJo+iWHzoWk+55WzOp9SLCubvUq+FP1DCjUlbYmGogt0qvWi1/08QEDRWmnDLM1sgUX4xv96bSFXmjvgxMe3Tp/3wK60xHtuqTJC9qT8ul6OyNf+PGVsQTVg+8BHPoRQcypsvzmtVs9Cq7nsz0tG3xSmmT8pK+WKgFlj+M5+c5nYVHtDEyL2DGQr/8B/6pvo7FS8A6NefcerakBhLyPxDuq36IX/bsi3bslkb8hdZPvcEgHzRcaDRsqv6g+ZuC992N58Mod/0aIqLumv+FDJVHTTbJe9Zi1AbtOTWz9Q3cD/y6I218ALCJLNnBcjIUouxPDwSuvR7uEWtiwba7J+v3pSaIVazzkB5nZwUcJ8NQlQ4J2Po5P7qCwLCNTRFaN+h6fo9kh4rzArBpX1kjhhsxAgXqXdfeGV/1WGw7tgqX4sxkVcGXxr0chnvgL3R/sJKxfmhhNdBgx9fCaZuOjAodIA/yA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(426003)(356005)(83380400001)(36756003)(2906002)(36860700001)(47076005)(70206006)(1076003)(86362001)(4326008)(5660300002)(8676002)(70586007)(82310400004)(54906003)(316002)(110136005)(81166007)(508600001)(2616005)(40460700003)(26005)(336012)(16526019)(186003)(6666004)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:58:42.8178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae849c29-d165-4727-ae78-08da0345b9af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3987
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

Start using per PCI segment device table instead of global
device table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2438cdebb296..1f3c870efd0d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2722,18 +2722,20 @@ EXPORT_SYMBOL(amd_iommu_device_info);
 static struct irq_chip amd_ir_chip;
 static DEFINE_SPINLOCK(iommu_table_lock);
 
-static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
+static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
+			      struct irq_remap_table *table)
 {
 	u64 dte;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
-	dte	= amd_iommu_dev_table[devid].data[2];
+	dte	= dev_table[devid].data[2];
 	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
 	dte	|= iommu_virt_to_phys(table->table);
 	dte	|= DTE_IRQ_REMAP_INTCTL;
 	dte	|= DTE_INTTABLEN;
 	dte	|= DTE_IRQ_REMAP_ENABLE;
 
-	amd_iommu_dev_table[devid].data[2] = dte;
+	dev_table[devid].data[2] = dte;
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
@@ -2784,7 +2786,7 @@ static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	pci_seg->irq_lookup_table[devid] = table;
-	set_dte_irq_entry(devid, table);
+	set_dte_irq_entry(iommu, devid, table);
 	iommu_flush_dte(iommu, devid);
 }
 
@@ -2800,8 +2802,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 
 	pci_seg = iommu->pci_seg;
 	pci_seg->irq_lookup_table[alias] = table;
-	set_dte_irq_entry(alias, table);
-
+	set_dte_irq_entry(iommu, alias, table);
 	iommu_flush_dte(pci_seg->rlookup_table[alias], alias);
 
 	return 0;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
