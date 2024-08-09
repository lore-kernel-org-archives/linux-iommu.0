Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFA190470
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195449; cv=fail; b=jEU8TRiRem0TBvbTaF6bi3UsGPoaijO6M3q5HlE+QY3k9M7x8D0OWQm6fmV4KJhxM7VBByo2s2zf7MH+5TvehbJED9eJwFlnoTtMDjfhsvrJdS/PsrkQ2sJ66a8aE/lWScNdYS5oH92MwPcl1leDjkksEDTRxTVtb62FVlnwCSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195449; c=relaxed/simple;
	bh=o9GOWw+69sllskdU01xOS6F2CIfZVlUtmMDftYlgbNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VkbY7XIJjqSO0ww7FD2AS2xtLNA3jN7fbl/zPYW5dbI+N5VbVqur/lly8jMWv9Z5a1vYabxeeMuPLlS3Kv4QGBFbZLmxQO7fLLOqj620fe98C2RNdYCCayBCcvsaRgGIBHBQPz6eyGW8LHxdoyDd6BX3+PCnN+KI88HjS3crfMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LX3Q+iLk; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LX3Q+iLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723195447; x=1754731447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o9GOWw+69sllskdU01xOS6F2CIfZVlUtmMDftYlgbNg=;
  b=LX3Q+iLkiKlwlEoAi4MZKMd0qcfceGjbz3uUiExw8M9ii+CmPtT6wUuz
   NTJKCiHEMuumgXZIxwX27DaeG7lCskW+zaZjU2Td2L3ZPl8lr+/3DOPd+
   NTSylzU0srJVDhcFbTxVG/Abe4B+5RIKsDil6qJhQ+MLBiGxfThOTWKe4
   5Q1oS8IdzmEAdHDJoAuBI/tPY2WtTQxYQGE02mEQa/bKOcmtyYDf+3sLE
   xBWzt8Wh82F/1qOHjMqLUBMsspHROnwjHvUtxzVG9GVGKfQu2Kwg4dBBT
   8NA7dTpAHowmM46QAqtEjQAODg32hHBWRuBh4sVSyd0NxEKkUhd+Ps6pe
   w==;
X-CSE-ConnectionGUID: tr5PfAGDSHydWA3Kf033nA==
X-CSE-MsgGUID: ydjDV7XtQjG6Gysj6YK9AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32509993"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="32509993"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:24:07 -0700
X-CSE-ConnectionGUID: BlfjrRMuSIikqbvtkP66IQ==
X-CSE-MsgGUID: GDgPCOCoTB6W7RBXmmPoAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57169083"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 02:24:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 02:24:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 02:24:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 02:24:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 02:24:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mz912jDYBDkbhT3PLXyolsHIWzUrsfksIhTT4fJC1yM18xwx/jcMPBB0g9fWrnJwyeZUt7ToB3THO6YRVHlaBeXdQoFnPeez2lyEk4tCjc3sZH8Hp6h5jpDeGDYEFMGd5xMlpHYrtI2HkTevVE8e2X1LgE5KhvvsQcOmC2q1TdzG2x7iWBySygRZ3BZYw6kLqnL62ZLOzZFTyJFlw3TDNXmEpcfn2Ln3a+Ihr4d3as6OPMq3I0LvGkKryTS2h6kmwEgVjZStG5FMkZQvbeGLppgZI5S3EiFgyg7TnXf57fQGIgQl6QEc3ptqLyoDy1X/yFp71r0Kgu3ZBBQf3E3b/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9GOWw+69sllskdU01xOS6F2CIfZVlUtmMDftYlgbNg=;
 b=UnIam7uHROghaw97hgm1jMqj6qtDXoGVeQ5lT9GB/wuRsxnB1T988wdi16OpR3cOmBmkUcpgHUZTDVRvWnYIzw59gajhvuJaphobv9FYrJ3jbCPMqPobWhbonuLLQ/ZlXnew9cZd6kvo0fYmH8SEzuzGKAVcA9lNOoNiE90jE2cgecUlaA1xiz5DADw2eUAlNGG8u5hlm9zjtaKm9Rooa/mnrZXkDwNgM8cYPAdi9bfpG9FrwrA/6sdn+LCSyw+x68BD/dLdisWW/qNt/bYOArAwR9zjcfHPT3/IK+z1u2Zp5oRaLccRbrthhOnH4L6MASBnoCIzN6Xg9G0a8q1LpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:24:03 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:24:03 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] vt-d/iommu: Enable batching of IOTLB/Dev-IOTLB
 invalidations
