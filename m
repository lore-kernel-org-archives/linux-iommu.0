Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CE3E7BB0
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940029; cv=fail; b=jqOZPzRq17jaJAOBrF4dslUXo1snKfRMo1sGdIavsGTbSHlM+exsfY1cSP2T4xIdeRAdRMls9PIvJlScDg18DTl5gO2avc1T7iWX3mrr1yOrPxNY+SQerUkFnbRHE5ekKxNxdyW+2M77c+PJRO46sA6oGoyePwC5nDsEcnuDe0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940029; c=relaxed/simple;
	bh=uEi3ji5dluimcoNoQP9l8t1CfTc7qhRl/xWxTjln4nU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYhzSNy1Wu86wS2DvXTeN7klrvo9geetY6yXxdRWIQgCCV4Kpj3b/O2XNLoHICyfCDfoIQ0iEPY9O5zuEJ2M4UerYWXedSboiQdlU8flWwRfxbXkylQoisqr8TANgsWFUs09sOIk2b0D1H25LrWAD/dBOaXwPsAXWyudmt8GR5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XlUhVIOO; arc=fail smtp.client-ip=40.107.200.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XlUhVIOO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0X9otaB6AbIrOxuVDegIDaDyUcZT4Rdd0Fy8Hm6yUvhcQ4KoeBmNYNPKnApre+TgRxQ+is0oKYgTp5Ni4UJSxOpchOCy94o/TYo/yAsdwTcESjsSsweh4En8hA1FGTXx1vA4Ry/GVkhQnIs1bnqCYphVUTxWF3fWC8FBoRBV8QP9x2jDMGIM86Iae2QbcAGTFpyCV6rrlZQatztIAJ4ticIQiQKnwxd+JBHiRiwlQGcTbHAh0qVHzfq8MWSgUlx2Bdm21CdywlFUzZjcUnlfSwHNBbqTPMIgVQKJzQDeCFmw9fSIyixmXpotrAKkKksN9A89cE+SSQjdt6kRz166A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y90PFNwCxmnOAvATsCZRv4I8sXwVAU+UatV0P9JETno=;
 b=k2sfL4ywbBgOSyJphdoqPilRtvPJ5Z9LLPss/T9uxJ5QYCHRvWNIdRN63eylqz32IExvHhhfP3Pm0MzfLLV736qOCbO4v0hW6MQnXFBHVgWHxLWtSD67AoOhW0czWXrvwPNMjb9DRRJ4jZC2SAGCiPsxhxJiat2cZFl1yEzuuoBMa/pX27Rcf4XfKx90iTOWpuiRQPhDkSN+ax3wTEBeCU1cVopkticKjnXT2rPWw8BEiYL7fEuQDHpn3nDKFQSmTVePoBy/TaFFcFDY1ksxhxDDSreYWFufpCr/onbmceTZrvV4q2zfVLHwOjgwkHsBPTeqXZdUULn/Z4D4C1MSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y90PFNwCxmnOAvATsCZRv4I8sXwVAU+UatV0P9JETno=;
 b=XlUhVIOOw/FWAvVglBP+6uN83F4PU5k6pFTG/9gYQvmxONKbz8xg7cgW5oQhi/6ucqtfv+Y9Xw8TVE8vkB74vmpL4dyWMeoN8yqNYtqeoSGbbFo9qaPAfczMwrBFkMMes1Sl6FuICaC64cXNkUDu3BVLW5iBY0wDdBX/QeLeq7o=
