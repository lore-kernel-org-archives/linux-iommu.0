Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2A46C836
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592323; cv=fail; b=FpUKe06abFOOC5PHKL31s9qYhYblWLuC7cWKmMnO3o21Mut7+yd9IUe5RayRFMcYGWF00u4+DKdUySa9h6Ed+/xfSS3bbXmkV3yKXPjLAet0YFUgLJnzbVvLyoRljPHqQkw7ApxU1GB2ZRpk+FUIsrkuw8Z4vsWYxwlHyy1jUl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592323; c=relaxed/simple;
	bh=FotAuY972Q3+18vvM99c/AKKcZ8/s0wQ8098vHFVPD4=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=jXzFxbgpD5PQXGrbD6RIEEaEsVdnXb1BVRZ8JdRh2RUSekeZtypJCBNL/hd6Vewxv4tB47bYXJyfZRW66Zh/SM4R+dW/ZCnYamnW+HdcdktbvNjFh5CAGz4VqQYTdNFBG2vXznyDrTqtFSwk9CbaqpRcbPg3ZSxAYXFcpCYvtpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r8NlyDpD; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r8NlyDpD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDU95AYmdXQh4ozdq5F3v9htH4zYNsi/xysyg4acj24BmZfRTY6ZOJbSR8bFZQWEh/soYwm6KMeSs7JTXn+ZlfHMP4jTe4onwVtY6nJO01OcqxaXOYspwboJRkGifvt9NVBNeFvK96Q4Kg1xNvQt2ILhOWjqnFkx7x4gIIUBVrtB+L3qx1U52xL6l3fe5P3uBOA7W0bfoZbrHeQN5BO34K+vJrrDB7qddqCmDsKT94wxiUiOL4I0OCPjhHDCZRRZ6BC7JLkV4+1HZvwk7erXiBCgWqdMHc2g72ZlsIHmExv7jkixHnudIYouItwvpp1TrmmgJ+/RUBldG3CZ6U5A3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxPvkQyGunc7Tlp5CZs9XFXfSuqS+8vT8t4/8c+A7yU=;
 b=DmP7Mnc9UbiuEUk6Exf7+i4vSaolfTcrVVVrtF51gmWzUEjrLwoly0c3t23c51xH1De1+xkHAisaPkAhuVNJIwqruOtae5PJouUCEXei86nxH9dI60o2GhWGDwWv9wg9+2LvnOGpMnDQjgZIjczTsCPutGDQLIOOSQS105NsdPcDwHbWJMbc13VjZemzEJJv5+jIIfU+v4R+EpDBPMcWLzk03/j1lEU1xdTT7o9l8kRnW8baBFBtMwwh+PNqXURiiMqNJRBlJqvulfH/uDm1G4hO7ljkblNhNZrYVnPL5dtt9urfZToOG4kEsfEAavvRvjMjNE06DG9UKxXjUHmXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxPvkQyGunc7Tlp5CZs9XFXfSuqS+8vT8t4/8c+A7yU=;
 b=r8NlyDpDdZzY5rzw3lxKAndLmWbaFzW89xpsBnrlZCvclPFq45+F23YIPNRRVH0fdWw8a6+kmgmUqgOwb3cSTvP+d8uf+efwlTTY3mbCVP0rTBFAdxbwzf9oc3Hzq9o4SKaRyVwLRqRhjpE4yw/B0HdhUh4gkZ1lFYmhgUCoTCa5GJ+7pNMw6x85UmnRz9exBt4clOS6sQIdouFko/gJ+kfaSQs/IAvaDwE6SUHptbIoNCIH6MbsiwMV1ibGYHNd++BgnV0nGxv1LG91JyMwJsMSXPBvDZu36d959qYt44z2w7xJXjM+iWmZEF+RZG+FwOQMUbBNKZ+QMsKs2mrK5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 13/24] iommu/amd: Assign IOMMU Private Address domain
 to IOMMU
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-14-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-14-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229635.3131778.5081474165505014029.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0429.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5b38df-ed10-4f68-4a8c-08df0204a3da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Wb3w0Ectyv/mr4hHDiws/Pha5UuFrkSG/ou7uCSHrz7kdc6pwFRkN4oTBAIjxzioNuz1D1Hqtpzhla8czyivKMoGUnSykczW/L/Krg0xPK+NndnUxK0K9zKNq8z1PQTvZD4dvfbVA2O1vPO3jmvR2rMY/mKUBtc92E55e+ukfXDDmp64P5r6xCwyzvyWEOFWnW2aDr5xExwatNAZCpmQstmswlFGGAbfarSTwitK1xLDOzwlxDnZxBnVK1HpXKET0VVYvwxJi4CF1VSfEpbJ0kXKfMxGnsk9VXwpZeXglFg5ddM1veOnkMASgQl2n5oYYnjJv0yPFGO8ARNcoPQiLZp/Wvha5EgEiyZm4PkUbjGNh3nueSZu0a1/ZvXexfgDe+P0ylaZt4dvsziW2UmaSOz2MxRyma1t4na09vi0hX/9VUn5jtUBjkAsVighF5HpqC5Cuhee6bc06p4oaa6yU8euDK5NRHHT1fhtB+QWxmP/ZM51y9WeTIfQi3EY8O+t3Qb8UOU0NJ18sCWzNUtm/qpkKxbEMg6TYop2/rUE/fW7uw/lOQbhnA9jaAHLdyfGfO+9mCWCWUjpLBo54Ppil+MXWHIwDuFO8A7Fkq9SLAOlfWYcXwvXz/OpgBpOM8RjexnejwCgsbdMnTgbfBM/eL3Wu7Es/jH3IPLGNB//FVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THE1Rll5RlcrSC9xWXhNK3BERHFrR0pNVUE0cFBIZkRzVGt5L0s3dUZhR0k1?=
 =?utf-8?B?a3FFcVBTWGlWbUVWdVJQdXUwM24xK2ZmVC92Ni9ZeDQvS3BaV0hlSVVhQ3J4?=
 =?utf-8?B?QSt6aEs4aWlPczdXYk1wa2dyTDdudmtvZ1VuaFhBN1BuVTVBT1FjSlhKSS8v?=
 =?utf-8?B?cC81M3lKMUs2NjR4Um9YVm5ucUNYaDI1Y3o1WmhWLzRiYUpza0R0b3ZBek5M?=
 =?utf-8?B?Q2xPaVJsOUxvc1QvVDJiT1Qvams5Z0NYZWgyZTg3R21kRWRqUlQ3bnhCbU5B?=
 =?utf-8?B?Wkl2a2FWRE5tdVFaTGZ0Z0lNSUc0dG1RMXFCNVozbWF1NDVNZkVQTDYyeS9V?=
 =?utf-8?B?djg0ZkVnOFVubzdnNWkyVjFpVUV0dSt6UWdMN00wYWlmMEovNURXQWhHUEJM?=
 =?utf-8?B?UktGdklSbSt0dVBhRjA1dnJ4OFFEOGE4dVJHTW0vdVpGTU5GWVlHc2tSWmxV?=
 =?utf-8?B?WUdzR0hiSVd6cUFuVnBaVEo5LzdxZVJEQ0hZZElQbktuYktDWE9GdkNFdmdN?=
 =?utf-8?B?UnlHbTgrMCtUdzdRMXFzdTkvV3Z3VVdQNHZHR0d4WGVsVzBvOUlRaFJhRHdl?=
 =?utf-8?B?anNaU3R4V1IrYjBYVy8ybzd0Q2FrblIrVXRpb0JlRjJnNkMrd3lpMVRvYjR4?=
 =?utf-8?B?N0Z6Z2FsaUVxY3NHd2JKNkRtWG5FN1pSTWZuRkZDMXBraXVyZG9XU0RseUZY?=
 =?utf-8?B?eDJCNlYyYjdJbTNvMDh3cG5BaHlKWXVjVTk3UUxTaXZUbWFnajZvWU9mTUxm?=
 =?utf-8?B?UTZabU4wcEtTUkg2Wlh6OEdOeFVXN2R3T2liakZvMGkxdlNoN1pOMiszYlZI?=
 =?utf-8?B?bHAvQkRvZTVIWmNVQlVuQ2RxcUtSSmNUTlg1T3FseE5GVXhPc3ZPZG1iQWFk?=
 =?utf-8?B?cWVKY1l3c2kwY25aN0NBTXYvRTZ5WTdBOURvOXFZT3JrUXo1ZDAzNTBnQ0dq?=
 =?utf-8?B?WUYwc0FyQ2dlWnRWQUk2ZFVqdERjV1dmNDBYWkxkaWt2M0VIMmh6SzIrYUlB?=
 =?utf-8?B?dVNGd0I0enlOeFhzZFY4bituY0NVSmw4NGJqd1AwRXlKajhYaWlCWXYyWW9J?=
 =?utf-8?B?TXNnN1MySTN5dzk4dUdNUzZsMlErZEw2VzEwbUdOK3Y4c0xsVEVZanJoTkF5?=
 =?utf-8?B?c0pXLzZGaEZ5eWp4bTZBa3NmOFVEcVhPa0I0d2xBWFd1c1kxL1g2ZnVKSi9n?=
 =?utf-8?B?UEdwNHFJWWNOdmw2T05iYUYwdk5RdEk4T2NoQkIwK0lndlNWTHdta29xb012?=
 =?utf-8?B?dTYvN1N1czkzcXhkRThsc3F5cEZvNmN2YW9NU0xnZ1N3YXhudGF0aUtMMlZU?=
 =?utf-8?B?SS9TQXpvVUUzMUFSdWxVUnJDQitvbElaSVJIL2ZSSkUxc2h0SWtYTGdMZ2Y0?=
 =?utf-8?B?Q0JUdTY0M2Q4dDNUUGhVNzhJQ2x2QTBidWYzY2lEM01nUmN0L3NxN3pzbDd0?=
 =?utf-8?B?RzFEd1JWYWVsM0tJclNCcGVVNlN3dzFYSXpLaGFuekN4aFY3ajNhRW01WWg5?=
 =?utf-8?B?UWNDQUxXUFEzdzZLNUZQakIvQ1MrelNndWlVZTNRU0d5YVRlRDgxRUtyWTU4?=
 =?utf-8?B?YXJmTGl1SmUyTm9POVluUWR6R0NoN3FmUEMrdTdBSkw5T1ptTDhmK1k5NXBH?=
 =?utf-8?B?ZEdrSDJtVHdwMDlUZU5Ebm1CUXgrSC9vMkNOeFhuUng2VHE4dGNWbDhuQlZC?=
 =?utf-8?B?TTdPZGhUeW04d1hnVDE5STJqd2FrN2pCK0RZUE1aVWQvem5qQTVpSHpiaHF5?=
 =?utf-8?B?ZTFiNFVNVXEzcmJydDlYNEdFZVRFSHpsMnVOSys2Q2x0QU1KVVc5QzlFdTUy?=
 =?utf-8?B?Y3VzK2N4dTV5RkFBMFkyYisvb3NkcHRYM3IvUTJsNCtqYjRjN21zak54MDRD?=
 =?utf-8?B?SkU5Mnh5UU90Rm54YmY1ditGbGFiNE5DVHU4ZmlvL1o5QnRENGl0NjdrdUdj?=
 =?utf-8?B?aFMyc0lWalBiTGRwZ2NFdXRwRTJGVzN6VkVBU0IwRjRLY09xTlhTODlleUFP?=
 =?utf-8?B?QTk3YzkvWWJ3dHVZNjQzSW1YcDduMUtIb255VmgrZXpSWlczcXFwV2h1d1p3?=
 =?utf-8?B?MmliK0RxUDlNVDU1ekpqMlBYQkhEaVlieGRWdTBhWEFxa3FDanhicllkV2Ez?=
 =?utf-8?B?OUZmaXdIbUp2REcycll4b2krRzZJM1hiQmdZZ1FtZzNnYWJWcEFxKzY0aWMy?=
 =?utf-8?B?RDZHQWNJWTl0ZW1DVitkL2Yxd0RjRFpjek1KUnlCTFhrUEI2TnJEUG1kYmlL?=
 =?utf-8?B?cmRDemRvWGdYaXZmWmFyWlVGcTYwMUlkL3FNU1ZXaVdDTDhicnpwV2hYdVVK?=
 =?utf-8?Q?CCFfiaC73Ri/rwYCg3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5b38df-ed10-4f68-4a8c-08df0204a3da
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:06.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4gTGsSEAKMsiOawCCLH+/lJp2+5UKN57BrCGswUfCrqX3GnnXSXqv6uIe0fsrg2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

