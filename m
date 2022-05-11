Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33ECC433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 839FA832D1;
	Wed, 11 May 2022 07:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NBYihB_VEisQ; Wed, 11 May 2022 07:28:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5A616831DA;
	Wed, 11 May 2022 07:28:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 438CDC0039;
	Wed, 11 May 2022 07:28:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4668DC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 266094060C
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tsJj4-pskMfD for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:28:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::603])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4C5840ACB
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsHswoPMYRiF1lygV3ZK3h4akeN5waPJzLct1Pdbfrx504QzHd/8OZXQquYULuEpxzzpfS/FurOt9CeB0Ab1/kuzaihyFtHNYBUD1Icrfi7ZZgDVEFv/fdxdpByvKarzaBWHBUrtXPh9YtfIvP9BSzylHo69hTA5jtDvICL3TnxeUGvodIv5PInI7UOuveLsXJOngewhHbOhYadV/3HGlynW9Lghw9ZvxxCo347aMYsA21/DZPEb0Zry1QFVVueKaig3cPVsYuZTA+7yv6ZnZ3jEXrW2rxl+6iee2+BEnT4Led9xmbJoGvCYivd7f9ghkCNHBFiq4LT9/A9yJ8zcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDpTa6fMZahaLYzaj4yKT/nwb94+3Ep+j4rKLg/2k3o=;
 b=n8ugc5Ox4KG1ZFwRyAu1Aw6sZCI/Ol03lP1wOa6yT35/OaELBke6wYE3YvPUBbT9u91/FJ0pvIX02k+b45+5dofrAiXapvYbyKPv+X/lwIF7cJcDM2TsWUbeol6mbO1ySnOa02mZ/2VCNFW8KPIHC7pD5vokXTyOjgCi6+NW0jaJAnnI1Xal+aFbBQFLb0NCOXnbcxVaYIxSmw5VKsYBpt4AgJAAANzsl/w9v1E9rTluib6CxaObHoKYlUyztlXBoaMgyW1pwdrRurPUmqND0+IQgbuALPIbI7Z913O/rddg53S6TlNu1ZImc2wnuLqwmo6X51Oum65uS7iZ69chSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDpTa6fMZahaLYzaj4yKT/nwb94+3Ep+j4rKLg/2k3o=;
 b=Os3CeuhMFtAW5dQdBb1DKYeNYFvl9lnSBqw7fJ+XNz89KTj7TJqPakyzSwBo0rzJw9tYzaWJw3zY1jjH5t/B3j76mMahquy9S6eXG+EA/ewrYSW7Eh1xiTQ45Hzvr9sBHEEvOSy+lH4hnSaKJclHpIMK1QFrWXS7384dDbbP9tg=
Received: from DM6PR08CA0011.namprd08.prod.outlook.com (2603:10b6:5:80::24) by
 CY4PR12MB1942.namprd12.prod.outlook.com (2603:10b6:903:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 07:28:18 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::f9) by DM6PR08CA0011.outlook.office365.com
 (2603:10b6:5:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 07:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:28:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:28:15 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 24/35] iommu/amd: Update set_dte_irq_entry
Date: Wed, 11 May 2022 12:51:30 +0530
Message-ID: <20220511072141.15485-25-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bcc0db3-07c8-4d1c-809c-08da331fd197
X-MS-TrafficTypeDiagnostic: CY4PR12MB1942:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB194256B2FBD4BFD91653FC0587C89@CY4PR12MB1942.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4b/NfSSKIDvlMzVqxati2ZQZiq8oqhewAqCFz0Ydp8bmjMmEQWQ/TEak02PgnFFPpVgRIZx7NgbjJ2FZlmJpfOmu5Q08gJujuBtwfJAFNGB3+Wa9Z46IFZ7d7QeB/ZyXKXK3jXtGAPvlOzyR8TxkCSLmVKs5Fqexw2pfXhLnNBcCRUOwwUS+SAnV4GF3VSrWCpZ+aOujIIpISheL/Ncm6UptpjH5ivJXCbuAcJQeuoRUVaBjJRS65gug8x0J/V9uEIVraejZEW8ZvD3O8z7un0H3XQL4yr3qCDFLPoAk+UxcHHLtvkyPELJB+zFmyTTzG3Y3fI84jsv+vAgRQurmsv/gpE0y46usAk6pkDAexif5I9ko8tzlS2w1BIlae9UAtVMl3DmwvSvcHM48GGKzSPSyYx9IPXaX/1vhq7g4RsBpvs2vLI7hx9IuKvzbMFbUvCvcUL7khQG1DcARD3y2XwfA8lTUWXR1PJHHl2W2Cd3I2fqgpTMi8CHqs/RF3tpPhcauokW2AYQB7u/0OQmmSk98rT1At3Ssyvszlag0o9MSteI6rWWkKwl2q73xT1V10nkdG+OspfwjDaZml1ceTFDQRzf7TlnzFodtFdLT6zUjOb88lJD7IhIxTE1bn5pWvaI1gCi5ZKuK/D79343buEfVNMzAVlQfT0+vrK5fjsNF0TmuC51M5FHgiy1Z3kyb+42VwPS3H944RrhQRcqUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(6916009)(70586007)(70206006)(86362001)(4326008)(2616005)(8936002)(54906003)(8676002)(1076003)(6666004)(356005)(26005)(81166007)(7696005)(508600001)(40460700003)(36860700001)(336012)(426003)(47076005)(36756003)(83380400001)(82310400005)(44832011)(186003)(5660300002)(16526019)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:28:17.8778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcc0db3-07c8-4d1c-809c-08da331fd197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1942
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
index 8c99e2e161aa..ebae64711691 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2729,18 +2729,20 @@ EXPORT_SYMBOL(amd_iommu_device_info);
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
@@ -2791,7 +2793,7 @@ static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	pci_seg->irq_lookup_table[devid] = table;
-	set_dte_irq_entry(devid, table);
+	set_dte_irq_entry(iommu, devid, table);
 	iommu_flush_dte(iommu, devid);
 }
 
@@ -2807,8 +2809,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 
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
