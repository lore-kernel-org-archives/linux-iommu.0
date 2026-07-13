Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B03BC69C
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939954; cv=fail; b=hiRzlqTlwE1MpJjhnJ9pwe5Otj8sMEwkZgJEo487kCf/3M3DwtDvSPH2D1SjsJ8mXH/7+n+In9Usjy1ZCGOrDUcLrpkGehoZaJG5jRkZnenYD8zlExec+YFtq7YDAWwmm46j9Or5tCQRidL7fFPlVBz/0L2U/a5OJRVV3KjLiPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939954; c=relaxed/simple;
	bh=Jka5b2D+GVzr4xCyUpo6JnXbJPLBQu4rDxHDv5kfXXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byqZmjWv1h5uA238XNTRQpzsL4B9uaXianJOO9EN9aZNC4TGCK+V0yI5xa/uAGHvzn7TAaS1eR/+Q57G3fwl/Ti+yEu9iJxFT1kd3C4A/KydotDXtMXSaJejYR+Bq3JAU2sC/o6D4zFefB1bmueygkGGNloI5IfPyT1rjipLmI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o0sqAcHg; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o0sqAcHg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgl3kSbStKs8bjlm/4wGOweQ1kXuf27R9M6WfToOAyu/9leFj2VSgDxDnc2StB8gz2OHyLxSGvcJnyj+hmXYhfmjR6MUxfHHXAxIRzghu24r85rB268z20JcLKMN0Lq3OFbdyun5JYxYewHruoRFX3A/PzPgmve5Vk5tM5w9BbeHqhx8CQ90kQW/qy98K3qcjqeEdfyJcGl7rMKZ2n+wBGsp6FOkKL3FALHAvdulG4+dAuYDF3IPCILgvc67Ze/+26SwOkhoK05Es3Cf4mSbJKXz50ggbhhemFWEKR5M4dRDNPj+kkmmMVVVJPUG6kRXY8dtZpROJQuuPXx28xn4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl9B6nrSMzh+1g9/H128efocsy/zMtuil9FfIZIXy30=;
 b=scxSKcYJ1KzKyVON890gumtDubOCYMsLZzXVIBeQ50BUH+LDCdYA8cVQ5QYynFR6ne/OxZxSweoubpAMhvFUo60RySS7UElfl4tYF6m29B2k/+YIKY8ALUz1OMdhwwg4dfBAKAc5AqyueXv0qoTO33KbHpiVit3WvMa59Xgh+yo+heXgP6QsUEATC1I1ZvR0obFQ+YafKtv5PSetFK5pl/zSE1bh6b/HsNjqAmpUxe3XCpgkCg3i74HNfO3axo8t1Xqfxh/Y0MQShNqBlTn/PAeJXghdf2C7/gAZQc5dVq603rZcjlzo1EGLRZxlR1ehtu2ZkUGv/qQfHHHIL43czA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl9B6nrSMzh+1g9/H128efocsy/zMtuil9FfIZIXy30=;
 b=o0sqAcHgBAKl4pii/oqTN53jVIZJi9r2px7twzTN4RFjMsI3qYjL/Rr7WJvBu/Wt9KFf9wWtpZ/A//3sbkuKNdJ+5hUAivbuf0agW0g1J5reFObm7HWYeUTl9ONK78OUijB+3MkaNjZh7WmCFGSty3ObB7NbVkWe37OzSIiQqEM=
