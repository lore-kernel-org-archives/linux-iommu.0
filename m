Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8BF1FCFCB
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083368; cv=fail; b=hxwNrfEM9+Vxztvi/lwTFC6Wm+J7RXIlS2TRJ7A0V+GOPsEDgEXXU306r6C3/VzHoVb3tQNmRH/rOeGogAZeZw8/Kvu89z5quvFg1VfRFnI74Mao1rPO9MkZ3YxYT5PBTcJje++iFtcJOA8rjApN22k8jY5WjNXW8JM5aL5uBU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083368; c=relaxed/simple;
	bh=h+c2Z9/JA+EuF3r3g8c43R8MkQGX1XjnM/E4D9AIZRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JspZCcrq7a1H6JjPQbQ/69ZUHQmfxh56Z+1Q1Ke8yhIjInBHc21W5fwjaL5Y7LfvYuS6fXIpLdYlZXI2jV5dLcUOVRxTgEp3YYpRhVYU0R+yNyxlG1DiTAq9Mtnn7dWIbOe08Zxe7iN1QxPBBvUYVMfGQkCu1ISZsGJcKNxBGY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M7EeSOnT; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M7EeSOnT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3Up7SIBk2BScTCh3+GEnwEUPEXMA01SZE0/d24lJmUUw3ARxe+NqT6wcCkCwnIkv72NNgS7yGaPC2nIF23TFOaVXCrp8/gnQkSZ1wGCKhvj4xQSzsUMwiPIyhjM4iP7XgG6V7MNJJHpnqnsx9GKTqbcAt84pr9ulB+dSnAq2Ffpn7zsaSPzZ4MGG4A+53ATmx2ajVz+alKrFYDYWMlnEEG6BrgmgwuLxhjy92XpuNUVwOSUbdu6lQLnt9G88GYp8GpOeA0ZMvF28rcJqfCcWGjA5z5SaNS/dT3y+DPQBj0k5b8jy9mq2aRa+nFsHXn0bn70G5oDRTEtQ9i8kpZiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsuLEoNnnz/ks0P2FhjTVSOMGjPBqsJlE62jzalUDeY=;
 b=XxL9gft+B4aQoKc769ugWYshxGvKDxe2VBhNcqwaimLd3TK3nibtiqalYqY405qAdfXehYq89fSf3cy5LLBWkj6I8D+euyDkgR8NHjwql0u6YiD02kiOspF9Sn2p7yd/yYp0dF+Sm1ddak6oSG6OV3dudR7fuoe3imfMgetf3pNaWgVZkwn12oafvVggYGBzfzBdOqksN8ZB3oHvaaM/+zwwt+bBqWvvO9ILd5BCoRBvtEwHv/HMzvXsM/eNXqxwuO1ONkjVrdmdIoWoo0WCnT13m+Mo4FTTg4jqHE+AIBLMPgzFzACkUBehbbZ6gcv7OXaB3YnzPUq+S3T7t03LDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsuLEoNnnz/ks0P2FhjTVSOMGjPBqsJlE62jzalUDeY=;
 b=M7EeSOnTmS/mVrfT83B85Qa61nI/MXVaxJnIs/P+wguYzss2IbvWyajIYLsF5E+zcu4i5F2PTLsv3Mz+nGg6eJGwHx6tmyfO3Bgfp+wsCujfPRMxKFRfXJ0yL4OSajjWSYOqtBV/mPjcQhGvVqzPM/uzMGivx1VUwdMOTQaiH3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 10:16:03 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 10:16:02 +0000
