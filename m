Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D642D51D
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240556; cv=fail; b=h2tBsxKarTSIah9yDho8rXiLUteU5YYtPM8/G2jb5u17LGSuxRTENhXsvDVuprWb9c+YgXVdeMftKNU7+R+CtFlNQc4YGDargf997SnpUYap9WM/pXZjFWNhTgyhbn5piyEKG3LvRwzXvdHqxIyEbO+1UcDb5tmWRBqHNYdp8SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240556; c=relaxed/simple;
	bh=o9y/Tg8Z+bN91DVGfXM7GxHn8iAki2z2iRivH3CrWlU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+aIuv61Ae0FrpoYqNvUYDBP1wnaHDWWdGrwkl+EBUkxqmGCvCqBlnfLrEpGfGA/rMBcucWmIeQYlQn8NlxegwjAEK9uWG/AxQRGfLOJHLxr9F/jKNbqsaDgPMGhjj+LkpbdxegvPXgc93f5NLHJMCM7kUKwY+9Z+/YJm6UNkM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aYQjO6kN; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aYQjO6kN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHUEtYVCrqDwjl5z9E1Huzqzk4UQbjLzEgBpT4vABrzY7hCfmoP9eKTn9C2VXE+Lb8bUY2reQJpYkleXBX9CDVM7Q/lyXCz3NM8lCNeBBM/Xzq6m1iYf46nRLA7WawNlVFv9QIOelkQFqsxeLRDDuGg2yIaXtIlxSyMUGgRtoweK/7lZlQeVcD9Px/iSaRWB2yXy9vCiP3I5dXQam6B8MaRErRPX4EnUR0fiq0YHwbrvnD9MSUj0yc8AjH4qaiUwO7WP8pPHZZzNnSRH5uDEma8tmWNbkjgeknQHlIE3YfpidE2NdkZtN5vHnPU4y5q+wp+AUeDzVemeOAbWQLHjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SN4C87Zg1ZNly58BW1OR4n7RMGd5KoD+gsBTHNoiuIo=;
 b=nXWGx13BfmoBawXZ/04xzSNz60ycUw6BPoBk0wykyaJG0cH+YkYrcqAz0jaHAm6agekK9+g1vuf9RzRfrTNVYrrUp6IL2K7yJhSxc6oijIeGPjxPEDABcCYXKWC5k/DPB1CN05X+HJyGiCgCnoaTp/OvduPXF67dO7aCz64m8X72QI1m42M4tvlHrx38a2AJcN1XKCj+sdAi7X1AYqmC02Y13QchEbwtVmdxpdPgReUG7i6Rgyq8ZzTfNxHhw+xcJHWW4ODwhmiT1yQzqhTvMbo5XJ3we06t9BwOccPBSZilFFlzKWbtmIQyB8oRqKu0cvXtBy9yjjJ/aFnuqF52xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN4C87Zg1ZNly58BW1OR4n7RMGd5KoD+gsBTHNoiuIo=;
 b=aYQjO6kNVocnPfuwB8JMU3XLLREcKjQVNV5heCS1qPlmBryVUZgCi8RZdJIh9ZLUzhKSfA8YSjtAx/FE8BIyOlVPwpG8/3W4Tro9nrKnmOVGFtaeiKrpjYjJfT1JKE9upDcHfj8dCjbphf3J9bkk6Vs/XBD98yXE1nHiM5gum+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.13; Tue, 6 Feb 2024 17:29:11 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 17:29:11 +0000
