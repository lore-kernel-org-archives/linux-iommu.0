Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D8225CC
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q7PZdzXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krNi04o5xa8GuMZwFq+QedfATE+E9q+scZrVHJBLGB5N+pDUeYqo+U1SOWqqrpFrqon5xrxhf7RNKMQHlz3WZNXfkUbLYck0KsT8I7kJBCn/i/yLH4jGSnOyeldad3+7zryBWKtLmU5f++PFhUg/l3zB1CcoFYs/NAWf7g67HhuUT53zShYgGyAjtMSX+QsaldTUlcy3Iot5TkB/PY9vJf/jhqqf1YswgjhUtWzkCVQZNAMduM04cbneTHOxrkkkjt+VnzWWZsDruL5EV+4JeJxYOUPuwEv8n7DvF+PIsN0nLrSWSgfmmS6ErZnF2/lAI4NX71Unl3a+73kqf7e9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msCFeLRLBv5w2Px3ZlSsPPf7JK2Lcc/l/EOrRt7eBwU=;
 b=PiG6mnb8rGrjf5EVwloF3cEbBhmKH4k91Vb2k9hPF6WPa4MeVX6FHi/lubN71Ri6nc4+0efVukN8Aa1O4wd2XXNUb3Nyeiwc/HOtG8v7EOe4xUKyO3mMyS4yc4J3/vDH8TyLQwM4WujkRtYEmmdg226AEmzMmqHzlZrrs6yGjGXQsQbXWXwbUrNOcKRTT9FS+AwE8cmld5WnDi1bf81k5ZbYLY/mVUaPABhf6FnP9bMXSBLNTgI1UyM0TdNX6Z6g6TdvO/CBbRhQw9EXB2jUHh6Rwg3TdUIXYfhTiX0IHOWr0ZWKtELFDStfr3Bra8dsdK3CM6JBF/K1/sulUKhaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msCFeLRLBv5w2Px3ZlSsPPf7JK2Lcc/l/EOrRt7eBwU=;
 b=q7PZdzXlG7OZsp7kynRO7zaUc2V19aLLiEellbSuV9V9yJPrBe2C7qYqcUTmb9R4nqsMS6WCztXYAVTldemO2NHdpwIvuHlFTd3m5vVcw1t2EJlR+sAPgGv2jZ+X9OPhDoR4yRDWtLiYHI7AXhQcpIwoevFCvkfBwu1wBkBl7XNZY1e49bOEnRo3NOWdxpuri9EHQLcsA+iEnSYRxVzLyy9TcZS3kF7v0VIPlV2USgqGT0oWkfDu+3fXSwRXyhlhZdzYjStMiRMv6zd17vb99PZuFTufpdC9XBURAqIYAyiUa0cYIa17XVi79fXSFlxbOBcWQv8MOC4lVtQ9Loi5KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 09/19] iommu/arm-smmu-v3: Hold arm_smmu_asid_lock during all of attach_dev
