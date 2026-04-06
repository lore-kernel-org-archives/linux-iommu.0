Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467BE40DFD2
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775465878; cv=fail; b=awiqA/Gs4rxS8gdFDPZ+lP7rdH26qnY0JwyOTwdEmqvSvxOjHKee7jQaV+AdM220KW/MbJTlXq32QV1Jor+SOOOfSm70zcDr/3iVP6gj8mzH1PTRyXH3tDVS8PwIsJR1WVUpYWmsZ9BVpH60053Yu/im3lXE60/aLBoYp7EpLlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775465878; c=relaxed/simple;
	bh=ltPMBr9hj84wz6JK194uLc5mZTp03gbWRuDDWrciMb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QVf6BljtwJZz85aeAh0bk0PsR0q6gSKLb3Ka7wdIi1VfVKP0cyvFa0YpinCok9MLOT8dA5/am32bFIeXBS6tJhiJdQ8Aoa8LclOqmd/GEgSM9CDfldq8nGNC60rpcOvPYC1YWpgNS2yBKUMX3Yrd+ivaJmfCYAllP5pYJDYyE04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c8qNJG7Z; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c8qNJG7Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaiS3G1om7kJ6kWgPf3/zTv/bz6QSlAHcjf9jOkupYYapN3Vo39lDkIu/y8bW9NIA63aumAe5vuYrskVXNA+Ry8PfG4EXcAq/zKyCJFcT0lk+JkdC09Y89ZgqutV/zM77JwqynLk2PYHixd6WP053EDnOgvXIRve516N93toxISQSEWwEfOkBE67/qAjWWasElPmMQ9Ns/mjxudtIl7IqZimxEBM/hp6YgmwtgXrReDUs4nHZj/DnJ1eGI+cSUzsRAYGEwM2mbC+ZtEYqU4qT05aQ6n9eJrInFmv8x1M2n73ghLScWIb4gA9dflNrdyohQMdscXlsg1MUQ/imGhGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKeWg2nO/JOh6SbZJ3uwWtwRkAOaGg0eUwWV6nFuUGE=;
 b=SqOhMQqJberqbOo8V5IerPf+rbCMczmnzR2i2epcjn3S2xQuJVD3MXEgIw/jrfKrKDOntlReDIlfUxLKPPbvJVdseAWIljq8bKQq0r1yYbGqxXM0rInCjOI3jOD3ppk6+0UjUUQWWKHSXwltk282iYqO+o5gxqKTBIheqN01uz9t2zjd4lBrVI0ZIoLDArH3br7NMH/CvyqAe5nzEH0oap5CmpwI8c1yV1LEVfGDpVwkWxBh0QJhr7OLvnP0u/JzzHvguVcp4ZhWIdz4lxJF5QEVuL4b5x1cdqkegsBiiclL096sax7Z67z9B9tEIfoHmxYlxYIk92/gZDNtdg5Z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKeWg2nO/JOh6SbZJ3uwWtwRkAOaGg0eUwWV6nFuUGE=;
 b=c8qNJG7ZIN2pP5NqMzBoiOyYdS/ThBuC737UD1d6o7E0xiOTUQUh91NlU5xKiVJD6JNI9n3whBk+XofCPEAZ3I8CYW1Sr7IULgydQsBi77tihjXt9z4Lw5iBOwAJeTlRUakexaN0gNG31WJbZQKxxkx5EKnp/Znh52Z9I68rNFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.18; Mon, 6 Apr 2026 08:57:54 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 08:57:54 +0000
Message-ID: <3d5a32f3-2298-46ea-8632-0351745f1c7e@amd.com>
Date: Mon, 6 Apr 2026 15:57:45 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] iommu/amd: Map vIOMMU VF MMIO and VF Control MMIO
 regions
To: Weinan Liu <wnliu@google.com>
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev,
 jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org,
 kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
 nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, wvw@google.com, yi.l.liu@intel.com
