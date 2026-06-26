Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129DA3793DE
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471648; cv=fail; b=mltBYsqmhPOFm6HLXTc5OI8CqtKfawwoPFhHx6mgRowIjXAbg6QWVMBqscfSRL8KpdwHPJTbDlQwxFnMdZtknTzT//voR6xYdI1H7abFe67M8HJgsgsZQJ7BjW8iNoNsj5c+xrOtrkZ9rnpPNTy07Mn2AkKfH8CM1UEJl9rXEaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471648; c=relaxed/simple;
	bh=uZ0QUNa1ZypLQZzw9N/Kfsr1WcwlOawEL6LiDXBu+FQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzfcvineRZ0knLEyoHckUeOKG8It3vj6LVq7NgHtGDj9zeG9PALQ4LXJNy8SBRfpsFdMkPT3phvzVGGYUwDvmkbySYu70fEjG69ZzjNvlKOdaIjsqdTHuIRTrhc+f93lByHHE12gFDT/RcJOFgJamx+K9und/qiqy99otU6skrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L2DRtCph; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L2DRtCph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRP0rmWVPLzY1H3X677tCf0w9mqbSzqkzqCTIzB+saBd/EoaXeCoZ/SF4ChDcNjxwgwAweyBu4LmuCee3pGTZE8seQBPexMeupqPqHl7NlbMkMknzPSbprLh3Ohy5/J6BG3/lJ2w7u6OIkaUA3zGwMtU5IaZEeEffGbg4WwnhsnGWMlzeraeW+fAeBHjNhcQwTQWUKsEBveZjMDGUZkc6kpHvHrBsoB1iipkVSO5B/bU6OKfsKrBljCiKTFCoW7ZNTv7Asgx7OHt0zFukbdGWEq1vF2sAifD9WRiVVkUf4zykRYH755ce4bWQ1kQNqeto5XfwCwdu/CFKGbJNKG9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9zM1JwaGvzYzZncMkIR8Tk8MNKuxUPlpbVORal2U1M=;
 b=meLkTTloTfl5JJx+peLcBysV262RmOqfW2LkXWrxH3bfDVSHlg+91WpINe6a0lRl0npLe8d6RONPrpCKQXcz9wPfDwNBR6WFIcT+RrphlLaLQpjjMIPeKJBx2WLBBOtTMotzcug9SttkaVUum2H9PCD4EncPh6vz+Cd6QcjuWqLkjbGmGLFd+cOlbOTXT4UKv5XlXvKtdsNaNXUnAOWZY5QLjVRgrSH1G5fo3S4EawpjST4S3L5hXrTI9onSyUb4SxHaq7t3MAT2fTa3AXmPaNmIkPqkjCHvDkRDkXP3OQ+o/aMmIH9dQLp4/zBLElNFCCxgy9MPr53kRvWxUA+95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9zM1JwaGvzYzZncMkIR8Tk8MNKuxUPlpbVORal2U1M=;
 b=L2DRtCphSsRWdSaLzRaJJ661OADrnNU6sKDADK//ZzupRpTlqh0D9uCGzWxKtm61sKKElXWmCW4ueHaI/6jDMynZDRj3/fIydWzky3QMFFF3EQ51Uan+uTuSr+Dg/wijMfnoIzrkwhqvyfBdBaTnZQlZf5QYOB++iAihWfbAGtc=
Received: from CY5PR17CA0014.namprd17.prod.outlook.com (2603:10b6:930:17::23)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 11:00:41 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:930:17:cafe::18) by CY5PR17CA0014.outlook.office365.com
 (2603:10b6:930:17::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 11:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 11:00:40 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 06:00:32 -0500
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
Subject: [RFC PATCH 3/5] kvm/svm: Introduce per-CPU lock and wakeup queue
Date: Fri, 26 Jun 2026 16:29:04 +0530
Message-ID: <20260626105906.14577-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626105906.14577-1-sarunkod@amd.com>
References: <20260626105906.14577-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: cab75332-e50e-4645-00f9-08ded3722986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	UCTSGjH8m1v+/JbLlt6P7coT9VSydnshJeVH7w77tox/9+SrSG06JMfmSBZUxp/mf9EgDnzW5nW4ee/HJNX6aPOQeyjTE7XU8WUjqSdWvOeXzhqd8/hQS03CJP1/rLRdpfKe9NZwTnaaWXELgGl7GdVT8VkH1NezyJoZrRwIpQI3Sz53pjluIMeeL2CN4mDzE66DteazeF7Du6IpF+BPgisEBr02Pq+8Q2OX8tOMfaHifFlIDsiFULRqmmbdJxMfaArch551+t9rMMC4Sp32gCswNk/r+4KP/1DwIk921jqfnjcS34uA9yOCQJ0YzH7qm3LVzb445feqcVI+AXiw7EPlzCoydGhALChjL7xALCVI+8MmGNG965DRkyGnQuk8StNaHoXcQ9zU8sUKyXDG0/SFtWGjC/x+EJphWrg0HbdZ8eyb2r1q1WtP/lMOAJFZjZbKShfcbEap21gGUta6v85FVNZX1vx6ClW5VH0Tlg86+yQ8pihptQYnsLMuYZZKcuBQyahqbGF3oTuRGL3X6bB1588akCwtY+WGV401ExlWnGigOxb0DgXlvlaf/Ghd9gCCFoRz4jTuGMdiF5LoIj+i4cK5fBlQYqc52IVwDFtgY659RzFZg8T+1YRCOOic9/A7d7QZEtLUfjVRKF5bclM1qUQb1NqdR37FpX1mThw2roJdHUFWVuOSFioC/qVuzLlX+DVWzFqkoC5ny9AVmzLAox/MULsfjYw9teQuumCRo4li2fJA77iXdz407xfB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0mTMQYuajdwXvSDN5JF+efsiyES+2GwfAqDaxPYZcqjR22EfSwIhZFe9DjziItKj8UlsUecaWrD88dWYDJmRREWEYuUfCQaHRCDKA0XZI6GRUp/Iy/dy3Dr7pJGXBPIFWRBjb8cxCWs60F70ecFLhwCtmoATlTDBrN/HPwS6qtgUzam/l0BkznY5JI4iAtwBA2G4k97OK9UHQOmtZ1ZaCR5gu+TcirS5kaIUVtCYkYITIQf9lrXhPQHK696oZkfZnQUhVVtfC+L2mOLmMModZvcBAFdQ3Y+O76oXPxk1og8To5PVRTpZVhItiIexChy+AO0mFULP1yxZCLQ0EbC6T1im7qOXZ5hn9eoKuqHS0fBvJoIZf1JMBfhUv59eqdo5g6q2dwwadEgrxUAGbbIGPm07F6s8J6/+MWRKZROEEG0QDyI/gNF0pO6LH58vzoCv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:00:40.9024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab75332-e50e-4645-00f9-08ded3722986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599

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

