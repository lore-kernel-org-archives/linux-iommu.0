Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70417FE
	for <iommu@lists.linux.dev>; Wed, 25 Dec 2024 04:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735101695; cv=fail; b=fItE2rtRXr4EEpwyrfnCUfnvrw5isKEa1GjrFNLOZRbaBHGz0XwjtnFIxywWMnwDA8ADhtgaG9XiCmLb7QOZpfAwIRbbfsndaRVJre645T3s2QY5UVGDKz6aRzn3BtZuk4V0uImNRvAZDx0gqeV3cWdmwBSqEEGoxD+6+1dqMs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735101695; c=relaxed/simple;
	bh=6PQcvrr9IvqJTUj000s1iFsaSEuDFmc/PzsdDC4RC9k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KQjskFO2nsiXqXu+ugq+y9SFhlcZW8V5YltWStnQWY9Xz5j3XSNcv0/IlSPJ7eWaNKGxbJBD+1q+aVlZuhd4rYIaS4oZ2KyRPYnePm2p6syEVzWovbw+3rHz9udKocovU+DEk18UNe7K8kUzURf2jNEeDKRtFziL5deS1iYEu0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0uBmiNS; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0uBmiNS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735101694; x=1766637694;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6PQcvrr9IvqJTUj000s1iFsaSEuDFmc/PzsdDC4RC9k=;
  b=b0uBmiNSnB4GaSrRXNk5ZEC/Wpx/sdlR8PzMpzQmADKB2NSOUD5v+ytS
   KFy+o2QHqv/EqvRybIRICSu3k6E7yu2QE5YfGGN3AJSQBGzxF0Q8S0J9x
   SRBMXruMeDiRaJSQl3zOV5lDkXdJxRz6yRYCCX7/ZVnXnM5OvjxQqroyy
   ZItDnxxkORSu2a72ICzh6E2BvjjPkC73USbRMjFfg5yGsTGXZe3X4ady9
   9L/+KuhFXOULuIjVYok/zWpFwAItXau1iW73hw3WiEs3o5D0Ts8E4axq1
   xZSRggmBvFzMITfzZ2D2UFViZXDND77qWH0F/cv1JfNPFD1E56fWsgUAS
   g==;
X-CSE-ConnectionGUID: j/uPucVVSn2bhGwY41HK0g==
X-CSE-MsgGUID: sma/iW9bQx62FW74gxbuKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="46157173"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; 
   d="scan'208";a="46157173"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 20:41:33 -0800
