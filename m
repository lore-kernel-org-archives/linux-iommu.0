Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97CB3B19C4
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680639; cv=fail; b=OhIvKXUT9ztaVOV1zPrcRoxAJnZ5k9UAzjLuSaH3rf9uML7uD8CQOBYV0W24LSlNZiwu9yTmeMa1TKULgswKhpjR33iSkhlOxpHOmZfszASG9zmEKwV7hHG6MBB4VB2sibaDqVvoYJBdCAuErT/h6roeLl/MxLyNPsvE9JRmRdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680639; c=relaxed/simple;
	bh=T5qDjFHaSGhltiAxrq5ZLTLosKmpbV6BdvT5iYjaftI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=apUxlC7CZFJDTmJenbL3rY59fY6Go28UitaWhtM2lsuL6LUYQLULz71aJTRSSwDT8GmuhZP9mpuhC/EivrOZxB3UXXbhUZvZHRTPLQxy9ie6W+bo3vOgJtFqZgkOHxabxC68m2F/KFf3zyqoDEAWi1ijesnvRB+Bp86IVbL3qvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JTAahHk3; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JTAahHk3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781680638; x=1813216638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T5qDjFHaSGhltiAxrq5ZLTLosKmpbV6BdvT5iYjaftI=;
  b=JTAahHk3ZzR/gmyeMXdofkMSTFO/+dRJefE48+czXjUajxZqRpHYUby7
   yi6iC9e8O+dKJuWKMAmbES+szQULGjvuZOCniL7Jl3DDrRMwWfDsLkbue
   ghPW5KYKFtgnokO2WKxeNs122fi5GdmPne7K76OmpSVnCfNJHj4lRPwoY
   4Q0DldomO9t2QdRkQjyVtnm6H+f7uUYcc3bbSf3DyGgalHoN58XWu7kGa
   2bINho0txXWGvbhJkz5fAmweBdN2X5egWeCXpTh4fZZqnF8PDvzg2cRLb
   KDTA7kob7Pra6yB4/hE0VHpBZSRbWB7+wlXG/5UVt3Jz8Jdd+/AUfa5tR
   Q==;
X-CSE-ConnectionGUID: VMCC9CAhTdmrcezcMlmS3w==
X-CSE-MsgGUID: J0SUJ05uT2Kx76YBrGFm6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82475267"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82475267"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:17:16 -0700
X-CSE-ConnectionGUID: 4J0JFOB1TSarLcPVfQMWjA==
X-CSE-MsgGUID: ZKyzObIiT2KRNv+ZUALwGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="249896257"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:17:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:17:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 00:17:15 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.23)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRfXtoZl7cVIH3+LC4ZONofo/jzswofb8UxuXOD2HuX4F7E9qh8orJDnbmYC7d9TE0QO+bIdDcG46yAQwMMXgs5K2p0pA8GmpPDmmkysDtPDvu3No5ZVeqNwv46WGvbla+eijQokFyrpmVknULZtE6smdD6eGP040tiZCj0qKbRc25VxzfK68dTC8DUnXzGymaszHVgJh/DtBnl7dzYGsOgzhV0Z6yETPQvfPGhQLcL8DjSpjc8zgPM/HPkwmLpaw8HRa9SCOS8TDKq8OY5Mxra/IEwUs487rCeeob0Iv+Mx/Gp4V7rmUtorsZemDStuiE8SRCIcnmDgrz34AZJIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5qDjFHaSGhltiAxrq5ZLTLosKmpbV6BdvT5iYjaftI=;
 b=g1Gbf7wBbvMKZPRqeXgSGYIKKFg3nrvEvF7KeDcE4CKUfrziPUWZinI2DFw3duGE24R3YQ/qypsRVX6Yf6/eI89KQR2ozbc1EbbLjDfknBipLDcU9si8zsm5eiOnee7dJT2o/dJwBhtPkL8JEbbWh294vXwzVmu9R0JxkoBn3lwbrUB16X/yMKvxVT41oC8xGxxUhcyqaxkVVaL/lUqvuztfrP5hTtnXlCAUxHVPgDTFo+3UfWtwew2L0UYNwN17FlQL9iOpyr7ELmO2jfsD6gn1a/oHtdVb26xbv7nX/GE3n4Qf38Y4rnABXD2ClJ0PXwNPe/DVwLktBgjiPNK5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:17:13 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:17:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Joerg Roedel <jroedel@suse.de>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, "Chris
 Wright" <chrisw@sous-sol.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/9] iommu/vt-d: Use dmar_can_force_on() for platform
 optin
Thread-Topic: [PATCH 5/9] iommu/vt-d: Use dmar_can_force_on() for platform
 optin
