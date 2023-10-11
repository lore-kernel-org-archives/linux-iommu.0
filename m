Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F32B744
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fqHZCsh5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BACloZ6OzdHEp9K28dMXwGSFpIDbYsJw+XsJo8gC6+M4Gwb8NlpiNytAN6vqXSOcweQqwkXcSOCeibeRWq33CJO5wMfz4K4tiFcOjHTEstdP4FompXxVKpBZy09ZfW0vzt6QOgvOqg6y8fXwfScze324rISyb6kv16tD+nQwBMUker2pOvkb8TeWbQzaYbb6EFM9f42rWY9HrkQIDffY0CM5/2k2XVSD9aHjpyfpw0WQL5pqSmE42UMIK5dkH6odaKpIVQ+VenLtCAleeyag2wqPndPXnr9Ouz7YHA5nW8yp4xHo1Q/rBqayeAVrZt/eu4IkFJ3GpHkoqxKveHpJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhXGrTp0hgRMYhKFlPhO8cgRmO5VDwer4GeDnd8O01E=;
 b=PZvbJtrcfg8uXYfaC6QuPhP1dikmHzNzicKDKWIrCtobeb1yq/c4LJ3GS2el72X+RcE4Se11O0kyGtVTt8dXcfS64+WqY3NrSZa/IHXGh9IQt8ezu2npt1YhYj3gEqteI27d+w8tzyVhDWTsF3rD9+rzjw29IUnzlqZjtCQbc1a7XWvFDmM6kxVjmxH18g0hBBrIXvX3k5U9c3zs6+e8tXDHD0S/oi8b2UmDztGbV0UhAfyI7XZ015r5fg+LW49Vi7LipK0akjiX90itjnDGOOrUzX+Hz28Id5mTnCmsIav+lUoUrM/YpblRPigIvi7HgrnElTbSZQ/TKRaK2sR6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhXGrTp0hgRMYhKFlPhO8cgRmO5VDwer4GeDnd8O01E=;
 b=fqHZCsh5h2t/SrhmeRA3p8JMk8iKC40rClolLBv+Ft//vET87i/Vjd7kTXszLYtSU8/uDwfvYTR3UAdxFoht64NgxaFI3QVQlJkq38Am2vuOYpmgmxWl5PdO4Pky6SMvuIDFrq5QkkH+N/L4cnRNU2j6rQ7qhaDGQabDrP+navYCIxjF6KmljXEitgJixCNUBRqyEukW/2jX7Zy3K055ooBrenPyYbUUdaN3y7G/lUpxiwQUzhynIvV8/DLfi2fDKNqekSXuOGoo8bLzcfl6L42o/EKdtWzATfqCRAxlhWDL/S2i2Yh8ZGyFSE94HcmQZ1XzZdft1ueYM38rtfUjsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:16 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 15/27] iommu/arm-smmu-v3: Add ssid to struct arm_smmu_master_domain
