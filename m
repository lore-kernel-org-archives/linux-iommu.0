Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABBC1C2F
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n47onOJi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtZcAst/NjOrCyBRhd0/wf7L8WmO2/4xWEYvqenR32BtX6Gjwvqg6yoQF9FZSfe3ee1tB9/u1yNiTmt4pNGwxuah/lk4nqrYImvSBitP5pWNRm/nERrZBGcBO3GKQS5p4TLukl3Igrs5A42K02dz8D23LTnyB6GAPcdvC8Up5KlKGf+yBWWmXQZdDbhe7P58oG9LVnzAStK3nw0v+Q1W+17V8gJ8q+czwgV18NVck2bCuV15gu2Y3cM5K/NobuWBlL7uczS12p93twLnC+YTiM4bklWfjMoB4S8uciGavU5PU01mIexXpPkJ5wyHgPbQosDBUy8t0c6q3scdv1p3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fU5KZ8JSkzVJmqI9EXc2PiFFDbrPyxmFTsOT8OudYAM=;
 b=DK0T0A147hUn7xyKSha5xL9KHrxSGSFAgEyseQaVQn1LqxQp8Bybiulq390kRgYE7jmDuMVBo7bm8a4u85eP3GWuVQ+eynMoeKfT6G3dtVQwaQ270AQPVpYU9nQWYhq7iMVi36lVMFLQJcXT7R6bLRB33ffnpjUn9wVl4q9Vft7YzJYbJeFzg//iHWo2xzCG7BvHedkUNT/7aH1G+LIuivVNeunL9mGkJxl6I8KVDPOUzxOJvSuxlUvuq7KrQ7X8GA7TUNAFZrGwgKzmr+4kMEnpqLCKYGylRSaK2loV72zdIxvCap7fjEADZYrh+lNm7JLVEMqJ144PS5gSJBGuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU5KZ8JSkzVJmqI9EXc2PiFFDbrPyxmFTsOT8OudYAM=;
 b=n47onOJi0PuDYRli/A8Z2SAcg0Vvl2ok7g5gpbXcJirKMiTIKkDclVw5G1wZMFhe661CuCuvK27/mm7KFnR6YO0B+qyD/XuSr48JVswqLEPVyr3CQVBymqkqvhFDZin8f1Skyp5Yhl5dzwL1WYivli+Pi1+dCJhOnYZCc9zMUsrQV6e0Ehu9Ghrmto4d0E/pHBF3aIZV17g6Jf9F6W9RZ7lUQyA6KE6mkOkfV9JHqcTT9t6UQYpm94dDExc5sfZPm/w0ZXdq1Qvm//nx26pUWWl+q6Tr2Xfs6AAn6xDieM5SXdaPptaM896FWmUhnt2gGR+y0NwHktlZ0JQ9+jm/bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 06/19] iommu/arm-smmu-v3: Move arm_smmu_rmr_install_bypass_ste()
