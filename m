Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2F4C433F5
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 11:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42318610AB;
	Wed, 20 Apr 2022 11:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qjkVEGyqGbP9; Wed, 20 Apr 2022 11:29:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 213FA607F1;
	Wed, 20 Apr 2022 11:29:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05111C002F;
	Wed, 20 Apr 2022 11:29:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A93A2C002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 11:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85454607F1
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 11:29:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gVC75eBJAmAf for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 11:29:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D7E96076A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 11:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiaDUcACyHLyycvWwUD1GfTxGAA+pIe8tYQYN4Sg4zgqY1DYCnAsna7X2TAM1Xg+MKqw9cDx3B7y7eB2pav91ZsO94Q7SXgtkaPZHsA1PfpYl/kW2suBB/7u2qBvaVt5X0hERUD7WIo8T/9KB4DKacye8RazVHAv8Vbjo6uV7M+bu8Mn4IbR8sXcmhY7drQafiNuAe1ISozFHYf2cjcHBsp35c8VM2GayGCmjM6ag1bklZh6eXGWRMhWMgU9dXXzCn/Bi3AlFMpdYDRZ60mq0WUam6leSWCBxPbhFdX+x6dxbxRNBxvDU9jUQvQC6VFzq43F0UADUdRELjSIbq8OhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybtfh4ubRyT6HXAwbp5rDNPI/riPeM6bZYu3+gH3Hfs=;
 b=JrHBBmawCxLqp8Uic2EjbXIxxjQj65LD51JvcyosB07/mQac53fAxELcJEdjZZcGo51PRMVNXIi7Be9wqK9ypjjIuREITZiL2t3RFKbjCXMTgUOUa1yAvUNs4ov1KDy09QRvJxNVQBHhixCINi0fsWFbRJqyc75zPl74v/YEI4hT7RpTZH9DssoD4OzqT1KJ/76Y1kmSqxHT5/b6/CfnBxe7oum87/Vr8Bwhwy9D+n8xV5kDbR3vGWwIaIKl05ofxLxJ92S+F+u3eiDrX4tEtkcRQx272bcHzb0dlqKXxOE7KVadBn7yiRxG/9g4snV3yc9N1IIev2whR6v6x5XcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybtfh4ubRyT6HXAwbp5rDNPI/riPeM6bZYu3+gH3Hfs=;
 b=rQIgO+6ckI9WtbHzwHc/F7TOZDk714nCyfyAhcDIV+8sNpiD00JN7k9YSO7DIejteqlx9oarOck/dn8eKnxP1OVxpuyXXo2vEBAc96FxeFdb3mnjXCT2rCp9o+Qo5w3TkzB93BYNvbQGSZhmm5P3/XNCmX3eXINzk5vCvx3K6Qc=
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 11:29:38 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::8c) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 11:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 11:29:38 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 06:29:30 -0500
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH] iommu/amd: Set translation valid bit only when IO page tables
 are in used
Date: Wed, 20 Apr 2022 06:29:20 -0500
Message-ID: <20220420112920.18091-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee8877ba-a670-4c54-40c6-08da22c10e32
X-MS-TrafficTypeDiagnostic: MN2PR12MB4288:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4288A1B3AF9BE39F96889310F3F59@MN2PR12MB4288.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIMW5LtdOE3CiNYXZbJ5PtIlq6tyHBJ8lZU8F1U0ABzddLm03e79eOYL5W/tSmVAFnnx9iEX/wWYPieYZR8JWpbegwkMkbWhhjt7zafoSrzJfCIOs3ZsRT3PgoJI6gK47VK8qeWBUsSWhPL0TamZhB9wUGyN9kgBwIxa7Ty8MgVYghAZF2mZisDwr0ravyG4cPmB3Uj77njUrwH9iuwxx0R77Fu6Ho4Dkj3G+hijVQjanAfB5/tm34u5MxXst7tyq/FVt5bptmRYBf9Oj1Jo1hUQPqNTubZaJZk5J/Cq3oLQdp+VrJNRQV4VQGJoCbAkfkoPQExotN3ilt9oZVdU45FnOvTgAKgBM2S/D1PI/mHuvJiaz32rRgl3quS6o3b+3SgkhwBViwmTtp9C5e4udZ5PxwhE11+sWdygas6jPVgVClHtfNS4C10Z2hywIDujfSZN+8HeUpCm38aBLXdHMNpz3oCQecU/Emmw3rYqTgqFZROfh7obGh1lV+b422gV4ewRxUg6b0RjARp6dFkKvlVoX28WBaIwbVznrxVBl3w9k+qPVUy6CkqAXyyDpCtujLESvkvRaw9tU+gMSS8CACvMCDyx7znCvIrBbE4Qv1rWsk0D7cv6TzA9Uq/DPk5WqLS23d7C/aoMN4roQkHMXzq73KZFMYqVBML3xclAdB3zqBSkux7L+uh85wYQzzsNHPjqG22rzhiUoHjLxN5VCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(8676002)(70586007)(86362001)(70206006)(83380400001)(40460700003)(44832011)(8936002)(5660300002)(82310400005)(336012)(356005)(4326008)(186003)(426003)(47076005)(81166007)(1076003)(16526019)(2906002)(2616005)(508600001)(26005)(7696005)(6666004)(110136005)(36756003)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:29:38.8084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8877ba-a670-4c54-40c6-08da22c10e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
Cc: jon.grimm@amd.com, vasant.hegde@amd.com
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
valid (TV) and guest translation valid (GV) bits in the device
table entry (DTE) before accessing the corresponded page tables.

However, current IOMMU driver sets the TV bit for all devices
regardless of whether the host page table is in used.
This results in ILLEGAL_DEV_TABLE_ENTRY event for devices, which
do not the host page table root pointer set up.

Thefore, only set TV bit when host or guest page tables are in used.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c  |  4 +---
 drivers/iommu/amd/iommu.c | 13 +++++++++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b4a798c7b347..4f483f22e58c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2337,10 +2337,8 @@ static void init_device_table_dma(void)
 {
 	u32 devid;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
 		set_dev_entry_bit(devid, DEV_ENTRY_VALID);
-		set_dev_entry_bit(devid, DEV_ENTRY_TRANSLATION);
-	}
 }
 
 static void __init uninit_device_table_dma(void)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a1ada7bff44e..6dd35998e53c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1473,7 +1473,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 
 	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
+	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	flags = amd_iommu_dev_table[devid].data[1];
 
@@ -1513,6 +1513,15 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 		flags    |= tmp;
 	}
 
+	/*
+	 * Only set TV bit when:
+	 *   - IOMMUv1 table is in used.
+	 *   - IOMMUv2 table is in used.
+	 */
+	if ((domain->iop.mode != PAGE_MODE_NONE) ||
+	    (domain->flags & PD_IOMMUV2_MASK))
+		pte_root |= DTE_FLAG_TV;
+
 	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
@@ -1535,7 +1544,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 static void clear_dte_entry(u16 devid)
 {
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
+	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V;
 	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(devid);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
