Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A1383312;
	Fri, 21 Aug 2026 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291834; cv=fail; b=X2SCRZq34xEsNy8cEUEQMumVHebf65xUgIVBWbimr2R34v0+jTna2ee3P949rtSfEpVDpXeAc7XRCCUglkP02FPgsrKsgK3iP2gxraUoCaSwzzXNjNV7HEKFntPzIe3UfPxUnxOgeUU+VtdEpuxpUWTLmmiNQA1ZHjHRlDo3Wio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291834; c=relaxed/simple;
	bh=FRnao4t/0sYM9oahz8IQxv0aBc1MQDqyRrNcXu87XNs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a3ThpGDYCqJNM9fD6puMQx0+zQhFL/u2n4s00JWf+NHlg0QBAxHSRpMVBXrKQ40hj+hLnHDTZ+xvz2ULWMSJu7Dw+81vBhSnwFoUfTzmuQlvzIgR+w8FsYKeSoCOwSiMtFNCIGrgXwAlvmlBzVgPNfAse3AYX48zeSz60CD1MnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Phm41HW5; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Phm41HW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vp0t0MSl8p4StDn4T/gPJ+agdhs6YcWN3tkE6pdCSGijTHFItATZt0d3Dk3daAXMcp+4ukCIKwKmuvQeWUOKq748Eof8D54vXpHaUUPUfIT5i83EZHgwV3NmiJKCHZOFkkt62bJrUf1aCuiNeU9S1TExEOYFGuAkQB1Ov4079qnl0GLB1rU55R300j30IwR7O/7BjNN+CaSwQE69Tox7y7GYtTr68qc8sVZhpvXswkb8qycgT8VUcutov08MO/fCiFHWS2I3dhoY1aQtRlu83wF2ZIld3JE3nH8LQ96UmpKZpKcr2sJMCdn9p+ZiFFJ/u4W+G+cv1yRuHFLg0gCUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDPgRUgPAOza4DD2Kxxt9pj+531K1qqDfuUTWhACkT4=;
 b=fhyZb3Z8mmQDxhUy1SVgiD1ZHG7ZDw+YqQGUHne+hAky6o7jFvUbB7PvybsRgZV4NUxHkaIoUHvzCO374O8iJ2rICFCAIs5zBLQezzq8GsHqj46j5C0bkUIvmlt+CQ51ONPraM/ddpG4CpaEEcRfVHhvcM79+6YCLsrBzQqVXUPAYvTpNiD7IKI/0+SqWErf8VDhSYCwLdVnMEOWRhB4lsEp0jgmx1AhGhJIAwOAXCZnPWt8Q7IHd17JBG0AewJHDrYeUUHEStB+WefVEWvhMNwMLg7CI095c3DE3+hFfs5q/n+XAxT2qDxTt6oO9jgH3+LexXMYcjm/5XEG4c+XXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDPgRUgPAOza4DD2Kxxt9pj+531K1qqDfuUTWhACkT4=;
 b=Phm41HW5BSKNtlFgdWXAvVr6hEjZsSYt1hWYIf/lEkStAsMUimOc8zeFYK4IbNSW9/fTh09lTGr+tr1KmF+XsbbTUhnUfI+Z3HAGdWxZO4FycdiHzzdNDpUwsV+0MZ6JWjK6OPkpttxHABVV3oyGmMV9Tbe7JxxcgWZHFBmr3fs=
