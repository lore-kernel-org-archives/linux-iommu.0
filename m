Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39555C2C1;
	Wed, 29 Mar 2023 23:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHwhTiM80ac6zXoWi6o2aBat4Hq9i5rZrpfsuS0t6hhEB90ct49A2oJCLytd7d7KeMHgQSypE/Udj3go3jGhc4NHXaUkqPfj/Q8fbTjabO0sNM4r9TCuAEGpQe5xtDw2SW+CeKU1uMna36Sju5tEmR5nGMVn5R8znKRn0wYseHJwkSqOQsHuq4eiXCT9mcbIAOhniRutg3kA59tia02RMPbZyhZz0uh4a+/2Ra+XrTU9L/1TnZKC1TsedcbI1c0cuUDWjhU/PXqweVf2fV9yLgxMR48ynapawOKrR/Y94TtbAj55jizaPFV64wkxjYxXQKOQIR0PzPAXoF5xDkBupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjFfCefeI6kikcoDDREglQJr3oJpOIS9PnC8JMZia+E=;
 b=bYirHgvVipDNI46rFgid3sv645rzHJ8uAXO5xUQ/jpzlIPoRllE1Q9AWkoN77S9BucNOjsB+yoEnsICtBZ07PlIDSSpgWMgIVSZsa2fPkUh2YthqpJiD5H9PWRZnry4s90vFUvz+Gm47hQE5gZ0BZX0tO/5trCHak1hWjXMm1I3iVlIXywzsqRF9h9+nVBIVOFR5K6d2Lv8YMTxWumrTzGJTB2fbDCLsvKMrUS/Sl1Rjbbdaoo+L4FzBzuEZPe+n8wOPG1+itUuYbo2e7femyksk1c8MLkk965M1luxp1dXEts+4LPMH8wC3nLIqzASMQePpSuz6oEBQx5PbcF+N2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjFfCefeI6kikcoDDREglQJr3oJpOIS9PnC8JMZia+E=;
 b=YNvrDDBiO5q4NbK0xwjyltzf5qfcwvKcv6hQyiUa0lbZ46JJW3cuRsgcjdyB8Dqof0IpkqXUqFv1QBiLeUgqg+CQUrE51zMoPb784miXsTTP/xttJIz5CYc5NG4NPlle40XM6+K1XNbFGmH9NFhyuJh3l1K0kwCuVZv8FGw8zMtOt+KUxZ7giEwgfygcvTGMQTfcom9FVb1nuBCGJZv/jBO/MeX4SCNa6j+CJFMMiJcgYCXJ1qRtKqfzQI9QoL3TLfUpXHcmZWqJl633dL24F0cJzfo3MKxsXpqXuuYW3PL5boevOgHLRK3Ko0oxm+tkPHbbghlmusJpvn+C2SVJ3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 07/14] iommu: Make iommu_group_do_dma_first_attach() simpler
