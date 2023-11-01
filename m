Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A331C69E
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JyI6/Nm3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2be0mjnAkiLvbNNlXitFf5pBlcqXileYqD6USHFGSiryRSK9Wco2p0HPLg2XkH2LCYBsBCR8QCo8vDyfNX+aAcpEDvRAdcB9djF4akqoerjFd96HfC/SYnVfI2urRtYu6RjFYBBq+OnpuZ3YwHAKktPMTnPC7J//tV5n+5g38hmvyi/SyFAKZqG7oaOexL3czVibgNXtaVNvg99xqvixSYEgrKyJeCvE/Z0x7bE1On4bixPE/Kk/xRELudADUZUSrEC+VWVz8BrMWgZeDfSusVcDdbCL7vcCUL8WVFMS0xrUt+KIg4+QYchw+czba4hCEp08Mxq7tztptwnP/FIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQnrUTakMA6dtB5Knm1CG6ZeLxGQgDwlzM6pmF2tGtU=;
 b=O4CqDz7mDeyeTCKMEkzCN4Hi6Km+y8KWrU3xcYGDHaUXeO2suTbbANndgM2MVbW2TbLwVk74E7EX5dQtiZlIveJEm68ubxfRoexr/85+THJy216S9Z5Quo+7/MErOXNFYl9+w/ECW+E+O2p4d+LqMg7WnmMNXS1OFByzIWcJuLrkc+4BrVRXRN5y8egl2C5UxAYfOQi24/ZRVnH/pQS/DE8l6zswF5+wvBFJnI4FSXUji9N5eudUp8kw3OEWCu+t0kPvjSJblxY+ti196Azikt1Pwc9sxlkKJe/UnjUNrzvtxKwNfYmUN89XKrsefvB8wuPTY/n3FcihexHUNpe1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQnrUTakMA6dtB5Knm1CG6ZeLxGQgDwlzM6pmF2tGtU=;
 b=JyI6/Nm32iwzZyZa8JvptxqqDOoJSSflHRT61qH5LzJCfQezpKnnJsAZUB7UEOXBx6bC/8rRAfKdxaIt0p7Icn8wmsHNVTSRzbJ9J2wLEZQXy28P1JvuaWJvsZGsa8ExKMWSWUvbyJ7qmF4YNKrBax+vzgcC2RsbqMQ8ODd3h+DuvTGvj3hisYvvqdMFNaeOcDVEYRdvMPhpPGNJG44KvSJbd2ofmWkDqxn2naFPmC3r/+lDA36aebLxYOKEmQ/Hcr27EcFUOTFFjzb/whWOYF5Flctwk+bjx0bFCNcriXyLLR38D+zM3VTj0iJk9wEq+P3//NGBtvsVMqdsmNL3Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:49 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 15/27] iommu/arm-smmu-v3: Add ssid to struct arm_smmu_master_domain
