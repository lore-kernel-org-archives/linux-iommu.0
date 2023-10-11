Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CE3E47B
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="seruNc4J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNXoYGSiZtq9e+rsOBpA66ocL+h5IzT+eR8D2P6PUvnNSDzcauPBPwlTalMta26x5lCHa7h7lFVGXOpgfrplHUZJzPZ5V2yH4cyXdwaulcxQcYPDGgYFyxI4qzNe8lzPau2fcXQUTrr/cCKZCbHglqEwckWf5rAMqS4fQhqtIApApZnnG5ERM0PQsNkA/Fz5NXPKAEgEKZC+96p7KM5oganNyxAt7vFffPCr1AGYsULxYd/BguQTnmGGrwErXBHunabJpv+qEyGAGxMuoddx97M154HoQrI3dAAbltZxYdiuUGdp0OOobr38wk5OC0gza8+6uDPfAZMxHz/BP1ZMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2i5gjTkWfy8uAUcDq/49E/mHT7SlJ/tQERVDsQxnAo=;
 b=JVEaqdqBXXk1YQqz0Ag6EipcWThcy0rluTTiB/bsRV+id3rhITmjkOtnQy/J/ptwAA8mbEWDbVQE948L3bRRcwzR+/fVUOn0xEPfCuJS8Nk+OFcrl2zHflxEcHVM3uz7lzSKy6I6UvSl9e3NlFcdE35TOQsiL2YhvCQpjBzoCPO/N1TGY0DvPtllt0qTQMx8CDXprtn51dS0RsIMt37zLTgxowmyGJHU4c4QINQdC7RSWLYXUoCch2LAPDhHj4iCtSzd7b1C+9lE1vlILMdc0AoyLmmaueHyQ3/Qz2WUX48/8ho7wQ8H+WTkHmoiAXg5Cqq8XJfzinw7VLOWyzOdag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2i5gjTkWfy8uAUcDq/49E/mHT7SlJ/tQERVDsQxnAo=;
 b=seruNc4JOwOYVCeIj8Pn8/gvcK91vecXTTEMO6qnOU7BUTNP37P8em/ZaHgmqpB3AYtbaQfAlPTysynjlwJiGHb0j9+Gn1EeQ0m8nbw/zX+gdCU6z3wQlcKdw5o0XB/HTFCgIPvm777uxGiFzXy7L4ZnsxbZx85bjoiPNGyb1z/lXyQ0N2hYluT1EueeCXJGcq84cIX76AO2JTc3KvqHtGYxon0IodyBaIDiAUycy1Eg6dD3efpZEafQLB3rbbUjYV1dTJv9oo8fMtNgWQOd6yuhP4yV8aH0RoNUajPQJd4DDiCjcw/Ha/0QrS9mVJD1MsfZxBjrFQ7c+EhIAkk/VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 23:26:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:06 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 13/27] iommu/arm-smmu-v3: Make smmu_domain->devices into an allocated list
