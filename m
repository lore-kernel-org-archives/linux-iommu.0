Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792678101;
	b=YLXB/TUJFPUOehzsqnTxfyaQ8BBPK4WXDsG6nc2hmgdEuXWL0vUiN8jB+Kk3OQv9sw74
	 X0v8KXyjY/VhBBOsXgXz9QqUiACX2owaN1whQ4jyxcqFv/Ro4nnfAjC78fXZI6J7Pbbdg
	 4LiB5IWgcF8GakHtlqHZyoR4MZ3OmkxucMpK+eIYin46omDZ3pcZu0eb7GR94WknStkhq
	 bZ8MFefTzoJtE1L6o8K64l98UIByGAquiAYvBQJEOW5+mazgEZdnYIegsVN8+Vzcp/7om
	 n63pCags8AR5qo08RJbG9QFNyIWAt/JWXzK2wTj2508MaFAzCeQ0g70R3eLGteO0o4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678101;
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
	bh=3a00eqVlMX9bHYctmzSvbHXFwMM/hdJzYQNbqCkJSSg=;
	b=skgEBW6gB6944/qxvqcmSD+eH71kdsNW1AO2V5ShKqdqv7r7hN++3/ZbTVZtWoPz8yij
	 WibWtrB1zajb75bFg7DmOvLrCz+XH/C/7mrWkU2/jZlOW48kIzP/b8e2qsFL7mdGuVxYP
	 JZ5uyyYn2wSain6m9D9h0bxJ3+z9E3ZX02vsnsLH6YzGSK74TjeoV0l8l8bF+u9WPg5PK
	 tkVnMsjZ5pZ8KHRMj4lleTubJNeKa59srAe/mlT1zce4sl9NVmZP0Mt8vocKNMxp8D7OQ
	 p+doGbG37RGXhPI0fH56VZctKmCsSk4TgZfuAUPEkjMTu7OB8CdmcbOudKb1pP33GOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0HBCXcZo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.6
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B56606A31A;
	Thu, 22 Oct 2026 14:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B56606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0HBCXcZo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkkgVozQFYMAM4C79MYf73hZtpMhSHZPM240X8y0/QljjsHd2Bbe92QhyxzqQhCtgaCNyO4+Vq4gfU9IObkHtYb9ba1e21//IiK0SA3grFP1XOLmpsHHVgJ3cS7pXpcOQ0bCUtLz8hx0awuK1esyRYM6fGWTJ4rIVw3G7ObtKFSHcQuWxL1YRyD99aR9c8YE64lLcQAah5f4iSMiHjUcJcz/4SoiK78wCxyBZegJQyZeAWfumo47jyMHivhGxYbF0AsDWal28rLAGUNC+Ta+irH81e7b4cB8IResDWSQX3zad0DFJNKn+uM+H6dL89Ked1xWdyvQqw0wmGxrPKNpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a00eqVlMX9bHYctmzSvbHXFwMM/hdJzYQNbqCkJSSg=;
 b=Ky3m6w+CcMY8WnfGsuNWBLTQ2ioNqHPVPJFbc50uOHilW2yGvXFax9WOVFDgOwNTh2ftQpUn9cp0ij6w1u2jE97RCakjUGqxX7eX+c+tjez7RUaWJLnEEEnT8VWpdgYhqO5roKiqa3OXkFV0dMpYZ4w7S7OlMelklO3SZHR63mXk+brlU2VJF0lBjuGomLwsyeMypeOoEbKeu/l7OdnxdbdpiAXhgCgh7PLywa/Ko8kQu8DZmAY5C9HczLALo0AeI4fe+EZP2CtflfhhMALfcOrkO4DU6nXSOw78lvNuo3ut3Djpi2bB3xEhU1N+FSM2pb0UyaydjSA5jVk8IAGLkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a00eqVlMX9bHYctmzSvbHXFwMM/hdJzYQNbqCkJSSg=;
 b=0HBCXcZocuBD2SKVSAX7tbXyq+NEOlo2rMYwi9NhHfwfL/vbJNFTY3FfU+9ws3MJ0n0Em4TXOnfDQ81m7evjLqYqOPMsLgE0I80l+l3mlJUMq3m1FCwh1LoCSA5qtecWXu893gUVcr025K9uoSx8DjEEKDxHY2wYmHdgQQGhgho=
Received: from DS3P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::16) by
 DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Thu, 22 Oct 2026 14:08:08 +0000
