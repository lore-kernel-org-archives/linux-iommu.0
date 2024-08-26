Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF2558B6
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661400; cv=fail; b=WOYjTA3TH5+GQDseuZ3PeVDDLkSRpX6KBZPm1PC/c7RBrFQIDu6OfmJJxZYDNQn21gXAqr0n6RJ65vy7mXLHMklKOidgd+v7M0U/9dZr0XHcb5lOAPugLviLiQ7SGcC4CS25T26JFbljmgojBfJCJ/feMmPRNDFCUr501du1NKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661400; c=relaxed/simple;
	bh=TWIL4pwZdd2ILLPkrBX18bg1svOtmJ+C6bfefPnVOIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K8ES54HZT/FJ2hzniFv6fmwZTb+YThRUSmMEX64baUx3NVpq5EqoGudtULEq3ha7Y0MrCG7cgpt0EHf812IOxew2vWgsjclM+sFgtE1/g3Ho7T0hO085fd9WVb1H2zsA39f3brV6y9klghMWZUGWagwC9eikDO4l63HTsIND2us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k7e7Utqo; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k7e7Utqo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrGYKu7LNPp8V/xJqZBxEM5WTBkrRRiZH+71ugPDzgLLM8XSvBzsRbcX/mzeuwutwuK8XijyWtx0uNNPPsaJtuMlFIO6Qn6cwxqdFhbtPbz2/gsHq3389i7YYrlKky+KS9yw0OhMBqdP7ZW6oFzlOtGOcaOfk5YOolWJI5t1ZN/y/BdSHN0zBS/LJCqncYTN7wrCcd7v6nYWnG3ieYa81zRUXw+YCO2NGjOv+28rXFoV5qu5GWsRzTFqKOzQU2qI4/tXJqK6617Mbq9S06KGZada/18q6CrOXzIYuF65pIRWc6Er/EeqEQcsav/7dM9z4L43iFaoMjq7qXb5G8tkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7Bql2+vEnzfslymi+dyQMMkPEmOm6GQNP+6lUamYGk=;
 b=ebsWHgLUNbKqb+ztLX9h+1umLxgyg2afNrmT8u/V9aIC2cXRGR1bgDlxGAxaVy+Kei+UnYU8vfE4GymVE8soF/X9Uybky2mNFCmDFUGYyPkFOac3MidcPlDJK3oWxi+VTP66Omo13inbf0TKjsYXf75CMPdWpgmln4/yqW3boeLH7EfBY5JeE16HjQ59JHktpFGdS9aoZI8IdMpKmtdXF5gN/dTO/pkFzZA74drS1DzH2zIFC7D11YN9G/i3KJxPdMWlSoWfVKRPyxuqItqcpcjslNhiiP52lRMTCYyxOgHDRJYcTn0c4jZqYdqGJnmh/PQ09IR2c2U8R0usm85RfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7Bql2+vEnzfslymi+dyQMMkPEmOm6GQNP+6lUamYGk=;
 b=k7e7Utqog7d9hgJ+FT8imZbBRwsj8c6CMaOHAxf4ZxVwuAivf1E8rtw4ryCmfYT9t1RqPPmWej5QBRiLVsawDWf8M6b+FhOVI5lNJkTbeBbHTWt47SeOrTaIK6VqCJmEteEQN6kfzPEeL9f7iSehI67RMfA4WBFVku+w8arjc1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 08:36:36 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:36:35 +0000
