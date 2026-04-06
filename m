Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D930DED1
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775464371; cv=fail; b=BufsiftmLU3uSY/0MNwvZo9Bm252uizhoLGKc9zHpNDHuyr5/T/wS15RtQiJ1AR6ePILEnUxS3+G5SwnwDfkCTD6KC4jBkYoq6ESKtl9LJgIQpxigBvEzxpmYtAkZK4j40m1HAwVLa5xu9LGabGlgtGuT9kxztE5LZ9agIa1g8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775464371; c=relaxed/simple;
	bh=rjd259YG/MXfR+ieUv4bGVc1BDPbV3pLwgRwReuK4bY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kftj/nemjpDUCGn8cyYl/csLL+6b1solZJEnHh9f9Y3Oe3BNVuEg5rY5On4R7Ke5rHB51AkXrTuHj/J8bJBC2WEtTvl1sCD29TWcVswoqMFiAt/J8JFMMGt8oOu7kKF0Ktec59MMDOWUl75lVmbri2FMR6/C6XQgcKBosiuQPK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lA3iF9p/; arc=fail smtp.client-ip=40.93.194.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lA3iF9p/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP31i/1m4Gg+HvMdNL/geeEg6cHFNgD+0aVgaZo5P0nPpd+vd97zyqwkdWDbd29px4ySIl40yUya7iLn47M9FfHbxRAnPLM7l5EXqYkp9sKP0mU74+ylwKGRGCXRbutbLy0HJRTOuWegueTsY+OTKMB8El1bXz1E/HHqAm7rGDd02dgPdVAwgWPFCJFS1faB/eTtc09qBgXmb/vK21YB+ulzmkvAHNxygsZIOOgCpb2XXZ06/flyiEESCeAmlSvxzlxYGWQyD72/WZDh1HOWLtn52cePX969q0Bo0AqHek9QCOuUPmg50LWy+ZfHvPusC4ZdqxUjtBNX4DnoZVDl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF8ppoTpd9hAyDB5ROZJhJOsDlJ+6J6Yi2cT5UFYwRQ=;
 b=SsuuCfoBgNmp83lcdGSErR4P/Bu13uSQD5nMhWQ2vUelsbZZTvPN5jAT2J7HoBFS9gfcRgPMxS/qWS11JuRYcG6X8wiZBJr1dEWc0yw9jofYeuGFjKpmJ3QK3lNcJCFLhn9nncyq6hPfiKabc1XvExqt9hP6+gTG4mmAtCjeeaRELpKSx36No0mtNUy3kOetw1S/J/k6gAwW5s2gu8/vSM032mhYnuSC3GbrOgnqTv1d20cpVN8LmdGqOwSxkiXQcIlbGpgKs9/3aPiBN3PH5eZE3gO5AO96REw0zGnQanVp4emPy7JcQw+QE4M+qBQsN8tBVtOMvBc5hTOunY95Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF8ppoTpd9hAyDB5ROZJhJOsDlJ+6J6Yi2cT5UFYwRQ=;
 b=lA3iF9p/nHWW7rsvfPf1V8rg88pVOFBYErCgJOchiOfFrWrqi1mNoCdR0OjTrmR8yCHNQSD6SxKst1mgLHaq4o0T9Jt9w1tbImeCuyUFDmqvtno7hqNvRmcfNDjedv0WKmuduzLHLK5yeVYyA1lm7cXU7DweZJtpm06vF6bMNoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS2PR12MB9824.namprd12.prod.outlook.com (2603:10b6:8:2be::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Mon, 6 Apr 2026 08:32:47 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 08:32:47 +0000
Message-ID: <27f2cf65-c350-492d-b707-fba3eeb697d1@amd.com>
Date: Mon, 6 Apr 2026 15:32:36 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: iommu/amd: Initialize IOMMU Private Address (IPA) space mapping
 region
To: Weinan Liu <wnliu@google.com>
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev,
 jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org,
 kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
 nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, wvw@google.com, yi.l.liu@intel.com
References: <20260330084206.9251-4-suravee.suthikulpanit@amd.com>
 <20260331051224.3993081-1-wnliu@google.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260331051224.3993081-1-wnliu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS2PR12MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: 84504439-13c5-456a-294b-08de93b71452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yipvFscFrWwstd5m7eSElFIY24xtMsn8W+Mi68i+BVJE+XilO3gQOhygvsIdxzIO0OeFKwevCT0fBGgkQbK/ovt37Y3sBRcJn4RHj4ghiQJnfZ1W1392Ne22nK2LmJRLbfWmHDR+dcTs9nPIGY5zp6J/SvfmrWJsP70JcLQn1PnnVmiyICgmme0cw8/XefTvL79BFtVvBAPJl2P4GQcJ0ejxXckvgN/NQz65Q63WWfYlgI2elwBMokAognZrSzkJC2LK4hu/2XZT5X+fBtGiArn3lxESS6y9J2kfS+br9Q6FJp/6eCKN/9BahKbVQhWhCwLZJO/5bS79qNVX2ufkmknPvV/bCgDxMzaYp30uartmozH2+4b2ZZVjfKAn6BbDMelrXe4NB0HOneYCQfR35Gd6wiFrFrxOGiOb7s8BbqsNpfSIak0lMpLSvQY0okWtf2aUR9l9Sxn3w3nQUBrp3YvrnwHd2dLfVNqF9jreF3PSPDR/I3haah6tYvwazH9dazNSu6QFd10EKNYSXgQThzh9td7KCNn9aib6iA3VRB9oQO+zLPoI6zXXpotnxySTvJ+1FodpuMvsPyzOlLD+/6LyL6RU3psPZuZPYBrOvFG7aoG0vTbARNenklQwMhKnGHJp5boE0hr1QjWMJkXL9KFW5zYqDWrg0h1bjTur25SUBb5cP4BBjp4lSWA19tbBecWbuaLhBfaT0BT6/XeWnGmcIdhD3Jrb+qLh/x1ZbYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STQvRFB1eDBwZ1dFMytaM1lHdE5MUTcvZDM1MC9ranBNMlp4Nk1DckJodlVY?=
 =?utf-8?B?SjhnR1lEV3JUa2pWTkRzQXhydU15dENJNWN2c3N2Y1I3a2hvcnAvWlV3d1Fk?=
 =?utf-8?B?bTlMUEhNbC8yTFdkV2szRmgySGIzYmsyWXJ0bXJnZEtRWlZNZ2J5S3NnQ1E5?=
 =?utf-8?B?YkEyRThpSEMzOHowU1lRQ2pDWlI5Wk5jTStHMldsZTc2bkhvSStOWWlubG5z?=
 =?utf-8?B?ZVNOTnIxenBzSE9BRXZpRndhSHFweEg1MmpyMVZsbVVKTFZYd1Jld2R4U2dw?=
 =?utf-8?B?aFB5M1pYNjJPZHBrNGN5cjd4RzYyYjg3UlI3aGdGdHoxejFZdlhBTWJmSVpM?=
 =?utf-8?B?TkhJNUNETkFwdGZKMko1T3Fxa0p6R1QrOXo4V0dVMjRlbFo3dzFncFJQUjhl?=
 =?utf-8?B?cHlrVDNjK3VHU25WZ1RMeUNJb1lJOFdRWWtkdmg3RnpkNzUxczdQaG1wSkpM?=
 =?utf-8?B?MGJxR2NZN1p4UnFIVHBudVFtYTd3KzhzajlBaTIxYzNrL1VyNks2aEdCMFBQ?=
 =?utf-8?B?MFdFUmIwVDF3ZWl0VFAxK2U1c2xFSzNEYlp3ejArV0tyWHN6akUrSkNhSDh3?=
 =?utf-8?B?aTA0dENkS2h4RHRPVkZzcWhnMGVVWG05RDZ3ZW5BSllHeG5WckVOTmxWaDZF?=
 =?utf-8?B?T3NOS3Vsb1hacVpFcTBNclVYUi8zVGN1NmFuYllreHZHbC9aUzRMRUNuWE8w?=
 =?utf-8?B?REdPK0Z5VUlYaGhyUU5KMjJPMmh2c2Fld3BtRUFTL2VxcXZZUks1YmxHcEJn?=
 =?utf-8?B?a1VrVEswd3BPUmUxVkJSaGNoVFc2SkR3ZWg5OUhBaVV1UU95alJ0OXRBT2lj?=
 =?utf-8?B?czIxdWhRSkRETG55YWpaclRsUndGUG8vY2VPcjRLZFd2L3l3K0JJd1ZmbjJJ?=
 =?utf-8?B?THc4aC96VjVsNmM1eDFCbDRVZGRYYXYxelNpdWpibjlNa1dCWWxUM2Z0ZTk0?=
 =?utf-8?B?WmlXdUxpMUhaUXhZZUJnOUw1Sm81YWxrZldhUGNZVXRSQ1FmaXZsUlhWMzgr?=
 =?utf-8?B?TDJkeFNMMmlHK0lhb0tENDZQZXc0UFRlT1ZPTENhbUt0UUJqWTM1TXNDbk5J?=
 =?utf-8?B?bEtzQ0VHUVIwaUhIcVlBdGlxaDdXYjQxMHNEY3A4NXBuNHAyaWR6dTBvRTRU?=
 =?utf-8?B?Ujh0STJ5WWtud2FGTkxZMlpDZFhuOWhienl1MCtha3N6RkJHZnh1NDZOcW5k?=
 =?utf-8?B?YnA1M3E2WkhRZXVNclAxQlBHMFZ1WHg1VVRGMm5ZN0lyb2ZOaDE1ZlZOZXp6?=
 =?utf-8?B?ak1zeElOVGhsSUpOa1R4THI3S09VMG5PN2Y3Mk0rcmIyWTRBSGtqRElpUDgw?=
 =?utf-8?B?clhDYldMcHpKU05NTVJpODR4VmQ3dnpFaUdNc1BZenl3Rmw1alRVVWNjNitr?=
 =?utf-8?B?YXNFcDd4WXhIeTJjaERnK0pvQVhqZjZ0elBLb0puRlJaOHFYdjN2ZUlEZE0z?=
 =?utf-8?B?VkJmQUVFdnN3VHNxdEJObXMyVXdKNk9wd1N3Zmh3M0ZvTloxdTJPekZrd2c3?=
 =?utf-8?B?ZUlBR3h2bzdoOWhDVnpzNHduaGZUb2RoaWp2WXlxZFRyVHdLUExFYml6VE9Y?=
 =?utf-8?B?bHhFMkdiM3gyeXRJWk9VOWdGUTVGQlgwcVVOZDdWQmNUdnpVMzBLS1RKK3RZ?=
 =?utf-8?B?ZWRwYnh5KzVUYmxEWHc4Q2FXL2xJZFdwUis0T05qTWtwQjhqa2xmMlRNb0Fr?=
 =?utf-8?B?TTVsVS9FWkxEWFlTVHhSbG5Fa1hpNkhqbnh6Q1dQTG9TWWVEeFZFNTd2d0Jv?=
 =?utf-8?B?L1kwS3pJRzZGYXFIMkxrc0lyYlhtQ1NpQi84YU1xVjJpY0txQ0Y4OUk0TlVD?=
 =?utf-8?B?aWFxd1V3WmdFajNEdm9DSENKUTBTN2lxVzRXSlRrNlJpM3Q2RXVpcmNmY0dl?=
 =?utf-8?B?dUVYdEd6YWJNNkxKMCtiOXF4L0c3dzZFYWRTc2pibmd0QWdvWGw1QXNSY3o3?=
 =?utf-8?B?TExhaG1WUEJta2hwZWE5TmZaM2toTUpOYWhGRTZ1dktrcTQ1WjVNT1BjdzRT?=
 =?utf-8?B?UjdjNStPdlFZVUR1cFlOMmRsOEpaeHd5TXJqVlJsVWxtRGNJMC9pcG9zUjBG?=
 =?utf-8?B?Vi9iWjZDQ3dTd3o0aGVnb2d1U0JIR3pwdnE3UXJrSEtDb3VWU0NYdTFpVmVO?=
 =?utf-8?B?amcxWWFmWllhaGo4N005dzIxQUdkL3ZvcTRKcmpQZVlCK3RtaHVSY252WTF1?=
 =?utf-8?B?RDdPNnhzOXo0Rm83WGd5RHRrNTJNNy9wZUYzZ0F2SEJqcDlsYUVXUEh5azll?=
 =?utf-8?B?YnljNGNZamhBNHo0dU9zcFR2dWdTN0txRjJGSlMzWklkaHJpQU91R09hU1hU?=
 =?utf-8?B?bVg3Ui9KcFdiY0lSVU05RWhTWFBZME5wN2hYTmY3TXIvMXoyNEZ2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84504439-13c5-456a-294b-08de93b71452
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 08:32:47.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Po9iFGgjbfdQzKmoQ+wWHeAVX5uFZ5fyAUpUC3LvQ1iVlN7c1X7G1j6ugxDWgukOis1KhHQoSo7230iU2cTQSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9824



On 3/31/2026 12:12 PM, Weinan Liu wrote:
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> @@ -2198,6 +2202,10 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>>   	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
>>   		return -ENOMEM;
>>   
>> +	ret = amd_viommu_init(iommu);
>> +	if (ret)
>> +		pr_err("Failed to initialize vIOMMU.\n");
> 
> Should amd_iommu_viommu be set to false if vIOMMU initialization fails?
> Currently, the following logic will indicate that vIOMMU is enabled even if the
> initialization process does not succeed:
> 
>   	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
>   		pr_info("Using strict mode due to virtualization\n");
>   		iommu_set_dma_strict();
> @@ -2291,6 +2299,9 @@ static void print_iommu_info(void)
>   		if (check_feature2(FEATURE_SEVSNPIO_SUP))
>   			pr_cont(" SEV-TIO");
>   
> +		if (check_feature(FEATURE_VIOMMU))
> +			pr_cont(" vIOMMU");
> +
>   		pr_cont("\n");
>   	}
>   
> @@ -2303,6 +2314,8 @@ static void print_iommu_info(void)
>   		pr_info("V2 page table enabled (Paging mode : %d level)\n",
>   			amd_iommu_gpt_level);
>   	}
> +	if (amd_iommu_viommu)
> +		pr_info("AMD-Vi: vIOMMU enabled\n");
>   }

Good point. I'll fix this in V2.

Thanks,
Suravee
