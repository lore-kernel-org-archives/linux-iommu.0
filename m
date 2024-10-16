Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFC187855
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055564; cv=fail; b=gPxyVFCxXhReuTDE5qtMSrE0QmYziGJFJRlbOy3yXKsVRQe1mcmlRTAQly6NFJrvt8ng6dXG1/nIqu/SUcgS9NOiE19kueDnKAeYcJLIAb8PxSnG39ADJKNjf443YuVd1FGwJNy0/BflE1X6UwGFWd0jrLSWS70Mnz01MsW9PmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055564; c=relaxed/simple;
	bh=w/5TEm/aWLXKriqvBfw5VWT98VdU4077y/Kq6iEPe/g=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBI+hSHyOyX0dr4k8vdIpGwI02nXtmBzkSnNaayPwlWZ0asJtCrdf6G4YskqQyp4JKg/7KajvY/jht2TdyaYHkvBh7xFXa2xO8UajGdj6MOL5NudtkGaQTJNiCxRDj/uG+uqTHOOJ+CSNIoeghe0t51ZhVXpGZ+Tz81uK6Wj9Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ca9vMabV; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ca9vMabV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdz2M2X7vCyLYxNr2zSaXxAr7s7f2Txy8va9ymrNk9ZEB8niQ5K+nB70CW8HdA2idYt5wJLgCH+NGbWz5qxnopFKSuKwpLryJzAkVgaxspt+iAxqiUik48TWArl6PCb0+g8nvDFuqQ1mI2B6SRT19mvS25PxZRk6fH6+tEC02tHuLgnEwOgKV3JzBUiPV5ia/e41L95Esus+YFOVzhrJqK8N5WYZHNLT3HgKBRUwjl61deqkxcrtRqs5KYjFyTYmGquITgZipdj5BLDTcd9j45OSueDgXxJNJ9NouIpy87hfe4CDsdD0A6K9kdt4gX+wE+Ial0QAn/X5N1hsnla4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2fTjpsnjS1RQwSz32cMl2F9MgBXjxRbni4FLKtNDiE=;
 b=nvwRIRifzLN6jaP9gt50vzR2acxp5tTOnfzDlpHReQwwOvafUfjWH7s82RtQGFPfWcIM69eEFNYKRoDZiqE5AXmEMz9UIdxNu4UHR76NWyPe4DjY/S3r/3X1reCxGFyRujohrYR/HbkM7dDjQpTmQax9BhyoFozrARziyCZ0f5icYZUinmsXemiV6aCcLKNAEvWvHSNYtxotGw+1CYZ399dc0sNIRRTYdrGQvfdJCiaQRLxyio5cA/SKJ75HY82vMqOYcoEjv2k1TeCy5OvjmPUHSv2iq/6fwZDfnlnMURlXktsxvGJu5AgQ/a41+EIAhIhuGYMKyS2ahIWxsX5cjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2fTjpsnjS1RQwSz32cMl2F9MgBXjxRbni4FLKtNDiE=;
 b=ca9vMabVezQOFw8eKOLTrhUqtpYOZgKaKiOcuD4Bg0VHuLN4HMrCZS5fz0aTPj8Z6GLcIHPynVdYLqbh+xZBWaiv77H3bMbVwiMa8pjRFpyDKKi49HVUZM8aoma4QLdziIOcYYaWwS8ubGbDGmc1FalNNAme3RYhMGufUIKu34c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 05:12:37 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 05:12:37 +0000
Message-ID: <2cca938f-9229-435a-a038-c431fcff0622@amd.com>
Date: Wed, 16 Oct 2024 12:12:28 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v5 3/6] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-4-suravee.suthikulpanit@amd.com>
 <20241007140502.GO1365916@nvidia.com>
