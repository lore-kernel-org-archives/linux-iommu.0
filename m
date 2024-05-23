Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CD239AF9
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716442835; cv=fail; b=S3WnkE40kjzHZdrGtp6sGm55tmJR4ZkvccLpsui4dwEzQm8TFHaw7opyktyO6GcZDxLBRTcTE+4ltXTN6YZSzlmr6nwDL4FUb8zv9si2okWWVpO52iDWaejy2uf//JIdHJQkxfCtVUVlEzYKs9jCPL8L+b4Ed4fEwi8KuSwba0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716442835; c=relaxed/simple;
	bh=J5yJqRJ6BuTXqrYZID9RPmw+x6+R9MQ6s8pnzcogowE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXvU8V8eQC8I8JUF+7KON0o24hJBIz+odsSo1s17gp3ozCgac6kSB/ReEp5oxSm0rHEUe5C/s3uONwfbRkJsJxERG1YpV3ytMgOWDF8pkG7Jd02PL0gZ57grhBMZ+GUI9EuUgem96tqjzHC3S4Flu18lZQmCJdncN31XRHesm/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1G9y5t6; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1G9y5t6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716442833; x=1747978833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J5yJqRJ6BuTXqrYZID9RPmw+x6+R9MQ6s8pnzcogowE=;
  b=Z1G9y5t6qPArQqlvJmoqgVq443OeNv7LD6yBjmsSdZ7s78udvXVpcQhW
   CI9TY61pws2wvVX3S2QLcJuV7UxxmVywlb10/RFg2Ie37g33P/ETOya9p
   VmbTVdOWXBzx93sI18A1REvqolzxojCSZgoKhW+D9r+Cxkh4O6q4ND7t7
   IDW0EL5z+IaWA9Z1jmyO/wM0ScCVwubZWjkS1pniD8jazMykze5NQEJTz
   KHaHtuaOU6mpLuiI+ddY/1JDINCYBiAjtD+wrABnGMKzyjUMpyVdQ8/Ur
   xJHCa1IK79oHZFhspsRMR3wG2k0llEklfgu69LRA73T22tbIqiedkDUFL
   A==;
X-CSE-ConnectionGUID: tuWz2x7bRdiOG120/5NkeA==
X-CSE-MsgGUID: xYBBjbqeSEKTNV0qAevl1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23400048"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23400048"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 22:40:32 -0700
X-CSE-ConnectionGUID: eCCOtIshQ2u9ib9qlwFVjw==
X-CSE-MsgGUID: x3LF7EUGR/WZuN+I1bx1gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38125808"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 22:40:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 22:40:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 22:40:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 22:40:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 22:40:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nfo4OPgtES2gzpBWJiZFr2OvFkoVJTm9xBk3SgBhry+nK1N8CqHMwb8QJyraBKVqoH+EiCgps1HZuQ881btvWynmNzcIKE1UKc2Tw8cwNVXTcestzR2MigBPyP6TwFPyFjw9XZxEgSPrUMv1RKgWZKxlh0ybOqUOAhk0Oa26dK7NBsZYvy6ZIttWZTwd/63KnNNnd6iakPK+83UUhnl89PvkTcnbggDGEFqbOWwamTUhxELStEH2Ee/2RwDGQL6EHXJv1TwCtKkcPl50lH+dpFOMJbeikSJ4VkBafxRGqhm1BFgwilaNH308GRHAUEFJ3dphKHDXgo1HDTdBhae+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5yJqRJ6BuTXqrYZID9RPmw+x6+R9MQ6s8pnzcogowE=;
 b=ldGcICy0KBZqzcC/g92NrwlJ2L4ROwgtKc64zSB6tq83HzVI2u60dmApaOt7MaLGpflddj+a/cJE1Q8HCTm1nlKEg8kHXz4cnq+siz1G+DprqV7SI0x3nObo+BoyIJNgkZ4dQ9XIBdlt7h8H1I2etE8r0gGq8z33Phyue8Ef+KS40FOsOtI50iYwrYTN3Q6/Aoq3203+r4/ksHtN7K86BfcU1VOlQGVMoXD27oAaIKW5Mi4vJekQfLQUMVBwnUs1jyIx0kuPWd7RDOADKPefLExG5jDzMbEJtXO2B+e/unAzxmxWHIi+jHN0yavDHH50YbRdEOxclozgSNPZOnkPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 05:40:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 05:40:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
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
Thread-Index: AQHajVVjs28Dvjq/i0qw8WNB6ldTtbGTz8aAgADiWwCAAmGRAIAMGHoggABT/YCAAMKCIIAALooAgAAZXvA=
Date: Thu, 23 May 2024 05:40:29 +0000
Message-ID: <BN9PR11MB52764652318E8671C7C3567F8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com> <ZkGKKoHnykAdGJq6@nvidia.com>
 <ZkOJgvMNFaZZ06OO@nvidia.com>
 <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522133905.GX20229@nvidia.com>
 <BN9PR11MB5276267BB1CC4AA7008AFBFC8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Zk6/rpwvh5lMck2I@nvidia.com>
