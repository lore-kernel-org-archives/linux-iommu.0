Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82629212EEA
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051889; cv=fail; b=Lxh21VGPf2CWtum+2wfFYJZ5TBrkaYuO/3aMvkQ6SJanIsDezT8I/eIIaxQoV6TcU7Ym1HOg9Syrf5u8/bISGqOlhRVQ7Z4+IwoPjNnWg0L0m76P0HKRrHHd0/7yBe55q3IAKhywciowKV+Gh8Z3Y8k8eY1pSB5hdWH2gTf4tTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051889; c=relaxed/simple;
	bh=U3mdR+6FVZzmQdhCDOzg8x+LuE+MMlYOox6iAfa1OV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tVUMm/YKWQu9Z9wyR4f3JhNw3qwLdfAYN5yQmcm3x+j5anfol2AjVMTFziyEQ3ZFYEk1NnotGo1BaSflCel3uiZx/r8oNEohVpNiJzHkLAy4Dg9zRQHzsHisDVq4pi0RzLm+j3Gi/2Pv+PQGAAhUeE30CnhwYKp2a3B2qb7JK+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QRN4LNSj; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QRN4LNSj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOfa4/kB5RWnzkHUu9Z+GNy3bOI8AqSYudXGNcQSDwlMTX+y1XR6TEYE6xrmFnJmaEBITj5fuq55Fc7feHvC3yDgySm5UlW+eDBxT77PNIDbFfaw2u/8aTejzZDHXyaoKHCS3X809R97ZIwzirTm+k9s+QJhw0ZceLfJKvTS4cXzRpbGVBAy92t1d0ESk+ioiQEZcD5Nnqhe64g5IJUZT56ddEx/PQM5CSeFgu56MLWrNKm4pfSPS3I1UkdcKq2DFGSTc0cTIUDaP9/7iHd05ZLY6Md4mAeZgj3Ghx7S1cyL52oQxF0qOW67AhDvzyEsisjRyy8nOhJ8U41Eu24T3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvIJRCXhl8nKSgNXyQZnDhyMW6wqH9DPN2MLA8fr9Gk=;
 b=sKckCHkG/VTq2+aU6dDhGWAPytrr7FSS2ZljmGQrEqIakOcCL81Kf95BM++ZAeWiJR5Gmt4VmHYBXrIgLredW5G6MAkNqiWIQOHCuLDiRIzMTD0COq9MWe371soYS+LK4G7ngQqo2e1mWS2DKOom1FEP6CzYCHMCCROB3QaenvfHV1LiZ42qudfyf98VRP4Zia460r98OPAcJyg82XNGBffMZy7z2HMAA/a9PRmpmzxQ8oe7ekQ4Ujkur+l0l7PWpsomQxvqDUW/LcPU4L5MOsOqXqTtKgv/16NGJotav+P8YqfYq1CDb7kEzRSFAoUxeCLFGj8Zln8UMa5JsDRAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvIJRCXhl8nKSgNXyQZnDhyMW6wqH9DPN2MLA8fr9Gk=;
 b=QRN4LNSjWNLTZd/PBku0sNW36hpbmIm1xx/UV7huV91YW0ZU/TrOgm/6nwqANa+Y9QyU/dQwm6NKWkL1A+37idooPXebrHjxfhSkegkULcPEFw+S2KpT2dzOmohp3et/LZ51+y9G64x1K5uRfseZRmdY8CPhicgt2ETOC24HfAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 14:24:42 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 14:24:42 +0000
