Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC11DDC11
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570441; cv=fail; b=qh4Rx2nu1sugp8h685YackKmNcUc/W9NL91UlxkC3NfY/RScnLAojYbWMZAqQlftp8cMmEzrkF2RAWW8/ePdVfFiYvRwBoDL+H8zUA6tBs/41md4LK1WYFG+lFyajN9E8JZoT/PYFQDk21glYLObgc4Yc6SsTWdPNFKVrvjgmtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570441; c=relaxed/simple;
	bh=cJ8hPS2PyShvnA2/zGPdz/RY5XDfRyThbp+XurGKxBY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AP/j04qP4NRdEkbGJnLqORTde5oQhCYopm44biIJfKNyY8B5Frw+hlgA4cMg/hgn4CrWITwOBzrgI08mNUmyd0UwWOnjyJged9jt1qQcDmY3keFAXPlFUd+ojBrIlysIB/HeOkLxy+AFe/24IykBwBhbLZy7C+FrDOQdhcMpqrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uifgp5Ey; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uifgp5Ey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742570439; x=1774106439;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cJ8hPS2PyShvnA2/zGPdz/RY5XDfRyThbp+XurGKxBY=;
  b=Uifgp5EyLgFjyvIEbNcz4TUoSF86OzZcrwa8UriIEA3djPZA9N/Ok7kC
   kCnXkbWbiPeKbIXLcTY5Opk1D3jlLJEzwsf6i94FAQfhHjoRuJ4zaZtV3
   sHoSuCHIthQEp24CBiuf+8FdhMwK0dHcXRYI8BPZWGGflFgte02qZkb7N
   iuJ0yf+TlDEWdMGXd3hsBm9aoOhA6IEfDKZJTdDaG2Npi/ekGkRm80i1a
   8G+tjHnvGMkoUkU7T1Xyg9+gRL0ZyjhFZSC2O3j93xTm+8iixJX9gsp4Q
   s8I2nJ9iTAe+r4FnBLzHuyVGZOUyAXHHJ+mFo2Yqchz9u5OOcmk7Vgp9b
   w==;
X-CSE-ConnectionGUID: K58ynctRRG6CpV2Y4r033Q==
X-CSE-MsgGUID: JLRcKsHhQdKJqayDDEKsmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43081233"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43081233"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 08:20:38 -0700
X-CSE-ConnectionGUID: 6EiHKQT2SCCGjS2odwjDgA==
X-CSE-MsgGUID: cO7EyfrqTHuo2RH+SX1uKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="128482794"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2025 08:20:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Mar 2025 08:20:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Mar 2025 08:20:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 08:20:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7ytzkNYE/Zou2PX8QcuO31wsumVXwQHvuls4Hq/xA8+1XAA/DpusD1NXj12HFNEfBefxlOXSOipiAly7vG4yYEL9D2p8l+6J2iIoGA+o8eKDVd5zD8LhdaOmR7J05XXqP7qySa85eXZenbyAY/dDLr+a6etdvFWF+S32p2Hexg99o91ZJXAQDaohf0U+eamojmx8sSsbsJcIyqhcJQPGfPGPZhgjZpC6e2NfdfX3tlgBj3GgVbFqdT+2v7CYhvhb5Z58IWC7Tgno93NHuTOgLHJFHg++OoOZW+QVb6eLE5IZyDtQmXX4M6ULB/hGFoGg5FdElajSIsWPkbrtO0bNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC5YDPQzQq22ef/jNlxaCFwqY3RaCQmeqCV5MbNroRg=;
 b=VS7TJQheIGcPkVUhpHmb64N2rAKb02MiYKkRl5Y2a1ASnUhq6JQFq19fo2d+/VCdCmiUbC4dxqrJlqhQzhw/mcfXMwY6NXfTIpdOJn0V04sF3zP7cCHYqWmZJ5lqMdTv6ywX1NzA0Triq7HihOMNN7//q1GdffhsTB/s1f2019nFE+KX/OjGNbL86ulguntmLrqsfbpMuTkOp9v0Mls1YaLQslg2IgBfOIwjuf6iXSu0JFUuHDK8A/fus9Y25cTrTNWXDwIamOprm22sT4raDbR12f6JNPgwpdOkHV0jFgf7czVjA1d/pqq7H4ZeUo6jv4e2aKWVYmYaUG7gkfHfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6401.namprd11.prod.outlook.com (2603:10b6:510:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 15:20:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 15:20:34 +0000
