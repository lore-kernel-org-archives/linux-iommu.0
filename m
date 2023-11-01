Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1721CA8D
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="llHQGusB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzBYDDLxG8tHHqcjqEqBmgyDVYmHvnqz7Q3Sc7X12kUabTRjBol2bJSk9IhlkJBZjXN6wjqwFaJyWiDsgbgyrkCc3397KddHPq1QYx99IgXaD3tCaqdxD125vZSz2iWZ8URpGCYOoz/COqyajxnPpfz6liRK5WD/0DJSINvYhU94DV8L0Kelv7jCoHWrK6OGa0cCagmpc89OakD5xWspyATripxYYfdyXAa+9ezSg6LZOmvQSU9E2zl4luLus7r2+Bl9BneNrhiBbLYkPjxTCKzQCJI3u5LKElXokbh9RbOuu8gjO/qHzSZ2HiXHOOlmx2cF+c1iTUBkGzMnGZFm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EMCuTiPRk6Mi2mH2pRTQ5SvhH7UnnuGyfIoGoBvDBk=;
 b=aIRbBZdc/NpEc1jTyF8h8YwJ49P0/80Csx0GH8UYIRjKzRPJoq9QOJNa8Kc7q4mUr+Br/dpMkpRU0IMeo3GthfzrFHvGIJdS/jpMh1XdzieTA5/28V/IAdNvZwiWPURK25Evrz+Uex0u+FySbXnz9tMlZuA2Ez6xiYP07m319rIPLIYJbxDj0p0k6plCA+Y/OML7PUI5BA4iwxyrVs/tXeOkx1+OJQJwIobzPTCzmun2qJc1CyHvVIlydG2n+JafTvEmzw4qiwsRl9Nxdk+dmuLYOo0DZ5X8TuhpSU6B0QWh34S6BKtI3EvF4AFV+YzVFpHcSK1RSQwnhQMhdVqWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EMCuTiPRk6Mi2mH2pRTQ5SvhH7UnnuGyfIoGoBvDBk=;
 b=llHQGusB6CD0FBhbvqlA4etibyeTfnxq7YVpdHR//78Tpx6jJDQaL1EQzbjKSCRwY3dDhEDU+bYTlWG0+lwTV20mTZzJDQc6qIu+1veLWQmMDkuib7I2sDzKH5ESNdemCr/R0nKL+QV5detOuciOoo7TBj9xpBBxkQpGHWzFcsiOL6XBpdOuTvyMw6W+mHTdZHbzajoyMndD2jTnhkfRVDOC+m2+csDjbRgm1RGfoJdGS+AZJB01uvO2jUBDFYJ7F35TbTET0iVRszvax+6JX3qs0CthyHcckqsg3SGdB2t/Jr9wpZU4N5woQ4e6tlo9MyaPKkYc6zBubl8pYf8SmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:52 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 02/27] iommu/arm-smmu-v3: Do not allow a SVA domain to be set on the wrong PASID
