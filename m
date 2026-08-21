Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A138AC7D;
	Fri, 21 Aug 2026 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291847; cv=fail; b=bPHeLRwmguLRNb6hWVdYaB6Y4HcUGAiNjWyZG51w5aj6jOafqMWEwBtgiIbnA+hDIRqC8ZiP8PfqDojYOku6CQ//u3jNc7jkvGvKYph8t+sRt05mmXvBXVTLt3t2KQYKnNftz+fZUvS9+S43IY4kjVTGgScGJzEF9sYa0TpRi/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291847; c=relaxed/simple;
	bh=ZE979SgzSzdHK5lbCapTAp8pbiKIAeJ+cVFtBVRaPNg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=to6ngY0wkaXEoV0AyFed5OXl7Z2rqIJf64R0873UPxH5JHGnI2W0EAX4HVhgDF90w/y7KCUQJ8iPSztFAG1CGWE+Iw8Tfm9O4kkgCkj0YVwjR0ue7qmCCnCkL7xRp/Co7++YzwxSi3eYnoHkzx8zlEoTUiztGR9cpR+opgw5mho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RptZREMl; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RptZREMl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIS6K5lueT5CEzoPMkfxr2HUhW9rjH40yOHXXgvmedRabLh38+lRik2etTmPZByHL578j8P2XI0oeDFDLtG+jUZ973hNpF4M1960RagO0ysUjo/SYdhR/0JpIYQFV98UsZBfgTkJxCsOj/MaD6euBjDGQySKN15W/w8Q9wtmctUzSWOUmkLSKjnJXkZ8dQsfq8XeVXW+3b17k7Nb1GlJSHdiKCxhGD9lMRFKJNJjjSCkpYZWlPCZ7CIQLVygwKwkWcFBkpGJfwOqWnYBMhGJw+sm0tdQ2nuRJKq4U2MZaCq35lM4oQFKxGuwoB2Ssfz0BsVshDMc0CLN7YYsuPOkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULMfi1SWiL1o2gTbPNEx0v44HaGwVufumEMzMjOeR8U=;
 b=Y8aLZdKm47UHIeNYSPiPuQIdZOoHo9SWZ4hzadRFZKxLAoCCPZmOgfl7gXaeCGiYjYJ4a8CpTXMd46M/lFFV8aSzgl1+RyZKsNOZu6MvWrCYcin3uOYLe+m9ZS5i6c3kOT2KN/Za6iwPURGxkNTUz2SkF8chrrLQ2ieb9xYxZOLrmefThiZEToMDfOpDaqTf4xMNoK7V5LZ+8c/QUswsbLRuFr0D2TXzpxLjIjMi6kC6KQF5ogfO12DdDOgt/G2pqQc2w9UnaoFvOBQVjUVwgxneCAdeT2cr8Zcgg8xvgC6CbX7oPrUH7LHlaD4kGKBz4l5nloXad1HISfTfFrvI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULMfi1SWiL1o2gTbPNEx0v44HaGwVufumEMzMjOeR8U=;
 b=RptZREMlQ12+MlSQxr9uq4Bj8TOnosOpImZ4lwymAj8oQVLE+LPvDDDDfIswOiPwroVAN2gdUUKsXXw/MavckPKEqCjeoUKI9NFr+1I4BmQE/ldSdqCF67jv5SVDFqi9LTlxtxj+lobFICkuitvL4OluXuBH0LylyBJZmCy28Pk=
