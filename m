Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98ED8CCA473
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 01:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41F214064C;
	Mon, 13 Jun 2022 01:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 571LGpDfPPEX; Mon, 13 Jun 2022 01:25:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0AC2640494;
	Mon, 13 Jun 2022 01:25:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9835C007C;
	Mon, 13 Jun 2022 01:25:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EED5C002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D66C260EDC
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qtMyOOvvfkqX for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:25:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97D5060E9C
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Evh4zQWGNRgw3WiKhRsLe/xt5RrpQr8fbodjKRPfirXvFE/bn+Z2iscxkWgpA1okmzkeIwQq5SCsD5k/1mY7fF568U7sUr52rWjr0QP4HqQ5uVq2sbLdzUnWmfcq1vZBwhDWGcjcBw5Sgzr1RgIP5wunFKrvyN0bSfCZqMICsMUwjayuPpHbRLTrsbL7+2Sq0UZFXiRweY7PEGltfWmxtqKB2lBXvBShHOjXkIxV2rCuCqJASllgZUMCSDpJkK1Lpp4t7YsX/plvUdJQ8KfRqsxQ0u0fpoXFWzeRUrI0HSfj6mkcj44X832+7dmXOxtv7WbbxJNOwml2GofZ+FR02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgkuOh531+9G3EO9RJphlH39cqsZIvfpBvq7o+muvbM=;
 b=g4qqjYK735KLaXChPqEzsx8MfRAxdeKAroL745Wrmizbt8R6XwdHPNumtnoWu0HlDvqgdcSoqwHqA0D+tBlihUWxkE1iyU64gxU2s2yYA7V1SUq61XjVkEcaE4NCefFt56cy4bK7hR03IqBM4EVwG2jlsysqH3Rh4CfdSRDX7YNKjwTJuFajcdm1F+084fmBAePIAEJtMJGi37hryaFwm+KAgiKHebcL2VNARj0bfERMc8gwLupyneL6qW7HnbRVWXqQBb8G6+icZX3NadfKnqZ8Xf+eXdKcIiGWSp9o+9mgl3IoOHDqQLiPVqGu7y5rEgx7l7lw0pIJuA5ULf1vHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgkuOh531+9G3EO9RJphlH39cqsZIvfpBvq7o+muvbM=;
 b=tYogVI0gOYdsW/jr4wRx7TafXrvWtRoXbvtCvAzEKJMsw+6nwrNAwYz8BGpIUPlvnkxbXWA5JK1+GTwrF1aBBIM6g8keO/G4hrwOWdwyTC0MUYyQC9ypknAluXftV42E7F1RJ4hbivP14wwp2fOfKGLANNnotUyfW9UoiPmHKp8=
Received: from CO2PR04CA0072.namprd04.prod.outlook.com (2603:10b6:102:1::40)
 by MN2PR12MB2974.namprd12.prod.outlook.com (2603:10b6:208:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Mon, 13 Jun
 2022 01:25:30 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::1b) by CO2PR04CA0072.outlook.office365.com
 (2603:10b6:102:1::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 01:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 01:25:29 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 12 Jun
 2022 20:25:19 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH 2/7] iommu/amd: Introduce a global variable for tracking SNP
 enable status
