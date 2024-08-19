Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57A16B74B
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070308; cv=fail; b=ff9ynM168WF2vi+ki7sLPbiL+ZtLv191/QOWdWsU01/j9WuObeTNsdNsptVrca/Sq73Cmk2yq39elyfuXlWg4A+ddcu1Ucx7kKCXyvI40WqV9K8bHkW07FV4C6esCTI4EzvEa5CPn2s+Mb7Xb2YbF+xH3iJcR+jkivv8cm5CKgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070308; c=relaxed/simple;
	bh=8OBvViEfXMKBHY8KQoIzmcNyDBPGPLjrAYrEGX7MAss=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nDKUoUiWN95reez58LdRKYhdjMqK8pHI00WfqqbZoSgKd025AcAgvB7TSSbFmIFRjDCOIFNMA4mOFgejsmFZBn47l+BNZ5vrzGQkLfGZTdXa0sP5O7Ae5Z5+gcRiWpBFFu7C6Pcw6ikWobJ2eBEkLbNreiQ2+sJYOyzjQ3ol1wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDYgeKHN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDYgeKHN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724070306; x=1755606306;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8OBvViEfXMKBHY8KQoIzmcNyDBPGPLjrAYrEGX7MAss=;
  b=ZDYgeKHNrbHeDiYQo4nzZlph5Gk9MocK0mI0EX+Ir+yKJkYCimZlAmIa
   4ziB8xkuawmHJCRdCXXJEmY4Bk4TOaGh46MVKRcF+nefs6IVINqM3w+/E
   QLYuRrlwlQjgOSarcMZSpWia/aBLFoL8jMDY3ZAsbhLzl+pxImUh4djk+
   SdywPQ9ErGv8cnMvMl61YRZTwpfwOTZLz2eSkIKnn4AenRqTUrstCxtyC
   TLWHAi+qrAfmvS3bF4IyNSZsVcJrP9lPzeIpMcQfMy0iht3ZvIzQQSj11
   tmVYY15bvXRVMHgvf9jM1LX4GPSiIs5Pjbyw669JZ+Dp7hihZ+ucqZUSN
   Q==;
X-CSE-ConnectionGUID: FuwlEpbeQ2GC2NXIMrX3fQ==
X-CSE-MsgGUID: qER2B1ehQlWGMN2KZ2ha5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="44835625"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="44835625"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:25:06 -0700
X-CSE-ConnectionGUID: LUDeH4laSsqnCqHQS8MHHg==
X-CSE-MsgGUID: BIfEUHkpQtyyurycnDn7bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="83574422"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 05:25:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 05:25:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 05:25:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 05:25:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 05:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqejjTaj4uNnXlMXN1xU6JKf1G1ZVTOouijvFdhtI7VKCQK+TrbhAo8/UlsB6xbAPNaigp6bNKFB4yySAgaemr4nIrs1uMEwRTuk1zUwBzoT1Mln0TdnESowzRD3dzz/AfPLwA1BIMSPkF4ojy/peT70RFJvcYSANXPtCwh9xLm+Zs/k6QOINjy5ujcN3GmIGTFPxoU7Xih9lx93E514yMLrLsANyrF098Cv0o/fcZwubZNgy1eYT+hrpib8QRWXIW1qm/PNMyA2otZmIq3HTkx+JlMlFMEBBIsMa1fJBxbq0GzIl7j6h38Np0EIJyvb/t3ODB5geTj36mCowTFShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zDvE58n8rvUUssDKhzsOT1VAM8nASCbaU4PYx2ubpg=;
 b=KGdxl+lDp0qH3//JqEg2Gk2puxFzQH0PJuPDkBEd+CiamX7v5aeiUr/Xutvv2/hGv2xuZ6H6DAmR597+rP1TjrHGR6AxomwWnHxo6d/Gbbps54yYTyi1h4/n5xJnHv27B+RMyFIk0VAV3/UhVrG4NgyN14A0Hd0waXbVPA4dsNXuSTnjhV+UXIW7DpozYEgpHZ3rGfCf9OCKvFtCY2TTnz//xv6R4s+UAidBNQGBcr333R99kaNlCqRcZMqatFgxvsCX5NIStWcoJ6lu429Jpf2UFsoUxdBpqnlEmlA84qjbr+6ZxKfgYJn0r1BS+8X0OMSYTXDJE/4txGxOrYsWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV8PR11MB8770.namprd11.prod.outlook.com (2603:10b6:408:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:25:01 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:25:01 +0000
