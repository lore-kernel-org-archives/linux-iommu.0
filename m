Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA13E63A6
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939974; cv=fail; b=jewR+itVx+T25ux9kOY/C+9Em68Uh2p64WsK2ATjymLszZ7T0U0lDOQqhaLD1ctgv3s5GxoXdVoSU0NxmAAnnVwAuHuihMKae6/8eomHW+sVxk08aXlF5on24Ffo3e7x373ZjXbMEsgBk3wmUb7mk9z3uLwV4wNw5zEVXhDJWHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939974; c=relaxed/simple;
	bh=sJ6LG8nKOw7dk378+ogBlpnR1Fy5tm6bhAaupTUoPIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDQLwxqe9Ar3hINcM3TxxinpZOasYDilRmw4xaqmaWVONlynvM1w/7s/vycUn8nRzy3eoE1goDRKE4HGuo6b/bjboLoSCgAzCwisbhqrHum6ZGpzM/+LFLJOok6Kw7yr1ddm+jg4rnHhanfh1Kywim+u1kAo3UbjnT1ikrcRXrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TobWfDy9; arc=fail smtp.client-ip=40.93.194.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TobWfDy9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvUjeBWciew/+PLI/ktDzk0/VOEy5H9daU52RlbjgkGMePYg7zOlXFBsrrzL4TB7xXoiLkD6tq9PcjvBoVkkKfpA82giySFnrOT4VKeZmjC2MoesHmsPCkfvjX6aDCEH1pLVZ6G7Eqbvy0cF0xEU8i3FayAkHbWMRossJOL+6ipCvv0mhtOfDEL/gQ4NkQe988grXtrGnyU2kXUsOw97FMlOPE4BIjNEENfqeNsKIAgFkKiLaPnBoxc6oWzrMGDl5jQGFFhfQMrJiXbvmL/7h4GPxC106qhmg1Ktc9xlBTvJJpf+HoYs5zBSWNyUGluAWbxKnbbM83a08MJdQZspKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBrQ8f5qVH0zwy/a2Zvs6licIQ2zKMB6DUz6mgCKhmA=;
 b=Dp7IBtL5unJ9qv5OLdpRA2qzpD0fqKgyCkudM49tgWxNAdMU4qS4v17QIASBgJrpfLNK0yXJMZUEt8K4eifoks4RsJ0IcSTKYXClrR7ezcgucBjpqGndHd2TCBKEmp13f9bKpSnAztgQgbxICbksmpMc76wnOODZCeiW9W47182JyvML4mxeahQO/wrrK5uJ1st6L1Q3w6BKGgSuzuW+2kf9NA1TMRWu/rgcZEldq1iTQ+QiS/nfEXHXjUEeSTdiYgzMrmkuvlPyYVvzDbT7SFbmMREkn6jTlMclhziiM6DtjVq8SLrkuQvY6uP0LOnuzrrasrfRaLLW6lh7rXkW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBrQ8f5qVH0zwy/a2Zvs6licIQ2zKMB6DUz6mgCKhmA=;
 b=TobWfDy911apsaK9dvunu0BYGwhBFegzkC3a8Tg9IuNKTsdWL/rbBiRfQlz6TwWskL6xGxZJn5T8I5NSNWE3RC5LYHkQ+omTCWTZLe3VXWV3qi4jA09HfTO1PZQXjmhFsztX1JBK2onmmTM9CJCEoztmcn+TsX4TqQYa2sRO5Z0=
