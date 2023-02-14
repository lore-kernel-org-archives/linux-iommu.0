Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013872569
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 15:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxrVgWRn6HW3i68Dfw29wuw2qD+fgP/pkR2ad22AY4/OtUh+GOLZLewrZOjzFv0Yp8K8r+I5KLe+hW9VbpDn68sG0cYIUMd1pFCS6at7g8ehGGGgLnbfzCT2OV9OJbZNuRrodvFpirIqwa8372XE5B4nJIj34Ov3dYtWDYzXhxSw3GXq5zVYyZ49sWl9xMBEY+wJzqphmlT6UGtlyvwWLwL02SCkgwqPqzlfOD74OpGjRelAVVGcuWKShL5Q9868C1efS5HthZmnz1ISjM2X0JR3LBRe3QBzEWq9Xj+4casoA0B9Cw8X3YR2EunPMvXpCirnVGGWlicHxxCVdSQnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVoQU/OaCxSTT6dpohUz7fOF2Mx4rRC4C5QO1w2xB9w=;
 b=YFuqIb8JS36+UGbNmM2pdBxn9Ut8HMZuzUPYATyRI5J0gtop7hNZ8FBvjq/iPKe7MqrwSY8CXeYuLQuSD3I1YdaIwywR1D/iYmzS00yzzpYDfDBQdOC5lpUKev9CLgmqSsS3E28KUPKOXrGYLs+Y2dwhAxhyXoJTnZASSELeR6MFjvTScDzl9OPDIaw40SVUAoTTv4e6Rp2wymT1IYInIrpjd8eamJetGlsw8RDMz2FWjemLVlCjq5+1jZPhvJHz8NfStlOX1tlb6+Kmyb9vL+9eSTzGrIvptVfy0FBgThlawJnZgR9BeWQX0WZOZfSjAJL5BwJRuUw+5JFIXxzUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVoQU/OaCxSTT6dpohUz7fOF2Mx4rRC4C5QO1w2xB9w=;
 b=pbLuM6B0Ar1ys5eZL6X8J4ff4k6iCZRvn9m22PW7Tt7qohdNDNVd+oZtgD8rgjmxd2jVgZaO3Z4O1MCreU6E4svxFDXmZaFjYkIETSXxna2TfEUc3AqE88IW41be6U+mPuAQrB6RL6dz4tJnOdV37mjC37UbU53uAZBGe2sdAO1uWY6WNsoc0WsuxUmNlAuAsv+8rlvKAFCSuThT3arInpeXhHpVlYdofHyk5L5lnlmmHzF7VbLDGG4NP/KskVD/3yco8+55aAS5LXVdI1Vue7XBxl20rTADwVMel95600j5YMjGN7iOvJnZi/7Yw+9SetLJ7XOyy+ElNZlXSJrAyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 15:14:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 15:14:49 +0000
Date: Tue, 14 Feb 2023 11:14:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Yang, Lixiao" <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/4] iommufd: Do not add the same hwpt to the
 ioas->hwpt_list twice