Date: Wed, 11 Oct 2023 20:25:49 -0300
Message-ID: <13-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0281.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: e80081dc-0b77-4968-473e-08dbcab1702f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K/jXiGbJsIviZdJM4p9L17d+QXYfLBsliFRLaJdioydjc0aFMHwJ/Ab3vPBeAjCvGTpDNUx/qNQuhWVnILh/dmtjo2xYo4rZHyzAWY1epY2tPbMufB6zCbZpG2l6DgKR2HDjQImjfw5k4+z2q+tOa2/bujz3nkS7m4HOLDZqRuFGZZCzMS1fCs83gIzhrtIOGrIzK2+Y7t2c8Zq76N800YT0EtPJNfOgmVrUCx0WxssnlYe78pMHhlskLdDjpWZaX00yZFpdDJtF9+cHHluYfVCGSD/AmheRi3K6uqGEnOrarYHk5nMcpbProJJQJ21uLqD7UXGJ6rD6duFYfOWEzduDnCJjx9Vrw666FQuY0ZU6JPqFX7gZjdGNPPc0rEJUrJN1bJi/wchFI+jVOES7mol8d7ST4iZ0warnb4tG5G2aURAzlhVeAWYvK2QIysn4Tcnv9TOoIKCUdlLk87ehEe2A7GvZ1Y3aPzLX50/wRNvIcVSq6iSdFPfqx+o3Z6RttM3NLFFbsUDdlhnoyMlSI/clUSQ+BwdhElCP04lEGB7L7BgdwkN/709zC0dToMV0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(6486002)(110136005)(83380400001)(316002)(66476007)(6506007)(38100700002)(26005)(6666004)(66556008)(66946007)(107886003)(6512007)(2616005)(478600001)(86362001)(2906002)(41300700001)(8676002)(8936002)(5660300002)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AQv/tWpTA38D2Deu938brCngSMA+4DvazUGEPcc/T3kFAtACoycg/fGNALWI?=
 =?us-ascii?Q?+jt6UMTIVQgXzBNs7DTYzEhdRunxTnkIQupjTPjvfLK3TQEvW1ZtcPCVZiqC?=
 =?us-ascii?Q?6g/1cZo2SQIQ1IeBP7GFCWizGcDGBuOFlw4P0PZ1nzl5o2GdNTCEtf8Kr4VF?=
 =?us-ascii?Q?sqBHOJsHsOpoNJxAaCLgNr/Rq95agnD7M/ayOUE200YrrPhvlYayZi/tbnrV?=
 =?us-ascii?Q?3+Bf5JAucrAtu9XdJIseADNsixKmQ+mVAvgshhnWaWZccqTeHYliclH3e3Go?=
 =?us-ascii?Q?6blg9Lr6oWpHgxo34EnzLtYI7V+Ij2qntsad4kOc2Yu78Wr0Gv7Zxj2vnru4?=
 =?us-ascii?Q?k9RtX6xtSAfo2/mOMu+Bpn1CAOsVQGeUJiXTkC0l/AduwzoytPqSMIwKMBSe?=
 =?us-ascii?Q?8H78molhOD+bMFN5hx1Y9p2ZcZjMj1txQ273cJsPKmVeEXtxwLTJmtQzr+sz?=
 =?us-ascii?Q?cnGiUw0Kt9At0+QIwo6dYEZUcfuz2QCpLU35wcXHAkRd8Kdvf5w2aom0byxy?=
 =?us-ascii?Q?Ow1Jz3EpAnbXw5ERTen9Dubr/BLLH25FE2P27UAxdEttpyI2MyWSOAZQg3Ki?=
 =?us-ascii?Q?BRoiigxxdJoCYpwgz1UAOALoeYDSG4rvvKXOesMTj9/Z9PG/5IKuwIqZQX4/?=
 =?us-ascii?Q?nZNQfBACjTEICgcD8LxVBrWyrOE1cbyclibzVd+RtwS1hLbliM4MiBLpNLiU?=
 =?us-ascii?Q?4tLm9QGr7s9POKbCB7RVmOdi7AoEs/m3fa6zJ5E60d9XO0tdJSZ9EfgU1g8R?=
 =?us-ascii?Q?YWvl44O9MNzpQVQnykdvxvwmZCCR+r+G+sv4+UFmwP8rtfY1BtsLRws+lQCc?=
 =?us-ascii?Q?8WYD3ZuS96ValjBRNnM1/1hbt0p9umPCcJ6Cpu591ezQS+6/97cYSp9ZiXUD?=
 =?us-ascii?Q?n56Wrh7mqTZoBlbJIPOyHum5x1SN8OnJXMgb+PNDtSM7AChRDaLLKNVfGSgy?=
 =?us-ascii?Q?OWVW9+Gpqd/Tu3ivQi6k7U+9kxJ0vDuBFxR26jqZxz0kNKvYMhGd+BdJ8E7+?=
 =?us-ascii?Q?EYUN/XLX0gCoecckPn11Hn7SeWTUeI6fxReJCexbGvmiNI0W+JDb/nc6rKN4?=
 =?us-ascii?Q?em5Z7s1+qOKI1xi9o1syeoZbxrJ8f9acjU7cxA+Ymu6LcRQ/suxmzZaZ6eaM?=
 =?us-ascii?Q?rQeqz5DZCrqWjN8o43hH72nYu33Cw8884ZGMShM9b4lcNAawvBHSYJNidAHS?=
 =?us-ascii?Q?fbrHMhpD72w+1x4fPYOtGCPf7SU8mlQisX71yjpMPUyNwCeGKUuO3sSBgm5+?=
 =?us-ascii?Q?008i37+SJUDvcihBJ7qaLTzg2DDf8V/oTIVDdrqGQtFBh5gXr4YBQQ6QWIca?=
 =?us-ascii?Q?5Hm20mYN5wuede+Q813QeJDnKRIeeYyPKl44jPNd22OvgBNa2tTfKtkw9glV?=
 =?us-ascii?Q?7Rb+JHvsvTsp4uDadwVdldAaaJyAZRy4Wf3Vjs1ByUZh+R0BmA89YowkWufr?=
 =?us-ascii?Q?eOccPuMuzYfCxYN04T5fNziC1haAsP3ZJxvL8XQF3XJ8W3T/cVo9QZ9XbEuI?=
 =?us-ascii?Q?IVpFknnbY4eRqS1htbmgb15pOg/siP4/GVIX+/HEdIHm86PVoo4a43HayCQE?=
 =?us-ascii?Q?zJJaCt8uREwZacu/8NX/bYE1hdbx/9NwpQ5Edgq+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80081dc-0b77-4968-473e-08dbcab1702f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR9rz7bDcKRFySa6rYZRTxtz+QVvMYjsGmWsoreOhGiHQWa2YiwSI3Qrt98j+EpL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448

