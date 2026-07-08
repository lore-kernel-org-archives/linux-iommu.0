Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84078408627
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502130; cv=fail; b=u2We4YS87Lfj6feUx2ul7j+D3zQ8mjSdI7+HsxeRZhTtc9X1Tc3pwmCVYK8avsnwvEmOJxuzCBN+GkzcQN9+fO+woA7L1YDTw6BCVLRgpxGMm07QtO3HRv6YX2qbLkL/cqAw2ay+FqlMIgVBKUG89TMji1BFUHM3JC4qYjOjy7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502130; c=relaxed/simple;
	bh=GP1K+pStiuGHzIc5Qn5adT4z9GlrzKFrpX5e1Y8K4Bw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkZ3j+wZrFw4puKsqGvOuDcX/6LulBzwbvAJiuD8whoTRoLi6KYX1KA+Ac7apdyQEjj9HUiThg9AB1UILOioyjTg0eaRbPq51z5HZLo+RRjuK/HMBJCS/2mSTR7wd1ya75Ni4JZLhGUmcEd50YQpQ3Rtjq/ZYvziLS+WTg+PyL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HtiUmA/g; arc=fail smtp.client-ip=52.101.57.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HtiUmA/g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4mmRVZrF5vHTxY/zF87rhwgKtdx8dexowu6udzMrmPpLRfbeG07cYnoPvKmkqFAEd2gu8FtQOw1BEJKzQh9y5PdsCDSA0Wl6I+jDRNnUvBpZowR3DfgtzrrPiD+qnYGiuKXYZ91mfhgSNfJbDSGVFGG1Cn8fpdR8St9waddO/nAaX2OYO72RvHL80SF07Wl/EwjsbZcW+E60+3AUAvt2EfV6pOnqkpKUzr5n6rwNJVafEl/zrJYWsOe/c+k67wWlY1jYqmI+kBPjK8/ev9tCiEtfXBxsEyiPBnJ57LCP0c5vXkeKmM1g4VYAmyXZEBSB5TO7lp/TLLY+SzL1eyUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2DAfovDC/ejKHkyJBRaQbp6ilo7LAXKmXhrQnWX3Zg=;
 b=UsevjQ08LIz90qi+K3eoEM4JSMnm6VbnmajH9fvxHvRdNJKGCDOSaY06pdtTkpyQheHRKK2EjJvB5DdWHOcTYFaLcusEmqzt2RS5shoCQY8H/CAmxxpW70ocm0BOvzVpCrSm4KjVB6YLu/KhqxtQtUQHY+lshvkvvKX6p8rPH3T1NyN6fNCv3efFcZfRpspIv2TJ5AqEb+T7nkQJE/NXxTu9S8A4CcfGGI9mQlt1F1a8QbXOrDSdkB5nvI8WelnA2BgkAI5dcBD3+YlbsepzZr1CpD9aJI3GDVIdzpNsbjAjKRip/7NS2N0daFTrLGrynmkJh9JG3ZfYiVg0usg9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2DAfovDC/ejKHkyJBRaQbp6ilo7LAXKmXhrQnWX3Zg=;
 b=HtiUmA/gyHfFul/hP8yoRwrzW8XAc89LseKoFtXN4HENa7TpgRgFfLGHoiqhYqrVgOYkAe2t20h3KdMiPDrXwATi9D3dIijoRnNItd2v2VF+mMnAkRfrumvGboy6xMP6P9iGEbvYTjGT/Y/9k+R1kbjpMEgSP2+1lwe85ZzpzDc=
