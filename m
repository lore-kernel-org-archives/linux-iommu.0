Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09E408627
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502171; cv=fail; b=L4SWoh8lWPx3Dj4eYuQblA46yxFOw5Q9isv1uhIc3ox2FNlom1NkPH7hhuxUklIrNg9hEBHDbNKlnOeKZj+UhNuL0tXhjRzHbgcfriI45txHJ0kxIUwDU8fs0Gx7kvze6BB8+90Y+vTItsCX0TLsqB/wiisClJaLV8h5qPugw40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502171; c=relaxed/simple;
	bh=4kKhgtvgdKCs4IGryVXoooJXKC2eM6o3T2DoXhMiw5Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9W1Kxaur1XT4VUtxXgf4KFYh1KDnEDRJVWVfw1hUYB8kEvX3ieYAkfJi3KOx/44OzVWjbPD+YtXncz+QRCskpyUxMPIWnvql2eq67FyVzgqKTgWq06dz7D72dskXIfzAdZM0+oB6bEFz+2pcMWkydzxEdgsEHmBwszunbjhkx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PeALRoSq; arc=fail smtp.client-ip=52.101.53.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PeALRoSq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIKGqdxSoN5h+t7WCpejaj1NM+NaAnZd/+rsnU/bvGIjEVE/jv5Ju8r8ahHEgizCgfMrI8f59UrW19hJlbzwmgxk2vLJ7Qlncm3H88TARx1GpUzkyXiu0F97sXtxcizBqfWFLfs/Wm74coUYFhTWU+tDXquHq50fI9gItRu0ulVu6EanV+Elh+qf1QrS7hgxS0kawYKPK8BPYzb4NS7IF4O4SSmIodgiJr5isBDREMJ6qkxmUxbYCADPIF80H/ziSdatW38b3Ei4EqDwuYIovAMmN1FUS3uVHCCUo4EmpSGFbPeFr75Eo48pEnvWDg5QZ+sAt55ruM3x+kiPeqSMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoAHfCyDPDiipIDB7pomSRHJ4CCqRdnhOhOy3gDlYDM=;
 b=j3GMNLy6+qWRVXqgHyK7d+TFY36Rxf6VMNvi6kUR8ztyWqndmnHmnfysjuM6JQXZsy92wQAvYhe9Wofz8ij8F7dPAeLspjU6ZlgJ2N6zKQ1LQQTzT+rQWQepDFWv2/eqYl9/eV03xy6cS3He70DUanXANP1V5gCJJAqn3NOYn4B2jYQhPGqdQqkNK4V83odG/ZKhd7PRdvcb9fsNizssdiay58lVUTi9KoX7ncrjhyvVupT9hlo1DrQyirZWxj6T8mTcHHee/k8cGTnt/WNus4LbmmDInnDMJsEB+6ciS5Eb8ZWuissugCzWP8SBwyjhC5sdwU69774oZfVEMoBYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoAHfCyDPDiipIDB7pomSRHJ4CCqRdnhOhOy3gDlYDM=;
 b=PeALRoSqusGb3g5tjUWM92nr7gEmnzDT/2jwIlvDd8G9oN5X23ZENpLJBOdRFDj36xSxJByIqAR9YMUQ4eW+PtlZqhvejThHPorH4THhzFKdG+/Zw59lf7uRNilJNMXkqu5rUp4C2d0WdBMYw9nlIAGcjvwtszk4U9Ims2ECNqM=
