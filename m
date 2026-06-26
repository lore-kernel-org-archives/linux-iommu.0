Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46323D291
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471623; cv=fail; b=bMXqFWnToieLnjtL9mJIC02S/n7EosVEzDcZaF5iMwyzahvUEMgZyTz482mA7Q7K5+Po4iCIzJqg4kFjfcIdGFEOZj8b+IE3evpHQOpcb0UV4FWWiWZuHt7V9jAGhvgD9N6fV15zYyMq2kKYWs/jLHiNijbTeHwbIIYzID79W5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471623; c=relaxed/simple;
	bh=Q4lVjeJnyXYwhYAXMlSg3mJWw217lE0jRSLn7AVQbsg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ht5BzJW5e6bxMfscK7Qqvf3U2KPhub892DAe+2eWbBeVtLDwAznR8Kujf/AW56Q9CIGGgxtAsfOnbHyHxwZRlcyvTybR9Pw4s2enqiksyVt3ujJYR51AFT1xKqkdttwMhFboEZt51Om6eiCfBjv52wdT3e+5vuW3HuysBz/OXps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e2+wEIT1; arc=fail smtp.client-ip=40.107.200.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e2+wEIT1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYRfi7LFEotjpiYdweVlGLMvJpD5b/vNP8jkx3itWUcVpQj+/gapnOmmzjmXh9FTM+LVggFDTGjZ6cW6VAxqPVv0ZVnCnEzmLpgzC7L6W1QiIIP5cjVs9gHLEJHZydxGU9hnAF3PHKGd+hLLrTxdNU6GPB1HNEIVUIEgLTE+YV9EUEEaQZVGRy5p1MfSj92JIYPq2vZHR4J0PG+7bEaIoODqs3tCaI1pzcXvoNKP/MURuxEFSecXB4PHgnmiPvVcgAlxoEZhsyBquE/u+XGwQ2ZzJjx0QhAJhZ8bCj34vVr06dLufPI/Oz8+yCMShpbJtpHfqjRyACOfNaKotf0SQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LRFXS0l58NpS88q7lI0JaIrvGK56giMkAAN4F6DdKc=;
 b=yh0WfrcCKGRfwudNMT2jGKjK6Lrzg5gl4ttm4rIWyaZXKPNJdOHNHtT40lYIW9tMcN3QOHwySQ3sgJ5RIr0I+iuLtU0IgQnnzyeWx8nmsZDOg6O59CnBGSQklu87jqdT5UjWEUf16DoSPoRw0KFiFZW70CRgyezn6rGGcgJSvRTCkzC4tVRZnR6pL+Qb4QZsTwr+M3UpaGEIV2z5Y3q6otCodbnSmyGS3zRIUbj7gBjcNisXDhaHCLFoSr88v7SSec28mGyneI93x+4YzRCUmoSokBaztsvmpMSJJ5K5lF4CedTXkvYR2FGoLTjdAElTPA/C5gNll213QOU6CpyP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LRFXS0l58NpS88q7lI0JaIrvGK56giMkAAN4F6DdKc=;
 b=e2+wEIT1cFfiBZ1gwD1B6VEq9rDiU4Vd8rdL2x26CemHDX+fmty1nz25ZMLVWPIiwSwu/ztJfFBHv50SDFVFC4YY8+XyR9qOBH+uZLxnTQ2W31T6xfWa/xsAt5RnaXCyI/uqk7fNY4ccNtOSIgst7JEypqHswzpRytY7aiZ2eEA=