Received: from DM6PR05CA0040.namprd05.prod.outlook.com (2603:10b6:5:335::9) by
 SAWPR12MB999268.namprd12.prod.outlook.com (2603:10b6:806:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 05:57:20 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::97) by DM6PR05CA0040.outlook.office365.com
 (2603:10b6:5:335::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 05:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 05:57:20 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 00:57:12 -0500
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
Subject: [PATCH v4 1/7] iommu/amd: KVM: SVM: Rename cpu to apicid in IOMMU interface
Date: Fri, 21 Aug 2026 11:26:05 +0530
Message-ID: <20260821055611.27138-2-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SAWPR12MB999268:EE_
X-MS-Office365-Filtering-Correlation-Id: 07be0ed4-89e3-45b7-697d-08deff49102a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ybV35XT6XWIru4lMtGiJ1Q2bH6/TmmMjBur4KHrH+EcEX2cGSzrnCfPzQYPGe1I73JnTcPj/76zQrYklhVv7Blj3bukqOoOpOAzdCymzEMZiGwsSudCdUFAPX1b2ZfC6AGdrkCficqQEKp4mm/OBvaW0G5fAH7dowvPovlrMqoBaSaP8shqVw6qYZ0WNVeo1oRXgNBxKfcr+8YffMp6DjEv+v+ATetTdTBYGXAvOIu0L6xQGuox2fgsXRef6rKBGptCChLqpSPvVKd1WFGr8b/jKA7I+3Qh5xhg/fXi+p739wbO4ANRce2A/XB4OZJgBV6N0jjFGpBMmOi/0ZED/I+rRf0tCloXsEbchaGUtYR6xMKwfN9KHNJxaRmG50x0UVsPKV6yP0Jmm4VzFCvcAWOcGJigHe39ErBIyG+DjHV5CZAjXAC+I8k06UY58004iEJbJr0m7gqzo2FXq6GHL0ixag5reUYOZKSUib6hT86N9bH/8ZGGOLY6hf9QzDR78VonKIejhcmcGSpab1BPAjjdyC4yywZaLL3sLG4UDuVlBnRwryfBVJlE0oZhvUSljaXgnllQ7ZhZCFq7pe7AtPQ3tDSK4vnNlRipRSemYSRLR8q2n6Coh9LqSm4gMECQoAG/7WOU6FlqKQKKnkEdk4f3cGdUFsiUUe+5J4CAtLmU1g6dlW6Y3pKolccw+flTFY4ZqbhtKVQjcxqsaoyHsRLTLXaQ4eM8Gkq8Ex4MBIz+GnwhCduuaoThPypLPaGFM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qHctaKj8Gvlcc9cmHpZyd5hCxwqJgGlNpjKKvR5i788iFz9Gs3nKTgJv48R3YGjj0EKjLyu2kYV4GJtyYAbM8ew1KMT9SeYskNC71N+vZ5mNLp9p2piuXgcZW8LIe6b/4eJDbVrMl683+LjkHSV7e3Gm6iheL0W1WMvx4zchW+f2zpHPf4GyYQkyClfH7B/TKfzMtblUbfX5ohaKt9Ves29geH4pf7jVEzlcDHLVZ5dRaqdF51ZJmeXxKbbH3OGh4+gLEnyTKxBJ1pBxcHypoWY1kcFEv5dM3KfL3QYIivrdiFkt8s3Xm4K3W2/O66jPblX7OTG0wsBjhOgyrtWGnwDaeffaOc9CIkHv4A4iIC1NjEjeH+7OOmA4Z1rwXtyAlJ3WIbJrLIe8/Dj7bsz89ZeHzoL3iC9rlILLnLH6YiREsuE/y1PuULo85usyhI46
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:57:20.1499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07be0ed4-89e3-45b7-697d-08deff49102a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999268

The cpu field passed from SVM to the AMD IOMMU driver does not hold a
linux CPU number. It carries the host physical APIC ID used to program
the IRTE Destination field when the target vCPU is running
(IRTE[IsRun] = 1).

Rename the field to apicid everywhere in the IOMMU interface so the
name matches the hardware semantics.

No functional change is intended.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/include/asm/irq_remapping.h |  2 +-
 arch/x86/kvm/svm/avic.c              | 12 +++++-----
 drivers/iommu/amd/iommu.c            | 35 ++++++++++++++--------------
 include/linux/amd-iommu.h            |  8 +++----
 4 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 37b94f484ef3..263f4df429d8 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -35,7 +35,7 @@ struct amd_iommu_pi_data {
 	u64 vapic_addr;		/* Physical address of the vCPU's vAPIC. */
 	u32 ga_tag;
 	u32 vector;		/* Guest vector of the interrupt */
-	int cpu;
+	int apicid;
 	bool ga_log_intr;
 	bool is_guest_mode;
 	void *ir_data;
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index cdd5a6dc646f..bccc5d7ed207 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -949,9 +949,9 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 */
 		entry = svm->avic_physical_id_entry;
 		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
-			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 		} else {
-			pi_data.cpu = -1;
+			pi_data.apicid = -1;
 			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
 		}
 
@@ -1004,7 +1004,7 @@ enum avic_vcpu_action {
 	AVIC_START_BLOCKING	= BIT(1),
 };
 
-static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
+static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
 	bool ga_log_intr = (action & AVIC_START_BLOCKING);
@@ -1024,9 +1024,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
 		void *data = irqfd->irq_bypass_data;
 
 		if (!(action & AVIC_TOGGLE_ON_OFF))
-			WARN_ON_ONCE(amd_iommu_update_ga(data, cpu, ga_log_intr));
-		else if (cpu >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, cpu, ga_log_intr));
+			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, ga_log_intr));
+		else if (apicid >= 0)
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, ga_log_intr));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 57dc8fabc7d9..c0cf7799c56e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3959,14 +3959,14 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 	.deactivate = irq_remapping_deactivate,
 };
 
