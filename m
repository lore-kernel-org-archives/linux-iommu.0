Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE21C698
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EW6srVAg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td9ITd+0eKJJezfDE1+NytFazkyMuqtOYuyjQ0HEzpfv7NxkfoDWc65CXnO3dW9Ah/rxSh5HCHI0NhcNEH1nMF4aTGzVXtJM6HokCL4tO26dFKaisYq5D3pGoBX+XvJN6Lj1kXHaG03ExqG4kJUKVRejQfSrPRfGkWljXmsY30FIJKDm8NuEWUK5lwdyOtqmCB+QRCAcTC4ditiD37wVBzuiM2Vjq6gc7vC46Yrqrhl0GKdeNf5O0PC6n3EbAYliPkKjzGYqLpPlPv4Za0yD2CLqhXToaSucBrOPu/Uhxq+ZC4ANFzwOFLzUZJpjUZHi1rZNkoJ9aQw/h+EsdEsp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xKslKn9pVv0Z198zV9SF7XR7Y47z3raRdyktAJza7w=;
 b=DrirZwQ4EEXld4ZO/ASqipHVyyDkKu+Vc/I68o4WDo71OSqrOYWL/RahRm+nEI9BYNhrU6YCpjt+typIv4vYNjl0yR6/r+qUIJP1dJ0K52eZW+lx3WvVeg5KzSi3E3R03Wlx8gulfqgBITYqX5EjPjhXt4VyuAvAytI+SnYvx209sVtcTmPZt2CNGJDlIqsVAGxW5Ne7z+E9OG+eo6JbQIvw9IvfWMxPwK5R8mq1TYdyBPfVLujKGTTSpwp0HfeyqBCV+3PU7nQ263K6XTembDvCZbOgROdWijr6Ss1rUXNYcS4cHnkTuNPlYUjXReIU8fjZHGgqLjBQN1eIldC/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xKslKn9pVv0Z198zV9SF7XR7Y47z3raRdyktAJza7w=;
 b=EW6srVAg9WAvey8kMeoXRl+U07zKFDXUuF6bqEiHmLdeLT5cufQT6A+Pep0baJUEbKeQ0mYHyT03Pl6cTeyGdHtbrEjQcFUR4/TRtW6pDKD71T9fK4SIjOnWJQkyTWPDhP0wcmoApPSODYSddwqdX8uSd2uUIBZ9fxhkyuYonMKx2T5qVkFYOmp7rLHHHZr8gaJK3x4opKEHAl0fYjIWkj1LaBMtZDLzsnc0HR4sZUpsMVVNQHkZfEysYTHyW/1rJl0jE3wCNts5witeCwNAjDPHUUj6xdXBe2oE+B+FVLHwX1Tx2I4sK1kRncJxPpo91Lh+C3fwHNpRjI/89kpDZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 23:36:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 09/27] iommu/arm-smmu-v3: Allocate the CD table entry in advance
