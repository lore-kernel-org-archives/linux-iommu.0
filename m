Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9632481FA0
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341912; cv=fail; b=DaUAaG01hUp+/iZj5a5rUPeqGktQ2z5NXaCpCBIOUQgz2vWK/6Rt63u0t5FQUA5ZpV3/WgA1ONetq6ZmHH0ZxD+EnrEzex72cbfQZ9POX3BMYZRiKFOtSAZwJz3ZIIGHS7GquN/yDXHNjs47zGLhfbFr9Vd9pN5lpnU5I7tpwog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341912; c=relaxed/simple;
	bh=tviukQ+0hGeDAnywLtx8i+4Wp3rfvECgpVsoxEEtJfg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ibJ6X16VTfExuS9Ch0+uDL+lf1M+CHigpWAuPD50Hbx3pm5PG0SvsLIlQERhA+zxxvFDt6z1H/EvecxPaYDuQPj1cODz2cGuRRqyiILBS3D5oJsBzrk50DINPDd0Cs66/UbKCFbulA6SBgYXGF8tu3pHW06YLdUQOEVRVmcPUlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vIFOhvJr; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vIFOhvJr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6BeoOPRqTXyuJ6WZHB6Y45sMtuO5hUrX601vM6tr3Ami+0vEDYQPbwIyrxdLuWci8w56JoX/fpqzvZe8zd3mhlO2W0Kn8+3XgEieNcq6QIKu29Z/ZO5YwmQDrSE1SHGtwWgt8Wfc0+zLc63qUfNlSJEt4muDKf78qT3Xe63xfbyS55XPpkLQwgG9Qe2nx4pi6UV5oV3fDNloZMsX30UKvZ5FaNMkSi6w9cPBDIzRau4YquBomvVNqDNQ7dyd6PEoIFSPp6LmOJzEcVW/2EjGRW2SI4fbJYmNmLCV/7bAZEW5KcCVWXj63vvLD6lDMslwTjPmgeBxtU4+nuCcxw/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZBv7Yga/fDgJ6xCJWIrrbGoHgk/UAGFipG4775rMtE=;
 b=LcFll5/3dPb/NjPMiLKU+nO3di4D6Eayo9+gMXUMY15uk9hPQaUJh2uRUgsy5P68ZAk4wWv4ThWJk5PC64jXmsCDRBYmB5DbBF4fW4CwZPBDCzXZoUbVFj12AGMxIgKiqCWKUw0uRs9EOSz+ooAT+TrEPajLlHue/SQicFhXVzquj1522i+FSWBmuAPRW0XhHTsKpiQ5pysbzCrxbZ7ZOyLBho2WwexSIS/URJtpkjEFcoUddWfESjJvmDzYshHva2H71IN3liP31pzGrEVZeNjH59UTDbsik3wthJJV+L/ASV1oxcCRUG4ZDTxELe1Stzrzk4/OGMW4/0j4mp1GjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZBv7Yga/fDgJ6xCJWIrrbGoHgk/UAGFipG4775rMtE=;
 b=vIFOhvJrG08gyOqiitXs2V4WrWCwl1uVV/Zb7kjUXzgJbcISENM5Xk2NMBpAlnemggrApB8ktl1VqQ6ipjES/tGiDiCDiKosWAA1y7LmHBDV4ejEXst9hbEIH0SAfdg/nTrhlluLVSyoxqjliln2GY8yGYEOtyLDi3ZHvmLA290=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:11:45 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:11:45 +0000
