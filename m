Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3841C5D7B
	for <iommu@lists.linux.dev>; Thu,  1 May 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095179; cv=fail; b=ZSzdxNFqTPtEb4ZBtI4CluFugcj83NyJf97KVSgKUmj+I/pQuxZhsZ4Le6mRcrBsj6WO+u3LtOgF39c8XriM2IREkC/gBK4d7qP4WpGEL1Q4RXacbUDvGAyQ00LwK9y+CZ0TWPylckHvikLuuz9/pU26B9dG/VEoEGiIw1/Xvog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095179; c=relaxed/simple;
	bh=FPDk+J6zNtVp9+xvNee4otQTquQzA7wXsRYTVnQWebE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fLMTf3MGTTvJ4MkU6SxYid0gBUnW04GHYzo1aipmWewzAIxBl0dKxcc2P2XuwdvSHs1AZyV9MzncmcELkCRjqOdq0G6r351dt3m2YKiPAbnQLtfCDBkVzucYeLqxaNUeFVeO4ABCAUutm0i7dkzFxQpYbNc+gJ93vtYegD7+Kpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ERZJ0IVK; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ERZJ0IVK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxZ8V9LUzIBiOscz8C/fFrajH3yITbwyhDbz2WoTVjSAw2EvO88oq0bYSvsdmL2dWz7+Hc3bTZEW3KvlI8yevKyF2eSi2MUVqV5jEpfI9iiXDelIW9li8Nrgs3BDD1ZFhvTr9puyA2WXgXgsrABfR2/nYGAiebBeO5Kj5/bdnVhPCeZ06TZKLhw3eNyfboA9z1FXU7eV10TaIkka25ffLFf0WZYBRLrotXfIwKgfO0jNiwiujDN1+E9tLVXD5M+43Ad0NB5+Vwnk00D5K8hS0X0RJ4YTd6jszxDU3ZQFuwdHRubCj6cqJgef5elXfTd6M8PVP4Htb+lSCqbZarcWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzD02jtTJeOoiZdHHQ2C/hGLwlQMv+I6AT0eFMCVs8E=;
 b=AhrOTzNfRfqAEKi0PZPHxv2u9iCGX9+3zoWjfmEkvJfLhu1pSkRvdL61wcPbvVsde7PsB0euvZ2fklkJ4rFfbOZ5UWKKTEdBK5lFpGgbxSUfWx9CoYvUcCUcLDz0yh3cnKwhOTJIPu+SFRmm/zWR7ZCH2RD0Ip6yccwE3AJbspxlqOKJswKpBOTeJVsWp4Gk58/5Y9tbMQ85UzKWnhSVZsE3jf+CWm98FQWNxGEH3hj18i3e2yRE897chGxI5V3aWD3sqwZhEkcNOGCcC1UOpA3TfHwNswfr70Ea16i7Kmv6Fxq5WAlqCKeoZ3K/YVRY+r5Ja3Bb1egIxpOJIeifwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzD02jtTJeOoiZdHHQ2C/hGLwlQMv+I6AT0eFMCVs8E=;
 b=ERZJ0IVKcciPJ0WCKFBGLUVwHFNLxV5wMY2a7d+zGZvW4Krn//pUvQieCY4DBCL10iJryk6z2cf6IxhNr3tWJjE6WHoPmW9i1CN60Wmc7mHBfdXNfOlLH45uV9JNcb16RpP1yfrAq1AdzCLfPkKlpsQboL9WVpenHVPwZn3cSA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20; Thu, 1 May 2025 10:26:14 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Thu, 1 May 2025
 10:26:12 +0000
