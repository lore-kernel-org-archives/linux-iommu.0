Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767914D6E0
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238869; cv=fail; b=ebMCXq12kSHSacyMGt5uP3/WUORbnBoA1cMSMKN2hlLYzDsr3txgMy9KSdOozJRaRnzZ+jBFefK9OizXJruBhXGFCEwChcKT0/SmFGd2Mh+rWIgeGoTMPk8HIcCn08RH+OXqjAsIw7mp2XIR20ACUk7JTgXuK4JxByLvYlC5fdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238869; c=relaxed/simple;
	bh=bxkdGLD6QlHCGwFhJWXN2FDqFELl5MT2kGr9FX83GGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TdKrgdzs8iTuqdVEJZRFJC8DL76i115q0Bu5/UsluHqwxOE+hraLXH+Q/WCUZQzHpBcNV6wDmbGZ5hoobUkudPGzLhm3vnkEal6PaONFtpCSRTeG/wrohvOdBU9tq1So/mBgLoYCSQsjdBjsZlaAl7x9hD1vCfcuzIK1y5tMBDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhRgt3KB; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhRgt3KB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+JOLP0mT0vZIc3/m4txXWkgEUiT3cEzaglV2rRHDE1k2CssyxPG7vb+N3odT5jCkhAPbJinE3AbPRxSqc2ahvx66hT9tpWas8QbGl6UC39hjYW0HoazOfb9kM5y1WzKofcJn05qdB2gL9N0pqK+0WkjDQ1ag1xcQrNFsYdCp7N89t5YWCHhchGnKTwboc6ohr8qbKX3udHCqPbrsY1ytQYUkqHiIRiXLPe1feWeZEUSFaeSxtaAurlxLErixhXOtW7V1r3cYJXpT5WVQS/M1jV5cfp8nz5Ntf3XFNn7TXgQWYFmF03MHUBQKOsIGzUVZPXoHq8GMpdVvQ2OS1L13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8Y0CkjQEEs5IRx8z4lGCsYvpqxrTY8OrRpK5Q7E8S8=;
 b=Mp5xFGGRsMPL/cDo0Bi2cFLplBh0bTWDxadiQc5WG0gKDAVDfti/TPsTp6sp6cl4jeOlCXOngAlNm5B76zllEcTh0bMvTTGdM1jCRuJHk+L8/h9o1YGwvWygyATWYs0oHQWaB6ZxepFYzUk/xr311hDCpEPvlvqpcHdSg2ammqo8hFWLsXQ2CDOymYIBgGKd5NALUaLqMvw0E9TCbMqX/OM+pb3DozknRD7W69pEAr9dm7e9ypGvcL7kjyPRNQWa73piJ59z0OPZQ3+xZe3VOU6j6e7CbtLLVKPX9NRXjdU1PmH9BFT/415nieVUzqEVTb+yECdsoKldJ2gmCWSkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8Y0CkjQEEs5IRx8z4lGCsYvpqxrTY8OrRpK5Q7E8S8=;
 b=vhRgt3KBiiofiNMtYyhZt3vRjKR86fN4djNuOmueZYOCBAjp4J8oRFKJaZn8nihF1nGEMcXXjM6gm4xv9/UMrcTBs4JZgpiqMSW6WidIDPhapb1qe/VhR0N+0DYceHoSRTINuYDsU1EFb34MM0HMklXgsXvmw6psQL5na5SL5p0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:20:55 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:20:55 +0000
Message-ID: <1bd088e9-8cb3-476a-b397-4257d3ec1b46@amd.com>
Date: Mon, 24 Jun 2024 19:50:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Take group lock before attaching device in
 iommu_deferred_attach()
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 joro@8bytes.org, suravee.suthikulpanit@amd.com,
 Lianbo Jiang <lijiang@redhat.com>