Message-ID: <873201d4-57d1-e856-87c8-08e2ca71f0a2@amd.com>
Date: Tue, 6 Feb 2024 22:59:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable
 IOPF
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-11-vasant.hegde@amd.com>
 <20240201214949.GT50608@ziepe.ca>
 <9d3579c7-66c3-3752-bad8-a8a8ebc5c74c@amd.com>
 <20240206163657.GG31743@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240206163657.GG31743@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f890a58-21a7-49dc-17d5-08dc273921ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uwge27Cl0aE6s6W57DHXnZf7HtQCTQHGRJWWJxBw1AcMH+Ruc4MNI8axNXAwNSKaUEnqeHBXuvQpnBLHt0C+hT81wQ4KAY7VXPY+06Pg2OVEYyq8nYg0V5XH2uq9DXTR3XlI3Js7T+O9ToHHEIx64/82b6xSeY0nBPhjg8g6mD4tuheqsdXdvs8pJJpRvrOzIJ+AYH2WLYiCGnyYsoMBp4D8zEnUdIvvgI5dJuf5PwTRBKs0RbZbjc0uzKWeoMbT/HqY6OV439UwmuF/Fx3EPuMv0NoJ4KXpi49Z3MlUSkgK0gt7ywRrffYYcybszcZ8VpZP6hStlavfr7yovS76Q0gsLIk8wjbrXaxoHmCnYE8xyjms/nQ4O/O6PXX8cSm8Uc6oLSZiZDVwmbBEHNEppkXyDaTwnvfQk4A3130xCHiUMmbbqj2gMdS2X72mTS+yGgw898tIMqNa3npBZDbuRAYlijtc+b82Yy7FIn1V/4Zzj35IOHXAckIYEba8L+pr6cvF/0leYSKlr1+Z6bHGDMSgBiPFL6znbjQMmeA5ltKo/M9+NY4LE55F7CR2EiLXLLORMHfjCqFWOULPKotuh7uwXi/+OqQI3Kl4fTyMTkahxIo0vN48f2K2EQQWI3E7da7IhrZUgkOpnU7gdeWZQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(478600001)(38100700002)(6506007)(53546011)(4326008)(8936002)(36756003)(66476007)(316002)(8676002)(6916009)(31696002)(2616005)(66946007)(66556008)(26005)(41300700001)(83380400001)(44832011)(6486002)(86362001)(6512007)(6666004)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGlNNlE2MVdmbTJHTHdzY3o5TFlRZk9lUE5TTE8yc1JEU3hJRTV0ZDRyQ2h1?=
 =?utf-8?B?U3NsZDdTeFpyK29EZHdpanYxZmZOR0R4a1ZkMGtOUytKRmpNNmpkQjRQakJr?=
 =?utf-8?B?ZjZTNS9FWnhHeWIrVFNHcW9mbU9XTHZ0ZU9iYXlJdnVYYUcraWxwREpYL1Fm?=
 =?utf-8?B?bUt3SWdaV0x0b29FT2NSSFhPLytPbS94UTF0VlErbFViV3pQVVNOVkJqTFZV?=
 =?utf-8?B?allkYU5Mcjh2SGhnSDdPZmZCSzRWaCt6MkZTNVFlNnE3NFFlN3dHQkZVanM5?=
 =?utf-8?B?bmZMKzIxVUtvVXplMHRJZDl3c1NQUkJwc05YQVFHdEQ1WEtqbXduN3VVMHNk?=
 =?utf-8?B?Qy85VmRtdndVb290SnY5ZVZTeGVKSnFjQnVMeUFJUGpZbDgyYkNmZW01azF3?=
 =?utf-8?B?bDdGS2ZZUjJmQ2JkblVBdVhWZG9qNVRmRUVzUThyTnZFWmpjT0JVTUdKQmg0?=
 =?utf-8?B?Z09sTFZRcmo0SllUWHhmbm1XalFoSTJ4eDlXVGVVZHpnMys0Skc3S0ptTys5?=
 =?utf-8?B?b1JuaWt4MUV6WnBXNHNYazhJZndsL3A5Qm9VQkZXKzI1cXhIKzVzdDczak5P?=
 =?utf-8?B?aUpDeGdWQVNvNnl3STJLKytjYWFYdDh5R0RoNkdobGU5QlhPT1o3amZEcFlm?=
 =?utf-8?B?ZDA1dURiU1AyUVdnVlhGSXhuV1RQZlFGb3ByZ2JTSVpaa2tqbzRIS3JKSEla?=
 =?utf-8?B?RGVuVDJiTWp3UUp3UXp1OHAxNjhSejZ2Zk45RWl4cTkzd0tzNmJrM2t4VS8x?=
 =?utf-8?B?aGh5M0hvcU1TaEJMTmsxRzN6NWZEZHR0NWVrV3FzK01oRHpnMzQ3QW1iYWRU?=
 =?utf-8?B?MHJpWG9tVzA2RE1HV0l1LzlSSFpnOGxNWXhXOVMxTkh2eERmTGtXenlJSzE4?=
 =?utf-8?B?bmx0SmsyZDRUb0pOcG5uRFYxelc5SHY2UlRha1FwWG1Ldm5SVTFRUGpZQTkw?=
 =?utf-8?B?aVc5UmtVaWVabUFWbEcvTTRxcHVvV09hZWFrNkR5dEVmUjdRd1NQNVdqWkZ4?=
 =?utf-8?B?dGwzSzlUM0FsaEVjMEpFa2FsZklIelBUZE10U2VETkpYNkZENEJUb1p5WUZl?=
 =?utf-8?B?NjVqaWF3VmJ3WnVUUDdoVHBub1FUYzJtdjdlcjJrS0tFNlNsaFNuS2ZMMUhR?=
 =?utf-8?B?dm5mY1FhOEdMT1YzZ0hjdjBEYUx6VUxhcllTYUw1NUhDVCtQUjVrZHA0bGFJ?=
 =?utf-8?B?VzZDeXJlTkZVV3pTcFNxbVUzb255VTVCa1lVUkkraE1OdkU2NTVSV20rR3Fz?=
 =?utf-8?B?Y3hKLzAyOU1YYVZLNUo2eFJGN0x6NjAzb3NGbkM3R05uNnhtTkRyNmNUSy9o?=
 =?utf-8?B?dXdwcElUSG02MWhYTmJLWEprVndPRWtRbVhwNEQ4S3FpVXpKRFlxR0NGZUVr?=
 =?utf-8?B?N2hkRVc4bGlZSDVnQUhTemFMdmYzNWZtV01ZQlVkZDBiVmV5c3RnQWp2MFEy?=
 =?utf-8?B?K0dGM0xFN0Y3cXZid3YwN2JzVEFvaDFrZEc2TlRjYTZTK1RJUTlXUnFoUmJH?=
 =?utf-8?B?UnE0U0FPZWFlall2ZGM2OWJNR1dWRjhyTi9nc0RMdVljbm00dGp1UnVlbkFz?=
 =?utf-8?B?ZmZpU3NIblMwZnVPT1pTYjNDN3pjNTRuRW5jZVY4aFMyK1ZiODBGVnpmN1di?=
 =?utf-8?B?a2ozOFNXWnQ5aWZyL05XeExZTlpOYmVwUHZIM0RxUTB6Q0JBSHlUOSthc2E0?=
 =?utf-8?B?MGJYbjFxTkRTREMwRlVYMFdtWWc0d08rZ3VyS2trc0Q3VERDaWh0UWdqakhy?=
 =?utf-8?B?clpHcGF2NjlRZ3hnTVJsY01GOFY2ZTdmcU1rOFJmTEtaaVAwUUZYbkxER3FU?=
 =?utf-8?B?cFJUN3M5RURwS0RKS1lCM0lSYTJmTExhSkhuMXNwdE1PY29wOGRyaG82N2JO?=
 =?utf-8?B?eGQ0SlVMMkZtd2xpcXFrMVMvVTNYOU5Yenl0enNsWHU3engrK0pKWUxlT0ZX?=
 =?utf-8?B?TkhuSkk1ZE1DZkpOWnlhekFQejFTd0lJOWVPaC9nUCtXTG16ck5sWGljblhI?=
 =?utf-8?B?Tk80bFBtZElzMFlzam12VkFZR29ibHBDZlRnckdOc2xsSmJxTXhsc3NHZGxY?=
 =?utf-8?B?dzhQK21TMXY3NmtxTFgzOTlmT0tsWktaZ0ZZZEZJR09MaUxlQUxORUVkeFJV?=
 =?utf-8?Q?oTH1COHoM6eO9tgEVacWmRnyw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f890a58-21a7-49dc-17d5-08dc273921ae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 17:29:11.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKmLayMZ7u4J9GYH+R903hD0QHQ53P5boGqP3LmJsSHzvV3B3JVHf/zFVb5Wmt6tCCEI6fc4Wp2ykJMo8q8YfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418

