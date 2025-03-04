Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC701FCFD2
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085181; cv=fail; b=QGfDvSxiOZEJmgbJn7BSx+T3c0DL3h+trUPfL8RuJSHxzUALnBp0k3EpCP0esA+zWAi5x39OLce0rdulusySvI8KzYe+iurx75Iv0Vl04eSF+hV9LR48lfd0Ntd04aw2veZBQqqxB/OzrLpo2lCdT8xMBq5l+wmPHiMpCj5eAxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085181; c=relaxed/simple;
	bh=aLlpBxXwd8tdqulkUW3fiVhn2yPEtS17t/RMBqXigjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I6S2SE2TwScQpdqKFd0M+GxMW+n2SmWdpvyoFmFQ9mB47V/Kw/si2cBNd3j9y1k0xVO2RvXALQbhJlDQIZ9hMwobBicksdv3j1TwolJk1ae5BnGkAp8RS/iqumwiVNv2dhshK0B6kDQf7bZjeWH/IWSQmzzosoVGdLHQsP8VWNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VTNUxEMz; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VTNUxEMz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tggKJqeFV/8D1QVi112vPgm6PtAwksrwWU7maG+Rv3swChAuaAoumk4VpxdtZuRIOcg+2iw2eHWwCX4ePs+1tFHlUAuW2novRadG2t+NM5oinpTCvd5XT2vBsbHawAcL1hZMrXk5JRS/WTbbNLDMjEkww2OuWsQ7Tkm1zljekAQwslcyysjjn94/FYaqoWPzop9kjCG+xOXzYc+VFazEF5JaUJz8wz7bwrA1A2b0rTmYXMTJFdV3XZnENntaqABAYYTYMH4yaGbjNNTJZY1Tmh0/8yOL21pXOBI1emY1TbrqJdmNddA6+MMXRO4Ef4EEC7obOGtEsfUGlwg+msGifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/A4U+VYH1XQwGVSrfVLqzkb0t+6+Juph/P8+3vp1Wg=;
 b=wZxYUz57Cp+0cyZQ4iLBC7kcTIWxi6VVpn7AeEWSt7/GNwdhnVUU4LkqRep5S+d/o6bmNIdBrdlGr6KwWvx5ClJODokKPG5etrygZvNzB8JU0dCkDoYjDTNScK5vHK+aAITIlal+CISmuF73ofDSDlHtACnLeNGhahZ7+NiYuD7ogCRP/1/Y1XLjxeGo+kbOaK5D6UOuHWqPvdkYQWQ/cKQKr99163zbmfPgY5gG/5FZT6LbLrIFrGKQAYQ+orIB8EQRvp04mdQ8dbHcc4FBfJwnmPKMWBwANdDOTwucy9xVv5gJ8JPq+uhePu4eu3PIV7mfL2VEU+uPzR8zPW8Txw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/A4U+VYH1XQwGVSrfVLqzkb0t+6+Juph/P8+3vp1Wg=;
 b=VTNUxEMzJEyGWu2uicuvbPFb1eqPGhSmAmPehKcbCnO/MN6FrCsUXKuzJIM+r1lj7+tsPQ76OBw1klAslY1lrnwJ98OJrneNOCbnxiEK7aTPYtrSxEh8mBxbHd0epzuI5GtZU7BOc4LMSnrDww4h8H6/1BKLDEFHHL5D99Mj0EE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 10:46:16 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 10:46:16 +0000
