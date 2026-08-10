Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5D3BBFA7
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360090; cv=fail; b=O/m8omUrG+fUKkvMEawc4JYqV2t4TFeQU8qzPpWk8SAVn5ioDVk4hZqBFyY9WNle7U3Hr3T5TlRM8o6u0cjSkINJv1Xvm8qmliwRkaD07BXr1zg6gjowXpgg1ech7cPjldUafcBcO08Afhu+hIynUNdXEquv/7JPXq9bmsweN9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360090; c=relaxed/simple;
	bh=VJ4Uzmw/seWOBtLKBpjYLuh8VSLwNFRZEftw5QdxxBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tX46XuKIhL4am1JASWeaxTGD7NHgczsBruiOe6zNIcC5JZjxNy4Aoi675qj2SiBRce7HTzfQXZjtoNvx/Yl1wjVpYh3iZFU318sjw5vZyJgzHz3VhtohxCHNPQfrQNaUs78jGo31DNjrxXlNv5KadN+XWMNDM/RLRx27N8ZHe5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pth9GMpd; arc=fail smtp.client-ip=52.101.57.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pth9GMpd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhUzGmTwxakBNtK4b2/eLSIp54h12R5u/ReZlNtmL5z1hNHjIFtTrfKYGL9BvYHliqLuHHbQAGbvs+Bbt3Am2f7FVVMdYcXCKEn9xp/AiXEhYWkq0KJqxC0EX+CBpxVfwAEvCK3tSEazlVR8VuiYZ2CCKx0KktMbCxm5O3yrNlnyRwTSxM0nYoJx5/+QnUyS57PsJ2dcjUk0bwjRsr/mekGYYTWmXA2eALLmzAtxB7KfeXSg2pjWCXir57zslmfWU0NAvF5z4GFeX3EWOMVfG/r8lUQ6/gP04F6SaPTTW/z3IvvkECvLhnDZYBqR1ZuHVj/RD9dQI/TRrU5pMMGcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqpVvY7iEIxlVMi6drrwC149zg7ct81KnMbTXeNjefI=;
 b=ha4d1mc2wb3zDdd07i6eW4l37w5Ve1WLkpzhWwaam948T5HFsc98cqzSzKg9io95c4lf5tluEtBd5ylhbNBhlz+uSCzAkOAb6h5lqIxeyViyB1/c7KX0MtwrI8z/4RdC5zCGIBEpV2w4oIIXYbNnUQ1X5rjjOkhrYrK8nZo26R45A6nOBDC8maP05K7xT8lLs4LUKMTrHdZtwsJHWuoLfnrvcWcpLzOGZWU54tIIabLQPBmJ5lZeTZ58mbf22NorqMTzm2ty3icToZhGwd4D/89GS7q6wOPLJ3yML2hukRtPrzAhgUN4rnFLxyK0PMAB23WxgFY4cjbQYFfNaVxiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqpVvY7iEIxlVMi6drrwC149zg7ct81KnMbTXeNjefI=;
 b=Pth9GMpd+V52ew9QTTvntmf6EE4snHU/3W8COKtqsUpGNNXMutV3UjtKJrUwwV9RCi1RBV1JQE2Quag4zQdp/w0n5WoCXgsJIaxDJaIYcizwZ3NskCfln/cVsMGyn1volS80amGJEa7tPVJpVp39+bgZ/PtALJM+I22zluVv/ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 11:08:04 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0292.018; Mon, 10 Aug 2026
 11:08:03 +0000