Message-ID: <c90acae0-98f7-4317-b279-2e94f6627307@intel.com>
Date: Fri, 21 Mar 2025 23:26:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 18/18] iommufd/selftest: Add coverage for iommufd
 pasid attach/detach
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-19-yi.l.liu@intel.com> <Z9yz/pVlPy6sOxP0@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9yz/pVlPy6sOxP0@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 9587b1e0-baf0-414f-acde-08dd688becdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ei8rUUdyaC9CTW1kbVdGQ0VLNWhvNjVwanlhLzVqVXUzb05ZbVBCTjVUL1B0?=
 =?utf-8?B?R1dKZGNCbTRTT3E4WVpnQVRXQzFGQlVkMTVNMEJTeC9CSk1tVkFxTHdUUnFz?=
 =?utf-8?B?Tnp4ekV0d1Y3Rm5YYTZ1SDVZYUl5VWFvZTJ6UG5hL25uNEhxMm1Vbm15MDR0?=
 =?utf-8?B?S2t5a1NBM2dDdzFNdjZvdHB6RnFtZ0ljSXdGamRUREd4WStMNmhKS2QyeGtL?=
 =?utf-8?B?elJGMVVBLzdrWWlNbThTRTZ3QW9LeTdiaGcwYnRiaEFVKy83bEhFSFYvRzUz?=
 =?utf-8?B?YlhrMUhFaU1zRmdXRitFODVNNy90Z0JacTZCY3BucEhKQ0hIbXpWcHQwdjJF?=
 =?utf-8?B?dkhwZVNYYXQxU05ZZkxzNVdGbUpENmFoRW1PMTB0bVNBRVViTkYxZ05BZlBB?=
 =?utf-8?B?VS9kOVF6SU5uSktJSGpXNVRXU1RHRGdhbnlDeVJKcm5IdERZVTQvRWlKd0dI?=
 =?utf-8?B?RHl2aEJSMW5kS3lvOUIreVRLVlJreERRNFVEL0F1L1V5THdaWE9IdkN4Ym9O?=
 =?utf-8?B?YXUyR0JmSVNjMzIxM0hZS1JjOVFrb3VIbzNSNy9IcmNQcnJScHo3YXU4WEtS?=
 =?utf-8?B?YmpBUUc2d2dzeXdzWldjS2tNR2xPSkkySkV1SDkxZ3d5T01mc1lycXdrb1dD?=
 =?utf-8?B?S0JpSWxGdDVLUWVWQ29HNWd4dHBLUFlBK2VVdGlCYjFLd0V0UlNCT1pNeXh4?=
 =?utf-8?B?SmlDeS91Y1Z5V2pLMXM3cWRxVjA3c0hzclBTS1pOQ1BCSFJaMVRDRlUzbDJQ?=
 =?utf-8?B?eHQvWXdHVmo5dUZjVHU3VHFNNTRsV0Z6UERtaE5aWDZZb3ZQZlV4M3RuV1di?=
 =?utf-8?B?amhzUVAvQ3VLcXlaZDRLdHB3MTZ3MDNaZXZQamhucWtXbXh0aEJaV3VxTXN6?=
 =?utf-8?B?TXpaME5DM013UnZwM0dGSnV4RjNJcEZtTnB3REdBaGxLdEV5M2dFMlhHL29B?=
 =?utf-8?B?bnRJNGNxaXNCQ25QcFJqYVkwUlpBNFNvUkpEL0pyRzBVOEpZb20yTnhaZnND?=
 =?utf-8?B?OEZPclZ4OHdMU01qU0l0ZGtKbjhHODRHSWFwWTcvczJYazZkbHJsMlBaUXFD?=
 =?utf-8?B?ZGZnU2JLZ0tIZzlPejhaZmNSQ3dLam5Jdzk5Ny9OcjhaT1FrZm9zQ2txaUgv?=
 =?utf-8?B?VkRicmVPYWo3VGd1UktvOGExUEg5b2ozbTBlL25oUkZGclRacXFWd0VPbUZN?=
 =?utf-8?B?MC9LRFQ3ZkJEV0ZHMWZubkNBSXk2QmpRcEVRQXpCeDhRb2Jaa3ppL040UU05?=
 =?utf-8?B?WEZWendCTHdzdTY2aFBXelRFZkM5NTJuKzZOamxwN2Y1bEFJWStXYUJKWStz?=
 =?utf-8?B?M2R5RFlIaE1BTWVwM0hEY3ZqR20xRWZLQUUrc2NrYjB6NGMzc2JibHBPeS9X?=
 =?utf-8?B?bExqWmIwTDByblNtR283dGRvcCtaOW9Db0ZKdFAxWFZ4YXZmVW5lYmxXR1Zt?=
 =?utf-8?B?djdsREtJSnNRaXdXbEFkMmltaEtsQVFYcTdpWFkvNCtRSTRicEhoZmRiVCtk?=
 =?utf-8?B?dEtpOGxVWGowTW1oa2Nzd2lrLzJQYStTSTJ4Smd6b3FpNGh2MWM3d3dVMEpk?=
 =?utf-8?B?VXRJZFhLWnI3TTFYa0FKeWpIOUprcXpROSszN0lLSTNhOWhjZkpkTXp5UnVk?=
 =?utf-8?B?QlFiRzdpZjJEaStLUndoRFVTODIzSjh0T3Q3MzlJdUd5K2llOGRxZUJPSmdZ?=
 =?utf-8?B?Q2Z6RjVxV1doekJiTkV5VGNOT29GbUVyMXFLYkxTUjA4VCtFcFhyZkxvdGYx?=
 =?utf-8?B?M2xZeFkzV201OWhJQ0hGZGt1b2N2cnFGZTFydlAxUFdPWEJCUi9aaGVRSEdk?=
 =?utf-8?B?bGd1R0xXZEpJL2VsUU96UU5wTTlKWnBXeGhpMUZzR0U2eXh3eTJxTkJxNjVx?=
 =?utf-8?Q?A/OxAYBOOU/cm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WERzUUdxZmExOVk5bU83K3lmMDZyRUpvdit2YjBJbW04SGxvOGFvRVlvRWI1?=
 =?utf-8?B?VDhkVDJubVM0SFZhM3VLazQ2Nkl0a0x3K1lMRmlrdThCaE1RcS9wRUU3TVJG?=
 =?utf-8?B?K0Y3M2JWbzU0STI3RTRPaWcwdlVKR1RyTTV0SXh4SmtFcHE3RUlxd1JCV1hq?=
 =?utf-8?B?eGxZQW9tU0tKeHdWc2pzc05lNU5SOU9MSGdCUzArM3NWdHhNTnVoUmdvNE5n?=
 =?utf-8?B?WFZLc3FLTHZGVitBbHVONkRoWmhEaHJxa0FkTHRMYVErVU8wbmJ2N1lDSzFJ?=
 =?utf-8?B?Wk9rTlpsY3pieEJObWVxTkI0SjUzNHhxY3Bad0ZSL3RCM3NlOHdCYlFwY2JK?=
 =?utf-8?B?K0gva252SVNvMGtDRDh1cVRJVjE3Q1VQWDQ2QUVvSXhodGF5VGQxNnFXN1ZL?=
 =?utf-8?B?STlJUzhWMzFFQmJodEtzbzRjNkRrbkVTK29CRlM0TnhjMmttbWxCbGEzRlhi?=
 =?utf-8?B?LzY1RzdqVlhKN1h1QUh4eGVwMjJ2cGNXTEVrWE91WHN1b01WcGc4NGxuTml6?=
 =?utf-8?B?c09FMjJ3RHdUK1JFRWxCQlE5ZUFXcGhaYyt4eHBpelZvOGxPeFBQQnBWWjBi?=
 =?utf-8?B?TmVGS3pYMURMUWlSRStsMnVYeVNjRW12RHFyOW4rYmZmUjBFZ09oSUVwNE9T?=
 =?utf-8?B?SWMxQWZNcWZlRWJYaHlhN1dMRXBuQW11T0oyaEJZYjBoSFFPSElsR2dmVzFZ?=
 =?utf-8?B?RFlsS0oyY0V6Y3pzZXRjVUNJTForUHkwRzlpSlZoS0hKUFR0ajhWTkIraFU4?=
 =?utf-8?B?RUpHOHFyeEFocy9scVpaNnQ4Y2FLMEhrOTNYN3VLamZQR05ZQWl0blFaUGNp?=
 =?utf-8?B?blJoTm5TajFmN3JXRVRBTVBiNVMwd3VTQkp5V3Q2YXA5WGJPd1Z5dVgyV21D?=
 =?utf-8?B?aktyRmlpbTJ0cVBwRkxNb1dSMU95eDRoMG55VkFQa0UvcDJZSHY4elg4TDVw?=
 =?utf-8?B?Z1lHNkp1aktGU2JDWlY2YkxIc2FqL3l4bFpycDZaK3hRTDdZTE9IQ3dGYTV5?=
 =?utf-8?B?Z2gyNXBFM21YMVNxTUdCS1F5NnRXT1F4N0NMV2NhVlNtSUp5LzZUVjlqSWtK?=
 =?utf-8?B?RlZnWmdnU2FqUEVZVURiR0NNVmM1ZU5WR0pHSzNsOGNVZGZ5WlAvM0dNbFJS?=
 =?utf-8?B?N3E2ZUNKK0o2cElzeTNiZUwrQUw5Z3c5NmlFYU9ndDk4QUhJcmRtMjE0d3Vz?=
 =?utf-8?B?bmlxZkV3TnRPbmo4czFGblJrY2ZFUzNnSDlHTG1Ya3dlN1BieWtORG1SWlFY?=
 =?utf-8?B?NCs5S0NhVFZicFpibnJNTEszNUs0L1JUNi9RcWJtdmhXaDZJbG5YdnlMS2Qy?=
 =?utf-8?B?aTBzUXU5TEptYktsYTVTUTVSZHcyVGRQa2ZBSHpyUGdPRG5NYUNtWFEwWHVZ?=
 =?utf-8?B?OStENkpSeFgySmpJUlJwYU41MlVFZWdRcXZpTlZMT25MZlh6Zlp2UTNuVzhw?=
 =?utf-8?B?T0hmVVVGKzdxVWs0UThHekdjVXVLZEV3M1BFbEczbXpaQitCaWpHNEliaU1R?=
 =?utf-8?B?NnhERS9NK2hlbkZjLzkveERpTTBqMHpjd3NDdXltUGdnenZVckRpVm1PMllI?=
 =?utf-8?B?RVVQaUFKajNQVnNVQUhBZ1NJVTNyZ0Q4ZXJyVTEzcnVZN2R0aHQvM085OHpG?=
 =?utf-8?B?ellWSVFqVHRwNzd4NGNQUE5aY3BDZVQ0RHdRVzZiQzRtbmdhVWVsSXhER1I0?=
 =?utf-8?B?amZ2clJEY2grMTBSemRacXRwN2xVYmtTdWtxa0YrN1Z5TUpId1p3MUtKK0Fh?=
 =?utf-8?B?SERMK1hoOFRlYXRpOStZNnIwVVI5bTlzVU5tR3pOeHhzWTVNL1p0Zm42UFlj?=
 =?utf-8?B?clFYMXFvd01QdS94cHJ2MlJ1VWJCOTRydGszNXpYM2lVMll2M0ZGcHdycEVl?=
 =?utf-8?B?VithN2lraE42a1I1WmZPVGU5UnlGKzMxNVhsTHJraUdsQjNTazJMd2dkNWMw?=
 =?utf-8?B?MERjN3JLM1I2NGJtL3JWL0ZLUXgweWdFam9tZ0RLaHF3RnBRQmJqa05JVmN6?=
 =?utf-8?B?ME1uZzdCMitOSnVqVjBnR3lDYUtjS3hjU08xeTl0S2hseWVTcXp2NDYyWWdl?=
 =?utf-8?B?NnAxeVc2YnppWmUxV25JTUhkUktoV0ZRRzhnWHRuNHUwTEFoelJYRDRXVzgx?=
 =?utf-8?Q?O/FaaLiYsr28fwVa2BSBKzXNt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9587b1e0-baf0-414f-acde-08dd688becdd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 15:20:34.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N3vMtu+IJjLH1oO0AvEvK08L7afabekNoG7gcTRxtXRjF1hHjByQZdJLRtA7M/eTk0VGR/mf9rI93FXWmKudg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6401
