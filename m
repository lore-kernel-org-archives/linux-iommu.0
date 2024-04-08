Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2107.outbound.protection.outlook.com [40.107.94.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9817745
	for <iommu@lists.linux.dev>; Mon,  8 Apr 2024 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712553059; cv=fail; b=Sbcx/GgkHswu8wZTnMlHZDS6itYogjqGz9hIblOAvqQpbcHTkDNRI5sTn0LqW4B0n4oOoEQTgEqVCcC9ZsxQxElQ17RTkRgdjUMoxsmYv5/4KUTdZcU5AN9TdMh1/I1uT9fY3eTARnUv/I8xFpB77CTvfGo718roR40wk/CiPHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712553059; c=relaxed/simple;
	bh=7uBeoo9J3rzHd7iUKAc1xMGkowq+0zdQDSIRUPvEjJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dtu3HEZuINgmvF5XV4TDY1dyHjYRx4oPI5UIk1Lj7hoCVLz0rdojza2YAoZRRWjA0WY/DD20KDuLEvaJiHUuijLMzltivSh4ui3kmzOL2QEiQRBAYj5gAuNTFBCZZ7kD7OU/QYf6YO88wjD0tBJYaSxX2nyVvbNrUgqqauzDkxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QCHwNJm0; arc=fail smtp.client-ip=40.107.94.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QCHwNJm0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTz5GWzQnpA7PneQGraitvfsy9fwc/wFKZmNgZREm1LtGRIN629RjtFPKDBt02bZmgPSK2zc6TumNNWfSyR1xK9Io0RhO89HLUYbydaoJ+HxYNEnDXSIvhZKWGfcPGUjtDUU89wFFRwHaDLYhqhwJd4OQ1o9Yk/sw92XOpr4jjcAy4tdChT9FMiRaiotEK6Nybl5zcnpyV86r3sf1ik5dRYwmVjHvQ0ty1jFucuNcI7GwozKqQX4F64jSPDRRHzmCEwAK28c8ljfuIbHiPxuQvgvet95t+AA7zyG4upwrClUZGS8m8gKdWFV/Gu1EFQ9DSHV6Pw5VN9OD0p2d1TV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN37b2eS6XPhovp3bKWM8HHEbW0tB6bb4VW0A3YZKRE=;
 b=FFZYScWPXMZ+zmVSYqG15dLpbzhiJlve66oXJosMHD/bJZOHDFRoA/qAC7tjb0BGvFRSoiOBe/jXe2+uHysYITWQ1LSw2+j3dZYegN5WxdyZVCk7mtvwkfF63M209HfIUjy6xC0r/Q2tBdkN7XLVeB9MlD21M5ktm+BDn/akP+hJ11vcMw3DNWN61FlOpFLnTKcf98lS2sib92fTPzSVesSbamuztPxXWRmkm3n+FPA8sRzmHmbCWDBntR6DnxWF+uo1JNAXn5J/ZJUE6K7bw7Z2y9Qee/6Ely6xjesyBTWlr2q9KtVVffeiP/om0USjdKnauIT7PNZltyH7O24mYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN37b2eS6XPhovp3bKWM8HHEbW0tB6bb4VW0A3YZKRE=;
 b=QCHwNJm0K1vyHKF8IHOyhAeWXp7zwH1H5NLrwpZ/72bvrpEtVHtIen+FzGDQ9Sji72SBYFCzqFsPMQXzqzDceaxIgR8uwfAr40uzITKxWJpKUAm4WjNpqUNIXkWqS8kBeiBFyjYrPFhuaTtc+/ruIzRS2IX533IQVIMnPKLzrGc=
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 8 Apr 2024 05:10:55 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 05:10:55 +0000
Message-ID: <2b2da6fe-9edb-4f7a-b917-6f9cfda6ec56@amd.com>
Date: Mon, 8 Apr 2024 10:40:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc] iommu/amd: Do not enable SNP when V2 page table is
 enabled
