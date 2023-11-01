Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6561C6AA
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dsmp4xQk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEW32qYi5V3nCDRrvN0BRCFlr3EYG8k5lK+hbUgpEmihRJg6dd9bwseQ7nvq4Dl4uNj89xkvSKW35ebJXKvwQBjf4epFrxPz1Y20yfhgHvjTyOCkfR9UTTdTJ2Si0rIqI9dwqdDMKXgXcaGIWrgmHsc9M6QWlad/j250HJJFouW1vtyEVKu969LAWpPXB5/daU+rh6GBodUJ53WuSFTGpSkuT1xFVs/VKuL/eRDe8uLmZbHlesHqeiYYN+rkxayDcIwOdm74Q/T8T3QVGs9T9qsSu0YVOK/IOAVIQgVRKsFxBFCawEcBhBaapM769WKldjtr58CVGG1/oEizMXH0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK7UQ0Se2IJLU7Yj7KUz12M1jB6ZPu/fxr5N7tdzgYg=;
 b=m720SiVZxvmFdv6kniE4vTaz0o74TdBI41ptKcoqXbCs3PIi4IFWGZeXb74JDazdb9WCm7p23GezrR5hUFXttG41z50qNJ/SjvhrHkvrwDkyKvr62UlQBhTbtPGUMf6WtoACPr7f+a+YuV4Ctm5A649hKCKrvm1CViM8WK/7eQR24v5yL/3YCIcSWn4bOOvtJ2rD0a1YAkCI/vzD/TU/DUWyKY0Timlf+uHZShpkFWL3hWTJ/Zh05irl/vFFz+QGwtPBjwGxBCRh9MV2cGVeAbs6No5YNL79XHmpyjHGGn6WsHidSavFMoJJeEieksg3fMIOWL+qW7wPa5NZwlcFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK7UQ0Se2IJLU7Yj7KUz12M1jB6ZPu/fxr5N7tdzgYg=;
 b=Dsmp4xQkNBOeLmLHEf4Hthvawus9k8Z4tVwvTtmlIesdU7isOZzGy3pC8faItYyV1PwFolWFmPg/hpv8BAiULN6Nf1L+02jUU2DLAGNsFtCu2o37t73bQKLKxjXSXEt1KTxC013kPCF88xZ3jqtziJki7OSCj0+4eST37MUHSfubA8wPTCUqEHiuFTVcoeQIeJqDGsmpynuTnWYWHAQkW8PmyplLKHzd+et4zKOFZnqcc+931Xa0HbvkDO7OTer2cYlIV1mebAhwfGdP0NJtienLNK5Qz/V/YY/gt0+zyMk1S2uL2mg+TbvWhkaY4RBAnmPje/CUBft3C+Q0LvdLLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 23:36:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:53 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 13/27] iommu/arm-smmu-v3: Make smmu_domain->devices into an allocated list
