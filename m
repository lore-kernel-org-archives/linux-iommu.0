Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CF157E99
	for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734676226; cv=fail; b=mXIw1qgxEnNfJstPM+8+3GlcAZgc02HMCBTyBlNhrjqsmaXRBvGykrvAdSZBGKdj3zFBsEp6OewbEQVYCwnTQu9OH6nfAEYzj4o9e2tqZo6rEt1FQ3enGFa6x9vx/8GiwA73hI0+LQGgNt+XWAfbFqmZWSAsxv2uhvXFenU8dhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734676226; c=relaxed/simple;
	bh=zPde8sy1xroq1GF12kMNVmSIGTkwDXErGIHOHtn/81g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BbgO/LNLo+uQyp1RKyFBV0iJj75r7Nu+dbpdgErNmXOeVMGr5TlmXqj8/L/CXeuhmandqIhZoaJEY2x6sUi4fd9hJre0PcKm+ReYIFFdYtobDPo+MgJ5+uYL3aSnB0mB6QKH27LrXFJxzWowR3YHo8Ii4d4havxuWvIMVfB1Us0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJAAZdiP; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJAAZdiP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734676224; x=1766212224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zPde8sy1xroq1GF12kMNVmSIGTkwDXErGIHOHtn/81g=;
  b=hJAAZdiPeaR/TTmf0VqlRJng/Jcvv5mS+ee5mDX7cmOJcEk+uqmHevoV
   VVlT+44wgkvfLDsk1JwkuaQuoI55UxnRf8Roptm6V4QDt6UCzdobkpzY+
   YjhmzRHRq8If9RjvQYPK4uJTqJlYLD+DlMOQ9gZTmz1fzpiZ/bQztE2Fd
   Ryo6BppWLwO6rKcE+188fA8dKKOKrocFnXxChRpyK5hJTIkWwofgNONsz
   TD0DC6PAgE/gzjA5aAuLcILrfxRxdSQHflb0hQv7bGR/VmQeXtYVrsX49
   4zREwR8eyNU1UtMokDh1L1edTSiFkj/chsTPkA3pK6lbFV5Zn1Z+1svIi
   Q==;
