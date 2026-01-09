Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E233345B
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952070; cv=fail; b=lcF9G5I7OX8UcC6CQbryC8Q7M6K/+eQTU1TJkrUxOEZ43S079ZU+vOlbb8Wt3QSl/1SKiocVVHzKhALW6c/ea0zKw/wnKS50Yjb5Ri0Dct+/Z9bbzx6JeH1y5YcuHk3SLpk/vED0Gh9LKPY68OjnWgtQQZvkEWkpSL31QiA8Hv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952070; c=relaxed/simple;
	bh=mQrAdTcM4OPP/JKAXvsJN15WgvWkHwfOfa4kE8oXiWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DevWoRe9U4zYS1mSgnXIpFbUmPU0JIMPurjdgiCJVxWguTGYoGe7JUgCyBw+mI6X1v2I7oUe/xChixqID5pz7QWfEc4kIAjhFpMv+QutBjOyitHHKMG3SX5WMz9G7OiH17JRdaU5BGxuJ1ka+DRhU2ui/D7ClRqpOAbBVxEmBck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BiT5S3Zr; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BiT5S3Zr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDHqL1u9/KaGVhdN8iYEQtut51DjvjVstXHBw1hZgDV7zjNKUGNepqUqyaviReodQE8iEpRwDltFVysmBnnXC/z6/KERc7isg0EQJ0qTotcXiEilZ9FwA7oZgadytgIIEqnBMA4Qe/PRIDZpVcMqQDHGOCmdfetfg2eePRYbsbQ/uRUPYtaRXCDNTNFul5wqXv6pPE+ssMDNMeP2DZ5COXDuRIUK45qb7TAxbI+1gxh05P/xKcuplFBFf0yk4d4N94hrrg2lILrEngBLrTrLF+VIuC0+jpNMLRE63SFCDF05MbiKzYgmhT0FAdtwMJGSuRMXg2okJA3SEBf36KFzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3bapScb+AF1e58JfR+ufYeYWG7Mv0iKpaT9BZpKysE=;
 b=VWBagLl+VTwCpnpPtOmgzVSF4Lw2EyB2npHc+UAr+40a376GGEvQud48shv88LbN8FiRrTmdE5KkgI7YQItFnx1SXoLFNtcYrggpLA1DRq1ctDK/GWlX0hNRVPj+sN1gy8cxzt5eYpf2xvgcNvE4H4v4llyTR+hv34IIhRXMpDqoeCgdTXbHgIUL8FTzEitO9c1HmgjVnzj6OwR13t4adYNx8Rjl68J6qMFNjmMcfo31GKgbPAB5Wnq3IQdMvAZuTm8Ugew/Cg7KDH6y4fE4m4vwE6MNOWAS6GtX2zCoro4Mzs7kLDMcROsse4Qk1BlNXGLIaZw6FtBzEycr+qYeMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3bapScb+AF1e58JfR+ufYeYWG7Mv0iKpaT9BZpKysE=;
 b=BiT5S3ZriczCxB3wO+5G6la314Cw3Yyp0xeRSwD0BJJ0XQA3H1oWb+NxL87SJvTAfuzosWVXc3ey0RbdZIAs1ZcqbtD4JrNKC9M6Rgd2vylvb6qzhzLoGgbOBv2E3Kq8GGPUvM+zWLwUNuTFwD1gTbuk5ycQBiZ335WGyZYf3CsFLZFZVzE7dhakOZfVHx+ZuodpfdJTavocm3DqdlPGINZaGFywJzuH5mBJg7XwW2+niA6PCeVr+ImAm0kLv9v8Zo16uofutamZmEJwcQ/yFayygZA5AmQ5TZANqJLHlxQpqU5OiCfWngXjz+XyCYI5eW5C25lThhWhGSk1I8sMLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 09:47:46 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:47:46 +0000
