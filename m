Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FD3812F1
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598610; cv=fail; b=NDs5GQM7Af6+Daxpu4v78fmozhI5dE2WKiKGlt0l0A93oAb4EfJIdTGSQQUC1HQbDv3OANTb6+rEUSMyDqlBG4/wjHYvvTovJt/qw3a3HBDLiUZbY3G7Kfri73kFLOs9knP7d/fVFpf+baStCRpGoIQu8t5nfTjX7hZ7JI76prY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598610; c=relaxed/simple;
	bh=YRjVztHcfZbBAKCryW00Wxd3gG7LLOTe68KwvMmkKno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XaeU9sOj0he8wIGtIqYhnaitYMlwdS81FJ4CsNE8KO35QZnXeFyvW/Jy3eVnCTwENUVvLUanqrcIVSNTURs1t/bBKqlX/eOsg+nqcVcxBIKz6xXP1xLW7TakbbK092pTak1v7IhAnhW8iBKUvx/h0ErviPIw1PjioGGeEu1R5po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CQnrx6ny; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CQnrx6ny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbHJwHDjXLk/r7N0/rQq3SFfSplKutFWiMkiujk46REuxO0vEjlFWUM+Z1vB3DyikLyLly3bx/HkXfqWerHmaLeL+GLqsq7AFSTHJ239XseHeArb6rhklnsxJlfqnPbbMZnELxirv/SHmR7amfKHRLapVsatlbDaC6xjUFvw7Jh8lEDVzV3ajaPQ+pydee7FIr5Nl+hWEPNNo658Vis0x14ZxF8nCbtzgMtBrhT+912sGBy4rqhB5ZoiqxOAt4SpGFdPQ0JQLcBICzoKjIDFmf1bTAU/sutuNqaP0noOewlIKGiJDs5W9ztvfqa9bUheDD/ilPMz55ege1Ikb0lEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo3+RxOFrwaW1IwP8ikNs/cPLRFDCwswNHda1cnVvdU=;
 b=RGOsgswx/sQyxNwRaqvHYd3bPLbxJK/bRnL/6PAFW4JrdP3luestNuEVrf4gW4mpPIq4Cs6IlMMHNlJwHOkoES5b2EF/eWH0R1/dZDFJc1t11lRQ3QMb4e5U3rQKAnwqbqeQ8YxGfxw7jchDsmi6HQpWN0xgUxE1kSv0EsI062tREJGPidj9KRinGXPIzhnKvctRp4Z6rWeYxFQ2zHkrqLUg58FMJ6jkemtFwpveG6A1f6DUy2BVMYDgAot+ZSk2SYTmmX62jR188RKSGPFoQ16NV55l0PoOSyJrr4DYYOszbB/hc8n6vFmW/GTtVhtm4mwoBK3DW+r8/W+BZobpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo3+RxOFrwaW1IwP8ikNs/cPLRFDCwswNHda1cnVvdU=;
 b=CQnrx6nyNq0b+wE+tOif9rpHu8Jxf7T9kJZs46aXm3yDmskdk0WwOCQJqNtaNX96jKDLdkn5MZzwfz1VIJqtbnAGn2qMHYNHwtdqZniNxTfIKtl3YSdnZ67B3pfXOh/FxczrMdG0dJjqAQ8LspSH3ZzfHKwGvdFKua0aK6SkFVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 15:08:02 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 15:08:01 +0000
Message-ID: <501683e6-30c0-4d48-845d-592ffc273e38@amd.com>
Date: Tue, 12 May 2026 22:07:18 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] iommu/amd: Introduce vIOMMU Guest-ID (GID)
To: Weinan Liu <wnliu@google.com>
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev,
 jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org,
 kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
 nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, wvw@google.com, yi.l.liu@intel.com
