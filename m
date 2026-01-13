Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0F30CD87
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 05:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768281138; cv=fail; b=Kr/e5VPNl8WqasofORigTjSzYNi4LjxKe0JHFnv/IS/Q9us5nQo5MjZNlnilFsEG/lakel4amZK2y/H6/HSwLmES09Q9JbnUx6e+7SdXWuc2OvzOd7CjTcH0eyU4eGEPjBY2cHcMe6xcAZRFfcfxLCIj25A0FkMf7LPSnc22Smo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768281138; c=relaxed/simple;
	bh=yQxkKHBgQZduqxns7wIZZNnmT176tZJIE28pPMqNe4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AEGDoZG8kV+rGaYZwmbgif5qSIoHvaKK3BRNfQLl9V8MXzJT2FgljKXua4AVNt8+PxrJWmfboF360fI6jF/S5Vl6xn+06gMXw5N2uxNxHqm0Ei4FIXAERicSmK2xsEQr/a8oi2m78KBtdYDWf2pNA+7BkqwpOJ6HHdpUfYOoBVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G30LhA6D; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G30LhA6D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gosL80GCbPsa9uSRXdTEBj87Ocjnt45uv8SmbElAWsAJ7w7Q6YPLUapk1UvdQdQQgJN9/kD2qcJDjRifNAum8RqqWANPKk2kO0/Qm5rU8xTXuG5f8MIJec6Iq0CcMgiKXAFFBzWImQXdA3p3dbnzkTOkyY0M+dtwEdOPQFtQPSUdi/9gYxW91W5R75flzu2kbf6LYBWD3s9rNIarG3SvCqA5WaHtXb82AMgmKXirOnplBCuWsxrrk+NIuLB+NZzHO1IzAJ49EQ3ybbPgs9iiD02VkMHLImaW2muUONIBfQ4F7fmlSzRC/xdjtNx+U5K2PD0wzPFsMOZGpDgl+d7FbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SiyoqWBdk8SzBc3vUzM1dge/dOQ4gxwpFGDlF/OPH4=;
 b=fZ+9+2YwdsYIcEsZu4s3mzS/MjiQLEMa2zWuwHjZ5YPv7mIM6AgFN7Mo75hwxWPgFebVCK3wKERFXt1a4G2NgSYRl7ScFa/nkGaiaq9/RZNRimV2VcSMycmr0cHxSfVELaRncE3benIYSlJ1OPzr4R9fJX2UFhSpAkf5v65WH8A914wx1vUccsdX5Z/OVzlacjimvnyzEJPmeaKwzr0U01YhpZ4i1w83JAqIrE1IdhTxUDek96K7IaMuqVw25+3VcVCxQhWR6+xXqc4wH5ar4XvPsXqZe5RIKhT2zUh9n98lpvItwT7fF3H5gjEtxFE9t6WHYH0uA4lJfF/vV2ML5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SiyoqWBdk8SzBc3vUzM1dge/dOQ4gxwpFGDlF/OPH4=;
 b=G30LhA6DjQ8dXDA76LWcV5nJQJp4uG4i24bHsYeObkRZf9INuEEFAp9CVe9jbFrCvJdta7xXlAE4aNyBGLg8ZEKIBRU8WAUKYck0GX0c1rvUT7DwyAoZHNC2+V4pOo4qJ4XapSV2hhx85uazCwyuXmJtd+TNPMOIoU3J183VO3mvsfwiu3h+hofa/U5aCJqOwIOTm9GoWQ+/YDfcL+FtWJg53luDwe6TKN3GUe2dzT3yaQt+Wtqoqaj8uSY/4tHAz8LSrmWH2Y9aALmc0fQMtSdix/37DRnds2yi/8BpX0+T55XzKe49oqJvIwi2OQcfJxWGBR6fAQXwsjmxAqzIMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 05:12:12 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 05:12:10 +0000
