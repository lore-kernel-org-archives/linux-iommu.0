Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379485;
	b=YFBT/Z4fUkyBhqzu5dsl1Lnzw2tgrcP8fGRLEWl3LPompaF642ZgW25dy4e/dWLXq7Mu
	 BNs5EwNLxXY+Eqw+yawd5KKT3WAB/P7fvTnqPbHElzJl1N9Z3RofcDqQNXyjw4IdeH0vP
	 hYNlVA/TSC4RGZGTCIrzoR9PuhCq9pJ5LH1zI1mb0fa7dbnrTn1jIf+fODzF6vdRGIZVb
	 GpHYXc228xCJuAonqJ3HznrSTX5IrmGUXMAhchp9Y3FMohOYcSbFRXvUVxmxdXfEJLHfT
	 5ce/StdowoZDzghRgkypy212yEfu6zDb1+ZfCNAKUeH+Ule0SfcvNWDl0izMr2xVahQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379485;
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
	bh=sKX5PfhzlLMTZ6eXCYAR7nQ6OdLLIEMQUK/CbteoQL8=;
	b=lNgxmn2gZbh0sjzyIbpXIGUvlx2PWPwfrg6qAmz4Q3Tym0S+pmz7TKp6u4+dmBOEI/lv
	 s9O1WHzU6hHgMqFJssZNfdKl1CH/PYPI7lMgTr02AKlAYO98f3KEtLt7zbekYJNqaDbLL
	 n0k8qsDFZIxq/QP+o7H0Wo3wlP7lPHbm2SVgdIHOwjG2doiigZkrbVLjqtUaHdzd4VjNs
	 PUkleVbdNuMqg+x+jxEih6mrTa4lMgHRYcSrHdJ+qadYJE51UAvdkaFJkScJgBdhyHC73
	 HTZlZ69LhxA47D6+9QD42tsSH2cWj1Y91nNXdWFbJDR/URvx+LW6RSAsj3M/hVntO/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="E4/cuzs5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.10
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99958606A324;
	Wed, 11 Nov 2026 06:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99958606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E4/cuzs5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnVyBaHK5ZGTDDwbLMcL7MhekZkWqWOSxiUqn/cWSR2mEX45AxnO4e8axdbIWTuzQBnMB3xGcogZve1u++IOcmg1NWd4/j3SefbqOkfoqqxRzH4Y1XgTDj1dYpQfipfmupndIMZ7M9tuWsBQEKysreBgitlYj++CZJk6y7lbmDTsnW2eqPKvN1kColz+Z+GXf/5cGcAnhu6ClzuvGa5rh86wCFp8m/5MOhVHILLqczuavrUWbCE2qn539eVTn/i4+pMHucLUzAWtCIlr7T+TNMrgb+slE6O91DNUe+ovM8AC/cOHtAd5T7kYUtQBAo1I0nk53mEgCujO9ey6Grtr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKX5PfhzlLMTZ6eXCYAR7nQ6OdLLIEMQUK/CbteoQL8=;
 b=L6v3hpEnNSBfQGy9YsLSCxMaiSJ8ZxL/6o1Q8fSy59rJpul5jdoWMG3AnxiBPbjEyiziIFvyp0REUaDPRzPv94BIpYz4mz+EdOoDrxkpGImO5GlqsjLs7nsFcpeuGrFVUf9pyPwbezCRTTsyiTw4D5kw1hJLrpOzPE7E1zvsgXbU6G0TdkyK3pWeDT1qE9tPcqeZsar+aCKcrK+nQwLla9CMvWIJYl7VigJywlG11YJRuhsLiEFswGkuXJJSwvhEDxeTBnEyQZ5RB1lL1lJza5dX/VKzcockR9TWudTNILFx/vcvxKFvJDJPPg63ueV2+PgYM7h/EWWyKig6WAcpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKX5PfhzlLMTZ6eXCYAR7nQ6OdLLIEMQUK/CbteoQL8=;
 b=E4/cuzs5aRlpYVv+H4baPolCRIkccrwOIMST+Zs3NI8wbmboeGFDrPLJQ7B+6mMxu3niB1mFQT/KK1pIwwcKXKZMmVdCa9Hcs8vaJbxoUNxsb1gOfAsi5WrSZTe02QJvmkC5U1UKXXv8QQL+6cqxAK31CuIal9i6B1Lx7D+oDHo=
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:44:37 +0000
Received: from MW1PEPF00018894.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::31) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 06:44:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018894.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 06:44:37 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 00:44:27 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Ethan Nelson-Moore
	<enelsonmoore@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Layton
	<jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Karl Mehltretter
	<kmehltretter@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, Marco Elver
	<elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Will Deacon
	<will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v7 3/7] iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU interface
