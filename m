Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF642FF15B
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785128760; cv=fail; b=Vx+GB5azf+jMbBPjAlog7d80SX+YpuPdEZ9CHdeDfOlOMUcqRyitegBsqgxVS3UReZKcJObUGIOP7U6hHUN6+cS17Wo0x1K2bD902pO0FoESw1t0k+yyvQ1sLWrfOIJy3g6ZTcH+uq4mbF2rW1u4ywSQ8dbDTjuTuoRoQ32Zo64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785128760; c=relaxed/simple;
	bh=9ijdqQ5YNxEP9Mm/bgU14Gsh69tPxLDwXZJ+EprFDhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VHMATaQLJDwWg5OhvERiZHOxDOXhXnlqXrodnTXSsDyNJ4n4WCtPXRT/yWUDfvCimiD9QJh8uYgvXIhIc+C/KRptZevDc80uayhV80kuEUCtZwUvilRDqJFBBHKiv5VEIxp2N79pCDK0E2zo8hewhrWkV9AUXLwpmvWpTFgbkEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zn1tig5T; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zn1tig5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785128759; x=1816664759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9ijdqQ5YNxEP9Mm/bgU14Gsh69tPxLDwXZJ+EprFDhc=;
  b=Zn1tig5TBlBVAUATY517mRO02vCj1IjgVC91evzIeFiZ5MlrTlAp01tk
   HdsB0SXug8W8g4LkVwjg92bBxZPFLvdrGhmq3kLHAEnbQYuow68qCd9Yd
   jMCH39g/mbzZL3Lf/gZFgNr7Gvcuyz7etR49AbTvSwqQ+8uIggD7yh0MB
   hBOlJnyh1h6mowshdRGTjRlK+3CdJ72hx0oJdh0H4eOHa6ReUPF9Jo6Yv
   mKnlVOl9IOhLgtU2X0Krpf77Mt2idoFzEtQDUe9Adom4bgKPf7edis3gg
   Zp2dMw92gMmGa4CFMcltgIIogH5ZwhJNkUbGNoe+11i4Y/UptBGkFZrDa
   Q==;
X-CSE-ConnectionGUID: EEwuTrC7SiSHA0toN3V6aQ==
X-CSE-MsgGUID: oT7aK8lJQ/CmRMRSi5m/5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="96045603"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="96045603"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 22:05:58 -0700
X-CSE-ConnectionGUID: j69eIolQQbaGgcDkQhbdiA==
X-CSE-MsgGUID: dzo4i/H5QZmKfMtw7fnhSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="261268900"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 22:05:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 26 Jul 2026 22:05:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 26 Jul 2026 22:05:56 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 26 Jul 2026 22:05:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA+IM1U1fQ0W73ZCtCBVCnjGlDxLbXIx2KD2jjFnvjRJrNk6tMzimvSFGkVhKsyVB0Kuq/wu5EUImUpOa5DjOjdpZ4X655IAAl5ybkVGSoaXkLFa5C3+T8ZPgpQE2pAyU3gXMbTTP+bun4wFPqYBqDEojj91G4Bjd+HX3sT69dd9GLjZk212sU+zuSCpwu8zJGFsXYcIC3bPg6Eq6kL+1G+axZIq89Ot+cUUyooohbVPBZgUM67xeFnqW0UCTEbf82uluXTB722WOXMVmzr1atu4tXaSx3TQkHvMOKzopT0W7we/Xo71816b+PI0g92ysqnedCAExPYybiH84leDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ijdqQ5YNxEP9Mm/bgU14Gsh69tPxLDwXZJ+EprFDhc=;
 b=j5kUC6v+qm/tgUQ1e14AGMIbFMvpQKXNUfO4MtV17VdAIeJeDI8dAl4HoAb+2ohnJbUDxB/jDW+6Re0fO+S/CGM5kp85uRiL5HCyXsscAPV8iardJ0LPTNlJt+adp91fK+dx9AtI2oDRAUz0Bqvl3BiEcyo3iw+VONfs3VcnWT1qS3gjbWNcdo79gDTAuocAe2WfMGMcCxsDjgb+bUdKx47IVYFSj4IDXIwDxFdascf6iYHAVk5XZDwIbtSfsEIiYROfre0yEbqaluh3p0Y/dxWH42FMmjKGHpHsM6shmQYibdbE6y9zmpBH0c80BFfUqqyzGcwGW6AATXx303OJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DM3PPF607052E81.namprd11.prod.outlook.com (2603:10b6:f:fc00::f26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:05:54 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:05:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Oliver Lin <oliver@liuxiaozhen.dev>, Baolu Lu <baolu.lu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v3] iommu/vt-d: Disable IOMMU by default on Lenovo
 ThinkPad P50s
