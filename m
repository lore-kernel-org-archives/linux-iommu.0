Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B2383312;
	Fri, 21 Aug 2026 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291889; cv=fail; b=UT/HbapK7wnZyth+oeUDbj+YjOlMDQ6dfxGD2DwVbH0FAtPsbbJ08G+1J0l24/NXazWNHFEPNyuWEDnz1ydnG3XhffxheSApevSo8xtmd8ru+HfSKl9omFSFfktELRJ3e5HxBQ8T5An7jTBerl01Q9BLpu40y8OgJCLyEC4E7xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291889; c=relaxed/simple;
	bh=/BYB73ik/2GfOmJF4OlQEuB7FwUR/utSy5Q5pxNeqlc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piRCzgVaPGT1thekljIKLpx+BILVoY6Cn6wWgec2QY/n9az7MlNsYu4Qe7MrCaFPs779413eGDiSd9VjcKMUD7g/bqv5f/IbEBV1c1++Ar+yJMFJmxQsI2v3kndLBWlVjEzvSbNJmKOh+Ca8pHvPBdDCd0Xj7nmBYMm1h0W3UUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NWai5E4v; arc=fail smtp.client-ip=52.101.57.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NWai5E4v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VILN/zXwJMugNYvInm7JRMfkMkmRm05ruq8ZF7BZWJI9C8xn/EueaT3OH+ct+04VS/7ppnNXkv0pi/MDRDXgkPWgdSVz7b/xXcan/7TaK4X8SPRIRJlixJDzlZP0crIAhnIIGHs+grLcyNCE40B2kZrMEdNIAKyRl3C6EUNM3yld7nfLI2b5qnGUQL960gNrIgxzU+Et+jgJGlGNxHst01lgS/cm3kcEEqKwY0VOWSYa0ncG4CeUg/nu5PVMzzGm0+tn1EYesLos8DpJPZz0cPxyLgA0WoKOgMn0bith7Bgyv3YULJ7/nHqWWodmvN428ZsstsQtBUhke789hchRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1+XKmtmxvbqVmPvKKU9lhn3tcIhMCIrdOG2dUmzY6Y=;
 b=NilJoulMyuvBS0CcQ5NHbtqShJB46Jh8G6wgOcsEDV9pKWulXGS+YK5rmANGICbsLYZQq5VBqm46ettY9pyXOTL0u2cctbcLqyyje13HHv6/DCVOmzeYLiZin/uLAlte8UTOm28KHUweMRHfYP692NBlWwrWxUV+uQG88Tjh+Gfd5UCZutt8rEgiNH9Sww1d4LzSXiOsfUCjGsbat42LJ3g+SqMxk3fS2zWtePFOC1O1EE5om8pEgLGkjSLoeUsx3Rf2XejKmE3wsj6NgV8xYvI70wGKQI2hkVo5zLoZI13sh77z0rBHDJxlMDZ3Sgd2hJ3ZSjAK9j47H1nUQh5x5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1+XKmtmxvbqVmPvKKU9lhn3tcIhMCIrdOG2dUmzY6Y=;
 b=NWai5E4vTmzhXjlh8/tt9p7dAyDj7+dlzfD0T12KczI648laR3GqDHl5+c9y53386oDOBvYrV4tPq9mznUpggXJ7Str2Wu4fKjIqPRqT4qNPKMCBAyi6kd79hbF1zHr0/szie44RtrsuV8Ey20E3RDQIZB9uO5TdvM5AEWr5Ers=