Date: Wed, 11 Oct 2023 20:25:51 -0300
Message-ID: <15-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0277.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4100c6-92d4-45e8-2fdd-08dbcab17127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/oL7UkGUjaOLBq1f8Ay0SW1DYSRMFX/l40FNhg4CpA0jsgJBQZ5czqT1hPjqRymNRYGPVg+p653Fst55YBf+v5vlDTfKE5nLRkiw2jUKUDqEEsZ3QYxKguSbYXwjlUdrYXh3dShtL46gZ01d1M3rSwg4TAdwR7Kgkc5mH6t3tvJEL933ccH5ZT/HoX6hnT61yDsHrT25IQ9mA7yACLqEhVwe9xE2YlSFxQhcdThFjq/WWyF9EYlh5D0QxXcaxGSRpLs3x7G8v3Y81j1e/3H4DAvvvJVMn2Bm8siwDs2GlA7//uNg8Mnwwc56KyEWZvRf+x3j+rccVW2L6nRxzraux+DIjv9fzi/lj3qEfSKecevBZSGhs9chMBZvBSeVYJmAqURgqejmOOSR0fm/c/33kD4gGvMkuqwLI6P2BPX7h9hFiSD/IB9fJAphM2dO6qDUtQLHPbd9GGbpboPd9smzfSDXocvo8v0+LsWa78YjmNUWKhBSHxbvVevmFFOkIVxNwJEoaT6I8Tqr4Ja2ezre1zqHjLB1hiw8+LrLIagFaVS31KEan2XJ9JuaDpkCKnPk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6GgZjwviSz6vXRbiLb28+JuZxwReLtj6RYBXKr+kPR4T6NXVsr0yXiUjnnNj?=
 =?us-ascii?Q?Xnqv7rQZwHusYxAoPzlt4oOptzl37vewp8Xo8emI0AyF48NYeRzrdukPULKr?=
 =?us-ascii?Q?Mpw2dTmBRbCCCPU43C4e5X0RT3wtMsR5jcDq1ITBQZgr7AnLE7eU96TQTUmU?=
 =?us-ascii?Q?gT58nCJj0YQmAWFovsz5+IwyZLNRvAfF4czrj+g2iyXk9BwRi4oK+A714TqR?=
 =?us-ascii?Q?+6rJ3CqUxcgS5QIvrBk3QbwXQ7TAJoFkfd3WPBG9X0znU+6lUKGNU8ZH7Dis?=
 =?us-ascii?Q?ndxHUr5XUBzpCJx6oN3z68KxDhDzB65J6/1KG8uyJ5/Me0bYHmKvuCu4tSOk?=
 =?us-ascii?Q?MdHPA8WgX9gXGRiQGcna4wwvToKZhZyKUqHPJdBfxwxcGUi5O2eRPtG0yqzd?=
 =?us-ascii?Q?eoSuIzR1QkrQd9LfLftNJ35V2p+cDEckvrmn2kJoDALbxtUFRUqCGyb05j3Y?=
 =?us-ascii?Q?sf6bLjayc/FnA3Hx0q+ZzqDl0E79fYt181JTDtb9i4MgXCwlWI4RzVjjOaMP?=
 =?us-ascii?Q?hpN0ZAjFemAwxUI9ou3i19LPDoKjUft0td9XAjETAo9/MG8IO4UbPD2HMN7b?=
 =?us-ascii?Q?NEGc5JEQ4bN2DDfhGaSuaJt2mBfHOq2q07DNvlMrfbANODdOvNioJYM9sPdP?=
 =?us-ascii?Q?FuYQAMsLugO3+xSIuSUvf36EpTnVEk0OdlP/IFOe+M0RE9Xbys0ehuuHBBD2?=
 =?us-ascii?Q?ZuP3vEjchuW6z0PJaOTdgip0oSLPmMVYyYt6m5RkUpK/rPWd3O8PyBskrHMN?=
 =?us-ascii?Q?MzvTIwljbT47lfjmIKe82QBv9I2IbU/uHcbGYdurvqbX4Jg1KfAPC3DDlbqm?=
 =?us-ascii?Q?XY2WorjF9OeiJ5DsAB7S3b1FCDk9JO8kSyWUcDZ4FaywzZsfBtfMU0iFfwMt?=
 =?us-ascii?Q?4rHXEvsyQmNbOVYVwgEFa7cJ3gi2m6+DhRq+8i2HhBpcnRup6ErbVr45NyY0?=
 =?us-ascii?Q?ZZlqNrYwqhcMqfFpGFt6Cv4fbNfp6sTrMxPFSKaphR2URYYJtCNy8Bk9aaEh?=
 =?us-ascii?Q?3JF/DjynjYTqMdomo6AgJjPwGOv0E179Ct2sv+v/5xVJS4wZCkOJO+ki7b3x?=
 =?us-ascii?Q?XRqHcl0hMSsk31RnCREdoV9e7+G1ECxBkhy8Uz7WmuUWhBvyjyPg6DAZPfmv?=
 =?us-ascii?Q?vpYodZhUSM5K0UkjHnWOA/6U3qtM+M5Lgpnn/080/qTiS2G86TWppONLl5zy?=
 =?us-ascii?Q?gVSRToLco0n2ZW4e770gTbBodNarpaKwsIDbbFQMgOm9vihiFoPQml9+5sYn?=
 =?us-ascii?Q?LiKFr8K9Pe0nAkHz3LMncb5CxtTgXz/n3YuyXfF/MlO+ZmiJXOPeu9x30Vle?=
 =?us-ascii?Q?rM3t4TMeKBI712gQ9FupGVOgzka6QduilImGvscZlcNQaDnhKCGWiqM13l4v?=
 =?us-ascii?Q?G9DuNyLOObdtUeQNd90RFw9/vF/8XhPD+Wa40BYvOVGrVyY9dWw8rAp3rSyh?=
 =?us-ascii?Q?P7cSUrYd79cyxjQJiG7iHl20QCPeyPcd1txJ3iJjQrVCWmkI7Vf5PtP9Zp8e?=
 =?us-ascii?Q?qwYwbzK6Vs/znxT+iv6biHEmKc9bHviyS7rSlrHmlwB4ev3XSwVtF4eGxYba?=
 =?us-ascii?Q?bv9f6URJsExW7R1adaK9Axb66TCG7iwAM9xbO/2Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4100c6-92d4-45e8-2fdd-08dbcab17127
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:06.0814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs2+L5V+tnRGNud1yVLmOOBluztjErkPYP84RlgRS5SoCboaNroRZCbp5XyMPaAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

