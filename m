Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EE24EF69
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861703; cv=fail; b=GsJ9TzX3WF65U6+gJYJJFkcRH5LQm3DMSG1gop2liiFJEjlnkxkVyXv4oIE83y2B0ksYLiCbXTk52cxz6pGosTlbzgEchTpUTkBNxMwuss265iE0ymdPlCXW/XGXsZoeaif1lqF7ggH6my/yAa1W0pevlh9KqNvlckURPxsxWkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861703; c=relaxed/simple;
	bh=qGJkHWtU5+vleI/UQAB5kdiMgT3x5O3tmIqD8w3z9+o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Db178EbCjZLeqM03801Ji6cHK+9bAc8Aq2Q40IQ1bddL7BqU3nlEAGJDSZBGf2thjP5mFgrbSMw7YpbPdn37136oPbfDjsUGKYlbva/2eykVnonlB2DJ3rPqn9+h9LlipfiD7bB+QBwTC7Fai0LnGEZFva86Nj0IYK6GWINCmRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sf8k///O; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sf8k///O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtpUhMqArOi/WCqUmFcBTVxOL6HeyIrbYYZeDC8mvF0kgoD8yJkmvqwAzkM5cIhvCWgT5Ag1EJ1GxmsQVu3ADvtvg3q5mC1d1lhoRx9t6Z+/CQYZ66dWzWsT/LXKyBcbFXZA3ZuUACZU0jUFbDqbNq3F8lYmcmuGUjlcX6fCfPnIc8tXdy3nMrMu4VjUeX10vs2NLArvNI03DWgOu0S4+r/z5ACg3RBAAd3UEKINeAnMxGUivoFhpybSJLwngwd+3GPGfvo/ebVpuV0ELfkS7jeWjeDao8yWN71S1IXBDoGwlrmjN4hxWvFnLUyOidQWTrCMKShce3kd7W1KDzyRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpClge/nUjUj2xL6hT2fzjIaRRazgyhkFH/w5nvtf0o=;
 b=LJpfysanpdxPHV1EH7qmoyAnxs5cFeiFGcvNGLz36W67ugqWl9qxaD0LBCrVgVJJzmu5UrnK3bRwlJ55I++5pZbqshyRfbN7QIicdLhDqDk+Otv+vxo8YSMXZ62DrNsKZezUzOf2BoC56gZ9ZmYZ2N4Rryjgf5y1iYEC9eYCKgwp4DReHoY8zrvpfYZM5z+/ccO8UQR1LvXzIQUrSxhSlxm6gDarFtmOufG4AyYyf9newQYU18sKj51xCHQaZbIRa8ZgmJiTmktqhfmUKhdKtIJx1Hy3zfdJGS/FtoIFRCrAaALjsn0Ovo3LJp7c58NGtQx7bv0xgmTHKQIpU8Njsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpClge/nUjUj2xL6hT2fzjIaRRazgyhkFH/w5nvtf0o=;
 b=Sf8k///O2kKfegbqJ9FCiUPqH+qGa+EyRccqixMoVKVXcMk6KWkYXJt1J9MAA7bWJMS4ZKazQejPeoMkGt1sTeUAYIytxkN44V/mtvCbY0is9M3AabEv4Lk+vZEoAA5S27RlZkNX2DIPIHkdXXNylA/GTlHGKt44Cnh5rdpCHRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 10:28:20 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 10:28:20 +0000