Received: from DS1PR03CA0009.namprd03.prod.outlook.com (2603:10b6:8:450::15)
 by LV1PR12MB999305.namprd12.prod.outlook.com (2603:10b6:408:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 05:58:03 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:8:450:cafe::3c) by DS1PR03CA0009.outlook.office365.com
 (2603:10b6:8:450::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 05:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 05:58:03 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 00:57:55 -0500
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
Subject: [PATCH v4 3/7] iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU interface
Date: Fri, 21 Aug 2026 11:26:07 +0530
Message-ID: <20260821055611.27138-4-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|LV1PR12MB999305:EE_
X-MS-Office365-Filtering-Correlation-Id: c74e9708-7d76-4a62-9888-08deff4929bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700016|1800799024|23010399003|11063799006|22082099003|18002099003|10067099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	s0ofIHACR89/5ApHRsj6cArnOFXDcCiduvzJFN2glvbDTpG3hPMrmjrQ7KHj7hTOs21vGtRH1QslJR6cUX7LCX/KrPCFzmiHYOjg0ScX7eqB/kJ/Ntdo6qUiQZKryzcmSgll31EGqvilc9lvVyyywgPX4PEK04MBk2FskujpeHNLQI9HH/B/MhM0pi5EFk3Xys6VR2e7Qk3b6HwRvjuueSYNdU03LMMNnyUQHbRRBhVuggEZF36VYyJpEFztkQDAEe1Xe7n06BwPMoGzchXUNl5nwvvypkyWYCzKyFDonWwon7nwTdpP+m1nhTSc+dBOB5ZOJiMolU1PNUfde7GjC8EOJHvJk0/KHZNWhzrRpq2+o/zMSFw3/D0oDP6E1cAfrXGtztQlLaZloy0W2cNXr/22pt4GUcOeG4b+zkaDGxf278fTB2Ppyuv+Du3pb3ABWC4hmVX8AO24UQdlnN2wPnPG3XvU3O5IOaJJeOXSgZk6DPKGkh1IJOfbhC1LgTp5qYGojiR5qUym8gMiyQmrWws4Rtkny+5hIERr2GStIi2Vmldb4QYIGAHVoCEYXbwWSGGf3DSD2pA6740vc+G7zVhGRKmk92jTyLrWEhhjJv3eSHaWQUqGYdhKGqN+L9IpW2eBi+kJOxhYQ8SDy3kKfLQYxwV4d5qGdZN6eTD01cBNb1ngexpZ2u9/LBdnmilAokpcTl01fg2WX6GlbqVKpiAbM/AXTYTyWZjj25MJpUb6zchZ6MHN2VSqqruJg+zU
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(22082099003)(18002099003)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WnMFJqDO1xFNkU5bB0IcYjxhhsp7SZ3yGuQ0dhsaUxgFT3TzJXvhU/QkpvttFGqlGNwntWLgE8UyBmpG7kJHvxlxyvosGFKh9WziH2L5RzGg1wfrNiU+bk6T9QjcdU2v0nAa0QjAAYNDYBnt576qlylpFnc8fejxIFDWlqFD9thfB7mnavApb3xBeb+4DaTn8Bu1o6ZOsESGgr6aY5Twd1ypSMzCwcN4Brq8v4DKjcZ9NDw9JVzEdA+cXRxqPmOMwI3yKzOhbwpDGYCRsLUj+1BEPtcbYKw6406Oit4bn+vc+sHhiR/OmArNWZ2RLmzsv6GTNnjIviwWqVWxCfnmNxSGnV3jOCrI28Wqs3uz7Aio2uP+gcLdp8SxZ/lMINgGaomeRTIyrNGSn9ZqKO09HGLH4pOM3qqUGZdNqIayUevqRsxKxH928rD+hRVBu03f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:58:03.0487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c74e9708-7d76-4a62-9888-08deff4929bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999305

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
---
 arch/x86/include/asm/irq_remapping.h |  1 +
 arch/x86/kvm/svm/avic.c              |  7 ++++--
 drivers/iommu/amd/iommu.c            | 34 ++++++++++++++++------------
 include/linux/amd-iommu.h            |  6 +++--
 4 files changed, 30 insertions(+), 18 deletions(-)

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
index 8e87a7f2f64f..dd497530d365 100644
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
 
@@ -1024,8 +1027,8 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 		void *data = irqfd->irq_bypass_data;
 
 		if (!(action & AVIC_TOGGLE_ON_OFF))
-			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr));
-		else if (apicid >= 0)
+			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr, is_running));
+		else if (is_running)
 			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1284f37e44c7..a5f89e93ee41 100644
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
@@ -4007,14 +4006,15 @@ int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
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
@@ -4037,11 +4037,16 @@ int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr, is_running);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
 }
+
+int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
+{
+	return __amd_iommu_activate_guest_mode(data, apicid, wakeup_intr, true);
+}
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
 
 int amd_iommu_deactivate_guest_mode(void *data)
@@ -4108,8 +4113,9 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
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
index e20c909edc56..a5f1bd6db0ee 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,7 +30,8 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr);
+extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr,
+			       bool is_running);
 extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
@@ -42,7 +43,8 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
+static inline int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr,
+				      bool is_running)
 {
 	return 0;
 }
-- 
2.34.1

