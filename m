Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792678070;
	b=3yny9TRZEFKQEOhmY/KHIqGtXaa5HhYAxVFHOVxAHxqSCGIwu44a0xPb6N5dze3O22c3
	 iAELfdsUHNisuCcR/0gdee9NZRaagcCdNkJUmRTJACRB1z/1OXAKtlPLoQZFQGAFlMADx
	 zFGsZHkb778nncflZcrNCKvo2vyn1igTftUkEtIkoLXobgI7fmkT97tUEgGaXftdXYRG7
	 zrSNsbpdBlw5X3+o8FI/8q1VtJnNN53CjYib/wSTG0AbSceBlRuT0ZF1ahtOUJh3HbCtF
	 xMAMOxFelTfGtdNvAGh6oqo+hNjj35DVG47IfhM+SfaBobpsuEtefL822HbJmlZsrig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678070;
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
	bh=1EbvabWJf9I3k7r/Qo9ZKwG1KSZ5dYYF+AhsCrnpI9g=;
	b=1nGXcI/dJqLnHoqjjDEXdI9MWs2L61vMe4bf9tAOR0uJWOv7/3IDhEX0pOwbgVXuxqUY
	 aZjHWkvxJpCQLQoe1BQJ5HZYQUQC8up05norAO2hZUcGGH0/x2ciigMl588yhmIaur8Se
	 jueAWdXp7rgZ20fJl/RgMXoWVCIY6bTAfbDQ8XSC2XUbmERDDisHL6I8kws2C9iJFQD6j
	 SJamo9xpUfwtGgE7VDYgSRPqpefySRkXlNT9OkCkD/9Uopepk82UfXyH7pSWS+fllrr+O
	 w29OJ9rA1dF2UmVqxjV/C+QoglwtpmmlIZ3QyR8bRBxnxwZODBGXgKeCvGxxBaNA+xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VaUSdA6y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.0
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99C606A328;
	Thu, 22 Oct 2026 14:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB99C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VaUSdA6y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kzw467umIlXaVt9vfLq7fauuIoGW61NMPfhF1WKvtnsYlDUV1w8T8MxjsUHtSRUvbgTLji/4QoGR+YSCjwTsnur3yMliS+p7tgwVJ87gaoTO9j3nwhysuHuf1sT65josTGvCGIb4a3GvJLdRqZrK9UShhGJRvwEmfkgUyopP7qG15kgfreXHipb4KLF1k4VdvPRdyGX2+JJXNbftYD+FBKS8P5fQqdPagEgRGQnP9qA+PNUT/N8jVHVY1hVtfB6ym8v/KfCX2+I+BCZeAwRYKFZuWInUB752Px1Iw0nq+waTvDHQ99ca4c28aaner+AJKPg/pQKgCmIErw2X7Fa5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EbvabWJf9I3k7r/Qo9ZKwG1KSZ5dYYF+AhsCrnpI9g=;
 b=f1tfrMvEtq5euJ8DNPE1Ua6SEdEqdqsvkXdAk5KVGYweyo3YDn/YvpyrfLQwAPQQpBFObgZUXuv0A7o7MYZKZttU7p9/w1gJC3/RGrcUcQkxw73LNnnjZLVqai1zvxxp/6GHGP9xHJgl80POHHfBbxViqmVGWaO8FsRJlWlFFo5RfPkxD2bE3JmUXqE0Hiy7hwaxmuhIHti0M1ZTHQDMl1dzxgtZzAe57nxEadH9JQQjZmKjnr4rXxbn3dR68j/Sc9r8Fpov7k6xVYKJaTNyZEYSlfXwGzaqE/p8mmHyOyDqEWRlYcxlgjHXYfwBRGqDiA0p0eG7C0pazjdgshkd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EbvabWJf9I3k7r/Qo9ZKwG1KSZ5dYYF+AhsCrnpI9g=;
 b=VaUSdA6yREGI7dSlrDPmjJ2wEw8QeLI5afhCAV7YRZ02OvAD7Y1s2BUbmZksgnhSG8M+Lb5h9nKxBXZogH2pZvy0WfuU0KHjdNZxQOBblwNg79ArnLpEqhtobnF/j2QW2BtePj2YBkvGaZR+shpIcFRTOWU5PJXbdhojerAZ0xY=
Received: from DM6PR02CA0142.namprd02.prod.outlook.com (2603:10b6:5:332::9) by
 IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 14:07:43 +0000