Message-ID: <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
Date: Fri, 25 Sep 2026 08:11:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
To: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca> <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260925122848.GD163130@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:610:77::13) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c4bbdd-bb69-446f-d075-08df1b068c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|4143699003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	bIET9pZ6Cv/GXYtntDZ54vt6zT2U2qS3NdJyupsxmgkzsrCgXc+suOl/rL8x0np3hIiPZfHt4Bq+8VfBkw+rpyP47Kcj7UylxiZs+HSDkYoiI78pPvepxxzW9SdScNqvyQBB8Oay9AoFsHi+VtK/kTGnFrXCwcWHYqb1cWOmUHuNt0b94pBA961f0hz/eSqqM+7dHnvwp+JvHNF3h4YAKVoEG51wJxS9owVXVnGOAMElvM2oeBNf7uwqw68bvnnH6Kjw9NEbdn1w8lOJ1uRJkSV+KOkkIDyw/bbdmhfAHTkkAIUKBNuPDiB3yyzshqMltgpTN4zCAqM43dDw9u1irj8EAVU/4E+kuOeciqKnQhVrAYCympxC6jvfl0U2Hqd0IpLs0BSZb+ypw89+afad89nL4EgD/mJ0TCY18H3bzKhAGQnfBuaU9iUBbK7cBBO2mx5KwQno6ZdPBqAn69SFTi0y0IABLs9RlWk1G1xBrbV34bHXtn0/ZUCsvTJ3RbZOlqMHzKOWVCEGWmlvDCyxm+omeJqre34zcpOOvzWLsd2ziwGQhoYceRUs1QvVlpVq6GmXByPUmRiSy44Mm0SwuGJDwuQOCjlbCU4CnDu2pU7aX04TfPeNYj19Cf/KIlIjhsDZyXE9z7zNfc5D09roZdZeh7PI+0Oog/RL+fSyDo0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjgxZ21DT2NXd21Cc0pxR2JqbUVMem13eWo4L3Z1RERYT3c5VWEyRzFvaE8v?=
 =?utf-8?B?bS9BMUJZUE9UNHE4Q3k4RGJCcXo2Nk1VY1VZSHd0dWh2Z3FIOW9NN21jcU9u?=
 =?utf-8?B?SEdKSjZqT24zY01KTm1KV2NMTUtYYzkrTVJUamJzNmxKUERWMTRoZXk4MmdB?=
 =?utf-8?B?SHVDZWN5cVFwUndlSEJUU0FNQzQ1V0ViZVNQRWlOVEpscmI0SUo5Uy9zc2Uv?=
 =?utf-8?B?UmZQN2txRGlYd3hmSEgzUmovMmNFMUc3cXNIUFQ1UVZkRmhUeExiUlZxUjJm?=
 =?utf-8?B?c0NkcXJrQk0zR3NhRjlQdzcxTEJIUnc3T0R0dktvOEJrS2p5d0pITjI0KzRZ?=
 =?utf-8?B?UjFZZUovcGsrbURCUFAyc1BMM096N3dBbnI4eTVqamVOYlF2d0ZIa2tnY3dC?=
 =?utf-8?B?Q2ZMeC8xR0Rpa3lPQnozenl3bEhDcUxabzg2R2NlRHpUdkFwLzBaNmdSMWhn?=
 =?utf-8?B?MHRkSytkZ1JJZnZ1ZEZyRE5nakRsTjRQMGM5c1JBK1RNU3RQSFFwVWJkM3Bm?=
 =?utf-8?B?cHl3QWttQkFWRmRnRnRqanRQNXhSSzgzVGpsYUFPbkpCK3VRT2pFTUdHeitt?=
 =?utf-8?B?aTh2SnhLaDhUeWx3M28xWFdUYzZKV2NleEp0YkhpT1JyTndobnVhb0Z6NG81?=
 =?utf-8?B?czZRY3FWYzlIQTJEUXRlWUZUdlZ1SklSVVlPR2M1ZWY5V1JJYS8veE5TaG9C?=
 =?utf-8?B?eHJEdUF1UUVibU51M2ZlVHA1RWcxMnd6SlNub01NSlpHdndXTUFCQ1hqeEVx?=
 =?utf-8?B?S3N6R2pIQ24veTBPQW9mSC9vanlHMzhHVWZhR0dlSHhOeTVSdnA2RWgzdm1h?=
 =?utf-8?B?a0NPMFpZSFdyRVZXbmFrWGxNQlRPcHlScEJsZDA3ei8wSFB1enZrU3ROdTRx?=
 =?utf-8?B?eGlnd1QwQXMyUWRLKzhTMkI3RU15eE1ScXRoN0tWb3lNbUNKUzB5bmdxdk9H?=
 =?utf-8?B?bjQzTks3Wko0UmdLcXN0dHBsaU5IVkozbW0zQ3BoYytIR0dEK2xyMklJL3hr?=
 =?utf-8?B?SGRJUWZhNkQzeWhRZElIekZ0UncrOFB5alQ5bmM4TXluQkMwRkluOUNNREZT?=
 =?utf-8?B?ZVJWQ21oaC9WMkVLTHE0Q0hnUjgxMThGbUg1LzJCNU0zejJTcHVickNBZ2JS?=
 =?utf-8?B?MityaFFIYUlLby9pWWVSeE5MbGVnUjh0Z1VaWSswbGk3eGZpZEo5a2NSWkpj?=
 =?utf-8?B?QkU0ZkE4cm9BNWtpaFZUalN2c3pmYzJXUGwwK2QxcFl1YmEvc2F0MWZjMmNw?=
 =?utf-8?B?ZjN1VFZDQ1pYaDJKZUtucWt1bFBiRGJsM0NHWTMxUEpMMFJyR0g2WnpNR01l?=
 =?utf-8?B?NmxuOHQrMERwYmV1ejMyc3NjOEorM29QMmdTTFdOcjFlV3I5V0E2ajJHQ2Qz?=
 =?utf-8?B?UE1IWU5HZ294RElHamNnazlwNXNPYjdlRzlaT0RDNzRnM1RacWZwYzBDOCts?=
 =?utf-8?B?aSt3K3YvTkZqYzNQVEdMWStaNFBFMGRjWXg4SkFsdm5mNy9XUG5KV3Rtbm9z?=
 =?utf-8?B?VUNPQlE4MFRPYnhTSSs0TU84NlFwL1l6bWw5Y1pqUDJTNFhKMkNSQkVlc1g1?=
 =?utf-8?B?RW5vdVVtWmdrTzNIR2NQOTBPOXQ4dGtCd3lJK1hFdXZpaUFkN2JoSjVJa2Jl?=
 =?utf-8?B?TERPSUN5UXFYci9VN2paTUhkRVo0alpITDFIRFVOV0hKNGJHVHBSbmdPRzBr?=
 =?utf-8?B?Si9obmtzRWNpMVdtd3BJdEpqNHZ5ZzdWSXVvc2xQVmgxSmdwNGVUcS9HVDVv?=
 =?utf-8?B?cWJpa2tlSkxCNUpHNW05UGk2aCtiZ3ZVbktqdng3anBNWk82eHpjdXBQVk9Y?=
 =?utf-8?B?cU5hcmdRTHBmdTJQaHdNWFRqdEpFb2traUxtaE95VEZGb01EMkcrSlQ4YUcz?=
 =?utf-8?B?RTByZkY1Qi9mZE8xWVBnM1B6VjU0SzllN082bTNmZ2pRNE8xelZ6UGd2YkdC?=
 =?utf-8?B?dHN1bFFQV0t4aE43UFNaaWRvd1k0THZna0VQYUVmUlo0eGtaL1p2S3Vzdzcy?=
 =?utf-8?B?bjNGc0oyNytxWVcza2NJRnZTbDE2VzBFbTE1c2EyTnVucVZQZm8rbzRCMkhJ?=
 =?utf-8?B?QUg1MEZZbUNTcG9iWDdCQW1FL2JGRDVjUGxtMlprTzVWdFpWMEVyM1RFa1Z2?=
 =?utf-8?B?L09zTW1sazBxTXdqa2FFK0JpcndWbG5lSEpBT1QyWFNmcTR2a0czRDE4M0FR?=
 =?utf-8?B?eUJaYXV5aVkrZ1VaUFErL29hbFg4NnBFeVJja1duNHhrQlZaSnBscHlYSFRy?=
 =?utf-8?B?TGlpQlRVMG9CWFliMko2c2lLZCtyY1l0bE54UnRFMkJtdUpKdUNuM3pjemRa?=
 =?utf-8?Q?yrr4Qfils6fsSHEi+u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c4bbdd-bb69-446f-d075-08df1b068c5f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:11:45.0964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/8ZvZTqmENSgTWHjOmh0dYxe4cl6F4XXAzqJunRgPFYs3J5X8nhILHOZ5St84k3j9sW7ehLWLKwowsViXNCpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831



