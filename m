Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDDC19066D
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619150; cv=fail; b=GfN3TOyqbBGKOdV5FcPNfvpRzEk25hRZYSbwVD3Dbtdy3LWMI8fLdoBzzJMUSGsFBn4/mUV7Z0IYLhj9852m+pJ6PLSEuTa+NopBCzzPuvmRujBPYT87lqS99pl2QCbIEHogYM686BaSzdWUAsjHVT0HPwNcx0lKFe2J6RLzV68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619150; c=relaxed/simple;
	bh=Aedp7mfBneiyyN5VZVPqA6Fm7wVKnsdk+MAxay4uRyM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eE3cmeILN276yonO9rY1O6RS05WZ/6iM09dXkD00V2uJMOaNWSeBlC/w6yKg5HLGyfKIZs8mIL/yhcthvHI9P3wCPiWtHfv6Et8zF8JLWHLJJCazZOS2nl2UWTQ8HCXU0/anPBZYDa/uxA0JX5wTTdCdeUEm0RzunjFQrU7p6JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D4iFCbjX; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D4iFCbjX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laUPqTW5FQUz/b+6omN4eEjCUk3YKd9ExB4t82KEv9hISMBvJJ41X+Lx7Julifg2IES0zWjrXoV9Iudp1Oni9z/99px73vmoxEdP0DCU7OnLBdDU3lK/w+JrUvA8t0tKPHh8Tja4MZR7mRmrqtq6goU+66p3V2YS3YKpZBy2EXzEIK+zx44sAudC6VagVUIOmXf7c6u/ur2GMnacTBmxiUkhS8i5nEpPg3k0PEJeloQDbkV4QFrVOe2yyjie8MJrflSrBaRHm57mVQv0HNrOvyZ7mPKnKzhXL4tMLTfs0Y45aaLnFVXc4C+oJ7PtPztNu/XhwzX/G8Mwx3bJLMIn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u51JrBEfSj3+Bi/Rt7n8LX/ZLHR5bIsDebItEVTtl38=;
 b=QZhgkRLjYToBjumgMrwXgOCJR2ncifd8yYeHDtXhYB1Z5I6WrwRkZafETb6evjy6TIROlP+itHKPnpt8DDoUtT7MqYz7yMO7IhepKB2Bc8q8qu1ZLm01Sv6gfv2zRVkQ3HiDlbhpBxHv1NFXLYx5NU8wVFyqfEb0YW2aBLh0ZwnuvWHZf9q72CrD0BHaoERto3cH63XWajJqBz90NiscB/XmlL/rkgoSayMv+0yY1MKDsdYWX6HAa5kOFXnm6jCUVLH9Y5d53dbIoQ5YrXchWnS2Ju/XDbbqjcnjVIrjjeFRV8s61M5nWrx1Pdummk3A5L8p3u8sVf8auIGFCOaxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u51JrBEfSj3+Bi/Rt7n8LX/ZLHR5bIsDebItEVTtl38=;
 b=D4iFCbjXaVYCiaPCCnIAOW1gN3KLnkmOW8ZDJFnu8q3wRB6HYHUFPQwwtKvvKpg5Der6u8HCrX5gjK+MEkLWcTqXLhgcsz13deZfKSneghxa6aZaApQHoUGeGI8xlGhqyNNI0NhxgEa33hW2TYkjev8SxC/IWlmGhzQMKehU1Z/bHi4ZpEsW5VwdjR2OUEJmqUAJ3UIOLg0teVE860mv7F0xxfcS1MM5e4oUebYrMem2r5huaDcxVRR9UyanzQHHGaO9DVKGX/F1uvQjmjp+ohCfVUZ1IOHW3YaN3odN/79V905satuwVmn+DQm63zVBZgt5Af7kmlp9ZR7BTF0Iew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.31; Mon, 14 Apr 2025 08:25:46 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 08:25:45 +0000
