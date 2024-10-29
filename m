Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F57198831
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219665; cv=fail; b=Qiw3+38ikwln0iCd+jrDxEKDCyuhXPuQM9a3yBiZOuEQkeYhT2wg47BLgsy7OsLkGcifsKVcl8a0IyhpvdX/BRpdHOYZ6UEKh0AblPB3PIhcazM9t/Vr8anoQOJa+I7W0LqTBcC3nTpn0djOwetdQe++HBfQKnSsBummBmXnlig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219665; c=relaxed/simple;
	bh=TDVRUQWzbHKIkVWS4txBjceoNPUuwp1P9V519nfwwww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u/aprVVN2iYguQOWw9vldZQ8xBAic4sjQwFzAbm0mwes12WpXXiwIQpJddJNh3sVJ6CXYoiCfp1QuBUJK4cra1H2hnVGrCfXgq80yiYzcZ7D621bzXTyRumNNpeZgLiI7f9jY5Ba215V0dEIXQuaHtR0+5P1yoSjtTrs3bWlHIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L39SjzA5; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L39SjzA5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Icms34cYuXrPepa2fROLFfVE2giROM1fLICRGTx7XX5cv0QA3rUt1XZgayYDY8+SjMOFZBRoZmnfyNplKIIdQbr/yHhRx2xJ93T3bNDf8i826XIP3W8cnfRzogmHqxmUBKHQn55+UlyrNLAKe9ZNlGVoZ84m2vFXt8EfiPmwTciX3Mum4/OETURg3AwqLAfH1OFx2fWvUH69eZD8O8OX1ENiKAcMJ5Iqtt14yedF893CJj6JC8PrUo5H4mFc2zZ6h2rIV4uCngtoC0BAz4EX/lr9FNKWO3Wz3kFzHnRAuBJLLngWZoW4qsgwoLub0tFZ0qi2NJ3rilqlCK5kcNrk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXHxTgzHCls1oq2hfj/IegUrhwhuVHmqdvzCcEiL5hI=;
 b=a4sKqh9lWlhqpqzeMPFcVXyUbVQWbigD6BUfiVNMCfjO/iLJ3yZ8vAwFiOwCmf8c36xD9CZYOYogjk0AOzQgtyHjlOhz2Qj7qERw4ICDiLmSJyXByS5KOh/Si4aOe5pzncbAcgsKHLDKm29mIIk47hjlSaytney1agWy/S+ccS2IiDdFX74ATp3bgWv8qQB5XP8I48cqnv/3nSODJKipJOOp0uSMnHUgwoO3fYrrjUlHSNAcZiLhGzIZ8LpybUyunWFGarn+XL/0+iCBJfSiaUJ1awPXiKKU80oWIkaCUvWqTNY1O+qpsOW1n37nzB/mx0APGYfn1hZ7rFl27K9jpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXHxTgzHCls1oq2hfj/IegUrhwhuVHmqdvzCcEiL5hI=;
 b=L39SjzA5EOwxxuih0Mb8GvfzSObmDJBD1ycvpytUyvlVwFpwlbJfhlzrYSVmBmgThiJgJ6Wd+p4m2Q5U8zcM5pjhye6OvuBp+Z8LOwQyhgVfr1P+yP4GCPmDG++yPnQ6mifJGVfAkwD2Jkjxz4QiVucmGOqxQa95KCQd4lcaqdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Tue, 29 Oct 2024 16:34:21 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:34:21 +0000
