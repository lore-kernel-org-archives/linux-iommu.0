Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD779171AF
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727847046; cv=fail; b=tYyrTN7QfY7R9ttDR7AImd0+fZzhiHiaRyWzNMsRkenImNsqR0F2Xc7X41VsyDjcDqa5V3j3IsG45xRNPZlzp+OTghEIyg9i6+zcSw2AVTvkin5TlfFamcWHeKvSbLRkHFkMXTuQlrKnDME+sus/Lk++tjISejbz4Hj2ltBDrWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727847046; c=relaxed/simple;
	bh=8Tvv+6M5UcSpQJVlMpKgAOtqbq9hLUtU8BEuLzlnlZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RiDyyodxQAjgCkmxgE1Y5QWUMVfgBIYWw2w/3TaRhlJaIfQHPgTTBkKByKqDPrpmdciX2h52B1YM725MfUrcIGNl615nxBxd4kWeESP8af3HoYvpv+dODUgSwIGpx2FHetfZAtDrNFAdwo8KnLVSCQPRylnjkynDY8AGadt2U/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F5XFuueu; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F5XFuueu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUbqphwJzd/8qcIRtQPj7tWUOmbwtxB5np77N0x9pU4hqNrN5K+7svJe5s9ZIo/KeQdVXNmsZI1Wpvs2T5wsTq9nyCGIqR+zv2zn035lDeUpNDQPIlstfGWIdtnjqe9mEony4qF80oP7u9TFHgm6qAb681XcccDMW7kBfiwpX1g852AQsj/BwBWb0/h7HhLoJvJGSgk0Nbv51rUG7RTUTItqfq2etPGbPShjlXt6MfT83K5rahlBcr4wPSz92Ompw37p9CX69gm+I6jK4PcP/HMPTnyXWDKkiFzpOlkxKBeQEXbUF1NyvapYLXdC1m/3kqzVUqSBdXjDzAf4vpKnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn5O348PTcN6HO0TXf5UwWHPTMPxM+kCC8acecdO2Ms=;
 b=u6A1X5/VNBp6E1ED4hmUMXtYycHbIB7SgjUxVmZxKvNIvnJ5w3E7vXcZtIShn4P9WfpCr6Afb7Yw8CviiNj+FPxSSsIYc+4Kz9hxPPol/sHv46Iw96GO1oF+K+Z7SfFtITMqJAHZ9YSfe72k9TdKyl1jONSTR7tKMn6qsFRlPPhv8HDGWQ2gKV79YK7PVC6FHJEZFOZps6WffNtJ4awwwYdF/jBD50dQzNcsGx1ggo+qYZl2gD8IWAm0kLuR6KAI0QlcNbJ17DP3O91zk6sn8vsXZ+foh6uKXKswT8CG3Byte0Iw14WPYHOOzUf3EBvD37RBCuqMBBs0cDsAi2wY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn5O348PTcN6HO0TXf5UwWHPTMPxM+kCC8acecdO2Ms=;
 b=F5XFuueuo4axM0HcvmjuL5Npipwc0f/X/9m+LAO84D2+QsbiqMiEkcKz7haD7O1c+9tHN2t89UqhwJJTEqY6OxIisBdeGYsXvVr0YadvhKwWn/32uutYcROBXaS34V2H8lrqozCF0r5KCNuHmohYDROpRzAdkFYUq0iTI4R2lQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.27; Wed, 2 Oct 2024 05:30:41 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 05:30:41 +0000
