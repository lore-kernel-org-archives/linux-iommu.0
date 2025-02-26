Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871820459F
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553845; cv=fail; b=Y30aTA9Iw/W0r94BozTAPXH06eU7MnCWOV+0fkPl5/I0JhMGTtlTT0kT+8mkmcOV2HOgqpKoZzNGX4rBw0cUF+EQ6LYXkSvt5RByYxLsWrSEGwCREnWPKRrbwXwzaT1BjmvVjxA3M0ufmtSNllTmyMdzmvoZW2EFtvkzQKAvrAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553845; c=relaxed/simple;
	bh=KwJeyISuGpilxwzIHhR02F405srqvOou90lhne3E3c4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=brY3Io+4wOkeNTzqHNe/WEscQOaOln4ZJi5CQ8/MIsUdPoq2iEGgoSA87rVnJXRR8NsiIffW67LDwc294AatrfC5g4asmrhEwn0Mm0X8fM/q+jOGWR/mYHkpCwXbNoXNxeceLnoXBSCnx3UulidNtTPdyIkZ46UheCKRARCk1IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHLz9a4h; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHLz9a4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740553845; x=1772089845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KwJeyISuGpilxwzIHhR02F405srqvOou90lhne3E3c4=;
  b=hHLz9a4hoLCdoMKwuZLXQxPrmMgfNYZHGqpFSQBO5KRmmxvV0wZHynds
   gEssrmB3+DzrUwQCPvmAjy4+BmuPzcvwHku/Gu0xC4Gd8Gsrrl7pPB2PQ
   WNnzaS1wOYsvLeR/XDuc8YSNuGH/QMmAOzsMyJhrl4XvEMkEt1juzkM/c
   71Z8kGbXSKmLa5bOGBVaOrItH4XJ4LD+WKyGcsJQqpxadHP4TeGB+Va/U
   jRFyW09KWQ8OAf/MqYCt/I5nYFPkpEDEjSa4RqRNunmja6sfTvkmB4RA4
   Ix8CrLyjL2LM7zdI7iK6sCkAvKfJFnDN2A9TeTbaQcgBMt0yBaw+jZlEB
   Q==;
