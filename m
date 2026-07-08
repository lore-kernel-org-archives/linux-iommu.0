Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D9040962A
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502195; cv=fail; b=ddjXyAE6ZAIsNhedKwiIPpi0IPwlEkCAZYkXC9GGjQWB+fw2KBJeeBH8jyRwdJjIMxDvz7bqzEzNfrOox5SMrOak4okew/3KRwMViYclEt6Ws9nCUojt+aAEpcnklhx65YFORQy8SLR+WHj/g8JJ4dte4voFAamZFLngEmLrdWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502195; c=relaxed/simple;
	bh=8lVHf9PrP51/4+Z9u0Ii74LZxrQLq3BmhMzl4dTtq84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ie7hYrj+uq2HxwlKiPVY9mI5vuPPmsLsB0Ufh2wamgEIHhBLiJXb6zbiAGUUvCMI20QECUlPa/JqcFPKI4PkAS+p/EP48asM6ZFRrDws3zG3wcZLXq04ofVeyABKGeEkw/48oe/Ec6xUbcGAUByQICW17t/O2d+JtafEMg4DJ6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KHJtjIxM; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KHJtjIxM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBYnbAbJNYk9teyYO7C7/cloXK+cIf7+5jPOWU/viTgCY2D84Q83n+gJ75ZvShhZLjEY/bx1Ee909hthnFF9Hfj6b4nUCDJ+NXMk1dwo27meerf3PuWPHh5xJ/1ccSMs1HZVYffmJsWMKVI5XiX+R/FldaUBbkkzcSGQ/DZvoGV4HBm9AAtJjIcFdazCqOg6H8+3p/dlclqV22pmNWhVfyNTQ+XOpoBZsNKxBAv4cckcvpTg8o/G3Q45L/hkB/X5pAqJDw32U9Xi9MT3izWbQ28O2NMwXM9a2JYj1O/9W0aMa+M2WV3WAEF+xS4vlYeDoTiJ2GaZ9UAfyesbqLPwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO35+c3saBXZkwqA7qqdrM9vT/xtMF9uZFOaMluoUYE=;
 b=wsGAHbAE6Gva4CVVThtLsZ3/M08Tv2doKpX28OtazoKR6xv/x3tox6qbT+zXrnsxNJcJ274bzpgk4LgSDV5DQxci9joJ4Tdr8UDodHIXnl4N7H+DhCaZRdSeRjWnNbvnfA0X5az51W3dXUkAw3eSCDSXGfeQU6rk9qCewssz6OWk5ASfQHUrc+65gD18qrjTwzqp/LZgdqR9mE01BWjla+P7Ez8363Z34+1eQkiJsVYZV4Rg3V3KYFUW/YbS2Ond84JtXL/5P1x4xENbIKlp0sSxJFQZay9YzNL1ZkIXE4ZvKkNBZvjrROE0MI7YcH/ybijhh32z4ajIwEjOoPceZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO35+c3saBXZkwqA7qqdrM9vT/xtMF9uZFOaMluoUYE=;
 b=KHJtjIxM4cngdh9z7W4QNK1+aUA4fO0YMV52tztlIu0+uwVtODJz5V79167xY36tBnJDfGpQiDl+2NqSiijlbsuN0jmhOyA4MKTwES5fn93xArJWpe/hxPDhOssX+jIV4nI1jXsOz9pTydK/xFdfmrlwbAS4qEXp0nqPpPd7tq8=
