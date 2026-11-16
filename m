Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794840548;
	b=Xk7BAnUlqHfB4rx8478xpNIMwJH6fitYXT3cjcPZX5Eg3NJYJYQGfjPwFDXm+fPtAmrW
	 OA4luCUz3qzlxLIAbod77yZ6xVedXW5xpkt3mObLTmPGy7HSpvGMuQiGxYjxs2F/oVI77
	 CD1A1YO/bN+AFUabkcpVqHc7I+Ke1f+iXZtacuc9Lp5OOmJ9QnAwEpcRVO1JV71XL2SkY
	 pD5vYl5+kiWskokFv3pZMmFbV7F4i/vYFeaSRWT3OcK4VyElUAhO3gv6yafwB1ak2y9ks
	 SCJob18AU3IGy0uoUvJhksaG0Pw49kKg9r9Oz5n1CboLi3reYhV1FQ2z9k3VQCfQ78A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840548;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jlVVpzOaQflpupPVn6+ftI7BZIQwkGgsyJYd7JWj6Mw=;
	b=V2R4JNaAoYXCl5vVmyuAdAbfePVpR3Wwyp7qoy9MzLMTBU3V+I4+7fshAxSTADowmN2f
	 LowQBggaplGGqrEzoicklD3DNLjQXDBvpq6wbbzCatVvkY0UPZoYHgXaUAqVZE/q/uB7g
	 LL8QIV9aXzRyDT9+qc36q9P2B6tX0bfsNAKktdUCr1yran2+B3Tt6umWwcaU3+XZNo52v
	 Q35G+UourTeB2WTpPloQrUK6wHU43v1HbkRyaLqfciVIZlGljNd2a5fVsGk8QwiQR+zEk
	 QfvDaO/g1zLnIe5h+8xvhAHNmGC57TVItGWNwUd8SZPXFAwe9vla2+gQHGUyWkiysPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="2/F2A6Yc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.12
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E70606A32A
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 14:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E70606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2/F2A6Yc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDJ0zOHXx+xdtvwgS9K0EGL1t9phH4grVQ1UVJ/FC4kiWEEDxt8VEnksgUh9SmMEjzmgYVa+oNv5o1pKvQTS4ZnJYrKcyFqE8DM/oFXsvzxgVNEkCypR4KIzQ6n7AWjDuEh9JrNXMc0MRLb2Sz69tjkfczdUWgCv/6iApr1CpBy5TDEszYqc9QqTD1/x76jfW9SB4kbHIs5jiCJ09hrhIpHGQjeCiBHSZ6z+hOID7OxB+QfnrcN6KZgWJJCtmU5jm/TolPMeZfn74tk7SycvbBur5Q1UsbtuSsdrLYXQeodk6saKASa4VHAmg93dYzqaQt5cIQRcmicMJHDqqtoINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlVVpzOaQflpupPVn6+ftI7BZIQwkGgsyJYd7JWj6Mw=;
 b=YTniczJhPXOZC0tz+SFWn1BOWUjEgYXukAj2ZyM+F85Rt1Ol+97ATt8O0e0KBl/0bJOzhwpSWQSX9PS0xJX7gZZUO2UVluXMoG0c/mP5tGEKhbiRuThTVtfyoE83SGP53WC6W8erZzW6t99fhqJVoCsh0nH+MnMt3ALP43MELLYjGbpe7n0ij2YlYGn1JYwvWH6ewcT2OZEUYjjLAWTVE5WfGALIgSV2UBdLS7tRfEh/LqZJcVARFrA7HQn+wLR1VU2FlXGul8Q9fh90Bo/kPO1Gzzs7JzW8hOEd4aXCAr0rH1HHb+rpzWet1yPCZgBmYlAqhvMjoXrHXsdpfgiOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlVVpzOaQflpupPVn6+ftI7BZIQwkGgsyJYd7JWj6Mw=;
 b=2/F2A6YcxP8+mOtNpHxvy9Qfn8wZPXF8pKkW1lQZtgMaiwCx51W+iHW+ApQjVlJqJnt5okxWW2lYhHK9RG+z50H74xuUxQyCmWV0kemNZWZJu9DE8jDZB1HAj+rDCRpfO4hH2HulhKv+Vi3nZvMkAXm1qGNBXNhSGtvn/K6VzX0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 14:49:02 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 14:49:02 +0000
