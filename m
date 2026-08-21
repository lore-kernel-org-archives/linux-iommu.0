Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAB40F75D;
	Fri, 21 Aug 2026 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291980; cv=fail; b=P38Lrso8yuEcte7UPt9cY1fHXcytd4zYSnGUPYZgPn+a9FSvUsZHVcFQnPTr4Q0m21gPJWYjy/blQsTLvk7r/u4slyinZcApU0knXhJCZHmSJKyLvZioQnYRrYKvbwp3ra4x70kuM427CXxvUYOe5iRUhIR3x977C7GyQHXvjlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291980; c=relaxed/simple;
	bh=4nUFryR8alljHgHOIz+Y0Lhgr+KJQoX7akzR24EDS14=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNfQ2ZpzxNdVVtIs+fsEimGdWlEADRTsIz/UI09WyGbmcE5ZDRCj3wMK81CukWruj8K4PEKCfx6rTMX2oClQJZABSMr8uPmL8wQ7sKPMm1pP/zywVu2inalvmL7Ogvm90PMnv5zS9ZS2eyhWzFD3FIJLq+tPdsWKS+PdMCReaE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pCDaVnkI; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pCDaVnkI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS7OEFLfFykW7cUpZcRMr9QJJ8esdMsp5TbQN3KjWUTddndJ6FzuLHiyylwn6DAVx8pmqnnc7PCPQKscXlytDkutJ1V/CcdWTatI2HA0EZdNX0qpVETl+H81TG1BgOLWangWVOKQ2zgdb+l4rXmDk9RCDlDH6I61zNd51Sxn0FfO1efNzHdjY6J1J93IEXWYjnjwoPeVrTLIWYNyPSQWkbBCNXvahv985bmWtogTwzKg03QmP+u9rWTIvKzsNkAcd9ErGbjuRAXnQmnMDS1Py/l+Mk08iznQz6dGtNc89orWo4ivo/l5ljz7N9q+aKPXt/+BVMavy8agRHS+mhLTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=438fLsU5lKjRl1bAwOto4y0y/qt00MVyPaV9LPZhZT8=;
 b=CZqpkpswOzjv9qkTeSJ2HYqDFiNNoR/z6hvsQoIkXuq0ZqTcPwPO8nIeEhrT05w1t+TBpHIKAeoqDnQ5xyqTX7aj+iFkdPai2nuXruX5+ifmXxHk02ww9ONQhdoA6JfsGYOg4GRJ/MO1Ed45f4Dc57cSvGBcZujsa8RJ735wrQ8e2C4eM1RM6TJfad0kh55vu1IuxmOB38+2IAX71AXIa2bYSZZcfzjswEaELgxtRZZZO1t1FHoyBowrUaXBfiOwkVIhfsGPugVYwGJDeRf25HXFr1affQs+8+NJYs0AYSWqrFDpUYni9LoEB6khwAbN8/TD1gDPj/hYpvnksQluyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=438fLsU5lKjRl1bAwOto4y0y/qt00MVyPaV9LPZhZT8=;
 b=pCDaVnkIbaIk90b8M2/ZhTphA03Ng3GaUlGX2xlAyzjpv0UM3sm5tKSGYT4l39fQt+AgyDC3/fYaNQovfKte79z0wutUTr5FSlSThc0GtBGB7Tq3mIrDdGBvoTAe6UKaPSZMh3f51VGJqdnmJGFEYqDZD7dT3SHURsf/rvRJ464=
Received: from CH0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:610:11a::24)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 05:59:34 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::80) by CH0PR03CA0350.outlook.office365.com
 (2603:10b6:610:11a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 05:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 05:59:33 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 00:59:24 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Borislav Petkov (AMD)" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Breno Leitao
	<leitao@debian.org>, Christian Brauner <brauner@kernel.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric Biggers" <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kiryl Shutsemau
	<kas@kernel.org>, Li RongQing <lirongqing@baidu.com>, Marco Elver
	<elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>, Sean Christopherson <seanjc@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v4 7/7] iommu/amd: Provide kernel command line option to enable GAPPI