Date: Wed,  1 Nov 2023 20:36:33 -0300
Message-ID: <15-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0060.namprd19.prod.outlook.com
 (2603:10b6:208:19b::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f5a5c9-4239-458b-b96c-08dbdb3369c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RUylVwDCUMlDYoEJmnNibH8IZbHi5empuZ815AJJm02C6bBGb8jOklFoYJbihGfNFntrYWolQyVKckT8js4qfpQYeUhsCdVN8BBtu6d+xtbeTIMAvbphlgBP0KCjqwoxjF4hdw2QQBE7oZ09iF6F35rRidhHOArT92vwAW5OiNvJts4EV2BstndzxZEqJntb6mOOgatEnHkGujDTnw8xNJZ8Q4NDZCbobhPlB+8ljVthHK8l5qgYtCvoel8MkH9hzkMia0XL1jtl4Bj/jwatu6famY/IzK89citFxiMjxrYUsCfgPjSBesqhfKgn9Ihxqn9VNGAMFO35Xx6HGsRPQ3tODSdxAV7lhSuHy6FV8GXjD0HuIDluIxfEMHaJySDkLkeDWlOQy5Z7nrikvxsAnZQH0+EvfeXhUGzpiQq3q7q1OBEOUYwWSjy+ZfaHufwIph66umBbyEWIrrcIxFDSwbO87JxCak9GgE8DeAbkpZEJE+BHgnVvzeItEHPMDK+bos0h7RQMUI3AUWPCrVfldc/nfuDIIpwZIEV/olwi5AtebhUMnCW0NhKakbf6SPk8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K6UBTs6iRENxc8KZ15/bK/d7tnQTyUZmqe3nfIZt0I/cgLQt/s+XipQXmwHV?=
 =?us-ascii?Q?NM1OwtCIDJx3zgIjxbSluROaedM6CjJF8/CMBLuIe01u7bvHCgb7A9sfEU3U?=
 =?us-ascii?Q?/iZult94M+Fv/4mDa3lKwUym0AfbfyjHK1DlyMrkhnTXAqHRtyn4wVtpC+YU?=
 =?us-ascii?Q?uYiv1rd+8gAE/+fa1WirD9sB5gKUkgrq7HTY850OAWppa+8hfiMuBoVl8Yd9?=
 =?us-ascii?Q?tgCbNGV72loQWGJpRhhgSXENEHYz31hB6wsHL4idYRRhzn4ivwPtSGFGSvcl?=
 =?us-ascii?Q?+Wu94TEiUvJDbhUIjK15bo1QauJRQ6lQ7eCPF6203ulWJMcrShCktUyG4ihO?=
 =?us-ascii?Q?gR1oLozrRmM4VQS0bupyEqzZtxDkgIexdDCoTWStkE5h0ph18wySEJktW7Bq?=
 =?us-ascii?Q?bI24i+vD8E2VhbQTr9xX+vAeVvyv1w5IlyHbN45qpoSeXOF/hc9AuVLRE79R?=
 =?us-ascii?Q?BWTl16G7w50pjvUWJtFCeKN3U2lM3TPoS1GUhJ8bI7ScWzlfG3n8Wr2Yhv5b?=
 =?us-ascii?Q?3U8UlkI5svlDsyEoQgrPyZxP56HL5l1HeZsjBBpAAPLis50KBlhfBsss99f4?=
 =?us-ascii?Q?BjdxPydG0xTcUj15PeTyUQQaE6MbSz+fmAwL76nu0CGSMieQabXUNT33q6eM?=
 =?us-ascii?Q?kPz5KDHDPKC75fNhlAi5RpJeDgcu+nUmK/5tSFTCU8q0p4eBXrY+UkoQicPe?=
 =?us-ascii?Q?sdNyj9C7LREwWahJ//iotPt049LNKh22PtbcmxAe1C2o6Fly31emFUnfxUGr?=
 =?us-ascii?Q?qJtlx/4ev6RFBivvOf66YRacH13U4PKmO/KDcp7RiOpuvsTRW9gbxDMMnqrt?=
 =?us-ascii?Q?rOqTEBXvXOIH35T04VWIi33ku8kQk1vTwcxQQFwJfCoF0f9hQk03+psVR30V?=
 =?us-ascii?Q?ImVlbLQGCRt7aSH2MC5I1yT/slhLFIH5Jg1j1JWLPi2yXQyzZHpH2mCZgyLh?=
 =?us-ascii?Q?1JjadlCV8JqxvFo74SOu6Q6WtLqEtsBrN6F+Qw94iNUZcOFnWrlp7RmBMH9O?=
 =?us-ascii?Q?OdBNJG3PGdQPv10MWM+4ci/HpbuncWS6IV2EXgFB+43s4plrqhCTDs0Wovia?=
 =?us-ascii?Q?YSzmxao2Zl440z6f0wRXLaiIEkWUAWqcGC4qGJ7cMZD9Py7DMca3ixuIrXTw?=
 =?us-ascii?Q?yrhJayO9H/s+4BHoXcRat6icKNFJCe7JGg49b20MYJ+EYaKDmG4Q9Fwz06bd?=
 =?us-ascii?Q?Jp7l1oQ+WkO4JT7AkHa5FDTomv76FSiP4DWatlChKDrt8kTPS/XsFZHhpd9R?=
 =?us-ascii?Q?Z62Fw48yeXYUslvk+4ONtYs79V/HXfmieTcPUus9i1l9K/oZJ5KUknRgXGih?=
 =?us-ascii?Q?HBPzjIfBbzDgHYpr82uJmvrMGTVzk7akPxxd2W2J9QIqLqKAlPB281jgjqfG?=
 =?us-ascii?Q?jAMjhoQbRr2Htea5jH0dqJn7oqKI105Yuo9LhrVeo4DIWRKqbniRgYwM+kOU?=
 =?us-ascii?Q?m1lBdbi/puRzz3rdkc0jNPi35PcSxnfrGW+wNd+qRc9r1g/j92ssv9ZAf2/z?=
 =?us-ascii?Q?h4eheXouDx8iJz8LvwpS3sTdY7LFV1zSJ3XaWZkTfoz+O96Cnpv2rRe/epP+?=
 =?us-ascii?Q?VHYzSrGeYvWZpP1l0H3nMIz20EdSIHrfIJfu6GK4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f5a5c9-4239-458b-b96c-08dbdb3369c6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wdqLht75lC4HLvjK+bo/44oJAz4lEoHBDEKzf9Acov0KeBTjf/mF1/jBgMaJfIr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

Prepare to allow a S1 domain to be attached to a PASID as well. Keep track
of the SSID the domain is using on each master in the
arm_smmu_master_domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 11 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 42 +++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++-
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index c541b94917d036..4644d4601c0830 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -47,13 +47,12 @@ arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
 		struct arm_smmu_master *master = master_domain->master;
 		struct arm_smmu_cd *cdptr;
 
-		/* S1 domains only support RID attachment right now */
-		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
+		cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
 		if (WARN_ON(!cdptr))
 			continue;
 
 		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
-		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
+		arm_smmu_write_cd_entry(master, master_domain->ssid, cdptr,
 					&target_cd);
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
@@ -283,7 +282,7 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 						    smmu_domain);
 	}
 
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -319,7 +318,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+	arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -398,7 +397,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+		arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, 0, 0);
 	}
 
 	/* Frees smmu_mn */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2181eebf0aa369..d56805d201fc43 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1968,8 +1968,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-			    unsigned long iova, size_t size)
