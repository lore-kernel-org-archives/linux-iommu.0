Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE913B287
	for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753224; cv=fail; b=QmbVcYWiYNINYJqSIYRkmjf2QXwqs/k/5mej9OZ6ksQ+3tjDtR3XRbzKMIKbA+GLoQ+mTpL5KKOXJYcqyHu/e7Uxya+Gu0o+Vtu0o2DizRAZJ7GABZTymFhzz5BGrZtg5GXgntiYQ+DGczf6zQhvkF+TBdTu9sok4T9EZlZgZa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753224; c=relaxed/simple;
	bh=wQVawj5ibtvFaWWL94bvITes6yn9qoU57JihjZlM/XY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X10nfsQi8txOLbE1NU3TwxQJSZjkXWeMFX4kbQK/Ge/Xj00yaBlpACbqvna9eMrm+n8lu1RgnAu5jhgQyR25OKn0fWXIysKN7bL2edsZ/5vc8fGuCHb5EcX30tVy0pD97l1VZwKc9K778r0SbxR7UlWCRhuacWK3h5+pEkSOb2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F0F1M0mJ; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F0F1M0mJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBTUd7cY2l4iNH4OYM9rxxhuzSodRP1HcJs8y4uOxq6V7EF6X0EnL4Y8317udPgQAmdgDI3szsYJNAXIJ+ck7RjLuE1MFMBTNG4qekkjmDlWDRTpBeRt5Wo9/CkgR9GeTxetAUDkVhPw61Az6ht9onPZSMTrI7Y1gd9omE6yaQpPGxldLMRQNnoL/yiAjq7lqzkwt6120q+5uV+UxHL4RU9vt9DEg04O1Gbl6WK7m/94UKGrmMg7rfOqoCcmTRyqMFlYsvtHcynDiLv8qsJwKkLXiNf5JUCfbFvV0c3BM0YoOPosbfOUVXNLVfqpQEkWcuSp2HE26fzeOhjCeOCkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PyjIgwqOBg8/6BNdwgNo8HHAoKDPMw/4l1eOjTkprQ=;
 b=n/vgDyImM/GIq5MolChHWZ7JFy9rkYo73CtiloH/43tyJafrl+6M20DayKCJ7ZZJVinXIJ9L5IiNJyyF+MXwTufVuygThLi80HCvydxgLXcf3XIHGnqMrlw6P3bhfEFii5eqCdaaPFPZjeIcw0I3d7Nq8qIpULe42L8Rakv4bShZ8a6Z0oZ09/tpIpgZxre6DL9atcOD1QZA2IS/skIJm7K0iAYOEaG7joayU3mq/Dqw4L+3DjLeEp6dwecBdmtn8LyKo8bO12YAOudHztXii09rqceGBKAEhBYRWOGbxUM26RyqhsbeRC+WDRiAQt8eGjJtSor8elSnzfc9qjgyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PyjIgwqOBg8/6BNdwgNo8HHAoKDPMw/4l1eOjTkprQ=;
 b=F0F1M0mJ3jqDtQ9dzhvq4Mli0YFRG+B8sOfj7Q0OM8hvAfQglXheTOuG9eR+HQOZ6xwC65Ht+5pdSAtZEQcOYaPCLcJrOf2TuCfs6r6nN37DZMbvjo50p8cxFvwwV7vkDvtHvXNwG18HU3YarMaMQZestnXLHMOpBbmrWwCSTJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Tue, 23 Jul 2024 16:47:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 16:46:59 +0000
