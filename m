Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D1BC433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 144A44020C;
	Wed, 11 May 2022 07:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1yGQMPkQknQx; Wed, 11 May 2022 07:27:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C114241880;
	Wed, 11 May 2022 07:27:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99D71C0039;
	Wed, 11 May 2022 07:27:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB192C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9A4340B42
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U-YGaqmET7Rx for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:27:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::627])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 783614060C
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feDwJbXd/9m58Yp/DHdtvSxj2vt8aee58ITjKLT3b4jr3F4AgcJyYTLjv5LWa1RHg+iVQBzRSmJs9tCAIYuCsC2NgfryXjkkO5Ux6H73h+0p166VeC1WEc1uQN0guSSUi2W/TE3E5H2CkCgJZ9b1oNm5ONE3mU4dTEGkwv0eIKH2A3D7D1Unf9sJPTqYMzfOP5mUUWY1X2GDcGw+trYyKkg+RR1XvJufWI70ucuULNSdptiF9949oGzXT4NPQFLKLJsNGKl81d34n0AhcjOOxBdlvJzlbZ04Xvqq5JM9RpWXPzWEEr5wPH5YYUm5RRjdlmYxAvTkfyfA4ebijuVzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LNFCNHC2j2J9yhXMaNrgzMHn46zyZn9eYwf5qzJ3ls=;
 b=JesN6gn/CaPosolNLhpxMxkuKrDSJYL1zhXLxAYVKrt07BBw3KYkasMI6askpF9od19UzWOQfYOplHkFoBUtYSxvVYTPIvtQdgeuY37diHO2Z7r/lwoF6CsqYiSIfDJ90sHyth8wEZyBIEfgOOkP71GEiWQnI8YWmD584s9x2JqeU9lFxL1LTfn4sH7/Tu5TrZPRpAl09dx+GiTJKrugKicqAeLVmclOUwJo1/2ZNI9DrU5sgX3j5FObGmJbA8fzy4oNZsNbdoWvznNyKdPoamEuSfbxAOsr8IFQ7M2uQAjP+rPm8Z6/tyzTuq2kVnN47wnc4kgD1KAe0hxYaMUG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LNFCNHC2j2J9yhXMaNrgzMHn46zyZn9eYwf5qzJ3ls=;
 b=ZOy7+N10ydSh7zka/hZk1idYM46oj9EzgTzA8LSiNjxCu7PdQzDCtZuz15DdK1d+Ew4/x7dLjM5732TPNNaKMu5O0WZblEkx3c2V/3TLemaNu38TdSab9RYG7C85cIOI3lbSgnRO0uf7JVCG0O4w6lAYDEw5A7lcccpaoeIvXuc=
Received: from DM6PR21CA0006.namprd21.prod.outlook.com (2603:10b6:5:174::16)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 07:27:32 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::5e) by DM6PR21CA0006.outlook.office365.com
 (2603:10b6:5:174::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.8 via Frontend
 Transport; Wed, 11 May 2022 07:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:27:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:27:29 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 21/35] iommu/amd: Update set_dte_entry and clear_dte_entry
Date: Wed, 11 May 2022 12:51:27 +0530
Message-ID: <20220511072141.15485-22-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28b8b5b2-7fca-4e76-99ea-08da331fb666
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203E1CEE683CA9DD055A6D087C89@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNOmCjglAl1JYrUuchQB+sdyERxV5C2pDomqBuqqF0kto2IZXhGjQvnaS64uZ/ssiLOGHbGCp7uxI3TH2mwet2biLAtNgSgIebgn1LVfQ1tKMy9HnfeVYRSAiFCJHUAYV/U1ob2msAqCP+RmO7111GHftuco5Zkn3UbjjXn7RdCm/Dxxm5mBgyElNHvYhQsXP5mupaTeF6L+LWgorFB7hM+/WiKg2P6QyRZAKODUrk7ZbySf39FKO5ctbEz7qWf74uIHLtcyU8XEe112LmUdHBz2ZLxStHRFyct8mxBRmyj2vVPAzbXFxbw1zNA4YRMe3SKdeTNfj8VoMHwPWe0XREnzlCcqHzN7WNxIHX0m8wdLnzYmkCbW3vssrqTfDR94sAnTqrVFSOlN5stufrNAk1Sm6VcSorabp+BEdg+bJljl+z8mXdAXmcK/HcQFQS6C6QUpKFvpRnbqSfKWchMMP54AXxQkQw2r7y0nCPdsLHpI1Q+EPcDkGOdqUVotz2gD3Vw9tf51zw7FtB5gyScqsA2ACZQza+8JuupHRN79mIXe1xiXv561mVNFMGK+s9dBF97FjZpXm0OuhavBkp5esUUOplvkz/j5Dmn5i3acDEitwQUpKGl34L3UsEZe+dySIcmxBs0z3jDGcSQxnk4BBmhN2xWzaqL+Hs5Td21sd89kT4zpuX+DKhdX3NJE9Ci81DCQxpNu3frEDrFqRFX2kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(86362001)(8936002)(5660300002)(7696005)(2906002)(15650500001)(44832011)(81166007)(83380400001)(356005)(26005)(2616005)(36860700001)(40460700003)(16526019)(1076003)(47076005)(186003)(426003)(336012)(316002)(70586007)(70206006)(54906003)(36756003)(8676002)(6916009)(4326008)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:27:32.2589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b8b5b2-7fca-4e76-99ea-08da331fb666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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

Start using per PCI segment data structures instead of global data
structures.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 126832ae2997..678eceb808e9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1537,6 +1537,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->iop.root);
@@ -1545,7 +1546,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 		    << DEV_ENTRY_MODE_SHIFT;
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
-	flags = amd_iommu_dev_table[devid].data[1];
+	flags = dev_table[devid].data[1];
 
 	if (ats)
 		flags |= DTE_FLAG_IOTLB;
@@ -1584,9 +1585,9 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
-	old_domid = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
-	amd_iommu_dev_table[devid].data[1]  = flags;
-	amd_iommu_dev_table[devid].data[0]  = pte_root;
+	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
+	dev_table[devid].data[1]  = flags;
+	dev_table[devid].data[0]  = pte_root;
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
@@ -1598,11 +1599,13 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	}
 }
 
-static void clear_dte_entry(u16 devid)
+static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
-	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
+	dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(devid);
 }
@@ -1646,7 +1649,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
-	clear_dte_entry(dev_data->devid);
+	clear_dte_entry(iommu, dev_data->devid);
 	clone_aliases(iommu, dev_data->dev);
 
 	/* Flush the DTE entry */
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
