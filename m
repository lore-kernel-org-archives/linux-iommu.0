Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A22F0665
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066151; cv=fail; b=T6vHNf+0xESlUTqLOiWTkhjgTXsqHNSzP0we/Ova10DlmcWikuXV6eY3zLq9un+vX9ZVQZGCafBlEdU4Dnjwjd+2VVZs3SAtt2IHChazkAPKzlRoq6a8UnXjZBIbgmd2jMSysXvZiDxq+mkJEE4sKu/QJuRRZiPZNhqXesMZZiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066151; c=relaxed/simple;
	bh=1REn0KWkJ7V51ah0+RwlY1mKDrNCzQcd57rz3v5LLgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IdQkOSuucuWuzC/BFu/s9rp0bgCnUCLtWLad8fa7YHV+Q0wSmi5PFdx8llHIOvAp7EXWdhCzCrfbtivFWFcz3eCtpthnDP+lVYIPihhVxYRUoSDaYzv18DYcwbQATljLnWxFehoqWq4wF1BRrs4r55YhXV5pl5Fcmap9MLgivIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fM+UNel0; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fM+UNel0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfK1skB5yNfqsWGsXPwFSEqc4hbw/RU6NxRGPVK4rfYUchhLpToE1tJrSfjMK7V+qEbQu5qzXsOWV6ZULpiSHemEVPFQBWKRHCtbWUw3uBz9YZEXOTyCtYDfYjHPK/Oly35pyPxP3Mb+hJUh3nW3o0Ukv+UTf3FytbhbzxJ2qYEQyaNG7Wja0hjC7A2RbOXsRs0KT+ybioP3j1A3TtVyYrG8UUAhRwurlhFEdM6aQSNWAb+KTxjE8iPloChu93QsMspsqPovJQOKkqQfFFlpD9YqhN/DeozQbHWwx9T8WPF3DKLrrNilTx9/OsUM4eIq7JJnjW4gpuSCFtAESFnsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CS6o1u1wC5bqFFFDPZXzfyazPhIrTWgu3fLsrWbgsDg=;
 b=dtjXq2v9l+g3a03Tvo4Ktre13E1ulNyD2ZGiNX1Ym/L2FW2o/i1HI/09dRaLJEzsWHgHTQiCqpw6WwNHVDET1Af9aydSuS36usqcdt+qLKYGpnOLx5sk68YreDIjJdwucjtJ49DwS8SQzmQMgXkwqaTH5FMX/aIceED/ivzg6lzuM5B0HRqGejx60CCddI9sVLHNevw9zGipNqzA906XoJkUnofyVJmGFxHKiHtKopOcauTIOkRoOdY09OqF85LapS+1gwVAkC6KQwk25JU7c2Hj+s//rO39Ub5W7Q+VudRfDbrWvAXch779oHBaBeh12Fi+IX11jJ1G10jpnsPSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CS6o1u1wC5bqFFFDPZXzfyazPhIrTWgu3fLsrWbgsDg=;
 b=fM+UNel0dVU0wEPTjYUOuXy0jCGAHiBKCnUg6M2BFbXNeF2mNt1RO4L/JO986yWeIVUxfeRELEkki7aixEbjO9kOWg6x0urlDVRbmY6KwqDtVr5jKZzHYWfG/QRWiDpiqdnullmnAYidv6TuLQCshA1ub61oGAqpoVtyTOP/P/ofTm3UWbjPsZSAKx/RmRs5O4/Lylg+odH2xlHQ7VJiu+fYFoMN2FYrCMX+GK7nzizdTPQ36XtgsZhuPBNPYYGXwsyj8sTdXLrROboS63yXqjN3X714IICQXgw41fbOsyx43JbypyxlpBGiSdxJsnmwSjTxszlgjGM+4GLJJ4w/eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 10:22:26 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:22:26 +0000
