Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DA3EFFBD
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471604; cv=fail; b=fNDQz8KKvq4ikFpJ5o8y/zslAltHPVM1d8bWKU8/zLRBSzI+pv0Euzyb/l+LVDdU0fYl21AfSIenEztIRwM5E133yBKaMu82iIUTL1ZsSGhytyVgW8pfwSfaQcAlCfPvV1TxWyQKdtEvnJC8hPfMt/vqfd5iDjba1GUXFfaYvFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471604; c=relaxed/simple;
	bh=ePyzueXX27IVtVIRg6RHAXxNO5YpoaXWIMfcfLMeEf8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEHblp8xT/XdP0iF09htxLejcPwa++AGxhAZ6t6BalgbfPk1FID5dSHZm+30sMLfJGs0/vwZAyeCNPV6mzY+FPE16pqUE++oCaJQ0WPlOJHsrsf8lW8szyT7uBpa8Tl60UFgCiRwV2McEK+zjJyz9FySFa9w0vXVPpQaZXYW1hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ax+dyFTa; arc=fail smtp.client-ip=52.101.57.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ax+dyFTa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNnjX7ZrtWtQhzZu/XfpJuzbK7+sJ/5W9y8GxpOmsDFjwvaggAVmIX6HhDRkrjnzBsaPhmMPKZIwvf/yc61CBxse45sMtrJbv8b1yasNaaQ/ET37fiYGxQVt2mhBG4uTbFH6z6UhRrobA853H/SiDXIy19PMsjEP6SbedkSRJkEEcEcAp5m8rzC3j7i3uAV+oDwLYGQOvGhqIZMqbdE1LPEbU/jDeiCmakHn9DmlLBJPNLCDEM09S4PDryd3w65OWz/nCfV+9gWMUbqEEvNLbfOzaIP5I1HKJeLx/CXhjPB1pSS57WtmYCHPGUNV/gV9h+OxpjkCG8qRfLQHq15lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDXKIfUnumHNKtZx89btPbMoAA0wH93YSkU/ritIDHc=;
 b=YZVqwFi5nuVUgTIXk+KXUIEehSqiPSYqHNNPN62jKvdq7HDxYk2b5Ng1h9nGsPWqjJfj9T0fnuACHp7a2FNmcOZ8Nxk9BRXDnpVN2djxHRE1ghV/oERzjuHPnxMh4boSJM7kf7IdZNhfLSkRwHhG8FsWhe/tDwUvUG18UHmE8D/BdjfBbpkBw1xEXK8XVd/kTAXI31nFBsaRTLsvR93UKK7XtmQSFhEP3cWwXP9dq0B5v1kAXNHz+VaTaA1FqLNRzvUY3nocoYt4ZkWv6vtF3cmj8iGkiAZdIq7OjepYX7APnoaGfj9Fafa+iuF40QqRXzf6o2/PNO8WkfmFsWFrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDXKIfUnumHNKtZx89btPbMoAA0wH93YSkU/ritIDHc=;
 b=ax+dyFTay0TxC52lh+RGNDno4S5itCbEuoc4lp14rZz+Aq2mEyrHLFk+Ji2FJ+8pbSSa0mGw6EylJcr/Cz5L2DmK/lxoBTppxawdJhkVP3/wDMtK5XU0NIqQg+dWqlm2yJ4DEMpEwWqn371jvmXZLqV8Z4qYAltLs65Cx9qYoVE=