Date: Tue, 10 Oct 2023 21:33:12 -0300
Message-ID: <6-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:208:d4::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: b248d581-80a1-4ab7-b6c8-08dbc9f1aece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DjhNSh5rVS86dTrw4ipwiFgxeCzOQthDYR75hrzRWoGphchMnxNP8sMoWFrkpC/96FnoZ+Gr4v61W3bJ8ZR53bpxWP8MVm1xWOhYKAxh1HcSzNOvRQAgZZDJE407EgN4wJ7NcL0T9/VMdYY374WdFXSzofw16fEwTfXqPq8EmXJiKksdCLZA8K0+0+XnLcZuR0lAoPuGP/0jzzaj0v80HwsbTcbdg/lOa35nqOr0YE5E/XraglUpH45habpDyqcDhDxx3OysQWPFXC4Dl25jl/jfte8YL0Gpa7FxYZlcfyoN+IIgN67FgCbD00TQFBH+krBZWa5Ox+1nBt3lb/z+Lq/KxxXsS/ZBwLOZjr9qh5SWmq8POr/PDEQJqCpP/Zvzzc3fMAHgUMxRK05H2KWYIfS/arsgyMLrG5ZGfcZKef+lE8Fm8ZMvC7B2gYny5k4FENuK8FFwC3y4TkmrXVuuqNQUE/1MJ93U5re0mKo4nhsPIrp1Q9aoqNGBTO96gf+bf3ldjZolgR/tVGjCVk2ARZe841HDATWxB/9h9GxVPSERO4C1j4BGnD3enrf5ICYoVpc4YmY1Srtl460pFWDEVtfG9oC+Z1evmXaZafANEfY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+NhPWTr8cH648gLr21FQVYeQka/SVwdi2BFEgdY9erYhOraX8ki8hhOz2qrn?=
 =?us-ascii?Q?I/B8btS8FX0Yw71Ig9yIM/D3B+npagbkiWKcLcASJEyOhLYec1z8SVpXN4EO?=
 =?us-ascii?Q?cS2LGRjxKKLbOFwqo92l0agFwDP8JkeYO0D1MWGoS0xUoxbOPZHH4mrvnXZj?=
 =?us-ascii?Q?BcYerJ0qc3AUgZ7Fr4MqPloi/xDfhOi0H0cyCUxwE23UFHll5OyXF+IwhG6l?=
 =?us-ascii?Q?92++zkLkSTlJUF/z1FJv39Iv1DX4EjVq+Q0cpieAkiYNK6DBdYZ8pMwNJdt/?=
 =?us-ascii?Q?lXWkbE3pcIxagm5EGPqgPOhrUR3uC0XL5DiSAptDoTPUYUfwbniqm64stpYt?=
 =?us-ascii?Q?dOuG2j4+bS7aNlB7111A2+rsUufv9Mhsuzz7D4FQzNyd2JFoSaEhGBed0jay?=
 =?us-ascii?Q?jvWaMOyKj3iXk/I/nDKq7CBjBjlzN1layhB63JBfq59VooqSBgMtCswN2UmB?=
 =?us-ascii?Q?KuVnX4IwqjRSy+P1sHhHLSAeFQHkYgpN5yFZTJkYK+lHR+EZZxmvCU2qPVuJ?=
 =?us-ascii?Q?bUqWrJEoJUs7K1sSP85BE9Ru6cJnaq3an/jRnQp8FXgLvYFQqMDiRqalL2u2?=
 =?us-ascii?Q?Ej3yT8is+gCmCKYzolnGK1W31YHkHDeJRhflRSPIXemETUDbSRtYnuu2HzdJ?=
 =?us-ascii?Q?ql/UcRMpZqpVF5vz8F9yR/m3tm/RYj2YE2kmAOsa6C5j9kuseEl3clMJ41qw?=
 =?us-ascii?Q?UyZYTY6qOVNCIKDML1jcs7jTcXU+Xhn7ZETacyOLpGZJ3jAAaogfrVlzT0MK?=
 =?us-ascii?Q?aZIblWZ7NnxitdIWA0pe3UrOqP1wvyoYZBUtezMsLinodDwDTuX5p0ChngZI?=
 =?us-ascii?Q?1ytiPi0IKVTB15HlXZZmUeMgEDQKptqTS6oSxWdK5LqLTp0UqOSzltwDeo7F?=
 =?us-ascii?Q?tgFj164aDg5ht0av/JK0VzFe2/eYfyyUdBlgEeqjPjHlc4zVFRmfJgyjwRml?=
 =?us-ascii?Q?59y6slkp+k7pp8fxnvyt+GveqDu9PFPonovQATg/tyjU8bgKQzd/5fKFd24O?=
 =?us-ascii?Q?wjhCc+muG3w5aNB1jtDlbzyvJ19BNVtPB+v4lgrMLKg+cyWKsuTO+SNAi7KF?=
 =?us-ascii?Q?hmimbsIwdm3FEdxRRb67RvV1aKJvPklnr3SqG0Us8zE9Jm4Yq8ewWLcALBIn?=
 =?us-ascii?Q?9wduLHlPV4knK399r4oUknX8G7rJFvCMd2AO9j+CoqEetSlenevVp9mojZwy?=
 =?us-ascii?Q?2Yt8g9mCJTOcDApjDrGbjJbZ/vQ2ifvbohLsCO6t6EpEOCLrDudBZn3xV5z8?=
 =?us-ascii?Q?yFCJvCzCFMUnPdw4OOy3wBuVtVjkBzbfiMsffGnfDlLjFOQuSuyDZTh8Hp+A?=
 =?us-ascii?Q?j8wGg6dg/w1wCkTXVy69nJn6l/k4rAo0jlFCFKakSkGP6+IJ9QYRRpx+e4qg?=
 =?us-ascii?Q?T9aJZ+L+2F88WgGLcEQuBVU3is1ZQ2K8bI06jtTQxsW/M7qdIl4yBYF54cOZ?=
 =?us-ascii?Q?i7BmaHzJ8hw1o6fRqE7ijG7aCqdT2zg8Gz+aO5xGiy+1xJihxO8ZhcokH0c5?=
 =?us-ascii?Q?TZF7Mxa54Gdwg4SiITvkIH7vT8U87G/e6v0W7dxmWCeT47CyfeKqpIFNz0pL?=
 =?us-ascii?Q?bqV4fHaDPQFSwA7233lnnF8eZMARqYNqbNFOdhpg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b248d581-80a1-4ab7-b6c8-08dbc9f1aece
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSFd8t/0uxlsuGffNG62gAj2ba4xFWuQUvPRnrPSWkWDHmmv4wpHuGcGZ5NFDuSS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Logically arm_smmu_init_strtab_linear() is the function that allocates and
populates the stream table with the initial value of the STEs. After this
function returns the stream table should be fully ready.

arm_smmu_rmr_install_bypass_ste() adjusts the initial stream table to force
any SIDs that the FW says have IOMMU_RESV_DIRECT to use bypass. This
ensures there is no disruption to the identity mapping during boot.

Put arm_smmu_rmr_install_bypass_ste() into arm_smmu_init_strtab_linear(),
it already executes immediately after arm_smmu_init_strtab_linear().

No functional change intended.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 91e2bd1d8ed40b..27eac8d4d86f03 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -86,6 +86,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu);
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -3175,6 +3177,9 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	cfg->strtab_base_cfg = reg;
 
 	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents);
+
+	/* Check for RMRs and install bypass STEs if any */
+	arm_smmu_rmr_install_bypass_ste(smmu);
 	return 0;
 }
 
@@ -3988,9 +3993,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
 
-	/* Check for RMRs and install bypass STEs if any */
-	arm_smmu_rmr_install_bypass_ste(smmu);
-
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu, bypass);
 	if (ret)
-- 
2.42.0

