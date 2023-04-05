Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8ED53B;
	Wed,  5 Apr 2023 23:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/XBSopVJhJ6hhHFPpqEmjBPfvyuNpucJWut9ZjbOItlrDCbrxxwE6OCmwysuJZuG+NtsTPuUGIbvKop0g4sPghyJTldxrRf1SJydOXveecCauvBCesLcQRFcaQ6SxWp4USYj1fMEDmQWVOaz6yX4kIll7IswQHd+VGvlEYUOQz3z5APZ8feB7PG66XexaB9nHOP4TP3ayy3AMEGOolAI39LHqGa2+bjpAXQY4xROgVdF7aErqRauiJqwZ3L+KfAKjP7HYsExKYOcrpkdoIxgTKkFhIgaRApNACVOcd463XIqeiJMmZ33HHi0knkYcql+Ks36CLl/83RW2nzlOh61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+89aOWGKFgKQT5q+L5+B5prnivsxy80JksVZU2345A=;
 b=XbuxEL46EBxCCK9gMooGJZcpk4pLwiY9bk5cQyRufKwViJGUNn+Vmpnjzsd+F6p7jO5Hd+8QgfEmub1sSeg00sKguz/vFG8eL8vCcIy1hxFclLk9+6T2oIbVj5/ZTY1pH8thtP3Ou4oILJt+di9NUJuqf9/mrC/jjjuhZFam1IRVeqQdfnbfNyEl2NVps16qSBk42+Y4hSbXFNx4SOm+lb/dCRpt8xbMY/4vB8snvbJxqZbwU+HH8v2hOPRR+XGn28YqxCKGu94QnyzM4wZac2zT0XZQGv24Q4F77N+tauyXCaieLWf59AgJ1L0BZQpHtbfzcp8rTjzFI/KR7bDgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+89aOWGKFgKQT5q+L5+B5prnivsxy80JksVZU2345A=;
 b=b2ZPD5RqWBzWvj/6uS3zX0EvND1iqRY5BIuTmWG4/nKv6lHzkq4T3weYSdzXh8DEPeG14JIyzU2NzPyUxgy9IK2rizGJk95fzmpghx/gkHRueZHr5C83588DiYXtwysg9rz9hmlu7mRVIlyvOvMOfhZ2gIM6BVrnfavy/CqbCbqt8b8aUhOFVsKs9bFCAgqMA8UWt3H4aGQNg4ZACgrEG/wavuKO9WzxE06vwSsg1scNopbRowvfCDBwU1t/L31IHNT4xxiJ64FJE8hNjYXJ05NOL8VT5rx8l+ovNnfe3TatFN64Q/qsXPvFJqAIJPmLEUJO7o2jO8WkjgG8nmiJBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:47 +0000
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
Subject: [PATCH v3 05/17] iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
Date: Wed,  5 Apr 2023 20:38:26 -0300
Message-Id: <5-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:208:23c::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: e190eca1-b8fc-483b-2a4d-08db362ee3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wQ7dsX+BT0UxLUa4Vz64Cg2VmmbbWgt1UOVi+PuPCnGbQXtkirxVGj6JX5hyypayHRjG3IKpYlv0ELLaIvI/CpO+FcSgUEiQk5k/nIz+TOsdoyhe3DmpgGNozqqcEBosI7qoxUZQng7FPVc3RFQpRPllqRP+rTo80tHULbrTz4vUfDsoYbnh4/vWqtRQZeBLNII0BvCKL5wjHEcx9JlHuPkJxYRpcyoiXgXh4UXGOBHrYImbI+moXLD/jXJYJoD0sdoCk4tFl6v4X7nqwJs8d/bj98fnejIMYZmfFj5jv5f3OvpVX36B7DV0CV3hbdvnhgkayChD4vVcVCEEj65phL5Nitn8cM5PB4QFe1lFMxpT//lBVpNXgPM5ffE46OxzoDd/bZU9AAwOol1w6NUat9CWAv+1pLy9+pwIalatFkOaOpIN/kOQNJc4ycMwPuX8pXciee6Q0F8vczeN1vU7Gsyjl5RvYmHkSapbzBsVAfrWRKd184IGcKJn+90V4zmy7fLE8dSVQe4e9TmQtGOmH50ooUy5kWU5gQEdCYBUWwUwFbJaxLjb9wo9rDkSusjVrIjEx9+kixtlt4Rt86grnJNII9gE3t8pAl0KYyG26+I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7gChWzBPaBFp+E0V0Yd/h0800JbiHpAnNeDJGFLC1nMyncargzVeTcmPhyNZ?=
 =?us-ascii?Q?aS8TZ8IDgDISOlkGMFzad43WVYF+N2q3x3xyD/tBBp3RxdB7NmoCN8rh0eMS?=
 =?us-ascii?Q?WNVMiozWNyL3+t1jTCYpY7UA3KT/CDHDjmAnscZdcKY8GWPVpbF7TwkpS1E+?=
 =?us-ascii?Q?FLjJT68PfFtfFs352pfmymcxJP4QVISQQdslggoAil2VGL0BCLyqw1tHP4LX?=
 =?us-ascii?Q?zx6lugz5lOdCeEZMOXFT8qtQE2fam85CNVMdnzgXied6f0Yea7j1TGsELyYL?=
 =?us-ascii?Q?q9VKpr/u/0u9zj5AbypqvSCIcN3FcLA2gnn2f35vzr330iK2Vn9a443I9+bl?=
 =?us-ascii?Q?wOydcuBuZcSNW1lZnE84XWlXRSKk6to5uUwH7XNw1S2JgmN08u3xqZ9310G2?=
 =?us-ascii?Q?sZs+CihGtzjQfErwW2f9vEN+wukEdyCfdqsl9wLsFFYQxUNAMwkneNha+oLW?=
 =?us-ascii?Q?nHtejEjnouqVIcWaQlFUgLqC9PkVwcSGpD1muMoHIwxDqOqAi7EO3MDJ7ycl?=
 =?us-ascii?Q?7TE3C94Wo/KxkxGmZeJmLzgoEb5F/e7pYysQ2ep8+slTLvnYAQGXcBzy4Iqf?=
 =?us-ascii?Q?SIBwdjbd+vBsJsfl0mcdBdHBq9c2x2C2THxfAZltqexwnaNfla2Di1HXLTTx?=
 =?us-ascii?Q?MFj6hYlftiEsu8Xl4zrWghWq1L1Gy0XEABA0tGYbxv2mKLR2PF2etimWUyTS?=
 =?us-ascii?Q?GFNDHSPq6Iz0PUWSVr6GamR6bU5ZM/86iw/4yCjzRI38lIMr2FB0jzfLuedo?=
 =?us-ascii?Q?inZLYrnJ1f8MObIDsZy45LV5ZjRdoHvEhL9D3Rlq+K/8qVt5OCwbafWW25US?=
 =?us-ascii?Q?Rm1c9UBG70pKdFuijoAOg8H0Qu3p69RvDIgm18QlD2ADJ/rYSV72b21ZgAYr?=
 =?us-ascii?Q?moNbgA1iMIWbYBrby6FCDT2hXXc6+rvozKOTKJq1Z/eTxOSY1zTIGND/n0dM?=
 =?us-ascii?Q?EGJyiBi1HoenpihlqK+Rsi1SGQuZppFULoKVz4Pc3fEg1qt1RQ8ZGygQzSPu?=
 =?us-ascii?Q?Xg91fV7ewux5WTfUJTpQ7nrQUMQegLa2AwjcCB9YlQtlkdWmWCbBRB9nC8CN?=
 =?us-ascii?Q?hU7SB41eMoX1I6kxqEYjbKnqMf8ljX4bRnDtoz9pYJ3IBnEBYSkPZHMq9zJM?=
 =?us-ascii?Q?mLJ5Ko+bpqkLIYLfqJ2oh1Y2/OWOxV6hj1bBcCYu/BRkdJUeXS8UsKzvoFcs?=
 =?us-ascii?Q?GTRlLTDMlwGpF+v1B8hWB0dRkUJPE18v6QU5nXei9ysXRKyI57GtxUJb3n5Q?=
 =?us-ascii?Q?JyFMNkytFcve+o2tO9c8WW6fJssJZ8gPwDYjVIg/mSpZGhJznjEO6NCTuelQ?=
 =?us-ascii?Q?AxLCIveTSTBUWrthOE/OcvdafEk/rYqvMB7jpiPjryOavbD9t7TVrp5CoULN?=
 =?us-ascii?Q?P5wNOvIGxmqqckx+NT9nRLR7ZGghiI+qbUqliSqxAJh1wHjcqBFt4wURrTre?=
 =?us-ascii?Q?sIfStvbP2w2pBdtaJUw7Vm5kZeTK7K+s/Qzd1IehBU3cBmXcSd/6N1cvrr/0?=
 =?us-ascii?Q?Efadl0yzK1vrOKi9VHSiUuKGG1jh+U8MMxDgRfpsfo1lCet45Wgb8S0c5ZWV?=
 =?us-ascii?Q?dybAlzjHQkjdWyaEHEdWNozZCznBIzyCCSnJFfSO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e190eca1-b8fc-483b-2a4d-08db362ee3b7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:42.1271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3eLm8ZBL5uPpjPir1bNqkdcppkA4buK8s1EKmDESeDE68nCZmi5YM4BvaU8TbR5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

This is missing re-attach error handling if the attach fails, use the
common code.

The ugly "group->domain = prev_domain" will be cleaned in a later patch.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ba9e988293f23f..cd75d7405a3051 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2963,11 +2963,12 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	if (ret)
 		goto restore_old_domain;
 
-	ret = iommu_group_create_direct_mappings(group);
+	group->domain = prev_dom;
+	ret = iommu_create_device_direct_mappings(group, dev);
 	if (ret)
 		goto free_new_domain;
 
-	ret = __iommu_attach_group(group->default_domain, group);
+	ret = __iommu_group_set_domain(group, group->default_domain);
 	if (ret)
 		goto free_new_domain;
 
@@ -2979,7 +2980,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	iommu_domain_free(group->default_domain);
 restore_old_domain:
 	group->default_domain = prev_dom;
-	group->domain = prev_dom;
 
 	return ret;
 }
-- 
2.40.0

