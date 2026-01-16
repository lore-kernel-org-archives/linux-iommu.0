Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0895D3594F
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768544201; cv=fail; b=Xu8qxM3Ft1N2W4V694djGenoouX58QDjDlCsfvwUJgBL9kLPTXfPgw6lJ6TlkHloWqvT5wsBxFzaae60DU2MejoCmm2vKx2txANkoyNnSpOyjmjCyNELAIiduiTxjifHf8eSSJo9HTXTnWfATokuV/hXhbPqIJWAAYAqwDGubjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768544201; c=relaxed/simple;
	bh=Y/ubIIWJqMHsgrqetw/UHl/r4svw/p09Svi33SC5e3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0YwYIQTRywkbLh0g0oxpUUMOUyNpd5mn4uVT8E0ezWv81HOK5gDyFtScd7uSwVElXixY03nTRxL5hip2LDe5BpzW+FaDP4yFwkpTQS2CoQNwpCDRLW836xEaHbeipmMNYWcIrwztbwBysrO+4FQX2JXBqgoGN527MU3BtalXIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKA0mg8X; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKA0mg8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768544200; x=1800080200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y/ubIIWJqMHsgrqetw/UHl/r4svw/p09Svi33SC5e3I=;
  b=GKA0mg8Xfjy8yU3OZTRY2iQqOp3RwHEiEMuKz5/umRuscloaY5LDBiuE
   m8f+rUwTv/gWR0YJNVTiwYqiCgOqEsxflph5HUKQ5tNnngDrligixjA0u
   l75NlmCrNjxXZ8C4qN/uLnx2fLz9lIF+K+EWJhrVdxN7IqGhqcvH5ibHQ
   rSE/YQdaO9JNgLCxBsiF0kERF6ZpSZtLd4Kc/WYWAzQEcmn0jcnbeaqza
   8O0RqUtf4PGWM4vyGqQ4iCSkFBwTvKM/BCb0SXLRAvUtpc6XEpH2XgddB
   8o+HuoqH1DVXll+wBTbptYB2Gn7tkv2Uir+cu0AMHbDXR0jCiyljU3eRL
   A==;
