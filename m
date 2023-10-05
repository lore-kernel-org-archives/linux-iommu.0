Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E833FB25
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MIO4Lga6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/7CRfNZN4OUbYDzrcTwOkNG22BZz5pJE+VzWVSH0sekqzECoD1Fn5a3nvtbuY2ceE9Tyrt/f+AgmpdtdZuK+ChSsx72Na1VgmuZCtI+m/5NVNbheucIG0TkB5XkFZ126Z3HAK1xdPN3CjiTr7+8oi/1zAzsrxbBelwpUgVjwHdfHJTqr/ySifa/zxPFoSJ6jT5PbBDQJDJjPu3BGLd0KT1q14MCkeJs8NNqTN3+2i/yM8GM7xpT9UDHKHXtC3iXQJ6iwNt4S2vZgJAM5NYvQkGU4cHwYsqRPmF3CUFtgp6RFUcMoOBgGlxB1cgKts3LNNu4HF6aAZoQZh6zGzhk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2R38D64Hno/MA13f9pzynNmGFtlFzBHJVeHOj93zaE=;
 b=UPpkR3pnHncUIT/aV04ft0uzXS/bcfDMxWVj1Wf0zkP//ryLX7BMjYtyA3LpDYPaE+SRR8gKeNp/1VEx1po+h4PXK3iVSxSk9XZ5TB7g4GyzYTxOO0jXNiXlWYHEe9kzx9unBNSR/AhutbMA6X9dbJxxXjFrrJfrsia/syK7HorGtM4rmwb3KM+FzrrNiZ2daSkN96VbLQjiwbECM1fCwEoY7cFa6UDyhSnH4I2cZKHm/PaJOI9kBYBL6KN6fMo5yVUCXFY8/cpNQeWHXeR+R6J+YlIUV087H8wnQnyK++ls67T71blTcw+dtDuIqYkutsPD2s6ASRY0epyZG9KRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2R38D64Hno/MA13f9pzynNmGFtlFzBHJVeHOj93zaE=;
 b=MIO4Lga6mSCbsmkPjQNQQq6HdxK8wrf5oeF0KpX8p8mwyHmzxrKNNY9krd70qb7R4wJiOg/9VP6YAI5pu4M8wsg8c1o1Q9HY8wK5rIZ2z5JjrUl7H1GDkPFHPGHRTCkd26g0eoY7LXt0Uy1uqV0YSaOOImqgsDopgzJ/dWYYrVFIbAq8HG/sHQDz21YOO8DhuNFdRML22pClBt4xlYnx1uJzPutrh4mKBGgT63bm7M1POpTZslP1wgqQQw1ZChPgsf2HmamHHanF6kECRJPvdviq7zQ2xu9upGdnVG6XfhPDn/yFuc0O6xbLtIipanYmF7K8dNCY/rQb9ghk7F+YTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 18:28:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 18:28:24 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 3/7] iommu/arm-smmu: Implement IOMMU_DOMAIN_BLOCKED