The next patch will need to store the same master twice (with different
SSIDs), so allocate memory for each list element.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 11 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 38 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++-
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index aeacf2fb317a72..0a2339d9e518ac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -40,12 +40,13 @@ static DEFINE_MUTEX(sva_lock);
 static void
 arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_master *master;
+	struct arm_smmu_master_domain *master_domain;
 	struct arm_smmu_cd target_cd;
 	unsigned long flags;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+	list_for_each_entry(master_domain, &smmu_domain->devices, devices_elm) {
+		struct arm_smmu_master *master = master_domain->master;
 		struct arm_smmu_cd *cdptr;
 
 		/* S1 domains only support RID attachment right now */
@@ -291,7 +292,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
-	struct arm_smmu_master *master;
+	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
 
 	mutex_lock(&sva_lock);
@@ -305,7 +306,9 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * but disable translation.
 	 */
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+	list_for_each_entry(master_domain, &smmu_domain->devices,
+			    devices_elm) {
+		struct arm_smmu_master *master = master_domain->master;
 		struct arm_smmu_cd target;
 		struct arm_smmu_cd *cdptr;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 894add54013fe9..82613f5d24f478 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1944,10 +1944,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size)
 {
+	struct arm_smmu_master_domain *master_domain;
 	int i;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
-	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_batch cmds;
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
@@ -1975,7 +1975,10 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	cmds.num = 0;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+	list_for_each_entry(master_domain, &smmu_domain->devices,
+			    devices_elm) {
+		struct arm_smmu_master *master = master_domain->master;
+
 		if (!master->ats_enabled)
 			continue;
 
@@ -2464,10 +2467,27 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 	pci_disable_pasid(pdev);
 }
 
+static struct arm_smmu_master_domain *
+arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
+			    struct arm_smmu_master *master)
+{
+	struct arm_smmu_master_domain *master_domain;
+
+	lockdep_assert_held(&smmu_domain->devices_lock);
+
+	list_for_each_entry(master_domain, &smmu_domain->devices,
+			    devices_elm) {
+		if (master_domain->master == master)
+			return master_domain;
+	}
+	return NULL;
+}
+
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	struct arm_smmu_domain *smmu_domain =
 		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
+	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
 
 	if (!smmu_domain)
@@ -2476,7 +2496,11 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	arm_smmu_disable_ats(master, smmu_domain);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
+	master_domain = arm_smmu_find_master_domain(smmu_domain, master);
+	if (master_domain) {
+		list_del(&master_domain->devices_elm);
+		kfree(master_domain);
+	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	master->ats_enabled = false;
@@ -2490,6 +2514,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_master_domain *master_domain;
 	struct arm_smmu_master *master;
 	struct arm_smmu_cd *cdptr;
 
@@ -2526,6 +2551,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			return -ENOMEM;
 	}
 
+	master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
+	if (!master_domain)
+		return -ENOMEM;
+	master_domain->master = master;
+
 	/*
 	 * Prevent arm_smmu_share_asid() from trying to change the ASID
 	 * of either the old or new domain while we are working on it.
@@ -2539,7 +2569,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master->ats_enabled = arm_smmu_ats_supported(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_add(&master->domain_head, &smmu_domain->devices);
+	list_add(&master_domain->devices_elm, &smmu_domain->devices);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	switch (smmu_domain->stage) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6d22a9f4c33a0b..a4da5c164dc62a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -695,7 +695,6 @@ struct arm_smmu_stream {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
-	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
@@ -729,12 +728,18 @@ struct arm_smmu_domain {
 
 	struct iommu_domain		domain;
 
+	/* List of struct arm_smmu_master_domain */
 	struct list_head		devices;
 	spinlock_t			devices_lock;
 
 	struct list_head		mmu_notifiers;
 };
 
+struct arm_smmu_master_domain {
+	struct list_head devices_elm;
+	struct arm_smmu_master *master;
+};
+
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
-- 
2.42.0