X-OriginatorOrg: intel.com



On 2025/3/21 08:34, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:44AM -0700, Yi Liu wrote:
> 
>> +TEST_F(iommufd_device_pasid, pasid_attach)
>> +{
>> +	struct iommu_hwpt_selftest data = {
>> +		.iotlb =  IOMMU_TEST_IOTLB_DEFAULT,
>> +	};
>> +	uint32_t nested_hwpt_id[3] = {};
>> +	uint32_t parent_hwpt_id = 0;
>> +	uint32_t fault_id, fault_fd;
>> +	uint32_t s2_hwpt_id = 0;
>> +	uint32_t iopf_hwpt_id;
>> +	uint32_t pasid = 100;
>> +	uint32_t auto_hwpt;
>> +	uint32_t viommu_id;
>> +	bool result;
>> +
>> +	/* Allocate two nested hwpts sharing one common parent hwpt */
>> +	test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
>> +			    IOMMU_HWPT_ALLOC_NEST_PARENT,
>> +			    &parent_hwpt_id);
>> +	test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
>> +				   IOMMU_HWPT_ALLOC_PASID,
>> +				   &nested_hwpt_id[0],
>> +				   IOMMU_HWPT_DATA_SELFTEST,
>> +				   &data, sizeof(data));
>> +	test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
>> +				   IOMMU_HWPT_ALLOC_PASID,
>> +				   &nested_hwpt_id[1],
>> +				   IOMMU_HWPT_DATA_SELFTEST,
>> +				   &data, sizeof(data));
>> +
>> +	/* Faulte related preparation */
> 
> Fault
> 
>> +	/* Allocate a regular nested hwpt based on viommu */
>> +	test_cmd_viommu_alloc(self->device_id, parent_hwpt_id,
>> +			      IOMMU_VIOMMU_TYPE_SELFTEST,
>> +			      &viommu_id);
>> +	test_cmd_hwpt_alloc_nested(self->device_id, viommu_id,
>> +				   IOMMU_HWPT_ALLOC_PASID,
>> +				   &nested_hwpt_id[2],
>> +				   IOMMU_HWPT_DATA_SELFTEST, &data,
>> +				   sizeof(data));
>> +
>> +	test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
>> +			    IOMMU_HWPT_ALLOC_PASID,
>> +			    &s2_hwpt_id);
>> +
>> +	/* Attach RID to non-pasid compat domain, */
>> +	test_cmd_mock_domain_replace(self->stdev_id, parent_hwpt_id);
>> +	/* then attach to pasid should fail */
>> +	test_err_pasid_attach(EINVAL, pasid, s2_hwpt_id, NULL);
>> +
>> +	/* Attach RID to pasid compat domain, */
>> +	test_cmd_mock_domain_replace(self->stdev_id, s2_hwpt_id);
>> +	/* then attach to pasid should succeed, */
>> +	test_cmd_pasid_attach(pasid, nested_hwpt_id[0], NULL);
>> +	/* but attach RID to non-pasid compat domain should fail now. */
>> +	test_err_mock_domain_replace(EINVAL, self->stdev_id, parent_hwpt_id);
>> +	test_cmd_pasid_detach(pasid);
>> +
>> +	if (!variant->pasid_capable) {
>> +		/*
>> +		 * PASID-compatible domain can be used by non-PASID-capable
>> +		 * device.
>> +		 */
>> +		test_cmd_mock_domain_replace(self->no_pasid_stdev_id, nested_hwpt_id[0]);
>> +		test_cmd_mock_domain_replace(self->no_pasid_stdev_id, self->ioas_id);
>> +		/*
>> +		 * Attach hwpt to pasid#100 of non-PASID-capable device,
>> +		 * should fail, no matter domain is pasid-comapt or not.
>> +		 */
>> +		EXPECT_ERRNO(EINVAL,
>> +			     _test_cmd_pasid_attach(self->fd, self->no_pasid_stdev_id,
>> +						    pasid, parent_hwpt_id, NULL));
>> +		EXPECT_ERRNO(EINVAL,
>> +			     _test_cmd_pasid_attach(self->fd, self->no_pasid_stdev_id,
>> +						    pasid, s2_hwpt_id, NULL));
>> +	}
> 
> It seems that we should test these anyway without a variant?