Message-ID: <dff3a962-82dd-4aac-ae11-69f0e95ba04d@nvidia.com>
Date: Tue, 25 Nov 2025 10:22:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] arm64: dts: nvidia: Add nodes for CMDQV
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251125071659.3048659-1-amhetre@nvidia.com>
 <20251125071659.3048659-4-amhetre@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251125071659.3048659-4-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0397.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::6) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe35a16-5e38-41ee-3417-08de2c0c87d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TitlUnRKZGoxTmNDNkd1eUpnTXlkMWdEenl6aU5RMThrTnNPamJ4ZENMMnk5?=
 =?utf-8?B?akRmSlorckhGYVljbFE4QytrcFJEdjN0M3FRai9qRmNhUjVDenBnMDE4MkZx?=
 =?utf-8?B?VjFGQ3A1Q0UxMy9CT1lHcXJ3dkk3TlZjYUtZaG4yYitiT0pHMmkyeUZMaStY?=
 =?utf-8?B?WW00TjNHQ3Z6LzJhT3JYQ2NTem5hQzlOL1I2Vk81eU45R2VrU2l5TUxhaGVK?=
 =?utf-8?B?c0pPNE5iMzVBa1pwcVZRUTJ6bU4rMUFsRGlXanFTZ2k0SlN1cEV3ZTRFb201?=
 =?utf-8?B?ZHBlVEFIaGUwUGpJby9RWCttMmJKSjU1N21rSkEzWHZhT0o4QVRHODRPZVhF?=
 =?utf-8?B?K0cyUEluQVlidlZMUjlkM3NSS1hUbHdiNkdIQVMrK29RSmxzWjM4TGxBZFZZ?=
 =?utf-8?B?bSsvcUpaYUFxV2p3dGlSOVh2dGlHZ29CWUFHbmhXWFdHR2c0WFhpeEpKd2VE?=
 =?utf-8?B?WTM4dnl4SlpEamwxM2ljaTFjSS93b3N2MHo4V0NLdU9rVG1ZRENJQ1R0blVU?=
 =?utf-8?B?NXZkTkZFaFBVMkpRUHFFSGZ5SHVJd1RtemZGaVJNZ1VWZHp4b20vYXYvMElD?=
 =?utf-8?B?SG5zeXo0RUZlcmJtcFFRMTRSWFdldFl2UGdzamdBQmtCQ1FUS3A2cmUxeE0y?=
 =?utf-8?B?RmswTW9UQlRCN3Q4aklGdjhia0kya3F0bmprL3pKMy9YMmxBdEVsSDBwUDd5?=
 =?utf-8?B?RGgxakNEVmVBTHhnOFpsdyswQks0UU0raW9qSktwR0s0N2t4SDNmUXhEM0N1?=
 =?utf-8?B?VStDMTJDQUlua3ZPUFFEcVNEUnBxSGNPaTdNMTlRSkpGL00wbHR3cWZuZ1Ru?=
 =?utf-8?B?enRGM0V4Q01wR0swUVEvVElLZHNXSm91cVN4VHVUYmtsdTU3bzkvZXRoQ3I4?=
 =?utf-8?B?TzVwM2xjWTZwR3dIM0orN01obTRldDhBZnNRUmQzK0s3NytNbEJTNHZsYXpw?=
 =?utf-8?B?aGhrM2VnR0d1MGxNRUMxT3FHTFFuVUdzbnJBU2pmNzFBb3haNG1XSUl0OUNI?=
 =?utf-8?B?Q1VhcW5FVy8zQXdvQnN6Z3lmdWY1MHdiOVE2ZU5qakR0VTZhNUc3Y0FRVFhh?=
 =?utf-8?B?bU5CaGpzYk5GczdualNla09tQlkzNE9qV3ZHcmltN3JoU3pLMXZKdXdkQUZz?=
 =?utf-8?B?Zi9adDQ4OUtjenQ1blBQSG1JM2pSVk9kMnZqSk5mUUVKZ1RBODU4eW50M3My?=
 =?utf-8?B?MnMrTFBvU1V2VytteWFBUnYxcHBMMmpIeG90bVo4SlVmdmFkRFJzSEdEbW5C?=
 =?utf-8?B?K0tZNHZtVnJYcUdVSkorWG4xL3dPdkR3dy9hQ3VkSVlLVVBiUkloZ0htU1BK?=
 =?utf-8?B?ZHhhZHFoWm5rcDVrWXB0cHVkQjNnL3o2aVdpd1dxNkdMeUxBNTNwNk5OZEts?=
 =?utf-8?B?aVJEcDhHQmJhVENsa2ppTS9UZmJ6T3VzS0dnUkVCN0t2bDZQS2t3QTYwSDd4?=
 =?utf-8?B?Tm9kbWttczRRWVIreVlJOUErRysyMnhLYXk0TVh4ZmhmcmdIbHo1VElrQkc3?=
 =?utf-8?B?a0ozM0JHdC96Rm1lYUF3ZGw5THhheFB0L0VzZ215Wm02S1FzTEI5N2x0UGUv?=
 =?utf-8?B?c2VDdGYwbkRVYkVWaHptemlMcDk3UWQ2eGhwUzR2NjdmL01PcGJvTEpXTXdD?=
 =?utf-8?B?Tmw0dHNlQ2V2ZTNWKzFTKy9VMnU2QnFWK1FDSWpoZVNOL251ZU44b05zWnpD?=
 =?utf-8?B?SUhIMUpVdmhYZ0dmQlFmWTdseGxGdVI1ZkJ3aE9SK3FEZEN1VnVOMEZXYkh0?=
 =?utf-8?B?cTVsUU8xOVFqVXZqZFZOZGtmUGduVGgxL080WTRuTDJZUDgzOFJ0QkMrZzYy?=
 =?utf-8?B?MDFzQ3RDb1VKcCtKU0FXcDdwdzl3b1dXbmFVcDA3YmtRNW1sUGxlY25VcXU2?=
 =?utf-8?B?cE4wZnU0MU1GTDZkQXBPVHkrSXBETnp2SmpkeVNVU0FzUkJSSTN5U1JmNGtR?=
 =?utf-8?Q?QmG7PnKDNeAhc+nAyTQPcqNahAiKjS8l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3ROaGlDT3RuV1JzNHVOSmVod0tEajRRWG9PVUp6emJHZU5sdWpINkIrc2Rs?=
 =?utf-8?B?VkVDaVUrbDNpWG5FTFZmbDZYbmhBSi9iRU0zSkcxZzE2S05zajZEWVRNcDRM?=
 =?utf-8?B?VGxlVCtaTUJkNVh6dGFJMHlWem1EWGRaWHVKaEpEcU9QRVJkcDRNOGNJcUNZ?=
 =?utf-8?B?QVl6aXJXYTd0SVJaU1hCSmFHSDJXSTZoeXZQVHk2RmdiYXFSY3JYZGVyTldK?=
 =?utf-8?B?Zm5MamJJR1loWFU0akVabzB2US9HWEgxT1NTSVliUlk1V1VMUnBsYjcwbDNH?=
 =?utf-8?B?Q2JlbmlWRHNGQW9uU1Q5b1JmbTRGQ3BNQjVCb1dlSG5SdEVHWm9aNXNGZk56?=
 =?utf-8?B?N0FkSmVDcno0QzByV0hKL0ZTTWM3VldQdmk3SGxIYzRKQmZWR2N6czBHRUdD?=
 =?utf-8?B?RlNCdEFvTTZ1RVowTUdmbWlCQjdZZWRUTFhUbUdhN0xuKzl6R2xFNUIwM25L?=
 =?utf-8?B?Y0VqSFdQNnhvZjZuZytWNTVyd0p4WW5iQXhQbFliZ0hrMTBLZzNYWldnZExN?=
 =?utf-8?B?dm9uT3ZoQUQ2YmV1cXFRajJjY1NKa2xlS1BOSDc1UG93YVJMWVpqS0ZlYlpE?=
 =?utf-8?B?NzZKZXhhWkNVaitlN0g4VWpRc1hyOEVDWk5MK1diZHh4eWJ5YmdRZmFZZXVz?=
 =?utf-8?B?OTNQMzRvUjJqbENCaDR6YWZGWXlzNjVTbjlWSk9xUEFoYmdBU2puakloQ1NO?=
 =?utf-8?B?WjhJdUpUcjg4V0pHc0hxZmVlekFEMWxNalVwSjU4VC9pdmN3dlRJYmVORmc1?=
 =?utf-8?B?SVI4MjA4VitDQjBtMmg3TE04Um1NRGpsR2xldDU3K0pPdGxad1dCUXVXNWFO?=
 =?utf-8?B?RXFXV0QvczF2cG1uK0QyRUd0dFZHRnBpRGI1UnpYY2dWNURSTEJWM0pSR1dw?=
 =?utf-8?B?d1pDNzQvNUxVUllHcFdaS2lUZ2pzMFBlYysvVmF4c2NjSytGNWpKWGNad1Bh?=
 =?utf-8?B?ZXpPU0ovWWJCVHdseVE0TTZKcmlwMHk1dVRhTW14cHVkOGY2STYzaldvaEQw?=
 =?utf-8?B?SzBnckFMVDVoUVBRaDR4UlFvOVBYTTBIR0tndUJLSENET3JHY0Y2UWdmMEQ2?=
 =?utf-8?B?OWdQTWZKMXV4ZVVQQldUeTV1Z1paUVJCNjF1UE12M3QzUjZPYkRTUFV3RmNy?=
 =?utf-8?B?SjM4bGJha0U3eFBUYXVKdEQya3RsekVzUkk0czNzRitqcVVDZHRhZHlsZDA4?=
 =?utf-8?B?Q1U4enFWbU9hYzlHUmtIYXByQVUrYW10K2t5ZS8yTlIvMGlQZW9zeEVkVWpM?=
 =?utf-8?B?WGpYL1huZk0weFdnaEF4Ym9lWVIzMUlnNXg5NjJaNkI1dm9DYVNlbzhoOHF2?=
 =?utf-8?B?QmJRUklEOURzQStZendmTUVrZjFQcUZBd09nSGtmbTQ2TUdWVnJ5OWY1RXhl?=
 =?utf-8?B?UHcvb3ZVOG41NXR3VWlIOWhMMURFWjJrYmxZbVNpbTVwcThrVGNPSHVXd09l?=
 =?utf-8?B?eU5aTDB0ZDdLZ0NWQUU0SDBZdEhRbmhVRjErMDIxYzhuYUd5K1F1WkkvWGla?=
 =?utf-8?B?eGc5TTA4alJHM2xINzladFNoSnRZZWRqRDBlak8vQWx0SmxHRy9PU1dLTFE3?=
 =?utf-8?B?WlRzS2pNTEVmSGNrTUFJcVB4TjF0S3NQc1FqNDZVamdwSG90V0R3REFEUkR0?=
 =?utf-8?B?TXB4NHAwSmNkQnMvWnE0OUNuUGUxREI2MnVIUW9PV1hhckZxY2tMSXRUaVRt?=
 =?utf-8?B?TmRheThHd1ZiZ0VmWldXSWx1QkVFSFJCUnlGWWpIYnNIZU4zcllCUld3SGNs?=
 =?utf-8?B?VVhHdWp2MURDcHRGNkE1R21USzRkaCtCSmtkSER1WU9LRFpSMVFUemNoTmxw?=
 =?utf-8?B?c0Z2MnhKYnlNZWZMbkZ3SlRpak4vZmtMcG1zZUV4VWU3ak1kcGlYaExMa0th?=
 =?utf-8?B?QXVhN0NXdVRsZi9wRE54UmZ1SkJ3cXprQkhRQmV6eFV4VHIxazJndi82VFJp?=
 =?utf-8?B?VVNnZFdvbXBjdUh0YVhHdTlGUll5cE1vSTY2S2pLTzEvY1BSTTl2Q21oMFUy?=
 =?utf-8?B?aExoUWJSVk95OTBzVCsvb1dIbERyclhHbFpPdGFGdXQyaGViYjB2QUdHcnBj?=
 =?utf-8?B?bFpzOHM4TlBGWTUxcjU2QkZoQ1ZjbmUxY2lFYThaOHZmZzFkYUZwUzBUOFRz?=
 =?utf-8?B?MzJRUmJhWU1tVXE3MjYwOHNKV1ZFUHR3TTBYYXhocTdyV3o2bGVQc2djSXZu?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe35a16-5e38-41ee-3417-08de2c0c87d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:22:26.4796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxJoKyQwt7ouPbNAFfbDS+zNvTDIOMOULa2hdEeH5IiaunvbHL09cKG0lgkrMMD/hcpSwbM53a6po4sRsMBpEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436



