Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC0B13CF82
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659739; cv=fail; b=jfWcSll4C4EWAT06qPoaRnEWt1u0AtTOLBJdXcTGg7Mx79lbyfu02iImaexOtzMv7GSvOnU7mWGI80nWkZHWso/w/oXJX1gAFPZqwU+ko+MJO6qFaRdbvV+eGjxmVC9aVeWU8ELPTt/sy61Lkgq7aCbU3U8GnRmBlqkfGPoZN3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659739; c=relaxed/simple;
	bh=htpwLr9661zVHzCoETQfOSnKPkJ4BKPqjnIgUjLxs/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uxUwd4kJpmpF+gCnWNKHEGbm4kHdn5MVkBw/GmzP0BX3up05+yTwzd6oIotzpQPgBWBRO/l0JoxbMRry1VHaV4dpCU00sAr1RvVv8H0wsFM8WrBs7Q9F7Z7cB1TWAQif0NpQCa/5qJVHbG1egEs1mILCYIOK0QoCw/h+950fz5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id8x18/x; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id8x18/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724659737; x=1756195737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=htpwLr9661zVHzCoETQfOSnKPkJ4BKPqjnIgUjLxs/o=;
  b=Id8x18/xmc/fxP3suJsr1XYHrySWsvgrThf7JiXqq5NjKmhDquVR+d1P
   qL6nIexeocN8tPGKHxl7B6+PH0IsMYUMentFXNJqiqFsRXeat6hWKMrH9
   L9xrSyFbLKRkLjaFTBH2fHKy11sCqwQjRnb1bBlzxmmcfrJXQyefDEh6o
   DxXiAid3RmqL4TYT6cQJjxaWQ8QQRlvIMom5LBvScdcwn1Cjc6RsoER3p
   rrKWtE/5VVNybhbR1A8DrUa8Q6CHNKbAop2IRYIIhXl5JrZIFuYW9iNq5
   HOYXxltdDcHf6ERYdfYIk3Q9fPd6usgr91MExZ1cEdM/2wOLwvgKV0Esv
   g==;
