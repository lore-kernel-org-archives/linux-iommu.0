Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A17D514
	for <iommu@lists.linux.dev>; Wed,  4 Oct 2023 11:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RibgbegWHel67UQOEwbUDfd0uDyzmqGLNO0U8Iu5AoS15xj6y5MCPkKEZItc1/ZEfHcrmqVfxCSdCLaPr8f90g3m1Y4RaTYC7hb3/zzr/WQAVrIBXP5OusKXDA/cnXSH4RFf8Ja5gujWwSsowrUw5KSqVgARYUV3OuzGg0yql+6o40ASAnAm5uvJ8NHD/HT21XQUMdzKeJsozD7C6w6A6Helgj6GikEwHCBn1cY6xiA9BDV8i2D7rPujP4Kt2WNZ3gm1qLO8ccGut618UaIq7PZXg4ge98B2HHqMifK34+nGqLDyaOl1dauNJaVQEVpPgl3/vnH4BKcgIZ8f50scZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTV693PIHgnROV8DJIpuOGIZVFALEz2YMX4UItA5g/Y=;
 b=Mlc4FBTu2pmChPVN9KaPXjlxvkJYVT0TQzed12NgS4M/xbADSbOtgY5lESAVr4xxlUlAFfO1Tzo7pUEBykoKWJXGifBuG85XKMFdmsYGVSPg5ojK14bZp47zkuvA/XJx0w5Kxa5YY80GYu5AznLU71Br9izVfcNozvU+AxHGSWbWbn4hBoByNKI0Xw55StyQoriGDTQ+ece5CFFNWs0DQtLZoFYoMz6iy4lvupi8rNj7Ag6fysCkcRfV6zEJZVsdi4ZsTRhATPGi6XzTs5ubGlmMilC78XF5jePKS4zYlKJHPjO0qnQ4GC2NYa1HLeUYZYuzbBXtTuOtGcz+P3oa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTV693PIHgnROV8DJIpuOGIZVFALEz2YMX4UItA5g/Y=;
 b=QEPrURNIvwSWOYxghg6Oq1S3i4FzukrrosXBPbbpaed4dQU6c6iMwUHEplmqAeua/Dba5ucYi7xxIqoo+UM40AgF2cwMrWx1mS+/DFtvSaP0JtshLNYGcAmhK6bhbZpZhg4qd3wDxQ70GYa/A9ncCt4hdpQjhkgdf/ikV/Idu52Io8blHSjNka+lyW/lYNKYJQBKq2uTUp+VLOXXWniBL87hsiPO0USqyrkWy6liMVBquspKF+HnocYNXABYm2C7CvB7Y7FLATnCyhtSmbDGyEz46yVPEDh7p/oyKnhS9NB87f4XkdDRzJNESR9cp9PU3UMx5NT1nAln/iKlqi/d/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 11:59:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 11:59:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH] iommu: Fix return code in iommu_group_alloc_default_domain()
