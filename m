Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7668C11
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619315; cv=fail; b=nPOqFr5SYlDK2t5BP4qJtmSeeL3sPmn5Em+3vtRKh8FnUfrEC3oY677P9ocJ5cAjsWpnO5OLzUPieaXWf/j3Q/hFB9HWhW2hYy7xB/IM4/+4gaJFMI8katDssqwb9B2Ow5RlwHqoPElJhetQ0H7HqF+TJNPnzoiU2nxkPKJf6rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619315; c=relaxed/simple;
	bh=kqCnCL2rlXKU7i3qm+0R0K0ZIJPp/6l3qjStZjbZGzI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fSGN+DtGjfmZH0t7lrDNBfYenOsOctTeNymL8ym6Q8HcyaLKtHnjm5P9s1wnbEo36p5k2hbbfYGB7aY6cwQh4bTZUjvK1cg+JdlJ0qQ8zRPPelyxeZVYFkCplojlI5TAi8+Obya/kqMy/9WJJvAAx45hYdSO6ldWLmC7M5YxWtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMCpPKNO; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMCpPKNO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740619314; x=1772155314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kqCnCL2rlXKU7i3qm+0R0K0ZIJPp/6l3qjStZjbZGzI=;
  b=iMCpPKNO3783iV2p+kn9K86aXEWpbeb3b0XFkwFdT3hRdbLJB/cxij3m
   B8b4vQtzsnMjvn/5gdBDRyjGEAKp9iD7ff5Cu92h90zi9JYXtN4azOOXs
   pDuVon1eNdUJkhq7p+A2WJaYXFWs/F52GALsEWYWo01eSee9u7OLw16lm
   fhLoXxcG8a4eJ0bwDSuGExV3b/WwEIKACzU7x3fM0789AWkUUrQNiYqeJ
   kNs8hWXr3WwiVl/Tkln2gX1cTGrnYrLRV76Yrx0BGibrf+gmBrfBS9pxb
   o1nkGv/TkeBOrL81tGtzM/22GUcwRruqmG7uShCkmETU9xXLu58iad5xu
   g==;
X-CSE-ConnectionGUID: yEtSirWdRC2t2SiHXfpH5g==
X-CSE-MsgGUID: hoIPKR19SXyUJ+j9UrEwGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41693075"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41693075"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:21:53 -0800
X-CSE-ConnectionGUID: 9QHTXWPOR3SHm/86zlTwag==
X-CSE-MsgGUID: 4k0QsbbGR4mMq0fyDYcr/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="147699238"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:21:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 17:21:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 17:21:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 17:21:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdkilSu0HDPq9pcIOD9xIfbV7+F8UuajKTvOVBy0a+2UDd3VjcrDYjac5Kf/ZLbvg6HxARTLXOluGdXHbx0LfTPZGABEzdCdStbDZH4qrbGinnwqfXOTyu61cjMXA+nibjsF3EIQI1OWkrFwcPuopYH7I9dvHeaYxDRKmdg/is33vJPOHSjDqArjuRlK6/kJCGEQsvYIZAy2iQmQsje+nil+bduSUC407JoGHSm67VWrmXmHycYfCZX2USVAfW+WaFGQp1Uu4+xHRObqnnpA017PBRn6scItex4EldafHH0mI1YIk/GCNWvp70uWSwj6mcuLRYkPlKNjIEVWL3FGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qapAyzHH37aZvUzxCuwCN0dyVtfOA97bvlh1bgROLpg=;
 b=DkVgK/32xtUIls+CwJR1C5mSImNvSBYuFqdLzVrilCa1Ri/Y0TTcdw1f47sjPaewN3JfF9GnN/Kf8lGIxRsMMm6nP4gCN/hntCOj80PmRSnfvAjmIgesoj9ZIZFvdfa9W8fgTBwgYdQFnr5VwsHTnN7IC+u8kO9xbGWuzZJ/eM16Le6VIQ3RIIjvqbqEH6LDhf6/sHiwyeEqOt16k5g4gEvvQcPQ0mY/J7ZELs39P8nOaUoqXRs+cFjG4iK6M1/jPhE1cUTKBlTE1F2C6hqi/odqHMcaEV0w/Gldix+ox6Yp0cUuPEQoYw/NajyQeUSPb70Iz+DzFcDBZLpmaVZv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 01:21:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 01:21:48 +0000
