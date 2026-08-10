Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261D336895
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353736; cv=fail; b=mYJ9OqPKbIdNxy3bHTZ3dkmTBMuWbqw8VjDiBBLdyUQyV9DymiMeczaVysVcFkvE3T+JQdpm+teX7FMs+xlu+obNmUgKL06nHnPFmja8DOfPotWZsKf+eTP+OLAF12szs5YlXw+NcUz013AaXixzUdhkIZKYP95IAlNPm6bcJZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353736; c=relaxed/simple;
	bh=MIB3w/3qXjkE0sjjmZ4Of2eODTXXe0ZFj+aLZa8+J1I=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sc+rWb6QT95F9QO9Z0dhRMFgiBx7NCXcg/N+3rOlgf02rsA6nkaU//etrkRPJrEDNSiP03wAymHzVk25+SnI1jrZ8djc9gi/UKYAWsT/UV9FO54RBt3d5I+POVafifINRhw3KgTs+tSn4Aoeq4wtZ663cerk/Vji5GZu5CmPwDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jyAMYfu4; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jyAMYfu4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdtnQL4DYaBvS+fa7B/N3v5AuLTFeWqcBu8gD8ZtgZ4oruUv8J0Vpgnce6bwIDIDMhrXjfuVCn3/JiM/Vw0TLmz7LWK54/ddCDUi6V28ayblKHM3ElZU8rib9S4wAYAOBksVDoLJxMfnlvfUDjHJRyHdm+RcrzupskcaV6BhneLmrJwIwyfOcrixT3zbgAoz6UxaVmty4ktLjn6yorD01BXUTIcGXZlqbX2XTMF/f7dV/H1ItoWccN8SdzNscTg3fLzyBCckSw0QXVbIq4+MjgNxWeHi4II5yBiv9sJbpE8VRgJd8+lzqWJBkIK433E4Gls5+LPxB//j+HVv0W2Nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lcc1t9MPEmzEh/itEA85tcUBg7dIcvdCJ5wC+0Sp3Es=;
 b=IzV3+tlhjEaGjiJsPQ9qu1seu78h3gJn9h4Q27eMCJr8CvgDjR/cwm8DM2IKJyaUeemGgoWyJ9p++M2Cl9uEKI3Ezqc2IYSMiPrasg/Js8rgpmjIztF9kM8fiy5zubd7ZGn8JbmfGRH8/u4Lz6fcyZo1QQzeTc3lpCM+eriIS1lzlQi3++8sxVovEkquuyfALRkSvh/Y+ZCU2WI9nZuWVyObmqRohtUBbUjxrwXK7NyQZmnpj8QMGsZyXBJhajfFngOwNWjXlCokQeNryiaTkzhSZzvNg4VQO4u93ZC73jAs5LZXRol729TVcHmRL/ubN7jT/3r8Sl6JxpkwYwT+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcc1t9MPEmzEh/itEA85tcUBg7dIcvdCJ5wC+0Sp3Es=;
 b=jyAMYfu4fBHh8x1pl/FOQLf6zbNab7oXXh31ASb6G2RrzQfVozxBhLXxxSvy8E2wKIP02EPQ6Ev9UT2FHsxd237arcIQEnLEaTXheiEk8fnirN53hPijO7fCSjohm7mXP4wihRI8uclfsbFLGc3X2XNe/ZT5+cqYp1wxr2whmzw=
