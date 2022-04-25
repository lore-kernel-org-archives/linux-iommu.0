Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05EDC433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA8684109E;
	Mon, 25 Apr 2022 11:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7_WOxq1P0pBG; Mon, 25 Apr 2022 11:39:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1D23B40A06;
	Mon, 25 Apr 2022 11:39:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3926C0039;
	Mon, 25 Apr 2022 11:39:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE02AC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC05240A06
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oIZQ6ukzO2-W for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:39:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::600])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A0B54109D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XujmWJ0yCMmVjbTrA0fP0mimKHmmv9d6wHXLlp4nUIaiTfBS4UIFw1sKK/NHueE/S2/gknjcdo9kp8ynyJtUXpmPdYgILJU7BVNdAAe/Ho0pGvpeHjJlGc4Yn2WLMTDHVs6JkVUuYEpixTb+r4jSirmcT5YFoeoeiGMXO2q4bBmhC+t/bQAwW4vIfv75SPNm5CV1Ro//EzRzAd3BuSsP9ZjDqAx1wRFUTDizdWVw4qszKVyGm1aKIPph2OmoRx8nU9HTUVi/JUoQh3Hv9IdErNu5TuNtVqSzxKeDBHUw1d69WMzKORVDpM55vjmquVjDPYu5cS3vfSwCzr5xIOy2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utM41+xdV8oIr7oaPanq99ijFER7TGymgm0t+G1BKDY=;
 b=ki4VU819MC0s88uOWIdkqQdXK3mP3qHAZuSLapuKa05bRmLnND7DwKeDYutAgPls1tGxXFayqE9h2cbSUFAW8HDfge6vv6nt5s6ftngrkK0CCYrPE9wKOZ9PplBZPM8llB9pLZ20UQ0JGGUV32+IHttvFKDR8pThE0pAc5CY2rHoS2Yd26j3y3byTGmrFTbINneN7rIQ5KfN0ScsRS975L6Sp2Y7WiqOrW6QM2fJk+tdK9/CQMjwqQoro9fmXGHHhOGgt1D6ScwkrtZ4zNGyCuFeZS5enidj3cWQc1eM2opoRsKNC24ZoyQVFpCYahFDIjUtivwZrbwiX1XyXO61kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utM41+xdV8oIr7oaPanq99ijFER7TGymgm0t+G1BKDY=;
 b=QpD7ldGnDjI0SC92S1K7mr+O4Ng0+54myUFpJi1WuGFFht39fQ9O9szAQ8pEeMB4SwXXMuhbURhjCFmt59jsibnBpK9894N5aNHOj61dPyMYuBV0nq1GkiKy1Balg1klXUJ6jKOtn0tthyaAZGtRBbuM3rx2cNjKYSwGr5pNdTE=
Received: from BN9PR03CA0933.namprd03.prod.outlook.com (2603:10b6:408:108::8)
 by MN2PR12MB3952.namprd12.prod.outlook.com (2603:10b6:208:164::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 11:39:01 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::53) by BN9PR03CA0933.outlook.office365.com
 (2603:10b6:408:108::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:39:01 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:38:59 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 16/37] iommu/amd: Update irq_remapping_alloc to use IOMMU
 lookup helper function
Date: Mon, 25 Apr 2022 17:03:54 +0530
Message-ID: <20220425113415.24087-17-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d63ba997-c20a-420f-7714-08da26b0319d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3952:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3952176996B0FBFA3C58EADB87F89@MN2PR12MB3952.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSP58KZBM1FtuIE5Ee/0UjNWY20GmD3k21TS0osuUgQvIKga07lPw4wileLTydprs5Kp8mRndlJhWL6YaA596AvRlhShtZ2v5vYoQulk2KEV/gC2sr0CJMimCHOltWPuYkoYgSkYAEQFCNqy9SEH3D/CFMdI0ozH94jHjSBZgCu70pNUSsU32rZBgUB/aRGrY9y55tst6G06q1XhDFdNQZ2cuaqRVLGF1XCS2Kv8iQu7l+eYw99sPwH2G8X90KJtnh+5w6zTCUZ+N0Ecllm6Xah67iK0EZpyvZddKLU38y/VjslNrwDbOYCpYQ8ibQOs2wFKmGF+TxjJYhoH4tWZG7vo6Y8aCeM8Tx1MR3ArLMI+S0yUMEA5JVNwrc4OpRJUDKy5/nT4fdhVRKz4YcU0m/niaxD7NQFQZ1vH567epvT9OXlAjczBTxu7EWivXvvaVt80T9+oX3kDANtqHMQtz3O83vBqvPfg8aUuqR78VC4YDOdU7d878Z27k0eKH5qt4QmqvezWQ4QeNK9w0sJ2OeNvRGLAEnpUW08ns6ltwIk02RO6MnEv6uJsszfbb4lF/BC4zlBgpcedc11Xg+evuDFYpCKXA6MQp+S6Ah8HQkgPk3bJVD2bK1dP5lPWF0xUWChx1sbjACLonD31O8/lro+1Qa8/droGk8o56Tyg2gX3yuFA5m4X+lUi3byhSlbXW9kYPysaaRDfz9/ZQjzixQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(83380400001)(6666004)(36860700001)(26005)(2616005)(16526019)(336012)(186003)(426003)(47076005)(1076003)(8936002)(44832011)(4326008)(40460700003)(8676002)(82310400005)(356005)(5660300002)(2906002)(81166007)(36756003)(508600001)(6916009)(70586007)(70206006)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:39:01.4224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d63ba997-c20a-420f-7714-08da26b0319d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3952
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
index 445f583795c3..c6b8a1f95b55 100644
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
+	seg = sbdf >> 16;
+	devid = sbdf & 0xffff;
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
