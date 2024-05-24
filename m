Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE743987B
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716528262; cv=fail; b=P+ruHCVu9XIMW3uMLxm5Ya+3RVPrl1qrlaiU9aCorI0mWwhSP/dWhi9xuwzOKFH4KEKP7+HrTONbcg5Y1cqRGpYvuhm57uiCES5qwlC3jskW2g5mvJkOaMVM+TI5lNC7wds8fDLVXOEiV2qTv6hHhGJmy1D5FGLWCd9j+R4IQsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716528262; c=relaxed/simple;
	bh=g9sI7Z1KosDmnOq9B6rUpINFLv/+PnrOzeHylZJUDJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ObrnCFz3lq7aEj8pXPxM8qTF9s/1iCQYpHpjxIARRaCfLm8/wjraovdfy3XGrAHLIzkTu1YE+jj3hXQ4ZwKzyGxzw/zF07gdaRcdJDgTmR6Og1qqriR44EWEX6x+NJpEDg2z07Z3cWeFcYQKg0hquYhUhCd4VaggBeXnGPAtn/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkMXDIkm; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkMXDIkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716528261; x=1748064261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g9sI7Z1KosDmnOq9B6rUpINFLv/+PnrOzeHylZJUDJY=;
  b=IkMXDIkm08HbTP0bycg28oh1CNwa+n533QKY1A0eq6dSNI6c1PbwlKIG
   h8b3yz5knDw03GllfcZr1E50WLDkOkRHgo9ucpu1dUHGIPnrFp4EtzfR3
   mtrTkmSGH87L044AejTQYpWqfPJeYWXNhg7JQFSWKnnzdrrgyJgHTypLL
   WA80LhnW7319caf1qzVF7HmtriWHfIE1AGa8PllncFhhc+oJxxcnkPEup
   GocpXhda0h4Z5pDtoQrIrn47QJsz7bsjKgDQDRJC5zdzjygS6qdOOiU8i
   3A2/7ryaKjORHRMQ+RQIQpEEZ1F+BVc3ilPB70yMZsx39lEQ9fcWC4+Qi
   w==;
