Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D451F560D
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077835; cv=fail; b=kuezLF/FWQZ8M2oOJkRfv1ytT4g47wP7kLgmXpTVdcgFpBcaGHev+EzMojo44ibS5blU5Vn+btykxWBOk//cxoD1D11UhabXT3u0JEbugSE1INU31qbTnWN3Axnt2QtFQo6x670hS8RauBBTN/P7MaplnmPIqxd7Grq/zdOmimk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077835; c=relaxed/simple;
	bh=BMoYKYyeF2QCN2X59peaHchHPbeIc6re8h+47CHf3EM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n1rDHJ4KDezhuFk2ZbhPRbUUyF9KjvpUHopu7xYVL6XUn3UsRHEGZW38hFrnJ7c7btznqFjhcnFL27JSBUkgmIolK6K2XGzgMNXbSwCvlrTx83KL55AVsTO0lOE11621ak29nCr1vQpIIfOS6aO77DNt04B1mt138TTiww2N/sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgB+CfMg; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgB+CfMg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741077834; x=1772613834;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BMoYKYyeF2QCN2X59peaHchHPbeIc6re8h+47CHf3EM=;
  b=QgB+CfMgxiCLWvfAl/C4VnuE3BniYtCcwQp+OOznSE5ajfKLi7JhKaRH
   LL77M+fLpELmXgBB3Orx3g/c14cyJBhhb07fjiBdyidBs34Z8nRpvSqgh
   oEYsOqXxax50Ej2sMeecczV1jnOOvZ0kvHc6MKJeQBaSviLmcM0nuTg4L
   mLKETFia5xyf9fEOEFm3grMBnfLa9fkZVU9pGjVBE0oBs39CHl81mjHjH
   pdnPLQw/YQJqtZ8VcoXXGnxxH/OSWxBvXwzQUgWEwbFWDfskuIYzU9psI
   EO2/Zf4IAfHzFvYt/pGX0l/hBQ5977ovxwzkJd24NkK1Rn105oCUapuCy
   Q==;
