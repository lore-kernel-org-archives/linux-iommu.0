Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BF54765
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389639; cv=fail; b=f0MQffy2J0aKrR6BKHJLUs541cdMIxYQ11q5yN1NCYKpu9DNw86ttiYqUFDJZ6GHBXL9gGsp+/Ve/Lp3wJ6c8prTYn2ncT8BEo8fofSnFtdXOEs2bHKburxdh19O8JA4hJStyTf36Cy6wwpzbkY5cv8YmC+2MY3e0JTo2qm0rpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389639; c=relaxed/simple;
	bh=c8OiHup4V86vNGEOayVSmZYJtecARLe4AlFA0ixMfR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V7/LjA8d6UpsZGuoSvELWwqHe1Lm2k6hiW/CTwzxZ/lclEvLDdpmX1tJIUVpiyJVWTX5nyN9GVEmZFcNP/zE5oQQucjof2+Pc3Ge/VcH/EW1xd+97YXOFXMe1uLwoNQWZE8E4ZGkAPfTHG0S0Nx2aC5LLXB2HoM1ZFZqwOf5XoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WIWBKu1V; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WIWBKu1V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqHwAckntEO5PFtAL+penhYoJVIu2Ba0F7vUbtBhoL2WOhBO9A8BRzPyy6+w6eDusPqeqnlMqOY/3S+M8oAWTjy0DSDCPltk+kKwXaD20z4uCkKdI+CmCk0oEUDfYEjCwn/s2WREzKLjw9cOYn9Gwqdu9zfJa3pnepZUgzC+TZgzpWC6cIM7UrRgrFa3/+Ll/3nOBz8AE9AZWFSDw9HdChDFblB3l3GBzssfqJ52hXfM06ofDW05EExhgYY1hDVI+yEsCQVh8N9V6o//P7Dddjt3mDO2hxkg8oJdozOzXg+JefIH9wrcVISL1JutLmx97y13VFza28eGRQy+dqqPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzkdaPiBd+2rrQB3VZaIYPBobHGOq6ni9y4rOpELsBs=;
 b=DFL4zIy8hO5f8hAj+7c5OpNE/BMhfQyQImruICWDKXepgBw96AhchjtTe0J+gkZpd3RSbqUl2nJ5rG8BT3NT4f2KkpZosBeqGtkl/e0gbgUHFx7AGskYchXkymXiTsl7FfCoTQc+AhVvQd6IsI2wMmQ28DV5f45JULkRz59rt0nTYyHk8+jvxUOrmYQS+3jVoGu8iD7UVUB8mwWDT+bkKQpTTctasZvnBBHK0y3pe+Z66UT7Tk9xa0mE9fyib5xIOVq+Wc1WA+eQ0bDH9P7YpMHXwXHjfKeeSu3jurSw4D4PvcH0x5Npzr5f0EFOS0Wkk0Bas6i3NLFq8xToDNPAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzkdaPiBd+2rrQB3VZaIYPBobHGOq6ni9y4rOpELsBs=;
 b=WIWBKu1VoGGZEen51CQQJgM9YrvHu3R5orGF72DKL8Pso+fFdkrCKZaZS1TqQsJMxpPcaJOd/1EmTDM5p1pcdJhKVVtybQ1mLC7BB2ETONH58cxywIsHvgTc38oUK+a9BbPA+2RnF+x+IxaKEPumWybTUrM0jjHVZcwAmc1sXrLRHZY3dT3eUpJ1vIC1apOjhco6YFQMrI4D24wVrpRS5JuhGQgzrK+19OBeoL9kXBARHls/NgH8AxrO8lWmMrWyQU0vYAFj5AVe0c2AGJVK7vqf6DS6dwmNo/ok7C+tAI4FTNldVtK36CCsQnvhEWK2dOTnvJRorr6/uzp/BTYLcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 16:13:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Mon, 20 Jan 2025
 16:13:53 +0000
