Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792678019;
	b=bxrbD3X//SbB0NK78Vqlea061UxzeOaTBvrgcc8tK2N8limWzKdhDKhEx6NskgxFL+d5
	 z/fEtDD27zEraMwsaWv/ggJdpeBHBJWcCio0+bFZTV/wwBuq51p6iDljBnMzs6RmWnlbf
	 XEGXq+z0EfotD7oIwEXVn5IMU4WURoY/BoP6tPv9afbQAdFEyBNJhCOR8bTwdMWqS4uYz
	 25uxxMqAjtQpMpzkAr27qqQjesnv8zly/rjpdh/A1vqyvc3P6uKpYC6UIXaw2LhQiqBUe
	 YHOOeFtFPax08cF8ckR+6syL4uART7fodQDPAG6k1zDUoVSFNLpOkn2e9b7GpEO5DPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678019;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YACiU+aS7hEXr0+/v+twH0okbDmb4uEhTVkIeo8me34=;
	b=0gsv2V8Q/gfGl5qvGWBTJ1lEbRiaD+RPfw84WgfJ5QeCnzO9cOVuUhltDEfBxKZQU8T+
	 3S1HbEBsDwg89tXStfZCNaZKCFDBsIqowqoL1T98S+MBNJja8MfGlHA89FuyeqMmnATZ+
	 SYwmVlID9RtxJSpGxTDKzlXMgGOHR4F4zwQPRpnR2P3T+9e2P0wd8TCPK8RtFMJd/DNyz
	 BB+rAh0qaxCVS/ABOW7ct61216E5SvB93LAS7M1B0jS44nCFUeZpEj/E2ZF7wUS67tZyp
	 vIV2bcrEXZ3sbSMtV6o82cMDnFdVvC4U59rtSuCDrGrIWGNMboQaEXNzx6Qk0gfclmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t3woepCH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.16
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B389C606A319;
	Thu, 22 Oct 2026 14:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B389C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t3woepCH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUzhZmFrISQLK7DiVMIXdpsKJVywPZ8vqz/wVqC1pqRDQaMS+XRoY0qHRL6PLRhQvTuFawTWz8NZ5S7NfQKORU279+fbsh2DlMv1rYCizjBiMqggMiZ7fzT9qq3YEm6laIrBF0ljOyu9hfdK1n9jOaCXp44xLEOxhBMnDdC7YCGAz+BL/cwtsCGjFacIoCrXmeigmpW1/bOITvQEJ+kCaUQF9HSSpfnW8wWVuC/Zlti13nHCLeiHfyn2rfcszWgW0iaU+/iw0DwmsiIxBMGJZAvctrp0DE3BVH9te2agMShMqmXC9QHIPWfWiauSOnSS8zxuMM1+doSKmy1rKfYwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YACiU+aS7hEXr0+/v+twH0okbDmb4uEhTVkIeo8me34=;
 b=zHoLKvlmbpCbHvYEOAj/sXsIobFFLiZ9ZtCLImBWqZHlYUL9vA8sGTmZEf5fOIEHXi1929VzJMH/ncXyllTczFTCsTT/XeWmOHQSU4tEko2pBvuJSfO5EI6NQGMosI+48i5bLX1V4rVgRey+TGpA7/rOj13UywdZpoxfoJI8ndQHBQ0MDgFrJKydKF9GrIn7woHg1mGgjHjSKcEqPIAau3xrCw9K2VsCnU/npauvy127JzvCepvXlChv3+XIp8klqAWRRRkWBtu6U/IEQ6I0/uJhqPe/k+Ic3lIZXYCutuwfvgjHjMQsmiL04oUKfLokgbQZJE+PiTJak+JF8PJZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YACiU+aS7hEXr0+/v+twH0okbDmb4uEhTVkIeo8me34=;
 b=t3woepCH1Q0uZfH7iNa8kP2FLVVSy489f4QfBkLHcUqAQgz7cMbtCEA4iBX3yD4KaiNwR01nmzDOjDuAWedulPCw6+VKJSFKH7Fo9aWoN5nKbcT4pk1WuQPa72exvq7LKuro9/ZHAbxUL2p27DtNRG0t6X9C0ujx/pdX/ShzUZU=
