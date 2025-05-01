Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8E224253
	for <iommu@lists.linux.dev>; Thu,  1 May 2025 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093975; cv=fail; b=NHbIcj3ZfTsCopsWEht0xdl0p7Jq8Gw9PDMAeLyY9Dl095ym3oJlMqywr/iUmuTxZPSUcQ6ApsJKQU7Jb5nCE/QlYsh2PM+CX4OYkb6KjSVX3FBSkschRt3mtnt7pvFLU2cqYwus4ElkMChbPGvF2scXjnYlnAYCarSxpyPeNOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093975; c=relaxed/simple;
	bh=NOg5F7TpWYm8qRa4tpk+m2vkAWda2YfX6WXcSNJhT5s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=clueTd28L9hNz6cqdG4TI5Qld5gjLkHHw7gfb7qHqIMZuQ2NQ/v3rtr783KtPMZwdquMDKvjacXYAqbbSVw8qkWUYo8j0fiEEveRM6A0g51S+XRQgMiXMWa3kf2RxUsq42hjlZH4V/LrPnXoZT8lNfW4gsoRCS+369pUIF+3s+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mkAd+lyE; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mkAd+lyE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrhmE8GsnX5ilgWdMljqcfkeRLnXkglRrU164ZIAnhAoVxDvj8CNZj7dAucZNnYafeudNtJafthgYX/E6d2XcTI9e5TsMRBbAmrvw0rq2xsAbfRdSULUi9pCa0kr2nUUMXSJn5/RJPn3AYEtYAe/ncC8wJ80E2GsoVHqpJt92gSzMRQOyoh7rwiONC7guFqY59turNi3t+x454jDNRctlV1sWFu3yyKOCF9Tb6yZwyGSkACs5WlXYHpkTu10XchVFvPimIOTXFVd2UVVp/Rjl5Vzt301z7I8R4miB+DzHdrSgLsNg9yTlioxfyEyKBIyztYeNjpZZrqzTSQDE9G+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/vIprQnXQCnZB+NlHHoiEufFhjwx5PoO4rzf065oJ0=;
 b=HeF7BBBng1RUkNJ5IsIns2gORX+j2L2dlul/5RxObQVgh2T7QFmWU2AvARySBV2xIbSeskEydUeF++FZVVnJ02qDPuxZLdsmIs+iRMVIMsfeEIRVCB/C4qcR3nyI22c5maK5yNedE8Yk7gMabtdIkZoT1kAJWdBpu1Z+wLxVLsntvwSs/ZjEadAAzXM/+Ka4SvHtTHFH3ZZ7xqaX2QlVh1tR2eXmtYtzPRprKFlrixW23cKXG0mKmGN0QWbaOcORN5kyrW5b6q7CJ62PKunAEB3wc2tGJC8/jHe7rdB+8/4BkJ58sK8flS64dbG2mQc6w7EMgC4djYtbw2fXCcc55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/vIprQnXQCnZB+NlHHoiEufFhjwx5PoO4rzf065oJ0=;
 b=mkAd+lyEyUlqSt8rhURHCsjnzzyiCgEQ3GaW2eOyWSWejbvAQRmyxE40KVqxfkZiQfNzke270EjfkSyTRpUgNKILwn00mh/ZrhQ7uMc2SsjdInzvf7xepKCqw7zd12BHv+gtaQqkFRlWvRYy2u1uq4WUPJvmrJkqkZ/tnWbQJsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Thu, 1 May
 2025 10:06:10 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Thu, 1 May 2025
 10:06:10 +0000
