Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3E22EE3
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oP5jQ5fa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arUUPau2QScVYr9Pk6JaVXnGQGPzXU23lh2cIGIRF822GX3QtIMMUl+4xBWNJUaivOMFtA4hFcHhTjAMoopica+r6nIuhdHQNeNzRV9XtJvb3w4fADf5i6qS+nQhyCelJpxGCLVyaYAeP3ui9TAMWJLoWu2CwOlAOCDKWH+RTspxXGH0pvvTUL3kzPbpaasyY8qsPem4oa7m2EXdGFi8srKS2RsLjiLWBZOG7rjRKQHQ83dccJzNGOtqun1jfRFN1sAjV/kX69uS3Pr2GDivyN2l4RabEhVV43/WBfA67fr7eaHiV0yWc5ck2E3igNJnSd/KQRwIIWV7WwASp2xGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gafHm90YyaTTunyvL3ecHyFxShSnY+zBl7BLNowIgvE=;
 b=SGP//AL2ya6t/AG2B+SgK5KF0K7Fs+CF13fALG1A528EiI2C9gXitjz64iRrFFHyQyaEYVtK+Tnowbiy0lekotwA3VQ9K8QeQ5gG0KS48gDPDt2KEBt52c4DpsywBannU+bYh5b6063nBTS+MY7uiqIJ0KczHoz0GAs02evjzcvN8E1YgKrg68msVnSA76D5SE+JtTy8ols3noBpTCFnbY1iJxLRBxjhQ1SpNBvgav/iBMHzED2qO1W2idnyWmtsJSXvbUnOsCAWUwk1ZVfOyhi5qoWenhEJRfrrRsHdg4OHzlZiTgNV+gMXmQTniHzBsaWl6ujsWN1thRLsh1udJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gafHm90YyaTTunyvL3ecHyFxShSnY+zBl7BLNowIgvE=;
 b=oP5jQ5faHSDTEAHPuUhQhRtSoCF7n+F+fJ7XKG0jUaYUJeP9z55OrxqJCW6mdr9fQthQXDlDWkvHfs6nIhlYHaoV5e2WmWQpKyWgen3zg851LtIEt6bhNGzOMBDRej4XUSZ3ZQ2kwiFjfM/eDt3RuqBvQ5B3RqBWIKNGYYG2s7oN45cK5O/6XoXFOhK+JCrakb7FbExHyAc22TygxwlGEF9AtAsuDvy2IL+zfOHVqCWem4wTUW9KAbqdfQcV/q6aeyaLUpK4HuevvXGlGcIKrsFAqfnEHc4/Y0bJalty82g5tqE6ITCdgVsQWvqwFk4Tz8jFmUE6UkznlcyPWLDcyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:41 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY domain
