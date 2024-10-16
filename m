Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238F206069
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073636; cv=fail; b=V1DUV4oexAVAGQKAuGp26rNrySwtyGSPWfgh8xwCMYe7ibaLSXEczfaccuMgQp+Le4CnBIw46qpaQ/CDB4+4/VS93/Vmor7yZxiHtpjoatJZ86jr+tefVUMXvei+pn3Soop8HzGr1nhOUTtZ/KyQWCbfcy62w44BcKrLYBP85fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073636; c=relaxed/simple;
	bh=V0AT/vnE7WVn+Zndk+OngLegez/sKsfL8Nl6qiPVEeQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqfaaqqRCK0kXMv05qZHiBrmFo/HTAtp34areeb8URS5udyTlgrpQ9HqbLtvBzjbBtXYoN6uR29OiuF8kkRRRU8pZ0GmxBPtkw2TCUQKLAZ4qDKq8GTQkveGsJdFmrM/yhnM4FBF1T0S4Hx7rGIZgyOAV7qZ+xm/Wj9KAJzhscM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sdu34m5M; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sdu34m5M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9hsYkO/C72eeltDx5TOkVsYSpEmb8WTji6OEbMSSnB2bdOWs/EAX11tdhpH23FK5kNlRd9/ChYGZ6kvhfxyNpwjT8CwVyXedCSDSAft8xK7OiUUPHW4S4ZbYHPdGRrHzzQQlIjFdPvbYhylk3UiIYp/60xsI8No2QbFg/Iw3GWtKvKQEnZpNGmiU/sHVhbejdI+IO65v082T6b85PjmbIYV84Kbi85NaMgigUxCZWpQILuoZnkhfD9tRCFo/MI4ECaZ3x0b59pXJEyy+1vuk0c2GN59NTHdcLwxuKybCclARob7SQTgHyUriUsgKN2lkAcGxvJ1WvhXYOr7P4Surg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B3WjuDlRZIWzop+rmdcuOpYAayUvv9645OLACW2zGc=;
 b=oIVN/JWITOKSdL7exfq50K4T1C1jW5MIDfmP/eU6diCaDXcpgmLvGhzJo166wTUCTPgM0theGafAtLzUgT26n5SxNZXPrISou3tGaQ8sBfXH1CSa18Rx93dAT3mfMpl539St8vaWqluRKd/+8ic44XNDuUM/0HYu2cuJLeBWS1LlAqvyvwYDzrC2/AYPP6l3vz0Eu5beJQyA6pgKi+AxoBIpj2Ybn3vuUk2hj5zinZTmpFFOvqVyM7T0RjuJU6r3XfdAlufK/13bweEGov/m0KDcGKUsBpUFZyX3fVT3Stt5ewnkwt91cBLfL8Z6VrWgAbX+E3jT45f46JS2Ivb/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B3WjuDlRZIWzop+rmdcuOpYAayUvv9645OLACW2zGc=;
 b=sdu34m5MaFuRhM6D8+nkh9LYg9ZL4zNQFvxXnz22HibcN4PFtOgf1oH8IhkYOPX+UTqiVgB7HNiMnOMAkpvSsUxe822q215KZJuHrn9DJBINZ1j2wbizUgTk/VXBw/6WGgjinPRnzRKEmomOACmZi279J9h9lgt7H4Zoswm5MeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Wed, 16 Oct 2024 10:13:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 10:13:52 +0000
