Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEF154C04
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669696; cv=fail; b=QCbR7YAfGf2FhvT5lF1IMbB7kFSSRWtfz4Z4Tl8VYFhwDaM2U5Tsyuv0G1GCYQqx79WiLPiv0fgpJMhLMunyVsUoZbxduNQ1BOBXB+vacyXa7ad0lqzlWn94XaLtq/H3/Pfo2KoVlnBBcYg6NvSkMadQ8z403KrRJrRviOtnGlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669696; c=relaxed/simple;
	bh=RT6AS06EoOjI5QlRFXE+Ykz0GLbSMnNMZ6FBV0C33pM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FcI+j+p4spAXsNWrkWPsvBOcsnDfv+lPNFb733FC/F2cajmD7JbeF+OHDqoNgRn0jgr4fn08vi2+ZJcaPE7HmS+Arboht4gmVdub52HciTiXnf8RfURBUl6a0HxBT0+FTQh8+djZwRPyY+0kti3bPlulh/N5xSrjnd2jMCSdTE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpE4ds9v; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpE4ds9v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729669695; x=1761205695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RT6AS06EoOjI5QlRFXE+Ykz0GLbSMnNMZ6FBV0C33pM=;
  b=SpE4ds9v0G3UsbdVMqeZAgVmZpDM1lwqe8LIJgSKt58HF6aMjHIV3WbT
   nPvWipX6w0wAcyEsnKo/iUnlGMtr1j9TuabSZGvDKM7fYn2056gVzR4Rr
   T3H6ap1eNL0pTaxiQNxxQSBmL4WtLneM65XZUDUl4ITF6kb6QPtzm0E2D
   gNOt2hPtnyGxIWgaut3HFMmU1FobdoAHckUQlocbSAFpGkRo15m0/mIQ/
   8yXmBajsU8atJZLfM+BOzPZfo0WjUB8bAmu3H7FLt/svgv/FW/F7Ii0ub
   iqpSwyHt+W8Vkp91x/o/PFRw8wRKcNZRCv/JKW3mbDFwbDg39n55WHL5l
   Q==;