Received: from CH2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:59::39)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:52:22 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::9c) by CH2PR03CA0029.outlook.office365.com
 (2603:10b6:610:59::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend
 Transport; Mon, 13 Jul 2026 10:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 10:52:21 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 05:52:13 -0500
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
Subject: [RFC PATCH v3 3/6] iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU interface
Date: Mon, 13 Jul 2026 16:20:30 +0530
Message-ID: <20260713105033.15405-4-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: deff4bb8-7b8c-4a50-c995-08dee0ccd0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	PyboclhpgLlZusg98kxEnGdRXCSHujGY3OF9kkke4cK84cRZn9BUqPsLwMnStV3BVZqQKosFBjvkdzgnSAPOXJJ1b2GvLit1m6bpj2FLrRSboOxNQ6tg32cEk11UVyvOJrRb8JtN/AfkE/H3CM1APcN8zqAH5Rtk8hL7Q4kSH5lvvSgTRDs45dOnVrr2C89SjXLylc2DUAuRalzwAL/j5w8l2ubta/45czU+HAaY94XbCZVKr831uQ6TQGDf+BjMQvQCZYaf4Y52M6VNm/pSQcAXFXIA+zi7i2jAswmm1LA6Q1ZlGcUfrEiw/HvBSJ5IGddb9KtXuKIf50EwTmNhbLibchqB4u4Lme+PHITLzgiLCt0YnfOF8tD/hlgeUPRK1Pqv/ElzD/LfnqJcR4SNvF0EZDNmN7DgYbAQ9kKCQSvMlYoH70x/cY71xJK1wXxBVAUzug7wdbHXBNE7/IHt9Mf1ucSIWgXCobfieeMtnVAdeeKWKtKwg7keDq+SOaGowWYH7k9/u9/iWDFD5edK9Uaj38HKqd5iVjwc7nRN1MFG/nKUSBEARl7Kc5RTTMdvyJ2BKxEDnClyfXxVXvYs1SZvca9QdMZHdSAnThdtjLwBjrsXsxmICx6haO/Ho2y1yLS3SsRHSnxJGWzp/alz9/sIU6CdVRq87xxkolbpfALn9nxrv5F5jS3qyaWgrHu2bYhECsV2A2HvapYeCzWbooAtdZE5lUQRMn7EQFdqzW2xDsMIe4bkjwzNzhE8oz8W
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jyckrBYFrEAzqQf06/0WP+07EvbBPf3EPWJWkYQsJdEv+AZs23lwjpKvRNT0kFEySMMipv5DrfYv+zeW9uIWWbivP/E7o5KkF5iAByqzGginuNrQXTo79mEe/KK2cEoydq+ubnkxwvuj7R2rpTiu+eg0ZCEfzhfV18lzgXPctF1GbTa+TSzxHnDGXTijOP9ZYC0aypsQfms2+bVACm4H6C9vsqjUtXRV3DPOLKS5xApq+2v29Qeb8Orl1sia4gJFpnR2bADCgCGESFgxLkJlhjDUNsR14LLAaWzqzLVdCWBPlRj3ffV4NQqErXptNvSGWbqyqCNwqmt02fWP9N3x9XumP2QiHrBfKwa1zROQC79meWnwtu4qOa+LpiqPblxN60v9OalooK+vLNm/TfItq8YiIpUuFuBJTyBULg6TsGjpJYqqzYRGDNYJ8NeN38BA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:52:21.4204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deff4bb8-7b8c-4a50-c995-08dee0ccd0d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442

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

No functional change is intended.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/include/asm/irq_remapping.h |  1 +
 arch/x86/kvm/svm/avic.c              | 10 +++++++---
 drivers/iommu/amd/iommu.c            | 26 +++++++++++++-------------
 include/linux/amd-iommu.h            | 12 ++++++++----
 4 files changed, 29 insertions(+), 20 deletions(-)

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
index 8e87a7f2f64f..3b2d92a58709 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -950,9 +950,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
@@ -1008,6 +1010,7 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
 	bool wakeup_intr = (action & AVIC_START_BLOCKING);
+	bool is_running = apicid >= 0;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
@@ -1024,9 +1027,10 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 		void *data = irqfd->irq_bypass_data;
 
 		if (!(action & AVIC_TOGGLE_ON_OFF))
-			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr));
-		else if (apicid >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr));
+			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr, is_running));
+		else if (is_running)
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr,
+								   is_running));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1284f37e44c7..91405e71b3c3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3960,9 +3960,9 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
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
@@ -3979,12 +3979,11 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
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
@@ -3993,7 +3992,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
+int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr, bool is_running)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4007,14 +4006,14 @@ int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
 	if (!ir_data->iommu)
 		return -ENODEV;
 
-	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr, is_running);
 
 	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 				ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
+int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr, bool is_running)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4037,7 +4036,7 @@ int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr, is_running);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4109,7 +4108,8 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_tag = pi_data->ga_tag;
 		if (pi_data->is_guest_mode)
 			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->apicid,
-							    pi_data->wakeup_intr);
+							    pi_data->wakeup_intr,
+							    pi_data->is_running);
 		else
 			ret = amd_iommu_deactivate_guest_mode(ir_data);
 	} else {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index e20c909edc56..e962ad511d04 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,8 +30,10 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr);
-extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr);
+extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr,
+			       bool is_running);
+extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr,
+					 bool is_running);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -42,12 +44,14 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
+static inline int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr,
+				      bool is_running)
 {
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
+static inline int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr,
+						bool is_running)
 {
 	return 0;
 }
-- 
2.34.1

