Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D433812EB
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471663; cv=fail; b=bKW1jwtd8zQHlHQE5k/MiTv8XSS43jjzsm0r2q7VdTb+bDE9fVWpQ7L1/bII5SGNFxmxKhqfRTItDcOe0kHdOS1x9yUzKXZqLsKJBtHJc09Al3x7gqaqv2+AfF+1XKXOr0ryRCK5HKgGORRQkjB88U3JIJad8DtJ/qlovxKDQgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471663; c=relaxed/simple;
	bh=Ehqoo1kB6RTQ0WXi1ciq6sFVririGN3lUOw3W6tCJzg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaUt4U7oxdkpUYV/jlw9JMJ0exxm2mk0LnxYxr7yNzbeEwuMSVvp6hATjFveygaFv0iaUlmDUeBbSLuzVcQKwEFssgo7urngFNkBW2cT+8WS31NU/oAoP6/mhB19LbbLVr/PQpL9lR03MeJ4xl7ztwSQHLtFgb9wEfWVkrLG3B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JaQQpRts; arc=fail smtp.client-ip=52.101.57.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JaQQpRts"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fp5KsSkQ3eELOz2IZYab+jwuOSXePg+BdrfNZG2O0NLJxdEUjsOOkRMK8xfDLOj4OVEBvE/PetUvvLVItci1msr1JN8tF/cPPXu0C0K19FeD8kbQFcysWzqDdusYETjZN0ZrCY5HJWsx/6RPX7LAoPduC1/TA7HXJO6hZg/f1K7zVh+rprdE00XjSpZL+zSnmLtNcYlG/ioOtaS/lEOlQWf9oP2jrrq1eEjYAE+Nw3vRVL/t7iHtVMsaiiuUbDNCFpHLu9HcXZ9UAx7CgNY9aBxgEW+hLpXTxeMYLw32FVRGCpyzRMkgvBE7XJDPGoxrSHOLqEXsN4raRtIGpGyPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzPkkQlBmzIIBzLKtPwi2LmRn8cpoM20dY4ekakcKS4=;
 b=eFxAb1RjWeccrsnJcwVjqb+30ei8SfrFxYpQGhb+ESKKiqbNMpTZ6cMjYphZxFO34kyM7AXCHj52xNlVm+ALnBjp1+0xVs1ql5QznILumhVJYuJwCuYhxRt6/HSdw7Ioo/o3jdH/jJdp2nIDTE4oKyvKjHxdgjX5PvRaQumz9iF5Lms2IDewHzw+OmfEBsKU2UbKC3c3Ytyzn2FEzQ90ahUxgIpO4Ya5zPogXhJVa/26l1cukCIDebiAqfih+gjsBL58RGJyR0I3c7WT6V0Cv5QBgUy4z+Bp18y51LSbcVAoZzMOaOWxmHfg19QBm3IKLqAcHge2z/61FEpRk92ozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzPkkQlBmzIIBzLKtPwi2LmRn8cpoM20dY4ekakcKS4=;
 b=JaQQpRtse2FO/gWyzl1k8IK1rNGOefZo5Fo4JeJMn8y7m9DsjKO2ql3dG0bwEGuMqhvHr008nYaFqpToeQPqQXlU3Uf8Elf9XdAPyGF6xgljkmo0HgKEr1onsbZ++/TNZTQs20P/+v8+lq6Itx6qrSADz0AALFM06jpiegUrHG8=