Received: from BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::7)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 09:15:22 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::10) by BY1P220CA0009.outlook.office365.com
 (2603:10b6:a03:59d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 09:15:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 09:15:21 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 04:15:15 -0500
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
Subject: [RFC PATCH v2 2/5] iommu/amd: Configure IRTE to use the GAPPI for posted interrupts
Date: Wed, 8 Jul 2026 14:44:05 +0530
Message-ID: <20260708091408.12106-3-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcbd945-9a59-4742-df17-08dedcd16ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700016|376014|23010399003|18002099003|11063799006|22082099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	7naA17rpA4M/3/E5J8deer9lB1vzMmKAkr06fP0+ujZXWBa6YkO+7SfBWdVNpzS0VAUZcR/EDhKYgtTNKAVR/qbOFFWu2lbUBLHAUR9H2F6Ww4f27MkHnxgbRXMdeh627sgaqz92HEstKp4JqKRbYNsMY0eh+dYw2oC1lkPpjftg3NhNrR+eHOghHe0tDVVXoUEAraYmtsW/rhMnU9OPGzySfVVDQhObu3PjusF83ggECQ/THgjB8iWCoxjW+y0UJ5hU1E5V58dszKYN7cYnawBCx4ghWhaPH6uObhAJSCfFXYk5K3iL1ZPDixRhVEzoigITc98Wk47CxrDGL3neHt1u3jDnFN8syZhjlGpkWjPAJTfbgKtOjaS1R3lQRQNn+C3fPByaFD8Ams/zxJY9mmsNuNMuFJ8mY7Zi0qmRqUgIcTIsjbJGk40w0CvIVIZ1X+wvN5Q0iKsG72pG2UOOfZI5RFnOf3hUzzAr3rUjFynRpcF8nl+ufxcM5iMx8XOxGQC9bIpPMC7HBW4DiIK/WLcr2yKNgykC8Ci2e5akBBL9aBt+HievdAoyn10FYJjV5mNp5LZRtQBlRf4A5SfyZpV5jBQwoXvbF5Ok5KCYnnQT4QD4VNTZfOOTE8FX+dHMTFxNTgmPvvqe4ZwD7cWL6I7qWrnSsBaqmvOGRp8aSBzg9pWtB3z6H6nfn4REU+Wfw5+D5nAoAedKoNkqshRCafgE0P+C34KIZAOjn8ZtQOPMKczIqTSSYiuTawAC9uVN
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(11063799006)(22082099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I+pPVzPap3gtWVc5qsIpaoxRNxoZ7kkWn8AKBlEL4vyYE+p47aMT0eIg/Kxa3pGdqNaS/6NbzHtO8AQoxvDD7ChHmXmOn69UAvRbLrty8jGL2ymh+OG8MbYx/Ik6bjuQX4E9xLDwKLf7a2yIBNQXihRzP0r4PvpsbUPo2UuqNerPK3R42v32WsawP5i8ygWnbtauErZxSIs3YPN9uJxzH9WKJZL1QIFY/35qkmm/nAhf4x62sqzeURWf9bMaf9R2m0R0xLEieZNXIuam3vEZQS/0f65gnzo1Ou/iOR4v59+SAOR1sU0tzoV4G8+uNBBSsqWgTgbp3/EtdEeb59ns+LDmxFGOyOw77cJ87hSquI1lP4L5Y/0bRak1H11mb/Km9zuq1TL0xZ2kPC6GXNnqFNW5W8EjqyDREdzaCI5Qmaw3FgYPkP+dIN58Uptq0k3i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:15:21.7029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcbd945-9a59-4742-df17-08dedcd16ffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

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
 drivers/iommu/amd/iommu.c           | 22 ++++++++++++++++++----
 include/linux/amd-iommu.h           |  1 +
 6 files changed, 31 insertions(+), 5 deletions(-)

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
index 76f0e469490e..b226d3941cb9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3969,9 +3969,19 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid, int flags)
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
-		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = !!(flags &
-							AMD_IOMMU_FLAG_POSTED_INTR);
+		bool posted_intr = !!(flags & AMD_IOMMU_FLAG_POSTED_INTR);
+
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
 
@@ -4034,7 +4044,11 @@ int amd_iommu_activate_guest_mode(void *data, int apicid, int flags)
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

