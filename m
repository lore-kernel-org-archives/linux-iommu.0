Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7660AD20
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 18:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC60jwWc10lNYrMF2K/0fGuAJX6NbVioZ1citx6QE3ED+2jl1oTue9dx2607P9cXnd8qbfBTZ7QhNoIWCJrDMs3Ip6TIyRyCM3d/ReHbIjFgfQ7NKJAxOFzuRafybSPome6euQtDtgg0dvZlV5s3Sr36LCBHlhP8JQAiOaqHtFO/kDVZQ5cgd+0d4Gv65or3Wc0OMFxu3EuqUU40Lp29j2uWc9a1jYsVcuwBRpGvUiGo+c/73bdgkYUE+WUuzETgxfJZLNpan+alN9pxg2fKdAZ0h9VB8DmHSYRIq2r8ZbooByAz6loFVAtU2SU9qdnvO9Dp48KR/E9lI3LyvfUSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yolRVVKMAdJ+Grb/rqAqKiavdlnzwIB/+/wXRmQmM6E=;
 b=VWDdWLvN9NNEjPwzIarqCr7gxONg24HOhACe/pN2HJciWry0WriSrp1+WuJautjpxchaKWCr+uQ55EmYvPKAOgFVkmnNJ6i1nJDzbgEA2sNeKB+/W/wDNyrSs+lcHVaPbV3ei+TnAgMag6ve7RRkm8lmcjagGDzBP7i1HDAtZtc6V4ovaKVA569oN+vgw3y0wDbx05MXV0Ih2do2In2URnOAQBfvwYyXwhvBkKfY4Be4F7CtCdP1WN8N16BhsK9JigysllyXJU/Mgu7CVVXqrgn/nn3R+QUj8GniVmYbtsmcLV5NI3c4U+3ZMHEa5rtRlVhRrYqPfCft/3peldR66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yolRVVKMAdJ+Grb/rqAqKiavdlnzwIB/+/wXRmQmM6E=;
 b=ZXG3CdgYRwtEj7UdtC3G5//ZOfwej7tG7KTQekZTDildcocEooIc7lKiKVleIf94KyFw4mGQaKObPYbPxEwgWKHEQupbGQACVwei1PEdtrIeknlqpVWgfER1Iu6CG1YEx4fojVfQTdA6kaVyWhb+WwOa9rWmEw19rV4LESWovwzj94zjB6DEuuzMRtu8kM+vNlc8o4GNQ8r7nA5NTRVMBY5InIVz7Ch5sTjFiqkoCqBOhHdTMUH/woaMxyGoU7BSFmfGQXH9TE2CKa2x6kmy0HX/7xoHoNESKV6mxRhlzOHatGmQ3iV8VpO5C/tCzOKya+tTVT90EQHecX/dswdNEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 18:02:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 18:02:50 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>