Received: from CH0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:610:b1::30)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 11:00:16 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::aa) by CH0PR13CA0025.outlook.office365.com
 (2603:10b6:610:b1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via Frontend Transport; Fri, 26
 Jun 2026 11:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 11:00:15 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 06:00:09 -0500
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
Subject: [RFC PATCH 2/5] iommu/amd: Configure IRTE to use the GAPPI for posted interrupts
Date: Fri, 26 Jun 2026 16:29:03 +0530
Message-ID: <20260626105906.14577-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626105906.14577-1-sarunkod@amd.com>
References: <20260626105906.14577-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: ccade098-5f09-4d48-3548-08ded3721a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|23010399003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	D6lG/Z5kR3B4Wo3X/79nXa9HwZ4PDk00SY6YO/Jio/ANjJtmUgWP5BRAfQfKBnvraqlCMRQXKEJn+O6OEXVV7rZuLLZ98/CrNhueQD+klNfjJF5rvGWAV24xnTCnF23cLkh03W2SXuiCjcqH7rC+lrQt8OBENckG4zFIHJo3vJnrpt1y7eDGfsrjB59t0pgMgMELviBckwIATqQxC4oib44XN+yGGSimMo7scojzbsc6jJyFmGowB9/uqiwroflUxOSIW40Lty+TD97gVVtbLnOQxWxSgG0Fgt71ijDMNlMrof8zzrdTn1l27HCrVTaFlFrFct94zv07xNP8rzhA+7SjR2jc35Vo7sYbQtiDGfoASMgysn4Kn4EWZP/G9h4S8+sqv6iQL0YDg75FIGkRpMy4Rwc3ZYuSJFGNPOnuftok/F8XU2f6ouZCs2G1bGdzjhJNqIykI5ewQNs1Xphl1udivTqf01fs72IhXHazPOipGgBo6qdF4sVI62+6oLGc1xh/0k6OG0Nac0Ej0r2IMJxZ0X/1do0zhNBYQDbLhC9xEzk8hBNz+G0d6odqM2C2rbZc1GMYPMK1vtfUAx+bCBqEcDkDssoH03tOeUlKIhRELdGDjVhFVK27d5GkbpvqzeQ6AMqOTUC6317Snd2XUxqT5el52f8BZNB2Tq0v6lGVitamCkNfV8NNKIMjHIooizmUb2hdh8RsA9xY9ELxx61ZGr6xrPC94XsiNf8mPF8a5B+9xMrqKHg+cN6dfic5
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GZrJseatxhIticRyyxdfUrYdwS17z7GFSXW0xjELmzEWQ3sn0jXJmYqaDpJSBExVUV9rCKXhYzZJo0cUv24C9DP/72TdKhqr24uFfsOEmz6x5P+KCThx1azbb0ZNLBl9n0Njks8ERje/asP6WhRq6N8vveRLiUriTmi/Ab7riqmu2hvP6hJEukZbPd0BQg2JDEjJcsJQbTYZuPlxbj9mePI9iK+qcTh2H1qqTZkQOuh3dAxLFqscCIHTIJs/9pGlrIwwfUuAdBKauGrfcmYgaw+xDYTENgVw8UHLANqzyFwYdybbqY6Y/S4LOjjMfhBYjuFZyB5j8gIaaxInKojqL/0mhr5B/1V+GCsNSBplixswsMcB31Ijj/+xCNaq1We0CuIbH6G/w5XchY0gOJC9uYDr3NJmWsC9R8rv1fUYjCv3Akr0c75PjrDb/SYJvCYs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:00:15.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccade098-5f09-4d48-3548-08ded3721a7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

When GAPPI is enabled, a guest-mode IRTE with is_run clear delivers a
GAPPI interrupt to the physical APIC ID in the IRTE destination fields,
with the wake vector carried in ga_tag. Program the guest-activated IRTE
accordingly.

Reuse the POSTED_INTR_WAKEUP_VECTOR for gappi which is already reserved
for posted interrupt wakeup handler on x86 and is handled by IDTE entry
sysvec_kvm_posted_intr_wakeup_ipi. Intel VMX already uses same vector
for the wakeup case.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/kvm/svm/avic.c             |  5 +++++
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  4 +++-
 drivers/iommu/amd/init.c            |  3 +++
 drivers/iommu/amd/iommu.c           | 21 +++++++++++++++++----
 include/linux/amd-iommu.h           |  1 +
 6 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 7862b13c5409..b666efb5d91c 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -955,6 +955,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		} else {
 			posted_intr = !!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
 			pi_data.flags = posted_intr << AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
+			/* GAPPI is disabled at this point (amd_iommu_gappi is
+			 * enabled in the following patches) hence keep the
+			 * apicid as 0.
+			 */
+			pi_data.apicid = 0;
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
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
index 76f0e469490e..4690cecc9aa7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3969,9 +3969,18 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid, int flags)
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
-		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = !!(flags &
-							AMD_IOMMU_FLAG_POSTED_INTR);
+		bool posted_intr = !!(flags & AMD_IOMMU_FLAG_POSTED_INTR);
+		if (amd_iommu_gappi) {
+			entry->lo.fields_vapic.gappi_dis = !posted_intr &&
+							   check_feature2(FEATURE_GAPPIDISSUP);
+			entry->lo.fields_vapic.is_run = false;
+			entry->lo.fields_vapic.destination =
+						APICID_TO_IRTE_DEST_LO(apicid);
+			entry->hi.fields.destination = APICID_TO_IRTE_DEST_HI(apicid);
+		} else {
+			entry->lo.fields_vapic.is_run = false;
+			entry->lo.fields_vapic.ga_log_intr = posted_intr;
+		}
 	}
 }
 
@@ -4034,7 +4043,11 @@ int amd_iommu_activate_guest_mode(void *data, int apicid, int flags)
 	entry->lo.fields_vapic.guest_mode  = 1;
 	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
 	entry->hi.fields.vector            = ir_data->ga_vector;
-	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
+
+	if (amd_iommu_gappi)
+		entry->lo.fields_vapic.ga_tag = POSTED_INTR_WAKEUP_VECTOR;
+	else
+		entry->lo.fields_vapic.ga_tag = ir_data->ga_tag;
 
 	__amd_iommu_update_ga(entry, apicid, flags);
 
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 3dd9074e5967..87e76f617ea1 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -82,4 +82,5 @@ static inline bool amd_iommu_sev_tio_supported(void) { return false; }
 #define AMD_IOMMU_FLAG_POSTED_INTR_SHIFT 1
 #define AMD_IOMMU_FLAG_POSTED_INTR  BIT(1)
 
+extern bool amd_iommu_gappi;
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
2.34.1