In-Reply-To: <Zk6/rpwvh5lMck2I@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7927:EE_
x-ms-office365-filtering-correlation-id: c6b19963-b6f3-485f-e460-08dc7aeadafb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UGx4WEphR3RjQWdmczB2OXNMYStZSk5xY3ZNMmZOeXhlaE1vNGJuNkZvellQ?=
 =?utf-8?B?QTBuM0JHOTdOd3hzSW8wSzFtUXJSRTEvNitMaUUwL2dVTm92MEVlaDVpeUJs?=
 =?utf-8?B?S0ROZFJPcmZlUDVwMzlkM084ZkpWKzgrdEEyWUVFcTdoSnpIZnI0Zk40OU0v?=
 =?utf-8?B?NzcwTElhOXV1a0lseC91ekJ5UTV4VUZaVGJFdStyM2U5WGNsdDIwOXdiNzBt?=
 =?utf-8?B?Q1ZrYzJHNFFhSjRFeUFMVUs0bVdRUWN4eVRBUFZtc01ZR3pPN3FVSGxIRFlJ?=
 =?utf-8?B?cXY0Ym1mNjFUWGl1UVhmR1k3RzhCcGtmaVNLelgzMFZiSC92cFpqUCtVNm1o?=
 =?utf-8?B?TFRzVGxvSU00cy8wV0VDdVE3OGZWV0VjbnlrZTNlZytVRUlkUnZoY3JsY0VZ?=
 =?utf-8?B?eVd4cGZoSmRuNXYyUzRMVWQvSVZkTWdWNW90U0NLY1VQSW12S24ySVJBOWdF?=
 =?utf-8?B?VVZaRE5tTUdOSzhVUzBJT01uSEFmdit6Nnl6ckw2RGpGQUwzZ2MvdmRRek5k?=
 =?utf-8?B?TkZtWUoxTG5OMzcwaXp2UkxzTkQ4dnJ2M0xJVjEyK2Q2ajV2cXAxdjNLNDh0?=
 =?utf-8?B?Y05LNmtId3lmSmtxbERUKzZBa3NyMVVFRUFCK0lvRzVtS2RrM01RN0x2TkJ5?=
 =?utf-8?B?eWNDK3hTcUlObFVXQWtZN3h1WVRSckFBMFRGU0RtNWVnS0YrWmFTcTRmUU9p?=
 =?utf-8?B?SVkrTkVhV3dYWWY2YURkYlJmaFA2emtNQVVhZTZTODRoSkMwbGZBZFN6OUdQ?=
 =?utf-8?B?ZDM0M3pOWWx6SGdjS1R0QUZZR2tMTDJIb0NQWUdiWHdLMVZCMnFyVWx3WWFE?=
 =?utf-8?B?R05jdE1nMUg1R1U4Yms1MTNoTVRES080YlJqY2h1VE94R2I3eFFmd1kyRk9r?=
 =?utf-8?B?UFFHUi8yNG8xZnIyVGp1L3BXQU5wbk0raXczaVFKRVVlVDVQdDVpNEVDUVVR?=
 =?utf-8?B?TUpISHZKUEVBVWtVcEpkcElwT2lrYitsSU5CY0JlV1hIMGhLSERXL0FsMHNW?=
 =?utf-8?B?a2YvTnNaUzRhME96WGp3MGFJNXNqbUxCNndIcUE0Vml5MFFZYmJmRWtxMjNx?=
 =?utf-8?B?RG9ONWpRSUk2d2VodVoxYythM3QwbHU5S0lORmpuVm11T2xuamdRamo4SlpY?=
 =?utf-8?B?TkVYbjlQWm45RmIxTXBjaXJuQkt4MjNYNTdaYVB6ZlVXcWVjTWFKelBTS1I3?=
 =?utf-8?B?VGJhaWUyZFkxNGlCR0JJZDNHZkxFZ0s2N0xhM1RkeG9EaFEwaXF1OVdkMjgy?=
 =?utf-8?B?TGdackp2dy95TitnSUltNCtHZm5kT0VvSnJteWNpYkNQVEpybE41Z1VlY1lT?=
 =?utf-8?B?Tmhya2U0enpBYkg5SGdWNEJ5UFZES3p4SDNLYzJvdFI5WHBPNTBuQm5ic2NZ?=
 =?utf-8?B?NWlxbE5sV21vMHlVV1Z1NmU3ZWRQU3hTcStsemtUK1JlSzRQRHRPYW1ZMnB3?=
 =?utf-8?B?Z2Y0bktPcGJSSWlhS0ZQYkl1SE96ZnoybFhYbnR2VEN4Z0YvWDB5REdoOGk3?=
 =?utf-8?B?K2QzU2dtRjdaa1RuSy9ubjdoMm02VVQ0ZnlnUGZMZUUrRGoyazZ6MTFBQ0pT?=
 =?utf-8?B?WTd0Vy9vY2FFQ2xvZWh1UVdtQlR6bHBNR3lGZ1YwRXl4dTdJYXFvZHE1T3Vv?=
 =?utf-8?B?ekRxZXRkOFdxcXJ3SWRvcSsyOUJpOFl2VHpmNUpTS3lFVTVPVHhvY0NMc3Rw?=
 =?utf-8?B?bm5XRlM3S1MzN0laUTZTSjVBRlpmKzEzdG9kMm84TUlEUzRJVytEYm9VWnRL?=
 =?utf-8?B?Nk9waHhPZEdtL1IybTFxOXhBQjE5cDhwcGlONkI5bTlIWlhtRmFSSnpHK21v?=
 =?utf-8?B?S1BsZ05XT3gyVVZ2RVBUZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGlTNThVZ3BJeDF1NVY3eTJMY1JRNzNLMUtZSFFkbDlnYnJYczQ3eDlVMEVL?=
 =?utf-8?B?RnZVK1YzUHljTWJicEJIbWZQbGpWUS9Rb1o2TTdiR3d6QXlCTExHUnNzU01l?=
 =?utf-8?B?QytHaUVsZjZYLzFRaGE0N0hIU2RmREFJeDZQUmhVOTBPNk0wV1ExQ2RkZnIy?=
 =?utf-8?B?c2hKU3hYVExNSkg0WGVDb2NKVk5udFowWC9ldGNnN21teGlhZ1lOaUFSNnRV?=
 =?utf-8?B?Y3J0NmZ5dlZLT1VkS2ZiMmR6OVR0QjRUWnZaeE4wWGVwK0FyWElyRzBWb09H?=
 =?utf-8?B?QWpqZlIvN2VqbG5hVGFvbWpmZEFOSWJLSWpUWFFOUy9HZXRtYjZJT0RXanVP?=
 =?utf-8?B?VVgwSjhMajNjS29EbzlEdEdvbEo4dkJ6Z0taQnVJQTFUYjJIUWYxTnExN3Vt?=
 =?utf-8?B?djV5TDZ3Ny9uOGU0ZFJ4bTEvZGtXVVNXaG9qYlNjcXV6VU1SWlNXWGtoTjc4?=
 =?utf-8?B?ZGxJbGtMZ2RmSm9CbEtBMlY2V3k0bW9halJTNGh5NW1ESDJnQVYyQXlRYXpM?=
 =?utf-8?B?RTJHRHNBTWFNMldxT1FUOGNqbjB4Y2xydnpHam12YkFBaTFTSDZOc2dSVllI?=
 =?utf-8?B?MzZsbEZMWFJLd3cxQUFOeDgxeW9xbGhkMXFFVllZdDRxU2Ruazdvb1JGa016?=
 =?utf-8?B?aDR6eTNtSENHbjlMeDF4VmdreUtua05DeDFPaWhtWXJwRE1MYUZibE5YclZl?=
 =?utf-8?B?M0JhOTJoOUt0R0k2QVE2OGtMRmhBaGVjT1RBM29EcE9JeUd1a0gxWSs0TkNQ?=
 =?utf-8?B?RXlaSjFRZnNhT0l1N3l2RDJxM0pJY3VGRVZsQjQ3VTVlYlhhVEVYRTdJTTZW?=
 =?utf-8?B?OW1UZVRIb2J3VUJhNWw3MW9kcUU4VFpMczRQa3hUS2w3MS9oL1pJdUFvdEJ4?=
 =?utf-8?B?TFhRWjRuTlN6VnZyWjFMV2hRd0JCdW5HeUJXVHNqZTNadDBMampxeVloc2xX?=
 =?utf-8?B?ZkRRVnI5R2w0cS8xV3pQRFRpNWxSVTBWb3NZUENMaWk4K0cwdmY3SkMvRDhX?=
 =?utf-8?B?cG11b0c2MkZpaXljQW0wTVNHa2srSHo4SGMxa3RTalVKeFV4VHNWS2VPeWRM?=
 =?utf-8?B?ODk5S2NTZGdOVmNpWXBUc3U5VVpnOWJXRVdyWlIxRmxNdHZUMmZLK252N0Ev?=
 =?utf-8?B?RGJZMkxKR1VMbTdJL2FlUVZKcGZ6VDNBWDhPang4VU9XV0JIM1kwcE9OQm9h?=
 =?utf-8?B?UmgwS0djZWk3bVlSZXVZczBhNElYOXZRdHZlNVlQdkFORDcxUzI4aE1tVmlG?=
 =?utf-8?B?SVJJSUpNRjhQNW9TT014TDNZellQcmMzVzdreG1yM2FzVHUxMkE2MlRxWlJn?=
 =?utf-8?B?VzAzWnVTRVZyUGZjU2dQTmpkakNpWU92eDZoT1lVT0FrUXhpMmt0djhxRjFN?=
 =?utf-8?B?Vi82aVU2Sm94TFVXdHNEQjdDc0k3YUNiRUlQTXNGZVkwQ0dVdVpIa3dyY1hZ?=
 =?utf-8?B?TWJUV2IwUlVaOTZtL2J1RnhtMmVYVE5seXRwN0szOWJYdy9PYjByV294cW9B?=
 =?utf-8?B?TUhZc3dNNGRpN1pidkFKMVZ6VWE2c2lvRmp4dU5UdmpwcFczcCt3ZjZPV0No?=
 =?utf-8?B?Mm5lUzVJWTkyMFR3Mzd1K0hPRHlRNnJSTnpXVzJ6V0lTRW5ESnZRUk54N2JX?=
 =?utf-8?B?YmVVbVoxNmlpUWpXOHZFWmdCU3BwNmFQcnZKWVJuMVNQSVhnMU4vOEdPRHBE?=
 =?utf-8?B?NG11d2JseU80M3RLdXQxSENNYVNaRVRSa3FtbEY5QmxMajNZWmJCS2pabnIx?=
 =?utf-8?B?enl4VjhMSDJSMWorQXllVEYvWjFxL0pmUnlleS9rMWw0NExESk5lRloyTDdo?=
 =?utf-8?B?YzIrV3F6UGE1T3M0a2s0SGNTNVRNc2h5UXNqM21Tb2p3eFh5MTl4ZWdSc1Nh?=
 =?utf-8?B?eXhVeVF4a3VLTUJtYWI3MktTV1dpMWFZMG1NaW11Q21kR3BrbkpyRzFhbWUr?=
 =?utf-8?B?K0FNNnVFeDZRekVrMEdrY3Bwd28yaWViMXRKVkZJRC9iT3hEMk5KYWFMNGpv?=
 =?utf-8?B?b2JqVVU4SW5kVGh6L3ZNZGF6ZFNwa1hSUGtrV09VckJjZDMxc1l6N282RWdC?=
 =?utf-8?B?N1RVTnFJSHZlaXRuRU5UWlo0SEEzY2lTTXIvNFE4TExqYmtwY3dUdGdMeEJF?=
 =?utf-8?Q?9SV9ufJru3YL7IIgZw4xDa6Pp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b19963-b6f3-485f-e460-08dc7aeadafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 05:40:29.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WriV9+nwblwDXxvrNuuJn3/5BehzJFy4sIi7qPeWciUGmKvw6vbwaq2r3OlRqmjwO3qheN8srsXmZtZAOrnYIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXkgMjMsIDIwMjQgMTI6MDIgUE0NCj4gDQo+IE9uIFRodSwgTWF5IDIzLCAyMDI0IGF0
