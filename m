Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3239447D
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404236; cv=fail; b=DXjJmmeNcUJNGfqr5wSc8wAoYKkN57e2xhq700iQ3dFAr8goDMsYdSl6lDwAvT6fDqyICpF3jMVMm0rKyDkAPWWAFn5wUY6Jzwpxd/fB00Emo/rK/O3kjB2N2DOLCkHJEo/5D1RBtLgWcdww5rqgTlcIAfZZBD/Qh6J6FSUSp2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404236; c=relaxed/simple;
	bh=a/DraAq5uCFJVmWQypxL10/4RWzVAz9CxL+A1UQE7Qs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IyhuMGcbc8ES0MfALuXm5IfDNxb/KxGrHCcsoyr63XlUrESt6z6wezxc+OegvphOZ1N9/tHaQDXb1SvNxHBcR03XdQw2ZB/RLWVv1Q4TQiTfHfblede+Hu9RejBf7YTzKHl2EPDxd2sWFcNPHnHdoqhI7In3WLjtrSsrVMgofBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ryHfyYuJ; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ryHfyYuJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bicrcdG5q2WMR2xwwQhYXVZ4TCF2A2IxDevZaOg+P6v730RXKX+CInHip3ohnXgtRVnAUybXaEv+iBO+FNBvDsK+XnxMONRwo9EzMW8GGi1XD0fK1MxlvW22hYul8EcjJCTVZ7QAySn8dpWPGS/Al1r9Bq9cftdRI1whxeI9Bfu1mVtv/omGKHywozCH2QUilvPdbadC8JiW9rtV7/DPbc09fdmo1tLvR0U37xyLFr/frwHlm0rR7BAC3ss2OGEGEsV6YuKvYZ9p3TTeqXuE1N4unam6pI3VoPwO5lOlqrtbWkgaD5xYJwcwQLbrJbxOVYKkNFyHyY74mZ7kykMxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB81BoPoyGnT5gwaBHo30yTuyejd7YDiJsvuBQ6iPDU=;
 b=Ej0QcKmeXe84VcnCayI5GPW+awBRm9zo/ATLonGgmR0ehIFGBMAF8K9MmWNIybOYtUZoExWhYg/gq/5sCTSzISHWhgC5OiG7ct56P33D7vpYi+EbGZqefEjDy9RGxSXVyjBndQrBF1SYEodAws269G8Bh5BckFaT575s3tVrQNQoJj+2tS9a2GxkNugZdskmHg1U0/q09BryT7uackNwTicliB+3926L0Gu52/7ApzXDlZFa3/A0ReuqK0nhr8PZJfI4kWFr+/440h1pkH8d9pDTByX+zqXKe5TvcJsV6U9LDgzi2aAg60yiQbImALPBta8wXfgMuz+BasIs0Ue+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB81BoPoyGnT5gwaBHo30yTuyejd7YDiJsvuBQ6iPDU=;
 b=ryHfyYuJvHnXX1DBvvQMlr/SWnbuh7lsmvSg/taw34/pVm4iSEh+4sWwzIwNrS0/7MNbmJmMwgAViJYy1t0S02yb5sCLSuxt6bOgTmqzmkqnqZURUENHWLNRmVCoFB9A1DrzKg7z/2yxGAD8QntKsim2wJHFUAEnMqk23g1d7EOa91VDqOw6W750S9g1tkYKkGgXR7FXlrIPeoiun7GJNdiCx7kDSrN1IhejJYIL4nPMeazzrTxRpKlRYaMduk+OxyO0nz+ae5BvmqyI9QxkdlnLD9uitLkf7VPwlNIP6iez+k9MGK+ebF5iA5+LuQMvGUymLhf7lSr5rvOQFc4csQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 14 Jan
 2026 15:23:52 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:23:52 +0000
