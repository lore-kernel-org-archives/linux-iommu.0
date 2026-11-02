Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793596798;
	b=tI/qirvy9pQyp2HBg+2sVpEvzMnxXBtxvKr1TDX3Xh70vQ3tZ34ltz6hYhi9QcE9sZ3p
	 LL78yDyZyj5OwuruDVki1pYC7fesM6r2Z/+F+xxrgbfNEORJiPaAaCJlFcvWPSQb0tvke
	 f7Qq1Rdn6xCTkPVCZjlvJ3dWd4pnPwcBEH8LnGRMPFlR6CC8VLQ53ThF3zkFqYL7WQTaE
	 WCTt2/8oA+vH3HkNZHsguD413dw+/R+y/oG1mL/SFJ3znt87xBXOPvlbS109Ym/4UdVkW
	 +zGY2funl8LpnqMdHa6dCsowLVYDvm66e5w3dVn943jHe21cl7RU23oWEaKBZMBE8nQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596798;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pUDLLySNDWj9gFs5Zi8Xfgu6BGwIa7LsvntrVA71rfM=;
	b=G4Gd2UpcCx8hQR/qTLwX+SBfJThPSaEY96jvJEAPwBb2y6rXmq+F7p5wkgKfzssbHoG8
	 NZTzW1007MzeKeMh7WqYrCCR3JiH8pdxdVHFUmyn/+rai5jL8JOQM5ATye9W/sog5gt7R
	 SGrOPqDrd5YcvwN+ut9Cny26gWIqTADLL4nPXVUQBH+NJEhK3EB0OjfYDXf685UTR6kw7
	 fSfYLS04dFyNBLt2pDsKkb10uu5271dBlTI1jx7B46lt3rNUyDPFo2GGShc+Hz/hnF1jE
	 8VCMgLt9JmM9RgDS/DgZWZ/LsceAeB1w+Ar9uDT7uE4XqegxwiaahlXjZIoGkciqsnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iyNXRkJl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.6
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAEE606A335
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 05:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACAEE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iyNXRkJl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jz/NAUy6IyHfiM6RUI2GDGzZGPtQoOkzLFRC/JnPaGwF7vtGidr8bDKpWLEN+cYdI9fQyuIxgsZCVUdHAapkiyiEhrGa6t+Mvy7s+hNb9ijG8oKlQAfF5JdINgi/NZDzBkym6ueNlkv0c8/jMJhCW/DyIn6lCxoxRJF/D64ZYxd+oWs57wj15FGei9pQPnOC50f6dTi/rTsum6e+EjJhOnB9mTMiFmpECeuARExMbOH650u7g0GGm/5W73JGz/6J9ND9U0UWgZm1gp6BeYAv2Mx4NasxI7OjM/WZd6QSx0d7hj9YNDk4tpGvC4/JnI3fiNWwDdFF/bbLF8qLqc9puA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUDLLySNDWj9gFs5Zi8Xfgu6BGwIa7LsvntrVA71rfM=;
 b=xvnynTV6O+OZr3WgjzBL7VajZL5bhSFp5fThGjMTqu95piYFYuEmVGOUyS9JTL3jzIAHvmY7CO/W9PjA1/Fppztz5VhrK3mafjnFP0ucOSAJleUgOfusKnzFW+e21APDQjuy/Jz11csOqKFP5MLo9dhqH18/C9rYl9NKsQ7oVY1fLmOPdo2VKB7jXanQoXAWE1ZhfABYJ7+zci1qzT8xkg255lUlrTqjR9QN2Ali3wUVDsMcAiDabKbAN+CrdrL+ucFoey6vnqSEtSs6Fbi+T46et/FqsdIXYL04y1yYo9RIR1fNecCAI/BfljamCZT6gyDQ6NPEVL910T/oMXgaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUDLLySNDWj9gFs5Zi8Xfgu6BGwIa7LsvntrVA71rfM=;
 b=iyNXRkJlQ3tOQp6B4fn4kK2YmUvk2dbeMtf6lUogFA9IhiF8dhqNAMBJpUIJUatk4v/nVUY4E6lnC4wZQ39e2vOPnwnKCa2BnzLVqT75WgPCI3/tbXQjG0Ue69v6Prh7HW6Y5R24L08ypYTKTyIPhb/2WEdqxVvUA97+EsV8/XYJ6iYq/BWWPjs+eyNtYmD/CqwrC+ItXVUMra3kxfEoeN0PGFlF3LJAneFQC2IVkdzpC8D0Uag8ag/TaBrNTTb+yZUM2IXvwjzqGTINKb2DMKKP8sjzG4ot6J8dmgpcGH/QloLKJ13RHejt4bO5ljX/i9cnsTxrSAoYVphb1WPmKw==
