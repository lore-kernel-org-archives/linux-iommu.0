Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BBECCA473
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 01:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B72DD41A1A;
	Thu, 16 Jun 2022 01:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i5MHd1BqpKFP; Thu, 16 Jun 2022 01:56:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 47F1D41A22;
	Thu, 16 Jun 2022 01:56:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0802AC0083;
	Thu, 16 Jun 2022 01:56:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41549C002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21E7B4031D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y5fXD0aG4phg for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 01:56:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C5CC40194
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1Ghu7H4bqdoHZu0oq8tdez0/IHWc0Tup8KtAJBK+Ga/Bx6K3vkKiW2LkTm0US4Y1u3WF4/K6kFSG2HnBzZLbjX4MJOFJDhoFMETlueWa61YYWvuIrJoBT0DekxYxD2c6+4G1PkE295+WAYyDSRW/ee1Joj5l6f4BAsbQsuD91z/Ymi52IiIjduruniyvxHa8ZR+e0FRH2F8lX3op4ayXQNKEb29+EWmNuQNNzsYWp32eE2WIcfeN6rmjbNuBODawNcwTUJ0NpuiHSUU16SMqKbmdHfOMOl+rMPNlp7DF+WYV/ksiFq6h1Nc5sOQLo86JH4kP3h2I1ciSiRxgu/+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRfMFSEyT3hc2ryWUHd3NEtyRUkvI43HJ0o8EWPSJsk=;
 b=Il/vK/VWiOt/MFCatWWsGh31N9l10mSm2s3/Ta4OPCT8/4Dk9UO1Q8fzaIiKPPnDVl8Aje11XoEIYHg6+q7L0KzW8a2Tt/7SrXlXouQh1ivCjlb7AG/scXIlXIxRm44QrJI5JNIpXVHfb4/tCQnOoePDbLCKPrYPxFwUSc8yuaReD75gaf736UelZBcwQx+mu7k0FGAbnjVqWYpqATsb1Ki/3MPnfQLPBrIRVrNhi8z4PVdgp9oUgQ/Oha1OWvrh2s7XUmRCcU3iDMOUAgEJdwqKtmbVu3u3mOKNiuEw29/doOHMfScXC4JD9BZbFl8MqQpWt/FFCQVqCdhL6CgXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRfMFSEyT3hc2ryWUHd3NEtyRUkvI43HJ0o8EWPSJsk=;
 b=4qs5ew9fa4fwRxjxLN8iedTPW3dCWbHdeZZvvKqEwpdZWYpb4dG+qszGy2OCyD63wcuruuWd5edigm5+LiiS0l9FsGjMKimXhdzNf9gBrMGR3GUNTRfGz/WCBZ0KNDa6FgaajKw9+Ezz7jsbFN8yRNcxEjL8McWF+zQRVmi6MMo=
Received: from MW4PR04CA0232.namprd04.prod.outlook.com (2603:10b6:303:87::27)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Thu, 16 Jun
 2022 01:56:25 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::dd) by MW4PR04CA0232.outlook.office365.com
 (2603:10b6:303:87::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Thu, 16 Jun 2022 01:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 01:56:25 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 20:55:56 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 3/7] iommu/amd: Introduce an iommu variable for tracking
 SNP support status
