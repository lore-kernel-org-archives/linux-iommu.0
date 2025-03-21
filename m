Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA0360
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515757; cv=fail; b=ADv+d/XZ2CQa2epmogkdi7P8LJn+pUzW2rag/rDZvTdwv4vxX13hIcmKaFTNbCOWczfWsJKStbNuc+D28vROOCNluXdSo9buXj0onskQek0otILzeT74oOLGuseYwE3fsYWgu8rb1RjO4uruiChyqMBTdh3cZGRlDlk+M5lAV9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515757; c=relaxed/simple;
	bh=LxK/u0XFx9e+mPoSgKcV0hK58KhOQO4Ghc7EVkti91I=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sLMggyxT4qUKQUTpBdvkXTvbHk3bxrYzssXukFmB87aYSsGqc3O9mBVQXGk4Y4Fwiuh+5thun5YvPalvLV1MrV89CUlOmuNpDdMcoL4ppqUGQMWjJaWNspM3sprOnbAIhOMrOag6QyFvcuS28d2RnEc5GzwLzvXDvUGDHpX2cUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzLmx11F; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzLmx11F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742515755; x=1774051755;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LxK/u0XFx9e+mPoSgKcV0hK58KhOQO4Ghc7EVkti91I=;
  b=IzLmx11FuwIug39AV68ypOjx9Pg4fBOb+p+aE0peHtKUmEj27RTVLZVC
   5KRcIJ0xS1jnRv2thAwxlCSWMIELWOXN0ztd5MZXb3ZKFFNwOfVnrc8Us
   o/fWoI7/r/n4nDpvy0/sQxBQyE7QoJ1TKU229eAZTfsnAn8b0QKrCmWfQ
   RR/8m1Vq6HJKsg2S9Sjblhc5J3imz2Oa+e4QX7Q6YHddiQaRO/8q7gVjz
   9pDcSqEC5CneGzfb6E/v6MDGCkRCh8G3JYfHxVeyYmveEWCWGAnHXgm1V
   cUGXbjNYDT4zt2HK9GBR7tOL9IZxK3c1/i2qANnrjFuGbq2zefqWnQp2v
   A==;
X-CSE-ConnectionGUID: btcNatPYS3uyd7mzghcNBQ==
X-CSE-MsgGUID: iPsFZdasTB6bmkMAlhK7zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="31362814"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="31362814"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:09:14 -0700
X-CSE-ConnectionGUID: KEwsaFJqSt6LmROpI6dvMw==
X-CSE-MsgGUID: eSTLJOMLQpGlQ1o1DvmmRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="127931628"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:09:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 17:09:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 17:09:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 17:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=As2WUZOSEY7eEizbDLwmo2XZGvI7rXyIASx/oRvlmzsrBKIGWsH1XH3OkeTGtQpbnHR0nKpO8RFftdNL3CQKgfFG81ZeuPl9e1e4bm0pQx2dVRbEPoJCNxw9ydxEz4HYfiN+oUtrFXIdNqm5jlPVBz+5nVNZu0waMhJcDOl0H/vqVFYfkWHCKT0/1i5c/ZsHHjqR6kHuxoAZ1jIHxrI7s+ja8BKnSMfU9/n70bZsuSp64QC22iHxF8H26wP4y8W1X0NU4kydluTuZFWf2Nnl8DVUPC/m34Y4jZYCn16qM5JoE+10y8g9KXI84rSkQp+yBl9HDyxUQ8C+2pTLx8jd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dopRBFsR7JZp5wD4X4oMjKYmGHlMN0BC9LgKdesL66Q=;
 b=pP/yKDZJnHLni8bMxUWCX2VWHuLU+WRWgkoANd4Vpdbv6wA/jFj3oVW2NyMUgvhvOVZ6X01gNOrFmfGsufOG2LyyG9Mp9d4vjYb7acd3OFGJAkT6JYIMb5l0cUMwzdwRv/e0PDhwNvwGWOgeXVTH5tBeG+24cdVg5e/Ipoo3fwqmJ782ucvYYjezsuI2pJVjazLR0+rYT/zlU4NK02DvpP7bPYuNkaCAVD+8siNXInzJIfmiWSnFx2Ucs0pDoFngyvzFABXO9PJXzTVgtQwhsw7EMRaq0L6gUz3teUqK7zKAUf+5EyTbKrIl1ALVsomWe/0rfDNSdAEzSnoaAFidmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 00:09:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 00:09:11 +0000
