Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D95FC433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7CB960AAF;
	Wed, 11 May 2022 07:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xRHlkppw1OiN; Wed, 11 May 2022 07:26:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AF86E60A83;
	Wed, 11 May 2022 07:26:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B5FEC0039;
	Wed, 11 May 2022 07:26:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42559C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2369E60AAF
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsHxrnT8FS5r for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:26:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C88A60A83
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbfQ57GsKN9iGWE+2aC0ALHQrOR3jrPkP/HFOuKOv4dGIGBeV99UySKIgcjeRW+CDnIF83H3gWJsFg1BNbkuFqYnDoGoB0+Cwx1ohmLPJoc35vQo2yCV5fVTFvjk6/0mpGked2r9PMo0qVoIsSwQ7YhsbV7QmO6lhqfplAkMQ963cNXyn+oV55s8vrIc7/rDEdv+8tO+qXjR07HXn9s/vgMRhR0P/0yQmg/pFE88QD1T/unAo68a6ktCmcYmboFkLRCb/apuhcZUsdnuyQLdYpY3CdTlP5MnsnpjqtR95VZ3iCg2bnONdsT7YwZOYYfPuoEfyYN/9NsnsvRhu1voRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txVakWZlCSNapEhgnvoSfH6mCS97SS1SGwrg9SnJmFM=;
 b=BiCAnuw2eVGlAbR1GkH/QzTQGE9Gmyc3g0ccyOyTO6FcXUOV46gFakWSpw5Myc2ASBvTwbhLMxy/qdohOHkH6uKrh3BmSenASPBTzIBQMONC1drctp9U+Jxm8n61cAunQ6enhbJEukQlkeEQjD9M2dBq1ccR6ShCIpO+bAWS6XaRBajqb/qKCSN01x+nbDZ+s1sxX3z5pOwDXbqlJf4FoLgyzXNamU2BykmOIdufVgpx5pBlx2zMlJtn35FIBWuS1RKvCQw3k8d0NfpoH+BBbgPcBrkr7gm5U84g63ejkN3bxnQfBENI/+ubQBtKADkLUGDbQh6r0hY3ipfOX8d/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txVakWZlCSNapEhgnvoSfH6mCS97SS1SGwrg9SnJmFM=;
 b=IXV/BJkDBd5t1bdKBFSFkxA/hIELap7H1d6KZ5Gmyb+IELfNBeWAZApohyY4PogC51IPVQUBPsU5vK4QFthi0nwoAviMUyYxL7UwYiWVgvijwr1uxOIxwn1KNww6bIXni+n+C/ZJLA6u1zIdkva358nbjrPZq4XX8hkbtS1R6bA=
Received: from DM6PR03CA0059.namprd03.prod.outlook.com (2603:10b6:5:100::36)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 11 May
 2022 07:26:16 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::e4) by DM6PR03CA0059.outlook.office365.com
 (2603:10b6:5:100::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 07:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:26:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:26:14 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 16/35] iommu/amd: Update irq_remapping_alloc to use IOMMU
 lookup helper function
Date: Wed, 11 May 2022 12:51:22 +0530
Message-ID: <20220511072141.15485-17-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be579ae-36a4-454a-68ad-08da331f8937
X-MS-TrafficTypeDiagnostic: DM4PR12MB6011:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB60113FD901828C380A919CED87C89@DM4PR12MB6011.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlMSjwMood/1EYl1QKX82HKK2mg8+b4ZxGzdBE+Eva18PiyblNFbcLxsYPiux24HGBtUspc6hWHOm92k//2zJ20N9skgMMqLq+YiPrO6Ru6aB4/rP9OnDx82GRTbcx7A/obmmnuRDdLHirDNpVgTdBBu1zL5amAVTsmlzNVVZBKNUzW5m8Gc3CB8VmUvHQ/g7Srg5uEFta5TE3p+0yxy07lxuNgTWm5HSMOKuk9ME0LaKbaXsZ5Na8BpV6tYsDVqKqcnwkOrOpYJlfUUeWrKGhTB6vbAW6+0jo+fPKO8tE9ABgfPvhyKTAMNSF+DDd77l1IyB0XVFEpfgUJ8Zk1NSyWNYlRHYfcqwGngYozaL9U/se+yYJdYx1qv0R9fz/veRyDk5BCqdkok4W5gcefXxjgQ5gIuzXvDdF2PJI/ySXFilzROBXTRBPp/40LcwRW5B2PI1oKgQr57W/jOoyd7vW0AkNcYp/jo4Cq/2sFb3Y7ZOpJ+3USvgCPPELxz7Ilw3/LwnpxTtlPAwqPjjlMAp1XveM5YvsqnpGXZhcDapKjueq7LiPByYLc48XH+sxOyzjj1d4eJ6SrffytoXPr4BqilwNHP6l2Wnxk+M/7UjDi3ZiMnRNAFO8lVKRf6oSMKMsQnY/3e977q15TibZTpo+BpEqVhTBHXbOroZiMYF+Qr+Kn+D4KmRAPSLMuX2cYjMif+F/RX1Siij57trWkQQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(6666004)(2906002)(5660300002)(7696005)(6916009)(356005)(426003)(36756003)(8936002)(1076003)(2616005)(47076005)(336012)(16526019)(83380400001)(44832011)(186003)(82310400005)(36860700001)(508600001)(54906003)(81166007)(86362001)(70206006)(70586007)(316002)(40460700003)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:26:16.4521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be579ae-36a4-454a-68ad-08da331f8937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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

To allow IOMMU rlookup using both PCI segment and device ID.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1485e4d4fb52..502e66d09c61 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3244,8 +3244,9 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	struct irq_alloc_info *info = arg;
 	struct irq_data *irq_data;
 	struct amd_ir_data *data = NULL;
+	struct amd_iommu *iommu;
 	struct irq_cfg *cfg;
-	int i, ret, devid;
+	int i, ret, devid, seg, sbdf;
 	int index;
 
 	if (!info)
@@ -3261,8 +3262,14 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 
-	devid = get_devid(info);
-	if (devid < 0)
+	sbdf = get_devid(info);
+	if (sbdf < 0)
+		return -EINVAL;
+
+	seg = PCI_SBDF_TO_SEGID(sbdf);
+	devid = PCI_SBDF_TO_DEVID(sbdf);
+	iommu = __rlookup_amd_iommu(seg, devid);
+	if (!iommu)
 		return -EINVAL;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
@@ -3271,7 +3278,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		struct irq_remap_table *table;
-		struct amd_iommu *iommu;
 
 		table = alloc_irq_table(devid, NULL);
 		if (table) {
@@ -3281,7 +3287,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 				 * interrupts.
 				 */
 				table->min_index = 32;
-				iommu = amd_iommu_rlookup_table[devid];
 				for (i = 0; i < 32; ++i)
 					iommu->irte_ops->set_allocated(table, i);
 			}
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