Received: from CY7PEPF000000F2.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::aa) by DM6PR02CA0142.outlook.office365.com
 (2603:10b6:5:332::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Thu,
 22 Oct 2026 14:07:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F2.mail.protection.outlook.com (10.167.247.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 14:07:42 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 09:07:32 -0500
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
Subject: [PATCH v6 2/7] iommu/amd: KVM: SVM: Rename ga_log_intr to wakeup_intr in IOMMU interface
Date: Thu, 22 Oct 2026 19:34:20 +0530
Message-ID: <20261022140425.27465-3-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F2:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 76614b58-44eb-48f5-01c3-08df3045d706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|7416014|376014|10067099003|18002099003|22082099003|261021121427099003|921020|261021123027099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wONBnVimYsPbQiI3IqE2ODnsV0ebP03b8bCMZSkcOzWWW7Y0CrP6qeF9NLdfDfha04WGArwdlF72MJ2qK/jy0P5DOVITlranXLZ9BXHRtiUtXY/cnnZ1LgV167JvQs0DslTJWQ7TYrrU4SYPR58s65FFuO0WQvR/s9tqu7/GMy774xd63EQJ2Tx+7pP0b/63VXIBKIjD7o2TTAia5DxmHrA+GYlKSOGOa4cIpUO4RMD4Dx/HmKdS5U3+gRWJfgAPC1Xj4Abv0Vjy3Fc8qpo+SwH1pH8ngrXEl0vyrLem030zY73Iua4iLTVw0Tg0Hi8W617AnQAvRPd1VXBTnSH52CUJIOhddNKOt9V4FZinhJ5rX8qgayChvQRHc/HBVRB5CRv61yVp9DXI20Zr47kAqBslCePPZQPu2/DFlA3h67rctnxPTsEcemNBVTCcmA1wKz92e4/hFpW0uucD5EsXpL/cHVV5Tg7J0LcKcQxUxXMhZeRPb385iaXohOP+qfKT48410YFjsWQqrtc1zb1ho+DI7ypzIia1FcWMNfuPGyDX7upR6PeHXcA49x+AJgyDMcoNpE4XMq5RLckYrqjDVvffEwW2zZxT4kK6JoiMq6dQj9f7Mt7fPO+ww+fN7X1EXwjFn3egDC8U5GsgrA1nFAWCpheVQ+KccxmH9KPssA2aN9n9+8rPnrm+vlJNIPjcbXvXXtX52PPHSlL5LWnjtYnQmkWG/7m0AWr1UdAUOl6ZAyk1FOrRpXIs1Dfnf++2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(7416014)(376014)(10067099003)(18002099003)(22082099003)(261021121427099003)(921020)(261021123027099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U8RGgorvo//QnjBB1NWgKp9Yd9ZCZNAC9eqXD155sZ+Kamslp7su8D7ckm6SRWVXmU6dF8WrUZpg5nVxX9e8CLJTG/V28HfoeAgN0aPXNEQMUmfnct9RNUtLaWeWKsq687l07ZX1BBsPGKwa3IcpApzTgtVB0ZAhqK9e/xPZB6H3Xn4ZMmZ09ZdxjNspZohdqArFMWJesfmIo+q59nvYyB/RUE1FEIGPz0Bv+q+mGAyfygmjL3jBIQEtDKTC9H4xvUpnGtlolTc1eoZl/J2Z0QcAWh1rasesOzjtjnpP0A+pTpnD8gca6mgkKmkxQXtJ5TWgftsI8DQUB8N7Q/EfGaxcvnP+wuCnEpd7z+zmdVRLAM0DnjZFwPifk7lhS8dsmiaORqzQGf3Lgatpd9NmS++NUmGFMcGc5bTGKUhqh8tRcVDjUpk6rENHWw+0z3gy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:07:42.7428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76614b58-44eb-48f5-01c3-08df3045d706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554

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
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
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
index aa63431ba92c..3de222d6ae15 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -260,11 +260,12 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
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
index 5ac5ce4039a6..edbdb5d75062 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -963,7 +963,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 		} else {
 			pi_data.apicid = -1;
-			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
+			pi_data.wakeup_intr = entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -1002,15 +1002,15 @@ enum avic_vcpu_action {
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
@@ -1018,7 +1018,7 @@ enum avic_vcpu_action {
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
-	bool ga_log_intr = (action & AVIC_START_BLOCKING);
+	bool wakeup_intr = (action & AVIC_START_BLOCKING);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
@@ -1035,9 +1035,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
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
@@ -1073,7 +1073,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
 	entry &= ~(AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK |
-		   AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+		   AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
 	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
@@ -1134,7 +1134,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 
 	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
 
-	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 
 	/*
 	 * Keep the previous APIC ID in the entry so that a rogue doorbell from
@@ -1146,11 +1146,11 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
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
 
@@ -1182,7 +1182,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 		 * The vCPU was preempted while blocking, ensure its IRTEs are
 		 * configured to generate GA Log Interrupts.
 		 */
-		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR))))
+		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR))))
 			return;
 	}
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index aa9848d57f6b..878567708737 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3994,7 +3994,7 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 };
 
 static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
-				  bool ga_log_intr)
+				  bool wakeup_intr)
 {
 	if (apicid >= 0) {
 		entry->lo.fields_vapic.destination =
@@ -4005,7 +4005,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
 		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = ga_log_intr;
+		entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
 	}
 }
 
@@ -4016,7 +4016,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * If the vCPU is associated with a pCPU (@apicid >= 0), configure the
  * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr.  If the
  * vCPU isn't associated with a pCPU (@apicid < 0), clear IsRun and set/clear
- * GALogIntr based on input from the caller (e.g. KVM only requests GALogIntr
+ * GALogIntr based on input from the caller (e.g. KVM only requests wakeup_intr
  * when the vCPU is blocking and requires a notification wake event).  I.e.
  * treat vCPUs that are associated with a pCPU as running.  This API is
  * intended to be used when a vCPU is scheduled in/out (or stops running for
@@ -4027,7 +4027,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
+int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4041,14 +4041,14 @@ int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
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
@@ -4071,7 +4071,7 @@ int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4143,7 +4143,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
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

