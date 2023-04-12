Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B78E5671;
	Wed, 12 Apr 2023 13:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl9X0LzpoEcX82t4e2+ylDtKRh8XDXM1RgzD9ZNAlgQdghMRJRXH5OWi7DqEdEJqCLDXkPFXpSeqsf5yrb6foRQdjXFZdjUEXpZLj8mDZsJG26Nsc9tfpZLsZ1Qkl5i4JdzCDSmYqjkNX6Wlvy51ZC/S+qUOP6CsBfpjPltrpToXYZZyjzemv/7CGShQGQacz+we92Rx+xMOn8ZPKO4G4lDHgFEnVyitbRfK7u+KniTAaF+DwGcAYcaLTDLlvvkxjnyraVYmeAj32t9GNLaySr0WYWhI64uKGDaSB6oaLQeY6FDxGTh+UKug57TYXyLIZ93WeZcbk41q+2A01jbUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MvAO9zMPhvKZ9N57z/zbK/VLQ/PaY+p9JYKYFHrcjc=;
 b=a5s5X3VZ6c/rUs8Vjklbmp7ckz+WeiXKh3HGZB+ruMnVxfia+/uD5hVy9zG+VxV/lCFvNIEE/JGCiTSRk2cfbS86XThrvn4CfqjK9BztBlpNbZxor9+OkaSKJBkGRpALgLMi6kRj5UkYHA7GZv+vqU/RBWV1fWTHmKBIyi0fQlaYd8J16zG41PC0YK7K6MkWGinSUPImLji4+Wa0B5dRzvSBQX4gy5BrjJYwn7w+iwfo2hde73KrZB0WB+GQGvgJt7RiOCAw0wVdXgAstoOmTZWaU2LsoSn1ktdeVxaDgqCKQrod/GRzzBiGonEl1SIY9+K7CR5bQqtQzn1ugZkv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MvAO9zMPhvKZ9N57z/zbK/VLQ/PaY+p9JYKYFHrcjc=;
 b=CFFAbQhu7POgk5DZ9D0uTfqsUYEkFy/9Au5PL3mdBrrbwthT6n7pEpejhZy/UpCOmJjiWhh4sr3qjUjrHZIWhE36w+shXX7OYXVSY0PjdrlAwvEViicoJ0XfVnlbi1JagqZjtLKZkQrFqFvtGm0IGUHFJCHuKKNtd47QD1FA3DIgskWZwdOqZFFvSczlu3TjL/CNte46RZxBxgxrkfpNk2w526JSDHhsPCrvBpPjuGdTWDq7rtJ0nrz3Y5c2fDh7h2nLc0M8/G/0hMvTFD6oJE1xx73r2iKqufKXXKfPAE2rtQuYZ2TmJlK89DzlAAbV9kaMamdy64ZlrdeZJeqHYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 13:51:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:48 +0000
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
Subject: [PATCH v4 06/17] iommu: Replace __iommu_group_dma_first_attach() with set_domain
Date: Wed, 12 Apr 2023 10:51:36 -0300
Message-Id: <6-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:207:3d::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 980ffeb9-ef92-465f-97e9-08db3b5d0f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gM0PgBdM0ByZI+KPeD5c3B8dzAZrHifY3NJ9RvzXOVjiICn2bVBWB+LcVSPPDGmzgzr2aZITk2GjXHzn4tB0hhvVHwR2BQTr1PmXn/4S1RgTtNATHTVIHx0lRlbH9WPQL0FQSRFYvROOuTmtL9tpSTDksW0yFYHZ4lH3sW3Z7pQkmfBQQqccnT8SFauy5IvJGfXc6c/GYveAIrmjDUHQvrDOUZdZW9XPdlQ6tp+pQXKfkMM84D1lgqdcnm4bUZI6oC77sS/pOVVn5qJDMpfORXrsucbAtuX72bxqR5enqYzQ790R3Qc0BLLvGwgiSGxH61Lp9DgLKIa8GvbsVHuP2IEZjbeovFl+75xJkpifnhJTococyBmnH+04XMGcbtrWPsMPF//hDHYpZhHuHLFARg3o03Hfq8VGttXdH7FaWgFZ34yfrFsI0GQapRIhdIqBUC1tZd84aYNa7suyGbtznlxQYr+VQhPu6e2sYWfNR53RhVSTcg7XnESKaROotwzTPGCGsvfTgs76Lg3ynUR9DMx4VFALTSowpjbHFy53ZkkYQpXZjZz6V/Q5Fc1TXh2KHJAHbWuJL/+5jddVrY1+mj+BXeIHw3l4UUus045ONe8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(478600001)(110136005)(26005)(6506007)(186003)(5660300002)(54906003)(316002)(2906002)(66946007)(4326008)(107886003)(6666004)(66476007)(6486002)(8676002)(7416002)(41300700001)(8936002)(66556008)(83380400001)(6512007)(36756003)(2616005)(38100700002)(86362001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ysep94fmNXfnatUiVxOmEMZzTsoTUssxz3p0WfAPOT303DJ146KYJR3fDNdn?=
 =?us-ascii?Q?HeJnOGijfgjxx8+pZt7yiWWWZ2SdfTfVg+p2sSns370faml7JpUCkQjqqPYC?=
 =?us-ascii?Q?PC5Uwr9OOxiuoWO3UGcpl8ht7/i+2+J9GbwFFbn+jnQjph0ar4LnhaZbFVNq?=
 =?us-ascii?Q?VxSYgSjSW+vLbunKNAyWufkRSNrBHSkc14LwT5EKLnNVappAq66+wAXkik/i?=
 =?us-ascii?Q?hY9noEqIbK6mPS6eqziwoM98gir+2d9nZyltrS3/f6rHDscNh3LAiUun1BJc?=
 =?us-ascii?Q?FMkQ9XNDwcPn2LCQOrGgGDVqKk0R0VSpux8D3DCxrqkZO8HrBP9g+Jj0N6cg?=
 =?us-ascii?Q?XZJfYqvOi9tBDYo+jGfOkZctyMFQBJhtkOFT3SdvWKxHk/evoQJYj+tmJ7He?=
 =?us-ascii?Q?fT4V1mtOQedlj2kkg0LqL8CuGwvaloT9jg76Z3dSnzwRmwL03Gg3Mfh+uEaR?=
 =?us-ascii?Q?G+XXselQC3G/7l4Ro2juMRq3B57bitR+uQhds/2vMHVv8lpyqWix0+OzR8AP?=
 =?us-ascii?Q?7TczcwnHKox/jJteAsghJnk1wLU11D3IRMu1We0f0BTVgZaTWk+tyCP3KBIi?=
 =?us-ascii?Q?vpQOhjZoFZfBm77td+vFJMXR78JDU/nSl6MVqpJHb0pTL5OHab8wk9d7OZ/I?=
 =?us-ascii?Q?9naJBXlm4k/+2Q21t4alQoKIV9cOBjwFZj8Gp8c3UQdbS1XG2dpwZOXOuwZB?=
 =?us-ascii?Q?rktxkCF8NfE9HewSyzjxmu9TzSh9w8aqTri87qs6ydyk1M8BsfFw/4VW4+61?=
 =?us-ascii?Q?kiLOnONVrj6TS6dfMW4E2KzyW4EWPPKQ3/E973K+kAYe5ZaMVvNPai7T1bHN?=
 =?us-ascii?Q?3WL0Efx8oBL+Pd5lQSo7XtGIpdCLOlTbxGRmasgJ1YEujQThEsoaWaSQBMY6?=
 =?us-ascii?Q?0EgC903Y22wKDGRGXpQLa+vbVgXwGqaJhtyktF2/OKORYfu0T25jdaaBdoCh?=
 =?us-ascii?Q?fA910as+b02WW+RCIPcWyhZi1QjMn2bTHEFLyM1R65OCVGNFzedarSLdn+np?=
 =?us-ascii?Q?/Q04xXYCmfnecFxPxsYMuo6YiHkypEJQoLz3EdfardhtnnPG2fC14ZWHBg5x?=
 =?us-ascii?Q?F9E90MT4ezmIBWDNVL+ssj11uGVo4fZBdd/h5ieuxc5LN6LszbNV64c1GzB6?=
 =?us-ascii?Q?i6but76vMwcTVQSiDVqhsJYGfvZ4W2MM/19UJexIkHuGiBPKVE34yItDip4D?=
 =?us-ascii?Q?Ad0q93R2Qw8P97R8IK3hiW+tx9fLuoX6uGxhJ8ohvwE+cBxcxZDCPzz0lPQG?=
 =?us-ascii?Q?1HmVvByMhrNkBUq8LwHQkbnRFERd0OJIy/oqwWp951U8wx3UdXckqal0/vc2?=
 =?us-ascii?Q?Fcwyi+C5XZzWO9Uk9gsBc/O8C/Mi8Pip6+w+WQeHr/oGi+eHICT1dgrEfMjQ?=
 =?us-ascii?Q?HtPY5TzYzumtlR1UuuwHydrjP+fsGNF+nPwKDc0Ac+LE+FpgL3IHlMreXSF1?=
 =?us-ascii?Q?ea+9+RaI9h4jNz4QAujRnqSHaC5kXsQSug/6qarzo6SyFHOCCJPmwi/MH2/U?=
 =?us-ascii?Q?Dbb08Ui8l+3ECweKuz2tuVl7SQ01b6cVO8PKMBib6ejsKkMH50wd4M4jdX6M?=
 =?us-ascii?Q?lGTJFGRt9lRI0GBISPpQEEF8wVXswKUvZbtK5kfH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980ffeb9-ef92-465f-97e9-08db3b5d0f64
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:48.1325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /viWNKQW/EDdTPif+TE47m4e2YECeddY4HJu/FKbA+//o63TQxjHj0CUBYJ0vHm3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946

