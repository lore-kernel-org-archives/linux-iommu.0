Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793348034;
	b=ZAQZg3NdHweNQuj4PjcU5Pr5YG1YJFFhf3QodGgGDM4rH+gzLrPiCqfx3cf7ky9ZwJiO
	 AMltZ71nrlUydO54Zw54Sa4QLs63H0EycyJ+3VVR/THXavagJzW8dqUJRnRsV+XRJL9jg
	 uCE4Y33wzdsSldcFvmO5Vtggd8ay9yBTzsVyBBhonHYVSB/9aO6PhBitezsMjRCsom0bu
	 c0r4I9xVnNw2STC/vg3Rus50WlfXx09VCZPEItyTz1e+l7Xx23zwxvABKeS0nCW5xizmV
	 g2DxMIEjAIHGAXkVMb08SD+G6eORHbT4WQVRRc+rCr75LJ+oHwWK6fJ3bzTn1A9S+1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348034;
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
	bh=0deXPnP4fG7yzfOXF7tlzTkxRg+Daga38ULdnrsIOTs=;
	b=rFMFTbLBYpH98cuNphUCikShZuVKvJqsu/1qUXW8zxe0jNC3YdGA7LX+l5CjNloR93i0
	 9Y5D0rWaTE+YbDWAqMRrFKoWHgKHzFGq5fcVfvqSuzNBQ61HupysssVqUAON6NYOM1BIe
	 +v41PrxeqY1TV/5FS9EF7LFI2AQNZlWMmnJ28ZRAxuxSPnIMZazqYOxJUpr4CXpMLw4Hh
	 R/eIZ/75NJCkN2iu+frVP8qBbg+Fgigbvyl3roEF7p9cf9TAcwEglt/fE77GU80axfkw3
	 +n8JSVno14KT0t6HeoZTdsHrGXR33swLXkUiiPYZcaRe/pfYtsczgNpqTqyU/QPIOgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BCbdbW0t;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF14606A31A
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 08:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CF14606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BCbdbW0t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793348034; x=1824884034;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aHUPirRduZaTB/hfpRA5KzE2n/PZgKwKAg1yQDurlUY=;
  b=BCbdbW0tmmVYI1LW8CynisBqj/zhZPWGt7i+Iyz73P67hIm3PQFp91mG
   Pk5f/n9LmSTLQbzKPxAVoYen3nJWv8mwQSRygtxeeiRQLBAoq6tDd44P1
   5N3yIV2xst7MK+abheAjcqkJHlk0IgRAzKVleSqm6mVhZWZkmJ5kbQ2DJ
   MXD5gZKx/JcNXkbYH6Qg1sziCnqAODQLbp5jhBxnm0b8/zcKIB6INTWWg
   C69umfko7S2sdwh+Vc3urnzSIe9t0wfxrGCjFcCLgbyV68EGi9kEufQkY
   uNpzKvtd6qe9cwNY2E2m5XoHgNrKJANG/jETCGk39OKCcZ1a+PgC33XNx
   Q==;