Message-ID: <70d5fa32-9911-46f5-bcc1-30e3ba4e8ab3@amd.com>
Date: Wed, 16 Oct 2024 15:43:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] iommu/amd: Reduce domain lock scope in attach
 device path
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-7-vasant.hegde@amd.com> <Zw4p7Gc099DtQ_f1@8bytes.org>
 <24421a38-3d65-48bf-a40b-7a5b15f9b1fc@amd.com>
 <20241015161258.GN1825128@ziepe.ca>
 <62782c52-4bb7-4981-8158-9eccd589e50f@amd.com>
 <20241015170134.GQ1825128@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241015170134.GQ1825128@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6d14bb-8b8f-41f6-4a18-08dcedcb3bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1ZpOUUvNXppVUFGSUxXVFoxeWpNZjBCc0VYT1Vnb09XWitsTysvWWVGSStn?=
 =?utf-8?B?Vmt4K1NUS3A4R1YxNGswQjFvZ0MzTWxEWkJCU0JtcC9VWDBFNm1zZjRpNXJh?=
 =?utf-8?B?MGt5WkdONUpYN0M5eE5SaUdPR1JMWUJlYVZYUDllSmdCMXlsVFhhSzhtM3lX?=
 =?utf-8?B?YTJ6eDVZRi9Id0xYQVVSU1ZRZHVEOVFTQmw5LzVNejBKdzJGbGE5YmhZY1BO?=
 =?utf-8?B?UHVLMWFqc0tMc2VCeDRpZGVpSGxYVktETkM3QmtJOEFhT3lQUmxHV2xjbVFN?=
 =?utf-8?B?MUtFa2FoOUxCWmNZM3EyODZyOE9Sb0tUVlp2T3Ftb0JBc1gwTEdUZytUZXVK?=
 =?utf-8?B?ZGNxUUlwa0dabXpFZEdnVUloRjJsbXhFQ1BodUNPMm5ERXZzZzlSeVdnc2Fp?=
 =?utf-8?B?YWRpb010WU4yMzhYUUZZdlJhc1VxQ3RaV3lmWERubzNRTWdtdWdWcENidGtX?=
 =?utf-8?B?RndQczZNeFB0Qzd1YWtqaklHTEUrazVZcVBSbzA0bUpleVNPYmFMcE1rbm04?=
 =?utf-8?B?WEsvaTFRNWs3VnRaelUxek5zZTh4Qmdkc0E5TTNvUm1zM3RwY0t5TWpRTlRK?=
 =?utf-8?B?VE1ZdFluWXcxT2RMNUsraG9RdUZoYUtDWTMrRnRRUmxISVc5b0VBOVFDbnph?=
 =?utf-8?B?ZFVlbnNjeE9TdTBYd3BjcXdhVFU5ano1aktVWHRVMHNwN3BrOEhRZ1NnOTY5?=
 =?utf-8?B?U3JqWDJUeGRYV0xLTXVmN1ZVVmdNOGVBd1BaOVNZaERTYzBvaDVJQ2tQdno4?=
 =?utf-8?B?Y2NDd2hVMGZpQ2U2TFB1TnB5V1FUNmQwNW9LSkVMaVVNbzB5Smt1eDFTNkwv?=
 =?utf-8?B?VW1PbERORUxWWGFCZHE4UkdFbG5YYlEybWlVRHhnMUdyQ0JIWVNsVkpEaVQ4?=
 =?utf-8?B?YzNyOUE4cTZRanlHcDNXRFlwaXNNeG15SzJzWnYyMDdmZVhLaGUyUGZ6VE80?=
 =?utf-8?B?aVpuemNaM0VTSXEzRGpQbmZYOCtDenlkYWM0dHJWbE9sTGtvYWxWV1hRdjEz?=
 =?utf-8?B?N2xWbVJrRHJBTHkrNW0zOTdRbGJ3SVNRM2xtMHVtUEF4RFQxWEVIRlE3ejUv?=
 =?utf-8?B?V0gvY1hBZjgra3h6dFNhbEN6eDRVTlZsMkljTjRiaUc4N2x1MFpJQkZ1Zy9K?=
 =?utf-8?B?ZFJHajRhelovbGF4SnpHOXRpMEU2ejRycG8rNUY0QTJoME1yTWFyMWZBQmFl?=
 =?utf-8?B?NmFKS01iUi9OU0RhT3o5MGJ5ZElPbVA4ek4rZXErOUltcjRIMzhqcDFLM0xv?=
 =?utf-8?B?OTA3NEFNYU1ZQWhLMC9JNmlVcDA2akhDRUROc0xaTEJkV3htS2pDTnhIUVh5?=
 =?utf-8?B?c0VNclgzS0lQaVg2R0FheUo3NVF1N1g2QlFhVVU3OHVQS24xVjc0NXdVWXpB?=
 =?utf-8?B?a1NIVXEvcU9VWjJuSWg0bkorUy9SZnNZM0d4RzF6MExWTU0rSiswbVUvdjZZ?=
 =?utf-8?B?VFRlVFpGbTNrMStrajFDQ0Yzbm1RS2lVTlN1SzdDY0JIUVJPdUJjTVNPNXEy?=
 =?utf-8?B?bFJKNFozTkxyS3l0cXQwcHF2d3RLRXh6ajRkeUdlSThzMklJZngxaWxrNXhn?=
 =?utf-8?B?YVRSOTBhRnBYaW1hM01RcVhCY0Y4amJweFZlNElqZklwaXJQNURxdzgzZkRL?=
 =?utf-8?B?TkdSc1pQaXpnQ0w1blg1b0R0OUlOMEJ0Uit3QTVJcU1OaEdobFpjSi8ycEVJ?=
 =?utf-8?B?aUIxWHRQVXZMM285WWh1VXV5SzRWSktnL2lZNmdGZ1pydDZMb3c4eVBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RStLUFVzNit3THhZS3pDU1Z4WlAzeVpoT296K25SMnh3am5OS0pmMUFkZW54?=
 =?utf-8?B?SHk4Wlc2cUs2SjltTzVyWVpTWmJNMHdoMlpjdFUvTTMvclVPVm9JVldSeXRI?=
 =?utf-8?B?ODEwQ2JGRENBb2xvSlpXOVY5eWNjWXA3Y1V5d0hqcU1PdzYrNEpiUlplRDA2?=
 =?utf-8?B?a2JvZkdLUURuODhhZFAvdmVOSTVEVURPQzZCK3lkTi9tUFhBamZ1UDVqTXdk?=
 =?utf-8?B?YUxIRkExT1ROSnkrTE9KRm1UUlgzdkVTSmlPY0llemxKUW1qTFNXSnpja29r?=
 =?utf-8?B?QVVka3JMQ0JRSWpGSUFvbC81TjJKY0lMUk9leERtN2hvZVlNN1lDNFFaTVhR?=
 =?utf-8?B?TktTYngzT3E2eXZrYldMUlBXVmljQUkycXZhblFtK3dnV3VCa2tleE1yWE1S?=
 =?utf-8?B?R3VnemE1OE14WG03M01tRG5qdjAyMlBncGxzNlN4OFpiZS90VHRFbWZnN0pE?=
 =?utf-8?B?MmdlMDlvSzMxblU5WldJOVVYaUEwbk15bmdobHVBeWpLOXZuMmk1T3paOWdo?=
 =?utf-8?B?b1BiOVc1UFZsOE9CTWF2enRmVnlqa3JHVFAwM0JZRCtJd2F3eE81dmhrTGJm?=
 =?utf-8?B?aEx4TExMblNXNjVVOEhiUFY4b09iMFRGZ1NrZ3dYL012UnhBVlNmQTlUVWFX?=
 =?utf-8?B?NVZHbDBpOFhDY3YwRUpRUlMveGpNdHMxNzluV2Q2RE05bjhhV3VTdktEaHFi?=
 =?utf-8?B?UW03WHhLdTB5Z3F2dU1CR3FTcUtMU2FXVXRydDZIVnZqUitKcXFDTnJDSHJt?=
 =?utf-8?B?amZBUWVlUlVmemFBeHpCYmZMdkMzcW55QjdraW9ldnFBUi9RZ2JlQ0lxakU2?=
 =?utf-8?B?NDZKME9YalNWNEVmUWZBc1J0Tk1vb1ovM2Jlb2RYSDVGSVp2a2dDMHpQUTcy?=
 =?utf-8?B?N1ZxNXhQZERMT2JybFNwUTJ2VzZDYVIxczZQZG9MWmRlNHdKeUNxRVZWdTVl?=
 =?utf-8?B?dmdvSU1ucjZtbmVhdUNtN3ZtUzdKTk40bjZiYjUydjh3MjdkSDQ2TzA5VDVH?=
 =?utf-8?B?T0ozM2RTQkFMc2YyVXlUM1lUOUo4TkNCNUYxdDltS3hBdnV0MzZ2RUhIbWdF?=
 =?utf-8?B?eEo4RDYxdm9EQWRGQ3NJci96eUwvNDQ0clh6MWhxTCs3S1E0TVRjeDB6eGsz?=
 =?utf-8?B?SW9tTVFVVi82M1JRa0taZEdwWWF1VVJXRnduMU5Ta1BOK21WQnMwOU1STVFr?=
 =?utf-8?B?djVCQ2NHZHkzQ3Q3VU1qYnVCbDUzUEh0QnNBc0ZQZStFYWYwK1lxQ3QycUJH?=
 =?utf-8?B?TGwwWFpOM0hibm0yUDk2ZVRBSThrUS9PaENCYWtyV2J3Ym5QUXc4NGtNSlNo?=
 =?utf-8?B?cTU4OTB1RHRnTFQvbkdwb3psVFJ6TW9sMWhyTTRaYXRDb250MlY2dk82dzRT?=
 =?utf-8?B?UDVFNFJrbXBEclZLdkxDM2NLQ3JOejBNczFPb3FNdUZrR0V4TEdqRW5OT1FT?=
 =?utf-8?B?N0NCSHF5Sis3QVkwYlh6RXdCMTJzamRQVjI2ZXJ2L0ZKU25hTlVXMkswY3BX?=
 =?utf-8?B?VGtvc2RsRnRaREMwOEFaR2NuY0dYMmkvcDNrQ2FPdVptdENwYURteXUyMVp6?=
 =?utf-8?B?eUZkcFRYWmhxV1BIeExxRWRyMmhBNHc4cWZoNTBsSEsxak9wNGJjZ2RadDNE?=
 =?utf-8?B?TFZjREhVMWN0NnFDOUVsZFV4cTZjWldWREpIM2tPa3U5VlV1aFQ3bUkyNWk0?=
 =?utf-8?B?enB1ZzBpbmJCaFRtWVM1YnNuUlhNdXFoejFpZmFJeUdtSVczd2poWE5NeTZw?=
 =?utf-8?B?Y0RJQmx6bUVDcy9sZDBpa3NoTHBwaTA3VktqVjIwMW5yL29tKzAxOFZxdmZ2?=
 =?utf-8?B?WURyTnN1azFZNk5ZVUtqN1VCeUtWUUV3cnRia0IwTjczNWlHbDFsNlkwQkN1?=
 =?utf-8?B?OW9EMWpHUDh6QjhUWktwRWhJWnBIejZZbWtadU1Bakc1clo3QlV3MlZJSHMw?=
 =?utf-8?B?WlBXOVhJVEc5N0VRQlMxd2xOSkdOcU9rdmR5SlNCZVUySXh2S1ZNMnVob3hC?=
 =?utf-8?B?ZEs2L1ZScXRrZldFNW8rR2pyTzkrN3ZXelVtbWNUZGpiRE1uaHhIdkZtT0Np?=
 =?utf-8?B?T3o2eWNZSzBPUXF5ZDBaL2RZWTZwMDZibXdvajY2Mm9aZGxtd3ZwdUhZLzYw?=
 =?utf-8?Q?ghVEpa8ePvQzmatIxhDMarFGJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6d14bb-8b8f-41f6-4a18-08dcedcb3bd7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:13:52.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDS2578wcXFS0SAIhua2YWD4HfFR0D2gnvwMz8enu63rrghUN4dkyeIuNSOUZZBHoFt4lvXJSEIx3ckI1O+b2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031