Message-ID: <f9b58653-eb6f-41ee-a8f6-70ec6ae0e1be@amd.com>
Date: Mon, 10 Aug 2026 16:37:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] iommu/amd: Pass iommu to device_flush_dte()
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-11-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260727132913.22475-11-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::11) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: a0480046-e451-41b1-e283-08def6cfa5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	79zsWY8UZNI+3ap6BXPiUBxAISjeMGUHOzVEWV659awBqpynxbipAh2XnrAB+vGHeyNObw+wXNfWuytJEOIFMP5lqNeOstFl6tjkUC4KOX9L9VJ3mNn61yuayaOf17NArO32i6JxJ0HBs3KeoQBlwCV3xqXsTTqNXPgeXkPu5WrDae4iqO3i1K6KY+1XCuJ+77Qa2J4X5fzcbn4xrZSYM8/snt99/C24ZYWUARUC2SsRFf8YAvLpelUB2D1qn6m0rjRwZRwPTee3y0ykEeXQqvmMWbyREaTq9vqmB9m/BdifRzpwVek1mCUtKWmqyNC/5htZ4e/PephWjMXZ5O22mDAJhHO4rAOg1n6m0tDh/+WPnzLBPjSpQPf7akrdHcvhUkUka22uNnQGLYRRj3MBHG6HPVH4rcddmx31Sdnh48SFrWOeXkQQqf0ygmCc31UCDXnxJzTYkuYLlafYip7fumSoyEtKSBGKfgYdW4oAJthd8JPn6/QOAd6lRWzzkwLnMWsgspt+ZMz1uMZ+MVBGAYBLkEKAU600Ve1FYIFkha+EnL7Z02hDZ0mSjDj8DnA4jPY0VnJq3We2PWJJT21Srutjuamo7U6ZPNJc03uYlP1IrSggZgep9vcUK3EcLAPh6PwbtrnVxo6uiL5qEexfjgMm/6sH0r/IL5DPe/jdGTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXlHTEg3bVdqYmlMWmxoUTFJQ3JmT3NjMzNuSDJIWUxKdnByT3FQWkdCcFho?=
 =?utf-8?B?MGprYVlzL09md2hvWkFmVU9xZHRaWmp5Syt6WHZ1Ulo1SGpDTjRpZURKeHEz?=
 =?utf-8?B?ZGw4NFVTbTB1dEJTSTExaXRKNStTTUpNeWZqUG1BeUdobktJdStZNkt5VVN0?=
 =?utf-8?B?Sy9EajVYZ0RmVGFsUGhCYmZ5VURidVNTYUFpeXpSOHF6ZEM4MnJsQlVoZmZh?=
 =?utf-8?B?Wk01MFJja2dHME4vcUR4ZFdqWnYwK21KVU8rQUhBbDcrOWhBN1hHYzBDNTMv?=
 =?utf-8?B?c0hWS1B6dXlaSVFLZDB0dVJzSmpkUVR2c1hzVkEwWkxpQ0E5aWcvcWU3bzhp?=
 =?utf-8?B?U1JSSGV5NjdqMGF2bjY3Rm1meGQwNElHdmJIenlBM0JHYzg1Q0w2Z0FLaGZ1?=
 =?utf-8?B?NWZiRVh6aVAzcERhdlQ2bjk1RTVUR0g5Y0x6bXVKblhsNEp5aHJwZVdVd3d4?=
 =?utf-8?B?cHJ3NWFUaU1aMHBNY05BWUZjTEJFcS9GZ0F0RHgwaHlZbmVUSEREemhING11?=
 =?utf-8?B?ZkIzdW1XWm5adk5qaGNPbGIvVWJnK1ErVTdVSUZqdlBZa0RkVDMrb1lWenlu?=
 =?utf-8?B?dUFDRGh4cHFGbnp3L3VOWHlEUEJpbHZVNGpmM1JKVUpqbUdCZ2FDTE5Zb2Nr?=
 =?utf-8?B?VGZRbGJ1UUZsQi9tbEVKai9vcGlVdzhVRVBOdzV3ZzJEMFJQYTJSTS9FZVBz?=
 =?utf-8?B?eTVkL3lydGxwWFNIRlllSjRUVndMRE0wQzM3SG1hOHZIbHdtVUd1Q3Fyc0VU?=
 =?utf-8?B?S3lEQ0lLZHRkcFlQWFJKem9MakVFTFY2dFRYMTlNVzRBd21NUmZtTkJQNVgx?=
 =?utf-8?B?eG9RNFEwQjJ2RnRsZnM2dzIyc2FYVDMweXZVL29kTzZVb1o0THkxaExtcFYz?=
 =?utf-8?B?eEk5MUZiVUJNVGxJUXlQbG92ZFhUYmNFOThkbEQrUzIxYWJXZ1EwZ01Xa0t3?=
 =?utf-8?B?MTcyTkd0aFBud3E0Q2d4eSs0NUJsOVpJcjJhNEdHUDUveHVQdFQ4c21zK2Iy?=
 =?utf-8?B?V0tzb1ZaODZJYStyT0Fvd01sLzB3MXRCNkpXRVBuOTRyNGZzcndtcDJQSjQz?=
 =?utf-8?B?ZjlmUk5PWURCbnpKY3dXall3VUJSb2xRa2d1eUIySklnY1F6L3pMK01pZWw2?=
 =?utf-8?B?Z1FNWUZhYTI5Uk9ORFBOcExKK1JtUnAzQ3o2S2toZ1VvVHcxWmQrUDU5cUR0?=
 =?utf-8?B?T0RSWHhhNzJQdEVFd3l2ZStGajRaTDVqTFZ3d2xHSjczSitYaFhCdG10UUYr?=
 =?utf-8?B?MVdhTXkrN3Z3cnFOSFNuQmlQc3lieVlncElLN09aYktHdEdEbkk5blhuZzBv?=
 =?utf-8?B?QjRTSkpmb1R6ekVqMVJsZkpmZTNSMWhmTzZoTjVaS2dpNFpncFY4aDRlMEV0?=
 =?utf-8?B?RmpoZkV4ekllYi9EZzVqZEIyS3U1cDRmNFZvVmFMb0xUbSt0bmJDZzZ1NW1u?=
 =?utf-8?B?cllITEFkdVhGUmh2dG0yWmIvWVJFVjFPemNpQWZDUFNvcmFab3NwdzRjbUc2?=
 =?utf-8?B?UFQ3SXAzSldlZDdrTy9GSlFUZUJ2NVArMTFGZHhicjlUZ3Q1YmxZS2dDVXZj?=
 =?utf-8?B?YTdrUzgyTDNRMjRhSmJlMVc0aGVLbi9uK3lwUmF6d1JSWE82M1lwVGhORHVt?=
 =?utf-8?B?MUNqT3RVNnIwWVo0bFBUQlpUaDJLNlAraW43Skl5akZ0MnpFMDdjTjlQTjhO?=
 =?utf-8?B?c21mTGhoQTByTllqSVFST3NDbituLzkzZzlHbCtsQ2tNWlRVT3ZZTDVhUFpN?=
 =?utf-8?B?bW1Nbk5GRkgreGhRR0E5UWJJcVhUMlhzOFlkR1c5K1hkQ3gwZTA2TWtCemJI?=
 =?utf-8?B?QktRZGQvNlVlbHVKMVM5Z01Ca2s4L1RlZmIrVWFCcE1BbU1KaXNXQjh0NTBP?=
 =?utf-8?B?cXE0TmdteGdWUGZNVW96dmhoZm9mTldwQWVLMDdraXkrN2pIakx5OUFvdUVO?=
 =?utf-8?B?aHhoTzFnbTlwaTZ2eTFvU2NWcXJyb0dkc3FUMnhTVzR4OVdpdkgzWDhKMmc2?=
 =?utf-8?B?d3Z0ZGFrYnlRT0V1blUwdjZna0VPazFaYTIraVpQS2thZ2Z4N01ZMmd6cnRj?=
 =?utf-8?B?dCtSK1poVmZGWWR4TTlySk41V3Q5WTY5Rk9tQmdTSjdxWFhZckYzY28zWTBE?=
 =?utf-8?B?OVowRWVGdXRRK0xFVllGc1dtWXI1aHZWdUhuczN1TVZZNXF3NDN2USszYVZi?=
 =?utf-8?B?MkRQWVZFNC9oejRLcVlGU3ZaQUFtQXlFNTArMHY4SVdGeXhqWllTWERZU1BV?=
 =?utf-8?B?d2hYblJTVzJ2WWcvUjdFYmprZjZNMyt3OG4yYmZHSzlJQXd1dUJybmZackJG?=
 =?utf-8?B?ZmhtT1Z2b2NJcUVVQTRYaU5ySUZGWEFMWE5SSTFwYkpaRXRiUUN2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0480046-e451-41b1-e283-08def6cfa5d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 11:08:03.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wql0WnFaBRlISLF33O2PuPm/WAYpYj+GlcRSJ7JJFMVXffhBGWAEfjEnWhdoKVvPn8c6GpoYmHOXy529ACW4MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137



