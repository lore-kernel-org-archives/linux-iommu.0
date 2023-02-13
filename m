Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10004AD20
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 18:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHV1DWCQstPZn8B/kwnCiK5zWYdUzWzLaeL6/w+hsf7lySM/J4o+177/08GLIpdGb+4UqDsntceDefMFoL2WZcC2YcZ8YAm09AnHWEFlvVNdzvOdSjzDZcikSGjbbsUdgPcTDH7TU69TydHnLNdrssXLl1O5B9xzz69+kUG93ZvjHIKH+9cZubfx2ZZaBOS8fVVf3uHZOmrVVqKznURb8j1b+AsLMiV/kLchZQMljuid/wh/VPEKP791g3r0URIy0h0T6DW/EGpfRYwMLAUITHiVs9G4ibugs63HUmYDxsQXUMLlk48o2EJPS1KPkzAXgpgoIFszemW9FqNm6dnAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXZ+HNNss3KJp05R+zFw1g8gFJJsZDRyklczKTKsFa8=;
 b=fLpttjIhyepvYhkAJb7GlNdDNvd80/d9aqmJlMzX4zh8nO8A7qRnyf4SlPU0azlvDWO0amAFxSpka2Oz8Q1USKKkcUB0FtDgicPvLNyTxMt9k2wyn6nRT6oY6Atf3xqeQp2FY/uHfH1D9/22NfHKr0qEvYZ3RszRjxyc31BQVIq6eoNGsHJP3CGbSRSUn++kqIZPRVFoIR9+jwuV7dFxiK18rCStAKQclXJy4zeoDJwtJtfIPeGAmIDRWilTYtJJvlqTb1H0IZE/Bl49IirDSl6e3ykpSm0RuUDC/gIrQrxuxiZUmJuWQbnzORAghI21fyJDqsoJLSSyyU9l2btBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXZ+HNNss3KJp05R+zFw1g8gFJJsZDRyklczKTKsFa8=;
 b=S0SuFRTm/PtxvCkOTJs1PcnRvNHwo8rztIflj8UrG8FbiUF+yDJmrDOpORK1cjiNNNlRrMi5B8M0W9chqGyjwxlB8SZY07Im6Dse32w+s6QY6O3mjn7EzSeIofr1F3vidVQukDt4C09yjG5PHXnpyVviy02iUVNkWS7u7utQKuv607G8jGeivT/wmEumVNzw7y9eCFr91DAP5r0zD/kOc1NYJabn34YfEUQtmQO8a70nFHNg1fY/gieB7QUo5M98EyLXpwNqcynMQ0QQMrqCci7brwTacCcqoZa0CnkZHe2SSZ7ib/2HpcCvcq2YAwhFB4dDyrjKUEXeJkiWr+WMAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 18:02:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 18:02:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>
