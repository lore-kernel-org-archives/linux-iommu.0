Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A804138E
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 00:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726275385; cv=fail; b=GUSSlAQRBpO+EWGxmlubzcbEmfbSd97PICf9GIrYHPlttECouyfJSP9g27LQUbmUGEW8gnaOACZaIb1j/l/UbX7Sykzw7HKjvOrxQe1jEkRc8hM80piLpfduXu+wU9GL/TbBTFS19PcXe/nY85SjuXZnQ++Y8CicWg53nrSyXao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726275385; c=relaxed/simple;
	bh=QOuSDr0f9l90yMZJ28MzEI7H1kw9hbzO2gEoHcr4weU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZjzhpFvxEDup69qzpcwZK7skZgVokb/DHm2eVYHaN0Hstl16+5DNfaFX8V0E7EwZbgWYZvo0ZkTR0USN81Te2QPIRbw9Dzd1nbA660M45x4M0O3bjoVMPRCHAMy6x1MyrLpWP4kQKD2J28lsXvX2mLi9d/ne4if1sm/vYhWYPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbkHiGjH; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbkHiGjH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726275385; x=1757811385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QOuSDr0f9l90yMZJ28MzEI7H1kw9hbzO2gEoHcr4weU=;
  b=fbkHiGjHDI+eCueN/TH3PlTHgxeSeqJ7Zu1g4SnhgkB46n2ZzyDV9hyK
   ki6YbmGXYrGhaOxgF/WapdpjZgms34XzqMKJfSQ+bvmUtptGTIWd6jiO3
   cWRtlVDVt0STI4kJHLej5JTWt7E/ZW3h0yaaywkMYbsNtRA+Q8bL1u9In
   G9yTsX19X+O0md/EvrPNxQVCoKG8FxqNum+6Td3tUeggtAnnmkdjnLH/r
   Xlr0FOPpwSgWpvrfVR7xGXO6jskuxoQ+TZufoKE6Qv37H49B+cq/Mv4oH
   mtrhnZuqxQKxleabcCmhM7nTqLt1bD4M72jfLtyvqw9tyDfI8Igzi5Gh3
   A==;
X-CSE-ConnectionGUID: cqUKZ0LzSUOSApK6J1ADew==
X-CSE-MsgGUID: fTrP/zLwT4eRso5lNUhryw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25017597"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25017597"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 17:56:24 -0700
X-CSE-ConnectionGUID: WLyRsTVjTomrfgpW3T/Ziw==
X-CSE-MsgGUID: rT3BdRqoSOa/9LR0+U2Sqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="72365012"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 17:56:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 17:56:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 17:56:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 17:56:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGdiRhGDrfUVpMzwN5nojD7PKbBMn4dcp4aQQLNjwv//TMc91+SukRImSPe7TD5WaKxxXcnw51yZ/4igijfJxksHA/ZQuQiXjjz7KIKcjZ6/tSc2s6iZZOc4T8BG1GI3KE7eTVTp9aJSxdqTDFdst1qt7doIMSFyj4UPEZudS5tIWynIxzKb9To4MW/SQw7Z9jnFgWAi/0NoJH+nIJURCPMkmkzaVVNL6PBK0qU3ZiE9P7RILnuQkYNACjQsl102bElpXOTE8zbuL5rv+rgkAGsvFqnXSLYQYUiB5w0WpSmlneqz9jG7SB1zyHtVUSb9ysEH0TXyvvo04Y0l0ckheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOuSDr0f9l90yMZJ28MzEI7H1kw9hbzO2gEoHcr4weU=;
 b=BeC5p1JF1nbhiIwgI1wR3kzpPe5cwB5nqDgHnnl4HTp9lzpIUN5W05ssimX3T62R5f6JBZ8fgFjGceBOCNB4u1FiorCJMwx9vJLmMkBaLpSvuz/soBWSLCtKzbidVHphfkvLdnU7b6sG006DbxJy6veXZF5WkyK1/oGik4uIeGjmy2KOi3v5SFsG08Gkq8B4iWGnbnPtbBaVvwXKL79VKstHewnc9EP210haa+RT0MEXS7jjF7DB9LqNoj86emotsR7DKY1IqS/cmZsu62lyEXZDmfNBAcEiigNrnbxOSmWuTk6f4tddzSuFDIrRKcaPyGFxyrs51cxNdv3ELW0E0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Sat, 14 Sep
 2024 00:56:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 00:56:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "j.granados@samsung.com" <j.granados@samsung.com>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen
	<its@irrelevant.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v2 4/5] iommufd: Enable PRI when doing the
 iommufd_hwpt_alloc
Thread-Topic: [PATCH v2 4/5] iommufd: Enable PRI when doing the
 iommufd_hwpt_alloc