Message-ID: <5fd22a04-ff5f-4763-a93f-268fefabaf7b@amd.com>
Date: Mon, 26 Aug 2024 14:06:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240821163147.GZ3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: f34cf51d-11fa-4b10-fe39-08dcc5aa3217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWNQWGZDVnkrR3hzVTB0UlhDWUFibE55TmNVeWJTcGliUGhzTHFDbCttQzVj?=
 =?utf-8?B?OGoxc2tkczVsRzBuaEpYWXVGandndDVUWHNuaDVLM2V6SlhHS0ZGNThxTkZX?=
 =?utf-8?B?QXdYaW9VZ0Y0cWRJeXdyeVVqc2wycVhHNWpYZ2tDeWRNQjIzMzJQN1hldWlv?=
 =?utf-8?B?cmpoK3VSVFBjcUlUN3ZlYlA3a2N3UGhISS9PQkc4bXFYY0htYVdPMkt2UTdX?=
 =?utf-8?B?NlFELzUvVkxjZUxWdGRScnEycUZnNEhkSlZNbzJYemltYU1QU2Fxc24xQ28w?=
 =?utf-8?B?NjhSNW43TWMxTUM3cVNqYWxKRHhJVWRyMXIyT0lXdFIvd1ZDUEJGL1BEUWtH?=
 =?utf-8?B?L2xwd0U1VGZuMWZUVXFHY2dXaEV4UTdsaEYzVE5MYWtpWWt5SjdlVlB0Wmhs?=
 =?utf-8?B?TGFHY2tpanFUYTNQdGhrTzR4bFhSWDhaUGJpakI3VHNMVTNteUVYNktWanBH?=
 =?utf-8?B?TFdMS045TjVSODlxZnByM2pJbnR0d2FHZld1dHpMWXhHSHpOQmxBU0hqSTYz?=
 =?utf-8?B?UGJzelZZODdBTGZaSUtvM2dHZ2Fmc2lIZnRZaWFpbDJ6bHRwN0NHamsvTVhm?=
 =?utf-8?B?RHFPQTZvSmVrOEhUN0NGcG5sUEFnSEhoaWh5MTM5WDdzVG13b29UUGNmNUVj?=
 =?utf-8?B?M3N0bG1jc2hYcWpsV2hld2ZGNDNLU25LODd6T3FiV2VEMWNxTHRReWpndlJt?=
 =?utf-8?B?eHZSMnpoQmF1QkQ2d2FsbGtsN09FaGF3Ym0weG01STFoN21tTXVpR1BOc0po?=
 =?utf-8?B?MGRodlhkelRkd0M5Wjc5UjZ6blJOVlBHbW1zVGpWczE2RG9DNFIzMGI3eUFV?=
 =?utf-8?B?VlpvWTVEd0czek9TMXJtMjVtdm4wdHZ0cXdjdDVWcDJtUDVhbkFBNTZTQnNI?=
 =?utf-8?B?V1lmVXNYaVZNM3VaNVB2ZWhYc2t5azl2KytCYStxMCsyMFdMc0wyT0dJVEtU?=
 =?utf-8?B?VlF5N2xKTjZwRE5SS1VSOVgxckE1bXdGb0d5aTBEM21hSWw0S1dCeDZNWTdj?=
 =?utf-8?B?K2xGc3ViK3ZUYUlzR3VoNjFnSGtLRkNVOE9CS2I2TTBSczExeTlGUTdENTNE?=
 =?utf-8?B?VHduSWxTbjVjMWVHcmZpZ1N0NjRNdDV4c1hCdXJ4RVlEV2doMFAvMGFYQWxt?=
 =?utf-8?B?a01BWmVTOEd5UFpYNXFpanpGOFhXOHZlQlhINS9ranlBY3RRTHN3RnB0Q3g3?=
 =?utf-8?B?Z3lvVHRoWFZaaFVxUHdMalg5OFFNU0R1dHd2Ti83ajh3NjNQUEZpVC9sN3hP?=
 =?utf-8?B?b2FWSWZFNW9kQkczTWV1SmVSV3N6ZGhiVXRIMjFlc2pzaEk2ZlpsREZlSWsz?=
 =?utf-8?B?TngwbmFsRjNBWStJNTdyelJ0YUVVUllVbVZLbnlOODZFeno4YXA1TVFKSWJU?=
 =?utf-8?B?MU0zaXo0KzBMV0RjVkhicWVhTDJQb25kdTNWRVRmdWRTc1Y5ZzFrZ2tmaXEr?=
 =?utf-8?B?cmRUMEdCWXlXK2xCbFpjZEdEVHZqUUhqdlM3Q2V5bHcwKzh0Wkg5aUVMS1Yx?=
 =?utf-8?B?R01pRGh3VkRTWGlqUXI2eExwcjN3RXljYXVtOFd3MlE5d3FmS0kwVlFhRnBR?=
 =?utf-8?B?ZTdPRlA3Z29vNVAybUlmQlg2aDFLcEtZYWJyM3VDbFgvL2FZM1l0Ti9TNEF4?=
 =?utf-8?B?UGtibS8vWmFJK1BPOHZWbE5tKzVWZklncGM4U0EwWDVDZXJ4VUtTUVhVQlVJ?=
 =?utf-8?B?YkdtaHRvbTcrUG4wLzA2anQ4ZWZnSjJVd3dRaWVDM0FoR0M2dmVoVm9Nc1hL?=
 =?utf-8?B?V0swYTJybng1V0gxTVdXekVuTXFyNVE0Y0VMaDl3NEFuTmRBTUtmN1dxMDcz?=
 =?utf-8?B?NkhBQ2thVjBKVFdxUytyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHJrUmtaTjVWZVhtd3hGaTJvS0h6TjNaTGs4cGpjNW1BN2pCZXk4V1I4dWY0?=
 =?utf-8?B?dklBelhSa2t5U2xjMHpJVUJCelpSNEFrWVJ5MFRTK1JuL0VWZjEwTzA5Q2tt?=
 =?utf-8?B?bzJ0bHBHY01JdVpxSDQ5eWtUZVRQK0NsejdMSStiR2s4YjREeGIrYUhiWS95?=
 =?utf-8?B?NmpUZ3FQUVArRHhuVGFOZE1pRWh6eklkMEx3RUxIcXNodkhrV3Y1bHIvZ2ly?=
 =?utf-8?B?L1FBZmNjNXE5ckdNY2h3c01nRll1VjQzeE56cUd4enAxMS8xT1FGc25ReEhy?=
 =?utf-8?B?aUtzVm1sdWZsTjhtRnQrSnlxd3B3L3J0U0xjNG8yLzFJaHNVMVJFbGdQaEx6?=
 =?utf-8?B?Slo5Snd4YlpXcldaRG84MysvNXlLT1dXT0xyZlgxblA5SStRMlZIT0R1bFZo?=
 =?utf-8?B?Sy8rZ1U1eElKYWw4TVZrSHdHV1Vic2FRRnE1VGRiUTRTbFhNVC80TDhlZExB?=
 =?utf-8?B?L1NqSVBHeXBmeXI3V1pEQ1dUOHFkaEo1VmdvdG1tRVJOL0NPazJOSFVIV0tX?=
 =?utf-8?B?NytqUXA2VndhSDJuQTdCd3ZNNEhybC9KZXdOT1FvTFpzNFBiMnY3MThkSTk5?=
 =?utf-8?B?aWNsb3hidE1zVnFtckFsbFgvWEg4OWVySWlPclJxaXhEMmUyV2Rucm9xV2ZH?=
 =?utf-8?B?QXVJcS95dzBwZDRhcVQwcWp6OVFIVlRhNEhoNXZ3MjVHQWJ0TTZLQ3JYeE1E?=
 =?utf-8?B?dkxSUXYzeThWampsZUlOYXlsUUlGcDlTVzVIMnlPVndGMUhNbEtZYkFsaVpO?=
 =?utf-8?B?a3lZUnFYVkZobkczYTRzZFhEbjNFeFpkTkF3K2J6QnBabWpteFVhZ29lQ1NK?=
 =?utf-8?B?N1Jka2owWFpaV0JOa0g1MXNaTTNiemxqOStLNDlCN0xNS2IwYlArb3BUcFhK?=
 =?utf-8?B?QWhOeXptRlNROW84NjRzeXprWHB3aS9DN2EraFp1dVpESzNGT1pGN0dISDlG?=
 =?utf-8?B?eGs1VjQxVGpoUlUxaEZrMUNXemVaVVhZYzErSGhRSEFEcTRYVGx2OVNXNXhM?=
 =?utf-8?B?bjRSSEVZOWtUS3lTU1JZWEVia0ZQL3pXL2h3U1RCZEYwSmdWT0xxa2lLQ0hP?=
 =?utf-8?B?bkpieXo4ZDlrS0EwUlpvbHNnc2VRcS9MMTNsdmpXQktZM1h1VGxlTG1GenQy?=
 =?utf-8?B?WWZsc2pUSUVqbTBoQjRDVkpkUXNXb1h1b2dsdUY2emRpQ3hacXpMTGdUMDJR?=
 =?utf-8?B?cVRjQ0RlQThGbTg5VE9yVkdGQjNBdXMxb2xDRld6RjZLZllVRmtuVmtqM0Qr?=
 =?utf-8?B?VnBaQW54NkFxQWdrMm0xbngwMjM5UzJPNEc4UWVEN3lYQXhuais2V2oyWjVP?=
 =?utf-8?B?SUpFR0tlY25rUmdOVko3WHB4ZmVnZDBtdnFkYWVhdEVYU1V1enVTcGZ6dWR2?=
 =?utf-8?B?UUduaG1SSjh3cjhsZStvMVRSMU9xMkdlNTMzQlFiV0p3Vk91dTNrZ1dMQWxr?=
 =?utf-8?B?VTJLSmVhdzdsV2I2MjFsamNkZTNwQml1clQxNlRWSGl4bHVvQVBYNXcvMVlh?=
 =?utf-8?B?dW1hZERUQXZ4dzV6SjBwQWhJQnBETWdqSHpBTk1qRlFtbCtHRzZiVnZDdlJW?=
 =?utf-8?B?dng3MXVBMVdkbmdRWVJ1ZDA2Tm5FQUplbXdsU01ZYVRRTHd3SWV3RDArV3JH?=
 =?utf-8?B?Yk1VemdjTW5uTVBMa0pzNThMeEozdHFaMDdpWS96cEpPMmVTS0Vxb0NEbVlN?=
 =?utf-8?B?N05pWFJZaGg2WGp2cHhLcy9kY0NST0NzSUFITUYrTkZIb2ZtcDhMS1FYR1Vh?=
 =?utf-8?B?Y0piUnRYTHhmeVpSdFRYcnVERlVLNlVTeWx2UmdDUDJYZFhsZkNGTXg3WjlL?=
 =?utf-8?B?UjNlZjNjdlhySk40UmZLd0NvUC9CUUpkdVRGTFZ0U2hFQXFXNkNsOHREVmdm?=
 =?utf-8?B?SGRPcHNObkxuWUdhRDNHbE8vejBId0VLNXJtdCtVYU5PWWpucHBHM0NFTXpZ?=
 =?utf-8?B?SlpoL0RiY0JUU040cTY0WFZDTCtMYjltWllDUmNnS2Y1ajUvT3FzbHRkc0Fh?=
 =?utf-8?B?UUxrOXh6M0s0YUxEYi9QaXJjdm1SYkg3ZlB3Yk1WWEo0aU5UWjhyN2RHN3BP?=
 =?utf-8?B?c29renEzZWFtdHFGanZtWnlQaHU1QjdObVArbU1FeXpad1IxSWZzSDJKSi9H?=
 =?utf-8?Q?WGl/mFJWTxpYZvX+vV6jqwrgA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34cf51d-11fa-4b10-fe39-08dcc5aa3217
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:36:35.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7JSpVRomBY6lWfsegjrmbZnbs+B2noDN/F1k1rlmt7LfdyOHMaAiETAtRdM0h/EsDVqGooe3aK1YlnT3VReiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

