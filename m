Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678C4483A8
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113270; cv=fail; b=qK9Tr3ML9w2BOZsQ2hbWMAV2ypceDnWf+hSPMgF51hHHygOrWyB0qtmC5khYWGCZtE6kyvRQNlt9kgJErQ2mBBl6l2xbnNmds8JBrWS364ZJvlqDkv3xIRG9vP6iGEQEIfZccPwl69KvvYan/i9tXct4vncTmdPKX2GyhM/jmGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113270; c=relaxed/simple;
	bh=cg1i0S4aUe4FwIFVG8h3ymRDOwiPu/QE7akzDfDGzrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A5nOU5XpNp49QyRWvygY7+MlZ5oqfbztZdrQ0zx3SNViaZOCYBKk15QUcKib8pmawYquig9WUfbrdDgNn3SlCMDlvcWRtyexIS642Zpp1TOGMlVseHvi6N8Tya7XDzM3zRSDKpdar/dLTnBkavQO4bL6S9Lk2dIvWEt+/hzd9W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zqOw1EAx; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zqOw1EAx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpHLOxjKA6dIOsG+C4PENzBmSpiUt8p1HQLdKwK6BVsIDyD0m2d1/I/Re5Sj31TYwEwyKRSnkeTYrmIQeZoqeEa4vYkOu0UtiOOw96aJ7/YvSb2ECV/l+mmZDATjvD7G67mB1xuGv+W8m5OjQVBqS3UduMORUbw1B9MeAFQXTT9qTI4m8pMO8lTxywCWe05BERX/vDOg+dcUTpFu0rNFACXQRM5625a0IDBs+OPd9slIDoz25fCkEnCxbo2Z3xPGyWHvpSIeaB/FU6qpN5mfVw17Ezml62iHGDqxDA6pkToX44Q/vJBoUzviAsZVXp8EJImM9lwTfaONOGTHgC17jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyM5UjRNQZwKfa953AvDnaO4drIhMIQOCRoy9qgiUj0=;
 b=NtOa10dHXcjNLVH3J5girYXjOkQjeQ8DhrNE+Au7w21CIj/udXWKyfL2uOe5h+I6d3t1ILElDwuFO8EmGC7y6U/rQQ8+pzALwn1t6Ig4KbcIm37PhxqbJLDnAqR4lhu1vUq0WXI/rlh/4xEDnjJ0hGnrmLgiWz4XwZFYt3Am7a4MFCaq4Prs3B3kUWKOXFWADqmKfHuDmqXmlnSD5QpMd1+Y1j/+5zpnuw3sSbGHVVaXV4QTQAGgx3p1GKujRnEVmeGiaxkPK2Hd5ylHhsCurzlJYGXaZhMP+b7kodcp7wb27tYWdXfDL7UXhYLh9r8uxdwUhbtQi+V9aFRjTkKyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyM5UjRNQZwKfa953AvDnaO4drIhMIQOCRoy9qgiUj0=;
 b=zqOw1EAxQ8ALYfGGm8A3+wkL8o8ZWk4WGTS5Af2gj0C8++kieI02EOKttHleFh1XgaRYItcruVjmpImUDuNGq19saQ/36CXJw8jjB4Tzbsie+G7eYy8sa1A4mcWPg/OiQJflmdWrfAx2aCHPiBpeKmbKzDvlco5mFTKyZQou44U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 11:01:05 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 11:01:04 +0000
