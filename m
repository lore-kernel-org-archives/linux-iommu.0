Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13EE18B16
	for <iommu@lists.linux.dev>; Wed, 17 May 2023 14:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZtBIiASfWtC5K1uRpalKxUABx3OJxJKfgbY4wgDtP5qCTu0gGAE8F9JISXP4/jPkTpfhIHO16QajNmg8JMrp2cNu9ReJ0tItPqywqehnjU7HZfXKl4GWMZDuDLzDoH2aZKbrSXjVDLdr/SksSSccli1kKXUUKHggr+2lDNo8UJiYhzZLRPeKM2GjeNchm03tMijJJcDu++Lf1FEIg1hp+TCDQAMlBKgH+e8fSpHFL0nvGICTVnlBvtfnlgsUjK1YX+S/DMTfsBUjvDlZlWK0SqrN5e+Wxm2KtcW7UA9qT3Cv2hWJMwOlWS8sCFp6d9OW93mCQbFiL3/a/0KSXcjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DxDQOcH1zMrijBXD/upCvAYWtmq455mB/3OPfhBNO0=;
 b=aXyOlIgvc3LaVg8RbJ6v2vHWVGdenARuWS3/iPkArkcpbHObF8cTxaJljb7x62WV+Z6O0qnkqbmYopRNFEvG3D7c0Z2xNfqdnSyveXLEAR2DtT/AAJQj5NrIblQgxM0n0JzqAvi1w+gs81nH8J/RZql/ZJrESfAS8L8nOhV5vLutDvsV1HdtweQ2WA0gu3NqZJlKw77Obi7GOkMf+/jnE6I771NjxRSEJPFN4vajUPRmCS6hmZNe+byr8Uz1C01rTreksanRze7NqLUByZ7+XSrZKIc6A8qgqBflNzUzz+Ur5FLFzSMtCgw75iYewEzg3MtzElMaszpQNH+gJUSzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DxDQOcH1zMrijBXD/upCvAYWtmq455mB/3OPfhBNO0=;
 b=o7Lw+RGgNwBUZtjiChCxjTL7wLlurv1V2tlHPoPBFlzMIJLy2ykFAOmlKAzgI/QgsFithKJ21szRkenSGOelrKXUz8T/ri3MeleeTt3IpM/DEeau9X5diLAERsMSKdHnmUBPgh4xpXtrUGlGEGKeSPBE4FkY3ZPxvoQl5cxH7llgT93TG6W/RfdfmaydZM7Ylpd4bCNEY5Xh4nzGt8ZB4SSTsghmdj7jy4baNR+D0A4pBKPimsb0GwCkFOmWE6Mu8d3IswVqvE8Y6pdryD7BhzQmiPfaRe38SYmkBt6hMzSwmFvYKBjsFuMlGLwnj4GoLvrxvD2SKKvUdoLEnSN64w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 14:02:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 14:02:31 +0000