Received: from SN7PR04CA0025.namprd04.prod.outlook.com (2603:10b6:806:f2::30)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 05:57:00 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:f2:cafe::5f) by SN7PR04CA0025.outlook.office365.com
 (2603:10b6:806:f2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 05:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 05:56:59 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 00:56:50 -0500
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
Subject: [PATCH v4 0/7] Add support for AMD IOMMU GAPPI
Date: Fri, 21 Aug 2026 11:26:04 +0530
Message-ID: <20260821055611.27138-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: f9bff804-e0b6-4187-c685-08deff49041c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|7416014|1800799024|36860700016|13003099007|921020|6133799003|3023799007|56012099006|10067099003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	e/sH5Jtx+QvY29q4xIeEdK/y+Bmh/CG7oTujjnW/ZIfBKbboG1rtQsJEvqNcNSIkzm7I3QykMiUyTCIzPsCm+yXYMN8zF/btTOQlcpwbOw0NI7SHtg71npTRaq8F+fCC93pQNJ/Q9DHjJAazR4QkLUzYILtyQHDCpynd2V3M+BTszoxvirRtOGbcsTZ9r6m7n/vME1olg0mXT2fQY6fx29kwn25cZpeWdgSB3mZG3pbwmJ6fkP4QUC5WjVbXNIHm3kP765ZVAlwyN3LUfzRx29F/9Dmkad9/QRvGjyIT4bQ65wBnLGuNu8RIe04A+PeWqKfQTyhINvElu/j/OEbW9/Sc/dHr9gBo+xHtY5yl1OJ6c8a4S55Z51Pb96AKie3JtTi0nIvlteKTrNfUpUvLqhYlOCrn59ly9MTqo+Y2BbsrnqHgIz4dNLr4L4JXZG+Bw43G0K/m+IhRSfpdfMiA5ot3OG9JitB5MrBZYIQQwXZZJDulDZiLEbm1uW6d3GgQgrKb6E4V0FRZyk7li0x20J4IwWcwk9tgDVxYGtvjBt9frrDYrS82fUOABEh97ro1zmXbKF8tmNqOfRtp2SNsy2q6dBjJB4aW+gxpaIGK2jbIong+0A2a0cirFAPfBzeIT2ZmYOgUmtv5riAi6yNRLVW1+FmsHbtRKnmtaLSmdStyaTpmRN21u3VVF9v1WtJevtjUbwKSQV/+fVDVBbMlTglYzLNrO1RmRE8pY7T5oWKXChiYLfP+1KBW3PLmN8hM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(7416014)(1800799024)(36860700016)(13003099007)(921020)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	okJTwoPs+Nr6RmvE3cfUljaRMDy04DGHp39P0QVr642w9irUI4QGjuBfRvjQGM8kke01iXSEr9riVju41MwWOOXZd06CcRBgHtquAGgoaWUyZDxJqQvBH9wFO3NWg1wghtWUb2bH5fWYiEipyRAXpdPvs2cQns9EDvdBZi8x5z5/YSfS1uB/982s3cjVSjY+weMpyyXoHBWsYSI+fgP8NF0wj+ZAKZIaeFTNAaSkL7VHU1ruHje0V0HpC3CJFeYIDDVgWCumaN6/92JXqjWhxZ+m2RRb31Nn7UbygtStSJKCSUxSUe1nJpxHDYbVH5PXrUkacdmpsAv6TYNHyywX8AsREf5GXiRXaDDKIsjKdwX97RbK09EU6zjs1BR5coP8iyu5cr4kzbOIYY2ekb32epN3ZhFIdXTto5weRydRnQdifChdHzVnIIbbVey+D/9k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:56:59.9274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bff804-e0b6-4187-c685-08deff49041c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681

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


Changes since v3
================
https://lore.kernel.org/all/20260713105033.15405-1-sarunkod@amd.com/

Patch 3:
  - Make amd_iommu_activate_guest_mode() as wrapper around
    __amd_iommu_activate_guest_mode() to in order to hardcode is_running
    flag to "true" for external calls

Patch 5:
  - Newly introduced, moves wakeup list handling from VMX to the KVM layer

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
Base: 89516a1c6837156f43525ef49fdbd781145942f5

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
 arch/x86/include/asm/irq_remapping.h          |   5 +-
 arch/x86/include/asm/kvm-x86-ops.h            |   1 +
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/include/asm/svm.h                    |   9 +-
 arch/x86/kvm/svm/avic.c                       | 109 +++++++++++++----
 arch/x86/kvm/svm/svm.c                        |   3 +
 arch/x86/kvm/svm/svm.h                        |   5 +
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
 20 files changed, 323 insertions(+), 155 deletions(-)

-- 
2.34.1

