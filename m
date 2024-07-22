Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA7C16DEBC
	for <iommu@lists.linux.dev>; Mon, 22 Jul 2024 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663506; cv=fail; b=JsERVriMDIf7l58tQlP3SbNLndnG+ZW0j0aKINzl+9s8uDPtVHnYO7pQEij5BzUMhboiDACN/cs0eU/dY9bV2gv5EHb/dWA8XqzxttYmXLKfaMLCo4GzQNyKU+yJRzPeHB4YmKPMWURMkAoRT6zLhh5YueJPaWJw8Y2s8ogFB98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663506; c=relaxed/simple;
	bh=fF0ReALave/thojV/+6/aNAtTTn5o4ns/+auZ3GO/gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YSP0YJ6i9jHs9CfOb5Tw4kf5+gAMqZUOyAsXkpZBwL0G3BZfa3Ty7Zfc8XSTcMNxXnAm+wkP7kOpS2IeKu/LXb2pOXKVnY/lzDF90HmAs/eNNeskLNNWmwb+gZEUFqOPlCZTmA6+8219mQM0lDBhNv1f2ZQwiQmAFm2MyCzBT9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IV2ltPhV; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IV2ltPhV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmFwQP+anwy8JKUsSu68w3Nrj2OLZGaNninqd1sGcGnxahaimXs0X5QWWjYDHRpWM2aU16EQop2AzcZoCinoJcOr9BiX2g/f/wa/VdqxN3Z1qpXuWIqlwE+igYyXwBBlqxCKj3bPNIjRCQEtbpBrYvjSEontRHtP4xXimixm9ywtDQUuMvEo6GcTdyXUrt1VUx7h81ghoPJ4XLskW+myIVR7fQc7bhC5yzcdONP/XH3R8j0eXVFFS4S2GYC+pIr+v0F5XEjkaWXAmiOAlpDrsJ0Rsm7wGLiJZVKwf+OGg1K+wEcjn0qylBBwMUl0bHUUC9vg74IralkeCuU9mJyHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYQquMQVUKbXddlvAiKI8D9YrSS5fA594FDbGlPdh/o=;
 b=Jfyh3t1w//T2Er2cXjfnvKTK/JGlDTcn9F/IYtdN84Z7Kunxms0HI1kKOvOJ+VBulC7mkBohYSWIIQyTAYtOEqRmhpTtAQ1Sm7IDB0ex0I/RDhdviY8V1Fy9aoZcC3VlWvPjZzPkMjvXB6p9Z6I/mtncn03NtACjKXzK83hyGyHfxPTIxv5bbWj2l0T4noX0hXHQwk0jjT6CpfqtZqbjiwdx8iGU7y/cwXKzVDXUiqd3f4SWST5t6vePsIOXA2UdSNNLqjv+aBOSRoUoiAekpBAfSRsW34JFtv0O/mAeYuRavuf+IchnAHTdEEahyC+GrwWohhKq66aqWMa1YpimnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYQquMQVUKbXddlvAiKI8D9YrSS5fA594FDbGlPdh/o=;
 b=IV2ltPhV9/eIZnxe7so1XM435EdrFuQb1YUJgKqIQhI31OWTtutDrRT7TZBq42x/L8b6O532fRFQlSyHZeuiKIrGaXN3p2dp93PesrOaJQp0KChurgJ7lXKrA/WSomm87Y0uUgPfRe4ZJUCgOk1jzbDjdVhSZCAi7bBVXYHQ2KgNPp7Y+HVVN7Mjlh4IsNSM+1EDvYZVHZpuBBZR0tbm81HP8gNgqiLdXmgKcsYpBbRz/F25dth/nlBB8XxVmMylplbMawp9UHHDnE46vmDfQqbuVnPm76pHkH4dM/Tz3YHtm2yUSqac1yljHuv0wafRNcePKjXH15ssN1DKDRCZCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 22 Jul
 2024 15:51:41 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 15:51:41 +0000