Message-ID: <f86e879a-bfc3-4217-ad14-5c27a2435c0f@amd.com>
Date: Tue, 4 Mar 2025 16:16:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Robin Murphy
 <robin.murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <2c9ef073-fee5-43c6-8932-a8cae677970e@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <2c9ef073-fee5-43c6-8932-a8cae677970e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: a42c0f0a-41ba-4c67-d533-08dd5b09c9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXhuKzgveS9GY0lRNzM0Zy8wYnhQdW13VHhReUZiWjVIUFJoN2RMeERVMW9m?=
 =?utf-8?B?NkIycTN2OGJQMis1eUtFR1U3QXkxZ2dtUDZ3Vy9mVTR4SndzRmwxdkxwb0gx?=
 =?utf-8?B?VC9VaTZXbUhiMjZGaFhMY1RHUmJkaE5SZnpkN3EwQklpNmM5SlJxcFZRd0cx?=
 =?utf-8?B?YUlBWTlVdDgyK2Nta1JoK3lseDhxR1NNa1V1Z2dQclM5KzlUNG0xdFFxNy96?=
 =?utf-8?B?OTBXQWYwUVZqdWpiYVdPNkIxaUVsOVR5UVBzd0kyYWVRR29QT2hPVUk2eXBX?=
 =?utf-8?B?a25iYzBtb1FzWlQ1RzBkbUQwcmkyTWorK1RjL3JENkdSdFp4Smp5VmluZlN5?=
 =?utf-8?B?bnNQZUN0RnpsN3JsOEFUaE1KNmVDRE5rSjJKeXh6K2U4YUVhZ2RaUGV0LzBQ?=
 =?utf-8?B?ckJsOURuaEsxRDJ3RENDQkhZVlQ5RUlvN3BMdVpVV2pVS09saHhVaDhkY216?=
 =?utf-8?B?WTA3NG9odEtJeVlqbU5mUTFvbU9SWXpQeDZlVlU2bm0ybk8xY3BQMnY4NlMz?=
 =?utf-8?B?WUoxK2s2YjQzZHRYOEZTbDFMSXJrT3VtS0NGREc3bE9McTFEaWhteXRwWFJG?=
 =?utf-8?B?Nmc0ajR2U1orOHE2S0lPc2VxSzB1cTB2UkJXbVdaV0oxRVFCTWtpYVVDY0oz?=
 =?utf-8?B?RTkyR1ZIWGxad1RSQUxqRTRUcXRlK1ZpUmZYZWpSWWVXaWN1QkdnL3lMNG9N?=
 =?utf-8?B?WDQ0V0l6ODNKK3JUdUZMb2wrazA0Vk5zVjlHSEh0ZCttbE15MkhvYkUwOWJD?=
 =?utf-8?B?ZHlYcXFWeWxNZDFoUjl0L253NW1OM2kzTGhxZDJsMTFYMXMvdnAwTGtmbUFm?=
 =?utf-8?B?SG8vMUxTQlB1a0MxSll5SnlHbzhiUzIrendLcHNuUkNSVXNYQlBRUU5wU0do?=
 =?utf-8?B?VGFxVFN5ZmZXWWdMS3VkaXBXTUY1STBnOURoWVd2eStaaERQMDh4a08zNGJq?=
 =?utf-8?B?VzA0QXpQdkVkMk9aL2NzUU55U0N4bDFFQmZUNnVSbi9wdlZxRnplVGluSG53?=
 =?utf-8?B?UzFYUWllYXNWRzhHT29MT0FPcFFHNXBhM1lIRmZoUkpqRjlXY2V6cHdYV1FF?=
 =?utf-8?B?a2czVDUwbm9rbGJUR3ltTjY3am1WY2x5VUd4OURxZUdpUUNMNDYzUVdiTVQ1?=
 =?utf-8?B?MFRsYlRGbkZTZjV0aXBUWnVFNm4yYjBzcmpMQUl4UkswdVQwL0VzQ3pycXNk?=
 =?utf-8?B?STYrZzRIRXlKQy9wdm1ldWFzR2MrUlk2OUE2VDg3SXZDcWNZaDhtck1nL0w3?=
 =?utf-8?B?OXIzRWhmaDJ3c0VFU0lHOFJtbTM4cUhlU0VxTXJLZmc0QkV0SEVweFl6Tkh5?=
 =?utf-8?B?WWpuS2U4ckhWNTNIbG0wbFFDUmNkRXVjb0liSktDYzM2cWRxWk5vY0tLeHVE?=
 =?utf-8?B?aFA0R0VmTDdHQkdLbC96dmxEODBIeHdVWlp6ckdrTmJTMUE4aUJyOHQzY3hE?=
 =?utf-8?B?S0ovbm9qM25TalBwaEh4cm9YdElhTm5sditYbGpPOWFSSXh4a0sxOW5LVW52?=
 =?utf-8?B?QXZBeDM0RWZkbXZ2eFdrbTAza2cwZnNnZ1h2Rll2bHpTZCt3dXB2c2NlZHQy?=
 =?utf-8?B?aW14VHRoRStzbTUwaGsvNkpMZ1o3TzZ5WnRNS3NnMnQ4K2ZHNFU1QzNrUkNo?=
 =?utf-8?B?eHkyazZnRkRxa1l6SkhJbi9RMUhFdE16UnpZMGh0N0dEMWpBcDZveGttd2RJ?=
 =?utf-8?B?MjhxaDhOZ3p1ZmFiOWtWbGdENWZnaWNRTkNINjl4YUVQZThYUFlDRkNIUkRi?=
 =?utf-8?B?TFdpVXl5Ui8ycUNScFl5RUJBZXVSUlBzVUt4ZGxjVWRMczlyRE0xeTFoSHZt?=
 =?utf-8?B?T2U5L2UrNk85RjV0MmJPeXNLcFhXWHJQb3BlUkJWMnR2T3R5RE4xZm55WFhm?=
 =?utf-8?Q?PM2X9iZjM/3ir?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDQyTVQ0bldTTTMwUXJwdU1Hd2RXdi92Z09UMXRCYlQrYTBPVm9HUS9TWFd2?=
 =?utf-8?B?cXBIODZobDZHckF2YlFQSFBOc1hyMXNGYzBzUkNYbzcxeTBDVjE1WkZiOVd2?=
 =?utf-8?B?S2ZNVlV5U1ltWEE0K1p0Wm1PcS9uUkdrOUtyUzh3RHFRMm9xUnNsd0h1SmRy?=
 =?utf-8?B?UGZMdFkrY1hnQmw5eU11SktTcExpb2NHRExDMTFXZDVBVGt2NWlyNXN5WUpl?=
 =?utf-8?B?ZjZ2NGZWYTBIYWlJWWtyd0dTeVowVXFZVU5qRVpGMFg0SkFVL05UOXh1a1dL?=
 =?utf-8?B?Z2ZVQmNmUWd4cmpPRWFiaWxGUU5QWEZvbUlTRTA3bzc4OEdHaHkyRkJmKzEx?=
 =?utf-8?B?U3NqTXZ3YjNMV0NOZzNUdTBQcUxoYkxQcFlaVTZQNFV2elJ6SkZ6dklRYW55?=
 =?utf-8?B?UWxGaVA1NHhSU0hFeEJObFpBaCt0WjNOSTBPeW1UeEpEWldEeWl4ZHdOdjI3?=
 =?utf-8?B?amNodjlUUFo0UHFybmRqOTVLalNBOXE2R1pKdzU0YzJNbGMwYmY2dExKbGt2?=
 =?utf-8?B?RGQ1ZndMdGd5dE9ZY0RVajFhN3dlNW0vNHE1NHc0ZVdLL2syV3RvS0t1UktS?=
 =?utf-8?B?MTg1Ry96UU9TNURQcEhXOVR0QVVRS0t3U0lnaFZiMGk5UUJHZ0ZGRGU3Q2tr?=
 =?utf-8?B?WUEvVWh2dDc4c2VMNDVZWXJwcUdNWTBXSDdZRW52bHQwcld1ZjVLeU1vUFpT?=
 =?utf-8?B?VU1BWWw3VkZBbHVjNTJQdGdtTCtIWjBCeXI1eURTdTFndVpSMTlQalE3MWVS?=
 =?utf-8?B?ZEFwWngxZXpCelR4SEQzbHRWRHhOcUl4bUI3VUFRU0FLSjhnOHhzdGZuekwv?=
 =?utf-8?B?aS85UXpUa3VtUkN3UytRdUVIZHlYY3k1OXhyTE1ZZVRCbXFSV01XTElvQVRu?=
 =?utf-8?B?TnNTUTVUTm5qZnVTN1d3TmtGemFKNTRmWHVobU1lUjVGUmdNY3MzdTBOb3lR?=
 =?utf-8?B?Y0gwbTBOdzUzNTdQNDY2L0xLWmpDZDZ6WnM3SzVhMGltZjRvbGlweW1zL0s3?=
 =?utf-8?B?OWZxME9JYnNPMjBZOEtTcjErUzUxV25RcDZqYmU1cU1weitvVFZIL1ZzMjNk?=
 =?utf-8?B?UWNhY3FGaWs3QlpTalMwTVp1SldNUE52US9UZEpUNWhocVRrcnoxa21BWnVZ?=
 =?utf-8?B?dVMyOVZ4em16cWs5dkowRk8rRFlZd1pEbDgzVjBSQU0wZHRucTBPT09ObXVh?=
 =?utf-8?B?OVR1aHhSUEJ6WnFkaXhOc3ZCSEJGZmY3QUluMGowQjJWQVpWRU1wY0Naa21G?=
 =?utf-8?B?cDBjWXh0QzlNRzBsc2JldFFJTGQ4Unc3SlRjUnZTZ2ptaVFieGhmQ0FVMHFy?=
 =?utf-8?B?ZGw5WlkwNCtoK2praHZVNTJGK2VPejgybG9ndDIvSXZyNG4zT2JyVzM2SGVC?=
 =?utf-8?B?bjRyWEQ5TDUwRWw4RW80ZGo2SjJKVXMyVWhscllPQlVCMFpEYXVjWVhVck5j?=
 =?utf-8?B?L2ZXUWdycWtJRkZGVWpmN1VQZUFpdElQd1NpTW11bHM4azJtNUFHSEJIaWVp?=
 =?utf-8?B?aVNieDBpRENDeGllek5aNWN3RXlJeWs5VUVkMHpiZFVTVVZ1d0xEeDVPLzhQ?=
 =?utf-8?B?R1RmR2NIengrQWErb2xYR3lTOGRjV2NzcVJtZWY3S0U4QWtnUWF4RlUramI2?=
 =?utf-8?B?STg5R2tlR1ZEeWJuWGhVYjZGQ2FPTHIxMU5ISlZPTW8rN1JVYUdOSVhjZEU5?=
 =?utf-8?B?c05CcTVWNld3d3p3OWthZktrT0hTd1hhd3R5UHNLT3FrZlJoREJ1V2I0dUt1?=
 =?utf-8?B?Z1RvbFJJR1F3cE83Q0N3YW5ZcE9tdG5vamU5ZHRKTnFSMFc0TWxMaHlXMnRS?=
 =?utf-8?B?WnRPZUFPb2publNqaTlremFwZzlDc0doSHVHL21Cckw2UElhQytQTThwQ0V4?=
 =?utf-8?B?bmhJRitOMDFlTzdlc1VwcXFFRGM0aFZRa0xyRW91Y3ZvQnh6OURoekptbUdU?=
 =?utf-8?B?emt0RnYzOUZTU0szc0NPSWVhc0N0eVlEVGlIWG01bTQzTjR5Qk9xWjc2K3h2?=
 =?utf-8?B?ZFdIRDk0VldzUzFXdyt0ajdqYVNjdVRjcVpJckJkQ1V3Sk00NFc3SmwxQ2dR?=
 =?utf-8?B?emU4TnRTbE1zdlZRclFnd0V3OVZyOUsyWXNTcmxndnhNTUpLbitHWitRMTZ3?=
 =?utf-8?Q?9lJjEuBBgzxUqh4XlWYfGmsWk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42c0f0a-41ba-4c67-d533-08dd5b09c9ee
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 10:46:16.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyrSLH+1pXSFTQ8zlX0UvykAycL2dymqUdbokzcxdsNZ6UVrO06gjyP65BxTmuDvIFPEM2k40Rs1JdA7TbYO7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642