Received: from CH0PR03CA0241.namprd03.prod.outlook.com (2603:10b6:610:e5::6)
 by BN7PPF9507C739C.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 10:59:57 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::8e) by CH0PR03CA0241.outlook.office365.com
 (2603:10b6:610:e5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Fri,
 26 Jun 2026 10:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 10:59:56 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 05:59:52 -0500
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
Subject: [RFC PATCH 1/5] iommu/amd: kvm/svm: Improve API between SVM and AMD IOMMU
Date: Fri, 26 Jun 2026 16:29:02 +0530
Message-ID: <20260626105906.14577-2-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: b1abd641-bb27-4637-e095-08ded3720f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|376014|1800799024|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	TmllPQA4I8FdloysAKKhEy12sqrbvjEKeGW4Se7FYeSswRGghJosia5PbPSXuwHS0D57AE0mqxfkVF/Hf8rbXfqq4R1lCk00LtCGCIFVk4KwouVrOWnwsinb5NIa3p+vCLqWLziFC9+fSeOGbo3dy9EiGRl3dfwiyc2zF2ZaJmznZHq+yO+4de918Y992dpc8izx0kVW+HQvOKlFzTlSPacABNKf9ddOfXrc8EnRR4HwziEe+SeghkbAAzH1gopZ32QRRIBK2w/fSqRaNKWvW/AIv3wyT43EbO37H4km4cjmGITYRqzOZzFDr4b5uxunjVUmkFRtLnyGZ2xu7EOXOkbZIPQf+JdUmiUaAmfjjJ1glaIhLtOiQlo4Ta/bsBJf2Xq1O24/WbMZKuGgn7gAcfRrJHTm6/GHKHLMlVYLNgFLNZq95BcWlAOtjDgUFYZR7WsHcOge9dsewdyte432gEh8Xi5vxcgjd3YKDpwq1MPE9+p94eKYqwYjEioUblF4CTQSkA8J3lHGEokI59vjHwCKRQou+qlkPiXvBpuJutZiNKsqVMhqjyqGNLcSHHuEL4sBpPlsN5EBvFa39VDZTmxKKDQrCt+0AOaGCb00EKTgZ9VfYjM9dcpKhoycyhmKKvxYs5fnnu6rW5F9mTCpXVsnYCyrcbXHI6///72jGMDYrzfOEFiVAwOY/HR1gcppPjpEIyI6/ZPVXbW368eWmYBvUrYtj67HYv06EZzJ/PRlIIFIrf4+qzuEfef5U7Sx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RwVuHxCxinbKiQaz4Ks0jsS3Wg0CwmeRG5Fp+bvDxtFy1Sb1ecMksclUpRPtBCCxRl/DbW0BjDLFKdMSZLQVN6wRY9/CTUY/BZePH5sxKW5NaLTKmRI4UK8k80jA8Vw53RPGjKWjwXGx9m0zHIgAqIkM6AphT06dslxqGTFSzn22ekclZ4meIm/x4beU8BWw8jwHEi6C7rAL+oL44i90N95k640rZvJgxOPZ/4OuHYVOhnhs9epIJiLNlWJWgd+XU7duVIT1gexcCwQ/K4g2p7m9SV2XfKkwPNU7m/LzhwIdY+HPTYRz9ojtUDyPIcmC8KMe3MF2A1TpVdfrhbfiuxRYYdRsnYS7mlJsya9pchpapw4cVAH7xsHLe9aYJ+CekNkrmtja4RRYhSK54HUkRCZbAoupa49XPjd3w7Rw/0S4W0Il1OsRiAfwmVVUZhZt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:59:56.9873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1abd641-bb27-4637-e095-08ded3720f58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C

The name "cpu" in the parameter is misleading as it represents the
physical apicid of the cpu. Hence rename it.

Introduce flags to determine the state of the vCPU (running or not) and
posted interrupts. This is useful as following patch overloads the
apicid (formerly cpu) field to determine GAPPI destination when vCPU is
not running and it can no longer be used to determine if vCPU is running
or not.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/include/asm/irq_remapping.h |  4 ++--
 arch/x86/kvm/svm/avic.c              | 22 ++++++++++++++--------
 drivers/iommu/amd/iommu.c            | 24 ++++++++++++------------
 include/linux/amd-iommu.h            | 14 ++++++++++----
 4 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 37b94f484ef3..40a2206a33c0 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -35,8 +35,8 @@ struct amd_iommu_pi_data {
 	u64 vapic_addr;		/* Physical address of the vCPU's vAPIC. */
 	u32 ga_tag;
 	u32 vector;		/* Guest vector of the interrupt */
-	int cpu;
-	bool ga_log_intr;
+	int apicid;
+	int flags;
 	bool is_guest_mode;
 	void *ir_data;
 };
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index cdd5a6dc646f..7862b13c5409 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -932,6 +932,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		struct vcpu_svm *svm = to_svm(vcpu);
 		u64 entry;
 		int ret;
+		int posted_intr;
 
 		/*
 		 * Prevent the vCPU from being scheduled out or migrated until
@@ -949,10 +950,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 */
 		entry = svm->avic_physical_id_entry;
 		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
-			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+			pi_data.flags = AMD_IOMMU_FLAG_VCPU_RUNNING;
 		} else {
-			pi_data.cpu = -1;
-			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
+			posted_intr = !!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+			pi_data.flags = posted_intr << AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -1004,10 +1006,14 @@ enum avic_vcpu_action {
 	AVIC_START_BLOCKING	= BIT(1),
 };
 
-static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
+static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
-	bool ga_log_intr = (action & AVIC_START_BLOCKING);
+	int posted_intr = !!(action & AVIC_START_BLOCKING) <<
+			  AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
+	int is_vcpu_running = (apicid >= 0) <<
+			      AMD_IOMMU_FLAG_VCPU_RUNNING_SHIFT;
+	int flags = posted_intr | is_vcpu_running;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
@@ -1024,9 +1030,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
 		void *data = irqfd->irq_bypass_data;
 
 		if (!(action & AVIC_TOGGLE_ON_OFF))
-			WARN_ON_ONCE(amd_iommu_update_ga(data, cpu, ga_log_intr));
-		else if (cpu >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, cpu, ga_log_intr));
+			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, flags));
+		else if (is_vcpu_running)
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, flags));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 57dc8fabc7d9..76f0e469490e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3959,19 +3959,19 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 	.deactivate = irq_remapping_deactivate,
 };
 