Content-Language: en-US
In-Reply-To: <20241007140502.GO1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b73787-e71b-4cc7-709e-08dceda12608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU1xbkprVXEvVmdCZEN3NW5UY0dHVnRvalVPRGFWQVFpZUFnSGR4Q1NFWFVn?=
 =?utf-8?B?SXVZZ1BJWE9sS3A4YnYzQVVIUTI0TGxqdHJPU3QwbHR5U3pBbGVua0k2a0JK?=
 =?utf-8?B?TTM4N0ZlMG9hRklIVTBabzB4TU4zMEdwdUdLdnFKUldIeVpvQTB5TXpORGE3?=
 =?utf-8?B?c1RGQ3lyWmhJQUhLTEZndUlyaHZFMmJPaHVra3ByaWpyK0h6MEozWklpZnJR?=
 =?utf-8?B?clE3citpek03Z2xZcmVnWG9hYnpkeTV4cHh3eXVycWQ4RGpoQkFKd0pycFZ5?=
 =?utf-8?B?b3E2TldsRjZBd0ZHdks3Sm9qVHp4Vk1EMXo0WGUyOHZhbHM4TkVRMWEzU1Jk?=
 =?utf-8?B?amd5K05Udi8vNDRoa1R5cENZbHdPQjBCK3VxSndEb01rRjk3TDFtUEVQUmp2?=
 =?utf-8?B?S2txcEdvejdPenFUckhHczB5TDBVS25rYWdlRk81Nmk5UEtIKzFRL1hCRDJp?=
 =?utf-8?B?Q3JnVS9jcDRKNytHajF6UHN5ZXlwRWd4ZlJOdXFTRnFabmVmMmttZ3R6cFlK?=
 =?utf-8?B?eW1vQXlzbzFabTkwRUpLNG9zbGNUenQwaElvNDFmYi9VcFBCMDl6OXlGcm04?=
 =?utf-8?B?TnN2emJEcUcxNDBPOHlhUzZ2REowaW9ZVHhtUnVlaHBkYXRFSkFPRzlKZUZh?=
 =?utf-8?B?VThmMG5UVWlxa1FEb1hxY21SSHRiVkxndGZhWWFPL2NtYTFZRHByOFdEZzJX?=
 =?utf-8?B?N0I0ZVNyZ29jd2doamNnR0N6dTlWRUZHMnltRGtSSTlzaVBlNGdvU1J1MnIv?=
 =?utf-8?B?cEZ1cW43ZGVtNG5PNXhjcjBmQ0pNUEJ3cmp2NG1LRm8yMXJHN2dvSGhtWkZD?=
 =?utf-8?B?dFlpQVA3UnR4ZWF3dEF4QVordDJSWlIxQ1VvYnFTQU8xR0ErZ3lWVXV1MkNZ?=
 =?utf-8?B?TEJqSnFUT3BYaGF5Y1gxcHY5R2RpK3dVZVlXQlQzb0JwUTZSc3NuMXRUZExZ?=
 =?utf-8?B?Rk9JUS92THlTeFRISUNhaVBRZ0lIUThHYVZTQWRCMXdoQ2tiYloyOGxONGs4?=
 =?utf-8?B?Tm1DV0VMTE9GYWFGdjR2SUphbjZlOHg4MG1kdzRrU0NiaG9oZE1UUmxUYnpl?=
 =?utf-8?B?eFVtRmVZZS9IS2xYbmxtOGxOanBZSko3ZjFlT2RoaGxGaWtBR3BaZ3ArVXV5?=
 =?utf-8?B?UG53aWFUa2RVdFFCaEdjS01LZ3h4cnV6VVpXN3BPV05jYTJCN0FCUHlVNzRu?=
 =?utf-8?B?dFM2OUxmYzRnRkxyblN3ejRzR3Z1bTJNMU5QR2xmelNsQVcxVDVnMTRlR1Fz?=
 =?utf-8?B?WWlPMHV3VFRsbUw5SmllQXFEZ0Nnd2ZXKzUzU1BlZ1VuM2dmRFpaWEp3VGNH?=
 =?utf-8?B?YmRJTW14czc5TXZxc3hBR2I2d21pd2FONE4yenlOc3BBZ2VJbjY2Y1RJL2FZ?=
 =?utf-8?B?dUhYaXFCUEtXeDV6eXhXVkVnVXA0UlR0UFZYMDRGZW9NRElPWXpqZ2oxaDFK?=
 =?utf-8?B?QVdxcXpwKy9VODJPVE1OSzFiN21zSXRXQzJnQUFQRjZ2SFJrMjVWYUpIYjRq?=
 =?utf-8?B?L2wwdUkxNHZ4bWIrRTlVSkdiTHBobXBCTkp4Z2JMZlFsNkNhVWRvTlVJWHcy?=
 =?utf-8?B?YkxHdXlmYjUwMlNiVzFrQ0JnOWc5cExUUlkzYm9BYUpGNHhHVVFVSHp5UUJP?=
 =?utf-8?B?ZWx2QWNpUEFiL3JpS2RoYmk1dlY0K2lnajJtU0c1TDdDQ3VSWFdrKzV2S0pM?=
 =?utf-8?B?L05rMTZDYzVVaStTRTQzN2hXRUZ4aUVOTEtXS2VxQ0I2RkpQUnNndHNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0s0RVo3SFlsYWxtZ3VlZ1JmR1A3cVdXZ1ZDN1g2WmhPaXFRTlJqU2lXN2lW?=
 =?utf-8?B?NVY5N0wyUGxZdnBEUFhVOTI3WDNXTUhYSDNLTEJISjJqTVpEK1BtNlJDUHpW?=
 =?utf-8?B?NVd4VHhvaDJoU0c2SzhrMkFrUkJJU3hSOVpheCt3NkcrTnpiVXlTRlM5QjAy?=
 =?utf-8?B?ZUVrVU9MeTFSTGJ5QUdnd1cwSjlQSGl5ZWhyVm9acCtlek16ZTBTdnN5Vy9o?=
 =?utf-8?B?TTdUMG1aTE5xbjBRNWp3MjIvRzNDREhwNHoxNjIvZ0ZtTXFQUEprS3hVUnl3?=
 =?utf-8?B?OWdXb2dBcndzcS9tMzF1dCtsYStZTDRTbUkzY2Q2TGlkZlZGVHBlSGpoVmRR?=
 =?utf-8?B?YUtEY3ZuRmhxRVpxS0hRM3lWRzFaZFFISEJOanl0S1hGeUVqcDZSalhWR051?=
 =?utf-8?B?bU5GTHpYc2FBZWNmVjRjc24yTy9talA1dHpFVzRremxNeTNrVStrWVhnblhH?=
 =?utf-8?B?bG11Sm10RXBVOXo2blgxcVRLL1QvNmpsUW1kSDBLL0pSTythZGZHT3FROHUz?=
 =?utf-8?B?QnFJSFFFQ2llUDV4YjQ3enlINkY5d1hZNDMxOTFuNktyb0pGbGVEdnBRWkpn?=
 =?utf-8?B?T3dZblZ1N1Y3QkNpZnNDd1I3Q2ZENG5IS0p5ci9oWDgyRHRwczJ4OFl6RjVm?=
 =?utf-8?B?TmFUSHpOU1k1UlpGQlFrRkt6VlhqS1J6N0VGbmxrUXIxVGZZYmQySkV4Mk1Y?=
 =?utf-8?B?SEhmYnlsZkFza3FUTDU0SnBRekw2N08xUFBPZ1hZcUprNmJNcEFCaGs3d0ZM?=
 =?utf-8?B?ZENpMkMxSGQ4eEVTVHgzVnNabjNxZzA5cU15SUpZeHUzRExVQjJSalpOVTh2?=
 =?utf-8?B?R3dNdkxVSTNTM2IrM0I1K1ZMSHJ3Tm9jb0h4c0QzSHZ3VVZKb1J2cUNmaWw5?=
 =?utf-8?B?WjNtMityeEszUXVjTy9LOVo3MzdDME5yb21vMDRRdlFPUE9qUkZwazM4RFpY?=
 =?utf-8?B?K3l2clg2UW0zOFVlU2Vpek9hcnZlMHZwdGV5QVhvK0dEOGlJWlFXdmgwTEJH?=
 =?utf-8?B?ZW11dWNmRTBFZEQ4ZUFkUzBWTW9DL2JlVng1UURwd0o1L1ZpRVFoQ3p3RzUx?=
 =?utf-8?B?UjlUaFRlaWU0dmhjakVBMGVIM0UwVXRPWWQwRmhBd2ExN2Rya1grN3NSYjNE?=
 =?utf-8?B?UVlWaWtKZFU5V29Gd2xMRXJXZXpWQUJsanovMmZEbCs5WDN3SzVaTEhzVnZV?=
 =?utf-8?B?NU8yM1VQUElJeElFQUs5VTFOUmRvblNtMUEzUEpBeHRGMGxUNTZiajJJeHIw?=
 =?utf-8?B?WXBqUXc3aTNPOTZuWTdnanY5L0dCSUlKRkMzNmxIMDJTMCtPQzRuY00xeWdN?=
 =?utf-8?B?ZlNXcG1hdGNjQmZvQVRVR2YyNjdvSXFNZ0dWL0NneXl4TUJxS1VMMU1zell3?=
 =?utf-8?B?em9NSWRuMnhEMXByN1ZMblAwVzhqUUtGRTV2aE5wYzZqSDl3MENteHNNK3Mz?=
 =?utf-8?B?VEI2T2tKa2R0NHp1YXdoT0Z2NC9NUDNpdDVQaHpZSE9iV2twL2t3SEtGMDVW?=
 =?utf-8?B?WVZaN3NHTjZBRE9DcUdFaFNpOFNLd3hLT2I3ZVlEYndLS2orZnNFbkh3OTU1?=
 =?utf-8?B?WVlxcERxSlQzM3pEK21aWlQwUzBXbTVuUFpVcXBOOUs2WWJnekFMS1RuaENJ?=
 =?utf-8?B?S0tkOWRPdmlTb1loRXFLSDVtNlRRWWpXU2xSbk1KQTFWK0p6bkhCUTB3NENu?=
 =?utf-8?B?OWJVb0dmMmh4endPT01yTDVlS2thUWs4cFpHVi81WmErZFNkOGVOcmdoTGFM?=
 =?utf-8?B?T0FDRlFUY0ljNUVGVExZL2dHTlN5UUpoWUVsRGdGcGNvVE1XcFpZQnZqdWxH?=
 =?utf-8?B?LzNLQzBKZUZsNi9JSUFqMm5wb1lwUkl6Q1YvdTFJeWFvZy9KZjBTSnZNcHY0?=
 =?utf-8?B?ZUU5T1NScEZDbmxMaFdVNmdrNk5yOGdTZmtLcjJ2ZngvcWlzR2VhMGsxS0F6?=
 =?utf-8?B?TmxrT281Uk5sQUllck9XSFk2WEFCY3lsQ283VCt1NHorVXlZUjFreTA0bkUw?=
 =?utf-8?B?T281c1daWFN0TGpuUFlwU1ZvKzBGdkNTR0F1VDBxdTRPaUI1ZVJqaVdDR3ps?=
 =?utf-8?B?RWVnaG01Q0hKWWltaUFMWUg2QS9ZR21EQVpVUmRCeWd6SVFpNGUvdWpKcFYr?=
 =?utf-8?Q?1oSOmytPb8crqM0/VZHGiZxCI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b73787-e71b-4cc7-709e-08dceda12608
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:12:36.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGOyoLGpZhx7NcpzIArQ+aHJ+wwY78mo82ZGGXaNwgb0sf1TTpUPcsmCv3If3Ua6hMEApMbOC4qSXPZTtyty3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

