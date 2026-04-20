Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A18288C08
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674589; cv=fail; b=cxtXWQoN0DTEQZgbvqdCCsffi6nXgrfHJ12RGv6SiKO5vOqLknrzBLirrcHiE975rAXkciME2S2RCr/qJwLaNRzF5eDyaPyyxkPVj4rpsn9G6kY97zsmdrT5GbgGmi/Wwf+Uxz4l0rhDE+3GO2jG+e2WfSC28pqOKziZ0oO6g4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674589; c=relaxed/simple;
	bh=CmzREwSDwRF2RJhxbBSj5hIq1iVkWiGtS15biPJK+M8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiY08PvLl3+Z7Wl13mM9ix7aWt0OyOhick/iGpwMZHXXA/2rPV/UMlX8ch+lecpx8+pSklhDS+qOXZxjzsmmTVWT8ilhxhmOMTEdQRhRjsb2ga2weWBIjsN2g7WY2K0temRytr8QVOSvoluJ8w2+q6a/h4sgAtLkXm65HbQe1h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ppZqwKiB; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ppZqwKiB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5pOewq3OwhZ+GynzFtg0Jmb2FLQaZwE0meTXiHoytFaIqIAiz67hpdJ4M0uoy83V2nTRCVJEnBliOqgMAoZNULbRe+ydE5W3klak9QUrqSPVcySfir1dPOoHv5QaEkklr9tY6zTsCZTJO/t8odB4yBLpajuElqNsM4lpMYUZv+e9S2ENowfS7psiIp5XXBne8mdkOcZsE+1eIejsKl5nTe/9TPUUjMxiX43F8JLYREV5C699Fflku+p/U2TNcHueM5fN9RDJl1NUftQ2Mt0VzeVF6q75+WPX4G6tg3KkchSkh+4y/iWYXhshlNuNs1eZJ26Tf4RfKdwGKIiTqGQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHmjNQgbfOnargvwrqFBVmjUvgVqKfrCm0tgKBs2urk=;
 b=tRNLCSnBHlpoZd6O8H/2nPTpXdDXDKd5qi/MJsm8VAHMpOywDD4tnqUAG3KRQwb+CRj51GRPPtdjGAGtuwGwKhF54lEEwsz7XpJyevkVgTUsBdtRnVvi7v/2FMdbbgiZxYB7WRsG0IekdYr2Q74MhSUfV5UlmnujaoGmIGcbbrtyxkLf6q3Jq3+S/gREqIGFrLsMbHzOZ3TFBY+dor5MLBDgl4KkECpdPj999ehAfUVW/fb19v5l0CAIZPAowxP6KvlTsHRc9Nex+QNcfeb9vZmwVScUqnXm801DOoMbgwPWIsfI+3Pl6DmDa4WnxGh0SZe/sU9j32KyNdTelK62nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHmjNQgbfOnargvwrqFBVmjUvgVqKfrCm0tgKBs2urk=;
 b=ppZqwKiBn3/ZZIW3W5LJNeXToDhVvZ+Ii4YoVYvsL8L+N5OfQNHCshAM7iHHfvMiKcPu3SSmbhmLBXeAhQ76AEOXYJtwfJs+53f8adIhfgSbE5s3WpGpM6eRmqdtTh+qzsl+SWGfeoimUusbWwax4j1Z2B6iWl/Dw+BIdRlqhiY=
Received: from CH5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:1f4::10)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 08:43:02 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::3d) by CH5PR04CA0004.outlook.office365.com
 (2603:10b6:610:1f4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 08:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 08:43:02 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 03:42:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <bp@alien8.de>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 2/2] iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19