Received: from SJ0PR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:332::17)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:19:50 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::a6) by SJ0PR05CA0072.outlook.office365.com
 (2603:10b6:a03:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 05:19:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 05:19:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:39 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:38 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 21:19:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v12 08/12] iommu/arm-smmu-v3-kexec: Reserve crashed kernel's ASIDs and VMIDs
Date: Sun, 1 Nov 2026 21:19:16 -0800
Message-ID: <71cc0734da5d77ec9463f33eff2ed23a3f3f1091.1793593923.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793593923.git.nicolinc@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
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
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: df502b91-d273-49c7-d40e-08df38a0eba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|18002099003|22082099003|56012099006|11063799006|5023799004|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261021135927099003|10067099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	DKhKYOKrnM98Giingt8kglqCoYN/ZzM2mAhCkd8GIja+eI5fdyNy44+Umd0GU3IeN18RuF//f2lL9UGap4OQcy8YnOH8+XQ2VXnbbN9WLHdRqeDUjbcG2kY7rJfdmt1b3VUhUJWWHSNOfLhwfMp2s3YOdffcp5oHv93/TBvPElai98kRRwmh1pxMlJqmz3fwpp2CxkmG2rqCOTNaJD6NFlh32mQTR+7mjgrWD2OIU72cw7mjbHqbFUJ1Hy1E24AJ5nXnrHazbgMlcVFNHt3h/YW/f+ph0kBBH5jtksmW4tTagvHQtxdYMAf+I4XESLlTaSs0bA2Ekk1k5+RWVi/D8SsAhRGPCF7TpCIRqV7gXhDC1JxXC5YZMb98SaJ2dRuf9K5GU5Dx/KDeWYVawuPIXIUD0SZ+E00JYtVELsOutMaXkrzun9ve3U8LXjgAT2YYPf7+Ep+N21QD3cMvjklKcIEwqESbco2JiJuBVdAtTiBisY+imTBHbq5OJir+idFWv5E3mrsfk0fpH2xmJWJ6G6ragIT4hetNKsX9BthDVU9BxayxytWKey3xVXGQxB6/nDnzLNPwSLAKZRTjo35rsRe166q87AMuT/UCCnSy4ncElXSgeJqVlNtB5di1bhJ5Hq2b/0cdKk6zJwqZ9lYLox5kkfvaf01/YXJxT1uFfmAbz8TxKh+oqf9kE0E8dIg2eoE3Uehdae7csAOwt0PJxg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261021135927099003)(10067099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G9rUAxSv+zv50cRN/LBLsyhM7W//xm+6fvBpZ+SsPMJXiYjXt0N9OcWyJHOb4sq3LAoxYztDP3AWBS6yM6/kgDyTg8Ockoazet3q+7muOdne9c7RksOXd3/hRE9Awr+G9S4HV44rVJ4q2gQ8YJjQhdlTR2tS6RC1aY0bOsdJyD4DqClombvqCV/+xcRp2QT5QtgEroYcGzxHuNXPaRCQ557qnEXTveEMcCRRdYIsywxB5/Fc1+JDzEJLyqT2bsFanrAqbB/v1PfAe74XmELCZbM9Of5zNHkMouk0v2HkeCwqg8F0BV+4fJj7CnX/hJ8JbHLB40APugCKpBAB3xob4bVtDYfP+G9oIv3SoXQJyUo0g3K+nkglgexNXtzeC8/QA4TuXpVc3HpJO8GLjk0a23gNF7xKovcGNGUA1WIxhGeRvNQcEITZj4HkWR2ZTpJF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:19:50.8677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df502b91-d273-49c7-d40e-08df38a0eba0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050

