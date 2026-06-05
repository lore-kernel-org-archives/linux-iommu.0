Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD981494A09
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649160; cv=fail; b=J8kPfG6AKubbLtDxGgZGPl6IRyylMr7u/OtxR3hmUNwIvkAofXC1RfGlJLBWAvWFwmhagyJISxK7qGgYeqJjBknDvrz4rKlQg1hd8mPdQT1hZCuA/SZMJtBFANEVIl7AKOMx+jQYUyAl3B8kSZiINdVmZwZyACot2jeaXXbg3eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649160; c=relaxed/simple;
	bh=7V9x4ln2kwFD+S5ft6R9YOI5qwjDsoAdIWzycKSSwpw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1+Egu9/fo7loWezTStK14s+urM2w6xhNxCAi4czOZ2XAe40p6sn6mjP1jsmiy84Sd1rWhDCFeyjeRKeWyLJR8ntbl+TsAguDIfFX8j8KzbQ0Gtv06g3afr0lvSBY0fowKadkvnF6202Rm4xsXb22sgdt8tIiBea6FPjZsqjn2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YLCXg8ph; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YLCXg8ph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZw2BQXFDI7LaIAK5dbo9NmygLZH+MzAanNI1SXoQBq7C6/kwjv6Ci7D0aHQilQ5yQGwZWxAxJtQhCf3gO1w9Mq67eO2iMGIXN4/z7Mlu+5FTSBkylKh7Y7UUozGgzpAd6vvff4HLkIlQUxEPf9S29yODsOIZaWsuhsV3+8sllh5AhJ7mIAzFB2A4W8P09uOkjDgltFMtNYFZn7DVv44omJ68o0IAjzVMwLkFvLfHi9IoTP9CmFvPEYppZk3Q1LH2L3WwZzqVKgZC1GzySv6c1TtpqWdjpcnXnVIy5RxWOvWXyc1mQ03JQlXHFNN32GQ/WQoJ4V1b0pfodyeomB5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY/wUnucb9TBy0HnHkx6TAez8CJAA4bWMMAikmEEpVM=;
 b=ZmUNeOcdp47F1cdulMfHc/tChELv4XqEaOUIOcLc2kbEYMSVfbQlI7vbMEfcttpyAD2bbV4oCzrkJeTEixpa4nu+85VJ42jdB7g1Mdm+FHeaC2oa3CMMpZfbd8efzSjcPc6RiNeinmMJ+gjQ26lFtT8VVigExslfswfTOozZ4l25saMHSodO9hbpVAqe7Tx8ocaK8ZHryJx4Q94UGeB0Ge5sgLCAiBsCPKJmtBRpuy3g32FO5SoCORXo01imCN4MsX430XOeLKHvDa0SWMkxgxpBK0Pg4SjfscI7yucwjIITuRNgdnQOzyANOvKaHRRrpjk2z4e7ZZ59FeF6VOGXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY/wUnucb9TBy0HnHkx6TAez8CJAA4bWMMAikmEEpVM=;
 b=YLCXg8phU6tBnelGoAvupulPhfn05WpIsxI0fXg75W+Ox4Gice59hmliaC/0PMQ9UAesNzzSbt6IQsyjO6MbFqbl44RLGJpqKNAggE+3G6OfGMfVc4QhzT1ropHo+32HMlEMEOWW9jV1D4vf9EwF0q2tCRUNZKp4Eew26Y6PBYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 08:45:53 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 08:45:53 +0000