+static int __arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+				     ioasid_t ssid, unsigned long iova, size_t size)
 {
 	struct arm_smmu_master_domain *master_domain;
 	int i;
@@ -1997,8 +1997,6 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
-
 	cmds.num = 0;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
@@ -2009,6 +2007,16 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 		if (!master->ats_enabled)
 			continue;
 
+		/*
+		 * Non-zero ssid means SVA is co-opting the S1 domain to issue
+		 * invalidations for SVA PASIDs.
+		 */
+		if (ssid != IOMMU_NO_PASID)
+			arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+		else
+			arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size,
+						&cmd);
+
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
@@ -2019,6 +2027,19 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
 }
 
+static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+				   unsigned long iova, size_t size)
+{
+	return __arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, iova,
+					 size);
+}
+
+int arm_smmu_atc_inv_domain_sva(struct arm_smmu_domain *smmu_domain,
+				ioasid_t ssid, unsigned long iova, size_t size)
+{
+	return __arm_smmu_atc_inv_domain(smmu_domain, ssid, iova, size);
+}
+
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
@@ -2040,7 +2061,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 	}
-	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
 static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
@@ -2138,7 +2159,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
 	 */
-	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, iova, size);
+	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
 }
 
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
@@ -2474,7 +2495,8 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 
 static struct arm_smmu_master_domain *
 arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
-			    struct arm_smmu_master *master)
+			    struct arm_smmu_master *master,
+			    ioasid_t ssid)
 {
 	struct arm_smmu_master_domain *master_domain;
 
@@ -2482,7 +2504,8 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 
 	list_for_each_entry(master_domain, &smmu_domain->devices,
 			    devices_elm) {
-		if (master_domain->master == master)
+		if (master_domain->master == master &&
+		    master_domain->ssid == ssid)
 			return master_domain;
 	}
 	return NULL;
@@ -2499,7 +2522,8 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 		return;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	master_domain = arm_smmu_find_master_domain(smmu_domain, master);
+	master_domain = arm_smmu_find_master_domain(smmu_domain, master,
+						    IOMMU_NO_PASID);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
 		kfree(master_domain);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 59bb420af52e28..887669f04b55c1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -738,6 +738,7 @@ struct arm_smmu_domain {
 struct arm_smmu_master_domain {
 	struct list_head devices_elm;
 	struct arm_smmu_master *master;
+	u16 ssid;
 };
 
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
@@ -783,8 +784,8 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
 				 struct arm_smmu_domain *smmu_domain);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-			    unsigned long iova, size_t size);
+int arm_smmu_atc_inv_domain_sva(struct arm_smmu_domain *smmu_domain,
+				ioasid_t ssid, unsigned long iova, size_t size);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.42.0

