Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB7FC4332F
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 08:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BDFC60F1A;
	Wed,  8 Dec 2021 08:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HX9NglG-zTaN; Wed,  8 Dec 2021 08:47:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F25A760F1D;
	Wed,  8 Dec 2021 08:47:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1205CC0075;
	Wed,  8 Dec 2021 08:47:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E24AFC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 08:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDF6441D62
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 08:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CKB7b0tlpfe0 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 08:47:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2082.outbound.protection.outlook.com [40.107.101.82])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C87F441CAD
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 08:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBzGEmSprAn2jGoemuqSKovvTjBuhi22YXsEblHgDHqclWTpHMblSk6vdBfdT5E36mR+edCY8l005W51TryIWFp0026hiE/22XuTs81W6+LhYPcfo55jGxevecyjKuMi8ImzyA4I9jaClW9haK14q4xWal7rWALANA4qhOjQrd/nrxj669hkHYhOsN8+Xvev6Q7aYrMNCYVlakE2fN/F05dWOvjvuQ5rxIhg/YaMQo4+UwmV6zpmeAQnhOcqjsxKmxjpTSnxX7YS0VmA+eX2oQCq4rjlwo34sSKp9bX8G8OcHtIuB2BGxUjHlUx6IHUV/eYE0OIW7dWAc5R7jBZCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40hdNavQRXGogFpDLhzVL/Me2vwSvrFxio25PonYd+g=;
 b=aZ9y4gUx896d/LhhNf/GNaeU8J9NrzjbeKDh6UND37PItlm07KHKOeypupPSjE/nZGyJBGAnAN9T+OMepKdHgSn/i1hnSsCMrnPvxUppgHuytmmhjRmGG06Hr8UMw9Vj2cbB0OOyGSQrhSws9vF3tNtjv8+K2GK9rCiVHRuSrRjntGaS0f7CO2782Gfo0IzIzF27Zx86RcvOCNhi1gTq8dh1ND5jMZAS0nuagUR+Hp2Lwq2X23Pqv0YOErcI6n7s+mN7czyVVOJ1I9WH4MjKwvoYyIvCmR6EmgJdXkxDWKf62L6xhIDkz3vAPZ1P2x73OR6xRsVJ9WPoRtbmclRZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40hdNavQRXGogFpDLhzVL/Me2vwSvrFxio25PonYd+g=;
 b=cZhYJC5/SCTRbWsgjrCRWDR+66wBGMNcaBKDPEWM3aYDRjmXWMm5DZxxBaz8inR8zXhUZsp3UAowzduhsCtY4wGKOV6yMrSJ4+F9VbNJdVQwOxK7a9om99zD6y++y6JB3tSCe6G2prqyNVZcUhx//1FuS9iqjbfdeV9pwjVUWKq0fViOYPztZ6OTt+hKQxKNFkG+0jBhx239HNvtO6Xzy/xI4Rd0ji/zIqvj6+y9k7bCV4qRoAQiQzsCPXaxFXa0EtpYTFHmRrhx3ez21OP79HLhcSZAdm2xyFGusF0m50UYb3DzvNzOCk4Y43AcsET7PG6nvoecJ3EEByQAt5KyMQ==
Received: from MWHPR12CA0058.namprd12.prod.outlook.com (2603:10b6:300:103::20)
 by MWHPR1201MB0207.namprd12.prod.outlook.com (2603:10b6:301:4d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 08:47:48 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::25) by MWHPR12CA0058.outlook.office365.com
 (2603:10b6:300:103::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Wed, 8 Dec 2021 08:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:47:48 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:45 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:42 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 00:47:41 -0800
To: <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH v7 3/6] iommu/tegra-smmu: Rename struct tegra_smmu_swgroup
 *group to *swgrp
Date: Wed, 8 Dec 2021 00:47:29 -0800
Message-ID: <20211208084732.23363-4-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208084732.23363-1-nicolinc@nvidia.com>
References: <20211208084732.23363-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1006bc5e-209b-4734-82b7-08d9ba276962
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0207:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0207ED61A9631F58F8BEA2DDAB6F9@MWHPR1201MB0207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQmD+OtEzyKma83vFzZyGF74X//RZ7NClOPEmcHkG6KkmJznLe006qBHkmcjsFGhzIq12LXaBgJp+5ysGvqNw+3SamGV1BMynZLefTPXJbyoV0QZI2svgmklNsWmhkouPtkhzd7rst6xdxM7bTVdxMCn0swgv/Ky+inN8w0R/00VwGsNJiL9iOYdWurnmJBbEZiIMF/Yyn+ENVja92Qs+RusWZiJwTp3euOMMjiP/NB8aM/RNnqE+pIdr45SdfP7+9szzvT8h9H21J8brBOiKJRxPaXyymXgJyfLwBCShoBR3UakagakQ2CKoAjglY+ZVnwk/W5iZF7lcpGEVDKjVxmgpj5Rn1SHDYRam9995aKtk95l+zMt31VafmmPUXyz8dstEDdHrBK7pJ1+Fw2R7lUOYWvJ9tGj1HHJdcFfn/uPdhHzqR6yNQIBakLaRO8plPUfVJDQ/HxY++R1gF3xLZK6mJ1dwIoFQxyAD1wc1tGxT1s5Dtqf1vjUvmK0V+65xUawjFbzL5zqQH6BQ2BbduozJkiawYL/ceJ1ljCo7QhbgR8aOloewZUT6Qg1sv1MrLSE0U6gdYuqwLW0udZUW/E6+Evsz8Wqme6bpGBN10X7d7Dyt/Mp9xp7daty7OpMePfWLkj4cpeS0NUgUg0QImbvmKURJ5rDhxkjpfMqNJkl6syLLViKTcD7EzP13aJ6N50PUSVtpI35H3eVeFdfVJ6xp+PIOzzrWtsqHF+a6EB36aQ+DZRIy/LJUGyNJZ51Rimc7MlyhOvCPOHObbB3UBf9+4RGYMFGRtEle5wZ9lc=
X-Forefront-Antispam-Report: CIP:203.18.50.13; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(83380400001)(2616005)(26005)(508600001)(86362001)(36756003)(47076005)(8676002)(4326008)(8936002)(426003)(336012)(186003)(34070700002)(70206006)(6666004)(70586007)(356005)(316002)(110136005)(54906003)(36860700001)(7636003)(5660300002)(1076003)(40460700001)(2906002)(82310400004)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:47:48.0596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1006bc5e-209b-4734-82b7-08d9ba276962
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.13];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0207
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

