Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84A2C08BB;
	Thu, 15 Oct 2026 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046972; cv=fail; b=VJU5Dytq0vUHkiKM9t6tChRQh5bMM4tsxJwO/4ijgzTqOfVR1Kis+4CpxX2nNyDkVA6gD5i4Ca4sfe5Bvb/AeanLcHW3yFhrkwYslFknxV02Mq12UNkXPUVmAIHew2UCoZVZZdwLMgBZ/b2m05yAD/mGpixsrj5UwXAqGhp0GIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046972; c=relaxed/simple;
	bh=dgdcT2ebnTv/tUJSH199QYla3/xVx/sd+Y/J5JvKLzg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qq4da6ztUxKrCDoj/fFp9RW9RhcpCYKlj0jGZli5B2kRDXgSFaSv/LAw7eOfrdl4NX2eaJRqgOgEJu+vbqQ7Zt+QueZ8TVh9ZNOfdOa1Rb42HfaKtRsoBXUCaxriAal+XplWy2+Fh7elIcSpzihX7hiXw7iLK7fIngQiYwzzckk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CHsFVjiG; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CHsFVjiG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9V+Qt4e++4YwYc3yTCYl9xYUblccxL+wI7kaZ8t8x63GbHwsaLjf95/9yESyPCfiiENXEYo9AyR63iVRTNL4+NZC09hGfb7QvOsRk1EE51QhiUoQqoo9d8Xu5j0mNVPYBNVUSA6alqv5pRBn4X9pcej7bM4McOpmRvwtiulbU6cRE/p3rsyUPZLh4z9ilI1GSNTflAGZmSKbw0h1EqOrtfvOohVTU6A5Hh2dir0KxaJ3NvT7xFB7BBvYNzHg0ezkTLZ/Wzw+SOWMvDFdGMl7gMcW/rDPpsTsgWxL96UbJgoYCVu/+iJcF0bjQ3euimsl1VG4UMCNvbCBT3SfWpWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yi8TNG1HWg/GB0SZbGpnMXQ16kesDYsABgKaZLuZM/M=;
 b=ZmC+dRuHGuw6i0Blq0C7TiH7WI0fVWxaMzGMWYKvTU+BfNpF4UnqMkjxdfgtUJ3SwWu7JCfZK9YHaMTHuNuWpqOPS1z1e3wvIjv/W5nkW03dR3J5wFyR2Q2JTtOTVD1z6DHcscM+4RxQndP+v73pEY6RqdnaNxn6zLuFvjee4Nk8tD1Rtj9AkdRzY1hfNiM6pF/85WaNhTI8ctB5GdWN0sKh7XdVXDpUH3WjTDmiZiPKtace1qL5KbH9pOwkKhA921HCjQtM21SYbI9kkqApdMW88+/sdL2IUdT1qm5ImNhdbLzPATRwymctxgCG0rjVKPyuGZMDGN1raLlyyS14sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yi8TNG1HWg/GB0SZbGpnMXQ16kesDYsABgKaZLuZM/M=;
 b=CHsFVjiGSlAZi/SDL4FOfLOai+zUvj87URI99wg8D0TL8WsYUpqpkCtfbRxbPVIJ6uouT/pIKGV/Om6UBtsX8mkgL2Jrl5THP7sYwZmZdjQZQox+S3whhMNhCZZMRZDcECmeXUpub+KZgw1PHXR7YV5mK+bS1PmchJYrAEESal4=
