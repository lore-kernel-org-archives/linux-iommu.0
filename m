Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B07C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE53981D98;
	Mon,  4 Apr 2022 10:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mEO5z659iWpD; Mon,  4 Apr 2022 10:04:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C6AD181D3A;
	Mon,  4 Apr 2022 10:04:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0665C002C;
	Mon,  4 Apr 2022 10:04:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10A9CC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4007607F7
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RtAq1gGTmNh6 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:04:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::615])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 27903607F4
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaiQT9pfGtqI2QwhqylVU6KTlWt2tBNWMtQUqBBttNSddG9NFsBD9SjP32FrcTfHtzzr4g8taJMKZRDVes2voTkNAFGoMxMEf3iopAkIv17dEzru7K856X9M/27IDT1dtY7ICpvTq8prFRS0EGDTbhCyWNjxqBD1hngaMA/QKdHKRgqdCcmAoJOEAJeywBbydSz4ZNWviH/NAx6ywSiVZT59yH9O18jcn2d37CUh7U+wXT0tn7MIlsbZ3tW/hr1Kxr0ZuIrMnCyn/CxBksutg+kc06n61rZCcqp3TYwKF46TV42k+pSQk2vpme8jkVIYdMZ5wEtBbVuwBsIGPs+Gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se53/IXkWmPFo1wTxPohMMO8J4oUufK1kiWCqHq17b4=;
 b=Fm4M8fUh2c9SAT44hssJvxlpOatkQZ67OmQehtZpOlCq0eksdpRciDeKe0oZsHz7sy/r+kNBcNcvFoJgUvQXvb8NdUNlz5eeImTG4B+j9KxdZJ9iJYsco8lfvnfpQID/NgThcPVDdWmlBlztlxTh9x9m5HyzElbrFN+8NAXKRinmB2LmGHeZwLDuPcdqdYw7p+dpbgGMlSkNQsAtJAOo46S2okf5UHMtmpnjIzHOltoijcGP8TPgCHsLHgxXIwc2HEmCh599sRxN7ronMVFOYBRmdMDnCO3iZUJYjnhFq6M58EKfpYCG0ZHt+SVWupYecNQdkgKGdH9IGs5ZM38Vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se53/IXkWmPFo1wTxPohMMO8J4oUufK1kiWCqHq17b4=;
 b=1ccOrC1caJXIma0nCPOYarmVNogRMYtIdY6ZhR99HgX0StfNyri8sAWbY3wZFcjQQgoB130zaPDdzganmx2w1I85NZMvighIAzNl3V5VYTRPm6gUj5sv9fJ5wzXTAMUC94sEUWBm+1G1lJ4XRA2w4lfzuoda/pKikdy3MQ7+LcU=
Received: from BN9PR03CA0666.namprd03.prod.outlook.com (2603:10b6:408:10e::11)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:04:50 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::a) by BN9PR03CA0666.outlook.office365.com
 (2603:10b6:408:10e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:04:49 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:04:47 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 16/37] iommu/amd: Update irq_remapping_alloc to use
 IOMMU lookup helper function
Date: Mon, 4 Apr 2022 15:30:02 +0530
Message-ID: <20220404100023.324645-17-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1e48605-f851-4957-5a8c-08da16228e4f
X-MS-TrafficTypeDiagnostic: MW3PR12MB4457:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4457743523DCFF6A6DE42CE387E59@MW3PR12MB4457.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YCn/K6BV6LTEyTHfJUkVUolmdsz2/v54UG3sbLsOy51HVW8/OmG6LAxnnWVPm0evs/RI5EopVqhWe50kZU5DH8MZj+lbQfRbjv9PS6jB6m6qEHR6iHuT/fsdpzB6YPlNZ0iS2ewQw5uxuI20O1xgtMsJuevhkKiwxs1x3esWHzHP5jSKOgOXCp/xkDopJEFqMoJ7KhWRN0ceHcnTUGMSUXhN/S6nInDkETdma4cJVk38reqEgnkuaMfdUACn2MQrf4S5OImDPVh+ilj37Rx6MJBowyiEHQ9Lzf5tiNr/U9+23mefOF/PU6gITAMcalkk8pptH4SJz9chcK/vZMq0jOiF70l/V91yvL2tU/CUcVwqoVW0PA/KVc2wBQVmO1vuxANJZWA46XcnLzOLhcCnDDy3ubGfRslHeWQ4Zcdvz9f936UZXHt3YkstqH4g6b1Jx8lBYLjIwALp7KsN+fw2pMz0BqwOIjnp+xhmo7KTlje/lMrVEv7Ug15fThWi4y0LKqmcJamvD1QiwY8v6lw27jclaQ+13xIIMCVoFnDg14T5rm3v4YXzBOpSC4kngIZq7ohFtZqtTx15tIESEGml+WO+VR/R8Hxja0p3MHi8xCoN88Y0HpdivqJDGX7ltV0HWolvT6A8rZ3Oa/mP2UIBXKST0fTN2EPPMU+PObsR0bw3TEBKN8lF60aFJQzsRUWd/XtX5zgZnhArIw/7NTDLdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(5660300002)(54906003)(2616005)(83380400001)(186003)(81166007)(508600001)(26005)(8936002)(426003)(44832011)(336012)(86362001)(16526019)(82310400004)(1076003)(47076005)(110136005)(356005)(6666004)(36860700001)(2906002)(70206006)(70586007)(316002)(36756003)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:04:49.7829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e48605-f851-4957-5a8c-08da16228e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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
index cc200bfaa8c4..c3941e342fb2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3241,8 +3241,9 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	struct irq_alloc_info *info = arg;
 	struct irq_data *irq_data;
 	struct amd_ir_data *data = NULL;
+	struct amd_iommu *iommu;
 	struct irq_cfg *cfg;
-	int i, ret, devid;
+	int i, ret, devid, seg, sbdf;
 	int index;
 
 	if (!info)
@@ -3258,8 +3259,14 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
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
@@ -3268,7 +3275,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		struct irq_remap_table *table;
-		struct amd_iommu *iommu;
 
 		table = alloc_irq_table(devid, NULL);
 		if (table) {
@@ -3278,7 +3284,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
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
