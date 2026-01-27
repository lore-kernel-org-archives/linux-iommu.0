Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90591302CBA
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483402; cv=fail; b=oVuaQ+LiSEE3av1YD4aczR5LRTVWBfuRyszBZ+cm/xajFypW7D2S+RBeQzscyjnpjJgbZ7FwHr2TijUcbffAmedlIZv2NOjyQsPbi7YVOgkdaUrqQlMtvLbFwQZ1dW1mnRx2AZPw5x5vydmCZ2EkjSE/Jc815xbWuWxWDKvq9vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483402; c=relaxed/simple;
	bh=oq1zqY1qmNYw2jjr0o14CAUtR3Q6uQshRDsiwNDfN4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0Q+8SGtmqTQ7oFwHKdwTnRh2r4dfbXTunqElkfVPkQm8Rm2VVJWjhm1rkKzvDHh3WB1xwXXkb+Jj8DP3h7yfXQSCh4dl7jxLTy5bH27yFpEVnIYT/e7RVZXdo4JV2ugMNGXy53s0ErXskAPzFOSqmXr69yomr+aR1/4vx1kJUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kLWEqyPv; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kLWEqyPv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlynqyk3jbgMRt2VlLcEsdEotESi7uTiDj2SyUykBQ3ntLCGGRs/U67KLmzcd246MlnYmWtnBLqCiBaRVAjVd0mpTRSQUzF/kEeZ8m8Sw4E7Oi7x8HF0F6nN1uv1CwifmeynqRtjp+ljOjGTyTnN80FBOjjgX0G2rt/WxvGvYPNj0diJuqEDwiuvY/cPROmdg/otyyNrHSxAePGBaopBH9j9khxx00ItkQ4Np01LQhqQmVfEPdOdTjiaQ0sYB61HOEYxoe9/XIhs2ZzNzvpBwd7RD/6U7WQ7cCHASbuswM5gqr3nl+gTpDSf1DKPCiAvq5l7B0bzeUUZ/kTwIjbmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJuzqIs5b5YweipQH8dpop+URN7F4iBqO9iV7u4rHp4=;
 b=cYB2/dTXV9GDA6sqLmCn7Nkls5nDkOGAHVU34ncr33MWzouw7kIYNAV7G3yuyh5gcnc59vvGge/d/h+BCNVP+mCyaMZPwZ2ez69OSEVJmMIzvFH07YFvDQ7wBz4Odsq8KJXK4sU1FmSU3zIq/omr5P7d7vD54IegelXfEx+jUVxQZAnGsmvYUd6mEu8gW+cYoPBWQK+UsMa+QDBfzznComYa9qfiNV1sp8FnYnYqneonMgAJDIR/c/lUZ8S4oPthSQX4lUu2KTiNHlyFAKZ/JGt/zSzYhv2tdfubyS+QfTDEg+RnMmRe8/6009nm5f1QSna0ah7GGQKQhEZub1+p8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJuzqIs5b5YweipQH8dpop+URN7F4iBqO9iV7u4rHp4=;
 b=kLWEqyPv0303k+mA0+GavVJmWTsHnCqK5Qr+b4YGPY2yyGLDI+mBkJp1/JLeMfpkG2UaIIOCXO2S6SGd9Zy7gEshD++nW5LdemMYyhgx6WMZ2FLVwM5ciXoVmFqtWpHaRAXu5aFPzHSPnR89snTJbhnObqyKCCICj/JgZAZ6iihWZQ6l2ClMfw2KziuQtiA+OMOIMURFNqskoZhwpY70rGdFo34rBPcCuosBoReKeLc7UGbYHpTL2x0GuHYdIeYWCymo6oXTelTB+UyA2H/H8osl3+48lOroJMIaDeYb1q7r3uWhhBF8hFFPPrkSnmK9XRcWiBI/r1XCyuvfiACEGw==
Received: from BN9PR03CA0156.namprd03.prod.outlook.com (2603:10b6:408:f4::11)
 by CH1PPF931B95D07.namprd12.prod.outlook.com (2603:10b6:61f:fc00::619) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 03:09:51 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::c2) by BN9PR03CA0156.outlook.office365.com
 (2603:10b6:408:f4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 03:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 03:09:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 19:09:40 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 19:09:39 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 19:09:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 7/8] iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
