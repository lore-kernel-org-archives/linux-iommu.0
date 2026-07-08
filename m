Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4751409127
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502115; cv=fail; b=FnhXwT8XdBARV8/gKecCyoQox6ifjTRhHeZ5Y/eArjWPWo5qoN2HivaYblZmgqkk41oo01zsLzLgeks7VTZ+og0bOON0L0Hld44eMaLfdySCLbDAvc66TRBZCuFkCriIi2FO+7VAJapUMYejFMXLI0jHIQ1/SDWRzruy3i9fe5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502115; c=relaxed/simple;
	bh=ePyzueXX27IVtVIRg6RHAXxNO5YpoaXWIMfcfLMeEf8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ymf0WYoVpE7dcJu9fmKVbnuwOCkGpJnvnSJAap3pPhN2E8SjeflaQP3wV3SquyxPNBkWDd3nYFTJPWoDwxq0WhTkCy6vRB7xqbq4FxpoHTclqw9urwKxKMnVA3hQfjXy5vlwZTgfblJQQb/vfcM1MoKJKUgMLxtm+7h2SAujusg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2SnUGmEb; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2SnUGmEb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5kVlquMmpKznsvkqVIcL/4BUg60tP1T/FsTpPALP4Gnzg4i+9o6Lq8C53rWIS37qVTcqGsf5k9Yy/tleQ2JxuxPgCCH5Vsq4pSn8YnqER6s6FTyYo2BzS65N2MGTUC9R+oJ3Cx1abfusk5073FLXQJxJeAk6JW5c/IKG/boy1NUUkB9Fr/B1xXiQHaSiRUqHA4H6/zPkoNKzZBCA7OwpBlUYob8p2fZ4991feDOuZehiH0AKKcCgG8VbtPYTyZFVcFR86xj/JhM+BaUjTsrgpKYQq0ipkBuQvylNncXUBaTG38VqPzp+lqxmntsl5IyDoW29U745UuUbSdKk8IQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDXKIfUnumHNKtZx89btPbMoAA0wH93YSkU/ritIDHc=;
 b=Rx59HN3n50veBCvKFJcZ1NGZS9974QUz5MaSSx18t7T5JcK6Al0MVzgfqXf/umeWFAQFLBoJxDtsrtXemzM02ES1c4Z1gkjXtzexM2iQUZGjhICMUVGKPQ6ugk/idV9FQV/iJL9RmBiiZoVMyvYNlayAUx/F6dCyt+8shRvK9/oZLAwJsxZrkDW1VtHKFDAK5H3Q1ShRgvRQUwWzPM54CDVTuo/CRgbRxjlf6GpOuGXZ2LUiUAMbFimJKyUikJ2yf0OR+OyuGLHTMUKrCaC485N0Yp2tXUbxY8AWI066mlpvDywFZlYPKWrHYf+plCAa0dgYfKLgy/7PYQq5He9Hxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDXKIfUnumHNKtZx89btPbMoAA0wH93YSkU/ritIDHc=;
 b=2SnUGmEb3oCzUeCMOyQdrju1HPWhmzOXmyn6zqwIagnEpMwcfIBTC1OggNalQZZHBl0DBbGSl4mxXJTrl4n9IwFLmGgUpSf5LQoNvDHzgZmnxdteJqYkDBKDZPt9PmxqKXOwwcGC+NKXpFIqBiI1CmLzeuuuyV8qj5rmo2JZ0ng=