Message-ID: <70f57946-cd6e-4bfb-a854-5e3c942799e8@intel.com>
Date: Fri, 21 Mar 2025 08:14:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/18] iommu: Introduce a replace API for device pasid
From: Yi Liu <yi.l.liu@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-3-yi.l.liu@intel.com> <Z9xPaGV8f7Nr1HGd@Asurada-Nvidia>
 <86dfbb2d-18d1-4f72-876a-edc131a8f47a@intel.com>
Content-Language: en-US
In-Reply-To: <86dfbb2d-18d1-4f72-876a-edc131a8f47a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf3d3c7-ed88-4de6-b727-08dd680c9b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVJPN3gvWWIwL1JuaFJ1cFlyMUoxK1RlV1dlWXV2OEZ0WStrZWlQa2JLMU4y?=
 =?utf-8?B?VytLV1lWMDBsYlVNbjdPM0dTMlY3aU1icWQrU3dWRGN4UVVsSDhGVjZXRUZW?=
 =?utf-8?B?RUg2dDdQWjVhdS9BL0ZjRFlCcVNETUdmNy8yWE1FVmdlY1ZkeWpSUHBJMWhZ?=
 =?utf-8?B?bU1NY1FjQ0FUSVgxOEZwVlZmMEFhbFdidTBWam5OWEtFaExzUUhUT0pRU3Z6?=
 =?utf-8?B?WHkrdTlsQ2t0d1BFdGdSblFhcXlUcjdsZnNJZVMrVGdMdFp1TFVFZVlDdlEv?=
 =?utf-8?B?aHgxelZnWkN4LzBQSU5jMHEwNmFDd1pnOEtSSWY4MTdiWjVNckhzSzBERFUw?=
 =?utf-8?B?b3hTTC9QLzFZbE84Ym9hNTluZEtrU2g0ZEpTeHNnbk5yQWE1V0NUNEswY1Mz?=
 =?utf-8?B?NnZUT3FRWUhDMGM4WUx1LytidzdzRVd5Ry80dDJ4ZkQ2UStaSVlRd1Rpbmlz?=
 =?utf-8?B?V3J2bkJMVmp4MnNRLzc2cjlnM29OczB1byt1dEd3RmJhaTFpeVpSSGkvbUVp?=
 =?utf-8?B?QlN5K1I5aUQ1ZEN6WHF5VlIwSi9zblNRYkFzQmZNQ1IzeERqZmwyMVB5L2NK?=
 =?utf-8?B?YlZvKy92Z2ErWU54Zk5FbXNiOG9MbUNOTCtWR0hFRHdCbGx4VXAwZW94K2ln?=
 =?utf-8?B?YWM3bGphNjNPRHc5WnN1YjF3ZDZid24zKzNOZVVzbEsxZGxjYjZGZlR0YkFW?=
 =?utf-8?B?R0U1RVBIaTZjeW1kcm5GdTRHdk1Gb0t1Uy9reENqR0EyRlpJaEIreU5rV1dI?=
 =?utf-8?B?RGhLV0VUMlltaWZYcnlQY1dJRzZ5ZGxtWW9LTzJaRWs3U2xxeWJBMzNYNm1l?=
 =?utf-8?B?YTc1MGgxRkVBOElERm9XMHEvY0RSalZTdGF2Qm9MUnBtUWVJTUtMT1k4aWVM?=
 =?utf-8?B?QnVTY0QwZWhBY21mU2gzQ1Z1QksxZWcxQzhWNFpGOEpSTWlSYW9JSXFxUXFM?=
 =?utf-8?B?emNya3NJNGxDQms4dDlydlc4Z2hMODRmZCtFVHdXZGF2RGFPeTk1UEVRa01K?=
 =?utf-8?B?aGY4ZGVpYTkxVHg3VUFWTmdDY1Y5NXFQTloxQmppZTlIa2lYcElxR1Q2M3Nj?=
 =?utf-8?B?TTBEdVR3RGNaZDZuRkZTb2dRQ2NNM1U0TlNXUUNwcy9wK3hVZkhrRGh6aTcx?=
 =?utf-8?B?YnZHaDJXR0JQKzhyWllZTkxaclN3VmlqVlRIZ2o0aTBSQlJMaFZjZFU1MkRw?=
 =?utf-8?B?RGxVWjVJNnNHS2krWnZza09GRzg2bkU3dWgxZVA4TkZzTElYNG83SURjbllT?=
 =?utf-8?B?WFB1eDg1V2c2QkNGS2FndS9VVHhNUFdrcldnV29kdkpXRlJLSDBwa1p4aWFN?=
 =?utf-8?B?NWJ3TkF4M085UTdtcTQ5QlVNUU5VZUdGclgyeGpnQkxBQ3NYa3piQ2hQNTJh?=
 =?utf-8?B?MXNrZW5aWmZEVFZPSlllQmRPV29qMllXZDN0N3lxTkROT3JWVGR4SUI5S2s2?=
 =?utf-8?B?QytSbW5PWnJZcTJqelZCY3laUkxJTXA2bzlyR3R1QzdVQTVPQlZWclFXQnBI?=
 =?utf-8?B?T1RKRFByejdINHB5REp6LzFhT1RsM29WS3Z4VkNWd1prTjAwaWN2djJuTFZa?=
 =?utf-8?B?akxzS0NNRDZxaUROTmxZU2RDZkFDUlNYaStrckxCUFdpd3VJdW9SQU10aEg2?=
 =?utf-8?B?ZHVZUGJodTVTTlBEc0M0NnYzdU5DNnVSc2YwYU9CZ2p6c1p1VGYrOTM1dVEv?=
 =?utf-8?B?Um5UWUVLQTZ0aHBGY21md1ppdlo5NW5oL2ZYbDNuS0FYTG44YVo5dEFmLzJU?=
 =?utf-8?B?RmU3bDc2Y0wvT29OeCszMXpFVEZDYXNrSEJGMjVEaEgwdnIyWjlNL0Q5SitS?=
 =?utf-8?B?a0diV0V3dVFSU0Z1VHRpbUNjdFQ1OGRWR0kyWTh4aUpKWTEvVmVUTm1YYUw1?=
 =?utf-8?Q?tWaxQSebg2gWR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di82UFMxa3NXMGZwYWxvWEc0S1pJblpJQU5Oa2RhZTFvWG54OVE3YWhjT3JT?=
 =?utf-8?B?UjNORVZERDRPQVBMQVVZUnF3YjVsaXdPb1AvQjBSeEpFcUxQVGphNnlNUDJK?=
 =?utf-8?B?anFCZnBSb05FNlhkTExCby9YNDZGeUR5eDYwb0p2ZFNkaEJjUHRKWmVrak5w?=
 =?utf-8?B?czZCVUUwaU5VYnRtd1pYTGFvYXJwUGlSSTZjSldvdlZmeExnNEg0VG1QSk9S?=
 =?utf-8?B?c215bnVpZVFEZTZ1NnpWaEw1U1djNkUyM1dUNkdqSUJoQnovMk5xOUtjYmVK?=
 =?utf-8?B?YWRrUmpacTZYcEc1cE9hZGh6MW5ydVRiRW5sOUp0MGlTcTU4Qkt5MG05VERk?=
 =?utf-8?B?WFNkTTVWM0tXNmc1OVIyM0doazNPWUxoU29yeEhKRlVYMHpWbEk3ZXlxVGRO?=
 =?utf-8?B?NCswczNwdUR4Q0xYMmlyendxTWRMQzIyMXYyaktWbEI4bGw3TDNCRHBiaEhV?=
 =?utf-8?B?WHdubUZ4dGdVQTlQMVpWM2xEVXJpU3hIK0pEMGUzeGFSd1ZFM3JSd3hDSmpl?=
 =?utf-8?B?MUJVMzhkSWk3UDYvT0JlNUtid0Z4enpLQTlOUVVxNHJYbDBlVmxnV3JqKzAw?=
 =?utf-8?B?eXo0SEJMM3J0dGZ0YXJIYkRsMHRJZHUrVTBDS29VdEJkWldmd05DZnJ0T3Ft?=
 =?utf-8?B?d0FPMkFyVTY0R0FLc1JtYm12OUtsOVRMSXAycGgrYzBPa3AyMjVNUDZqNUp4?=
 =?utf-8?B?KzJzTTQ2aDFFQkZGNnBwZnpUcXV0WjF2V1JsUkplalVRcDVCaVBueTkvclNj?=
 =?utf-8?B?bjYrS1pieGczNEVlUTFuSlNCZnF0OVB3TXhQK3pack8zTGhiR2dzcndFMnkx?=
 =?utf-8?B?VWQydjdjMWtIZCtOdittL0RkWHcrVEhlbGQ5RlVZQXREOGRVbG9CcDNhdzJ2?=
 =?utf-8?B?ME91ZDNHTWVBZndXNWVCd1RlSkJZSVhiQTNHemJPSThEeG56bGhHNlU5aGp1?=
 =?utf-8?B?b1BsVWJoQXd1WE4rdWxUaCtqSVErczdMZmpyR1psbkp6RU1lZzFOc3hFYUpp?=
 =?utf-8?B?U0d3OEhDUUk1Y0JtbmErWXVyUklORUJqZWorOXhJd3lwZVVFUW9Bd3FjR2tz?=
 =?utf-8?B?Q3VjOGZGS3NzWTRwNlFaaFBtMjEvUmZWRTV5TWRDQ2JyT01BaEQ1aTJ1T2ZD?=
 =?utf-8?B?dHczMGZDNEU0cVh6MTJ2TTVuaTFhYnRJamk1NmM2S3pBWFNFOWh1MVZVa04y?=
 =?utf-8?B?cWxQd1ZWYmhKZHBGOHJHakFocTVlSTU0L3c1NnZVUm5aOVFTM1Vna0RpREZi?=
 =?utf-8?B?RG15d2JZL2tMNkhieVJEWjh5bXhzdkwvNGhiNnIwc0M4U1lPRW1oWFdJMEYz?=
 =?utf-8?B?SmhBa3JWVVFnckxtTGQvVFprdXV6RGdMUHpFMUFCbXFGWkVvb2puczZacG9S?=
 =?utf-8?B?SCtObVEzeXZuTkNEbzNrVG5UaFRtNnpZOTg3RE5WNjJ1ZWxXL2NGdFoxZFpB?=
 =?utf-8?B?OGhxa3ZxTU5qOTRqZlo3b0U2b3c4ZkJFUzJzN29FcDdrbmVjOVRqVnpNSEQz?=
 =?utf-8?B?Y3g5R3U1Q21SU1VpK1ZSRExyY0sxdnI0WDgwb2Y4MkhuRWd4NW5Pa0ZlMnpL?=
 =?utf-8?B?T2x3R2NRcGEwSC91Y1YwNFMzQ3kwTWh5L3cwTEF2cjZ5aWtta1ViWEg2T1pR?=
 =?utf-8?B?ejFUc3dWaXVkMlFxUlpCVHF6NlRjaVdCc3hJZ1FueU45WDR2Y2pja09HK3B0?=
 =?utf-8?B?d2N0NUhIZTNUemVhZjlJTmxIT1dueUFiZFdYcUxjcGJ2NFZvRzh2TVg0cW5I?=
 =?utf-8?B?MnBpYWxiNGYxbm44ZGF4OXNMaGE4cHN6aW1xUWtuYkQ5QjNIQ3FlYko3SWJx?=
 =?utf-8?B?UXdxVkNBU2NIZWVLemJHQ3lFL3FxdHdpREdkdFFIVEQvRDBYOG50RVA1amdG?=
 =?utf-8?B?QUJxRDRndDV6VDgwaGRPcHJ5azFBYTdwVEFoQUFpdzFaQWliTHprUTE4Tkhn?=
 =?utf-8?B?bkxWNEluUVNoeEZMV3VPc0tuQmlBbEdIMXdEQ0pvdWVhNW1jT2EwV0FSS3I0?=
 =?utf-8?B?Tlc1dDhCc0hFQjZqNVVsUEtrYU9lYmtIRVplZjlsMGRkQTgwT1RaY0NlQ3lM?=
 =?utf-8?B?RTBHM295RWQveXNaalczU0wvbng4QlFyREhQamhNNXJBTENIMFduTW5tOFZk?=
 =?utf-8?Q?v9apnf9/cInlsjs/Kvf+nnHw5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf3d3c7-ed88-4de6-b727-08dd680c9b22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:09:11.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSwUHIFLEZay73yT7Z1vAwU4KKGQTVYFX6c69WZI19Wr1TjEDG8vWi/WjhbPTJFIrkoU3Dv8CoVgTi+i8o4Wlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com

