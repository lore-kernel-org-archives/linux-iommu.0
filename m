Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EEB286417;
	Thu, 15 Oct 2026 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046899; cv=fail; b=j6dDFsJGthjmHXeiYJbNMPMRVxWSoy3nLrLyraBmW53+GvzjBcf3FBFrEFYEq3CW0OEXcu43johSrSSv5stx59id3lvnvC7xawJ7lXAYfZersRKHM2bvrye02FRFN3GOCLt9KTAHwT8hpnIxcuI1bHEMXHLvzsCYA8eig+i/QZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046899; c=relaxed/simple;
	bh=07dFGvZjJxKoVtVRW5+d+tWv5I88RmBPcK/5IIYo/mE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QH1tf7sQElXy6Fipfc5TktrGo88hWKyGs3YCSJIy4fx0iBnTiFvG3mCjjnO79BwE1b2iuja6fR9xsGT1ETPOXZkjSsXn8nK0jgkT/8KiI7V8CZ2kzSnnIBUph9USbjo1kAHgCiZW5HJXrSAmIRFDVdC1sBgnnc0DpNl9toaWDnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K7jL1VA+; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K7jL1VA+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbcW5uyN6QxiWh4zK5djjbszQ/V52PGAx/AEtUFvgFOPcrk59OW9Kj0bg3qYqRioWY8PHMnVfcFu3kKf+wGhtuNFFI2IsqfLSQ/YopNLvbLeB72hMwISL1NLa3zSOeHrmRXNLx3p/tMbugMyo35y37huA+it++9pVRjJXuI69azrXCkhVzO9CR/gNiRudTiZtLUPeAaWndRgsWyb9sdBguxWe94HZws4coJkLiSrEOzmfP/6Hj9w4lLuXhrEt4KWVkUS2foNktpqbHeWIQCyc104IJerstRYXffWoWzARa7qSsl8Xk8wuU6AMwiXm4fENd1TNUxFs9NoCBghfbUd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YKsbe8vOAErHl63Hn0qupViR0lrrmPRVG7BkPhE2Rs=;
 b=N6Ytyz5coc8He6FMowrDtQ3hJADRoOyqlXKi3TBMDaO0uZLIheCF2TMYd3mDjEa2YwEAgrZfU/tr9s4TS8ZNO+8b8yBIqB3T3FmTuS4MB+xWDOw3c4LadzfO3TZUa7TyQU/3Pwt6y+OPxemwfYIstDCrEyBKgGxa9SGjbFtlXp3kX5aFe5njkpN+y4972eG0hTC6V/l4QgGWgUHCSp15DHR/FysAlpaz3d1lCEQLRsaZnAcvkItkN82w8ooW/ufwiUIqArMCc7imXc0POCb8hxucvMOQ8YvXCDXjI2oP/RZFr7zWRHN9IEuGWxM4PlseVf+xvNBdw/GuarAKvxkyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YKsbe8vOAErHl63Hn0qupViR0lrrmPRVG7BkPhE2Rs=;
 b=K7jL1VA+jpUEqqiAd3nVAYXKop7OPdjAtmoOIa+3dhVWWHn9m6BclJ7okaNRAjtcjvvDy5pESvnkVj8uShzSYQHb4bH1Y/T7dBJeMR1bFr3i31FDJinpz1dw/zzjnQrZ6IVtydCh5YtIHgLu9X7z0bEL6CkLsuZaDnRfkUGMz6I=
Received: from DS7P220CA0126.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::10) by
 IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Thu, 15 Oct 2026 06:48:10 +0000
Received: from DS8PEPF000000E2.namprd05.prod.outlook.com
 (2603:10b6:8:25f:cafe::3e) by DS7P220CA0126.outlook.office365.com
 (2603:10b6:8:25f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 06:48:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E2.mail.protection.outlook.com (10.167.23.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:48:10 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:47:52 -0500
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
Subject: [PATCH v5 3/7] iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU interface
Date: Thu, 15 Oct 2026 12:15:11 +0530
Message-ID: <20261015064515.10700-4-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E2:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: b63674e7-1645-47f5-0ae2-08df2a8846f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|7416014|82310400026|921020|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1e0qYNn7NSEmLj5vtxUeM/24TtD1r8IUE0lJr8+ghaJlPoODJjDKI8l8Ng4hvR+fYz/3smsviIYdPz79P8xvEwwIBhtlYAfpJimtORUa/q66vjslYSO0EiOUb3zLJ3qHZLC99Zb2D1QC5iI4Dx2tfyd5TWYoztHE0mSEPBIfHAwr6CDwuqyNr2X9n64jG1EznaPFgiHyZObQeMNMg7Q5ianDfVi+tT+Rt1IWOjotW1g8W+id4yr3VYny7lGN+pygAXrAJl2udj1eCrzfCt5bc3HOhijT19UsxrGZTEzLOo3u5uCJRI0kpu6ck7SBA0regwcE9zVMqlbv4eaS0fEb92/n2ixQPBfRVdg2n1voYtuE7JIO98N+fApmUxQv9frmnSGWuNkv07WQ3yKTE7yXclKFPhaxHlqdXSatLV9iuh7+O4mX+oQxwGszOYDujnQAk7tdo5WgT8iFv/BCPZa/D6jh9gB3t4vE8pPXTYJg9cZu7hb7y0AkZ5KXCk1KDbbbw4d+QCJyblbLPYX9TAqdFw64L44uhFuoMyot2UoRk+TlNwnhoqYEiLDu+rBBxSzJfTFTFbWaWOgM87/IJi8ONkZ/8VoRLMQF1OvmbihZ0L8wmQUpeRPPQeTHJBSuBrzyrcdNbUkL6REfpjwv81oNoqkp18V9TYmciit9H52L5v4lVkuNTvaQBLr8Z5+gqbJFszERe6BJWoSCGY6z0mIKjk/nsAGunp9Wj8im9E6Gi10IQnsJsjD0O4WBcSjffNwn
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(7416014)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bQSYG5z5MYQj0wj/8tbzWMrhyy/tXRTZW+3EAIcMOI+ZvGUX5ofqLv5GogO9bTJ5jGF60VeQ57UJgh+9RNQ7c/n6IuQwHMnjNB/zpxjtvEkVA6k8oLYaNCFJXU2ZC08QBPfTaVWBB6nFGHOBbmt3UxH6jjzd2MVllkw6FTTyi4EKVAW8s05iMKpz4fDvfyQCCMmRS+iJyTjMO7PV1T0MNzmrnmPNsLSHxq3XdrzMsU6iU5rKUWj9joajiMvUzx9ZaMbkzUsO6pp4TK6C9DGb1mZIq52o1T32R2HtcHwIiC9c5CUk1AaqPFSgFpop9cby8fJ/TXo6PGBCFIu1TE5cjRocqPWjtUUPymWweme0MKc5wPQ/5wdJa9rt5O+kZh1kHkKzrPAUZNtpCWpcN9TJC8GdlAeVY+pE1tShdYfTpa9vlc4PRe4IJkdOTM66yzWM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:48:10.3594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63674e7-1645-47f5-0ae2-08df2a8846f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

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
index edbdb5d75062..8b1fa5bded3d 100644
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
 
@@ -1035,8 +1038,8 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
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
index 878567708737..c0eec32ee3cb 100644
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
+int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
+{
+	return __amd_iommu_activate_guest_mode(data, apicid, wakeup_intr, true);
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

