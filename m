Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88831C2DA2
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691597; cv=fail; b=FfU/jtqD3itT592yEL9oI5lB3UYUPgnP9/2q9B6EGdkG6ZaikiutCScoFf+P9PNWvzNF0mfSyedRyldFc2FxQr0H8qggFNKejZ3ggQ3Dygcw0FBGqOjQCXCWTp2WdOWA/Xq9HryINih9YsRdvDAccPmEzA7fufDvuaARTDMItAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691597; c=relaxed/simple;
	bh=dhl7NnQZA6RuBeoRL8M3wAAP2Cb+ro/9yQQiKaw4C/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KzqhdZmr+k4+WIUuETqgVwvSJ+TWeh6/lVYK2xcHxfhDWL4Xw2DAMqO5/b0p2P4y+M09pI5zCOEnjGMn99Nc4cAuR9szuNZeFJKie0qbyAmDWmSwrK2lS8HXg5fHQZTbXAYYKtep34IOFI46HqvVXLlj7q6XsCcG71+lNWyYg2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LlzKjVG+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PsMbG1hc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LlzKjVG+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PsMbG1hc"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQXjY017382;
	Wed, 23 Oct 2024 13:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Q5N+HSbhwrHH/efhu68vccLLKmbaz3aO3DlorBmpHl8=; b=
	LlzKjVG+ZGCcZtpqYWgIcnxtvTuUCoJSPk7BlDXG+h1Eu+mm4fmv9eK/hb5riutF
	2iPm8o/JtlFWcjzYRL+Id9XpNMQJNYhmQUsf4jxLb5a9P7Jikgkr+1Ml5AlPVp4W
	HtOPPdpv8mynTYMHIHo/ecmn+NNeiO9IpNgWtTtlDyR7UrRxbEAccvdWmYd78swS
	+Xp1uMwj1tjHXAtcfM4ArNWimTsp/bZ99HFXQ26RBy+e+gY08W1WSwGN1JNcD44D
	1YZN6x8IldqUldw3qk+lglPPby+9s7ywZEc31K6u3/oVQYGlCPdvhqCV8JlEmgVc
	SkHRHFlEsjUt5pN4yNVhzQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c54589m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:53:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NCVn5c035989;
	Wed, 23 Oct 2024 13:53:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2j8sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkEnQf+BzYJC2ZAj6ygzMu+oxbcTRQJHFo6GzYOV44CEUtmC/o7Xs5yIJzKvC9bTR2s4g6VQPNEaSPiALcz8lW+z/waQ2ODhfyLOCKAQ8bmygEF0bHTDn1y0iMrAL/kwuUwM2PSkMS6SFX+pt4wMyLHdAqN+NLJQpPqI3BPXEnFKlk0uXP40+U5RumlVxSTHR1D1BVlnSbtcPIPeM5YkqWRlSbz4SsYsw+SWsVv2pTh7q/dS55k/LOsmfkuRKyZHxpcLLC5Vvq8ZCUVQsV3wlrrv74xG1m/CuNFRzLhQ+y6EnJ0IoeeCfWoub+b0JbOS/SDJAQ7KvDBqXT23bHbRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5N+HSbhwrHH/efhu68vccLLKmbaz3aO3DlorBmpHl8=;
 b=bU102MJRIPjgjRTS0/DqmOLaAq89FNkIbV8MJiel73gnZBKtnSeePs1ODMcadI6lvUjzX76A5Lbu0TK7R/8hocDjz+j+m0/rDhQH8RkBim0K4H6y9d+obFPkmQIM8Pd3zFugnGmvz7tGn9geqg1nVjUJikKAVZCGBWJ4sH6oui98SJyantBVGMvsB9ydKHZA1TD0uvm7Cef1lTbkXmGv8PhXFq43K7IMNldP6OdaqAIKqqa86Ai+kPm1hYYXjH8y6Bv6KBFEc3cnMlyUjS3m9hTlwF1j19ieIyKTJMlCh7Qh7Sjb83fgTX0TnMr7DPSGWVrEs2wwAZkxxo1w/v2Ldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5N+HSbhwrHH/efhu68vccLLKmbaz3aO3DlorBmpHl8=;
 b=PsMbG1hcEuLBvzS7JpQhy6X1/F2RemSJfb5fftTiHAXr/NTYgi9baiLtLz2RUnBmS5nYQu95dz3AM7SFM2yXzBzNJSeeg5pfYtVMKu8+LZPzVVhv9VWPD9TfxBt8dWi4R3jfOLWo+FSPq1EzT3NlOZfo3z5/B5nEPhUjaZFNueU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6581.namprd10.prod.outlook.com (2603:10b6:303:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 13:53:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:53:02 +0000
Message-ID: <2f39f873-6a5a-40d8-8d10-723c614593fe@oracle.com>
Date: Wed, 23 Oct 2024 09:52:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 9/9] iommufd: map file selftest
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-10-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1729630838-24586-10-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:408:ed::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: f62fcd43-de81-4321-e35e-08dcf36a02cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZndmT3ZJRkRmaFVxZzJvMEtBU05UU3ZjUnpsTnlRL0RTQm1xNW9VSXo4Tjkw?=
 =?utf-8?B?QWtvbTBOOVBlK2w2ejBQanh3ZGpGY2NVckszTnNFcC81dVRtWnFQUWNHall1?=
 =?utf-8?B?bWRET0N5RHNqUURLVGg5M0swOEY4czU5OTRMUWx1MTk4bGxwU2ZEZ3BkUzF6?=
 =?utf-8?B?WERadWlrVFd0NzV2TUNkNUVWbnRiVzZLU0ZGYW5YYlExMnhXNjAzZ0Rna2Rt?=
 =?utf-8?B?cExUWmszLzJZSHN3UUp2VE1BN25yT0RRTXhweXJWOWRIeGs5cmR2OGdYVXpj?=
 =?utf-8?B?bE50K1M5UmdHaVc4cjNSdCtiUU82WlFCY2R5Q0hUd0FCZkEzdWV2SUxjblA2?=
 =?utf-8?B?MnU2bkpmRkJpU2c2TEVvSXBqQkFXNUFMUUNjQmlkT1ZrYUdEeWdzSjhjSGda?=
 =?utf-8?B?L1ErYjY5RWNOYUxJQjBjUEhhZ3ZlVmwvdG9Udm9HR0VsN2NaSzVFODVnNk81?=
 =?utf-8?B?blFtNC9nNXpBb0NFQ2Jqb2pGdEk0bi9IdWRPYzhXNHpHWlRkTVpOL2FVcUoz?=
 =?utf-8?B?Qy9CaXRuMkJxRTBhWGs4R05xd3BmaEZoQWRRd2c5bWUrYlN5ZCtvS1lBaUZ3?=
 =?utf-8?B?eXpYSVlGVk1wNFBhMWdYdlJQbk00azh6UEwvUWxNR292VStnOFU2Umo1cmhS?=
 =?utf-8?B?T2RCKzZQMXRlNmZyTmhVN1pRU0JQYjl6amlLZ2JUUFhxWUF2ZVNobjRwdURx?=
 =?utf-8?B?aDJHc3cxbmIwbHpFYTg3N1g3TW81bVpUOEwwei9XRWpsZ2dKLzlvZWhDdzBZ?=
 =?utf-8?B?TFR3UUdWQ2pQSjI0clFEcmJqMXRjRU1xSWEwRWYvL3pXRVZ5eUJaSWlMaU5N?=
 =?utf-8?B?L2t6RW5ua05uZk9aZldDMUYzZjVna25qbDU3Y3ErL29rS3dxZU5ta2FBYkc2?=
 =?utf-8?B?KzJQU3FOM2VFVFM0RCtZcWh1emcvNHVJK2Z6WkJyVEpFVml6WW1wVG03cENv?=
 =?utf-8?B?WUQvZWozaitVejFOVkhLdk90YTUzc05rcCtIdWZLd3dzOCtQM3FudzJNdHhm?=
 =?utf-8?B?cjFvWWYzNFozMTJLQTdHNXNjTzVJalJzOFI3b1A2NTNWOTZtOG5Zb1RYQkc5?=
 =?utf-8?B?Z0NSbXlWNXNKdjc1aE1FZ1NLcDFZaWRoWVgzY2p1WHdNQUdHSWpTazh3cXV1?=
 =?utf-8?B?a1NrMmZ0eURod2lUemdUWm94U2tMN21SQkRDUXRmalFpeDViV29mcjBXNUwz?=
 =?utf-8?B?ME1qWjJzRWxENTVzTUhjb0FNQ2pkVXloQ1VpcXVYSElkZU5IMEQwNURyWUM1?=
 =?utf-8?B?dlNNaWh6QnYvb1pDQi92RWRUaVhmL0d6a0tQdzIxWVNCTFA4dkl0N01ReHpG?=
 =?utf-8?B?T0cza3pNWVZjeWRDMnlmdHNDVVY3YXZDQlpmSVJvSkxuY0ZESFViR1BsYkhD?=
 =?utf-8?B?b21LcUprbjBqZVV0M1JFa2d5Y2QzeENreFhBRlNpZGxMWnJXdUU1V2FpYW0x?=
 =?utf-8?B?bERaK09udzlNUjdOTTZJUk1RTHdIUE1zL3FXdjdBY3U3aW9sVzBob3ppeHZ1?=
 =?utf-8?B?QzRkb0RyUUo3eEdSZVhjSG9ZT09wTy9MeG1NVEdibmh1TjRONEs0ejluaUFK?=
 =?utf-8?B?SW41aEovdGxHUCtvYyt3UUN0bG1IcnZMZFRKV1RaTENUbE9YSWphcTN5Rmg4?=
 =?utf-8?B?UU10REZFWHBlK1RicUhCejNoYXZMYzlyVzVRaUhxZlNiT3d6WE9TTFdhYVBF?=
 =?utf-8?B?S3VseDdpNjV4a2VKTWJJd0RFc0Exb2JVQUNpeTMwT0VjaWdYUm9FWVRFclc0?=
 =?utf-8?Q?wUAbT+km2mo1rC8OqItU9VFrtlu4N/gmVLIjU6/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk5NcXdsVExiWTBGM2QvT3FVNk80UEJpbVc4SUFJQXNndFlGZitqMmZPSnZa?=
 =?utf-8?B?L2lVYWpMMUhENVVheERIWWhSRUwyQk10RVJwenp0Y21neDBqODhCT0pVSkF5?=
 =?utf-8?B?aElNOWxRZEptay94cjB1Z1ZCOHJzQjBTeEpQVnZlVVFjN3U3dndWUEU1WkZa?=
 =?utf-8?B?dDFnWVd2MVNEdGxubDBDc2hBdHQyWDNDSFljY0d2UnRLaCtpWDN5S01uQVpa?=
 =?utf-8?B?UXlOWVlVNVFVNzNrejIyVmJtWHN1MVAyS0RDNGdzR1RUNHhrNU9vU3V3SzVP?=
 =?utf-8?B?UTJMT3Zvb3F0YjlBdWxVczFiNGRKamNhYjd4TkhyNXRlNk1yQS8wS093T3FO?=
 =?utf-8?B?R051MnVDa254Ti9pRnZ1SXFGVWd3TGM5cnEzQ2ZqZGRSRTFTRkluTy9XMVBI?=
 =?utf-8?B?V1o1TldqUVNnczYwQUxYeXdUajJwa0Yxd093eStwUEhacHNVS3VudHduSkxY?=
 =?utf-8?B?bk5iYjM2bHZ1c0IvQTRwNkF2eTJPYTduQXhKVE5YWFBrM3JNYnk0YlR0RlF6?=
 =?utf-8?B?d2dtcEdGYlNTWlJwc3o0SDZjemNZQlRaNjdpYk9VVnQ4WmNsb3M4MEZTY3Vs?=
 =?utf-8?B?aGFiZEdYMzlxNUdLNUxoaU11L3hPU0ZzL09WdDI2alI5RW1JTXM1UGZaMGE5?=
 =?utf-8?B?UDFtL0N5b3lySWdrd21FRk9KKzM1Z0VKT21ObzBiais0ZmtsMkxtMWMrYWJh?=
 =?utf-8?B?WCtzOW9hUkE4NmR3b0FxZWNiS1Q5YWVhT2xVaFl6RzkxcVEvbVowVm1JQ0tQ?=
 =?utf-8?B?QkdRc0lwNmNZVGF6UHJPRWhHYkVsV3JqcnBjc09OTGtMb0sveFRjR2h1NEJ3?=
 =?utf-8?B?bkhxMVkvUHZBSzVNWXc3MVVWbTJtWVR0NkpNUjVHd1RxWFJKUXErdVg0VkRo?=
 =?utf-8?B?MjdBN2RJd1o3Vkp6YzlCUUtYQ05jQVpvWVRSMkEvUHMwN1ZuTVYreTgrR1Ay?=
 =?utf-8?B?RnkzYVF4U3JpS2w3cDFUUmZCSVRaS1RKcnBHWFVZRDRPRzF1aW1uWXdXRWc4?=
 =?utf-8?B?THdlK0pSK1dHcU5MVTRINWhybG9mcU5HdTMzbHc4YkVvSlNQUnFmWGh0bzA1?=
 =?utf-8?B?UndGUGEvbmdISFprWEh3THhnNEV3RzdiQ3pld2FFL2N5cG9DcXo3T3MvSmhF?=
 =?utf-8?B?eXZGOXdLd3JiandrUG1rSllVKzRTdFQ1MlRZMU9jSEtYUFlzU05XdGNLMm8v?=
 =?utf-8?B?SGhiNE1Ed08xOXl3YTZyOU55M2ZKMDhGdmVYalBtOUxxTGxKdCsyWkpNQ0xB?=
 =?utf-8?B?c0RZbEtNeEtOUUhVUUV4NG13QlJIVTRmY3o0K05rOVZabiswNURsVHNCMEx2?=
 =?utf-8?B?cU1pSG1nWDVsN2Y0cE4xWFEvU0s1eUZWSG5GZjVHUzN5dUtMOUgvbU52a3d0?=
 =?utf-8?B?NjVYclZoeVAvZEF4ZCtBOW50MXhMKzhJYnM2Nm5NQjFnSE0xcWc0ODlUdW1R?=
 =?utf-8?B?UnNYcEg0Z2FLRTZrcndJY0o3dDNKcEk5L0pDRUNERjJJMmp6OUIzM0JMak4w?=
 =?utf-8?B?bWdiK2QwUGhPMUw0UlRJZVlndEZ5azZxNlh5QTJaTXVHOEdQSEcwTDlpR2Rv?=
 =?utf-8?B?bXQwQzZybjlVQm0xVmtUT2QzR3pKZXNPWnNzR01Kd3RkWnpKbnc4ek5wWXl4?=
 =?utf-8?B?YzNYd3dJcVBBNXJleVg5U3Uwajhrb0g0dXlmZzNhL25zajYvWjFUdDZEcTY0?=
 =?utf-8?B?Q3dMUXJSbndSd2NJcnZZbUtpMnBMNmJRSy9mRjZLa1owdXpza3dCdkVCWkR6?=
 =?utf-8?B?ZFBjdHlUWEt3SXB0L3hoRkxGM25BY0FtMnRlTVVZZHc1MGpVb0s5T254Y3A4?=
 =?utf-8?B?UGg4ZEwyMldaN1hET1hBN2NGajQ5YmxhV1hQdXFzamIydHcvbExIWkV6SmFB?=
 =?utf-8?B?dUpqQ08wQUE1Zmc2clF0VDJaS2JWL1Z3UjJvZzlqZDI0OStGeFhDU21pdUNx?=
 =?utf-8?B?anc3dFoxanlsempHYXBXOTFSRUd1cE1UUmFiRFIvOExoTUhWR1FYSmRsSlF4?=
 =?utf-8?B?Y0lUS2tFYXFtc0ZaUzVHaFRXL0Y2WEpweVM2TlUwZEpZVHNYa3Q3dlJRSnVt?=
 =?utf-8?B?RWU0S1RCTE1lOU5ldjhoelg4aEVjR2FpVlFOZmtEQnZEMnY4UDNSNmZPVVRs?=
 =?utf-8?B?bXBOb0hlRXBiSXZZQUNKUVVpTmFUcXhaWEtSbEswZFRXZDJWTjlJZVZLME1T?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zhmBEazNlbryTRK0bzxPhghy68Rjc8MVgXIoqr9n8llVYESdXgjyfEh+OEUi9vymVZ97GA5rRpiHm+23Haq33B6aREiWcF3GZNcZgMV3LpnvsIrpBX3JXdze0bF3TMl2OOAIZzGdHQ/7/JWRFi013lrqBSiz/EbBCKjEtlMnQvJq03FozfNPCqjOVJOaARVr2+0O2B3J10/us1bfg8llIH7egWNLg9W9zH9IR9TWBLv+NrkiceXmeQnGxEM2PVG4sMCHsV3YLxVQEBMiS8v/0sJOyNEQ6l4vWQxQhcKpbGlnaUL4WI3Hojn5dQTKuwabZYHP1oYIEyE/qIhQBj7x+wkI5lM6G9Km2qS5Nf0Zo4ymxwlxUrpx1zo3sAvamGyUos1v0qIPItacFhYiPTMbear/j2qh+1DROLOEwWu9g4rdpbGAbO1RM7qQnvLPKQGbk6uxOMt3ltpMtGKkmmK/C66ZBIXnWgBT0RNklzlM/Rt0K5hCQ4KpyGB6kkKerCAZSd1ZlLFzeyPp1zQBR9XlqqE7LaiIfX0jyk8+ln3guuXBVlVVAOMwK1PhDvlptsMSRP8pFMqRpn0MqlbZRmHIzfi79dcNSCcplG79oX2MHHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62fcd43-de81-4321-e35e-08dcf36a02cc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:53:02.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HM8L5MvGWWHsqJlaQobm07We+tBKIwhkvf7u9DroyfA33xXHFMXaY5KeW6Ii20ta1h2O2CL0jXvjI7LKlMoaNmJKWcnB0tkwT7IGcDik9Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_11,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230083