Cc: Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 4/4] iommufd: Simplify the lifecycle of a hwpt
Date: Mon, 13 Feb 2023 14:02:45 -0400
Message-Id: <4-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:208:23c::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 59288283-60d6-4767-356f-08db0dec8349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4LgvoUKUH8K4d7FAtGnzLnqLPvQLZfk1fpb3Dtdszh8Jb6Q3Cd6h6XFKlRr0LbFV3/tdHOIQ+HjCqB39WD+VxCYrMYCRmklC3apMCCd1wvQIeMl/LiU6wCfL3J2etMkE9ipF8QOiH6TPab872HAIf4ax/i8gW6gUUewhYIuA6u40JR4utY1SwulknvM3OolfyINArKGwK46XIDPztJXmNLr+PAdhh45PIBAhWEDCt/yVJv9crnd5+0u8ShaF823fFSBWBgHuygqi7TVyyGjMLF5fFtZn526GkJncuHkxiWcqft8oU91KJ8wmdiX0GsCngrbQF10X9g1kt/PTykSlJL1YUn9m/GKFa064T/ibuPs3Vr2ffLL60pHkMG7ntS5M5fwXGR/cV4WVsx/7wFU/Rl++i9q7Z5o6yNZPVwe5kF/LxvX/mx3pWRcfZsUrKFA+QCE2MCNE30dpuiuX3YtO4d4ke0rW6zfFMnAlmkKJe1e9csgFOuSbdKAzkiUfJUxPrAAovYbyjW8Zz6rtVCeLY6s9uC2omidBX+EOtJaIVXW7odUH/8+QL5+nnv9L8kVdZmu9J6pgTzgOHxkBA8aCNBYDR+RHB8ghde+xWYKnsV3PJ1tqIRxIn0ZFfy/3YX9D83zPSKSyj2q6rW4v91a4KeM6YlXE9smCUuLKpzy+20jnHX4uOkxJCgg4+VQOghup
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199018)(5660300002)(36756003)(2906002)(38100700002)(6486002)(86362001)(478600001)(186003)(26005)(6512007)(316002)(66556008)(8676002)(2616005)(6916009)(66476007)(6506007)(4326008)(6666004)(54906003)(66946007)(83380400001)(8936002)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qfcz+pHFnvn2UgnGacjEYD22BbQ/wQiFEh0LhXjjhd8eoIiuokSydGiqam/w?=
 =?us-ascii?Q?mFI+PDKPgd1s5y9SVGpBfIX0/vAn/LvmSRjqfH/4o75Z5Y6jzV7ZkT3hYo+e?=
 =?us-ascii?Q?08muk1/RfXvr9NZnh80IqFAAh6RyLdGzpwx0RWvZ6eL4hl1Q9Bp502n9mGS+?=
 =?us-ascii?Q?k2ZkhJTgmUjylNiVQ4K/9o/lrGchSokUSOzsX9N+OMcYT9fImuwptlj17gKs?=
 =?us-ascii?Q?v5ZOj7PIrIuu12bM2M0T+IGNfQHwTpyGXbiTKYKJ/b4tydUEsYHRF+k0ucRE?=
 =?us-ascii?Q?XESw9+TnnxHO/giRG7d0wh0uLSDr8SndBFdPSLJqbVjyiZIg5rVoyQfgP3y/?=
 =?us-ascii?Q?yZnZlidH3cWSdVGVLWB9K1pW0Ze8xQovEyH5ETA0xeHLT3FUHQWuPqIjiwUc?=
 =?us-ascii?Q?vz6W00IZyAYtOdq637E8hNcgZuGXK24at+l6eTzIXEY7oHQLhIpigslNCd60?=
 =?us-ascii?Q?m6CYXNio0ZG6cBZHlKPUyGQWkWzFdUf+Jb42UR9KRidPe4nh63MF5qzGw+zs?=
 =?us-ascii?Q?Ohcwyq9YM5qKSP8ePOHjJsCz2orPcYlRH263Nqa8HvGs2CGaL4j+bSy97BnS?=
 =?us-ascii?Q?ei+xul6Uum7UohiY+KB7VFn+iB4Cvc0fBtJn4Y53VOg3nBgWaYX1Grdug7iO?=
 =?us-ascii?Q?OpFqkNMqYMUrxQS6whB1xsygtmbZN/SF2F6J8W6XRXjcIH+jeVBKfrT9JYnc?=
 =?us-ascii?Q?4d9P6dHzD8MlNbR9NP74/zLpMPm3/5OiYdH0R/mMfrXS0S993sCmrHe6JoPq?=
 =?us-ascii?Q?sSM3GzZGNF4HNVw4C4AK2wKYF0NKWb6qPSwepfctKZHwcQHMNsPrxFtMJn2+?=
 =?us-ascii?Q?8mWbCJ40cdaGJaXP3UlcXA7o3/xNTp/JUiS8K0N0VWI7aoSYXAGJc6ZIt2C6?=
 =?us-ascii?Q?XVkn6LyDEC27fO8hu6OVD8uD4H6wA6LJkIntCBvooYeJbz05d7uO+bCbnjz3?=
 =?us-ascii?Q?U0vf82brj99v+SjDMaircyXrkzyC+Gb6KXhwne4xLzNAY7cf+efj6jyFLMbJ?=
 =?us-ascii?Q?FaTESkR6dnci7Qs5/DhPiJDpIHIkckKdSqkQD5zTYOuIZJHqSFIrG3pP352O?=
 =?us-ascii?Q?z7BZUJfpEGbxQteLIKz91X5eNqKwkpiV7JFIy1bcv5BvucJ3giCHIffvPdqe?=
 =?us-ascii?Q?jjaQWySy3FZQzO3dVmpQuMqohPBGjcsJxliWwSRB77XPpnffvlQ6+/lLmAWu?=
 =?us-ascii?Q?1M6u3wTQq2/PvZw+pZI3303n2l3xS8rSV2kXHTeD9P8DCQvTRum4dydQ6tBD?=
 =?us-ascii?Q?4VKaLtq6VtxQ8XjgsuneOXoFSpbvFaHCBFqUjn1ltNZ8evUJloHvYROA346H?=
 =?us-ascii?Q?DtcR2J1XgT+bITahgVt9kUTySv5e1ye5I7Xy2DbKyqnHR1l7H5LM2/WobvGv?=
 =?us-ascii?Q?gh94TF3jUb4ctGMXWrJzObC4TC2xyJeMcWumWKvUnuwJ6Zz7jLblrMxCBgZp?=
 =?us-ascii?Q?q5+8ko1bbWXGvHvNsrOO2wUqoxN9NXsBVc8NNf7IMnJGd0+kyL2K8CR0UK9S?=
 =?us-ascii?Q?5I7pMk+61bYb99V/71EiU9weyMP8hLcmwLY2Gzyj4Hi2bpIG0c6P/pvHjB+Q?=
 =?us-ascii?Q?miNszCHGpHjJPtmSZAVpmNnLP9gRKfS2I3LrKVnx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59288283-60d6-4767-356f-08db0dec8349
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 18:02:47.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfinFJN5ObXXT7vS7K6qSzTIHPr0wUBCX+iwMR2POF9IiCL8+0+iJoe3lfXWfNro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