> [ ... 39 lines skipped ... ]
> +void amd_iommu_free_dev_data(struct amd_iommu *iommu,
> +			     struct iommu_dev_data *dev_data)
> +{
> +	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
> +	struct llist_node *prev = NULL, *node;
> +
> +	if (!dev_data)
> +		return;
> +
> +	for (node = pci_seg->dev_data_list.first; node;
> +	     prev = node, node = node->next) {
> +		if (node == &dev_data->dev_data_list) {
> +			if (prev)
> +				prev->next = node->next;
> +			else
> +				pci_seg->dev_data_list.first = node->next;
> +			break;

Why is this open coding llist manipulation? That stuff is tricky, if
you can't do the mutation you want using the existing helpers then you
probably shouldn't be using llist..

> [ ... 45 lines skipped ... ]
> +static void set_dte_ipa(struct amd_iommu *iommu, struct dev_table_entry *new)
> +{

This is a strange name for a function that fills a DTE with the paging
domain for the "viommu_pdom"

> [ ... 7 lines skipped ... ]
>  int __init amd_viommu_init(struct amd_iommu *iommu)
>  {
>  	int ret;
> +	bool dte_set = false;
> +	struct dev_table_entry new = {};
>  
>  	if (!amd_iommu_viommu ||
>  	    !check_feature(FEATURE_VIOMMU))
>  		return 0;
>  
> +	iommu->viommu_dev_data = amd_iommu_alloc_dev_data(iommu, iommu->devid);
> +	if (!iommu->viommu_dev_data) {
> +		pr_err("%s: Failed to allocate dev_data\n", __func__);
> +		return -ENOMEM;
> +	}
> +	iommu->viommu_dev_data->dev = &iommu->dev->dev;
> +
>  	ret = viommu_init_pci_vsc(iommu);
>  	if (ret)
> -		return ret;
> +		goto err_dev_data;
>  
>  	ret = viommu_vf_vfcntl_init(iommu);
>  	if (ret)
> -		return ret;
> +		goto err_dev_data;
>  
>  	amd_viommu_gid_ida_init(iommu);
>  
> @@ -318,5 +355,15 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
>  	if (ret)
>  		return ret;
>  
> +	/* Set DTE for IOMMU device */
> +	amd_iommu_make_clear_dte(iommu, iommu->devid, &new);
> +	set_dte_ipa(iommu, &new);
> +	amd_iommu_update_dte(iommu, iommu->viommu_dev_data, &new);
> +	dte_set = true;

Why split this so far from the alloc_dev_data() ? The dte set cannot
even fail?

If you make the alloc and set one function then the free function
viommu_free_self_dev_data() will naturally pair and no need for the
weird dte_set

-- 
Jason