IDAxOjQzOjQ1QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTogSmFzb24g
R3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDIy
LCAyMDI0IDk6MzkgUE0NCj4gPiA+IFZJT01NVSBjb250YWluczoNCj4gPiA+ICAtIEEgbmVzdGlu
ZyBwYXJlbnQNCj4gPiA+ICAtIEEgS1ZNDQo+ID4gPiAgLSBBbnkgZ2xvYmFsIHBlci1WTSBkYXRh
IHRoZSBkcml2ZXIgbmVlZHMNCj4gPiA+ICAgICogSW4gQVJNIGNhc2UgdGhpcyBpcyBWTUlELCBz
b21ldGltZXMgc2hhcmVkIHdpdGggS1ZNDQo+ID4NCj4gPiBJbiB3aGljaCBjYXNlIGlzIGl0IG5v
dCBzaGFyZWQgd2l0aCBLVk0/IEkgaGFkIHRoZSBpbXByZXNzaW9uIHRoYXQNCj4gPiBWTUlEIGFs
d2F5cyBjb21lcyBmcm9tIEtWTSBpbiB0aGlzIFZDTURRIHVzYWdlLiDwn5iKDQo+IA0KPiBOb3Qg
YWN0dWFsbHkuIEkgZ3Vlc3MgdGhhdCBzaGFyZWQgVk1JRCBpcyBmb3IgQlRNLg0KDQp5ZXMuIG5v
dyB0aGF0IGlzIGNsZWFyIHRvIG1lIGFmdGVyIHJlYWRpbmcgbW9yZSBjb250ZXh0Lg0KDQo+IA0K
PiA+ID4gT24gQVJNIHRoZSBTMiBpcyBub3QgZGl2b3JjZWQgZnJvbSB0aGUgVklPTU1VLCBBUk0g
cmVxdWlyZXMgYSBzaW5nbGUNCj4gPiA+IFZNSUQsIHNoYXJlZCB3aXRoIEtWTSwgYW5kIGxvY2Fs
aXplZCB0byBhIHNpbmdsZSBWTSBmb3Igc29tZSBvZiB0aGUNCj4gPiA+IGJ5cGFzcyBmZWF0dXJl
cyAodkJUTSwgdkNNRFEpLiBTbyB0byBhdHRhY2ggYSBTMiB5b3UgYWN0dWFsbHkgaGF2ZSANCg0K
YnV0IGhlcmUgdGhlIGRlc2NyaXB0aW9uIHNob3VsZCBiZSBvbmx5IGZvciB2QlRNIHRvby4gdkNN
RFEgaGFzDQppdHMgb3duIFZNSUQgcG9saWN5Lg0KDQo+ID4gPiBhdHRhY2ggdGhlIFZJT01NVSB0
byBwaWNrIHVwIHRoZSBjb3JyZWN0IFZNSUQuDQo+ID4gPg0KPiA+ID4gSSBpbWFnaW5lIHNvbWV0
aGluZyBsaWtlIHRoaXM6DQo+ID4gPiAgICBod3B0X2FsbG9jKGRldmEsIG5lc3RpbmdfcGFyZW50
PXRydWUpID0gc2hhcmVkX3MyDQo+ID4gPiAgICB2aW9tbXVfYWxsb2MoZGV2YSwgc2hhcmVkX3My
KSA9IHZpb21tdTENCj4gPiA+ICAgIHZpb21tdV9hbGxvYyhkZXZiLCBzaGFyZWRfczIpID0gdmlv
bW11Mg0KPiA+ID4gICAgaHdwdF9hbGxvYyhkZXZhLCB2aW9tbXUxLCB2c3RlKSA9IGRldmFfdnN0
ZQ0KPiA+ID4gICAgaHdwdF9hbGxvYyhkZXZiLCB2aW9tbXUyLCB2c3RlKSA9IGRldmJfdnN0ZQ0K
PiA+ID4gICAgYXR0YWNoKGRldmEsIGRldmFfdnN0ZSkNCj4gPiA+ICAgIGF0dGFjaChkZXZiLCBk
ZXZiX3ZzdGUpDQo+ID4gPiAgICBhdHRhY2goZGV2Yywgc2hhcmVkX3MyKQ0KPiA+DQo+ID4gSSB3
b25kZXIgd2hldGhlciB3ZSB3YW50IHRvIG1ha2UgdmlvbW11IGFzIHRoZSAxc3QtY2xhc3MgY2l0
aXplbg0KPiA+IGZvciBhbnkgbmVzdGVkIGh3cHQgaWYgaXQgaXMgZGVzaXJhYmxlIHRvIGVuYWJs
ZSBpdCBldmVuIGZvciBWVC1kIHdoaWNoDQo+ID4gbGFja3Mgb2YgYSBodyB2aW9tbXUgY29uY2Vw
dCBhdCB0aGUgbW9tZW50Lg0KPiANCj4gSSB0aGluayBKYXNvbiBpcyBjb21wbGV0ZWx5IHVzaW5n
IFNNTVUgYXMgYW4gZXhhbXBsZSBoZXJlLg0KPiANCj4gQWxzbyBGV0lXLCBJIGFtIHRyeWluZyBh
IGNvcmUtYWxsb2NhdGVkIGNvcmUtbWFuYWdlZCB2aW9tbXUgZm9yDQo+IElPTU1VX1ZJT01NVV9U
WVBFX0RFRkFVTFQuIFNvIFZULWQgZHJpdmVyIGRvZXNuJ3QgbmVlZCB0byBob2xkDQo+IGEgdmlv
bW11IHdoaWxlIFZNTSBjb3VsZCBzdGlsbCBhbGxvY2F0ZSBvbmUgaWYgaXQgd2FudHMuIEFuZCB0
aGUNCj4gVklPTU1VIGludGVyZmFjZSBjYW4gcHJvdmlkZSBzb21lIGhlbHBlcnMgaWYgZHJpdmVy
IHdhbnRzIHNvbWUNCj4gaW5mbyBmcm9tIHRoZSBjb3JlLW1hbmFnZWQgdmlvbW11OiBhIHZpcnR1
YWwgZGV2IElEIHRvIHBoeXNpY2FsDQo+IGRldiBJRCAocmV0dXJuaW5nIGRldmljZSBwb2ludGVy
KSB0cmFuc2xhdGlvbiBmb3IgZXhhbXBsZS4gQW5kDQo+IHdlIGNhbiBhZGQgbW9yZSBhZnRlciB3
ZSBicmFpbiBzdG9ybS4NCg0KdGhhdCdkIGJlIG5pY2UuDQogDQo+ID4gPiBUaGUgZHJpdmVyIHdp
bGwgdGhlbiBrbm93IGl0IHNob3VsZCBwcm9ncmFtIHRocmVlIGRpZmZlcmVudCBWTUlEcyBmb3IN
Cj4gPiA+IHRoZSBzYW1lIFMyIHBhZ2UgdGFibGUsIHdoaWNoIG1hdGNoZXMgdGhlIEFSTSBleHBl
Y3RhdGlvbiBmb3INCj4gPiA+IFZNSUQuIFRoYXQgaXMgdG8gc2F5IHdlJ2QgcGFzcyBpbiB0aGUg
dmlvbW11IGFzIHRoZSBwdF9pZCBmb3IgdGhlDQo+ID4gPiBpb21tdV9od3B0X2FsbG9jLiBUaGUg
dmlvbW11IHdvdWxkIGltcGx5IGJvdGggdGhlIFMyIHBhZ2UgdGFibGUgYW5kDQo+ID4gPiBhbnkg
bWV0YSBpbmZvcm1hdGlvbiBsaWtlIFZNSUQgdGhlIGRyaXZlciBuZWVkcy4NCj4gPg0KPiA+IENh
biB5b3UgZWxhYm9yYXRlIHRoZSBhc3BlY3QgYWJvdXQgInRocmVlIGRpZmZlcmVudCBWTUlEcyI/
IFRoZXkgYXJlDQo+ID4gYWxsIGZvciB0aGUgc2FtZSBWTSBoZW5jZSBzaGFyaW5nIHRoZSBzYW1l
IFZNSUQgcGVyIHRoZSBlYXJsaWVyDQo+ID4gZGVzY3JpcHRpb24uIFRoaXMgaXMgYWxzbyBlY2hv
LWVkIGluIHBhdGNoMTQ6DQo+ID4NCj4gPiB0ZWdyYTI0MV9jbWRxdl92aW9tbXVfYWxsb2MoKQ0K
PiA+ICAgICAgICAgdmludGYtPnZtaWQgPSBzbW11X2RvbWFpbi0+dm1pZDsNCj4gDQo+IFRoZSBk
ZXNpZ24gaW4gdGhlIHNlcmllcyBpcyBzdGlsbCBvbGQgdXNpbmcgYSAxOjEgcmVsYXRpb25zaGlw
DQo+IGJldHdlZW4gYSB2aW9tbXUgYW5kIGFuIFMyIGRvbWFpbi4gSSB0aGluayB0aGUgInRocmVl
IiBpcyBmcm9tDQo+IGhpcyBTTU1VIGV4YW1wbGUgYWJvdmU/IExlYXZpbmcgaXQgdG8gSmFzb24g
dG8gcmVwbHkgdGhvdWdoLg0KDQpJJ2QgZXhwZWN0IHNvbWUgZGV0YWlsZWQgZXhwbGFuYXRpb24g
aW4gdGhlIGNvbW1pdCBtc2cgYWJvdXQgaG93DQpWQ01EUSBhY3R1YWxseSB3b3Jrcy4gSXQncyB1
bmNsZWFyIHRvIG1lIHdoZXRoZXIgdGhpcyAidGhyZWUNCmRpZmZlcmVudCBWTUlEcyIgdGhpbmcg
Y29tZXMgZnJvbSB0aGUgaHcgcmVxdWlyZW1lbnQgb3IgY2VydGFpbg0Kc29mdHdhcmUgZGVzaWdu
IGNob2ljZXMuDQoNCg==