Reorganize the attach_deferred logic to set dev->iommu->attach_deferred
immediately during probe and then have __iommu_device_set_domain() check
it and not attach the default_domain.

This is to prepare for removing the group->domain set from
iommu_group_alloc_default_domain() by calling __iommu_group_set_domain()
to set the group->domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 817d90081b4db7..b6e6140119731a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -360,6 +360,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 	dev->iommu->iommu_dev = iommu_dev;
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
+	if (ops->is_attach_deferred)
+		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
@@ -394,27 +396,14 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
-static bool iommu_is_attach_deferred(struct device *dev)
-{
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (ops->is_attach_deferred)
-		return ops->is_attach_deferred(dev);
-
-	return false;
-}
-
 static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
 
 	lockdep_assert_held(&dev->iommu_group->mutex);
 
-	if (iommu_is_attach_deferred(dev)) {
-		dev->iommu->attach_deferred = 1;
+	if (dev->iommu->attach_deferred)
 		return 0;
-	}
-
 	return __iommu_attach_device(domain, dev);
 }
 
@@ -1855,12 +1844,6 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 
 }
 
-static int __iommu_group_dma_first_attach(struct iommu_group *group)
-{
-	return __iommu_group_for_each_dev(group, group->default_domain,
-					  iommu_group_do_dma_first_attach);
-}
-
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -1923,7 +1906,8 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		ret = __iommu_group_dma_first_attach(group);
+		group->domain = NULL;
+		ret = __iommu_group_set_domain(group, group->default_domain);
 
 		mutex_unlock(&group->mutex);
 
@@ -2218,6 +2202,12 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 {
 	int ret;
 
+	if (dev->iommu->attach_deferred) {
+		if (new_domain == group->default_domain)
+			return 0;
+		dev->iommu->attach_deferred = 0;
+	}
+
 	ret = __iommu_attach_device(new_domain, dev);
 	if (ret) {
 		/*
-- 
2.40.0

