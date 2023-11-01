Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9B1C2BB
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TC7ZQZIF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC51d7Lk0JVfj7JiEAKKuKZiKw4DbNHW+qd4B5/fe8zOYmnCekcT3N/jpuOHGIZVpfZpn9FcIc/xahZTR5rmU0Az179opGCZ3V8KvUjdW9YqdfBtMYbkXa3KnG6zCKpn9WCs3C6XZ95igZt1E1J7iiZpki7ob1r9yutLdb9ybolAAY6SMgx6hoSh/fdZF3lyyG2wF+POxnhG+4uhHsmpPIhZ7iRvt6o8zrgtY07xVyrWcsAZr+nRDey7nJovkQinjY2ITD/dGpPmdOLIRg/v9jX69ZzOrmgldhgM2H2XCZNfPvNEPOMsweAHDW5m/8R5zJDymShjzWfL/NgjjWiQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SBEHUNiHJavSDEijDhFP1X9EW/JTL8xJUkX0CCpjUk=;
 b=FwiKJnWDvT6u9mEfpDHwTcSDP5BoonQSzkhnNt7ZaS+pi1R+AKcEq0VWb4ljHVtaeigsOO3cEwiIjhnK1CLKcRMLdGUA2+skqd1JQPxmT2EA7RCuSrXOubVTHlRBVEeBho62U5wlIIrfztb/KF7etgt/CB5o34kObfgnlKlydLjtKh+0S01efPPbGSiMrf2Q2lveiZ+SAl4hpenTS1ioisrCJY+T+kfD7oTItqMqYC7EohPxW3Cb9I76tXT+3acD4ZExP6sc5kM5c8XR2BOD3SDyf71AiREjfy0q2EDD93gt/UMJV2CIe/RA+fIgDsR7oesW41rWXoqnaFrea2w7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SBEHUNiHJavSDEijDhFP1X9EW/JTL8xJUkX0CCpjUk=;
 b=TC7ZQZIFuOGDTALqjegahhlOJmdK6xErzFge8mCa9CvOmLSFCsj/5uBigaIeVBetZovmjdavz4hSlCOSFllGjC1nbP1RW1l6jOJ7ojtPEvhfNMhuuy++cVswXHyeNNUFmDaXVmZwEzicVfmXMfRGraywVGvpj/mdrv6UQ5i57JXYrpSccgvqMm8ScMb7tgVDTt5Gd2NAQpfYXxtSk2eFkgl8y1Vfs2cpjgOjEQWY8SZnIjSqzpM8bpHXtbQLVTkHzwdtiGatmPN78p8IOqgICuPhH/aT82RSfqaITDt/mns4akUQ35p6JLcClGBDwNSfLrKlKB8cSFkkREBkZRJcSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 23:36:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 04/27] iommu/arm-smmu-v3: Add a type for the CD entry
