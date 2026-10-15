Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1402C08BB;
	Thu, 15 Oct 2026 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046817; cv=fail; b=ANpW5Bvs/c1p782BdYL5ph7gqyJqoC57/Reg761F20tvTRlNAoXIkLLyzGwIbYiMdSxGsvDeoxBbDwjeIt6YX2zZYrmHN0Q6EWQU+fPqnhRtBDoJWd7OTUkH5uaWTQPOiKz3pM7zPlQnm/Wqhu0GniH1t3L5Osd/IJwSBdwbLcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046817; c=relaxed/simple;
	bh=Y3pWzG8Rtq8EMdGSFJm015Iiaj/+nosFSd0nqBgAX+g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LFL1x4dr2TKhkcG/blG3BQ5jYDYNrJrQSjGqgdHUYywfP0Ex0m4raFMGXPAFLWgWqVtPvlpGPWL4Qv7uWUa2WCkx3wr61stI3jgrzcvKKs+dVusAfzku7XMrNkOMxvSfc5dCvO6FYbT8Z5o1EjQecZ8IyBeTlL8iS4gfFQNAp5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XCIUrdT+; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XCIUrdT+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0V76ElV7+Ij/BOgXvDr+mpT6GgsH8ki5Seg4YFhu1aMDE/qcFmXOz/gKFEctI62CDfE27rkIGUWlqlDl/nWYd7GTdHG15qJ0bIZ6QiNa9rf1yOorAVVxX6FKVoL/96Uq3lwcM5TAM7Cv5PdE/HWdPofNipUMdNuK0e076j/6kbvnnwtqN4+YLNGb0/CnPCu/uQqRBfsnu/MbpxwKa4Qob60TB8UBUvvQRowyH/t2LiJ/8kyrwQJ21pec/mQeNqQMVsH15HfoYwcXEoqPVFlxvWRNwMWdDb12JZ7lM5LDFSu5MOGoPhGXRqA82Ui6l2poY4vEzdcUyE4VIDf9+mPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p74IQ91hEPcn4DB4+p2fcLBJ0juMDmBp/fNuxJAj7uM=;
 b=eJrSb/b2izfnCT21W+5joOkS+6nr4CUViasJ7iuGm5k2AS9zHF5pr5FFf73eq58dQrnQzZVNNyUCe52UgXMD9WvHPOllkR8idb70K3j1aAXI3z8GlW8+kmuzSmajdXsW6D23/Z1saJ9gRpQvO6i3tPZPFQyys39Gmz+VA58RCOWP+KXet2u3U5tDAkGdjxTnjo0OsNk+eBGszuRIskFaORXo3WESKHy2lsejDr6/ODJwXCnCqK9/t+ngyQ+uD8tNbljUczF7bWf5dSKyGQJ5IrD6kFJlSg3KP2KKpU0M5cU8llOXhMDqhMN11Ec1ByljZM4EFJAX7FALATk4xb0LUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p74IQ91hEPcn4DB4+p2fcLBJ0juMDmBp/fNuxJAj7uM=;
 b=XCIUrdT+6eDmzQfOoAlvF/TOBOdFDQrNAEXCcie59naELEEdOK92sZtf1+CldrMUNqEdNh50dgoXY7DPwd/jRfagwf42WZfZEgBOH9BJHsOpWXbqu0lqpxp39DpgqFQaHLZN27RQhX4fZxYRTpPVZZw/ExIB0MQDZeat1TfVnk4=
