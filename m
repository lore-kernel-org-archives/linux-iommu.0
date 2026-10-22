Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792678049;
	b=vhLBveBdqtgOoTuooyIpbjGlBS4WWBzmr8Na1joyWVO32e2mX6Y1Bd9z8I5Ix8cq62V6
	 9OtYWVQw5Ph2yzz5sKPAt7jMruw+d8XzmvcG+BIZfwvVlHp0WDPiBKxl2T7zKi5JlmiU0
	 pE2Tdn8+KFvX8adMtAgEqMJCBaD/3IIBUd+OHxehlx24jd1gJFEPBY3yT3Qkp1nYvw7WJ
	 UWlNjdKfrac8w2ADNrQDg5NJWiLWiFZvxEw4JDIessYEEeqwq4kx2SIMcsqqsaCpmRPBI
	 hJ/+vz63PiV6+3JKPh5zA0EQWSee+s+pdyORwkKhkpydjK1DK4Sk+tBYYj2Hhz1l7mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678049;
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
	bh=IBHfJ4PXDuKLTqODMhL17gkfZp2Hf6h78fYN5tiHzwY=;
	b=YBge8dio+aq08sgXOZtI2QGSUQhDLpargnK6sWcgFuaKeFZDLlJf5pP+xMUie3CFst3+
	 rFf735zLZQYL+lc9sc1bL/3oyJTDgm1K3krNxlrW6gRrzIzDgr5G4fcab8t+FspT19ci1
	 B/uAsNYxF6QkgBhJjM4cggAaPxPa7e4C4wexGCRJ29Lk4a880gAvVrxZwH13aJMtttSzt
	 5E3N5Vfdzj4wpBIHKufrj4vd+6JekLEkxqSGHFn6eQ6WvnSJJNUa5ODJDsm90f/sMDriB
	 EzCbVHfPKRzPyWj2Xiq1NQDNqyziiTkmZhRv1+8kz5o4S9LgbYOYXvooGMDjPQek8JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qwt0B2zg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.5
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3867606A319;
	Thu, 22 Oct 2026 14:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3867606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qwt0B2zg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT73HxlfTOaM1w6ffOXsMtu7LuULCGVyPp3+6JD9qGQbQh9wYvzqvH1BdBI0L5myMjxTJNNeXhkleB7lxR7Ttp/t26O3K5NXmBUj4PKFEqG4V8bcXUpW2cH0CyvZF7tIiWAweI5IpYq92fyUcPThTckbNC1h6Y4DeRFCY460Hbo3O2XguTc5MSpLYSLFlTdjpVQ6M2mePOf/upkUy4emWFdbTSrxbQCngIkAvUn5h3rL6yaZP9OO9mZ+jdVgaIiThpyIYhA+T+wBfh+kn0r2P+lrViICb6l5Bk7VeojkX17y0pvbl2xNPVg1+rX6rkPEFivp0c1NbbuNoLEEUDWwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBHfJ4PXDuKLTqODMhL17gkfZp2Hf6h78fYN5tiHzwY=;
 b=C2qWAY8ChQvEOZR1XLSbelH5fRzHeuC+fjVg8mHDuvJbR/blzVuDJc24wqrm6G4BbdNe9RNF0i/y7EJpjrUBGmc7FQ6vr1sTkRcWLaM/VYsIpGHqbXy0tjEg3RNVvE0Xme2IIT9RHO4IrJ07wO1CkUFru0h99TmgImNReMPzG9EgK0LYMQgzto4xIH7S+UnpjwrOXDYAdScgIlkfS0XBp98sFrXpq2Lb3q7QC73Vyz5ZbUoLoRWeTA5nsQFJK5itiVa+6cbiK7kgnfI3/1U03hNCU8/40Sh/6w9VwXVybeeuuIFU+uUMgJvJLq2j19y0vpQ8B+l0LJ3aNPTtcJvysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBHfJ4PXDuKLTqODMhL17gkfZp2Hf6h78fYN5tiHzwY=;
 b=Qwt0B2zgjFRBDiG+Iy6zPJVvoGjgxuqCU0KnJC+XqLIAl8GvDf5/NLV5cLHZUSi3ZOGMkcKtFzLxGeY/sYC0QEchmFP0zgot9yhqudFk9XFE+GRufQyk3Og/Z0HMZMcnjg/LLp7d1JmGTJML2RdFqY6tHn1iAgBOSYH+WInCNXU=