Message-ID: <391a2333-0373-4cd3-a858-349230bc7c90@amd.com>
Date: Tue, 4 Mar 2025 15:45:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>
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
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250303183801.GW5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dae37c1-b36c-48ed-ef78-08dd5b059092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU02OGxldWJkV2ZXQS9USk1HUXFpanhYbGY3Nk93aVduV2FPQS9aeUU2VDdr?=
 =?utf-8?B?M1JSSUpTQWhHemx3TloxbHkxcW95dTB3cUJCYTJMS1BuekFJY0poU2lVN2tN?=
 =?utf-8?B?eW1sUlVlR1dwREdGWHJYR0ZGOUk4cFJwZUFKSXZ3dG9QOEZVN2dFTlh0NnJC?=
 =?utf-8?B?YWxlbHJPN2xyMytQMXdHVVVmRE5FRitJcFMwSXZoRERCdWN5TkZ4dlYyTzds?=
 =?utf-8?B?Yk5iTG9qWm96NGNiNG5VM3cvNDNVTStPeC9sSGIrVkQ4WjdUb3ZUajJCUitl?=
 =?utf-8?B?UXgwVVdsMkZ1ZUNtY0UzdFI0ck9SV0NFclZYdy80Nm0rNUJVdlN5MXZvdm9G?=
 =?utf-8?B?dUltL2RKNGIvZ2ZTamJia1A0anR3LzFFTnNIcU9nTW1CUnZMY0dlaW5xdFpU?=
 =?utf-8?B?ZEFPSWx1R2VJY3VUeTlOYnd1dmZvY0NpZE1kcnA2ZVNrRlhGcXMxd2hrQzJL?=
 =?utf-8?B?VVN4Ykl2TkhtUU9IcmYrdGxlaFpKYmtJeTVwN3Nud2t1Z0hTVHhBMWR5eWdW?=
 =?utf-8?B?M3hRdjdNSUdwT3JxTTUrNlVUN0srM3c1WitxOG5ET3dhWFczajBVSS9yNTBh?=
 =?utf-8?B?U0lnZ0M5MEVFWFZ0eVhUaHZTbGZPZGJoZWhNQ1dsRGx3V2dNQXRGZU5RWm9i?=
 =?utf-8?B?ZVpzT1dURy9CVXRBVCt4TVNUNHBjY25YWjE2M0JCenVIZWhRZmVxMEhMUnIz?=
 =?utf-8?B?a3Y2UTFiUkkybTNSVnNITStWYlV2ZzNpMXpDVG9jbERXczBRY1lFNVFLbEhO?=
 =?utf-8?B?bkwwejV3K2E4TUFMMEdWNnU5bWhEVFdmNk1QazZuQWJJMW1XSHdEK2d5V0lm?=
 =?utf-8?B?QWlzM0hRUjEyN2hRam50TGJqSUNnZGJNa1ovbDJWQzdpS1ljQWNrKzdNZ1pj?=
 =?utf-8?B?U1k5Qk45WUZmU0NhNERlUXFtM1NvblJrbjBjRG9UaFRJSkVoYURMU0FBNnR6?=
 =?utf-8?B?QWtBRUFxYWluTUhaSHE0dE1BOVRTQWlBazlENXV4RjBzaXhPTGErN2ZNSHFL?=
 =?utf-8?B?RXFTT3kxT1lPbzhNcjZkdzdhaXdrZEFiOXlGaWVkQ2dDM2dPemJpTmk1MEJK?=
 =?utf-8?B?ZW5PTDBpTUFHVk8xL2RwZlVnNStFVVBuUXg4UEROdTNUVGJVd1pYN0NBRGNa?=
 =?utf-8?B?a3p5d3c5ODl3YUZNcFp5OC9nZHZyaGpkc0NaOUJIaHlIRzBCTHpMcFNZV2Nx?=
 =?utf-8?B?NXY3L0wzNHpQei81YUV3c0laeE1TNUdWTWpzaHZuQ0pBMFpPS3VySDNkc3lR?=
 =?utf-8?B?dlZEVWVsRjM0Z3JLcHVJVmF3WEw4eUU0cUVEeU5YWXUwdTZrVEpFcDdzaHdQ?=
 =?utf-8?B?YXQwdmlMVkxIT2FkSlVabm1pdE9mUDk1MEloZExoSHA2Tnk1ZER3UXVWeE9r?=
 =?utf-8?B?bjloQ29vTEFZdE1mTHk1SitMM1lza0lHeExyd1B0NHNnUFVueFN0Nnh2R0hq?=
 =?utf-8?B?d2NGdFlyeEw1WDZxWHZ0Y0Z0cFBESmRwM2NsU1pSYUJpcjBvR1F6cFAxaXhS?=
 =?utf-8?B?L0xBay9BaHladmdod1k1a1VuZll0MDN4Skw2ays4bGJYYS9ISWUvUHk1QTV6?=
 =?utf-8?B?RUtBTm54ZFNJV3RCdThNV1VHaGNYUEVNWGZST0JweWtqUEJFSVBhVy9jZHJK?=
 =?utf-8?B?MzdGTWRwdFNiMkU1TEZmZFQ4M0VMdWtDd0l3OGZ6QndpNitZYXhHellQNUp2?=
 =?utf-8?B?V2I3T3lMSFZhUlV3SlRnZkNJL25lY3MzeTZuT2hTV1BXNTJpN3JDMzdvOHlP?=
 =?utf-8?B?ZmpURXNKa28xMUlwMjY0SytoZW9sbFhyd0haMWxrTDk0RzZJY3JQVEpmdnh1?=
 =?utf-8?B?Q1hZMU5YRlI4RzNSUkkvSWNRZkxCdXJGSTBEdDBrMWR0Vm9HWXdoUk9oMGpn?=
 =?utf-8?Q?icsgqHbgLpXLz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHRuUi9hZ3NzSDJnWTM5ZHhDU0V6VTNZWDY4Wm54NmpmVG82ZEFPVHh2Q2dm?=
 =?utf-8?B?aUJVcXAvbG1WY3Y1SWFFV1lkRWxSQUMyZWR5REQ0SlE3Zk1YOW14djNFOUFu?=
 =?utf-8?B?cnRVaTlYRGtXL0FnL3cyVlZ2SzhUN0l3VzBKU1lHQzFIUkVsVEd5VTZ6aEZM?=
 =?utf-8?B?Vm1QaWx1TExzR2xWYkhvUFloQlBxOEV2b0RXZi9LMlU4WEVaUE5BdGlDaG4z?=
 =?utf-8?B?Ris3M3VZVmg1SUtZai9OelR5VGtzcFF0Zkpjd3hVV2p1cDB6Uk5jaVRsTDVx?=
 =?utf-8?B?QjJvcm1aRjZ1TjhiREl1OVpDZUQwTVdxYkEyMTFRTjFkOURmTFRjQnBERGZu?=
 =?utf-8?B?ZGY5T0Y0REdGaHg0TnlZWkJBRWpyOVpuQjN2NWdnME01ZlhLYlB2YXEzeVNu?=
 =?utf-8?B?WktxbFlFREdxRjZ0WlBFQkNHRHlXekZZNXhWL1dHbkFsUGZsRExKek1mVUVm?=
 =?utf-8?B?ZGZOTEJsa0QwcU9yZk5TL0g0cjBYeDFFaWJzQ2Yrd3dOa1BxN1BmYTdKaG5T?=
 =?utf-8?B?UFl0bXBvbGxnbWRXVTFISVZmbWNCeDU0enpMWTllRVpGODNEMmhXQkw2UDJT?=
 =?utf-8?B?d0pGYnNFSXJnUGFYWDFtRkpRdGNBYTdKT3d5MEpkdzJ1NlRla0lydHlkbXpv?=
 =?utf-8?B?Z0FaZ2dEakVlbTB0cTQyUGZBUW83VldRWDdacjlLNGVHTG9jK1hmeVNLb3RV?=
 =?utf-8?B?SUxyalJFeFBwVG95TXhCeWk4b09HUWhZdmxKdnh1dU5oTFBMWTRKMU43M2xo?=
 =?utf-8?B?WkNObHc1ZXZiUjRZWnZ1Y1JWZGhzS2lvVzZqTUZLVU52YXM0UlBKYUFLc2cr?=
 =?utf-8?B?cTdsNGJsVklEZTRJb0hVNmtEKzU4d05Qb2JtdDljQ3JDNnZnOHozOHdhUzIw?=
 =?utf-8?B?dHgwYkgvMEdpNG4ycndJSWlEcXBKcldpdDJpUndBSUNHcjNhMUh2dlJGTFdu?=
 =?utf-8?B?amVEMnVMSUlOQit2NWFHanBGa2xNRDdNaXhVTnZTQjlsY3dvKzMwZVo1aWd5?=
 =?utf-8?B?b2VSS3pyYWYzTzdFd1J0WHZ5TGhBc0h0R2o0ZFVsL1J4SEpaUHJZL3lPYkQx?=
 =?utf-8?B?QVhaMXhHTUcvYlRoelJjeHp1ZnpXcFlQMnJmbU04VmpybGpxMXVBSVNRc2ZU?=
 =?utf-8?B?SGhnWDZWeUZjZjM4VlZFbG1Yb3BoNkIyUnhONzJVZmxpSHBBU283Z05XWkVh?=
 =?utf-8?B?d0NGRVVNbmdqd1FQbzBTUDJwMnRZV0xrYkdVQ1BHVHZnVnBvV3JDNG1Tb0xa?=
 =?utf-8?B?cXcrOUFjSVdhMjB1WWNORXNMbUJibG1mSi93am9Wc2VNT2N5aEJyOHduR2pI?=
 =?utf-8?B?Q2phcjltOWY2Sy9jOFFJdWZIRzJaVDNWQnhFY2JWYXpWbUZEcHdqU2JVK2Z4?=
 =?utf-8?B?bkgvVHZaa2xKOGhabS82Q1lORXVsZHlWcjdOaEZ1d0hPMHFhY1RuV2IzSmNI?=
 =?utf-8?B?dnlZWXVTR3l5cDBpaHp3b2djL0tHRUpkQ0V6bU1Fajk5OTI3em85dHlMZ1Yw?=
 =?utf-8?B?WlJ0aGFTWTl4VDg5U05sQmJlTklLeWtmNlBuSXRZRDNsVEJQQWE2Zlg5ZTh4?=
 =?utf-8?B?OTFYMTV5VzFiNXExZWZCYnFaMWJzb2Q0d0ZMeEVHODJvZDJSRXVtdVh0L1dF?=
 =?utf-8?B?QlFKTk8wa0tDRUZwTG9WUDc4TDdwY3dZbXNqL0ExM3lLSjRpMGdocFpBaitT?=
 =?utf-8?B?QThQUlg4a2dMMndndE5tNFFuWWQwVGRaZGVRMXJzYllVM0VYTWJZNmsrbDBQ?=
 =?utf-8?B?aGpSQmFtQ3hVMk9oUEp3b0syWWJ2QXJyN2hjbEJFRFNIZk5DV3hLaXIrK1Ft?=
 =?utf-8?B?OGRFT2VIaUhqaEZpMjlWSGkwbGxNcExUTGhHWEI4dG5ieHhUZXZrUWFNalN2?=
 =?utf-8?B?Wm5POVI2MWNuMGpyTWY2ajFJWTIvNjBCV2x5S3plZENSdVVWS2E0Z3VvNlZU?=
 =?utf-8?B?WC8rWkJSdW5wejBzMmxDbk1JVHVYSFpwWGZJRFJWVnVoZGRTNnpNeVUxdGsz?=
 =?utf-8?B?L1ZWNHI1cEp4djkraFZVY3l6Nlc4T2dUQzNxeWpualI0UHpKekJyNWkvQ0tH?=
 =?utf-8?B?STJaMTdXL1ZhWVl1MllrcFM4TXVyNWJrb2Y4QmlYdyt2RXVVS2k3RjhvRHpB?=
 =?utf-8?Q?u5sdcdNmTirNUvJSZTwOoQICR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dae37c1-b36c-48ed-ef78-08dd5b059092
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 10:16:01.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyCFnFurj8zlNqxOmIL2nMObFnBHRQOsbwsE6FsKUqEFy2ho99i36eKsYC/lklVJIE8bTTueak+XUQYhVAKfQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

