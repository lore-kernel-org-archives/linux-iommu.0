Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D061C5D42
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732819; cv=fail; b=m3kkL4fDUvc611DRe8q/TCK/UyOTLziTwlKbNSeoHr+XmjkTPMTKSzzwaDL+hKXUwAl0MmCroH4N4LuXqnDqFjPypO2j6cJQ+/LBG8Z4gDBiMyGJgAAgCUgG9TIoG10r1CvolutFRHv1tMBse42leMVL8GOBs2aXX3E3rshwwkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732819; c=relaxed/simple;
	bh=eGZkD9zPhE/LjHykyFboiT+qbsqC3LGrrUoUVBkBPlM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fb7vz/xaF93vCZ+Pla/aLqvqM4em/GFshx4yQKalLNiBeVtYHHw9yL8HU3gFiJBzIPlDRfCs4sLx/htUNnCUZeyFLfrWzartOJyW41hxNGbvdhfNSLeLKsBIooPbh/Jszgck7q6fhdhIl2U+Vw146bHgic9KvlFq6jrKsTI7Ff0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zkti+HeI; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zkti+HeI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlVONeOUTwsvlUmO/VT35E8u73Hp+P/cmle46yinK9wcDwxJNEDz82ruzphB43QtImjoTMtilE0Lqh+BFrFJ2BEs5XRtnUC5Qna82lhEaB9XRI9P/tzcM405ZSp3QzP0XJU3hNk4pAS6GNCBlcZI3CoGeCfO1Fh7F73BLPdKg+3tS/DzgGREWqZUGfdNk/UUxzzuxLm3Ppgwjb6xScisTe24jerN8FWRbFzmBDXFuzrYPLWsUJsiZAFD2wL19p22ryv5N9iEiBcKW6c4kiVFDItVvWq6Ru9UEd5DOcVAjCsPtI9qZhFYpDo3T5dAStAbxXkXFseNKiIvzWeT9kgJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H75Ea3RI0HzXvwaxeALvCMxJlE5MWVS3ew9pMSQ0ejE=;
 b=p+U/3B7yrR1x9AH977zJee5APVNgqVSit/UNNarvMN/x+SrKppSGy6PqkDv/71Nb1N5jRtOLD4LiNM2J9oBG2OEsAXOrvPh9K7fFKNu+KJ6vAfOVRNFrrI14lq2MXKw+/CML16lwvpuQzhZ+v6XqeDP7kZcvpqDJREEmRgnTfAsmmpxKA3xaWLZOs6g0KEbaL5AR8hzq+7YSBWJMFbGuLYaEGxP8SOt3N2YxGF43EqIUuSIAtDVyi60jbtxqAyMGF1IT8OWkXhQ7R07kx+iVF4FgsI2OHUudFF+OLYWTy394k/ud+TXzBK8RJquJ6IzQCmuydqpmvd8Ygu3mGPCQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H75Ea3RI0HzXvwaxeALvCMxJlE5MWVS3ew9pMSQ0ejE=;
 b=zkti+HeIJpY7X/zGf1UEY7G61eOCwpW1xCvN4hqt1EbTeZ6gNL5q/W671/4bW2fyVdPhndXmK/CvjDpLDALqw2Lkh7yg96WzggzllJNNREiVubFDKTvAv/aId7+VrQwkvwY7X+SJvtFkPHpW+/13WUsS4gGFmV2288d963UC45o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Fri, 28 Feb 2025 08:53:35 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 08:53:35 +0000
