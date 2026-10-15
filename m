Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A201381E95;
	Thu, 15 Oct 2026 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046879; cv=fail; b=OHOZ4AdPAOBEDRwmUR7VNtJP7HnMXMbcwVKS7hOdGLm02LSKFNpxdikGUtXhkDvqYxQy07qc1GGTIAknEi7Sfpt/d/CZ/5iYSrtSAAw33Pg4QZdmO5JwcKRZwgQ3vOWbObR3nkRzsbArA+qEDX9Zy0gVG4Obg/8ztDHa153AgNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046879; c=relaxed/simple;
	bh=Fm1daE0yM4ECGKFNi/tGjwGZoaB6cqNYutPUlOHwufc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZvexN4PyCYfHadVQYVX77nVCZMiEDdYZ9OPIcwvrAT8W519BYL7l6zOG+y56gCmtefrIxOk5zBMRdmQiul+aOrWERkhgg9egUT2C0W5lzxbBxNbfw00dkkU7uBgPmlnFSwjmCeKfXg83h1xCuAv2mtv8Kad7tAHi1t1ORMrtkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i0ikdOqR; arc=fail smtp.client-ip=40.107.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i0ikdOqR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWlj/sc5qZ0bJsZFxqMrogmGD0pkKDq+vGDbwQujSi4bkLiq9l0URM5aW21lKsulvH0zqzCaO/M6Y3nA0LOPVqqXtYmejQqvZ90jDFv4EXN1mvs8qjA2Lt2lPOllvktOwfMkMjz0y3zD91DFR+JYrKfeM69arJ4/0I02tPBaLqGTIHJQnFNa7r9Pq8eIzBgHQQnKPI0BeLEyJJcVOCokcXZz487HM8oOAI089GzRrapnWmrvrsE6aobPUIxMRdl7mnFryxpmFvcvpkJ8uyKGp6t6ccpenDZUQ7LpZGqlDxhrr4vHS+RYChIdBiwiCTh78bif0yBfcQZKs6ONdzg3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EbvabWJf9I3k7r/Qo9ZKwG1KSZ5dYYF+AhsCrnpI9g=;
 b=OLPouoZLBJjMqcAfI26GTHkam7mCI/kSjm794LsUql/ARhPpabixTgBs6IdXlSLn+OAw7jARapvLuNi7ZWcEJF6zYY8w61pMLWNKo1x5szUfozCD5ocJxY7sdDrn1LAYAAC5j4ZoNinc7qrqoQtM8tTxES6BgVU749CxI8OSOa949U/OWdizSPwPQ70uHnJbwoqNGOZBrQbgdLbQbrhdiujtUFZWio6vLygGDOMaVBiTI3ED6b8k+/Kh49Q0a0mvs9c3ay1apXcuTY9QzZDCjIWJm12sTJvYMyg8WoAeYsg+veWcSK7sbju+y0LlWOcFSUihxGE3SGryKw6QG6LaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EbvabWJf9I3k7r/Qo9ZKwG1KSZ5dYYF+AhsCrnpI9g=;
 b=i0ikdOqRlNZ0e5lMTsUI+/uU7cRrvZ/6bJLXW/f88ri5nyl99s6j9mI6TkGu20qJ/6fcM/ZXYTr8InEJbY/42+mesAObg8ZoPYc8U6W7IR5JZqcvi982yy9tzpN1PxOxeYIlK5pPsrfYiSzQvKwsc0gXxNmHtbsR+3/xUVCHzvc=
Received: from CH2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:59::25)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 15 Oct
 2026 06:47:46 +0000
