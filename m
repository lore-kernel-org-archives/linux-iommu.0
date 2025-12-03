Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC028313D;
	Wed,  3 Dec 2025 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759868; cv=fail; b=KawFCag9OOpPABXyEITay0E51BBfPEJ0dSD3D2NtvWc6xKOKh3DHS5YZgMQmDT7q4qJHL5SoSjm53JwfcStv7FiE02SR+B5GGLJWalHQuWEPC86SSxTm24BYGhwbf5dm7hQ/18eJoX6CAMQhOew2qd+oRm8JXAtKiBBQ0o97Lbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759868; c=relaxed/simple;
	bh=hgOSvNdl1d059F8ZAvlWmVBxnqS/Hc20EdpwK3Y+U14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1hF09HQnyffix59msDhlPg/MUbHDltUnkEVyD3mAVeARzmEZ3Cai+p52I1eWw04+/3Zfv8qA4OnLVMq1KjMF4xaVjI6s97xcW/x2zSFatCFM9g5u5MRtaOdyQ1IxPx3FuoZw9ZxlF8cNiNU6Zhh0QlBb4K2aYGNbcVzafK7UXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gl5xD1Uj; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gl5xD1Uj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L11RDLNyrR8Mxy0bgovnaWV5KWt63T7upOrXVLZANN8VlTNrif0OeMeXt9yQ1gyGuhvgaRRHrsqBaPas9pHDl5HDRYUDJZghz28i8y2tRt/Mjv+p58VEsHgVMu09FOdnNN7PmnvBwX5SY/XzrEMI450c7Z3iAlA2kv/5uEYi+MARvmwBC+tNxKTgd8bS//kQQeyZcZBPsv2TrSmEGw/CJ/1f8shKi67DHCLl+wi7d3Q7HRJeRR0iHAnOih2e47K6KC36LxMc2U5NLcO53GUqpTMcCRnVxQudNvLdatscEIaH5C8n65p1qvEwUGKbpi85LE5yPqhdLEoMgxER/bWfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6xkIYl6TPl5FcyGQaVkGRPG+Qcjpbr86t/UrQgzqFs=;
 b=JCqlyEw01uoZYFhZ0Cvzuzq7CSPAc5TuTijHwrwmPe8zDUBlYQUwlq4zwZ/VabmrGwNgTKOfWfJj5HVqLsUMfqpiDPwbWEpG0ZiD3Q5hvd69bblVs76lBYINL6O3bwn74NXVR3Gwgpo0rfOJgdPv0FBb11W5FrkCJYFH/XlJQbpY7caGQFPM9IbnVMDwR/ElaEgafeWfCq7sByVI4LjSubLp0T28ei+UJT3VAEzen61oAJLXXOM5vhu6o1fiNqFd/+on5myA8j0JVRGR78XxzhUyT8kXgnbsdwzHqUlA4jxYrI7kGG7YWN7Aa0bOuv2d6Z8taryZUsliBqBBAXBeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6xkIYl6TPl5FcyGQaVkGRPG+Qcjpbr86t/UrQgzqFs=;
 b=gl5xD1UjZdldgOqa+7IpMPWYVHWYCnbl2U6Iyr5S76xrRDLRZLPXKvMAxQ91FNBHTkjJPgdukKinw0BdePPT67NiY05ih97RPMg4HideQTLCzpP1DzUlF1gsH70+Nx/PUVcxag611PeaNrp21ZQyD+DDkzAg3f6Bggtrq+3H9Y6XElm6jA1j+dOCDAL14+He8X07tJEn6O2g2cJikwHHjf6y/wLDO5m8gVCnRnw5uXRew1bIjKJZ2HV85HNMlgFcQhgwLiLOOEElFHjmA67unRIwqZBE/9iOFP0ON6q1iAszHgjhYbOBntrYV+723wqIhDl73Qom9I5Z1PUutkB4TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 11:04:22 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 11:04:22 +0000
Message-ID: <47684b91-7c0f-4260-abfd-2795fdaa2b31@nvidia.com>
Date: Wed, 3 Dec 2025 16:34:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 thierry.reding@gmail.com, jonathanh@nvidia.com, vdumpa@nvidia.com,
 jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 joro@8bytes.org, robh@kernel.org, kernel test robot <lkp@intel.com>