Message-ID: <4488ab67-8d41-4095-a1b3-a109e6392890@nvidia.com>
Date: Fri, 9 Jan 2026 09:47:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-4-amhetre@nvidia.com>
 <fbde672b-611a-4d81-ac05-44e434bf70ae@nvidia.com>
 <38364cfe-8fc9-4ed7-9034-4e67584ee965@nvidia.com>
 <9c13e838-6fe5-433c-b361-7d19d1b2ce1e@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <9c13e838-6fe5-433c-b361-7d19d1b2ce1e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0383.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ed3d18-f15f-4e6f-3438-08de4f642446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmpMcFNBcngrQWJDNTMvS3Blc0FnWS9nMlBnMTJOMm1FS1prWEhpYkZaa3VC?=
 =?utf-8?B?bnQ1SkgwWHRzRGhXcjZXZHRoUDFuRE1zYmdEbTJjRjZGSmVaZEhTMkhzNzZv?=
 =?utf-8?B?LzJrd1ZZWkJBZ2hpYURqc2pDSlBCVU56VzFtandkL1owNzZUbzBtekE1OXhu?=
 =?utf-8?B?UU1aeEZJRVRSY2VrQnEvT0EreXhGUGF1eEZoQ3VNUDY1NnlVajFsQ0YvL3Vj?=
 =?utf-8?B?UEhpMXlmenZENGxzL1RGVFJYL3ljRFFYcU1sdDd4dVJnQmNjOGFETXl0OS9G?=
 =?utf-8?B?TlE3U2k2U01qdHljcm56YVQ1RzdMcFVQQXpWR2ZDMmhFSjhZbzh4T0JtbUdz?=
 =?utf-8?B?Ti9EYmZhUW5vZ3RiRVYzdVNnUThhZUkvMGdxTjZLOW01NzZZU2VlUmRlTUxu?=
 =?utf-8?B?UWp0S2kxOFk4dHg4WTFIZTFSZHNua3J1cVppQmZLdXR3T1A0WUYzNlZhenBV?=
 =?utf-8?B?dFd6WGlHSkZWSFB2WFU0Uyt1aVQzQk5pZ0x3QWtpVzQ2Wm9PamlWWUdIOGQz?=
 =?utf-8?B?VTRDUFZ3V2lHdmZOc1JqbXRYbWIyWGhKK2JEblByMVFNdU5tNDhCb1hBWVRr?=
 =?utf-8?B?R0JqYnN3K1pwWEM5ZS9XSGRMZDlHc250UXBYTnRQRE1jcmx6amdUZFJ6bkt4?=
 =?utf-8?B?NFdPVytKWWZFcTloZUYvemJTUzBCYm4rQmdGSFUyMFZnOW5vcVNRUHd2a1Rk?=
 =?utf-8?B?RnJzbmJaNU1rM0pab0l2RTBEdjlTYUVBcVZCSlNMaXJOSVkyNlczckhSZ1V6?=
 =?utf-8?B?VFg4OTNtYzI5a001Z3B3bFZOeDR5QTl1VkdmZ0RjeGY2dG5DdWdVdUdVOHlV?=
 =?utf-8?B?N0RDc1pKYVhDck0xMFM5RzBiRVEyRFNab2dkekxDdFkxYkdGYW9Hc3BpTzZC?=
 =?utf-8?B?bUg5cEdBSEd0Qi96YndQTnNxWlhvRmZWekVVTUdHYzY3cUtUL0ZJL09zNXpo?=
 =?utf-8?B?SUx2YjhTNlRHY0FhWEswYUFQSVFad1N1TjJyb3p1L0pBb1A4Yzg4dGdHREdB?=
 =?utf-8?B?UFRicGZWU1ZZVnFyaWZBMVhpMkY2QkE3RlFod2FoQ0VmalIzeG9wbXB6Z0pN?=
 =?utf-8?B?akxBRWptNUZmVzgyQmxra3VCK0dybUQxMEFTcktCZFFIeUl2L3dsR1I3L0RO?=
 =?utf-8?B?bllnWHB1WGk3Q2JReFc0dHA3YythRkx1M21wN1BlVGZCSEUwQmgyakNlV1E4?=
 =?utf-8?B?ZDBjNjFpcnNlQSsyNmEwSXlZeUJVcmptUHZML0tyd3hkVlI1aXFxZHFTMm1x?=
 =?utf-8?B?OTB1VFo3UFJSc3RIOXdvaXl4R3A3L0F5T0ZJVWo5cThLSkltK2cxRDhZa0l3?=
 =?utf-8?B?aUo3YU9YamhCRXBPVGNqakJJcXBrb2M2Z3ArL1FvVFlWQkswdlc0Qi9VSFor?=
 =?utf-8?B?RVFkcGMxVFd0ZmE1amY4cUpQUS94Ni9VZGhrcS9DNlVkWkVtNjBvdDh2NnBy?=
 =?utf-8?B?K2FhQzJvSnhtYnh3TXZpbnpsNFJPNCtveWFNalJHVm1LdkxkUlhrdnlEUWI2?=
 =?utf-8?B?aEFBNUNXSFhxQ2cxajJDelYrUUlXeVljdFJFVUUzaDZ3eHZZcGlnVFdGa1Vl?=
 =?utf-8?B?N0VJUFBudTUxb1gxUU9tdVo3U1dReHhGN0NOZExZTFBKVzRiRlc2NHBuOWV6?=
 =?utf-8?B?RE1OUFNJSFV5QjVDSmwvVVp3SG1PTWdrYTVtSG1VbG43bGVQbVFDUHdwNXl6?=
 =?utf-8?B?ZVNyK2JEVnpWT2JKcURrTTZBcTA1VWFtVWtsQWQzNGlqeWZCT1VVeVRLa2Fk?=
 =?utf-8?B?VW5Lc3FvdmluTXlSL0RnbHNRbWZ0bzVpWTdRbmdTb2loLy9tWFJHdUZHT3pY?=
 =?utf-8?B?U3lScFNBcWFJaHYvWDQwRlVZVnpoN2V3aFI3YWo3eFo1RWlmL0wyNkhpaEg4?=
 =?utf-8?B?bHl4bElHMHplN251USt2Y1dCTzhCNWlpTXhqaGtMZGZUS1EyYjU2RFZqNmRl?=
 =?utf-8?Q?8PYoz8JKV0NaNIaIXc6E/zDAkMJrjj+L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnMzVEJmQTcvNFNOcXJhenhFUk9jZWlpdEs0Z1lGQSsrNVh6RHZXQUltUjBs?=
 =?utf-8?B?Vmc1TVVNK3VnK3RRRHJ3bmh0aUxFdkVxSWMwS2c5Wm4rbkU1WlRYeVd4cjFo?=
 =?utf-8?B?aURCNUFNNmROZDArS284Rm9Db00veExzNzducGl4Z0ZlakgxZ0F4QnhBa3Rh?=
 =?utf-8?B?d1FFcmpFWWQ5WDhZcmxhaXp3VVkwK3AzM2w0QXdTS2t4U2RtNDZqM3N3OU5i?=
 =?utf-8?B?QkxsTTVtSUtPak1vOEZHeHV6eERCMCtEM0l5NlJCK2xUZkhJSFdFVHA3elMw?=
 =?utf-8?B?VGxhRmpGTlQ1RHVhM2FXaW1qRmxvMXdDZnNlOExuZ1RJMW1GLzNNWGMwQm42?=
 =?utf-8?B?ejZtK1lJejlFT3lZUDVNeUUySFJ4elR6L21jay9EQ2JPU3NoMXROVm84VnJl?=
 =?utf-8?B?djlyRmZ1bXZDWFpIUVRQS0s2QjlROGJNb0Yxa2I5L1ZCZUtqZmJlcmZTbWg5?=
 =?utf-8?B?eVVCMUdZZi8raEJmaEszWTZ1QUxSNTdhUURrVmdSbHNSR0dNTWdPa0FBQjBl?=
 =?utf-8?B?VTAxdVZ3Ly9WSXZlNzNWRE1ISzNVREhhS1Nac1BOVjlYSjd1SjROQmZ6WUhV?=
 =?utf-8?B?WG10YnZmVmFJaFNSM2NkZEFmaXF2a3AzblhQenR3Wkc5VTBQYXBhUEZiSDFZ?=
 =?utf-8?B?TWsrMHV6cjhsaWdYOWxJdm9IWmxHSHE3SGJvYWJ4SDN2QWFPekVRWkF4dURY?=
 =?utf-8?B?ZnFKRWljSThDL25Vdi9MQnkzRUpXRE9Qdmh5ZGRUZTF3VEE4N0xWdkNISm02?=
 =?utf-8?B?Q2tGcU5CUzlnTTlhV1JvdTgwTk5ReE1DbjVQcEp3N1pCUVJJY2V1K0tRVzhl?=
 =?utf-8?B?TkRYV3c5Tno4SWNLYXlQUkJpeEZVa2czN1g3OFJmWXNFR2xROUZ0QzB6dnNZ?=
 =?utf-8?B?S1FnTkY1eXZ3WmRDVjBManBtNWxkY0NCcUlxbW10Z0JDcWJSb2VMcmhBNTFZ?=
 =?utf-8?B?aFhyUy9McTVQa0ZlSXN4MXhlMklyYVJNQmxEWjhsOHRxUkk0TENOU0M0Mlhl?=
 =?utf-8?B?Q3M0WDZQLzZCRTFVanFROWhlZDBmYXhvSU9KUm5DdVV2b3JGYUxJVnpncS9h?=
 =?utf-8?B?SjNPTWNSQnQzM3dTOWdqQXNiSlBQblk1OWVYZlZNQ0d5TUxhbEJ5TkZBUW04?=
 =?utf-8?B?NjhMWllSdEpIS28xdEt5WG1jODQwM3h1YkFXZzlKZVJJOHZqSlYraDU4b1lF?=
 =?utf-8?B?OHVHOXExNVQ3OUpkL2o1cHkzZ0YvR2F5ZFA1b0QyajY0S3dwaVd3WXoybzFv?=
 =?utf-8?B?Ti9oaWgzVDUxcC9IZUxOYzMwazBiV3N1K0RBTGlJTVZWdzd3NlNCNnhyV0Nu?=
 =?utf-8?B?QTNmMU5oRlE0bkowck4wZWNwdk9ucGJyMHY0RE1qSWRodEZ4Q0NaN2crOFBa?=
 =?utf-8?B?MEdZMzFPV3U5bkk2MWZaaXBHbVl0RUp0RGpXVzVhSEoxYUY3Y1N1SHZtWmxH?=
 =?utf-8?B?Unlqem90NjNZTUFzUHRHY0RJeFpHWi9nZ213R0p3by9adFZKN2FjNGJnQVZi?=
 =?utf-8?B?bzhmM0VpbjBCcGNJWkVrVEgvUk1BWXZLUldyOGJlaGMxaDVkZityREFwQXlT?=
 =?utf-8?B?YVZpVVlxNXRzZDlWSmF4c0lWK0VyTkUwRyt5eWkrY09LbjA1Y1hwUGcrcTky?=
 =?utf-8?B?TllCZ3RzeEJGSE5uT3E2eEw5alg3blJyemtMeW13UWxnTDBXeXZ3Z3pwb05u?=
 =?utf-8?B?WlF3cWdMMzdzRWJwaFRLeWUyYlpHcklRNmIwZjhsWGhLRTVQRTRxSHBJdkZk?=
 =?utf-8?B?Zk85TVhzcUx6NmNFZjlod21JWGw1VGN1SWdyRlpVZUd4c0VVM0Zjc2toRHA1?=
 =?utf-8?B?a1ZUdTJCbkZQc2l5bllQMFYzNXlqbit3d3dWUHNhYzU4RklIaFlJNzNqMW16?=
 =?utf-8?B?K25wYXdFY01TYUNhM1ZjTWJybjZZQ1pDYkl4eFJneDYzcjdBeE1xVXZkbk9l?=
 =?utf-8?B?ZlVYTXVqK0hkeUpxMVZCeFFjTklzZkVtSzBJMDNjSUpSRTZFT3pnK2kxL2Jt?=
 =?utf-8?B?R3V3VkFiSG8wcWlTYzRNQ3hDekhyODE2YUM2UFNHWHZXRmp0UHNLZGtJbTJx?=
 =?utf-8?B?amdBbmNaODlpb0ZzSjNMQjlYYXhSUi9MbzdTUU1HK3Q3eDZwZU1XMnVkbnhF?=
 =?utf-8?B?Lyt3TXgvaUxoZXFVSE1oK21pZmFvM1B2MDZVWnhpbisyNWg4SnZBTWNQL2Yy?=
 =?utf-8?B?cWo2OGxYUGVyaGVMUnBkdW5pcnBXcUhLckpOYWxybkY1VjJnaC9YUEorUGJa?=
 =?utf-8?B?V1dIeGpadWNjWFJOVTFoUDl1M1lrbmxQY0k4S0tRZm9tUUMrUjNINzZCbE82?=
 =?utf-8?B?TXBuckZJSDR6R0wzSVBtMlJqUXFjTzhHVFdJWUpEZ2JXViszeG1OQitJQVNJ?=
 =?utf-8?Q?CEJmnyM0Yku2TIbJLyyah+Ks0w1uHnZOmIM7Ll9oxYtnU?=
