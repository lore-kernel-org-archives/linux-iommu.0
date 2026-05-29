Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE73C348C51
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039149; cv=fail; b=F3FnCUTjzXhM5FxmcSYHnP2e5YXQwqIulrZW1+syboVh08qTddLa/ctL//WMZRHgbJFWpTdH7DrrmK012cf98B1U144shAisR4/gpDTrgk/EHaWhTO77NJPPV1Oijq8cq4kBohqJp2XvNxDDLFlC9UrC59YMQMLm/EACrXlDkIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039149; c=relaxed/simple;
	bh=o8o6IU7zoWSwojrCNvm87BtLeiTib5K7c0f+VcdO0Ao=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PQXAZpsAtfsXy9QFMDn9jcItZU2oWdN0t3NdtQT5xEm6y6T9TpoYajnvcFWnqf97ZtlRcw4g5mkIjj1XN8QOT2Iq5C1Zs86AuZzI+p6pHe9RMLk9coZ/X1r6ZIKpDizpULugEFtisQUAqKcaXKzutt9swpnXuoa9dN2tU+OZbJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOR4x07N; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOR4x07N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780039148; x=1811575148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o8o6IU7zoWSwojrCNvm87BtLeiTib5K7c0f+VcdO0Ao=;
  b=OOR4x07Nhjt7bYiEi7FTaZ3HMn9UU3SCWXGUg6kmdMVGi2aKoPbE2tsD
   e0Gx6wkgzV9Y9cROkbxjwKVGfXN3rk0EB15MvrOT0dwylHZASpSUc5NwV
   3mGSm0inL9ptahOuDiMDmr1Ckm7JhIGLheS3BfQTPhRahOjHlrTkCQQoC
   o/fm9J1ulmhb1wyhLaNhgldtf3+kzg8rLyxHJjqE9smZmWvZXjByetkly
   SnUvUNKtVd7Czlpw0NYUGGJWJ/99Yqzufs3rNKsvpTmf8csCafxT3+cHa
   e5vPmNvL2BNt05wS6DqqzYx9SDUD3zr8hu3DU+Jwk3sKfxbZ/iZx5VI57
   Q==;
X-CSE-ConnectionGUID: DIQToIfkQeeJyLNoSukkcw==
X-CSE-MsgGUID: QOtYgONmRaqcIdID27mnIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="83462744"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="83462744"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 00:19:07 -0700
X-CSE-ConnectionGUID: F52XnuukTWGDP2TVy7Lj0g==
X-CSE-MsgGUID: K+U5JdswQTG4UXe1Lf15Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="239761057"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 00:19:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 00:19:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 00:19:05 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 00:19:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2RWz9qONhHxrgRpgHoS8uCAZ5JGbKkkJNjWsFe36knmrHU4+WoUOhyGuOB1MHr9wG2Agl7QfaJ3zmyZ2XujfXkJMOUkkeeWBL+WPUWryH81fdB0nDNb4rJ6QHigWh0zAD8iQzGoPL5d/NfakUxJE1vT0axP2X4brhTGdVYVyOlnN3fdiCfzTvWi3rTBCKdhkNA3mOcCGeAxFHdwslKMkm6pTI8V8OqZCYX5FddaBSZw0pQTHmuvd75pjnSTFlR8ACDoKujFBoTC0zTu/jjyGoioUXfrlxiU71FoPH7+VHrNwNVsdHgBepZpoeDfqqZ2bpNpJBNHParpQOSo4SWYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH+xTeNmFotqcxL1DtfQRAm7mgRtHwCQLIVzwPkegjw=;
 b=OxuBohEnlWULkoZeuLvWFyAScFAaeeHLCImeJ+n9H3aWtcf67tOg6PIRSZGTIJh85+wP2DCnN4bl1qJb5pLks5SqxybWXWtvOiCE1lpyLHVvnqvErXt0HwNPXCoJkYLiqcTUe9H7AUpN95g1zXF3iFC2YtmNRlQ8TwlXksD12ySiNlERYGrOkPupxeK9l4WMz1o211YCZwPBTaIipDX66Ta3gohoYywznjL4t+NPES1pqS/tMZQCspCiVXAFR+TDQW80GQCz+nLFS4QAjks5d+xz8sLEQf7PLFz3MJ693RSmVmBurGTXsAnsLnUBvzb7SnIksfvIvcoH6t14ywYSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 07:19:01 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 07:19:01 +0000
