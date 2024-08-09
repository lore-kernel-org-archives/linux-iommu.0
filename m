Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54417129E9C
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193985; cv=fail; b=kwOSAR8JUwUxYhH6xHWjGyiYQRP4ctzK4VIKM8Z/xopiHoFa9MMVv7bGZFdre67o1I2nhsDF8HjLDp0nrZFyaqVjPeEPU2Xk6/CEIhHrUnUT+YUNJRyL0S03KWUIGjHu/g4qhIou+CCCF041rulpPQEdAVgH+thIjpBxiSkf8rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193985; c=relaxed/simple;
	bh=M31swyciE/YAb6/ZVdrqps4y1KgnIWTM0n/qrb2Si7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tFrH6KFqiscVT28yV16wyYNTkqKqLRri3OFKrZMuJ6qlxtPMmyrAJCgyhmNb0vWN9xvu1IBM7KI+GyVlEMS4N6LX16sf20u8mTm3i6igcISAYLvan2XM3JL7tBhWjqGjX5HWB2aK2YclUKpXMtbaJjnff5RJENABVSrIWR7Huvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PasuF5iQ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PasuF5iQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723193983; x=1754729983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M31swyciE/YAb6/ZVdrqps4y1KgnIWTM0n/qrb2Si7A=;
  b=PasuF5iQoAGP4puX3WoNLex93ISSTptGaJej7VMz7Ltp+e637hEH9iyj
   mYtPJ4uv4Mr+VUKwA08udasirkD/CGF2+nwXhvckfbIe5UOArGIdXQQv+
   KQ2Pb+CGd/TaEGqpOlyUZpv5WMFYVUqhn7zMnha11K3a7sqvmpS6DsCHp
   fwL9Sz2JkbidvkcchpzDWQfzYozpHq/8Y5kMqdiKBmxNTMbZ4++Y1QjA0
   PtlgkhD1lbNwnEo7gOrECMGvG4BiVtr+oHJJMoTJaChJI7D91FSN9URi5
   GRXZZUZGWtamimckDv0gL3kHY3wXXPgI5SPqzDvNbAIqkGRzdn5wWK6UJ
   g==;
X-CSE-ConnectionGUID: vg1MGH5BQ/q0kKENEy/ILA==
X-CSE-MsgGUID: Z5y7Fcy9SciTgZeO66q7/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31933696"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="31933696"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:59:43 -0700
X-CSE-ConnectionGUID: gd3lkn6XQJ2uyluLmn/nIA==
X-CSE-MsgGUID: uWMDUlf+R1+OoxS2PdXugg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62147350"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 01:59:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:59:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 01:59:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 01:59:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhhsoZB3mf4jSM/Vrxii1onxMWmF+CNE/pJ0cB1ZmWjP5R+GZ7HTkb1T3BVLYEl9vhUIROMh72exyekb0rlwM0R4sk6asSqv2zCLIdrNdwJ48G2IpEGjpKOh/rc9hJg7t//0C/6vUHom/ydEwirPPq+oCbnu2CJ8Ih2DxfqaFspZKIO+jYjDrdSdDTQkWAklPPgutm+kyB3yClEmJMXyml30ICprwsDsDNF3OWha5eiHuFldYdVLPNgT6mCgNXHw+THl8W+5CMmtMbHkatII9lt5gghmdABBotdnto9f2lKnyHI6k7u4wF6PJAsAxIUtD01f7NqxIg5ZMofiL5Dvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M31swyciE/YAb6/ZVdrqps4y1KgnIWTM0n/qrb2Si7A=;
 b=QK+IqFBMpMPLw81sXW2Cprd9ccGjXY6C5+FZYM2ryx8bniDgH9OiaLCcENB1AJXX22/9W5F69s6zDPWXgqDTlNTfIK03YOiSW4JdxLHdv4XZfnMjqHAJK8noLGlkLr91XDHK8aGW3WToSfz9oGoRRn622KYbQgVehdDtMnYNY9BRJclYrGqyrCgAdTp1XXGHmLfGB/I011qgUZo7kj90yp44vXyKT/PP36Vs7N00JbXlm6yFsTUC7X0nmT2pzDYjnhZnw1WjCOq2/D4F++FdJAx0rzgpzsXejw57CyTLMm7xG2sd8LqL+FsOyuCaNqRPrHXVWQpsaVWJ/b1oZZfcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Fri, 9 Aug
 2024 08:59:39 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 08:59:39 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] iommu/vt-d: Introduce interfaces for QI batching
 operations