Message-ID: <bb359e20-2d96-4277-b341-c8fe9c16dad6@amd.com>
Date: Fri, 28 Feb 2025 14:23:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>
 <26fa08c1-4a3c-44a6-aba6-a35a0f308bc8@linux.intel.com>
 <BN9PR11MB5276D09A00E44AE7D220D7C18CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB5276D09A00E44AE7D220D7C18CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d357cd-3966-43b5-50e9-08dd57d562cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTkzVU9sYTAwdklFdzlQMkJhdng0ZFBHYm9KZ3FWZHQ3UUlLcmlKV3lMMjJS?=
 =?utf-8?B?d3M2SUk0S1dkS0c2Y1ZISDNlb1lhMklvN3o3OWRwWVlpOUpSR2NJUkFkcWc3?=
 =?utf-8?B?SmwwZFFjYlV4dUpmQ2JIUGpMNGNqYmh1YmRnbnAxRm84RHFZelBDVUwyTWRG?=
 =?utf-8?B?eVJlT1NMa0VCNjQxem5hU1NyRithdkp3eEdzYWUySDBFSGhXVC9ZbmdpaWdK?=
 =?utf-8?B?ekFDa3ppeXNHUUIyQzFFTURwL2ljamljdGx4ck41b2hranlsYUFJd1VidTBn?=
 =?utf-8?B?Z0hRUU5IanZHcjkwZTJNd29xdk9JYldHUkZjMFk2bWFUL2RLUVRFcjJOY1dm?=
 =?utf-8?B?NkdySFU5c21PNEJ5d3BFcko1S001djU5R1JCWXZJT2tGTjNQL0ZWMGNoNGpq?=
 =?utf-8?B?YnZWVE5qbnczcjdJV1VWemxqSndUZmQra0hIclRzWkxXWHFGOGVRelRPclJT?=
 =?utf-8?B?SWtGN0tZWUIyWHJCN2p3czFvNTJ1aWlMQUFiR29vbW9qQWlVc1VvMldBQ0pC?=
 =?utf-8?B?bGorZFVyQStKakp2d3JTMUlmOFI4UFhEc0NsRERRNEw2cFlxNGNFby9weTBi?=
 =?utf-8?B?MTEzNThLSkdQL0lRSU4ya2VRT2U4T3RaM0EyY0NjbXNXTjZJeFo1Wk9zVDI5?=
 =?utf-8?B?dGdkNnh3ZkZxVHpqMGRlS0g4dVlJLzZFY2pUcFM0L0JCVU1GK0ZHR1RncWp0?=
 =?utf-8?B?bm10alpsVXkvNVdHbndiaUNPNThCc2pucWN1Z2IrbE10M09aNlBXSWlEcVBK?=
 =?utf-8?B?M2tEM3BzQ0U1alRZNyttUHJqUFlaaDk2QWNmRE1idUdaMElwUUVySWN5b0hV?=
 =?utf-8?B?STJ0ZW5QeUw2NlpvVzNNd2MxdmN6RkYxUFF5bWR6a3FCamZXOXdGM3dxU3N5?=
 =?utf-8?B?TXlpWHhhVCthbTFYeVo1Q015MVo0eUlvZVkzSkhPTG5mVzlaTkh3bXFvd25h?=
 =?utf-8?B?OTRxT0p0ZElvelZRamhHb3l1dHhCK0NZZ1BRMFFPTmxaT1o3SFpJTlFjbEt1?=
 =?utf-8?B?Q05RU3h5YXo2MjhKUXh2NEJVUG1LUXhsa0xiMnh5Wjk1OExzSTRMTzN5bHg3?=
 =?utf-8?B?MGdBY1kxZXhCTmcvaENwRVVMeXc3R3F4NjV2UElmQXJ3WnBGWlFUdERQQ3hC?=
 =?utf-8?B?RHZXMzc0c3d4Y2ZHL2k2RVBGLzR5RzVPd3hJb1o5RnQrNVJ5YjIwTnB6OGZh?=
 =?utf-8?B?eFBqTkx2dW16bUxkU1lObDdFSkZOWCtzbTVIQXRwNW9KWnFBOGdQVFFQSDhw?=
 =?utf-8?B?RXhUdG9YQTlVOXpPS0cyYnNtelphSlZOaHBFcmdnNzdMSkhIS3htd3ZyTWxl?=
 =?utf-8?B?ZGhmbTBISnUrblF6ZDNwQi9FVVlmVjQ5THlzNlpsSjRkcW96cjVVb014cnZx?=
 =?utf-8?B?ZGRJTGR2SmpETmNNTnluSmJxT0FldVNaa1VQSlp6SjdGQVVzUUJqNUQ0YWFR?=
 =?utf-8?B?NFl6Q1dMTlZabER0c1ZXWlFMQ21BZ3FYMExUeUtZM2dkNEQrVHJuVmJWVUxq?=
 =?utf-8?B?VEtFd2N2Q1JZU3ViYk5EYThXYzRWODFTWXNHd3A3cTI4dEt5ZjdQSWd6Vi9k?=
 =?utf-8?B?Nk0rOWYzbUpSMnhMWEZXNkpJTS9yRGM1S2dRT2ZBYnNXME5qbmV3Snh4bXpj?=
 =?utf-8?B?QnNZMHNmWkpSOWdEN0ZCY1dyS2RrbTFicmU4RUR0TTE1bXFqOSt4ZkpBbG9z?=
 =?utf-8?B?S1U3azFvMWJBSzJXcnVYbVNlL2VQMHJsREUwa0pJQzFwR1VIRUNkTk9yVDVG?=
 =?utf-8?B?QUpTejZMT0FJdFVFV1JLQWZHOEVVK1hOQlN6VEY2QURoTnFVRkNJblZNZSs5?=
 =?utf-8?B?TVVPN2pxWGU4blVuem9RYzJKRUs4TmI5WEVNOXZRZWwwQTlDYVBLUXNTRm5N?=
 =?utf-8?Q?knHl3bPcsEEg1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVVacUhKV2R3ZGg4UEFtWDQ3cEV1cHFXSnZHVldzOWhteVplaEd3WEFnWXpt?=
 =?utf-8?B?c2JlQlZZU0NQMGFncVlpQ2JFTjlHZnR2Q1Q3QmUzZHY5NHB3TUJXbURUNHJ1?=
 =?utf-8?B?blFUY2VRZUo0OEVoS1lIUW1wZkNlbVkvOXZ0ME4vK0V4R2dzcXRsVUtrS2xO?=
 =?utf-8?B?b1Bvb0VOZFhEa0E2Z0lodGtlSVVEaTBSUlpEZmt6OS9IODdzMjBkME1LUmpG?=
 =?utf-8?B?MG9ibWd6cG1XMENFWUU2SldmTVNUWEtxRWpnZk1sWXNyR0MyNkgwRUZrNlNS?=
 =?utf-8?B?UFpXbVZhc2wraXlYNXdMV0RpWkhlNE95QlpyRTBVTU5lWWhWRkNlbEJ2QU5a?=
 =?utf-8?B?N0ZFeGUwZUFqc0hYVVZXWS85TU1uSS9qejFkNUdZaUsvVWRwNFZzQUcrWExM?=
 =?utf-8?B?bUkvdEtoODg0eTBCZGhjNFNBQ0U4MlhSZG1YR2NQSkxWYXpROUtJZ2NUZTU1?=
 =?utf-8?B?ZHF2ZmtQTUJEYXFiZkthVVBQbEI4WXBVTlU0S3NBa0g3QUloYzJTa2o0M05x?=
 =?utf-8?B?VjBoL01obG5KQ2tpd0liT0tLWkEzSVpJOWxqZ1Q0by82aVl1N0thUXFza3Yx?=
 =?utf-8?B?MHVPbDlXTGVUWDQwTzNGdVJmYUdaT29pNTJKSWloSWF1WElZV1pld3ZMUE5k?=
 =?utf-8?B?eGZTbndnU0RqYXZqZ2dDMFVPK2tobWUxYlR0TlpCWGpkNW52S0VxS3VZUUlN?=
 =?utf-8?B?S3g4b1BSWTZPOStkMDE2K25vNXVUWmFKQlZpTUE3U3pFZzFKZ01MQ2lXUkpE?=
 =?utf-8?B?djRZRHgyNEJ1eXNja0VEd2pRSTgzcTc3d3lxbnk2ZUk3bTg4b0xBa3p5NkZk?=
 =?utf-8?B?TFVPYXFGaUpvMEZBM1QyaDFteWxLMkZFcEVOazZMbnlPWFZVaGdkWW5zeUdW?=
 =?utf-8?B?SENLcHlOeVY3WllVVHVaRm5XMmdvM0RNSWtERnpyejNVcGVZY0MrUFRaWld1?=
 =?utf-8?B?enptejJneFZDTGF3QkFnc3Y5TEJZNFM1V3g1NEt4S1FUckZDdW9HZm5pK09n?=
 =?utf-8?B?MThKVUFoK3FlZ3RpZXdFWkdDUEVXN3NqTlNhMHk5OEZNMFltT2ltTGhCME52?=
 =?utf-8?B?dG1uM21GREVYOW5EOWNCOU96clNNc3ZzK0FicjVKeWE1RE5vQWdFQkIvK3ho?=
 =?utf-8?B?c2ZDaEhpRm04MnVqd1VET1pKOHlKNkpWTXBkNjVEZ3p3WHVlTFJnRHRlcUli?=
 =?utf-8?B?SUg1OVo3MlViemxMSzhLSzZmaXhsUGlhZXZ1Vy9hT2hQWE5RcjNUdXptRVRT?=
 =?utf-8?B?dU1nRWFIUS8wM0ZxbmFMbUMvczZkdDFpcHhPbUZLQnNoeVFIc2dRSXB1ZHFX?=
 =?utf-8?B?OHZFUWx0WFdJSDZOb1FYcTMvN3YxcHE1WTBHLzV5d2pIZk82bkkwaVRWZGJo?=
 =?utf-8?B?SG9HZzRyOTYxUjBCK3VYNzVjODZud2JjSGVBb1BCNEJVcFFOY1hqdTBKcUMv?=
 =?utf-8?B?VUdEazJVQzd2OW5rRlcwUS9RTmY5ZWoyTCt5eEtsTk1INllVYlBCQWxpY0Yr?=
 =?utf-8?B?K0pNYWswYnFOb1RjUzJqc0RpNXpGSFMwWVhSRkVqOEFKVlFpdnJOalM0WTIy?=
 =?utf-8?B?b0UzNDJLdzJYa2EwMllNSEtUcnE3RUxHRmRhejE3MUZiT3VpNGNObmpHNnZ4?=
 =?utf-8?B?cEJ0UmpmSGY1QlJzUUpXYzZtSUVFV0JlYXc0RVgvK3dzY2JEZ3A2YTNPNEZl?=
 =?utf-8?B?WnNuQUNNeE9sMlNDbStoR1Awc1ArREt3ZkwvMkhWSVh5YWFHUDAvaUxKcldK?=
 =?utf-8?B?ejJiRkdJb1JFWDJ1M3VXL0ZNTUh5V0x2Vm92eHo4V0JDM2NxekJTNjhST0FN?=
 =?utf-8?B?d0NYRFRaYmlGd09VdXJmUmtlc0VHckhGcWdlcmFyaGQ4UG5Pa0lCVWlGbDJF?=
 =?utf-8?B?enFyRDEvcmttNkNDK3JCOTdGNjFudTB5V1dDcnBOL0syU3IwcVBGbHloa1VL?=
 =?utf-8?B?ZlBEWkZnQnhWcklxM1FNUCt3MWZWOWt1TUNIU1R4Q0N6WXhDTnpxb3haR1Ar?=
 =?utf-8?B?ZjJXTVRtSnVIYmVpcGVvekZHVkVDVndkU0hQZ2EyeVVUOXBGZDVjaStxQkY5?=
 =?utf-8?B?RTdEY1FNSXJJVzVwRWxBYXAzaTFVZ3ZMV0tFbml4bUowVVdUOG9KODkwYUdj?=
 =?utf-8?Q?d/wmX0lZCOIfZcGuVIfutN/30?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d357cd-3966-43b5-50e9-08dd57d562cf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 08:53:35.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hzrLonQnrxpmXoTYr0I0n/sBBtU1SG4I8zneNIlPZd0RTLr3ZLxHe3sr1b/TH5IR1a6PIxoLMwTVqnVb4LIAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

