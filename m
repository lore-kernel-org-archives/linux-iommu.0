Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF1463B6C
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927257; cv=fail; b=eY7foq/pNrK1rLGlicTNa7LVzhkak41zKpc3Xrmo/z9DSyCjkTir9egGkbINxxIOICCWsp3+5zhQex8fjk3fSwTawkv2KIOJTBo6zxIeNWvMMsRc6GIfrNmMDmWmti82QAYDCII07tNOa3qfXaOFecY5MEJDqHFPA5ZSgQOa6oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927257; c=relaxed/simple;
	bh=x/2FGLnNp0gUgcUnrrBFimB5C7g5zVt1z1JtyEcs+Ss=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=WUk8+BlyoRnb4RtyL3mYGjlYjAthvv3k718o3Dp9GvstHtMmvc0G9Q8GkcGozqFs0Vtrj9V0Ls6zBYVhnioJ/ES4EjFXo86AYCw9vC/aAtCXm02KhZ3eTFIy6nGqJo815mmm1y+ZLLXUXGQwtfdaXnwqhSXo2p0+DPV2eyP/HZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gsdP+/lj; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gsdP+/lj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyCQ+jytxwzaqWK5729TUm+z93HTw7+SvTuooSvLGFHzQhwuXrDxtoc6opfj//+Dpc0N0ERTqCtLVCPscoKQGq0fL5Pxpm95rCB5+eM7yH5uUq25Bb5t0apMRJhn4YlGQZWBvAahLTJ7lqaECTGT1nrR1e7KngjRAOrFbQMo2Svh3yWD6bYurOxv7hyZ1qOBvEOR0GzHCQMUmM6j8rdN/qjNZUXqtI2HtWP4UPZy5RB6kvvZn0gvGmK7P3wG2AuJozQ5kINhOSNoml3Nto1Q+TfpzAorFBatVDjg4NuYTeZ+AxagSK2YTYPTxFM1hHnXa44UCP9IivyoedXbMv5M3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WLtHBxj0kgnRGa91PF752ZYTIC0cvCWP9HtNeVDErA=;
 b=nq2eT77TfOZxgx88qoTfcpuX8cs1QXguGJlvfDi4P6/kDpgTnkwH1cebY8OS7RA3sTicEo3+nRd+65V3RRwYgsfMzT+g6k0jCMcVse5EiXlS1R79MTkVySacgdTTA6sX/x4TQA1IQlBj86MUbY7FnDs/S0vN7CHx3u1X8TsLdR+VB766X9iI8WHJfAeDXnlYDPbf0iuPcgsBpu+xQjiNa11UY+1tH4VX8F3A1Tfd3D2FioclcXpHWifqJ5wn2rdirTuv+DeEUp1vu4UK8q6j7YZcNmvJB7hkIyeYSRV+QxuUhszIGNBKK9Y6cRS44QBaMvMrBS5lGEBnDkaYKB0D7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WLtHBxj0kgnRGa91PF752ZYTIC0cvCWP9HtNeVDErA=;
 b=gsdP+/ljWdtFemo4F6uP/XyFWGCzPSq0YqMckFhw50f+lGgHyBQgH8fWB14pMfjlJY/p9vv5gbQf4DtE7fLdXttMz436ynrtCxYZ58F7kXs2VpJ3OpgXVzu50hzoCipJEUq6tWBMgxyQAuPzjSuY6g1UpiFUq+5zA514mB4aLshaAbsbGZnfUQDAW+VV9v514BB9uMokiuNWZyAzvcop57jaEVhFmjo2m+NHei4voMdLJfaRJizkbOUVQIuR2WJisZd6HSpJ3/RZUcMmP+Ki3dcMckSdtmMirP4iWUJO4gwcF/uNACemusHtQ/5JtgAn3Lu0hHoZD3DmvGtitdMUMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 28 Aug
 2026 14:27:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:27:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/7] iommu/arm-smmu-v3-iommufd: Fix error path in
 arm_vsmmu_cache_invalidate()
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
 joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com, praan@google.com
