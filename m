Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C43F0AB6
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780458813; cv=fail; b=A2nuuBL4X9qmVkGS40GkdDKc3AYw9vrijy6nVj3TxHF4owLbxyxPMFdhi+93qIA3gJCIf4iAMaBOT3JMdlKwfZgGPe1niRa708LbJRRUzWkvWJRWlP1X7D5QlPB7gIKliYcoXhyAaRR2SaT1NH1Zx/vb1jnPYifBbLefgwnu5o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780458813; c=relaxed/simple;
	bh=87atKstrD7GZ1HCBC1Mfl6YgCPN0krBiRsAtqbV6Kko=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rDqEYt4W/opbmdpAMByRnhkrcGHhgok2b6FsWweGLSiyO2ziNzMELbKxwd0Nva4IZZI+ozbDLn3CZ2qVW2DYVyl9ywn0XyiRGaS1NDsC4sPx8Ud7kPKVY20HKJDg3WCnpqLSv14qJ2i53Frnk7x8cB06FTrhrZXshhjHRlmjG2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZX7uhDbM; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZX7uhDbM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hvjm3j0dZuUxsjHFo/k3s/e1mR+kZYartvjCbDURHH4Ivia623hWTujDASqdsGS56Z4ZLbrV83LMzvJtlejnvBvK/910MBLM0N+22Trr+sPhgMv5KeClyiB54pBrgHfk5pEUu9jR0qqZuv415W6rVKox4sm/xO84idXl5RjNb7C7hhv4ngtzbYiEi71vU9ZRHPLNQOBkcMTX/Ma5SegUr3HOZ9T4ltw/O3yF9ET89+liyPQfntoaKJ1ckfpFBJj6dqgTR8PAvH8QwGwNuMsdix8KCchU0vAS5DjnsKIM5yDfAlevCz4zZnFpqHRqTywNjPFZc8Ap9/EswfVcssITYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr/We/lyFwiYcGdPnGwt+d1q8PPXPtE14L3W95dsOa0=;
 b=Hn70SLwovBipMe6gxAijMx0QuN8WLS1w39PICDSebilwwxIw4rpEAUPAjEHMq5IcsjIFl/z1KSvSKAgB4A6m+vOIfZPDfIs78FEtT132QdRDokzkrAIc5kYtO1Zz0Fa/aDGF7tM9gS0QPDDLwb+BRv5pwIk3YB0j/isFFGoXH5IJ9/fiF7blRdif34jV5odAHtf6kBBRibS0AxLP7jhDNXcBfKeENVNDUGr5zh/bkMXZONhny2UhY1JVthLBUHbTDQwiILufAhW15Q0Z+FyM5j6kJhwWVV/Te3A84pHFvAGuyEbwOrI0O/leaYcwBGH5czOnFpfx6wZrV9EFsdFlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr/We/lyFwiYcGdPnGwt+d1q8PPXPtE14L3W95dsOa0=;
 b=ZX7uhDbMUysuEvkaPOIVWyysmxKUpDC5A0fHjup4CGAMsV9ZJlwBN5WWJ49Ku1+NxygiknTu4yN/p8udoR6dt+yTlAFULYFOi5ygw9OBNGGUZY8p9yNuZVEmd+a56VomHGY8SW0+2OmUif67LSQv1MrouPWzc3W/L/BfkH9Xil4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by SA6PR12MB999201.namprd12.prod.outlook.com (2603:10b6:806:450::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Wed, 3 Jun
 2026 03:53:29 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 03:53:29 +0000
Message-ID: <13ce21a9-1275-46f3-9c50-3b046f0e86ad@amd.com>
Date: Wed, 3 Jun 2026 10:53:20 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/26] iommu/amd: Handle set/get command for AMD vIOMMU
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-26-suravee.suthikulpanit@amd.com>
 <ahofMQGl6TzvIwnL@Asurada-Nvidia>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ahofMQGl6TzvIwnL@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|SA6PR12MB999201:EE_