Kevin,


On 2/28/2025 11:45 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, February 28, 2025 9:48 AM
>>
>> On 2/28/25 00:04, Vasant Hegde wrote:
>>> On 2/26/2025 12:40 PM, Tian, Kevin wrote:
>>>>> From: Vasant Hegde<vasant.hegde@amd.com>
>>>>> Sent: Wednesday, February 26, 2025 12:47 PM
>>>>>
>>>>>>   3) TA is an IOVA and the IOMMU runs it through the full translation
>>>>>>      to validate it. ATS is just used to signal non-present
>>>>> Yes. AMD does this when Host page table is configured.
>>>> Here 'signal non-present' implies to support PRI.
>>>>
>>>> But...
>>>>
>>>>> We need to consider various scenarios. For AMD:
>>>>>    - Currently on baremetal, we cannot enable SVA and Secure ATS
>>>> ... here it says SVA/SATS are incompatible. Any more background?
>>> Sorry. I should have explained it better.
>>>
>>> To support SVA (PASID/PRI), we have to configure domain with AMD Guest
>> (v2) Page
>>> table and host page table will not be set (DTE[Mode]=0).
>>>
>>>    GVA -> GPA contains translation and GPA = SPA.
>>>
>>> On ATS request it will send GPA back to device (which is actually a SPA). We
>> can
>>> support secure ATS, but ATS response will contain the SPA.
>>
>> So, the hardware is configured to work in secure ATS mode, but the ATS
>> is not actually secure here, right? AMD's secure ATS relies on checking
>> GPA to SPA translation; however, GPA is always equal to SPA in the SVA
>> case.
>>
>> Am I understanding this correctly?
>>
> 
> Looks so.
> 
> To support secure ATS, the IOMMU needs a structure to manage the
> permission per the translated address (TA).
> 
> For #2 it reuses the S2 page table for permission track hence requires
> nesting and TA = S2 IOVA. It cannot support bare metal SVA given
> S2 is absent.
> 
> AMD is clearly this flavor. also supported by ARM.
> 
> For #3 it reuses the full translation (s1, s2, or nested) with TA =
> untranslated IOVA. This supposes to work with all existing ATS
> scenarios. Probably good for prototype development but no
> real value given it loses all perf benefit from ATS or even worse
> perf compared to no ats due to double walking.
> 
> Both #2/#3 have PCI topology restrictions e.g. CXL.
> 
> ARM probably supports #3 as a special case of #2.
> 
> For #4, it introduces a separate permission structure per real
> physical address, hence TA = physical address. It's supposed
> to work for all ATS scenarios and CXL, with some burden e.g.
> sync with IO page table plus more invalidations, etc.

Nice Summary. #2 / #4 is practically useful scenario's.

-Vasant