On 2025/3/21 07:58, Yi Liu wrote:
> On 2025/3/21 01:24, Nicolin Chen wrote:
>> On Thu, Mar 20, 2025 at 06:47:28AM -0700, Yi Liu wrote:
>>> Provide a high-level API to allow replacements of one domain with another
>>> for specific pasid of a device. This is similar to
>>> iommu_replace_group_handle() and it is expected to be used only by IOMMUFD.
>>>
>>> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>
>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>
>> Some nits:
>>
>>> @@ -3420,6 +3436,99 @@ int iommu_attach_device_pasid(struct iommu_domain 
>>> *domain,
>>>   }
>>>   EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>>> +/**
>>> + * iommu_replace_device_pasid - Replace the domain that a pasid
>>> + *                              is attached to
>>
>> How about "... a specific pasid of the device is attached to"
>> aligning with the clearer narrative in commit log?

click too soon. some remarks are not responded yet. yep

>>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>>> +                   struct device *dev, ioasid_t pasid,
>>> +                   struct iommu_attach_handle *handle)
>>> +{
>>> +    /* Caller must be a probed driver on dev */
>>
>> What's "a probed driver on dev"? Mind rephrasing this?
>>
>> Also should it be placed outside this function?

This just follows the same pattern with the iommu_attach_device_pasid().
It was added in the below commit. I think this reason still applies to
this new replace API. So just add it here.

