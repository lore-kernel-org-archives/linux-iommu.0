Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF63200A0
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753749; cv=fail; b=tXV1j0L6Zcy2FF6yNf1Cy/7qooC/Mmmk/8C6fgyn4I0kVAQ28KRTZ6yxlTsEGI5yUNwFu5sN96ChdsyID4YgTkYBusZUuuPAB08L1Mnwc7BpqU+kKto2/2OycxNXqLnJDgdmMOTRXypU4l5ce2K2JmfhsA0AP5EG0QXFeJkf7iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753749; c=relaxed/simple;
	bh=nogQUBzBg9/vFIjL9inZt8X/fhgmaUAU1AJrD+2mZq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VkCMQvU1S6cC9cf9crk6Ly6GKH8fbnKpEnzOcDZjmkYcfx2ucmb2CFPVK6CFFjsdPGZWQfsyqNsf57IG9+sQJ0yzYQl6kc3aCeVgyIm4DexI3KnlyysuXbMRclMzZSfIJa/bQpjn/+t3d4hQ+3dlIlVfAxrPDbo+6ZjsiS/bmDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFRldzXi; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFRldzXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717753747; x=1749289747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nogQUBzBg9/vFIjL9inZt8X/fhgmaUAU1AJrD+2mZq0=;
  b=iFRldzXir7KL+N8KO1ZttyYBxbcy/SAF0H9aeERc5q5+F72Pb6zE6rWP
   m03TC+GEfHfS7yNK8mXwgjAYJj074JZpQTcjdsGzt4NxFWmW/K+MIGyO5
   v84b2Tc5CQbIJG0D6dL+xpsplj+/LW4JSbZqekqL/Yyg2fLVf4fiixCMI
   ydklA/ht9IlkXLnMn6VD7K5gtxS+nVg/9AI7fcXJsHvBeUbrxs7aFm5DS
   dKigzl3kFzyzen1KyBGj3rX9PLdBPYUhTlqb0VVuj3HN05aDdCas4e2hE
   WeDGsgIxGwB0P3L8/1sbQY7hZdM8qdhpno7ffeZUwDMA+GkdLMnegoE1e
   g==;
X-CSE-ConnectionGUID: gueE4GfoTKKEvLO3Zj1A+w==
X-CSE-MsgGUID: YWSg9eYnQMKthqhRtaGaZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="11961353"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="11961353"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 02:49:07 -0700
X-CSE-ConnectionGUID: 0ip+3dmwSveasAyog71G6Q==
X-CSE-MsgGUID: TNb+Eh4kS82ywA3Vs9DnqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38841005"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 02:49:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 02:49:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 02:49:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 02:49:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 02:49:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKf3BTV5GT2TKtTPn0/bNJkpjDUh7Nwcs3grzIyqpooakC+pZxInYS5ihOZFeHEyGsontQx12iHxPLVNVjQYixq1Ang7suQW7tMOziY2cmGZmUdxUlTnetLHFN0KQi4UPvTwIyIUU/9M7wgAOJ4iR/cRgcxwAECkfJPHI+y/tp4wJzkZMEXs7DxmnSHCtUNvtoqeq8EZJEPoWgFlbkC3rAPV6LQuMBmrz9TrMz+ZzHt7SMLTQtM4mG3bmEgMHR8I6uAA6SnH7eL3J/lOoY2vpCScvgeGXQBrnzSgNk4RvoGXE7737QL4iZ4IRe70yNIukInWE3MvoebZE6bXYPVYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nogQUBzBg9/vFIjL9inZt8X/fhgmaUAU1AJrD+2mZq0=;
 b=Q13ufVwaNtEDr0LSNPwkGnd/z0thAHQf9UneOfUANfO8iptswnNHASKRAqoqIbYoNNkD6xDMr7SkZlJWnV8E1v9+umSXMNDea80a/pZ8CTatZoEoxSdFb1UHNic7GdA5WkVqBYQnugzFxpxD3MTQHSTynb839tuRmC4POnHx4jtnkx/graF1gosoeWrYbM9vdIZ2sOPjpa/q0uOYZcKhHvnbgRyBCqDml5bb8BHn0tRsGGHIUw8/gYHBCKT0+WmUwoiDgNwMEWZ/mDQakphTqCP+pog4m4vpE+vPcAQTjM79edW7tuyLBoho2nUyW1g8JCD8bOhKqWt2q0m0uGu5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7771.namprd11.prod.outlook.com (2603:10b6:610:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 09:49:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 09:49:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "mshavit@google.com"
	<mshavit@google.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhukeqian1@huawei.com"
	<zhukeqian1@huawei.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH v5 0/6] Add IOMMUFD dirty tracking support for SMMUv3
