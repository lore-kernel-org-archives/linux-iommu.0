Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379406;
	b=cOr/lzjTZCkuu8oc9kPKgkAu4D0lGcRgXkntCgEC6Bkm+zgdy3J+oQhQ9DiBEwTjuM5p
	 ZlcX7P8VXpuze7thgFh6cc7k6odVN45NJzALFSXK06s5NzDdZxk8FPc8nc4gugLu6PLsZ
	 CboxWfikyXlEhO6ZV57bz5476J30Nq2TImyMuB9oOMthsYAhYCsiR4Gr/X2s8ZMSqyU8+
	 mCtc9fAAYy4+XIn1QrRgqgujN7amVAD7JsmJ4vCZ1kqhVoWzzc1RJmyB3fawqOdm2PHMl
	 i45Xk/KYLkBaJdv/0yVOn4xDbl2ePZknkvsq0H+0bY3n+MpLdqzZFnwIxGvLUZrVWzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379406;
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
	bh=lBpVhCFzpASnbAhoglf9NrycuxfCVVDBWeYgpv4M6JA=;
	b=CafDCDKnS0s22iXoJGSreet5NKyVG86zC1ZucZQpNRTJHwwZ/plm7JqIw3BGHbizibj/
	 7weCYJc2EnZqFvl/f5CiJfYhc+c7KLsxE/W29NHQ421oO6IsdQ7KvTRANGqTLAX4v86mG
	 bf2yR/xA+LnIZEJBL8E50tO3aJbIQsI/waZSZUL+h7PNcHEil6O04Lf/LmYENig099doI
	 zBGsmOTl2mrm6AgCVxhjA0cLM6mFwtNpD5lhwRr3uQOyE0JKM006NcyIlGKrBgpXsQHJB
	 L+iAW7M3BbcJQJFXpOgRm+uCcTjyFN3k/osbrz2Lpozz0poncePBQBN7c8r3tl287TA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jizMV5zJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.29
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC1606A321;
	Wed, 11 Nov 2026 06:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66BC1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jizMV5zJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgAoVlp0nvvItBPBmYdtrbl0DXaeSLBYvdJndAV0LFikRGmeKLi4wKd9BapbO1ET3d3cP5lVWsF39Yq/Jyv6kHwgojvSgU+18xsEjuxlC/4Il+dbq9VzkgZykyqTQM22NNZOjhHcgRdJMoagFe35WhSGPAHKLSb4FJDDvKZTRoXHLdxJmeuuPWfe9hCR58OBxWydZJc1BYXQbZ10e4kDxDczVP6+QLldSiA1bLZhePtk0HDrfkh3uqLVCu5uK2aBODaK4cwM2seXy+ddIeZf9YUewU+Z1tqjptO1c38iJLlWieljN+lfACa4aVa599mtmKFC8hy/wekzoPz4tQD1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBpVhCFzpASnbAhoglf9NrycuxfCVVDBWeYgpv4M6JA=;
 b=IPLFE+Ng2sMWnRn1rBKtMC4SYlCiVHCLT/Gs4wwRaeYGChKugFTNsE0Bp9LfY0x2mGfjEVLmxQLJczjbIetM9+2uIpTOf8+ZjzmUn9HwpiYs5ufbD7DTtou2waS59N1ttS6rPif+Ky1c+TiRxLkYeHp41b9+IiMpxJrDyBTv4UW5MXVLIAkFPMqUaBh6g5gxGStWF0Pssn12KxngDQhbxpDl/NJOZStjhuCvgQjfLVjgVKWTcsaM0hkk69wM3WvB8bHTxGGMl6/tdvczgLHdVB/HtoK8RATuv03n9wiPfhV8iW54JkWurMcx+4oOeap/aiimQULzom5j8s1GOXn01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBpVhCFzpASnbAhoglf9NrycuxfCVVDBWeYgpv4M6JA=;
 b=jizMV5zJSgBeAEYBnV4Nw5qP9Ns6g/Zj0I2fxFdsUfmrXwVLQM697TH851jSVDCdXqXiw4uVRtBHamxu+u69xY4kiTJ+9GeTVZdCWm1hWe8K4/0tTVbuy6nUiQ1fvcoVH06cmC9m3SKrHC0T+9xpDuRW/znXUhganxbAnAZW5JI=
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by LV5PR12MB9780.namprd12.prod.outlook.com (2603:10b6:408:304::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:43:21 +0000
Received: from MW1PEPF0001888F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::11) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 06:43:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 06:43:20 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 00:43:11 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Ethan Nelson-Moore
	<enelsonmoore@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Layton
	<jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Karl Mehltretter
	<kmehltretter@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, Marco Elver
	<elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Will Deacon
	<will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v7 0/7] Add support for AMD IOMMU GAPPI
