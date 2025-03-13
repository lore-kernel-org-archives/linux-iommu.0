Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861111EF084
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863850; cv=fail; b=sQHcPH937qMlDwPl5mmIVQ815hy627DmpNJZsa2sHqJqQxeCYb4LPWHrZLPxsfKxdJ8zjTqaW8leibwtxgrrs/JaNt3FWbXoU1FwLPQHTwt/Gx8KXes8663KIf7fNXxt3gbMJYRd59LyKWVgev33MGZM25UHsOfUrm08SEc+AtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863850; c=relaxed/simple;
	bh=kYgXgsHTIe/1+iJvZ2EEUczseY95ncx+B8EsQiCfT0o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VHqW27rMnz9cXtH7d7WVRuMSo+stiRWwV+2MHqBnz7eU2PUV5CyfD3zYVx06XBJYYgbf6RU0tfKggk/flcZ6MauxurdvWV+mlmHcGuj6qIhvEmfgB8zoFEjZIhRmXwGNTzyL30ysZ2Qz6CicEHvC2ORwdjlcUqdhfK1uEtRG8iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pj0IMRvL; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pj0IMRvL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0Og0jMsv6MbB8ct6WlLKxjHVhnyPtZsCxgqYpV8VvLe1Q/blhM5WZinzqYxtArMjjLRWI+6FhtLW/pz5ywQ0nL1XGE9cFO03tnVmnS5eiUH/GX+51XZpaUfCiYMWNN9ISNUJlj3LjMh5eeLfe5kANg+9l7mGUWV7m9WslUaqtttMVnLXvy9gzoESF+LFqgOUs+RWaiC/9Ue5gx1Wg3P290CzvwsNEbBMsBpebV80PxffGjWU68/GNoSOJka+L7P+nMS+kSu5mm0BPA96zdfap381xiUHpCJfA2vGPZeYk810Ro4RVariEJZy97nsGGpuoeP7Lq6leUs16nuAZJGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBm6mnueTios2v9gePW2PEmD7KfqCKWex3uAboeRAn4=;
 b=orhbo5NfzaUCi9EVoolMHlB8knYxvqm7kWa6Zl3jbOKLdfUBvxjfYTLjKy9kcPHs8ylnoLW1IJxENRr1s6hsVIg/BNJcDb1PZ7hE4uWJ6YZ7dJYFNq2GbpgAmT/kHi5lP5VP2VmAd1AJ0U/W79YtpJ1+nNVQstxc2iMU8Neq6PeAdfnySo1GWu0Q7oM+ZfVKZeE70fEk5SaPheUC8SnPwTV2R7ag57l9X0eMrp0JvGfOH6noPFlFuSVf/k7MWHmbJD31aTVTttEa+UQg9c+04HQLdWc/7VCHSeqOoHWUOHVmQ48NptwYLvBOV+GOXM8aRwAOCVd4tGqH6OKDis9ULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBm6mnueTios2v9gePW2PEmD7KfqCKWex3uAboeRAn4=;
 b=Pj0IMRvLxVSrBhMLHAEikgkHtfBtMqsc6G/sHR66EHG3umISq35CE1dCdRPsTji8XUHXJmeu0rlIXU7HQkM6/cJmQZJM2o28ujjriPyo0TiGWCwLSh6IYTbwX9+icDRdpt0d/sCLfb2MGTNmxDiKw1NyDqQc0HQvmYTrCVTE6fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Thu, 13 Mar 2025 11:04:06 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.028; Thu, 13 Mar 2025
 11:04:06 +0000