Thread-Index: AQHc89/s8gQ1ixU9mUSRE3iAOvNI1rY686eAgAd2jIA=
Date: Wed, 17 Jun 2026 07:17:13 +0000
Message-ID: <DM6PR11MB3690FFF38878EE5B7D29E4EE8CE42@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-6-kevin.tian@intel.com>
 <6832298a-0d2d-4d45-92c6-b1e081b73cf1@linux.intel.com>
In-Reply-To: <6832298a-0d2d-4d45-92c6-b1e081b73cf1@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|MW4PR11MB5891:EE_
x-ms-office365-filtering-correlation-id: fead5971-292a-445f-d4a0-08decc407423
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: ztPqkZ5l0sRhPDXVdfO4qoLaot+zho4gIcDPaM+PLoshetYInLgzBHeUo1XH+nqZ6kIABU8sWaF6Fe/t4QPsTHuFck2AdSAY09KlGPGcA/pCS5aMwwwNZsblqqJJzlVodbI8cPsxBgfpGPEaHWBLCT+Eh4aM7IETuyg+EYZOY5vojhyOO+PoS76hqwql7xfnrpFwzmwbz5VQG0unXFmYYvr4eM1z0wrJRMSEkTKG9oqmGJ2IuX7p4177E/RE0sYwFOVyV+w805mViiL9bYec1azr2YWFMWa8wH/PDO+L03lMyXHjKPqqdv4D2Ku5fSN+JFqm5BXjNX7URNdmmW9FLugFjQB24EV9mfIDVCKH0t7wSJ1V6oULJCCdlVdewwimJVX9WYFDxrWltWYo0uNMkKwED678Y6FxCHPxGzvXPO37JuRbHVIbwV+Xzuzx0hsEavX5SIx/GYjtGj/GJNsxSA/WtLEkQsZhu8XIrHjtDgGCXp86yGk70B6rOwzlOAXT5sS1PkoZ1UERQBbTluc9BhE0k5kcnBnlu5OeyTskm519cLGUVP9TeobGdDcqFQ3c6HzFuFbbAi+bP/rJVak1tNAlIxv+DtRrSrml8M04WcTNKbuE31CR6vIsGniqIoq9N0921JsN4tvdXOsWvWtwO8zXEn8g8bAT/oeNEuzPnXe0FIVt8BTPgvfQxEoUycsnLl4oJrue9+mcipmRV+Z/K7xR+2lcj6/xAbCVU6ium511V4NJ5n+310Gcv63XPL/n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEpNeWdYUmkwcWE5UXJoZEtBQkhjQjdTMVYvTXcvNWZlRFVjL29oajZGUmxh?=
 =?utf-8?B?ZTIwaVFMSllJbldKeHEvaVZYMUpxcDU0WERaNmhkU2hVZENKMW5MSkxrTU00?=
 =?utf-8?B?a1ZhZ3FFS2FlT295UFN4dEdjeUNmdU43c3N4M2xkeU1rQTB6WUNPcHhzeVhJ?=
 =?utf-8?B?V2RVQ3Nxd3g5NEs4SzBqOGtaQVFiYkhpQUhxWmlqWnh1ZkpXeG9vN2FxYS9Y?=
 =?utf-8?B?MEFrdUxkVkxwWkZSY1FSeXdDOVJWdFpUQmcrMlNhZ0NTT1VXZXNEYUxUM01n?=
 =?utf-8?B?WGpyY1JtOHJDbkhjaHVhbE9GK3ZoTFBzMjRydzRrbVBvak5lZ2lQbnRIRDRr?=
 =?utf-8?B?MnhkNTF5U2JIUVl0YUhlQndCQmJ0N0lEMUdONE1jYXJ5dFVqY0U5KzQ4ME9W?=
 =?utf-8?B?NTdJaTFQdUxmRHFoZzgrbUNxWm5OS09Ld0xkMitqeU1uZURUeFduZjQ4Mkxs?=
 =?utf-8?B?Si84L2NpUmMyOXRXSEg4cVBIT1k0Y0JRZTdKaWR2VitYWU1UVUxBZUN5MklZ?=
 =?utf-8?B?ZHducFVJZnVJWlh0MkdTYWZEczUxVUZ4WVBEOFhnSWtBelI3WFRDWXdKV29y?=
 =?utf-8?B?bUxleXA2WlU0eElvaEdBbDd6UWtnL01VUkh4QnYwYVF5eCszb29xTnNoeE9s?=
 =?utf-8?B?bEZ3MnZ3OWNWU29TL3hoeTZOTDVBVSsrRjdqanVJZ2NjaTdtVkQ4aHhYZjZW?=
 =?utf-8?B?RkdXWkwxRlBrRXFsYk9MMmhUcFBxL3JUUDN1M1NKdldiV0RNRkRYZ0wyN2Vu?=
 =?utf-8?B?cXZNSUQwNFZOb0MweEU1a2t6U3kveW5rR09QQUszVEoxcVphQkNqbnhQclJs?=
 =?utf-8?B?OURSczRiY1hvWFFQbmpVcVRSVW9RZjFTR2lyMTBSZlNtQU1jZVZnMHJDb2NF?=
 =?utf-8?B?TUlQdk9zOVhEalFkMVZVMG9lRnY4UE1scHlBbzRTNEh1VnZYaGRBRU8wR2xr?=
 =?utf-8?B?Vk0vb21UTzFZM1orQ09GUHNZNDhPd0hTVzhkMUN4TThUTTMyVUYvMmIvWEg3?=
 =?utf-8?B?SW1pOGNyZ1dLOWFDTU1ldnhQVnVnSlZ6RkVKWUkydGZyaUxndVRLNGRVOXk2?=
 =?utf-8?B?YXBSTE4vSGdXUzNZNGRzY3VDQldzSzFMdSt4anZPb3NURDNYUW1UV1hFay9J?=
 =?utf-8?B?UDk4QkF5NVRqRG1KMnlKM3JnSStSRzNpVGFwSFJ0ZUJtM3lxM0QzYjNpeGZB?=
 =?utf-8?B?YWlTS1V2Qm85akxETVJORFZmVGIwaGgwRzlOSDhIa0xhc3pQaTRmNFlYUkFQ?=
 =?utf-8?B?aVNPU0c0MzRkbGhvYmwvL21uangzYm1tOGVnWkVkN29RTkhJQzNXWWwrYktE?=
 =?utf-8?B?dElWdHlPak9UdEhWK3JYUGFlNk9KYkVScDJlWTRtZ0I1RnF5bWVHbk1Dd0ZB?=
 =?utf-8?B?alJNeXNqakNHUDErNDQ5MzFVL0VJTFd2RkQzSkpLT0FoR0NZT2JUYVdkNDhM?=
 =?utf-8?B?cnIvS2g5SWw1Y2dvZ25aR0tweFp6Sk9jTFBQcEpwVzJtTTM5dXkyTnhqVWhj?=
 =?utf-8?B?TWpUTTY2NkZ5ZE1Ka2RUTG1ablRUMUJLZnJJbnRtMWV1UHZ2dGQyc0lSWGRB?=
 =?utf-8?B?eGk0WVdrQ2VMT0Vpbk5JdDR1WVJWbS9GRmFleW05TmJhdDFud0N2eCt0bkpZ?=
 =?utf-8?B?aVptWkdFVXIvd3hPRllaY3NWR21YM0xteXFndzk2aXIyZUh4end0OHdWbXky?=
 =?utf-8?B?VUcyYVFNNk1IR20wNWJnVWt6NncyL2MzbVlNOEpJVytkRit3MDdMb1hKVkFx?=
 =?utf-8?B?aUVzQnhFRnNSbkRtU1BQUXdteHI3WE50blBkQ3d4QnYwbzlwM0VocDdBY0d6?=
 =?utf-8?B?cjdkQ2tqZC82VXRGbXlGNEE2VXdiSnhsaDlROFhPWFdqN0ExSHIreUwvNlZH?=
 =?utf-8?B?Y2RBcWF6emY2WXRsc05ZdXRSakVDdlU3eWEyejgzbFZDNnNLT3BRdnBxZmNl?=
 =?utf-8?B?QTVvUFFlT1lqWkh1bCtkREVNeGw3NU56QUhNaXVhRVFDZDExSlBUYmRHNmU5?=
 =?utf-8?B?M05tWUFxb1grQUNZemFuVFluOHVxekoxWUt2TDUvYWRtRkUzUjN0L1pONWd5?=
 =?utf-8?B?Nlltd2p5UUJqcWF2RS9TUDBTRjZ1Uyt4MjBBeGthb0JCYkRMc0owTjFkUkpm?=
 =?utf-8?B?NVErTFk2SFh0N1FDdFlQYmdhZ2Y4cm5nTTRxckxmME1sN2hJT1I4cTV4NVVk?=
 =?utf-8?B?c2VoWFQ3TUZOcENaSXNyOGdwWWpLRlU2QnpxZnRoVjdsanptcEZDQlZJZmNQ?=
 =?utf-8?B?bGxkMVZsb0NFWUo0NnhkT2U5M3VBMFBndm10YXF2TXVsWG1MZ3ZEYWpzejlT?=
 =?utf-8?B?d0xpbDZvT2t0ZlpPMzNld1NmUDJCV0txVFlEbFpUa3FMcThkNW5GZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J4YLJpmlOhYLgzBOMGegV7Gu9E7rEVY8uCvxODZKPGE6/UjSwtU4xne7SL8lyMJHL/KlkMrZa1r70qXQ6jhV6YfNUGV5DoX4kEfDTd3Avbgi6e/NWwZfMLf7dQ+Bqs33dAczVRVTq+g3hnhEoqc2+paeJUZg8x6M7+a+KtiHSoPcZB0vv2bgd49VzWgX8anma09xdlk2Hh0BncXvfPbQ8+60+7/xqt2pwpfkjHVQp8P5E/9ANkYYtFx8EG5y/MvTeyXhsBgGgTqgqbEluSMsbmLquF/YHR6XythnUs1FB9+ABeh6ShFigyvmNfzu2klT8rrYhVELuPIT3JmONL7tKA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fead5971-292a-445f-d4a0-08decc407423
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 07:17:13.1496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvNexV0QSqkCqaoVwG1QE8VUxwESd1latzWUXE8FsCDwDgEsh3nc6N7Fx4Q2vXEzGXJwax1EXjpR6JaHQ5p30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bmUgMTIsIDIwMjYgOToxNyBQTQ0KPiANCj4gT24gNi80LzIwMjYgMToxNSBQTSwgS2V2
aW4gVGlhbiB3cm90ZToNCj4gPg0KPiA+ICAgCS8qDQo+ID4gICAJICogSWYgSW50ZWwtSU9NTVUg
aXMgZGlzYWJsZWQgYnkgZGVmYXVsdCwgd2Ugd2lsbCBhcHBseSBpZGVudGl0eQ0KPiA+ICAgCSAq
IG1hcCBmb3IgYWxsIGRldmljZXMgZXhjZXB0IHRob3NlIG1hcmtlZCBhcyBiZWluZyB1bnRydXN0
ZWQuDQo+ID4gICAJICovDQo+ID4gLQlpZiAoZG1hcl9kaXNhYmxlZCkNCj4gPiArCWlmIChkbWFy
X2lzX2Rpc2FibGVkKCkpIHsNCj4gPiArCQlwcl9pbmZvKCJJbnRlbC1JT01NVSBmb3JjZSBlbmFi
bGVkIGR1ZSB0byBwbGF0Zm9ybSBvcHQNCj4gaW5cbiIpOw0KPiA+ICAgCQlpb21tdV9zZXRfZGVm
YXVsdF9wYXNzdGhyb3VnaChmYWxzZSk7DQo+ID4gKwl9DQo+ID4NCj4gPiArCWRtYXJfc3RhdGUg
PSBETUFSX0VOQUJMRURfRk9SQ0U7DQo+IA0KPiBJIHdhcyBpbml0aWFsbHkgd29uZGVyaW5nIGlm
IHdlIG5lZWRlZCBhIGxvY2sgdG8gcHJvdGVjdCBkbWFyX3N0YXRlDQo+IGhlcmUsIGJ1dCBzaW5j
ZSB0aGlzIHJ1bnMgZHVyaW5nIGVhcmx5IGJvb3QgaW4gYSBzaW5nbGUtdGhyZWFkZWQNCj4gZW52
aXJvbm1lbnQgKGluZGljYXRlZCBieSB0aGUgX19pbml0IHByZWZpeCksIGNvbmN1cnJlbnQgYWNj
ZXNzIGlzbid0IGENCj4gY29uY2Vybi4NCj4gDQo+IEhvd2V2ZXIsIGNoYW5naW5nIGRtYXJfc3Rh
dGUgaGVyZSBkb2VzIG1lYW4gdGhhdCBhbnkgbG9naWMgY2FsbGluZw0KPiBkbWFyX2lzX2VuYWJs
ZWQoKSBiZWZvcmUgdGhpcyBwb2ludCB3aWxsIHNlZSBhICJkaXNhYmxlZCIgc3RhdGUsIHdoaWxl
DQo+IHN1YnNlcXVlbnQgY2FsbHMgd2lsbCBzZWUgYW4gImVuYWJsZWQiIHN0YXRlLg0KPiANCj4g
V2hpbGUgSSBkb24ndCBzZWUgYSByZWFsIHByb2JsZW0gcmlnaHQgbm93LCB0aGlzIHN0YXRlIHZv
bGF0aWxpdHkgaXMNCj4gc29tZXRoaW5nIHdlIHNob3VsZCBkb2N1bWVudC4gQ291bGQgd2UgYWRk
IGEgYnJpZWYgY29tbWVudCBoZXJlIHRvDQo+IGNsYXJpZnkgdGhpcyBpbnRlbnRpb25hbCBzdGF0
ZSB1cGdyYWRlPw0KPiANCj4gDQoNCk9rYXksIEknbGwgYWRkIHNvbWV0aGluZyBsaWtlOg0KDQov
KiBObyBjb25jdXJyZW50IGFjY2VzcyB0byBkbWFyX3N0YXRlIGlzIGV4cGVjdGVkIGF0IHRoaXMg
cG9pbnQuICovDQo=
