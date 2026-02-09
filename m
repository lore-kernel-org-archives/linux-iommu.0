Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D92D7DC8
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770616338; cv=fail; b=OmfsYOfoxXZd7Hb8SF3iPpgicM04fd3x2Mgj0sq3rurMhUF4nkqBovvL/TeqFFWB/gkF+16yTPeh7OaF6QFx2NopuNEU9QtY56uSqNfE2RyR9ntrlkngbxLcKXef1WcxON1YX7JZWA0FfzO+bJ/6Hnp4+hiGmy69bQjS5V+p6gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770616338; c=relaxed/simple;
	bh=UfP0Up/6mgpb+30kVQe5zuQIgGwBuw8dn+7F+LvAHUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=klXYHEHBng34/mh+7/0erTmuFaHbuheyIbDrdNJdoCaaRchQVwQUSch7LPHnB5k0T0CQiYPtvYRlC3HDtCRAMa7HN68C4Sj0xqOvPoyV87haQxVQJwpXpoMDLWYY6Df52uJA4qbPEHbFvg2rK8h7Z9SL9rLz403r7r7QLxN/riM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1IiXGm7; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1IiXGm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770616338; x=1802152338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UfP0Up/6mgpb+30kVQe5zuQIgGwBuw8dn+7F+LvAHUo=;
  b=S1IiXGm7kShv0DedqXfK4ryKu11msbRs0abe1PojeeP/GTAauGhUTv7v
   KBNGiBIUFuCHmzTvDJJXsJJy3EAcvBfEcKI2HJPOwW/E1E1FRWxhmgbzp
   k+NxgsTcKC3qd4IKkoXhDJFoY8HEbnPaamYXXgzJbe+Td0tcdYGKu8nbs
   8McCgHz2I3lMQPXUuOJWxfBfAUE72pUI8Pyi+z3uqdGOhL5K4XrJCOotL
   37fI3eLCa3bthRCsOOLoxX95pQI34jDsshI6slnbpRbievHT0u8zF66cN
   payUuZTxICY8jX1hlmpaS/ly/1Xy7wC08pjSd+33h0RSXs2sl2ME5KBNj
   g==;
