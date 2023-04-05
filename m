Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD7322A;
	Wed,  5 Apr 2023 23:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewd41Y2jeUi0Vru/TdZ4i+UFXhZ9jFB9+5SpIEyoQaNBIh7U8QKGBKX0O/xBi3KcdruQ6LiyTPzUbQ3tfImR2VdKtCAoZXVi2IWFnw/ISX3PIe/ZVHSyZpmFiWoQ2S0V6bAdGJju2BNQguKf1KlE0OEJQ4iM5oBtijpaCty7tKwppL7KaNElb0PDMJaGdPbqvyNXUdPmpfEYyG9MuAszZBa9eFdqR3rSvooSX+pbBBag3GIYWArS53b2tM9Ti0zYXsdy3tx+OSMCjDA99RoVRaWs47yBFr1Q+WfH778e3YQY4QSCcEQ3tU1QiGPwWWOWoVqCUfXrNY1zfpHFUWXwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IegeaZoz9Sl3ocFzaKyz1lY0m/C+y4I3fCMBOXywjHw=;
 b=AqIvaINvS1ONNHxkscvDEc/uCWACpPjtI0ItqffFup1gbn+NUceK6U/Ey2F5joV5Feye6un9aEu/RUEDlZMS7GkOsIEEovn0ZywbGla46DP8DIi06CTX2QJNKGiBQLJwFcC5m2JqWv+EpDWN4f1rAkW1p8rIu0/5Z67V+qcPAZ7/pPjSlWp/yQw830wqxnRzoNIhOTvm9aFH54IGiFUjq4+nWmJDREi89VGSshwT4Upeg6ZvCmkNoC6FVSwr6uMLNfln6qMTlgB8ob7GLO4Sx6b3QyVi83eou79fvhW7InBisuR/yhu+FmBdkNZGPOFNaFDA1KzYTdzUU2vFbcKgFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IegeaZoz9Sl3ocFzaKyz1lY0m/C+y4I3fCMBOXywjHw=;
 b=lQ5lzEhbz8pec69I/kgBFrYUVdzNJgZX7p11n9QvoJUTFbJjn71kZn2gjQLJP5KWibcMy+JIynLQHtRKcOYfC00ICVyNc7cODCK7CZsHH6Xu/+Q5LI/SJ87wCHiNDBvM+GFv1Nkj2bId9sCc3dfZDb2STyqSlHfb17+Deq0MZyF9UrMrPFN7KwL9P7tdE222g+5gLWuuQZ5bGBA7JhYsakZ6NiUBDXOHXUnLpI2fNIwkAhhltAtwEs/mY305i31h9dmhDiMnQ9Go9mHyv4vwd1PQFJ2EADJLpyqG+FnbalVU596WNMOseVRM4ZWohbuOebe9hAgDexfxmU5PNfg2SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:47 +0000
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
Subject: [PATCH v3 16/17] iommu: Remove __iommu_group_for_each_dev()
Date: Wed,  5 Apr 2023 20:38:37 -0300
Message-Id: <16-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:208:d4::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: d17dd77e-85a6-4022-65d5-08db362ee3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xRXNeo2d62pjaWHlDvUXIpRlnARKmGFpPy5+wt1XcgH2F3Qkr4zWV3/Xt0L3ZNLu56aBQcgiuJgW9CLwegSLRR0iQIwcW121RGOipRd8AkcGfQFXCbScK/yMkR9/eHhqXaz1YQymeMs4qT6cRtA7a1vqppi4iUSQUdoBA7Vt0I7Q7CdfLTIAy39AtbcuY7YbUVIX5VNBX8xof7SWAPcVru4FS1WFS117tntGeuV17XNzkZNPrlKZy8f8gIm1aoTrRNZNbaIRNxM3y0jBHJ6FUhn412M+NJQM/ZtYU1Bp+21Q4rqhbrJ9RDJ0yYKth/FRa5fzXFWYr0X1mEOGHlLQXuMetUGYVtqOa1vC8kKKY64NaMjKWwGFy8v/pItAA5mX1H5cLfJtsdo7g1Wx7GFTZVUU2T329tyr2EZnU82RyEgRysL71MgfuTRU4s0aICQOoCArILJnHkFjc4AEoP9ZbD+aPFAR0poGfniZlBeQJjN1dL4AaSCR8MXPZbK2z62t4JCjolDSg+7KNcxFqStjNQmfuAdY0RsFoI28Ybax7PXVTs81Pb+faNg7UbHbLEF6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qt92QIgcns4zd681IVdVpAhnMvwvhkSZNYBruRDWtWe13DIEfyj+LebQhgw1?=
 =?us-ascii?Q?AbViNl9wDE91GDjErINXZOZGYbuRfkIIKTeLoDY0qxkoEdyq46tKKfRLsUYm?=
 =?us-ascii?Q?Cbba5f/dYZdT0XACAFe0VrB0TvhpF/qLaw1x3wVVhdrAgI0h3Hl3GsRpw1lg?=
 =?us-ascii?Q?D60a5IykhT1uHTdAnjgXAycaG36gvZTeFyQEj8ryVL4RFNRzwoJfq4v9FX6h?=
 =?us-ascii?Q?ApknQ3Z5h4+//A4Yn0NSHPqi8ZhfSEfT/IjFTf7Yvid/mS8+l7zPygt9xMjq?=
 =?us-ascii?Q?X7XsmYI8MgS+l1ntUOtSUOX7M0hQkwWHpAkVL2W8hbE26/bbtF8C6Bu/qdij?=
 =?us-ascii?Q?QEsZgC0yRcJ/03VJOpkH77bi6uGKhJEQ65kBhbNelvOxZhGrv76JYwgxYB2y?=
 =?us-ascii?Q?NU91uY3KqiAH9TrbBwweBeY4GUHpTUA7KBFfh6IB6LWdvdmPIQRGMMp/B7qP?=
 =?us-ascii?Q?c1jJsUZOOixjF8MM8odCWoGJTJAB2Yo1ubUX/q82E6fvEgGdmpzEQPdflpXF?=
 =?us-ascii?Q?1795yBm6x6iTVbtA+GP8shLD5ji7GWRfRtRtP0lDQqse8xHXRjU4F5vx/Ke+?=
 =?us-ascii?Q?A75EbvoPFoY0Sp+tGE04Bwg6IutOC81FOr78Vkv/gWA9itMJ01Noxg2i8npT?=
 =?us-ascii?Q?08R5xk5vYUqZ/Xc9//lGub1yUQVotctDq69stDTX5cDbRCaaRc4jGc15CV08?=
 =?us-ascii?Q?U3bovcOPjBdbmxUmI0bcsE4nCr2n/CJi6WXAqOM5ZY7e6AnXNZconPfYGlTj?=
 =?us-ascii?Q?I5jxfuwnyZuWY5sNKmAl5HjpIHVKcBMnm8Prty/kzjASu6VaIAjpvS3lWgAi?=
 =?us-ascii?Q?5Ir4b6myuddFAif7jFIn2+UzCrz8Q7VkGjQQqyLOggW1nfGycmYdfPFqRlIw?=
 =?us-ascii?Q?2XIyJcyMwoxN8qyrkG4HL43sKpPwJUReK3wOsQUo1t9zxEMY2YmsQxjvny0L?=
 =?us-ascii?Q?aJShNRh0jqcnrBJzZcS8bYA8KMhon9oaHKWczIU8sAgEUrO35mPGprqT2L2i?=
 =?us-ascii?Q?AtecR+TxozX8STw7hCjk9a+kyePLnsy54Z1iZP+ItFd1jXclOVaRnPpNzPhY?=
 =?us-ascii?Q?4gUESwlYHKzQP/dRK9nVZjAwPNSq9bzXuhBmM8/L8bmx5F3Wfbl83OlfYaKj?=
 =?us-ascii?Q?Iv42J3jgJJsI0s8FDq2hzXtGqiPOkMoX9Ngome44jesvNi7+mwF0wgKmNgYf?=
 =?us-ascii?Q?3OCRlMxKXwdE8oZHqM/7f3vI0T/wMfEO5oHqDcEmLuj3mGFifAIKt6zAYz1p?=
 =?us-ascii?Q?v9JRaAZDUnkOUurXwDoKNDo1aV5cPq03HUwuEgdoM6qiUsXfQIJjT5Xh67ou?=
 =?us-ascii?Q?sCPneev4Odg5wapEGFOs7A4h9oXTgyNh1yN7ploIxVnF3tWGZhOOV42M76vN?=
 =?us-ascii?Q?0etiWjpr+BXiH98yh3uxL+2GXhK/IVylj+MmsoBZL6sXs7PY9GcmLJr0W7RH?=
 =?us-ascii?Q?zqQhxOFDec1CiqQ0B2oShDBPbdDv7sV5fT326fm8soK5qKI2OuQbpkC5Cxvp?=
 =?us-ascii?Q?qTt0IPI3nY6bYcuGGEhAGouYl5ptL+sWQjiH3D8rCASY9Tr+UNvxLEKlatcF?=
 =?us-ascii?Q?PRBxyqpjQXMIItE2rw7Qhl+hAVOUZ8fsr9TG/A4S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17dd77e-85a6-4022-65d5-08db362ee3b2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:42.0944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kERQvOwZCj0OwlK36FOiyM9aSYyhryqX/4GYQXq8lApcYWYB/IE96bObapujCUqc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

