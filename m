Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379536;
	b=1Y0taax1p52LhqtmhgNaaHPgxZvn3TTQD4lu0cle15omqMDqlr501SqDCRFgmypj1TYJ
	 RG+fYqGo/xy6l5y+TbKSLhgC6FH3dU45nUmC6A5zWjyfMU548+3b47ogW+ge78AeQw4rC
	 L8N+s5I8gNljNkRwDNwUADzNv58YBSdwym8yfDrYN/UGRv+eIN4RQqF6kVpkO5/rexJ88
	 rb9rICmj/bnIyC8hPhA5yoawhPSu5S9Nv8sZa6XHlpQedy+CwdhFMwYLDMOCQFUj3GzqG
	 qPzAq4LvluMTLbGmHxMXmiq48nHSMIkFFNbqAd8A2N0bOJW/CKKcwzGUvSMaBVAw66Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379536;
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
	bh=eujETMa9Z1uBFSNxCuG8Vb+Vx1eWeH4LHoycx1RDWNs=;
	b=1Pcqwz01UTRDcamoR485QIVbXVDauUttARKfmt2sUysW5Y1wi7zFIDQcDAJBr3RIi1Fk
	 0/93Bqale0KQYPNhvyVnBuCTso+7ABI76s9vl3KNViapbFonIRPFTvaqy1FrsNbGd8hPH
	 uZ59dqdBgyin7kbJrZDA/YYdBy0e662VPz1DLclctrQarN5ydjMOBldAUqQfm2UjFa50z
	 xARMnvcusWpmfb6D27zXK6VuWidsoZau9fjg+ryegSYDp2dY6mItGWX5J/DAC6u/PEyz5
	 5QZJpvI4lTb7V8YkqaVot7eXHFbhqBsqdHUGv/4QzS0peoChhViaj75Dymwzt6vRr4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uYm3QXfr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.49
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DAA606A320;
	Wed, 11 Nov 2026 06:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52DAA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uYm3QXfr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/qaqLV2H22iq+7xDKmuoN4LhSLiC6pkpXZf3MjWnASMZL/EL1CWrptIoVGAx/vQkDkpmNHU8putIbErMUnJE3eMzc1ttBz3FrW5vSzGJtpuJ04gD0q7NcKCyuSwK7NrSO7cfb9+nHR9J6dWSa25CIS0jTrxfnGu4EXKdPRaAO3fg/C9qBi8HD0lW0QYl2J+kZIXiiGIKwKrDRLGWfEtUJKoDIGugGDjELs4oSYaLa2+hxxn14CyWr6UdhIOFyI3TXH/qrpD9eaSJ7K0LZrIfmHM71bCzpNar9dn/7S6DvtUwMCIsMPN+SdjHhEa/NSXqgzvSSm5/hnV5fsyQCK8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eujETMa9Z1uBFSNxCuG8Vb+Vx1eWeH4LHoycx1RDWNs=;
 b=S0DXDUla+tBHOHrxBjaV7/afwFMwODTN2PjDqggnEvsLZxdyRWqlD3F7I3ErBjb/xlJcb5W9HL2LUkU+O0ZTLxiIbnEGBRKo9VepXIvOzUyXtkpS8PometCRVu+A5F081DZG0idpgl5xjr4B9l7ZpytiaaSppEJlC6WLENwNtbUqxYVmiZ6VNlTfE7yXCGiGiyYeHHaZgzq+m4kHPTtPlD+hmxsZuVdfc2/8Io5ZxadblbkCUSXt2g82gM8rn9ZQTsi1+Tvb8sQ80yVifzEbleBnfvhNPBboNiqmmE0t03ToFI3R6/ZXiKHjWE9FTEDVsnyDrkkJddU2xUgPWLwd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eujETMa9Z1uBFSNxCuG8Vb+Vx1eWeH4LHoycx1RDWNs=;
 b=uYm3QXfrNjKx51hVq2OyzYSfXHMVSb/Pi+GdVfrzCoqWEFDaD9ee1jrqVdGof6Qtb2LHUPY0r2cWmO3z1XIsV+5rQjG9bBOy5L06GawH2XYQu4B7CpO2edLYBXtlR7oOeMMFegQG5AnMqskZB87o1SKAf3e4zI3IC9o8dG6QJ7A=