Message-ID: <3bdfd531-698c-40a7-be76-254c122dfcb6@nvidia.com>
Date: Wed, 14 Jan 2026 15:23:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20260113054935.1945785-1-amhetre@nvidia.com>
 <20260113054935.1945785-4-amhetre@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260113054935.1945785-4-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::19) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: dd071f5e-16b6-4013-360a-08de5380ec70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djFwZkg3R25aSnZRbzRxNlN4R3J2a24rNEVEUE4yM2tMb3BVQStUSWVITVdk?=
 =?utf-8?B?bmlWbFZwWXVrM3JzcFllQThSWitKc3lnZzFlRWpOejBSQlVNQUN0eG1Qc3l6?=
 =?utf-8?B?YXJ4NGY5czNtT0dJcDd6dHFvVkdGQ0Y3MFhKbkptUVBidm9ReWpKWjBiZVZR?=
 =?utf-8?B?cjJqUHkxYnU1Z2lMSzhYckNaR0UxcEdxcU9RWkhMb0hKMzNIcmVRSXVMS0NR?=
 =?utf-8?B?ZkRZUXNSSlVHWm94Y2hhUFRnc1lwekdNK0M0SCt1SnJGV1VZaVYwRFIxSHk1?=
 =?utf-8?B?eldudEUzKzBqdFdVQlRXdmc0aXUzNlZwT05mbE5SWkFTMFI2L0tGTFllQWgw?=
 =?utf-8?B?L3lrZkJ3UFhJTTZyWFVIMHRYb2dKdURvbGFtLzFaM1NHYXNIbElwOGRFMGJk?=
 =?utf-8?B?NzVQZUFRc1N6ajBLTFhwSFhSNEZ5amkzbE9zUW9UeTJUeUxCVGhPaXVNUWY1?=
 =?utf-8?B?bi96eE43SWl2SjNzN3hkQ2JNdjhvN0QwblJIWHVqakw0V29KTHVNMytGczRG?=
 =?utf-8?B?cmJya3lCZE9ZZlUzYlNBM21USVZxMzQ5SU1FRHhkQUJYSGd0SnpLUXV6N2lI?=
 =?utf-8?B?SkpaMTRXMnh4NkNDZ0ZOQXZ4Rk9DRUtKYXpPa3loMzA5NnZCZUpVeU9ENTVS?=
 =?utf-8?B?TWljMzNqUkRzcUFSUTdsK1VNay9qTUVCeVR4VDZ0UnErRmFZREcyS2ttdmcy?=
 =?utf-8?B?c2VpRUUyZHFOazhLcUNWdTF6SStUaDA0dy9mOXpCSGM4VG9DeVB0YVdLQnMy?=
 =?utf-8?B?SXgrN2ZDZFM1YVo0QWI3SW9kc2YydVlnUzdGaWg2cDQ1dTdxcTdsRG9CZ1RK?=
 =?utf-8?B?VXdibG5hWmlQWnVZaDRsWjZiUEV6dHdpZ1lWZWpuT3NhTkR6Vk9DWVlUbTFr?=
 =?utf-8?B?WDhhQW9ZazNPMGN6MmdIYmxEem9DOEtOMW03L2pTZjRzamxnQ3RENm93VzJK?=
 =?utf-8?B?NzlyVXd1MFFSUmhrMWhLcFhjVnZRdGM4QlNjRkRtRU5YYlNwMXQ4bE8vdTJC?=
 =?utf-8?B?OWxCMXBDRnNUb2dFSDE0YVFxOEVGTU5aTVh5L0ZDNHBPRVVRall1aTJrQXMw?=
 =?utf-8?B?MVZRd3NlNmNlZk9BTFBwUnVoY2NXNTNWaDMrRlNEd1ZnTXliWUVhQkNDSTcz?=
 =?utf-8?B?UzJ5bzFicldZTm8xSmpJR1RibTRFUjB2M2ZsMUpHVUdPRU90MzNnK2ZJL0Qr?=
 =?utf-8?B?MnRCRG9zNnByOGJKRnlxYkF5cE50Z1Vxd0diam5JdFJKZ3ZPUjBXUUtBWDJX?=
 =?utf-8?B?NTFFNzdDRGZSRVBIU0NTdUVjY2s1ejhPUWJQbzBYU2JHS3BrcTBLQlYweGM4?=
 =?utf-8?B?Q3pvZU9tWDU3d01qUmtWbXFaNVpVbithbmJWREU4OGtxUHJTeDkzWXRWRG9O?=
 =?utf-8?B?U3lEcEJlL0NlVk5rdmpNb09HM2xGTmduQXMwRGF1dnROOFVueGEzS3ZQYmox?=
 =?utf-8?B?VHZCNmt4SEdGMnJIcURMRnFPZWpwMUMydU9yc0p4NW1jT29OY2lFSHBMZ2J4?=
 =?utf-8?B?QWpkYm16Ylo2S2lNcXBHK0t1eFZ4MjVBYjVFWkQ5aFl0MnNoaktjdVpRdVdy?=
 =?utf-8?B?Q09SN2RaN2Z2MWhrWlF5dFBvWjgzTzdacmFTYXFUZDNBNkkvL1VoOCt6ZUkv?=
 =?utf-8?B?eVB5VVpUaE1KUDc5bkhtRFVwVFN5UkkrUzRQZ25UKzZ1OVdkeGREL0s1ZER1?=
 =?utf-8?B?TDY1MmN0NzNKWGF0ZDk2SEh3amhoZEdhUmYxdStqamlFQWVrL0NHNEUxYmJr?=
 =?utf-8?B?K1pJcGFrQjNXR0s2ZUJmN09CQVFPeElvVmIyTDU4TCttTktmcitOLzFtbE45?=
 =?utf-8?B?QlJlNkJJTnBEcXpSV2x1ejBmYVZqbVc2ZWxqeVZtNXdhcWdMMm5MeUIwenVG?=
 =?utf-8?B?clNuTituZXRrTzRkZW5wS0lPUVVLNUV1VXFaU1FaWi9aM2QxcXJycS9yMlF2?=
 =?utf-8?B?anRRYmtwZm84czNpcHZoOFpFdWZpdCs1eTl0bXZjRFVZZDg3MDhhdGFkbDJk?=
 =?utf-8?B?VGdhK2NNZ2tyYkRTU2VXU1JhSitDcU9VbjVkNUthQUpJdGludTFCSVZ4VnpC?=
 =?utf-8?B?akpaRnV5S3ZtVkZycGZtWG94TTRHcDZuTjhTSllTNGtJVkNDZXlMNFRiaFdq?=
 =?utf-8?Q?uXtY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlVSV1VFcHhFM3BDWExwV1o5SHlhYUsvcnZWTzZPRE5uRnQ4Vit5bkFFdjho?=
 =?utf-8?B?NHBCQnJTUnFoNW00VEVpWGRndVdMVkY4YXZkdm81RDZybldTeGVDTzh1L05J?=
 =?utf-8?B?bCsxZ3NMZ2FDTjFLZktSdXB0TDlQY0lONEcxVkxIaER3RFJvTFV4SGhVS2k0?=
 =?utf-8?B?cmRZdHJVekRxaVhSTlhESi80aXE5RDdvL2FNZHNCZTd1TUhOZFcwQ1RuNWQx?=
 =?utf-8?B?aXZlZ3NIWTRMZ0cwN2t4UVRJUFEzbW0rR2s1aEl0TXE0YTg3ZjZkb3U5QkNR?=
 =?utf-8?B?SHZkcnk5RDhIRkZScm1ZbnNpdFAxZWFmMjI1c2VNLzRqZWd2N29hZFozeGJv?=
 =?utf-8?B?VTN2WlU3MzhPTkY0cVIrT0tUVFgrUGFETDhDdTdTQlBFUmtidHF2cmFzZGFX?=
 =?utf-8?B?L0pSb0R6a08yT3F4bCs5dk90U2g2MDVmNHB1MDkxUGo0enN0aFg4ZDJuQnJN?=
 =?utf-8?B?dWlGemloY0REU09sZ0QrNWoxVUt3NVFUWGhscjdvR2VUSGwxNnV0NDNBL05k?=
 =?utf-8?B?SEdzRjY5a29vS0ZTY1dyaklOSFF3d3YzQWtuUlhiR044MEF6UG00KzcvOXlH?=
 =?utf-8?B?L2pCNHdzcTVkdnpaL1MzSVpNUFZQdnE5Ulg3Q1RXVnZkYk9MRjVGRkZZeHFj?=
 =?utf-8?B?QjB1SkRwTG0yajlaS29PRW40eTk4UzRjTWRpcmZ0WXhVTDlXdVlzckRYV1Zn?=
 =?utf-8?B?UVBkWk9WMytyTFZ1ZWRHRnhkN1RJajNuWjlMb2JGMHE1SlVENk1pQWpkVGlq?=
 =?utf-8?B?V1JSRVV2RTRLZG1CNjBjSHBUdjNLWXJyMTRWQVFqV3ZDSEhSOVova1BlQmsx?=
 =?utf-8?B?Uks5a0VFb2hMZXNmanZCYXFrMUFIK2NrZkIzS0VISVd5ZUdCNzY0d09YMXIw?=
 =?utf-8?B?Z3dwck43dGxjK0lRcTVlaUVwUzZMUnNIMTFndXU1LzVBM0lvTUU3ZnRkczFy?=
 =?utf-8?B?S3VkYWdGWWk3Uk85ekFHM0hJVlJ3YWtoOHBHRllza0VmSjdFRXJwVmdsYmhl?=
 =?utf-8?B?YVJnQlNUK1I0TDN5WWlFM0VqM2pvZUthREIwVjNVM0EwOHlRQm9jTHJTYnZ2?=
 =?utf-8?B?VVNzbkk1dEVsSTdwY0duZzE2bmExMjB1dEczZVcrd0lyVVFMZlo5a1k5QW5M?=
 =?utf-8?B?QTVUTEhPeTlkNDRqTXVLbnBQWndtdjJnRVY2MDR1clJOcUdCQm9Yd3ltTEN2?=
 =?utf-8?B?c1dpNFZpRHlYcmNSZk5MQ3BEbGVuWnRKVVBmZjdrdHB6VG85U2hDWlpkR2pS?=
 =?utf-8?B?WXdGSFhlSTQrZ1JkM0R4eEh0ZHF3SEl5SzZMUGpiT2lqQ05kcit3eTdmSXJk?=
 =?utf-8?B?MURhUEh3OTdQbVFTa25ValFESU1jdWFmZ0RuZHUyR2NDRXZzVytnYUhvVEJE?=
 =?utf-8?B?RWs3UFM1eUkrWnpRcmR0cXIxTmJQZUFTWHJ3TnA5aHArclB3Y1VjejNZMkNM?=
 =?utf-8?B?T3cvSGxmbXYxam1XMmRSL0VMOU1Gd2hTamlzbUcvOGdERnlKZlNiZ3ZFSjJx?=
 =?utf-8?B?QWF2clVHZmtwbVVYeHRSdERyWGN2bUQ5RWszcktFL04wdytPOGpmTW1VcWVY?=
 =?utf-8?B?cnJ6dFBnNVNjT3g4aDFwQ1V6V1l3MnlBenlkV3VFc1RndnNMUXBoZ0VLczd4?=
 =?utf-8?B?Mm8rTUJYekRSTG5ZK1JvZDRwa0lmenpXOExrSkxIZnkrejJhY29McldEelpp?=
 =?utf-8?B?c3BjcVZQcWRGWTJkRURKT2plQmtLa3B2WWptRHFZQXpuMU5uMkRJcGM2aEZ2?=
 =?utf-8?B?c1YwVUtaUmVsMmcrV1cxVkVlNytJVjVycG9JTGpnNDhlT0ljU1dIMW4wVnd0?=
 =?utf-8?B?cmFoZGgyMytYTWpJWm84N3o2ZVVzSGRweEFKRi9HblllNEwrdUhuZkdjMkh2?=
 =?utf-8?B?ckZ0a0hiMmxxUXcza3UzN0VaRms0d0E3blZxbUtPSjR0blpIR01hMEZCSVQ3?=
 =?utf-8?B?Y2pvNFNtMTFuaVNzVW4vdEpKUGlEb2xQVFY4eFJNRkMxQ21tT1lReENQZWFD?=
 =?utf-8?B?SjBMR0p4alJXNFFBWm5kNnc4S2IzUGhyOHl2VDdEQWE1L00rNFJEVUxNMktV?=
 =?utf-8?B?VnRQODJvd2tnNUtuK2JXYmxnMU9aUng2N0pLdlE3WUtPSkprVDB0UVN0SFdT?=
 =?utf-8?B?Wnd2VlpwbUZYZjRGK1IzMXhyT2FHRThYVFlNYzNTQVEzeVFDNGpwa3dqYzdL?=
 =?utf-8?B?L0RMaDlha092Zldpa21HdXhDakM2bklLdit6SzdZY0JkcFgrUEg4V2hablZo?=
 =?utf-8?B?alFZdUtnUGRPT0FRd2dnY3o1NnptQXhCZmFJSjJ4aXlEWEtIdDRYcThXZFdO?=
 =?utf-8?B?TlFNeU1lSEMvZ3dHV3Y0RlYrSTBqdnJLMDFibXEwWnp6YVZkaVdpZ2MzdEhB?=
 =?utf-8?Q?1XGZwg0Dvm/efsUl7e0QMlDuxEBUIHtd8W2c+2jb5i8YX?=
