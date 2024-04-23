Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889357870
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867042; cv=fail; b=VoFz8Rx9iakIgeptkwRKeUmfOm4d+ync17ADZgLXbr2BM3Le2DLIzIK7eVuxLyg43zUoeRyxLGMuWvKY2zVFD9DZIRabkyRWlGnShMF+eYA4gvikvV8mMBElIol+RI8AbNLu6lCRy4fYbbecJw7L2SKfdoJTCnigd51+Si+5TG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867042; c=relaxed/simple;
	bh=84gap4LWpwsEXCdRIenxN/QGGC2rXHyaB/M1gVRbCJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E8RkwaKoYyNKs9hs6C4rdwQNxf5o/PUvFLVf3LjJINVfSuQkB/P6BdMNBUX6zRYQSnpFjQickvvyW3DT/QCwjYn2S47EUff40CR/sSeqqV8QxKzXpGfrMQi+iyLZB444v02UJlX1h/wGWQ4T2rDdA5oWGPKsRHmD02RGZm38/FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EWRTcTL3; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EWRTcTL3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMXOYsx/RjADv5AWo1BajrukRsaxQcDdBqZmX2YG09Ekz64MEnX/47Gfy6uNaVU17u0cOgMcaKXKuHIh1Um6JNkcRk+v69qt3JkbI+LfbgU+Lpwsa2/fAcMiNfxTCcNWkmnjd9CirSt0514mJfHSK8dGcbxtL4I4khnB8OybpFxWl0kdSlnLSZVHVN98vKcxCpWgVmuS0qZLK3F/outkRYoTheTFpInJYG1JjIuzbSZO7peXKwlpgk75b/CLjhEvtDhr6IScFmg/2Cm0LUg3BWP1QZGQlvAxSGaYwp1QxIzzEDOfMc6GW1p55iSk4DKogSZiUFLT7AqfnSlsWj8a9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwHHIc1tFW5YeMuD85HHGM0ptdKNucQiUT0qjJ5aqJw=;
 b=Yw1prfFmUlq/bOYz/feQuz/WPLPu1gSn2llaSmkCv5WSsnnRFJdThTFNvVpEx9bErc99ikUFI4Tx+EFGOFPbIx4A48wMYyql9JV8FounZTUmztxZkJglC+hSYT1rz1iLZ9rK2N67VeTfIaz9vXhzi341YqEmxW1axFbJM/fcKdQVjD/tz7ZYdYCLrjDYmU5FGpC4YrDM0MNSiuTI82Cz2LDKWPBTliLseXI0nUF3uivHfCAEQQrWPn9MmggPAPwjzJksbIlB4n4YzvSEERUngdn+Am1F6Ei8sFRereOyYnGssN5g1umZXFWcNNgi2GpbEExHPsLgT7Y5QkrRaTmvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwHHIc1tFW5YeMuD85HHGM0ptdKNucQiUT0qjJ5aqJw=;
 b=EWRTcTL3Qi+SSe90+xTsbMQAAGovN1ZvADWwV9zu4Yu10Gf81wQRsXtvctRUtp4jtTl4ldlI9etuEeJEjgMWX0++46ao+sb9wFN5xKv+tNOhVEGRKtsZgfp9QpcMUtjgssFdRH00bMqETqbo0yLpml4cV1m0Yjlqb+FBp5+h4pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 10:10:38 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 10:10:38 +0000
Message-ID: <1201994e-55a6-42f6-bdb4-773d25f8d50d@amd.com>
Date: Tue, 23 Apr 2024 15:40:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Enhance def_domain_type to handle untrusted
 device
To: Baolu Lu <baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, alexander.deucher@amd.com,
 Eric Wagner <ewagner12@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, stable@kernel.org
