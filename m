Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16DE15AE
	for <iommu@lists.linux.dev>; Mon, 10 Apr 2023 01:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV5JTDJPpOl7D79nCvtZUVybw0DOi+IE+3krSha+BgSKU3ozwd9gyOTw7tGlz/TfLj82Q/Vy9rVlTYYKCkMbI9/VBG1jcU/ONf7A3FGoOjhDi5Yr/I6ah1bYtRoXSG4kYyvBQO0kf27S6FOVZ90rb54Qb5fcNHSCnexGLCNo6GiVjkI6FTMELZzZfdit+FjOx+k1JYpH5U6P8Lh72unBzYk2TvEGoSOfcbMCVrH9LyuE7KRRRZSg2v5h7+Ix0s2/Xh0DRz4sjSXiCTqBUYAtzki7krJBU6eDog1ww9eb+TF7Y1SsHPvvH4nB7DGAhnH0TyQ+CJHTmnJKdxj74oiR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaHbDRq5yLhE2LeSv5abprgBYhdCNd5fIiVQ8CJV31Q=;
 b=cbemi6F6+rr/rEHHq70n6WEV33GIR53msX2IjuXtVGpQL3r5QwDvGcy8/oTQ+vi3mQla4oAPnDP4z9tu39FkFSIQTFksWP3f/qxWNwRCu5vq1F/8cmpocRVBSLRpcPg+ZnAqjVK9h10Ab7g+IJCCU9JvvPw4+7envtbsb0nmOkZwrCSxtrkUKdD0+LP7l9Tmd9sbJ+Qkj6mR5GeNwpHHQUfX8hEpZbTtFS9omoYSuAfmi96QxcZ7uH+Z0iOSvHQQHhl9Doq4yxkUpY3VR7K/Ba0G/14Gf26EIdM7pawm1iVm76PiWusnC7s13SwI7FAglfgG8DZfh3Ietqg1M9hiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaHbDRq5yLhE2LeSv5abprgBYhdCNd5fIiVQ8CJV31Q=;
 b=HdS2tDi/hoOxzZct6JgaKRiXfu9u8+J/ji/szqojol5u2YzaojZWAWuZ3ompPzMr/X1VOvkKykn4Ek7zShQ0BJ4qwmsX9kXVxcPPWmGQsGmuVRG1Cx4yXACtFiueEQ6I0a0bR304P6zeT/JNgDq0IxEvKooqkFqEjAZHWZSWn1uku4SmFLlewh5hPcGv7VomkVVnxVw8KaVjR+9OtYgFsIPPb4OlzfjFPt+e/EotqO7v0DS29Nc579KlI3FUThsXzqYilGR2i+iR/Pxy8wF41mIOh8ByZ5LupNzVrYrF4ZuZ6DBufx09ij4sxfv0C954UMMVBTqo8okupb9EWMFqQw==