commit e946f8e3e62bf05da21a14658f8cb05e2a616260
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Tue Aug 22 13:15:56 2023 -0300

     iommu: Remove useless group refcounting

     Several functions obtain the group reference and then release it before
     returning. This gives the impression that the refcount is protecting
     something for the duration of the function.

     In truth all of these functions are called in places that know a device
     driver is probed to the device and our locking rules already require
     that dev->iommu_group cannot change while a driver is attached to the
     struct device.

     If this was not the case then this code is already at risk of triggering
     UAF as it is racy if the dev->iommu_group is concurrently going to
     NULL/free. refcount debugging will throw a WARN if kobject_get() is
     called on a 0 refcount object to highlight the bug.

     Remove the confusing refcounting and leave behind a comment about the
     restriction.

>>> +    struct iommu_group *group = dev->iommu_group;
>>> +    struct iommu_attach_handle *entry;
>>> +    struct iommu_domain *curr_domain;
>>> +    void *curr;
>>> +    int ret;
>>> +
>>> +    if (!group)
>>> +        return -ENODEV;
>>> +
>>> +    if (!domain->ops->set_dev_pasid)
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    if (dev_iommu_ops(dev) != domain->owner ||
>>> +        pasid == IOMMU_NO_PASID || !handle)
>>> +        return -EINVAL;
>>> +
>>> +    mutex_lock(&group->mutex);
>>
>> How about guard(mutex)(&group->mutex)?
> 
> yeah, baolu mentioned it as well. But given the

