Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A6C80D
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qVpy2GNa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQuMuNaO3xBWQEptgZ212VH26M4TmRkkvLH1WtrC0YaM2mTjcf7zk+wHm5EOF/zw19v1u1mBCLHDMyKxEP17qMgbBtphKdOglU6ovzf1v3JLbr29QSMkeLaqKO6pUgToJs50XPRV8dipBButBFrQ3eBT0BK2s2Wng+goKTmpHr0zw01upXmjoCUk/MYsBl2TaQkIOXVcX3hV6RrVo56kjXwqh9P6XMm0IQsxLS9nfygbrAQl7lbeVbdgfvZngYdd9ANPqurjLBM0YwlP07hCy5twQI18I984FNx8hdEbb2aotOxxhBfHZ1NJbAnlZ9+5ibYthy3556xNW5GBY64TCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W61Se46VPgMQr56svmSHw5sOJgbPbT3Rcwo3Na9yTTs=;
 b=eugoxmzgq256rcpVV9TAUcYo4QZgAh9CZ4OArEMt47Tu0tUCz5l/JEuKtCDtdW4R0z0vFw5j9zw2kA/KqQoPwR174na43HfnsEZlCbHbqvVfeUc37JrVtBseXkylmC/kLb571K5hG+/BNDWVOnZHbW0gxNNc1Ye7ILCvOnTDoTG1/HIg8Z9g7WwS4zo+PHP0GIIIfCHx3C1Y2y0Vib7fphlhR9FJ/Q/KFabKEDuPLDlqZKFm1w/014blGe1erz1piBd2QA65BtK7TAqtWjgSouEt3C1fQRG1gU8g4F5K/2HBkz+IUAWifTRtDZF5BfH/9ORiqF7Ii1tQnXfLRhdLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W61Se46VPgMQr56svmSHw5sOJgbPbT3Rcwo3Na9yTTs=;
 b=qVpy2GNaWk/42gJWvxFphnptT30pOndAcazdDZREcYclHWLgfocrATERtMEd1i6R0CFe8WOTUDXx6BSN4E0zq+Uu0ulVbs9YDl/1AyFK+EUgwhKNnhcEm7x3YepwpFTyrQnFVeQi07euayfoRkIb7RnVxJqXusKsU766/qSCWphG2SPHt5fzsNAOwmpvH/Kmjg/sRdLLJMjjUXB8KC277P5GiQBxnCPMwzmgY4zKgqYh4mTG6bNJzDwV2+ubgXuN6Y/qnc3Fd4rswlZpGntFF04t1hcyLa733DRy0hKIoJa05LUJPZz/82jVRWRB/GaUnNwJZrWTbs4QFkxBll7iTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:30 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 11/19] iommu/arm-smmu-v3: Do not change the STE twice during arm_smmu_attach_dev()