these are for non-pasid-capable device. without variant, we only create the
pasid-capable device, hence the above test in the if statement are not
necessary.

>> +
>> +	/*
>> +	 * Attach non pasid compat hwpt to pasid-capable device, should
>> +	 * fail, and have null domain.
>> +	 */
>> +	test_err_pasid_attach(EINVAL, pasid, parent_hwpt_id, NULL);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, 0, &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/*
>> +	 * Attach ioas to pasid 100, should succeed, domain should
>> +	 * be valid.
>> +	 */
>> +	test_cmd_pasid_attach(pasid, self->ioas_id, &auto_hwpt);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, auto_hwpt, &result));
>> +	EXPECT_EQ(1, result);
> 
> Hmm, I thought that a non-RID PASID slot could only attach a PASID-
> compatible HWPT. I think I am totally confused now... lol
> 
> Perhaps we need a detailed documentation somewhere, at least as a
> reminder or so?


In this v10, attaching pasid to ioas will allocated a pasid-comapt
hwpt. But this is really messy. So I will make the auto_hwpt always
non-pasid-compat. Hence it's aligned between RID and PASID path.

> 
>> +
>> +	/* Attach to pasid 100 which has been attached, should fail. */
>> +	test_err_pasid_attach(EBUSY, pasid, self->ioas_id, &auto_hwpt);
>> +
>> +	/*
>> +	 * Try attach pasid 100 with another hwpt, should FAIL
>> +	 * as attach does not allow overwrite, use REPLACE instead.
>> +	 */
>> +	test_err_pasid_attach(EBUSY, pasid, nested_hwpt_id[0], NULL);
>> +
>> +	/*
>> +	 * Detach hwpt from pasid 100, and check if the pasid 100
>> +	 * has null domain. Should be done before the next attach.
>> +	 */
>> +	test_cmd_pasid_detach(pasid);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, 0, &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/*
>> +	 * Attach nested hwpt to pasid 100, should succeed, domain
>> +	 * should be valid.
>> +	 */
>> +	test_cmd_pasid_attach(pasid, nested_hwpt_id[0], NULL);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, nested_hwpt_id[0],
>> +					      &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/* Attach to pasid 100 which has been attached, should fail. */
>> +	test_err_pasid_attach(EBUSY, pasid, nested_hwpt_id[0], NULL);
>> +
>> +	/*
>> +	 * Detach hwpt from pasid 100, and check if the pasid 100
>> +	 * has null domain
>> +	 */
>> +	test_cmd_pasid_detach(pasid);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, 0, &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/* Replace tests */
>> +
>> +	pasid = 200;
>> +	/*
>> +	 * Replace pasid 200 without attaching it first, should
>> +	 * fail with -EINVAL.
>> +	 */
>> +	test_err_cmd_pasid_replace(EINVAL, pasid, s2_hwpt_id, NULL);
>> +
>> +	/*
>> +	 * Attach a s2 hwpt to pasid 200, should succeed, domain should
> 
> Attach the ..

got it

>> +	 * be valid.
>> +	 */
>> +	test_cmd_pasid_attach(pasid, s2_hwpt_id, NULL);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, s2_hwpt_id,
>> +					      &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/*
>> +	 * Replace pasid 200 with self->ioas_id, should succeed,
>> +	 * and have valid domain.
>> +	 */
>> +	test_cmd_pasid_replace(pasid, self->ioas_id, &auto_hwpt);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, auto_hwpt,
>> +					      &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/*
>> +	 * Replace a nested hwpt for pasid 200, should succeed,
>> +	 * and have valid domain.
>> +	 */
>> +	test_cmd_pasid_replace(pasid, nested_hwpt_id[0], NULL);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, nested_hwpt_id[0],
>> +					      &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/*
>> +	 * Replace with another nested hwpt for pasid 200, should
>> +	 * succeed, and have valid domain.
>> +	 */
>> +	test_cmd_pasid_replace(pasid, nested_hwpt_id[1], NULL);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, nested_hwpt_id[1],
>> +					      &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/*
>> +	 * Detach hwpt from pasid 200, and check if the pasid 200
>> +	 * has null domain.
>> +	 */
>> +	test_cmd_pasid_detach(pasid);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, 0, &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/* Negative Tests for pasid replace, use pasid 1024 */
>> +
>> +	/*
>> +	 * Attach a s2 hwpt to pasid 1024, should succeed, domain should
> 
> Attach the ...

got it

> 
>> +	 * be valid.
>> +	 */
>> +	pasid = 1024;
>> +	test_cmd_pasid_attach(pasid, s2_hwpt_id, NULL);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, s2_hwpt_id,
>> +					      &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/*
>> +	 * Replace pasid 1024 with self->ioas_id, should fail,
>> +	 * but have the old valid domain. This is a designed
>> +	 * negative case, normally replace with self->ioas_id
>> +	 * could succeed.
>> +	 */
>> +	test_err_cmd_pasid_replace(ENOMEM, pasid, self->ioas_id, NULL);
>> +	ASSERT_EQ(0,
>> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
>> +					      pasid, s2_hwpt_id,
>> +					      &result));
>> +	EXPECT_EQ(1, result);
>> +
>> +	/*
>> +	 * Detach hwpt from pasid 1024, and check if the pasid 1024
>> +	 * has null domain.
>> +	 */
>> +	test_cmd_pasid_detach(pasid);
> 
> The designed "failing" replace does "pasid_1024_attached = false",
> meaning that this detach() isn't necessary?
> 
> Or perhaps the designed "failing" shouldn't set "attached = false"?

hmmm. This naming is a bit tricky. It still requires the user side
to detach 1024. That flag is more for the conveniency of faking error.

>> +	/* Detach the s2_hwpt_id from RID */
>> +	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
>> +
>> +	test_ioctl_destroy(nested_hwpt_id[0]);
>> +	test_ioctl_destroy(nested_hwpt_id[1]);
>> +	test_ioctl_destroy(nested_hwpt_id[2]);
>> +	test_ioctl_destroy(viommu_id);
>> +	test_ioctl_destroy(parent_hwpt_id);
>> +	test_ioctl_destroy(s2_hwpt_id);
> 
> Once detached, all the destroys can be done automatically?

-- 
Regards,
Yi Liu
