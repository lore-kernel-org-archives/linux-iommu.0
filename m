Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952F1624C5
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838190; cv=fail; b=Ob5er7tmJTTgBS5DqAwm9z1cAx3oQfNXw+kCyUPDHDMPaO6B5/3JhXWoW28fYo+O9e5wP+BvxUsliYPQZrgkFhei1Uky7k8OLy31DSLctdbmydKgaVemev+tXiQlJgQioGagTtfGHJN6yOk54pcYPiQ9Gu3brsmADL+W9pze0p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838190; c=relaxed/simple;
	bh=oZ0QdCNAyUScBwyE5qHPyxJOFeLcxwkFZN6LaXzDI28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oLc0xv2mD7VgI/6bIsftpuY+Zw5vuFkX3THjk8g7QVVOUayYPGj5S1SJLCUcq+ghaXQCgzsW4Jo/s7fenr+FPj5nhYHo615crqWvplkzaXmXJ+i5xzZNpeFr7+OaSSf5g6EQ5xYpE7V5PStIqLzcGU30LUOXWcK4/w57c26eLQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3eCKZ5P; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3eCKZ5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767838189; x=1799374189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oZ0QdCNAyUScBwyE5qHPyxJOFeLcxwkFZN6LaXzDI28=;
  b=L3eCKZ5PPSt/sB6KUEFeAVmzZEMHvqe0B4X+jYlu+jxkqFqq6kTTS1bK
   zVEoViCB1AGBB6qB3u2MSK62FE1JKxmlPfaSUSaVu385YfvSLGpo42Kbx
   50TRLR9w1qhj0F6dWJLNZNnTQ/U9hdmvJbG6vJBQicsw7Pw2PSvYof45P
   jKFOY3ZdLkkKz/j8OcMzK56hxt0jVfcys7v6yQeen+4pzduOZAndU225z
   KLa5eGGzkq+D3hW9OV+cAzGr99J5mHfkHuL7uKZjBGKijgSbR1qPz1NG1
   KuUkZCJki532eADfkQBTKu0vU5TmIyLNpuNG21iEORFwLQ9eNm6V/qlMy
   Q==;
