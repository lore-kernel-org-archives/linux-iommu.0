Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF12BFC60
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468911; cv=fail; b=CML4wa7pHH8HdJyS0x/u1Hu45/sY/ntEPMoJiQXGoVcJz26D8pPjlV463aVvTgtTUxr7RU9dmOi+kAQvkaNeNqyC1CcF0YU8RTQ3B+eM2rNBMEdVuOiLYF3pDCOerbHGau2Yx25G/jQw9pUqyp4PACQzdd+u/wzR8/agDBT/dio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468911; c=relaxed/simple;
	bh=x3HW1fYs8eXtr7VWYjuLAcaX0YFYLNSWS6cnsiACKPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XhRRhSH7zSzCNpjvBGzfnXWOgjYJ1f56aJue3bSr56iBw7KTlSDStSwv4Rz1pA18++z7PTcBbdR/dGlSmv6n6NED06NbhnyeHjkz9RxLMHDN53yt/X4m+KX8qzzN4M9vN67xFUvsPEYoxcao3J6DpzXsZ5J3fHLgMMvZhVdDASI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RhH97moo; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RhH97moo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEcw8yIBJFxBJe2u5aO193qC98rpVWUfdL4ODNX4H0cp/SMk55/fydNCMZy88QNYAEtPE0xg3VRSHH2qmkVGSNosPIU+3B59W4fOZ2t2QTPYVzsRfVwu/gP8+XJhedL0lLDBrvc4ZyJXAIlDJhvtde+zekcZFA1LbQOd8Kfbr+aIX98mryMX6o7gAJPrMNcs2BE7keDRzXhlk0r4RKjR3rbuV/4TRjdK7cQ0qSpRA8O1cZ1ZDAw+fmS6M2/FwqQO3sdUG67Xd4Wa/+9ByPRNEi9RxFHHDC+0EeeP2sKyMqcpgeESKoKvAQsF4i4c2ypo2egjuP+xKPAwUryczg1ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx7D2nZdCBDM/AvR7YSx5H9BoQiP0BuoSvlBg3gDXvs=;
 b=dFDceg1EJ3CnO9VmFE4jHyoltL4Bp+sDwvHppWBDLkz3m0l4FILYW44lJ8A6CHyIlmCCVp6tVjFouACW+g6IF3980Kefm8GE8Gxg+ckd51F1BmKSWpDHGG+/EdGeJRFfsx+sGa3ANtqsSoK6Xs0CTdsMlNIPL07evTclm3kIJhdFiQRh0kcHo9aQipeQgsaXHhFlsidBa/A5HaE7VomIvHVg2z2BCwuk9SKzgrKGJ9sy1lDTeXHNQ484N8uKc8w4irwi08kzLO+6hh2tENCwWihIqUYsICUsNN0BwzCv0/v1hYpwdYh/vP3Z3xBVoS7eFzcU5lBxxNrGUaCkM6svdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx7D2nZdCBDM/AvR7YSx5H9BoQiP0BuoSvlBg3gDXvs=;
 b=RhH97moo7207juCTQAHIHQm4oy5rbF8BYSCYUnsZuQx2chH1aA1mtmXb/931IVJiiI1YhGlwuJai8u0cIsFfmQKg8K+LfQcRlIUFh8fRe11IvSjLWE1pRBfSoaC8URFF3zCxGEUKg29T/f/NmA1QFk7K5xP2A4OzOh9VQushYlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:41:46 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:41:46 +0000