Date: Wed, 29 Mar 2023 20:40:31 -0300
Message-Id: <7-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:208:2be::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: a5bef8ef-c8cf-4bf9-9ea5-08db30af0154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PSmvs3Jf6iiH+NXWBuMvwN8nO80OM7Wz58b9m8S6V2pv7LsWmblczoYp5CGNsfPBnKr3w2mUmBsZ0ASYv8HL6ZBq2H+4S5zTp/qxoc7zhgwKQUOUcW4pVO1QTuF3NmNVK73QRiX2djfGcXCtgn4X047iLbizvWA/LoFMZ1zzR4HzuirMhcbWoRfG3b79eCOETky4yHuezzKtCeOLKLZFlxFnTR6tQJsMXKkxv3LQDQkzvAj8JpVVmyTI3W4GCtncxS3hfh4+RA3QFjO0XIo6v9UGlF8lwoOJ3C4hr0XQ/gDwBKU9HtDBKo8Mvk2cd1JUAPpkGkeYFEsTtyTJOyItlPAV9aWjfFngTjSqo3v9GrgL9mfG2weBIfUx6wz6L2C0PXJbTklLRl/vdGdu3692mKSgLiQ4hkK2vUs53f8J3Bd6+cFPX4FU3qsyvbekvb7bfIQBeXX4JB5veyy+SHShqY3DUCxZYdP4E0PhGugTLA4nTHNRm8m/Y2RNFI4uX5rVDy81Mq9sCeGcfOeYVmrFHTsVMuMn5GpZblXs8wBGcdLoQ5AQFV4YOfzYqqEcuCOKkWStDe+47V8cu2LA7TTYLajcPZBn5ZpIwIuKYIG/QTI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4V3gvSXF1/ZfKEca+pmCq7mDwtBb+Z1biiBMA1NMmnCaC21OHmrCZL+8kOX6?=
 =?us-ascii?Q?ww8mySiRN/yHVlqpKU7TTi769oPSwv+7geWe+cWW1O3vHjo3JCzImJX7IZg5?=
 =?us-ascii?Q?5rVZNxLz/RmwvIELZmjCkHOenlCeLgTs+ccCYBJm++C75Yqbg7z2rDb0xdQw?=
 =?us-ascii?Q?aIzHbb0AOyhJEl5dIuUqTbY3pZVDyfGCy+VogqpZ6F+SLtTqqcEV4EKEImq1?=
 =?us-ascii?Q?jqCaCaf7UgE+7zSUj4aupzwEJhi+COIsHMUvxEC3CnhgZ+N04H6IGUwUJqp6?=
 =?us-ascii?Q?PppB1KaROlm34et8ON28oYEddmgOFPiAVbMLtXCw9QVrszYAEgqwYy/+AuMz?=
 =?us-ascii?Q?QO9OWJzIMUdvqxOlmxnE3LXF374g9hxzZncZHGdAXov+SG0nw4kmk5lyfa2B?=
 =?us-ascii?Q?tZrlrM62P8O9gjgX3iGzqzh+WnnYrQlCcQ+D1U02/CwV7mmfWqvrTTSiMmUg?=
 =?us-ascii?Q?pLfY+SRQwnRYJEDEbUwjkRJziBxRAVYu9FSV8kK8smJVXcmCSaPNRXSHSw90?=
 =?us-ascii?Q?KaNefHGUzpgwaeg3oRQeuECi5hDgvySGktP1XnE5b4sv7I3bA+4X+Zk/brg2?=
 =?us-ascii?Q?TlYZC2RCTHWMIIjFQuClq0j2Mfq4kcIYHG4vY0+6n0zX3WBiWh02N4wY4GBg?=
 =?us-ascii?Q?k4SKOsS8db9bFHgFbsg/c9tAFnu0m2Wj9AbJoQoenH/n7txZBaXqJiXbdZ+3?=
 =?us-ascii?Q?vrdLb4ii3//FIbPdNl4EKFdxAH42/FWM0zOTaF/Lfy8cx1Jyrc7t4uJsZhJs?=
 =?us-ascii?Q?dmdAsoJSaXMmag2LNTDjb+m60oXpy/lz3xooKvv4firSqX/QF6V84RT65qhw?=
 =?us-ascii?Q?SbNhn1vF03J7E2yrCyXDk6ncbIN4sS8dIK5NnpNPw7uARXU5ni4Cp1rqNluG?=
 =?us-ascii?Q?BQjZs6EMADJDhFvTQkYU2NqQaJoDP6f23lGE0wiX991MihQF3BmpcIf1kByv?=
 =?us-ascii?Q?Jonq5OQ2VULndlYIR9U0D2cZ32X2IqQGvct1e+42BQ+LwDIU3Pqp6uLYWVmz?=
 =?us-ascii?Q?hiyCdgfDjF/PTJuQa1DygX0vyjbXNc4NSQmeN/9j/m6VlFIIZ6K7g3CwR/fa?=
 =?us-ascii?Q?tHBrdSAqUE2iKDQs4wrlvCYNLvCI++OBKzUjSG9PGl/skx0RXIdIHicjlogE?=
 =?us-ascii?Q?Cq7y/UB0UhpHEJsZuVL6tJxqLVxo6xBheBiC5jtKLni0GgLXrHzk61VngjHR?=
 =?us-ascii?Q?6uGoF7Ak5tWYbVmPIyFJ/2o3B4Ui8hxzY3jSjnMiJqdcS5SoZh3Pzau2yQ6/?=
 =?us-ascii?Q?dknbWle47GJ9JBoQh5tmPVlPTGh3dqTsQLowI4hTCtDy23Zc2ycTjWIwG8C6?=
 =?us-ascii?Q?dv6lonmd8NRwOM5Gw/tvS1WD89mkYdNsNP8krj0kgf3A77Ku3SuqiMw7MYEp?=
 =?us-ascii?Q?8/5+uABQTSkGUgMC4bKZLhTmTZX+3Gmns0bhbkNtpG+wGMsKyDQVhH9NmSKs?=
 =?us-ascii?Q?SrIuaZe0BxHT6TwT8MSso9EUaHXMWNf6lAKJL1twbvcxcky4wtVPsweMVb9H?=
 =?us-ascii?Q?wXyQbA8gXBKHMtRnbq6P27bcX2DVLsGa+dxSrb8kV8gScr/w/NOR2liknG2Y?=
 =?us-ascii?Q?Oiu9OTJwnFoMn+o49oLANd6926ofIwJj+EsDi17B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bef8ef-c8cf-4bf9-9ea5-08db30af0154
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:40.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnCS6jFOdlwoKZ+8sa9H5rSrZfoFV3O34FWkMfCR9HECqtBD5SbOKQFl2Yolle9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