Message-ID: <110c57d1-1a84-44e6-bf71-ab5cbae12120@amd.com>
Date: Tue, 23 Jul 2024 22:16:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Add support to change domain to blocked domain via
 sysfs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20240722115553.6005-1-vasant.hegde@amd.com>
 <20240723130507.GK14050@ziepe.ca>
 <e7a6ce53-c473-44d0-9177-b7dafa5c6aa5@amd.com>
 <20240723164448.GM14050@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240723164448.GM14050@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: c83b940a-b2d2-403f-dcba-08dcab3711e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azhSNlI4ODczSFl3UjNBQmdPT2habm1YSXYvczFCWHZwYU0rMjR6SjczTG9K?=
 =?utf-8?B?RjMvNkttVHBEWkQ1SThoQkVid3c0a3l1RzA2YWtZOVhzbUdNdW9hMFg4clZI?=
 =?utf-8?B?Y0xsb0JjcndhOXB5WjRCT1ByU1FzSE1KWkNyMXZ2ZXA2ekFOTlh0MnFYZUNy?=
 =?utf-8?B?Q0RjbWhFejNra0MvaTJGMlFYY3Z5WXFrRmVaZFllT0JwMjZDODVReXRZQ1Vo?=
 =?utf-8?B?ZXVYNkdtbFprRHYwN0RYcTlXYmwzRngwcWZiUUJiOENSQzliUEo4bS9tOTJ5?=
 =?utf-8?B?cU5PKy9FWXk1dnVyOHF0MHk4QWhZNUt5aHVrMnNxS0FFOWFaakM1aktaNUE4?=
 =?utf-8?B?R05paVZjOWZ4RUhpL2lvN2phcnAyY3UzcHlhY3VQRDc5VUV5ZUJlQ0hFSldB?=
 =?utf-8?B?dFNJeUc2Ly80TXE3RXZ2bS9sWEh0Mk5nU1lDelhzMDJUc3hJQ3BtZ1J2dGNx?=
 =?utf-8?B?aUNma2tpVGViQjVuTzR1V1UwVkdqalc2OW15ditWcFh5YWtUbmhoQUh1eXp1?=
 =?utf-8?B?S1dabEViazlLUm1jVWNLam45RzlTUFZOaE9kemFpZEI1NzBMckVJQXpnRVdD?=
 =?utf-8?B?cU1CeVd0Z2NieVpRL2pMRzNoNnh3RFNBbGYxc2xlWHJxc0Rwei9KNFQ3WEVW?=
 =?utf-8?B?NGpSNU1OWHM2YUVOeGtmb3ROSUduTS82dlFyZ3pJSjVIT1Q4eDZPUWIwMzda?=
 =?utf-8?B?ei9menpOTmorRHc4VVRWUjlYODd4RDdxT1FqZUxGbTdQWGVVV1l6bFJBUE9H?=
 =?utf-8?B?UktzQWZ1bUxwUDlmbEd6MW1KSHNJTHdkdXAzRHEvMnFNT3NqdzVvUTExOHZ2?=
 =?utf-8?B?Vkt5WnZFZ1kyVmtBQzVOdVZlTWpMOXFiTXIxdEJENjE1eWNUNEUxRUxGSW9i?=
 =?utf-8?B?dDRQSUFzRncyc1NKUjZ0dzFjSXpjb2lGNEVkRzVSc1RYNFI3Z2hXMWlGQWVG?=
 =?utf-8?B?N0JWL3NEK0R3RjZadVNRQUUxRVdKdFdIcy9sUnNsdFlUOGI3dUpwWDBUcEFM?=
 =?utf-8?B?Y1NhU0ZubkdndDNId0hSeitXQjZZdHFPSXR0U3R1OHJpZnpVQUQxWmNMTG12?=
 =?utf-8?B?SFJhR1p5SExyTVBPZFNuQUxQZGZDUys5ZS9CbkxWNjVTbmpIMHUwMnRZV3Yv?=
 =?utf-8?B?ZTFZQXprZkd1OFJpcUloWTFHNG11c2NaR3RvMGJCRy91Ty83bmhBdGx5dVdu?=
 =?utf-8?B?ZDRlQzFOSkdSUFlDV3JrU2lZVzVaM1l5ZmMxaU5rODd5bTRqZzdtS3hOS2pE?=
 =?utf-8?B?SWdWa2JqNWFNTDZxcndCNHlpaDZOcUNFWTNQdHB1anZydk9NWHoxdlRLK2Fa?=
 =?utf-8?B?WTl4d1cvTnNmMVJpNGZ1Z2pHMmErVlVRc0o3bitlbnZtRk4zOXNSVlVhRWhq?=
 =?utf-8?B?TThQMWhUcXNJZXZiL1lLL1NyQWhpdk0wYUN3TnYyNm5ZNEpwYTdJSlVYbWg0?=
 =?utf-8?B?MDZaN0VRMzdrK28zSld5TzlZNVMzclgrblpDVnRqblA4RXFQbE5iNTRpeVpm?=
 =?utf-8?B?eHJwelVIemdUaXoyZUtmTnZuYnlUalAxMjNWSGptajlEc2QzcU9JdENnK3FC?=
 =?utf-8?B?YStSWnN5YnNqQXpTbmVYTmltSHZwNDJaRUEwMXl5VG5GUm5Wek9lZStYZXV1?=
 =?utf-8?B?K0FnckNXRTVVQjVtUFIzYWQxelkvNnhWSktXUmo5US9KRU5YS2JXaXo3V1Ro?=
 =?utf-8?B?KzRDay9VRTdDdDNOVEFvelp1Sm5IazE5SGh4RGZvZmwzUk9NY0djRW5BVmZk?=
 =?utf-8?B?YTR3d3NtNGVyekJXV3RVL2lIVVdmSXhZVk4wVjlBYTl3SFZ4dXNkYzFwQ1hU?=
 =?utf-8?B?RlpTMk9QdkNBalRHL3RuUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHlJUExEZ3BnL21mUHFkUjZ5QW0rRllNSE8vZEtxQVZOSjBQSkwvMUNIZ0w2?=
 =?utf-8?B?RmZzZ1BPazBHaGhPTDRqZnp6Z3VBTG5lTnlDT3E4d2t5SFBleVFralNVSklP?=
 =?utf-8?B?cjBUTEZoc1AvaVJNaitpTXVkOSs3Z0JPdFFEZEJiZWFJQlUrUlBoU1o2TnFH?=
 =?utf-8?B?OE9FNWFTaGtCS3orNVh0Z0NxeXU1UnZOOVEzeWhJTE90dVlSaTgzSHk4MzZP?=
 =?utf-8?B?QTFtTDlrNjA5UUtpd0FIWXphVHNZVmhMQlpVMG1iR0pIZXVzQUp3VEw0emlz?=
 =?utf-8?B?MFA5cHJLYzVYaDVoMmx5bnhkS3ltQXN2R2UxbE5XREN6LzlUWlRyVnQ3N0Zt?=
 =?utf-8?B?WWlxOTU5bm5pUGQrWXZ6Vm1tRGJBdVIwRmpVK21rMXlzeVhuR2NPRXJmVTh1?=
 =?utf-8?B?K3c3VE16UzI4QW9XYUwyLzNFYnNZVi8yMG1EUGV2QTRDSk5PVXEyUFVsdFF1?=
 =?utf-8?B?NTlUS1p3dEZzT2dkc1hmbTl6V3RMcWpQNm16WXhwcDNiOG9NL0ZpVWJmT3dy?=
 =?utf-8?B?cVJDM3IvVXNYUU4vbUxBVE0zaXpnbHhnRkMwUDBEaUdRcE1idENlT3pkWXA4?=
 =?utf-8?B?dmN0TStwSDhhS1VhWVhpdjJoUDdmQkZsTmNwRFUxeVN4N2NHRU0xZFgrSmVh?=
 =?utf-8?B?VFp1V3p1ZU5zTDIzMldCL1JEemUzUElQM3EvNy9YaXRHdkZ6SWNlVXZkZVFz?=
 =?utf-8?B?dndPVFEyMFB6d0ZDRTZ2d0pKLytxNzVjV0dZdnJGK2xrd2wwczZVcko3MzRI?=
 =?utf-8?B?Q3YrclZDOXVvSFViOXlnTC8wUVhZdGZER0luU0QyYjdrVUlySEtCTEtLeXo2?=
 =?utf-8?B?YmFWZVVSc0V1T3JLMzhobjJDN2lKNktqUW5qMEJ0azNyVXpnMXRjM2E0cXIv?=
 =?utf-8?B?djFrSDUwMUo1U0prZW1sN1FHYjNXRTV6ZUhWS1dNTW9Ib3o0QU5qVU5ldzRK?=
 =?utf-8?B?cXJIbUhLWm5aalRuWlBIQUZtR2IzSVo2czdvRitMM2N6bnVBOGYvK2NFbDBQ?=
 =?utf-8?B?MldxUUg1SnQrY2NtYVNTREVQall6UzNIcGFjUXpjNUxWZFdOMU5iS0liT3Jj?=
 =?utf-8?B?ZDFVWWFPV3BXWjJxc3RuditHalloNE1xaWx2QmM2Q1A0SVJCZUxJYWtCMlBa?=
 =?utf-8?B?ZEwwUURVSjN6TDE1ZzM5elZzRG56S2FzSitGVEg5aEk5VUQ4K3hRSnlvcG54?=
 =?utf-8?B?SVdzWEI0N0IvOS9rUDNQQ0oyS2k5UjhvQXBYaVBsRExLYTZCeCtpNUN3Rlll?=
 =?utf-8?B?MitRV1pwdkJjNnFKNlBZQTFvZytjc1p1L0VUUTcrbFh0NVl5RWVnUFNCVEJ6?=
 =?utf-8?B?NnM4SXlOUHJIemJsMlVjQTludHltSkxtK09CdytVQWpTbHR0NWt5L1pSc1JW?=
 =?utf-8?B?bXh4V0V2TEpiNk5FdGEydDRhMzNhV0pJMVhTallra0JISjdXdUJjTTlHNzAv?=
 =?utf-8?B?dGhOY3ZvV3NYU2FUYlFEVjdtZGJjTHB1a2xPdzBraDlKTC9NREh3QVBscjJL?=
 =?utf-8?B?ZzNkTmJOQ1JZMjNndVVlbEhJZlBmeTNpM3RvMTJVV05xTGQ4YVhiVXdvNEtx?=
 =?utf-8?B?TzIwMk9pa1RVMnFOM2s4MXlsYnFOcjlENXQyUWVnNnRGeHVNZHB4ai9sRmkx?=
 =?utf-8?B?ZmFOeEF4Z2RBc0lFOTMrT2IzWFlEWlJDQTlhdnFzVFF2L1p0a28rTWg5d2NN?=
 =?utf-8?B?RVY3TmN5RG02eTQwNXRqOUVkV2tHdWFwcjYxSDZFUVlUb3NjM2RFVTlGWmVi?=
 =?utf-8?B?Tk11MnZMeUVXNjdQTVRFSFpzdnF0WXFzMWZVUXVCd0xKRkpFc2pMTTBjK1M2?=
 =?utf-8?B?SUlDVlh5S1NiOVBoTi9UdzNpQXlTb2Y1Q0FyRmZxaitNV3ZDOE5wL25XQitB?=
 =?utf-8?B?cHFVL1ptUEJGMEdjamU2QkhldU5VQ0hJd205OFRIdjZHRnhFbXhOSFJUNkZY?=
 =?utf-8?B?N0wwZCtiRUdFSmNwaG1lODRWSms5dHRGYjVUd090Y213dy85ZDBnYkVQQ2o4?=
 =?utf-8?B?aDF4aUdMcnpKSGtJaUtBOHpnelBCM0MrVzl3WmIvMThTOFFEU2lvbFVCVVAw?=
 =?utf-8?B?dEpBWDYxOVIxd2dTTlNycTJrTTVzMnhpcWVPcmNmd3lwNnFpUDYycFFOcTdp?=
 =?utf-8?Q?3p6B2g1zO6NBXfVAyMFf3NVfB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83b940a-b2d2-403f-dcba-08dcab3711e1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 16:46:59.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvz04VyvS5s6ji4zIni256xboFDa4wWBP0oftMZ2GWrxQXs6fgxaDRy/EWgFlxQJ50ehhCmUn91bUqrdEZBE8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

Jason,

On 7/23/2024 10:14 PM, Jason Gunthorpe wrote:
> On Tue, Jul 23, 2024 at 10:08:52PM +0530, Vasant Hegde wrote:
>> Hi Jason,
>>
>>
>> On 7/23/2024 6:35 PM, Jason Gunthorpe wrote:
>>> On Mon, Jul 22, 2024 at 11:55:53AM +0000, Vasant Hegde wrote:
>>>> Add support to change default domain to 'blocked' domain. This is useful
>>>> for debugging.
>>>
>>> But how does it work? 
>>
>> 1. unload the module
>> 2. echo "blocked" > /sys/kernel/iommu_group/<groupid>/type
>>
>>> If you set the default domain (aka the domain
>>> used by the DMA API) to blocked, then surely no drivers should be
>>> bindable too? 
>>
>> That's correct.
> 
> What prevents binding after being blocked though?

Device is in blocked domain. So any access from device will be blocked.

-Vasant