Message-ID: <d5dc3ba1-187c-4ce4-b7a9-eea95a7f043f@amd.com>
Date: Thu, 13 Mar 2025 16:33:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] iommu/amd: Add debugfs support to dump IRT Table
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
 <20250206060003.685-8-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250206060003.685-8-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::17) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: a7867c37-1d45-4a90-b9bd-08dd621ec528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHllMGtmRVhOd1p5WXM1UXhYbzZiUklwNUpubjY5bXRBYVp5a08vNW14QzN4?=
 =?utf-8?B?SVdJZDM5eHZoUllJbldkQlM4Z3RyUm9BUE1TWHFzTEdXY1RUOUt0eXNQZlh3?=
 =?utf-8?B?NVhod3ZwNDBLZms3b2YvRjlRRzhQUlhGYmI2QmcwVFJUbFBCdGdDSXJyWW9i?=
 =?utf-8?B?MlVScmhZL0hkTWhPTzdYdk96TnpMcVFKU0ZzdDFXekVhUkE1MU1kUU5JNGZk?=
 =?utf-8?B?NjJRd2p5c0tZRk5pUW5jYjJJbVplWGx0bzFuMXVJVTNaOGVXUEVuVlIyeUI3?=
 =?utf-8?B?UnRDNldnbFpaanR3WDNmMi9zSG96UStmbFEyNWl3QVdjNGMzZWo3UGowdGxl?=
 =?utf-8?B?MURTMnRLK3pJQk1saldpUm5WMVMrUXo3eHZHdWlsa2dNNWEvMGcvcXUyNGpQ?=
 =?utf-8?B?TFZBNVd1cGpwbXE2aEd0bS8zTHdjNENKQ3RPQ2FPNWg0M0FFZFJaVEJaMVd1?=
 =?utf-8?B?dEZLVUFUc0F5OVkwT0NuaWR2NHBmZWRZVURld0g1RWRVODFPeWszRjF1UG5h?=
 =?utf-8?B?cXZHK3hHZzZxMXBObUc1MDd6TCtQK3RhTnVCV21CMXFQWUV2SUpDbEpFT3FC?=
 =?utf-8?B?ZnU1L2hWZUxlNjV6a2ZzRHgwaE5zQmRhQUZ0blE0VkQxcG5ualRKM2ZLL2lL?=
 =?utf-8?B?bmoramFocUNKTTVwd0FDOU05WUs1Nm1BTzVCL2JmY2Rob3Yyak5rL2tET0hq?=
 =?utf-8?B?czloUGVoSDNmSldNTEJscFVMcW5ITFFwVVNzRVJ2WTM0V3pjeklneDJTRFJn?=
 =?utf-8?B?S1M1WUgwQ1NsY050T0tGc1JOaWVRU1ZUYVJ1RXNUaEVYMlo2Q3ZUYUFXZGFT?=
 =?utf-8?B?bGh6NnFLZGpnYW44WUlrR0dhSng5WXZwbVEzSytLenl2MU0yUUNCNzZ1Skph?=
 =?utf-8?B?enhzL2pLdUVZbENCSlp5Mi9Fd2JnaFNlZ0NLT1hhMmhZZnhhbFl0aVNWL00v?=
 =?utf-8?B?RU1acGl0TzJ6MVF4NWpwNkJnWlBoRis4bGthTm5RRHU0YUFpK0IwV1RTQ1V5?=
 =?utf-8?B?Ung3REtkcmpiM0RFLzdsQm1hekdnQjQrT1FXSlpwQVNsZnRjd2ZRdEVyaXdZ?=
 =?utf-8?B?elhPczBRK0pETzhqYUpLTi9CNHBWUjQvNVVYdlV5ME1mbmpnVytGWHVWSmpo?=
 =?utf-8?B?NlI2T2ZHOEdYOXdCbXdPd1VDU2NFbTlINmVYQU1HcVNzUGZHWmhIYkxrWVhq?=
 =?utf-8?B?eGJGc0xaRE5HV3hhb09JTDlzYWF3ODM5amZDT3JaQXF5NFBXUjJyRXd5SEw0?=
 =?utf-8?B?a01MWk1EczJtUS9GR3czZjNEZDVWa1RpUW0xS3VMQXBBeU16T0haMWJQWDBP?=
 =?utf-8?B?WC9uZFhGSGJLd3RUclhBOEN5eGJHSlMwZ1V4U0k3WkRHRUxSZ2ZYekg0L3Jy?=
 =?utf-8?B?WlNvQ0hrRnZ1MHNmbk91cXVCTkVLT1RzY1F4bFZrbGo5UkRoMFlOWlZDb0ZY?=
 =?utf-8?B?OWFVaG5RTFZaWkdvbHU4WlRESW13dXlFR1BsZmdHUURpQmZUSFVScW9uWDFp?=
 =?utf-8?B?VEF2NzROVzlqMWRLaFltOTl5TlkrTkxaQXJDbmp0MWNFRmszWnZsWno0RWl0?=
 =?utf-8?B?YWx2djlWOGVHRTlFMXBTVlplQmRVbUZYMGlBNzVuck4rNkExYUhYVDNISWhm?=
 =?utf-8?B?NjlhemlxN0pJTzJ0VWIrOUhubkR5cTRsbG0zaVI3eFJ2aWU1SWR4M3I5LzFT?=
 =?utf-8?B?ZEV1emRtOUh1RkVQZThWdURuQ0N4cGVMWTRJdmpvdWxZSnhZS3dqQUpZd1lr?=
 =?utf-8?B?akZqcW9Lc21NQzhPNEpJTlBHb1Y5Q3dJWFlyYWZ4S1JWSHhLSXZqTEkveVZO?=
 =?utf-8?B?SCthN2ZKMDMwL2cwbUE5QWlJT0wxRDhpYVhhL3JmcXlVc3BYc0JHa2UwNi9M?=
 =?utf-8?Q?EeH8UU4yJhrqh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3JKcGR6bW5JV2ZuWFIwdHFLNXlWWWZKdmhWK1Z0dklwUVBoelBZUGJqbDNY?=
 =?utf-8?B?NDBYbVVuNGlic0t3MFphZ0JCUnpXR0NySVZ3aGEzbTlVLyt1RXJ4WEUvRHow?=
 =?utf-8?B?M1RPRGJ3YWRCN0YzM0YraUZLeWwxRldYZXo0TTlLRXgxVmtiQkhVRzdyR3g1?=
 =?utf-8?B?UFpaajdpRXVPSEkyMVNJa3VwdTRuK3NKRThZNm05MG9UMXBSajBra3dnQkp4?=
 =?utf-8?B?WFZmc3ZDR25BSzFUbSs5OFpSSjJhWVJ1VHhYRXBweHl2SVN1MGhnbC9jWTJi?=
 =?utf-8?B?cEpCZWs5c1NiZEt3cDJyOTRvTmVCRENNc3NZM2xVa0lJSTZnZFVLSndPN09D?=
 =?utf-8?B?RXhXazNENW50YkZPaDNNem1NTno0N0RnajdMa29VakRzNDdDL2JadzdVNFFn?=
 =?utf-8?B?MkxBRlBxbHM3WkdCZUZBY3k3ZThSMVc1TEFnQk5meVFDa1lsVDlMOUd2L2ly?=
 =?utf-8?B?ZXc0TjIzUml6clpuRUx1MnU0bEZzQzlnZUdEQmcvMUdDa0JEUjRtdGE0ZGZY?=
 =?utf-8?B?ai9qUUc1TXJjRmxTaVBIVHg3SkdMOXJQS2wrY3ZtQUl6VUd1aEhDZ2dVc01F?=
 =?utf-8?B?dnJ6Wm5LT2lJM2Y3S1E3RjlJZEJpUkl3djZLUm1nR0FhbGJPeFRiN2QyWEtG?=
 =?utf-8?B?MlVWNFVQcG5ENk5zU0NFejRQVXY1WFZuMHhRT2Zta0M2elV3ZU9ld25yS3N0?=
 =?utf-8?B?bW9yVDJiY0lSQ253aUdnbDdBZ1pxTEpKa09XVGRMRDRNaElEbm1ZTS9wU0RT?=
 =?utf-8?B?Z0VabDdJYjFickp0QkMzeUdTWTNsUVJOQXpmNjFic1N5cVc3S1NOb0Y3VTJE?=
 =?utf-8?B?MEw5a1dEWVpKTHF5eUtCUWQvOEZ3OVVlUjkzclkzclVjWFp0amM2RzJ6VU1y?=
 =?utf-8?B?dFlGQmhCbHB3MFNYRVpCNk5KN1FUZWRTSHpEbHZGck4rNkwrSE1ETGhaSk9I?=
 =?utf-8?B?SFhkcWErbU9QZzJXK2dZcDlTM0p3M09PMFlYTTd6ejlxYzZ6NXNSZU5ZMlhU?=
 =?utf-8?B?YkhsYWJZS2ZMSDdWRUx0MXFkR0g3UUsyNkJ3a3RCWVRRb2NPRngzTnRZZm5K?=
 =?utf-8?B?RUNVMkdGRWUyK3pYTlkvdFIrT01lVDJuTngwZ05kR3lLQlVWazJmQjZyZDZu?=
 =?utf-8?B?TjZmaVlJZVROdHJRMWJoTE4rMXdRZVV1emxUT21veDU4a1lJTXl6TERScFk2?=
 =?utf-8?B?LzZTaENPcmNXL2lES28rWm4ycmxEYTFQMVc5NHF1SzhLRktiRStJR1VkYXNN?=
 =?utf-8?B?dG82bW1CUGJUcmNONnVrNllDb1FaMWdIMytodGg3TWlqVWI1QmlGMHdzVkFy?=
 =?utf-8?B?eTRWaTFHT3h0M2kvYVlhM25YTWltbHp1b0tqQU95UzJqbkc1U0hTdjFpRUpR?=
 =?utf-8?B?VUwxMHA0WjR5ajZnTVRIOVMzNnBPaGJFYUZqMzBGL0xCYWZPdVFJZTNoVlJ1?=
 =?utf-8?B?UmpYTlVRNmcwVnBDeHlxL1UwRVcrczF1ZkRzQkM5c2wrUmdGVmsxODkxTWhR?=
 =?utf-8?B?bWcrQmhiQkczMUZGRjZ3N0V4MFFUZlMya3lsUW81MkR6V3gyYy9ITzlmVWEr?=
 =?utf-8?B?WWhZYjJjTjlFeVNja2ttWUlnYmduYmtYZTFGa0pRNnBNOVF2VThOZ0xLZlc0?=
 =?utf-8?B?Y3BqWlBFbkhBQmJaRzBsNURzb2xlWm9LRGVYOFRZeVIveTYzWnZ6Z0xLZUdm?=
 =?utf-8?B?YVFtOHBQVkE0bE5veEtzU3NSQUdzcVVIbFNmUDlNVHdnZ2lXTzY2S2NDV0Ri?=
 =?utf-8?B?SmtNRlRJWS9FeEQ2ZEdyZXJwSnpkWFlHTnhMNU5DMERkRmFyNFEzSVVDeXNr?=
 =?utf-8?B?SHFyUWdHdUd0UWFjejEwdTdBK29mQVMrd3poNDlWeTVCdDVpbjVqeUpSbzh2?=
 =?utf-8?B?ZldiUURYNUlmbTB1U3pEVGQ1eWlubDJBUk54ang4RFl5WGxRRXczZzRyUVpJ?=
 =?utf-8?B?ZDZ1TkpDY0JYSFlCQ01RYy9wRjJZMGtTRnI5K2h0ZEZneHFmNDRyZ0RpREFZ?=
 =?utf-8?B?UklrSkdFVHVZeWo1SkV4RXdBemxPSktJNXRZM1pCb1VLMWVGdkZlQTR6M041?=
 =?utf-8?B?N2xEaEl1bEw2UFZvQm94VjNBRTVJdFZHakpJZkNpWGRXMUhxSk5uWE5lMEty?=
 =?utf-8?Q?c6hUTBdpV31kBRpsKx4FFjRqa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7867c37-1d45-4a90-b9bd-08dd621ec528
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 11:04:06.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/Mfg6vUTVAxqEvIj2PrOmgYRvAjikAPb6B8naF82ydcn52duMD0SGy25RmGQu+ynyR2VSL5tMeon7Z2HzzGiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172

