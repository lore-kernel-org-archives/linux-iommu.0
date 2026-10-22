Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792678147;
	b=O2Tjd8Q0xEM5b1DVXexOAlC7wCN61gh2Fv4duarU/qdgq/LkfUL+yzqDI3mn+qSSepaU
	 15PUBRVIPJp+ymiDu8K2yVmBDF0/Hn8Ht7bsVgKKmUnFb+bsWgoe6bp02PQF36PbqJ+uB
	 StAB1MQEBlIYz9y1B3zOiNJXAEKwpyc2VdcPdxIdaGzeG7QhNHWeYrhRCTRYMYX+AemYE
	 FuUbiTj7ivbW6vVwyJjwR9lVkUbMudj1ZMZjdKN8ZgLFTVzbAa0YmXxrFZ3Vb/Jm+pFDh
	 Yn2Fq/mTJ7VdaxkHRBcWDKzn1qLVlwPgPCZ0QpkABhQ9t+YafJepzzqOvoYQwy/D8kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678147;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=UYGaNq+NFjgPBSLSOmuSWy33yyVk8tUwPVEQ4wTsfRE=;
	b=mGzht55Pos+zE7+Nt6dXv8lr3PgSX0J4dKwO//YYkODf/WDNzwot44DOexcGErJQuQ36
	 k5htQ4A2+Z/CyzSJn9EPWFcVZhPQQC/4yhY5FmFyh4gDB7tYSfnDdTd3q+BssLGdOXtrL
	 FSwgPc0mlxGiTfZ17HXkrBPEGK02eppeh0GZMMEM83b3+qEFwWOrogtO/zDdfpK/6TXEU
	 qoAr/CXXc84tEpm5Z0aKiy4X3N5hAVUQPw92D4bAo9MmDLJ8NpzvOxlXAg9JKPoBaHVZ4
	 RIYHyxT+mMLU1jzfBfphezOy8pmirs9e+W6jKYzLDuvnuaJ3pJ1nlol1H/IpChJZ0hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5Kz5Bcq8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.24
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B4606A331;
	Thu, 22 Oct 2026 14:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0B4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5Kz5Bcq8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5UgPbHYmnfi1EbAQ+EA1kA8DznLnv718+2aSqQe1R0iO3T9adTmmvTcbBDEpUVofVxO6HJ/sKOcSPTrryhf4uXCuFcFm8MEp/85N8JglCgHnRh3XAKI82kGG2kOCbM6d8urtC8LTUF3Bstfdki9JUClR4nplUCpthtcFTxgvOEGD5m1fBv4kffAZHeIXnudurCoR2nUkmL8OxI2bO/ACz2peeAy9qmCenvy2Ce33Payj8kJn7pqNCWbe5635alqWYT569Fs4Wex96GxgD9Tog8RU6EYsiH/VX2gwrQzCUiEj9PMXRKlfI49T1joowWbWJ0nsCMQEoU7uUPZWk5a9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYGaNq+NFjgPBSLSOmuSWy33yyVk8tUwPVEQ4wTsfRE=;
 b=XUMzAKxo0cieXdXlDxKKnjQj9KI8tCJuQZ29aZFCG+Vpg5XItm73qSPth7UHUwgQWrPp2a+zJ7qGZLkbZGISrU1SIn+gW+rXc5DqXKbTZPsG3cLHO57VkhL8YTqDjozPLz/9wSXpq7Nx40UnoK20oR4YSZZMNcdPzcIhLuyOziA1RkHY/PMMOWO3r5NzP5OJ4smWb8z1YwD/NZvwCwdtRzFpzTza4RN8pEp28yMdBIfHM5GiC06kGWzve7B1dhnCHQXEDseqnjuXpSiHzdOTnJNKE4kZDZpboZS/E+zPKHXfCl4zoQap1wjmf4gmKCOB2yGPGKqjTNlwSB4zmYDT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYGaNq+NFjgPBSLSOmuSWy33yyVk8tUwPVEQ4wTsfRE=;
 b=5Kz5Bcq8ddMmQ0wzsqm2ytyFnkZkAkodcgtwYS9YudFxnksKOyTs++EF9TVtYzIem/bLVdjKd0Vr1vUh+7sVhO6SgvR1Qq0NCzRKgZ+57CFRTz+4MOgLNKZAr1nz1zlaQknqRWO+FBJK0xlarpSscvcvZGQ474rwLXQbzb9XX9Q=