Message-ID: <a7d4929b-f7ff-4ce5-800e-79df3816d9d6@amd.com>
Date: Thu, 1 May 2025 15:36:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] iommu/amd: Add debugfs support to dump IRT Table
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
 <20250407173500.1827-8-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250407173500.1827-8-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: a0423de4-233d-49ae-817f-08dd8897cbbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0pwVFBhL3lIZUkyckFUdG8rd3VFV3U2cmszQ0lSWGpXaW8yN2UyRE12Sk5M?=
 =?utf-8?B?SGJPb1JMejZITThVdSsvK3BjQTV5ZThCcVRjUVc3N2tJOUFPeXlEK2Y0b3NC?=
 =?utf-8?B?T1ZRUzFRbStqY21qMzNnTzE5d2lWY0JNMmdSbDJUaEhSeGpobkUrVGI5eTdo?=
 =?utf-8?B?R1J2M012NnpRN1ZBOTJYSzVzeGl2aWhleHBWdjdiaVR6Q1dsNHlEbVpoYmFR?=
 =?utf-8?B?T3l4WkpBOWVKU0FFcjJhMU5DZktmNWQ4UWxqKzBpODMvckVUQytxRlhYeXJY?=
 =?utf-8?B?Vk0zNHJGWWtFbG55RlFYLzlWSklWZnRKZnVPRklVMmNqNTlQVlpjZlIreS9B?=
 =?utf-8?B?VU5UMm5PbmJzTndJQnVEZHl1N1FsZjcxQ1AvaHloQXNFU0xERHpVOUJ4K0Zw?=
 =?utf-8?B?SGlmblBPcFBrZkcvQklia1A4ejdsSzlreFU3Q3RGSldETkJmdGZ3YU9LUlJZ?=
 =?utf-8?B?N2praXplRTU4NjdGUTF5OTBYMUwvem1YcWVYMlF3Y2xWa0orZ2NLSVN4dG8z?=
 =?utf-8?B?WEg5dk5HRTFscHZGeEExQktLR25hK3BLeEJBTnJmcER2RnNOYS9tUGdpTFBZ?=
 =?utf-8?B?ODlJM3owYkNCNnRNTkZDRE5zdUFWVWZiOGNpRW13SVRzT1A4OW1Qb0NQcGVj?=
 =?utf-8?B?d2VrTGFtcW95SmtDdC9mVXZtekxHdTk0UHVEL0pOZlh2ckVHU0F3eGR5OUVy?=
 =?utf-8?B?ckxGVHZHQmpsWnY4VDRVZDU3ZlhrMEVDMVBKTC9aTGYwUis2ZTNrN2xOTVFV?=
 =?utf-8?B?V3ExZXBJdGdzaDlXMUU3ZkJORlVXMmxGTFBFa1dqQkZuMjMvYkIxUFB5bWdj?=
 =?utf-8?B?R3FtdzltQlJxWnBhVDUvZVRkcGMvcHdSN0lxTWRwWmd1cGhQZFpSTS9SODM4?=
 =?utf-8?B?NXhoZldtcDdBMDZUNXVuUmpROWtCU3MrSkZVbWgwMHZqQkpaYVIwUjJPMmFR?=
 =?utf-8?B?dWVaUS90SCswMzFQaUdlOWhwLzJ4ZnU4VEI5cWc1clNNZThKUlIvRXhSUGMw?=
 =?utf-8?B?MnhPRXE3NU84SHlYSEs5OThnSUJ2MVNDTkh6Qm9LV2Z0S3BiaFk4ekd5RTc3?=
 =?utf-8?B?K2hWVFNONXdUNDhidk9uWUlRTzBMOHp1aFNweUFVS0I1aE4vSEtwUUJiOTBs?=
 =?utf-8?B?UjhydzJNRmZFaDB6R1FUUUtEMURtdkcxOHpmUmM0dE1CWVM4QStTV3VQVlND?=
 =?utf-8?B?bUdoRmtPQ3ZqVTU0QVlSUnBHU1pHbklkN0IveStBWjU5bWtiREltOHVZOVdI?=
 =?utf-8?B?RExNeENQQjlWV3h2YXMvNmVPaG00SXd2MldLY1hFSjJEVWdMNlZBTUFLdDJS?=
 =?utf-8?B?NVU0N3NLSkg5T1kxdHJCVUZYNzU0SHRYeWpjc0lUbDZCUzN5NXhRUHVZQmc1?=
 =?utf-8?B?czV1MURJZm9rRnkrb0xjaWY5Wk8yUGdIR3FhV1NYYnpVOGNmKzFKdks3NFhs?=
 =?utf-8?B?VXpObklRejNLcElQbUxmaWJobG1na2RzR3EvQnZZTUdNcmRnUEg2VWdhMXJV?=
 =?utf-8?B?ZUt0ZndGMzBOUSt6aHRCYXFuNnVGdkprRXpMVlcwT1p5NUZ4SkxtaDR3YXhU?=
 =?utf-8?B?OVpGdnVjQ0hFdnRqbXd0bitHdUNHY1Z5ZVdoNGI3cU5PR3hzWE5SdEZmRDZX?=
 =?utf-8?B?ZzdZT21qdHFYVjRvcGpKMVY4YTViSXFVQUdOK3liRzBWUEZOYWdCeHZDekFr?=
 =?utf-8?B?NmF0Q3FRRmF3UVN1Uis3THFIYmJpL2NwM0JxVDJqUkJTalowdjNKY3lVc3RS?=
 =?utf-8?B?SVFvSUw4YXBMRVFZemI1U3RORVQzVjJKWmJIRE5XdXEyZTlDYXpjRnhVdkpr?=
 =?utf-8?B?d0hQKytUQWtZNnpTTytPU2c3N2piaXJOeTJ0VzEwZ25wbDJLc1NjZUFWV2th?=
 =?utf-8?B?eVFTUHBmdksxSTBtRzRoYmxoelVSbGlxM1RCc004SGhoRmRVTGE3SjBpaEg5?=
 =?utf-8?Q?O58/1V9Egpk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFRMUmJHNXVuYytYWldsTFlXZVZnODVabnByRGlPdzEvOE43UlNuZm5rZnNI?=
 =?utf-8?B?ZC9ETEVjN3hRK3l1RTk3Z0NvL2M3S1lYMTdmM21PNnMzRi92aVdVZzNjK08z?=
 =?utf-8?B?dEEyZGhJNEQ4cjVmV0txTzE0OEp3TXZaemc2aVZrYktmSDRnMUVrWnBYM2F6?=
 =?utf-8?B?N3hEaWRLOW9BdGRFOFI5aEJkeGVETXVuU2RONUlDd0JIdXFJZGtaMXRzU1N4?=
 =?utf-8?B?aWFlSi9jeHpSZVRJMWxQc3JhZXcvazNZYWg4Z3o0d1haYy9pNXRndkhhQkZk?=
 =?utf-8?B?bzBWM0FsZlMrUlJvZU9QV1AvUE1SUEtjZlpzKytEQU9KUks1UTBiZGRyN1dL?=
 =?utf-8?B?ZzBlWERlOVo1QlRJbzJWUGdrQ0RWSWhGV0t2RTJidExQa1VLbmFEOUNnQnFx?=
 =?utf-8?B?OFVkRjdBamZDb1ZQdXRsSTlKdDBTK3gyRnpNekg1Ym5mUzlPTkV3TUdGZXZT?=
 =?utf-8?B?aENoc2NkMmtCczczYTY1bFRWQ1kxUG55aGhVVkV4N2xjMmJtWE1yWFFCRW5J?=
 =?utf-8?B?UGE5dFNqYzkyeE1oeTBzb3FkTExRMFJSbGdRSllYNE5HTGoxZmpuQ2pPc2Ry?=
 =?utf-8?B?dThoK3JCTlArdkZoTFV3RkF2V0ppWFhPRmJoa1BRVnMvUVZCY1Ixc054SEdR?=
 =?utf-8?B?bnRDYXJaYTVmSXVhanhvYVI0ZUlYRCswai9CTVpOZ3dZM3hUb0xNN1JJcmRT?=
 =?utf-8?B?MHhXQ2tCbStoeDZpc0NkSmpwSUFOMllod0w3VUdxREpoUjU4STMxdWw3MkJL?=
 =?utf-8?B?MURqRzg4QWxsMGo1dE9XZUR4Wm9FcmpwUDduVUZlWkhrZGw0STdsRjByRUxw?=
 =?utf-8?B?L05saHp5dzE3R3g5RG5WaGRoTUtPRFlzbmZMLzRnN3pRWG9iQ0t0US9IVG9M?=
 =?utf-8?B?bzVQZHowYjhJKzFFM0tkVHB6K1Jwc1pndUJlYU4yd09ldCtPMDVhYWdvQU4w?=
 =?utf-8?B?TzhYNDM5WWljYVVrSCtWaGdpQVBwazVJZU5rNGpYMDU2ZWxEVHYvQmVueEZB?=
 =?utf-8?B?M1o0ZjE1VEpqSXY0cEE0eEVJZDBLeUIvK05Sc1dZQjQrV1pncG9UQ3dDNEVP?=
 =?utf-8?B?elNIQ2JBeXl5cVU3dGV5WFZEbDlVbWxaeitFTTVHRUhISDE2R1d4QXhDbXFF?=
 =?utf-8?B?cVA5Q1BhYjdjN3VLNjNHNEVVVzA0N3dYM040bEl3KzVaZnprWVBpbDlHdUJV?=
 =?utf-8?B?V3UwV0xGRkgrbVRCa0ZmZTVscU5iOUxUbFAyNnVoUGhXTHNIaTBJeUJGS2xt?=
 =?utf-8?B?UVc3SFNWMVU0YnE4NWVabmF5ZGRNUTlta0N4b3o2WFlaNm9SbXdzWXVUeWhl?=
 =?utf-8?B?TWNLVG0vVnY3OVI1S1BhMmtVTkVRMzJucHhzVVAyaDhaKzI3TUJQMEY1VEwv?=
 =?utf-8?B?SmpVM2tWS0Vwdkd5RWxxSkljekRKaGZXQlRDVVV5OEJaYkdJSmFlaGZHK21E?=
 =?utf-8?B?S1A2UUY5RE11dkw2UDNLM3ZwdjBiK0pLRDJhVlk1VWh0QkpnQy8yNytQeVJx?=
 =?utf-8?B?VWczZkYvdVZ3NHg1dnhuRlFNU0ZGWUlmRDhLREM3bUQzNGVrL3dWR29QZVc3?=
 =?utf-8?B?YVJONytCY1JiUVhqZlV3SnNtRHpmZFN3SUhqVDN2bjJtMHVCdWJUTXBEUmxl?=
 =?utf-8?B?M2JKcEhNclhUaGNWdG5hZmQwZ0dWaEpxMGdOQzd1eUJmMG5YTFNBL1RONnIz?=
 =?utf-8?B?VlJDL01aM055cjhiVWc5NkpXTXAwdzIyeHpGSGJub2ljdGM2YzZNMkVqN1Jp?=
 =?utf-8?B?SytyR0NZbGh4MjZBUm92UUtCR1V0RkZFQVdwUU5KOHg3eUFpM1VyQmZURW53?=
 =?utf-8?B?VjhoTlRVTVNIaTlERmRKWEFaQjN3VHk5U2pBT3lLRy9KSENVL3VtRGE1SmIw?=
 =?utf-8?B?TWhac2ptWXlXMStIOWFpS2RQd2FVaTVtUyt2dlM2RHE5dVRmbDgxT1V0VDAr?=
 =?utf-8?B?VmFuOTArS2lLT0JFeElaYjh5bHNPUzNJdnptVE9FTGh6dmdtby8zVDhhZWs5?=
 =?utf-8?B?Q0QwT0dPQVhhb0xGY2N0b3VpZzlGZ3lZaExZZytCQzRSbzZ5WitWcDVKckhk?=
 =?utf-8?B?YmkxY2hsL1hmcTJiM3dRdSt5Z2ZaUi82VzBtVnA5VGlxQzRncGlhT1dGODdi?=
 =?utf-8?Q?YsFa9pDwzMKn0sRh8hj1fGfgE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0423de4-233d-49ae-817f-08dd8897cbbf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 10:06:10.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7d3xHgmg4J5dZBxTZJU++lFQsyvWu6nu+bPX6M+rV5ws0XzVuZiUJOh26j8ixBDl6nUYa8yTtHZwbjDObI+QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439



