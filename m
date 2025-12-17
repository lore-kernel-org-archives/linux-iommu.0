Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1ED35979
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766003480; cv=fail; b=ughArjPf21UN5bpxbDAZa9VaLqlCO5r550yNwS+l2NiRVo9x34BxtrM64Co9hkls0V8ltmsuxnEpYSeV4NuSt58ptP2kIGWzy4Fp3C+oPp2c2AxM8aAmK3gQDxLYEoD1hmVqNbBjnBcTC9rvObH2acglRT0JUMSJZ1TzokdrabA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766003480; c=relaxed/simple;
	bh=0A0fJHRO7+/Z4JiF5nl8H8AsF9ANXdd6f086hfr3M6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=afvdR4fb27jqaynNyxONxgMLfKMoexXnwl1QySK5jPO0oyQcZ11HeNcBtwYuE9Apsufj40W1jnCNUZ1xEBeQT56n+QE32+6IJYxQp3aUgM90a7qZ63TwOscZi884ORgG1eygew9w0owsdr0E1DM36RiHQt9z/sKsyIZTNgHcfyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aSL6rIeM; arc=fail smtp.client-ip=52.101.193.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aSL6rIeM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZlya1WLw+fzv3zoO3jWxs1EUjt8jmrc3Qp6D4iKxsw84n8yeRzKk2eMf0YI5XzvH8nTwPEZ1Pq4BPCzp7NxJmrgepUPg0r9J7Rj8g22c1VhAp8HBhHYSOPvjlYEAALmrHWObFKua+qErvMPBU0nyyq45xTiiwuE2m1VvDaqkWig8nJgWkBCgw/wXi03jNa/EzH8PyJVFqGMB+cl+J022j6oNlRJfmjPD9iuJ/P8S9VN7XfKz1g8zgJChomBgyhommMZxwzn3RXZQMTavPnbvhTYa0p+Ws6Zq1IxbBk5CgYTjftOxYd/fVkmiSqCmYglgA1hPBSS7lJrTudeGnYv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPwlol8cTJ3OiL8S/+oR/hoxZ7wSz1corMmCDHtZIOo=;
 b=o3N6KhdPz+zhvBlEUW7Iz/y4DloHRj9kyf0eFcQSV5wBl1ZqHqTJzQ+QIa/BWIah68mv8JsQ8cTpquwRIm6UMEaDaHcBCvciEPymMTJC1VDOCljqaAPzQNn+BXj1crh/ChHuXwdrWN+3/9MDZ+aJZZ6EUTbbrz1YxilPphN5jbgbzgeIw/KqZLBITs6fkwbo4eLFpmD51mT8xJf8ZTYzdq7sy/k3l46bMqzPYVT3oqzzFNOMcykVdz4bGqRO3FZfOZg3JVz/XmaZEzPPRSLtsaRYyL4qrm3DD5FGu5WZyuZEBzShr8+w3EivVZ4fQ41PI1vS3rVls3cQyw1AOWxfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPwlol8cTJ3OiL8S/+oR/hoxZ7wSz1corMmCDHtZIOo=;
 b=aSL6rIeMWWx6Qm6rlyPifQ8wRmti6mc+2Bxk2h/jxDEOI1d9vJ0L40pDMNh+JiK6Ef35dIVUszCo8ZNWlLTVSRCVR8N7xDGESocpF1kMkAyCC255Fg1Ptw1G6pnXk4oeev6bQ6ZOTRVEv/HSy2I7JmeETFr/GfN9CeBGQvn0gVBmhI7rFcWys10gDMsbfQVLFEx23xWZXJBO9aXTfqILlZy9AO6NA6vVTVwmyvFxFo8fJ0vr4ayTvuo1TABp4FfgXlGRVjMUmyoAwBs+p1t6sp2KkZ0QwRtapo+jjEksjUw6GCXHa+JCJv7xXWmkomaRmEKr8Lz2F2PMwDkIAmdcsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:31:15 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 20:31:15 +0000
