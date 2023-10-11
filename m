Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611B80D
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dzQk+veH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioPWRoXC4yO7RGZqzwjcSxpp44xsFpgrWgngQX/sef07XRAgRPmNwZPz0/6h5qJUuPjMo2RTjhhW7B8NGl6q/QuWWrCiDLtIanfLt8cAx6TbQsn2lAgHCMULc6TAXAVg37DDXjEA5E4GE2U6p7QpjDPNpOqVdkSxzOoghcp1NAx0NjNZOcRlB++OGq0sYZzRzsQJnvjsgb2UhBgNTO5KcJqyqCCtJ4nFyNSm3CWmPoyIuZqpuTkRjuKnyxEUWOmqOuK3cn5YBllkrYqPaMFzOcsGXQl+MthqpfEC5st9VTqQrvEkiRW4SQL9FtjE+5lEKNA7u6VeuW0NZp4Sr20UwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AheY92vkUiJ5a678ypXiBZGqbwjhyDCguTy7iwI+hJA=;
 b=g6ABIkrivdetq0v8QqbhuFxtg1lJN3ZCWCWBtJUzT1ps8o/WCZRMbgHSEhCCFZVrybRta5WyJ5mR/aJexzIZAmZOIC0wbV5+UtJAHpMIzoVTAZ4svv2YM5SYVdWOCke6qZdYqpeNpMHAm369HM5aJCldm54WmGT62PuWzNRztI9KRUWHpS16ve2jUI+BO/Te6VcdG82GIwA6mvIzGM69RYbCUM9XxX5nF8dV6sSoj06GLR8dLVrz/joCeE4nNq5HPy/Y9a6R1BgN9xmOR3jPkNKpgLsgRxkLDxI7EZEHCDh6eVexhu+aDp7LBdsWoDywv1vptzNnDSrn7RXej2KZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AheY92vkUiJ5a678ypXiBZGqbwjhyDCguTy7iwI+hJA=;
 b=dzQk+veHk3bUOoiWCyVwjHDCWpnx4r9H82Uy2aQAqs4ipikqL3MysjardFeTNGPVjKXuJtLJgTgg/zWVptw4/4EauD/XsyCgGKQyVwTyHRPqM5woIv9vhIEHDg67lXD4bT17m5L7IWNKc5v6Co/hLoFUN41EjuStP4zwGieBTl/iQcr0yTN1jujG3RzpuLUee+fDhIen880JZf9nUj9pvEks7zxk7FTCU44gQ3h0hfrT/UJ1ZVsaZEAt9xnFd10iJWntXUaHoaUQe9LpjOyV/p2ETSSSL8BTVSNocM4nVIywm3oMD3I4esU0G2V+cIZL/REzeVaFc3YL1XUwYgxUBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:26 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY domain