Message-ID: <db3df4f2-445a-49e5-9362-70cdaf363420@intel.com>
Date: Thu, 27 Feb 2025 09:27:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com> <Z7+SrQFXdheJQzuK@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z7+SrQFXdheJQzuK@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a697dd-e886-44d8-2351-08dd56cd1b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHkvdENVcmRESlVsQ0pRcnRjM3lRRzhaQ3lIQmdQTHhHcGN0MkxZVW9PZzR5?=
 =?utf-8?B?aCs3Z2tnR3U4NlpBbENhcldrQ0VCNmVxdFV3ZFhjTkY1ZExaZXZldjVSZk1s?=
 =?utf-8?B?M200ZDRuekx3RUQrWjB4RUpWMXB5Qkc0VkRQZ1JXNnllQ1FMeUFWRVhxM05I?=
 =?utf-8?B?c3VUL1ZRQjdGckZEMXNrOWprczdaS1JWRm9hNlFvUXFxazJ3ZzBwbWRBZ0lu?=
 =?utf-8?B?UkpVUkhxaTBhenArd0RqUTE5Ky9IMkZoamlPWHFFK3hUejFETVpaeVQzN1Bi?=
 =?utf-8?B?OGwwTDNMRExVWXYwZlFLd0p2eEF1SnFJbFI4Vk1tYklNUldrVnVrcmFNNWtE?=
 =?utf-8?B?RU40YWNoT0FvcnlmOWxEdWJNbFhpOE5LMGhiOGF4b3N5eHRjVk1KcHBJaEhl?=
 =?utf-8?B?aWYycHpZdzlIYzZ0QTBOZjZmbDUrbDZIUkRITjVSUnkxVkltSW41SEZLTk12?=
 =?utf-8?B?SjlNTys4YmtVQkxtR1pwWGxHbkJqOXptb1lTRTA3WUpOVFQvSTZtQmtlVG1j?=
 =?utf-8?B?S000UkFjcTBLWUw3L1JBYWlkYmd6Y2kzdUI2dGdmUEZvWmFjT0NlMXdzMzdq?=
 =?utf-8?B?L3h4clA3VEVLN3FJMkdsMEkwYzY5Y2EzaTZOcGdiZk1sNlhSc0EzNWJYM2tR?=
 =?utf-8?B?ZFZUZkx3RE1LUnpZNERZdEdDVzZpamNqVmdzZDE1TkY1eUxrRFZOYnM0c3d6?=
 =?utf-8?B?TmtFeHowb0NWcDdLTDVndHdqMzRzVTNmY2lSSDc0c2NSVC9abU9XdVp0UEpj?=
 =?utf-8?B?SThjeUF0YVBtRU9Mb2xjMlh4QmFjdVVKWnlQUlBWQkY3THJHaDZ4eER0MjVS?=
 =?utf-8?B?N1dSaDBYQkdzWFpMOEIvbldaSENUcm5YWlN0b2FvaFFwcnNzMHNzUnhOdG9i?=
 =?utf-8?B?ZnIrZVJsNXVlaUNVWVdZcHQwOWRHNS9jaGlnMlNUdG9acyt1R01FYzFQNUcv?=
 =?utf-8?B?enovOS9LSVpKZGhpbDIyRStmSVF4N2RGMGdLWmdGV2xjaEMxYUlvRExOaCtS?=
 =?utf-8?B?Z3dOaXM2Y0owWVFuVkJpcmx5MTRlRFlxV0pVbDA2bEFyZmZSc2N4aFlIVVVR?=
 =?utf-8?B?WURma0xkdlhJTkV1ZmVsdmpxQVhiQnA0K1NTczJ1ZnpVSEJZZ20rWFo1UUNa?=
 =?utf-8?B?RlZrVkdHUGdXaURPS090RzVQRG8xNXVyKzdGSVhpbUovV2d6Z3ZFaUhybGpR?=
 =?utf-8?B?S2lUbmNSZndESWtzbnpPYXhiVVVYVXIzNWpzL3RrcmF6SEk5QTROTE5aN1Bo?=
 =?utf-8?B?V3VCZjl4SWd6S2ZyYXptamhJeXkvQUc5L0ZqTXdjZHZDemxKUGhzL0N3cUt4?=
 =?utf-8?B?U0FHb3dKcCtWNEUvcTh1YUpHWGFMU3QwaWwyMXFNVHpaVms2L0dvVEZIcW5z?=
 =?utf-8?B?RkxJUzJhTW9rY2xKNVk3WHdvQm9IS0pRS1hkR0MrRE9QWUYvWkpSTFlMNEZa?=
 =?utf-8?B?UktjYnA3eGFncDBhV0tmUS9zVkplV2VNT3pMRTdEN28rV2tFQlhYdlU2U1Zq?=
 =?utf-8?B?Q3o5VTg1NmZpaVM5SHc5dlNaNTFORGl5My9vcDdHeENqVTMwSWRpUFZFTnRB?=
 =?utf-8?B?aTBtdlMrYmZZQ1ZMS0Y3TjZuZno4NGlBMXJWTjhjdyt2R1pONThxa09NQUtD?=
 =?utf-8?B?aGJCdTRJU2l2NGQ5dDE0UUFNSk01WHBkQ0MzR1VMSklzK0Zpckh5Vk5GcjR1?=
 =?utf-8?B?aHV5ZDVkUmlqOVBYUEFiU2lHdlk5WkpOb0VUQ1M3elAyOGQ1RkxQSWZEaEVY?=
 =?utf-8?B?Mk1HYjNGcFhQZFVCOExLTmQ1WHkwNEF2aFE5RGw3dEZGclhqdmJlM3NXdERr?=
 =?utf-8?B?ZUhpQ0pIZFM4QVB6dk0rZWNLQk1uMEhJeU10TjdtOThSdlBaZlhpbTM3MW9R?=
 =?utf-8?Q?NiaHs7D6edUnM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1pMd3puOXF4RXJHMVdDN0laaTd3enFrMDUxZ2pKMFo2NS9TdDhUdkJkcjRV?=
 =?utf-8?B?ZE9XdlFaanNVRTJQQ1Q3Vm9pMzhOTlZGazdqcU85Tkp6bFBSQUhEWTVzdkx1?=
 =?utf-8?B?Z1Vja1ZtUlNtaTlkUkhLaG1KZm5LVlpIdXdsa1Z1UDRtTXh3TGtNbDFSdE83?=
 =?utf-8?B?K0NiSkVoMzFtRXBUaW5YT2pCQ25RdC9lOHNiZ3hSTDZJNXJUcDhKcEhxWkE3?=
 =?utf-8?B?RWxrOU9EeVQzeUxmRHhIN3NyQ2pNcVlyVTBFZm14TW52dGpYUGpRYTBWaFcw?=
 =?utf-8?B?K0laaGJmR2l1NENBUHdPVjNtYlI4VVl2Vlh4dVBXbStPZGt3cGNIYTlMOWYx?=
 =?utf-8?B?cHhRR0x3UlZ5dVd6WlRZRmJMUWRFRnAvdFBWcy9yOGFVb2RXVnBrNHE5ZFl0?=
 =?utf-8?B?OVd5em1xYkNrRVVNQ0ZnZlBGSkZEVjBCbXZ5NlRVcjJ4RjJIWHBGRkFvMWYw?=
 =?utf-8?B?QXZTOG1lbzFBL3BjWkRqbHRDb0JtdjcxVEl3TEc4ZnFpZE9zWjA0cy9uNnBy?=
 =?utf-8?B?WjRXZkxaL1hEZkJTS0puZVkvbG5oK05vZHp5QVY4aVgwK2RwVVdzZkR2WVps?=
 =?utf-8?B?UU1UREw2NHFjZmsvOWNZMktvNFdBUlE2bTFrQjI3Y2w0dEZWOGVHRWVkTjdK?=
 =?utf-8?B?dFp0YU4zeTJiQ2wrcVRybnRnRkJaRHhkbW9ma3NNcU93WDdHMmpxVE1XS2k1?=
 =?utf-8?B?L0lsc1hyekdJcms0c3d6d2lqeUVxODlJT3haVjB0eHJMZE5DdnV3SndsWG9M?=
 =?utf-8?B?bG0xL1psaEM1akhBTURyd29UaXZxelJ4Mm9ST1VOcXpXRHNZNFFyZGJvT0VJ?=
 =?utf-8?B?RWdnWGQ0V2V2bE5RbzFUaE1rTFoxOG5BQklwWDZUNGxoZ0JtbTdOYjhNTlNP?=
 =?utf-8?B?Rnc3MCs2MFBsb2FOQjZzZUJzenplTmtXd1NuM2s4eERKZklrNHpKVlBBazRp?=
 =?utf-8?B?QjhFTUJodSs0cG1Bdk9pWHpDT1g2aGUvbnVRZzJJZHZjQ0R5bWcwK2l1WU1s?=
 =?utf-8?B?NHVxamFWRm41UDJaelFUUnJYQ2FqZS9vNndsVjR1TGorSmFNRXowOVRoMkU2?=
 =?utf-8?B?NytMUVdMOWRQdzdib2MvTmg5YmlJS050WTg5SFhPeXRaZDR5bXBTRkdMMG1L?=
 =?utf-8?B?aTM2YmdWRmlDZzI3bU1SbWVWcnJWbm5Vd2x4Y1luUGZXTFhyaUd1elpWeVpN?=
 =?utf-8?B?TDRTVmVSQWVGT3ZXWVcyRU4yZk1uMGtjcVZ4N2d3V2x5WlRqeUVTSzRXR2Nl?=
 =?utf-8?B?bk1pTWczNDcwelhZT29PY3JjMUpCSnp2VXRRRHY0U2JSU0pkRTRaeGxQUkVh?=
 =?utf-8?B?K20rZzNrZzBVTmFuWFRnS28yL281MEpLeXNRYnJDd0xEZ1hEZlhVMGMva3pY?=
 =?utf-8?B?WUo0L2QvdStYWVpHYjZUUzkrWEsxaUVIOG83d2sweXFKRFNCMUZlYWxNNm8x?=
 =?utf-8?B?OUUvQ2RlNDBNb1daWnErYzBxSVN6ZU1ENFlyUHBLV1NkT21VN2p4dzVvekN1?=
 =?utf-8?B?U3k0K0MreVNISmR4MnZsWVpVM3VvcGlCZzVUdTg1bGtXN0ZDTDgveDdVaWVl?=
 =?utf-8?B?ck1oYmQ3TVRJSzlwYzBNcGdkTU5jZUtjS0xTMXprMmwxdjdwaGJGNDFWM1pJ?=
 =?utf-8?B?ZGg0UzNKU1VvOFlhZUthd2cvVU12MmE5RFBqVitGTElyZEI2OWkxbStHNWVF?=
 =?utf-8?B?K2pSL056OWE3NkRlU042STlpZXViVGJNaVV2V01WeFpTMzAxSmVjczdsZ1Vt?=
 =?utf-8?B?UGVYcDc3NGFNcE5jKzFoNFhVcHFkd2Fva2VBcC9aMW1LcWxCQURYenlIVitV?=
 =?utf-8?B?U3pWbER3ZUljOHE3SzFkS1dmdG51Nzdhc2dJZ2w5MkpxaTBXandFNjQwRURi?=
 =?utf-8?B?U1pXWDZGWXlVUWhXQ0FoR1o2NVdFSUpFU0ZEUUtsdlo4NVhRTzNHMy9ZYmRR?=
 =?utf-8?B?ZHAzczBqR3RxZTEyekhIYlFZaUpocmFDdEdoOFA2RWx6M0k2WHRoTzViQ2Y3?=
 =?utf-8?B?ZlZuUUV0K25oUmFBT3BYYUxNMG13YU1VdUxEa2dxaDFBL0F1bURwek8vUXJz?=
 =?utf-8?B?ekl5VGJSZjZ0emhFOTNLT0JUVCtqUXhFRHdVVmhJcy9rbDVtWTFEeEZUL2c2?=
 =?utf-8?Q?QZD2Uuc5JjGzk2pwLn8u79LkL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a697dd-e886-44d8-2351-08dd56cd1b30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 01:21:48.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWCab96bn8s8O2BPBdVifGdNMzSlVVV4ko/6EvPDQMh7GR1qmKXm8DCVwXUe/16mInwla7TcOmBgfFcsXa8n4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7381