X-MS-Office365-Filtering-Correlation-Id: cb50fb64-5342-4d07-b219-08dec123ac5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|56012099006|22082099003|18002099003|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	EWs9Xfa5g4/gpJyw941RU/jhJTsO+n/iUYlUJUVEnaKnFIi5xktfj+T2ZgvrPvgJLRxgXByENddxH4BYX4fzo8Bp7ZBlOHt9/y6Si/90iGMOA0ozppUEn3cqeqrl+jeuFgoWKDuvG7Ib+5WbC7HYHbZpN9PSp724VhuzKUBoDUtAkgPtGspaHWgGKYHaEqs7wS50z/Lke9Cszr90CaDQr8LMZpytsOn6bS5J7pii/TXY3eJA3KBdJ7dxc0Ru+IN91Q0e1C6Vw0kJNYL/j8lWV91riHit9vdNTWdNyiLew8fwTpvNFgJYIFUvRLNxfOBhuh31JuKVO/KUVWTd11dISIIM8V1e4kvqjOn8NMg3qho6P5Sh4gw1QVA8Ox4N/1rk03gfJUmYdv2W6kGMiudQYRmiH/wJXL7Y1GW4VVtGklHIxrONiNhNK/4lro8SHhoxvsgN0YT4Guc2z7zQDSoHEaPr1yZmJpotDiQpqRiShvgNTn6MleQeGmUnG7fPTpCetHudiBcrNwBJkrfMZThnd9gLgIpDPoczllVuF1dwZYqnplseT/3N6IzBpe3KLeOZLRFcXhXrCKaCrLb0AeMNnSQGLoiVSMVraPPUIH1XeA66uWzFvUGeIaUd3UeQy70qWqJQRgAiUsx9Hid2iYQ/NDyAcUbpcrp/J6ccBGMLbDYNlW9C9EmwxNZH1pUXGs7/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(56012099006)(22082099003)(18002099003)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3JydTR2QlBLREVSbk52T09kaTEzcDFUUVVsbzR6aWQ0ZVZsN2M3WlV2cUpN?=
 =?utf-8?B?L3NUTTRQdlB1TzIvdXNmTndUQTZVd0xiUmN1SWwvT0FMdFRucm5vb2paWGxq?=
 =?utf-8?B?S3RRN3dmemVhRm9RdXljVFpSUExkN0NMamJDVXZ2VVFPci96LzB5ZnhlWS9U?=
 =?utf-8?B?QzQyajAyZWZaYkNnKytZclVjeE5NcFE1NUZSYUVyT1d5aDlBdU5lbzU4UmpF?=
 =?utf-8?B?dmYwVlUzRVRmRHhkcVplMzhJSXA5Y045QjRneWRQN20wWTFUVENlK1NaSGEv?=
 =?utf-8?B?bkRWc2hRdFBkdU01Zlh3dnFZQkpWNlJDdi9icmFCTWJ6YkFoVU5iS2ZqN2Y1?=
 =?utf-8?B?ZkFaUUNyTzRyY25TakdybFBzRE9RZkJoRGZDSHJndGN0WXpVNmtIamNuaCtD?=
 =?utf-8?B?Wm9yeHNGaTlwd05nVTcxM0FMc2F3OFF4ejN3YlRZdTBzeU1KbXZWYlY4Wm5o?=
 =?utf-8?B?a3JUVnZ6eCtiMG14UDRWTjFOT1duYktqMkhpaWZpWEYrdUlpaHRhMWU3NTYy?=
 =?utf-8?B?cGVPOWs2UVh2L3VxQm9ST0pldC9sNnhKaHN6b2hzVG5TODZWem5vbUkrU29V?=
 =?utf-8?B?UE80VUpoNDJhVDVZNmdFcFFWMXhiQmkrSGRZQ29FRzZkajJhUm5ySlUvMmZH?=
 =?utf-8?B?QVp6SThGOHYxU3BHekk2U0tYaHhuYlpiYmpieEwzV2FKbmhsZlpjL2F2ZHRD?=
 =?utf-8?B?YTV5ZCtPbTJ3ME9KZDEwNjRqWk12YVlpeUN6WmJwcUtPWDdJSTdQMXQwcTFz?=
 =?utf-8?B?YVJLcmJDek15MEYwVlhjVU96d0w5dm1ab0p4d3VsVGNPQitzYXlocmY4bmpK?=
 =?utf-8?B?QUZ1TUVWdUlBYUFIWFdBbTd5TE1oN0hqT2MwVUpEREpXeCtFdEFiSnZ6NXlk?=
 =?utf-8?B?VCtFZ3ZNdnNERzRKV0FMMHM1NzJIL1hmRzBIT3pWa2hMaEQyNG5HVTh6aGJr?=
 =?utf-8?B?bW0xTzhrSmdxWWJxU0t2YlJzZTRsbmZ0cDV5ektRbUd5aThOQVBwS1NyVUc1?=
 =?utf-8?B?ZjEwSnAyR2RsMVErYTJENWRwNUhjalhYd2o0V2VJN3c4Q1RocXQ3L1k5bHhi?=
 =?utf-8?B?NjVuR3FFU2N6VE5Va2pLN09UTU52dzduWlVSbCtzRUdMMUc1dlhjSjZOVjFl?=
 =?utf-8?B?T1hLTjZjNlBuVmZjUE1jSnk5c2FOUzNOVGVWR201dXNRY0pCTStXeDJjZFcy?=
 =?utf-8?B?TkR5YW1GQjJBaDREN3JuWkVENW1NM29SUXpTaHZYM2E5cElwWmtxd2gzNzN6?=
 =?utf-8?B?MWRVOFlaTDIxT0EvOEQ5NjBvYWFEL0hhRk53WGZoRDdkKzhaWldyN0VqcXdD?=
 =?utf-8?B?SDM1dXJkTkl4aVJ3WTFYVVhIZ0VGMlgzbmRBbHc3Yzl1NjJLWXVRd3pWRkJo?=
 =?utf-8?B?eXpRYmtvd0RReUJEVG5QelNLZXNyYlhiTmVSdFljWGx2VSs5RVQrRnI3c0ZK?=
 =?utf-8?B?dW4wVVMwamkxNmpLbmhhTUkyQ25vL2NFbEZmUDlyeDBIZjdWb3dIT01mMlZo?=
 =?utf-8?B?MnJ0anJLdXJobng0aUNRcG9HRXlYdHJOQ1F6ZjZPa2FXNFliWVNtNmw2UG9G?=
 =?utf-8?B?VkZxTWhKSVkzUGE4c1J6TitoeUs0TmdlRnJtZS9nMXM0L3lpUzlNbnBjYUps?=
 =?utf-8?B?ZFdBUFJtd2c0VVRYZmc2VjVWay8ySnRDRUkxRzZBVkE2anlWaGZVR1VYcExG?=
 =?utf-8?B?Y2FMWmRGSnlWZXlWUytiYnExOHJ6ekllcTIxTU9RK3FsS3laSXd5cDVRWlJD?=
 =?utf-8?B?SW5sV2gxQmViQ05lM29zSDV3RWNEWEN5NE94TE94SkVOWlF4K3pyZUl1MTgy?=
 =?utf-8?B?MzEvZGpaNVNUYk44SitiNVYxOTI5UVJpRE5xbmNOWisvU0t2U0hxdkwyMXU5?=
 =?utf-8?B?eDhCaHEyUUs1WFJMRytOU3c1MnFtdWpuVVdLbnk2L01OTlU2Qm1pYzFnT1JN?=
 =?utf-8?B?Zjh6MWZyamFvaXFCOWZ6SUVjOS9RMVY2ZnBmdUFnc3VleS9HNlA0SVNUbXBQ?=
 =?utf-8?B?YjFUY0pHVmJTVitsQ21XTFFVcDRlWmNzaGNNTjZLWjNGU0VvWENxL3hrdjVM?=
 =?utf-8?B?Nm9Xdk9iSzkrR280QXJHTG9hTEJCMGpJUElVU0VNYjBmL0tWTElkRERJRHlo?=
 =?utf-8?B?Znd1WXVJWTRsM2VVc0FpdzhZT0RFU1hscm5VNnpJZjNVamc2Wm04YU1nTHo0?=
 =?utf-8?B?UDZNTjczZHZnQ1M3RCt5NEJNNldpYjh4RGJPTVlXWXl4MTFzVXAxUndrQ1Y4?=
 =?utf-8?B?OWp0RUR4bzN5czRmT2k4eDhkL3BnUTdEbWhNZmlzV05sbG44d2krY2xSbmhn?=
 =?utf-8?Q?5QmfsxQOBLP0feV/jN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb50fb64-5342-4d07-b219-08dec123ac5e
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 03:53:29.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVVOYzBSKFxrxNqF2tKVOzhDTm21YIcxIydp1ebMdDf8dLK2/V9lHilGGiD4/iZGsJOOms6Kg3Ond2F4OJkLbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999201



