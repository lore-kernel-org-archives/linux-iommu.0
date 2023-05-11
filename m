Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9ED1E51F;
	Thu, 11 May 2023 04:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUOpn2LsZQdM8Q2acalUdqltevfyvOwPh2nDMw4dNxBK5A2MjTWYZncouDGp/0ct4oMgi0ReNEzVwTYrO9yTPkd5vnM1VgXCUbdnGMXJ76rOP149Gd9QENoD6XhO6j/bf39/QciDOgqxRFFTqn3gZXj+kHyMKmBDL9hVaJTqAnQfe5cLy5CmQIVZVkukMatrJBt+iVXPKnv8cJpH+lJp6ah0wj81vNffSYRgI/vDH3Ntrn1TOfPV+Nj6WASz45VrlR9jyxOlU/pLpMfqjYFR/j+bMZWgbIbKCt7VCzalXvzLJZRoVcx4f87jelX0R+WJoUebLWvvuz+bkCX4Rimfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR42Uo/LYRHxiGQu/Csvnd1cuOkSvmLlhvg0zzQULX8=;
 b=iKjdt99wskmE8HNs4CnpQ9uGx65nDukl6EcLl3Z3o/zPG8ozXvtZBDGDt0BtdxMLvsoYw9kTxjUibqkCv1FbmTaS7QCSVHh8sLZtUvhOcT4E+U53T0liYYwznsQIK/z6jklwhyz406bVALsTwCGqxEMa7x7oBt/FwX1IAvhUqMEIpU3tY8ZsFLU9w4VFRssfBCgMhD7tH+2VufFpCREMbj6/rqlekzGBPoMp1vqgmZOY5MLQNK/CkUt3nCKqxEOqVDpuFusW1EwHHxC6q5RNFfcLXrL9buH6hUIBEQ143ysHy+87LPQFkESMhQN8x0FluE/cR1+wieQ6m2avewAHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR42Uo/LYRHxiGQu/Csvnd1cuOkSvmLlhvg0zzQULX8=;
 b=S1N+gfTS4o4GLq2ji7+1TCPkEJbXaq5vwqg1TK6FkFk3TV+l0fL7Bs1PZU5CSYQr+midFb9kz+mu5fi9yqiCIGLqHQbYsibb1ZzbWHDzq10HaVjp02MfwINKT7GAwhNEv0l3EvLjD5BLEoM2h/DI/96r8RiS042Zo1ltPc+MRpfq1uGn6WQ+qkHesUnGuUkeTr313bKGhs+EIx079AL6ECSZY4DMV7gcfctwjC/d/sd+s2ZSctB6NuSApDJGsdPNjyZqwm2xiGIsUWKsAz0WLQoqMeWlwoWfonvcgqExLt56h5dsbFkfoI3VnNxs+PmTwV/18pwA81f3xtjY5RuTqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:22 +0000
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
	Heiko Stuebner <heiko@sntech.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 09/17] iommu: Fix iommu_probe_device() to attach the right domain