Message-ID: <f7e3f22c-dbad-40b5-a35d-8fea0fb6b490@amd.com>
Date: Thu, 1 May 2025 15:56:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add support for HTRangeIgnore feature
To: Sairaj Kodilkar <sarunkod@amd.com>, joro@8bytes.org, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com
References: <20250317055020.25214-1-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250317055020.25214-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: ad13fc47-6559-469d-1160-08dd889a9824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXVGWUtHTktZSmdpNnd5RHN4QkRQU0x2RGJWMjEvVTJPYnBZb2VzR28wM1Vw?=
 =?utf-8?B?SWR6UDVVczIxTUVLaW9ncnErcVhTbVlwSllOYXlucTkrVlprQmFnZGhkSTRo?=
 =?utf-8?B?ODRhME9iS3JLUGh6QjNlUzg1NmhYVmV2MDg4SDBnVG9LZk5TOVRYK0MzZ01T?=
 =?utf-8?B?QkExejNqaWtQODNHeldObkkxVjFaQnhjL1NhUGFGWW1DeDE2RTRRZ1o5TVZl?=
 =?utf-8?B?clBnTFNCdFF3Ym94T1B4c1dJQ0lSQ1IvUzdFaTE1d3NFVlhZVDVJWVF6cUVj?=
 =?utf-8?B?WFBIWmJpcDY5TmMxbCtjZXJTWW5iY3VNYzZkamdsdlBBK2U3RXlrUXY3K0Mr?=
 =?utf-8?B?SkQwV3R3MnZzd3Y2K2hydTFvdlh2M09ZSWxtMFJFYlBQdjBjZG9kM250KzU3?=
 =?utf-8?B?dXVJMHNyL2dqQWQrbXhiVjlTUjJ4d1FOT3ovdlBGS2Z6WVZmQ3BQNmhFeVkw?=
 =?utf-8?B?WXNPV1g5Tk4zQnFBV2p6MlBNSjhEY1htMnpwQ3ZTUTVDKzhMbmhwOEtDcFcr?=
 =?utf-8?B?R3pxV2U4Nk9pd0JqTU9kUHkrNkx6ZlVjNXZkQnY1R0xZd0ovbHhPWE54dHpZ?=
 =?utf-8?B?WmxoazVEN0dHcHdIbkRHbXBScnQvbGNsblE3aG5VVTMxRFVoU2s1dmZQalo3?=
 =?utf-8?B?WUlZWGhlZ2o0WTBoNjhaMnZIM0xJWnlDTFVJMFlQbGwzMDdFUmIrdmVNeFYr?=
 =?utf-8?B?RHZGeVV0eGR1aEpVNTNPM2NLSk9ZRkduU01ZR2tpN2Mrc0NzcDM0azVaR1Ix?=
 =?utf-8?B?VkViQ0Z2V0lOK1JSRW0wQkwxQjhZN0w5RDJ6WTBXV1pUdkNmSDUxRkNZaDB2?=
 =?utf-8?B?dkdIZXBxSTN1T1g5end0Z3Nhak00WjUxdWMyR2xVVmpobWdONDJMZm43aWFB?=
 =?utf-8?B?TGt2TnRGZGRLbEdMZzdTcDUzbVVCNlNPTmhxclhkMllVeHlmTldVdWs5eDdu?=
 =?utf-8?B?T2UxSm4rZkU1alk2OWpPMGxHQ3gvOXJ3YkZ2ZS8wMlZpVnk1U3NyTndCYXRz?=
 =?utf-8?B?SVJOU0tBaGRYUXR6THdxc3NXenRnQytyOC94NkhscDE0ajQ2Q3o0a0xJREN2?=
 =?utf-8?B?S2grTmhYZ01Ld2swS1ZjNitrN2lqU0dpTTNqT2k0OGVOSStaZjdEYmpCNWcy?=
 =?utf-8?B?YkFhYjlzTGJkUjI5eE14ZndFMGFEKzMwaHV1Ynp4cGEramJ1UTcyNGlPNVVR?=
 =?utf-8?B?VXVzeTFxTjZ1cEU4dDFJU3RGUGY0d3kwZUJMQkp5N1JZTmF0WlEybmh1WW1q?=
 =?utf-8?B?bFVCNTRadksyd1ZFTmUzbzh6NWh2UEVLdmxscXFraklqazR2VkM1bkJKYnIz?=
 =?utf-8?B?bHMyVzVRRUFYT001bThjWlJYRmQ2Yk5VVGJJNFh6U3pKa0VHWDdrNHhVNngr?=
 =?utf-8?B?U3M3SW5melVid0NQTEVoUXA1QmljOHA4K2VZVDU4OENEL0ZubnpvZk5YUDdu?=
 =?utf-8?B?amtvMmgrclNLcHVLa2syZmxxK2ZLanNZRnI4NkVyNk04QzgwQmtuV0Z4c1hQ?=
 =?utf-8?B?c0RxSXAvWVBvak9OdW5Oa2xLNnI5TXY2ZS9WMlAyMGhEOWtDWS84TjVEd29w?=
 =?utf-8?B?WUV2VTBqczB2TmYxRDR4UDNDYW9GWkI2Zk1zY3FwSitwS3dncDBNSUdMZm51?=
 =?utf-8?B?OGhEa2JldlpERHJiMU94ZG5RaW5HanllVC9SWWNIWHVwWlVqcWs1cHJNakpq?=
 =?utf-8?B?cUdlMlpySjhiOTJJOXdrbXIraEErZEJTcTMzWVR6VkV3ekR1MmxtS1UxaXBj?=
 =?utf-8?B?K3lPdnBXTEZ4TFlxeERsMy8yekxaVVJhT0dJTmhETzRCWGV4LzhvbXpja0RJ?=
 =?utf-8?B?b1JYTW1PMm9DOFVMVTU0d3JkSjlhZ2FUK2hma2JMaHRUTkhhR1JQL0dDaDdI?=
 =?utf-8?B?YitOWENQNGtHUHl0QVQyV0t4ZEgxN3crb0l5SHBZOHNjUUhTemNNNTQwZm1s?=
 =?utf-8?Q?9KbakrwRsKI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVU2SXlBcWowOVZ1REZZa3BhbXVHYnp2eXl4SkoyRFNRQks3TFNCTUVVVFlR?=
 =?utf-8?B?Rno5Y21lbzNFcmI3M0lyMVE2dnd6UkpacXZxTWE1YzJLaHdIZ0R4NFhjaWxW?=
 =?utf-8?B?ZzdFWmNpMjZIZlVKOHdiRFlUbGdXazdFQUMzUUhxbnpnbWxhdW5YUGVNY0ZC?=
 =?utf-8?B?VFZiWXdhMHVGcjVmbFVqdVo1eGV6RDZRNTM4RUNPQldlSDNoTHNVVmhaeEFJ?=
 =?utf-8?B?d04rdG00T0ZuODNSN0xaUzFIUXlxWUJYeU9kWStnQXM3RTVrTnIrRDJ0SW55?=
 =?utf-8?B?T1pmeUw1UXJSZHRNZk9lb3U2eUd6QmdwUkZFY1phMUVNOHgzbTJDUjFxOUZE?=
 =?utf-8?B?VkxycHREczYzMUUvd0pwL2JsUHV6WGJPT05Ea3JQbWxLMmNxMVZWUEc2SkFN?=
 =?utf-8?B?UzY0V0dvQ1ZwWGE5RDhhS0FBVWtRUFgyRllxcFkyUk9TVEJqZnFyTDZhY0sw?=
 =?utf-8?B?THBROC9sYVNqbXoxcE41eHhTSTdIWUpLUUhaQUNSUHdtNWlsaFI3UklSTTNR?=
 =?utf-8?B?dktZUEN6Z242Nlh6amdqTzJEbnJ0MmJVMmhsTm9xZlE3aEk5Q0tIQkU4ODNi?=
 =?utf-8?B?MElNY05uVy9mcG5vM1hrYTVxNzg3UjhhZHhiT05qc0ZRczcwYnNMOHBFT0Nn?=
 =?utf-8?B?L2hGY1BSREVIQ1FBUkRpUXl4bVowNkpIZXJnZGt4ek0rbnU4SWdQenc0MkhQ?=
 =?utf-8?B?VHQ4eUl1eXdYQWJDRUVscXRvdHpnUDFxQ0NnM29yaGtscG9NZjViMk51eCtI?=
 =?utf-8?B?Mks4M090cWRtTU4xdFhjMTRtcWxIVDRRSmgxOUpaRGN6M0NZVE1BdnBvV01u?=
 =?utf-8?B?WWpWUElRTktmZ1RYeVdIK0RVbjk1K2VBS1hMbS9pVG5hbVlJdDRrNC8wZHRO?=
 =?utf-8?B?QVZkbU9MQVVBbys4Y0l5SDg0MDVmbVJPNWQyWnVVRGhERFVxSTV5amI1bkgz?=
 =?utf-8?B?OW1sRTIrcTNxaXJkc3ZuZnZIOEd2LzJ4eDFqSUsrcUJ5SzFFL2lYN3FpQk9l?=
 =?utf-8?B?bGpwVUdBMlJzb01sVCtVWUNhMmVldW10VjhjT0x2bmZxVFlJZGxQUU1Hdzh6?=
 =?utf-8?B?RmdMS0dZNGZ3YWZYc2JoNGdWTFdTTTlxMlBTZ2FTRFFLT3ppVitjRk5obzAz?=
 =?utf-8?B?ZnZTQXFncEUzR2N5NzB4RGxIS3R4Q01zTkFZQ1FGeG93SXVPc2VnakRjZGVI?=
 =?utf-8?B?VUZWcXkrUGhQZXkzdVdVMEVmQmNWczU5WWJOSi91R0NVQnJySlNmYzhObkRN?=
 =?utf-8?B?N3ZBaEVVVGJZUUlPRVBMMGtsRy84MWdsR25lTHNCbk5JMWhTL3h0bDQyYlhn?=
 =?utf-8?B?NWNOblZTVXdseXBaYWw3Z3FHYlhkVDhDVisyUUpJTVo5bCtwVlhwV1hrZFk1?=
 =?utf-8?B?T3JkNkg1WHRJVTlBd1ZnZk9LU2dEeTFGL2lySDh6RUJ3MWhsNUx5MWVjckxo?=
 =?utf-8?B?U0hiVWYxQzZac0Q1cUtjaE5RTTBvckUwSkkxemRLb2YrblVqTm9UdU81Wmox?=
 =?utf-8?B?QUZQVEZVZ2hEQ1l2dFE4aHN5Y242MlJ6aGNMTzk3RElIVGtydVF5Wk16NkZm?=
 =?utf-8?B?Um1tbHdaNWxwbTlJWlpCaFk1eXIxcC9qaGhBVDlHZ0hTd2Fnc3I0T1FuZ0pq?=
 =?utf-8?B?NzQ3QVBCV2hVMkwzZWwvZnJXclhycEpmOFdoQURydkErU3lHWFZHS1R0b0pj?=
 =?utf-8?B?VGZnNG9tZXJKdWRZOGZUQ2RyVmVZcGFoRkIyYmg3M2ZJcDdaQXd0UmpPWEd1?=
 =?utf-8?B?WFlRU0o2Z05lSmtIRVZBTmZWVm9MRUNwSU9TUGVtNTB2Q0RFazlrMUtSQXVK?=
 =?utf-8?B?Q09BeU5KM20zdDRhNzNkYUQwTlNHTzR0bnFUOU1NeXhWQ3I1SGdzOUhqUHMw?=
 =?utf-8?B?WDNMWjRmQ3BPb3NMOW1wcEpveFE1YXhtVnNyOVdoNmJEMEk4Zjg5aUhRUWRW?=
 =?utf-8?B?c0xidHVKNDJweC9FSmFmUXJFYzFpcnVMSGEzeWxKNjZCOW1BL21rVmFrdWpu?=
 =?utf-8?B?V0JNekpVbW91V0NVRVU2d01VQk9tcFZqaUlaelhIeXNVQ01oSVhxdEk4WHdp?=
 =?utf-8?B?OXZweU9YeXNDdyt0T045azVCMnJnekRBWlczek9QVERMWkxrRkYvdXZDRk9o?=
 =?utf-8?Q?+C0q/H/gQzF2s8UQxihYlunPB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad13fc47-6559-469d-1160-08dd889a9824
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 10:26:12.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15+m93uDfzOQFnsEAhZPSocf+Ptix2ModMXqsJvIqSfeaiqZ9ynykhebpcxW8GttlArTodC6WMMpA3/Qu/iuWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814