X-CSE-ConnectionGUID: sENw/dojQMu41162J8p9qw==
X-CSE-MsgGUID: 7Ht9AYufRSOQFAqrDYXu/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71785899"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="71785899"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 21:52:17 -0800
X-CSE-ConnectionGUID: JYlP2eAGRUOobZ9mshK2Ag==
X-CSE-MsgGUID: bpbtmjEeSpOxh/2AR0BvQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="242110429"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 21:52:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 21:52:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 8 Feb 2026 21:52:16 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 21:52:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9w6abPVqgzTSHS+oiHYHD9VvHQl1qF8HOJdZep2vOec6eHxqBhRQgompdo2HGMS0gQHEpZoqQ2pv6Vlt7Dt6XuEaVJx6q87Ot5v/6y0uPi8CYw295WYaRLF7F7aq39wZ+KyVwMFmPT3GJDBcs7Bvxvs2lDHMV4TFDrB79fXW7zTfJnp/GAmc/tlvteyEe6AXpcOing6Ld0pgkpxntPsPbyQKvYxutjVgixdYbeVUXS9paOREvo6OLwlTLvW1m/SABZEmgIE4CvQXsaG2zp3kooFfNGa0efazEY7vpLMAftRUfX96b35TNGaDRLxbKYHySbyZCsXDjLR1AfgauRlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfP0Up/6mgpb+30kVQe5zuQIgGwBuw8dn+7F+LvAHUo=;
 b=xQcRclFfyy33A2ZHDasiSE3EDtw8POWKSMsmmNA6G7dr0SLEQ+lvrOSTMig5XaK8VY179rFW7O87k0FTOBe8v33K1jpOZ1DXXXhIz3dcBuNJOORBmHDIekCVnGG7PJPyFwmToI2jgSIMKCtunP/lwsIMC5X8d8Rl4nJT2kRMB4wI2b74QK3046GGK+3D/G9rfZp/LlTZDh5GPxzTTUnUX7OyI7kwnvN+YyIol0bLK01QFjknZDWDu2ITT7UifzcWRDZBoxStRffLr+n2UB2JqweSbZwe2oIQj5sZ0TtcTVpByMvCX85cahDxTba6AW9GJxllhPU9XSGNDjDq1hLs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7392.namprd11.prod.outlook.com (2603:10b6:610:145::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 05:52:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 05:52:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>, "Baolu
 Lu" <baolu.lu@linux.intel.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: xunlei <xlpang@linux.alibaba.com>
Subject: RE: [PATCH] iommu/vt-d: fix intel iommu iotlb sync hardlockup & retry
Thread-Topic: [PATCH] iommu/vt-d: fix intel iommu iotlb sync hardlockup &
 retry
Thread-Index: AQHck+kHmJunq9bMDkqZ663uMXRimbVySnSAgAGh/YCAARPCAIADocUAgAE9F1A=
Date: Mon, 9 Feb 2026 05:52:09 +0000
Message-ID: <BN9PR11MB5276A8C1C3F3989F46A7D7418C65A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260202020920.3557883-1-guanghuifeng@linux.alibaba.com>
 <086971f2-cec7-414d-8cc9-01836ef7259a@linux.intel.com>
 <ebd62398-342f-4b28-8c7e-ce0ec8dd8889@linux.alibaba.com>
 <f8e35741-6b4c-4e14-a0a5-2c3176840242@linux.intel.com>
 <f152400d-cda1-47e3-8722-5b72855f0a96@linux.alibaba.com>
In-Reply-To: <f152400d-cda1-47e3-8722-5b72855f0a96@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7392:EE_
x-ms-office365-filtering-correlation-id: 3e3a96ba-086c-4894-1631-08de679f5d2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?cTcyL2hDVDdRMXFyd3EzU3VWR1ZaTGV1TTRMVytxRmFBVmpXVFUxTWxLQ2Nh?=
 =?utf-8?B?UzlPUXdpQ0w1RjFaSm91LzUrTW56QVJPaXFKSmhTNlVYeTZoSzdtNlhFY0FU?=
 =?utf-8?B?R0VSVC91SkJIazlrWmhwVHA5dUg0VDBwUTdnTEZ0N3JBUFhxN005VGxQMHQx?=
 =?utf-8?B?c01TcXlicjNzNWwrN0drYThJSGRjd3MwSUJyOWtNbUFwTkk1M2RoNjZzbTRk?=
 =?utf-8?B?eHlMY3dSeHBVbHBVUnNiT05XRS9JaXJqRVFqWmlXUGgxM0lRTHJxTjZrbDdW?=
 =?utf-8?B?RUZ0ZFdwcVhnWWE3RVJBUWdvM1Fvdkt5YzVUQXNKakFNalNxeVQwTGlNUHht?=
 =?utf-8?B?RWVIT2V2YjJvZlhnYjV2NklCbHZXZFpPcEFtMDVISHcrNkEya244dVRucmNl?=
 =?utf-8?B?ZWxzZTgvT1p6UlU3VVhqdC9JRlFEWjZsWWoxbjd4Vm9qQTR3VGdZSnlXaU43?=
 =?utf-8?B?M1VFai80bzRuN0pEb1ZOU1dSUGRjT1cvakRTcG9SWFpwV2F1TjhuM3MyN2Rs?=
 =?utf-8?B?TXpUTk91OWhaODZaMnluamg5NFJzT3pjeXY0U1B5S0hLdjl4bGNjV3NDSXRt?=
 =?utf-8?B?RmI3ME1ueG1xWE4ySWN5RHNNekdEUG9HTm94VE9ybHBLTnBZNnA1TlVpS2FG?=
 =?utf-8?B?REVUOEhLaGl0TndSVEZlTjVLS1BUSkRZajBTRmV2R21ZTTlHQm9KVlY4R1E2?=
 =?utf-8?B?R09Fc3plUGM0OCtJUDRSOUp5QWYzQW1JT2JKcS9POUlWNVlVZlNWRGdEVEdO?=
 =?utf-8?B?WFZWUG5mcWRQNlJFdW13dEpPdzZyV1I0TmlRZTRxUjdQeXBaK1VxQ2tSUVFx?=
 =?utf-8?B?MjN3S3VVUDFCMlo2c2JWa2tjaEU2ZXluNXlFajFyY09ySUROZktQLzU3RXQr?=
 =?utf-8?B?N2VIYXJkdlJpZUtsZTdoQ1JVRFRueGpTdG9WNFBUMmlmdDEzUkNQb0x1bnB0?=
 =?utf-8?B?akJFQVJMbjUyUW0yckJxTm11T1VnV0VVZ3JsU0lyc3o3VEJVVXVIMXlMTkkr?=
 =?utf-8?B?WnAxdGxub1JUOCtDUURxV2xqODErNklFZU5kUzJwYU82bmY3c0s2SisyVnZh?=
 =?utf-8?B?b29WaVlOdSsybzdPdG9xZjl1MktlSkMyWndBS3RhSmJ2dW9KSlpzZXI3RThZ?=
 =?utf-8?B?aWkwbnFQekxpTm9seFZlNlV3QWQwR1lESmlud3RJVFdGN1EzV1ZpVHlRTTNK?=
 =?utf-8?B?T1VER3EwVlRDU1VSV2QxQVg4aWFvbHdOcG1SUnRvZlZ6dklYdFl3cFpuaWZV?=
 =?utf-8?B?ZXJMcStxWWMxaEwyOEcyenYyWUhjTkxpbTVOQkZNUll4dDJhOUUrV0FSSEph?=
 =?utf-8?B?bW5EOHJoSW8vTUduNmc1T2w1Z0diS3BqbFppd0xpZ3Qzb3h5RElSU3JQUnVU?=
 =?utf-8?B?V0F4QU9sSUNuc05hWmg5NFd2alMwL3VvUEVGN0xzU0d1WlVBUnhNYzFZVTJH?=
 =?utf-8?B?YjZWMm5vZmNXRlZvTzFBVGEzUkpyTzhEM1pEa2oybFplaGhMMXgzVCtEZ2Y1?=
 =?utf-8?B?Q1hsL0Z4OXJNVlZKZGdKSTRQd1dCQjlYWXd1blpEYVQweHNQcUZuSzFycGw1?=
 =?utf-8?B?SnNlUWRZMk9sK0MxU0hGd1Vac3F1cFIwN1oxRmxnUnJMV3JlYXVPWWVzenlY?=
 =?utf-8?B?cm53bmFTSURKSzZyaVkrdUdBb2tiamptaUhqVzh6aG9BZklRc2RRSkJiaEpT?=
 =?utf-8?B?Z1UrOUhwMmZML21EczI4UkNOVGd2dU1sVHdLL3BFVm82NC82Rll1dHZ6OUZy?=
 =?utf-8?B?NVVJOStIOUc5ZXZiRHllOVc0YndiN05tWDcyUWpQS0NzSFppSGpGcnpCQVFD?=
 =?utf-8?B?VU85MyttQ0dRRytSNDdVY3ZFWGc3US9kTkhuc3J0Yi9CeWdPNU8vSHhtbkd5?=
 =?utf-8?B?cjF2UThqUVRxOGFGREg2eVVEdnphNnB0U01VL1dqN3BuN1JzNXVWTDVQS2pp?=
 =?utf-8?B?QmdOdWFROXZQeHZGYUJReTVVaWU2cWhKMnB6NlZhRk9jaW4xbTZFNGdQdGRo?=
 =?utf-8?B?aHAxT0U3V0lnWTNkb0RCTmZtOFpKeTc3WDB0Q1FLV3BXT0tYbTVFd1orZnVz?=
 =?utf-8?B?TDhGZnpvQnVtLzVhdTlwRlk4MGhKSm0vNXQrTDczSHVMUHhRZlJVajFHV3dk?=
 =?utf-8?B?bnNnV0hZcjlpK1JHREJObXFLUjlWNlV2emtpUkw0QjRsUnE3ZnRDc0Z2aWtC?=
 =?utf-8?Q?9NDqfbu8cQH+ARzd9ikFjIk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHp2UUE4TUlXbDNmZmFHU0tCbGNPdUl0RUtxNURpTWlEckZxUUVEYTFOT2Uv?=
 =?utf-8?B?bmYremlPZmdmSTZ5Y3ZiM3VYWFYvci9TYmRzWnBydERlUFRjSGVsdlpyalRs?=
 =?utf-8?B?SlZlOW5JVGhURzI1QnRvMGxsZ3ZTQ29yUCs0bm4rOE9OSEJ5UkthYzNUL1pR?=
 =?utf-8?B?bnZ1TUtDMzZ0MlMyRXpRemVSTjhZZTBQS1BZTGFnR0IyaHNYZFdueWtOSTdR?=
 =?utf-8?B?aEVES3JicVBYQnFueFVxTXFMeVdoNklZZmZxWXJHQkpCR2xxMlB2eU11R2Vk?=
 =?utf-8?B?b0tDTWJ5eHhQenRlWUE3ZEtoR2dDbzdlSHVyTWZabDF5U2w1YjRmbHJHVzNx?=
 =?utf-8?B?NTYzSmpqVWp6WmpieFNBSHB6ZW5zbWlvQy9USVhyZ1Y0d2VwNWFFQ0Q4d09D?=
 =?utf-8?B?b1Ntd05uVkRkeGFFMXlBbWtZM3RqSldXWkVuM0tUVGd0YUxDcUZiSE5lUmY2?=
 =?utf-8?B?cFBZaUN0QzJwV0RxTXowak5TOXI2L1VSam1lZVBDNm5rV3dxYVJsVFAxcG1T?=
 =?utf-8?B?OUZuczkrQkFCN3QzMTRaUzQzTEM2VmtSRkRieWhYUGhyS1RicVkrdHp3aFll?=
 =?utf-8?B?aVF1TGJMakVlNW1MVlV2YytTM3lZUGs0emFqMktMaU5WZjBqVUZNRG1lSGU0?=
 =?utf-8?B?OWFzNWhPbXhCUXd6b1BaK3VuUlBDTkoyTkJvODE3cmYrTkVXb21Kd0Fack50?=
 =?utf-8?B?VnZkWklCSE1zK2RhYjRjQTRRc3k0WW5nRXF2cVBCMlVCSTZaYkpXMnJ1OFY2?=
 =?utf-8?B?RkpZek04dFh5am5ZZnJFR2xNM0w2MnY3OE8ybVh3TWtTQXVqYkx5ejVxVnhl?=
 =?utf-8?B?Qk1IS3VBZ0laN0taeFgydldOTUhFYjd1ZmhkNTFRYmJkYk9BMnN5bDAwRnlF?=
 =?utf-8?B?M2x4ckN1L2lMY1VueVJySkFWRHZZdHkwamltK252ZC9wUUZxdE10UHRNMnBp?=
 =?utf-8?B?eHNHODF3d1VSVW80T2lwQWE2TXJoUkI3c0k3SHAwWFpxTWU3cEtnZDJRKy9N?=
 =?utf-8?B?b29oRmxqTzJtMnAzRkY1cFRzcG12WXUvOCtEUW54aDVpZVEwZzhYdWVMQk4z?=
 =?utf-8?B?MkdjV3EyaDUxVXlpeDc2NHgxb2JaRTRxcFhKYkpjWDFzaTFyZ2NsNGROSXZi?=
 =?utf-8?B?aVZkdU9KWGpJa3FZYlRsWEFSVzhKNWtYYThCNXZiRHI0WTJaOEFTcE1wSlhF?=
 =?utf-8?B?M1A3eGREWWZ6RlY5UDMwZXlzK0xKWnAxQmpnTmhHd2xEbGJmTDNKUWFYWm1v?=
 =?utf-8?B?bG5veUdxT2MzSVVHZS9yZ2JsaGhISC95Y2VhTmRLNFFnUjROUko4TDFqeURV?=
 =?utf-8?B?SjBGQ1Q1NkxnYld0QkhyYzl4V3o2ankxbmRGcW9jRjdVaDZsSzlXaVdidUpo?=
 =?utf-8?B?YUlic1dXY0JlZEpaSzhIcC8yU1FMWnZzdzcybEp0M0w5bGhWc210VmlyMkhF?=
 =?utf-8?B?TjB3V2NxdnlVeFd6YmxhdzBLcXpMemJmRG9KcXVNZDdVZUlMNkpGZUYwQVRE?=
 =?utf-8?B?dW1HYktYZG1VV2s4THhFanJmSDhpQk1ONGZ2UmR2UEJ5YXhOZVZhZ0dqTVc0?=
 =?utf-8?B?VS92cW4wTlcyQ1Nmam00RTlTa0dqOFFVUmtWRjYxcTFNM2QrR1RIT3A1dUoz?=
 =?utf-8?B?ZmFEdGExUmYzYUcvOXZVam93S1J0cGI3MnduNTdnZkNhU0NESkpNOWhNWTdF?=
 =?utf-8?B?OW11NGRIdmFCTFk0bkxTNk90TzNiSCtaWWhLcGtGU1BoUGc0WTBBeE5PY3Bj?=
 =?utf-8?B?UTU5SFB5NnIzblBKeXZKdTNYR2FMcldmcUg4bmNoVWZkQnpMenM2K08yMCsv?=
 =?utf-8?B?VmFTZ3kvb21LQkN2OTQ3eUp2MlJVcGpndW5NbmZQenNZeWxxQnJWMk9sZitO?=
 =?utf-8?B?OXU3ZGRLYlBaK3FZaFA5L2FNU21aVWhhbDhwZjRraWI2SnFNbkRqbjM0Y0RQ?=
 =?utf-8?B?OW1qVVRPb2xrRXdmWDNOSEo3SzhBZzg3RGU5U3dBNUppL2lOc0VKendkQmRm?=
 =?utf-8?B?Vy9IaVJCNlhEWktmdHRQdXQ0RGZwT1l2bTBndFNpelNhVGEwcy9pbFhVaElS?=
 =?utf-8?B?MlFxZ1FqQ3NVRUM1cWdiRzVVS1FkZGRJdWtFMk1OV3Vvck14YTZydy9GY01T?=
 =?utf-8?B?RG1MYkJrS1ZnMTFmRTJQSmtneHFFQ1pmZW9EaW5zWjhJVXRaM2pBbzJDcTBR?=
 =?utf-8?B?MUN3eTNXMXIzendMNVRLdmk0Qmo2TEZWRmZ4YXlFb21hUEFwNklrZW1uRlNY?=
 =?utf-8?B?RnNXWDZtV0QvQjd2L0dTNGJKcWx1YW9VZjhObWdKekp3WnAyNFQwY25WTVc2?=
 =?utf-8?B?WnVWaHFDZ1N5Rk5CRGx2VjBhN3NTSCtJK3hBdnlIdVp4SmkzeERNQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3a96ba-086c-4894-1631-08de679f5d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 05:52:09.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBmqgIT6k/WIpWoXY2ssB72hW/c/gfVbmxkaAsKgvoxfFWo8q0NZtFlFGX+wK9zOxy2ZQz15EbxfFhY1VTM/qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7392
X-OriginatorOrg: intel.com

PiBGcm9tOiBndWFuZ2h1aWZlbmdAbGludXguYWxpYmFiYS5jb20gPGd1YW5naHVpZmVuZ0BsaW51
eC5hbGliYWJhLmNvbT4NCj4gU2VudDogU3VuZGF5LCBGZWJydWFyeSA4LCAyMDI2IDY6MjMgUE0N
Cj4gDQo+IOWcqCAyMDI2LzIvNiAxMDo1NSwgQmFvbHUgTHUg5YaZ6YGTOg0KPiA+DQo+ID4gQW4g
b2J2aW91cyByYWNlIHRoYXQgSSBjYW4gdGhpbmsgb2YgaXMgc29tZXRoaW5nIGxpa2UgdGhpczoN
Cj4gPg0KPiA+IFRocmVhZCBBIHBsYWNlZCBhIGRldi10bGItaW52LWRlc2MgaW4gdGhlIGludmFs
aWRhdGlvbiBxdWV1ZS4gQWZ0ZXINCj4gPiB0aGF0LCB0aHJlYWQgQiBwbGFjZWQgYW4gaW90bGIt
aW52LWRlc2MgaW4gdGhlIHF1ZXVlLiBOb3cgdGhlIHJlcXVlc3RzDQo+ID4gaW4gdGhlIHF1ZXVl
IGxvb2sgbGlrZSB0aGlzOg0KPiA+DQo+ID4gwqDCoMKgIGRldi10bGItaW52LWRlc2MgZm9yIEEN
Cj4gPiDCoMKgwqAgaW90bGItaW52LWRlc2MgZm9yIEINCj4gPg0KPiA+IFRoZW4gYSBkZXZpY2Ug
VExCIGludmFsaWRhdGlvbiB0aW1lb3V0IGVycm9yIGhhcHBlbnMgYW5kIHRyaWdnZXJzIHRoZQ0K
PiA+IElURSBiaXQgdG8gYmUgc2V0IGluIHRoZSBmYXVsdCByZWdpc3Rlci4gVGhyZWFkIEIgc2Vl
cyB0aGlzIGluIGl0cw0KPiA+IHFpX2NoZWNrX2ZhdWx0KCksIGNsZWFycyB0aGUgSVRFIGJpdCwg
YW5kIHJldHVybnMgLUVBR0FJTi4gVGhlbiB0aHJlYWQgQQ0KPiA+IHdpbGwgbG9vcCBpbmZpbml0
ZWx5IHdhaXRpbmcgZm9yIERPTkUgaW4gaXRzIHdhaXQtZGVzYy4NCg0KbG9vcCBpbmZpbml0ZWx5
IG9yIGV4aXQgdGhlIGxvb3AgYnkgaGFwcGVuaW5nIHRvIGNhcHR1cmUgdGhlIG5leHQgSVRFDQpm
cm9tIG5ld2VyIHN1Ym1pc3Npb25zLi4uDQoNCj4gPg0KPiA+IFRoZSBxaV9zdWJtaXRfc3luYygp
IGxvZ2ljIGhhcyBiZWVuIHRoZXJlIGZvciB5ZWFycy4gQ2hhbmdpbmcgaXRzDQo+ID4gYmVoYXZp
b3Igd2l0aG91dCBlbm91Z2ggdmFsaWRhdGlvbiBvbiByZWFsIGhhcmR3YXJlIHdpbGwgY2F1c2UN
Cj4gPiB1bmV4cGVjdGVkIGlzc3Vlcy4gVGhlIGJldHRlciBhcHByb2FjaCBJIHdvdWxkIHN1Z2dl
c3QgaXMgdG8gZml4IHRoZQ0KPiA+IG91dGRhdGVkIGxvZ2ljLg0KPiA+DQo+ID4gVGhhbmtzLA0K
PiA+IGJhb2x1DQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQo+IA0KPiAgRnJvbSB0
aGUgSU9NTVUgVlQtZCBkb2N1bWVudGF0aW9uLCBpdCBpcyBrbm93biB0aGF0IHRoZSBJT1RMQg0K
PiBtYWludGVuYW5jZQ0KPiBwcm9jZXNzIGhhcyBzZXF1ZW50aWFsIGRlcGVuZGVuY2llcywgZm9y
IGV4YW1wbGUsIGEgY29udGV4dCBJT1RMQiBmbHVzaA0KPiBtdXN0DQo+IHByZWNlZGUgYSBQQVNJ
RCBJT1RMQiBmbHVzaC4gVG8gZW5zdXJlIHRoZSBleGVjdXRpb24gb3JkZXI6DQo+IA0KPiANCj4g
TWV0aG9kIDE6IFJlcXVlc3RzIGluIHRoZSBpbnZhbGlkIHF1ZXVlIGFyZSBleGVjdXRlZCBzZXF1
ZW50aWFsbHksDQo+IHJlcXVpcmluZw0KPiBvbmx5IHRoYXQgdGhlIHNvZnR3YXJlIHN1Ym1pc3Np
b24gb3JkZXIgaXMgdmFsaWQuIFRoZSBJT01NVSB1cGRhdGVzIHRoZQ0KPiBoZWFkIHBvaW50ZXIg
b25seSBhZnRlciBjb21wbGV0aW5nIGEgcmVxdWVzdC4NCj4gDQo+IA0KPiBNZXRob2QgMjogUmVx
dWVzdHMgaW4gdGhlIGludmFsaWQgcXVldWUgYXJlIGV4ZWN1dGVkIGluIHBhcmFsbGVsIGFuZCBv
dXQNCj4gb2Ygb3JkZXIuDQo+IFRoZSBzb2Z0d2FyZSBlbnN1cmVzIHRoZSBleGVjdXRpb24gb3Jk
ZXIgb2YgbXVsdGlwbGUgcmVxdWVzdHMgYnkgYWRkaW5nDQo+IHdhaXRfZGVzYyBlbnRyaWVzLg0K
DQp0aGlzIGlzIHdoYXQgdGhlIHNwZWMgZGVzY3JpYmVzLiBPciBtb3JlIGFjY3VyYXRlbHkgaXQg
dGFsa3MgYWJvdXQgdGhlDQpoYXJkd2FyZSAqZmV0Y2hpbmcqIG9uZSBvciBtb3JlIGRlc2NyaXB0
b3JzIHRvZ2V0aGVyLCBsaWtlbHkgaW1wbHlpbmcNCnRoZSBwb3NzaWJpbGl0eSBvZiBwYXJhbGxl
bCBleGVjdXRpb24uDQoNCj4gDQo+IElmIHRoZSBJbnRlbCBJT01NVSB1c2VzIE1ldGhvZCAxLCBh
bmQgb25seSB1cGRhdGVzIHRoZSBoZWFkIHBvaW50ZXIgdXBvbg0KPiBjb21wbGV0aW9uDQo+IG9m
IGEgcmVxdWVzdCAoZXZlbiBpZiBhIHRpbWVvdXQgb2NjdXJzIGR1cmluZyB0aGUgZXhlY3V0aW9u
IHByb2Nlc3MNCj4gYWZ0ZXIgZmV0Y2hpbmcgdGhlIHJlcXVlc3QpLA0KPiB0aGVuIGFmdGVyIGFu
IElURSB0aW1lb3V0LCBjbGVhcmluZyB0aGUgSVRFIHN0YXR1cyBpbiBhbnkgY29udGV4dCB3aWxs
DQo+IHRyaWdnZXIgdGhlIElPTU1VIHRvIHJlLWZldGNoDQo+IGFuZCBleGVjdXRlIHRoZSByZXF1
ZXN0LCB3aXRob3V0IHJlcXVpcmluZyByZXN1Ym1pc3Npb24gb2YgdGhlDQo+IGRlc2NyaXB0b3Ig
cmVxdWVzdC4NCj4gDQo+IFRoZXJlZm9yZSwgY291bGQgeW91IHBsZWFzZSBoZWxwIG1lIHRvIGNv
bmZpcm0gdGhlIGN1cnJlbnQgYmVoYXZpb3INCj4gcGF0dGVybiBvZiB0aGUgSW50ZWwgSU9NTVUg
ZXhlY3V0aW9uIHByb2Nlc3M/DQo+IA0KDQp0aGUgc3BlYyBpcyBhbHJlYWR5IGNsZWFyIGFib3V0
IHRoYXQgcHJvY2VzcyBhbmQgdGhlIGN1cnJlbnQgc3cgZmxvdyAoDQp0aG91Z2ggd2l0aCBhIGJ1
ZyBhcyBCYW9sdSBwb2ludGVkIG91dCkgbWF0Y2hlcyB0aGF0IHByb2Nlc3MuDQoNCk11bHRpcGxl
IENQVXMgbWF5IGJlIHN1Ym1pdHRpbmcgZGVzY3JpcHRvcnMgdG8gdGhlIGludmFsaWRhdGlvbg0K
cXVldWUgaW4gcGFyYWxsZWwgYW5kIGluIHRoZSBwb2xsIGxvb3AgKHBvbGxpbmcgdGhlIHdhaXQg
c3RhdHVzIHRvDQpiZSBRSV9ET05FIG9yIFFJX0FCT1JUKSwgYnV0IHRoZXJlIGlzIG9ubHkgb25l
IENQVSByZWNlaXZpbmcNCnRoZSBJVEUgdGltZW91dCBpbnRlcnJ1cHQuDQoNClRoZSBjdXJyZW50
IGxvZ2ljIGlzIHRvIGhhdmUgdGhlIENQVSBzZXJ2aW5nIHRoZSBpbnRlcnJ1cHQgdG8NCnVwZGF0
ZSBhbGwgd2FpdCBkZXNjcmlwdG9ycyBiZWZvcmUgdGhlIGhlYWQgcG9pbnRlciB0byBRSV9BQk9S
VCwNCmVmZmVjdGl2ZWx5IGFib3J0aW5nICBhbGwgd2FpdGluZyBDUFVzIHRvIHJlc3VibWl0IHRo
ZWlyIGRlc2NyaXB0b3JzLg0KDQp0aGF0IGlzIHdoeSB0aGVyZSBpcyBhIGNoZWNrIGF0IHRoZSBz
dGFydCBvZiBxaV9jaGVja19mYXVsdCgpOg0KDQogICAgICAgIGlmIChxaS0+ZGVzY19zdGF0dXNb
d2FpdF9pbmRleF0gPT0gUUlfQUJPUlQpDQogICAgICAgICAgICAgICAgcmV0dXJuIC1FQUdBSU47
DQoNCkl0J3MgYnJva2VuIG5vdyBhZnRlciB0aGUgZHJpdmVyIGFsbG93cyBzdWJtaXR0aW5nIG11
bHRpcGxlDQpkZXNjcmlwdG9ycyBpbiBhIGJhdGNoLCB3aGljaCBicmVha3MgdGhlIGFzc3VtcHRp
b24gdGhhdCB0aGUNCndhaXQgZGVzY3JpcHRvciBhbHdheXMgc2l0cyBpbiB0aGUgb2RkIHNsb3Rz
Lg0KDQpCdXQgeW91ciBjaGFuZ2Ugc2tpcHMgdGhhdCBzdGVwIGJ5IHNpbXBseSByZXR1cm5pbmcg
LUVBR0FJTiBvbg0KdGhhdCBvbmx5IENQVSwgd2l0aCBhbGwgb3RoZXIgQ1BVcyBzdGlsbCBpbiB0
aGUgd2FpdCBsb29wIGFzIHRoZWlyDQp3YWl0IGRlc2NyaXB0b3Igc3RhdHVzIGlzIHN0aWxsIFFJ
X0lOX1VTRS4NCg0KdGhpcyBwYXRjaCBtYXkgd29yayBmb3IgeW91IGluIGEgc2NlbmFyaW8gd2hl
cmUgbmV3IGRlc2NyaXB0b3JzDQphcmUgY29udGludW91c2x5IHF1ZXVlZCBhbmQgbmV3IElURSB0
aW1lb3V0IGhhcHBlbnMgdG8gYmUNCnRyaWdnZXJlZCBvbiB0aG9zZSBwb2xsaW5nIENQVXMuDQoN
CmJ1dCBpdCdzIG5vdCByZWxpYWJsZSBhbmQgbm90IGEgY29ycmVjdCBmaXguIHlvdSBzaG91bGQg
c3RpbGwgdHJ5IHRvDQp1cGRhdGUgYWxsIHdhaXQgZGVzY3JpcHRvcnMnIHN0YXR1cyB0byBRSV9B
Qk9SVC4gDQoNCmJ0dyBzdXBwb3NlIHRoZSBJVEUgdGltZW91dCBpcyBkZWZpbmVkIHRvIGJlIGxh
cmdlIGVub3VnaCB0bw0KY2FwdHVyZSB0aGUgbWF4IHBvc3NpYmxlIFBDSWUgQVRTIGludmFsaWRh
dGlvbiB0aW1lb3V0IGZyb20NCmRldmljZSBzaWRlLCBidXQgbG9va3MgaW4geW91ciBjYXNlIHRo
ZSBkZXZpY2UgaXMgc3RpbGwgcmVzcG9uZGluZw0KKGp1c3QgZm9yIHNvbWUgcmVhc29uIHRoZSBy
ZXNwb25zZSBpcyB0b28gc2xvdyB0byBmaXQgdGhlIElPTU1VDQphc3N1bXB0aW9uKS4gdGhhdCdz
IHdoeSByZXRyeSBjb3VsZCBzdWNjZWVkPw0K
