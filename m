Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F04139B
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 00:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719968215; cv=fail; b=rnQx5gKpP4oobGWsV3mP7iws18tzOgFIYCgvoYFBJW0662OXJnwc6/m19dNC8ZN+wPRMGx3Ft5XvafRntMcz1xoTNi6MalqKlR0Jhcz5W+0fj41tzeyElCcIqlebuffb28qlAqUZGEnLtPOohvqrjAepcoz8rJcSfs0Uhhkgcy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719968215; c=relaxed/simple;
	bh=qE2u6O278jCZKMI3Ng7cwIlYGouoL0MMQGrvkB9B6ts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S4MR82wWnfSr5NblO+lYctD8IUa7jCKyAEAPoiNa0X1RwIaMAGTxQZSnRu46BUUGBiLPxgvuThlLC0XqZnqnxOqIokvCDb2NH/vwz2n0wLYlwvSE9l3i1sJCkjNv/Ap7UVBt1y+ka6Y86faWHF09V6XGiUMA52mtZec8yanI2kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dw9pGw5M; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dw9pGw5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719968213; x=1751504213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qE2u6O278jCZKMI3Ng7cwIlYGouoL0MMQGrvkB9B6ts=;
  b=dw9pGw5MwmiJrUb/Mo9IayjV26i2ZsHNxdQKCYu5dihX1SMOy2ODczvh
   OW8MI3/8pRB2RPzlH/8k2UtVxuBFe6TOEX+R8LEOsl1rR5DGfcSHZFBId
   6VFDZkg8lrZhALct+79NuS2kqc1Q7L4cMtACue/izrxya1jfBKAubXoIy
   TBqO3MdUvys52fMq0/04wt9NHRKw1WDLXkoD+17281i7CqoaeciuAJo18
   pf4T0Hjyp+tyx93h3pmA0DV+RuS28ankgOwxHL8C9KqpAzgrxA/ewZVfr
   Laq/iXAuXLIsEZjLHas4T1sKXdFvMDQvuRvFZuZ12xxoQ4ZW7mza7BRcE
   g==;