Date: Wed, 11 Nov 2026 12:12:38 +0530
Message-ID: <20261111064242.29336-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111064242.29336-1-sarunkod@amd.com>
References: <20261111064242.29336-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00018894:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 437c6191-de56-4ae9-612b-08df3fbf40fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|7416014|261009223027099003|10067099003|261028144727099003|261102123227099003|261102130727099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261026121527099003|261026140227099003|260925022911599003|260925021911599003|260925021311599003|56012099006|11063799006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZoXpU5tKjPKEQPz7NhxY2C0JRXx8iEkKk+4QUTbLxAY1xRZCG/W+8sCkbJt8NIDmVROSMofe82vxYzvlc/XR9IWuHdFcf9/KE4PKv4hmwHS+OjUXAKDHuYoEIohlHdh8wTcc2G5xSKnpp11rOH2HsfeFsaZYNpNuuVPiT7qj+KS53pr17cRq7fexqNt42jiGISo9AFjgBiKaAcRKGaCweSIuLVE8CJ1XYC9ruEwBvqvqbiRt0Zvkj7FSnA6jV+XtDlIyQ9sQ44AtepCPEs/50caOm3IZ4WWGqPfkM1qWncSYDNP7FkCk3jFOdyT7nQz7fAnLFdFcPI6x7FUqR6+OdZjQlutPiXITECncfdcVc+BA/EDtvfWDGh3CJ26CprO0EiMaUY8qGVLZcIQcETzRA1cmKEnRdUhqc97TBJDbzhhWNYCICH7dH8Dpd7iJjrS/GDyaaypmZ4IjSU1ZEvNIpZNi+h43+dEENSJJNCLex31EOpFbAi79ViAQlk/zyhMWhmfZrr/CK38h74KjUcCjBPNrMwExhHUzmhdT63XNFtDv0wtteqWpw9BnzrUjAdk30D2jkHtCSvxKV/51SEtX920LShiaVD0coJRmh3zEGBNyhCRtPI55IiwcjlcUHDC8pQ8fBGe0XChth7ZFNkeJsC+C3EMiPaCHWSbIGGRbvwv/exl8BLwkMdC+GfEh0lNCbZqeutONkk179z8EQy1gf53zoIKnvOrhWf/q36OW2YF3NKbvuT9jqezTzJWTBWtU
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(7416014)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261102130727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(11063799006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gus+PGf7TPpHx0R0fXCqifvcDZd8X9yY/xhcaWtH61OySVwe49e0bZc2+g120YloCoUFYgnG8GvEEyHGDwIhrUiEjtnfwtafsVaHuIPBEe5os84AmhEcvnUQcrUmnidKq516qmoE4XvprMhNdCrLCGilpDklArzsgbZwmWN+qU45O5kUpWuEEPDnYYy4rCQNCq+k0evhBnp9+mpwxfTlBtqgqtAAJvb7lXGX+OosL1qi7qSAB+IHfEU09sDFJJ8eF+4dYsfToK9pIf+e4OBI9kzEWp7caSg82c4yl+l8Pr/UE83shTpJpZI5Wj9XP0UXprDRHjxCYGUz1td5DZ42TzCZu4dtsZjEB0nWrPTQzmlqZrw1Khtr0zanLrFYrIuufw4+fBvkCehSIHAPWd/xnzbzfsMmcNbJ2j9N9MdgyusJy4c2zBy0A4JJXq24chSl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:44:37.0316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 437c6191-de56-4ae9-612b-08df3fbf40fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00018894.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187

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
index fcf23ed4ce43..c00a85b3a090 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -4054,9 +4054,9 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
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
@@ -4073,12 +4073,11 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
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
@@ -4087,7 +4086,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
+int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr, bool is_running)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4101,14 +4100,15 @@ int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
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
@@ -4131,11 +4131,16 @@ int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
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
@@ -4202,8 +4207,9 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
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
index 7253456331de..2b340f0f5b31 100644
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