Received: from MW4PR04CA0236.namprd04.prod.outlook.com (2603:10b6:303:87::31)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 09:15:06 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::9d) by MW4PR04CA0236.outlook.office365.com
 (2603:10b6:303:87::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 09:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 09:15:04 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 04:14:57 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [RFC PATCH v2 1/5] iommu/amd: kvm/svm: Improve API between SVM and AMD IOMMU
Date: Wed, 8 Jul 2026 14:44:04 +0530
Message-ID: <20260708091408.12106-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708091408.12106-1-sarunkod@amd.com>
References: <20260708091408.12106-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 810ca517-a704-4a9b-3365-08dedcd165bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|921020|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bIOuBVEaKXdeYVw5lzcg4wDxYfw+QnTKw+DdosE9YKXJj3LsxCf2lUxst9DNHvutPaIgFJFhBkMPE9ZWLdehRd8y+jdFbj4dUle+V119tcsewb5xanz5gG08zBqicG3Z18jdepuUG5zOtB6pZWf+rDzt4/Q2ezHlkzun/Ttye9WJVIlVbsyiCI/e7noWeS9lLR3sDPxQRpfegiUAp77/jMKlnMoShu8bmqw7j5pNtSgqS8zwSR1vwxwDXOWIL7qQfj923iFN4mX8XU9QPeSRL3MwsAf90lbCiKYF1ptHQNjTkCD/PbV6pr9Q0H2Wv0m9sY8UPaJzBMaJ8GWhayfMoy9YWs45A39HiMJKH/z/8r2kER/szbmmuHZGAc16bOLPeohZ9DTF2k9K5swGP61/CSsJmYEJ+s+AisEf/yxJKsGCjWbyJdHeuT24tneqaa6+YJ6PNpzZQqawf2cM3qT+VuVPdqZI2i/el1swaBOp/Pbo2a+6im7h3TZ/jqoGtFBy/qhzOybdLEVnaoltXImz1yfGR0B4ov9bKrigTqdRa0KeBWrEE0lHNe0VAYValfy0wCl6L7vzuBU/RbTXM0O7thKIPIFvdH8I0xuRikrdpKiYPAAVXN/CtTh7mbU1+1ewOT0hFBB68HKawpgLLjQr9MyUn3as++FLWJTYsVjBOCvK2yx/Jg+dq+nK3Sx8MlTcbKxGAi2CXdKmHCUBW3G2LetHLoMh6kmkac5FOETRKLbW3eAcR2vYR1iaD8l2HzI/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(921020)(18002099003)(11063799006)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U4AW/iiiPBtl75qZqrFM+pvBJMCqkF0sPs16029xh6ql8adB7tRlvBDUsdCKoRoxdLXqqFsJpMa/BxQYivTwdx0vcSa/yirSt8PlnDdDmz9MeDgoeg7AWBsKmO/TiMokH+T6xlCHPKQAVLn4Cj2QmP3K5FAA3rhuJgxbWQW60OVGrm+yw7H140hP0FHlrEDOrOgD4dn1O2RPUza3R3774G1uNWXuLJ9LkCtpopvpvk/pKFsFbztIb6WinoNywGp2ajoDEVwuykqhLOMf6zYLL0UWujjAOfQqOCp713wrWieR6PMyh8/kG2ADxqBNTzpCgjvTtmIXmN/vjQ1h7s77uA9IC/X0tE650k4iznNinXsvN98UW1qYmP1QR4z7dsM2uLzxeMzH4a3zx2TgIiSU/vLx9krjwg4oPWUatOlgTOGZzsGXXa1139GlnZ4FbSN8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:15:04.5516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810ca517-a704-4a9b-3365-08dedcd165bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

The name "cpu" in the parameter is misleading as it represents the
physical apicid of the cpu. Hence rename it.

Introduce flags to determine the state of the vCPU (running or not) and
posted interrupts. This is useful as following patch overloads the
apicid (formerly cpu) field to determine GAPPI destination when vCPU is
not running and it can no longer be used to determine if vCPU is running
or not.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/include/asm/irq_remapping.h |  4 ++--
 arch/x86/kvm/svm/avic.c              | 22 ++++++++++++++--------
 drivers/iommu/amd/iommu.c            | 24 ++++++++++++------------
 include/linux/amd-iommu.h            | 14 ++++++++++----
 4 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 37b94f484ef3..40a2206a33c0 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -35,8 +35,8 @@ struct amd_iommu_pi_data {
 	u64 vapic_addr;		/* Physical address of the vCPU's vAPIC. */
 	u32 ga_tag;
 	u32 vector;		/* Guest vector of the interrupt */
-	int cpu;
-	bool ga_log_intr;
+	int apicid;
+	int flags;
 	bool is_guest_mode;
 	void *ir_data;
 };
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index cdd5a6dc646f..7862b13c5409 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -932,6 +932,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		struct vcpu_svm *svm = to_svm(vcpu);
 		u64 entry;
 		int ret;
+		int posted_intr;
 
 		/*
 		 * Prevent the vCPU from being scheduled out or migrated until
@@ -949,10 +950,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 */
 		entry = svm->avic_physical_id_entry;
 		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
-			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+			pi_data.flags = AMD_IOMMU_FLAG_VCPU_RUNNING;
 		} else {
-			pi_data.cpu = -1;
-			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
+			posted_intr = !!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+			pi_data.flags = posted_intr << AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -1004,10 +1006,14 @@ enum avic_vcpu_action {
 	AVIC_START_BLOCKING	= BIT(1),
 };
 
-static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
+static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
-	bool ga_log_intr = (action & AVIC_START_BLOCKING);
+	int posted_intr = !!(action & AVIC_START_BLOCKING) <<
+			  AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
+	int is_vcpu_running = (apicid >= 0) <<
+			      AMD_IOMMU_FLAG_VCPU_RUNNING_SHIFT;
+	int flags = posted_intr | is_vcpu_running;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
@@ -1024,9 +1030,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
 		void *data = irqfd->irq_bypass_data;
 
 		if (!(action & AVIC_TOGGLE_ON_OFF))
-			WARN_ON_ONCE(amd_iommu_update_ga(data, cpu, ga_log_intr));
-		else if (cpu >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, cpu, ga_log_intr));
+			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, flags));
+		else if (is_vcpu_running)
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, flags));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 57dc8fabc7d9..76f0e469490e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3959,19 +3959,19 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 	.deactivate = irq_remapping_deactivate,
 };
 
