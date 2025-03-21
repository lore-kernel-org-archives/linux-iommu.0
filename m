Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071AA3D69
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516767; cv=fail; b=b9HrcKVIMNt9BT+sPb0qDYHuT2RCeizt+4Hb7RIUqqDQgDxJHBaj9CUMzQlpedh1e2deWA4+WfTUbdkV568pQ9+36Efvx86/reUTjMh9U/wDA6wZzDyXae0umc7xP1HuX9Y4I56DmN96lBx4tLgAIRXESn3jqJI0mJY/b/MNKg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516767; c=relaxed/simple;
	bh=ZQWk9lcpi2a9WXePvtS4SBmPW+An/0M5Le1rLnyyXec=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SKHsgc9ScWScPoC3q/oijlaFqOJKQaOFcu50Y90rrG5jDYFr3Yk5GlJMD4ukkib7FNCHHTUuhJi8C2Ib4dG8k9Bzhup2achw9jT75/DyKC3gqFCjanC8HlzMWp+4bfa+impnZVcx8DpiSBYsrOjqL9glcmR10cnRC0MS4jhM5AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC9uNqT3; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC9uNqT3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742516762; x=1774052762;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZQWk9lcpi2a9WXePvtS4SBmPW+An/0M5Le1rLnyyXec=;
  b=iC9uNqT3UUJr3koDgP3tsree6WmI9Q1T0TauSpe01VUrzLoOw0+TKghL
   YGBVEk3MpEj61Ln23Ba+JninHgclitBATyDB+W7Zt5czHB8yDMSdJkn3c
   4+3ffbLHvtEjudHzz4gjyGN76MJ1jHlus2s7hvTziyYNbeYAcbyYTU7dA
   WfrhR8DY8cpXX1h5gmC5VuKiry7nNtnCfkREuifMaf4sUqsnr+6pn2VpB
   naDle32uSh0QWJf7P1qifk4UvoGZh2nDpEAOQwGDLS1HX0aRBVB8bXMJV
   TP5ycOBaiz6BJTGi2XIPG8KiFQis3zVea3UYfYjtLaiVx5LS4fWcHwYxQ
   g==;