Date: Mon, 20 Apr 2026 08:42:04 +0000
Message-ID: <20260420084204.12263-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420084204.12263-1-vasant.hegde@amd.com>
References: <20260420084204.12263-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: 382ed8e2-0ee9-4862-0926-08de9eb8d593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|13003099007|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WwI+WVWCiKy+FdSTgfvtIzVscURZCO+trtVHDhJ5pu4Nt/o+k5v5YJjil9qadtoGT0lnI/7m7MZBpMQzA5p3AKkxeuwOg3VrV5vcJjwFgYigjBpKz5hTC5F49+qkI0Dozs1oZ+a8Sv3oWXj5Mn2NLyUgZaqIFeLeAlvhMeIGBQqp2BZNUnPdd1SlYltdevRz9NlixsY9YGMCuU2LrsItRLym1QnjJWXF8K51NF/J9NXxNdPMZL3nytVMCFfGGmFv8IMMHCwIqtuHikzEOCw/UbL8YdmACDmepG4D6S4RbfTBjzujDHGhGtfXXcWVRIpmfchgyMVG2dwyNrtoQeathUAaopfrUL/Xktjtkfwxa/s1qiLtsC0WPMcgJj8aYCXAd65GgnloezSgypZ30rMjOgzpuLTCXljwnev+rJWYfb38HMzliSEFQPGmDLqWzaQ5eV/5EyRr1DPQrLJTIbxuFxoC9XlRjKLvatqsVqFsHJoWZjas4AmG6jtpa6DZv83XL1UfMZUbKFGOcYA+voJ3+ZF2o6sl/M3DjO1aqbpgKUElGW+UgPdoJVWHQGkvnwg8x0ksecYDoac2wgvN8D+Z0wnMRChBuGT8chir9KXNP4WiRX2M0YE1uvOxh+RV19HDDCPVNrm/mY2UdJhx5BWMwA307HyDglpo1L3PBFl8FJHmwdNB/wQOmWGV4ZDhn+/KnaJn3UNaVIIPH/Jt+fOf4+3c5lENqFoP8/KN3wdZiLTtzbxieZ/LRH1OuL0HsSmXldF95dVUHd6BuceIcc24Yw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(13003099007)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3kh23VBeKlBzo+W83XnBLJL1SdspDSrvnMRQjFGEsG+faPvctfRjS4lccGJ1HSCVNMhMR67s1VxcHZEZOuccZahqwOTsXG4OVFzrhj/OtOTsc7KdY88DQSApgZPNN1JqUvMxXXu3JKaCZv1CIA4ZMlFVGrX93HoFOq9nhEKLVp2HD+mvKTn1MydLnWI0G8NnzX5KKxYtEzd6dZe7L996Wcdt7wooK+KXjQ7HFahmxFicGVSdMqCKb9jn8JjMUMGzBHIwYsEs0OrNZjxHM/YOMY99PbN8cfo4KwKmnoQBuht3WyndArieiMCe+lXCb4gazJT4rN0pI+nO1vpiOVtUiGGWB8G2OKe563ZTBbh4mU3R5Lkq0uPjtTDLgD3zi0p8I7GoOsHTcy9804MUI4atqpX6QDNdql41qYjCpUYJk4vMCXtKTO8UXFD6aSgBrlGa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:43:02.7019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382ed8e2-0ee9-4862-0926-08de9eb8d593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494

Due to CVE-2023-20585, the PPR log buffer must use the maximum supported
size (512K) on Genoa (Family 0x19, model >= 0x10) systems when SNP is
enabled, to mitigate a potential security vulnerability. Note that Family
0x19 models below 0x10 (Milan) do not support PPR when SNP is enabled.
Hence the PPR log size increase is only applied for model >= 0x10.
All other systems continue to use the default PPR log buffer size (8K).

Apply the errata fix by making the following changes:

- Introduce global new variable (amd_iommu_pprlog_size) to have PPR log buffer
  size. Adjust variable size for Genoa family.

- Extend 'amd_iommu_apply_erratum_snp()' to also set the PPR log buffer
  size to maximum for Family 0x19 model >= 0x10 when SNP is enabled.

- Rename rename PPR_* macros to make it more readable.

Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3016.html
Cc: Borislav Petkov <bp@alien8.de>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h | 11 ++++++-----
 drivers/iommu/amd/init.c            | 13 ++++++++++++-
 drivers/iommu/amd/ppr.c             |  8 +++++---
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f1c486dcf0f3..834d8fabfba3 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -12,6 +12,7 @@
 #include "amd_iommu_types.h"
 
 extern int amd_iommu_evtlog_size;