On 9/25/26 07:28, Jason Gunthorpe wrote:
> On Fri, Sep 25, 2026 at 09:20:02AM +0200, Joerg Roedel wrote:
>> On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
>>> Why does the GPU driver have to request this? Why can't the iommu
>>> driver know that this is a special device that can use this magic fast
>>> path and then auto set it when identity is asked for?
>>
>> This is a layering violation either way. Either the IOMMU driver needs to poke
>> into device details and their relations or the device driver needs to poke into
>> IOMMU details.
> 
> There are no device details, this is just a module option in the gpu
> driver.

Well the GPU driver has knowledge whether it's a GPU inside of an APU to 
decide if it's valid.  That information is part of the discovery table 
setup.

> 
>> This is not perfect but to some degree unavoidable with these highly integrated
>> SOCs.
> 
> This is exactly the sort of hacky thing ACPI should describe so the
> drivers can just turn things on automatically.
> 
> Who is ever going to track down and figure out it is OK to set these
> kinds of module options in the first place? There is general negative
> sentiment in the kernel to doing things like this with modue options.
> 
> How does Windows do it? There certainly isn't a "module option" there?
> 
> Jason

This specific one I don't know; but these kinds of things usually end up 
in knobs in a UI that plumb some IPC deep into the driver stack.
