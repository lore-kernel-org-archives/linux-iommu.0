Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D957E4EB;
	Wed, 29 Mar 2023 23:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnmG68oPQqljM8LDvG3c5gryogHq2JcI/d5JqZ8Fgs3Bc4B2SEthkQdPj1Fvt4Ebpvt/ZjlcAazpt6UTOS1d8xrACY7vJtM4zNjAvR7EwpuwZrR1iy6UJdwehezopDYMA7/e78+kJU/s+wyxbMmOENjYzckZps6bLiPgt/2kiIX4GT0x8W0qVGz91ah/kyowHixFAOmdb+5RwVw87Vz7AqN0LMNN7gW+bqISnLi0RfUVOxcaj8GB4G9QphKGwGt7PQo/JzRt7D9dUSWDNxk1SmomBuKWTlgVfbGWRm9mr0KuHLh0FlWkZehL9k0jsgCscQtLjnjDogzgiYUv1FlXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuM7moXBu30IjV015Oy5sxLa1Yf7BpadUvSlfrixR4Q=;
 b=fM2q9ti3IAp03I3IJOYbwWne2b781lZTQMkVVDoYiqkYA4NzS4BpFnf5WWYuSJuHKPGlaBWjpfc+sm4a5Uxp/63X6LlyWrVSnhZZA/us3wRu1gREUXdslCUFrPmyY6mmwL/ZzpF2py3hvaePgqQl4h6fUS4urMJIhBmUvYRzarvZil8ztVGZbdwJcn08UiLzSujVVl1sPr31uM0AV8DNO8gt2GCKTldqgG1MI75sPA622JzuviTcmcBgN6H0LFhfeo7U/++9sar4ckHRW6FGZNN1acjcGPEKXWNtZJU2uV/6R+Rqd5/zbcnSiSd3Qx27N63U/Qv7g/rM/XZAPXbLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuM7moXBu30IjV015Oy5sxLa1Yf7BpadUvSlfrixR4Q=;
 b=M//fVSG+QW8qjUAdTprvmZnnUVUPxNWFy45D+EreCcFij+kPV8UGHXRtmZtMzXU7rmRt3uXbIQBNrZJpgIpepVoj8VtoUxA+QDodnYQwE5wCkPjMRPgOzvVIMdbZMEZ/mG5kNIALeBpkmDvUX7ypSF+QVNouD4n7XW9k2B1zu++7yi6QErm7QaX99eeXsMCX3KKbyG8QF5rWdlXuE/TMlhkWp8gBAbo7nfmOQByUymRTL6Z5Snpeb1NQq67/3OmygMHuEuwn0/kxPXTcE/jicZkRg4TSFct3NNmhYpH5JY6wPgoya3a0hvm0hTBsJxEvK5pP9Mp9lB6NFRcmwOGl2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:44 +0000
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
Subject: [PATCH v2 10/14] iommu: Remove the assignment of group->domain during default domain alloc
Date: Wed, 29 Mar 2023 20:40:34 -0300
Message-Id: <10-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:207:3c::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 756c6603-e5c5-4860-de6b-08db30af0111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MSq2hxSw843N80pwGcgWDEjbTeSA/t0qLtzrRVYEd3npd2GkgzITgsIeXzKrpOhzukaFrHZbBtxcBTV4fOjHf+FYWkijlefgZr5FZl2vM0P9mH+1aYP6gpY+0s1J0gVI746SFg3xfR324Is5zWUp0jdD7gxfagB95S2TOZKKuNX1Pm3cQPkDOBmzHnQM7fv2XFIx7JuKOOeLFlJCktIK07DZS29mZVsBm0JhVi6M9t1vaxGtMRtAgdlH1iqmcaDhNGK7juZ40in7V6hRuucIJoqKo/TBKLFeusGvWLDkVvIB9wbeJiURxlCZqnMDGox9kIQO1j6EocNs/xzbkkXDSWsjNal3E6N5ll2PiF8A05Q8PYXs8FP9Lg4t1HOi3UjEoxIgJhrrhJyJPS2DytImjU9sbc69T6p08JeE9Q3sze0nFk3fh1N0z/xA/SosAZLfdCXcZWHegQYTww9AHKHbuP8zo1/Sc77PeRevTvKn84io3QbGEHKkmKZFkIvIlCaZOPi+mQT4s8kTfjPorz66E2yR5TW7mFjtTuORTjZBWpa9qrcNt6zMUMdU97PG8s/K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXVxGn+KF1ptRPq+MifiCmfk+yh3v2Sa9lWuB2D/LW3t1FV6UtPa0ZCkY8JY?=
 =?us-ascii?Q?hFaH7lmBw2AXAOSt6YL745icB59YC1VW/tFm4Hris0PJeg3KNRe3LHmQ8DJk?=
 =?us-ascii?Q?KquffEVTr6W86AjtE25+8EtJpRDND7k1bGasm91kjqVVX5EnjhAl72/POHEL?=
 =?us-ascii?Q?K2QQL7NQ+9JuIBeipg9NrULM8CwfmkxsAq3fOudakHMM7HspUKzMdRPnwn4B?=
 =?us-ascii?Q?RYfQ1rA7jFiYTBF1FIu3YOtqzpCU4MAAxkY4K4r8jPG+s0O2c/APriuDXR+o?=
 =?us-ascii?Q?vWl6p7Uvfk961w+A/n1bX0QGcPXRGyxV5mZh0racYkcVKDWST6LiBvPlbKlX?=
 =?us-ascii?Q?8oCdFYR1WxgRv6KS0sIZ3ASlXwVWKgSrm66VjRp5QeWP29s1wMUY+/5Pp7O2?=
 =?us-ascii?Q?pECq4YfM4tNUzsdGv4cwtxBbRNyBReR9ceuKtjgkYFOItGFMvtfBOe9pTyRm?=
 =?us-ascii?Q?jnmAvg6/daKxlTMHsevQ2QcPpRbcooT1naszL8GbfS054AYAgFBuoqhTh/Pk?=
 =?us-ascii?Q?3VXEgachtMZuOGhgXpPVE8uRscHBoH/aJBGm/QQo/WM3mFyX/D4K7q+GfdM3?=
 =?us-ascii?Q?BwUk5C4NdwKD+lVLBfZsO8qc9SeBHLdxcBe2wliQMETq4RqJvUIxjljjVAwW?=
 =?us-ascii?Q?enkg7xO+hBJfJI3+tWo7KwzfApbaF1kKDaYRU3IrXpLp6DjECBTAQV4otxSq?=
 =?us-ascii?Q?T6NlbGg08xWY7bZhHmz2dWDCFprIwK+xLuA9gJjTtnTfEbweb3ip6fdYYxYY?=
 =?us-ascii?Q?p1+ydFBsE3aNPSkDz0MKT1oj2wITcqqFA7ks611cEYNx3tRbHqebuSrNfOXM?=
 =?us-ascii?Q?moIjhWoZMKoJ+cjq/exkcmiBrpIPYf5/1O5Eh4yegEyiyOUSPfQ3dKR5gMqM?=
 =?us-ascii?Q?hYWa1pjbYBiSx1wimQ27sTrNVHmrgb7lyGByB21NIoSjnLEgyC25Uvc7DJmM?=
 =?us-ascii?Q?mLsPTZaDMFBUMFbY/dMLeknEmTLz7AutIXj9/kZiD/MQEyz28hA0lXfsX/FV?=
 =?us-ascii?Q?ILeWdvc1RJGA9ZPoPpQHuJbonJyTy8lezKTbBKVch04LdlXWJEVXVxTV0HqI?=
 =?us-ascii?Q?7jD2zJ8aI6yMQc4AYOWnFwSvbfkThGcxGo5uEB2YWgFj+otK6Sl7hUJvzD3h?=
 =?us-ascii?Q?dZ5cstMW6bQtSDJb727bXAh0wSyPn0127k+DPhEq/RMJJr6nAReKBsHpvJ0A?=
 =?us-ascii?Q?wBRSz5lzrwJtlTMPv8/tSqfqU6V7a04GS9+Xrwk+8R0qZl8fWPbwxhbWCrA+?=
 =?us-ascii?Q?Hsee+lkI+TPUKOE7f620YSEGW5wD4SGasS7VncTrIwaXvWHUG6R1Z0Ga8932?=
 =?us-ascii?Q?KKpdv4s1W1i7C+ORc62Ap2e9rObeKbvI8ahrZ6/LYP4zYZ9JPf4gM+VRyyxo?=
 =?us-ascii?Q?ZwIaLbvhvr93OUgr9XaPm8LnZhEYJrr9GOl98lfYTee/KHKYVYzPJiC/2qzy?=
 =?us-ascii?Q?+hs54ZJ13IRmV2WfbTvvJyz1q0HlFK/ydf8jRZat7vuyEAIwv2EwvRXQmGqc?=
 =?us-ascii?Q?Zi6nLwFcJ8KmZKDbYGrvZZEgQmsyDa1WRbAFyVghn5KgiBxniKk1P22xy4+e?=
 =?us-ascii?Q?2cW5HEQgiPzjIyfMOm78IZQ/R5VXRebZrtz2N2yI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756c6603-e5c5-4860-de6b-08db30af0111
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:40.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFnBdC5X6i13661DBiGCsBn9HMtq+9g/VMrctWjkdpkWH0x3qWCDFN5oAAuWXVPM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

group->domain should only be set once all the device's drivers have
had their ops->attach_dev() called. iommu_group_alloc_default_domain()
doesn't do this, so it shouldn't set the value.

The previous patches organized things so that each caller of
iommu_group_alloc_default_domain() follows up with calling
__iommu_group_set_domain_internal() that does set the group->domain.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5bbd667f727605..0eee54d47757d2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -444,7 +444,6 @@ int iommu_probe_device(struct device *dev)
 		 * checked.
 		 */
 		iommu_alloc_default_domain(group, dev);
-		group->domain = NULL;
 		if (group->default_domain)
 			ret = __iommu_group_set_domain_internal(
 				group, group->default_domain,
@@ -1715,8 +1714,6 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 		return -ENOMEM;
 
 	group->default_domain = dom;
-	if (!group->domain)
-		group->domain = dom;
 	return 0;
 }
 
@@ -1920,7 +1917,6 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		group->domain = NULL;
 		ret = __iommu_group_set_domain_internal(
 			group, group->default_domain,
 			IOMMU_SET_DOMAIN_WITH_DEFERRED);
-- 
2.40.0