Received: from CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 01:08:31 +0000
Received: from MW4PR03CA0151.namprd03.prod.outlook.com (2603:10b6:303:8d::6)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 01:08:29 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::c7) by MW4PR03CA0151.outlook.office365.com
 (2603:10b6:303:8d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 01:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 01:08:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 9 Apr 2023
 18:08:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 9 Apr 2023
 18:08:28 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Sun, 9 Apr 2023 18:08:27 -0700
Date: Sun, 9 Apr 2023 18:08:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	qianweili <qianweili@huawei.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
 <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
 <ZC6vlI7onlUgBidX@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZC6vlI7onlUgBidX@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CO1NAM11FT076:EE_|CY5PR12MB6576:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 459a6305-e4ce-449c-a35d-08db39601857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K00kaDwpVd7Hp25BCgiSxNPxl3+277RMR4kuPatpWcP+IVc0RpvCgb+yF4qkFljKIigX8moVuzv7hqpM+TnXYrS4oQw2A27ZR0GsSluRNfU+soF4MAV9vP3lbObJVwBu8GeuTDpt4uDe9IQQWi0+3ABkHHGKYQrw8FNV6t4EU4MO4zuPG2IY+bZhTCjnpRkuxYNpXILsNekVwTCr8GrzBL8WzxQokpVYkJ2u5m13T+k85P7cA2lOmEIwDOuhEkMVt5xFZDjTZ5IMOuP6KfmD2mjlZwZE6ZKESpFAJAKOjIJqaO4gRth8F8BOBqMsGP3ELvm0WuP02x1V6UiKCwoBH0xO/7f52r2y2K5Bos4VEUXt3onnLP4m2uuI1mLSuFCBbpkDXiX76lXNUnRyOaUGh3aiv5M+6MN2ptg1mFyWPgXfSz/mtzns42/WdIbWx9zDcpDtBGmRh4dWjthg2cTGqUnP86Fbj8DKllMlrwsh9UKmcnmhAnwCFd5hUAPFA3aEMFhKONDe8hxgLpzJ/dxsd2rP7vv+YwHhAgvNYet49HnKRxW2Ko2hIZsUYs+HE11hXA5wfFuFidGYUHwd3un8CPGvusJcAVWhI+72J+Bkpe3qwnFWX9RQ+aWVDM4qyOEe1VUveEw5CMpCu89Y1XeeaIjXJCNhbKn29RgqLCqppjzQV/qoju8zweYPP70+Y/ZVvONNW+wxmS9mVCSdl1n2KCChW52a+Ja4srg1Rj+7LFmq+Vc+CiNW3yCmgjGYICaZCTqWM0//uPA+RoJ42UCOMoczsW51ZLHtQdOgvTzQRBzOVJ18j7W71zMspGE2aueg2f+EwHeGoriM6axbzuqWog==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(110136005)(316002)(41300700001)(70586007)(8676002)(4326008)(6636002)(966005)(70206006)(54906003)(478600001)(40480700001)(55016003)(33716001)(82310400005)(5660300002)(7416002)(2906002)(8936002)(36860700001)(82740400003)(356005)(7636003)(186003)(9686003)(26005)(336012)(426003)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 01:08:28.9535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 459a6305-e4ce-449c-a35d-08db39601857
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417

On Thu, Apr 06, 2023 at 08:40:04AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 06, 2023 at 02:23:17PM +0800, Zhangfei Gao wrote:
> 
> > We are using ioctl method now.
> > From the testing, the TLB miss impacts performance a lot, so we use
> > huge page method.
> > After using huge page method, guest can achieve comparable performance
> > with host.
> 
> Looks like these tests are not stressing the MM, just measuring pure
> BW of the DMA, so they don't get into the invalidation regime..
> 
> You need to measure a more real application that is actually using the
> MM (eg alloc/free memory, fork, etc) while it operates and turn on SVA.

Would an iommu map/unmap benchmark test be useful here?

I added a test program to measure map/unmap times with a
set of different sized buffers:
https://github.com/nicolinc/iommufd/commit/3eb417f2cae0234cc801c6ad74de2afb0ddbdf84
(Also thinking about sending this with a RFC series)

@Zhangfei,
In case that this could be useful, you can pull these two
branches for perf measurement with and without mmap:
# Kernel
https://github.com/nicolinc/iommufd/commits/wip/iommufd_nesting-mmap-04082023
# QEMU
https://github.com/nicolinc/qemu/commits/wip/iommufd_nesting-mmap-04072023

To test without mmap, simply revert the following commits:
# Kernel
git revert ecf602a3c8480ba7ce2c7e77c2d15ca873dbf2e4
# QEMU
git revert c726c014de70998f14b8741a6a96e18a2a7bcd0f

And, you can get the test script in the branch:
  tools/testing/selftests/iommu/iommu_benchmark.sh


On my emulation environment (very slow), with mmap, I see
improvements. I'll also try setting up a test suite on a
proper HW this week.

Thanks
Nicolin