On 4/7/2025 11:04 PM, Dheeraj Kumar Srivastava wrote:
> In cases where we have an issue in the device interrupt path with IOMMU
> interrupt remapping enabled, dumping valid IRT table entries for the device
> is very useful and good input for debugging the issue.
> 
> eg.
> -> To dump irte entries for a particular device
>    #echo "c4:00.0" > /sys/kernel/debug/iommu/amd/devid
>    #cat /sys/kernel/debug/iommu/amd/irqtbl | less
> 
>    or
> 
>    #echo "0000:c4:00.0" > /sys/kernel/debug/iommu/amd/devid
>    #cat /sys/kernel/debug/iommu/amd/irqtbl | less
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/debugfs.c | 106 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index c6ff47561afb..28fe546e0bc0 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -11,6 +11,7 @@
>  #include <linux/pci.h>
>  
>  #include "amd_iommu.h"
> +#include "../irq_remapping.h"
>  
>  static struct dentry *amd_iommu_debugfs;
>  
> @@ -254,6 +255,109 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(iommu_devtbl);
>  
> +static void dump_128_irte(struct seq_file *m, struct irq_remap_table *table, u16 int_tab_len)
> +{
> +	struct irte_ga *ptr, *irte;
> +	int index;
> +
> +	for (index = 0; index < int_tab_len; index++) {
> +		ptr = (struct irte_ga *)table->table;
> +		irte = &ptr[index];
> +
> +		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> +		    !irte->lo.fields_vapic.valid)
> +			continue;
> +		else if (!irte->lo.fields_remap.valid)
> +			continue;
> +		seq_printf(m, "IRT[%04d] %016llx %016llx\n", index, irte->hi.val, irte->lo.val);
> +	}
> +}
> +
> +static void dump_32_irte(struct seq_file *m, struct irq_remap_table *table, u16 int_tab_len)
> +{
> +	union irte *ptr, *irte;
> +	int index;
> +
> +	for (index = 0; index < int_tab_len; index++) {
> +		ptr = (union irte *)table->table;
> +		irte = &ptr[index];
> +
> +		if (!irte->fields.valid)
> +			continue;
> +		seq_printf(m, "IRT[%04d] %08x\n", index, irte->val);
> +	}
> +}
> +
> +static void dump_irte(struct seq_file *m, u16 devid, struct amd_iommu_pci_seg *pci_seg)
> +{
> +	struct dev_table_entry *dev_table;
> +	struct irq_remap_table *table;
> +	struct amd_iommu *iommu;
> +	unsigned long flags;
> +	u16 int_tab_len;
> +
> +	table = pci_seg->irq_lookup_table[devid];
> +	if (!table) {
> +		seq_printf(m, "IRQ lookup table not set for %04x:%02x:%02x:%x\n",
> +			   pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid));
> +		return;
> +	}
> +
> +	iommu = pci_seg->rlookup_table[devid];
> +	if (!iommu)
> +		return;
> +
> +	dev_table = get_dev_table(iommu);
> +	if (!dev_table) {
> +		seq_puts(m, "Device table not found");
> +		return;
> +	}
> +
> +	int_tab_len = 1 << ((dev_table[devid].data[2] >> 1) & 0xfULL);

This is hard to read. Please use the macros like FIELD_GET

> +	if (int_tab_len > 2048)

s/2048/MAX_IRQS_PER_TABLE_2K/


-Vasant


