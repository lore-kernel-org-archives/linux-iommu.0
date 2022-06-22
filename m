Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD87C43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 17:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA8EF409E5;
	Wed, 22 Jun 2022 17:12:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA8EF409E5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ovntnZxp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qYc0FCGJ4EjS; Wed, 22 Jun 2022 17:12:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 146F7417D5;
	Wed, 22 Jun 2022 17:12:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 146F7417D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8CF4C0032;
	Wed, 22 Jun 2022 17:12:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC24FC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 17:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 773B9813F1
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 17:12:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 773B9813F1
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ovntnZxp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b6BEcLabCxBL for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 17:12:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A649813DD
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A649813DD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 17:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAfeA6wPBdzfORmuKW97KaIQxeKanQrmiDlOrI4wQzGsTux5gxC5LzRbd17ucBR0p/gDpr/EKkjIEmoe8nBXEO5ixlwE1SmE3qFdXLHVSiUA0kYKcFnZ4CQ9p/FWI8/JOO7tzZYoYjGbcG4FQcKrmLy3f3jzx/9QCShhPVAcsY0nI8aEYDmbGFSGx69rg5wk5t5pCFB9rsRu/oTzuQiz4n9f5aubK6JZNSmMlZf0u/Jyv86cD2bBYXlySXFBdOC5RUmRF3s9gB+CNkya28lSMokTe4byKpMMpXRB3RZjh3burwQsOwte/kSS5M/foY8jn4p2vDfbQRCP8B7wYCQ5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6yVpFxtkPWJlhdwVx2hjM9OeHJHsycJnst8oFkE+OY=;
 b=Ebs1EhrJZMZ5jl79aeXXo0138UvI/lx/Qy6pUHr4AcG3M0GEkr+UTTWUIT0rLYZzqCy6Vy9FOP/etUAr3/Ba78OQynsXu0fG96bNU8URKP1jvU3V6MxmTVmfh/D1ndeK/h3VqLm/YELrxKWX14vui3SDKQSJqRotDP+mAq6tRrI2PhQqKtQaOoERucun2nqV573khhN22VQn5oqpL045mZAqbNZfeDBqHBolRHL6uNNk2VIhA4CUpJlusp5B0lSgSJT27TIbtvHpW88bFUVozXupuACt1anqLBrxQ33mFt1/ua4V6l6TypuLVcEMlegmIXspe+6snjk67f3woMx1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6yVpFxtkPWJlhdwVx2hjM9OeHJHsycJnst8oFkE+OY=;
 b=ovntnZxpLPykTY53yo+fCtLZR7UYMsMYWzye9y2Vo9/b7h/ulmcra3aBK/lplf/fuxRHRYqisT7T0gJAK9KsU8kB9+3ucO7mj0/3XRBgUJSiTSu3HqiF431+f+jQrvCBaFbXdAWr1s7f5PruzBilosF7QipZ/EJIPXrh8kM7FNQ=
Received: from MWHPR08CA0037.namprd08.prod.outlook.com (2603:10b6:300:c0::11)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Wed, 22 Jun 2022 17:12:37 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::ec) by MWHPR08CA0037.outlook.office365.com
 (2603:10b6:300:c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 22 Jun 2022 17:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 17:12:36 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 12:12:33 -0500
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 2/7] iommu/amd: Process all IVHDs before enabling IOMMU
 features