Jason,


On 10/15/2024 10:31 PM, Jason Gunthorpe wrote:
> On Tue, Oct 15, 2024 at 10:15:30PM +0530, Vasant Hegde wrote:
>>>> With all changes locking sequence will be :
>>>>   group->mutex -> dev_data->mutex -> domain->lock
>>>>
>>>> In defer attach path (iommu_deferred_attach()), core call attach_device() w/o
>>>> group->mutex lock. So I retained dev_data lock.
>>>
>>> deferred attach is broken to not have the core code take the lock, all
>>> most all drivers depend on group_mutex for correctness.
>>>
>>> I think we should fix that, not retain unnecessary locks in drivers :\
>>
>> If you recall, I had a patch to fix core code [1]. Robin had a concern and hence
>> that patch was dropped.
> 
> I do, but I think the concern was addressed.
> 
> There might have been a small argument if AMD had a non-sleeping
> attach path (at least in some case), but here you are switching to a
> mutex so that is out the window.
> 
> It is one thing to say we don't want the group mutex in core because
> it is just documentation, it is quite another to say you will keep a
> fully redundant mutex in the driver!!
> 
> Drivers are relying on the group mutex, we have a lockdep assertion
> helper now, we need to hold it consistently when invoking the
> attach_dev and related ops.

Yeah. Its redundant mutex lock. I am happy to get rid of it.
I will look into it as separate fix.

-Vasant