X-Proofpoint-ORIG-GUID: -c2Fp3o0EjV_tUmxC0i5b1OalzmLSFxy
X-Proofpoint-GUID: -c2Fp3o0EjV_tUmxC0i5b1OalzmLSFxy

Who is willing to send an RB for this patch?
All new and old iommufd and iommufd_fail_nth tests pass.

- Steve

On 10/22/2024 5:00 PM, Steve Sistare wrote:
> Add test cases to exercise IOMMU_IOAS_MAP_FILE.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   tools/testing/selftests/iommu/iommufd.c          | 136 ++++++++++++++++++++---
>   tools/testing/selftests/iommu/iommufd_fail_nth.c |  39 +++++++
>   tools/testing/selftests/iommu/iommufd_utils.h    |  57 ++++++++++
>   3 files changed, 217 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 4927b9a..3d62951 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -3,6 +3,7 @@
>   #include <stdlib.h>
>   #include <sys/mman.h>
>   #include <sys/eventfd.h>
> +#include <asm/unistd.h>
>   
>   #define __EXPORTED_HEADERS__
>   #include <linux/vfio.h>
> @@ -49,6 +50,9 @@ static __attribute__((constructor)) void setup_sizes(void)
>   	vrc = mmap(buffer, BUFFER_SIZE, PROT_READ | PROT_WRITE,
>   		   MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>   	assert(vrc == buffer);
> +
> +	mfd_buffer = memfd_mmap(BUFFER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> +				&mfd);
>   }
>   
>   FIXTURE(iommufd)
> @@ -128,6 +132,7 @@ static __attribute__((constructor)) void setup_sizes(void)
>   	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP, length);
>   	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
>   	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
> +	TEST_LENGTH(iommu_ioas_map_file, IOMMU_IOAS_MAP_FILE, iova);
>   #undef TEST_LENGTH
>   }
>   
> @@ -1372,6 +1377,7 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   {
>   	unsigned int mock_domains;
>   	bool hugepages;
> +	bool file;
>   };
>   
>   FIXTURE_SETUP(iommufd_mock_domain)
> @@ -1410,26 +1416,45 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   {
>   	.mock_domains = 1,
>   	.hugepages = false,
> +	.file = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains)
>   {
>   	.mock_domains = 2,
>   	.hugepages = false,
> +	.file = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_hugepage)
>   {
>   	.mock_domains = 1,
>   	.hugepages = true,
> +	.file = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains_hugepage)
>   {
>   	.mock_domains = 2,
>   	.hugepages = true,
> +	.file = false,
>   };
>   
> +FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_file)
> +{
> +	.mock_domains = 1,
> +	.hugepages = false,
> +	.file = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_file_hugepage)
> +{
> +	.mock_domains = 1,
> +	.hugepages = true,
> +	.file = true,
> +};
> +
> +
>   /* Have the kernel check that the user pages made it to the iommu_domain */
>   #define check_mock_iova(_ptr, _iova, _length)                                \
>   	({                                                                   \
> @@ -1455,7 +1480,10 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   		}                                                            \
>   	})
>   
> -TEST_F(iommufd_mock_domain, basic)
> +static void
> +test_basic_mmap(struct __test_metadata *_metadata,
> +		struct _test_data_iommufd_mock_domain *self,
> +		const struct _fixture_variant_iommufd_mock_domain *variant)
>   {
>   	size_t buf_size = self->mmap_buf_size;
>   	uint8_t *buf;
> @@ -1478,12 +1506,52 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	test_err_ioctl_ioas_map(EFAULT, buf, buf_size, &iova);
>   }
>   
> +static void
> +test_basic_file(struct __test_metadata *_metadata,
> +		struct _test_data_iommufd_mock_domain *self,
> +		const struct _fixture_variant_iommufd_mock_domain *variant)
> +{
> +	size_t buf_size = self->mmap_buf_size;
> +	uint8_t *buf;
> +	__u64 iova;
> +	int mfd_tmp;
> +	int prot = PROT_READ | PROT_WRITE;
> +
> +	/* Simple one page map */
> +	test_ioctl_ioas_map_file(mfd, 0, PAGE_SIZE, &iova);
> +	check_mock_iova(mfd_buffer, iova, PAGE_SIZE);
> +
> +	buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd_tmp);
> +	ASSERT_NE(MAP_FAILED, buf);
> +
> +	/* EFAULT half way through mapping */
> +	ASSERT_EQ(0, munmap(buf + buf_size / 2, buf_size / 2));
> +	test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
> +
> +	/* EFAULT on first page */
> +	ASSERT_EQ(0, munmap(buf, buf_size / 2));
> +	test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
> +
> +	close(mfd_tmp);
> +}
> +
> +TEST_F(iommufd_mock_domain, basic)
> +{
> +	if (variant->file)
> +		test_basic_file(_metadata, self, variant);
> +	else
> +		test_basic_mmap(_metadata, self, variant);
> +}
> +
>   TEST_F(iommufd_mock_domain, ro_unshare)
>   {
>   	uint8_t *buf;
>   	__u64 iova;
>   	int fd;
>   
> +	if (variant->file)
> +		SKIP(return, "redundant test");
> +
>   	fd = open("/proc/self/exe", O_RDONLY);
>   	ASSERT_NE(-1, fd);
>   
> @@ -1513,9 +1581,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	unsigned int start;
>   	unsigned int end;
>   	uint8_t *buf;
> +	int prot = PROT_READ | PROT_WRITE;
> +	int mfd;
>   
> -	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
> -		   0);
> +	if (variant->file)
> +		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
> +	else
> +		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
>   	ASSERT_NE(MAP_FAILED, buf);
>   	check_refs(buf, buf_size, 0);
>   
> @@ -1532,7 +1604,12 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			size_t length = end - start;
>   			__u64 iova;
>   
> -			test_ioctl_ioas_map(buf + start, length, &iova);
> +			if (variant->file) {
> +				test_ioctl_ioas_map_file(mfd, start, length,
> +							 &iova);
> +			} else {
> +				test_ioctl_ioas_map(buf + start, length, &iova);
> +			}
>   			check_mock_iova(buf + start, iova, length);
>   			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
>   				   end / PAGE_SIZE * PAGE_SIZE -
> @@ -1544,6 +1621,8 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	}
>   	check_refs(buf, buf_size, 0);
>   	ASSERT_EQ(0, munmap(buf, buf_size));
> +	if (variant->file)
> +		close(mfd);
>   }
>   
>   TEST_F(iommufd_mock_domain, all_aligns_copy)
> @@ -1554,9 +1633,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	unsigned int start;
>   	unsigned int end;
>   	uint8_t *buf;
> +	int prot = PROT_READ | PROT_WRITE;
> +	int mfd;
>   
> -	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
> -		   0);
> +	if (variant->file)
> +		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
> +	else
> +		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
>   	ASSERT_NE(MAP_FAILED, buf);
>   	check_refs(buf, buf_size, 0);
>   
> @@ -1575,7 +1658,12 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			uint32_t mock_stdev_id;
>   			__u64 iova;
>   
> -			test_ioctl_ioas_map(buf + start, length, &iova);
> +			if (variant->file) {
> +				test_ioctl_ioas_map_file(mfd, start, length,
> +							 &iova);
> +			} else {
> +				test_ioctl_ioas_map(buf + start, length, &iova);
> +			}
>   
>   			/* Add and destroy a domain while the area exists */
>   			old_id = self->hwpt_ids[1];
> @@ -1596,15 +1684,18 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	}
>   	check_refs(buf, buf_size, 0);
>   	ASSERT_EQ(0, munmap(buf, buf_size));
> +	if (variant->file)
> +		close(mfd);
>   }
>   
>   TEST_F(iommufd_mock_domain, user_copy)
>   {
> +	void *buf = variant->file ? mfd_buffer : buffer;
>   	struct iommu_test_cmd access_cmd = {
>   		.size = sizeof(access_cmd),
>   		.op = IOMMU_TEST_OP_ACCESS_PAGES,
>   		.access_pages = { .length = BUFFER_SIZE,
> -				  .uptr = (uintptr_t)buffer },
> +				  .uptr = (uintptr_t)buf },
>   	};
>   	struct iommu_ioas_copy copy_cmd = {
>   		.size = sizeof(copy_cmd),
> @@ -1623,9 +1714,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   
>   	/* Pin the pages in an IOAS with no domains then copy to an IOAS with domains */
>   	test_ioctl_ioas_alloc(&ioas_id);
> -	test_ioctl_ioas_map_id(ioas_id, buffer, BUFFER_SIZE,
> -			       &copy_cmd.src_iova);
> -
> +	if (variant->file) {
> +		test_ioctl_ioas_map_id_file(ioas_id, mfd, 0, BUFFER_SIZE,
> +					    &copy_cmd.src_iova);
> +	} else {
> +		test_ioctl_ioas_map_id(ioas_id, buf, BUFFER_SIZE,
> +				       &copy_cmd.src_iova);
> +	}
>   	test_cmd_create_access(ioas_id, &access_cmd.id,
>   			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
>   
> @@ -1635,12 +1730,17 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			&access_cmd));
>   	copy_cmd.src_ioas_id = ioas_id;
>   	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
> -	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
> +	check_mock_iova(buf, MOCK_APERTURE_START, BUFFER_SIZE);
>   
>   	/* Now replace the ioas with a new one */
>   	test_ioctl_ioas_alloc(&new_ioas_id);
> -	test_ioctl_ioas_map_id(new_ioas_id, buffer, BUFFER_SIZE,
> -			       &copy_cmd.src_iova);
> +	if (variant->file) {
> +		test_ioctl_ioas_map_id_file(new_ioas_id, mfd, 0, BUFFER_SIZE,
> +					    &copy_cmd.src_iova);
> +	} else {
> +		test_ioctl_ioas_map_id(new_ioas_id, buf, BUFFER_SIZE,
> +				       &copy_cmd.src_iova);
> +	}
>   	test_cmd_access_replace_ioas(access_cmd.id, new_ioas_id);
>   
>   	/* Destroy the old ioas and cleanup copied mapping */
> @@ -1654,7 +1754,7 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			&access_cmd));
>   	copy_cmd.src_ioas_id = new_ioas_id;
>   	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
> -	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
> +	check_mock_iova(buf, MOCK_APERTURE_START, BUFFER_SIZE);
>   
>   	test_cmd_destroy_access_pages(
>   		access_cmd.id, access_cmd.access_pages.out_access_pages_id);
> @@ -1667,6 +1767,9 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   {
>   	uint32_t ioas_id;
>   
> +	if (variant->file)
> +		SKIP(return, "redundant test");
> +
>   	test_ioctl_ioas_alloc(&ioas_id);
>   
>   	test_cmd_mock_domain_replace(self->stdev_ids[0], ioas_id);
> @@ -1697,6 +1800,9 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   {
>   	int i;
>   
> +	if (variant->file)
> +		SKIP(return, "redundant test");
> +
>   	for (i = 0; i != variant->mock_domains; i++) {
>   		uint32_t hwpt_id[2];
>   		uint32_t stddev_id;
> diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> index c5d5e69..111d43e 100644
> --- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
> +++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> @@ -47,6 +47,9 @@ static __attribute__((constructor)) void setup_buffer(void)
>   
>   	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
>   		      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	mfd_buffer = memfd_mmap(BUFFER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> +				&mfd);
>   }
>   
>   /*
> @@ -331,6 +334,42 @@ void __fail_nth_enable(struct __test_metadata *_metadata,
>   	return 0;
>   }
>   
> +/* iopt_area_fill_domains() and iopt_area_fill_domain() */
> +TEST_FAIL_NTH(basic_fail_nth, map_file_domain)
> +{
> +	uint32_t ioas_id;
> +	__u32 stdev_id;
> +	__u32 hwpt_id;
> +	__u64 iova;
> +
> +	self->fd = open("/dev/iommu", O_RDWR);
> +	if (self->fd == -1)
> +		return -1;
> +
> +	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
> +		return -1;
> +
> +	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
> +		return -1;
> +
> +	fail_nth_enable();
> +
> +	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
> +		return -1;
> +
> +	if (_test_ioctl_ioas_map_file(self->fd, ioas_id, mfd, 0, 262144, &iova,
> +				 IOMMU_IOAS_MAP_WRITEABLE |
> +					 IOMMU_IOAS_MAP_READABLE))
> +		return -1;
> +
> +	if (_test_ioctl_destroy(self->fd, stdev_id))
> +		return -1;
> +
> +	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
> +		return -1;
> +	return 0;
> +}
> +
>   TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
>   {
>   	uint32_t ioas_id;
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 40f6f14..c708dc1 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -40,12 +40,28 @@ static inline bool test_bit(unsigned int nr, unsigned long *addr)
>   static void *buffer;
>   static unsigned long BUFFER_SIZE;
>   
> +static void *mfd_buffer;
> +static int mfd;
> +
>   static unsigned long PAGE_SIZE;
>   
>   #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
>   #define offsetofend(TYPE, MEMBER) \
>   	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>   
> +static inline void *memfd_mmap(size_t length, int prot, int flags, int *mfd_p)
> +{
> +	int mfd_flags = (flags & MAP_HUGETLB) ? MFD_HUGETLB : 0;
> +	int mfd = memfd_create("buffer", mfd_flags);
> +
> +	if (mfd <= 0)
> +		return MAP_FAILED;
> +	if (ftruncate(mfd, length))
> +		return MAP_FAILED;
> +	*mfd_p = mfd;
> +	return mmap(0, length, prot, flags, mfd, 0);
> +}
> +
>   /*
>    * Have the kernel check the refcount on pages. I don't know why a freshly
>    * mmap'd anon non-compound page starts out with a ref of 3
> @@ -589,6 +605,47 @@ static int _test_ioctl_ioas_unmap(int fd, unsigned int ioas_id, uint64_t iova,
>   	EXPECT_ERRNO(_errno, _test_ioctl_ioas_unmap(self->fd, self->ioas_id, \
>   						    iova, length, NULL))
>   
> +static int _test_ioctl_ioas_map_file(int fd, unsigned int ioas_id, int mfd,
> +				     size_t start, size_t length, __u64 *iova,
> +				     unsigned int flags)
> +{
> +	struct iommu_ioas_map_file cmd = {
> +		.size = sizeof(cmd),
> +		.flags = flags,
> +		.ioas_id = ioas_id,
> +		.fd = mfd,
> +		.start = start,
> +		.length = length,
> +	};
> +	int ret;
> +
> +	if (flags & IOMMU_IOAS_MAP_FIXED_IOVA)
> +		cmd.iova = *iova;
> +
> +	ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &cmd);
> +	*iova = cmd.iova;
> +	return ret;
> +}
> +
> +#define test_ioctl_ioas_map_file(mfd, start, length, iova_p)                 \
> +	ASSERT_EQ(0, _test_ioctl_ioas_map_file(self->fd, self->ioas_id, mfd, \
> +					       start, length, iova_p,        \
> +					       IOMMU_IOAS_MAP_WRITEABLE |    \
> +						   IOMMU_IOAS_MAP_READABLE))
> +
> +#define test_err_ioctl_ioas_map_file(_errno, start, length, iova_p)	     \
> +	EXPECT_ERRNO(_errno,                                                 \
> +		     _test_ioctl_ioas_map_file(self->fd, self->ioas_id, mfd, \
> +					       start, length, iova_p,        \
> +					       IOMMU_IOAS_MAP_WRITEABLE |    \
> +						   IOMMU_IOAS_MAP_READABLE))
> +
> +#define test_ioctl_ioas_map_id_file(ioas_id, mfd, start, length, iova_p)     \
> +	ASSERT_EQ(0, _test_ioctl_ioas_map_file(self->fd, ioas_id, mfd,       \
> +					  start, length, iova_p,             \
> +					  IOMMU_IOAS_MAP_WRITEABLE |         \
> +						  IOMMU_IOAS_MAP_READABLE))
> +
>   static int _test_ioctl_set_temp_memory_limit(int fd, unsigned int limit)
>   {
>   	struct iommu_test_cmd memlimit_cmd = {