Message-ID: <Y+ulaEHbx/uHqx8B@nvidia.com>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <1-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <BN9PR11MB527654AA7B3BE05FCD7A12108CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527654AA7B3BE05FCD7A12108CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0117.namprd02.prod.outlook.com
 (2603:10b6:208:35::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb876a7-82c4-4328-6140-08db0e9e370b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0UgmUh1JAjeuKwFBDk1nD+BUKOkk1EC5Zj3PkidXU5Qtn0/jAk7XvJ5m4+1SN59M1U/m3i4PaXR8VHOwe++RRNXvEfcnmwYWoqlUqvs5oOPAKvnJu+FE83h4j+Q/OqFKT3Rvi4fmpij8+87pSEkil69/W7Q2maqfZyaw04f6lf0xFMnPOCGt+nMNjfm3MVJKQ0dAhg1MTa34cIYm8mFsrzNVCbGqDS53DZNbxhshrylMNY49Zsb2mK3JgUn5Mjak3DgJVwGCvzbTCwOMnPhzksSV4B1NNxabkRYKCHCpZmBaq589XEFWn2eNrVr7pbHeaXy0P23Zz3l9dzyrZVMRnZ0iaaKhsrImK34PovzZV1uA7TwxedBpr3xrJfiBsd7WEGR1rIXes3ea1RQURx+wvXSSD1mN5Hj14lkHjVcKkKhfYa9i6Vrfb7KIfjiXSjwEpHSvMBG227lbWyirRYYeWKKfaU6LZE/U1mfAZIQHHtGjFWAKOQYEy2TcednYM9bOt68IlQ+jLXH3BxLZoR7DHLw1NqI5pbA4NJA2f2iKk53bgCGoCpgsICcPbY0vYzI5Fdi7T2MRA+tFyrfW5ZecEKSiyodS2p0Ld77VEdIuztDE5GnzrQCDYqYHHZjSCXRMkZn/+hB7Mq0MStQDd7gjwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199018)(66476007)(66946007)(6916009)(8676002)(5660300002)(8936002)(66556008)(41300700001)(4326008)(38100700002)(36756003)(2616005)(6512007)(26005)(186003)(6506007)(478600001)(54906003)(86362001)(6486002)(316002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DKEWgi0JhR8Bscsv4sFOK7tGjBVre18oSrIYBStF3y8K+3KXvQxE3ZP+f2UA?=
 =?us-ascii?Q?WLtJTxx3Qy/QQmJC1MZC67zNuCLyveEU/2X+qwDVWWNvYixlBEoMnOW/if8i?=
 =?us-ascii?Q?qhSuqR2VXKxfbfOH21pU2T51jIlyE88Y/6aSRiXB3x6it3PQ3xZLWwrOUqOh?=
 =?us-ascii?Q?isHa6enrls02e7LKZR4TEwT7brc9oCD+EpVhuQRf67sx4w2MWONU0dbWrJ5K?=
 =?us-ascii?Q?aE/rtLQZp8n0oYNVi5K681YxVgmK2Phqm1CZ07OKQEjg5+L+vtUuUBpnfnCS?=
 =?us-ascii?Q?7GOz30U5oPbbuPeVpoW1aFYiGCVrLp4ZISKdLT6VIygIzBVxm8NEVt/xooKr?=
 =?us-ascii?Q?rLeVtdwhoK++f5ehLWJfPclzvQF9izDVxwv/NNmU0B+HsH8OQzclPNJFnMDt?=
 =?us-ascii?Q?ai9IJDWOl3FDmYMZ3gpUrTNtHsD3gL/yfJYZjrAkmn3VW4wShM+0xjqN7sbP?=
 =?us-ascii?Q?Kun+3pJ/we6xidajbED3LMxflY8dtQO6r4Wn8plXBmldcwyS3c429NsmAfoO?=
 =?us-ascii?Q?9BEhZGPda9mLrZd3blDmmr7sZqXgNaqMHEKNhjKmpKe6ALJAu+XUMshDyCMV?=
 =?us-ascii?Q?BDUi9m+vDJSCgSChZJol4ZQmpndmaL7IYCHCt7iA6bp/bKQaNNAyvGMDxiMp?=
 =?us-ascii?Q?7zSzzFOTAzgGr6YC/aEO1cJqlqCic/yFrs9+CBC7S0xpNuzJzgQON+ImJBiH?=
 =?us-ascii?Q?xfzh8Mf9pSmPDOkpHAUVbl+GpmjAmsifNCopSOG2pQjuzdVfyNhIYcnEb8nL?=
 =?us-ascii?Q?LUwLzpgMigQuPmGu41lwIAOyvBLR5F/TWX9Qd2gFsCeSjSNmdOQpulQBk/qu?=
 =?us-ascii?Q?bWntGed3ePgOZrmavnvC9SrLVEDmueNfPWfXs2iCcXsJHZTo12fJGcTnLJGk?=
 =?us-ascii?Q?KHQZ9sdftRhetL6inbmhaeSl8bIWSxDKWW4fUxZchI+9PKSIzEB0yhEvlDAD?=
 =?us-ascii?Q?m6krnF60vNlD8OveO2uyJtmV8yxcJeT+4PuAzaawZvDCIjurQ4GO9c4Ie4mW?=
 =?us-ascii?Q?Ldt/qxauGhPeQt/4epNCxvOoLPdjqs8Ail/JgshpyWans+d96eDQTT2G6heC?=
 =?us-ascii?Q?ny0G7Lgm0jDNcYkHpWPYvrP5dCayAKDydGFmzBVhMen8DMNcIEBBzll0/I3B?=
 =?us-ascii?Q?kcSwQFh1jwWjZ2Buzjqe8Qyaax3ggdAyX8U7ZEtUAmgYbvLFBU9022qfH+IH?=
 =?us-ascii?Q?ee3TWy/8eD+qp38Dvj6a5T0CkCQaNGgVsW6jLxU6yhOXu+A3sgwfrGiVQIZx?=
 =?us-ascii?Q?trNFL9KJoa4St6qMVB1CU6rsE3/sagovcGClp7BB77lb4twZoDZBMUmlMMZi?=
 =?us-ascii?Q?rYWT6oCllgs8lN9DCdlJ3WYpNVjw29opq8C1Z8TqXdtxOReaRi9INGGfZh99?=
 =?us-ascii?Q?jQRRDJM32swI8jjK8yBtkwR34osKELpPF/uYJywayBnYGTkGa/PTGnH17Y72?=
 =?us-ascii?Q?hEZpNIbTI22Yvh/FuLz+j6lxMTfxEeiVBXz2uoeIkoA8ArAB2cwXPVZgqoQi?=
 =?us-ascii?Q?H4W5jLfc7Wyo8LNqDFrSHL3mhG2P3L5iJctB3v4ANI6Ajgn2Upizx+GAWjRS?=
 =?us-ascii?Q?P9rZRDd6JpLrBoBFzvEEDtpHBhiBDPKRcyYD9RYe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb876a7-82c4-4328-6140-08db0e9e370b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 15:14:49.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpnXeerk/c3cHIsPF9Kr0DhkNlXDYq3eYoHyOXvGae8ITYWUpgwlCKWn7MpBsvRN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

On Tue, Feb 14, 2023 at 05:51:13AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, February 14, 2023 2:03 AM
> > 
> > The hwpt is added to the hwpt_list only during its creation, it is never
> > added again. This hunk is some missed leftover from rework. Adding it
> > twice will corrupt the linked list in some cases.
> > 
> > It effects HWPT specific attachment, which is something the test suite
> > cannot cover until we can create a legitimate struct device with a
> > non-system iommu "driver" (ie we need the bus removed from the iommu
> > code)
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for
> > physical devices")
> > Reported-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> for stable kernels this kind of fixes an issue in a dead code path
> where no uAPI for user to manually create hwpt or return the
> hwpt id of auto domain to userspace.
>
> from that angle do we still want a fix tag?

I always put fixes tags, no matter how minor.

The cc stable is the thoughtful one.

In this case though there is no way to formall access this API the
HWPT ID does exist and a hostile userspace can guess it to trigger a
kernel bug. So it should be fixed.

Jason