Jason,


On 8/21/2024 10:01 PM, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2024 at 01:35:50PM +0000, Vasant Hegde wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>
>> Currently drivers calls iommu_paging_domain_alloc(dev) to get an
>> UNAMANAGED domain. This is not sufficient to support PASID with
>> UNAMANAGED domain as some HW like AMD requires certain page table type
>> to support PASIDs.
>>
>> Also domain_alloc_paging() passes device as param for domain
>> allocation. This is not sufficient for AMD driver to decide the right
>> page table.
>>
>> Hence add iommu_paging_domain_alloc_flags() API which takes flags as
>> parameter. Also update default domain allocation path to use this new
>> API whenever device is PASID capable. HW driver should implement
>> domain_alloc_user() to allocate PASID capable domain.
>>
>> Finally introduce new flag (IOMMUFD_HWPT_ALLOC_PASID) to
>> domain_alloc_users() ops. If both IOMMU and device supports PASID it
>> will allocate domain. Otherwise return error.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
>> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>> @Jason,
>>   Notice that I have added __iommu_paging_domain_alloc_flags() so that
>>   it can call iommu_domain_init() with appropriate domain type.
> 
> It is okay, but also the type could be fixed in
> __iommu_group_alloc_default_domain() using something like:
> 
> 		ret->type |= req_type;

