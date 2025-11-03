Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4FB148850
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178099; cv=fail; b=rL2A6pqsErSVodSKpXl4SbR3vyV0DbwOzD182PEUfEqAwH434js7D2ooovn2GKftlCszcQe90LedcJ4syEcwhHJ6vECk5kRU5BlKoVI6JBeTesrlmdJwe3w6HtMfH3lY8VicxgXsv3FJayCOfuIIB/9y/mWKOjx5JKCLyGdBcVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178099; c=relaxed/simple;
	bh=Fdz5YVMUaYqg5JpUXxdOI/ASQb+nWVNspj6lOYJOdyk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BfQYLRt/1zQzgsugTSc8vdsVci0s4+G7VqELEhSXXEk5v7VOq1B0hYW9RCGSasfcLdyyaCXO6lXKNj2YXUHhwigfoY8qFbwJrp2vSpvTp0bITattlvMo8aWew0Tvz3m1/SOjvFMK9D+sHIFrOUGJdOE7sJklz9yWiDSESGRV5Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umaG/ijk; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umaG/ijk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uG68z03ESvt5kCnSDF3E1ngxeUuhEDSsSMujt4Ku9OL/6DgIaVgPr4J6yvie8znYO/dl4WKSNdVI6F6RGdvP1TsSyVDUL/1tmRhAeUu5jfd3zbmff0N2DOk/aMHGAxIMpILda6xiPwBSM/55v179w1lpUF5KnUEKe/LNit7Jtek/N62nQJCoRvipLLo5GS1tyFPJOwPzg7o/vOEvEgodwZrUHP6+uwFP16EuUs9V7CMlBCoViyYFh5vWUCtxWUPEdaBlkrEaDNf7QX/WwtahYKbDi/ZT1gzdiKYwG6Tjz3vJ6Kon7BAK+p4g6SJPQ+FPcfZb/rHjDE08teI9G9LjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jodrgEZhuHyvNhEGhxEAIn6daZ/jl0wOadBxgR2upsQ=;
 b=W0msSAutVqzF+WVsphcwuNyH05kfTcbYK+6xIAwFVRbdNiHzdVfLT9fH1HXHYfAUdHXzLuaTpqtvHGa0M57pqwT8vrYCfnO/DV/CfZeQm9OX1uQsLbRrKjhkcO2QMf5koZ41BBanMHL2cWEMgRQFdI7mv8golc5uuTorGBycu+bgJbN/RprjZTKD8jrHolW8lf21E1CP5RQThw4Z2JzSV/XYv12dIDLJ1sZr9tdkcDazulRrNo1ubjx9CqKqiTy9m7yi7Yfw8EFyd+D4yAOAH9DN2/c6e1ybftsARVhf33/t9I6R3ikTVjw8mBgSgTmiBer1uyJw7q5WyYmQZY+3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jodrgEZhuHyvNhEGhxEAIn6daZ/jl0wOadBxgR2upsQ=;
 b=umaG/ijk4uIyxDspzm8OUOE36U2umonCFNjpIh5DwhGb4ulr8qUJII439vGzcwdrY/Bp144yWcArhC6zjyy7HXSlBL1jACnCXjpElKWF5bt8s9BBTJAHlGt2VCmRHP4/i56vGyw+Y86dSxxpYRJcTsHJI5I5Z1rGKldYTg8YSMGz8ySrkHf9BxYuMmpo3cmpVSoPO2s5jfmghOv7uuyxAaLDue77zqMYKBtl9TFsw19e6uctett4kvMbBYDz1PLJnJ/fWAMyrDd3Zx+ANyHcBFa3k8j7v/UCRbeuHYDdbEi9WE+0ONJDM7h1IATmoViXnRUNbiBPE5edWIgw0onfDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:54:54 +0000