Received: from CY5PR19CA0078.namprd19.prod.outlook.com (2603:10b6:930:69::25)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Thu, 22 Oct 2026 14:06:54 +0000
Received: from CY7PEPF000000F6.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::3c) by CY5PR19CA0078.outlook.office365.com
 (2603:10b6:930:69::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 22
 Oct 2026 14:06:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F6.mail.protection.outlook.com (10.167.247.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 14:06:53 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 09:06:43 -0500
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
Subject: [PATCH v6 0/7] Add support for AMD IOMMU GAPPI
Date: Thu, 22 Oct 2026 19:34:18 +0530
Message-ID: <20261022140425.27465-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F6:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: c9121a40-acca-42fe-eaf0-08df3045b9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|6133799003|10067099003|18002099003|261021121427099003|3023799007|261021123027099003|11063799006|5023799004|261009223027099003|261009221227099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	SFwLPqy+BC5CsbcOgjfE1gY3JHqdhXAsKiALNB9Ukg2DmztAriHWLxyPHjjZYbCydVr1kpfcC93N+IhMjwaW1fB5QrSaJXG03bbBPcPesER5iaPV6CJALAQYqVdyUav+iYcKLulstUFq48IpQXFa5rT5MJQT0GqT29PJ35JJY8U/rhdGC3iM2MyNXDH+RE5FFsCxp1JYiuDTiKX1A7zUpKWHS5hFI29G8qEveIrT1pQQ3GqAlDcbIGSBznQxH/Y+vWHObExfW88w3nLXccQjCVz3UU2NJih3IGt9cXKdlp2L1nICRW918GS21x5NR+muAxb8scEoAp/sZ1PZpoZzS+8OvNOD7sVbvBpBuU96byz3mzBItXq0G5NrddaawRgLjUXmQQxuK/IZN3H1Fs+9E16ymztscG3fenVaCNzC+LNjo8WjDKzLci2XuWJSRsxcMueRiO1VSjpmlTni3uSEle9OaGwxsNNDpelb6IQHzQ3gJmltszNpHX+JHA+ZR0BJOL/Wi0fNjrxCT0ctAQPFfRu2N/ZCPH7Sb13D5Cf5wgQS6pVXQODyhlPPRtNpIHWrjLLFmzDEQlrwikeP2kehctR2pfAiKB+zQPOaT4PUkexpOOOtWLJFGwVFRpIPvgAI5wfwRo/zvf8+HZBkKIkFKER/zMD34s1CFmX6VN8NW8jo5RT4XwAKSFt7Tw194d8CWLtxbYFyImAqKXsxLMmmsw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(6133799003)(10067099003)(18002099003)(261021121427099003)(3023799007)(261021123027099003)(11063799006)(5023799004)(261009223027099003)(261009221227099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9t4tv+wxGuJEbG8EwWj7b9guKe1aSqgqA5XujhWRUokezIcoQH/6b17kXK4OTECQWIpno9KjI/GNVvNEaPJzZZGdwnWz7BnHesYpo4QEnjSAEvC2sShPp+U1IXvShHoaAYdF5cPtGGJ16uy2PVgkcpPLQDqZxekFqYPEfr8pkrkxdtczwd8NeHdjcVT1/XabMWxu8gQBbpDkbvZ8liyGsnesKCLYPybwh0euvr81aLhq+AYIKRRGiq7mu4r0j8zhlMor0ApgF6S2E+Goi1Cj8nBgYkRSRoT80/c4cCJLVqJsVnaFkXIs92xFscAntqUD6vMaPMd5mVzF5hJjyAr3B9emEeVUe+ZOYOsSfBLLbArUITJums+zI/k7S0C49h3MGp1IpsCgXoIhvZZlvYXHfcf3wc79XR0fdf2407WhLSHV0PLgdGHfQqEuO0Gysyop
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:06:53.8535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9121a40-acca-42fe-eaf0-08df3045b9dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416

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

Remove wakeup_intr flag from amd_iommu_activate_guest_mode() since it is always
called when is_running flag is set and IOMMU never uses wakeup_intr flag when
is_running is set.

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

Changes since v5
================
https://lore.kernel.org/all/20261015064515.10700-1-sarunkod@amd.com/
Patch 3:
   - Remove wakeup_intr from the amd_iommu_activate_guest_mode() interface as
     it is never used when is_running flag is set. [Sashiko]

Patch 4:
  - Set GAPPI dis bit to 0 when vCPU is transitioning to running state.
    [Sashiko]

Patch 5:
  - Use KVM_X86_OP_OPTIONAL_RET0 instead of KVM_X86_OP_OPTIONAL to define
    vcpu_irq_pending callback. [Sashiko]

Patch 6:
  - Do not add vCPU to wakeup list when avic is disabled or wakeup_intr flag is
    not set (i.e. vCPU is not blocking). [Sashiko]

Patch 7:
  - Rename bit 5 in the feature list to "GAPPI". [Sashiko]

Changes since v4
================
https://lore.kernel.org/all/20260821055611.27138-1-sarunkod@amd.com/
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
*** BLURB HERE ***

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
 arch/x86/kvm/svm/avic.c                       | 101 ++++++++++++----
 arch/x86/kvm/svm/svm.c                        |   1 +
 arch/x86/kvm/svm/svm.h                        |   4 +
 arch/x86/kvm/vmx/common.h                     |   3 -
 arch/x86/kvm/vmx/main.c                       |   6 +
 arch/x86/kvm/vmx/posted_intr.c                |  82 +------------
 arch/x86/kvm/vmx/posted_intr.h                |   2 -
 arch/x86/kvm/vmx/tdx.c                        |   1 -
 arch/x86/kvm/vmx/vmx.c                        |  14 +--
 arch/x86/kvm/vmx/x86_ops.h                    |   1 +
 arch/x86/kvm/x86.c                            | 111 ++++++++++++++++++
 drivers/iommu/amd/amd_iommu_types.h           |   6 +-
 drivers/iommu/amd/init.c                      |  39 +++++-
 drivers/iommu/amd/iommu.c                     |  66 +++++++----
 include/linux/amd-iommu.h                     |  16 ++-
 include/linux/kvm_host.h                      |  10 ++
 22 files changed, 346 insertions(+), 158 deletions(-)


base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
-- 
2.34.1