Received: from CH2PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:4e::24)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:52:47 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::ad) by CH2PR02CA0014.outlook.office365.com
 (2603:10b6:610:4e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 10:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 10:52:47 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 05:52:39 -0500
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
Subject: [RFC PATCH v3 4/6] iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] = 0
Date: Mon, 13 Jul 2026 16:20:31 +0530
Message-ID: <20260713105033.15405-5-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b998913-0078-40d5-0bc4-08dee0cce05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|18002099003|22082099003|56012099006|11063799006|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	RYkDBMAyP9+IZ00gX9CTFwVzqB7Cga9hK/4K70xQYoAc4QYKOi8oO3HGj1T/iiG1gBmBv64s8A30o9VV7CZKY/bVulFjpv14nJsHAemY4CfmbGrZH/7egpyvj/bfKLjzbGphHn0W5exxvKGROlImo1CoQ54xMsX2yAEF76NwAlOwvbyrGNYEuVUy5Y91pJKyW3Cfvpmm8zGQYlofPbTn/YDIr1UohJJLMNMfr8BwgNQegp2k2cOEHItpCS+rfkY48aIQHrpuZ7oQSW1rUa+ub/vMwn7uNfsUjPwMHZRxQW6RvLvPYVeRwxq4scAE798vJzFcMuz8FZhaDc4FweVoTRHnsw10S6UxMVeBgGb42YB3ZebX6ej8MvIdDbmDcD9nlP6gm1FVEUE+cc0mxz61PXFf7Bd+GfDbT9TDuhTbqwsaWCatEYoHfoBlwI93ILbpT8SrnT08+bLALUy3L7ITQw3HLqQ2HzoJWAp5BIk6deP0m1iWxfvWmslKO/noy2/UB9rIsW2GuxXV2UnIIESdvC6A1TlM5aLYpA1s4H+wA7qEap3SoXKnGiWhvnafsFrbM9QFNiF8iHJWOG5zKQ6yKF9U5iAH2P4QtNvWKJNgJhHdDV4Vi/FNGQJJ+pNcg8auXRPzRyL7ckjP70mqmwXPdwxMDG6sDIe03+sov7NY76yHPzREj9B5i8ZGYVrKuMcogftXpEHRWErVSvg6PWBqqUDA1GhvdaaGXBcxEjJ6C0qgvHWGC456JMWD08tIAfmO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y1Pdlgexjla3aiFBrE7OfaNCcfx7d6QOwO1Pz4HtscYihSZYLotyb0cfJNTOZvKnj2smsHm5RMWmxO5GgWj0HUHS6XEmSC1ga+1G3XOH7IEjwGCieeojOtOt77v6JtJBKUvqx9FpgBqADACVd0C4759oz2VHSzH/htC4HYyuGJF5OfLWCRMcNKja/CDd/yLANQDR+fKSQfGHyn2beiIkmIRrzjRY3tQ4RLARNQHNWzLD7mwwNhCclnDnrt6zlwaKvZ7unC096mi/9J07RQrE6gKWP2wwhLzv/Y0zTaeW8Vdy5TiFdKCto3mc6BYzSigP46HTfJotwyl1es08JF1jiHTkD4GVf9zhyCgkAZMAsbb1Jff1gOkOBn6SaXOz5nQCCOj6SAiGZH0M2hTGsGx/oDu6f7zP/CVxNbvVTbq+memLTicGeaC6FMX3BVwTFbfH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:52:47.4808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b998913-0078-40d5-0bc4-08dee0cce05a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

Guest APIC Physical Processor Interrupt (GAPPI) is an alternative to the
GA log for notifying the host when a device interrupt targets a
non-running vCPU (IRTE[IsRun] = 0). Per the AMD IOMMU specification [1]
(section 2.2.5.4), with GAPPI enabled the IOMMU delivers a physical APIC
interrupt to the CPU described by IRTE[Destination], using
IRTE[GATag][7:0] as the vector, while still updating the guest vAPIC
backing page IRR as usual.

The AMD IOMMU also allows suppressing GAPPI interrupts using the
IRTE[GAPPIDis] bit when the GAPPIDisSup feature is available in
extended feature register 2. The AMD IOMMU driver sets this bit when
the wakeup_intr flag is not set by KVM.

Note: amd_iommu_gappi is currently false; a later patch enables it via
the kernel command line.

