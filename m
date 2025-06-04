Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F842AA9
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053786; cv=fail; b=daPt4XfXOJlVliHjpoKibYPG4e85Q2Co3+dphGcf9TLNLXg+6FMVKRhQk/1F5YU1WzpI9DaUQ/mtW6TdN8FcWpEo82Z+/qec4Z6/AVrBZXrLSA7m3lMOHAXRDb9Upcef+nUiz4TBcDbPjHsIyHIVWxkrtt6lRfhkhqak6KRRwlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053786; c=relaxed/simple;
	bh=USfJuYM9dRU7iG77RUpC0Hm3coLzmOLl3ktUGw0MEsQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WG1wswc/j6uHKqDVfy53dFcSqKIosznzi8HZZWaiYVob6qEj1l6ThL75J2wssBPu/3ImkQF7pVk1JFPWjCIwhrda0BulpVSQ8bDNSektizm+ITrZZSpe3EXRRQKOPHWgdlvoeKbmTvx3Q36nHNEOapmZ80OQ0OYXRkwbG0/Nw4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UGutifWO; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UGutifWO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8bZ/t92FSoUF7lGf+390WJAvpM39s2s+wyXHAib689DUe6ivkgYZiHbbJotiwwlq3/bEbMH1yuP6Ml3Kve0zRw9njw3hAnTU94T+zQXbW459Sb/1/d3lsU2cTAQegoZpq29s/byYMrOf2xSwytsVqpJcAEbggs87ZRleI6e83143j4l3mCNYRPw51YvpUjYE+3CSd92gZh/6iP93BnZpnaOYwNS9H0Uoqh11RDA2T0ScpQC8s0LIweUQdF4mOIUs5RchiPKuUqPsRyw2Zee6RyFqvblske0T05Nmwt/WSu7HheJlRslOgDv8aGQr6H9AJq/tAK+5AbR1BQ1AaRA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtEJOoCK5XOWa3zUVY2KraHUJcWk8fEzPHPiSC7r29s=;
 b=XGwBKzlaixNuTOT1NWJOPVj+vP0dKF1SFCR81/B4ISn24Kbi9EJ6cAqH3I9hunp/foPH/Pgn2ngwcb7ZNGcOCg+r0AvikRvHjU2nOp4/ODl/NUso4nOmkBA1PCuRQEDQVm0KN4ccG37GntRWlvd9QBK0W85yehwwKMLz07Py1eWbXYhqE8equikWgUN+hnucxFzIlvu5q8Joplv3xFDUJKB5Otgy1zOIiHU4cv2lFIwV+0CPk+9I+BH7gX1g/ePhlPX9t5VeO1lV7+UC2G+m5go6Ago94H3ZVmOx1Qg/UNE0ERMVXJjTsvC5NIdQ6ZkwM1ojDHzbSC1AedM+LNErRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtEJOoCK5XOWa3zUVY2KraHUJcWk8fEzPHPiSC7r29s=;
 b=UGutifWOHvl65m/1AupnzkIJdCFVVziMrlBuZCS9uQCa4EuwjUb3Shr2vacUVd/+5tneOPYdti8XtrYeqCBuyLQtWEZpFTi07KPtp8wZpTU1NicCIjBVla4m03wUA3eW0HOH7NPZ5Ivu4OZjqUdN6GywcHRb5H3jFZHkUm6Lbh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by CH1PPF73CDB1C12.namprd12.prod.outlook.com (2603:10b6:61f:fc00::615) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Wed, 4 Jun
 2025 16:16:22 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 16:16:22 +0000
Message-ID: <58921dc3-aa6e-41bc-90d3-d25a4a2cce8b@amd.com>
Date: Wed, 4 Jun 2025 21:46:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] iommu/amd: Add debugfs support to dump IRT Table
To: Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
 <20250407173500.1827-8-dheerajkumar.srivastava@amd.com>
 <a7d4929b-f7ff-4ce5-800e-79df3816d9d6@amd.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <a7d4929b-f7ff-4ce5-800e-79df3816d9d6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::18) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|CH1PPF73CDB1C12:EE_
