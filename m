Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E507137750
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730267203; cv=fail; b=cQhZvZFUA7by0mPGshjrN/9O8AGUgEHqJUqF++4be10u3fUvLIsDxkbcyege4l2yXg7Q1krIQ5pwlqslS9JtTfak7IE4TU5hiICvOOUqdN9dMsuUwdMblFmHUsLpCxzwBAfktVL3PYPV+mqctXasXHu5U6GjccpsKHVbikodyTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730267203; c=relaxed/simple;
	bh=G8H39WI0EfqF7QN8JAVlmfIsWJ7iqnoNFRx2yV/A8A8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UYWIk1zokBpQ9v5Bw1iwaU91hEpLdtiMQQmdecLuH5rRHvgN0WnreivGfzYjjTyE/5FaH79Tw51e9kiIuVWlX4pWi/yTR2akgekfIf16TPs+O6PJWpa0EdDxqhmuSkMaJGsHsprTSFxey6n+n2LXj9WEl4uWgSvH3b1RjimAm90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBJyI59y; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBJyI59y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730267201; x=1761803201;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G8H39WI0EfqF7QN8JAVlmfIsWJ7iqnoNFRx2yV/A8A8=;
  b=HBJyI59y9PnDNFcznPJ33cuykCl/0n6rRABbf0v/o1YEu0Ld/63GrC6v
   8NgyGVG+SLI3mxNYY8tc3tMyTTM8pzxq5JHCtZvuRLKuP2lndb6nh/xtR
   BlfuL72/tGN0CWQErf+fHw2g9PJBqHj6WqssxKiMYPn5nb8qV/qR45SKX
   ZPyG9GpVrgFox6vz7evGEUlz6myCcxie79YS/d2OceDSJZpugCttaK6FS
   eefqKTPQUX1rmATbeV96BCNLdhsMuOP1b3tNs4fZ26GUHExUw9khlTCGc
   hrN/1egWk7R5yAaStbbnaku0JcnL77Le5IxgN9eRWkmb0xgy6ZWvvkMud
   A==;