Received: from CY7PEPF000000F0.namprd05.prod.outlook.com
 (2603:10b6:8:45f:cafe::5e) by DS3P220CA0002.outlook.office365.com
 (2603:10b6:8:45f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 14:08:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F0.mail.protection.outlook.com (10.167.247.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 14:08:07 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 09:07:56 -0500
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
Subject: [PATCH v6 3/7] iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU interface
Date: Thu, 22 Oct 2026 19:34:21 +0530
Message-ID: <20261022140425.27465-4-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F0:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0aa0ec-9d27-410d-1baa-08df3045e5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|82310400026|23010399003|261021121427099003|921020|56012099006|11063799006|261009223027099003|10067099003|261021123027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WWqcKlylSkpwNFtfCILhNegQBDbzGeSWyE0+662LiTiARHWbBvdTNlD6cfulLmIumaOuZ6BA0r/F7KqF8BfdQWrmRvjOg8Kh1JGOgcaIG2qvdeCZgahH9GjNTThCn5awW++qBsUw+zUJg9Uwbso7JDNzf40qYZ0RY07tLOy5ucM9cg23hHKQmKSAnsqvLDlVMQ7qQGjZHTMaweFSTvPYunR5ZtDvDg7sGkiunqqmb5AohWsVXTQ0iBHP06qHfhdK8Tml1+qi1JwIsZwuRUwDwmfe7/7xVFRt6gH5M9NjvdVE9KtaCdAVUGFvKtgabyU2wHS8L3zT0gU8pFWbM7DQiiJRnQ8xi/TUXOhQBTszwDnKLw00Y2HaE5HaANj0Xysc1LoO6QQxVNGyjLiPae9ZvX5y2B5u/VS/zXwWJyT5OSEpJh4Q/gLT4GrMg9inSfCheeZolN+JU3Gxh2CPLL5SPI/y6C++NSYH9WprRCkac5Xw0fuCO3L0cR10Y8CreKiD1QpSQjBxMlztiCpSQLmj0UWi07TX8g1TV+Rgq1Y3mM8drgDZvyH56i6LlRJ4YQN/oxEE0cQTn71swdkSd8w6eaRCDDIXfp6ByLFeFky/I9EipD0Ppj+CwYV9TJ/FddIVE8Bl/Go8cMNWiFmIdyCn5BE6N1aeys/6uPI9NmWdpoBWw1t5xct4yPE066NpQw8R14iznQEVSSLC2fk7qszNZSCGo/sH2Q9u+D3MBHh63Ds+s3BNPKjWQKh5Gjkh4pE6
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(82310400026)(23010399003)(261021121427099003)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(261021123027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e2Otmye35+7guIxDjYaQKgsqR2BFkigj802zgQzNAQWrXdEZy3oFnaQP/RnOzwgbtGlOawER32ZWBmJaa+tKYnDvPx2fqfJBKDpSwghVLIMN8Q5lVs6Jhicuobvoa3sfxm296MqM/iM5kTXtKKqhJxGtkNNoNMvAI6mb2iNpUw/TipOFAJF7zrSRER0oJh4590ZrOjnQQjIIOam6s/cnRjNBGjBF/gFyh24Kv+y4U/Eu3qMo0yeRI74U+hB+db6dnYqLsdSDJ9lxKnLRCQMBhod240IHlXWQq1keI1q9y5Taxx3tXLThqarePKS6M3D5cVzVniw3ZlFpd2iS5Cqg2BqW/HtYIVN0Y9/Ao4j63H7waZLRWUgZOFeDnm+KdF1WYxq4lenHzy+acutfbFSAvqdxwoo9iFK2Nys5cfha+IuhtRs8LLHAsxLs1b1bKR1Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:08:07.2746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0aa0ec-9d27-410d-1baa-08df3045e5a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

Guest APIC Physical Processor Interrupt (GAPPI) is an AMD IOMMU mechanism
for notifying the host when a device interrupt targets a non-running vCPU
(IRTE[IsRun] = 0). Unlike the GA log path, GAPPI delivers a physical APIC
interrupt directly to the host CPU described by IRTE[Destination], with
the vector carried in IRTE[GATag], while still posting the interrupt into
the guest virtual APIC backing page as usual.

In GAPPI mode, the IOMMU delivers the notification to the host CPU using
the physical APIC ID in IRTE[Destination] and the vector in IRTE[GATag].
KVM must therefore supply a valid apicid even when the vCPU is not running.
The prior interface inferred running state from apicid: apicid >= 0 meant
running and apicid == -1 meant not running. That encoding breaks once
apicid carries the GAPPI destination while the vCPU is not running; the
IOMMU driver can no longer derive vCPU running state from apicid alone
and needs an explicit indication from KVM.

Add an explicit is_running indication to the IOMMU interface so that
SVM can pass vCPU running state to the IOMMU.

SVM calls amd_iommu_activate_guest_mode() only when the vCPU is running,
so keep is_running out of the exported prototype and make it a thin
wrapper that hardcodes is_running = true. The IOMMU internal caller,
amd_ir_set_vcpu_affinity(), calls __amd_iommu_activate_guest_mode()
directly and passes the running state supplied by KVM, i.e. it handles
both a running and a non-running vCPU.

No functional change is intended.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 arch/x86/include/asm/irq_remapping.h |  1 +
 arch/x86/kvm/svm/avic.c              |  9 +++++---
 drivers/iommu/amd/iommu.c            | 34 ++++++++++++++++------------
 include/linux/amd-iommu.h            | 10 ++++----
 4 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 789e3e154600..af0cdfa32c44 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -37,6 +37,7 @@ struct amd_iommu_pi_data {
 	u32 vector;		/* Guest vector of the interrupt */
 	int apicid;
 	bool wakeup_intr;
+	bool is_running;
 	bool is_guest_mode;
 	void *ir_data;
 };
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index edbdb5d75062..b975f08825ce 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -961,9 +961,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		entry = svm->avic_physical_id_entry;
 		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
 			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+			pi_data.is_running = true;
 		} else {
 			pi_data.apicid = -1;
 			pi_data.wakeup_intr = entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
+			pi_data.is_running = false;
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -1019,6 +1021,7 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
 	bool wakeup_intr = (action & AVIC_START_BLOCKING);
+	bool is_running = apicid >= 0;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
@@ -1035,9 +1038,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 		void *data = irqfd->irq_bypass_data;
 
 		if (!(action & AVIC_TOGGLE_ON_OFF))
-			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr));
-		else if (apicid >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr));
+			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr, is_running));
+		else if (is_running)
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 878567708737..099df57384e9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3994,9 +3994,9 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 };
 
 static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
