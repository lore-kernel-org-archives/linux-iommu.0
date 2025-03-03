Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023086.outbound.protection.outlook.com [52.101.44.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133562147F3
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031802; cv=fail; b=HA5KoYmOpWx4IhU9VV9OTCwUrb+0HcKPE+AW2GQypzvzrgYOwcV9/PyBu3YtavyS+w2WME8F/L6WddtpzTuoZh7uQdqByHJ6MxBgacbcSc/OzLHYFfKLYxdPEGj12wr2sb2ez5zaVsjMe/oiKYubVU5glkP5s1+awljk8cuKW3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031802; c=relaxed/simple;
	bh=oSr2cacNtk1N2CsOzYGxpuOsxKOIqFZaM/m/hBCIh6U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2lnSTlntd010rUpaNt4EHuL6YXSItX6XNY/7Jd4gNNWXJYNtNw1RsmJzgs76YQVLhhIYUtidMLxYw+gAGBfSw11+Whu2XsRSWgJD9xJ/JQN7iV+askkVYF0t+cx5k7h8+IhtBXocb4P0sCYkZNlD3CZ1FkXDbzWdXIwDvMrRGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=fMHddgaL; arc=fail smtp.client-ip=52.101.44.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="fMHddgaL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exwLo/WNrS7LWG7LU1/1YAfziNUe+txWvR83UI1+/IKC1LcZz4y7dmGoqMNg5Yx451+yhOa/OOtoeb6bD4AlRHuPvVMwq/l75D5TG5rEtxIMjrKvDv5PrrZ+64un4Agc7VZ+hpqmHhsSNI8ZQaBVUfwNsMOIyw0Md0wMW8P4rf5To751LiLLNI6vshLp9Q5e8X5aX+2oDBefcAEGaIp6l1Co7r66IsKuoAliCTpTLFJ+0Y+3/o1NcH5Zbxzsm6RtNZ3J9hbzNjIGwg1zLimScbJPdIZX9OJ/Y0pgw132lGpba90l2YLhXg7KiqaLqx4aqgQmR26M7br4UBw/n0vjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNNpzn2A5Wa1pIWP1haVAteA2rYTUckUb0uSM4Grbe0=;
 b=MbhipaRwRToYmLfB2PHbscvXZtNxw2vvqZXohs0XWaTETe4q5B2DvNPAh0PLoQSEdj0GrjRmd33ER/JoNPVwxuAMr1XwqI8XkVHVUyISbTpEqeLx3gO0ON3hwHrCo+dJHcF31bIGAW97VYHfjhegr7ZHUO8OvQy7+yUNGaeoEL7RW0VYaXS22Z64/wCx+Y9kp2Q3AmRkGm/7t7m7hMsvXZaePUyjMACHmd3wt7oKb6ay/4EmlegmPz59AQjpYON2GG6b+RJ4C9KABEpZ3qI5B30FFHFvLV8Ha8kcKLUK6YsOkvpOkjgMdWj07WUZBbioWCVZBitwdWnhcruJX0PYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNNpzn2A5Wa1pIWP1haVAteA2rYTUckUb0uSM4Grbe0=;
 b=fMHddgaLQd4nvAEnmkGl6vrCu3FT6Jgwa1hFDRoBgUOpPhr+PH1tbYWOfAyfHl5XygPZvlyCqnDJlKPzZ7W5xHYQJkKl9fcUV95obvooXVqcBKZ26NaK9qIAZGyIX9k3CgUisOsy6pdVDeMDfJP2nfmLxY87pv4JEIua0qaNs3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6877.prod.exchangelabs.com (2603:10b6:408:161::22) by
 CO1PR01MB7387.prod.exchangelabs.com (2603:10b6:303:15a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Mon, 3 Mar 2025 19:56:38 +0000
Received: from BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0]) by BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0%4]) with mapi id 15.20.8489.023; Mon, 3 Mar 2025
 19:56:38 +0000
