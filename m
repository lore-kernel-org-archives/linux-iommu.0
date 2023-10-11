Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC812E5D
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lT9dhAiD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFaazYTbkFN1RfhS1pe8OTIVEbuMH5wNJDUEXXpVO44SuVsZ7my6XLvvv5nMAGEv0lhvxYmefgiyPurlNklQZQboQzm5WoE0zr3/VXS3JT2vmtU1AQtoLTv7l+LyD1OYZPJj6s6Tk2gRXGZkPj+DUjiLwPKsaUGIDM8aChhyIF3iQroPFGhUFGA0IwsK2X7MZI2dSXb+ihm0jEuCT0JC00yqn6sd3oL+qGgaLlTfSDkL4iLCKhfvRF/bueurJZjvqfmE9B5Qf6KrupTQxled4baljx/x2CXOsfUw2TuHXHEUz66QE518TknYpSxqUeF+tSimArTI2KG0L0bWaC57kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANiACtlUMSpceOxjO3Bpb/1w/km8Dl+vlMLfGyWkcLk=;
 b=PGUeGIgNtGTd4thpsH0X0xZVepr0rM9SKLEoLYYwKt2qyMHA2/jRJLga5XC78Wfx68UUu6gaVZ+H1VIBJXk++O8S8mtq550INsRiRl6FSzXP/1Atuu8YZNvDRMuQ6oh28QFT8eYhxoQ4vIsmlxK0qzS/sO3p9VRMRl3ig4GsBS44AP71Y/V2jlysp5Mtqa3QYO8CdDGSe/uuz96gH1yHBJCWBXpMCuFpgCCQnUJzlHOd4cFq+87Wo3MSpnFy3NOCsfnOgFPXwov2hQfguOBsYpOBo85xFdd6+ZIWVH7lewZFO1LhZFsWHlyKB6PBJPf/MOurecvo8Goo/fzHlViQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANiACtlUMSpceOxjO3Bpb/1w/km8Dl+vlMLfGyWkcLk=;
 b=lT9dhAiDR6OYGBlNmDbltQLGxNJnpViDGaf3QBL5iwC/tuQKG1Gdjnn5aRz59OO+k+MvboFTrxpGK7e0itfsn6yiUy9DpgmwADPOuUltxSLixV3rOVwdoZu8i39ggn7M/FO3kqiQ6SYInlNua3CN56zikfmV8Qefj5JX9WJcBA/UjSaPHszWE46IKO3yFZeCwD89l1N9o03H/J8Z7tCRVNv0jObA7NJyp0BBTrYXArDYjpAVWUMJbfQUwVqeEyw7mcqknwYkBkfJioo+b7j8u0Lo8Y9WXb47k5hxo/p1euiuOGvrGCVLdbdaMgtHIcyGVo5Kak90DdwmyF3btyzPaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 23:26:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:05 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 07/27] iommu/arm-smmu-v3: Move the CD generation for S1 domains into a function