Date: Wed,  1 Nov 2023 20:36:20 -0300
Message-ID: <2-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0300.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: e8035978-1512-41f7-b116-08dbdb336a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	037dTqp5r1yUOqHaAvFkV50qE2WUAdJ5B5QDt1L1N4wxu6Zq/g2QfzTLqOwrYh3WYkyO39B3mF9KAltifLeX+l3SBPEWoc+wNJSPKb3kLWvCEZcPtmb/hKLz61eKpsUuPiLvlN1lVYrk9gXqESrFm97yCcqzKvIq8UQMeqAkbKRpGq/OaOQqZGsWB/iaWJXOblNS3mj7qy/AY7QEdb5pLGESyxJbm83x14hsTD66gnKJOuJpuOhNuFbw4sVrFB89vW59Xs+tI2w7BGjCYvKE8uhPZmD+aTFUz5LFGbqjcV5kur+dI5Sz05pCU9zVsM4RFCcP1nTsLBS0LdeKMYsaoKHa7vV00g4y91MTBOeD+wX2vIvnNYrzvJL0Xdi0GbW88+VuoyebmZsLnD7Ie93YXCuxPVV36EoFvrec2y3cI86f7A74abq5rbhBeSwmirp1Nb6j5jCKl8V7kIZzvYjUQHjK29l+JJlHKo5vN2WBXdsfHRuh1QlPyhCfJHH6avuqXPKq5QGbNmmvpOnWnLgIyXoL02hWOoj0YAenRctQFr1GSeR2MqogJyJ4AfsArA4O8IUPIRu87MqNsdKJKWRBwgn/P9xeAYs1afJP06Siklc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(4744005)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/shs9b9Y7Z2wNSzpEOcsS+NuWuMX6qgtpVYCVRZVWzOybAvmNI5pXnc5famo?=
 =?us-ascii?Q?NHGNeUS+d7O0MAeumebBtHPHth3tLjy7ePZQfDpboPwacrDekS0ETsSAMSGy?=
 =?us-ascii?Q?WH1R3fU2ZbEBDpTzO6YR1z5CGuNcyVbQN1V0fXQbIMCZ5KwnPXnO1poh+aIK?=
 =?us-ascii?Q?4RqIFIzqNN//AyH3Ctd16byIhvTw8K/j8xXVhoCiS+OpeWZfHdxBpNfq/rAk?=
 =?us-ascii?Q?Awm0cqSsw86E3JKp+udvNJ4vhyPbszHKxUoweT+lOFo44v9NObWeLqbZAr5p?=
 =?us-ascii?Q?KoYLoIAwu3P9JNpMU/j7qGSY2ebx9knhbwsm01ubzxy+pgh+vUnbGzsBj4Pv?=
 =?us-ascii?Q?ND5MTPB4rjalRt5a1ClUio6LkdfCoSA35UXVe2RROjC2h7jbfV1fxCYf/5fi?=
 =?us-ascii?Q?ZmjNnSE7XUVs155S9dlHkNIhZo1dx1lc4451UsHUIquyTNffdrFvjKLPJUzm?=
 =?us-ascii?Q?eRP1nb0YhfebwBaHB4yWxgXujzhyPoHjfiblrjgdAjxjBWBdDomu9Sk0az77?=
 =?us-ascii?Q?Ff2bpyHVVEFE+4iXAA8sYg8TDmhJt+4ZVOXmhHYGR8HRBpy8PVarM7IEu9zb?=
 =?us-ascii?Q?yaqBGOeNinn5Ek/cvd6dFSn8cWVsQBitjXw1G2E65GTRaor0a3kQfyndQH/j?=
 =?us-ascii?Q?Gk579EhQpCZdtlRE29FSXSwK8vujYyUlEMgyVDVMKBjx+eRMV5CCDawrwt7/?=
 =?us-ascii?Q?3WoVWE70ksuiwkx5IP3jWjkE1IoTsm/zUmloEmGtjGxDWbQ6j9VRQLDq4Umg?=
 =?us-ascii?Q?qogiBGHfB4/zDb7SDLJPlNNIwSff0qKDwi6VwCuxdOtO8oFESmCwZ7RrczDd?=
 =?us-ascii?Q?NdEOk7lsz1k1uxtpe1wLe9befhBKY/JD3gicGYAYNkA9TNWJ6jh0gMwKhmJH?=
 =?us-ascii?Q?ASYybLejKZ6EAZe6kvEM+/203qfGbbFP9mAdmYAr0Zpl5Eptyas55np0iw8o?=
 =?us-ascii?Q?yEsG/c6vurpaMaf1UfZpGYMCkefp7CHzGq1Mt73mibg3cFDezhDUswY9gZLj?=
 =?us-ascii?Q?DL9X/stZhx/U1Z9Yg0XYfzWI6ksS45Aqvcvdoyh9c86EiTroiXC4K0hQhNPW?=
 =?us-ascii?Q?+bNlaLIPBQ8V9Kf6PFvXzWQ8KFFGLVXsKr/Tl9fxAV0aMIiU82YZVY/Mrb6W?=
 =?us-ascii?Q?nQTEr49e6iIvf+1XFGEJ/P+OqCo78x8tE/0Zig4vk4A63buccbtxnlJhijBO?=
 =?us-ascii?Q?rQdtiY1qxJ3loBTg9bZb4uQ9oGIwn+A08u63y7WK33//wyDGHnO9I/GDzMle?=
 =?us-ascii?Q?y7BPy7RvGSlS8szg1rDQrQtXyzpr6asfEkf7Zh3Lnx9gxa7uBaxyLKBkNgfH?=
 =?us-ascii?Q?eF+GeLFd95MzIxZo2RBu831eYC9hhwj7D5jmIVGFwuBUvdDze0qfxFWrYXtq?=
 =?us-ascii?Q?Hcu0ik8BRBMzeXU133FsrxwqzOM/7ZyYj2vgidz7BRXv41mkwz6QQ/rlCtf1?=
 =?us-ascii?Q?RhdSTWBamhgTGOShEKR85YynLvYt+Y2+T5ho5qdAfMfK8nEBT3zft+TmuBXm?=
 =?us-ascii?Q?0iCnz4OGS/0RtlASdwKC/kv4z8a6SfCmF9gcEqDU0RcizZdgrepOYgpmjI+K?=
 =?us-ascii?Q?khwaS4IW2mXUWNW62JORA9T7YDsTgoEwMuGL9Oej?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8035978-1512-41f7-b116-08dbdb336a80
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:48.0614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdiupbbSvF4618rORkZjZ+HEsVlN6Qzsvi5puu1SToJsSESDtEZr1bSRmA3rzNJR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

The SVA code is wired to assume that the SVA is programmed onto the
mm->pasid. The current core code always does this, so it is fine.

Add a check for clarity.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index bd0566381c58a9..ee3d148aafa26b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -585,6 +585,9 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	int ret = 0;
 	struct mm_struct *mm = domain->mm;
 
+	if (mm->pasid != id)
+		return -EINVAL;
+
 	mutex_lock(&sva_lock);
 	ret = __arm_smmu_sva_bind(dev, mm);
 	mutex_unlock(&sva_lock);
-- 
2.42.0