-static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
-				  bool ga_log_intr)
+static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid, int flags)
 {
-	if (cpu >= 0) {
+	if (flags & AMD_IOMMU_FLAG_VCPU_RUNNING) {
 		entry->lo.fields_vapic.destination =
-					APICID_TO_IRTE_DEST_LO(cpu);
+					APICID_TO_IRTE_DEST_LO(apicid);
 		entry->hi.fields.destination =
-					APICID_TO_IRTE_DEST_HI(cpu);
+					APICID_TO_IRTE_DEST_HI(apicid);
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
 		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = ga_log_intr;
+		entry->lo.fields_vapic.ga_log_intr = !!(flags &
+							AMD_IOMMU_FLAG_POSTED_INTR);
 	}
 }
 
@@ -3992,7 +3992,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
+int amd_iommu_update_ga(void *data, int apicid, int flags)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4006,14 +4006,14 @@ int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
 	if (!ir_data->iommu)
 		return -ENODEV;
 
-	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, flags);
 
 	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 				ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
+int amd_iommu_activate_guest_mode(void *data, int apicid, int flags)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4036,7 +4036,7 @@ int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, flags);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4107,8 +4107,8 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		if (pi_data->is_guest_mode)
-			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu,
-							    pi_data->ga_log_intr);
+			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->apicid,
+							    pi_data->flags);
 		else
 			ret = amd_iommu_deactivate_guest_mode(ir_data);
 	} else {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index edcee9f5335a..3dd9074e5967 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,8 +30,8 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr);
-extern int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr);
+extern int amd_iommu_update_ga(void *data, int apicid, int flags);
+extern int amd_iommu_activate_guest_mode(void *data, int apicid, int flags);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -42,12 +42,12 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
+static inline int amd_iommu_update_ga(void *data, int apicid, int flags)
 {
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
+static inline int amd_iommu_activate_guest_mode(void *data, int apicid, int flags)
 {
 	return 0;
 }
@@ -76,4 +76,10 @@ static inline int amd_iommu_snp_disable(void) { return 0; }
 static inline bool amd_iommu_sev_tio_supported(void) { return false; }
 #endif
 
+#define AMD_IOMMU_FLAG_VCPU_RUNNING_SHIFT 0
+#define AMD_IOMMU_FLAG_VCPU_RUNNING  BIT(0)
+
+#define AMD_IOMMU_FLAG_POSTED_INTR_SHIFT 1
+#define AMD_IOMMU_FLAG_POSTED_INTR  BIT(1)
+
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
2.34.1