Message-ID: <53869e06-879f-4a77-ae4d-c91a23b8d6d3@intel.com>
Date: Mon, 19 Aug 2024 20:29:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/8] iommufd/selftest: Make dirty_ops static
To: Jinjie Ruan <ruanjinjie@huawei.com>, <jgg@ziepe.ca>,
	<kevin.tian@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240819120007.3884868-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240819120007.3884868-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV8PR11MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ee93dc-970b-4e40-2265-08dcc049f244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnhUK1BaUGtnRU1yYmo4Vi85UDQ2QWhLMHRtZjNpamN1MmRuTm9Qc21DMjRh?=
 =?utf-8?B?UVlOa2krREs4QnV3ek1LdE16SDJtdld1NnhrM2pFTHIrREJBVXI4amxHdkxB?=
 =?utf-8?B?K255QXg4UmNzNXZpWVY4akRGR3dyTklqOVhYZHF5d3RwcHE0UjMrd2c5aHZR?=
 =?utf-8?B?MG1UWDhiL3RaSDNqd1FzRURsQzFKRmxUclc2K2NsQWoyaE1qVTlPTVlGQlBT?=
 =?utf-8?B?OTl6dUt2VzhDMTduWGdRKzJmanBwNExDOEExYVd4OEFWMmJwT2pMT1BsZGFy?=
 =?utf-8?B?aTRBUFNleXFYdU1sRWl5SE43QWJXWmhDYTNZSENURW1kaFliK24wRXVwa2lp?=
 =?utf-8?B?algwZkJZR0pJaDFXcm9ZQXBrelVpT3dZcXVIZmlTbHZkWk5HSktZRGJ6UEhH?=
 =?utf-8?B?UCtsRWdhNWNyY09JTXpINkpwendCU2w4aWtrcHhBeEx6K3ovWEVTMjRzYStl?=
 =?utf-8?B?UkFsVjZjMjVDZ1NhTFYrMk1laTJyRHpvdUo2YVlLR2N2eXBseEVoN0R6NGl1?=
 =?utf-8?B?Z3NxZk9MK2VEbDhCamxXNVIrM2RoY0RrRU8zOWlBNWMwT25zK3lBbUxHSGh4?=
 =?utf-8?B?UjZ5M0l2bmtSMlhGRDdDaEpicXhzd241b2pvcXlTZ0psQTZnMlNLRXJYTlpw?=
 =?utf-8?B?bFFCdlhLMWFacWdrVmxQK1FxU3hVZVMyVE52SnBvazhqb3F6TEUzKzBaTmtL?=
 =?utf-8?B?WHA4ZnA2MWp1Y054MnhGcXBoTEkrZitMQnV1TnRLSkRGNEpDL29uTWg3OWcy?=
 =?utf-8?B?a0ZLL1V2bXBSdktLcE92SEhkMHJQZ1g5SU9WZ0oyZ2M4akJXNkZzUVRLaHhY?=
 =?utf-8?B?UEtBVHgrcEtwYTYrejJtWWZhUThaNTFkT3A2REVQc3d1MFhIZ2I4YWJvcDNv?=
 =?utf-8?B?SnVGWkE5aEtmYVNlY01weTRSNEpKeDJxTmJMRHFPNWV4V255c3JEdUEzaFNt?=
 =?utf-8?B?OU9WMjRpM1g5WVE3am5adjlXV2Y0RU1jdmRyVmJwdmJkcjhTbldMbG5BRzk2?=
 =?utf-8?B?a2M3MTBHMldLbzZFOW0zSURnQXZxNUtqVVpzOWtOcmZlODVWaWNOTE9JYzdN?=
 =?utf-8?B?UTNUeDdkRjVISjlrbDk4SkxiUUErWERuT0dWd04vQjlwUmh3VFQycFhGby80?=
 =?utf-8?B?R0dhNjhmLzZESjFHYmdlNjNtcHpQcWFBbVlTRmQxaEJ4cnc2dkFqY2lEVVJl?=
 =?utf-8?B?aWorZFlWd3JaZDhFK2dINFNxWmlsbFpmbGw3SGpobWpIWnBldmZFZEZTS3hZ?=
 =?utf-8?B?bTdQUWVGQ0U4VzhKNGhXR2U3UVA0RTlWMmhlUXJtQ3RBMUR6WXpwek0yRjhu?=
 =?utf-8?B?VHI1RFhrNi9YWXJCT0JuWkdCLzlLKzlZYkNTRUovUndXbU5ydklvRm1UaWp2?=
 =?utf-8?B?S3N3a0N3azFtcEJvdEFDMVdEcGROT1RvRXE3T212QlZHbmVEOUIwSUJHOHdN?=
 =?utf-8?B?TnZaaUN3NE5hUk44ZXJSNGpWOWs4SjgraitvWUcyOS9qRzdydTRuOWg0SFZx?=
 =?utf-8?B?QUM2emVua0pMZHRXendPWWlieGVlM01VR0dERWt4aDJIdzRRK2RsTnE1VSsy?=
 =?utf-8?B?RldxeE45ODZFRTZqcmVQZGhpSVFlSUJ3SzNKbzdYOHYveGRIVjhnVTBLRE8r?=
 =?utf-8?B?elJSNHQ1UGlVazNFZlkzd08ycUlZZkJpK2tvUERuU2Y4VTd4allJZFVZdXBI?=
 =?utf-8?B?UVh4aVRKTi9PcjFSMkJjTXhnV0p0ODVjOUVpK3ZVSGIzMzVLNTVIbng1RTlw?=
 =?utf-8?B?YTNXUDdzRnlxdjhlK3ZiaVoyQnZTcjZsNDZ4REEzc1Q1dTFhOWxOcUdVbm1R?=
 =?utf-8?B?ZTJOejRqaDBYcUlreGR6QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1lWlF0NUMwR0hiVWx5RmQwQW9lZjRjclByaXNlSkcvNjlDTC9SUW5nNk1i?=
 =?utf-8?B?L3doMURob2tiRlkvM3pPbXJyZndqQ09kY00wbmVUQWlGN1QwbGJpZlBoNkxm?=
 =?utf-8?B?UFRyOGdBSDFhcXpkVVJIbGVVeXNzUERGZHBCQ05tYmIwc3lrRFcxM1hoWFpZ?=
 =?utf-8?B?VEN1aysxakV6Tm1kSnpjZGUydTNqM3o5bnhPQjFzZWRHZXNZd3NqcXBsMUgz?=
 =?utf-8?B?Uk5hRjBKd3lNSTJqYVkyem5zM3YvYnUxbEZoT2gyMUZvYjFrenQyTE9hUDlk?=
 =?utf-8?B?TmxvL2xIV2VOTkZnMitrWm1QWlVyOXhhYzlFS1dWVmZWd29HbGMreEsvaWVy?=
 =?utf-8?B?dGMyeTB4M3hWTTBvRzZ2RVVCdlJVZEdOTVE4bzI5b09ZRzBvMWtVZVl3S2hD?=
 =?utf-8?B?QkVHWS94QXBwNVJ5d1V5S1FXRGtXdEplS3RCM2ZmenJlUDdZa2tkd0NpSllp?=
 =?utf-8?B?ZGRpQi9WRjFXaFdsemFCaFdYRmZsSDBRYnVERGF3NU5UczZzZjJoL01zR0d6?=
 =?utf-8?B?TjcyOER4azU2U2FwS2REYzA1R3d3aVRodGlBR1cyenExUnkyM21UQWlFaWl4?=
 =?utf-8?B?MXhXVmhOQUxjMHZBcVdVS1hOZFpPL2F6MXo0MXlwcjlEYUk2VndmU2NKR1Rs?=
 =?utf-8?B?VTE4U2FYUStmYjUvR3ZKUHc2dzNrbWlveUdhT2pVZWsreE4rMjZJQmNGazBw?=
 =?utf-8?B?VWNCejBUY0tQRFlVS1NMSzYvdm0vVyttcDN6Qy9pajAzQlBHZFZFMFVSWmh6?=
 =?utf-8?B?RXplSHpXSVBJRXBuVFBUVGhtMEZaRG1WNkdvYlJtb3FwT0wwNjIxb2lnWXYw?=
 =?utf-8?B?Um1WdzVDR3crUlVGdWhEV0VkRGJNaXUyRm1nYVFEa2FqQjFVWHJEMVhnQWJa?=
 =?utf-8?B?dlpKRGpZMG1GMkdYS0thbm5PR0NkY2pZS1RkdkpMbHdJZWd6eVJBdG9lRitp?=
 =?utf-8?B?ZEsvazVBWGo2NEFMN0ZMT2dZcEVUUk5CU1lQcGI3Q2JmdGc1cjNZeG1pcHdv?=
 =?utf-8?B?K01raWpacHZMS2wzNzZwWWV6OEhZYnA0c1FtSXJuaXNRY3E0OFVnajNaTUNz?=
 =?utf-8?B?M2xDdmR2MEJ2d1NVVmVQeW53YlNuUTdhTm8xdk85S2ticjJBSjZ2Uk9USm51?=
 =?utf-8?B?c0hyN2hQYnNDOGNxVGE1aXhkY3R5NDRzM2xOUFcyQ0pCa1JHRXN6R0ZheDRs?=
 =?utf-8?B?QXJOTjJETHZLZjdVOENoMTU4SzVDZjNXcmVyUi9IMkp3S1pLelVMNnVTNkt6?=
 =?utf-8?B?MFhVUlB0UW96ZytXbWxsQkhXN0pHSTA5ZlFMRUxhU1VNNTFtQVlQRW40R3Jj?=
 =?utf-8?B?VGR1VXdkMTJKU0pvekRLNjlIRjdiVGt4OTgxeWhkS25xZm1ZSkFTeXZhS2Mw?=
 =?utf-8?B?Slo5QXUzVm1xWTVOakVVOUR6U0RKRFZKNTlwSUJNQU5GTnBnZFBtb2YyZnNx?=
 =?utf-8?B?YjhUVTZqTEIwRlF0WVpZZHNvSW80RWEyUXFNWTFTeldyZ1lCZE5ZVFAxZ01p?=
 =?utf-8?B?cHkzN2o5SmpqQk1wVWRreHNvYVNHbjNPZ2ZaR1JSYi9YOWxPUjdNVjJScE8v?=
 =?utf-8?B?NU9tUUdUekNhRHNGRW9odU92Mm9VT3d2bGFZbEVYd0g4WWZ1NzZndGJWTUV4?=
 =?utf-8?B?SVl4ejdUTUtsakx1ZnBWSDNXZ0JhSm9ScnBpckhRNTZtN3h3dFpWZmhOMFo5?=
 =?utf-8?B?S3Mvc2gvSmFYT0hEZllZTzFoMXIxMHdkZXhPMjJRcmk5YXBFR2hJalZHempi?=
 =?utf-8?B?a1E3L210Vk5nT3ErYXpCWlRObHhwaklLWkFHU2NZalZPbkVWTnE3V1NyaTNl?=
 =?utf-8?B?ZW1PN3dZM1FlNDlLSklQb3ZML1laTGdlUmdiSG9iS0JrQ1hZUlpJV2wwZWlM?=
 =?utf-8?B?Qm5meDYvMGlaY1RaaG5heEJaNWRGSFlPVVI0YVFVcERtZjFkK1k5eW5SR2h0?=
 =?utf-8?B?b1ZEUVJnWXhucDZNYjA2ZVo0QnZCOUdMTlB0UDlVNk1DWDBvM3AzMXc5MlE0?=
 =?utf-8?B?OUk3a09BRURnTXpmKy8rZldSY3UrdlU4VytmWERVQm5IKzNYM2ZwZjVOUEdT?=
 =?utf-8?B?c1ZLUGcvWHJVVnVVUkFRSlljRk1SWnhhRDVvekJkTU1MSVM3WE9yNXVUTmZ3?=
 =?utf-8?Q?kk3+X5BTo1XY7dCFcD1hgi2MM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ee93dc-970b-4e40-2265-08dcc049f244
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 12:25:01.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3GT3M4UUmAdAh3hnepwjM6ETsM4VIwgh7GPWlOlZm0snMvH21rkSCp3IFdS3b+uiLHvi0LXpsweiRH5dvKHcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8770
X-OriginatorOrg: intel.com

On 2024/8/19 20:00, Jinjie Ruan wrote:
> The sparse tool complains as follows:
> 
> drivers/iommu/iommufd/selftest.c:277:30: warning:
> 	symbol 'dirty_ops' was not declared. Should it be static?
> 
> This symbol is not used outside of selftest.c, so marks it static.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/iommu/iommufd/selftest.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 04293b20e20c..7464c24764cd 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -274,7 +274,7 @@ static int mock_domain_read_and_clear_dirty(struct iommu_domain *domain,
>   	return 0;
>   }
>   
> -const struct iommu_dirty_ops dirty_ops = {
> +static const struct iommu_dirty_ops dirty_ops = {
>   	.set_dirty_tracking = mock_domain_set_dirty_tracking,
>   	.read_and_clear_dirty = mock_domain_read_and_clear_dirty,
>   };

-- 
Regards,
Yi Liu
