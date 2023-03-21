Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B886D52A
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 19:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR+6cfM3z5WAmk3hFTsLG0yU4QQ+4orZ+qLcgKY+E6zX8jYDm+JFMw2p64KRuJPeiVBgX5/nbpKIoQU8nRQnNEiH8XcsMinnK0+Kcalzy2YKNMFVbGGMr68UudMDK5t++gdMFmaForRv4W4qZ2DhsA69XV1Gbik2UEqhmdNMZqdCxJ/ANiHDczAhnmCB/gpHk3Uomd410BrY9j30R/dYzTthkPi8v76ko1u8WRp7j8sT0P9bSA7AL9B62hvecBFnSm1tm++eW3VfW9nFjNmJUWoBW++eog/xRnhuO902PuYHtvbIa52RJXoJmQ++zdOwIuxDf+nbOfyLBsz5y2tJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX5zHJAAGK/mUBRPws8Pmscg13u3EvGXJfwK7W2r2ck=;
 b=Da7FB796I+/fu022aEj0LgWJTDLN0lp1p6+tqKo8PIreEt6Hx472endxuw0oPgmZ9Nu9Z/G+coWgeJjAbYVYPbOaIP7bxpQyT1EuBnxKtooreUkEmqiMGiLdbSjV79GAFG2jRPv8b/v2HqAxwRcBqPzH02DpfWEpSKK0N8YTWMBfB3LDm7M1KH0eKM+WxOJACr+oDqtNPDFAylq4er0cIGUZRUaGY2M0k+S+DZ5OHZRb/MB7P3ZlT+H/mOn6ZYznbx0z3PrKOQPQX5MMX4jGtsOxxB2XfQMOXySz+3RHKOzOcc4gqBnWkBb7/CEUXFU6IDYaChdVNaYm/yFzD4233A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX5zHJAAGK/mUBRPws8Pmscg13u3EvGXJfwK7W2r2ck=;
 b=UrjhWCrATZYza+9LtI5DHiHM0Vn62xqwk14kJE2PsWsaW2VAt1tvPkQQEpY5j1EbQtpKFzXukGr4QaxqfMA9PdjfM+Rw23oaJTLzBdeYAJD4SsjhU6dgbCn5qyUXjVfPw2DdREImXzO8EC1Jb40fr9ErgFNgXSvGGxvm4a8Qz97Fay1xfBDRbcLfYxWoakp99i6Qlfk4srzMBoSNdmZ1ukASC4jYBKfcHPT5NfzkihqzZoBU4Z28sc2z26XYbm5dokooFGIgc6XpU64dSen3VZgWKNlzCbwf5TxlVWeoIR4TspQEr6uErTond3WQPDFu0zWueo90vl66gohegYSQ0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:53:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:53:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 6/9] iommu: Fix iommu_probe_device() to attach the right domain