On 5/30/2026 6:20 AM, Nicolin Chen wrote:
> On Thu, May 28, 2026 at 05:17:37AM +0000, Suravee Suthikulpanit wrote:
>> Guest kernel programs guest Command Buffer, Event Log, and PPR Log
>> (a.k.a hardware queue) settings via guest control MMIO register
>> (guest MMIO offset 0x18). Accesses to the register is trapped by VMM (QEMU)
>> and information is passed as IOMMU_VIOMMU_OPTION to host IOMMU driver via
>> struct iommufd_viommu_ops set_command() and get_command().
>>
>> Provides AMD IOMMU driver hooks to handle set/get operations for the
>> guest control MMIO register, which uses key parameter as AMD IOMMU MMIO
>> offset. The value parameter contains the value of the corresponding guest
>> MMIO register, which is converted to the format of AMD vIOMMU VF Control
>> MMIO registers then programed onto the hardware.
> 
> So the whole set_command/get_command thing is to MMIO a control
> register? I doubt this is a right ioctl(s) as it can be abused.

Correct. As part of the AMD vIOMMU architecture, MMIO registers in the 
1st 4K range are control registers, which can be grouped into Command 
buffer, Event Log buffer, PPR Log buffer. These are trapped by QEMU and 
communicate to AMD IOMMU driver to configure the vIOMMU hardware.