Message-ID: <7ebefb9c-d865-488b-8441-cf598d18ac2e@amd.com>
Date: Wed, 15 Jul 2026 18:00:55 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/22] iommu/amd: Add support for AMD vIOMMU VF MMIO
 region
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-8-suravee.suthikulpanit@amd.com>
 <20260707143317.GF220801@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260707143317.GF220801@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fe96eb-fe4c-4a37-8b00-08dee2605d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|10067099003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	F+N4eUD/f/An6uVOkJqWbHmxd7WW+J10H5akj7n2+wJQ0Cz1Glnfnwb8MDaJvoJ9rxA03K6KUpSI0QQAZYIQolJSEvzvtwx1uXIESrVz7dKccD5SJ1veA1emr7WENUKP5FnHXvTx1Vfc70ceCGlHXR9Z1tKtfghmx4uJTPAc6706coZyWfblkZDZIeu2o6i1+2A8m3TUi7wK1LY2naioVSNeIMJ+p1P04oPpHNrZDttvy3u+MhahppQyURXQEcHqwiAADR28bgvQLLOys+m+grZ4ZWsMvgIRtR+rtik/KDw1iPdJUdv9ZZfsl8iNIJ03pY/pKHqp1aZwep4iqkQLopfl+FFQ3tBKPHIEyxYjuI5nXnXmp9Y9hxPmf/8UymkTeecuieXQTnxqbFsQO68RrfN2wlcIJJWRxTVlMQXVGu+C7BXMLCw0s3+ZK7pWkPJhfpcmNDOAbkjex3xkdLGwpYbuvYlOR0Y/PtjMScCLUi7+jVvH6wsjdHm5pibZ63MdfBeRGTnJJTswr3p+1qIUdZjlUIBElssRFatGmn2EDOlhSm9mFOA3TUQhyOR+Fd2o9M2zSMZ9kwti5DwvV518fSzXidZ1AH3ccDN+lR37dr+nEO2/ri30ZpfsjPk5bY/JQLJmyuskr4zVvqMEn6XWBYLvwdMPdcsWjb/1y3d38L0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czNuKzNSQ1FMM0pNK1FJVW5BTFJsZTFBNFJDTS94ZTFXcnljYWpDR3F0ZUZn?=
 =?utf-8?B?RFhWSXFCVnh2dFRTMzNTNVlOWjJJWEU0enJsVW5RMnRVaXZYemdDUXF1K2hj?=
 =?utf-8?B?MHNwZEFLNW14aVBDOS9lSzV1c2xTWDJjakMvNWd6cjZmUkNJSmFtY1BpWnJO?=
 =?utf-8?B?Nkh0R2RZK2h0VnhKVXh2dGdtWHhkMHVzWjlTbnhDR1U5TGozNnBEeHB2VkxX?=
 =?utf-8?B?YmtUUHE1bHZMcnBhU1NEWGNGVEx0aTRiVVpFeHp4eXVTb1ZZSGVYSFYzQ1dr?=
 =?utf-8?B?dTVsQ3Y1SnRTeEgzcm1SaU5kYzI1czI0M3pXZ0ZQWTFOL0FQVzhzU1FLZ3J3?=
 =?utf-8?B?eFA3NWorWFRqcHplajRadzZqL3V6M3FrNElxN3BURUh2bmlQR0hCS2FsL09t?=
 =?utf-8?B?a24zcUZFZFRoYURUclh0Um14Y2VEOVZwZUV1NzJWbWQweTYzUWQzSCswR0lW?=
 =?utf-8?B?OFM3WFQraklJRTdyNGFUd1k1eFJta3dkbDh0RG81OGtTMDVnKy9neEV0M29Q?=
 =?utf-8?B?SXllMHdDcVNFYTdxRW0zUFpaUjBPWkFyalNJM3NYNkZ1RDN6OE9LT01ZalU0?=
 =?utf-8?B?YTVJeXdTdHE3c0dRc1UrNEU3aWR1eHNZb1NUV0FwRENuaU83KzBSUVJ3NGwy?=
 =?utf-8?B?blJlNHNNSjlURm9kUlVvSDEwTElISGhPTU91ZzU0a0RvbkxDM1JiUUlwbkM3?=
 =?utf-8?B?a29QMFcyNTBXQUQwc3c0K0poTlhZYkl4TU1yblk1U295WE9UNWZaRHpaTEVS?=
 =?utf-8?B?eXNIMDMxZnVyYkd2TXBKOGtxSFVSUUkyZVpwTmNxMXNiNmZhSG1PbkplSE1I?=
 =?utf-8?B?NEhuNytzRWJRbWs4UVpVT0ZhQ0tTQ1lJVmlIdW5sWWc0OG83RjhVSG9BL2xC?=
 =?utf-8?B?RUc4d3ZtMFFVeVB5WXFMY2Q2a3E5UzNXSU9qR2poY3h1dnV4dDRscDdSYkdx?=
 =?utf-8?B?cGNXTVVYOTBzVUp4dGJYNHVYRkJha3VqdGZsNmF5NkdzWlhIT1FGSGM1Rkor?=
 =?utf-8?B?NjlVWWthMC9mUzZLWmRTQzREK1Z6cEZBODRHSVJKdFlGUG9qdTZkMXlDeWM4?=
 =?utf-8?B?azlkUjJNWis5cE1qRzlQZlRZbE9GbXV3amF4b3BtT3pKQXJzRDZ0a1NIcGsw?=
 =?utf-8?B?cE9HMGZXM09kUHBuZ0h1S2FxZmNEVkxWeTVLeWl3NklTR0xsSHlEc291VURr?=
 =?utf-8?B?VzRIcm9lSUhLYWplVXhaS1hpRjk1SWNOSGNkMFZsUjNmUWFIR2RjS1FZWStm?=
 =?utf-8?B?anN1Y3JFdm00N3dwYitBM0pYcmIvYUdkV3BqSTEvaTlHMlNxSkZGY3V5VzZ6?=
 =?utf-8?B?VnQxcFJ1RGNRcUxaSVh5SGlYUEJjSXhFc2owK3gwUVg3QW44cUhMaUpZTkU5?=
 =?utf-8?B?a015NEpvazJuTFN1a21WTGxTNU5GalhCRTl5YzFkYmRJaHczdS9ucSs1d1hC?=
 =?utf-8?B?VjY1bEhTYkNZZkVyNXVDZVJwdEVnenRIU01IZnNYWXBOZndmbVduOWY2Q1Ir?=
 =?utf-8?B?aTlkdHgzMmgrOXNLMDdqMjRDTUhkMGRZV25OT2JtVXg2QXJQeDJueU9sUzZp?=
 =?utf-8?B?bzc1S2lIYi9QRXpWZ05aYXN4ZnZ5b1FFa25RbjFya3RVOWRROElpOG0vUHly?=
 =?utf-8?B?QUdGREdPaUw0bnliRU8wRUJPU2pZSUtySlpVNWp3eGdsT1QwdUNHZFhCb3Iy?=
 =?utf-8?B?b0NUTGFtcHBRaGIyZHMxRzA1WnF0SEhMMllqZ21vRGtaR0JxY1U1Tml2RkdZ?=
 =?utf-8?B?a2M5OXRCWVl1TTN1STNwQ3JTTUVoUTY3RkR4YmYxdE41VVcwNWg1SmJPczlZ?=
 =?utf-8?B?QldJWnhlOUlQTWlDOUJBZmtraUxWbXBLT2c0V21kMi9EMnVwVXduQmx4R2Vy?=
 =?utf-8?B?Uk5UK1djajNrc2hPdkE0ZHo4ZHM5TWlmdFFJVXdNRjV0V0x6VkdEUW5UbW1K?=
 =?utf-8?B?ZjBvdmFIUzZXdEV3RHZhcnRNTXVhNHZsMGdMOUs5N1VsMmEzblRlZUJqNGRQ?=
 =?utf-8?B?cUlFMnI3VGJ1REFsNzAxM3l2Y2FBV1dxcTE0UGhXdUo0R3ptN0ZobGNxMEJn?=
 =?utf-8?B?bnl5c1JQUjZJM0R5UW5QQTY0SDMxeUU0MHFCVWhWSUxtSW1JYlZkVFJ4YlJX?=
 =?utf-8?B?MmJpcmNZSVkvTVkyWEQ2OVg5T0RiMlducFZ2RExEUFNYNkFmSnU0SWtMMFlZ?=
 =?utf-8?B?cDBwSUI5UjNnR1Z2dFdoOVNTNHVkZGR1SkZxZEg1ZzZCK2VVaFkvVk5uck5S?=
 =?utf-8?B?emdVZWZSaldYTG5pdXFNMFNHNjlXQlAyK2huei9SSHBGeDhxNk11d2ZiTExR?=
 =?utf-8?Q?hD/X4aIXWa1+Jy50zB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fe96eb-fe4c-4a37-8b00-08dee2605d5d
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 11:01:04.7702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Agug0fxmHpGyjaZ4ka7mbvszN7Sx2OR3zvNI4ABdUE49F7HGVA+l2j/UfxI+btYAeJEDFpX4OPVQ+9GXhy+B7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516



On 7/7/2026 9:33 PM, Jason Gunthorpe wrote:
> On Mon, Jun 29, 2026 at 03:35:20PM +0000, Suravee Suthikulpanit wrote:
>>   
>> +/*
>> + * Returns VF MMIO BAR offset for the give guest ID which will be
>> + * mapped to guest vIOMMU 3rd 4K MMIO address
>> + */
>> +u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
>> +{
>> +	/* TODO: Add check for sVIOMMU and set gid[bit 15] */
>> +	return iommu->vf_base_phys + gid * VIOMMU_VF_MMIO_ENTRY_SIZE;
>> +}
>> +EXPORT_SYMBOL(amd_viommu_get_vfmmio_addr);
> 
> Why is this exported?
> 
> Jason

I'll remove it in v4.

Thanks
Suravee
