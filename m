Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA74428
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428631; cv=fail; b=ZzZ+JgR3fdyZVgqaXQPEXaULh8NX9wie2VYGjE0elqmXCFHvCcUzZL0XjAPmKO0y099+2wSHJybjAibrXhf1TswE6H8GX0M7T3N1cNz0d8pG92fHAvlJb+PlBLtYw/kS6vW09GO1aczKNhFTSrffiGia2bRAvdXel+6IW/77bcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428631; c=relaxed/simple;
	bh=2p0nXu/drqlKhQnlaDMm1UK3ePHFG5/gmbr8POZdfFU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=da3kv/GICEP1X4CXoNp2hJaV+qWmL8LGbAmrQ3JhnZG+QoRzuLgDPAKHeEHkXijIA0uIeAkuneDhZxJLaWVdjYgddmh97f/vSbXlesjeUez4ev7+Obf3tTiXaEslv0sMYDHhp6zcNAvrqD1uiUjPRP29x22rrsaj6NgOMzqNRv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsPHOky5; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsPHOky5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716428629; x=1747964629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2p0nXu/drqlKhQnlaDMm1UK3ePHFG5/gmbr8POZdfFU=;
  b=JsPHOky5pAY8GJ4zlcCS1B1cka/XViPdaaFKb207VBr0qIN7/wLRnjje
   3MahxK9OitK0SOiT9/JUB2jIQuGiShXmckKVKpEyG59MifEwXq430w6qY
   LcdVqpa443n0f5y4HkHinph5ip86+fACJSREoeBxZwWoP93+NRGuRxz/s
   B13CDxo1TyEvVpwSzG/XnfVPh+g1dyndMOwhwz8OX12RHw3OfZmJD4ugc
   U2UA57Bu50rU+onjyFfzVecgYpJdD0cRESj3hFEECcqsdPEG7MTcoJ7Wp
   /9hIUvwUCeDdijMRIxpSxC420WLKi24aBhdotyVbfdBf+56abBhMwWc1a
   A==;
X-CSE-ConnectionGUID: uPapFYiXRHKVP04cF1tzPg==
X-CSE-MsgGUID: ofxpm51NQXyUw9mSa/fzUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12832837"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12832837"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 18:43:49 -0700
X-CSE-ConnectionGUID: iWU+T+ybRsaqpzoQzx11Zg==
X-CSE-MsgGUID: Re5tsoKTTymqZEJ08NeNlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38278044"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 18:43:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 18:43:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 18:43:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 18:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNJYeTM9v6YIB5oh9WPMX4Xhli3oGIOm+A1CL1DoexdI05YJyhbWArfwBiWcOpDxCV1N04y25Cr0Hn1qvCE7zrT2clLbOPvMUZJn4BX+4wZN7NPfIgiMyJjTKVHEQ9+J29tCbcB4FRV4tLHh6K49H5KChmiIJZnHLpnXCmNfDo2sBhGIru2jSRZOgQwnARzoT36NyOZVilbwy468AiYF8xT3JtBdjSfWWztgpWL3dNOSRcGKZVPFanNJOAoDYhkzyMLHYg3lp6QCmwWDsJ43CFL9hk4TNYonPPrddV+3H+aYpfqVblS7hZYOf6BaKfNcVFLLDHlRe3Hs9JSsFBszzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p0nXu/drqlKhQnlaDMm1UK3ePHFG5/gmbr8POZdfFU=;
 b=i+I1Mv8hfSbj3uiVYA/OBiOhV0B6hbRfiG0SfHmRQLMQm71RWbEBewi3i10CTyCr0qe3YR23ayJM74fROPKOSRLnpCYKUP4iZoLlsv4/Ghc8jqx+Nk0wtweUkK6rc/FsiWcZDQ+Rw/JWynUz2vxZBwV7KZ0Ocq3owKrLukp4f5Jln88t4iWCUn2nvrvUFOPh75rYG4PS9EpzI0peBKLjKeoKJAgtx/9oz0LLnZsM+DRoArRB0iaeQ0ZQS4g2yv0pqZEmEWAl9hWFCzBULpkraQ/zZs25UaBhcirGelqG3Yc9YWX5OFwrNNrlsWIsVc3GbRf2VwvHReMI89hbDeSnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 01:43:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 01:43:45 +0000
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
Thread-Index: AQHajVVjs28Dvjq/i0qw8WNB6ldTtbGTz8aAgADiWwCAAmGRAIAMGHoggABT/YCAAMKCIA==
Date: Thu, 23 May 2024 01:43:45 +0000
Message-ID: <BN9PR11MB5276267BB1CC4AA7008AFBFC8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com> <ZkGKKoHnykAdGJq6@nvidia.com>
 <ZkOJgvMNFaZZ06OO@nvidia.com>
 <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522133905.GX20229@nvidia.com>
