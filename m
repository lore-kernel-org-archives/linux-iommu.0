Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F4568B
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 14:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMISFKDG9dR4aW5c2+2RWomBlV0xBhjZ6Ee2cdzLXLPoYjf7VMacYG/WEayHI/rw3+YlgMXUuYjXx1Z/fZ8cc4CacY9bVj/2qA6bOH0F2QXLr3KOEDU3D0YRnmuxjoD++QZrSL8Y87opYFy1wr3JXgvu/m9dDcec7BXwmiU1SvAkb+CQsD8CHGM9wCNqDJETzrgWAWr9FA2qEX04TgVYusDnlQNCpbCLaHhC1vQEP3VcHqlsfxYjB99y/XDwKdSsWM0IgZB1+4k0odMFpby+mEq8lYcYZOrPQBIY/9nDnevKrHkNK/yfBn6xrTI2hR4KYW9ltMkB1/WuGal56Hq1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nE9+iagLiFkmydOTM/TcCswD7MFhMK8bB4HpLHTdmh0=;
 b=MqWI62i2UvXFIk9iAl87+X/ADdsK8t8eYUw+TXHgiut2hZL9L1SLpkc/wftygodWrhL4ybrXBBsqOeiuACzwj11FxDrjdFjbWbmUFDFBBuN/v2tWeRaXB2vNoe82J4jwm1QrIj59QjoKqP0QAfxPMmc+qSqIjxE1aUYcLnEd/oT3KjKDfgNqsrEDxxPd9NelP4+2n/leiCapk0i7cwBx0uEMsmf1l9RCRCa/9lrVgjRDFkSque67IiKgkBPSIn81oKFOwu0rb8pyEfqEDkQ5mguiZhlAxrT3ZXnI6KkB8utR6QVImKsZdd0LeFWGwS3NZAvkT83TxFmUXZypMFJo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE9+iagLiFkmydOTM/TcCswD7MFhMK8bB4HpLHTdmh0=;
 b=PlyI/8UI2q0MlSO4044Haiby4lgQaqdONDWphP+u2uL6vwE4vFOATOJ0R/5hism/Bse72JABl+eUmV4TzAuZqCqET81YyEr6lbSHTjb8t1sWpKaOMAM3pkMnDy1DdVL0GH3JZENreK85UKHK+ovjwyinJKwvbsj9vX4AnR835ePvtyuuxqOUiRc6I6q+U5u6/ZuDKDD9G1fVz+ehozRrUwD1nk6QYlKJmd9SjuT1qxE4Aoapbaxt7ZQAGNqYR8UgcSF5d6ni05z2DLcLL4Hy887skr+tFMzMMW0c316OUDzxQgoz4iSdMknIc8qeXQ3VlemwzSUzFeWl3N6ZWBIpCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 14:10:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 14:10:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] iommu: Make iommu_release_device() static