Message-ID: <c8686af9-775e-45bd-bfde-25f995b59ac2@nvidia.com>
Date: Tue, 13 Jan 2026 10:42:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/4] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Jon Hunter <jonathanh@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 vdumpa@nvidia.com, jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-3-amhetre@nvidia.com>
 <23df682e-6d08-4827-994e-1bbd89e5c903@nvidia.com>
 <5e9a0ce1-a0ba-4a31-be95-99f349ec6028@nvidia.com>
 <e7d3e95f-a885-4b13-ab4d-bc82793c5396@nvidia.com>
 <aUROk0jRQoLmBRo3@Asurada-Nvidia>
 <b2df8ce6-d336-457a-8169-f2eccec3c12e@nvidia.com>
 <aUWeUapsFo3KZP7i@Asurada-Nvidia>
 <69e11fa5-558f-4fbd-ab3e-e8f3b8197df6@nvidia.com>
 <1a224921-1e67-4699-a91d-89930db6147f@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <1a224921-1e67-4699-a91d-89930db6147f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::23) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 3149d4d9-5585-4e09-7ae7-08de52624d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWI5eW95aTZySmRwQjRxYzRMY0JOVFNYa2R6ZTY5VmgwOS9TSXIyL3RoYy9k?=
 =?utf-8?B?V0tEaE84TUpOdG5zTWIxcnVsenBvZE5iVnJjVHpxME8wMm9LRC94bEpKa3NP?=
 =?utf-8?B?UFkvOTNRVndSY3gzYVVVYmlSNEJ0dURyRENGRUlnM0puV2VURlNiYU55WXI3?=
 =?utf-8?B?YkYxclZpUXJoT3VEeW9EQmVESTFwUXB1ZzRTcUJzMHpocTFyV3FZRUhGRnFk?=
 =?utf-8?B?Q1RyOXlYOFljcWlGUmVJVjU2dS9nV1NGRmxKVU5TWlVhUXIwV3A4czRqWjJv?=
 =?utf-8?B?Znp6cEJDeVpDNnBIck5xRldxSHM2cVZ3RUZVNzNuazJYWktnMnFDNE0xbGxn?=
 =?utf-8?B?MHIzT2JDMUJNZncwaU9QSWhCUUc3bTU1cUZWanBPSS9vQTZpOHN4Q1VGQWJq?=
 =?utf-8?B?alVvcytQQ1ZFeU1vOUtlclJPNE1MeWNTdkp2TVZhbkEzM2ZxUVhoV01HNXRk?=
 =?utf-8?B?NDFyWGhaR2hKbzRZVjRMZFZSQ0VBZjN1cjUveCt4cENxeUxwRXA5K3cxQitr?=
 =?utf-8?B?MGU0NzE4dmFqWk9Xb21Tczl1VEZrM1lrWUxpN1Fkbjk5bnpkU3d2TVdCT3F2?=
 =?utf-8?B?YU1Xd0pNZEdkeEpkYnVYOEk5ZDJyYXFtSzg2eTkxWFJBbFdIQnNQaGpIejN3?=
 =?utf-8?B?WlNFcCt4cnYrMTF3L0hZcW1RdjhwVUduRlNoaUNwNE8xeGozSUlKVVE4dlN1?=
 =?utf-8?B?dHRCdFNvQ0Yxd3VSdVhqQWRZTFM4ZFJlVk5yRkpzWTJzR2FRZUxLck1EUXlk?=
 =?utf-8?B?QVlrZ0hMeEREcmthei9uN0dERmVOcEdmYkl1cXgyLzIxa3I3UnNhUmVtOUdt?=
 =?utf-8?B?WVlQRlR4NjFXNUp0eW9HZEZTaTRPdkhudWswTzFVMzRyT24rQkZaQlUwdGdp?=
 =?utf-8?B?WDlUc0tDNEZwWndNKzVneTlhWmN4Z0xRNmtiK1ZoZlAvdEEyaDgvMXJTNEVP?=
 =?utf-8?B?Z1pZbytGQUZkVlZBZnF0L0Y1TmttREVoNUNSOHBBa3RSL21ScnBGd2ZTQ24z?=
 =?utf-8?B?RFV6QUo1ZUtXZmFRREZXZGhHVUkyZEd6Mm9XQzdpYXNiNjdtSVBCU2J3TzZV?=
 =?utf-8?B?cHhra05BcDlQNmFQQ0tCRnZvK04yK1pHKzRiWTBRZGJ6QXNaS0JrbDlkVEoy?=
 =?utf-8?B?UmFsY08rUWlWTHJXTVBMK0JQbE1OcTBRNmZrNG1qeU0wYitIY1R6NnlNa0dw?=
 =?utf-8?B?aXJTaWorQzc1UmRkclFUczJnTFUvUmMzMHBsU1BscUpJNjV3R01Na3NRTWdE?=
 =?utf-8?B?Wk5LdnpQcm9tdi9FZUdHS2YyMGQzbzQyQy91RXVvUGlad2o1N1Y0UUxXMklK?=
 =?utf-8?B?RTg5dDVvYW5Bdk5yQisxSG1sVnFRVnFhK0ZrTFVJelB4MnljU2h5L2NIRFlv?=
 =?utf-8?B?Wi9ITkpKaHBHbkp6SGpwU004dERtb1pRMjh1M1JON1ZxWUlQeVJYaFFhUndu?=
 =?utf-8?B?VEpKOVFGY0RkOEttenJCbEZJeXZlTlJwMzFhc2lnNnhwMGlDQjNWM2JrRm1v?=
 =?utf-8?B?blV3amo4ZXpNR1FzTUpTV2lUUWE1VVFHYUxlbHRVQmhxZnVHcHQ4MTZNQklV?=
 =?utf-8?B?MGNoKzJqTDFWSW1CWlNpYUJ2eXJicXhkeFBaRk9nVGsyR25WL2ZaRFlDMGdL?=
 =?utf-8?B?T3Z6Q3dXSG1tVXFaN3k5UEk5L2FCazB2MnB2dWI0dWp0clEzWmZnOS9ub2Z4?=
 =?utf-8?B?RmVWMThUZWwxREd4bHcyV2hzc2ZQNHZBSC96TEpobGoralNFNVZ3MFVDOFZz?=
 =?utf-8?B?ZzFDaFFYamkrYkVUbERKckY1Z3dYdm1kSkpDK1ZiSXRxQWJGeUNzdTRPdXVq?=
 =?utf-8?B?U2VVVmJna2c3cXAwc0EwWEFUa0lNMU9zWjBxVWJtbUp5N3lsOTQyS2gzMWJB?=
 =?utf-8?B?VXA5QU5hUmtoVGRnUy9CSG84Q3FMcks4MGpET2NpNGVuKy9TbHVpTnJtVXUy?=
 =?utf-8?Q?UI/JotVnvaQbccI8fuccqUYgniEFBu8K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWVSV3Y4dGEyOExIVWZwdVJvMWdmWTU4c2NTaEdGVUp1R0w2OTNoQ1B2bHFn?=
 =?utf-8?B?dENwa0Y5WmsrZmEyOW5OWFBSbHh1aHJzNDh4VlV1K2NaZFJYRWtJSWphUk1V?=
 =?utf-8?B?aFJMa0Nlb28zZ3pwbDVBTmlac3VkRk94OUwyUzhYUWVzMXRIeFcwZ3cxSEZM?=
 =?utf-8?B?UWtlYWVLZDUxNUJOV0tnbnZxSTZISy9CYmZFQW5nbDFoajF6SndTT0d1TmlY?=
 =?utf-8?B?MkorcHJUYlVSeG5zSHY1RU5DM1lCaHFwT1Azd2daZ29yeURpcjVNY01LRWsv?=
 =?utf-8?B?QUUzV3YvVU0rZERhMjd1Smg5K3ZrTHVQbmIxMlkrZ3BCaWJZa1lTY1dFL2Jl?=
 =?utf-8?B?NjNsN2hHeXdMUUUvdTBsVDc5MEQ1NDJzMjZUY0VoaFoyYkkvd3MvNTBSOXFP?=
 =?utf-8?B?YTVtWk5LMVJJZCsxR3ptMk5EbkNFTng3QW4rOUdBNWIvbGdBcFhPUkFycVZ0?=
 =?utf-8?B?WHF0RC9JRDgyYVE5RjA1QzlQeUJKVTVveUNOWkdNb0VLb3JZcitZemJ1aGFK?=
 =?utf-8?B?TkZDNW91WUZsc1dsODNEQytJNEZWL1UwTDgyTXdjWTd6ai9TbGUzQVA4Yk9m?=
 =?utf-8?B?SFk0YnRseVBVdVRJbEpMcC9rZ3pVTk5hbGxhVjd5MXE1Vlp5Nk03bkpYZW1u?=
 =?utf-8?B?RjJ0VE52Y3F0bHd5eWxKM295alIweHoxMERUNTlXc1dCSGU2NTBlM2dHNTNl?=
 =?utf-8?B?TXRvb3IwSHlPUTRhZHRwaXg5OVhOMGNKMFdkcnZid3A3em1lajZBcjI5Sk5j?=
 =?utf-8?B?MDl6RkJKMHRCTWVWSlRvWTFzNkhnMWgyazhqNjhEdzBLZ0hvUmpSUkxvVVVD?=
 =?utf-8?B?OTJQeCt5TXN1LzhkaTY4NGxIemZuYmlMcTh1U3RCU0x5Z0RTK3htR0NmZGpa?=
 =?utf-8?B?TVpwVGh3NUhIdHdZd3J0SGJuQ05mUFhZekN0MnFERld2NStDaW1XWFYyOWJ6?=
 =?utf-8?B?dyszVnc4c0EvM1ovYUxXejJhNVJvc0RrL1ZBcUZ2TUtnNllGc0ZtQ3dJenpa?=
 =?utf-8?B?aDdCRlYySWlLZi9lVWtKZWlGaFBxR2ZKaDIyZGVvS2xpZlhKazdFdk9yZHor?=
 =?utf-8?B?OWgyS0t1RENPcVBrTjBYWm5xNGhoR0dNMUlkV1BDSWdRZlJhY0hOK1ppUWhS?=
 =?utf-8?B?MzJOOTkvdVAzMUR3MzcxeUZDWWlkSVhTWStxMmFUWWFkakJyaGFCSzh2SHc5?=
 =?utf-8?B?T0txYlNZdnM1QmcwN3lrR1F4WjZXaXEvYjlKenRPcncxRUIyMWdYTHJCbTVn?=
 =?utf-8?B?VUxnRDdraGVIMzRkVmdaK3JwekppMnJROHFDelAyeTRBWDQzYlhVUk9POVln?=
 =?utf-8?B?YXc5RnJtVnpUNmt2WGhhcmlJeDJnck9QdllIV0ZMd1RtdXgwaHRrUStBOENu?=
 =?utf-8?B?enNIdHlSOXZDZ1UzeVNWMEQwWU51K2lYQTJKbSt6eFMvMldMUTZVT1pISDNF?=
 =?utf-8?B?dmVoRldzZjVmM0dxSVllRmdIeXBUY0lKSCtxWkVoL3ZZMlZUNk5LOEpObXht?=
 =?utf-8?B?ZldhbWJ4dmlKSENJYWk0eDFPc2tUVEF2NnJ1aDUwbGtMQ2UwS2c1Kzc5SlVm?=
 =?utf-8?B?K1NzT295TVF4RU14RkFPQmtIZFRveEN2QzR3eFJZV0FZTTdxL2tOOGEwbStN?=
 =?utf-8?B?WnRZN2hqbyt0L0gxblFVSUFybVFsb3BDTHFBRzdoQm5FOXlFOHZiK2JTN2JH?=
 =?utf-8?B?N0ZLYXdoWXRuM1ZoN3FTTmwxNnZ1YzdzNUtFNDdIZC9iNFprU3F4NzIrUTJ0?=
 =?utf-8?B?ZUdiQVR0WHV1RlJXcDB6UWNTcjhxRkc3ejY3b3JISVRDZm83RnRXelFWMzN5?=
 =?utf-8?B?b255ZEZmS3g3eGZFMTk4c3BSUXNIdUptbWpBQXB6QmtzdHM1YTRMSFhFNkM5?=
 =?utf-8?B?QnZXeE1VY1lYUjgybDJYcTM2TzcydkF4OUo5R3cyWFVBS2hrMEFXNWNPeFBI?=
 =?utf-8?B?U3JINklYdzBQMjJCdm1uMW1IeGx6ejlZWmFCeWFKVE8wMXFPMVF6bWJ1cTZi?=
 =?utf-8?B?dUc0QnRsWkFMYjRha0F6VUg4aFJOVEozeTJHM1V3SExMeUNYZjlOenlvK3Nt?=
 =?utf-8?B?OHhzYzEvWThXUjc1dUs2VzBrT09jdWlMUDFQWXUyNGJaQUdienJaWGxid0NV?=
 =?utf-8?B?ejd2T2dXNmkxbnBoRVlqNjFNVC95WkpGMkJkSVhhL3RiaWdxOS96WUNpT1ZK?=
 =?utf-8?B?ZldMTUVEd1R5SXg3empPSlpMc21uZzBNeWJIQnVzR2Jxd29LOGt4S05zK083?=
 =?utf-8?B?RTdDcmhBMkFQMWNOMUl4bk4yOHdyTjBmWVIxdGJVVlQ0bHVoK0g2M053SjRP?=
 =?utf-8?B?Tm9DbVRUYjdOMldVS1VQZW1odk1FaGRBNnhyTHRnM2tNWkt2RjUvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3149d4d9-5585-4e09-7ae7-08de52624d9f
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:12:09.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gO9QcuWvTMiXqxg+pyJv2BfbMsnp/85azhxmot+OW41BwqKt4GleLbgGiaXSxTI3qKoVzLv32DuY/AYx5O+bAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168



