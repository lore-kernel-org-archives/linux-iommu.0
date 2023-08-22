Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747331DA4F;
	Tue, 22 Aug 2023 16:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW24m1VRJBDZ5jFGZS2tT7SRRLbzeC+1QOJatGPZILioWB/xknXwimP7ws7+Ua9mirjEyCyZi+rx2sHTrIEqQAnabFdiuhPfNch3IwU3iMVLZXEv4eH8njCPcbdiKWbgy+9wImH/MjdwSLTHkYEuPpYIgFZ+++82v8Bf24jUMiGq+iBIi+3dOR0c/to3lo8yM5aWWkyUXvyxBSRBqNmxyxIJz5bvb/QvjGJf4J0PJB3R1cjBcZMOW5mADRXXq1T+0og5jaZRkgZ8fOJiadyVepVl23mLkJ1lQY2wnV3MxG3jF9qP2Ma5DhMBD7q/zJcD2Cs9dnqwHcEbB9KLYUeGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qunw758No1uqIWTm52lIxe3fGHIxNkfgVaaLpgAqlZ8=;
 b=UXDvJCt3+pZy6SOIFhoQhUq3cuqyFSXnP7CBgNozww2uF8MHbNU5efTkqxVZWyiIzuW/iYe1Y7yyJel2qmJ2y6TNi1ZSc4WI/NcLjeMbECeAyyaqAAaQNDziCPdF0XYjAz9gAfAkQedekn4/ZaibEko+xlpkYW/3qpZ2jYePz5CjeE2aOiL3ZFx07LF5AdPFDFIlxh+bzBV6RCIbhxLbNHAlh7ldAGOSBytYtTuFRlP3zF4/qTdtmHoqkqlYh/uEegU7qN+WmlllfM0DZMIxasqi0jl9PrvOrVwoeIrZX1lMVGsegV633Xm3+lSn0ob9rW9FG1UVE6EO31G5Pn32rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qunw758No1uqIWTm52lIxe3fGHIxNkfgVaaLpgAqlZ8=;
 b=tWUotb71MOVNnLbMzZCKsCabLXYw+Pdj2C4uv+F5xe7UId653xK2VdbGBpRbMogTwUc+qO0m899xgCALKHsxnrQNsrPRY88G6efLgX827YkeOioqp+/A6MBQJFRl/cMDOax+54lOx1dEtIHfqNXHQJExQGO0p+KagCF5sdYSOxyAuAgfKgJvcobiIIheqfl4JcvDsPF/5kzXSgQIlFKi4Cf5UE8PyYa6j4w+LCxanulDITdhwqFCgZvxKxDvrrGch8vaigAHMCLoDnBxDSA0cYJ1MITjQPFG6eW3L370AMx/PqMJL6wuP1iG0cwIgI4bfj9Hn4wco8azCP39XPwqyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 16:16:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 16:16:06 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/7] Introduce generic_single_device_group()
