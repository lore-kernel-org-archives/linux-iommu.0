Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB817D8
	for <iommu@lists.linux.dev>; Fri, 28 Apr 2023 05:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRWhJiAZ3SxKsSiQfz21RbYyrXBhLo03S7hJ0k6B6NaPLXKFsNqvJKGZftAPDqGY5t2E2W2jQkE0RcWfrTqARqOWS/cSHLOXUUZQnpEV+Ewzl9sVX+lt34n44CICuOXxBn0LexzYXBXJn0lq1Cro4mKjFeA7sNCQQro6L+sI+rbUIsfxL+tBuHWZjHRKlvPr5Z9pwtTYTHLHdoVj0/TzQ3Rt+3JC6BEnQPPzHRa8T4DNhdLzTCLNt8bHtOu9CRFcUdRimXDHH9xjKrp7JO8dUXuKRZx6Gki28zLecM2F4Bc+0yZwj53nYZYkOgfHGKTZT/sF5vXpQK1dIOHyi33IWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh6qbqUJ0OnefeBCiydCKNWDUMBq09HYRjnbro61TAo=;
 b=eD4DQM+2xtxdAhHwxdhB7tUJ29JDNrCjrn0MeVjyjD4pTzlS0S8uXa7nyaLSLZTfMXApND3LZm7xBFkGKjBWeeb0VytczfBXSm8roUqcznOziHe1X0oafn3D2jb9r6fWRLVKe0DgtvQcMtnBq3a74Ax8ODL08B1LrCKy5wtYqEYUq/4MQzk0U1MK4kUDbRB/VTIPQYAvSXm8/OnDHE3zpy3rVOdEJP7urqu8bws6ODvvncH6iRMYL+SkgP1WxVMdf91y6mu1XWNPFMVMB361PxBKawX44VxPuDceMFD25WHDfnWq5aTvA6UyYBEm41uH1kT5S7/KLhqGSDFN6DPovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh6qbqUJ0OnefeBCiydCKNWDUMBq09HYRjnbro61TAo=;
 b=WiN2oWtbyGZ4XQXLWHHS7O+3HZGW6s7RJB3jYo1WEoTV4x+Y0LnqhOLutMYIZQwwHYHoUVGwVb8eOm9Vz8xXrLLpjuENHhkZIk4bcAH4OC9R5bBq5bVOqlOaRZxiSWCYKOHkTINm2tk8uOJmGOyNY1PVU29cGYHYuUPpp6QFF8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Fri, 28 Apr
 2023 05:24:21 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::1891:71ee:fde7:4e1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::1891:71ee:fde7:4e1%7]) with mapi id 15.20.6340.023; Fri, 28 Apr 2023
 05:24:21 +0000