On 3/17/2025 11:20 AM, Sairaj Kodilkar wrote:
> AMD IOMMU reserves the address range 0xfd00000000-0xffffffffff for
> the hypertransport protocol (HT) and has special meaning. Hence devices
> cannot use this address range for the DMA. However on some AMD platforms
> this HT range is shifted to the very top of the address space and new
> feature bit `HTRangeIgnore` is introduced. When this feature bit is on,
> IOMMU treats the GPA access to the legacy HT range as regular GPA access.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/amd_iommu.h       | 2 ++
>  drivers/iommu/amd/amd_iommu_types.h | 1 +
>  drivers/iommu/amd/init.c            | 5 +++++
>  drivers/iommu/amd/iommu.c           | 3 +++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 68debf5ee2d7..156eb66caca1 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -148,6 +148,8 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
>  	return PCI_SEG_DEVID_TO_SBDF(seg, devid);
>  }
>  
> +bool amd_iommu_ht_range_ignore(void);
> +
>  /*
>   * This must be called after device probe completes. During probe
>   * use rlookup_amd_iommu() get the iommu.
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 23caea22f8dc..1b3fc25bcdbf 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -111,6 +111,7 @@
>  #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
>  #define FEATURE_SNPAVICSUP_GAM(x) \
>  	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
> +#define FEATURE_HT_RANGE_IGNORE		BIT_ULL(11)
>  
>  /* Note:
>   * The current driver only support 16-bit PASID.
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index cb536d372b12..538af5a7418f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -258,6 +258,11 @@ int amd_iommu_get_num_iommus(void)
>  	return amd_iommus_present;
>  }
>  
> +bool amd_iommu_ht_range_ignore(void)
> +{
> +	return check_feature2(FEATURE_HT_RANGE_IGNORE);
> +}
> +
>  /*
>   * Iterate through all the IOMMUs to get common EFR
>   * masks among all IOMMUs and warn if found inconsistency.
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index cd5116d8c3b2..4985855914a3 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2907,6 +2907,9 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>  		return;
>  	list_add_tail(&region->list, head);
>  
> +	if (amd_iommu_ht_range_ignore())
> +		return;
> +
>  	region = iommu_alloc_resv_region(HT_RANGE_START,
>  					 HT_RANGE_END - HT_RANGE_START + 1,
>  					 0, IOMMU_RESV_RESERVED, GFP_KERNEL);