Date: Wed,  4 Oct 2023 08:59:43 -0300
Message-ID: <0-v1-e4bb9f78c084+202-iommu_ga_err_ptr_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 1915b172-a0e9-4ec5-8647-08dbc4d1677d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p50bXQyMaWc3SuFUW2b9s7ySKjGrLM77bosxnW3QLxOEvOdLVnt592HjX8DdhN6k0JtTiTmYDlQ2PIy+c2U1vC1ANlFnAyCKX2+0xM7/AVkMwYif32FS3qJp5genskGoU4aL8s9qkdmVeMG1RBeds0v/P+z1+surj882zAT/RYJk0K/A5xfTLZ/ZJWyVuoPNKFVYeWb205/4IbMRd/cBsf30KfuzQ9xQmxyiKkfhhhb7P7ZqyzB2dmbxqGREVvSNhDZF1ErI3G1O0zW2WlqPl9sBNObCRqNv51XMF1DmQzW8ivphpEJtn/3a7+p+JyHRzmK1P2OAI0FwinQWd2mKpTiFpCeSiNn09TAiJQh/3/Ip/5i3B0hqgf8qXAhdSTF1uMlT4aOfumvWkPYL1uQ9saXolYjP9yrV5s1alIJqCZpmnN0TnIIwAlyjsu5VSimj07P8QuSGhlJUdXVTmbpbkZKnPl/FPMWFSK7cxYhFYa4IZBDXAD2P+rsVSAChduquQmddB6lVj5kDq2FplKmfKarEwJiLr8omEYhq6spuaAhCIWxibtMDXH5kiUR8E3BKuyiOX/G6lbtMIrW82W1QGyNjK9OWMSEpjQ8dJmnYK44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(966005)(6486002)(36756003)(6512007)(38100700002)(6666004)(86362001)(110136005)(478600001)(6506007)(66946007)(66556008)(66476007)(54906003)(316002)(41300700001)(2616005)(26005)(8936002)(4326008)(8676002)(5660300002)(83380400001)(4744005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WQ17PBcB9VBUr/1vif011+Arkz0I7C1h8NBeVqPz/TNvqwMjL1Q1oVPobA+J?=
 =?us-ascii?Q?Fc4so3gKKWLAAxgwGDUpZlDIwkR9dDkwKCKmFPNJ94HD0r3R5em0NQtFvYAS?=
 =?us-ascii?Q?2pjCMv7wKiIIuZzS6K1W2QyplWa8Nl9GvAPxuNSm/0n9WNJjKDN0nJqgjNq7?=
 =?us-ascii?Q?aX6Xfn+2JllQT/7mbVx2iDJfwdniEbdldQXGoAzqpnq9c6yc7B3fOq81jz0c?=
 =?us-ascii?Q?8VopyLepcLfWHrWt3W/nU8iC/1NeEAgFSQ7R1z14XWGNLzGPHQfit2RD7Wt4?=
 =?us-ascii?Q?0ZxL8s5s/uOpv69DViAv1BW6RiLAoDCQHxx3gl6VgXn4LG+j87h4hmYOVJi8?=
 =?us-ascii?Q?nTEtKFgdq3JrFV+kS9rLVBseciZhwaB4hUp3rbGw1Vhytzuz+5mh/4CYIhzs?=
 =?us-ascii?Q?avEheUdu908Ec/pI3ZwEPTJJUdLfDNll7pK2yV3i6mELxG799knHsFIjFMB9?=
 =?us-ascii?Q?d9SzjPO3hcRlvsaftFTtNuqmxf0tu7QP0T6eLIoN/oqSqYxdzaOvKn0xcz74?=
 =?us-ascii?Q?iVI2WeOgJ+JPtyajaw4yyAE5HcMHcbD/PkEW3QF6Xfde9x7UjBmdP7hR2tbh?=
 =?us-ascii?Q?HrIdozBHpXpWOyVZFseXGsEcAX051ElNFl7SaRlhxENfGzObPms+koLLSiSl?=
 =?us-ascii?Q?3hvWZI6o+Mejzu2e+JTA9KVpc4U5ttWD51nE7j/MMLJJYlh0JUaNvMD2LqM5?=
 =?us-ascii?Q?DPHOGdrsSO/ApQVZCnhvbf356lD29u+ABd9tSNmZDJQjs9GlIh+ZwCOK/TIZ?=
 =?us-ascii?Q?NDAWrhju1ucCeC9ycKGPkjS8QvHDOfg0uUqMF/+qca+cnhtd7YAzIhhBc90m?=
 =?us-ascii?Q?+eIUIzUxm8hffxxTRBYO+7cRPJGL3Somg8cBPk0wbQGMW6reaBiMHYS/bv7n?=
 =?us-ascii?Q?jwxC/bGxMip8qzZ/QWXxj5EEk/D71YeIq3dAyDP8gTanLJqkRgrwUeyO+Ul5?=
 =?us-ascii?Q?+wR5OZfg3tgljKgIxp4Sg4xTNp84q+FAXbGzTU9PifHb0RXrAmBbngIYYE1a?=
 =?us-ascii?Q?IYK1i9tJrkQP5sQHCuaT004HVnb6MBLK9yUdJZSfztJ2fJJIAdo5ADOJ72JK?=
 =?us-ascii?Q?s0HZfKaP/HMyAQe30UxxquXOknYomlXBNv+9GyxF8Hjl/LJ/AcvMUpTb/Xds?=
 =?us-ascii?Q?vZ8rrpJKGkalr2arbf4VLZ0RbrK2EiCR2S2bHLvkVZlzCw9Za0XbQiubMCfa?=
 =?us-ascii?Q?I+RFBaBNSNw7k/K+1FTfVaCWY69FXkkxA7E/bak99kguIcqA/LgwFuPdEm99?=
 =?us-ascii?Q?p0ihxFSnW3VXPeKJPTLopm+cvI5ZtR8WGcMzWyjxDkOS3w3Hb/YKq0Fy2cza?=
 =?us-ascii?Q?VBxcb7tB6PClIBZEoYiTCYGTjoZrFwyn8qHTFcpTFVZCP/ZSAcoMeW/pb4Dz?=
 =?us-ascii?Q?tUkP3d8oBH3cM3nA0OFVb2UnOuS8CpV9t+nJP29jGCtXzQ4rnQKaRBxRKvhu?=
 =?us-ascii?Q?wvBYfxJQJfVXAM7j33+NBIdlqBFNOj67xy8hhygdbeep3oAFVMzH3JmoH4I9?=
 =?us-ascii?Q?sPHV/m9eXA1GkEXMhV/uUs/aOEEbHk0qmCYP3Dxcua/vJejHGRm1Z9MxjiQV?=
 =?us-ascii?Q?wMCIKkWMFEbK5Z1WhWDh900ZIsfiECPkrFMdaTkd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1915b172-a0e9-4ec5-8647-08dbc4d1677d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 11:59:46.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSV8vPxxsGVGaUUVXm//tKRjrpbE0YuJMUrpqCyxa84ciX4w+wtdF7iHgnVwGmd0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294

This function returns NULL on errors, not ERR_PTR.

Fixes: 1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/8fb75157-6c81-4a9c-9992-d73d49902fa8@moroto.mountain
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 13b911e4323d06..f9f315d58a3a14 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1787,7 +1787,7 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	 */
 	if (ops->default_domain) {
 		if (req_type)
-			return -EINVAL;
+			return NULL;
 		return ops->default_domain;
 	}
 

base-commit: 2fa5936cb764a36a95f5b31c71fc6a2954336221
-- 
2.42.0

