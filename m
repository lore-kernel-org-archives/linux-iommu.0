Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D81D304;
	Mon, 31 Jul 2023 17:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D067OVg3NN2lP1o5V/UMdEQqjZyt2KwAGaBA1x2FwwzzW2u6ifvvGC/+jS2CosIcLI57rxZ+dbMQWarqBiWtf84TPjQbeQ+wv16ubU/nqlDW2/jIMaEdN5XpfWveCe4EDtgEfiLKzJ9DOmpVi+jrTBqsvXdcn4sG2nVAMeeGdeoLPo03CTOiNS0xoITjoSODyhTgCAaIDGxIVbya5Z/uGkgy2MpvoyPrauTETE53yjE4qk59xEMfsg2qCdvJfi0DVpErARqnUgeRPicXQBBGgWZFHgoCfU9L4J/GDBYSqlvu0Y5L1/k1gnSzmdclZ6/3ZUqmz2XUpCBne6WqEmj/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKa3MByOgnOA1c0jfesSBHrkwAfoQyALjze5rwFRISM=;
 b=VEZBVlACZEg6RrbMLdMmKwpvbfcDZLyCfHJ1C4uywXIg4a8PonLFrVccKPhcUZU8YbBJOSF3t4b2iPXSosqMNZGp+UyrUGjaso7Hn6XPJ4UcWFY5AQpXEAfxWiaQOv0eHVp/3kTlZGw+dtTjUTtKmgKFPOp+laG127/hN6Jl/mGIcWlFVYLbSetM6xSmB0V7v8jhKKplk3pWS+zCBsxLxnyqwiRiY57o8Sfx7VKqhpgBHbtiuoOEZskZIYnD1VuBWFCZqwrluyXSmNe79uZ3+wSxehPnzSKS8zyAOwHrxMta71AJBwZmeWn0s+ITpfzEOllwpI5hV6rMzsTd2FU4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKa3MByOgnOA1c0jfesSBHrkwAfoQyALjze5rwFRISM=;
 b=hCSScOCITSYYqjtTmDx2bEb9f7vUxC9GEUWe7/wq29Tg3IoBgtAt7rk2H3KbMt8OxiOzZZ8PBNONXF7XwtgDh3V53+zfE4bzvQZX+aAhFjJ+Rg8K/lZMFNqP2zv5H+rDu0xB7QQMws8ekBZ+7uWpdAsPw0f3Orv4ykyEJBJQNge8rcuAvn2RA+ek74HRoiaRFMJDOiKx/WDcHvzjO5188UhZhI7NU5qq/QZHMsYuzqmChHpEO97H2FaEGKdTmJB94yYRMlcLV2s4xkl2Uw1UJLNUCHoOxqa6Sj8lZc4D//r1Tr0hh9L5misx/4+mlnw6Q6xl+L1ZlsMaPE48N8DPnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:50:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 17:50:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 10/10] iommu/intel: Fix missing locking for show_device_domain_translation()