Thread-Topic: [PATCH v3] iommu/vt-d: Disable IOMMU by default on Lenovo
 ThinkPad P50s
Thread-Index: AQHdCs4JfDSehXNb9ECNVV4qDvRlYLZqv7AAgAAJBwCAFfBgEIAAH3QAgAAJ9pCAAA5QgIAABEPg
Date: Mon, 27 Jul 2026 05:05:53 +0000
Message-ID: <CO1PR11MB48350C58435D27F981DF83DF8CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com>
 <20260703092348.17583-1-oliver@liuxiaozhen.dev>
 <775d3d16-f43d-4a5f-9629-4912a4cabd91@linux.intel.com>
 <0c9256b0-19ad-4d1d-baea-0ccd3b827d0f@liuxiaozhen.dev>
 <CO1PR11MB48354FC225C295EFC745EEF48CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <19be3c19-9711-4cac-bc6e-c2b020588ec8@liuxiaozhen.dev>
 <CO1PR11MB4835CB1B5633DD1E4F1011428CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <7017b26c-7384-470c-bf8b-38b667c7d7cc@liuxiaozhen.dev>
In-Reply-To: <7017b26c-7384-470c-bf8b-38b667c7d7cc@liuxiaozhen.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DM3PPF607052E81:EE_
x-ms-office365-filtering-correlation-id: 611ae7fa-341f-4afe-b385-08deeb9cbc4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|10067099003|5023799004|11063799006|4143699003|3023799007|38070700021;
x-microsoft-antispam-message-info: d2NkL98JbHpXdB39IwmGYrNmVbF4xUY1TJnJiYa8MzUe6CN7ls6S1MK91wuoTJaNGYIxET3EMnRr5E1DmiKAO8H06Df9sIfvmu4iRIzA/L+PZX9pTHgWlaHQZ2qL2v69xcpsJNpMC6X0A4pzni4srgzLBLhG1vy0lH+F8DyFn0YJPsJ+HT0XuV8JH6ODuHOlmh75oCbdXijqQBhKYD52khFWWvxWZNRccSebua8wM6y2BQs8srI2oepsE01JV5KZltAWmGUKWp04RWB6hiHwLtT6KqIHWR8oAP3eKkutsLFTOmqatUxV4QgHJ1fPvPaPWI+3nsq0SFxsrIy3tbonJ890knF3F9usaB15fib1T3JAlQBv9CIbIopDDkWSLFDoUvyPzZ5Aowwn3y+DqA4U+ruK8jvD4XgWskEl9B3rwzgd6nxD4PtxfKuUOcHJ6rHj7D+c1g2ZajytqVMntAjMSg0OK0WAIU78ghZEcN1IfOMccakI9TWBvPmyTPwn4ivfQBWraYv1Go0P+sAurdtO96EnYPs0Zc5tr6orQ1WRB7I/gekHp+d7K6kCP+1XmG0aA5XbEfQOaywjlwvp8qo9taN8KH0DuJly6H9MeOfWRHKr1cMTVQ4XrdfPdvxfycDzat1z/v7cE1TtAu9wAOJFjWr/kIhEERKvjjWzmEjK9pWQIumAoOS4m7DS/OwRZ2EGTVA1QcFZMBII4+ttwf4PisXID4xv6nEVjvbBsW3nzIM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3RrbDRjQnVZeHVvTnVPbkdOY1VlUU9Tdzg2NHMzdXZMSEhuS0dUcTBVb3Nj?=
 =?utf-8?B?OUd3YWUvbGFJZUVLU29rQ200UGJtOHFUV1JRaXpmOUZ0azZvVVMrUS9HQzJz?=
 =?utf-8?B?Ym1Hb281d3hVRlE3czV0K3NSTUZuOXZKNko2WDhqeWhZb2J3ZEdVWmVHRk5P?=
 =?utf-8?B?M0lqVXV4WWRBcVJ3MjE4dEg3bHVEQmt4cGFtZmRDeG5BZWlHcjM1KzU0SzZ2?=
 =?utf-8?B?R2FNREJ0Q0VTZzBpNkh4ak5UVjB2S2Z4UzVCZXVFSzJlUCtFVm0vWEJtc0ho?=
 =?utf-8?B?MDFMd1BtMmpkUlBQV3dXcE5XN0tKbi9KRkVjMEptTE5vYUkvcTBBT2ZqZUtN?=
 =?utf-8?B?YkNKWVN6Y0p5ODhtRzF6S3JhVFJUM3pDU050eTFVOXNPVy8xcEFKUTJpRXE4?=
 =?utf-8?B?dE5GVjQrUUV6SWVEOFVaM0dEcHd0dWRUOFpoc29HTDRoQW9kQ1hEVTBFK0NI?=
 =?utf-8?B?OGhNWXpCVHZYQm1iYWVBKzZDazNEQS9VbkxxaVBnSkQzdHd6MTlkalBmbzBR?=
 =?utf-8?B?NHBPck5yYkF4bytnMEIzOFpNVnZFUkdTbG40S2F4TGFBaWc1ZnJFU0hnQjQ3?=
 =?utf-8?B?Z0RuRUREOFZyeUhHZ3NoQk0zSjJyY29RZlhWdjhqY3FwRVRzRXVjdm5YY0Zt?=
 =?utf-8?B?Z0psK2Q3Y1NiaXBGamdhSTBxd3M3ODhWNmFYcmVOZjhhOGFhYlN6RDM5NDQ2?=
 =?utf-8?B?Z3E0dXBvVmhhRlFlY3hYWjdCQU9uWWJFVTllV29Md040ZmYwUjQyMk5MYUV4?=
 =?utf-8?B?RDFoaTI4Q3VTNnM1ektmYjZYRTVWQlVGL3NONDRvdnBJdXY5bW1vR3liRDlw?=
 =?utf-8?B?MXRIR2h3aWlrUllRK2Nqc2VzMlRmVVRNMHowNHN4MGh3bVcvUkVITk5Nd0Yr?=
 =?utf-8?B?UWdSZ0ZYWnBkR08wRFNtU1RyTEhIM042VHVPNk9TMVVBVjAycFJNWGkvam9s?=
 =?utf-8?B?QzdlK0RhZ1dOTGRYc3NzMjBkOGtQakwzZFkvSGtsMnZSd2JlSDVndjFIUzY4?=
 =?utf-8?B?WENKazU2MURwQ0pZcmZRYXNUNWMyZllaV3dyTERKdXg1ZC9KSzh6VCtIb2Zm?=
 =?utf-8?B?alVMNUJQcHRnK3Y5SDlXcFZ4VXdsdmZ3KzBhY1VYV2tEaEsxczdBVW9WL1Yx?=
 =?utf-8?B?RzB0QkFVa1pYYjBkZlJ6R3lQZDVpTVJDMEFpQlRrMi9kMG9pQkFBRjlZWmVu?=
 =?utf-8?B?Uy9WVXF4bmFxS2tabGpmSHdTc2RRSGZONTZkTUY3QS9IclZsd1p0WCtpbHVv?=
 =?utf-8?B?ekhNd0pmOVJacWlldko2NUI0ZVBMT0tsR1hFUnJrZGZsVWFEamZudlhQVHlE?=
 =?utf-8?B?MHJSRVpKd2RBSTVuZnljdHkybG9xMnFnZTdVTUxkWERoVDJhZjZ5OFUrUkdO?=
 =?utf-8?B?N3FDY05hZHJ4eXRqV2dCRnEvSE4xZWxwMEZ1WHpSTXdKemxObCt3bEhXZWEz?=
 =?utf-8?B?eTRYZjdlM0o4UThuVS9YWjMzZ1BCaVE3SEhwV0QwWW1jbkNPakZldHFFYlZp?=
 =?utf-8?B?NEJUc21hS3JSblFaTXdRUkFxYjBRTUsyMEwxM3lEeTFDTzZ5YUdqTElPd1l3?=
 =?utf-8?B?bk5DV3g4VUxsVU5WR1JUVzYwamNrVVluMDRGcUwrMGtGMHVKaldQTUp6c09n?=
 =?utf-8?B?OVAvcGJYbzdYNnlWcEFJbEMyMUhXY0FaeEl1ODBUc3JIMkoyNEQ3by94LzFi?=
 =?utf-8?B?ZlJXOGxaczFobVFTdzFjUzJ5SUVlcmMrdEdmd3dYNUdjaHBDeUVBT3ppWktY?=
 =?utf-8?B?Sy9RSnJuVjEvTStNbXhYb3hkMTN3dVVTUmtrVjlrVitIMnBTU0QwSXEwbGpU?=
 =?utf-8?B?MTBiRFF3bHdENjFaU0JwbXY4SzFETlZHOWVkb2N3OUhqQ0xuVUlESktHOHJY?=
 =?utf-8?B?NVEyekV0T3NHOVpyQkRobVh6WS90REJYWi9FWGkxYTgyMEc2VS9mL3VDekNs?=
 =?utf-8?B?YURnNUZZckZ5d2ZRN0lEeVRUMlYvRWcyL1l0RGtnN054K0ZvNUpKUDhKYkJJ?=
 =?utf-8?B?enhGemxBSXBaOE4xL3RIeFRSQ244ZmZxck1DS0VUZ1dKbncydWYxTlhWc1FQ?=
 =?utf-8?B?Z3hIUmtWNlAwVU1oMXM2azBWM1d6S1krODFUSW9vdEpTQlB0bHFGTk5Zd1k3?=
 =?utf-8?B?QXEyRU1MNlRkS2RtdVVwdXBaTjBDdU5naC9IdEIxdkVjUFZ6RzFpUFlFdklK?=
 =?utf-8?B?anhlNU9vYWhYZEYvTGUzZGFlVnRlODF5UW52YURQRDFPalNaNitza0w5UFBn?=
 =?utf-8?B?K292MDYvOWdBUWJML1oxMXhmTGxtZ2RYUzZkaHQyTDFGczFHWHFET0lJUzZk?=
 =?utf-8?Q?Y6Splj4ddDrHjrkYik?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hpzBK1xbESclRLFX++mc6R7dF1FnzeMQ7aWB6uGFj+kXPJRYa7C0OJcqcznAf4q0q+U+wGvQLsnVetrcKZKT71eWm/YexAUYB3fs1Z2uF22nCyhsN4IeRLzCkNbKU7FGJPNXEVGYbedGHJ0AJUgzMNTh2coMUwsbo0OtqJOl8rtdXgndoh9rctMhCd4C5UWoE/Mx233h7qjpknTAu9X2hLEsGkIrmPUb74gv9KePMQaLnNxKa4jQxGWqvlAIpti09n0zb1X96MF5TeHKZAflBsHLq+yAwhpx+39cxf0HgTX9Od78gJo9UQW34++odpE/xYn1fnCe/KlRSAqbJy/j2w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611ae7fa-341f-4afe-b385-08deeb9cbc4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 05:05:53.9511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0a0xE1Ka3gS60GGVrsNENrpH6k6IteR4PZUX4lipGNTVSLdrrv61sm3G+g7PX8EEMUWUfEBXQNUmJRd5EEaHQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF607052E81
