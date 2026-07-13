Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3713E6DDD
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939889; cv=fail; b=ChMfMEnrM1IgzvaPMZ7UJ8xybSl5zkeQG1SeM9fcxsBLRGjej7LVPCObIXkAbFYNjk47Yv2CxbW9ZKlIyNIAysEntlGT0AFj5yQe/eMPP6CzwgPj19Qrfx04Qa7N3XSyBRIaR72BNoHdJWY2EnAlOVcgv2I8FoRgLn54SsMClGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939889; c=relaxed/simple;
	bh=vLh8Go6T5rcdA2B8UdaIPn0fJkjzrLaSKINgZIWIa9E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cy4f5DxwYqNwZR1B6gPFa8tvjcAvo6anvgmLFe5jaoshMNkOiMLw9gCF7ZdQlX66zc2NUlnLCVcrEQT660B+Jenyix2BnlvblYld+otXKAai/2+gkWcekgI00Ja3lfKJYrlVp89xSkUK29BZx0tghyggqL3yNqYC/yYRLgHv9uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IQ0yly/4; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IQ0yly/4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJzXA9ne5IF/dkBNGe48ZW3XDCVt/KQ5uJ1lywc5tZ5oWtkA0f2gthHAYANNgHkndQ8aKruVY/PHRqfWKUUdPlP4mXEXq+ZaXEFN+tsbSSaYRJxpubmOsbxvY1M7jNrzULUUVL1thxEEVcWqxr2PVLVXnG1+m0iiBDHw1fPvUKe+P2JbNVYMIImf5FhhG6m7Nz+DWbSQOwiwc4ID0TOVWTm2OdIC8ro2pdYEYD4a9lVUQRcXFK8+p7tAVWq9BRAx8Di+S7gTURWJ7VYUv2dBFVl0v1VMyJjj9qSLJUS5A9UNjZXrblIQwFEG4zuH18lTO43XKbuPwX+Jfw6d3Icttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tN124K2AWwTxqllLX6/eu7IwKmpdZi26C9Q5X+NAJ0=;
 b=wIp+h7VxP8UrXND6Q+tcmOMhfrrwiQle7YHw7uXpLpuyE4PiQYdoio9YQknOhlj5DWOhAReHkAtyGR/fAClkzYemW3ch9nn4ktgD3f5JbHaK0AfPU6HYZRoFhMa+7pjBVPwp7Aex4xjhdyjj8mBe7hub9FfOd6mdb5QpnwLiQbUm3ryCvDSst+TP2nB+BRGDwIXkPbf8a1tksK6QEXgPblMWyrV9ic+U1CYaP0nNHHmtw71CUJgb3tfKg/0zcI/0cEv57WQHj5We/GflmqFEzmE+rjBtY5g7Sma5trKM/6SSstJmRx0D9GTgIyaE9baVE6LhXGGuPML8g+rF3ywtVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tN124K2AWwTxqllLX6/eu7IwKmpdZi26C9Q5X+NAJ0=;
 b=IQ0yly/4nVi5EmhICPym2bES7sf/4vWee+vyhxCmdWC1P3Ebt9GN5mHwQ9XS1ehGXx+ElHiGrDT4DLaP3w5+9ON6lvG4cUwf48T0r66sTb6IbYv4BuzBd2jzT0a9rmMtt0RaIIB2TOmZAOxcmw8wVHjNUfcNil6rvF6arsl+nok=