X-CSE-ConnectionGUID: C0FEwyIkTQG4t3cxYNtvaw==
X-CSE-MsgGUID: uM2L0kNoTOO6fdH5feKW9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="42938242"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="42938242"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:26:01 -0700
X-CSE-ConnectionGUID: xdiJLpIlSLuuUKTvwxAtCg==
X-CSE-MsgGUID: 2b67nad+QzW0mx/3nFen3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123061824"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 17:26:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 17:26:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Mar 2025 17:26:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 17:26:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSUTOsLYNajge3dmiHnDP1DEtXkhu6VKjRicID0LaYbqQTq0rTjW0118uDxoEdzVO+4aXdfWbd2KXz4pylSXmerHgCuG10gQceb6p8V7gKGu2X1hZS4Y7aksF4woS1dEWmZBujNmC+lpTQgsrHJJ4cP0OadYv+/cCR77l7fvLB/g2hWeEIBRGyfKvBK92T9lJwFni2SPRaUvXZ8J0KHTkmmnYCNmbPOSwlIa1MnSpJBGPNfWJMQUxa+xCsElsrMk06MKwB9G2cM23pq6T4V0iEE+XQtUCz4+eoZR2e2ceQ3gmlh0QvVXkV2D9MAjFDOQWVrrzX6eTtU/BxOFTkrG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6KyHUMcG/o3/ZXjqr3WsBTnYQSOc94mfMJoHDppuhY=;
 b=FfUbNdszkJhMDx5sAxMPYFMZhsDV8Ty/LUvAoSnHr9W10zWBTguUtQYane19yjUisoXmkD+Lm36KznUoH9Ta55DWtofcw2woW5fq5xI1cpAokXHiDatmTpymVf1LR1BWXdDPX5p59w1fBXJVDnzAc3I+Qj/kJLg50aZL2+31oEM2ViJDEhfFox3ZDzvBQY5SbIng9L9N5gUBQHNZa8XHw06kVKAiH/tDNlYxgQA3ckyl+2kwLHt4JXawGJs8gVTOPzmmqUWDrHCE6k+K6dizin1zzIT1JGhlcCVuGSTL1orF0k5PL0X0YUBgedD9Rewr9XWMgQhUY948gr9ssTZRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7147.namprd11.prod.outlook.com (2603:10b6:510:1ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 00:25:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 00:25:55 +0000
Message-ID: <783d69d4-5858-4699-812c-b8495a36e9b5@intel.com>
Date: Fri, 21 Mar 2025 08:31:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/18] iommufd: Support pasid attach/replace
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-12-yi.l.liu@intel.com> <Z9x9sy7s2u18wVrG@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9x9sy7s2u18wVrG@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:820::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: c4894bed-e75f-4475-696d-08dd680ef198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkZXWW91SVE0VHgzSXpYNTJzNEI0ekMvalpvS21zNlRuMTV3MzJXRklFeURQ?=
 =?utf-8?B?RXliY1JJS1ZKdk52NlZOb1ZzY3dVZkpyWE9jbzhOVHlRL1J0WHBjTFJzMHho?=
 =?utf-8?B?OC8yOUxTL0s1VmNpS3JxcWE3WGVpdVVqZnZwaXZlWEV2MUEyVnh0STJtNlZG?=
 =?utf-8?B?UG1CSGtJamV4ZGlMODZkVlJXdGVrdTYyYW01TE5EblhtRWhuUDlkR21UY05K?=
 =?utf-8?B?Tkh4cHZHN1hlajU0WjhWZjRhMXR2SS9HZUN2Slp4ZG5LZ092eGNpR1JVN2RE?=
 =?utf-8?B?Qms2VlAycXpIbEJ5MTdsUElBQXcrb2M2Y1BKdzhsY254NzlkZWoybEdYa1ph?=
 =?utf-8?B?T0JZOU5aa2E5ay9nUG50eUluaG50eElHV1pHZWUrVkhlVWcwZGE2Um5Sdk91?=
 =?utf-8?B?SmRHUkUrMTFyUlVYV2NXbjNsQjM5UURhQTQ1b2N2M2wvdHVZdTRZRHdqRWNl?=
 =?utf-8?B?ZVBUWGg5bmNxSHNzakZBQ0FLVERVemdiaTVoSWE5K2x4VHEwOHZ1WGhzQUpY?=
 =?utf-8?B?SVRqS1F6SkoyazdlTThSK1JneThORjhjTFp0TSs5T3FvZ2tsRnI4RWl3aFFS?=
 =?utf-8?B?OUtibURyRzZLVk5iSTh1YWYxdmpWM0h4Vi9XeE5ydE42KzlwRnpTd3owcDZn?=
 =?utf-8?B?UG5mOFRmZzNZKzkwSFVkSlNlRmQwd3d0OXVjc3dZdFdEUmUzNmdwdDlrYTlu?=
 =?utf-8?B?c2MwUlVXWkVWaTZEL3ZndU41SHVNT09YeDhuZURKR1JKY0hib213RlgrT2pz?=
 =?utf-8?B?MVdqVDhVQjI0RWN6OCtrTEhPQjZ4UlVmc3lRZHZTbVIveEViQ3lldUoyZzc4?=
 =?utf-8?B?bFNUUjlDZmt2Qk8wR1RVUUNhdG5qTGx2VTI0Rmdad3prc2dpZlh1eG5McHBZ?=
 =?utf-8?B?RWRRZk1PNGh5Q0dUaW84UHNUSmtScyt3cjc0dWM2ZEVTbkx3Q0d6WmM5bFE0?=
 =?utf-8?B?OFhlZFhTODVtV0lPazVOeWU5Q1VTS0hCUThHZVpSNytIYUZtbkFvWmo4U0M1?=
 =?utf-8?B?OFlGTkhMdjJXUCtSNDh1VVJLWFdDbUdXQStVbFhBRDV3aXRmR1FVRmZoaE1Y?=
 =?utf-8?B?MStXdmtXdWJEWlNsOEM4SytkbHk4Y3d3d21SZmxnNXNqTDNCUGIyS0ZwK2Jj?=
 =?utf-8?B?TW5rTDRSWk9FNXEyeEpmZWlMUkJxV1l3aTZyQ1JHVGRxcE1pV1UwNm8xMnBG?=
 =?utf-8?B?eG1KMU1jakppQVVUbE9kVkhRT0phQTRkbzVzeHJpNS9aMzJFNVhrQ2tmZndM?=
 =?utf-8?B?aVVobnRjazFrVExPRW5wZ1FPbk02VGttaXZVUFgwYXpFQ3duYWt0K3B5NlpQ?=
 =?utf-8?B?SHRoc25VbUNhRnBYYWczV21aK1gxQ04zZkZyODNQZlJoSVRGd1AxZGJKRE5B?=
 =?utf-8?B?YkdhZjFtUUlzTWxRbDUxdGJiVFVRNTloNyt6SlBDQ2VRRGhqRDJBYndQdUtE?=
 =?utf-8?B?WDZYYk5rTmJCSVJPR0hUVnhUTEw3ajlpMVZrYWowaHhvd3U0VHo1SWMyZHgw?=
 =?utf-8?B?cmFkV1dOdDROUE1HSm5SdFd5SVFDN3lZSmhPRkRkWFBaMldMRk01L3gvS1VJ?=
 =?utf-8?B?SzR3NUN0ZDhqUHd5ajNrdXFsREhjeWhQTWEyOTR5cXVhdjJWQWlRclc0VE5E?=
 =?utf-8?B?empGMWxRNEtSdTBON1IwYk95TkFtYXRiOVFzV1AvcXpzYjI1U215VVhBRi9z?=
 =?utf-8?B?VHhsZ1ZwdEZlMGw3Nkk0UXJ1NmVyYS9XTVpNMisyOW14RnZ6bVdnTUw2UDFE?=
 =?utf-8?B?eFhHR0dJQmxMb0ZGOU50bUg5TFhSbVZNN3pHcnQ5OWFWUmNLWWQ0aW9WR1lo?=
 =?utf-8?B?YUFxK1h0bmUwTXZGLzRkNEs1NmdwVlRpR0FMOEp5aEZDeS9DZGsvd0dXRTBa?=
 =?utf-8?Q?9RrL29/AjgTsV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHducGdoeE1PcmxoaFFoVXhvcGY5c2dOcWVodXJTU2owNEkrTWJNQ0w3S3py?=
 =?utf-8?B?TGRSSzZpcEVZNHgzL3RCZitOWHVCNnJXbFIxNytIRVVKWFdzdFYwOC9DTVZQ?=
 =?utf-8?B?QlhWSFBLWTVNRWx4bEozUU8zM3V2aERQcTJ4U3R4TzdRNXBaeUJGSmkyT3lp?=
 =?utf-8?B?RXdXSTRoMVQxWjhjNDdFSlhJWjY0czBhOVA2bldhbXlGOFc5eTRuNHVPS0dv?=
 =?utf-8?B?R09yL2NSQlNLZ0lBTFlJU3hVSjQweDNiaTdHUEJZMm96NVl4SjYzeWc1RlBr?=
 =?utf-8?B?M0c5S09mNk81SGl0S3lRSkFObnlUUW4waitEUlFsbEhxMlpVZ1hnams1Unc4?=
 =?utf-8?B?clBCTll2VnFWT0hTb3dlRTROK2dhRkxoVmYzZVJwWitEQ1NXOGxmWmE2bGlW?=
 =?utf-8?B?VU9ZeXYvQStCVVN5cHpHK2wxWkVobE5oZzdqeXkvR2ZLLzNINzcyUCtlcGFH?=
 =?utf-8?B?bVJoS0I2dUlNR1Rxc0tNbGZhUUJPako1Yy94d2FNZE5xRzlOeTM4YXpCdFBC?=
 =?utf-8?B?VVJFZUVHaktxWVdrZm5LQTFPZGsxR1dOUWhYUmllaFhNakJTeSt3QkdKMVB4?=
 =?utf-8?B?ZnJtUUw0cStKWUkyT2c5NjV2cHo0NlAxM0ZiOWNZaHBYVHlyU2tGaTZZODRZ?=
 =?utf-8?B?SjBHSWt4MTBSODJseHh3cnJYaUlOU3RLcTBTYXB4a25jMitFdjR1WElMbGEx?=
 =?utf-8?B?eFJKQTJMSk42MStrTHUwNSt2UzBFRExBRE5yTCs1TUVBNFdML0tVNTgyL04y?=
 =?utf-8?B?dnVYTDFvaU5WZy9lSUdIcVQyZm1DTDVBSjd3bVN4YkV4Qll0Ty9jTGRGa3Fa?=
 =?utf-8?B?WFRucFp5VFhKdUFOSzYxdzFORjJNcm5saFBUTEFrcGp6SEVLOHdEVmVOSVdy?=
 =?utf-8?B?Z0t6YnpxOWwwUUdRNXBXdU1yenc3cmZsK1N5S0VKYVd1Ny9SemZqZDZ1M1U0?=
 =?utf-8?B?NWI3bFFBc0FkUEVHY1VNbS9JZkc4UjR4dWFIblRuRmpUbWJaTlVPeG5WTndJ?=
 =?utf-8?B?dEk1SXFHYnkxZlA2cldHbEtlRHNmYWJNRVpPUzY2TFJxbHlVMW53OHQ3UmtZ?=
 =?utf-8?B?S2xGZGNYMGpXTHozVVB0MDJ6c3UydWpmZjhFWlpieG5NODBNMXRmNlBBNC9v?=
 =?utf-8?B?QStjdUFNM1JqKzhjWEc1ZFluZFI5SEh6V0hyb1Z6K09ZOVhOaEhoQjdpcFQ5?=
 =?utf-8?B?RThjTGI5RFJDb2l1T1pmekppb3JxRytUcUEyUTZqUUZNTlFzT0VwVG9QdHd3?=
 =?utf-8?B?MkpmWlZ5NEpZdVZSNTZ0THFLV29lUDJ3SU5BR0tzbXBjSFRQeHppTE5oQ20y?=
 =?utf-8?B?S1hDT1Zpa1JzQjVpZEs3eTI3amxXb3N2WWo4cmw1aTFnZStNbk5ocGFkR1lQ?=
 =?utf-8?B?WXZ6T1Z3bVZKQ1pTSzRXRU9GZ0txeDM1c2dIeDk2QUpCb29xQkd1endpN29P?=
 =?utf-8?B?disxRmZLUG1sMVA3aWdRbFlTZEtzd0RUcDBNdVZ3Y2crZnYyaW5kYTF0Skdk?=
 =?utf-8?B?cGhScWk2K0labFg2dTNMVkgwcVVUSi8wei9rL2lGQzE0R0dWdGdCVjJ5eGlW?=
 =?utf-8?B?WFRlT2tRVkN0R3lIUDc0eitkVTNFV1MvcUhTNXpUU1l5SytpOXNKSldqSWYv?=
 =?utf-8?B?SDExUDR3UGZBQlB6REpQbzV5NUR0L1JZaGtmUFNBRTBSRXg4QXdtd3pFM1U0?=
 =?utf-8?B?a0cwN2ZDckRMWlF6MjNNdFdHRlNKOHJVRWE3S2FYNjh0SjRoLzF5dlhVU0xr?=
 =?utf-8?B?SEJnOStWUjRNandpTDlZZTJBZEpEeDlVSGE5L21GMlFIZUc0MlFDN0ZmVDlY?=
 =?utf-8?B?NGpFSmR6enBpK2xpTS9zVU5iVnVRR3EwVGFaS1IvRXFEZTJBUk1TUG1BVFlL?=
 =?utf-8?B?VTNOQ1RlSmltOWhvYUZhdjRLWEZjZjlUcFU2SGJucGNYaW4yeVQ1VzNRMm5R?=
 =?utf-8?B?ci92MEJwcDQzRXd4ajhiM29FdWp5SkFWMU1CSTJwLzlsMnY2UGNGcDZpU2xS?=
 =?utf-8?B?d1RaOXNEdmRGL0ZBdVRnRTkvdmF5bDFlMzZwYVV3YUJ6TFhEalQzSkVzZVdZ?=
 =?utf-8?B?aCsxdUx1cGZYUGhESjEwZ3V2M2FtVTBHN3V2cUdhbVhUM1VvRjIxS29BRGJO?=
 =?utf-8?Q?7GRSJF55wBc6LYOEfQDYIzLUj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4894bed-e75f-4475-696d-08dd680ef198
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:25:55.2028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBXNjlSePCvcNNOvqy5fPm+wuSwglNYXto+UrjVKnkaw/8V6GXiSQx/DKGZNXZEr+YGY8JM0jq+9Dy5VEmcdkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7147
X-OriginatorOrg: intel.com

On 2025/3/21 04:42, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:37AM -0700, Yi Liu wrote:
>> @@ -579,10 +582,12 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
>>   {
>>   	struct iommufd_attach_handle *handle;
>>   
>> -	WARN_ON(pasid != IOMMU_NO_PASID);
>> +	if (pasid == IOMMU_NO_PASID)
>> +		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
>> +	else
>> +		iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
>>   
>>   	handle = iommufd_device_get_attach_handle(idev, pasid);
>> -	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> 
> This changes the sequence of these calls?
> 
> Is it correct to do iommufd_device_get_attach_handle() after
> iommu_detach_group_handle()?
> 

oops, yes it is. It should keep the order. will fix it.

> Otherwise,
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

-- 
Regards,
Yi Liu