In-Reply-To: <20240522133905.GX20229@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4602:EE_
x-ms-office365-filtering-correlation-id: 027707f6-1926-4db3-0300-08dc7ac9c8e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eHF3cklIei9wQjB1WWZQL1Bad1RKd3IzaU0zM2RRcXk5NnNPQlU4bXovSmhE?=
 =?utf-8?B?bnpGdEpvT2hyZ2xsRmNBd1hLQjA3cDFaZU82UEgzM3VTY1JlUnlsUlh1WkVv?=
 =?utf-8?B?QTg0THJmZy9BY21GQTlDMXlEOC9wNEU3Y3Y1TWR5bW5XRWVjL1BtcU14SS9L?=
 =?utf-8?B?VTkzbFQ2eDZpcUpRcVhkdXVRUU5JcVhzZ2FJRzRpb2ZEelJUb29LVG1kZ2Vi?=
 =?utf-8?B?aTZEOUo4OXJlcGtBdVdHQ1V3UVNaV05PQmh2c1Y1aTg3OEpVMVp4SzVERXZi?=
 =?utf-8?B?V1BMRmNTckRBWXpwRmNPbml5V0lVTkVyQWZDN05sYXAwcFJOYnBaTHZJME5O?=
 =?utf-8?B?NlF0OTU3MTY2UmNDUW5vU1M0NTZZYURUdndOSkcwbUl4MmZ1L3ZIcUUrd2pp?=
 =?utf-8?B?NkF0ai95R0lUN29XZGxNR0t1YVlGNUN3bTZUVXYzZTV5QUhGVHB4bkdYSzVx?=
 =?utf-8?B?OEhBdkRXVHJ2QUd0S0VkWDR5S2JWWjR4cmZIeFg5ZTU3NVhETVZWSG9NV2xY?=
 =?utf-8?B?RVhJc3YyVjhPaUp6VWhpZWRYQXpHM0VsTjdteDJVQ3FHcllZK0IwUlltVmw1?=
 =?utf-8?B?S1RrU0cxMzNyUTdrdFlLN2dJakI0aXowNUk0WkxmcTVQd21QaEFicDFEY2FH?=
 =?utf-8?B?RTF4MGd0ejh5dG5lN2lHbGF2N21DZFFySjFFdzVTTHN2M2JuU2lVYnVtZ29O?=
 =?utf-8?B?RW16UXplQ3F3OUhGOHF0ZFZBd2hucjRONEYzc21iN1pXRFJpd2tGK1VzZnov?=
 =?utf-8?B?TDZjblNXYmlUZjlIYjMzeUV6ajF3bGFKbjRNeS93K0prZFRhZGNQRXdISzRY?=
 =?utf-8?B?NG8wOVhXN2NGTkJud3cwY2NDYjNwcExrMGpWWkJsbmdVVXZYMXg4UjhxSmh1?=
 =?utf-8?B?SjB2YmQ5VVJ5NzRGK01jOGJTRmMyZWw3NVNOZGdIZ2dsSk5FMGpjNjhnWDV4?=
 =?utf-8?B?RDRNcFJnSWpCR3Y4emhYM3lueVpCcDlJVU04ZDdocmtpRHNLbEVHeHB6N0Jh?=
 =?utf-8?B?TmpTdDFmdEJmK29ZQk9GK2ZoVGhKZ2c1dHJQYTk3dzFNYnFsNjA0UEJaUkpY?=
 =?utf-8?B?V3g5aWNIY2JIcFl3RmpYcW5JOGsvRThJY1IzbktrenFYa3pTRm1teUF3aUFr?=
 =?utf-8?B?L09uRGdjYjYwVFUrc0ZkUktPTjlOZ2ptcldsdHIyWTVobmZrek9aWnNwZWNr?=
 =?utf-8?B?RmNWR2ZxQVlSeGxKUjY3OU5aamRUSk9qTWR3QkE0ME1TWGpjUm4zUW0vVjRH?=
 =?utf-8?B?alFJS0UyUDdxMS92WHo3dnJNMm1Nc0hOR1o5YmxHdW9RRTZRWE90cHc0NGhZ?=
 =?utf-8?B?aDFiSUtURlg5SVBJbnNpbFNlUThPa1BvRGYzWUxEclpsY0toV09DMHV2WTJC?=
 =?utf-8?B?RHc4WDRmSmh3OFBRaEhaR1kxc2MxR0xiMEErRWpGYVdQT0VER05NWnZpaS9s?=
 =?utf-8?B?RWdiRE0vb1VVZHF5clUwS1hKQjdNTVVqWHZ2UXkvYjJ2VDZUUThJL0R2WVhu?=
 =?utf-8?B?TDZobE05cmErS3FXMStWTVlyaXl4L1FsY3NEcTlLOTAvdUxheDNGcVdNVkZC?=
 =?utf-8?B?SDY2SVczK3VqcnhrYjRPYlBmVk54NXg1SGpnUnZrT3FVeHI1QjJYM3Q2cTE2?=
 =?utf-8?B?ckdabGY5V3F1dHNCOWJzd0RXdDVQTERWQVRLRzErS1JhYmNLU0FWTnpCd25i?=
 =?utf-8?B?WVk3Z2ZBWEpxbXJRY1ByYWRXNktJRmV6VlU3T0cyMVphbTdrMjRDRDZaK2E1?=
 =?utf-8?B?ZVpPczFKZzZsZEU2THNteG1FWklRUTNPeXlWWm1uN1hiQUpoYnphWE9qMGFx?=
 =?utf-8?B?djdwTmVldXVOcTRhN1JXQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3NWcCtqVHBGYmQrbkZLbU9CVFNvWnVjMlp6UlhNL0FOZUxVQWdTVGZkQnNi?=
 =?utf-8?B?UW85RW1XSWZLYjVpS0dPUHY1ZEVBZ3V0ZEswcEtOQnhXWU0wNHA1STRSNTFV?=
 =?utf-8?B?Rkx2cVR4WG1MUlp6ZlVUTnBHalk5em92ak1Ua08wV3VpRUlMS2FIQzdLamcz?=
 =?utf-8?B?djFJMjQvSFIvTVFTTDNVUzNTZU1ZbnA3anNtRDR5V09OYXc4eHZZOVVkVGU1?=
 =?utf-8?B?TWQ0cDdZTmYwQlpNUW4yMldsNnl3WEdiQmFlbGkrc09qNjNFQWVUTXRlOEdk?=
 =?utf-8?B?Q1N6RHNmblVFdGpsMEtsOTIzclMwem95UkNUZ0hvanljNlpnVWtqOXpIY2F6?=
 =?utf-8?B?eFVpREEyUDg1clVHTzBwOXEvcjliallZN2NOY212bndadHVackw3R1dtMWF4?=
 =?utf-8?B?UXB3MTRVQ1N2cGRDNHNTWFlVenhVOFNCS2tKSE10WUhaTnVES2tSVUhoSUFt?=
 =?utf-8?B?dmNZOXFGeHJyVSs3N1hVM3VLbGttNm1JQk4wN1BEdnB6MHB3RGlKc1ZxUUpZ?=
 =?utf-8?B?QS8yRFZ0bWIzL09QeUZOemplRzdoSS9VUG0vWTN0VDBsZ0w3S0UzYUxITUha?=
 =?utf-8?B?VmZ6VFpKQVlUZmM2T3VOK2s4bHhJODFSZms4YkowVXNTM1BFUWVhMVlwb0J6?=
 =?utf-8?B?MW9EK2lMZnJPWWRMVnh6Y2ZZK0QxNHRKK0xjWkZIOVlndEpFT0lEWU8venlt?=
 =?utf-8?B?SjdvSGxVWlN5Q3RkNk9OYnRnVGY1eGFEVkR3KzdvcGV1K0NRdUhNcXNYSGN1?=
 =?utf-8?B?U2ppd1ZTYTdvTi9ieUlGcllrblpMWkZMTUxIRzhyODZ2UTBEQlB5cHowb2Mr?=
 =?utf-8?B?QnlKTlhYM2Y1NHRoL0dWU25HbytxVzEyd3ZpVDRyZWpJMlFaQWVRSzAwZGFy?=
 =?utf-8?B?eHRvY1pzeGVqZDVVZHhZUUdBMmZyMW4za1RTSmxSaFlBOGZZWmdjZktSeVgw?=
 =?utf-8?B?SW96VmFramNiNEpFQlJ6bHZ0SjIzSS9CMDc0MVJmaDRHdFJGQnFoMFFBTnJJ?=
 =?utf-8?B?dTNIcE9TVDhMTk85QzVYWW9EaWhlNzhqOVJUY1FmbnBUYXBXbEtjLzNqeEhY?=
 =?utf-8?B?L1RjaHZoeGhYZ1FmZVNBN3BxV0hSZkhqNzdHbnFYR01QcWRzaDM2KzlDQkRD?=
 =?utf-8?B?SUd2YmF2NVU1MzByMTREbXhGaGZZNFZ3ZGh3MDMrbGM3MDNPMHYvSy9ucURu?=
 =?utf-8?B?bWRmRmU0QWFVbkVUYSt1aHduNUMwYnB0VEZZd0xhMFEwNEtsS0xlQzB4SHcw?=
 =?utf-8?B?ZWtvckV2a0xhYnJZYlFuN25CUkZNOGZQQUJkZllJSEY2aUxIMC9lSUREOVgr?=
 =?utf-8?B?WVRvd29XVlRMS0VpeWNOTzVPWGhLZDc3d2RMdnV2ZUxPZUUyeEJZR2ZaREhR?=
 =?utf-8?B?M3EyZHRjanYza0FyZElLT1lRMElBc1dNUmtnbjU2bmxRV0RhTm1xU3U1ZERQ?=
 =?utf-8?B?dk9oR1ZZUmJnaWU3TDl5RjlUUHlIN2VOVjJkd1owR0dEQUs5ZnM0RDg1QkpY?=
 =?utf-8?B?Q09GSFRuUWlReEM3Si9LZGFrM0hURU94L2pMcHdzVm5hVTZtcytkSU5wZFdQ?=
 =?utf-8?B?UUE3SzFMMjNpZ2RwVitWZWtZejhvQk9HbVo5VURRdXRYdjRZMmUxcDhLSmdS?=
 =?utf-8?B?dVA0cTg1ZjVJbGxaanAwT1B6ZWhIbnBseDR5QjlsRy9oS3VJRWM3Um5LaCt2?=
 =?utf-8?B?Y3pJMDAwS1ZIVy9RczhQZi82Yk5EUW1xdFBkd2Y4N04vN2pjZG14b3Y0aDJj?=
 =?utf-8?B?K3FTVTVQU28zbjRSeFR4WWF1OTJXV3JFc1ZHRXhjd2pUUzYrdXNDaHB3My9J?=
 =?utf-8?B?bmpDTjFhQ1VyU0RVOUVnSDcva001bW5DbnZyeWUvSXpnMFNQTUZ2bEZvc1Yv?=
 =?utf-8?B?SGdjVGtsNUJ2TmtFOG1lMGJWcU00OFIraGt5UHNGeW1XalppS1hwNCtZZzlZ?=
 =?utf-8?B?MGpERWdNYkkvcFpTTkMzQWpsV3VkOWVsQ01JMTRrcHVaSS9ScU0zaFRnTkJY?=
 =?utf-8?B?Rk9RbURTUVBtcWFaUjVZb0xUZm9sZjBaaVJ2Q094MlNKSFcvcFRSbkFvY0RK?=
 =?utf-8?B?QmFpL2pCZ0NaMXQ0VWtrcERQcC9GTU45TDJXNUZwNC9JcFAzS2luckx0cDA5?=
 =?utf-8?Q?BObn1yy4LYNFRTgqX2jf7YGiA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 027707f6-1926-4db3-0300-08dc7ac9c8e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 01:43:45.7286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iT7WQtcTFzSSJNF6z4xNGyP3SfipmjP7ZiBJ8FXCA4r+uoZsQw1zfzUA95kISCdXc0Ip8eXknxFilu4d6uFVrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIE1heSAyMiwgMjAyNCA5OjM5IFBNDQo+IA0KPiBPbiBXZWQsIE1heSAyMiwgMjAyNCBhdCAw