It should always attach to the current group->domain, so don't take in a
domain parameter. Use the __iommu_device_set_domain() common code to
handle the attach.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index af3af752c255e4..c68cf551d05dc4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -105,6 +105,10 @@ enum {
 	IOMMU_SET_DOMAIN_WITH_DEFERRED = 1 << 1,
 };
 
+static int __iommu_device_set_domain(struct iommu_group *group,
+				     struct device *dev,
+				     struct iommu_domain *new_domain,
+				     unsigned int flags);
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
 					     struct iommu_domain *new_domain,
 					     unsigned int flags);
@@ -405,18 +409,10 @@ static bool iommu_is_attach_deferred(struct device *dev)
 	return false;
 }
 
-static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
+static int iommu_group_do_dma_first_attach(struct iommu_group *group, struct device *dev)
 {
-	struct iommu_domain *domain = data;
-
-	lockdep_assert_held(&dev->iommu_group->mutex);
-
-	if (iommu_is_attach_deferred(dev)) {
-		dev->iommu->attach_deferred = 1;
-		return 0;
-	}
-
-	return __iommu_attach_device(domain, dev);
+	return __iommu_device_set_domain(group, dev, group->domain,
+					 IOMMU_SET_DOMAIN_WITH_DEFERRED);
 }
 
 int iommu_probe_device(struct device *dev)
@@ -449,7 +445,7 @@ int iommu_probe_device(struct device *dev)
 	 * attach the default domain.
 	 */
 	if (group->default_domain && !group->owner) {
-		ret = iommu_group_do_dma_first_attach(dev, group->default_domain);
+		ret = iommu_group_do_dma_first_attach(group, dev);
 		if (ret) {
 			mutex_unlock(&group->mutex);
 			iommu_group_put(group);
@@ -1117,7 +1113,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain)
-		ret = iommu_group_do_dma_first_attach(dev, group->domain);
+		ret = iommu_group_do_dma_first_attach(group, dev);
 	mutex_unlock(&group->mutex);
 	if (ret)
 		goto err_put_group;
-- 
2.40.0