+extern int amd_iommu_pprlog_size;
 
 irqreturn_t amd_iommu_int_thread(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c3430c09bc5c..f9f718087893 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -267,11 +267,12 @@
 #define EVTLOG_LEN_MASK_MAX	(0xFULL << EVTLOG_SIZE_SHIFT)
 
 /* Constants for PPR Log handling */
-#define PPR_LOG_ENTRIES		512
-#define PPR_LOG_SIZE_SHIFT	56
-#define PPR_LOG_SIZE_512	(0x9ULL << PPR_LOG_SIZE_SHIFT)
-#define PPR_ENTRY_SIZE		16
-#define PPR_LOG_SIZE		(PPR_ENTRY_SIZE * PPR_LOG_ENTRIES)
+#define PPRLOG_ENTRY_SIZE	0x10
+#define PPRLOG_SIZE_SHIFT	56
+#define PPRLOG_SIZE_DEF		SZ_8K	/* 512 entries */
+#define PPRLOG_LEN_MASK_DEF	(0x9ULL << PPRLOG_SIZE_SHIFT)
+#define PPRLOG_SIZE_MAX		SZ_512K	/* 32K entries */
+#define PPRLOG_LEN_MASK_MAX	(0xFULL << PPRLOG_SIZE_SHIFT)
 
 /* PAGE_SERVICE_REQUEST PPR Log Buffer Entry flags */
 #define PPR_FLAG_EXEC		0x002	/* Execute permission requested */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 74effb847f48..a590f487937b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -133,6 +133,7 @@ struct ivhd_entry {
 } __attribute__((packed));
 
 int amd_iommu_evtlog_size = EVTLOG_SIZE_DEF;
+int amd_iommu_pprlog_size = PPRLOG_SIZE_DEF;
 
 /*
  * An AMD IOMMU memory definition structure. It defines things like exclusion
@@ -3420,6 +3421,16 @@ static void amd_iommu_apply_erratum_snp(void)
 	amd_iommu_evtlog_size = EVTLOG_SIZE_MAX;
 	pr_info("Applying erratum: Increase Event log size to 0x%x\n",
 		amd_iommu_evtlog_size);
+
+	/*
+	 * Set PPR log buffer size to max.
+	 * (Family 0x19, model < 0x10 doesn't support PPR when SNP is enabled).
+	 */
+	if (boot_cpu_data.x86_model >= 0x10) {
+		amd_iommu_pprlog_size = PPRLOG_SIZE_MAX;
+		pr_info("Applying erratum: Increase PPR log size to 0x%x\n",
+			amd_iommu_pprlog_size);
+	}
 #endif
 }
 
@@ -4080,7 +4091,7 @@ int amd_iommu_snp_disable(void)
 		if (ret)
 			return ret;
 
-		ret = iommu_make_shared(iommu->ppr_log, PPR_LOG_SIZE);
+		ret = iommu_make_shared(iommu->ppr_log, amd_iommu_pprlog_size);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index e6767c057d01..1f8d2823bea4 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -20,7 +20,7 @@
 int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu)
 {
 	iommu->ppr_log = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO,
-					      PPR_LOG_SIZE);
+					      amd_iommu_pprlog_size);
 	return iommu->ppr_log ? 0 : -ENOMEM;
 }
 
@@ -33,7 +33,9 @@ void amd_iommu_enable_ppr_log(struct amd_iommu *iommu)
 
 	iommu_feature_enable(iommu, CONTROL_PPR_EN);
 
-	entry = iommu_virt_to_phys(iommu->ppr_log) | PPR_LOG_SIZE_512;
+	entry = iommu_virt_to_phys(iommu->ppr_log);
+	entry |= (amd_iommu_pprlog_size == PPRLOG_SIZE_DEF) ?
+			PPRLOG_LEN_MASK_DEF : PPRLOG_LEN_MASK_MAX;
 
 	memcpy_toio(iommu->mmio_base + MMIO_PPR_LOG_OFFSET,
 		    &entry, sizeof(entry));
@@ -201,7 +203,7 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 			raw[0] = raw[1] = 0UL;
 
 		/* Update head pointer of hardware ring-buffer */
-		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
+		head = (head + PPRLOG_ENTRY_SIZE) % amd_iommu_pprlog_size;
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
 		/* Handle PPR entry */
-- 
2.31.1

