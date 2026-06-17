Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A13B27D8
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680781; cv=fail; b=FBm3Yb9gpBIT8lhOVf055FF2s5ins6gGtwSS2JD/ZeRWZiMj2ia7dYUHdcNg2erOr3M78YfyhgRT6oxdzGTVGvj7jpoSLSYQQlmXFCHCTeDt0Ok6dbk7WVq+Hdbbf9AVHCe8Xl/TNG45xqqVjsd7sVrEklfD27fFF/TflPDKwag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680781; c=relaxed/simple;
	bh=wH0QDiEZ/GxwOGdavn29OzI8bRRpkSGUu6MmIED+imo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cGsQCYDAW2Re31IRtxTcmPG7N3FuRAJVD9/ddRTQsMMKIKNycfF/B8JRjQTiHzDVhZJVdWepcRdZVtnVcqHf8ykpz/L13MFpS4F59h7zXIf+r6ZA2/lVQWw38Fy7ydTELKREbsZz+SWYdQtTFVkmZ4tP7LFtU9KXgLzUCRQG2FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4OUTUyO; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4OUTUyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781680779; x=1813216779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wH0QDiEZ/GxwOGdavn29OzI8bRRpkSGUu6MmIED+imo=;
  b=K4OUTUyO97cEPZz8k+nnE4DcRiTamksODQS0yJSSve4mxz5YegYSJw3S
   UeL7Zxmg5Tbrql4n/L/JlqPNuwJo1nSVFJTXbp58ybpweyrUMWzWiASE2
   CCB/ApPgh7kUZl/xPIocjnhaUjUfIzV5Odfn8WDusNX2cB4nRf4AI20EG
   C5TNu/ClSXU1egqI/D9JxcY2NRvWyLOzBx9uwyoot8i6xJgSDrFdVwu9h
   B2aPzdR42TmidVG08y0f5/8Um/aD5jSle5ts91xch3b/gBDCdGwTTdZG8
   jbpJ0PolK2vo/ADhCPXmXfgq8vaklDzQTq4WqrXpzT4NkQsOP5zax3LY+
   Q==;
X-CSE-ConnectionGUID: 1LaDRKgeSWK8UeSTZB9aOg==
X-CSE-MsgGUID: ufIF6U4AQr2irq8AFjbewQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93841582"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93841582"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:19:38 -0700
X-CSE-ConnectionGUID: wjesjKopROiLcXMGb2tF6g==
X-CSE-MsgGUID: NPvh2cAqQO+zgdp2VK3P9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="246852462"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:19:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:19:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 00:19:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njHA0ecqeNzC6xeloEi2BLUHGYxtWNQksP0uNA9sCnMMyLFHatBJ7I7LL9TIbjlq09qIxx8hoUZCHs/gpB0Vs9+ZbKfWzxFVsuA0K/GW3/SiR9dRq1QFeVwvqRfqIN/O4dz26/0w4n42hoj0M43upRjwtUmdvRF0X7CcUQhrfyNp5hpwhv9J/l4yl54CpYHLCYfMve3V5jW8gJjPyaNuJiC+iK53L2r6WhEmPa2YWSdXiCUZwf2P75BYRasaeUkP1lqkZULFMuSgiHLpYw63sqxfWiP4HZX/nXDLtcPO8Dqu4yD+xunxwxak8TDe8Vuq7h0Hry8jGY7zm8XYglrk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH0QDiEZ/GxwOGdavn29OzI8bRRpkSGUu6MmIED+imo=;
 b=sfBV+/VoSDJRBbb1aQjzzqzsJB5O+dhbzB0dtuWAIF9ZjSMvRAPIrzmP3CEk6ibIKZ2qOYkdFxhb45kJ8UwvqTE6VF8LHObv71Nb9o0ftQF3G9SsXRdzPvW1uRqzJrlNHUT6K2EcMngQ82+sOXMPzRpr+lmcmzCE9UnonBt3rl13jW9akTLIQ8fFy5LEYM2+Sbk70QTUyLT490QJqd62gsxjgsjm28/J3mht+6d4XJ+WNeYgajGENwm4v0mzQyhDItP1eBctko+WHLozI4IAfDJQwJBkefpN8TFO4fNGTYLDKhyYony30kSBWHUItyYrKiIjmgAhMZ40gKoKsT5Vtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:19:35 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:19:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Joerg Roedel <jroedel@suse.de>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, "Chris
 Wright" <chrisw@sous-sol.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/9] iommu/vt-d: Call dmar_can_force_on() for tboot optin