Date: Mon, 26 Jan 2026 19:09:18 -0800
Message-ID: <ed142f13c1895a9cdf1ca9ff45906615bed3b1b5.1769476588.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769476588.git.nicolinc@nvidia.com>
References: <cover.1769476588.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CH1PPF931B95D07:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7f0882-52df-48d9-1d06-08de5d51897b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kFaIfSjlmjyFa4yvTRBzrgs/wn8ETSAD35Ao+Qxr1r/QZdCgNetkZlJAn+Cf?=
 =?us-ascii?Q?JXDMlmisQ5fnWE9gVS6EwCMVrrqZIcr2qYiezKm/tCQRsSH9EtRaL7ToHGuB?=
 =?us-ascii?Q?3UPP7SzrIAPHqnoQc0zfA8RvEca8mNlI1RQpqKX5/1xOdqZJmNMVDViqsbvH?=
 =?us-ascii?Q?5MICOiFhnU7tuDoVJ9wIWiNqM6+P32qdNyn6kRNRtJV2Cp9fkv59rgwpnhdc?=
 =?us-ascii?Q?9jBbtcgZQaPMP/s2zOAb0M/jHq8xIb/ZrmWUPSWCzpP5zDAH1dlaytDkqL4m?=
 =?us-ascii?Q?5to597gGmwHgflx3TDsQm/DbzqvlB5gSIRXYUFrZ1HMNSFG60Wy1GepBnxvq?=
 =?us-ascii?Q?B7by4Hto1jq4x1cB+QasIkP9m//Pe+WgiLYkUc8YP/7fYJlvCsh9xikWtcHv?=
 =?us-ascii?Q?sBenQH1ikLqBaaMGs2TaOkRe6FaEioBi4wLxy4JSMe2gHDdLeSHg2de3nqbM?=
 =?us-ascii?Q?TjMVDT89EeEvEToLxnzmM1ThgyJUmMGe5t01txQs+N7IqUwMa+3ZwHeb2WQV?=
 =?us-ascii?Q?JnhIrt+g4xlQazrAJ3JOxc+RmPXE64wuMUPhN/Vd3pwExyzp8K0Vy5XMMt+w?=
 =?us-ascii?Q?DINPWkSUxU7IEojlGvSjGFJiz098WnfM39Ol3PDqobz0971PldkDjnJuGdVn?=
 =?us-ascii?Q?Elh08ayAXSJDGtVwBnuOAD2R8AAZgmVFj8zDR1sKWTIt135jzrG9ePBKhoAV?=
 =?us-ascii?Q?QNDQKTroyqYUqgw5O+XRe+3T4B8Yorq9+6j0rIs8nY6Jr93PWj8j4xTkVnyj?=
 =?us-ascii?Q?cYnpmdTpQqL0W4XBAIvEnmlwcQsY1kCv9vPDa6rmArT6xHgTFonkmepf26DB?=
 =?us-ascii?Q?4F0WOWUyeyGrMCM+SXjt5ePkUYRYQjwH2090gXnl8xND4hrCoN7SjTIXJ3qK?=
 =?us-ascii?Q?O3y9tT+8WnTvB+ik+NAxBGVAyEVy71rCitYn7l14c2oGwNiuFxe11AEP3omb?=
 =?us-ascii?Q?045pJfSfMe+6YONghGgVultj2r2ftn+3oCgSVikwDN31yCMTrIpdKq+VIXFH?=
 =?us-ascii?Q?oMGFUorCUWji+P6HjD8YBBSBKLoUl3bQkKItkqVqGhBkmE0MN9nhGJsVwbYG?=
 =?us-ascii?Q?gvkUuodNyFiq4vM6j/kY5FtKroB+bdyGQTBq9AcjYG8gVyywiGKMtWX01pqO?=
 =?us-ascii?Q?1f/+dluISUcRj/ClecTzqvZQk8FGUa8viaUwzwp/ekRWfhzlJLlLD2lpsl+i?=
 =?us-ascii?Q?a8OfC668F/HSDFOoOlk403c4E7SKPx3Qxn2w3NRmOOMkC2pv2cOZzADwj4U2?=
 =?us-ascii?Q?ZnGTjIR5naEU8/XpBtvmUx62qACaP3MYfFt1LnaVihh90nyh+9dRp1xZ57f5?=
 =?us-ascii?Q?sQSkroapHew5TIKHnyu1v2w+mGSSP6IMQt5tJmWevdxvxPPbiXe7+1im4ZQe?=
 =?us-ascii?Q?DZQW/ZIiS34JFlam6NhWetWtcaRsF2t4ktq/djTQuLNtEk+gBH9fogOYzZxd?=
 =?us-ascii?Q?Ay7h5IAyvUVA8CdwoMYPfzg8+3VY/PfAk8AgXqQCflcTBdEm6FQNgQ1h+Vo1?=
 =?us-ascii?Q?IV7tBP8bExstA2ykJMTE92xeRigDfmYMvQykrJC+tMG/VEJp/GK+gDEkWf6F?=
 =?us-ascii?Q?+qED2AOIAkASbkVa8XAtId8sTy7Kag3BoT9zyOldwMEHu1Y+/cvP3Q/FdxTM?=
 =?us-ascii?Q?NqBdtUXfvl3b4lRvkVhhyWZ/OwaKqyNR7S37qYOFH7C5zFy8QATzvA4zHCdr?=
 =?us-ascii?Q?wUue5tSarsckxxTfIhJIOXtJAIs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:09:51.1792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7f0882-52df-48d9-1d06-08de5d51897b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF931B95D07

