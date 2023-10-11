Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954279CA74
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/XaXrke"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkL1fTlCvDOH6JGnNMetMUhi+enVtASE+2ImVqiY0gL/HgqeadZ8/HmDT7VbNm/iJpGm1xkKf8WBVSJ0YZzyMj3pPl6zE1jmhRewywBhIROnVlJ2WhwyGvqPysYwdmwmkjCyRPQORONGb8IXWACU5F+N31T2FdCfNYIExoA/22v4v9ge4PI8HrYcqqZ5B6TCByDTOeovQaFcAQ84SjmW/tqumVneHx01uV/XxIt3qELOEd8t5J+f215PZGkzRJtFv1tpJw4rXENDlSTiHRIC8F7aUNxDSsVY/KP84p01VDfKrEAZwebg74ro80lkc9eTE0ng/b6mwl0jEulGu21/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9K478hMNK5IVtmpvvYY/RvphbbkNHSj0cPowTvj9dQ=;
 b=SEUAKN0NQuPwjHP3xaKbudMkFhRDmneLeS2fQG+ED/UZYXLjt/muBhiXpLyTRXRp3JgE7Yv4Dl+LqNGGXKkE0saQKHjw3JaqvxgY2w2Cj1jk9NJVCLUssbnLyP+gg9dF+d8HBh32nSygFVb5Y+U2CiSkM6SwI0NRUI7pMTMzq58P1xQE4vn5L19Eioa/YvlFAPzymVL+N+iCkgIT3jqby3b/k4CfZzJb9ebXpHobmAwxtxS7yFfThUpaYRl+A6LqgBdsNjb1i8c9Z51Ydukq6xWIjHt1viM0sseokXSNyGiC1iFEHaTQuLpLUiwxgLQ7ZdL/ivFywzoDoTikT0Xh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9K478hMNK5IVtmpvvYY/RvphbbkNHSj0cPowTvj9dQ=;
 b=W/XaXrkeeORn4OlcyhbelfKXWcI977aS/esVMrNgWVxDvG5JCtp+qd25hU7CcDQs6y8vksm3/UHBapAnmd0yJm0hZi6FW1M4DFnzjXMD/ubXAz0i7s5h74UEB92jx8GNYwPEsJKlhb/W0ax/XWKnz+IwqVBrTkg6gPGeo9HbyMsC+E6VIn7f1BWyDCP4L/nTVcriUpvU4i16GamxI+GaMNLV/5h/cLaWs8891gkwgsazmh6x5s4JV4RErpoh3PuUWSAOcEms39CHUnP5gRHWik8dtsBT9UMejRQNLHn80veouAHgdzdcWKBqtId+ZRDemPvnwvkSlfCFkiYvIvbmJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 11 Oct
 2023 23:26:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:15 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 26/27] iommu/arm-smmu-v3: Allow a PASID to be set when RID is IDENTITY/BLOCKED