Cc: Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 1/4] iommufd: Do not add the same hwpt to the ioas->hwpt_list twice
Date: Mon, 13 Feb 2023 14:02:42 -0400
Message-Id: <1-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0135.namprd02.prod.outlook.com
 (2603:10b6:208:35::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3f03e6-94d1-471b-1213-08db0dec8465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s84Nvp4f75QyEpn2ZYz0LNdIBVZO6E4gR+6Heh2vqeUYWxbqwD3k3E9Ob6xXwDK/ctr2/aSvlXIrPI5zTEdgX4+6CbEazypaNkM8KylVhU+WWWaNlVMnYwDiOUR5Nhkztz10vI/f9gY3nHd2/ptXM9XaShZlwVEKzAb85d8csZh5FbJ7QnzfUq9wCYmo8PM/tvtqm7nsZ42twbIrNpQktz+4XhsB4u4hvTHOtlvOVQZYlpvTtpf4dNPJX8Sek7+cFDcJ3tGRKZM4+KcXhMIO23c2aigNuq5Sl4PmOQKvkFA0+GTRSGu8mi6qXhlP+3Z9MULHo+qlhpF+3sZMJ9f95RumnO1Zgo7BLaY+xGVBmcB9d6EDLUmPvoCgXcr8xuJC5OZ7TZusQfmdXjEkkQvHqFh8cDQlDUYrUKsOZox7BGY1RbjEBXpTDDZ0JeYCN6KPGPOHLmvR0ku9bISlWx1J787oNQ0WS5egjhCi6nFoynpUsOhIO40vPB0jLq4h6dKif2iH8uioNsEaJcqugXgfMKpRABpbppPJmh1/qJL9oZGnXt0GOomRVR6LqTM+j9T4TaRlG7pb+7iNO6HX7QDKEBzqOnbGiCeNeQeKbRCtC5KsxaaW7ZM3i2uHHsxo9M2kG1pNpQX0RppvbY9TsNLS439AhYdKh+HfwQGpWoSJgZLWmz5LsfRNhF8jBZKQlR1O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199018)(5660300002)(36756003)(2906002)(38100700002)(6486002)(86362001)(478600001)(186003)(26005)(6512007)(316002)(66556008)(8676002)(2616005)(6916009)(66476007)(6506007)(4326008)(6666004)(54906003)(66946007)(83380400001)(8936002)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P180YTk/hqNl9FKb0bbD/8tnB+79EP6jYlodFsC0ud/A2Y1yjo/Thm9/hr74?=
 =?us-ascii?Q?dcKYcLXP/J1OnqQj5jb6uURt7k/TG0yCjvqPq39OoqolJiSna/WZdKSiQzCu?=
 =?us-ascii?Q?ITcNix7G8242YZPcjDop19bbtRqoVTxDq3GDdaiwPkKd+MkiguF/hcNrDWIK?=
 =?us-ascii?Q?1ztdJXF7KeURipCm+ZblJ7X27vPWQd5jQxYNZWPodOB2b4Yt3iN6O15Zecnz?=
 =?us-ascii?Q?Z8PN56xwertT5Ip3XOSSB3yuSGHJ5jjPdrfQsVfRc3ZQRySR7ejRc5kS4qkl?=
 =?us-ascii?Q?sQeqtv63igC85xIfeNg7ViwJHosGl2ySfepFgKSOjbzMbA/HJdXB3vS35QHm?=
 =?us-ascii?Q?PWh5SM8L2Oj9qXP2G4s4QQleOn/77zDlt5GceTSw6x919C/jMKCvRiMnQJBo?=
 =?us-ascii?Q?W59qmZEE9QAp0zQdKjlZK8cbpX61dSumwMD+IxmsNgP5wVWK1RN0QdI52q74?=
 =?us-ascii?Q?o5wfrwbDOhWExs1kyarWDcFo4yE/mefgHLn6kv4oa6l52RydfRRp5lLR8V2U?=
 =?us-ascii?Q?Qr7SfS9mJUds95VVjJcm8Wis6d3vl5jNJIcbjsPutinZdPQ+3jFA4/v0xFoy?=
 =?us-ascii?Q?wLQvpHPVW0tl968TSY2k7iviblwuipvXnZZiVcrEyOwVUUlunEsZCVjR5Sji?=
 =?us-ascii?Q?jMyoJjdbXX0FchiKOaHE0oxVyKE9ubD8OwJUWaPdc4d63pfVYpIJ6++MrC5g?=
 =?us-ascii?Q?7L/93Bz06z7Hr/xRgi45JyieHjfEJ60wrh5wlOeOMXdqUqtGrK+BdErQHUfV?=
 =?us-ascii?Q?lh9u4iZpivRLDssHEKJr/x+QDPabh64SjWJmkpkzL3TP01+zKxQgH6aB14O7?=
 =?us-ascii?Q?1YDTsNYRfVSakCGZ5JfcvI3Ck3ru317EJPuTBWQqi9ZPikC3+SqGviIvpPc+?=
 =?us-ascii?Q?vXQhwif+GKZNGdpiBtKZugxpinboaqNFCmxvVMWgn7k99e/9Kl2YxmUou4XE?=
 =?us-ascii?Q?EYLIrZwfKGN+vYRVyN8UCik9Hl/qroLqbrW3LY4e4VGfrj1c/mDm8YqotTff?=
 =?us-ascii?Q?8PgwFXKFj50msBYRaJ7V2fxWTlaX6JC3qgxfG0nfVBcR518xnJ+u1P9yUbHw?=
 =?us-ascii?Q?NflG+MihIHzL3hczfryf8WglQwbsodx2Fa+6KC7nRoWfGMVTJYXaB5cRWB5Q?=
 =?us-ascii?Q?UMZnhfsThqRez4d2M0MeQ7sQxkWpzdub/I195LfDkUSnK5Zz6TCegT0LhC+X?=
 =?us-ascii?Q?kAWPisJUC1KVAgRwRluhvcm7bIO6t9MgiHOYK9U30vhArE9HvE25TYU6s0i9?=
 =?us-ascii?Q?s50N6CNE26f8KlGjYEJ5EkjnoP0mhPFKkyyI1c1lhPMQdV8gqqo5SjbZdmIb?=
 =?us-ascii?Q?eVN2sSGTxvVrfuW8Eep0tbeuJPCY/YwO+CttFauHTtJ89+2YZNR7ERVoaruM?=
 =?us-ascii?Q?OSqvjgz/cYOfB9ZUtHR43f/sE7sOn4cznbnaTPve9rHyV0OHIpQZjGIdGeLC?=
 =?us-ascii?Q?p4+9JYNe5v1XNOmF6YnDaG+iMVDKO1Pb/yLYAyjqEHLw1fOzlMqR8mvYa/NR?=
 =?us-ascii?Q?ib9RP9txXVEdRxcwghy+7DFhl3Uoj/N+NQb+5bEWfrKk4L+H0eT1bPebo5oH?=
 =?us-ascii?Q?BANjMD4YpxaYbH8lierO1UEpYI5mkO7wqMUS52AV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3f03e6-94d1-471b-1213-08db0dec8465
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 18:02:49.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0Llw6sS42NQFcOE9LxQDxn1sxq9NvCJzrMqguQGJYiuqhQnQVkY4mh+1kvOsPwH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

The hwpt is added to the hwpt_list only during its creation, it is never
added again. This hunk is some missed leftover from rework. Adding it
twice will corrupt the linked list in some cases.

It effects HWPT specific attachment, which is something the test suite
cannot cover until we can create a legitimate struct device with a
non-system iommu "driver" (ie we need the bus removed from the iommu code)

Cc: stable@vger.kernel.org
Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for physical devices")
Reported-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 9f3b9674d72e81..a0c66f47a65ada 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -344,10 +344,6 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		rc = iommufd_device_do_attach(idev, hwpt);
 		if (rc)
 			goto out_put_pt_obj;
-
-		mutex_lock(&hwpt->ioas->mutex);
-		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
-		mutex_unlock(&hwpt->ioas->mutex);
 		break;
 	}
 	case IOMMUFD_OBJ_IOAS: {
-- 
2.39.1