Date: Tue, 21 Mar 2023 16:53:18 -0300
Message-Id: <6-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0342.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e701ef8-649a-4251-90ac-08db2a45edf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mhcdkkjVzHzwuzryFUJob10lLdZzy3Xzv8t3hxZKZUSKQ8Y7Z8FXMQdrF4YgobponzTdxpcJtbPFFCG8pFwPonvI1fX2vrdB+dSJYZLz4RP/5IbxZ8dbuzcejatAVuzKXIBIcjdVvIfY8FodP3N1gQdi4SQpl8mAaNvUp7I09O5JzlqLhXqvgQXFpfwoA7IJLzFQAQpRvrMMRtGHdH4EItauxcJjOU4XjjeGNedG4ECNXs15lT85P7SDOHpBzSUShc6SrhgmbKHs8+MbFqmT+m9+0IQ/iRH6uw9dodjbQvJsc8jIYnbUPWbwXBK5R0TeN4vwMwNGPcLjH8YB67/e/VRUiX/y1DDB7lH/9KE/Cvn//u3ZVtLPTOIIXaDmYpMC0Zo8MHDG6BKK26uEl1ifyELQOfojmYwPy6vfvEZqzYstiDZ6itNmJ6Vr9Yux2qfSOUf3hty9Cp93ajmZrvRCMa2zBiH7QZuGGhCNkxrrhygoJfs5gSsSyh6qiafPcd5IDQdtuqKTmCmylW2JqISmfVm/i9keAlKBrFDwcguJUu0BZlNf8/K/gyjrydTNMErqsX3NkZUeG1YmLc3m8dRn0ZTt6ggesF+aDXs521F+EQWse2ITh1SpDtRMDBiLH/DobcBxaxLsUnPgpEm/r/926VzwkCyWQ7/BTgZVIH0Rd1LeQ/Bwa0SbFolJKeNwqmY+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002)(2616005)(8936002)(186003)(5660300002)(2906002)(86362001)(110136005)(83380400001)(41300700001)(26005)(316002)(54906003)(6506007)(6512007)(478600001)(36756003)(38100700002)(6666004)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQyxDIJb2PW0xs1w/iYNe0++EF0X7buACTB7cUX4aayuVa6Fm3euesgRl8SQ?=
 =?us-ascii?Q?iVXuxXdriUbRcDxQNfJc9MD81T40LMrJn42os+SNNINIh1P5nixF5YGcU+tY?=
 =?us-ascii?Q?A6ZzZDl4DgNyguDGE2lthgbsZtF58OQV1e00PNrnI/UPAlC0vboIeOq6gQNt?=
 =?us-ascii?Q?SExg7dtWgDfeVu8xVoTKFj+czqRT6C0y1qX/xfr4rxAYL7Bw1AGzZkXmG1+o?=
 =?us-ascii?Q?vZfIrQjvukDVKSGZW+T2MPDkGZNP4vZQ5l7TdngUgtu1BzYuRX+q/pH5CQp5?=
 =?us-ascii?Q?s2vrj02hYHwwWQrVflbcFAaoOSAj2Xtd4meVRjyVzI0tCsvf0uv9v0FN5K56?=
 =?us-ascii?Q?B3Epz2LHFRJOqZGbyaiVv10XeMsCaH7RLlJFL4MITeTVJlJjqKlUKDG0Zi0x?=
 =?us-ascii?Q?JFzZZc4kKy55eHf24aMlxB0zmRAUCJx+lpRwBWmBAgwVtA55CTruhCrypwal?=
 =?us-ascii?Q?VhtQJSYyaIwSQxmMGggH9JShT0CzuxfubZftDlGdxJ8UH1xZVO4RqX2OaRNZ?=
 =?us-ascii?Q?g7uuVa7ROxMXS8ZQpmi810r4TUlmEfto/ettb+EH4JkJ+o0JLhES8APueNZG?=
 =?us-ascii?Q?TBfs3VT9X+WZorEYGTYeQt/YUhnSL5/M6nWzNe5zjqxEyi9dP46OcC3e/qTN?=
 =?us-ascii?Q?hDNHTbwhoA920nbPnzrMpx/W5MT0vyBviKYuUsDOX/AFOo360Rka6wnzuGNI?=
 =?us-ascii?Q?8L6g1cA994/WY1KMu9Lhq6iohrEqlwOXdxb+QiaqoDy9mc4Kl7jtf0EKV4qH?=
 =?us-ascii?Q?QlxRzYhx3GXs4fP4cE45AmUoDqSrnA8RfNCPE3HcLykvOY/XrYtCwQhIHTn0?=
 =?us-ascii?Q?gx0Bggg713BEQ0Tp9jxcEAMRq/Y7TDgrfiDSjJu9CBT4Ce4hrPNmjO+cgJeP?=
 =?us-ascii?Q?mbeBsxCmWUYOjbFdIZldM6PlZhIHTbR2dDtPeJvDMK/Kh176nLxdPoMpC4c/?=
 =?us-ascii?Q?JZgoskidCuVmsZX5i82hHsGPkI/3Klveqn8zY9rVo/sMMiCAlzMfl/pAL5mP?=
 =?us-ascii?Q?HJSAQibG1taErMoWozSErB/EPQ+SvDJTcmKs26vs/EL640ikU89dz9/YGgub?=
 =?us-ascii?Q?qqGa9LNpKV6NbSO1xaqAnopDda1hcfFNL0qZ+TlrDIIVi9g5FAzN4TX/6cgC?=
 =?us-ascii?Q?r77kF6FLLK4xYNBGsKQwtTevXE/ov+1hwkPIj7Elze0FJQAyMt2MU/Qrh6kl?=
 =?us-ascii?Q?qYw7thjnuHa3O+pTimej6dvMLuHs4raUy5dK34V6MtB/x8GHBzNp0gqKYhgy?=
 =?us-ascii?Q?79GJK3YWIgVDTV+nIbeuB72LMWMRfc/WXauHL6dwc8UDZQteXb56Qz1zNb/m?=
 =?us-ascii?Q?o2YEEJx8HFld/UrKFmD2Fn28Bovcaerdmqfzs0ez75GowCD1EjfYkyHewUEk?=
 =?us-ascii?Q?MkXgu9ty2eNTidccKbXkRZBqppxhwhg6PlTyGZmIANogy+O37XAEHhnxQLMD?=
 =?us-ascii?Q?D0dE+YY7IvLSeb5gz1LQf3kPZ/9GWPFxOcGLTLBOqGUC+Z8XTt8ILzJZKesO?=
 =?us-ascii?Q?fH3k1KhP2XUC1O1F1dfhVIunP3HsS5zohgxRRN2nYDCyGN3nYorsHX5chWqM?=
 =?us-ascii?Q?U5KM/LDn2eQ7dujSR5zu9xmZy2AQFehgRSKjEIKl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e701ef8-649a-4251-90ac-08db2a45edf6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:53:23.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Pl+3CMT/oWIkKKWA/FVNKnx4hErliyy/wATZYQAodHBxmyyWQ023WnaTi9YGQHG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