Received: from SJ0PR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:332::15)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 09:16:03 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::1a) by SJ0PR05CA0070.outlook.office365.com
 (2603:10b6:a03:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Wed, 8
 Jul 2026 09:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 09:16:03 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 04:15:57 -0500
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
Subject: [RFC PATCH v2 4/5] kvm/svm: Update the per-CPU wakeup-list during vCPU load and unload
Date: Wed, 8 Jul 2026 14:44:07 +0530
Message-ID: <20260708091408.12106-5-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 5422431c-e483-4920-fef4-08dedcd188a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|22082099003|18002099003|56012099006|6133799003|11063799006|5023799004|921020;
X-Microsoft-Antispam-Message-Info:
	mw8o59MLLvBx+oXvrBsk7J+uMEBpiQUCJ8fHFIRNqmqB3ieOylqDbKTxFddBOlDEmTpkO7bZTvbn4c3/nGW2uhdE6IOBT1Ywejx515wLfeFfzih/BVDisdU4wujs14Gl3bEWYajZC3+rok5VO+w6CQf5SwUZKszq+p5Fnze5fWsqwlSJ1W33bx2ACGh3+wXOeCOnkt3DMDdCGN3nygAwapQRBqfUTQevAQlmE2+pzTNvK9erqHwYIyYmpOj66xZ/Z3GUs68E1yTfClVDhmmjWo44s0NxJ/NlnsJrnz7d1Ex145qJRIzu/WLFdYboHgWRly5pJ2Wx6TQd5X5RLu2bta+jEu23Bx7XQkce8oAX55xRNGNpIKUl6AA6Y8t7jxZ4LCAHO2q51RhjLA9O98//Mn/BGOrvmSDraxeOPMEvZeqW0WI88XfLbI2SHKvntgFnHAmNDpXUUr6O/ONFzyEN+bNF0anvVcZYG0U8V1FgQnwo2xcVEjkbtLS1VguFyok5DSbFR5OZp+ea9hdNWcd+rE4Tfhef4B+ztyfamYl+HROZ88AgSR99AZYfMcXmq+V34t4HNb69e2l5bVhZqQw/E+sk/PeKJkeGIKaxREs8TPP4oqKGDhpJtV0V4aUpH1Ty/PPjIa/2qX1fBmLyh7hmJZUEge4xXPgFLrNcaDCaa7isrI4nQfQiJDRD/eB6m6eZq5RziKwt/OgNu6vKlwqydkBdmsayAzpQc1mVhT3m0Z5HUQL3Hj9BF5XPHglMBuBV
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(5023799004)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gBbRiIZN5yNWVb0TFUYB+jHeN/O0XB619yLE5SZFu4l6AXRjSAa9y2e7iGRE5Vh2DINnRxUa7wYoT6LCq9TPayKaQQCYgd5mRYo5hrDHIE6zTUskp5kQxkTKwqbghg47iDR0cx4CbL6DWBROeiPhTkneP4zdR42xRAV5zexTolkmE5gnas5lnGI3QnsXhtPH3H9wRj9z/3s347lbVB8eF+/KiP2/tnUMX6Ew/HN/F2egkaW1ReI/i4huNhML7oeyfdg/CpdSknaCQ7q1hU5kzddDVn+DoSxAdx32KPRTbMTvlx9OVmsKTKUz9pbfr0fH/00SnRS0sMf4IFnTOUDIWYwFx2o/7v83lGIjaqtJzQPsAYulPdA26dZl/cw545ylaTALd6HQPDh4TRkRcNakq4gKr03fpfB4Jvth2qkuOqhIOFfMHblb+zDJQbdPMcG8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:16:03.0748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5422431c-e483-4920-fef4-08dedcd188a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207

When a vCPU is unloaded from a physical CPU enqueue it on that CPU's
GAPPI wakeup list. Remove the vCPU from the wakeup list when it is loaded
on to a CPU again.

Also enqueue from avic_pi_update_irte() when vCPU is not running and
ir_list is still empty.  This handles the condition where vCPU load skips
the per-CPU wakeup-list update when ir_list is empty.

The GAPPI wakeup handler walks this CPU's list and wakes vCPUs that still
have a pending IRR.  Install it with kvm_set_posted_intr_wakeup_handler()
so deliveries on POSTED_INTR_WAKEUP_VECTOR invoke it.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/kvm/svm/avic.c | 115 ++++++++++++++++++++++++++++++++++------
 arch/x86/kvm/svm/svm.c  |   2 +
 arch/x86/kvm/svm/svm.h  |   5 ++
 3 files changed, 107 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index e7a4c0e90e7a..8185841d9b81 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -877,6 +877,9 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	INIT_LIST_HEAD(&svm->ir_list);
 	raw_spin_lock_init(&svm->ir_list_lock);
 
+	INIT_LIST_HEAD(&svm->gappi_vcpu_wakeup_list);
+	svm->gappi_cpu = -1;
+
 	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
@@ -889,6 +892,42 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	return ret;
 }
 
