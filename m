Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83274C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 17:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C35A40AA8;
	Wed, 22 Jun 2022 17:12:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C35A40AA8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zkCCYIO9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Fo5gtWOvXBj; Wed, 22 Jun 2022 17:12:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AE70D40012;
	Wed, 22 Jun 2022 17:12:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE70D40012
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ECB1C0083;
	Wed, 22 Jun 2022 17:12:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 644F3C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 17:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31A07813DD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 17:12:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31A07813DD
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zkCCYIO9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IW1yHrErZ37L for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 17:12:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C07A813EF
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C07A813EF
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 17:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7NxyLYBUW9ki3jFD2nePvbW8E1scqTxL6xC7kLAL/0Fym2pPrRWYQ8P9JGE7mQZ84MMIvBEzEkhzUNOOPD3qcpdz8NLtAWK6/sAao/SywDhYcEIOMcroOnjDnp2leSHFsvwoHFeD5z9U2bxKhrcDaD6HofB6nH0wetOIuXp+hZxvZltaKq7kok1jApprFt6YXgW1uXgTud0PfYKF/ei9Iv36R5IaBTz4ynJJfV1djUZW3Ht5+UEkbcU97+cqYd8cl+iiJcOagSEpMkYfnlFDb94eecuR5EDoZq3lRTp/DgZpUZoYyGOkDBBuHv92kajq+2tgTi2P6f6GMnO9MvBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRfMFSEyT3hc2ryWUHd3NEtyRUkvI43HJ0o8EWPSJsk=;
 b=aQyXdapeMgj9V3QGLLJw4brpXd3M/Qb86lqc//ibjj2IzEYRuGshtjOyIfM5gmUHdoMPD+4K9cleoRY0Rs08EXbdaFdrKNqryqru8yo1pEr6SB7dOdTIAdel9qAFUGNZRr/IRBFO+Q175jSbv4ttKwaON6lm+WVFnsZtk6cZXMixIPRdx3+hFS+YgTQDXnsTdZyaCCt2zxNtivjMUr0TMe6VMW5hp7odDX+HJ8K1cYTfEhGBgUSln3JIDiVk6zULajzNkgniFFLX6KUDHGru73N8RlJYNgVcmYH6238K7W6GTpLxtyi0qaWn6EZA4Tirnt4g4y1Y52dvQ1gIGEQC/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRfMFSEyT3hc2ryWUHd3NEtyRUkvI43HJ0o8EWPSJsk=;
 b=zkCCYIO9o951p2qD9pbJAxdNZPV9hTKI78fUvMcvkXI0QoJeMsQmlN1FnO/hJf4bh1PBI/xyXnz9bqyS9JkJFwKC86W1E4b4Ii6Up8ynBM03eTEpJRY88+MH4ZJ4356ypieTpc2XHDKMvKcDQhQY/5CZqDgwP4YpXXWomnGNa4Y=
Received: from MWHPR08CA0040.namprd08.prod.outlook.com (2603:10b6:300:c0::14)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Wed, 22 Jun
 2022 17:12:38 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::b9) by MWHPR08CA0040.outlook.office365.com
 (2603:10b6:300:c0::14) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 17:12:37 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 12:12:33 -0500
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 3/7] iommu/amd: Introduce an iommu variable for tracking
 SNP support status
Date: Wed, 22 Jun 2022 12:11:27 -0500
Message-ID: <20220622171131.11870-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
References: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac8852e3-5fcb-4cb5-c22e-08da5472684a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB241166A542A118E10F3BF7E0F3B29@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9jgsYbZxwjRP9O5sReqGe86bJ++d0QqnGVijz1tfe2QfGTdJOlqR1J9B1AYVZF2ePMCIRuWSdgh17AHv+MiG9WPtFnuvjSMRn+k6dGffJTnWSb3gBaWsMTRWA8zZMrP2HcmkBJ1no02oaTcqoZn3nY684xy2kX+EhjgG07NA01eFS348JZCHNUG2KmbWjqt0d5BcyP3XW8OgVfjcbRRD7kMIyGfMGeyES0qFjE3dYaEFVHdf60JASR9UtKObtaUrLQwlWyfR+8D99MGwE2JTgGRnwRkX8hby8Xg3dB6u5OV0xlf3Sj9tkVNUANBJ7Nca/koSn6fmG+5WOCExSUGxIyQhuT7S6m+dHsZXxlw7vDTp3rYmtO3mPFxBBK2DySl9m+qhmoFu3nueyIMu8Oc6AmxjiZvv3ZvWDdot61yoFQasKwfmqD/cW/7FPhOsSb0kCaWwlYfKbpuX3ECSvrDGAJhA2SWEVgReNY751VZMplMBnsONp+DYmGAZoHoUYN0eujDG7Sdb/Ac8eOJjZkPWV1Da9RkN8KburWYJ0BXTssM4cSuNJGWRJIqPO9FofMv12lQ0ENJtO1yVFNv5AwPgJaTbSOKDYQZVxgvo8rTMY6dWs7GVIf0Dqgu15tNnrOcAMK5gbFH0Ij0al++8pIWFmS+5Npxdnahjk4Do/5yC3sNwlWAui+It9BbErRlP7sOCpo1uGNELr6dpRGNO63BLFMvQeNBPPSjN4hup/TXeN3YZN0RsBYK7nX/0tx2VboPb7AAgIFmLYf0u+j11W4db5ZV0UpzE91pP06sjKBMTco=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(40470700004)(36840700001)(1076003)(426003)(44832011)(186003)(2616005)(8936002)(47076005)(83380400001)(36756003)(2906002)(5660300002)(41300700001)(40460700003)(336012)(16526019)(7696005)(478600001)(70586007)(54906003)(36860700001)(6666004)(86362001)(356005)(316002)(110136005)(82310400005)(40480700001)(81166007)(26005)(8676002)(82740400003)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:12:37.7206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8852e3-5fcb-4cb5-c22e-08da5472684a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