Date: Wed, 22 Jun 2022 12:11:26 -0500
Message-ID: <20220622171131.11870-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
References: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c45be15b-5043-4a96-de9b-08da547267c2
X-MS-TrafficTypeDiagnostic: DM4PR12MB6112:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6112F9B283FF4EBCF16AD8BFF3B29@DM4PR12MB6112.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FX2KInx/TZsi81aG85+F2dlHL6G/W20mmJ2j7XqaA9R7LWuC+75jfnUCIvcBKpcIkkoLuzxkIrxfI+TaASEOmLrVfNe/fTmbRVsQtoHWJL0ntTMsF0azDT3+aOhPIsHYN+hSu7ZBdeKK2NNWeEIahhOT2W4787H7xzxO8KeVs7/Xj8G6fwUmudxS6QAHhvAb7WUZJ0krJPpYDcATwPcpoVVlXnGcsEnZzyg69SWbZXs3QjZp8dpVtzlHvUvX5+O9rClqrQQQEN+lpUaAn9mOiM59gaKQ/ZEwly1YTccIS6c2kV68aO18BHn2hRlb08Gx0SkyOv5L+1Uf1Ys/nglaynJlCF8TiBIRiCU2jEG69YewFyYiRv1OXqjxr90+vVPyvstnm4QFrXf3CveS9p4m4SHGyAttoIVRpIfWB7X6bZWlXx53cr9GrH1n0oSpO2bxfx6tXti88ZdOKhfpbviYa36NnHE72+2B3WLUtS9PIy9C7O6Sv/woWHHspt3DrqzP7scZq0bifMJf8zPfEHOfGsLifzvXAuIhQoolyyTIkpeelOYGN6DRjMbM9uMgLPt61V1TUsVeLYvxoXMSXekXK5bGmEfiXoQ6BM20G9lI4SNcXyKpP4OqjnjaBC7p3sVQEGYIC9oMw1UqfN9Uo/8JBmNc+suHP/UfYIqVflsDlymvyb7vZgbh+3umPvb4jlBI//AluQQQPg7VMt5vg94d7NtV4vX4t2VP2ZJs62+OSQJEFVn7svNyxoU9g1bh3aZfbhxdzn2idUrWUXDszefNbD9hZuChS2erZE3oBmOkELY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(2616005)(1076003)(110136005)(8936002)(54906003)(70206006)(41300700001)(70586007)(4326008)(8676002)(86362001)(316002)(6666004)(81166007)(356005)(82740400003)(26005)(7696005)(478600001)(47076005)(36860700001)(83380400001)(36756003)(82310400005)(2906002)(16526019)(186003)(5660300002)(40480700001)(336012)(40460700003)(44832011)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:12:36.8300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45be15b-5043-4a96-de9b-08da547267c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
Cc: thomas.lendacky@amd.com, ashish.kalra@amd.com, vasant.hegde@amd.com,
 robin.murphy@arm.com
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

The ACPI IVRS table can contain multiple IVHD blocks. Each block contains
information used to initialize each IOMMU instance.

Currently, init_iommu_all sequentially process IVHD block and initialize
IOMMU instance one-by-one. However, certain features require all IOMMUs
to be configured in the same way system-wide. In case certain IVHD blocks
contain inconsistent information (most likely FW bugs), the driver needs
to go through and try to revert settings on IOMMUs that have already been
configured.

A solution is to split IOMMU initialization into 3 phases:

Phase1 : Processes information of the IVRS table for all IOMMU instances.
This allow all IVHDs to be processed prior to enabling features.

Phase2 : Early feature support check on all IOMMUs (using information in
IVHD blocks.

Phase3 : Iterates through all IOMMU instances and enabling features.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b3e4551ce9dd..5f86e357dbaa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1692,7 +1692,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 				 struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
-	int ret;
 
 	pci_seg = get_pci_segment(h->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
@@ -1773,6 +1772,13 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	if (!iommu->mmio_base)
 		return -ENOMEM;
 
+	return init_iommu_from_acpi(iommu, h);
+}
+
+static int __init init_iommu_one_late(struct amd_iommu *iommu)
+{
+	int ret;
+
 	if (alloc_cwwb_sem(iommu))
 		return -ENOMEM;
 
@@ -1794,10 +1800,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	if (amd_iommu_pre_enabled)
 		amd_iommu_pre_enabled = translation_pre_enabled(iommu);
 
-	ret = init_iommu_from_acpi(iommu, h);
-	if (ret)
-		return ret;
-
 	if (amd_iommu_irq_remap) {
 		ret = amd_iommu_create_irq_domain(iommu);
 		if (ret)
@@ -1808,7 +1810,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	 * Make sure IOMMU is not considered to translate itself. The IVRS
 	 * table tells us so, but this is a lie!
 	 */
-	pci_seg->rlookup_table[iommu->devid] = NULL;
+	iommu->pci_seg->rlookup_table[iommu->devid] = NULL;
 
 	return 0;
 }
@@ -1853,6 +1855,7 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	end += table->length;
 	p += IVRS_HEADER_LENGTH;
 
+	/* Phase 1: Process all IVHD blocks */
 	while (p < end) {
 		h = (struct ivhd_header *)p;
 		if (*p == amd_iommu_target_ivhd_type) {
@@ -1878,6 +1881,15 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	}
 	WARN_ON(p != end);
 
+	/* Phase 2 : Early feature support check */
+
+	/* Phase 3 : Enabling IOMMU features */
+	for_each_iommu(iommu) {
+		ret = init_iommu_one_late(iommu);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