Date: Tue, 22 Aug 2023 13:15:55 -0300
Message-ID: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:610:4d::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa18407-e016-4d20-fd2e-08dba32b161a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cXebvd5D38gQBcquABPSLm6Gvet11e//SUyFO9/g2sPTa1gWZsOZJnxsPxMzYsOD7040G53UsP3FMC16dMAdisKUSsOWkRO3mDB03GfZT0Mv9v7hNxd39f2zgo/3NBbJT3VJND9BaEbmHndqnmtmRflUjBeFZqLQwkAIoSbqVNBreJpramotQsqRvbIQuc/qsF5ur1Th/TpkxTTm9GptsuDeG5OAGuT7JZGPVDoUC0ihDeVASyeZOJeorFx0UK83BYPFaJ3DzLJRETowZv4uwgFBj8N7imKVKOaZjMdnz/fNWSS8bMK3dVvPrzfXIyPACaQhcYLkHAFUkbqvGXMYxAhip+VytbEtOmXQbmM9s85MBkIGHNlgdjysNvXZDw4fJ1ejDpXYvIw8RtkWR19/Lnx4orquM//WEyhfK9/J4gedHo1PWBwcR0tu2+kgGrFUyBj2/U3dObnFdmr65hsUqObNPXZNcMC+zL122mV2iVfwtz1HnkqYtZdicE/fazSMeVhMZoLu9TXCLjEYIKQLpQ3PJTwo2fkjtUtPkZYVEb4JyVdOkArFqjb9vaVysWCnE18d4pdtx2ufD2G88E0iAn4/9a3SOdSYTuNYR9PV109AzJTnWrfUFH4GXApLaLDPPJIavBt9i8zB9E4KyBbOCmdRqPFKXQ39CifG7KXzs7wY+dRCLTuGRPmccdoCWHKl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199024)(1800799009)(186009)(83380400001)(478600001)(966005)(921005)(26005)(6506007)(6486002)(2616005)(6512007)(6666004)(86362001)(5660300002)(4326008)(2906002)(7416002)(66556008)(38100700002)(110136005)(316002)(54906003)(66476007)(41300700001)(8676002)(8936002)(36756003)(66946007)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ExcFP1i+acHURXob7YzQSSJY5tZNpkMfhYjmlEhCjyhHyzYGNpb3s9zxbafz?=
 =?us-ascii?Q?tKWsUrLnegjmBax93BkeAZiTSeJXPPin/vo0zJ02gMnActUmJYXKVTbE8GXx?=
 =?us-ascii?Q?mKepW33oYTnzYWrnu2aK4JakQwcwV/bmN/tViBvMEJxP1Rw7h+1wqE/KCnLa?=
 =?us-ascii?Q?VZoUg7VjYqnHzButtzMts7x0PL+iJVsFIujxCyX7lzF9RwMnxOjU3qJmtVPn?=
 =?us-ascii?Q?6MKvMyX0ajeHNp6Xj28SE1fVDeBoFnN4zBKybTmuT7PoWFPTyVbymHCu+xCW?=
 =?us-ascii?Q?Jlq5XA0MapO64MLaSydJM4tGsk/dMnugYsrAapfBB41ubcdMLASlqI5d+etp?=
 =?us-ascii?Q?6Ibzo7jPsWuODvw/7aup6zO3+bb0vlpCzeuPfBNAw1MEh9NiRgq/q8+WUd1u?=
 =?us-ascii?Q?qkaXLexNFhq8J7yi0+oFmxBvejLhkZhfgezXuRz6WU1oLCJYm88Q7xmNqYA7?=
 =?us-ascii?Q?zUMSpJ26rVLoAOqPgawhoq5SfY730gLZe0dx7viDLH+Kk2xasQmmc3tjmJk3?=
 =?us-ascii?Q?G/qdQNoT1xCkvn6urAaPkz0hUj8xAvM2K2eBuMhI+wT6yACF8FUB7m2Yfh72?=
 =?us-ascii?Q?HPBFPHU/cxd61X+Wgc1hGDIArq7wN6LgnoBC00jD4UshcYPFlrvAhlwi+q5y?=
 =?us-ascii?Q?8NKnX55vLN+1oRBgeNvRFCpbuGhzHOHzECm4gXt3gh1hmJX2SEQGIuyE6yvl?=
 =?us-ascii?Q?azd0SseiVzhFMegqMwUUIcJWgpqsHw2zg38Gwyf2JcsfMSybivMfuy1F6+Ot?=
 =?us-ascii?Q?m2CDeyiw/KQY2NfeDQC2qZY/bEKgW/UcfHDOBjzAHmfB7eTymMOFbcJK7POr?=
 =?us-ascii?Q?Daln0P2ojRfcZEOmumZZmY90zxX+l6yLPyb2k1i0kNDQPoKIfg8NbgZxSFWy?=
 =?us-ascii?Q?L2MpJT1hfAPFZY27Srn6WV7ZUnHzqi8OiBHczsnIbr9PVe8Sg59IxZjHWduu?=
 =?us-ascii?Q?Tz3Bl7x0JUVhgJRlm3uEwySgA2XJoAuPyy98WwqVlu2SrP4OWGTnmirbbVS5?=
 =?us-ascii?Q?g7hTrhx4ISo7crD+jFwFF0fCSSeJtUZScjoaDZP8q7Q5eo+Eiu63xXn3mYyw?=
 =?us-ascii?Q?wGmrXXeZdsuYXRTFRueY2skRAZZBH7o5IFvuJv0LQ8aylT/Al4G+skgvmyQO?=
 =?us-ascii?Q?wMpgiOtsO+cFGCy4iIq8clVkLlqzGG9z3L+9aB7o/9EgzNfSnEFWWER900fA?=
 =?us-ascii?Q?PzixFXeV96ObFHDHJpUmvjCQoH3+Mx9Kdg0SqQMRhT0bIUriB/Af3uo+P3AX?=
 =?us-ascii?Q?anAi12pS0dNqzHRTurGH6Exqsxl9FI6nGFb9/tpoYKvJPNE6wwidIst00rW5?=
 =?us-ascii?Q?Z4oXylp4a30TCpSO6IkfZNAathreBIRKBNYEd2iwQY0G4mIVknjSTMG/9jY3?=
 =?us-ascii?Q?jbyETdVZUcSr0YD8+9Gk2RjBypYANGMQpChUDVyDAA6Ux9xD81ie3B/5GS8s?=
 =?us-ascii?Q?MSS6+MyZM/Xqme/1QBD16chitdEj27haBVIE/K2qAA2Cq0NEF4Bh/NRMZgHC?=
 =?us-ascii?Q?7QC45V37dmlx0a1jk32qvNsUVHp3NURwOvHTHhuuQKJGSIKwSgntob8j/+Xe?=
 =?us-ascii?Q?10UZH2ZyGdM0h1CyXVzroAmRWjMRJIey12HMF7iI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa18407-e016-4d20-fd2e-08dba32b161a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:16:05.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdxm1bnIqc9AVLN/ecSlZpTZEllYj7FNJMzarEts2D3/ub5wbAsqw1Nru3vLSDti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