Prepare to allow a S1 domain to be attached to a PASID as well. Keep track
of the SSID the domain is using on each master in the
arm_smmu_master_domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 11 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 45 ++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++-
 3 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 0a2339d9e518ac..702a6ef9df8a22 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -49,13 +49,12 @@ arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
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
@@ -285,7 +284,7 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 						    smmu_domain);
 	}
 
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -321,7 +320,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+	arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -401,7 +400,7 @@ arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+		arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, 0, 0);
 	}
 
 	/* Frees smmu_mn */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5137f7b2ad3858..59de4f5302c57d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1943,8 +1943,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-			    unsigned long iova, size_t size)
+static int __arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+				     ioasid_t ssid, unsigned long iova, size_t size)
 {
 	struct arm_smmu_master_domain *master_domain;
 	int i;
@@ -1972,8 +1972,6 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
-
 	cmds.num = 0;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
@@ -1984,6 +1982,16 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
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
@@ -1994,6 +2002,19 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
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
@@ -2015,7 +2036,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 	}
-	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
 static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
@@ -2113,7 +2134,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
 	 */
-	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, iova, size);
+	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
 }
 
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
@@ -2449,7 +2470,8 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 
 static struct arm_smmu_master_domain *
 arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
-			    struct arm_smmu_master *master)
+			    struct arm_smmu_master *master,
+			    ioasid_t ssid)
 {
 	struct arm_smmu_master_domain *master_domain;
 
@@ -2457,7 +2479,8 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 
 	list_for_each_entry(master_domain, &smmu_domain->devices,
 			    devices_elm) {
-		if (master_domain->master == master)
+		if (master_domain->master == master &&
+		    master_domain->ssid == ssid)
 			return master_domain;
 	}
 	return NULL;
@@ -2470,7 +2493,8 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 	unsigned long flags;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	master_domain = arm_smmu_find_master_domain(smmu_domain, master);
+	master_domain = arm_smmu_find_master_domain(smmu_domain, master,
+						    IOMMU_NO_PASID);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
 		kfree(master_domain);
@@ -2522,7 +2546,8 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 	 * domain, unrelated to ATS.
 	 */
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	cur_master_domain = arm_smmu_find_master_domain(smmu_domain, master);
+	cur_master_domain = arm_smmu_find_master_domain(smmu_domain, master,
+							IOMMU_NO_PASID);
 	if (cur_master_domain) {
 		kfree(master_domain);
 		state->existing_master_domain = true;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a4da5c164dc62a..8349649654e2c9 100644
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

