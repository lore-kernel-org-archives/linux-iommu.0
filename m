Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D433A3816
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665559; cv=fail; b=AN/s9KqcMKS3IS4rzwV+uCD9PTTVjfM9MV65n8xBjEQtifRxRCO3qdleapvyakAsPWcVcdjcM/OZ26EEknOHXaPIAQc3UdvDYxyhBD68HnlXcmLccAsvQvX+zCLDCw1B5Zy0Sm4Yb8RYkYivKhEOUSduZ8bCr6b7hYYkj5q5lXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665559; c=relaxed/simple;
	bh=rS10WUzBcmo429Yam+CQOEMHLWxCMQ8DcgI84kV3ONw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lf2MM2jsuusRDCtb8c+/5qQ0oVV3LmF6I2sZ9GZbylaLIUxzZIIIOCB94l6Y2FM2ThudbpKpR9Ic9FX5csis6mXwvAeA5k6USpMfq/mBn4pL1N4vKNzPU/Gt8fyaSYqeAUJMspJecBaAxZdV6L11vGjBQe+xX8A1ULcUGJnvVfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HeXGJ3lW; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HeXGJ3lW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t027QiN/HYB3Bg9hmNWCFJ9u4xcIS/C+dRY9J07fm2Kb7Nr4oP03QoPzvmk7YcQaKwMaUsIVCYskmNLbYePcJiNHZPsqlrgE4H12fnYcHVBv9Ckyht+C72Xb1yliVSY3quzJhhFUedoEcpkqbOZ05rGAIyASCl0lkQa/RtYO0acNqqJIg93AnQFNhyi+pgpfC6oOkVuqPK93eHNJu9KLchQ+GPQ3AcD4kTDSjaQ1y7R36A2BRCByLM53D9ihgdgp7dWJzMXsRyOD830eN/sVqLOXQamkKYkhLGXTOc2vSmUIbrwysS1bCcmYTT50I9iAA0xV3VUTxThQbjPAf7B9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eY8IwiZj0Gw+LHhFSUKuOzf25S+swrhHLMzVCCdMmA=;
 b=alyGHT3vK+G6Sakv6jGwv5f3lwEDQCgXv0IbYSEMXnT4vOeqEQBqmtR62Eagv6WITvBkNLRyoIG3/0+Y60g9gZobsJOwV6dqVLTASTB9VrAP1DMxlW+t07xewwhs8oMZ242G3B1sadJyS8ok6zIO+OqStwz1dwPyh3QJIQw7Pd26qXoXaP7meHykmLToOSU/RgV+9JM+Jo14GXR2rDIb0W0J7R6XFUgl/EhLswRsqmXufzj+cwUkEF7xqEzcrtMLyqZHQjnm/32JmkMgKRqZXAlNgCvvz1/H9yzzbhiL0zKrm+iHwiUtMP3kSjLIe8uWxE8OGJkicQofVO7RAqkfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eY8IwiZj0Gw+LHhFSUKuOzf25S+swrhHLMzVCCdMmA=;
 b=HeXGJ3lWUO/Knj6vH8RASGZnMlGyHMNTOfzrz4h5evbr3InhOSX6hirZIT25IfSkaY1kKmClMRZxsBPid4/NLG05AXNg9uTSuzBiv6MS/ejxqU0/JIQC2lDd6ZUcrKCRySmnVo0k9HdSfcjzs+id6uTzqrJG/RfPG1BdbBLICnAoXSG8KOU+yvWTDCs9KRuVueR5DZBMYKsjV6wxMjqvnG68/tHxkNF5ZDdXKF09kGefpcGX1FzVWRohzSZCioxzPu5Gl6Pjaf6NjIP9/Eu7fjkbj/5pi3LLyZBVse0vZzHFXbv+qnmAeEaEu2M9VVVmE3w7ps+xAE6A5/AuCjwFiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 06:39:14 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 06:39:14 +0000
