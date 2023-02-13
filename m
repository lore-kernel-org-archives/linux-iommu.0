Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD53222
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 14:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5Ctf7iJ39Qx89UNRttdXIevwPfk/9JmzDrAS27Dpb0JAB4iIziO+keH6q7he1r1OZ4dCU3OWHFw88W4/g2YN0JUG0owk6VSaX6t3AqOhOq8UBrQhGyf+DIuv2xsg/VhhVGeYmEdPIvBASgfF+0CQk5XSQkTPuZdUN86h2KRn42cFZ5ncfO5fxNmfmM6801yZ7ou/5M9fSbX22+AVlrDjI6GGEAORAprWrjfoussNmwKewjhH7y9TXcu7fCKjkFVCm9WSl/Hj/5Lf4Ap35kQuafy/Wj3VOdjkk7usA/FWMMcmHW20EuLGZTS7okLgKxVcWJ9h00Vl4iBYgSwuHjRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yWN771WGGXSnWmEkztnBB8DtkYZYTcMmxOw4SUhwYk=;
 b=GjaDzBUr3MOF5dDo8gX0LZTMn5KKcoryMbRV0a3QdgKvbBbmgMbjBEbnD4hpynloN+u+SshJw5IZ8v2M3opV9Xhk2iQTq+1v/RuB3ybS7oM8ZSifHlOYqBWsvfCc4882OEyRjC2TIuqvIhjODyqPRagCznBm/awrDmJJvweR6RukelQeOX2DzHSC6i/j9aZDSrad8w0YMCanwDKCpEtZchVtsX0CVMmnCI5GF00rwp0cBPsLBXqcSh0vGl65eb5SFYwX607TcJt/r896ld1ZYA+PyGXUtDH1VtRUeO5U4DTrVLrY99zq0YPwdidSDheJueI+9lcj4RNi/p2aceGJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yWN771WGGXSnWmEkztnBB8DtkYZYTcMmxOw4SUhwYk=;
 b=qsKKxa9HyJzGJ+dx9OZhmIF6zhFY7qblY42K7La0bsq/7D1II0yC6+N1mOgxy7dN0SNmUk3Ggd5XRXizYtG/EqxBrlTqQSGcZY3ET3f0m4B/xiYSDvSIQtHbPm7HrDYYxiXhggAY9WPvUUQdYCkuWCYkoejFrl5uQKkMqgLycVc9uaYmX7RWj4LEyGIacuPBzThZG/rD6oOQkQ4WQOSlsBotJyQM/S4QUo23H1kJxjeAy4DKGiaZ4Uc/thwtY39g6ORXZkZwsPXa4ywjaDRIC3C/eBMUxGl/9KhDAaNW827bGCP1TD0ahIbq1D5Rjp/Pp3zFQ2jPnyef9qkY/mFldg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 14:32:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:32:22 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH] iommufd: Make sure to zero vfio_iommu_type1_info before copying to user
