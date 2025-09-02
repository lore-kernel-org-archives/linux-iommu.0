Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AD2DA751
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818596; cv=fail; b=s8aPpziMPcqWoX4L3ZyojJDAQWulHdjzMq0k2u35qszFevx0tGSHPiiQFWzNlKrSECAGkzLT8Lx8yBVS+2pdUkmcDYoyLwnn7wj/Gi07J3DwwuxqN9hTVeMAFu9QgmJFiOtYqcK+U5nz3VqArk5fPRDHOepyxmH5YtBmk1pZ2Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818596; c=relaxed/simple;
	bh=uGgmQdcS0qvrstSxZUqemP47/DxNqmmeJ4kDxMiUg9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DC+cyvZVO2RKsC7ukINwqEI/9LlpEKJR6r+7usNNkIg+H0VVCUhqMA5boFUpgN83eworVC6jkSwWcM7ErRNkxDSlLpYnBfp52opqP1nUt8e/W6EgV/ghfz6exqw30/dmqF+rUA7l/MAtXGDPokr4mJPV9WIrlQLh+9IGIekSDjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pa+HXhZ3; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pa+HXhZ3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tM4gJLrFFkMrN8IyV03vyEDkrbaemgPP/Hg0X/aNoXc/lWq8PR1a94P7WKEvi/gtEwKQDzS/7uDj1+zfeNF3TcUUFwFSH2yc6Yrzxxf9FDH5uGbqTRsThJv7baTjWf5GVI8SeigLuKcgjCDcwy8A+0PBgQ2REq5wA3eCJG6xij/f0ano/cQw4SEE28PjJW9W2wdCEMTja241e2Vg2ROlfXs+nMCem7Jc/HRZOGmptJu8XSvrtJFTsdiFz54Pedzd9q7WO8AWP6lPXVnZKpEK6z3Y6w9lqhZ8URMUiQCXIPNkcA5MWwk4qcwEFFDVU5sMXcY3wsab6WMwOEHPEqHTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLSUlR91T5ouw8jzauy1Kp43nhQOtKFIGEHeVRkFXPw=;
 b=Gj4WXcnfF2TjfJvs309wLqRQpEMBJNXEnlk43+RvePNMrWwmItIMRU+07Ajp72zULDoE6YE/ppbzvTNoNnf2dxXPoWCBK5X37hVtbwsXihfU62ailKih26nk/7KfHcHTrka/+iPj9BV+r6M13gJMoRo5Z/FPq5QicDOqEnZRpvGLaf0l//Unt9mf/dsK8VjJVK+0MuYb1m4gBtZ0oJym0Lhswu/Nrce9qo8+dHBxGcJQZDji/fOZS0bB0a+BoJsfh6uLG/BXpEEosCwwjZUTaRuGBSk2iW6d5dAtczxSX4Oi56mqtu/dlqTToYa6onHVcIKwUQFQKrcGsuYvuK39DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLSUlR91T5ouw8jzauy1Kp43nhQOtKFIGEHeVRkFXPw=;
 b=pa+HXhZ30ZCLScjOIPz0KtNI94FQbwPP4LM6It/GM/mZdiBwyrANdrEI/OzgL54cd3h9qupMXfmdPSri1hhuGzjrpJ8Hnv5Cn3hfI9M1RFGXCrvH9+Otg1Gj2TboYmZo+lyXuyYOH/vI+jtHdWdOqUAJ7d2XiqzIXxaxcmxGDFlzAp0XPYi4yumZwjLXQfhnb36+CPGfHMyfRf97+8k4lV27dgVbn6bvIQs7JJhsCMJ7+R3/gRVZaJNa8NhexP7EfiMDQXENMznf0hiACw0LKp5d5AxYANGvqO2dTUiuwh5YPjB8Ioe6wwOSY0CNd/Aqrg2KGSEePdF2oyW+Z91czA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:09:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:09:49 +0000
Date: Tue, 2 Sep 2025 10:09:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH 5/8] iommufd: Introduce data struct for AMD nested domain
 allocation
