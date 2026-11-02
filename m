Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793589706;
	b=4B0phnW9eoYW2fXokzOzLB8R3ULr8N4lLFZJbcnpFJhNywCS31+4ExXXx8VutzctokXc
	 ZOMNSPWVpGT+2rZhbs6nwfBJGAyhpkmO13PRxdGfF+U+wDwOeExJ4Cm79pXoHWnR7Rk3l
	 Ffd4P31vBlzfSFMFw1lP1aNi277TlhMxIicrvL5UxFCgCYob0TorYH0OSpDdpxh2IRstR
	 K2CJWuyd/Iq9/wWCDqb4Qz9+cQnwLnEF/NLmwhMHa6BPTROxMVv93X44gk6GkMw2o6CWl
	 aE+eJpWUP2TjxjKu2ldgsxBxz1P0sy6fdC9qJD3hAueiQg05c+Y+m87aHJ8KsIimy8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589706;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=36w+TyvDK7zrreFZ2/qdlIlCs0cxVVPBxr+ATq6B5c0=;
	b=UgZ/eqRQezwzvot9ywMY0u7xJBGStl7+FzXLKShkhV7zEyzeWymadwiqQlpnGenP9FTV
	 hsbo40w68v0kR2nFQ5oAlXfQ1w5WFolh3zzvY+amaolCcAYBoGnyxEgPqfhWFMyim4M+M
	 MmQ67xCnOwl7fege3MtYETxSbQJeuNKtCMGW3/MEUaPoSaN6itLGU3n+OcbqRkbIvPaQE
	 EMVQzVoO78wl31NxFC+zdqQTeQ7dofqVAgN0CbqNK7ERxeDm9rXjhrxaHYVEQd9vI8Lkr
	 hjOhhTDwrK/RsEZQluQZ3v0bIfCMmgEoHd9wM0X3KmBOJB2/iNX9XyvAmkOy8zovk+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HuTWvpnl;
	arc=fail smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B507606A326
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 03:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B507606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HuTWvpnl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793589704; x=1825125704;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=378I7ZnhQyJ4UGroGJ68fV6eplCjWqI2FaRRnDkCZdc=;
  b=HuTWvpnlDZnUYICw59vTJfoPlmegip+ZZhFx8GCHcWj/zitIaSoAKGpX
   XyG6Azx/DwYHc0Csy9MATt1Joq2YH18tdDVeSAjCsn9FAd0uDgtVCtxF9
   jEyhUr2FXs30p6hVurAnetm0yhKcyRETa29htdkJBFp6kpabdkLRrv9Hd
   /UC2xulIvE6Kz3F//K9peEozY7ySs7O29n0Sh48cBdMrdBN7lMQbv3trp
   pvljT+uf4ViOjl0LfpsUPNZu5V+HpXn1YTOZDfhne/YWJ5vX1e9YGxZi+
   tuaMAABQVSNTMjq2y5rsBIhMECcRgxYJ7r1MG0cg1uFh24OsrK22zh/nJ
   A==;