References: <20260330084206.9251-7-suravee.suthikulpanit@amd.com>
 <20260331053024.4008333-1-wnliu@google.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260331053024.4008333-1-wnliu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddd6855-1ae0-401e-ecde-08de93ba9736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mFTdjWGiVG+AkKIE/6uhT1cskPT+JvjFwmtkd35hFWNX8Oj4UbjnEKW1Od4XOX0V47HMezA3CksLO22atUGOecvZTyfgFgtLYa36JB5FxUxBIwS39NW/24nY7s/Ij8Rxjy29zgo6X6v5FcsXt0hzVf9/QvxP6TW+RNBsTXCvbQAh4BQxeFjzSfTbnMvdGXIPhvVAxkMutATnC1AA/3F5NoUAsb00Ll8HyjeukdA+oPzFpK+LjyOqmqHp4A2w8KcpqPzae7NlEsYHcUlTBN28yg29KYsY3z8iVGawqjLhX/lvRaCVM7GBjgPhXV81EsDu6xEPzTpsL9WHNY6usjQ4/1x26DmU+qpkeEJ3YCsAjyLLZdjW8v+rZbwbX9NPbb7/SMoaxPPt1UKNFiNCnVuFioIkbfFs0QBgNFGIZHmkO7Epqe35bGUT1fbm/lUoi5VsqIPFl8b+iWZtj1GraZSOYy4RBMS76ehRUBZHzqxpb7Um8wgt9uw1XLxnIV/68OogXcpgCypAYdX331Mzrqb83dJAG6ywuuMgsKGr9ZHfcaQKAyBTIrIdgi9kk20OmTZj38TrboKet8dVAsAX4LmkHaWaQR2T0hc0fe4xsxE2cZKrS5z3Z3YjpyHz156oBnXnU1oJXcJTATbSnFZQtoAnWeFm5SECqzyb6PD54Yr3cCqvPm0FacgrnHLg6j78Sxw8/DNS7rAalyD+Waieu5C3PYA3j1RfkBG/OMAbqLl1HHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnlMb1psVmx0Mkxkb0hZMGRUMHZsam1PZlFLcWtDZVZnK2dXbVJqZmVueHZ3?=
 =?utf-8?B?d2NLYTRiLzdFd3VqeEwrV3JkcWw4SnM5dTBFOTRURWdhTXdQK2xLM2ZrK2NW?=
 =?utf-8?B?VlVjMW5QSTZkSmJ2QVUySEpqTTJMM1dFTENqWThQUy9oeXJSNlplZ0RXZmdG?=
 =?utf-8?B?UjhwMVVUSTBLMkQrOFlkTkV2RSt2ZXlkNE1zY0x3TEJYN2ZGV2VWSEpXS2ZV?=
 =?utf-8?B?UWZGL1BGY1VqWkNCL3JRdVZuM2tydThTTkFleklXMDNya2xsRzJEdlg4MlMx?=
 =?utf-8?B?TmVSV3VjZWZSc21PK0h3cnU5U1dHcjhCblRYYVk3ZkkrSVNnZmxUeWIwTkxo?=
 =?utf-8?B?TjdjcDFCVnRyTTQ1V1JzK3FLalBVa1hxaFZqdlhnWHd5LzIvaDN5bjYyeFh0?=
 =?utf-8?B?TXRUbHp5NlVYSVJBRkZ5a2tlRkQ1Zi80UGlJZ1hYcmZPOG82QUF1MXl3YzMw?=
 =?utf-8?B?d01WMUtaQjh0d3lTWDcrMVlBdWFrT3dpMktGYStTYTY0anNZcWxQb3ZSOXRG?=
 =?utf-8?B?L1RxTDJLUitrQmRMSlMvN1ZvV3drUU5ONzIwU0hzQThBN1pQaUFDNGdIZHhi?=
 =?utf-8?B?VC9hSU9nZ2M3T09wWGtmSklLWlNjRWZrSFowWkJvTWxKZFNPU3BYTVdoSFRZ?=
 =?utf-8?B?bjdNTE13UTNCOGtxUG55akNjT1VJNTZUYUNOYU9PdEJITTF4bkNqakczdUli?=
 =?utf-8?B?RDE1QW53b3hBL1IxUnFCdDVWTGpvbDNkbDFkYWRienRzZFpZelBJMDB1azQ4?=
 =?utf-8?B?alFlMVk5M2lPL2pUZ2FYUGhUaG1CcVNiQU1rNC9ZSGRDUVhGVVFvRTFoaTZR?=
 =?utf-8?B?WHdDYXFxMW9lN2lzTkxPSEgzdjlRNFVmajJ6Wk5YbmJwVHA0SzJQcEcxTGx1?=
 =?utf-8?B?U0hRMkVIenNmN2lQektwcnhBeHZoUUtiYXVieXR5cm5BUU1lUlBJeHFmT3p2?=
 =?utf-8?B?enpjUmtqbnN1MEVwbjQ5T3JzZDZWUEZCNUFHWDFMM3J6MXU2cjQ5ZVpTdTNQ?=
 =?utf-8?B?UWJzbjgzVWdiZG4yNGl1NEZ6MktPYVBSS0RmcUJyZDUvTjJvQmlDR01EK200?=
 =?utf-8?B?eTNvTndOY292Z2h2bXhTd0UzRUVFTWJqR2w0RHh3VGVlc0xnVjlWUkgwQmJW?=
 =?utf-8?B?QzFKZFVmTVRJWWg3RmtOSjdOejlxRnhGb1lqbXV5c1FHL2NSRGwwbVlncWwv?=
 =?utf-8?B?dVkvSzFzTm9Yd2xLdjgwUTJ4TFkzb1hiN0ZxQkxtYlgyWjFHd1FTckpPZjk0?=
 =?utf-8?B?ZXEwNUVqZmtRSU1TMzRHdjV2V29LSHNKaEVqY3Brbk9EVVk5NTlVMlNuS2NP?=
 =?utf-8?B?NDM1STQycUJwTWhsbnhzTHBRMUVsYVJXUExpK1ovMDI0dUtLWGtlNmFCMVlC?=
 =?utf-8?B?ck9YbE5nNmRCZCs1S0oyZEpqbVNubllHdTJtTWhSbmZJT3lzQkVPL3NWeUJh?=
 =?utf-8?B?TGxDa0NvNzdDV3BreHlJQlJaQWQ3NmdobmMxSmIwZ1d3RGZoeHpDQWlxVkQx?=
 =?utf-8?B?NFJKMFBVT1hHcWc3cXRReG0zNjB5bHl5c1dVOXdzbUVuekppcWVKT3VoOFI1?=
 =?utf-8?B?ZFl3MjVsR081NDloUzZJaFhlV0t1UDBTUUdQV09wYlFoVEp4OWhZOENoY0pw?=
 =?utf-8?B?STU3Tk0ySWZxdGVBa1p1VjV0WStVTGVyK2ZtZ2FIK1RlZDdXZ2hKaC9peUdx?=
 =?utf-8?B?ZXJGZmdidy9vRUNBUXdhUStHcXB4UFdLUUVidUgrVHMraDNqMGFXNFh2WDZW?=
 =?utf-8?B?dmQ5M3UwSDRrQmg2cHNNaDl4QmlnVWdlY2RiMFlDQmZidmJlWnBwa29OdUNG?=
 =?utf-8?B?aXUwNzUrMWZRVkJ6ODh4cFdHK09kUE50L09SaE85WlNURTlhM0VNMVZycjUv?=
 =?utf-8?B?MndqSjB3RDlza0FNdHcxSmlKRjg4dHN5SG9YWncyR05TcjVvcmV3bnBrTHlC?=
 =?utf-8?B?T1d6Rzk1c2N6TWRpSVZmSVM5dWp3NExrT0lVUVpmL3YzdGMxVlh6aFJ3b1V2?=
 =?utf-8?B?U2VVWE5obGVWdmdpWGpGZW9LbUIwTGhLMGdDNW14V3o1TWxGdmh0MUVkc3Ar?=
 =?utf-8?B?QTBEaWhLcnlXN0pySkFiVHZvZWR1Q1JJRUVNU1pqMlIzaHl2TlB3UkZFZDRB?=
 =?utf-8?B?YWthWXhLNU5BZW1TeXdkVEs4VUd5T2d5NFJrendDYXJaWkdaMGJsakNkUHpP?=
 =?utf-8?B?dlBwc0RpZStGSENocU05aGJUQnNpbGphSEVkOFVDazh3SURwM0l2cmVmSWJp?=
 =?utf-8?B?NHhCMzdnQkN1YVp5aHlHMGcrSmQ1cHVmY2tra3BNWEwwaFVhZGVSRkhKY1N6?=
 =?utf-8?B?UndoNFNLVkRvcFJGUVdzdk1kSHg0L29QV0JSWFA0QytYVFZOOHhxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddd6855-1ae0-401e-ecde-08de93ba9736
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 08:57:54.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/1zCri9pAQtgIN+0q7YUybKFwnoDSyFSZex7L87BMCJCN9GcuPtezlCgVf87TWgGLWPRYE4Lg5P9hDuy1ETjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452



On 3/31/2026 12:30 PM, Weinan Liu wrote:
> On Mon, Mar 30, 2026 at 1:43 AM Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> 
>> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
>> index f4b5f96d4785..887a9eb8122d 100644
>> --- a/drivers/iommu/amd/viommu.c
>> +++ b/drivers/iommu/amd/viommu.c
>> +static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
>> +{...
>> +       /* Mapping 256MB of VF and 4MB of VF_CNTL BARs */
>> +       vf_phys &= ~1ULL;
>> +       iommu->vf_base = iommu_map_mmio_space(vf_phys, 0x10000000);
>> +       if (!iommu->vf_base) {
>> +               pr_err("Can't reserve vf_base\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       vf_cntl_phys &= ~1ULL;
>> +       iommu->vfctrl_base = iommu_map_mmio_space(vf_cntl_phys, 0x400000);
>> +
>> +       if (!iommu->vfctrl_base) {
> If this mapping fails, the previously successful mapping of iommu->vf_base need to be clean up

Thank for catching. I'll fix this in V2.

Suravee

>> +               pr_err("Can't reserve vfctrl_base\n");
>> +               return -ENOMEM;
>> +       }
>> +