X-CSE-ConnectionGUID: cXRF0xriRkamAHAgA4lEvw==
X-CSE-MsgGUID: GG34fVlhT820EG4m/JfDGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104260909"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2024 20:41:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 24 Dec 2024 20:41:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 24 Dec 2024 20:41:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 24 Dec 2024 20:41:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYYM6/C+TLH3ibdK7AX/CMK2tJ2HnyGmBPlJNnhCTODPUB/Fnx93fRuUt1BfcnEJVvN52pHPEiKdA+7cXi8rKsMZlKGIVRehXsDDMeJRYJ7svca1LZEMjj3byEEwZUnhMTF+PyNIRO98Zlax6HdQ71yzE238JWk/Se9opzUcMmptg4I/n1eqzmgXyvFQLWg/Sjpp+/ZAqDQYKiPfSuRF7YBtTLLQAasyi8NPWVTM5ZsMv9kamkq9jahLahGIdaYIdhh+8eg3UqxFB+SU/rnnv1RGsoUxU5Wf54GoHrGHo0uwV8oUqYX0D7gZkX6hQQ9sI5AQmxOaHVWQNUrm1EVhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpyAs0ug7k28WhjkUjIqJed9JNQpTWyEPwYmsWB4EKs=;
 b=S9WJy1tXT5aNJlsip8LRzUFc5NekbvEozDoCaVv8t4onWchZBhaQA0rBbkjB8wqyZaG2R67FUzOAMTlC9CgIZjgYvfjDkzRPDb7BOu187HmxWyxevbNs39L1QNGZiZ0oxhK6visKMDV69OD6sNtBNTn+HNkIHmE+z1QIdeK7lDC2PUfDVjEJUW+3fR1Wy2KiSErPvmzgvE/mEYEp5eaPMqI+1Ofe6bnTuLDeK0jfabe7e7r5OtD5CeyWIkSFNfP2MoXhZgyNpV6UTnqRo5of8Ienzu6/Ry6LVoCCCBxS5V5iWAEAHkh4/bkI/kjd8QFYVq+mx796IO0Y5RN8QloEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7837.namprd11.prod.outlook.com (2603:10b6:208:406::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Wed, 25 Dec
 2024 04:25:03 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8272.013; Wed, 25 Dec 2024
 04:25:03 +0000
Message-ID: <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
Date: Wed, 25 Dec 2024 12:30:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 848f0a22-6176-4105-f5f5-08dd249c19f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkJqNFV1YXJBWXhQQW1Rdm43TXpQUFBNS1B3QkVpNHk3TGZTM0pUeU4zOXJP?=
 =?utf-8?B?cEZyaEhWTlkxY09aVHY4bFI1UFN5ZTNVVUZJb2owRForbFJuVG1CU0RzRllm?=
 =?utf-8?B?YUZSZGE2Um5ORGVESnQwTERLL0hneEduNEpMRElHNUdaQnlyUXkyZEJCelhP?=
 =?utf-8?B?K1oxS29BTzFJY3NHbmpiSXEwS0JDRU9nWmlLTlBqZEtIQ2k0OHB6QWFtZkhS?=
 =?utf-8?B?YVhSQWRSdXhNSVNmODcydlZzaHFwSkdudGFSc3lTVWFnY3VUdHFheEtsbVpM?=
 =?utf-8?B?L0hyZnpiekxuZ3JJaStaU2N2Ryt3TUlJUDY5QWNEZ3hpbnIwZk5QN3A2V0pr?=
 =?utf-8?B?dU8xRWx6TjRxaWNSN2I4UDhkMTl1S1ZaNU5qbGpvK1Vwblp5Ym9tLzZVV2Qy?=
 =?utf-8?B?TVo3NGh0Y0cxdVJhbmlIbSs2MDlWblpQVTdLWXBIcENrNHJmYzNKYlVIVUo3?=
 =?utf-8?B?ajFzc25xamgyVS9wN2k1amVlTk1Ja00zaGZuN3dpZkxiVlFzMWhFUEZwTlhy?=
 =?utf-8?B?RWdmcGFzMjFWb1BGdzJDY1kxZlgrT1kzZVBpeVFWWlM5QUNzaWJMTFpCTnI0?=
 =?utf-8?B?NzVGYVd3VHRzWTJGYzVkL0hlc2U2UWh2QmpSKzBRKzN2MVNKTGNJdkppV0NP?=
 =?utf-8?B?b21ZSGF6Y1VGUDl5dUJkYkdYSTU3Q0g1RkZlYWJVRXRVQzlPRE5SR2RWbmdC?=
 =?utf-8?B?L0RpS2hZR3ZmcHBoWUZ2a3R1RGdseHhjY2FhVlJUbkFZVm5SVHBEaFdRdUNG?=
 =?utf-8?B?RklZejZzN3JuNjhjZDlob2UrR21lRDV2VkdLajFOUlZIeEt1ZDZCS0UxK3VP?=
 =?utf-8?B?NS9BcTJqaEt2TTQyQ2VaMUdMOTRIU0lFZ1JSMk1ndGhGTzExYTV4QnYvWEda?=
 =?utf-8?B?OWJCK3JITjBXQWJxaGNVMnY2anQvYk1jZ2J1NWQ1d0dFZFdQOFN0WEM2Rzk3?=
 =?utf-8?B?RVdweGVNWi9ZWS9vbVlEem9WZWJWekRlUWFzeXhsQWRlVUM1YzFybEZERGo4?=
 =?utf-8?B?Szl5Sk5TbXhTNFRLb3BDT1JydkE4SW56bnQrUnBISmNYOS9ENmJ6ZDBIOVFw?=
 =?utf-8?B?aDY1WTVaUG9ZYzlYRGovZjZ5aVY3SzlsMlRGMUdNb3JzZ3hVQkNnL0w2VUlR?=
 =?utf-8?B?Ry9mRGIrYzV5YkhjdEdXL01vaDJHWEVyTEFGSVFyelRTQTZUNGJMVGVEZSs3?=
 =?utf-8?B?Tk9MSWVzNzZjMlVydXI1aG9ac0RjV3hPdjNwcUtMMVZFZ3p2N1gxSVFqVEJK?=
 =?utf-8?B?TTVoRW1vR1kxb0s5cFBkR1d0empQZ1doSFp0NnM2b3pxZWxEY1lIMmRqZGcw?=
 =?utf-8?B?TDIxWVUrNmlKaWpqRDExY3I1TXhCZXJmYllEUkZINXdMdG9jUW55a1lSRXVK?=
 =?utf-8?B?bWlmdGhyc2F2RWpYVnVjeHJVWWZzNFdFWHhnVzBzK0I5bml6UnNZZW5JZ2lT?=
 =?utf-8?B?TS9rTzdOQ2kzdHFyZFpjbVMzQS9pdVphbG8xeWhROHpRZmEzWUJSQmMrUVpj?=
 =?utf-8?B?QW1vMWVVTzFyY0hvMFpjbFkxSXFxZ3pxeHFnZW9qTGhsUUQyK2xQTnE5WVMy?=
 =?utf-8?B?dGNIRndXZlRQMTg0K1VGQk1FdDZJUWExQXBvVC9pbGdWTVlFbVJjRHhuUTdG?=
 =?utf-8?B?ZDRKQWdVcTByNE1GQXFjZk1vaGhxMTVob0JFTUViSVd0N1VZeVo2SFJXNnRU?=
 =?utf-8?B?OG1LSXU4Y1B1cVNzZy93UkFQY3dIbWV5UUxoTDBwVTRjZVZiYWEzcWpldTBX?=
 =?utf-8?B?MWpwN2FOOE9zOSthajF6WFN0SXU5SkNUcGJlaGhRbEJqQXhPazRzc1U3cTBu?=
 =?utf-8?B?UDROdnU3YzZBaUt4aVBDb3hNYWRJZFY1Q253R0ZxQ1pDTW8vUUtud0xwK2dy?=
 =?utf-8?Q?kHVaf8z1ziuR0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm5sUllYTlBjUXRvT3NtUjNIV3ZGaEtPeHV0eHRjTlBLQmgzN2E4QjVFZitU?=
 =?utf-8?B?ZDF1WlFSMUR1QUxSWUZMMGp2eVlBZnd0ZEdPbk5oRzNaRDJYN0NEekF3b2Zl?=
 =?utf-8?B?VFBrNk80TUpDZ0RiYjRqTDBTN3RReXhqbnh1ZWw2aGZ1bVpueWRHbCt4Wkxy?=
 =?utf-8?B?SmtyaXU0MkRDTXhnMlhKMGtPSWd4K1NJcmk0L09VK0ZkSHF2Y1VTVzA2TmJ1?=
 =?utf-8?B?N1VZMXdSeHJtTzBBUU9HTG1Qek5yNkJNSWRqblZYTGFlUFJrY1lzeVNLRk9j?=
 =?utf-8?B?TFQyVFlhbUxRZ0NKM0lQQlUrck8yZGJMdGNkZERjTW51M3o4dDdNb1QwUEIx?=
 =?utf-8?B?NWVMaEtoWlRNZVVQL0d0dzdjYjZCbitodlh3YXlGR25URGxLYjQ4dXNSTnNy?=
 =?utf-8?B?RFdmMkpyb2VuVEl2dlRhU0NSNUlBSUVBdG8rSS9pNVBRekthVEJ6MWpZaVk1?=
 =?utf-8?B?WHBybDYvY1ZjdVRGVkFOdW1HSCsrc3R5NTBzMFY4c1FPMThFMEZmYjR4WUh6?=
 =?utf-8?B?eHBvOUZ0K055djNyZmJ4VmE4WWxQUUFrdkNuVDgvKzAxOHJOaEpMS2ZPVm9k?=
 =?utf-8?B?STFLc1lkU2J5R05hWkxGa3V2WUtKUzl6UERGcEJXZERpYThoT2xkK2NxNTZt?=
 =?utf-8?B?ejF1SU53ZUhUaUU2ZWc5NkxWWENKSHpLL1k4RlhDUWZrWFBFakU1MHBrYjdE?=
 =?utf-8?B?dXlpTStiaEJ1dVJXSnM2ZWI3U2g4YktIbVJRdko2REZMakFRckZmY2d2N1Ir?=
 =?utf-8?B?OU9kTkkzUGtvbmJKRUlKZXhkbXNoY1hCTkY1Z1A0NncwKzMvRHQ2ckkveGlF?=
 =?utf-8?B?eUZYb1dPUnIyTi9WVWNWRnRaU2FqU3Awd2VrTi83U2piM055ODl4bHE4bEpx?=
 =?utf-8?B?TDBjSDBHaWhtcSs4RnBiU09EMGphL3NkWG1vWVpJUzdFR0NsN0xZd1lNU25F?=
 =?utf-8?B?RlFrSTFQRlc2c0ppeHhWTTBzTHF5SnBKY0hnRThIc0J2UC9QTkJmdXZLKzNQ?=
 =?utf-8?B?U3VUZ0w3L3lkNS9jUGxRcityWUp4ZnlndG9SVWZLUXBOVGduUE1rbElXdTgy?=
 =?utf-8?B?NVcxejk1blhRbmlDMm4vL0pVQm43R3ZUcmdyRGRCbENWUzg3ckJUK1NaV3Y1?=
 =?utf-8?B?ZUhoald1QUx0QzlOTHgzd1l2NG93dkw1NUlBRXRCcThSenJyMDRtbUtBbnZ1?=
 =?utf-8?B?R1JreVZmT2pxVDc2ZmhxbzI0VkJwWm85WE9aa0xJanZYK3oxaHcwcUsvU3RX?=
 =?utf-8?B?TXQ4QWFwOHNwYkF2QWZRb2ZkL0xxdzJSVUNrY25uT3d1QVBPLzJqN0dWT2I4?=
 =?utf-8?B?OWhGdnl6cnpKSUhUM0ZIWGhpcmRkSUpnbG9Pa1dNY2JlakVEUE1YSE5iZ2hr?=
 =?utf-8?B?Rzd0UU5uaVZsa3BNZEt4ZTVKR0dma2RkQTVUdndEcnUzRnNKdjFCaHVSQVF2?=
 =?utf-8?B?MFcvMFRjbkdzS0FUdnliS2puZENRamRqVXlxT3ZRODNqNGMvQndLZUZ6Qkdn?=
 =?utf-8?B?cXZlM3F4NTVEbTRPcTRUVGI1R25TTUxwUGFsUWZMWDVPeXZOcFRMNVF1cjRs?=
 =?utf-8?B?RkhIUnVCZk5LbWthemFRekFTZjl2Y0cxQ1ZiTmVESC9XVDJ0a2RoeC9TMXRy?=
 =?utf-8?B?ckh5TDZxbHJGMnl0YUpyZ25CMTJ0dFhQK2ZrSjhpMzlWRXBDZ0JwYU8vWkVx?=
 =?utf-8?B?WEMvaGlvS0FkaXl5RW1iUCsxcTZrdEFzb2twYlpPYndkYXFqVG95YXJQd2R2?=
 =?utf-8?B?aG00UFJla1hMclE2ZHNsWVJsakttekJkWFBZdWNxZEVmdUFoTVo2YW1ka1B4?=
 =?utf-8?B?T0E5U2dGU3g5eHNGM085d1NHM2RPNWZVSGlTaTlDNXVHY1hvVUQzSnY0U0ZZ?=
 =?utf-8?B?dVlWeWp2MEYrRStid0tLTjFGd3JzRkNYWEdkalhPdVRqZUtKVmxPNExtVjVE?=
 =?utf-8?B?WlNMS2d1V0R1MEJMNGF0WkZQZWJXem84Y0dTL3lxVGFQcmQ2TnE1L2pQRVN0?=
 =?utf-8?B?Q3JlcWdjNFhFYm5Bdkg2Z1hpOUtSeUYyODloQ0hQWkk5Sk02aUJYN0UwbERJ?=
 =?utf-8?B?Vkx2TEhGUVArazI1eGI1dTdLa1VqNEdQVnA4NW0yM1RUaW9SVHN3K0x3V2t6?=
 =?utf-8?Q?qLWUJm9TYLiZpCTfsBro+Eryy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 848f0a22-6176-4105-f5f5-08dd249c19f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 04:25:02.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9oMcfry4lrsUYEJSmqD20CG82XaVUFFfkT9iLk/rQhTgYeAmvKvTaCMqDBXSvzDb8w6SLRSG0RN9MyHICkICA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7837
X-OriginatorOrg: intel.com

On 2024/12/25 09:02, Baolu Lu wrote:
> On 12/24/24 19:35, Yi Liu wrote:
>>> Another related consideration is the support for page faults in nested
>>> domains once PASID is available in user space. Would it be reasonable to
>>> support page faults for nested domains?
>>
>> yeah, it's good to discuss it.
>>
>>> If so, perhaps it's time to open intel_iommu_domain_alloc_nested() to
>>> support IOMMU_HWPT_FAULT_ID_VALID when PRI is enabled on the device?
>>
>> IMHO, the PRQ support for nested domains requires some more facility. PRQ
>> can happen at either stage-1 or stage-2, iommu driver may need to tell
>> it and forward to the correct domain (nested domain or parent domain). Or
>> the stage-2 is always pinned just as the VFIO/iommufd does. Hence, any PRQ
>> happens under nested translation should be due to stage-1.
> 
> The parent domain is currently always pinned and does not yet support
> page faults. Therefore, when a page fault occurs within a nested domain,
> it apparently should be routed to user space...
> 
> If we decide to support page faults on the stage-2 domain in the future,
> we will need to figure out the correct destination of each page fault
> and route it accordingly, either to the parent domain or the user space
> nested domain. Hardware assistance would be beneficial, otherwise the
> software may need to traverse the parent domain, which is not
> performance friendly.

this is my question. Is it still true the parent domain is always pinned
after the below series? If yes, then it's fine to enable IOPF for nested
domain.

https://lore.kernel.org/linux-iommu/20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org/

-- 
Regards,
Yi Liu
