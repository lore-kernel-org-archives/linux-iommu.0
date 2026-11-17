Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943336;
	b=0rTKBMHf6CFUQPYC3PFscRtHbGyrXgpuFTjgTpWm1iZoQxKlm6R1gvTA5rFsDM6w7Nu6
	 ykgR8aRxWye81lcmZUjIAbTuFK6OqB9g17hhg0+QP5wjHK65wrdekzZR/Sy4Ppf+q4Vj0
	 S3W+Uii8R4N++yZjA6uqElVn1Na/heVD0+ho2klxsQJK8kywcAK+MfuGkXgQt4Fx77Gbz
	 x01A+rqwo3lmVvTL2/i9RGoDSvpQxwuqdOUcNW3pD9z1oxj6caO8bc1Gj+r++fc+Be+Aq
	 YV3Byaq5eQ2K0y6NAt4nGkEJE7jN5psQZXAihEN8Dfm50camZ5MBjpugKh68+6XQyVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943336;
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
	bh=j1uuZOcv66qKHw+CIKmDlFZ94A0VZaLf462YHrZMngQ=;
	b=3x4FpBbbYo0q3QsE2B1ms9f7KPVYh4b33MdI9LA/JyN6/nMqDYy4ZtlsUnptf5D+IJB1
	 IZAGq0F2cP5AJ0JnZZEIRqZeoS4SMWswnvYNjhdTJA38AMjw3jJG/XdGqn1NU2sFDycuK
	 lh22djZ6za6RUffNK3h2g8SqfbWwtRO7O2gPuIeuRzOJA/h7iSpFjRl0b9Gnpj/UR7GSf
	 bhVqnGw2Gr4+2OuMw0VN6FjiHREPPfu9bBWhZmTL1GRR+sb+KzrKsW2lx8vW8LfbGHciH
	 Y5ac4bo9FzwVL+LhJkxQJuDaD97LWeAlxWuQob26BUp5SnGJzk8FE3CWATTy5yY160Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="j6oPsF/W";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.57
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013057.outbound.protection.outlook.com [40.93.196.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33802606A8BC
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33802606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j6oPsF/W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVBzjJIOTtZ0X34rds9wa+F9DHTAWjelTuCmvuPlHM68bbEjr7vljrAqup3VE+iXA/zBwV5j3ruHKVM99+SyiRiCQu6n2YroYMI73/vuf/3PTNQquNnSfWAEiULUNWglfC5w6/YMCRsTIQ2wsAqzV8IqNQY4iSo13e6GGOFbK7LOK+i7xunzJ7GMkNYttPF+v1gRn8/rarDc0vAndS527566DNWf3qZpDwmNjVqJQK0d+BLM+PXnfrGSz7SDr+6axOOKcW8tmi1fcRumdU1s+Y7/6pPBWdBocdx7nl2WmtsTDikiCVFisZoZTawZWPj5Gm2WUJ//H9CwOYJAhSO9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1uuZOcv66qKHw+CIKmDlFZ94A0VZaLf462YHrZMngQ=;
 b=oL6Wla7qdG597ZQRItmk1yMqGNnwjl4NUFC76wH8zfyBlk3f67/MnwGWfP/i6CEikcTpm71nGC+fmve403ZpevAa1sAIxpjDxZSEyLB0o1FXqBTA7bioY01oszVS3iodE0ZxyDqurZrVXqyhNfkQjQ/3mB8K+lI9JKCa1j5bZs1DYz36KXTH3T+EKtp+w451QXfPfNqeCw6kdd6a040CIHBXsRf/pr5UGU5U7ILEstB41ryDPq8uFi/0UhRN3KRtJFYHvNpjK6Nmm/1pwetvcD44WOFZYHGTHNl6FAMhTo9M1e5fT/4fBd76xW0UaPIvZ3baXhX+le+/YeR8d2xPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1uuZOcv66qKHw+CIKmDlFZ94A0VZaLf462YHrZMngQ=;
 b=j6oPsF/WuSxr2Ez7A6NuWFcaLl0Sqj2lJ/UenPMJrmqFVIHSY7i9nLDewiQ7X0RfA03SjAgeQdO0pE8qlwToJ4XQVGc7+tm5yLGBSJffEoDnqIBOtXQz6k3pdX4ur8MwVVVhihWrkkwD2LSVZBW1xl0PH99usSsuuVW95CRS7hMNFkIQQxiLibq77BMWsl2l/2SEZ7vcFxP8q19RshWo7Hdv5kWvAmnCBWzyruCmOKoNAnlXQQfbrG69j+k/mJGx/bL5Ldn9T7OmAdLdLqr/E4PD1OVO4F571O73gv/LW19RZg/9lg5qbhVOLGU3TPCewTLLQpJnk5GlNdHLTYGPMQ==
Received: from MN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:208:52d::24)
 by DS2PR12MB413088.namprd12.prod.outlook.com (2603:10b6:8:400::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:22:08 +0000
Received: from BN2PEPF0000A991.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::a7) by MN0PR04CA0025.outlook.office365.com
 (2603:10b6:208:52d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 19:22:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A991.mail.protection.outlook.com (10.167.248.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:22:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:21:43 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 11:21:43 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:21:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v13 08/12] iommu/arm-smmu-v3-kexec: Reserve crashed kernel's ASIDs and VMIDs
Date: Tue, 17 Nov 2026 11:21:25 -0800
Message-ID: <c8dbd1cb5dd935008fe1ade3125b79deabf0a182.1794942324.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794942324.git.nicolinc@nvidia.com>
References: <cover.1794942324.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A991:EE_|DS2PR12MB413088:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c58098-e040-47e4-f253-08df44e01262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|6133799003|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|5023799004|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	QaPAeKJF6B8d5n1cYGbTVIEvidmcOmmtegTo4ZAZmoo7DoJxJCVvN/AksR5KXc/H40GG1VGEwGLPshs7ys4CmO4BEr0SplqwVbgppcZ5Zb3NlJZk92CnjItWkwNmd0G9Fssc1hOZJdrzMR+u2TCM6RxM68JDuih1Q8WHNaXF7bLEiuvL/hLLqQApNx8x7zfZHsAsHV5Umw7c4ID1k15G/wrf7eCQGc18CNuA5kQNO9+W5e2T337/Bq1EjHXA1wIJ6BMl+a6gvqt443wcqtvJN/OpiarM2QaLLOf5X3Y7GaxpqI37/H4uTRZjQB8wOI6jLeKslv6nzUWmWxKGhdYixiKP8FD63XrRnwIDTqEbyEvszqmyJueqONC5ADieqikBygMfM7uwHR28gLJ62zrlUQbW2lc87Hmkk/ynxS9rrHsvap2krUMk2Ba8WCpGL/zhbF3yibipu5/KF8UOvzOLclJHf8W53ZVlpKjXsBbZ4r8eyF5ZXMD9ucMiCYZAA9sMLrWrXru/Whp7gJcr1kmP1CuV/yFoXefmRntillDrUJwqLBzZROJ+zV6HULLly5vQX0ZqdPjKiWLzERItlAmidVhk7H/aZpkTGl9tUkhoaKTyjCRObQlN5pPprvgySi0vT81mQpiaB2G2oCRfYE6rVSsLzrAtWexm4T7o4UVgqGq+xXSL+uyYPPZCVhUv9EBNlV3Lof8H7rqmqGvXP/emiQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(5023799004)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+bJkHYu3KKfhe5/q2V+OOYSujB4oDq3JrQonPyTFtqOtglzVuUOgYIC1So0xkYZbObGdlsrfBJS1Iads+0mh5vdiA88KMzTwhKoKwFwHRRHy3w/DvA6c8jUfI7SoswOvHVXv9gbXML235fZ+JWJomEwSwjK7ktGvb15KPZ/bi+UylDQneUS5mOUvsoe2V+CFQ/KaTp6sFc0hu/cpOt2JlFGochAOzZudKSY6zJLBgNCChLKhJriZ9jJn/OTPLTg6dCd0rFG9/AMO5QLr5jRK1UJm/j2wuySlGvFylIRrshU0ZWZI8PFsTIYMkvjZb8KJqTvCRI+NMNHICJTimwM7437ejLAb4/8lTikQU5OUWNHKCNqCdA8nXEM+eHl4cPqDvc8cYSF3La0pRlNK8TKSluO3WRp2X3wc6hsIiTzQ4L765kOFTCq2FbZ/ekVlsVI3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:22:07.9907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c58098-e040-47e4-f253-08df44e01262
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A991.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB413088

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
index 9c2df300b6f80..766d54c33de74 100644
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
@@ -366,14 +658,24 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
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
index 807a4bf7c1d10..ac1aa83c69291 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4862,6 +4862,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	/* Init both first, as a kdump adoption reserves in-use ASIDs/VMIDs */
 	ida_init(&smmu->vmid_map);
 	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
 				       &smmu->vmid_map);
-- 
2.43.0