Message-ID: <272da9f1-74ac-47df-b40f-3488f2cd4781@intel.com>
Date: Fri, 29 May 2026 15:27:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] vfio: Enable cdev noiommu mode under iommufd
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
 <20260521221155.1375144-6-jacob.pan@linux.microsoft.com>
 <e431af3d-b19a-45d2-a58d-e400d43141f0@intel.com>
 <20260523150147.00001c38@linux.microsoft.com>
 <a9024812-5486-4d16-b451-a75181f304c0@intel.com>
 <20260528115227.000027a1@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260528115227.000027a1@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH7PR11MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a9ec19-7fc4-4bc2-d258-08debd528e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|42112799006|376014|366016|22082099003|56012099006|11063799006|6133799003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: VEismOko1jZG1BGSy1Jw8PsaXmAUN9WP3IsCzr9JS7znRbQgDDYQejQQCVBqDl4CR9kLbTjPo3cbeRJcrMMJToCy1L0JhEsSRNU52Iu9e3Ynj9S6L30KT4ZaLBsk0q4Mm5S0x8OpS2LXFTGAPrU4c4KKWQlR/9EXXQYzdOOL3ZALB58TLeeMJl10eJO102h5bJ+B452Cvbo5LBkVJs8se1dcdlPBGXiBlSMb3lprCT4btJM4osBZaoikS3RNbzRfaSTLWqxmUw8ZE7+315V+AiVrSwYJ/0c9LznRm2xbHoLuYqL9tgyNbzZCY64vIwjfdKCvus+1t8gdxyTa5L4m3OlABWXP3YoOMWLxM+j3G/blntGzFpb4NxOwYe44ExMMT3NQsxGx213rRsp+1cYYjQ0EHcm9bHbJ/D0FD+cnbpAIXgz9ZyMCfOxf+Ri7GaMAY2I7tn9cJWqijl/ouyNHa9oGjCEAxwPu1QyOaCc8HK3MHTLOUXkyHZDoYtdbpF2LLriy74V2iKY4SebMNYMERuSRJiS7mxOv4vCE7btNXJAUNEQQqw3McUdDEd5zxcHFtv+6/Z6BfVzkSmER2SYSydt6oGI7Av+TkTghoZvX6uTmE/brIVlZ5OMac91aqqTVQ38vSPsb7nKlBRwdz3obQn3kPZ0mJza67in613LZVzu4FqXSVYYJayiWHCjKYegAzqLj3N1UonpFdkVmIkPjKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(42112799006)(376014)(366016)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDRsb2NIdUE3YVhpUVVpZHl4UDdLb1RKb0Nsc0NYZUQ4RG9WZVV3NTJxSnVQ?=
 =?utf-8?B?d3RNU3R2cGZtUTJ3MkhSNk0wUDZ4b2JZZDhEUmxmL2pNNHRBYkh2MytrcGsv?=
 =?utf-8?B?SVoyUisvbXFzeVNBQmo2YWNXQkUyc3ZSL00zQ0MwZU5CQnp1MWNXYldDM2VB?=
 =?utf-8?B?R0c4bDRUTUtadUUrdWNYZlZUaE1UQTFkcVpNS2oyaDFSY2ZmZlNVbHpJY2tG?=
 =?utf-8?B?ckVEZTBQMFFkSFlHNGlTT3RBYlg0TzRXUzUvNnJ0eVlJZ3FKMnl4QVVuazlk?=
 =?utf-8?B?aU0wTk1kWGdPaWpPcU1rbi8rM2ZoaWlhcWNKYlVGQ3Jod01uUDFkL0pBRHBu?=
 =?utf-8?B?V2tBc1JwVXV6dzdxNFh3MkY4VXpYVWI1Tzc0V2pNNTErMjY5Z3NhSEJReWsw?=
 =?utf-8?B?QVhTWWJjNFF5NmRXL3JJN0RyNU1hSXFXSmloWU1XYnp3NDMxUEwrTFNpOUVw?=
 =?utf-8?B?bGNwQXduZlhuQzg0YVBCcFNJbURMdjVYNExvVHlIYTl0ZmxQRk91Tjd3ejZl?=
 =?utf-8?B?aXd1TU5HczNNZTNMRkF3Y2pSL2trcnRYZ21TWjJ1cHh6YkUrMGYraVNaNG9Z?=
 =?utf-8?B?ZzAxR2V5cGU1KzFkMCsxemFURWRFaTVQdTFyRHRTREwvNlFseUpwVS96QVFM?=
 =?utf-8?B?WS9Yb24rbS83VVVIcGhvTmxpbkhiV0UzRytjVnQ3Z3RvNDVVS0pNNTJsMUVu?=
 =?utf-8?B?USs4bkxmYTgvRXpaQm5reFVZU3haazhkK0N6TFJnYVJsazM2MUtrZjVXV1lZ?=
 =?utf-8?B?MExOTXNSak5rNks0MWcyL0pNM0FWSG1sZ2h1Z2R0WVJOeG0xOGtETUxTSlhi?=
 =?utf-8?B?QXBFeFN2NEJLckJFVFJJbk1LM21uY0VvWlNmblJ2eXV1Q0MzSGVSL3M3bXFm?=
 =?utf-8?B?Ulh6V0F1RS9LY0xNbzhoT3k5WEx1bEhIemFqSDA5RWFiajFJRWxsazBKQlVV?=
 =?utf-8?B?Wm9ZM0hpV0trY1ZhUjFqN0REOWU0UjdoRnMwZzVRbUJ1QkRKSGU4N3lTL0M2?=
 =?utf-8?B?OUxwVlg0UkMzaS8rMVhNUGlBV0syV04yUUczV1pHeDJGZ1ZGQ1ArVGxkc04y?=
 =?utf-8?B?U3lDblZqZnd4dTJCMzQ0Ukp1STN4NWZSSFFQamM4K3VYZ0h4elFYYjBORURL?=
 =?utf-8?B?OU52K1Q0NnRRT21wRWdtUGlwTVhYNUtBL1R1WDRNSm9GT01lZW9UQnphRzJC?=
 =?utf-8?B?SkhBS2tYd2d2Znc0RllTZnVLNTF3eEhvRXB4VGlDU0JpN3o4ajIveVRUNWxG?=
 =?utf-8?B?Yk84cjJ1ZlhpVWF0OHFTZzNlNU1MZkhydkp4cUJIMmh5U21aOUp2MEhxa1k4?=
 =?utf-8?B?MzEwZlhPaWhNdVF5VzFrMHRDVVVCRzVwZzhCZjFYcnVRVisxdGZBMUx5dnB5?=
 =?utf-8?B?OGJFY1Jub0J4Q3JCMnpmNTVBYzBqVzBoZnRad2pKSXV3NmxKaWJqUjhBVStj?=
 =?utf-8?B?Q1BJUHU1VlhQbUticEQvTXh2dnBocmtjelY2NnhmUWc3WVkvMTVGaGtxSTFI?=
 =?utf-8?B?Rm9pNmhWOTc2N0tzTHl5ME5oQ0ZCRVJaZnA4M1ZrbjdwVTdhbEt0T2VXWFJJ?=
 =?utf-8?B?WHRkQTFTbm10WU93ZkJPZGY0L2lqRkJ1UFB4S00xRnhabStScjJ2S0dnWEJh?=
 =?utf-8?B?Uk1Sc2xMaFIrdWxnZzNxaU1zT1ZJdzBnaGhMVzk5ZnhWUmRKWVpkc0gvYW1I?=
 =?utf-8?B?R3hOMVNEWHNpTk1ybUxyY1pHOVVBdjdyOFhGZUlYcWtqeWtRd29HaHZYb2Ny?=
 =?utf-8?B?T1RtWkk2enMzM2cxZ0Q1TkpCR2ttekpGVVZqZlZmckp5enVGZTladjVleUZV?=
 =?utf-8?B?RkQyRUIraG10Rmk1UGlRSTBtbmlxeE15QlpqR0pvN2IyVlFCNVZXeGdYZlNB?=
 =?utf-8?B?ZVdkbmswQkJGNUI5SHRnRUZCZkFJbVRDcjBrOFBtc2liNlI3SFJUbnFhQUMr?=
 =?utf-8?B?SWNZSHdyU2J6VzVsaU1PRDlWSC9DQ0RrWnVjT20yQmc5SU9kc3R1WWtUUm9o?=
 =?utf-8?B?cWsxekxqTDVPY1VXVHF6NEFWcUU0UGk1ZXA0Z3lhcHppdEg3T3JIelQyVDBL?=
 =?utf-8?B?NXNGY2g5RGdpclVqNi9acTlOT05QTHVzK3dHNnFVT0F1Mkk1U0V1S1lQaFdx?=
 =?utf-8?B?UjBFeFJsOW41ZGFZQ0J6L25VRFY2MFNQcWFyVlUrSWYvL1dlTHZ3N0ErNTMw?=
 =?utf-8?B?UFlId1V6clRVcEMweGRxQ0NjeUZtMXlGMXRKWThKbVJDNW80L09zREZOeU5t?=
 =?utf-8?B?VEhYVG05RFUyYkRyL05vWmc1S2VUV0pXSndvamFjaHl6cnpzemdUbldXRzBm?=
 =?utf-8?B?U2tPTmR2M0JKRGRaVWNraDVESGdmYnl6RVcvV1MwZm93UUdnR2owZz09?=
