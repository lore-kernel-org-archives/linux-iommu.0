Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ADB201006
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438981; cv=fail; b=oM9Y4YdqMiFD3s/5+XGiV2QRLGhDg8NgxluzDR9CKTH6ojHQVPYf74lVaBSutt9yI+X4WFSdheiZZcF4h3ovJiN/dgAoYuE75HDT8KWxngFe8E0NsFKkpRYSLcWFlocLIiCCT1sspGjhOWCTj9YQlBL3h9+OF2uy4CTL9ZN9NFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438981; c=relaxed/simple;
	bh=i6NoSLp1ny3nWnjTQaUvxt7qW8fjFzFSV9ah7YODrAA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jBQGsicNALeohyh2Z04myN/CmMMBhJ/XQEvEiCgiGY7MsMEasIfo5lT5rZpTNHz/HQB9rUJcVex7j0aW+PEs+6yxklvyE2v3+aVVkJso64UF+CkCBghlpGdjgaPYr9vbIoHTwboFCGTkXAkLyfocYJYQ9eBrC3oBQsdVgZTHWyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWy07ZBX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWy07ZBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739438980; x=1770974980;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i6NoSLp1ny3nWnjTQaUvxt7qW8fjFzFSV9ah7YODrAA=;
  b=lWy07ZBXeufTaqiq++dFBUrxtTk8hJktdffL4PJb1dsJrstz9oWbXCeD
   gqINdz1Nb0F3AzxwdkglSMwd0nJUuwOpOrzjp435PEenIxJ0Yn9Dis7jV
   Y1bZq7iHcePJLF/e4ajcUWhKD73rKOolk5OBcFZb5QuKPNG4RbgM/XpMS
   DObViulYLSpWerJf0dRnH2pQ9PCCHQub/Y3W1W5BrlfjBQ4NBT0y6FeEw
   sWoc7q3V7f2p+dYPn+GIHFsZD+bZ3z8TCzXI3USg/21Fk2nBbbM8RNoMo
   E5697/Cq+7g998Iu90sWQQfvBtrb2x5hVSNPeSRWPuVIDXpeu+5i468QP
   Q==;
X-CSE-ConnectionGUID: JVv1xhyoTSWj/g9/z8iZbg==
X-CSE-MsgGUID: AJmm3grvScCRfJdoEv+uBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="51525838"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="51525838"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 01:29:40 -0800
X-CSE-ConnectionGUID: 8MPPjWLlQXW+lIudaYIzbw==
X-CSE-MsgGUID: 8J+BgWr7Sum1FGoDqwaR2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113617033"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 01:29:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 01:29:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 01:29:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 01:29:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBw4PZ44q6+mJsLt2l7f4V71tbVbgaq4BlTbDxRla8YHyIpyF94E+PKhn8C7g8/4syaIbnPG3kckY8Uqx3AOZ4ASj1oDuCCBrR7wWNdOPiTrDbJxD+6uVAYYC5loADG+Br/7UfzqfLMe9Qw3YW9nUOkGF2H3v0bkQduCiHqJ9ufPxm1mVjjeV4GA92wo6GOIQN5IYhn/KaBvle+jYGqSDSxmpjDroLNxsF/lm+wy2gWhLzCSHRx0Cadq+2SmznXIDxylmg9WXbDPbL2MMj2ADQEWS6Gmn0GiCrEEQXxk2A3qu1b6N78aasCfxHrsjem3IAQaO/0YKSUVzDgrVJAh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s2BMHFvRMMZokdnF3z9GihJbCiU5t9pRpL/OHzQn3Q=;
 b=NHLaQksdfYh57JXHFzuIIQSz8ea/UuaOeUY+xVHaxm8v8oZtZ265/9dhoCf1iNnSz2RMpmiWHhyiTBCEXHhYSSWzLp4pw0MWuiJ3YI7PS8oOHlt3Bg8fe15+m5SLWwe7f+NdS9qe2lCW6YSPXWVcoFSL9T61MSYGF2EJyz6cwSw+8/qIDxxd7rHVZvVq2eV9qW95kU8zQO99teosEQqfidC6eyQjwY0Ng26LTSfqnlMyVUzICtd/hBpfUbOu9VYTej5HN+jK3s9Z5V3n7uOhF4w2usy47st3nrZNKBxOW9hIbfDHLpwc68eWcWHT7dC/ZdpO6ZmqJvel1mlSKTPlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Thu, 13 Feb
 2025 09:29:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 09:29:35 +0000