Date: Fri, 21 Aug 2026 11:26:11 +0530
Message-ID: <20260821055611.27138-8-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821055611.27138-1-sarunkod@amd.com>
References: <20260821055611.27138-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: e180aba5-14c1-45c0-349b-08deff495f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|3023799007|6133799003|10067099003|56012099006|11063799006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vBO0I1nWhfS5eOLFGtXD8D8iOyfOp/JxQ2EUUCX135NIIeYGsaEOvqKKT132CUeiSLfiA2MvLtf4dz4Fa9dTak0YpW+gnTzxJ84tAF1QYIww37qvOIadfFiOqhwpLiBIjczXvEEHdeYXn40VR+lsOotXT+EnpcNHIEwmpSzdUwbv4SBuzhkSN8xXDJaQt/6rGMtntHLZN5kMgFwcA/iltDgnyIA/r9JQTw/HhQvpUwKU81iu08p6/fTyJxzi8c+g8KK7ol9dItRN4z2827C1iMi9WUPI2qypHMGzf7hcD98PBj8Me55lkJwcreTPLRZpNeMzPqlvobU3bo6j+NS2gvVw2ta5bG8CA2g/DI2Mc8Dms6V21K6GNdM2XmfMnbrx62AVCajQWe0Q8XBudtruR9S1N8ANCyrYFCmv42V4BROOHY6PpWe/Y2U9/bzGci9dZrKJAcBAQEr5kO6ILwiOUBlZwUhwwyMZpe37ffr3ykTW5AwdO7tnr3lrB1uGw6/Rbjs1NT9/UeCQLS5EdqdhoVC5NKtrqKk9yCeHl46OXcRnri5UuLHotYFUPjH8THMdBcI68JL0gW/epSqeuGmNDuVoMLiORjzm0q3o+CQymM9P9qPAR1gIskU9FrOrLxMisxtoZKvTM3gAwRScwWszbo3VdPDr6loFzfb/BMbuQVBP65fR0E2/9IPRoZNBDBIub6ZiH6LHb9aMmHPtFtS/jyXgRbYQQutHzpPclkuheLppYu6xq0lJ5rBcK+q1XAUF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vssQGqxmATOskMlWHSN/VNNDk+SYzRCrpPchyuk0hsKNneEAasGF8rhz+2yAQTN2OWKANEA5mUxzgNHJstBdtTDh86VhUb1ABfDLM915sobCKDdE3/bpyaOZdqG+yPp4K9FfS7jGnF5hzxtsauXBv2pr1IwcqtGL5kQeytRh9CFNydNj/tG2gHGBWInO0Pkicw4okQC88Q+MX7QBbsDd6mx5rkgqOGL5qafZ3GYK6OoZuKd0rt5kxru6bVTDpKWvbnJ9lTiVQXP+KRt9YjXDTotCZVMoflZsdHZdYqg6HKPiBNzDDqCzWWNEh2cvNxtKr/GIHCGo5cJkZ/1ztw9GaIPToq/VHWRXIuc9O3Bd/rTRaDKWaJy72TbgFmzMu4IwXlpfj6H+rG48gIGUx80tMGyQ1CDcS8U2ywtOw7FLlJZgEcq9BBJ8cn35ifbvDb6p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:59:33.3638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e180aba5-14c1-45c0-349b-08deff495f90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

Enable GAPPI when the IOMMU GAPPISup extended feature bit is set and
the kernel is booted with the amd_iommu=gappi kernel parameter.

Document the option in Documentation/admin-guide/kernel-parameters.txt.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +-
 drivers/iommu/amd/amd_iommu_types.h           |  2 ++
 drivers/iommu/amd/init.c                      | 28 +++++++++++++++++--
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 97007f4f69d4..7bea1bbaa0e0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -455,7 +455,8 @@ Kernel parameters
 				          to 4 KiB.
 			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
 				          to 4KiB/2Mib/1GiB.
-
+			gappi           - Use GAPPI instead of GALOG for vCPU
+				          wakeup notification.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
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
index 2e1889f8a9e4..7d2b1c24f6ec 100644
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
@@ -2999,6 +3002,13 @@ static void enable_iommus_vapic(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
+		/*
+		 * Disable GAPPI, do not check amd_iommu_gappi as it may be
+		 * false in new kexec kernel even though previous kernel has
+		 * enabled it.
+		 */
+		iommu_feature_disable(iommu, CONTROL_GAPPI_EN);
+
 		/*
 		 * Disable GALog if already running. It could have been enabled
 		 * in the previous boot before kdump.
@@ -3038,10 +3048,19 @@ static void enable_iommus_vapic(void)
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
@@ -3050,7 +3069,8 @@ static void enable_iommus_vapic(void)
 	}
 
 	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
-	pr_info("Virtual APIC enabled\n");
+	pr_info("Virtual APIC enabled with %s\n",
+		amd_iommu_gappi ? "GAPPI" : "GALOG");
 #endif
 }
 
@@ -3741,6 +3761,8 @@ static int __init parse_amd_iommu_options(char *str)
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