On 25/11/2025 07:16, Ashish Mhetre wrote:
> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.
> 
> Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
> CMDQV support. Add device tree nodes for the CMDQV hardware and enable
> them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
> instance is paired with its corresponding CMDQV instance via the
> nvidia,cmdqv property.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 55 +++++++++++++++++--
>   2 files changed, 58 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> index 06795c82427a..375d122b92fa 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> @@ -26,5 +26,13 @@ iommu@5000000 {
>   		iommu@6000000 {
>   			status = "okay";
>   		};
> +
> +		cmdqv@5200000 {
> +			status = "okay";
> +		};

This needs to be ordered in the file according to its address.

> +
> +		cmdqv@6200000 {
> +			status = "okay";
> +		};
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> index f137565da804..d8287b95221e 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> @@ -3361,7 +3361,7 @@ bus@8100000000 {
>   			 <0x02 0x00000000 0xd0 0x00000000 0x08 0x80000000>; /* ECAM, prefetchable memory, I/O */
>   
>   		smmu1: iommu@5000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0x5000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>;
> @@ -3370,10 +3370,11 @@ smmu1: iommu@5000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv1>;
>   		};
>   
>   		smmu2: iommu@6000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0x6000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
> @@ -3382,6 +3383,23 @@ smmu2: iommu@6000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv2>;
> +		};
> +
> +		cmdqv1: cmdqv@5200000 {

Same here. Please order according to the address.

> +			compatible = "nvidia,tegra264-cmdqv";
> +			status = "disabled";
> +
> +			reg = <0x00 0x5200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		cmdqv2: cmdqv@6200000 {
> +			compatible = "nvidia,tegra264-cmdqv";
> +			status = "disabled";
> +
> +			reg = <0x00 0x6200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
>   		mc: memory-controller@8020000 {
> @@ -3437,7 +3455,7 @@ emc: external-memory-controller@8800000 {
>   		};
>   
>   		smmu0: iommu@a000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0xa000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
> @@ -3446,10 +3464,11 @@ smmu0: iommu@a000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv0>;
>   		};
>   
>   		smmu4: iommu@b000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0xb000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
> @@ -3458,6 +3477,23 @@ smmu4: iommu@b000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv4>;
> +		};
> +
> +		cmdqv0: cmdqv@a200000 {

And here.

> +			compatible = "nvidia,tegra264-cmdqv";
> +			status = "disabled";
> +
> +			reg = <0x00 0xa200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		cmdqv4: cmdqv@b200000 {
> +			compatible = "nvidia,tegra264-cmdqv";
> +			status = "disabled";
> +
> +			reg = <0x00 0xb200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
>   		i2c14: i2c@c410000 {
> @@ -3690,7 +3726,7 @@ bus@8800000000 {
>   		ranges = <0x00 0x00000000 0x88 0x00000000 0x01 0x00000000>;
>   
>   		smmu3: iommu@6000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0x6000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 225 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 226 IRQ_TYPE_EDGE_RISING>;
> @@ -3699,6 +3735,15 @@ smmu3: iommu@6000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv3>;
> +		};
> +
> +		cmdqv3: cmdqv@6200000 {
> +			compatible = "nvidia,tegra264-cmdqv";
> +			status = "disabled";
> +
> +			reg = <0x00 0x6200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
>   		hda@90b0000 {

-- 
nvpublic