Message-ID: <f1001c61-b6c1-4274-939e-c2982ef4e086@amd.com>
Date: Tue, 29 Oct 2024 22:04:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] iommu: Create __iommu_alloc_identity_domain()
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
 <20241028093810.5901-13-vasant.hegde@amd.com> <ZyCtLXeZxhNHTPbX@8bytes.org>
 <ad8bc41e-e6cc-4a91-8cef-6aaf06703cdd@amd.com> <ZyC05ycHuceILlye@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZyC05ycHuceILlye@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c622d00-d5f3-410b-b6de-08dcf8378a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1FNSWdZTTBMZktMeEhPTmhSZVZja2pWWjV3dXFQbC9xS2N6NkJBMVd4eDVS?=
 =?utf-8?B?YXlwdlRRM0hNVnpMeC91SERTRi9RdGZidkxaaXRGQUkxaGF2NFZsRzNFN0dS?=
 =?utf-8?B?ZlZlNnd0Sy9VSHNUbWMvaks3QmZxYUpjclZUMUtGK0ZlVlY0RlFhSDlHdTV1?=
 =?utf-8?B?UGpqWE0rc2FxZmthaDNPaFZEbVZaQVhlemxQaXRaM0ZvdExSaUE5NjdwekFB?=
 =?utf-8?B?bm1YbXdFWHNwMHJua002aWZ2MnhuMEVmNUc2cEYyU05kMlZkRDVGODA3cDhu?=
 =?utf-8?B?MkhVZVlmMjBDYlFtNWs0bnM4N3VwcGtyY2I1T2Z1bExHYVRXMk12VmhpNzM0?=
 =?utf-8?B?bW9nZzBDTnBXSGdvSG1kQTZUdmRncnozak5uSG11TVh3Y1c5VEp6S3kxYnVS?=
 =?utf-8?B?bVJzZmFHWG5aRUFVeUF1VzQzSWVERnFKSVZhbTJBdU45VjRlOW1BU3VPZzBq?=
 =?utf-8?B?cUhrc1lJQW9aV2IxMnRSSkNlR2ZVRUF4VVlIcC8wUjFwekRNYWJ2Z09ibVVj?=
 =?utf-8?B?ZDFpSXE2eFp3RHFsWFRmV280eVZaUmJYc3V2SC9GUlZTZVY3SlJJQk5vQWxr?=
 =?utf-8?B?d2hBY1NLRUhOYUllU3F1ekcvWFlQeGFTZm1MMGZmcUw0NUVHZ3FucU5qa3JE?=
 =?utf-8?B?RTl4SEZ6MjZYVFVnbHdoT3F5TlhwUGc3L3VJVEpRNW0zUXg2UHdTVTZnbGJt?=
 =?utf-8?B?a3dGcVJqZkEzd1c1d2l3S2cxeTNDdE4rb3phN1VkeDZUWkNPaXl2RU0vS1Uw?=
 =?utf-8?B?aEgzRTdWWkdTU2gvTUtxNGgwbmVoWFVHU1VyRVQwRFRxSE1OSHJqRlIwZS8r?=
 =?utf-8?B?RG1YY2RyOXZramVETXlZb3B0UVcwNTBqWDZLQk5hRHNuaUpLcTZnMWhHanpz?=
 =?utf-8?B?OVpma3lhTGo5U2F5d3REaW90TTdRVzZUbjZQdGYrSEIzbkk5SllScytPTnhN?=
 =?utf-8?B?RnFvVHdsVmlqeEozS1VZWG1Zb0c1NVlCZmowc04zZlBFS0dmd0NMU3czRUQv?=
 =?utf-8?B?UEc4cGtWeUo3elBOZFd4OXUwT0VYWWVsejFraXB2NmFrd1d4V0xmcjJVYzJL?=
 =?utf-8?B?VklGYkEycU1UWW9pbVRmVDFXRkZ1WUJRRDB3U2hDMERreWRIT0dMUDVOd1BD?=
 =?utf-8?B?bnl2cnFzRFEyMkE3YVQrd0lsNVB5Ujgrd0RyYTAwWWRYenFmZHE0K0pweDdH?=
 =?utf-8?B?VHVmRTVGYnFkU3JtRjhMM2dvRjIxcmtBMVV1c1RxMi94RjIrMWlSUjhUd3dn?=
 =?utf-8?B?UUFLVm5CckJBZXJWNGg0SCtpTXZONlBrb1E1bkgzbzlSSS80bmlVZVZZSGd1?=
 =?utf-8?B?bFV4NjU4SlNhTDZhek9HS2xzNytNbE5KSktpSHZoQVlzQ0NqWENpdVpvNE1w?=
 =?utf-8?B?c3doem5EOXFiMzFTeUFIemNiclVHWlIzenZ5cy9FaEJMTXBlSmZncDR1aVBL?=
 =?utf-8?B?UW1WalhkalNzRHhwQ0xoQTJrMXlsMFRIYTcvYjUveTN1NC84eWk3eW1KeGdl?=
 =?utf-8?B?b1RTOFo4cGlERzJmblFLNHBLTU5ES01KVEpMS0p0YnZoa3hac2I2QmJwNXkz?=
 =?utf-8?B?eWhwanNQenJ5emJqelQxY24zUUxWYXoxMnFzNklDb0M2eGY2OUhJV1N2WDVQ?=
 =?utf-8?B?MitsbVc4Z085ZkxZQU9yT0lhQUs4YlNNMVpkTUNoRzByamttdDkwQnc2eUtO?=
 =?utf-8?Q?+UJCK6pZM1qkyKC44lfe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHVDQUNsU0VrQUhLc3RudEhSVUhvWEFDQTdsU1NldUFyYnYvQ2pNKzJKNjhB?=
 =?utf-8?B?b08yYWJ4Rk8rRUtyaEVSU2s0czZlMS9WdnhPYTE5VkltRlhFZ0RJWUFnVHdC?=
 =?utf-8?B?T1lYaW1HbXZHNXdSejI5UmJpMVA5ejh6RHlIa0tpbnlydGROOUlnQ2dFbndR?=
 =?utf-8?B?bjF0eTVmN2xNSDdNRmM4SjNhL0tOcU9qaGpqRU5vTzNXcisrSkV3cFFLNzJE?=
 =?utf-8?B?aTA4NFFKUGpkeU9oMStWRzN4Z1ZoUXQxUmVZR29GRjVBWHkvS2ZHL09idFpB?=
 =?utf-8?B?a0ptRUxMMVhXaW5GTmlQSkZ0UGZFdm10NEl4VTRWK1ovKzhqeUhqWjhSbWpY?=
 =?utf-8?B?eGFVQTJ1cmU4UmRidkM3dnBYc2dGN2FMU3Q5WlM5a0xvZWF6Tm9tSGlBeHJl?=
 =?utf-8?B?cTJRQUE0bGJHblFtR2xYNFM2aVBFT1dYU3N3amNWekpyS1VwRmJuUEN5bWFy?=
 =?utf-8?B?dXVPdnkwc0NMOGFwaEFuUGNEYjZuQXlZb1BjZW5jV21tTjhldlcwQlZZaGxq?=
 =?utf-8?B?a0ZycEQrKzM3cDFqaU1QdFNzYnJFbU16c3lqT1A0MG8rR1hEaGExaDR5NmhZ?=
 =?utf-8?B?dmlzUjRNSjdnSG5ZekFKM1c4VVFKNS83M2VPY0p4dkh0MDNUVjhKMDJsWFdx?=
 =?utf-8?B?TWI0SHhQSHRLSWtzZkJCb1pEZ1pGVXFQSG14OFBEQmhpbXZ4VVJ2emtjVkM3?=
 =?utf-8?B?Rmo2d1ZMcVVwVE5paVBCMkhlSEpmeFNhbVJEWVhuY3k3WDY2dVdWRUhGWU11?=
 =?utf-8?B?WUJpek9mdGN1Z3JMNFA0MHlGeWl4STNoMm9Lb0pVMVJQSHZzNHFmQjNBNTAx?=
 =?utf-8?B?RXFtNnprbndqSXJtTDROcjZEZXh5VVNDMUhGZElTK1NwRU94VzRQSEpYakFI?=
 =?utf-8?B?TE9HTEV1REFYdmNXbU5RQzBJOEthMElOS0k2VWZ5cStHMVRrbVFqOHF2eCtT?=
 =?utf-8?B?UmZKRU5CMnFtckV0TStFNVJFbS9hSGVRN2Q5QW9rVHliU0piaml6Nmphb1cz?=
 =?utf-8?B?c2sxejVPUGdKV0NqaG8zUlZlVnNQT0pwSUpya3N5emJQWFdWdG5zR3hoQ3I5?=
 =?utf-8?B?MGpwV2RpampIZ0xZYVRyZFREUlFaUnBBVjJQQUd5a1gySk9qZVNpc1BvNjQ5?=
 =?utf-8?B?NmJzeHc5YXVXSlNEWlhWZGlQQ1RNalFtRlcrZWRXZ3VDaVB5ZjVvcWx3Z0VQ?=
 =?utf-8?B?c2g4eWpoTHRZTFRXREY4cXdKMG9aNjJaRFlxT2pENDF0NkhDNUFtU0NmZmc4?=
 =?utf-8?B?aEc5S0FGbzJXaEJiWXozeUlVMERTUXlKMW1FVlh6QW1qcWdraGpJSGYwQUtZ?=
 =?utf-8?B?UUlQRTRVNTZReFg3aFpyaUVsTjBnV0JsUmRoNVIySHJjczF1S0tydEpWSGpy?=
 =?utf-8?B?Sk9kRUs3OEZoYXRva3QxbEdQNHdZVEhVeW8zM1hQQjl1OFN1U21vUDl0U3lI?=
 =?utf-8?B?Y3ZtUnhRd0xlOEZjNCt1UHFQOHhJK1l2NVRTUURDUGphdEZEREdpVGp1RTJJ?=
 =?utf-8?B?K2lkN1RqZmxyMHo5TDJma1k3bkZ0WkFZQlgrTmZaU0xnYUpNUjJXWk9Md0p1?=
 =?utf-8?B?SkYrVjlVVTR4a0R0ZzZydHZQMDJJdzZNVmdqWUFBT0V4bzJDZWtpS1NyVnZ4?=
 =?utf-8?B?R0hiYWRwL2p5QnNhZG5SbElCVC9TdU9pQndRUnJjcjR4ZTkvM0hYeVNtTnJu?=
 =?utf-8?B?TE51QkVKZHNWaXc4TU5XSnlhREdlVW5lMmtKK212dWtqU1hndGJKcGxDd3JW?=
 =?utf-8?B?WitqSS9KYmFoNjVBclFGOFNHRU12RUE2dTRZbUhpc2pjbFFUVW5HeXYyU2ds?=
 =?utf-8?B?Y0d6RmprdGRmL2JXbDlEZzdJTnlsNDMwVTdWOUpLa0xzcGtzT2ppSTNuQUVY?=
 =?utf-8?B?YURMQytqWnhqMTVVK2dWOUYxblVTcDhSc0Q5Vkg3SWFCZ3F4TDd4clRqaW1n?=
 =?utf-8?B?TzhtNDltSE1QY3ZHd1VqZUNyTzVUUW5LdE1WdE9WMW15RlBNTkx5bTVxeThI?=
 =?utf-8?B?UWM1elhnVlp6QVlYWVZBY2tsM25KRm9BNWUyNEdEVVI2a0N3STFQZFhrdlBP?=
 =?utf-8?B?OVVyejVFd3Y3cGgrMDN1cDM4Nit0VWp4dS9nNGEzUTFoblZ5RllFTTRqR0gr?=
 =?utf-8?Q?f32vxvHUYl2njSg5w71h++GnF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c622d00-d5f3-410b-b6de-08dcf8378a37
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:34:20.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tM42DUCR6DNv3nHb/sj8NqjIrv0RY4NsoykFQMl+wvi/rekILIjYGp3k8BwCwIgkTaLpdkyQClr7fCegwUm5dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

Joerg,

On 10/29/2024 3:41 PM, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Tue, Oct 29, 2024 at 03:36:41PM +0530, Vasant Hegde wrote:
>> In my base (v6.12-rc3) + this series, iommu_domain_alloc() calls above function.
>>
>> Looks like you pull Baolu's series which removed iommu_domain_alloc() [1] as
>> well. So now there is no user for above function and hit compilation error.
>>
>> [1] https://lore.kernel.org/linux-iommu/ZyClPkzekxXKqTFV@8bytes.org/T/#t
> 
> I see, that makes sense. Yes, I pulled in Baolus series as well before
> this one.
> 
> So I added the removal of the function to this patch as well.

Changes looks good. Thanks for fixing.

-Vasant