Date: Wed,  1 Nov 2023 20:36:22 -0300
Message-ID: <4-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:208:fc::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: 0166c8af-05a8-46f8-83b6-08dbdb33694f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aF4zVTBT9nYtQcqTwmT2rhqhC7HEHbAltxT8CFM48Frwp1thKMR1OqJYOjJ0lvoR6fUQ768QEMXSIZAMfHtBXFHf2oJHMEPhUdfQmkoJdVTc3rypdBQazK3AMd1kiHvXb1v6c7eIlB3pQ2z43PjHv84PZWRfcwgeM1P+82fgNKJfQIW2r53cS6r84rMTJys5/WueoVlYOPfZHbgI/OFKTzHlEMA7Mt0qYoLIVlOlPrEdSjs08YnhUXZTVsx5ibMfMOl7ODuLopAGoTqWHYgM41ZHyy0MO9RtDy9guKWmUxu8yRGZzSkordxwNWZcKte0llEH2eXWqLDTpqxNWROMFCD5aim82f4zJX6t17s6ODMhCwZuUkadm/yXMnRYzGtG1b3JQ20X0QFRvx9dKx51coZgUslS+1Lunn4pKXAwo/j+4BNNIhdzJP79o1SeURYPYJrctWkrznlVGCbTGbgHmy3JOAZgEujJoXPcLS8EsvaM2caKjqWvTLaS7SVCNrpv8nDz7K+ZzYQl1d3qOuoyd0UcK9Fv2i4q+1RE+BD3Wb6sLZJD0O23FfqyeWSQtX02yo1vzZ0lXzNsw8Sw88Ud0+xt0QveBaZmd5+6R/iJJrBlxZgVGeb2wp4zL9dOVdPuKyr1mL3sBnwQtoAa2UPZ/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4326008)(8936002)(83380400001)(86362001)(2906002)(38100700002)(8676002)(36756003)(5660300002)(41300700001)(26005)(66946007)(6506007)(6512007)(478600001)(6486002)(6666004)(54906003)(66476007)(316002)(66556008)(110136005)(2616005)(107886003)(4216001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c4TiSmxQAjPpzl/HPiACInZzn/cFHbQVbQ3bhG74PsAzBob6Z81V2nuhPvdt?=
 =?us-ascii?Q?nMAhetYPHofj9DJMVyRyT5nML1lhbBLPZrrkXau7Bop68+VuF04hcTq4kZ44?=
 =?us-ascii?Q?7PGDINBeKqkiKarQcWRY8qRbUeWm14yXQGCoUGHMSb5AfPKPu8NSvUX709KD?=
 =?us-ascii?Q?6K40jXo/yk3Va+ufDonImMxbtzM9hmqOF8gYoeze0fpfdqaLj6xIGStO//71?=
 =?us-ascii?Q?NxH1Kk3nxYfyL9gOfgD9hgSVT7bxBC0FMC7PSzZ1sqpof6jDwKqFi5z81B9Y?=
 =?us-ascii?Q?1ULsqCNkfoXQ+nyWP6zB648fCaSvvBz8w0OBrVshiuBrBNetq6CsZGJL9pqX?=
 =?us-ascii?Q?KgjFi0oTFt2x7ShtXfskZ5PfbCCPbW6/4R5yB4ccSb4ZPemCfsXR+xRcbBbP?=
 =?us-ascii?Q?aXQgOANYupVl2x3mhJ185cBbgZMO8NrAP1AwIAZnV2yT+mTe0o++5shMSWj8?=
 =?us-ascii?Q?/JFxeflbI9Cb1t0prw20AyK2Uz3Zo1KEvsgf6rKUOt5QkBpe/+9mqczDo9TQ?=
 =?us-ascii?Q?wEOwaFPg1WPnImkHEeYoBjkPgsP9c/uFZwWOyzyoZLLxqAoMRUrOhkK4t/OS?=
 =?us-ascii?Q?2BROM5ptwQ7Vv3vWj+ItU1taQxPqqRLzC5ijyBSaIM9oR8wXWvUAsG0ypViB?=
 =?us-ascii?Q?5+nIsUA/yXifmkKD0d4ZP14KyUd2s3I3fcMoSyONkcdtgs3piIP3n1IuEQ+5?=
 =?us-ascii?Q?Qk2C0Uh7bnnb5uLqhfT5b4UePBjikteYx8nSHgBhLfSv4oAd68EXoeHFpElj?=
 =?us-ascii?Q?/NcO87agkXC5y+Kx5zVpnG1iu4+UK/NfKl15s+5NLpTBIYqIeOXSzrPZRYMO?=
 =?us-ascii?Q?rD6Oukgsxch30cgAHjEW278v4UfH1vxEmSEAwVvc3luKjef+lp00mfr9LZlv?=
 =?us-ascii?Q?0klzrEkOInRCUFQUw4qYx8uOaUmN7OIUnx3ZZ7HrQde6t/TKqBC0ndTofYqf?=
 =?us-ascii?Q?3BbdQki5C5Rqi14O/R0Zbe2k5GRafHNEPXFjkiuyxrRfbs9NRYFIvAl+cx5q?=
 =?us-ascii?Q?QlxHzIxcCEnHGnxGVdpWg7qLaKh6VdeCFZi69Yh6q3Wocf0hwEh6B7eCm6/l?=
 =?us-ascii?Q?+AimWlXfNp4ku9Qa2z6u0fUfhAxlqr0SOZWky46cqeGIZcDY4FY3qWVg5n2M?=
 =?us-ascii?Q?1dig2xOf8Z6nsC255INZKUV4DWJzsvMTHCx85OVsHglCzTrRjJcQEGkARFqB?=
 =?us-ascii?Q?sgWH6XoHtiXeN2hXgu59mOWr0BI7TY3SQ3cfLfo9S6cJhf/ZP4PpvKImzrHm?=
 =?us-ascii?Q?o+H+GshJxTonMYifJ7QBvk66cFi1N3XDwzAkORAC7ym8oSLp7xHRBwb4ebse?=
 =?us-ascii?Q?HhdexQbfhtjzjWyAINqNfkcXjnXgK6puxfm0LCNM6sglQPyXzn962z+hpauy?=
 =?us-ascii?Q?+f/rd462G6IPOvH+4FQrzQqWzD8KHSoLbucS/9+p1OIdJXji6jabKWVKY9wK?=
 =?us-ascii?Q?5cQ5M9LlLbqv9IGcHDy+3bfrYYkquLrC1tQerZFq3RnhDgCvs13Q06uOx6+3?=
 =?us-ascii?Q?k6jNJI2VWbELMgq5EqBD0qjUJUGRl3ShXxX9wukxvGUCZMmxpT+ENcT6L+ZN?=
 =?us-ascii?Q?G4OB6gIhTBrnA/hTUdadb1qoNswu7IEtxdc1W5fg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0166c8af-05a8-46f8-83b6-08dbdb33694f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDmIfkl1TMapqFUrP53fuXWI+aDbfIEBepvesG1mnNKmkC06ke3H75cjYmur0RNw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301

Instead of passing a naked __le16 * around to represent a CD table entry
wrap it in a "struct arm_smmu_cd" with an array of the correct size. This
makes it much clearer which functions will comprise the "CD API".

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 ++++++-
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9a0eaae586f2e1..80cbedcf33aabc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1118,7 +1118,8 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
-static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
+static struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
+					       u32 ssid)
 {
 	__le64 *l1ptr;
 	unsigned int idx;
@@ -1127,7 +1128,8 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
-		return cd_table->cdtab + ssid * CTXDESC_CD_DWORDS;
+		return (struct arm_smmu_cd *)(cd_table->cdtab +
+					      ssid * CTXDESC_CD_DWORDS);
 
 	idx = ssid >> CTXDESC_SPLIT;
 	l1_desc = &cd_table->l1_desc[idx];
@@ -1141,7 +1143,7 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 		arm_smmu_sync_cd(master, ssid, false);
 	}
 	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
