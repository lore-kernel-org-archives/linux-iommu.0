Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B41B808
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038259; cv=fail; b=V3faTy5M86xxB6opNbQGJ926VoQ0LWvhyhIx+HAVjFUtcvcJmuxj3xtU0RpsLEY4TDaNjPDQmi8j/qiYF94r5JetNC7SXX5lblyCebEETqA609pb/pYK+yEvU8+zQ/RQ4T4HaAlcTrfFM1UlfnlXGxbJdj+sJVo1/K1/nQ8S96o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038259; c=relaxed/simple;
	bh=uU7e50GbkGKkb9sNM/5Oa8h5F7l/QhHKaKXbhL+R1Rs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LOqq9sXdsG6STC+aHF8Tq9YJ2fHfOq+Vph0TxlP7QW07PIgiCdIS9BIj3M3fIvMo0kvPQKtAH2NEKXnZzpIj2LnUo4A8l9TTPrd9flor/3x68FcE/mqcNe8lKzTDWCdv9/n78IYRfqvqp5wWsEVNDrO/HjBFL1+QGPrMl3dkBwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uMALs33B; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uMALs33B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVu6TGrDxz47g3hNdAlhF7KJICpI36TKPwzwjTXC2D0iUxzQo9rch2ESk1rlYawl/ss3nQLvsiCuArwYkUExIf95rSRGqdHPzUTELR9wZZ1kGDGTsW3Nt9jj1TmcYp/vg0S8XjwGBBBtwX45YQeeJ6+q87a9rM4SiEuvv8zn3Rgi4r4HYImhqMMZnTc3VsVT6FkvPQw2R/XmScAYqSGrf+gdmU6MFQ8S/ktdVhcygNN0JCN35+unS3w4wSKYudpKR/00LG7tyqW5RiTiINGUq9Rge9p746oeaHRlCo80YpjU4z4XM74yaqnhFYMzCNiFQa9M/sUSHleCfGH/uIOvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSQ+aSGLFqU5Qhf0pnhr3zqGF1Vy71fWZckKHlF9HHA=;
 b=CtwCLyMvl0DiCfRGqggTXNq24p76e0EMBGcjegARYKghjckGHkZCLO//Spz7dBoQzCjmJesi8tt5YA5oDsRzq+dHotNEuIA/xC0ALegnVCqfAhDSoaoBu+pKAK92Wh7i5MB3z/jBfe4UfxCaisyYxXv7/emuRbNKhCsasf+FKOi7xE783JASmhy93H9EXO3ccwjwRpaL0bPpk33i9dAIh7gTn6zWUESlP0cwNwQfC2OVXCX4PpAw2OusgOhFWsOGk21orLSKmQLHnsipKf4yyD3UIfqmNfdy4APcHU4ZchMRrvqNq6G98igz8+F0XgDiBzorrA3wBSylw9iuifGFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSQ+aSGLFqU5Qhf0pnhr3zqGF1Vy71fWZckKHlF9HHA=;
 b=uMALs33Bg8cr0LmuJa72LsjmgEVD8ZXxPAbT+GaBIfCPcoKI3lM+Q2ZG/opqZjk0guiTVYxJkUgubyvgb2eRbACnluNb8HhbRmJEOd1PVUo0RRh4UzwyVfvDABKv7/ep8XlLGHla0EwBWtdoT4R2scuZKHTFZPCOza28poeHxgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 17:17:35 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%5]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 17:17:34 +0000