Received: from BY3PR10CA0005.namprd10.prod.outlook.com (2603:10b6:a03:255::10)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Wed, 8 Jul
 2026 09:16:22 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::1b) by BY3PR10CA0005.outlook.office365.com
 (2603:10b6:a03:255::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 09:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 09:16:22 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 04:16:16 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [RFC PATCH v2 5/5] iommu/amd: Provide kernel command line option to enable GAPPI
Date: Wed, 8 Jul 2026 14:44:08 +0530
Message-ID: <20260708091408.12106-6-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708091408.12106-1-sarunkod@amd.com>
References: <20260708091408.12106-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4e8b2d-d9f3-4f91-c3bc-08dedcd19409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|23010399003|56012099006|18002099003|11063799006|22082099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	0Dpk/9KFKUmHzmbcIcebfimBy6vu8JKEjWlyV8dIV1O/NRUm9NWdbbVBMekCZ/T7p9HP64swVlGg2fywGlKkjVQ1vow++r5yXgm57FCzU47fXVXNaGIGc0lhsttMaFRoUk2ZAmRgr4wxHy9vOU42s3jxLAV6BRQHzsmSsoUUejPl6DnHQedImWVfgf7FTHJoLsdByWCeWbLBFcBVIp6t/efNyHfoZlyr6P0jcaZvLuCH7RkuQ/KPnZHs7BGDmm4DA7AicxGdx24oKfIP3t+zOybxRslRPQY0tBzgRIbnc7ru3EGBR5MiG49ITjJIrenJRZncxkJ0BXK2morAv0ESUhJfdptF8Zvp47OPgJu7R6+jxq+lEMSXZSLGClrEk33lA+wrhobu6A/voxeFNng7qFT2YXMOjLQSFoYvm9BnRdFtY6ZJ47NUkh+UwslJO7q38CMnkGXfj1PqYqoI/L/IAm1Op/jDZX2ngz2uwHbJ48mEEsokhaiCtFdWIVDakYuz9NWZC+Vk50yXAffk0e/Z8PBbh/j88pNvK+J9lD9ytQyEH5pyQ/Fy15d+zUeRsaDuPDDg8gxGZPPY9aMGfHWq05dcQXUYjgFNEs58jjWz/G88Uly9PCt2JsNk/rvko5tjHe2NMNy5ycM2tHxBe+qXlVHp+lKxTNf0oInzqEzOH7dVJJGfchXbv7mx5hb1IvTNUEsCchQNr15q7xcB22kHF0wA6Jj14igAvvfyFHOFFXCZvMLYjAHcPEHKtl344DVK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(18002099003)(11063799006)(22082099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	alKULkDFfFBecoZYBQDqrccjJYG7CfKyhFCctjvj9oGsi5UABBIieYh387X55L0G+ZoOI8KDIEYyCKdrQnnspi0onz9eh1IjCGcbTDaZrRVg44ddJs6Xzh/fKfj3pv9zhI/VYLnbdvxPw0xDUIzDw6uHlykeD/kWy1yl60dnUrsG6xNZ7+3Ss3R6bGzux+PB7MgoAJxEHnSdxzRyLjbf6qLCQGBQCdhtXSnn6rTrZ/nhetByd7fWe1Gdrwy9ZHF3qW4u6xpUp2h3SFy655vV5ka1EtiSfpCEA7yi7R1g16UQ3DfNxmYHJNkTiZKvxleikQtd6nczW/HsZOMnL1LeC58T053FxsLJKSY+uO5PQkv+RLGUbfKU6FyruLhAH2e5HmtDH3Y1YNOi/nEKRj5sgpiPb9XnddRqP3xSJfqi0b/24GEDIsPTtoHxwOrY2zme
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:16:22.2374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4e8b2d-d9f3-4f91-c3bc-08dedcd19409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167

Enable GAPPI when IOMMU GAPPISup extended feature bit is set and
the kernel is booted with "amd_iommu=gappi" command line parameter.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/init.c            | 27 ++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 26d7a9796e64..de0b23306944 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -94,6 +94,7 @@
 #define FEATURE_X2APIC		BIT_ULL(2)
 #define FEATURE_NX		BIT_ULL(3)
 #define FEATURE_GT		BIT_ULL(4)
+#define FEATURE_GAPPI		BIT_ULL(5)
 #define FEATURE_IA		BIT_ULL(6)
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
@@ -191,6 +192,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GAPPI_EN	55
 #define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2e1889f8a9e4..27ffb2184bf2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -465,6 +465,9 @@ static void iommu_disable(struct amd_iommu *iommu)
 	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
 	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
 
+	/* Disable IOMMU GAPPI */
+	iommu_feature_disable(iommu, CONTROL_GAPPI_EN);
+
 	/* Disable IOMMU PPR logging */
 	iommu_feature_disable(iommu, CONTROL_PPRLOG_EN);
 	iommu_feature_disable(iommu, CONTROL_PPRINT_EN);
@@ -2999,6 +3002,12 @@ static void enable_iommus_vapic(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
+		/* Disable GAPPI, do not check amd_iommu_gappi as it may be
+		 * false in new kexec kernel even though previous kernel has
+		 * enabled it.
+		 */
+		iommu_feature_disable(iommu, CONTROL_GAPPI_EN);
+
 		/*
 		 * Disable GALog if already running. It could have been enabled
 		 * in the previous boot before kdump.
@@ -3038,10 +3047,19 @@ static void enable_iommus_vapic(void)
 		return;
 	}
 
+	if (amd_iommu_gappi &&
+	    !(check_feature(FEATURE_GAPPI) &&
+	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
+		pr_warn("GAPPI is not supported.\n");
+		amd_iommu_gappi = false;
+	}
+
 	/* Enabling GAM and SNPAVIC support */
 	for_each_iommu(iommu) {
-		if (iommu_init_ga_log(iommu) ||
-		    iommu_ga_log_enable(iommu))
+		if (amd_iommu_gappi)
+			iommu_feature_enable(iommu, CONTROL_GAPPI_EN);
+		else if (iommu_init_ga_log(iommu) ||
+			 iommu_ga_log_enable(iommu))
 			return;
 
 		iommu_feature_enable(iommu, CONTROL_GAM_EN);
@@ -3050,7 +3068,8 @@ static void enable_iommus_vapic(void)
 	}
 
 	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
-	pr_info("Virtual APIC enabled\n");
+	pr_info("Virtual APIC enabled with %s\n",
+		amd_iommu_gappi ? "GAPPI" : "GALOG");
 #endif
 }
 
@@ -3741,6 +3760,8 @@ static int __init parse_amd_iommu_options(char *str)
 		} else if (strncmp(str, "v2_pgsizes_only", 15) == 0) {
 			pr_info("Restricting V1 page-sizes to 4KiB/2MiB/1GiB");
 			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+		} else if (strncmp(str, "gappi", 5) == 0) {
+			amd_iommu_gappi = true;
 		} else {
 			pr_notice("Unknown option - '%s'\n", str);
 		}
-- 
2.34.1

