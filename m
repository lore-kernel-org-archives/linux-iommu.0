Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0654468E
	for <iommu@lists.linux.dev>; Mon, 20 May 2024 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716179699; cv=fail; b=eOVtUCcKwRnGZH+QZf4k6c0dTDiXUWGYbUkNZKQKpBblVEpNJ64G7tcc/TaIcMLvILCFVY2qccTsUbOPvWWi+bZhUI49SzQJT6clOCUFAhLqcPzl/0Hsojpctx8GeGjN97RF9x7WZOkoqLudNMeojGK0f/33rg77L/9t3lkb7yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716179699; c=relaxed/simple;
	bh=klTM8Ws49rI1vYo/uaAw63Rxr7a1KSpk1OODpwCN5Rs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oyj3bLBRkkZpIx+sjg0DBy/s3pBqhTLWZ7piD6Xx/6h1ki5x4DvHBBobKdi0IIloF1VH31LG81imlpFxcec0f41X3ogg5S4E5iIlc+fF2tP+StDQMp8NI+iruDDlKY8qfjfd9C4QLZchE7aqyXV4E3YktrpYMaKXgFECcD8Y8SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrLZRpf2; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrLZRpf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716179697; x=1747715697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=klTM8Ws49rI1vYo/uaAw63Rxr7a1KSpk1OODpwCN5Rs=;
  b=IrLZRpf2Fh//y1pUvXBMRbL3jjuMk5PunHh/MpxcE8brn0RaV7zG3KcC
   zVbYe/RWkwWJx0bBWxngLXbF3L845Fw0PRLijKOCDzFzo7vqg61CinreQ
   LbpMgH7TsrmIDV9XrpWt9/zPwDsPPywUKicR7+A5ICTx0EV4nNWiYIR+D
   ZISQssMvo6WaWAfADI4/LLRKAMjE8W7hvU/U7sgughlg7S7dvChqm+3W4
   bcF+jqwJScc+r3329KZ3R1awamIvx/cEj/1aVEdTVu/bdwJ8y4UmiFVi7
   0l2oFHUpMj2i77baMtdBtXtf38X2ywZTQIY9xQky4J7fHi4UAKiQZUH8l
   A==;
