Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415B2209D
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967467; cv=fail; b=UXuT0JOhH+vit7RkhEDf+qVib6MrGaaNMcwMErfAGIK/oLiTnCDFQyIqRsuapt4lRJBKdNqQoH9n33oRQts9iMcIIo3oQdHfQnDd1/AeQ2Q0eIhImz00pwejUFy4nmWLP3fg5bcycti4iZkLXJD42b7+9NbjNohdUh71zigEOd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967467; c=relaxed/simple;
	bh=DIJqdyBJ1JhXOI5tvAz2zvXH6t+nNr5++GS4bz8fpOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XXXi4GckpzZSLwKvEM6vrk3qKcFvtwjyJ0M26oMIRREOW3t5pgM5G311YHSiinpF2SlVaK8w9D6458erm9Ti9uKQG8p009WHjUEtiGt2NEb+JuiNDb8BFRxN6sP2J17w4vORFeAf7e/i5GKkteeFWn9wjSMZLS7xvqZfWVzzxlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tKnCCe+r; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tKnCCe+r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC0MkCEjbMzC2a4lzySdTrZMLwFjhciD7H+ikXqTJy5eMzv6y0Pef6aebdmqG/kEqVu9GxATDuvBHB3uP+Uu/nVlvECs9FfDKRypv+ZRrnfXPv29QB37OL5r0BqpBq2jdEWwN1cczDkR4S7cuhPpM4GMXq6gpKSMfld+R1ngCQcKUFNN5BbJBaL5LAccwuksKBsYazsgfO+4DCzWrmeGIXMLThS5uAw55sMZOWUhLQPGhlHF63WPrHqc10tzUk5aB0L1ld/tSzgBncLwC2YmUg290Yx/Io7IF+1ntVsES4th+bDPu+v1bSkU2PbT6masMr375R/1jzCvw1qfMEcqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CRN238nmGhWuCropGOlCCMCo3NGaDeWGvG1eGAqWbQ=;
 b=hGCAFFLO31ySRCW1B6GlEbG+bL8959gd2G7KlCHS2pqiz5OssmbGGYH4gxEqkiKPXgpRP0NuuZhYNWsksXfv2rmg7M4n0rLVVoTY/IlZYnY/k3Bfh7nmzHRch+SReyopB3uZj3lQQhe+wONHKVQH+/suSFOapGtN2NFU/K227rwekBsVOXIFl0wYkNlYid0QADrNLvAwxxfSmbGoLdcHMLajMrKEsakPN8AP4UvCJ6OBOlLmunHY+VdHhB9BIdpNznRluoA+W770tWx/0dvbh1q6IKXnnZklCISBgBZ3P5qjLzndeIpspZ0lyh/I2J1OMiV1f0sF6d7T5r6h85v6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CRN238nmGhWuCropGOlCCMCo3NGaDeWGvG1eGAqWbQ=;
 b=tKnCCe+rbaVi0eqnlaCGwoTuuLXo7vfJabiG3d1HXH43emnQhhaol7DrYIBOkoeRoMtKmMSIBcX+DjXD960SUFY6ZzgVQHhhEg7OSLOPbCt8WMbYmzXZ/3wLJMxyrd+K01ZyFLQAqsY/SbofeUpK9IP8zUJ5RRIqrtYWv4kJ/0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Wed, 29 May 2024 07:24:22 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 07:24:22 +0000
