Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487EA3FFAC5
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984408; cv=fail; b=giaoElOTvVpCoJ5YY39ouurhbn9R6KwXPiWpAu+o52X49Y1ta8jvfPuWB6tUc4tQYbNE02iwha4GPcp/3P+IwchbYTwMEo3il+N5sJ2gcA0on73KkcUjGX4/n99yQt+QMDbeh8t/yQMXe57SeyAxkP6PYFX/YJOpAhdvI4biIjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984408; c=relaxed/simple;
	bh=zeaIJuIXq7yEKH8iBARY1vABlsSRwAtXlmNoGQM1aMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RxQE5XmY/aoObAbUI2mOjpATBEO9U7dqQQ0DlRrNhM6SGMOcpsppvByojDrGshHY0lIdeKN+vL2L2aLurYVdmXX8xyu7m7ZuB4BiTkJUDJXTEjHQ+J1j0O7+tg7V9QlIEaBIS3aZuM8MgYC7CK1C4YRlW/3EzMSZDnoawXSMLcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gdgfoVpO; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gdgfoVpO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnxhxWBjSyb3Lifx21EeWY3+ZI+9HOsqXbeBW+UdywyYZWSzibUdUps65OUQE60HqVBEQZtuf7/kCmU4HNPmP+sMPvbelVk9SakkFN+Ei9FCanVSHo9dS/moJam9s3cf5Y/S/pwFersxMw2D1W7TDJO2lTPjTQVLRltmzkpA3O91OLvIaKpLiG7EHPqcUj4xxlmVT21zpaFXtd5O57VgiI4ZVuKeRrAk8Fetd0Gcn9z0L5fUv0REzinnBT/4et/h9PPoo5LquOj1vrwmjmCSCBztIXHhM+CTaLYI7uxET2Kw0VR3oENnku8BAFXXe36ScH8n7OCQDwLMCSu0rjTsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvjAQL7iCr9FAHVnlfylXlZtwi97p6dK/ANh8lXRvhs=;
 b=coFSjzy5vZNi5g2LUfs/aE3S1pHmvyQ4C4j0XeSPKLgm0fqAUsDF6aHoodeZQ936CajVLu6CFjceW1ivBa1L4hFoRl3PeJ5JbDoZ3Ej7fZ41PanV050sTIJ9Dmk70khd1p75U9QbtrnlaR7+5Mu+MD6pagOlzZnikMZnjHk2Akua9W2isQkg/0MhPVbyhbFD50duJUWRFik9TwOyz4Sh+zEDofF8JFYJ8ysNFrmxNMnhRU/IDI3zHncjYhwAy+FIpDYvdTexj6ELzRH3abci3xwzgkDPnFs30Bzen95RC5L5T4bGugLGB35DGZ1JILq85ABUSY+kTQ511FrwPK8wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvjAQL7iCr9FAHVnlfylXlZtwi97p6dK/ANh8lXRvhs=;
 b=gdgfoVpOBzXBIXTEkR4lYnRDl9k/BHa9mawGK0G1u7Y4aztqXpZvFAaFAFjT85n/o4B0gULK7g5eFHM1ZRNkgQhL/T9i9ZQtuIjGYmnvsekvFZHvDUfZfh49XYOc/3UbzNlPt6hH/27ZeatBqqJosQjKsRpsQ8X0n+QJ3gUPT5xSafZzrQMDG1uvG2qdgv8wgOqleX7qWaLJXMG5V9aobg3AQLfyvTJ8iteET2ixK60gO5Q4ue8SjrkF58ZBPjUsONVufTXpehL9+WPGtFb+S/gozvCZr+SFE+SHl4g5sUfwA16nvMG9oot8IfuFz8Lo34HJSIBy5SOSheufTjzwcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 16:06:41 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 16:06:41 +0000