References: <20251201163219.3237266-2-amhetre@nvidia.com>
 <202512031601.IpliwbHW-lkp@intel.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <202512031601.IpliwbHW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3eabcf-336d-4863-65d1-08de325bb6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkNXWk5XRDFxZnR1N0gzdTd5cDFqaWpQeDcweXlNaFZhV0tqMWRNemdJUlZl?=
 =?utf-8?B?ZHhWL0RzbXhJWS9qS2w3dDNCRjUrOHAzZFNrRWlqL0p4RXI1R1VaV0dINTFF?=
 =?utf-8?B?djgzVWpQYWFWS21Qa3lxZHQ0ZVh5WkpPVDVJZ2pKYUNzMFVhSEFxRnRDclAz?=
 =?utf-8?B?WE03WkVVZll2dStrVEdQNVArT2ltK1BKN3NQaUJkaXZZbDdiWXhpSjBlSS9q?=
 =?utf-8?B?bDZOeWVvcElEbVJoaEUwMXpPZ2V5OUdZTitZalZnOEYrSlhlY0hGcjNJSHhx?=
 =?utf-8?B?Q0Jrc3hiczhHVnRoY2tubHRXU1RSYnBqVElUZ3dRS2dNcWpORW9jQWttRnE0?=
 =?utf-8?B?Y1FiVUtOeVJuakhHbVFVeUxQeHpJUkw3aXdhbzFUMThvWTdJMmNpRTBVRGFw?=
 =?utf-8?B?dFJNcVkrczRGTlpoR2piWUhRWmswTklLdlpMaDl4T2dLNlhjeWxQY3RVK0RL?=
 =?utf-8?B?YWYzcUpIQ2NFcDJ2OHVmUzB4VGwzT1FKSkFCV1JWd1RSamdudE01WHMzcE1Q?=
 =?utf-8?B?MW1POCsxUGFQeEZsS3kxVDZLdnR4WVVVTkZFMys5UUZRaFFYNXl5UHBVeTlC?=
 =?utf-8?B?akVlV1VvdE5hOFJ4UEFKbDYrRGVtR09URi9zcndIc1NsWjAzQ0VLcCtPeEtl?=
 =?utf-8?B?QmdsOFJpb2JlOTdWblViRGFMSVdTa1djbnFmL3dYSXcrS2FmODNiTVptYWNW?=
 =?utf-8?B?eFVZWEFSUXhwZ3RDTDNCcXM2NkZ2SHpNWmFjY2pseHRaZEluWkVXdW8wVUxO?=
 =?utf-8?B?MVJFNXV0VFNYQjFPTFpsNzdCRVZJZk9rN3Z3NlpaUlFEWnJicU9QZC9Dck40?=
 =?utf-8?B?Z2FxbjNCcjRFK3ZZbElReGN4YVRMeXU4TndmTWlYU201REthaDZudEIzWnVj?=
 =?utf-8?B?LzJBcUtuY1c0bGFNdk12OHdQQ0syMWdzdWYwVU1OVy84N3hVdjgwcDhWTVMr?=
 =?utf-8?B?R2lnaHpnM2EwVEdGSWdZQ3ZheWtWZmx0ZW9LNTA5KzJYcks5S0dhSzN5VDVj?=
 =?utf-8?B?eXh2TTdTMHpRUW5OalV3bTZQQThjeWJmdDBNc0hBcDkvbDR5eWFwVzJEUGQ5?=
 =?utf-8?B?Rk8xc1RHaTlEOEpjKys0aUlnZTVWNm1teGhtdUF4ODBWQ0w4ZEZHajBQbDlI?=
 =?utf-8?B?OW85Y0U4SzBwVXgrbHEwZEVuL3QrUjErRElPdmtzQjdhZXdyaitmSHdHUDRC?=
 =?utf-8?B?UWdnRHRtdHlTaXRNQzFtSk03dHREb0JlWGc0L0xHUko4TjdPV0F4SFk5KzBI?=
 =?utf-8?B?TWVUanI1Ym1pVVhUZXA1L0FEMUYzbk9xOFNRVFJmT1lDaGlMZUhUTkN3WUtO?=
 =?utf-8?B?QTk4eWovZjh4VytCTHZPUUwvTkEyc0ltMEV1ME9rY2o5aytqdG4wYU9PTSty?=
 =?utf-8?B?VFh0NDBvVVJKTkIwRVNkU2F5d2V1ay80aElFMUF6aGUrZERhb1kwRk5qQzAr?=
 =?utf-8?B?d0w5eW5LTnBwSmU1TmU3bWxkTFV0emF3c2N1alZWUUZZUm00ZEFXMW9CUlo0?=
 =?utf-8?B?Z3BlNld2MUdrb2VkeGJ6L2xEYUd3Z2w1bnBXT3BjYXRpZll4ZnhqTVJhUEdN?=
 =?utf-8?B?S0R5Z1EvVTZjYTFpMVllU1FYSllBWmI4MW1DbFJMRVVQbXdFZFBnalBtY3lp?=
 =?utf-8?B?SUJYVHRyY09reG1xMFB0WjE0cHErM0JLYnpFZVJlcHc5WE1WQy9KeWtOT2FY?=
 =?utf-8?B?TEFlVCt4cjJqbzNGOElUSjlOSGJKR0lCV2hGTXZDSWFJcFBMTzMzMWt1YWc4?=
 =?utf-8?B?U3dNUFR0dXlPZjZNK3hpU1ZuWnV0Q1MycDFMQndCSXd1RThpZjBLaVFmR29Y?=
 =?utf-8?B?cW93b0JDNWFHV1I4TWh3WUhGdE5DN3dYcUUzR0t6QXFmbUw4T3RaZjFpOHNW?=
 =?utf-8?B?NUZ5SEFrV3oxc3JueGxBa3ZhM0cwMlh1NTRndG1raUZyNFlZemtJdC9iTWhv?=
 =?utf-8?B?cmZJemd5eU1QQzIxWG5rTUVOcTdVdVdnWERhR0dGTHdPYnRubmgvYWtMSCtI?=
 =?utf-8?B?NkNqRUJFQ1hBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azRFVEdubWxrR0MwcDVhMGFnWlpRbzg3WXhTc3JkUzVncmxKSjI1TEVsU0Ja?=
 =?utf-8?B?b1hJcCtjMHE5azVMdTNvMlBBN1gyRGltVEJjY3RTR0xLUkZmNmFyMHY4TEF6?=
 =?utf-8?B?VVBWVVdWYml5bFVCN1lUcFlNYVRUcXkyS2Nzc2ZyY0phdEpoL0ZuTEQ0NDlF?=
 =?utf-8?B?ZklWR0JXZWI1S282MTVWZE11WDZaMG13b092QStvU2Q1d1dJVEJUT2daWW1q?=
 =?utf-8?B?elBoOE9ER05BMitQWktEMFlXUWg2aklwcktIOVh3cHNreitxajdPUXN1bUxh?=
 =?utf-8?B?WTRBU0dsWFI2QWo3Z2N2eGJKL1duQmVUK2R1YmJWbWh4NW5pcCs3OTJ5OUJO?=
 =?utf-8?B?Q0FDUXozbFQ1YXJBbTFueGNUcmhIeXE0VTB6YnltV1lYQzZhRGRFMzNpQjRN?=
 =?utf-8?B?Q3ZXK0ZRS3NIZ0s5aDNJbHpMTnM3bFN5eUJnc2VHN2pPWlc2NUNSNHN1SEd1?=
 =?utf-8?B?eVhGY3dPeHl1ZHRheXhTdGZER3ZTS0xzV2FKZ1daUEt4ckVOeGRIU2FrQTJ4?=
 =?utf-8?B?OGwxOC9pZzJ0VHM1TnkrajdCZHo0alcwSzE3d3VRcnRZT1YvUjUxNm11WUxv?=
 =?utf-8?B?QUJ1bGN1R0padlJBclBuQUQzbnd1MnZlMzBES1oweVhvcHV2ZFJUcGluazFN?=
 =?utf-8?B?Nk53MXM5T0VrcHVSbXEwdnlxZXhuV1A5Zm5KMHNBZVNzMDVUVjFIK1RyOVFo?=
 =?utf-8?B?Lzk3WXZIRnhPWVhYSXBOSURjVEtIWGt5QU16YVNVRi80aW1HYUZDb1h6N2NT?=
 =?utf-8?B?SkwvdmRWWE9aNS8xTnpWbU5HblNyMitGR2hlMmE4UHRKdWZZdzBBNmYyNkVT?=
 =?utf-8?B?Q05XcTQ3VkIwai9Gc2hGQlNNNmV4elRYL3dJdk1TdEhSaC9vTUtyZG54RzVR?=
 =?utf-8?B?dnhTSG1FMWJkSEZ4ZkprckhWazFSK0p0L2FvWGw3bG9hQWhBTG1EdmxYTmNO?=
 =?utf-8?B?MzJ2UWtnRDU1dHhOOHdINWIraUxkMzZmYzY4dDZLSWhra0xFdVdNeXljdG1p?=
 =?utf-8?B?MnZQMVNNUjNkVHBjTVkwNkVjS2lPajU2dXZkaXUwbEE2ZHdWazl3RVR0ZG1P?=
 =?utf-8?B?ZGpscmczU20xbXJ6dzJSQW1qTDQ5dEFoSENDNmdtVUFoYnZmemV2Mjc2ZDFv?=
 =?utf-8?B?QUx0R0g1THB6ZGU2c0tZTDFwZEtObmFET2ZaMWs5dW9Qa1FaWHBRYVZialA5?=
 =?utf-8?B?eTVjK0Vpb29sVG5zKzN2NmVMT0pWV1FyV3lZV2NyZnAxYjcxem9GTldLc21E?=
 =?utf-8?B?NXRZRFYvSDhWeWpjMjVsZ2k0Ny9HQy9zblYySG0xUTYzZ01zL2NqU3hTQXp3?=
 =?utf-8?B?cnVtclcrTVl0bmM3dExqeDYvRCtoaHF4K2hDU090YWFxM3RKLzBPV2RDc0Jw?=
 =?utf-8?B?SnVRRThyc3pVZEk0ZVNRUlVNRjVmRkZqdnJVdThLRCtlNTVmSVBXTEJueFh0?=
 =?utf-8?B?VlVFTFpneDF5STJVMS95RFZsc3Nqc2xUL0pPTm1QYUtHVnFyeDJOSDZiNGo3?=
 =?utf-8?B?VHhxcEs4L3o5dmpab0tQVGtBWElwUlJBamI3NVFBbW1OWmtWNW1BUW83VVJS?=
 =?utf-8?B?LzdrN0xSRlk5eTRqTTJNdHl4WlVDczlGM3FWbEhqY3R5d2ZndUZ1WXh3U3po?=
 =?utf-8?B?RU9LdE8yZmZTZ1RLQTArUDRSaVJvLzZhMG8weGVTZVdoR0ZsL0FhU0VRc2JP?=
 =?utf-8?B?bUZqY0Vwd2p6RTRId0ZEMzJNOGxmdlBLUkhma2ZRMDl2K1JZdDV2bEhGM3l0?=
 =?utf-8?B?c01TTDVQcXpZem50YjBONm5nWXdRUi9oU3laRXRocWZieDZXS1RhNWxiMzd5?=
 =?utf-8?B?aVNYWTc1RzRZMHB5NkI3K09HWWwvWlJYd25Yc3E1UkJuN1lxUCtDT1ZldDZq?=
 =?utf-8?B?RlJtT0RYMWUyMXVxR1UrZTE5NVdhR2MrdHFMd0xHUzBYMGdEMU1QZ0RzeHpm?=
 =?utf-8?B?cFhiSVY2bUI4cXVNb3p0ZU9SOEcwSGNQUlNQN1Q3NmxSQm50TXRVNHRyOGU1?=
 =?utf-8?B?OFlPOG9wNFM5UUNuazZvREdVWDFxRnZBeDFjdHpjVWJId2FkdXdiYlNrK01J?=
 =?utf-8?B?ZFU4S3lQSW9sTWQ0OXZ0QVRsdjhNV3NtUGlQajB6TVFRZDJmUnJ6SEtLb3VZ?=
 =?utf-8?Q?ECG49f0CGwGLF+mHkcDkMwgT6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3eabcf-336d-4863-65d1-08de325bb6a9
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 11:04:22.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljGP2yI6kU3zi7gP3UMoB26mS8Z2HQ21+4GSBpnbDu1E/zfJ5r8EfatwAPBh7DQVoRt7vSM7rMSntob17YIaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793