Received: from CY5PR15CA0246.namprd15.prod.outlook.com (2603:10b6:930:66::19)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 14:07:18 +0000
Received: from CY7PEPF000000F1.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::5b) by CY5PR15CA0246.outlook.office365.com
 (2603:10b6:930:66::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Thu,
 22 Oct 2026 14:07:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F1.mail.protection.outlook.com (10.167.247.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 14:07:18 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 09:07:07 -0500
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
Subject: [PATCH v6 1/7] iommu/amd: KVM: SVM: Rename cpu to apicid in IOMMU interface
Date: Thu, 22 Oct 2026 19:34:19 +0530
Message-ID: <20261022140425.27465-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022140425.27465-1-sarunkod@amd.com>
References: <20261022140425.27465-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F1:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 5595aebd-d138-4b14-417b-08df3045c853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|36860700016|376014|1800799024|82310400026|921020|261021121427099003|11063799006|56012099006|261021123027099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vJuhrb/GaCZp+fTrQCcFX78GiPKeKymcqBHDEcLGh32CdG4el3Y/i+GpXe3Fj1OSVX045894edzlyPK8Tw5N9og2mELmz+ht8E6a3Y3EScSo3xiNWsUHYZTlusQjY5zVfFebFiHpuHkDLDs7K0ZHtQLP4MPMgKller9QDKAjYc19BdT+ZVvBw+6vPGXq1pO3gLjxnRfQBovqIx99NMwggz1cehnz5h6F4vdDuYH/DSOJT8sQ8shW0ig0oOSsYaT1ATHpVuowSvcOLKgn7aOisTYkUkTCaGwIIRspicFb0/bUi3DshsM8BoQuacM1N4bCY98Kory8mDOMVqXh+TTWiIK7ek2XXqpLgec23SdL8EOQBubECh1FJqomSmF/f9V1RZio7DvJ1E3tZAtNzGdaePe3ZSxoLf7LXjbmWGQdA2PZ4vK1gonxX4EaD5lJKBdN0+QMU9K91u26JH1U3wTrLJhvi2Pm2qlDT+py4s/I6sL0PJKnZh+4rnH3pZFB0nGBdHGUZ0wIzYKt5tyGs7aQJlyEhzMz5hTIeXvyYRZCEqVzwC+M0mlBGipz9EW9PW5NtLfZ7Ba/+XXJ4f1Z6dxGBrxn1qhDs18VmZHsXD35nVxKc08kL3ss7CNRR/zqA5w7G12RoUe8Kv72GgdT5MLGUidcjw7tEI4lXlNBqEdlIoOAahc3T3m2KLiPF85sbceOJRoja+HycyrPABiR5Pr7h+HBYQQjD2QQnmQFGLv4qs2W73BgxftIV+zFmavMEZDl
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(921020)(261021121427099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8P0AdtNj9srsXecdIQWGPHEoZCGJ2xowxg9mBqv/1uWb3GzCT7xcsKpl4yfQ+2pc8j/JSjsOgjMCYO/I9bdz2wXIe7m8pAyGOGcQVcG/RynTVXHGzVGO02s+VhDBcYlxUkidg8LNFHlhkj3ZhT6GQDnkYl8o5LxwtBMIsVc6/2m6pY9Vh4PsDnqyJ2vlm3ApynfEnWWhhvT6TEDtnu9rF8yC8ogkqMfAkRpoihiT7bJHkYSe0+bUC1sY2sLifxMeZ3vk4dExRMozI15yq07U6aNU+GDqGakO4HVhchjfITeKOzEB+Zrobm5LmSK8vRtVEWb7MXTEKOTP3I8Ewn77AAt+BWwqI5YlhoYQheQ2trwDiPAitw8aDNlBkmSHJu189VJoBGuMTTGysKGzH5zoz/rdYjgoGBWRnCpJSFMRVw7kEgF5ay94Mb3x98ZXuH3n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:07:18.1087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5595aebd-d138-4b14-417b-08df3045c853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391

The cpu field passed from SVM to the AMD IOMMU driver does not hold a
linux CPU number. It carries the host physical APIC ID used to program
the IRTE Destination field when the target vCPU is running
(IRTE[IsRun] = 1).

Rename the field to apicid everywhere in the IOMMU interface so the
name matches the hardware semantics.

No functional change is intended.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
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
index 96ca39c0045f..5ac5ce4039a6 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -960,9 +960,9 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
 
@@ -1015,7 +1015,7 @@ enum avic_vcpu_action {
 	AVIC_START_BLOCKING	= BIT(1),
 };
 
-static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
+static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
 	bool ga_log_intr = (action & AVIC_START_BLOCKING);
@@ -1035,9 +1035,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
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
index 56262f6b1f70..aa9848d57f6b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3993,14 +3993,14 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
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
@@ -4013,20 +4013,21 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
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
@@ -4040,14 +4041,14 @@ int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
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
@@ -4070,7 +4071,7 @@ int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4141,7 +4142,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
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