Message-ID: <2f46a07a-20c3-4a7a-8174-99631cfbeade@os.amperecomputing.com>
Date: Mon, 3 Mar 2025 11:56:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
To: Ryan Roberts <ryan.roberts@arm.com>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
 joro@8bytes.org, jean-philippe@linaro.org, mark.rutland@arm.com,
 joey.gouly@arm.com, oliver.upton@linux.dev, james.morse@arm.com,
 broonie@kernel.org, maz@kernel.org, david@redhat.com,
 akpm@linux-foundation.org, jgg@ziepe.ca, nicolinc@nvidia.com,
 mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <b46dc626-edc9-4d20-99d2-6cd08a01346c@os.amperecomputing.com>
 <43732270-8fd0-4a18-abec-096e383a6a4d@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <43732270-8fd0-4a18-abec-096e383a6a4d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:610:4c::25) To BN0PR01MB6877.prod.exchangelabs.com
 (2603:10b6:408:161::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6877:EE_|CO1PR01MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: 92608545-0cd2-400b-7cb2-08dd5a8d828c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEhZaE05cGhkYkUrck9oVnVFVTM0VkduMDI4WkROc1NPVk8wZHRoTGtYUWtL?=
 =?utf-8?B?Tk8zMDd0cCttS01xUytQdXRhMy9hQU1KRWgrZ3JpWE9BZkFkc0kzZDZLemth?=
 =?utf-8?B?WkVvdTFCM2tWRjRyYjNPL3V0K1ZQUUd5aGJiNXNYVkxuMEZtYXRId3RTb0Mz?=
 =?utf-8?B?U0lrVHJDTDRFbk5vQjEvUFZ1dHF6NWVEenh1cXE3NDFzR2Z6UllaL25NUlF3?=
 =?utf-8?B?MUlmd1JDaTM3R05CcU1IVUVTUkQxYnBZcjNzdVpLdFhmb2VoVjJidE51UDJj?=
 =?utf-8?B?RWdTNUJpNGN5Y09kWGtWeG9VK3cvT0ora3JZcnlYK2lMNHZrVTdGSVVCM3NX?=
 =?utf-8?B?K0pWaGZOYkJGZVNGb3QvNFZwRlBwUXhLd3krNkJIMXFRRDRvejVFT2tlTnpx?=
 =?utf-8?B?Zm42ZHFJVzJpRTNsWW9KK0g3aDUzWVhtQVNSSS9zd3dJSngyVUFScjNpUHRT?=
 =?utf-8?B?R0tLRGNTckx3cHBxeng3bmJhVXVEUmtVTDJiTzNqY1N4VnppMzk4TGdmc0VN?=
 =?utf-8?B?TkpESWFFY3gzdXgxUU1DUXNmZERPeU92aytONTVGM1dMYWVUSE5ZNm1rZy9i?=
 =?utf-8?B?Zy9NNityWGI1ZG1EakhWSXB4c3Q2VVB5T2w2czdROTNOSGRQRkV5RDliUmY4?=
 =?utf-8?B?ZnRKUmpFeXBZT0JaaTJleUFnZTlWbFhLZTlGcHdtNTA4UVUyc2I3QUJSWlB5?=
 =?utf-8?B?KzNJdHNGK1ZPR0FoKzRGRWxGdWE4TWpOcjZQTEJYTGIzR1hSbzhSbHRZUnpS?=
 =?utf-8?B?UldMV2hQMFBjTzY3ek5GVzFYcWprZmF2eDY1VitveXdGOVpoZEhobUxVY1F4?=
 =?utf-8?B?WDJEM3g5WXhLRHpCWWF0dmJBcW91YUpnNjB5S1RHSmlFWHJzcHQ5NjdJdmhC?=
 =?utf-8?B?TjZManJCYWVHK2I5ZExuZWpGRXZ5UUtDUHh0Z21PWnpjVmlybmZoN0Y3eGwr?=
 =?utf-8?B?ZjA0dnVhTmE1bTJaWU9VRDMwWEJuZEYrOFpVL1lXQXd2a0tLcmQvbENDU0Mv?=
 =?utf-8?B?UmhPQ0ozTkt6Q1AwRTAzV01EcHJmNDg4dUNBbUJ3SDlLaks3Qkl3UUhZZi9Q?=
 =?utf-8?B?TjBPbmQ5UHQrVWdsVlFtT1VSdjdRYkdDOFVZZXpjaldmek15Mmk2OWtBN0Qz?=
 =?utf-8?B?eExWYTdWWGdKTWlDc2pPaFR3aFNlTHhuWklPQ2x6SVhzQ29UM1hVRlZGUGpQ?=
 =?utf-8?B?UVR3VWljUDUvQ3ZUYThXMVZhS3NvTEEvWHY1VkVodHRsR1BhallBSWYvN056?=
 =?utf-8?B?aW05NWRKaXJ5bFpaeTN3b2Zvb20wZUk4d3VKY3FnUDd0TW9JQjN1WFhtSnZG?=
 =?utf-8?B?aEkzOWkva0dDaGd4MGFYZlhwVHNZU0ZiQ0UvaDlWeHhlclg1dUtjbnN1RUE3?=
 =?utf-8?B?ajE0MSsrUzRrNkJuQXhsNFI4U1NtYU1wOTJMcnNIazF5bVpqS1FXVUx2eS8x?=
 =?utf-8?B?akFZRkd2dkpYS1EvUUJadU96ajdIZzUzZmVsUDhLQWIzUUQveEV6eWxqcUFV?=
 =?utf-8?B?SGtkWlFEOTU4K1EzYjMrdkVDQTJQL3BVbkVQTXU3UmJPbTNlMFFtNU9MaWNs?=
 =?utf-8?B?d0lod3pjYnN2SCsxMURUTUVrTUZVWFhzNzNqa0lleWcvYk9DWjV3cXhCNWtQ?=
 =?utf-8?B?TUMvcmJvdUM4alJ2Rkt2bk1DdlFvdndUTTZuTStOWUgvSXpjdWx6UWwvTjh3?=
 =?utf-8?B?dFN3VHNZTjd5TlVScjFidDZoQVFtR05CUG5jN3NFRzF2TzczSGJTS1hxL0tU?=
 =?utf-8?B?cVQzdEIwMDJDTTUrSlQ3eTJaWVF5QkQvaVNkd2FnRWJRZmtLeDZXSFBieDBX?=
 =?utf-8?B?ZUQ0K2lmWmZJQUFMVXQyb1NTMmNPRXBOTEh2b0ZTWHUxOEhCdmptSlpLVG5S?=
 =?utf-8?B?dmFLSGUrYjYza25PWjhmd0JzRFovWE8zK245aHZLMzd2MHJ0bkZ1aG82R3Zo?=
 =?utf-8?Q?eAkYzcroKh8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6877.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2YxcnBCa0FuZmhRNnhENGdoM29ZNGRVRER2TlNzQ0hvUkZFUU5NNExwN2Y0?=
 =?utf-8?B?alNiYWRRd1d3OTU4WGZ1clBZV1NnQkU2ZlVqSktDdksyMTlMVTJ4WFB5NlAw?=
 =?utf-8?B?bVVHNUFvbXk5N0RFbzZTUlVONWRaUmxqNHBoVENNa1NHSkk1R3ZCK05qS3Jl?=
 =?utf-8?B?alNCYTlDMnBlRmYxaUU3WlR3VFdSTEFQQ1JwaC8wZFBqYXBFTEtxZklZRUN6?=
 =?utf-8?B?ZzVWMDI3UmJYVWhvTmR2N2o4cGZEWlkvcDhDVkNKMmVxSmh2MHhiTEtaZk5j?=
 =?utf-8?B?Vlp4TWJNVnlpRHRBZ1NBNm52SkU0SVBlNk9pWmx0UUFicXAvbkZINTFjb2g4?=
 =?utf-8?B?VGJvb2JKcWswNmtCYVVEaEVaTGNBNGZHUUt6NVVmU3J0NU5jb3B4alJJSm5K?=
 =?utf-8?B?dGR4dFlNQUNJeHRIa3VicExOUmlPRnIrTE5URnhPSUJUTldsREo4Ky9zYkJy?=
 =?utf-8?B?WXNkMVRpRHJpOFhwNHZtc2hOVTJaOEJESWJKVHY3Zm1yUnJIeWtoQmZkbkN6?=
 =?utf-8?B?TGlwMnRmM3hNWldaenRBSEVreVRnUFpJVnBYRVRxemJYcVEzRkJ3amJBT3Av?=
 =?utf-8?B?TlpxRWdjWFllK3Q0cEJERFZkT3k5SHVRRm5uTEpoNXpjYTZ0SWU3MXBtOGFN?=
 =?utf-8?B?Qmk3WnBEeFUzSGVIQ2d3L2ZKRTRFckhXNEZwWXdyRWRlWXNWVlpDUjBUenNu?=
 =?utf-8?B?Vk5pYWdRZHFSdUw2c3VCbGU4TWJlVDRvamR3THhXWE9KSTJwb2JHcndJNEIv?=
 =?utf-8?B?VUpId1h3Z3Q5eE02NklTNkpQR205cEFYU2NuOGV0d3NReDZpblFyTkZiVlhB?=
 =?utf-8?B?YXJaYW1iVklYTitYT1o3Zmg2ODNOZURSRCtHeFBRNWx1UTJDbTJINTdUMUky?=
 =?utf-8?B?bzNMeEo4MjVZOW5NRDB1SEVRVkRTcUdONXZJd0N4NGFTb3ZTaFZRMDlVQWpV?=
 =?utf-8?B?bTdJclBISGN3cG1UUlNrcFA0TVNPdW1qVmlBNEE0bmZFeGt5OTBJaENBTUZ0?=
 =?utf-8?B?OW9BeGFIdWZPeFlkT3lhTjhnZmVLWUhlUFlaUUZEZnYxblVBQ0NiUGFzWC9N?=
 =?utf-8?B?VVRBM2VaTC9HMVE1V1VuZWVRd1BMSnZGTXQrNXhxNkN6S0tjLzZNWWZXWHJq?=
 =?utf-8?B?Z3pZb25yYklpSWJETklWNTVSbTNrVkxieEZOb3MxMFlYMnlhdGhOMlpqWlVU?=
 =?utf-8?B?WXNna2gvZUN0VU1kdkZLby9ZaE5yeHg1OTFnZU9ZYU9qaTBPVVVLWDNhalpl?=
 =?utf-8?B?b0htUnp2Z2xSQm43T3JDMEExUGFGQURDMXhYMnBQclZSSUJLbzU5YTBNR2xO?=
 =?utf-8?B?aGhJQVg3dmY1UVhYd1kwSmllRUd5SmdJM21OOVVKb25Tc0szcUlWcExncVI4?=
 =?utf-8?B?N1lIMW56UExEOWZ5T1JIMzZ2SHROS3A0UXlXVURMQkV1akxXaVliUlVLV3Fp?=
 =?utf-8?B?S1BHT0VhajJQYTVGMnUyMlBNTFZEQ1AvM0VDc1lNOWt3bU5xNFQ2bkFVbnVv?=
 =?utf-8?B?ZGhRYXpDWFNRSGVUSGM0NGg5RC9mT3Y5ZG9GZzlaUEF0WkxCM3NHNEpCMXMy?=
 =?utf-8?B?dFUrc0ptZ0c0c3d0TDNZd3d3R25LSmpnRndlSEdGMWtNVllFVWI4d05tbXl0?=
 =?utf-8?B?RHVWNVhwTS95SnFOaWZhQThseFZjdktENWFZT2NldjN1SUVnbDBEcHV5SFhi?=
 =?utf-8?B?SHhZVTNTbUVOYjkxWXpZWDgwcnBjTUhYaUgxekI4NklvM3FWbHc4R3U1a0tE?=
 =?utf-8?B?L2JjZ2w0U1o0bXhnNjZoZXlDK3FKSllkNXIrY3pqa1o3OFZYcTJabUdqQXdi?=
 =?utf-8?B?Q2U5ZnJnd2hwSUlXRC83djByZXBKVlRTeHdBK0M5WUlxYW81OVNjOTVIRGx6?=
 =?utf-8?B?N1Q2MHJYMVZUcWlIcElrNVNiT3lTRVYvOWd2KzlJbERQMGYzZzZuY2tDNXlB?=
 =?utf-8?B?OGhVL0xjZUhsSXVpRis4T0RCUzhJWlp6eUE4WVB3VWlBYmJrYlZxd3BBc0Zu?=
 =?utf-8?B?eVJwZFRqa2NreDNodHI3RVVDWWd3TnJYOUgzd2FEb0VNdmFhU2s3UnFxVnQy?=
 =?utf-8?B?SVRRbmFyZVoyVmJGK3pHcWhzc0E0SFE0eXB5bGx2L1hnR0YrY0p4bkJRTE92?=
 =?utf-8?B?QU1GejFtaFhQaHZkV1dwL2ozczAvV1gybFI0K3BsZjZ6VThHNXNXUVFyQjc4?=
 =?utf-8?Q?relCxv3rs7bO2EBeD3TQ0ew=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92608545-0cd2-400b-7cb2-08dd5a8d828c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6877.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 19:56:38.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeWkmG5QlOkDPFes3FZdNuBbhfrDWOIkUqPvlMFWfdSchttBVt3NXWfGOysfGnFag6jTIrz0oLo6GpsMlv4G418OiHupzXhZxZ8cvGhYQuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7387



On 3/3/25 2:17 AM, Ryan Roberts wrote:
> On 01/03/2025 01:32, Yang Shi wrote:
>>
>>
>> On 2/28/25 10:24 AM, Mikołaj Lenczewski wrote:
>>> For supporting BBM Level 2 for userspace mappings, we want to ensure
>>> that the smmu also supports its own version of BBM Level 2. Luckily, the
>>> smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
>>> 0487K.a D8.16.2), so already guarantees that no aborts are raised when
>>> BBM level 2 is claimed.
>>>
>>> Add the feature and testing for it under arm_smmu_sva_supported().
>>>
>>> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>>> ---
>>>    arch/arm64/kernel/cpufeature.c                  | 7 +++----
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
>>>    4 files changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 63f6d356dc77..1022c63f81b2 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -2223,8 +2223,6 @@ static bool has_bbml2_noabort(const struct
>>> arm64_cpu_capabilities *caps, int sco
>>>                if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
>>>                    return false;
>>>            }
>>> -
>>> -        return true;
>>>        } else if (scope & SCOPE_LOCAL_CPU) {
>>>            /* We are a hot-plugged CPU, so only need to check our MIDR.
>>>             * If we have the correct MIDR, but the kernel booted on an
>>> @@ -2232,10 +2230,11 @@ static bool has_bbml2_noabort(const struct
>>> arm64_cpu_capabilities *caps, int sco
>>>             * we have an incorrect MIDR, but the kernel booted on a
>>>             * sufficient CPU, we will not bring up this CPU.
>>>             */
>>> -        return cpu_has_bbml2_noabort(read_cpuid_id());
>>> +        if (!cpu_has_bbml2_noabort(read_cpuid_id()))
>>> +            return false;
>>>        }
>>>    -    return false;
>>> +    return has_cpuid_feature(caps, scope);
>> Do we really need this? IIRC, it means the MIDR has to be in the allow list
>> *AND* MMFR2 register has to be set too. AmpereOne doesn't have MMFR2 register set.
> Miko, I think this should have been squashed into patch #1? It doesn't belong in
> this patch.
>
> Yang, we discussed this internally and decided that we thought it was best to
> still require BBML2 being advertised in the feature register. That way if trying
> to use KVM to emulate a CPU that is in the allow list but doesn't really support
> BBML2, we won't try to use it.
>
> But we still end up with the same problem if running on a physical CPU that
> supports BBML2 with conflict aborts, but emulating a CPU in the allow list. So
> given AmpereOne doesn't advertise BBML2 but does support it, I'd be happy to
> remove this check.

