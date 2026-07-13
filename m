Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB53E7BB6
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939998; cv=fail; b=NwLHwB28YdZ6uSVIPd+qyLBeaIsJsenNB6fyER/Hu9BJAmXddPYi/m0jJEPfmIQFCiu+/VuzneNLM9JUrA9e6zcw854Ae+MpkkjMdvZlC4QCJHph48jd9G0GcF/7boxJALbr6svzAwWdS0eiEkaBrVfm9cwtzrL5l5FYMc1wLOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939998; c=relaxed/simple;
	bh=2RknE0V1t2Tck3AVBV20kOzj+kxVV+QxZ0z46xzRtqw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4clO6c5kg6T8OsF2oakhMgxwnFrtDsZtIIZmTWlNsCKjzYqNdGK+/4pp+IeFj+UxD8ewqjQ0YaB2hPOjCuPg6H21ee/9O2bgj8rate0dVywxxVzTjaYs/QC9BINdgGMiq2W6Od71+G34W4KAWbQgFI+tr8K4e7dRf2uQ4TmqAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HkpSoBLT; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HkpSoBLT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulvMaQn6MIwvEgBsTmDjnSIz+fs1OzuIBeBOKg/1kgNuhnQ03DVcUHxm8tzPcQ2psOohtrxLrYButLqlgBvpYImUlWqe7z9gY/MFwjMSMeRl79mwI2K/v/MJR8Th0gVzhyEL2cQ/mOZjyZTGFyWSeG1R1RgH6nZ+X0xQTv2KlJaG2nj/2VpbsHYqsjgY1BH9NYKQXn5cpZgxmJsNi3N0dn/02WFw8jX3oXJS2DgJ3Sn+6Bl4yMwWj6GH/7dCHVn/XR1Y+J/PTQeO2XRo26lcroDbRglo/P2sKmN5TisXgonZDfLxyDGwocqh8laq/OjZcQ1jXhxcYY5ii+DBCkvoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prVdIE7RYavQpOCnFT8FHpWoyQ8JUh5EULEg7d8CXeI=;
 b=xJwptNrqIfp0cVYRd4K84OBR4+FkI3iccW5DfERQOPfsVQTFbX4eHqKdNrzK7kmb5lMplw9kwrE8cPIveuHOlun1lIlJG4uWejxuaOW8eMQYnmajCv6z3/wlVZJwdly+i6I33yVJR/ES+pPDAKBb258NH1EQSyZCVNsMGQaliATRgGlULgEoI7edHvllQWTxS9+bL2m4bxG3r5CiJmYid1JcC1c9/kwysLlvV/kccqq+97Qc5bcqTPXoc6sxMY/vXAnj7M3oJm/V7wyTLDWxThR9ed09FFYqUTn4Rd/9I9rKVUGnyX9RkxDltRuX4MapSIHDLhJj5AaXXDv1gg2xuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prVdIE7RYavQpOCnFT8FHpWoyQ8JUh5EULEg7d8CXeI=;
 b=HkpSoBLTRm0AnvKDkh1sRux+pq1mJvQ+f4jPxOjifn6kA/Y/jlNFelMAxL2Cs9N6nfQTP67RbCaAdW5cOPWIewpVO8UTiwf7lKhNzAdXSfuVY2NPplteCKR6iJcjAUV7+NRNSkCUzkLi+qHx1gmSgxbA65XvYh61jdhjd5h2sCc=