Date: Wed, 11 Oct 2023 20:26:02 -0300
Message-ID: <26-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0044.namprd20.prod.outlook.com
 (2603:10b6:208:235::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: d6525e01-d0b2-4e23-e26e-08dbcab17118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yRGZTrTMK+8K8AEj/enCWSeJ6FMuvz8IAEcceKAaLU0SxJ5gA/ZLVbkLtqsyB9hvIRpj6nxeCFhKPYoMfuhSObADVZyuVFvsHQ1xhBIwJa0tUa13ocnQzhIiaIigp1UIxDYQhMoCr2QrMke4B9peRnYC/eOIersKoHfa1X5Llrz2+q6iLcY0yhJxQ0Yh+8X6p4CUeOEO++ZATNE8k8R2Uq97T/rEXHnjE8kOZxuzGzAach3Ztlwa10VQ9Kt8RufmoznwY4bAuyIuWQeoV9pMuKt9eLWwnjKnNWy1psQbmoSKQMGahgwKcT6y2zMu4QTr2fuiKyBCgweDP+n8L6zGRfdfBgnhW56A6TRsGQiMZ4EO4rD1m3tIkj2xn8MlujeRsMEKuo/Su2+NfBiJOrAI19VVFXDZ70VfpDkEI+eC+Rhcfo0wTjVYP6qW57p15VWtGsdPdm/00ZPXtIuNd6Nnf05EYWqB3/74IepLh4TM3q3uAaLDJ8fqwHQyILnnpjKJnN/HeTC0S5DXIB51vW6krpKss7ZHGGq/dIp8BNmYOkD8Qd00tvdkkRSVk0708zsY+PvGRnJg1gx2IBElTfY3yYHBIBaYRl07xI7dN2Q+RzmDaZveEEeCwM6RCNCGkehiwzZom0apYy0Fbv9u8Y4N6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(36756003)(6512007)(6506007)(8676002)(2616005)(83380400001)(26005)(107886003)(15650500001)(6486002)(6666004)(478600001)(38100700002)(4326008)(86362001)(41300700001)(66556008)(8936002)(316002)(2906002)(66476007)(110136005)(66946007)(54906003)(5660300002)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gidhfiap+Y9BmyxcZAIrhELti2GmKqFPDhnc2JuzPaeEzDRbaZGkyt50V/1a?=
 =?us-ascii?Q?OyT2z7U4Uom0+CaIX/nlLbnwBuKa5vx0mwWLqAjouC6fWjSdpT8WYRzpaUEZ?=
 =?us-ascii?Q?g5wSbf8Igf8syybPnDNfUPNcQG9kl39yZaGWlb4tOlJE1fgpw4uX9ZpdQ7So?=
 =?us-ascii?Q?vogqZeA2Z2ms9BFXxQII3LxtHOSNXWIU58j/hbbAgNWGRfNQg4FPRQKIgfiO?=
 =?us-ascii?Q?a1Rbw5A77B+80llgDnZfa7LnVaAU6Z5i5kU5u8yluiva6l4Y9ExMXuGadCkU?=
 =?us-ascii?Q?UHY7cVcSw8Tdz+AOaZS6/cRIlN5WLiyuiVAqoplVl1jHaeB58pp5X+Elj/BM?=
 =?us-ascii?Q?aE+f32RSgzNeEWoslYpjKQy6dL3NMGnsHo687lh6EL/0NHXrbYaCk0EyhiEl?=
 =?us-ascii?Q?0Glmv5p2jBagSS140WbAVNRX3qUIhx0qko26pfEL6yyVjTguvlXeHGEh9db+?=
 =?us-ascii?Q?3Wi5CbXHLyv7D1ssib/k89jIn+i9+frfU5zH++TfUju5bqlVMCBul5hF0JzW?=
 =?us-ascii?Q?otm7gzrfi2KPwBp+G6iYatQy8LHI3Ktc1k5w3PgiRRyEF4n+iX7kxOdhlW+P?=
 =?us-ascii?Q?+Ap3fzICVQvJCGTiRs2T9OtCiC+95BLHqRfYmIiyo6RJfnju8sBcTTWvj4qp?=
 =?us-ascii?Q?6WFi0jW7RZxBnxPjRtXs0tTVM9JlodDZG3dz0V7rgsc70Zh6t/tITQCLvUuy?=
 =?us-ascii?Q?gp8OAJs7GgjugpS4wHQJnkAMZ1f21r6Nm7i1Io1kx/bX7mTKOAcgGxstD6V8?=
 =?us-ascii?Q?P9YoMWG6jM9ZxAcqbZFBrCHBvGbJgAbfK7Av1dI3uaPIIuGWIbsIkk816RHY?=
 =?us-ascii?Q?5X9K8TgNv/CS4T54YYI33vxq4PIBa1nhA2Uiian9qIZWZIVbu9AL1Cpw3NxS?=
 =?us-ascii?Q?xaMl42qozJnBQHntmpb8CGoqx9tLDyq3dEbFmLpzyK+KznV47tGFYqzbCvMU?=
 =?us-ascii?Q?q10lEwLRWuZTFTXFDTEbIE4OrzIPyBlPXXSLfb6tu2PsYit8V/ZbLDb00+r+?=
 =?us-ascii?Q?bAR/UdMUiw3nNYEvC2xBKLr6L2a+BVBkh/8zPumQQPIDuw/D00pRxjAA25zd?=
 =?us-ascii?Q?ETt0GSWm5Ltacb4Zt6Dl6ewH5NVbhNx3yxMPWHnrql35d5zs1Zat8LD/lBF3?=
 =?us-ascii?Q?+ZPN0iEv0/yGVUI+k3kBWDmbBwy0gs4C6YUQIWDaIfMO+RdQVy+cRfFbDjf1?=
 =?us-ascii?Q?P20Cg5A6wQM/Psxoind6qzyQGofZ27QtAAbvsFlJ4jiSEkNJywDsiNdOIxXh?=
 =?us-ascii?Q?HDZg2mqdXN4J9bPGDuLzXJNh6waTskvnNIg1D4RJbskWuZ3CJHm+kxD/fnWR?=
 =?us-ascii?Q?NyAfXexdlIlIr74Nmkjuy9Gm4gMgsdWPIGBNvJRPCCyWlcNJa8rum4lY3ThS?=
 =?us-ascii?Q?k7phIEKDEMQKBNFswS9bW4n6tg7UGGEsmqgWgNgWQc9G5XFau3EEmCNEnkkA?=
 =?us-ascii?Q?28SQUVlrvVdaPVM+Klxf6IsQbSfSweYVXqUHu3f3KMwaH1rPMANYVUNbcvDK?=
 =?us-ascii?Q?wbu+NAgAgxJOgzy9TlV+R09BSR+UBpP18OqSjXdAYQ21JjQdTgzCETLdz/fl?=
 =?us-ascii?Q?NmjH9AoeKz605jNX3NS6SxRP7u7tnQwHe53D0h0s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6525e01-d0b2-4e23-e26e-08dbcab17118
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRO+TVc6mTnSF2Ms9VK9bjfl62pTpe4fOIu3cK+YS26GpHROJHXFpgzgkm7L+GaT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

If the STE doesn't point to the CD table we can upgrade it by
reprogramming the STE with the appropriate S1DSS. We may also need to turn
on ATS at the same time.

Keep track if the installed STE is pointing at the cd_table and the ATS
state to trigger this path.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 57 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 ++-
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 83d288fef51249..8eef125018d082 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2360,6 +2360,13 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
 
+	master->cd_table.in_ste =
+		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
+		STRTAB_STE_0_CFG_S1_TRANS;
+	master->ste_ats_enabled =
+		FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(target->data[1])) ==
+		STRTAB_STE_1_EATS_TRANS;
+
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i].id;
 		struct arm_smmu_ste *step =