> Looking at the details:
> 
>> +	switch (offset) {
>> +	case MMIO_CONTROL_OFFSET:
>> +	{
>> +		/* VFCTRL offset 20h */
>> +		val = readq(vfctrl + 0x20);
>> +		val &= ~(0x3ULL << 8);
>> +		tmp = GET_CTRL_BITS(ctrl, CONTROL_CMDBUF_EN, 1); // [12]
>> +		val |= (tmp << 8);
> 
> This is to enable a hw_queue. So it could be marked when a hw_queue
> is allocated; IMHO, VMM should only allocate the hw_queue, when the
> guest really uses (enables) the buffer.

There are more than one registers to control each buffer. Some of them 
we can assume that it will be set last (e.g. the CONTROL_CMDBUF_EN, 
CONTROL_EVT_LOG_EN, CONTROL_PPRLOG_EN bits), and use them to trigger 
hw_queue allocation.

My original thought is to be explicit and separate the programming into:
   * Guest setup the buffer base/size -> IOMMUFD allocate the hw_queue
   * Guest enable/disable the buffer -> IOMMUFD enable/disable the 
control bits of each buffer.

Combine these steps into just hw_queue init/destroy might be okay.

> 
>> +		tmp = GET_CTRL_BITS(ctrl, CONTROL_COMWAIT_EN, 1); // [4]
>> +		val |= (tmp << 9);
>> +		writeq(val, vfctrl + 0x20);
> 
> The spec suggests to set this with CmdBufEn, so it may be a vendor
> (or hw_queue type) specific flag in structu iommu_hw_queue_alloc?
> 
> And similar comments to the event log and pri log buffers as well.

Lemme see if we can integrate this for all hw_queue.

> Overall, VMM should control the timings of allocating these viommu
> hw_queue objects; then kernel would just enable them accordingly.
> 
> Nicolin
> 

Thanks,
Suravee