Thread-Topic: [PATCH 6/9] iommu/vt-d: Call dmar_can_force_on() for tboot optin
Thread-Index: AQHc89/tYqHC5hXatUSapZs8n+6r0LY6/xqAgAdrzzA=
Date: Wed, 17 Jun 2026 07:19:35 +0000
Message-ID: <DM6PR11MB3690B5C7395AB982C0AEBA588CE42@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-7-kevin.tian@intel.com>
 <cc8cd5bc-e093-4a95-a68b-ae3ca24944bb@linux.intel.com>
In-Reply-To: <cc8cd5bc-e093-4a95-a68b-ae3ca24944bb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|MW4PR11MB5891:EE_
x-ms-office365-filtering-correlation-id: c5e805d1-5719-4565-04f9-08decc40c8ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003;
x-microsoft-antispam-message-info: /gbVwXbyCNmvhUTVdAInDbLMfEDiA2ivac8ITS5NU9tMTqPNA+jXxV+g6u11IJ9NpNtnXHSPDY+QV++dzg18fLEYcozhY3bj4V8b9dKK/6ROe70BOVcNtS+gcc1gGM4KCylN3wa/Aeyzkd4lKQ1cYYZcXMpOe8HcB6cvhTnMQFBuEXW+4OwLWn4pQXdk6mtKEobTkurANUgeilVPVupBmx0pRppiXiv71v8XOjbvy7ZT4zD90rUGkYaZ5qUkY66qBp2H0t6uVlz4UCSF3FxAe7oV+c13B7zUZ8yG2hszfRqCwwxI0DJukwtv7BTXdohhpIHu4Wt+CJEK+ZRWBJf8ZOsIy1faqB3vcKA1Cd2cy0hgmxF0D0fd9zkSnGoFzDV6apL5jECXq/Ptd5kW7XAlaTiTSE4uhGVIFfM+heLKG6e6MU2YeLiLMHRs3bdfz+Goh8zffWzWOcKceVU3OoUGnjzouKL43P1TKHDC6iaFzosMOaNUUBVvmwy8acU5L/j1TPHIl+MfnWW2NfJ6zL67IgkqQc9k5d05wjy9PwqNnuitEfFD3siGY7MbRCPis756Wncqa/c5ZltHpgB5SUQ0/mW1xDXNYxhRp9bHSYvIhXZ8dufAxAw94u06RgXX+GtZLeCIU1wWoDwzqiyh0npRj0QyHLjuZeR6Y/apgMuG6LPlNUAsnrHVAkwVnstcK8PLNPVRFRJl/OPpeHzi5zZbDNNRQ/R6oWITrvEdEFaHi2SGmR8lr1yGSvxK1C84DP/b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDZ2emEydWs0ODF2eUwrTDRHYzFnTHkwKzBpRU9xM2dWbjJETVRxOVJQK3p0?=
 =?utf-8?B?VjR2eENLUzF1Z1JXV0VyTUVXWU1Tb3lyeU8xT2RmSWdDZ0xSdnNaMDhaYm0v?=
 =?utf-8?B?L0pKQ1ZWN2s3RWdpVHg0azZ3Yi9PYm9YYTFNZzFmamR1ZzBmQklrWC92QjRq?=
 =?utf-8?B?R3hrbExCQTgwMkZndkJIMmdTRHd1dUxjMVNWQVoxNGU3QTZ5SHJUc3R0WnZl?=
 =?utf-8?B?MFRVR29pZGpFT1VqOFZDdHNyeFFETm1obWRiNUVyN3o1VUo2YXNRMUxpczQw?=
 =?utf-8?B?c3JkT1NkTTlmUlFZcjdKYWtOZExCZFZ5bXhYT2drZkdrQm52anhVeVY3Y1lq?=
 =?utf-8?B?cWdlYzVpQWE3K1NybGVaUWJnS0x2TEZMVjM0VkZZNHNqeEJ1ZTc2d2RmUXFY?=
 =?utf-8?B?cEsvL3BXdERHYmxkdHI5cUl4SDJSWWt2c0dQZ0ZjVXNraDVTY1Q3VTNEVnJH?=
 =?utf-8?B?SldTM1NGY3dQOEV3d3pHR0I5bk9PVU9PU0FmREhFTlpxSEhYNEdIMGRlK0pP?=
 =?utf-8?B?cnk2ZzNJQ3VqWXB1ZW5rR3NvTXNCYWIvVEJmY3pJZE9raW1NbDBjRWtOZWpH?=
 =?utf-8?B?QTMrTnVicG51UDNyK3N1engrMXcrYjhONnlBMElxVzBqeitHVWwyOGM0TXRy?=
 =?utf-8?B?enFSN2VONldVeDNiSU1HOWVzMDRLUHNYYk1YYVdvOHFramZIV2I2NDAvM0Uz?=
 =?utf-8?B?WVpPY3FBbElvRUxqT2NDRXM0KytjV09Gb3NhZ0lQUmN1Q1FPR00zWGVvYnVu?=
 =?utf-8?B?SkFZWVczODlaNG1IVzNTYThRdHpsRnQ4eWd3UGNwWkxJZFlPZ2JYVWNpSTdT?=
 =?utf-8?B?VWNScGRxTU9TUVUyTjZ0ZnVPU0NvZzNNcVd4VTBWLzZLNW5TUm5Vc3dzZzU4?=
 =?utf-8?B?RjlYWFlVNnFwU0xsOXdkSnBUbGZaQUs3M01zSXg3QmNQWEdtVTNlUmJ1NXZM?=
 =?utf-8?B?Q09LOTRqeldMcEdTeFJVZ0ZVYUc2T0Rpc1JFMkFFbU5SNDAzeEx1NHozRTZG?=
 =?utf-8?B?Z29iblJJcFpoQ21oTk5iQXdIUU5ZbGI0RXdET0pKQjNXa05hS3FiUXFYeVZz?=
 =?utf-8?B?czZQY0NUQnc4TVpFM3N2U0RoRjBFZ0xwM24rV1UrU3RjcThmV3VFZFVpbXpp?=
 =?utf-8?B?Z0NoSmRsdHhQN2pCQXdtN0hMSzZYZjBQS1RyZndxUUpQMDJLVXVIZmxPc243?=
 =?utf-8?B?Nkx6OUJ4VmN3MnNXNDVUR2xmK2dhZ2NleXlYTFU0eXJreFdod0xBRzZOWE1m?=
 =?utf-8?B?ZXZ1MjlKN3BHc3p3N1dhYzNUL0daZGJYcGRBeGJXcG1HZnhDNUxRME51OU43?=
 =?utf-8?B?a1p1cUphVHVkODZGak50cHFTT1pFWXIyL0MrY1NQNzVyNGtpR0FIQUtzMW9P?=
 =?utf-8?B?aDZHTC8yYTYvKzZLNkU3R1d5VmZlMG4rVURTTkNQR1JDRkZGbFpOQ2ZjRXRW?=
 =?utf-8?B?QnFGSWIrbXp1WXdISlMzYjlZSHorYmFnUlNnUTJYUzR1bUFoMGZjVVd6QXRO?=
 =?utf-8?B?cXV5amVNTHg3SDJrYW9NTVVRVXhwR1NCVmozL3YvZFBNdEFibURXUFRjUmZG?=
 =?utf-8?B?M0Z0ZUMvcFptdDRkbzc3SjJjN3d0Vk9lb2xiTVZpQk1mY25NN21vcWlFeTU3?=
 =?utf-8?B?WFFNOWpLQ2cyb0dQc1YzTUlhV2FmUFBpVzdTZHUyeGt0MWZrUHFKUmxZOFJp?=
 =?utf-8?B?SVpWSHFvTUNLN1NvODMxQmUvc0txV05GRURqWThEY1pRVFlXTmVpNFNqcTA3?=
 =?utf-8?B?ek1XbEMrZldSM3o1UnpLbHNCUEZGc1d6NlJ6TkdPbkhLdEdRMDg5aWlzOUlj?=
 =?utf-8?B?S1NYM1ZDcUxvekZzb1Y5REc5azIrZDZBYUwwR3I5YjZxVTBSVjhBSWUrS05Z?=
 =?utf-8?B?c1RlNHVZMHpnT3RHclgvVEk4QXBmdjhxK25LbjNCUnRQVmliZExrNUFNN2lY?=
 =?utf-8?B?NUl0T3VXbWJaTUJ6NThUZXNJdjRWaUJhYnRaZ01ycXNkVDUvVnlFTFVkaEI4?=
 =?utf-8?B?YVpjajV6VHk2bkljbWpiaFhWdmloUy8xRCtiaHY4Y0tJK0w4dVVXSlFjaUhw?=
 =?utf-8?B?Z1JxZHcwVktWS0Q3bkc5SEMvbm11eGsyNHR5TUI4ZS8wTEVMdnFtUjZlSDVv?=
 =?utf-8?B?V2FUam1JQUpIdThlMVRtcFhQN0ZuWjBpOStRTGNINFZsYVBKNTNOZVNaaUdM?=
 =?utf-8?B?dHBkY3BxN0dtSFFUMUFDVFQyenFMa0wvcVN4RXBWOFQwdFlaVitvdjl0WFlJ?=
 =?utf-8?B?cGtzUUJKdmNta1pkSnl6WmYwWnhxT1JKYWY0V1J3TVV2RHE4bjdpbGJ1Wlhr?=
 =?utf-8?B?RkttZjhaT1NoSnR0dmhWamRnMXN5THVDVDU5V2RQaklLa0Z1c0lEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kA2TPAcCodkqop0wIPsgcVvazi5Ul0u/VfqN3nZzAAcIavB/QJlfEq8SyC9FRlvWG55CPctorC9gt5Si8NjJfNR8QEhBCjM97kJP5cvQJwLZpVMcgZSwQY5AsZz1WDqMpFpxgnJoUW2qyQaYs5dXpdE10isXy5//Iscokf7MQT3xlavCjXFnuPdAGK3s8c+PH8AtWpINcmJKCPx9w3W4bLfP2qWWohfUwgvNKq95stlBkSrTmCFE3FEjpMGv0OK1i3HigqSoU+QNw5KGbfFpXjQt+x6/vGtO7+shjs2panP1RFzYbDz4dMHpjR9sXiN7/P2vJb6cBYe7T6Z8+iVEpw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e805d1-5719-4565-04f9-08decc40c8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 07:19:35.3871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0CAc3Q3QOBUfcdJWRG6AaDpkDyRUFdYgVPQK7omkuaDq8wYIYu8YamvNUgE8eWOUE/Ym4lBGwG4hmrKLka1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bmUgMTIsIDIwMjYgOTo1OCBQTQ0KPiANCj4gT24gNi80LzIwMjYgMToxNSBQTSwgS2V2