Received: from SJ0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:a03:33e::12)
 by LV8PR12MB9691.namprd12.prod.outlook.com (2603:10b6:408:295::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 06:45:26 +0000
Received: from MW1PEPF0001888F.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::f) by SJ0PR03CA0037.outlook.office365.com
 (2603:10b6:a03:33e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Wed,
 11 Nov 2026 06:45:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 06:45:26 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 00:45:16 -0600
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
Subject: [PATCH v7 5/7] KVM: VMX: Factor out wakeup list handling code to KVM
Date: Wed, 11 Nov 2026 12:12:40 +0530
Message-ID: <20261111064242.29336-6-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111064242.29336-1-sarunkod@amd.com>
References: <20261111064242.29336-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888F:EE_|LV8PR12MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b891e5a-99f7-408c-e223-08df3fbf5e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|921020|260925022911599003|260925021911599003|260925021311599003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102130727099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	MI0HgA64VCI1Ekb0gk+WY5z9yzLdVVk+w5LYwKEF8ABiMgFFXRX9uqYL6HzPdw6XGDDSrFyfIiCVTwvEU75SfDdcgTDBZXxErUtCvSaR1WlVoI9ajie1t25sLP3LNebfLN0BMTYH1+JmR7kH3YPxmeGcVHizh1nEJ1z9gHz4Tqa+/yx0nP3MIkgcHKGpiFA8nWzMDPt4bj35E998pr4wvYMuIONI940Dg/ri0mMy3aj2/kTT3Ut73fljRhWoSBQx76rUiuHVYpn/RyQpvPrkktnfsHHgn/eRtyUQRblFq4L1cgiABQq3U5JtAdcXu4rJcNnkoLGWiEqgxUtYXb41/vtSakKv/4DZNpXKXcHXlhOfY1IX2tckQ9hcvU2npOo3mo5qlt/gXTdhTt+o+6hQZ7EjTkiN0wQF3lEUvH56TcehT4DMrZ58T0M16/VrpjOtvycqUWUYoRjoPxq8cJqXMJHPgsjVE7Faeks58iiJsiORi7oNVo3Q57X6cndl+MGNaxIctZdnbVgB5Rjymq0ZhkHGS8ToZxB8XbAdNvAMWjtSViZPF3dR+awrxK+pFJCpGYtM3tNkRPN2KipS365HA7RnrkUu29It+pDKKHsMfIRhm+MgNhNFTRmmiRkDxjP7HhTBm1p7KH3veDJEV/ZesK0Y/kwtWIN5TLt6L1v/Hr+ut2Xsaq52nKWxfjWP/ba6omlyCMidNPpMVu0hgfXzELL7C9W9e17RLKbQ4/yQhpEFckkHGWz2WR3UYTsoJIjF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(921020)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5b5aRi8Tjc/XPoLtjWFitZVCC2AQMaIpe/ZfrdZEsSwk5x9i8GYdcZIY3rf6yZDcP/MyD1uvDocmp+JvQPVmWOCshwyHXjc9ksJGCjSB2nMEAy4pLIdZGmYF8cUch9HAdY5kuFBIVjLpqsvu+EnXoE+9bEBOfYO+6sHsZHU4usnuGKcHKTeitMl7ybCUMEKx+8l/F3hKaq8AriwSJ/3wJQ135scwcA4a0p0Hc1qYYQHRijIcXo6XpoI5e6sLirOzEb4j3NrFvLGbqlUbjAmXchBtLsfPHpGI67K6FvL2BxN457U4ZgCcsdqmBcBqVqe2gzztTDt9FgDxcYIGuHYEUl5pwGcYOnNIDhADN/cfTp0eSlgv/khFSQ3dVK+haQ7CbleWKVmtEDJT8G5/+VpjBSr6N0UN94c9R3mwSjBhPgRe+QRnkEWMzgerld2JgI6t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:45:26.0822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b891e5a-99f7-408c-e223-08df3fbf5e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001888F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9691

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
index 4dde4e3e608a..7c1f8ce7de9f 100644
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
index 1ee4b127004d..9750ace7d429 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1534,6 +1534,7 @@ struct kvm_x86_ops {
 	void (*prepare_switch_to_guest)(struct kvm_vcpu *vcpu);
 	void (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
 	void (*vcpu_put)(struct kvm_vcpu *vcpu);
+	bool (*vcpu_irq_pending)(struct kvm_vcpu *vcpu);
 
 	/*
 	 * Mask of DEBUGCTL bits that are owned by the host, i.e. that need to
diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index b2905335a2d2..c5b41e12df58 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -37,9 +37,6 @@ struct vcpu_vt {
 	/* Posted interrupt descriptor */
 	struct pi_desc pi_desc;
 
-	/* Used if this vCPU is waiting for PI notification wakeup. */
-	struct list_head pi_wakeup_list;
-
 	union vmx_exit_reason exit_reason;
 
 	unsigned long	exit_qualification;
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d75170a6199e..48a294364358 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -113,6 +113,11 @@ static void vt_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	vmx_vcpu_load(vcpu, cpu);
 }
 
+static bool vt_vcpu_irq_pending(struct kvm_vcpu *vcpu)
+{
+	return vmx_vcpu_irq_pending(vcpu);
+}
+
 static void vt_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable)
 {
 	/*
@@ -1024,6 +1029,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.prepare_switch_to_guest = vt_op(prepare_switch_to_guest),
 	.vcpu_load = vt_op(vcpu_load),
 	.vcpu_put = vt_op(vcpu_put),
+	.vcpu_irq_pending = vt_op(vcpu_irq_pending),
 
 	.HOST_OWNED_DEBUGCTL = VMX_HOST_OWNED_DEBUGCTL_BITS,
 
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 2644add54b76..e8fb494e7443 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -16,27 +16,6 @@
 
 #pragma GCC poison to_vmx
 
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
@@ -59,7 +38,6 @@ static int pi_try_set_control(struct pi_desc *pi_desc, u64 *pold, u64 new)
 void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
-	struct vcpu_vt *vt = to_vt(vcpu);
 	struct pi_desc old, new;
 	unsigned long flags;
 	unsigned int dest;
@@ -92,20 +70,7 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
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
@@ -164,28 +129,9 @@ static bool vt_can_use_vtd_pi(struct kvm *kvm)
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
 
@@ -249,30 +195,6 @@ void vt_vcpu_pi_put(struct kvm_vcpu *vcpu)
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
index c5860ea828ae..3180436049e8 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -10,8 +10,6 @@
 
 void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
 void vt_vcpu_pi_put(struct kvm_vcpu *vcpu);
-void pi_wakeup_handler(void);
-void __init pi_init_cpu(int cpu);
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int vt_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index c213c0eba919..7f44111d06cc 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -683,7 +683,6 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 
 	fpstate_set_confidential(&vcpu->arch.guest_fpu);
 	vcpu->arch.apic->guest_apic_protected = true;
-	INIT_LIST_HEAD(&tdx->vt.pi_wakeup_list);
 
 	vcpu->arch.efer = EFER_SCE | EFER_LME | EFER_LMA | EFER_NX;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 82eb891f684c..5c909069414d 100644
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
@@ -7533,8 +7540,6 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	BUILD_BUG_ON(offsetof(struct vcpu_vmx, vcpu) != 0);
 	vmx = to_vmx(vcpu);
 
-	INIT_LIST_HEAD(&vmx->vt.pi_wakeup_list);
-
 	err = -ENOMEM;
 
 	vmx->vpid = allocate_vpid();
@@ -8413,8 +8418,6 @@ void vmx_migrate_timers(struct kvm_vcpu *vcpu)
 
 void vmx_hardware_unsetup(void)
 {
-	kvm_set_posted_intr_wakeup_handler(NULL);
-
 	if (nested)
 		nested_vmx_hardware_unsetup();
 }
@@ -8695,7 +8698,6 @@ __init int vmx_hardware_setup(void)
 	}
 	vmx_nested_ops.enabled = nested;
 
-	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
 
 	/*
 	 * On Intel CPUs that lack self-snoop feature, letting the guest control
@@ -8765,8 +8767,6 @@ int __init vmx_init(void)
 
 	for_each_possible_cpu(cpu) {
 		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
-
-		pi_init_cpu(cpu);
 	}
 
 	vmx_check_vmcs12_offsets();
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index cd72684d075d..767680731c0b 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -26,6 +26,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu);
 void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_put(struct kvm_vcpu *vcpu);
+bool vmx_vcpu_irq_pending(struct kvm_vcpu *vcpu);
 int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath);
 int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff8a0..7a5cdab48ea3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -312,6 +312,27 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 
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
@@ -2699,6 +2720,79 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
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
@@ -7171,6 +7265,13 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
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
@@ -7238,6 +7339,7 @@ void kvm_x86_vendor_exit(void)
 	irq_work_sync(&pvclock_irq_work);
 	cancel_work_sync(&pvclock_gtod_work);
 #endif
+	kvm_set_posted_intr_wakeup_handler(NULL);
 	kvm_x86_call(hardware_unsetup)();
 	kvm_destroy_user_return_msrs();
 	kvm_mmu_vendor_module_exit();
@@ -9435,6 +9537,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	struct page *page;
 	int r;
 
+	INIT_LIST_HEAD(&vcpu->pi_wakeup_list);
+
 	vcpu->arch.last_vmentry_cpu = -1;
 	bitmap_fill(vcpu->arch.regs_avail, NR_VCPU_TOTAL_REGS);
 	bitmap_fill(vcpu->arch.regs_dirty, NR_VCPU_TOTAL_REGS);
@@ -11109,10 +11213,17 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_rmp_fault);
 
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
index e7fc94e2910a..9d6b4794aaa0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -402,6 +402,11 @@ struct kvm_vcpu {
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
@@ -2689,4 +2694,9 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
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

