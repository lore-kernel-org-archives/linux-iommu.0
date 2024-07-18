Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB472C1A2
	for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721272877; cv=fail; b=Qwl0Nhc9CoSp+FSXz0kDs/5mfMlni7lIxkUDQp8yF0fk+geqx5Mc8Eg7sUDbqa/M6N5A+VDk1skhNvNHCKs7JAhp4/VJcH9BWWBQIm3WpPwHNrUEjGpF9pBMV4ug4Gc337G6rVYnPR/B9DZQVwUCz9G3voIK1ZYseoKFsx4tJD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721272877; c=relaxed/simple;
	bh=gBvRfGg0EfvgTl8cS8I2pFYKvyRoSTb6tH4HobHADoU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sj30VP5lNKRZuAgcTEoYU6qhhwu/P4Yu8U+R15YtVe6933n1jJ3K5kF5uU3VpECKivlqPbBVwwTE2uUElbvbZtFuiWyP98zB76cRvXgK7k7rmMdCqxVhlBcyVQ/0Vagb5GSyq74gg5hE6gYG6TD4A0CoTuBB9Vd3zjM3cDRwlQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X5rBHllf; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X5rBHllf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzFM+yRL8jRh/NymK2gUoNU//lBIQErTwMeorWViSsPo2PNNe3Nl6mMqSLs/M1EIeyOtRJWWC5Ba5yGCNtQIf+zVf4gnnbnxFABwLPgN/WUrhhQ7VzkHioMHXRL6isZcDinTGsbrE6UCoB+eYY6gd+wLm9wKiblBOGWBOcCON1eBilbZwhcrqM5ZYYQNBb9utE0YKpJCB/4ppoiFYrtPjrB020jezMOOkqOQGyM+w8uQ4bpXLXacjApcW0YRP0LisbfyvT1KIryaT2CA3Ui6pqyseYkbpdhIV+F6yNIXaThoHzC+Y1CJdJg12g5mEvPpqL9LbGtTGghLtQ4/PcbIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvAXgzcYQOHpNBT+KafnPP4RaCG40cPJgVOUVEfy4Dc=;
 b=FRcq7/Vo17TbanXdj3XIJZXi5RCWM3qPfYbWR1kQiuoHxnTbFoThl+LVN8R4d19BsTvQ5xpQjBOwAqm7Cqu997beGt2VCkGYbwG3jBsl/aejPB4H3nneUjnr0DKuhkECSQaG6Zy5mD4N5xYZEjLxv+IWY1Jkdb32gXKAC5vGxG0DN5/0cnjkCvjU0nXEn6C6l/+LkFK04QwnVUkfynO6D5181LoFS90/YHXcjTJ0swZFl1ZQTlzOndeLnq2CFa7jm1FxnFZNu4GhSjOoavT7pp50X7ujVCx4qTO/sXSt4cNo9NwwOEVGEDQJ/5uU/xC0u4lfSfeOjhkhgxhL5hFAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvAXgzcYQOHpNBT+KafnPP4RaCG40cPJgVOUVEfy4Dc=;
 b=X5rBHllf8VIdf40ECnrw0yXXMwBwk7vUjsfagSSr2WdvntPV8s4t+OHJ6DUfP6RmoCTGatXMkRO7pRAcfjEHA2z4Vptj3Nkl1fG8QPKOS3gc9Yo18sa4NSWvKYBXqkpxa97EAUhIAb1jeKubrZvHGQ0jfutCYIlThXZQRV8C5L0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Thu, 18 Jul
 2024 03:21:07 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 03:21:07 +0000