Date: Mon, 13 Nov 2023 13:53:22 -0400
Message-ID: <15-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:208:a8::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 1876ae5b-f9a6-428c-5cb5-08dbe471716a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xeFlZS5flyhxjS13ml+8d3K84uKTQ0Ui2PwSwGiIgTsMm9sNNn/PXWHdXMHK0RATKtLVJdLNv/WdVRb97HmsWwdBlzjAsrBWtLp14sDyiZzG0XEXj2RCfoM/16Au35z5dMUyRxVHQARRoz709dhOZj0yhCtmDiZMOGH2VpyzOxr8ZV7oE7HI9seKqhtS1M/hGmH5aPZKDAw/QQSLL/F3x/52FNsUFU5JIkMkGxjU0eQ3N5pHFfc6lycX/BGIqRq2gSAh9MXSLv5eX/7qdrqAuyp/xEAvqn8B28nS4IUwejBmIufCG5qGq5HAijHhkTja1S1w/N4w9XF6T9InT3tKhloCyw6y0Z/XovTDdMOkqI1NnUGZakkNLJmu+U5LDyTFZzFFacTMj9ZA/woG9Dq1ME2n5Sx8M9v1sET5/I24Bw7pq1aJXB51qMC3miYGfCQTGKMSPMMwwlbfQrQm1Y78MIBNu8GC2CUHf4KV4pkTMCbp1LWKK0uKyF6LYCUTW9l2bsWJonXVFSABnr4m+R7lRPrllFq13nz7xxE4o1YPIMamUlljMP8bF7WgcnRpun/a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZBeYi0EgrC23iMoQpRGMnBkOo53GFRWElgipV9ZjUrQP1oc/jm9UHCAG1nRg?=
 =?us-ascii?Q?82snVOxfDCxDZFXXb7a8w2cbvoW8KgijY4HT8p1WbdVMxfZ/Aw67VrXBMJek?=
 =?us-ascii?Q?5sHyz1vjLyDtgVnDOSu5LBTHdwRlTxIM0aJvCtD/xeOtiy3tETh09Tp1TKZB?=
 =?us-ascii?Q?Lcg56eIWxqJuI/AkPXFMb6U9XztE9LbnQG05RFhLup+hWTUvIQ22zOUTrhWV?=
 =?us-ascii?Q?rx0LFVuzSwxFElS8+s2yX8u2qCS3k4RK/q7Y7+QTf+FGYTXUQwW8TX+2GXQl?=
 =?us-ascii?Q?uFQ/ktWKWcpbQAAx57oespIlEzkC0UssVuzeWy/6IqSi4POaJyrFXsX2I7qG?=
 =?us-ascii?Q?+R5VdYKbNJ50NZ3XTeulI5jdOehN7tXLgyrr9MdUhqnO817oIQ6yIJziZlYF?=
 =?us-ascii?Q?mWNsKp1RtIGEsUN9SkFTvFwhXhx77p4zo9f/zB4Bcq/j6WDDm4n0Q4p68LKo?=
 =?us-ascii?Q?dMAVlCr3EazGuagiaRBn99fR0mouNpcLwWuf1fknrWpTM0X5vXdl47o8GR5f?=
 =?us-ascii?Q?OBaRF+xIK4k1rqDVonX4AYKiYr1/uH9Cv1oU8DrZllkOwTa/sPStuD61f3C4?=
 =?us-ascii?Q?K4fn9W2mMafOnasiUUB4zO5BuG/EZkIGZ6JnFu2ILCZZgeOpzOpquBu9YldO?=
 =?us-ascii?Q?6P+X3oXuFgc4rZT6b8C0ko67JCpEX/ZwUz00zG3x54uX2h0b8VH655H6c02u?=
 =?us-ascii?Q?rMDOz19J6QvP3WPR8iYd7HUGIKfB5NVNV907pGMpkAaej2te72ApyO4jke0O?=
 =?us-ascii?Q?CdocKhtlmaf53NCoiYGDYLakG/LLHpWAtTYQyteaQela1qW+aHZTd5z3Ultd?=
 =?us-ascii?Q?IHfAQn7AsaiJ9p0yjA0KMyzn3qzEFP7FXOHC6vPmHXS6reaKf5WnPtsuctnt?=
 =?us-ascii?Q?pejD+r/s+vI/j3qK5mQ89M0btZwliYyoWbYydQRTbnRR49RjCazk5TexF+Cq?=
 =?us-ascii?Q?6wVaromBX4W3Tf9JCGUFYkRGR4bFiDJwi2gxgDCYmPjeJofsWvJl82tGOWS5?=
 =?us-ascii?Q?TM6F/VJabaTv0Hn79LQFzqDC682llg79xV9OkkLoPKBmiRdp8U5AX04wQE8H?=
 =?us-ascii?Q?rbYVlA3PIY6gUwVdqQCnQDmfW7BCCfUj1lkU6O0ayNHCL3GTW90ATGXGg0RQ?=
 =?us-ascii?Q?lCrCQFejoLdPzhR50D3Xuiz/a8l7JvvrnfW65F4j/DZoB3JKtE/QwHZr+BGK?=
 =?us-ascii?Q?vh/gRqXsuATOsUtRouE3UZ1py1t2tdsGeshkl8lij2o+sEYdTtKp1V6phYVr?=
 =?us-ascii?Q?hi0wO+Sg4hESkKD1wBXm85LpOpdhbOX+oYyFacn1ckS2m/xI1OXvfuQaMoPa?=
 =?us-ascii?Q?cURFvtUsYrc7rY+97QihKJAeC6XZA6HhE8OdPvpdRVbcnDNThCaEGLDQPAyF?=
 =?us-ascii?Q?PLdxpc4Z+yQ1q8Vd/ibuPVSP2IIv9Mi9fL6to2PS3lT3wcqxNvw6BoIAdfcj?=
 =?us-ascii?Q?iA6tS4DPSD3NrDTGRXoTvHqyHRTCVmlSCh38u+0EhAm3xkOtvZXfATyJjKII?=
 =?us-ascii?Q?FOMEui1VPiX8MQrcui2ne+H2PmYimxX1atx8EjtXyvww9UoIsEFO+O7sdfyz?=
 =?us-ascii?Q?MQ2GcMGzsRXVJFCaVXE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1876ae5b-f9a6-428c-5cb5-08dbe471716a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:28.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/usRftTFkvb4Vx2D9+9V4m3/xdkucfbSChEzy85UWfK+laj0VxYHzHESz9JO3gn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