Date: Mon, 22 Jul 2024 12:51:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC V1 4/4] iommufd: update VA
Message-ID: <20240722155139.GH3371438@nvidia.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <1721501805-86928-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721501805-86928-6-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BL1PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::32) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c52c6c3-fe10-47c7-4b6d-08dcaa662de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ljkiJ1Z9jTQuWbEBFOhmcxSnwBdEl8O+zbrn70sGbIZHhnn2R+Ma/kKJYZ3D?=
 =?us-ascii?Q?CSc84R2z+m/xEWFIabs5+yCQbEmgkHxrBGnn25EWB8t+FGYoNSCSs3t0B6ZO?=
 =?us-ascii?Q?wSo9jeuUVU6TYHJlB7HII63jeQGHxr3q+zCODxR0s/J3tm33I9S2N5NQIepa?=
 =?us-ascii?Q?CxuGf606T7bNg8b1XU4yL1uhGIv58eUZ+fhKa2D72xyC+LywxbxtL9Pe5jEN?=
 =?us-ascii?Q?SUzwjc0Ee8OwIdB9JONBMHM5MWA2B29wVm1/d9WRfJGvyLTfZZoEjasVv6t1?=
 =?us-ascii?Q?p77G/3M7JkUZnnZcxcwKfiVTIyv1hTO+9h7SW5YuTQUFHcNL5F7C26Ie9+4N?=
 =?us-ascii?Q?dqBIM3TaNpNg6rCbesu+sFxd1Wq99TXZZunNApgZugjwRLvWmPtutNSULA7k?=
 =?us-ascii?Q?COZSegqUIHQ7xsEOam7zcq+sscgf5V4SA3HuVe5sTaXcKNx6OVxtYtNcLPgH?=
 =?us-ascii?Q?CVGeLeAp+bzLUuI87oIj2t5Dk1hS1eirODFY2lzp0uAW5LiE1ClgfR5gRuDE?=
 =?us-ascii?Q?nVMtTuWgcNl8nR976pGyib43tMDG9om+X1OI6D5xwoA6bVpM6yrNuGTm7cL6?=
 =?us-ascii?Q?wIgqWhyDn00L/99DyCmI0a6gLSFxTJH5FLRea69oaeyu/H1mBDaVUPiASY2D?=
 =?us-ascii?Q?FPsXzWtr74NI88N8JCeoeei/oC8j2c8O5uYIzaOxGr/H31y/NXVJFvz3t0N0?=
 =?us-ascii?Q?j1cfZsYK4tzjSdM0FEyFciKyPeC3TafOh8kpApVPqa9sVSaUu9e4YnD6Aa2M?=
 =?us-ascii?Q?GY0NZlEw6siAOG3MYXcKVBAAOtoQHxEDPW8hvJ+kLLQH/CozmRLOXApNQfa5?=
 =?us-ascii?Q?FPxMcuahdRXP95bPZ2bXBsc6a04WZWQJW7Ch6/rYlL0zZR3v7giStVHPedLl?=
 =?us-ascii?Q?AEWitsMZH5oJYc5+nyMoAvAtCjDAal9NpFWLjmZHcA3afM3BlvEaDvanIvXs?=
 =?us-ascii?Q?rdqdwLpyX8wce952s7W7YtIpHTDSmynHAljGKOvmJ5Gvdk/X7fEti8oB9Jh5?=
 =?us-ascii?Q?TzCsgADc6RwG3Sp9JJASG+vLnG44rKfQfaJ60FW9o7yc5y6wYuUcS8AOPUSc?=
 =?us-ascii?Q?D/s9xRlreQdKui29ro46cHNUMz5YVx3bVWTVT4Ooh2UMgOyOJyOO42Vp7ith?=
 =?us-ascii?Q?zCBN8owJoavsp5iTyDkGXwlHgr3jUf2S/sj2yyB/vcmoW5DnJOawtZWG0mxN?=
 =?us-ascii?Q?Q4eMGriNF2VYmCx1SqwNsGQml8uA5wzR5JWnqz/Oa/yDfgunzgUx8mFsMZx2?=
 =?us-ascii?Q?zoILSHF73rJsLfu/BsRgrTbfWLg6u6sjd5GWYLxK7F20bq2wzddUi8Zx40B3?=
 =?us-ascii?Q?YyUvbHcpA20jzeFAFjraqRBVWqqAHF1h+NwooTut1YPHOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e2jBf1GK+vyduIZsmcJjrqhY3YdqZ4S/YroDXTbD/Sy+2ivDdQXVSCV+SKTh?=
 =?us-ascii?Q?+++bAryCBy7bDay1bVOzJpSB23kTHW1L12WSz+taSyeneHHElBE+QjLDFKCj?=
 =?us-ascii?Q?U2ppnY3Phf2KfbTlFRnSbHWTqSoMKzYRZ4XpBIjccUPmD0Jm+W5vp12VIzD+?=
 =?us-ascii?Q?7+KX56Xwaz3gYUZ7cQ1WdyjltnJ/YNOnfv4TI+wdmp8OfGUo8WWijgvYUhoq?=
 =?us-ascii?Q?mEPm2YMvVv5Nl+gBJsWgcHcFhDyuj8krRez+DuQzaVZtefA0/CN4BPtSZ/MI?=
 =?us-ascii?Q?Uhk4UmjxbyxE54hvxM0ch17JNm6U1dU19a5la1GejfbJD+zut5S+J/1JJm3l?=
 =?us-ascii?Q?myIaAG8EOqBChiRTVLFAb5vKt+VHY3qK0IdaliWoA8BERhTL+dU3A0TQNTO1?=
 =?us-ascii?Q?/S03O3ARMH4YddJphoaCvG74uUMI2U/6YIi2eCDKM2lG3Eb8L8hPNnq6O3uZ?=
 =?us-ascii?Q?zxi9eG0e299G4p0Qyqj47azqZr8w7p/WFLu0W90FDQ0AJObJvOzWoCNKTH6b?=
 =?us-ascii?Q?7LNWLP/QA3PHNZU1XKy9cJq4vFLixJGXUTHaYwROSCDEVjNcAz/kGZ5ApN9+?=
 =?us-ascii?Q?DvbkkO1yviI6WU78Ea7HOhbURESTaC+Q6XaLX7AVm7zpeXzYlH10DO9Yq9Q7?=
 =?us-ascii?Q?3SGMwFM1EmcppOqFyBl5JkSCCJfrwNT2ERJQ7d5vvEa2eETP0cqQXkR64QZm?=
 =?us-ascii?Q?RYwQJyy1jnQv6CCZ/JxLrVTI8GM1ueNz5aVsjio2+ptXE+gb4rKQQIs4+lC9?=
 =?us-ascii?Q?WashIkQ2XwYxa8Kc3zIzsiK5QqOCXHmYCQJzYNavAE37TITRbGAh4g2aGdIg?=
 =?us-ascii?Q?1IzDCkJi1rPsHmkkmmnGyoCuXprbZ16bfwu/TeUb4tyEXnmUdmKTg0WgpgC4?=
 =?us-ascii?Q?2LCLnW7FARLwn+sMXMsVVfu6ah9t1v8DbkMyWbFg6yzMg7VXthXkuNGW8W66?=
 =?us-ascii?Q?ji7ziUhULCzYgcv2D2yoq9kI2MnFrwbGNQ4X8kPxGN+Pt4poKftI7HhvFa0A?=
 =?us-ascii?Q?Bet3DYywHhkM80HKelq+hGGtg5ZBHLtLFBX3/sa1OaOgkTzHCOMNkfSFs3Bd?=
 =?us-ascii?Q?kzZzKYLXfi0VY4v2EJS4co0X7LiiShRQkeoxD2l3halCsHWyUHERo/qJ7Xn1?=
 =?us-ascii?Q?KYVjiChMdvKOATWGJM8EhPf16HctNXhuMp38ibSpMakfSla1s6hUDeiuXwJ+?=
 =?us-ascii?Q?0gKB8XZkB1jTGB1cgCpZGnTw7wDOJkPjGj5bWeIrqOUxEg5rxtKxW+M1cD8E?=
 =?us-ascii?Q?8pLL3Bkym75VbUOA+5mf5eVqfDnIBo55qK6w61Nl5irDL2H5L1YL2L0Xbrrd?=
 =?us-ascii?Q?YURo/HlJZvLGfwHLyCOwo6bZBTkCFeQnmzaMDmlCMBmL9bt0jD/QyFOmp1ro?=
 =?us-ascii?Q?UW8gbNhnHOHDmoBLAGCOMc3PeEVxzTRXW1VzWvVbN1Qx0ly/5iqk9ZzS2sWR?=
 =?us-ascii?Q?3L557DyNdJ/DIbZr3ICbMiRoOnJwDan/elyRdh2YYM+e3t7UKzYtQffypifZ?=
 =?us-ascii?Q?ENfaZME8WrJoD1X6rFBvwCHlkY1YDWS5hjWpmhFFk7WHWFAjqb6UD5hNLZMd?=
 =?us-ascii?Q?rHUGPrbp3m8aXs7bPtQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c52c6c3-fe10-47c7-4b6d-08dcaa662de9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:51:41.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctwmCZnfMart1n48XLwVw6iy1RpIWcjSOrl7knswg/w+Pmaqe2ojyoz8Layl/0ET
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