The last two users of it are quite trivial, just open code the one line
loop.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 53 ++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0aa837b31cdfd..cfacd99df78a05 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1160,20 +1160,6 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
-				      int (*fn)(struct device *, void *))
-{
-	struct group_device *device;
-	int ret = 0;
-
-	for_each_group_device(group, device) {
-		ret = fn(device->dev, data);
-		if (ret)
-			break;
-	}
-	return ret;
-}
-
 /**
  * iommu_group_for_each_dev - iterate over each device in the group
  * @group: the group
@@ -1188,10 +1174,15 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 			     int (*fn)(struct device *, void *))
 {
-	int ret;
+	struct group_device *device;
+	int ret = 0;
 
 	mutex_lock(&group->mutex);
-	ret = __iommu_group_for_each_dev(group, data, fn);
+	for_each_group_device(group, device) {
+		ret = fn(device->dev, data);
+		if (ret)
+			break;
+	}
 	mutex_unlock(&group->mutex);
 
 	return ret;
@@ -1841,20 +1832,12 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 	return best_type;
 }
 
-static int iommu_group_do_probe_finalize(struct device *dev, void *data)
+static void iommu_group_do_probe_finalize(struct device *dev)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
-
-	return 0;
-}
-
-static void __iommu_group_dma_finalize(struct iommu_group *group)
-{
-	__iommu_group_for_each_dev(group, group->default_domain,
-				   iommu_group_do_probe_finalize);
 }
 
 int bus_iommu_probe(struct bus_type *bus)
@@ -1873,6 +1856,8 @@ int bus_iommu_probe(struct bus_type *bus)
 		return ret;
 
 	list_for_each_entry_safe(group, next, &group_list, entry) {
+		struct group_device *gdev;
+
 		mutex_lock(&group->mutex);
 
 		/* Remove item from the list */
@@ -1884,7 +1869,15 @@ int bus_iommu_probe(struct bus_type *bus)
 			return ret;
 		}
 		mutex_unlock(&group->mutex);
-		__iommu_group_dma_finalize(group);
+
+		/*
+		 * Mis-locked because the ops->probe_finalize() call-back of
+		 * some IOMMU drivers calls arm_iommu_attach_device() which
+		 * in-turn might call back into IOMMU core code, where it tries
+		 * to take group->mutex, resulting in a deadlock.
+		 */
+		for_each_group_device(group, gdev)
+			iommu_group_do_probe_finalize(gdev->dev);
 	}
 
 	return 0;
@@ -3020,8 +3013,12 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	mutex_unlock(&group->mutex);
 
 	/* Make sure dma_ops is appropriatley set */
-	if (!ret)
-		__iommu_group_dma_finalize(group);
+	if (!ret) {
+		struct group_device *gdev;
+
+		for_each_group_device(group, gdev)
+			iommu_group_do_probe_finalize(gdev->dev);
+	}
 
 	return ret ?: count;
 }
-- 
2.40.0