-	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
+	return &l1_desc->l2ptr[idx];
 }
 
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
@@ -1160,7 +1162,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	 */
 	u64 val;
 	bool cd_live;
-	__le64 *cdptr;
+	struct arm_smmu_cd *cdptr;
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (WARN_ON(ssid >= (1 << cd_table->s1cdmax)))
@@ -1170,7 +1172,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	if (!cdptr)
 		return -ENOMEM;
 
-	val = le64_to_cpu(cdptr[0]);
+	val = le64_to_cpu(cdptr->data[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
 
 	if (!cd) { /* (5) */
@@ -1185,9 +1187,9 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		 * this substream's traffic
 		 */
 	} else { /* (1) and (2) */
-		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
-		cdptr[2] = 0;
-		cdptr[3] = cpu_to_le64(cd->mair);
+		cdptr->data[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
+		cdptr->data[2] = 0;
+		cdptr->data[3] = cpu_to_le64(cd->mair);
 
 		/*
 		 * STE may be live, and the SMMU might read dwords of this CD in any
@@ -1219,7 +1221,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	 *   field within an aligned 64-bit span of a structure can be altered
 	 *   without first making the structure invalid.
 	 */
-	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
+	WRITE_ONCE(cdptr->data[0], cpu_to_le64(val));
 	arm_smmu_sync_cd(master, ssid, true);
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6f62184eaa2434..24a77e0a97898b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -282,6 +282,11 @@ struct arm_smmu_ste {
 #define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)
 
 #define CTXDESC_CD_DWORDS		8
+
+struct arm_smmu_cd {
+	__le64 data[CTXDESC_CD_DWORDS];
+};
+
 #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
 #define CTXDESC_CD_0_TCR_TG0		GENMASK_ULL(7, 6)
 #define CTXDESC_CD_0_TCR_IRGN0		GENMASK_ULL(9, 8)
@@ -591,7 +596,7 @@ struct arm_smmu_ctx_desc {
 };
 
 struct arm_smmu_l1_ctx_desc {
-	__le64				*l2ptr;
+	struct arm_smmu_cd		*l2ptr;
 	dma_addr_t			l2ptr_dma;
 };
 
-- 
2.42.0