On 10/7/2024 9:05 PM, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2024 at 04:13:50AM +0000, Suravee Suthikulpanit wrote:
>> +static void make_clear_dte(struct amd_iommu *iommu, struct dev_table_entry *dte,
>> +			   struct dev_table_entry *new)
>> +{
>> +	new->data[0] = DTE_FLAG_V;
>> +
>> +	/* Apply erratum 63 */
>> +	if (FIELD_GET(DTE_SYSMGT_MASK, dte->data[1]) == 0x01)
>> +		new->data[0] |= BIT_ULL(DEV_ENTRY_IW);
>> +
>> +	if (!amd_iommu_snp_en)
>> +		new->data[0] |= DTE_FLAG_TV;
> 
> It would be nice to have a comment here..
I am moving this check. See description below...

> clear_dte() must create a blocking configuration as several callers
> depend on that.

Right, I missed that. I'll rework this function.

> Why is blocking with TV=1,Mode=0,IW=0,IR=0 used sometimes but
> sometimes TV=0 is used instead?

Originally, when DTE[Mode]=0, the TV bit is set.

Then, the commit b9f0043e1ea6 "iommu/amd: Set translation valid bit only 
when IO page tables are in use" clears the TV ONLY when running on 
SNP-enabled system. We didn't clear the bit for all cases since there 
was a concern whether it would cause regression on older platforms.

However, I am considering clearing the TV flag for all cases to simplify 
the logic since it should not violate the spec.

>> +	/* Need to preserve interrupt remapping information in DTE[128:255] */
>> +	new->data128[1] = dte->data128[1];
> 
> It doesn't need to preserve.. write_dte_upper128() does the
> preservation automatically under the right lock. Any bits in
> DTE_DATA2_INTR_MASK should be 0 for the input DTE because they will be
> ignored by the masking:
> 
> +               new->data[2] &= ~DTE_DATA2_INTR_MASK;
> +               new->data[2] |= old.data[2] & (DTE_DATA2_INTR_MASK | DTE_DATA2_RESV_MASK);
> 
> Also this shouldn't preserve the top Guest related 64 bit for a 'clear
> dte' either.
> 
> So, I think this can just be
> 
>     new->data128[1] = 0;
> 
> ?

Good point. I'll clean this up.

Thanks,
Suravee
