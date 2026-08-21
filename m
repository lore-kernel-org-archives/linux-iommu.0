Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4063AEB38;
	Fri, 21 Aug 2026 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297959; cv=fail; b=fnL1ZHwYpEDU61cb6/VnYkxOypZbZ2aIu55ntdlY66p4HZJr61NkZepWh3nSY0OD2zrN54lF7JbXbB8RDUGGKRbAKxVYeji92PjUJxRlxQfyl4IbFH4ISKVqTnovqKc2lU3/e2m3SEGNCrtL+J6N3xQx3g2ijssdj2TUJEmnIyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297959; c=relaxed/simple;
	bh=ITU3kI+Nb4XtAcpyL3eKFtBPEdilxp9UCMUTR+qJN5M=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VvFISLgis4q6uumf+qSzj9n3XxYJlfP/19A6zg+B4O2ryiD1igN75zYE5kJTB7xbnyjgoTlX1ZfO5E7fCkBvLuhsBHQr/jteE9iNYdFv/gxC95EFY4IEhE7bALbVg6xxnQ3qs9b8aeOq1fgcPvIem64KkIyNdPPdIQPqe9EZhyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fF1FszZr; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fF1FszZr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPsrBM14KbVEIg6AXDpD2I04iyJ5wofKNl1FLtR7P0Hx10+tPKTuMcoj3m3DQ/crLlX7fsIJocMic/7TIC+882X7RUErb7PsfszVXRoAQfIjklfBFIC7k/4zh6tmZ4qWc5m2Hxy3JB61jfYlDZmJcCOlQyAKMSknCdmJwfFg9UF+jSRt5oz8ODD0+NPgCA7qERbd6c4+SSnbSRQmW+yE514XgvcGYq0duJ3moKQ+zFPKVD6Ui3UJJCavBV7s0Y71L/OCqJvd6My7jr9/e412vSWqt5H2HSUrXSPtr5F4Z5XOtIKUOvCBg+7Ego+DOi3TCOWAXqw0tkTiYxszF9rNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWdx2YU5pKutitAiYon+GUXBSi6dQZFVTRVeFrwkvt8=;
 b=tPD95NvUNBLi2QsgulCMMRP28qXvbdpFiw1PWvrCTZ9+xuuTsBoJGDkoA4/Sd4JnnqtXq2Zm+BWUzCDsTIS272aXhVex3LA2HXbL9LtUz+KXQzsKpDQBvwxvNSS06HHg6k2qn/YBoyvR0XHTB0sC2uatIvBY5JgE03BIDZCxxVEWZ+15JF6sW3LMVfP4jOJjJ8sdrJ96x25vbAzZvvmxPpPSIFxkIMfsKJ9umW5LorUMjW+NhSMhPgIWumkF7Hc8LYwjnAlqBPLsoe2Y7WcaYhPbwfghknIhEdO3u32q68DN9sfProp6Bys5Yi3tAjnw2CRFYQzLFrqTajYQA5v1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWdx2YU5pKutitAiYon+GUXBSi6dQZFVTRVeFrwkvt8=;
 b=fF1FszZrYyCNEHe8mmMeHp190Qd5G+fsa1tXw2lKDlzj8ichCxOzJZQvH3W3HhrU7hM8lXtVURtoKr1A8bgTUxtlrQw2UOLQKdTbo2G+rJhtQPhviRgIgA9cTxn/5u4qA1/kCTzNJ7saLuq1q+5zBGs63pQ9WH9cnl6cwBvbLIA=