-				  bool wakeup_intr)
+				  bool wakeup_intr, bool is_running)
 {
-	if (apicid >= 0) {
+	if (is_running) {
 		entry->lo.fields_vapic.destination =
 					APICID_TO_IRTE_DEST_LO(apicid);
 		entry->hi.fields.destination =
@@ -4013,12 +4013,11 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * Update the pCPU information for an IRTE that is configured to post IRQs to
  * a vCPU, without issuing an IOMMU invalidation for the IRTE.
  *
- * If the vCPU is associated with a pCPU (@apicid >= 0), configure the
- * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr.  If the
- * vCPU isn't associated with a pCPU (@apicid < 0), clear IsRun and set/clear
- * GALogIntr based on input from the caller (e.g. KVM only requests wakeup_intr
- * when the vCPU is blocking and requires a notification wake event).  I.e.
- * treat vCPUs that are associated with a pCPU as running.  This API is
+ * If the vCPU is scheduled to run on pCPU (@is_running = 1), configure the
+ * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr. If the
+ * vCPU is scheduled out (@is_running = 0), clear IsRun and set/clear GALogIntr
+ * based on input from the caller (e.g. KVM only requests wakeup_intr when the
+ * vCPU is blocking and requires a notification wake event). This API is
  * intended to be used when a vCPU is scheduled in/out (or stops running for
  * any reason), to do a fast update of IsRun, GALogIntr, and (conditionally)
  * Destination.
@@ -4027,7 +4026,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
+int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr, bool is_running)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4041,14 +4040,15 @@ int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
 	if (!ir_data->iommu)
 		return -ENODEV;
 
-	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr, is_running);
 
 	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 				ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
+static int __amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr,
+					   bool is_running)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4071,11 +4071,16 @@ int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr, is_running);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
 }
+
+int amd_iommu_activate_guest_mode(void *data, int apicid)
+{
+	return __amd_iommu_activate_guest_mode(data, apicid, false, true);
+}
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
 
 int amd_iommu_deactivate_guest_mode(void *data)
@@ -4142,8 +4147,9 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		if (pi_data->is_guest_mode)
-			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->apicid,
-							    pi_data->wakeup_intr);
+			ret = __amd_iommu_activate_guest_mode(ir_data, pi_data->apicid,
+							      pi_data->wakeup_intr,
+							      pi_data->is_running);
 		else
 			ret = amd_iommu_deactivate_guest_mode(ir_data);
 	} else {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index e20c909edc56..e07dc8efac32 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,8 +30,9 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr);
-extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr);
+extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr,
+			       bool is_running);
+extern int amd_iommu_activate_guest_mode(void *data, int apicid);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -42,12 +43,13 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
+static inline int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr,
+				      bool is_running)
 {
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
+static inline int amd_iommu_activate_guest_mode(void *data, int apicid)
 {
 	return 0;
 }
-- 
2.34.1

