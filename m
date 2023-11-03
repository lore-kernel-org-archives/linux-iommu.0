Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A822305
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NvzIuvWn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHafT1rpwUjS9//JiAywkDs6QSp3IsjYSAz7EFr4YiIh6mC0+c+dMDrp0xQuS+A5BGp8z5N/btVj7em1SRG0s479w1mCwPl1AmZ+rt6WuIpYWcYIcSGJZ5tyiEskIfKttWaQlwdcs6qvbUHMGvg5ZzJt9bjGra6I5j6caB+5MC9dT8KX2gevGL0xU12Ti8Hqc47bTZ8a0W0cKh1mTd4wYLAB/hdt954hh8C2LrfpynjmuDRSK9ZcJ2l+Lgr6iGaf4WQIQKF7QdWWL8fIDBOky+ZD7CAIMM7iKVUTGWl+fbi6trHV37HujSnNbHTtyd10DEiQcgvLgQOvr5hfcKjPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXq0/hnBqtrjy0TY+SRVdh7GTFp90Qk7JzgNGbqeP8c=;
 b=QvV6z3AywMst8It9yYY2BDczWLO0l/MOytfHowWcF7n+886MrgTjxMMW+UN1bOAJayONh2Gz4C7rSXFyFeRioMg624YTVMpMd+tPeCshg2/wZJBhM5Dmdt2g9JhcqhGauHnj+2NwC2XwAVJ4EFMwZNX6OMf60hRRJ+vJt0n2LHSJD24kNi/4MDVdSd4qqEZgWveLYOGhHrWEBuvUeLA+8kEldRkr69MbkUiaOcPvjptz/mQWn4v/j/h5GlcbVMdF1EzfJ+IvMp+D0QewHh6PdRFvyEPcYgcmTBfHE77RbV4ejtKVtNebW05bCm9gqD5FzHCPF7bIh90EFYrTgNjsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXq0/hnBqtrjy0TY+SRVdh7GTFp90Qk7JzgNGbqeP8c=;
 b=NvzIuvWnI3ktD982rEybOEEXUxJ795E86WL3/LI304D7EPjfSxfTp250PnxYP/fHmFZop47yqJJkTBRESofudycRBv12Vri2MkSRJtyHt8rOoIbPZ8hMC/6lSAoO/jfS0T/ucPOn4fpatuNVN3qIPKstIhiOdne9jpgb9FJa830JKh79vLxGm4YLyb2iAylHQcgnhhuOQGJt5KE9SYsWeJwuE5nWb7GOJIC41l/lGy9nCMBpLzBYT3in01LpLEv/1p9E4wm6kAEdCrsJKR/4r6vtIPrgDaxiCis3RQ4CU6TbjGpcHjxv0xCXFFhN0si+2nFDfr9FVx7Lf08ooqBShA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 18:25:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 18:25:13 +0000
Date: Fri, 3 Nov 2023 15:25:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	Kishon Vijay Abraham I <kvijayab@amd.com>
Subject: Re: [PATCH v1 06/13] iommu/amd: Refactor device iotlb invalidation
 code