Received: from BN9PR03CA0271.namprd03.prod.outlook.com (2603:10b6:408:f5::6)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 07:39:06 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::35) by BN9PR03CA0271.outlook.office365.com
 (2603:10b6:408:f5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 07:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 07:39:06 +0000
Received: from [10.85.45.224] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 02:38:58 -0500
Message-ID: <68696175-a796-422d-a677-4a986ef86631@amd.com>
Date: Fri, 21 Aug 2026 13:08:56 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>
Subject: Re: [PATCH v4 0/7] Add support for AMD IOMMU GAPPI
Content-Language: en-US
To: "Borislav Petkov (AMD)" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Breno Leitao
	<leitao@debian.org>, Christian Brauner <brauner@kernel.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric Biggers" <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kiryl Shutsemau
	<kas@kernel.org>, Li RongQing <lirongqing@baidu.com>, Marco Elver
	<elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Sean
 Christopherson" <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Will Deacon
	<will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20260821055611.27138-1-sarunkod@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260821055611.27138-1-sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: d120c7ae-633c-4e8a-d6d9-08deff5747bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|13003099007|921020|3023799007|6133799003|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	boqUPYzF5ZxTltFtKTsnuMJAwqpVEAYaxFyIJlc5+x0uemkd22fOuPt6l4E9xayVfLpoxE6X+WJGr69qDZJLQavhIeFW9wERhOKCj1gmNnL1i5l952fGUvwmM22lHPSIQOAu8eGAJRzfcxvjaw1WHYCjBjrLeZMu/tVy0byLetRH0K83+bw88UH4soEJOtP9wztKQKXCPspcLX8dSCWz1O5j0Tvak/OYSiZh6VCVaysPYyZF88o+XR5+scKrEJg3z+6nC+rCppY9zJ1QarBfHYXz5n6ZxCOA8v3MmCPIzush8yTO0qhT6+RUgW5/6d9VLjulghQQeq/GsGGpl81E0bC2XMEKSWorOmmADHBM6g3+csloyEm2seiCmN0PrMuMJAdoMr2xJeEb01mnKtDGd7LBKRy/O+MybQkvwdamxNlh26JipenIbHDWYk3ytt52PapKu6hKCkQ4bUQQW77ypkj95AE91Wa0qOBp66TPIQdG/hyasCrnhG8JI7m2YGm/C05qrX3vWPMNuyM+b4C99MC6ASR/fjFXS5B+UV0iuGnrs6Mfyem8QM7p3Ob+nhblHb0hWX4bYwH1ZHDSrQkGjqJ01DGWxlY68QCJs4PUxqihT0X1t++tiFWCobNJSG4gv9vgHuDxmVsbWfreczK/iiG6kIW6pO+PWQAIfXGdPyvGSH2v7+hDA9SKQon19U8WuDTdClQImgO4Jm8o8+KWEY5JFuaUI8EDsnB/t5zkIhYzPQfUqJKbVXZ4v2u7WnaG
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(13003099007)(921020)(3023799007)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5wMRaEp6Bw/vP8bAKKH7sh8dhaDZtpdus5aOFNJLOY94uW6d9Dyf0Ed4mxZs0cbq9d3jH9EySQ/8r0vGHEqhYj8yd84FFECszmuAlhOcV0unSqHQmrPYJJgdF2RQxRyb0NF1D0750NpCDL4W6ptu8fPlMaCRfVaabj9VMlZl1BcNKaaUEYRNit39wKTm/iOcYgUUlxDJR5gR1Py0xJXSrGx+too9o2bbdjIFr+JnPBpHYXFTfkjPbjyqdyCUNEG7g5HKe8deBgSMRuCwNUrUn8Y02BQ4BEpNHkLBJrgB0ZXTHZj/+azno0721ZsUmVDQY7w8VJDNn9IdvkfyfbA8ZNcruZRZuyS4jNpC/NEDT1JNUIC4OM5J1YSlpOgT1O0ZnLAS8jK7YvRqhkRStGfOhleJW3hhok1jZk7iobTTBJUGacvtbMbfa3acxkg53c6q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 07:39:06.3631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d120c7ae-633c-4e8a-d6d9-08deff5747bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076



On 8/21/2026 11:26 AM, Sairaj Kodilkar wrote:
> Introduction
> ============
> On newer generations of AMD processors, IOMMU AVIC/x2AVIC guest-mode interrupt
> remapping can use Guest APIC Physical Processor Interrupt (GAPPI) as an
> alternative host-notification path when device interrupts target a vCPU that
> is not running (IRTE[IsRun] = 0).
> 
> With AVIC enabled, the IOMMU posts device interrupts into the guest virtual
> APIC backing page. When the vCPU is not running, KVM must additionally be
> notified so it can schedule the vCPU.
> 
> The legacy notification path is the GA log (GALOG): the IOMMU appends vCPU
> tags to a shared GA log buffer and raises a single GA log interrupt.  KVM
> registers a notifier and scans the buffer to decide which vCPUs to wake.
> Under heavy interrupt load this adds latency and can overflow the buffer
> because all wakeups funnel through one interrupt and one shared log.
> 
> Guest APIC Physical Processor Interrupt (GAPPI), defined in section 2.2.5.4
> of the AMD I/O Virtualization Technology (IOMMU) Specification [1], is an
> alternative.  With GAPPI enabled, the IOMMU still updates the guest vAPIC
> backing page IRR, but may deliver a physical APIC interrupt directly to
> IRTE[Destination], using IRTE[GATag][7:0] as the vector.  This distributes
> host wakeup notifications across CPUs instead of centralizing them in a
> log buffer.
> 
> This series programs guest-mode IRTEs accordingly: IRTE[Destination] carries
> the target host physical APIC ID, IRTE[GATag] is set to
> POSTED_INTR_WAKEUP_VECTOR, and IRTE[GAPPIDis] / IRTE[GALogIntr] are set
> based on whether KVM requests host wakeup.  GAPPI is selected at boot via
> the amd_iommu=gappi kernel parameter on capable hardware, otherwise the
> existing GA log path is unchanged.
> 
> 
> SVM/AMD IOMMU interface changes
> ===============================
> The first four patches refactor the SVM/AMD IOMMU interface ahead of GAPPI.
> 
> The cpu field is renamed to apicid because it carries the host physical
> APIC ID for IRTE[Destination], not a Linux CPU number.
> 
> The ga_log_intr boolean is renamed to wakeup_intr (and the synthetic
> AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR shadow bit to
> AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR). wakeup_intr describes KVM's intent
> (request host wakeup while the vCPU is not running), not a specific hardware
> mechanism.
> 
> A separate is_running boolean is added to IOMMU interface because GAPPI
> requires a valid apicid in IRTE[Destination] even when the vCPU is not running. 
> The prior encoding (apicid >= 0 means running, apicid == -1 means not running)
> no longer works once apicid carries the GAPPI destination while IRTE[IsRun] is
> clear.  The IOMMU driver keys IRTE[IsRun] and destination programming off this
> explicit boolean instead of inferring running state from apicid.
> 
> 
> KVM GAPPI wakeup scheme
> =======================
> SVM follows the Intel posted-interrupt wakeup model already used by VMX.
> Each pCPU maintains a list of blocked vCPUs that may be woken by a GAPPI
> delivery to that CPU.  When a vCPU blocks while waiting for a device
> interrupt, SVM enqueues it on the wakeup list of the pCPU on which it was
> previously running (gappi_cpu) and passes that pCPU's physical APIC ID to
> the IOMMU to program IRTE[Destination].  The rationale is that the vCPU is
> likely to run again on the same pCPU, which is common when vCPUs are pinned;
> targeting GAPPI notifications there reduces unnecessary VMEXITs from GAPPI
> deliveries on other CPUs.  When the vCPU is scheduled in again, it is
> removed from the list and IRTE[Destination] is updated to the current pCPU.
> 
> List maintenance is moved from VMX layer to common KVM layer so that both VMX
> and SVM layer can share the same list handling code. 
> 
> Note
> ====
> kvm_pi_enable_wakeup_handler() and kvm_pi_disable_wakeup_handler() take the
> target pCPU explicitly instead of using vcpu->cpu, because on SVM the two can
> differ. avic_vcpu_load() returns early while the vCPU is blocking and leaves
> the target wakeup CPU untouched, but the generic layer still refreshes
> vcpu->cpu on every load. Using vcpu->cpu would then unlink the vCPU under the
> wrong per-pCPU lock, so SVM tracks the pCPU it last programmed in
> svm->gappi_cpu and passes that instead.
> 
> 
> Changes since v3
> ================
> https://lore.kernel.org/all/20260713105033.15405-1-sarunkod@amd.com/
> 
> Patch 3:
>   - Make amd_iommu_activate_guest_mode() as wrapper around
>     __amd_iommu_activate_guest_mode() to in order to hardcode is_running
>     flag to "true" for external calls
> 
> Patch 5:
>   - Newly introduced, moves wakeup list handling from VMX to the KVM layer
> 
> Patch 6:
>   - Use common list handling functions introduced in patch 5.
>   - Remove list addition during pi_update_irte by moving list handling
>     functions before list_empty(&svm->ir_list) check.
> 
> 
> Changes since v2
> ================
> https://lore.kernel.org/linux-iommu/20260708091408.12106-1-sarunkod@amd.com/
> 
> Patch[1-6]
>   - Expand commit messages to explain GAPPI, the interface changes, and the
>     per-CPU wakeup list scheme [Sean].
> 
> Patch[1-3]
>   - Split the monolithic SVM/IOMMU API refactor into four preparatory
>     patches [Sean]
>   - Rename posted_intr to wakeup_intr to reflect host wakeup intent, not
>     guest interrupt posting [Sean]
>   - Pass vCPU running status with a extra parameter (is_running) instead of
>     flags.
> 
> Patch[4,5]
>   - Move ga_tag=POSTED_INTR_WAKEUP_VECTOR setting from IOMMU to SVM layer.
> 
> 
> Changes since V1:
> ================
> https://lore.kernel.org/all/20260626105906.14577-1-sarunkod@amd.com/
> 
> Patch4
>     - Disable interrupts while holding wakeup list lock inside [sashiko]
>       avic_add_vcpu_to_gappi_wakeup_list and avic_remove_vcpu_from_gappi_wakeup_list
>     - Unregister posted_intr_wakeup_handler during module unload [sashiko]
> 
> Patch5
>     - Disable GAPPI feature during kexec and suspend path [sashiko]
> 
> 
> ------
> [1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
> 
> ------
> Base: 89516a1c6837156f43525ef49fdbd781145942f5

Apologies for wrong base commit, Please use following base commit

Base: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6

> 
> Sairaj Kodilkar (7):
>   iommu/amd: KVM: SVM: Rename cpu to apicid in IOMMU interface
>   iommu/amd: KVM: SVM: Rename ga_log_intr to wakeup_intr in IOMMU
>     interface
>   iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU
>     interface
>   iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun]
>     = 0
>   KVM: VMX: Factor out wakeup list handling code to KVM
>   KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor
>     Interrupt (GAPPI)
>   iommu/amd: Provide kernel command line option to enable GAPPI
> 
>  .../admin-guide/kernel-parameters.txt         |   3 +-
>  arch/x86/include/asm/irq_remapping.h          |   5 +-
>  arch/x86/include/asm/kvm-x86-ops.h            |   1 +
>  arch/x86/include/asm/kvm_host.h               |   1 +
>  arch/x86/include/asm/svm.h                    |   9 +-
>  arch/x86/kvm/svm/avic.c                       | 109 +++++++++++++----
>  arch/x86/kvm/svm/svm.c                        |   3 +
>  arch/x86/kvm/svm/svm.h                        |   5 +
>  arch/x86/kvm/vmx/common.h                     |   3 -
>  arch/x86/kvm/vmx/main.c                       |   6 +
>  arch/x86/kvm/vmx/posted_intr.c                |  82 +------------
>  arch/x86/kvm/vmx/tdx.c                        |   1 -
>  arch/x86/kvm/vmx/vmx.c                        |  14 +--
>  arch/x86/kvm/vmx/x86_ops.h                    |   1 +
>  arch/x86/kvm/x86.c                            | 111 ++++++++++++++++++
>  drivers/iommu/amd/amd_iommu_types.h           |   6 +-
>  drivers/iommu/amd/init.c                      |  31 ++++-
>  drivers/iommu/amd/iommu.c                     |  65 ++++++----
>  include/linux/amd-iommu.h                     |  16 ++-
>  include/linux/kvm_host.h                      |   6 +
>  20 files changed, 323 insertions(+), 155 deletions(-)
> 