-static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
-				  bool ga_log_intr)
+static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid, int flags)
 {
-	if (cpu >= 0) {
+	if (flags & AMD_IOMMU_FLAG_VCPU_RUNNING) {
 		entry->lo.fields_vapic.destination =
-					APICID_TO_IRTE_DEST_LO(cpu);
+					APICID_TO_IRTE_DEST_LO(apicid);
 		entry->hi.fields.destination =
-					APICID_TO_IRTE_DEST_HI(cpu);
+					APICID_TO_IRTE_DEST_HI(apicid);
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
 		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = ga_log_intr;
+		entry->lo.fields_vapic.ga_log_intr = !!(flags &
+							AMD_IOMMU_FLAG_POSTED_INTR);
 	}
 }
 
@@ -3992,7 +3992,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
+int amd_iommu_update_ga(void *data, int apicid, int flags)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4006,14 +4006,14 @@ int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
 	if (!ir_data->iommu)
 		return -ENODEV;
 
-	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, flags);
 
 	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 				ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
+int amd_iommu_activate_guest_mode(void *data, int apicid, int flags)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4036,7 +4036,7 @@ int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, flags);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4107,8 +4107,8 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		if (pi_data->is_guest_mode)
-			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu,
-							    pi_data->ga_log_intr);
+			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->apicid,
+							    pi_data->flags);
 		else
 			ret = amd_iommu_deactivate_guest_mode(ir_data);
 	} else {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index edcee9f5335a..3dd9074e5967 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,8 +30,8 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr);
-extern int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr);
+extern int amd_iommu_update_ga(void *data, int apicid, int flags);
+extern int amd_iommu_activate_guest_mode(void *data, int apicid, int flags);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -42,12 +42,12 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
+static inline int amd_iommu_update_ga(void *data, int apicid, int flags)
 {
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
+static inline int amd_iommu_activate_guest_mode(void *data, int apicid, int flags)
 {
 	return 0;
 }
@@ -76,4 +76,10 @@ static inline int amd_iommu_snp_disable(void) { return 0; }
 static inline bool amd_iommu_sev_tio_supported(void) { return false; }
 #endif
 
+#define AMD_IOMMU_FLAG_VCPU_RUNNING_SHIFT 0
+#define AMD_IOMMU_FLAG_VCPU_RUNNING  BIT(0)
+
+#define AMD_IOMMU_FLAG_POSTED_INTR_SHIFT 1
+#define AMD_IOMMU_FLAG_POSTED_INTR  BIT(1)
+
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
2.34.1