Received: from CH2PR20CA0001.namprd20.prod.outlook.com (2603:10b6:610:58::11)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:46:50 +0000
Received: from DS8PEPF000000E3.namprd05.prod.outlook.com
 (2603:10b6:610:58:cafe::5d) by CH2PR20CA0001.outlook.office365.com
 (2603:10b6:610:58::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 06:46:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E3.mail.protection.outlook.com (10.167.23.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:46:50 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:46:34 -0500
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
Subject: [PATCH v5 0/7] Add support for AMD IOMMU GAPPI
Date: Thu, 15 Oct 2026 12:15:08 +0530
Message-ID: <20261015064515.10700-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E3:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 361b6d0f-d30c-4e2c-5af6-08df2a881714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|921020|56012099006|11063799006|5023799004|261009223027099003|261009221227099003|10067099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	JKeamLIboS5sQke5Dg/FZ+KUzYZjPNsHf1Wa9wk3hqFcyGL1F16Uq9REx3hrTB69/2IEyxETzF5yODhGjX3FPX3+lbfG6iscw+ArCLHUl3wBVcbnPplR/PcLCkh9phfqKlN7s7bFZsvmbXSa1dnKdYPF+XoC910uceB54JK9WFVmoIQu2oBbRUS0UxSZimSoVluSDKmxv/iMm28HZ83T47cwA3J6tluMMRpmfLNcG6z9kB+YrUKsJledEGaJz4GiAM6Yfw82NuxO2L0oI7e2sTkSULC/V+7U+ZP2pJyPV7dnkuJDA1Yd/qlQa0TGlpv9Orsig+E+g7l9jAdsQ9b6Nj9VKIZS55OllPRLk2OqApKuohabQ6ULJJFIkg5J0Kd6bAyqtYeJCtETzmHUsE87wMbzCBmC6DNyOIJNVDSu6HdXlaIDzPSWS/cKocI0DpGq8/OxyGS6CxWPbESQWlGqH75H4N8s7UW7wBEBJOuKdULWNsv0iPaPIab3CyNqaeHHvuTcipnOdl3Uz006p00uneW64zcVMkdWqLl7h9WufxVVfUzyTsJu+oexJeZjJTYJqpWsKBRtqO3JeJAWNlP+ZRd+F+zwc56ekzSdIgh49QHdCYS6B85kegJAvItcMue7Ag+7k1wLLe1dHmvRo4YTSkLQ9n49xwe7UuVIaBvoL/mAOd1Gvuesg6vPc0Q8J7FcomuTTgsgHTRk9qtdDJCyIA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(5023799004)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Sxea9bgc72T7cILBUla1jzhUzTaUnBWaA/cJBs7u4pELdZcqt3S+QsV6uS1LrDQAyR44GVbDsPWIGmRrLJzHrD4n4umn2tYZU60voyvICqn4qaipXAa2NUxv3lTbeiGIuVbF1b3dCvv60R+gb6sXDzvZ8EH+YMqIawJFRYHhUeqPyxnhekIg6+h6KobWuDOt6xTHV9NIVqAn8uwmmq5X48qZK8PWtgcpusFvyvVKy4w9/eQPPKCtAwDHMGTXwYxlb5K7K0493KeF/bQXKLx1oPDp9H1wkZzjo2iqKjdyv9iH/w3ewrH87E5TaQ0V18k53R0YHM6nm5s/wTgMInhbjIEDFeC4hKAsoFtZt9cEnmYrAHhPsgigSqaqPCv8H3cwv9uj740FPmbcEOyepRQteU8ygw/DTSkcnqgG7fgOU0iWLnnqo7KIlLXCLe97pmIJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:46:50.0554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 361b6d0f-d30c-4e2c-5af6-08df2a881714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

Introduction
============
On newer generations of AMD processors, IOMMU AVIC/x2AVIC guest-mode interrupt
remapping can use Guest APIC Physical Processor Interrupt (GAPPI) as an
alternative host-notification path when device interrupts target a vCPU that
is not running (IRTE[IsRun] = 0).

With AVIC enabled, the IOMMU posts device interrupts into the guest virtual
APIC backing page. When the vCPU is not running, KVM must additionally be
notified so it can schedule the vCPU.

The legacy notification path is the GA log (GALOG): the IOMMU appends vCPU
tags to a shared GA log buffer and raises a single GA log interrupt.  KVM
registers a notifier and scans the buffer to decide which vCPUs to wake.
Under heavy interrupt load this adds latency and can overflow the buffer
because all wakeups funnel through one interrupt and one shared log.

Guest APIC Physical Processor Interrupt (GAPPI), defined in section 2.2.5.4
of the AMD I/O Virtualization Technology (IOMMU) Specification [1], is an
alternative.  With GAPPI enabled, the IOMMU still updates the guest vAPIC
backing page IRR, but may deliver a physical APIC interrupt directly to
IRTE[Destination], using IRTE[GATag][7:0] as the vector.  This distributes
host wakeup notifications across CPUs instead of centralizing them in a
log buffer.

This series programs guest-mode IRTEs accordingly: IRTE[Destination] carries
the target host physical APIC ID, IRTE[GATag] is set to
POSTED_INTR_WAKEUP_VECTOR, and IRTE[GAPPIDis] / IRTE[GALogIntr] are set
based on whether KVM requests host wakeup.  GAPPI is selected at boot via
the amd_iommu=gappi kernel parameter on capable hardware, otherwise the
existing GA log path is unchanged.


SVM/AMD IOMMU interface changes
===============================
The first four patches refactor the SVM/AMD IOMMU interface ahead of GAPPI.

The cpu field is renamed to apicid because it carries the host physical
APIC ID for IRTE[Destination], not a Linux CPU number.

The ga_log_intr boolean is renamed to wakeup_intr (and the synthetic
AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR shadow bit to
AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR). wakeup_intr describes KVM's intent
(request host wakeup while the vCPU is not running), not a specific hardware
mechanism.

A separate is_running boolean is added to IOMMU interface because GAPPI
requires a valid apicid in IRTE[Destination] even when the vCPU is not running. 
The prior encoding (apicid >= 0 means running, apicid == -1 means not running)
no longer works once apicid carries the GAPPI destination while IRTE[IsRun] is
clear.  The IOMMU driver keys IRTE[IsRun] and destination programming off this
explicit boolean instead of inferring running state from apicid.


KVM GAPPI wakeup scheme
=======================
SVM follows the Intel posted-interrupt wakeup model already used by VMX.
Each pCPU maintains a list of blocked vCPUs that may be woken by a GAPPI
delivery to that CPU.  When a vCPU blocks while waiting for a device
interrupt, SVM enqueues it on the wakeup list of the pCPU on which it was
previously running (gappi_cpu) and passes that pCPU's physical APIC ID to
the IOMMU to program IRTE[Destination].  The rationale is that the vCPU is
likely to run again on the same pCPU, which is common when vCPUs are pinned;
targeting GAPPI notifications there reduces unnecessary VMEXITs from GAPPI
deliveries on other CPUs.  When the vCPU is scheduled in again, it is
removed from the list and IRTE[Destination] is updated to the current pCPU.

List maintenance is moved from VMX layer to common KVM layer so that both VMX
and SVM layer can share the same list handling code. 

Note
====
kvm_pi_enable_wakeup_handler() and kvm_pi_disable_wakeup_handler() take the
target pCPU explicitly instead of using vcpu->cpu, because on SVM the two can
differ. avic_vcpu_load() returns early while the vCPU is blocking and leaves
the target wakeup CPU untouched, but the generic layer still refreshes
vcpu->cpu on every load. Using vcpu->cpu would then unlink the vCPU under the
wrong per-pCPU lock, so SVM tracks the pCPU it last programmed in
svm->gappi_cpu and passes that instead.

Changes since v4
================
Patch 6:
  - Initialize gappi_cpu to 0 instead of -1, the list_empty() check handles
    the initial case when vCPU is not on the wakeup list of CPU 0 [Vasant]

Changes since v3
================
https://lore.kernel.org/all/20260713105033.15405-1-sarunkod@amd.com/

Patch 3:
  - Make amd_iommu_activate_guest_mode() as wrapper around
    __amd_iommu_activate_guest_mode() to in order to hardcode is_running
    flag to "true" for external calls [Sean]

Patch 5:
  - Newly introduced, moves wakeup list handling from VMX to the KVM layer
    [Sean]

Patch 6:
  - Use common list handling functions introduced in patch 5.
  - Remove list addition during pi_update_irte by moving list handling
    functions before list_empty(&svm->ir_list) check.


Changes since v2
================
https://lore.kernel.org/linux-iommu/20260708091408.12106-1-sarunkod@amd.com/

Patch[1-6]
  - Expand commit messages to explain GAPPI, the interface changes, and the
    per-CPU wakeup list scheme [Sean].

Patch[1-3]
  - Split the monolithic SVM/IOMMU API refactor into four preparatory
    patches [Sean]
  - Rename posted_intr to wakeup_intr to reflect host wakeup intent, not
    guest interrupt posting [Sean]
  - Pass vCPU running status with a extra parameter (is_running) instead of
    flags.

Patch[4,5]
  - Move ga_tag=POSTED_INTR_WAKEUP_VECTOR setting from IOMMU to SVM layer.


Changes since V1:
================
https://lore.kernel.org/all/20260626105906.14577-1-sarunkod@amd.com/

Patch4
    - Disable interrupts while holding wakeup list lock inside [sashiko]
      avic_add_vcpu_to_gappi_wakeup_list and avic_remove_vcpu_from_gappi_wakeup_list
    - Unregister posted_intr_wakeup_handler during module unload [sashiko]

Patch5
    - Disable GAPPI feature during kexec and suspend path [sashiko]


------

[1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

------

Sairaj Kodilkar (7):
  iommu/amd: KVM: SVM: Rename cpu to apicid in IOMMU interface
  iommu/amd: KVM: SVM: Rename ga_log_intr to wakeup_intr in IOMMU
    interface
  iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU
    interface
  iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun]
    = 0
  KVM: VMX: Factor out wakeup list handling code to KVM
  KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor
    Interrupt (GAPPI)
  iommu/amd: Provide kernel command line option to enable GAPPI

 .../admin-guide/kernel-parameters.txt         |   3 +-
 Documentation/arch/x86/iommu.rst              |  22 ++++
 arch/x86/include/asm/irq_remapping.h          |   5 +-
 arch/x86/include/asm/kvm-x86-ops.h            |   1 +
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/include/asm/svm.h                    |   9 +-
 arch/x86/kvm/svm/avic.c                       |  90 ++++++++++----
 arch/x86/kvm/svm/svm.c                        |   1 +
 arch/x86/kvm/svm/svm.h                        |   4 +
 arch/x86/kvm/vmx/common.h                     |   3 -
 arch/x86/kvm/vmx/main.c                       |   6 +
 arch/x86/kvm/vmx/posted_intr.c                |  82 +------------
 arch/x86/kvm/vmx/tdx.c                        |   1 -
 arch/x86/kvm/vmx/vmx.c                        |  14 +--
 arch/x86/kvm/vmx/x86_ops.h                    |   1 +
 arch/x86/kvm/x86.c                            | 111 ++++++++++++++++++
 drivers/iommu/amd/amd_iommu_types.h           |   6 +-
 drivers/iommu/amd/init.c                      |  31 ++++-
 drivers/iommu/amd/iommu.c                     |  65 ++++++----
 include/linux/amd-iommu.h                     |  16 ++-
 include/linux/kvm_host.h                      |   6 +
 21 files changed, 323 insertions(+), 155 deletions(-)


base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
-- 
2.34.1