Message-ID: <301430f5-c96a-42e2-bd81-de564650f9a9@amd.com>
Date: Mon, 16 Nov 2026 20:18:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: RCU-protect iommu_ga_log_notifier
To: lirongqing <lirongqing@baidu.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260924064709.2194-1-lirongqing@baidu.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260924064709.2194-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0288.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::6) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1680de-3e2b-4d74-0d6a-08df43f0c117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|261102123227099003|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261009221227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WbuVODf4cJPnkqnOKxVb/pi8OzqfVDPfEjdOn9RA8psC8PcIJj20pscvn5L3Fd/67mGouejWWWv39dxtw5qylbJ7nG8dzW+mSCKn7y8+QeeI1YYxoQ5lgkxv1940YnbIRmPHR3H64/CEIph6qIel8nSmi5ZdATqf7DxcpAkA0cKyql7Cjx0RlQg13XeP/ts2/nJ/GM2/8nuCZnK0KGr0szNhDUkIiWoYoJhyWS0YC4LHfgudScgxv/4NTMTwVleqI89f/QjfUZ/koylc3puVdxMl/LLAMYs6UCzc5ebcUXIUwxo4z9fEBIHBJyRr8gka+7PwU776VZzSoxUCk0mxeziImM17GZylLXoTDDnibTxKbonYAk/jLgt5ETgzLPD7PBsnBblI6rLpfxkSwoFceSPW/dF0vqQBC93FNReX3IDuXR2GlU/ZqvPXE8bYT/cQs0r7iCNWozXiP5hLvs4pJYOnm6+w3CIrRrK15LEVzmRfZL9vqLYmp82vxaFVbBcXODLfeOObi/zC3muFbUUeCKLaqOxOJ4WZHwpif5Zf2BCQtuh0+9giadadwRsJf31petFFlHkxfng+anbJS58cDbCfqlHH2HYlzdUOM6+UUcrfUJ7BRRL97nR6fQhWAfF7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWZBTUFzRzhuQVBiYTlrUUU5RGtEWGt3TlJwUG5sV0ZkQVc2M3BVNWtHQ1Fs?=
 =?utf-8?B?M2EvbUlqYVc2MkpjRmN1Zm5WcUZVcnBXT0FWUEdsb2hvbjZ3MXQ1REZPQ2Mz?=
 =?utf-8?B?NEZocWdabGdja1RGUGsyb2svcXdBNGlWbGpaRHFIclNqSmtWSUNFaVZyaGdW?=
 =?utf-8?B?M0dlU245VEM5bVJUbkJ1TDFuemlFekNobUtlaWJqTUdMRVVsZ21XaG1GdVJB?=
 =?utf-8?B?dk4waEZTTXZyWmszd0M1N3NWYWVqd29ETVUyNWRZV25XUW1hLzVIQUMvM0wr?=
 =?utf-8?B?bjREQ2J0RWZmMVVyN2NQUVNvc2dTdEl6Q21sZTdqVmxJMVNlME5RMFBNbHE5?=
 =?utf-8?B?dmVqc1IzQ3FMOVZUMWhmMkNRUEc5SmNmbi85K1pvTjMzZUk0cStXdFVHZHl6?=
 =?utf-8?B?NlhUeEJWRWhBWEpEWFZKUVFIKzFYVEYyYnpkSHRNMWtBYW9uU1IvRTIvTGlt?=
 =?utf-8?B?d2pzbzJlUWNudWQ4anJxRHk5TlpmU00xUFo4MlN2dXVROHljcmozOEYyY3V5?=
 =?utf-8?B?SUc3TURseVluS1kxZUZuTVkrblBDNmhxZVhEd2JKOUtGc0UxMnJDczNBcmV5?=
 =?utf-8?B?Q3dHRlJaVXFDL1VtNWhUL3REYTZTSlBvUlMwcURFd251Z2xlR002NEg4Q1FW?=
 =?utf-8?B?NTE4SEVPdnZnME01aHdaTmtsUEdYcDNPRTB0NitqcUhCZUJGT0RFa2x1UVFa?=
 =?utf-8?B?eFhpQzNxM1QxRTNaVGxMZmFHN0JwR0RQUnl4cHdvRjJDWHdhT2p6TDhzTC9j?=
 =?utf-8?B?RURHNDNQYytCZXQ2SVh1a1Z2ZWQvSjYwRVg3MFhqaUorTDNkcEZWUXpUTTY2?=
 =?utf-8?B?cENSUWI3UUJUZFI5c3Fqc0V3d1ZuVHZpK3krQ2xLQldIK1Q1L2ZlV2VCOXZ1?=
 =?utf-8?B?aFFXSkQxdzc0WTAzd1dnbUZxdGNCL0V4OHphT0ZOczJ4emtPZFZVR1lEQ0tQ?=
 =?utf-8?B?MjdMaFZFMjhhcEI4eVdMNktoK1lPMVZQUm1yOHhha1hCSTY0SGtxODhxbnF3?=
 =?utf-8?B?Z3JJYmlTQmNyOFQ5TFl3MXpGZ1RHUHY5dDFrZGQ0bGxERTFXNlZGNmxpNm1Y?=
 =?utf-8?B?UThVbUNWQkRvc1JYRy9EcEw4ZjhxQ0tEZTl0MFdibTNqdEZoRkx1VE9YR1BP?=
 =?utf-8?B?dFZIR3BqN2tGY2N0eWt2SUszN2FkbGZoaFF6QXB5NGhvcnlNbWVkb0YvZTdP?=
 =?utf-8?B?QVNJeGwrK3VaZ0NxNUp0elZCMGtkakt3UEpyWkNJSGpRR24vWi8wM0dzSmF4?=
 =?utf-8?B?UlM2S2xaNmpvRUE1NlpPbnpmVUlPUDB4aXlOU29kRnNVdmhSSktBSnF6Vklm?=
 =?utf-8?B?cmZhazd0WHFBaFNUVzVRWDhQZ0ZQTnhuN2hXRUNqc29lVU93VitWVktzZ0dJ?=
 =?utf-8?B?M1k4NURRa0hkK0NxSGg0ZCt5aGFzNmVyQXloTnZ3UlFoSlJUSWd4TWVNcDdu?=
 =?utf-8?B?NG9sSEg4RWtOendjRkluRVhCdFFEdnNGQUYyTjdvRnF1blR2WmhLSWlaT2Nx?=
 =?utf-8?B?UmpDR3FCSUFWOUdSc2hBYTFiYTBKZW1LOTFZU1dOQnVzTlpuU2tad2F5V0I4?=
 =?utf-8?B?TDVSVFRWMGtXTlFhVStNTWlqREQyQzBEZ1V6UnZCaThGWVFoQWZRSkUwa3Fj?=
 =?utf-8?B?QWY5YTlCRXBxY0tkNzdLK2dGbStxeUd3YUdBbjRNMHRuRHdsdks3S1FiUitk?=
 =?utf-8?B?YXl2eXBUN3RuNkFjMDZ0aENFZHRzQThmb2hqSFV6OWVoUm1PU1pJd0lpNlQz?=
 =?utf-8?B?bFBDNVlmUDBQcUhPYkJwTS9KVUUvb2o1em1FOGU5MkExRXEwZGJGTU1tSktt?=
 =?utf-8?B?dWU2RE5sNDZQQzBsWnNBVHB1Y0lzZHp0QUNjcFRQaHA4U3FVZ0RwcUdTeFhE?=
 =?utf-8?B?eWN0b2dtUVd3bDl1THV6Z2d2SCtuSS85ZXF5QVdRSHZQU2RuL2xSeklSSEts?=
 =?utf-8?B?eXVoYUtUUVFiVTJuSXROemxWc1hhS3RJUktyQzZFMjFNZFhsZ093Nmd6SzhJ?=
 =?utf-8?B?c1NvaHRnTHNpMDA5OGt0RHgwV3AyNlJKdXloS1dxdnVFckg2cmdGcEVUNWc0?=
 =?utf-8?B?bk5PcjV4TUZLZzdVRHZzK1d1NjQ5cWQxN2R1VUlObTdFdUZSOHR1bFl1R3F6?=
 =?utf-8?B?Rk9ENWttd01hbjh2eFh3b29ZREhXQnZPSmhOK2l6RFk0Z0ZtUlNLeTk4TTJT?=
 =?utf-8?B?Z0dBc0hqRXBMYmFzbFVNdkxSTkFRRFJ1VThEZ1pnSHNOT2JzNy9aOEVsRG5U?=
 =?utf-8?B?ZENXanVMcTdtNkRLSHRvblAzcGtmczUyeFVxU1gwVllUMHFxWngra0JaZ2dY?=
 =?utf-8?B?SlBiZGJwcG9ubDlab0ovZ3FvNTdTK0k5STMxdm9XMitBTnJnTkdEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1680de-3e2b-4d74-0d6a-08df43f0c117
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:49:02.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyPkH2Ick5GssiP2lNwl1X9t4L/upAKGBTAl6dOhi0xA56y3eY/YCgx8XF/0pMJ3Rv5JgwnsBuCOhcROMkRqbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276