X-Exchange-RoutingPolicyChecked: IVmsCcQUcr5TA3cP45WfUOaDGgRRc69JcJefGPR4gt/x4G40kYz0QLWJ3GZQHH/Llaiwy0++e4tNPy+y3UQh7j+z92+cb6bMnkw0Y6bBAwLMH3/LJH1oPqeyiaGBpuc9rFbqXJXN8XdNCcFlrGhUotPfxDkG4UZF+Pa7L4eszi7NlmJJd5rL24og9agxmgcjPmMQDJLSrA2kE8Jym2GlTS54Z6loYqMSGLiK39BPG0HXpUuxab4MM9TLp73AianUO9965ckZudTHpb+0J8X7SqUQJv4E2k+/nMRR9yqTgqXKmEejpVyAy1tPGazJtwrO5ymil/6qU9w5fNEzsINNzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a9ec19-7fc4-4bc2-d258-08debd528e87
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:19:01.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltadKZic91CxgeocRYPWWGrg/KH6+qJMxRy4ygfJxolRdaQMNkLDTOphihd4JHfQLUGim6GdqjMnADE1sYQRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-OriginatorOrg: intel.com

On 5/29/26 02:52, Jacob Pan wrote:

>>>> static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
>>>> {
>>>>        return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
>>>>               vdev->group->type == VFIO_NO_IOMMU;
>>>> }
>>>>   
>>>>>     		return 0;
>>>>>     
>>>>>     	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
>>>>> @@ -58,7 +58,7 @@ void vfio_df_iommufd_unbind(struct
>>>>> vfio_device_file *df)
>>>>>     	lockdep_assert_held(&vdev->dev_set->lock);
>>>>>     
>>>>> -	if (vfio_device_is_noiommu(vdev))
>>>>> +	if (df->group && vfio_device_is_noiommu(vdev))
>>>>>     		return;
>>>>>     
>>>>>     	if (vdev->ops->unbind_iommufd)
>>>>> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
>>>>> index e4b72e79b7e3..6f0a2dfc8a00 100644
>>>>> --- a/drivers/vfio/vfio.h
>>>>> +++ b/drivers/vfio/vfio.h
>>>>> @@ -358,19 +358,13 @@ void vfio_init_device_cdev(struct
>>>>> vfio_device *device);
>>>>>     static inline int vfio_device_add(struct vfio_device *device)
>>>>>     {
>>>>> -	/* cdev does not support noiommu device */
>>>>> -	if (vfio_device_is_noiommu(device))
>>>>> -		return device_add(&device->device);
>>>>>     	vfio_init_device_cdev(device);
>>>>>     	return cdev_device_add(&device->cdev, &device->device);
>>>>>     }
>>>>>     
>>>>>     static inline void vfio_device_del(struct vfio_device *device)
>>>>>     {
>>>>> -	if (vfio_device_is_noiommu(device))
>>>>> -		device_del(&device->device);
>>>>> -	else
>>>>> -		cdev_device_del(&device->cdev, &device->device);
>>>>> +	cdev_device_del(&device->cdev, &device->device);
>>>>>     }
>>>>>     
>>>>>     int vfio_device_fops_cdev_open(struct inode *inode, struct file
>>>>> *filep); @@ -420,6 +414,18 @@ static inline void
>>>>> vfio_cdev_cleanup(void) }
>>>>>     #endif /* CONFIG_VFIO_DEVICE_CDEV */
>>>>>     
>>>>> +#if IS_ENABLED(CONFIG_VFIO_NOIOMMU)
>>>>> +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device
>>>>> *vdev) +{
>>>>> +	return vdev->noiommu;
>>>>> +}
>>>>> +#else
>>>>> +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device
>>>>> *vdev) +{
>>>>> +	return false;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>>     #if IS_ENABLED(CONFIG_VFIO_VIRQFD)
>>>>>     int __init vfio_virqfd_init(void);
>>>>>     void vfio_virqfd_exit(void);
>>>>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>>>>> index 6222376ab6ab..84381c500623 100644
>>>>> --- a/drivers/vfio/vfio_main.c
>>>>> +++ b/drivers/vfio/vfio_main.c
>>>>> @@ -321,6 +321,20 @@ static int vfio_init_device(struct
>>>>> vfio_device *device, struct device *dev, return ret;
>>>>>     }
>>>>>     
>>>>> +static int vfio_device_set_noiommu_and_name(struct vfio_device
>>>>> *device) +{
>>>>> +	if (IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) && vfio_noiommu
>>>>> && !device->dev->iommu) {
>>>>> +		device->noiommu = true;
>>>>> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>>>>> +		dev_warn(device->dev,
>>>>> +			 "Adding kernel taint for vfio-noiommu
>>>>> cdev on device\n");
>>>>> +	}
>>>>> +
>>>>> +	/* Just to be safe, expose to user explicitly noiommu
>>>>> cdev node */
>>>>> +	return dev_set_name(&device->device, "%svfio%d",
>>>>> +		     device->noiommu ? "noiommu-" : "",
>>>>> device->index); +}
>>>>> +
>>>>>     static int __vfio_register_dev(struct vfio_device *device,
>>>>>     			       enum vfio_group_type type)
>>>>>     {
>>>>> @@ -340,20 +354,21 @@ static int __vfio_register_dev(struct
>>>>> vfio_device *device, if (!device->dev_set)
>>>>>     		vfio_assign_device_set(device, device);
>>>>>     
>>>>> -	ret = dev_set_name(&device->device, "vfio%d",
>>>>> device->index);
>>>>> +	ret = vfio_device_set_group(device, type);
>>>>>     	if (ret)
>>>>>     		return ret;
>>>>>     
>>>>> -	ret = vfio_device_set_group(device, type);
>>>>> +	ret = vfio_device_set_noiommu_and_name(device);
>>>>
>>>> the order of dev_set_name and vfio_device_set_group() are swapped,
>>>> any special reason?
>>> The ordering was intentional in an earlier version where the cdev
>>> noiommu check depended on device->group. With the current check
>>> using !device->dev->iommu, the ordering is no longer strictly
>>> required for that test.
>>>    
>>> I kept vfio_device_set_group() first because the rest of
>>> registration already treats group setup as the first VFIO state to
>>> unwind, and this lets the existing err_out path handle failures
>>> after group assignment, including dev_set_name(). I can restore the
>>> old order if you prefer, since it is not functionally required
>>> anymore.
>>
>> I think it's better to keep the original order if no functional
>> requirement anymore.
> will do,
> 
>>
>>>>>     	if (ret)
>>>>> -		return ret;
>>>>> +		goto err_out;
>>>>>     
>>>>>     	/*
>>>>>     	 * VFIO always sets IOMMU_CACHE because we offer no way
>>>>> for userspace to
>>>>>     	 * restore cache coherency. It has to be checked here
>>>>> because it is only
>>>>>     	 * valid for cases where we are using iommu groups.
>>>>>     	 */
>>>>> -	if (type == VFIO_IOMMU && !vfio_device_is_noiommu(device)
>>>>> &&
>>>>> +	if (type == VFIO_IOMMU &&
>>>>> !(vfio_device_is_noiommu(device) ||
>>>>> +
>>>>> vfio_device_is_cdev_noiommu(device)) &&
>>>>
>>>> now, the group path and cdev path have their own is_noiommu helper,
>>>> can the two helpers be consolidated?
>>>>   
>>> They could be consolidated mechanically, but I feel they are
>>> checking different things it is more clear to keep them separate?
>>
>> IMHO. They are actually checking if the device is noiommu. I found the
>> current usage of vfio_device_is_noiommu(). #1 is totally specific for
>> group path. #2, #3 and #4 are for the common path to identify the
>> noiommu of group. It also implies the info of the open path (group
>> path?). #7 and #8 is going to be dropped. And 9 is totally for
>> checking noiommu attribute. So I'm wondering if using !dev->iommu is
>> a good choice. Should be able to cover both group and cdev path. Let
>> me know if this is not workable.
> I'm not sure I follow -- do you mean using !dev->iommu as the common
> no-IOMMU check?
>   
> I don't think that should be the helper condition directly. !dev->iommu
> is the low-level device state, but VFIO no-IOMMU is a VFIO mode. For
> example, VFIO_EMULATED_IOMMU devices may also not have dev->iommu, but
> they should not be treated as VFIO_NO_IOMMU.

you are right. :)

> What I can do is consolidate the helpers around the VFIO state instead:
> legacy group no-IOMMU is represented by group->type, while the cdev
> path uses vdev->noiommu
> 
> static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
> {
> #if IS_ENABLED(CONFIG_VFIO_GROUP)
> 	if (vdev->group && vdev->group->type == VFIO_NO_IOMMU)
> 		return true;
> #endif
> 
> 	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && vdev->noiommu;
> }

looks good. :)

Regards,
Yi Liu