Date: Mon, 13 Nov 2023 13:53:16 -0400
Message-ID: <9-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0328.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 87216ab0-d498-47ca-a50a-08dbe471702f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7IZ0hfS58eANb2WzYbtsxcVSGB2/TMXMX5c6rjhKIW3wAeSsKsEXv4bncdwTyl5jwRYEIvggPMo0PJ0FMg8vl2XxU4AKeYMRl2zAWD/+OfOlGzwBjcz2Km7bQQycem73/7A2Skrld5JFhSpUMnA7bIKJa7c442A5zlQhNvqIqeVA6EpvANH3g6p7muTRMnLOwRLH4Dr7dwh3DxkZZjB3VPVSqJZ3F6zq/NBnDKJKLjmjNbotKyBsXOK1ZRW7Z/sZCV28iw3NbxSMGLP0YykstSnzdCQBhC1x7UJzybOaoRn1C36gKkjct9SXJ//StDiI1fZFumYHatZ/rQpnYLaFn8EnK6x5+sqcb0A/QhDy7NFOV4bcYzp14ZVM1eAG+7gSCd7FwX6mFRqMzzfkO7xIFLGpiHHm8i1M0p4BF/pR6te8C22wyX0pMtW4d51AcCcatcvW1CRZGcz/TuDnRmonj8OkX7Ukiq/tPSufX9nEI6QWWY2g0Q7XYYHGktHTLl8LH/eZ0Xz0Qc3Aw3axBBWvt8rLMfc2dqoVyevr7SRjRPeChhRADoz7kEKbh8+V5+ImLTiilRfEQXvqdKI6DkDnR0zJuHO8I9qJiTijBPpMbEw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nl0hkPIk+M/wZOwckWAnMwdSk+luwCsf1p9v9fk3It+jIWnv12iz8Zzqta1B?=
 =?us-ascii?Q?cL5I2noDjcNT6ySwrOsorDtHy9CEvHisWpf+PEzuUvHkvPBeyhNZVBw6nrh7?=
 =?us-ascii?Q?YnsN3L8zkobqP9xPVb0l6qpTwZBTNxXP4bzQvw6bqenFrmqf/EAz9YnJoyuB?=
 =?us-ascii?Q?mFsiC96za5AYqjbAu1t5NRUI2Gz7u52Md4SPcGVA+BewsMbKLdE/yuYz6pSl?=
 =?us-ascii?Q?0VRlTHsfkh45fRYu0F7dfPIH6RRIJY0OfipEyLL4aKBOJN3VoIMTG0dkXCs5?=
 =?us-ascii?Q?D6Z9taXLGrwMxgiENoU0RuG6qWfwyBC84fc8hVHfCduJlvDxT93Dc4JXGW7K?=
 =?us-ascii?Q?YH1Y3hePMGCGLvPC3r1wQPoQcs6Ca6YAp7K7aRU0pXOVPhEgNJr1b1y9aS67?=
 =?us-ascii?Q?YmrrX4QM0n0wQ4pVb5tWFnArq+c37f8/NEHp20qNH6CxY+dsJ98puobjpfrZ?=
 =?us-ascii?Q?qDflsCbz1E8K6UI0dGvewv/fB1kApey5d/Wbik9kT8LHQNGGctZSNSHknYnx?=
 =?us-ascii?Q?eRghXT94H9AHAT/z3FOwxd2/8jwyffRIP4QJH9RzooahlEVZIUHhZJlW622P?=
 =?us-ascii?Q?2N00etrfdANMXdetboZfgoA22CLPBdvlRYRRXWKMn6roKyjcuHcLxdG9OONK?=
 =?us-ascii?Q?PJXlFhcE9R6Rm0Ncsdmb/7/qDQbvXzcl/YMNmyxq9J7sb0tbGlaq8Dmg1uc7?=
 =?us-ascii?Q?/Z5k41hkXkDjzgz3ES+5OWLxrOBXW/E/+RuFru+oYErOWC7RZx5Kc0zGJ+i/?=
 =?us-ascii?Q?hR7c7paropaRo7RsAbek3ruL/fIWFmzeEHRyHW2ZoDSb33Sfd3Lcpmivgl0I?=
 =?us-ascii?Q?gNTT0ANvjQxG373gwv0Cz+1wOJoSAt2FU0mbSQdTKPz4WQgnW71IuWymoP0Z?=
 =?us-ascii?Q?QwBO9JbO3Bu+JG365i6wPOWpSeVK8/yZKCsAX7K9S4ldTu9l3sT+hvY8fbok?=
 =?us-ascii?Q?A26VNz+EAw92VGEQJXLNTLbVuH5AWuCkq8BFMn60FiaNeF25i3YxaI4ZvKCA?=
 =?us-ascii?Q?4e/PAqGaaMqIR/CpSX31TzSJhimQfTyzPsdLULZmUHasPUyc4cD61sO6En53?=
 =?us-ascii?Q?+P/AWmQ9TQp5KU+M56oabH1klx+lqDA6u1HyOx6LvHG5VYoedxRQFedQodAn?=
 =?us-ascii?Q?EpZwaxQccNI99ZP/+1my2yQpMy0JaEQDnvYCwePAnHeNMgohcVIwi9fgwON1?=
 =?us-ascii?Q?dtT/EBuZ8gGqU5E9WabX0idIgnzrBzg6ig5BaXjYEXpp1203E9RN+ysYbjh3?=
 =?us-ascii?Q?1mUxshNOKge6g0kuJol4kxOjJ95/EYbaNbqIYcyUUy/zKsCIu4qA24QF1F5F?=
 =?us-ascii?Q?lPQgsQGocbZCg8XkEVoalprLRjJLwTMnXHUAnXTiE8ITSpBls+XuYkqLjA5M?=
 =?us-ascii?Q?dM2R0EHNzbOlIjP4vgXU0LAJE2QJUOT+cZwJenE8VBK16DBcJ4xxAoWCfaTU?=
 =?us-ascii?Q?AMrxlTIFhkfRThAJ33u8Nmc8w5IN6i+F+MUI0QbXrZZ9dUYl/gTgb3ovmLpE?=
 =?us-ascii?Q?pxiOVBO5d4Amc2FwjmzR05eRbkBi0zZqIKZStXf/14QJQMZx4rqv6iPOQZXa?=
 =?us-ascii?Q?xDiwEc0w2/D2cgdodaU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87216ab0-d498-47ca-a50a-08dbe471702f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:26.8553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeLVLKfZxjOUQ+lt2T6+NlRTp5KtI5vIxr5Uie/BnuLrOoY0v7XCtklEb7koXjm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

The BTM support wants to be able to change the ASID of any smmu_domain.
When it goes to do this it holds the arm_smmu_asid_lock and iterates over
the target domain's devices list.

During attach of a S1 domain we must ensure that the devices list and
CD are in sync, otherwise we could miss CD updates or a parallel CD update
could push an out of date CD.

This is pretty complicated, and works today because arm_smmu_detach_dev()
remove the CD table from the STE before working on the CD entries.

The next patch will allow the CD table to remain in the STE so solve this
racy by holding the lock for a longer period. The lock covers both of the
changes to the device list and the CD table entries.

Move arm_smmu_detach_dev() till after we have initialized the domain so
the lock can be held for less time.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e80373885d8b19..b11dc03ee16880 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2560,8 +2560,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -EBUSY;
 	}
 
-	arm_smmu_detach_dev(master);
-
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
@@ -2576,6 +2574,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Prevent arm_smmu_share_asid() from trying to change the ASID
+	 * of either the old or new domain while we are working on it.
+	 * This allows the STE and the smmu_domain->devices list to
+	 * be inconsistent during this routine.
+	 */
+	mutex_lock(&arm_smmu_asid_lock);
+
+	arm_smmu_detach_dev(master);
+
 	master->domain = smmu_domain;
 
 	/*
@@ -2601,13 +2609,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			}
 		}
 
-		/*
-		 * Prevent SVA from concurrently modifying the CD or writing to
-		 * the CD entry
-		 */
-		mutex_lock(&arm_smmu_asid_lock);
 		ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
-		mutex_unlock(&arm_smmu_asid_lock);
 		if (ret) {
 			master->domain = NULL;
 			goto out_list_del;
@@ -2617,13 +2619,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	arm_smmu_install_ste_for_dev(master);
 
 	arm_smmu_enable_ats(master);
-	return 0;
+	goto out_unlock;
 
 out_list_del:
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_del(&master->domain_head);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
+out_unlock:
+	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
 }
 
-- 
2.42.0