Message-ID: <fbde672b-611a-4d81-ac05-44e434bf70ae@nvidia.com>
Date: Wed, 17 Dec 2025 20:31:09 +0000
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
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251215064819.3345361-4-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b43f11f-81c6-409b-7ac9-08de3dab3a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW96NHlWdVdVNjh5aEN0b2R6SW96N29xdXdvQWZWbGNPUytJdDdLMFhidXJ5?=
 =?utf-8?B?RDlmQzRabGxydkx5dFRoM1dVOG1HU1k1a0ZscGltM21wQm8xcW15cDB4Qm5p?=
 =?utf-8?B?Q043c09UWXhYU2pZc2NaMUE2MXd3UGpjWHNic2dDM1JxeFJIMDVLcTdzQVF0?=
 =?utf-8?B?RkhWd1NFcGxpOUl0WTRDUHJYN0srQ0dYTXgzaWxjcmp5MGhybUxsVG81akVv?=
 =?utf-8?B?TjBTNlBTc3Z1TEIzNmVUSEtvaEJiNG1OdWZuTjZqVDJRdGY5VDJnZjdZanZS?=
 =?utf-8?B?YUp1VjJSN3pVQlVGcXJ2bks4WGRNVjBzaVc5NnJyRkptanFLRnJLV0JoR0lt?=
 =?utf-8?B?cjlXZnpCc21BbUdES29BYkdIcHZXcElGd3phYXdQTFRzYVhqUHFtWEpXNEV4?=
 =?utf-8?B?WDBXd1VFWTJYL3NxT2ZWZ2hNWnJIZE9mVlFWQUs0bWpXWHZ6MzdxdTF2LzdU?=
 =?utf-8?B?ZEJRcTlrNEtXS2tyYXV1ODVSQXNEamRBTjJrMFhaQ0V0c05Ya0tlSk1ZNWZ3?=
 =?utf-8?B?NjRPMWxhTmpaS0IzU2VwbVNHS1kzL05JY3RjZ1VVY0lNZXdNeGo4OGx3RlNr?=
 =?utf-8?B?TDd4MDRJUFZseU91cVFQMEdBNGF0aUNPcEMwM2FUTnA5OVpyYVVPOWdCazBo?=
 =?utf-8?B?Y1d6MFI2Qzc4aDl1TFdnbkdPWTZDUHIwWHFFMDVVUUp4M3RVeXh6N2hib0Zy?=
 =?utf-8?B?bDgxdjZaTndPL0pnampKS2VVTW02TUN6cFdaSTIxRitwYWNJMWJ2elN4ekZI?=
 =?utf-8?B?VXM1bTd3azdLaGorMC81TUpqN2lDLyt5Mm5oUlc3UWNSZWU3eElVcmpXZk83?=
 =?utf-8?B?b1p0dVBEaGdEeEc5cmQvSE8vRWRqOHprdi9rTXB0RVVHMjVaZlNGVDd6Y3hD?=
 =?utf-8?B?aDVSNUptM3cySjhHdDFsN2lxYzFZaEtEWWxPWmpmM1phbDcrQXZWYVdaWXk5?=
 =?utf-8?B?dXcwanp0cGRoNnVPK0xxQ0ZpRUdJb3hzL3JNcno0RUJEdkRFU1dVTERlbXhx?=
 =?utf-8?B?cTc1VzVhTndYWXdkbnBLNDJjdklZbEY4a2tQOENWWjR6b085UytBUXlHTFhp?=
 =?utf-8?B?WDhuYjM1dTV5MFNkdHg2WERSeWNhWW5VZ2lTbHYxaXVkdzQ4N3VEK0ZSME9o?=
 =?utf-8?B?Q2wzN1VycHJoRUo0bTg0Y3Jsdkx0YlY5VXlnL0l6R1pBcUI0TEV2blRoWkJG?=
 =?utf-8?B?RW9qcU5jcGZ1ckNRSFFTRlBaOGFqN3VNbS9Fb3ZNSmVMa1VwbVk3Q01naDJZ?=
 =?utf-8?B?Z2dCUjBUZ3h0ZUxlQzY0NU5WOWdsOU50VDA3WnBOS0JPeW8wZFArOGFrWFZR?=
 =?utf-8?B?QTd3VlJGTGUxYXAxbjRKU0lpaHpxNi9qYkZDVE5ZYkQyR1J0Rlp5QTk0b2ZT?=
 =?utf-8?B?aHdabW00MlN1NVoxTTd5QUhubmdjSjY5M1V2OC80S29SZUpXNERvQ2pFanF1?=
 =?utf-8?B?RGt5cWllVWFiR3lEQVoyOGhJVXlRdzN1K3grVFhnTUMzUWhYTWxYZDNhWHVV?=
 =?utf-8?B?eTd3ZWhyanhha01SUHlNTSsveTc4TTM2bnFJd0x5V1ZyaVAxTUp2cVp0NWNw?=
 =?utf-8?B?eWpHdHc2b2NzK3N2d0VQbHJyb0FNL05wTHNrMEhJU1orajBIdjVkTnJ4VFlT?=
 =?utf-8?B?L2J1UjU1VDJoYkRCY0NGRUZ3TEt2SHMwUmd4SUllWFQ1YXRrUzFZUEJhYmVS?=
 =?utf-8?B?MU80R1BsVjh0M2ROU3F2emM1T21NTno1ZzBqVXk0S0ZlSGgxM2VhV05zK3R2?=
 =?utf-8?B?WGIxdDFTSU1aV01pei90OW1MSjI3SHJrTVJBaVQvbXVoTVZ4T3ltSkhnb0px?=
 =?utf-8?B?QkVMSHd0M2NsRVdTTk5EblU4NGNUeEU3N0lWdDhnQ2tPaFFFNVNZZ3lWZHlE?=
 =?utf-8?B?TXo1UWZZeXpoU2lEWmZtTFVKYVMwQ1dHc0lxeFZKZUtYY2ZSWHZyOXFWNjYz?=
 =?utf-8?Q?ZJERX/hNubU8HoO+1i9a31dmDjuYaflA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlBleTFJVU5xVXBNQVBFaFUxTndJRGJycURINTJsQWtDd0V0NmdCOCs4UXc2?=
 =?utf-8?B?ajkzQnJiRlovTXdWT1I2clB0UitrQ2Z3MFVxRTZnSU9QeVdHL2tEMmpycnRV?=
 =?utf-8?B?Y3l2bUJoSWFuZVBYQSs5S1VocWNka2xDSnZHZEZJdnVUTmtRd2xYV3dRUVdX?=
 =?utf-8?B?UVN4NXNsb3BBMFh0ckpmT0UyZTdCdGorNFVVWThFRjVBZS94bDJZcTYzVEx4?=
 =?utf-8?B?SXVJelBxYlBvUVZVa2o1NnJNM0xEV0p2QjhUUzVhamxFM1R2YlcwbkdZdnlo?=
 =?utf-8?B?UnM4bTlTSklSS1BvSFZhclZEMmUvSm1NTCtwZnRFdmcxSXk4Y1BNeTV1cmE0?=
 =?utf-8?B?Nkhwdmd4Q0dZT3A3RlJCNnlHNHVhWGNoQWhudXBYSFkxU1BHSGd3aHFOWExT?=
 =?utf-8?B?bkJlcXEzcTZUUnhZQU9PbGt5NU9WYldvVUxXOXpCTEZrOGhjL0xadG5jV2th?=
 =?utf-8?B?bEtOSlhuNExiWnFTb0lTM3o2b2RDWEdKa0pGNE5xSTRxK2UyU1pTTGFPK0hM?=
 =?utf-8?B?ZW12RnBTTFZ0MkhiYXppSUh2YWhZcS9ObFJ1TS9VeUg4TVZiTG5rdU9QZGF5?=
 =?utf-8?B?OEVyOXFQU3JOY05VK2dJYXkweHFwTHZzZ05DdytyWlRKak9pS2hkWnRoS05U?=
 =?utf-8?B?L082R2pISGhqZjJMRDVjemhBd3B4dlZYN09Ea2ZqVUVCWFFZbnd2Si9YejJn?=
 =?utf-8?B?K2RydjhHQTczWDhzaUpFWmh4WDBTRktmcGlCa1VLeWloSE1WdHV4ZXZ6Rjk5?=
 =?utf-8?B?ell2UFJMa0J4SU55dFRqOVM2NTBsQ1hWMkptbXk0TUFUc2VpT2JJTHpKeTdk?=
 =?utf-8?B?V213dktEdWtsbXpxNzBUVHU0Y0JqaEdSSXRPZGRTUEprVW1jTkljUUd4bHp2?=
 =?utf-8?B?RThoSGpGVUpFZUYyVy9WWEtxdnZrZ09Qbmx2QUZORWVJSk5ML0FrN043MnFF?=
 =?utf-8?B?clFMRXBJbzhIekwxT0RlM0tWZDJiSFdZc1pSVE9uNFRnTWU5SERrSkJUbUli?=
 =?utf-8?B?ajJSazE2L0NmZWxncisxMVlIc3lxSEhqb0I3b0o5aXQySVNCZWwycUp5dGNW?=
 =?utf-8?B?Ri90MDhJUHlyQzJSYjZxbGlKV1hBSGlpY1dKTkVmN01LNDJ2N3JpTGY3R05G?=
 =?utf-8?B?YzVHU0xEdzBXcFFCTUxVV2hsZkRWelRIN0l2MG8rKzJSS1RQOHhSaCtwdHBo?=
 =?utf-8?B?OXdLTDdKY2x2MmZFRVEvMWFpK1FRaTdEV0Vrbm9veVJKV0NhanlDOVFmSWNT?=
 =?utf-8?B?TmFyWHJMMitEUXdFUWxlRXA1S2dHYjczZ2NIRWNQandJWjkyZnJ1NDZxRFJi?=
 =?utf-8?B?QVFZUk5zZmtIdEtjeVVhcHFWc0Q2djVFbHRwcjRHejNNTHJGVG1GNDRUZHgr?=
 =?utf-8?B?cE9adXlrc09NT3N5bzhhMkFxWXBDUllpN0U3S2NUYkdjMlRETVR3OEtRZW1H?=
 =?utf-8?B?REVZeGgvaXJ0aWZHdkp3TUQ4L1dsbFE4bnhrYlh0a3pWdmtKcDJXZzZpRXNp?=
 =?utf-8?B?QndoeS9OVk1KaGc5ZmIzQTJXM3BJUnJuQkZEZXpraDRNWW1PNUZEbzFPS0RT?=
 =?utf-8?B?S3p0RnpnQ0ZyK2dCNmtPSjhac3BIWHJPd2ZQTTliM2NkeGJySXQ2NlBnb1BR?=
 =?utf-8?B?M0g1TUxudEJmWjdBMEdiZFpVQU83N2x3SU5jdzJaek52Wkl1YTQvaXlqSWtv?=
 =?utf-8?B?WGNETjByc055ZW94TjJuRHJ2R3FXWlNCN2ZyK1pqWEI2eDFYVTFvNmVNR1NH?=
 =?utf-8?B?Y3NyZlZnL3pIY283YWxQRkRONklnRjhwZUl0Skp4V2cyeHd4MFB0MGducXYw?=
 =?utf-8?B?Wjg4YXVyY2JyWXBnM2drWXFodUtuZ2s5T05TcU9jTjhJRlpEWEgxMzh0aldl?=
 =?utf-8?B?TnBXazBrVWpZQStBVzV2d2dVRWgxb1Y0dU9VdzBZVERNeDhtcTQvTDdRQUZo?=
 =?utf-8?B?bjBvNlhyOUFqazkrSFIwZDhESmhrTFc4bFVzT3BCb3haN1I5bzhrSkZBZTdG?=
 =?utf-8?B?QlVLT25RZ3l1d0NoSnlrRGtWUHZnb3NSTTNrMEVlbjFOSGdZS0IrZSt0QS94?=
 =?utf-8?B?ZFdidTdaT0VWWjZ4aS9GQit4amV2UDdBNTc4bGhTRkRCM2k5SUNkMW9Ic3p0?=
 =?utf-8?B?RkR0a1lwcGRmMFBES0YrNE5Ia3VhTzRUeHZYMHdkUjBMSFpXZ3puRVVKSGJS?=
 =?utf-8?Q?XsH0uW0Iq1veRUWyN7TDJpR2DLNA4bB8Mu78OR+7J5vh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b43f11f-81c6-409b-7ac9-08de3dab3a05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 20:31:15.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/VB0IT5VD5bbCmwPGLncxkNSGZH/dU7XFKRNG8AXECJnOmatZl1MEDUAf7YoIqyZz31tBaFaE7HYywgvn/1jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446