Message-ID: <029a1733-4e7e-4deb-92d2-874040679bd2@amd.com>
Date: Wed, 29 May 2024 12:54:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Take group lock before attaching device in
 iommu_deferred_attach()
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, Lianbo Jiang <lijiang@redhat.com>
References: <20240528163940.48789-1-vasant.hegde@amd.com>
 <aaf7b619-1826-4db2-aaa6-235a25f46299@arm.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aaf7b619-1826-4db2-aaa6-235a25f46299@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bcd989-2bde-4ff8-abd3-08dc7fb05c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmhGYm12dTRBNDNibGhicHJBckVtcHI0NW0vZWJjVys2YnNpb0tFSHBmd09J?=
 =?utf-8?B?Ky9maXRjRWVVS2Z5eFpwdnFhL2IzdDV3Z1F2OW5rOEJVdzVDTURpUzNOZm5V?=
 =?utf-8?B?MGM4aGgrLzNLQ2hVMHBTYjNyR0xJYlphOXQwUGM1WTRGTExTN3NDYjY0VFlz?=
 =?utf-8?B?b0N0RDVnaHExWHNqTTlHeHpVS1JaV283Q2svamk2UC9zSEZlKzEwVnlwZnVO?=
 =?utf-8?B?TWV4R1lNK1RvUFU2ZVRGL0VyajN4YmtUS3lrbjRsb3Vua3M5WE5pT0w5K2NX?=
 =?utf-8?B?bXFrQThPSVVvSW9RMU5aVktMSjVHZ2sva0krUW92cjNnY25zOXdYMU1JTWp6?=
 =?utf-8?B?U2UyTXFSVkZjT0h6bmkvbENhbndTamNidVdQZEZaV2ZQaGZ1cVR0TWdneGM3?=
 =?utf-8?B?eVRiZDAwRFdFQ1hjSGM5eTAzd0NUd0Rna0VLcmJnODIvUUd1eFZwYTRHeXhk?=
 =?utf-8?B?TW1YQnpiOEdFRVdPZ0NITCtjbWN5bVl6YUtPMW5rWllBTG1kTlVXSmo0MzN2?=
 =?utf-8?B?andVQnZUVk1CbCs1MU1pV0FUSzRtczRWZkUrZFdNZUxha0s5ZUFHbGxWQ3F0?=
 =?utf-8?B?MkVZT1RqYytSOXNkOGwyZVRlTE9mUUtsSDR3eVkrblRtVS9DajdjenhDQ0hh?=
 =?utf-8?B?aTBxNzZiaExQVmlneS8weVRMNWRoVkw4a1hITUhxNEJEbXhmUjlURXJhdzJP?=
 =?utf-8?B?WTdNUi96TzdwVFZlSG1SczRTSS94cTRBOHU2TE4yTFRrTkY4aFFGMGgrdnNU?=
 =?utf-8?B?Ynl4UkdjN2FRbGVPcjNWVnJKRjNWcmpRcUNpcEYyZGJpYjV2dHBMWWhtQlRB?=
 =?utf-8?B?L3RONkhaVk5TdTg2Q0JydHBZWkVaRWx4WkM4TitjNW55blc5c0IzVTE0OVVo?=
 =?utf-8?B?T3VGTkVYWVJ0VGJTenUyNEZFd25IU092eEpwN3hzNXZKK3N1czFtczJCcFdz?=
 =?utf-8?B?dEU4UFBIalk5NnJGN0d4OGtKMThvczJoU3I5Rnh3dzc5RWxCcWFjeGhCM25j?=
 =?utf-8?B?UXd0L2RUT1lvOGpJWjF6MWhkbVdpQStkRUY5bUR3QVdTTmxjL3RKcG5MZGl5?=
 =?utf-8?B?NW5CZkwyVWsrN0N6Vm0vbU80cDhGSnNDRVByL01lTFlhK0cvd05XWjZHK1ZP?=
 =?utf-8?B?UHhVL1pmY0tGNk5SWm82ZlhDZTQxdHJNMW9zbEZobUpzNkxMRE1TcXpweVA5?=
 =?utf-8?B?eDNXS1NvUGtNd1FhKzBZenMrSTNtN3pkR2tRMWVES0JZSUFJeVVjK0pnL0tj?=
 =?utf-8?B?eEhsQWJMb0w4dlFPNHA3OTJ2SWFSVExyeU5YbVczcnJUME0xNERMSS81a1ZE?=
 =?utf-8?B?NXhjUGtLYWRTeDF3MVZZVldKdUp3emZteGcrajFjTEdTRzJWcUp4L0o4SmJq?=
 =?utf-8?B?dGIwNTJpcnMzeTVVUlZ6WHRra1lCZkp6QlgvOWRRV0x1a1VQNENZZmxCZnBT?=
 =?utf-8?B?WGRhWnNPd0czS2pyT0pJZnM0WnorNWRhWEpGV0YyRVFxeHVuREdyYjNsM3RH?=
 =?utf-8?B?VC8zZXVPdURHc2IySW1XOGx0STlUcHUzNXVLajhvbHJ1SnFBampWZkRMWDBK?=
 =?utf-8?B?dkszN01USU9jWGMzKzdDRTVDWGJKMHNXbTI5S2hwb2tDTkVmK2NmeGFHeWd2?=
 =?utf-8?B?ZEdINDVETW9BMGI1VWFkYTlTajd0RzJvZ3l1K1ZJTk1ZNmh4UThTM0Z5dUpI?=
 =?utf-8?B?T2o2SE53ZDluWGM0QllmemdSdnMzaUFhR25rc3BOcmUwN2ZLUlZDUWt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXltUExBK0VoSm4rZ3BJbEZ2U3MxTTFpa0g0NVJlYUs4MU50OHRDR3dER0hE?=
 =?utf-8?B?Tk9UQUk3Rmp5R1pUa2VBR0dyUkt0ZDN5MlpxUlNFczUvZ041cGRVQ2FSZGky?=
 =?utf-8?B?enhXRzJnYW45aWVaejVQdURCaHcyTytGZFBwRmdKVzhpSHVCR1psTEFYbzRP?=
 =?utf-8?B?cnpUejNuOUxsVnFqaUwyOVp2V1RudHJHSGRpMDIydkh3NFg2NVpURG9Xb0l6?=
 =?utf-8?B?M3ZtMkZhemxIRitBWTVmUVJpVG5udzVOTUdOOEhZdmlWZmtldkp6V3JHeU1L?=
 =?utf-8?B?ZWt5RExEQk1CejVaUUxzVlJIZERydGVrUjNSOXN6aXZpYnMzMTBYcCswNEZH?=
 =?utf-8?B?ZlV1cVY4Y2phRjJaSUdVMFZ3clV6OFJZU1A5WGc3TllJbVhHcUVrRlhTVEFj?=
 =?utf-8?B?QjkxY0ZwLzhRWEJSK09sa2lyTFZ1SndkMXdNeHdIbmNLbXo1dUtINHJGcHUw?=
 =?utf-8?B?UEU1dEFnZmJxY2lDckRORjk3U2FsOXNhWGo5UStUNmtJZWJoMFdWT0lnUEpE?=
 =?utf-8?B?Yng5SXJOdmNIaXVOTTc3T1Nlck1iN1gxenR2TGR1UEJmNHloZVhYcllqZ2l6?=
 =?utf-8?B?M2FESnJYZG90eWlLQXhyU1FRWDdndmtLbEg5ekN3czkvMldwUHNPTzBoa2ZL?=
 =?utf-8?B?RHNEWlNEOHJJUlVZVm55aHlPWmN1ZkZFRkdITmxqRFA3eS9TMEFpRHhEcnZV?=
 =?utf-8?B?ZG9Nc2ZuNzREc2N5Z21EWkVubGwwczUzU2hleGM5dDQ3TDFoYmF0ZWJ4YXhs?=
 =?utf-8?B?dTA1aXkvM0tmSFo0TzBzdDV6UGN4OXBrYjg3MVRrc1k1RGlhVGZoLzhRMy9z?=
 =?utf-8?B?ZE14Y2pXclpVSW1KdEZ1c1B5ME1hZU1nVTdobjcyaFN6akhRZnhHU2NKRDdW?=
 =?utf-8?B?Nks2bmJtYjNCUFBQbjlzMEVtc1YxNWpDVTVIdFBxNGRyU3Q2RUtlYlNpRVBF?=
 =?utf-8?B?R3RJZmYwYVUzQkZPVmtudWJPSFVPTlNNVlowaVBrMGVLZkl6OHNpam1JQzB4?=
 =?utf-8?B?cVRUUWtKMk1oaTQ2SmlvMXV5SWJmQXkzRkE3R2h5WWExRzM5SklINEpXODF6?=
 =?utf-8?B?MFZ2N2N1ek05cEtWZ1hiRDZPK21KVFpVcEN5ell5Q01OUUF5WFEvSjBPVXBp?=
 =?utf-8?B?SVg5bE80bzdBbEV0RkFWL0FyUFZiTGhSYWp5MHFETVU0K2xNWW9PcHFVWWM1?=
 =?utf-8?B?YmFiM3hFMzFsWWh2VGxkQXFLZGEvdnF4bWZCeU5WdksrOW9VbURrdUJtUEY1?=
 =?utf-8?B?WllITHJZcHRBNVFlNVRxcnBwV3RLdlpHa0c2ZmN5T2JJRjROdXhxVjZwT1Zv?=
 =?utf-8?B?OGhtakFzdEZYRTBSN0lBZy83NXRrdVBRSlo2ZnM5Vk5iU0w5R3hHbHdUb3dF?=
 =?utf-8?B?WmdHSi9DM0lNZWdKeFZCTitta25LcVNzZmxYK2xxdWx2bld2bDRNQjc0ZHRT?=
 =?utf-8?B?YnlVNWJuSVZoYXFSQWJSdit0VFJ2MUtRakxaRisyQW1aYzFlY2thSzA3TjQ4?=
 =?utf-8?B?MUxhdFh4aUgyYlA4c00rbnR6ZEZMcEg0WE93OHNOWDZpR0tXeTU1ZHVGK3R3?=
 =?utf-8?B?d2ZvcU5rSGNmUHFobEt2blVkL0YwU3ZuRFpXdUtaTDNZcmY2R0RNQ1pqNlhF?=
 =?utf-8?B?c0ZMalYrbFVDYTJBam5rbkpPMzUyV1V3Yk9sTnhXTW5XZTBVN21hNG0zRFJV?=
 =?utf-8?B?YjI1enRBT3NZcldSQmhvekw3dHJBRUFETitjUEowTStZV2d6K2pKbGZqQmxR?=
 =?utf-8?B?eUJJK1pYSUQyR2pmNXBSdWI4dlZRT2FaclZ2VmZVcDJlU3FFRkJYUUhLZGoy?=
 =?utf-8?B?WmhHWEhuU0dtZkJPYld2WHZVaE0vNmZJY0hIcUkxRUkxeGphSnp4ZnltZTNU?=
 =?utf-8?B?ems1WWQ2b1lyRkhBQ0hmaTFLSVFkSWd0cGxZWW9nQWorK1JqaFpqN21FdjVy?=
 =?utf-8?B?eG1sSUlqY0pwcE1YTkx5V2doN0RVZDArUnRmaEZJYzFRb1BJMmlvRFdZN1ZR?=
 =?utf-8?B?RUplb200dDdsRWI3UnlvZnNXRjBoaXJQaGlrenNtWG1ZeDJNTzBYaGNFUlFB?=
 =?utf-8?B?ZlZwVEpQa202WnF6bmZibHRuMnRMcU9oTkZuZjFrWitSNXV4NTJVUWpKTWJC?=
 =?utf-8?Q?1kB1z7faJMBnSDi40dtNDqIY3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bcd989-2bde-4ff8-abd3-08dc7fb05c79
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 07:24:22.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMbaHF+mYtsAmfyKZmH3rfU8c89+K8KBF94dSi2MGTNo6tSQOiwt8U4E6nfOOTxXJiAJfhl8f4k2yUTInn7e9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080