Date: Wed, 15 Jun 2022 20:55:37 -0500
Message-ID: <20220616015541.11207-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
References: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7612ee2-a876-4070-9a36-08da4f3b6ba1
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB561442631646CD11EA7D9127F3AC9@SA1PR12MB5614.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3Y/SkJ4zJy7vaS0GPFxL6CX54KygCelK4MZez6zEs2miWOg3veKHPhM9m+Ieoopza/wVK+dX+4Axkf/o3iObsAbdhJbdlxP/v2tDRp1De4W8rtyGHUfu37TIz1hOKAc5B1eLHh6rcI8qGXSJkR2rlXstszK7JfUjUSaQZi+X86mfkCdF4w+zC+X+4YeNPIhnJLlBqKxUgvXbhh60g7bfW5VOCJ/QmRM72P/LL261Q+TiuSu1taYHzcl3gPmyptjjg1GbEdcPQX/YMyp94M3dpbuUZFFfamerKspT6f7hFYnvzvCkuCuJN2qC7PBTVq/7MRUy0idpQ97Y2+NBZFMTxGXXrzdLEacgvshcc2MW6MOib15lqbcPfdieHYjSo8Z6Ztk8fcBbe1dQzH7swmfUh8sEQ8wTYwWXzYbxBGpunwaaW/yuRdwDxSyfD6qO1+en/tVsC5WqpRU10PUQN3qagxQLxE5RPL+tzQdVGZIDMymExiQYnEZtjqPsqSEwByyRz0jHNjNhJ7ZTeeBHIIYkPegOZ3lLRf1NvgZUHZg8IkOvHK4HDrTSLQLpX/DSwJuUSTkjwsVxpWIxMIqEF7RNWHx5Io/kJ9k7VthHYGCfJEBdYaz4TSyvGf1AQbU8gPD9xk8rUBQW6pQTjHR5M+83MPI8fapfl2gApPQE1lfuexBa4OQXR9dLZGcb6I7MrFWkAd2KMGC8ynI0MHM/yVwjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(336012)(426003)(70586007)(70206006)(16526019)(5660300002)(8676002)(186003)(4326008)(83380400001)(47076005)(44832011)(36756003)(8936002)(36860700001)(40460700003)(26005)(1076003)(316002)(356005)(86362001)(2616005)(6916009)(508600001)(81166007)(54906003)(7696005)(6666004)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 01:56:25.2045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7612ee2-a876-4070-9a36-08da4f3b6ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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

EFR[SNPSup] needs to be checked early in the boot process, since it is
used to determine how IOMMU driver configures other IOMMU features
and data structures. This check can be done as soon as the IOMMU driver
finishes parsing IVHDs.

Introduce a variable for tracking the SNP support status, which is
initialized before enabling the rest of IOMMU features.

Also report IOMMU SNP support information for each IOMMU.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5f86e357dbaa..013c55e3c2f2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -166,6 +166,8 @@ static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
 static int amd_iommu_target_ivhd_type;
 
+static bool amd_iommu_snp_sup;
+
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -260,7 +262,6 @@ int amd_iommu_get_num_iommus(void)
 	return amd_iommus_present;
 }
 
-#ifdef CONFIG_IRQ_REMAP
 /*
  * Iterate through all the IOMMUs to verify if the specified
  * EFR bitmask of IOMMU feature are set.
@@ -285,7 +286,6 @@ static bool check_feature_on_all_iommus(u64 mask)
 	}
 	return ret;
 }
-#endif
 
 /*
  * For IVHD type 0x11/0x40, EFR is also available via IVHD.
@@ -368,7 +368,7 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
 	u64 entry = start & PM_ADDR_MASK;
 
-	if (!iommu_feature(iommu, FEATURE_SNP))
+	if (!amd_iommu_snp_sup)
 		return;
 
 	/* Note:
@@ -783,7 +783,7 @@ static void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 	void *buf = (void *)__get_free_pages(gfp, order);
 
 	if (buf &&
-	    iommu_feature(iommu, FEATURE_SNP) &&
+	    amd_iommu_snp_sup &&
 	    set_memory_4k((unsigned long)buf, (1 << order))) {
 		free_pages((unsigned long)buf, order);
 		buf = NULL;
@@ -1882,6 +1882,7 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	WARN_ON(p != end);
 
 	/* Phase 2 : Early feature support check */
+	amd_iommu_snp_sup = check_feature_on_all_iommus(FEATURE_SNP);
 
 	/* Phase 3 : Enabling IOMMU features */
 	for_each_iommu(iommu) {
@@ -2118,6 +2119,9 @@ static void print_iommu_info(void)
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
