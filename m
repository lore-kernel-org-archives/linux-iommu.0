Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E68B4D5A1
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208232; cv=fail; b=QhYVX47kw+m9cwU8llSNDLXB9Vs/zYgRlqMsasZPkU/CMniZImMQb8+W9uWFtQCMoUvadquxT9gEWWOI0gMHY18lIQxipuUSGYJsrLmUeHLlb/1o82p8/echz9HSHmO3vD64ZjZEyQDxzOa2OQf1o1X8y03+AklHEAvjNDG1q4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208232; c=relaxed/simple;
	bh=SP77+sTgyEv4etyNyNrF6WcUqqrD30QOSEl/pwK1gqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ueQHvJlse39komgdjqOfoh4GLw2Lz67s07DjrqSE8rpFCvbYjan6qsfhhT0hUFcrKMwswJmDQLJcTMG7IvWFdVP0dBCoKc7qQyfRoUduCi4M+l4puuMz5lHAk7oKjEkFtC+q+mm1LtqgXp6AnHcVPr7H55keCPz/ovm8P2TmReE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ISOn3ROs; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISOn3ROs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXm0ufTUyOpryIzWbDDj7hsAH1npWiPKRXR2l5iWswPR99javLydkZD/kttSEZsGlSDd0PgoDBXJx28TDvxNZqTb4znxlFWA6hFRAa1Bs8NNqG4c67Og0KXFsU8DLq4fENyBxic9vuBFv4gbK+hb7Q3NHrxIHaTySx09hOFgimrmqoG+G1gZkfwgcQner9LZkcvazEJvH5ZDYlOYZiQSLb7/ZSb8WhCwPyMpmLKLwhLa1QfSfWgrZPwnail9ZHF7qzs2wTAXBDOTLEHNmSyKDb1Rx33qJ/dQBn10NpqkROtTJq0WeN0xS3nSYcm9jpb0goYs9EIkNevizpPOswwJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OkM8YvvXO9Z72WGcVOREvWj3RRrEbJV8vZoQSngsXs=;
 b=QHTZnArjR11IzmuKWwB1dMRB6uOO5Rf2XtDFKhbo20GfX6XygyA2IHRS5cuSSReKruXxj1Pdq25J3mx4v85Khu3+wd2YhLxV8BzqZZ6oliqpEUplvNN7SZyq12dvpABhccMv5c4Wxcm01ar44i4ioerC5cOkZBR0hBoXZWsynupJ7X8EEACUUyDnDXRMrC2216jyACGyNOm0elgI9wtx8j0x05bjfYIYnj7izMMYqDIRQ8h19LkCKEZVWEZXhEX7ABUPFL7D7kUy2cNzPOw3/BeOS2XD9FKbmVzvuTLLPxCfsGINm31ReRD16gnhq/QMF/WZ67+2Ja7zWt4cH7lwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OkM8YvvXO9Z72WGcVOREvWj3RRrEbJV8vZoQSngsXs=;
 b=ISOn3ROsw3pMxHlkbcUiX+pqtnMGm/0Mb4CSQDkNExwhWAD7uNNlmSk1fSGubjVbI4KittnKCUrVRafi4WJwDWrDM/eoAaYnNKErgN55iaCVLoivQg/E6fA1lct8f48pZgIOCcxCDbOHu0ZKEeN/YqmchIEzOnuzAQV+/y6SLYC52bof6UfhDGgW5EXzbNJFXmkl1OG3PvXsP300rZ7M2w+zMFKlK93tIg8IYdZug0C/Pz+RTzhNI9rDeYGWApGWmA4sXvjTLFanQ7QdopBVCQpY//fvs9D43gvAgxPSQKAMc5ySh/tlGB/3R3jDik//qL99jlBOoaGTBtKRVMD8aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CYYPR12MB8870.namprd12.prod.outlook.com
 (2603:10b6:930:bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 00:03:45 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 00:03:45 +0000
Date: Wed, 23 Sep 2026 21:03:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
	praan@google.com
Subject: Re: [PATCH 0/7] iommu/arm-smmu-v3: Fixes reported by Sashiko
Message-ID: <20260924000344.GA3560397@nvidia.com>
References: <20260828125409.1921538-1-smostafa@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828125409.1921538-1-smostafa@google.com>
X-ClientProxiedBy: YT4PR01CA0278.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::19) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 795d18c0-ac24-467d-7152-08df19cf4d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	mZjwfC7j1UiK3FrmDQX1v9uytF+WO5xW8s/P+CmrjCtZd2LubWLX0Ovt0/g7tmMWWcndffa/tSf9gH76pDePKJWywk9ggXT9Gs3ApOrTF6WgnL+Q8yd5TnazS9xPQNjksnR81RPIWZFQIqP1TNWm95ucCFY7ktlLCW/8aQEi9glzjxOR2IvhnvCYmt1bs0/hPDk6sK7Ns6brxDedpv+ELP9Zspqvtbdy5ggV77TvOJqeo6C/HHLhJW+hazuxDIPz766hP0UqjpmjnYlIFh7YloMzUi2Rb5qWWM/iY4uSLB7mHoss2Vjn3EK03y+YmtqUz8fWd9RhOlGJIeRBMEr8wbf9vBD5ao0WEOF2A6zL6VTuUZqk9LFBD3xb0GxIjKx+Pk2eYGyOKZIB9MRRHYqtMR5BaqARizcbMo6P8FKIJA5omCz6NO7H2wsjbUjMNvbH/Jjec54N/NFs/nv69u4Memf5gCL1Em2bKenV5OMuzy6cA1I51UnEJO4nqr6224lwawj0pONgwRdSI6vH0b3ZxMrcROo407lkxWaCT3W2Niap/unST/enK3L3tpLQ6Dj7qkifb9jUDWlAe3im4BAmNs4rwtGDTAdzp5PtgJqLaVoBc8B7fQ8L354XpfmLQOOF9DJ2/jH2wb2kfq+Akxp6DbnpcJ7D2tiOHr6CLt20RBY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGJIdnAxVmt5RWs5UGJ0SlVLREhLOXVlTEU3bThkMnE5alhRZm9nV255a3hF?=
 =?utf-8?B?RjNVeGlxSE5qekQ2SkU5dWFPdHY3WDMvZ1dSMUNJOHFwV3NuS0lmSThrcjVn?=
 =?utf-8?B?L1NSbE1FS1lRb3AraXNHT1RHZ3JVcklLbUgyaldoTVpiMm5KV1ozWVlPYkdG?=
 =?utf-8?B?bWF3QW5nRjN4bGlWMWQ2cCtUTEs3NklYd09pWWQ2dTR6VHBlQmZJb0pKWCtq?=
 =?utf-8?B?R3Z0WUhYbXlrL1F1Vmw0NyswcEFUdklxMjJPbDlTdkxucmgwTUNQZ2c4OEZQ?=
 =?utf-8?B?bEVsUklOV1paRTFRZCsxVzRpNkVKMmxaNnkvY0R0R2hxVmdsdDBleS9RelNv?=
 =?utf-8?B?dnFQOHJaL1Z6aTBudTV2VCtsdUJJYStSbWlhVHpNbTZlb2VXVmVpUk1WcnIy?=
 =?utf-8?B?bk1RVVlPRDZaOG5iYldGcHVOSE9OWlRpMWtWU0pFSmRGUi9jSXZYRDI2UENY?=
 =?utf-8?B?MUdPSm1SMzVPQ2VDenpiNFlmWmlYN09lSmZTMG4wcEQxNTFTOVNEMGpWQ0Np?=
 =?utf-8?B?MDhsSkxXZnRuQzJDQkwxN0FhOVIwc245VURybUNEQWxDVUtJRVMwVTU4WEFl?=
 =?utf-8?B?NGNlOGFtRU4vbnVxc21GWisvN29sbmdsTktycXNQYUpTdWdzbWdoWGdWMGZk?=
 =?utf-8?B?SE9XYmFCNXBVdStpV3ZmZXBFODZtSVlySFVwUkxMbmVNZmlHM000cy9BVjhp?=
 =?utf-8?B?M0FIOXdSUFB6WExUSXhCcllDd2dFejh5U2NkUXhJR0hxMDl2bUx3WjJnQWZH?=
 =?utf-8?B?VllyREdYRDg1UlJ1RnRETGp0UDVGeTlJTFRabHBJWkJFR2tOaEp5WU11WFZ5?=
 =?utf-8?B?cXRqdjE4MytvQSthT1J1WHZzYmxZZC9UWEZJMmFzekVncjVMUVRWUCtNcFJ3?=
 =?utf-8?B?SXpuSkoyNWNiOUhKNkRqekVhZWcwWVFqWGRSUTFFc0ZHaEpRSEtKRlRZNnRW?=
 =?utf-8?B?MU5VK3NJaTN1NlVneXE1Q1RoaU92UGtpWkZCcFdpb1hjL2ZEQ0RUSmxReTBo?=
 =?utf-8?B?TWJ1b0N1b3daL2xQOE56a1NqTHA0TXpOMUd0YVhKSFpWRU1xUDlHQStyeGhi?=
 =?utf-8?B?Z3pmVHkvZlFkSnh1V1ZCZElLcG81VGhITVZzaGFwWnhzNGcyenlORWwxTFJD?=
 =?utf-8?B?M0oyMU53M3BxTUhXRDd2TVUvR0E2Yml1TTVnbytMM3RiRDdCc3BtTk9RdXZp?=
 =?utf-8?B?eTJVS3VJV2FMSjVHTjZjNU1Rcmh6VWVkSVZIR01wMWZvYSt2dEtuVkExcVNr?=
 =?utf-8?B?bnBPUlBGdmlBTUhkWWJGN3pYU2wrVjh6eGN5YlVOZkFFUjNLdWk4TE9lRkl3?=
 =?utf-8?B?YUVHN1I0eHVORXZVM0NiKzc1TmNyTitNM2ZYS3BLWTBsNjJPbjRySUpOTHVs?=
 =?utf-8?B?KzYrSGEyLzNmU2lRV3NxV0FhajBpcUl3ZVV2K3dwVUY1QVp4MnRPa1pFYjIv?=
 =?utf-8?B?V1RyN0VhSmdhUk1STm1SV2U3K2pHSVQyRDJjMXR2OWRNcXdyc2R0Tm9zM3Fv?=
 =?utf-8?B?RzZUSDZ6TUF3QWZ5VWxOamVVNFc5WHVjUFUzQ2ZmMlZCV2IzWDZwZkNlQ2Qx?=
 =?utf-8?B?aUxtQW0rU3JVQW85VmlWSmZFOXNMTmZUZFNrbCtpZzk2aHhtVmRVQWsrM3FS?=
 =?utf-8?B?ajVEMFR2eHBjYTZiQUtWQ3dCcUxqNWliMG4zUEdGU1lCcVU4YmNxazRKQ2Ew?=
 =?utf-8?B?amUvaVpOcVpIdFB4czRISjRhcXV1VTJQT0RRbXpwSVlhWVRvcDBIVjlBRjJL?=
 =?utf-8?B?WW5YcnBWRFl4M1Nici9sNTQwR2RjSnpSTXRvR0IwU3FDeXJVdG8vY0kwbnJx?=
 =?utf-8?B?YWtxcHZvcVlhT2t3bnpUVDRUc0IxMnNERUtSUnBmQmhvdityb3NCQVdsU1lo?=
 =?utf-8?B?UDNBRXVNcHIvMnRSS3hrNk9zWFlVMU1obUZEc0xvcFR0a0lpRW9qeWkvRTMr?=
 =?utf-8?B?V0FnekNGSFJWN2NycVI2ZGdLRys3Zk5yRzFJRFlsUG96dUdQUXBZUEFsVVJz?=
 =?utf-8?B?aCsxNDFLRFJud2ZNT3ZOdmszMWkxVW9NQjRqbFZoTEw3ODVXekNzRGtyRGd2?=
 =?utf-8?B?OUVSM3BQUHlhRnEvakpvYW5OdTFiRWV3Um9XMWFMMTBSZjRmTXh6ZC8zeVJY?=
 =?utf-8?B?alF2aHJlci94SkpzQldFVEhRUys4bTJCcE9XWXVkU041NExNUzdjb0xxeGtG?=
 =?utf-8?B?V2dkTTB6YlpzNTU5dVdPdnRGUGh3YjA5dHV1ejZYdnBlYUQ0YlJsWXhDWFF2?=
 =?utf-8?B?eFBVdGR3b1hUb3JzaHJvNGNtSmxwTFEyak5yc3V2OU1GLzh2Sk0xOU1UemFO?=
 =?utf-8?Q?zvMX3WYM86ZsUDfvUP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795d18c0-ac24-467d-7152-08df19cf4d0d
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 00:03:45.3467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpTEuQ1U+LUf5IeDXFYAq5/4kzPLqn43EjIPuN9j733PBx6QwRrGITLCX3PXKqWV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870