Message-ID: <592389f0-3068-4b7d-9999-5fd188dfb293@amd.com>
Date: Wed, 3 Jun 2026 13:41:34 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/26] iommu/amd: Introduce AMD Hardware-accelerated
 Virtualized IOMMU (vIOMMU) Support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260601133031.GA403363@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260601133031.GA403363@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 61631b93-46e5-4131-cd17-08dec13b2eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PiaaHfiGcSYuAZ0L/zskhM+P5q6bO4gqg1zEeUUmUKgCtWXx8tOH5OSeCgyTwFbUkqQ7XnNhIF5U85H610o8kQljC0U9xmlmvfYgtyE8ppqyJFkxyNBvsH2evZyl0ZlXX7WVwVyrl10EN7sP0/U1FoCrq/QoMWQt2M+GtTRU3OAxXTRqXD+aN7f4XyUz2AbdlHoC1Ac0qLVkYm0oXcZ54IbRzEfGoAcogCA8HUZ950HirM3n8E82D0lVlrLvXI/cMDgr0OWqKdrxsDZDa1sAMyCeHzy+VRRPvPhGAsCwhLeHXpyuG8JQyMxb2f5GMepcg9qxqBjW5UvnmQwT3eBKpCLV9ofEimbE5/6Yyw1Oz5I67a08UusuYAn1SEtzKrOqwkw3zT8HhGG5GPIb+UOwJxIJdiS2UgqIWaJyPiRklWjqSRBXnbugFx3vYJCs3Ysf5IJI0R7ZB3a1qHoWH2M8xaE0p/RZzjD8OuKino12UD76lIB0XBOUZhTwnmS930L5x18K3lXcfYwHuEdd+WCSvfGzwawRTRJtX5TsL79Fkx5/4bbRcvNWa2xqlAp70RnaxWO3Rb/dQuwlW8Wh44A+VNOH9QOZlUq6MT27ZBEH+vjQSc3zId0eOCinhPH5wwaeis8mWAwBVrfknPzp3fWqArr6znv0bG83Y6wbq8Hx+HXIqKO5tARpvAh6/Tac2uYz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDVld2Z4ZC9RKzRrVEE1cnJ2WmdHQ21qU0QzZWlqanhZWk5oTzhYZldkK1Ur?=
 =?utf-8?B?ajlrTUdLREVMMXBheHhDQVVxcUFKN3FIWWJxZUozV1FuNmtIS2hzRWo4YVNz?=
 =?utf-8?B?SFJFVFpYSlByZWlPdlhLOEdyVU9ZVFNJaDRpMmtqb0MzMmFES3dYZTFGWDZW?=
 =?utf-8?B?SW5EK2kzSUZqdUdLM2xIL0xETjJqN0YvSDJrME02QjdLTHAyZFRKN1JXOWxu?=
 =?utf-8?B?Zk5BK1U0clQwdHo1eFI5RTNBSEhER3FmRm1CZ3NSS0FyY1Z3SW5JaGNObWFS?=
 =?utf-8?B?OW83d0g0UkFPOXpLS1VQQ2hDQWZxWnc3K0d6WFNDTjFMdzJKeHFIV2pEZElt?=
 =?utf-8?B?MkFXbVc3QjRqdmxmdTh4bHo0eDBNQXppV1hDQkNRNk0vWHNJbHpQbFpZK0tY?=
 =?utf-8?B?Mjhma1JDZDFtOVdSSEx1QjFaeGpRQjNQL09HU2J2eDBRQmxoR3dDQ1czeHFn?=
 =?utf-8?B?NVRXQVA2TUVEMittcTlIRFhBZHBTS2dSenErSTFrQ3ZCTkxjeWJsaDFwZGFG?=
 =?utf-8?B?bG02ZHdHQW45YUtPcld1WHdUMGEzU2VONDNEak9Sc21jSHhTLy9BZXlON2Q2?=
 =?utf-8?B?K1ZwaHdDY0dUTU16WlBSbndGWmNoNmRZeks1WnA2dHV1aGw2cUF0UjUwNGNO?=
 =?utf-8?B?ME5kUkl0Z1NtSFJSSXBwS0tzWW91WGd5VUpIdlZtWUdWbUJpQ0N1eEJTK2dk?=
 =?utf-8?B?N1dUWU03T0ZaYmY3a2psdnk4SEF5ZHkyVk5kNnRDWEFLN1VsL0dOTndtS0ti?=
 =?utf-8?B?YTUwMGNHVDVPUThDcjFLOVdiR0t4d1VOZE5IdzZVU3VhZWxtTDI1cGI5VUkz?=
 =?utf-8?B?MHRQQTRlZi9vKzI0YUMxYi9pOHRXbi9FZUUyQUZwd25xMmZrb3FhcHNQZHQ1?=
 =?utf-8?B?RjZNRlEwV0lzak5rZFBsYWR3czg4cUFXNHBDak94NFpHM00xb1psckNMV0FW?=
 =?utf-8?B?QlV0dXNManFCT3JXREtkMDJrTzNmMFVZUUNrcWNFOGhGVVNrL0Vpc3NLQzVy?=
 =?utf-8?B?V1RjdEVmWGwwRnpuUld4MUxlYTdXSmRBNHBJRndTblpWRWRaenM1UzgvbkRl?=
 =?utf-8?B?OUV3dEdFYi85bjBPZm9RWFE0Mjl1L0drU2tPYytOK2UxKzArZUdQSkVOMVBq?=
 =?utf-8?B?cTllc3RxTTdxS3JJanpyTTl3VHN3ckFBMW8rbCtsbFJkTU1GellSeDlkak92?=
 =?utf-8?B?eG0xdzRSem1aVGRUUUFwU0I4d3N1ZGE0THhzaGtmYm5zYkhCbWprMUdvS0VV?=
 =?utf-8?B?RHZvQTJ4ZzZtYUZidEFtL3ZlY2dlVEY5dkxpMEJhS3JKejYrMVdsZWVjc0NX?=
 =?utf-8?B?RVB3eityczFZb25hMFNZMnZZRWtRWmlXSkdlK3VNY3grbmNOSml3RDdVUm9L?=
 =?utf-8?B?K3ZnRldrYjJxd1JFeklvZjRiZzQvNjBUd0NqVjliRVgzS0tBVjdPZ0x6VXVH?=
 =?utf-8?B?TmFLZXJxcFRsT2FPVnJldlNtOG5yMkIxcXdIbUtLYjFVc0VPUWdsMFQvK3dl?=
 =?utf-8?B?aHZoOWxWWU9zQjV6MVdpZVhzVkpGeXZUMEIyTTJiT2xFb1libXR0d3laWGto?=
 =?utf-8?B?dTkrNlFjcGJJVEEyUjZrSDQrVmhVODBZSGR3UzR0bTI5OGJxZEY4Z3U5OGlx?=
 =?utf-8?B?dDVZcFExY3lTQmFXeVV0R2x1YzVjUU1PVUo3RDZFWklCM1lSNnpvY29mV0lO?=
 =?utf-8?B?b3M4WFdHVUtyODZ0R3VnNWdUa3hFejZNVW52YTN4aTY0Z2Y3UXhXalE4YXZQ?=
 =?utf-8?B?RWRQc0hIdDh3NmtVWGh1d2gwM2NaMnRnRFZwTVlBRjNQeCt2OCtHRE1SMTFK?=
 =?utf-8?B?OXZGNm1mRFBGcmw2czV4VVIzeDc0VmhVVzNNMEh2dG04eHNiL0tjVGEvN1R3?=
 =?utf-8?B?Tk9oK203ODVLSnhXa3pEVW9PSERmNDJnRlQ0M3BBaVZlak5iN1JUMFJjVkFL?=
 =?utf-8?B?UENvV1dBYnVsWFpYbUVqY0ZocW9XQk15ZEI4VEloOVZteUl3UWZPVGdGUmE1?=
 =?utf-8?B?WnYzRkxWUG8yblNyVXhDd0tnS2NkdE5PamlTeFBRSWFZaU1aZVdWZy9JVGEx?=
 =?utf-8?B?alJ1dHIyRUJPV0NwU3NVTHdBRUZiZmR6MW9hMmhEbjRQVGdqcVA5UWlhL0Vu?=
 =?utf-8?B?WS9xcHcyUk5uR2k0NXNlaE9odTFkUFhZL0IxbE8waWhnWlcrdEprS3UvZEZa?=
 =?utf-8?B?L09SS1N2QWtrVFVOQ28zTmkvdGczQ0J0dWdsMERwN3dPR1NMZEtZR2JLUEIw?=
 =?utf-8?B?UkZrb0ZjeDAyb0tjekRoUCtOSHovK0V3WFBPelJZSWZ6YkIwVFEvcyt3UTdn?=
 =?utf-8?B?VjZhR2lJVm93VUVxbVBoVitIdGdQYlB2Mms5VUpBODhGQmVyU200dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61631b93-46e5-4131-cd17-08dec13b2eba
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:41:46.5375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjrMwF0IU5lffZJSB4GeiALvIwNvtnwcPQnc/urgc1NrUs+m/DKv0odNpPeRboTVBYJkm5R8+wN/cw9kowX1cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722



On 6/1/2026 8:30 PM, Jason Gunthorpe wrote:
>> [2] Linux git tree:https://github.com/AMDESE/linux-iommu/tree/linux-7.1.0-rc4-amd- 
>> viommu_upstream_v2
> Build test all the kconfig combinations, I noticed problems.
> 
> Jason

I have build tested w/:
- CONFIG_IOMMUFD (m/n)
- CONFIG_IOMMUFD (m) + CONFIG_AMD_IOMMU_IOMMUFD (y/n)

And they all have passed. Could you elaborate on "all the kconfig 
combinations"?

Thanks,
Suravee