References: <20240528163940.48789-1-vasant.hegde@amd.com>
 <aaf7b619-1826-4db2-aaa6-235a25f46299@arm.com>
 <029a1733-4e7e-4deb-92d2-874040679bd2@amd.com>
 <20240610174407.GL791043@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240610174407.GL791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ed9541-2f3a-4a28-cba8-08dc9458dc47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGJWa2tLZWdjVWtDalQ2Zk14OWx0bkxRSHRLL1p6SlhKVlFtZWlpUmdDY29W?=
 =?utf-8?B?Qzc3N2M0SjRCSVplalYzSHJjc3BBczVrUmNUNnBmR053TWhHUVJJckdlMHVx?=
 =?utf-8?B?dWlVenFTaElwTEcyT1ppTVNiUmd0WjVOb0c2Mnd6Z3FWcVhaQ3ZBc2R0aExL?=
 =?utf-8?B?SHhINlNWeEpvbWlMMzFHWXU4b005OTNJOTRvWnpYc1JjdHhINkU2ZkU0SlhB?=
 =?utf-8?B?WjQyWW9Vb3grdkxvSjVKR2NQdnNmSkpLaDMycW1JRXdCU0Zkb0gzeUxDeDZy?=
 =?utf-8?B?M1pmOHNiUEJHWXNhamVZZjhiSTBwR3NSUFJPSERZQVNpR3ZISTJuUmRLeC8w?=
 =?utf-8?B?ZlluaDRIUFNkRnZqR0lRZnFyNzJRUmpxV1JEQXZzRFVGdUE1bGpRVUwxeURN?=
 =?utf-8?B?OGRMeXU0bnZFT01uK2VNVkJjWFVXS3d1WXFUUnVjSmdKV0FOeEZMV083MmhN?=
 =?utf-8?B?ZSttWHJ2UjlrME1CTFFWZ0JmODBCWGRSSm5veWtlcVY4MngxVGV1WmtESXpZ?=
 =?utf-8?B?RHpYeEcvejlLbnJjVGR6ZDArNE56eWo3a0xza25JTUQzRHFHZWlsS2xJL3ZC?=
 =?utf-8?B?akh4TS9MWldiS0ZMUHhVcEd0TDRuSHVrMlIwUXRhZnR1NE0wNzJNWEQ4Mmlj?=
 =?utf-8?B?TnQ0VVhnemVPeURuVy9tcmd3dUFod25CZ1A1Q01qdlg4UWNIS3ZjRytNeWpa?=
 =?utf-8?B?bkM5dGo3Yno2K1QwOXF4UkFxL20wMEJwT05UQkFtT1c4bDNDTUF0SHM2NXAw?=
 =?utf-8?B?VDVGTTlZUHZ4enRGeldtVFZncHc5T0dkTXV2Q0tCS0cxdWU0djFtRjVOYk5h?=
 =?utf-8?B?OFR5dCtVME12QmxYQmtYSXNBd21vR21NeGxvaTZpNjNqOVhCVFB1dERyVkUy?=
 =?utf-8?B?Njk5c1lZOU1pdXFuQkVNT2RnbVhGMmJpaHEzazBQYlB0eU9pbEc4cnNRUUlR?=
 =?utf-8?B?QVZabGpJTHNTZVNHd1FjalNQQlNWMzNhVzNRaWxSY1M5czYvSkFxZ1RZQW54?=
 =?utf-8?B?am81dlVxSlc2VG5NTzgyQ2lMUi9DQVZiNnd2ZFd6elRVQ0FkWDlGYkM4K2V6?=
 =?utf-8?B?Q0wzUDl2MDVIL1VoQnNqZ05LV0VjNU9pYnNNT2t3M25Hb1FiVFlRSG43WHVu?=
 =?utf-8?B?UXNkYm1RaEExQUk2V2c2WFpTUnhqNWF1L2V4Y0Jxd2NsQjVzdVBtT1FMWmJt?=
 =?utf-8?B?bWUwdjdNSHdnLzdmMWlBRk9BVW15bHZPQ0R0N3owN0dzRXNvZm8wU0FXMkZs?=
 =?utf-8?B?bTlRRXhGa1BEbmJBRUxrRnFaWHplcWpYalRZeGZQZmlDNjExUzRZclFXWTFz?=
 =?utf-8?B?R0prZCtDRW5YNkZDVFBTOUJqUk16dGQ3ZEhQdTNGL1V1UFAzTGNBanJCTWN5?=
 =?utf-8?B?OTN4TmJTcWV0SFE3RFE4YkhOU29mdmg3OXE4cmxTWit5R2RwVnBmL1pIdGc2?=
 =?utf-8?B?UFdvalErdHM3QlV6Z0piY3RsZ1hwRS9FaUFCMnoydXQwSG9iT0ZZUEJPWXcw?=
 =?utf-8?B?bTJVenlZMjFrcnF4ZTA1VDUvRXl0S0s3U0RwNU5mZGp3WjFCTnF5aTRRYUZS?=
 =?utf-8?B?ay8vbFFSMDJMMHFpblVNUmRRN1hCS1VYZU9ObWd0RDBoQVZKK3dZMitUSWZq?=
 =?utf-8?B?L2c3Q0RZRUZhWCt0UWZnKzBiRm0ralV5Q21ZQVN5L3lqVm52TFQ1MHVYTDhI?=
 =?utf-8?B?RWFQbkRWR3BnL0N0eVRnc3F4QlFLS3Q1eXgvRVZUZkZRSlJrY0dVZUx1ZE04?=
 =?utf-8?Q?DMyZlN4xqnvVXaMtm+fdQ/A6giNOIv5koQYd8o9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTVFVCtYalVFTW1YU1pmemRYMGp0QkNFMnM3TUFVMHMrNElsWE55ZXhrRmls?=
 =?utf-8?B?SnFBU2RoZG5hMzhkUy90bW52R3BUQXJXempzWVlsN0FNM2xmcHdoUWptNk5x?=
 =?utf-8?B?RzZoTFdsUFVYNW9vbFlBYzB1MC95TU1RVzBLaEdXejV3MCs3b29KKzdkanBn?=
 =?utf-8?B?cmxJTGE0aFZzcWlkRU8wUUhyaHJqODh1T2VXRXNQT2pMdEFzcHppL1pxUk1l?=
 =?utf-8?B?U2dGQUpHOWFJbzBCQXJuQ1hmVzlqbnRneEpkczN0OCtxaWFSYW5BM28yZVJo?=
 =?utf-8?B?S2VnMTBkcFdtTG1ZNHJMTUVFM2g2Z3VGVmdieHU1d0htdUNRY3BmbHBDYk1B?=
 =?utf-8?B?TDhWMStIcDFvaTFTV25BSUZPTGNEMjVuM0ttM1IzY0pwRTlvbzA2SlpJQXB0?=
 =?utf-8?B?by9pMEljYWxhaTZUTytOQnVacUYvSmZrLzFGN1haUy92ZHN4ZENob3drUkc4?=
 =?utf-8?B?UmRKeHovRTQ3enZ4UDdSQzkzZkpJZTNFNUNNK0dwTkRKV3VGbVMrQktLSGRT?=
 =?utf-8?B?cTJzQjJ0c0pUSlE0SUFPaTVJUUE4dE15bEhQcnhZTS9aV1llcUhwZjJFR3li?=
 =?utf-8?B?ZUNrSzlXdnlxam1SeENtdUtERmZmeGVSbDAyaGpYK0pYd1h4eG5nNWVtNVhP?=
 =?utf-8?B?RVdDRURuTWJBSzJla004UDdSVy8vcndFdmo0dzg3ZVU5NXg2dDlvbDh1T1M5?=
 =?utf-8?B?a3YrYlNrcFVHekp6SU1tU2s5U0VBNk1tNDBmMnR0Y0U1bWFWbThGb29pU1Jz?=
 =?utf-8?B?MTBGSU5ERGNJVDEvT3Q4Qk15N2ZWekNBM056YXlhN3dvS3piYkYrM0Y3ckZU?=
 =?utf-8?B?VVhNSG82NEJGbElVSm1RYjdRVTFJVEhNMVpBUzFvT1R1eW9SbjR2cWxrNmJv?=
 =?utf-8?B?M1BMbDBvU2o2YTJDcklWb2lHUDREeWd6ajF5c1JwaGpieGk3dUNhWDJ6Q1FN?=
 =?utf-8?B?c3VjanQzQnRPTThQSG5uZCtIaDNGRzZickg5TnJZTEg4NFhKQ3p2UXViVmxG?=
 =?utf-8?B?S01oUjdQTlVPVWg1OXRIWWphQURLb1ZHS3FwdEpoSjEyVWdncUxEbEJwZEZ2?=
 =?utf-8?B?bXBpMTA5WFZGNFZuMGp4eVBUUFljZC92VGlKZ3VaMnIrVDIycGxsZTBtUzV1?=
 =?utf-8?B?Q2FROTdMODVNTVNaSjBDZ29yWG0vRTd1cmluUjVsNWVaclBPUE82Rmx3SzYy?=
 =?utf-8?B?V2VkeTJibU4xVVYzaExZQ1N3dDQ5NU5pT2R5amJBcFNPejdFT2hhTDVKVXdH?=
 =?utf-8?B?VVlHYjI4TjlkblB5akN0T2hMNGhRL0xSSDUxNStXWUxrRCs2VWJYWHRjbits?=
 =?utf-8?B?Q1krRGNiYTZ2eU9DUUZBbkl3bjB2ZTVzVUkwNWR2VVlIK1ZVNHl0dERkRnAx?=
 =?utf-8?B?NHJFQ3BIVldFaldEc3pxdUl5Q3RydkcvVDJNengySHRvdFBXRGJFSUI1WWpz?=
 =?utf-8?B?WkU4V2dvRU4yODR4R0ZCS3RYbVo0UUlVTjZMTkNNbElqTmZxQVhnRkdZdWpB?=
 =?utf-8?B?dW9SQXZjZXpWZVc3ckMvcTNiaEJyZjZHVml4NUFuMzcvc2J0QmNFOVNTYUJG?=
 =?utf-8?B?dU55T0RVK1gwQjduSUhYd2NWcE9hYTNXakdqN1lLT212cFlrV0s1SUtvY1BW?=
 =?utf-8?B?bGREQ2tOQ1NmRnE5WU80S3Q0VU92YWJEVWNFNVJjVHVOb0U3T29qTkNZcVhh?=
 =?utf-8?B?a3JXOTZqa3IveHNMeElaWnVXYkdoMDk5c1dkMWI0NkVaVzJKWkZ0UDlMNnln?=
 =?utf-8?B?NnQza1ZVNUx2TFpMZ3doTThyckUvM1RFTWNYMmt1TkhJamZMQ0NHYzA3R29t?=
 =?utf-8?B?RFd6M2crWUdhVUp5UWRjblozOGFrK1dBSnNHUzYrdVAvQzgvWEo5WGJuLzNR?=
 =?utf-8?B?cDRrRklxUUttVjRTKzlnSnJTWjd4STY4S0NkaTFvdm9zSkVBWUpHY3Nlc2hi?=
 =?utf-8?B?Yi9JZ0lpYjRaZDd5V0VDY0ltaDA2SVVvaVA4MWQ3V2I1NmJMdFdxNWR1NFhk?=
 =?utf-8?B?RGpmQmFWclBrSlg4eUk5RUZsOHV5SkNXUlhGckhGbmpOYnpnSzdHekEwRjRz?=
 =?utf-8?B?UERYRExJZlBMdXJGZDBTMGgrVGpNU09zdjJ1bjlmcWV0SjNkK3JhS2JONmRr?=
 =?utf-8?Q?mVZvEQtO0cOIbm/1e7CDAFluO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ed9541-2f3a-4a28-cba8-08dc9458dc47
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:20:55.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yQW49v+VW5UI8acs6ap1y1zuNZHWCjfhBmtdMBynG8DMqGRXC25Numd4p2ihuvk4GyTnoPIzGp8XuwB70S+KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306