ODo1ODozNEFNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPiA+IEZyb206IEphc29uIEd1
bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBNYXkgMTQsIDIw
MjQgMTE6NTYgUE0NCj4gPiA+DQo+ID4gPiA+ID4gU28gd2UgbmVlZCB0aGUgUzIgdG8gZXhpc3Qg
YmVmb3JlIHRoZSBWSU9NTVUgaXMgY3JlYXRlZCwgYnV0IHRoZQ0KPiA+ID4gPiA+IGRyaXZlcnMg
YXJlIGdvaW5nIHRvIG5lZWQgc29tZSBtb3JlIGZpeGluZyBiZWZvcmUgdGhhdCB3aWxsIGZ1bGx5
DQo+ID4gPiA+ID4gd29yay4NCj4gPg0KPiA+IENhbiB5b3UgZWxhYm9yYXRlIG9uIHRoaXMgcG9p
bnQ/IFZJT01NVSBpcyBhIGR1bW15IGNvbnRhaW5lciB3aGVuDQo+ID4gaXQncyBjcmVhdGVkIGFu
ZCB0aGUgYXNzb2NpYXRpb24gdG8gUzIgY29tZXMgcmVsZXZhbnQgb25seSB1bnRpbCB3aGVuDQo+
ID4gVlFVRVVFIGlzIGNyZWF0ZWQgaW5zaWRlIGFuZCBsaW5rZWQgdG8gYSBkZXZpY2U/DQo+IA0K
PiBWSU9NTVUgY29udGFpbnM6DQo+ICAtIEEgbmVzdGluZyBwYXJlbnQNCj4gIC0gQSBLVk0NCj4g
IC0gQW55IGdsb2JhbCBwZXItVk0gZGF0YSB0aGUgZHJpdmVyIG5lZWRzDQo+ICAgICogSW4gQVJN
IGNhc2UgdGhpcyBpcyBWTUlELCBzb21ldGltZXMgc2hhcmVkIHdpdGggS1ZNDQoNCkluIHdoaWNo
IGNhc2UgaXMgaXQgbm90IHNoYXJlZCB3aXRoIEtWTT8gSSBoYWQgdGhlIGltcHJlc3Npb24gdGhh
dA0KVk1JRCBhbHdheXMgY29tZXMgZnJvbSBLVk0gaW4gdGhpcyBWQ01EUSB1c2FnZS4g8J+Yig0K
DQo+ICAgICogSW4gQU1EIGNhc2UgdGhpcyBpcyB3aWxsIGFsbG9jYXRlIG1lbW9yeSBpbiB0aGUN
Cj4gICAgICAidmlvbW11IGJhY2tpbmcgc3RvcmFnZSBtZW1vcnkiDQo+IA0KPiBPYmplY3RzIGNh
biBiZSBjcmVhdGVkIG9uIHRvcCBvZiBhIFZJT01NVToNCj4gIC0gQSBuZXN0ZWQgSFdQVCAoaW9t
bXVfaHdwdF9hbGxvYzo6cHRfaWQgY2FuIGJlIGEgdmlvbW11KQ0KPiAgLSBBIHZxdWV1ZSAoQVJN
L0FNRCkNCj4gIC0gT3RoZXIgQU1EIHZpcnR1YWxpemVkIG9iamVjdHMgKEV2ZW50TG9nLCBQUFJM
b2cpDQo+IA0KPiBJdCBpcyBkZXNpcmFibGUgdG8ga2VlcCB0aGUgVklPTU1VIGxpbmtlZCB0byBv
bmx5IGEgc2luZ2xlIG5lc3RpbmcNCj4gcGFyZW50IHRoYXQgbmV2ZXIgY2hhbmdlcy4gR2l2ZW4g
aXQgc2VlbXMgdG8gYmUgYSBzbWFsbCBhc2sgdG8NCj4gYWxsb2NhdGUgdGhlIG5lc3RpbmcgcGFy
ZW50IGJlZm9yZSB0aGUgVklPTU1VIHByb3ZpZGluZyBpdCBhdCBWSU9NTVUNCj4gY3JlYXRpb24g
dGltZSBsb29rcyBsaWtlIGl0IHdpbGwgc2ltcGxpZnkgdGhlIGRyaXZlcnMgYmVjYXVzZSB0aGV5
IGNhbg0KPiByZWx5IG9uIGl0IGFsd2F5cyBleGlzdGluZyBhbmQgbmV2ZXIgY2hhbmdpbmcuDQoN
CnllcywgdGhpcyBtYWtlcyBzZW5zZS4NCg0KPiANCj4gSSB0aGluayB0aGlzIGxlbmRzIGl0c2Vs
ZiB0byBhIGxvZ2ljYWwgbGF5ZXJlZCBWTU0gZGVzaWduLi4NCj4gDQo+ICAtIElmIFZGSU8gaXMg
YmVpbmcgdXNlZCBnZXQgYW4gaW9tbXVmZA0KPiAgLSBBbGxvY2F0ZSBhbiBJT0FTIGZvciB0aGUg
ZW50aXJlIGd1ZXN0IHBoeXNpY2FsDQo+ICAtIERldGVybWluZSB0aGUgdklPTU1VIGRyaXZlciB0
byB1c2UNCj4gIC0gQWxsb2NhdGUgYSBIV1BUIGZvciB1c2UgYnkgYWxsIHRoZSB2SU9NTVUgaW5z
dGFuY2VzDQo+ICAtIEFsbG9jYXRlIGEgVklPTU1VIHBlciB2SU9NTVUgaW5zdGFuY2UNCj4gDQo+
IE9uIEFSTSB0aGUgUzIgaXMgbm90IGRpdm9yY2VkIGZyb20gdGhlIFZJT01NVSwgQVJNIHJlcXVp
cmVzIGEgc2luZ2xlDQo+IFZNSUQsIHNoYXJlZCB3aXRoIEtWTSwgYW5kIGxvY2FsaXplZCB0byBh
IHNpbmdsZSBWTSBmb3Igc29tZSBvZiB0aGUNCj4gYnlwYXNzIGZlYXR1cmVzICh2QlRNLCB2Q01E
USkuIFNvIHRvIGF0dGFjaCBhIFMyIHlvdSBhY3R1YWxseSBoYXZlIHRvDQo+IGF0dGFjaCB0aGUg
VklPTU1VIHRvIHBpY2sgdXAgdGhlIGNvcnJlY3QgVk1JRC4NCj4gDQo+IEkgaW1hZ2luZSBzb21l
dGhpbmcgbGlrZSB0aGlzOg0KPiAgICBod3B0X2FsbG9jKGRldmEsIG5lc3RpbmdfcGFyZW50PXRy
dWUpID0gc2hhcmVkX3MyDQo+ICAgIHZpb21tdV9hbGxvYyhkZXZhLCBzaGFyZWRfczIpID0gdmlv
bW11MQ0KPiAgICB2aW9tbXVfYWxsb2MoZGV2Yiwgc2hhcmVkX3MyKSA9IHZpb21tdTINCj4gICAg
aHdwdF9hbGxvYyhkZXZhLCB2aW9tbXUxLCB2c3RlKSA9IGRldmFfdnN0ZQ0KPiAgICBod3B0X2Fs
bG9jKGRldmIsIHZpb21tdTIsIHZzdGUpID0gZGV2Yl92c3RlDQo+ICAgIGF0dGFjaChkZXZhLCBk
ZXZhX3ZzdGUpDQo+ICAgIGF0dGFjaChkZXZiLCBkZXZiX3ZzdGUpDQo+ICAgIGF0dGFjaChkZXZj
LCBzaGFyZWRfczIpDQoNCkkgd29uZGVyIHdoZXRoZXIgd2Ugd2FudCB0byBtYWtlIHZpb21tdSBh
cyB0aGUgMXN0LWNsYXNzIGNpdGl6ZW4NCmZvciBhbnkgbmVzdGVkIGh3cHQgaWYgaXQgaXMgZGVz
aXJhYmxlIHRvIGVuYWJsZSBpdCBldmVuIGZvciBWVC1kIHdoaWNoDQpsYWNrcyBvZiBhIGh3IHZp
b21tdSBjb25jZXB0IGF0IHRoZSBtb21lbnQuDQoNCj4gDQo+IFRoZSBkcml2ZXIgd2lsbCB0aGVu
IGtub3cgaXQgc2hvdWxkIHByb2dyYW0gdGhyZWUgZGlmZmVyZW50IFZNSURzIGZvcg0KPiB0aGUg
c2FtZSBTMiBwYWdlIHRhYmxlLCB3aGljaCBtYXRjaGVzIHRoZSBBUk0gZXhwZWN0YXRpb24gZm9y
DQo+IFZNSUQuIFRoYXQgaXMgdG8gc2F5IHdlJ2QgcGFzcyBpbiB0aGUgdmlvbW11IGFzIHRoZSBw
dF9pZCBmb3IgdGhlDQo+IGlvbW11X2h3cHRfYWxsb2MuIFRoZSB2aW9tbXUgd291bGQgaW1wbHkg
Ym90aCB0aGUgUzIgcGFnZSB0YWJsZSBhbmQNCj4gYW55IG1ldGEgaW5mb3JtYXRpb24gbGlrZSBW
TUlEIHRoZSBkcml2ZXIgbmVlZHMuDQoNCkNhbiB5b3UgZWxhYm9yYXRlIHRoZSBhc3BlY3QgYWJv
dXQgInRocmVlIGRpZmZlcmVudCBWTUlEcyI/IFRoZXkgYXJlDQphbGwgZm9yIHRoZSBzYW1lIFZN
IGhlbmNlIHNoYXJpbmcgdGhlIHNhbWUgVk1JRCBwZXIgdGhlIGVhcmxpZXINCmRlc2NyaXB0aW9u
LiBUaGlzIGlzIGFsc28gZWNoby1lZCBpbiBwYXRjaDE0Og0KDQp0ZWdyYTI0MV9jbWRxdl92aW9t
bXVfYWxsb2MoKQ0KCXZpbnRmLT52bWlkID0gc21tdV9kb21haW4tPnZtaWQ7DQoNCj4gDQo+IEJv
dGggQU1EIGFuZCB0aGUgdkNNRFEgdGhpbmcgbmVlZCB0byB0cmFuc2xhdGUgc29tZSBQRk5zIHRo
cm91Z2ggdGhlDQo+IFMyIGFuZCBwcm9ncmFtIHRoZW0gZWxzZXdoZXJlLCB0aGlzIGlzIG1hbnVh
bGx5IGRvbmUgYnkgU1csIGFuZCB0aGVyZQ0KPiBhcmUgdGhyZWUgY2hvaWNlcyBJIGd1ZXNzOg0K
PiAgLSBIYXZlIHRoZSBWTU0gZG8gaXQgYW5kIHByb3ZpZGUgIHZvaWQgX191c2VyICogdG8gdGhl
IGRyaXZlcg0KDQp0aGlzIHNvdW5kcyByZWR1bmRhbnQgdG8gd2hhdCBTMiBhbHJlYWR5IHByb3Zp
ZGVzDQoNCj4gIC0gSGF2ZSB0aGUgZHJpdmVyIGRvIGl0IHRocm91Z2ggdGhlIFMyIGRpcmVjdGx5
IGFuZCB0cmFjaw0KPiAgICBTMiBpbnZhbGlkYXRpb25zDQoNCnRoaXMgbWFrZXMgbW9yZSBzZW5z
ZSB0byBtZS4gSnVzdCBsaWtlIHRoZSBkcml2ZXIgYWxyZWFkeSBuZWVkcyB0byB0cmFjaw0KUzIg
aW52YWxpZGF0aW9ucyB0byBmbHVzaCBhbnkgbmVzdGVkIGNhY2hlIHJlbGF0ZWQgdG8gdGhlIGFm
ZmVjdGVkIFMyIHJhbmdlLg0KDQo+ICAtIEhhdmUgdGhlIGRyaXZlciBvcGVuIGFuIGFjY2VzcyBv
biB0aGUgSU9BUyBhbmQgdXNlIHRoZSBhY2Nlc3MgdW5tYXANCj4gDQoNCml0IHJlcXVpcmVzIGFk
ZGluZyBtb3JlIGlvbW11ZmQgYXdhcmVuZXNzIGludG8gdGhlIGlvbW11IGRyaXZlci4gSSdtDQpp
bmNsaW5lZCB0byBkbyBpdCBvbmx5IGF0IG1pbmltYWwgbmVjZXNzaXR5Lg0KDQo+IE5vdCBzdXJl
IHdoaWNoIGlzIHRoZSBiZXN0Li4NCg0KPiANCj4gPiA+IFJpZ2h0LCBJbnRlbCBjdXJyZW50bHkg
ZG9lc24ndCBuZWVkIGl0LCBidXQgSSBmZWVsIGxpa2UgZXZlcnlvbmUgd2lsbA0KPiA+ID4gbmVl
ZCB0aGlzIGV2ZW50dWFsbHkgYXMgdGhlIGZhc3QgaW52YWxpZGF0aW9uIHBhdGggaXMgcXVpdGUg
aW1wb3J0YW50Lg0KPiA+DQo+ID4geWVzLCB0aGVyZSBpcyBubyBuZWVkIGJ1dCBJIGRvbid0IHNl
ZSBhbnkgaGFybSBvZiBwcmVwYXJpbmcgZm9yIHN1Y2gNCj4gPiBleHRlbnNpb24gb24gVlQtZC4g
TG9naWNhbGx5IGl0J3MgY2xlYXJlciwgZS5nLiBpZiB3ZSBkZWNpZGUgdG8gbW92ZQ0KPiA+IGRl
dmljZSBUTEIgaW52YWxpZGF0aW9uIHRvIGEgc2VwYXJhdGUgdUFQSSB0aGVuIHZJT01NVSBpcyBj
ZXJ0YWlubHkNCj4gPiBhIGNsZWFyZXIgb2JqZWN0IHRvIGNhcnJ5IGl0LiBhbmQgaGFyZHdhcmUg
ZXh0ZW5zaW9ucyByZWFsbHkgbG9va3MgbGlrZQ0KPiA+IG9wdGltaXphdGlvbiBvbiBzb2Z0d2Fy
ZSBpbXBsZW1lbnRhdGlvbnMuDQo+ID4NCj4gPiBhbmQgd2UgZG8gbmVlZCBtYWtlIGEgZGVjaXNp
b24gbm93LCBnaXZlbiBpZiB3ZSBtYWtlIHZJT01NVSBhcw0KPiA+IGEgZ2VuZXJpYyBvYmplY3Qg
Zm9yIGFsbCB2ZW5kb3JzIGl0IG1heSBoYXZlIHBvdGVudGlhbCBpbXBhY3Qgb24NCj4gPiB0aGUg
dXNlciBwYWdlIGZhdWx0IHN1cHBvcnQgd2hpY2ggQmFvbHUgaXMgd29ya2luZyBvbi4NCj4gDQo+
ID4gdGhlIHNvLWNhbGxlZA0KPiA+IGZhdWx0IG9iamVjdCB3aWxsIGJlIGNvbnRhaW5lZCBpbiB2
SU9NTVUsIHdoaWNoIGlzIHNvZnR3YXJlIG1hbmFnZWQNCj4gPiBvbiBWVC1kL1NNTVUgYnV0IHBh
c3NlZCB0aHJvdWdoIG9uIEFNRC4NCj4gDQo+IEhtbSwgZ2l2ZW4gd2UgY3VycmVudGx5IGhhdmUg
bm8ga25vd24gaGFyZHdhcmUgZW50YW5nbGVtZW50IGJldHdlZW4NCj4gUFJJIGFuZCBWSU9NTVUg
aXQgZG9lcyBzZWVtIE9LIGZvciBQUkkgdG8ganVzdCBleGlzdCBzZXBlcmF0ZSBmb3INCg0KSXNu
J3QgQU1EIHZQUFJMb2cgZm9yIGRpcmVjdGx5IHNlbmRpbmcgUFJJIHJlcXVlc3QgaW50byB0aGUg
Z3Vlc3Q/DQoNCj4gbm93LiBJZiBzb21lb25lIG5lZWRzIHRoZW0gbGlua2VkIHNvbWVkYXkgd2Ug
Y2FuIGFkZCBhIHZpb21tdV9pZCB0bw0KPiB0aGUgY3JlYXRlIHByaSBxdWV1ZSBjb21tYW5kLg0K
DQpJJ20gbW9yZSB3b3JyaWVkIGFib3V0IHRoZSBwb3RlbnRpYWwgY29uZmxpY3QgYmV0d2VlbiB0
aGUgdnF1ZXVlDQpvYmplY3QgaGVyZSBhbmQgdGhlIGZhdWx0IHF1ZXVlIG9iamVjdCBpbiBCYW9s
dSdzIHNlcmllcywgaWYgd2Ugd2FudA0KdG8gaW50cm9kdWNlIHZJT01NVSBjb25jZXB0IHRvIHBs
YXRmb3JtcyB3aGljaCBsYWNrIG9mIHRoZSBodw0Kc3VwcG9ydC4NCg0KSW4gdGhhdCBjYXNlIGJv
dGggb2JqZWN0cyBhcmUgc29mdHdhcmUgY29uc3RydWN0cyB0byBkZWxpdmVyIGZhdWx0cy4NCg==