Date: Wed, 17 May 2023 11:02:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: an iommufd selftest issue with 6.4-rc1
Message-ID: <ZGTedVao04FKpl7A@nvidia.com>
References: <2e437fe7-59ef-be3c-1b94-c92adaf2e8eb@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e437fe7-59ef-be3c-1b94-c92adaf2e8eb@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:23a::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 78769763-da96-44a7-c576-08db56df5b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Uddzg+VkMN/8fHl1AjfDxpkPKn8J/NTmosPhn4SXXAqeBrwjurvOtoWHrF0QaN05v/GiMA/vXAoRBz7ZSJvJAACeCOduDRQH9BI8byEY4yiZ3h99MnqTorhNr9qip0u0qCVzuXPM+KxG8KUkhS3/Su2akrjudCD+vEwydJasA65Zl0U4LBPQWo5AZadTOZCimxxgPVkjh7NIMd1bJ7Fq5YhWclQpab4ULzPLlmEHpnCvBQewQwfkUbG0Tc5lFYOGpebJ1smC/N/jh2jRkMuYoAjWz4eSBVoy3q2s+9NN2ja84EmsKNUm0h8Cx0+0iCwR4G7D/NcNuXgf8hEddiiQN6SPQs5swGW+jxjMQUZ7l2sVK6DNMzfLZ0HdgxS5+urTRkokNHq8cME6HNb0ztUEgcCY4mfMUvE7UHgIfVSNgOiu5AXXyo5ldZcsMmnIJcA5+7hwGbX59Y5XWJ5aSnTJ0mGwZXdPKlm0Ami0voGHFztHCV5+EwcxZkxdp3hV/aRvmHUCqN6/38U6YQiJEKt/TCMqVCGNy2uXx6Yv43Ufm1BaB94oai6qE1VvxKkjk9e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(5660300002)(41300700001)(2616005)(2906002)(83380400001)(86362001)(36756003)(38100700002)(26005)(186003)(8676002)(8936002)(6506007)(107886003)(66476007)(66556008)(66946007)(6512007)(478600001)(6486002)(6916009)(316002)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AJRsJ30o7i6PK+LSbhdcqgOEXzEP4sX2sN8MdBxm9rzVlBajMqyJ03E7GsIr?=
 =?us-ascii?Q?m9cg4Qbg/DTsX4ktvW4f/zamlmGhD1vJQ3l/M3kpXW48zxdGVm8J1XSBJzRe?=
 =?us-ascii?Q?B1M7G/VnaEX0tMrc3apyEaKxE7qqEH65DCeqRshgV7dPYPiKJJFwwlw6ykms?=
 =?us-ascii?Q?ML4mynM6D88Ku6Da/rPdjWV3gazugZMlWYvtJdeejQyYSPAsK86MwDsknjM8?=
 =?us-ascii?Q?QPuHfgsRrXxLyVdIPGnrCkokw2gweiADnvjxbiRiHsZ5b5bQ3eze0GNR7Rw0?=
 =?us-ascii?Q?2wbBqzWDyM7dlEhhomSZzhl7TIe4EU2EuJhXV6Ff7mpH2IOqiurkgJ0z6DB9?=
 =?us-ascii?Q?eOkBIQzk26pp7oqp2zHfv3YcG/I847Cgd4p0McHrf1jhsw1nHP0obVrHtjyf?=
 =?us-ascii?Q?UaWu0m1xvNZuncj/3KK8W8/0t76OV78Kr010B/Y0Go/BltoZsqUXzAuW7K/O?=
 =?us-ascii?Q?NvvOvZZwySx4+LsMY1DpQPdaMVHGMBZuTB9phdCC8cFn2/Givy0ag3PB2y4d?=
 =?us-ascii?Q?iV66Clc83qbthfltbKWz1D1wF/KdRa9f1KDvOia2IJcaqPaMXNtOV5ClCZ79?=
 =?us-ascii?Q?BCo8xyXUOwxFD/9AnRPPZJ0IirCMqYkVSJ2k6P/OZhY+K638wPJnwgljYscB?=
 =?us-ascii?Q?hKPfqe4o4CY6+vsu7LoJPy4DO/ShzqTwgvYOEhaTGSlheXnwJMNt7QbvuGdP?=
 =?us-ascii?Q?8mbYczYF2OJWcbVmLHoEYvPVqfOMg7uJ6eEfLweKKHVZUm20ZpgbmyVFA6AF?=
 =?us-ascii?Q?QzqTXcB1hJpHQMw26rTeve/6cv3BrNRrUVmSvS52wUPVK1lgfsgzJlnTyEPi?=
 =?us-ascii?Q?kqWvMbEDGwxYTY3ZNyeXUz5tY/JyFea91FfgPjgWFzlBTd5du8d3lUkrTHDf?=
 =?us-ascii?Q?WT/vqr36tu5pjm/mpLvBb5Q5kcTSyZt/0rdOHYBsIL8kdHPO88ND/zeX8OXC?=
 =?us-ascii?Q?kzUYt43Mv+kKU10HSY41qBreaa0Ze+Jn42yUZ7twp0lrtQb/9RsfBMIslFr4?=
 =?us-ascii?Q?znAdx966FbU4KbCPK2LWs6X6Q42ZXmVnGTtgCzF/L5PKruB3epEISTtT0kP7?=
 =?us-ascii?Q?OyOH4BU+hdrRy4Cj3suGCmLGxFXkh07k3qQAGfwnCEfbT6ebnJlUnEOoIVEl?=
 =?us-ascii?Q?XCaJM3YnSuc2xg1cS4/MmWm3mqlWXKE079mc+LWlaHcjnkdbJ0mqv4krAAEf?=
 =?us-ascii?Q?jmL9Pci3fIQQhYe9eXKbp1kPppemTW9BWijxodr+gyPyRvgfrENuU5lFbCT6?=
 =?us-ascii?Q?kSeFkBAqv7xFfvr+SJAIzMjZErA2P2XuZmUS3qYOF6fCe6hqVYK4O4xrUtsc?=
 =?us-ascii?Q?ya6M/xKxaFpnwp9Re5a2GrIN3bNDzjCioxoBA8mq32gvwjWGhwAlHF8K/bza?=
 =?us-ascii?Q?CTUZbY0I20y0QA0a9R9GymAjhJGTKGixnkGZ9lbYAnUu3CbL4AFUzLTwxw+N?=
 =?us-ascii?Q?LRZ5X0F7sb02dON3ACDp5DzjH5o8+DtzHfMuy1xsbXL9LuN6Gx6GUYVhlSkw?=
 =?us-ascii?Q?4hgPEV1/jykhOiGvcG2Coosm0GAgAz6Y3O05Ss7B8oWTCVHxb6WBkX77TGLE?=
 =?us-ascii?Q?Ok7sVfLm7kob2QuzRXIOKPNKohdUENR2R6aCaPsM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78769763-da96-44a7-c576-08db56df5b0b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 14:02:30.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l95T6Tp9lJtV5HnLd5PkBtJ3rfktkynpaJmchpajOcKz+edbcLTBh/Kr+klikGv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219

