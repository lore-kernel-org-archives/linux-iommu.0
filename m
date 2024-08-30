Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA421D131F;
	Fri, 30 Aug 2024 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977806; cv=fail; b=dUFTzJQys2ZdH2GA2jp8iIHuB2quulqDcQw9UAhQa9H0ZMTqevjbVbNCsW/Pl7Z8hBjNrZKDhqb8Jl2qm4AtJNnRIIQKyIPcGA8lmOt4EXzawrMHjhcO8xAGLj6y5fKnL0aPY0MCq6sM9I2lWUIC5dX4V6BZIcDoopfKWj20rFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977806; c=relaxed/simple;
	bh=t4ZEFMf+odOHy2sT4cSn1+oLdGgQIX9wZl+j2GRawpo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sGQvh/DLYJSQmVggUerjfezqlkopHq778gVmpyIu0E7Mtl11O5fDLkxZThKdl3iZNQVsOJaA2WG6AqbOy/hQb+Oa5RMhSpjplHxrplrtxbI6y8Nw9eaicze7fD+MpR/3CIGyW38nKRLCZbTAmhtfkQBVWKRAohsXAwlQtWzpT+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXcGKA3l; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXcGKA3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724977804; x=1756513804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t4ZEFMf+odOHy2sT4cSn1+oLdGgQIX9wZl+j2GRawpo=;
  b=PXcGKA3lMHnTRzQxf7tEREAfyjZ+r7PAWSJ0lAUoxC18OSXkcdLANCvG
   kaqCu/OyKkK4UpRUtYwMzUoTOUuIEerVdgHwrjydBOy8/QTRSzD6cJRXn
   kTLtCxixZImx1ndfj1uEpT+0+vtLaWeVajxfYbbLyamy2/B9lkTPIOus8
   IMeZb9L9BCObJnctAgaHYgAjsQcxwN0TqnLqvlcYm9R9NqZJLGxNP722L
   0vsEzFrGzOCH/BVMWehzoGafAVpDcQ+EnnNKkRucILwqb5fPFhoE4VXA3
   SZWnQ0AdZcOovUMB3zngeEp7I4PtaxwsmfBysjVeMSY42oan8hQ7l6xLO
   w==;