X-CSE-ConnectionGUID: TsRM+LQ0SZaQ+8bffmgKjQ==
X-CSE-MsgGUID: oKLFyb/xRQCbPo1udr4K+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27852328"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="27852328"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 17:56:53 -0700
X-CSE-ConnectionGUID: ku7bYoTRS5CC9Dy3qRowPA==
X-CSE-MsgGUID: sjhrerQlT0KZWNWPS2/oGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="45861501"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 17:56:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 17:56:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 17:56:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 17:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3hA5WjkkcQbj+119yRgWp+1KtOrHIwqs6xbPGhC/53Ify/sOfcvsueTv+7ARtertkzacOJuQYwUlkirWzPqEUAHbHWusFvysIuACdJfw1m5fhoCzwakyxvgGrYO6nu0xI3PWFzUMOUqsZS1e8EO1OXCA7NWG/cVbaOrQ/Y4QfVjtuh2IkkZES0c9Fjr+QJbIJneAD7NduSXifi+rs+1wpZzuFmTjsD9H1GUoZJ91tNenayhm0xvSvwndA4iKqv3E40fOm5fWCIAeSzgKnNoBpT9E3OMH05gs2weAyi2PstO2P0TMVvvt3FFq+SA5Np890XoqzBxUOeiZg2w2dXIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE2u6O278jCZKMI3Ng7cwIlYGouoL0MMQGrvkB9B6ts=;
 b=a0Az5Q7fBHMG/rL3Mb8jpnqufnC0T6m/1DTAsFCpjC1Im9fJAKfHA1/l12/Dx5fuzqoMUwOMthIz/2EsCSVS13ZdwTrC8sJJvJywaMHQHCz3flHLhy4EdiRiX4PiUn2QqBXLm8fj5fHBwNKK+ETeqXjO0AG9cTVoMpytAb+RMqaocswj2cgjZAsSFK3ZX6GP6hJOzGQzWd7BETfqbBNQLWdY21krRdPVka9+9RIr6/cNChzcTZmT2F46jMYh5pHscB9mAyvbp0Nnj7/SgyJWRp4/8sMS14L8x4QztrwRETFSh/ucxFr/CeKXg42kQ3mwOy1qhh1h01Jg/Y9mjtZDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7556.namprd11.prod.outlook.com (2603:10b6:806:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 00:56:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 00:56:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@infradead.org>
CC: David Woodhouse <dwmw2@infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: lack of permission checking with intel-iommu?
Thread-Topic: lack of permission checking with intel-iommu?
Thread-Index: AQHazFQLqG7HYsxMnUCNIsx358B6CbHjE9CAgAAFd4CAAADEgIAADT0AgAEGfyA=
Date: Wed, 3 Jul 2024 00:56:50 +0000
Message-ID: <BN9PR11MB52761AAFB5C2E2A42E24B9B38CDD2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZoOwc7O5W0PUeja5@infradead.org> <ZoO0KxkU_JNO0av4@infradead.org>
 <4d84afa1-e2ce-4e1b-8fe3-1d3fb0db2ba0@linux.intel.com>
 <ZoO5ZeYtA6qLIs21@infradead.org>
 <0d0c9d4b-b233-4ac8-9a46-9da24f1c5536@linux.intel.com>
In-Reply-To: <0d0c9d4b-b233-4ac8-9a46-9da24f1c5536@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7556:EE_
x-ms-office365-filtering-correlation-id: 52edf49e-d686-42b3-a101-08dc9afb05b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RFRTTzNINUdSOVpjV3hnRjg4ektJK1FKUmZxK05ycVRZWm1XTWNWeUcxbXZG?=
 =?utf-8?B?RU1aYlIzZVFzQkJtWHR6V04vZHJDS3ZxU2lmcFVTUEZZb0ZBcWplVGFRcmYx?=
 =?utf-8?B?bWpJWWNuUXhsMVpoWmF5YW1TREJhLzFzRGdlY3loNHo2MTBPR1l5cVJqWGpC?=
 =?utf-8?B?T1RiMndZVkQxSWZDc0RBVE9BU0xxdEU3U0NJZ0VjTnRnUjg1d0gxR1Urempk?=
 =?utf-8?B?emN5MVdsWUUvT3hyZk1OVXVIU09oTnkvZGc5T3hMOHZpS01pS0IxekptYUpv?=
 =?utf-8?B?NUduSjk2UnFJZnJobTBnZGVwNlI2Ri9TQTR2YzFNOGpQWUpoM1RPM3hOdXRu?=
 =?utf-8?B?NUpqZnJ2dWRhY2sra3prTmlmVzVaeGtjbHJOMnRsc2M2NHJPcUFDZDNBamRC?=
 =?utf-8?B?ZjBPMitTMklUN3YzTmtPYWZmTTRsSTNjZS8rR0hxeUI2NmFnSktJZ3JDajVQ?=
 =?utf-8?B?dTBMcVFaZU5aZWphOHQ5OXEvUjcxQUVJbG10ZjdPUlhTRCs5a2QraG1tZk94?=
 =?utf-8?B?dXRGM3V5YWJsaVd0dG9uUkJxZWEwZTRVQjdIdU52T3hwSXEvQk4zckdxMU5O?=
 =?utf-8?B?eTRVWFZqV09qM1NxK3Z2Q1VxVjBiSit6UFdTMDZITXV5aVVoRmVWQU9ac3Zm?=
 =?utf-8?B?SWE5UVVFU0VsN2VMK2o3YllZWko2cDFLTlQ0S2hRUVFxakM2TUFFZWpncmd5?=
 =?utf-8?B?b1oxeVVOQ3IvR2hhM1FxRHAvTGNkdnF4MGI5b3pMYTNEWW9STmtlWkxLTHRF?=
 =?utf-8?B?M1BZZmhLRkQ1YTdEbFVaYTNoQVNxVnZmZmdVTEU0dnFlNmRjVmdnK1U2d2VL?=
 =?utf-8?B?bnJXeHJySTN2cXVvZHYxTFk1Yko2MXl1a0gxL3NwTENWRUpobktSZEdPczFn?=
 =?utf-8?B?V3FFY0Z2VEVFeS90UHJjeUVyaW51OUV4ay85UkVlZTJON00xaWNqaTNvcHNC?=
 =?utf-8?B?b2lGTVFSbnhIZ2xKYTBGUDNJOVBhS2dLS3h1VnFWUlBJaUJld0I3T3lmb0x2?=
 =?utf-8?B?ek1pclFYa0FoMGZRdXZOL1JLVGpXVTRpSjc2b1p1ZDNiMmthN25McVl6R1No?=
 =?utf-8?B?QWdnbnJGYm9QdGdSVzAzZXZWLzlWREUwN2piR1VKVmZ6bHRYTHdYckNhd2hm?=
 =?utf-8?B?WUhzOVhXaWJkRVlYOEVlalZPREo0b3pOZkhha2c0VWVvSWsrYmNxaWFLRnF0?=
 =?utf-8?B?NUYzUFhNK2l0UDg2VjhtWFJKMUl6WHdPNjlQWXIrNXQvSXZ4U0RydU1FNUIy?=
 =?utf-8?B?czcrTWtnUEJwUGtDUEdyM3lPQjI0b3VWKzFPM3hMYzNTb2NUelp4Sm1SQmlY?=
 =?utf-8?B?UE1NN0F3NmYxblgxUUZ1UCtkU2ZobzU2Qjc2UVczOS92dDh5ck5JOGd2d3Jl?=
 =?utf-8?B?N0EvT2Z5TzBIVW9vUE9nMVpXWDQ2UXdVZU5YdU16ZS9oeURiejhwTUNKbmhl?=
 =?utf-8?B?SlNCcThEeHBPVGFBWXlwNmZxNjBIbVJodlIyajlOYXpnWitXTHV4VzJseVE4?=
 =?utf-8?B?VmtlTWlRdjZFRTFybG15d0hnMkl2U0ZsRGJzQjluN3A0dVJ4N3lHVjc1elF6?=
 =?utf-8?B?SUJNTnByenRjdmNNY3huQ0MrNzAreWRYS0xPcTBHbmJGWVBHV3lKK29CUjF1?=
 =?utf-8?B?cXpHbUlVOGpvdnRxM01sekxLblFSYzhhV1g3QUtDT0V2YjNpWTcvMHloOEtR?=
 =?utf-8?B?Zlh3Y1MzSldUWTU0MW9FQ1RRUGRIUmVPdlZRdlZkbEVzVFdxTy85TFIwTVdR?=
 =?utf-8?B?Q3pEVE50bUJGaGV3N2NuVGhBbFlxTDR2bmgvcGQvMGNhWGZNTHhhLzlHSnE4?=
 =?utf-8?B?UkE0NURhVzNRWkJFaDY1enJ5YnFPSWlUNEtwTUROSHZKMDFEMHY1RkYzOHpm?=
 =?utf-8?B?UGNrNldKdWIyRUdhOUkzL3NnQ0cwdFNRaUdlY2hzWkZlenc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGE2eEpDMFlBQVFCYzdIaVZhKzVzSzM1d2JxZm92M2pXWVZSMi9scVU1ZWU4?=
 =?utf-8?B?UnlzODJzaGluQ09qTjBSeFNrZ2t4c0ZSQWZhVGRJeHgrMDMwR2ZFazlQNVR4?=
 =?utf-8?B?U1E3K1hzV3dRdlRld2NLc2RoMHZ6bzRoaGIybCtFTU5GZThnZHgvL2srRHNK?=
 =?utf-8?B?WUtQaVcrbGNPeUhjRlpUc1BEQU1JQzZ2dkNqUjRRYTNMT0xicVZrL3czK0Nw?=
 =?utf-8?B?NUJST3k2WmUwMy9EdkdiSS9WYXZYRXlPaUsyZnp3OWczVHJENXpldGtNMXEx?=
 =?utf-8?B?SUM0MUhzNUQyQmNCdnFOUjNYRzA1U0REcHR3c0JINXJrbDdWaHhKT2JiZmFz?=
 =?utf-8?B?RXMxajlZU1Q2eUxiVGFzVlZoc1luS1JkajZqRlBBZ2kzWUlwYUNIL1E2Wko4?=
 =?utf-8?B?c1lmK05FVFc4ZjBXdG8rQThZbEQ1ZFBTM1FRWnplZk1aeFJmWnJzWCs5Rks4?=
 =?utf-8?B?UnpaQ21WSjQycGdLZStnRE5TQlpSTFhKdUJuOHpiMTZHYThQeG1ScFQ3dGdW?=
 =?utf-8?B?U1NvUTFjamxTNFZuQkJhTk9hNzRhYVgxWG9zWmQwQkluSWRKY3dxM1l4QmFT?=
 =?utf-8?B?OEdLMW43YWpBbWN4NlF2U2NRQUJjeTAwbS9HRzV5TjRJeUoxYTk5K241VFAw?=
 =?utf-8?B?Y1N1YkRCRlYvdDJ6U0JhaVEyeVp6MEtJWGJPWGJNa3FWTTJkUVJQZEdhRkRX?=
 =?utf-8?B?TTkvOGhwYnZRSldnOTZVVGZtdE9LNEFnY3BXTm8vcDJDYW1GV1hrRFZTTGpM?=
 =?utf-8?B?YXNEQXFISXorb053aStEY1llU3ZmNkVTVU5XZVZBSTVtQVBUendxeDYwTitK?=
 =?utf-8?B?MCtDYk5rQzAxUWE3bHcweTJiTzhGZ01mblZFaWs3R2xRY3Z5c0VnZWhBMlIz?=
 =?utf-8?B?ZGlCZVY2VmhabDI4NVFnSWZKR3NlS3JzTDZSdFRwZXpibk9Bci9wYUdYckVz?=
 =?utf-8?B?THVxZ3BtcHNCbndHcThxOGgzajhETUZ0NXNJNWI2cXdHNnZWVHZOWWc4OEt3?=
 =?utf-8?B?aWR4MXQ2dTlEUjg2U0lXejhiUUo0OWZzbk93SXI5UW5KeEZUZVNOUGNxcy9L?=
 =?utf-8?B?SzNjVmh3LzJ1ejBOMTBnZ0xqcnkrRUpnSk5UaTlXekEvcWYyTmRqbEo2RmM0?=
 =?utf-8?B?aU5TdTU4NEM0N3llS1hJVjQ1cGxYV0tCRlU1NWVLRTFPWEhvVGlWZ3drQVl3?=
 =?utf-8?B?RUR0NHhGcG9xYnZ2OGV1NjJmc080UFVKQzFSK0FaUGxDaG1IUit5dEpzUkh2?=
 =?utf-8?B?Wkxzd1QvcjQ0M2NISVBUYWV5WE1MVVphQVJ3MDUxWTg0UEdFdkxwMzVTM1ow?=
 =?utf-8?B?azBkZzFnSVRMQzF6S0hEOFhKZUlJaTk5U2pUdFFVb2xaSkd0bDR0S0hMdTl0?=
 =?utf-8?B?eU9tMTBFdFVuaUR0dit2SEVUY2hyOGRVRzlJN0VuemZQcEhOelovNXdKb0RU?=
 =?utf-8?B?ZXcyS3RNbWhsckkybHBIMmVNN1JNUEVOcTFlaWJVQUh5NGloYitxc3lwbmtY?=
 =?utf-8?B?aFdob0Izakx6VC9vWDQwbTl1NnBYdTBaVklheHgwVm9yNU1YSTJyN0VjUzF6?=
 =?utf-8?B?NHlpTGo3R0ZacGF2by9saW1KLzQzRzdXWEdlUHdkOE96alhmNTlhMVBhc24y?=
 =?utf-8?B?RzhOdFpMSXVTaHIzbjZYVTlKK0R4SWZwRlMrZGcraEtPSWllOUFPZkVPNXpH?=
 =?utf-8?B?WWFCRVdRam5PREVZdzNpYmhKSkN3VllZNXd1b1VHM2ViclNyblJ4bGE1LzIy?=
 =?utf-8?B?NEdKRTZ1TEhDSVlpUlV2S1V2aGRHSkg3dk1USWF2Wk1kcmdYVHFIRkRJSGZQ?=
 =?utf-8?B?anFXcWZBNy9ScTYycitMRkk0ZFQ1K2JrazVOeUF0ZnhBNFI2Y0FybW9SMXZt?=
 =?utf-8?B?UHZKZzhxU2pURlBBSTl6SHltWHBUZ2graUowYklDN29kOU5Ta2RwRWl2K2ZZ?=
 =?utf-8?B?eGhoTUszRVYwRnppUlRCdXJod2JyemowWnBnbzVvUHF6bmdKMlIvVVB5NXJw?=
 =?utf-8?B?cWxoS0N1UDd4Sm5uSGp1T0NpM2FMQlhkaEhzTkk5SlZ2K2wyZ1BLNTk5dmZn?=
 =?utf-8?B?QUI0NkVtVzBjTlErTVNWTkVzY08wTENQREFpNmN3eGN1cVFhTnl1ditlVmdU?=
 =?utf-8?Q?8Tu5DWPaPsEjitQENJPphpZQ8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52edf49e-d686-42b3-a101-08dc9afb05b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 00:56:50.2852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ry33b3GixgwC5YBQTFaaGplCR8BMnsWvOJOqmOUg/cw1Gdac3hjpWffxtneJi7hGWknzTFXgUmvd4UUr7xsoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7556
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdWx5IDIsIDIwMjQgNToxMyBQTQ0KPiANCj4gT24gMjAyNC83LzIgMTY6MjUsIENocmlz
dG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+IE9uIFR1ZSwgSnVsIDAyLCAyMDI0IGF0IDA0OjIyOjI1
UE0gKzA4MDAsIEJhb2x1IEx1IHdyb3RlOg0KPiA+PiBJcyBpdCBhYm91dCBJT01NVSBibG9ja2lu
ZyAiZGV2aWNlIHJlYWRpbmcgZnJvbSBidWZmZXIiIG9yICJkZXZpY2UNCj4gPj4gd3JpdGluZyB0
byBidWZmZXIiPw0KPiA+Pg0KPiA+PiBUaGUgaW50ZWwgaW9tbXUgZHJpdmVyIG1pZ2h0IHVzZSBm
aXJzdC1zdGFnZSB0cmFuc2xhdGlvbiBmb3Iga2VybmVsIERNQS4NCj4gPj4gSXQgc2VlbXMgbm90
IHRvIGJsb2NrIHRoZSAiZGV2aWNlIHJlYWRpbmcgZnJvbSBidWZmZXIiIGlmIEkgcmVtZW1iZXIg
aXQNCj4gPj4gY29ycmVjdGx5Lg0KPiA+IFRoaXMgaXMgYWJvdXQgZGV2aWNlIHJlYWRpbmcgZnJv
bSBidWZmZXIgaXQgaXMgb25seSBzdXBwb3NlZCB0byB3cml0ZQ0KPiA+IHRvIChidXQgZG9lc24n
dCkuDQo+IA0KPiBJbiB0aGlzIGNhc2UsIEludGVsIElPTU1VIGRvZXNuJ3QgYmxvY2sgZGV2aWNl
IHJlYWRpbmcgYXMgdGhlIGZpcnN0LQ0KPiBzdGFnZSBwYWdlIHRhYmxlIG9ubHkgZ3JhbnRzIHR3
byB0eXBlcyBvZiBwZXJtaXNzaW9uczogUmVhZC1vbmx5IG9yDQo+IFJlYWQtd3JpdGUuIFdyaXRl
LW9ubHkgcGVybWlzc2lvbiBpcyBub3QgYXZhaWxhYmxlLg0KPiANCj4gRG8geW91IGhhdmUgYSBm
dW5jdGlvbmFsIHJlcXVpcmVtZW50IGZvciBXcml0ZS1vbmx5IHBlcm1pc3Npb24/IElmIHNvLA0K
PiB3ZSBjYW4gY2hvb3NlIHRoZSBzZWNvbmQtc3RhZ2UgcGFnZSB0YWJsZS4NCj4gDQoNCk5vdGUg
dGhlcmUgY291bGQgYmUgY29uZmlndXJhdGlvbnMgKGUuZy4gdklPTU1VKSB3aGljaCBvbmx5IHN1
cHBvcnRzDQoxc3Qtc3RhZ2UuIFNvIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IHdyaXRlLW9u
bHkgcGVybWlzc2lvbiBjYW4gYmUNCmFsd2F5cyBlbmZvcmNlZCBvbiBJbnRlbC4NCg0KYnR3IGFj
Y29yZGluZyB0byBjdXJyZW50IGNvZGUgbG9va3Mgd3JpdGUtb25seSBldmVuIGRvZXNuJ3Qgd29y
ayBvbg0KMm5kLXN0YWdlOg0KDQpfX2RvbWFpbl9tYXBwaW5nKCkNCnsNCgkuLi4NCglhdHRyID0g
cHJvdCAmIChETUFfUFRFX1JFQUQgfCBETUFfUFRFX1dSSVRFIHwgRE1BX1BURV9TTlApOw0KCWF0
dHIgfD0gRE1BX0ZMX1BURV9QUkVTRU5UOw0KCWlmIChkb21haW4tPnVzZV9maXJzdF9sZXZlbCkg
ew0KICAgICAgICAgICAgICAgIAkJLi4uDQoJfQ0KCS4uLg0KfQ0KDQpETUFfRkxfUFRFX1BSRVNF
TlQgYW5kIERNQV9QVEVfUkVBRCBhcmUgYm90aCBiaXQtMCwgc28NClJFQUQgaXMgYWx3YXlzIHNl
dCBpbiAybmQtc3RhZ2UuIFRoYXQgbGluZSBzaG91bGQgYmUgZG9uZSBvbmx5DQpmb3IgZG9tYWlu
LT51c2VfZmlyc3RfbGV2ZWw9PXRydWUNCg==