-static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
+static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 				  bool ga_log_intr)
 {
-	if (cpu >= 0) {
+	if (apicid >= 0) {
 		entry->lo.fields_vapic.destination =
-					APICID_TO_IRTE_DEST_LO(cpu);
+					APICID_TO_IRTE_DEST_LO(apicid);
 		entry->hi.fields.destination =
-					APICID_TO_IRTE_DEST_HI(cpu);
+					APICID_TO_IRTE_DEST_HI(apicid);
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
@@ -3979,20 +3979,21 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
  * Update the pCPU information for an IRTE that is configured to post IRQs to
  * a vCPU, without issuing an IOMMU invalidation for the IRTE.
  *
- * If the vCPU is associated with a pCPU (@cpu >= 0), configure the Destination
- * with the pCPU's APIC ID, set IsRun, and clear GALogIntr.  If the vCPU isn't
- * associated with a pCPU (@cpu < 0), clear IsRun and set/clear GALogIntr based
- * on input from the caller (e.g. KVM only requests GALogIntr when the vCPU is
- * blocking and requires a notification wake event).  I.e. treat vCPUs that are
- * associated with a pCPU as running.  This API is intended to be used when a
- * vCPU is scheduled in/out (or stops running for any reason), to do a fast
- * update of IsRun, GALogIntr, and (conditionally) Destination.
+ * If the vCPU is associated with a pCPU (@apicid >= 0), configure the
+ * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr.  If the
+ * vCPU isn't associated with a pCPU (@apicid < 0), clear IsRun and set/clear
+ * GALogIntr based on input from the caller (e.g. KVM only requests GALogIntr
+ * when the vCPU is blocking and requires a notification wake event).  I.e.
+ * treat vCPUs that are associated with a pCPU as running.  This API is
+ * intended to be used when a vCPU is scheduled in/out (or stops running for
+ * any reason), to do a fast update of IsRun, GALogIntr, and (conditionally)
+ * Destination.
  *
  * Per the IOMMU spec, the Destination, IsRun, and GATag fields are not cached
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
+int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4006,14 +4007,14 @@ int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
 	if (!ir_data->iommu)
 		return -ENODEV;
 
-	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
 
 	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 				ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
+int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4036,7 +4037,7 @@ int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4107,7 +4108,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		if (pi_data->is_guest_mode)
-			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu,
+			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->apicid,
 							    pi_data->ga_log_intr);
 		else
 			ret = amd_iommu_deactivate_guest_mode(ir_data);
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index edcee9f5335a..2c6232aefafa 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,8 +30,8 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr);
-extern int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr);
+extern int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr);
+extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -42,12 +42,12 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
+static inline int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
 {
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
+static inline int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
 {
 	return 0;
 }
-- 
2.34.1