Thank you.

Yang

>
> Thanks,
> Ryan
>
>
>> Thanks,
>> Yang
>>
>>>    }
>>>      #ifdef CONFIG_ARM64_PAN
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/
>>> arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> index 9ba596430e7c..6ba182572788 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> @@ -222,6 +222,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>>>            feat_mask |= ARM_SMMU_FEAT_VAX;
>>>        }
>>>    +    if (system_supports_bbml2_noabort())
>>> +        feat_mask |= ARM_SMMU_FEAT_BBML2;
>>> +
>>>        if ((smmu->features & feat_mask) != feat_mask)
>>>            return false;
>>>    diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/
>>> arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 358072b4e293..dcee0bdec924 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -4406,6 +4406,9 @@ static int arm_smmu_device_hw_probe(struct
>>> arm_smmu_device *smmu)
>>>        if (FIELD_GET(IDR3_RIL, reg))
>>>            smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
>>>    +    if (FIELD_GET(IDR3_BBML, reg) == IDR3_BBML2)
>>> +        smmu->features |= ARM_SMMU_FEAT_BBML2;
>>> +
>>>        /* IDR5 */
>>>        reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
>>>    diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/
>>> arm/arm-smmu-v3/arm-smmu-v3.h
>>> index bd9d7c85576a..85eaf3ab88c2 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>> @@ -60,6 +60,9 @@ struct arm_smmu_device;
>>>    #define ARM_SMMU_IDR3            0xc
>>>    #define IDR3_FWB            (1 << 8)
>>>    #define IDR3_RIL            (1 << 10)
>>> +#define IDR3_BBML            GENMASK(12, 11)
>>> +#define IDR3_BBML1            (1 << 11)
>>> +#define IDR3_BBML2            (2 << 11)
>>>      #define ARM_SMMU_IDR5            0x14
>>>    #define IDR5_STALL_MAX            GENMASK(31, 16)
>>> @@ -754,6 +757,7 @@ struct arm_smmu_device {
>>>    #define ARM_SMMU_FEAT_HA        (1 << 21)
>>>    #define ARM_SMMU_FEAT_HD        (1 << 22)
>>>    #define ARM_SMMU_FEAT_S2FWB        (1 << 23)
>>> +#define ARM_SMMU_FEAT_BBML2        (1 << 24)
>>>        u32                features;
>>>      #define ARM_SMMU_OPT_SKIP_PREFETCH    (1 << 0)