X-OriginatorOrg: intel.com

On 2025/2/27 06:16, Nicolin Chen wrote:
> On Wed, Feb 26, 2025 at 03:40:21AM -0800, Yi Liu wrote:
>> The existing iommu_attach_device_pasid() function allows both a valid
>> handle and a NULL handle, which is not consistent with the RID path where
>> iommu_attach_group() and iommu_attach_group_handle() coexist. To refine
>> it, this adds iommu_attach_device_pasid_handle() to cover the case with
>> valid handle, while let the iommu_attach_device_pasid() only deals with
>> the case with NULL handle.
> 
> Hmm, I am not very sure about the necessity of this change. The
> underlying function being called from those two helpers (with/
> without handle) is still taking a NULL handle, which looks very
> straightforward to me already, so this extra layer feels a bit
> redundant..

I think I should have added a if (!handle) check in the beginning of
iommu_attach_device_pasid_handle() just like the other _handle() APIs.
If so, this should be clearer. is it?

> 
>> @@ -130,8 +131,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>>   		goto out_free_handle;
>>   	}
>>   
>> -	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
>> -					&handle->handle);
> [..]
>> +	ret = iommu_attach_device_pasid_handle(domain, dev,
>> +					       iommu_mm->pasid,
> 
> These two could fit in one line.

got it.

> 
>>   	if (ret)
>>   		goto out_free_domain;
>>   	domain->users = 1;
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 73a3b20b2ef9..f6dbb60ef948 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3354,9 +3354,9 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>>    *
>>    * Return: 0 on success, or an error.
>>    */
>> -int iommu_attach_device_pasid(struct iommu_domain *domain,
>> -			      struct device *dev, ioasid_t pasid,
>> -			      struct iommu_attach_handle *handle)
>> +int __iommu_attach_device_pasid(struct iommu_domain *domain,
>> +				struct device *dev, ioasid_t pasid,
>> +				struct iommu_attach_handle *handle)
> 
> Should it be just iommu_attach_device_pasid_handle?
> 
>> +static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +					    struct device *dev, ioasid_t pasid)
>> +{
>> +	return __iommu_attach_device_pasid(domain, dev, pasid, NULL);
> 
> Then, here:
> 	return iommu_attach_device_pasid_handle(domain, dev, pasid, NULL);
> ?
> 
>> +static inline int
>> +iommu_attach_device_pasid_handle(struct iommu_domain *domain,
>> +				 struct device *dev, ioasid_t pasid,
>> +				 struct iommu_attach_handle *handle)
>> +{
>> +	return __iommu_attach_device_pasid(domain, dev, pasid, handle);
> 
> And drop this?

this needs to check the handle before calling __iommu_attach_device_pasid().

> 
>> @@ -1139,6 +1154,8 @@ struct iommu_fault_param {};
>>   struct iommu_iotlb_gather {};
>>   struct iommu_dirty_bitmap {};
>>   struct iommu_dirty_ops {};
>> +struct iommu_attach_handle {};
>> +
> 
> Nit: no need of the extra line
> 
got it.

-- 
Regards,
Yi Liu