X-CSE-ConnectionGUID: +XT3hvuuTr+lw+q4BqXmUA==
X-CSE-MsgGUID: wkIcKm6kQp6SgL6SfoI1EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2209998"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2209998"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:13:53 -0700
X-CSE-ConnectionGUID: gTRingFcSzWk4avEAKbuNA==
X-CSE-MsgGUID: 55gwCy3KRxavnnedNZYr7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5396638"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:13:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 01:13:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 01:13:51 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 01:13:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4Rs8hBajAYsUoDrr4nvbNBXzblDoJlBdreJI94iAU/8f3ONd8dsm6NQ+JYJypY9hmMF48KRSutCOFwq8iKtSsPR0LR0+NrAakuM41pbuPHR+JUIJAZXC1KaK+cAaqySDuIGCO1dmqAHxeMMtdtbTlKU67RM97SAAgEJbtKnTg/+RUHZQxeoy4rQ2d2lP7WwmpEZvYG+/RlMBSizG7tkrB9jeaIIiFQAKIctl/Rpq0xp6VuSe9b1OhEYPYENEvvnUP2IMHxupmAu7ubBrD0sRRR/If2LJBP7ctMyhfPjvgJZkEQGcOQkCZ5ruQ/SoPf8eslCr2Xq5ZEDk8pvh7ETOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0deXPnP4fG7yzfOXF7tlzTkxRg+Daga38ULdnrsIOTs=;
 b=SS2oqCevSRtzEeg5aFhjg2abHCwBVWdO/9WPVV88pUH3YsiOlNkeBg4mk7FO+AIGE2G3wKd9X/uwcCt0TVAsZPV7n+0hD3nODsxy9ELckdb0gHAP8NJNaD0EjxlLaFVstaT8im80WhFPOhisPZoi6MGN9xvWA+eV0KY9Sc/Tpjx+1mSZ4il/n/HLWVDZ2yJ6b7rQdYVMTNMQsFC18XIQpLLOHsoaMC56qVu2PAvELVg5T7E4g8x4vgP/MyYDl9oq7viRBQVW1RKlH/wA9y8v9+CvXuz2VfNgmWF5UuoWqnNjFXJyWavcO/xy163zQ5RLqyDsPvEg/xoPw/MKo0vtOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by LY0PR11MB280243.namprd11.prod.outlook.com (2603:10b6:404:230::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 08:13:49 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 08:13:48 +0000
Message-ID: <943304cd-112d-4bd8-ad3a-f70359f15aca@intel.com>
Date: Fri, 30 Oct 2026 16:22:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"joro@8bytes.org" <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
 <CO1PR11MB4835DF015165BA9306D022178C6E2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <87fb7a3f-b6a8-4683-84e0-1b0d04dfc235@intel.com>
 <20261029184544.GF3734323@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20261029184544.GF3734323@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To SA0PR11MB4527.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|LY0PR11MB280243:EE_
X-MS-Office365-Filtering-Correlation-Id: 3358f0f4-48f2-4940-7ad0-08df365db972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|42112799006|11063799006|4143699003|56012099006|261009223027099003|261009221227099003|261026140227099003|261026121527099003|261028144727099003|261021135927099003|261021121427099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: R/lKlikm8DQON9y0eYFq85g4MCCFxPFb7rcUXWd+FVD4fsH1ak6qVZ52IDe6tJaMrC/m4ysiQ04rBa1uWrxjemPCJSQt0C5y/TzV/G0GLHps2mhoNjDTsl47E9+IiA6pt4T0qQ62aOdrh0AUqpl/u/z9x8xFeC3qzn603zZx/bxferbV0EzHAErUzstWn0O3ByfJ0Ja6DegxJEnDPFR9r5AupvGpcdY3cR1TJiIPBUTqb37YTVA5B0WsPFYTwIV2w4SRxG4w4UingX+Kag6OQK5eO0EXTKWb2HEmqKBa745eP2wWwf4b/J6zexPKSK2T/E3hUEBJh11WO6bQudBF5vpOMK0aFXY9r9xRpUbuFzR1BHstWxAyJ0XuT0adTiezItE4BaOYDpdqHi0WzQuuWMLe57yhdF032HAv9Xh4PBlyAaas0Ab851Mcnc+p3je3pRgEJmb5dZWOskiSqgCIXhvZUIQqvEA5FEWzT25bdPWDrH2ISqHzYs4v3PLynk4sWLbMexZ6m2l4/d7H6zeJfmmNcY8ar5ge1ZNhEP1TRG9bPEs0PVjXx7CaGAGxEGW3Ki2InRm2HfGMS0ZOlIxyPKZBj0oCCU44nTpsG1QHjMm+xq7KnsQVBgRRO4GEhYpk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(42112799006)(11063799006)(4143699003)(56012099006)(261009223027099003)(261009221227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021135927099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW1Kc3RrdE1FVTJCUTZ3K0xwd1JINE80dXpFY3hGcDVEM1ZHeHk0MFBib3NN?=
 =?utf-8?B?d0VXSTVFVDk2Q1lWZmtTVUtMazgyNnJRMVFIanMzY21CQXl3dlZIZzFpM1Zk?=
 =?utf-8?B?TGNFRlpsaTJzSFgzc08za3pJemVEM3ZieHlBVmpBVk40WU9FZit3TWRxa0dz?=
 =?utf-8?B?OWpXdjY4a0dMc21WdE0zS1EremRzZ3ptOU9JeFJZZGp4alYvRWU0bTRwTkRk?=
 =?utf-8?B?MWhHSFlFY3dKVW5YZWI1QjNDdlRIeDZmbTRVb3NrY3MwZUQxc1pmTkk3UlVr?=
 =?utf-8?B?elNnN3FEYmVGeUNiVTlkbWdzVzVRNWhrRW8rUFdZUUVvNzQ0TGVHVHJ0STE2?=
 =?utf-8?B?c2ZITkRHVkZIREVXZXZNUGtYOVRHdUQ2VUZDRHkreUp2Y0phTDJQTlNKakNX?=
 =?utf-8?B?b1JlUEN5d21YNGg3U3RzdzJnY2dxaTFNaURxYzhPeGNEQVlzSW85ZjFrZmtx?=
 =?utf-8?B?WVdpMVNmcytyZlRCNGJ1a3d3dWJScHpMdkdIOTRVRElzbEROaTlpTk9EblNa?=
 =?utf-8?B?NFNsTTJleklQREtuVFhYSVlFTC9YUzJJNHAyUWg2VXM4ek9YSTZpQmRUSVI4?=
 =?utf-8?B?MmF3ZHQxQldhNXpGWklQRXltaDRpSWl6ekV5TEVkb1FEQ1RFSVN6SHBUWmJ0?=
 =?utf-8?B?TW1hTGl3RytVakxqSkJERElES3BDSUpyMEV0OGpHRVdnUitmcEhTaFNVSmJE?=
 =?utf-8?B?QzY1R3UreEpUZWR0MzA0M1RDMHNPUnhKQmxmYWRyM0psd09HanlhWnovNnhO?=
 =?utf-8?B?S1hRMElXVG1md0VLaEY5TEdXcThFVEU3MU5JTEM0T3A2ckZMdU1sbVZ1WGgy?=
 =?utf-8?B?VytvSzNkWCtYK1J1Y2loeUx3dm4yZHpNWEhNZXVrSVJDVFdYcFN3ZFNWY3VW?=
 =?utf-8?B?eENDRjB4NkFMM04yUGx3WWlLQzlONG04S3d5QlpBSXhYMVUvQlNoTlRPYVhV?=
 =?utf-8?B?ZlpYMWFOT1JaS2NtSWJMSkhsWWdneDBsUTlMQ20rTXBVT0gxV21JaHJsTjhi?=
 =?utf-8?B?UlpVZDBTZ3hIUEZKTHY2dkFwUC9OZ01aUDJsb1VVQy9idTNjUnRyTXJPVnlP?=
 =?utf-8?B?UEw3akZOeXQrb21RQnJvVGhRMHNEZEV3NC8yMkd4SmNOL1JFNjRBajVHVE5x?=
 =?utf-8?B?UlB0L3BqaHdJVjFFYXdiMjN3Z2ZDY3NVSUc4aEx5NEJxYjBibk9CTnFrSkFn?=
 =?utf-8?B?bEloR3NzRVZBN2tzMGtFVHZGbjVsaWs2QzM0SVlGSTAyZmd2NFBsanl6WW5k?=
 =?utf-8?B?QnVGMWJpODc2c1BaM3JRanpKTXRLYzVyMmFTRG1mR3MyMUpKZ1dvai9pbFB4?=
 =?utf-8?B?c0YrSjRzam14em9JdnZVUWtKT2J2cllOMjFWWnNJSEJma00wSzJTaGN2dnBv?=
 =?utf-8?B?cXNiUWZyaVFrQWFFNmZvREtJUnNrRUE1amwyZVRZeis2MU9tUjljVkQwSHhY?=
 =?utf-8?B?TEtybXIrVGRaNTdzMGlSTUpyN2swN3VkMFJMQ1k2SCs1K1pNcEc5dWk0Vk1i?=
 =?utf-8?B?MWlmZk9mYzdOZTFxaGI3dWlLTHNLaUJpN0MwRFBXOHpHa0FTT2luUzJGRU1P?=
 =?utf-8?B?aXJXalZWTmRDWUhrbjZ4cFdVbzh1blZ3N3FXaHBCTjNXcjlBVW1veXZ6ZHRp?=
 =?utf-8?B?M2piOEdyc29WWWdISlNSdVd6Z2xJVUw4Zjh0bUdtaGljWDErWjlNWVhtNUh1?=
 =?utf-8?B?NUx5UGpBS1JycklkU3JrSTBGQVdKVUdWbGlPUWdzWDAwMzJGS1BLUmNIeEFi?=
 =?utf-8?B?MEczcTlHZjZDbHpzNEFRYTE5dEREbVRJZ3MrQ1FRcUlFTmpYUGVXNy9HeklU?=
 =?utf-8?B?OXBEcDB2VFJaV3diVkhwWkVySWQyM0Y4ZHNvcHZpa3pNMXJiYjBWcHUrajhp?=
 =?utf-8?B?c1Y1cnJ0QkZYeUhJMmE3V3RudlpGS3Vod1pDaDJ3TEVwVHAxSmJDcWhlTmlH?=
 =?utf-8?B?WmpRNmFmRG1NV3prQk9uejArOUJuMEp0TThjbDZWbU1wSFNvOW5rakVnMHQ1?=
 =?utf-8?B?cHJRYmRCSktOSWQ0UXlMcXlzZklqc2Z4UjlMSCtxWlBSYllRVWlsdktPUDc1?=
 =?utf-8?B?d1cwTFQvT2NGazlEenBsV2o2ZDNFOXcwU0pVUEJmbC9hei80TFA5MXZJa1Yz?=
 =?utf-8?B?NEM5cjE3QmJLTkZGenplcXQydEM1RERkZnk5SndSSDQvV1dCWWNXM3ZKRmpF?=
 =?utf-8?B?ZWtIeDlPWEpOZ2NiSFc5TS9qbHpXeHR5V3h6TTZrbUl1a08zT1EzeVhndCtE?=
 =?utf-8?B?bWZDVkp0OERBLzdQZUZMejlPamxZZkQwblRTeFhPa3k0Vk5lWlBGQXNCdGZa?=
 =?utf-8?B?T3VpTVRTb2ZzdjRUQTVpdXdGdTF2b0RKd3IxRUYrV1NhTkhKUFNUUT09?=
X-Exchange-RoutingPolicyChecked: JDtG6ysCbiabClvY28GAlsaRduuNZtH1Sk46O3tpDNLs2SFZb05eiHZACP00FA65o+wTrkwJ/2BnW4H+IZkfFx5fbX4a4o7rc3om4aQP+5k4l69TS8yFvYjq7eH9CEJjV6ia1INmrbq98emeOZiEmNa2CK/qPJCigNEdnfL5PU3Aumm1C5LIalw/TpfcOaPfvyZ8eD+ujj8KAQpeVozx3ucKpDBBLHlSbgjrrht2/HO21ADtYqm5k0a1B2bve2WmK98Q15RH5KsbiwxiLcLdSNIaltqqCpWoxEQvvDzEneDXkuWZQ4VvoQealfRltDv/xdO4BI9SZSC/cKsjnlxF4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3358f0f4-48f2-4940-7ad0-08df365db972
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:13:48.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsIT/yIn676NTJK0JipT1cRNW1Jjz7XbUqfnFmFN93tqORNci0xrNowi0MKykUMCijjn/tIBMsBQKjiAoR9xwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR11MB280243
X-OriginatorOrg: intel.com

On 10/30/26 02:45, Jason Gunthorpe wrote:
> On Thu, Oct 29, 2026 at 07:00:18PM +0800, Yi Liu wrote:
>> On 10/29/26 15:25, Tian, Kevin wrote:
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>> Sent: Wednesday, September 30, 2026 5:52 AM
>>>>
>>>> iommu_replace_group_handle() looks like it hides the detaching handle ahead
>>>> of the driver callback. But in fact, xa_reserve() calls xa_cmpxchg(), which
>>>> stores only when the current entry matches @old=NULL. For a replace, there
>>>> must be an entry sitting there by definition (i.e. @old cannot be NULL), so
>>>> the compare fails, XA_ZERO_ENTRY is never written, and the call decays into
>>>> a plain read.
>>>>
>>>> Therefore, the old handle stays published during
>>>> __iommu_group_set_domain()
>>>> and only gets replaced after the call. This creates a window, during which
>>>> an asynchronous fault path might hit UAF:
>>>>
>>>>     core, holding group->mutex          fault path, no group->mutex
>>>>     ==========================          ===========================
>>>>
>>>>     xa_reserve()                    ,-- old handle stays published
>>>>       no-op, the slot is occupied   |
>>>>     __iommu_group_set_domain()      |
>>>>       driver attach/detach ops      |
>>>>           iopf_queue_flush_dev()    |
>>>>                                     |   iommu_attach_handle_get()
>>>>                                     |     reads old_handle
>>>>     xa_store(new entry)             `-- window closes
>>>>     mutex_unlock()
>>>>     kfree(old_handle)  [caller]
>>>>                                     UAF: old_handle->domain->iopf_handler()
>>>>
>>>> Replace the xa_reserve() with xa_store(XA_ZERO_ENTRY) to unpublish the old
>>>> handle.
>>>>
>>>> Fixes: 8519e689834a ("iommu: Extend domain attach group with handle
>>>> support")
>>>> Cc: stable@vger.kernel.org
>>>> Assisted-by: LLM
>>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>>
>>> btw I just realized that neither old code nor this fix can actually support
>>> replacement with lossless fault handling, but I don't recall whether it
>>> was the original goal (then destroyed by a following change) or intended
>>> to be a future enhancement...
>>
>> There was a related discussion[1]. With this patch, a page request in
>> the replace window gets IOMMU_PAGE_RESP_INVALID instead of being
>> serviced - spec only says re-issuing the same PRG won't succeed unless
>> the mapping changes, it doesn't forbid retry. So I think this is just a
>> more conservative instance of the failure case Jason already called OK
>> in [1], not a new hazard.
>>
>> [1]
>> https://lore.kernel.org/linux-iommu/20241105151042.GC458827@nvidia.com/
> 
> I called using either the old or new translation OK, using neither
> seems suboptimal. So returning IOMMU_PAGE_RESP_INVALID doesn't sound
> ideal..

I see. maybe we can have a interim state for the replace window. This
state responds PageRequests with success for the device. The device
shall retry DMA and re-trigger PageRequests again. Once the replacement
is done, PageRequests should be forwarded to the correct domain and get
resolved.

Regards,
Yi Liu