On 15/12/2025 06:48, Ashish Mhetre wrote:
> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.
> 
> Add a new device tree binding document for nvidia,tegra264-cmdqv.
> 
> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
> property. This property is a phandle to the CMDQV device node, allowing
> the SMMU driver to associate with its corresponding CMDQV instance.
> Restrict this property usage to Nvidia Tegra264 only.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   .../bindings/iommu/arm,smmu-v3.yaml           | 30 ++++++++++++-
>   .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 +++++++++++++++++++
>   2 files changed, 70 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index 75fcf4cb52d9..1c03482e4c61 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -20,7 +20,12 @@ properties:
>     $nodename:
>       pattern: "^iommu@[0-9a-f]*"
>     compatible:
> -    const: arm,smmu-v3
> +    oneOf:
> +      - const: arm,smmu-v3
> +      - items:
> +          - enum:
> +              - nvidia,tegra264-smmu
> +          - const: arm,smmu-v3
>   
>     reg:
>       maxItems: 1
> @@ -58,6 +63,15 @@ properties:
>   
>     msi-parent: true
>   
> +  nvidia,cmdqv:
> +    description: |
> +      A phandle to its pairing CMDQV extension for an implementation on NVIDIA
> +      Tegra SoC.
> +
> +      If this property is absent, CMDQ-Virtualization won't be used and SMMU
> +      will only use its own CMDQ.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
>     hisilicon,broken-prefetch-cmd:
>       type: boolean
>       description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
> @@ -69,6 +83,17 @@ properties:
>         register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
>         doesn't support SMMU page1 register space.
>   
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: nvidia,tegra264-smmu
> +    then:
> +      properties:
> +        nvidia,cmdqv: false
> +
>   required:
>     - compatible
>     - reg
> @@ -82,7 +107,7 @@ examples:
>       #include <dt-bindings/interrupt-controller/irq.h>
>   
>       iommu@2b400000 {
> -            compatible = "arm,smmu-v3";
> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>               reg = <0x2b400000 0x20000>;
>               interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
>                            <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
> @@ -92,4 +117,5 @@ examples:
>               dma-coherent;
>               #iommu-cells = <1>;
>               msi-parent = <&its 0xff0000>;
> +            nvidia,cmdqv = <&cmdqv>;

So I believe that this is a generic example for arm,smmu-v3, and so I am 
not sure we want to be adding all these NVIDIA specific bits here. What 
would be more appropriate is to add another example under the existing 
example specifically for Tegra264.

Jon

-- 
nvpublic