Sorry. I didn't get it. You mean domain->type? If yes, its set in
iommu_domain_init(). (That's why I had to introduce
__iommu_group_alloc_default_domain()).


> 
>>   I think instead of having separate function it may be better to
>>   enhance __iommu_domain_alloc() such that:
>>     - Keep below changes from this patch
>>       - iommu_domain_init()
>>       - iommu_get_dma_cookie call inside iommu_setup_default_domain()
>>     - modify __iommu_domain_alloc() to additional param (flags)
>>     - iommu_paging_domain_alloc_flags() will call __iommu_domain_alloc()
> 
> My expectation was to basically remove iommu_domain_alloc() entirely
> once Lu's work is merged.
> 
> Instead we'd have these direct APIs:
>   iommu_domain_alloc_paging_flags()
>   iommu_group_alloc_blocking_domain()
>   iommu_group_alloc_identity_domain()

Sure (For AMD driver, we may have to tweak a bit to allocate_identity domain,
but doable).


> 
> And then iommu_group_alloc_default_domain() would just call them in
> the right order maybe like this:
> 
> 	if (req_type & __IOMMU_DOMAIN_PAGING)
> 		return iommu_domain_alloc_paging_flags();
> 	if (req_type && req_type != IOMMU_DOMAIN_IDENTITY)
> 		return ERR_PTR(-EOPNOTSUPP);
> 
> 	if (req_type || iommu_def_domain_type == IOMMU_DOMAIN_IDENTITY) {
> 		dom = iommu_group_alloc_identity_domain();
> 		if (req_type || !IS_ERR(dom))
> 			return dom;
> 		/*
> 		 * if iommu_def_domain_type == IDENTITY fails then fall through
> 		 * to PAGING
> 		 */
> 	}
> 
> 	/* iommu_def_domain_type is PAGING */
> 	dom = iommu_domain_alloc_paging_flags();
> 	if (IS_ERR(dom))
> 		return dom;
> 
> 	pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
> 		iommu_def_domain_type, group->name);
> 	return dom;
> 
> Which is the only place we need to make a decision based on a type
> input.
> 
> Hoping Lu's final few patches make it this cycle
> 
>> +static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
>> +			      const struct iommu_ops *ops)
>> +{
>> +	domain->type = type;
>> +	domain->owner = ops;
>> +	if (!domain->ops)
>> +		domain->ops = ops->default_domain_ops;
>> +
>> +	/*
>> +	 * If not already set, assume all sizes by default; the driver
>> +	 * may override this later
>> +	 */
>> +	if (!domain->pgsize_bitmap)
>> +		domain->pgsize_bitmap = ops->pgsize_bitmap;
>> +}
> 
> Pedantically the pgsize_bitmap is only needed for paging domains, but
> it is OK like this too.