X-MS-Exchange-AntiSpam-MessageData-1: fPpIA8c1zQawpA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd071f5e-16b6-4013-360a-08de5380ec70
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:23:52.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEYMZOCP9CZT3D857tU0+gAeWzMM6bdbio9NCu8yKGOu3VXustS1dMHW03/lK/7TU+iPjpFXAQ4BAPz2OJ6m4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769



On 13/01/2026 05:49, Ashish Mhetre wrote:
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
> Acked-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   .../bindings/iommu/arm,smmu-v3.yaml           | 27 +++++++++++-
>   .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 +++++++++++++++++++
>   2 files changed, 68 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index 75fcf4cb52d9..82957334bea2 100644
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
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> new file mode 100644
> index 000000000000..3f5006a59805
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/nvidia,tegra264-cmdqv.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra264 CMDQV
> +
> +description:
> +  The CMDQ-Virtualization hardware block is part of the SMMUv3 implementation
> +  on Tegra264 SoCs. It assists in virtualizing the command queue for the SMMU.
> +
> +maintainers:
> +  - Nicolin Chen <nicolinc@nvidia.com>
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra264-cmdqv
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    cmdqv@5200000 {
> +            compatible = "nvidia,tegra264-cmdqv";
> +            reg = <0x5200000 0x830000>;
> +            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +    };

Looks good to me!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

