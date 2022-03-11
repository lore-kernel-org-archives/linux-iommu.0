Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F4AC433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD14B82919;
	Fri, 11 Mar 2022 09:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yn2UFDRrKIL0; Fri, 11 Mar 2022 09:56:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ACD1A82890;
	Fri, 11 Mar 2022 09:56:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E9E5C0012;
	Fri, 11 Mar 2022 09:56:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4E17C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6143418F1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxrav3GEaF2J for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:56:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::613])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F133E418E6
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaQ1AgTY/iq9NaNHO9VXkg5x4qkfCU+RI2CZQD71Hlnh8Zn14wlEHI1IN77iENv1kqq4xhk81PhD+PTJSiMXWc2BpiLi1Q90zqB88A+96SwemcC19BzRfV43mi+c/xWw2DuNTURiQL7clJT7bTcVpyocBkqU6u+8dxbEz58/h4M4YNV/K/xuE3EvNDYpK6E/og0jBLiZ6MVWnR6bZ2/aSHNJFqy7D8jVjkUnIX8Fl/IgWBRAnpEwgnokqP05FJ3ktpy2iJKKFhdGHOfF2UWrWr6F5UVP8cWohxzritIzNNfbCEd7HSdPdJUYuOhUrAgNrmpYT+YAu2BISu12soSQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXMvT8cuxB+n0m/5s74oQA/JTRAhyZAgVJH1gbS7P5M=;
 b=YdwiFoT2ZR3w7qpkAVONvUFfQrT6K+WEenyRE/n+dmAdVTGMD9CD002o/5UrdgGBnciOu7pmaLmTYI5fx2L13IebgLh6HFpQZGbOgLxvkvZU21CqqGgV7dSMtwHgRLtRHHU7rQUVmw/Wq/Q27TvCqL+RL3XyXEPvnv09KRvHK+mjRAGm5btJdbZHEtHwZviEdLBxPbKoMrkIdS20h2Chp+FQNSh72ED9TMHTgO60+66Fl6499UuJjtQ9I7OC7g0NIVuFE0sjdPGGZejefwV2IU40JC1aqeTwkXt6/E2WpY/KUo4GQ7WiS2lgweojSV/cctMIBL9QaW6kD9pMwKL+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXMvT8cuxB+n0m/5s74oQA/JTRAhyZAgVJH1gbS7P5M=;
 b=t7/SjZl3I/CInhSSoam76Rolxq+ljqGef+rNbIZYeD9GF9lue9KilMDVe2xG0yFZjEAfEfSMx4QjtWa2XUNtx91LSF8bRMHoWhK0U+YmLJbEhLgHzsge00imXccWzu+92jliU6QGaz7pXdaS/dJgaHX8DA+NYYGEGwAn9hIdC8I=
Received: from DM5PR19CA0071.namprd19.prod.outlook.com (2603:10b6:3:116::33)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 09:56:21 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::9) by DM5PR19CA0071.outlook.office365.com
 (2603:10b6:3:116::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25 via Frontend
 Transport; Fri, 11 Mar 2022 09:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:56:20 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:56:06 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 15/36] iommu/amd: Update irq_remapping_alloc to use IOMMU
 lookup helper function
Date: Fri, 11 Mar 2022 15:18:33 +0530
Message-ID: <20220311094854.31595-16-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31f14a1a-4f69-4be2-20e3-08da034564d5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046078A5F682F8F9655EF65870C9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //F7oRS3n7yGpivE0Ut4FzvlZM7vlAEmyKtCU2EtYQ5ZNNvReqUJvd76pcnIGS8DndtMBoGwo1h38T7fPE9Jk2zJdAeRYd9qxE9FxdWgyoWsBM09VruyaxJxd9FKyP8rVOUZ6So8WN4vEm+AuDY0a5EbQjnQ0X9/EGNLCyOaeksK8da3ei4mEeHyVXCO3PZRFCf4tlm/qOW5cvtsdfFBobCm9eLE8IlRxCqvjQnH55T7HV2HcLsp65TysTrPm+fAkm2VbYjMSX1ca8TX/qC5Wz/jxpmrXfJPmDT3fIVqE7NuzESLO0EB3XDmTi3IbmQvuOIHLeHKtK3LIAIoL9QoFDnmYnl4ivoa5m8RoId9cDKqP6EU9XXAWE01lD/met/i1Ch9YAwWhFy2f0JCv53z+fHXOe6O3ZE13UXCXMOfNopFTTpWm6bwMJ3NygZFiV7bn+sNYlfknnnKZWFI9Xx6JS/24pYEgCTFrgSbEOA76FrcFwK+aRZa0O/QfASrfPZgtBZEnlat6pITcbnT9tj9MEh50ftNgUYCbS7ZMHShxzBzrT62jnSVlyTYiwfSl9BUJtEcM3TlInq6rViTyPYcDQrkRZ4VMMsBGiHuHUFYJyLKW+NkMkSiKuDNZ/ziSJ1MgkLJ0fy/fmpdwqw7dL66VfwILIWm2GNauqZd1rfTyeknjnlF0VsCheuf/UCliePavoXdFFwfFJCtqaekDZC9bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(426003)(186003)(70586007)(16526019)(8676002)(26005)(2906002)(83380400001)(81166007)(356005)(44832011)(70206006)(82310400004)(86362001)(336012)(6666004)(36860700001)(508600001)(2616005)(5660300002)(4326008)(8936002)(1076003)(47076005)(54906003)(40460700003)(110136005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:56:20.4568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f14a1a-4f69-4be2-20e3-08da034564d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit>
---
 drivers/iommu/amd/iommu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 51cf83aa04c1..124346161258 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3237,8 +3237,9 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	struct irq_alloc_info *info = arg;
 	struct irq_data *irq_data;
 	struct amd_ir_data *data = NULL;
+	struct amd_iommu *iommu;
 	struct irq_cfg *cfg;
-	int i, ret, devid;
+	int i, ret, devid, seg, sbdf;
 	int index;
 
 	if (!info)
@@ -3254,8 +3255,14 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
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
@@ -3264,7 +3271,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		struct irq_remap_table *table;
-		struct amd_iommu *iommu;
 
 		table = alloc_irq_table(devid, NULL);
 		if (table) {
@@ -3274,7 +3280,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
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
