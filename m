Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DD5C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EC9160C1C;
	Mon,  4 Apr 2022 10:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sAmwdMXAzhJd; Mon,  4 Apr 2022 10:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5C7BE607F7;
	Mon,  4 Apr 2022 10:06:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37658C002C;
	Mon,  4 Apr 2022 10:06:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59F93C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 399AA60C1C
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oxpewLukCtMW for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:06:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07B55607F7
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krinkx0VWnV4ZIcLYYIxpPWrFv90fEfdQhPvzbNaMmp5u0gZ2imj7MRuPSfwMzG/D+oLwRICkahQ7+VcFEr7KjXgq+f1p8HewBnyzi/STTUeZwop1b0d3wNF4RmTt6VgJb8FfjBJXO8vGT+MSDdDu+YDkYfQu/O5WMhYITCw+Y5TPdN1m/R+XXlDBuHcDqxpUPdYwot6mTE4k9cOtgtiGySgn4WDRi1KdLrY7OPQVEtn//Ch6Gdwm2aLw8/Jdte+/IaIR79h/4BrA6elVUssin6z5cJQ/wjjrEwoscjE7iyVP/+M0y/Y7wwOEtqx31DxQFdyCPLMOqpqsFf+C0ylQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZrxfbbE/eMyaB6Er1UF0La051jjdFpeG02voR/F0Mw=;
 b=CB1cDzwEoA9UxHcyWojULjKuLTOp1yVkNr2ZbrxukZHg8KOzFt4FhuPufVanAbKBOf1qLuF9gkXpsQvXg2qJRxdQDtm5ClxZ+/6BeJ/5V+nLd1OY66yXR/3bDXpNX3KKIeMZ0fnfZBR/x0RRqDrt3GtrzvyWhCZDsjkaQVsaX8jZobWBW2XyPgh/RUwJm/u6YwZrT7tpuPN/hsrZrw75RpG7/wIGI7Wh5IyAfLmtKIoZ/gunBCqAvuzHNtdCY361hB+8keoUZt29mVWDW0mxc0VfGO3OFyd6nUy9nRcpWaPv5i6bQiBdYJRhNIoZBmClnZ/By/lkUyriTrO6wtGYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZrxfbbE/eMyaB6Er1UF0La051jjdFpeG02voR/F0Mw=;
 b=5U4MpApe5UB7r2EQu3w0dhg4VYmx3dpSzBF5QIUyvR4H5eteRkQ3fR6sA+8e8Jt6eBEa0QuDznEz6QuECOSMJxnHx4B93V9Xw0ELg+TT5vwFA1JPs2UYHcSnpmIczc39dRlz7URcluc6y2dz0p7c1b4vm2j4DWvRo9EWj2GTctU=
Received: from MW4PR04CA0223.namprd04.prod.outlook.com (2603:10b6:303:87::18)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:06:50 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::3a) by MW4PR04CA0223.outlook.office365.com
 (2603:10b6:303:87::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:06:49 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:06:47 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 24/37] iommu/amd: Update set_dte_irq_entry
Date: Mon, 4 Apr 2022 15:30:10 +0530
Message-ID: <20220404100023.324645-25-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cae0b7e-4a39-4246-a9fc-08da1622d5f5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4044:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4044AC0CF8804E54AE62185487E59@DM6PR12MB4044.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nx/x2vpPubnz99p5wrAnosJ9BNGjFybYEIB5K+QGTW1KeZq8eNnT+V7R3imD3Mzj3rGgIF1Fs5InzGhAhXcI8+rYlpegaloJQMZtB6h9LZwMV95ccSCW2d2xS4TJdghAVG37Gj4elL6iUiM9nCidrfBE0ZCdJ6zgfeedLZJL5niR3x02SFci25OxP9+N3CF0uNTcYQYQ2bR8SHpReR2dNVZf6iicnmQ/2Mj/ERVr9W/lZ3IIitu42HKbAmRgj1XKHDfqRcjHiJ0/Nm+Vxz0cOIKs0Ej/kf/w0wusK9N1QdMIBQr3olUkChnMGW4AZWWG79sW69rkhAiFaPvOoIiSVZebzf4iPi/y5XNYE2YwfC8eyGsoRjqJ70ESMvPjfV0rtyyJk/9ZlIZEUICjjd1/yXQDIQJflmNmQ2MaW9ddcuJ+GJksbAzy6XNSo+hCCMXUCIl5wFRkwWqbrsyydjx0NLWSsZcj/7w6bM0vZeI1t7gvYykwlGLIQKAG/UgOCB2OszSfLnQ4JEYhAVilkHuoaG3pbXYsxYY0tEyH5qR5vU2W3OpZT8M1Z1qnfrWY/MU+4P9qAkvn8aXC+7C7Sm2904uf2196tX9PNa1e6twQc5oubopULSMD3JF2WgMKJjVR3VgxdbYL/k3iJdOz5SUeNQeIv1ZqEhbtOaOPYE/vNJq+UNpdQM8RTVe46dOG43Vzzw1jgSMiua6XIgZ45Hl0Cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(186003)(16526019)(5660300002)(4326008)(336012)(1076003)(70586007)(70206006)(40460700003)(2616005)(426003)(8676002)(8936002)(508600001)(83380400001)(86362001)(356005)(6666004)(44832011)(81166007)(82310400004)(47076005)(110136005)(2906002)(36756003)(316002)(54906003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:06:49.8817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cae0b7e-4a39-4246-a9fc-08da1622d5f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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
index f2a9f7078b2a..dad84f76c1a0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2726,18 +2726,20 @@ EXPORT_SYMBOL(amd_iommu_device_info);
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
@@ -2788,7 +2790,7 @@ static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	pci_seg->irq_lookup_table[devid] = table;
-	set_dte_irq_entry(devid, table);
+	set_dte_irq_entry(iommu, devid, table);
 	iommu_flush_dte(iommu, devid);
 }
 
@@ -2804,8 +2806,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 
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
