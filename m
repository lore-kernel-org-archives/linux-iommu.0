Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6AD53B;
	Wed,  5 Apr 2023 23:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U06NFZY7YwYXt5L1ZkGiQCfTXrva9Mo71Fj/l6T/UqL760t0ZDWkHuDQgVwPf2sBRVUXPNuluh7mIYRZlFNRscDI0AsqH9HOhn9CWohMsWE6MjxKTxeM42zTjAa0P9kCKHbicAlAl1t/PYFMeCaByagpt/bkUzYxXSevy+n6tRtnGeOxAwFKeaDfdAIeo8TlCVYOk9rQ/oisjyme7RAYKDS1pJ+T04IQ+qurO0qxE6SeGsMii2jUyPAQbUE5GlafPeaG7SgG5cgkqTO5lC2d9CDu1XFB+tWsNH6ODQyyYvmvGXmfxWhDatM+KbyFiDKk7uXTJ3jUp5399g1bbrCfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sMf7AVnrc0BT+xGFJRtWyG76ZoZL6yqF+Da5mGO+ec=;
 b=d7vjDsJtqx5IvqVKn1h7VUkawfS5qUTjfyGs7IvuNBc26fi+L8Z4nhzyecVkfVCPQTEGS41v3OEg0av5TJW5P3otAyHJcX4A+ZA/HYpO8wLWBnwt5KB8ZCVlbmrkD4u9hHsHpvJEe3iFH6MNTBrL2yzPM7DrVetqq/Tj1jO86U5m/jTWt0Wpfn9ptuEJgUVCyJ/9WfYY69dCShvKqnEcq4BU9KXNFgXIvhXsuYndKscdKwgz1O4aSrlf+Ncz2EWDuqTw3ukiPCYiTIiR89HY0D05kb4Fl3mxnBnsnneqsNcetJzDlDW4LL40WFIw8Ej/IfJ5Hau080MsL3xlaOM6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sMf7AVnrc0BT+xGFJRtWyG76ZoZL6yqF+Da5mGO+ec=;
 b=MYSiOaLk1vKIjxDHIOsG8Wzn9RTjh55QfaUqjy21d+dTqtRNSWpGIkps39anNChHn8XEGlcuYoLMOO9ojDliYnBHhrVonTcepNPRTLEcrPK23DhwQHxXgH4rzYlP2bocy8lSJeEPfhHFvv3lpVZgxPMt4565dR2MPZ3M41Keaqt5c8WNfuGMrBaD0yXvM9exxymdmIfoxLKjs5T0lqCVY4niLNr0Rk+a0BrHO9zoAqTToEt0/5KEGLhTDXj8TA0CU8EUUSJt/7t8GD+pt/m6NncO0FX8EujP3QF3kV7nPQXfw5VslFkLx6ao82QpcQ7F+Wkt117wSMoOF5DG4Uo7VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:46 +0000
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
Subject: [PATCH v3 01/17] iommu: Replace iommu_group_device_count() with list_count_nodes()
Date: Wed,  5 Apr 2023 20:38:22 -0300
Message-Id: <1-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:208:23c::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 94eaab8d-2cba-4cb2-dcde-08db362ee3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xBLAQsqbLknQeuyVXWSXk02xahqoKFJe4jKxJpj+pD+IuG73xMxbM0I+CjPHPNWbFE+nmbFA36/pGUgy+FgwtmKf0kEPx9GIehUAqCxKqrn7BbPGZHbRlZFdaSut/9IiZwCTx3A6umm3Qc6E3BTongC9wd1RfCRzIT+XqT3S9vZQf96WopjYICZ1yjwi8OPn/GY++1WvhO3EunwifOHK87Xv1jP+ZbLi8kkfD5E4hMXa66JQ1acFF4YQvYip4CbU+LVqRQQG1icsU+Uox/2K/y64x8avtOU2DloP7hQpT31mCtso5IsGU48s2RfOmLaoYkRoKx2GTwPrhiDOYQONNd7uekYDc0leoIachzBhAmfiPBV2hhT7pDSL1CLpELfAMeyKTKjBaZiUJwzJhurPrTH9+erTgTufKfeOeT1vnHlIz01tZXCRA1q9IGitlzNf51xETt1PYu8u3ikAuEGmYjNQKDlMXC+6ho4z4AUJwvL7r1tTxbdogxtwQmInrLtxMCVpL2sod/Pf/lhkJwDa4JcFmYAdMEps/z3NU0WQNehYZm8jacBMeNwrLLq4FgcP9/CqL9X/uDdlJmbGUJS5TwHK3HreW5DJ7KoQzugy3AY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F15/ZVGuMsPTLw7gURdrBnT9ScoWTbmGK/BGXIQMt73Rfmj3vNM0Qcub/+m+?=
 =?us-ascii?Q?/fKMQYHhw5TDkh19fjBEbFj/kEsGYXpgKi4syR1UOFpMvjA01setZHU3eUNO?=
 =?us-ascii?Q?2vIuvTmi6LVYBtAHFFH51/fccCnbe5fjbjl5O5mZHo3kwwaP/OWYeejdcdnH?=
 =?us-ascii?Q?3rvWDUrn85U3WvBzSdBp8wCyssRLmoVjglCzAboG8igUf23xbeA7Y3zbrOnu?=
 =?us-ascii?Q?NkCaGV/I+yb+KIgSQ23cPSaSHnBltFCHONHOWSaG1JVK1uy8R6UBhUjz3VgP?=
 =?us-ascii?Q?4xqn6clQ3fV2YUzc+s4enhJX5Q9Kqt8HQkXhiEg0C03ynTgtAE1/z4AwDZwF?=
 =?us-ascii?Q?08Th3XYKxCaPE/daBlGvGa+qFz4i0q5yD7eiclZ2+k3rAS7HiZhegFwKFAWj?=
 =?us-ascii?Q?fvFTfFBoy4WUa1RomrF+IF/qMVEbKbG1eftT0X0Mx8GiRjBQI7qWQ7L9/gdW?=
 =?us-ascii?Q?C8J+ihURNpuzy8Zk7PYVJPZMqPSj494mclcMLbijaaqoR5ogLCKmUrVYXsuT?=
 =?us-ascii?Q?ZgjxAkKRfHv76Q89YLzD0FI39D7AIdKodm3wuklrP3pTzy5qGo4NYhxtMP0o?=
 =?us-ascii?Q?PsmZlK1TYtPMXWzrArSabkyWa9fp4YzhXtYjpXo9yRCcAfP7yAkQNgzRk7OZ?=
 =?us-ascii?Q?yRKP/YI24r2I5KpAlrzE8A+tFdFO4NFG4ZCVFOeSHJoPT+tqEqEceLCuaAOH?=
 =?us-ascii?Q?O7EoSfY85zsCEELY0IX+E7ZzuFZPenBDuTNypP6j5oWMLv5Iq7SV4Tr0NT8H?=
 =?us-ascii?Q?6B6uyAr9kuhgPSFNfXTEsT75O5nS2HhBNhQgllnmBx19GPN+e4nXeHCGPenu?=
 =?us-ascii?Q?SG2R031KDU8hHXMhyZazPko08HX8khhavoMoYm7HwArptW5x16gmkz595c9p?=
 =?us-ascii?Q?koA+APjRYkzjzWrBmfNDBB04an6ra1iiqQqXgEekoLc8TDnNPN/UJDAuRnNI?=
 =?us-ascii?Q?iPKqbLnY7tKxCDOxccOs8YVwX13lntxt6ui5jt/8Ly//UJFoMtbZrbg1v73M?=
 =?us-ascii?Q?225AdM/it7CrzjS0/U+AFXxAHBOmuXaXXDUxu8RCtTSXZSjGCg+MxW6mTiyM?=
 =?us-ascii?Q?i/Yk+zqIw8Pi9GG1ogykMk22NLqGV9xUEcc4J/s+bSMnOxnC28VaQWxhn2gz?=
 =?us-ascii?Q?7sbfX5GMQx80w+tnvBull4HdHpKxoXX0YQO8b0Wb364UmP+0lC9Nwlc/brvj?=
 =?us-ascii?Q?OSrzhc/40l9OF3pvrnDiiDp0K5rRVEn1qadfkQxJAzGL2qJeZSA1kkXWbHba?=
 =?us-ascii?Q?jVs+O8xSDd8WIN03ICNFvpYzZMgM5BxTM+repzs/a2F7iePUHm42qPyWblHA?=
 =?us-ascii?Q?50haIVroblkFMtUzjpiOqUDDHMY4I0eqdnLay7as/ogKBJ58XiKAthKVfBr4?=
 =?us-ascii?Q?+29hzVa9nmR0j9o+TZeZnzfjekkprMOqb6r94Ha8CWfe01AdffWZpdBVn1CB?=
 =?us-ascii?Q?uL5suWF/+p5I/LUWkcGpDw5wihfTyooVPTbZFas0W1kbCDdaW4TSPeHjk7WT?=
 =?us-ascii?Q?Fmku2h4Pmg49xucgzIshzH+U/+N0wFNuM3frRk9H4RrIutO9tUdApRDfP/nD?=
 =?us-ascii?Q?fhG7qGaVYlXboZfUYV6XDRvO34fWK1Hp1gaRt2tq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94eaab8d-2cba-4cb2-dcde-08db362ee3a8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:42.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /W1jFaQmt8Q/7QWxq7Fo8SNXbmO38Xt/eVbXzz3vOWxlI8U1M6RUpk30TazR4Tfz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

No reason to wrapper a standard function, just call the library directly.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7abee83610b6c9..8cdf47279704c2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1149,17 +1149,6 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-static int iommu_group_device_count(struct iommu_group *group)
-{
-	struct group_device *entry;
-	int ret = 0;
-
-	list_for_each_entry(entry, &group->devices, list)
-		ret++;
-
-	return ret;
-}
-
 static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				      int (*fn)(struct device *, void *))
 {
@@ -2101,7 +2090,7 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (list_count_nodes(&group->devices) != 1)
 		goto out_unlock;
 
 	ret = __iommu_attach_group(domain, group);
@@ -2132,7 +2121,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (WARN_ON(domain != group->domain) ||
-	    WARN_ON(iommu_group_device_count(group) != 1))
+	    WARN_ON(list_count_nodes(&group->devices) != 1))
 		goto out_unlock;
 	__iommu_group_set_core_domain(group);
 
-- 
2.40.0