Hi Li,


On 9/24/2026 12:17 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> iommu_poll_ga_log() accesses iommu_ga_log_notifier without an RCU
> read-side critical section, so synchronize_rcu() in the unregister
> path does not wait for an in-flight notifier callback.
> 
> Use rcu_assign_pointer() when updating the notifier and
> rcu_dereference() under scoped_guard(rcu) when invoking it. Load the
> pointer once to close the race with unregister.
> 
> Keep the RCU read-side critical section minimal: only the pointer load
> and the indirect notifier call stay inside scoped_guard(rcu). Move
> pr_debug and pr_err outside the section so that logging does not extend
> the window that synchronize_rcu() must wait for.

I didn't see your patch earlier and posted somewhat similar fix. But since you
posted earlier I will pick this. Can you please address below comments.



[1]
https://lore.kernel.org/linux-iommu/20261105041603.399016-4-vasant.hegde@amd.com/


> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a06cd61..a31464a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1054,11 +1054,11 @@ static void iommu_poll_events(struct amd_iommu *iommu)
>  }
>  
>  #ifdef CONFIG_IRQ_REMAP
> -static int (*iommu_ga_log_notifier)(u32);
> +static int (__rcu *iommu_ga_log_notifier)(u32 ga_tag);
>  
>  int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
>  {
> -	iommu_ga_log_notifier = notifier;
> +	rcu_assign_pointer(iommu_ga_log_notifier, notifier);
>  
>  	/*
>  	 * Ensure all in-flight IRQ handlers run to completion before returning
> @@ -1094,17 +1094,25 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
>  
>  		/* Handle GA entry */
>  		switch (GA_REQ_TYPE(log_entry)) {
> -		case GA_GUEST_NR:
> -			if (!iommu_ga_log_notifier)
> -				break;
> -
> -			pr_debug("%s: devid=%#x, ga_tag=%#x\n",
> -				 __func__, GA_DEVID(log_entry),
> -				 GA_TAG(log_entry));
> +		case GA_GUEST_NR: {
> +			int (*notifier)(u32 ga_tag);
> +			int ret = 0;
> +
> +			scoped_guard(rcu) {

Why we need scoped_guard()? we don't have multiple error condition to handle. I
think  simple rcu_read_lock() -> call notifier stuff -> rcu_read_unlock() is
good enough. That way we can avoid multiple if(notifier) check as well.

-Vasant


> +				notifier = rcu_dereference(iommu_ga_log_notifier);
> +				if (notifier)
> +					ret = notifier(GA_TAG(log_entry));
> +			}
>  
> -			if (iommu_ga_log_notifier(GA_TAG(log_entry)) != 0)
> -				pr_err("GA log notifier failed.\n");
> +			if (notifier) {
> +				pr_debug("%s: devid=%#x, ga_tag=%#x\n",
> +					 __func__, GA_DEVID(log_entry),
> +					 GA_TAG(log_entry));
> +				if (ret)
> +					pr_err("GA log notifier failed.\n");
> +			}
>  			break;
> +		}
>  		default:
>  			break;
>  		}