Message-ID: <901fea5b-7ec9-4fd4-a350-671e6d56df77@amd.com>
Date: Sun, 17 May 2026 22:47:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] iommu_pt: support small VA for AMDv1
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, jgg@ziepe.ca
References: <cover.1776075533.git.Ankit.Soni@amd.com>
 <64515b0d53c541ae52347ac3c0f90b75bcbde0c2.1776075533.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <64515b0d53c541ae52347ac3c0f90b75bcbde0c2.1776075533.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0114.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::6) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d10572-55df-4fdb-9d35-08deb4382fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ohze+V2Me/y+Jye2k7Q5jaNqWQdfa4hbqXr9EWT7jDdDTOB0fPSYwBwycw+uuWQ4zRFtvsh7FfSiEtvqIlTSFfBM+SK8YJWMRoCMujmbfNhF64NVSkTon2vVpydm2+nQxv93Gi6iHBAZo8yZbdWXVgWJFwNrRv5eAEJ6J3ckpoPDEqaucY35PGz7ld8JG0HPgA5LfplXQTn1nblRJH8nui1qBCkkPbdBK41zh+EgF5cJ1YxRpYtB+8PD92/cE1EEDsqoHM4BkYY1djOnksjCnAW3WorkS2xACHd3KUfb65qZmsgj9/lUUADP5z3+3n8KnKz8SXPMLvh11NUYW4r79MgyqkZTAibrRJGb7cak0ASteU6gzHL7OHgsBUR2Az5Wr1s5vBclHNVFn2lfkUKxdxj74OtcULgZm+s+chELm0kzUv7T+GPOtSpO3I58SMT1YxXYD/61buO1oaC2cvnWnovZ9E549j+nvb/gTHMITitG1oRUVTZWvBR2Tfouv7MQxB7bjQEWt4DOM4iRHOpe/Y6Ab4NMw7PeE3T1ATPEp00cligISF4G9lEH0K2WWH/MKALJgr/ap/C1W/vUSrxUQtxIiCVd6U+Fv6PyjKzkT5BxpPrG6LZPCHFjYuk77l/zvI10jSke2JZ4zjPMJkf8a15YvyHD5QHx30aQ7YZNuANjSOTwI5jYoWRRy15QFGuu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnRPSXVvK1NOa29hVENhL0ZYNjh1OGxYOWYzMEg5QXh4M1Mxb2V1d21PLzFu?=
 =?utf-8?B?V1htWkMwMklxVzRCVlpzZzVpV1RpVitNaklaaUY2MnZZWEpQcFdpNnlhaldR?=
 =?utf-8?B?NzVVVyszaVVyWHEyZGhBYjNCcU1BU083VDllZWhVK0ZaL1Urd2ptdXcvbFZ1?=
 =?utf-8?B?eUN1OG8rTy81dHJ4RUdxN3MzK09MdGhQSzFoY29tMnlkN2Y0LzQwM3E5OVJs?=
 =?utf-8?B?ZU1COUZBVkVpQlpiVGlxU3BoZVg5dWhDdERMd01kMVl5TlU1NFZFcVNFZEhM?=
 =?utf-8?B?QUFXVDVmR24rNkJDMDcwMExDRHpIcEcvUDl4cWpJcFZxc0I5NjBKYjFVRGl2?=
 =?utf-8?B?ampLU1lVSTd0RXhQVFBXK2FmcTFYYk8zSTlFVnZ0L0hndEliajVQUzFNK2gy?=
 =?utf-8?B?ZndFVVRKVVVHa244L3liLzdnNWl1dFdBem9WMWZyai91OHRublltN24rNzJv?=
 =?utf-8?B?SXBsdnM5Z20wdVRSS0xwVGx1aXhTcXlzMUVIbmU3VzdZUkJLQWJ1RHJUSHB4?=
 =?utf-8?B?Q2U5S1F0Q1JYRXhvUGFXVWJEbG9hUWg2TjRtd0QyN1JiNXgwY2piSVRwUndi?=
 =?utf-8?B?QUk4R1BJV0hVelBLMEdnMy9jN29nbzBHZXpnNUphVjB6TTZSSWpENkVmQ0cz?=
 =?utf-8?B?eHVpd2RRWkN5Vm9jMWtkd2dOYUFnWUxlczgzKzl4Ymp1eE9BRmo2SDl6MnNq?=
 =?utf-8?B?eFVuSFd0ekxKZEpSYWZ3Tk90R2tuUktXMWNmZEx2amJWSVhXd3pXRmtNb28w?=
 =?utf-8?B?N1VDZ01IK2h1L1dNekhLUHNudlVkWVZINTNPNGtUbDJJU3liMEJvK3VYeWo1?=
 =?utf-8?B?aVFIaTJhcEluMEM5bFJTY3V4VDhDVWY2eUprVE1FMkxnak5lWUN1ajh0dVFy?=
 =?utf-8?B?QktZN1NTR25hTVdMMTQrZXJsaVdmUk9iZ0ZoS20yVFJSb2JWT3dER2JEVTZ3?=
 =?utf-8?B?b0RHcWk3N0tGdndoRWF0eGJMalcxNmtNRGZsajN6R1NDTkhoUTZ4MklJVmZ0?=
 =?utf-8?B?T25RUU9DcUlaUEphRHgrbm5LZG1rWGFvYi9WSXRiTEhVUDg1MHg3QjRUVG9h?=
 =?utf-8?B?eWhxZmFWVkdWUngzcDNPa3RTVHZrT0k1UndENE16S1ArakJtWXBNdFdEQVNy?=
 =?utf-8?B?QnFra1kxTU5LbTZ5c3BqcGJhZmpkaEwxQnJFYVNjWmk4RUJNaUNQY0IxN1BC?=
 =?utf-8?B?N0t5VnpuNEQ5eG1wdzR4bHFLQnE4dWNYYUIwWkdTcGYvSE5oRC9iUzZFRGJm?=
 =?utf-8?B?ZjJsZmxBRG1kMlN2TzFaeE1kVmNhaUltQ04wZnZzSWFzaXFKMEZqQW1DUURI?=
 =?utf-8?B?S2JsQ3VEWUVlQXczRks1UVJGV25hdnZPNFJyK3NpSXlGY1ZvYzJZM084bld3?=
 =?utf-8?B?ZFNyWCtJNmUzellYYTFyY2d3RmtMamNvMmViMS84VDZJTjJ5NURnT0w2NDFK?=
 =?utf-8?B?cnpuREw2VTkwVWRiaHBDcG1hUGVNS2tHV3pMcUJxbGFGR2RXcE9NVTJkQmVO?=
 =?utf-8?B?SGsxRG9DUnc2YkVFN3hzMUZPK1BWbnMwVWZOODNYOU4velpMblhJMWZvcGZ1?=
 =?utf-8?B?RTR6N05qRlZBTUhJNkc5TXBjNGlhYUFiTGpaSGE4T2pueGRXWTJFbWZoVFpO?=
 =?utf-8?B?eUtIdGVnVC9Zd3dUOFU4R3l4RkduMGFaVTY4djgyM3F6M0JsQ2pVcTROLzUv?=
 =?utf-8?B?bjBpRlZUV0VhVnFnNmJ5RHFSMFNhRERKZHBta29GaXFsZWxrNHg4RnF5cHpu?=
 =?utf-8?B?QmMwK1VJcDNpSHpRTktHTitIVjJpTjg0NVhiaHRMTnNJc2k5c3Vwa0UwUEti?=
 =?utf-8?B?bFNKaVI4M3NEakpKM2o3UHRxNWQzS1VRQ3BnZ2h4ZVB4bnkzSjRzdVN5d0k0?=
 =?utf-8?B?aGxrTWxITWxoUTUyTzNEZWdVdTF1U2hoV3hWcW51N2Q3dG5RS25kb2pxYkRN?=
 =?utf-8?B?RFpNdDk0T3AvQXVuT0RzYVIvQnNnUFJWbmVhWHM1Q1FHOFJwVXMwcjJlQUF0?=
 =?utf-8?B?YlRhVjhZOEdnSlA0U0svMXJDRzdOWFJvV1Rmd2RVN0NXV2tuUnBzbmtzeGti?=
 =?utf-8?B?dXFqbC9MWmp1aXhvZmo1VElGcUNVVy96QmhEYk5peXhhSjc4T3pRYmlRcHc2?=
 =?utf-8?B?YWd1RVZZK3RmbEd2aStJWXNpQTFZQU83N2gyaGVBeEpvcnM5VDMxU2w2aUFZ?=
 =?utf-8?B?VFRPelo4cldIYkJLRHFPMU0xSlkvQnM3bEFZdjJmS0NrdVh0RHowcnJ5QUhF?=
 =?utf-8?B?akNUdVVpenVobnRCemIwaFFLQ3hCSFRoZlFaRzRtd3hVMkZLUHEzWXN0NkR2?=
 =?utf-8?B?WW5uZ1dEK3BIMkNnZVoxVEdSbFZKSUxYdWd1Q0NhS3ZHNWtFeE9qdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d10572-55df-4fdb-9d35-08deb4382fca
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 17:17:34.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXQDomR8a6QwbzFe3ApUdlmVbajzfjQYleF/W+ZL78vUwNNbsT85ZYmCUeCa73b5PjvfGxeZ+K771zGoN3fNkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041



On 4/13/2026 8:15 PM, Ankit Soni wrote:
> When hardware/VM request a small VA limit, the generic page-table code
> clears PT_FEAT_DYNAMIC_TOP. This later causes domain initialization to
> fail with -EOPNOTSUPP.
> 
> Remove the clearing so init succeeds when the VA fits in the starting
> level and no top-level growth is needed.
> 
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