Date: Wed, 11 Oct 2023 20:25:43 -0300
Message-ID: <7-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 362c9e6b-2edb-45e0-c141-08dbcab17006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IP1I6cXapBG0+TVgMzpiewwBkugiCwJYMcqie6MpcBiwt+4kd+ylSIHKhQIS/G3K3b2SbFpOqAYlash5P8nd6mNfdTOJ+JEaeOnD3a7/ubPj6LxpRE6P4q1Vxk5KkZyxMFrzj3Nf7M+8O1haBR7divbbN+wPZYhUSyVcv/XN6N22rSm+W4EL1AxLnezN1x4Jd8WSRPFZwZI/wy+Bhux4lf8i0l4/NbFvV92VDN+xTu+ckGVR4dZiHaUJuhrBv+OulzYQMPiT6rv46wjlNSo+lqa2pZpFWjjOn6kSZuCRpyE2/Ug/XCnmQF6wJKxcUacyyETmoefOxqEyqLpBNF5PbXrayoe+Y2BDTkpQZEuM5Dci5mwgIofWWVcXBt4y4s4vLoCHts862L825bOPmpPu51ONYOApqzQxIhz9SFGW8oNEBd4JzAKb23dkxF/7JiqvVKh1O1sOAL6/AOnmjFP/P15trbWRq8ypaCrtMXLeoZrHe1/jZXWQIT3fsTK97FVRHV+1XMdRuPTPww2McmVJxvt8uexBzfwQvwlVyB64mC2HBv6mALaQedFgg+/YXQ47eDxaLPi2fWeD9aihDFivUIiQ6+YSl0LO2aoEP7nzYqElrDHL9yuGPbyE0ITD1ZaFWOOoe5gIyKDfHtJiAGzFrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(6486002)(110136005)(83380400001)(316002)(66476007)(6506007)(38100700002)(26005)(6666004)(66556008)(66946007)(107886003)(6512007)(2616005)(478600001)(86362001)(2906002)(41300700001)(8676002)(8936002)(5660300002)(4326008)(36756003)(4216001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SqqgKVyMJjhzFNpREr0dZR2kNe6nEZRjAfIRenmtojY6qRwcO3RfYrshSHBe?=
 =?us-ascii?Q?CrMI/aDRKSJIvE908Nky8nBs+nrmZ4b3DNnCCqsjmRW/6oQ7uJlmAkt84qLz?=
 =?us-ascii?Q?rSQHi9Hb1Hy6apMM/n6GneSQ1k/yU/eX+WdLrWfJk10RYBxT6N6//BUv4Kj/?=
 =?us-ascii?Q?gLQwOwNvPnYsfT1kknTxJA3affE27ChkKyVV3Vhp9+kerZAlHuYFERgE3QsC?=
 =?us-ascii?Q?T4K9CGdwnuXZDKXMFXnmHOpwspppul14LqQndVtIJY3UKqYqJakxfPKYt6dE?=
 =?us-ascii?Q?KnCnAL+QjEGGPgl9MghiKAN43OQYDjVA7hWjBUgtD02Yv+pK6T8hJ9WT5bOp?=
 =?us-ascii?Q?wlQItk/UZ10ebgbs7xK+dprYG+F5qXlhPDj56s85/qxeOTEIlyQYzNK/BBTu?=
 =?us-ascii?Q?KI/+rgym9BCdWdv1g/d/WPC0FpG8iNyv0Sap5HTnpbqxlYS8+1q09bcQHQdV?=
 =?us-ascii?Q?s2Qdoo+c6blEioImb6M6SYh5y7BuFnSw/gHA+MkKhR9AurLpnp3WQIrT/NnO?=
 =?us-ascii?Q?Ww7qNHmCB5BY/PgThExhjJAzADPJdryul4fyW31imTstqsuKgMy/waFknYEJ?=
 =?us-ascii?Q?EFvA6pPaDjkIRgt4nZAqDSvrgRRVI+kq0HYK9/r9KdjwHCK+gKR7M71PMnY9?=
 =?us-ascii?Q?0Qhcg20vnAj0SXZBon+4jQXgbcZlwHZUg95s1kqi59m0M0OEoUxvTynm7mQx?=
 =?us-ascii?Q?Yjp8OQ9syeuDbnhrxOPJdorIkv4LceZvpXo+qH70/Nd4PxGdmKaH52MFd9pB?=
 =?us-ascii?Q?+BJvV2/YCa9H0W8QXbeyCKpSJQwrKc5puBoGevCgEDI4hM+CxrsD1IWdqz4Y?=
 =?us-ascii?Q?/7WjyGUFq3nycsz/7XAVNBkniQ+ZWi+DXiEP2sj8vSqs1+OBXBdmlnI3KknU?=
 =?us-ascii?Q?uknGqnya2x1yBPpLbpvSBt+j2EBWlM08Vt9dZ1KiSPsagRbFTef/IkwwdI5I?=
 =?us-ascii?Q?jFh2U6WMxog0Q4O0F3CZTFZvi71ZtnqXzyOh0/NYVmLs8afTafqX5XHhCNiO?=
 =?us-ascii?Q?Rg95dKc4PeF9Z/k3wnvqwosBIZqg3YRhqZgcsHekUhuZ1brdEWqzNNOjtjNv?=
 =?us-ascii?Q?ksf55HIyG6csV39MqdznPiyUreKVBy99CQ/9e/Wsphb/YleUNjtb4+1E49ig?=
 =?us-ascii?Q?85cwEeFEx7Ip0tSuPAl1/S+kKWDO1nFoe/rl7Y++pDULJ2N1IFGWJKUm0Z16?=
 =?us-ascii?Q?QgptNI9nDOFMqKUvgAbisoy+tO6SCGICnCzY6LZi9sDg1coGTwts0zIestli?=
 =?us-ascii?Q?93Ku+kR922D6Qh4HdRcFn7xfzTP1SNUv3R7aqySsyc3W/H9tjsLFFo9bUN1K?=
 =?us-ascii?Q?1MI2j4VvOoDDIr3brI3D2wGcqdv5q+QuA/u8KMrUSu0AkasU+6w+jJzSVVIa?=
 =?us-ascii?Q?FNPU1vQjjDARYU8LrTcpgxZXc+DBLYdfcxhPsFeskjJ7ch/KDBhR+H6zPwPZ?=
 =?us-ascii?Q?lreM1HrmVXWZWZeQHDICVl4NXM49zYeHP82gXopkxN+gEt2ONAQ6OgspeSmT?=
 =?us-ascii?Q?JlJnXQM1jfHJhd06vldg15NP7b0+PZirUPU4s6kWH9fFkxjXlUeOpLMPptN9?=
 =?us-ascii?Q?O9be6jrYm8idYVN+gTktaMh8+QjWXnMaa3xbcXh2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362c9e6b-2edb-45e0-c141-08dbcab17006
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjBhuFCsy8N1rcNiA0U7gUs/ehZnbsCLu5TrJJ9/iT4LOglaphlFdhqsSVP1Vq02
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448

Introduce arm_smmu_make_s1_cd() to build the CD from the paging S1 domain,
and reorganize all the places programming S1 domain CD table entries to
call it.

Split arm_smmu_update_s1_domain_cd_entry() from
arm_smmu_update_ctx_desc_devices() so that the S1 path has its own call
chain separate from the unrelated SVA path.

arm_smmu_update_s1_domain_cd_entry() only works on S1 domains
attached to RIDs and refreshes all their CDs.

Remove the forced clear of the CD during S1 domain attach,
arm_smmu_write_cd_entry() will do this automatically if necessary.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 25 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 60 +++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  8 +++
 3 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index e73e9b67e4f622..03a8e7b73bc004 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -56,6 +56,29 @@ static void arm_smmu_update_ctx_desc_devices(struct arm_smmu_domain *smmu_domain
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 }
 
+static void
+arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_master *master;
+	struct arm_smmu_cd target_cd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		struct arm_smmu_cd *cdptr;
+
+		/* S1 domains only support RID attachment right now */
+		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
+		if (WARN_ON(!cdptr))
+			continue;
+
+		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
+		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
+					&target_cd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+}
+
 /*
  * Check if the CPU ASID is available on the SMMU side. If a private context
  * descriptor is using it, try to replace it.
@@ -99,7 +122,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	arm_smmu_update_ctx_desc_devices(smmu_domain, IOMMU_NO_PASID, cd);
+	arm_smmu_update_s1_domain_cd_entry(smmu_domain);
 
 	/* Invalidate TLB entries previously associated with that context */
 	arm_smmu_tlb_inv_asid(smmu, asid);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0590fd42aa01e3..dfcc392bc57d7d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1086,8 +1086,8 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
