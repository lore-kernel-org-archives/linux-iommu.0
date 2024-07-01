Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553054765
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820180; cv=fail; b=YUy1sYWsttR/6OFincfIXGGrTaAltzaoTayLa641kYp+AoVH1sgxFo4F7rS/3aUwA6L82uPG+2vwUgN2S8MYzgsqni2Jrw5fJI8m2Ap/frbiKLkoIP3qgHYupLuNj3KaSTUH5XFm0pF5/5XaExXwRSk2UWLAx7rTzgYyNo4Q7v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820180; c=relaxed/simple;
	bh=PLjJ7SvY0uc8/7BB6urm57TDFMizLgEGdn9Y5Y99R2w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=laCV3hEA25OfuQxtLyE75VQ2Zx/v3IaITTyliCjuCC00++9vAEj7DzP7htr1BWZJg3CIr5cXAmgDe+5RERxORpt57znca1OjubhRKzvE6jTM8XoSzY2xDZUvA9BKxVntVIYmpy7CGRR07saksU3ugWk6wkRxucTGNBQ2WSsyj/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHfwnBa5; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHfwnBa5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSz/mU1QfhNSTLqlWW22TOKcPNgHIJesQeKEV6Ta55EP0grQW1my9pu09W0EROqI8jp/qIIv363YFUUJ7E2tps0cF79RyFwX/hyCj8M/mTiznDntquJw+DH7GgGtEA0vjVC4zcQk0enNdrvsFa3ELY4GjdcJgUhcW28YUmUb/ohg5j1kHvoGpTA9vhIUbJEDGOKj2cUi1Kj9/dEMr8Gmh0Am0yLP8DtFvSmmXhFClKP2QkmlUZubl2cm8cpV9+MrLzQf5y4gC/er0dvHczC5e4AKLlRjN69SjoIHP90j2wlh+H3f22SMDArlDRwxgyU938ZKPEtIPDcrKm4ETuVUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08ThproNo+OX8Hm+CXdIFdif8TpNyDFVyLkvjS55Xvk=;
 b=hw9coVK+MnqgRjCW3LLDt2VBdOLCFmTu6WMqLP6eWVEGZlLYwnwYB925wKwLhfpk3tReOVOF5OIkbW3apU65xqcLOEqEv3TvEpwncPT9+6ulbmmUatGmXcl+GpvHs/tjeq7BEpiQl0/ypNo87ZHZ2TlSBIvpF6RLtzzeOhDeFYQBt1PaVm1EAY0Pmpu/HAVbbR6+H3qO7h/aGaOXwMNvO8K5f2Ob2AaGC6PuAwEU9qxtaR36FOSvyY62SDyU+mMMWzndK/W7JKwzQBm4hVkD5iZvqV3TkEeI4FDCEkhiL/MeJEcoKvGbm6XtrPn/izOjdp4EIjrcuHLkkdsPUpTMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08ThproNo+OX8Hm+CXdIFdif8TpNyDFVyLkvjS55Xvk=;
 b=AHfwnBa5dzq9DjUl6i2MwDegzWykg5JofRsgAQzlT4IEFGCukKgb9grl9htUqep0jK5SIWC5Noj3vf2xpcSlJKHATd6sM6DNvLah7/V+snFAsp89FbDTHuAIArxGkMe/4NwdwrS+PMd7kj4BaNOfNLFb5UwqZh7iX5EPYDFLKfiCzUoXpvYdVHZVOK8uDeckFb/aeVIOb4KbXBCqxCQXFHpGod5MhrIY+EmMeIa7sYD4uk0PCK+WRD+aWypvwYH3s19qLp+qNbcCycc6heYjb9CvqH496uje6dL3APdDaqkFGH/NlckUwycgzSuWnC6DWS634Ltj+kt6EQ56S2Zq9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 07:49:33 +0000
Received: from PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33]) by PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33%4]) with mapi id 15.20.7698.017; Mon, 1 Jul 2024
 07:49:33 +0000