The adopted stream table keeps translating in-flight DMA, so the SMMU keeps
caching TLB entries tagged with the crashed kernel's ASIDs and VMIDs. If
this kernel handed one of those IDs to its own domain, the new domain's DMA
could hit the crashed kernel's cached translations, e.g. a stale entry left
behind by an invalidation that the crash cut short.

Scan the adopted stream table at adoption time, reserving every ID in use
via arm_smmu_kexec_scan_and_resv_ids(), and roll all of them back through
arm_smmu_kexec_unresv_ids() should the scan fail. These two kexec helpers
will be shared with the liveupdate code.

The scan memremaps each table transiently, since the IDs must be reserved
within the SMMU probe, long before any master re-probes to claim its table.

The scan walks untrusted tables, yet every loop is strictly index-bounded:
the iteration counts derive from the log2size and s1cdmax fields, which are
validated against this kernel's own sid_bits and ssid_bits, so a corrupted
table cannot extend the walk.

A nested STE's guest-owned CD table is left alone, since its ASIDs live in
a space of their own under that STE's VMID. Reserving that VMID covers all
of them, so there is no reason for the scan to walk the (VMID, ASID) pairs
behind it. The only ASIDs needing a reservation are those in the space that
this kernel uses for its own domains.

Note that, on an E2H/VHE host, the kernel's stage-1 domains are tagged by
the EL2 ASID, and the TLBI_EL2_* commands take no VMID. So isolating this
kernel by a reserved VMID alone would not work. Reserving the ASIDs covers
both the E2H and the NSEL1 cases.

Reservations are never released: a kdump kernel reboots after it saves the
vmcore, and the full-reset fallback flushes the entire TLB, which turns any
stale reservation into a merely unused ID.

If the scan finds any inconsistent structure, toss the entire adoption and
fall back to the full reset.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 304 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   1 +
 2 files changed, 304 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index b15728b5b5b53..0786a7dfff411 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -169,6 +169,298 @@ static int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
 	return 0;
 }
 