Thread-Topic: [PATCH v2 3/5] iommu/vt-d: Introduce interfaces for QI batching
 operations
Thread-Index: AQHa6gfJK/9zmIoQakmQi414CsUy+rIelKoAgAAGu9A=
Date: Fri, 9 Aug 2024 08:59:39 +0000
Message-ID: <MW5PR11MB5881A8659273103114CF46E089BA2@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
 <20240809025431.14605-4-tina.zhang@intel.com>
 <41eda769-f1cf-4e96-9cf7-d74d4802eaf5@linux.intel.com>
In-Reply-To: <41eda769-f1cf-4e96-9cf7-d74d4802eaf5@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|MW3PR11MB4588:EE_
x-ms-office365-filtering-correlation-id: 7d296317-06fc-466c-0ec9-08dcb85199e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RlhaNGxHSU5pR3g5SVZwOHZGZFZIdnBEN0pIMFRRNm5UcVpVZlRiSmR2cTly?=
 =?utf-8?B?dVFZVTJ2SExRZWVBMU5IVHE1RVR2bXF1dVFWekJzV1d5YjEzZ3NoT3p2SDZ6?=
 =?utf-8?B?S0NCcHBZUGp3MHB0bnpIbFdRcWJLOTJnQjNScFBxYXhzWDczanpHTHpoZjMv?=
 =?utf-8?B?dFA4ZHpxenlGcWFMc0RJWUVuMWlrRHRHQWVpTlRoU0Q2TkhKOVRwbmFNTkpB?=
 =?utf-8?B?SWQvNVFjRzdYMVhDNGJFVnBaRzA3cVRQcVBTNjBTSzVyaTkyZkcwbUxkVEhN?=
 =?utf-8?B?TTZucjZyQ1NENXhHS3ZYOHg3R0pMdXFVWEpEYU9jU0svU09CQTh2T0dHU2J4?=
 =?utf-8?B?a1hqNFJpVmhJYXNMVmJ5OXZwUGZ6TC80TWlGUGQ0d3haNWQvaWVBUXBXM2ow?=
 =?utf-8?B?bXhRV2tKVlZHY3ZwaUFsN0paMm9tMzhhRkVNK2hHYW5UM25ib1Y3VTZPMkUr?=
 =?utf-8?B?NkpYWTZhNTV4clRZTGtreU95aCtFMUdONlIwVS8wWldxUU10NHJ3VlVidkt1?=
 =?utf-8?B?M0dMZUdnZi9vTWg3Uk1CKzZpOVlNWHg0WjlpRUlXTkMrUkF5LzVkVkxubDdy?=
 =?utf-8?B?MnJqbXNxK2FXbDI4NC9xUE1NZjczeFJja0UwVmhtaGs2S0QyajVpK2Z0VWlQ?=
 =?utf-8?B?MVEwcFpmeGFOSXQzTTc4N2hHRXlUUnJvTjU1ZDRrZFdSWVcwblorbXdHOFhJ?=
 =?utf-8?B?T1ltRGFRa204L3hJbzhRMjZWZkk2cG9CSG5UY3g1TlJXdXAxdms5ODhqbzV4?=
 =?utf-8?B?T2xoQ2NlamEzbTJWVEpjM0x6ZkZ3Ykx6SmlNdEV0Z3BJakZHTEtuYk1JbmdV?=
 =?utf-8?B?T3ZybDZuVjFmMkVuOTlVMGE2VUxNVDJHWlp3TnVhSFRWcnJrQzc3WGxyQjVN?=
 =?utf-8?B?S3F1TG5xTmtoU2J1V2pzemd5UWtnTVo5ZkxtdXUvcW1ScjJtUkMweXN4d005?=
 =?utf-8?B?N0RJNjlyTWtnSjJGR0ZTK1YvblNqTnFJOFBpejBtcldBcFBFTUtDQlVPV3lm?=
 =?utf-8?B?SzFqUjVONzl5SEQrbVAxdHhvMWRqOFFWQ0xNQTBFNTQ2dUNjTHNTYU5Zc2VN?=
 =?utf-8?B?TzFyYzN6YjIzcUcxT1EzNWxDYUlMWkRJVXVYL3FmSEFMZ3RJUHh6THRmQU9M?=
 =?utf-8?B?d3lQWms3QzMwNndGQ2tEb1Jta0dJL2ozc0Zvc0xOWmVmUHdmMnEwUkwwVW1O?=
 =?utf-8?B?ZDg2Y1hyZWFySUpDeHNZeG5vYWhibzk3c2EyTjR0cG5kbll6TU0zK0ttazkw?=
 =?utf-8?B?WnBwdDdjYTdETGN6djB4d2F5M3JmQW5FRmNncVFtSmhuL2l1R1NLUkpibTJJ?=
 =?utf-8?B?cmNpNlA0cU45T2RrMFl2OVpFUkVhZndZRndIZGdIMWxTS3lLcTlacnZRVXBZ?=
 =?utf-8?B?REV2VlR1aUYyYTZtbmVqRUJHT3IwcEhyOGg2TTZnRklLLzFPL09JOWhFUlB5?=
 =?utf-8?B?d2xzTW9xejA5NWlKVTcvckx2eFljd1BEcjdLaEtUcXFzWkNmNTJnMDFGQW5v?=
 =?utf-8?B?TGtsOHBtYnJEcngwdElFdkEwOThnTXJrYWhYUmZ5T0Uvd2tubTRsK1F1dmlp?=
 =?utf-8?B?NEF0eFJXR2JjYWlxNnlmd3VnUVlhQTY5RzVaOVZyK2ZnZG5ING8veVN3UGww?=
 =?utf-8?B?RTd3TkhTd25iQ0FvRGp2WEt3OVQwQVUrQVNtd2RPcysrRlROaTh4bTBIbnMy?=
 =?utf-8?B?MS9SY1B5SXJQWk82L2hTMmRHS3lvRUl0UldBTjUrRGZEUGZ0OVZtdnY3TC9q?=
 =?utf-8?B?R0VVcGRTcktnWGhMdEI5RHo3K1hONnpFSnFzeXdwd1ovZWV2aldsa3Fpb08x?=
 =?utf-8?B?b3JJUkJ5anpRd25NalNZbzczc2haTkZFOXpMTGcyWlU3OTRlZXdhNjl6Ukgv?=
 =?utf-8?B?dWR0bHU4ZTJrV3BnWk1PVEZvTUhTRzBSWFVEdHpZZDNKdXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NS9lcXFYZ1d4NVNvUWVoV3Q4aEdMSGQwT1UwMmFoTC9ZN1lCRllJcUJjQ1ZH?=
 =?utf-8?B?Z2NnMS9Ga1F1NzkxOTVYY01EaTBJU2pnVEFWWFVlK2pnSGx0ZjJVV0VobG1q?=
 =?utf-8?B?ZHJlOVFmMERuR21LcXFYZ256L1pEdkhHT3JBamt1SVFnUWRRbFZzeExxNmpZ?=
 =?utf-8?B?K0R0amRaNzUvL3hPVDJHVFBwTnlQdzdsdXE5R05nTWkvME83NzMzdFpmUTBH?=
 =?utf-8?B?ajFRSGV6T1VwMnYzNU5zRzhQK0IvV2lscUo3c1NJTnpNZlRnU2thSFZySEFk?=
 =?utf-8?B?ZHZzY0FrRkZwZ2paNjdNQmE4K05hZ1lJVk9NTDBUekVBL1FNMHZNSE9uUEVh?=
 =?utf-8?B?b3MyYWFFeVZXUjV4Q2RoYVAvRkVJQXBhaW5Nb0VTTXY2K2greDZyK2JjQ21z?=
 =?utf-8?B?S3dtMnI1bWNmNlZMYzNmaXZOeHB3MnErRGc3SGlSVStVVldwMzdLaHoxR28y?=
 =?utf-8?B?R0JGZjMrY0hRL21WNkYrQXFzT2FNTFh1aXBvamVEbE0zVWtKZm5iRTlrdSsy?=
 =?utf-8?B?cEJBbTFlZFB6dG5tK3g2anZNbWhVMEtzUzhBWnJQSVBoN0tkNjhkeFNsNU9F?=
 =?utf-8?B?TGt3cExwM255Tm9ZK3BhZTd0ajhjbFlBZmRyeCtxNXdwWXRnMG51NGpBWEVi?=
 =?utf-8?B?S1FDSE5WUFVCN2dwM2FkSWJKVXh4eURGK0dPWkpRdzA3WGF5azljMnFDU2hR?=
 =?utf-8?B?Mi9qQVZQZFVSSXZCbmNGU3VVb3lLSWxjNFBMNEVqa3pKT1dZT1R6YWNzMFJq?=
 =?utf-8?B?WUdONTNlcG4yeVhWejJuNi9NNnNIdWFkbGVZbjBPdzRQRUV2K1dubTAzVkRj?=
 =?utf-8?B?UDRSVUNncGtKRDl6Z1FTMGhWMnR6N2xIVU1DYndDU09hbEpZcnhGSWhYcmFY?=
 =?utf-8?B?K1doUXA0WkVCQklOQzd6UDI4ek82ZTYwUmYyeHhLMWdUZ1BsRTF3bUIxdEkz?=
 =?utf-8?B?TDRCNGRkR0xscGlKSGR0MGw3akkzemdhalVNcStnL0w2SUhUMklxb01peEZ0?=
 =?utf-8?B?TFU1QmdwSWZVSS8zcWhmYlRPeFkwekpkamhHZGNqK0IwbmVPQUN4VkpPQzIw?=
 =?utf-8?B?eHBCcnhwQWZIK3phWnpETmh0RU1wVGtCeXNzeDdwUW9VejJIMlRidXFKY2JV?=
 =?utf-8?B?dW9wbkp4ZmpUTzVUR2ZUVHdHUUVCZXZrZVdLQ1FUd3hESTJSVTVCbDExTmVt?=
 =?utf-8?B?KzZ6YXN5b0tJQkdlUHkvVThMU0k3TGV2dk9hRThRejB1Q3hHUnJtRTd2US93?=
 =?utf-8?B?UUMrOHBGblUrSWFWZzlrOXhOZE1BUXVwS0Z6cytmS0tGTEVFZzUwSGNvV3Q5?=
 =?utf-8?B?elQ4YzVYLzRKSjVES204ZVZqWHlYVnBOYVgzbHg2T0V1TFBvWTA1TzdTZy9N?=
 =?utf-8?B?V0RnZkxad1VLdS80UUpBTjBvaVg1elp2S3F0bG8yNVp6V053Y2xxMmRRUktp?=
 =?utf-8?B?VU4vbFJpSGlzRDJEMkZUazA3a1NKQU8vU1hHQUdtc2pqRUV3T21EZzdPZkgy?=
 =?utf-8?B?cXdHVUFUV3ZrQWZCZXZZVTNVMzYzQ3RqSFE5QzhvSnhBUlRXc2VlblV4VUNM?=
 =?utf-8?B?R3k5Zk5LNmJsckdCeEZ1Y2dTd3lKUi9aY2hseHJRZVNzNlFUd0NuQ1F0Zm1m?=
 =?utf-8?B?R2RjQSt1NDNWWXhXUWtUdnMyRHFRU0RrYWNFOFpLNTZrTmxGeHZPRVpaTm9U?=
 =?utf-8?B?dmFnTnpjZTc4ejZlVGlBQTllckorTlhMVk9VZUJCUGhlUkV3elYrMkRNdnhS?=
 =?utf-8?B?K2dHdlRxMzhTbVNLSHZaRmxmcUlFNkpDbzMyamdHa3RBNVBQQVpoUW1uSEZC?=
 =?utf-8?B?dDgwa1dDdkVva1dFNjFGanlyMlRlemt3ZXZaR1c5T3RMamdVYjRTZFFaZ1dR?=
 =?utf-8?B?R0Qvc0owcHViUVpnZjV1cnJDMTVNZXRndUUwYWJWeUJkQS9CR1FWeUpIMXh6?=
 =?utf-8?B?TWV2Mm9VZHNmNTNwRWZ2QVhwTlFiZXFmZ09nOFYvZHp6MkZpMnhRbGhQU0Ry?=
 =?utf-8?B?b21oRUx0Yk54aHFHZEdQUDE2NWkzaGZObmsvWE1OZEM1TDNjbmNMbUJ2S0g0?=
 =?utf-8?B?czJRVEE3dFU5dnFrdjNSMjlKQnpXUDZqcVk0S3VWcVQzVW9mamp0cnlhZkNk?=
 =?utf-8?Q?e03WDRtsMCqPZLl9sa/B/eEj8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d296317-06fc-466c-0ec9-08dcb85199e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:59:39.2987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhwVVDwjmdhPeBF8Qn8htL9HAHFnyUAhTfJbu64+YKuShY1Ypzsqab/kSYtHQzjDct1OKbiwXZ9fDkLI25gtTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgOSwg
MjAyNCA0OjE2IFBNDQo+IFRvOiBaaGFuZywgVGluYSA8dGluYS56aGFuZ0BpbnRlbC5jb20+OyBU
aWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IENjOiBiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb207IGlvbW11QGxpc3RzLmxpbnV4LmRldjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzVdIGlvbW11L3Z0LWQ6IEludHJv
ZHVjZSBpbnRlcmZhY2VzIGZvciBRSSBiYXRjaGluZw0KPiBvcGVyYXRpb25zDQo+IA0KPiBPbiAy
MDI0LzgvOSAxMDo1NCwgVGluYSBaaGFuZyB3cm90ZToNCj4gPiBJbnRyb2R1Y2VzIHFpX2JhdGNo
X3h4eCgpIGludGVyZmFjZXMgdG8gdGhlIFZULWQgZHJpdmVyIHRvIGVuaGFuY2UgdGhlDQo+ID4g
ZWZmaWNpZW5jeSBvZiBJT1RMQiBhbmQgRGV2LUlPVExCIGludmFsaWRhdGlvbiBjb21tYW5kIHBy
b2Nlc3NpbmcuDQo+ID4gQnkgYWxsb3dpbmcgdGhlc2UgY29tbWFuZHMgdG8gYmUgYmF0Y2hlZCB0
b2dldGhlciBiZWZvcmUgc3VibWlzc2lvbiwNCj4gPiB0aGUgcGF0Y2ggYWltcyB0byBtaW5pbWl6
ZSB0aGUgb3ZlcmhlYWQgcHJldmlvdXNseSBpbmN1cnJlZCB3aGVuDQo+ID4gaGFuZGxpbmcgdGhl
c2Ugb3BlcmF0aW9ucyBpbmRpdmlkdWFsbHkuDQo+ID4NCj4gPiBUaGUgYWRkaXRpb24gb2YgcWlf
YmF0Y2hfYWRkX3h4eCgpIGZ1bmN0aW9ucyBlbmFibGUgdGhlIGFjY3VtdWxhdGlvbg0KPiA+IG9m
IGludmFsaWRhdGlvbiBjb21tYW5kcyBpbnRvIGEgYmF0Y2gsIHdoaWxlIHRoZQ0KPiA+IHFpX2Jh
dGNoX2ZsdXNoX2Rlc2NzKCkgZnVuY3Rpb24gYWxsb3dzIGZvciB0aGUgY29sbGVjdGl2ZSBzdWJt
aXNzaW9uIG9mIHRoZXNlDQo+IGNvbW1hbmRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGlu
YSBaaGFuZzx0aW5hLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW9t
bXUvaW50ZWwvZG1hci5jICB8IDc4DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuaCB8IDM5ICsrKysrKysrKysr
KysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTE3IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyBiL2RyaXZlcnMvaW9t
bXUvaW50ZWwvZG1hci5jDQo+ID4gaW5kZXggNjQ3MjRhZjFhNjE4Li44ZDU1YzQ5MzgyZmMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMNCj4gPiArKysgYi9kcml2
ZXJzL2lvbW11L2ludGVsL2RtYXIuYw0KPiA+IEBAIC0xNjM2LDYgKzE2MzYsODQgQEAgdm9pZCBx
aV9mbHVzaF9pb3RsYihzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11LA0KPiB1MTYgZGlkLCB1NjQg
YWRkciwNCj4gPiAgIAlxaV9zdWJtaXRfc3luYyhpb21tdSwgJmRlc2MsIDEsIDApOw0KPiA+ICAg
fQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIHFpX2JhdGNoX2luY3JlbWVudF9pbmRleChzdHJ1Y3Qg
aW50ZWxfaW9tbXUgKmlvbW11LA0KPiA+ICsJCQkJCSAgIHN0cnVjdCBxaV9iYXRjaCAqYmF0Y2gp
DQo+ID4gK3sNCj4gPiArCWlmICgrK2JhdGNoLT5pbmRleCA9PSBRSV9NQVhfQkFUQ0hFRF9ERVND
X0NPVU5UKQ0KPiA+ICsJCXFpX2JhdGNoX2ZsdXNoX2Rlc2NzKGlvbW11LCBiYXRjaCk7IH0NCj4g
PiArDQo+ID4gK3ZvaWQgcWlfYmF0Y2hfZmx1c2hfZGVzY3Moc3RydWN0IGludGVsX2lvbW11ICpp
b21tdSwgc3RydWN0IHFpX2JhdGNoDQo+ID4gKypiYXRjaCkgew0KPiA+ICsJaWYgKCFiYXRjaC0+
aW5kZXgpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCXFpX3N1Ym1pdF9zeW5jKGlvbW11
LCBiYXRjaC0+ZGVzY3MsIGJhdGNoLT5pbmRleCwgMCk7DQo+ID4gKw0KPiA+ICsJLyogUmVzZXQg
dGhlIGluZGV4IHZhbHVlIGFuZCBjbGVhbiB0aGUgd2hvbGUgYmF0Y2ggYnVmZmVyICovDQo+ID4g
KwltZW1zZXQoYmF0Y2gsIDAsIHNpemVvZihzdHJ1Y3QgcWlfYmF0Y2gpKTsgfQ0KPiA+ICsNCj4g
PiArdm9pZCBxaV9iYXRjaF9hZGRfaW90bGJfZGVzYyhzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11
LCB1MTYgZGlkLCB1NjQNCj4gYWRkciwNCj4gPiArCQkJICAgICB1bnNpZ25lZCBpbnQgc2l6ZV9v
cmRlciwgdTY0IHR5cGUsDQo+ID4gKwkJCSAgICAgc3RydWN0IHFpX2JhdGNoICpiYXRjaCkNCj4g
PiArew0KPiA+ICsJcWlfZGVzY19pb3RsYihpb21tdSwgZGlkLCBhZGRyLCBzaXplX29yZGVyLCB0
eXBlLCAmKGJhdGNoLQ0KPiA+ZGVzY3NbYmF0Y2gtPmluZGV4XSkpOw0KPiA+ICsJcWlfYmF0Y2hf
aW5jcmVtZW50X2luZGV4KGlvbW11LCBiYXRjaCk7IH0NCj4gPiArDQo+ID4gK3ZvaWQgcWlfYmF0
Y2hfYWRkX2Rldl9pb3RsYl9kZXNjKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUsIHUxNiBzaWQs
DQo+ID4gKwkJCQkgdTE2IHBmc2lkLCB1MTYgcWRlcCwgdTY0IGFkZHIsDQo+ID4gKwkJCQkgdW5z
aWduZWQgaW50IG1hc2ssDQo+ID4gKwkJCQkgc3RydWN0IHFpX2JhdGNoICpiYXRjaCkNCj4gPiAr
ew0KPiA+ICsJLyoNCj4gPiArCSAqIEFjY29yZGluZyB0byBWVC1kIHNwZWMsIHNvZnR3YXJlIGlz
IHJlY29tbWVuZGVkIHRvIG5vdCBzdWJtaXQgYW55DQo+IERldmljZS1UTEINCj4gPiArCSAqIGlu
dmFsaWRhdGlvbiByZXF1ZXN0cyB3aGlsZSBhZGRyZXNzIHJlbWFwcGluZyBoYXJkd2FyZSBpcyBk
aXNhYmxlZC4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKCEoaW9tbXUtPmdjbWQgJiBETUFfR0NNRF9U
RSkpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCXFpX2Rlc2NfZGV2X2lvdGxiKHNpZCwg
cGZzaWQsIHFkZXAsIGFkZHIsIG1hc2ssICYoYmF0Y2gtPmRlc2NzW2JhdGNoLQ0KPiA+aW5kZXhd
KSk7DQo+ID4gKwlxaV9iYXRjaF9pbmNyZW1lbnRfaW5kZXgoaW9tbXUsIGJhdGNoKTsgfQ0KPiA+
ICsNCj4gPiArdm9pZCBxaV9iYXRjaF9hZGRfcGlvdGxiX2Rlc2Moc3RydWN0IGludGVsX2lvbW11
ICppb21tdSwgdTE2IGRpZCwNCj4gPiArCQkJICAgICAgdTMyIHBhc2lkLCB1NjQgYWRkciwNCj4g
PiArCQkJICAgICAgdW5zaWduZWQgbG9uZyBucGFnZXMsIGJvb2wgaWgsDQo+ID4gKwkJCSAgICAg
IHN0cnVjdCBxaV9iYXRjaCAqYmF0Y2gpDQo+ID4gK3sNCj4gPiArCS8qDQo+ID4gKwkgKiBucGFn
ZXMgPT0gLTEgbWVhbnMgYSBQQVNJRC1zZWxlY3RpdmUgaW52YWxpZGF0aW9uLCBvdGhlcndpc2Us
DQo+ID4gKwkgKiBhIHBvc2l0aXZlIHZhbHVlIGZvciBQYWdlLXNlbGVjdGl2ZS13aXRoaW4tUEFT
SUQgaW52YWxpZGF0aW9uLg0KPiA+ICsJICogMCBpcyBub3QgYSB2YWxpZCBpbnB1dC4NCj4gPiAr
CSAqLw0KPiA+ICsJaWYgKCFucGFnZXMpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCXFp
X2Rlc2NfcGlvdGxiKGRpZCwgcGFzaWQsIGFkZHIsIG5wYWdlcywgaWgsICYoYmF0Y2gtPmRlc2Nz
W2JhdGNoLQ0KPiA+aW5kZXhdKSk7DQo+ID4gKwlxaV9iYXRjaF9pbmNyZW1lbnRfaW5kZXgoaW9t
bXUsIGJhdGNoKTsgfQ0KPiA+ICsNCj4gPiArdm9pZCBxaV9iYXRjaF9hZGRfZGV2X2lvdGxiX3Bh
c2lkX2Rlc2Moc3RydWN0IGludGVsX2lvbW11ICppb21tdSwNCj4gPiArCQkJCSAgICAgICB1MTYg
c2lkLCB1MTYgcGZzaWQsDQo+ID4gKwkJCQkgICAgICAgdTMyIHBhc2lkLCAgdTE2IHFkZXAsDQo+
ID4gKwkJCQkgICAgICAgdTY0IGFkZHIsIHVuc2lnbmVkIGludCBzaXplX29yZGVyLA0KPiA+ICsJ
CQkJICAgICAgIHN0cnVjdCBxaV9iYXRjaCAqYmF0Y2gpDQo+ID4gK3sNCj4gPiArCS8qDQo+ID4g
KwkgKiBBY2NvcmRpbmcgdG8gVlQtZCBzcGVjLCBzb2Z0d2FyZSBpcyByZWNvbW1lbmRlZCB0byBu
b3Qgc3VibWl0IGFueQ0KPiBEZXZpY2UtVExCDQo+ID4gKwkgKiBpbnZhbGlkYXRpb24gcmVxdWVz
dHMgd2hpbGUgYWRkcmVzcyByZW1hcHBpbmcgaGFyZHdhcmUgaXMgZGlzYWJsZWQuDQo+ID4gKwkg
Ki8NCj4gPiArCWlmICghKGlvbW11LT5nY21kICYgRE1BX0dDTURfVEUpKQ0KPiA+ICsJCXJldHVy
bjsNCj4gPiArDQo+ID4gKwlxaV9kZXNjX2Rldl9pb3RsYl9wYXNpZChzaWQsIHBmc2lkLCBwYXNp
ZCwNCj4gPiArCQkJCXFkZXAsIGFkZHIsIHNpemVfb3JkZXIsDQo+ID4gKwkJCQkmKGJhdGNoLT5k
ZXNjc1tiYXRjaC0+aW5kZXhdKSk7DQo+ID4gKwlxaV9iYXRjaF9pbmNyZW1lbnRfaW5kZXgoaW9t
bXUsIGJhdGNoKTsgfQ0KPiANCj4gSG93IGFib3V0IG1vdmluZyBhbGwgdGhlc2UgaGVscGVycyBp
bnRvIGRyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYz8NCj4gSXQncyB0aGUgb25seSBjb25zdW1l
ciBmb3IgdGhlc2UgaGVscGVycywgcmlnaHQ/DQpXZWxsLCBjYWNoZS5jIGlzIG9uZSBvZiB0aGUg
cGxhY2VzIHdoZXJlIHRoZXNlIGhlbHBlcnMgbWF5IGdldCBjYWxsZWQuIEFub3RoZXIgcGxhY2Ug
aXMgcXVpcmtfZXh0cmFfZGV2X3RsYl9mbHVzaCgpIGluIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9t
bXUuYy4gQW5kIHRoZSBxdWlya19leHRyYV9kZXZfdGxiX2ZsdXNoKCkgZ2V0cyBpbnZva2VkIGlu
IGJvdGggY2FjaGUuYyBhbmQgcGFzaWQuYy4NCg0KUmVnYXJkcywNCi1UaW5hDQoNCj4gDQo+IFRo
YW5rcywNCj4gYmFvbHUNCg==
