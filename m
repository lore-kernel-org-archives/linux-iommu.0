Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA93140F759;
	Fri, 21 Aug 2026 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291872; cv=fail; b=kIWJToOdAMeKXmbd6KFgB64JmaqMavbznHxoVmI/uYEeCsj97fokDl42SQxKWzNNQxrKvOPDaX1pcxzmvAex+0NxND2UU7eZcqcFnHtg+s3X7EQsLxo2iMpXEIEpJlbcYoDVD2nPqVHQN0u6zSXdbKTRNd9Pqq9R0kxQQMTPJLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291872; c=relaxed/simple;
	bh=uOXnSKyqgtrjvsbbQakzGKckmFagyPCw2mFq74i8x1w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBIPtcjkzXpb66f9xEtf8lkaq+cWkHgmsEv+APwIAK/7QfmNrSmEjDIN3CbqFvvOulrwwxoB97UPYgWoe0xs3gLa4Wl9fEFtwqi9M/Ow0x2HXSxs/TJXXBsBnGsi2SpMi3IQnG9Jc0W+jhZRIeWlP3r4EvJu3xuH6MaAQRmeWhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fTQ4q1b0; arc=fail smtp.client-ip=52.101.57.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fTQ4q1b0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tq7W8Kve35aFfO0fFFSIh3I3KWvCBE63mQNfaDrGMCFItVeI3BnFXJkvL+bIm/n2i6OiiaAsQjYlEI1EXMrR5Gl99/aUK+UcnJdgOB+vgpUWMP62PIR50nkC9gb2+Ori9VW0kaksL9/YSV1GYv0ZRXgRjKI+e4I69RdKfcxosIJ6HKBtWyXDBz2mTyzf1Z8k2fMJegOYRbm2pJIfWJWF27jTjKMrtivJfCcy2NppBb66NHSJy1xgAE1vX2jkJ2PVT/3JK2ZtcDjrfwx2NYs+o5xN9QhOQnh+hvq4AZhjxOIEnXP1OZ7xGiklpL5YPNbInpVR2AeoJ3rckeiYeJSBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Aybnibe4u1nOdKKGbqYcGv/r3je/m+vlyy9hvom/bs=;
 b=imvzNl10BRRxWJkxNKbUBKnembM47smZdsYt3CojMgPNc1KjLfvP8Usuw9gmphDNFvch8z/mmuR/KBkP78bl501h6cAjOtbcUo3tEk0ZTZHWx62tMKwubWQ1JUWjn1SHellwpeRCNu178IvgdWYpmIWou4KGyQhAWTN6ffxcuUWtTxWybw675sF4XcP46e2N41XnCfx+8VIKJUklF6WtItm4VqWFxvT04koc1mVifgWfjOEorpLhBuR7e8utQFhNeRKFZbsdI2QnphKtU5QBHhRSd8jC+mXvzD10yJ8chqlJ6Ll32OvquUlgM5pgEg9Tp3TNw0tU+egdN8d49zfIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Aybnibe4u1nOdKKGbqYcGv/r3je/m+vlyy9hvom/bs=;
 b=fTQ4q1b0PqHufWhJsXRRfjLQbvPG0W2sN0oXqOuCbygQt7ovJYIo052PijDzX8/XTHzpuLy02n+qp8WCR4F4BVhlwBwWvQhgQx15L40ljHCvpY2VmiES4jY2AjFaeJW47v4AMxkKacJ5WlwXkbkm9xkrTMcsiM0qafE8rBQ5ChU=
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 05:57:42 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::c) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 05:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 05:57:41 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 00:57:33 -0500
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
Subject: [PATCH v4 2/7] iommu/amd: KVM: SVM: Rename ga_log_intr to wakeup_intr in IOMMU interface
Date: Fri, 21 Aug 2026 11:26:06 +0530
Message-ID: <20260821055611.27138-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821055611.27138-1-sarunkod@amd.com>
References: <20260821055611.27138-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: f677d143-a8ec-4aeb-dc36-08deff491d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	i79+dgv4j15xPqZ1MXIIVRDL7ZpH9W6hWqp6bfgmn78ElA91rSyHdwRctQ3hptDELJDCb7hUAgQs0xCxZn5KKYywtl329nKUGcIK963GUO9i36X0WKVRmkuThwaxNkEt+YayiJ3ztBVe+Yq63DKiE+8AEp7GEs9Z31/jhKigZpqJzwoBZLNsjpzMChM3a1aCfWrsdyg2osPhEHaDtFWXClJ9+GXBS/BZ8QHLlDmmSYKE3rb78k7Leg7TC04Si2PSYzQSdl9d8mmKjyrKSGlloAQ3wJeL+gZR1a1Unytx5/1pfXa+2dk2mc9I/5nruYLf0KeoVZRTa9E0kpSoVr3Kn54qwFqqJfcvo4DsEHpYjYHS9HgEgQ3yMhCbO50ttAh76BuB3v4SQ3lRWEP+GUOBxl+z3JCowCJW909jOmRFqdDfUVArmaSFby1nT0uIq3HN+UjWlf+MHOTMZ/8w5gYtcUM8lZkHXZpgYPWjxxwlPcR1NQ30smNZm79MO9vlDiA6NoecBj1DvI5+h4iOzQbqTo+FO/IyTbNQaeF8XkzyNR8439QbcPnff3DhTqyA83tUcnnyuYU/5RSVT/2JU95z1eIyt9ZDB+qAL2aIfxCbfPlcDgUSpFnxDrLd0kLJGQSm35e5Wn6xVgotHPSq1Z9J/1/w7MQ4/fU03f5SjagHHTHwNpq3IlLBQmnbVCSQqW7p3MUS+ghqYBv/9juGiX2hJ2WpwcFIXJu5Gvzh/IALSXJgVuXzgeuzS9y00tfN6SX+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6cQVYlIWK/TIRfJVaBrkau3FPezNWN/sRrSIbAPSJlee7LTNcG0d1ldVhOoylCBqfTcpDAIgqwm0wDt/uTiuv5N6/nCElBzeQYwytdt2hTNKaIQ7IYrxXVaYeoBV3pK/KCnpqmdX0rdebSr3dNfp5ljEtBCc+WCRD7Yj8rNWrAFNX2dzdFJcV46ga2hzGWM4LOD5WNjZ2nOCfZQB9prTdWTY1gXG+gyCqk8U1o/WquaCZeoWY5ghkE7wCD6I/SRkR3dw6pDM1+TP9HJFfYTIQm7V+9MgR3kFYiZ3rw39Xw2KIB0TevtcldKTvHzt6Gz3tsgT5KDQFxpFVyhmbITn9zvyzbQE/brb6h113xKD9TwjHHtPY1dll6obBCIe3g/lizByweKKMolIHBUs+ct6EY512f+X2pkVHAeiQyH10mgOGZ6B8nbWFij0aszKJWoa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:57:41.9776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f677d143-a8ec-4aeb-dc36-08deff491d36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329

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
index bcfeb5e7c0ed..add8b7274cc2 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -259,11 +259,12 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
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
index bccc5d7ed207..8e87a7f2f64f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -952,7 +952,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 		} else {
 			pi_data.apicid = -1;
-			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
+			pi_data.wakeup_intr = entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -991,15 +991,15 @@ enum avic_vcpu_action {
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
@@ -1007,7 +1007,7 @@ enum avic_vcpu_action {
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
-	bool ga_log_intr = (action & AVIC_START_BLOCKING);
+	bool wakeup_intr = (action & AVIC_START_BLOCKING);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
@@ -1024,9 +1024,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
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
@@ -1063,7 +1063,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
 	entry &= ~(AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK |
-		   AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+		   AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
 	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
@@ -1125,7 +1125,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 
 	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
 
-	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 
 	/*
 	 * Keep the previous APIC ID in the entry so that a rogue doorbell from
@@ -1137,11 +1137,11 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
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
 
@@ -1173,7 +1173,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 		 * The vCPU was preempted while blocking, ensure its IRTEs are
 		 * configured to generate GA Log Interrupts.
 		 */
-		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR))))
+		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR))))
 			return;
 	}
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c0cf7799c56e..1284f37e44c7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3960,7 +3960,7 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 };
 
 static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
-				  bool ga_log_intr)
+				  bool wakeup_intr)
 {
 	if (apicid >= 0) {
 		entry->lo.fields_vapic.destination =
@@ -3971,7 +3971,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
 		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = ga_log_intr;
+		entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
 	}
 }
 
@@ -3982,7 +3982,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * If the vCPU is associated with a pCPU (@apicid >= 0), configure the
  * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr.  If the
  * vCPU isn't associated with a pCPU (@apicid < 0), clear IsRun and set/clear
- * GALogIntr based on input from the caller (e.g. KVM only requests GALogIntr
+ * GALogIntr based on input from the caller (e.g. KVM only requests wakeup_intr
  * when the vCPU is blocking and requires a notification wake event).  I.e.
  * treat vCPUs that are associated with a pCPU as running.  This API is
  * intended to be used when a vCPU is scheduled in/out (or stops running for
@@ -3993,7 +3993,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
+int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4007,14 +4007,14 @@ int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
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
@@ -4037,7 +4037,7 @@ int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4109,7 +4109,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
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