References: <20260330084206.9251-6-suravee.suthikulpanit@amd.com>
 <20260407070147.623349-1-wnliu@google.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260407070147.623349-1-wnliu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3a9882-7fe9-4ac7-7cc6-08deb0384273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HKK5o9E7cXVzDbeVZW6r93WaYX6ZD8ef91VN72WZ4UgFFP5QN9UspFzDRFabS+SqniPrTDIZnorbtf0Jm/4xsHfMMdamDO5DXpOc9LxcHPi1iOWqGvXjIgzrcoozuS3zCTsLls5YGk6+bTBKXoxmYPoWYOc+i9kghbM3n+MYjUuhFPx14kVui89uA4A/SwAEY8NI9JgoilLHK5/dTc9PGpYPXZlYR8Es9Z1l5rKgbWUOyupai/yzmrMZjqV9AuZcKDJvbiaudKd6IzZBbjZU1LFJSal3ZQmUtcA44T/dYBvRrRjUfHW+noAOxrXFyZ+gjK4oH6ud4ku0UehqjdW5tZv45aU06wqEHtBn06tVww79H3bHIRtm4Ec7pugG6OIZKugWy3pvVRbGwsNK24rLcaCN1cFRW3LH/7eJ1hW26L74zt1XNOj/Ip1NIa8rm7rAWmo0y04osrK/OAk0I56HJgbE1lkqUqF2V0FK5IzCj0UawuBUlrpS5LoeWHu8lHulJtFGZjy9JoRSAUNQli7O81tw1Tnl6QVyuTXXcyJv0ENp2eNA7PvX8d8pJ4pECwuNskQ1McVMJTCRd5rp8Zsxj3tMhIxClMZgGPmOLR7inEXEga6TBULLQqSCfPgQCrWecwcutILW41MwGUudSzC6/aRsF3Nzfy3fZE6KJtZx2sAXxgfULXONzyb8x9FUscFs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkpYbllXRUJCek5yS3NkQ3VrNk9jY0RPQnNleXNYeUJtenRBZTFuSURHY0VF?=
 =?utf-8?B?OHhwSDlGQU5JU0RaYVE1MWVyQlJrOFU1YjdUeitHRTB5YVZXSGN5TlN1NkVC?=
 =?utf-8?B?TDJDR3hML2t4Mk5aUUVBRnE0REtSeG1jdkQ5VzN5QklQUEc0d3NSMnhCVU5o?=
 =?utf-8?B?emNvTTlRSGR3Ri9Xd21OMHpQUVFicjNLdElTMFRlckZobStGQTJ1WUUzR3li?=
 =?utf-8?B?WFE1OFFFV0hieUFlREtiTE1oc3FibGhGbFFsb0dHeHhTUXIwNEl0Y3lxeURY?=
 =?utf-8?B?M1NKWENTY29BdTB5SUZXYm14aytJRlhIODMva2NWb2V5Z0xtRDB2Y0hEZGRE?=
 =?utf-8?B?eE0xNVJxSEswcVhNdjNwQXRKaEo3OVRxeFBqT01KZThieEswN0M1Q2IxdFdR?=
 =?utf-8?B?ZlVtRFFxbWdMcEZTZTV5VVByN1JyWnR2TDN6V0FKUEkwb0Z4RmZySnFWRnBB?=
 =?utf-8?B?QnZMSGFyOTVYWlFVMU5ac1NERGxkRXI4TzN1N2MzZ0ZrWnlQOVpBRzlCK1po?=
 =?utf-8?B?QzFNeWwvK2hMdmpZbDJlSzNaazBaRm4weFdLaERuR2xPU045TTBaVng2UXdi?=
 =?utf-8?B?cm9HTTM2aUNWcm9Ta1pJa1RkWWo5SmgyM1IweTN4OVRHT0s4S3NBMWlCUlJU?=
 =?utf-8?B?UHpjSTNoMGkzaUREWGZCbzNVQTVjU3NtV3ZFa2VyalBSRjhOaXFRb0Z3OGxJ?=
 =?utf-8?B?bzVlQW9tUm9mNGNrdHpWa01tdDkzeW9BZHZTQ1lSYzFzUEZQSGZpUzMrejdq?=
 =?utf-8?B?VFlNSjhFRTlvL3VYUERxa05WR0pzY1NNY2Z3b3J3V29HZCtFNGxCTmpna0E4?=
 =?utf-8?B?ZTdJV2U3N3c1NWVobjVjNERsQ2hDc21JL3lFZWN1SU0rNDg5Sm5wMFk2elRR?=
 =?utf-8?B?YjQ5NGcvWVd6UGZSNUJ4OTEwcFNqQTVCcHZkcS9oQURZRXVLOTRKWkQyZjFt?=
 =?utf-8?B?Y0wxWWJmVGVZRVdpNWE4cUxjdEpvMHh4Y2d4TGk5ZEsvN1phL0dham90WU5i?=
 =?utf-8?B?REhRWjhzS2R5YTNkUUtGekFrVytnMVJvWks2TFQ4WlBId3A1eEpzR09aNnI0?=
 =?utf-8?B?TjhsaWFoVGl0UHdnSWVwTCtucmNaNjA3TkZUd3FNeFpiMmlPMGlRVTFMZS9M?=
 =?utf-8?B?UThtZXlGN20yQWsza2Z5NjUrakkwRG1DTHFqcFFDSm9oWHczY3Q5OWdzLzhs?=
 =?utf-8?B?Z3FacEdTbUhaNHA5cUFZU3I4MmtsdWVWSHFESVEyRUtNNGUwNVY1MytDYk9y?=
 =?utf-8?B?dU1IdE02N085cjdULzRMVDhudHZNZWtJaWtkSkwxc0dOSStTU2d4K0p3NUVa?=
 =?utf-8?B?RjcwTGgzQy85VmJuODNUc3habmtNbGg3bU5HWTFaaWtKa29mOUxjcjk0MDZO?=
 =?utf-8?B?UVowb29RdDF2Rnd6Y3Z3SnhFdWd4bjg3VUZxV2pwZk55TXpmTUZVdEgrM056?=
 =?utf-8?B?ZjFhSmx4Q09IdnBNODd1QVkyTmRGQWhwTUNzRzM5cUpDdDdqK3B6MVdQTWpY?=
 =?utf-8?B?cTNHeFBSVDZFM0QyazR4ejg5TnBiN0FveXZCT0F6d0tVZzJhRWFRZThYWHVz?=
 =?utf-8?B?SmtiRzBvWklnNHo1VnlFb2ZhNzhOdDhUdFJwcm9Ma0RVRVRqT3ZxRUpDdG45?=
 =?utf-8?B?NHBKRER0UDQzRndjaGFhU3ZGVDd2VjBWSW9IUEVrT01VZ05qTFc3U2lSb1FO?=
 =?utf-8?B?TmdKTGtUZUNDZ2M0eDYyb1BMa3ZmeEpsRmd2V1QzbUl1dVpBNVVFdnVCU2NX?=
 =?utf-8?B?SXhCaXA2RUVKRXZoeGlEdmZzTFhrY0UyejIvejMxSTB2VnBXRzk4dFlKRkFx?=
 =?utf-8?B?TVUrUTdPQWVVMGdGeXNDN2RBbE5kRXo3UUtSQ0RodE9nOEVNQVN5ZFptOCs5?=
 =?utf-8?B?NFhVc0RkNW4zS1hnQ2ZpckluZEMrNkFMTHRSNkhwM3R3Y3BYZnIrK0poNXdO?=
 =?utf-8?B?ZjJDUFVncEtFNW1uY2plclMwb1YxRU9NbjhSNjBiSlk1UEtBMDY3QWVYenht?=
 =?utf-8?B?bGJvelVmTithVHRwRVZqZHE3ZUltYU1RNlBmS2N0RWhWcTlkVXV4QTZHMjB1?=
 =?utf-8?B?ait4YWdCTUxvYms1ejRuWEtRSGJPdENOc3Y5L25GYjROTlFkaExXVVd2YXpo?=
 =?utf-8?B?a1lna1laWUdTWEwwMTdsQzVROEp3Wkp3cVJTVmUrSW5aMXlWcG1ialdXSmJs?=
 =?utf-8?B?Wkh0b0V0U0o1dDlCVXUySUhleFUydUNSSW1MREVXS2lzVWZ4aHlDaWZHdVBo?=
 =?utf-8?B?bzR0Y3UvWlVOWm5wME0yR2xIaHJXaEs4bFdYOHFuRFpwS1BLdGdodHdQQ0FC?=
 =?utf-8?Q?2B4T7Fa0b5cKdsdPag?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3a9882-7fe9-4ac7-7cc6-08deb0384273
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:08:01.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cQl36BFU09esNfE0w+HgTDqj0cxabH7d2ueTxBuwBHo1oVUqiCRD+YuGCkZeT0S29NAFZ1OidKeSOmJCo8WNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940



On 4/7/2026 2:01 PM, Weinan Liu wrote:
> On Mon, Mar 30, 2026 at 1:43 AM Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> 
>> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
>> index e7ffa7e8915b..6fba5d9b1310 100644
>> --- a/drivers/iommu/amd/iommufd.c
>> +++ b/drivers/iommu/amd/iommufd.c
>> @@ -43,13 +43,35 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
>>   int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
>>                              const struct iommu_user_data *user_data)
>>   {
>> +       aviommu->gid = amd_iommu_gid_alloc();
> Since the gid is defined as a u16, the return value from amd_iommu_gid_alloc()  will cast any negative
> error  codes to a large positive value.
>> +       if (aviommu->gid < 0)
>> +               return aviommu->gid;

I will fix this in v2.

Thanks,
Suravee