References: <20240419114715.6028-1-vasant.hegde@amd.com>
 <3ef9b4c9-9b56-4c19-8f09-97f984d1d560@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <3ef9b4c9-9b56-4c19-8f09-97f984d1d560@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2f8e78-974e-412a-99ad-08dc637d9fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGVCek5rV3d0dXhPMmxpelY0K1ZmaTcxcWQwQ1A1QzJjNnFueDU1ZnFFT0l0?=
 =?utf-8?B?S3JoNjlXWmJmUUN1b0YzdWpRakhqSHNhUURVd1NFbGtnRXNJaEo0QUd0ckxn?=
 =?utf-8?B?U3lUMWF0SUhEUGRTNW10eHRzbHZVVkl2RWltN2s3K3B4a2pMZ01aSVRmVnRL?=
 =?utf-8?B?TEN4ZTBDenJHL1BhVmgrL0pJeHZYRS9nQ3A0b1Vkbko0RmkwMDMxN0ozd2px?=
 =?utf-8?B?NytxekxONGVtTmVGVHl6L3ZyRzlBalU3VExyc2R0eStnY3Y1VWdubEtObWlD?=
 =?utf-8?B?cUpCdGRFNXhKazdzWVl4M3BRZGlBdk5Ob0xBZS9qM3FWQkFRSC9Bck5VLzRT?=
 =?utf-8?B?eEU4YzRYTUY5RmR2VmxLSTJwczBFbzZCS0VkM1VkTHhpOVJYelFMaFhCbmFX?=
 =?utf-8?B?am9WRk5lOUFOSEZxaDEvQnV6TjBnb0E1WXljOXJMOEMwWGRjV2VlUzBkRkI4?=
 =?utf-8?B?OW9WSG5HSXoyVG9EWEZvOHpNTkQvK1ZmcmZsdDFTVkZiUjhETEdrT0l4K2VH?=
 =?utf-8?B?OWNDdHNRcTV6SWRPZUh3MVdld2pOMmp2cWhIckxYQlVEdWMzcFVWQ1JBQUMr?=
 =?utf-8?B?NmdrMno3NmhnTXc5UVF2US93ZGVSR2ZUZEFSMzBrMVZjd0JHR1JRckdjZnA0?=
 =?utf-8?B?Y2VDcTZUTlIwQVVMdXhnSlFPdzJsbkY5bXBJVUsyelQwVEFHSHJBV3dNdzZE?=
 =?utf-8?B?WmZtVEoxVkZNWjlycEZWK2FlMUdaalF0Y2gveE1SQXc1eHJrTVE0b2YwS001?=
 =?utf-8?B?NkFPRWJJV0Y1WGt2Nm5wNkFXTThCMGJSLy9oZi9rWUY0ZkgxTjE0TC9WOHhX?=
 =?utf-8?B?NEZuVnlFdC9NMDNvRCt5dXU3azU5SkcrQVg2NWlJdnNRc2RQL1MyRzhweVZ4?=
 =?utf-8?B?NUM3OHpUb0l6Y0VwUmZaS09qaUpLVTdQVlBsQng2T3Q5aWJDaFRrRUQwQ2pB?=
 =?utf-8?B?RlRwMVYyQnpUb2hmT0RIa3hJaFJ5M2FFT20zc3lrdVZ2UkpHUGgyR2JBUHNB?=
 =?utf-8?B?UCtzN1dqL3lGbEljb1F6QlQyaXFTTnBrVnFHYUtMZkpibzZ3RTl5M04wWll2?=
 =?utf-8?B?cVhzTUV3K2pBOVgveGRaZkdlMHIyU1VSMHJxeHBNT1Zhd2NxTjNvblpQTjdz?=
 =?utf-8?B?M2Q5ZUJEZjJwZnNkWjFVYU5JUDZiRys4U0tkMXZmMkRTTnBKSjBpcXp6Q2F0?=
 =?utf-8?B?SmpIVFQxc2ozVWhhS2E0S2ErTWswTk1uZEdxSHlRNzcwSDh6ckpyTkFmL1pW?=
 =?utf-8?B?WHRhT3Qwa3RxYXI1cnhVNWQ4NnozMkVOQTIzOUtZMzBWUVEwUUJsOGt2OC9t?=
 =?utf-8?B?R3dNdzRTOG5tU1hqNmFqZ1RqS3F4b1N4YVZnbW5XZzh5YVRvRm9ncHkvMXdQ?=
 =?utf-8?B?VkZqYlJtVzVwTExmRlMxSjVkc3RJT2VBd1J5aThFZnd4Q2x3N1JpOFA4TWY5?=
 =?utf-8?B?bklwSzBhazJTN2NZQW9TSS82K3JSa2Vhekx3UENqc0I4SjNsNHEyQXdCeWxt?=
 =?utf-8?B?LzlNSFVFM3BDOS9LeWR5by82UUFtN1haVUVMQ0o4RkkzNHZQM1B3Ym40ejJP?=
 =?utf-8?B?a1U4eVdQU2I3dUIyVFhWVHJtMlc3bWFNQ2kyZjM2aTA4cENPU2hJcXJXYVNu?=
 =?utf-8?B?ZHR6Z0ovM2xEUU9CSGlIcjRBU1JMQWZmN2FwWit2ZnNRRFBUZER5UVA0OXl2?=
 =?utf-8?B?c0hBenlGS0Y0TDVkaWRvdktPOWlxUHk3dHlrbFROMGVQYmtlckVlakVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2dSMlk1cDNTMXlyZmwxRW41R05EV1VndW1sSFJpZnI3YktUaENyZit5N1Zu?=
 =?utf-8?B?STBkOW9GRUtHcUhtcUJtV210Z1dBRGxCcWp2aGdiYzRhd0o5Tnpsa2hsbjFl?=
 =?utf-8?B?a29hK2dCRWh0L0JMOXBYRzliOUtQSDdldDliMmR2NlFTUE16eEhmUS96cEpR?=
 =?utf-8?B?MktNaEVLUWxtKzYyK2VFUTZMMTdxaVUvTmJqdlB4b093Vm9YQ056MDB4RXRP?=
 =?utf-8?B?Uzd2NlZyaldVZ2hnL0diSWZLcnZBOS81dkxwZm9VK0VwRHdNMHBYczRGSHVn?=
 =?utf-8?B?dnljVElxOGhlUThtdHFNL204Z3BrNWJEdTJhVHZFSm9jZElBaGVwazNKL1gy?=
 =?utf-8?B?eWdFVWhJWXJjZzFsTy9MNk8zYS9pQ3hXSzlzS3pUcWlSandiNmdvNlNWNExi?=
 =?utf-8?B?Z2FlN1hVYjZUWlF1dmU2SGhsb3g3TG95VmNFRVVXNkZRVXNFQkloWVp6OU9U?=
 =?utf-8?B?dTZzUzRWYThqTWlhYjU5TEtjNTIrRDdON01WRHFQZkU5YXYxRkZKcGlONUY3?=
 =?utf-8?B?V1R1bDJHUUhYSEJaWFVodVY3dlgzWEZKNzFhSVBPd1cva3F5VytpcnN2Tnd5?=
 =?utf-8?B?VzYrRlB2WXVJVEVrVFcxTUQ1R1NVTThOVWV4TkJGMk4rOGkxRlNtVk91aFpt?=
 =?utf-8?B?ZjRzMTZET2VQdVFnWS8ybTRLZ0UvYitEaHovSm1pYmI5Q3grbEljbEttTDBF?=
 =?utf-8?B?RnRtTzJBNGhuNkQrZDZNUGU0K3NMa1N4aXQ4c2ZlRmlRaXdsSEdwcGErYWlC?=
 =?utf-8?B?Mm9SdjBTeDRFRklZNXY5bVRIalcwUTdrRlY5cGdzV3JPOWZUMU9FTVkxdXZ3?=
 =?utf-8?B?RmdpZ3lIb3lLSnNtc3NZR1JEdVFsYUYzMWhhYWNFa2I0dHoxUkN4UnVERjRh?=
 =?utf-8?B?UkJjSkh1enlEb1NlK1A5c2VqRVAvVmIwNkJCU0VGYkFld3l6RTJEUUZGeXI3?=
 =?utf-8?B?ZWljOEVhbWZSSiswdVhoZUR2NlF5dktWbEFxakNMZzZrNnNjMDJ6WmJYWVgw?=
 =?utf-8?B?eXd5MTBaTkdiTnlBRCtHY3NsN2ZSS2g0SXc1ckNrNjJZeldqaGQ4UXVGeCs3?=
 =?utf-8?B?M0E3S0M1SUxYNXhobXM3Y2JmR1lUc2krcFROVTZpQWQrNC9SK2lqOEtwaDJr?=
 =?utf-8?B?ck9ZT3ZBRzRzaVpQS2tXdWhlcGcrMUxoUk1EaFJJY3FPRUNYbTRkeXJrS21u?=
 =?utf-8?B?aVBZK2o3RDlRaGMrckdwM29aOHRudStmTjdMQWFQWjdOTGxPaGNCWDA0Y3ZQ?=
 =?utf-8?B?TUxkY1h0T3kwNFFjRW9lRDJBeW5CU0VSMVlHQVE0RldpSCs2VktYaUdtNUlB?=
 =?utf-8?B?NVRsL2ZQR21TVnRvdUFjZElvSmtIVEJWM3I2ZlloQ3dBOFB2c0Zsa0VqaHE5?=
 =?utf-8?B?SUx1VGtQTFRPSGFCZ3J0UENUL3k4elRHbDNzNGdVQUF4YVFhWEIvUEVEYjE0?=
 =?utf-8?B?SDVST3JyRktZNjNlZkF5NE5sMGpNbFI5cjFDdTZNWkV3VSs4U3l2eit2SmNZ?=
 =?utf-8?B?a0xvcWhtelpiQWhydzV1R00vNlNvd09pQTRYaEorcW1wYTBoTmM5OFlKUk9E?=
 =?utf-8?B?b0J6SW1MWTI2MHBZM0hZTWJyZVgzNWdVL2dmc0o0VTI5R0dVd3pyeGMxeEVw?=
 =?utf-8?B?SHQyZWRLNy9ibWxNMFgrSzZadzFqWC9lQzhXVXoyUm53b2x3cDhPV2kxdWFa?=
 =?utf-8?B?ZVZydEJScE1DUnY2Yjg1ejdyRUJrNEZzOUhwSTNXOFBLbkJ5M090a1FjQUxO?=
 =?utf-8?B?SW1wTEtqYVRhZjh3a0JXTFBZbThraG5sSk1sSVMxdEFjWjA2cUdFV0FJcUY3?=
 =?utf-8?B?QkhqdGZnRG5jbEhvMjFlV3J2MXRvT1FsVzhMU2JyL1VFTTlYTzZkRWYrVGd1?=
 =?utf-8?B?bm5DSnVHYkhQc1F3U0FERi8vMFRjck8yempHeU9FY2R4WEhjTm1HQ2RCUFhp?=
 =?utf-8?B?QVFhek1od04vVGZCeFRSYmplUnJ5WkJKdS9NeURxaWNrNHZndFU3YjdyejJk?=
 =?utf-8?B?dCtrMEd3YUVaUHRUNjU3NW5Qb0hGUlpSbHF6RkpES0NvRExub0QxSnI5cEVL?=
 =?utf-8?B?UlpQRmZrbjcrMEwrZzA1MmdpV3F2NlZHQllGMHduRjBacGswenNrTWE3Z0ZR?=
 =?utf-8?Q?YC3KXV64IiA1su31v24G/qdCX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2f8e78-974e-412a-99ad-08dc637d9fcd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 10:10:38.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwuQTNMLFOGeiRSTFAz0gRzId/IVGgGS8L7hfFfP8P22qpjjA2t+o19KSKeczR6ndE02LbzCAPoT1hQQmKO7TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136