Date: Mon, 20 Jan 2025 12:13:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, jacob.pan@linux.microsoft.com,
	robin.murphy@arm.com, nicolinc@nvidia.com, will@kernel.org
Subject: Re: [PATCH 2/2] iommu: Swap the order of setting group->pasid_array
 and __iommu_set_group_pasid()
Message-ID: <20250120161352.GL5556@nvidia.com>
References: <20250120030840.4171-1-yi.l.liu@intel.com>
 <20250120030840.4171-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120030840.4171-3-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:32d::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: e4541666-f817-49ca-b835-08dd396d6f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K3ZXe8AWMsK6/wGATfAp0OJeoP2fmo69/Pe0vDckseavkKxxRUTwajto5MPD?=
 =?us-ascii?Q?f3GY/DeXO9bYZylwKFEJloNLiTcEWVcHhK8hQAKJ6FbS/UVCyJCmhWf9JyKp?=
 =?us-ascii?Q?p6qM/cHa/YQ1C36CrbEd9Bdq2oBMdGOVHpy4Y6tMLAysRFVrKSATVmiDPdd1?=
 =?us-ascii?Q?XIGtydXvsXttiEoYMAkeqJ9dLAiuNb+rcos37ivtQVEZqvqs79i1Y42+ixo2?=
 =?us-ascii?Q?53VzY01kzzYyMToOpf5sU2pslw5BdWU7Fdt+9EbWWWpsgcw92tNwOD3UavTu?=
 =?us-ascii?Q?ZrNFdS+WFE611SWMGo246sBXHLB7xhClokvfDcCoz06SlrFE0LnCK5JzAuvS?=
 =?us-ascii?Q?r1zhvTW9C6gjpvFvG7modgrDHr+tAJ5c5/roEiZcfO7JPKoixfHBKXuJ6SR0?=
 =?us-ascii?Q?SbmxLUQIme6tS0JeDynl1jzX71CRPaBb5+75GGer4fJrJanBgJ2C5vPJhEKL?=
 =?us-ascii?Q?Dqky/A8UXGO0k0FRjEY7N74+NZB2FmGKagqHkDqvf1kajr+Qu+UfgWzPd+Ou?=
 =?us-ascii?Q?F3HQM3E0td4o6Jrl6ntSbCdvvWwGFr745vpB4d9PkbKSb6Ib7KI1xSrfV6am?=
 =?us-ascii?Q?r8v47mXbn7NKcmow9KyTGiGJ9fz4bAon5Wg+ybPzQTh1KND70M9KAkHDZP/N?=
 =?us-ascii?Q?LTSS5JDLlkWw0G7xleulv6nOebGHU3FfyrDZXu+wMHqidjD5fUN3LShNX6e6?=
 =?us-ascii?Q?bQ1OlLiWBlNvW9p8PgqNsgSEGipPrJ7duylQf5yRXMcBWmwGH2+mzQG+kUUw?=
 =?us-ascii?Q?l6MX6WE7ZRhOHUWZ6Tkp3RBj3g1kUUI9yDeOktGdcCG8qrMyq23QKglWXkEP?=
 =?us-ascii?Q?SlTBGCEEfYmEUyCWtAV7oXZGGAdoTAKrnmuKSatqppcStem4fFpEbE5ZcGjv?=
 =?us-ascii?Q?373XyN7itZizqhuLH2C6UJZm5TXiKQD76ZdgCG4SpfJIV7rnczjIlPxR9PiI?=
 =?us-ascii?Q?juhezK4SdqMBtBs94/kGWntKliE9+oyR0QX0xWNwQMMUtba68GfcdwTBzrPG?=
 =?us-ascii?Q?6XduYpbMXnKHxkltv/w0v6YXETSFzQPpxzl1jrSmIpSQZznv7cZfbtuFUKfi?=
 =?us-ascii?Q?VpSKthXn2F+3df9zgVXZZahdsnG5qNC3GMo0VLAImDN77pWc6185W0f/i/DC?=
 =?us-ascii?Q?XYf/N69JxvkXmzU1FedZNyrfDMa3ACEhhkzmCcwn7OsEdp22FuypfUaoPIu/?=
 =?us-ascii?Q?15vkyOwyr/oV/uB2rCjZ5MvZwNVZQ8P/mnGBr3m9mxcOW6+3EnJAHi3oGvk1?=
 =?us-ascii?Q?S+mMfJr1ochPd78ZJJD0SA/jMPmuWVikFx2pASOzPtmHt8YU29pDCRQfdP0k?=
 =?us-ascii?Q?GNOdN+428y/09t96Tzzy/YIXMM5//Q92a35ZNUHJb+IFAh/9auc2kTXeBofB?=
 =?us-ascii?Q?synR/zSoZP0eSZPzf1SNffMugu/e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EcAOdTt5a+2hQUWhvU8eSYVN/7jJq8CTdt/OXp8/ObPa1/T0mJnsGgrnl9Fl?=
 =?us-ascii?Q?YoMUh07ka+VWo0A1apCDhhD9tKzSEviefJE0LRMaRURqdh6BhNbNf/AB7cPJ?=
 =?us-ascii?Q?i5bOOvpPIcizeA8pn2WMzUCU5I2BUumNdAbp/shasyTOD4Qb51oeTTkx8K58?=
 =?us-ascii?Q?D8eYjAHvrkFgEQ17EtxnpgTpBRhV0At/NSwmv1TiBcJlZWIQixQGJ5XyNewv?=
 =?us-ascii?Q?D5ur9naMkCIFRmQeDtcjVCXYoJ5keov9lbcFaJxc5ujvHz/5fLY1yB/bGjgT?=
 =?us-ascii?Q?BbH+XepcZk/XqpBQ2OMieq2D0Evb7SKtnZEXGmFBtcfb1v7RniGGsUSDb19q?=
 =?us-ascii?Q?dM2N7U8Vf2LxITbQQkXmQShSo2Y1aONDnlrM/w9/IaBeV0ldYFQeUYd/Xv3v?=
 =?us-ascii?Q?C0wmXIKzFehFuBln+joSWzLfM9s3w0xUhK2wGgk0cpJk3A2BJ08jRGAxdbWp?=
 =?us-ascii?Q?3D0ZD/qCl8Tub98wgK5I5gWRw+odlLs+fFc6EXnXWcD8YtZeeEj5w8UPS/S5?=
 =?us-ascii?Q?u9VwaAa/E4Zn+FXndhiRLu9EBMwPNtWe2AopSsW5LytxS8Ul6uwahSo8laC1?=
 =?us-ascii?Q?9zQ3DUavrn5mnX6/fOCP7i5qyfK3ymQ0X7C57m/cVM3sKDSLxZBcSEfUWGSP?=
 =?us-ascii?Q?DKUS6Z25uGtttm1ZI4SNW2laKMJP5JEIT1c6J6j2pxcZ8VHhV94nSxbkZwpk?=
 =?us-ascii?Q?whQ1W8z95jxO7V/c7gAtaDQKVgCP6bXZUKfRUZEC1vyd5BsoUVm9GpodCnGN?=
 =?us-ascii?Q?gszrgkWuZ7gU0LTQPI2HZMSmEVuFhxKMoN82tFK1JSGgvBJ28S9MbeJ72/wD?=
 =?us-ascii?Q?uZ0NKhTOxzmYcnphjvAWbxCQOGhnc9Luv/bKeum3TddoL6AAPJZrz+j8LB4B?=
 =?us-ascii?Q?+Mo51o/qlHWUTLl0iJ1Cw6gC4qE19g9dMGvG3l9a5F5gFXBD5dUbn5OPuAB4?=
 =?us-ascii?Q?dVCn7oIwGGKcaHwjn9CsfJ8lJHqH3PyDtDWl09avGVlsp+5mhYNVgcf8y1vI?=
 =?us-ascii?Q?p6nWuJ4vGsSUPQFM0v0XSOehFePPtg552VICVeWizbWwcF1dyN1KwuJjbGEO?=
 =?us-ascii?Q?jO5j69Z0rfEYhn/UZhTytAjxd9J7++hIaKVzJiIUNh+4IFEJ6jlDabF03jIX?=
 =?us-ascii?Q?H5026GUkr12F9UajRlMDxesCbDI8CZzRssxxuEnTKGW1iQx/W05C8SVfdMhW?=
 =?us-ascii?Q?gElgXL5yp9Pa0oXxYDRJ2mcOuNAZL7gXFwwiSCjVliWEdBorsOFbkQ66sa8y?=
 =?us-ascii?Q?BGnotuNi7iCXs9RoRdBFVfp7mp23T4ucHAkZ28s2dV66XKv7UzF0FqS1OxaD?=
 =?us-ascii?Q?2YU2R7IM9Y4JYsPbbpPy6gqwgPPOYvawGXh1GyJN80LiJJfU3UoxFQpmTUyL?=
 =?us-ascii?Q?ppwu1EKyGhsklQWc2UkAnACkkj1XJFlFps92Z6pVE6ovKxVK6u9k0d/39AQb?=
 =?us-ascii?Q?+eIyWA1Y0JSZFYtJqKGPkGTMMShA5wiRw410lXTDpR19YYtYyYTJCCWj7KXa?=
 =?us-ascii?Q?P6qt8GgWvS26ymp5Y76ZQXwN+n/sYlgaF1IEglW0QnRTLQiKqWuTODq9vRUE?=
 =?us-ascii?Q?Df1Tr9Nw6W11mWOMOaKL/8haQkI4x8kRlfzFIiXv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4541666-f817-49ca-b835-08dd396d6f3a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:13:53.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+llEQAn032LBRQKbUdIrTUToW2kM4nvw8GQ25a7JCuBaDOi+t/taljKHDqObO5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651