Hi,


On 2/6/2025 11:30 AM, Dheeraj Kumar Srivastava wrote:
> In cases where we have an issue in the device interrupt path with IOMMU
> interrupt remapping enabled, dumping valid IRT table entries for the device
> is very useful and good input for debugging the issue.
> 
> eg.
> To dump irte entries for a particular device
>    #echo "c4:00.0" > /sys/kernel/debug/iommu/amd/devid
>    #cat /sys/kernel/debug/iommu/amd/irqtbl | less
> 
>    or
> 
>    #echo "0000:c4:00.0" > /sys/kernel/debug/iommu/amd/devid
>    #cat /sys/kernel/debug/iommu/amd/irqtbl | less
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/debugfs.c | 89 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index 1377795814d1..0aff1d616108 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -11,6 +11,7 @@
>  #include <linux/pci.h>
>  
>  #include "amd_iommu.h"
> +#include "../irq_remapping.h"
>  
>  static struct dentry *amd_iommu_debugfs;
>  
> @@ -250,6 +251,92 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(iommu_devtbl);
>  
> +static void dump_128_irte(struct seq_file *m, struct irq_remap_table *table)
> +{
> +	struct irte_ga *ptr, *irte;
> +	int index;
> +
> +	for (index = 0; index < MAX_IRQS_PER_TABLE; index++) {
> +		ptr = (struct irte_ga *)table->table;
> +		irte = &ptr[index];
> +
> +		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> +		    !irte->lo.fields_vapic.valid)
> +			continue;
> +		else if (!irte->lo.fields_remap.valid)
> +			continue;
> +		seq_printf(m, "IRT[%04d] %016llx%016llx\n", index, irte->hi.val, irte->lo.val);

Can you please space between words so that its easy to read?

-Vasant