Received: from CH2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:4e::16)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 10:53:35 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::a8) by CH2PR02CA0006.outlook.office365.com
 (2603:10b6:610:4e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend
 Transport; Mon, 13 Jul 2026 10:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 10:53:35 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 05:53:27 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Borislav Petkov (AMD)" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric Biggers" <ebiggers@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, "Ingo Molnar" <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Robin Murphy
	<robin.murphy@arm.com>, Sairaj Kodilkar <sarunkod@amd.com>, Sean
 Christopherson <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, "Vasant Hegde" <vasant.hegde@amd.com>, Will Deacon
	<will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [RFC PATCH v3 6/6] iommu/amd: Provide kernel command line option to enable GAPPI
Date: Mon, 13 Jul 2026 16:20:33 +0530
Message-ID: <20260713105033.15405-7-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713105033.15405-1-sarunkod@amd.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abb90a5-b7b2-45d3-d082-08dee0ccfcda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|23010399003|921020|22082099003|18002099003|3023799007|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	wgBF7xlA6BfBI6PRaDY2/upLfJFaHuvqMqKvgRAV2yNyiCmL+8ihY9/50wLqyDzDW+9QZKykG5EcrET5D2NXbX8Z4HOwnbPF3InOLE/1AuZMLVqKC7+X3ifunJDYP+C6kij7pVCG5LTnAskfKHXqeQxEPZuJN+FvHewoSZ/VYo9BYu684u0jthmgrJSJaDtzwlp73UtPVSz+TkDcA3R8ivXdRMxuAw+NRX0rrNMEAlibbXNYHTfshfjvVNrZfuGXFpnRMZJxAjV1hR6TIc/q4TkEZ6o2dv7NnaDQakBuwgvKZ7I2pWra5URLvtcWQFI59ZwsxayuphjQjS5joziocw6THfLidOTiiqMTLAOZKnrlYPpq/ookkhnIkQjK1hg0MG5G7i22Bt6U3S97dH1pE0cnxaIWfQZba3qaCuJ1+lwNKKIbWjIxCP5yki7tFbxbZ+0+FBRwBdtUey0HIRP5J3pY0KyRkt+g08Pt1ZD/E9YSD0rUb7KNmuAwMxXlUYtQ1s0K6mUIcq642RCNgH1WJYBGJeEg3wMW2QX2Tel+sCljcvvFHvQjBkloSqDRspPLyUAu0N73Ru5scnicPDu5nyw47u66W04gVzhAgrZVqOQ2udvw02LY8j4opp224K9jiTH947ckUBcczfKFysdpOBLFiXHZgVpqY4HMl7jekJP7FvAVqQzfHDETyrd1aYWpqukBg39BtqGRtNwI301ZixnjQp/uPVQce4RZGSRXKtYzVVoyEo3iOcjFszQSVRht
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(23010399003)(921020)(22082099003)(18002099003)(3023799007)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5uF28teRZrOB6FCsSKbK9fPwiSCW/Bz4MhFHtGFgmI7mQ0s9h3a+F4KIaV1EUeUiHjIj6L9C1CWsKVkohc8qk+0e2zJt4g1bIv+jwEUlMvowjsIwMWgTGv6hXBrnGuN6JYZ/R5/C6J4PFMmiH1dJHLEwNBWT8/Xb5LPUqOKQg8j01MhAxBbSlhd4FouSXPEJJVSEk+DVLRvNQ49Z+purodbRNG3qN0vFAFpwzYHbs4CReVdM8FhRJj3E5NtscyDkUgHRo8pm8N2pyCcheREptkRFRo0YfjA+YlJaSli2h4Y0Ruf7nN/O/J2drl8hUcNoff+Cv2i8nNAOOIPfNN9xksJm+IkIEfi9b5WsnYkgYHXOlk4JTdH/BQMSNwQVVtkfp13B3SuK+M+s6L5LdwxqkIYSXRiftbuuu0gFQwprjzHDy22drzxgg78QCM0PkTse
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:53:35.2992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abb90a5-b7b2-45d3-d082-08dee0ccfcda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067

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
index 97007f4f69d4..d27f10cbb004 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -455,7 +455,8 @@ Kernel parameters
 				          to 4 KiB.
 			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
 				          to 4KiB/2Mib/1GiB.
-
+			gappi		- Use GAPPI instead of GALOG for vCPU
+					  wakeup notification.
 
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

