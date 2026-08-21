Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BF351C2A;
	Fri, 21 Aug 2026 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291939; cv=fail; b=o9ZHlaIdRW2Xwmh8vxTYW+yAErDrY3gHbgdqKWUdPwLJQwBifUWi+YAmZVW4UwI0WdlwUvin0xWOCN2E8XNcDYy+R8ieEPgbqvwCqzNYwumAhsnfh8dhlmhecF9apw4vrFriXhbBbBMvNvXH5INlaW3oZHjM8u2Pv/u6sN5Nutk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291939; c=relaxed/simple;
	bh=1Z+Ghr5FzZRPoxu2UMdG0op6KfMtDpnnUGWLpLJ3Alw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNg+lpG3nN9flCRU+ZfL6/FivA8ev0YA5VMCP9m3IzHtreKRva4zpyRPnWEXzl7mKZsR5QicxOenB+7SH2QeL3qY10JfjXYQ8DL1g1Ogug/PcDX1dpepTvy6uP54OKjy6nv56pSaG0REp1Jzxu1GIVGlpAUFs1rFjBqcbQgHRzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tyEB3yKv; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tyEB3yKv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz8z25trBvsSwEbPSX/nJySTCwvn5cAIWUPoXc2soNAwCSSJW7bE9Im94r6OE8uJ/EP5TqkKHKOK5h17ne9+IjC64+EEVx8F2oCBaN0EPZl/LYsDTqV5jNS68f3hAoZeFn4L/YB6bbZTqMTaz4FLmVLHGlHkugSDg9VmN1jbcofCsLoBvzzOhqjhCUatG5xryVGRSAKEePTwdwKzWuogyj9Vu4dKdqbCjDBhmPHcsMmUhgR/aNSkcAsOEbBEemIyWe5wtVZetuGdTbwJ7nw5K3PRZi90oar3hz9w48eGEBTQe6x2HdkE7TOmtYWzGekE8F3rQWGwLTqeUc4IUQ/frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVfoZVqNwAYubOBxLzlaGg2sWXoPZ5DXNFw45jtxZlQ=;
 b=rlsDu1mRVBLTZD+xDFE+0GS/IgxmXcI7R8XbI9WkfnzbZrToDBELjqqH4wow0bkIHYcLhNIDb5zqx35/QXoonHDqz8rfZSpYrtV8bU3wK8KMVvsggBUZ9zFqERyA35m6H8l9GbGpufx7nqCQTM3r6AIMGT0tUniuqZrjekVNUQIReKrSe2dT0WQnuvSsYHWs/Qxh7d6ET0lxpfnzQ5sPwVGKV6kYCLFe8wD0BV/VnAgCNcVpWp6fprGsae14chsztsH5StbQnZOerJIrZoBMA/7ku5K7mjChX4SEKK8tEVfO22fWi7xPNA+/wZMU+rcMCXSuy/7yAtz4yMNYosZ/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVfoZVqNwAYubOBxLzlaGg2sWXoPZ5DXNFw45jtxZlQ=;
 b=tyEB3yKvgVRqkHkqjZFx1MsFpfBnx4607uynWlTGVCBkdyyXe7I5JDKVx5xfnInWVWkk8nlhSQpTGxA49Hz5/Ga3v2mVFagVr8FNkfU+Y4SaE7HqiLztH97UfFzW8ZQh7+OevUXtlMbAXVXtZbDampOSIfTyaP2MbHVnD8QMTqM=