Thread-Topic: [PATCH v2 5/5] vt-d/iommu: Enable batching of IOTLB/Dev-IOTLB
 invalidations
Thread-Index: AQHa6gfJcHiGRM1QuU+FvBQqjf2SKbIelm8AgAAOkTA=
Date: Fri, 9 Aug 2024 09:24:02 +0000
Message-ID: <MW5PR11MB5881E894D3452E372C78F90189BA2@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
 <20240809025431.14605-6-tina.zhang@intel.com>
 <284bed78-c9ff-4715-a85e-bf353cabaa22@linux.intel.com>
In-Reply-To: <284bed78-c9ff-4715-a85e-bf353cabaa22@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|DS0PR11MB6325:EE_
x-ms-office365-filtering-correlation-id: 09c30c63-babc-4f32-6499-08dcb8550252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VDNqT0NDYncxZ1N0eHhVZzgzZk9GaVVLcExCanliWG5DL2FBOUN3b2pVdjBS?=
 =?utf-8?B?eDJkbEY2dVpTaS9wcDdVN3htTU9zYVBmbnlRbGZBeUM2TFdsYnRiU3BueEd6?=
 =?utf-8?B?cU1FUVNWcDk0NkpUdkJxWFdNYVJlRFI0bG9EU00zWHYyd043T3ZrNTZOenpm?=
 =?utf-8?B?YXR5ZFp6ZW1mWUdrNDN4QUdpeXdzbWxVRDc2ZXgycElCYlJVcVhobE0rR2pG?=
 =?utf-8?B?Zk9TTitHWGtoV0pEVUpNVjM4UXdJbVk0VG1ad05qTkVYcHJFMmdodVZ0cUE5?=
 =?utf-8?B?RnZVV2VUR0dvTnZYZnRTZjZtdkxDWi9uMTJwM1ozZ0V6QkpML0FjaU10VDR4?=
 =?utf-8?B?RGJwZUlzZS9tY0NpNGtrY1g2OWkyZVdsZFIyN0pkenRZSGxOWithUGFBdEtq?=
 =?utf-8?B?VWtnUWtXUjlPNHlxRmRRWllWOHl2QzVVN0Fob21MVVpZclFGVWtxSWdTbXN0?=
 =?utf-8?B?L3NpL3BvNUU4ZFh3V2xPN2JlaWtiZVZaN01pbk4xZUNSV1JHSXdrNjA0OG1Z?=
 =?utf-8?B?L0haZFgzUjVQYnpDMUxTUEY5T1ljZnd0OVk4bG1jNjYvR2xBQzU0UFN6WnVq?=
 =?utf-8?B?WGFpTUpmOHpLOVp5a3U3eXBFaUR5YjNsM2R0RTVIOEVBSzMvUGY4RmtKV05W?=
 =?utf-8?B?RVN6UmVpNit5WjAwTi9YanN0cGlhdUFQbkJxYkVwNHdEWk4vcTRObDZRT3lL?=
 =?utf-8?B?UkM0VlROWElaR1FzM1dYcEZaWFVaUU9tTjZuUWxkS3paUTZVZDVRdjRWYUZo?=
 =?utf-8?B?bXY2aHdvUHE3NmVRanBLNTNIL0VRU2psZ1dZdG0ydkkzVXh4amRrTnNxRmpJ?=
 =?utf-8?B?RjBmUndEY24xNjBQOC9MZ1Z1TWQvUXNkMGlqdmhISDhCRndWZEVJSDdqZmtD?=
 =?utf-8?B?dlVxTm94cFh4ZHlKaFc2OUxrY3RVelZ0UmJrQWhXT3RWNEdWTUFIVkx6WWVL?=
 =?utf-8?B?YXBERUdIN2h2LytzQ2NPQkJHUC9meWJheDNUNHJZSDc1MkFGU0RXSnNrMkVD?=
 =?utf-8?B?VDY1UzJ1Z2xxL0dQTU44OVNPSHFkRzlNTFk4Wk1VRHpta1JLUVc5bDlmcVdY?=
 =?utf-8?B?OGdFL1pHbHBJdjhtNnN0ejBSVFBrc2xnUWQrT2VxVURkYm9EZjdNZS9HVXlw?=
 =?utf-8?B?RlYySmNkMkZOc2ZRbXgzT1loZS9ncldVK0gvc2ZPYzg4ZGZybWxnT21IdjRF?=
 =?utf-8?B?dG1rUTNJUk9SK1VrQXUzLzB5SENXcUxia2RCTEFDcTFLdXRwNXVRaXg4L084?=
 =?utf-8?B?WU5ERU1sbFFuQmxpdUFQVUZoZkdrVWhvNHIzbWVLNjRnczFPZWdZdDRrQzZV?=
 =?utf-8?B?a1lyUGdXZ0FyblhHRzQrZ3J6ekhzUDRxRTIwd1BWNGhJOUpxQmpjMTdWMHJQ?=
 =?utf-8?B?dGtyNDdYU0l6TklyU3lQMTRKYWZ3ZjZ2OGswUEsrKzJ6UVM0blA2RU5WUDJL?=
 =?utf-8?B?NFhRVkJYNHJVbUhoa0h6V3pmOG9RbEdyTlFCbnpuUTRUMzN2dXlNT282Q0RE?=
 =?utf-8?B?RDZPRmR1SCtxa0czanVFMW1rZG1MYWNwK29aUzJLSHFibU4wdUxaeklxMFVC?=
 =?utf-8?B?d2JmSzYyNkExU0hqd1RJMFVMRXZnUW1zcGsyR1YwOVhLRUFBRnRSdWxnMHR3?=
 =?utf-8?B?VVk2a2tKOEM4akJEcHpQM0tYYVpSU0RtVzdWTmROY0xGVVE1Tk1pK3kzVkM4?=
 =?utf-8?B?dTBpMjE4TUhwaWRpYmJDMW5qZ2JNczI5aWQ1Wk1DZUl3QjR3SVN3VWpEYXpr?=
 =?utf-8?B?bkdYQVkwYW9FMmdNamVHOFM5MzllckJaOGpBdGNJcFFCbUlLTXFDZGVJNTR3?=
 =?utf-8?B?R01DMmlONjA2TVFUZlRQNThZdjFGVFRMQXRoL2FRZFNiU0FGKzE1SmxqZkxu?=
 =?utf-8?B?ZHNEU3htOHI3RHluT01MdjF0cU9vYmlwMHA4QnRGTnh2ZXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTA4MS9wWk53cFhVS2JrdmNwWkwzKy9NZXB5c1ZmZllaSjJTZFdHZFZoWXgv?=
 =?utf-8?B?akJ0cXUwWkJGOVJOZHYzdHFkUjkzb2s2eHVYZmNtcGVnMzFqcit6M1haSkFw?=
 =?utf-8?B?TUtuME5YMlUwblhTdW1ScmJBSWc4UWd2UWV6UU5IWXNZS0pCNW5sOUprQUth?=
 =?utf-8?B?bWxNYWlxb09jYThPcGpmaGpIbVBtNktZY0E2SmpXaEpLTGhVYlpFdzU4SU9H?=
 =?utf-8?B?Y0FHUWk1TC93bi9RQ0VyZHNxVXdaV1o5OWlrbjl0clBJT081bzVQbUxxeDY1?=
 =?utf-8?B?QUNlZ2E3WkNFV045djUyaUt1RUVrR0ltcDJqSC8yUVpSMVpwQ2QyRjJTWU5E?=
 =?utf-8?B?WGs1c1JYMXlXZ2YwSzRJaVRuRnBUT3lJK1VTWUNrTzVHOU9kR3UyamNSYVMr?=
 =?utf-8?B?ZlZGTGhtS3FJL2xyVTdwdFFHUnBFTDIrWlNUY2FrM3NPK09BVVl1eVhhWm5x?=
 =?utf-8?B?dzhjU1pEZUZYV2ozRWczRGUxWWxzREh6VUtLNW82amozVExXZHBqb0xLOWdQ?=
 =?utf-8?B?cXB3Qkovc2JyNDQrUjU3a1BhVHl5UUkrekk1V0JONTN1ajNmdHNWZVpoUStu?=
 =?utf-8?B?ZU9lQVFZMnhPS3g4QnQ1KzIzTUhIcE9vcjErd0lmMUQ4eTFIdHBQeXIyZ2RD?=
 =?utf-8?B?aTZaMHREcmlLNmhnc3BBc0lIcVFDVk1aOVhIZmJwVVdZUHhwbDRFeFArVkhP?=
 =?utf-8?B?VEhKWjNmUk9obVZBcTc5bDlGSzh5UTJxb2h6OUN5MDJvdVJBN25EVTZXRjM4?=
 =?utf-8?B?OWpLNTVJbUdvL2YxYVRZWmhSTjYyWGRhOFhaZEN4NjNWcER1WnVXTGdGSWdU?=
 =?utf-8?B?R09JR3ZmUkQ5R1hpTnpIM1J4RWhIU0R5b2RmNVlhTXcyd1pueUZYSTFISEp2?=
 =?utf-8?B?RVVwWG5zY0t6aUZUeHJyVW1zSDBIT2lsL1Z0TWRKVGRIVjRYRUxseXpIem1u?=
 =?utf-8?B?UVRRM0hHekVRZWdHUFRBZWJWOEZXN2ozK1ZyZ2R0dXVsNU4xM0ZwU1QwSkdL?=
 =?utf-8?B?WkZET056Ui9TMWdSdExkRkFQaDVLNGhxMy8xamJKdEpFb1RWTm5OSGZmbEhl?=
 =?utf-8?B?YnlKNGZNT0ZWUWZZS0Q1VE4wdEgzQzhIUVNWaHlJb1RrbDBkK05SYjR6eHk5?=
 =?utf-8?B?a0NERFArRFBXNmNvQ2UrdFprYWF4QmFrZ3NvQ2xmaWdIQW9Nc29NMlBOWkVN?=
 =?utf-8?B?dzhHQjJkRERyR1EydTRaaGppQUIwaXNQVVZsQ0FqUE9oNFkxeHpaM0FJb1lL?=
 =?utf-8?B?eS9oeWR4ZEZ2bjdpQnlwUDRCa3pvckQ2ZWxUWTRBUmgwaFJ4U0w2d1dpWVVN?=
 =?utf-8?B?OTBzNG9zbDdQTVcxeUpLVW1BMld3eFgycXRyTUoyRjRzZjdnYkhTWittM1J0?=
 =?utf-8?B?VlBxWHl0eWFITEFmdlV3bGRqMktYWFNSckd6bnZDVGx3VmFDSnhCcXdLVnhF?=
 =?utf-8?B?R0lMWnh6encyTFVSZk9pd0h6UlppblhZejhMaVNzRXZzdll1VW9hT3MvKzdW?=
 =?utf-8?B?a2d3M1hFdmtQWXFFT0xhcnhFM3JOSmJVbFFZeHhuNE5xS1MvSkEyUkZLVFV4?=
 =?utf-8?B?TnM2enRhaU5jNitTTXA1TzlzeXlUTVZNNzRwU3UvRXMvbHNObC9WcTlCYVlm?=
 =?utf-8?B?b2FEbWVsZFRXNU5FUUNmZFZLdFVUM1VMNTM3WUtyYk9lNzI4WG53cS9QVGMr?=
 =?utf-8?B?QUxXaWZQdjBHbnN2dUFydUQ4ZWtTM2xoZmt1dTR3YVFONEwrbXhlT2N1MTJ2?=
 =?utf-8?B?UHhIZ1pRUkZHY2lPSWFhTUx5cWpDaU5OZUFpSytiZzlYR3laT0VFSk1jWXNq?=
 =?utf-8?B?bVR3aXZpcTBicGloWHpxRkR5eG9uaTNXMzR1NTExZVhodzNldytHK2xmZEt5?=
 =?utf-8?B?aWVYbEhFUWtVajRGWlI4eFdqTGh6bmVuOGlpVEpjT3kyOWRlWHZpQWFVcEhM?=
 =?utf-8?B?eTAwd0JReE9wbk0reGtZSUM0cmpGbEVSWlIzWGVDcEErZmlvTHd4RTJacEJh?=
 =?utf-8?B?UEcyRTljRDk3WC9aSnVVQlFDRTNOVjVGeE1yczdQcDMvOEM4bXRxeE1KQTBx?=
 =?utf-8?B?M3VnWGNFRE5mSmdDQWxRUnJjc0JMNXVIaTJyMHY3dDkxUEZtQ2hXejhnWVdh?=
 =?utf-8?Q?1v9EPli91T0xhFC1VODkren1D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c30c63-babc-4f32-6499-08dcb8550252
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 09:24:03.0104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vq9YrFWeTQ2/4E/AIM8IirLbTvbuz5b9empGkXVuLqgGedi5izNPpOeKO1AzxDcbk57iRjCrZRNjNZ3AoSoKpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgOSwg
MjAyNCA0OjIyIFBNDQo+IFRvOiBaaGFuZywgVGluYSA8dGluYS56aGFuZ0BpbnRlbC5jb20+OyBU
aWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IENjOiBiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb207IGlvbW11QGxpc3RzLmxpbnV4LmRldjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA1LzVdIHZ0LWQvaW9tbXU6IEVuYWJs
ZSBiYXRjaGluZyBvZiBJT1RMQi9EZXYtSU9UTEINCj4gaW52YWxpZGF0aW9ucw0KPiANCj4gT24g
MjAyNC84LzkgMTA6NTQsIFRpbmEgWmhhbmcgd3JvdGU6DQo+ID4gK3N0YXRpYyBpbmxpbmUgdm9p
ZCBoYW5kbGVfYmF0Y2hlZF9pb3RsYl9kZXNjcyhzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwN
Cj4gPiArCQkJCQkgc3RydWN0IGNhY2hlX3RhZyAqdGFnLA0KPiA+ICsJCQkJCSB1bnNpZ25lZCBs
b25nIGFkZHIsDQo+ID4gKwkJCQkJIHVuc2lnbmVkIGxvbmcgcGFnZXMsDQo+ID4gKwkJCQkJIHVu
c2lnbmVkIGxvbmcgbWFzaywNCj4gPiArCQkJCQkgaW50IGloKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1
Y3QgaW50ZWxfaW9tbXUgKmlvbW11ID0gdGFnLT5pb21tdTsNCj4gPiArDQo+ID4gKwlpZiAoZG9t
YWluLT51c2VfZmlyc3RfbGV2ZWwpIHsNCj4gPiArCQlxaV9iYXRjaF9hZGRfcGlvdGxiX2Rlc2Mo
aW9tbXUsIHRhZy0+ZG9tYWluX2lkLA0KPiA+ICsJCQkJCSB0YWctPnBhc2lkLCBhZGRyLCBwYWdl
cywNCj4gPiArCQkJCQkgaWgsIGRvbWFpbi0+cWlfYmF0Y2gpOw0KPiA+ICsJfSBlbHNlIHsNCj4g
PiArCQkvKg0KPiA+ICsJCSAqIEZhbGxiYWNrIHRvIGRvbWFpbiBzZWxlY3RpdmUgZmx1c2ggaWYg
bm8NCj4gPiArCQkgKiBQU0kgc3VwcG9ydCBvciB0aGUgc2l6ZSBpcyB0b28gYmlnLg0KPiA+ICsJ
CSAqLw0KPiA+ICsJCWlmICghY2FwX3Bnc2VsX2ludihpb21tdS0+Y2FwKSB8fA0KPiA+ICsJCSAg
ICBtYXNrID4gY2FwX21heF9hbWFza192YWwoaW9tbXUtPmNhcCkgfHwNCj4gPiArCQkgICAgcGFn
ZXMgPT0gLTEpDQo+ID4gKwkJCXFpX2JhdGNoX2FkZF9pb3RsYl9kZXNjKGlvbW11LCB0YWctPmRv
bWFpbl9pZCwNCj4gPiArCQkJCQkJMCwgMCwgRE1BX1RMQl9EU0lfRkxVU0gsDQo+ID4gKwkJCQkJ
CWRvbWFpbi0+cWlfYmF0Y2gpOw0KPiA+ICsJCWVsc2UNCj4gPiArCQkJcWlfYmF0Y2hfYWRkX2lv
dGxiX2Rlc2MoaW9tbXUsIHRhZy0+ZG9tYWluX2lkLA0KPiA+ICsJCQkJCQlhZGRyIHwgaWgsIG1h
c2ssDQo+ID4gKwkJCQkJCURNQV9UTEJfUFNJX0ZMVVNILA0KPiA+ICsJCQkJCQlkb21haW4tPnFp
X2JhdGNoKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gK30NCj4gDQo+IFdoYXQgaWYgdGhlIGlvbW11
IGRyaXZlciBpcyBydW5uaW5nIG9uIGFuIGVhcmx5IG9yIGVtdWxhdGVkIGhhcmR3YXJlIHdoZXJl
DQo+IHRoZSBxdWV1ZWQgaW52YWxpZGF0aW9uIGlzIG5vdCBzdXBwb3J0ZWQ/DQpZZXMsIHRoaXMg
aXMgYWxzbyB0YWtlbiBpbnRvIGNvbnNpZGVyYXRpb24uIA0KDQpJbiB0aGlzIHBhdGNoLCBkb21h
aW4tPnFpX2JhdGNoIHdpbGwgYmUgTlVMTCBpZiB0aGUgSU9NTVUgZG9lc24ndCBzdXBwb3J0IHFp
IGJhc2VkIGludmFsaWRhdGlvbnMgKGkuZS4gaW9tbXUtPnFpIGlzIE5VTEwpLCBzZWU6DQoNCi0g
ICAgICAgaWYgKHR5cGUgPT0gQ0FDSEVfVEFHX0RFVlRMQiB8fCB0eXBlID09IENBQ0hFX1RBR19O
RVNUSU5HX0RFVlRMQikNCisgICAgICAgaWYgKHR5cGUgPT0gQ0FDSEVfVEFHX0RFVlRMQiB8fCB0
eXBlID09IENBQ0hFX1RBR19ORVNUSU5HX0RFVlRMQikgew0KICAgICAgICAgICAgICAgIHRhZy0+
ZGV2ID0gZGV2Ow0KLSAgICAgICBlbHNlDQorDQorICAgICAgICAgICAgICAgaWYgKCFkb21haW4t
PnFpX2JhdGNoICYmIGlvbW11LT5xaSkNCisgICAgICAgICAgICAgICAgICAgICAgIC8qDQorICAg
ICAgICAgICAgICAgICAgICAgICAgKiBJdCBkb2Vzbid0IG1hdHRlciBpZiBkb21haW4tPnFpX2Jh
dGNoIGlzIE5VTEwsIGFzIGluDQorICAgICAgICAgICAgICAgICAgICAgICAgKiB0aGlzIGNhc2Ug
dGhlIGNvbW1hbmRzIHdpbGwgYmUgc3VibWl0dGVkIGluZGl2aWR1YWxseS4NCisgICAgICAgICAg
ICAgICAgICAgICAgICAqLw0KKyAgICAgICAgICAgICAgICAgICAgICAgZG9tYWluLT5xaV9iYXRj
aCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBxaV9iYXRjaCksDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBfS0VSTkVMKTsNCisgICAgICAgfSBl
bHNlIHsNCiAgICAgICAgICAgICAgICB0YWctPmRldiA9IGlvbW11LT5pb21tdS5kZXY7DQorICAg
ICAgIH0NCg0KVGhlbiwgd2hlbiBpbnZva2luZyBoYW5kbGVfYmF0Y2hlZF94eHgoKSBoZWxwZXJz
LCB0aGUgbG9naWMsIGludHJvZHVjZWQgaW4gdGhpcyBwYXRjaCwgd291bGQgY2hlY2sgaWYgZG9t
YWluLT5xaV9iYXRjaCBpcyB2YWxpZCBvciBub3QgYmVmb3JlIHByb2NlZWRpbmcgYmF0Y2ggcHJv
Y2Vzc2luZy4NCg0KUmVnYXJkcywNCi1UaW5hDQo+IA0KPiBUaGFua3MsDQo+IGJhb2x1DQo=
