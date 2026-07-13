Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052743E6DD2
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939930; cv=fail; b=X4sBSYI1ZnXLflBegkZh1DowBZCRJGHsaAeyfPrAnYciJU8DPKWHa4aaDg+O28QyupuSrO+ocqPu76x3LzWHXE1viP4ytr6zqKOFnHCuGvvixH2R+lkMA/aUJyQzwfHweaBOIzx4DUKEz7DV6JL3RVIB/OsY/iFamlJatLSr9Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939930; c=relaxed/simple;
	bh=uOXnSKyqgtrjvsbbQakzGKckmFagyPCw2mFq74i8x1w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJ6gmKOBwTdMV1WqORoN6q1nu2IKf09dkQk1nn0s9Pj5ln/7Y/LUxYfZBHWKwGqd+37ly+vKBheWf7/K1yNeanV70LecVMesbmUFTUthc4i3nT8i08+pHrSUIN1R5ro2AyMBVg6WT2e4W76+YJ3gu8l1VCOprYEjhcigwmiQ5z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C4M2FdaU; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C4M2FdaU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lG8XYHrUetvvYADeaYEtyN87UwUAPub47+ZTt0yvKN6cMf7SNoiEY7nTG4WeWWVc8vTKc81FxvwmMxXORgIfyNf3QXCyXfQbI0U5re9A5pVEzGJGWd2J1Alc9N/8/TB5SXOOSCty5V3oniS0uZA26sGnsmzoq4JoLUuu3al8VHNCfiHQ/10SmHAGH2oCbfuY3mIMcFp74ngrgbEfhKE7Mj73xcdqjqmuYZFUeU3jMAgrVsqM8Fk91XoyDDT0dvRHL6xt6m23N5Zk6fOckf6Isv/U33PUW8fpTS/c+tBgjY4Bo7ZxXMNTMk5rVxJroKkgE5Xbvoa4c+qXgjzn3zGY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Aybnibe4u1nOdKKGbqYcGv/r3je/m+vlyy9hvom/bs=;
 b=hEscM//0wPXkbBQeAuMPrLsnunw10boEdMK4Q3oqgC3wFx8Zqenf5rySnydPhR2vSQUl5PVkwWSx0OJ882+QPVh+bbDMEGSG7qZDB4vtnCS7SpRQ7SBJDWaoFp0HBQsrHrkOiFxxEAqmBBXsEYPJQ+fW2PD6bCkLTBumZinricacpqkcUYBdlknngskpkie82U1BoMdWx6KHYMY52M70hp35QBXQZ+XuD7Lp4bBwLodLx+/xP0Xcb97pK/fDb1515o/E7xLbrZQDiFaXhwBHi5jxhNrGZubvdyPDW6GUAbInWvlR0L623A3oeH6lUUu3N7KQwmWp3adFvYw3uMrfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Aybnibe4u1nOdKKGbqYcGv/r3je/m+vlyy9hvom/bs=;
 b=C4M2FdaUlcbspn5wu95Z/PlVUK8lhBxv4g7/0r7BgpFDlC1MNCwKRdj/MqyZYWv50QK1q21nLdjqfzq9b3z+ssjCeq9rFeOMRo00H56PsOedkiYsIImg88SK2mo/cFmuBYO7o17a6JWqJC9ybipYMz/y2H6unGA5+zWpWvjUVGg=
Received: from CH0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:610:cd::9)
 by DSVPR12MB999283.namprd12.prod.outlook.com (2603:10b6:8:41c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 10:52:00 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::8d) by CH0PR03CA0094.outlook.office365.com
 (2603:10b6:610:cd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 10:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 10:52:00 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 05:51:52 -0500
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
Subject: [RFC PATCH v3 2/6] iommu/amd: KVM: SVM: Rename ga_log_intr to wakeup_intr in IOMMU interface
Date: Mon, 13 Jul 2026 16:20:29 +0530
Message-ID: <20260713105033.15405-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713105033.15405-1-sarunkod@amd.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DSVPR12MB999283:EE_
X-MS-Office365-Filtering-Correlation-Id: a7756fe9-7a4f-4371-d694-08dee0ccc437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z89uihurH5BjukQwUscZ0WihPsMx9kxbVIq761a4OStccFfoxURgo0njk7l8M91c7h6yqpOjYhGz+MERTaV5BpIQrmzpRWAAvtqt1hBAsAarajaG765Kuwd0zoNRLED7rSXbUZ/jVmzHgaby1exk9FPtC0sH+MyeXFcyNPqWdoZixUQ/0H2O+4E6XAJMXacOm6GGytxvudaGuWr1ZWkQNkFiwmw1a9teNgSi8Y4z5+dF+3T3hyOF73f1Qr1cWnfBagm3Qvsmbb/rb7B1TyqxehqBPRfLVZ+N4WZlDWfNtLaA+O5rD1Nmxx76qiNxWVNUr81DkXqy6tLfvepwecoi0CrImKVolGa0fByOPQZSN7r25OTxT07BRjmcBYwGyeZAc3dHWeosJebV/cIKeomHTYXKwVZtHM0D3aTYmuu14HKDgV0g6DFKWCmp5N6v4/8mb90RD87kgyh4WGuEdhn/cnT0t3rqsKr5fgPBSeL3+zEWLd4sLFfU4D9k7Doy3T8GVYWNUwditHf4jSjH9/faGsqH7s/4cFo4k5NUK8yTPd0+oPZje6tfZ6AOmpGcDo2I/1rzCloxtjzPkyzzSvvZWSrW2fn5T+RTAgrZ6LW7Bb5bQNpg90GSzTNjxdchjUdmjf2YxOBjzpIGeES5kYM10usGQaHrKIgZjtm3ovNMh04pRus50K3T5BoZoox9IeOtlAjhd7xTVJstkGmxwcMcFMXBy+EOTUPbDb6o/FfG/vvqXLw92oGILDDSGQ0X7rtF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UgxP4Mui2mNsf0FMz+tlgz4LXZyQAMJzaUFAR6TtgvuWP9wZ82eVKRuf0eKzm8EYii6h28F5LT7n9xFuIR2eOSz+PFadGCO+2uSfhLt+d8/mo36yyYJ8zQ2e4ENlwKx57WxYJWsEovrlBDM6gumiyCkLLli3cV9daqRhlk0KUiGHu+Ifb28aThWq5au0LRkr/BzhlUx0zp4fWLte6uNDQX8AX9lx9ssPTkBLG+v2nQAjXrWW+IWY8XDJs15o6ruPljnFwhWVhidvEhD5M0NnHSZQEVD2xDPiQqZvd1FTmmjcwiUGjCuLNAU5vqSunFEEgdtHnbmHJF3AxQ5KpjctzWgryp4ANuvlHOLh/xCVwIXMJx8V8mvAr6gK6QBoPRMx1ZdRVyJGnYIa0lJE7L2O+XIZbNmBf284dDYD22gy0LjZr8u3p9UP6mcZVT1msrO+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:52:00.2803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7756fe9-7a4f-4371-d694-08dee0ccc437
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999283

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