On 7/27/2026 6:58 PM, Suravee Suthikulpanit wrote:
> Take struct amd_iommu explicitly so DTE invalidation is issued on the
> same IOMMU instance used to program the DTE. Also, flush each device in
> amd_iommu_change_top() immediately after updating its DTE.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e5d26d6d4715..1bc232553c71 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -76,7 +76,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  			  struct iommu_dev_data *dev_data,
>  			  phys_addr_t top_paddr, unsigned int top_level);
>  
> -static int device_flush_dte(struct iommu_dev_data *dev_data);
> +static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_data);
>  
>  static void amd_iommu_change_top(struct pt_iommu *iommu_table,
>  				 phys_addr_t top_paddr, unsigned int top_level);
> @@ -213,7 +213,7 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
>  {
>  	update_dte256(iommu, dev_data, new);
>  	clone_aliases(iommu, dev_data->dev);
> -	device_flush_dte(dev_data);
> +	device_flush_dte(iommu, dev_data);
>  	amd_iommu_completion_wait(iommu);
>  }
>  
> @@ -1716,9 +1716,8 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
>  /*
>   * Command send function for invalidating a device table entry
>   */
> -static int device_flush_dte(struct iommu_dev_data *dev_data)
> +static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
>  {
> -	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>  	struct pci_dev *pdev = NULL;
>  	struct amd_iommu_pci_seg *pci_seg;
>  	u16 alias;
> @@ -2685,11 +2684,9 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
>  		/* Update the HW references with the new level and top ptr */
>  		set_dte_entry(iommu, dev_data, top_paddr, top_level);
>  		clone_aliases(iommu, dev_data->dev);
> +		device_flush_dte(iommu, dev_data);
>  	}
>  
> -	list_for_each_entry(dev_data, &pdom->dev_list, list)
> -		device_flush_dte(dev_data);
> -
>  	domain_flush_complete(pdom);

May be just replace all these w/ amd_iommu_update_dte()?


-Vasant