Date: Wed,  1 Nov 2023 20:36:27 -0300
Message-ID: <9-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a31fd9-3270-48c0-aaf0-08dbdb336956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	caZDyBaekgH7UR6vWvixPuAIRssRUEMho8sNPB6R/Ru5aP6vTDfB/jKnuQ+MtJEFEiLlwZWkEJawDRYPmHwAvTj3jvqu85iugZAPYOh2xgOaAbJ4219qoygwOp9z2rYOdEharuFMz0ErV96d5/O0WopBdq9sAmLY6qHtIFwaeHhQ5faX1neIZ8kqI87xjWepC5TXSCNLTziV9yNKyQQ0VhCV4rgJX0PSSHRTXJsKjhRAY+DaHcWKt1axKZNaSanYl69GUr1KKp5NYe9102NDgzQSsulWMJOFYphfS8gkfl/zvFJMBnroyZBwqujJ9V2eKaDgQsmLhQTy2B6tQu5eW0qssTebLN6V04b8B7azU0J46zzWehScxQy8aJe0ke33rMpVQYYCh54GWgjy+370bK+IDeVM7rNbpAcb+ZKfAy17l9G75OThRFAg2+ipr7h9c8weTUU89DEm2tDqFY6js4xh1uRqrUpO0w4hIrr53P7XlP2yq+E6L2QyCUj1NIJxCZ1MQw5lTeXQTfXpe0gM/vX6wzvcpB8SViqV4f+urIjBi+FjjY2MbER1MArKDZiaya+qOtMWhZdBa8Q7sMbaS0ELLGBzD1BNQNuBEhGIsVc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4326008)(8936002)(83380400001)(86362001)(2906002)(38100700002)(8676002)(36756003)(5660300002)(41300700001)(26005)(66946007)(6506007)(6512007)(478600001)(6486002)(6666004)(54906003)(66476007)(316002)(66556008)(110136005)(2616005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HkuY09UZ9rsaJ/rPzIwikQNMJ9Wa7ELkeL57GRCszVbB4uzF3HOfM1mLySfa?=
 =?us-ascii?Q?g1oCPg+yrnRJjmb8C1op24UOQboPzVtNHuTWg3xKgolwmfPCUpG/paH4F/4Z?=
 =?us-ascii?Q?PEkNnVi7VArvXo3ISPlXE3QVYVFNuquvOPYt8bqRxJJ9YAlvIOA03F+yQZ9A?=
 =?us-ascii?Q?547IXceGdgvLpV7aRuDJKVm00/pUMSbUdd1jgcMv4H3dXz0xzCQDnqBtMQtE?=
 =?us-ascii?Q?pwAbgDLk7UfyGeGYtlkkcJ4l53sjycWmPb8sehQy+UCdqHOlxOfpaaP29Xya?=
 =?us-ascii?Q?fujkLLOFlJ+BGTE8TvPwbJhyyKlzzNWIlyMqHXxibnSL6XfPFN3dS+IcaAp5?=
 =?us-ascii?Q?M8T8ezNXd7ntjX8OYv/W2gnAuLRWZ8Xvy89RC08iXl8gm6aE0S2zNNph71md?=
 =?us-ascii?Q?7i4s2lpTpCaivs3Kj3zYG0vL/ck34m2qEZZB1Fmvci/xshkgbjo2A4imhg9f?=
 =?us-ascii?Q?0eJc0Y4TW5D2BJYrzIwjif7/4HvTN1MLMdoHrTXA2c54xO4AvUV2599In1ev?=
 =?us-ascii?Q?dvWj21vYwJIz0TpcuUorLqw/ZIAVap4KCQ+gIqMLHMGS8o3uILXXiNEHtfd8?=
 =?us-ascii?Q?YeTrWytqtiEvjmFzO0FI87q6aW1Xrfp4O4B3VYuUNGEldeWBTz4rmq8bdI3q?=
 =?us-ascii?Q?+XXukbj2T414D0IE1jy+YO3Nd8aOp0UBNjPoFP7D23eoJyYyoUAqvyjGjPm5?=
 =?us-ascii?Q?y0cxQn64GxLZDqnUmt58rc4YknpIfknfxrQXXeVNPDNMnssIiEs2LXpGjn7p?=
 =?us-ascii?Q?zxCwCErXYyKAE6yt3AQW6t4HqlpBx+yu3HUDsmp5IfY4WnoixtnaVxyh0CtV?=
 =?us-ascii?Q?cHlhppMM8XJaOs4SGNVFmiX5+2vrOGm+g0x2FL4ukj0feEqevv/qZ5nGb88g?=
 =?us-ascii?Q?7y6N/0xE42dC4biCRS+LamVoM22cnY8JXzk7aTua22RW8ORQaw0fmmh5p2fE?=
 =?us-ascii?Q?i+kcw/REAdbLaX1ycNJzypGilB1lpz9JbeqQ/K6jDB0ts1L9Pd8qDMN+Jkw2?=
 =?us-ascii?Q?RTXX/ACGwEvt7dzFK/LuW01T2lHOYa/DPtSjKlAAMr3atqvN8XC3bafNZWec?=
 =?us-ascii?Q?Z1u0T2N0ZQzINkdQbGdmzBk6itFd5oc2skVdv3Sv4WVn4JfOS6OmYlos1Zyj?=
 =?us-ascii?Q?C+eAQ9Xmp8H63lCRaKaR/dVnt/GSZ462HA21QJHKReD9+CwJgP4DpOfks290?=
 =?us-ascii?Q?hyt3/PVy2wiX8tFYH5AgSGdOH0ULX0cIaJ0DYZMiC5IvjW4qxgrJcbARLNLd?=
 =?us-ascii?Q?LBdBC+XRkXBgnQMpda7muu1o395WB58fCVt2nX954MoK1kMnGdt/GUaQL0/l?=
 =?us-ascii?Q?r4FX16Z/wkHyBanva9+AMDzmUu3XqMAHE6lVDRi0uN+B1Pq91HMLdChsxj1z?=
 =?us-ascii?Q?HkKVe0BHll5Nj20M/rv8UAcq6nPwnHn0Br2EyUQ6+uwGfwDjJkdRE46YDE9Z?=
 =?us-ascii?Q?tItlpOLN8l4VNp2Gj9PVys10llzrYxsAx8UZJn+y1y5LmYGHKCARZxVJKqcC?=
 =?us-ascii?Q?9udWQeYwfW/AU9hRhh9JhPQhpo+jXdP5Wo2VN6AKD64+Qyhmq43E6IS8P6d2?=
 =?us-ascii?Q?1LiSbNpfnmYlkJyU+vpibYgul9HLtYNGg2VYpDEl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a31fd9-3270-48c0-aaf0-08dbdb336956
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBC9xmfgPxOus4/6DlRIL8eKpVTq8LPRrmD72lZHdcI2qOeekuxfUmpj2cEPXj97
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301

Avoid arm_smmu_attach_dev() having to undo the changes to the
smmu_domain->devices list, acquire the cdptr earlier so we don't need to
handle that error.

Now there is a clear break in arm_smmu_attach_dev() where all the
prep-work has been done non-disruptively and we commit to making the HW
change, which cannot fail.

This completes transforming arm_smmu_attach_dev() so that it does not
disturb the HW if it fails.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++--------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a95e16a83f0196..67544a92a7714c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2596,6 +2596,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master;
+	struct arm_smmu_cd *cdptr;
 
 	if (!fwspec)
 		return -ENOENT;
@@ -2624,6 +2625,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (ret)
 		return ret;
 
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
+		if (!cdptr)
+			return -ENOMEM;
+	}
+
 	/*
 	 * Prevent arm_smmu_share_asid() from trying to change the ASID
 	 * of either the old or new domain while we are working on it.
@@ -2643,13 +2650,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	switch (smmu_domain->stage) {
 	case ARM_SMMU_DOMAIN_S1: {
 		struct arm_smmu_cd target_cd;
-		struct arm_smmu_cd *cdptr;
-
-		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
-		if (!cdptr) {
-			ret = -ENOMEM;
-			goto out_list_del;
-		}
 
 		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
 		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
@@ -2666,16 +2666,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	arm_smmu_enable_ats(master, smmu_domain);
-	goto out_unlock;
-
-out_list_del:
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
-
-out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
-	return ret;
+	return 0;
 }
 
 static int arm_smmu_attach_dev_ste(struct device *dev,
-- 
2.42.0