@@ -2690,21 +2697,48 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
+static void arm_smmu_update_ste(struct arm_smmu_master *master,
+				struct iommu_domain *sid_domain,
+				bool want_ats)
+{
+	unsigned int s1dss = STRTAB_STE_1_S1DSS_TERMINATE;
+	struct arm_smmu_ste ste;
+
+	if (master->cd_table.in_ste && master->ste_ats_enabled == want_ats)
+		return;
+
+	if (sid_domain->type == IOMMU_DOMAIN_IDENTITY)
+		s1dss = STRTAB_STE_1_S1DSS_BYPASS;
+	else
+		WARN_ON(sid_domain->type != IOMMU_DOMAIN_BLOCKED);
+
+	/*
+	 * Change the STE into a cdtable one with SID IDENTITY/BLOCKED behavior
+	 * using s1dss if necessary. The cd_table is already installed then
+	 * the S1DSS is correct and this will just update the EATS. Otherwise
+	 * it installs the entire thing. This will be hitless.
+	 */
+	arm_smmu_make_cdtable_ste(&ste, master, &master->cd_table, want_ats,
+				  s1dss);
+	arm_smmu_install_ste_for_dev(master, &ste);
+}
+
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t id,
 		       const struct arm_smmu_cd *cd)
 {
-	struct arm_smmu_domain *old_smmu_domain =
-		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
+	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
 	struct arm_smmu_cd *cdptr;
 	struct attach_state state;
 	int ret;
 
-	if (smmu_domain->smmu != master->smmu)
+	if (smmu_domain->smmu != master->smmu || id == IOMMU_NO_PASID)
 		return -EINVAL;
 
-	if (!old_smmu_domain || !master->cd_table.used_sid)
-		return -ENODEV;
+	if (!master->cd_table.in_ste &&
+	    sid_domain->type != IOMMU_DOMAIN_IDENTITY &&
+	    sid_domain->type != IOMMU_DOMAIN_BLOCKED)
+		return -EINVAL;
 
 	cdptr = arm_smmu_get_cd_ptr(master, id);
 	if (!cdptr)
@@ -2716,6 +2750,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		goto out_unlock;
 
 	arm_smmu_write_cd_entry(master, id, cdptr, cd);
+	arm_smmu_update_ste(master, sid_domain, state.want_ats);
 
 	arm_smmu_attach_commit(
 		master,
@@ -2733,6 +2768,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_domain *smmu_domain;
 	struct iommu_domain *domain;
+	bool last_ssid = master->cd_table.used_ssids == 1;
 
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
 	if (WARN_ON(IS_ERR(domain)) || !domain)
@@ -2744,6 +2780,17 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	arm_smmu_remove_master_domain(master, smmu_domain, pasid);
 	arm_smmu_clear_cd(master, pasid);
 	mutex_unlock(&master->smmu->asid_lock);
+
+	/*
+	 * When the last user of the CD table goes away downgrade the STE back
+	 * to a non-cd_table one.
+	 */
+	if (last_ssid && !master->cd_table.used_sid) {
+		struct iommu_domain *sid_domain =
+			iommu_get_domain_for_dev(master->dev);
+
+		sid_domain->ops->attach_dev(sid_domain, master->dev);
+	}
 }
 
 static void arm_smmu_attach_dev_ste(struct device *dev,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 28a03bb3d6d3de..5cb3b602b6baf2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -600,7 +600,8 @@ struct arm_smmu_ctx_desc_cfg {
 	struct arm_smmu_l1_ctx_desc	*l1_desc;
 	unsigned int			num_l1_ents;
 	unsigned int			used_ssids;
-	bool				used_sid;
+	u8				used_sid;
+	u8				in_ste;
 	u8				s1fmt;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				s1cdmax;
@@ -708,7 +709,8 @@ struct arm_smmu_master {
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
-	bool				ats_enabled;
+	bool				ats_enabled : 1;
+	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
 	bool				sva_enabled;
 	bool				iopf_enabled;
-- 
2.42.0