Hi,


On 4/21/2024 7:15 AM, Baolu Lu wrote:
> On 2024/4/19 19:47, Vasant Hegde wrote:
>> Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain for
>> untrusted device. This always took precedence over driver's
>> def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
>> iommu_get_default_domain_type() to respect def_domain_type()") changed
>> the behaviour. Current code calls def_domain_type() but if it doesn't
>> return IOMMU_DOMAIN_DMA for untrusted device it throws error. This
>> results in IOMMU group (and potentially IOMMU itself) in undetermined
>> sstate.
>>
>> This patch adds untrusted check in AMD IOMMU driver code. So that it
>> lets eGPUs behind Thunderbolt work again.
>>
>> Fine tuning amd_iommu_def_domain_type() will be done later.
>>
>> Reported-by: Eric Wagner<ewagner12@gmail.com>
>> Link:https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
>> Fixes: 59ddce4418da ("iommu: Reorganize iommu_get_default_domain_type() to
>> respect def_domain_type()")
>> Cc: Robin Murphy<robin.murphy@arm.com>
>> Cc: Jason Gunthorpe<jgg@ziepe.ca>
>> Cc:stable@kernel.org  # v6.7+
>> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
>> ---
>> @Eric,
>>    Can you please test this patch?
>>
>> -Vasant
>>
>>   drivers/iommu/amd/iommu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index e692217fcb28..e405714640b0 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2754,6 +2754,10 @@ static int amd_iommu_def_domain_type(struct device *dev)
>>       if (!dev_data)
>>           return 0;
>>   +    /* Always use DMA domain for untrusted device */
>> +    if (to_pci_dev(dev)->untrusted)
>> +        return IOMMU_DOMAIN_DMA;
> 
> Are you sure that dev always represents a pci device? If not, perhaps
> here it needs a dev_is_pci() check?

You are right. I need to add check to verify whether its PCI device or not.


-Vasant