Message-ID: <2399c639-b9dc-4c7c-bac8-3776cf6a88f5@intel.com>
Date: Thu, 13 Feb 2025 17:34:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<kevin.tian@intel.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
 <20250212125930.GQ3754072@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250212125930.GQ3754072@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: 483b8b40-560c-4dbb-889c-08dd4c10edc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkEzS3pNTzlaSkR2SkwrR1NBcTNUWGwwb0xwR21ZZTByNHc5eld5T0pSNHBR?=
 =?utf-8?B?ZEhOVkd1UU8zT0VGNjllOXZQWFVKMmcyWDVRL01TQy9NUUl6TDBEU3JLMEVT?=
 =?utf-8?B?OWJEeXhoVlVMUHkrY1B2d1d0ZCtFREdrTmZoczVyY3NQb2FnK3FFT1YvZXpR?=
 =?utf-8?B?VjNUY2tUQXJUWW9MQUlJT09tU3ErWDJPaXp0a3U1NERldC82QzlvSi9Od2lH?=
 =?utf-8?B?NXZsMDBJakZJNjhheXFpTS9FOTV3d1QxemU1NXk3NVkxRXZRVzFOaWhPc29y?=
 =?utf-8?B?eWNUTFo0S0VaSndjcGhKMHk4eHp0NHNFN29qQ1lqQlZsU1lSaGpqZlJlWDlO?=
 =?utf-8?B?RlZYYTlJVHd1VVBTNWFtb0lKV09DRFl6dTc3SHNXdU1lMDltY1BxTnluSDcv?=
 =?utf-8?B?SjdZYkY5NlFBdUtNaDVPMGNlaExSWGNkWjJDa0pXRVBvTmN6ZmozMlliOWwv?=
 =?utf-8?B?N25XZHo3M3NqWUhuZ2laalZzUXdlVzh2bms0eFg0aDRHaGxZTjVqNm5hN3JE?=
 =?utf-8?B?TXNwWU9Ec01UcVdDUXlIazN0WkpzcStOVkUyTUw3alB6UnlPd0hpYTV3WldX?=
 =?utf-8?B?VXdSTllNV0dsVFh0OUJYbkhuOU1tRVkzUndEWHlZcDFSRHIzUXliS0R3Y3Jx?=
 =?utf-8?B?ak9rblBTT3ZEaXZEcDF5VjM3L0ZVZWZOdjh4TzhoTjJGUG81THUxV0JoelZS?=
 =?utf-8?B?Y25iVkhwY0RDd0JDTWRKWitRanpacWFhdkpIaG9WT1pHMm1hREh3WC9URzc1?=
 =?utf-8?B?TWQ1dTIrZWZGVmpydTJySHNJa3I4MkZqejIydXNsU3FjYldzQllOZ3ZOWUZJ?=
 =?utf-8?B?MDlzbU9TeCtUcGdZTWhCTlBTcUowU0w3TERNMGpBREtPMlpFbGhaRmRuMUFH?=
 =?utf-8?B?NGRkc05yUEpjRzdsMkJ1amN1V294T01JTzRCT213NWhyc1pFM2ZSQjlqNWJO?=
 =?utf-8?B?K0h0dlFVd1FxVzNreFFGekhkM2lzTXl4K2tZVVpGaVFKblE1eTNOVm1HT0JF?=
 =?utf-8?B?aG1sRWV5RnF3ZzhndklMblBoZlVrMTZyZUNINmp0RmdvSmhnaTE4bGFTT2FY?=
 =?utf-8?B?N245eC9aZFJJZE1lU0ZLRGJ3QmJ5Nm9GcDR2ajY3Q0s0eWdWZEpTcitRaFMz?=
 =?utf-8?B?NUhCcHM3cWM3YWI5Z0Z1RHlaZ1RIc05VUjg1K2VudXVmc252eUR5VmEzR1Fk?=
 =?utf-8?B?TGcwV2tqRXhLS1RlTld6RWowWURrYXFySkNLTXZ6dWpnZU91eENQbVhUK2d3?=
 =?utf-8?B?bitDYlJwUmNuekdQRWpQL3ZLWDBtU3MyK3k3VGpUZmZGS0lHeTZQd0lVNXMr?=
 =?utf-8?B?dVV5Yi85cVFxMUo0YmhLYUZSNjR5eDVrQ0xYckxkeWZTQjJqbFlycGptdkp5?=
 =?utf-8?B?WEZtaGN4cmVTQ2pmTlYybnJ3RDFoMmF0UWVibzI3aXBzM1luZ09nekFHNUc3?=
 =?utf-8?B?OGV6OTA2M245SkJveHdMclJxaUdTUXZ0YWVMWVdhcjJYUW91WG4yekpTcEtq?=
 =?utf-8?B?R25ocnhEYXVhTU9weWFvQ21ROHYyNExqdStuSGhZV3B3dE1JWnFrNVJjRzFn?=
 =?utf-8?B?R1RSUUNZbHBjeHg5Z0tXOTI5dWYrNTBSak9WVUR4UU8zcWZlVlJVRzF0ZkxC?=
 =?utf-8?B?SmlYU0Q1NUxETVBzY090L0lMTUdZWitZZnRsWjhCWTFVSEwyODlhTmRrQjli?=
 =?utf-8?B?ZEZhcXFIL21DK0tQekRrSHRKcXNjU2xaSk1sMVJrZWkySlNxYnFsWkRnYjZk?=
 =?utf-8?B?Q0Vwb2VRcFhyYVhXRW1JRkFWSy8zVVhjbDk0ZlNWNkRZWFROOVdOK2RNSit4?=
 =?utf-8?B?ZzJsd1Jkbkt5SlkwMWE1aFRTMFV0ai9GVHE0MHNiNlFmMkMvU0tsemlHd3I0?=
 =?utf-8?Q?cZw4vJRSxBeaT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHpieVFiVGpzOUczZjJvNlRkTW9qa1BYRXpFbjFqM1d0cVltK1NHSlV1Zktt?=
 =?utf-8?B?eEdzZUhpZW8rRUU0MjI2UE5TeFFhSXM4ZEswUksvOHdOUmFrU1FQaStaREhn?=
 =?utf-8?B?ZC8zZ0V3UFN2WG80VzNKUFd5ajQ3VUtnZlgrVU01aTYzUFo0eFVKOFFEU3da?=
 =?utf-8?B?eEsxeFNaRFo5WFRFaHd4NXM2NG9kV0ZPYllWRjEvM0NKUVFjUHovUlNUSFVp?=
 =?utf-8?B?SmgvMEtBTm9EUzhMTHNLck93ckJIb09KNUdLVlJ2QUZ2QWRWZmtWSWdnZ1gw?=
 =?utf-8?B?TThsVHBmZVJoTWI5SXRSdDVXYVUrVGxab2Zmd0MrcDRRckloV2xHNFIxMUZa?=
 =?utf-8?B?b2Z2ZUVOZFJvT1QyVkoxcGtjQmYvNStwQ2diMi9kYStSUXVObTNZY0lrNjA5?=
 =?utf-8?B?YWpQMGM2WUFIcWk2RTdiTktSSUo2UjhpalhzVlE0YkJHSlBld2tGTXFyWWVV?=
 =?utf-8?B?R1FVNW1yZEVzYVUvZEhTLzFsdWI1WjVsZVRIS0tKZnNQczE1RDB4cEU0S3g2?=
 =?utf-8?B?dHZrMVBKSXZxVkU3Sy8yVVBaMTdtZXhBRmVmQUMxRmxtRWMzUzRsK3BVV29F?=
 =?utf-8?B?dTJiMnNoZ2xoMk9jTTJWR0dNbDk4dnJjTGVzUmlzQk5lU2dFSHZaV0ljbUJz?=
 =?utf-8?B?UWJjUm5wSWJ1b2pzaHphazhyb0RIK2ZVb1RKWEFnVW1wK0JVVGRlclJid3Rv?=
 =?utf-8?B?UHNReXlrNlR2WGw2N2NwWFlZZThBMzIvMW9KUzdBTnZTZlg4NCs1d1UzQzhO?=
 =?utf-8?B?OHBLbW1IZTgzT3hEdUtLZHJYclhxRHByTUhRK3BSNWJsVHZSN3BpUkMwb3Nj?=
 =?utf-8?B?Q2dWVFY1UnBYZWZRRkhyYkhMQlN5NFkydzh6bUI0UkxFRW85UHh3b1NqZ2tR?=
 =?utf-8?B?Z0hVSEFRYXhhN2VLSHhoVmczeWxtTWVuaXFWRFlGRGw0VHlVdnpGdEhlaVda?=
 =?utf-8?B?cjRxT2IyK3YrcXdEY3RVVllmcjUwVUpPQXk1eHVxS3h4bW9sWXVDT2N0NktS?=
 =?utf-8?B?a1Y2K2t4Zmtkbm85eHBZc3hGREh0NlllLzl3bEV2Y1lUdHo5VlRuTE90UUVm?=
 =?utf-8?B?MDBUVzRLall2TXZoTGhjSDV1SlB2NnByVzFXZEhvcWU4UlVPeDdpWHY5MnVE?=
 =?utf-8?B?WUtBbStPMHE4QVkrS210UjNWci9TVDBHLy9PdTdkKzVWZEd1dk9qckRabXZw?=
 =?utf-8?B?ZG1EQTVwa3VYcStrYWJwSWEzOTErVlNlMCtPckRxVUhDOHd2MUYxLzZ3dlBz?=
 =?utf-8?B?NVk5Yy9HZ3F4dmNUV00vZFFOVmlMKzlISmJ5QkkzbzUwb1hodk1lcmxNK09D?=
 =?utf-8?B?TDRDbzIzQVF0QmNQRkUvVFZKVHZTcUg4V0plUWxnUjl2aWNGMWhRbGdDayt1?=
 =?utf-8?B?NXJLUXd1MldZanEvMlVPZ0d2QXRPbkpuT2FPM3dsNHVWa1IvOElMSEgyQkF3?=
 =?utf-8?B?a1cyUnRpcXZDS3M0ZGVEVXhoaDFGZVdRdTBsWU8waVZhZFFHVlF5N1FXNnY3?=
 =?utf-8?B?dmdKLzZ1aktqZjJVVEF4MUs1elRwZTdqZCtWNTFGZ00rWDV5cVdCT1l4WVBY?=
 =?utf-8?B?UzNNTEtvOG0yY0JMWXh3K290ODhvNmtpTE1MZEJUQ3BpYjRSclFPOWMrRnpB?=
 =?utf-8?B?R1VSZjllSkZwZytPRmExUVFxK3B1Vlo0R0lhajVXQXd5eHg3bFVlb3pUd2l5?=
 =?utf-8?B?d1JYcVdRR3Vja0VBQWRFY2ZUd2c1bDdnT09ZTTM0NUhNREpGU1h3MUV5bUJw?=
 =?utf-8?B?OWNDY2M4aWozVmtXMU1GcUFUNGZmc0d0ZTZINVZlT1RZd2VoQm9CbnZyR3NQ?=
 =?utf-8?B?d3JQMUtSVmUzMWwzc0dUemhqZDhlNFZuMmJEb1JGZ0Q0Q1QyQjFCa0haRm1W?=
 =?utf-8?B?SXc4a1ZVaEtCbXpCVFZOOC90NlVMMnN3bXlod0l6OXdNMTRlN05aRkl2QTYv?=
 =?utf-8?B?ZFloc3NXaWl4cVdVOHZ5MnJlSTAzRzNpYm82cGpzOWR3M2U5Q1QxWFRKVVNT?=
 =?utf-8?B?Tzd0ZWNBQXplR05LUStKQmlRMjJwODZvNlVkS29id1pubVBPVkxFOWsyV2Nr?=
 =?utf-8?B?UmxpNkowNWswNWxNNzJlTzlzMExDY0cxbFNQZDhId1ZtenZKQVl5eWlBa1RM?=
 =?utf-8?Q?buCDrCfxgXDyi+2TdtwW2K7GD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 483b8b40-560c-4dbb-889c-08dd4c10edc0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:29:35.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPDjpotPfTyqoBX+8iLGf/QakoSKI9p7KHq5/8L2nkBJoYzCl6DNd1SQ6ePt4Z+2VtjYtFPGwz3U4ODutEV9sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com