Date: Wed, 11 Nov 2026 12:12:35 +0530
Message-ID: <20261111064242.29336-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888F:EE_|LV5PR12MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae7ec60-1cd4-4353-1912-08df3fbf132c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700016|23010399003|921020|261028144727099003|261022075727099003|5023799004|11063799006|56012099006|261021123027099003|261021121427099003|10067099003|261022105027099003|261026140227099003|261026121527099003|261102123227099003|261009223027099003|261009221227099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	wQdGqx6fGsWW8PhuF5wJYJTlSCJOb82S6niivitRXjJ44gyk4MCWZcNZBHGII/B/MfMGDXwfppdL6iSR1mTDexsY0ilTrmbW7MSWK2PtDX0rM5X13zHa6Ehqkn+uHYcJq8NOa43UJtFReZQzYY1cTiw49uX61YfUe1z1BAVqArFq3XOvevi14+SARq7jqmZSIFEmRvonSzA1fPVPpYbRb4kwYD+Xp3ny0Ry5HYpKt33vngbqWmPcBOUslpvKCAVAsIumZ3QfQjhd1FwusOt0IaAx6jkrctpzF61MqDWYMNLwFQOUU5NEKIXoq0PQlaiiK3MbGPt+cVvmfpxbJqYRGmF+75i1zPQhX4a3RsdI6KB6B/lscC0xM8Bjj/lhfZAx1aX55bZtPyR1GApm/C43wUWCMmiIzvWAhGYH8cJGF/Y4Yw0w90c9RFJa3fVnLawi1Lq5fqqVo9NxYt+AkvwHGicuOY8Z4KriKcv31PJ7kr1UsHITYJzvhpdjtDfG9ui9ofvEz+KvXQW77jMsBWSpFJy9rYBqk4y1VHlDgqc30RL5qVAMVG8AMSvW2W/ErcG9rdJR7raCiswUYgjGgYNG7xtM0/m6xU8vGpeBNhH0+JV0soIrmm1e1H7koHABcZFHVNgMYLiBuXv9fMJZFDUuz/GBfrlWkX9AFqa4TO6g/uhoCwctWxZjMSb79ky0kccr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700016)(23010399003)(921020)(261028144727099003)(261022075727099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wv/d6K9TybF7t4UT3jeGNHI9pvrYzNh9R0ZRaR23REoH0zMAFF5MmKqZeovjk5jDXN8ccEIuvLYG5id7NdHx+bPvLPJRU7lIlyAB6bWxUtBzcLfZTNkABvHyqtOtLThogugebiU85CYGQ6KkGrh6cYfAwMHBdqHdaqqbH6sZD+1C/o3U3GRcYlpdOrykD7qfLWHZ9GH0DYu4Cfepm6wlbJJAsDxnVztxj5kZzdjyofdRVEPiv3m8TfyMPsTvzUC7DPSbH5aaR/i4+WWzu/rsm2TRonx59P4KjU5DQeaHHOiE3HZmdO2xl/UTYE/VYW1+j2mLSu0camKq6lfvPdIYNBj5ofi8NegxU8+ofIqigOCoPJVn20UoVk+XPWBKavGxE/7GknnTISw/C15ssn+xXXCK2H0Zavg6dzDqGTp3zHS7+Q7CfpM5gcnHEdTht98J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:43:20.2020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae7ec60-1cd4-4353-1912-08df3fbf132c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001888F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9780

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

Changes since v6
================
https://lore.kernel.org/all/20261022140425.27465-1-sarunkod@amd.com/
Patch 6:
   - Update svm->gappi_cpu = cpu before jumping to skip_wakeup_handler when
     AVIC is getting enabled. [Sashiko]
   - Remove check for wakeup_intr while adding vCPU on wakeup list. [Sashiko]

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
 arch/x86/kvm/svm/avic.c                       | 112 ++++++++++++++----
 arch/x86/kvm/svm/svm.c                        |   1 +
 arch/x86/kvm/svm/svm.h                        |   4 +
 arch/x86/kvm/vmx/common.h                     |   3 -
 arch/x86/kvm/vmx/main.c                       |   6 +
 arch/x86/kvm/vmx/posted_intr.c                |  82 +------------
 arch/x86/kvm/vmx/posted_intr.h                |   2 -
 arch/x86/kvm/vmx/tdx.c                        |   1 -
 arch/x86/kvm/vmx/vmx.c                        |  14 +--
 arch/x86/kvm/vmx/x86_ops.h                    |   1 +
 arch/x86/kvm/x86.c                            | 111 +++++++++++++++++
 drivers/iommu/amd/amd_iommu_types.h           |   6 +-
 drivers/iommu/amd/init.c                      |  38 +++++-
 drivers/iommu/amd/iommu.c                     |  66 +++++++----
 include/linux/amd-iommu.h                     |  16 ++-
 include/linux/kvm_host.h                      |  10 ++
 22 files changed, 356 insertions(+), 158 deletions(-)


base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.34.1