Received: from CH0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:610:cd::22)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 13 Jul
 2026 10:53:09 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::e) by CH0PR03CA0107.outlook.office365.com
 (2603:10b6:610:cd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend
 Transport; Mon, 13 Jul 2026 10:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 10:53:08 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 05:53:00 -0500
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
Subject: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt (GAPPI)
Date: Mon, 13 Jul 2026 16:20:32 +0530
Message-ID: <20260713105033.15405-6-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: ced53cfa-0b8c-40db-fd09-08dee0cced1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|36860700016|1800799024|376014|921020|22082099003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	I7+7s7U2PUO6WQ54MRKECmZdo9CWc8weZm/YWB8fJdawfHonEQCXilIKpXKb2avW9P01wpRJDw4kDuUPYmSYattksjvaJPDT3kUCiBsH/YxQj/03opKPf396NceGmDeheA2f5f6QScZImB+ogBG2qtfBqve7STxIhNx1lLL4m1bs4kdNxCZB83SfEV6Q6I9pEaPxQUWxDR3VKl+GhAiUMZV3PWjANrNY2r2xiP63qsfhWXFZEUhzI+INe3b9XSA4UVcjdGuK166qZ+YHiV0xjrm8gaP3EODFtlvA9Jl3m9/Ie1LXItr2rtjxXduauBVw8MqqKWMuN9q4STzODX7ehswYwtp3e0df437pyOKYfrO+lRYZ1vtNI6+9OFmOWvvMX7SUCwiYv/Jp7WBBaFSmvvRrJiPfx+k2ZfoLw4zQ+LRqXPMKPHejeMM1wRLGRo1OBLz6ujuFPsN9otEB5lfgOGAMs6sUTVOfQxD9Iv8dq3FpxwXufp2asFir/EipWRvaEIMhaEPPKUpTELm7orHhvUW99uyCu3Xh6H49XaPut5hqBPEuK64gkSYqZltuz5kfjq62L6ITZ/Ca6Yqxg45ifjwWIgjZY2g+5wdWafYncpI6zbiijGkaNSLeR60LpbunUGPc1WaBOZf7cbkhGWKunt45OkaWEt8NuinjXswA+ZbReVycRlNl9g4/jLKrth1S1TgYmGwGXyfiW4yCef/7P7B1FXy/ZGHXpbpHspX1njEtgdfDj/oNC44il2JQS+C9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(36860700016)(1800799024)(376014)(921020)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TOtIE9TlFXcv1g7S1TbWOEHC1FXReaBsNsAXjWyziJaf5XxyiLnnpC2wccdxDBHMjo7r3XQcBPnzfn1HeRQEjA25y/jZSvhko+mg+r0bYy7/r6H8qV590BlMlBGM+6QCh9BrAXTs8eFxPar0lLBZA0sZo0zTYQiId8/z1O+zfO325AK8IiKhmIqjL/qzvCLItQOTIVqzEUY/4HnQTkdrkx3FN9YW6QsybvpD9gK85N9lwBKAxsnkoI/w4dLKW33t4BL11jPdJ1Wp/dRQl+iU2S2HQf/Be1vwmQxbbK83o7dllZb5MOcUgAcGTTdRNhJWRuFGW3UCQ0gpcFm3Fj50y3ru9J9yEZpZrAeg/D6e5HK8t8Hqa6tJs99r0LaZKTPcLZQ8QS+cz0r5t5ezMb0g7w98JfvgyCHEWDepAuOUbO6Y7x6a8w+cZIw314X0k3PR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:53:08.8751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ced53cfa-0b8c-40db-fd09-08dee0cced1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

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
 arch/x86/kvm/svm/avic.c | 135 +++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.c  |   2 +
 arch/x86/kvm/svm/svm.h  |   5 ++
 3 files changed, 128 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 3b2d92a58709..982a5988532f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -63,6 +63,9 @@
 	ga_tag;								\
 })
 
+static DEFINE_PER_CPU(struct list_head, gappi_vcpu_wakeup_list);
+static DEFINE_PER_CPU(raw_spinlock_t, gappi_vcpu_wakeup_list_lock);
+
 static_assert(__AVIC_GATAG(AVIC_VM_ID_MASK, AVIC_VCPU_IDX_MASK) == -1u);
 
 #define AVIC_AUTO_MODE -1
@@ -874,6 +877,9 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	INIT_LIST_HEAD(&svm->ir_list);
 	raw_spin_lock_init(&svm->ir_list_lock);
 
+	INIT_LIST_HEAD(&svm->gappi_vcpu_wakeup_list);
+	svm->gappi_cpu = -1;
+
 	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
@@ -886,6 +892,42 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	return ret;
 }
 
