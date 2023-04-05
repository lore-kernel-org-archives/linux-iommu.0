Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B5D52D;
	Wed,  5 Apr 2023 23:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwLnHsQm4bUX5IoCPpCD+CSbW4+lSh8CQmarPaUTKrJ9NRHBHZwUXhdhJMMYWCMp+/SBhNaDO6xcyfZFiCOXIVf203osyJD6vQRpDTXyZTA+2AW1hxEQ3FhtVA5FoiMFMZ3nBy/L/xBMSgvSTCGAawkam0GdqE0ES20GUqrn+ddEbtt3eIKGL399LU9UQ28ldUAxQYnq5RSZYUDjobIEcTmNKxNlniD00uT/5YXdF3m7hmbDUxE1I0lkAT/2ccw41fGBCcg5ZG5oJgEKxaerNKHiJ3Bz/9rrbFlepAUAeMl0XpIl6kTUwahj+qaliy1z6247b6xMmOZ+bCoJanuQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNDLTenX7H0ubORRWO/kczT7z6pcoNEr0FIzHBz0SkQ=;
 b=CRCOzvqKcSoNv71L18wy9udHtsJqSzZsQnSyDaKG4uwMeLhFqwnyDjPh3fphP9vPj4rIT+/GUQikI8WpEqLWlofqqrMnQVGuHAsc1PineArFdSNDXhG7FP8t7t3gzV+D4OUMRj6E527lUK2tb4gbDiYiUyq11Zbzf6xx2ALAOkMUqUZpJUObGmGR8yDul0lXyfpWadFQH4ohuZLdAntF52Lci9anR/2JeJFMXeEuQ4L8NG7hOJcb770YI8ScR4fIcAJvhFguCKup9NDkHSQwu7jONHiZCHIG2Lm77u5dueIm9bb2gI6f9y6HgKZ3mbKZg9X0buml0LH5sV1WSgi+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNDLTenX7H0ubORRWO/kczT7z6pcoNEr0FIzHBz0SkQ=;
 b=KS+D7iXLvZcs36TM1yJUBqoOlpZ2cs6zmiNa9+rFHRfAO6oUqvS6vKrSdHadNJlZTClk/LJLnqDbLfeYgsFy0r4PziNbBGv9qRm24HWOgDT34Qmv/AwFzyn4PEhUU+EMjjsaKl92YMyJbWJDuJh9iJ8zaDw/VNdBYK5DSLR1is3Vpo/jmNZn0eDaVUmIrZqlKFW7bvHlG2MDO6xwBT1RMEuGOTWupq2RhFOrX/x68dD8NxOHzPQ1yUVwql7FcYu5kLGqNIHMToxvjUFvj0iy6UeS7rLWwo6B9HXzWLcGwMKFPlTBbZVo3U5aQcA4Au/ZdmCQOtYFEr4FFTl1Lalq8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:43 +0000
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
Subject: [PATCH v3 17/17] iommu: Tidy the control flow in iommu_group_store_type()
Date: Wed,  5 Apr 2023 20:38:38 -0300
Message-Id: <17-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:d4::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6eaac8-dcb9-4344-a6a3-08db362ee285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aFBmPGGIrSi784Dg1mWerNllm79db5GpPDz/W9qe/Eyxh2+mLHashiJFd2lOVHdqFFFPBg0v4h1tASyqBu17PS01inG13wDzyjlYDQ/m52a60gwfPJEUOg/hOD1jSs68FS2cCNEBwMz9HDPudgzsLudoywACX/ooymuBs5ocdinRpC7sNMXWCo9xnOfIJdE7C5Co5xGH2GV4uBH5cvmdGckzGbYSU6IoR93jQ77Z56PXjH9P5EWT4akKuyVGVHCoDyLGcR5dibytAmOGT0rnqoz0D/xMrgI/FNQL1+uvrJawL4fKvNJUBY5Zf4DVGHcUznqp1jfbqNbk48k9faAz722zFB0kofTZLJ2g3dfsmxU1iT81wNEsX1OLYliY+7SZLT/MJlbJZwJy9AcYi5RCqn0IwPrHqi7smZZgyRA0gyYhb//SW48t5gK2Pct1djnLk/15kAbMeHLUsxub4asSolshqhHaVbYS8s1EYBnpNA4njOWjmn7Eh6Vee/htBb4zugIyrdPWF5FFbvUN2/SpeKsUtaCgHNbZPY3I/r4UUGfZc5yW8E2npf+7YGwGL1Z5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yc1FhPGVJN0X5zOonkxF3EZv/70hpFZvJz0ipj1ZtXm5g5LEA2gyC8W9R0P5?=
 =?us-ascii?Q?cqMIxwnli6P+1bWwW8N/LxzJkUxagx+E5Ms55+PPmU5TACEnIHDZn5Bi4vSj?=
 =?us-ascii?Q?3Lmxh3eGk40gTO8Nd2jh6X2CxNQu3YnJLTzdcuYw31LURlffrCjFqBik0KaS?=
 =?us-ascii?Q?h/FKXXI28ILvQxV3ZVWhJNHUO7YRgI3axppmzSDlXGfhoU2/VeDJcIpE8jvw?=
 =?us-ascii?Q?Dh6sn+YCMVM2t4etUTv7L8fsU6WS4qpObb2IgYThCiCtCJMS9MDqdpePGYJs?=
 =?us-ascii?Q?u/mv0jjIua838FGTaPw95fmmu6py7SjO0sbu8RNAci/v01zhstFYxqjKXlhf?=
 =?us-ascii?Q?4TKk4hLM+m6fGZe1qwJCvgqnrGPAkWzbMzycqOpfOkKfqdQ8x2hgWqgqWtlO?=
 =?us-ascii?Q?ZjYIW1KbNc3aMH1f2pAJVYpfbv+jaHM/pnQNK/qviwJ9d3tJlemr5XZJJ7Vc?=
 =?us-ascii?Q?sGPxgi07t/pZtXVZUgDiybasdP9/mm9eiHFGt0EZalivsYte7n6b+tPrhpnP?=
 =?us-ascii?Q?Z/9BWImGjYhD3c7O2ink7D5qbdF6jXUWBT0hDnhNyFzBEBwMgO+c+KIJ3SIe?=
 =?us-ascii?Q?kLguzNgb1W6iV889d/vjKbrzgjk/LH/9mYgvFSTL3rkPO5+CfbCchPJ4iVXt?=
 =?us-ascii?Q?jtorQjTYZ0EzbURAwmfXo7jVD+ATu1jG75rTnTGovzlWbwQm98UkX/itxVXW?=
 =?us-ascii?Q?ZxYHlthmDeMGCn0KDrwBZPvTzlcofW9mAFhJraVOVGtlKK22/SJlKd5I4XdB?=
 =?us-ascii?Q?QAu+NpOTJ6Ku7M2XyRSba1OLmtTCb8ZZROxuUISzn8IHFAxLKeaH/Laz0BUS?=
 =?us-ascii?Q?XZoPvmKL7wrT06Hm6cBo+hPPhswv18BdiB/N0ZK+qxrZcZmccRrhEXu9kQcO?=
 =?us-ascii?Q?xQ/4LQly9NrOtOfJuqkS+QJ+WxBzja19cCR2w2kezqyji4hFXJDCL0Cumzbb?=
 =?us-ascii?Q?csPxGDdmdJaimEfwGoMlQOEt+/WQBwwY7Ft2jgJK891ELanGFOYuIu0dq4Rw?=
 =?us-ascii?Q?qp61NLTpx7b2MFEU+zmLQMYcCVeF7CMWWJIB3r69EiSzIyEdENUECZ+kOGRL?=
 =?us-ascii?Q?NybznH4vOEaqxM6QFnfpIUOy9VUryRH9adwidrwctcZ66m/szXsJcx5suMRt?=
 =?us-ascii?Q?9hpeyNEJkVn2GTFkuTHTW8Hdg10O8hb0qwMnDwd/aehLoMem8+ldgmmKaR6e?=
 =?us-ascii?Q?4hQjBCmETQBO5Yw1ol6Er4WDVtv+LgpRy7urPzNx49F9r/Z+grzRAPGutWcD?=
 =?us-ascii?Q?0pADP4W6GnPOE15WvcrtckcaQOgrdpqIuCa7luCpSbpocYEoBQmZEjIMwTA5?=
 =?us-ascii?Q?tG2aowAFXJOxO6g582v7nJM2IoafMKK0AEzoBvBXmcbCudxno/y6NwyGcOtx?=
 =?us-ascii?Q?GI/KEHZX256O/8y/yLMxDjFkIl3Iw7PeEJMOGjsw6JeevLrKH6AGRxdeA6kt?=
 =?us-ascii?Q?JAExwnhRFekkx7rry+/8w5xY0SFWfQv7vGqRw6rA7l+yTj4bWzQTNK8eSTH1?=
 =?us-ascii?Q?VKgiDHZu+nTL73lZxuk3Qf0w9yv4ZK9/deX5O9deMysEk8eP1B+uS/OEEnwO?=
 =?us-ascii?Q?NqoMFesOxusCkDW+UlJiqRsGbcIwnE48M0K9UIvV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6eaac8-dcb9-4344-a6a3-08db362ee285
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:40.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zH0aML28jt9Jite+Y8NL5LG8jVN7TWb+FI2qC/xb8KUTVjIWhU31hEo+kpC2RRHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

Use a normal "goto unwind" instead of trying to be clever with checking
!ret and manually managing the unlock.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cfacd99df78a05..c72aa3e81aae50 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2965,6 +2965,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
+	struct group_device *gdev;
 	int ret, req_type;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
@@ -2989,20 +2990,23 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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
@@ -3013,13 +3017,12 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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

