Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC07262FC0
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771994991; cv=fail; b=npCr88v3H00PfhIhVEkbIx0sl5YbtBqt1PZB0tWugLZyzHZvnsOCqladZ7jK6axO+C6KvFzz+YE2u8sl+kefXfFqp/yNpu54hTAkemIyRiFjxLlaI4uq59cZMcg7gqWzO2yElMjIFaTaNUdBpKqSkuRFmyfpY6eWwifR46tXkEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771994991; c=relaxed/simple;
	bh=tDzTQxdgfRh110PzA3PO8yvY4RsAXGk7D2rbbz8Gwyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tArEt1mgJha3QMamQ19UXNMDITjHMyuWJuoCzncBZzZz9LQhP9/6VEqXGaOXaSaQ3cxo1UK6llQxcD/0g5CyMf6xn98duO9Fk/Mt8GM5hEQ2qcKqNYTsOeeannxfgWJ+829AIc4aweZ5PoO5fgXeNsH00vaFdI8XPm29Nv/SNqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vp6XeVUK; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vp6XeVUK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZhScMik9NsFC+dQgXeooz7zaImXpWYwwCKJGXXRHx4iNl+ce4e2UZxPXfI8ayFMQN3E8Wc9ipw2Tf5wuSQ5X/EJlARxE6l2aSU2begtozwRzONWfOo7r3Rb+27J0kFoET4juWBB3jXVSboWRsA7RYbYKlUnzwnPZz4mwA0jKdO9MvPnRwG+y6UiPe7gybTxjYd2Ghs7RF0c35U6gtDpH1fevElUlAHu/1/S5tveVGvaqw5XgJDLFC5PkpSW4D5b0NbGFEL0jLRPR9NWhglraLi+hSZboCrapfQeNHCc8wQwu2DyabXJEv7QN+19EOc1GFSMFybfJI0WsdFdS0tpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMpVwbiwscAH0tOoHEtItME/zuaBY+QqaZ+P+2l36eY=;
 b=bW4kUfbEg7cYqtVvkV8xfMe7lbspKiVSaWDzAX6rHS70WgMgFMpsKr2aD6yCcV2scqlNCI/1rRb9xSDj08OLYLKyNd71w92WhgZCZuN/EKKgvwcF/DYnya09kveqFm+xyEJREIv0FjR4IqJvkOk50xtc2VrZtsX5gbmwJhp2iQGAuvwlh9mFdlirFhF2nWh928y2I8+A/Ip5fWTs0CYXLiYx1AfsksLcYNe4uhm5g+UMCiVBn2m0D+GqZgxmwUz/oII8d1Q+KGdysiW+tAcYObWULf4TgyngMMfDfhBVqiiG7ClDvCCVb6P1SQvHevX/TYYUMTYMcyHWGhT4Bz+PvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMpVwbiwscAH0tOoHEtItME/zuaBY+QqaZ+P+2l36eY=;
 b=Vp6XeVUKqCsGG3B0ycbJloOxM0qmhMY5AL+/sb9BAV5wzL5mlFU6TQHUYnfu3BlE5HhF98976EWdsm8lkSnuwLf1Qkh+aFJheWy6pzEVVyvdmovFG1O1tlvF+OgMjZfUOpxHayJdZmek9BtFX21pecHGi5zCGM5nAr5tXA/RWOlpj9R6qeflv9CnC8K2HbPk4xwE4Dc0TBfzQ+XU2A3WryR6gIC7/Zcc9LB1VKK/htZE6HqqqdXzJelO4tL7XzXcTsaf5WoH7/n0H0BoppHrge0+b+G+dvxKXUchuYcUvb3603HPcgWelTUcUqELlz2bDaUR5Qke24xLbyruLmIXRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by DS2PR12MB9614.namprd12.prod.outlook.com (2603:10b6:8:276::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 04:49:45 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 04:49:45 +0000
Message-ID: <9d01b4e3-be5b-4c9c-8088-1d10f67f1fd8@nvidia.com>
Date: Wed, 25 Feb 2026 10:19:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu/dma: Validate page before accessing P2PDMA
 state
To: Pranjal Shrivastava <praan@google.com>, Leon Romanovsky <leon@kernel.org>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-mm@kvack.org
References: <20260224104257.1641429-1-amhetre@nvidia.com>
 <20260224123221.GM10607@unreal> <aZ4Q1HA9q1ojsVYY@google.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <aZ4Q1HA9q1ojsVYY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0120.namprd07.prod.outlook.com
 (2603:10b6:5:330::10) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|DS2PR12MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 59efc398-e982-4a81-5c4a-08de74294c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlNHck45QnI2M2xFVmJQS0VSTUR4VHNTWGdBODZoMGlGYUZOL2RmZzQ0MkxL?=
 =?utf-8?B?WFAvUFM5b1JJS2J5dVpMK3p5eTZMTFFWZVhZWndqdlFCZDdocUNCN2tweU1y?=
 =?utf-8?B?WVhZRjlXdXF6MlZOcHQ0ZC9uOWp0R0xtUTJxSVJMeXlPWmpVeFVtdXBkQms4?=
 =?utf-8?B?OWp1Rk84NUdBVFZ1aUJYc2NJcWVGb0c5R3liem5zbVdGNS8rREtZb3JpUW1v?=
 =?utf-8?B?bDIwSGgwWGczWEJDem9vSHp2V1ZtRzhOdnhpK0Nhdmo0UXlWcmkwK3Z4Qnp1?=
 =?utf-8?B?dHpPbEYyYU9vL1dsL0hRUE9iMUdNajY1ZDFMUXdDRHMwZU5kRlByV1E1Nytx?=
 =?utf-8?B?dUVyVVgzVllqbGVZRFAwZmJHZS90dXNIK2M0QTNRbXhDMGxLeXpyMktmSmQw?=
 =?utf-8?B?N3JPTmtPRWRPWTVlQVlHQnpIUU5IaUROU0RKNWUyb2NkVzNSNlhMbXdJWHZI?=
 =?utf-8?B?czd0TC9KRzBBb2ljTE1LS2ZNNWh2RWlhUDBGeFpWaU1DUExXeHV1cWJUcWRH?=
 =?utf-8?B?LzRUZlRUdVpleE5hR2dGQ1FJTDd2S2wwYlZYK2N5L0huWExUTXFhWWRldXFm?=
 =?utf-8?B?Mkp6VkJ3UVFCNk5ROGlhUHZzbWsvLzEyQXhKQ2M5Z1hJY0xGaGRWMnRZYzJ2?=
 =?utf-8?B?TnB4bFRWUFpyT2dNV3BKZitkN0t6QTB3T0tXcGxVQW81NjVwZWVZRU5ZbnN2?=
 =?utf-8?B?M1haR0U2YmYrcVRvNjRWbTlCbTNUbmpDMWZHZXg5Q0ZSQ1Q0bkxrNy9oanpG?=
 =?utf-8?B?QWNQRTh2N21IYVVNNlZ2cktjSStST1FsYVIvRGtSUlE1ZWhKZWZNdW9zeTBX?=
 =?utf-8?B?S3hSTzNDcDlzRTZCUC9xOEZMU0pabmhiL3VhR3c3WjdEVnZPb0oxcy9RSFZl?=
 =?utf-8?B?Um9yK1dkZmdjbVN1aWpCckFTcWtiZjR1SlhjU1B5U1hhWDhoeGFGVGpjOVVn?=
 =?utf-8?B?c1dNNGJ1OGcvaFdnZW5pWVJpRklHTFRHWVM1cTdTYmUwbEVJcmR3ZGxKYnUx?=
 =?utf-8?B?TmJ4dGFrZU44MlhvR0VEV0xiVTJjN2J4WmY0WHltT0tPODJzR3RiQTYxRlkz?=
 =?utf-8?B?TlhTcENHYUdKUzI1cEJvMWw4dEgwVHlTWFV6NWJSSkdhVzBIU2xLVllNemti?=
 =?utf-8?B?ZnF3OHBLWG04NHNpZGI2QTV3K1pXY3JsNmV0TnJqb1dMeTNzaDFwUlFpOG9S?=
 =?utf-8?B?ODJIMjJ2WitISmRPWjlEQkQ1b2ppVDdHNlh4eTZ6NEpuWW1ZWUdKSktPc0Zi?=
 =?utf-8?B?MUE3dWJFc2hycFc5ZVVucjNieGhIcDE3Z3lUeHhmV2E3MG1sNUpPc3AzTlFy?=
 =?utf-8?B?WFJja3I5dHVPTGZ1a0paVS94MDVxbVZIRjVuSHBMcFpnTDVuZ1NxemhKOE91?=
 =?utf-8?B?VmdWa0pIeVZwYXQ2SFl2TG82REg3UlJuNWdiTW9INW5EMXQ5a0syQnp2VTh6?=
 =?utf-8?B?djNTSENvTGpqaU95YkFHWnhhZkFmc0JmYkljK2EyNTRlS3hTNXFQQkZhYTIx?=
 =?utf-8?B?ZnlucEYwdHNyYkVNcDhHa054UUxkd2EreHB6eE9sS0FIYUg5T0h0bHpUS3BS?=
 =?utf-8?B?RG02ak8wVnp6eGFxQWcwc1V1SGZJcmFiYjF5TnJJMlFFQWMvYU44cTBhb1JR?=
 =?utf-8?B?RXIxclZ4TEdTZlgxVXNJaGRoSVBGMENmc1YxRkV2OE9Td1k4OUdHejdkTGw5?=
 =?utf-8?B?OUkydG4yaDJnOHpwSzlZSHVBMzg2USs0b251Q3BzU3p0cnRhMHZ3T1AxWi9F?=
 =?utf-8?B?RE9YMkpCN0hma2p2cHRLVEE1ZENYNjViVmRNNzRxdzN6U2p4ejlLbDRadHl1?=
 =?utf-8?B?cnJ1NytvZGJxY0dOZ3FCVHBabG51cTNpdWhwWFVvTEl0bllDWTJGZXVyZk1N?=
 =?utf-8?B?NUd0OHJxSmgvcHFpeUZYcnF4RVhyaVNJOWNZM0lDMXM0RGNzOUV5dGF3SWd0?=
 =?utf-8?B?SnZEZFBCVmdWaHUxbWs5eTYvQXJ1TFhacVdjTGpoVndmR3Q5UXpqRSt3MkE0?=
 =?utf-8?B?ekNnd3hFSStKa1RXNHZkVFExV2N1V0pKR1ptT0dvWDVka3BxUHQrRVZvdm9y?=
 =?utf-8?B?ZVNpQ09jV3pMOEY0RG1xUHBFQWlPTGllNENOVEdLWXBkSlptZEFhSnUzRWZU?=
 =?utf-8?Q?olKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzBiL1k3Q3hjcTFObTRKMkgyS0JsUkE4MVdXOFVSaHZFUlBxUTJucmF0SCtC?=
 =?utf-8?B?SUV5cWtuZmlmR2tJWFhHK1JJdXMyd2VUaWgxZUJTck9mbmZ5aFg1cVJKYTZ3?=
 =?utf-8?B?QVIwOUNaYXo5TzEwOFdqM3RTZWEzcGhaajVPbXdPRFU3SUlTVG53bUt2TnFn?=
 =?utf-8?B?TEcwMlVMM3pLSXlib1JQZWwvMzZMWnBGUU9GNVFhRTIyVWdTbDhUZTJ6ZHVW?=
 =?utf-8?B?NFlsVDFPTlczMFRFWi9RQnJTZVRKc1JLalJaNnJvLzdwdk1GVnYxR3ZjaC9E?=
 =?utf-8?B?YXhYMm1kb1M1TkN4Z252ZDI3TUlIc1dFTkRLZzUzejBidHNJRG9SbzR5Q0Fk?=
 =?utf-8?B?UDY4bEdzdE4yZ3VwcnR6SldWMXFpa2VPRzhKWFIyRjVPa3JxWXRjanlOcXJG?=
 =?utf-8?B?bjZ4cEJyTk5xRkNZb0ZoMFJHYVkzRXJMVm5DKy9WbEtQdEI4MmEyQ2dlS3Bt?=
 =?utf-8?B?M1N6c2hhSnp5UkhnTmdDdWlqbFF2anQwRHlrNytaa0JibWh1UTdqSnJ1SGdL?=
 =?utf-8?B?bU9HcE1BQ0JyeFhjU3V1b0dBSysyVDQzSW5Ib3RCRzhONkQ1dEllcHJXM25N?=
 =?utf-8?B?cEc3bUVwb0NJRytmTkhzV2s3UWM5VWVCTUpmdk5ycmpIaGUvYUFEdWszUmNT?=
 =?utf-8?B?M3ptbnpSQ0F4ZkVFWW1UV3lYQ3orTStaSWlzcWlvM1hoTXdmYnZJNnFnNnhv?=
 =?utf-8?B?UTVkR2xHQmxGbTZmRFNkZm9KSFVzQmdQRWdSRkFCV2w1eHhTTndKdkdIeFB2?=
 =?utf-8?B?UFNiL2owZWYyL2UveGV5ekhYZHFOcnMxdnc1aC9LbHdyMXpEVXB1MTBuMFVP?=
 =?utf-8?B?V2w3YlprbjVMUE85NkFmYW9qZSs5a3NRVUlPeitSZEJuZWNDZlFRcTFRTFRh?=
 =?utf-8?B?eGVReDNsRnJiV3BiQmlSV1ZrOHFxUmcxL01HQ3g0M2N0L0NTL1NWblFaWHZX?=
 =?utf-8?B?MjRBRWVVNFpPQ0FPcFJqQjV1VXcrQ1JlUllzWG44Q201MFV6dDNPK2JjVW5L?=
 =?utf-8?B?L1BvUkZkNFZWWG5zNERYaFpZd2FkYnpOQjVydXBwMWJNS1MwazVZajRZaCs3?=
 =?utf-8?B?dU5RMEliTng4Nk90NncxYngrNnFIRE9SQ2N1aUtuVjFjdjJOZG9JcnRVVW56?=
 =?utf-8?B?RVlUYnp0UEpuZGh5bloxSE9aSDF3VytEc3N0NEp4Rm8wR0NLcWNuR2tORHpl?=
 =?utf-8?B?U3VoNFJ1WlhmN0IvU0JJZkNxS004emJFZk5LSlZyUUFIZFRqb1JsK25BVzRG?=
 =?utf-8?B?Ulh4MVQxaklYeGhjYW52ZGxxbU5JWDg5UTBvcnljNGFQQ0UrMGs5ZVFEeUZ4?=
 =?utf-8?B?UUFjYm0xM2dPQ0o3UE1iSGUrR0lxVEhsU0R1eEpSWlZTaGlWTmo4bGhPVlhC?=
 =?utf-8?B?TjZXaGdpNTJKSStjNjRxQk90QUx2U0F6MCtNVzFwU3U0ZWRZTVdkQ2xEcnZa?=
 =?utf-8?B?MWhCSkh0ZkRtZ1VMU2VUMnRZVG5XZkNnYyt3QmlXeU1IZEt0K1NlUWhzWFdx?=
 =?utf-8?B?bUNFa0RwamJGQm1nSUp4ME5BMmIxOEE4dmJDZk5pU3NRL2luWllneHhPNFI4?=
 =?utf-8?B?ZUJBZlVUZWVnUjhhdTg3cnUyeDJKa3ZGYzQwU3poSTFIb1R2VnFpdnFhOThM?=
 =?utf-8?B?N1NpOTVVOEh3TUFnRUJ3TTBSaTQwd2lEaXZiaE9iQjVueDZmL0MrNXRoN0NP?=
 =?utf-8?B?bk9kdHc5dFJpVU5yWmtPVVZFS2NReDBqMy9iR2pFRE42aWc2ZmZaSE5HSEtU?=
 =?utf-8?B?cXEybnhGd3dxY0dDVUc2NmxtanVHd1lYc1VINkxPb3laTGtYNFdCRHZmMVlX?=
 =?utf-8?B?S1pJM1VFaG5tNmVvSDdDeWhjd3JaREd3NS9HbU9SVkpSYUh5eThpdmk0SHFn?=
 =?utf-8?B?T2ZqMjhENFBMalFZOW1DZkI5ZzJqUXhwai85OVlIYXk3dWpsTVRKcVRkZ2M2?=
 =?utf-8?B?dzQ2ZjljeVF2b2E4S05ZciszWVlNbXdmdmJXUzZKQWNyMkxPcE9CS2VJb1pF?=
 =?utf-8?B?L0pxa1owcFNhckUyMk9yV0dkM2xhRE04Z2xqUVdwaTBQZkdsT0o5ODV2NDNs?=
 =?utf-8?B?cDg5c3lINTc3YkxnSUdGZytLcU9EY0s1N3JTVENiSzJ6cUxkdDVzcC9OdWFI?=
 =?utf-8?B?dUtUbkUrWjdGMERKNW5La2lqRTRrUU1wZ0ZuL1lNelVsREFpa2FHSHVCSU5l?=
 =?utf-8?B?M0R4aUwxc2JYZHhDazUvMU1pQ2p5dk5lZkdQL1RpYUpVZVEyb2hwZElYYmR1?=
 =?utf-8?B?L3RDTnpkUHFsZ1p0UG9NN00wOEszVDJOTVo3eG1SczdLL2daYlQ0dTcxcnZF?=
 =?utf-8?B?aVJvV0FEUDh5YWd2NkRuUU5LdlNuNitBak1tbDFvcTYwRkZpajB3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59efc398-e982-4a81-5c4a-08de74294c18
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 04:49:45.3241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zI31RM8SpIfV/o4z8AvqfXycTgvSxKpMfsE9pQOn3rDr2n+PiD1LvPO0wVR45m+SSxaHGIdn5HprwPa8KVgVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9614



On 2/25/2026 2:27 AM, Pranjal Shrivastava wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Feb 24, 2026 at 02:32:21PM +0200, Leon Romanovsky wrote:
>> On Tue, Feb 24, 2026 at 10:42:57AM +0000, Ashish Mhetre wrote:
>>> When mapping scatter-gather entries that reference reserved
>>> memory regions without struct page backing (e.g., bootloader created
>>> carveouts), is_pci_p2pdma_page() dereferences the page pointer
>>> returned by sg_page() without first verifying its validity.
>> I believe this behavior started after commit 88df6ab2f34b
>> ("mm: add folio_is_pci_p2pdma()"). Prior to that change, the
>> is_zone_device_page(page) check would return false when given a
>> non‑existent page pointer.
>>

Thanks Leon for the review. This crash started after commit 30280eee2db1
("iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg").

> Doesn't folio_is_pci_p2pdma() also check for zone device?
> I see[1] that it does:
>
> static inline bool folio_is_pci_p2pdma(const struct folio *folio)
> {
>          return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
>                  folio_is_zone_device(folio) &&
>                  folio->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
> }
>
> I believe the problem arises due to the page_folio() call in
> folio_is_pci_p2pdma(page_folio(page)); within is_pci_p2pdma_page().
> page_folio() assumes it has a valid struct page to work with. For these
> carveouts, that isn't true.
>
> Potentially something like the following would stop the crash:
>
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index e3c2ccf872a8..e47876021afa 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -197,7 +197,8 @@ static inline void folio_set_zone_device_data(struct folio *folio, void *data)
>
>   static inline bool is_pci_p2pdma_page(const struct page *page)
>   {
> -       return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
> +       return IS_ENABLED(CONFIG_PCI_P2PDMA) && page &&
> +               pfn_valid(page_to_pfn(page)) &&
>                  folio_is_pci_p2pdma(page_folio(page));
>   }
>

Yes, this will also fix the crash.

> But my broader question is: why are we calling a page-based API like
> is_pci_p2pdma_page() on non-struct-page memory in the first place?
> Could we instead add a helper to verify if the sg_page() return value
> is actually backed by a struct page? If it isn't, we should arguably
> skip the P2PDMA logic entirely and fall back to a dma_map_phys style
> path. Isn't handling these "pageless" physical ranges the primary reason
> dma_map_phys exists?

Thanks for the feedback, Pranjal.

To clarify: are you suggesting we handle non-page-backed mappings inside
iommu_dma_map_sg (within dma-iommu), or that callers should detect
non-page-backed memory and use dma_map_phys instead of dma_map_sg?
Former approach sounds better so that existing iommu_dma_map_sg callers
don't need changes, but I'd like to confirm your preference.

> +mm list
>
> Thanks,
> Praan
>
> [1] https://elixir.bootlin.com/linux/v6.19.3/source/include/linux/memremap.h#L179
>
>
>> If any fix is needed, the is_pci_p2pdma_page() must be changed and not iommu.
>>
>> Thanks
>>
>>> This causes a kernel paging fault when CONFIG_PCI_P2PDMA is enabled
>>> and dma_map_sg_attrs() is called for memory regions that have no
>>> associated struct page:
>>>
>>> Unable to handle kernel paging request at virtual address fffffc007d100000
>>>    ...
>>>    Call trace:
>>>     iommu_dma_map_sg+0x118/0x414
>>>     dma_map_sg_attrs+0x38/0x44
>>>
>>> Fix this by adding a pfn_valid() check before calling
>>> is_pci_p2pdma_page(). If the page frame number is invalid, skip the
>>> P2PDMA check entirely as such memory cannot be P2PDMA memory anyway.
>>>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   drivers/iommu/dma-iommu.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 5dac64be61bb..5f45f33b23c2 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -1423,6 +1423,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>>>              size_t s_length = s->length;
>>>              size_t pad_len = (mask - iova_len + 1) & mask;
>>>
>>> +           if (!pfn_valid(page_to_pfn(sg_page(s))))
>>> +                   goto post_pci_p2pdma;
>>> +
>>>              switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(s))) {
>>>              case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>>>                      /*
>>> @@ -1449,6 +1452,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>>>                      goto out_restore_sg;
>>>              }
>>>
>>> +post_pci_p2pdma:
>>>              sg_dma_address(s) = s_iova_off;
>>>              sg_dma_len(s) = s_length;
>>>              s->offset -= s_iova_off;
>>> --
>>> 2.25.1
>>>
>>>