X-CSE-ConnectionGUID: m5gZrkRtStCi5noeOGVNGg==
X-CSE-MsgGUID: ykbUy7BFQ1OSjKwgEsKNrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="57691096"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="57691096"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 22:30:23 -0800
X-CSE-ConnectionGUID: BshV2Cn6TYqhqk9wfnfFuQ==
X-CSE-MsgGUID: lXX1TXl5SUeNg2Oqo/B3ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99246276"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 22:30:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 22:30:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 22:30:21 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 22:30:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrWkN8ql/yDElVXKwW9p0+grO56x45dE1lBAaAJh5Vl20wQTVoX7wAgrFmtzO3WFEVUo9xuWTZrERTg4g+1aVBODEg8+4CxczxyVcky5j9xbi053uAYylstHCEEwis6Zx6pz+Vnpxc+M2Lk0zwO2MQIli0FzFMfgx200P+GRfAo+ahPIciIy+rB+IED+moFsczvV7dMYpneI3nHtC6EoIZfLiSgrduZ15eN4zv8N4ncsFM3baEhDZUdkB3tvB+hDycZn5Y5TQBKh8pIzYNivQYuNBloYTAwFRWEAaCuEXYW2SDGgsEtzs968eS+igGwHZXWyXGQN33CaUyethISH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF32PHnHH6jlRg4MvIHcIHuANbMLrRCab04GkGJM5us=;
 b=PaqGahLRWTZ2mAHywknZXppZaVxywtOv6TaUvHMwINK9CcN2bLyYvr1iREjJAAyS4vPgGLzZMyGgdjtos/YD4chrI1Rk+qVCrGvVFFfj4hdVfPw1+bANJQkl8u62HNGnsg/Tr2ogeMpNsUEJYUd3AQzzmvuZh3xKHXKOcWleQ3yJ7I48ZpBFQ+eqdZ19u0KrG7BgHn8COHxrSXP3cDhIumxdhAtOPCTYp/leWH6IqHoE1VYyeJ/ICTpZDueJWuOrpABW0J/Ye2D3je1CJtbTMq9uVqeQaUYn+/rpXTQWKc522cdKpSZAj/uNlBg/wpFfgx5hpNhAeoWd5UuRd1oZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB8586.namprd11.prod.outlook.com (2603:10b6:a03:56e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 06:29:43 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 06:29:43 +0000
Message-ID: <f19ea3cd-2f31-45c9-a1d5-5e5b754a191a@intel.com>
Date: Fri, 20 Dec 2024 14:34:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/14] iommufd: Move the iommufd_handle helpers to
 device.c
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-4-yi.l.liu@intel.com>
 <a2f363e7-88e4-46ef-8755-8a5e0cc47ecc@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <a2f363e7-88e4-46ef-8755-8a5e0cc47ecc@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: be80ec31-3b5e-4cf1-2d38-08dd20bfb07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTl0STRGY2lRYUxiZnFkVUMxWXNta09uSDdUVkZjREh1R0djbklTUExnUE0v?=
 =?utf-8?B?d3pUS1hiVWllazRuTTdzZS83c1EzWXNuOGo1N1Z0NWgveEIyZkt1MHU4czFp?=
 =?utf-8?B?QUlrbTVmRmE2ei83OUN0dmtpWkdYSmVQWnN5YUV6anUwcDIrRFVpZ2FyYUdV?=
 =?utf-8?B?ZDlCZFQrRjJHL20vODI0S3dzNGZTNE5jZmRUdUNDUk5BNW5oTTdjNURjczl0?=
 =?utf-8?B?NjNwVGxTcmYrN0srbHR5YXBUcGlXbVZyUU8wS09DWElYck12Yi80b3RQTGNq?=
 =?utf-8?B?MlliWDRLRGd3dm1lQ3U0bkZVWGgzS3dsR0Npck5aM2xJRHZiTkNnWGgzbUVk?=
 =?utf-8?B?YjZScHorcjBsTzRtMTRBTUw4aGhlWnJoclVySnRBZzZpQkR3ZnZxeFRBNGxX?=
 =?utf-8?B?ZkNPR2t1QS9KNTN6Rjl3Q2w0NFFjT3pwaFBpRFJZTFpiQ2I3eHMvdmg2NWNM?=
 =?utf-8?B?VWt3YVpSMThSNXZHeVliK1NMYnV4K1c0eVBvb2NDb2hpL2JVcmhubitBUUQ2?=
 =?utf-8?B?Q3p1UTRhdDgwZ3J4bTFCM1ZLS2kzbFRnWFZUaWloY3lkSG4yWXFwdVY0UW4z?=
 =?utf-8?B?bCt3L1BWNzB6QlZZc1JwaUM3WjZDRnpzeXV6MXRRUXdPZ2NjMDRLQmhTMTVG?=
 =?utf-8?B?YUUybCtHNU1FZ1NUSlovN2FRWlpUSFFYdzk0a1hrMjZHcmhTdXY2TEhaUVRq?=
 =?utf-8?B?dlhPbkJUSHgvZ3dtWmRYbGMxRkxBQzY5d1cveG84ZFJrbXJZRTB4cU9mUXN6?=
 =?utf-8?B?aGZvR0lqRGpBZTJ6eitxS1IvWENBa1BVandyNmVaYkpUNVNZZk5kZGYvV1BR?=
 =?utf-8?B?RjJkbTFnRmRETE4ycm9RQzRKSytPVzdlZjhZYWx5Z0NGaTg4bXpKQVRFZGkr?=
 =?utf-8?B?bXlDRjZNclNtUUl0UVNWbVdpNm9oMCszcGxGTWJUc3ZuNGVYYkZxbjZFU09U?=
 =?utf-8?B?T09tQ1dzSTBUQ3pKRTcrcmVNTVgvRERMd1RvUThKUDdNcW5NdlJNeGNYRXlG?=
 =?utf-8?B?SVE0ci9CcmZDQVNiNGdqNzdpNzRod1BWUFZ1bExxeWFacUNUZERRM2dUWEp1?=
 =?utf-8?B?Q1dRVUxmclplcGo2eCtBRjJYd1ZYeHhsQW5nMVoxT1M0QXZMUXdwSWRIRXhZ?=
 =?utf-8?B?TjhxYXkrL3MyYzhYVnkvTG9kaEhsMlkydWR4WVJxaGR2dWpQWDI5bkdFVG9t?=
 =?utf-8?B?NEhNcS9ydXhGTEtHMDJDWGk1bUtHRG5ackVjV2NFSENuNUFiOGRIUkxiSGFs?=
 =?utf-8?B?cHVtUWxRVEREME9uMGJPY0J5UkEyNlRlTTZVK0h5eWgvWkRJenl1NkdFYVBB?=
 =?utf-8?B?ekpTL0hNcDJpallHTm5qTUlJRlVCNFA3TUpoVEtsb3Q5WERneUZOK3E1dEVH?=
 =?utf-8?B?dDNIc2Fmam5uVkFYV1dYdGNhSUtSaWJ5OHo4RmpGd3NXbVpNc2hEU1pHN1FK?=
 =?utf-8?B?aHRmcndtWE90ZDFyanpwdWFMVmxSSStOeERCd01SNmZrUFZ4M1hoOGZvOE4w?=
 =?utf-8?B?SkVWWWNsZGRFRkc4MzdIMHl4dXhyYUxaUmF2YXdNdGJ4RmRnQktzYkNTc2VB?=
 =?utf-8?B?ckpJdCt5VU5HYTM5ZTdLQ1RIa0lBeEYrdVJqS3JVUXFsR3BCQ3hjNHdrbjRX?=
 =?utf-8?B?NS84L1ZGREc2SmV2eDRYZURXbmR4Z3o2UkVnNU5qQmVzS0g3QVFUS0FlcHhI?=
 =?utf-8?B?K0RHNFNjT1pSamlKVjRvSWJvc1cybFY2aXZLc0Jhb0duaWQ4Tms4Sy8zQi9s?=
 =?utf-8?B?bVZFazNTblBYZFlTNGc2VmpLL0toMGozcGxCVFJXTEl0dnlyazJ0U28vSEFC?=
 =?utf-8?B?VFNMYm1XcGE1ZkVwMHlXNmw4Q1RyUmJEM2ZoNnlHVzBJOStPTGppUGhheFk5?=
 =?utf-8?Q?ZSzffu3FxMViU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW0vUDhFOWc2SkJ4WmdjRG5rTktldGxCS3lveWt2YkJYMndzRk40ZHFuaWVi?=
 =?utf-8?B?c3I2TytNTWUwU2JUNCtXamh4OXc5RGVKbCtENFhNN3ZIOFVubTFkNjNacWNM?=
 =?utf-8?B?THVIQ3ppWk4veDFWMHByRU5qQTdGWUxtVmNlZ3JNWmtkMFhiS1RYV1l2M1hn?=
 =?utf-8?B?VWZoSmxDVU0vOExtSkNySXRpNzk5YkVpaVFBeFZWMFpWOGl3MXZCa3pDZktF?=
 =?utf-8?B?dzlkVE9xRU5SajdtN3plM3BKTGR4QUdkUDF5NUgyeXBGTUMyOXdBVDRqUzU1?=
 =?utf-8?B?bUJPMG5DQ3FZYVV1ZkJYN21IbUVhY3pVK0crUk41cXh0b242Q3Z2bXZONEpY?=
 =?utf-8?B?VnJQSmQyT3BwZHNVMElDbzVFaXM4MkcrOHQ1MkRlM2FBOUxmeUFHL25hc2tK?=
 =?utf-8?B?VVdodUFYaWkwZm90ai81OFF1R0NubExiRUMxY203dHpNUjFaV0ZFZjh1SXhv?=
 =?utf-8?B?RE9oNTBWeDJaN1lFTkZaMnB2YVk0amdjeXpvRFNRa0FiU2FBWVZBaXc5blVO?=
 =?utf-8?B?MnhmTldZNkNXM2k5QXhUWGo4R3ZqeFB1eUR5TW1KcnllYTdpcGYvM29sM2ha?=
 =?utf-8?B?ZkxRU1Bxa1hsakVpRTE1Ly9uSlRKbzA0cTU5YlQ4NjdKNlJ3cjlqbTJhSUJY?=
 =?utf-8?B?ZnRqdFJGbW9jeXVCQ2lWQUgySzQzMzFVeEU0RGptYjdScWwrL1RzVEY2eUhQ?=
 =?utf-8?B?Z2RjNmNBczd5RE9kWjNyYkJNanBqcnBBTXZNdEl1RjNVUWdZZHB5MndLR0V3?=
 =?utf-8?B?VW90bmFlMTFNS2VUSXVZWTd5RjAySDR3SVpkZmJFL3oyL2Fxa2VMT2lSMzFR?=
 =?utf-8?B?ZHFkdWxuTDNZYzhtU01MMmdaYkZrMWNrQitLMG11ZlBlcEhoeFZWcDJpRmhC?=
 =?utf-8?B?dVgxMURET1p1LzZTYk5ZV1gyTWJHczVUOCthaW5YK080bHV2aHdlQ2RVVTF2?=
 =?utf-8?B?UXpINFJwTVQ0UzVGbkJaY0NzMXExWndodDlnMlJ5bE1NSHNXTzdZWWw3Y255?=
 =?utf-8?B?dWFKUmprRGZIK0M3L0E0bS9yU2xtQ0YvblNLbGlGd0p5T0VRK1RlcWI5bkpr?=
 =?utf-8?B?ZDBYUHczVlJKYzM5dlM1dm9EVlVrRnlDZ3B1a09iY3dlVEMxL3NocTlGUXRE?=
 =?utf-8?B?cXlkVlZIQnRnUEpDbGVUZUxCcytua3NJQzVrNzE4RGFQQ1lOaXdIYkx4WDBR?=
 =?utf-8?B?S3JuanhLaWw2Y1JLcEVQNVNxb0dsN092QWhYUXU0cnhWdEFpd2dtc2tHZ25I?=
 =?utf-8?B?TWhCWEh2c3RwelEyanoxdjFtMStIV1dkT1o2cGlKVERWQXhmenlvRSsydDhz?=
 =?utf-8?B?T1FaMEY2MGFvL0ttcjRIWHlXSEY1dGVOUE1QSzBDaGE5dzlJRjRNZ1ZQM1Mw?=
 =?utf-8?B?bGEyUTh0ZEJGNlJyYWtWdkhLVmdEelBoNGpaNGJEaHg0L2hXRkxUS1E2Wkdt?=
 =?utf-8?B?NDdHRHBBZjNpOWI4Qkh1eFlxZXN1U29GRnB3enhMUlVtV1JQeUc4cnZjazdO?=
 =?utf-8?B?ejhsNVlGTCtKK3NrZXErNjY4T1U5V2tBUG1mQ2NFUnMvRTJocmRYaTBoV3pH?=
 =?utf-8?B?YkxPd2dOY1F6NVQvdmF6cmhUYjBBeUNjNmZseE5wV2dDUGMxZmZBa3NSM1JC?=
 =?utf-8?B?TVp2VmVpRGFDY3ppNWExQmJYdzBhb0M3WStiZ1pnanFIOGZleUZ6YTVCRHRD?=
 =?utf-8?B?UU5oWGozOXpwUnhTeEMybGY0a1Y2OXErK0tRVFRCNzlTQ2todXIvS0RGNU5S?=
 =?utf-8?B?WTIvc1NsdjRPVjJuYlpVV3hzZU15V0xKNWRIR1AycTY3ZHoxRG9ZK2FtSnJt?=
 =?utf-8?B?Wk1yR0Z6OG9DalcrOC9DQ3ZKb0tScWMrK0lQc3JUbXpqd09OQkpFbDZUVG5Z?=
 =?utf-8?B?NzV1RVhNdnhOTC9UNnBpSmVMUFErekhYQjJsMnhZVEJGLzg1UGJGN2l3NDZC?=
 =?utf-8?B?aDNtWFZYRkVxNERvaG9uRDRwekgzOHQzYXpXbkM2K2VaL2VPSmM0T3hSS2pi?=
 =?utf-8?B?SURaNWo1WWRNQUI4WmtJWE1pUE9ZbE5ZcEdoNitqVTgxNHNTdnpaUVhZRlJw?=
 =?utf-8?B?OTFTU3V1Z1FwRjVJZTdyT1J0L3Y1ZUdEdlNzWnJweEdnaFN4cGtjaVFIUGNt?=
 =?utf-8?Q?KJkPwgMYvj3DfqBMGmMQfOdZn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be80ec31-3b5e-4cf1-2d38-08dd20bfb07a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 06:29:43.1415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWW59cENWB3ZUv3j8x7ssl6O/XtvO0XxrZ4EwKoNXfgIlG4uWbhgjZKhUJ/ZQNNF8pmQ15CmJ8ch2wTknL/enw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8586