Message-ID: <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
Date: Wed, 2 Oct 2024 11:00:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] iommu: Domain allocation enhancements
To: iommu@lists.linux.dev, joro@8bytes.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 jgg@ziepe.ca, yi.l.liu@intel.com, baolu.lu@linux.intel.com,
 kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240911101911.6269-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b10f10-d49e-4fa5-10e4-08dce2a35aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzU4OGVubEVpNHFHTmxVZnNOTnpFM2JVcnZQQ0srY1pNOEllNkVjN1VCQ05h?=
 =?utf-8?B?MVpzY3JaZ3hlR09wSWZ0Q0F6eXM4OVhjWHNSVDROVWNQM0tRNlMyUlpma0hH?=
 =?utf-8?B?Mnl1QjJpTFdKOGZ1T0RweXVCalBndnN3K0V1OTdhSlR3MHRnOUF3ZFhTSWtP?=
 =?utf-8?B?VWtKejI5YVJkeHdpK1dMWUhMYzFNWGkxQ3IvaUVyUjRPaFp3WUhMTVNxalJD?=
 =?utf-8?B?b2tPQmtHa0xHZlVHVk4yQkp3U2k4TGRTeXNOTnVLbThxZ3R5VThzZUQybjhu?=
 =?utf-8?B?RHlvdzM4TEtMYUpSSjF4UGdMdHAwR2VjWVZSaFRaWFdVM2JocHcySGFzSUE3?=
 =?utf-8?B?RkRFVitvb0pWeUtock1Sd21nVzN4SXRiNzd0WllXeTAwUjltSWltZnhSenhm?=
 =?utf-8?B?RDQrNGgwK0RNaFFhcFNCUExENEM3cEhTRWRsVTNIWkhsams0OFVKUFp0c1Bi?=
 =?utf-8?B?VHB2cHBHekdMNVJtc2J0L0V4SWJBUVRZZDc5eEtYc1FTV3hrcDFuVnJGbi9a?=
 =?utf-8?B?bHdUSzM4V25Wa1ZLYkFNNHFuTEk2bVZkcW1KQ0VtOEllZVdPTGVERVNlUzBo?=
 =?utf-8?B?NVR0ZDBkK2Fja0VzMkE3L3FWTDFwbTIrZ3RDdjlLUCtPeTZrM2o5T0lOdUoy?=
 =?utf-8?B?Q3BaSG45S0tyeW1BbjAwMmE2MUcwT0srNlMzdVY2ZHNGem5ybkJyWlBKRUxq?=
 =?utf-8?B?ZmJtdVBodlVqWllZWHZEeUQ5OXV3akVXcmErK0F1dEZnc0VDcitzMkFqK2E3?=
 =?utf-8?B?T0RiZjd2VEpJaTBNdnRLN0Y3dzhnbnRRMTBMZ3FsQTVQVWlXTEMzYkFYUHNV?=
 =?utf-8?B?UnpQY2hoVGVuOGVYTUdhM3RvWUZOdDhCMU5LajRRRVlxMVR4YzZTUnFIVitJ?=
 =?utf-8?B?Y01DYytkYkdRVWJ0SFhDZDRNSXZGQU4wbklZUDVOVjZ1RTBqV2hmVW5jTzNX?=
 =?utf-8?B?bEduRDdtMnVDeWQ3SHYyQVp6YjlZcnd4N1ZKanpiWjJoSG91Nzl3ckhtVTRi?=
 =?utf-8?B?cVJrZnl0NlgxOENlVThtV0lUSEJZcmFpbnhGVy85dTJVR2xzcVlnOG8xMWdD?=
 =?utf-8?B?UmlnbzJGWVp2ckZZamNnYUlwV0hBdkdvY3gxcUN1WC9hMjVwVE5KQlJ0T3du?=
 =?utf-8?B?STlnNWlXaUcwS3UreWpSRVp1R3RsN2NMRWRhOVFlSGgxWEFYVi94MzdOL3R1?=
 =?utf-8?B?aTBxZjRTSnJTUzNiUDBkSHc3VXNoUlpvUVVPaDhlQitMbjZJcXJva0wzTGJN?=
 =?utf-8?B?T3dKNWlNZGx4eFRobUY0K2Y5N1dPS2x6R05OMm0zYzNiSTYvdUp1VHpHZ1RT?=
 =?utf-8?B?eFpxVjkrQzRGOTRzczY2OXRlZFo1K2MyeS8zNHFYcVlrbzZRRDNEN2JtdkJW?=
 =?utf-8?B?R21KWWc1c1kyc2pLdSsyaW9nWm1uMW1CTitreSs2TVV1U3lMd2lJaWJMQVZQ?=
 =?utf-8?B?UWVxOU4xWVdNQThjNnhCaG1NUzFRaXV0Z2tSeEJ6RGlnTWpmeXhWeGtRa0E3?=
 =?utf-8?B?YUR0dWN2QlJxcjRxSS8xK0xGWnJQSzVvVm0weWFINHRsWGg0cFNyeWVjTzRO?=
 =?utf-8?B?Y1l2TG9xZ0ZKWUpDakZuMng1cUVlT2FNY2pTR3VWNThhQlUxbktkeUF0NlZI?=
 =?utf-8?B?WkhQRmxtQUZuK0lhY0E2VFg4Y2ozUjU0MGxwRUR5RFBZYUx4S3FYU0dob2Mz?=
 =?utf-8?B?WnVIZzlQeGRaWm1SNTdKb0xIbWpzTFpFamx2Wk8xUEZqMjBaZ09laEpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHBNbmhkSmZoQ0oxZ1hZKzQxZ3Z6SGRZYzRzOGUySzVFbzdTMWZFMnR6bU1X?=
 =?utf-8?B?eEJ1Rk1vQSs2OVQ3bGwyNmp3OEV6Wm9NaFdnbjE0SlhFQ044dk12MWlUWTVN?=
 =?utf-8?B?UUUra3kzRHg3M0FzSlk3dEhmaldMbmhvcjNjVndzTHFET3JaL2NDWTk5V1A4?=
 =?utf-8?B?VGIrYjByK293dC9UWmI1R09VdElBZ3hqZXkzeXpOUVFIdmRldnZwMFJzRnZ6?=
 =?utf-8?B?QjVudW9wcUZ6Z3M2VVVvZ3RUS0o4TU45c2ZyaEVtRXNkTG1LdytXaGJIdWl2?=
 =?utf-8?B?V3hHTnl6OGprTWR2VnEybjRzcUpCK0xaK3orSTNrK3lJczI3UW1vRmtjQ2hL?=
 =?utf-8?B?UnVCR1c5cnRDemVNYndDeC9XM1ZqcWZNZU5TWXl1Z0xyOGVmcFpMb25pcUFS?=
 =?utf-8?B?NGdONnNPV0txQksvSHF0K0grQW1nMGpRSXRzZVp3dys5eGNlenhLV0lFbkh3?=
 =?utf-8?B?K3ZWcXdmeWxNL2Rkc2E5Q3hZVUU0M1lndjV2TStqKyttVnlHTE5pRTk0L3N2?=
 =?utf-8?B?L1pUS3A1TXpYZUhxWExMV2UvV1pSa3YydzFOckl6Y2FWY3ZWYnBMOUZRcEVL?=
 =?utf-8?B?NUtIUVhxQmZxdjYxMDE4QTljb0tDSjYwTndhbW45YjVuazFJWHJHeUEwWUkv?=
 =?utf-8?B?dWkzZElVZFUzWTFGNHRyeVAwM2o4UFlYcEdFNUN0WE5xbWpHNC9UU3pWREhI?=
 =?utf-8?B?QitaZUZlRHl3ZitHMlhpYVNFZCtHS3ZMWGQxcVVYZTE4bnRHQmJpTkpqY0Er?=
 =?utf-8?B?UkJ1NloydGlEV1NrOTNQZm80ME85L3prRGc3MXNHMFJHMFM0SCsvTmlyL0ts?=
 =?utf-8?B?S2YyOGpHWFplb0NpM2x4cGFxdWlKeWk5cTVBVERyVjV4aUYyeExWSWxjNEFM?=
 =?utf-8?B?QWF2c1JZTURGbjZjcGd5TUFLUFZGTnRQT0hnYjdqMVNrR2g4WEg3OUt1YUV1?=
 =?utf-8?B?eks1REVvNTdSbnI5RGRpTkh2UHpKZjV5UkgzQ3ZMU1VkV0dOQWRFTkdxWExh?=
 =?utf-8?B?c1lRRG1RQi81WDduTUVwVCtFYldZMCtadSs4VDhNUzhGbGRjQStXeG1ieVlN?=
 =?utf-8?B?MDZsMmlKdXY2Tk5DS2V4VUhsK2RQeEhPNjhMZDBDYkUwZ1k1NmZzN0xNZk1G?=
 =?utf-8?B?VHM4Qm05dXpqMmZUSkZGbXBLNy9DdElYT0tjWjNoWFlUSHZMSzBFU2RTa0dO?=
 =?utf-8?B?aENKeGJodlJnWWlVbUFLRHNZeGJHT2ViVnN5U09JVEhWK0pnbUVab0MzTzBH?=
 =?utf-8?B?bXdGUHd6eDZRNVFVajBKaUttRk1qR3I5ZGJwQzFpakV0STNaWmpUcGcycC8v?=
 =?utf-8?B?a08xOGlIaEhiUzR0U2E3UEFKdkh1UnNuSUh0YXBaQ2pTYmRtNSswSmwrUnMv?=
 =?utf-8?B?NVFYbG5QY3dXelVLMTRNN0VqaTR4Y1ZUb29ZcjVyZGtvcG9QWFFrekswamM3?=
 =?utf-8?B?VzdKaFlqMFpLWkRzdnU3VHBnQWZLckNGNTExeHM2Z0NzdFIyamlVa0JESklm?=
 =?utf-8?B?YW1Sa2J4SllzcUt6RjNzNGZ3cVgwVWtwTHBmbXluZnVabWlMNGl6dnRvd1N1?=
 =?utf-8?B?UkZwWFlyb3FJTTIxcFVsdmVWK04zNHYzam12bFRqLzNXQ09aaTBGL014STBR?=
 =?utf-8?B?NXF5Wml6blNyZHMzNkV0OU5kTENDaFFZWGlnajNENkowb0p2Z29EMkFzekdk?=
 =?utf-8?B?U1NFMVFZb3BUWHpQbEZmM041elNLYWtuQWs1TXBhYmxvSHBwM0hKREJGUngy?=
 =?utf-8?B?d2EzZnB4b3N3eGFNRitjVk9iTy9rQ2N0OGQ0VjR5bmZkdCszQmlTODBkem82?=
 =?utf-8?B?Nk9xR21EOTVodzhNYWNZWDRmaElxenIvaEc4UlkvSjF2UzkzOWNHTWdlY0RU?=
 =?utf-8?B?ZFpWanZoTXRaQ2dVdnl2YVBjV2RmN09RT1pEdHF4Z0RkRURHbXZBM0EvTzZp?=
 =?utf-8?B?WlZjUXFtc0Y0cnA2ZjZkLzJGVENhM2d2UDFkNTM0VHdscWJTaUIwWFZzSTl1?=
 =?utf-8?B?Vlh2NHFnd0dWMVZUT0x0VFBhaGNYZEpHb2pkU3c0a2ZrbjhHa2tuNVQrZXU0?=
 =?utf-8?B?aUpvNXRPTS9RVUdQRVNyZDRkNHFNTFF6SXRIM016SmNnQVlneGk3N1o3TUdH?=
 =?utf-8?Q?THMCxz+fS69b574K+yrrrHUTs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b10f10-d49e-4fa5-10e4-08dce2a35aca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 05:30:41.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNz0vQ5WD1VhL7/DGyFULvwSL2oMUqRnYK9X2/46GvMNxgtipatYo5mH0yceYUIhraBzrVhrrEQ+EMZHiytk2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273

Jason, Baolu,

On 9/11/2024 3:49 PM, Vasant Hegde wrote:
> This series adds iommu_paging_domain_alloc_flags() which takes flags to
> pass additional details for domain allocation (like domain with PASID
> support).
> 
> Also updates AMD IOMMU driver domain allocation code. With this by
> default it will allocate domain with V2 page table for PASID capable
> device and v1 page table for rest of the devices.
> 
> @Baolu,
>   With this changes (patch 1), to allocate PASID capable device core
>   will call domain_alloc_user() interface. Do we need any changes to
>   intel driver?

@Baolu,
  Looks like intel driver works fine with this change. Is that correct -OR- do
we need any changes to intel_iommu_domain_alloc_user() ?


> 
> @Jason,
>   Do we need any changes to arm-smm-v3 driver?

@Jason,

Looking into SMM3 driver it looks like some changes required. Does something
like below works?


diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..4d4af11c5fda 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3088,6 +3088,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 	struct arm_smmu_domain *smmu_domain;
 	int ret;

+	if (flags & IOMMU_HWPT_ALLOC_PASID)
+		return arm_smmu_domain_alloc_paging(dev);
+
 	if (flags & ~PAGING_FLAGS)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent || user_data)


-Vasant


