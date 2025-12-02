Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC352DE70D
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764652911; cv=fail; b=GyW1uonWzo6HXNrD/nIG8b+blMLmRkxMzY5HX1e409zfQDEo6j7Vp03kqCdZZMXTc94pFbki47fb6l/D4WD+7Nf/A8/i7uYD1EDRqFCuzSQdLwF61vkMru8u63iCX4KIatwawctqjVBnvPQ3MVTDRUc3+LZZOXC0KuZeFgeq4Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764652911; c=relaxed/simple;
	bh=X5HZRjurxrzhW56b6PMNw4WfrVH+f3nM7PLy4YhPXnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PRqsBYF57jOagTESGZXmRJG6cjLIJq8pKh6+4F+XP/ldvlOf11bFB+2/2SZaPGBxSFZ7mKd0OimRZq1draKWSCaBwL7ExbIUN6nsZiJoGurw1ygpQlax7grKd2CZ9XMaVemli6goJDSXhn5cZ+0rCKVL42pAit2W2Bh7QpGR8eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GR3pbZiC; arc=fail smtp.client-ip=52.101.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GR3pbZiC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6yy1tKsHyEfzWJtwaaNL2mDbaIUfp+7M1RJ9wuvD8RatByoNN8Tej3xEormUkgao5Gqpi3kzQKLwbfcWNuDVRvEOMqRDmx6TLQa9KVqlpNXAyjjn6CbJ/3AU/GZKIx1T8PMAiDJqpHIY35pPNlVnVKV9llgMqGhlUTjueOXIGELe5buNiPJOmg2r46HdCRULGslTewYrmTQBQuVMQY1TDxW4pGMkQNH4OUgeC7fRQhEQgOSotHrLx5cY+DkPrWqlofeI7U2g1ldM/ABK3ZH+rEODnO5Roh6YLfketppvhehCQxbVA8A57glmSPibc6RxAOzHrRILXm6CJTzF1gB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEXYrcofIyjDS5XQKMdaFa3f9WEmnl14h46kw4jEDFE=;
 b=qhGNxhhLp+vQvqgu1JjRAjIlC5uCNvUkT74LLm/n4d5PAiM/yDyHIdzTaCGhPjlR/HH5Al67yBwz83T1qrHWNNaytuzOh0mVdcrArvUxFqG42TQR/kWLqT3MF4M+UawcgPdjDxzsarjxtMt4WZgKIcdai56RakMcUKlDTEgC/3mc8ta2pWOC+Ua8f+8Jw4c/VdwnNSpC3oyC9jQb5vuo+QcY68n3WBkM+KASRSkvR1UD48RCQIa89laS0CxGU4N5vSFtVKIXq6S3aeB0RzeIA8dccsAXs2xFv4G0uRjD1fw931f6hcxuGLfGjgkr102vAw7OyjNlcb2r4HiGJpXrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEXYrcofIyjDS5XQKMdaFa3f9WEmnl14h46kw4jEDFE=;
 b=GR3pbZiCboHIt77sWEUN94m/RaIOW4gIazy4p8dwOCrbcz6vMmEzVKNerec4bByLLkm9b9yS3G1+S0gSsY8vc717c4jafiu0UWWabe3zMNygCRZ6FipzdkG19XUjQeRNRBTbXW3zYcq4ejf5gzBwenw9jzzmuD8qkmF7w4ei5sM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 05:21:47 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 05:21:47 +0000
Message-ID: <e71c0c1c-8bd8-4ad7-a8ed-c5b005a72788@amd.com>
Date: Tue, 2 Dec 2025 10:51:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, robin.murphy@arm.com, ashish.kalra@amd.com,
 will@kernel.org