Received: from BN0PR04CA0119.namprd04.prod.outlook.com (2603:10b6:408:ec::34)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 14:09:01 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::69) by BN0PR04CA0119.outlook.office365.com
 (2603:10b6:408:ec::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 14:09:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 14:09:00 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 09:08:50 -0500
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
Subject: [PATCH v6 5/7] KVM: VMX: Factor out wakeup list handling code to KVM
Date: Thu, 22 Oct 2026 19:34:23 +0530
Message-ID: <20261022140425.27465-6-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022140425.27465-1-sarunkod@amd.com>
References: <20261022140425.27465-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e23ca1-6ed8-472b-73b5-08df3046059f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|7416014|376014|6133799003|18002099003|22082099003|3023799007|921020|11063799006|261021123027099003|261021121427099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	IKzlw7nO13pKvtxOIJy9Z5akgnO1M0l3tHOoUqrmlPCoL7NkNzQgPlusKaIG0X1jg1gUFd0LToIiK/KtYb02GQpfgGm1qIlNFSt0N5HX4k2MSJMak3uZDyWq4kLSMg2ArLNFQMJIp4Tq7zkKAlN+AwF4tMb6IC+UwHxRrs+pwabW5jNmfl2b0ULJlO2ruZlnc+XJ00KHflR8BD7Aha68fBiyNs4w+yx8CSq4CMEwUOkNAP0qr5nWsHIibVh0s1gL7pHBIlyyUBuF+Hw3NakaGHAJBoWuTXHzpU+uyhO6ymSUfTkMhsnseYA0QH2pauXS/B76HKmMb8x1Gu9K9uCHSmnPUjV1uX3P9g7sLsvgLs95Em5GMDh4F01mp6L3TALmeniuCVbdIWrqsgdKnnvDMvuIxDG/0qeHLT90MKRrsQP/kyVrLldBiiLoywVY82wml4nlNOhDevOnZ459CQvSl8l3r9UsmM+dLMO9lVbMDWDuBSX+Yf1+SWo/G08hfYzanEfq/0qqPCIigUuA1VfuMAqhlR7J1fzJBFCM3/iraBKs4ud1UUZyKp1BuY6cOkzWeHQL4kf5c1xumKc7WWKtSdReOMlUfix0dK4QcsEFnGZqtjEXr1YnZ4+YQ6Vi2oXzq4WIcW7fH1VChKMRqLt8fJdWZS5QtpUSL//g1d0gqPuQvAvggSIHCPP+IH2Ap9dTTSewFA7gqzpNSjuW8G4DSywkNttBaZDwcw+tGYcvH81F0fxSlYc5LJ9bpwZl3pbs
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(7416014)(376014)(6133799003)(18002099003)(22082099003)(3023799007)(921020)(11063799006)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WFTAq/serdqLuBdWBiAl8jIhQCWhhR9kueKktZNdCtE5Mm1Xr/xKpCQ5pFOXdP9sLiXPjCFfeVBuvdB2ZZLwLydAhal/pOxkai6X43MUTVSlNGsswqxpOJgZzCqSww71zjwz/eeoE3Ug6YWalDPFNMsMf4JGQkCHKYmsHqu7eZXRvQfkNDlRWKSXYIMcYMXiYaD0tWGtNFDUUQMKU1cWiayeDaKN6bYcSrxZjzs3FxmNR2gyHiThGPbHV3y+7SFHVa2GE5+tgQrhJc/vEB6tC8PJ3z11mGgSy6RdzvH4YVMjFH6FfETDbPndPQjbHqoR7gFA7IUBAnsNkfwFY0dxAIcRepPoRP6j85jhCDwmpMwOQrgmn2BxP2NiugKM6LYVmeq0ZrIuo26uRDr+fODDwY7U2qJIS93Az31xDGlu0s+zcKKD76cwH3jjTbfaAlAr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:09:00.9695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e23ca1-6ed8-472b-73b5-08df3046059f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417

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

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   1 +
 arch/x86/kvm/vmx/common.h          |   3 -
 arch/x86/kvm/vmx/main.c            |   6 ++
 arch/x86/kvm/vmx/posted_intr.c     |  82 +--------------------
 arch/x86/kvm/vmx/posted_intr.h     |   2 -
 arch/x86/kvm/vmx/tdx.c             |   1 -
 arch/x86/kvm/vmx/vmx.c             |  14 ++--
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 | 111 +++++++++++++++++++++++++++++
 include/linux/kvm_host.h           |  10 +++
 11 files changed, 139 insertions(+), 93 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e213c9ae3e30..2ca95686b93e 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -30,6 +30,7 @@ KVM_X86_OP(vcpu_reset)
 KVM_X86_OP(prepare_switch_to_guest)
 KVM_X86_OP(vcpu_load)
 KVM_X86_OP(vcpu_put)
+KVM_X86_OP_OPTIONAL_RET0(vcpu_irq_pending)
 KVM_X86_OP(update_exception_bitmap)
 KVM_X86_OP(get_msr)
 KVM_X86_OP(set_msr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a9..51ed472c5ec3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1529,6 +1529,7 @@ struct kvm_x86_ops {
 	void (*prepare_switch_to_guest)(struct kvm_vcpu *vcpu);
 	void (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
 	void (*vcpu_put)(struct kvm_vcpu *vcpu);
+	bool (*vcpu_irq_pending)(struct kvm_vcpu *vcpu);
 
 	/*
 	 * Mask of DEBUGCTL bits that are owned by the host, i.e. that need to
diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 08005676702c..5762d90a9531 100644
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
index 4c52ab8d0786..af5808eacc72 100644
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
@@ -912,6 +917,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
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
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index a4af39948cf0..7bbf00191028 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -10,8 +10,6 @@
 
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu);
-void pi_wakeup_handler(void);
-void __init pi_init_cpu(int cpu);
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 00850a3a77d6..1ba73b1379a7 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -683,7 +683,6 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 
 	fpstate_set_confidential(&vcpu->arch.guest_fpu);
 	vcpu->arch.apic->guest_apic_protected = true;
-	INIT_LIST_HEAD(&tdx->vt.pi_wakeup_list);
 
 	vcpu->arch.efer = EFER_SCE | EFER_LME | EFER_LMA | EFER_NX;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..3359f2481d77 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1587,6 +1587,13 @@ void vmx_vcpu_put(struct kvm_vcpu *vcpu)
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
@@ -7667,8 +7674,6 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	BUILD_BUG_ON(offsetof(struct vcpu_vmx, vcpu) != 0);
 	vmx = to_vmx(vcpu);
 
-	INIT_LIST_HEAD(&vmx->vt.pi_wakeup_list);
-
 	err = -ENOMEM;
 
 	vmx->vpid = allocate_vpid();
@@ -8548,8 +8553,6 @@ void vmx_migrate_timers(struct kvm_vcpu *vcpu)
 
 void vmx_hardware_unsetup(void)
 {
-	kvm_set_posted_intr_wakeup_handler(NULL);
-
 	if (nested)
 		nested_vmx_hardware_unsetup();
 }
@@ -8830,7 +8833,6 @@ __init int vmx_hardware_setup(void)
 	}
 	vmx_nested_ops.enabled = nested;
 
-	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
 
 	/*
 	 * On Intel CPUs that lack self-snoop feature, letting the guest control
@@ -8900,8 +8902,6 @@ int __init vmx_init(void)
 
 	for_each_possible_cpu(cpu) {
 		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
-
-		pi_init_cpu(cpu);
 	}
 
 	vmx_check_vmcs12_offsets();
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 054fd14bb2e1..114dd8bb48b9 100644
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
index aad065d035fb..0c637a18bcfa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -310,6 +310,27 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 
 static struct kmem_cache *x86_emulator_cache;
 
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
 static struct kmem_cache *kvm_alloc_emulator_cache(void)
 {
 	unsigned int useroffset = offsetof(struct x86_emulate_ctxt, src);
@@ -2688,6 +2709,79 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
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
@@ -7109,6 +7203,13 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
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
@@ -7175,6 +7276,7 @@ void kvm_x86_vendor_exit(void)
 	irq_work_sync(&pvclock_irq_work);
 	cancel_work_sync(&pvclock_gtod_work);
 #endif
+	kvm_set_posted_intr_wakeup_handler(NULL);
 	kvm_x86_call(hardware_unsetup)();
 	kvm_destroy_user_return_msrs();
 	kvm_mmu_vendor_module_exit();
@@ -9346,6 +9448,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	struct page *page;
 	int r;
 
+	INIT_LIST_HEAD(&vcpu->pi_wakeup_list);
+
 	vcpu->arch.last_vmentry_cpu = -1;
 	bitmap_fill(vcpu->arch.regs_avail, NR_VCPU_TOTAL_REGS);
 	bitmap_fill(vcpu->arch.regs_dirty, NR_VCPU_TOTAL_REGS);
@@ -11010,10 +11114,17 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_rmp_fault);
 
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
index c844def6dd95..a85e6e79f16b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -398,6 +398,11 @@ struct kvm_vcpu {
 	 */
 	struct kvm_memory_slot *last_used_slot;
 	u64 last_used_slot_gen;
+
+#ifdef CONFIG_X86
+	/* Used if this vCPU is waiting for PI notification wakeup. */
+	struct list_head pi_wakeup_list;
+#endif
 };
 
 /*
@@ -2651,4 +2656,9 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range);
 #endif
 
+#ifdef CONFIG_X86
+void kvm_pi_enable_wakeup_handler(struct kvm_vcpu *vcpu, int cpu);
+void kvm_pi_disable_wakeup_handler(struct kvm_vcpu *vcpu, int cpu);
+#endif
+
 #endif
-- 
2.34.1

