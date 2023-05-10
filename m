Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4EE362;
	Wed, 10 May 2023 01:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJNnrWqGMG6K6DcdJMRnFJ74rZr1YikKmZVGeOFUk7wxD4nYFquho0E+fCncnamI8gsu6xaE0pTNRBBdu0SKvyReIZ+F20fOA9MnBvhmDSGt+le0UITMHnRNPq+r6vmBCsUlw8dSd91M8SHFSuGL467ROofRIT3uzilJNKZykNOJ9MZGX6ujLHxvQsplnIl6q+xIYS1z+a6gCz8gm7f1o7vpcyyI8PGy/8osxtH9KoXpfmrR4cU87EKG2zJPa98iwyn0K3k89NfbP0PKYEVe9zoknJP7jQxU59VM5DuGezWVR/FD65NJYPp7w5pSw0orbpodAG+PfimE60mn6FZkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6ZdfOHYWpcTE5wal51a6k7RJymS9LkwYORnFAn3wM0=;
 b=NTRgJUl9TpqRiWNSQ641+64vhGdjXTDrfga01CCwYj40SYu/5MJ0/NAv5XAUDI8UMXwkxtZgjy77xQ7Tva2zemrY6x/CE4mGH3yOOfWB/qUtJHqNnpBCGpBA8eaUf319BKz0uqXQFr1hch+BvGmH6/uxkdxXXBrcQkAZpeuOSXJbU4fbRs0tiLaikWQHi1LQoiQWe0K237blgM2cqrSVcuIwIeVMKBeJyirxkQ9WrbHQpwgkcx/PVFuElRXD2caXxfRTsQ8rnM1Z6icRILNo5rbMmYv4yafEMiCiPIElHlkN5ea9vJFhpy+RX2jeB7ps1dWs1vn06Wo53VIdpwu+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6ZdfOHYWpcTE5wal51a6k7RJymS9LkwYORnFAn3wM0=;
 b=G7UVt+jAvh4L2vlsrCBFvwiqk4ZEXq4uGhdkD0i4FyTPk+4zXfzKJTpbnxk/+y5MRXr4xFYp+GclyeQcMGiof8iPV8mx6LA49apwoO73ysvCc2/91IdZoWZbrK7Gy/2SLeFIqMIYtdvwC4iID5ywWlKgokSRFG55gjjGAMgjyG1FngnAvLJCRs7WinKijk47oUGj4+wHmNK8uyqEhFPRxziU6Z+WlrkDk42VgWM+DL0MgnUArtbeDiRPrJ4t41lSqIE0STpuGfWBXlSIVXx/GpT43Wby86Zf5qYMFCkwhRvE15eTuJOWbwKo9p7g8FuysNlOHjPyViMnk9O0MELCXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 01:01:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 01:01:24 +0000