X-CSE-ConnectionGUID: yXsagBc3Q+KpbAOPHfhEDw==
X-CSE-MsgGUID: uzpZSBQKTFGFqRlhJ4HgFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="64430098"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="64430098"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:43:53 -0800
X-CSE-ConnectionGUID: ojbEncY3RTCwoN5D3RAIJg==
X-CSE-MsgGUID: 8SzCBx3KTgC+vJxrWZ+b2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118321904"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:43:52 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 4 Mar 2025 00:43:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Mar 2025 00:43:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:43:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vyicdh5sl9+GMhv7pGHUn4q4ORir66Gj2OgDpl0fzJxsiMHwWtOLAht6D5Dl6vA4/Io0GpjHj8DCMpyiT48wz0R2FXNIUD+VmFknd3F96KJ9WiWAYxngRXrB96/5Y2QwKhRHxNhJ4mtIIB88YB1hr7IMId68jjE/a7e3B70KcZAmtQyxdRlgwFuntwMpsi7wGurNtEk6yKIjTopdFWVdgjvsDnQDER75MnRIKez1ZqBcS89k4l832CvkpLOdmmJ/oAG6kGAr/dByqwzTI2SoxZcxCqORthH7aq2hiLdlu8JPSoIm6C2yuhiFhkWGald4VKoxAfJY87acwLmBUTTsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4yWMR6YXDCJydpYs98IEqP1KPlQ4mW/5Ic5yiFfXWk=;
 b=SA1MwZxwQesiE9Yb1qYvLNV9vaCVsPQMtB2upF9Z4/DQazJZYhZLhfK1ArmqvC1ZvoF2QaJeFgHzH2wRLl/ubc6K2puqt2656LyaaLGDTzpWEj8ecbwM9lkOUI8nHaK+8wPV+HvrUO5BWETo7LuEA7LJHQlQ4jiiQrvQDah5eFK8DK68etOFwlGAOuWtJWaeUhLki2C/rZeu3Ze0p078VicWqL/1w3EkKVpNMyvAscLCCQV1qzO4Ld6PpYqZn24ETVqpdhRx1OWCEx5GPS5/7aYZSmVNlr5kAHxggDWZc1c3FJ3u1Haqt7TYeiaOr19fCki7kcpmo8FnxYcVxgRVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA0PR11MB8417.namprd11.prod.outlook.com (2603:10b6:208:48d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 08:43:45 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 08:43:45 +0000
Message-ID: <ce7010f5-57a5-4b16-9448-d2407ef8961d@intel.com>
Date: Tue, 4 Mar 2025 16:49:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
To: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com>
 <BL1PR11MB52717ECA943E3A2D5D1FB6E58CC82@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BL1PR11MB52717ECA943E3A2D5D1FB6E58CC82@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA0PR11MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 955ccf3e-2ab9-4e2b-fa48-08dd5af8ac2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVVxNkI0TExjY0ZsUFVKRnUxNE9QR0RQS2RIbVp6R0JoRzlRYjZxUGRYQkRQ?=
 =?utf-8?B?NlB1Uml3czFLQldEc3F3d3ppanVGK2pGY2t0ckFDaHJ3bFpibWFOeXlibGYw?=
 =?utf-8?B?SCs3bEttVWdsTVppNDFDM25kek1hcGY5QVN0Mm9CaGZXUnc3ZS9xbnhYbWRG?=
 =?utf-8?B?VTNNMWRYNklrWDVoOVM1T2lxbEQ4VWRlRlRFQUxIZ3lWWGU1b3pBZC9YaE5m?=
 =?utf-8?B?WEZzWVFzcmtVbCtLWVpFVWlUSWt3R2xYUzdkV3NhZW42NnFCK0xLRHVHM0V4?=
 =?utf-8?B?RDBkaWJVdGpFL2NPQi9HOS9zZndsYVNZeWZxTFY5bmVWckFubCsxeVJxRkVu?=
 =?utf-8?B?TUwvL2o5VWE5bXpiVnRaaGxVQWlBVXhyRWN5Y1NuM013Um12Zkx6RVdsQU1O?=
 =?utf-8?B?dmR0dzhRNytKVElZUVk5c05zZGVoa0hCSzBGY2tjMlRLYXM0dW8zT2tXbzdF?=
 =?utf-8?B?WEVaNW5xaEs4S29xa2dpL2E5Zk1DQjlkRStSM2Vha252MFBrZkRuR1FPcGpj?=
 =?utf-8?B?UEJsemZTOXdRdEx3SHF6TUJJTG5zS2pXdm9OcWhyQ0c2WHVpNStucWVlZFNy?=
 =?utf-8?B?RXoxODNqWEVjYmxkTnM2a1E4VHlKbmZFUmdFOEZzcDJaTFNEM2dTc0Zrc2Vh?=
 =?utf-8?B?U2VBdDNVK0l1cXU0dTJCYW1HZmVYdDBaeWdoNUl5b1QyOE5hK04yMFRZLzBm?=
 =?utf-8?B?WHR3SmdyekgxTDdCeEFQN1gxenEyblpKNFdtVS84WW1EOXN6L0hxYWZJbFBH?=
 =?utf-8?B?V2dsQjZqaHpqL3RDYk8xSERtdzk2NktVbWJZM1ZCREg3UFFtclhqY2xicmYx?=
 =?utf-8?B?bkhRYUs0Y3hFZE41UThXU2xXVmNFYXVSNW4zOGt3UDhuVWxuMWRKZWE4K2pB?=
 =?utf-8?B?cUlBS3JYVi9tTmtFTVNaOW1aaytUR1BOYnRCV3N6NkE0RS9EZkt6RlhodzIr?=
 =?utf-8?B?RVl4ZVBWQ0JlSXJtQWtpRG5mcEhJR1J2ZzRjRTh0S1JZQURZbzVRMUluZktP?=
 =?utf-8?B?bVlUb0NlL3N6czNvZ2c5RElwYmd4YWRudi9UTWlnSXVsMVBvck5YVzBEMjhJ?=
 =?utf-8?B?U054VWQzRDlvdmt0Um5JaFZ2cnBKOWRJYmU1UHNXNnZPd1B2SzIzb0V5SWxz?=
 =?utf-8?B?SGUxTmhWWkR4aHBDWGdiSnVIMDlpQTRicmRjNDVhNjEwU3lNL202dHZsTkxL?=
 =?utf-8?B?cUdaTnlIWW01MGREaUxnVWFxMWRrL1BDRXptaCtzK3lnT2VRV3U0dEI3MDdz?=
 =?utf-8?B?c1BZSjYyaU9LU2FrdGIyejBPbGQ4bkFRdEtFcDBOelo2RkRYK2ZQOVBwbjEx?=
 =?utf-8?B?SndhcUxaaDZHYUdqZTZuSzI3UEtpeHU2TVdNSzNwNzJCUGRWOXovK1pMbThs?=
 =?utf-8?B?aTJRZVJwSXFId09lWFNrVVBnZkdaWEtmS1hFNFlUNHdZWi9wNTdKYXdNOGhI?=
 =?utf-8?B?Y1pEUHNZMUpGYjdRYXZGcm1FTmpCdjBIazVyOVF4eklJMlYvL3NkWndWN2hF?=
 =?utf-8?B?dzlQSzBnOGZNWHZrMjdkcDNCQUdHenI1V1M2RnF6UHZITnluaGZ0dlNzZnJk?=
 =?utf-8?B?dW1kU0NaOVAvcXROa1VlSUhBQnNhaEU3S0ZRbmdhSUhjKzRLZjB0ekY4SHlO?=
 =?utf-8?B?K1dzQkJORzFwWDlKZkJ4UFhuN3lqaWJmcWdDNGN4UDJodDFLY045ekRES2NZ?=
 =?utf-8?B?TG5SdXh4N1FzL3hBRlErVmJXaStsbHAvVGpZOTZJczBWeHRVQUlMR3Ruanlw?=
 =?utf-8?B?MDZzM0NZOEl3dC9hZnliOGczUTgvUEVKV2lLSldtSVdtVXRUMzFSbVBSczh1?=
 =?utf-8?B?SkFUMXo5ZktRU3VVb0x3MUFrQTZoNFcrMENQN0VRa2E2MXdkVU1oNVhtdmgz?=
 =?utf-8?Q?PgZV4if6T34SR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckMvWWdXT1NIVkRtOE9Ea1hEVTF1WGorcTAyR1MyMWdVd1ZKRmVPdy9mcHBq?=
 =?utf-8?B?Zkd0eEFIS3dGdElIOWFwV2g2YzBqaStickpvaUtNZ1R5K082emMraWplVHgw?=
 =?utf-8?B?TVo1RFA2aFc1TDdnMGJpSjZjQ2kwaXJLakk2bGNFdkdRNWsxbzZBcHk1TUlv?=
 =?utf-8?B?QllWdmE5cHRkdkE3SVVoaXNVUFpXdWIyQ1Z3bzJsTDlFdlR3VGV0OGRvYkZL?=
 =?utf-8?B?T1dNU0R5UGE1UGxwTmwwY2d5bUs1czJoNW85eUM1RUt6TzZWb1dudU04Q1Br?=
 =?utf-8?B?Y1FZZ0lYeVVIVUpuTElhRFFZbzFaRHB1VHRMelBxdFFKNk84ayt1bkFBZ0lK?=
 =?utf-8?B?VUxVemVZdHZXWVN0UVkzTXYxeW1YbmgrbU9lRXF2WEFBb2wzNzZPdmZZbEVG?=
 =?utf-8?B?d0htREtHRmdTdVBPMTUxRXhZcmJEWGF3ZXorTEJIbzBYYU1ubVBFVkM1TTY1?=
 =?utf-8?B?L2M5M3k5L01MbnhTYVZFQVBjMkJxbzNndmp6U1NuUXlWWEhJY1NCdkc4WmR3?=
 =?utf-8?B?aEp6MjJVcFBpYXNuYUlpbjVnd0huVGhEcVpJV3BkZ2J5MHlHQWwyWmdKZWhG?=
 =?utf-8?B?MFZibmZiWEhWUkh0aG8rMHVkWC81VUk1NGZsVkNZVFJzdjB2QW9RKzhlRzgr?=
 =?utf-8?B?dFU5aWc3WFVIaEhGbWRaTDR1SFRmSVJaczZPOWJlNm55VUdtZ2NxRDJVbXFq?=
 =?utf-8?B?V2VzcUtzb2txVGRnZWVHeXpiSUw4d0F2TExxYVpCWE1Ba1hBTVZyTmhhZkFZ?=
 =?utf-8?B?d2RLYmZCdFhmTkZJR3Y0TUZkYU9ucUtxMGd5aXNadGhuZkVxUk1oMFpnNWd1?=
 =?utf-8?B?dFJYbGVsMHF3K2FONmN6d0ZGay8rTnVNV0tITmtqSjNQckpSSlJpbnUvdXNF?=
 =?utf-8?B?YnV5ZFU2SmhOaDJIVUxyeWw5Z2lOem53UWJhSGltMTVPeDl3c1Y5WFBMbStS?=
 =?utf-8?B?bDBxNXdnRzhyYldXWlFlLzFXK2pmLzlYN1hOekF2bnJQWWcwcFNKbGZFZVZt?=
 =?utf-8?B?QWpoVlQrb3lBTTNYak9zNWd3K09pM2hmZTZkT3B0YU1LQlgrL1phM1RiNThH?=
 =?utf-8?B?YkNPaGJadi90c0hxbFlUZkNVdXZ6Z1ZNZWdwU0tESVhFM3pjSVFFeVV1Snlq?=
 =?utf-8?B?UVpnSEZqWFRscnBoUWM1Tmc2YUFEelJlNzRlYk1wOEJpZExIdnRwUmRkTFlO?=
 =?utf-8?B?NlY0dHh2U25obE5vVzFabi9vb2c4WWR4TUNPTXRiQnRuOWRXVS9UQjhENlhk?=
 =?utf-8?B?NFpSQlBnZ21Idk1GVVZMbXBmTmdvR3lqa0xLWjZDOFBVbklFcmw2OHhVZXhM?=
 =?utf-8?B?L2hYN1FTSWtyOG1oWE5Ub2k4NTdPenJDUjFENUpjR3hTMy93L25HSFdtdVor?=
 =?utf-8?B?QWZ6dTdwb2wwSCt2V001eUN5YnAzeTk3NTlyWncxSXdJdHRHUVlPL205WHhW?=
 =?utf-8?B?WjJpYmRwYmROem0wWjdNbnJpSzZOVG1yUFA0UWNCR3R6Mzk2QURXR1dkVTRk?=
 =?utf-8?B?WWh3RWZWRFR1aXRYMjRDSDlrakJvVThwY0pOS1YwY1BYbzlHZG5uNUI4WXhB?=
 =?utf-8?B?RkxQek9WY1NWTVFwREtWZk14VjZUc2tERmwzZkpBMmUyM2Z2aHVlTFl4a1dF?=
 =?utf-8?B?dXVKRG43ajgrdlN0bW1oRmlSVGF5OU9tUHRKejFodlRmY2I4Y3lmaUZJTTl6?=
 =?utf-8?B?ZU11eFVtMS80eWVVcEN6dDA2a0lZNHFvY0xXRDl1eXBIcURzTEc3RDlBL1pC?=
 =?utf-8?B?R24xUzh3MmtXYkpYLzVZVWRrVHBzTmgwQnJWWVhWTGNET3prSHQramMzWFZC?=
 =?utf-8?B?Z1JxTjRPdkdZWWRTNkRoZ3JNNXNuajRsbXRCWXAwV0t5aGtSdm1wZDU3TTY4?=
 =?utf-8?B?dmFDV1MycUZ0ZnpaWlFKeVlyYXlJZno0dzE5czZFcjdUMFdsYkRORHQ3NnU3?=
 =?utf-8?B?TXl4ZmdRZmE3S0M4YUFWTXkzRDVkeHdiTkc2bnhWOWNQV0ZWaVVSdENyeFFa?=
 =?utf-8?B?SWJxUm53cEx0UWZxOUowYk1MZ2pVT2duS0hZMmpkWVNCTzdGY1Vad1pDRHQ0?=
 =?utf-8?B?TW82bUV1b3ZHaWVMUlFSZi9vcGJvbTNBK1J3aGVPQXgrZC9TbjU4WGJkalox?=
 =?utf-8?Q?Niczqz4X6Nk4ctbqD9izqb6Q3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 955ccf3e-2ab9-4e2b-fa48-08dd5af8ac2a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 08:43:45.1840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBmwHwhiyvehFAAs7B3j4TNgSpmOnM45vkF/cqRNqgfhT3hb7Y4vEfhq2WQnVMlqSWJHAeArLL82a65SBWdzgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8417
X-OriginatorOrg: intel.com

On 2025/3/4 15:42, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Wednesday, February 26, 2025 7:40 PM
>>
>> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +		/* If no old domain, undo the succeeded devices/pasid */
>> +		if (!old) {
>> +			iommu_remove_dev_pasid(device->dev, pasid,
>> domain);
>> +			continue;
>> +		}
>> +
>> +		/*
>> +		 * Rollback the succeeded devices/pasid to the old domain.
>> +		 * And it is a driver bug to fail attaching with a previously
>> +		 * good domain.
>> +		 */
>> +		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
>> +						    pasid, domain)))
>> +			iommu_remove_dev_pasid(device->dev, pasid,
>> domain);
>>   	}
> 
> My comment to v7 was not fixed. Above trunks can be merged into
> one call.

oops. yeah. it's missed.

I'm also thinking about if it is necessary to call iommu_remove_dev_pasid()
when WARN_ON happened. Ideally, we don't expect it to happen. If so, should
we just drop the iommu_remove_dev_pasid()?

> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

-- 
Regards,
Yi Liu