Message-ID: <20250902130947.GH186519@nvidia.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820113009.5233-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4P288CA0076.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6d2642-b157-4ec3-32b3-08ddea21fedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+gTGzh9frX7YOysd82NMaYdZqDBEeTIE5zqIVE+b44uiGnfroeOJzlVq/qW3?=
 =?us-ascii?Q?1Og0NFGJ+uOZJvo1MRF/jO3lCF6zljuWzhCGdeHXJKay2p5p6TB5ukR3Bxai?=
 =?us-ascii?Q?TrWEz8rX2fSmCqh4oGPdnuaByOJe72lxnH5B6b7uCZAtrrCj7f8ZHzK99jXL?=
 =?us-ascii?Q?RI8pC9mTRL0HRvFoSuJMLb9ZEPArG+XBZgSQ0o9B90r1SqDoRX8UQoRk0kDZ?=
 =?us-ascii?Q?kRXcWmti4hMSJmdrFqZIxJgxj93Vi3L5SPkls1/P0wGGXTLoYCymWh01/lw4?=
 =?us-ascii?Q?8D8u2y8f3xRZypuCNQzuOikuihbqC+MdFdvcu8bIhKkLrSQ6f89KiI3wluUS?=
 =?us-ascii?Q?cDGVz0V9WdNxBoHjayXWy52oJkctQXoIRSG6iQzD/uBUPlAfy2VvymaS3dYD?=
 =?us-ascii?Q?p0OkiDAJGD7Hvi/Itg+4JX+ckqYJzERgwBW6sGVv+X5NPMXDDfIU+Y1l8gI5?=
 =?us-ascii?Q?ZA6kw11wh40mflcLSUPL3EfLT1+lWjU4SCqqmfrYPzuuqMlCPOyh+avw8PVO?=
 =?us-ascii?Q?Cas6R23X+oVKxbWiyvbYt96U0AE9H5qvjVd+WnGyOq/KTFk9NAZgFraPsHDI?=
 =?us-ascii?Q?GTRV5BfSGBdr6CIHEr5Uhnd9JIAM31N6yBt6kITyh3UPdst6vwziW8vNLfQl?=
 =?us-ascii?Q?dnuUpIl7mi0G9GmSTsE1Awf7COZPDtA0IsiKOcp433yvQ4HdOQiadGo1QRA3?=
 =?us-ascii?Q?7vUT5wJ+EtGxl5MVEera4aEUbCmCcfMYjHXMhAneKvvEf8+CrtSNGEMI/ray?=
 =?us-ascii?Q?wkS1quLG5k0aKrDTfukDREcaIz5tMjn+7cYe0WWz8bO0ES5zpD9iRTwoz16y?=
 =?us-ascii?Q?iyUHcYhlzrUrJFBJxocSj6RvDeSQXZgdDTRVQ8/srIUKabxJgwDBniuG3GJw?=
 =?us-ascii?Q?7BUkdXZs61E5pLWs/13tiXLvBRAbbt/9pr5Z3JpomKmR34WuHP+UZx1/Qfp7?=
 =?us-ascii?Q?WfLvsPq4d/4wpgouv/KvS5WJM0rFEZf5im1oQFQK8CV5wh2XWIGVc5pmHiav?=
 =?us-ascii?Q?BdBKJ4gZH6BWQ98QlG3ZKtZ0fj4tCJ//XvXhsQPmcwF9KaV36qATgQgiIarG?=
 =?us-ascii?Q?jRIb6yl5Ka08PLDs1Udm7+SXADmYNkgrC4Bye8g4M/LnFwrwjgbtW7PHc84j?=
 =?us-ascii?Q?7ej7mh2F/0qhJizdsANrQBgI4AEKq+fbvZv6LIiqVUuoDBgwLdCClkJWZ4Ok?=
 =?us-ascii?Q?EbPwQlKVZ14V3LqIaI1yu5dcFJSOZnGIMq74e7BB1e+GYRhyNC8LKlRV9PrZ?=
 =?us-ascii?Q?O9qDBpbmyFBwjc0i1RMV36C4Fr+aVCSQCTuHZn8kMln1gGIkOuCntQHAf2mm?=
 =?us-ascii?Q?Z90S0n5nEeiK4JNBc+4wHdMaWHjMb/xjw9Taw3b4kzyENmG0WjM44gXh7J66?=
 =?us-ascii?Q?D32/PaJa7mAZa0olcVJXFkqnXZRUNpZkG6WOTb+sOVO70VbK0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aU4uePU99RjTpZK9dkoVDBmTOyUxNT3EJzeXY1/GKNYm8tdJb2j/hTb6U2Fc?=
 =?us-ascii?Q?JwjPJHDf5CI3697rbyCG1yWf5dHGAVXYT43A+hApwcum19L00v1GvX4xCEeT?=
 =?us-ascii?Q?k2s2xFPRvD60aYS3pStJlwK7E43fbzsKbwYpKP3M0buyjzaHquw2CrO7QhM0?=
 =?us-ascii?Q?HDUduDpO529nxJ1HcMqCJR4+VPFISm1gP9wocmPeUViM9ua85Gj6xCy0BTev?=
 =?us-ascii?Q?pUvdt6kb1YPWrRVNL0QYQXeVa3OYyFZbR/BWRTgtYLqjcqr7oBw6/ClscsnA?=
 =?us-ascii?Q?t+IAC0/YMXkMJxIMpz62j0RXLf5pMtGyNNCJ231HmmUJEasZIQKVWLhTLuVM?=
 =?us-ascii?Q?9XfdOigpcX5nX4d1cBJCv1gpCvKuxfg+7LM71HnrBIX6/SLyJWdK/hHiEbvY?=
 =?us-ascii?Q?dPxJ0o7yNIrVmBQaLDDuEThTHdQLFmZT3YZCOy6vpvI0TPFu9VWuXevQPNk4?=
 =?us-ascii?Q?q9iZV6if4GnDzS8IkDgZzbXxEFRCr/a2R9HXa2cgFocKfEmk7GRwLS4J9ACW?=
 =?us-ascii?Q?66yk97a0Rs13voyLLENInQ8ZsFrOOd05Ia4nirGpzW2BZ9HzG0LvVtXCHXO7?=
 =?us-ascii?Q?ATmJtZGVNS9ZkSpBS//orgVZ1QKtoE7lAJW38Q+fHI+lD9RKONFd9+rgn/Pk?=
 =?us-ascii?Q?mgiNVZ+8rhMMlt1eMtLz4Sl53rq0fXFzxS9BO5s5VLsgPTxVFVkeinsGhmFM?=
 =?us-ascii?Q?xOvapCFczYyj700awpUxJfomFp5yi0ix5GXdfGMzAYAcEyaTAukXXnfRPA8R?=
 =?us-ascii?Q?Eov35MFTsXm+sIX/o/hdL0ERMBHf1Jp7ozf0HvEnMxTl4N7OtsY0cLMLFwkL?=
 =?us-ascii?Q?pLGy6jLtun6CmuCsMec4OndHXZ+XUDe/rxe8ZmJAfwFyYdeg17bSjyUBoOiV?=
 =?us-ascii?Q?0xvHlp5Tc+Untj45AVN0qcJMASdSN9WGZNV9B4RDcxO53xgTH0cmSc5yFUGD?=
 =?us-ascii?Q?PJiNfKl4HoH6KHDUz0skXYUnvXRzRgqLWRgylAzD2qXxbgHYNfB7iIkrI1s7?=
 =?us-ascii?Q?pKeKdJxLZ6cFw5WUNULagYCWz6yt6gTZ5hsuNHrEzArrdpdTyu5uJT7h7rtP?=
 =?us-ascii?Q?F/styw1kNajSIpJAovYYRMaYkgDpf4iisJOz2GJxxQFeHK5C8WwGRPlmToUd?=
 =?us-ascii?Q?7fKLhxdnQOU3O8+AhVVZlWrdpIDnDDKYaARIQEsRugcY6v/AMrGnOvAJUHr5?=
 =?us-ascii?Q?wsddKAeZDDSC38HvhcJqrhLBGhO5n5X6vQZFSfmgXHUlwZPnEgWbf6sheV/4?=
 =?us-ascii?Q?sWsC7S/2KYN28xf+m6GeWd21/VZfP3iWnddlSBFypJhAXUHnhHFhFRQLAFPh?=
 =?us-ascii?Q?cpERhYizQ0jeFPddorrJACIoE5RYlnjvZ6JbK5Uwzo3UBcUVU9K5AUzWgnXV?=
 =?us-ascii?Q?dpkXBUkcWwpqAupX/bAxetioz5tAItsfQ0F6HXg+r5o8T4rbTC3fIBFViWLa?=
 =?us-ascii?Q?4jfSUoUtJxpGfavMPL/1l4zzE7gXjSCJy/A4m0t0ODwT2U4QfpKWA1y0CJFZ?=
 =?us-ascii?Q?hSLBuHTbc0ItxLH3sFuZs0nQyLMeya9UemXJrKHojQUqpV6I6j+dUUPNbxfg?=
 =?us-ascii?Q?pMR06WiCqv/zjCGWFuk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6d2642-b157-4ec3-32b3-08ddea21fedf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:09:49.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLR8DpBvQ/p0yw+UO+BCNqkNJVl3bIiR9aLgWa5voLIt7IT95n+3J9t1A8De4dRG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458

On Wed, Aug 20, 2025 at 11:30:06AM +0000, Suravee Suthikulpanit wrote:
> Introduce IOMMU_HWPT_DATA_AMD_V2 data type for AMD IOMMU v2 page table,
> which is used for stage-1 in nested translation. The data structure
> contains information necessary for setting up the AMD HW-vIOMMU support.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  include/uapi/linux/iommufd.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

I wouldn't call this AMD_V2, the spec calls it "GCR3" and "Guest"

IOMMU_HWPT_DATA_AMD_GUEST

Otherwise 

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