Hi Robin,


On 5/28/2024 11:36 PM, Robin Murphy wrote:
> On 2024-05-28 5:39 pm, Vasant Hegde wrote:
>> Commit 3ab657291638 ("iommu: use the __iommu_attach_device() directly for
>> deferred attach")
>> replaced iommu_attach_device() call with __iommu_attach_device(). But
>> missed to take group lock. Take lock before attaching device to domain.
> 
> Why? Nothing here is even touching the group. If we've reached a deferred attach
> then we know the domain is the default domain already initialised and set as the
> current of the device's group, and the device is already otherwise added and
> holding a reference to that group, and a driver is bound to the device in order
> to make the DMA API call we're inside, so nothing should be at risk of
> disappearing under our feet. Please clarify what purpose this locking actually
> serves.

I am sorry. I should have written better description. I was trying to see if its
safe to use  iommu_group_mutex_assert() in our driver. I did audit the iommu.c
code and saw this one place it was missed. I just looked into git history and
tried to fix it. As you explained below I should have looked into the caller of
this function in detail!

> 
> But then there's also the fact that the initial DMA mapping operation which
> triggers deferred attach could legitimately be called under a spinlock or in an
> IRQ handler, so if anything it was a bug in 795bbbb9b6f8 ("iommu/dma-iommu:
> Handle deferred devices") to ever use iommu_attach_device() (and thus involve
> the mutex) in the first place :/

Thanks for the detailed explanation. I will drop this patch in next version.

-Vasant


> 
> Thanks,
> Robin.
> 
>> Fixes: 3ab657291638 ("iommu: use the __iommu_attach_device() directly for
>> deferred attach")
>> Cc: Lianbo Jiang <lijiang@redhat.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   drivers/iommu/iommu.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 9df7cc75c1bc..1743dba023b6 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2114,10 +2114,19 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>>     int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>>   {
>> -    if (dev->iommu && dev->iommu->attach_deferred)
>> -        return __iommu_attach_device(domain, dev);
>> +    int ret = 0;
>> +    struct iommu_group *group = dev->iommu_group;
>>   -    return 0;
>> +    if (!group)
>> +        return -EINVAL;
>> +
>> +    if (dev->iommu && dev->iommu->attach_deferred) {
>> +        mutex_lock(&group->mutex);
>> +        ret = __iommu_attach_device(domain, dev);
>> +        mutex_unlock(&group->mutex);
>> +    }
>> +
>> +    return ret;
>>   }
>>     void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