Message-ID: <39d1635d-25b4-47ca-beb3-0baaae6252db@nvidia.com>
Date: Mon, 1 Jul 2024 13:19:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu: Optimize IOMMU UnMap
From: Ashish Mhetre <amhetre@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: vdumpa@nvidia.com, linux-tegra@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240523031935.90856-1-amhetre@nvidia.com>
 <6b707eb4-5cf3-4b66-8152-5ba252f5df39@arm.com>
 <2a349725-72cf-45e2-9ca2-5a8b153a6fae@nvidia.com>
 <d854664c-ab56-46b6-81f9-9ef712c32b3a@nvidia.com>
Content-Language: en-US
In-Reply-To: <d854664c-ab56-46b6-81f9-9ef712c32b3a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::26) To PH7PR12MB7426.namprd12.prod.outlook.com
 (2603:10b6:510:201::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7426:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c32ea7-0d2f-49a5-a9b3-08dc99a25896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHdOQXJSSFpWOGszUXFBbmRpRXRMRmJUazVqOXY1bUNKOEdIdURlZVV4UkpK?=
 =?utf-8?B?S0FnaVljV2MvcjV4Sk5NcExHZVlRdUI0UTU3VVJQcS9NeDIrdmIyNWZNLzlS?=
 =?utf-8?B?YVBydFRtSnMyNXVNaituZm93OUlyd3M3VlhIcFU1UHBVaGR1cnF5TVh6S2h5?=
 =?utf-8?B?Rkg3ampOOVpHd2RncW9PaFpPMUErQmdSQ2tQU3FwYXNBc1h5b2d3MmRITVl4?=
 =?utf-8?B?SXlVU29sS0dKZ0MzdUM5MlI1cUo2WHFtOTBlVVdxM3JKSmVnZmJRL2FTdTRv?=
 =?utf-8?B?Z0RlL3praVVLQTRLZ3c0MEREV0dyV0k1eWVUSG5uVzBOUkhiamxJUXVwY2ht?=
 =?utf-8?B?SFlZa2VNVUJYZlBRcUlJS3BnbUppVEMyWG51UGNOVDhIbXhCdU1GUkRlaVpH?=
 =?utf-8?B?MU9UaVE2QjNxS2RLNjJ4YXNSVzdDbklZcmlvOWo2SUtzT2l1Vm5qSEFPSmJk?=
 =?utf-8?B?Q2FQbXVXWlA5b0hRMjdKS3lmSEhQaFpESEtWcUYzQSt6TkVJS2dsL0VjeEdD?=
 =?utf-8?B?OWZ0MUswbFA1S1Bvdkw2YU1SNGR6Q1h3VzRySVZSanVhRjF4QUJ2c05hLzFr?=
 =?utf-8?B?ek5vSUd1Skh2MnZvWG9HQzBpdFk3aGYzQW5sOCtMckJkWVlHa3BUaS92MDFz?=
 =?utf-8?B?WTA1RjJQdkRwSU9HdFFrTkFkYTcrK3Q2U3RWTE1PR1VIOVQ4endUQk16eVAy?=
 =?utf-8?B?UmN6WnVmTkNpUTArRE5aQktRSWc0dnhUckV2Yi9xN3hnSk9xVHZJT0M3QWNt?=
 =?utf-8?B?aloveVFzQUVhUXZJZWl3UC8zRmJ3QjRWRTFsWEVZWTIwSVRGUVhoKzFIN1ha?=
 =?utf-8?B?L2F0NkgxQjdtYWtzVUxsd215dVpUbmxvUzZNNDBhQ0w2ejJxRHQ1S1BMTmFJ?=
 =?utf-8?B?eVZDdlU0Z1lLVHJoMm9uVDRZekZUS2E2Mmg1aWF5Zis1UGQwaEVvbmppeU1R?=
 =?utf-8?B?YjQ2UnhDbjdLTTdCN3E3Um5RbkdxMGRPY09nYTduYzdaOTVka0tYUWJrVGkz?=
 =?utf-8?B?Nk5XbXlmYU8yc3hzeGNjbHhFZVFoWnF1SE15b2RrWDUxYXpPbmlWbXVJcEJz?=
 =?utf-8?B?dDVMeUp1bTI1Tm9VTHU5b3FmR2NocEJhSUFWaTdQWGZkd2pseXdPSXd3ZVZO?=
 =?utf-8?B?c0RwSnJmVytoWGxmWTlOTlR1QVpHQUpFTzMyVzlaa1JRNGhJdVQvKzY4bDl6?=
 =?utf-8?B?bnphY2dlb1JSQkhRaHMrdkcyNGwxSHRtbUM2endaalFjVTBuY1BSeE50WUdI?=
 =?utf-8?B?aDhUQWljU3U3Mm1obkMvd1RTQXV4WW5wQWtPMEJUSXhLUkpSVTBVTy95OFFy?=
 =?utf-8?B?QkY0ZnplQlozNDNCamEwM2Jmb3RCYU4wdDQvZFdCR29WQmFKK0lldm1JRE5w?=
 =?utf-8?B?ZnpwSG8yYldoQ2MwMU5GNjVDdGNxaFpDelhqZCtWVjNna2g5NjIrQmNlNlFm?=
 =?utf-8?B?dWowYmdiODdDM01xRHV1N09LWHhUOWpIZzVVT1BoRGJ2UHBnR1ZsV3MwU1Fz?=
 =?utf-8?B?aTVsallQREFjUm1HK2pKYzJYWDUxaWd5T3RQT3pxSmxGallDV1Z3dEJFLy9l?=
 =?utf-8?B?UE52ek9xRzRac2k1RU5oZVJyQW5sc21zek1YdkMyQi8wM0dpZ09McTBoTVJu?=
 =?utf-8?B?dFZsbkNHc1o4c0NQZHhzVjVsNmZSamRWNVZ1VGF6YXA0VzFBNHJzYkNsRGpC?=
 =?utf-8?B?dlpXQTFhOVVCbzhIKzdhTGN0UmFyUlBJRTF3bzNKRC9mYTBHMTFIbTJOZUJz?=
 =?utf-8?B?RGk2S3N3MTAwMy9CeXBrUlhhZkFubDhpQklOSHo1WmFzVUVxa25ZMmw0TjJC?=
 =?utf-8?B?cmNjc0NSMy9jM0VuQXNOUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7426.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlFiMTRqcDNRRXdyU3dvMjl1Q0FFbHUydTFTNlpyUXVQampEeUxFQWw3elZy?=
 =?utf-8?B?ZXNheEN3OWoxV2NDQW5SOTdyUGEwUVE4U011Qmora2FZYmdTeXluM08rdG9O?=
 =?utf-8?B?S3RRQmZpWGYyUUZHeFFpZ2dHeWVqQjN0RUI1em02VVNpMEFUV3Z5SUxwQnZi?=
 =?utf-8?B?ZlVWTUlWVFlUR3BsNVJVY0szY0NxQ0pHNjJPb3dGaUdUaFdlc1JiQVdQSGt1?=
 =?utf-8?B?TDVjc0t4dDhlYmlXWlpaY3hnc0lscXM2WmpOWWE0UWZCUjIwa0RXU2YwdVhy?=
 =?utf-8?B?Ym1Ob1NkcThPWHVMUmNCQTVMTG9tcmJHcFRHTTB0YXJHOURNclVwVmk4NHBo?=
 =?utf-8?B?RlFGZ3lQMFdPNkhhMmVVNE53KzN0cnBNQzFjMmVEdjhkQ2lPc0NsTnFDY2NJ?=
 =?utf-8?B?N25OQUpvbnZSbWovUGsxNFhDQXh4V2o0UmYra0ZNaUNJd0JlMmJBNDQwU0JY?=
 =?utf-8?B?S0YwelFmb1pDbitBQmw1NE9mTmdmR0Q1dXdaUi9vOEJwK0t3ZHdyZXMyWXJl?=
 =?utf-8?B?S0JyTTJwVi9jQnZNNjZNN0FpQUNZQThMUXRaa1ZtUzhTK1lNckRESnpMVENH?=
 =?utf-8?B?ZVRNVWkxbjZIREplNE1TVkxNNGUvMmRNYnBMdWg0MjR6NjBQYXE0NVYxRXh6?=
 =?utf-8?B?OTd1Nkt5QVpPK2I2T0NFSGFRV01GaStPOXBDU0swUDk2WXdhMnl0MkRLSnRZ?=
 =?utf-8?B?NkZQUFZaVWpBT1IvdDFFaThJcjdYcHZZQUZmclBsOTMzaWhwTFk0V2RpaWlT?=
 =?utf-8?B?OS8vbmRxSTcrY1doaUNRR2x3MUc3U3VGSkwvYlRFOC94RldTeU52UGJianVO?=
 =?utf-8?B?SFR4UTN1UE1JTnhtbjY2S0FpeXB0emxiQTZIRXMwRWlnczlDeVZHc0dVVkQ5?=
 =?utf-8?B?ZTdzVGUxMzNmcitva3R2RUxGUjBOT2hNaVkyMHh6T0VOKzBiSFVKaTJmVldN?=
 =?utf-8?B?ZGZxRDlXVFQvQWhUbk55US8ydWw5K3BEL2tQMkNRM0VsL2NVSHQzMk83ZkF5?=
 =?utf-8?B?Tlk1OWJHUTM1TlVFL29FUEhCRVdtK2hkTCtYR3hXTEhvQmgwaG9PK3hiTTdX?=
 =?utf-8?B?OENuRkFFV2xrMm1xZFQ2eFo1cGJGdnpuc0xkZE9XVVJ4N2xmZTQ2SXl5YWNu?=
 =?utf-8?B?c1pRRE9tVUpSY0tEb3lrWDhZOWgzY1NuY0pabG5pWmtLWnc5SDRvR1ZhdGl5?=
 =?utf-8?B?M1lSS0J6UmM2NjVvcVo1bEcxM0ozNjAyZzZ5TUoxbTdNMTE4bXVmaHBxZjNq?=
 =?utf-8?B?UnlDTitOdUEyNllZekE5NGVVeHFIL0F6Zk12STBRd252SjdvTFRscWdYOW5G?=
 =?utf-8?B?R3cyNENrdHV6T2JZamlpajVIWW0wSy9MTEoxMzdvZWQ4SFFjQ2JYclIvSGEw?=
 =?utf-8?B?STVZNHZmZ2EwVlRBaENUQUQ4dFJjY1NVSlRzRXJGUmJpNEd2cmJKd1JmeHk4?=
 =?utf-8?B?SWs3eSsrQmlKMng0dHFrZGI3K2xQNHRvYUxCSi9IV1VOdHY4Q3BLaDZUWFo2?=
 =?utf-8?B?THFWNEhMWUVUaHFwZnJ3ZFVGYkN1b1dTMUR3U1JyRndHS0hEQWhqN3pIbEpn?=
 =?utf-8?B?dm5JQjdXSDUvR0x5bWhkSEQrWkhXR2tLTkZoQWFnVUFhVWdlbE04VW1xZ21L?=
 =?utf-8?B?RlZyTW9tUUVtYVBSY2xWNGYwOGVrd21Vc05GWGc5Ump3eS9VYmc3U0RpNERQ?=
 =?utf-8?B?dHUvS1Y0K01lWG1weit1dHVpSlBSY0NORzVkeGc3emd3S0x6Q3B1eGh1UklL?=
 =?utf-8?B?N2Rqc0w5YW9qVWx5ekFiQmptb055MlMxRzBnWElMcEd6QXNodGhhamJVbVFI?=
 =?utf-8?B?alNvcGhhaGpFSUkwOUFPT1pUYTR0NXpFZUdwYXRvUkZmZzU2MmRMNVdOQzN1?=
 =?utf-8?B?ZVo2dXVVc0dtZHF4bjh3L3psZ3NlTWZhM0RhcEFBTUdFTU9BSWlvTmEwZ2Vr?=
 =?utf-8?B?TFIvdXdxT2RpUmE3NkxTcUdzem50YjNhLzdzRnNpL0RwTVlmaHF1SEpLQ1Nh?=
 =?utf-8?B?cVhGWVdrZGNaWUFwcEFyY2ZYNTBpNzJTSHhiVXRjWVNORTEzc2ZOWjJVU1M0?=
 =?utf-8?B?VTFYSWdTVHJjYU1mTUJ5SlhVbkFIeWR1Wks3dVZPRFVBS1FRRUcxQ1VIVzlW?=
 =?utf-8?Q?cG8NpNMRbgangih30GMiQeKq6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c32ea7-0d2f-49a5-a9b3-08dc99a25896
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7426.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 07:49:33.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 457LjFKXBmXWkQVaf+hSkdi1+4bb20r1Zj9iA6VbW0VQZ/ZnKbQDGnETaB6ahZdcoi6pziFV1NK83gKISQMpSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237


On 5/31/2024 2:52 PM, Ashish Mhetre wrote:
>
> On 5/24/2024 6:09 PM, Ashish Mhetre wrote:
>>
>> On 5/23/2024 7:11 PM, Robin Murphy wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 23/05/2024 4:19 am, Ashish Mhetre wrote:
>>>> The current __arm_lpae_unmap() function calls dma_sync() on individual
>>>> PTEs after clearing them. By updating the __arm_lpae_unmap() to call
>>>> dma_sync() once for all cleared PTEs, the overall performance can be
>>>> improved 25% for large buffer sizes.
>>>> Below is detailed analysis of average unmap latency(in us) with and
>>>> without this optimization obtained by running dma_map_benchmark for
>>>> different buffer sizes.
>>>>
>>>> Size  Time W/O        Time With       % Improvement
>>>>       Optimization    Optimization
>>>>       (us)            (us)
>>>>
>>>> 4KB   3.0             3.1             -3.33
>>>> 1MB   250.3           187.9           24.93
>>>
>>> This seems highly suspect - the smallest possible block size is 2MB 
>>> so a
>>> 1MB unmap should not be affected by this path at all.
>>>
>> It will be unmapped at 4KB block size, right? The 'size' passed to
>> __arm_lpae_unmap will be 4KB and 'pgcount' will be 256 for 1MB
>> buffer from iommu_pgsize() unless the IOVA and phys address met
>> conditions for next bigger size i.e., 2MB.
>>>> 2MB   493.7           368.7 25.32
>>>> 4MB   974.7           723.4           25.78
>>>
>>> I'm guessing this is on Tegra with the workaround to force 
>>> everything to
>>> PAGE_SIZE? In the normal case a 2MB unmap should be nominally *faster*
>>> than 4KB, since it would also be a single PTE, but with one fewer level
>>> of table to walk to reach it. The 25% figure is rather misleading if
>>> it's only a mitigation of an existing erratum workaround, and the 
>>> actual
>>> impact on the majority of non-broken systems is unmeasured.
>>>
>> Yes, I forgot about the workaround we have and agree that without the
>> workaround, 2MB unmap will be faster without this optimization. But
>> for any size between 4KB and 2MB, this optimization would help in
>> improving the unmap latencies. To verify that, I reverted the workaround
>> and again got unmap latencies using dma_map_benchmark which are as
>> mentioned below. We can see an improvement around 20% to 25%:
>>
>> Size          Time WO Opt(us)     Time With Opt(us)       % improvement
>> 4KB          3                                  3.1                 
>> -3.33
>> 64KB        18.6                            15 19.36
>> 128KB      35.2                            27.7            21.31
>> 256KB      67.6                            52.6            22.19
>> 512KB      128.4                          97.7           23.91
>> 1MB         249.9                          188.1           24.72
>> 2MB         67.4                             67.5 -0.15
>> 4MB         121.3                          121.2           0.08
>>
>>> (As an aside, I think that workaround itself is a bit broken, since at
>>> least on Tegra234 with Cortex-A78, PAGE_SIZE could be 16KB which 
>>> MMU-500
>>> doesn't support.)
>>>
>> Yes, that's true. For 16KB PAGE_SIZE, we need to fall back to 4KB 
>> pgsize_bitmap.
>>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>>> ---
>>>>   drivers/iommu/io-pgtable-arm.c | 34 
>>>> +++++++++++++++++++++++++---------
>>>>   1 file changed, 25 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>>>> b/drivers/iommu/io-pgtable-arm.c
>>>> index 3d23b924cec1..94094b711cba 100644
>>>> --- a/drivers/iommu/io-pgtable-arm.c
>>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>>> @@ -256,13 +256,15 @@ static void 
>>>> __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
>>>>                                  sizeof(*ptep) * num_entries, 
>>>> DMA_TO_DEVICE);
>>>>   }
>>>>
>>>> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>>>> io_pgtable_cfg *cfg)
>>>> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>>>> io_pgtable_cfg *cfg, int num_entries)
>>>>   {
>>>> +     int i;
>>>>
>>>> -     *ptep = 0;
>>>> +     for (i = 0; i < num_entries; i++)
>>>> +             ptep[i] = 0;
>>>>
>>>>       if (!cfg->coherent_walk)
>>>> -             __arm_lpae_sync_pte(ptep, 1, cfg);
>>>> +             __arm_lpae_sync_pte(ptep, num_entries, cfg);
>>>>   }
>>>>
>>>>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>> @@ -633,13 +635,25 @@ static size_t __arm_lpae_unmap(struct 
>>>> arm_lpae_io_pgtable *data,
>>>>       if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>>>>               max_entries = ARM_LPAE_PTES_PER_TABLE(data) - 
>>>> unmap_idx_start;
>>>>               num_entries = min_t(int, pgcount, max_entries);
>>>> -
>>>> -             while (i < num_entries) {
>>>> -                     pte = READ_ONCE(*ptep);
>>>> +             arm_lpae_iopte *pte_flush;
>>>> +             int j = 0;
>>>> +
>>>> +             pte_flush = kvcalloc(num_entries, sizeof(*pte_flush), 
>>>> GFP_ATOMIC);
>>>
>>> kvmalloc() with GFP_ATOMIC isn't valid. However, I'm not sure if there
>>> isn't a more fundamental problem here - Rob, Boris; was it just the map
>>> path, or would any allocation on unmap risk the GPU reclaim deadlock
>>> thing as well?
>>>
>> I am using kvmalloc() here to create an array which is used to store 
>> PTEs
>> that are going to be flushed after clearing. If we don't store them then
>> those will be lost once cleared and we won't be able to flush them.
>> I tried using GFP_KERNEL instead of GFP_ATOMIC but then I am getting
>> warning from might_sleep().
>> Is there any other alternative way we can use here to store the PTEs?
>>> Thanks,
>>> Robin.
>>>
>>>> +             if (pte_flush) {
>>>> +                     for (j = 0; j < num_entries; j++) {
>>>> +                             pte_flush[j] = READ_ONCE(ptep[j]);
>>>> +                             if (WARN_ON(!pte_flush[j]))
>>>> +                                     break;
>>>> +                     }
>>>> +                     __arm_lpae_clear_pte(ptep, &iop->cfg, j);
>>>> +             }
>>>> +             while (i < (pte_flush ? j : num_entries)) {
>>>> +                     pte = pte_flush ? pte_flush[i] : 
>>>> READ_ONCE(*ptep);
>>>>                       if (WARN_ON(!pte))
>>>>                               break;
>>>>
>>>> -                     __arm_lpae_clear_pte(ptep, &iop->cfg);
>>>> +                     if (!pte_flush)
>>>> +                             __arm_lpae_clear_pte(ptep, &iop->cfg, 
>>>> 1);
>>>>
>>>>                       if (!iopte_leaf(pte, lvl, iop->fmt)) {
>>>>                               /* Also flush any partial walks */
>>>> @@ -649,10 +663,12 @@ static size_t __arm_lpae_unmap(struct 
>>>> arm_lpae_io_pgtable *data,
>>>>                       } else if (!iommu_iotlb_gather_queued(gather)) {
>>>>                               io_pgtable_tlb_add_page(iop, gather, 
>>>> iova + i * size, size);
>>>>                       }
>>>> -
>>>> -                     ptep++;
>>>> +                     if (!pte_flush)
>>>> +                             ptep++;
>>>>                       i++;
>>>>               }
>>>> +             if (pte_flush)
>>>> +                     kvfree(pte_flush);
>>>>
>>>>               return i * size;
>>>>       } else if (iopte_leaf(pte, lvl, iop->fmt)) {
> Hi all,
>
> Can you please provide feedback on this patch? Is this optimization
> worth pursuing?
>
> Thanks,
> Ashish Mhetre
Hi Robin,

Can you please share feedback on this? Is more testing required
for this on non-Tegra platforms? Perhaps shall I send it as RFT ?
I have used 'dma_map_benchmark' available in kernel to test this.
Same can be used to test on other platforms.

Thanks and Regards,
Ashish Mhetre