The HWPT is connected to the ioas when it is finished being created and
should remain connected until it is destroyed.

Instead of trying to disconnect the HWPT manually during
iommufd_device_detach() simply use the object reference counting mechanism
and free it when the refcount reaches 0.

This means the ioas->hwpt_list can have an item with a 0 refcount during
races, a prior patch made sure this is safe.

Add a new API iommufd_hw_pagetable_finalize() to formalize this contract.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 14 ++------------
 drivers/iommu/iommufd/hw_pagetable.c    | 25 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  2 ++
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7b687d002c5c81..cc1452f9e21024 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -317,10 +317,8 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_abort;
 	}
 
-	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
-
+	iommufd_hw_pagetable_finalize(idev->ictx, hwpt);
 	mutex_unlock(&ioas->mutex);
-	iommufd_object_finalize(idev->ictx, &hwpt->obj);
 	return 0;
 
 out_abort:
@@ -398,20 +396,12 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
 
-	mutex_lock(&hwpt->ioas->mutex);
 	mutex_lock(&hwpt->devices_lock);
 	list_del(&idev->devices_item);
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		if (list_empty(&hwpt->devices)) {
-			iopt_table_remove_domain(&hwpt->ioas->iopt,
-						 hwpt->domain);
-			list_del(&hwpt->hwpt_item);
-		}
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group))
 		iommu_detach_group(hwpt->domain, idev->group);
-	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 	mutex_unlock(&hwpt->devices_lock);
-	mutex_unlock(&hwpt->ioas->mutex);
 
 	if (hwpt->auto_domain)
 		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 43d473989a0667..39c9a7d6ea3da9 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -10,9 +10,18 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_hw_pagetable *hwpt =
 		container_of(obj, struct iommufd_hw_pagetable, obj);
+	bool finalize_done;
 
 	WARN_ON(!list_empty(&hwpt->devices));
 
+	mutex_lock(&hwpt->ioas->mutex);
+	finalize_done = !list_empty(&hwpt->hwpt_item);
+	list_del(&hwpt->hwpt_item);
+	mutex_unlock(&hwpt->ioas->mutex);
+
+	if (finalize_done)
+		iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+
 	iommu_domain_free(hwpt->domain);
 	refcount_dec(&hwpt->ioas->obj.users);
 	mutex_destroy(&hwpt->devices_lock);
@@ -25,6 +34,8 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
  * @dev: Device to get an iommu_domain for
  *
  * Allocate a new iommu_domain and return it as a hw_pagetable.
+ * iommufd_hw_pagetable_finalize() must be called to successfully complete the
+ * allocation, otherwise iommufd_object_abort_and_destroy() should be called.
  */
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
@@ -55,3 +66,17 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	iommufd_object_abort(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
 }
+
+void iommufd_hw_pagetable_finalize(struct iommufd_ctx *ictx,
+				   struct iommufd_hw_pagetable *hwpt)
+{
+	lockdep_assert_held(&hwpt->ioas->mutex);
+
+	/*
+	 * Once the hwpt is on this list it can become attached through the
+	 * auto_domains mechanism so this must be called after
+	 * iopt_table_add_domain().
+	 */
+	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
+	iommufd_object_finalize(ictx, &hwpt->obj);
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9d7f71510ca1bc..2837044e8431be 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -255,6 +255,8 @@ struct iommufd_hw_pagetable {
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct device *dev);
+void iommufd_hw_pagetable_finalize(struct iommufd_ctx *ictx,
+				   struct iommufd_hw_pagetable *hwpt);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
 void iommufd_device_destroy(struct iommufd_object *obj);
-- 
2.39.1