Received: from DS8PEPF000000E1.namprd05.prod.outlook.com
 (2603:10b6:610:59:cafe::97) by CH2PR03CA0015.outlook.office365.com
 (2603:10b6:610:59::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 06:47:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E1.mail.protection.outlook.com (10.167.23.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:47:45 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:47:30 -0500
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
Subject: [PATCH v5 2/7] iommu/amd: KVM: SVM: Rename ga_log_intr to wakeup_intr in IOMMU interface
Date: Thu, 15 Oct 2026 12:15:10 +0530
Message-ID: <20261015064515.10700-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015064515.10700-1-sarunkod@amd.com>
References: <20261015064515.10700-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E1:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8b393a-868f-46cc-9a62-08df2a88381a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|36860700016|82310400026|376014|10067099003|56012099006|22082099003|261009223027099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	3FphT4BDqild/1B74SK9YzK78NOr6akMTZ/B6sW6FkZEGwUgtI/RZ/jAYlV+3VeXBShXYI542iuQi32mMSNbYEHrZxLsgWsY/uy3eY7N+g/8TSIef7Zyh5/AsLAz/M5CGq+YEPE2PTLs0YKcF07TQcAxF0v4jTIvAvUmDu0qEVJX+oH7YS99iaXRbpAQ4PRGEo+HX/9EFCLXJiiHbb1DuZpgmGDV1XSyQ5uR58pvWkM0ylAXf9jpcQH+mR3fvBsCv+7X6z643YZK+Inpa5eSXJcnhOA643/Enfdk2P814h6UBwuPNQGuvBrMrZpwmr9NGQ1+bIuS2arBZ4aCYtpMQTHoMroSh+9ukXUxxI+n1DRc8reWlfZQiuMqcicD0vsjk5LhJR7pDW4mQ00X4GhRAcqqoX3cPj1vp82aBBesq3WxFcTJd/EAxuGrjN7MW45FME2EQ5pzne/nNFomaSyjkCQZznbDlmz/tRG2UszQMrxVKgaGzJbtPFEhvv+hq3FlFrreu1egPxHbuiNrv5gMgHFeHXyLeEWKEBEmxJ6KT+HCwBBgut89LAF9t4ioH8sm+9oIflDDMwBgzUuT9TmbaNsIgqrGeyPtmiwmqoRoSj0z3MJSV6mgdPGj6rwpOier1zHfrtnVjmlnb+teiXD97goUF9UVP7rZEAPdwvj4AhmXyNUbc7/dfc1t8po2byTsMAPWcutFfbgt6Mms7peoTIrVzyNgVskWIyd/WPqPQfgn/L4LIRrQ6D/6xa7EnJvb
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(22082099003)(261009223027099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oHqB5JzjLbQ6Hzn881cItNBFK0l5FYSSJL0RFjexFBKZ9BvdJ/015pQbP3hr0cH0ENzmW9kex5s1PKS6JRb+qre/0dVduZwzFoZ+ymtohLj661xJ8Xwn6fcyYP8N07BGcl3X7X2U47E0Jb40L17VY+xjtdfL2a32Zs2lHBFQWfurHm9WgURYEsG4XNke1L23KTDDO8jti0GCrAh/mGqC+B1twS2k+Yblz9zaN+iq55iTmjuulyhe2/5uYI+y7jY3K+el1diiQDCrxW9tMl/989fStb+QV2YBV2fwLmjP/nnWRbFhS8TrGbCt1yl2rn31+sCOAo4dlhMA/Y/H0FVuaGZJ6+gJA/A274bG97P1Jc6L7z6xSFXJEHOGmxZz3pZpDFGFxDPsRELNYIWdgvXVEmuv18JOaFK+syxnMUE/rQvV0rSeM0ung6rZ15OGtlKS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:47:45.4345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8b393a-868f-46cc-9a62-08df2a88381a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080

When AVIC is enabled, device interrupts are posted into the guest virtual
APIC backing page regardless of vCPU running state. When the vCPU is not
running, KVM may additionally need the IOMMU to notify the host so the
vCPU can be woken, historically via the GA log mechanism.

The existing ga_log_intr name is tied to one specific hardware mechanism.
Guest APIC Physical Processor Interrupt (GAPPI) provides an alternative
host-notification path when the vCPU is not running, i.e., IRTE[IsRun] = 0.
The KVM-side intent is the same in both cases: request host wakeup
notification while the vCPU is blocked.

Rename ga_log_intr to wakeup_intr in the IOMMU API to describe KVM's
intent rather than a single hardware knob. The IOMMU driver still maps
wakeup_intr to IRTE[GALogIntr] in this patch; GAPPI support is added in
following patches.

Similarly rename the synthetic AVIC physical ID table shadow bit from
AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR to AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR.

No functional change is intended.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 arch/x86/include/asm/irq_remapping.h |  2 +-
 arch/x86/include/asm/svm.h           |  9 +++++----
 arch/x86/kvm/svm/avic.c              | 26 +++++++++++++-------------
 drivers/iommu/amd/iommu.c            | 16 ++++++++--------
 include/linux/amd-iommu.h            |  8 ++++----
 5 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 263f4df429d8..789e3e154600 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -36,7 +36,7 @@ struct amd_iommu_pi_data {
 	u32 ga_tag;
 	u32 vector;		/* Guest vector of the interrupt */
 	int apicid;
-	bool ga_log_intr;
+	bool wakeup_intr;
 	bool is_guest_mode;
 	void *ir_data;
 };
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c..3de222d6ae15 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -260,11 +260,12 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define AVIC_LOGICAL_ID_ENTRY_VALID_MASK		(1 << 31)
 
 /*
- * GA_LOG_INTR is a synthetic flag that's never propagated to hardware-visible
- * tables.  GA_LOG_INTR is set if the vCPU needs device posted IRQs to generate
- * GA log interrupts to wake the vCPU (because it's blocking or about to block).
+ * WAKEUP_INTR is a synthetic flag that's never propagated to hardware-visible
+ * tables.  WAKEUP_INTR is set if the vCPU needs device posted IRQs to generate
+ * GA log/GAPPI interrupts to wake the vCPU (because it's blocking or about to
+ * block).
  */
-#define AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR		BIT_ULL(61)
+#define AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR		BIT_ULL(61)
 
 #define AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK	GENMASK_ULL(11, 0)
 #define AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK	GENMASK_ULL(51, 12)
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 5ac5ce4039a6..edbdb5d75062 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -963,7 +963,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 		} else {
 			pi_data.apicid = -1;
-			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
+			pi_data.wakeup_intr = entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -1002,15 +1002,15 @@ enum avic_vcpu_action {
 	 * No unique action is required to deal with a vCPU that stops/starts
 	 * running.  A vCPU that starts running by definition stops blocking as
 	 * well, and a vCPU that stops running can't have been blocking, i.e.
-	 * doesn't need to toggle GALogIntr.
+	 * doesn't need to toggle host wakeup notification.
 	 */
 	AVIC_START_RUNNING	= 0,
 	AVIC_STOP_RUNNING	= 0,
 
 	/*
-	 * When a vCPU starts blocking, KVM needs to set the GALogIntr flag
-	 * int all associated IRTEs so that KVM can wake the vCPU if an IRQ is
-	 * sent to the vCPU.
+	 * When a vCPU starts blocking, KVM needs to request host wakeup
+	 * notification in all associated IRTEs so that KVM can wake the vCPU
+	 * if an IRQ is sent to the vCPU.
 	 */
 	AVIC_START_BLOCKING	= BIT(1),
 };
@@ -1018,7 +1018,7 @@ enum avic_vcpu_action {
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
-	bool ga_log_intr = (action & AVIC_START_BLOCKING);
+	bool wakeup_intr = (action & AVIC_START_BLOCKING);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
@@ -1035,9 +1035,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 		void *data = irqfd->irq_bypass_data;
 
 		if (!(action & AVIC_TOGGLE_ON_OFF))
-			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, ga_log_intr));
+			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr));
 		else if (apicid >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, ga_log_intr));
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
 	}