+static void avic_add_vcpu_to_gappi_wakeup_list(struct vcpu_svm *svm, int cpu)
+{
+	struct list_head *wakeup_list;
+	raw_spinlock_t *spinlock;
+
+	if (WARN_ON(cpu < 0))
+		return;
+
+	wakeup_list = &per_cpu(gappi_vcpu_wakeup_list, cpu);
+	spinlock = &per_cpu(gappi_vcpu_wakeup_list_lock, cpu);
+	guard(raw_spinlock_irqsave)(spinlock);
+	if (list_empty(&svm->gappi_vcpu_wakeup_list))
+		list_add_tail(&svm->gappi_vcpu_wakeup_list, wakeup_list);
+}
+
+static void avic_remove_vcpu_from_gappi_wakeup_list(struct vcpu_svm *svm, int cpu)
+{
+	raw_spinlock_t *spinlock;
+
+	if (WARN_ON(cpu < 0))
+		return;
+
+	spinlock = &per_cpu(gappi_vcpu_wakeup_list_lock, cpu);
+	guard(raw_spinlock_irqsave)(spinlock);
+	if (!list_empty(&svm->gappi_vcpu_wakeup_list))
+		list_del_init(&svm->gappi_vcpu_wakeup_list);
+}
+
+void avic_destroy_vcpu(struct vcpu_svm *svm)
+{
+	if (svm->gappi_cpu != -1 && amd_iommu_gappi) {
+		avic_remove_vcpu_from_gappi_wakeup_list(svm, svm->gappi_cpu);
+		svm->gappi_cpu = -1;
+	}
+}
+
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 {
 	avic_handle_dfr_update(vcpu);
@@ -899,13 +938,18 @@ static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
 {
 	struct kvm_vcpu *vcpu = irqfd->irq_bypass_vcpu;
 	unsigned long flags;
+	struct vcpu_svm *svm;
 
 	if (!vcpu)
 		return;
 
-	raw_spin_lock_irqsave(&to_svm(vcpu)->ir_list_lock, flags);
+	svm = to_svm(vcpu);
+
+	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
 	list_del(&irqfd->vcpu_list);
-	raw_spin_unlock_irqrestore(&to_svm(vcpu)->ir_list_lock, flags);
+	if (list_empty(&svm->ir_list))
+		avic_remove_vcpu_from_gappi_wakeup_list(svm, svm->gappi_cpu);
+	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
 
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
@@ -936,6 +980,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		u64 entry;
 		int ret;
 		int posted_intr;
+		bool is_vcpu_waiting = false;
 
 		/*
 		 * Prevent the vCPU from being scheduled out or migrated until
@@ -958,16 +1003,18 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		} else {
 			posted_intr = !!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
 			pi_data.flags = posted_intr << AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
-			/* GAPPI is disabled at this point (amd_iommu_gappi is
-			 * enabled in the following patches) hence keep the
-			 * apicid as 0.
-			 */
-			pi_data.apicid = 0;
+			if (amd_iommu_gappi) {
+				pi_data.apicid = kvm_cpu_get_apicid(svm->gappi_cpu);
+				if (list_empty(&svm->ir_list)) {
+					avic_add_vcpu_to_gappi_wakeup_list(svm, svm->gappi_cpu);
+					is_vcpu_waiting = true;
+				}
+			}
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
 		if (ret)
-			return ret;
+			goto gappi_err_out;
 
 		/*
 		 * Revert to legacy mode if the IOMMU didn't provide metadata
@@ -976,12 +1023,17 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 */
 		if (WARN_ON_ONCE(!pi_data.ir_data)) {
 			irq_set_vcpu_affinity(host_irq, NULL);
-			return -EIO;
+			ret = -EIO;
+			goto gappi_err_out;
 		}
 
 		irqfd->irq_bypass_data = pi_data.ir_data;
 		list_add(&irqfd->vcpu_list, &svm->ir_list);
 		return 0;
+gappi_err_out:
+		if (is_vcpu_waiting)
+			avic_remove_vcpu_from_gappi_wakeup_list(svm, svm->gappi_cpu);
+		return ret;
 	}
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
@@ -1015,7 +1067,7 @@ enum avic_vcpu_action {
 };
 
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
-					    enum avic_vcpu_action action)
+					    int cpu, enum avic_vcpu_action action)
 {
 	int posted_intr = !!(action & AVIC_START_BLOCKING) <<
 			  AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
@@ -1031,8 +1083,22 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
 	 */
-	if (list_empty(&svm->ir_list))
+	if (list_empty(&svm->ir_list)) {
+		if (amd_iommu_gappi && cpu >= 0)
+			svm->gappi_cpu = cpu;
 		return;
+	}
+
+	if (is_vcpu_running && amd_iommu_gappi) {
+		/* IF condition handles the initial state */
+		if (svm->gappi_cpu != -1)
+			avic_remove_vcpu_from_gappi_wakeup_list(svm, svm->gappi_cpu);
+
+		svm->gappi_cpu = cpu; /* Store cpu no as target for GAPPI */
+	} else if (amd_iommu_gappi) {
+		apicid = kvm_cpu_get_apicid(svm->gappi_cpu);
+		avic_add_vcpu_to_gappi_wakeup_list(svm, svm->gappi_cpu);
+	}
 
 	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
 		void *data = irqfd->irq_bypass_data;
@@ -1094,7 +1160,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, cpu, action);
 
 	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -1137,7 +1203,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 	 */
 	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
