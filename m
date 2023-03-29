Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B207E4EA;
	Wed, 29 Mar 2023 23:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tie+vabW+iKZaJtm2ppbvOaEeNKVnlhx19285URmvIGeU51VkR+qsEbxRJgo25csV+BjjlcoQLXurGAFnEOtt/7P3VKNOb8ZnWofQmUbDl0Xu93SMLRNGb1/6LnGXqmbLrZyumXiHWI4KQOUcFclJX09ODO0NW/ffqJ21X6oEcKFu1cxQAq5b6Af3H1HiiKSR7ezJm5exQYz2ZyI8nRMdbUGreZ4wELg60t4JKBwkf0EeU/8PBMzJMvfW42UH28EmQKpGQ7EGAgQR5x6pTBGZARu2Vze6ek4TlR0iwtPEKqt39un672VOG5lQ3hWxp4FnP2ZnleR5UkLofzNCfK5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/iVAsCAwH1cS4IWst3PCC1aaoSvOoI786k0mQ9PpLQ=;
 b=fViQYodXmu+x/XxlMaHNaBHzyV/3A3Rm9gLPE/9PHzJSJB9KpoZ6WbT/ncxXaQF1KU+57dWarCv9YaXyPXfDkWc/8fXdKJRp9h4xj4osk8nmsZPcUW9t78I9ASeuDrftVoo5fP6SzGitc/1n5qu7jX+afwime1oOPFWNUwTBBu9/nLjkOkjff5eaTZ/hLmyl4oHnb3QPJAM8rw7ZJwKK68LXEDYIxqD13Qdmr8fdxGSV7djFHhWejYS4rE1N7PCVSFOzfzUcu9qQxWaXPQBdArcmwlNCX6Z/bZmJ578SBkc3AAxWBFpVzCadHc+KaTAnZNyeP31G06HWVMIwyeXztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/iVAsCAwH1cS4IWst3PCC1aaoSvOoI786k0mQ9PpLQ=;
 b=V8kYaOFskD2fVIjE9AHhQ4mUcG4j5A6d6+NCIzGGSp/dmiwx4gC67VlJ8CoAoqEDBAC+EeS2qXL/NrCYY/LkFLuPKysU164YVBN0rkQK3eUjICRYB3Z39km2sQjmXVCELQ4PZAET/7k0Pw6WRUtNYyi2s24cXhwnigh+dP8uoD4z7SwdOsr5Xd5/qdremTl/2MaxlvzYTdVPRDoobL8KSGJ0qhNnZJRxmy+ulrSYnUJDLP9tH32yGEkLzsJIQzfVGjrYInCHJbckCRv6sLObEv0fIFs/O49I4/4+ycywQK6ZqP5T9lqI2xDV+pKn/g7kguynHrjDynO4hNgFTze4Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:45 +0000
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
Subject: [PATCH v2 13/14] iommu: Remove __iommu_group_for_each_dev()
Date: Wed, 29 Mar 2023 20:40:37 -0300
Message-Id: <13-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0286.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bf87ab-4520-4d8b-b4c1-08db30af0129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	47VealhWPrN6PyMrjJ+0QGxYaNu/HGRC/ykaI7jjAWlXXXr+XuOtssQWONGYXGDnFiBxIjLMbgnKKi8m7lvKJeCKpNSAHmziI7kRM3QDB78B7Tg4fwo7PUurTjM5GY/NnkbUtfWeDZex6ddvEBsHdE8DwLn9mDBsdGiDCwsFkOSHvJpxGBTXIFXVIg3+PkAMu4sBFkVHchol2c8AQoudZ4Len1q/B75dCBJpz53Nw5RUSFlauW6rHjYNeOVvoPAO21xSOmW4FFWVpulp3N5/IzCXSwqO0DDPkR/92ZOssn9MOs3rvfv+N7Q7EErMiV8u2h3Xqd3Fv/mqNE7me5Y896f/FhE5yaAlp9r4gRhCSHGTAbelhjW5qctxXsuwp3pvmYlj4/iOhAaERtAnhjxes8GS0vBBGUJp8UaYhFtFyt7fyOY95MiNMK8SG3suwxb7seTzW549JMzcHG3wF7lW078mDFVJdYMv8cF+BbU6dJbRISHm0Uh6plnU/w8W1+Fxt9XFD1Ph6SIlsagX6HABvpZGJvVeRAsYqib7Prf3Dt96HxVNtd962isyWiV1LocH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LeR+sLEc8z6kHxavcSjZs58WOGEnw1Yw4DjX+Kj/KVqSK+kwAcpIMm2sXqqm?=
 =?us-ascii?Q?i//l3ZjIAov8nU0Q4xBctR8L3fvaNFC5zlAr8HQH6tAcOZ9GaI/uym5vTsjO?=
 =?us-ascii?Q?DcKwH8e56yttLtlAhe9MK1H2+P7G4Y/l0QAyA5eEIuvoVd+a08k3IrmhAE0u?=
 =?us-ascii?Q?0yBIsUeUp4e73WD/4ioJHwk7gemv5XLAjnB0U91GWsjZNgjjEKRpB5oZtAbF?=
 =?us-ascii?Q?yUvJNuUUc4O2nuRy2HLPy1TvSj5FNUHqJCkUXKFILuhgOednGyjh0LLJ2TAF?=
 =?us-ascii?Q?Bzjhbc+h+ZBzCPZrqoFpasTbE5WadXQHPMM6nOaryJ1ASTaPk9b+7LshmMDz?=
 =?us-ascii?Q?vCITA6u23R3QfpTIgFYLJbiFcOmS3Gf1oPz/Ts9h2vFLRF8sk7dhOA3xWAlh?=
 =?us-ascii?Q?vxlJ754dcEbukL7a/MZWD5Fuh7YNYVrYkHJ+p3zaYgWYJ3O/okPSw/So84nl?=
 =?us-ascii?Q?L9Ug2WCHKIgBPdVVpoGzO+4gvz53KcKaF/B8zWmcJLzCZElG521v9fn1vrhM?=
 =?us-ascii?Q?sw1xAHuyLDs2irazOYOYaiZpNeOUEKzHLmbB3gxM6XOqGZgAqy5V78i1IRK3?=
 =?us-ascii?Q?SK5ITNb9rfH+XOqYCSnqWp3RRbqasJrn2TThIiLGlxUAb4P7GJlqXHUTcCaA?=
 =?us-ascii?Q?fvlgO1xBduy3Jl5rgDOyg0LNReUQzQ7xeytWfJ2yoGvbX/Hdp9ExzrpjfWP0?=
 =?us-ascii?Q?/R15RhRPjVvpeSaqrJm9UoEJ5RTLdR62ldIimhWVpx0O391ofQ7l14qv8ZoU?=
 =?us-ascii?Q?AEHuY+F71gzZCOT/cWGuvWa4Ggi+u468GT4R3vByNSfP3EDtC3NJ1Yd8Ku45?=
 =?us-ascii?Q?X1fAiZd7Lc7InWfRIRDoH+919SANryvoHXU8gDUWDszEeNQYazFkekppd9gr?=
 =?us-ascii?Q?yFY+w5K6pfhdWumvIHTcAkrv1FkWLyiKuBiWP+rxyZGxwD4lQ8AIT+rOzUta?=
 =?us-ascii?Q?jSmzQxOU6gRFkNY4bSdmYSyLnWC/qpi8uqgCkzwzV7JEny/+N7JfvSXzRkOa?=
 =?us-ascii?Q?176X2j0K3c5ItgfQi+9sIqQnmK3lGiCFdils1mT/LoiDa6YFZs0u6DiOGHc/?=
 =?us-ascii?Q?qLplPJxws3yX/lngfi8o6RjW/H3I4onu7/bmOPNY+8UfbOZke8waVWvFALn+?=
 =?us-ascii?Q?P4TI4KqFYj8Ha64XzxyChZ/4/6vJaCVnTq+O2p4DB6KuVtogYui0pDChnD92?=
 =?us-ascii?Q?RYjC4qS/pe5GH2p0s5pBgroKj97LXdU5sHmftYyZjAS+zh0W+eyCX6pW+g2F?=
 =?us-ascii?Q?4mXKXwqSfEzHS8KGZUjxZ23Awmxmee3Y6rgFssQgbujuw3XxIKH46mfObq8m?=
 =?us-ascii?Q?nqvYCnMLikP9ztTiT9O1XKPAYSDRXQY69kjKb6/c2ciLR/X5mi0dueGbIjUY?=
 =?us-ascii?Q?BDP6NyhHFt8t3zL5O01alHcw1Xho0UgGUOWt9+yNitnf5SX48mhDcwT117ct?=
 =?us-ascii?Q?jeSRAl7UnjnHQdEMbaaaHIHKntID5mjWUhEDiyGpZ+2r9bvT2ZSBYW+ahqzu?=
 =?us-ascii?Q?07UhuhK8uETrKSRynrKLN9QKHrF7g5FrRbj03IMfqMvA4jA06EyiYjKoE5hX?=
 =?us-ascii?Q?EoE74sqd/gO9kGKlAottQBoCKRX1trMjlG6ym2P6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bf87ab-4520-4d8b-b4c1-08db30af0129
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:40.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIbCdH/iR0zYIBa33CXkQ1/S8+AUumKXITkexTNEndzhvhOdXUiqfbdB6FUgRp2m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

The last two users of it are quite trivial, just open code the one line
loop.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 53 ++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 26129423fa7b95..71c8198f916715 100644
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
@@ -1879,20 +1870,12 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	return ret;
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
@@ -1911,6 +1894,8 @@ int bus_iommu_probe(struct bus_type *bus)
 		return ret;
 
 	list_for_each_entry_safe(group, next, &group_list, entry) {
+		struct group_device *gdev;
+
 		mutex_lock(&group->mutex);
 
 		/* Remove item from the list */
@@ -1924,7 +1909,15 @@ int bus_iommu_probe(struct bus_type *bus)
 			}
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
@@ -2969,8 +2962,12 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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