X-OriginatorOrg: intel.com

PiBGcm9tOiBPbGl2ZXIgTGluIDxvbGl2ZXJAbGl1eGlhb3poZW4uZGV2Pg0KPiBTZW50OiBNb25k
YXksIEp1bHkgMjcsIDIwMjYgMTI6NDkgUE0NCj4gDQo+IE9uIDI3LzA3LzIwMjYgMTI6MDMsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+IElmIGl0J3MgY29uZmlybWVkIHRvIGJlIGEgaGFyZHdhcmUg
aXNzdWUsIGl0IHNob3VsZCBiZSAob3Igd2lsbCBiZSkNCj4gZG9jdW1lbnRlZA0KPiA+IGFzIGFu
IFZULWQgZXJyYXR1bS4gVGhlbiBhIHF1aXJrIGNvdWxkIGJlIGFkZGVkIGFjY29yZGluZ2x5Lg0K
PiA+DQo+ID4gSWYgTGVub3ZvIGNvbmZpcm1zIHRvIGJlIGEgZmlybXdhcmUgaXNzdWUsIHRoZW4g
dGhleSBzaG91bGQgcmVsZWFzZSBhIG5ldw0KPiA+IGZpcm13YXJlIHZlcnNpb24gdG8gZml4IGl0
LiBJdCBkb2Vzbid0IGp1c3RpZnkgYSBxdWlyayBpbiBpb21tdSBkcml2ZXIuDQo+ID4NCj4gPiBh
bmQgaXQgaXMgbm90IGFib3V0IGEgcG9saWN5ICJ3aGV0aGVyIHRoaXMgaXNzdWUgc2hvdWxkIGJl
ICp0cmVhdGVkKiBhcy4uLiIuDQo+ID4gSXQgbmVlZHMgYSByb290IGNhdXNlIGZpcnN0Lg0KPiAN
Cj4gDQo+IEhpIEtldmluLA0KPiANCj4gSSBwZXJmb3JtZWQgYWRkaXRpb25hbCBpbnZlc3RpZ2F0
aW9uIG9uIHRoZSBETUEgZmF1bHQuDQo+IA0KPiBXaXRoIGludGVsX2lvbW11IGVuYWJsZWQ6DQo+
IA0KPiBETUFSOiBbRE1BIFJlYWQgTk9fUEFTSURdIFJlcXVlc3QgZGV2aWNlIFswMDAwOjAwOjEy
LjRdIGZhdWx0IGFkZHINCj4gMHhiN2ZmZjAwMCBbZmF1bHQgcmVhc29uIDB4MDJdIFByZXNlbnQg
Yml0IGluIGNvbnRleHQgZW50cnkgaXMgY2xlYXINCj4gDQo+IEhvd2V2ZXIsIHJlcXVlc3RlciBJ
RCAwMDAwOjAwOjEyLjQgZG9lcyBub3QgYXBwZWFyIGluIFBDSSBlbnVtZXJhdGlvbjoNCj4gDQo+
IC0gYGxzcGNpIC1ubiAtcyAwMDoxMi40YCByZXR1cm5zIG5vIG91dHB1dA0KPiAtIGBsc3BjaSAt
eHh4eCAtcyAwMDoxMi4wYCB0aHJvdWdoIGAwMDoxMi40YCBhbGwgcmV0dXJuIG5vIGRldmljZQ0K
PiAtIGAvc3lzL2J1cy9wY2kvZGV2aWNlcy9gIGNvbnRhaW5zIG5vIG1hdGNoaW5nIGVudHJ5DQo+
IA0KPiBJIGFsc28gY2hlY2tlZCB0aGUgZmlybXdhcmUtcHJvdmlkZWQgQUNQSSBETUFSIHRhYmxl
LiBJdCBjb250YWlucyBzY29wZXMNCj4gZm9yIDAwOjAyLjAgYW5kIDAwOjE0LjAsIGJ1dCBubyBz
Y29wZSBmb3IgMDA6MTIuNC4NCj4gDQo+IENvdWxkIHRoaXMgcmVxdWVzdGVyIElEIGNvcnJlc3Bv
bmQgdG8gYW4gaW50ZXJuYWwgcGxhdGZvcm0gZGV2aWNlLCBvcg0KPiBkb2VzIHRoaXMgc3VnZ2Vz
dCBhIGZpcm13YXJlL3BsYXRmb3JtIGlzc3VlPw0KPiANCg0KZnJvbSBhIGhpZGRlbiBkZXZpY2U/
IG5vIGlkZWEuLi4gWW91IHNob3VsZCByZXBvcnQgdGhpcyBpc3N1ZSB0byBMZW5vdm8NCmZpcnN0
IGFzIG9ubHkgdGhleSBrbm93IHRoZSBkZXRhaWwgb2YgdGhpcyBwbGF0Zm9ybS4NCg==