+static void avic_add_vcpu_to_gappi_wakeup_list(struct vcpu_svm *svm, int cpu)
+{
+	struct list_head *wakeup_list;
+	raw_spinlock_t *spinlock;
+
+	if (WARN_ON(unlikely(cpu < 0)))
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
+	if (WARN_ON(unlikely(cpu < 0)))
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
@@ -896,13 +938,18 @@ static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
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
+	if (amd_iommu_gappi && list_empty(&svm->ir_list))
+		avic_remove_vcpu_from_gappi_wakeup_list(svm, svm->gappi_cpu);
+	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
 
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
@@ -923,8 +970,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * if AVIC is enabled/uninhibited in the future.
 		 */
 		struct amd_iommu_pi_data pi_data = {
-			.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
-					     vcpu->vcpu_idx),
 			.is_guest_mode = kvm_vcpu_apicv_active(vcpu),
 			.vapic_addr = avic_get_backing_page_address(to_svm(vcpu)),
 			.vector = vector,
@@ -932,6 +977,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		struct vcpu_svm *svm = to_svm(vcpu);
 		u64 entry;
 		int ret;
+		bool is_vcpu_waiting = false;
 
 		/*
 		 * Prevent the vCPU from being scheduled out or migrated until
@@ -947,6 +993,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
@@ -955,11 +1007,19 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			pi_data.apicid = -1;
 			pi_data.wakeup_intr = entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
 			pi_data.is_running = false;
+
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
@@ -968,12 +1028,17 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
@@ -1007,7 +1072,7 @@ enum avic_vcpu_action {
 };
 
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
-					    enum avic_vcpu_action action)
+					    int cpu, enum avic_vcpu_action action)
 {
 	bool wakeup_intr = (action & AVIC_START_BLOCKING);
 	bool is_running = apicid >= 0;
@@ -1018,10 +1083,27 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
-	 * interrupt remapping table entry targeting this vcpu.
+	 * interrupt remapping table entries targeting this vcpu.
 	 */
-	if (list_empty(&svm->ir_list))
+	if (list_empty(&svm->ir_list)) {
+		if (amd_iommu_gappi && cpu >= 0)
+			svm->gappi_cpu = cpu;
 		return;
+	}
+
+	if (is_running && amd_iommu_gappi) {
+		if (svm->gappi_cpu != -1)
+			/*
+			 * Handle initial state when vCPU is loaded for the
+			 * first time without any IRQ affinity.
+			 */
+			avic_remove_vcpu_from_gappi_wakeup_list(svm, svm->gappi_cpu);
+
+		svm->gappi_cpu = cpu; /* Store cpu number as target for GAPPI */
+	} else if (amd_iommu_gappi) {
+		apicid = kvm_cpu_get_apicid(svm->gappi_cpu);
+		avic_add_vcpu_to_gappi_wakeup_list(svm, svm->gappi_cpu);
+	}
 
 	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
 		void *data = irqfd->irq_bypass_data;
@@ -1084,7 +1166,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, cpu, action);
 
 	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -1127,7 +1209,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 	 */
 	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
+	avic_update_iommu_vcpu_affinity(vcpu, -1, -1, action);
 
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 
@@ -1175,7 +1257,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 
 		/*
 		 * The vCPU was preempted while blocking, ensure its IRTEs are
-		 * configured to generate GA Log Interrupts.
+		 * configured to request host wakeup notification.
 		 */
 		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR))))
 			return;
@@ -1300,6 +1382,21 @@ static bool __init avic_want_avic_enabled(void)
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
@@ -1308,12 +1405,18 @@ static bool __init avic_want_avic_enabled(void)
  */
 bool __init avic_hardware_setup(void)
 {
+	int cpu;
 	avic = avic_want_avic_enabled();
 	if (!avic)
 		return false;
 
 	pr_info("AVIC enabled\n");
 
+	for_each_possible_cpu(cpu) {
+		INIT_LIST_HEAD(&per_cpu(gappi_vcpu_wakeup_list, cpu));
+		raw_spin_lock_init(&per_cpu(gappi_vcpu_wakeup_list_lock, cpu));
+	}
+
 	/* AVIC is a prerequisite for x2AVIC. */
 	x2avic_enabled = boot_cpu_has(X86_FEATURE_X2AVIC);
 	if (x2avic_enabled) {
@@ -1337,12 +1440,16 @@ bool __init avic_hardware_setup(void)
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