Thread-Index: AQHbBdJ4p2PObSpib06QowlmEbqjtbJWdVWQ
Date: Sat, 14 Sep 2024 00:56:13 +0000
Message-ID: <BN9PR11MB5276989B9CF1B4865CE4D69B8C662@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-4-dea01c2343bc@samsung.com>
In-Reply-To: <20240913-jag-iopfv8-v2-4-dea01c2343bc@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6490:EE_
x-ms-office365-filtering-correlation-id: f753ea73-cb77-4db4-1f59-08dcd45807ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1ZVY2IvZkFQMjhHQUVXKzVxQ1FFZi9hZkMxcFhMbEJ1U1Z2M09NSWgwdGxD?=
 =?utf-8?B?SkxCVHZ6ZktseWR3NmNtS0c2QVpPSnN0czZ4UUFXVW1uRjBWNUFRaWEvRnF1?=
 =?utf-8?B?S1pQdG0wTXAzTm1Lb0JCb2FiWnhhMDA2TkxRU3A2bmN6RHBBdFIyUmFDMkd4?=
 =?utf-8?B?ejRTYzBwZ2x1aDNueFlnblRDazYvTjkrVlNQME9telIxYi9TaWZuQmVvb3ZR?=
 =?utf-8?B?WU1HcXZtZjdWeUtNK2MzdngzU2RoRmNteFJncnB6dDJ4Y0FVV2VHU0hBdHhq?=
 =?utf-8?B?MjNRZFNTS3ZxM3RGTzJHZW5ST3dXMXA4QnJJaDRzeUVOZ1lETlovVVVVYmpW?=
 =?utf-8?B?Q3VGNjcySktTamlMQTE5WS90OWRac0gzSDNVb0ptM1hjR2JZWXNxUE95S3BC?=
 =?utf-8?B?UFNxajE1bjV0NTZhNUEycVFaMGluQzN0aEJEQXg5Q2l6cUFxQW1LVWF6bWtX?=
 =?utf-8?B?NlRGaTZRcE95UG1vQkRyUHE5c0s4MHdZOEtpenExWFNWYUFLWSs0d3lpcWNC?=
 =?utf-8?B?WkJZVTMrVUJQaTRXUHp1T3MvNWRwMGNkRk9JRC9JOW9lV2VnWXdvVUgyS3lO?=
 =?utf-8?B?bVZjc2dDRm8xSXk5d3B1ZFRJbFRCUk5rbVAwMGQ4OWFVVjB0VDVkRXB3dmI5?=
 =?utf-8?B?YzRscDA4T1U4Tm9CbWZmMVFxcEdLckNrdzNPQmdOaTRmc3pXTmgwZ2NRTUxX?=
 =?utf-8?B?NVlGaG42NXZIbXNDWm82VkFpYm9hNFRMWXNwanB5YndrajZ6QXRLUkprOGRl?=
 =?utf-8?B?RENLSTg5U0hpRDdBNStRdFBGKy9lU0JyS1FEYldPZkYvRUtwNUFlSlEweFBj?=
 =?utf-8?B?aGJWbWRUVzUzSHF3bnNaamdNZ2hnMzFtanlzaURjUHBzQnVidXRPb01Sd040?=
 =?utf-8?B?bVVQMHg5ODVqU2hPMHA2VE9KL0VwdFZuYnlORm9TWTlWNWk2ajBkVTR3N0NC?=
 =?utf-8?B?QndPUEdON3prUkF3YWdaY09CZitLUjNpOHl1NmFjcTNNdmNtQjFianFmdTBo?=
 =?utf-8?B?S2ZYSWRLZ3dxZDJJdzdrYkhKV2hmVzdpSDN3dE9hc0ZqaHEwQUU2cGZUWW9Y?=
 =?utf-8?B?dkJremxDc2M1VmdmM0picDlCaUVqeWE1VkNPSTFzUTVkWUxkR0dQOEt5M0Q5?=
 =?utf-8?B?WktDYlIrMUN0cFpZbHZaMnBRTVhONXJNVGFUeWdZcVk3ZVlNR3NRUWtUTVBJ?=
 =?utf-8?B?OWFkbVJnRHYvR1NWWU1NQVJ5aHRBR0tSMWVxbWNKODJRQzdvSVJNUUFpdGNr?=
 =?utf-8?B?UDVLZjVVRDQwSi9sa0ZEMHFYdUVkcnlqcFJsbUQzNkhkU2Vsc1JEQ3oyOUZ4?=
 =?utf-8?B?ZU1sS2trelFDQ1MrbVlCYXdMZ2hrNVBMYkttRDdMRkNtdTBwMEpxTXRvWjl3?=
 =?utf-8?B?VVBFOFZ5dDNScXZKTE52L0t5UmJyZjVSSGpVZjVoUVFxQStxN0ZKV0JRK3BI?=
 =?utf-8?B?ZUNhMWpoanRaZ0REQlNFN2RDWEdHR0hubWt3NUFlQWY1UStGdXVkcU1SdHBV?=
 =?utf-8?B?Zjh1aTVIdWVVNDduVlV5emlIL3I3cEdHNXIzdVgwUnFxYTlIUlhDTmdtSTJN?=
 =?utf-8?B?azdCVWNnaW43dHpEbHJKWHZuVmRRcmRVaU1OY3hUSFNCOEVxQ0kyS2hUZERz?=
 =?utf-8?B?Z2J0emJoNStzY3pBcHVvUmRMUWhOUExzSmxNMEpoU291enZqSkpsd1JEL1VI?=
 =?utf-8?B?UkVzNkxGUGJmcm5teS9zMndSNUsvKy9zRHNzTjlZcDFMRjJXTU1WNGU2b0t2?=
 =?utf-8?B?U3ZOZzFuUmRrRzllcnN6WnhLSE1rbTJHWG9Gd1NWMEM4dDM2eXBhelo3YnlD?=
 =?utf-8?B?S29yOTUwZTBwSG1HSy9LMHc0QUdVMGxHeCtidU1kbkUrdUExdTAwZW5Cd04x?=
 =?utf-8?B?aHVNZHpFNklUWERLSEtpcnliOHRSL3huMXdJME1nRVdxTUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3NvYWJJdzY0Q0tTNXEzdFBKcmZRV01jcWdvMWFHeVphc0RHcHluVlpCcjNu?=
 =?utf-8?B?WnhzRHhDeGhvZ3lmSEY2aXJUZ21hcjhCTGQvMDEwV0RXNCt5RHJZakdHc2sr?=
 =?utf-8?B?RlpiUy9qY3V3T243LzVLZWJmZzBLS0F6Vm5yYkVsOUJndk5JVVFzV1VVdlFJ?=
 =?utf-8?B?RzFRaTExb1d3S0VsKzl0dmNidGdaMzVBWVFqQmxHa2RlTk5yYlhBMk5kUmEx?=
 =?utf-8?B?NDNiR0lYcTNidFBZUGRWWVBWLzNJbGxZc2FvMkFzWE13RkJuVnB4TGJlNXFj?=
 =?utf-8?B?b3RmWlRBRlhmUnVZU1A3T0QweEN3ai9uV0Jpb01WTXV6QTNJNHM2c1lvc0lS?=
 =?utf-8?B?bmdUY05zZlRXYzd1Y24xZjBHSnRobzRFeGFuSk5GMUd5WTQyenNmV0dqcHp0?=
 =?utf-8?B?dVJHanBVdUpCc3NpVktNUTlPK1NHclVMUFVJbklpOXU0anhLcjhaK3pySnln?=
 =?utf-8?B?OVhnTFJXcCt3SU5tcmdYZ2VCVjZ0aFRDL3pHSXUweDgvQVU2ekRPUUQzbjZU?=
 =?utf-8?B?SVlhdVZ4U09SeDV3dTZBR2V5UEZwVUdod1h5L3Fld2VyU3I5SXg0RlA1VEhN?=
 =?utf-8?B?b1hWVk5BbVZMWlNrMm1UNmI1V2NJRTBPSElrdG9Pclc3UzdxbUlCbVI2Q2M0?=
 =?utf-8?B?ZUZ4RGVrS1ZnUUYrM094LzFVZmtMYjZmNWpqbzBReHJCdHFRbXkyd0x4aHRu?=
 =?utf-8?B?SU15QXIzcmVUT2F3WDJRZFd3bkN0K0dIdlVpOFRRUDhsakZCYTBYdUQ3a25y?=
 =?utf-8?B?alV4bVA0U0JFQ3U4VDUydVd3cmtpS3ZHUVA4SGtRQi9tRS83Ym95NWZGYzMr?=
 =?utf-8?B?ckxWc2IrU3FqWUluT1I3TE84d21QUktiTDJJdXFTaFcxZ1FmNFEwZCs3d01U?=
 =?utf-8?B?WU91VEJGVS9GNm1GNkRQejdYSUx5RjlsZGxvMkVqMHJkaU11WXpKSm1aU0RS?=
 =?utf-8?B?dDZnRlVkMnVkUmJVSXJQUXJBUjVNVk1kT1RxVEVYUEtCMnpXSUEzOEpjdWtE?=
 =?utf-8?B?T2l0d0Zrd2VpZ2JsT2ZxeWdrd3VtNzFoSFdQdkEwM2VsamwvcGs0Y3Zuditq?=
 =?utf-8?B?MXBYcGhIRjR1eXlXWW85QWczVFk2Sm9MRzlWdFNWcWFoWjJxUjlMWExnWXBa?=
 =?utf-8?B?OGJNZDd5bzhKajh1aUlkY3RsMXZJZ04zZnNxcWhDcVFKV0puWm9CMDRrbVNv?=
 =?utf-8?B?d3BRRTBJbThsRXVWeUtVWEhEQUVxb0VrdXVCSEg2WjhuMzkzaE02UEwweHBC?=
 =?utf-8?B?ZkhNRC8wb0FDWjdFRjk3MU5JOCtlejkxQnVSdXV0QWZsNStoOUpNekNTYTMr?=
 =?utf-8?B?Vnhzc2dMOERIMzhDTnBUMEZtRDZiMTA5Tnp3OGRmSFVVTlM1dDUrQjF4T3Ni?=
 =?utf-8?B?MGFLVVNBQm1yM0lpdmJSRXhzTEt6cDcvVElDYlhCSXNlL1VnZzhDV3JWMjFT?=
 =?utf-8?B?YWd4OU1pRG9NbWg3V28vWFQ4L21DQTQ1NU9CUDc3dTJXSHY5dDVtOENDR1RU?=
 =?utf-8?B?MFpOVm40ZlVCbFVOTkhRWUdwNlpPSWl4Z0QrN2dFdG1uUm1tRGRCS1BEYVhu?=
 =?utf-8?B?cXVxWHFmR0JaZlJVSGhTNlpwbDRWbkkzNVFKUW16YWY5SGVGZU0xalZGeTNP?=
 =?utf-8?B?Uk1DUDBOa0IzSTlKdUlNWlQ3cUd5MEVSMFhuK080Q3JjdVJ5bDFpWjVlL1Av?=
 =?utf-8?B?UGtUNjJSVWpNQWs1VCtBdkVhM3hyUGVMblkwVE1PYTUraGN5bytDZzVlNmIw?=
 =?utf-8?B?RDlUSk1XanhMaCsra2dCM3R3NE9oZ25LSGhXUnJabjZBcU5KV2hiT2ZjUmpB?=
 =?utf-8?B?UXFxZDg1U0t1UWI5elcveEl4a2l4UTBkdStFVDFEaERscHFUSWxnSEZQMVpK?=
 =?utf-8?B?R0djK3RYSVZaaXY4MzMrVllwekRlQVgzSjhqVVJHYmN6L1o0RXllZllJZTNI?=
 =?utf-8?B?UnVUcGYveHA2YnpTZVNlMFhZNVdQNndadlBXY1FRTTJrNC9ONGZ6WmFONXVD?=
 =?utf-8?B?SjBqUVRGMkd0aFFXcFlmQVZLVEhwVW9MWFVaUnJZcmdhN09SVVk5SGN5eVdN?=
 =?utf-8?B?LzZvMkl6V1grQ2xYdi9PTXphTUkwQ3B1bDZSbG1yc0YrSkFLWnhJb0JmZW1k?=
 =?utf-8?Q?8GIgONypY4UiRsSS5LdtUbP5X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f753ea73-cb77-4db4-1f59-08dcd45807ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 00:56:13.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mneMov3pDvg0CMvzoxHNidG/pO/aXXAvLhFtmYmPHCwpwCCcXeDQNNhgvcdIVQuSotIVyDk0rAWGtVBmmQRutg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2VsIEdyYW5hZG9zIHZpYSBCNCBSZWxheQ0KPiA8ZGV2bnVsbCtqLmdyYW5hZG9z
LnNhbXN1bmcuY29tQGtlcm5lbC5vcmc+DQo+IA0KPiBGcm9tOiBKb2VsIEdyYW5hZG9zIDxqLmdy
YW5hZG9zQHNhbXN1bmcuY29tPg0KPiANCj4gQWRkIElPTU1VX0hXUFRfRkFVTFRfSURfVkFMSUQg
YXMgcGFydCBvZiB0aGUgdmFsaWQgZmxhZ3Mgd2hlbiBkb2luZw0KPiBhbg0KPiBpb21tdWZkX2h3
cHRfYWxsb2MgYWxsb3dpbmcgdGhlIHVzZSBvZiBhbiBpb21tdSBmYXVsdCBhbGxvY2F0aW9uDQo+
IChpb21tdV9mYXVsdF9hbGxvYykgd2l0aCB0aGUgSU9NTVVfSFdQVF9BTExPQyBpb2N0bC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEpvZWwgR3JhbmFkb3MgPGouZ3JhbmFkb3NAc2Ftc3VuZy5jb20+
DQoNClJldmlld2VkLWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg==