Date: Wed, 12 Apr 2023 11:10:45 -0300
Message-Id: <0-v1-c3da18124d2d+56-rm_iommu_release_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fce275-32a9-41d4-0c52-08db3b5fb6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gmYJbgT6bnNzYILpztOuEnEnGh0kMQAgH0vIOCFaQv5sBDo6Jokv/6qs6TVCvu5KjvMh21N2kVFpAvlfP7cT7PgxiFvcD/tTZ9Og7rKEJShWAgIhfR5VU+azMyuh6xMvsrDRS84cISMUBcpbOtf+vHQhGrJfAcnA0ELyqmBw1IxMOP4jOk156D9miNimMZg/bHAxdM0V32VyHAGgI6A43ZvC3Xd/e03JEhRrQZ5W3j+Bf0CELXYiwK/w6wv48+qJWZs4kfjhR0DP4b3F0nwHmh+BhpYQJ4lebEDDcfmQ77m8LjtvQDLmhaKGrw13vkda1DLBiiMjXfXmf/QClEpAyeOA1E4pMXwzpYQ8UxQ7SODZIZcmbTlZY1VsZIuUuGVOkLjn7FAygGL1HRJeYam9o9/fMYPduuZT/LNU40wowwHAOZcycGYfTl8a6n4RwY4uyymBz+hFbkgvgtjnZ3XKN+A68VYYPN6TQ0Mme+1UBiDd3AnarJdQtMT0EXq3dkJge6LYvxf5iDbBVVGBETYqbDjJifs0qSKWB/A2vWssyjiEul3sz/eHtDU8As3C12jZQeJdHB2YfPkbmmZ3or8vGzfxHMYoHtIscfywVCKQXCk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(83380400001)(2616005)(186003)(478600001)(6486002)(26005)(6666004)(6506007)(6512007)(110136005)(2906002)(5660300002)(38100700002)(8936002)(66556008)(41300700001)(8676002)(66476007)(66946007)(316002)(36756003)(86362001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ewoWkpzx9SSzyatMFOzlroSq2uwnpbC2W/6SAEir8W5jYtKZfNMLTbN+zVRl?=
 =?us-ascii?Q?HRrwFoc8jBrURC/SWB76ie6LQ8QTd1gfa/Fd3MvNFB2BhjpIniX3t2TFtzX3?=
 =?us-ascii?Q?CLFj+qZG9X0mJ1T/ZCYIBhmeI9u2+XMIkgXBRHPzfgeNdQkfCGOF0x6PQXzl?=
 =?us-ascii?Q?v7q44vm82+/pX3f/jBWJycJL+1er+Z0WGlssI3WxuoMOs8IBUBVMCjAmf9n5?=
 =?us-ascii?Q?bUoltXm7fakrMSsPJoOui3RNbx/THJ6RcuylLh1RVREYlp/zBePOYzH6EDmO?=
 =?us-ascii?Q?JJ0mEsyk60AUz4cDw2QFEGGNBOBNfe0dWSQxPCLzF42riRrGkwD59CB132xu?=
 =?us-ascii?Q?p6sV2IApD0mlrx6vR3YjZa0+/0xNV2I8cpsXKKD/mmNV7vvOl95+akxkVFdT?=
 =?us-ascii?Q?Mo3pYKsrvOJ2UR8YtJQ6RWSL4FRa87ljp+5rQYq4Do65wbcoSEz5mSX9T9jt?=
 =?us-ascii?Q?3zuIIZ/54Luj+Vu4JK34PboDVGT1ldjf1qFJHPP2bfgd9NqIUuWuN+Sp1bYN?=
 =?us-ascii?Q?iyEUuN/Gtr09ejixgikIaMpYCsgqWzWSo+NAw5ZCTSP7alj+Gmn+JqHYIhIl?=
 =?us-ascii?Q?dZw4nmvRx90enYNL8ZQgUc/cRyR0qVUqzK6Vjgt43gh37f433d/SuuoQ5xsv?=
 =?us-ascii?Q?nhFMJsNMeawGWBEHY/vUIQm0IV5w3vxQN1x2LCtYHreZdCD46RsXQMBTWZD/?=
 =?us-ascii?Q?aNWe+npSJ57ZePvW14jBFYR4Spq6d1EFbRkqw27pNReCzQDO8baGQDE0bpDm?=
 =?us-ascii?Q?EtTzPzIq2yCYSfAIyWrZ43SZyyqxaEpzBrrndEo+S0Cazk/Z7BTWFDwEBy3y?=
 =?us-ascii?Q?ibtvIdxx/cuCH/xo1wk41VTd0mELjESzjjJtcicp4Lhzbc7Zlxb51Sb0HEcc?=
 =?us-ascii?Q?lyXa7cRtt2pmBErDqYBwwPVeBy5uVJvweEDHt393YiJUAQ3U61/X+5AStQy8?=
 =?us-ascii?Q?+kTlqmYW/LVum7myJpkdV6QAxm3GPa9Py15rnHFXRroe5dwzZKcGLABDlh47?=
 =?us-ascii?Q?yWioyqFZvxZAqeA5gxg7ZbpAxJFbwvaucD3ja8niE1Q6DoDiOjwSdNE8D0as?=
 =?us-ascii?Q?sedbCYkJDH9BsLhzBaHG8ya0Fb/PbhNvlHWG4OI3v2nPN/go7ra1Nx5UB2e8?=
 =?us-ascii?Q?ugUEZBQ4yE46DkHvA4JfHhBKkO85JWkkaCHOh+HBoWE/ysXWRBPxrlApBGtI?=
 =?us-ascii?Q?rx+AvSzTs23B07YN3O3wufWfnmcoGiHDi/T5PRbefYSz/t5FJKDojiP4nJZm?=
 =?us-ascii?Q?cVy3ZAp0d4VKtt1wXZCNvkqqsjtlr3lp0OJXPg2ggg2gNz9d2glD8OBNx4s+?=
 =?us-ascii?Q?t2rT3naANiOgegDBSxYyaESrN98GqEgDwCttcLqDHx+xaOom6Kd7D3Z9bUuN?=
 =?us-ascii?Q?iBTIQWgpOMY4qvKHQLgTW1wM8wllLjDNDVd54WCST9l5H7m1PfohS+KLQMX9?=
 =?us-ascii?Q?5QoAKoeWvjPNDFNXqhUNOKIZ0jzbAbIGJ8IfrimAWSVlhsGhC9p6pURmVIac?=
 =?us-ascii?Q?Yk3TFaBK+ibSAUGnaVYfMukK7fxdClIIR1rUOvVwmfirQxslNJEk1K45StO1?=
 =?us-ascii?Q?3tThAJ93ZeNfwVp/mpUMD54tuaNnc3MKFL4VwppW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fce275-32a9-41d4-0c52-08db3b5fb6f2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 14:10:48.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORxPb25F50ykXO6/JyHhv4dNCFn0tmTgt64U/2kt35jEu7hjJg/OO9IM2G4uAK1l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646

This is not called outside the core code, and indeed cannot be called
correctly outside the bus notifier. Make it static.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 3 ++-
 include/linux/iommu.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7abee83610b6c9..435fc902df1984 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -87,6 +87,7 @@ static const char * const iommu_group_resv_type_string[] = {
 
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
+static void iommu_release_device(struct device *dev);
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
@@ -493,7 +494,7 @@ static void __iommu_group_release_device(struct iommu_group *group,
 	kobject_put(group->devices_kobj);
 }
 
-void iommu_release_device(struct device *dev)
+static void iommu_release_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54f535ff9868af..c892e06f8357ee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -699,7 +699,6 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 }
 
 int iommu_probe_device(struct device *dev);
-void iommu_release_device(struct device *dev);
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);

base-commit: 43a31380ed6e16ad08675de5e68b5e4d05cf8716
-- 
2.40.0