Message-ID: <c9390279-24d9-46d4-a644-797395c2eb2c@nvidia.com>
Date: Thu, 28 May 2026 21:36:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Detect Tegra264 erratum
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 jgg@ziepe.ca, nicolinc@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260528101617.4068249-1-amhetre@nvidia.com>
 <20260528101617.4068249-2-amhetre@nvidia.com>
 <f25b769a-d89f-46c6-a3d2-9fa35882b848@arm.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <f25b769a-d89f-46c6-a3d2-9fa35882b848@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::19) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: cd937fc9-1b05-4881-6a12-08debcd31b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BtnebXoQW0LyQtR8AeszJHt5mxCytPgsJWflw73spkXfaELEREi1kqgBuClt1kLfqap7wECMUGNUZxIU3o1WQXXeonXoBBwOjtZwMguHgD0Dq67Iqwez9HoMOrA2xJMMKdqqK8DY0lMSS72gIBOYeVtWwa2K+M2A7VObLcUwJNZl1Bhffrcl8tIwgfjPB3gMhqjuhTx9DRJPOZe1EeF4qrBE+wbkNnmC1+9amLzdze4nq1VRsyCNRtRjHk/2D5jpqnBVPcYjXZzq+J2+m7wxTzLvo5+xkIFJin800Wpj0CIvn1KVZmtkASVNMqzTkD4EC3CONFQjB+RhRt95ndzwCQiVXA0T7mebbgkHE9HCBPLQRTdecBQm8RAnJuJbs0jx+otn0Gjxcy4gX2wU1veQ6sj11F0XDMlG0pj5ldKTJrbkh2vDASuRBlbpdQb+hIiNNvZUEGbP79kuhubVZsD4RExH3vJrrTrFonv4/3P146XAn6UsWiFfAuuoeFVcu6aEpfuGWNfkGjPoo+jXf02xaAKeqZBGe7bGP73LyMtlN+FOE6/r+CAZNQ5Tywy3COKO2uJX+wQYRg4l/EkJPcx/eeyIYdmgS9na29OW2y1JDamUBPAaLzEDEtXN5Y24XxJC6NYi9a8jMkSsD5UvPgJzObj2iBkqGI9QqE8U5VoG75PL0LPXbjF3fxXxl+BSTBjn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVFDaisxS0tyN3JOckUvbkRqaDlNYVZpQzJ6dVBkWVlpNStYd25MekJwOS9I?=
 =?utf-8?B?Ti9rOGpPYUlDWXQxWXN3dWh6WDZUNWNhTGJSaDZpZDgzNWo4UGZTWnBwMXFK?=
 =?utf-8?B?SVFXSTMrVTUxVDZWY29WT0ZhZEI2WnJML2VSVmh4TXgxaTNXSU5Da0l0WmRC?=
 =?utf-8?B?QTZFdTl6enYvSE5wcnJZbEt6Y3JJOGQ4bzlybWxreWx2bk4xc2duSDI4SU9w?=
 =?utf-8?B?TEhiSmxjaStxa3ZjRDhScVpKRlozdkNxT1BQdVZWTzdsdEtsNzRxcHkxMWVs?=
 =?utf-8?B?NWxQekx0VVIrc3ZWenBIbzNmSllZY2FtOHpUUFJsSlNUNXhjSG9jb01UaTBB?=
 =?utf-8?B?MGFjMk10WGN1UVFIci9MNVo4dmtkQnpXSmtyQi9KNjhUcDVjTndSSnZlb2I2?=
 =?utf-8?B?OFk2QkR5eGtDam1Oa2VSVndMY21VUndYMDdOWGZGdmhGMnpoU2ZRbnZsTjhw?=
 =?utf-8?B?NHV0UisweVlhejdNK1VST3lZWVBnZjhyK2xhV1ZwUVFSWDBUem5QUSs3aTVh?=
 =?utf-8?B?RXpGV2ZJRjNWek95bEZaZ3huUWVLYlJCUU9MRkhXczE5SzFrTERGSzFqQklF?=
 =?utf-8?B?WXdZRDhUVHNJRWp2R2VBYTJ0SWcrdGZxMmtBNUorV0xHWXFBYjkxUXBtdzQ1?=
 =?utf-8?B?L2diWnhmc25UWW1xcW15ZnRPU3lCWG5wR3MxK2JrN2ZwVDhjaTR3VzlldDEx?=
 =?utf-8?B?ZmxBc0NvVXgvbTJTZlQzM216SVdQZFM4ZnQ4eURKM3pPVTMwenhHRExKWHhP?=
 =?utf-8?B?ak01eDlSVkJlTXU1Ni9mK1lCS0FIbWlTWkNPUmw0Y1hVK3A0aWdrUm5Hc0lP?=
 =?utf-8?B?NnRySWVoOURYNzFjbndGVHJ2SjJZdW00NXBQNUZRd3ZQbU11SThxMUppc3pr?=
 =?utf-8?B?d1RZMEZtYW1xZVpkZm9TM1Z5U0RzMU8xcDV2OUNJQzdHaE5MMHA3dThWYUty?=
 =?utf-8?B?KzlFb2dJWlVyMXFkbU1aZnhuZkx5bU0yY2ZveGo0RWU0ZWdJTEp2K1NmYjF5?=
 =?utf-8?B?aW9qdzFHcHFEbVBKcWNvUVFXWmcwNnVCSU5YZ01GN1pzSGZnNEk0RVZ5MTBD?=
 =?utf-8?B?LzFkM3I3VE9sRUkvTWFJTjVWUnJLb2kwZXl6TklCcUJkWjJ1UUpLb1BkT1hV?=
 =?utf-8?B?VXd0MVRybTUvZ1ExaG8ydjBHUnJWTDFTTGFaSjNyWG1hRW1FYXVTMUJCWDly?=
 =?utf-8?B?Vk90K2JGQ0lRRWtNRVZFcml4Y01jVGhaR1J2RnY1ejVsUjllOHdlcENxOEkw?=
 =?utf-8?B?d0dtMnFKYU45K3ZiRitidFhxK2lTUnlxOFNWWTNhSUJOWkU5Q2hOQVoxRWlm?=
 =?utf-8?B?N0RRZjE4MCtabTBabzJEZ2RBOEQ0dmI1eWg3UllqMFNuT2RGRzZxS2lvS0Rp?=
 =?utf-8?B?QzE0YVBZbmh3bGxlZ2NBeXN5S2crdUR3UlZObVJBSlhUV1lQVGxUa3FiQnA3?=
 =?utf-8?B?Nlg2V1VldFRaQXBCcnIvdkl6Y21zeC9mRGU1SkVhMGRlSGRIVkJpQWdQd043?=
 =?utf-8?B?MmxRYlRsUnpPMUNyOTFSZ294YlJTWFlrclE3cXA2Nlgyd3pQRGlvTnJlTnp4?=
 =?utf-8?B?QVZBU1YwWGN4cnVzbVgzMjdraFJmOUVEejNUYklyaDM1bkxmU2R6c3NGVEJV?=
 =?utf-8?B?NGpKRmZNQ2ZpQ1N6cCtpb3hsQWo0aTZYaGM5eDlMWDlodTJrWVAvUXZzV0ZI?=
 =?utf-8?B?UC9LY1RSTjdaeVFGNVI5UHBxbi9PbTFUMHdDdHZVUG5vSGlWdGZGdG1ackk1?=
 =?utf-8?B?eFNmTlJUU1JjSnlVeGRVT1RJMm1TOUJNK2VrU3A3ZkMzalk4OVp5WDdyWVps?=
 =?utf-8?B?amRLUC96d2kvWkMraGc1WG8vTG5PY1IzMlFiR1gxZzNic2pTdnNJdkwyRW9u?=
 =?utf-8?B?TlBTWnFDOHV1c1FTaWszR3BVRWlDa1VLOXkxaHVjelRoY2hYeEg2dDBhTHQv?=
 =?utf-8?B?clZTYjl0TnFtRmlUcFd3ak93Nmw0K0RwL3VKekw4QW84S0s1dUJKRWFPR1Bv?=
 =?utf-8?B?ZWtIOElOcXpRNHN0RkhVSGhpZUcwb2d4VkhNWEI3N0RGMStVVUtYNnVDWjd0?=
 =?utf-8?B?U01ZMUhHSXdVcm45eEJpZEdHaHh5WWMrTVVzWXhhUDhPYUVFd1A2b2NZQlF2?=
 =?utf-8?B?ZXhnSkppRElRZ00yTlJ4S1NkTnJuRkhudWtrNlBQN2lGTXRTbkduSE9hU0h1?=
 =?utf-8?B?SnoremNRYVdaalJSWFpOTkpNTDZqcmtuT3RRejdtYUMrWlNSN2pFRVNvRkRH?=
 =?utf-8?B?SUhkMDdhblYwNVBHcjRJaDZlOFNrK3hCSitqYzM2RWN5eEpoVU14UEUyeDdv?=
 =?utf-8?B?RWpQMWZhWE5iQlRreWM5K0ZRdVNBZkkxWGx6aGF5TENpZWlDZkZBZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd937fc9-1b05-4881-6a12-08debcd31b17
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 16:06:41.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zow4x3H80CS667vB1V4StP2g8uUsMYempOqPcKQLdGqXJIRYwE0QfCK3AxSqbQmXwfFUupHISyX5jYk9DTbaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967



On 5/28/2026 4:04 PM, Robin Murphy wrote:
> On 2026-05-28 11:16 am, Ashish Mhetre wrote:
>> Tegra264 SMMU is affected by erratum where a TLB entry can survive an
>> invalidation that races with concurrent traffic targeting the same
>> entry. The hardware-recommended software workaround is to issue every
>> CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue is
>> guaranteed to evict the entry. ATC_INV is not affected and must not be
>> doubled.
>>
>> Add the ARM_SMMU_OPT_TLBI_TWICE option and set it on instances matching
>> the existing "nvidia,tegra264-smmu" compatible. No callers consume the
>> option yet, next patch wires the workaround into the CMDQ issue paths.
>
> Can you not detect this implementation from IIDR like for our other
> workarounds? Otherwise what about ACPI? 

Neither IDR nor IIDR flags this Tegra264-specific bug. We cannot
detect it from any HW register, so we have to rely on the Tegra264
device tree.
Regarding ACPI, the bug is in Tegra264 only, and Tegra264 is
device-tree-only. It doesn't support ACPI/IORT as of now.

Thanks,
Ashish Mhetre