Right. Lets keep it for now. I can do a cleanup patch later.


> 
>> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>>   *                                   enforced on device attachment
>>   * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>>   *                             valid.
>> + * @IOMMUFD_HWPT_ALLOC_PASID: When the domain is used on a device, with no
>> + *                            PASID, the device will support later attaching
>> + *                            a PASID as well. Some HW requires a specific
>> + *                            domain format on the device to allow PASID to
>> + *                            work.
> 
> Maybe:
> 
>  Requests a domain that can be used with PASID. The domain can be
>  attached to any PASID on the device. Any domain attached to the
>  non-PASID part of the device must also be flaged, otherwise attaching
>  a PASID will blocked.

Ok.

> 
> Yi will need to add a check that IOMMUFD_HWPT_ALLOC_PASID was
> specified on the RID domain while processing attach on the PASID
> domain.
> 
>>  enum iommufd_hwpt_alloc_flags {
>>  	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>>  	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
>>  	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
>> +	IOMMUFD_HWPT_ALLOC_PASID = 1 << 3,
> 
> Let's keep the consistent spelling IOMMU_HWPT_ALLOC_PASID

Sorry. Its my fault. Will fix it.

> 
> I think the series looks OK. The naming of domain_alloc_user() is now
> a little bit weird, it has now turned into
> domain_alloc_paging_extended().

Ack. Do you want me to do it now -OR- May be wait until all changes settles down
(above described group() related changes, this series, Baolu's series, etc)?


-Vasant