@@ -1073,7 +1073,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
 	entry &= ~(AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK |
-		   AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+		   AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
 	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
@@ -1134,7 +1134,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 
 	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
 
-	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 
 	/*
 	 * Keep the previous APIC ID in the entry so that a rogue doorbell from
@@ -1146,11 +1146,11 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
 	/*
-	 * Note!  Don't set AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR in the table as
+	 * Note!  Don't set AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR in the table as
 	 * it's a synthetic flag that usurps an unused should-be-zero bit.
 	 */
 	if (action & AVIC_START_BLOCKING)
-		entry |= AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
+		entry |= AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
 
 	svm->avic_physical_id_entry = entry;
 
@@ -1182,7 +1182,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 		 * The vCPU was preempted while blocking, ensure its IRTEs are
 		 * configured to generate GA Log Interrupts.
 		 */
-		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR))))
+		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR))))
 			return;
 	}
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index aa9848d57f6b..878567708737 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3994,7 +3994,7 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 };
 
 static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
-				  bool ga_log_intr)
+				  bool wakeup_intr)
 {
 	if (apicid >= 0) {
 		entry->lo.fields_vapic.destination =
@@ -4005,7 +4005,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
 		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = ga_log_intr;
+		entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
 	}
 }
 
@@ -4016,7 +4016,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * If the vCPU is associated with a pCPU (@apicid >= 0), configure the
  * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr.  If the
  * vCPU isn't associated with a pCPU (@apicid < 0), clear IsRun and set/clear
- * GALogIntr based on input from the caller (e.g. KVM only requests GALogIntr
+ * GALogIntr based on input from the caller (e.g. KVM only requests wakeup_intr
  * when the vCPU is blocking and requires a notification wake event).  I.e.
  * treat vCPUs that are associated with a pCPU as running.  This API is
  * intended to be used when a vCPU is scheduled in/out (or stops running for
@@ -4027,7 +4027,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
+int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4041,14 +4041,14 @@ int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
 	if (!ir_data->iommu)
 		return -ENODEV;
 
-	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
 
 	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 				ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
+int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4071,7 +4071,7 @@ int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4143,7 +4143,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_tag = pi_data->ga_tag;
 		if (pi_data->is_guest_mode)
 			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->apicid,
-							    pi_data->ga_log_intr);
+							    pi_data->wakeup_intr);
 		else
 			ret = amd_iommu_deactivate_guest_mode(ir_data);
 	} else {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 2c6232aefafa..e20c909edc56 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,8 +30,8 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr);
-extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr);
+extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr);
+extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -42,12 +42,12 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
+static inline int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
 {
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
+static inline int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
 {
 	return 0;
 }
-- 
2.34.1