+	avic_update_iommu_vcpu_affinity(vcpu, -1, -1, action);
 
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
 
@@ -1310,6 +1376,21 @@ static bool __init avic_want_avic_enabled(void)
 	return true;
 }
 
+static void avic_gappi_wakeup_handler(void)
+{
+	int cpu = smp_processor_id();
+	struct list_head *vcpu_wakeup_list = &per_cpu(gappi_vcpu_wakeup_list, cpu);
+	raw_spinlock_t *spinlock = &per_cpu(gappi_vcpu_wakeup_list_lock, cpu);
+	struct vcpu_svm *svm;
+
+	raw_spin_lock(spinlock);
+	list_for_each_entry(svm, vcpu_wakeup_list, gappi_vcpu_wakeup_list) {
+		if (kvm_lapic_find_highest_irr(&svm->vcpu) >= 0)
+			kvm_vcpu_wake_up(&svm->vcpu);
+	}
+	raw_spin_unlock(spinlock);
+}
+
 /*
  * Note:
  * - The module param avic enable both xAPIC and x2APIC mode.
@@ -1353,12 +1434,16 @@ bool __init avic_hardware_setup(void)
 		enable_ipiv = false;
 
 	amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
+	kvm_set_posted_intr_wakeup_handler(&avic_gappi_wakeup_handler);
 
 	return true;
 }
 
 void avic_hardware_unsetup(void)
 {
-	if (avic)
-		amd_iommu_register_ga_log_notifier(NULL);
+	if (!avic)
+		return;
+
+	amd_iommu_register_ga_log_notifier(NULL);
+	kvm_set_posted_intr_wakeup_handler(NULL);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e02a38da5296..b687133f8528 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1356,6 +1356,8 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 
 	WARN_ON_ONCE(!list_empty(&svm->ir_list));
 
+	avic_destroy_vcpu(svm);
+
 	svm_leave_nested(vcpu);
 	svm_free_nested(svm);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5137416be593..47d5bb5d7103 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -362,6 +362,10 @@ struct vcpu_svm {
 
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
+
+	/* GAPPI related fields */
+	struct list_head gappi_vcpu_wakeup_list;
+	int gappi_cpu;
 };
 
 struct svm_cpu_data {
@@ -909,6 +913,7 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb);
 int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu);
 int avic_unaccelerated_access_interception(struct kvm_vcpu *vcpu);
 int avic_init_vcpu(struct vcpu_svm *svm);
+void avic_destroy_vcpu(struct vcpu_svm *svm);
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void avic_vcpu_put(struct kvm_vcpu *vcpu);
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
-- 
2.34.1