On 1/9/2026 3:15 PM, Jon Hunter wrote:
>
> On 07/01/2026 06:44, Ashish Mhetre wrote:
>>
>>
>> On 12/20/2025 12:19 AM, Nicolin Chen wrote:
>>> On Fri, Dec 19, 2025 at 10:48:22AM +0000, Jon Hunter wrote:
>>>> On 18/12/2025 18:57, Nicolin Chen wrote:
>>>>> On Thu, Dec 18, 2025 at 08:48:32AM +0000, Jon Hunter wrote:
>>>>>> On 18/12/2025 06:32, Ashish Mhetre wrote:
>>>>>>> On 12/18/2025 2:13 AM, Jon Hunter wrote:
>>>>>>>>> +    smmu->impl_dev = &pdev->dev;
>>>>>>>>> +    smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>>>>>>>>> +    dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>>>>>>>>> +         dev_name(smmu->impl_dev));
>>>>>>>> This seems a bit noisy. dev_dbg?
>>>>>>>>
>>>>>>> This info print is similar to what is there in ACPI path as well.
>>>>>>> It's only a single print per SMMU at boot time. Should I still 
>>>>>>> change
>>>>>>> it to dev_dbg?
>>>>>> Yes, I would.
>>>>> It's really not that bad IMHO, I am not against that though..
>>>>>
>>>>> If we have to change that, we'd need another patch changing the
>>>>> one in the ACPI path as well to keep things aligned.
>>>> Regardless of what is already present, does not mean we need add 
>>>> more prints
>>>> to just say everything is OK.
>>> This is how it looks like for each instance probe():
>>>
>>> [    2.709269] arm-smmu-v3 arm-smmu-v3.10.auto: found companion 
>>> CMDQV device: NVDA200C:00
>>> [    2.709273] arm-smmu-v3 arm-smmu-v3.10.auto: option mask 0x10
>>> [    2.709618] arm-smmu-v3 arm-smmu-v3.10.auto: ias 48-bit, oas 
>>> 48-bit (features 0x001e1fbf)
>>> [    2.716236] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 
>>> entries for cmdq
>>> [    2.719432] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 
>>> entries for evtq
>>> [    2.725898] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 
>>> entries for priq
>>> [    2.736051] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 
>>> entries for vcmdq0
>>> [    2.742553] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 
>>> entries for vcmdq1
>>> [    2.742586] arm-smmu-v3 arm-smmu-v3.10.auto: msi_domain absent - 
>>> falling back to wired irqs
>>> [    2.742759] arm-smmu-v3 arm-smmu-v3.10.auto: no priq irq - PRI 
>>> will be broken
>>>
>>> On a second thought: The CMDQV device has a very unclear naming in
>>> ACPI path: "NVDA200C:00". So, printing it gives us a hint for any
>>> later warning/error tagged with "NVDA200C:00".
>>>
>>> Now, for DT, it might be okay to not print it. But making the two
>>> paths asymmetric feels odd. So, is it really worth nitpicking here
>>> given that each SMMU already prints quite a few lines on probe()?
>>>
>>> Nicolin
>>
>> Hi Jon, Nic,
>>
>> Shall I keep this print or send a new version removing it?
>
> Make it dev_dbg() and you can always enable it if you want it. 99.9% 
> of the time you will not need this.
>
> Thanks!
> Jon
>

Ack, I'll update this in next version.

Thanks,
Ashish Mhetre
