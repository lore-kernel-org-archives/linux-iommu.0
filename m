Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84211DD0E6
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010746; cv=fail; b=H4FAJy1x3tJNQVPyeynMfpr5K/6c+AH6rndebUc0jnb1kTlxJ6HAt02MUq3ZPFKjDNEqDYQ3Ka3M/lwCQWIhw4LwOyBwJaLUNZ13iGU5zv+k0KO4dwmck+GoJncA+n4W9o7/U+TAclZYfV5EQ2y1Kcyzvf2EBnOTVcnCySWD6Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010746; c=relaxed/simple;
	bh=nx2Q1ZvGlbkowxcBq4EB0ZcG9lpi3LSXzOq6GxTy0YA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dBTLlF3rLY/CHKu9NiJnfLClGlbeUTOkyN8WM0m5M+fHhLg+yaSdwqX7wtg0kZdT4JHphT1lf0vF8VjDS/8qqe+t2TsiDdSP4prNS62pkg6awwpwHLQTBO3kNIVybhYBJGuwDQQB/PqYDydHl8Uq6fP1HBBIDLYY2e9HwDBKgGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hQAw5i9D; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hQAw5i9D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GR+NpB7dn8M5QP5TcXG6wif64Tek96M45wbAgl7B5rS5UsUVurCQ1IWyBQiUNL+xWxNN8yQJ5izmQSejhpYyWeB+ZD2734Lvv54bTVizGDOdvdc1qqvcKLTD0tHoSHcpTZRQcQSlVAPKe4kzPQ4GkMhlekps8jRMhOfRQN8WoADrdmjYSvH7JwAtC+K2LzRTIFUP2XTPlJeawlu3Wl3HPgWkj9cuIEOw7jfixWhQW7ooYde3gVmabhnAtGd0z/g3+D18VhI6G9ImgCzpKKMYf05JVrRm/CjONm657aohmCv0/tErfnIRUHn6mEhVnNAs8YeatAVctWq5FtRHIyNnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w39jpyu2ljbuSwZJaq2a6KTuagd6LahE7u+AC+j5DFw=;
 b=h6jIGsnWouIS4bgS3/dpA4xfWEmweSQZa+8H1NPVrAfmd/uqpQS+nwSeko4QDSUHYZwmRS64anb59+tNDhacA2+JOGe/PokGlUGVkthUL9kfVJah9tCSPx1Fbtm90EPRaRAeNLlN5kjZ3spTdP+JO+DNwbjO37wUjXvwj7i9BYlreHOEhHGIP6GwPddBPjdPzF3dK50IUS2YY/S13t1LF28XnKOmdItq8xSrS0c+utHCHGy68ht8r+vDwF+28Vdp1gveFjEdhym7xleJ36avuS1Nk/Nqgd9iWW1fjASdM9PG3Z1i4c45RqpU8wknwBgJVnilLj57X8NhA5dTALOYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w39jpyu2ljbuSwZJaq2a6KTuagd6LahE7u+AC+j5DFw=;
 b=hQAw5i9D4VgAQf6dAjFDYHIFCJGaXNj6So524vl6LKF16z0g/1IjZYMMOO7livnQ/54o+a62awh7c9lVfKAw4eqcuc0kHLCK+r7nObFK4x81AJPHYecti3iHaCTJ7vfClxzd6YKPaxH/00S9Xul9IXBTaWPnUC524anvVYBKg5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 15 Oct
 2024 16:45:37 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 16:45:37 +0000
