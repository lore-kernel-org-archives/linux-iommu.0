Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE54119F2;
	Fri, 21 Aug 2026 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291961; cv=fail; b=lbLYo25uEDbUCTg9uE3ExoN3P6VE1BWbMs+o8UBL+LwcwbZGcFafxJtA2kTkn5DSSYyVQRQNEXjp5Kv9efQ8UkoiFP1JAaebvbuMVukvJGx5OuWLbzK+/8BG85gPZSsFTrxljs/xdDt/L2lHCUbSMY0O/1CUXIH8T4EH7xOir20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291961; c=relaxed/simple;
	bh=fDqamZZFNzzXkWLbERgkBJ64v2JAxqcPqbnPlTvcNT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+0oDb8NBm2u6iXYYctqXMsZK7C+kuuJlqI8tcIjRxxE6bfO9/YqaVny6+DhfSWLd9ElRwBsPBUH5lMK2ayQBxSacX0kEsBoF+NErcf9cDLNGyT3LBTHwDFnbYKLOj5rKz3FyiEmlX0b4Ehx7fnSTmVkZMcAt1XLH+ZzT+N3he4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0vf/8Jfb; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0vf/8Jfb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3XoEnFN4ESZv7d49ISeMXwsLrcVsa+9N9eIHLkAIXcIvioW90vf2EJWDL0nsgKUpUc73Ac9eTs+YIr6SYwngObaKZMQZoQwNt0JuVC5P0WNo4sbxBe4R0Tbq2QShzJ2zj9tIcJ3w4o1d6t5VFtGeVOpOh+uB+OC06VXnUcr9+IAO73MwVMdmc6aR1Zt2QScJhpXB5RXQ6DF3aKujjIlYW+e1YeKCxnFb7rzdG5g/uOJm2ImU3wHnSJ7MmJ/lCsZ16+/HrJXEIqxzU3sr+RFr3xqhfm0gQx5zMScnwu5D76FQOpsEqTS+DMr1GQNPDywAVi4fdZDvvbuYt1sTTzwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5iVp6G6AHq3ph4pwxbdoKQeAxZDBetbN53BBHuZi1k=;
 b=IW9t/qJyyGr8NOfn22uHF+R4vJaeLjsNAmSvZ7fSBgFNL7Ca2MAALsL636+2tzZFyPQBdrZcnS/hnsKrTHdb2Nr4NvLRujoZS2XhtwdpnjHAv3WLptQMuy9a82aOdv5k5Yz65I2fypmnnC5OnmaTmkhyT7r4km9mWAbBup//WNjoJtgxVnSAF7nU9FNZzLtpmWLe9gxlKd15ySu2NzqfAqeepFIBbfq/niQUaJQaAmzsqHp2Hdwxf0/pwNDj8LkeIM3E2NBPOoq6PdjGq3efXC24shFgMdPku1Ka8mZMpt6y4mDXYBUdF6t4j/810gzw71GSvPz0LqeubzNCQT6AuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5iVp6G6AHq3ph4pwxbdoKQeAxZDBetbN53BBHuZi1k=;
 b=0vf/8JfbzR+kUXn1Dmu5uz/XyMTa0U/uwo11i8DYvIOxHjraU0PDTH3C3Ul3wjKbTv++fvB/5//zZhXQW+TziDpvaO/YxgCzqDekqOaXfqAvSXS7ag+eSJlabYX+olajEISFBsqM4vZjSpkQmbPt8H/cs4qh5RPt9uxVlRm4N+s=
