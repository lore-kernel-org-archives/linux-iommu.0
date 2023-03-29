Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24042C2C5;
	Wed, 29 Mar 2023 23:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYeZjR8nyQzuBv2A+WZ/SOr1VH8782pMYzmB9/dU2YlmFAykDmpLWe5BTzTziJ9D0nuKNytnORvOC/39t4fe8pOoZ9bvDMgnblMlyr7hIQyfRTxxEUxCvL7/fogQUsVe0zl3snqGhiMVjeEom1OeXjCGw4kZGNOs4TLhEqsqRuqIUl/JFbd6Bh3KiPd/mBCnoyUr0HcEcHjfFJ21qYCUTI0WrSVbSZbkAJQzF/3dQCxt8akIvpoU+5xT5qOia+lOP6/tUFVhxqjKg5nO9/x4H1t2r7JvQkWk1ogF721cd8clwILRn4lknU5H4cbC+/VwIv9YbhyY69VUA8sl5MmrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty+39SDZSyg49Vef1zuvrBDhUExZp4bOiFEmZ5s/lhg=;
 b=EtNw52UasnOxBxsprlJG1WyPUhVAwSQtNhA9u50DrOIIyb5aVQRRCsEBmEa9O9HF5WJdaibkfOftX0qieJIRhcWL3rKE/PhQArLFihzX2V3fHn3ELXb/yNcircF3SY4nCyKeojfhS2YhVtsTwBwoc3yRdaPEGaMqz1U2shq26oxp49I0lhAJ/slubJMLolV4+u+Q/0cJdMEZRHeDKB7kz5+VD+ZZ6nqNv6qMYvMkJuTube7eA25HmpiO6GhptUpvPb2OKtamWyAmSf+H/SzA1TiTEUejiCpKDH+fs6MzcttPQELqsjCCKJ1teV0qBzYEDZY89VT98YLAg7wfq2vJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty+39SDZSyg49Vef1zuvrBDhUExZp4bOiFEmZ5s/lhg=;
 b=IwWp3PkWX07V480ohqmu9xEZqgjO9wa1OPyNP4mntRzG1Uuk4NGsnZvWYE6zzQ6t1ihf5bbhLJsiHgkRXzChI8E3yD4tHmj3nDWdz7E6aF6o25MO9gqrTF3utwJg4YLQgwLNvSyFHdMlEWh3/7oOs0ARGsffUMlVGYlEybi1Owpsn5w6J9Zm68xin8S613XENG6dXtQocT7vwV8fjuxuvybQ47g15JtTjr4rJPP6KkQYSLMUbJnkkf2Clvn/BuihpgCt+vtoQb07NZKEBg6K9J112tMO/ZDDTvzfey7dG+BO4nr8FHE9PA2SLaf2fyTwRsweOe5mIejIE5F6HMmtlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:48 +0000
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
Subject: [PATCH v2 14/14] iommu: Tidy the control flow in iommu_group_store_type()
Date: Wed, 29 Mar 2023 20:40:38 -0300
Message-Id: <14-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0285.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: b86c5d1f-1af0-4199-abdd-08db30af0186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2G8If4QtTcL4v+ASbptqS4PyLmFwjbKRGxEbzYwZZYhEKRe6y0Vq+wkuR6oPdrjVH7mUjkKa9lOX/hVKWuYjUyd3u+Ud8BIiUr1iF2VX1rtOxsuuT63XsTpWFE2ggvR8wqwBv30ypKUFgM174HN6uPsnPqz3YdCCCvRi5z5qvR26Q9k7fayWfjJJ2xx173gCGvbtiv7NRRWjfrnU/SKoS+DedB0uyxGQ9Fpsa6HJ6d7Ajkm13EjKKzJeZiy9p9FN7Lc+fTfNkPPXJc5xL0MxXNJNgB0LFC71ID6sSTLAD5ZhGEZaahDrLiHQfEAUNpw8ib0hcgePsWCuZW0Z8u0pfrhaLSOpq40katwuZmknMoae9EcVE+x0kJq4mCqWCotcVjXuvN2VdEPK8m8ChloSXrdHbDy/zdjHU01HuzKvW0nBY3try3vgQQ5N3g/Sc/p6keYrxfulziSIgQ0ijSR67Au4FU85c2Cki9Cv+z3Mhprt7WIoOehLXNuoE++n9QnBZSCj6SaewYfUdjScxChRTU9mOSmOGTuPg5D0P44JCmwPdr6cjTZ/734I/greyLHT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(6512007)(107886003)(6666004)(66476007)(26005)(6506007)(6486002)(38100700002)(5660300002)(2616005)(186003)(2906002)(8936002)(7416002)(54906003)(316002)(478600001)(110136005)(36756003)(4326008)(41300700001)(86362001)(8676002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JsUWMNRvLE1avFbM06hjLzUjr3z0y4KEzMD6rGodOLd5FeJAq/NnfvRiWDV8?=
 =?us-ascii?Q?CcTyJKqGW8KlmYkgAMBb4WeWIjVI8SQSvxJqst5erVrTW90LC6LF547eLj4E?=
 =?us-ascii?Q?htgEhCvwvC9Sl7Qup72oTlT6J9OhFO4El3zEa1drGM7ncU/EPYekdEpqGZXs?=
 =?us-ascii?Q?0inP2jiqzhfXOLi0SCrluXupIDvqr/ks9C3UoAz+/Hm4dLtWJshTiyrRaq7N?=
 =?us-ascii?Q?LATOiHJZJV71nFRWYv0lo+eQON7QzAPob2ibuXUy+Gd26FVVutl5YjU7EjZA?=
 =?us-ascii?Q?WWQOt2tEUZGuIJLZnMUWO0Tj0WjMO3hwNf+NaVghAjlv/us7/DkGKUiyiXGJ?=
 =?us-ascii?Q?2mJuBtR4EPuO+QbHKuVam/sGCv2BxZyi5Zl2wwY1Uqbp2nVprq6GsrDBbSnY?=
 =?us-ascii?Q?ps5k0z/G/srwm2d2n5hyxeYekZNtjX13TkBCb45sV0tX/afJpNu72cPL6o55?=
 =?us-ascii?Q?JeRM6Ac7V3hMlRttJiVQtAYRD/I0EAsZ1l0+h5N1ucAHhyduxXn24ocj2NMw?=
 =?us-ascii?Q?H7xB9/LA+sMaqNdIJSgxpUyTs3s7uF0Lnu4V0Bn7tidifCLC8S0Z+BJz3Jx0?=
 =?us-ascii?Q?fociEmy58owDHV16jxjbBXjPxeE6LpsHsJw4zT2yOd3u+qZKH+WY23HgOOjm?=
 =?us-ascii?Q?Mp0xekLvUJwB/WWIIM1+13PYJGbOzD4xdu3iTC0bQlUJwqEVR2aGrRINSl7e?=
 =?us-ascii?Q?ptomIUHXxtymc7myS2Z0dUYF+xY0hih8+FxXM+UFNT6o/aCHYq4gvyToB8wD?=
 =?us-ascii?Q?CUrtYQ0Ol7KDo2bElLOXkY0hsquSVg4rGVdHOIPTaRBvo6TdIYHkI6dZi61I?=
 =?us-ascii?Q?MhZl65E9zDrLQlGFZLW9s9PfNdeVSBqttm1B4JZvsDGjQOhQwQDY8HbZ60dj?=
 =?us-ascii?Q?kshxzNJ26f5Pyo1mDlo5KDqAZ98jbdT84DkxZXxx0V8vtWne/B2aCGuXYYud?=
 =?us-ascii?Q?Z1zhRSgCaNeo/xcg4KxxJ/LGMUgl3oxZtlDij9+du3xsnqQH+Q1h9h8VxR8c?=
 =?us-ascii?Q?sH4RCz8vr4Y323LBFshhjF5rqKTTb+AWIQraj7qpsG3WsSR7mPm95WV7Rqvp?=
 =?us-ascii?Q?AzYfR1BFR4yqXqDSdZ/oS1kcq1Dz8X0+YYEXqOrmKZxMeByMHy89FcsS+Wdj?=
 =?us-ascii?Q?imAaI83a06KezisCq0LQoEwu6HDg3oFNSJyuBYLw3lgCJaUkkfMtenSWBcCB?=
 =?us-ascii?Q?7gAe/YGNxo0T/36vxhXNf6ZLhd9EcQij2ar5zS2nyJYa8KaypCj3penNHJmA?=
 =?us-ascii?Q?fJ/c0BgukYFKTxNkactrDKakKtrzne9hF2CCDCwP3UhPPPxe6jD2NW19aFgo?=
 =?us-ascii?Q?kgQZve5KWP3d8qTPGKO1ZvDVw8BXCAeQ9dcJqCiOa4wHyfUpHr6Oq8Z4tcBM?=
 =?us-ascii?Q?N29oYq+dDxwvowXPRLV+N3SJk/Z08JumAJQ7/xlvTnbq914hcGqk8yE9UAmr?=
 =?us-ascii?Q?/Wtl3F5oIoJZQeNx8acblIef09+HhrKgZtB5oaB9f8HgVUHcL9QZ9qroFMCa?=
 =?us-ascii?Q?RFaobfcuFe9qk8J7pk3S/mtAMG2rCGW3V/Ue5H/rTXgpczeDF28fX/LZyvPl?=
 =?us-ascii?Q?PEFZee8z9hOsk02v3YeQEu6Nmeg6DfYlQhjaPjLP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86c5d1f-1af0-4199-abdd-08db30af0186
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:40.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YM8pp2ZaMk6ooZVKTsg1KR4K8/o4eDIfGCTK1DdzrLWFKQ9nwhQ6Bcvqsx80Q6/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977

Use a normal "goto unwind" instead of trying to be clever with checking
!ret and manually managing the unlock.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 71c8198f916715..2a63fbdcb76095 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2914,6 +2914,7 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
+	struct group_device *gdev;
 	int ret, req_type;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
@@ -2938,20 +2939,23 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	if (req_type == IOMMU_DOMAIN_DMA_FQ &&
 	    group->default_domain->type == IOMMU_DOMAIN_DMA) {
 		ret = iommu_dma_init_fq(group->default_domain);
-		if (!ret)
-			group->default_domain->type = IOMMU_DOMAIN_DMA_FQ;
-		mutex_unlock(&group->mutex);
+		if (ret)
+			goto out_unlock;
 
-		return ret ?: count;
+		group->default_domain->type = IOMMU_DOMAIN_DMA_FQ;
+		ret = count;
+		goto out_unlock;
 	}
 
 	/* Otherwise, ensure that device exists and no driver is bound. */
 	if (list_empty(&group->devices) || group->owner_cnt) {
-		mutex_unlock(&group->mutex);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_unlock;
 	}
 
 	ret = iommu_setup_default_domain(group, req_type);
+	if (ret)
+		goto out_unlock;
 
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
@@ -2962,13 +2966,12 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	mutex_unlock(&group->mutex);
 
 	/* Make sure dma_ops is appropriatley set */
-	if (!ret) {
-		struct group_device *gdev;
-
-		for_each_group_device(group, gdev)
-			iommu_group_do_probe_finalize(gdev->dev);
-	}
+	for_each_group_device(group, gdev)
+		iommu_group_do_probe_finalize(gdev->dev);
+	return count;
 
+out_unlock:
+	mutex_unlock(&group->mutex);
 	return ret ?: count;
 }
 
-- 
2.40.0