X-CSE-ConnectionGUID: XIjBQmu0RPelk4FkLEjrPg==
X-CSE-MsgGUID: 5Ya6LE+zSVmzAjrSrAxe4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="16078266"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="16078266"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 21:34:55 -0700
X-CSE-ConnectionGUID: qP8JA14tTFCEu8cptWRajQ==
X-CSE-MsgGUID: uyzCjJA9Rn2D4B1/YU1dUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="36982252"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 21:34:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 21:34:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 21:34:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 21:34:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvMakWsUuNXqOMupoRHPxhBozYoxGPbs6PI2gxqfLudM8g5BDXxmo7phblmk275WSSobWUjdZpIBLtG5LecaPL/ziDqJdlcAxHpScrMsbWwGMtyqgb0M1uV+cJgaYG1ymJ7gRsrSl9gPOrrivQZsuVsqzyfMJbLxfWuXsbFBvDK3MBDn65Iw1ifgylnPFSHtmRLvgo9E3hGChRDw7MPCQlhewv/vF5XjT2LuSVWe8XAof9d0yV3GX5yBhGZpI03hCFt26lFIBbDsqgY8Iumm3wE3yizgCa6Ah2Z6+2Mof5DgwOD+Wj4YV1Upm7c83Yqm3VrCAp4JYTBBKmh75bwk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klTM8Ws49rI1vYo/uaAw63Rxr7a1KSpk1OODpwCN5Rs=;
 b=SFK0jklXtf1LzvFNQ/JF4Jj3fliLOke2m8KsVUM8zzbbIRNTXpM4taT8ugGKJYoONeAASklUMocwn0b+DebbGOOW2Vz6Se2gHXcl0dKuHRiCrUszaqjiCV0zH8ufLWWyYCBjRYYzKpxh+F0uBpss5xBANfEedyJcbaSJWFQCEnntdI7I3qC1sF6OTMoEcwqFdLsz0pCNlSTN2q+9cf1qurqFooafhWCmJ76be5T0xEHhKQnOf1qkPY0FFnAmLz8LAeR0CqnqUNnintUvba7t7FRiIbRF+J666QnbRKdpm0rkLJaFmcOGGn2X8kYhUbZAenUPT3TidXWyZ1OiiutPZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by PH8PR11MB7095.namprd11.prod.outlook.com (2603:10b6:510:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 04:34:52 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 04:34:52 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
Thread-Topic: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
Thread-Index: AQHap/JyA+quh6RCVk2aSVRG2G8N3LGeUfAAgAE70AA=
Date: Mon, 20 May 2024 04:34:52 +0000
Message-ID: <MW5PR11MB58816BFEBC3C4F8F668F330089E92@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240517003728.251115-1-tina.zhang@intel.com>
 <20240517003728.251115-2-tina.zhang@intel.com>
 <2b390228-190c-4508-b98f-1811c54c9e5c@linux.intel.com>
In-Reply-To: <2b390228-190c-4508-b98f-1811c54c9e5c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|PH8PR11MB7095:EE_
x-ms-office365-filtering-correlation-id: 854af515-1a5a-488d-c204-08dc788630f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aktpUkpJSGFpcHM2bzlXZ05McVNPQk9VTGM0SzlmMmprNy9hbWhWbTdOMWlE?=
 =?utf-8?B?clpFLzFsSWxLVmxsYlVaMG9ob29CSW0vS29LVjZqbDZwVUFVVFFvOS96bm5I?=
 =?utf-8?B?dGVlaDgxeWhuQWhzZEEyb2pQVkw4TnJXSUpJR3hiYWZRem9MRklQWWpvUWNw?=
 =?utf-8?B?N1BSYjdtaXg0YjVLUVZUQ3pqaUZ5bTlJcVhSMjJ6bVB0Z3dwcU9PZkhjZXhi?=
 =?utf-8?B?cGJ0SUkvcjZRUFJzQTVuSTZUVThnejhSUE1CNktXcDdjeDFsQmdhUmp1V09B?=
 =?utf-8?B?ZkZiVThNTitoMGJoREREWFVrbGZORVQ3Y0hraVRqWGlVdWdQbUtYTFV1d2tn?=
 =?utf-8?B?RVJVZmFZZU1ydjNrTWpaMURmWHpOZC9uM2FjeWQrQlVLUTkvaFcvQi95Ukpr?=
 =?utf-8?B?WkM2a1Ura01lZ2FRYkVKOEtjVExVUTFrR3J0ay9IWDJhbjZTMDY5UWIrNmdG?=
 =?utf-8?B?c3R4VWVLYk8vK1BFUmNPRVNJRlFNcFZXUGp0dzhaQUNkeGtROWQ1Qm1GTThk?=
 =?utf-8?B?MURieVQ1VlZnNzR2T0Z2bWFreUlaUmZiREozaERuRUVZUFdPaTJ0OXdjZGF2?=
 =?utf-8?B?WUFiRlNKVmlSbE1XNEtZRXVxSStVbXA2REdjVEFCZU0vVDJMUFpDeFNubGhx?=
 =?utf-8?B?a25PL0tQb1IyM2VOcS9Nb0JTa3JKYTRzWFRYRHU4YzRQUnQ0UjFmeGptOXJI?=
 =?utf-8?B?OW5XeDB2cG9nd081ZFVXVUU1aEV1ZnVtNEdEd1M0RTcvY2MyOHlmODZTeDhv?=
 =?utf-8?B?cTNrYjFLTnoxWjIwWnZtTXBoTlI0SHBpclBhOFJ2L2ZoL2VMSWMzVEVPMnRi?=
 =?utf-8?B?bHRGdnJmeEVycStaK21TdjNXZ3ZOYXk2eDdCNmVkR0dJN3RkcUd0UUVsdGV1?=
 =?utf-8?B?bjVvUHZ2OW9kMHhPS0lSZ1ZwMllEK2Ryb084bWhHUU81SjdnNzJSYmN6ZU93?=
 =?utf-8?B?SkMyYkt3Si9CYjB5dHkxYUVGMldZT0lqL3Zoc3dRQkZvanlQQklsMHcrTWpi?=
 =?utf-8?B?YzdCTFVydGdKZ3ovTHZ6Rk1HSk5QTTI5ODZXdkpSYXNPRkJjaXdCVFV5anNJ?=
 =?utf-8?B?OTh3TExuVCtVQjN3MEFpc3loSFF4UUhUSHdFZjZld1grWTVOZnM2dnBwVXND?=
 =?utf-8?B?dnZuZG14Y2hINk5jODJmUmIvdXZ2eW90cjhZMFJUeUFEcWwvcXh3Q0FNbENH?=
 =?utf-8?B?a1RSNUQrNitkR21KaTFpczhRVnlveWVibkpBdDM0RjR4TDRuNWRqcTBNMkZp?=
 =?utf-8?B?ejRiQkROZDBXekRYTXpFZGJXbWVWR0JtLzBLRVpPdkxtTFNXUVF5MlF6bXNp?=
 =?utf-8?B?Vmh1Z3gzS0RQL29TdkdKK3B5QllJaTh1eXZKQjhoYXUrUnE2aEZRYlVCM21u?=
 =?utf-8?B?MjBYOG0rTFY3eVBCeDNNRXhkd1V3eGY1bDFadisrMkhtUDhpWmQrd05MQTl2?=
 =?utf-8?B?eDdQTG1ieXBlR3hXOXBpdWFsRTdrODlpeC9FcWhmNG5pZDZKN2pVSmJFczdx?=
 =?utf-8?B?V0Y5c2JCR2NMaTRON3hQQUIwZDNCcDE5Q05YZTJTWFVEckh6Tk9heGhBNHh2?=
 =?utf-8?B?bUJ6VWxTSEdQVnZGRXA2ZW5maWtPOUpTVmpuWXVoV0UySzhlM3phMTA2bHdq?=
 =?utf-8?B?TUpLU0llck9NanlOZWV1cERncmVxWHhYdDR1RnExcTJIT3o2enE2cjFINVNq?=
 =?utf-8?B?NVFxVVZhdWl1UHAwaDRBSVh5Q0dTLytwdDZqM1BJZzM4SkJ4T3lOcXdmbGZL?=
 =?utf-8?B?QnBNRFVJWGlvT2ppUG1oY2pUZkc2NFlPU09sRUlkU1ZROEhqUTM5UThPbXNI?=
 =?utf-8?B?SnBaWFhLemRpamgyaXl5UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3VkZzMvc2ViUXVUZlFuYUM4L05vdEkwcFdZUHMwR0NBMVFnTW5YMFBRazRJ?=
 =?utf-8?B?SW5Feng0b0c3QUNLRURSNmJjQmtRWlRROTE0QmVLeWp3UkpVTWlGMjhNSjVk?=
 =?utf-8?B?dGJRTFREQnJwZjZaT1hVL1dFNVp6R1g4ZjJPY3RsQXlrVzlLSDliM3JRRUVT?=
 =?utf-8?B?eU42a3BaYTI4OXdzVFNXNVE0Rm41SWZxNkM4N3hWMmQ3OTg2S2V1Q1o4VU9o?=
 =?utf-8?B?MjdRMXhxclE4anVYOHBGQ09VbmNpdmlYNUk1UlNXS3lFaVVtTjF0WmpkZmhH?=
 =?utf-8?B?ZS9hckRxYS9nMS95V2MyNHA5UDYwQlgxWVpDNzY2Njc0eGk0cjNOK3BYYjBF?=
 =?utf-8?B?VE9wb3hBYXBMdHNaVm1mTFR3dmpZdnZzTkxBRUR4K3F6K1pGaGYxelBpM2Vl?=
 =?utf-8?B?WFdCd3I4bllzL3NpR2pLYzhuaEE0aytydm5JTFpHRUNnSTlCMGVoK0JMQ0Nx?=
 =?utf-8?B?MGdYN0J3TkU3S0dqRWlIcmZYQVNMNktwcEtnR3FkV2wxRlZjaGxRNmF5YmNS?=
 =?utf-8?B?eU54WXhyY3ZHWDJCaTNRNW1wTlNVcE9PakQvRlRFcVhqU040OVJnYVlxbURu?=
 =?utf-8?B?SlQ4eHRIMFREblNqY1Q2K3pRWThXZlNHNTQyVDFKRnBsSTkwSDkrODhEdU9F?=
 =?utf-8?B?R0piRnhIaHhwQzI1MkdjbXV3N1lZNE9jcE9mSWxUVTU1MDd4aURhekNMU2Mx?=
 =?utf-8?B?cEZzODF6akkxNlVlQUJxUVpCRFNxeGcrYjlPUUNIaGp2aGFrRTZPR1BLRENm?=
 =?utf-8?B?d2Zqa0dBQkpNSGlyY3k0WWdsNDM1YzU3OWlVcGYxbGludWJrL0h2SE5jcFZ4?=
 =?utf-8?B?TVBFc0pUTU9GNENZSllyVVBrMHhZRitUbzVOOEJlNlkwMWRNVXhCOFpwbFQv?=
 =?utf-8?B?Yi9lZ215bWtVbDNlTDZZN1Q4UlVZNEJJcVFlbzNVNjY0SUdEY0lBOVgrVEZO?=
 =?utf-8?B?d2x0d2p0OERmQlBoUkFnOVdyRmx4Q1VMRjJZODZ2anU0STViTzNEaFNyb1hk?=
 =?utf-8?B?VUozUHZNTnQxWnpBZVJDN3QvcmlPMFdTdjhJSEQvcW5hZ01VVXpSeFh5blc3?=
 =?utf-8?B?TWxDaE1oMFBqc2s2d3VRZWlocC9tek5QWDFNSy83eXVkZE5RTS9mUkNUeWcx?=
 =?utf-8?B?dWJwaHZGQkpZTXN6RUdackZ1RC94NmRlN09uY1dESUdPdjUzUFRxSkFhUXRo?=
 =?utf-8?B?aW5pclhFc01ISm5Fd0E3NXdFRFFnNlgwRFNrWkdpRDQ3a2FnZ0EreUxCYVZk?=
 =?utf-8?B?OXVoMW5aUzZsRXE1Rm0zOWg1TjBadHBCWU12WTBpUDBHRUlJd3hxVG5zNkcx?=
 =?utf-8?B?ZlN6NnU1TURGdEtVR0wzazdJSENHSkdoK3B6WjRjMDVRWmFxQ0R3SmNYK0Y3?=
 =?utf-8?B?enYzOXV2NEIyNU1XUE5NRmFvcEE1TzRjVmRFQmNTUWNsem5WK3BCbE1HaXZF?=
 =?utf-8?B?ei9EYTloSHYzNXZYUlhTbjFLMEJZK0dRUWlzbHVCUkZLVm9LVjRGMzJyWnVR?=
 =?utf-8?B?RVdaZWxxMTJGRm5HL3F0cXVnemZsbzkxTWkxdDNBRzNUVHJMVXhXKzlvVjI5?=
 =?utf-8?B?WjBLNTFmMWFDaWpUVnhMemFpNTkyYy9MZEJaOVVJMTJLNC9EZFlaWUpvV2R6?=
 =?utf-8?B?S3l4LzVTZ3ZpMUs4NGZ1WWxXdWw3T3h3TjNwMUJGa0NQMTIxZ0VwUzRwbmd1?=
 =?utf-8?B?alNHRVBCMDlXY2dzOTVQKzVwbHlCWlpWK2J1YkJPbUtjb3Q4bDJDdTdUNUJl?=
 =?utf-8?B?SC92dVBadFg2VzlkSkFSS1haT0ZtQmltMHRWZnpzZndwN0Q2L2F1N3Y0SWxj?=
 =?utf-8?B?dlArY2JaQ3pGU2dKQ2F4MjNlSUxaNk90ZEg5VWlwR0JBVEErblY2K3FZWFZm?=
 =?utf-8?B?REFTMisrbHRBNUJoT3VONmEwK3hPVWlWSVpFbndTbnM3VjJvMm00K0tPY0Y0?=
 =?utf-8?B?dG1vRU9ZTVRTc2JjRjRkc09sZ082bUJrZVNla1diZ3JYdnFoRytFU0d0N3dY?=
 =?utf-8?B?b3VGY2FqWnY3dC9uanRpUTdCZEp0MGdyT0Focys4eW4wb2NNb2diVXQ1K25K?=
 =?utf-8?B?azVjY1RXcm9EKzIvdEc2bXVvZ1dzWkpZUnlRYnZheHJXNy9IRjVKbnpkb3Fy?=
 =?utf-8?Q?qA+UxKvCAo3z+WcIJ7xc9QqcA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854af515-1a5a-488d-c204-08dc788630f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 04:34:52.1889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFh6/33jlIXBCH7THEk+Re3S5YDWWBjAufWOt8PcBXT4yiew+48FH+m1q/xMusAN26jKl1fK+PxEs6TvdNlliQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7095
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJhb2x1IEx1IDxiYW9sdS5s
dUBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgTWF5IDE5LCAyMDI0IDU6NDMgUE0N
Cj4gVG86IFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNvbT47IFRpYW4sIEtldmluIDxr
ZXZpbi50aWFuQGludGVsLmNvbT4NCj4gQ2M6IGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbTsgaW9t
bXVAbGlzdHMubGludXguZGV2OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvMl0gaW9tbXUvdnQtZDogU3VwcG9ydCBiYXRjaGluZyBJT1RM
Qi9kZXYtSU9UTEINCj4gaW52YWxpZGF0aW9uIGNvbW1hbmRzDQo+IA0KPiBPbiA1LzE3LzI0IDg6
MzcgQU0sIFRpbmEgWmhhbmcgd3JvdGU6DQo+ID4gSW50cm9kdWNlIGEgbmV3IHBhcmFtZXRlciBi
YXRjaF9kZXNjIHRvIHRoZSBRSSBiYXNlZCBJT1RMQi9kZXYtSU9UTEINCj4gPiBpbnZhbGlkYXRp
b24gb3BlcmF0aW9ucyB0byBzdXBwb3J0IGJhdGNoaW5nIGludmFsaWRhdGlvbiBkZXNjcmlwdG9y
cy4NCj4gPiBUaGlzIGJhdGNoX2Rlc2MgaXMgYSBwb2ludGVyIHRvIHRoZSBkZXNjcmlwdG9yIGVu
dHJ5IGluIGEgYmF0Y2ggY21kcw0KPiA+IGJ1ZmZlci4gSWYgdGhlIGJhdGNoX2Rlc2MgaXMgTlVM
TCwgaXQgaW5kaWNhdGVzIHRoYXQgYmF0Y2ggc3VibWlzc2lvbg0KPiA+IGlzIG5vdCBiZWluZyB1
c2VkLCBhbmQgZGVzY3JpcHRvcnMgd2lsbCBiZSBzdWJtaXR0ZWQgaW5kaXZpZHVhbGx5Lg0KPiA+
DQo+ID4gQWxzbyBmaXggYW4gaXNzdWUgcmVwb3J0ZWQgYnkgY2hlY2twYXRjaCBhYm91dCAidW5z
aWduZWQgbWFzayI6DQo+ID4gICAgICAgICAgIlByZWZlciAndW5zaWduZWQgaW50JyB0byBiYXJl
IHVzZSBvZiAndW5zaWduZWQnIg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGluYSBaaGFuZzx0
aW5hLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwv
Y2FjaGUuYyB8IDMzICsrKysrKysrKysrLS0tLS0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pbnRl
bC9kbWFyLmMgIHwgNjcgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+
ICAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgMjcgKysrKysrKysrLS0tLS0tDQo+ID4g
ICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmggfCAyMSArKysrKysrKy0tLS0NCj4gPiAgIGRy
aXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYyB8IDIwICsrKysrKy0tLS0tDQo+ID4gICA1IGZpbGVz
IGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCA2OCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMgYi9kcml2ZXJzL2lvbW11L2lu
dGVsL2NhY2hlLmMNCj4gPiBpbmRleCBlODQxOGNkZDgzMzEuLmRjZjVlMGU2YWYxNyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMNCj4gPiArKysgYi9kcml2ZXJz
L2lvbW11L2ludGVsL2NhY2hlLmMNCj4gPiBAQCAtMjc4LDcgKzI3OCw3IEBAIHZvaWQgY2FjaGVf
dGFnX2ZsdXNoX3JhbmdlKHN0cnVjdCBkbWFyX2RvbWFpbg0KPiAqZG9tYWluLCB1bnNpZ25lZCBs
b25nIHN0YXJ0LA0KPiA+ICAgCQljYXNlIENBQ0hFX1RBR19ORVNUSU5HX0lPVExCOg0KPiA+ICAg
CQkJaWYgKGRvbWFpbi0+dXNlX2ZpcnN0X2xldmVsKSB7DQo+ID4gICAJCQkJcWlfZmx1c2hfcGlv
dGxiKGlvbW11LCB0YWctPmRvbWFpbl9pZCwNCj4gPiAtCQkJCQkJdGFnLT5wYXNpZCwgYWRkciwg
cGFnZXMsIGloKTsNCj4gPiArCQkJCQkJdGFnLT5wYXNpZCwgYWRkciwgcGFnZXMsIGloLA0KPiBO
VUxMKTsNCj4gPiAgIAkJCX0gZWxzZSB7DQo+IA0KPiBJJ2QgbGlrZSB0byBoYXZlIGFsbCBiYXRj
aGVkIGRlc2NyaXB0b3JzIGNvZGUgaW5zaWRlIHRoaXMgZmlsZSB0byBtYWtlIGl0IGVhc2llciBm
b3INCj4gbWFpbnRlbmFuY2UuIFBlcmhhcHMgd2UgY2FuIGFkZCB0aGUgYmVsb3cgaW5mcmFzdHJ1
Y3R1cmUgaW4gdGhlDQo+IGRtYXJfZG9tYWluIHN0cnVjdHVyZSB0b2dldGhlciB3aXRoIHRoZSBj
YWNoZSB0YWcuDQo+IA0KPiAjZGVmaW5lIE1BWF9CQVRDSEVEX0RFU0NfQ09VTlQJOA0KPiANCj4g
c3RydWN0IGJhdGNoZWRfZGVzYyB7DQo+IAlzdHJ1Y3QgcWlfZGVzYyBkZXNjW01BWF9CQVRDSEVE
X0RFU0NfQ09VTlRdOw0KPiAJdW5zaWduZWQgaW50IGluZGV4Ow0KPiB9Ow0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvaW50ZWwv
aW9tbXUuaA0KPiBpbmRleCBlYWYwMTViNDM1M2IuLmRkNDU4ZDZhZDdlYyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50
ZWwvaW9tbXUuaA0KPiBAQCAtNjEwLDYgKzYxMCw3IEBAIHN0cnVjdCBkbWFyX2RvbWFpbiB7DQo+
IA0KPiAgICAgICAgICBzcGlubG9ja190IGNhY2hlX2xvY2s7ICAgICAgICAgIC8qIFByb3RlY3Qg
dGhlIGNhY2hlIHRhZyBsaXN0ICovDQo+ICAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgY2FjaGVf
dGFnczsgICAgLyogQ2FjaGUgdGFnIGxpc3QgKi8NCj4gKyAgICAgICBzdHJ1Y3QgYmF0Y2hlZF9k
ZXNjICpkZXNjczsgICAgICAvKiBCYXRjaGVkIHFpIGRlc2NyaXB0b3JzICovDQo+IA0KPiAgICAg
ICAgICBpbnQgICAgICAgICAgICAgaW9tbXVfc3VwZXJwYWdlOy8qIExldmVsIG9mIHN1cGVycGFn
ZXMgc3VwcG9ydGVkOg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDAgPT0gNEtpQiAobm8gc3VwZXJwYWdlcyksIDEgPT0gMk1pQiwNCj4gDQo+IFRoZSBiYXRj
aGVkIGRlc2NyaXB0b3Igc3RydWN0dXJlIGlzIGFsbG9jYXRlZCB3aGVuIHRoZSBmaXJzdCBjYWNo
ZSB0YWcgaXMNCj4gYXNzaWduZWQgdG8gdGhpcyBkb21haW4gYW5kIGZyZWVkIHdoZW4gdGhlIGxh
c3QgdGFnIGxlYXZlcy4NCj4gDQo+IFRoZW4sIHdlIGhhdmUgYmVsb3cgaGVscGVycyB0byByZXBs
YWNlIHRoZSBjdXJyZW50IHFpX2ZsdXNoX3h4eCgpIGNhbGxzLg0KPiANCj4gc3RhdGljIHZvaWQg
YmF0Y2hlZF9kZXNjX2lvdGxiX2VucXVldWUoLi4uKSB7DQo+IAkuLi4gLi4uDQo+IH0NCj4gDQo+
IGFuZCBhbm90aGVyIG9uZSB0byBwdXNoIGFsbCBxdWV1ZWQgY29tbWFuZHMgdG8gdGhlIGhhcmR3
YXJlLA0KPiANCj4gc3RhdGljIHZvaWQgYmF0Y2hlZF9kZXNjX2ZsdXNoKC4uLikNCj4gew0KPiAJ
Li4uIC4uLg0KPiB9DQo+IA0KPiA+ICAgCQkJCS8qDQo+ID4gICAJCQkJICogRmFsbGJhY2sgdG8g
ZG9tYWluIHNlbGVjdGl2ZSBmbHVzaCBpZiBubyBAQA0KPiAtMjg3LDExICsyODcsMTMNCj4gPiBA
QCB2b2lkIGNhY2hlX3RhZ19mbHVzaF9yYW5nZShzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwg
dW5zaWduZWQNCj4gbG9uZyBzdGFydCwNCj4gPiAgIAkJCQlpZiAoIWNhcF9wZ3NlbF9pbnYoaW9t
bXUtPmNhcCkgfHwNCj4gPiAgIAkJCQkgICAgbWFzayA+IGNhcF9tYXhfYW1hc2tfdmFsKGlvbW11
LT5jYXApKQ0KPiA+ICAgCQkJCQlpb21tdS0+Zmx1c2guZmx1c2hfaW90bGIoaW9tbXUsIHRhZy0N
Cj4gPmRvbWFpbl9pZCwNCj4gPiAtCQkJCQkJCQkgMCwgMCwNCj4gRE1BX1RMQl9EU0lfRkxVU0gp
Ow0KPiA+ICsJCQkJCQkJCSAwLCAwLA0KPiBETUFfVExCX0RTSV9GTFVTSCwNCj4gPiArCQkJCQkJ
CQkgTlVMTCk7DQo+ID4gICAJCQkJZWxzZQ0KPiA+ICAgCQkJCQlpb21tdS0+Zmx1c2guZmx1c2hf
aW90bGIoaW9tbXUsIHRhZy0NCj4gPmRvbWFpbl9pZCwNCj4gPiAgIAkJCQkJCQkJIGFkZHIgfCBp
aCwNCj4gbWFzaywNCj4gPiAtDQo+IERNQV9UTEJfUFNJX0ZMVVNIKTsNCj4gPiArDQo+IERNQV9U
TEJfUFNJX0ZMVVNILA0KPiA+ICsJCQkJCQkJCSBOVUxMKTsNCj4gDQo+IFBlcmhhcHMgd2UgY291
bGQgcmVmYWN0b3IgdGhlIGluZGlyZWN0IGNhbGwgaGVyZS4NCj4gCWlmIChxaSBpcyBzdXBwb3J0
ZWQgYnkgaW9tbXUpDQo+IAkJLi4uDQo+IAllbHNlIC8qIHJlZ2lzdGVyIGJhc2VkIGlvdGxiIGlu
dmFsaWRhdGlvbiovDQo+IAkJLi4uDQo+IA0KPiBhbmQgb25seSBiYXRjaGVkIGRlc2NyaXB0b3Ig
aXMgb25seSBzdXBwb3J0ZWQgaW4gdGhlIHVwcGVyIGNhc2UuDQpTdXJlLiBUaGFua3MuDQoNClJl
Z2FyZHMsDQotVGluYQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBiYW9sdQ0K
