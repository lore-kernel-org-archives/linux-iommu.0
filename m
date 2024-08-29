Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679BD1AC432
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935671; cv=fail; b=TPbxs1QHdTz/L2cqzscy7hrld0tYMxa/jLSBAIDEzjyBka3typ2qNZsic6BxdBV9Niipl7YLQLwfVEFJiIn2nzk68YO7oryoBYl6S81FVYqxB31eT6Xh9+kdMBrQjW/utggfYh8WfBu05KDTsY3gA+XyDKtcBbSn2Yp/O3iRQQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935671; c=relaxed/simple;
	bh=XFSWWYXBdXn5ND6qqa8B4QacDNC/15hXn1f4u1Hxg38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YyQ3VEzs27FfxGWwC1yn6v1QcNp/FRc3dHn/L/KakNDuD0Hjkb7amfQRcQrmJhF5AgpFjAElFODcaDrC4WNNbTVY1mwZyUX0CwAokXGboWAsQ7WbyvxtnnUGPVcxpfTompYxszwafKVgtjzxwWFq4eV3ofOuP1t4ChbyBeTEbKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lXowy6FJ; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lXowy6FJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSiJP57QcCa7w4iTkhLF5+1XrnrpIBgT982MIg9nWEQpEtvzVGq92CrrQD9xGVCk1uHa9VHTc41qMLQx/pd1CFQq2Z72MLFU2+f+gP3tDGxiiJ2VrlLE7RgckXKo/c0UDtk++81EP2sFX9g2qHbfUA7AqSt64YK+/pFeplkvOm2oi+lFjICAPVa4rcgHHak8Vu3UMAQWC0akvJIcEAFcU3G+Dc72xaQZQk+gk2q5zzHiR0W2BRlY6tDnwLACB5TSMciCbn5tDUUFKnAEe+aObYXKVAxR+ujNQj/xqwodfjeAitN4GIKQwgIWFdfPs4WnlSSgHkju0O7f7FgmAkj5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB0fR9Qgxf7gAAZxXCS4hyXC/KSAfkskQBmRb4oEq8I=;
 b=fjCBuRxatBTeGP/VaiSb+ipxszuIXo+Gm7uSR7oz/UFC/nZUlLp02n5lrrG9XqnYzwSSzlXEJ+X8Lte8uOz6RFqKr8HDO27rsEd6kCFkTgNhxtwjQHyL/BJ5WsRCxDaswJP2oaU0cPL7TN/tUYJ51FBs0w4lZaWslj+j8T6aOOgX5XjYNPdCr1caiqEF5ayOMVeaMZZcOSxnrtaY9Zs2Opnaz9E2bUbE/aoBkIc9NMP4WMqkzAxA176h1gLiWMHmj5OJazQo2jYEdM9aQ1Xo9MCMQdF7R9WBLmBLff/AzmhPDxfiyRoSIn8Wqx8Gu0baqpBIxVuCgAA3baOxQGT9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB0fR9Qgxf7gAAZxXCS4hyXC/KSAfkskQBmRb4oEq8I=;
 b=lXowy6FJ7/WGYZI2BxxmfAcTMvod5kp/zHDhBwGX9uzVjq7h+0tFTSVxBVVYXLuZDK4V9gJkQMoLF9T8JfUpmK2q2BApnZkyKuLB3MOYCF/t7b3SSCNiur+aIQKLruClk4xc+ZYFaOrGk87JADMKW27aisbBtWjwPyDmWVU/IzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:47:48 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:47:48 +0000
