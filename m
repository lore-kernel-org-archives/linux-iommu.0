Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB5E268FFD
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494471; cv=fail; b=TG5RAPMYwnxY12+TiBXGawj75dFEhBGEsLW9kB/e12bI3r07PnUx5Oi9TMPr/LfNJRXYBZbQxOCt92R38i8j3qJw/Qgehq+9ed870GlELEv30M6qpKD0QatFtIvsBtgkHa6cJ2mQfl86+OWP224Q73PZ8nB1BTG+IZYizx0+qCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494471; c=relaxed/simple;
	bh=873Bt5VLQE0249DT8dlSvRYDHyog/vhsdSLV8apTP98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B1mRwba80DcbEBBTyWHdoGZ0x3zq7tKo1zrmBwRZfSd0HJEhPtGOyzB7Nq17676PSp+DbOHg8QsvzZwP6U1V/T9ojniwNEZWDak75PUgT94YfgLb+J+O/5lh61Mxsl5XZnQg+MTkLGOC3ZUpzWGM+XKSG4WwCwrlWLaJXUQfN1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=od/Bc9Ly; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="od/Bc9Ly"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDKe8zPhB2RJ66IXBb28bURfy2FV4T+LEXGJBDVGsOQVEGlCIx2SExNo/307qPegF4C4KpJgP4H//F8XPv6Qhe4qB+XnmGgjCwCdlmYN/1OBAbSCS+3i4B89Jaa5ZpAKKnJSpxPvs+XwgFhZyJkKWffwXH/PD53qMVoVZxbUe3bebKwLBe36UWeYJGW8Kes2XumZ9UQbRxuFKyD3pGtV0WbX866ei8Ps6T6EcjRwRyefZJHdvKGQEKjZUHmsUUMOl2v0I5EKfslW6BXzTXP55z/B908Dh2NCTDA5YexENBDKW/mzT382a1Iteg+4w4fBR/Bl/LVbtXWcCW9PXY1v0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTVIpZpmUFxm1NyeAVHbt5FKs3sc9o7mYZpQgv8/08Q=;
 b=S9banCJA+9lBB+snGk8JFfMr9Nc1yrmo2sobhcSMHHE+adpuoFkZm4i9wjichFhxYbwRzzctdHo1Uaxzx6e2OoRzauP/B0I8V3kn+8YFEQAb9gnBfu7R0v7bBAhfuUc2sKR2ovMsF8rF+1+FjZkrs9Tc/3pSVLkJ6I3NvGZcQ1Wc9rhwTSwBGEnPurvGgSiH2hOayIUnM+Bt9xwrA/dC9dcWcQWYkyJ65XaZBLdg+LMEiTvZOHLTFrRb9+fBcFjJM8bz91loxrJKCkApzGRVMZFPIqKifvQbI+Q00rTXLiHiIFZnIOTVgbI3FHV70KFxEQnlAt9HwQBqM/o9Z8CZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTVIpZpmUFxm1NyeAVHbt5FKs3sc9o7mYZpQgv8/08Q=;
 b=od/Bc9LyiHC+e8hIMoAqpo6xqXfPTqctDFGh2RMdpZcowi6T8rVeG7sB3ljEm5IBS78GMRbRawasoXGxUYuwTfoYa3tPlZA6x7wjoivKd234VqGTzPv/XGl40hIcqr3lUKesEfXyUHJI6GcaWYqj0uC/S2xQu//eUDU+I7/FeYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 14:41:06 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 14:41:06 +0000