Message-ID: <45462b05-1e92-43e6-907b-7440ad435a83@amd.com>
Date: Fri, 5 Jun 2026 15:45:44 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/26] iommu/amd: Detect and initialize AMD vIOMMU
 feature
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-4-suravee.suthikulpanit@amd.com>
 <20260601124305.GH3195266@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260601124305.GH3195266@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:4:297::15) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ba447e-b876-4516-3dae-08dec2deda2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ofnhX/7AsVWA9udb7y3zY6u3IDs8S3fof0kr1SfsL6F8ZioE4XeuBH9deJ/rbOh6BNAAIXGNAK3owcdHrHlYirv4Krd6d1ZCZuYs2bxclXJcA79fCqhXMewNPVbhtlVz3UvgZEJzGoItngVziqUN2Qwzy2CQ+9G78cKVnxTTx2bq56sdho4ogRYKF+SngkzmqnoJj8WrTy/a4vmaWFTbCvqsehrZFLf8216tiwpb6EpQUBSsDDu/R7WVlcepg5yyFddadpfbStR+x79sPDc081xpqYva+0JOwoc5W3KsHpbKWkUxDNl+rQbrBAZh5+36vP7ei8lWjdnT4M6VYNm/SsvZ2p8c0eAX3yijWYN83eSAuhJRpt7PhGap4TurHjlKC/fa9YfNdMfgbF80NDuT+tEjscvIfl/ekTasrbAi+6sjrFmzfpuzl1hS7wGwT4Jrsye9RwDs5ipGAayJnwjCspnOsfMnObUXLddYsVAWh4J5qH9uoL0W4qvcUuMmpPxnLFxafr6kZYePVr2TF1xJd/GLYLU3BjH+Z6WIaoZ4xRRyXxA1sFZRvyfG/Di+lRo8h0yHAecRTpfdeNpKqUDIzeD8kI+H6GjRbfe6pD041tIluRTGgqifTthxTo+Z+P9AhwIQ6bm0PQQDU2C8YC2x7OM6tj0z5vfptMCYJxpkUDzA4BeQQcBiA7lxrb0RiaWT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OENRS3ViTjNlYW5wZW51UGZzTHFSc2w2Qkw5UkkxLy84NUF6MlY2azhnek93?=
 =?utf-8?B?aFBwN1lsSllldlZxTWV3U0oreXA0UWhMdTF3cGV1MG1CbVlVU2Y3Sy9YY2xq?=
 =?utf-8?B?bnFwNnRHQmliNUxYY1JURzF2NUhwVHpsKytscDVPRFhOd2MwT2NSeENhOHFH?=
 =?utf-8?B?YkdNdGtTTlB4ZUdHT3M4emJFSUpoTHVGM2N3clF6WjZJN0pPSUE2MmRWcUlV?=
 =?utf-8?B?UVVJdStTUHBCaDhaSlgxM0xSaUg4MUYwOEFqQmpYRzM0TVRMK2I3SFUzQ2Er?=
 =?utf-8?B?YjM0akdOVmVKQWtYYnB2VVFKU1JqT1dzb0xod1N5NG50L2JTb0dzZ2c4eTV0?=
 =?utf-8?B?Qkt6QXZoTEcyMGlzekxPcHdheDRRRTFqRkxoWDg3OFUxRjgvTTBad0lYN0Y0?=
 =?utf-8?B?R3oxTXZpc25wREZIdkhVaWk0RmlFWWYwRE80YXowdGFEaTVRWklXRkJIMU0v?=
 =?utf-8?B?eGxKQ0czTDlaTmQ4dU9VSnZsQkFIY1dQMS9mdGR4YmJ5Wkdzbk5nWEFwcE53?=
 =?utf-8?B?TmtsSHREb3ZnZGZDK25hdnVNdDRzeGZ6ZXV6dGcrU0JRSFFrMWIzOUVZZmk0?=
 =?utf-8?B?SHN4dzQ3bjFXZWZ6MWhXTXczbENBOFA1dGVRclIwMmVzejJoSGF0QjNvUlFC?=
 =?utf-8?B?Q091L3VsUlhMNnQyeHF3dzdXbVQvdUxiWk5YVndhRGE5Y0hESmt6RTA5Qnor?=
 =?utf-8?B?b3h5N0REUjN6VWV2VkExYUdlOVFPYVlKcHdIaVo1RjUyc1JmRjI5TmJSai9C?=
 =?utf-8?B?Ny9wQ093SVJudVJSaFU4SmpxL3VOM1U1MGY2TTk1ektqdCsrWGJBcEd3c2lW?=
 =?utf-8?B?bGlkeEpPd3FhY1p0Mmd1SVdKeEF4NExMZ1BLbmJmWkNqNXVPWUVZaVJBWm5Q?=
 =?utf-8?B?Z2dzNEZRNzFRQmhXM2VXRUxiaGVXMkJqenJjY1lRTE9mZGFQYVo4RFU3MGV3?=
 =?utf-8?B?bkdMVGQ5MWliSktJckY3NGlyalFnOEFWRXFLaGxYR0p4SE5VV0tLaHBGK0hm?=
 =?utf-8?B?blZVR2x6MEZ5amZpdFpEbGxLRFpLdVNDcWgvMkxncFViVGMwdGxQcTlRME9X?=
 =?utf-8?B?bStUN1NRbkFrRGVHNXZ0MWtjQU9zSzhJSlBOZDNENml4VkVod0w2N1RwaXB3?=
 =?utf-8?B?bCtHdVAzUXJqeDZ2MmF0TkhIQ2J5aGFMLzYxM2VqeXk0WnJFVXpOWW5RMUM4?=
 =?utf-8?B?VVRuUTdBYVhSVExFbSt1aC9vaDFIUk5meWU4TGR4T2NQc1JmS1lGS1JKS2Jv?=
 =?utf-8?B?c0pQZC9lMU5WVkRvaWcwRTZadm1PRE9vUEtDZVJvVmFzT21CYkpjTjcveEtN?=
 =?utf-8?B?RXI1cTdHa0MwMEFGS0ZITWlXV3ZaZUZOQUlXWlN3eDZUWXViSFNxU0djZmJj?=
 =?utf-8?B?ZDVqVUpWRTRxM25Md0I5RE10ZG0wSlB3STFlT2RRUG1GOEt1UzM4Q21xdnN1?=
 =?utf-8?B?eUExK2I2aGpZbzVsVVhFS2Z6ZlVFRW1IUkgvOUZ1bHIvSjJLcUtHV1dadnBi?=
 =?utf-8?B?a1YrZlFRK0w3QXRXSFZRdEhVc2FlNnpEMUdFdjlwdFRwdTE4cWtiTE5UakNS?=
 =?utf-8?B?bXQxak5ZenJ6NGJNS3dSc3R4N3hpU0tHdUZyc3NxSzVmbjR0L3ZuMFR1WDg5?=
 =?utf-8?B?My8vcUpldXNFaWIybDQyb2NydmQ5d3FvR1N5UFFBUGNUQVdPTmJTUmhkNDhl?=
 =?utf-8?B?Rlc4OFZ5RXV2NVZSU3pRMXB0RVIwVTFGTzA4U0pxbytBYWJzK2dMblRvSFMr?=
 =?utf-8?B?aTl0dXMwRkRON09JTFBXWHVwMnRMSS9zUk0xTlZ2dXlPNGV5NW9kZ1d2Rk9O?=
 =?utf-8?B?VlF5RnhXRW11NEp6Z3dMcUZyazdjd2xYU3RXcU5yd1ptQmtTVkl2WnllSEZE?=
 =?utf-8?B?cVlkajQ0bCsrdUlBTDVyY29KYTZPWGRpRTA1YTJON1BvL0FLekFxeTk3VTd4?=
 =?utf-8?B?T1F1NStMMnVrMU5Tdmk5Z2hjTTRjb0hVV1RrcTJaelplYmcwRXQxdHZqZHNx?=
 =?utf-8?B?S3VoWnNTZ2VpdzhrQi9CVDNLRTZ3ajVTbkFaWWNGeFlvNjhJeVE0ekVPTGIx?=
 =?utf-8?B?NGpWaWJJamNkS0V0NTFiSjJITUFYZVZqQitlTUdsS0U2SC8wQlNxTFVOTTZB?=
 =?utf-8?B?N25vbTNkTGwwUytPVmRvcFJEK3BoK3FraTRYdlRxV1pselZCNFVLWWpWZk5D?=
 =?utf-8?B?QkI3VFgvb2VrcTljUjlZV2NOekZtdkRtVWR5dnAxcENYdWxzeS9BeGRZaGxF?=
 =?utf-8?B?cFRXNjg3THF0bU8vYjU3Y0gydlFidVB2QVJ2WFIwZ0tiY1hZOFkwclA2em9H?=
 =?utf-8?Q?z5dFYnzs7rQUtFP4MT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ba447e-b876-4516-3dae-08dec2deda2c
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:45:53.3743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /D00wiSKm2CnPb7zHVqo9mNhujwdBbzpV9VrtsJWQNv5qQBgPvCiDGUMjw6E8GhXPRX00T6YeXbTzPrfBXZK+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535



On 6/1/2026 7:43 PM, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 05:17:15AM +0000, Suravee Suthikulpanit wrote:
>> The feature is advertised w/ EFR[VIOMMUSup]. Please see the AMD IOMMU
>> specification[1] for more detail.
>>
>> Introduce a new global variable amd_iommu_viommu, which is used to
>> control the feature enablement in the driver. Currently, the feature
>> is default to disabled. Once the feature is fully supported, it will be
>> changed to enabled by default along with a command-line option to disable
>> if needed.
> 
> Still no to command line option. Just don't use iommufd if you don't
> want to use it. It must have no cost until iommufd activates it.
> 
> Jason

Noted. Just do not set CONFIG_AMD_IOMMU_IOMMUFD to remove viommu support.

Suravee
