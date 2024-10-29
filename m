Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4519A298
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219812; cv=fail; b=HEBCfeXypa204COjjuFcbzlKa30Mm/QZNmUBPKv4o1hZebau8oFQaTn0AvV6zjpkatIJah+vSveVCMEQOaf5Jgq4IgJT4IitVWxwSURmR6jfb8Re0JCha2soctMDmwCC7rKEJd65x+PNoftC0B1NOk/HTZ4OEi/ifzo17QCcfaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219812; c=relaxed/simple;
	bh=ZnOGoAYkyPqel66QiCfydb7gXjlXIeFl5SLYYZ3byJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XCLgXHEDIiozewRq/vZk63mIqjs17N108/1JtRq7ThEdsrQCq08VeDv+m2LTkVnBeJQSgF7gj6oqrIVqgglkjRR2b8ii/CKWVEDdv269lzBakjPvr44ZXMzWWzVrilrfwZKK2qRQJTmLwAEGnsATGiz+tKrYWRz0Ys91+pIY+0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YG3V8wQF; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YG3V8wQF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKkCMVlrVbbJngzTKCdYouiV1/RmHjLNm4EvpGyT4hbx1QmYiQ1fisYOUCwpzeXYhx1MmaatxxwM/v50aelnUe+EL0JiIiKD9/K7mIzUWcSNDVxc1TeoaPeP0rgzzftdk3DVYO8f4dDpOtrcWkov8lAV3EM8qcSi+8u5JJHM4Qg7m5IiNZbUduZR54ycLBRKvwPJ9xD8AiVHh25Z9UQxe1DeatZ4/WCEjkUr9UxjdPf7ofXb+GrlMs0aPR7WZQdYsLc7jpfhJ5djIGu26w8YqyZ7PFMmvA5vnBsmAkR8+WDwLS9tconzi2dnE5l0wJk1ybwMPfQhp1xQOlfFvleDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK1lmdASySYwaC4/QwJVskoII/1Hun3SnnZFnXqQ4nQ=;
 b=d5CWKsLZfKcQIP7ATGlRvUxfz9mPsxqPuc+Ntu+fMLTVjEp877sQH3VrF9n7k5G4MmcGBCDmjNM1oKh8f3HvhLLyxCj7TGZog0eUxV75ceMgQfwGUvQAitOQYu50EaWblklLxgOqPOPALL0Mafp+bLdASYlwhdEQk23FLvdxPBFe3KNsYa9Jb/WdTPnNs4PkHtnIYBwe34jr9sBbYRwwHlRe6M+5V0fVg2HN8ykylAlnDT8nBXVONI6CbwczedqTiiVoo2CyixMlRxMmgA8tt+FIt1xqIOotZxf7nNShATqgYqF0JK/h8UuJcXGvT0STcUT9SfZRWkZ8gDeyuCVdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK1lmdASySYwaC4/QwJVskoII/1Hun3SnnZFnXqQ4nQ=;
 b=YG3V8wQFIBJqACrJAm/5Iusz4ohLEDiGXx6Xj01CUsf5s4aSXbfXweisiRafUj61zWS5UEZXDmsvIiQhvcf4j34WP85NRFLXzo0XoZ9f+pWpT+4ak/Kf9VqsNR1tMF9V/GtEQo5mX+6fFpqe8DC7g9ZyW9aVNZfyF3auLIJ2j64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:36:47 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:36:46 +0000