Date: Tue, 10 Oct 2023 21:33:21 -0300
Message-ID: <15-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:208:d4::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 376bc3c4-3f42-415d-2dd5-08dbc9f1aec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q549P3zmABXWpfrld+k7/TvAjRVxy40HBuVzIumFf2J3ItKdn/YzEtYqVihUC3gx9nlE6w79F36nbSDJA7M8O2x3jiPCzPjnJiEs4cjV69TOyk/21ai5BoSSKIoXuqleuy3S79ziDyij4BByBv45ZB47BVgtTZIwq2cLRoTWye21iqH+/nwCMLJeFr8W2CDKFB3RueH8ZyVHvT9TmS6+kDuw4lj6GkVq1uoLboh0X4UFC+JMHTJgXZWQ7h0dZPIcv0MISXe+ZU6AcPFpZSabfvKmIZwlvNt1GvRSab1RhU6hGqwe2C1D+Ke7yrRFQZJd4Es7rI+o/20n2Qrw56ocWwX72ZFNwyoWJEzEtaFBofCLz0xL2WmHLF14LY5pGJ78pP7O/WxyANRus7wTdlEFxdENkKmwIpitNmrGnZWKpddijYAGiDtcZj2wuUymW421l02zIQMkel3zALAtVmvkrcd+FIv63jhTj9oEgOuotNdDaAFf/GaI8fCnEgIehGETjak1gKipGps2E4iO+wGuhEWr/xESz2NYRGSBrWKweI6K+zARxVUDTaF88CzuywSx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7DLxJ5/m7gSCLs1tMNjL8qBRN1btD11947qZN1k0Kdnj70KYygpFryCvPPTt?=
 =?us-ascii?Q?OcrXt47mJYtdWRSulALegMir1uBIvYBX7SlpxH5nFe9dbkD9lwf/qRbfgcBe?=
 =?us-ascii?Q?5C08XbY2Pf9d8kHWl86IdfqKfuuG3/S94hM2vjsKPs7sdWJjUg0VNXiEyDEt?=
 =?us-ascii?Q?vgLWozbBkofRqOR4p551Rlv/OXbdut+NsckDnb+2nEQscL5/pwx73gjWDSeA?=
 =?us-ascii?Q?jOnnLexXAtL04RR3/oK2N5Mq7EnROGMR5MMobf+a347cn5Lgac9c+4h8Xehi?=
 =?us-ascii?Q?mKXX10U7Ezis6x3EizzKcx5osrbQN0ArxU8MEa+BR+3GPzXI7/vI84nZfmwq?=
 =?us-ascii?Q?xEQrHsgtNH7Kp8xi/rJ3MbXiXgHiXMtQvHmOeRUkApXGv9PfmSeotsXkuHLM?=
 =?us-ascii?Q?ZPVAM/v3+8iJmOrV4DfSwVoNFgYtFiwdS2IZSZjKSSdtkTsUK5FSIyMW0coa?=
 =?us-ascii?Q?sruwYQq1xTVFNJ810oarGKtmcb43QoDvHIq6S5W0PWWOTik5SRSDvCspotOn?=
 =?us-ascii?Q?CXnO2ALZRIWG10vcWeH9Jdih2241bfnGOBX+21IpZ6AcLarwoDHsdUcciV43?=
 =?us-ascii?Q?l0XhNWspdafLiRVeZoN9bz6dB8cceNGfMReAJzX1aQZHX03MgCQQToFVuu/3?=
 =?us-ascii?Q?HvIHDeQ1894JoXWytfxlk8LE4Pe7Y4HDaGWKaATxETLLD9U08wl68vYwR9hd?=
 =?us-ascii?Q?9loxpJ0b7ApN0qw6pq7E8ws4uaDarr3Ql+pwXxEdBBfAnSADqzi8VYjIwbis?=
 =?us-ascii?Q?VlNukQ0TchW/G+QRo9WyXrIkhbZfdhvVJJc1EyNpAriR2NPalkADrHYRoZLo?=
 =?us-ascii?Q?E3s0C2jPJFecqSITeiDT1esV5HLu3ef26gPUDhmR2i2BvCWhTdAck978Om29?=
 =?us-ascii?Q?ckLQ2Ru2r9VmJ8TE4rKvt6x4zkxm95maHDGFHN8MtrZRUzNUeydWiOZ7lmpt?=
 =?us-ascii?Q?YSD7S6dX7Zo1gv89GHAszTbEj8vNfYfGavVoSgYQ6DTKIHy9z88sjd3ylY7t?=
 =?us-ascii?Q?sJn9/wNQqi2VqKICwOd+M/aJ8iShx9tIwAnNw7v5PJaHxFWw1FlWvKnaqqPA?=
 =?us-ascii?Q?G8VFfuJF3HCRyZm5cK3jfE4KGzH2KIARi8CAhnTF5/aVHTVLdHbQycOxH5UB?=
 =?us-ascii?Q?PAWtJQwGOiLBCOq6+cc4/vMhlI1iQKL1FBqakasJYYsD0SgwcmqGLjmCuLnm?=
 =?us-ascii?Q?Nztu9oBW42CvHUdjUbe/rWFlcmYj0ZW8YXNkeoxj0UAgf8ckessQiB6kJLHm?=
 =?us-ascii?Q?FvAD7hwAFjUBYAUMCCTZm6EDrLSiQgwvBtkrvom6+MEmBRTFNtytdUVasN4s?=
 =?us-ascii?Q?HRorw3XOetMXboOJvv02o590oQFAV55SsX6INiNHgOX1eCMxjo4H4XeBvwlI?=
 =?us-ascii?Q?/EN3CSzxlPPFmK0ZrX3K65MWn9ASvZM4PJKbfV7khVTbdSmHeFfMe8yaaQ37?=
 =?us-ascii?Q?xAFIg2tuHTviyHxwa4LVvG9JLB+Dw4kzzmdP5jVOU9RIeAEIuYaGI7sFpCIR?=
 =?us-ascii?Q?Ye6lYXljTsDjk/xo5BruafrqtaeJJu0CPCsuo7ymrN50AOeSDbwxF3Azznom?=
 =?us-ascii?Q?7yl3GjiDb+JLRhH5F6heDKAwqnVQnca2HENzX6Ic?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376bc3c4-3f42-415d-2dd5-08dbc9f1aec5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.0782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKtDrkw3BkJOz0KhwmA5PMpXRa4NWMEMV6aUIZFBwS//HCzrZl8huCDp/H4261G1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Move to the new static global for identity domains. Move all the logic out
of arm_smmu_attach_dev into an identity only function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 82 +++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
 2 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 26d3200c127450..1e03bdedfabad1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2149,8 +2149,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return arm_smmu_sva_domain_alloc();
 
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
-	    type != IOMMU_DOMAIN_DMA &&
-	    type != IOMMU_DOMAIN_IDENTITY)
+	    type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
 	/*
@@ -2258,11 +2257,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
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
@@ -2459,7 +2453,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	struct arm_smmu_domain *smmu_domain;
 	unsigned long flags;
 
-	if (!domain)
+	if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
 		return;
 
 	smmu_domain = to_smmu_domain(domain);
@@ -2522,15 +2516,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
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
@@ -2567,13 +2553,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -2589,6 +2568,60 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -2981,6 +3014,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
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

