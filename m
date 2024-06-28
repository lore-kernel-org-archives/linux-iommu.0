Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DC1C9ECF
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594530; cv=fail; b=m9ab95ItWtEvWxrBG2RBUiGJh2tCghSVOwY6mM6zD3xvTinY4LqNGMpTUqCSfu2nBTbOW5O0/fwWYGYIuh+1qRKFmAK6RUESmuvMsVCqZYfIKt15qaxX2UceFfi6V0r3iv/Ag6qjjSfP0X6Os0NwxBlWblcA/HvV1n9xt6ptuag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594530; c=relaxed/simple;
	bh=J5U7DEkDt7AEJU0rshOCklxOuFBr13u+tgWUw7i9ivE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LWdEHuB12Dcq+B9f5qyIe8hWoOUzXSZdVB2TQowhh1qqIreG1h1T7JF5ieeGSWKIChM7j6eljsbdRH7ogcRzxa/XSKAseRgVvnbmI8O09tnbCxI9RVWtg6l8DAXRv8rIA2Z7SxTnNmnaXywDTsUj5c3LGEUMbWKXOqjB60I1POs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FmcnzAV7; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FmcnzAV7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pa9GkTcacxNYe1Qt4cIXlqjdPp0hrBn8KRVnjNg2UXDvVZGM4NLOf+4cqg1gKl80yUMZ2fNAxznQNuLYEEeqbhBDbTu4D2s63jLYwp9fdvQr8OBTdHT1vr3AOLLv90U0HFSZffAgKR/jjrj2CLkUUZRkMgJ/xR/KmhpA6368OmiWG4eT0Ftcm04npAOiNE5V9pLfvn4Rn19q7/1tEKKQzAUqNItuc8aVx0s4OZ2fcFrxG54DNlPynW2aYOETfEN3R/oHg+iiGe4cqC5UwUH2nhxKT4hKIN+nDERN+uqxCdyjU+Sbg79sxsPMy6adIJud3eaNybn26DKcjBEQy+RsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdobESx9toet8VmH7QHX5dP2tReG7ycwDqRX64J6coI=;
 b=TTi0KNycLAKvsadWIyqKSFswL9RXyU3kHlBzhydB4d5ZGVyGC4iLADZ9NzViI0i3IePtVdNSKXKRyr10V122c6oy4BgxXqjdmmmsadS/vWmflwKbWTv2QnlizT673F0hjf8xs4PvQa2MXMHhP35hTm8x2F592xGZ3V1V1chuJSak8fx06F9RnpUjfeGdTgstQ50s1Np/7nkgcpVqfFGcXb6Xdm6DZOdlxyWOpuOfYjjf4DO8HjeBS2N+XNtaCzox1uVdU92w5K6gWBM9PpOqju4JafiuRtao7r6TKubS3fLlj+jJbOtXCfXBo5DcY2uhmFe34iKNUbdD1g2zQ5pb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdobESx9toet8VmH7QHX5dP2tReG7ycwDqRX64J6coI=;
 b=FmcnzAV7W5ycCcSZot+HsT1VjUXQ/RCm78ToERw/W8JSAetFztur+IGGDJPUv3bl1QjG9IMryt8a1uMFtb7UwK+MdSuNhK1fPCJQVR3ENg4Hzy9WjizS6KMXSKspQ+gUp3IefwjkR/fhWVVcxvpPltmwypKT6EuZq97Xw20BwXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.33; Fri, 28 Jun 2024 17:08:45 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 17:08:44 +0000