Date: Thu, 11 May 2023 01:42:07 -0300
Message-Id: <9-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b724251-9683-4798-c47e-08db51da19d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SRnFWKxQpofAyI7xLGCuIadZMX7s+xWqZWbGp5Fh+eznAGZbXn9dXSZCjzKiQMvWOs4hOa3UiMVDZ57iTYPrKC8xObYG+MJpoIbCxjvWEUKhSqFQkwYwEYHoMKT8qy1PWCA+4xIILVAQYc57rLBd4MSVJUHfPYSzX3iN7cyQgbOKayHMt6WH1QeKve5sNEu1+eiAY5uYPSHEEn6Q/kgk19j9r7sqiHMstkRd2b1XZZlL3xesDbA9e0PZOCRL2JYlQi03yJgUTCC2uIwxS1LvH4RJsGCUT/xTSIuQh0KiZlsMeALj23voAWKYmA5ANcMx4/6TbRS5gjFnftzFTMcKDHiNuiKdRvUeK3NlJvBvSxlduYwfQu2z5ovLRCErkjz0fqqzlC8dSx+95eVDpuKHi3SH0c2sgo1Vxq5UKQCyxdEk/H1bdxvWp4mi5Eo4uRg9gwQDxKOGbdSOA3+RJCIwt13bSCXKUS/KB1teMBK0CmCnU4fNZUG0lu+iFCnkNIBCmN3FJ6D0nJAVMnc+6sVmINRVAGhsOgBL8rIENxhqTumjb6Ke3PJVqeaMeaMJuGzHs6Rd4wsTm4YG4EI7C9iSTDDfnGTBbOq3LhWqsR8fSCA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWJiJjUPCSZWLyuVeyMcqdRpDgJQkyoxx7UskCaaLurauHV+3QTLdUyLLnMD?=
 =?us-ascii?Q?z7sXJvX3e5kd2DU33BTr0x5iGW4ueRQJYwKIiWQ3eO/7YL/TGEjZWUsCDKs1?=
 =?us-ascii?Q?H+gtdr8BT0gx3W3Ht/j1leqs+DmfAT8uPQZ3N2RRRElr9wVJn20MLaMTvub3?=
 =?us-ascii?Q?hjwXmpz+vy8LHQL/K7tYjtZkyOQQygz2mYtAIRg0OnfkKXd4NnF28WuQv/v8?=
 =?us-ascii?Q?1IVYTfdoQNmcNbTXioj8aDiqegjWhZAuKhBh3EMiA12GASX0mWz3v4ozz3/t?=
 =?us-ascii?Q?hX1Q6JXuhqDy3wlRytHPRx4GWGfXsHwq/0/PnJW2IF8JYJ/4ipukKuHyeFZU?=
 =?us-ascii?Q?DBaNd9XqRtIjT9h+WSnCTHXoylsT/451kpJcQZI5lypIW0fbQ7LBCpBiLgdg?=
 =?us-ascii?Q?TzgFjdq/4BKAB6W0uYm8+O8HUzNYsOwcj94zkeiuLnhSung1V6V1LBmmSfE2?=
 =?us-ascii?Q?KZI5Jfr/LFekCueCVa6lrLx6beoo6QyL/jk9nvGRvytq/l4/TOItcvM8+x+U?=
 =?us-ascii?Q?gr7hWozPcmDsdDW/3uGcAqpelEmDCmW+VVWmvtlLNUgn0mJMtf2IPhuGpInM?=
 =?us-ascii?Q?/n91kCRxRPDlndmINgMlBdH74Ia7k4hTxMZ5iDh3OZvGyLUdjByeaT0DqSd+?=
 =?us-ascii?Q?yPYuM9bJ7246O43d/108z8nGvaWcJmmgZpCie+zMVVFXqXH7zk9IiMF2Xlaj?=
 =?us-ascii?Q?+0bQ8GOGUVwLf6P5sJ0TVhl/4n2btCvAEKtWqnxUFKKdvdjtGSliJDsknDVg?=
 =?us-ascii?Q?8IpRNYylhunUnWAanh2yegmDhOBYjynazVfM0Ct/CKKpKx+EJcpaHM2C2Srs?=
 =?us-ascii?Q?UfD94j33Lem6m6rMsLA9p2VFmMuAalWVtKLQ17+Hyjf0S6F/+F1XGf5uhiUo?=
 =?us-ascii?Q?tzSsibHI7ZtFX9QQXTkAo/fWXrStiJ8fQPm96pnwc6u4BG87a5I1EcmwWEUM?=
 =?us-ascii?Q?Os7X+6ToZunbKKstsjnykFJwngDR3rZQBCcQSChEb5mNpT3c7opK7NDKMwxv?=
 =?us-ascii?Q?OMac7jb9ngXJmxycDO/slEQ4HjHw/01SEa+JH1+6o3NvP1fFaLl+YXJ5arBQ?=
 =?us-ascii?Q?wD9/5OzARiCyhetnBOaqaJ7MLkXAM5eFEexBFx5h39lQqBYvlrPYwxwsV97A?=
 =?us-ascii?Q?U960iEYgUFKNiqOLaZ1Q0V0rF+jZZgiNlBQlpS1fjsPQafO9JPrFyigMI0mS?=
 =?us-ascii?Q?3jgNkPL40F4UzbSVVyBlLTqIZmzdwcEE8SiXGdBiE1LIcU99rVWT9yMKDa4G?=
 =?us-ascii?Q?GVrt3Z9yB99wU/kdqpS8jkDVqJVRfN96g4FLyoivq6ps2xKKYnW0OVz+Gwk8?=
 =?us-ascii?Q?o5wocjee5CbqDa91B50Lxxmm6Temsv3DhqeiZLrBodUkJgl/wj/VYCXbtJjp?=
 =?us-ascii?Q?hDTcFBIwqJeka1E+Yhratk927Mtvld0ur9iNI8kW9+WTjAPvUL3uWP2CmjhV?=
 =?us-ascii?Q?JwiFRsoP/vIe7NzojkK4PHei/YGld4FsFLjKCbMIkG4toouDKWj+FnnpoTt5?=
 =?us-ascii?Q?hVaCt3wf9axprRinXFrGJ19wCr2YSSEqEo6URV+JoJUhTvT7GOFK9/e/F3g0?=
 =?us-ascii?Q?DFR2HYVMpWSFELN0DbCnXViEQLuA3Ix4i+ECCh3b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b724251-9683-4798-c47e-08db51da19d9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:18.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bh7vnObdc6bw0tsYphhNttQoyxY7yg/fXtEOb6R/oGxkCt+KxE+8noXboqsdHQJh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

The general invariant is that all devices in an iommu_group are attached
to group->domain. We missed some cases here where an owned group would not
get the device attached.

Rework this logic so it follows the default domain flow of the
bus_iommu_probe() - call iommu_alloc_default_domain(), then use
__iommu_group_set_domain_internal() to set up all the devices.

Finally always attach the device to the current domain if it is already
set.

This is an unlikely functional issue as iommufd uses iommu_attach_group().
It is possible to hot plug in a new group member, add a vfio driver to it
and then hot add it to an existing iommufd. In this case it is required
that the core code set the iommu_domain properly since iommufd won't call
iommu_attach_group() again.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 44 +++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8b9325565b3b48..71ac5f7fe6bd09 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -421,27 +421,31 @@ int iommu_probe_device(struct device *dev)
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
 		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
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
+			ret = __iommu_group_set_domain(group,
+						       group->default_domain);
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
 
@@ -454,6 +458,9 @@ int iommu_probe_device(struct device *dev)
 
 	return 0;
 
+err_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
 err_release:
 	iommu_release_device(dev);
 
@@ -1665,9 +1672,6 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 {
 	unsigned int type;
 
-	if (group->default_domain)
-		return 0;
-
 	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
 
 	return iommu_group_alloc_default_domain(dev->bus, group, type);
-- 
2.40.1