X-CSE-ConnectionGUID: gH3DC6JjTuyWweV2V3RVxg==
X-CSE-MsgGUID: c04y/agYSrmRmsknawMQ3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2284684"
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="2284684"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 19:21:43 -0800
X-CSE-ConnectionGUID: F4XZCK5FSwetwWM0RGDrFw==
X-CSE-MsgGUID: aGyfomOlT8OkhN7Kyw515w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="6012406"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 19:21:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 19:21:42 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 1 Nov 2026 19:21:42 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 19:21:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G28pjzosD19dQTViej445X8lF8HCy8L7uNSoIIc/xD0jSzTS8qozdis/GzRGCkZNtdt64HJ41ylubH8QreITNDBJHSieZp/oASDTKcPjO0EAZyiMfMAzAjCXjyIA+wMvkQmO3CwcwK7alAhMwub6iydu8It055Y/3n0xqbrS7js1/BFuzBNcqYpY+8r/SOjdQD3Dp0k299jg7nQ5+ugzi1BHFPhCKjEDiI4cVn8J7XKBZxE57tHTufB6+B3/bk3LqimV1BWamDgtvsRgt8uz1iOQ+wlUepz40aaXN2Tu+gcsMbaVv9HBgyJ9mY1r2w0mxlAx+SbkG78vkaeH37QoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36w+TyvDK7zrreFZ2/qdlIlCs0cxVVPBxr+ATq6B5c0=;
 b=r8q30kBOn/yErXovBYCwCqG1BwPgj7Jp8D538lHrLR6xp8S224KsAUdWPTYoxlpiZVn9xXfzVqgoLtDNwGWFMCBVX4N+KVGSqzlacpOaoCM7HWn3AqPS0a6cphEheg5gVWG4YR0Dy56uJ4nIvJZBSrzNheocU8RFIQH2UuVB0Y8oet0V/uRWQgC19/q1Jq4OAHyDsrdfPSqJNpVW11VVTiKOPHaAo1/eF4vhFXgVu1gGg2IH19Faub3OGAX5mDEPI6JKOm+g8Wexd+iADzu4VJniqe8h4hIQ+Kd16FxejVu9VB2ZODcl3SpmUA3UsmJmofarujyWT4QVgcfSmZFtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by SA3PR11MB487683.namprd11.prod.outlook.com (2603:10b6:806:533::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 03:21:41 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 03:21:40 +0000
Message-ID: <5512edd1-3c52-4e8a-a38f-3a5f1457cdaf@intel.com>
Date: Mon, 2 Nov 2026 11:30:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
To: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Jean-Philippe Brucker <jpb@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
 <5751040a-e180-4d29-851d-3ccab96878a3@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <5751040a-e180-4d29-851d-3ccab96878a3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|SA3PR11MB487683:EE_
X-MS-Office365-Filtering-Correlation-Id: 3207525b-42a7-4d70-3da1-08df38906968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|23010399003|1800799024|366016|376014|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: pJPy3osQcVS1gpCNTNdly334eKrKSwNF0BewV1E94bB5QWpByXBVX1OIwGzBS6BvUr3ohMlJhV+fzJJIy4zrXqscbPEfkgIn5jNx/uTz1p4/96+13+YtvehwJnPJSP0Nkx/h8NZwPvfrCt4fEvsJRsy6YGukEw5NRSLDyL6mgpcPuyRBFUEYao4RU+x1sRinpFs1rMJJB2zeVnnvkZoZAPmtEeN/Y8+ZpUeV7y/8XXachRtlTEoAr24Su2RdTVfcHnx+OU0lqNDBl2AvPuEtoprws06cOfZN/QaYgWL+WJK5OmOP4ci81rvPJ5x6Yt6b//NYW9SMPMmi1bARCvRS7K6km/BHZdA/JIZYC4N23HZ1UaCTCW11fs7YDBmlTJ/tJa93MknMPmHV0Xud59vQ2ZJiAHWAUtw0uL8++Xsm5GqsQbWDaEQHQnsinm6V02NdwMtEu1JCbjyxJ4zgSgtQodsg8ngEeBjvVxyABRFjLqZW12hQjHyOflhVoLqjqa/U2eWJaUx0UCOIuT6clX1SNemNiKCujMgzDk1aLpGvbp1/5QU9n5jFmKe+uJ9/bbuKzPnY+VtsErofMXeSb6fwNC32ckpRJfK4sY/7Qwml0bpsPacw6glK182dDk+QqNrzJAPs70GJdq19tUCVLBPrxmmfXZ4/AJSCAM8cSrgREMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(23010399003)(1800799024)(366016)(376014)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NwVlpPa01jaWJWRlVMb0krWENNWC9HMjc3Rk1NWDd1MGpNN25NVkVGTk8x?=
 =?utf-8?B?ODZHbExya1ZTd2hHUWhRYnliV2tHRXVUbE56dWExd1NFOTJRTjV4cG9lSG9M?=
 =?utf-8?B?cXFTaXlCTlpFcE9EUHVZZWJNUUJsTUZubE1kTVhFdm93a1JaNURocnlhOXpk?=
 =?utf-8?B?MENrTzVMWTQ3bndsbks5N2ZNSWNRQlZCT0JGRWpGVTRqVnhqWGFObmcycUVG?=
 =?utf-8?B?aXh2S0tpN3NSbERQOFk3M21vSkV6UXlqMndQbW1pWktvNE52a3B2Q0xjMm9K?=
 =?utf-8?B?Nm5YaGEweGlMdHFKL1Y5TUNocGY0aGNLZituSlFFTGZ5ZTlUTFh4bzMrajlD?=
 =?utf-8?B?c1dUUUxmRXZNN1pGVUpsYjFhNkNKN0c3bXVKcFl5Rkt0RFluVGtGZktNZnJC?=
 =?utf-8?B?eXZWMDBweTduQmZRRW5hd3ZwelJPUTVHZXRvY0VRaUUvMnJCb2lwVXNJaFUw?=
 =?utf-8?B?MG9pVHg3eXVPb2FRWGl1MWpUL3Bud29RWkxZMEJaVlBHUFN5V3QxaGdaTUxZ?=
 =?utf-8?B?R3M0K2NnV0VFcXZoOEJiOG1icHc2Vk9UK3RWRHNzMEE4Tk03emxOUU5BbkhO?=
 =?utf-8?B?aVlCbzlmN1VtWGRiUTRrTEN1d245OUhWbkRTZFZRcmhDOG1sSTMvS0I1M3Ix?=
 =?utf-8?B?N25TRk1qVFh1allFeXNzMFNYNEFBL29PenNrMXoxRldncy9qbnJqSVZqUUR5?=
 =?utf-8?B?VmlVdUNDaXEyaFZzdm9uNXM4OTZOVkNiamxDZG9qRXl5S0p2c3ZKdUNidFdk?=
 =?utf-8?B?cXZBRmNHakFkNlgwRUwyOFZPV3d5MllxcC9rSVd1TFB2RWQ2WnNWTE53Z05V?=
 =?utf-8?B?b0ExUVhuR2RaU3BlTDltdkRtNVIxU0xtRVd3UkdmOUMvREZjTThjcTlhT0hM?=
 =?utf-8?B?V2hmMWdHTm9nK2VhTzRqeU9TV2M5M25DSjBwZGUwTXZxSGNxVVdYdVJXb1J4?=
 =?utf-8?B?KzAybWNqYUFjYzYwWUtSY0lHRlRZWWp2RkxUUHdSNkxDVkFPR283MU1NbHhT?=
 =?utf-8?B?MnAwK2FETFhwNlBsR1NHdVBKVTZodG9xTjliWWRYM3N5VTVtRjdwUVpLNHNC?=
 =?utf-8?B?WS9UdzFaN1h2SnRpMWRmOSt3Sm1Hb1c5N0ZLUkZGb1hOcnUySVphc1RzN3JW?=
 =?utf-8?B?REtHc3RxVCtLTm9FY1JYYTRsSG5TcUYzZi9kcGFoYlNHRng1ZUU5a0w0RGhl?=
 =?utf-8?B?NSt1OER3dkhWUloranVoSGY0Yk1wRFZlRkdDeXJvUVdWZUJDZldGQlg5M2NG?=
 =?utf-8?B?K3plOC9BZTBSNU5OdHhLSnk5UXh6NmtWVVBoL01qOThZM2pVakpMNmV3OHZC?=
 =?utf-8?B?WVYwZkF3MWE2K3JNVzF2L1dvRkx2a3ExM1JwQ1JBdGRkNVR2bHkycFg4RWMr?=
 =?utf-8?B?K3ExOVpGM3NZVkQ3R3FJRms2dVFMUDN4eW5pdzgrcWxDSzIwUjJxMDZhd01a?=
 =?utf-8?B?MXg5YUIra2k2L0VwSmZDRWZGOTg3VlpWSCt3aXJNL2dHYXVJM0lVd3BjNWlC?=
 =?utf-8?B?T1Jhbkd1eXhPNzFtanE5QnVTRVhRWWhhRFZGQmxNaVVDM0VQOU04WFFodENx?=
 =?utf-8?B?VEp3Smlqd1ArVzhzNGZtdWNVazQ2djNXY0hsSGtzYnk0VGlBTmtZeUQwWU8r?=
 =?utf-8?B?WUVtaGpVYm9vRnJlamgzYXUyMmRFWVg1S1BtUzZ2SlBhcUsvTHIvb29kTzY3?=
 =?utf-8?B?ZlBEZ0V1eVgzeU13c0MydEp0dnZESFRuY05ETXV5ei9wTWIrV3N0Z09yYUlR?=
 =?utf-8?B?aXhpUGNFOTZOUUdpNkU5RVdQZ2dIMlhndlRjTVVndWFmUGpxb0pMWUZnZ1BK?=
 =?utf-8?B?Mmttb250NjVnWkx1U1BYRk0wTXVOZ3FHRTMzODhZS080M3RubTRmTHcrb1dR?=
 =?utf-8?B?OHhvMXZTS2lyZ0hPV0lHRkZWb0hxVFhObVZlVlpjbWJsZXpnNEErV2d2dzVG?=
 =?utf-8?B?YzM3TUhka0VvVlJ5Yi9sc3hpQXhLVklBdU92a1VUSUFyWnBvRXJWMVhVRXFr?=
 =?utf-8?B?dWVzRTJIcVlwMHhEZlVIbkEvTW5aQnBsc29JR0dOaFFvSjVrRFZ5RHc0SVF6?=
 =?utf-8?B?MzhzQkljODdXUFJya013MWQ2ajZjdkVBbjlQSnlsMC9QeXBEZTBWSi9qQlI2?=
 =?utf-8?B?ckh4UDBZcTByTVZLbjVvcG4xUjUyNnFVK0U1bGtOb0orbmpyeDZXNXVObzUx?=
 =?utf-8?B?V3NjRk9GZnAzYi9OL2lQK1ZiQ0ZtRHJJUDIrejEva0pHdWZwMUFCM0dCY24v?=
 =?utf-8?B?KzQ0S1RSZWJZMUdxdGpCQjFjanBTeEJYaXNvU3d3bHRnQlAvZGJxZzZrbWZN?=
 =?utf-8?B?YVozVFU5ZGhCYWtKMU5yN2hHVnp6cGxnZFhjWVRzRzBOWGhpR2lrdz09?=
X-Exchange-RoutingPolicyChecked: Njb/6WiMrw6MSL83Wk85MBNv5HUggyyIDC0Hi7WqhfZMJjCgQVYi50OoaHZJH4XY1D/d324nW8kZ2EHo/P3DQeYOxw99oUyq2fqsACqLezseGQLG9fhO92OtMRqMgANUWdLrUpk1u1197xRR4dXk4DQxcIbbV1tjc82QKJo9v5UcUHGcGr2q5XNNp/WOc2cqHoHJMFCDwR035WaM/1z7UN/Z7udjxsmClEl/B7PKqoaDLT+w1wTb2Jm+LOIm1xyNYdBfAnYUEONdBG0ouXD+3S7Plac0H49zx7An4AmKYNBq2/6LzU2uS1CbaydTRLsWv4DYL9U2n5z9UCZ6VJpXLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3207525b-42a7-4d70-3da1-08df38906968
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 03:21:40.8700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QilPno9n8mM0mZGLE545KONGbPwrBsumSt72/ipuBqB/oiZzL5mRU10ck6UttQnxM9oWv8sE31KH3nHFBJE29A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB487683
X-OriginatorOrg: intel.com

On 11/1/26 13:53, Baolu Lu wrote:
> On 9/30/2026 5:51 AM, Nicolin Chen wrote:
>> iommu_replace_group_handle() looks like it hides the detaching handle 
>> ahead
>> of the driver callback. But in fact, xa_reserve() calls xa_cmpxchg(), 
>> which
>> stores only when the current entry matches @old=NULL. For a replace, 
>> there
>> must be an entry sitting there by definition (i.e. @old cannot be 
>> NULL), so
>> the compare fails, XA_ZERO_ENTRY is never written, and the call decays 
>> into
>> a plain read.
>>
>> Therefore, the old handle stays published during 
>> __iommu_group_set_domain()
>> and only gets replaced after the call. This creates a window, during 
>> which
>> an asynchronous fault path might hit UAF:
>>
>>    core, holding group->mutex          fault path, no group->mutex
>>    ==========================          ===========================
>>
>>    xa_reserve()                    ,-- old handle stays published
>>      no-op, the slot is occupied   |
>>    __iommu_group_set_domain()      |
>>      driver attach/detach ops      |
>>          iopf_queue_flush_dev()    |
>>                                    |   iommu_attach_handle_get()
>>                                    |     reads old_handle
>>    xa_store(new entry)             `-- window closes
>>    mutex_unlock()
>>    kfree(old_handle)  [caller]
>>                                    UAF: old_handle->domain- 
>> >iopf_handler()
>>
>> Replace the xa_reserve() with xa_store(XA_ZERO_ENTRY) to unpublish the 
>> old
>> handle.
>>
>> Fixes: 8519e689834a ("iommu: Extend domain attach group with handle 
>> support")
>> Cc:stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
>> ---
>>   drivers/iommu/iommu.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> This doesn't fix the same-domain replace issue, which can still result
> in a use-after-free bug. I agree that this needs a separate lifetime
> mechanism as stated in the cover letter. But is it possible to prevent
> the same-domain replace case from going through this interface?

fwiw, iommufd already guards this at the device-replace layer
(iommufd_device_do_replace() short-circuits when hwpt == old_hwpt) [1],
so IOMMUFD callers can't currently trigger this. But that's a 
caller-side convention, not something 
iommu_replace_group_handle()/iommu_replace_device_pasid() enforce 
themselves - so it's still
reachable if a future/other caller doesn't do the same check. Worth
deciding whether to push the guard down into the core API, or document
it as a caller contract.

[1] 
https://github.com/torvalds/linux/blob/6628e7d4c6b25c8d18f1345e3a20d21829aae7e4/drivers/iommu/iommufd/device.c#L888

Regards,
Yi Liu

