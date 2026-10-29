Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793271126;
	b=z4MkYbPNK0Y/8csvJ2MIn0KvPB/ZCpe7HAJzzUAGJSgFMoFc3YqcV+AIN89SsnuAe/vR
	 DCYnx757F8vppcqv2SNYwfyIiC/wVCWhi9Aj+XhauEujCKapw3U3LbBP/Ara+HP3WcjVW
	 YtMcVuJHIBbkDbDrotzvp/YpF96czKLt8D/3sa9AhohJky8hpT/UVg2+5GRJz1B4HwtK4
	 dlD4ikWCfLAxAJaAADgG2VOxeRhxGBKqwTo0o3JhPyx1pzDRCch7DuD10gPhjisIBd56f
	 QZ9hzVxmggOSnkH03n23GQecOOodw/If8K0hVD+jgpZP2S2NCrtBrO9O5mjGhw1kS2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271126;
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
	bh=ueStyqAAco9Fqe3FWChQqHxw5JUuZ0x9YF0dQFxCWcQ=;
	b=Kp1/9+bJXUvsMjxag/CNqZ/2fp0G2snrkfhxPRjMlK1f7MUduYytYlrROi3TbIpmDvvx
	 SuuqGprT7KQ3TZRDrYdZjP9+9/7Lx7EArwetQIijlvicgEgVXs96KRxKnM6+2YRoMjcwc
	 snmw0ELDJ4xtwIkev9W41KDG5fH2RC84+QkdOPX2c2zg4Ak4sRZG0D7dfKVVFQ0sy+GVB
	 XFYLuUX47HLwl9hZQTfKlnwHYtqJMnOp0gsVLK4CqqyPobtq5JLZ/C0YBVgnMKv4cWo5k
	 Eb7BccomNTI7eCklJWFw1/IhlOURuZt9qCVeNxSM3W+L0SD563VrR45gfvFOPw6f7cA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MLz+TGar;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B1606A332
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 10:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 139B1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MLz+TGar
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793271125; x=1824807125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VZvQMOK3kuUvGuV854CVd9WAw01eFN/GAfAYy1mkPwA=;
  b=MLz+TGar00BWQsamYhdjdh/a76nOrpNN/i1ZrIUGy5gMJt3ZXHBufFD0
   sa+FhrmMFXanQwwJdmW1vdes6jarn3rqSWZPS2qzNm+fv+1do2ZQS4Ypy
   8L9HEGDwXKnAeZdFFI/PWz0A4FQ7Lc8tXt3svOfYImCtztkfRHblwzfOI
   7/iVu+WmTHRzZbBlIs+jAdup0EB+VXQs7q8AWyAdLaMwvAg8S+AxTvTRg
   UkznW1Ko/0z9O77HATlVY2EP4SnxI/An46kT3fJMV9wzqH9lwt97/9FQW
   WdpkyUHOL8iDcXxVzRVg8PPsFvzi91+/0+CXcda6SV4VyTefGp9YXTIpj
   g==;
X-CSE-ConnectionGUID: oMeeYzRbQzi2zAnrAQ3UNg==
X-CSE-MsgGUID: FSmL9yyZR9C73CUWbbk4og==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2103611"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2103611"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 03:52:04 -0700
X-CSE-ConnectionGUID: Rj6VHVabSRWCHMkbYWpZSg==
X-CSE-MsgGUID: JlnP87GASxW2IWpgxHfGmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="4996391"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 03:52:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 03:52:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 03:52:03 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 03:52:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRvQinAy4AUhxchI+CdOqBGeHIWtq0LYEFMvHU7+CCJTf5W7C7/KtDmqMxEXHJcAIHpaeqaSr8SFWJMgPolRpoco8Mh+1aoKjt5TYALekQ1A7cVFRmhai2L4jDcv8Fcr3of+3Qx8RWL7vXaFyWvcommuKpqIgRmuwUlpshoo5bY1reLlhwJN83obWkpgF5wMVhXBYgelzsnqYLzuITxqdJkg/QxfshtKfuYwom/tiy1deWOfkQSxLLGnIo+nNCbinnYyNDxtA4X/zDcPKgV3v49YJsy/vuGGsmDFNBxtsYtJ00D/H2usT1CxMuWhEDwVKSu1bAxPHctqt3BZHTvS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueStyqAAco9Fqe3FWChQqHxw5JUuZ0x9YF0dQFxCWcQ=;
 b=cISC8UP3NCYuu26I2Zh08grT9sU+b1puGX1DNSHQcL3zKn9VwRa8XPWTUeC2vRNf9Yoaq21/fOD/LBnyQv2p3+ZeaTLN0UdirYM/ypErCXmpvlo6dAACyxYf3q2VwMcf4+Y+8KW7pEVRV6Dd9+GvgJmNJkyX7SoJXTOlpxYzAzskjCisPGS4GA61gcr6XsTXHmuAp5F0HcHtmQyoS5ASPjL1WSwfSNBQ4/VuvtLhlPgQbuog4yD6quJbuc5nwR5KPRWNk7d+2lA5u6zObVxVgTS1fq38fnT0sY/psptMdDLmOlq9KaoCafvqzXHdzGN1zcoQktVL5FClZh29dCKBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 10:51:55 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 10:51:55 +0000