X-CSE-ConnectionGUID: TsnFTwwOQ8i0u0q8o8S5JQ==
X-CSE-MsgGUID: DPqzw/6mQnmSSQ7+JOQ+3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33749447"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="33749447"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 22:46:40 -0700
X-CSE-ConnectionGUID: ZnUV5B0iToWznkRi6b/tTQ==
X-CSE-MsgGUID: 1SkWM33NTdmKTqcNSU5IAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82285298"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 22:46:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 22:46:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 22:46:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 22:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gftdu8OTwd15X+0UKV1pHtyAw3QH2LLT0C9Rt4YUSHRKjWrRBPpqGIgh6lbd1iwPSlwLNCN8fuehRnJ5MUMjMbWKJBKK2jNPOw+fJLsqbSrBRboKs24DSI6TiekM4b1G/4+Ak7M6fUjwJCsc7DasJ7lSb/1KqVTUggKXIhl1zy0eR54ZeD1ISkozP3dXyYfY1HjCxheGLw7TxK/DHrL5B8nB36LUF4mFqHJ0wZUeAt1fhuh/YXkI+cbY/cTUiBIT0Rk3fF/5QnT2YqCgCJYj9S9ntGDZxLGckoFYI8MrFlW+8i1Sl9q/O/CY215LmomTyiT+GA3mAZNyJaNhUJL9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ejMcroMEuPHbGHzeEi1Fdq6CwpkTbGBVuafA8eRndg=;
 b=al5vFGg4VgeGN2H3qHBLtYQJOMnYGqswj/cGPztABnShiF5QqevgUclZAmrRn1Eq6iUoNTGJ1IqeNFg1GynuTcM/LZ6nat1hHGKjTqRqvsD6x03stowWZdH1wdVATRZSV1TfNhe2j1/1zXrwS2V1MSfo998QMFBkH7HNez1BZ3GNIDgHsO5m8uWgyUl034IC7286fNRAIZ/58NSXFjE1OhGiGuNSfKFIcuxyrVIc+Qhy8LAD2U0ODcsqTne+Bih1ZOiMMOKodoB9kyn5hAggjhhaCENB0dJ3UtRNvVv8yXmiI3hIxqxnqqZyWJ8N7a2YTIAvD1T1f+0bl5HK1xkdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB7087.namprd11.prod.outlook.com (2603:10b6:806:2b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 05:46:31 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 05:46:31 +0000
Message-ID: <ccd8352c-16e7-4845-a94e-b22bdb3ec5c7@intel.com>
Date: Wed, 30 Oct 2024 13:51:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
To: Baolu Lu <baolu.lu@linux.intel.com>, Joel Granados
	<joel.granados@kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Klaus Jensen
	<its@irrelevant.dk>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	Klaus Jensen <k.jensen@samsung.com>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
 <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
 <ujexsgcpvcjux2ugfes6mzjxl53j3icarfbu25imhzliqskyv6@l7f42nv4fhmy>
 <bbd95589-f4c9-4dcf-939b-c3c407eeed21@linux.intel.com>
 <91d59b7d-58b0-4da2-af59-18a980273bb4@intel.com>
 <acd5c4a6-040c-48ff-9e6b-1a33e5ff118d@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <acd5c4a6-040c-48ff-9e6b-1a33e5ff118d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0129.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::33) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc8129e-ddb5-4cf6-ed17-08dcf8a634c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjZQTlBvaWRnVnRoaDMxdFN2cStUVFFjamxBdUJ1eWIyTzU0NmwxNEdTWGd0?=
 =?utf-8?B?UmI1R1N6eFBDTXV2eE9wbERJd0RjLzdaODZFcjVhUVhjTFAzRlVsek03WDlZ?=
 =?utf-8?B?QzRDWE9SZjlzMWtkQjN6a2kya2xLcmRZMlU4VHAyTXgrSUFtOG55OU05bUdI?=
 =?utf-8?B?VVlzQzNUWEtzTkhOTlBjVXl3S1dYQnhXUks3dlRwdzM5NlQ2ZmhaRk00MVB1?=
 =?utf-8?B?Yi96cEhaTkFFVFI4Wit6aXVRTWRrYmJkd1Qwdi9HRExrcHd6RGs3Z3JObXli?=
 =?utf-8?B?c1hrNWV0MEtLUkU5c0hqRDZRM2tiY3pQSzFnMVhjVVg5dXV4V3VrZ1VPSisx?=
 =?utf-8?B?MVEzLy9pejgybm9mQVJBQ25qQ0FXcHRMVHdJeGt1QnUrSGtSYU9KMDdrREtz?=
 =?utf-8?B?NzM3allUZkdnQUlVUmNpWkRzUkt4Q2MyY2FrY1NtakJRbEJIczZCVXRQOGND?=
 =?utf-8?B?ZllMaVFORG9HcVVKd04rbFlBdmtVcU05UFpydllDaWREODNKSkVodkFhSExG?=
 =?utf-8?B?VHA2SVIwc0REdmdsRitxLzVzMHhaL1ZIUWNLQURPVUY1cW5TNk90azVpUmpx?=
 =?utf-8?B?dC80akptaWt1Nk1pOVhubEEzcHdIYk1lRUpiNmQxMnkzNjIwZ1pLYmZWOHVP?=
 =?utf-8?B?ZHVhcWliUmdsTWRWeUk4alVWcDBINWEvV3A3Vkx0WW5Wd3dHbS9JMW1uMzN2?=
 =?utf-8?B?NjcxVU43K0NSZXJJWlE1WUdHem9nQXpIZ0FyQjdGeU1IRjlzajZadW5QSU1a?=
 =?utf-8?B?N095am9FTUlubXJnM2cvYTQ5SXJobDJFY09RR0gvRWJ5blh6UFZldDEyQ0xC?=
 =?utf-8?B?SWNiZkx3N2NNaWlzc0Z1TFpYTUErLzNlTUlLVkxsc1JldERpb2Q0OHh3eFEy?=
 =?utf-8?B?Sm45UTl4S2dnQ0doeTduaWlBalZDSHpDSG1pNmxocU9YZUsvV0V0Y0RmaG4x?=
 =?utf-8?B?QVZuSHowSCsxTXpKREJoNDBwcDBVTDZSWGNibHhvZUs3dStTMTE2VjVQTVUz?=
 =?utf-8?B?Qzk3TlFBbnJlbGNqaks0OXc4dys3ZGR5dzVOYUJUa050Y2dwMXlESjc5Q3lh?=
 =?utf-8?B?SnJGS3g4SkkrMDV4cEpJOVlPcCtjWHNNQVRjN3lhKy9UWkVLeXZ3NXdVUGhW?=
 =?utf-8?B?VjhxWTczdytoOFVMSzZyZjRTZ2JWZkExZzZFNHpxeXA3MHIxQmRUYkQzS3B4?=
 =?utf-8?B?Z3NHbnNSbEVPaHFlVlZIRjJNRFJFaVFQZlp4dUVwR0VtcXBwSVpScStOWTY3?=
 =?utf-8?B?c3hRaStzcy9rMlpMMk42bGdNM1BveEorRnhiczBsVmRYVHJBVGlrSHJNVkZh?=
 =?utf-8?B?R2Y1bmp1bEtKL3lhVWlOSEdsNmdubyt3QnhzOVl2NmFIalF4akJrQXVIYU9S?=
 =?utf-8?B?VU85RjJkbDZwQlUzSUsrM2EzR2tuK1Q3NTAvbHVoekVnSjIrL3VQOWgrVGVY?=
 =?utf-8?B?a1g2N0VwOFVLWEZhL2JFZXR3dTBMQWs3Q0MxTGtJVVI4ZUs0Z1ZIZTZuV2x3?=
 =?utf-8?B?ck1rODZvSDN1OUsxZERQTnZSUXVlbHIzdDZJMldmaDBsbS9DcTlQQi9hd0Ns?=
 =?utf-8?B?L0x2bld5M1doZTFxd0N2RFRqMGZSK28yeDZ5VVdnSGJDMjBpYk5yeG1odjFu?=
 =?utf-8?B?VElzSVRmMFdzNXcyc2ZzbUtwdVExNFNGSTRqK0pvT0NER1JxMzd3ZWxwTmNM?=
 =?utf-8?B?dmk5YnYvNEd3QzBrcGdWdjBqWlVMbFN0Z3p0czFpWHlyZURvRDJvRnhJNHk2?=
 =?utf-8?Q?4E+/mMqQw0UeWcYrIGsHkXju6eYdRG1oM0EDC5N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anQ4SDFWQTQ3eWQ5ZktPKy9WSW91YjBTcGRGdElIM0lHN1Z4VHdJSnMySW1l?=
 =?utf-8?B?ZVFiSGxIdDVuQlRXeWloaHc3UzBnY3BNZ1ZCRE11ZUNlNmcvMW9KQVU2R2tW?=
 =?utf-8?B?YjRrYmZWR2hCbkVYdHBBUXdvQUw1Z2ZNUkIvVjRXWms0R3lsRnNnazgvUG9u?=
 =?utf-8?B?RWhvY0pTNXliZThmbThoK09CZ3BINmdYMHozQThlMnZVcUVFUGg1ZTVFcmUy?=
 =?utf-8?B?anF6NENoaFlUZFBlMm4wbUpvdlk5QVpDc3RNMjVqSHFyaVp6U0w1RVI4dDNi?=
 =?utf-8?B?eUYvR3V2bXg4RFFoYjNNREcvNGUrQThQQm15cWhicFpvRWZ4VWJubmdwYS9n?=
 =?utf-8?B?UUlLaWJtdTdhL0IzZ2luZGFoSTNubzhVN3pCOGlCUmhFL1hqUG5QYkZDenJS?=
 =?utf-8?B?dWlUcEQ1WEgvSmxYZHdKSVJEVU9QYjVrUFdxQi9XWS81akppOHl4NHdYN3dU?=
 =?utf-8?B?SldKWHhOV0hSdjJ0RTZCUno0UFZvdVBiRG5tbGxxTUpOcTNYL2lCU1RxbjRY?=
 =?utf-8?B?S1lURmMzeDk1dTJTM1RTa01hdXZJNVpDZHd0cURVcjRqN3R2SXpOL0h1YVRn?=
 =?utf-8?B?WE1BU01mODZwaGVMRFcxS0t5SzdBbFRJR2JkbFVKcUV5b1htNldsOWFzOExk?=
 =?utf-8?B?Ri9zRFMzNFhzdDRuTTRsQjlOOU5IdTE0dzluc21xZDA5eXZXTnVsNFdqQUZ6?=
 =?utf-8?B?ZkJQM1RDNGZuVVVFWWtsdHZEOUV2dHlaSERYbGk5eklibG10VDF2RFFwcTlR?=
 =?utf-8?B?Qko3QW5LMTVRSldWYk1BaDBpa25tcW1MVGFvZ21SUk1GdmFPMjNpZjlXRlRy?=
 =?utf-8?B?S2d1MW1tVVNzN05ZSEVwRVZiN3g3a1o1WlZvSFFYUjFKSVRvVm1jNTE4QjJK?=
 =?utf-8?B?czNFdnNnQzR6Nm8zbFZNQWlvb2R2R0l0ZU5KaVg0ZklLa3AxRkcxc1R6cHlB?=
 =?utf-8?B?ckczeUtFZWpKeHhLbnNncDZLdHpMUkpVMmhNcUtvY2FrM1UrVmlnWFVwcnQ0?=
 =?utf-8?B?a1V4WlUvUlZFRWY3RUoyZ3VpMkROSXA1WUhMVXI3WW9HNTBmWDVkdFBmV1Bi?=
 =?utf-8?B?R29BUVdxQk9hRG9pdUVBYTZCdElOTWNxTmk2TlZGbnNmOE9wbUFoV2taVWVx?=
 =?utf-8?B?R1h5bjdZajh5VFhKV1R0THFIT2QyaVk0RWlxaU5uaUErRC9QR0x5T1ZvYXVq?=
 =?utf-8?B?RkNNRTFvdnJDelF4enRneUU1ejRqdzRsLzY0Y0tjMnNqbDNpS3pEUmMrNGZh?=
 =?utf-8?B?N2dpd1VoSGlDUzFKRld6QTEyZ09PNUpoVnoza3ZyU1VBNG5nTFVMQjdYV3Jn?=
 =?utf-8?B?ekJwZzJBR2M2RFRYWXJCa1Flelp0QndCTTZLRkFOT20rTVNHaDU2NkRXbjNZ?=
 =?utf-8?B?RXJYSlJ5bmFPcWx2WHdZMlpJVW5Ebi9kNjRBTVlpMEgvRWZCUlRiREoybEVH?=
 =?utf-8?B?SHc3eGcrcWFMWFMwZStwZ1NxdXJxUGJQbzZXbHV5dG5xL0tBN0gvenV0YnQ4?=
 =?utf-8?B?Y3JMNHBoU0tCTnJQRFlJbGFCVVZoKzc1QmgrTVFucEFsdDVMTEczQUk3eFMw?=
 =?utf-8?B?eTR3ZHY3L01TbWd0WU8raWZXOEZKRldQV09vOE1zT1cybFFPc0IxY0V5a0Iv?=
 =?utf-8?B?TDQ3UFArTTE0TFBGTUYrTStIazh5SVpUK3pHTjRqaXQreGEvMHpjbVN5VElv?=
 =?utf-8?B?cGN0WnhTVHVWdG9qQTROcXBKdkgwRHd6b1FrU0oxdXlWdjlaS0piK3k4WFkz?=
 =?utf-8?B?RDA1b2dsd1RrK2lMdVpscGFZZGNNc1Ftc1V4WnljZDI5N3lVRjFFdURqeUZl?=
 =?utf-8?B?UkdHRkhsdjhZT2pnMzBlOWZwZlBDYXJiamVVSDRQWGNNbjhkL1Zuakd5K2I4?=
 =?utf-8?B?czdoN3ZCa2hBSkNrcVE2RndWcjFLQWRUY0Z3U3B1Nmh2dml6a3VhUy9OdDVv?=
 =?utf-8?B?Z3VLM0k3T0ZiMnhrWFFxOFpOSS9Wd3c3cSsyd1BOMm1vTEhlUjh4U3J6YTlm?=
 =?utf-8?B?Rk4xeUJpUGpnR05uSGh0OVR2SzFYVmxuR1Axb3NZK2dHZ1NFdDdsSXlCeDYx?=
 =?utf-8?B?YUFScnVWT1ZvaUllakFPRDh3Y1RjdE96Q011WjA2Zmpkc09wMXZjYXBqTDZL?=
 =?utf-8?Q?yaNrFgxH9f1rIOkZ6UN32qgeZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc8129e-ddb5-4cf6-ed17-08dcf8a634c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:46:31.4651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPTaycQc2qBxoVQINlpgM6R0c6lM3yfXv7YnGKCxv35fuLLxN8kQVOTOOUKaOulXNmQ+sirZri8DgS9rmYgNmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7087