Hi,

On 3/4/2025 12:20 PM, Yi Liu wrote:
> On 2025/3/4 02:38, Jason Gunthorpe wrote:
>> On Sun, Mar 02, 2025 at 04:10:46PM +0800, Yi Liu wrote:
>>> I'm also thinking about the impact of such a knob. How should we define
>>> this knob. Should we allow it to disable/enable ATS? Especially in runtime.
>>> e.g. if the device is identified to be ATS untrusted by the admin, while
>>> the hw does not support SATS, it seems reasonable to disable ATS for
>>> such device. This might change the driver behavior on ATS enabling. Intel
>>> iommu driver enables ATS as long as it's available in the probe_device()
>>> op. What about AMD and ARM?
> 
> sorry, a revise. Existing intel iommu driver enables ATS in the time of
> domain attach. While Baolu has the below series [1] to move it to
> probe_device().
> 
> [1] https://lore.kernel.org/linux-iommu/20250224051627.2956304-5-
> baolu.lu@linux.intel.com/
> 
>> ARM enables ATS when a PAGING translation is set on the RID or any
>> PASID is used. Otherwise it is off, eg for RID = IDENTITY
>>
>> This seems like a reasonable thing to do to me..
> 
> will it affect Baolu's above refactoring [1]? :(
> 
>>> On the other hand, we may just define the knob as sats required or not.
>>> This is just a knob to let kernel know if the iommu driver needs to enable
>>> sats or not. While leave the ATS enabling policy unchanged. This means
>>> we need to probe the sats capability of iommu hw before creating the knob
>>> in sysfs.
>>
>> If we add some ATS control knob then maybe it should be able to
>> disable/enable normal ATS as well?
>>
>>   never
>>   always
>>   paging-only
> 
> this can be considered policy to the existing ATS. curious, why paging
> domain is special here?
> 
>>   secure-always
>>   secure-paging-only
> 
> and this is the policy of secure ATS.
> 
> A general question. Can admin op the knob if the device has been attached
> to any domain?

I'd say, it should be similar to "change domain" interface we have today.

-Vasant

