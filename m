Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E5D2DCF7C
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918636; cv=fail; b=F6oLvyB8Jc/U6hW+7Nu2tqLRwzkTwwDB9nRtnP3iRNErxlU/UXDdKJa9jeDYtu2Qmc1xZawMPZ1uHS+uPQYE5qitjpdKvCW2AtQ8m+kwpGSgbp0xh5pw7Mn4t2Dfw+ivN0cASDU1G0cf7FY3GgXBhWLypV9xpL60qmQPZ7pKaUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918636; c=relaxed/simple;
	bh=y6jnVHMnqLPK2H8/RD6SxW/63U9GIq9h0hpWffFmvNI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KuuqnksUnJOJ8NmGTk/wK8hu09Oj7N98udhKA0iP5c/LyLBFrWJ5xkFnnntGqMz/3wIEUsizB6RxB0GtonR/az/23W+boc9nUAW3Ydm7dFYFwTOnwoTcF2PFuhNi3CQm8VIZ8jf4F7BLBPPBwQ7WN4g7fEenlJ5kRabCdLZW+zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mwDNS2Gk; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mwDNS2Gk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzdUrGn4Grx1sbmMnokJGX30KtHLt9OsREZgU4ND+lJ5h/6cbN4LYzz/XFUjuJJWE10qoYJ+HnToqWOfb8k8uzyPEgksU+8vjm/HbMK7z976QjCGBqbohYGszGJLARLbWr/fOSqEiojbH3I1dLjRwLgtW+vSs689sLnXL5YKO6RNEfQ0gp8giHtZGE/4qyrmRZX4nTRgYhaAk0LmuyI/6cnF8ijXiDqtHYXc/zIyjjqgwz061vXoM0i6M5yACAKQeCw5iYRl+XiHA5cnMRYPwfCOPfWO4SeOe/XTXl6Qe+e9chxTUrNynBNrJiA7RJmAc1ttFZJ8b/wzCNX1TlmFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gp8Ffuvxp6MWZfcCna65OJZhcKLB/tMEAAVgfSFrMhA=;
 b=GyCwmhMfQIWqKveQDyyUETpPPd2bVpCiOc5aU4erft1Kipow9sCqc2ZZ49yg8GKtAf975kiHy4GnIGrRy7R7lnD0Y7wj7jfpWya9FfCMNpUjOH192YJhjVMQ+GljaAbVr2uOhrGsAO5JMpfv/c0ZONanzORVi3QLH9Xzv9KyUq1VD/w4Nefl9xZQcQ5VBESKsgIaM4Nz428R5eorFytj+uvLxJ10A8CZs+BYlTs4bm75q/nHssYbGrOauyScYkNxeP7VZDJvLgHCG27jQ9vbS7n96gd5bEottDkjOW1i6Pt+hStrTpH3MhajUqX03NwNcgRjWDvGivZCXJGEOJZwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp8Ffuvxp6MWZfcCna65OJZhcKLB/tMEAAVgfSFrMhA=;
 b=mwDNS2Gk5G9MtvjCvf5OXgbJ4qle/6eFtcfzFvEF4CbqkXVrTKsuky/oEcBSXdwC+gHSrbue3T6zFqZQ/nh7Lm/L69E2Le3AhlwlYOmdId1agZa2/P/eRSoGV0QF43iN4C2cs8ykvuUlniFKBZzVJpjBHXvLmI1x/h/iUYVuCNG4kGMOhZRrTOCFHngAuKB0ytl57HfEKmFpqJr0n2gkQ/Z3BunWFvdJcAm65LxCqk1tuscgQglvBgGkkUJEehW/Z9VvV1+cu0ZYHhVKLs4jscBEBRwkPvY6q2D84cn7GPROBkI6jQQKQwrkcbQjYNI9nuTyjQiVPfsEFChaKQXB1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) by
 MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 13:23:50 +0000
Received: from DS0PR12MB6606.namprd12.prod.outlook.com
 ([fe80::ee84:cbaf:9af1:3f5a]) by DS0PR12MB6606.namprd12.prod.outlook.com
 ([fe80::ee84:cbaf:9af1:3f5a%6]) with mapi id 15.20.9009.016; Mon, 11 Aug 2025
 13:23:49 +0000