[1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  4 +++-
 drivers/iommu/amd/init.c            |  3 +++
 drivers/iommu/amd/iommu.c           | 30 +++++++++++++++++++----------
 include/linux/amd-iommu.h           |  1 +
 5 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 834d8fabfba3..044179cab12e 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -41,6 +41,7 @@ int amd_iommu_enable(void);
 void amd_iommu_disable(void);
 int amd_iommu_reenable(int mode);
 int amd_iommu_enable_faulting(unsigned int cpu);
+extern bool amd_iommu_gappi;
 extern int amd_iommu_guest_ir;
 extern enum protection_domain_mode amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f9f718087893..26d7a9796e64 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -113,6 +113,7 @@
 /* Extended Feature 2 Bits */
 #define FEATURE_SEVSNPIO_SUP	BIT_ULL(1)
 #define FEATURE_GCR3TRPMODE	BIT_ULL(3)
+#define FEATURE_GAPPIDISSUP	BIT_ULL(4)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
@@ -1004,7 +1005,8 @@ union irte_ga_lo {
 		    no_fault	: 1,
 		    /* ------ */
 		    ga_log_intr	: 1,
-		    rsvd1	: 3,
+		    rsvd1	: 2,
+		    gappi_dis	: 1,
 		    is_run	: 1,
 		    /* ------ */
 		    guest_mode	: 1,
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3bdb380d23e9..2e1889f8a9e4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -160,6 +160,9 @@ u8 amd_iommu_hpt_level;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
+bool amd_iommu_gappi;
+EXPORT_SYMBOL(amd_iommu_gappi);
+
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 91405e71b3c3..7eebf4745a67 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3970,8 +3970,18 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
-		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
+		if (amd_iommu_gappi) {
+			entry->lo.fields_vapic.gappi_dis = !wakeup_intr &&
+						check_feature2(FEATURE_GAPPIDISSUP);
+			entry->lo.fields_vapic.is_run = false;
+			entry->lo.fields_vapic.destination =
+						APICID_TO_IRTE_DEST_LO(apicid);
+			entry->hi.fields.destination =
+						APICID_TO_IRTE_DEST_HI(apicid);
+		} else {
+			entry->lo.fields_vapic.is_run = false;
+			entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
+		}
 	}
 }
 
@@ -3982,15 +3992,15 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * If the vCPU is scheduled to run on pCPU (@is_running = 1), configure the
  * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr. If the
  * vCPU is scheduled out (@is_running = 0), clear IsRun and set/clear GALogIntr
- * based on input from the caller (e.g. KVM only requests wakeup_intr when the
- * vCPU is blocking and requires a notification wake event). This API is
- * intended to be used when a vCPU is scheduled in/out (or stops running for
- * any reason), to do a fast update of IsRun, GALogIntr, and (conditionally)
- * Destination.
+ * and GAPPIDis based on input from the caller (e.g. KVM only requests
+ * wakeup_intr when the vCPU is blocking and requires a notification wake
+ * event). This API is intended to be used when a vCPU is scheduled in/out (or
+ * stops running for any reason), to do a fast update of IsRun, GALogIntr,
+ * GAPPIDis and (conditionally) Destination.
  *
- * Per the IOMMU spec, the Destination, IsRun, and GATag fields are not cached
- * and thus don't require an invalidation to ensure the IOMMU consumes fresh
- * information.
+ * Per the IOMMU spec, the Destination, IsRun, GATag and GAPPIDis fields are
+ * not cached and thus don't require an invalidation to ensure the IOMMU
+ * consumes fresh information.
  */
 int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr, bool is_running)
 {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index e962ad511d04..729d82c4e09e 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -80,4 +80,5 @@ static inline int amd_iommu_snp_disable(void) { return 0; }
 static inline bool amd_iommu_sev_tio_supported(void) { return false; }
 #endif
 
+extern bool amd_iommu_gappi;
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
2.34.1