I may listen to Joerg if he is ok to use it. :) I haven't seen it
in the iommu.c yet.

>>> +    entry = iommu_make_pasid_array_entry(domain, handle);
>>> +    curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
>>> +              XA_ZERO_ENTRY, GFP_KERNEL);
>>> +    if (xa_is_err(curr)) {
>>> +        ret = xa_err(curr);
>>> +        goto out_unlock;
>>> +    }
>>> +
>>> +    /*
>>> +     * No domain (with or without handle) attached, hence not
>>> +     * a replace case.
>>> +     */
>>> +    if (!curr) {
>>> +        xa_release(&group->pasid_array, pasid);
>>> +        ret = -EINVAL;
>>> +        goto out_unlock;
>>> +    }
>>> +
>>> +    /*
>>> +     * Reusing handle is problematic as there are paths that refers
>>> +     * the handle without lock. To avoid race, reject the callers that
>>> +     * attempt it.
>>> +     */
>>> +    if (handle && curr == entry) {
>>> +        WARN_ON(1);
>>> +        ret = -EINVAL;
>>> +        goto out_unlock;
>>> +    }
>>
>> We rejected !handle and !curr cases. So it should be enough with:
>>     if (curr == entry) {
>> ?
> 
> we only want to reject the case in which handle is valid and it is
> the same with old handle. If handle is null, I think it is ok to have the
> same domain.
> 
>>> +
>>> +    curr_domain = pasid_array_entry_to_domain(curr);
>>> +    ret = 0;
>>> +
>>> +    if (curr_domain != domain) {
>>> +        ret = __iommu_set_group_pasid(domain, group,
>>> +                          pasid, curr_domain);
>>> +        if (ret)
>>> +            goto out_unlock;
>>> +    }
>>
>> Oh, does this mean that we can just use this function to replace
>> a handle if domain isn't changed? Maybe add this in the kdoc?
> 
> if handle is not the same and domain is the same, yes it should
> succeed. yeah, doc it would help users.
> 
>>
>>> +
>>> +    if (curr != entry) {
>>
>> Hmm, since we rejected "curr == entry" already, we don't need to
>> double check any more?
> 
> as the above response, it only rejects when handle is valid and
> happens to be the same with the old one.
> 
>>
>>> +        /*
>>> +         * The above xa_cmpxchg() reserved the memory, and the
>>> +         * group->mutex is held, this cannot fail.
>>> +         */
>>> +        WARN_ON(xa_is_err(xa_store(&group->pasid_array,
>>> +                       pasid, entry, GFP_KERNEL)));
>>> +    }
>>> +
>>> +out_unlock:
>>> +    mutex_unlock(&group->mutex);
>>> +    return ret;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, "IOMMUFD_INTERNAL");
>>> +
>>>   /*
>>>    * iommu_detach_device_pasid() - Detach the domain from pasid of device
>>>    * @domain: the iommu domain.
>>> -- 
>>> 2.34.1
>>>
> 

-- 
Regards,
Yi Liu