Message-ID: <b57b8846-9d13-4ede-98ba-2d09268c15ce@amd.com>
Date: Thu, 29 Aug 2024 18:17:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <67436cba-3d05-4528-9519-231b8396ed51@intel.com>
 <20240822124433.GD3468552@ziepe.ca>
 <0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
 <8215e4d4-2077-4fca-a002-27ddbfc0ddf2@amd.com>
 <20240828145224.2e949806@DESKTOP-0403QTC.>
 <6741bdcc-d9ca-4090-805b-3a7f4a4d650a@amd.com>
 <20240829121002.GV3468552@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240829121002.GV3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0216.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b82bae-27f3-44f7-9611-08dcc828c905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0lVUWYzSXMxczB1SEJoUmw3NmU1aHFzU3RZeWFpaUxUbXQyU041cHZraHdO?=
 =?utf-8?B?NHhWNVVnY2N1VUgvVnpWaGIwVjZyc2YxUU9VTlNMY2x1MitENERtYmUrYm41?=
 =?utf-8?B?UnF5RHJEMzRiaWFMOGVVdmdGNFNXTjcrSDdpa1ZhRVcvSVZGY1ZmNVJMbXBV?=
 =?utf-8?B?ZHVzeE1jSmlJVmI0NnltdjZkc3lwZDd5L1laUlcyaDMzZFl1cWVLNUs1Nllq?=
 =?utf-8?B?ZWhNenMwMHB2VUQvYk9qOWlyblNoc0lZcFZKUCtpVnlYM3lSeWdBcU5wVmdr?=
 =?utf-8?B?VXNuL0lwY0c4NzBRdHovbDdhU3diTm4ydXFpK2lPTjQ5S3JHUkt0eHJ5dUVs?=
 =?utf-8?B?VFJKekI4LzhYaWxqZS9LZlgyS3BMSEUzMENOdU84ZlpodnNTVjU5N1BUVDVH?=
 =?utf-8?B?QjYyM0IxdUJRWlRsQVQ4K2d2cjRLbHBXcGkrS2llWmFaWE0vU010RURQWHp5?=
 =?utf-8?B?azFtaG9MWnh1YnM1dHVlQzRYc3BCOGdLcG5kMEhuUFNYVHV3TXdkQWs2eVNN?=
 =?utf-8?B?cXBWeG1pcnZGb0FzOGovRlFKcUpTWWcrazQ0L1NjRzhhLzlhNFNuUlZNOTM1?=
 =?utf-8?B?YVBPNENNOHpzOENlTGc5Wnk1MFJvWnVYT09XUy9IeVgxdDNnY2dPbTBmTFQv?=
 =?utf-8?B?dW5lcmR6SElLanVISVVQdzdSRit0Z3RCUlc0SVlDcnZ5L2l1MUtURndyeWJT?=
 =?utf-8?B?Q1FVQVpTU3F1OXdGdTdHeTlCRWFpWHRmZWlaOEVWa1ZyR3ZjUlFIbVM2UzM3?=
 =?utf-8?B?NE9NOU45L3FaY0dUT0J2N2R5QkRTbHNlN1RaY0lPTlMzQlZaYkdZT0lCR2xN?=
 =?utf-8?B?dk05d1U2bTRLM0lUV2x4SWRwVkNnY0p3YmtQa2hramR5bXZXTkhPenFUc05J?=
 =?utf-8?B?ZW5NcmRodXZaMy91S1lOWkw3cDZCeVpPMlJBRWhuMnkyVXlPMyt1bE1EYzJw?=
 =?utf-8?B?dVB1bnJPczFNdTh3Q2NjVmNFZW0zQlovOWc3RFFzYXRkMXVjQWtxcVcxRDlr?=
 =?utf-8?B?KzBybEpoUlVTUEwvTmlJK1pLUHJTaVpCMEYvUzMrVzBKaUt6WlB0c1Zld2Nh?=
 =?utf-8?B?SWNPME5ZcmtjYTVnNDVvcHVSaS8yRFluWnhzRkx4cU1qWmt3QUhmczNkZ2k5?=
 =?utf-8?B?ZGpKempFeXRubWVER0pKSzVWREZZTWxuWlRPY0REWmxYeEQwU01ac1Y3RUd2?=
 =?utf-8?B?dVNpNVdvOGwwWEhFQ0xqR3dtMnI5MnVXWWxQY0NxMzVibEJTQkFmNHJjNXpn?=
 =?utf-8?B?aUNORlJBZmNZZTRNWWpBUS9MNEhsWHZjUVhBN2hQMHlMRER5L3R6VkNYUDhX?=
 =?utf-8?B?OXZpZmk3QjRnR1doeDJUUnRZbzZ4Y1lWaGVvWVNaT01KU2VUbm9MY2poWkZE?=
 =?utf-8?B?ckdMTEN1Si9QSm1RWHNGeUlWYmExVEszMUNyUHk0TlB3QXUxeW5nZ3RIVDNB?=
 =?utf-8?B?blNLaWRvQUd2L2lvWHlUVlVCKzdpc1RRdlVKWVRzczh1U20vdzdCT3RuWGk2?=
 =?utf-8?B?RjlkM2Q4Qlh1L3NCbWI3M3dnNmlOeCtIUVlJZjNTd0Y5dFQ0V2tOYjNFT0ZW?=
 =?utf-8?B?ZWYxM3F3SWJOb3dJYTFPdElRcDFudWpCa3czNWxPVTBlY2VUN1BtNWFBMzlZ?=
 =?utf-8?B?VkMwMHhma0NFMWlRR0ZHTGpENzBRL3lVTndyd1lhMEoyM2JRS2pQK2NQaGtQ?=
 =?utf-8?B?MEFKWEozNklsZzFpWVhMSDgyUjJmV1lCTzFxY0MvVEU4MTdDakpRT01jaitK?=
 =?utf-8?B?eHgwSXpyVDIzY3pEOVdrYXZqbWJ2OXFJclBaUEZQdHBJb0h3SDJUalU0Mkw0?=
 =?utf-8?B?OGtKcDFVU2RsRnBNNXFhQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytqcWkyaHByb011TnFJME12dUdpUkg4RlpYdHNJVmo0cVQ5cVMyY2NwWXJT?=
 =?utf-8?B?K1R0R0dlSWRQb0xyeFRjVFBQN1VSMnV0Szk5VndIZGFBRWwrei9ibWY4MDFE?=
 =?utf-8?B?bHhpa0JBL1d3b2RLR3RTdW01cUN3aDlpMmhtb3NMYkVES2EwSHJCRGcvb0hh?=
 =?utf-8?B?eXFVZkFJUnN0dUl6dXFaSFhhUmRKL0puWC9wczBkN0lOdEc0UjFtNDVBTGFy?=
 =?utf-8?B?M3QwV0JZN0NneGNSbFowUitNcnRwcmNFZW5LS0hYWEtQS3N2VDl4c3hoa21o?=
 =?utf-8?B?YTNUeithbkhxaUNqRVBWc0JKakZYNktKNVZoQllJM0NiNW03Q0RWZlZFRDZo?=
 =?utf-8?B?TnB4clNHei9UQnEva01UUElNMlluWVRxNEF0YWFyMWFBQXpBMnlxcDBxcnQ1?=
 =?utf-8?B?WGlCYi9vR0M5K0tsWHJ3aTBpNVpQUUdDTTBpWWw1R0J0TEdVVjFuTFNqZkhp?=
 =?utf-8?B?THVkS1lNYUlkbWlSRW1IOHlYaFUzSDZ6MFhIaXl3aGFwMzQvaHFHNXJqNTJl?=
 =?utf-8?B?VXRLSlk1TmFCUm5DRnVUOERySnV5UUZWcXM1MkdxS1lObGE2aWhlOFF6b0hs?=
 =?utf-8?B?Q3BEZ1hHajhUQ0dkM3ZVTHFVZUsrVXhEb2I2OFVLV2FvTzhGcTcvUjUyRXhB?=
 =?utf-8?B?aUh1czdTOE4rekNsNWlEcEszVm5ZSERjaVVWeGdlVXA5c2UxSWJWSmV6aTdI?=
 =?utf-8?B?WlRxRDRDb0MyMTZ4ekgweGU5dlNOeXBBdFhYWHR2b0RtOGdRK1RhMjUvUzhn?=
 =?utf-8?B?WTVHT1RoM3lKdUtmWTB1SFFnWkR4MWRhZGJqRlgzeGluRjVZQW1WYlBwK1N5?=
 =?utf-8?B?LzJvRkFxZE9DZ2U4RkpNZ3p3Q3FTanR6RjhlK3pyWkxTU3FVVWNKbXArTXV5?=
 =?utf-8?B?NGhId2w2MzdtOW53S2ZPKzZFSTBLZHg5Yno1bmVnbWtnNTMyRDRUTFA3amJW?=
 =?utf-8?B?NUNlLzAvYzIyMFQrYmZFWENWd01wQ2ZFSzBmODkvdmloSUNGdUxKMzNxSity?=
 =?utf-8?B?YTdhQ3JMcDVyVm4xeDI5S29mKzh1bExrVjlNaHF1eDNrc1NxbjVZQ1ZSeUZP?=
 =?utf-8?B?NnljZWxQYzl6ZjduYUc1bUJLSWcrZ0FwWlVSR3FqZ1dGTy9LZHFWYWdsejlw?=
 =?utf-8?B?OHBKRW52dms4Mm04ZTd4RTF6SE9teWhBSVFvdnRkSURiZVgrdy9WUVJETUM1?=
 =?utf-8?B?Y3lveDRvVjVmNHB6d0FRa1AzbURuci9ybEk2VFZ4ZnlOdlYyWHUwV1dqaWtN?=
 =?utf-8?B?d1VTbEcwRElHNndENW9OYVEySjZmMjEyd1JmUGtMMmZvR21qQVN4eGZZdUdN?=
 =?utf-8?B?c09sREsrSUxWWHJXUUx2MHlFM040VUxaUWd6Sk5uZVhhMUJadkp0eEJiMGJL?=
 =?utf-8?B?QXNnTENrdWwvZ1BUUlh5S0IzT2ZBeFNXNWlGYzZIWjBpS05zeTRZekpTOFpB?=
 =?utf-8?B?clh0dWQveklZeWl4emVIbi9MM0F5Vzl5Z3ZYMFJpdFNra3RRdmUweWhFSlJK?=
 =?utf-8?B?L2tpYUtUdElmUnBxK1NTVUxCM3VkSDl2empyZmQ1TE9FOXBxNWRuTW5KVU5p?=
 =?utf-8?B?QmFNaEtpZGl4UTAzSi8rM01BNDJTWlhWQU1aQXI5a2lGbENpMW1mZW1jMHk5?=
 =?utf-8?B?ck9ZeTZuT3R3R3FwaktCUldPV2VMeDI5OTZJTXJNaGEyaFJPUzBlMi9ZZFQ0?=
 =?utf-8?B?UmdaSVNkb3h4V3pEQTdiQm50dDFJZkhSbkRmaTVMWVc5c0xQT0VxRWlYbGZQ?=
 =?utf-8?B?aUNhVzRWTnBnUGxPMnhUdVNRa0NJYXhqc0UxT0tpYkkzbEVhSWx4bW93MGFa?=
 =?utf-8?B?VVBaTWE2NE51a1h2TTBENDMyZkZTWG54YVdjSUh6bVpJbTYrZW14ZUl4NnJD?=
 =?utf-8?B?OTZmSEYvMG1VVHpmNUhuTU5vV05lZ2lrazBIVXVHbDhrY0J3ZHhqZmxnU0hM?=
 =?utf-8?B?L0w2QjlIb1VUNzBuZmN0VHhhd1Z3aVNObHRTSXp1dldSb212QUxSNTgwWStS?=
 =?utf-8?B?TlhJL3IybWtDZlFBanRXWkpnUVE2ZVdTY3p0ZkM5aTQvNUVyWjR1U2tJd2h2?=
 =?utf-8?B?ZVFHWmRpL21Jc25sdDEwYVlIZE05dHRzajhBb3dCVVpUTlFmdnpqeTRpaW0v?=
 =?utf-8?Q?ggG7g9l1IxbIHTN5NTL71VUEp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b82bae-27f3-44f7-9611-08dcc828c905
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:47:47.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4l+PpDHJmTwGMFnPYWHHWSqZjtRSCsHlvCA2Ef3zG8wlBT4fl0pqHPvJOANnXDLRHwW8s5alFILbSPdgbvfqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123