Message-ID: <014ae844-e7ca-4829-95f6-31de979db140@nvidia.com>
Date: Fri, 10 Jul 2026 12:09:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Factor out CMDQ batch
 force-sync conditions
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260709095613.831769-1-amhetre@nvidia.com>
 <alB0/RXGUtoyXggd@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <alB0/RXGUtoyXggd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0041.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::13) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a19ac7f-8fbc-44d9-9281-08dede4df565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	qoH1wije1R2OOlIVZoywuFKv4//V8RxT6bATxBYI5ak4LMMoeD5dUK3Gl/hXDaj7r8tb6ifmUrrM74oCnQJTwsISrpvdxLYDIL51dM9S+g7NyHm4pnND8R5ZAjFvPP3Nbkpa3Mmk3/Zi9p14pO/oGWzPewW5V95pGpiQ/I6UVwHRHoqJBQqUhZuM2LRatCZm6zz5ffSpc7P7xaCPaA83IpLAscyb/fgdEil6ipOAOV4KUl5BWCs15wA8PFNGRHmSJ5tGQiBeurqhpXkfzvSypZbCsn9b2V+/AK7ga640Dn12wIbxvV7GiAFrRx8RdL8y7IMsUQCnUIV6IKJA5XVGSmCF3G69v584dqSKX9jhkrm44tOvRbiC4qCZcKOQZ6aj1Pk9hkqi+IBdKMlphUi/uto+D9p9eZwKqe0yrYBq7sjh78lAJGLdJctbsacf2XhaQA97flITch/4//hDLqIAh/vFjmKSG9SHWMXd9XWbKwX74VuFTwQv3PYpP5f1mBUULd84T+/7SLBqtRKlQ1liJ2eKY0HxJEaEWMHf6jlaibJcUwaiFhN42Z7j5P5Nqa9/DAYYfcC/ysJWNouFlinN9L1L8HzGhk5Mz96aZW1C6FQXlbQdN04oElv4Iz4vKmNp/l7ONIu9MlRybtuUY9A7VFVn0eVzoH4tKjKPBTA3eds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFBhUE4zdHFuTFV0WUdWSVVzYWo5cHRVMCtrV0VFN2FhblBsRDVFY2hNUFNY?=
 =?utf-8?B?SE55VThpK3I4bzVCekJBcDFUaUZNaVdWbUxoaFpLWFZ6cFNidkZtYnBORmlB?=
 =?utf-8?B?OVZwUldWcTBSZ21TNENENHpLWGpkZ1ViUExlRGVhNElQWllGMXNrbWc1anBY?=
 =?utf-8?B?eGRUVkJFWWExZk1mRDBtcWxad0EzUFBxT2p5MHBCUDk1aVRuRkYvSXBWalZk?=
 =?utf-8?B?aVZBT3NIN0g2OXAzN1pyQUlVUHJuUlBPVzhpMHRrSy80WE5CNDUrN2FiT0Jt?=
 =?utf-8?B?WFR6QytKSmNnR20xRXFOZWZiSlJBUSt5enh2WTJMWVRKallWTjV3NDM0SW9Q?=
 =?utf-8?B?TGtaTHltWkpuWEVtU2h5VHNrcWdVaEsyblk2Y2lRa0J3TGJNOEQ3KzJwYm42?=
 =?utf-8?B?ejNhc3VTbFlseTBSSUhnNmtkTkwxR1JrMmlyYkErUlYrSVRDK2haYVZONW0x?=
 =?utf-8?B?M3lyZ05JSW1tWm1IcUhNcHVjeERKQzYyMk9qTDVJUUdpUDdQdjQ1cXMvVEJj?=
 =?utf-8?B?aldRd0R0Q3k3K21YV0NDNHMxR2Q0TlRmWUJ6Z04zZEw5R0Nmb3YxWEhQMngw?=
 =?utf-8?B?MzQ0dGdENzhqbEdHUXFNN1VXeHJ5YmZZQUJ5VTFubEtVQzR5WVZkMExzTUdh?=
 =?utf-8?B?My8zRE0wTUVOTmZaeFA0YmNCR2Y4ZlBJdGxyYUk0ZlRVSlFsSkFwSWJ3S1Z5?=
 =?utf-8?B?UTlZRFRJOHJSTmhEc20zUkJCWWIxRXNabEFhcEhESitJTndVLzhMYXBUTnZn?=
 =?utf-8?B?VTNzek1yWUZqMTRIbGFxUlc5VmJoZG10UG5LdWMzYTNvcnJmYVgzWDZlczM3?=
 =?utf-8?B?Kyt5eW1NTXljSXp4VHQvTzRUMW93NmlUY3dLWFlvQ1hHWDF4YjdNNnVjWFpX?=
 =?utf-8?B?Q0R4YmdpUFlKZ3J1Mjg0RVdDakFRa25DREJRbGpJMTdFbG55MGNiWWNTcjVm?=
 =?utf-8?B?SGEya2JUTStyWWhJWW1iK0pKM0FKenl2L3ZQRnQrUE05UGxCdlJ3aExQQUEy?=
 =?utf-8?B?czV5dWlxVHZOTk1ORnhHVC9BRTBwaGswdDV4eCtXeksyMndReTZNWGNJMHpV?=
 =?utf-8?B?TnhaeTl2S2kwU1RXL2ttTEFMaGd3L0grbExOQlhBOGJPTGdtWGZBdmRuNVNM?=
 =?utf-8?B?VFBVK0xrekh1c1p1ZFZFcTFrNVNUQjIwNVFuL294eUk3Z205K0pUVFV0MUJO?=
 =?utf-8?B?TUw4OG13RW1CSDdoRTVqQ3ZyZEdXQW5RZytHY2oxQkNGWUpaL2g1RkQraE1R?=
 =?utf-8?B?RDlFYzUzazZXK1ZBYzRERVhDMlROaDhzcnZzaW02UWJid2FYS3FidE1seGVH?=
 =?utf-8?B?VjAvWFRxQ2twOEVMTmNxMC9UNFVsaGZYVVVkQjA0Z1VqdS85aVc5R2hkaTVL?=
 =?utf-8?B?TjNHTU1tdzdDYnVWSHUzb1U2OFN1dHJGRjRPRnB6NWFlUTlVYmNyOWZkb0gr?=
 =?utf-8?B?VjNRZ21IU2pHaDZodWNvd0l4dE1QTm40dEkrWXl4QW9uMHBjTGpKNE1HTk1w?=
 =?utf-8?B?VjZiNHVCMFVzUjBYM0ZFNE5TVCtrdWJHZEl1Q2Vld0prSkFKTEtJZ3BZSkZJ?=
 =?utf-8?B?dDQ3TGZRYnRZdmVVczBhZFMrbitiU1dNOC9qTXdHSE9FeEJPdk5aWlE4bE9J?=
 =?utf-8?B?QzFrcVEzZ3hFVERGd1ZzVTdjWHR1cUxFUlJlbjFOdXRrZ2ZQeWEwdU5TOE1x?=
 =?utf-8?B?UnF2bXNrZ21uaHpBNzZNbEp3aEQvYjU0N2ZLeTltOG1kaWw5M1YxbjNvNm5E?=
 =?utf-8?B?bTdsaXc0eGFvQUd4RlRDejBUS2xiSnNFUmxyUndibG85cWlzZEk4VFo2djZj?=
 =?utf-8?B?ME9uSDhNUHJlZTlIU2xkUCtEL2wzbFRhdUxaRGpwWG9jTmUxc0dkbUZ1Ukcx?=
 =?utf-8?B?Kzd0eWN1YldxSFB3a0tiajJNN1gzRWpoZTFHS1FXd0ZPb0wvWlptUmlUZDFr?=
 =?utf-8?B?TEpUWW9yTmthTVhvbFFKQWg2ak53TUlwdkx2ZVB4ZGF6Q21JcngxK3E4WVhW?=
 =?utf-8?B?NmZCYzl6OWVQcG9aRkcyVGNzSlhkQW1aazlkQlluTWU5NkZTemNRMEpzZmIr?=
 =?utf-8?B?VUhCVGp2RzlRY1Y3MUpWY283SE15U1d6WjEvY2c0dGNsSDRnQ2hkRGZkL3hB?=
 =?utf-8?B?SUtFUjEwTWhSWXdYZ0tvOVFGZ3dIQ1R0aktaVnN1Qi83cEdkaWQ4TVhJV0Ev?=
 =?utf-8?B?V2l6dWw4SzAydTh3ZHNtMTlPb0VCek9rYlUrSWtMM0Y5ci9HaTk4OUdnTlFB?=
 =?utf-8?B?aXl3TkFxM1l0UTVmUDR6bWJZTTJrUzNTM0VCMHNYNXdIWDk5UGEyazgzZjFo?=
 =?utf-8?B?czEvakV3aEdHSVpRamwxckRWTk5JcTg5WWJ2UlE5cXowaEhSZVNvQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a19ac7f-8fbc-44d9-9281-08dede4df565
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 06:39:14.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL6YpsoDP5HPa+THrW2yC8tCXsYKmzOw3y/6D/TCoQOvN+zJM7gYkYkbIQtdsYJxMFIDaLWjNgj0YkyT3Dbj2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344



On 7/10/2026 9:58 AM, Nicolin Chen wrote:
> On Thu, Jul 09, 2026 at 09:56:07AM +0000, Ashish Mhetre wrote:
>> From: Nicolin Chen <nicolinc@nvidia.com>
>>
>> arm_smmu_cmdq_batch_add_cmd_p() carries two distinct reasons for
>> flushing the current batch with a CMD_SYNC before appending the
>> new command:
>>
>>    - The batch's pre-assigned cmdq does not support the new command.
>>    - The Arm erratum 2812531 workaround (ARM_SMMU_OPT_CMDQ_FORCE_SYNC)
>>      forces a SYNC at one entry before the batch is full.
>>
>> Lift those checks into a new arm_smmu_cmdq_batch_force_sync() helper
>> so that adding another force-sync condition becomes a one-line
>> addition. No functional change.
> Patch is fine, but you're missing the cover-letter and changelogs.
>
> Nicolin

I had sent out the cover-letter along with change logs.
The sequence got messed up while sending. Here's the cover letter.
https://lore.kernel.org/linux-tegra/20260709095613.831769-4-amhetre@nvidia.com/T/#u 


I will fix this in next version.

Thanks,
Ashish Mhetre