On Fri, Aug 28, 2026 at 12:53:35PM +0000, Mostafa Saleh wrote:
> While running sashiko locally on the pKVM SMMUv3 driver patches, it
> reported some pre-existing issues in the SMMUv3 driver (the RB tree
> corruption and a missing NULL check) and given that this is not the
> first time a pre-existing issue appears in the driver from sashiko,
> I went ahead and passed the whole driver to Sashiko which reported a
> dozen of other issues(except the last one in this series), I included
> fixes for bugs I believe are true or worth fixing (others were mostly
> missing NULL checks or bizarre HW/FW configs I don’t think are needed).
> 
> I also sorted the patches based on severity from the most critical to
> the least, so it is easier to apply a prefix if some bugs are too
> theoretical
> 
> Mostafa Saleh (7):
>   iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
>   iommu/arm-smmu-v3: Prevent rbtree corruption from duplicate streams
>   iommu/arm-smmu-v3-iommufd: Fix error path in
>     arm_vsmmu_cache_invalidate()
>   iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()
>   iommu/arm-smmu-v3-test: Add missing error checks for inv array
>   iommu/arm-smmu-v3-test: Fix OOB in arm_smmu_v3_invs_test_verify()
>   iommu/arm-smmu-v3-test: Fix UBSAN error

Does this need a respin? At least the 3rd patch there should no go
as the iommufd tree has a different version of that fix now

Jason