To: Tom Lendacky <thomas.lendacky@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>
References: <20240404103729.6752-1-vasant.hegde@amd.com>
 <5187cf7a-7263-7635-90ad-b298e14b8ce1@amd.com>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <5187cf7a-7263-7635-90ad-b298e14b8ce1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6345:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cpo6OCu/dTtE+H40oUQHYOvgZ32xD4I3m6Nc2HV+MUFv9xfwkpk7382Cgy3aRgaiHZGoGfkknLkYwHkFXgUgkPGcJ3D4u4XCJzK3ri1Z55QNF95xMfVKuWTbqafE3DCKnvF087HgtgOESzkVAhFVhErMhENhsWW0rpKq/vuEBcDqjhTILqfSpmNCZvl5heU0HqjHU60DjzpdDvpx5tXJ7ESW5r5vpuneRLYmwOkzxXvg3RYqCX+l0mkVfkOMwtg40OcQehxzMx1zwF6UMZz40ikZP8ksybwvAGv3ZEnoNOrMP388RnxCG0EYL0MUpMOmNpwVgvNwRPXelqC8vJ4u59MA1F3VuSgcl3bIbvhv4zVIsRpY7q8vIw9mXPbAT1AqxHbg2htvKcaJk5x5/B1k8IUDcQr2Uly9hbz8JM5HxKXDKZazK4nfhMM8piAnG6rwfdto59lX+nrsqIZXU1r92aLeq9wvD2c8XVSRskCG+4g2+mFrXqGSNG05vDprVQEWmx9BSQbpc0MmDDH0exQYBOHYNOykn51frdmg2c0C/wOFvf0SA8n5isjsSucEWPIP5AiaR7nAIGYaQdtjkeBiym+UEZ57w7OA+LUjnVgpFCG2MwPGEGhInptY7daThjik
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG45OFQ2dmliV2lUUGtNelFMNjV0V2Y0L1BWdnJLQXUvQ242UllUZ0dlWTJs?=
 =?utf-8?B?VDEyTGVzTGpDaEFjSjBSc3h5OFJrcmlKOXkxQWZJbmd1WGpycWRTMW9yMzht?=
 =?utf-8?B?ZkJ4Ky96M1BTN3ZHdmhIeXJydVRnRVByRHg0M1l5bDhIak0wTzdhcDhvNHVE?=
 =?utf-8?B?V1dWQzgvdnpwUno5RUU0NlhPUS95QW93MlVSeENJaElWdnBtRDcrcytnMURJ?=
 =?utf-8?B?bnVuQjFTNHd2MHR0VlVvOGkyaFZ3N1NYYVZpbGwyVnNPZHo5UTNIUVphaHZ5?=
 =?utf-8?B?Sm10UWJHTHN6UkF0dXpaNldNbWZBYndLTTE5WmRIOEVNSTNkUDJjdVpEajJB?=
 =?utf-8?B?WGE0ZTFTYWxwRm40RWlka21DZXhuMWREeGN6dmE1Tk1xT0ZHZzBmUVBaYytj?=
 =?utf-8?B?Z2Z5VkJ0cUdpaWEvMVg5am45TEhrTm9wOXk3WWxWdFJDWWtOM2h6anFkTk55?=
 =?utf-8?B?dm84bkp5alZoNHplazRwUkF0Ri9HbFhKaXVhSWhqeXVmVDlueXl5NTQ1ZlhZ?=
 =?utf-8?B?am5PdXA0OTRhaGtwN1RQbGVyWC9sdXFvSFJzcUZzcUVmOE42M2Y5c3NNRmtj?=
 =?utf-8?B?THFISXBqcnZwbkU1RmJFMDkxWDdkT2U2V0hOc2pBY3F0dEdYVnFjVEhPTkVy?=
 =?utf-8?B?YnZhUktQOWlMS21qRGFmczk5ckFya250Tld4SmwzdG1jR0J1ZThKUGQ4cFRl?=
 =?utf-8?B?K2ovcDdVYUFINHN4VGlmYUFqL21VYkVUbXNRdUwxRjlzcmcxRHcxWFV2SjVN?=
 =?utf-8?B?cUFOUVR6ZTdXZy8xNDNqdld4RklPU05JdmNrWitjNlVxczBUd3FsY1Q1c29E?=
 =?utf-8?B?VVBrZTlPWkZBOEVua1htbDlRSVpUb0w4L2gwV25MN1BmMjBVSXB4TVhvV3pO?=
 =?utf-8?B?TlFqUWkrSWZZTU40UGNSQkw3Vys3UDRuVTJiQ2VrTjFmcXRtUXFmVXdOSEIy?=
 =?utf-8?B?Q0JnTGQrR0RDeERKMEVCMXNGenJVNVNJR1Z0YzlIYVlBYlIwSnhOMTdLamJH?=
 =?utf-8?B?amo4SXU4VzkxZlk0dXZYSkxiaVp6RldKV2xEczdLM05lQ0dnK2dFRW9mZHNV?=
 =?utf-8?B?cDJZdzEvRXVYaDJBb1BNU2NGV2x1bC9kbmdjOTRoWHkyTGl6Zk51ZnNwV1Uv?=
 =?utf-8?B?cXlrUlFyTnZGQS8vaFUzamRRMmloS0RCQXpON0Q0dkRIdXdTV2N1YTVTS0lm?=
 =?utf-8?B?ZFBqdmZVWVh4OXI4aUsraitmNkFrMHV4RWJQWkI4RmpWSDVBbENCVVVmYVVa?=
 =?utf-8?B?QngxUG45QnFoZ2w4bXFRbUdURkoxSzNqeHBscWZXOWVvNlM3MVI4dnZoMUlB?=
 =?utf-8?B?TUJDTlFOd3dqRVJIcmdtNGNFNWpRMVhob2lBZWpSOFZQRVV0VU1WS3VScEFF?=
 =?utf-8?B?ZlBHUVdObTRQWUI1WFFhekhETG1GMXAyVm9PVldkdE5nbGloc08wNUMzQnVF?=
 =?utf-8?B?ai9ia2kwMHZCbVVnVHZlWmlnTmNDdVRMbGhuQktIYzBUMDVnS2hkUm5DdW12?=
 =?utf-8?B?WFErRW1qVjBDWklNYkt2dDRDTlN4OHFLVHNxcVFadHo0ZWQzMXdueDF6SEZz?=
 =?utf-8?B?QmxBazIzOWJoQ3p2SzF1RTFqNTJaT09CSWJ0dVJQeTdKNDJvOHJnNDZPL3lK?=
 =?utf-8?B?WjgrRldnZWVMVExPcjlVWVBTM1g0UEVXRGx3dGFoZ2xlMndmaGRPTDN4bUVD?=
 =?utf-8?B?MmxIYVNBNmxqb2ZiUTREVDh5OVlQNFphWCsxVG5vM3VyNmNSaWNiMk5wcjVp?=
 =?utf-8?B?d2dxV0VXWEhEcmZIUDBUR0psNEZhUHFzN3FrMzQxV3JWNm54ZnZWVGpwMExO?=
 =?utf-8?B?UkphWjBpeDZKODRIb3dQTHR0NXFma2RNRTJrVXEzZ3RKVTVPVWo5VC8wSHYx?=
 =?utf-8?B?ZmVCeG4yL01QV3l5TWl4bi93MGlrdlhtMFZ4MWtMaStVWHpNK0VyZjBsQWJK?=
 =?utf-8?B?V09UcjNwL1dkS0Y5Tmx4MGR5K3kxdzlzamNiK1JVVzk3RitXZDByNW5jeTBB?=
 =?utf-8?B?QWdZWlgzUmt6Wi9Qc2pQQzVJc2dleDRvNzZvRDZNei93cHltQ0xaUUl4azRy?=
 =?utf-8?B?TTRMejRKcENmbXRpYi92Y0hQSDRaVC81UmUrMXVnUC81MjEyTFpuY0kvcE4z?=
 =?utf-8?Q?iCAKmx/pePJjjAYkDVYDbC1xb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d498f55-0b17-432c-bffb-08dc578a44f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 05:10:55.7656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdSLiuTtP3OOx6FK8MZTwaDNtIqGPTPpFv3zbcm7CqQefXUHOXBL3zgtQ45yXTSIdbbfUy9xOPZ3mF8eWze4mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345

Tom,


On 4/4/2024 7:04 PM, Tom Lendacky wrote:
> On 4/4/24 05:37, Vasant Hegde wrote:
>> DTE[Mode]=0 is not supported when SNP is enabled in the host. That means
>> to support SNP, IOMMU must be configued with V1 page table (See IOMMU
>> spec [1] for the details). If user passes kernel command line to 
>> configure
>> IOMMU domains with v2 page table (amd_iommu=pgtbl_v2) then disable SNP.
>>
>> [1] 
>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
>>
>> Cc: Ashish Kalra <ashish.kalra@amd.com>
>> Cc: Michael Roth <michael.roth@amd.com>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> Just a heads up, but this will likely end up with a conflict after tip
> just merged changes around this area.
> 
> https://lore.kernel.org/lkml/171222187434.10875.5343618940901502172.tip-bot2@tip-bot2/


Ah right. I will rebase/resend this patch.

-Vasant