X-CSE-ConnectionGUID: N0Gl//e0THuUK4gnPf9N4w==
X-CSE-MsgGUID: VMcMHQQgST6a27AXmbsA6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="45584900"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="45584900"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 01:08:56 -0700
X-CSE-ConnectionGUID: V/IeXDLqRYeyKxzxuPMxlQ==
X-CSE-MsgGUID: iYJD6GqqR2CFTmLFMGO4/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="93159274"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 01:08:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 01:08:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 01:08:55 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 01:08:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3YRm36YjrWbJhm1q57UtWqGEN9O/gkUMarghJQB4onQ/sXQbbQfDWUroc6BsZcxLa7+s1cgS1yof8EksyAGjvRm3JrgPZYKxUwYAKEwTJrnFsjUiNY6ooHpLz1MbEYf6KtmngUYK2PZynzpe+DzVJp4RSRfMenooldObnMXQKDw/w3WfE9Zj20prRGMokhk5d59avhMt2w15sUUYWxSAUyFpjPCTCDGSK35GiVK4zQptLqjmKiwmfeIQCkOqJRrgE78DDtoxikEdcUJKP9JJDgMSNhCzGFUFCB5nxAewSKrKvzHWgpyXO1wXcaTB11HunXEjUoB0h/oPeW6W54oCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htpwLr9661zVHzCoETQfOSnKPkJ4BKPqjnIgUjLxs/o=;
 b=BsIz3fx0BaCJjHrSEDae0SN80iHqk2/pQ0yTLOBB1VaNyB23KhMlAe89aIdRlo82o27VNL+VowwRuzh9HuYf9qZxrel+PAY40j7B6AX7254B4bm/z6Lxp/RVzms4HprRarycTsDdFnm8lRfCWb9RPfgBT0BJkaly6oJ4pwz1fUxqTo5QbtX29SONbmIHlk1aFPPIxl2XWxWK8M7XeLOf5CA5/Paxp89IZ54pMPZUidLBcCKnabzw0vY1+6VoK0IDOUqAboyKfuxqhjzCKMDhSr5ZqK1ZfNukW5Z84/VgN/otpBrCSuhmZVQyr9XIsgOC4D1n/Q3js6Qd9RzgCYfzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8566.namprd11.prod.outlook.com (2603:10b6:a03:56e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 08:08:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:08:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Thread-Topic: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Thread-Index: AQHa888x7AP+6/rsFk+8O8E7c5w7BbIx552AgACcOoCAALY3gIAA6/4AgAUNv6A=
Date: Mon, 26 Aug 2024 08:08:53 +0000
Message-ID: <BN9PR11MB5276296DD7C9503378C9227B8C8B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <689eee1c-4b84-454b-8dc5-a5f35abe1631@linux.intel.com>
 <20240822124307.GC3468552@ziepe.ca>
 <ec556b8e-4a8c-45ed-a3d2-319ef9fdd04f@linux.intel.com>
In-Reply-To: <ec556b8e-4a8c-45ed-a3d2-319ef9fdd04f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8566:EE_
x-ms-office365-filtering-correlation-id: 5709df4a-36c0-46ad-44a9-08dcc5a65357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cWxESlAwQ3pPYW1UZGlpVEk2dEVvdHBTbFRHZnAwanU5UUoxcGZOa1Z4MWt1?=
 =?utf-8?B?Q2dmeEpjWFV4bm1SR2V5T0NOMVJUTkVRSWVWaHBHVExEYzZZbWZ4U1ZFWm5D?=
 =?utf-8?B?UlBaN2hGSGx2QnpROVRLTTB0eXN0enBlUG5GZ0szeDZrcFFldGtRdU5JTzVV?=
 =?utf-8?B?Zmt5NEdudDhTdlZ5dENhdWw2dExaME1QbHIxMHlTMGcvYStybmNPY2JMWkNU?=
 =?utf-8?B?a3BLQzMwdnBJZnRMY0pwN3lOT2s0ZUFRVUlDNE5zRFo0YzFXQnIzRXVGcWhy?=
 =?utf-8?B?dnE2cVhpTUM0ckxzTUhJN1hpRUo5TEdQL1Vza0E1dDZzSGlyaGh3RjFYMWth?=
 =?utf-8?B?N3BUTVBrUUNiS3Y4dlBLaEwwYTYwY29lTStEVldTMy9NRTlpL2hvbFRTejZp?=
 =?utf-8?B?TmNIZjRWNUl2N2ZQYmxjQ0hwUTVQYXZNc2U0eENtaDZQRUVIL0hzc2t1enJm?=
 =?utf-8?B?UnNWY05LWUFURXk4cnl0V3N4OUdjS2pDQUFjamlUdmhNdElmWFRFQ0FIbjBS?=
 =?utf-8?B?TWJ2M1NhTDAzQ2xMbWJIMi82L1o2VWRNOVJ3aWFrdUNoU1J1WnZzY0tRVlJt?=
 =?utf-8?B?Tk9LN2R6cUFFSm9kZlY2TGJPbDU5QnhlTmVzbysvQkttYlR0dVRWSGUzM3U4?=
 =?utf-8?B?MktjempScTgwY2MrN3REM0MzUEg0YlZGWnVsaDZhSVJOUGlBUmlRQ3FFczg4?=
 =?utf-8?B?V2JoYm9WbW01YTBESnduM0VkdllPTHROUGVsbG5Xc0dxWnM1SzMzd2JJSGVC?=
 =?utf-8?B?TG9ZcVkxY21CRjFQNWtIOWdZUFcrNFdXNU5kUU5jcHdjYTEvcTNvY3c3T05x?=
 =?utf-8?B?dW11Tkx2eENWK0dwL0R0elVlYzFMK1lLRkY1ZVhqbC9iemZXMS9KZUhnenJz?=
 =?utf-8?B?azNDU3pvVjI5OFBIempvT0R3VlYzU0d0cjVmdW41YXNEblJENWFTQjB6WE5H?=
 =?utf-8?B?Nkl3NzNTdEd0V3daelZQMTZIVzh1ZFY4Sk1UZG1mSGpvT1RJcGlrT3R0dUU1?=
 =?utf-8?B?MlZMU3d0Ynk0ZW9BblhDQmZURmlUVmR0UDc5dlR2cXpDRENuNGsrbytDMHVB?=
 =?utf-8?B?Z3VRY243Z3Z6cEE5U1ExZ1h6Yld4N1lwSFRYaVlLei9CcmhpcFV1bXFHUjAx?=
 =?utf-8?B?UGtCaUlpTTZ2UCtRQ21CL0dGL2RHb1RvN0dERml3UGMxL2dFdnkrbHI3b1Vx?=
 =?utf-8?B?cGtsY1o5cGtobVBuY2tCTHJNRE9rQi80WUZSMGlRUThIdlg5N21VZVVsTytT?=
 =?utf-8?B?amtqcUp0Q044U2doRmtLTWt6WnR3Q3hRR2w1V3NrR1VmdTFyRXZmN2xaNjM4?=
 =?utf-8?B?WktSL21GbTkvWlVWakVscVNEZXhzcjFLbHBxN24rMktvWmZVcGFMUWNwZFRk?=
 =?utf-8?B?VFFpQXNPeXFrYWtETmVRTmQvbWZ4SVQ3T0tHUlJaRU91cnZ6Z1l4ajhHdHhI?=
 =?utf-8?B?aThQK01YQXZvYkhVT0pVQlB0NlhEbVZPVjlNb2prZUhQaXBscm5iSk9Dc0ZT?=
 =?utf-8?B?U1d6M3A5S3o2NDg0S2g0d1N3bVNJWFRpV0N3TEhqNWRhQ3JIbURoNE5ROHdm?=
 =?utf-8?B?SjhFS3FsWGMyTU1TUFFrSDQzYzJMT0NMREhRd21vRy95dXFMcW9XK01ZeDhV?=
 =?utf-8?B?c1ZlUWRXZ2hQVnUvWkY5enFHblVnT2YwTU9PVzlOTXI4UkVSR09oVGx5NnhY?=
 =?utf-8?B?ZGhzY3BpWVdycTRoMzd2T2ZqTnpnbUx5UDhla1NsbEtIa2ExUXJkR2RMbGlH?=
 =?utf-8?B?anB1YmpVUDlVN1BTOUR5UlY1UzZLd0puTG5WdnJld2orYmE3NVJ4bUl5bDcw?=
 =?utf-8?B?T0VXSDFvQzlaRmdKRnEwbmJKNjVLMzdaNTFFSXI1NERzMmFYak5tU3Z1UVly?=
 =?utf-8?B?Wkp1Y29BNC9JVGlyK1pmSWNRMEN6RmlzWGxySEFIdW5YTFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3N5MlNwTllQTlR1WXFCRUdiVUI2SDNrUGNYR0VvRG5BdVZNUHZqbEY5OW40?=
 =?utf-8?B?bmtHcEU5WmF0aXVpbUU2MUp2ZHpQM0xBbmNTcGxtbGNlQkxNS3JSYy9kMjZV?=
 =?utf-8?B?YXBzRWVWblVJM2ZPQm11RFZOTlBjS2JrcEpMMklXNkkyY29Dc2FqRFBuWGxC?=
 =?utf-8?B?UmcwNG00M1pTYTBGRHdsTkFQUzRib0lrRllyUk5XSnRiQ285cW1Oc3M1OW5y?=
 =?utf-8?B?MVIrWW11QnJhUHY0NWwxMzdJVzh4OHg2c1FHUmJEb1hWOTRhVTVURTZOTEFt?=
 =?utf-8?B?MGo2cUQ0Z0tMQ3h5cWJVc2tHQmRXRkpCVWpLeFFReURPcHFFY0xTRTRlcERU?=
 =?utf-8?B?Y2pocFJDbWJLMHV1QW56L1lkN2FHNmZkWVhHaUwwRGJ3V3RVQVJZemVuQTY0?=
 =?utf-8?B?VXp4WDlFUVlmZ2hVSDJmcncvU3hGSTJya2lqaVBCcktiZFdzdkIwYXVDSUtV?=
 =?utf-8?B?UVpIWGxuamlvbjhjSlFLRjBXVmtlV1lEdHdGbkx2UTFvbWtEMnlzbEk2anJm?=
 =?utf-8?B?OEZicnltcC9EWlJiLzdPdDBJU0lEWVRXQnU3Uk1kbGRqVFB0bHFTQlRFU3Bk?=
 =?utf-8?B?eklUZjVZY3JhT1RMWklJdjBBQTFtOHlFeHpXOUZzdUN1dVhuYkZDVnloT1J1?=
 =?utf-8?B?OGc5VXdKWjNrbndkY0RYTFpybFFKcXFlSlVGQkE0MjdUcklUZWxuK2ZpWElC?=
 =?utf-8?B?M2d5WGZ6WUpJQktWYkRCYS9FSEFMLzkxNlV4VGZGV2hoWTNVenVQRy9XSEN0?=
 =?utf-8?B?R1JZQ05ESjlFRzYzM0MvOS9tTGMyUml0eWZxWWo4VHREZzlOa2FaMXdLeGM5?=
 =?utf-8?B?d3ZjYnJrcWFXUGdwczU1Yk9zR2Ercm9RTlRPVGdGTnYvbTFSMkhHdmxwdHg2?=
 =?utf-8?B?VUx2bUNDUmpCdVRhODRka0t3MDlzWDBnUFlHSzZCZlJyZU1oR3JseGJKdnRw?=
 =?utf-8?B?T21neXZkSDkxV0NLV2gwZkxGSm1WR3lFTHE1ZmtJK0lCV0t1UkNXR21nM3Vt?=
 =?utf-8?B?UklQZ1FQYUh6dzV5MU04eFd1NmJ1Vkx2WXJLNnJybENwa0RrdnRLWnNVbWNK?=
 =?utf-8?B?MVl0UlNEZGlMYmFWK2FZVlo2c3c3em5wTERFVkYrK09YZitTSkFpQndJa21E?=
 =?utf-8?B?bTZNc3JDbXBmclBGS1dvTlE5NXJZUFc4dmFMaUFuZGNlTGdlc1RHZ1ZhT1FM?=
 =?utf-8?B?TU53cjIxZWVkMmlmZ0VIT2VPeFFyMm9MQ3Q2Z3hBY1BPK1hqa1pXZFJtcW9Y?=
 =?utf-8?B?dTZJck1USTlKMGVKcmgvaVJBRjBLVElETElTTEp2djNSRnpUU0F4dlhmNlFX?=
 =?utf-8?B?aThMSk1oRjcrUXBtek0rVU9GUGE1b2pMKzRKWm1lMU93SW9ZRGc2SWNNSHlM?=
 =?utf-8?B?a3pRZU1sVjBLb2F0WitQM0FNMDI3Z0RNNFl3d0FWbTNHeEpkU3dHYzA2TWlt?=
 =?utf-8?B?bDM5Y1poZjFYV0dzVGx0YUFlSCs4WTljb1VpM0s5MGtNMVptVFFDV3Rnam52?=
 =?utf-8?B?YmNQU01QVUFPV3ZhekxsQkRBT3Y3Qkd4MXlKOE1CMWQxbnNLTzJEY0c1eUNI?=
 =?utf-8?B?amVLdGo2ZXhBd0tWRW80UFdMeGxQNkFyMm5QUitmRUNPSGhiN2pkQlJuaE9E?=
 =?utf-8?B?Sjh5OG9tMW43V2JwR2xjRnpvMDVJT1dteHNRSDNvRTZ4ZEMwbVlhUmdtNTJ5?=
 =?utf-8?B?UElIektFbjBTQ05UbDdaUmhGd2xuMHFxdHM0VktPcEZTcmRacU40MC9HeGFM?=
 =?utf-8?B?THBDSVFBUFFhU3NxaTYrNWp5MTgwd2dYSkZlOHFzWW5tdVNaazJJZVIxRjNh?=
 =?utf-8?B?RG1EVGtWRkdEOHBzK2pNUXlmUHpMUHJSdHM1LzZyQmd6SlVINWt3d04yNVlE?=
 =?utf-8?B?Z0VDVVA4dnF6TWc3QTh1ZTdhQVA1SHVCcjdJNzlkdjg5R0V4ZE9SMUxRZ2Rn?=
 =?utf-8?B?a0FRUWQyY2NZSjFxNG0zU2FoNEFCcXZ1cHc0Qm9nWHRnMTg5NnpLbk5odGFo?=
 =?utf-8?B?UmtPYXV1VjZNemZwUTNJRjdaeFQzVnRta2M3N29qYW9tbG40bXVpOWJzaHNa?=
 =?utf-8?B?c1dsL3ZNSnkzYTFBejZobGNQYTlEeWNwOUFWTmFGVkhkd2hQMFpOM3lmSEdJ?=
 =?utf-8?Q?zbFID/7EXT+qUwtVomleB+N7Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5709df4a-36c0-46ad-44a9-08dcc5a65357
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 08:08:53.3132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKyWG+rer8CT7qXjP9X+Zp7bE6FqIo/jMyHqwy+brislDWJBil3JlanSAZcHtKd7L9vvhcQKCRw8zg+JYds6Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8566
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEF1Z3VzdCAyMywgMjAyNCAxMDo0OCBBTQ0KPiANCj4gT24gOC8yMi8yNCA4OjQzIFBNLCBK
YXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVGh1LCBBdWcgMjIsIDIwMjQgYXQgMDk6NTA6
NTdBTSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6DQo+ID4+IE9uIDgvMjIvMjQgMTI6MzEgQU0sIEph
c29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4+PiAgICAgSSB0aGluayBpbnN0ZWFkIG9mIGhhdmlu
ZyBzZXBhcmF0ZSBmdW5jdGlvbiBpdCBtYXkgYmUgYmV0dGVyIHRvDQo+ID4+Pj4gICAgIGVuaGFu
Y2UgX19pb21tdV9kb21haW5fYWxsb2MoKSBzdWNoIHRoYXQ6DQo+ID4+Pj4gICAgICAgLSBLZWVw
IGJlbG93IGNoYW5nZXMgZnJvbSB0aGlzIHBhdGNoDQo+ID4+Pj4gICAgICAgICAtIGlvbW11X2Rv
bWFpbl9pbml0KCkNCj4gPj4+PiAgICAgICAgIC0gaW9tbXVfZ2V0X2RtYV9jb29raWUgY2FsbCBp
bnNpZGUNCj4gaW9tbXVfc2V0dXBfZGVmYXVsdF9kb21haW4oKQ0KPiA+Pj4+ICAgICAgIC0gbW9k
aWZ5IF9faW9tbXVfZG9tYWluX2FsbG9jKCkgdG8gYWRkaXRpb25hbCBwYXJhbSAoZmxhZ3MpDQo+
ID4+Pj4gICAgICAgLSBpb21tdV9wYWdpbmdfZG9tYWluX2FsbG9jX2ZsYWdzKCkgd2lsbCBjYWxs
DQo+IF9faW9tbXVfZG9tYWluX2FsbG9jKCkNCj4gPj4+IE15IGV4cGVjdGF0aW9uIHdhcyB0byBi
YXNpY2FsbHkgcmVtb3ZlIGlvbW11X2RvbWFpbl9hbGxvYygpIGVudGlyZWx5DQo+ID4+PiBvbmNl
IEx1J3Mgd29yayBpcyBtZXJnZWQuDQo+ID4+Pg0KPiA+Pj4gSW5zdGVhZCB3ZSdkIGhhdmUgdGhl
c2UgZGlyZWN0IEFQSXM6DQo+ID4+PiAgICAgaW9tbXVfZG9tYWluX2FsbG9jX3BhZ2luZ19mbGFn
cygpDQo+ID4+IElzIGl0IHBvc3NpYmxlIHRvIHVzZSBkaWZmZXJlbnQgZG9tYWluIGFsbG9jYXRp
b24gQVBJcyBmb3Iga2VybmVsIERNQQ0KPiA+PiBhbmQgdXNlci1zcGFjZSBETUE/IFJpZ2h0IG5v
dywgd2UgZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZXNlIHR3bw0KPiB0eXBlcw0KPiA+PiBvZiBk
b21haW5zIHVzaW5nIElPTU1VX0RPTUFJTl9ETUEgYW5kDQo+IElPTU1VX0RPTUFJTl9VTk1BTkFH
RUQuDQo+ID4gSSByZWFsbHkgZG9uJ3Qgd2FudCB0byBoYXZlIHN1Y2ggYSBkaXN0aW5jdGlvbi4N
Cj4gPg0KPiA+PiBJJ20gdGhpbmtpbmcgYWJvdXQgdGhpcyBiZWNhdXNlIHRoZSBJbnRlbCBpb21t
dSBkcml2ZXIgaGFzIGEgc2ltaWxhcg0KPiA+PiBuZWVkIHRvIEFNRC4gVGhleSBib3RoIHJlY29t
bWVuZCB1c2luZyBkaWZmZXJlbnQgcGFnZSB0YWJsZSBmb3JtYXRzDQo+IGZvcg0KPiA+PiBJT01N
VV9ET01BSU5fRE1BIGFuZCBJT01NVV9ET01BSU5fVU5NQU5BR0VELCB3aGljaCBpcw0KDQpXaGVy
ZSBpcyBzdWNoIHJlY29tbWVuZGF0aW9uIGNvbWluZyBmcm9tPw0KDQo+IGN1cnJlbnRseSBzdG9w
cGluZw0KPiA+PiB1cyBmcm9tIGltcGxlbWVudGluZyBkb21haW5fYWxsb2NfcGFnaW5nIGluIHRo
ZSBJbnRlbCBpb21tdSBkcml2ZXIuDQo+ID4gV2h5PyBXaGF0IGV4YWN0bHkgaXMgdGhlIGlzc3Vl
Pw0KPiA+DQo+ID4gSXQgaXMgaW5oZXJuZXRseSB3cm9uZyB0byBiZWhhdmUgZGlmZmVyZW50bHkg
YmFzZWQgb24gRE1BIEFQSSBvciBWRklPLg0KPiA+IFRoZXkgYXJlIG5vdCBkaWZmZXJlbnQgdGhp
bmdzLg0KPiA+DQo+ID4gSWYgeW91IGhhdmUgZGlmZmVyZW50IGJlaGF2aW9ycyBhbmQgZGlmZmVy
ZW50IHByb3BlcmllcywgbGlrZSBBTUQncw0KPiA+IFBBU0lELCB0aGVuIHRoZXkgc2hvdWxkIGJl
IGRlc2NyaWJlZCBhbmQgbWFwcGVkIHRvIHNvbWUga2luZCBvZiBmbGFnLg0KPiA+DQo+ID4gT3Ro
ZXJ3aXNlIHRoZSBkcml2ZXIgc2hvdWxkIGFsd2F5cyBhbGxvY2F0ZSBhIHBhZ2luZyBkb21haW4g
dGhhdCBnaXZlcw0KPiA+IHRoZSBoaWdoZXN0IHBlcmZvcm1hbmNlLg0KPiANCj4gSXQgcmVsYXRl
cyB0byBJbnRlbCBWVC1kJ3MgbmVzdGVkIHRyYW5zbGF0aW9uLiBJbnRlbCBWVC1kIGhhcyB0d28g
dHlwZXMNCj4gb2YgcGFnZSB0YWJsZSBmb3JtYXRzIGZvciBETUEgdHJhbnNsYXRpb246IGZpcnN0
IGxldmVsIGFuZCBzZWNvbmQgbGV2ZWwuDQo+IEluIG5lc3RlZCB0cmFuc2xhdGlvbiwgdGhlIGZp
cnN0IGxldmVsIHBhZ2UgdGFibGUgaXMgdXNlZCBmb3IgZmlyc3QtDQo+IHN0YWdlIHRyYW5zbGF0
aW9uLCBhbmQgdGhlIHNlY29uZCBsZXZlbCBwYWdlIHRhYmxlIGlzIHVzZWQgZm9yIHNlY29uZC0N
Cj4gc3RhZ2UgdHJhbnNsYXRpb24uDQo+IA0KPiBUaGUgaW9tbXUgZHJpdmVyIGZvciB2SU9NTVUg
aW4gdGhlIGd1ZXN0IGtlcm5lbCBtdXN0IHVzZSB0aGUgZmlyc3QgbGV2ZWwNCj4gcGFnZSB0YWJs
ZSBmb3JtYXQgZm9yIGtlcm5lbCBETUEuIFRoaXMgcGFnZSB0YWJsZSB3aWxsIHRoZW4gYmUgbmVz
dGVkIG9uDQo+IGEgc2Vjb25kIGxldmVsIHBhZ2UgdGFibGUgaW4gdGhlIFZNTSBob3N0IGtlcm5l
bC4NCg0KSWYgYSAnbGVnYWN5LW9ubHknIHZJT01NVSBpcyBleHBvc2VkIHRoZSBndWVzdCBrZXJu
ZWwgd2lsbCBjZXJ0YWlubHkNCnVzZSB0aGUgMm5kIHN0YWdlIHBhZ2UgdGFibGUuDQoNCm5lc3Rl
ZCBpcyBhbiBvcHRpbWl6YXRpb24gbWFuYWdlYWJsZSBieSBWTU0uIE5vdCBzb21ldGhpbmcgdGhh
dA0KdGhlIGtlcm5lbCBkcml2ZXIgbmVlZHMgdG8gcmVzdHJpY3QuDQoNCj4gDQo+IE91ciBjdXJy
ZW50IGRlc2lnbiB1c2VzIHRoZSBmaXJzdCBsZXZlbCBwYWdlIHRhYmxlIGZvciBib3RoIHRoZSBo
b3N0IGFuZA0KPiBndWVzdCBrZXJuZWwgZm9yIHNpbXBsaWNpdHkuIFRoaXMgaXMgd2h5IHdlIHVz
ZSBkaWZmZXJlbnQgcGFnZSB0YWJsZQ0KPiBmb3JtYXRzIGZvciBJT01NVV9ET01BSU5fRE1BIGFu
ZCBJT01NVV9ET01BSU5fVU5NQU5BR0VELg0KDQpBcyB5b3Ugc2FpZCBpdCdzIHRoZSBjdXJyZW50
ICdkZXNpZ24nLCBub3QgYW4gYXJjaCBsaW1pdGF0aW9uLiDwn5iKDQoNCj4gDQo+IFdlIGNvbnNp
ZGVyZWQgZGV0ZXJtaW5pbmcgdGhlIHBhZ2UgdGFibGUgZm9ybWF0IGJhc2VkIG9uIHdoZXRoZXIg
dGhlDQo+IGlvbW11IGhhcyBjYWNoaW5nIG1vZGUgY2FwYWJpbGl0eS4gVGhpcyB3b3VsZCByZXN1
bHQgaW4gdGhlIGZpcnN0IGxldmVsDQo+IHBhZ2UgdGFibGUgZm9ybWF0IGJlaW5nIHVzZWQgZm9y
IGd1ZXN0IGtlcm5lbCBETUEgYW5kIHRoZSBzZWNvbmQgbGV2ZWwNCj4gcGFnZSB0YWJsZSBmb3Jt
YXQgYmVpbmcgdXNlZCBmb3IgaG9zdCBrZXJuZWwgRE1BLiBIb3dldmVyLCB0aGlzIGFwcHJvYWNo
DQo+IGNyZWF0ZXMgYW4gaW5jb25zaXN0ZW5jeSBiZXR3ZWVuIHRoZSBob3N0IGFuZCBndWVzdCBr
ZXJuZWxzLg0KDQpXaHkgd291bGQgb25lIGNhcmUgYWJvdXQgc3VjaCBjb25zaXN0ZW5jeSBiZXR3
ZWVuIHRoZSBob3N0IGFuZCB0aGUgZ3Vlc3Q/DQoNCkluIHRoZSBlbmQgdGhlIGlvbW11IGRyaXZl
ciBuZWVkcyB0byBkZWNpZGUgYmFzZWQgb24gdGhlIHJlcXVlc3RlZCBod3B0DQp0eXBlIGFuZCBh
dmFpbGFibGUgaW9tbXUgY2FwIHRvIGRlY2lkZSB0aGUgZm9ybWF0Lg0KDQplLmcuIGlzIHRoZXJl
IGEgcHJvYmxlbSB3aXRoIGEgc2ltcGxlIHBvbGljeSBiZWxvdz8NCg0KLSBEZWZhdWx0IHVzZSBz
dGFnZS0xIGZvciBib3RoIERNQS9VTk1BTkFHRUQsIGlmIG5lc3RpbmdfcGFyZW50IGlzDQogIG5v
dCBzcGVjaWZpZWQgYW5kIHN0YWdlLTEgaXMgc3VwcG9ydGVkIGJ5IGh3DQotIE90aGVyd2lzZSB1
c2Ugc3RhZ2UtMg0KDQo=