Received: from DS7PR03CA0177.namprd03.prod.outlook.com (2603:10b6:5:3b2::32)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 05:58:50 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::87) by DS7PR03CA0177.outlook.office365.com
 (2603:10b6:5:3b2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 05:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 21 Aug 2026 05:58:50 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 00:58:41 -0500
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
Subject: [PATCH v4 5/7] KVM: VMX: Factor out wakeup list handling code to KVM
Date: Fri, 21 Aug 2026 11:26:09 +0530
Message-ID: <20260821055611.27138-6-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: f64ed37d-fb7b-40c5-a5b9-08deff4945b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|7416014|56012099006|10067099003|3023799007|6133799003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	tpmRL3RFpBOnHRxT45+WZlq9WT3NFxDU5hwy1BSuaYsWf/8zTq2bewl9AG/L1Mep2XziRMAOeAV5JIWjvUVmAoyKk1NDK6P6fwad8A+YN5trmtzijQlRddvFT6wsFsxV8TrC3yrDmhVU2rH1z+qnTMTDPzKg9+CALti1ZngKMWlwkotbnMBYV9go35S3tu50j/sJUPwBMs8mEl37r9k4Nwx+XPvh7BuhpsRzbv7CoDLgBcLrxsUGDljWTqug055jnvnLkWoMr/xPsbJBL+UZ+geHBET4rXxaVeH3FrIukqFEGN8xqyNN9HRaKjWQ306OguKXKgXvFP1p9YTBaW5oI5fRwshtaSJirF5H2vWYkhPoCZjiSuskB48npXAyHDB0YxD49t5mZsqp3vg8XmHIsFvCXqC6XunduW2Oao8Rr52t0mF56maGAeDBEOq+s3H1hsdPNiKMt0Edl/eOi0IqPAlkzk/KB6LWuRzJ1JYSaNBuhbyYPLnHKdLxaz2MZk1cVUOUaQVvDgu50f6lGppwseG1aYCG066wT5D5AhxLvfgzePP4xelN5lDwiLU64InEd4fh8oj6pnTml9WC7P7axR7aIdNFZB36oDTU4EBRsnOBs5PNN7S/8+warF8NegM7eU6zo5i/+OXN2tizXrOGrVoOB9AuvosqJKHLvmIg+ZskuLrVF5Crw6bWHwJGv+SAdj5okVhv/cM9fZK4wmTelBr2WtvffUzdH+3rV6CxsAYsBLymDyNB3QR//bHydFDJ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(7416014)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KA439chuzeNP1yDJLuHOwcjcLU9VL5YF1cjONWm/Y6Pmvceiu0pOOcr7mgSebGwC4AMZIG3VMfNXnEN8wkfGugpgBj1TP++3qJUiV0iMP7ZapLz/IvgmudXb8zYD6FOE3jypou/pCIvgmWZmNSrixELNerXTrKbP5NkZRUasRGB7QJLURVBu/NxB4E5n3fit1cHmCyVqD8KpqIAzNVMHZ64Bv/lRU1bHk7eEsV7t+9zafsVE9yEuUD6k2eDGyHH5We4PWRDSYnjzIG98KJmgYKe1pIrYPm8VUPa92oSqLRFwytFjjWUbR1tsLEpIUW0UIL6FpGxraFtwfhPQYrJ1kOXCTFO1ZyZwQI3pIVq+nqFf0/Ha6l9IXXrm5qQBvNmjNb1xLI1sigZOi8yN7yv6fNaP2Q7kUfysBcRGlGAZx0ssiuoen5OCDF/C5+6WHoyx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:58:50.0000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f64ed37d-fb7b-40c5-a5b9-08deff4945b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802

VMX maintains a per-pCPU list of blocked vCPUs so that they can be woken
when a device interrupt arrives while the vCPU is not running. The vCPU
is queued on the list of the pCPU it last ran on and its notification
vector is switched to POSTED_INTR_WAKEUP_VECTOR, so the handler for that
vector walks the local list and wakes the vCPUs that have a notification
pending.

Guest APIC Physical Processor Interrupt (GAPPI) needs the same
infrastructure on AMD. When a device interrupt targets a non-running
vCPU (IRTE[IsRun] = 0), the IOMMU delivers a physical APIC interrupt to
IRTE[Destination] using IRTE[GATag][7:0] as the vector, which KVM
programs to POSTED_INTR_WAKEUP_VECTOR. SVM therefore requires the same
per-pCPU list of blocked vCPUs that VMX already has. Hence Move the
per-pCPU list, its lock, the wakeup handler and the per-CPU
initialization from VMX to common KVM x86 code.

Intel and AMD determine whether a queued vCPU has a notification pending
in different ways. Hence, introduce a new kvm_x86_ops callback
vcpu_irq_pending(), which the wakeup handler uses to decide whether a
vCPU needs to be woken.

No functional change is intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   1 +
 arch/x86/kvm/vmx/common.h          |   3 -
 arch/x86/kvm/vmx/main.c            |   6 ++
 arch/x86/kvm/vmx/posted_intr.c     |  82 +--------------------
 arch/x86/kvm/vmx/tdx.c             |   1 -
 arch/x86/kvm/vmx/vmx.c             |  14 ++--
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 | 111 +++++++++++++++++++++++++++++
 include/linux/kvm_host.h           |   6 ++
 10 files changed, 135 insertions(+), 91 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 3776cf5382a2..9adc88cc9724 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -30,6 +30,7 @@ KVM_X86_OP(vcpu_reset)
 KVM_X86_OP(prepare_switch_to_guest)
 KVM_X86_OP(vcpu_load)
 KVM_X86_OP(vcpu_put)
+KVM_X86_OP_OPTIONAL(vcpu_irq_pending)
 KVM_X86_OP(update_exception_bitmap)
 KVM_X86_OP(get_msr)
 KVM_X86_OP(set_msr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f14009f25a3b..1ac547b77696 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1787,6 +1787,7 @@ struct kvm_x86_ops {
 	void (*prepare_switch_to_guest)(struct kvm_vcpu *vcpu);
 	void (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
 	void (*vcpu_put)(struct kvm_vcpu *vcpu);
+	bool (*vcpu_irq_pending)(struct kvm_vcpu *vcpu);
 
 	/*
 	 * Mask of DEBUGCTL bits that are owned by the host, i.e. that need to
diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 412d0829d7a2..d6a654e05fcf 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -34,9 +34,6 @@ struct vcpu_vt {
 	/* Posted interrupt descriptor */
 	struct pi_desc pi_desc;
 
-	/* Used if this vCPU is waiting for PI notification wakeup. */
-	struct list_head pi_wakeup_list;
-
 	union vmx_exit_reason exit_reason;
 
 	unsigned long	exit_qualification;
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index dbebddf648be..8a037febb60e 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -108,6 +108,11 @@ static void vt_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	vmx_vcpu_load(vcpu, cpu);
 }
 
+static bool vt_vcpu_irq_pending(struct kvm_vcpu *vcpu)
+{
+	return vmx_vcpu_irq_pending(vcpu);
+}
+
 static void vt_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -896,6 +901,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.prepare_switch_to_guest = vt_op(prepare_switch_to_guest),
 	.vcpu_load = vt_op(vcpu_load),
 	.vcpu_put = vt_op(vcpu_put),
+	.vcpu_irq_pending = vt_op(vcpu_irq_pending),
 
 	.HOST_OWNED_DEBUGCTL = VMX_HOST_OWNED_DEBUGCTL_BITS,
 
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 4a6d9a17da23..1a22730bfafd 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -14,27 +14,6 @@
 #include "vmx.h"
 #include "tdx.h"
 
-/*
- * Maintain a per-CPU list of vCPUs that need to be awakened by wakeup_handler()
- * when a WAKEUP_VECTOR interrupted is posted.  vCPUs are added to the list when
- * the vCPU is scheduled out and is blocking (e.g. in HLT) with IRQs enabled.
- * The vCPUs posted interrupt descriptor is updated at the same time to set its
- * notification vector to WAKEUP_VECTOR, so that posted interrupt from devices
- * wake the target vCPUs.  vCPUs are removed from the list and the notification
- * vector is reset when the vCPU is scheduled in.
- */
-static DEFINE_PER_CPU(struct list_head, wakeup_vcpus_on_cpu);
-/*
- * Protect the per-CPU list with a per-CPU spinlock to handle task migration.
- * When a blocking vCPU is awakened _and_ migrated to a different pCPU, the
- * ->sched_in() path will need to take the vCPU off the list of the _previous_
- * CPU.  IRQs must be disabled when taking this lock, otherwise deadlock will
- * occur if a wakeup IRQ arrives and attempts to acquire the lock.
- */
-static DEFINE_PER_CPU(raw_spinlock_t, wakeup_vcpus_on_cpu_lock);
-
-#define PI_LOCK_SCHED_OUT SINGLE_DEPTH_NESTING
-
 static struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
 {
 	return &(to_vt(vcpu)->pi_desc);
@@ -57,7 +36,6 @@ static int pi_try_set_control(struct pi_desc *pi_desc, u64 *pold, u64 new)
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
-	struct vcpu_vt *vt = to_vt(vcpu);
 	struct pi_desc old, new;
 	unsigned long flags;
 	unsigned int dest;
@@ -90,20 +68,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 	 * current pCPU if the task was migrated.
 	 */
 	if (pi_desc->nv == POSTED_INTR_WAKEUP_VECTOR) {
-		raw_spinlock_t *spinlock = &per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu);
-
-		/*
-		 * In addition to taking the wakeup lock for the regular/IRQ
-		 * context, tell lockdep it is being taken for the "sched out"
-		 * context as well.  vCPU loads happens in task context, and
-		 * this is taking the lock of the *previous* CPU, i.e. can race
-		 * with both the scheduler and the wakeup handler.
-		 */
-		raw_spin_lock(spinlock);
-		spin_acquire(&spinlock->dep_map, PI_LOCK_SCHED_OUT, 0, _RET_IP_);
-		list_del(&vt->pi_wakeup_list);
-		spin_release(&spinlock->dep_map, _RET_IP_);
-		raw_spin_unlock(spinlock);
+		kvm_pi_disable_wakeup_handler(vcpu, vcpu->cpu);
 	}
 
 	dest = cpu_physical_id(cpu);
@@ -162,28 +127,9 @@ static bool vmx_can_use_vtd_pi(struct kvm *kvm)
 static void pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
-	struct vcpu_vt *vt = to_vt(vcpu);
 	struct pi_desc old, new;
 
-	lockdep_assert_irqs_disabled();
-
-	/*
-	 * Acquire the wakeup lock using the "sched out" context to workaround
-	 * a lockdep false positive.  When this is called, schedule() holds
-	 * various per-CPU scheduler locks.  When the wakeup handler runs, it
-	 * holds this CPU's wakeup lock while calling try_to_wake_up(), which
-	 * can eventually take the aforementioned scheduler locks, which causes
-	 * lockdep to assume there is deadlock.
-	 *
-	 * Deadlock can't actually occur because IRQs are disabled for the
-	 * entirety of the sched_out critical section, i.e. the wakeup handler
-	 * can't run while the scheduler locks are held.
-	 */
-	raw_spin_lock_nested(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu),
-			     PI_LOCK_SCHED_OUT);
-	list_add_tail(&vt->pi_wakeup_list,
-		      &per_cpu(wakeup_vcpus_on_cpu, vcpu->cpu));
-	raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
+	kvm_pi_enable_wakeup_handler(vcpu, vcpu->cpu);
 
 	WARN(pi_test_sn(pi_desc), "PI descriptor SN field set before blocking");
 
@@ -247,30 +193,6 @@ void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
 		pi_set_sn(pi_desc);
 }
 
-/*
- * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
- */
-void pi_wakeup_handler(void)
-{
-	int cpu = smp_processor_id();
-	struct list_head *wakeup_list = &per_cpu(wakeup_vcpus_on_cpu, cpu);
-	raw_spinlock_t *spinlock = &per_cpu(wakeup_vcpus_on_cpu_lock, cpu);
-	struct vcpu_vt *vt;
-
-	raw_spin_lock(spinlock);
-	list_for_each_entry(vt, wakeup_list, pi_wakeup_list) {
-
-		if (pi_test_on(&vt->pi_desc))
-			kvm_vcpu_wake_up(vt_to_vcpu(vt));
-	}
-	raw_spin_unlock(spinlock);
-}
-
-void __init pi_init_cpu(int cpu)
-{
-	INIT_LIST_HEAD(&per_cpu(wakeup_vcpus_on_cpu, cpu));
-	raw_spin_lock_init(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
-}
 
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 04ce321ebdf3..b8fc0419efba 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -687,7 +687,6 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 
 	fpstate_set_confidential(&vcpu->arch.guest_fpu);
 	vcpu->arch.apic->guest_apic_protected = true;
-	INIT_LIST_HEAD(&tdx->vt.pi_wakeup_list);
 
 	vcpu->arch.efer = EFER_SCE | EFER_LME | EFER_LMA | EFER_NX;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b9103de01428..9bf088877815 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1567,6 +1567,13 @@ void vmx_vcpu_put(struct kvm_vcpu *vcpu)
 	vmx_prepare_switch_to_host(to_vmx(vcpu));
 }
 
+bool vmx_vcpu_irq_pending(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vt *vt = to_vt(vcpu);
+
+	return pi_test_on(&vt->pi_desc);
+}
+
 static void vmx_switch_loaded_vmcs(struct kvm_vcpu *vcpu,
 				   struct loaded_vmcs *vmcs)
 {
@@ -7686,8 +7693,6 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	BUILD_BUG_ON(offsetof(struct vcpu_vmx, vcpu) != 0);
 	vmx = to_vmx(vcpu);
 
-	INIT_LIST_HEAD(&vmx->vt.pi_wakeup_list);
-
 	err = -ENOMEM;
 
 	vmx->vpid = allocate_vpid();
@@ -8475,8 +8480,6 @@ void vmx_migrate_timers(struct kvm_vcpu *vcpu)
 
 void vmx_hardware_unsetup(void)
 {
-	kvm_set_posted_intr_wakeup_handler(NULL);
-
 	if (nested)
 		nested_vmx_hardware_unsetup();
 }
@@ -8780,7 +8783,6 @@ __init int vmx_hardware_setup(void)
 			return r;
 	}
 
-	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
 
 	/*
 	 * On Intel CPUs that lack self-snoop feature, letting the guest control
@@ -8850,8 +8852,6 @@ int __init vmx_init(void)
 
 	for_each_possible_cpu(cpu) {
 		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
-
-		pi_init_cpu(cpu);
 	}
 
 	vmx_check_vmcs12_offsets();
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index d09abeac2b56..1c5cc50f9c60 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -26,6 +26,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu);
 void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_put(struct kvm_vcpu *vcpu);
+bool vmx_vcpu_irq_pending(struct kvm_vcpu *vcpu);
 int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath);
 void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu);
 int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0550359ed798..dc607a296527 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -482,6 +482,27 @@ static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
 			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
 static unsigned int num_msr_based_features;
 
+/*
+ * Maintain a per-CPU list of vCPUs that need to be awakened by wakeup_handler()
+ * when a WAKEUP_VECTOR interrupted is posted.  vCPUs are added to the list when
+ * the vCPU is scheduled out and is blocking (e.g. in HLT) with IRQs enabled.
+ * The vCPUs posted interrupt descriptor is updated at the same time to set its
+ * notification vector to WAKEUP_VECTOR, so that posted interrupt from devices
+ * wake the target vCPUs.  vCPUs are removed from the list and the notification
+ * vector is reset when the vCPU is scheduled in.
+ */
+static DEFINE_PER_CPU(struct list_head, wakeup_vcpus_on_cpu);
+/*
+ * Protect the per-CPU list with a per-CPU spinlock to handle task migration.
+ * When a blocking vCPU is awakened _and_ migrated to a different pCPU, the
+ * ->sched_in() path will need to take the vCPU off the list of the _previous_
+ * CPU.  IRQs must be disabled when taking this lock, otherwise deadlock will
+ * occur if a wakeup IRQ arrives and attempts to acquire the lock.
+ */
+static DEFINE_PER_CPU(raw_spinlock_t, wakeup_vcpus_on_cpu_lock);
+
+#define PI_LOCK_SCHED_OUT SINGLE_DEPTH_NESTING
+
 /*
  * All feature MSRs except uCode revID, which tracks the currently loaded uCode
  * patch, are immutable once the vCPU model is defined.
@@ -5318,6 +5339,79 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu->arch.last_host_tsc = rdtsc();
 }
 
+void kvm_pi_enable_wakeup_handler(struct kvm_vcpu *vcpu, int cpu)
+{
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Acquire the wakeup lock using the "sched out" context to workaround
+	 * a lockdep false positive.  When this is called, schedule() holds
+	 * various per-CPU scheduler locks.  When the wakeup handler runs, it
+	 * holds this CPU's wakeup lock while calling try_to_wake_up(), which
+	 * can eventually take the aforementioned scheduler locks, which causes
+	 * lockdep to assume there is deadlock.
+	 *
+	 * Deadlock can't actually occur because IRQs are disabled for the
+	 * entirety of the sched_out critical section, i.e. the wakeup handler
+	 * can't run while the scheduler locks are held.
+	 */
+	raw_spin_lock_nested(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu),
+			     PI_LOCK_SCHED_OUT);
+	if (list_empty(&vcpu->pi_wakeup_list))
+		list_add_tail(&vcpu->pi_wakeup_list,
+			      &per_cpu(wakeup_vcpus_on_cpu, cpu));
+	raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pi_enable_wakeup_handler);
+
+void kvm_pi_disable_wakeup_handler(struct kvm_vcpu *vcpu, int cpu)
+{
+	raw_spinlock_t *spinlock;
+
+	lockdep_assert_irqs_disabled();
+
+	spinlock = &per_cpu(wakeup_vcpus_on_cpu_lock, cpu);
+
+	/*
+	 * In addition to taking the wakeup lock for the regular/IRQ
+	 * context, tell lockdep it is being taken for the "sched out"
+	 * context as well.  vCPU loads happens in task context, and
+	 * this is taking the lock of the *previous* CPU, i.e. can race
+	 * with both the scheduler and the wakeup handler.
+	 */
+	raw_spin_lock(spinlock);
+	spin_acquire(&spinlock->dep_map, PI_LOCK_SCHED_OUT, 0, _RET_IP_);
+	if (!list_empty(&vcpu->pi_wakeup_list))
+		list_del_init(&vcpu->pi_wakeup_list);
+	spin_release(&spinlock->dep_map, _RET_IP_);
+	raw_spin_unlock(spinlock);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pi_disable_wakeup_handler);
+
+/*
+ * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
+ */
+static void kvm_pi_wakeup_handler(void)
+{
+	int cpu = smp_processor_id();
+	struct list_head *wakeup_list = &per_cpu(wakeup_vcpus_on_cpu, cpu);
+	raw_spinlock_t *spinlock = &per_cpu(wakeup_vcpus_on_cpu_lock, cpu);
+	struct kvm_vcpu *vcpu;
+
+	raw_spin_lock(spinlock);
+	list_for_each_entry(vcpu, wakeup_list, pi_wakeup_list) {
+		if (kvm_x86_call(vcpu_irq_pending)(vcpu))
+			kvm_vcpu_wake_up(vcpu);
+	}
+	raw_spin_unlock(spinlock);
+}
+
+static void __init kvm_pi_init_cpu(int cpu)
+{
+	INIT_LIST_HEAD(&per_cpu(wakeup_vcpus_on_cpu, cpu));
+	raw_spin_lock_init(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
+}
+
 static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
 				    struct kvm_lapic_state *s)
 {
@@ -10204,6 +10298,13 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	 */
 	kvm_timer_init();
 
+	/*
+	 * Do not check if enable_device_posted_irqs is true because VMX
+	 * requires wakeup handler for ipiv even if enable_device_posted_irqs
+	 * is false
+	 */
+	kvm_set_posted_intr_wakeup_handler(kvm_pi_wakeup_handler);
+
 	if (pi_inject_timer == -1)
 		pi_inject_timer = housekeeping_enabled(HK_TYPE_TIMER);
 #ifdef CONFIG_X86_64
@@ -10270,6 +10371,7 @@ void kvm_x86_vendor_exit(void)
 	irq_work_sync(&pvclock_irq_work);
 	cancel_work_sync(&pvclock_gtod_work);
 #endif
+	kvm_set_posted_intr_wakeup_handler(NULL);
 	kvm_x86_call(hardware_unsetup)();
 	kvm_destroy_user_return_msrs();
 	kvm_mmu_vendor_module_exit();
@@ -12840,6 +12942,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	struct page *page;
 	int r;
 
+	INIT_LIST_HEAD(&vcpu->pi_wakeup_list);
+
 	vcpu->arch.last_vmentry_cpu = -1;
 	vcpu->arch.regs_avail = ~0;
 	vcpu->arch.regs_dirty = ~0;
@@ -14563,10 +14667,17 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_rmp_fault);
 
 static int __init kvm_x86_init(void)
 {
+	int cpu;
+
 	kvm_init_xstate_sizes();
 
 	kvm_mmu_x86_module_init();
 	mitigate_smt_rsb &= boot_cpu_has_bug(X86_BUG_SMT_RSB) && cpu_smt_possible();
+
+	for_each_possible_cpu(cpu) {
+		kvm_pi_init_cpu(cpu);
+	}
+
 	return 0;
 }
 module_init(kvm_x86_init);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c14aee1fb06..e5105cbe5230 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -398,6 +398,9 @@ struct kvm_vcpu {
 	 */
 	struct kvm_memory_slot *last_used_slot;
 	u64 last_used_slot_gen;
+
+	/* Used if this vCPU is waiting for PI notification wakeup. */
+	struct list_head pi_wakeup_list;
 };
 
 /*
@@ -2609,4 +2612,7 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range);
 #endif
 
+void kvm_pi_enable_wakeup_handler(struct kvm_vcpu *vcpu, int cpu);
+void kvm_pi_disable_wakeup_handler(struct kvm_vcpu *vcpu, int cpu);
+
 #endif
-- 
2.34.1

