Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DDEC433EF
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 01:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1851830E3;
	Mon, 13 Jun 2022 01:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nxdIemohNiOF; Mon, 13 Jun 2022 01:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 87E3383122;
	Mon, 13 Jun 2022 01:25:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4586C0085;
	Mon, 13 Jun 2022 01:25:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EF66C002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D1F260EA3
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 59kfaONz1d_c for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::616])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C790A60ECA
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+ZPv0ganDVxbfgxxnI5ykSISuAHIKPWakN2arQNV1LphYkt+9TCfibX4zDQaw6adqlhvprEo/9moluRdESlzq+Q2PU9dYXDpfwL6X97PBjlD6FOMof50mw0xs91vA1xtxgAfp2nsuqsT8fJHwfs4e7kKM7Bj110nTMZfb1dfr7tymwF8JwIWmze8Q0Q4v0FrWMcbUzOZ1bnjyfMZYPtEDz6LzQvITEdIR1FckXJrdWXu3yh/ZypmNvmBGAOjHc7j/MgTA65bP2WGzWGTU04f6+Rrm1mO7bwC4mekbhRkoHq9x1yM7wd/D+okGYHh30tLJ/njG7zZzCDIVC7kLHvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYTUhjY8YhlOwEtj5gSWMtSta9FrPlaVylpXQeUaJMY=;
 b=KJ5BcjqWngIp9RxG9EN5VbNef/MNuDRV+2m8/+La1Cz5Zu3h1ofqYPBdsrtJh59Piwg0ZAaJgEKfa9DnSk6mz/RJyESefxnnMn80u4g+EFSeX9uuLRRtGvB1nfstU1BlRxHMMTSsi3upQgcQpSzjAlf6zA8E+6FSZa2zLV9sReucBx0cnli+ks7UkbWUNr2WsoWqh25auoJE2G0sorK+4zub7w7U1Sm18edS1a7pmoZIR7IaVMZg+5x/arL+dCktACOp8uinfkd7qpkE13L0MnAblpndI8oXl/G+hwCpmN8p0C1SgAmqjFqZ0pY+7jf2m0cpQxt+48oUpT9nyvqoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYTUhjY8YhlOwEtj5gSWMtSta9FrPlaVylpXQeUaJMY=;
 b=kmn7kTEMgzSr7+anpAp4BlzpA61RKHH+e9mueriWvcnlisj5jF8aNHiuuUBaX6e/UvpP55ZOuwzqTXWFBW9zvpsbqm1WzsmE0JgI5Q4MCmP5g3kQkPJR/HnOEb2AJIac+fl+1/KwXpB9mtlsfEeJqu9Ynsz340dhvGu1ZzoHxDc=
Received: from MWHPR10CA0002.namprd10.prod.outlook.com (2603:10b6:301::12) by
 BN6PR12MB1667.namprd12.prod.outlook.com (2603:10b6:405:4::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Mon, 13 Jun 2022 01:25:32 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::f7) by MWHPR10CA0002.outlook.office365.com
 (2603:10b6:301::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 01:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 01:25:31 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 12 Jun
 2022 20:25:21 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH 4/7] iommu/amd: Set translation valid bit only when IO page
 tables are in use
Date: Sun, 12 Jun 2022 20:24:59 -0500
Message-ID: <20220613012502.109918-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae1fdb84-36eb-445a-ae8e-08da4cdb9b4a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1667:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16678948B27471F6B23F6331F3AB9@BN6PR12MB1667.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKoctWqUsmdxKtFqxVPipCAQOLb2cb72FvegFEg07h3m0+SKx6BhHtKED9TkmcopmzsRrg2JhoEwurgP8vbTBy7hh4mLy9QoTABrcJ5sgMSg1RMwgldBp6CIYDUY5SY5osSifPCcBc+BCL2nvxb75FGPBb5/kII2UDoS3qST1id5+ysnwH4RJv5P95Z/UjnP+iNaI7nzG2irCTeWtAmCC1nAlDyxoo5ieUV/TebWGt9HXOWrr/yhiTpJ+V4IsbQfGhPsTkxXtBmNFLDPJ4uYL1U4ADUIfKiqJjm0jZkixqX83Av/CPBtPffYPyT5hYzf3iTv8luUSuO49REMd87hjWW3kNVUOJrjaPrLopNZ+RTrR7JbU27/B2r0UxoEFPuhLdVVLs5EHxapTg8Qd3XuVh2FnAiYaaW6979BFh7D3GmEJN5cjEYfzjojELyDMsoHB9abM3AfcezMmUQg3RqC9YCiDBge394AZRbprt1KGv/VHu3/5ENva/2e1OJDTPTKhHl+1KtZRkvLmglWTCXvrpIBbCKk7LJxM4nW2R9jyqMui0D5nTTiHC9KQaeCd/8ohLkwGuw92aSGegcKgI0w8o0yFTs6xj2eG2KjZr98sjiBygGps4n3BXo6ABHNghyO7Zh2lBqPhpUPBqsBrW/HfKEMagqLut7egl9q7Yb/b39ACrG4RIXy4UC7C54buPuc7+qTZg37F9X5eTvfi71Nkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(8676002)(86362001)(508600001)(2906002)(8936002)(70586007)(70206006)(186003)(16526019)(4326008)(7696005)(36860700001)(356005)(81166007)(6666004)(2616005)(40460700003)(316002)(1076003)(426003)(83380400001)(36756003)(44832011)(82310400005)(6916009)(336012)(54906003)(5660300002)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 01:25:31.1383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1fdb84-36eb-445a-ae8e-08da4cdb9b4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1667
Cc: robin.murphy@arm.com, ashish.kalra@amd.com, vasant.hegde@amd.com
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
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On AMD system with SNP enabled, IOMMU hardware checks the host translation
valid (TV) and guest translation valid (GV) bits in the device table entry
(DTE) before accessing the corresponded page tables.

However, current IOMMU driver sets the TV bit for all devices regardless
of whether the host page table is in use. This results in
ILLEGAL_DEV_TABLE_ENTRY event for devices, which do not the host page
table root pointer set up.

Thefore, when SNP is enabled, only set TV bit when DMA remapping is not
used, which is when domain ID in the AMD IOMMU device table entry (DTE)
is zero.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c  |  3 ++-
 drivers/iommu/amd/iommu.c | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index da32e7bdd1fa..a9152d3f33bf 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2546,7 +2546,8 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
-		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
+		if (!amd_iommu_snp_en)
+			__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
 	}
 }
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b9dc0d4b6d77..ca4647f04382 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1552,7 +1552,14 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
+	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+
+	/*
+	 * When SNP is enabled, Only set TV bit when IOMMU
+	 * page translation is in use.
+	 */
+	if (!amd_iommu_snp_en || (domain->id != 0))
+		pte_root |= DTE_FLAG_TV;
 
 	flags = dev_table[devid].data[1];
 
@@ -1612,7 +1619,11 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	/* remove entry from the device table seen by the hardware */
-	dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
+	dev_table[devid].data[0]  = DTE_FLAG_V;
+
+	if (!amd_iommu_snp_en)
+		dev_table[devid].data[0] |= DTE_FLAG_TV;
+
 	dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(iommu, devid);
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
