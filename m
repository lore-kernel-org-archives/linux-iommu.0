Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E011101E9;
	Tue, 18 Jul 2023 19:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsrG+F5afznIIuubP4ZMJKFkzpdpeXIym9QL6t5eWH7MFD4iMtyqKKmH4RDWhx/682gppXfolWk2cAXXEr18IiRGnR/CjzCR9OJZ+msRPVjR3ssLHApkLEN2DrG2l6fYOhBtNB0EtZXuFh2YFgicssQ8Xmf356Apoux58gV+NAD0n8SaG7JNSTJg1Lz/w+8i/2oiws10HtsolzrUthO+JgbvrsXrODz5Zk1ZcDhQhSZyvkGOyM7gpKKNgtEmhxKB96++nEi1DaKmo7WnXUmm+gTJc+ORdE/+xq6ceWLqvLxKyrB3BXbysYyq8WqhRdZjJq5yJPuUEE4p8wt2jpxu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE+UQONWAdRVQ3rLYcmUMjoa9bBXOMIEbkUImBMOc2I=;
 b=E4DFPKezYIRsSH08wHNeg+6zXGhP4yMKSypoezQs0u+hi2U4Qhp9LcSquIwrFpaLhYcaJvYjJVwYHbR22AJchxgKT2gXYVF9aQWGhbFt5OhN3qftF2E/LOwvrLcEaMXI+FgABNJDRuRDklv/JclDiHNxxwG30FIeOw3hOT0L6TH/QAQ7I49YeelXMIPlHpoh2yJxw9ZMb9iFmL4nQriC6Ufr7qtnXvH7dUuDrhSEWeycwbVat0prScqOgio0AeKEN6cG9nN3nDtNZ7su8fAy84/Nb9vOAM3Z00vt/SaY/2SZEyodlWIDoHqFuiOXcPPuJnD6Cyi0uK7xTkgz8Sxj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE+UQONWAdRVQ3rLYcmUMjoa9bBXOMIEbkUImBMOc2I=;
 b=Jqg7U8312aEjU3emr45IonNgXUBWzJyI498fLngZAxfAeHIykuk9KWpS03trDxCvC5F/+YJtxckyt7GYcyLq4RK710ObartEf/Ztudw8wqHNWKDHfw3YGaaEwdk43H8gopbNYjzefaVaFs+2Wkc5MA88pVezQHT1pk9lcVQpaGGqCraEOZdONbQbVtJ7yHcbS98LN0CuHs8na4vOMOUIh6H9aBbOZ+VmpgOKb/Ef3CEZ5DMJGB4eE5PmN92eudJSPgpW3Qy2lcRCQ9ZiBp9kJUCe6TrettRSoOYQfRT9Fw56zcBbSkmWIqCUccu1+PL7lPlqzTBn/cP4J22jjqawHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:06:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:06:00 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 10/10] iommu/intel: Fix missing locking for show_device_domain_translation()