Message-ID: <62782c52-4bb7-4981-8158-9eccd589e50f@amd.com>
Date: Tue, 15 Oct 2024 22:15:30 +0530
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
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241015161258.GN1825128@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::8) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: e9beca56-5f87-4502-7fcb-08dced38cb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2pZWVZ3RDVmU1JycGVDcGt1dDRJUkt1eGN6RHU5QjZ0NEFoUUN5VkFxM0Ra?=
 =?utf-8?B?cHhPQk5GcWNEalpQR2QwaVQxc2RMeG0yYkFkUnh0WDZHeFNMdHlUaTVoa0tO?=
 =?utf-8?B?OHpvS0pxU1lSd0x4Y09tTkFteDdySGNtRUxSNjhhS3A3amZZUWpodW1kOW5E?=
 =?utf-8?B?VDhGbGRKbk01M3NQcWJBZkh1L3BrQkNUa1VNZmtmbWYvM3JKMkJuQitnbjFz?=
 =?utf-8?B?ZHNqalF3WjVvOUJUdC8rbE9TbGgxNkNwYloyZ0dYL3l4MmJUZmMxWGcyTy9j?=
 =?utf-8?B?ZHErT3M5TCtyM01zdmdSRWpGeWtETHZUbTZiOFJlT1E4cTlpM0JUVzRuWkhX?=
 =?utf-8?B?clFhYXRZNFpiVUhPVkMvZHpidS9iSVF0VUl2bVA4ellKb2M1aU4wcVdHWk83?=
 =?utf-8?B?QUJCcENLY1lYeFg5YXhOMjRkelVhSkNpbzlEN21YYnI0cnREZ1A5TEkrczZI?=
 =?utf-8?B?OG1FUStubGN2dWRiY1N3VDh0MnZWMS9NcFgwd2JTdEZsZytYQ3gwNXZOUnI0?=
 =?utf-8?B?MEJJbHhrT2lsWWFPSGFkWXpRVytZSFhmSWdmeGdkZDZpckNKc2txamRWNW41?=
 =?utf-8?B?WWpseFFlUHBzVWFNbmg2N3p5cDR4aGJkRmhSOFBsdnlLR3hQRlk1QVhXanRQ?=
 =?utf-8?B?cFlhQTJMV0ZaODBuL0pGQkc2RUh6bkIyNnU2Sm9palBpUnRYaTNiVWFwWENo?=
 =?utf-8?B?VFpCb3hwNk13TWFmQ2llNXJTTHZPS0J0R3VGeG5kKzFpejdmMlRmeUUwMncv?=
 =?utf-8?B?aDdNb2o0cTVZY1JkOXNnbDFCWHlNWTRCZExGaW9IcGtzVjZPd3ZuRlg5OERS?=
 =?utf-8?B?REZpNHo1TGs0ckdHbEFCY0dZT2FrUFM5V1RncktVcjM1NWdMSStGN1ZBUVUy?=
 =?utf-8?B?OC9meXljZWczOW9QbFR5WjdjMURONThRODBXNnhtb3MxanhFdWU4d09pN3lL?=
 =?utf-8?B?SjMwaS9wVXRqUEVXaWRUaWUrRlUwTGprQ21yeW1Ob2xTU0xrck5iYW4vS2FF?=
 =?utf-8?B?Z3MvSjdwVWVKcEZDK2xSVzlOSXVQM1pYQ2VicGZ0bkw3SUNPb29zY3FFTXJV?=
 =?utf-8?B?YmFLaFJMbmVzc3JrWG9DY084ZndvR29UVTM0SDUrRmdxdHovMTV4M0hOREVk?=
 =?utf-8?B?Sm0vT2JZaW1aSUdtYXd2UDZlU2EwYWVNZTJLdnhHb1RXY0hOU1ZaY1RhNnh1?=
 =?utf-8?B?UjRReDIxNm5mR2xVVjd6VVd3R3pTcGo0dGtyTWo1Kzd2elpzUlJVUEU3NjBV?=
 =?utf-8?B?a3F2VVVpMnlZT1EwNWhXN0dGYUZ5eGFEWk80YUdCTFl3VnRMRi9UYzBRN3dz?=
 =?utf-8?B?Y2p4VHJHZDJraXpFN20zSHJ5VllNay9PVXRmdVR6ODBLK0dMR0xKWVRHd29D?=
 =?utf-8?B?cHp4RmxnMmxOYnlNdkRxTjNZZmtGQk9CdDR3enpUTGx4STB3WXc4L21NZHhp?=
 =?utf-8?B?NEJWTXppbG4rYnhsQThYUkxDOHd5enc3eWdDQkJFT0xjVXVJVnFWMEw2MUwr?=
 =?utf-8?B?Ry9vWk9qSmxiNWZtQVRRemZ6WXdnYjQvU0puWEFGaERsY0c1MkMyZWU3ejhF?=
 =?utf-8?B?TWEvOGdRVG5VemZUaUZxVUgzRE4vMzVUbncwdERwaTlOR3lRV2QyQmJSeW9X?=
 =?utf-8?B?M3Z2N3dKQTI0MjlYU3FGUEpWaTBKUXRqNzV5S1BadFd6eXl2VG9uMzRqQ2ta?=
 =?utf-8?B?UVlsL3pTa2tXR0MwUmxQb0NqS1FyMU1XZktxd0pkK3Uvamhuc2NNbFZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWdsUGI4MVVoc0JNaXcwUzRtWWdmSnhObHUwOVY0ZzBxK3ZPV2lmZSsxK2Fm?=
 =?utf-8?B?UVNEOTlIYjJDRE5rMVI2T2tPVTJwNGlRWUtkRVFzMVFRREVKWUhBaTBwS25V?=
 =?utf-8?B?OW4rYmxvWEtEbERURnlobExzTWUzT3JXRDFSZHVkSE0zN2RvOXpxRUYrbzhH?=
 =?utf-8?B?b1krWHBSdEwzRG5xT0V1SWQyaXoweUhWdVY5YkNaN2k5SGUvZURqNVRISERI?=
 =?utf-8?B?Q0dNSm1JUm8vRnAvZG5QNXZ6amNlTmVxVFVzY1F4azhhdEk3cU83SDFqYm1P?=
 =?utf-8?B?RmszSEg3Uk9rUS94c2tCVnRtMnM5RnFMSlVTQ0NFdTkwaEU2Q24waVdpTGww?=
 =?utf-8?B?TUlYbDFFbVZPWlN0R2xpK0srdHliU04yOXh6VFVlN1hHSjlhTkxrTS8wYTJ3?=
 =?utf-8?B?ME5HdEtoQlpNa1JYTVczTndBL2hqK0tpR0pNR25GM2p2emFKd05EU3Y5bjEv?=
 =?utf-8?B?QVRKOUlEZmo1R1lTaWFrM25LZWNMNUp1alBXMk96YWVmdE9KalN3ZVY3VDFw?=
 =?utf-8?B?ek1XZU1CWVdTcGRyNkZiYU9RWStNNUdwYzNUSENtOE5PYlF0RU9sY2EzWFZq?=
 =?utf-8?B?UEVEZk1EWWNqcHRNMEczRWROTWJkT1RPTDZUTEtSMHRZVUpQRWM5S0ZDNlY0?=
 =?utf-8?B?b2NHZmE1R3BLYmNiRm1YaEZSRVdsZHZDNTlyQ2poZnU2cGVERXEwNDRCZVNN?=
 =?utf-8?B?WGhRVVc2ZkdXSWdQT3cvYjJnSDlvb2doNk9MZ1BaS2JhNkoweEVpSVkrZFhi?=
 =?utf-8?B?c29VOHJWeHRxSVlhWmVkN0E2SE1NYk12TXhITDU1VnJOcm1HVEdrVmF4Lzkw?=
 =?utf-8?B?QnRIdUpZRTlIcXpJdnNEeDFRM1hTWUhvOTFKSVk4Uk5DMWhkNHovd1ZxN0t3?=
 =?utf-8?B?OW9BOGNROWJZQlZkbFRhVHBYV2Z4TXAwSCsyU1NNc2ZBeXFxb2RrV0NpajJ3?=
 =?utf-8?B?eFVtVzZnU3BKTkcyNlArczZOTjRqUytUbGtZNUd5MjE3aXFiM0UxcDFPZWx2?=
 =?utf-8?B?cnpHMXN6aDB6dlZJYTZoUUZpWGdLOVY4OEx4TmVra2c0Q0VVY1hScVpudUll?=
 =?utf-8?B?U3JuZTRqcDF5S1RpTUJBWXZoV1I2ZUhRd09weXRHN1JSV0VGU25wd09jMGIw?=
 =?utf-8?B?cUlwVUVpM3FsZzJuWk1FMlhZYTFnL0hvamJVeFdwOGw2SGYwcXIwdzZVUTRC?=
 =?utf-8?B?YmFKM3cxSlB1aEY2Y0taczFqWWpUWDJUMUowbXZMdnRLclhLRHRDNTFObFJT?=
 =?utf-8?B?NDJvK3FhUWpMS1ZZV29rSkNpZVlBZDhWU3VFaGZlcDFIRTNBMExLWU1xOFFU?=
 =?utf-8?B?NFVuYW13YUdTM2NlYWtyVnorUXk1U1VKazlScE9URk5zdDVSaUtERys3TVJM?=
 =?utf-8?B?Q1JNZWtpb1lOVzJtRTdTR3hNb2kzN1JWN3pSOFBIbldmRE9WZVpocVFPWUtS?=
 =?utf-8?B?b3c5VVAxK0YzRXJjMVRRM1JOb0YyZFhRWEZXOFF2bUlBQXlTaHYxdjNzTXZ6?=
 =?utf-8?B?SzVZdlVScTRVVDJZNHYxQUpoaXVTbVlxY1NBdE1aeDlHL3hMMHNXZGt3OG04?=
 =?utf-8?B?VXNxUFNUeWZWRXdZWnI4bWttYTZ3MWV3Y3kzRzFIQ08zbW5Oc2pTNFIySXpU?=
 =?utf-8?B?UmNMSDgxaXp4UTROS0ZuN1o0ZkR4WXF2MFlhZ0R1V0NhWHBsc3BwcVZ6MW1G?=
 =?utf-8?B?eHhaV0JSTnFBOU9wc3BObmZvWGoxOGZsTjF3NzFzdk9oWVMyMTRwTFptdnBj?=
 =?utf-8?B?WldnZHNYeUgyUU9ZKzVvTzlxcTE5UTJmQ3lRbmc5VXVEQ1RZY1plTDFuRnZ0?=
 =?utf-8?B?bTlqUktUMy9xTFVKcEJIQjhGcHRHakUxWk9PYk9GUHVET2pYSEl4V25FSmxv?=
 =?utf-8?B?YzRGdlRXTFJxRTlTT24ySnNPQTlCclVFWnlDenR2MmZSOGtiWDJwSlFrTXdJ?=
 =?utf-8?B?aWkrcks1UnYvMHljQmY3elpObjUrMGVjSFJwSWJBZ1dvcWFHYk1GWkJZQ3pC?=
 =?utf-8?B?ZkpDbEV2ZTYyVDRPSW9oV3pWdk1DMms1SXphTlNCUnpqOXpJU2ZCYzM4NjZM?=
 =?utf-8?B?S3NkNi9QK1QrS0lFSHJjUkdkYi9VQUFuQVhMVjZ4MGN5TldSNlNhcXkrbjFN?=
 =?utf-8?Q?+Gi29KfXKfZbcN9V8VzLmJOCW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9beca56-5f87-4502-7fcb-08dced38cb9c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:45:37.2259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYi/NkfFVrhjqklEmSEgzlFeEtZwY2c4/+XizMMUc6nYGNXE6RJDhHj2wtGotSCOpTmgQR+qUCKMCv+hFDFaRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239