References: <20251121091116.25663-1-sarunkod@amd.com>
 <20251121091116.25663-2-sarunkod@amd.com>
 <20251124144458.GH153257@nvidia.com>
 <b15c4495-3765-4af4-8cf1-38c64e8fa69e@amd.com>
 <20251126152040.GH520526@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251126152040.GH520526@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0077.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd17bd2-47f8-4b41-5f7d-08de3162b085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3RkQjFvR2JWaWlZOHJtY2dKMlArdVYxTnB4amsxekRtOGNEOVF2N2N0bWFs?=
 =?utf-8?B?SlpOc0h5WG9FYmZEajRlZW1hTTZ4OVNzM2t0NEE3OGNXVkFCMUppU0QydEFM?=
 =?utf-8?B?aVBLaWxHbUxVT1A0K1ZOU050aHdjdGk3OFVCUlBlcGk0L2w4WTQwb2pUY2Nu?=
 =?utf-8?B?MGpNRkx0WDk3amNVL0JhZWVDSUdLWmlCY0ZKQWlheGRGQ09McEptcGVMUnBN?=
 =?utf-8?B?K3BkZ3BjWWxDM3VvY1h3aFNnNWdNYmEyTzErUEtES3ZOYjZ5RXJiaDNLRkpY?=
 =?utf-8?B?QmxaSndYYmFyRm02R1hPL2lrOWlyUlRWbXIzczFvZW4xR281QU0vekg1eTlh?=
 =?utf-8?B?cjIrb09TZktOVTNlY3lUWXExTENLWVl3YXZnUDZVOVlvSDRHUlpJZG9lRFJp?=
 =?utf-8?B?Vnc4MDR2NnVjckQzUzZyTTNQVlZZQ2JtenRkZzdJaGFrMnNKTG85V05kYmgw?=
 =?utf-8?B?bzVQS2NPdGZyclBMUVMzWmd1azlpRFRDZUxMSXRoK0c1QU1URklTaDJYWW5S?=
 =?utf-8?B?YzVZZ2pWK2tzTkFWVTc1cVJac3Z1Q0w3elUvNUNlaGxibVdTcnQ2Q0hhQXRl?=
 =?utf-8?B?Y0VTajhDbWdjR05XWXBUVlB3dHB0Vk8vRW1odlVrcWp1MVNaNThqallsTnRV?=
 =?utf-8?B?VnNLK2huRGcwSm42aUcrNHBmVXFjbmFxdGVhZ1FGdWRTa25OM3lnL25BMkhC?=
 =?utf-8?B?Q2FmSGVzNUxPSmdCakVXdFdhOVI4WEYwVmxnTERUcGF1d092UUtickIrODlU?=
 =?utf-8?B?RGxhUUxybkRiMVQxQ1FnR21vZ1g1blRWQW9wMWVEbjZ3bWtvVm1ma2FSMWVV?=
 =?utf-8?B?bTlNb1pLNlRXNEQwVzJOMzIySHQxUnladGxiSEFRMVN0aVdsNXliaUllWHBm?=
 =?utf-8?B?LzI2UCszQ2FiTFBhNjEyL1dNaFBuVHpLeng5MTMveGx2MUk4SmNFOGVhM0dB?=
 =?utf-8?B?VDB6STdKZ1VvOWpnMkhhd2ttdHo2U2ZSZUM1WHZqRElzWDA4S2wwLzJEazhi?=
 =?utf-8?B?REVlOC9iQnhsZGJIL0dLbG9LZlBMdlA1eU0vZld3eEdKWXdMZURSaVo1c3Y0?=
 =?utf-8?B?cDNvZlh6NGtLUmkyYWk5SUl2aVAvS2pRZ3pCNlU4R3ppM0VQcWdCWEdtLzZH?=
 =?utf-8?B?alZGaWRsRW1JUEgxV2pad2JZV1N6eUU3M3BWeURDVlp2QzRiamxjb3lQQVRj?=
 =?utf-8?B?bEtKL2FjU0grSGpqVEUzSHl6dnMrbHgzb0o1VFVpRXVwZUIrcFUybWpoUkZW?=
 =?utf-8?B?VE4vRE5ISktocnVJR1RMV0lta3FNY0kySTIzYTkrbDZGbEJtMlBRZittazdM?=
 =?utf-8?B?TlZXUWFaRzBadFpLeVJld0NFZXh3UVQ3YUFid0E0OUVKd3B3VkJhL1c0YWhh?=
 =?utf-8?B?Z21qY2FBSk51bUIyV1VyMGVvaUZzTEoxWktvMWNXU3RXckFxdTZjanFrL2dJ?=
 =?utf-8?B?eEkrUlZLL0QwdThMUnVVV2FGSkRtZ3ZNNk4rakl4Qlh1dzJHRWZRTE9FcVZJ?=
 =?utf-8?B?VzQrR1hQYWV5bmo3Z0ZlYzZEeXdKcW90MEVlUFZRQ0hzVEZlVHVjMGdleGZs?=
 =?utf-8?B?djQrcGVUMVVJYmdOZGRxWTJjUXgzeTRma2hmZWxlQ0hjbWxOZVBDYjl0TVcr?=
 =?utf-8?B?Z0ZvbmMwUDFFbWtMS2ZvZklFZkh4bHd5eTZsR3FtN2dsYmNWUnVCL1FMTEZV?=
 =?utf-8?B?VG9VODlwRkF6SnptdE42OVB2cmFvMEdrNUtDTStIM1B3cm1sWXlhZkdkazhR?=
 =?utf-8?B?WlpYelFoQzZnSEd4ZlBIcVE3bzBYUTNBeUhxNmJ5S3lYMEplNkdHVGVjNFZj?=
 =?utf-8?B?M2lFcnoyRFFKbEEzWmlVN1BweEpIZlFiNVJKYmhHY3VLOVppRzhua1BFcHJr?=
 =?utf-8?B?a01yTWE3TDR3VzZHTUNiMTI4aFgzcXo5cEV1N2hOdkN1dFpQblJUN2lsdW5p?=
 =?utf-8?Q?Vqq+d4BYpfUXS3KIZz2BeehCz3gT02MO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTFuWWIrZ1VRcXRlNS9nc1pJRU56WVpLWkNPK1Jza04wR2dMdmVTUysxTTFG?=
 =?utf-8?B?OC9BMjhjbXlHa05yd0JYWUM1b0xKbHVaVy9IbUl3VEtSV2M3d2RmTjhla3Fv?=
 =?utf-8?B?dk5MN2ZRK3NOY2IxZ0lFV1MrRlE1VnQ1K3lZZWlrSmFrSTRDR1pPMjZCTEpV?=
 =?utf-8?B?cHdEQXZ0TG5YQUxGTzF4RERIQTBrSE04bGpFbFU3Z3BFQ0d5eEY3b3BsWlRK?=
 =?utf-8?B?K1d2QUNWTm5iZ2xaUE10ekhmQzQwZndDYlFyZVVXM1g2ejN1cC9FcG5NclBj?=
 =?utf-8?B?Z3FyaXNxL2cvTjM4anhEc2F0aFB4QnFHU29EU2VsTjh1ZDBRNUVNa3I5My9q?=
 =?utf-8?B?eElVbnVFWldmVnNYd3RVY2VROW5QYVJQWFA1OEMvVkliNWViN2x2VW9ZNjlZ?=
 =?utf-8?B?ZW1OblFPUzVDanY2VElVdlc5cjZwSStaMEJJbkN5aStQL0c5OXUwL1lWNXla?=
 =?utf-8?B?bFpXL2l5ZFpCM0U0OEhpUVFaYXRTeGxUeitza3Rrb2VrMlBsL25ObWZyRmVh?=
 =?utf-8?B?MnljRVdHY0VMZFkrY0lHVk96K1VtT2lLWmppaFdZQzBZaVFTY2FhcW9ZdlRP?=
 =?utf-8?B?L1lrVGFRb1cvei96TUN3UEZYeWtzLyt4MStZVnlCQys4aUhDV1lWdTdwMjRT?=
 =?utf-8?B?WUhpVXRMVlF6RUxsU2NHVUlucDZTMzhJeGliVjRkUzdiZVF1L0hjWStSN2Z0?=
 =?utf-8?B?M2hxUEVEQ0YwNXNWcS93WFF6OVRRUXBLaHVBb0V4RHJoMHA5ellIZUwzVU5Z?=
 =?utf-8?B?c1ZTZ1kyeFdUd29wRXN4bktSZDgzNjkxVHdtZyszQ1IxTG9scXlQVGUvRkNG?=
 =?utf-8?B?WWt6QUp4UVNJYWtNVm1OVHA3QkFMODZMVk5JSFpYaFArNzBFdFpDNytSYmlV?=
 =?utf-8?B?L08wNXpkYnVjejNzQU1mTmMzaXNQc2FZbUxta3NQNWNTbU9wYjZaVS9OaFJh?=
 =?utf-8?B?LzFJRTFZR201K0xBK3BWZGNTcmd3dENZNmNHY3RHb0N1NzhMNmVEdUlFMmM1?=
 =?utf-8?B?VjR5cnNwbDlJVDFzRDFXbXcvbDhuV0FydWp0Q1V1a0k3eWdoZGRFajNnenM3?=
 =?utf-8?B?cmVoSDB6ZkVpZE0vM3hlRDZBMXpMNFU4NzNEbzVDSExUT2NZQXF4cmhmZTNn?=
 =?utf-8?B?bk9rNUQzbmZ1akZVSm9DZFdtakV1RFB1M3ZLbVlFMncvbjhjajNVUldBZzRR?=
 =?utf-8?B?cjZOMHNQMWs0WWpGRWtTb0Nid01NeGEza0FaNmNibTdEbHoxUTB1TDdyNXFk?=
 =?utf-8?B?Uld4ZDhmMFNKY3N4Zzlha0JycHg2VVVOc2hyendqNUFSZDhwYmh6OXRTME4r?=
 =?utf-8?B?cWt5Tk5RVFVRZFIzSGRpU1pYM3dBcDFQVXRVenZ6N1N1b0tUdnEzR01XM254?=
 =?utf-8?B?ckNSYi9DcW1uVFlzTFBHcGhBakM3dzVJM0lBZnl1Y0RENDBGdHJzdTFVYlB4?=
 =?utf-8?B?dU5nUnFWUDV1clhhN2Y0d0wvdkJvb0laWmFsMWRlNHhHaGVwQ2V2Q2xCaHFx?=
 =?utf-8?B?VFp4TWdqc3F0c0FQMm1uNThOSXUxaE9Nd055bU5TZUhJUm1aanJzeFZDZE9W?=
 =?utf-8?B?VFJ2M3BtOEhhNEY1RzNhd3NBYlE2cHRocDVzTUtEZG9LUGJLREhMUng0bGxv?=
 =?utf-8?B?V1RvcHlCaFo5bnlWNjlHTzJrSHFlUUxzR1VXalAvYkQwRzFzZEFHc05SZUZh?=
 =?utf-8?B?L1RaZjZXN1htOVM5WitPSW9namMxK3ZHNE1zdWhwekpBbHFlVERKOUVqL2Q5?=
 =?utf-8?B?MGRBbEp1OUgyVEo1ZU9Uemc2WmlxaVIxVnJDaFFscmFoQ3hyOTIzSlc2OWxj?=
 =?utf-8?B?Z0w1N3BOclJaTFRWWjIwSStOdFdMMnlyMk1uL2lJdGZ1TFZoVFJsWDBtTzY5?=
 =?utf-8?B?d1JNUG1XVXY4ZW1waGZRb2JUTEUvalg5b0UzOVNnWEJFSmNIb0tkTUt4UStw?=
 =?utf-8?B?ditSenAxeWZoU2hUVk5ibkdyOWZ3ZDBBQmFLWEpHa1A5eU1XSzlHQXlzbEtl?=
 =?utf-8?B?T1RIWVdvTGFBWGtUNzRnN3JoZlJ5a2lzQ0VYcyszcXBrY0FJRzN5QlJmQTNn?=
 =?utf-8?B?SkxxOCtUMmVFV1o4c0wvQXpUTjE3d3NCMEs3Rk1pcis4YkEwTWJtcE1zTDhz?=
 =?utf-8?Q?dO2HjThKDe4Ua+Y3xUynN6/hA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd17bd2-47f8-4b41-5f7d-08de3162b085
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 05:21:47.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnVbhD5i9WNejSpb562PM7DR1H3qfAWcF+uRfpnACXaGtxh7rI/QHbAQatM2bIQLI2CerX4XfywnkKQ6+588IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691

Jason,


On 11/26/2025 8:50 PM, Jason Gunthorpe wrote:
> On Wed, Nov 26, 2025 at 01:51:27PM +0530, Vasant Hegde wrote:
>> It looks like on non-SNP system in kdump path, if it fails to reserve old DTE
>> table, it tries to allocate new one! Looking into code again, it may be OK to
>> fail in that path as well.. so that we will have common flow.
> 
> If it allocates a new (empty) one and does a full flush of the iommu
> that would be OK?

I did look into the init sequence. We have kdump check everywhere which will
create issues. We will try to cleanup that path along with your suggestion to
remove flush from ste_dte_entry() code path. I will have separate series for that.


-Vasant