On 12/3/2025 2:05 PM, kernel test robot wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Ashish,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on next-20251201]
> [also build test ERROR on v6.18]
> [cannot apply to robh/for-next linus/master v6.18 v6.18-rc7 v6.18-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Mhetre/iommu-arm-smmu-v3-Add-device-tree-support-for-CMDQV-driver/20251202-003517
> base:   next-20251201
> patch link:    https://lore.kernel.org/r/20251201163219.3237266-2-amhetre%40nvidia.com
> patch subject: [PATCH V3 1/3] iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
> config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20251203/202512031601.IpliwbHW-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251203/202512031601.IpliwbHW-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512031601.IpliwbHW-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> ld.lld: error: duplicate symbol: init_module
>     >>> defined at arm-smmu-v3.c
>     >>>            drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o:(init_module)
>     >>> defined at tegra241-cmdqv.c
>     >>>            drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.o:(.init.text+0x4)
> --
>>> ld.lld: error: duplicate symbol: cleanup_module
>     >>> defined at arm-smmu-v3.c
>     >>>            drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o:(cleanup_module)
>     >>> defined at tegra241-cmdqv.c
>     >>>            drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.o:(.exit.text+0x4)

Hi Nic, Robin,

How do you suggest fixing this? Is it fine to compile tegra241-cmdqv as 
separate module
and export tegra241_cmdqv_probe() to fix this warning?
I am using GCC compiler and was not able to reproduce this with W=1 build.

Thanks,
Ashish Mhetre

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