Received: from CH2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:610:53::22)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Mon, 13 Jul
 2026 10:51:13 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::67) by CH2PR17CA0012.outlook.office365.com
 (2603:10b6:610:53::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 10:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 10:51:12 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 05:51:04 -0500
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
Subject: [RFC PATCH v3 0/6] Add support for AMD IOMMU GAPPI
Date: Mon, 13 Jul 2026 16:20:27 +0530
Message-ID: <20260713105033.15405-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: faea52db-ac8f-4ce3-6759-08dee0cca7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|23010399003|1800799024|82310400026|921020|13003099007|5023799004|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RXvWDeM5M3o8sJI39cmkyQ3+zYzxs9fV6HAl/uxB8rFXDAPL6KJI7P0vtTnK6vmP1VcRIwThPaBIJDsu680/CC8AdptdEnQqlkJHQLva9j2OIeoJEPOM8m5giWXR891lwPnsX+geQXemun0UrvdYpbqhACPSUq1c4RELlSrUMBSFmcpoQxB0mbqVbMHYlktFEdd4THrpZcpBgcOIvlNAFEOfr/5jf87U30exXK055TJDWNs4eWUDiTWs9ZGH7NIS4kfS0YSzrVm9naF/GeJXIIKkYcRFGn+o1/vyUow6QF2lappGWuE5LMFd6mJgdy7K2OXSkxranfCvr/uT5bKlv+665HWuiiBGQLAjv1224326sDRu/JFuXbgpIivO4K67VX09ryLyqEWr2zRuVjBSYgWXAB02WlmsFQRkincc3GT+gLjT0AiA7X80/1LtHg7H3m8HCUtD9MzsJSf5EWAmzXBiAy5ZbiWiTLJJPGNaITacTrv1thqSzLQBpyGA7bi1vT9J4iw/nQ1yAaoILnL2DsmHq9VpHGrZvyCujfy5/TBEjb1ydEGCQaqoea8MwPqqXe4/upXIO/WWzEzP+Mp2IsUfuz+DkDeLK9Cjhx0Pg0DCGuRmdOU3/EV7vOssccvIlTrIOzrDtqXZPp3h/LIz8krm0AxCWJzsvXxYif6EIg4uUrGnuh/EnZwknCypng2D4uBx0ywu2huDdp3Txkbpc2Md601qe/dxvTsxdsYswoQjx/fS6Kl58rP9xYosG1aj
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(23010399003)(1800799024)(82310400026)(921020)(13003099007)(5023799004)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0ExwTKU35dokSp/NAc3XBnV1/9+4eEjlzcunmSIue5el9ta7e395NwsgLzOgGGJ97lKiiuT7JjjsYJ5QYp9RJFAhRW35LtuJpO3bOwkxw3osD2HBypA+JeZgFqdR4Syui9uJ/jzeoUYbuhh+O9voaPKLnYoSopaVHrLIRUZ6LNW2LnwMrqr4VIL0mbTH67KRExFMfCwZToqg5LfGNcK5IpF/0xJD5FYr3W/BEJ4bsurkHAnWOAVxJk9H/R3D+9WUwJtaSjd62rRMfqlE6o0uTlv0vQ+i89baMX2596QKlVHjpc1ZeajNtq/cCVA/EwI3G3aUM1tDFdkORF2B509jYNC9DfshSFuW8xhUAyWnVHlzZJAWg9SfyWUY6dkWSaJ6mjHeke8lEEWw4bFEtHrK+VK5HAdBega1Q11klo5kVHBMCV4mwZE2N0ljaZTQxIDy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:51:12.8686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faea52db-ac8f-4ce3-6759-08dee0cca7f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159

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

SVM registers avic_gappi_wakeup_handler() via
kvm_set_posted_intr_wakeup_handler().  On POSTED_INTR_WAKEUP_VECTOR delivery,
the handler walks the local per-CPU list and wakes vCPUs with a pending
LAPIC IRR.  The IOMMU has already posted the interrupt into the guest
vAPIC; waking the vCPU lets it observe the pending interrupt and run.

List maintenance is hooked into the existing AVIC vCPU and IRQ affinity
paths: vCPU load/put through avic_update_iommu_vcpu_affinity(), the first
IRQ affined to a non-running vCPU through avic_pi_update_irte() when ir_list
was empty at put time, removal when the last IRTE is detached, and cleanup
on vCPU destroy.  All GAPPI-specific logic is gated on amd_iommu_gappi.


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

Sairaj Kodilkar (6):
  iommu/amd: KVM: SVM: Rename cpu to apicid in IOMMU interface
  iommu/amd: KVM: SVM: Rename ga_log_intr to wakeup_intr in IOMMU
    interface
  iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU
    interface
  iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun]
    = 0
  KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor
    Interrupt (GAPPI)
  iommu/amd: Provide kernel command line option to enable GAPPI

 .../admin-guide/kernel-parameters.txt         |   3 +-
 arch/x86/include/asm/irq_remapping.h          |   5 +-
 arch/x86/include/asm/svm.h                    |   9 +-
 arch/x86/kvm/svm/avic.c                       | 173 ++++++++++++++----
 arch/x86/kvm/svm/svm.c                        |   2 +
 arch/x86/kvm/svm/svm.h                        |   5 +
 drivers/iommu/amd/amd_iommu.h                 |   1 +
 drivers/iommu/amd/amd_iommu_types.h           |   6 +-
 drivers/iommu/amd/init.c                      |  31 +++-
 drivers/iommu/amd/iommu.c                     |  59 +++---
 include/linux/amd-iommu.h                     |  13 +-
 11 files changed, 237 insertions(+), 70 deletions(-)


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.34.1