Message-ID: <4cf15e68-9b1b-4c49-b247-38d0a7d10b5d@nvidia.com>
Date: Mon, 11 Aug 2025 08:23:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/2] arm64: Add encrypt/decrypt support for vmalloc
 regions
To: Mike Rapoport <rppt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Steven Price <steven.price@arm.com>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, Gavin Shan <gshan@redhat.com>,
 Vikram Sethi <vsethi@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>,
 Dev Jain <dev.jain@arm.com>, David Rientjes <rientjes@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250811005036.714274-1-sdonthineni@nvidia.com>
 <20250811005036.714274-3-sdonthineni@nvidia.com>
 <aJmvFz-0xlfS2B3p@kernel.org>
Content-Language: en-US
From: Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <aJmvFz-0xlfS2B3p@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To DS0PR12MB6606.namprd12.prod.outlook.com
 (2603:10b6:8:d2::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6606:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc5a1e4-7664-4c5b-bfad-08ddd8da4f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk5KWHJTRW1QQk5pdkJEWmVBQ3pUTnIyMmJPajJRMkJpLzJ1MlRFT1NQNW4y?=
 =?utf-8?B?WTJ3NDJGeFV2eWpPVlhtaGtEdHFuRmJjNG1JVW1DVU1QaTIyL1V2MS9IMHIx?=
 =?utf-8?B?bXdiSjdFMFNEbmo5QnU1OXpPb3dOdGZoMG5QNkJlQmJtOXlOb0VXaXpYVW5x?=
 =?utf-8?B?RWRZc2djOVZocnVPU28rQ1NJVmtoODF1b3ZFWVQ2dVkyOTdYZUhKTjNIekZ3?=
 =?utf-8?B?ZHNkNFRPSzJFSGpEZlJZMFhTOVVxWFkrcC9NYjNEWmN3M3hLdjlqRndLVVVC?=
 =?utf-8?B?RFYvMGZ4RldCVThrYUQ5dk1HNTFEVHo2eWVZTUVKc3FDR0tUWmtLS1EvRGZB?=
 =?utf-8?B?TlJxcnZwVytGb2hjQzhhYkhoS0ZVRGw5ZitLd1VGcWo4bUVyc1lQZUc5TllU?=
 =?utf-8?B?YWVFeDN6bEJqOG5tWlIyTjVzUTRuQTgvTGhGbkNjZTJFM2pIYzVZYnRsM0tC?=
 =?utf-8?B?bXZONFphUGlNWTFOOVFjeTZnYmNhQ2FMN1NGTk5HNGlIZWtCMFNIQXUxYzky?=
 =?utf-8?B?SzR5K0xFQ3I3c015aWVnRjdkSU8ySEZackpId1JOMzVpTXBYMnpxekJCbm9P?=
 =?utf-8?B?K2hNVnI0S1hqRmkrT29NU1hpa2JXMWxCVm5jMUlKQ095aVUwU1JCbWtZVm9B?=
 =?utf-8?B?YmJCK3Jra2g2N0ROdXJnWE02S0FOc3lJN0laUVpjb2wvVGVsM2FaZDIwYjZO?=
 =?utf-8?B?bHdEcFFvcnZ3ek5ZbzUvVWd1R2RXNGZPQnFSaFNPVm4zdzZBdkVWTHlvRnBX?=
 =?utf-8?B?R2tHdHFjelpMSzdUb29EZ05hQmk3OEtBV1NEamJTZHdobHFyRCtKN2hici93?=
 =?utf-8?B?UjI4WWszL0dDVjBzNHlSWU80bEhDUWxvQnV0a0czNWNCTytXaEx1RXladk1v?=
 =?utf-8?B?Q2JRcGJEZ2VMUHB3aEM4VXRJY2drQ1pORmFTb0laQUQ2OGdtZmd4Qk5hVDZG?=
 =?utf-8?B?V3RYS01KbzlrMVhqbmZwaHRrdVdEQ3RucmwwRjJKVWV1UlRqUkxyWEE2eDN4?=
 =?utf-8?B?SGdyZWNDRDYrekxvQVFWTXdPTVA1R2hBajRQWmUrWXdHc2lMajJJNjEvOXo2?=
 =?utf-8?B?OHBkcGVNM0sxU3RpcVRLQmo0NUFBbkoza0dIaXBFbUhzKzVSemZ2YWgycE1j?=
 =?utf-8?B?ZHRuT2htSUUxaEtiN3AvOEx3NElmVGRRK09JVlMrZS9Md08wYmpCL1NSZUNM?=
 =?utf-8?B?bTJPd091bGt4aFJ5TXpHdGN3dk0rZXBSRlRMdmg5ZGtmRS80YTdwS040all0?=
 =?utf-8?B?bi9yd2FmRDE5R3ExanJwUHUrQ3h4OU1IRSttMXhoZEJ1SVU5ZUFVLzBzcUgz?=
 =?utf-8?B?Z1piVGxLRHBEOGdYdmlRdkZicHFyTkpKTnFURXlJVU5mZUhHVHpGWGFoSWNn?=
 =?utf-8?B?Y1h4dXRUc0tsU2ljNU5xSFEzaDAwdTVRc3JNOXZBYm9sZEg4c2I5bU04MVJI?=
 =?utf-8?B?ZVF0MHd3YWE2Q1drTHMxN2UrZklWZ0dVMXlGc3ptZ2x1c3Q5NzdwUzc3WFl3?=
 =?utf-8?B?dVRBQTlWMWNPY2txclEvRzcrOFk0cHB5bCtqL1Z4c0w5MDJJbmw0bm9zTTZq?=
 =?utf-8?B?bFFkRmNWUVVCNmV6TVo3NHVSL1hIcjRObkRETlp2azB1cEdSWXFPNnR2V2xm?=
 =?utf-8?B?ZjVFZDBtU1N6M3dKYXBCMzlJSmplc21wTGJydzlhNXV4dmVublN1OTBtQmwz?=
 =?utf-8?B?Z2VpMndQYkwwM3JTcW1wcnBMenBpeTBWY1A5OEhjRGxnaWR6ekc2bHlPbXdH?=
 =?utf-8?B?OFA5dnExTU1SRzB0TVhvSFNqYStHNEVOVlVFdmYyTVdkbUltK1l3Mk9tNWZU?=
 =?utf-8?B?bXpwV1NXVEIxVWZCYmpqQ0U1TUxwa0NHY3hSV3pQNzhYcVBLbHZtY012MzVm?=
 =?utf-8?B?bERQOUVGaW0yK3NsTmZqVE9HTU5kNFYxK0JnRXJ5N1lEdERxUENDNlBWUmZX?=
 =?utf-8?Q?KhzjUVr6rss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6606.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHUzcGdTTDduc3ZiRU85dXBJc094NVR0ek4xd0lmRThIVXdlR011OWh0WHhl?=
 =?utf-8?B?bENrQVNOYmh2dzE2Y2lOb1doTzA0T0pvUm9YbTJ0ZnhXb3RIK1Uyb2srRU53?=
 =?utf-8?B?aFQxdHBuK2VabDVRSkF1YzljZUs1dDZZVnJkWXUwYm1iQ0ZEMjdyemFvVlhH?=
 =?utf-8?B?OUMwYXZ3VDdTM2xzMS9JNnJlZDFobDdIL1VlQTExbUhqaS9jRFlmc1VyaDJy?=
 =?utf-8?B?S2p1OWJSSm9xS3JUOGN3SWFNZU1MYkxOL0VkV0tlWDliZWNPeUVYOUlaTStV?=
 =?utf-8?B?K1o5MUpCbXFBS2s5cWhXME5JR0M0eTBSYzV1VWFCRG1GRmlhVWRqRnpkdzRI?=
 =?utf-8?B?Y2lVai83a0c5bGY5L3pUNWdZUmh4QnlKaFlwUGE4bEtWc1NtbUhKL3M4blY0?=
 =?utf-8?B?R2FGZndIYzRGYWlhRGl4bjQ0MVdGdjI1WDlOWUJ4clJyV3hKd0JXRzhXQVgr?=
 =?utf-8?B?ZjFGWG8wa1hla3M2aWhqTVhaQXcwVHBTTmNIYXE1dHphYW5HdldnREV1NURH?=
 =?utf-8?B?SVRyQUtqNXJXWjFnaTZ1VTRGWG5yeHB1MkZlMU90dTJrdG9peElzbWpGSWV5?=
 =?utf-8?B?NnlJOXoxc2hoRGtkV2lCUUNpMXUzWFZ1cDNRU3ZPNkdrZHpPTXliTlNZWGk0?=
 =?utf-8?B?WjRrako3bmRwQy9jZ2dxR0FVOGQ0Q0NlcmtpbHdLWkhKY0pSTWMxcGFSQ3da?=
 =?utf-8?B?TVliK1ppZ3dGK2MydUhsUGN1YWx6a29nWnpvMlozRGtXQU1FV25GalBYT2xB?=
 =?utf-8?B?dldzSUhXd0x2MC9uQTBzUlRHSVpNNnBxWTRDMTFNd0ZoMnFLRlV5ZkVyNXR6?=
 =?utf-8?B?ODV4d1ZnSmd1a3YzY1ZQQTRIdnJpYjVGRytrdWg0S2NXR1NQWVFycXRNcERv?=
 =?utf-8?B?WE1tb3hFYTVGTUZEVWRCUlNjbGV4bnl4TVlQVEFXMXlhR0FpcnFWNkdwMGJI?=
 =?utf-8?B?Mjd0eXZSZHlqVTBjSHl4ZUhoSUt2bHlYanJYSGcydDVzbjdKYmRUVFB1QkR6?=
 =?utf-8?B?TmVmbUtTYlRXaWg1RG9jUDNkZTc0SG5BQjFzRE1PMUdLYmtUREFaMEZ3Sm16?=
 =?utf-8?B?MWljZGRiVTZEZjBxTE5kaDhKNUJNNTFhdWlUUVdMWFI0akF3dFoyalBPNDdt?=
 =?utf-8?B?Tkp5cjduZzlFdlJxaitNRlROUUxKMUl4UkMzUDYrb0VNL3NMbVBiUzQ3emRa?=
 =?utf-8?B?NUZiZ0xuMmVkVkxScm54QmVFL3hLMno0U3ppQUJCNDExZW80ZHdNd2gvU1dm?=
 =?utf-8?B?b3BCZm13T2lqRHBvRklmWTlQRFRvSisyYk9ITHlDc1lqRlFNekJRaHhaeTFk?=
 =?utf-8?B?YzZaeXoyYW01WEF2UExzN2M4dUVMMDRCdTVsSHp6WVJhaGhiYUYrZWo4OFRC?=
 =?utf-8?B?MjkrMzlqcWptMURFb2k2ck8rRGdpQTBuSHhKR1BIbklGSS82eXFyK1h5blgw?=
 =?utf-8?B?VzE4K3lSZW9XdnhqV2pjUXdTVEN5azNEK2JJQndRYVBINktwWm9BeUR0a3ll?=
 =?utf-8?B?bDR1VzNiYklUamFlUngwRXZkeWxQOXhSdUZiVkpPV01Pb2w1WE8vemVKM2d5?=
 =?utf-8?B?RlNOQVZUVU9ZMnZPWnMwUkg4WU5remdINlhYM3k1dzUyMW1KT0N2RWJzYmZR?=
 =?utf-8?B?OGpPdlhiZWdCY2tnWkFIUmZTNDI0U0NIMWtpOXNKUlYvQkkxcTFNcExnajRE?=
 =?utf-8?B?NVRVREJlNGhzck5rODhqeXNIVWJDZjZhZkF0bmcxUVNPekNtK3Z4ZzZvMzlu?=
 =?utf-8?B?OGRXS216RVpMYzdRRW9NcWNNbFRmMjhSSGpBK0t4bzloT1Q2ZmtRVDFOM3Vp?=
 =?utf-8?B?aHdpQkNNR1MxU1JhRk91U3BXTlQxUTdQSDc2amJjK2hTOWVRVUdKNmxNQWVz?=
 =?utf-8?B?TDN0YXdaUzJqSGtHWm1GOWh4elNJTFJUUEMrR2E3RlNuUEorRnVsSVhTWGpX?=
 =?utf-8?B?SmdYUjVhU3dSYkpuc3Voc2MwMlJsQjVjdDNsUTN5Zy9ueGlNYUh0RFlHd3Uz?=
 =?utf-8?B?dGU5cTk3MXhOQkYveEpMelJqZkFNS29HL1IzZTlYR2VJUlJ1eXZSbVB6d1Fs?=
 =?utf-8?B?OS9PNGtJaUc4MmlBN2tkRXBjUkpRRTNORWtGOWplc0o5VFdFb2JBY2FJMlc4?=
 =?utf-8?Q?P8fDraYZRp/T2m2CPGGs2bw1w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc5a1e4-7664-4c5b-bfad-08ddd8da4f09
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:23:49.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfZFbi3B2USvkR/qimSMhj6+c48RLl1BHnzK0kOdRTklcE6L6L6Ut47RtOxciHPFIg/YDcPAO+4l5gMWvl0L+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

Hi Mike

On 8/11/25 03:51, Mike Rapoport wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Aug 10, 2025 at 07:50:35PM -0500, Shanker Donthineni wrote:
>> On ARM64 systems with CCA (Confidential Compute Architecture) enabled,
>> the kernel may need to change the encryption attributes of memory
>> regions. The existing implementation of set_memory_encrypted() and
>> set_memory_decrypted() assumes that the input address is part of the
>> linear mapping region '__is_lm_address()', and fails with -EINVAL
>> otherwise.
>>
>> This breaks use cases where the memory region resides in the vmalloc
>> area, which is mapped in non-linear mapping region.
>>
>> This patch introduces a new helper, realm_set_memory(), which detects
>> whether the given address is from a non-linear mapping. If so, it uses
>> vmalloc_to_page() to resolve each page’s physical address and applies
>> attribute changes one page at a time. For the linear address regions,
>> it maintains the existing fast-path.
>>
>> This change ensures that encrypted/decrypted memory attribute updates
>> correctly for all memory regions, including those allocated via vmap(),
>> module allocations, or other vmalloc-backed paths.
>>
>> Call stack of Realm crash, QEMU hypervisor + NVME device (emulated):
>>   ...
>>   Freeing unused kernel memory: 6336K
>>   Run /sbin/init as init process
>>   Internal error: synchronous external abort: 0000000096000250 [#1]  SMP
>>   Modules linked in:
>>   CPU: 0 UID: 0 PID: 64 Comm: lsblk Not tainted 6.15.5 #2 PREEMPT(undef)
>>   Hardware name: linux,dummy-virt (DT)
>>   pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>>   pc : __pi_memset_generic+0x16c/0x188
>>   lr : dma_alloc_from_pool+0xd0/0x1b8
>>   sp : ffff80008335b350
>>   x29: ffff80008335b350 x28: ffff800083162000 x27: ffff80008335b3c0
>>   x26: ffff80008144f000 x25: ffff8000801a27e8 x24: ffff800081e14000
>>   x23: ffffc1ffc0000000 x22: 0000000000001000 x21: ffff800081458310
>>   x20: 0000000042a40000 x19: ffff00000232fcc0 x18: 0000000000200000
>>   x17: 00000000000120c0 x16: ffff0000795520c0 x15: 0000000000000000
>>   x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>   x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>>   x8 : ffff800083162000 x7 : 0000000000000000 x6 : 000000000000003f
>>   x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
>>   x2 : 0000000000000fc0 x1 : 0000000000000000 x0 : ffff800083162000
>>   Call trace:
>>     __pi_memset_generic+0x16c/0x188 (P)
>>     dma_direct_alloc_from_pool+0xc4/0x230
>>     dma_direct_alloc+0x80/0x4a0
>>     dma_alloc_attrs+0x94/0x238
>>     dma_pool_alloc+0x128/0x258
>>     nvme_prep_rq.part.0+0x5f0/0x950
>>     nvme_queue_rq+0x78/0x1e8
>>     blk_mq_dispatch_rq_list+0x10c/0x6f0
>>     __blk_mq_sched_dispatch_requests+0x4a0/0x580
>>     blk_mq_sched_dispatch_requests+0x38/0xa0
>>     blk_mq_run_hw_queue+0x288/0x2f8
>>     blk_mq_flush_plug_list+0x134/0x630
>>     __blk_flush_plug+0x100/0x168
>>     blk_finish_plug+0x40/0x60
>>     read_pages+0x1a0/0x2b0
>>     page_cache_ra_unbounded+0x1f8/0x268
>>     force_page_cache_ra+0xa4/0xe0
>>     page_cache_sync_ra+0x48/0x268
>>     filemap_get_pages+0xf4/0x7a0
>>     filemap_read+0xf0/0x448
>>     blkdev_read_iter+0x8c/0x1a8
>>     vfs_read+0x288/0x330
>>     ksys_read+0x78/0x118
>>     __arm64_sys_read+0x24/0x40
>>     invoke_syscall+0x50/0x120
>>     el0_svc_common.constprop.0+0x48/0xf0
>>     do_el0_svc+0x24/0x38
>>     el0_svc+0x34/0xf8
>>     el0t_64_sync_handler+0x10c/0x138
>>     el0t_64_sync+0x1ac/0x1b0
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>>   arch/arm64/mm/pageattr.c | 55 +++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 48 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 04d4a8f676db4..65c3322a86b49 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -202,21 +202,26 @@ int set_direct_map_default_noflush(struct page *page)
>>                                   PAGE_SIZE, change_page_range, &data);
>>   }
>>
>> +/*
>> + * Common function for setting memory encryption or decryption attributes.
>> + *
>> + * @addr:        Virtual start address of the memory region
>> + * @start:       Corresponding physical start address
>> + * @numpages:    Number of pages to update
>> + * @encrypt:     If true, set memory as encrypted; if false, decrypt
>> + */
>>   static int __set_memory_enc_dec(unsigned long addr,
>> +                             phys_addr_t start,
>>                                int numpages,
>>                                bool encrypt)
>>   {
>>        unsigned long set_prot = 0, clear_prot = 0;
>> -     phys_addr_t start, end;
>> +     phys_addr_t end;
>>        int ret;
>>
>>        if (!is_realm_world())
>>                return 0;
>>
>> -     if (!__is_lm_address(addr))
>> -             return -EINVAL;
>> -
>> -     start = __virt_to_phys(addr);
>>        end = start + numpages * PAGE_SIZE;
>>
>>        if (encrypt)
>> @@ -248,9 +253,45 @@ static int __set_memory_enc_dec(unsigned long addr,
>>                                      __pgprot(0));
>>   }
>>
>> +/*
>> + * Wrapper for __set_memory_enc_dec() that handles both linear-mapped
>> + * and vmalloc/module memory regions.
>> + *
>> + * If the address is in the linear map, we can directly compute the
>> + * physical address. If not (e.g. vmalloc memory), we walk each page
>> + * and call the attribute update individually.
>> + */
>> +static int realm_set_memory(unsigned long addr, int numpages, bool encrypt)
>> +{
>> +     phys_addr_t start;
>> +     struct page *page;
>> +     int ret, i;
>> +
>> +     if (__is_lm_address(addr)) {
>> +             start = __virt_to_phys(addr);
>> +             return __set_memory_enc_dec(addr, start, numpages, encrypt);
>> +     }
>> +
>> +     for (i = 0; i < numpages; i++) {
>> +             page = vmalloc_to_page((void *)addr);
>> +             if (!page)
>> +                     return -EINVAL;
> 
> It would be faster to get_vm_area(addr) and iterate over its ->pages rather
> than call vmalloc_to_page every time
> 

Thanks Mike for suggestion, I'll do it in the next patch.

>> +
>> +             start = page_to_phys(page);
>> +             ret = __set_memory_enc_dec(addr, start, 1, encrypt);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             addr += PAGE_SIZE;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>>   static int realm_set_memory_encrypted(unsigned long addr, int numpages)
>>   {
>> -     int ret = __set_memory_enc_dec(addr, numpages, true);
>> +     int ret = realm_set_memory(addr, numpages, true);
>> +
>>
>>        /*
>>         * If the request to change state fails, then the only sensible cause
>> @@ -264,7 +305,7 @@ static int realm_set_memory_encrypted(unsigned long addr, int numpages)
>>
>>   static int realm_set_memory_decrypted(unsigned long addr, int numpages)
>>   {
>> -     int ret = __set_memory_enc_dec(addr, numpages, false);
>> +     int ret = realm_set_memory(addr, numpages, false);
>>
>>        WARN(ret, "Failed to decrypt memory, %d pages will be leaked",
>>             numpages);
>> --
>> 2.25.1
>>
> 
> --
> Sincerely yours,
> Mike.