Jason, Jacob,


On 8/29/2024 5:40 PM, Jason Gunthorpe wrote:
> On Thu, Aug 29, 2024 at 04:21:32PM +0530, Vasant Hegde wrote:
>>>> Note that when we use NESTED page table it will have both v1 (L2 /
>>>> stage 2 level) and v2 page table (L1 / stage 1 level). Even in this
>>>> setup V2 page table inside guest can support PASID.
>>>>
>>> Sorry I am still confused. So V2 can support both PASID and no PASID
>>> (untagged DMA). For the nested case, if the guest wants to allocate
>>> a UNMANAGED domain, would you use V1? If this code in [3/5] below runs
>>> in the guest:
>>
>> In nested scenario, Guest will always use V2 page table (and host will use V1
>> page table).
> 
> Sure, that is how it must work but..
> 
>>> static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
>>>
>>> 	/*
>>> 	 * Force IOMMU v1 page table when allocating
>>> 	 * domain for pass-through devices.
>>> 	 */
>>> 	if (type == IOMMU_DOMAIN_UNMANAGED)
>>> 		pgtable = AMD_IOMMU_V1;
>>>
>>> Hardware-wise, in nested case, can V1 be used in L1/S1 for DMA w/o
>>> PASID?
>>
>> Actually no. L1 (Guest) will use V2 page table. 
> 
> Where is the code for this? How does it work today?
> 
> I have the same confusion as Jacob where I don't see the driver making
> the distinction - ie as above...

Sorry. I was only thinking about HW vIOMMU support.

Today we have two modes:
1) Device passthrough : No IOMMU support inside guest. Host will use V1 page table.

2) Emulated amd-iommu driver in qemu :
For some reason (which I am not aware) emulated AMD IOMMU driver in qemu
implemented V1 page table. So if we use emulated IOMMU it will use V1 page table
in guest. But this doesn't support DMA for passthrough devices.

Hence it worked fine so far.

For HW-vIOMMU where we will have nested page table, Host will be in V1 and Guest
will be in V2 page table. We need to add few checks to detect and use
appropriate page table. It should be part of nested page table support.


-Vasant