X-OriginatorOrg: intel.com

On 2024/12/20 11:31, Baolu Lu wrote:
> On 12/19/24 21:27, Yi Liu wrote:
>> The iommu_attach_handle is now only passed when attaching iopf-capable
>> domain, while it is not convenient for the iommu core to track the
>> attached domain of pasids. To address it, the iommu_attach_handle will
>> be passed to iommu core for non-fault-able domain as well. Hence the
>> iommufd_handle related helpers are no longer fault specific, it makes
>> more sense to move it out of fault.c.
>>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommufd/device.c          | 62 +++++++++++++++++++++++++
>>   drivers/iommu/iommufd/fault.c           | 56 +---------------------
>>   drivers/iommu/iommufd/iommufd_private.h |  8 ++++
>>   3 files changed, 72 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> index dfd0898fb6c1..0e1baf84e887 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -293,6 +293,68 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
>> +/**
>> + * iommufd_device_get_attach_handle - Return the attach handle for the RID
>> + *
>> + * @idev: The device to get attach_handle
>> + *
>> + * Currently there is no locking to synchronize threads that access the
>> + * returned handle with those attaching or replacing the domain which might
>> + * change the handle. It's caller's duty to guarantee no use-after-free.
> 
> It's better to make "It's caller's duty to guarantee no use-after-free"
> more specific. Something like, the caller is responsible for ensuring
> that the returned pointer is not used after the domain is removed from
> the device's RID.

ok.

>> + *
>> + * Return valid attach_handle if there is, otherwise NULL.
>> + */
>> +struct iommufd_attach_handle *
>> +iommufd_device_get_attach_handle(struct iommufd_device *idev)
>> +{
>> +    struct iommu_attach_handle *handle;
>> +
>> +    handle = iommu_attach_handle_get(idev->igroup->group, 
>> IOMMU_NO_PASID, 0);
>> +    if (IS_ERR(handle))
>> +        return NULL;
>> +
>> +    return to_iommufd_handle(handle);
>> +}
>> +
>> +int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
>> +                  struct iommufd_device *idev)
>> +{
>> +    struct iommufd_attach_handle *handle;
>> +    int ret;
>> +
>> +    handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +    if (!handle)
>> +        return -ENOMEM;
>> +
>> +    handle->idev = idev;
>> +    ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
>> +                    &handle->handle);
>> +    if (ret)
>> +        kfree(handle);
>> +
>> +    return ret;
>> +}
>> +
>> +int iommufd_dev_replace_handle(struct iommufd_device *idev,
>> +                   struct iommufd_hw_pagetable *hwpt,
>> +                   struct iommufd_hw_pagetable *old)
>> +{
>> +    struct iommufd_attach_handle *handle;
>> +    int ret;
>> +
>> +    handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +    if (!handle)
>> +        return -ENOMEM;
>> +
>> +    handle->idev = idev;
>> +    ret = iommu_replace_group_handle(idev->igroup->group,
>> +                     hwpt->domain, &handle->handle);
>> +    if (ret)
>> +        kfree(handle);
>> +
>> +    return ret;
>> +}
> 
> Where will the old handle be freed? It seems unreasonable to allocate
> the handle in these helper functions, only to have it freed by callers
> in other files.

yes, it's in the caller side. See the below snippet in patch 02. Maybe
it's an over work to split this patch with patch 04. Merging them may
be helpful. Nic has a proposed patch as well for such purpose.

@@ -196,13 +187,24 @@ int iommufd_fault_domain_replace_dev(struct 
iommufd_device *idev,
  			return ret;
  	}

-	ret = __fault_domain_replace_dev(idev, hwpt, old);
+	curr = iommufd_device_get_attach_handle(idev);
+
+	if (hwpt->fault)
+		ret = __fault_domain_replace_dev(idev, hwpt, old);
+	else
+		ret = iommu_replace_group_handle(idev->igroup->group,
+						 hwpt->domain, NULL);
  	if (ret) {
  		if (iopf_on)
  			iommufd_fault_iopf_disable(idev);
  		return ret;
  	}

+	if (curr) {
+		iommufd_auto_response_faults(old, curr);
+		kfree(curr);
+	}
+


-- 
Regards,
Yi Liu