Date: Mon, 31 Jul 2023 14:50:33 -0300
Message-ID: <10-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a507935-0d8a-4089-2a53-08db91eea598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LhQxRzi65hIWPPtNuK2W1+s22HZfTlnnKxUzi5IEQXybEOtBYEht8cm78PSzd8aEI8HRprZYJkiRIAvhFWBPhdRByPlDALufle/O3sTq+I15zALfCaLMC1NvvIifVuDAeVPDpYfQWfiQcyj8i/xklgFlkQmk4DFmRW2G2AWeQz32ACRiLuUV4ZarO5i/dejXl5QKC+qjCOldFG6HUlhfrGdlNf7mTlk7tchPEJ1QeKXDcvz+GZOezM4NChKmBevqXHsfwcfFQhwlfaI7oOYL/EEBnIi8MiG762kPUQSsoKT0aRrwHsGI5d/AmbYOGdkEkL5iTGBYg166qNT4Fsk8nuOV5owPcgjjuUlrjjEUq0vCQ5ss4s8pUmfd4Ow1HK12R7om6oeNk+2BcjdaBftT+neQr+bXogwC6hUjcT0ne7Uojmcoqqf/GmxjnCX3Xj0euUUPMHvbajC78ZxBhXNQrX9l3zvIgci2ZmVY8J+3mb+LLwIKrvQ064bryCckgYbpVGS8RE43AGBqCcJpreDS9wuywkddA9GVo8p4NL+WXQlgG1Ac86jQmXePSC7iTaSaOGN/ewDNmOkGjqUKUeMVEVExs/r3VSXufyx3XSwpnxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(478600001)(38100700002)(921005)(86362001)(6512007)(36756003)(6486002)(6666004)(2616005)(186003)(8676002)(26005)(8936002)(6506007)(5660300002)(4326008)(2906002)(66476007)(66946007)(66556008)(41300700001)(54906003)(110136005)(316002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TAVJVBqZ9xTteSkQo007z0t3y6qIHhjXbtIAxmVIwKQaQsY+ApwcQY0NqfBd?=
 =?us-ascii?Q?ekQJyAPm19f0BCgX5i277GMQgYr8AIPA75o7uR59ahdqwPhX6JuucVWmjhi2?=
 =?us-ascii?Q?ZhiFXeorrrP9kzUpvvZxfw42pCzN3V7cnYKBuJxwrw3oq9zEF5DMsZd6pgnh?=
 =?us-ascii?Q?GTxEicFf+406dcBYJ/yhHVgs7ygr19eAKa4bXLaG3AZTYl5f/Jim1FE2GFHP?=
 =?us-ascii?Q?GVcFpAbnJYLVrt3+TEPq3z45pUJX2wScANDgMo1s6TP7TANsojegdFa3wfD+?=
 =?us-ascii?Q?TPMKp77HkRjc5NZTOp5iegEZG0jL+i8zKJ7e63Z3Qzyv6HTmKRSguB1buozz?=
 =?us-ascii?Q?faA0HyEuke2xdGJVxpp3DNS9a32aJaN6DJ3j9KtJV9M2vC4oyHEtJb+EbbKr?=
 =?us-ascii?Q?BaJhSJjeO2dc3NFFo1rRdaRkSXd9haoUyGbum69wQdQInPg9abtp8qnYOurF?=
 =?us-ascii?Q?f26kmlB2ko1z/KoDq2GRLKdOgevuOdcUk+yXneJuLS7KkFejKM5fL2bmg3Oy?=
 =?us-ascii?Q?HQdBTAKinlZL3PWPObHURSyUBMm7eDGy1MXrEoCAesIDY/WNNixZhQxIEzzE?=
 =?us-ascii?Q?MBWVWJZf6ZfHkJpEQyVfSm/AA+SllCdOGXyKN5Y5L7vmP5IjqKfdcrvjkvRB?=
 =?us-ascii?Q?QqQohxFg1Owp3nGujz8OOB4G3bqjjxwcCvYmgmil+OwfWh/drPspAyWbAFZQ?=
 =?us-ascii?Q?SnnSPIBfEqfn7U4oytngyzdghKDWPYW4P/R8ad/71hPcMEtI7x/6dL/izSeP?=
 =?us-ascii?Q?Pa7U+1ih4Med6PpHy17RowSOLbDlf/b4ErO57pvMNxEtVopiGb/CWN/l5nmC?=
 =?us-ascii?Q?Tmmu6hlgNZzZxC6znwvq0fSIqmLleySjG9PP6uB1SvEDA3Ltr0GH0bYA0aKg?=
 =?us-ascii?Q?h4mWBU6LwrZiItOZ97pxNOI1wtOjseWIKzR80wni2WbaevI9mRHDJN4ZggPH?=
 =?us-ascii?Q?FYqJ+vkmSsKfGzwPMFFeUIxkNBbtqhmQDVebT4CCGDlnvIYkk/HCNZCzS9k0?=
 =?us-ascii?Q?4/PVJ28mMx3y7xYEcTC6b6Yd1omSzXek+l2iVlU1gy9ARMrTR8xeHhJDykW6?=
 =?us-ascii?Q?Y/HGCxWNSLGq+hRwb5x99X/L6hw0KWonUHU+IzwGCtd/g+ksZpJZ7OOqmmwN?=
 =?us-ascii?Q?d5MsBLJIhPncB5Y09ugBlKYezJhhfNdoEsPxaRAKzM1b1yIf2LNqsRM5600f?=
 =?us-ascii?Q?aoFUw+8lncTsayZLoyqWdA7mh6ioIKA3PU512WQxcRQ3Au23UvozYCn8UZgL?=
 =?us-ascii?Q?asl8MVCINrJscP62rURGdQlP6YAbBHNi2zMD5wi6nQ9kUYSnsCggTIS6LJ3V?=
 =?us-ascii?Q?uc3aZhCQfDs0n+bkzmXGIR1P1FKfltlafomnk2G5IGEFMN+nl8pDAUB49tJO?=
 =?us-ascii?Q?/FIjchBFMfN7CVMajfR4ZdgnRJaWrPBmrGxecZj6YkFFmEzT2tmdeKWP4LTw?=
 =?us-ascii?Q?+oDpgWIYsZQO8TOXoJMfSmU6fbKvIOS/pc7F83dNLVLva7qlMK937J1r/xUz?=
 =?us-ascii?Q?t4fWbtwkSpzoqTP9cCPTG4n80T9lzUSRqFA2cGEHbVPuSZ/kKP+4fLlJdUO3?=
 =?us-ascii?Q?MZu2L2HzrCKaNxScT+wNVWo1mLrEHJjL9C1RK/4/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a507935-0d8a-4089-2a53-08db91eea598
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:37.1202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/Mpz9k4cCqV0NdwtIm4p+Jz9gIHI2RPus+uTBxqQeaGIPMEtoWGTaWgmp5e2gVw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320

This is called from bus_for_each_dev() and must lock the device before
calling iommu_group_get().

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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