X-OriginatorOrg: intel.com

On 2024/10/29 13:39, Baolu Lu wrote:
> On 2024/10/29 13:13, Yi Liu wrote:
>> On 2024/10/29 11:12, Baolu Lu wrote:
>>> On 2024/10/28 18:24, Joel Granados wrote:
>>>> On Mon, Oct 28, 2024 at 03:50:46PM +0800, Yi Liu wrote:
>>>>> On 2024/10/16 05:08, Joel Granados wrote:
>>>>>> From: Klaus Jensen<k.jensen@samsung.com>
>>>>>>
>>>>>> PASID is not strictly needed when handling a PRQ event; remove the check
>>>>>> for the pasid present bit in the request. This change was not included
>>>>>> in the creation of prq.c to emphasize the change in capability checks
>>>>>> when handing PRQ events.
>>>>>>
>>>>>> Signed-off-by: Klaus Jensen<k.jensen@samsung.com>
>>>>>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>>>>>> Signed-off-by: Joel Granados<joel.granados@kernel.org>
>>>>> looks like the PRQ draining is missed for the PRI usage. When a pasid
>>>>> entry is destroyed, it might need to add helper similar to the
>>>>> intel_drain_pasid_prq() to drain PRQ for the non-pasid usage.
>>>> These types of user space PRIs (non-pasid, non-svm) are created by
>>>> making use of iommufd_hwpt_replace_device. Which adds an entry to the
>>>> pasid_array indexed on IOMMU_NO_PASID (0U) via the following path:
>>>>
>>>> iommufd_hwpt_replace_device
>>>>    -> iommufd_fault_domain_repalce_dev
>>>>      -> __fault_domain_replace_dev
>>>>        -> iommu_replace_group_handle
>>>             -> __iommu_group_set_domain
>>>               -> intel_iommu_attach_device
>>>                  -> device_block_translation
>>>                    -> intel_pasid_tear_down_entry(IOMMU_NO_PASID)
>>>
>>> Here a domain is removed from the pasid entry, hence we need to flush
>>> all page requests that are pending in the IOMMU page request queue or
>>> the PCI fabric.
>>>
>>>>          -> xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
>>>>
>>>> It is my understanding that this will provide the needed relation
>>>> between the device and the prq in such a way that when  remove_dev_pasid
>>>> is called, intel_iommu_drain_pasid_prq will be called with the
>>>> appropriate pasid value set to IOMMU_NO_PASID. Please correct me if I'm
>>>> mistaken.
>>>
>>> Removing a domain from a RID and a PASID are different paths.
>>> Previously, this IOMMU driver only supported page requests on PASID
>>> (non-IOMMU_NO_PASID). It is acceptable that it does not flush the PRQ in
>>> the domain-removing RID path.
>>>
>>> With the changes made in this series, the driver now supports page
>>> requests for RID. It should also flush the PRQ when removing a domain
>>> from a PASID entry for IOMMU_NO_PASID.
>>>
>>>>
>>>> Does this answer your question? Do you have a specific path that you are
>>>> looking at where a specific non-pasid drain is needed?
>>>
>>> Perhaps we can simply add below change.
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index e860bc9439a2..a24a42649621 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -4283,7 +4283,6 @@ static void intel_iommu_remove_dev_pasid(struct 
>>> device *dev, ioasid_t pasid,
>>>          intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>>          kfree(dev_pasid);
>>>          intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>>> -       intel_drain_pasid_prq(dev, pasid);
>>>   }
>>>
>>>   static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>> index 2e5fa0a23299..8639f3eb4264 100644
>>> --- a/drivers/iommu/intel/pasid.c
>>> +++ b/drivers/iommu/intel/pasid.c
>>> @@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu 
>>> *iommu, struct device *dev,
>>>                  iommu->flush.flush_iotlb(iommu, did, 0, 0, 
>>> DMA_TLB_DSI_FLUSH);
>>>
>>>          devtlb_invalidation_with_pasid(iommu, dev, pasid);
>>> +       intel_drain_pasid_prq(dev, pasid);
>>>   }
>>>
>>>   /*
>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>> index 078d1e32a24e..ff88f31053d1 100644
>>> --- a/drivers/iommu/intel/svm.c
>>> +++ b/drivers/iommu/intel/svm.c
>>> @@ -304,9 +304,6 @@ void intel_drain_pasid_prq(struct device *dev, u32 
>>> pasid)
>>>          int qdep;
>>>
>>>          info = dev_iommu_priv_get(dev);
>>> -       if (WARN_ON(!info || !dev_is_pci(dev)))
>>> -               return;
>>> -
>>>          if (!info->pri_enabled)
>>>                  return;
>>>
>>> Generally, intel_drain_pasid_prq() should be called if
>>>
>>> - a translation is removed from a pasid entry; and
>>> - PRI on this device is enabled.
>>
>> If the @pasid==IOMMU_NO_PASID, PRQ drain should use the iotlb invalidation
>> and dev-tlb invalidation descriptors. So extra code change is needed in
>> intel_drain_pasid_prq(). Or perhaps it's better to have a separate helper
>> for draining prq for non-pasid case.
> 
> According to VT-d spec, section 7.10, "Software Steps to Drain Page
> Requests & Responses", we can simply replace p_iotlb_inv_dsc and
> p_dev_tlb_inv_dsc with iotlb_inv_dsc and dev_tlb_inv_dsc. Any
> significant negative performance impact?

It's not about performance impact. My point is to use iotlb_inv_dsc and
dev_tlb_inv_dsc for the @pasid==IOMMU_NO_PASID case. The existing
intel_drain_pasid_prq() only uses p_iotlb_inv_dsc and p_dev_tlb_inv_dsc.
The way you described in above reply works. But it needs to add if/else
to use the correct invalidation descriptor. Since the descriptor
composition has several lines, so just an ask if it's better to have a
separate helper. :)

-- 
Regards,
Yi Liu