Date: Mon, 13 Feb 2023 10:32:21 -0400
Message-Id: <0-v1-a74499ece799+1a-iommufd_get_info_leak_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0051.prod.exchangelabs.com
 (2603:10b6:208:25::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d460dfe-762d-4404-40cf-08db0dcf1e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	84N9NGSeoMEu7b5WCvBqgxZbzQeqzJyOG1aMyfVTIilO/NPVZhVUG7WxHGuz7PQxGgcSPkjFXKoSc/YJlQBi/FMR2802OdWG34LVRPL2K8uiSuDX0uPDOeWbZEkHOIdUm6vOciaNfy2vKFrnNL902bmoY84pXCxUT+qJspHwUtm17/sHpvOPCbLCnDHHzRcDx9X0m9PDD8PMeJR6tP4JIi59LPtSrqKWqoeKdLAaokHglA/p/y0CRwMx7e6jGA6kxlR2lfO3STaiySistSGaWr5YuoFi0b1aRcvfRDdB7ZiKzSifJ9JzL8Q11CCTD5kjpvccD6QhFfRwBWORngXbnWpkyrKrJ9Isk1lL6F3cbAqfxD7U5QqNx5SzHO6p5xQ7bVjiw3F8fMxi2Zusd85NQ5bR4EyA43LaKW5cWT/X5/GiqKJJ3ofvtD6Cws2XmJikUz6OGUiC566qHpEAy6RhrI7WA/TefmJLwrybc9JPte5k0qulwAjKBUIJtuq1S1J7Kmdem3rWhsdIgyR4Kj2pFQLGnpciav4seQyVyA3qzK2E5F+JBG5IqffCybceKoUtLX6qxi/X6r3wiDkJt08/AhTSgj5mgnzHWBPj+3i7knXGQ/mWkvikH279gBMGaCgP5MQPyHOMO1sSbfimhV5qygoOH+BDqqFD0YK3wyHUgtmZAeGDU9jCv77Sa9VWOupm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199018)(26005)(6512007)(186003)(316002)(6506007)(2616005)(6486002)(478600001)(66556008)(66946007)(66476007)(8676002)(6916009)(4326008)(54906003)(8936002)(41300700001)(5660300002)(83380400001)(2906002)(38100700002)(36756003)(86362001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/+RqcYdXgGjtVNffERkrwTL7FstdtiFDZIBMR4GgZddI7T3bkRdqPWJpSICK?=
 =?us-ascii?Q?ek9EoMUm/eBW8fHzQzXYpwXY5aVajaBJxuAK6F8u3Yg45tQcHqdz0kSbCdbG?=
 =?us-ascii?Q?qWMduD4PF3Yc59But/yCKQMMoU4TLZyBhtdhRYOljRzMUv7GhK+g2XruSdop?=
 =?us-ascii?Q?85FIzoSpIP750pAlb4NmQHPOPeKT4DRAjksKdcB2dRSJUJZDeJ3004Oge+Xy?=
 =?us-ascii?Q?zPCurzIRkpjXSWSy6myLPbbwzpUsMEdJCW2fnj0nrlcKuL8EzaowaXldC47P?=
 =?us-ascii?Q?4mO2ORLSqztzqpTRd73gR/rSTJ04iqZ0p4L//LuOFe/Xj99hqF+oKRa4OVIO?=
 =?us-ascii?Q?u4JRXYoMnPdoAciuNexLZsAd4bsFaJcn4d2asn48S2aDzcP1YArXR0X+tf81?=
 =?us-ascii?Q?gYAyNjQttZoz1VgXyzn4+W+TyuwazSAiizAjPTycB5k8IhRAY/YLfUs+4U/M?=
 =?us-ascii?Q?/iPof3auoVNqTFHGR8suFAYSl5uVMvRd35qKfmm7ihmUaC2hHYexo6sHKd8w?=
 =?us-ascii?Q?2mmlU8C+J8Q2PIjnwc4Znuzfe0j9mxih7OdkZ4a/bbBYsYflKn7ZW43ze/O7?=
 =?us-ascii?Q?sE1FodHKJOrc6tTJvSaoLLtcREMa5jKIsF3f786wDpl4PPeuwGMUd+yLJwPe?=
 =?us-ascii?Q?QapGAVDnL6xn6HrEZTGQvtqPLHucfLDZI3xfFMYthdtuI5DvqNOm1Hj0G6yx?=
 =?us-ascii?Q?NdmZrYjesfmtLA0AI48x+FZEKrJeUbMoE+OObHtKYR+uHiP/6vrmrKv77ZSj?=
 =?us-ascii?Q?d/ol0lfnREbCDYjQy3XfZTvuTo4suSvbs8s7Rx/HfkEjtY4kwegNmM2gLVyq?=
 =?us-ascii?Q?Qj1hrU3jRP3T4SAe2y+J+K8IUGk2HDMpwVupMgtUozmuIsftcyVVTBSU3iVT?=
 =?us-ascii?Q?LdDjhat5NN69ALbOUJ0vANrajeP7SuVtWNXABaTnqbMEiJxPYeCIQbpEtz1c?=
 =?us-ascii?Q?hRsc6GQOfKJ2qz2IIUAIbjwwEiTeL6Pi/Px+s6HBlXwvzH4KJsU+BjE7Amu7?=
 =?us-ascii?Q?zzCIOLpIWviGvECMiyXNlTH8jsLDqfIP1G8k728ccPl6YOq2pr/gtVJXFwNX?=
 =?us-ascii?Q?mLxWXrc3hvf89YxAzYQtlsFSFIewXLf+n7orrnv6t0+UZ7U559e1nkJ3oew1?=
 =?us-ascii?Q?7rS4YUbym7C4WN1l08TZY7TGKUgxcJi2E/bEAgxx/WWKK48Df2MNb8D1XBvw?=
 =?us-ascii?Q?9dtuzhoR1VWNt7Dcs3aguWagk8hC95TeXb0OWJeU4jFEAhZHLiOgX6FJuMB2?=
 =?us-ascii?Q?GboUbvwzN4qX01y4u6+VMC+Eph3h+lEt62CuS4eDirgUSi1GrHMrtTPiBv8x?=
 =?us-ascii?Q?VfEeHKpeP/FVLv0hCa6e22vCeh3AlBdbS3tYxd/SsRu36jZ19VZg0zreviFR?=
 =?us-ascii?Q?pLrlpNZ+x7J+7ohq/JhVPTUw6U4VuLE+B+/pn3WIpQ6fiF/Sbtm7LuGN5Rrz?=
 =?us-ascii?Q?zNPdTKaBX7sgDVSs2tiaNtUxQ1lnaONqDwjyXQRhIvZb1UnYLrWdDPJ29Spz?=
 =?us-ascii?Q?VvC5WjQ7nBScu+kkF3m6FneZU6IA3o9bJhU0jqMmQwRq25c6woAP9OHgr9Ch?=
 =?us-ascii?Q?wM/f1Y8ycdCPffFgjD5U5QqOWIT06hYcArchEj1x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d460dfe-762d-4404-40cf-08db0dcf1e9c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:32:22.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKK7eBnoLmkKajlYtQ/nMQ6l2vmWMqcpE51Bfgy7JfN9L9eSmulqJd5zGMJIoKh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304

Missed a zero initialization here. Most of the struct is filled with
a copy_from_user(), however minsz for that copy is smaller than the
actual struct by 8 bytes, thus we don't fill the padding.

Cc: stable@vger.kernel.org # 6.1+
Fixes: d624d6652a65 ("iommufd: vfio container FD ioctl compatibility")
Reported-by: syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/vfio_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
index 3ceca0e8311c39..dba88ee1d45710 100644
--- a/drivers/iommu/iommufd/vfio_compat.c
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -381,7 +381,7 @@ static int iommufd_vfio_iommu_get_info(struct iommufd_ctx *ictx,
 	};
 	size_t minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
 	struct vfio_info_cap_header __user *last_cap = NULL;
-	struct vfio_iommu_type1_info info;
+	struct vfio_iommu_type1_info info = {};
 	struct iommufd_ioas *ioas;
 	size_t total_cap_size;
 	int rc;

base-commit: c13a5b88359b9c1791e8713df06a40ed8da88ef8
-- 
2.39.1