Date: Sun, 12 Jun 2022 20:24:57 -0500
Message-ID: <20220613012502.109918-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8158bf62-d16f-44e5-38cd-08da4cdb9a5f
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29740E54FC9C8B295188A1EEF3AB9@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5fX2Bp8qBwenHUmD45L5k/LqxX2CVPVk9AfAYEBRzb70kzUzU0bPUQXh53RAHiJfjFxsuyQkT4OHBbJ+oLIvfnf12FKfUskBeYG9uPUHva3rJNouVo5c6/dChJem6eZh0nGBeIiWH3fOc+8s1AMckPbV9xYPFs37AeJ8KAdUpHJaeMA8iScUkbjJDsHEp2PmFY8fIzUr6H36Bd8NM0dT5ZZGX4HOs3OpKZu5cJ4b3D1CfaiLp+071bVpCXpfwY1SiJ3G3WIZG6M0djOsnvFq41khaga391IsRyPM3dNMciziKtXv8NhF+WiDLkLK7Wv4PtVHfo1Q2oSGeK/9Ho714/Swh8RZM2P/nNtJ2q06GEw1eqjD861zqx5Wbg8TYNrzdO5QLlg+N9GkhT1T3qgRlLNG/HI1audUBRqYguycAaObDrBjCc9t3oge4NYNG/9I7yON5vmOlrRjGz8iJWqmzmw2WdFwMTed0+2FMfMkpFd/rs03jtvW2LoGFqyP5914F+ZtWim+P1T1fTTz9suIpFYNAV6aYZWoB2KxaoDSFxxlge4ooY2vJVktoECe8tN9+W/7VIoVxSpkdPuxPsmSHahf5uQsTihZWakV6+KE8kS7Pbuezi6Cz0S2mXLz3P9++aAMd6542R6r2JAhLQOtfhXOoXJ1qcnpnpH7g71OMRorOPe9c2oFd8dANQ0iH4fWcvuYJ7v/2Jiz4ndlvPCJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(26005)(54906003)(316002)(16526019)(6916009)(508600001)(7696005)(8936002)(47076005)(336012)(82310400005)(5660300002)(186003)(83380400001)(40460700003)(36756003)(426003)(1076003)(70206006)(4326008)(8676002)(36860700001)(70586007)(86362001)(356005)(81166007)(2616005)(44832011)(2906002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 01:25:29.5952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8158bf62-d16f-44e5-38cd-08da4cdb9a5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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

IOMMU support for SNP feature is detected via the EFR[SNPSup] bit.
Also, it is required that EFR[SNPSup] are consistent across all IOMMU
instances.

This information is needed early in the boot process,
since it is used to determine how IOMMU driver configures several other
IOMMU features and data structures (e.g. as soon as the IOMMU driver
finishes parsing IVHDs).

Introduce a global variable for tracking the SNP support status, which is
initialized before enabling the rest of IOMMU features.

Also throw a warning if found inconsistency EFR[SNPSup] among IOMMU
instances.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 42 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6a4a019f1e1d..3965bd3f4f67 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -164,6 +164,8 @@ static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
 static int amd_iommu_target_ivhd_type;
 
+static bool amd_iommu_snp_sup;
+
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -355,7 +357,7 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
 	u64 entry = start & PM_ADDR_MASK;
 
-	if (!iommu_feature(iommu, FEATURE_SNP))
+	if (!amd_iommu_snp_sup)
 		return;
 
 	/* Note:
@@ -770,7 +772,7 @@ static void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 	void *buf = (void *)__get_free_pages(gfp, order);
 
 	if (buf &&
-	    iommu_feature(iommu, FEATURE_SNP) &&
+	    amd_iommu_snp_sup &&
 	    set_memory_4k((unsigned long)buf, (1 << order))) {
 		free_pages((unsigned long)buf, order);
 		buf = NULL;
@@ -1836,6 +1838,37 @@ static u8 get_highest_supported_ivhd_type(struct acpi_table_header *ivrs)
 	return last_type;
 }
 
+/*
+ * SNP is enabled system-wide. So, iterate through all the IOMMUs to
+ * verify all EFR[SNPSup] bits are set, and use global variable to track
+ * whether the feature is supported.
+ */
+static void __init init_snp_global(void)
+{
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		if (iommu_feature(iommu, FEATURE_SNP)) {
+			amd_iommu_snp_sup = true;
+			continue;
+		}
+
+		/*
+		 * Warn and mark SNP as not supported if there is inconsistency
+		 * in any of the IOMMU.
+		 */
+		if (amd_iommu_snp_sup && !list_is_first(&iommu->list, &amd_iommu_list)) {
+			pr_err(FW_BUG "iommu%d (%04x:%02x:%02x.%01x): Found inconsistent EFR[SNPSup].\n",
+			       iommu->index, iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
+			       PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
+			pr_err(FW_BUG "Disable SNP support\n");
+			amd_iommu_snp_sup = false;
+		}
+		return;
+	}
+	amd_iommu_snp_sup = true;
+}
+
 /*
  * Iterates over all IOMMU entries in the ACPI table, allocates the
  * IOMMU structure and initializes it with init_iommu_one()
@@ -1875,6 +1908,8 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	}
 	WARN_ON(p != end);
 
+	init_snp_global();
+
 	for_each_iommu(iommu) {
 		ret = init_iommu_one_late(iommu);
 		if (ret)
@@ -2095,6 +2130,9 @@ static void print_iommu_info(void)
 			if (iommu->features & FEATURE_GAM_VAPIC)
 				pr_cont(" GA_vAPIC");
 
+			if (iommu->features & FEATURE_SNP)
+				pr_cont(" SNP");
+
 			pr_cont("\n");
 		}
 	}
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