+/**
+ * arm_smmu_kexec_check_ste_cdtab() - Decode the CD table geometry of an STE
+ * @smmu: SMMU device of this kernel
+ * @ste0: first 64 bits of the previous kernel's S1 STE
+ * @cdtab: pointer to return the CD table's physical address
+ * @s1fmt: pointer to return the CD table format
+ * @max_contexts: pointer to return the number of CDs
+ *
+ * A linear CD table on the 2-level capable hardware is accepted, as a previous
+ * kernel might have used one, like the linear stream table.
+ *
+ * Note that the spec requires a CD table to be aligned to its own size, so an
+ * unaligned @cdtab gets rejected here: HW may then zero the low bits or fetch
+ * any CD in the table, leaving the live ASIDs unknowable to this scan.
+ *
+ * Return: 0 on success with the three outputs set, or -EINVAL on a bad geometry
+ */
+static int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu,
+					  u64 ste0, phys_addr_t *cdtab,
+					  u32 *s1fmt, u32 *max_contexts)
+{
+	phys_addr_t base = ste0 & STRTAB_STE_0_S1CTXPTR_MASK;
+	u32 s1cdmax = FIELD_GET(STRTAB_STE_0_S1CDMAX, ste0);
+	u32 fmt = FIELD_GET(STRTAB_STE_0_S1FMT, ste0);
+	size_t size;
+
+	if (!base || s1cdmax > smmu->ssid_bits)
+		return -EINVAL;
+
+	if (fmt != STRTAB_STE_0_S1FMT_LINEAR &&
+	    fmt != STRTAB_STE_0_S1FMT_64K_L2)
+		return -EINVAL;
+
+	/* Both kernels run on the same HW, so a genuine STE never has this */
+	if (fmt == STRTAB_STE_0_S1FMT_64K_L2 &&
+	    !(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
+		return -EINVAL;
+
+	if (fmt == STRTAB_STE_0_S1FMT_LINEAR)
+		size = (1UL << s1cdmax) * sizeof(struct arm_smmu_cd);
+	else
+		size = DIV_ROUND_UP(1UL << s1cdmax, CTXDESC_L2_ENTRIES) *
+		       sizeof(struct arm_smmu_cdtab_l1);
+
+	/*
+	 * An unaligned base is CONSTRAINED UNPREDICTABLE: HW may zero the low
+	 * bits or fetch any CD in the table, so live ASIDs become unknowable.
+	 */
+	if (!IS_ALIGNED(base, size))
+		return -EINVAL;
+
+	*cdtab = base;
+	*s1fmt = fmt;
+	*max_contexts = 1U << s1cdmax;
+	return 0;
+}
+
+static int arm_smmu_kexec_resv_asid(struct arm_smmu_device *smmu, u32 asid)
+{
+	/* A valid CD never has ASID 0; both kernels share the same HW limit */
+	if (!asid || asid >= 1UL << smmu->asid_bits)
+		return -EINVAL;
+
+	guard(mutex)(&arm_smmu_asid_lock);
+
+	/*
+	 * The scan runs before this SMMU registers with the IOMMU core, so no
+	 * domain of its own holds an ASID yet, while xa_reserve() does nothing
+	 * if the entry is there, covering a domain's ASID that many CDs share.
+	 */
+	return xa_reserve(&smmu->asid_map, asid, GFP_KERNEL);
+}
+
+static int arm_smmu_kexec_resv_vmid(struct arm_smmu_device *smmu, u32 vmid)
+{
+	int ret;
+
+	/* A translating STE never has VMID 0, which is reserved for bypass */
+	if (!vmid || vmid >= 1UL << smmu->vmid_bits)
+		return -EINVAL;
+
+	ret = ida_alloc_range(&smmu->vmid_map, vmid, vmid, GFP_KERNEL);
+	if (ret < 0 && ret != -ENOSPC) /* -ENOSPC means already reserved */
+		return ret;
+	return 0;
+}
+
+static int arm_smmu_kexec_resv_cd_asids(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd *cds, u32 num_cds)
+{
+	int ret = 0;
+	u32 i;
+
+	for (i = 0; i < num_cds; i++) {
+		u64 val = le64_to_cpu(cds[i].data[0]);
+		u32 asid = FIELD_GET(CTXDESC_CD_0_ASID, val);
+
+		if (!(val & CTXDESC_CD_0_V))
+			continue;
+		ret = arm_smmu_kexec_resv_asid(smmu, asid);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+/*
+ * Reserve the ASIDs of all the valid CDs of an S1 STE in the previous kernel's
+ * CD tables. The CD tables are transiently memremapped for the scan.
+ */
+static int arm_smmu_kexec_resv_s1_asids(struct arm_smmu_device *smmu, u64 ste0)
+{
+	struct arm_smmu_cdtab_l1 *l1tab;
+	u32 num_l1_ents, num_cds, i;
+	u32 max_contexts, s1fmt;
+	phys_addr_t cdtab;
+	int ret;
+
+	ret = arm_smmu_kexec_check_ste_cdtab(smmu, ste0, &cdtab, &s1fmt,
+					     &max_contexts);
+	if (ret)
+		return ret;
+
+	if (s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
+		struct arm_smmu_cd *cds;
+
+		cds = memremap(cdtab, max_contexts * sizeof(*cds), MEMREMAP_WB);
+		if (!cds)
+			return -ENOMEM;
+		ret = arm_smmu_kexec_resv_cd_asids(smmu, cds, max_contexts);
+		memunmap(cds);
+		return ret;
+	}
+
+	num_l1_ents = DIV_ROUND_UP(max_contexts, CTXDESC_L2_ENTRIES);
+	l1tab = memremap(cdtab, num_l1_ents * sizeof(*l1tab), MEMREMAP_WB);
+	if (!l1tab)
+		return -ENOMEM;
+
+	/* max_contexts being under a full leaf makes the only leaf partial */
+	num_cds = min_t(u32, max_contexts, CTXDESC_L2_ENTRIES);
+
+	/* Aliased L2 tables cannot extend the walk; they only repeat a scan */
+	for (i = 0; i < num_l1_ents; i++) {
+		u64 l1_desc = le64_to_cpu(l1tab[i].l2ptr);
+		phys_addr_t l2_base = l1_desc & CTXDESC_L1_DESC_L2PTR_MASK;
+		struct arm_smmu_cdtab_l2 *l2;
+
+		if (!(l1_desc & CTXDESC_L1_DESC_V))
+			continue;
+
+		/*
+		 * A valid descriptor never carries a null pointer. Also, an L2
+		 * table is always 64KB-aligned, so an unaligned pointer would
+		 * make this kernel read a different table.
+		 */
+		if (!l2_base || !IS_ALIGNED(l2_base, sizeof(*l2))) {
+			ret = -EINVAL;
+			break;
+		}
+
+		l2 = memremap(l2_base, num_cds * sizeof(*l2->cds), MEMREMAP_WB);
+		if (!l2) {
+			ret = -ENOMEM;
+			break;
+		}
+		ret = arm_smmu_kexec_resv_cd_asids(smmu, l2->cds, num_cds);
+		memunmap(l2);
+		if (ret)
+			break;
+	}
+	memunmap(l1tab);
+	return ret;
+}
+
+static int arm_smmu_kexec_resv_ste_ids(struct arm_smmu_device *smmu,
+				       struct arm_smmu_ste *ste)
+{
+	u32 vmid = FIELD_GET(STRTAB_STE_2_S2VMID, le64_to_cpu(ste->data[2]));
+	u64 ste0 = le64_to_cpu(ste->data[0]);
+
+	if (!(ste0 & STRTAB_STE_0_V))
+		return 0;
+
+	switch (FIELD_GET(STRTAB_STE_0_CFG, ste0)) {
+	case STRTAB_STE_0_CFG_ABORT:
+	case STRTAB_STE_0_CFG_BYPASS:
+		return 0;
+	case STRTAB_STE_0_CFG_S1_TRANS:
+		return arm_smmu_kexec_resv_s1_asids(smmu, ste0);
+	case STRTAB_STE_0_CFG_NESTED:
+		/*
+		 * A guest-owned CD table is in the IPA space, unreachable. Its
+		 * ASIDs are only tagged with the S2VMID reserved below, so they
+		 * cannot alias this kernel's VMID-0 or EL2 S1 domains.
+		 */
+		fallthrough;
+	case STRTAB_STE_0_CFG_S2_TRANS:
+		return arm_smmu_kexec_resv_vmid(smmu, vmid);
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * arm_smmu_kexec_scan_and_resv_ids() - Reserve a stream table's in-use IDs
+ * @smmu: SMMU device of this kernel, with an adopted or restored strtab_cfg
+ *
+ * Scan the stream table set up in the strtab_cfg and every CD table behind an
+ * S1 STE, reserving all of the in-use ASIDs and VMIDs. A failing scan rolls
+ * back through arm_smmu_kexec_unresv_ids().
+ *
+ * Note that the scan selects the linear or 2-level walk per this kernel's own
+ * ARM_SMMU_FEAT_2_LVL_STRTAB, so the caller must have matched the feature bit
+ * to the format of the adopted stream table in the strtab_cfg.
+ *
+ * Return: 0 on success, -EINVAL on any malformed table entry, or -ENOMEM on a
+ * memory shortage
+ */
+static int arm_smmu_kexec_scan_and_resv_ids(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	int ret = 0;
+	u32 i, j;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)) {
+		for (i = 0; i < cfg->linear.num_ents; i++) {
+			ret = arm_smmu_kexec_resv_ste_ids(
+				smmu, &cfg->linear.table[i]);
+			if (ret)
+				return ret;
+		}
+		return 0;
+	}
+
+	/* Aliased L2 tables cannot extend the scan; they only repeat a scan */
+	for (i = 0; i < cfg->l2.num_l1_ents; i++) {
+		u64 l1_desc = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
+		phys_addr_t base = l1_desc & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l1_desc);
+		struct arm_smmu_strtab_l2 *l2;
+
+		ret = arm_smmu_kexec_check_strtab_l1_desc(smmu, base, span, i);
+		if (ret == 1)
+			continue;
+		if (ret)
+			return ret;
+
+		/*
+		 * This kernel will map the previous kernel's L2 tables lazily
+		 * or not at all. Here, take a transient view for this scan.
+		 */
+		l2 = memremap(base, sizeof(*l2), MEMREMAP_WB);
+		if (!l2)
+			return -ENOMEM;
+		for (j = 0; j < ARRAY_SIZE(l2->stes); j++) {
+			ret = arm_smmu_kexec_resv_ste_ids(smmu, &l2->stes[j]);
+			if (ret)
+				break;
+		}
+		memunmap(l2);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/**
+ * arm_smmu_kexec_unresv_ids() - Release the IDs that a failing scan reserved
+ * @smmu: SMMU device of this kernel that failed its reservation scan
+ *
+ * Undo the reservations of a failing arm_smmu_kexec_scan_and_resv_ids() call,
+ * for a caller that falls back to a full reset.
+ *
+ * That reset flushes the whole TLB, so the previous kernel's IDs no longer need
+ * any protection. A scan that fails halfway would otherwise keep a good share
+ * of an 8-bit ASID or VMID space reserved for nothing.
+ */
+static void arm_smmu_kexec_unresv_ids(struct arm_smmu_device *smmu)
+{
+	/*
+	 * Emptying both maps releases exactly this scan's IDs, as no domain of
+	 * this SMMU can hold one until it registers with the IOMMU core, later
+	 * in the probe. Both stay initialized and usable for the full reset.
+	 */
+	mutex_lock(&arm_smmu_asid_lock);
+	xa_destroy(&smmu->asid_map);
+	mutex_unlock(&arm_smmu_asid_lock);
+
+	ida_destroy(&smmu->vmid_map);
+}
+
 #ifdef CONFIG_CRASH_DUMP
 /*
  * Helper functions of the kdump stream table adoption for ARM SMMUv3
@@ -362,14 +654,24 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 		goto err;
 	}
 
+	ret = arm_smmu_kexec_scan_and_resv_ids(smmu);
+	if (ret) {
+		dev_warn(smmu->dev, "failed to reserve in-use ASIDs/VMIDs\n");
+		arm_smmu_kdump_adopt_cleanup(smmu);
+		goto err_unresv;
+	}
+
 	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
 				       smmu);
 	/* devm_add_action_or_reset ran the cleanup upon failure */
 	if (ret)
-		goto err;
+		goto err_unresv;
 
 	return 0;
 
+err_unresv:
+	/* The full reset will flush the entire TLB, so release everything */
+	arm_smmu_kexec_unresv_ids(smmu);
 err:
 	dev_warn(smmu->dev, "falling back to full reset after adoption failed\n");
 	/*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2c3d0378c39b3..458f4720856e7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4861,6 +4861,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	/* Init both first, as a kdump adoption reserves in-use ASIDs/VMIDs */
 	ida_init(&smmu->vmid_map);
 	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
 				       &smmu->vmid_map);
-- 
2.43.0