Message-ID: <31b80b2e-fc9b-4ba5-a208-d957b111a414@amd.com>
Date: Tue, 29 Oct 2024 22:06:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] iommu/amd: Improve domain allocator and device
 attach code path
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, jgg@ziepe.ca
References: <20241028113148.5774-1-vasant.hegde@amd.com>
 <ZyCni2HHjXqivNwl@8bytes.org> <ZyC1rZJrMqYYebRL@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZyC1rZJrMqYYebRL@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: b64023f1-51ce-41b4-d260-08dcf837e138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0ViMmZmSyt1UkFpM2VwVGM4UkNCODUrbkVxU2JudkFVR2l2Q1o0RDdYVlAv?=
 =?utf-8?B?THM5VG9oSUdyNWJIY1pQSDFxME0ySm8vN1JHcnVuMFBQWUVtRHoreUROWkNK?=
 =?utf-8?B?dzJGZVRYUzh6VWtramFjMFExRjB3d21pVnZqNVQyMkNiM0lQTUJQbmFORUFI?=
 =?utf-8?B?VlZrVmZScFRuS0pxTzVDdUdua0R6dmtkQ2M0N2duUGJSMFdBRnhLbnF5enBE?=
 =?utf-8?B?Z2FjaUlwbnplQUxtNk9FMnNNdGdaa0dnM1h0OExrSWxCMVlWV1RTUmlNVmtl?=
 =?utf-8?B?RGZhVklDbWs5SWdzSFFsY2JJUXcva0FJQWl3aHY2UWtOa2dUcm5VNUtscEoy?=
 =?utf-8?B?VEhQV3NKajNWTmFwdkhtWFN4WXYyeS8zck44dXV6aUdhSUtsUEJOdHI1Y1B5?=
 =?utf-8?B?WGdrcVpPaHc5RGdZUkh6bG05cDR5aURneEw0bnEwT0RrTi8vRDFURm9JNlBV?=
 =?utf-8?B?Q09kekwvTXA2d3pVd3F3MTBOKzRzdmlOQjVsT2ZtVVFXN1EwOEFWVmNlS2ZC?=
 =?utf-8?B?YzdpcGQyQXJhWHhKQmlyWmlVWGF4eG5PTGxyZkw4ZGNGMjlNVEZ5R2dVUjBo?=
 =?utf-8?B?QVFQWExKNStzcEN5ZFlLdWhwQ1ZrMmxFSWRDeFcrOExtNkFTK1QrVFRUSTZr?=
 =?utf-8?B?SzlNbW9Xa09HN25RRFJWUUZwSm9McUxJRGZib21mczB2UVN0ZWVGc3BvZ3lm?=
 =?utf-8?B?Z2lIcFRpTWdmTnJBbHNyVUZaWVUrSFhYMGtEa09zTEFOSUt4SU9JWlhVYXps?=
 =?utf-8?B?T1VYNndLV2xxazI3ampGVnpQRDEvUzZYdFlLa1YrajJWNG9vaHV4YkNxNUlV?=
 =?utf-8?B?Wi9iNThCVlBGbTFoTktONnhRR2xzSFY1K2hjNmo5VUdvNW9oTWpid045eVJU?=
 =?utf-8?B?aEhDdHF6b2Jpa1UvaE9mTmRZVU82Z3ZsRUpjWHlzUHZvMXpCQVo3ZnVqMmZp?=
 =?utf-8?B?TzY4K1lYZE10T3E2VmJ5blFVMTBUdDdHZGJuUWJxa2lFOTdWSEhuK1ZQd1lO?=
 =?utf-8?B?SW93WC8raEprVUxpOFBmdkhnRHJ1S0w1NnY4UzlyTUxCcHpPS3Y0L0VvSzZD?=
 =?utf-8?B?Rk9paENiT3JnU2NuZUpnektaMWMwUnpNWGNhTDlocHhmckhGb01meURlSFNU?=
 =?utf-8?B?NEoxcUFjbVJBT0FvZGZNM0U5ajdVYytMYUh4UjVZKzUwdVQ0QWxXKzFVK2lm?=
 =?utf-8?B?eExWc2ZockhUT0xHY0pTMUROS0N4ZjFGTGlyK1VrNlRDeGhmSmVUai8wWkUw?=
 =?utf-8?B?Mzl1Ykx4TVJnbmdqYjlQZUpwdWpvcHJZM05VSkhqRjBqaUQrUU9mZUhveTNC?=
 =?utf-8?B?WnF2eXNub2FwNUs4d0kxRkhKMUtneFA3bWtseUI3Sm5nMnlyNlRsUHdkRDNm?=
 =?utf-8?B?Z1I4cWFhakI2ZDJwN052U1pUN1BBeEdzNW5ZSWk4VVFUSllUQXBnTDZoditl?=
 =?utf-8?B?czQzSC9vYVdmWkxmS1ZvZWt4V283dDNmcGZxWXBYWkN5eWZGRlNZeHRjMmxO?=
 =?utf-8?B?OFA2UFdOTlV0bDJRbHMyT1lOZEZCdzJ5eVlMWXBZSDgyeTV5MzVaUXhQOEV1?=
 =?utf-8?B?bHozRC81Qy9nK3haNGw1U2tFb2psWFYzcXFXTklQbGpDdHBra0srNlNXVzlL?=
 =?utf-8?B?bjUxYlNLVnV5TGExRkRaSVhSVUFHZ2c4ZVdiUlY0Nm9FT1ZnVy9KeGFBT3ZI?=
 =?utf-8?B?KzdxMmQzYVFIREhYanJLSlAvOGVzTk8zTUU5eUI4b29HMkh2cW1VS2ZlL0VL?=
 =?utf-8?Q?2r6mYd1AvgjR+EDR8reX5z6b8D2O4a72pHnID4h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0VnRHh1T3NxZzEweng5SGo1eFp5eVVuc2FPODUwZ041V0Yvcm45ZWhRRHY4?=
 =?utf-8?B?TmhkOW1MREJxbThEemxLeFNNNDEreHMzL1czcG9XMTk4cy9kVGpiZ1A4bmhT?=
 =?utf-8?B?bksxN2U3N0ZDMVBRWkgxTUNYU3BsWmZhRFJSbjJHMGtjejh0TnQyWGJDaXZC?=
 =?utf-8?B?Z0FZV0RTbEdMcS9XSlVGTVU1SGY2dUFUR1JpWWJlc1ZXcGNqNFhqNWpMMTNS?=
 =?utf-8?B?RG5LYXo5MjNEdDV2QmNLUXcyY0VRYmVBYnAyUnNXY25lZFZvNlhqUG5FU3Zv?=
 =?utf-8?B?aSsvWjhHd1JPNXlsN3IxcU1mMGNLN3NzeVRubjJpRUFOQmpLeU5sZUwweEkz?=
 =?utf-8?B?SFBqOFFLMGhpbUYwSTdYczNISVp6UnNnM3E0UlZpb0l3SktrZUU4eXZEdTZy?=
 =?utf-8?B?QUlteVljaThqTmRXYWFYQlphNE53enRzNzR6dGtTSlRFMHNPREptcjlaK1pD?=
 =?utf-8?B?WFdjR3UxOEVVSmQzbEppbmMzNWNCQjhwMk9GWDIvZW84eDQzQnN6UkpiV084?=
 =?utf-8?B?Mm5hNVorb3BTQmk0em9mbVU4SkNrYnYxNUpYTDdTMzhrOURCMm5XRzMvNnhm?=
 =?utf-8?B?K1pkZzZBQ0R5eDFXcHFyZlphamZlMDBBUjVldTJYaS9WTHZEU1lOODNXbFN5?=
 =?utf-8?B?VFp2MHN5ZmFPTHpsU3RyNVptVXp6OUZmYjMzSFZSRmZnWEloOS8yM0svQUJE?=
 =?utf-8?B?dUhsaWhoOFdUVmswYTlPS3FFUlZ0Z1RwNC9Qb1l4UGdnTUJUcU9KOGo3TmZ1?=
 =?utf-8?B?cWkvZklyY2hJZWsrd1hOSWdYaG9vMWtjYmNhNGhPS0ZOSnN4RDVXMTd1cnor?=
 =?utf-8?B?em12ellDa1B2RTg2T3hTUUFXUHhKVk03L1FoTVVuaUxXS3Rndys4dHB1NWt4?=
 =?utf-8?B?ZlN2L2lwaWFoeUNZakFuZnh3ci9MZXBkajBJSmJDVS9WWncvRnhjREpYR0Na?=
 =?utf-8?B?RnJZS1ZmeWhsb0ZZUHlwMlNjblllQzlkZGpIMU41S2NkSHE4U0RsTm1XemhE?=
 =?utf-8?B?QTlOVVRMbitzZjNsS0RuRUFRbnhPSFo3V1J1TnBjdEcxc3R0MXFUelRBbU1a?=
 =?utf-8?B?YXNvTVVmWnJnTmVOaldTblpZV3NmL0dKY0huVzN6ZEc0TVpzWmFCd1ltT2s2?=
 =?utf-8?B?cWJsWUtpazc5R3Y1ZXkwMm53ZmtzSG84ZzZzZnlUaHQ1RU9hVXcyU3VZT3RH?=
 =?utf-8?B?NXdaczNveFpJM1l6ZEVESm1wempmUFpHcmVITUg4OWlFK2J1T21mcklNZ05C?=
 =?utf-8?B?alFmTzV2MFVaVHFYUUFlYVFiemc5OThSTDZxaHJ3cEFJWFhTRmVmRnArQVlJ?=
 =?utf-8?B?ekE3aWFpYXExeGFSQ3BObCtUcjI0SERlRnNPSWdYNXRvWkIvb0ZRT1pqWFlO?=
 =?utf-8?B?NjVsRW4va3JHNUY2bjFlbVFUOWJtMjJZaDNSUE1Wa0dHd042UUJKQXFBdUE4?=
 =?utf-8?B?ZE5OeEszQVFiL1g3VFR6R293NnUxOC9lQXU5bGNDVksyekJVQmR2L0ZYL0xL?=
 =?utf-8?B?NHl3Y1dIUXZiVXd1dHd0N0ZQVGhkeE5MNnp2UW03SUptMUJrb3kzT29VYVFn?=
 =?utf-8?B?UUxOeDFIYjNNNkkvVzJDWW1Rc0NNeDhRMHQ5MGFrcENXcE9PRndjaU14SlY3?=
 =?utf-8?B?MFJ3azNnc3gzUW9SWTFkek5UZjlZWllzdHJNUGU4SE1Nc0hoMXJSSnE2S09R?=
 =?utf-8?B?OGtSRTl4MWxoUHlvVEs0OHJGR3ZuZzR2aGVPNm1ndUxTTkZoVWVMUWhxZ1Q3?=
 =?utf-8?B?WUVyekpLOWRrcHJyN3dWUlE4QndHSmRiTlQzNlUvSUdXR0tsakRadFN5a2lv?=
 =?utf-8?B?QVB2enplUTI2bjlQQmVtQVpTZGc1Vk9xakl2RXpvRTJENGpqQ1h0OUl6UlFa?=
 =?utf-8?B?Z0c4aVl4T3padU5rNTFIemprbTRaeXNITjVyU2pxczA1V2I4dEJYSlhNTW5l?=
 =?utf-8?B?TXhnVW01ZWNWM2xENzAxNXBJRVp1bUhBVzZhZFl4MlQrSit1cEZ4eXl5RDFy?=
 =?utf-8?B?NThZZDR4M0xrbDV1UGN2Rk9LQW9ycGpJdW5ZZFFDUnBndEczSnFTZndJd2pI?=
 =?utf-8?B?KzZPTEdoVkJUekNDMGNYOUg4SXRwbURIQkVKTTBEclZqYlZka0dzaFVuallm?=
 =?utf-8?Q?mvd8VdI+fFZZmsQw/mXQQ8YyQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64023f1-51ce-41b4-d260-08dcf837e138
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:36:46.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCnhuQX8j39oLhiyy6tEyrU+fDpjDMagS9uYXW2yhdZCm+uwTvvzKZ61hHropZ6ZtxvaPrSqD36NDH46+xXLqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062

Joerg,


On 10/29/2024 3:45 PM, Joerg Roedel wrote:
> On Tue, Oct 29, 2024 at 10:14:52AM +0100, Joerg Roedel wrote:
>> Applied, thanks.
> 
> I have to take that back, this series heavily conflicts with the changes
> in the core branch. I think I resolved everything, but it looks pretty
> messy.

Right. It does have conflict (I was not sure which one will go first. So I
didn't create dependency between two series).

I will rebase and send it tomorrow.

-Vasant

> 
> Can you please rebase this series on-top of the latest core branch (I just
> pushed the core branch only) and re-send? Backporters of these changes
> will be very grateful.
> 
> Thanks,
> 
> 	Joerg