X-CSE-ConnectionGUID: iT3hIf5zQpy2aGGx25QDUw==
X-CSE-MsgGUID: p64YQICNQlKio8boYz4fBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23763731"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="23763731"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 17:30:03 -0700
X-CSE-ConnectionGUID: 165e/x6RQN6JaYtjszkGow==
X-CSE-MsgGUID: Zq3R+0zhTmGGGU1OGszWSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="64477228"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 17:30:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 17:30:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 17:30:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 17:30:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 17:30:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxfVvZOKpHXrInt7IvJgY3t4vic8bjr/Uui7+MOzBjF49MXeU6ZIif/rcz5l2PL0q93z4vAJxH7T7KgwZLpj3w9QDvbATUrfEQ0yWGhLstYYUTO5Mr1C5MMjn6y3lXETwy7sKSbxU30tXIdXsV+H+Kf/Ja/qB4zkJ60ybh4fXkbem2PWf9X7yYoAA2jQbufUiy0+hLUM7D8yvCARaH7owuYqGkWEp5SHpqDHlihqVlnGJPXvnFiFXaLfwvb46U81ibc8fdoWD4K8gf+5imOa3sRSReTrhBGb5JsDLISlafeuFP3wfRh4umrnJzyamFS/IVknVCY26zFk4G5R0ceNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4ZEFMf+odOHy2sT4cSn1+oLdGgQIX9wZl+j2GRawpo=;
 b=xhi651En8s/Y43/8swSL9OX6f4adLDFgkGSUQ6Qe0guHfbagi7L5tTBtM02tVT2R8EkFIK7wmyG+W4CyzW0wCGMDolvZRddvfJkddGIjtMqIIxLTqPIMHnxvOdUCpFfHwG0KkHywT+A5syqMkuimzi1MwFoMnEeYi+K5cbRN00z1jPZxOUfb2iUd97ljA1CILHEI/JWx8BpHarxRjjIy7VDf8VLjWJCcrwzkS0zpjTjfrLigdPzWKqF/3bHp9luQb5zklhSoFsWtvk73cVYyxJv6PGPChr3V8+EQkr/q3mzaHFYaXZVafAKfEqn0AXVbmTrK+S63vA7rj7MK5tTjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7336.namprd11.prod.outlook.com (2603:10b6:8:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 00:29:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 00:29:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Markus Rathgeb <maggu2810@gmail.com>
CC: Linux regressions mailing list <regressions@lists.linux.dev>, Lu Baolu
	<baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>, David Woodhouse
	<dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML
	<linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Adam Williamson <awilliam@redhat.com>
Subject: RE: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
Thread-Topic: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
Thread-Index: AQHa+TT2MgK5ERDS1Ey44fCKLWFprbI9Z5sAgABdTgCAAA0fAIAABD8AgAATpwCAAQqgwA==
Date: Fri, 30 Aug 2024 00:29:51 +0000
Message-ID: <BN9PR11MB5276F533DC882B182F1A4C268C972@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
 <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com>
 <CAOcK=CPi1TokgySF77X+zuQ10kxfsfCXekYVanPhF51+Ow1XRg@mail.gmail.com>
 <CAOcK=CM4Poawy2AN3f6C2ooPdoT=dg4J9Bg1Fu=gsFjvkrBpQw@mail.gmail.com>
 <CAOcK=COEd0njBPGhJ8idaLbaqvATr_zSB1O9dyzwi+fbU8GhqA@mail.gmail.com>
In-Reply-To: <CAOcK=COEd0njBPGhJ8idaLbaqvATr_zSB1O9dyzwi+fbU8GhqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7336:EE_
x-ms-office365-filtering-correlation-id: 34a80e24-8a00-4238-fe28-08dcc88add14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d1J1MWU2NWMzc0hFVXZjQ0FJMFFGMFI1bE8zN3MwNjJJdEx6V25pajh5L2to?=
 =?utf-8?B?TS9zUStsT3BQMnNpaytObE8rMjNPWUxucTRkRHhLaU8zQUZUeEt3bHFJNUl2?=
 =?utf-8?B?U1RiVjR6azZpOFJwbFRDUlpKZkpIUTNFTDRVRi9wNjRVMFJxNlo3bG9ETkpJ?=
 =?utf-8?B?dm9XODYwWDRIOVlxenIzcnhXbWduLzRQZGF0V3F2S1hnNUVtWWhDTEErT2Zm?=
 =?utf-8?B?ZXhLNU9XY0xreGVvbmt6b201RGJJQnEwNWRhbWZzYU4yR1lKK0xyUG4zNG42?=
 =?utf-8?B?UkFqa05GTnEvdTFZMGF1dDJZbDRqTUVyejVzQXhJeGRLMTdYYU1KNVZ0bmlR?=
 =?utf-8?B?YStWUnN5aEVveTZFRjRnMVFpQ0tIaVMwc2U1Y2pOblM4OUMwalA0OXA0ekxp?=
 =?utf-8?B?NUNVQWZyVEdUVlljTFVpVE9LN3hsYlhnUXRUL1J4QlArY29UWWszTElrVHpC?=
 =?utf-8?B?L2c1U0JmVFA2WmtYSWNINVVFbVlyUE8zaWxRYXJNeTkzcnJKZlJZdGd2Y05a?=
 =?utf-8?B?SXJTcHNERDZKMFFrTTlzTlBzUTVyTWdaWEJIWEVYMDdMOERBMTdIMkxwSnli?=
 =?utf-8?B?YUhxTkF0UmJMdDV0djhINlk1aVpYaXhZZkx1NFA3d2RoQU5pN2RnM0tYK3ZX?=
 =?utf-8?B?dmlBdDdwMWdvc3dueDZYM0ZIb3MrcXE5bzJ0S3EySnJUandySDVNUmFqMDlF?=
 =?utf-8?B?bncvallGYkVYa2xZSHAreHAyU3hUWkY5aXJ6WWJEaG13Q2RGTEF0b0hVdzJY?=
 =?utf-8?B?RnAreTgyMEcxcENuV3lTdjRtdmJWWmxtU1lLb0tKWWJWMExLZWw5NERvc0NT?=
 =?utf-8?B?YXp6WWNpdzZweFFsQUZ5akIwYnFDNFRrN0loTDBMNnNzdUJtSkt4Z1R6WGNx?=
 =?utf-8?B?clYvRUV0M0RzRG94aTNmWTNqUXpJTmtSMGYwVVZXdHl5RExVeldBVUt1Ym1j?=
 =?utf-8?B?dG9IeVE0eXZqQzdVOENOejN0dXNhajVvanVKNktKeHJyZ0o3MGVpSjV6T0tZ?=
 =?utf-8?B?VU9iSFNzMC9lRi9QT3ZOank1L3RoaFFSNDBGRXYwY1BudVg5bHpXNWo3OVI4?=
 =?utf-8?B?ZzFNODF3WCs5WFB0NzhnVG5TSHJiVXMwdGhJNlVRallKRUI3RzFJRll0ZjRK?=
 =?utf-8?B?eFpIS3FVWHh6MjFBZk9mZHFEbVY5Z2wyZUJwT0R5QlgwVHVLdEtUL0JkTVVX?=
 =?utf-8?B?Z0tTNC8wTzVvTHlVSkE2OFM2ZWNPZUJzRCtMdEE2YTA3U3pQbWt3NnZvdFpn?=
 =?utf-8?B?b1BBekYyeHpYdUJmWFBSY21WUks4ZGxzMDRwKzVrVnRlNm92ZHRjMWh5d2hV?=
 =?utf-8?B?RVJ3Vm10WHlYeE5BRFYyK1FkWXF4Mm5sc1EyY3FvSjhWRXprTExtNnZzMHBF?=
 =?utf-8?B?alZpWnFQK0xTSGo1QU5SUVBuVEtzejk5c3lQR29GVGlGY25ZT01QVEJCQjI1?=
 =?utf-8?B?Vk9JL2k2dU51ZGoxTHBQSDY3Tm05YUd5K3Q2QXZvWGM4WDVKU015RmE0N09V?=
 =?utf-8?B?V2VqWFpySUVkTmZjRG1nWFdDWG13alB1bDZHVkQ1OENSRTVaU1Z0d0hpKzJx?=
 =?utf-8?B?TjllTWJ1Yk9qT3RibVBFYlJoUEpnVUQ5SmFjMWFGQXhvTnVLc0xNTzhlWWNL?=
 =?utf-8?B?d0RwcUFNTWJzZE1qMlBDYTEwL3l0aEVnVmNjRHloaHNUbmxiMzlxOVB0Qno0?=
 =?utf-8?B?RmFnM3lFTE14UktUb3RZcDlSS2lya0NtSnA3NGxmMWViRHBiMHBkQi9FRDMv?=
 =?utf-8?B?bjRWNTJPVlo4NVo4eWNzTjN3c2ZRV2NSWDdkK1hMT2kzNUQzN3lVMmNhYVE1?=
 =?utf-8?B?Nm1rS1F0d2NuWFBNcWtlbkdDbWlCajJ1OCs2KzBjNnprOGN0Y251blB1S0RN?=
 =?utf-8?B?TzlBdi80WklXWjVsRVRlSzVNM2dGUldtYlk0MmtUTUtaa2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0RWaS9KTjJGTDBnMmpicmcwWTc5TTBOQXY1YnBqKzFXMm9JR04xK1ZHcElu?=
 =?utf-8?B?a3F2dmRXdEpFQ1Bhb2N4TURTUnorVFFZdk1FZ1kwQ056d2paL0pzRFVRbDJU?=
 =?utf-8?B?dlJ6OW02dTNZM3R6akRrc2FGc2J0d0haY0NhNlpSZ0FraVdOVXFvVHBvcEFN?=
 =?utf-8?B?K2k0TnpwUnQ0RFViUlQ1RjNOOVNmTXhUbzRMOW45ZCtaZ2lhblB3TE9oSExI?=
 =?utf-8?B?TjkxbTJJTllES3ZiVG1lY0RrdUZ4dFlocUM3T0ZQVTI4S0xTbG1lZVVPbVJt?=
 =?utf-8?B?K1M3anZvcmFmZC9TTzBodm5hYXFuMmgvcDExbHdtblhrUDV1UHVSejk3eWNk?=
 =?utf-8?B?Yjk1L0x2S0ZobDVLNzdUNnJSUzN2TzhRSDJ3MVhqTDI0a2k1Tko0THRGYmli?=
 =?utf-8?B?bVkySUVFVkN5MUdGcUowd0ZCUEl2U0JvU0VYL2ZUcnFYR1J2YmszR2Nld3hH?=
 =?utf-8?B?d1dCenRMaTlLVUJiZ1g4V2dQUFMrRnd5dEF5NlpIdk0ybjdHWmRZNTlDc2JU?=
 =?utf-8?B?MUlkNDdoTDNiK2Y1clhveUlTZUhaOHZ4ZGxwNmErTnZUb09jSmJzckcweEly?=
 =?utf-8?B?T05JeVRzRHBkVEVIS1JIVWY3YTlUdE1uUHVVRGkvbFVWbmR0QmpuMmVBeG5U?=
 =?utf-8?B?cnlxMDV2OVdwWllFSjBFMGlEazVZckc5ME9mL0VRL2c5STVtYSswTXZBMlc0?=
 =?utf-8?B?WU9NaUkrN3cwZDNXMmFMWUpib01OUGFjd0NSYmhYelRJNTBoNjZOWDJxa3JW?=
 =?utf-8?B?S2ZJYXJOUDQyMzMwMlRZMS9xdUZBdG9keUtXRElseStrdE1pUlVoaUdja0ph?=
 =?utf-8?B?VGEyRkYrYjNERHdsQy9OaXBaTjJtU1dSRHNzQmV2MlJkRDBJVWFsRnMvSFo4?=
 =?utf-8?B?VDQwRHp5LzB6LzdnMDB5OUpQZ0txMjdaZjFaek5hODZIdTF4T1ZRTlI1aXd6?=
 =?utf-8?B?MEMrK3FTNkJYUmVmR3kxWnl0REdFK3F5U3NvODM0VC84ZisxK2t2c2JmVEFx?=
 =?utf-8?B?QkFzNkNSaVJkZmpMM3MybWk1K2svT1ZQY2tob2cwZTZlckxscG9senJlbFlG?=
 =?utf-8?B?WGtQTmtOS1FTS0Voc2hSRTlRbmZEZDA5NTZTQ25vTTJLbGxGbXFLZUdsRC9m?=
 =?utf-8?B?RUY1bFp6NzdtUkI4bWtWU29TUTRXVkd0Wi9jMlBoOXRkWnJrdkUyNWVuelpS?=
 =?utf-8?B?ejhONEtiWTVqZFNaMWdlZ2dRRGJjcm91SkZqalpOSmVWSThDZHVvY0NHYXFp?=
 =?utf-8?B?bFRpWkFHeXo1cXJuc2wwN2RRSkpyY2pOVnlSaXFmRlZmRllQSi9KZkU1Qndh?=
 =?utf-8?B?MktIZG5KZ3B0TEpNWUhyS05OVWtKUkdyWnFLRllZdGpYdHRZemdUZlJWZnlW?=
 =?utf-8?B?aXlVSGdxdmhyUHZJL3JwVmJneC9jRGJHUStybFVZV2JmODJKb3hpNFplUzVW?=
 =?utf-8?B?SnZsb2hmT0k1dGdkdERqeHBUQ09kcmM3Ky9SODM4cGdTYk1paUs0aHFIWDkr?=
 =?utf-8?B?VjhmR05OSE5FY3YzQmRMYVQzcGtZaDFDT2o5WjlrTWRab0h3TVQ3K3cyb3ly?=
 =?utf-8?B?Ym5KQTVTUEJSQXFVVXlsVVE4WVFST3FKckwzWVAxUTRaZ0NFdUJGeHF5T243?=
 =?utf-8?B?Vmtld0UrbEhTeHN0bUxLeGVEUlNaZkVaamxvSUl5WG9GSTB0QzFpVExPOEFE?=
 =?utf-8?B?VjdJUGxyeUoySitwMTkwN2FxSFpISkt6MndzVW40YUk1K2preHd4YmRFdUNY?=
 =?utf-8?B?QmZUMnlCbVd1ZldXTGZwM29tOVBMY0pyaWJxOFl3WDJVQnpJNjlVQi9oRkx2?=
 =?utf-8?B?d2N2WWMxL0ZVTElQV1VHbCtCZG0yUU92NTZZWXNWY2JkaHlYcUt1UGRtQk5T?=
 =?utf-8?B?d2ZEOCtnS2RSRGJlSnBYS0ZMbFkzcXNQcFV6eTh4bENzTUpaNWlHK1pvWFN1?=
 =?utf-8?B?UUtGWCsvWG5PVHRCamZGcW0rUFBMUTRzQ3hpMUh5KzRPeHV2UTJkc0lGUlQ3?=
 =?utf-8?B?SXAzcTZ1VExNUWZRUDRTQzc0SkpGM3AzRkJxaUZyL2VtcFgydGlVc3RQb09W?=
 =?utf-8?B?SjNLOC9DYXlSRWtEazFjMVFJajUzS0drV29zTStqRjR1cFZCMlJaRjdNdVo3?=
 =?utf-8?Q?AVieJbg5GCH78vdY3L7DJRIAL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a80e24-8a00-4238-fe28-08dcc88add14
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 00:29:51.9339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nm4AwCxO7otgXGaSMc4nw/0sLNDBwtkVUgQTISBoT2B5s+TkQyMRvR8ubOUkkIQJLFSjrZwy3WDDXRBQfqLO2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7336
X-OriginatorOrg: intel.com

PiBGcm9tOiBNYXJrdXMgUmF0aGdlYiA8bWFnZ3UyODEwQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCAyOSwgMjAyNCA0OjM0IFBNDQo+IA0KPiBXaXRoIHJlc3BlY3QgdG8gbXkg
cHJldmlvdXMgY29tbWVudCBJIHRlc3RlZCB0byBmaXggaXQgbXlzZWxmIChJIGFtDQo+IG5vdCBh
IGtlcm5lbCBoYWNrZXIgYW5kIGRvIG5vdCBrbm93IGFueXRoaW5nIGFib3V0IGlvbW11IGV0Yy4p
Lg0KPiANCj4gQWZ0ZXIgYXBwbHlpbmcgdGhlIGZvbGxvd2luZyBjaGFuZ2UgdG8gdGhlIHY2LjEx
LXJjNSBpdCBzZWVtcyB0byBmaXggbXkNCj4gcHJvYmxlbS4NCj4gSSBjYW4gY29ubmVjdCwgZGlz
Y29ubmVjdCBhbmQgY29ubmVjdCB0aGUgZG9jayBhbmQgVVNCIGlzIHdvcmtpbmcgYW5kDQo+IG5v
IERNQVIgZXJyb3IuDQo+IA0KDQphcyBzYWlkIHRoZXJlIHdhcyBhbHJlYWR5IGEgZml4IHBvc3Rl
ZCB3aGljaCBpcyBzaW1pbGFyIHRvIGJlbG93Og0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1pb21tdS8yMDI0MDgxNTEyNDg1Ny43MDAzOC0xLWJhb2x1Lmx1QGxpbnV4LmludGVsLmNv
bS8NCg0KPiANCj4gDQo+IA0KPiBGcm9tIDVmNjIxYzA3OWYwZjhiY2U5ODk1YWUwNWE5Y2Q4MWIw
MDFhNTgwODkgTW9uIFNlcCAxNyAwMDowMDowMA0KPiAyMDAxDQo+IEZyb206IE1hcmt1cyBSYXRo
Z2ViIDxtYWdndTI4MTBAZ21haWwuY29tPg0KPiBEYXRlOiBUaHUsIDI5IEF1ZyAyMDI0IDA5OjM3
OjE3ICswMjAwDQo+IFN1YmplY3Q6IFtQQVRDSF0gZml4OiBpb21tdS92dC1kOiBBZGQgaGVscGVy
IHRvIGZsdXNoIGNhY2hlcyBmb3IgY29udGV4dA0KPiAgY2hhbmdlDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXJrdXMgUmF0aGdlYiA8bWFnZ3UyODEwQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCA3ICsrKysrLS0NCj4gIGRyaXZlcnMvaW9tbXUvaW50
ZWwvaW9tbXUuaCB8IDMgKystDQo+ICBkcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMgfCA0ICsr
LS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMv
aW9tbXUvaW50ZWwvaW9tbXUuYw0KPiBpbmRleCA5ZmY4YjgzYzE5YTMuLmU5MmUwNmU2MDRiMiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiBAQCAtMTk0NCw2ICsxOTQ0LDcgQEAgc3RhdGljIHZv
aWQgZG9tYWluX2NvbnRleHRfY2xlYXJfb25lKHN0cnVjdA0KPiBkZXZpY2VfZG9tYWluX2luZm8g
KmluZm8sIHU4IGJ1cywgdTgNCj4gIHsNCj4gICAgICBzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11
ID0gaW5mby0+aW9tbXU7DQo+ICAgICAgc3RydWN0IGNvbnRleHRfZW50cnkgKmNvbnRleHQ7DQo+
ICsgICAgdTE2IGRpZF9vbGQ7DQo+IA0KPiAgICAgIHNwaW5fbG9jaygmaW9tbXUtPmxvY2spOw0K
PiAgICAgIGNvbnRleHQgPSBpb21tdV9jb250ZXh0X2FkZHIoaW9tbXUsIGJ1cywgZGV2Zm4sIDAp
Ow0KPiBAQCAtMTk1MiwxMCArMTk1MywxMiBAQCBzdGF0aWMgdm9pZCBkb21haW5fY29udGV4dF9j
bGVhcl9vbmUoc3RydWN0DQo+IGRldmljZV9kb21haW5faW5mbyAqaW5mbywgdTggYnVzLCB1OA0K
PiAgICAgICAgICByZXR1cm47DQo+ICAgICAgfQ0KPiANCj4gKyAgICBkaWRfb2xkID0gY29udGV4
dF9kb21haW5faWQoY29udGV4dCk7DQo+ICsNCj4gICAgICBjb250ZXh0X2NsZWFyX2VudHJ5KGNv
bnRleHQpOw0KPiAgICAgIF9faW9tbXVfZmx1c2hfY2FjaGUoaW9tbXUsIGNvbnRleHQsIHNpemVv
ZigqY29udGV4dCkpOw0KPiAgICAgIHNwaW5fdW5sb2NrKCZpb21tdS0+bG9jayk7DQo+IC0gICAg
aW50ZWxfY29udGV4dF9mbHVzaF9wcmVzZW50KGluZm8sIGNvbnRleHQsIHRydWUpOw0KPiArICAg
IGludGVsX2NvbnRleHRfZmx1c2hfcHJlc2VudChpbmZvLCBjb250ZXh0LCBkaWRfb2xkLCB0cnVl
KTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW50IGRvbWFpbl9zZXR1cF9maXJzdF9sZXZlbChzdHJ1
Y3QgaW50ZWxfaW9tbXUgKmlvbW11LA0KPiBAQCAtNDI2OSw3ICs0MjcyLDcgQEAgc3RhdGljIGlu
dCBjb250ZXh0X2ZsaXBfcHJpKHN0cnVjdA0KPiBkZXZpY2VfZG9tYWluX2luZm8gKmluZm8sIGJv
b2wgZW5hYmxlKQ0KPiANCj4gICAgICBpZiAoIWVjYXBfY29oZXJlbnQoaW9tbXUtPmVjYXApKQ0K
PiAgICAgICAgICBjbGZsdXNoX2NhY2hlX3JhbmdlKGNvbnRleHQsIHNpemVvZigqY29udGV4dCkp
Ow0KPiAtICAgIGludGVsX2NvbnRleHRfZmx1c2hfcHJlc2VudChpbmZvLCBjb250ZXh0LCB0cnVl
KTsNCj4gKyAgICBpbnRlbF9jb250ZXh0X2ZsdXNoX3ByZXNlbnQoaW5mbywgY29udGV4dCwNCj4g
Y29udGV4dF9kb21haW5faWQoY29udGV4dCksIHRydWUpOw0KPiAgICAgIHNwaW5fdW5sb2NrKCZp
b21tdS0+bG9jayk7DQo+IA0KPiAgICAgIHJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9pbnRlbC9pb21tdS5oIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oDQo+IGlu
ZGV4IGI2N2MxNGRhMTI0MC4uMGE0Y2U5OGZhYTYwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmgNCj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oDQo+
IEBAIC05ODgsNyArOTg4LDcgQEAgc3RhdGljIGlubGluZSBpbnQgY29udGV4dF9kb21haW5faWQo
c3RydWN0DQo+IGNvbnRleHRfZW50cnkgKmMpDQo+ICAgICAgcmV0dXJuKChjLT5oaSA+PiA4KSAm
IDB4ZmZmZik7DQo+ICB9DQo+IA0KPiAtc3RhdGljIGlubGluZSB2b2lkIGNvbnRleHRfY2xlYXJf
ZW50cnkoc3RydWN0IGNvbnRleHRfZW50cnkgKmNvbnRleHQpDQo+ICtzdGF0aWMgaW5saW5lIHZv
aWQgICAgIGNvbnRleHRfY2xlYXJfZW50cnkoc3RydWN0IGNvbnRleHRfZW50cnkgKmNvbnRleHQp
DQo+ICB7DQo+ICAgICAgY29udGV4dC0+bG8gPSAwOw0KPiAgICAgIGNvbnRleHQtPmhpID0gMDsN
Cj4gQEAgLTExNTQsNiArMTE1NCw3IEBAIHZvaWQgY2FjaGVfdGFnX2ZsdXNoX3JhbmdlX25wKHN0
cnVjdA0KPiBkbWFyX2RvbWFpbg0KPiAqZG9tYWluLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiAN
Cj4gIHZvaWQgaW50ZWxfY29udGV4dF9mbHVzaF9wcmVzZW50KHN0cnVjdCBkZXZpY2VfZG9tYWlu
X2luZm8gKmluZm8sDQo+ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBjb250ZXh0X2VudHJ5ICpj
b250ZXh0LA0KPiArICAgICAgICAgICAgICAgICB1MTYgZGlkLA0KPiAgICAgICAgICAgICAgICAg
ICBib29sIGFmZmVjdF9kb21haW5zKTsNCj4gDQo+ICAjaWZkZWYgQ09ORklHX0lOVEVMX0lPTU1V
X1NWTQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jIGIvZHJpdmVy
cy9pb21tdS9pbnRlbC9wYXNpZC5jDQo+IGluZGV4IDU3OTJjODE3Y2VmYS4uY2I0YmJiNDVhYzJh
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMNCj4gKysrIGIvZHJp
dmVycy9pb21tdS9pbnRlbC9wYXNpZC5jDQo+IEBAIC02OTQsNyArNjk0LDcgQEAgc3RhdGljIHZv
aWQgZGV2aWNlX3Bhc2lkX3RhYmxlX3RlYXJkb3duKHN0cnVjdA0KPiBkZXZpY2UgKmRldiwgdTgg
YnVzLCB1OCBkZXZmbikNCj4gICAgICBjb250ZXh0X2NsZWFyX2VudHJ5KGNvbnRleHQpOw0KPiAg
ICAgIF9faW9tbXVfZmx1c2hfY2FjaGUoaW9tbXUsIGNvbnRleHQsIHNpemVvZigqY29udGV4dCkp
Ow0KPiAgICAgIHNwaW5fdW5sb2NrKCZpb21tdS0+bG9jayk7DQo+IC0gICAgaW50ZWxfY29udGV4
dF9mbHVzaF9wcmVzZW50KGluZm8sIGNvbnRleHQsIGZhbHNlKTsNCj4gKyAgICBpbnRlbF9jb250
ZXh0X2ZsdXNoX3ByZXNlbnQoaW5mbywgY29udGV4dCwNCj4gY29udGV4dF9kb21haW5faWQoY29u
dGV4dCksIGZhbHNlKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW50IHBjaV9wYXNpZF90YWJsZV90
ZWFyZG93bihzdHJ1Y3QgcGNpX2RldiAqcGRldiwgdTE2IGFsaWFzLA0KPiB2b2lkICpkYXRhKQ0K
PiBAQCAtODg1LDEwICs4ODUsMTAgQEAgc3RhdGljIHZvaWQgX19jb250ZXh0X2ZsdXNoX2Rldl9p
b3RsYihzdHJ1Y3QNCj4gZGV2aWNlX2RvbWFpbl9pbmZvICppbmZvKQ0KPiAgICovDQo+ICB2b2lk
IGludGVsX2NvbnRleHRfZmx1c2hfcHJlc2VudChzdHJ1Y3QgZGV2aWNlX2RvbWFpbl9pbmZvICpp
bmZvLA0KPiAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgY29udGV4dF9lbnRyeSAqY29udGV4dCwN
Cj4gKyAgICAgICAgICAgICAgICAgdTE2IGRpZCwNCj4gICAgICAgICAgICAgICAgICAgYm9vbCBm
bHVzaF9kb21haW5zKQ0KPiAgew0KPiAgICAgIHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUgPSBp
bmZvLT5pb21tdTsNCj4gLSAgICB1MTYgZGlkID0gY29udGV4dF9kb21haW5faWQoY29udGV4dCk7
DQo+ICAgICAgc3RydWN0IHBhc2lkX2VudHJ5ICpwdGU7DQo+ICAgICAgaW50IGk7DQo+IA0KPiAt
LQ0KPiAyLjQ2LjANCg==