Message-ID: <22a1216b-4ab4-493e-a1f9-1588840339d8@nvidia.com>
Date: Mon, 14 Apr 2025 18:25:40 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] dma/mapping.c: WARN_ONCE on dma_addressing_limited() being
 true
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Bert Karwatzki <spasswolf@web.de>
References: <20250412094110.3208838-1-balbirs@nvidia.com>
 <Z_yjDsmjjCAMHUrh@infradead.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <Z_yjDsmjjCAMHUrh@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 299ff57f-4158-484e-d2bd-08dd7b2df423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1FRNW5oTUsvZVA2TDN6bnJmbExhMnY4VFFhZ1VOSXBkRTVVTVFTdFdYNlRz?=
 =?utf-8?B?U3ZLNmJYTWZRK3lEWWE5czBWa0xGM1BRQXBMTWtzNFJpcEVPQVJEQk9oVk1y?=
 =?utf-8?B?U1BJU2NmZHE3VmprbVkwMmo3Ym85NldDdjNGVnJ3QUFJYlF6c3NMY2xZeWp6?=
 =?utf-8?B?dXNmMm5LSkM5YU8xSGJWS3Y1bkdncFg3RVNWUTRPc2ZyOGNHblh4ZHY0Ky9y?=
 =?utf-8?B?aVdXajkrblFva09nd0piMmxmN29aZCs1V0NSNkpSaWRaRlNNSFFpZmhmUVlM?=
 =?utf-8?B?YlgxTWVXU0Ivd3lxVHhXKzNPUVo5M2d3T09nenJUTTZPVWxIR2NrSHlFUFAx?=
 =?utf-8?B?SVVsOGUxTk5wcXBwbXBGMmppemVBeVVKY1puSjBlNzh6U3dEUVVxd0llZUQ5?=
 =?utf-8?B?V0J3TXk3Q0EzVWdnSnBoVVhtSnYvc3FDQThzOC9FT1MvR0NPbEZqSWlDRkQz?=
 =?utf-8?B?dEVkWHMzTUFTVzlKbWVhNG81RkI0SytEeDlQTFpZdWk1Rnp6dk5BUW8yb1ZW?=
 =?utf-8?B?dXJ6K0U0cWxEeElqbE5lQURmSEswMEF0YTdqdnRmOVAwdXFXeFdlY3ovY2dj?=
 =?utf-8?B?cEttZnBEUXJLSzdSWmZGV3cwZW1iVUUxTytPVktFUU5ieU9nbVRJMXo0eG1I?=
 =?utf-8?B?YTFVVlhra3lCTTFnVVdyTWtCaWRPc0hmSVFTWFVONkhSVnF5RmlWbjBIendM?=
 =?utf-8?B?WVZjMjdJQ0lsWmJFQ2xlY1NHQ2hEQlNTSmhQNG5CKy9XZkI3WDRQMWdXUDlK?=
 =?utf-8?B?anRNWWZaS0tITUNTc1FTZkhzUlNiNGJWZThmYUxEM2xPOHJSb2tqM2prRm1C?=
 =?utf-8?B?UUJzSEIyQmo0d01aYUlrZHE2by93YWNqY21vcGs1cG53aElWeFVVMDJUallB?=
 =?utf-8?B?L3h4dWkzNVhqODdMZ0pGWktJV2swWmREc29rcVZFQmV0NmVZMzh6cTU4UnhY?=
 =?utf-8?B?MlZacXhRZHJnUzNEUjlwc2FVMnYwZlBuYnQ2RkZPK0hSTWR6NndvV2l6a25F?=
 =?utf-8?B?b1B3R1MvdlVpRm10dzBlc1k3cWR6aEt0Mzh6a1M0MTcwL0pyangvemVqYzdF?=
 =?utf-8?B?N05nRGRETFpFU000NEFLMGQ5bnFzdjhVYlRjNVJlVXhpNU5OOGNsOVZ2bm93?=
 =?utf-8?B?MXVzV1FXdDVIelArTEh1VTBXK3VNR1RtRFBHY3pmZElvbVdBZDNVMUJaRytm?=
 =?utf-8?B?VlMvZXNEUjJvdVY0UmY1eXc1K3I2aFRlUWFTc0lIZkI3bHl5aC9meUlMcGpI?=
 =?utf-8?B?NW9jRmRMbXduOTZIRm9QUnM4OGM5QVlHdHhDWWtUdUlNOEhCMmRDTmY0U09Y?=
 =?utf-8?B?VDJWOWZ2dDJWRjRzditrdlY2a3N1YWZEZWJ0SFdhdWt3bTFFakJSRjhyb0xu?=
 =?utf-8?B?ZUZuODYzQ2g2Umh5amwzcXFtNU40b1I3SmZEcC9ZVVJ4T0dzSWlEYTFBNW11?=
 =?utf-8?B?MTZqa2RjdDZkbUJSK3p1dlA5MklZN0M0YjBYN25iY3g2ajBJMzNzTHEra2pm?=
 =?utf-8?B?OFJyVW1ZODIzOTA3ZjlodDZQdC9MQTRvUlh4Mk9DeHNNU0QxUzkrQmRvUTEx?=
 =?utf-8?B?V3JVWnNYWnZ3Z01CRzhIZCtzTGNHYlpTbXFrMjU3YmxyV3ZFaTJHVEsyQWRT?=
 =?utf-8?B?Nm9SRlZ5bjFpaXFJcTFsNzNNdTZVUXlrNHFGeE1oSDdUY2xiWi9zUW8zQ2hS?=
 =?utf-8?B?OFNjblpqU0lmS0pwbTE4NFc1Skx5b3VVd2ZHR1g3aUQ1aHVYMmtPZFI5amF5?=
 =?utf-8?B?SUJPcSttYWhqRWprZjBoeFB0bkl3Um9vWEZURCtjWVFuK1dlMjBzZzNHMzFi?=
 =?utf-8?B?aGdMY1Q5RWpNakZ4b3VIVU1LR3ZieTBBRzluTGp3R0k2Y0pjZHlUMXE3RGM4?=
 =?utf-8?B?bEZKaDZEM215ZzVwUVBUWnRVelBhVUdsdVhpdjh5eFhGU3lwR09NL1EzVzlh?=
 =?utf-8?Q?I1eN2nrWjTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXBKMk1VQmUrcWJ5NFJDNEFpOWQ1Ui80K0JOcU5DaVR6dDJTckk3L0V2Y0Ry?=
 =?utf-8?B?QVpzQUtnc1lZem42UXV3Tlhibk5YVGI4c1E0S3dwSVMwejVLRkoyR1EyWEtQ?=
 =?utf-8?B?OTBIdFNPMHZOWExKNTZ5SUZVQTRyRHBmMUhVdFFUb3FHaDRqNjRhR3M0WkhQ?=
 =?utf-8?B?b2FWRTJoeTVlTVQzYjBEdTV3dnNGTlEzcmp6N040MTJKY1dUVlhIbUhXcXhO?=
 =?utf-8?B?S0xGN21sN2FDMllyWWZ6UEZiQThUaTNZK1k5bkErdWRDd0Z3dWppVytSS2p4?=
 =?utf-8?B?N2RHVnhpVzgyQm5vV3c3d3IrUElxVEN6ZkJjbUNTQ2phQnlQR1JDMEJLSE1j?=
 =?utf-8?B?a2owK2xZdXpGSXZqRVJtVG55dUtlYzVkcTRmY0NFOHhwNnhjakNDL0k2OHE0?=
 =?utf-8?B?cXhveGxkbnI2OVdtY3RERTlZT0QvRDg2djd6RTdBZ2NCU2N6SDErQkphV2ha?=
 =?utf-8?B?ZmR5M2VmS1lsWEdlQUdQWnluazBKMVArcW9maFlkWU1HNGkxUXp0eFRYK2x2?=
 =?utf-8?B?dG1aeDZWWlg2STZDMU04ZXBPK05CMzg0VFpsLy9RU3NDQ0pGS09oenJiaksz?=
 =?utf-8?B?MlBOcjI5OThzTjlrMENZYzR6ZzJCM0YyUGYvYkI2V2ozVFp0Q3U3eXZoV1Zl?=
 =?utf-8?B?Ym51WmhBYy9wOVZodHJZbElic1pOMU9JTlRNS2VUSm1QNk5iSmFjanN0TGZX?=
 =?utf-8?B?MWt6MjRXSXNycm1Pa2NuUlBFU0tJTUQ5Z3RseVp0NXFpWUdUc2htelVNc0VF?=
 =?utf-8?B?bVZvZFpXL0tuNUVpeTFpWjl1c1dKWEJQbUJNRUsxQ1RTYVU3OGxSV3NOMG1h?=
 =?utf-8?B?S1JnQ084NTNjNzNlL0RGYmN0d3NtM1hIVWxCQWkwQUFGcm9PVnpCalpTUkkw?=
 =?utf-8?B?Sk5TZ2hZelNLdmVMNWpqTUJ0bWhmMHpkMDJQb1ZURUlaaTRtTHJXbDlKVGQz?=
 =?utf-8?B?R21yT1ZmL2RISHNPN3hLM0JMNnRaa0luNDFRaVFMWkRieUYvRUV6OTNmaE4x?=
 =?utf-8?B?eGVhcnVQdWY0eU5YdDJZcEZSUklWRDBpRjBRZUI3dnA3TS8yK1QyUGlXZmxP?=
 =?utf-8?B?RVE2ODlMNHp2eEdmQUNpYUY0ODVzMUZROENGMDBxU0QzemFzZy8zcCt1cEE2?=
 =?utf-8?B?NVFEeHYvRFBFYm1oV1pKYURzLzk3bG5FVjEydHRsNXBTUUo1LzE5OXZZQVpn?=
 =?utf-8?B?U1BUS0dOUlBnd3RRTHZOTVBBd3EvWmNzcm1iYUlIMEpCS2pGQ3MyQktidjEz?=
 =?utf-8?B?NkdPRU44clpSa3pBT1FMa0VBQ0VyQ2R1bk5kVy84VTlpVkx4KzFrS0ZkUG80?=
 =?utf-8?B?dTBWSVdjTllTSUl4b2dqNFZjWlVpUExjbnBHU29uUTdERGdtbHZxUlZZeEU1?=
 =?utf-8?B?T0RrS2FNV0hLN3F3bUYyVVVCdDQybHh3cjVJMFVTT0F0RTZYZXQ5Z0NDb0VZ?=
 =?utf-8?B?U2FaV2lrNXlmOG93TWZTa0JlUXJ4VjdFbEl3ZHdsbE5GUFBBMlQ2SVBPclpC?=
 =?utf-8?B?ZkFOUjVyd0NBdnplM3JwWlhZQzhJR2tYOFpjWTl2RlhPZlFZRWp1VitzcjdL?=
 =?utf-8?B?MXlPWlB3dWNqVUlTTkkyTXpWdTlobEh4ZzA3cnM1UW5tMkZ6SFR1RmFjNFlw?=
 =?utf-8?B?RDF5d2NQaStEL2VBbk8zbUVJZFdJNTh2Ky8vYnVIKzRiaTBUUFZULzFkTlhu?=
 =?utf-8?B?RGpKeXh5MDZiaDZzd3A4cnhHaW5wamkySUNTME9CMjkyK3BwSnp0WXY3OVF3?=
 =?utf-8?B?SjUvUXBYUmpVOTBpenB4dmtVTFdLMys0Rm9yOTZaN2s5TkE2Ymp3bFJtSzhZ?=
 =?utf-8?B?RnJ5Z1UxU1M2SGp6YWVsYXBKSkdWMWphaFY1c1FncFZOSFNmalEvZFlxN0VB?=
 =?utf-8?B?Zi8vU2VCY0R5YnovRnlnMFRoNmtjcU8yY045NFRlZHNpYm1Nbm5TbGEyY2Rv?=
 =?utf-8?B?anpLREZlSk5LUnpWd3Y3V1p4RGhEQjUydG5UUDJnOEQ1S2Y0bVlOdEV5YnRC?=
 =?utf-8?B?a0o5TjFvUmRzUGNhZkFjMksreTFkdU9aWi9iMnJoRUEyK04zQVd6aWJQZHVq?=
 =?utf-8?B?SXNyRFduNjd5ZnZPK1ArZkJXclUvM01aTXFzbitSNXllR1R2YUNhMXN1akV3?=
 =?utf-8?Q?DZYskiaNUAYbAcgVn6PcPyi2/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299ff57f-4158-484e-d2bd-08dd7b2df423
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 08:25:45.7678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UKUa/CNmqBjvg7hOI8NJnYI5dM/TQehbe15t7o4svgMJ3qZTIuDokXWlrC+tfjsV3FMv66k6qtbBRUTSlhuqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023