Message-ID: <08816382-f02c-4f98-a355-a4aa5af16d86@amd.com>
Date: Thu, 13 Mar 2025 15:58:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO
 registers
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
 <20250206060003.685-3-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250206060003.685-3-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::23) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f044fb5-0301-4a1a-b034-08dd6219c638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STdVQlJpL21mVFdYWktkd2Iza0FCZ2tRZE44U0E3NnJNNmMvY0l1YlVDaW1P?=
 =?utf-8?B?aGJEWVUvaThQbUdmcVdmVHh2ZmN6STdCanRmc0RjK0dobS9YUmREWnBXaWJa?=
 =?utf-8?B?MVZMMzFBRlkxUElNcWgwdGRoSGwzUjVBam5pOE9qV21LLy9qWVc5WHRSOE42?=
 =?utf-8?B?cnJ5NVVMbW9YNXA1cE13Z0dYY2xBT210ckpRUzh6blBPdVhkVXpwb0lqYkls?=
 =?utf-8?B?ZHdYdUk4cThkZEZQMXNMU1RQWmhUSUlRWTh4TGVGN3RMMW9WbURJRUowNFZk?=
 =?utf-8?B?OVlwZTYzZ0Y1RVFMOG1IZGZuSnJyU0xNMVg4S0R4aUs4UFV1cG5rQXpldGZI?=
 =?utf-8?B?OEw0WCtXd0szTnNXYkpCZWNLd2hMaDBTeGF5Q21kdjdjQVJPQlp0d0lSeHdk?=
 =?utf-8?B?Ti9FQml2eGY0TjlvUCtYRTVUZVRKdmVXVm1yaVVFenVzL1VPTGMraWJodHJ2?=
 =?utf-8?B?U3B0eU5CNjVXREtsejM2TllVZ0N6c2o1TU9tQmFwYUhHSkhySVNMZk0zcGF1?=
 =?utf-8?B?ZTQrSTQyQSs1Y2RVM21JVC9nVnhNZC96ZnVzS0JGUmx2N1JRNmtGUTIyUGxq?=
 =?utf-8?B?MlBCNzNBSGFWYnBEVkdnVTZGOCttOUhaQmFwU2N4RGl0cEJlNkRLa1pkVlF6?=
 =?utf-8?B?YjdvRUlveFBWSTBPajUwbGorTXp3Rjg0ZlJXaDkrMTkvTCsrMnAvc2c2ejZ6?=
 =?utf-8?B?ZWo1SDhUdG83UGNkYWMxWkJ4ZEc3TGJwY2RIbnh1ZGJQckFqT21vRmhMOGJK?=
 =?utf-8?B?U0JXS3JoeG5pWDJ0OURVN2FkcmtodWZlV2hKUW1QSFIrTnVyd01NOGZtT1Az?=
 =?utf-8?B?MC9UeXh4dlJWVm5URUxQaExMa0s0aFZHQnlwb1JiS3JOV0VQd0VjYVlCMExB?=
 =?utf-8?B?YVMvL09RSXp2ZUsxU1hEajhkTUh0LzFYdjkxUTUrVlJMLy90MVc4UDRwa3c3?=
 =?utf-8?B?WHN3aUVkSWZNQloyb2cwQUpYdWg3Z3lvU1h0V1NWV003ZFBleVRYeTliODds?=
 =?utf-8?B?L20rMkFlSkJiaFpwSVh6ZGYyMmlzSDRDcnc1WUNzUUI3SkFlTm4zV3V3ckI0?=
 =?utf-8?B?T1B5YldhT2Q3OW9uZURXK3JNNTlmcm02bmo5YWdxc3pPRnpxVlZ4VzBXWjFC?=
 =?utf-8?B?NURGYzRiSXAwcDBRSVZUa1dlcm9MQ3gyU2FjSktEL0VnYzcxcnZ3MTFMbVEx?=
 =?utf-8?B?a0VqZTM4cmVoMDNwQVFJZEh0SGR6V0d0ckI0bmd6TW4vUHRrMnlnRVlIUlBn?=
 =?utf-8?B?ZlJHYVNPN1o4eERwU3N1Sm5aVUgzS1lZelc1QWN2SUhhNm5wdGhhMnhzZzY4?=
 =?utf-8?B?YTU3N1d3WXRMNm14anJEcGhYNUROeEswdksyaUZjdmxEZjUzcnJpTWhWb2hU?=
 =?utf-8?B?bmZBUnl5NmxadklZSTZjYktUVkJjVVFwWUlRV2lKRFRSMzRDd2ZNcWp4YTkz?=
 =?utf-8?B?dkhuV0Q3cnFaOVhJSU1vZmVOeW1ub1NuMEFRaVdIK3FxbGtJV09ydVVuaFR4?=
 =?utf-8?B?aXZZekFRbi9qNEdLWjlmQlN5SDg2K0pSZElHSDRCRUh2ZDhxUVowNmo0TEtC?=
 =?utf-8?B?SWZXN0tYdnNOckdzSC8vKzdlbWFSQlFEdkJCYndNYk5YbG5PV0wyVWtEVTN0?=
 =?utf-8?B?ZDQ2MHNPMVFvWDhEUnd4ODJVb0hSYmVnR0lFNWY5WFFSOU9iTlFxQk1jZXZq?=
 =?utf-8?B?ZmVhcFJsZUllSDQ3QkllM01ZcHFlVG8wb2paNjA4TEJqTURneFZsN0JBcnZB?=
 =?utf-8?B?T09mK242WFhXRE5ZL2JkMisrTGJlS0N5d1ZQNVlCV2xzSHp2WkdTT0lEaWdj?=
 =?utf-8?B?dUVNTVhmUm40Y0UzV2tXU3RsNjRuUlNLQk5HK3pRdmFoVTRUSGloM0pPaDZx?=
 =?utf-8?Q?kEK1K38AIm+Fa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXQyc1Nid2FOazRTS2RDK0dsL3d2N0dzTjZ5dzdpQXB2T1NWaEwrc0xmUmZD?=
 =?utf-8?B?bXdLMVZobDZ3WHZNaFQzNVZ4SUFzY093c083ZG1oaHdqaUxaeGJGTUZqWkxJ?=
 =?utf-8?B?Y3ppb3ZaREF0ZGdDam9TcGhqSW1uVTVTMUtjd0Q1cmRBQWN6aFhJNTA1T2pv?=
 =?utf-8?B?MThIQkpKaUpHV0hxK084L2lWODVmajFjMW1PWmw4ai85VnV1L0ZJVnhtaGI3?=
 =?utf-8?B?TEhESSs2L2tHWXkyRUpIZkhYcjB1a0pvK3JWM3pHMnQ0U0lFKzE4UFZCb2FD?=
 =?utf-8?B?RjJkei9zV2JZMzNLcUtPTmFoN2htd0NqWU15dFdCUTNSMTN6NXJ5VXpRYS9z?=
 =?utf-8?B?dkxoV3NPdEJGSkR1Nlh1bllXRFZmcGRPZENUUlpjbXZ4M3pvdWtzN2FqUDBR?=
 =?utf-8?B?YXF2QW52WVVWVUFSdWJxNm13ZGJyNkVCeFhTUVZTQ1dmQmdTQ1ljUUNCb0xS?=
 =?utf-8?B?alo5aGRwa3A0aEdFSXpFbXNHUnFQcGxIdFVkL1ZEY3JmWlRla1Y5SHBQenNK?=
 =?utf-8?B?WFNkT3FTREdmUHhXRzIranVONTk0ZjRtbVhwMlZwOHJMakd4RUtPenBLVXI2?=
 =?utf-8?B?U2x2NmQ1MEU0aHFEQmNEVEJEQ2xSSDJ5VHZYQkRXZmJLYXBMUWtIZCszWU9u?=
 =?utf-8?B?RFR1Z3FSL3dRY3ByRjdJVnFOeWR6cVQwNEl0WUNoQVNUSW1KWnYzbTFzcG51?=
 =?utf-8?B?NUtEOFRDTjVvMm1aVGMvanV1OGJDL1JRZ3o0WTF3NmsvNWl5bmFUR1RCdE1x?=
 =?utf-8?B?QlE4RVRVTHFmenRTemRGckhNSTZiNGJ6TmVhR05JYVVmdlE3TDN5Q01JdnZK?=
 =?utf-8?B?UTdjNzh0MzJJMGd5YVVMSjZhN2YxU0owTHRWZFU5Umo1Ri9wK0xSOVd1aHgv?=
 =?utf-8?B?c2dvY2E2YUdVelZsYlBEYUhKb1lrRmVWd1U4Sk1tbWVvOWErdTZYb1FEcDA5?=
 =?utf-8?B?WlIyeStFL1pRMytvTDNPcEdDWi8wKzRmVG9NRzM1L21WaVNuekJSR1J6dnlo?=
 =?utf-8?B?aTFFZ2EyYXJReWRzeVhsQUNaODFxYmYwUStXM3BmS1hCb2gveEJBTjFpWWFy?=
 =?utf-8?B?RTBEZTNJTStjb1ZnOTRlN21RRmdkUFBGTnUwd2tSaWZIZWVSREtaTEhTa1Ny?=
 =?utf-8?B?cTFCVGV6aGs1K3FiU3J5NTEyQU9vNmR2Q1JJQk9NNHlNQ2lQYk5GM2VhMm15?=
 =?utf-8?B?emNQc3ZyQVZkdDNQcS9ZNm9rSnRZVVBENXRtbEJ4bGJNV05rYmY4Nmlkd05L?=
 =?utf-8?B?VUs0eEU5TUczNWI2MEk1cjhieGgyUVNyWTFCV2ovajRQeVpleXlQOGRPU2NN?=
 =?utf-8?B?azhxTmF6V0QrbUpVdlYwM2Vmc2NoU2xHN1FydFZyaFNWajRYK2ZoU0dDVU9n?=
 =?utf-8?B?OXVaT051MnBhZ0tEbUZ4OXJ0TDdvRGczd0N1SkZFdTN2N1ZRcHlSUHBnMjRF?=
 =?utf-8?B?a21WWmFhWTRFRmpIdC93MVF5N0ViczhTTkdoU2lPd1gydVJYczZndzhiQ2pZ?=
 =?utf-8?B?bUFvN0Q1VFdMaER2dk5GNTJTZXhjRWgvZEc3WHpzQ1MxcVlUbTJYVHl2TFlB?=
 =?utf-8?B?aWx3N2JKdUd0YXRuZG8reHllRHBEakdjTktpTlEzR1VNQTdORDRVSE9nUzVF?=
 =?utf-8?B?K3lvbXZyMTA5dGpCZm9DdlozNTF6YWpKeGhRUUNUdUR3emNPUEc3dWUxaGdm?=
 =?utf-8?B?UTQrS2MyeStpWExEaXhIcUFFTFpackJ2blQwMkhJQVVJUDhBVERnelg3MEF2?=
 =?utf-8?B?QlVrVmpSWnk2dm8raGM3R1Bka3BENlJKWFFDNnhEQmF0azluUXhuTHF0cHBT?=
 =?utf-8?B?WmdwQjhveXZGVk9HWVYwNGo3bklWZzBTZFBVQnN4MDllVVBuRkdHU2UybVpJ?=
 =?utf-8?B?Yndvcm5FVkpjS0ZSb3BuOGZmTVA2RnZLQkFMOEJQZExCeDlyY2paR1Nrc1VC?=
 =?utf-8?B?MUg4SGgvcHFuQWloMjhyUkdNR1ZZaHFDSnhhRGhEeENxcFNsc1JEenlnV3Ns?=
 =?utf-8?B?U0NybWd2TVFJZjV1YjdJMUJKNSs0SFZvM0lUVjFTczc2T0EzbU1JcU1GQTlU?=
 =?utf-8?B?bUJmTXkrN3RvTzJibUNqRDhwMGZmWnk0dm5oRWV5T3ZRdEhhbEIzZ3ZlMFh6?=
 =?utf-8?Q?9wDfQZs3WqCP957gRMjub2mi6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f044fb5-0301-4a1a-b034-08dd6219c638
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:28:19.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lw4zdknVQp3hNgY6aKUv3UUccWcI8AxrCIuyrjMyaFxhFCmxt8XG7Y+E0+YSXxNXL0SKAUhsMSyMRJ+S2VvAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483



On 2/6/2025 11:29 AM, Dheeraj Kumar Srivastava wrote:
> Analyzing IOMMU MMIO registers gives a view of what IOMMU is
> configured with on the system and is helpful to debug issues
> with IOMMU.
> 
> eg.
> 1. To get mmio registers value for iommu<x>
>    # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
>    # cat /sys/kernel/debug/iommu/amd/iommu00/mmio

Many of MMIO registers are 8 bytes. By default can we print 8 bytes instead of 4
bytes?

-Vasant