Date: Tue, 9 May 2023 22:01:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 02/14] iommu: Add for_each_group_device()
Message-ID: <ZFrs4aK8TqzWL7xK@nvidia.com>
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <2-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <CANiq72m4sGq10s==TPTjN4L28xgHk1dYsq+o1ves7_c6pho_pw@mail.gmail.com>
 <ZCWcd5FkGhpYhCUi@nvidia.com>
 <CANiq72mymifSufr-uBJyVi-7rY2OCtKgLvbxbEQM8MF2bHG3Lw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mymifSufr-uBJyVi-7rY2OCtKgLvbxbEQM8MF2bHG3Lw@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab5d626-6ea9-4a9c-6446-08db50f213a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dZ8F95yOux3GsEsO2YfiAoEFMC+YRQPGfqY/r0iS7UC1YPNiKHE4oscLjnQVjqLq+ZMm1TX+LqM3peKmkwhogoj68yPOZK2jhcKknzUiOaBAbMDHQlk+/NDSEt1ub5jLwr7c3JV2i1H/oix6DdeF20/HtOyn4G+ccz1m6emjj7QKgO+/E4dllqOGBK6bWZnUuJpc/xmJ0zKCG/7jnzcCNtc1ng7IDkAMLRBwnxhokOXjkcPKkgytLQ6W2kX4nHcUKs3Pm9afmoBmv7AHTG065JaObCUmS8QPsR/HvDqiqsmrwQhlVZ+gpRJ5I0xw5/+ZnCotlyzpW0yb1Y0ROlEnPm+DPlzD0sGlDG5B5vWvZ+o5XeS82Wb+lynUy5sUg7tG0+OZgg8f2ktFRzmpZcGtq8Scvj0ACo10vJznL49vpOAmWu7ZyR4KseVbzmeeVck76IrQ3k51PHDAGl3Jyfj0We6YGVag083Q7/xRipkHwt02vTsEae7zxcI5lTuLM7O/T86WIrsNN4Ey8SZnJy78+A6yVjBMVRbqjS8E1bx+5XS/ekNW0Pd8eqDFTnIiaO3c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(5660300002)(7416002)(54906003)(110136005)(478600001)(6486002)(6666004)(41300700001)(8676002)(316002)(8936002)(6506007)(6512007)(4326008)(66556008)(66476007)(66946007)(107886003)(26005)(2906002)(4744005)(2616005)(186003)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IxKKOgsSAXblliCzqS9ZyuxtoDx3fZFVkl/7Wvpxm7aCHHcZ4VWCVqViwCZZ?=
 =?us-ascii?Q?cq7pJ89xcdvvI9o2XMWUPEl5zA7khpbotJW2b+GS1qxuWJVXqdtlaoQPYe2N?=
 =?us-ascii?Q?OocuUYwHJDTQzNmihKIuZVwkz0jDkqgIztEMJ0P+k7sEFPzWHjw1D+ovNoVT?=
 =?us-ascii?Q?OCWcKx8/BDQZnFP2dH8GPujfxfHq+US2guKEcP+sUzyOM9CW13b0TQwNX/38?=
 =?us-ascii?Q?N6M02k2sMEMpBDXQkpIeppvef1VtfqtgKzagq4zJzV0cXlXIkq8qTIQgjliJ?=
 =?us-ascii?Q?BxtTcuoTQ+18hPiI78AHUBbxw+swXsgbQJgg5aJQwIuGnrGPz/9RAl/ti4ts?=
 =?us-ascii?Q?wMLsj7ruMLOO/3MIMxuT/9su7d3/BiiyCgDfVQzu7xbbQwnSQI7Ms74r9bAS?=
 =?us-ascii?Q?rouvrZZ68HqB8EThlMcV/JSLpRx95H/WLsuVo16XzNT0texiATiK/bFrA/2s?=
 =?us-ascii?Q?QHCSAuIUHa39SE0uPqeldM3o/p2mQfo3ZOy8kTwwF9NFp4dAC+IYP6Ozr1wd?=
 =?us-ascii?Q?QV9luZtw0Ua5/J8PzrZ3MLp4Dvp/d+0JloqNbaSYXfnVrKvrjSS/Ag31GCMr?=
 =?us-ascii?Q?YKGETgXsnFU49UaWUbCJF3YRWg1eiP6D3U8ypMUeee4StO7PTmjM1fG7FmT8?=
 =?us-ascii?Q?oPGmofKF8uSHVetrFhbRebumBEJiJVyYmmoIH9AhuyWxw7oHPXWeouudHJFf?=
 =?us-ascii?Q?Z0kZMx72+XUlbB9Oe+p5j2N2B0XloBvLMwAfy/LcdeI7+NV97qyE7aD2eu/G?=
 =?us-ascii?Q?X8iqYrJAuvHNuumxkyopI02RznWj0HYdzrtpqGfJ+WeEz8B3X2p4+ff6cUOB?=
 =?us-ascii?Q?1rJMn/MJZHIGOtloRzcSSO/ebFrxEQE0LbuowPjZ4WjRtaPIKMmg9AnIbhch?=
 =?us-ascii?Q?SnxrPnvoQYt5fj/cjehVkPUkFXQdt0tKR55IafvOoJAOauq/VDyS0f4H01XE?=
 =?us-ascii?Q?6w+PEXGgdRUItbPO9RRwKKJhKRMeZOTERUM/NpjeIEnMNN3HCSd0eOWyxJW3?=
 =?us-ascii?Q?3yG18F5tEecaHki3eAZnkR7hnYGQNs5sQleFVPgjOTX4Vf/iSEK1TuK6n1V1?=
 =?us-ascii?Q?fi+hyIxE3415XoJWBramSAo9Cxewsv+wZcrt1E+45jvhNNm6BX8tjyBinBYB?=
 =?us-ascii?Q?Izx7OVKhyahIMV3PbFPvknkZHiLqC5v1VE5p6KzB9h4c5OetriWPANnTc5az?=
 =?us-ascii?Q?jbPNGmsUwDivPo1Ugd7vZ8KBRt9Aq9bMTcAfjsP6/w5QikBjsUbxTxK2ZmIr?=
 =?us-ascii?Q?xot9kzDsWnsxvLzvHYTu9PI/JbQGNn0Z19g8rz/MPdN7hssIWAu5YAGu9VzY?=
 =?us-ascii?Q?cBqXX3H2FYOt+96UMKdNp8sQavpmGLPqDAzEzRAkN53J+phsbXeW6YRFlUJ3?=
 =?us-ascii?Q?a0FhzcFPw6R3xvHgs0pPz0THghQGTyPp1DuZCAj1Fvd2CJ0MOgff8vA4Qwbd?=
 =?us-ascii?Q?iq3PYZ9GoAi/+chTLv4IY+zUIVFIkZppo83FiI6JoAEl/Zbc1cXqmot1ZKQ/?=
 =?us-ascii?Q?yDhsj7lN9uY1qWYZGtSZZET1U/wm1uy5rcZbpgp6g/tiKIx35IgvS/iiJw+j?=
 =?us-ascii?Q?/QnIp38A+PGdhLskdBqZg/JHIZB0YCaKIFaUvuU3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab5d626-6ea9-4a9c-6446-08db50f213a7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 01:01:24.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66Ckp1lIZ0g+hn8l3Ap3KC/rEOA1hiSReAl6xWH8ZJYYT1zNbPRaBdKbdCW3pbVw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255

On Tue, May 09, 2023 at 03:12:08PM +0200, Miguel Ojeda wrote:

> > Yes!
> >
> > clang-format and clangd have really transformed how I'm working!
> 
> Thanks, I am glad that is the case, and it was also useful to justify
> the change above.

Thanks!

Hey.. with all your clang folk attention - any chance we can get
clangd fixed for kernel usage to not ignore __* functions? It is
really annoying for our usual kernel patterns

Jason