Message-ID: <20231103182512.GF223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-7-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-7-vasant.hegde@amd.com>
X-ClientProxiedBy: BL1PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf4e6a7-99bc-4d56-d78b-08dbdc9a3899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O9vdUlTbjok8481uTBRncdwY0VlBM3mvLmKgE5GL7CiKcU/hfXZN40xaGkM6XlwIDBkIL7PqnvbS1dzXh0cpFEBqCCbBFatUw2icdLd3KWeM2RsR4mP3yg+aIjKeSsRT2Jt9m9hmII1CIGEOpTu1Q05FDNHKNAOduTGaLKhxmxWMVhU1OsI1hdVb8hVyCl+ZZU1zo5qEb7814G+dW8NZCyZwPjfWx2YmyAxIJ0RU7Ylw8cGEbHFFAQ4VPI7iUx+wieC3rrQchnCboaKhGu2CyutoyNAxZbeqolH5+dq9jY1asKCCj4bmLT2c21AX4t/2jfqMqHUtYgpEfmdks12kBWSSe4581TemaObiO65ca2nsyxE3QCJU4ukNXD83lRxf9UUZHoS1DF4eMyZnXafw0yhhgZZ1+OYYL5VwfdXe1WcXLWA7CZO8mbOwN1FPLoUpDiN8gNnU7VcC6ldLS2iab6Y0PplnS79UCFCq3mxEwhJtT5Qjfa7oDEQkYQOYXA25ShlJEosQG/MRgIMTOYwlKRBIo3AMrmqB5dWcOzHr9dWf4tWhFmqw0x8DWSiR+GGfTLgbB7pZZ+9gaDJmcyYnoB3yEmOO+W6AOrzx3XySJ5bvv/bZ+7Ry7VTJqOA1ZEKe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38100700002)(5660300002)(41300700001)(2906002)(4744005)(86362001)(33656002)(36756003)(316002)(6916009)(26005)(66476007)(66556008)(66946007)(2616005)(1076003)(6486002)(6512007)(6506007)(478600001)(83380400001)(8936002)(8676002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qCVWoNCdQbuL4BAD1nSfM33n7I6mejBxQlIyz6A2I9THnMmJnJj+ygIOZ8ka?=
 =?us-ascii?Q?aWUq5WFURjs/1btTrqII9pQ6hUxRkRtXhkekL0X7J9nsiYfDGmpVuTaPoKb5?=
 =?us-ascii?Q?WYXQx9dh6Xj5s72j0vnsi09eh0ziDpG4s6BaWfc+ml4GFDjcE26RWahpYgQ3?=
 =?us-ascii?Q?MP5oGHrREwe/wF1qGXTZPr63RmdZaQsMUdGueaHR9gaOMuDa/E1kLc33XZ4u?=
 =?us-ascii?Q?SuDVUZtg9IgpF1qL6U+8t6H9zNhtbzDYyx5XLNhecA2veuK5gidjqtw8Ac4h?=
 =?us-ascii?Q?OZPUpvvjhk7L/SopnxEIzQH+0zyEZXpF6L8l6Q0ay2l4+5v6VtQ2GGWj0Uu0?=
 =?us-ascii?Q?g5TZb/l4BzKkv2KVv6Ca3tR3hF3047Lk6xMjUuTlWR4UIgjy/OZ+DX5UQpYv?=
 =?us-ascii?Q?EIZSI8oETozl6YAfjwcFSePuSOiKywKL1c/+N1HCEnuZtgwmMbBa9xsca24Z?=
 =?us-ascii?Q?VGq6BLrtyOjD10etbdAtIskNPwdEPUDzrddwLz10Hk26rGym+TOfVBODhiP9?=
 =?us-ascii?Q?mctOrxDcyuDRboLERNY2bC14JIAE1c5Iowz0enEruYNfoKV1ffSm5zGu0sSN?=
 =?us-ascii?Q?y1wqI08mu1lHhn49YHdyq+8qlkbuDXu6THVx4/1vuT8he4hnzzEIz5p6ZHaW?=
 =?us-ascii?Q?2fg9KFsq+xEhsOdP4ij2F3o2PaRX0LvUUT2qeK/nJlExArmCmqO2/ivWLAoO?=
 =?us-ascii?Q?2LKQ4237pcPBXbcy3E5N2OrlottpGRUqOguru09PQgLU9U8x9JPW2j8m+X6I?=
 =?us-ascii?Q?o9Ud/DWWpE2t7LyEXWvYF2N4oEoh0Z6Rs8HPtvn/AA0cInTCCkWPhOXd1ow0?=
 =?us-ascii?Q?8QGVKSaO4bkAU/6tn21pbBDGgMfroln06c5IwtiOQ7jmNJFyBpcJcPMsgoiN?=
 =?us-ascii?Q?KP3PecfHqFE5dIDkmnwd19cZTSjLoqPw5Afk5y6IbYxSK0iaNqzf34kQ3jjr?=
 =?us-ascii?Q?2Uto9hdap0/pxIdhTSR+6Jg5aTVacZdX7iHBlEjnFlRuVgd6OlhjPpw/kU5k?=
 =?us-ascii?Q?CaMxFDR45hGkNd+W0njVP0Zt5FIXJ/7DIMDNRHDXYjqKp1XgRXzFSbn9Fyip?=
 =?us-ascii?Q?g9qI7H9A+6yuTd7eONOCrUmPt6LlDnV1QaDsMAarG8gziXd6Xd07OuhVQBd1?=
 =?us-ascii?Q?QAHeFP64z+Gtbs1791O/LLSohl2lcUWQ0YwvejciLXQ3NY49lq8m80O6bRdY?=
 =?us-ascii?Q?u0WZ0hAqV5XYqSBbChqYxiEy3Q/rAC4GUKQUQUaFhb3yJwmEyfnPx7hvjLyB?=
 =?us-ascii?Q?sS8A0TiJTOBetIaBRsApGizDE7KCb6o8V7pSW3clFQEZGDkPjzsCKZjkd6Rd?=
 =?us-ascii?Q?pqI7aacZU681gAC/PkfN9O1HM5TJ07UlwR9zn7BdCFXOZB30L+9mT6NeWNM4?=
 =?us-ascii?Q?WZtet49ZyJe/KMiE80s09PyXEzEcjs7VxzlA/5XOBXiGaUUaUn0DqdfHd6Ia?=
 =?us-ascii?Q?iQ/FBfiitd6qzIB9jzHIgl+WY7U30vRiW2fA0iRrb9nBfog/uH4fy2jtBvgP?=
 =?us-ascii?Q?EAvJ3W9iocyqruXYpBa8qHuRIY+EOoxZ4j1ZGpStVw5YR3Fvo3gpugJfzvIY?=
 =?us-ascii?Q?I7JQmfo+ObDegSZZnfID4I/TGb5wqvPjnblv/Qhr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf4e6a7-99bc-4d56-d78b-08dbdc9a3899
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 18:25:13.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sH3CE73ns6ABXjtBCwJekRmALKfI4jWqGydLnlsiiY7TcHkbZrhoSHm6GKGhXy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

On Fri, Oct 06, 2023 at 10:16:17AM +0000, Vasant Hegde wrote:
> build_inv_iotlb_pages() and build_inv_iotlb_pasid() pretty much duplicates
> the code. Enhance build_inv_iotlb_pages() to invalidate guest IOTLB as
> well. And remove build_inv_iotlb_pasid() function.
> 
> Suggested-by: Kishon Vijay Abraham I <kvijayab@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
