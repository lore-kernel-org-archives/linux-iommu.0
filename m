Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D492408627
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502149; cv=fail; b=Nwzq3PS4vnz0f3Eoaw3TXaBuUIUvHde/OLKFoEmyk7Sw9gOQbg1lFRypv+JZNSBs4KmDTqOcle3jCh3QCIa3In1h7fDHdVVnBj4x4oOPdA6rMjWvCIjPC9SGCKChX7ns1X+yDg3ETs+n8PQK63lqjImWfGhFB+q35Hh4Ri05hlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502149; c=relaxed/simple;
	bh=uZ0QUNa1ZypLQZzw9N/Kfsr1WcwlOawEL6LiDXBu+FQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKrersCc1zY64Ma1INFfdrJe3E54q3gh3/58Yk3+Z0X5ov7D39qt8kJdPLtF8habfUyfpSaxB5wlQwY2zbXjmrDsHxx2ffMMi2UsaCT/KjrLJryF79a6kKTrgHF2j0qVB19x3/+Bxg3EVuNciJYKOiGjeVoiNKCZARNO92WSynM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Imirw3/o; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Imirw3/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlmvzj6jNtftoUDAXLXZTOPhiS7jqQxqEG+Yqe/mpB82iBySJRUJOvdJl9j17kps4WOZZp4UGVHuSwacm9rTSS+sE+Sgd1ZCrcqxzh5kkyThzQ+ndso9YDAQ4+aFVJT8flX157vnnkvaSxMkNCM1pqXhbykX6RI2pj3MXLMVJhrqoowvFy6sM2+MIA9n2RM6AO+PilgGTjfjNvL2myWis6W55N9nwg/Et7ZBTGk2CpmDT2BinvHCg5gOtZugUA2jeDJDCqjS4TNZhl7XrX+YVBNz+G0KXxQs10ag49gXVbY7rp90ob48b4ja7sWVlUdr/bG6U6VR0Fh8qnPsENvTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9zM1JwaGvzYzZncMkIR8Tk8MNKuxUPlpbVORal2U1M=;
 b=xUQEwrIXbDZvT6n2ZkwPFHpKt7ZST9e74U5A4uYLNDB+JeHiPSLI+nAG6KXFho1UXwyQGFJUDIfIP51GdmOyRk11/6iDp57WM4YBDRZc7JQiZf2i2kJrCKIlO2VInHI1zMCYDS4U7wsYBHIKGJDXVCYgtd+R5ZFuy91xZ0FN83Ss8bogh5gzyo+WxXnnoGFyVDYIBRsl40Mp4Ot5OGVSLJkODHMsNUreGq0xEf6CX54YfX/KhBgQxtUKhUGW4T+ex94ugDPgC7OIdUGDXRzIby+ZfU4ms01EGsfZIlvGo++F6021bZxL43zbW7+6OuwDYjQnPrqGpR3lVF1hjmUpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9zM1JwaGvzYzZncMkIR8Tk8MNKuxUPlpbVORal2U1M=;
 b=Imirw3/oYTB8jMxyf0wzIMYS40qtxL5xwtTDL2y6Lz87cX2PwUt06+jp7c6C7KriAbskFNQjOjpMCbGOrnDt31dzCClW5j8t3QxvN88X0ppx2EAxIJO23UV5Zfr5M2bS/GBXAKLzQE02NE+a6BYtoe/EHYMwJJHA0D8GIwMzTXA=