X-CSE-ConnectionGUID: Ye9P9R8mSty7TCAdckRBvQ==
X-CSE-MsgGUID: tEgW1iVTTn2wHQHCDcwygQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="81224306"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="81224306"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 22:16:39 -0800
X-CSE-ConnectionGUID: oNO3EiztQ7WiWExCI8Akvw==
X-CSE-MsgGUID: q2aIsaPVTk+ejC4SLw3GyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="209654346"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 22:16:40 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 22:16:38 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 22:16:38 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 22:16:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFmTayVNuv/QP+0UsQ5iQ68NWNaOAqac3ndYOshDPUY0eG9sBDPjfk54nQdBg3d5tu8hSiKH/9d03p9KF8m56cDoEuHJE3uJb9dxqxjoIOirF9B8wR/rXs9LcWC1r7cbA4FGd9k0JGRH170NTCedOCbst43LjwllQ1n5CmatUeQ/DHxYxUfKwmeo/q9j1uxxC0GpGQws5O/ExSlvmW0EY2Uw5A1kcKIdpDyDj4CvuYHDbZh2KFaWIy3IUsyp55VozNdrxuNFdlKb5JRshcZlXTLkmtlqMC2OMdpDMnyJVU+MnSpuKgjIEn4VNvKxtoEppIYmzlYuC0F43q5bgr6qwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/ubIIWJqMHsgrqetw/UHl/r4svw/p09Svi33SC5e3I=;
 b=V/L38dXy2B90XFxrlmRqyjyVKiNsL7178JJjO9h+3RakJb+dJ2t+qR8V7TBr0DpiRnq8XnjPHRs7yy0YqOaG/vZjnUH5YpgHYX+5j2rB0ildRPGTKnINB2z/4TXggo7lNNe7y4kqxP6cCCA5i90wIf5ouJjgtLQg+O5yrQl5TXb3qC3TLPa5zYObx3s2iwQhcmZUsJHq3O6wws/YEs04hHsIDJRgNnPSDjvTjSlgIVGhNe/ZEiDn3zHWPYnmaRIF2fACVmtwk8HDHkNVucJuW885Fk2QwnSGjt44Ufbmq4px1nrfzcT7JYqNDSaVUwiXEIldbQY9/R6E0eWyZit7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6041.namprd11.prod.outlook.com (2603:10b6:8:60::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 06:16:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 06:16:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Samiullah Khawaja
	<skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Dmytro Maluka
	<dmaluka@chromium.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Thread-Topic: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Thread-Index: AQHchDk8uR0lu8XrwEKOIcSK4FCQmrVQfN4AgACsmgCAAA5hEIAAb+iAgAERgCCAAIPmAIABCh+Q
Date: Fri, 16 Jan 2026 06:16:31 +0000
Message-ID: <BN9PR11MB5276C686DB7BDD83FAA7FF548C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
 <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
 <ef58cd8a-504d-457b-b731-f7dfdba0e43c@linux.intel.com>
 <BN9PR11MB52760881132AD4513E32373C8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260114131715.GA961588@nvidia.com>
 <BN9PR11MB5276C98AADBE65795DAC5CB28C8CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260115132814.GF961588@nvidia.com>
In-Reply-To: <20260115132814.GF961588@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6041:EE_
x-ms-office365-filtering-correlation-id: 1b0b233e-b1ba-41dc-f1eb-08de54c6ca9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RFU1dUVMSVl6MEtJWklaNVdFNEpZaGJMRkcvSzdma1VYa3JCTlBWQXh2QXJG?=
 =?utf-8?B?cWZ0MnA4MUUwYS9mQ3BNYmJlRG9QWHZlNXE1ZGdFU3dVNTk5dzhVRmxTRDl5?=
 =?utf-8?B?cElWeWZDZVZIVVVyeEF2VDkzNWJVSUNFV0dGZTZGQWJHRmc5WHkrN1UvTnR4?=
 =?utf-8?B?UTMyR3VNWDRwUGhUb2pqeW00ci9MeW5OaGxZNWtlUVlrS2llZ2xybWxoRHJE?=
 =?utf-8?B?Y3B2aGdHL3hMN091Q2F4Ty9TR0tnQTBkd3g4UlRrSmxMRHQ1RWNxNUY3Vmx3?=
 =?utf-8?B?UHEwVUxHTDU0TGJLNTNiY0RQZDNPMDlTalpJYlRERTh2YnpIcTJ5M201aThT?=
 =?utf-8?B?SlpLcGVDZUJIRGlyQmUrM3RKMWZGSytMSC80d25YZ3M3aFhETVcyalB6RHJq?=
 =?utf-8?B?QXBvSXMzNW05TjNCTFBhMVo2cGt0NU9aMGNxcUtQVGdFbTdOZjRvQzV2SldI?=
 =?utf-8?B?bGgyOTZBZzNLS0VvTGQ1Unk4WXJTcFBndG5xZHd0NWR5VngzWFhiaHgyclJB?=
 =?utf-8?B?U2ZyZGoxaDhZRmFJbWp2T3ZWSnh0L2M1WGVRY3hvL2JQUGpXNUFXSjBKOThN?=
 =?utf-8?B?Sm9EdW9JN0dFZkJPWGVMK1ZmYTVGQU0ydHUvY2Nua2dIbGQwVG9lYnRUMHll?=
 =?utf-8?B?VjAzOU00bFhZQVpiQ3NtajFUV2hReW5iQ1lrckZaWUtUalF4cGU1aXZZUzVZ?=
 =?utf-8?B?WmhjOVgrMmF5WGExU0hQSWw4WUhlTTRyWktzZkQ2WVZ6TWdKTUtZMjdRYlFy?=
 =?utf-8?B?NkRPQ0IrZzJNV0ZkdWpLOHRUOVBnMmxNYzVBUFRxdHJaamU2UXJ2S3J4QXJI?=
 =?utf-8?B?ZkhDV2RpdUIyREJvMHU2dzAwcldsY3NwNEZSOGJpS0h4RkQydmdCOXN5UlQw?=
 =?utf-8?B?bHdJMVkyNDBmUkV0NkhRK2VPQWdRa1dFM3I0SHMzNzVTeDJ6WjhoeENTa3pZ?=
 =?utf-8?B?ckVoZGtweGJCUXA3Rm8wVG01Mnh5U0Zncmg4MC9lM1hERzFQc2s1MUVjZkk3?=
 =?utf-8?B?azRrRUEzTytGUUxJWmZTKzN1MlFzcVRMTDRPbkM5TkFmQUwxdU5IRXllb2RH?=
 =?utf-8?B?Rmp1S1VDdEpZWk52ZVd3akxxVjR0VHo4Ym52VDN2Qzl0MlFTMmEwMlVEMnM2?=
 =?utf-8?B?ejUxMTZ2M1VkcXJnc3pZUzRMMTJoUTdmRDZSS0NPeUhnVC9JamZiZEtuN0U1?=
 =?utf-8?B?ZFg0MmM4M3kyQVFOSlU3bVhKb09DQVVranhuSzVLOWRKRnl5dEhEUEwzWEpm?=
 =?utf-8?B?clJzZWViclRid3BjdXd1cHlPRXUvV1ZFUmtmd1B3NjBYN2ZWMk8xMlRPQXJZ?=
 =?utf-8?B?MGtJRzFQM3lFRVNJbldEUTNJSEErTW5QRndocUx0NUlRbTYrWll0QlV5TkVR?=
 =?utf-8?B?QnFlbkczb29yTitDWU1wNHJzeERTTjNBMDkwcjVNVHBaNk1CMzVDUzkrNGt3?=
 =?utf-8?B?Z2luaFhEaVhZSkxFSDg5dWxzbjRLZ2IwdEs2NTJtK1d1ejk1VWIrUnBqMSt5?=
 =?utf-8?B?WVEzUHFJSHM0L2lCcnlMSDkxOXZGMmlxU09KeXZRUkRDRXE2ZHN3TWVPcXpP?=
 =?utf-8?B?SmZYU0s5eE9HMlpqVHNzbGhVVHhIc1JwNW5yczhUUE4rSUpkb29FOUZRVW9E?=
 =?utf-8?B?b3U2YzB6SGY4TEhYV0dsSHRKZ3JmTlYwM1UzU2pQaEJvM0tXZE1sNUpIekRj?=
 =?utf-8?B?a3ZCWnBaNUZIWDdGcCtIUG8wR3dWdUppamNzSWNjL0ZRelFyUmtiMVNrMUxD?=
 =?utf-8?B?dHk2Q0dMdDFqMGZHQm0wS05IYzdkYllFbWtOQW84elJqbHV2a0g0U1pub29H?=
 =?utf-8?B?Sm0rd1NxM2pubHE1ZVc5VlNkekM4VEkvOFFENEZ3aHA5TGRTTXdHeHlvQTIz?=
 =?utf-8?B?SGdsK3JGclkxWVNTUGdlNWVQeTdMVHpaSkxIRFB5Q0wyRHN5UCtweUtSdlFH?=
 =?utf-8?B?Ykp0RHFlS2Zia0dpZURpd2V2YW9BWVZraDNaRjV6R0NQMFNFeklCZEt2MU9i?=
 =?utf-8?B?VndKaStTNkkxTGthKzhzUXQ1Mmw2WVpJNUdUbjR1cC9VejRmSzZHUW5uMndo?=
 =?utf-8?B?N21NWjdNbFdaWFRBeXFNbWkrYVFyUFNUS05LZ0xDSUlONnB3Y3VJUkpDbjZK?=
 =?utf-8?B?RHYwbTM2MUY2T282cUhhM3R6WFdjbUVtRWhjMWdmdXlMNlRZMGxqUTgwQkE1?=
 =?utf-8?Q?GXOwSUe9bab3yPzroMxSsuE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVZ1Qld2UTNvaUdiSVhBZHhMejFrNXBEM25hTEY4ZFlYY0djWFphenROZmxZ?=
 =?utf-8?B?eXFoSHlKdWN2RjREdE5SQlRERmNrME9vWEMxYXpENk9VSEExbHdweGhjdlBy?=
 =?utf-8?B?cUd6OUc1cHRXQ25meE1rQTB2UkRHcVcrT3lHNHdQUEs0SlNKNnZKZjRDNS93?=
 =?utf-8?B?S1hTSUhDQ1prVFVycFdGS1huN1VSWlIvMUJhSVF1eUFQS25TSWF4SEdBV3l1?=
 =?utf-8?B?Vm50cjgrTFBoYnZoTUJTazE4Slg5bzNkZGc2dDk4S0ZUOEdiRklNSmZlSlpY?=
 =?utf-8?B?akFSWURIaG05V29QUkJNNnVVQ0thTENob0JaeWd0MDZhN1c2NlZ3aGhTK0VL?=
 =?utf-8?B?OGxSZG1FSzdYOWx0cWVQZVo5eGZvTEl3VTNKSWp2M0k0UEpkekhQSVg3dnpI?=
 =?utf-8?B?bDlZbTFnYzM2QldTcHNUamJ2TkYwVEN6NkNPNXYxZHlnVXRLL0M5RnVMTyt1?=
 =?utf-8?B?VW5xOWdEb0szazU1MFkrZXNYVXJxbmdLL1JYUmZZMzZReGo4MnZYR2NVNnVZ?=
 =?utf-8?B?ZjRvREN2UVRnTVU2WFZZdkx2RitWdWszaU9rTExsTEVCRXpKa3BnZG1CdTBm?=
 =?utf-8?B?LzlxSWk4UUNKSThyaVo3K01JSkd0dktyRGpRZW5MUWhPYmZGdFR3aVZ0MGV6?=
 =?utf-8?B?bXM5V0pvNFBNV1RVNkxEWE1IazFYSDNYemhxZEgyVnJ4aG1PSmtQamY5bWpI?=
 =?utf-8?B?ZmNPallIY1UyTlRuMmUyZXVEOGpLRjY2STNPZVJMbUV4ZzJXMkZOczZubVRn?=
 =?utf-8?B?RjZqaWJIdnNZSDhTRTNKZyswYU81U2NTSXU4UjdwbVgzNkdoY0d6d0JISmJs?=
 =?utf-8?B?OFZUOGlSandCNk4zQUkzcTlrb3dTbjMrNHVsckgyRHNTR0pUbFdyWE5BY2JI?=
 =?utf-8?B?c0E4ZXA0dm9sNllpTDF3ZUU1LzZ0dVE4dzFxUUhiYnZuN2hOcXN1aVVpS0Rl?=
 =?utf-8?B?U1RpWHFBYlRJdFpDTTdHMFlySUlRTVFpZUxGaDFzNVZ4b3ZheUJKMFFIVytv?=
 =?utf-8?B?alk0YjdYeDZGVGZTVDdKRnMxSE4zcGJQU3BENHdXV093NjlZSG5JRjZ5SFJz?=
 =?utf-8?B?TVdnb2pqejU1K0tKejhiQTVYcDVyNlYyQ0tTNEUyTjYzcWFkdzZMYTBRbTZC?=
 =?utf-8?B?cXZzMVFJTC9Zb0xRQ2JTOUJDclNJQlBONktvMlI3NDNZR3VLYzVKMTdML1FR?=
 =?utf-8?B?T2tITUhRNlFud3RkSU1JVy96YjdTelZNUEZITXdlTmRzVXJJamYwT0MvWFRT?=
 =?utf-8?B?UVZZa1hKRVBXMklGWEtaWG5VTVJHcXZLeHRuZVF4TXZvd0pwRGZWd3VVL2tq?=
 =?utf-8?B?aG1mYXBmTWR6anMxTTBGZWZ2Rkp3WWlwMjRBSkpPQmptS3Z4b3NLV05WZU10?=
 =?utf-8?B?UDJXY0RXNFhXWjhNczlvZHdITUZ5a2Q1RUhWaHlkY3lTRWlETENyTmpnNk1N?=
 =?utf-8?B?TmpOa0JOc1lzYTFJZFl2M2RzUUZhUXZKVnFEaEd1S1hwVUlIQXVpRXNKZTJ3?=
 =?utf-8?B?emhZNXFnMlF1eTJwRkl3bTloTmN4U2lZVkw2UnhGWDFNeE1EVm0zTlhJRWRJ?=
 =?utf-8?B?dHpGVlF0RStPaENGd3dBZnRWc2djY3JGSUxKczYwUWl3WmJvcHU4RGtwOEFj?=
 =?utf-8?B?UHhSWUY0Yy9iWUhxQjU2RkhYaXhyK1Y1YWRNa0FOY0ZGL1ZxQXYrWEoyZmgy?=
 =?utf-8?B?MTFjejBha2ZjTkpZVDZLcTdoNWE3dUg2cWVKZUtGK0ltSXdUQm9memJsMjZq?=
 =?utf-8?B?UFZ5WEJPQi9zbS8rRXNwZktwcGhvMkNnYTEvd1hsSlA2cHNBeGdYYlhmL1hs?=
 =?utf-8?B?M2I3Ym9KRjdCZXVydk90cU05YVY5cWw5ZzZRSDRTbzZqU2RVVzJ0MmJEamxV?=
 =?utf-8?B?SUJKdEh6SmhVeWtYSCt3VkFwT2hlYjJTMm5VZW9EVU5OYjRkU0FzRzRGRDZY?=
 =?utf-8?B?bjEwNHJOc2R0citkT2ZWUXhGOHR1Ri9INC9PSW1CQ2ZZNlN2a3ZWQkk3bEhR?=
 =?utf-8?B?aGJCa2RCSHJZQlJiTHFPajczekY1N0NJeitZS0FmQlk3azJ2Z2VHT1RUbXo3?=
 =?utf-8?B?S2FhcVRJK1lCU0lOSlFYbVBNTTRONmtreG56dFFGNGtpdThsM1FZSTlncGFo?=
 =?utf-8?B?YkRvektvaFpNb0dMbHpZYkdGUHIyZGlSN2U5YVZsNnJ4a29kbnlYbkhZRmJs?=
 =?utf-8?B?bmUvb3RJWkxEMlZFM3Q3cVA1RUVtcjc2RkVwcmpCa0VuTjNQbzhlVEtpSUxL?=
 =?utf-8?B?a293NjE5K21icnpsbEJTekF3Y0FVWGI4WjJoVUV3elJ6WXBsVU9UT2w1cGR6?=
 =?utf-8?B?SHpteVJXODRCZ1QvUHFxeGZGdkRFclZFTlU1WGNQSU80dGdXL09TQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0b233e-b1ba-41dc-f1eb-08de54c6ca9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 06:16:31.2454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLASVr42OmdMDixTZBhBqFPo/01Lclf+5tbLd83nHca1vNbgFomJnx6h/Cngp64Q8f8JBnkyQIodj6n0eoE29A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6041
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgSmFudWFyeSAxNSwgMjAyNiA5OjI4IFBNDQo+IA0KPiBPbiBUaHUsIEphbiAxNSwgMjAyNiBh
dCAwNTo0NDowOEFNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gDQo+ID4gb3IgaW4gU2Ft
aXVsbGFoJ3MgY2FzZSB0aGUgb2xkL25ldyBkb21haW5zIGFsd2F5cyBjb250YWlucyB0aGUNCj4g
PiBzYW1lIG1hcHBpbmdzLCBzbyBubyBjb3JydXB0aW9uIHdvdWxkIGV2ZXIgb2NjdXIsIGJ1dCB0
aGF0J2QgYmUNCj4gPiBhIHZlcnkgS0hPIHNwZWNpZmljIGFzc3VtcHRpb24uIPCfmIoNCj4gDQo+
IFRoZSB0aGluZyB3aXRpaCBLSE8gaXMgd2UgZG9uJ3QgYWN0dWFsbHkga25vdyB0aGlzIGlzIHRy
dWUuIFdlIGhvcGUgaXQNCj4gaXMgdHJ1ZSwgYnV0IHVsdGltYXRlbHkgdXNlcnNwYWNlIGlzIHJl
c3BvbnNpYmxlIHRvIGRvIGl0LCBhbmQgdGhlDQo+IGtlcm5lbCBkb2Vzbid0IGNoZWNrIGl0Lg0K
DQpNYWtlIHNlbnNlLg0KDQpUaGVuIHRoZSBvcHRpb24gaGF2aW5nIHRoZSBuZXcgZG9tYWluIGFk
b3B0IHRoZSBvcmlnaW5hbCBJRCBjb3VsZCBub3QNCndvcmsgZWl0aGVyLiBXZSBjYW5ub3QgaGF2
ZSBvbmUgRElEIHRhZ2dpbmcgdHdvIGRvbWFpbnMgd2hpY2ggbWF5DQpjb250YWluIGRpZmZlcmVu
dCBtYXBwaW5ncy4NCg0KPiANCj4gVGhpcyBpcyB3aHkgdGhlIGhpdGxlc3MgdXBkYXRlIGluIGFu
IGFwcGVhbGluZyBzb2x1dGlvbiBiZWNhdXNlIGl0DQo+IG1lYW5zIHdlIGRvbid0IG5lZWQgdG8g
ZGVhbCB3aXRoIHRyeWluZyB0byBhZG9wdCBhbiBlbnRpcmUgcGFnZSB0YWJsZQ0KPiBwcmVwYXJl
ZCBieSBhbm90aGVyIGtlcm5lbCBhbmQgZW5zdXJpbmcgdGhpcyBrZXJuZWwgaGFzIElPQVMgYXJl
YXMNCj4gdGhhdCBmdWxseSBjb3ZlciBhbmQgZXhhY3RseSBtYXRjaCB3aGF0IGlzIGluIHRoZSB0
YWJsZS4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgdG8gZG8gdGhlIGV4dHJhIERJRCB3aWxsIHJlcXVp
cmUgYSBjb21wbGV4IGludmFsaWRhdGlvbg0KPiBzZXF1ZW5jZSB0byBob29rIG11bHRpcGxlIERJ
RHMgaW50byB0aGUgc2FtZSBkb21haW4NCj4gc2ltdWx0YW5lb3VzbHkuLiBOaWNvbGluIGlzIHdv
cmtpbmcgb24gdGhpcyBmb3IgQVJNIGFuZCBJIHRoaW5rDQo+IEludGVsJ3MgbGlua2VkIGxpc3Qg
c2NoZW1lIGNvdWxkIGJlIHRhc2tlZCB0byBkbyBpdCB0b28uLg0KPiANCg0KeWVzDQo=