Date: Thu,  5 Oct 2023 15:28:14 -0300
Message-ID: <3-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 426da7f1-9bdc-4ab9-8b7a-08dbc5d0da6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5tIU1Rg9lfWjOvrlzTtVHIWV+kgZw+s+O9ZkGRlZUvq2Jn5snDy7isl21hBEL4yIqgaWLwkG/ToYPjf4D5jv0ejOPyv1kcjvjXY5RxywMcmgkCl5CfeqHizJC+uS3bFROrRLakwzQP6fJsGKgCUByXZY9ZVcppcEgwfbqIcSyS+4hqjH2EICZZdb6MWCtE3SfGfQNzz6eilKYjLHgpFecWZEQ23nQM4hPQSc66YzkPvjPZ31sn8PabYseIJvcMlYLkF+ucyIjz0UbfBK+7x8+QDS1ywfdfXYGVTodpuGJO1sNuWS3zm8Rx7QjM2RW67YQGyDLRx9G7kX2fNgUjlisZpElqVZfi9TLLuFN1vBAgFHX/nhRPO48enWWkzViDwPVMmws0LoeCeLf4O0InAgcUY0vQoq+RYdrkDIT6G+L5+LyQolMp1e8IJzdUdXtNWrpiyET/Ojj9CWU1uo3iO+2TEOcez3W53GLFpGqy7lLY1aAZPcLG+KzvSpjX0UqzNM42nl0QroHMby7taRLHTO/SSpWn8u78sb+JswbTrVkWmF9K9IM6Xjk3uNuHtu7XIR9gRk6dVOhxluGBA1pCJASY9om5D33BT/q3i2uMZpKNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(2906002)(36756003)(86362001)(38100700002)(2616005)(41300700001)(4326008)(8676002)(8936002)(26005)(6512007)(6486002)(6506007)(66556008)(316002)(66476007)(83380400001)(6666004)(54906003)(110136005)(66946007)(478600001)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T4fXacvxqpSoD2H2qwK7C/Enckxz9WTuWmd5UujUJRUY3irp7sgJ5nglukaX?=
 =?us-ascii?Q?CW4kxVVaw81w39FkmwI6RnI89aKbdBCGl8XkydwB6TbX+uh8BR4yFl/9oc32?=
 =?us-ascii?Q?tLMcoEd3N/nR0GJzYixvmQHyrVd1wncq60XWZEPvyOYXpQlPhwnE6be8aZt8?=
 =?us-ascii?Q?xYClEZVIinQ18LV2vKhWbjsdI73QA+vxxzNIMgZgzlZumec317rnIvw6zpIS?=
 =?us-ascii?Q?1ezI9KVsT/IW71ottOFbBeb0MZpDuXn6++ZutKnivs6Hkl2rUFV31zaplGVA?=
 =?us-ascii?Q?89G0MzG1+uk8hYIIjcEc7/VOjQjBX3Y2YXXVyQI3CiNbo3ZNxQSh2+ApD+Jf?=
 =?us-ascii?Q?UkNA2fwSjWrn397KsRFh/2hzG+RsWWm/1O1Jywp3I8Lp+wXeAwTdXXh2mDtl?=
 =?us-ascii?Q?qCaQNfcPxFbxpcC5FpURqbTD8SB3prnyTK0j5aa9BaThnUw6jUYTpYrXl+HD?=
 =?us-ascii?Q?bbte6rq93QiYHqSHD8tK3mVq9c+NOvVDYkvtLQCvcBtJALRaJggQ6puAb5uG?=
 =?us-ascii?Q?MBY/xQzEYMllfwCk1y+iYm7b3WiBDmyZhLEd3uUdgu2KHYjyfdefntJcdiV0?=
 =?us-ascii?Q?/oXQej1eBQYZgKPBou5qxPMELlj1K/xak2sG/ldbYuPen5SoiE2aigN/0OEP?=
 =?us-ascii?Q?rGXKnDNhNKG2Hqz3ODb2Usy9kDDsOg+6knbJadQuSRZy2/xKQ+7e6NKPHhCI?=
 =?us-ascii?Q?IyXJqZmWNpf2BmNRONQY9vG2K/Sc42z9BP/UpS2iOLImBOsgro1i1qLtdyuX?=
 =?us-ascii?Q?wjata2UW6glFhQ48wt66MTqsa0eFMnXjJgmW85HWXWfWCI5++Fp1hgfPJ07X?=
 =?us-ascii?Q?1lCgUTWFy8zfg5V1MY9mjWihFQqdX613na7vJ9Whuop6JzZnBPAEE+q2+5As?=
 =?us-ascii?Q?nhlnBk+K2pGtg99gQnokxsGgHJMLA9ZPZ5EHOwqoHaQFhFA4Z27rbfUS7IGY?=
 =?us-ascii?Q?q0CkOAzIZZNrR7ddgFppj8a5cYHquzX/2YYr5U51g6FecRJoi5QUAZH/pzy2?=
 =?us-ascii?Q?8jNrwSyv6mpKVW779I5I+cn98mUDuulcZ9TFfKwF5inwYqtZ92XlW3HQ40zs?=
 =?us-ascii?Q?H/2+yeWgvvWT/W6kUf1waDYTFBUFEzjdE4Sbw6F8tgdfF4dEx0hN/KiiCDcn?=
 =?us-ascii?Q?xPtxfPabq4Wusqt6O7X1hmrikSXdf08uaXxJg0Elzk/B99ksLurdgvX4Dwuh?=
 =?us-ascii?Q?rmswdEP8hS0BaQNNKOX+fILWZ2dPJfv+AyMeJlgdZ9Esat5uJF5kB4OXaGea?=
 =?us-ascii?Q?c3lGvHhxMSytaChVMkYlHbTFOsj/E4/E/jSdziNcyHY3s9uLNu59+l3z61Sp?=
 =?us-ascii?Q?PpdGCkreQcWeeqfac36b9Bq/0kzLtHiCLDKCTz9+AeBZUHPQyEKG0cg1x1rI?=
 =?us-ascii?Q?O+BXNGsFd50uw6dyRpRZNS0zje1Yudpw4/pM7zVIgtm5qvXzRVu5xf73bKX/?=
 =?us-ascii?Q?r4eYoaF1wTwN/LrRibdALeKjdYL74iGGylUpVyTw9w+brCQwbdvYRQIb1YtU?=
 =?us-ascii?Q?LGMxZGaS4LE99dTqG1uVUJtpm8zyK3uTKDg3cKkauloQqaOBKWayXyVI5BCv?=
 =?us-ascii?Q?XxzlWgFCbMARtextl5pVRzLV2ytrVCAXJbjd3qGX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426da7f1-9bdc-4ab9-8b7a-08dbc5d0da6a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:28:21.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGWYZT5X+zmLmSVGfQ+HsATSJfv5ClynZcNqZmxVKuj4YWvKhFBLU0hB/knR8x1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