Received: from SJ0PR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:332::29)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 09:15:41 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::5e) by SJ0PR05CA0084.outlook.office365.com
 (2603:10b6:a03:332::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 09:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 09:15:40 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 04:15:34 -0500
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
Subject: [RFC PATCH v2 3/5] kvm/svm: Introduce per-CPU lock and wakeup queue
Date: Wed, 8 Jul 2026 14:44:06 +0530
Message-ID: <20260708091408.12106-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708091408.12106-1-sarunkod@amd.com>
References: <20260708091408.12106-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 8723fc3b-8110-4b1c-d70d-08dedcd17b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nyoel+uN2yvkJHBCx7r8rIozPVuwIqi8cjJK5oHAprzIXnu6nsjKa8uLZZJ5I5acOkmFCscDfwkHw5gChuazndjr8YoW4AVMpN5aJ4wSgSip5QZwHsq6gKAUZJYqvsksrl8u2uw17sv7jT05wBTSyUhxEpGtYrpXkaJctNaWqtwW8HRqQMJu2/tngHdq6/Q/xHYgzZpDyA40WV/X40fQcWUfKfEvUdOF7XzpSE0ucA2L64OjkJEoZUGC3CaG2c/q0YiltcR1a+gHzVpgNaTTHAkoLBkU1oUxZYTuRzJEaRwc/Vgu8MmRPxhTBHQJ/HnAGg81NR4zlIon3QqudHTVyH09gtd0U2QgeCDqRr8RSZ2M8Oas0Yaic5qB405H3tZ12Brdt7rkOECuvZJU1TY/yabXu0GXl35JRuP9hA6kD8An3yXH2+Zc3nLmbhHAqwpyOSpd8xbNvf0svyaXoUkVluWHEvBGbUkV57E8E+hpwTH7P9vwIUyYF3folMjuG8BxzJ2yuAa5edxKqqhWLFhOZ5SuhmvxQWWwEgNkLG0zk0WKNXdZ8hSUbHRsj6IitRXeWKykRdPu+IQgoQfc8rUBSuqgBWgDi+oXH1iUsUPa3XQXWdu+/qqvQE75MlpScWtcKZFTcU7eUGq9rshDlrY6F1c3Nsi5pzJMgY6PbKYbUKDD45Td/ypZGRRND30T/Y6dZU+T0QIJJlLPBe57Ziz7+VkyuaHLItG5D+WsM8Aui1Q2ZpG6Qi0ubySRT82XhSz+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(921020)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LZMVDFDJEgjUdLMa7KGrGrPlkPYzLEC9ZmLPl92zuSa1yGPdQAnZvbM/HyqcA5D/NOLSJEac9xu69l2P+bvTSkIP9WRcLKJ2GYztxAiNKubAvbAQJLZ09y4OPDeuJHox+Xj4r/dKvkFyoch+vQcC3sFjTNra4XXg3qloPLxAT+BKMnFbNfq0A1RYp+yIW4muBqgLDHnoqkPha9b3p7H6jegOM3lRGNmw4JWmjSm5BtEAAUNQt9Vh0oYCNWiRUeYIcqVHf59SMIglWIeNy64pVRVP7kowqg2BjMZyMGEfrCn9bXsC6LtdxxpNp75EQ4uQopJ8iLkZVmTjvZQxawr/qA6557p704h6dJQFOvhVnOyK52jM+1ANrUK4vwZmJl63eu7noThs0qMUMfJnDksvjlIwuufkDJ6acVvrcA1fi3L4U+AwSkXuxKlbwyjhzFwI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:15:40.7420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8723fc3b-8110-4b1c-d70d-08dedcd17b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663

Add a per-CPU list and raw spinlock that SVM will use to track vCPUs
blocked and waiting for a wakeup.  The GAPPI interrupt handler will
scan the corresponding CPU’s list to decide which vCPU to run.
Initialize both in avic_hardware_setup() when AVIC is enabled.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/kvm/svm/avic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index b666efb5d91c..e7a4c0e90e7a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -63,6 +63,9 @@
 	ga_tag;								\
 })
 
+static DEFINE_PER_CPU(struct list_head, gappi_vcpu_wakeup_list);
+static DEFINE_PER_CPU(raw_spinlock_t, gappi_vcpu_wakeup_list_lock);
+
 static_assert(__AVIC_GATAG(AVIC_VM_ID_MASK, AVIC_VCPU_IDX_MASK) == -1u);
 
 #define AVIC_AUTO_MODE -1
@@ -1315,12 +1318,18 @@ static bool __init avic_want_avic_enabled(void)
  */
 bool __init avic_hardware_setup(void)
 {
+	int cpu;
 	avic = avic_want_avic_enabled();
 	if (!avic)
 		return false;
 
 	pr_info("AVIC enabled\n");
 
+	for_each_possible_cpu(cpu) {
+		INIT_LIST_HEAD(&per_cpu(gappi_vcpu_wakeup_list, cpu));
+		raw_spin_lock_init(&per_cpu(gappi_vcpu_wakeup_list_lock, cpu));
+	}
+
 	/* AVIC is a prerequisite for x2AVIC. */
 	x2avic_enabled = boot_cpu_has(X86_FEATURE_X2AVIC);
 	if (x2avic_enabled) {
-- 
2.34.1