Date: Wed,  1 Nov 2023 20:36:31 -0300
Message-ID: <13-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:208:15e::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 091c9dca-2ae8-4e57-4a87-08dbdb336adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W8kBDwPCT5QxOBSFo9b8FAkHDTGyqjNl8uzD+R2jmrIR+jXAZQKa8lq8GkWHkRATReX7H+UwSSZnNxjz8PBcsofKFgUU9bcyuajKhFFC6HY6llEHV8TGA1Sv/zfAHa6mYi59SSUtIEUjWSVHUGzy2GiMmko2X5h64B+r7jtoVJFO2gklCxg6pwfcshEJo+PqECel08LaXxRAQy/j21qpKQOYtlBp77L11ZebL3QgPaYo/Etuf1Q1o65T+rE5Tz2gqU2NWTe8sVNevcSpw/5j00Xfs3hiSHINW2NgJocMNZN7Eh88jzu5mR3+UemK4RmVN/u4I8cg09+inSKF47FORKHtc/3tFRsyG7UUbjiPjxCDlDSRf8LfpwC30+H0yGCf3Dieamsj2FJFf7dGu1CWyTqE3xcQX2ZBkX7ynwDlajQNoKU5un8HsIpTVy20nVEwtGBq4xk+v0HU4pwhipC4szfZEbHX4QNjhH8BlKUBO/cW0TmtougVyRwfzcwjc3KT3ZA5miZ3+ydBgf+paBDrPa+ntwo4cpyBxi6FvqDQAM+eEF0SFcpS7zaMzFIxOiVq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(110136005)(2906002)(86362001)(41300700001)(8676002)(8936002)(4326008)(5660300002)(36756003)(478600001)(6486002)(6512007)(6506007)(38100700002)(6666004)(54906003)(66556008)(66476007)(107886003)(316002)(2616005)(66946007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k1XtkaWc6OQ8iLqW/I26YR4POSI34tn1jyEs7e0Ip0kwy0c8rJJohTSRoaqw?=
 =?us-ascii?Q?VVia/DyrQdxBDmUHTY6es9iyW3s6JLyY3Kv9cYh4I1ug3ZeNnEuMZssUWJUb?=
 =?us-ascii?Q?HN5cI9n5OvlPWNCJxN6zQWOrWXL36SZEJUtqRfzq6kF4JHr0f8v1eQVQ5ZPA?=
 =?us-ascii?Q?xivNDxcJN0yUqEIMtbAYcG/UlrKmViYlySA2aBhIixLGKo0P40a3Jgj/ZSHm?=
 =?us-ascii?Q?tpFABk1bbZxkhGmxW5JD2t9VWFUTKn+a7+nn8cjctU9cW5bTL1wSwd8MnXfj?=
 =?us-ascii?Q?MgasOLcd2wpyFM2nazCPQZ0A36Z63KHXhSieDu1AU3zHSIjrPNSl2MeMs9Kk?=
 =?us-ascii?Q?GnRTJqPzzcU/YSZzG8KFvqvXJQ48oTsPylFtHBXWmHi4k66HmifWREksmdvy?=
 =?us-ascii?Q?HMF9Ff20H/l+B3E0znc6CZ1OOHSu4h5/E2+fGc5ZuVwQ9RHEGxOWP9y786NH?=
 =?us-ascii?Q?k0bnTb3OJa69pg7H2FN+74Ua1ZKn4HKoM/ieTApv98QDN/Q8NdjKq4YEhYde?=
 =?us-ascii?Q?+T4Xjzp+vo6mazTBUVs+KBjcWbhlbqzkuXQpo5EA6eWNKmUmBF5lOtBrCBsB?=
 =?us-ascii?Q?sFvMdGhsgyMq1cjYEZF9FXizYJpz+imEdjPEekcxz5DUw87Zhsib1NDQJN3I?=
 =?us-ascii?Q?TR1eOFMIlNtqeKfEAhS1VvH+FGnJYCozINlLdQkju5lINGZK5FIOT8RVcr3r?=
 =?us-ascii?Q?lH9w/eiDeOaEVtI1zXRy6x+AQt90lQ64SPuAZCc0YuftK3NeJM82bDRV2T2O?=
 =?us-ascii?Q?ctTKPY2W+5w4y3JUQatueL9zRQJCmgw5lKLmCFChw1YbidZ5H0H2WcZUPxRR?=
 =?us-ascii?Q?6OZoCEelZCf8wEIzNi8iwwAvu8dOh1e60reY3F4gV1SJxaB661uLrskp1i1Z?=
 =?us-ascii?Q?UqX4duHrfAyNrwf5MpTacs1vPFZCIX5WwiEFezmhaQD6srJvbolWDpCifuTP?=
 =?us-ascii?Q?XGwYts/yJfxwZz7JUF2qYZ0xRuEK5/2jxlry36Vbcsqz2QFJb4NF/2QdiAfF?=
 =?us-ascii?Q?AZ4PIEyyIgmIZvQneUgrCJZjI9gZr4kS/+jRg75CLsgQakFxvcfA8+XlOdj3?=
 =?us-ascii?Q?wBEVAX4dqvIFmLFAtXs4bmQDCmqxEiqVyABSAv0pAJRzn/89n6qxAnB1MFXY?=
 =?us-ascii?Q?xZyhKgV63RMWh1fUo5kW3ne8PnzcY5fd/GWk4b4rbBd5Pjlq9TM/kWsmvweh?=
 =?us-ascii?Q?4jrCwqpGTQcrge5bJZVinJ4m3kpmFsKcEjMQzJB32sMTNOXS7Hv/44zC3bUV?=
 =?us-ascii?Q?p25RVRBRoPACMRbF3dXx99kAyjJFj4AlmYTfXv2GPLbZRj27YqyiH4ShLFR8?=
 =?us-ascii?Q?qNe02kbvXjnESkmnyjQdZCnbOT//5MkAxxxvGg2ArJYHzhoYHT4IbT99ta3Y?=
 =?us-ascii?Q?MC1ibVe/EP/FMaGq6NaHjkRCo8ttp8wu0A1pbSzG1PP9Co6T93/fJBXq2r90?=
 =?us-ascii?Q?bs6xdKHfWXcqc0DkY+B0EAh26TBYqo+oKh0mfMhzdZJkDZN1dXzFUIycHfaf?=
 =?us-ascii?Q?gxLX1nZatY1y8H0qLy5exFs+GcHztTFxARt+GrDrBQxHnttHAQ2yfeCDc15F?=
 =?us-ascii?Q?HKaDp897jKfGIT5+ktGowfCZJIyClFX/hHUB5Vav?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091c9dca-2ae8-4e57-4a87-08dbdb336adb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:48.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYGxzo0VdWqvFU1t9T+Me4wVVfPTGVLmMl+fPU3fv0rD/oBO92zVK0ddZSYbt/qK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664

The next patch will need to store the same master twice (with different
SSIDs), so allocate memory for each list element.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 11 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 38 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++-
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 29469073fc53fe..c541b94917d036 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -38,12 +38,13 @@ static DEFINE_MUTEX(sva_lock);
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
@@ -289,7 +290,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
-	struct arm_smmu_master *master;
+	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
 
 	mutex_lock(&sva_lock);
@@ -303,7 +304,9 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
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
index c62c677dca1d9a..3aec3791ccbe9e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1969,10 +1969,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
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
@@ -2000,7 +2000,10 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	cmds.num = 0;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+	list_for_each_entry(master_domain, &smmu_domain->devices,
+			    devices_elm) {
+		struct arm_smmu_master *master = master_domain->master;
+
 		if (!master->ats_enabled)
 			continue;
 
@@ -2489,10 +2492,27 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
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
@@ -2501,7 +2521,11 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
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
@@ -2515,6 +2539,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_master_domain *master_domain;
 	struct arm_smmu_master *master;
 	struct arm_smmu_cd *cdptr;
 
@@ -2551,6 +2576,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -2564,7 +2594,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master->ats_enabled = arm_smmu_ats_supported(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_add(&master->domain_head, &smmu_domain->devices);
+	list_add(&master_domain->devices_elm, &smmu_domain->devices);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	switch (smmu_domain->stage) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b7a65e37c51e9e..59bb420af52e28 100644
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