Message-ID: <87fb7a3f-b6a8-4683-84e0-1b0d04dfc235@intel.com>
Date: Thu, 29 Oct 2026 19:00:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"joro@8bytes.org" <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
 <CO1PR11MB4835DF015165BA9306D022178C6E2@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <CO1PR11MB4835DF015165BA9306D022178C6E2@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To SA0PR11MB4527.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|DM4PR11MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d6131e-f44e-466e-31cb-08df35aaa57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|42112799006|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003|261021135927099003|261026121527099003|261026140227099003|10067099003|261009223027099003|261022105027099003|261009221227099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 3xamKNXtOs8tdAEG8mYmIbv1yNNr1O6Br2CiuzU7Weup5McEg3RNk10Pv4wDsfQwBkCRbk9EsMrq2G87FEpYD7LipGbXECVaxjrOWaCVMeedynKHZEsCErttzl5NYs1RzWkvWS+h0QbPwgrlIme+5HhLIpD5wtywAG+HyYpothd4eCDzvrPXI2WOBF2OURAIQhWU9vDs8AjvlFjlSedsTPK7IMJcIJqZ045cODy6olpk84f2UoocYvWsDiTn8Qqdz5bQMD47KjE1nn+YxAHp+Gzs3A2rupZo0vtO8rp1DAb7sibokDam4gU5yz4XRAmX+FpRJudJHFZ6Muz4x8PMbVEOJJrtoIkP0a6aooU/OsutTtEkrGq4PL/Xz7kqUz8dq1xaTU5PexZKkzYNXRwdPLk17dhWi8oDVvwfB0O3D8ccXJLQGo8lIboZL6CUD2K39bpzJnr9qrgjmImZ9CZz7L7iZ4BhQOcffNDbHo+cTJgz739f0kqcd0SnpdDszD4PTqgRYo2BAY8xqZWIz4GckZgTKcEnOBe6Cl8PpTEr6mgafQeqbhNnF0MfPcCKjv76HtWCBfwvZqTwFZMZBkgkd4IYPWA3sWvvdRziKRHGIino62NG5VSanPGWqFFsmTCs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(261021135927099003)(261026121527099003)(261026140227099003)(10067099003)(261009223027099003)(261022105027099003)(261009221227099003)(261022075727099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGNNUkE1STRmTlJqaVNYd0ZXYy9hUG01c3kzbGxINU5KckdWNStMSldncXpG?=
 =?utf-8?B?dEF3ZEFGdTdXQURmSXlPdjNnQnNjanFERXJBTWhQbERNbStCUWZTNUYrUncv?=
 =?utf-8?B?bUROS1pEbTZlSlF2bXJQL0xIN2o3QXRsQ2FvNFVFeTJXSE9qcGlYUFU5UDlv?=
 =?utf-8?B?alkrWlhDUkFoZ2d3NnVPaW1wVFZiM2djUEFNNGZSMVBhSVhSdzVhSDdtdGMv?=
 =?utf-8?B?Zk5uUUs3QUVJd1dhY216ZjdXcm9PcVlLcnMrWkU3VTRSOElSODRlUWUxd1Bt?=
 =?utf-8?B?VUVqVmdHQjkwWWFFVjFxbjhEdUZWRk5kZmVFNjA3ZkNBaGI4b29uM281WGN0?=
 =?utf-8?B?UVFwWnd2Y05hUWMzTnlKUkhlQlc2WE43MllIRjdNUDFDMlFjcjlzQVUxME5Y?=
 =?utf-8?B?cUlIYWVkSG5mVmxVQzZ3U2hLb1NYeW9OQXRhVW5sdEE2SjhDa3ZrLzNXTW9x?=
 =?utf-8?B?Qkd1bmFPMXVlS3hvaHhCZ2h0UGEvdXdBMFFVZk1Ta0M0alovc0YvVVJIQ0Vp?=
 =?utf-8?B?UHhZTjRpdzA1b3NnVk9qaXFVUlR0U0Qxa3VpaG1Qdlc0UlJHb2t0K3I0anBx?=
 =?utf-8?B?aEFNNklUNFJYQnMvUnJJb2l1Z1BxazhzK2RIVjllWWVYZGFFRWFETmdDTTBE?=
 =?utf-8?B?VUszMEd4TFFBa25KMjBlbno2dy9zZFA5cTJrYWRpTGtUSUFXUnlPZUh4cmxD?=
 =?utf-8?B?dittZ1IyaW54MFl0UXJzbWtTVWM0R3B4Y1ZlSGE4OHhOQUZjL2FGVlhZaTBK?=
 =?utf-8?B?MzJnRkhNWXJGNHNCdlJMSWRwb1dhU2NjR2JnOU1VbGxBRmZ5U0NZZ3g5bi91?=
 =?utf-8?B?UStQK3dJTG1EQklqaDE3UUJ2QXRod1FSUkJ5RitJRjQzMkNFM3hTdGpJMG9Q?=
 =?utf-8?B?WlFDSkl3UzNxRGQzSjVKMUdnTmthSmpWRnlGVXhBRmQvOHdTbUFtTDFRQ0Ro?=
 =?utf-8?B?TU5FbWM2b2ErcFZSd3NIUXRUMWYvMjNFQlQ3N3pqcVZLc3VKV3F2amJGZU5u?=
 =?utf-8?B?c2VYREpCM1o3ZFVzaGxlK0lYZmZqRFo0c3VVQjg5OThTekVmZmpJU0ttdFZ3?=
 =?utf-8?B?amJhQ2pHdzhla2UxT2tGUjdMaTYyeTFJTG1BTFp4QTU0ZnZJeHR4SE9tZkgz?=
 =?utf-8?B?Und4eWFEWEZoV09HWnlYa1UxRmZCMGZEUGJMZEU5eTgrbk1kaDdteG5yNXhO?=
 =?utf-8?B?NGt2ZklrTUt1NlpwTVAxaVYxVmVUc3QvM2pHandkNFBHaEJRbXhtL0x0Zm84?=
 =?utf-8?B?ZXlCdGxJM2RSSEwyMDFlZGNMcnlLZ3lua09MRU5LamhRREorenBRZ0Jza09j?=
 =?utf-8?B?MTFZb1pCNFQ5SFZNR1BtOVMrN1cvOGpCdEQxeDJvQlBVY2lVU3FnRmVUS2NN?=
 =?utf-8?B?T2hqWVRtd3l1U3lLR1AwU0NvaGErSGZzSmFlTG02SGpFeWZuYUVEdng5M3Bu?=
 =?utf-8?B?Q3ZhN0l1aGR2VUkyem1uanBCY3VNZXgrMTJYc3JpbmFZd2R6S1B1cUlJZjN1?=
 =?utf-8?B?Ym1iRU5nYjh0MFdsWGc1ajNCSWtjQ3Z4SzRUajFramJMbHA2cFJiS3J3bnNr?=
 =?utf-8?B?NVdwMXo0bjlxek1ERFhzUW5mVDNvdVpYMGlDbGFVLzB0UE1XK0lYMld0YW1F?=
 =?utf-8?B?SDVOY1crSWhNZld2cGJoS3dhUFdmeFprWkNrVUhrSExoSWdrRmtFL0hnREE3?=
 =?utf-8?B?R0ZqRFQrbDdpVWl6V080bW9nMjFsSXNWYVY0cDJ0bDNuSGlibHR4OVBJRVJz?=
 =?utf-8?B?QW1lOXZlOEpHdy9Mb2FndW1ra0gwQmFoTXlOeVAwaHlNNlZob2xxemx2Z0dm?=
 =?utf-8?B?c0paSnVkS3o1RG9iREpySFRtWHlIRkVadVIyS3lZOGM4VXdHNU80aStKMzVl?=
 =?utf-8?B?UlRVdmlyd2Fma2FOaWlKZHFIb0FiRENGTG1LUUtJSzk5U0hpSU04emRLRGZx?=
 =?utf-8?B?TC9BSjdLaTZzWElpU1NRbWV5aVdZYzZJSzg4bXF1aEFCaVd0dmJwK2tGVjQv?=
 =?utf-8?B?L09rSjIzd1p6SWVpQlFRV1BPSHA4MzJTems2Q2RmM2FoSUJQK1duV0JyR1Fl?=
 =?utf-8?B?Y3Q3bFp5eFBpczBoUUZOaXpRQVpydWpqR3k0YmhXYWJ4VzRiUmVmK3QzRzVS?=
 =?utf-8?B?SGtTOEROdzJZYnFFQ2xZeHJxY1RaSW9vc3B2bzVyMjk5bVlMSVR0OXZhUGRn?=
 =?utf-8?B?bDBzWWE0VmF1TzVTM3V4UzBHSnZtYVRZTmdaUVRVOGpmaXdyRUd2SHVHTHJO?=
 =?utf-8?B?MXNJa1dWUmRQZG9QUVZTWEZUZE5mRE5wbkJvQVRmOWVXRFZUa1FxS2pvQVZ5?=
 =?utf-8?B?bEw4N3BPU0VNZ2JEdFJHV1pIZklZcUp5TDhPTTdHMEVhYWVyckRUdz09?=
X-Exchange-RoutingPolicyChecked: xDjqTlswzmXtlhVqhk7vyyXLPuEz6v96V2i2dAMO75+RfaOCVozMSqQdCF/b0W7lHbL+AhhVk+wseejnyefNVZ/0UagPqKPaAYN8xt0KmLxd2VR8fEkHc1biNKOW8mh54YJ6jSHP5XxZULQESmvm9ZO98R4WL8hkbA+GAnTzfKn6TtOwf+uG6LdJ/IksXUpT2KdcFIfhXrA6U7y70bV1nkUqKxLPg1V9tQcD+PtwlWqNNUF8pRWcnqAvXjfH5QFEikiyf52+TDzhdBEodYaBKFKivWBF2VYYJpqAA2UKlFldXaN/ipmAQaAKsEkn+RHNKeEtS24FlT4XsCOvTrfYow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d6131e-f44e-466e-31cb-08df35aaa57b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 10:51:55.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+Qz2ABEkEO4z4NSPuUkN9lbj4v8xpL+m/EIvXyRSLmi8MSW+n21Koxkad26o9KE/ECeLyUA6qEHt5lsYBrKQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com

On 10/29/26 15:25, Tian, Kevin wrote:
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Wednesday, September 30, 2026 5:52 AM
>>
>> iommu_replace_group_handle() looks like it hides the detaching handle ahead
>> of the driver callback. But in fact, xa_reserve() calls xa_cmpxchg(), which
>> stores only when the current entry matches @old=NULL. For a replace, there
>> must be an entry sitting there by definition (i.e. @old cannot be NULL), so
>> the compare fails, XA_ZERO_ENTRY is never written, and the call decays into
>> a plain read.
>>
>> Therefore, the old handle stays published during
>> __iommu_group_set_domain()
>> and only gets replaced after the call. This creates a window, during which
>> an asynchronous fault path might hit UAF:
>>
>>    core, holding group->mutex          fault path, no group->mutex
>>    ==========================          ===========================
>>
>>    xa_reserve()                    ,-- old handle stays published
>>      no-op, the slot is occupied   |
>>    __iommu_group_set_domain()      |
>>      driver attach/detach ops      |
>>          iopf_queue_flush_dev()    |
>>                                    |   iommu_attach_handle_get()
>>                                    |     reads old_handle
>>    xa_store(new entry)             `-- window closes
>>    mutex_unlock()
>>    kfree(old_handle)  [caller]
>>                                    UAF: old_handle->domain->iopf_handler()
>>
>> Replace the xa_reserve() with xa_store(XA_ZERO_ENTRY) to unpublish the old
>> handle.
>>
>> Fixes: 8519e689834a ("iommu: Extend domain attach group with handle
>> support")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> btw I just realized that neither old code nor this fix can actually support
> replacement with lossless fault handling, but I don't recall whether it
> was the original goal (then destroyed by a following change) or intended
> to be a future enhancement...

There was a related discussion[1]. With this patch, a page request in
the replace window gets IOMMU_PAGE_RESP_INVALID instead of being
serviced - spec only says re-issuing the same PRG won't succeed unless
the mapping changes, it doesn't forbid retry. So I think this is just a
more conservative instance of the failure case Jason already called OK
in [1], not a new hazard.

[1] https://lore.kernel.org/linux-iommu/20241105151042.GC458827@nvidia.com/

Regards,
Yi Liu