Thread-Topic: [PATCH v5 0/6] Add IOMMUFD dirty tracking support for SMMUv3
Thread-Index: AQHauBYzumtSIW1XCEit00mOtubBCrG8D3ZA
Date: Fri, 7 Jun 2024 09:49:02 +0000
Message-ID: <BN9PR11MB527624894AA8D51FCC4BCF7A8CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7771:EE_
x-ms-office365-filtering-correlation-id: fbcf68ff-932e-4f67-54d2-08dc86d7103e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dVNFN0o0UlBSOTc1S2VJbjVTbzF2QmNhZThXZmNWZmNSNHAyQTg1VnQvZDE1?=
 =?utf-8?B?WGs4emxXYytRNTR2U3RZUEZvQlFzZ3dvZmJjVjBpYWVXc29sQm9ud21HZXU4?=
 =?utf-8?B?WllTOUpobHRrclhsckNHZmMxSm9JM0pnYXRYaXRYVGlJY3BjeHdXSXk1M2JV?=
 =?utf-8?B?VmU4QytmSUljY05CRHdVczlhNzRnaDFuUEdabnVrMjdLMDBremxRSk5peURP?=
 =?utf-8?B?NUlhUXdaenNJS3EwZGR0UnhmNkJ2T0h4em42VmpSWlRNV05NRTQ5aVF3NStx?=
 =?utf-8?B?RWVrM003Qm1LTnREWml1bld5d0JBMExsVnlWZXE4Wk5obERweSs5MjJrVTd6?=
 =?utf-8?B?Y1FqdGRYZmYvcU1NM3AxcUVKS1NvMjEvTFUyU1I4a3k0S1plaFJ2bkVKZnc1?=
 =?utf-8?B?OThFTnQ2Q0RRb3NSd3BtK3R0c3ZFT1FEUVJHREVxaXNzanEwRlJNSFBub3RY?=
 =?utf-8?B?TDBoWDVFZDdkZUk2S0hFNFpZeE9LbnFHb2Myc1N0WEx3WnVXVlhmZURGY3ZI?=
 =?utf-8?B?ZkxHeFRFUXVoc1lEZy8vbU9EZ3gwNzRIWUczd0ZuUGhCMnZRcWIvbDJteGk4?=
 =?utf-8?B?UFlpMHJrbDRFNWlCeXU5OXlpbzExb1BMTU02a2dTL1p6Skp4WitPOXBPSmk4?=
 =?utf-8?B?UzdVbTJVNHhtTmlNNFltSU1KWGhEMk5LNEI0bldFQ1k0YmNtOTBEb08vU2Jp?=
 =?utf-8?B?N2hXQUtQM2V1YmRDYlIvTytvNXc3QW05Tk4yWkpaeVAzdnRMMHRjYmVBSkVp?=
 =?utf-8?B?cmNlNzM2V0lLVGJvWTBCK21ZaGZndnR1cE9ZbWgwVkNKSXZXV3U1MXA4UVZ6?=
 =?utf-8?B?S3J4aHBETjhJek5pVE9aSk0xN0VhYmpWZndxYXI1YWpTRmUvRzM0QUVBTTE2?=
 =?utf-8?B?TmdoWDIxeUNyODFpSnl3bG81QjBHb0tCdlRxRWNRZndyQmFSYVBSSTR1SGtV?=
 =?utf-8?B?YUZTWlhKM1NLM0dYTmlrN200UGFxaWN2cDZZV1pwdXJ4anRUL3pFTmtYWDhu?=
 =?utf-8?B?N1NzamZHVkhNZDh5N05WYzQrS1J2OFZTZ3dyZ2xxY29EWCtFZE11SHY0ZUdn?=
 =?utf-8?B?SWtzdmVIWFJXU3oveEJuU0c1M3kza21LYVFPZWFCSDBzK1pGNWxWWjl5WVhy?=
 =?utf-8?B?K3liYTdQbWV1bmwzVDFiTWsvSGhNdzdZOVVEempmSDhYajZ5aXFuV0U2NDU4?=
 =?utf-8?B?M1VBcCt1TU5GWVRzR2gvZEtpVmlucjBYZndrS2hlSjRyWDlLUHBFUTFkenJw?=
 =?utf-8?B?R25Hall0bnM1WlJIcUQ1eFUwdDk2ZWR0SFJ3dlNidW9uZ0RaclVxbjVaZCtp?=
 =?utf-8?B?Sjg1ZEVtQUE1TXlUL1h5RHROdFpOSUtTYVJNZHBUSjE2Z2kxNm1ONzkvc1pC?=
 =?utf-8?B?eHZ3RHh2SEt4cG00VVFTLzlLWEdlZjkxUndUWDJFT0dYNFZCejdpcktIZi9R?=
 =?utf-8?B?aUVBUUxOdWdqVUV1U1N1QUhJMlo4Mmp5anFJTDBnWDA3ZmJLdUJTbXZzZ1lH?=
 =?utf-8?B?WXZZNXpqVkR2WTlYQVpzcHlGL3NoY0FwR0JvT2RiSkQ0MVJOY3MyejdVdUFa?=
 =?utf-8?B?dVpKTnV6SkFkVUl1ZFdISWtwL2RRRGZETUZRdHF5bjUvb09BM1ljVkNtZ1Q5?=
 =?utf-8?B?WlJxczdJa2xjVGpTKzNZNnE0TnVpQ0VrWjZmZURHaUo5bzJVZkNxTGE5OC83?=
 =?utf-8?B?cEVCUm9lTFhGaS9VczJvbzZKaHZmamtHNlZiR0daNG54VzExRUlVZmxsd0Zi?=
 =?utf-8?B?dnlzcXRRMjJUQ3JJL0hnVnRHVGhVbGlzcU5NQjBTZi9XZkpaNlZyYU5ZaUxG?=
 =?utf-8?Q?hu7+J/zsj/ibHRfVQutjNdAjQp2S7hQn1mL5A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1EwN1UrQlU1VmU3ckZJVWZnQlFDNTJGbk02MG8yMTYvVGdLZHlOdCtlMjNK?=
 =?utf-8?B?dkFqMUtLNW5SUmZpSTNkY0VsU3ZsSFljYjB2TFh0d0lwZk1Mb2luVmtDWGtw?=
 =?utf-8?B?Vno3bVpXdEQ5QThpWnBsOWxIR2NKZjdQUnlYTU8vaEVLZnp5cmhmMmxsU3R4?=
 =?utf-8?B?bjFwQW5vSktIaGxHOWZXTjFTV1pVWTl2RlhNNEkyMTN0MERma3NRcGhsTitj?=
 =?utf-8?B?dXZKU1RpSkZac21rbUIrTk5PKzBrdmZNWVIzZDd0ZVQzWklldjN4SVpVR0Fp?=
 =?utf-8?B?TldneXY5OWg5OGt0ckZlVU9XOFRYR0JLUGFiVGFjVnFOSklwL0lLNS9yOGcx?=
 =?utf-8?B?cTI0MnpHc2NSRTBFZVZqUC8xK05OM1M4emFub0QzdjEvNitYUGMzTHhLR245?=
 =?utf-8?B?Nnd2cEhnOFc4Z3dMM1ltc0daRTkzM0ZIdGxBck9oR2QwMVZPME9ubVNrbDBK?=
 =?utf-8?B?MkN2SnljeFpSNHVyamFacGliNUZLOHZab2RmZjhvNjMwbFdQdHFhU3ZGdGxG?=
 =?utf-8?B?TXF0SEtEUi9DUjYyT01nbHUwWm9VMmFCd1NkYWViUVBaQ25qMDNrMXBXTStl?=
 =?utf-8?B?N2o4eXUraHB1LzM5ZlZiVFNXVS9JWHptdlRFVzZXaWhYRUFRbGgybVdOdVpF?=
 =?utf-8?B?aDZuUkQ4bmluNFRadEpaOVRvVk1YbG9oOFRKaEFxbnZ5WStNWVhrOFhzZE5l?=
 =?utf-8?B?QWJGSG95ZTJseGM0c1BtWm5zMjYxYWR2VlZmd2N2ZUFTV3R0eFp6bDVORXQ3?=
 =?utf-8?B?T245dUFZcDlpNlM5d0FYTm5SNEdWT0NYVkRWSlArUkIyWitrYnhQL3p5cnNL?=
 =?utf-8?B?LzdtWFQ3UDFrK0NxY2FveVc3L3BhNGMzb1dBMURrczFsWU54ZVJmNVZJMnIy?=
 =?utf-8?B?ZGxsRDRlQnkxeWJqd3k2VFg0OHJoS1h1VHRjc0NFUmNpcE0xSmV5M1NEdmhh?=
 =?utf-8?B?b0U2UHJ5cnYvSjM1Q0VsMGcveXNBSVZOMkU1ODNObXoxeExaRmU5NEpBQXB6?=
 =?utf-8?B?V0Jva3NKQlhUOGI5MEd0dDgydTVJbVZ2V3hEUUdoNG1yczRHV05iV3pnY3Mz?=
 =?utf-8?B?ZURQQ044aG1xK25zWENrTXduRm9LcHliNlFBS2VDU0RieFM4M1BEbHlVZm5G?=
 =?utf-8?B?MGs3T1RsVWdLOWJ3Q1kxd2Y0bndZY1AxQi9QeXF2MEFrVzhlc2pGSmVHS2dV?=
 =?utf-8?B?ZlRoSHQrTXM3YkNlQlVBVC9jWjBnMGt2Q3EzZ0p2QU12S3p2Qk91eW0vVW9a?=
 =?utf-8?B?eXpLNU5iSUxFOWR1UUZPSjNHaWZWN1lsVFU4dXY1aFQ5c3l2RkwzQU50UXJR?=
 =?utf-8?B?am03MllXNVZib0c4a0l4c0F1RW1wcnlMWjAxZURvcmYvUndaZ1huUU1uVmJt?=
 =?utf-8?B?YU5sSmUzVms4SzBkbk1BSS95clhzZEptanhab0dGTGplLzVKSXI1U1FKbDAr?=
 =?utf-8?B?NGlnY2VNT0hOZmRkZm1LWFVsU3kyVEt4SUJya21BeitVOEkxclR0Y0g3Qm1B?=
 =?utf-8?B?bkhrMW5wMElibEY4UEkyUVp4aStxbVRlMEg0SnkxeFBRbzN6a3RGb2NVRFJS?=
 =?utf-8?B?L1NSbnNFaFVYd3MyN3ZpS3JDOEJIWEdOL210T1NuVFJKSEVieDZNbmdzZ3cx?=
 =?utf-8?B?MzVJQ0ZhNXdpekRpM0c1b2ZYUVoxaW1aZWJzSW1nWWtmV0FWcmJhM2NXWjJO?=
 =?utf-8?B?OTJqWnpmY3RyZnJlL2tUbklPaGRxVENkc3JLbVhOdktqM2VTVTR2N09qbE1r?=
 =?utf-8?B?L09xcVlEbnFySmRvWmdzUmxScXVEVFhnU1dGcjE5ODBQTEFLY0hveEEyOW81?=
 =?utf-8?B?QkJQRzExVFhNSVkvMHp0NmVQWTBSNC9OQ0RVMlNjL3BlMGIyUkcrbjBHMnlD?=
 =?utf-8?B?REV1UGRCdEt0Z3VlVE1OZDRHUjExL0xrTmdzQlJlV2NpblVSb2p4UTg4YnFt?=
 =?utf-8?B?QzMxaEFJMjJlZ0xTM1pRdHEwNkRQNGVvcnJYQnkrdjVsN3FtM21Mc3diV09m?=
 =?utf-8?B?M2JPWjRlbkZkUG1hbnFaaG95bzhYZTNFUnBlRUxoVFA0TXZwUU8rYlllM0Ru?=
 =?utf-8?B?dGVEYXppL2ZwdllkOHFzQ3lrbE84a0liSDVxb1NlR2FRUWJEc1pOUEJhdHEv?=
 =?utf-8?Q?UBVNwirTq3eYDSzlXDcwq4nQE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcf68ff-932e-4f67-54d2-08dc86d7103e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 09:49:02.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4/qLCdXlTnM72FT7Ui4M/sqBrt4e+UNZcoWHjZAy7i71wjmececDrp54uv9hrwAY29jOCcLofWuom0AQjyN8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7771
X-OriginatorOrg: intel.com

PiBGcm9tOiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdl
aS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDYsIDIwMjQgOTozMyBQTQ0KPiANCj4gSGks
DQo+IA0KPiB2NCAtLT4gdjUNCj4gDQo+ICAtRHJvcHBlZCBhcm1fc21tdV9zdmFfZG9tYWluX2Fs
bG9jKCkgcmVsYXRlZCBjaGFuZ2VzIGZyb20gdGhpcw0KPiAgIHNlcmllcyBhcyBzdWdnZXN0ZWQg
YnkgSmFzb24uDQo+ICAtQWRkZWQgUi1ieSB0YWdzLg0KPiANCj4gUGxlYXNlIHRha2UgYSBsb29r
IGFuZCBsZXQgbWUga25vdyB5b3VyIGZlZWRiYWNrLg0KPiANCg0KdGhpcyB2ZXJzaW9uIGxvb2tz
IGdvb2QgdG8gbWU6DQoNClJldmlld2VkLWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVs
LmNvbT4NCg==