Received: from CH0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:610:cd::28)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Fri, 21 Aug
 2026 05:59:13 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::6b) by CH0PR03CA0113.outlook.office365.com
 (2603:10b6:610:cd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 05:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 05:59:13 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 00:59:02 -0500
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
Subject: [PATCH v4 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt (GAPPI)
Date: Fri, 21 Aug 2026 11:26:10 +0530
Message-ID: <20260821055611.27138-7-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ce544e-948f-40d9-e8bd-08deff49536e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|921020|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	+Q2pdKjYw8ns3hL69na9CkfcQzAKlL15NTShrqDBxlKSOthSo/OrDKZ15c0DTqihEkf3r9JfaJoCGrn0WwkIYsGy3it/WRoC4c7j9oYIeMW2NLAWiBQFdnQ4bDncRftA9Hd42kXuSAH6b0W2qdmYADm8lSGHtnXxLHlebmXeFofy8mnJeutCDf0f/cN/TUFwW8OsGALG/AgrfeqyJtRocoyf4HcNcbfD/B8q7f059w/J4yQVQYv8cScF05Kps+KHoEb1y4bcwEj/hBvbIvxvS6aXu5BZ7zcJzhUfDeYz9OH1hIkKNOg1PMQb0ryp4P1SUNuJnKZOQUHiLNz4PuJagc6mEmRirZtTCSSs8l5BvuGzBI+Rs62c7W9whY1ftEogGfuKAUl3E3nosQYwmF8ZyRLRdu32FDbqxEoIzk0m9VTuk/+GtoYhcFZcKvI0UGo9YYCVNkXFlZRWNSfRaaX62BJcNhg0YPP087E4weMGKcWdCoNsTHxqsDDUx7EoX6lfn+t2UtPEXMrzbRvUr4DkOm0HFKyLTd2F68TYjbJEuREaXu6rYnKV6DxU5OQYSGa/21aiSUFP/6i1j1gl4QovYNQ3TpJYtmJV+euK1tNN4ZkXJNi04D9qzpohAwZPP4jfTQKELTzWkn85InOUtLChSWkQXsTTATLTe0tdrqOxX2SLyT5EJUX1KzCTnOMm1t991U3a/YhHIlqO076aOwLb4PM0hsAZgXmcZPFHKon9Kvm7B8bsn3Q2zihMzuFizPI0
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(921020)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FC6TBbdg3VoValx0H1Y1OnkKGkOnq9olJaonPJm3Vxv7Ici4viFnGvE+2Wt/kdd3oVl7eLl4IvsOFgd6IJ8Qj9otAYMmhMEteeR3R0y9nRIowpCedbGGRYbPSgdpwyzzSf9l4rUv1my0ri0QUSPAwqSUzFtf2ZBD5mVMjr4/LsYq8hLFkBKsyn65xrpGbzL9yoGxJfaUi4l4YaGNsVk9dVrfzLVUy+IH8Dfu8ANYmF+uXGSgHdlvBTNRqZvHYWiYk+yiG2nNjRJMoxjXx4EoYzaa43uegXPUpxxCjhvFMF3NoWeIBmYhH3Dk65/fe4i3rRND8BiHzuQHIfP6I2ew3HBSe5YhyL5yXD6+YijwjvCNFqvSiAu0ugZT6YwJ+9m6Sa+uOlXsALVUPWolKBb3TAc5bnXHDaWXRuHonFWAMu0c4rwi5cxvBBAfYbeoZkim
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:59:13.0067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ce544e-948f-40d9-e8bd-08deff49536e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B

With AVIC guest-mode interrupt remapping, device interrupts are posted into
the guest vAPIC backing page by the IOMMU. When the vCPU is not running
(IRTE[IsRun] = 0), KVM must still be notified to schedule it. The legacy
path uses the GA log.

GAPPI (Guest APIC Physical Processor Interrupt) is an alternative to the
GA log mechanism provided by the AMD IOMMU. With GAPPI enabled, the IOMMU
still updates the vAPIC backing page IRR, but the host wakeup notification
is delivered as a physical APIC interrupt to IRTE[Destination], using
IRTE[GATag][7:0] as the vector (POSTED_INTR_WAKEUP_VECTOR).

SVM follows the Intel posted-interrupt wakeup model. Each pCPU maintains
a list of blocked vCPUs that may be woken by a GAPPI delivery to that CPU.
When a vCPU blocks while waiting for an interrupt, SVM enqueues it on the
wakeup list of the pCPU on which it was previously running and passes that
same pCPU's physical APIC ID to the IOMMU to program IRTE[Destination].
The rationale is that the vCPU is likely to run again on the same pCPU,
which is common when vCPUs are pinned; targeting GAPPI notifications there
reduces unnecessary VMEXITs from GAPPI deliveries on other CPUs. SVM
registers the GAPPI handler via kvm_set_posted_intr_wakeup_handler(). On
delivery, it walks the local vCPU list and wakes vCPUs with a pending IRR.

All GAPPI logic is gated on amd_iommu_gappi. Without it, KVM and the IOMMU
falls back to the legacy GA log mechanism for vCPU wakeup.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/kvm/svm/avic.c | 72 ++++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.c  |  3 ++
 arch/x86/kvm/svm/svm.h  |  5 +++
 3 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index dd497530d365..18ac24ef40e1 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -874,6 +874,8 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	INIT_LIST_HEAD(&svm->ir_list);
 	raw_spin_lock_init(&svm->ir_list_lock);
 
+	svm->gappi_cpu = -1;
+
 	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
@@ -886,6 +888,20 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	return ret;
 }
 
+void avic_destroy_vcpu(struct vcpu_svm *svm)
+{
+	if (amd_iommu_gappi && svm->gappi_cpu != -1) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+
+		kvm_pi_disable_wakeup_handler(&svm->vcpu, svm->gappi_cpu);
+		svm->gappi_cpu = -1;
+
+		local_irq_restore(flags);
+	}
+}
+
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 {
 	avic_handle_dfr_update(vcpu);
@@ -923,8 +939,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * if AVIC is enabled/uninhibited in the future.
 		 */
 		struct amd_iommu_pi_data pi_data = {
-			.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
-					     vcpu->vcpu_idx),
 			.is_guest_mode = kvm_vcpu_apicv_active(vcpu),
 			.vapic_addr = avic_get_backing_page_address(to_svm(vcpu)),
 			.vector = vector,
@@ -947,6 +961,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * scheduled out, KVM will update the pCPU info when the vCPU
 		 * is awakened and/or scheduled in.  See also avic_vcpu_load().
 		 */
+		if (amd_iommu_gappi)
+			pi_data.ga_tag = POSTED_INTR_WAKEUP_VECTOR;
+		else
+			pi_data.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
+						    vcpu->vcpu_idx);
+
 		entry = svm->avic_physical_id_entry;
 		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
 			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