On Sun, Jan 19, 2025 at 07:08:40PM -0800, Yi Liu wrote:
> Following the current order of setting group->pasid_array and
> __iommu_set_group_pasid() in iommu_attach_device_pasid(), PRIs may be
> forwarded to the domain before the attach succeeds. If the attach failed
> in the end, the PRIs on the domain need to be flushed in the caller side.
> Caller can do it, but it can be avoided by swapping the order. This is
> more self-contained.

Can the caller do it? I thought only the driver could manage it?

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 278c4eb8f225..b69bcf559839 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3376,7 +3376,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  	struct iommu_group *group = dev->iommu_group;
>  	struct group_device *device;
>  	const struct iommu_ops *ops;
> -	void *xa_entry;
> +	void *curr, *xa_entry;
>  	int ret;
>  
>  	if (!group)
> @@ -3400,6 +3400,16 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  		}
>  	}
>  
> +	curr = xa_load(&group->pasid_array, pasid);
> +	if (curr) {

No need for curr

if (xa_load()) {

> @@ -3407,13 +3417,12 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  		xa_entry = xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
>  	}
>  
> -	ret = xa_insert(&group->pasid_array, pasid, xa_entry, GFP_KERNEL);
> -	if (ret)
> -		goto out_unlock;
> +	curr = xa_store(&group->pasid_array, pasid, handle, GFP_KERNEL);
> +	if (curr) {
> +		__iommu_remove_group_pasid(group, pasid, domain);
> +		ret = xa_err(curr);

curr could be a valid non-error entry, but that
would be a WARN_ON condition due to the above check. Like this:

      ret = xa_insert(&group->pasid_array, pasid, xa_entry,GFP_KERNEL);
      if (ret) {
		WARN_ON(ret == -EBUSY);
		goto out_remove;
      }

Jason