On 4/14/25 15:54, Christoph Hellwig wrote:
> On Sat, Apr 12, 2025 at 07:41:10PM +1000, Balbir Singh wrote:
>> In the debug and resolution of an issue involving forced use of bounce
>> buffers, 7170130e4c72 ("x86/mm/init: Handle the special case of device
>> private pages in add_pages(), to not increase max_pfn and trigger
>> dma_addressing_limited() bounce buffers"). It would have been easier
>> to debug the issue if dma_addressing_limited() had a warning about a
>> device not being able to address all of memory and thus forcing all
>> accesses through a bounce buffer. Please see[2].
>>
>> A warning would have let the user of the system know that in their
>> particular case, use_dma32 is set due to the addressing limitation
>> and this would impact performance of the driver in use.
>>
>> Implement a WARN_ONCE() to point to the potential use of bounce buffers
>> when we hit the condition. When swiotlb is used,
>> dma_addressing_limited() is used to determine the size of maximum dma
>> buffer size in dma_direct_max_mapping_size(). The warning could be
>> triggered in that check as well.
> 
> dma_addressing_limited is a perfectly expected condition, and returns
> true for many devices and still plenty system configuation.  A kernel
> warning with a stacktrace is not acceptable for that.  A simple one-line
> dev_info might be ok, but could still be rather spammy on many systems.
> 

Thanks for the review!

I'll convert it to a dev_info(). We can remove it, if it causes confusion
or users complain about it?

Balbir