Message-ID: <ae7e415d-0e70-4d84-82e3-d6827f931565@amd.com>
Date: Thu, 18 Jul 2024 10:20:59 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Convert comma to semicolon
Content-Language: en-US
To: Chen Ni <nichen@iscas.ac.cn>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240716072545.968690-1-nichen@iscas.ac.cn>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240716072545.968690-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 9343b168-461a-4618-12fc-08dca6d8a965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZElzQkI5UWo3R2RRV0h1V09NZHBRbUFNTDNaa3o4a2txRkJaTVhwS2I1d0Z5?=
 =?utf-8?B?YzltdHhmdGZKUWVnRktkRENqdWxkOU5odHVzbGtaSVVON3drNmY4SUlpaklB?=
 =?utf-8?B?cUpLNlZZcXRVenhKWTg2MFNMRXRmVUVXalg1V3VweVRWcFdrMHFPaC9WNXZl?=
 =?utf-8?B?TkZRa2R0MTU5NnBxOU1rQnVQS3M2RVp6b05TWTV6Q3RJNGh0amVPREU0T3Fa?=
 =?utf-8?B?OUF4eDF4WUVGVXpJck1lRXFwNnk4Z2VtTWd1WkVOck9lc3RSMzcyU2NldjVX?=
 =?utf-8?B?OUVjWEtucEh6L3ZpKzBHMkcvSFpnbVNhNmtxMWZzalNtMG05ekJXdFRwd1Fz?=
 =?utf-8?B?aUhIa2U0a1ZiKzlrY2tOa2FXWmJLMUp6S3NKUVZVRFBIeUw2Zm9yeWdGancr?=
 =?utf-8?B?aGNkSUx2bXlRWFFENUVJTmVucUk0WXRiQzJVNXp2aGorcUYxbDZ1OG11dG83?=
 =?utf-8?B?UXpkTGIvbTR5d25TdGE3RVJOYjJtMWhBVE5yMXlFTjRUS2R3SW1US3U3NDhI?=
 =?utf-8?B?SmtWY1B2N1pUV1ZWOHZ5eXdkMk9ucVUrK1pqRXJ5WXl4d0MxQm94TEZaRjVw?=
 =?utf-8?B?cXJ0L25nS2FLd2Z6QnQ1R1NiRnFTLzNFTEtyS0tRWlRqQllWT1l3SEh5QmZq?=
 =?utf-8?B?b1dRc2JQT0ZxT3F4OE00ZW12OUZieW1CV3BGQzFrZk9ibVdZOXRBeDVraS9s?=
 =?utf-8?B?dXAwQ3cwOXc1MHlQVGNaeEoybnM5TVQ3aXNGK20xbHF5U2QwUkZQRWZKSWVH?=
 =?utf-8?B?TXFWbUQ0MUZHUXZJY0phL0NhcG01VjlOYllpcjE3OFlaQXJvTjRDNTU5N2JZ?=
 =?utf-8?B?eVVuaUwwYnJQUGdzTmozUkE0eVNIVi91RDhFY1gwbCtSMUY3Mm45dXRoMUo5?=
 =?utf-8?B?RXovdE1VcjB3WmZsS2hLem9XbGxVM2tqckVKcUx2M3VxTWtHc3U5VG1mQnlU?=
 =?utf-8?B?VU1DaVBMWk5ieUdsNEZ6MTNUNkl1bGJYMXIxRlZGWlpvejdLUTlkTGhqWndC?=
 =?utf-8?B?QzkrRGloQTllRmYzRFdBQm9QWE9QT0d5bnFTdVJLVHdKZ2NRYlBKdVNTNlU0?=
 =?utf-8?B?R0RVUys3em16VGJVUlNzOXgyK1FiS040OHdiczROSVM2UVY0MTk2dVFOaXZV?=
 =?utf-8?B?d2RwdWp4eHoxT2FXdXpnTzlySjJqdFl1U3drYjhLaUx0bENHdGJBdktwZ0k2?=
 =?utf-8?B?bi95VnMxWFpNUXorc3N2WGg0WE1kSEJ2S1dHQ25mQnVWZ2c4YWxXbWFWT2Jh?=
 =?utf-8?B?LzVYK3hYem9wbi9rWmJLOVdRcXJvN1NvVkQ1ZzFqM3d3M2lIZzJqMndVQWg4?=
 =?utf-8?B?UTlZelBFRlJqcnZkYkkvbjg0L1ViM2pMdCtKUVpBb0xLSk5HMUpicVFPV01t?=
 =?utf-8?B?WUFjdzhBdDRWY1pHUFpMclI2WUNFbW5yZ3JZUmsyNDQzN3FVcFY3c29FVTk4?=
 =?utf-8?B?TW9WQlVsOUh5S3NzNmJHOXp0UFB3Tjk4Y0JQVWpWVVdnVm45QzM0REFuT1Vm?=
 =?utf-8?B?WmtLbUUwUjRyUjYvUzhPODBFQ2FyL2UxZDEraDdLWFQxd2UzQlk4Wk5lTEI1?=
 =?utf-8?B?SmNqYnE1VHpuU0ZaTHlsUVF0cVpQbUlua3RqbWp2aUhzOXNURmVqM0x3N09h?=
 =?utf-8?B?RFF3VkduT1hYdXRqaXpMRjU3bVQ0Ui9FV0dMbWRjZU9qYkpiRUhXRDhnK1M1?=
 =?utf-8?B?ejhDSzJVZUZJY3VSRnNjQzBaVDhNYmdYUGtlRnBlUDhXbDFJSStEYWJUZGkx?=
 =?utf-8?B?TnlMeFZuSGloa3UzTlhCWmQrNHNxeTRKQkVuUEowSXN6TExEVTJGWjZzT2M4?=
 =?utf-8?B?Tk9pUGdKaGY2QTYzeXArZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXFveHRZOU9WR0UvYUpqd1Jab01GbVdlSWI2N2V4ZlJ3YTNsL0I1MDFRWXVn?=
 =?utf-8?B?VG4xRFRMYjhBNGRUaVFieWRuaktyYWFCNzJBOFdpVERNTTM3ZDhiUzRwSWlD?=
 =?utf-8?B?Zy9rTVFTR2FWVHFvT1hLWmhBd3d1Ym4xemxoQlFCdHJLOWIzYnBBQTVUc2pR?=
 =?utf-8?B?Z2lkczF2cURjckgxOENOKzhubUwwa01BVUpCT1U1a3VxcFppOGZPQnU0UnND?=
 =?utf-8?B?YytHaTNwS1JPRXpMcFNNNTVlVEhkc3RUemt6SDhVNjlWeVlzeStnbDFrMnRt?=
 =?utf-8?B?ZTRWdTlzUmlQU3ZBM0t4Mjd2WjhuZnhlRFFMd29YUU5yOGplT2VGZEhINlk1?=
 =?utf-8?B?Qkt5SUJtK1RLWlVTRElTTVZUWkg5TVN1SUFRQk5pMDk0MWhBYWJNNEtYdy80?=
 =?utf-8?B?dlV4alc4SDhNQXNxbWdiRm5uMUEzMG5nYWc3ZW1RcThvdHNJd2Y1Q0xHa0d1?=
 =?utf-8?B?SENjTUp6U1BKR1JhZ1R1eFB1LzM1Vk5HbFlkNm5YVzJMN1pqNG5ENTF4RTZU?=
 =?utf-8?B?S2hLY1h5QjRBRkQyalo4YTFDZm9rdEZVVWRtaytaQzdva1hHV1ZtRll4Ni9S?=
 =?utf-8?B?QjEyYjhIWnYvUHdiY0VDSVVUcE84SmhEVjA1S1VlOHhWVjZrajZkREt6QzBa?=
 =?utf-8?B?a1I0cnZMZ1R0ZWYwbDN2OVZvMnh4b3FybDdVdWtKVzlqYWo1ejBqZ1RWdVda?=
 =?utf-8?B?SWZtcG55VHJseUlHcGZFRHJoQWYrblN4dTlROXIwczRIdGUvZDBwNDFqUDRQ?=
 =?utf-8?B?WDNoYlI2WjJKM0pHcWlFVEl3L2tuYXJZVkFMQ24rMjl0UFZNNDF2cTVoczM2?=
 =?utf-8?B?ZWRGWUp5Yy8xVDYySmRkZG9CY0RuZ0drVjBhRXR6NXJnWFJ0czN1VXptc1JG?=
 =?utf-8?B?elp0MU96RkhVa3o2QTU4NG9lWEdReG1LRENPWHNjRThtTk8zcTZTalpic25I?=
 =?utf-8?B?ZVdEQXk1Y3dyT3JtOXRyb0F6M2g0REZtbE9yNTExUkx2ejZ4enBqM3N2dFll?=
 =?utf-8?B?dWJlZHdiZ3FZbXlFeXI2K1R0ZmRxdnlraDFoR0ZiRzF2c0VDeHY4NGVKYTVq?=
 =?utf-8?B?Z0x0TUpYWWNHbGVEbG1PQk1JaTNUTU8xM2VnK1pXaGFZZmtHb1FKcGlmb0hT?=
 =?utf-8?B?ZkpiK0xvc2FHUWZvei9YZDVRNURZK1B5L2YxT2pMNlA5MEtCdEZLVFI0QlVk?=
 =?utf-8?B?Qm9wYzJkZWVtYVhCUlUrdWhWeFNwU1RhYlE1d1NMb0hZSG1yT3Azc2ZzcEs5?=
 =?utf-8?B?TkpxL1l0cnlSMG1nSW9ZcUxUeFY2UEtzbWpFSGJKVXBqWURPa3l3ODF3Q3Vi?=
 =?utf-8?B?cXE3dW8waWFWNFhWTVpqVHdiOHhObENlWk0vdStCQ2JYWHVtOEYxdjBpNnBz?=
 =?utf-8?B?ODJrR2ptZE9TVk9FRzRVOGFRa2ErWVNQdTRVM1E4K2p0RHBUeHhXdnZhNjBO?=
 =?utf-8?B?dmRRRVpONTEwMG5CdGRQY3NKRk1NU0ZOMUhnVGxzSzVVS2F2bk93WXUvMlll?=
 =?utf-8?B?bzVsQnY3VGYzcndKUlJGeCtXMzltR2RIbGprSWl3Vmo5aXR3MXFTOGpDclps?=
 =?utf-8?B?dDNsYVhTV0dGVFFnK3RBYkU0aFZMdlBqbFhwdU9vRjczR01oUXRwTDhLTnBv?=
 =?utf-8?B?bDFkK0JoUXFCWEJyTUZidU9GWEJtUUhobUNocy9UbzNRRFZTV20zNVg5SGRZ?=
 =?utf-8?B?V1lnRUFVT21XcDNEQUFMVzkxekpTOENHdTA4VTRKTFVNcDhvQnI1L3UzQnpG?=
 =?utf-8?B?M0JveUlwWFkyeU55RGQyaERFM1Zxam5kT2FqZnVsZEVWN2xkNVZjdlJsU0dE?=
 =?utf-8?B?VDNMRHgvTDRLUjNTRzlYNVZRME4ySWJLN0kyWUNocVQrZ0w4eEw4WHdpYVdQ?=
 =?utf-8?B?dFZKcUs3d3phdHRUVHo4TmU5Nm9DN0ZJNU1OMElBdjlielorS2QvMkJrSlg3?=
 =?utf-8?B?RjlVelVxTzVrZjhGTnd4NDE2SGV3bDE0Q3Q3QVhTRlZVZ3VHeWRpWEtpU1R1?=
 =?utf-8?B?OUtvSTFKYjRMeFIwS2Z1Mk13bVBWN00vWExlU0M0MTYwcGI1NW5razJIajRj?=
 =?utf-8?B?aEU5eGZpZWdYWTNmZTY3MHQxS2FJOHM0UkdYeUVGaFZoNDV3c2d2MWtXTTFQ?=
 =?utf-8?Q?Ox/Jj8BQyRaTPrg1Mshuxi0C7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9343b168-461a-4618-12fc-08dca6d8a965
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 03:21:07.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iedQaEkkeC33VMkrlZrTtzR0bzoatzJj98vSiPw7QZegSpC6+9Rok9zRa9zsFXVjuMuIcKmvbm89GH4EchOrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758

On 7/16/2024 2:25 PM, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: c9b258c6be09 ("iommu/amd: Prepare for generic IO page table framework")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/iommu/amd/io_pgtable.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> index 9d9a7fde59e7..1074ee25064d 100644
> --- a/drivers/iommu/amd/io_pgtable.c
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -588,9 +588,9 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
>   {
>   	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
>   
> -	cfg->pgsize_bitmap  = AMD_IOMMU_PGSIZES,
> -	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE,
> -	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE,
> +	cfg->pgsize_bitmap  = AMD_IOMMU_PGSIZES;
> +	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
> +	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE;
>   	cfg->tlb            = &v1_flush_ops;
>   
>   	pgtable->iop.ops.map_pages    = iommu_v1_map_pages;

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks,
Suravee