Using the same design as IDENTITY setup a S2CR_TYPE_FAULT s2cr for the
device.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 28 ++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 141b8d1266d808..0fc4f2e8bf3ed5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1161,8 +1161,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 
-static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
-					struct device *dev)
+static int arm_smmu_attach_dev_type(struct device *dev,
+				    enum arm_smmu_s2cr_type type)
 {
 	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -1177,7 +1177,7 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 	if (ret < 0)
 		return ret;
 
-	arm_smmu_domain_add_master(smmu, cfg, S2CR_TYPE_BYPASS, 0, fwspec);
+	arm_smmu_domain_add_master(smmu, cfg, type, 0, fwspec);
 
 	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
 	pm_runtime_use_autosuspend(smmu->dev);
@@ -1185,6 +1185,12 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 	return 0;
 }
 
+static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
+					struct device *dev)
+{
+	return arm_smmu_attach_dev_type(dev, S2CR_TYPE_BYPASS);
+}
+
 static const struct iommu_domain_ops arm_smmu_identity_ops = {
 	.attach_dev = arm_smmu_attach_dev_identity,
 };
@@ -1194,6 +1200,21 @@ static struct iommu_domain arm_smmu_identity_domain = {
 	.ops = &arm_smmu_identity_ops,
 };
 
+static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
+				       struct device *dev)
+{
+	return arm_smmu_attach_dev_type(dev, S2CR_TYPE_FAULT);
+}
+
+static const struct iommu_domain_ops arm_smmu_blocked_ops = {
+	.attach_dev = arm_smmu_attach_dev_blocked,
+};
+
+static struct iommu_domain arm_smmu_blocked_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &arm_smmu_blocked_ops,
+};
+
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			      int prot, gfp_t gfp, size_t *mapped)
@@ -1581,6 +1602,7 @@ static int arm_smmu_def_domain_type(struct device *dev)
 
 static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
+	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.probe_device		= arm_smmu_probe_device,
-- 
2.42.0