Message-ID: <7aed7aac-160c-d58d-428c-d20acf23da2d@amd.com>
Date: Fri, 28 Apr 2023 10:54:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH for-rc] iommu/amd: Add missing domain type checks
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 Tony Zhu <tony.zhu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
References: <0-v1-2ac37b893728+da-amd_check_types_jgg@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <0-v1-2ac37b893728+da-amd_check_types_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: b4671716-d000-4097-63a4-08db47a8d239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zfovrxIbqyaulxIn4gAiomppLZ4+5PFTz6ggI/QZ6+68nE2aJWygiBXOBiRXFkliPlHmxFo5Yt7lxCO7j2beq7W2345jS+mqjAzAgQFC6VMrgHG71vN2CvjblU0ao7cUT6kvIFeKBO5/+ZsuvyTBsbrDcw3JAcVrvj+b99hDpEfVmLqf4O0de4QDCH7Qvpc6Kjy87JjhaiDZ/zpHssAh8Mavk4KpGRQbQgXS49a+NJoYGj6mZEKc/QDwH6+e5Z47K8CNl3oxsxTYUwrHMZGQYt6/cMxcqH6T28JR6oxCZ+CePEnDYDDcLapYSw4dGwZy63QH7Aa3Do4paWzZh7dtdJpUz3dmFpAKjJPIqiywGlHuujJWSTHC7lbqmVRJfX0OXr6dIetxEIaxN/a/tmajnTSQEhJzwyIZY3ygYWcPNZwDzRSULNsV9Q8M19YV8uL8hDZP9tummC9CMdSLZ4t9XXO6DnkVHYTmm1IDHnTpePEvC0zsFs9bLU+8MnwQlVikr4lCFez5Cfd1j0fcx7v8e0PP1+j7jxa6wiKmiZ+qVmlhKlaxzDlBUdkMqInf+4gGOuPzcCCN5EANc8v2WimoyTvo03jjlttKFTvEeme9M+odOEtbqSnWypPn22zlEH2AgkOH+B0VAq94oIYG7I7aqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(316002)(2906002)(4326008)(4744005)(66946007)(44832011)(66476007)(66556008)(7416002)(8936002)(8676002)(41300700001)(36756003)(31696002)(86362001)(26005)(53546011)(6512007)(186003)(38100700002)(478600001)(5660300002)(6666004)(6486002)(31686004)(83380400001)(2616005)(6506007)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW5kQm9qTzJvR1dEQndWZU4xcWROZldiMS9zS3pONVJscDkxZHhvcUxiTUZE?=
 =?utf-8?B?YUtoaGN3RE1tZ0xReDM3U2FjTEd2SHB3dVVUUGR1YW9EUjJTWlkrZk9WRy9G?=
 =?utf-8?B?c0ZWT0FFOHk1QUY0UU5ZeFBFcGZGMDBLaDBsbEhUTmpXYXh6SFk0dm1NZ1pj?=
 =?utf-8?B?ZFZiMFFsVDVUbWN1VHdUUHZoVG9rb1ZYRjFOR2N5YnhsWXIwT1ZwR3lsS3lr?=
 =?utf-8?B?QUVBZ2ZmRXc1UkVocEwrYmdmeFNhL0MzaGVXTW9CUnlLQVFFQmFoNVNiRExU?=
 =?utf-8?B?YVlFaExQbTQ2TTVEMFllUjdPejd1dnlyelB5M3hTMWVqVWVvQzZmTktjaUly?=
 =?utf-8?B?emRtT0dNS1FTOUNPc1VnMFphSXhxUWg5RmhraFd2V2Ntb1hQU3lhdFc3Q1RP?=
 =?utf-8?B?bnJsZUpvK1h6b1hCdkFCbWYyeDR3aUd3ZExTWDV2enE1ZXdBUVREYmdnQ2NP?=
 =?utf-8?B?Tk4wNkJNT2VVQ0o5QlBrUXdzbS9tR3BGRkUwaldSaFNOREZIUGUvam96d29u?=
 =?utf-8?B?bUJIL09sUnE5UmtXUGoxSi9XYTJOOUJmTDBTbjhFWEx5d1BxcXEyNjJUQ3Na?=
 =?utf-8?B?OVRQbzFMNUU1ZWorNmV5aDZybldIZG1mSXV4Z2ZMUGF6ZVFMdDRJdWo0L3J4?=
 =?utf-8?B?WUhZdnhlRWEvQlI5akV6dVpyYUE4R1hHY2hUblpkU1RSaDgrTXRLbHFRY2Yw?=
 =?utf-8?B?UEZPZ08ycWdJUUVSVGdTanRvelJBbld0WmQ3WXRyNnZSNFEzakJlTFBweWtk?=
 =?utf-8?B?WS9jQmdSOTFVQm5LbUYwVlhreUFwbUw5MGhNMVZjaFhHQnY0d1QyU1FXcisw?=
 =?utf-8?B?U3FGWGR1Y2pyTWRzbmdQVERBVkUyMUxVeGIyNHpzSVljUkM2WTdBQ0JHY3dh?=
 =?utf-8?B?MVpiaTVhMk5LTlBSeEFqY2NreE5PMThYSytWbTRjaTlhQ0tIZUZBTFlQcjEr?=
 =?utf-8?B?Vk51NWY5czZMUmZVZHFFQTc5bWFTdWFMSDVwL2tSLy9naWtHcTFkSkpGek8x?=
 =?utf-8?B?TDZWWlpReFp0Mm85d0ZjUnVwNG16WEsxSzVWNXp6UzhqeXY5Q1ppR2NNWHdN?=
 =?utf-8?B?Yit2bkRqdzZPQ2R2SWIvbFQ2bllWMmYvY1l2WHNCZGlZYTVrSnNFOXp2M1k4?=
 =?utf-8?B?bWZsZ2dnT2hDb043TENrTVNKUjV1MjRmWGlJZGNhNHUreEN5ZmJwTGRwZU5n?=
 =?utf-8?B?b1EreHdaeDMvcWpFdFpUdGpETUs1RHJKVzkzS2NnaGNLMmtYTHRjVTlNbEVI?=
 =?utf-8?B?MnM5UDRrTEgzTlZ0VWhkM2dBZ2VzM1FCV3VMQW1RUFEvSGNqS3JTRkRCTTBj?=
 =?utf-8?B?SmpmcW1OZnJSMzU3Zm1vRktidjBVQzBxenR4cG5QQ0tDb2d0WU4wUmU4eDlu?=
 =?utf-8?B?aGM5N21lYThtNWJxQ3JTR0FpSUxPVXJwN0RGS3Y3M2xYdFJuME9HNlJXbzF2?=
 =?utf-8?B?REx4RkZXQk04QzA2eFJvMEF2amNyNnhkdU4zRHdkRXh0UGZjcGVOMnpqcEZi?=
 =?utf-8?B?OUZWVnlYbWhHQ3l2QmNGaStyZzVDTFc1ZC82Q0FHcWt0RStVTjkyYUhXL2Rq?=
 =?utf-8?B?cExvMmszQ0hDazhaQUVZSERjY2ZxSTQ2MlNTcU5qRGNaMm5WM3FOZENXLzdQ?=
 =?utf-8?B?TExQYllpR2ZtNXA3bDUrRXV5aCtzZzJscDlDWEpKZlE1MFFKY3dBZGh5bFNz?=
 =?utf-8?B?TkdKbFJNd2t4T0djaEJ0NVhtU0lkUzcwYU5PblJzWVJIQWlqbmp0Vk1wcTRs?=
 =?utf-8?B?ajJtMmwvYjRHZlkzWmFrVm5FdmhCOWYxL0t4L3ZNVis5ME45eHpnWVoxK25i?=
 =?utf-8?B?SmJFdThCb0xCRXJkVE4xNU1lUVMrK2h0TW45RGxzcDlJZVk1aENXVjNJY1RM?=
 =?utf-8?B?SHNVZVhwbnl3ZkhHTUV4ZVRpVCtJNXF3a2FKeHFKbGJuS0ZOM0RJd1VxYVU4?=
 =?utf-8?B?QzhQOFdzU1oxd1FGSnplczF6QzBFVXlaUHNxUUY2Q0ZFY3Q0OTNmbVJRTjBy?=
 =?utf-8?B?Q1NhMFNPNW9VdEhJYlB1TklJRjMrVk01VUtMMEd2dHV0ekZ0VTluTmY2TmpQ?=
 =?utf-8?B?Z2kwMWV6U2FMQVUzbVBtRE1CS3ovb3o0cXkwR3phOUV5U092K1RMaTVOT0hV?=
 =?utf-8?Q?RYWdmmq8NqUNgqn5HdlkyDd/m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4671716-d000-4097-63a4-08db47a8d239
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 05:24:21.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JCdRzA/lM/Hg+K2mA89S7ONXwuy23MitgLaAEwp10EBxfkZEeNs+zhBHz38EYK1AhqQERvJulJSCWV1aSvMIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616

On 4/26/2023 12:34 AM, Jason Gunthorpe wrote:
> Drivers are supposed to list the domain types they support in their
> domain_alloc() ops so when we add new domain types, like BLOCKING or SVA,
> they don't start breaking.
> 
> This ended up providing an empty UNMANAGED domain when the core code asked
> for a BLOCKING domain, which happens to be the fallback for drivers that
> don't support it, but this is completely wrong for SVA.
> 
> Check for the DMA types AMD supports and reject every other kind.
> 
> Fixes: 136467962e49 ("iommu: Add IOMMU SVA domain support")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


Thanks! Patch looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