Jason,

On 10/15/2024 9:42 PM, Jason Gunthorpe wrote:
> On Tue, Oct 15, 2024 at 06:00:25PM +0530, Vasant Hegde wrote:
>> Hi Joerg,
>>
>>
>> On 10/15/2024 2:08 PM, Joerg Roedel wrote:
>>> Hi Vasant,
>>>
>>> On Tue, Sep 10, 2024 at 06:58:08AM +0000, Vasant Hegde wrote:
>>>> @@ -2119,11 +2135,8 @@ static int attach_device(struct device *dev,
>>>>  			 struct protection_domain *domain)
>>>>  {
>>>>  	struct iommu_dev_data *dev_data;
>>>> -	unsigned long flags;
>>>>  	int ret = 0;
>>>>  
>>>> -	spin_lock_irqsave(&domain->lock, flags);
>>>> -
>>>>  	dev_data = dev_iommu_priv_get(dev);
>>>>  
>>>>  	spin_lock(&dev_data->lock);
>>>
>>> This patch inverses the locking order of domain->lock and
>>> dev_data->lock, have you checked all places to make sure it is safe to
>>> do so? Has this change been tested with lockdep enabled?
>>
>> Sorry. I missed to explain this part in commit message.
>>
>> With all changes locking sequence will be :
>>   group->mutex -> dev_data->mutex -> domain->lock
>>
>> In defer attach path (iommu_deferred_attach()), core call attach_device() w/o
>> group->mutex lock. So I retained dev_data lock.
> 
> deferred attach is broken to not have the core code take the lock, all
> most all drivers depend on group_mutex for correctness.
> 
> I think we should fix that, not retain unnecessary locks in drivers :\

If you recall, I had a patch to fix core code [1]. Robin had a concern and hence
that patch was dropped.

[1]
https://lore.kernel.org/linux-iommu/aaf7b619-1826-4db2-aaa6-235a25f46299@arm.com/

So for now I will retain this lock. and if we fix core layer, I can have patch
to drop dev_data->mutex.

-Vasant