Received: from CH0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:610:b3::34)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 11:00:57 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::39) by CH0PR03CA0059.outlook.office365.com
 (2603:10b6:610:b3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 11:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 11:00:56 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 06:00:51 -0500
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
Subject: [RFC PATCH 4/5] kvm/svm: Update the per-CPU wakeup-list during vCPU load and unload
Date: Fri, 26 Jun 2026 16:29:05 +0530
Message-ID: <20260626105906.14577-5-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b788957-c2df-4aae-cc3d-08ded372330f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|23010399003|56012099006|11063799006|5023799004|6133799003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2LXjZtJe1aub0XN2X2TBWQuyO9Uz8dDIZF56Caq+u30oACDrB1xBaT6kcUJNHtLFEod6Z9j6HmzrVuQj0e2SiKDaPU5yx1oQXXDalrBx0uW1mmET7sk518k+MwmLIXVt75HswMe4dWzI8dphVdzTySCQq9ZdxfvXG/Gf8lcLhrHAwCRmMhhgtTnUhesN6dVcF2JqPedWR0GBUIdZwGqEIwwK6xCYkeXZObZAl6GrmDS8hB233SHzfQKOcG195BHP4OXA3ni9RVJkaTla0ID8EUld+eJQ1t71kz99vK7CbCIF447vbb+bYtejROGsuKylwH/qg6GwCV8jVF6aOqL6Ry660EdOnFKWlMYl4NV6QhfcKcQTd4EPOYIM5jiN4i5BwDVix4DMgmDs6OFKzhhejKRYgkd4yqB4FCOuI1MZje4+10+b9VfhbWRERNdKDNfsjcb1zGsZlhBym5A5J84sPU+hv7dq/eQ3MCE+OfsaylwplrdS5W5tj1aB7NIChXiNF0Vo78rRe2zgNgmi1AS1mzkMWMGr5sozG/CPv7OpDhB1bDlnEXiAVJy+zfj4h5biqJOKpkiGpMEQg1ppp5jVor4kGnBgbqbmXs4E6EbNAOlyCUjeD8iBGIYQ23+IPCRCLXT0U992iNVVCvKU9SRtjnwg8B3/F6px5HkpHEWznOJ16+5dKE7FN7Y/jH9JXhga/aFlHxMP4P30w6kX/uN8zAi8Gb5MCJXm2+4yLMbB5dCw3d3fBHDmPO85FLteSWrC
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(5023799004)(6133799003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bPW/pnXUgTpS5Pv4nCJdd25DJZDbZpxbnFu/NJzd3ElXFvkbN/v5gZ7yj1/Ag5Pou7luTblNgC6PudaAePfYcKM5xQPIdX1KdKyDrIqqEMB+XTIQgSu0seA4lojWoTuF6sX3SAPpJ0By9xMqQzfb4jG8AshJx2zeDEHN/AnJUVU5nKUPZ51TiuaHMw06gAdMpmYKvt0INQwcStGVkAPXm+xQ/1Gk4hMVgsUkZctO3Oag+PO/bttmXc9mK4y1qTikd/OWYOtDCwArLk90DnMf3glR3LZxZT1PBrF5x9h95KEr0fFbx1rJQj6PQIcVmEpK10ykZZvTrZIu2tfAQXsdBSIBDLK8NOglM2U+J9Nuc7ozoNL4VRJT/OmkjVgm9wH7lAcJgwNaiQsPnB4PCCNP5QyoOCUy1CHtu5Pc/46bWAmfJ0nf9v7y5AW0L1EV9Whp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:00:56.9044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b788957-c2df-4aae-cc3d-08ded372330f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754

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
 arch/x86/kvm/svm/avic.c | 110 +++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.c  |   2 +
 arch/x86/kvm/svm/svm.h  |   5 ++
 3 files changed, 104 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index e7a4c0e90e7a..d238f65a8172 100644
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
 
@@ -889,6 +892,44 @@ int avic_init_vcpu(struct vcpu_svm *svm)
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
+	raw_spin_lock(spinlock);
+	if (list_empty(&svm->gappi_vcpu_wakeup_list))
+		list_add_tail(&svm->gappi_vcpu_wakeup_list, wakeup_list);
+	raw_spin_unlock(spinlock);
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
+	raw_spin_lock(spinlock);
+	if (!list_empty(&svm->gappi_vcpu_wakeup_list))
+		list_del_init(&svm->gappi_vcpu_wakeup_list);
+	raw_spin_unlock(spinlock);
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
@@ -899,13 +940,18 @@ static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
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
@@ -936,6 +982,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		u64 entry;
 		int ret;
 		int posted_intr;
+		bool is_vcpu_waiting = false;
 
 		/*
 		 * Prevent the vCPU from being scheduled out or migrated until
@@ -958,16 +1005,18 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
@@ -976,12 +1025,17 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
@@ -1015,7 +1069,7 @@ enum avic_vcpu_action {
 };
 
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
-					    enum avic_vcpu_action action)
+					    int cpu, enum avic_vcpu_action action)
 {
 	int posted_intr = !!(action & AVIC_START_BLOCKING) <<
 			  AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
@@ -1031,8 +1085,22 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
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
@@ -1094,7 +1162,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, cpu, action);
 
 	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -1137,7 +1205,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 	 */
 	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
+	avic_update_iommu_vcpu_affinity(vcpu, -1, -1, action);
 
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
 
@@ -1310,6 +1378,21 @@ static bool __init avic_want_avic_enabled(void)
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
@@ -1353,6 +1436,7 @@ bool __init avic_hardware_setup(void)
 		enable_ipiv = false;
 
 	amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
+	kvm_set_posted_intr_wakeup_handler(&avic_gappi_wakeup_handler);
 
 	return true;
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