Message-ID: <6d63014c-e7ea-409a-8b81-50149db9b52f@amd.com>
Date: Fri, 4 Oct 2024 19:54:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] iommu/amd: Improve domain allocator and device
 attach code path
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20240910065812.6091-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240910065812.6091-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9bce58-71b1-496d-9b11-08dce4804963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3o4c2V5ajNwYk1PWmdtMkZwWGNXbG1XS0l1VlhaK3l2VVdyWkl6LzZvdmNz?=
 =?utf-8?B?UmVBdDdpVFdaYzd3YldzT1ZhaDlmTDFoczZGUnhsZTlVTG1YNjFBSkRjMmFE?=
 =?utf-8?B?SW9iaExZTGllbGpHbXhIUVJpUGc5M0tFREE1UEpGMTVidFNRdUJuUTlCNlRh?=
 =?utf-8?B?aVRiSGFTc3RKOHFJa1ZmT0ZDcnRsVjFEOXNqRjdGd3c1RGx4OWNqV2w4R1Vz?=
 =?utf-8?B?RFZ2SVpRNTBSSzl1Y1hzYldaL3BxMG9uMnh2a2tDOXh5NzVWS3hmbzhUYjBl?=
 =?utf-8?B?aXdVcFZsU1RkejBDSTBETUhYNXU0MU9CTjBzTjgzUnp4Z3N3NE9RL0hDQ0Y5?=
 =?utf-8?B?LzJycnBzcjVwOE8yS2hhdUpVa2UzRmw1Ky9uR01KMmVocElCYS9scnVTRWcv?=
 =?utf-8?B?Z3lyenNFYUgxY0kwaDBUN2I1VGRJdG5qSXJIcmovTE1sVTFlVmh4MjZ4UTRN?=
 =?utf-8?B?b2EwaHpoYWhpUUcyR2FMSm9LdzJJdlVINWRJd2NtdE8xeXdESXNQMUE3VmRV?=
 =?utf-8?B?MTlQclFkbFFlLzBIY25iTU10aENuNkpEdWZQaU1SYm5vQXE0U1cybUs3bUtk?=
 =?utf-8?B?ZmdHUDk4OEg2b09EOUExcms2NTdoMGwyeDRYRm9lT0dOYWo5N0x6L0ZMeG1w?=
 =?utf-8?B?b2t2WC8vN1Fsc3R0V1EzUjJrOU1Wa3drOFVKMnh0dXVheEZlajBuWU95MGpj?=
 =?utf-8?B?a2pudU02djdMdUxJRkVYaHNtMlMwdHEvUnlFbDB6Slg5Z0lwd3hoY1N2MnBT?=
 =?utf-8?B?ajV4eTdEaDZVWm1OVktCZENtRnRjV1I5ZGlrTEx0bnUrT2NyOFVubHpMV0pI?=
 =?utf-8?B?bzU4K3R3UjJEd0NacUZrbTZpcVF4QllwYjJ4ZDJKbEcvT3FvOFlzN2tiL3I2?=
 =?utf-8?B?a0RDMmZPTDhtTkhNZCt4MHU0U2dlVDBkMzFXTHJXSTJZL2RQbWtXdVRGbjN3?=
 =?utf-8?B?UnRkWWwvZjVZWXAyeUlWQndPeHdKemFpOGV1dTBhc0VteHB6QXcvaFNva0F0?=
 =?utf-8?B?dVFieHM5aXg2cjlTUW13UDJscm9ZaUFnYmhaSHFTVGw5ODEyUXRKQ2QyMndI?=
 =?utf-8?B?UFFXczJzWkY3aGtMeXdUdk1ENHM3SUpwSnBkNHJQK1ZBMVVZZzJhcmpaMW42?=
 =?utf-8?B?QUJvazVGSDdOTXo1eEtDbU4rM1RMMDI1dEFNcjhRUnlKcEhCNFdvcFBUZTFp?=
 =?utf-8?B?RUt2T3JhWkwrbzRVZE9Na2lDczBVdS9PZzZiVk95b3JsR1JPWThDaFprck1I?=
 =?utf-8?B?ejA3aGlsOVlCVndpUDQvTTc2c1RKTXRlUENpQTlsbXlHc050MVMwbVI0MFp2?=
 =?utf-8?B?TE1uVHY1bW9qdkZRMzlDMjRZenVCUlFRSlc0bHl1UU5NeFF2OU05MldQOFlF?=
 =?utf-8?B?ZzBiUnJGUkZoYTg2TnNiYWlHbisyU0VWWEpMSTFMWGl4VkVHdkVvcW5kbjJa?=
 =?utf-8?B?SUJwSmVROWxhcDFtWFNDUFlQUktpd2lUbnZPNlQ3amk2dDZOSXY4blozSjYy?=
 =?utf-8?B?R3kxcDNNcThvOGQ4NDRWTE52RjRNck5JS21KTCtFM3Z4UG5UdXdOSytadjdl?=
 =?utf-8?B?S2w0b2d3eFNiSTh3K1J2S0dNbHNnYjBqZ3dsWWFaajBCYlNqd0xhd0hka2ZT?=
 =?utf-8?B?NERyTzNNVEZCOW1WY2ZBUFNadERvZzQxUmdKemx2ZGhwc1F5bEdndmlKUTAz?=
 =?utf-8?B?VlM0V3lON1gya0VudmtZdUtxSEViTjNCb2ZoSzdHWVZ3OGI3YzBoNGZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b29reUMwdExnU2YwU1pQRTJQNW9BOVZ4SjVHQ08xTmFxTGFEaWVXWlZUUFhY?=
 =?utf-8?B?QXNna3hDNU16c2NQdUs3V0RtNmpKNGdIOW1rRERUemJTL1BrVjBBTlVDMnlq?=
 =?utf-8?B?MUxXd0ovWklTSzdFN0c1T3VOY05ialU1Ky9ZLzlRTm5kYkNLZ2V5dHBtOUpQ?=
 =?utf-8?B?TWdaU0tMeC9HRUJyZzlIYS9RZDJJMnlDMngvMlcyWE9KWWNIOVlaSUZHRStm?=
 =?utf-8?B?RkxUdXdJWVdRTmxGM3hqQTVBdUtsY2ZKMU1IREFQYnRYVDRwUGxoRWlFR1lE?=
 =?utf-8?B?c1NkUnJGZXExTFovMW1qY3pPbFRLM2ZVY3RzZjJNTmFoN3RQenFLVWdSbnFr?=
 =?utf-8?B?V0NZTXFLQVhwdW5XcG9zTGRoTjBvTzcrSzdpYStFR2UvWER5dWlsdnozMUN6?=
 =?utf-8?B?VFVFbFdFdFNHZFpZUzFVVFJXaTZEc2gxcWVXNmRqOFpJOENBbmdVaGtHbXdY?=
 =?utf-8?B?RGNMR3k4SStUODZ4ZWNOOWl2NmNMVDVNdFN3Mk5DQ2czRUE1Y1BHY3NUM2R6?=
 =?utf-8?B?NGhqMGthZ2locVBJL0pPRUhYYTlzWG1QMGpGVVhlTnNLY3hWS0dLVWVtNFRL?=
 =?utf-8?B?SXRCc1JoNFNBZWc2bHpNQjZLQTNDdnd3YUtIdlRWekFVYWV1U0hHM1hhV3lF?=
 =?utf-8?B?aUFvTU5QSkRuMGhiMy9uRW9CYjdnd3ZWZDN5Njc3S0pSV1Zpc211RkpKZGNX?=
 =?utf-8?B?RUxWNjJOUTlVaTA3QUdiZVp3V0srMjM0TGVob04rTVMvT2JrdnBqd3ZKaXhY?=
 =?utf-8?B?T29NaUZETFZ1SU1FNVFubzVaNjYweHpWN0NYcFB1K0M5VGFxazZ3YnFMUGUz?=
 =?utf-8?B?QXhVdkx0UlAwOXRpRXhrcW5tM2FHS2diVVVqWkJyb25ETG92b2hMRlk4L1Zn?=
 =?utf-8?B?NzltWDhVVlE5SU53ZzdQMlVKTjFtRVdHZnVkQlpyZFF3aXE4MEVPRzJzaVBt?=
 =?utf-8?B?Tmc0WmRiZ2J5K3FNa3Y4d0g5SmpaS2w1R0Zpd0dkQXY4Vkx0Y0FIRDZFNjA1?=
 =?utf-8?B?YWh0cHBpMUlzSFJPRGFaYUgwMnpmemJXd0JKbi9PWWRZWmRrNm1QM2o1NGJs?=
 =?utf-8?B?S1hWbDNsczRuYUFLUGk3Ykx1Rk5tTnFib1dDTTRQd3A5TGd2NmxvZUNxZFg4?=
 =?utf-8?B?Q21DMXJFK2tJS2kvaXQzRWVtQ2c5OUFzS1pXWDdxU1RlMHE3WmFFNG9EeTdM?=
 =?utf-8?B?cEs1ZlA4emVGNUxlbWFQbm9JRE5FL0lGdDcvQWRXUnFXVFhXZHFWWG42NVZB?=
 =?utf-8?B?NjVBR1JvdFVtL0srWHdQU1I1Sjl5TDhyeTlyRnJOZ2RmRTRoRU9YRHlCemt0?=
 =?utf-8?B?dXlXaHpDbVJQOWpGUWx1dUx1bTdCaFE1V3pkdU9QSGZFRld0eEpMRVFlbDdy?=
 =?utf-8?B?MDgvYlpmUGw4VWROK1FoWlR6M0FIRDBUdDJwaVduei83d0l3dE5hekNJaXBs?=
 =?utf-8?B?YWZqT1hYdDROTzdrUnNncGJwUm5UdEY3aUtyK3paTjNIckZ1ZmRQc0dmalor?=
 =?utf-8?B?dlZJZEtHSWZUTWxXQnY0NFZGSWx5M1l4TVNrWFpqVytlUmFOaG4rbkJlNkxE?=
 =?utf-8?B?aTViLzVtNUpQZStON2dqQ2tSUUlwU21WcjF5cm94dis0c3hzY0ZLVkF4RGxk?=
 =?utf-8?B?K3N1RG5naURPVW9NZ1ZlY2pUNXpTT0V3My8wbm9QdTdIZXBqTlNreWczSm5a?=
 =?utf-8?B?dy9hOGErT2tERnlXNldLbm1uWmFjeTBGMXF0bHRhLzFBVnY4ejM5L011SzNy?=
 =?utf-8?B?LytHbGkwVGN0SzVVQXhIQndwUHpKZUMrMGFqMVppUXNOTHdqajZnd09XbEFu?=
 =?utf-8?B?VEVuWkUyN2x2ZThIbzQ3bzJvaklObW9ZeVZxNmw3MXpvSmtvQ2Q1MktyRlU3?=
 =?utf-8?B?RVJtdnRlcFNBVzBmMEtGTWNlVjNPdHZHMDJCODVYeVIvbG14bjJKcHF2QUJ3?=
 =?utf-8?B?d2lyOWFaQ2F2TUpKcnhuandRdEhOZmhTdzJWRzN4MmR2NDc1S2RwRXlQR1E1?=
 =?utf-8?B?T3JyM20wc3pXSlhzNDB5UEFPTE5pQmFOb0lVbzlVV0JmcnJUWGQxcGx2SHlH?=
 =?utf-8?B?YzNzLzNJRnhyV0pXelczRmQ3U21hRWNWNTJIL3pyc1Z6QmUyUXY1UWw0Y2RZ?=
 =?utf-8?Q?ZKw3SRFrPA9gM+qCJ8J/QSE4D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9bce58-71b1-496d-9b11-08dce4804963
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:24:42.1947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6TYOmT9oqoRuFmzicl1gR67TPRKWtHdzjfHUJD95G+I7390D1mFqxIaTRwGSqNv/Hv2GqhVQWIGQjFDMfrudw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

Joerg,


On 9/10/2024 12:28 PM, Vasant Hegde wrote:
> This series aims to improve domain allocator and attach device code path.
>   - Replace custom domain ID allocator with IDA allocator.
>   - Improve protection domain data structure
>   - Improve attach device code path and replace dev_data spinlock with mutex

Ping.

This applies cleanly on top of v6.12-rc1. I have tested on to of v6.12-rc1 and
its working fine.

-Vasant


