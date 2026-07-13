Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A3340401
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939907; cv=fail; b=SBfENgexhI4oo72GgbTNi7S3oS7vrDlgLXWxzbAms1XUWSedLHSajOZu/WITly/9+qbye5SjGVo0GH6exH9a1H2hqTVfedxH4qNyP8dyYeHl8/MuumhjF5AFRErFspEBZvJuVgfA8OassYeByCr0S9fpcVkarZCNdz1Kh2+/nM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939907; c=relaxed/simple;
	bh=ZE979SgzSzdHK5lbCapTAp8pbiKIAeJ+cVFtBVRaPNg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPFkyG/65GgyAQUwUgDb+PG1YuCNwRcHgXKXM5Q7MqBRRWddcxOffpE3rdkeryXVUFkWCJX9pUA5TmdB0MJ90wtc3SSpA7QqJGxf/XLFL2YttZKIn9EB0nf0mb3AAaaqBYnxpda48wo1ZHSCwaYmIZrCYpvrPNnw29GfSuZ5ktg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fEEsiGxo; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fEEsiGxo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyAZnydfZvfaJCBtAq8cKC9+Dqu6zvSLvAnVTk/aJhvm2ziqMEHImDtuB/JgqEa34ShEl9n8liHgRnxRW88xM0ZyS8fqNZERCw0dSQZ6CYdQEowd6bZ/n23NYKao52bJlPgiwEnoquab1IsD7Iza7Ll8YqXZhF2y8vKWrqv24R+Zua1iB0q97grxRzlcJR52QILeEzrqgtaRBFCFhRTXz9fbU6FYKXUDiRBMPvq5zrU6X7PHYmBFiYbhXzmBVSDssiHUrd1bm5NKBZ5JkibRPcU4azUAaJEwj4GjhOcd1zpzvvIF/7weW2uAkP9ZzJr1rETcamr0mMSwvH28//XFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULMfi1SWiL1o2gTbPNEx0v44HaGwVufumEMzMjOeR8U=;
 b=IzyXB2udr8nCdnB+gX1lPoNexYaoalr/h8EMJsIdT3X9vY0fVHqDW/AVY3sOi+9rhu+PdYYSV5HZ/2pgif30gF3fnDfyTnyVpXw+djyNdR7xn6iN7497rhOeUq1VTHLYzv4Svy3gzF8CdIZvL2nyexiQkNiZY648NUKHCRxyvQtjkDenh3tCHSqQCzPJsjCOUAJNrFweVqmuvYjAPuW087HnykemWC9gWto91LUzvrI5f5T9Bm9Uq6aGcuwQ0G9/+5syn1GNkZOyKhaC1i7ahyhilFSHS1w3E17Z7ywo4vK8d18EOKpc2pqP9K9hdNBLNzk21ULQQUcTSFBiLMKyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULMfi1SWiL1o2gTbPNEx0v44HaGwVufumEMzMjOeR8U=;
 b=fEEsiGxoT8LwzLMPKOh8YVADapuVXitStzh1zHFB+I2aIJBooqdZLsRkeZdGGIdQiy289/lpgyUYMJj6j3b7hRZuI2DH41PQGSbvLNAf8qlEU60Eg/JXMzAhbAso+G0SaBAadgN8riAJxNOWIM770/QZcOHvPwuNAV5XDMCQwTg=
Received: from CH0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:610:cd::17)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:51:34 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::16) by CH0PR03CA0102.outlook.office365.com
 (2603:10b6:610:cd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend
 Transport; Mon, 13 Jul 2026 10:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 10:51:33 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 05:51:26 -0500
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
Subject: [RFC PATCH v3 1/6] iommu/amd: KVM: SVM: Rename cpu to apicid in IOMMU interface
Date: Mon, 13 Jul 2026 16:20:28 +0530
Message-ID: <20260713105033.15405-2-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: 17061b1d-00db-486c-b582-08dee0ccb48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	giMU6f4qt0p1uoMgGKglddSbdZoYuh/TeyG2qnA8DDlqXaS4KhPJHaWMqJoF29cPTM6VtM+8fsJvzqQoZAlToRBoJ67alY06k1I9i80VYeLR8gP+gLg0PeCZMgscfOAuLbfNtJ6F4t62HmIDXsRz5lg1+mtYGFGRwLbaWOScsxFVJqGMcE6KbyEihl+rhfZ0djdw9FoJHCz9OXUdJ8uG2HIAGd1ks4ArlOXKczuJUlkz5nmXu/s0vRzS02Dq6vSdoPB/jDXAzCM2KnHYWIzukSqLC/lNitn6ObNoXH2+2gr0LTgfXaNOzIikyMM4673BUFru6UHTecfBZu5UK2cB0hxYUj6+fXceN1abkOV4cs4GDB/pme6clLSzOGpv4PBn8uJH/+/CCQz10bQw2yRqxl8L/vGN8CwtLuPrvRbj3xfFdCkPL93bhyv93afKTh5VniFEO46e8p2D/ebRCZHfCzCTjKW99QIs2jyiMesu8ZlIJ9Bn9V8wwUiTjnng3mDBA1qFn+W9UgSp0HlBp5Y1yjhOyuilgUifFlcEI26rNPAyqAAkixMOXKKpU4LHiybEvHVTLRr9xiwtwPnnOxxMITPrifd/aOvrLP76KLLLz7qVXHz440dhT2xCRwg65SSv4qlQOiiCGXPSIVd367E6bQ40L3Bx0k9w9ZV5PWFAHlUg4Bg+mMvj+pTccKP9RjqN2v5V4aaJxP0Lq/kskfU//PU21242fUylvWDy0W6qDwQywEyuA8THuWfvFAli4bb+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nR9P07yFVlxbLvF+P+bqy2JtI9qmAWOicG7KLBTQ6aLK8oAULHuKDa6KmwhW3UdGkNySRCtPK6NA9ZX2A/twDtL/TfFpk+wGkewyUyo3xD6kFk6agG0FenZEmpdZbnjlH83YU8IBzhBaPt42xVPlB6DLoU7Oy8NL0MZxDyrlTrV7pDt15bn7xm3wivP4lhePC1Lx+8T8ke1U+Iz7Sqmt7ElEprIA2STlMFd3t3fJfeKmGH3YyvGQWN/45XvM6eQ8DlOxre/xm88pMm1+ODQN+BsMn27bw6k/6XKR1MKl+0gdGLDDQQwruceo+krdw7GpB7ajfaXmqdaDxLTvXAeRe5JLSyX4mYVcuWr1ME/7J7hVHwjLo3ajtjPTMaSva4teE9/A6i1KggjsnMYv2+ntDSzrZpGshEqr2qDlTkpb6X8gL8FXrgj/31O4vX3rvgfv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:51:33.9996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17061b1d-00db-486c-b582-08dee0ccb48d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797

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

