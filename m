Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E952148CD0
	for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PgeYfyKm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArwYXtf0tmy9mZw/KFY7fUZ/FAFeaGccMYPJlcYtyCiIZIgSNUj+6z6egJ+c5yTXCfZf1Or22vRftsHrNF7q/yp4Opo/AyjTIHumDbtdR3NYoozfPDnt6lTWLIijHW3sJPdxGtcdsXJMsxjrLiXK0QrJ/ASbF+NX9pNiWW/CA7n5IGCtnRRDk7wJAiL4iP7V1D4u4LaZnA72Kh4pB8gss5GFzwL2ONnNWqFLYmCzSsQNVfMGwsAzm+n1ldTziuqdXd03Z9eBWzrWtmhCQIGI6YxnlLlrx8TRJBTWS/gzrJSFNdYFCrjNMsBVOMUGw6rjU0IA0P6fZw+EN5+7jT11Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lP+3+L2Q/ZTM3c+p4VBuvy5NHais/SXSFnu6kIhtmA=;
 b=lb5HZKTbUWMG4+sklKd5ClNDjHA/NtOzd/7m/N5QK4uOJtgzpW80HOiWmA0tMm8t3YWcQ3daeMZKnQbJLUTEflbLkOAB8y/l0jG+xpRiTvZ1FEK7nZ2t0t1QeCCebk0ibkg6dtUsi5zdSlhCcziSC5tuYFwUmqJCfd2pKVVIjjwJSj2sXRH76PFuLGc3y5ubn1liqGiZA49S8iqk6dZsWsHsE3gV7skgToZXPiWR0XlfWGiaI5Xpu/bkHsYYxN+QyVI5yWBK5YHYx06v6J+2E9ll7YqdWcsOoMKx1FGVPu1L6xwshnw68aQsTnVwNdIvneEb/r5HK1nl4nnu6wo+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lP+3+L2Q/ZTM3c+p4VBuvy5NHais/SXSFnu6kIhtmA=;
 b=PgeYfyKmZUNgHvPWwKH0LwFyrCZD3krO+9kynU1I3EugVNd4J6KruyKMdM5rF8ox94q/gbv7BF5Nj2c9HGezU1XYZeT+H0bz4mh+e1dfymioc8378BE5hYQtzuSp4bzSnQuOmQps77oMuV6peJQ0TJIW93OtUVK7r6IOsGwTgI6UJJOj4tYLhFcx9ZeUv3Xhgj3lnKsGhbKkCNrN4yBN+klaA6ldx8p5YVq8zXLhN2aaQKu7hOhqmQMBtfWuw2dfYfYZ2gLW68zR5P4/BCCC9vEbubdGP38tXHe0EmGjOoXfcn2P1ZjA0SCm+PlcHyZ9IpUGX70LOnekZe5DLSZ56g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 13:34:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 13:34:21 +0000
Date: Wed, 10 Jan 2024 09:34:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com,
	will@kernel.org, nicolinc@nvidia.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Make CD programming use
 arm_smmu_write_entry_step()
Message-ID: <20240110133420.GB535328@nvidia.com>
References: <20240103175043.GS50406@nvidia.com>
 <20240106083617.1173871-1-mshavit@google.com>
 <20240106083617.1173871-2-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106083617.1173871-2-mshavit@google.com>