Date: Tue, 10 Oct 2023 21:33:17 -0300
Message-ID: <11-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0392.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f604675-4c39-437b-e3a6-08dbc9f1af64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rEFJ21gLvZeJmLoFfaY6Pz4E9zUIEtxcBgEliZuCzvA9xLP/Qwtk0vu0EZpE6XNkVFlGoNB9g3d6lY2pBsEZnxy3qHiKcDCfFbF15vScYIbLN3vW15VgHv02ulIO9Ty11LmtLZ8WPVavYrzjZngJeRASLczYEWGK8HmMEsOpw33Ub8PeD8473ngBJE2ls6Rs6eyv94fg++Siq5DoxMn77CT4bf9aTP3LuESKdhVOCZoJ+5pvPv/rVlwTMzU1iOe2Ncl/rvFWsPFyEZUjX/oaezcIl8a6VYckH8Tan+OjNw2FgPEkSJgBKdYbRAnbry6hF3cFmhHjqCK5tNk22zxDE9ui9ONOYA0ZER/+HpYRh1tSY8g0O4unQ1KZowm5/FpZAU6/9Grt42MSzMgZVVYL+wIibBoCYa+7SRMdb2WJRjk4EBafwc1uiu8T75Kvo/iwNeC5z9SmlJ5zDfLWrJ3PjTHmTs/jLXYyPPKrYHQvZHNgS5j5IFyqPUd1xwZUguX/9UtyrD4CUaoy0SNO+cdtrLTU64U887mRtdM0cdiTxUy8nb4iiekiecobs2/6RI2f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKemnwa5qMDGsd88hpEsNQPozQRiquxkZsLLusyfgBkGQ2LNtb5jZ4Zaj9Db?=
 =?us-ascii?Q?Tcu3leke9VuIqium+M3d/K7PwNjSbEDS71dq7ey7T+0wlbwcHNE3iHLH5H+3?=
 =?us-ascii?Q?hdRnZx9NNswvXSztt3ymcxn//XVeqRo3x/qcLBl6y/wtqhwcVaeiQ9FuovBB?=
 =?us-ascii?Q?oFFjMDWKVNtrJrA6yuZ+Nj5UXS0utfvJcmQ9/PqgOkt92kQ0aPLQwatkJKeG?=
 =?us-ascii?Q?/fgpJkr2Q7fBCKPZP8eZQNQcEt+xp8yog2/MVY4O2JydE6do+/joRJ+eyIuy?=
 =?us-ascii?Q?nTdnmM2sFQ/GMPxH549vyq4WrFLskcM3dO5gFV0zkGgD8VnVILJ16I2W+02O?=
 =?us-ascii?Q?5flKg36mzKE0YtjHH9peNyXWzOOroPWFJc18g4koTbqNqFMNvsnQadS3VtYH?=
 =?us-ascii?Q?9LE3polOqh5hy4e1MBTcvQyQdMPf442wt+W/mOZ6m5QQaDCHxKR85yU1YKfn?=
 =?us-ascii?Q?G6ffElKfeEfoKm6M0MOu9NgPiA4vlyAbsaagQXf6QqvpYSlcvmVkbljhrVe1?=
 =?us-ascii?Q?ijbwayLlZZf6TxTgDm6bCn9O1EiIw8E5WeRIB3OkK7Xk5xj+GgGBWKPHa7hR?=
 =?us-ascii?Q?GxJNKY6vgR29qadvSH49a9jbSOkNlXNtA3XI+NYJB3u0E77zlBjR1dDLrUq0?=
 =?us-ascii?Q?5YHlM771/y/vCl9dvbrm+IgykJwNH53SYj2lX3mOMYOeV8LY/Q/yL+fep6OF?=
 =?us-ascii?Q?vjWYnoXd0Hp2CZ7gjf257IR+pqEwG2nfVgpf/bx7XpOd4iDoSAIb9kQKB2Ns?=
 =?us-ascii?Q?IdsGU3GAuxqoDqpUVVeK5YYkvkhhWp71pS/BGIEXKj8ioKWxYpZcyZQpV7Hx?=
 =?us-ascii?Q?CjEidhvzZOWZ/SXsP/pVvNFscM/p7NEm9cSHQajzCPg94Y19esErkWN1PmS6?=
 =?us-ascii?Q?8Cges7BmHNpig1IBor16m3wnolj8YXTkuYo3bSVDZcYISiUO+3GkNIqTY/Wx?=
 =?us-ascii?Q?L9p88c6NOaw9uQzuvjXGvb1czsiiiZXBvEvvbz2co2kNWiOwC91uNRyspf5k?=
 =?us-ascii?Q?T/7jCvahqrh7yDMiIjoCSGNMi0/3gjNH2eyR6byE5C0AvoJ68b2ZiG3vi/jT?=
 =?us-ascii?Q?x/bbigodOTuuZ8YnGytPq+8uKrDF+LZFybEBeZXU63lZocl9IFghdaszWiQI?=
 =?us-ascii?Q?F/mUxi4ZoiTRC1dpXtBUcerXRQPldt0ugzU7X8ntlUgLECzYi33CHgZyMHTt?=
 =?us-ascii?Q?ZmI8/vJFcbLYgfJNzdrTHlvakcg7bj21+FncneElE3jczJ19kt2jRee21k8r?=
 =?us-ascii?Q?G0NsYZ5XEz/ot2q48xTwgFI6BlL/lO+ECQ4lTz8lbi0uSAT4dVq7zGJ27pDf?=
 =?us-ascii?Q?n8taBtjCFu06ZLiUHy3DvhXxztbIr+rzjTRCRbjQQg6gLx0xL8MEyxG4fxcq?=
 =?us-ascii?Q?1fF5m9IlhZduxSTNpOVL8w5f5IRgOnZ0wMbn1JHGVf80YY4QQNoJ4qbaY6sB?=
 =?us-ascii?Q?o4Dv9ZQzX64yhjQ/NHRBr9evRxFZGHIieRqIaKCQm0ucAaMBBN5hwj+F3kbv?=
 =?us-ascii?Q?VYsUthH3sVyk/QRYf5LU7us+xrmXde+bJDktWEUqfaLAlSXKgbkHDIWEssA4?=
 =?us-ascii?Q?lM2zHXaemhjATSlSXJ7zyS51elRSSoVRwGTf+RpN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f604675-4c39-437b-e3a6-08dbc9f1af64
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:27.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4C+HiY1gsVUjsqSQ1eCpRLLNX64vQtcOydhqOId9Or24E7ToZQe60Og7GfiXcHT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

This was needed because the STE code required the STE to be in
ABORT/BYPASS inorder to program a cdtable or S2 STE. Now that the STE code
can automatically handle all transitions we can remove this step
from the attach_dev flow.

A few small bugs exist because of this:

1) If the core code does BLOCKED -> UNMANAGED with disable_bypass=false
   then there will be a moment where the STE points at BYPASS. Since
   this can be done by VFIO/IOMMUFD it is a small security race.

2) If the core code does IDENTITY -> DMA then any IOMMU_RESV_DIRECT
   regions will temporarily become BLOCKED. We'd like drivers to
   work in a way that allows IOMMU_RESV_DIRECT to be continuously
   functional during these transitions.

Make arm_smmu_release_device() put the STE back to the correct
ABORT/BYPASS setting. Fix a bug where a IOMMU_RESV_DIRECT was ignored on
this path.

Notice this subtly depends on the prior arm_smmu_asid_lock change as the
STE must be put to non-paging before removing the device for the linked
list to avoid races with arm_smmu_share_asid().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ce1bbdba66c48a..b84cd91dc5e596 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2457,7 +2457,6 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
-	struct arm_smmu_ste target;
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (!smmu_domain)
@@ -2471,11 +2470,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	master->domain = NULL;
 	master->ats_enabled = false;
-	if (disable_bypass)
-		arm_smmu_make_abort_ste(&target);
-	else
-		arm_smmu_make_bypass_ste(&target);
-	arm_smmu_install_ste_for_dev(master, &target);
 	/*
 	 * Clearing the CD entry isn't strictly required to detach the domain
 	 * since the table is uninstalled anyway, but it helps avoid confusion
@@ -2827,9 +2821,18 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 static void arm_smmu_release_device(struct device *dev)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_ste target;
 
 	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+
+	/* Put the STE back to what arm_smmu_init_strtab() sets */
+	if (disable_bypass && !dev->iommu->require_direct)
+		arm_smmu_make_abort_ste(&target);
+	else
+		arm_smmu_make_bypass_ste(&target);
+	arm_smmu_install_ste_for_dev(master, &target);
+
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
-- 
2.42.0

