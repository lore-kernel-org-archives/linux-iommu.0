Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BDD63AE
	for <iommu@lists.linux.dev>; Wed,  5 Apr 2023 15:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWnk6aAdcflei9m6ihRBbr/nTGKC0NQZxMcdq8Spr76gt9Ld9AUowIZYc3XQnazpAl0awpC/Lf92cQ9JqM1Jk0aadUXDzEUUEthLo4/1Rq67LHGwhvAJgzVwiLTDOQfDmSmh3p1V9C4OYJpM2cvkQHAidx4Nx5+aaNxU8kx5B2HEDwTnYVZlhpLPUyiFr17PYzQ2h9T1dLbBzcSPtjdi9sJuQ60jddt8EtHgT2bHsf/3xUuZe+bILTt/+LcycasxKEpy4g3T0QMgK62ch7pDBeuMaSgEbk9BFrPMi5QmRdY8lxbGdknE5t8V/CL52l9RST1IBcm92QFI57G5MGBlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqoriWWPefpEcCopb0qrRNXkxGjaobaPrbr1ciIwuRw=;
 b=OHcct6Nec3TIo/ZET9js/RxmgS6uTdj15msMV3F823o4pWFroTlPIZOkicb5TLBfky7lhqJVTVxFv5X1l6H/qR03S7Seh0WZ2p3yKrGWfbETkrqJuY53Z1+l5iePfLRCoVUodG9DIIzDvSoUseNslsch92V1uUKecGn1oLHiy+yQ1C4fFxxbwj8fhZDRUXMhOz7KQJtcdYULoDqqzRHKe5IwxsmgkHI5MF8uEt1m3Ams9QgfPz31VVU4I4SBZKjlpwIhVqNW+3tC/SMFEzebihdu7ROvcNfyGNTwQe2RoSFg8aLo+HWl6V/fDqD4Nb/zgEseqAy3okFkLreBARaP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqoriWWPefpEcCopb0qrRNXkxGjaobaPrbr1ciIwuRw=;
 b=MG8zpT+A9RMu7pv79YdTfWEXL+hFJDjMGVaPc0I1RHHBmOCN9GbmF8Q50CkR4ydD31RCoG1TiK+Mh/lyvRUp7tg2C4oWjHef2e9FTjnRU+G83UD1orrizY8jDtR5i49w1iRC4OTJZLeX/nKEjqO7Yd8OOUB8s+2PbYnzk0QVttyvqGhFg8N5KyZncAd56t7PY+Jy3143ShGEEPjHMmg0Dt9YLSMW6CB8Q2+VIekZ4BtSf8rV5X9U7jCyE4nDozVRQmFDF4te4xVYgq1GmDYd8ECRmSqlVQONn6d1eJ+FbDdTxVaRKl5N8q+nsBxTMiWI0EuvQ3nOtzfDmAzLAzANpA==
Received: from DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) by
 SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Wed, 5 Apr
 2023 15:34:52 +0000
Received: from BN9PR03CA0070.namprd03.prod.outlook.com (2603:10b6:408:fc::15)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 15:34:50 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::f3) by BN9PR03CA0070.outlook.office365.com
 (2603:10b6:408:fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Wed, 5 Apr 2023 15:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.30 via Frontend Transport; Wed, 5 Apr 2023 15:34:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 08:34:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 5 Apr 2023 08:34:37 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 5 Apr 2023 08:34:37 -0700
Date: Wed, 5 Apr 2023 08:34:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <baolu.lu@linux.intel.com>,
	<shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
	<iommu@lists.linux.dev>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZC2VDO8pX5oVFs+2@Asurada-Nvidia>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <ZC0LFM9hxF9wY76w@Asurada-Nvidia>
 <ZC1dlENobD4wlZCv@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZC1dlENobD4wlZCv@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	BN8NAM11FT056:EE_|DM4PR12MB7694:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c96f9f-75d4-4ffd-adaa-08db35eb4b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vAKHqxFirLqyv32XcuwlAzCvzlbpODxwlv+cNImziRJNIdG9k/dDmd7vq/YPCIRz/5Yrhrtz+sgJ+/9nq37cnwRckd8fDQR1oIvYqGKiTXr5acyi9XPBp2VWckbp3GIBHbk/8eELCt/KD7CTQXIE6xXjy00EOuUbUKoVT7YKlFijpB3EChgCOKyk+njRpkbdYHpv/b+ddJlmE7BnQfYROqhNNsykrdR3nZTOEWGfv7NzNanz5sSUGWqmpjZA9ypcg828jDekO7dO3GGIM1idTn33mRUcB2DNipzPQpVJT+UT0UxLsa6AOYCFeNyTBehkD+FWa5dct6D01eugCsQH+PKtIhwyv0jq7iewmRjJojDnpkQQ4xNuQtvpF55jPr/RX4z96kFqiv0ZkBD22Ax+JfX5ZaRXUcJnBHki3pHf91hUSAQIIM6V4qYf1QULKSbBnFLFea2Kmwxwz+rnIh35fEd2lWBXxfTa680hQfX9Aro0R8LXlLnkXlKJYQ0mSHAoaesqf13W4tTIh4FKCGGQjRvo3DV0tDLBBOKbcYT4oiKz/Vx21LNeH3+lqesp9ejOQrr3DSj2QJ6E4yudnoowo52W2f/3yvt5iZ+g7bUN+gO3wfn/55YjOO1xSWWGtsNJZ4sVs18O90jCTqjYLPTUiEuQG1NE+BVvdByO0RN4kURFodT0XebugAKBbo4ilLqEYGgg9yzfAPLZubedHHSk5Exr/PbsJ8HML5Pb+J0GUuPPHr0SbxQGz+DlZDIvy/SNQ6/F+zpq4obftIqQpg5zmA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(55016003)(40480700001)(40460700003)(70206006)(54906003)(478600001)(36860700001)(6636002)(70586007)(356005)(4326008)(82740400003)(6862004)(316002)(8936002)(5660300002)(7636003)(41300700001)(47076005)(186003)(336012)(426003)(8676002)(26005)(9686003)(86362001)(2906002)(33716001)(82310400005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 15:34:50.1271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c96f9f-75d4-4ffd-adaa-08db35eb4b7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675

On Wed, Apr 05, 2023 at 08:37:56AM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 04, 2023 at 10:45:56PM -0700, Nicolin Chen wrote:
> > On Tue, Apr 04, 2023 at 01:20:01PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Apr 03, 2023 at 05:02:09PM -0700, Nicolin Chen wrote:
> > > 
> > > > My preference is to have a mmap'd page, so the interface can
> > > > be reused later by VCMDQ too. Performance-wise, it should be
> > > > good enough, since it does batching, IMHO.
> > > 
> > > You can't reuse mmaping the queue page with vcmdq, so it doesn't seem
> > > meaningful to me.
> > > 
> > > There should be no mmap on the SW path. If you need a half step
> > > between an ioctl as a batch and a full vhost-like queue scheme then
> > > using iouring with pre-registered memory would be appropriate.
> > 
> > I've changed to a non-mmap approach that the host kernel reads
> > the guest queue directly and inserts all invalidation commands
> > into the host queue.
> > 
> > The qsz could be as large as 128 x 64K pages. So, there has to
> > be a big array of pages getting pinned in the handler.
> > 
> > (The handler still needs a pathway to report errors. I will add
> >  tomorrow.)
> > 
> > Does the implementation below look fine in general?
> 
> In general get_user_pages() is really slow compared to copy_from_user

Will change to using copy_from_user().

Thanks!
Nic