On 2025/2/12 20:59, Jason Gunthorpe wrote:
> On Wed, Feb 12, 2025 at 03:47:57PM +0800, Yi Liu wrote:
>> Let's consult with other vendors. We need this enforcement because we lack
>> a straightforward method to distinguish between PRIs in stage-1 and stage-2
>> under nested translation. If other vendors share this requirement, it would
>> be appropriate to implement this enforcement in IOMMUFD. Otherwise, we may
>> check it in intel iommu driver.
> 
> I do expect HW to be able to distinguish S1/S2 faults for the purpose
> of PRI, otherwise you cannot use non-present pages in the S2 at all,
> which is something that is very desirable.
> 
> Eg AMD as a GN bit in the PAGE_SERVICE_REQUEST
> 
> ARM has a S2 bit in their F_TRANSLATION/etc

thanks for this info.

> IMHO not being able to do this is an Intel limitation (that you should
> get your HW team to fix)
> 
> However, right now there is no driver or core implementation for any
> of this, so setting up a S2 with fault should be blocked in the core
> code.

yes, as iommufd always pin and map user pages for the paging domain, so
I don't think there will be any PRIs on S2 due to non-present pages.
However, PRIs on S2 might occur due to insufficient permissions,
potentially caused by userspace. Nonetheless, I am skeptical about the
existence of such use cases. What do you think about it?

-- 
Regards,
Yi Liu
