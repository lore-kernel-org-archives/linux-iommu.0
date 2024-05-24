Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E24C9B
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716517001; cv=fail; b=YPXQ3SEyyPkbvRmF9rlle+zujVAFpYnrtZb5mW8xymZRUFsbCZK97P4YraTnt1YItjwk4Qj1g8x75a6VaVeqG4teO8SDK5fA/8WFuqAxeNVBwfZnGrgMBxEvUp0UCR419+6cSV40M7Iyjs6SYljP8HPlc3XZqfv0nfMHCU6ktec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716517001; c=relaxed/simple;
	bh=v02Kd3afHOOvJGSeGDQhm7dTcOCHcAIn1wHBrDH3PNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JUOIdp+ky7+qsLwhQQFJ0GZAu9AunH2kHkJi9PR5IHCkNNR6uWhaMOkj+7E8A7WKSFb7aZLEC7aB9KAF1hGUd68ryNOs7vGA6qYE/2Jvf9D1Ea9MtPpjsorjCZHf/5pQYJZmql0tyKTVi2JGKjhin/tABDQnrKfR4aEaJhgmtp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPoIdLKK; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPoIdLKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716517000; x=1748053000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v02Kd3afHOOvJGSeGDQhm7dTcOCHcAIn1wHBrDH3PNo=;
  b=UPoIdLKKkINVGFTesbFV9j8fO9W7QwsK/Kpyxqo0fPJVXzrSbxGhxHgd
   dDloWeK15AYMRYmfWAmcKcxQIvjnxMd4nAmAubI6pX7oYsnapL2BDKket
   Ldn5Jd3XwbmQ327qL2nIijmZHUV5a67CBzAG6irAyH9NuOX+j44HQ/U4z
   7GvgR3BOEmeubGs3YJKz99q3J993WnlIz8uKk7cKHerUAQgUi67rABd3Y
   DvK3ennjaFzIDBSFSsNxSCPrkRNGlEQBCQ5TG2aD5Bq5lHc10Y3kwV3I7
   5Wlx9tYP4lld1V+CpK32CVKh0idER4wH4gMLyd3E6TcmlgNc/0sPI5JM9
   A==;
X-CSE-ConnectionGUID: xrE1cOvzQEKYf3O3z1wYeQ==
X-CSE-MsgGUID: Atd4zNmGRTaQrstc+ypxOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="16713560"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="16713560"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 19:16:39 -0700
X-CSE-ConnectionGUID: 2t/hR3HcRhSHFl87OEdR1w==
X-CSE-MsgGUID: bB4ZQPZ/TKOz6VTPdGUhzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="38858946"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 19:16:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 19:16:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 19:16:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 19:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8e32to2QTbOxXGXwERTA2vQ95RHq/OgRVjRk/HwwSsMFoiSDNQW2GXxVM0zCdqAww7kMp1Alub1yuFKSIL3HjdjxXhIoRSVmUJ2ZC3UUhGVbBp+/C9nx59jxwUhJbOVjcQ4WOkYFD1oSWdVwYUAJr9uxZidvyyWsIQ+yx1mIMrMg6K9eOg8AeluAfCEyL62EDNcjq9azBpZEOZ7GYjdt3pAPwD9O7CF0TVe00aJkMrhxIT/IX/7K4pFuGaYUj+Bmc4JzJpyZRQoFYwOPB4IGT0KMqm1EfM+UZk+04FHhtJ0oLGFxoMSlmU9jPpq6CaARroY6Isb9rCQq8FmOS5ktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v02Kd3afHOOvJGSeGDQhm7dTcOCHcAIn1wHBrDH3PNo=;
 b=aBfHpGnG2rQYHPpB6+RICtZQhmSwGrPUF1T2CVhPCKmcUFIH9ftMKjWlt+WJ0HROnrWbAb7VjGeoIaOxxJ2/BMfdEzGy5NBl2p/uo7HpsbOrIA/oDn5iWFHZGg9C8cdCVe0Om+Nc8oBPkQM0SjDDeZp9fCkkeByk14jPO+x4kTgd0q7uF648Kujvo/BKxn77Sk3ZPaqkK6xkIHR6+s6tQGAr8tzFWsq5NKXC1u15w5NP7kDdlrRGwiYiqA0EU2qtun2Pxh+nsQQXebaZBLvflnVZW7cc4qY5tSfEKhfpALJLiqoytLg7EziALScvHKQ85LXNsa2/w+Q7TKbKZLeMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 24 May
 2024 02:16:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 02:16:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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