-static struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
-					       u32 ssid)
+struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
+					u32 ssid)
 {
 	__le64 *l1ptr;
 	unsigned int idx;
@@ -1149,9 +1149,9 @@ static bool arm_smmu_write_cd_step(struct arm_smmu_cd *cur,
 
 }
 
-static void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
-				    struct arm_smmu_cd *cdptr,
-				    const struct arm_smmu_cd *target)
+void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
+			     struct arm_smmu_cd *cdptr,
+			     const struct arm_smmu_cd *target)
 {
 	struct arm_smmu_cd target_used;
 
@@ -1163,6 +1163,32 @@ static void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 	}
 }
 
+void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
+			 struct arm_smmu_master *master,
+			 struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
+
+	memset(target, 0, sizeof(*target));
+
+	target->data[0] = cpu_to_le64(
+		cd->tcr |
+#ifdef __BIG_ENDIAN
+		CTXDESC_CD_0_ENDI |
+#endif
+		CTXDESC_CD_0_V |
+		CTXDESC_CD_0_AA64 |
+		(master->stall_enabled ? CTXDESC_CD_0_S : 0) |
+		CTXDESC_CD_0_R |
+		CTXDESC_CD_0_A |
+		CTXDESC_CD_0_ASET |
+		FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid)
+		);
+
+	target->data[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
+	target->data[3] = cpu_to_le64(cd->mair);
+}
+
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid)
 {
 	struct arm_smmu_cd target = {};
@@ -2584,29 +2610,29 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	switch (smmu_domain->stage) {
-	case ARM_SMMU_DOMAIN_S1:
+	case ARM_SMMU_DOMAIN_S1: {
+		struct arm_smmu_cd target_cd;
+		struct arm_smmu_cd *cdptr;
+
 		if (!master->cd_table.cdtab) {
 			ret = arm_smmu_alloc_cd_tables(master);
 			if (ret)
 				goto out_list_del;
-		} else {
-			/*
-			 * arm_smmu_write_ctx_desc() relies on the entry being
-			 * invalid to work, clear any existing entry.
-			 */
-			ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
-						      NULL);
-			if (ret)
-				goto out_list_del;
 		}
 
-		ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
-		if (ret)
+		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
+		if (!cdptr) {
+			ret = -ENOMEM;
 			goto out_list_del;
+		}
 
+		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
+		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
+					&target_cd);
 		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
 		arm_smmu_install_ste_for_dev(master, &target);
 		break;
+	}
 	case ARM_SMMU_DOMAIN_S2:
 		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
 		arm_smmu_install_ste_for_dev(master, &target);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a8e7574ab8e154..950f5a08acda6d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -764,6 +764,14 @@ extern struct mutex arm_smmu_asid_lock;
 extern struct arm_smmu_ctx_desc quiet_cd;
 
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid);
+struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
+					u32 ssid);
+void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
+			 struct arm_smmu_master *master,
+			 struct arm_smmu_domain *smmu_domain);
+void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
+			     struct arm_smmu_cd *cdptr,
+			     const struct arm_smmu_cd *target);
 
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
-- 
2.42.0

