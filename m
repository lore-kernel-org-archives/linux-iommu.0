Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3723E9584;
	Thu, 15 Oct 2026 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046994; cv=fail; b=Lk98dqNVp4ked21ZFeGdqGAeEgHB0MGd2xewgY8Xk43KUbtSuaYX7de8SWFR5D7T60xcfYBVaAWPXJH8JDAA3ibfcJtE8m1zkIJwxwarPb6wV/SU7HAh5jkQsTReLImwaOgmJe1KeSIEPc8IkoEIFipbdX2B1gsDMT2kgQwUgAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046994; c=relaxed/simple;
	bh=Z/gvDV8lgczEREA+NvYiEgUtHRsQv8P4SaKlNgG26Rk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vk/l3JUzPIgXFK2iYY8CJBKXUlYWUGnteyM96LsKF8CWpjBHBnRqSQdFC1UB/rXhv3rs2Ba6DLA+M8q3Tu80a3fl4mKUlzvR6x/ytCWIsMwvlcCegS607vVoCC+NEPF5QxPV+zWWhIlHUKGJq/zYJyqvuXfLSLhNVbIi5DD5Xq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xggg4R2S; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xggg4R2S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sp9zJtmriKvGs2b7pxKr5Uo5w5IVBdMaD6sEjQ9MHs31s2cjQT121xvn/YABATmV3q3g3oWAlwu1PV9+cvs2GUYr72Nw+HxoPfF9HbzJWZke1+mgZr6rxi/mqrL76GqFSEWM2w3qnyOeGYctk+Ik7Sr7CEej2dmqXpQToifwkmwjRumQyHYAsu8HHY+wCBr1iFwF04z7u0cwD1AbPAaMlC89vIZdtGM1E9YkPq0Nm50+E79zYJRkO0n7qFVMA+p5BZ87aMc4NhfYu6yreuOdwh/lxCJC2ZqyiKdabqedtbplEa/gWNYOz/yLCULJDDWKtuGIVtdRiCQzhY+F0oO4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaGloLY2pJJ4JCBGE+xxZGdIuiVpMsoMDPI3k3sAX0A=;
 b=ISPVk+sT8pP0opf/k6yy0AOod9sTYwD+fhlaqkI9pCV3pFuaPg27RFKdLO7I+mJ8WmaNV7D5vP5ywqHk2efsOUujd8idaq59YeEZM0W0M/hYds5MVu3hSJGd/6ibSONvdtdxgeFm9PyefHiH0HA9YD9hShdt6xE9+takAyQ7jpsjlcvud3snUcKn8EGCLT61B/sKUqEldgCthX72qXMnoIWhGBx6Frv7HwvlonRPEzqiYPgS8Xu0y7Z6ItIJCXuryGlhslDIK4m42DKH6rUGKljkj/39jvVxiKcScnYoeK+gMOBCFnAs+l4Zhe1OgLQe21OiBuPcelbCKYetmQpLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaGloLY2pJJ4JCBGE+xxZGdIuiVpMsoMDPI3k3sAX0A=;
 b=xggg4R2SOn+L+tjz9QBmEg+Sp8M2Y34WVr42WtjmCPcSV7ZsaKi+sE5dEaZ7cS0GxhIkqpj8/xVUgU7a53NWYOJUYNrbgNpBbZIiRBxwOpQSQqv851WCYysGn7pNXXvwpmK7zcczRPj5FT0qStxjpRWulM0vSd2dB0vKIFwF0z8=
