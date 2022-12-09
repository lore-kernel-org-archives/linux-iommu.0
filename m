Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2206D24
	for <iommu@lists.linux.dev>; Fri,  9 Dec 2022 19:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqBUmJw2kQBo9OdGi+hvbnbtKhCEVtLHUYGYNX4JoAx0uSd9jcgPQ9NTKqhdHKdYcWLyShcseI2P3rzD6Y9UrurdAYvpvU0avINh5GRsvEjXE2oVAdkvZdVJNEhrgwkQ5EQIR7moSlZciXu7Yb1UsC4FbTw2glo3qnulHGfD9XPZ81czEgLhLR1c04yS3MdfbqLgqhRd24cgjsR9LFrrakruq2MMJkXdM9YgdSjWCTtd8nn8xF0iMsWnHt64HC7Zze6Uc8kGiD0A6yn/14i1hsY0s60IBFkC0s4GiCjP8ploAciO7seu5IsbM/GPDBvQjjfxKWsibuzgbccSeEcuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCXNhwKv5boOhkd/g5BXxQKqHncnGnkitu0qCeaJ4RE=;
 b=GhY60GFlZLOi4atRsc+nEfZv/w0sjSUouf27nZ0vIdHtkmZJBLR8/vx2tsQUufy+ceiY/HmhfbtQ8sLuwPU7B2PumDDFuNZnHF14ViXPeD+tBBHMqDbK8iL1C1li2qQ/3CuqSyFen6tqNChbKCZP9hlEPa1F2jlhuFCUcuavIV1Al4tqvcWydBZl0hp1BH+ysrKQFEitpGu1qLSX8txlrUkAtSQWwERCf1gHE3hN9tGjXhZ5IiymM8eAgpxHMyy3VzAuy3o/A2KXpKq5o2uxYeZJeukwKBjjxsudfiU11Ur9ZQsiWOuYKNW8ZYYmHLd82zrncuhHKmc7c0msNlePjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCXNhwKv5boOhkd/g5BXxQKqHncnGnkitu0qCeaJ4RE=;
 b=k2E2NoYhw7zX3mdGZvcObVXHAbNG2is1pdBdLFn+yw2mbsKBw6HY78v9TLlPkKkggt90kICR5/8Qd+nexzZh1UGP4qOwwjy9KMbZnqnmJ2qxkohodSmSfRSOpEDFqsJiBvnzIF4gDxXF/SbmQ5Uwo8QnAmNZWbOrD8IfO1PV4u67b6Wue1eYzBkJzHDRgv7jxvSJw92x5UYUD4VLrJFyx8uukkRstGxfXsT3wTEs5WdRukKOY2l9RPKZNIcebIpwS/Sap5ukbFY0pbvou0D7QUh6Mw5IULCgCU1qNak+siknSexRZ506BmnHMCk20znsc8u6KwwpkQRz6P40Xvp5Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 19:27:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 19:27:24 +0000