There are both tegra_smmu_swgroup and tegra_smmu_group structs
using "group" for their pointer instances. This gets confusing
to read the driver sometimes.

So this patch renames "group" of struct tegra_smmu_swgroup to
"swgrp" as a cleanup. Also renames its "find" function.

Note that we already have "swgroup" being used for an unsigned
int type variable that is inside struct tegra_smmu_swgroup, so
it's not able to use "swgroup" but only something like "swgrp".

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 9e9f37e4894c..42af216ef65c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -334,35 +334,35 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static const struct tegra_smmu_swgroup *
-tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
+tegra_smmu_find_swgrp(struct tegra_smmu *smmu, unsigned int swgroup)
 {
-	const struct tegra_smmu_swgroup *group = NULL;
+	const struct tegra_smmu_swgroup *swgrp = NULL;
 	unsigned int i;
 
 	for (i = 0; i < smmu->soc->num_swgroups; i++) {
 		if (smmu->soc->swgroups[i].swgroup == swgroup) {
-			group = &smmu->soc->swgroups[i];
+			swgrp = &smmu->soc->swgroups[i];
 			break;
 		}
 	}
 
-	return group;
+	return swgrp;
 }
 
 static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 			      unsigned int asid)
 {
-	const struct tegra_smmu_swgroup *group;
+	const struct tegra_smmu_swgroup *swgrp;
 	unsigned int i;
 	u32 value;
 
-	group = tegra_smmu_find_swgroup(smmu, swgroup);
-	if (group) {
-		value = smmu_readl(smmu, group->reg);
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+	if (swgrp) {
+		value = smmu_readl(smmu, swgrp->reg);
 		value &= ~SMMU_ASID_MASK;
 		value |= SMMU_ASID_VALUE(asid);
 		value |= SMMU_ASID_ENABLE;
-		smmu_writel(smmu, value, group->reg);
+		smmu_writel(smmu, value, swgrp->reg);
 	} else {
 		pr_warn("%s group from swgroup %u not found\n", __func__,
 				swgroup);
@@ -385,17 +385,17 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 static void tegra_smmu_disable(struct tegra_smmu *smmu, unsigned int swgroup,
 			       unsigned int asid)
 {
-	const struct tegra_smmu_swgroup *group;
+	const struct tegra_smmu_swgroup *swgrp;
 	unsigned int i;
 	u32 value;
 
-	group = tegra_smmu_find_swgroup(smmu, swgroup);
-	if (group) {
-		value = smmu_readl(smmu, group->reg);
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+	if (swgrp) {
+		value = smmu_readl(smmu, swgrp->reg);
 		value &= ~SMMU_ASID_MASK;
 		value |= SMMU_ASID_VALUE(asid);
 		value &= ~SMMU_ASID_ENABLE;
-		smmu_writel(smmu, value, group->reg);
+		smmu_writel(smmu, value, swgrp->reg);
 	}
 
 	for (i = 0; i < smmu->soc->num_clients; i++) {
@@ -1007,11 +1007,11 @@ static int tegra_smmu_swgroups_show(struct seq_file *s, void *data)
 	seq_printf(s, "------------------------\n");
 
 	for (i = 0; i < smmu->soc->num_swgroups; i++) {
-		const struct tegra_smmu_swgroup *group = &smmu->soc->swgroups[i];
+		const struct tegra_smmu_swgroup *swgrp = &smmu->soc->swgroups[i];
 		const char *status;
 		unsigned int asid;
 
-		value = smmu_readl(smmu, group->reg);
+		value = smmu_readl(smmu, swgrp->reg);
 
 		if (value & SMMU_ASID_ENABLE)
 			status = "yes";
@@ -1020,7 +1020,7 @@ static int tegra_smmu_swgroups_show(struct seq_file *s, void *data)
 
 		asid = value & SMMU_ASID_MASK;
 
-		seq_printf(s, "%-9s  %-7s  %#04x\n", group->name, status,
+		seq_printf(s, "%-9s  %-7s  %#04x\n", swgrp->name, status,
 			   asid);
 	}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