Move to the new static global for identity domains. Move all the logic out
of arm_smmu_attach_dev into an identity only function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 82 +++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
 2 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 23dda64722ea17..d6f68a6187d290 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2174,8 +2174,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return arm_smmu_sva_domain_alloc();
 
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
-	    type != IOMMU_DOMAIN_DMA &&
-	    type != IOMMU_DOMAIN_IDENTITY)
+	    type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
 	/*
@@ -2283,11 +2282,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
-		return 0;
-	}
-
 	/* Restrict the stage to what we can actually support */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
@@ -2484,7 +2478,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	struct arm_smmu_domain *smmu_domain;
 	unsigned long flags;
 
-	if (!domain)
+	if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
 		return;
 
 	smmu_domain = to_smmu_domain(domain);
@@ -2547,15 +2541,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	arm_smmu_detach_dev(master);
 
-	/*
-	 * The SMMU does not support enabling ATS with bypass. When the STE is
-	 * in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests and
-	 * Translated transactions are denied as though ATS is disabled for the
-	 * stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
-	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
-	 */
-	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
-		master->ats_enabled = arm_smmu_ats_supported(master);
+	master->ats_enabled = arm_smmu_ats_supported(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_add(&master->domain_head, &smmu_domain->devices);
@@ -2592,13 +2578,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
 						      NULL);
 		break;
-	case ARM_SMMU_DOMAIN_BYPASS:
-		arm_smmu_make_bypass_ste(&target);
-		arm_smmu_install_ste_for_dev(master, &target);
-		if (master->cd_table.cdtab)
-			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
-						      NULL);
-		break;
 	}
 
 	arm_smmu_enable_ats(master, smmu_domain);
@@ -2614,6 +2593,60 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 
+static int arm_smmu_attach_dev_ste(struct device *dev,
+				   struct arm_smmu_ste *ste)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (arm_smmu_master_sva_enabled(master))
+		return -EBUSY;
+
+	/*
+	 * Do not allow any ASID to be changed while are working on the STE,
+	 * otherwise we could miss invalidations.
+	 */
+	mutex_lock(&arm_smmu_asid_lock);
+
+	/*
+	 * The SMMU does not support enabling ATS with bypass/abort. When the
+	 * STE is in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests
+	 * and Translated transactions are denied as though ATS is disabled for
+	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
+	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
+	 */
+	arm_smmu_detach_dev(master);
+
+	arm_smmu_install_ste_for_dev(master, ste);
+	mutex_unlock(&arm_smmu_asid_lock);
+
+	/*
+	 * This has to be done after removing the master from the
+	 * arm_smmu_domain->devices to avoid races updating the same context
+	 * descriptor from arm_smmu_share_asid().
+	 */
+	if (master->cd_table.cdtab)
+		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
+	return 0;
+}
+
+static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
+					struct device *dev)
+{
+	struct arm_smmu_ste ste;
+
+	arm_smmu_make_bypass_ste(&ste);
+	return arm_smmu_attach_dev_ste(dev, &ste);
+}
+
+static const struct iommu_domain_ops arm_smmu_identity_ops = {
+	.attach_dev = arm_smmu_attach_dev_identity,
+};
+
+static struct iommu_domain arm_smmu_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &arm_smmu_identity_ops,
+};
+
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			      int prot, gfp_t gfp, size_t *mapped)
@@ -3006,6 +3039,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 }
 
 static struct iommu_ops arm_smmu_ops = {
+	.identity_domain	= &arm_smmu_identity_domain,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.probe_device		= arm_smmu_probe_device,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 21f2f73501019a..154808f96718df 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -712,7 +712,6 @@ struct arm_smmu_master {
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
-	ARM_SMMU_DOMAIN_BYPASS,
 };
 
 struct arm_smmu_domain {
-- 
2.42.0