This was previously part of the reverted locking rework, but it stands
alone just fine. It has already been in linux-next for a few weeks, this
folds the bug fix from:

https://lore.kernel.org/all/e5e75222-13a9-ee01-0c25-8311b622fe0d@samsung.com/

The patch "iommu: Add a lockdep assertion for remaining dev->iommu_group
reads" is pushed out of this series, even though the logic and explanation
behind that is still correct.

Jason Gunthorpe (7):
  iommu: Remove useless group refcounting
  iommu: Add generic_single_device_group()
  iommu/sun50i: Convert to generic_single_device_group()
  iommu/sprd: Convert to generic_single_device_group()
  iommu/rockchip: Convert to generic_single_device_group()
  iommu/ipmmu-vmsa: Convert to generic_single_device_group()
  iommu/omap: Convert to generic_single_device_group()

 drivers/iommu/iommu.c          | 85 +++++++++++++++++++---------------
 drivers/iommu/ipmmu-vmsa.c     | 22 ++-------
 drivers/iommu/omap-iommu.c     | 30 ++----------
 drivers/iommu/omap-iommu.h     |  2 +-
 drivers/iommu/rockchip-iommu.c | 22 +--------
 drivers/iommu/sprd-iommu.c     | 24 +---------
 drivers/iommu/sun50i-iommu.c   | 29 +++---------
 include/linux/iommu.h          |  3 ++
 8 files changed, 71 insertions(+), 146 deletions(-)


base-commit: d8fe59f11096d6470b5f53739e49cdce67f3e127
-- 
2.41.0