Received: from BN9PR03CA0691.namprd03.prod.outlook.com (2603:10b6:408:ef::6)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:22:08 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::7) by BN9PR03CA0691.outlook.office365.com
 (2603:10b6:408:ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 09:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 09:22:07 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 04:22:00 -0500
Message-ID: <32f30f3f-62e3-4d17-819f-c5eda1af457e@amd.com>
Date: Mon, 10 Aug 2026 14:51:58 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>
Subject: Re: [RFC PATCH v3 0/6] Add support for AMD IOMMU GAPPI
Content-Language: en-US
To: "Borislav Petkov (AMD)" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric Biggers" <ebiggers@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, "Ingo Molnar" <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Robin Murphy
	<robin.murphy@arm.com>, "Sean Christopherson" <seanjc@google.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, Vasant
 Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20260713105033.15405-1-sarunkod@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260713105033.15405-1-sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: c82763f9-cc92-4e0a-21b4-08def6c0d982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|1800799024|376014|921020|13003099007|18002099003|22082099003|56012099006|10067099003|3023799007|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	jLVxdh0ua9Dz/p/tQaG5xOWDzB8MaBJH8AizBmkPFfiRV7Cb1/JsRN0Xe+cqvBgrUiEkUD8VNsYG8SbCjK5EESbhMbLBS0kwYV31fJtxSYqazkznFSwdUYN76fzX7mbDkgKvILwGlzmnm/FgNMOX9uplev4oY0jy4jaSOqk+aXyWXNfKzcwkdtjWhQuYGyXr94ROr6oe8Q/ZrVZByEtS2YT2iq6m5ef4cPeE+4EVG96kVrjSHGjNYYkEjFPsYLBQRwq8Xqp8tHY/iVjS2iFfsZZMJy2PghoTky5UgUYHaobSAr3opL+V8cRsuYRvQGbuahMXFYljzRX6w1ji1Ttt9SItxpA+eOCkQhhi6vLbfVnxBm3niiso6bF7d8f8DfU5Vd6yAqXAMhPlpwfGU+KroOs93sqgnnyQRRie8mdXJt8OSQUgN9XpDsYYGYm436WVbD46neI8/B98OdmzCibxoirL9Y4WE2Ky7P9kAALe5KyLfTF8lSaKPduocgvArHc7ErBLySn5kj9hi67tDu7h3bKy8VplhzVwD1D/i+MjfClgy9kOl9HsyMdHZoGHIqhzKpD49Ye1hpHSvZ4k9fdF3GJNqvP4cUQM/PlyiysoqH8TOyLkFAwz2niKN98IxHY8c79q4lQRR/qN4M1AHFNjZMoCdvj3kxUDR6ZyDK+hFHCTG75cO7qdvIOEk8Vyf68GHNTww2YJJrAidnde2DhK/1u78ZNT2gnTU4Ry9H2pj+ujlNWAvzRwKw+zTjXIITkU
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(1800799024)(376014)(921020)(13003099007)(18002099003)(22082099003)(56012099006)(10067099003)(3023799007)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KxrN0aHJ1KrMcQrPOxWu/AmisorL0RizeZ0DWnsivuvORareXAt+uYoULsnKDTf18c94zhyDLgoqyrfOKle9gwnWRGCBjhiyBlJVYYaiXd6gP9fjSlHMqs3+onYMwa3YYOmhBWIny7oWnJ5J+aPdt6qX0HHT4h6Y/z5OGy0PTKnCDtGvMqKMGsFpbeAcVlvfAT5lBHWM5VTdp+DNlCc+Z7qzWZMWcXRYutUG6ORGVIFsg+9Du+g77WyASafH93k2IWFZlTO9h+wHK9EbRwc4BYLmUMipnH9P3ylGRssnzOG6DPPwnzsSOA47aLHsnPTCrDaHGbDAYhBQCbLgwRE1nMQGbrocF8fBUZMkPX5eXNro8JeEiENHbXo1kEuLICft4b+8SA0zcVBlhJtMyMHGxYmYwdCQL/Cgf+D7MYfMGuBYqJqBES05HgHCxDVQLov1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:22:07.6255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82763f9-cc92-4e0a-21b4-08def6c0d982
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890

Hi everyone

Gentle ping...

On 7/13/2026 4:20 PM, Sairaj Kodilkar wrote:
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
> SVM registers avic_gappi_wakeup_handler() via
> kvm_set_posted_intr_wakeup_handler().  On POSTED_INTR_WAKEUP_VECTOR delivery,
> the handler walks the local per-CPU list and wakes vCPUs with a pending
> LAPIC IRR.  The IOMMU has already posted the interrupt into the guest
> vAPIC; waking the vCPU lets it observe the pending interrupt and run.
> 
> List maintenance is hooked into the existing AVIC vCPU and IRQ affinity
> paths: vCPU load/put through avic_update_iommu_vcpu_affinity(), the first
> IRQ affined to a non-running vCPU through avic_pi_update_irte() when ir_list
> was empty at put time, removal when the last IRTE is detached, and cleanup
> on vCPU destroy.  All GAPPI-specific logic is gated on amd_iommu_gappi.
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
> Sairaj Kodilkar (6):
>   iommu/amd: KVM: SVM: Rename cpu to apicid in IOMMU interface
>   iommu/amd: KVM: SVM: Rename ga_log_intr to wakeup_intr in IOMMU
>     interface
>   iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU
>     interface
>   iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun]
>     = 0
>   KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor
>     Interrupt (GAPPI)
>   iommu/amd: Provide kernel command line option to enable GAPPI
> 
>  .../admin-guide/kernel-parameters.txt         |   3 +-
>  arch/x86/include/asm/irq_remapping.h          |   5 +-
>  arch/x86/include/asm/svm.h                    |   9 +-
>  arch/x86/kvm/svm/avic.c                       | 173 ++++++++++++++----
>  arch/x86/kvm/svm/svm.c                        |   2 +
>  arch/x86/kvm/svm/svm.h                        |   5 +
>  drivers/iommu/amd/amd_iommu.h                 |   1 +
>  drivers/iommu/amd/amd_iommu_types.h           |   6 +-
>  drivers/iommu/amd/init.c                      |  31 +++-
>  drivers/iommu/amd/iommu.c                     |  59 +++---
>  include/linux/amd-iommu.h                     |  13 +-
>  11 files changed, 237 insertions(+), 70 deletions(-)
> 
> 
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6