Message-ID: <8c3b0199-96f4-4f97-96d9-de2a961ac882@amd.com>
Date: Tue, 25 Feb 2025 20:10:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] iommu/amd: Make protection_domain as static
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20250225105345.52143-1-vasant.hegde@amd.com>
 <20250225105345.52143-8-vasant.hegde@amd.com>
 <20250225142921.GI545008@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250225142921.GI545008@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 080bf84e-2da1-4eab-e1ec-08dd55aa6f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTJEN3Bkb0drekMxQXcrUnppbTBWdjZubWtyb2E3ajZscGZqb1NkNnI3TmFR?=
 =?utf-8?B?bEFqKzFjM1NWOUJ2UnlXUmY4Vm5kcmVKRUljcFM1S1JoUXNGcUtWakNlVGkr?=
 =?utf-8?B?QXN1b2NSTzRwRkY1VHN2djlQMW5EL25TZDlkKzZBbmlzeDU4VlhsM0Nxa3BP?=
 =?utf-8?B?YmJnVVVSNmpBcUY4ZGRhVHJ5cTlZVGNaSS9kd25XQTNiMUdyaG51NU9LZnBE?=
 =?utf-8?B?SkExZGsxSysvSjV2VkNIQklKWFZObVlHZnRFby93SzVLMXY2bU9vVXJrZWVq?=
 =?utf-8?B?bUdxV3pmdGlaUHJweVNrbXY1eUNJRXFqVW1oV1Znam1TQlBQNUpiamYxcTM5?=
 =?utf-8?B?M3JMUWdPN0hiTlBqK3VrTkREc1FTRFNTSE41ZEU5bDdHcENqV1N5ZTk3blJs?=
 =?utf-8?B?VkhSem84QmRXdC81dEM4NWVQY3gzTWFHZ0w1RXlqQXhGb2xMa2ZHRzA0WTl6?=
 =?utf-8?B?UDhkdUQ0ZHFGUzkzT3RuTVk1UW4vVXBtOHU2MWdYV0JLRG5DVURCMGszV0Ji?=
 =?utf-8?B?dGg1OE9sMUVLNjEyL2hoS0o2b1pZbXFNV1dyQ28zcDJ2U0VyUzllN0JDaVZD?=
 =?utf-8?B?NGJvVVRmQjgyZEJZaWlCTU9iaDZTbEpUdW5TbnllUm4rK0RNdVRoaW9pVW5v?=
 =?utf-8?B?Y1pxbXNDZHRXTGEvM2k5c3d6aEdHaDZkc2pEYjRuN1lsZVlEOTdpWGxyVVJk?=
 =?utf-8?B?Lzc4eWUrWkdiR2Q3WU1kZWNrZ2dRamUzR2o1L0hxQWU3eDkwSmxyUmwwRTZv?=
 =?utf-8?B?UHdLbXkwYUQ4OWorcncveU01KzJ4QkZSU0l3aFJ5QkMxcW02dmRkUWNNWlV5?=
 =?utf-8?B?am9zRkpKcUtoTk1iMXNnUjNQK0NnTnM0eHBZdGQwNnlFRHdzdUJRbis2aFJB?=
 =?utf-8?B?K0dNZUVKR09mZ0RleHFTTlRjSi92VlEyN3FkRU9mZjljV3d6OUNITmZVSmly?=
 =?utf-8?B?Q2lsRjlNY0JkSEZ1U0M2QjBNVGMrZkI3c2ppdTJhTW1IN0J1ZmpiSjJIbWIw?=
 =?utf-8?B?Y0dDYzBhRkVBcWtZMG15SjBVWnI3ZkU0ajA4WTZEL0psUzBTSnAwV21mU0Nn?=
 =?utf-8?B?aE53aTd5d01yK05VRGNCOGl2dlV0cEJkcjI2eGx6aTVXZk9LQ0trOURWOVVh?=
 =?utf-8?B?cjl2dEw3MUZSd1FLKzBXZXUwS3d2Zzd6elRINDRsSy9mb2NyV0thN29pYnk3?=
 =?utf-8?B?UFM0dVRub0pYaVpmc0JMeEV5UUZpMzBhV09rNTlxUGs4UHJDZDM5dHhPSDJp?=
 =?utf-8?B?Y2Z1WWs2Zk1uY2xFRXMwUi96VFdCTWh4M3JEQlN2TXNROTBtZ2NuUGpOeVFM?=
 =?utf-8?B?blgxcmV5RENUdlMzTVZiRmFZNDlNblVWMklTdCtTditXZDFCYVpzTnk0Tjh3?=
 =?utf-8?B?Z1I3STdkNVdBdHZVUkQwUysxT2hHYUtoSEc3NTVQckdUVlYrMklPS2FPc25j?=
 =?utf-8?B?Qkt1VWEvMEtPcHZtQ2R3RGUwWUdXL2RnaWFXRjZzeHRPZ0p3NjJVd0twMTFl?=
 =?utf-8?B?cGdzUWZvYWhERy9GZk4zVysycjdaY3pSQUtBT2o0b3pqa0hSVmRlTE9XSU1t?=
 =?utf-8?B?eDN0SVNsb25OYjllSkZ6aFJub083bVc0UHVBTFk1Ui9XVUdHVDIzRnk5bEs4?=
 =?utf-8?B?aFlzUjhmb2s0MVlsOEZOdnRYN1dFYXB4MTBWb09pWDgwWDk3MGFLdVZnRVoz?=
 =?utf-8?B?c3NqT3pEYTI0aHlHREU5aHFCMzUwZHQ4ME9vLzhEdDREd0ltc040S3BGK2Ro?=
 =?utf-8?B?SWl5UmhvbnhrR2tvWFByNis4VWlXZFNFb2lacTdyR3JiUytPWlEzMmVGbzhh?=
 =?utf-8?B?QTNDTE9CWHlaWFVjQTd0WnVuNERleDM0Tyt0R3Q3bU04T1k3cVgwWTVaRnZz?=
 =?utf-8?Q?g8MxlkeelJ+Wq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmlQdWI0THZ6My9BWGthRm5zZHlZUmgyWVpwSFd3anFWcjRSVFZYMFV5c25M?=
 =?utf-8?B?TjEvUWEvVVlhZDEzUjJnZUF1SVhwVlZXWGU0QS9mUVd5YzhFcG5BelRLQUMr?=
 =?utf-8?B?RU03dzdWUnhNd3ovR2NUTlNpNzFZekNIczQ1b1Z1QnpSSTlDblA4SnhoeVgy?=
 =?utf-8?B?QkRPZkFaMWthSGlEK1I5Q2JJWVRmTkFNOExHajlmSEI2YkQxcXl2KzRXcnVx?=
 =?utf-8?B?MGdXSFpuVThhbCs3NGpobitVdFhWRDdQUmNETlFhZ0dJL1BFekxxNEVnYmFQ?=
 =?utf-8?B?QkJPa0RobGdzUnoybVZUaUhCSXBsV1ZXU0JPSFB3MXpZZXpSdVNJT2dYMUR1?=
 =?utf-8?B?R0ozQUhNRGxwdUZoa3FCTXdYQk9GUzhwblhJM01MOEZVZTliY0gxVTZkZ2Ns?=
 =?utf-8?B?R2ptd2dxZG9kWGRINEx0SSs4UXUxQkw3N0RjaEtrSmZpOGZVU21MUitqTVZG?=
 =?utf-8?B?cWQwUE43elJvSFFsWDUrVWMxbGdHajVpV2ljemUzayt2L3RHSmNBUHFIUVk2?=
 =?utf-8?B?bU5tN21kRzNGSDhHWFhBM1lobTJwUlBtb3hNQTVQdDk3UjVTRnB3RUNVMkdx?=
 =?utf-8?B?M3ZiSzVjRTJqeGQvZFhQVTFrbGVCQ09MZjg1TEsybnR5TWFEblAwYlBkWVZ6?=
 =?utf-8?B?YldTc1A0eWZWMklxc3EzRlptSnhOcXpIWEE5cys2YUhZTEF0QXV0ZWJYK21Z?=
 =?utf-8?B?bkZOMlJZUVloeVE3a1dOMkhTYk5paHpKbktXaHRSOWEyTGcxY3BHS3NBZ0VY?=
 =?utf-8?B?RU4zZDY2QnMzL25XbjB4L0doM1JDRUt3aEZXdXE4WTQzUGd5TStBUVdHaUM0?=
 =?utf-8?B?QTAvVzhQbjJWVHl1YmJFQ2hseURKWmZHSEJlZC9henJ1NU1maThVM082UHNQ?=
 =?utf-8?B?ZVBSUGRHQmI1MmpCQnNBY29oeUViQWhLYTk1S05Ua0g4TUNVb2hZL3RzZTVV?=
 =?utf-8?B?UUxXdVhhUjhmNHR2ZlFILytHdnJDeXJWWUdMckhCREdKNGczMzZIYWxMb1ZS?=
 =?utf-8?B?UGd1dk5uRG5EVTAwdVJKUG9EUWxpZklRYUZHMmtWUW1BMnFXTkFpQkp4eHNF?=
 =?utf-8?B?R3hpVFlodTFJZTVjOVdrOHVDS2NCbnh1dkdHT2hGYXlRQUtucWgzckRjb3Rn?=
 =?utf-8?B?bXhhRklPaERieFJHdU5TWVBYa3VOd3loZFhmUWY5ZklLVEsycE50N05QZnNV?=
 =?utf-8?B?VEs2NE02Kzg0UmMrOFBaUVphWENXc1NLR1gxODROb29CVWJiZkIxVWZDWC9v?=
 =?utf-8?B?OXNzN3J5d1NqY3lNOERYMklUK3JNQkNqNDBOdzdJcm96TFVGZFFmNzV1cWNU?=
 =?utf-8?B?MmxHamFYc3FPRTZnMHAvMG0zTGdXc0xZeDhCeTM5ZElRcExKdlB1SW1sTk1F?=
 =?utf-8?B?V3h3bkxBRE9aRFNvdFVsREdMSjhzU2xGYUYyaXptU3kwNThQNG1jTmY3cmtO?=
 =?utf-8?B?d0xnbEhKeVlZbFF4Yi9kKzJUTGFCWVMwcG04S1dWVzJFZnV3eXdXSzNIRXJU?=
 =?utf-8?B?bjFGZVlhc1U2WDBxODJSSUlrSU90ckxXUW1jQ1crSjlGejJyY0Y3MlJLbEE4?=
 =?utf-8?B?U0pZZ3JFR2k4SStWMmtaSHV4Ni8xUVdacE8xdGlOdVNwQzVQQ2pzRFFkcHNX?=
 =?utf-8?B?cjAvREY4dklRTzNZdHZzcXdJZVhCaHlYMER0WjgwOTF1dDA4YkR3WEVMY0Fj?=
 =?utf-8?B?d1VZNEZRcHFvRGJNQ3lTZC9oMEIzd3AxOWhLNUlhb1JOczhna2Y0ZU0vaGNH?=
 =?utf-8?B?ZSs1eDM3c3RSdmpWKzlaRDB4T0lsNVZJcVhzR0ZIOEtVVjlmVkw5cTdBbG1U?=
 =?utf-8?B?bWxZTEtrSFdla2tZbmVYUUJOZko4U0xSTWVmTHBtdDNmaW1jcDVaK0JwbkpD?=
 =?utf-8?B?MXplSDBjcStEMVBmbzVUWStMalRkbTRKK0gyVDliamcwRTQ3Z25HT1huQW9t?=
 =?utf-8?B?ZHV1YlUrbHpjOWlORUo0bFltMk11QXRYSXA5SHFzS1BGNUNoUkhzS1hKWGxv?=
 =?utf-8?B?Q2loTDNyYXdMTU9oNjN0NmJteUN2VlV2NzhqeGRQQk9OSUpMMW0vRGlaaUI2?=
 =?utf-8?B?SXYySWZNSXBPZzRGcVhWSzZUaVdnRVRUSlNoUGpOOG03YW1jQjBMM0xpKzR0?=
 =?utf-8?Q?aTxyU+GQhdPSPfb34yCjMV3IO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080bf84e-2da1-4eab-e1ec-08dd55aa6f74
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 14:41:06.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqZ3LH3rm5azpklF/Rf5gh3npjepPbbk+GRUQSKQNCURcPtwXOTrz58lB4hGdSmO70m1kPGvM88EJDfz0mj85A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759

Jason,

On 2/25/2025 7:59 PM, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2025 at 10:53:45AM +0000, Vasant Hegde wrote:
>> And update amd_iommu_domain_alloc_sva() error path to call
>> amd_iommu_domain_free() directly.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h | 1 -
>>  drivers/iommu/amd/iommu.c     | 2 +-
>>  drivers/iommu/amd/pasid.c     | 2 +-
>>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> Why do we even have protection_domain_free() just fold it into
> amd_iommu_domain_free()?

Yeah. We can do that. Will update.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks
-Vasant