X-CSE-ConnectionGUID: SRUEq1d8Tey6ePTP1msv5A==
X-CSE-MsgGUID: ZHvj2/p4SN6QgWTlUCHyLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="35406203"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="35406203"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 22:24:20 -0700
X-CSE-ConnectionGUID: PjVDfQ3vTp69rmqhojoR5Q==
X-CSE-MsgGUID: aw0+4yt+Teuo/o+ITz9TrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="34016977"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 22:24:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 22:24:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 22:24:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 22:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUHr9LaWeqYYBhWqL46Wt+WqFdUqX6PQvbQmPOuv19ifigjWHXLVxMtf6nxGoQxU8weGsQw6/sz3BEMh3qae41pJskVZfY/2w9spYPIUnzuDYt7GBaam+Hlp+0Q9OZCORKtYZJ2XM7FLIlkX72S6cR4s/Wp5V3UGT4RtZ0JFINHca8c/9U1pHFKRyBDOy5/GSfJ64IyDQkqDwYTvZD0ydSrSgtAYUxBqrJwNu6dVCc3W0sKHdYTheEDGziQ83CvJKuJOf86Nxgg/DWMLhubM39t7BxyC2tZPnj9YOxiJz/6+mPa0J8VyrZES2TugrEonoiO6fE8CDHq/rc+rx92Uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9sI7Z1KosDmnOq9B6rUpINFLv/+PnrOzeHylZJUDJY=;
 b=IRHG8nXITKlPWsWg6msuOySTCukbAL95vkwtl0ABlsM/hjChKruGtf3oTJ1rKj0C6lG4kEAL10EpeSRUAxMYnN36PEfcYwOAlgBqp0W7sZ24aJdImGFuZde5E67sJUv9kNchxdvHE9mhZGlq6VxYmPb3aBg0GJ39fueWoL9VV3FHvx5MBgOeg/ZKmFF5jWRK0vUPuHBPGl757exxYTSVbsoyafzTcoO7+kftQYclj7fiZSmt8iXjfd9BkeTJTQ5XNsksG1gwoX7T2aNxh7EC6ZU3eAOdr8Dna+ki2ph1FUobkzjFYwTMrXqtXqbn7OgIIOa2vlAa8lwcV0yofLYPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8275.namprd11.prod.outlook.com (2603:10b6:510:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 05:24:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 05:24:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Thread-Topic: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Thread-Index: AQHajVVq/X0HjqCDvU+a/LkdwhCQ/LGT28sAgADojoCAAk6vgIAAqT2AgAqBYwCAAlS+oIAAlxIAgAC8r8CAABODgIAAIBrQ
Date: Fri, 24 May 2024 05:24:11 +0000
Message-ID: <BN9PR11MB5276422CE4B77D262CD292208CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com> <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com> <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
 <BN9PR11MB5276EEC2A1DDA9C92F96737C8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240523150120.GO20229@nvidia.com>
 <BN9PR11MB5276A896D215E1FA61DECDC38CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAI5d6ktg7yncLE@nvidia.com>
In-Reply-To: <ZlAI5d6ktg7yncLE@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8275:EE_
x-ms-office365-filtering-correlation-id: d20e6fcb-1b55-48f5-f211-08dc7bb1be99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aUtmTWdFRm5hZVhGNEgrMkxhaUtnb1hVZEVuTGUxVHlCOGVSZTVsdGhvMXZ3?=
 =?utf-8?B?NnRpQ3Zvd1JwM0JhaXJ6d1FjK0hIRStXcTBrRjRtTkx2K2hKUm41cHZPTGZk?=
 =?utf-8?B?VU5JcGlWbHpiVEpWcDNiaVZQM003Vnc1OUVvZVU5bjhIT2daL1RBY0czd0I3?=
 =?utf-8?B?K2V0WHRNRlFpdSt4Tm1ZOHN0bk5SUmdTaG9HYkgycHIvS3RqUXprMTg5eGpt?=
 =?utf-8?B?aHI1SUdTYWhtRFpBL3poWVdsYlpCWTFNT2xiVWIrWnNPU0JJQkxuSy91dERi?=
 =?utf-8?B?RVFuVjVZdDUyVmM5RUJEODZFZkFIRE1XTzhlQ3BhSXpHUEUvTVlnVVE2UVRx?=
 =?utf-8?B?aFpHZGFiUHJKUXIxNUtTdmEzSUw4em5CS2ZmTDd1Z0lWUU1NeEtWM2VRNWpt?=
 =?utf-8?B?dDl5eVV6VTlibERDVXNuWkM4QVNyM0ZDc3YwTmZrL0FsaXRaK2xmWHJaakxL?=
 =?utf-8?B?VG1IdDNGVk4zZE5CYzJiU1dzS24ycm14Q1pubURVOWVmdkN6L1F6Rk1KSEds?=
 =?utf-8?B?cCtRV01ZU1BNQkxVMTdiTjEwcXNyQ01WOExHOFJwcWJDeC8rUEJpOUNJWFVQ?=
 =?utf-8?B?U09adk9qUVVGUXhCN0N2ZFBpV1BLS3hFTTl4OStvOEFBdWpDUjdFbi96Q2ZZ?=
 =?utf-8?B?Kzl2bHQ0T2lWelIxcjloVGRuT3E4bmY5ZUgydmRlY1FQSDE2QjNGcCtZMHZG?=
 =?utf-8?B?TDVkR1hYRzBjVkRvc2xWY0tqVCtmbTBadXZtdWl5cmhsdUZNU3BHTmtYQ3VD?=
 =?utf-8?B?RkRSOWVGeDhKNncrRFhmdXRXOUFuQ3E0djViNkd1VnhESlBMVHVXeEJnUFRz?=
 =?utf-8?B?Qk1kRlF5TUMwUzhCNVFpbmF4QTZZQXJuMWs4VnZWeUxUU1h1SUNJWUMrT1V3?=
 =?utf-8?B?cG1HRUY3S0IwRHBEMUtLdTV0QWZRY3p1eWI0djA1dzZ1eld6Smc3bmJ0aWY1?=
 =?utf-8?B?bzEwOXdvSU5SZFZSbkNzVmF5ek9SaERmSVh1YzJiY0Zqd0p2WjV5VkRzcW1q?=
 =?utf-8?B?TDhRN0V6d0VlblRJRXhvQSt3cWNOTTg0ZDlScjRkbVNxVnpIbGtLY09JUG9o?=
 =?utf-8?B?dC9XeFJ5UEpiWU5iK1VKVTN3OW9aR2s0a2JsbGhKS3FVbzNXcUloeDErOHYy?=
 =?utf-8?B?bnRheFZEUGVkZFVGUFBER2wxc2swOVlXTERLUy9pR3c1RkRScVJvbGZTa1ZU?=
 =?utf-8?B?WmtDUGZDd2pPRlk2MDZDdWRWY1p1MjFNTXBwY2ltM1ZhSEIzWXVmUzNSOHEv?=
 =?utf-8?B?c24rd1UyclNSSmtRWllDemREd3VvVktkWmROK2R0amlBVDY3QSsyMEJPMUxC?=
 =?utf-8?B?UDdPZkZDNHFWSFhBa0xvN05TREV2Sklwc2E5QUUwTHNDK1dveU5TWTNTTHVI?=
 =?utf-8?B?NUE1dmpPaUJvZ3RNcDlwekxtQ0YwZXBQUXFxRWEvWmY2L0wwa3VDWmJmVFRL?=
 =?utf-8?B?M291S2x1bEFLaGZwWVFnWVBOazVqKzA4My9SbUFLc0NqemFJTmE4WENLT1pM?=
 =?utf-8?B?d3JjalorNVdhelovQTBYNHlYZDdHWEo4a2pIakVoaWIvOU10MnJUOWcxL1Y2?=
 =?utf-8?B?T1piTys3SXVxekNxSDVlV29Db0U2RVptdDcyUUVITkxBZXFlRmVjR3plMjdX?=
 =?utf-8?B?VEZ3NllubE1tVzI2Rm5qclZBL1F6a2VwMjBEQm1UbldWOUZFLzBEZXdBWHpK?=
 =?utf-8?B?TU1tRUtrWmZRNERLeXhwdU1lSUl5Ny95ekZFeEsxS25WU1l4ZmJQUjVpNDIw?=
 =?utf-8?B?SVYxMmxUU2tGMjcxbEZUZ1YweitOdzVxSnI2U3hYVXFKM3lKa3pZMHJkZy9h?=
 =?utf-8?B?UlhPa3U1cTdDcEE4SjBYUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dCtUSW9rWmtCUFVJZ2krWUxMV2hLV3g5RnFOS3J1ME9RdzB4aEhIcUtzTGhs?=
 =?utf-8?B?KzNqT0lBZmtzM2s4NWtjbWRFZW9Zcnd4RHpONmx6bTIvNXQ5ekFlOFZxcHg3?=
 =?utf-8?B?TGowZGtxclBDVXFqdTNIemc4WFM3RlBzUzlTUFA3TFVkdWpKVEZCSXZaMHdX?=
 =?utf-8?B?SGVxS2tIMWpRVU1rV1pYbyt5Zk1ESmNLRkcvQ0tvbEVpRkFaMUNLL0hBRGUv?=
 =?utf-8?B?USs1VWRERzRvQWFqZnpnUFdPRWhSTnVvMFRXaUVoSDVtbENiaHU3WW4rUFZF?=
 =?utf-8?B?aFovWTliYzdjYVBtYTRoUVNFTXN4cmRTeStDNzJSOHBUU0Z3Ui9pSHpOODFz?=
 =?utf-8?B?UGthdnFlVFF2VlhadXZzWnpNU01vSVNxQTdDMnl4ZmZwalVBZDRkSGR1NHF0?=
 =?utf-8?B?c3R1UjFBY1FlVXJQcnpYUU1aa28xWDNaQ3p5dGp1alNVUkVoSDh0MWxqWC9G?=
 =?utf-8?B?c01aWHlwOTRMYWU3TFlYT0toMnNJaXZjWm9VZVBtbUpGWlVpMUl5VkJUK3po?=
 =?utf-8?B?NFlvdHVIcEVCRUM3QjdHeTREb284UVVBVHN1cEdDL243UVdsbTgzMFRrejBI?=
 =?utf-8?B?eE1ZcGVscUhqQWIxS2pLRkJJaFBUOXBwRnhoRGpmNTJLd1RSV3RGMnphWitK?=
 =?utf-8?B?SThod1FpVjdWNUdCUzU4aFJYUHBCSkFKVEhWcG9RSEtyaWdaZVZXL3h5WEpk?=
 =?utf-8?B?Z3RJUmJybXVBSXIwenlBQldLTFFPZjZhVEhDNG5EaE5TZnIvcTI4eGhHZzZx?=
 =?utf-8?B?VzBUZjMyQ1pLR1RveDVFS0R3MjZMR1hKZ2pZY3R5eHZsbVd4NndMVjEreVhw?=
 =?utf-8?B?Q09hZ05pczI2eHptZm10dklVKzlYREVJVHJROERCYjhvcUpHdjVIeHFqaSta?=
 =?utf-8?B?bjVybDU4ZkJmYlR3d2ZRNkxEU1VDamtjYjZyZ3NBWWFWTVN0VWJ4djBHSWEr?=
 =?utf-8?B?ajZ3OGpyQXZ0dFRPeUlzeHlRcXRJTldLcmVBU0ZNSkJWeWl4ZWcycEgyWmxK?=
 =?utf-8?B?RGJpd0hMR0VENDFIdmpPNmk4YkNqdjNhRWxNVWpKajRTN0p0dmFKQjRVbkRV?=
 =?utf-8?B?V2dFanVMNW5MY0Y0blNLZU4xQjhrVTdBQVY5NkZadlp2Z3E2VVVNVi9QM3p3?=
 =?utf-8?B?NC8yU2wrdkRGdDJIUlR6L3FaYjlHNEJyVTExakQwNVpiRUNkejBqb3Ywdlly?=
 =?utf-8?B?YjFlQ2dSSHhrclZlMVhiTWV5SElZdy9NZ0N4WlM3TFhKTVpHTVduTXJRQzQ1?=
 =?utf-8?B?NkY4cVpGKy9UV1Q4ZXlXdU43ZEdJT2lDQjNycjFwSWlMRE53Y2l4UmR4Wk0z?=
 =?utf-8?B?NFZBanFUNkhTWml3Y2pZVlZGOEtOcEV2S0lNTkVIeGozQnVyTTdweklRZ093?=
 =?utf-8?B?TElVMnFOS3p4ZTJQeWY4akhKVnNQMTF1cTVaeVJNbHRLbURCamZ0Y1ZCVlBw?=
 =?utf-8?B?N0cyVENoQy9sZ1RiSnBDZkEzOUFUL2R3NCtkRjkxS3BYRVFXaUdUTGMrQmty?=
 =?utf-8?B?eTMzc1dldGs1MW1aNmk1Zml1QjNqYkc0UzM4THZ6dzVFb1NXVGhBMFF3blJG?=
 =?utf-8?B?Y2JwUVJoOTVGQjl5anhITGFyOU9TTW9LZXNCN2pmYm5RMytzYVplV0hKSzI0?=
 =?utf-8?B?SWx0ZGRPajRTQmVBSDFkNFNYcjhvNFNXUVNNNGI5dTJ0M1NRdFdUcHlvdDFJ?=
 =?utf-8?B?NnhwUCtEQXl5amg4VmRvOVJkNnVRdGJ3UzZwYjFxRHZyY2tBT3FMUEprRXpT?=
 =?utf-8?B?Q1lqS1VRaGZVeUhhVHczVE03bUVnNkZHdFRwRm5zSWJDR0lpZno2UDhVTnRH?=
 =?utf-8?B?VDZpM29XcU9iTnZuZmN6RWlwK2JMMW42RzhxbnlMN1MxUWtEdHdrRDY0MVdi?=
 =?utf-8?B?ZzZZLzFyYjNDV3B1dGNTRTZhalBNaDFOQ1E3MFkvQWtTeGltc2pjNXlNRWk1?=
 =?utf-8?B?aGs5Skd4clMvc2J3UkV2eUdsK2tiVWsyVTJCSlJLbmxGTGNZcXF4OFNnYnhW?=
 =?utf-8?B?dktVT1daTmNzSENwZC8vRUNiRUU3dEhRMzN0K1p5TTQ5clVWS0l4T3VrUW54?=
 =?utf-8?B?cVlWK1FNVTVkM0kvdXlHRzMxR2dQL3lhdVRTdE93RDRMTmdMK2tNdGwwZjZN?=
 =?utf-8?Q?8hSyv1g2XOW4Dk0q3iXcFisMw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d20e6fcb-1b55-48f5-f211-08dc7bb1be99
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 05:24:11.6351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DVFNeGXMpnHorodhcPscjVrR8ex5baSbtm4M+zeGHH9dUNrDmJ2kY3JaxLYJBpaCpSiakYd+Zl5qoAlrBWVIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8275
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgTWF5IDI0LCAyMDI0IDExOjI2IEFNDQo+IA0KPiBPbiBGcmksIE1heSAyNCwgMjAyNCBhdCAw
MjoyMToyM0FNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPiA+IEZyb206IEphc29uIEd1
bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgTWF5IDIzLCAy
MDI0IDExOjAxIFBNDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBNYXkgMjMsIDIwMjQgYXQgMDY6MTk6
NTlBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogSmFzb24gR3Vu
dGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gPiA+ID4gPiBTZW50OiBXZWRuZXNkYXksIE1heSAy
MiwgMjAyNCAyOjI1IEFNDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBUdWUsIE1heSAxNCwgMjAy
NCBhdCAwNjo1OTowN1BNIC0wNzAwLCBOaWNvbGluIENoZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBT
bywgeW91IHdhbnQgYSBwcm94eSBTMSBkb21haW4gZm9yIGEgZGV2aWNlIHRvIGF0dGFjaCwgaW4g
Y2FzZQ0KPiA+ID4gPiA+ID4gb2YgYSBzdGFnZS0yIG9ubHkgc2V0dXAsIGJlY2F1c2UgYW4gUzIg
ZG9tYWluIHdpbGwgbm8gbG9uZ2VyIGhhcw0KPiA+ID4gPiA+ID4gYSBWTUlELCBzaW5jZSBpdCdz
IHNoYXJlZCBhbW9uZyB2aW9tbXVzLiBJbiB0aGUgU01NVSBkcml2ZXIgY2FzZSwNCj4gPiA+ID4g
PiA+IGFuIGFybV9zbW11X2RvbWFpbiB3b24ndCBoYXZlIGFuIHNtbXUgcG9pbnRlciwgc28gYSBk
ZXZpY2UNCj4gY2FuJ3QNCj4gPiA+ID4gPiA+IGF0dGFjaCB0byBhbiBTMiBkb21haW4gYnV0IGFs
d2F5cyBhbiBuZXN0ZWQgUzEgZG9tYWluLCByaWdodD8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRo
YXQgc2VlbXMgbGlrZSBhIHNpbXBsZSBzb2x1dGlvbiB0byB0aGUgVk1JRCBsaWZldGltZSwgYnV0
IGl0IG1lYW5zDQo+ID4gPiA+ID4gdGhlIGtlcm5lbCBoYXMgdG8gZGVjb2RlIG1vcmUgdHlwZXMg
b2YgdlNURS4NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiB3aHkgZG9lcyBBVEMgaW52YWxp
ZGF0aW9uIG5lZWQgdG8ga25vdyBhYm91dCBWTUlEPw0KPiA+ID4NCj4gPiA+IEFUQyBpbnZhbGlk
YXRpb24gYWx3YXlzIHJlcXVpcmVzIGEgdlJJRCB0byBwUklEIHRyYW5zbGF0aW9uIGFuZCB0aGUN
Cj4gPiA+IFZJT01NVSB3aWxsIGhvbGQgdGhhdCB0cmFuc2xhdGlvbi4NCj4gPiA+DQo+ID4gPiBP
biB2Q01EUSBIVyBhbmQgb24gQU1EIEhXIHRoZSB2UklEIHRvIHBSSUQgdHJhbnNsYXRpb24gaXMg
cHVzaGVkDQo+IGludG8NCj4gPiA+IEhXLCBhbmQgdkNNRFEgcmVxdWlyZXMgdGhlIFZNSUQgdG8g
ZG8gdGhhdC4NCj4gPiA+DQo+ID4NCj4gPiBBdCBhIHF1aWNrIGdsYW5jZSBWTUlEIGFuZCB2UklE
LT5wUklEIHRyYW5zbGF0aW9uIGFyZSBib3RoIGNvbmZpZ3VyYXRpb25zDQo+ID4gb2YgYSB2aW50
Zi4NCj4gPg0KPiA+IE15IGltcHJlc3Npb24gd2FzIHRoYXQgdmludGYtPnZtaWQgaXMgYWRkZWQg
dG8gZ3Vlc3QgY21kIHdoZW4gaXQncw0KPiA+IGFib3V0IGlvdGxiIGludmFsaWRhdGlvbi4NCj4g
Pg0KPiA+IHRoZW4gdmludGYtPnNpZF9zbG90cyBpcyB3YWxrZWQgd2hlbiBoYW5kbGluZyBhIGd1
ZXN0IGNtZCBmb3IgQVRDDQo+ID4gaW52YWxpZGF0aW9uLg0KPiA+DQo+ID4gSSdtIG5vdCBzdXJl
IHdoeSB0aGUgbGF0dGVyIG9uZSByZXF1aXJlcyBhIHZhbGlkIFZNSUQgdG8gZG8gdGhlIHdhbGtp
bmcNCj4gPiBleGNlcHQgaXQncyBhIGltcGxlbWVudGF0aW9uIGNob2ljZSBtYWRlIGJ5IHZDTURR
Pw0KPiANCj4gV2VsbCwgd2UgaGF2ZW4ndCB0aG91Z2h0IGFib3V0IGEgY2FzZSBvZiBkb2luZyBB
VEMgaW52YWxpZGF0aW9uDQo+IHZpYSBWSU5URi9WQ01EUSB3aXRob3V0IHNldHRpbmcgdXAgYSBW
TUlELCBhcyAiVk1JRCIgaXMgYSBmaWVsZA0KPiBpbiB0aGUgVklOVEZfQ09ORklHIHJlZ2lzdGVy
IG5leHQgdG8gdGhlIEVuYWJsZSBiaXQgYW5kIG11c3QgYmUNCj4gc2V0IHByaW9yIHRvIGVuYWJs
aW5nIGEgVklOVEYsIHRob3VnaCB5b3VyIHVuZGVyc3RhbmRpbmcgb2YgdGhlDQo+IEhXIHdvcmsg
ZmxvdyBpcyBwcm9iYWJseSBhY2N1cmF0ZSA6KQ0KDQpPa2F5LCB0aGF0IGV4cGxhaW5zIGl0LiB0
aGV5IGFyZSBpcnJlbGV2YW50IGluIGNvbmNlcHQgYnV0IGNvbWUNCnJlbGV2YW50IGR1ZSB0byB0
aGF0IGRldGFpbC4g8J+Yig0KDQo+IA0KPiBBbmQgdGhlIG5hcnJhdGl2ZSBhdCB0aGUgdG9wIHdh
cyB0cnlpbmcgdG8gZGVzY3JpYmUgdGhlIGxpbmtzOg0KPiAgIFsgZGV2aWNlIF0gPT4gWyBwcm94
eSBpZGVudGl0eSBTMSBdID0+IFsgdmlvbW11IFsgc2hhcmVkIFMyIF0gXQ0KPiB2LnMuDQo+ICAg
WyBkZXZpY2UgXSA9PiBbIG5vbi1zaGFyZWFibGUgUzIgXQ0KPiANCj4gU28gdGhlIGZpcnN0IGNh
c2UgY2FuIHRha2UgYWR2YW50YWdlIG9mIFZJT01NVV9JTlZBTElEQVRFIHYucy4NCj4gdGhlIHNl
Y29uZCBjYXNlIHJlcXVpcmVzIGEgREVWX0lOVkFMSURBVEUuDQoNCmFuZCBvbmUgc2lkZS1lZmZl
Y3QgaW4gdGhlIGZpcnN0IGNhc2UgaXMgdG8gc2F2ZSBvbmUgVk1JRCBmb3INCm5vbi1zaGFyZWFi
bGUgUzIgaGVuY2UgaW1wcm92ZXMgaW90bGIgZWZmaWNpZW5jeS4NCg0KPiANCj4gQW5vdGhlciBj
b25jbHVzaW9uIGJldHdlZW4gdGhlIGxpbmVzOiBzaW5jZSBBUk0gU01NVSB3aWxsIGhhdmUNCj4g
dGhlIGZpcnN0IGNhc2UgKHdpdGggdmlvbW11KSwgdGhlcmUgaXMgbm8gbG9uZ2VyIGFueSB1c2Ug
b2YgYQ0KPiBERVZfSU5WQUxJREFURSBpb2N0bC4gU28sIHdlIHdvdWxkIGxpa2VseSBkcm9wIGl0
IGluIHRoZSBjb21pbmcNCj4gdmVyc2lvbi4NCj4gDQo+IFRoYW5rcw0KPiBOaWNvbGluDQo=