In-Reply-To: <20260828125409.1921538-4-smostafa@google.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-4-smostafa@google.com>
Date: Fri, 28 Aug 2026 11:27:22 -0300
Message-Id: <178792724269.3808739.17189675074822824146.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BN1PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:408:e2::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e26de49-e142-40e5-c9d4-08df05107b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|3023799007|10067099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	r7G5dWbmPqkjlwB8dJEt0UuRgGR9GwStgmvpXq3a+pTecyqthkhdTYDaIPrYnDf280bkw2CQkPUDjq8i9D5ZhkUKghmutEM85pyE7wbsVk/O2aM+6XXSFBmt/PIF5zotKhZJQnisi3IJcaRk0OBmIBG0IavngcPBRtJvdOvuQSynRC+1784oJUUML+xsCeBFJbws2vuDZT4Md0NhlQcp3+LsHcgb/n75lR0U/ZU9Rsm7Cw4VnRLhy62T8NbvnyDwEkEnHl7BqLilFlNMJK3puE4V+i6dkClbGk7lK6V+1lWnbXVaNxRUlWak12U94eTfgo2/5SZIeHEQc4XEkNrya/XhGzEwuG9WY53vIdlvXIEu/mdVTVoNwTI32hVDs3UwteZkcqOniXO4+3tOYQY4rp2AoyoPTJzuEZ4V5dGIjJny3LdfhReNM09RyvDa2eZbXktfBPgiEzNY7tW+2e6GrcEkhK31MSg7IRtNTUfDipLYwQeB6k3a1B30J+VyiyLS8SA4YzqZdxkwQX+daf/mNIXMX8QdezlVQKH669CTURDWSSfFcmDXGj+SqKQHTI9VmBPCBJAHIKja4KBTGFir897IDZn4xzkYvhMd8XUa6meaUa8yG49x7IBlzCQveefCF5vduGK85TsxZKKOb5gibmm2RyRxlfcTQO5dvnX52NE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(3023799007)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bithVGdjUDVaazhPeVFGcyt6SFR4ZlhpMHdxUytyUXh1bVBDdGd4UlZDREVl?=
 =?utf-8?B?dXVqbW95akt2VEpRaTE2UGduZ3hSZE5pYzJMdE5jVlBtS2dnS2J3VVJzdW9C?=
 =?utf-8?B?U3BaS3NHL0FOdTFoZ2ZObVNzUC9aOVdyUXhhWGVNME1TcXB3NWQzL21vUTd4?=
 =?utf-8?B?MFMyT3VnaTEzQnN1eXRZd0tsemh2alRzRTM2K3FsdmhSK2VuS0ZYajNCQTVj?=
 =?utf-8?B?d0dKaFNjeTFjZTFwMkFsSHR6S3RMa0dvUXRxV0pZVVVZc3VqeWFpTmY3bUk2?=
 =?utf-8?B?V3FFS3dEcVFpVytBWW41S1ZuSkpXRHYrSDJIU09NRHRhT1R1U3h2elE3cTg4?=
 =?utf-8?B?WVA5UENVVUhibDk0cUJZR0g2WEppN29mQkNENXFnQlVtOTVTQW1OMjFLdlRD?=
 =?utf-8?B?TEFndjliSWVxTDlIU1JxcktvYmpZejluMzZzUW1SK21iUkpaS0ZyTVZ4cTht?=
 =?utf-8?B?UUxrZU55OVNBNm5qUjgrUTY0OWlKS0J6WGg2WkE4YnJJQjdhcXFJWHNtaWdK?=
 =?utf-8?B?amFya0NLOGF4Q3c2dDZyd29MaEE1RmJDWFN5VnZEQUdjdjA4WGtUWkF4Njh6?=
 =?utf-8?B?L2Z1cmtCbTlKS3dEdExGTnoyRTJIYzFKajRlbUtKV2RHZlJyM3VndTVxekZG?=
 =?utf-8?B?enRYRDhkMWtLRDVzS1RkbktDTS8xSFRvVVJ1TW9POVo0Q2FZUlIxVGFjd0sv?=
 =?utf-8?B?OTVtNW01b0l0dXprWkZ2YkJ1QXg2TStIQUxMdXJaTjhhQTlPSlNTYXd1ajVX?=
 =?utf-8?B?VzB1REt4ZDV3SUNpdHIwNE5HdkxtUXRvYVpOYnBHSFB2bXhZYmcxVXpvbTR4?=
 =?utf-8?B?bDMrL1J2NzQ1aVM0ZGxWejJ2ZXVsUk5SS0ppQkNBNENCZEhyZjN0REJSa3JR?=
 =?utf-8?B?TUI0SDlVWlJXbU9OQ0dIV21abGpkM2dLYS85SDk2MHNpQ3pWMm9weVlXOGdL?=
 =?utf-8?B?M012Ukw0VThybUVhRzNEVDhvMFM3UXJGVGEyMUFreGFma0o5blUvNThqa1BQ?=
 =?utf-8?B?N1NPVWI3TzJEZWJZeHFRSytOeEJyS1owc3hJck5IZlY3L3piVUpQWW5Db3VG?=
 =?utf-8?B?bGdSNHVZU0dHRlRLUFE1ZzhxU0hXUTE0cVBMdzFMeGVmb0ROS3AyeEtGV1Nt?=
 =?utf-8?B?c0N1NXViMlRkM0pJVzUzVzZZOGlCbGxLZkRPNlM4L1docm9jRmx6Tlhyb1RL?=
 =?utf-8?B?MUtsQVpHYnJmWGxFRUwvNTdMQW53SXUxYnlYeGlFSU51UHlTQzI4aFVkY0My?=
 =?utf-8?B?ZUtWWGFoYzRzOTlJNWw4N1ViaTA4cDAydk1hQ0dtMndkdWdGckovcVl0WktF?=
 =?utf-8?B?NG1vUTBybUFoWndBNjgyK2xWWTkxc0FzNFJaWlZMMVQvSWRaTzN1LzlsTkMv?=
 =?utf-8?B?NldId2NWenFVcTFXbm9tWUFQZEp6bU1HNVByWFRiU2ZTVllPQ0NLQUZzekY5?=
 =?utf-8?B?c2dXTk83TlhGOEtUNGJaUUpBcVhwRm5oV0t4NkVZSTF2b0Y5Z3hHL1k2TXFF?=
 =?utf-8?B?VWE4TGdLWHk1WGpkbVYrWkp0dFhFTjNwM0JtdnRhVlFjSlhvazJNczdRRW1z?=
 =?utf-8?B?dERadXNQM2hybGN0V09LUEhzMDdCZFpoVkNPTU90UC9LRWtaMGpLejZOSnZT?=
 =?utf-8?B?THdBTEQ2NG5hMXNXU3k5aktBTEZpMVp0MnUzek1DM0owQ054MVgzQ3laK0c3?=
 =?utf-8?B?VXhKb1ZtVS91WGhxRjlFUFN3cllBd0pDbDJkeTVoODdiblV4MkVtQzNlcXVO?=
 =?utf-8?B?SFU3YlR5cG1oc0J0QmNsRGhoVG1kQXZFOTNIV3ZielNyYVl0SzFBNTAxdVg1?=
 =?utf-8?B?bkJySExnNFBXNjZ0cXh6eU9uaW11bTZ3VUlCV3RzaTZ5RFkvOGhLejFMdFVR?=
 =?utf-8?B?RjlleGZyT3FhS3Q5Z1ltK1lJZVpRUmc5dldlQ1NBMStEZTVpd0xjSFhsa2hS?=
 =?utf-8?B?a0FsRTQ1UkFEKzZQaE0ycUpGKzgzYk91UGYvd2x4eVU0NkdsVDUxUXdkL2or?=
 =?utf-8?B?U3lEc0k3OWtUYjl4aEhaY1hnWVBLQ3RuQk1uU1J6Q0JzYVJSdGthN0JqUTBw?=
 =?utf-8?B?U1lDT1JyOW9xZ2dVeHBGVGkzY2laU0pLZ3EzTDl1Tnc2TDRFak5pK05kZXlq?=
 =?utf-8?B?UHlhSmYva1RWc0NEMFgzR0tTeENwWnZOMXlFWDNWaXZUY3liRitEbERhZnph?=
 =?utf-8?B?ZXkxaDF5eXBwZVl3WDc1UWNTRkFkRnVGN3FNK294K2VIOEtpZjY5OWhHc1dJ?=
 =?utf-8?B?RjVZUEdSYVZaNk1TMW9CaVNaS1BIZTU5SVhBSVlyNm5Fd0xKMkVVRlpjdjVB?=
 =?utf-8?Q?Q122Qiil8naFttVd80?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e26de49-e142-40e5-c9d4-08df05107b19
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:27:25.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /64+MCZHIgQDz2WRi4OvDzo2mMaCEkKouLr8OnJscdTSFG1i5QEI51NrG41FI2ON
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314

> arm_vsmmu_cache_invalidate() issues commands in batch size.
> However, if arm_vsmmu_convert_user_cmd() fails, it will return to the
> user that it processed "cur - cmds" which may be part of a batch not
> issued yet.
> 
> Fix this by calculating the returned entry_num solely based on the
> "last" that tracks the last batch that was successfully issued.
> 
> Also, fix the number of commands for early failing condition.
> 
> Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
> Reported-by: Sashiko <>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Nicolin's series fixes this and the other sashiko note about over
allocation:

https://lore.kernel.org/all/cover.1785258826.git.nicolinc@nvidia.com/

I think it is in good shape, I would rather merge it than hack on this
further.

-- 
Jason