Date: Tue, 18 Jul 2023 16:05:58 -0300
Message-ID: <10-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 6318ddf4-4dc9-4d1f-f696-08db87c2062e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1JKjP4e7z4HuMZj81Oejfx4565+SZsPAqc5+w2c2js7FCYcfC6xhDsfAB5X0XFSKUnCocefvSJPQqPxJdJpu9atNTq2UqLohDyEbN6LJvOPMTiEg6ibZO5vQ/J3wJJ5XSzHmBSz+PcrUlNuHDKGUdxXfPRtwZJcpGRVaVtYA7T7AYFsA7Ep+kcUz/Kb8vBl5EXQVXfmdUNDepO+Eb3uW+7PxoMcoC3ds9D1VdAboA8XTyNX+VajoYIqruQJbhaFLJmdyYmh1o/oq8g1S1knIaz0nzif9+tfubLZXuJr1fnnIoLsFFfL1GoZnfSSHGJg6ZDuEadXXpty8kXr8PIdX77SKV87av6p5seMlarIe1W/kXsqFOctqhDb6IBFEKPGLNdhgj1BdruQ7gd2lsnzUAw3pfHu591JP3JlUL/EXT89Tol4JYZ++a7v3X52knewod5VcgrcCuURxYquv6TpBWHFbuxSp37keOf9ba5XO+87bABvTjdwvd2BzHymOaRG9G9+8qxz2uDNc3hskHAqsXsektBajeuxA2WfQYl7RahLBa5tX1r7RJe5UROcE8vnso8PwchzJstE5CPP/KMB4s/iViyS2bj3QJGf1r50+GtA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(110136005)(6512007)(38100700002)(921005)(2616005)(83380400001)(186003)(6506007)(26005)(5660300002)(86362001)(36756003)(8676002)(7416002)(4326008)(478600001)(6486002)(316002)(66946007)(8936002)(66476007)(41300700001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UtFeln/cH2EW1zzArrxD67+3KOtCDSL41qtWNw+/acdxx6s//xigN8Y3DrQ/?=
 =?us-ascii?Q?OpGCJyiwqvNyPb2E9fFEoa70PQ0nW7oi5q/ASABv4IUaYqdn3fEw4LQ0UEr3?=
 =?us-ascii?Q?dXASUL8FFmLm2KJEXaJeZBjbBPDBmwnbNnKhQVfwMPLGB3QwRKVkLkV3oybW?=
 =?us-ascii?Q?TFkA/A49iEAb5Yw2Urw+w0ksQMfYtVUso9rrcO4q2pzZPW3WqY88GDrjXa/x?=
 =?us-ascii?Q?SsO8v8OhoDBaaV9O68HN6UoV9XDyo6TPrEVv1ZrNWMZ+Aj51PD3xOVIPb+0R?=
 =?us-ascii?Q?omRsmgpOUN949kjRwftx+kk8VJKrdtrVyUrbh3PU58eyb9neaeABldMyp/X4?=
 =?us-ascii?Q?cdQCFhZre22wna/jtZTaoII8NQlRgsR9+ow3F4GQZenECaAIPOLGlDx3c+vR?=
 =?us-ascii?Q?oUjmw8WJxPWJ0Cd1Q6HRk0+nl+DAISo9+Zo1kBxIMxGB6nVL/FB0Q9PXJsYD?=
 =?us-ascii?Q?3lR96PSfTn4vARk2L2QPdUMLUbAyvqH1nvsWcconyFgIiYbRT+X1y2umOMMQ?=
 =?us-ascii?Q?KeLFKHp/jVNCjX/ZGQtk/LMiwNSvw7HLZF8jDwVea6AUm3f1jNfC5bUnhlLX?=
 =?us-ascii?Q?Qy/XjAX5RH/qBc1dY8QTUwXKJZLXWPd2twpZ55/GizJIcc2v5nxtZHdM23Mn?=
 =?us-ascii?Q?r2cW+ZGf3A6ZnrM3QDGThUzqfAgnNhk1zcnyE/1o6qnNjpVMMnmta2z1+qsb?=
 =?us-ascii?Q?bbRZ4iLGJq88WNaTczR3j5yc3FjcM2h1c1l7pYr0pJRs/U/RSeRxbhc+p67T?=
 =?us-ascii?Q?/jDAMHGA51U6ZGpkP42+558houo2LbtqTqJyXl22vqg1xLJ35x3D0mBYf2Vq?=
 =?us-ascii?Q?cE/PTsu4Tu0+2Y/xNM6RcZML1gk8BIyI75DKGXGxbTRl0U+zLYk5dcQXm3Bn?=
 =?us-ascii?Q?4Q/ZZQn0WWP4GpYKgQkjAez5CYoW7nGu27eukswXXH2EDdZfTZPnvIuWyvMO?=
 =?us-ascii?Q?lV5ErYbTFM81NU0X7t6fkaNRSij1V3MjXGUEUwdrwf71UgrMvJZIbwmCrSDW?=
 =?us-ascii?Q?beAClxS4hl+q0pG+YGbso26oOJjuSd7hYCuxlpLR3lh9fJ8zkPUgZtVfUVUW?=
 =?us-ascii?Q?3t7lSrPNKmq9rdCsyJ1m5CpGMCMB+9sIG5vjifWXWgVooIYPjf1ngpBm05ca?=
 =?us-ascii?Q?BDoAuvOuDZoT8qtkhHVlEqWVzkpra5jIqryj2/1CGnDUvyEnEmtzzwbrNmBi?=
 =?us-ascii?Q?cS0AOF99dpG0V3vMq8ktAmnSe48pGSOygtQDfvnBBUyryDvln3iCPGGjWgRs?=
 =?us-ascii?Q?ELZhoLqrh9hj4CtCIER71z1XwVtgUsPTTTjM6JfhQyKChhe4ADgTTo/kXchI?=
 =?us-ascii?Q?Kn9RHBWHRYo/yGcUStCX+ajsTR9FX1CjmkAEixQ25AgYmnryhzadn5kpwBPG?=
 =?us-ascii?Q?VA/ECIF4avqIjjOfkIiq0l46u02A1YnD6Rqv160wdwPJLyOP+MOeDQHIV9bU?=
 =?us-ascii?Q?G1npSCadrzW0o4yIirxIzA5dJJLnLk24IgVRZZ9sTwtPUpzNg2jzkzUzn47s?=
 =?us-ascii?Q?X6SW2PyUmOiB/PCR8zDejKCPjUKo9hiUopVebFZjZib0xJWm9cdqNEpvURUs?=
 =?us-ascii?Q?2XCS7T7dUw/QHABDq+hLJ+Yl+sa09845Mjjzahzk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6318ddf4-4dc9-4d1f-f696-08db87c2062e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:00.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PedWjx6rJZ+0xpIV7Ogu71TLvzBfsy1uc8CNccL3duVJfPHOpVC4YNGUd2AHUuTE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

This is called from bus_for_each_dev() and must lock the device before
calling iommu_group_get().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/debugfs.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 1f925285104eee..0255c4a2326931 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -365,23 +365,25 @@ static int show_device_domain_translation(struct device *dev, void *data)
 {
 	struct iommu_group *group;
 
+	device_lock(dev);
 	group = iommu_group_get(dev);
-	if (group) {
-		/*
-		 * The group->mutex is held across the callback, which will
-		 * block calls to iommu_attach/detach_group/device. Hence,
-		 * the domain of the device will not change during traversal.
-		 *
-		 * All devices in an iommu group share a single domain, hence
-		 * we only dump the domain of the first device. Even though,
-		 * this code still possibly races with the iommu_unmap()
-		 * interface. This could be solved by RCU-freeing the page
-		 * table pages in the iommu_unmap() path.
-		 */
-		iommu_group_for_each_dev(group, data,
-					 __show_device_domain_translation);
-		iommu_group_put(group);
-	}
+	device_unlock(dev);
+	if (!group)
+		return 0;
+
+	/*
+	 * The group->mutex is held across the callback, which will
+	 * block calls to iommu_attach/detach_group/device. Hence,
+	 * the domain of the device will not change during traversal.
+	 *
+	 * All devices in an iommu group share a single domain, hence
+	 * we only dump the domain of the first device. Even though,
+	 * this code still possibly races with the iommu_unmap()
+	 * interface. This could be solved by RCU-freeing the page
+	 * table pages in the iommu_unmap() path.
+	 */
+	iommu_group_for_each_dev(group, data, __show_device_domain_translation);
+	iommu_group_put(group);
 
 	return 0;
 }
-- 
2.41.0