Date: Fri, 9 Dec 2022 15:27:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 0/3] iommufd review updates
Message-ID: <Y5OMGyJZ1JpqNfSl@nvidia.com>
References: <0-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:208:329::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b7fa4f-fca8-4747-6837-08dada1b661a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	npc4n/zO0iUm7jJBgfdAhAM+F1iajRTcmgf0gaKujGlXfmorLCMGCbsQ95sjysbm6oD12we5KyszS48MHHYNNCtoOhoSLsw24n0uglqyOJmj0jEOUTwH02htGJoDvJgUZ8TEUvgblbkWuoV1PQV7L7CPcS1HpBJpARpfyxNHiCDZUKEoud39WboQRBmAGPhM2E5gbDXE4HMQ2ApYvOPrWzNYtidHSTmKlMvw4hDdTSp+V4A2ukYtqXvsQGhfzihYYccKz+IUJoWuNiCGJzU4ydhK1OQpdn6KxSAed7qv7qjpOZmyv7OYblWj3WNUOEL5ng82wgsStXRRQnV0tFLDZbr0T/SICIoGFJ/yj5fyLWOuUIPYCA+a1NG/BlBFwhANoETItSRWKv7Axu23x4LMQ+grpGhjYgSzr1NU2OruwR1fha/HHMmKmmNwmHBeganiJXBVIbVyFjvrIpGxktApfIw5pAh5tahjvUJ5/3xCel71LQFIpS/nDmhyn7o4RWgoHQHE+sPQlEZB5O591WKdqL7REvR+PKcgCUNzbdMjYtJ769kNItbf+SpZ6SrSgo/M/U76olnNbN4j9vY+ZoBStXVTz8Sn35BElMYiDeJg0T6U2GJagO31AZYDDWlHnGKW+igsD6fcoGNUR05xXx0qxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(6512007)(8936002)(5660300002)(86362001)(41300700001)(26005)(2906002)(6486002)(54906003)(186003)(8676002)(38100700002)(316002)(4326008)(6506007)(478600001)(6916009)(83380400001)(2616005)(4744005)(66946007)(36756003)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d8JRcAC+iICgN+SxP7vSm+AEgZ+Cgwl/QXf1QPZ7AmPj2W3wwz9u6McYsXrS?=
 =?us-ascii?Q?hG1rXNT1qT5zPVjRQyiCy24gMoI4ASjHArnCqW8H5m0+qvshcthMXdUL41Po?=
 =?us-ascii?Q?c6+fgqVqL9zLfQ64vfGTvXM/ud7Tc0aWmAZ//H6myskXlvUOtuW5TsQj/KCn?=
 =?us-ascii?Q?HE+MvOyM7d66YofDeZKOAYsJP59X2s3VtSYyGsYqL82OW2ZzZtQdDrluZxdZ?=
 =?us-ascii?Q?Pkz81FGLAHOQpd2Dw82H7HjDWVuJhgkxymjBWX5CkAAqcq+Yyf37hwi10JTo?=
 =?us-ascii?Q?iKfExH79E5LTBkwNbCwJgF2dB/JETZgweoEpDr1pOObbmWW2jIYRdpeY/hqp?=
 =?us-ascii?Q?7wqMdufLqgNtmlr/oX3Mgdjq+ADnf8FGxIWRCDNjAWCQffpRp60+JH1Zr0D/?=
 =?us-ascii?Q?qcVA42s7iafTrHLQHDW+3fFOLYqq/v/02wGfBEeulyC+ZyMRkmdLk0giyap7?=
 =?us-ascii?Q?XSekbRfnfDt/d8/4hhS5FvmhhkVS2YmunSmpgkUDCfNA/hX57VjOR0e+oG8M?=
 =?us-ascii?Q?hXR65+xBMztCkgj6VO+Ioo7f3YEKdzolcnnVkaKvJA6+uCOnvAgZYc264mTD?=
 =?us-ascii?Q?WfpsRfpsc4kFFdLK/Cc2fskka8a0dozRN07y8/QB2labqOxcJaDQ7Pm0ok1k?=
 =?us-ascii?Q?dXTlxC1BA0nH5Co7oq3aiIACXcqGcPwZtiZnX0ipYCBzvhwsyW54kIkeUKH4?=
 =?us-ascii?Q?BtmhMeShro+niDUfzVzSyMKC24+neIgFNZgHz89tS6FsMlFjPViGVcJke8Z3?=
 =?us-ascii?Q?X0Jn7V065xf0jphjqTJ59svKLKf0mqHJZPZskqOR2SBZkuxs52zWlpbt+wSU?=
 =?us-ascii?Q?mQLFmAmkZG/rqLqSJPwTcJY8iUSUZqZZGO9nWvCPUzw3h0JOfxlYGXl+mS5N?=
 =?us-ascii?Q?P/qYnCgJAIm1T6i/NcwEUzA4yma4ZbibEoqIQnwMw+DT65pNRHqAXSqMBvbG?=
 =?us-ascii?Q?fcuNFcURp6N+ncG5/cbUtSsKZpHZeXXmg94xZmbb6za0USX1e0h/hdag+nbV?=
 =?us-ascii?Q?Dk0aF43YbYMV2yHIbbBwyXIuTA8pTZvX8H2Pm0lI/m1L5nZJy5VGnufSflJs?=
 =?us-ascii?Q?g+7GMlSjfl7UIOW85Xxte+77PGrYHMpFdhAPiIEWph2+KgUis1x4wJdr366x?=
 =?us-ascii?Q?/3NQtnpGTlmg7q0uBRCLr2NheYCcHT8XfnK4CHDHz6zplfod/XKLcIPMCq3c?=
 =?us-ascii?Q?zwwBRgjTc1v11OPQGwpdajSR0vpYeIHvR5n+odjBn7opeyYnNco4dGJV18Vd?=
 =?us-ascii?Q?0lHFfRVYruzLtc3rnzMgqs7CXOcHTW7tYXWVnmiY4cWX5nRlfI1d8VXHC+En?=
 =?us-ascii?Q?nOZkR18crgK4mANiLjUOQ0+T9+fuHHXmfC8YeE4cySpGuAqrPLkLFcJPATnd?=
 =?us-ascii?Q?tj2oNRguvJTWsip+mTwJK4lZS33mQxyxXeByDK9Cdyw3RK2tpfCXAmuJJf2w?=
 =?us-ascii?Q?svzqSQZ7yzovyykiZUHU/zt2RqNEa0qWUYmi6wYiJWgSUggL8Oik1hPH3+Kq?=
 =?us-ascii?Q?NZKLs8S1fVqocbW0Ty5xXtVZj4ZcLsXF3yqNvqJhU3j0I5wwny3+kLeCcmSe?=
 =?us-ascii?Q?CLO+LJWEAUZp16qG7RA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b7fa4f-fca8-4747-6837-08dada1b661a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 19:27:23.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmpKlg2hqNca6aCgAIgwUngCKMooud3k/FOWGqFxCsxzLfQjZacy2L6tXW35VhbN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425

On Wed, Dec 07, 2022 at 04:44:40PM -0400, Jason Gunthorpe wrote:
> A few patches from review comments that happened a bit too late to get
> rebased into the commits.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason Gunthorpe (3):
>   iommufd: Fix comment typos
>   iommufd: Improve a few unclear bits of code
>   iommufd: Change the order of MSI setup
> 
>  drivers/iommu/iommufd/device.c       | 54 ++++++++++++----------------
>  drivers/iommu/iommufd/io_pagetable.c | 24 +++++++------
>  drivers/iommu/iommufd/io_pagetable.h |  2 +-
>  drivers/iommu/iommufd/pages.c        | 11 +++---
>  4 files changed, 45 insertions(+), 46 deletions(-)

Applied to the iommufd tree

Jason