On Wed, May 17, 2023 at 09:56:47PM +0800, Baolu Lu wrote:
> Hi Jason,
> 
> I compiled a 6.4-rc1 kernel and ran the iommufd selftest. The test hung,
> and I had to break it with Ctrl+C. Is this a known issue, or there is
> something wrong with my test setup?

There is an annoying bug in the test harness and it infinite loops for
some failure cases. That explains the hang

> # #  RUN           iommufd_ioas.no_domain.ioas_destroy ...
> # #            OK  iommufd_ioas.no_domain.ioas_destroy
> # ok 13 iommufd_ioas.no_domain.ioas_destroy
> # #  RUN           iommufd_ioas.no_domain.hwpt_attach ...
> # # hwpt_attach: Test terminated unexpectedly by signal 9

That seems bad

> # #          FAIL  iommufd_ioas.no_domain.hwpt_attach
> # not ok 14 iommufd_ioas.no_domain.hwpt_attach
> # #  RUN           iommufd_ioas.no_domain.ioas_area_destroy ...
> # #            OK  iommufd_ioas.no_domain.ioas_area_destroy
> # ok 15 iommufd_ioas.no_domain.ioas_area_destroy
> # #  RUN           iommufd_ioas.no_domain.ioas_area_auto_destroy ...
> # #            OK  iommufd_ioas.no_domain.ioas_area_auto_destroy
> # ok 16 iommufd_ioas.no_domain.ioas_area_auto_destroy
> # #  RUN           iommufd_ioas.no_domain.area ...
> # #            OK  iommufd_ioas.no_domain.area
> # ok 17 iommufd_ioas.no_domain.area
> # #  RUN           iommufd_ioas.no_domain.unmap_fully_contained_areas ...
> # #            OK  iommufd_ioas.no_domain.unmap_fully_contained_areas
> # ok 18 iommufd_ioas.no_domain.unmap_fully_contained_areas
> # #  RUN           iommufd_ioas.no_domain.area_auto_iova ...
> # #            OK  iommufd_ioas.no_domain.area_auto_iova
> # ok 19 iommufd_ioas.no_domain.area_auto_iova
> # #  RUN           iommufd_ioas.no_domain.area_allowed ...
> # #            OK  iommufd_ioas.no_domain.area_allowed
> # ok 20 iommufd_ioas.no_domain.area_allowed
> # #  RUN           iommufd_ioas.no_domain.copy_area ...
> # #            OK  iommufd_ioas.no_domain.copy_area
> # ok 21 iommufd_ioas.no_domain.copy_area
> # #  RUN           iommufd_ioas.no_domain.iova_ranges ...
> # #            OK  iommufd_ioas.no_domain.iova_ranges
> # ok 22 iommufd_ioas.no_domain.iova_ranges
> # #  RUN           iommufd_ioas.no_domain.access_domain_destory ...
> # # iommufd.c:611:access_domain_destory:Expected MAP_FAILED
> (18446744073709551615) != buf (18446744073709551615)

And you had a failed mmp, so probably missing THPs or something

I don't see any failures when I run it..

Jason