Received: from CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::9a15:4da5:cfae:f5c6]) by CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::9a15:4da5:cfae:f5c6%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 13:54:54 +0000
Message-ID: <4f6496de-d3c8-4701-a9b4-6f695018eb5e@nvidia.com>
Date: Mon, 3 Nov 2025 19:24:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 jonathanh@nvidia.com, jgg@ziepe.ca, nicolinc@nvidia.com,
 linux-tegra@nvidia.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20251031062959.1521704-1-amhetre@nvidia.com>
 <20251031062959.1521704-3-amhetre@nvidia.com>
 <20251031-witty-sociable-chachalaca-b73dbc@kuoka>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <20251031-witty-sociable-chachalaca-b73dbc@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::15) To CY5PR12MB9056.namprd12.prod.outlook.com
 (2603:10b6:930:34::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB9056:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: b417b4fd-bb31-4808-0d74-08de1ae0910a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2UxeDFaUmEvT1dmV2xFV25NOVJnSHo3eUNlQTFna3JLOXhiNWdHSzY0U0xo?=
 =?utf-8?B?TXYwTzgxWHNzRWhVUTVQYjRuUjZiVEQxaTE3dUlsOFpFVGlDaks3RndhS2tw?=
 =?utf-8?B?b0pLNGZOVkxqU0c3clV4OGRhdkJscXdjemVmTzZHQURHL1J5WEc2bGVhMmNW?=
 =?utf-8?B?NXJhbjYzSk5aeVNtSDdLNnFBY21jWEd6MUFPNjJWUkJvSzErNE01UDZCUlpW?=
 =?utf-8?B?cXBBSFpvRWdudHFnd1lVN3RlbUVvcXk3ZUZERHIwTUplUlNKVSt4QmlQa3dj?=
 =?utf-8?B?QkU4dHR1NkJyMVZMWm14aUpCUy9GSzZ2ZWY3YzMxZXAwWUo2SWorU1YxYzls?=
 =?utf-8?B?YnUwMzBmL1RwK3UyajRKbklFbEhKNHFQMW52ZVl2M2xZRUU3VGdNS1krM0tJ?=
 =?utf-8?B?dEJaUEtyeGJOd214OFJyUjBoTWFHY3lDYzBYa28yYTlrNnI2cXRmQnFCTjN2?=
 =?utf-8?B?MjdhdzhqZTI0QzVsR2hUMGlzTytnZVkzV3VORWRUUDRpT0hJZEd3cDVpZDdx?=
 =?utf-8?B?b3hjTXpDVUg2UklpVTFMTTNYcndhMmlRcFhNd2ZGbmc3d1RKM0V5OE5iUEdr?=
 =?utf-8?B?S1h6bTY2R1BrSUQ5YS8rZytRQ2ttMzNiYWJIYk85TkNpaG5TemUxTVI0OFV2?=
 =?utf-8?B?c2drSlNxeUZ0WjhKeVZHd1FoM3NmbllhUUdnTGl3Nkp4c1kvVENYb2g2VHFv?=
 =?utf-8?B?SFlrT1dMcTlXT01jSC80UDdLWTcyZXJIOHVaNk5XSWV0Tk1iZk1UL2NINTQx?=
 =?utf-8?B?Z1Y2em5DM0JYZGNUdWNKV2luRUZZRGR0TDJMUkpsakJKTy9MOC9BcmI0SkM1?=
 =?utf-8?B?bFpmVmFGN1NPTEpwN2lOTXlFbkpWdGRqcGRlYkpISmlGVXRWR0FGckxjci9z?=
 =?utf-8?B?c3J2aGpSTm5MWjlKaytxQkJRY0VkZkkvdzM3OHlCMm94NWFUaG5uekxlalpE?=
 =?utf-8?B?aEZKSEdtOU5QTkxhVkVjaVgxbFQyQlRySGxDRDlMNmkvdmpnYVJGYTAza20x?=
 =?utf-8?B?RE5UbmxOV0lyT1RMUzJ1VGw0RGY0Q3E5bkNIQ2VFZGZ2a1FsWmt6S3VUMmNx?=
 =?utf-8?B?ckw1SGtsOENWTm5sUkExLy9XLzlsZkNCVXRPSTFCeHhWVzVldWkzNkZva1Iy?=
 =?utf-8?B?RE1sVHpNazMwT2J6SXNPaHkyek9QcG4zWldja3NKak1PK0lEaEp5eDRWc2JP?=
 =?utf-8?B?c2ZRaEFhL0N6NGprNGw5SHZqT3lUZUdsdU04a21TeUNlNm13UkxBV1krWE1m?=
 =?utf-8?B?QllxcWY4bVppS3Ywa3hqR05ZM3crcGNvUzVWLytvdVNjQXlDSVVWMnlkOG9H?=
 =?utf-8?B?bzNidjJMb203YmJUbGpXVG03bmxDczNySzRSbjNVQTBOWmFkTVVoWjVBY25F?=
 =?utf-8?B?VVRydzBJakdxMUdUUmZyeHB6MWVwN3NxZGMyUXBhekVHOEwwKzNXTkdnMmkx?=
 =?utf-8?B?RURtbFRVY2VkZmJ0UCt6MmlwUFNLeFJXQmxLYUZ4dEp5WlptZVlJQWNZcHBs?=
 =?utf-8?B?NXRHTXBKdXRRQUJyMm53WWpkTmNaa1lKcVUwOGVkTTZ4SStXZU9VQktuc0pR?=
 =?utf-8?B?YmM0TDF1SXoyek1naXVIZUtHTmpmRXJHNThwcnJKMjdMUG5vS3RqV1Y3bkRH?=
 =?utf-8?B?K3g0VEZqc1grdzNSa0RPcUpWcEhHaDA1TVlGb0p2WnBHRythRHVHZk1mMjFR?=
 =?utf-8?B?Wk5nbWYrYzUxVll3U21zWWlHbkNQeGY4WW85dWJHbThNOU1kZ2NSQkdqQ0VO?=
 =?utf-8?B?Q0NzZmE3VC8wM3l6cHAwRkczeE4vczBGWXg0bEloTFp1UXNiVWxLU1I4SUF3?=
 =?utf-8?B?aVFGUlN0R2l1QURtTEZMTGdkaVZsU09TKzJSTE9pMi8rbitVNmFlMFJjVFRH?=
 =?utf-8?B?QmtRNTM0ejRBNVFNNE9qb0NwNGpickdQZ08xMEY4Z2MzeDMvcjg2SW93eWoz?=
 =?utf-8?Q?WZsB4oufIzCgRdDH+eoAFZOhC1pQBORi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB9056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk9NZzIrcGFkR3JxNm1oc2FrTmxKam82RWMvTXZKMzhUZ0RWZjZJYWY2WGlB?=
 =?utf-8?B?NlFHL25RK1lVdUhpWTVBNVJmLzdqeDAyLytKazBTNFc0eWR0Z1FFRmI2Yy9a?=
 =?utf-8?B?MlB5eUV5LzJnK3pCYTdGcjNRRzI2OFloUzl4N2oyTDNEU1B1YmxYSkpycGQz?=
 =?utf-8?B?bWR6TG9acEtpWHlOcUNkcm5iS3pubUFEUzB0c3d3TEZsVUM2YWZTOHkzQ3Av?=
 =?utf-8?B?a3R6ZmhZWXZ3SlFUS05oUE5wQlYyZTBXQm03WVJ5SlNZK0ZIR3c3TmtzbHll?=
 =?utf-8?B?OUFFbGpwWjVhK0NMNFl5WXJWTllKS2Q0azBieEpqOE11cjBJRUNJcTFKT2RX?=
 =?utf-8?B?SjIwQ1R0ODc2WHp1OFdrSUVOWDhVWXJYRHd2akROeGJLa2huS3Y3Q1BDbjZV?=
 =?utf-8?B?RVJoR3ZacnpkYVBvOHNlaDVmbCtCSjdjZkYzTUdtclRpcmpQOVVLeSt3V2sv?=
 =?utf-8?B?QVJhV1FxOXlBMlk5bEtpUUFucGtmU2ozSWZHQ1JBLytPQzMxR1kxTWNYd2Fi?=
 =?utf-8?B?MjRMNzl6bGU0SEUvRkV6d3pYUkZROTZVMW9raElickE1U2taZGRmL1VjcVBV?=
 =?utf-8?B?bGFjSDBxc2NRU3BVZlNVZGNibzFqZDAzSlRsSUZTNjlpa3FLVHJWZENaeWt1?=
 =?utf-8?B?NlNRS3FqNzlWM1NqMXJVdk92WWRUUXRuNkdsczRVOE1MTVRBbWR5ZDhlemo1?=
 =?utf-8?B?amcvU0RtTWlZS2NyMEhDaUtwYjFSbkZSbk04K2l1YUtocG1JOUdaNDBQaldJ?=
 =?utf-8?B?cVZrc20yNThhUTNEekdReTErL3dNYU1mVnY0VHdiT0d1a2NFU1Q5SVNaMzRM?=
 =?utf-8?B?TlhZOXpRdm1CMTEwczhvejBQcTNXOEVEYVF6UzFQWGpsZ2N2L1hxNWtHelFQ?=
 =?utf-8?B?MXIwdFkzYWVRcUNGdWZaRE9CRTVSZzlpZ0xObXZNSUNVRzllaGhZUm1HOG1i?=
 =?utf-8?B?WVZqVTBwdzJhajNnQ2psbURpam9ZMnVSRURTMkZNWWdvUmVheWY0Q3B2QjNB?=
 =?utf-8?B?c1V1WDNEaURFUmErRWJGODRacFd3SW9IT0hGQ1FPRWk3dTRBZFFRTkFhUlkr?=
 =?utf-8?B?ejlNejM1cncycHJVSWFPWGFZMWdJNkZNY3lSUEswM3hpVytVNmhaMHZKZDQz?=
 =?utf-8?B?emhhdkxTUmZXZEU2cTQ1RXZHckhzQkVYVkx3RmJsTUEwNVdOTERNMTd0N2Z6?=
 =?utf-8?B?UlozOHR4SVM0OTVlZ2pjbm1GMit6cGJvMWJQMVh1V0FvamZGeFVXUkliUzlr?=
 =?utf-8?B?NmVZckVrVWRaMkRYSFVIRGFlZmxEK0lWeURxbHU5Ri9ZdXVidXk4RUNhempq?=
 =?utf-8?B?OUwzQ0hWVVhsVjBUMVVscFVGZTRPSXg0TEtBZ2VKVXhPalp6SUFEQjVKWCtz?=
 =?utf-8?B?blRRbEFBdnI5VG5FakFwQzFFbnpIN3IrcVptM2pJZDQrSGxSMzhkbWxxeTA3?=
 =?utf-8?B?UnhKZXJZUThhQXpONVZISDhoN1ZFbUx2VzJYbVc4VGpEb203V2MwZy9UWmtW?=
 =?utf-8?B?SGpFS25WeVpTZGNpS1k0MTBCOE9ZZ0g1b2E4QlM4b25tTnViUWFWdU5ITnEv?=
 =?utf-8?B?WmlQRmFLeWxCMVJUNjBGcHJ0dmJSMk9pSWEyTGRkRm5XWXpSVFEwMjA2MlNu?=
 =?utf-8?B?TGhZQWJZU1VvaEIxTEZpUWc3NXY5T3NOVi9KaEdBS0hpZmFqekdpdmozMzNM?=
 =?utf-8?B?RGxaMmRkN2NRa013Lzdld0JraUVEdmZpbnJCa2hFblFyWGJnWEhHZ1JhRDMr?=
 =?utf-8?B?Q05ucVAwZzhKQmFIRjRKaWpjeUVFN3R5a2NaNmZRbUFyQ2R3b2w2d0c5b3Bq?=
 =?utf-8?B?cXRydW44dlBVT2s0eXkwaThxaHVSYlkwaVhVb3gzMHZ2d0VnVXh0UjJEalRP?=
 =?utf-8?B?U2pKeFJIUmdLcGtnTFgxN29QNCs3KzF3eHpRR2tLcUJ0aVZWZ1IxSzZXTGVS?=
 =?utf-8?B?THZTcVBLQndwYjdDK29nMXdHQ2xJZFJMSjBnbWNZV2ptY0lkQkFqeTNyOWNV?=
 =?utf-8?B?TlVrOWhtYmQ2K2VpN05aOU16VDFJRUlUMEd4cnNjS1UrT2Jrb1VwZGU2UlZW?=
 =?utf-8?B?WVhoSVVVVXhZb0QzKzdXRWlKVXNPbmZCM1FYNnFVUjlyTEpST1pzU25aY3dt?=
 =?utf-8?Q?ETLmMig/Gw7VNLpxr53OupAT2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b417b4fd-bb31-4808-0d74-08de1ae0910a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB9056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:54:54.5802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjzhV7o07m2OvWbIdY0I7nArHPML1qs3TsdsNVKZSA84hmO/tFas2xQRSc41YUN4muEBTB1VYe3B3FuUJAsrcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224


On 10/31/2025 1:44 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, Oct 31, 2025 at 06:29:58AM +0000, Ashish Mhetre wrote:
>> The Command Queue Virtualization (CMDQV) hardware is part of the
>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>> virtualizing the command queue for the SMMU.
> If this is specific to Nvidia, then I think you need specific front
> compatible and disallow it for other vendors.

Yes, CMDQV is specific to Nvidia. There isn't currently a vendor-specific
compatible for Nvidia's arm,smmu-v3 implementation. Would it be acceptable
to document this as Nvidia-specific in the description? Or can we add a
new Nvidia-specific compatible string like "nvidia,smmu-v3" if that's
preferred and use conditional schema to restrict the property?
>> Add a new device tree binding document for nvidia,tegra264-cmdqv.
>>
>> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
>> property. This property is a phandle to the CMDQV device node, allowing
>> the SMMU driver to associate with its corresponding CMDQV instance.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   .../bindings/iommu/arm,smmu-v3.yaml           | 10 ++++
>>   .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 46 +++++++++++++++++++
>>   2 files changed, 56 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> index 75fcf4cb52d9..edc0c20a0c80 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> @@ -58,6 +58,15 @@ properties:
>>
>>     msi-parent: true
>>
>> +  nvidia,cmdqv:
>> +    description: |
>> +      A phandle to its pairing CMDQV extension for an implementation on NVIDIA
>> +      Tegra SoC.
>> +
>> +      If this property is absent, CMDQ-Virtualization won't be used and SMMU
>> +      will only use its own CMDQ.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>>     hisilicon,broken-prefetch-cmd:
>>       type: boolean
>>       description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
>> @@ -92,4 +101,5 @@ examples:
>>               dma-coherent;
>>               #iommu-cells = <1>;
>>               msi-parent = <&its 0xff0000>;
>> +            nvidia,cmdqv = <&cmdqv>;
>>       };
>> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>> new file mode 100644
>> index 000000000000..f22c370278a3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVIDIA Tegra264 CMDQV
> Missing blank line

Ack, I will correct this in V2.
>> +description: |
> Do not need '|' unless you need to preserve formatting.

Okay, I'll remove this in next version.
>> +  The CMDQ-Virtualization hardware block is part of the SMMUv3 implementation
>> +  on Tegra264 SoCs. It assists in virtualizing the command queue for the SMMU.
>> +
>> +maintainers:
>> +  - NVIDIA Corporation <linux-tegra@nvidia.com>
> No. It should be a person. If entire Nvidia cannot find a person, I
> don't think we are interested in having this in the kernel.

Okay, I'll add Nicolin as maintainer.
>> +
>> +properties:
>> +  compatible:
>> +    const: nvidia,tegra264-cmdqv
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: cmdqv
> Drop interript names, obvious.

Sure, I will update in V2.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    cmdqv: cmdqv@8105200000 {
> Drop unused label

Okay, I will remove the label.
> Best regards,
> Krzysztof
>