Each smmu_domain now has an arm_smmu_invs that specifies the invalidation
steps to perform after any change the IOPTEs. This includes supports for
basic ASID/VMID, the special case for nesting, and ATC invalidations.

Introduce a new arm_smmu_domain_inv helper iterating smmu_domain->invs to
convert the invalidation array to commands. Any invalidation request with
no size specified means an entire flush over a range based one.

Take advantage of the sorted array to compatible batch operations together
to the same SMMU. For instance, ATC invaliations for multiple SIDs can be
pushed as a batch.

ATC invalidations must be completed before the driver disables ATS. Or the
device is permitted to ignore any racing invalidation that would cause an
SMMU timeout. The sequencing is done with a rwlock where holding the write
side of the rwlock means that there are no outstanding ATC invalidations.
If ATS is not used the rwlock is ignored, similar to the existing code.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   9 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 223 ++++++++++++++++++--
 2 files changed, 219 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 83d7e4952dff..534e9a5ddca3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1087,6 +1087,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			    unsigned long iova, size_t size);
 
+void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
+			       unsigned long iova, size_t size,
+			       unsigned int granule, bool leaf);
+
+static inline void arm_smmu_domain_inv(struct arm_smmu_domain *smmu_domain)
+{
+	arm_smmu_domain_inv_range(smmu_domain, 0, 0, 0, false);
+}
+
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 			      struct arm_smmu_cmdq *cmdq);
 int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4648d0aad693..d94bb290d190 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2591,23 +2591,19 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
-static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
-				     unsigned long iova, size_t size,
-				     size_t granule,
-				     struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
+					  struct arm_smmu_cmdq_batch *cmds,
+					  struct arm_smmu_cmdq_ent *cmd,
+					  unsigned long iova, size_t size,
+					  size_t granule, size_t pgsize)
 {
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	unsigned long end = iova + size, num_pages = 0, tg = 0;
+	unsigned long end = iova + size, num_pages = 0, tg = pgsize;
 	size_t inv_range = granule;
-	struct arm_smmu_cmdq_batch cmds;
 
 	if (!size)
 		return;
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
-		/* Get the leaf page size */
-		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
-
 		num_pages = size >> tg;
 
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
@@ -2627,8 +2623,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
-
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -2656,9 +2650,26 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		}
 
 		cmd->tlbi.addr = iova;
-		arm_smmu_cmdq_batch_add(smmu, &cmds, cmd);
+		arm_smmu_cmdq_batch_add(smmu, cmds, cmd);
 		iova += inv_range;
 	}
+}
+
+static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
+				     unsigned long iova, size_t size,
+				     size_t granule,
+				     struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_batch cmds;
+	size_t pgsize;
+
+	/* Get the leaf page size */
+	pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
+
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
+	arm_smmu_cmdq_batch_add_range(smmu, &cmds, cmd, iova, size, granule,
+				      pgsize);
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
@@ -2714,6 +2725,192 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 }
 