X-CSE-ConnectionGUID: 8MLfTQ4VRBiMiy6/H1PxUA==
X-CSE-MsgGUID: dpu2zeqhTjqeEN9CFLg2+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29117139"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29117139"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:48:15 -0700
X-CSE-ConnectionGUID: V5t6CKa3R7eAmd0pN0LOpQ==
X-CSE-MsgGUID: xicMAtTiTriiAmeDpxzetg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80124709"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:48:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:48:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:48:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDbKD9oTgc8jhwgd6UG+8iPyGPksnzSePdEaaGJEKXf0F4hwacRfIkujeTRjgeIesLAhhrrPkeUIBLnc55gZAR0X9BhsKrhGU43xOtn3Rk9sMr6TP0K1MdILC1CwRjsiSmGY2mrjrHlkAqKR9LBfBwPp2XMMGQAUgmbz/6wtuf7l78t+1lA96G+CHu/euL78h8ck/FRX/BK6UcSIrPpbLbRoYBF0/uRtkHGifGDT/cZ/tGTqSMUZgZzi13F9YXKA4GFUtlE7S/lKD/MPlbSWSmx31LmylQKEgIC0mtbdNjzATWmTKWyXukr4rmVE3Hpi8fKcBDg2HPPMzxxnOe2Plw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RT6AS06EoOjI5QlRFXE+Ykz0GLbSMnNMZ6FBV0C33pM=;
 b=hDKiQ9LXV8v9+QRrNYOKpK+jmjSajLYcN36LUVvUPKkLTmKPwgo3V38TSWMAybap8z4NkIr6NBdd7Xs5lJoN3RxBnFywBOx0GUcHBusXGfFuq8ix9C00OLKK2/iVbREClRJ2feM5KDLlMWGtp8cLcuBImq4hqiqZV21jsM8C/h29oZSW+HEEYYZZhnzJ6pr+DN5aC9jqJbn67fFDbu8rzeJt5Odj1Bbe1pYB4UJczup4OBgU/dO22TeI3t61gS1gAeYWYamQQYWUnaJA6PbF8A+61F3rWdBtoRjOYWKNjlV7XavT4EHqV0xISrdZ808Lnl1IPy2o1ahUcWCrgUQ98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6056.namprd11.prod.outlook.com (2603:10b6:510:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 07:48:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 07:48:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, Kyung Min Park <kyung.min.park@intel.com>
Subject: RE: [PATCH 2/2] iommu/vt-d: Fix checks in pgtable_walk()
Thread-Topic: [PATCH 2/2] iommu/vt-d: Fix checks in pgtable_walk()
Thread-Index: AQHbJGhDqRDkRT5yak+iRoHXqTbTzbKTxSQAgAAFi0CAACp7gIAAAbkw
Date: Wed, 23 Oct 2024 07:48:10 +0000
Message-ID: <SJ0PR11MB67447D03F5E78EFDB570C60F924D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241022095017.479081-1-zhenzhong.duan@intel.com>
 <20241022095017.479081-3-zhenzhong.duan@intel.com>
 <813d32e8-e84c-4744-bc2c-b76adc10d00f@linux.intel.com>
 <SJ0PR11MB6744EC9F9B202E1BBE7DC4B1924D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6d109cd-9a7e-416f-87d7-429e584e3b3e@linux.intel.com>
In-Reply-To: <f6d109cd-9a7e-416f-87d7-429e584e3b3e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6056:EE_
x-ms-office365-filtering-correlation-id: d4690dce-196a-4aee-9005-08dcf3370ab5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Yzc5U1RiRTZ5TFAwYUdGNlFlMnRPTkJJUUk4ejdvaHVRYitQZzlKb2c4Y05Y?=
 =?utf-8?B?S2RPRVNmL2RZRXNWbHFVN3N6L2ZsckdaQnh5YUFuMnVtODFFWkdJV215NnY4?=
 =?utf-8?B?M3JIVms1YkdFcG82SDZhRGl3WGludnBPWFMrTHEvdUo3TXdkZ21jSyswaFVr?=
 =?utf-8?B?TzJaN2lVMXJENjE2TnpMRm1UL3NvamloZTdKOG0rVlA4c25jK0Q3ckUva0th?=
 =?utf-8?B?VUJyNjNSUG1DV3Fpa0ZvVHhyL3hBVGdWb25raFh4SDIrNE1LV2xlNDcrekxv?=
 =?utf-8?B?dmtXVVBleldHSHlxWlgvcjdwMFdoZWIrTlQxanl5dU4yb0I4RU9aam5scHN4?=
 =?utf-8?B?Mlp0V1dqTzQ0UmFnNFdMUGEwUzRpa1EzVDgrajFleWpIKzFjdWhBRFl1dUlM?=
 =?utf-8?B?eEF5WUtkS2cyc094WDZMdnE5ZmxrbkxTeUVpSlNFTUt6WUFPVVk5NEFjZ2tQ?=
 =?utf-8?B?aEY3RHg3VWFGaSsrREduUFRydHNTMVRMYUMwYW0rV1dEVVIzOUJMSWFETFhi?=
 =?utf-8?B?S2NZWDg5M1FzM2x4Mmsrc2tmazlwaWtMdHVSanpDaDRTNzYySXRhUjdvZ1h2?=
 =?utf-8?B?V2huWWRKRXREeEdONEwyV0Z6TDhJN2I3TjF3TU1keng0THhGNnpnRWJpUE5R?=
 =?utf-8?B?VHA4dTBYdDRFUlZNalRhUnZwZTZSSndZb1J6N3g0VnlPNlAvbTU1QU80bFor?=
 =?utf-8?B?ODkwZW5yNzRGcGtVS1JQSGJ2Z0tOeTVIbWF5QXQvdTBrWS8rM3IvbEtkeno4?=
 =?utf-8?B?S0ZPaVFVUGxLOXlZaEY5QjZCRmVuMStrTTR0Qzlob0NFZENkUkNNcmpQU3Bn?=
 =?utf-8?B?Y1d0VzhFcG1tczJUcHE1eTJvT0ZyWmlPQitjV2FyRjRBMkN1TFE4VnY0Y2Yy?=
 =?utf-8?B?KzA4a29CcVRHSHZaSVIyc2R2VnpwMzZyb0FWL3F3cS9VUTJ2cGVNVlBVUy8x?=
 =?utf-8?B?Tm5pdHJodjNST1Fja21UUHRLMEoyTU9MMXhUd0I1azh3eVlCdU9lK25vYW9H?=
 =?utf-8?B?WmhwQ0ZHZGRrVmJ2U082VDZUd1ZhWVhtNXRJZWdnajN5U1p2cW41Wm4yVDJI?=
 =?utf-8?B?eDJEbDVYaXJNZ2tQNk5wVDVtTnJ5NzZ1NTZ5M3VBUk1CRXR1eVhxbFRaOVkr?=
 =?utf-8?B?VlZTL3YyblAzQ05KWEoxTTljNzk3ZjBKeUJoS1R0Uy9DT2lqazM4aWtBTTFa?=
 =?utf-8?B?eDFnd0dJSkY5OFQ3YktSVC9jVjcrUDlDNkJQYi9WQVA0WkZYZnkwUVRNZkJZ?=
 =?utf-8?B?b1VVVzFxMVRIYzFuRHhKSEJiNzVDN2tIVVFDd2YxdkVCRmNWSU5sNnJLejVQ?=
 =?utf-8?B?SG5NZ1RZcmdGcTFHakQzUkQ3Zm14dHBCRm1HRVRpQ1FBS0Q5ZmRtcVhZQkx6?=
 =?utf-8?B?bkNjSkxaM21sUFR5OVFRQnZjNDNrOUlla1ZiWTR4azlwTHpQQXJHUS83cyt2?=
 =?utf-8?B?ZG1xQ0VLTW10ZnFYV3RpNFAxcUwzaVlnZmdxa0RNdWRMQ1Zhcy9FdjNTbU5y?=
 =?utf-8?B?Z2xvaFFqMjJxQVZhYkJEbklpU2dFYWtmQys1UUw2eHFKOE5BMDJ2aUIwamR0?=
 =?utf-8?B?WlY4U2hWazlnZE96WERJcnA0YXhaTGlQZFRBdHdjd3J6d1ZrZEVtd0F1Njlr?=
 =?utf-8?B?MkxZWm9PMDVRR01ORE1IcHkrUVF1NFlZZktBdnhBTjhIM2l4Nk9KRjB2VVox?=
 =?utf-8?B?RVRveG9SMTBtbUQxZXRQTVU3NkdHTUo0LzNPOVhFTHJNcDN1eVZ6cE9uSEdp?=
 =?utf-8?B?Q1luUTlXUmN2MWw1dk96SWpSTVM3UExKb0ZkYmREeDU4dmdPUzZyMHdkL2Rm?=
 =?utf-8?Q?LpjpSJXY6iKq1jbF82JHksUFLw3OY7veAShVc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wjk4TjlUTUJ1U1dwOWdJKzdhMHUraEdrcXU0QjFWWUhXN0djU1hPUEVYa2t4?=
 =?utf-8?B?ZjR6WVBhdm1KZ1hmd2lsRkZPVzl2U1JWRFYwdFdjY1VmUklmRGloS2c2bEFx?=
 =?utf-8?B?TGZHMXc0YVg4REpORWNoZU1KV3Z1ZW51MWg2MkxJaW12dXdHcVhuQ21SMWk3?=
 =?utf-8?B?aHIvOHVSVlZtT3RCSjg4anF3YmNhOFhjQ3BMMWE3Wmw3alJpMWVtYUgzOHZ4?=
 =?utf-8?B?RCtGTlcxQnZMVVhUV1A4ZkZqT203U3N5aEk5eTIrRk5uc2MwMG9iMHBPYWZt?=
 =?utf-8?B?QWR5Q3dtTE5UWnY0M244ZVh6d0UzelFNc2F3R3R4cEFOaTh5cUlJQzlwelhI?=
 =?utf-8?B?b2pyY1poV0N2V3V4MGV1KzFVWmxsUU9uQVMrQjVZUThvRktpeTRsdnBZa2RG?=
 =?utf-8?B?ZUhBY2trYVpGN0twVll5TFpqNTc4VjdRbTh2dWFEZDNlWUhOd1d5TnFwVGJ6?=
 =?utf-8?B?WlQ4aUtTT01GRk5IOTNSbXdzOGNoaTZ3bmZBRkw3Y20zcTBQOWdlUytxMXd2?=
 =?utf-8?B?K3hHcHMvQ0tEV3NwZjN6NUVldVFXSDVVMTZSTzZ3aTNZcmRsd0hRQ29rdmIy?=
 =?utf-8?B?Z0xvazZRUG5IMy9Pb1J6b0RERFYzR1pyYUJWUWNsWDliRWk2aG1Cb3kwOVo2?=
 =?utf-8?B?V3U4dWVOcXkyWjVrbXAvWUZqOTkvMmVuajF0emd4aHBSbmpvZXo0VjBDQm5h?=
 =?utf-8?B?N08rRTdneXdpWkZxaVdFV3BhaXFsOE15dEtUM0ZGempkclJocnF1OEJQNEhZ?=
 =?utf-8?B?RUxGQTljL1hDT3hneGNOdURyMmJDcC9KUkZydUhIdzk1aHZqVy9jWnpXcXRx?=
 =?utf-8?B?aVE4Nm1ZQjY2UzJVbkw2M2hyTkN4VHEyai85anROOGxVVnZNOHhDZjAxa1Ro?=
 =?utf-8?B?SlNvYmpTTmROMUZXbkFuTWoyb3o3WWZjdk5yN01xNXAxRk45UGZuN1N6blFo?=
 =?utf-8?B?aU1aWG9HZ3kwZndXV2xKQlM0MnllNkNpWDVsVkNvMHVGajllenhDRnJ6UEx0?=
 =?utf-8?B?MXNuK3ZMTmQvaDcxeUp3eStCRW9WK3JHUnJ0M2hXQWt6SjhjZXdHVXhMd0ND?=
 =?utf-8?B?a21aRmZmMmlrdUk3YlR4WGY5dk5Qdld1ZGR2UXBkWVNoTXhvSTY0KzRwNUJJ?=
 =?utf-8?B?ZVdEZVh6RnRhd1d5aTUrblA3RmlJUVF2TjlmRUVmTjZsQlNLWUFRLzhBNmdX?=
 =?utf-8?B?MW8reVZRL0xsa1ZuUkFJaHhXNjhRUDdRanlhQUoxaHZQaW43eXV2SGtKUXow?=
 =?utf-8?B?azVDWk9HcVA3am1kdmY4eldMbUVDKy9UV0huYWJZVDlCUWE5MHk3MFdzNkU2?=
 =?utf-8?B?b25XMWVqS25XOW81c05LTFhhcWlkcFVNUW4yOTR2bHlrTE5ENU9xWGlqZmhx?=
 =?utf-8?B?ZEVaK1NCS1BFT1JTWEVuNDVmZkZIMmY2bGhhaUZJUU1xYjRUdHRPRDR2V0d1?=
 =?utf-8?B?NUxabzVQMHUrNWFySm84cjA4MFI2NGtNZHNSd3FKVVpJcUJJZVRVNHJNY3Rw?=
 =?utf-8?B?Mk96TGFzalFqRjlOUE5aQ2VTM0duSE0zS0dMR1E1UTkwNHNUOGhoajdOZHQ3?=
 =?utf-8?B?Qm5CUlNXVFpoQVRjTTlFRWd2K3lpZ0RtcVc4RFVUYUVUZHlvNTZNSDlYMXF0?=
 =?utf-8?B?eDVOcE9BSjZSYXByanlKR002SGlBWVNycy9FSGpSeTdmTGxTUy9idWhxdncz?=
 =?utf-8?B?dDUzOW5xeFJWMmpoNkFiQk5kSXJZemJpNzFJbDQzWU9WSTNxY0c5dHRRTHNZ?=
 =?utf-8?B?R2lIWG16V2lBYXJxd1FBTWFncWt4QS9YUFBzN1FuTzNrYnVhcC9UU1pOS2hE?=
 =?utf-8?B?WVlWQ1JGTEFYeDgzMjBmWG0reUlpM0tPRGJCdzc2UExMZjRSVXFCelBOS1hO?=
 =?utf-8?B?UWZNTEE0cGN5eFZjNDFoOEFpQitNc1h2UFFuSk51a1dQYnFNVmNkVjZWWGwx?=
 =?utf-8?B?U2E0c0V3anhncUsvTUlIRmk5N01UblpPcFFUU1FBZzYzNXV3Qk0wanF4NURD?=
 =?utf-8?B?Yk1uSEp0a2ZwOU1DRjB0cVA4a1E2YkVRL3MvdTJzR2ZWZ05GY01icFRCeXFM?=
 =?utf-8?B?YVRUNnE0NHNjMkxpWGNOSGk3bW5ySnNPcUtWNXYxaENnWGtkYm5TOHM5d282?=
 =?utf-8?Q?hviKvE3z2QCUoyjpiqhXs6XV3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4690dce-196a-4aee-9005-08dcf3370ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 07:48:10.7866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xcn5OHtZw2iSU8ZYWWMclrTwno0JD6wBWG6LuDagzdYKpYwHHM2Fuol5PeBJO0tNi56PX3XYZCVpBbjpIhmDl2ZmHCpDUZZkpWAQuULsqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6056
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJhb2x1IEx1IDxiYW9sdS5s
dUBsaW51eC5pbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGlvbW11L3Z0LWQ6
IEZpeCBjaGVja3MgaW4gcGd0YWJsZV93YWxrKCkNCj4NCj5PbiAyMDI0LzEwLzIzIDEzOjE2LCBE
dWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+
PiBGcm9tOiBCYW9sdSBMdTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+Pj4gU2VudDogV2Vk
bmVzZGF5LCBPY3RvYmVyIDIzLCAyMDI0IDEyOjUwIFBNDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRD
SCAyLzJdIGlvbW11L3Z0LWQ6IEZpeCBjaGVja3MgaW4gcGd0YWJsZV93YWxrKCkNCj4+Pg0KPj4+
IE9uIDIwMjQvMTAvMjIgMTc6NTAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+PiBJdCdzIG5v
dCBhY2N1cmF0ZSB0byBkdW1wIHN1cGVyIHBhZ2UgYXMgbm9uLXByZXNlbnQgcGFnZSwNCj4+Pj4g
bWVhbndoaWxlIGJpdDcgaW4gZmlyc3QgbGV2ZWwgcGFnZSB0YWJsZSBlbnRyeSBpcyBQQVQgYml0
LA0KPj4+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gaG93IHRoZSAnYml0NyBpbiBmaXJzdCBsZXZl
bCBwYWdlIHRhYmxlIGVudHJ5JyBpcw0KPj4+IHJlbGV2YW50IHRvIHRoZSBjaGFuZ2VzIG1hZGUg
aW4gdGhpcyBwYXRjaD8NCj4+IFdoZW4gaXRlcmF0ZSB0byBsZXZlbCAxLCBpdCBpcyBsZWFmIHBh
Z2UgdGFibGUgZW50cnksIGJpdCA3IGlzIFBBVCBiaXQgaW5zdGVhZCBvZiBQUw0KPmJpdC4NCj4+
IGRtYV9wdGVfc3VwZXJwYWdlKHB0ZSkgbWF5IHJldHVybiB0cnVlLCB0aGVuICIgUFRFIG5vdCBw
cmVzZW50IGF0IGxldmVsIDEiDQo+bWF5DQo+PiBiZSBwcmludGVkIG91dC4NCj4NCj5JIHNlZS4g
VGhhbmsgeW91IQ0KPg0KPklmIHlvdSBoYXZlIGEgbmV3IHZlcnNpb24sIGNhbiB5b3UgcGxlYXNl
IG1ha2UgaXQgYSBiaXQgY2xlYXJlcj8gTXkNCj51bmRlcnN0YW5kaW5nIGlzIHRoYXQgZG1hX3B0
ZV9zdXBlcnBhZ2UocHRlKSBzaG91bGQgbm90IGNoZWNrIGFnYWluc3QNCj50aGUgbGVhZiBwYWdl
IHRhYmxlIGVudHJpZXMsIHJpZ2h0Pw0KDQpSaWdodCwgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==