On Sat, Jul 20, 2024 at 11:56:45AM -0700, Steve Sistare wrote:
> @@ -458,6 +459,76 @@ static void change_mm(struct iopt_pages *pages)
>  	free_uid(old_user);
>  }
>  
> +#define MAX_UMAP_ENTRIES 1024

Only 170 of these fit in a 4k page :\

Are you worried about the high order allocation this could trigger?

I guess the alternative is to load it into a maple tree or similar,
but that is alot of memory allocations.

> +static int iommufd_get_umap(struct iommu_ioas_change_process *cmd,
> +			    struct iommu_ioas_userspace_map **p_umap)
> +{
> +	int i;
> +	int len = cmd->n_umap * sizeof(**p_umap);
> +	struct iommu_ioas_userspace_map *umap = kzalloc(len, GFP_KERNEL);
> +
> +	if (!umap)
> +		return -ENOMEM;
> +
> +	if (len > MAX_UMAP_ENTRIES * sizeof(*umap))
> +		return -E2BIG;
> +
> +	if (copy_from_user(umap, u64_to_user_ptr(cmd->umap), len)) {
> +		kfree(umap);
> +		return -EFAULT;
> +	}

This is memdup_user ?

> +struct iommu_ioas_userspace_map {
> +	__u64 addr_old;		/* old userspace virtual address */
> +	__u64 addr_new;		/* new userspace virtual address */
> +	__u64 size;		/* size of the mapping in bytes */
> +};

Use __aligned_u64 here as well

>  struct iommu_ioas_change_process {
>  	__u32 size;
> +	__u32 flags;
> +	__u32 n_umap;
> +	__u32 __reserved;
> +	__aligned_u64 umap;
>  };
> -
>  #define IOMMU_IOAS_CHANGE_PROCESS \
>  	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
> -

These - lines should go in the prior patch

Jason