X-ClientProxiedBy: MN2PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:208:23c::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: ca08f2e2-4444-4247-b29b-08dc11e0da21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yFenRiAWurgpoaUBNkM5qFhZS+wbBjK7PRJv2Nv+7s8BUvxHjfk29u3L9yZPotQnMwbnvWx1bRffTBRXDpX/FibEfhGQLBBeS6PrOfpVMvbPsGyP1ZJqpCGqc33oSGPeXybiBq96/RaXhhNsciu2bATs33UNJHzoPC+xXbYv2WvpQ2QTdyftstNiBbed5wG6/TazX0/xROYqC0tuqjEH/He8WBQJOcjuhJ5V3Atp2bdgQtH7TRH4tOm1LbFRtQk00LAEUNGGLoEWdPs+GhWAZmpdkGzuPbBXj63M01pr4j1o5xPHWpKrQg7+HHh1SIyMzOKbrtFvyxY2v7XP6Gh5ZA+cs3IyOw592QxlCB9LUOGeP8YK41dcKIwu+cBkmBs6l0DAQ9jppI6Kt2mbyHKS16ZsIa7l864mW1tag3Nk7ONYEkw/o0cfqsUJm/Ih99zee5uX5usFqpDoDOSZEVBCvRnONYVfMipP2PnZZenCnkzf+eyqQHTBw5/GbnDp2lexRctu/ekR1OrXpxMYoqB8T1WfHgtei8i8wVzB1Y+vc+0/aNVIfC/vbSvpb+t2Vog+BVZNI6KmKYWEU7LFBvXQOS/KLnxfVq3Kv2cXUEOj++4/di1/rZ3CpO1usMwq/IgT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(33656002)(2616005)(107886003)(1076003)(26005)(478600001)(6506007)(6512007)(6486002)(8936002)(8676002)(38100700002)(36756003)(4326008)(66946007)(66556008)(66476007)(316002)(6916009)(86362001)(5660300002)(2906002)(41300700001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pzu0O7mKeqweFPTC6Bx5t0FZyUz9t9KEFGCah89itZqL6znf4PCMu3mDaBvK?=
 =?us-ascii?Q?Tmpv6zsydalDDM8YtYbmgmZ7mZ1esUo0279ihT7Zsf9eEDup3P8qAuc2cQRi?=
 =?us-ascii?Q?E4BV4dXQW7ly4qPlIHknQeFPi+EhYKKgwj3Z2dyriHmh/L29/y+T4UnwSghl?=
 =?us-ascii?Q?czkmIo/v3kEuN9IHi1e8h/vY9VDYWCoeCtp/SqY3sVfj+oQuNQvEFdrehIdR?=
 =?us-ascii?Q?5sAup8Cp0AJ9pGhl6ySazV+3Kj+lnyGTcNGFUyt61PXHrr4gvvV7XStxJCCe?=
 =?us-ascii?Q?PHlcszzhnDWoeTwReboCWIS3ttBvBlCjzVzrEvMbm3/7CVJz4MWEHdkmdqev?=
 =?us-ascii?Q?lsO4LJaM/GF9+Pd0a3QKlLSYalFvSCbbgKSsWOYQwGcDbJ9QeEiFOxxfSzWT?=
 =?us-ascii?Q?W44je4qm/PFC8Y98A5OJkKX4AYeEdG3nxE/HVD0cadaAiFcUliqMQqh9A3r6?=
 =?us-ascii?Q?zlJPDQCVcW9UjwWnCn3nzIVO3PVXvv89I/5lHUElZbFd9xa1TwNdtFMYJ4dV?=
 =?us-ascii?Q?7npaq3X/Q/wPR2E/YE90zxU3KUid0y6mE5kpAgMVZNFCr/ldXfh2c0nQYqPd?=
 =?us-ascii?Q?HjKQfDTmMxC0BEWXWL5ei6/0ET+HKVpbfI+PDJ/ODf6YmyWnLlqezYOYDUUc?=
 =?us-ascii?Q?B946Lp0z9aejPoDKuBZNa/i8B6zRHmlZ1HIOdcAyORbkJZWMHUR9sixkNAjE?=
 =?us-ascii?Q?6yaZXpEcjBWbKExRPm3UtIzAFbQwySZP87D6yIz5AC+ZM35C8egszcEDwB1Z?=
 =?us-ascii?Q?tCQOvXpQjxdcQpJEviwM43gBUwcjOrV4RUmWW0t9gPImwUXKr9ulAx4LXVfk?=
 =?us-ascii?Q?CPFs/gXpxvNxPZQdPTAUU50ZK3A6wamXxanOd6Iaa556ZBxa405F3aUgXGLW?=
 =?us-ascii?Q?DADym/dKz2TKPg8UUytfV3TW1BjTTDR5xcC5zwKqjj08/pHIqv1z009afCgv?=
 =?us-ascii?Q?9kCJ1ux0jExlxX6IH5bpFGJ1hxnr3rHQgjWRG687JgCDEAIU6bJutixau+sb?=
 =?us-ascii?Q?tqp463FcW7P0EGjR+423x61sG+2GzA3ajhPIOeE+wjO1e4awNy/kMKSH3tNO?=
 =?us-ascii?Q?VOg5Cie9gKvRECzpWfD6PaiUvprSYFH4E5Mets1pq203bSvy01b4ugDabNwv?=
 =?us-ascii?Q?/wvmqn7uF9pmhXpKv7NfgUeNjj0Dqae+gUhTEIQzcwfFp2qnkNspfa3Yu52E?=
 =?us-ascii?Q?4/4NIyelVariKzuK2istXZcwRzRNPc57UFX96me6XL5wwytL+qSF8xmt8Gas?=
 =?us-ascii?Q?0WtFncV1UiERcxD1iPywL3zm6asPE+BkiD0FephelsebJsEK5t6GnoAXuO6a?=
 =?us-ascii?Q?rZ2RZOGRK5s6qVA30j/s1OujqGswML+wnbxRC2BNkARDpcp22VkJ7YjpSVXM?=
 =?us-ascii?Q?z24z6zE/QctRuzZGNmNA7P3QdUuWwFSFjuvx2J8ACnuXw1U5GIgacy9IFYYb?=
 =?us-ascii?Q?X2XJQTeCybya1RImHDwTqsT3G8J+7almUOBXteMR0aEKcHvaT7hnNMorohy8?=
 =?us-ascii?Q?JBxl5M8EtEF1jUEAe3aRd8odGKQPWOn4HK7tUBNOx3vHzmPmzn1bSE57R9QW?=
 =?us-ascii?Q?Q5XYhlITgVX46C2T6nga4btWsDp+InKKl/Z30LMJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca08f2e2-4444-4247-b29b-08dc11e0da21
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:34:21.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGbFFiYzUtAfBa511r4F9Jiytcjw+uZy4cp/QH+z4LYH8hzE68d6rG3HEsy+WCzZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447

On Sat, Jan 06, 2024 at 04:36:15PM +0800, Michael Shavit wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> CD table entries and STE's have the same essential programming sequence,
> just with different types and sizes.
> 
> Have arm_smmu_write_ctx_desc() generate a target CD and call
> arm_smmu_write_entry_step() to do the programming. Due to the way the
> target CD is generated by modifying the existing CD this alone is not
> enough for the CD callers to be freed of the ordering requirements.
> 
> The following patches will make the rest of the CD flow mirror the STE
> flow with precise CD contents generated in all cases.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 90 +++++++++++++++------
>  1 file changed, 67 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index c9559c4075b4b..5a598500b5c6d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -23,6 +23,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> +#include <linux/minmax.h>
>  #include <linux/pci.h>
>  #include <linux/pci-ats.h>
>  #include <linux/platform_device.h>
> @@ -994,7 +995,9 @@ static bool entry_set(const struct arm_smmu_entry_writer_ops *ops,
>  	return changed;
>  }
>  
> -#define NUM_ENTRY_QWORDS (sizeof_field(struct arm_smmu_ste, data) / sizeof(u64))
> +#define NUM_ENTRY_QWORDS (max(sizeof_field(struct arm_smmu_ste, data), \
> +			     sizeof_field(struct arm_smmu_cd, data)) \
> +			     / sizeof(u64))

So, the reason I wrote it the other way, with the enum, is because
this isn't a constexpr in Linux. max() has some complex implementation
hidden inside.

An obvious consequence of this is you can't do something like:

static unsigned int foo[NUM_ENTRY_QWORDS]; // error: statement expression not allowed at file scope

Now, the question is what does the compiler do with an automatic stack
variable when it is not a constexpr but with optimization can be made
constant. Particularly will someone's checker (sparse perhaps?)
complain that this is a forbidden "variable length array" alloca?

At least latest gcc and clang are able to avoid the variable length
array, but I wonder if this is asking for trouble...

Jason