Subject: RE: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Thread-Topic: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Thread-Index: AQHajVVjs28Dvjq/i0qw8WNB6ldTtbGTz8aAgADiWwCAAmGRAIAMGHoggABT/YCAAMKCIIAAxJsAgADb66A=
Date: Fri, 24 May 2024 02:16:34 +0000
Message-ID: <BN9PR11MB5276461630564C74C9369CB88CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com> <ZkGKKoHnykAdGJq6@nvidia.com>
 <ZkOJgvMNFaZZ06OO@nvidia.com>
 <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522133905.GX20229@nvidia.com>
 <BN9PR11MB5276267BB1CC4AA7008AFBFC8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240523125856.GL20229@nvidia.com>
In-Reply-To: <20240523125856.GL20229@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8346:EE_
x-ms-office365-filtering-correlation-id: c3722b92-ff4b-4fac-52e2-08dc7b978917
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VUs4clVyeXJSL1pSK0hLaEpNQ09jWEVTcGdpRDB2SVBWQTh5OVB1djM1NWJQ?=
 =?utf-8?B?MjNLNWpaNGVpcy8wZ3BmMTA0cDZvVlpqN3NSeWhnREhMNXFFM3lxVkpJMFkx?=
 =?utf-8?B?TzlPS095U3N6eXNhK2VQZlFtNTQwSmoydDBtZ3EzR1NaeFJRVitNUFlGRGZF?=
 =?utf-8?B?eExnK09zaEUram9xV3UyWW54dXFEQ0VDb2N2R2dETUVwQVdLSVNFU0l6L3Na?=
 =?utf-8?B?N1lKWW9xZFlMZkdwVkdHQk5SWlNZUTFVQndXdkVsV1RURUF0UUlDZXJDWlRu?=
 =?utf-8?B?LzhqVjdLeWhJMkdJaU4wSHBtVXFtQnNRM0ViOUdrTmxsVS9SeC93OEJKaWFS?=
 =?utf-8?B?N0loKzArZDlOQnZYZG55M0ZQYWV2R2pIbkg1ZGhrQmJ4MmIyajFDUU5zWnU3?=
 =?utf-8?B?T2ZJRGlZZzJVQSt3VVlMeGNkWWgvNTlDc1ZtcW5taTgrWTJQRWI4N3hBK1VY?=
 =?utf-8?B?eHdKalRRZGFURVJyQ2tidWNqd3JEaTFWWUpyMTB4dFdtRWJZaGFtV2p3cVhD?=
 =?utf-8?B?enNpZ0lQbEhqdXhMa2V6YTVTQkd1eVpzRUJsbW9TMlpoNmRxMkZTd0tKdXVE?=
 =?utf-8?B?OVlGbkp2a3FTRW9QaUUybVJjUWMvYXJIcjA4aVFWT2JrTFNYeXRYOGxLOW1t?=
 =?utf-8?B?Z1RaNnkwVzFURGVobzNNeUlBUklvQ1o0eE5PbUlVc1F0eGx4YnhBQ1l4MFRH?=
 =?utf-8?B?WjYzcXNJV2dNenJyRFZFUlpPTnRkdFFrQU9UVXBFZXJDNGVCdVNTN1Ryb004?=
 =?utf-8?B?RWpxd2RFUzV2bGZ1ZWFWT0JJNmVHNWRsUURsVHJLRDJoeGNDWGZoc0h4L3Fq?=
 =?utf-8?B?VVNBTG9WRjFSLzFRSHVJbUd3MHFWeGdFd29vM1d4b1YyZU5zemRHZGdCR1FQ?=
 =?utf-8?B?Tng0ckhwY0E3QVBCR3dsWElOT2VtaEJJTkZlNU5xdEFmVHErQ3JqQ2l2UEhN?=
 =?utf-8?B?Rkl0S21Ick5lOW1EbythZ2VJbThGK1pGSTZWWVNBTjVZaElhTTF2VnV4YjU0?=
 =?utf-8?B?eFpYbk9pUEpMOU9LMnZET0NKYmlQMWFZRTBOTzJDT21ZNVRYSjBqZytpOFBK?=
 =?utf-8?B?d29LVCtXeXpaek5zaE1RcE9tRHh1eWJ6amg1ZmwrbmgzZUFieXFKaEdSOTdE?=
 =?utf-8?B?NGhHV3NudllLSW9EU2RzTTVmVVRic1Flb0FVRG5MOGpxb1cxRVRyMWVielM2?=
 =?utf-8?B?L05LTHpLYmxFRHpGdW1mMlVCZ3FNU0tTYlMyVUhuUzQxZ3lWODN1RU1SV0NN?=
 =?utf-8?B?Q0cyNmhrUmNyU25XWXp5dzJrUWIzK3RvUjQwYkVHeVkvaVZ0dGwvWjBqVmxS?=
 =?utf-8?B?QkkrZ3hSdlA4K3NlbEFReHd4TVRxMjR2WUNmYXMvTXg1a0l4Nk9GOGI4Vk1s?=
 =?utf-8?B?TEpSN0l3Y0VpNmw5ZytNWVhWMDlTQXpjU3RyajZ6K3RUaU9QdlBHREFpUk5X?=
 =?utf-8?B?NkU1OTBNa3BJRitNbVppZlVYU0NGak9mVGxvbzl1THh0enNGdm0wTE44andT?=
 =?utf-8?B?aWNXUExWSkkrTDVQRGtpdHhJMWg3aFYvaEs0ODZKMWpTNHJsWngyVUZLUUxC?=
 =?utf-8?B?L0hCbzNCamJEdVNJaGNBWlUxcldrMjM5a29taU51NHFjSWtGZmRJRjlRRW92?=
 =?utf-8?B?RDZaY0N4eFJwWlJCY0NKWlhqbnRuYVRLUUNmMEY0VWVYODBsKzlpdjdVSitC?=
 =?utf-8?B?VC8zN0x0bTVDSWNwUWUwd0Jjak1JM2dmRE5JKzlsNCtGOVN2cm1xbTdpclFC?=
 =?utf-8?B?OFJiY3hlYit5bnFjaHNqd1NMR3BCbW5BOGlJYlBBbmxuOXpuc3M1VytNdUJk?=
 =?utf-8?B?ekpHcE1RdllCUFlIaUp2Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmZLZCtzSXNwK1h2VmdsMFZPaG1LSUhiUFMxOTlkZy8rckxMSXprdEhHeGJk?=
 =?utf-8?B?OGxpRmtBRGo0OFM5SFZtMFEzejVIMmRmMkUzWmZodXh5SlpQSVpDbTBWZEhW?=
 =?utf-8?B?LzNxZTZKcVd6UW5QUS9oVmhvdzBXZnRvalpzd01McDJ2c1djQzg3NzJmbmZ4?=
 =?utf-8?B?ZTI5S2JUVXpDdTF4eTQzY2NydFlCSC9RRkxvK1l6Uk52ZVpjZDBkMTFiVytl?=
 =?utf-8?B?VHJLZlpKTndET1oxZFNUZG9LcnhPUXkvazMxYXB4ZWZLcHVzVXZ1SFltZkdJ?=
 =?utf-8?B?MFFhRVBNMndUK1o4WVJmSjZwNk9scVJjRnVOWHBlL0tBWXJyZXpiQ1NjaU5F?=
 =?utf-8?B?aG1sZlVrT3NHT1N2dUk1Skl4czNTWm4zaU5Sd3FvU0RDaURnelZIVitjTGcz?=
 =?utf-8?B?Y2pqdkduZ1p4RzBXV0lBUVVlcC9Ra1lzUUtrQ2c3dWN0NmxXSXU0VVpod3Yv?=
 =?utf-8?B?UENKVXRmL0ltSDlhWWZFaHhaR3FyU0ltb0lEemhUUFA3b1o1SXZFbWtpaUZr?=
 =?utf-8?B?NUdYSlgwdTV5YjRzbWFBd0hmcGFYZ1BsT0NQWVhJelFobG5JWUFTdnFNdFNl?=
 =?utf-8?B?QVhsT1J2WERMUmtRMlBEeVYySVppbUV3RkZJVk54cnZjdi9STkREUG5aZzRL?=
 =?utf-8?B?TFVSSGVVamw4bC94WE44KzdVcmErYndYc0xYMGtwVE5WTVFnNE9xVUJuamNL?=
 =?utf-8?B?a240YU13TnVxT1BFT3NZN1llWjV3dWhBYVUzVXRWTTNCRU1ZVjdvVklSOVZO?=
 =?utf-8?B?Nm1jRnhjcFBvYTlHZGxXc3g0NkFHUkx1eGc0Tm5OTExOeGQ3Slh3VTY4V3oy?=
 =?utf-8?B?cmwwM3ZQbmkzVHVBRjFPVWVVSVk1V1pITW90SUpSalRlUXBaZk1FZ0ZOdUtz?=
 =?utf-8?B?RW0wbEFWWFRNdUNKNHdIOElPUitieWsrMFVtbUhLRS9uREhzTDRZdlFzclJQ?=
 =?utf-8?B?SFg4djR1N1JCNUpnaHlNOHNPVGVsT1JEbzdCN1JPdjBIckVPdDdsaWFvUXNY?=
 =?utf-8?B?NGZpQW5Ob002bnlycDRzenlOLy9BU0tNY3RKSnZ0ZGdnY3hJZ3lwWForREFR?=
 =?utf-8?B?YWVCLzBHbytTaVdUZmFXdDBJVGlqV2hmeUlmcnJLS0QwOUVKNnpGZjREdzNL?=
 =?utf-8?B?RW54U2ZXVERkSUtXeWYxVGFHbzdZVkt5ZG9yM0l0ckFDL290aUJoNVhCaHly?=
 =?utf-8?B?MllNclg3Ti9TZ3pRS2VQMnhseEYyc3dBeCtLdzFHd2FWNjVoYWFxUWNHUTFE?=
 =?utf-8?B?MGNzdzNxUzFqajJURHRQUitrRWxlTmtTVHZZV0VSbGtMZDFwNXZ3dmNYcG1y?=
 =?utf-8?B?SDZtMnJzb1VJZnN1L29NNytxdkpnNDFaQVhFd1Z5ZFpyMkFnR0NRVnQzVlBi?=
 =?utf-8?B?RjR0Q2tkTk5KbmVIMUFZM1RCR2kwbHFSNUhpRmtLT2pldFp3bmJKRkpKL3ZR?=
 =?utf-8?B?S3FQbHJ5QkZheDA2OFBKcXlUOXNHYnU4RGJlR3k5clk1WC90YVRMY3h1d0JY?=
 =?utf-8?B?dDZZNUN2R2lzb3NVeVkwNjRLR1FHMEVPZHF3dUtTSmVZb0UwVXExZ0RqVk0z?=
 =?utf-8?B?RXVXdHBJUTdJc2I4dllOcExSWFdKSmZuV3FjanNEZGs3Nitqd3pZK3dMRDNy?=
 =?utf-8?B?R0lIaW9tOUsvRVpJYndtTFhFOVdoZ1Btbm9NQjcxVm1OVHk4OHkvYW42cFh5?=
 =?utf-8?B?ajVGZ3dWQkdYUUx5TEJJYTFQWmJHemZFVkh3WEZxaC9VUllZWlM2WmJJRHNX?=
 =?utf-8?B?TEpPRlFTU0RqWlpOZWxESEhPSTVYREI2YmJIb1dGRks1c0VqODZLS2hyL0Vr?=
 =?utf-8?B?ME83ZEtTME1SUm1uanYxeTVNRDJ0L2E4YzZ2aVV1a0h1TDVEb3JnZlBPUjg3?=
 =?utf-8?B?MWJqVms1Y3ZmMDJPbE1semtWRWlHZklWbHRVR3JuOUI5QlV0TG93dXpjVDBu?=
 =?utf-8?B?QU9RL3BBY0c3UTEvVzh4VFdhdVRSclo3VGQxSFNtemRiR1BRaVE3Mzdvbnly?=
 =?utf-8?B?NVZqQU9vNEhkMnB2OTV5WE5kT3VuZytWR3BoMEdzT2JEUytGdnVwYkxENlVJ?=
 =?utf-8?B?NWEzUm1kM1c5anNRVHhHb2VrWlBaVE95TjU5cVlFSkd3TEhmbmpJL1ZvNUJP?=
 =?utf-8?Q?n1jIvO8nfmQo9m003Mk+Iyk10?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3722b92-ff4b-4fac-52e2-08dc7b978917
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 02:16:34.9902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWzncXApSxv2jfL/J5tzexdPZWPhhIMdzaSYC8sQf4NPoscdsvKf3yydIfxmI774o1B7bwGCG/1vGliZW/YIYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgTWF5IDIzLCAyMDI0IDg6NTkgUE0NCj4gT24gVGh1LCBNYXkgMjMsIDIwMjQgYXQgMDE6NDM6
NDVBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBKYXNvbiBHdW50aG9y
cGUgPGpnZ0BudmlkaWEuY29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjIsIDIwMjQg
OTozOSBQTQ0KPiA+ID4NCj4gPiA+IFRoZSBkcml2ZXIgd2lsbCB0aGVuIGtub3cgaXQgc2hvdWxk
IHByb2dyYW0gdGhyZWUgZGlmZmVyZW50IFZNSURzIGZvcg0KPiA+ID4gdGhlIHNhbWUgUzIgcGFn
ZSB0YWJsZSwgd2hpY2ggbWF0Y2hlcyB0aGUgQVJNIGV4cGVjdGF0aW9uIGZvcg0KPiA+ID4gVk1J
RC4gVGhhdCBpcyB0byBzYXkgd2UnZCBwYXNzIGluIHRoZSB2aW9tbXUgYXMgdGhlIHB0X2lkIGZv
ciB0aGUNCj4gPiA+IGlvbW11X2h3cHRfYWxsb2MuIFRoZSB2aW9tbXUgd291bGQgaW1wbHkgYm90
aCB0aGUgUzIgcGFnZSB0YWJsZSBhbmQNCj4gPiA+IGFueSBtZXRhIGluZm9ybWF0aW9uIGxpa2Ug
Vk1JRCB0aGUgZHJpdmVyIG5lZWRzLg0KPiA+DQo+ID4gQ2FuIHlvdSBlbGFib3JhdGUgdGhlIGFz
cGVjdCBhYm91dCAidGhyZWUgZGlmZmVyZW50IFZNSURzIj8NCj4gDQo+IEluIFNNTVV2MyB0aGUg
Y2FjaGUgaXMgdGFnZ2VkIGJ5IChWTUlELEFTSUQpIHdoZXJlIEFTSUQgaXMgY29tcGxldGVseQ0K
PiBjb250cm9sbGVkIGJ5IHRoZSBndWVzdC4NCj4gDQo+IEV2ZXJ5IHRpbWUgdGhlIGd1ZXN0IG9i
c2VydmVzIGEgU01NVXYzIGluc3RhbmNlIGl0IGlzIGFsbG93ZWQgdG8NCj4gY3JlYXRlcyBpdHMg
b3duIHByaXZhdGUgQVNJRCBudW1iZXIgc3BhY2UgZm9yIHRoYXQgaW5zdGFuY2UuIFRoZSBndWVz
dA0KPiBjb3VsZCByZS11c2UgQVNJRCAjMSBvbiB0d28gaW5zdGFuY2VzLg0KPiANCj4gU28gZXZl
cnkgU01NVXYzIGluc3RhbmNlIHBsdWdnZWQgaW50byB0aGUgZ3Vlc3QgbmVlZHMgdG8gaGF2ZSBp
dHMgb3duDQo+IHVuaXF1ZSBWTUlEIHNvIHRoYXQgdGhlIG92ZXJsYXBwaW5nIEFTSUQncyBhcmUg
ZGlzYW1iaWd1YXRlLiBUaGUgYWJvdmUNCj4gd291bGQgY3JlYXRlIGEgVk0gd2hlcmU6DQo+IA0K
PiAgZGV2YSAtPiB2U01NVXYzICMxDQo+ICBkZXZiIC0+IHZTTU1VdjMgIzINCj4gIGRldmMgLT4g
Tm8gSU9NTVUNCg0KVGhpcyBhc3N1bWVzIHRoYXQgZWFjaCB2U01NVXYzIGluc3RhbmNlIGhhcyBv
bmx5IG9uZSBBU0lEIHNwYWNlDQppLmUuIHRoZSBndWVzdCBjYW5ub3QgY3JlYXRlIG11bHRpcGxl
IFZNSUQncyBpdHNlbGY/IA0KDQo+ID4gPiBIbW0sIGdpdmVuIHdlIGN1cnJlbnRseSBoYXZlIG5v
IGtub3duIGhhcmR3YXJlIGVudGFuZ2xlbWVudA0KPiBiZXR3ZWVuDQo+ID4gPiBQUkkgYW5kIFZJ
T01NVSBpdCBkb2VzIHNlZW0gT0sgZm9yIFBSSSB0byBqdXN0IGV4aXN0IHNlcGVyYXRlIGZvcg0K
PiA+DQo+ID4gSXNuJ3QgQU1EIHZQUFJMb2cgZm9yIGRpcmVjdGx5IHNlbmRpbmcgUFJJIHJlcXVl
c3QgaW50byB0aGUgZ3Vlc3Q/DQo+IA0KPiBJIHRoaW5rIGl0IGlzLCBidXQgdGhhdCB3b3VsZCBi
ZSBhIHZRVUVVRSBvbiB0aGUgVklPTU1VIG5vdCBhZGRpbmcgYQ0KPiBWSU9NTVUgdG8gTHUncyBw
YXRjaGVzLCB3aGljaCBpcyB3aGF0IEkgbWVudC4NCj4gDQo+ID4gPiBub3cuIElmIHNvbWVvbmUg
bmVlZHMgdGhlbSBsaW5rZWQgc29tZWRheSB3ZSBjYW4gYWRkIGEgdmlvbW11X2lkIHRvDQo+ID4g
PiB0aGUgY3JlYXRlIHByaSBxdWV1ZSBjb21tYW5kLg0KPiA+DQo+ID4gSSdtIG1vcmUgd29ycmll
ZCBhYm91dCB0aGUgcG90ZW50aWFsIGNvbmZsaWN0IGJldHdlZW4gdGhlIHZxdWV1ZQ0KPiA+IG9i
amVjdCBoZXJlIGFuZCB0aGUgZmF1bHQgcXVldWUgb2JqZWN0IGluIEJhb2x1J3Mgc2VyaWVzLCBp
ZiB3ZSB3YW50DQo+ID4gdG8gaW50cm9kdWNlIHZJT01NVSBjb25jZXB0IHRvIHBsYXRmb3JtcyB3
aGljaCBsYWNrIG9mIHRoZSBodw0KPiA+IHN1cHBvcnQuDQo+IA0KPiBJIGFzc3VtZSB0aGUgdlBQ
UkxvZyB3aWxsIHN0ZWFsIGFsbCB0aGUgUFJJIGJlZm9yZSBpdCByZWFjaGVzIHRoZQ0KPiBrZXJu
ZWwsIHNvIG9uY2UgdGhpcyBpcyB0dXJuZWQgb24gTHUncyBwYXRoIHdvbid0IHNlZSBhbnl0aGlu
Zy4NCj4gDQoNCk9rYXksIHRoZW4gd2UgZXhwZWN0IHRoaXMgdnF1ZXVlIG9iamVjdCBvbmx5IGZv
ciBIVyBhY2NlbGVyYXRpb24NCndoaWxlIHNvZnR3YXJlLWJhc2VkIGZhdWx0IGxvZ2dpbmcgaXMg
c3RpbGwgcm91dGVkIHZpYSBCYW9sdSdzIHdvcmsuDQo=