+static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu, size_t size,
+				      size_t granule)
+{
+	size_t max_tlbi_ops;
+
+	/* 0 size means invalidate all */
+	if (!size || size == SIZE_MAX)
+		return true;
+
+	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV)
+		return false;
+
+	/*
+	 * Borrowed from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h,
+	 * this is used as a threshold to replace "size_opcode" commands with a
+	 * single "nsize_opcode" command, when SMMU doesn't implement the range
+	 * invalidation feature, where there can be too many per-granule TLBIs,
+	 * resulting in a soft lockup.
+	 */
+	max_tlbi_ops = 1 << (ilog2(granule) - 3);
+	return size >= max_tlbi_ops * granule;
+}
+
+/* Used by non INV_TYPE_ATS* invalidations */
+static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
+				       struct arm_smmu_cmdq_batch *cmds,
+				       struct arm_smmu_cmdq_ent *cmd,
+				       unsigned long iova, size_t size,
+				       unsigned int granule)
+{
+	if (arm_smmu_inv_size_too_big(inv->smmu, size, granule)) {
+		cmd->opcode = inv->nsize_opcode;
+		arm_smmu_cmdq_batch_add(inv->smmu, cmds, cmd);
+		return;
+	}
+
+	cmd->opcode = inv->size_opcode;
+	arm_smmu_cmdq_batch_add_range(inv->smmu, cmds, cmd, iova, size, granule,
+				      inv->pgsize);
+}
+
+static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
+					   struct arm_smmu_inv *next)
+{
+	/* Changing smmu means changing command queue */
+	if (cur->smmu != next->smmu)
+		return true;
+	/* The batch for S2 TLBI must be done before nested S1 ASIDs */
+	if (cur->type != INV_TYPE_S2_VMID_S1_CLEAR &&
+	    next->type == INV_TYPE_S2_VMID_S1_CLEAR)
+		return true;
+	/* ATS must be after a sync of the S1/S2 invalidations */
+	if (!arm_smmu_inv_is_ats(cur) && arm_smmu_inv_is_ats(next))
+		return true;
+	return false;
+}
+
+static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
+					unsigned long iova, size_t size,
+					unsigned int granule, bool leaf)
+{
+	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_inv *cur;
+	struct arm_smmu_inv *end;
+
+	cur = invs->inv;
+	end = cur + READ_ONCE(invs->num_invs);
+	/* Skip any leading entry marked as a trash */
+	for (; cur != end; cur++)
+		if (READ_ONCE(cur->users))
+			break;
+	while (cur != end) {
+		struct arm_smmu_device *smmu = cur->smmu;
+		struct arm_smmu_cmdq_ent cmd = {
+			/*
+			 * Pick size_opcode to run arm_smmu_get_cmdq(). This can
+			 * be changed to nsize_opcode, which would result in the
+			 * same CMDQ pointer.
+			 */
+			.opcode = cur->size_opcode,
+		};
+		struct arm_smmu_inv *next;
+
+		if (!cmds.num)
+			arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
+
+		switch (cur->type) {
+		case INV_TYPE_S1_ASID:
+			cmd.tlbi.asid = cur->id;
+			cmd.tlbi.leaf = leaf;
+			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
+						   granule);
+			break;
+		case INV_TYPE_S2_VMID:
+			cmd.tlbi.vmid = cur->id;
+			cmd.tlbi.leaf = leaf;
+			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
+						   granule);
+			break;
+		case INV_TYPE_S2_VMID_S1_CLEAR:
+			/* CMDQ_OP_TLBI_S12_VMALL already flushed S1 entries */
+			if (arm_smmu_inv_size_too_big(cur->smmu, size, granule))
+				continue;
+			cmd.tlbi.vmid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		case INV_TYPE_ATS:
+			arm_smmu_atc_inv_to_cmd(cur->ssid, iova, size, &cmd);
+			cmd.atc.sid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		case INV_TYPE_ATS_FULL:
+			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
+			cmd.atc.sid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		/* Skip any trash entry in-between */
+		for (next = cur + 1; next != end; next++)
+			if (READ_ONCE(next->users))
+				break;
+
+		if (cmds.num &&
+		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
+			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+			cmds.num = 0;
+		}
+		cur = next;
+	}
+}
+
+void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
+			       unsigned long iova, size_t size,
+			       unsigned int granule, bool leaf)
+{
+	struct arm_smmu_invs *invs;
+
+	/*
+	 * An invalidation request must follow some IOPTE change and then load
+	 * an invalidation array. In the meantime, a domain attachment mutates
+	 * the array and then stores an STE/CD asking SMMU HW to acquire those
+	 * changed IOPTEs.
+	 *
+	 * When running alone, a domain attachment relies on the dma_wmb() in
+	 * arm_smmu_write_entry() used by arm_smmu_install_ste_for_dev().
+	 *
+	 * But in a race, these two can be interdependent, making it a special
+	 * case requiring an additional smp_mb() for the write->read ordering.
+	 * Pairing with the dma_wmb() in arm_smmu_install_ste_for_dev(), this
+	 * makes sure that IOPTE update prior to this point is visable to SMMU
+	 * hardware before we load the updated invalidation array.
+	 *
+	 *  [CPU0]                        | [CPU1]
+	 *  change IOPTE on new domain:   |
+	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_new_domain_invs()
+	 *    smp_mb(); // ensures IOPTE  | arm_smmu_install_ste_for_dev {
+	 *              // seen by SMMU   |   dma_wmb(); // ensures invs update
+	 *    // load the updated invs    |              // before updating STE
+	 *    invs = rcu_dereference();   |   STE = TTB0;
+	 *    ...                         |   ...
+	 *  }                             | }
+	 */
+	smp_mb();
+
+	rcu_read_lock();
+	invs = rcu_dereference(smmu_domain->invs);
+
+	/*
+	 * Avoid locking unless ATS is being used. No ATC invalidation can be
+	 * going on after a domain is detached.
+	 */
+	if (invs->has_ats) {
+		read_lock(&invs->rwlock);
+		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
+		read_unlock(&invs->rwlock);
+	} else {
+		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
+	}
+
+	rcu_read_unlock();
+}
+
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 					 unsigned long iova, size_t granule,
 					 void *cookie)
-- 
2.43.0