X-CSE-ConnectionGUID: GAQNfpIuR56GA2Nnk5GZyA==
X-CSE-MsgGUID: T0+uIWcOSKKWnHpiFjlhKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41406442"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41406442"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 23:10:43 -0800
X-CSE-ConnectionGUID: vTI+W0bcR9y/D3e5ZevEEg==
X-CSE-MsgGUID: JLhOXGVfTCWVPrHZpQLSyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="117240498"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 23:10:42 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 23:10:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 23:10:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 23:10:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsmBDUo2JqPK1oJkwlUMu3Niw9+axzXl324du64nBuEycNSMQv3O6z1rE2hvObglzqiOnoWClZHeF1Jhw3JOWPGKiKJL1sMFENJ7pxaLVs8wFEkf4C86eRe/W5UeiLdNrC9Jw3EPRkGyMedbui9v0hoaau3zlZZ4tEo6IAKlv0ubnXZGsUI16N7zJPwyU2Xi5kG1imswdKtcaQfT0IQJ+Im33NookfCYzn45HX4/Vwu0uyss/oooc+wOoEP11vk6SAYL+icoVArApLOEBixQNK51KFHNNdIQkjDSQ1W0SXFDm63o59Bu6l0q3tg6dXLZ2qx1aQXqKxHB63FtYwEQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwJeyISuGpilxwzIHhR02F405srqvOou90lhne3E3c4=;
 b=SnCFjLNsEaGw58yqYTE7pTLWq7lqd6LZK2tBPu1DF4ulc+ADoVe6Bt/W9B8AtM8hmrmuApRxbX4kBQCm6VxRQG3p+Y6H/IDLjFFxIgk22nnmuch8m93usC6VLunjGggRMX7eNl9rHTpj2PRSTeXIsMeG0PMNTHeHN+A34JZXjDe1VkrFyPNMfEVSEiqB+jrBITc5rcU/LOgHzk8JAPaPRjqi66+XSrSMipKI/nc6J0F3X+SrUgu75OEXYH6b113TvAqHtCuafukZTmIAtRFPVGG79mD6x3qfDRCVT4ziwYrUYYbotHnEvhq4RQlrDaan+0J029tOuGzoUycLeplI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7943.namprd11.prod.outlook.com (2603:10b6:208:3fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 07:10:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 07:10:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Robin
 Murphy <robin.murphy@arm.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAA6H6AgAAmfHA=
Date: Wed, 26 Feb 2025 07:10:20 +0000
Message-ID: <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
In-Reply-To: <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7943:EE_
x-ms-office365-filtering-correlation-id: 3fa4acbb-0d03-4190-f9ba-08dd5634a184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXhxNktkRGQ4alNZTUkweUtoVkE5OWVPcjR5Yi8vNGJXb1ZzQ2JYL2ZQSHV4?=
 =?utf-8?B?UzZPNmY5STZVWHk5U1hkanpTbkh1QUJLbks0am45NENkbWx4QnhSa1FHa0FO?=
 =?utf-8?B?UFZjYlVHbXpNQmNSaGRiVklhb0xTc1NCajVmYlIvZy9wUlB4V0Mxbnp1L3My?=
 =?utf-8?B?a21sQ3ZWMWhJb3ZmSjF6SlVzSmZmL0FvajdaUE1GaytIY005RENxck9IZ1BY?=
 =?utf-8?B?dXRodkYzeUJrWUVIWWNaSDUyRnhhRFJ0UVgwbW9SYk92VVVUWDFmdUhkZWRv?=
 =?utf-8?B?SVMvdXRlbXRkcUJKYkZkNTJLakFiQWFyb3pBUTZGNlJHZEh4cm5CeGhwR1Bj?=
 =?utf-8?B?eHRFZk9Hd1hyQkZ6a0I3U3VCTTFFMy9HaWd3Q1pmTVpCZWVWb0VoeGhObzlX?=
 =?utf-8?B?RHhNdHNvWmdLa2FoWDlRdy9HUk1OZVlRbkh2ZDV2d01DQXBVZi91Q1BEQWk5?=
 =?utf-8?B?VnhXMVNoWUNHVWtJZXZKT21BcFpRcUtleUxGWGFUNTFPbXhBUC92ampUL0xE?=
 =?utf-8?B?aksrK0JlY0QwOGxkd0tZY3Fnc0dtc2RkVlNaNWlReFNBMTdneXlQMjZXZE1m?=
 =?utf-8?B?OVYyU0JjL1pLTzFBSXIwbFAxOFU2QklaR1lkdGcvQnVuSFlHZ0FSdENpQktr?=
 =?utf-8?B?OG5qMFRUdSt6bnhmWmZFTVpzUzk5K0dzYUVBWUFNRGMwaytsWWcvSWI0R1Rx?=
 =?utf-8?B?a3FUTlZUaFBBQkU4ZUEyQUhvd080anAxbWlpelk4QWJRNzYwTEgwWmYvWlpt?=
 =?utf-8?B?QnBKUDFJVnBWaEpsUDVHcUxablF3TFVQVkJzMHg4bVh0OW9ZNEpIcEFYQ1Y4?=
 =?utf-8?B?cnF3dnkyYmd2eFFFUDU4cHVNak1hVjZqV01xUnM0V0xFais2MnpySEtLZlVD?=
 =?utf-8?B?MVNPd0ZyS3NKR2pmTCtWQTlGTUYxck1pOUx4SVJzNjcydjVYcUQ1emJRTlVL?=
 =?utf-8?B?NzlkTEV6SUNDVXgxK0RUdjFtSjc3a3FldzlFSWRaVDJOOVpMYmtoYkI1M0hs?=
 =?utf-8?B?aW8waGQ4NDhJVkRNR2owY1RkVnFud3IyeGVxeDgxU3RFYlpJLzY0ZmdxMEZN?=
 =?utf-8?B?TzdjMkpqTU1tUFRacktSZEVvcGpISVY2dWZtYmhER2wwVU15aWU1ZU9Nc0Iz?=
 =?utf-8?B?MnM2QmpYUWtpdWpVZEY2cXJCeEltQkgydk0wN056cnR2NzVoRWJ5M3BVUkNK?=
 =?utf-8?B?UWt0emh2UisreTViZnlwcnVoYm9mbUpNNmdTYURaMGRvcVhyVWhITWxLTE8z?=
 =?utf-8?B?R1hBTFBMOGdnUEEyVitlQ1Z3Mmg2Y2NxZ3RWQzJpUEtqM2E1ODVXVzJxUjFm?=
 =?utf-8?B?ZFF5MnJTcHB0Nm1VMStzWkwwZEllYXRCNGp2R0oyUnQ1bHVIOVl1NkNYRDQz?=
 =?utf-8?B?bUkvMFp5aDl0ZmxkdGJTRWJibkRUb0pBRXZpYVhGZDF1eWZRRU5YckpDaklk?=
 =?utf-8?B?S1VDZFg4Wk04bzIrUDV6Y3lqa1RCam96U3YvWEUzeklWT1VZajR5Ky93KzVx?=
 =?utf-8?B?VzdqYnh3ZGp2MGVKdDhXSklGbXhlRG92MUJXUTdVZjdKblNNVEVVcldqWFhn?=
 =?utf-8?B?U2hNVFBvWVo4a3kvZHE3Nk5hRkpkRStIL1FrSUVLS2JKanBqa0s5ekpKS2cr?=
 =?utf-8?B?dUpCVG1ZK0JZYldNYTJJVElpYmJVSXpnVUp6N3NJb1gxRXJJZ1dHcll5Uk9k?=
 =?utf-8?B?aDlXa3JkUFB4bVpwU2lhS1M5K05HNVRReEc4ek5vTjVvc1ZHTDZDdlMwZ1Rn?=
 =?utf-8?B?NWJ3a1U2M1hjTUVYUDZENlhlRlUvVmZISEE2TjRpVmFLUUxZVlpFOWdwMkxQ?=
 =?utf-8?B?d1VHYTl5dnNjaUNCVWt0SVhPRFkvRHlLRUtKV1hGR3BPcWVWcm5pdnlKNnl3?=
 =?utf-8?B?cy9JUzM5ZXZRQWQ0SUV4b09TODJUSWRxZW5KNUttTmZIVjRJZ3ZIaGs2YmZQ?=
 =?utf-8?Q?q69//3Z/8PDR1uskYvcmHSksVEEzHKaW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnBmbHR3ZVo0QzlHU1JrRTFVallvaG0wMGZMRXJVUzl2UmRjTnNzTytYaW9M?=
 =?utf-8?B?Y05MQzFHMmdQZVB6azZ3WkVYVHdMaFlXVzBLOWVWNndmcWphRjBQZUhCSGVw?=
 =?utf-8?B?UEtFZGV4OEtRMkpEVWpSNzF0elBWbkcxSlpvaG5aR1JsWVlMS3hMS0pNeEF2?=
 =?utf-8?B?eWdibjBYd1VsOHVPTERwR1R2V3ZQMTduSlhnd0VqTncvbk5MMXpyMVppZ1Nt?=
 =?utf-8?B?K0FybEJsc3p0Ui8zR3poOE5za1VMaVRtZmxoQWdZZE5Yd0txQTNZemNCT04w?=
 =?utf-8?B?dU1xaFZSM2tkM2laMldtUUxOLzlvdm5wL1FmanhwSUphbW5DRnQxUGtYclNU?=
 =?utf-8?B?anFocHBhVkJjNXhNYThOaTRUUG1TbXlzOGthRi95L01DaWZOUWUzTGNpZnd2?=
 =?utf-8?B?RWJLOW5tdS9zZm02eksreWlvU1RlTzZQenpuU0w3bkNQNUVXaWFIWEJoVjRl?=
 =?utf-8?B?ZkdCZzc1Y2w3akZHTklpTjJiUlFvZWs1YWZQZXRBN2xGT1ZiaUlOOVVqUDBT?=
 =?utf-8?B?NVE1a3M2ZUFZRG9qR1c2VlVPUGV1U2hNbFJIRkp4YzMrUWt0Y2VCS0xEc0dH?=
 =?utf-8?B?dDh3WVJjTjBkWUs3U3ZkNUs3YXBIMmpwMzRmckhzWG5EU1J4b05uUTRsRmw5?=
 =?utf-8?B?b2Mxc253UnVoakVOOHRnalMyOXFId2VNOFdpdEVuZzZMTUJFUmdPQWsyUGZW?=
 =?utf-8?B?dGdkRStlUmZGUVFDdCs5RmtRVzBKMnVuMnRFSW9pTk5zb3lSSEpKYjRqcm9i?=
 =?utf-8?B?dTRSZlRmRWtmUXI5ZGhCZ0IyUTNUUXNzRE1XQm93ejM4Z3pKZXlpUFJtVWEw?=
 =?utf-8?B?N1FDNmdLL0xkL21iR0cxU3RySjlYL3d4MXhhZVZjQnVybWVFRFhqdTRwSG52?=
 =?utf-8?B?RTJyOGlYOGtwYi8wcE01bzdKUC94V1JTVVpldU83OVlJN01hTlZjMlJ1N2o2?=
 =?utf-8?B?VlM5UUl4NXpmd1E2MGd6dkFzbG5YejBIUHhtaGw5bldwSHlmMEZCeG1EL1h4?=
 =?utf-8?B?Smk2T2R1QnljVndvSnJyL3hoLzBYVmpJa0E2dnB6WWtmbFZnRCs5M3NVU0NL?=
 =?utf-8?B?MzlDbEpHRUN6UnVWaGVvWHBGUzI4YTU3ektJN0YrYS9NSktxOHlydkRYY0pN?=
 =?utf-8?B?aWRsK0NFYmJEYlY4bGFuMU1JcXZNeTlaaDRFMndvLzlGZm9FL3VIT1pBNG1m?=
 =?utf-8?B?TjdpVmJrQWM3c0t4TzI0bkhvRGgwbk84c0NxOGxGaDlJanMyYUxHZUMwV2pW?=
 =?utf-8?B?THJhSWQ3OXk2WE1lZS9yTHJzQ0hpb1U0akZsUk12NEFoYXJ5N2o3clh4Tkxk?=
 =?utf-8?B?MEFwVm1ISUFTbWJ3VEoxcngxeGp3Wi9aK0NFRmRPc3A1cFl2SFE3K2F4SjNy?=
 =?utf-8?B?VW9FMXgzSXZsVHZnb3VRZ1l6NldDdFZaUVpiekZXZm9lR1FBR1plLzE5eGxO?=
 =?utf-8?B?OWgyVXdmaUNkbmR5STRPeE1WVytNVFhwY0RXamI0U0J6K2ZRNVlydUNDZ1Y3?=
 =?utf-8?B?M2o0ejRLS204Q1dxcEtZcElBRXhaZUhWbGpUdzRlTE81eDlnRFZyQ3pkbkRE?=
 =?utf-8?B?SmUzS2dGY04xUUR4aUR0WUFWaWpPYzE5VTFiaFRYZmNROE5KeDF1Tzl3ME1L?=
 =?utf-8?B?Q08xYUFndCtQKzZhZ2RuU1IwVmRtcmlrVkQ4c1ZNcERoZGQzaFdQenFRRm93?=
 =?utf-8?B?NFB4QjdVb1pmUVlkUHhDU2E0MUVHMy83VExKNXZCNHUrV3FIdWsyc08yUERN?=
 =?utf-8?B?NWp2V2tSQUlNeExLSVlmZkJFN2JlQ3BQcWJSNlNpVWY0SHE5VkRpdHpkVlFT?=
 =?utf-8?B?WkF4TkdIc2ZyTjFxajE5aGtuV2dHZUtNNzdIYi9uOTRuUzUvRGs3VVY5S3Zy?=
 =?utf-8?B?eGNSWjUvL3ZNZDM2NW1jd1V0dy9WZnIxNHgxazJSVzBGTVBYOVU1WWE0dEor?=
 =?utf-8?B?WnZaSzlmandTTVh6SDBtNG1CeWJDMVVkT2UzU3hscTZSeFNFV1lQL0RJd0NQ?=
 =?utf-8?B?WUUxWkJvVjFKcFJvVU9yQUw3dzlkQWNOUjBLVXR1dllPbTNUNG5YNlNBRjcx?=
 =?utf-8?B?TDBobUxJSlR1ZzVtSkZxMHdQVVZMTllEVUtsTGpFSjBMOE9GbGRGYXB3UC9W?=
 =?utf-8?Q?QFT1zIZQQ+1cu1w5rIOwE78nS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa4acbb-0d03-4190-f9ba-08dd5634a184
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 07:10:20.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQstCx/i/7kPGnsGu4xLdmvOBf2Kt2WTO++rJZu+OLxz738jyZKv1KgISaO5sAtDVKZFzfhDOSiYUKVlMGjSFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7943
X-OriginatorOrg: intel.com

PiBGcm9tOiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDI2LCAyMDI1IDEyOjQ3IFBNDQo+DQo+ID4NCj4gPiAgMykgVEEgaXMg
YW4gSU9WQSBhbmQgdGhlIElPTU1VIHJ1bnMgaXQgdGhyb3VnaCB0aGUgZnVsbCB0cmFuc2xhdGlv
bg0KPiA+ICAgICB0byB2YWxpZGF0ZSBpdC4gQVRTIGlzIGp1c3QgdXNlZCB0byBzaWduYWwgbm9u
LXByZXNlbnQNCj4gDQo+IFllcy4gQU1EIGRvZXMgdGhpcyB3aGVuIEhvc3QgcGFnZSB0YWJsZSBp
cyBjb25maWd1cmVkLg0KDQpIZXJlICdzaWduYWwgbm9uLXByZXNlbnQnIGltcGxpZXMgdG8gc3Vw
cG9ydCBQUkkuDQoNCkJ1dC4uLg0KDQo+IA0KPiBXZSBuZWVkIHRvIGNvbnNpZGVyIHZhcmlvdXMg
c2NlbmFyaW9zLiBGb3IgQU1EOg0KPiAgIC0gQ3VycmVudGx5IG9uIGJhcmVtZXRhbCwgd2UgY2Fu
bm90IGVuYWJsZSBTVkEgYW5kIFNlY3VyZSBBVFMNCg0KLi4uIGhlcmUgaXQgc2F5cyBTVkEvU0FU
UyBhcmUgaW5jb21wYXRpYmxlLiBBbnkgbW9yZSBiYWNrZ3JvdW5kPw0K