Received: from DS7P220CA0116.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::13) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:49:22 +0000
Received: from DS8PEPF000000E2.namprd05.prod.outlook.com
 (2603:10b6:8:25f:cafe::54) by DS7P220CA0116.outlook.office365.com
 (2603:10b6:8:25f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 06:49:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E2.mail.protection.outlook.com (10.167.23.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:49:22 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:49:07 -0500
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
Subject: [PATCH v5 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt (GAPPI)
Date: Thu, 15 Oct 2026 12:15:14 +0530
Message-ID: <20261015064515.10700-7-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E2:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: aa79d1f2-5c5f-4d92-9abf-08df2a887203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|7416014|376014|22082099003|10067099003|18002099003|11063799006|261009223027099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	xlulMa17pGZXIRKEVi9uy+nAymCm3jLSmDEXu10BAQU+EEudorfd1XbUIrJObpCMj3i7FiKUQ2NPpK8lsdGSvXzYXBAjmvmjDR6o6eps0xLYp1eGLBL3DWuG/gS3Zr8PCtwjzpKo/c8jkXEsZypCo+IhJzGQPOOcenBvnu6t/RYih6VNXjgAoeyq6gIxyrrm2C3V2229+AlC/r5cbuUGMZ1mGkpkvFjWCIl81/Cj33dUKLSEAnl8Z1vqzNM73elfEFmwAH7Pj3GOaFy+mfxwGmUbhQ+5ziGBg/DlfOr48YkxQ99k5s2aJuffD1txinQp1oAuxdGQCUfcLtN/gNP5M2KboJGkblxMUELyu4X3ipoFWnXxiwtj7KZli/2vHe3M8ReJc5/0Wdk0NdNB0YigbBfITF+q8mMiCKK7LPqKTCZYnNXEmqzGzM9jOwB8QnkS7mq7rxBY0mGnv7B0PzJkbno/C6EkVBPyMS5ikURzqgRfaK59Iu1zO68fIbNf6S7E7S+3SBCD7GAh6HxijwzNgJQTo7Mob4R7juK0ULCnFudgX/m96AeeayeKlnKQ0VvS4zwBRcDt09vr1Wje9BjK+V01rRowIGLq0CYLF9eRoU73bGlMBw1nwabef0AEt56Krttrw8iuTdTGYB57erFrqSPAAACL1WFL+Gz2yeHCktYe2XhZbVLRrVfXoqu6oFgJP1ezbQGSOZp0u0+D4BN7Whtpi/+KXiAybxWnxozYzjc5olxA/e9Um4/mJ88paOyx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(7416014)(376014)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CmGg1V/VA+o6vQzA6Nr2wL1FdrgJwG5JSNFk0coDNCsCG9Zcfjdu7kKWfkwbPEkx2Gmg5GELAzZ+oiQiecCPRosJE8bTXlxA0bQLx8Q5wAEFD+NequgbOI2DaQ0FbNQm9jurMxslACODi0rODtF1OWq8mWu7J1WaQzXiXTju6x+jsJ78zPvhrw39TBHxAkZWlwlveAgWL7zKh5iN+ItPYaGJ3Cj/FEvCcXm+ej45n8XtBnumQGtzJap6ef4wx8xiDs+hl7YSF8coAbJdv+Y4S3rowybNABfCC8i00al3V4VOdzIdW5ozbdRJ6snnpiozzDCI5oT8rhz41fArySq13ZPOclzHD1fGXTk9/DEDE5sihdyJeYuR5qD2Dj6hFKZ+qCThQai69PnUL0JlXojyd5/IpUVYalX2Xb8ApVCMabfIbLCQVQzaIjB9J6FBOKl2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:49:22.5924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa79d1f2-5c5f-4d92-9abf-08df2a887203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729

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
 arch/x86/kvm/svm/avic.c | 53 ++++++++++++++++++++++++++++++++++-------
 arch/x86/kvm/svm/svm.c  |  1 +
 arch/x86/kvm/svm/svm.h  |  4 ++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 8b1fa5bded3d..054b89c3cb0f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -877,6 +877,8 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	INIT_LIST_HEAD(&svm->ir_list);
 	raw_spin_lock_init(&svm->ir_list_lock);
 
+	svm->gappi_cpu = 0;
+
 	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
@@ -895,6 +897,17 @@ void avic_vcpu_free(struct kvm_vcpu *vcpu)
 
 	if (kvm_svm->avic_physical_id_table && avic_is_addressable_vcpu(vcpu))
 		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], 0);
+
+	if (amd_iommu_gappi) {
+		struct vcpu_svm *svm = to_svm(vcpu);
+		unsigned long flags;
+
+		local_irq_save(flags);
+
+		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
+
+		local_irq_restore(flags);
+	}
 }
 
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
@@ -934,8 +947,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * if AVIC is enabled/uninhibited in the future.
 		 */
 		struct amd_iommu_pi_data pi_data = {
-			.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
-					     vcpu->vcpu_idx),
 			.is_guest_mode = kvm_vcpu_apicv_active(vcpu),
 			.vapic_addr = avic_get_backing_page_address(to_svm(vcpu)),
 			.vector = vector,
@@ -958,6 +969,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
@@ -966,6 +983,9 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			pi_data.apicid = -1;
 			pi_data.wakeup_intr = entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
 			pi_data.is_running = false;
+
+			if (amd_iommu_gappi)
+				pi_data.apicid = cpu_physical_id(svm->gappi_cpu);
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -1018,7 +1038,7 @@ enum avic_vcpu_action {
 };
 
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
-					    enum avic_vcpu_action action)
+					    int cpu, enum avic_vcpu_action action)
 {
 	bool wakeup_intr = (action & AVIC_START_BLOCKING);
 	bool is_running = apicid >= 0;
@@ -1027,6 +1047,14 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 
 	lockdep_assert_held(&svm->ir_list_lock);
 
+	if (amd_iommu_gappi && is_running) {
+		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
+		svm->gappi_cpu = cpu; /* Store cpu number as target for GAPPI */
+	} else if (amd_iommu_gappi) {
+		apicid = cpu_physical_id(svm->gappi_cpu);
+		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
+	}
+
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
@@ -1093,7 +1121,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, cpu, action);
 
 	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -1135,7 +1163,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 	 */
 	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
+	avic_update_iommu_vcpu_affinity(vcpu, -1, -1, action);
 
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 
@@ -1183,7 +1211,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 
 		/*
 		 * The vCPU was preempted while blocking, ensure its IRTEs are
-		 * configured to generate GA Log Interrupts.
+		 * configured to request host wakeup notification.
 		 */
 		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR))))
 			return;
@@ -1308,6 +1336,13 @@ static bool __init avic_want_avic_enabled(void)
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
@@ -1351,6 +1386,8 @@ bool __init avic_hardware_setup(void)
 
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
index c054803d4673..cd0d8e8c386e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5352,6 +5352,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_put = svm_vcpu_put,
 	.vcpu_blocking = avic_vcpu_blocking,
 	.vcpu_unblocking = avic_vcpu_unblocking,
+	.vcpu_irq_pending = avic_vcpu_irq_pending,
 
 	.update_exception_bitmap = svm_update_exception_bitmap,
 	.get_feature_msr = svm_get_feature_msr,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 29bde741874a..58d4e85e30fe 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -368,6 +368,9 @@ struct vcpu_svm {
 
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
+
+	/* GAPPI related fields */
+	int gappi_cpu;
 };
 
 struct svm_cpu_data {
@@ -958,6 +961,7 @@ int avic_init_vcpu(struct vcpu_svm *svm);
 void avic_vcpu_free(struct kvm_vcpu *vcpu);
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void avic_vcpu_put(struct kvm_vcpu *vcpu);
+bool avic_vcpu_irq_pending(struct kvm_vcpu *vcpu);
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
 void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
-- 
2.34.1