Jason,


On 2/6/2024 10:06 PM, Jason Gunthorpe wrote:
> On Tue, Feb 06, 2024 at 09:49:36PM +0530, Vasant Hegde wrote:
> 
>>> This dte change is in the wrong place. When the domain is first
>>> attached we know if it requires PRI or not. At that moment the DTE
>>> should be set properly, it should not be set wrong and then changed
>>> later.
>>
>> We want to enable PPR support only after setting up the handler.
> 
> That's backwards. It means error handling can't really be sane..

Why do you think enabling feature only when we are really going to use it backwards?



> 
>>> (and again the whole dte setting flow needs cleaning, I think you
>>> should do that before trying to build more complex stuff on top)
>>
>> Yeah. I want to fix few things in that path. But that's outside this series.
> 
> I was looking at it and there are many security bugs in here now that
> iommufd can change the DTE at any time. The current design assumes DMA
> will be stopped and ignores the spec guidance on how to do a safe DTE
> update :(

What security issues are you referring? Can you elaborate?

> 
> I'm really not comfortable with adding more stuff here until the
> security issue is solved. Especially if the more stuff is drifting
> further from being correct. If you can keep the updates in set_dte
> then maybe with some reluctance. But not like this with random touches
> to the DTE all over the place.

Currently all DTE update is happening inside set_dte only (dirty bit enable is
an exception that may need to moved inside set_dte). This patch just invokes
that set_dte and invalidates cache.

-Vasant

> 
> I was looking at what it would take and got part way through. It is a
> very similar problem to ARM and I drafted a similar solution.
> 
> Jason