Message-ID: <73e03875-cb36-4846-a3e5-c715a4c23869@amd.com>
Date: Fri, 28 Jun 2024 22:38:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <ece72a5e-e4fa-4fe9-9d03-ad31d7a4b212@linux.intel.com>
 <903594d3-00c3-42f8-8003-eef30f110510@arm.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <903594d3-00c3-42f8-8003-eef30f110510@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::29) To CY5PR12MB6060.namprd12.prod.outlook.com
 (2603:10b6:930:2f::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b379543-b5ea-4fa6-7a5d-08dc9794f730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1M4SGpiencxMWhEdjhpQkE3RXZDbWxVUldnQitpaVNkSGR1eDB4Q2hoaWVM?=
 =?utf-8?B?R0IzZCtUdVNTYXV1UDlmSklQZ1lmdHpQMzh3ZWhVN3ZvVDFGNThRcVR1aVAr?=
 =?utf-8?B?QkxXT2FIdm9haEJOTjlab0ljQk1ZaVBGWnlRbFJvdi9aazVNa2E2TTVnSWJJ?=
 =?utf-8?B?dHlXaG1xSEZOS0YxbkRxdEZ6OFgybWhabkVBZkNZaXZaMkJvTnVhWGk5Q3ZK?=
 =?utf-8?B?UmlUYTZJMHpGaXFLU0UwZ0k2WXErR3RHUHg1cGZ5NFgzK291OHFkRUoxeXlZ?=
 =?utf-8?B?bXg5MUZMb1dSU1NialA5TUdvSjZNTm5qdW1NZis4Yy81dHlqS29SV0JFYU5T?=
 =?utf-8?B?WVI3M3lmQW1lbHF6L3dIemdiUWlyNkxEcjJMM3AxUjFjWEVOVEZjUEUxTFlC?=
 =?utf-8?B?T3FObUFPQUhSNTB0V1NqVWthSHlDeHllM0JyWm1VUDFLeHNQL1VuVmxlZjNp?=
 =?utf-8?B?UlUyb2hlL3kxSTQrTlNrMkpseGo1Y1RzK2xZQUxlMndIMVJRTFpzVkZYQ3dU?=
 =?utf-8?B?K0l2Ty91dFkwanhKUUZvdlQxQU0xQ0pWaFcza2NpcTFiWm5LZ2h1MElqaDZz?=
 =?utf-8?B?Q0RTTVAzTnF6QmRSYXhxcVBuWHM0S3JFTkQzNld0WVZxWGFrU01WemVSUVlS?=
 =?utf-8?B?TmttQlhma2Q2ejJtSzZvNDBnYjJFbUppMzFCUnJ6ZjdJVDBBeGY5Y09mTTd2?=
 =?utf-8?B?NlV5WDQyNVVxK29vVlFmcURVVmZlQmxWTk5JbjhhRDc4UWM4dC93RHVucThL?=
 =?utf-8?B?SUZSYllDUG5WRVVpYnF5emFtWlAybzlXSXA4VDNIOWR1bmdPb1N2eHdoU3VR?=
 =?utf-8?B?dTJuR2FUczNXcnVUWjR0SlB1Ymh5bmJNME9zWlp6TWh2WGl3NU9DUzRnTFpJ?=
 =?utf-8?B?dTZDUnpLamd0c2FMU1lveVBjWGpJdEpoNTJzWnA5aFB6ZmdYZEdJUmlMbzVP?=
 =?utf-8?B?RU1Gc2UxdnBMd09ac2lVNjNiUmp2UmlHRVh5czhRYVIwcmJ4MFg3U01Lallo?=
 =?utf-8?B?ano4b2hYTVRYV1ZhK244VG5hUWk2MDJnK2JDK3JwUVBFT1c0d0lKSG5WOG9X?=
 =?utf-8?B?NlluRWhUNUdPRVJoTUNuaGdFQkFNcDJkaE8wdlRLejdaSWRRSU5yZFJXYmpX?=
 =?utf-8?B?K3krWmorVVdCY2oxZmU2cGZBUkRRNHlDUERIeDJuaC9JNXZlcjZGL2ZqdnNw?=
 =?utf-8?B?QmhWNkVJY2VVS3p6dnFkRkwzc1RKckhHZFlTdjJuMm0vbnlFUXJYWW9NZUcr?=
 =?utf-8?B?bktsMDBtcjJ3VFFWbEFYY0dsa09ZUWFJMFhDd0VaMm0rWk9vRnNONDRRZnJF?=
 =?utf-8?B?SUZ2MCtoUEpIcVhBcThEYXlYRzBlT1RiaU1VbVF2eFhZeUF3MW9BNG1GanZu?=
 =?utf-8?B?L21OcjBPTHg5TWpXNG5YMnF2RE05MG0xMjNVblRlMGZaYXc5eE5xdGJodHpy?=
 =?utf-8?B?WGJIc0VLUHNxWUIya29UKzNyVXdUdTIrYzJ6MDZWM0VKcnVwR3BVVnN2UlJX?=
 =?utf-8?B?OXpkM2h3cFZlSXJNQ2lMckhMWEpOUEQ3S2NHdUg1N0VpUkxHeDFHbmo3S000?=
 =?utf-8?B?L1UvaEE1QmJhdUFtM2kyMzJqWjAwdldJM1hqOXNOeEI5ZkhONmtVY1RSV3BM?=
 =?utf-8?B?c0dOZ2RhRk5yT0dTaXpuVFlpVldxcHY2Z2dteVB2RUo3RjA1SVVWS1lvb0tt?=
 =?utf-8?B?MFNSSFlVYjhUOGQ0RUFiOGl2RnZyaTVjL0xPdUFnY0YzZWxnUmhnNEJERmdq?=
 =?utf-8?B?ZEVmUk5kang4Z0poNUJhT082VGlkcm1zcllhbi9CaUY5bEY1UzZHY2dPUkNH?=
 =?utf-8?B?dzdkcXlNNjBCVVRxK0hUdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VllwNW9xYzlucnN6SndiaVJQOUEzR0dVV3FQWjJ2QnZXN0YyTlk1cm1nU0tw?=
 =?utf-8?B?LzhFNit2SUJjQWRJWUY0RnBOVUs0RXMzV1NHQko0MEx5MGhKdTd4ZVRXTm1I?=
 =?utf-8?B?YU1mRlJ5MytSeTJNQkxQYTQ3bFRxMUgzVTJOb3I3WFFGVFhqZkZJbEx6bnVj?=
 =?utf-8?B?VU4zTmt3UHc4aEFXNTlQOUtFN0JjQk9RbldJdW5zQUtIdGhMVW1zTDZWTnBJ?=
 =?utf-8?B?MGtKVHM1Nm9uWHVBOWNrVkZ1WFNlSjV6VmoySzBUVUY5elZabmJ0R2M1TTkw?=
 =?utf-8?B?cDRraytzanJxR0M1MDEzejNBTmhXRi9HSEtZTEwzTTQ2Skp5VUE5U0syZzBH?=
 =?utf-8?B?MXhiUEw5T0hPb1lqbW11cGgrdkdpa3cwVS9IemxFZVI3QURpV29BWU84Mlh1?=
 =?utf-8?B?R1dYWkdIcVZxa2FRVVVaWnNZS0VVa3M0Sko5T3E5YkxYYXVEaXdiR0YxZm50?=
 =?utf-8?B?b0pXdG5admMzeThDbWVWTXY2VDdmWFBrbGM5VUFSQ2hhTGQ5VXhiNGlzeVhl?=
 =?utf-8?B?MWRuVjJaaW0xeGQzMHI2UWRXeXdkZHc3TzlRR3U5aFNuN216MUxMWjNMbWMw?=
 =?utf-8?B?OWhrUW14VURUZWhXM29oQTU1TGpRalYvWktyWXNCejI1akI1Q09QNkd5eHBK?=
 =?utf-8?B?OXZSTzE3eFE5MmpWVlFyRXpNNlhsWFdXM2gwS0w4UXcxZStDU3lQNGxFOE9L?=
 =?utf-8?B?SnR0OFZlcThsYjdCb0g3Nm4ySGpybG01N0F5R1FzYjBSL0hCenFuOW1pMmJv?=
 =?utf-8?B?cFA4Q0VJdEoxTG4rY1hQOHQzaEkzS0lTbUF6dXhCOEpEWjNydEdwQkNqMzF1?=
 =?utf-8?B?MG5sK3V0ZERXa2MwY21pcVNtank2ejI4emI0c0xIY3ViTlFIWm0zR2Q4MUM1?=
 =?utf-8?B?T3FkVFBvbWZWTEMzUExDQTgyV2hqMmxhVjZHeEpRalRtTHRTUHlKaTJSVStj?=
 =?utf-8?B?V3NlQ0poWWx3dTRObHk5YVBKSE01R2JUNEtMc3o4Q1A1NjFkK3pQSGI2Z0ZW?=
 =?utf-8?B?T2VDQlpBSGcxT2ZxN0VDMlFLY2F5REFFUlVaeVhIdnp6ZTMrQ1EwWWdYSHh4?=
 =?utf-8?B?SWh3S2V3c2ZNV0lCMDZxSGlWYXpJVHp3S3NCQk1SbWNmWHQ4OUVrUi9xZUpQ?=
 =?utf-8?B?QVNYaEpPR1oraWdzSmY3YTFGbGlkTVExT0hFbXU1SGlRZDVZNDZ0Y2JXVGRm?=
 =?utf-8?B?UWJ4ejFrbXhCSVlZVERXNnBEZjBuVUVUVmhoMlV3T00vME4rb05BNjQxVEh5?=
 =?utf-8?B?VEQyRXFIOG0zSENKUUpQMXBMNW5xVzZGUk1QVllqaHhJYkxLT2JVYjZqU1di?=
 =?utf-8?B?ZXh1eXIrMG1KakFoL2FjTXYrQXFhSm5iT2gxUnR1OFF1aEh2cWxjQitqSjFL?=
 =?utf-8?B?ZTJBZGdVYVc0Ukd2WmY4Zk9JeHhkWnQyUEorTFJ0a0lyYllxT3htVXNMNXdm?=
 =?utf-8?B?cWxkd24yTlQvSzV1eklCNFdnamxScFFzTExFYUZwMURRWDdpdno1ZFZpaUlF?=
 =?utf-8?B?NitBR3NBTmdJMWcyZ3BsTXpWSE00Y0RyUEFQTHR3d1FtZEFDVG5ZeG9iaHNR?=
 =?utf-8?B?NFIrelMwaVVPc3dnaDV4MTVuZEg5OFFQTUhRLzRzd2xoOUl4NjNHcHhWT2tR?=
 =?utf-8?B?Tm9rTTBDQ1ZNTVByNC9LVmRkNEwvWFJMTkNrSHlvRXl5b1FkK2pwNjV0SkFw?=
 =?utf-8?B?OXh1aTRxSjkvR1hHbWJTYnRuRFZkcTlvVGYyU25Cc0ZzL2FTenhFK0JNU1dP?=
 =?utf-8?B?Y3FiUHhKVjdUZTdmcll6dkFBdlk3ZVE5cUE3YjBvQzlpazUwQzBySkNmaC9p?=
 =?utf-8?B?Y2VTL25PSDdEdjYxT3VCQ1N5UTUyTHFITEpBOE1vUS9ZSlZ6RjgwSmdYbTBr?=
 =?utf-8?B?SDlOTkUwaFZhczAySW9xS3kxWUUzSGhNWGl5UVVFOGt6Ym1qckRSc25BZXhD?=
 =?utf-8?B?WFI1OFRDK3Fsa1lyY3o1NVg3NE45OXdWSko3WXVYb0oxN0I0bFRlWjUrOWlF?=
 =?utf-8?B?MTI1cEJGNlNIKzZscXd6VmRTSTg2KzlTUmh5VmdUVW1CTEZybDloT2w1TDI3?=
 =?utf-8?B?UUF0UFNHNFpRZXFVSE1ZbTJMdkVqVXNuZHNWNWRmQ2tzcmxOaTR0K1BlUURQ?=
 =?utf-8?Q?xK2u6jyYk540IAOTdpCv39Tio?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b379543-b5ea-4fa6-7a5d-08dc9794f730
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6060.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 17:08:44.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdJcWvu0ohKcXPtTIrNWID7yR7+CzzvCeZyD3LLtHOmYXxNDYzlBfloWwLrN0ofsd4DUcdwUPdPVgVnX0t/dXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

Hi Robin,

On 6/28/2024 6:36 PM, Robin Murphy wrote:
> On 28/06/2024 1:23 pm, Baolu Lu wrote:
>> On 2024/6/28 14:43, Vasant Hegde wrote:
>>> We are working on adding domain_alloc_paging() support in AMD driver and came
>>> across below issue.
>>>

.../...

>> Add an allocation flag seems to work. It doesn't indicate any type of
>> domain. Instead, it indicates the required iommu feature.
>>
>> Something like
>>
>> #define DOMAIN_ALLOC_FLAG_PASID        0x1
>>
>> means the allocated domain requires PASID to support on both device and
>> IOMMU. If the hardware lacks this support, it should return failure.
> 
> Yeah, we could do with something sufficiently general, as we'll also have a need
> for passing pagetable-format options through to drivers to be able to replace
> iommu_set_pgtable_quirks().

Sorry. I doubt I understood it completely. You mean to say:
Enhance iommu_domain_alloc() such that caller can pass any special quirks they
need and then pass those quirk flag along with the other flags we need (like
PASID support or not) to indivisual driver? So that at the end we are remove
ops->set_pgtable_quirks().

Is that what you are thinking or something else?

-Vasant