The general invariant is that all devices in an iommu_group are attached
to group->domain. We missed some cases here where an owned group would not
get the device attached.

Rework this logic so it follows the default domain flow of the
bus_iommu_probe() - call iommu_alloc_default_domain(), then use
__iommu_group_set_domain_internal() to set up all the devices.

Finally always attach the device to the current domain if it is already
set.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 45 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ea7700bbcf3399..d58570f361bb92 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -429,27 +429,32 @@ int iommu_probe_device(struct device *dev)
 		goto err_release;
 	}
 
-	/*
-	 * Try to allocate a default domain - needs support from the
-	 * IOMMU driver. There are still some drivers which don't
-	 * support default domains, so the return value is not yet
-	 * checked.
-	 */
 	mutex_lock(&group->mutex);
-	iommu_alloc_default_domain(group, dev);
 
-	/*
-	 * If device joined an existing group which has been claimed, don't
-	 * attach the default domain.
-	 */
-	if (group->default_domain && !group->owner) {
+	if (group->domain) {
 		ret = iommu_group_do_dma_first_attach(group, dev);
-		if (ret) {
-			mutex_unlock(&group->mutex);
-			iommu_group_put(group);
-			goto err_release;
-		}
+	} else if (!group->default_domain) {
+		/*
+		 * Try to allocate a default domain - needs support from the
+		 * IOMMU driver. There are still some drivers which don't
+		 * support default domains, so the return value is not yet
+		 * checked.
+		 */
+		iommu_alloc_default_domain(group, dev);
+		group->domain = NULL;
+		if (group->default_domain)
+			ret = __iommu_group_set_domain_internal(
+				group, group->default_domain,
+				IOMMU_SET_DOMAIN_WITH_DEFERRED);
+
+		/*
+		 * We assume that the iommu driver starts up the device in
+		 * 'set_platform_dma_ops' mode if it does not support default
+		 * domains.
+		 */
 	}
+	if (ret)
+		goto err_unlock;
 
 	iommu_create_device_direct_mappings(group, dev);
 
@@ -462,6 +467,9 @@ int iommu_probe_device(struct device *dev)
 
 	return 0;
 
+err_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
 err_release:
 	iommu_release_device(dev);
 
@@ -1676,9 +1684,6 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 {
 	unsigned int type;
 
-	if (group->default_domain)
-		return 0;
-
 	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
 
 	return iommu_group_alloc_default_domain(dev->bus, group, type);
-- 
2.40.0