Received: from DS7P220CA0124.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::8) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Thu, 15 Oct 2026 06:49:46 +0000
Received: from DS8PEPF000000E2.namprd05.prod.outlook.com
 (2603:10b6:8:25f:cafe::13) by DS7P220CA0124.outlook.office365.com
 (2603:10b6:8:25f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 06:49:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E2.mail.protection.outlook.com (10.167.23.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:49:45 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:49:30 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Jeff Layton <jlayton@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Kiryl Shutsemau <kas@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>, Sean Christopherson <seanjc@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v5 7/7] iommu/amd: Provide kernel command line option to enable GAPPI
Date: Thu, 15 Oct 2026 12:15:15 +0530
Message-ID: <20261015064515.10700-8-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015064515.10700-1-sarunkod@amd.com>
References: <20261015064515.10700-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E2:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e848003-7cbe-4522-36e7-08df2a887fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|7416014|36860700016|921020|56012099006|6133799003|10067099003|261009223027099003|18002099003|22082099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	JPK3xbCtHFCuNxzdVQb60U2PH+S6affqmrmnrNvWriBzDMjW2XklwAn7JzAj9vU6rhhfBSxaUhfxE4uLUjgax3Fcz78T0Loe47/IItoVugOOnGRAE2+juJ+PvewLfreGKLor3pzAlxdrpEk+Kueab7uU+sXC4fcAz4HIvZjyaF7gH96vc0gWoD37TeoGRxaoWrJbk7jeHvr/ms66CJbTisOE6NUbi1u2FQT2HdqvLeLBjHfq2PsBzk0G4pBvOHzoU6h0YPFCDPhSFtXzIvvGpF1SVYOCmHd1ey+2sMqYl48NzpAU0mAWnLqTuuNQaRU2gPKLVpRioOwLLMqUfhMqip8Nhoz2EIszoxh2IAx/vsgTYiR7uPoS3rB9HH84F+iPph6TRxqo4drtmgsQ14UOtnv6wV74cOZJoDBl7sQGcwTrNJxxmxi8uEYx8NtC1N28YvbJgEgE5H9/NxjYa7E3uO89GzLvPCpQDIMRZVhL2tZB9tEU/mH/RO66sp7zHyHihzM+3WSNnCXIh1+QjLRdifugkeHNoucltRBs7F86++T80O9XunNdejBtWv+3iSvvJySZF0muNfe0ZVf5pCSdJ9gM9vl8sTp8uCaRcBSRHrx3eBb03vGEvFajHaQtMeqY8b9aO4YUsYCq7FYzFKUOYJZNXO7Vz0BEDUD28GJ5BA7CHQbPcAy4qDnNbqwVdfFQEZ3+RTz6Tqd+SJnodfI/01Xq5BFP4FStUoOXoq1e0nxASUthEK9DFaRAACW2R23k
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(7416014)(36860700016)(921020)(56012099006)(6133799003)(10067099003)(261009223027099003)(18002099003)(22082099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MMMN6Y9AKnSIRt7zWQzMJTD6V1zcwNrqOh5wSaPRt4JjFxmwfO2qtL8ie1hzfBm831OZtveiK9SiiQmumBTCxwDdLGVoDrHTonh1Adc2K0YhqkO7XBFW8sRlIEOLckVIg5wNiX2SfWoqFF7k3MYe8Hb2CiMEslbkpgy5zfV3MwpraZI9d06kohHiy9jsQSyWjcFAagRh/G4ZbPPeo7I0LAvQ4qCUQ4xuXviCyvhAIKPRjZvQBfgkKutvvznMrLy5nvus8gEohacFXg/BzcIsK/BtNkcweoF18qlQtRI4eet0nSmx/nAq+qiBVyPkSaajZBLURRhYDsQoYzp3ngPwK0ylSfYH/J+Y3oo0MY/HwxPongKuGQGkVcFca7zbPt6aBKXQjsvu8jb7geJzr9TNBBaXZSxaJoHGA82pnlc2+3oIdjHO6KYTTlDjszPMuIaH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:49:45.6510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e848003-7cbe-4522-36e7-08df2a887fc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

Enable GAPPI when the IOMMU GAPPISup extended feature bit is set and
the kernel is booted with the amd_iommu=gappi kernel parameter.

Document the option in Documentation/admin-guide/kernel-parameters.txt
and mechanism in Documentation/arch/x86/iommu.rst.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +-
 Documentation/arch/x86/iommu.rst              | 22 +++++++++++++++
 drivers/iommu/amd/amd_iommu_types.h           |  2 ++
 drivers/iommu/amd/init.c                      | 28 +++++++++++++++++--
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..b260ebef118f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -456,7 +456,8 @@ Kernel parameters
 				          to 4 KiB.
 			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
 				          to 4KiB/2Mib/1GiB.
-
+			gappi           - Use GAPPI instead of GALOG for vCPU
+				          wakeup notification.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/Documentation/arch/x86/iommu.rst b/Documentation/arch/x86/iommu.rst
index 79c33560299b..6bac30f5abbd 100644
--- a/Documentation/arch/x86/iommu.rst
+++ b/Documentation/arch/x86/iommu.rst
@@ -150,3 +150,25 @@ AMD Fault reporting
 
 	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
 	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
+
+
+AMD vCPU wakeup Mechanism
+--------------------------
+
+GALOG
+^^^^^
+
+GALOG is a legacy notification path to wakeup the vCPU waiting on an interrupt.
+When IOMMU receives an interrupt destined to vCPU which is scheduled out, it
+updates the vAPIC backing page IRR and appends vCPU tags to a shared GA log
+buffer and raises a single GA log interrupt. IOMMU driver scans this buffer to
+decide which vCPU to wakeup.
+
+GAPPI
+^^^^^
+
+GAPPI is an alternative to GALOG.  With GAPPI enabled, the IOMMU still updates
+the guest vAPIC backing page IRR, but may deliver a physical APIC interrupt
+directly to IRTE[Destination], using IRTE[GATag][7:0] as the vector. This
+distributes host wakeup notifications across CPUs instead of centralizing them
+in a log buffer. This can be enabled by adding option amd_iommu=gappi
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index b89a2b3df0a4..51edd617ddca 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -78,6 +78,7 @@
 #define FEATURE_X2APIC		BIT_ULL(2)
 #define FEATURE_NX		BIT_ULL(3)
 #define FEATURE_GT		BIT_ULL(4)
+#define FEATURE_GAPPI		BIT_ULL(5)
 #define FEATURE_IA		BIT_ULL(6)
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
@@ -178,6 +179,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GAPPI_EN	55
 #define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ef23e0755c32..c536e0b3c4ff 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -446,6 +446,9 @@ static void iommu_disable(struct amd_iommu *iommu)
 	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
 	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
 
+	/* Disable IOMMU GAPPI */
+	iommu_feature_disable(iommu, CONTROL_GAPPI_EN);
+
 	/* Disable IOMMU PPR logging */
 	iommu_feature_disable(iommu, CONTROL_PPRLOG_EN);
 	iommu_feature_disable(iommu, CONTROL_PPRINT_EN);
@@ -2984,6 +2987,13 @@ static void enable_iommus_vapic(void)
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
@@ -3025,10 +3035,19 @@ static void enable_iommus_vapic(void)
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
@@ -3037,7 +3056,8 @@ static void enable_iommus_vapic(void)
 	}
 
 	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
-	pr_info("Virtual APIC enabled\n");
+	pr_info("Virtual APIC enabled with %s\n",
+		amd_iommu_gappi ? "GAPPI" : "GALOG");
 #endif
 }
 
@@ -3780,6 +3800,8 @@ static int __init parse_amd_iommu_options(char *str)
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

