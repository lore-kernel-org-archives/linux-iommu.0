Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBB5695;
	Wed, 12 Apr 2023 13:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1+XdlvPkKCWxxROww21OUEhvGrMX5fKHbRngIKUjLymSVr/mk9c6W/HZ494VfZtmD2lAnbgpKswloOqajE1OfiAv6kU9IGde8UaVJVSgx4YyUSoRosSbfl1xKhTg6vQ+Il6JJnDwOzpsrhQJenn6zI4oN4yDiKhCQii/vJa0/4KgPExm8K08AwXg+aqLKQQcfXhnXDPe3HObt3KFHg+CUaHQ3n2EJIL3AbqBTcyzD28dK/Z6e4Rj57Y+AX2G1doqMM7GThANMa7vdnCaoDAHEznyF8F7aDPOBCg9WqeFNIkAL2Azrl+HD8Fc0EOAKDnZliXvlu8X8qv0C0h4o8MVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EApSze9pJynN3SoWSdBQ4ewzNdKnCssZxnt58PlPcaw=;
 b=aPaUxrQxw+I8+bKoXiOwbGnEYm31cw8Ga5lIEqa9XJ+WJTJAToi5ENgx6SfaYiZpBOVkiH62mdQBOrrhXSFVZOzNsFoMQd3aQ7tZoCP6iVJIxiyKBwsfxmEKXnxOV8S3C09dkaKk5PPY0QCnm20uP2k7LNPQ/L+HTUwxB7kbQkUlpMQ00U/tYjbIbwWnDPei9K924bwCKc9vT8S7z9R+9Dj/V5fJUcx+kAbpPW0YHggGJiR5Swos3LX/PfDGp6CWO9/PS3ySyAkSLzyPe/pwd14lBWYUKSf+4uJns+3iUrKxVtciXzgUiXb32jMubVwOwvhAOA8kxBvnxNdX/8DZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EApSze9pJynN3SoWSdBQ4ewzNdKnCssZxnt58PlPcaw=;
 b=APF2UKpH80e0GLEkuS64Iy6vEHD4laZtO28T0eNygMtcmuXEEMzcqEAICa9X56ifT/K3+emEbI5n6pW02vGx2KFoYGl0QIYd3QCQaE/6B4tXG4QuahMREIm++G+EzSxc8Aweu3joRo1pS9VA0nsraPZ4U6pMpahqDFJSqZlX1H44u4DcgZ4/4GqomvCDsIzs6VvVf7joqNanftmA4KXHno7yp8OGSIEPOr/gKIKp6xG55copEHVKqhwCpbJPKiAHHUiPOl+RzC00aj5vZCgPTaSzmE5driGgZCATE1HkMiy7VuRfiHmcDHLOzyh2QjBowTjjYL8GQzFmBrtBrJAyxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 13:51:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:55 +0000
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
Subject: [PATCH v4 08/17] iommu: Replace iommu_group_do_dma_first_attach with __iommu_device_set_domain
Date: Wed, 12 Apr 2023 10:51:38 -0300
Message-Id: <8-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:208:15e::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ccee3f-85df-40d1-b421-08db3b5d1023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+AUQODSfskBMFMa99B7gtS9qwEUBszonSRV8nv+1U6rR4+08z1pWMn8uH5nLgrKRH9/h89i/oPX3USXsN29V02EHqNRms/Vmw15TtoRFL8rFFlcXunbBLWUh3is/Z2DrTot4jQwT/YBt9FiQ1vTLS7iY+z7al7ZrYnfhlvGRfxMZNV1jsHo+qEkxBMLH/BnblxW+WfF2EFMaUdn4X3JOtmLWQiRyB4Npg3ilsOB+wxOQQFUUl8TpxuKoEIUwxjL8DUSSphK46VfFA0awRVPBPbFwFn9BlaMuV+MHc2Wk7HtBbRh8IO6sSjeVG+Qr5ZOHM+i19A+aiX97+5jGVIaBM/9rKzxaAI4+Y+dAYqNTby2kLUS6MTiXOSzvoGIyXXX+Ri58z0vtzrEIiagYnPqQRmyBxWvMSuYVOiPNsTMQ1T4HL2mB8y5lQMwjfxKOiMKEenL1KAbd9IR+f/TlHPxOPVyjqU0XnuAA61lq1arAVuFx55W07hGNYNQcxOT/ZKnvg6FaAAiFCeh+6OYpUqiG4s+ziibX9FkYBiU/DGe6T59HNv0+eymjnZaNJtWAyv6cH3ce2rmbHQIiy2Gk75rYqgSs1mfwod9H1y7taB+QI54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(86362001)(36756003)(110136005)(316002)(54906003)(41300700001)(66476007)(478600001)(6486002)(4326008)(66556008)(66946007)(8676002)(5660300002)(2906002)(8936002)(7416002)(38100700002)(186003)(83380400001)(6666004)(6506007)(6512007)(107886003)(26005)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RlE4FWAbhgKZJmlemoaKtWlS9lqkOtp0hfIGx3dwFW8DVE/dOdRSch4Afkm3?=
 =?us-ascii?Q?MdTWDbJcW1lXa8G869QkLVnrvwB9cUcTfaSeb03yjipRjPie7um1o1UXf2bS?=
 =?us-ascii?Q?M9Fdx1GBmPIboS4EVfLkluZCkOxwLkcNlnjp+cnKfZ+5U6bmknJuJ7gXnDHT?=
 =?us-ascii?Q?gEeFkfzhCGh1XNKNfeK9Xu5z+hkYpJ0jjJnBpOgjMn5Dr1NJeAjwxr9PkpzE?=
 =?us-ascii?Q?NxEBOQ4ywfhsqFSLm9yn7E/ep9XhktF84D1bit1BMWHNsxThbZef3bXVVXvD?=
 =?us-ascii?Q?2DNPW4Xp7E8mYagWPC8I2f1FSNMXqdRy5HwZkE458k2MRBa0vyuSVfahfOXY?=
 =?us-ascii?Q?NknEWuKexz9W923PosjeRqvStAlYUL6im6bEUt08Ycnw+60SsKvtUpEBq6Lr?=
 =?us-ascii?Q?yXn07FqLOL4a8UOz/MsmeKmrMlksyUlls3Jnjct/iu9IPFOr5pyj+lXdGrAy?=
 =?us-ascii?Q?YV3yqKsbnb22fnDQ2U97AqwYQeMMYdylId8aj0N0ZB4FTAdZYGTgtE13OXgN?=
 =?us-ascii?Q?2gmGr56WaHysg5b3HxM8k7wmpQG3Ea1OUWxZYxvmXjqitYccJMH+5c79e8ql?=
 =?us-ascii?Q?ZbgLdigWoQ871mFLPH7PyhATbMN+dTQrZwwcZk9ELvy+0qYcOn2b5Hy7n9ln?=
 =?us-ascii?Q?jURR5UQyqvnG9UZSWOhORZzLzQ+kQFdFy9Y2AOxb7+6IE9p1ePF+cF4hQSk2?=
 =?us-ascii?Q?vEYJ591EMzQl4bjI9VwNC3dzj8pNNUH29kOy1VN7rCV0MFfOQp9OQAkgzBbp?=
 =?us-ascii?Q?iAjuiUq/TAjxJT6HOi2/9gzAbBwuWz9uRzoWMT1qTuIXY2ePQ8TfWfelmOyB?=
 =?us-ascii?Q?eGsB01cO0/yBrnMh1FJ7fFzQHtEfRRAngyEnSTgk0X62Y5ufgHMX3Q6yOrAE?=
 =?us-ascii?Q?mO8a0ZF/cRzVTgHNLxMVpYlsPJ2mpgEvR+5rqsgljaddt95G8LB5ippKzHtT?=
 =?us-ascii?Q?GF519Io/tToiVymiX6ySZ6cqxQFizD2vy7j7DPq8hLexfscKx5ftfuYaxO8P?=
 =?us-ascii?Q?NLr60TxxN8bVyRlTY5zLKEH+wJg08hHK4xUdXSAWUKvMSOIk0pqraG/MM8Yt?=
 =?us-ascii?Q?BRCrUK7c+j9VLqKT4Q9LRLrsOr7bXkI+YJFYwlLYtYnF5C/UcxRPjye1NbV5?=
 =?us-ascii?Q?zeP1TwMf0BanHsfHSicQuboZG85AleTkN1IzJTdCfi/NQP2SRzxTfshv1Hyw?=
 =?us-ascii?Q?qW2TCUd3+eaIxHaojocl5St8EUqlP8pN7mjulEXkuDQxGQ0KAGS6iRpywjjm?=
 =?us-ascii?Q?00mzyvCLxe/fTgQ2fyZ8axSEcuyPvl2+H01FXvLLmL0vD77EfhRfjQlNDITS?=
 =?us-ascii?Q?+gR4MZbYu8+1tTz8B+qR6KsBQZGWoLpcdwh42WM6779+POuhhtYXsSOeyZ5T?=
 =?us-ascii?Q?lnwyb+dqCFwHI/9VVRBdkEREEy04bB6PzB0laH+ntIZUMgUA/Zots5gE/8qT?=
 =?us-ascii?Q?/4hcm+1YXSsmkuEe62A0u7mtiNS8i2nGiIRyPDTMV7KpMOvW8DWxLeMWHbLt?=
 =?us-ascii?Q?XyzIuZKRCQfkKQ8y+ZJpvOirihISGZFlQGWu/HUEG0IvciwSOk4GVJx3VuO/?=
 =?us-ascii?Q?I0DN2HI00XcB7Y+3rW+KC2577d06irY8efXUwok0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ccee3f-85df-40d1-b421-08db3b5d1023
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:49.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7UsFdNmk5dNgb/QNqNf3aw7LgeJmam94bri73daa8t0wxmDC/e9DFB3ZhPiNqJS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

Since __iommu_device_set_domain() now knows how to handle deferred attach
we can just call it directly from the only call site.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 24b0290d16ffd4..72c3a9c8e4751d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -104,6 +104,10 @@ enum {
 	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
 };
 
+static int __iommu_device_set_domain(struct iommu_group *group,
+				     struct device *dev,
+				     struct iommu_domain *new_domain,
+				     unsigned int flags);
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
 					     struct iommu_domain *new_domain,
 					     unsigned int flags);
@@ -396,17 +400,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
-static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	lockdep_assert_held(&dev->iommu_group->mutex);
-
-	if (dev->iommu->attach_deferred)
-		return 0;
-	return __iommu_attach_device(domain, dev);
-}
-
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops;
@@ -437,7 +430,7 @@ int iommu_probe_device(struct device *dev)
 	 * attach the default domain.
 	 */
 	if (group->default_domain && !group->owner) {
-		ret = iommu_group_do_dma_first_attach(dev, group->default_domain);
+		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
 		if (ret) {
 			mutex_unlock(&group->mutex);
 			iommu_group_put(group);
-- 
2.40.0