X-MS-Exchange-AntiSpam-MessageData-1: OAvZ1Jg8c3ANOg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ed3d18-f15f-4e6f-3438-08de4f642446
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:47:45.9187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H4sMFxvm5XH11U7BqxYWDJvwiSvDeg8HUs9Eh4OoU5ArkrtRChPB8Ms4AO+ekFr5Qw+1fXC7mC693VXx0Iuyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242



On 07/01/2026 06:49, Ashish Mhetre wrote:
> 
> 
> On 12/18/2025 12:33 PM, Ashish Mhetre wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 12/18/2025 2:01 AM, Jon Hunter wrote:
>>>
>>>
>>> On 15/12/2025 06:48, Ashish Mhetre wrote:
>>>> The Command Queue Virtualization (CMDQV) hardware is part of the
>>>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>>>> virtualizing the command queue for the SMMU.
>>>>
>>>> Add a new device tree binding document for nvidia,tegra264-cmdqv.
>>>>
>>>> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
>>>> property. This property is a phandle to the CMDQV device node, allowing
>>>> the SMMU driver to associate with its corresponding CMDQV instance.
>>>> Restrict this property usage to Nvidia Tegra264 only.
>>>>
>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>>> ---
>>>>   .../bindings/iommu/arm,smmu-v3.yaml           | 30 ++++++++++++-
>>>>   .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 +++++++++++++++ 
>>>> ++++
>>>>   2 files changed, 70 insertions(+), 2 deletions(-)
>>>>   create mode 100644
>>>> Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>> b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>> index 75fcf4cb52d9..1c03482e4c61 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>> @@ -20,7 +20,12 @@ properties:
>>>>     $nodename:
>>>>       pattern: "^iommu@[0-9a-f]*"
>>>>     compatible:
>>>> -    const: arm,smmu-v3
>>>> +    oneOf:
>>>> +      - const: arm,smmu-v3
>>>> +      - items:
>>>> +          - enum:
>>>> +              - nvidia,tegra264-smmu
>>>> +          - const: arm,smmu-v3
>>>>       reg:
>>>>       maxItems: 1
>>>> @@ -58,6 +63,15 @@ properties:
>>>>       msi-parent: true
>>>>   +  nvidia,cmdqv:
>>>> +    description: |
>>>> +      A phandle to its pairing CMDQV extension for an implementation
>>>> on NVIDIA
>>>> +      Tegra SoC.
>>>> +
>>>> +      If this property is absent, CMDQ-Virtualization won't be used
>>>> and SMMU
>>>> +      will only use its own CMDQ.
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +
>>>>     hisilicon,broken-prefetch-cmd:
>>>>       type: boolean
>>>>       description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
>>>> @@ -69,6 +83,17 @@ properties:
>>>>         register access with page 0 offsets. Set for Cavium ThunderX2
>>>> silicon that
>>>>         doesn't support SMMU page1 register space.
>>>>   +allOf:
>>>> +  - if:
>>>> +      not:
>>>> +        properties:
>>>> +          compatible:
>>>> +            contains:
>>>> +              const: nvidia,tegra264-smmu
>>>> +    then:
>>>> +      properties:
>>>> +        nvidia,cmdqv: false
>>>> +
>>>>   required:
>>>>     - compatible
>>>>     - reg
>>>> @@ -82,7 +107,7 @@ examples:
>>>>       #include <dt-bindings/interrupt-controller/irq.h>
>>>>         iommu@2b400000 {
>>>> -            compatible = "arm,smmu-v3";
>>>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>>>               reg = <0x2b400000 0x20000>;
>>>>               interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
>>>>                            <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
>>>> @@ -92,4 +117,5 @@ examples:
>>>>               dma-coherent;
>>>>               #iommu-cells = <1>;
>>>>               msi-parent = <&its 0xff0000>;
>>>> +            nvidia,cmdqv = <&cmdqv>;
>>>
>>> So I believe that this is a generic example for arm,smmu-v3, and so I
>>> am not sure we want to be adding all these NVIDIA specific bits here.
>>> What would be more appropriate is to add another example under the
>>> existing example specifically for Tegra264.
>>>
>>> Jon
>>>
>>
>> Yeah, makes sense. However, I checked arm-smmu.yaml (v2) binding docs
>> and we had separate Nvidia specific compatible and property
>> (nvidia,memory-controller) there as well. But we didn't have a separate
>> example for showing this compatible and property. So, I wonder if we
>> even need to update the generic smmuv3 example for cmdqv property or
>> add a new example?
>> Can you all please share your inputs on this?
>> If required, I'll update the patch will the change below:
>>
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> index 1c03482e4c61..6b07ca9928a7 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> @@ -107,7 +107,7 @@ examples:
>>      #include <dt-bindings/interrupt-controller/irq.h>
>>
>>      iommu@2b400000 {
>> -            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>> +            compatible = "arm,smmu-v3";
>>              reg = <0x2b400000 0x20000>;
>>              interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
>>                           <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
>> @@ -117,5 +117,26 @@ examples:
>>              dma-coherent;
>>              #iommu-cells = <1>;
>>              msi-parent = <&its 0xff0000>;
>> +    };
>> +
>> +  - |+
>> +    /* Example for NVIDIA Tegra264 with CMDQV extension */
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    iommu@5000000 {
>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>> +            reg = <0x5000000 0x200000>;
>> +            interrupts = <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
>> +                         <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>;
>> +            interrupt-names = "eventq", "gerror";
>> +            dma-coherent;
>> +            #iommu-cells = <1>;
>>              nvidia,cmdqv = <&cmdqv>;
>>      };
>> +
>> +    cmdqv: cmdqv@5200000 {
>> +            compatible = "nvidia,tegra264-cmdqv";
>> +            reg = <0x5200000 0x830000>;
>> +            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>> +    };
>>
>> Thanks,
>> Ashish Mhetre
>>
> 
> Hi All,
> 
> Can you please share your inputs on this?

I don't have any strong feelings, but we should leave the existing 
example as is and then up to you if you want to add another example for 
Tegra. The various DTB build checks will catch any errors in our DTBs 
and so I don't believe another example is strictly necessary.

Jon

-- 
nvpublic