Jason,


On 3/4/2025 12:08 AM, Jason Gunthorpe wrote:
> On Sun, Mar 02, 2025 at 04:10:46PM +0800, Yi Liu wrote:
>> I'm also thinking about the impact of such a knob. How should we define
>> this knob. Should we allow it to disable/enable ATS? Especially in runtime.
>> e.g. if the device is identified to be ATS untrusted by the admin, while
>> the hw does not support SATS, it seems reasonable to disable ATS for
>> such device. This might change the driver behavior on ATS enabling. Intel
>> iommu driver enables ATS as long as it's available in the probe_device()
>> op. What about AMD and ARM?
> 
> ARM enables ATS when a PAGING translation is set on the RID or any
> PASID is used. Otherwise it is off, eg for RID = IDENTITY
> 
> This seems like a reasonable thing to do to me..
> 
>> On the other hand, we may just define the knob as sats required or not.
>> This is just a knob to let kernel know if the iommu driver needs to enable
>> sats or not. While leave the ATS enabling policy unchanged. This means
>> we need to probe the sats capability of iommu hw before creating the knob
>> in sysfs.
> 
> If we add some ATS control knob then maybe it should be able to
> disable/enable normal ATS as well?

Yes. If we are dong knob then we should support normal ATS as well.

> 
>  never
>  always
>  paging-only
>  secure-always
>  secure-paging-only

Why not just expose supported modes (No ATS, ATS, Secure ATS) per group and
allow admin to select within supported modes?  We may have to add more logic in
sysfs store/show code path. But user will know what is supported and what they
can pick.

Also sysfs knob needs new domain ops to communicate changes to indivisual
driver. Like in store path
  - validate the input
  - make sure driver is unbond so that its safe to modify the
  - New ops to communicate to indivisual driver
	 something like ops->set_ats_mode(dev, mode)



-Vasant