X-MS-Office365-Filtering-Correlation-Id: db83357f-09d0-42e2-dce7-08dda383259d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmFNQ0EzcURQUWt0MXFST3FFdXAxTVVXMitoQ2hna3RyUXE2VkxzYmovSGdk?=
 =?utf-8?B?aDl5MFYxVGY4eU9iNmdrM2dwMG5jaDR2d2F0dittTjFDdk5KdjJ1dXRRcElC?=
 =?utf-8?B?RVZEbjdzRkxPcGUyZDh0WmE3TWJNbGNIa0U0RHlLQmZnNHU2SldQbWFFVzk3?=
 =?utf-8?B?YzZ2N1k3Rlk0K0xJM3NxSHNINGlRWlFGcnMrWVRRNWJ5MXkvdDFmRzhiZUZz?=
 =?utf-8?B?eURPU1kyN1ora0NWdnpBODBZbUJLVFdTdFNHY21RYzdkZWRoZFhwa09GSXhz?=
 =?utf-8?B?TlQrVEFBQVBja1hES050V0xkMGhHRldtYXlPampmZWJLL1dXalgzZ1B3OFVl?=
 =?utf-8?B?eDM4MWhua1pLODJkM0VlWHIrUXZwRjlpR2paQmx5ZnkyRTNpN3M4OU9lUk50?=
 =?utf-8?B?cVRuUjNYTGV2Y0NzTmQrRWdKZWs2WUhIc1haUHk3RkZQMmRXaXZJWG9xUHl6?=
 =?utf-8?B?ZlZ3SmtqQmsyRnRSWlZxR2hxWWlQUkRUelN2YjBkQ2d6M1FTOUgrNzRyNWhF?=
 =?utf-8?B?M0hSc2tpNWR4VHpDTkEwRkZIREw1YmRGSHNRWkFVenhkVXhwbVdmeGlvS2Fj?=
 =?utf-8?B?UU1sMXM4SjJJazJUZGpUR0pjMGxJczlHdmlWUnhvQWtvR2RwVHRYOExqNVRU?=
 =?utf-8?B?QlFOdWRmV2c1ZzRMeUpVOHFub0srR1RnZG1lMXEyMDh3Mkt6dFJ0WWtOa1A2?=
 =?utf-8?B?Q2VCTlByWndtVzdvczNVejRqUERaa3JQUGFqZkxRb0Q4ZzF1Ymh2eitpSHMr?=
 =?utf-8?B?ZzBmRUdJOTI5bVRKZkxVUjBaV1hhdFpNK2FzZStYMlVNTG1udnF5bTNlSXZQ?=
 =?utf-8?B?QVkrd2ZUL1ArWEV6UVdmU3Bhc3NKaHdvN0JWYWxxd29qL0ZMOHE4c1VZRWtN?=
 =?utf-8?B?YU8yZ2RiWW1ZSkNnODh0Qi9vaU9BWmU0UW1HaGJ1VnBDa1dqSkM0OXZrMmk1?=
 =?utf-8?B?eUg0eDMvNU1DVWRFR21McjRwaklzd0JCN3oxb2p2S2RTbVdReHFkSGVVWFFL?=
 =?utf-8?B?ckRjeDd2YzZXM0Nxdjl6dU9lcGtZRnBBRkViOXhmQy9JVXF0SDV6K2M3WUJt?=
 =?utf-8?B?VVNHeUIwbEJzSUtFVkhnc3oyMEZkZTNFUFVsdWFFMHp0RTBSem5MdGpodmpP?=
 =?utf-8?B?UWFlYVNhY1hxbE05clptS2tEK0VNMnRFNW1sTjNQMndPMGpQWEFFaDdMbExV?=
 =?utf-8?B?RDB4bXV3bjZZMzVuWUVjN1V0amM0WHFvdThqNE5ZMWxWUGxWV0VhOU1nUkFE?=
 =?utf-8?B?SURIeWNTa0I4Ym5qaGhLS2d0V3hScmVkcTBpYW9zVjlHdkdtZDNtb1FmZUZ3?=
 =?utf-8?B?ZTd4aDA0Q0NLa0E2ZklzM2dUc0F0NjZmajg4OHl1Z0RLZDE0VzRuclJUZlhU?=
 =?utf-8?B?T083Wk9ySG9VVzNaLys5aVhMT0tUUVJUdFA5dGcyMVBNS0pLREw4c3A0aTI1?=
 =?utf-8?B?L3JyNkQ3dnJ5RkRmTjJ3TXhLaFdNclIrcG9rV2Z2Z0lKblFPZzdDZlZlcUE0?=
 =?utf-8?B?bkQwYzh2UXNWdjNKQnFlTHRxWlRTUUlUOGJGNldOOGE2MjVGT0hRNGs3VkpD?=
 =?utf-8?B?N0JVeENydE0xWWVTL29sWEcyeGRuZUx0KzdGbjVKTTBEVG9lSmg4ZkZpNTg4?=
 =?utf-8?B?T3pISmE2QXRLQTNPTENVcFBZNkNwZy9JK3JVREpJMnJPWUhZN0V5bGNudmR3?=
 =?utf-8?B?azhoUktiYUllMzFuQWNLaTRaTG9PS1NwWUk4cGhaUDcyaExoZE5NaVFRbFRo?=
 =?utf-8?B?SUR0aFRTcU1Qay9mQjV5ZkhsZkpVamxhSmtRM2NsbUxkMjZPV0dHR254K1o0?=
 =?utf-8?B?cHM1djdQRllCd2ZUYWg5eWVnaVRVOEFLeGdWb3RWLzhnajVKeW5Hc0V1b3Js?=
 =?utf-8?B?elMxMWU0RVNmS1BJMHhReWFvY01sNVYxNjY5UEdvVVhaRUk4VGptZ1Z0UTUw?=
 =?utf-8?Q?yra1w11V3sg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGxCNU8rOG83RHBVZjRoUU5WWDBlTUJqUkNLZXFJZUMvT3FDa3JvMFIyUUx4?=
 =?utf-8?B?aFAzbEo3aGFBSElucGJXME45ZzlLU0VQMlFzV2J2OUYvclRmK1FhUEZlQm4r?=
 =?utf-8?B?aG9icjVRbHB1TTJnMDNIdGswbEVaVGRtOUNWdDRpOGVsQ0I1Y1dxd0YzaGtW?=
 =?utf-8?B?SVlmbnVDSnd1ZnpoWVE3RG1PMWtFekFEcm1ENkRmZWxnOE85eGVxTjMxYWZz?=
 =?utf-8?B?VUpVUDZKODB0aWNiV294WWV1Y0ZHTWJjZnRhM1BQV0I5alNlckV1eEhqYzM3?=
 =?utf-8?B?UVVobnV5MWZFZ1l4Ri9aK1lVa2owbFFuNFVjMUJOSU1tZ0pkVE1KL2lCRWoy?=
 =?utf-8?B?V2tWdFA1UVNwMTgvZ1p6Q2hiQ0cvY04vTGJhWm8xTEhUK0ZmaHB3RDJHOCt5?=
 =?utf-8?B?NzYxUWdpdWVBeXlpK1c3d2FVNGRQMUY3WnZVU2JxTWVnYTFwY0VsZU1uL0JO?=
 =?utf-8?B?Wmptd2xPMEY5eFM3Mm8xZVJ5LzBLK0pwS2RrRTkyTGYvRVVTSWlWbHBaamxV?=
 =?utf-8?B?NkFiZjZKNlQvVFZTa3Z6YlN4MkRiQzRNSERSMHBNVkZGakZlc2RzQkFlR21M?=
 =?utf-8?B?WjFSS0hFZVBQcXJ3bGYwRGcwK3M4YnBwQnJZM3lRc29iYzR6ejl5TFMvTTNR?=
 =?utf-8?B?RVQ0RVc0eEE0aC9uVUxFK1Y3NFFkR1h0Ti9DQno5U0NTN2Q1b1JwQlgwbWtC?=
 =?utf-8?B?MENPY0xiL2RBMG1NZ3A0MUtzdUJKYmxKd1lDNTlQUGJSY2JzUy8zdEErakNl?=
 =?utf-8?B?QlBOMUxlNVJ3Y2Q2MmtRNDJZaGxXT1AzRlBtYm5EVlNkSDR0eEI4TVVlc3Bl?=
 =?utf-8?B?eFRoR09rVmFSSFNBQld5VHNacHh5SDZXZDhDUEtiMUlzbkpDM2tld3U0K0Rj?=
 =?utf-8?B?dnN2MXBiV0xnSi9PRHBteXR6N0MxVjd5ZWlIQUE5UFIwZEhCQmNPN1MybVJH?=
 =?utf-8?B?aXVXZ1N6NFVrM1J2MVlLK29SanJoaXU1b2ZVdGg1a3VwK0pPTTIxMDIyU0ty?=
 =?utf-8?B?NWlZWDgveVhSZlVNNlJtZGg2bjFkNm8vcjIrSndiU1BjTk0xZis3MG5QNmJm?=
 =?utf-8?B?dWZwQmhxQmg0UU1qWDVuZEFrR2kzVEpLaTFZa295S1J2eDN1RmZGUEZJNldW?=
 =?utf-8?B?WDFBUnhpUjExNW5jQzB2Y3czcW44K2V0b295dEM1RGlqZW5IbzcrNFp1WmZr?=
 =?utf-8?B?UCtDcDlFa0pRYWdjaG5UNjQ4TzNWOXVSem1uZk9lbnI2WUU2RUVNTXU5cW51?=
 =?utf-8?B?SnBaSm45elVQR3VqbFBieW9TL0thdUhTV2pGa1NiMFM4dUtuNXNBYTFNMHhv?=
 =?utf-8?B?TXZNU0ZkZ0NZZUQ2d3ROaE1ENDR5cmQ0N0cxdGpxSU00S1Z0S1dUNjR4cGta?=
 =?utf-8?B?N3lJaDFISkhwV0RoZjJ3blNLK3hUNGJ6eldWRTR5N1FkV0txWmx6RVdHbTk3?=
 =?utf-8?B?d2tKbnd1V3VIaUpJQ2VTM1pjeXhMTlEvK0FPVDg2d0t6dUFJUE9VRzNwdjFt?=
 =?utf-8?B?RzNwaTMyZ3lFRlRXdVZGWVRSU3ljb25aUWpMMzBFd1hvRkw3djA2cS9JcDFL?=
 =?utf-8?B?SVVBOExhRURoTTVhaHdaay9yV0s1RXZQbEdCbjM0S1c0bjhjZnZ2VVJvSEE2?=
 =?utf-8?B?RkdOYmdnRmZaeHZDWEU3L1FVZjRyOWN6ZkR4SWtkUkJrT1RFV3dMTWlNTk9L?=
 =?utf-8?B?UEhoY3l1NWtmSDc4ZlZ0MFZsZkhrSFNWRWppbkZvL0dWVjJNVk5USUh6aGY4?=
 =?utf-8?B?eldyVVVQSzBaVzVzUkRvWW12dTRTTUwrcXBxQ28xUkZBTlZIbGRjSFJpZTBP?=
 =?utf-8?B?RjVlbWZPaHZxbEpLQThUaDRTYUhNK0NqSkhZdUlXSSs2MXB2Qml0b3ZHaUE4?=
 =?utf-8?B?d2JmVGpYYWU1dWphS1JkRE5PZjc5cEhYS1VoOEQyRVlGTDFqLzRNRzFucWtT?=
 =?utf-8?B?YVNyTDZjdWdReVh2dU9Xa3dyREp4dDUza0FqMjRFWnN6Z0l6TkNSVjcvVit6?=
 =?utf-8?B?Z0xVbGlSczFuTGxpTVMvT2tHTWROZTFSWVFxQmQ5ZEYxRDV3TG1LeUxaNE1w?=
 =?utf-8?B?TjZCVFZKbmJnVmNZZVVwSFZiTGl4Q1ZGc2xKVVEzbE9nY0N6KzVYNE01V3RM?=
 =?utf-8?Q?uZnKj2JL23MO0wyVhwY4NjEEJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db83357f-09d0-42e2-dce7-08dda383259d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:16:22.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJdzjfznxvonsPcORKG6O6Iiu7eVc+hvsrJJteL6Fvzr0Pztqil9QZ+O01CgF9zFSTR6h59VUY3t729LCx+Ocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF73CDB1C12