Jason,


On 6/10/2024 11:14 PM, Jason Gunthorpe wrote:
> On Wed, May 29, 2024 at 12:54:14PM +0530, Vasant Hegde wrote:
>> Hi Robin,
>>
>>
>> On 5/28/2024 11:36 PM, Robin Murphy wrote:
>>> On 2024-05-28 5:39 pm, Vasant Hegde wrote:
>>>> Commit 3ab657291638 ("iommu: use the __iommu_attach_device() directly for
>>>> deferred attach")
>>>> replaced iommu_attach_device() call with __iommu_attach_device(). But
>>>> missed to take group lock. Take lock before attaching device to domain.
>>>
>>> Why? Nothing here is even touching the group. If we've reached a deferred attach
>>> then we know the domain is the default domain already initialised and set as the
>>> current of the device's group, and the device is already otherwise added and
>>> holding a reference to that group, and a driver is bound to the device in order
>>> to make the DMA API call we're inside, so nothing should be at risk of
>>> disappearing under our feet. Please clarify what purpose this locking actually
>>> serves.
>>
>> I am sorry. I should have written better description. I was trying to see if its
>> safe to use  iommu_group_mutex_assert() in our driver. 
> 
> The core code guarentees that the dev will not have racing
> attach_dev() ops, and we added the iommu_group_mutex_assert() as a way
> for drivers to document they are making use of that assumption.
> 
> I'm guessing the purpose of this patch is to allow the AMD driver to
> use iommu_group_mutex_assert() as it will fail in the deferred attach
> path.

Right. That's what I was thinking.

> 
>>> But then there's also the fact that the initial DMA mapping operation which
>>> triggers deferred attach could legitimately be called under a spinlock or in an
>>> IRQ handler, so if anything it was a bug in 795bbbb9b6f8 ("iommu/dma-iommu:
>>> Handle deferred devices") to ever use iommu_attach_device() (and thus involve
>>> the mutex) in the first place :/
> 
> ops->attach_dev() must be called in a sleepable context, even
> the Intel driver will hit a GFP_KERNEL allocation in its attach_dev()
> op. It seems to be an issue in 795bbbb9b6f8 that it did not consider
> this.
> 
> I suppose in practice kdump using drivers are setting up DMA during
> their probe functions and don't get into this problem.

Looking into code path and AMD driver code, it does look like in kdump path
deferred attach gets called.

> 
> IMHO adding the mutex here is an appropriate thing, it should not be
> closing any race, but it is the right locking documentation to make
> iommu_group_mutex_assert() work.

It may be good thing to add mutex here.. But if any of the caller of these
deferred functions hold spin lock again we will hit the similar issue that I hit
with AMD driver.


-Vasant