aW4gVGlhbiB3cm90ZToNCj4gPg0KPiA+ICAgc3RhdGljIF9faW5pdCBpbnQgdGJvb3RfZm9yY2Vf
aW9tbXUodm9pZCkNCj4gPiAgIHsNCj4gPiAtCWlmICghdGJvb3RfZW5hYmxlZCgpKQ0KPiA+ICsJ
aWYgKCF0Ym9vdF9lbmFibGVkKCkgfHwgaW50ZWxfaW9tbXVfdGJvb3Rfbm9mb3JjZSkNCj4gDQo+
IEhtbSwgaXQgbG9va3MgYSBiaXQgc3RyYW5nZSBoZXJlLiBUaGUgY29yZSBkZXNpZ24gcGhpbG9z
b3BoeSBpcyB0aGF0IHRoZQ0KPiB0cnVzdGVkIGJvb3QgZW52aXJvbm1lbnQgdGFrZXMgcHJpb3Jp
dHkgb3ZlciB1c2VyIG9wdGlvbnMuIEhvd2V2ZXIsDQoNCnVzZXIgb3B0aW9ucyBoZXJlIHJlZmVy
IHRvICJpb21tdT1vZmYiIG9yICJpbnRlbF9pb21tdT1vZmYiIHdoaWNoDQpvcHRzIHRvIGVuYWJs
ZS9kaXNhYmxlIGlvbW11Lg0KDQo+IGNoZWNraW5nIGludGVsX2lvbW11X3Rib290X25vZm9yY2Ug
YXQgdGhlIHZlcnkgdG9wIG1lYW5zIGEgdXNlcg0KPiBvcHRpb24gKGludGVsX2lvbW11PXRib290
X25vZm9yY2UpIGlzIHN1Y2Nlc3NmdWxseSBvdmVycmlkaW5nIHRib290Lg0KDQpidXQgdGJvb3Rf
bm9mb3JjZSBpcyB0byBzcGVjaWZ5IHRoZSBmb3JjZW9uIHBvbGljeSBvbiB0Ym9vdC4gTm8gY29u
ZmxpY3QuDQoNCj4gDQo+IElzIHRoaXMgYW4gZXhjZXB0aW9uPyBJZiBzbywgaXQgbWlnaHQgYmUg
d29ydGggYWRkaW5nIGEgYnJpZWYgY29tbWVudA0KPiBjbGFyaWZ5aW5nIHdoeSBgdGJvb3Rfbm9m
b3JjZWAgaXMgYWxsb3dlZCB0byBieXBhc3MgdGhlIHByaW9yaXR5Pw0KDQpzbyB0aGlzIGlzIGly
cmVsZXZhbnQgdG8gdGhlIGVuYWJsZS9kaXNhYmxlIHByaW9yaXR5IHBhcnQuDQo=