@@ -955,6 +975,19 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			pi_data.apicid = -1;
 			pi_data.wakeup_intr = entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
 			pi_data.is_running = false;
+
+			if (amd_iommu_gappi) {
+				if (svm->gappi_cpu != -1)
+					pi_data.apicid = kvm_cpu_get_apicid(svm->gappi_cpu);
+				else
+					/*
+					 * If user calls KVM_IRQFD before vCPU
+					 * run, use CPU 0. We don't need to add
+					 * vCPU to the wakeup list as it is
+					 * never been loaded.
+					 */
+					pi_data.apicid = kvm_cpu_get_apicid(0);
+			}
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -1007,7 +1040,7 @@ enum avic_vcpu_action {
 };
 
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
-					    enum avic_vcpu_action action)
+					    int cpu, enum avic_vcpu_action action)
 {
 	bool wakeup_intr = (action & AVIC_START_BLOCKING);
 	bool is_running = apicid >= 0;
@@ -1016,6 +1049,20 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 
 	lockdep_assert_held(&svm->ir_list_lock);
 
+	if (amd_iommu_gappi && is_running) {
+		if (svm->gappi_cpu != -1)
+			/*
+			 * Handle initial state when vCPU is loaded for the
+			 * first time without any IRQ affinity.
+			 */
+			kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
+
+		svm->gappi_cpu = cpu; /* Store cpu number as target for GAPPI */
+	} else if (amd_iommu_gappi) {
+		apicid = kvm_cpu_get_apicid(svm->gappi_cpu);
+		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
+	}
+
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
@@ -1083,7 +1130,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, cpu, action);
 
 	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -1126,7 +1173,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 	 */
 	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
+	avic_update_iommu_vcpu_affinity(vcpu, -1, -1, action);
 
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 
@@ -1174,7 +1221,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 
 		/*
 		 * The vCPU was preempted while blocking, ensure its IRTEs are
-		 * configured to generate GA Log Interrupts.
+		 * configured to request host wakeup notification.
 		 */
 		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR))))
 			return;
@@ -1299,6 +1346,13 @@ static bool __init avic_want_avic_enabled(void)
 	return true;
 }
 
+bool avic_vcpu_irq_pending(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	return kvm_lapic_find_highest_irr(&svm->vcpu) >= 0;
+}
+
 /*
  * Note:
  * - The module param avic enable both xAPIC and x2APIC mode.
@@ -1342,6 +1396,8 @@ bool __init avic_hardware_setup(void)
 
 void avic_hardware_unsetup(void)
 {
-	if (avic)
-		amd_iommu_register_ga_log_notifier(NULL);
+	if (!avic)
+		return;
+
+	amd_iommu_register_ga_log_notifier(NULL);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e02a38da5296..0883cbf24b6d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1356,6 +1356,8 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 
 	WARN_ON_ONCE(!list_empty(&svm->ir_list));
 
+	avic_destroy_vcpu(svm);
+
 	svm_leave_nested(vcpu);
 	svm_free_nested(svm);
 
@@ -5292,6 +5294,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_put = svm_vcpu_put,
 	.vcpu_blocking = avic_vcpu_blocking,
 	.vcpu_unblocking = avic_vcpu_unblocking,
+	.vcpu_irq_pending = avic_vcpu_irq_pending,
 
 	.update_exception_bitmap = svm_update_exception_bitmap,
 	.get_feature_msr = svm_get_feature_msr,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5137416be593..d74777f287c8 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -362,6 +362,9 @@ struct vcpu_svm {
 
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
+
+	/* GAPPI related fields */
+	int gappi_cpu;
 };
 
 struct svm_cpu_data {
@@ -909,8 +912,10 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb);
 int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu);
 int avic_unaccelerated_access_interception(struct kvm_vcpu *vcpu);
 int avic_init_vcpu(struct vcpu_svm *svm);
+void avic_destroy_vcpu(struct vcpu_svm *svm);
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void avic_vcpu_put(struct kvm_vcpu *vcpu);
+bool avic_vcpu_irq_pending(struct kvm_vcpu *vcpu);
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
 void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
-- 
2.34.1