Hi Vasant,

Thanks for reviewing the patch.

On 5/1/2025 3:36 PM, Vasant Hegde wrote:
> 
> 
> On 4/7/2025 11:04 PM, Dheeraj Kumar Srivastava wrote:
>> In cases where we have an issue in the device interrupt path with IOMMU
>> interrupt remapping enabled, dumping valid IRT table entries for the device
>> is very useful and good input for debugging the issue.
>>
>> eg.
>> -> To dump irte entries for a particular device
>>     #echo "c4:00.0" > /sys/kernel/debug/iommu/amd/devid
>>     #cat /sys/kernel/debug/iommu/amd/irqtbl | less
>>
>>     or
>>
>>     #echo "0000:c4:00.0" > /sys/kernel/debug/iommu/amd/devid
>>     #cat /sys/kernel/debug/iommu/amd/irqtbl | less
>>
>> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
>> ---
>>   drivers/iommu/amd/debugfs.c | 106 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 106 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
>> index c6ff47561afb..28fe546e0bc0 100644
>> --- a/drivers/iommu/amd/debugfs.c
>> +++ b/drivers/iommu/amd/debugfs.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/pci.h>
>>   
>>   #include "amd_iommu.h"
>> +#include "../irq_remapping.h"
>>   
>>   static struct dentry *amd_iommu_debugfs;
>>   
>> @@ -254,6 +255,109 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(iommu_devtbl);
>>   
>> +static void dump_128_irte(struct seq_file *m, struct irq_remap_table *table, u16 int_tab_len)
>> +{
>> +	struct irte_ga *ptr, *irte;
>> +	int index;
>> +
>> +	for (index = 0; index < int_tab_len; index++) {
>> +		ptr = (struct irte_ga *)table->table;
>> +		irte = &ptr[index];
>> +
>> +		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
>> +		    !irte->lo.fields_vapic.valid)
>> +			continue;
>> +		else if (!irte->lo.fields_remap.valid)
>> +			continue;
>> +		seq_printf(m, "IRT[%04d] %016llx %016llx\n", index, irte->hi.val, irte->lo.val);
>> +	}
>> +}
>> +
>> +static void dump_32_irte(struct seq_file *m, struct irq_remap_table *table, u16 int_tab_len)
>> +{
>> +	union irte *ptr, *irte;
>> +	int index;
>> +
>> +	for (index = 0; index < int_tab_len; index++) {
>> +		ptr = (union irte *)table->table;
>> +		irte = &ptr[index];
>> +
>> +		if (!irte->fields.valid)
>> +			continue;
>> +		seq_printf(m, "IRT[%04d] %08x\n", index, irte->val);
>> +	}
>> +}
>> +
>> +static void dump_irte(struct seq_file *m, u16 devid, struct amd_iommu_pci_seg *pci_seg)
>> +{
>> +	struct dev_table_entry *dev_table;
>> +	struct irq_remap_table *table;
>> +	struct amd_iommu *iommu;
>> +	unsigned long flags;
>> +	u16 int_tab_len;
>> +
>> +	table = pci_seg->irq_lookup_table[devid];
>> +	if (!table) {
>> +		seq_printf(m, "IRQ lookup table not set for %04x:%02x:%02x:%x\n",
>> +			   pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid));
>> +		return;
>> +	}
>> +
>> +	iommu = pci_seg->rlookup_table[devid];
>> +	if (!iommu)
>> +		return;
>> +
>> +	dev_table = get_dev_table(iommu);
>> +	if (!dev_table) {
>> +		seq_puts(m, "Device table not found");
>> +		return;
>> +	}
>> +
>> +	int_tab_len = 1 << ((dev_table[devid].data[2] >> 1) & 0xfULL);
> 
> This is hard to read. Please use the macros like FIELD_GET
> 
>> +	if (int_tab_len > 2048)
> 
> s/2048/MAX_IRQS_PER_TABLE_2K/

Sure I will use macros to fetch and validate IRT table length from DTE.

Thanks
Dheeraj

> 
> 
> -Vasant
> 
> 