X-CSE-ConnectionGUID: LfKmajqkSe6lQqNIqFvQog==
X-CSE-MsgGUID: CYOrxUslSY2GVBe4QWwqdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69262412"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69262412"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 18:09:42 -0800
X-CSE-ConnectionGUID: Mpp1T3c3SmyHsLYAPh1g2A==
X-CSE-MsgGUID: ulSgMO0HSDCUhaqJD6Anqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207559329"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 18:09:41 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 18:09:40 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 18:09:40 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 18:09:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sF2jYRbFfeedwSe7PhXpsL6RmwwW0ew9JAoc3qQnPW+UIb7jJN9tQGSts2SR+MmsCL7QRraFBRjF7aJ9m9iAMl5bD2pWmQzuwPk6F0SmHPL2AXENbCLcAVqU37WG6viOak9tL4JZ8BAPX9JTtdQjFXauQjbCrQnoNJqSYCnkLZWph0RIiVP7FNTcFqzWlK552MWGpFM8BT9Ha5+OFyAv3lf+hKDCs88iDZ98cKqCIhHoJHxoKj0ieAexkCWJR5vkE8sm1MNZHBN/iBtdQw0Crs/MNgEY+QRE4dWlJ/g8IPMjcnysVW8KURBhUkffqfwvHkGDNtL6d+a1+Clu+fBZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ0QdCNAyUScBwyE5qHPyxJOFeLcxwkFZN6LaXzDI28=;
 b=o1LvtAOr+NhBm2caPfFYvJHKbAgRS4sIbibBJoL6q+m/PIdOMWwGj7oCklzE4k+DZIcZZ5w+QCsggz3IY/Op841dLtuU5JorkLYCeUajlt5FztzFvI0V4x1OjG3JJPWJ1nOyC0gaANd7Nt3QHBa8FRWnnflU9t/J9r29Upb0nHoCLJeFhp/6ACXQDXXhV01fTYcTMIxorHZII0y2WzfxXyLaRaBL6OlnjRIo3UVx7A3lHiWcZarpJcV8f73NwBB1cMKUymXghZIQN4l+LYygWQp3EYZpbuyBKoHw0t4No2Vqbd3BewGupLtrI0HxrTJTz8Y+Go6I9McF28T63vmMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7620.namprd11.prod.outlook.com (2603:10b6:a03:4d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 02:09:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 02:09:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Dmytro Maluka <dmaluka@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Vineeth Pillai (Google)"
	<vineeth@bitbyteword.org>, Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>, "Dong, Chuanxiao"
	<chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Thread-Topic: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Thread-Index: AQHcd1pONBzWAyEdQUC7AlJ00GGhhbVD7t0AgAAL+4CAAAVkAIAADl4AgABFfQCAAORcAIAACMWAgAAYWoCAAjOC8A==
Date: Thu, 8 Jan 2026 02:09:37 +0000
Message-ID: <BN9PR11MB52764C6A9F1774DDAFED41258C85A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca> <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca> <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca> <aV0TalseaDGW-1Jp@mitya-t14-2025>
 <20260106142301.GS125261@ziepe.ca> <aV0vM9ad-4QhCNaA@mitya-t14-2025>
In-Reply-To: <aV0vM9ad-4QhCNaA@mitya-t14-2025>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7620:EE_
x-ms-office365-filtering-correlation-id: c1f8487c-7d66-406d-3143-08de4e5af9ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?a1ozTUZHWkk1L2p2Nm9GTW5tVXhiWnVLbTZDWEdvRnhMUGFSbHRUVHkyN3E2?=
 =?utf-8?B?S0xJWk15aUV0TGxSRzBnM0tyMWpLZk8rUHdYa0U3MWFtWW5DcjRQYlo5MUEx?=
 =?utf-8?B?c2tVQWhRb0hjQmVjOFN2YkFBdmMzWk9QQnBHMGNnU1VjSEZPM0kzKzhWNXQx?=
 =?utf-8?B?SzZqcHZGRkRUc01IcWdwNjlyaHVyRktrMHVMVnVTNzNOTmU2NURJbDczRmxw?=
 =?utf-8?B?YS92V2NUSWxFLzNlL0szUnJKYi8yL2Y4STVybFdmbC8xamdUVGg2UlFKejlr?=
 =?utf-8?B?QWlSOEhhN0psOTFVVGdUNTN3OCtWbjlrWi9nVGxjOTRqV3Y5TU9CanNxQkJl?=
 =?utf-8?B?QXpMK2pybGMraTh0UUNwTVllay9CN0lyWnZWZjRuSUMzVDhwaUl4SG5yQWxw?=
 =?utf-8?B?OEJZeVB6V2Fkb2s1bWdaRVlCNnpvWlFFdDdERjUyc2Fkc1BySkxvaVJNUE9R?=
 =?utf-8?B?dUk4L0R5ZG0wT0J1TGJCVkdONFRpWjZ2cm91ekd5U1djR0I1Qy9iYnBxZWpK?=
 =?utf-8?B?M1hMaDZBTW5vblhiSldSN3ljQUp0RTZidnRJamFHTEMxcXRNMlp6T1luS0R2?=
 =?utf-8?B?ZmVOZGdDUFhUaEJCYU9QTTVoZmYydDhhUUVxalZNenFNZURFbjZJcVpWNGtr?=
 =?utf-8?B?YWtET2Q1RDBXWnhzWEI0RFd0NFF6WG5zcHhXODlTVXc0SG9jZUxxZTdRRWpR?=
 =?utf-8?B?ZytiN0U5anAydG4wenp3cDdoQ3VQdDNTbnFyVU1yLzIyUTIxMmlGdlg4ZlFw?=
 =?utf-8?B?OUw3RlR5Y09neVU2NHFwUFBFanhFN0FhQkRkM0sxWTZMb1diWU11cUxjRUVY?=
 =?utf-8?B?ZTk1a0UxUDFxdmtKaUZDcjBQNU4xZ3lERVRRY3JHSnc5L3pVb1A1OTVzVXJk?=
 =?utf-8?B?ekk3b01rTVlUcjZOazFNOVhjdzR0dEdnSlFhYUdkd3JXQUdUd24rWGZtV0Fu?=
 =?utf-8?B?R1VRQ2E5QjEvRmJoaUduZWZZWWxPZUo0OGV3ZGVxN0k5WVBjdXFDRGRmSk04?=
 =?utf-8?B?QUVhZDVNdXBMMHFQckdPTnovelZ6TXR5SENyYWRFUWRBRk52ZXlyWnlRbmhZ?=
 =?utf-8?B?VjBHcWVQWWh2T1c4R0xHMlBHS1pvRDRFSU1oSW4xWFlYM2M0eHNMcmJNclZU?=
 =?utf-8?B?ZlR5V0ZjK1FFVGdxeXZ4ZmpWTGxPak1qQXk1SGpoN3B4aVc0QmhHcVJyYmM0?=
 =?utf-8?B?RklrQVBiQWFwek01cnBhZGJjOWhKK09nNWpJRytEWUxMT2FSYS9SY1NZdzJE?=
 =?utf-8?B?Q3NnaEJpbXUyQnRGcVFYMGZqT0dTZnpNQkMzRU1MeWt2enN0N1NMY3NGZHpt?=
 =?utf-8?B?SEZueVdVVXRkdHlJNlMyMFJwUjRneTlrL2ZtQkVtSDhxNnpkcGJmaFphS1VC?=
 =?utf-8?B?d0g4NlV3amNJbGFlRGIxcVplMTJyTmFHWFZUSjIyNExoSVQxYlh1OWtNK2xq?=
 =?utf-8?B?c0RKaUpSL0tpVEdpZERmT1hYYnFEVXFxMUlwUzZ4QXR3RVB2QTc3cXI4Y3JW?=
 =?utf-8?B?TjQxMmNobzFhYXErT2pIb21XbUdmenJrbm9lS0VwL0JtdTlHNEJGWG9LaFRQ?=
 =?utf-8?B?VUdLSHRiUm5uMUZFMHN2Q2lGTkJVbEVuMC9xcUNDMXhweTl5UjcyMmxUNnVG?=
 =?utf-8?B?dDJhbWEwNGdHN28yY0hzaWVLMnhtbUdtUitxYzIyZ3p2SlJDSml2b0lWSmpY?=
 =?utf-8?B?Q2dJVE5hdG10c1IzdkVhNFM4NjlVVVRJZVBKZS9IK3NDR2xtdmRHNE41RXFv?=
 =?utf-8?B?dENWOWd2c0p4ZUFvbjhkSjVydHFHdTNXaTE4bVBaRXRCcDNjMFVscW1lT1Fp?=
 =?utf-8?B?aTBuZWJ4cm5qcTFUU1ljZkYwdGhwQTZ2NW4xWS9vN2kvZTE1V3RiUFVuclhD?=
 =?utf-8?B?N0JlQTRUSXpDeDRhU0tFSXJYTWJqdWRJM3pyekVFWkhZdEQ3ajBoUGtjQ0gy?=
 =?utf-8?B?TWRjL2ZTYVd5bkVaWmFUT3BEb3hrdldaM29VbXlqYXd3UEZRN3N2RWVGN1k3?=
 =?utf-8?B?Y09Ybm41S1Z5aWtNcEMxbWp1cFY0SU03a0V0aDJyaTRIVkRzZWplSThYZG4x?=
 =?utf-8?Q?6cishT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEs2UU9GTlUxdUUyZTVXUERwK2dNUnppQjlWYllNU2FDQ1dDSHdMUkdnc05i?=
 =?utf-8?B?bENpV25OYmhhZ0NDQ2N4VUVXZTFqU0VuSHZrUHFrcW9pbVErSTh2Q2theWJy?=
 =?utf-8?B?NmdITW1YTDJuRjNsRE5UeWYzdElSZ2E4YkxIWWp0ZTFmM2hMT1RmRks5Z1RT?=
 =?utf-8?B?WEVXUVU4eE5PTE1aL2hHK3A3Qm82WWkxUmtWUnNpUDBIRWl5OTZ2T09FTFBH?=
 =?utf-8?B?MzRkZ1M1R3E5L2t6UTVjdnZLQnpCdmlPa21rbktwMmtPY0MvRW56eW9mQ2dL?=
 =?utf-8?B?Tzg5K0RqSmZJZTVsc05DbENuR05YMW5OUVlXVFh4T2hCQldpQkF2K294MSsx?=
 =?utf-8?B?NkQvek5TZ2M0RDJrTXpOZVpMVzFhdUlXYjMrY0ZrT0l2Z3VMZVBRUFU5SlZC?=
 =?utf-8?B?UHp6NEJhS3RPeUsvVzMzMFZVZjBEUHcyZTlpb3hxTTlTSDFjajAyZUZWbUtK?=
 =?utf-8?B?R0NCL2hYSlIrTGE2aWtpeWZoeng4Z2ZRS3MyTHEyWjE0VjlwNEE5SS8vb2Ft?=
 =?utf-8?B?QjFsQmpsZ0JtZHFpcDhsTHVudVB2bHZPV3hEUlpqTjhpSk9wSTZ4dHE1WW9z?=
 =?utf-8?B?TW9hOFdPN2JrQUhIdUJWVy81T2FaZVo1U21CMVI3ZG5XL2MvbGVTcnlsL1VK?=
 =?utf-8?B?ZEJ4NnZlRTRBb1lmaUxaUmVibVd1ZjAvelFDN05JRXVhRDE2aTVxdkl1dkJI?=
 =?utf-8?B?V0JYUlplUkRyMVE1a3BBcFEvWjkvRU1xbGQ4RytRTUxQQm9IMTZrYzc1NXlS?=
 =?utf-8?B?czdNYlZVV1pGaVZveFE2QlhrK1EvZ3haVENwNGRDY0taWkZiS1N3QTN4b3pR?=
 =?utf-8?B?cFMydk8zUTVzZWc2c0p3Mzc2L21wVUNYdzdZdmttVmJJMW5wSDNCNE9IVlp5?=
 =?utf-8?B?V2dnbUpIWjV3SHkzWUlYdDJNRFJMMEpBbVhBSlFIUVRyNEh0U2NSL0tUdXRD?=
 =?utf-8?B?V0o2ejVNSGRpM0hSY1c1bVdRdEtvdDRhNllLQ2tCcTBTUi9rN1NXcmF5L2xF?=
 =?utf-8?B?UGgzKy9lM25Ga0JvSlQ3OWJwekwzS3lPazBsKzRLK1NRUzRNaTJaYWhQZy93?=
 =?utf-8?B?eTNZa21COTdtNG9yTFpCVm45cHZkR21CZ051bzZzMUVkMUVEY2dlQm5kWjc0?=
 =?utf-8?B?dzNIZmZCQStFd0xQVURCbmNUaTJnV1J5N0dhb3ZYQTk3cnRBUDdtdUNKQk9x?=
 =?utf-8?B?QkVoVFgvWHJvT3Fwc0tITGg1eWdYYk40SHJuN0dlYi9TcDJwVXFoYVRTcDlC?=
 =?utf-8?B?SnFaSFNIK0ZneGxvVUhYY3VhOFRvMlltUUlvZ1VCd0pvdnBqazFJTjFnWW9Q?=
 =?utf-8?B?USsvNENZeEN1dm80UjJUV3ZaZldUQ3g4L2sxQndCa1krK1hSbldFZWcrQ3Zk?=
 =?utf-8?B?RWY4ZXMrRXhDLzNTd2s5dUhWZDErUVBLVmVET0hGOEJHemY3bUR2ajdpUE9V?=
 =?utf-8?B?UGdHbzd3ZG53UGlhai9Vb2UvRGMwaWpENWJYL3NHUXIzYkhoQnJKMXpNNUd3?=
 =?utf-8?B?WVpoY2YrdFBoMDFYdDdMcCtyU21CQWszMXUva0srN1htVmd4TkJuWGdNYW1y?=
 =?utf-8?B?dDYvbTJaQkZGclBGRlBwNWtSNXpaS2dvUkNxUTBaM01GVEIrMG9hZlkzTC9z?=
 =?utf-8?B?cHBmWnVXcm5iWThwT1hNWDhPTUlOeFhkNWkvc28vRTVEaUxIL1VYNXVjMHF3?=
 =?utf-8?B?ZWY3akNPdFdOYWordTcvajVJb2dGRjN3YzVjNkU4Z3F4VS8weTRPeEZGNi9H?=
 =?utf-8?B?WVN5OENDQ0x5QlVnUkVYcVBUWE9GZXE4TTBJck9OdEx5Uzg3bTRLNVdkZ0FV?=
 =?utf-8?B?T1VqZWE2S0Uva2JZckU5WjM0TTVDZi9mM0l0bGxCYUJPM2F4NFFRNTkzVnh4?=
 =?utf-8?B?dnlCVFFoaEIvdGVCNUJNM1V6emtMMVU2c0lnMG5rRDY4ZkRuUjJJNjBEYkpY?=
 =?utf-8?B?K2VRZ2RHK3pjREVubXo5ZkU0QnUvaDRCd0J5cWptUWRRY0xybjQ1UElPUUkr?=
 =?utf-8?B?NFBlTm1wSEM0QzVLYnZQQy9STmdHUzFPRGRQTk40dFJrOUtPOWo5Q3RyWGxT?=
 =?utf-8?B?YTk2WlE4anhpSUZTMTdmUm8zYURmS0VkVDVjVzJXRXJlZ3pQWkNud09BTFJ3?=
 =?utf-8?B?VUlzNGFuL25qMG94RTV2SExWSkc4OHpzM0VzVGluV05FM0xVUVhlNDBwakRS?=
 =?utf-8?B?T1J3SURjWnJUa2JtcmtVV0Exa3FyWk1UanpyUUZhNjlQdkl5enF2cGlMUll6?=
 =?utf-8?B?ZGNxc3Y4TWY0NWVmUDhvVVpuWHQxWjVOYjNha3MrTFpCOWpWVnBvdDUzbThu?=
 =?utf-8?B?Q1ZPUHhLWDBtcHdJN0tpbWFPYnRhN2ZBTFduRXZTRmd2bnZkY1Vhdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f8487c-7d66-406d-3143-08de4e5af9ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 02:09:37.7832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/YFkElsSsMzE6VHQic85NnwwTxuiczpIGeYRWdRa0VfOAP8AmUnOiaa/Z0vCuRjXTWclDfKUAApaUqcWle4+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7620
X-OriginatorOrg: intel.com

PiBGcm9tOiBEbXl0cm8gTWFsdWthIDxkbWFsdWthQGNocm9taXVtLm9yZz4NCj4gU2VudDogVHVl
c2RheSwgSmFudWFyeSA2LCAyMDI2IDExOjUwIFBNDQo+IA0KPiBPbiBUdWUsIEphbiAwNiwgMjAy
NiBhdCAxMDoyMzowMUFNIC0wNDAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVHVl
LCBKYW4gMDYsIDIwMjYgYXQgMDI6NTE6MzhQTSArMDEwMCwgRG15dHJvIE1hbHVrYSB3cm90ZToN
Cj4gPiA+IFJlZ2FyZGluZyBmbHVzaGluZyBjYWNoZXMgcmlnaHQgYWZ0ZXIgdGhhdCAtIHdoYXQg
Zm9yPyAoQlRXIHRoZSBJbnRlbA0KPiA+ID4gZHJpdmVyIGRvZXNuJ3QgZG8gdGhhdCBlaXRoZXIu
KSBJZiB3ZSBkb24ndCBkbyB0aGF0IGFuZCBhcyBhIHJlc3VsdCB0aGUNCj4gPiA+IEhXIGlzIHVz
aW5nIGFuIG9sZCBlbnRyeSBjYWNoZWQgYmVmb3JlIHdlIGNsZWFyZWQgdGhlIHByZXNlbnQgYml0
LCBpdA0KPiA+ID4gaXMgbm90IGFmZmVjdGVkIGJ5IG91ciBsYXRlciBtb2RpZmljYXRpb25zIGFu
eXdheS4NCj4gPg0KPiA+IFlvdSBkb24ndCBrbm93IHdoYXQgc3RhdGUgdGhlIEhXIGZldGNoZXIg
aXMgaW4uIFRoaXMga2luZCBvZiByYWNlIGlzIHBvc3NpYmxlOg0KPiA+DQo+ID4gICAgICBDUFUg
ICAgICAgICAgICAgICAgIEZFVENIRVINCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZWFk
IHByZXNlbnQgPSAxDQo+ID4gICAgIHByZXNlbnQgPSAwDQo+ID4gICAgIG1hbmdsZSBxd29yZCAx
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmVhZCBxd29yZCAxDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgPCBmYWlsIC0gSFcgc2VlcyBhIGNvcnJ1cHRlZCBlbnRyeSA+DQo+ID4N
Cj4gPiBUaGUgZmx1c2ggaXMgbm90IGp1c3QgYSBmbHVzaCBidXQgYSBiYXJyaWVyIHRvIHN5bmNo
cm9uaXplIHdpdGggdGhlIEhXDQo+ID4gdGhhdCBpdCBpcyBkb25lIGFsbCBmZXRjaGVzIHRoYXQg
bWF5IGhhdmUgYmVlbiBkZXBlbmRlbnQgb24gc2VlaW5nDQo+ID4gcHJlc2VudCA9IDEuDQo+ID4N
Cj4gPiBTbyBtaXNzaW5nIGEgZmx1c2ggYWZ0ZXIgY2xlYXJpbmcgcHJlc2VudCBpcyBwb3NzaWJs
eSBhIGJ1ZyB0b2RheSAtIEkNCj4gPiBkb24ndCByZW1lbWJlciB3aGF0IGd1YXJlbnRlZWQgdGhl
IGF0b21pYyBzaXplIGlzIGZvciBJbnRlbCBJT01NVQ0KPiA+IHRob3VnaCwgaWYgdGhlIGF0b21p
YyBzaXplIGlzIHRoZSB3aG9sZSBlbnRyeSBpdCBpcyBPSyBzaW5jZSB0aGVyZSBpcw0KPiA+IG9u
bHkgb25lIGZldGNoZXIgcmVhZC4gVGhvdWdoIEFNRCBpcyAxMjggYml0cyBhbmQgQVJNIGlzIDY0
IGJpdHMuDQo+IA0KPiBJbmRlZWQsIG1heSBiZSBhIGJ1Zy4uLiBJbiB0aGUgVlQtZCBzcGVjIEkg
ZG9uJ3QgaW1tZWRpYXRlbHkgc2VlIGENCj4gZ3VhcmFudGVlIHRoYXQgY29udGV4dCBhbmQgUEFT
SUQgZW50cmllcyBhcmUgZmV0Y2hlZCBhdG9taWNhbGx5LiAoQW5kDQo+IGZvciBQQVNJRCBlbnRy
aWVzLCB3aGljaCBhcmUgNTEyIGJpdHMsIHRoYXQgc2VlbXMgcGFydGljdWxhcmx5DQo+IHVubGlr
ZWx5LikNCj4gDQoNCjUxMmJpdHMgYXRvbWljaXR5IGlzIHBvc3NpYmxlLCBidXQgbm90IG9uIHRo
ZSBQQVNJRCBlbnRyeS4NCg0KVlQtZCBzcGVjLCBoZWFkIG9mIHNlY3Rpb24gOSAoVHJhbnNsYXRp
b24gU3RydWN0dXJlIEZvcm1hdHMpOg0KDQoiDQpUaGlzIGNoYXB0ZXIgZGVzY3JpYmVzIHRoZSBt
ZW1vcnktcmVzaWRlbnQgc3RydWN0dXJlcyBmb3IgRE1BIGFuZA0KaW50ZXJydXB0IHJlbWFwcGlu
Zy4gSGFyZHdhcmUgbXVzdCBhY2Nlc3Mgc3RydWN0dXJlIGVudHJpZXMgdGhhdA0KYXJlIDY0LWJp
dCBvciAxMjgtYml0IGF0b21pY2FsbHkuIEhhcmR3YXJlIG11c3QgdXBkYXRlIGEgNTEyLWJpdA0K
UG9zdGVkIEludGVycnVwdCBEZXNjcmlwdG9yIChzZWUgU2VjdGlvbiA5LjExIGZvciBkZXRhaWxz
KSBhdG9taWNhbGx5Lg0KT3RoZXIgdGhhbiB0aGUgUG9zdGVkIEludGVycnVwdCBEZXNjcmlwdG9y
IChQSUQpLCBoYXJkd2FyZSBpcyBhbGxvd2VkIA0KdG8gYnJlYWsgYWNjZXNzIHRvIGxhcmdlciB0
aGFuIDEyOC1iaXQgZW50cmllcyBpbnRvIG11bHRpcGxlIGFsaWduZWQNCjEyOC1iaXQgYWNjZXNz
ZXMuDQoiDQoNCnJvb3QgZW50cnksIHNjYWxhYmxlIHJvb3QgZW50cnksIGNvbnRleHQgZW50cnkg
YW5kIElSVEUgYXJlIDEyOGJpdHMNCnNvIHRoZXkgYXJlIE9LLg0KDQpzY2FsYWJsZSBjb250ZXh0
IGVudHJ5IGFyZSAyNTZiaXRzIGJ1dCBvbmx5IHRoZSBsb3dlciAxMjhiaXRzIGFyZQ0KZGVmaW5l
ZCBzbyBpdCdzIE9LIGZvciBub3cuDQoNCnNjYWxhYmxlIFBBU0lEIGRpcmVjdG9yeSBlbnRyeSBp
cyA2NGJpdHMuIG9rLg0KDQpwb3N0ZWQgaW50ZXJydXB0IGRlc2NyaXB0b3IgaXMgNTEyYml0cyB3
aXRoIGF0b21pY2l0eSBndWFyYW50ZWVkLg0KDQpidXQgd2UgZG8gaGF2ZSBwcm9ibGVtIG9uIHNj
YWxhYmxlIHBhc2lkIGVudHJ5IHdoaWNoIGlzIDUxMmJpdHMuDQogIC0gYml0cyBiZXlvbmQgMTkx
IGFyZSBmb3IgZnV0dXJlIGhhcmR3YXJlLCBub3QgYSBwcm9ibGVtIG5vdw0KICAtIGJpdHMgMTI4
LTE5MSBhcmUgZm9yIDFzdC1zdGFnZQ0KICAtIGJpdHMgMC0xMjcgbWFuYWdlcyBzdGFnZSBzZWxl
Y3Rpb24sIDJuZC1zdGFnZSwgYW5kIHNvbWUgMXN0LXN0YWdlDQoNCnNvIGluIHRoZW9yeSAxc3Qt
c3RhZ2UgYW5kIG5lc3RpbmcgYXJlIGFmZmVjdGVkIGJ5IHRoaXMgYnVnLg0KDQpJbiByZWFsaXR5
Og0KICAtIGlvbW11IGRyaXZlciBzaG91bGRuJ3QgcmVjZWl2ZSBhbiBhdHRhY2ggcmVxdWVzdCBv
biBhbiBpbi11c2UgcGFzaWQNCiAgICBlbnRyeSwgc28gdGhlIGNhY2hlIHNob3VsZCByZW1haW4g
Y2xlYXJlZCAoZWl0aGVyIGF0IGluaXRpYWwgc3RhdGUgb3INCiAgICBmbHVzaGVkIGJ5IHByZXZp
b3VzIHRlYXJkb3duKSB0aGVuIGh3IHdvbid0IHVzZSBhIHBhcnRpYWwgMXN0LXN0YWdlDQogICAg
Y29uZmlnIGFmdGVyIHNlZWluZyB0aGUgZW50cnkgYXMgbm9uLXByZXNlbnQuDQoNCiAgLSByZXBs
YWNlIGlzIGFscmVhZHkgYnJva2VuLCBhcyB0aGUgZW50cnkgc2hvdWxkIG5vdCBiZSBjbGVhcmVk
IGluIHRoZQ0KICAgIDFzdCBwbGFjZSB0aGVuIHRoaXMgYnVnIHdpbGwgYmUgZml4ZWQgd2hlbiBy
ZXBsYWNlIGlzIHJld29ya2VkLg0KDQpJZiBubyBvdmVyc2lnaHQgKEJhb2x1PyksIHByb2JhYmx5
IHdlIGRvbid0IG5lZWQgdG8gZml4IGl0IHN0cmljdGx5IGZvbGxvd2luZw0KSmFzb24ncyBwc2V1
ZG8gbG9naWMgYXQgdGhpcyBwb2ludC4gSW5zdGVhZCwganVzdCByZW5hbWUgcGFzaWRfY2xlYXJf
ZW50cnkoKQ0KdG8gcGFzaWRfY2xlYXJfZW50cnlfbm9fZmx1c2goKSBmb3Igbm93ICh3aXRoIHNv
bWUgY29tbWVudCB0byBjbGFyaWZ5DQp0aGUgZXhwZWN0YXRpb24pLCBhbmQgcmV3b3JrIHRoZSBy
ZXBsYWNlIHBhdGggaW4gcGFyYWxsZWwuDQoNCldlIG1heSBuZXZlciByZXF1aXJlIGEgcGFzaWRf
Y2xlYXJfZW50cnlfZmx1c2hfY2FjaGUoKSBvbmNlIGhpdGxlc3MNCnJlcGxhY2UgaXMgaW4gcGxh
Y2UuIPCfmIoNCg==
