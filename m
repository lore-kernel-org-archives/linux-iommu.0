Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDBE200C1
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718855863; cv=fail; b=Di9jzcGbYwUOkesBOHitzZ87EklRKagJ0EsdDpWSkBeZT1dxwdSwsXwU1dfbfn7TU/2+wO5blO3sakM9kPcoRX20q+SZOGKurYX2PGnLH5/3fBiclVDKeQ0FUqOFHbRzgIM1lh4LsDE6TgKN13nkAY0YLvMP7dU69zTq8ZdnXOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718855863; c=relaxed/simple;
	bh=ZrmFaJhJWGfry40mXc6/mCtqQWdslWxOPVx8+i52ig4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=shiNXZmw70itYY/P5L281fQtBmHrXbd90gPhNSSEGTLfByfdjvK0K5w/HlrfbtE7ZJ32BnnHz6VVBlu19Psjseme8EepYLGxxmaUSOu2wYAXJyWJlb8SNzDc1ZJgEMXZZWD1mxJbiwA7ysb+MHkGlPls7sQ9gVikKiFeI+3JQ+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAqN6dMm; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAqN6dMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718855862; x=1750391862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZrmFaJhJWGfry40mXc6/mCtqQWdslWxOPVx8+i52ig4=;
  b=mAqN6dMm5CvlpsxC/hjS9Gmvug1hUP9qv7LYZ87sukW6euJC3iyAOHNn
   7yvvpu27AlSAcedHkA0DxUK5dvHHL69T7luCL3h5SGuNWba1AVq5ChxZZ
   pqliIVntxBSDV7BvALFO4az0KYsV3vieK5ZAkqSLyj7GyjvhonICQYcIT
   r99z2u1XDvkTN/EjICUgqYtsZbf6hC26YbyUKTMNMEc9yI+4tjlCYjvjT
   E+AMs3ZVWf0PV4BiJ9qRQSZtjkiDhVmbYXGDvEua7wIJv5Qm9SupUpdEz
   pVSbaYvp0Zvdexv5mGtgDwpWzhdku63wBvADKa9SU+nSHYZF+JcV+scpc
   w==;
X-CSE-ConnectionGUID: b22SvBWjSrCjBam5gDyNPg==
X-CSE-MsgGUID: iGyDzCraTQKDucsy1VGoEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15931875"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15931875"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 20:57:42 -0700
X-CSE-ConnectionGUID: +4feeK3bQ7aXwKYcIXmyEg==
X-CSE-MsgGUID: QAfg4HjxTW2Cf2iQQE8M3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="41927191"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 20:57:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 20:57:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 20:57:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 20:57:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 20:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EN9oaEr9V/Xop4sVXvB0vvw5d4oTps7inPVHP3sJa7bbSz0qTOJpMU/RTAzCXsy/Z0P/dbfqcHt3KKy/HLMy0p9//tM7eID/8aQJijDYqbAB0/qtEwySfKhyJ3m2OCfy5LNgA203FohGeuFd8U8ak19ExnIkpL/ylMSogc17fTt2BBl0AVOf/oIWW1RHm9VZ5Q8V1Cwo6aFwJsCTvbzJlFyov/ERnFlacurwr+cTapH+tOnFwIDwtCsy+f/xCzMB/dMONxW4yaannaX/HzqAiYsmQ55r3KfhssCSje6MgsxjxDTxzZgjYL/d6FGSuDQIeGT1E8bfP7Xc1stE2nRVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrmFaJhJWGfry40mXc6/mCtqQWdslWxOPVx8+i52ig4=;
 b=lAoezkrKQua2eI2REbjn7bqz9IpkLUCnXbNMABmmyBEMvMWtZe7FKhNE+3lFg4QsKT80+NHmTUtaxc8E6QN1xL4PkK0ycEv+uWRGSSgIedyASb2y9L3vnPlI/CRmUpTWZuZrmAdANWDkT1VF/nmT+dnVU/ibdoBVsqe75Y+xXLpPq1Q24yDoRv7GFv5K/fBzQtImZbT3hDWQJaLP5HZPOjopuuWuwjhsvENDlKB/7xXvTp4Tu4Qk4RiHAKZ2tqFyQGzIC96jomlsZtrB+x6tRX9gUC45XVFGTJvEYrWqApK1appQyt8bLQr8xvU2B45ARJ/Z+BMItUTTem1Hww0LqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7951.namprd11.prod.outlook.com (2603:10b6:8:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 03:57:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 03:57:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jacek Lawrynowicz
	<jacek.lawrynowicz@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Thread-Index: AQHawevyEa4SaKI0hEeZkWqSILyCJbHPTJQAgACHMoCAACMPkIAABQmAgAABujA=
Date: Thu, 20 Jun 2024 03:57:38 +0000
Message-ID: <BN9PR11MB5276E106E53A3DFE184FEC698CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
In-Reply-To: <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7951:EE_
x-ms-office365-filtering-correlation-id: cb7319b7-102f-4266-255e-08dc90dd2032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?MWdMTlBnbkpkWldWZHBrN0p3bi9uTzZWNlFwVUZoN3lYeXVwSit3Nlk0T0lm?=
 =?utf-8?B?UDUwK0V2T2habWNwK2lLdHpRY3dMWnpXSGxEMnZHclZHWlRPVUhVWTltcjhh?=
 =?utf-8?B?d3g2S1diSGdGbzVudDlxNmgwTzdOY1ZDM0NiNnEwcXRMQTZpQVFLdEl5UE5Z?=
 =?utf-8?B?TWZ2WVViMmNDcGtuSi9GTEY0M3BhdWlqWmFEQVAxczc1OS9xWTlVekE0aXZO?=
 =?utf-8?B?M1daUWZKYmdxWXdEckw0Z215Tml0QlNucXdwb29tZGRNdUVFTVRUYjdQK2V6?=
 =?utf-8?B?d3gzOFMrRDBmanFQb2dkbGpXbVF5dUxkUTV4QldoaUp6ZzJQYTErYWd4VG9x?=
 =?utf-8?B?SmRodG9jTmpqUkk0NnFkN1BUWktGSm0vL2hudXVSc1YxVjYvQ2R6cXlmYmpi?=
 =?utf-8?B?YzJJRUUyWEQzbUVaOU5JVFVBZ0JQd3BHNUx4NzNSeFc4azFPNmpYeEJBQmh1?=
 =?utf-8?B?YTNyaTA3ck95WHhWb0J0bXpza0FQZ2VnZ0xLam9nTlhybE9Xb2V1aCtSL25v?=
 =?utf-8?B?d2Zkemt2bEl0TVdzY2RyV3VRdEt2R0pWbnJQSUlNTUNsTVI1aUkvbUlSZTli?=
 =?utf-8?B?dUV3OW9PZEpvS0ZzbGtWN1c4VGFDME5KcjJaSy96NWR4RFlRZHRFZGtHbDF4?=
 =?utf-8?B?REpoelVhbVNaNVJCakR3L0hPRFFMM2Y4VGY1eXRjWEhnR0dTYjhxS24wamQ2?=
 =?utf-8?B?S0F5cjYzbXBVcjhNdThWYmdleUI4RlZKeVBEdmJaU0MwZ0ViL2E1bzBOVlpu?=
 =?utf-8?B?Zm5vTHFKdmpOSURUNUhwSENscS8zeTRkMDhxZ3R1WEdhSEtkSTNwS2NWRy9B?=
 =?utf-8?B?YjcraWNiaDRQTXpHcE1JTUdaOWlSeWt5VmVXK1lyZ003TFcrbHhnWmJ4YVFI?=
 =?utf-8?B?bW1zNnVtQzhicDl2bEMwTm0wQS9UTnY4YlNOSUd0ckZ0Ly9HS2RTT09Iekhi?=
 =?utf-8?B?cjJ3b2FRMjJoblhyYURmSlNuVGpRaUhPa0YwSkFtZW5ZSDJLOWpMT2NNNWR3?=
 =?utf-8?B?UEFyb2RQZnVKaUJ1a1VPZzlpODdYWWNuVEg1ZkhkQjIrSnR6blVDM0xOWHVj?=
 =?utf-8?B?QnRHZzkrS3J1WDZtOTN4V3hjQ3k1Rjl2ZjU5Wk0zWFdaa0VwTXlTZ0hrNHV6?=
 =?utf-8?B?UXhCRFFPN3ZEK09YTTVQT2hhZ0lWN0RsbnUvem4zTEVTM2kxWnltZjF6L0dC?=
 =?utf-8?B?ZERHcUplN3V6MVB1Y0RyY1h5K2RTVWlCbVU5NXR1VUJsTytPMzFTQWc5YlRM?=
 =?utf-8?B?VmNPZHZ1d29kMXBFSFZNd1lWbTJaODBQSHRyNzM1LzNldjA5WHU0bkxtSmJP?=
 =?utf-8?B?Nmd4WkhybXhWamxTd3hOWjFxenBTeXEyVEhkVHoxeGd6cjQ3M1c4dnZ6ellp?=
 =?utf-8?B?R2lnazhiN2pROEtnQTVWdnFENUE2bnhXUWd0eVJtTjhWTkpiRm9DZ0U2dlF2?=
 =?utf-8?B?bDFJSXRjNXp5UFFQbzRZci90S1RMK1luUUhZN0xiaHB3aXFSRjM0Sms3YzZy?=
 =?utf-8?B?dVpyTmEwZ1BsUUl4TnV3em1iVUtBYUFSREY3Y0w1ZXhkTEhhQlFqU1VwcHBw?=
 =?utf-8?B?UVBDelNKZGZZWHBLMGJvY2NNVzNiZGlQTkJOeTdxVXNwUGoyL2RIQWw2aEI4?=
 =?utf-8?B?RzRnOG9zZE12eFRGdkUvS1dlb3ZwTWhuRXRiOUhqQTJQdTFzYzk0SHR0OXFo?=
 =?utf-8?B?SnVCUmRQdE1udU5KNHhPUFZvVXBWK2VVaGV3dS9MbFJ3VXYyWWdFT3VrWk5q?=
 =?utf-8?B?ZmIweTdIOFVISGpVT3Q5VllOVXV0OEhKd3dBSVhuNkJsakFiaEZjRHFyb0F6?=
 =?utf-8?Q?zLSXOhZLTZ6KRmkZNcTJKhNKfmC9COVDPAQq0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEtWS1Y3L2wvczE3OC92dGl1RnNtZUNGZndzVEE2RFBJNThyS2ZSVHZqV1Yr?=
 =?utf-8?B?b0g3Z3NVT3VJWVVsMWtIdElGb3VBM2s3UXdXRjVSOURRSlFIb3BycSt4UGJX?=
 =?utf-8?B?MUlKYmpreUl0ZSs1Mk9vcHpYQUd1OTROcnc2K2xCaGVEemJCeUdLaW81SG9q?=
 =?utf-8?B?VERjNEQ4L1g3aUk1amJRSTRQVjUwaFBtci9ORCtMS1pJaVJ6QktzTDdXR3RQ?=
 =?utf-8?B?U0dOd3VQRTZuVWcxcXE1bnRHYkJ5Zi82WUorM1NBb2VPcVN5ZllFU0QxWXV4?=
 =?utf-8?B?RWhOUktLSzZ3dTBvQW5GV1ZrUi9sV29uRTluaEY4dXBnSkhXVWRGcDVrY2k2?=
 =?utf-8?B?OTZJc3dENjd2VFp5UndnUExxNVlwczdxYW0weWpyMUVKVTBDWXh6MWdmZWs3?=
 =?utf-8?B?cDhtdzVobDZ0WEFkZDEvbDVxb3g2UEdtZHF0TG90RFRsZUdwMHRaNDM4V2R4?=
 =?utf-8?B?aThoKzNGL1hMcEpuRE0xWmJBcndDcE54WHJodEJMUjhMK0RrbnNSL0UvYmVQ?=
 =?utf-8?B?SnVVc05ubkJOc3VFb0w3SklFYnFsQ2pMZEwrWHRydTlWWk80VFYrUEZ1OHpW?=
 =?utf-8?B?Z1hqdFNjZVlaa005OUtrR05zOVJka0pOZ29pR3ZsdGZtcGRiUVNMcURxNnhn?=
 =?utf-8?B?WnhIclVpcHVDNllKMlZKTEV2VHhHUzVYUjBMNGZUVHJvd3BVNEgzWmE2Q3Zr?=
 =?utf-8?B?dFhCUXgwQ3VCc0lQMWRZeGFtR3hjWWxWb0RmK1FKdWxkWUJxS1hqVUU4SStQ?=
 =?utf-8?B?MWpTSTYreDhKMHUzdnpReHE2VWE3NW9Zd2pDdGloMFhEUUhxc3kvdGdKWTFC?=
 =?utf-8?B?SWJKWXpDU3dRcWJ6SHp1QXNsT0FOT3hqcEwwU2FudDRyVkRDSkk5M1N3d1By?=
 =?utf-8?B?NCtsWGc2RkdRaXpEdUpGdVZFZ2NzQ0x2Vm5QUUlVZzNhQWUwREFKOGs2NjZx?=
 =?utf-8?B?Y2gxSVhOaVcxR3hISFZINFd5cnN6TVZiSjBiZ2RpZFoxamNpSlVwMFBoTW9H?=
 =?utf-8?B?ZmJyOVNWZlp0Kzk3bUp1dlpqTkQ0eFhlN2NZaFpIUUt6Ri8rQkdLQTZQWXNu?=
 =?utf-8?B?bkhxT2ZjOXdBSTErNVZHOHltNlpZajgzMXVET1VpUUtaZmxLN1dIOWpHMUlV?=
 =?utf-8?B?RGJlc0tFUEtJeWVPRmZFencyd2JPQkIwOFExVC81Szd6RjVrNklJQ1BiMS80?=
 =?utf-8?B?M0JJalV5MG1hczdhblllZzZHNHNkUXcxQTljNnh5YmtqK1pnNWU5aE5jY25W?=
 =?utf-8?B?ZEM1WTUyTnB0MEFZK1V0N2NVbSt3Kzg1V3JuNzlHYkhHZHcrTTFvdVB3SnU0?=
 =?utf-8?B?V1ZXb1VzaHlZVml1WE5FMlNtY0xhRnlJYXBtZkNJTHNPODc1RGJObHRkSUZn?=
 =?utf-8?B?THVmRlljMDQ5eTdyVU5EUW1CVDlSWmNkcTRPeWtFNUpVWWpFZzBwY0pBZjZS?=
 =?utf-8?B?R1ZadU5uNHByOU9nT0Vjdm5SdXYwdlArNEwvaG5zRUN1YzFidWxDN0EveVhz?=
 =?utf-8?B?Q0JpU0NsVUJPRjhoZEErbjQxamZoa3QvalZnQjRvVng3WERGRzVzSlJOWlp6?=
 =?utf-8?B?Rk81cVI0T3ArYUZGelh4ejdwV0crTSsxS2JjUnlIcmZ2R3JNeXJXaGJYSDJH?=
 =?utf-8?B?d3hKNzNscnd2VzVqTStOOHVVTVA2akM1QzduelVPU25UeWI5NUlETDJYV0JE?=
 =?utf-8?B?dGZlZ1dwSFJYQ0szOEc2OE8vRkFVU2Q1Z3dXZjdNZUdpUWVHbi9qYlN2UmVN?=
 =?utf-8?B?bmtLRlB0aEFDeXVYRk5iV2VtWS8yVU1uZmNxendTc1lqTjlIdzlINm9OQy9s?=
 =?utf-8?B?U1FhVnlRalJaL0hHakhyWU5EajVEeHNaZDVwMVp2WGdMQm16N0VmYkFCcFU1?=
 =?utf-8?B?bm5ZMTlsMSt4Wm1wbEpILzY4cVRDSGh2RTR1NEtwT05VRjhZMC9NREkyZjhS?=
 =?utf-8?B?b1JzSlJiUnNJRGFhb25nSmRZakRmV1BhamNEWldZRTYwVzdka3JnVzFUMzNi?=
 =?utf-8?B?dHVUTUtneWJqQUZWVlJSd3lZcmpsMUF5OGxuTGlsdnR2NW51REJrRnFNS1kr?=
 =?utf-8?B?eEx5NDlmbkVxRE9UYWpkaVpZOHpWelB6d0gwNE8wZ2UwWkpRYUdMWUQ3dzds?=
 =?utf-8?Q?rnc/G0vYtnRPfLGpLdSxyR6Q5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7319b7-102f-4266-255e-08dc90dd2032
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 03:57:38.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMqab4MhCx+TObQaGfkXTeozG2kJPurJi8vN38BJZLIgDv+4d48A/qqppEjBmU/oLbxpijEXDYWRJQpiHTJNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7951
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVuZSAyMCwgMjAyNCAxMToxNCBBTQ0KPiANCj4gT24gNi8yMC8yNCAxMTowNCBBTSwg
VGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEJhb2x1IEx1PGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEp1bmUgMjAsIDIwMjQgODo1MCBBTQ0KPiA+
Pg0KPiA+PiBPbiA2LzIwLzI0IDEyOjQ2IEFNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4+
PiBPbiBXZWQsIEp1biAxOSwgMjAyNCBhdCAwOTo1Mzo0NUFNICswODAwLCBMdSBCYW9sdSB3cm90
ZToNCj4gPj4+PiBXaGVuIGEgZG9tYWluIGlzIGF0dGFjaGVkIHRvIGEgZGV2aWNlLCB0aGUgcmVx
dWlyZWQgY2FjaGUgdGFncyBhcmUNCj4gPj4+PiBhc3NpZ25lZCB0byB0aGUgZG9tYWluIHNvIHRo
YXQgdGhlIHJlbGF0ZWQgY2FjaGVzIGNvdWxkIGJlIGZsdXNoZWQNCj4gPj4+PiB3aGVuZXZlciBp
dCBpcyBuZWVkZWQuIFRoZSBkZXZpY2UgVExCIGNhY2hlIHRhZyBpcyBjcmVhdGVkIHNlbGVjdGl2
ZWx5DQo+ID4+Pj4gYnkgY2hlY2tpbmcgdGhlIGF0c19lbmFibGVkIGZpZWxkIG9mIHRoZSBkZXZp
Y2UncyBpb21tdSBkYXRhLiBUaGlzDQo+ID4+Pj4gY3JlYXRlcyBhbiBvcmRlcmVkIGRlcGVuZGVu
Y3kgYmV0d2VlbiBhdHRhY2ggYW5kIEFUUyBlbmFibGluZyBwYXRocy4NCj4gPj4+Pg0KPiA+Pj4+
IFRoZSBkZXZpY2UgVExCIGNhY2hlIHRhZyB3aWxsIG5vdCBiZSBjcmVhdGVkIGlmIGRldmljZSdz
IEFUUyBpcyBlbmFibGVkDQo+ID4+Pj4gYWZ0ZXIgdGhlIGRvbWFpbiBhdHRhY2htZW50LiBUaGlz
IGNhdXNlcyBzb21lIGRldmljZXMsIGZvciBleGFtcGxlDQo+ID4+Pj4gaW50ZWxfdnB1LCB0byBt
YWxmdW5jdGlvbi4NCj4gPj4+IFdoYXQ/IEhvdyBpcyB0aGlzIGV2ZW4gcG9zc2libGU/DQo+ID4+
Pg0KPiA+Pj4gQVRTIGlzIGNvbnRyb2xsZWQgZXhjbHVzaXZlbHkgYnkgdGhlIGlvbW11IGRyaXZl
ciwgaG93IGNhbiBpdCBiZQ0KPiA+Pj4gY2hhbmdlZCB3aXRob3V0IHRoZSBkcml2ZXIga25vd2lu
Zz8/DQo+ID4+IFllcy4gQVRTIGlzIGN1cnJlbnRseSBjb250cm9sbGVkIGV4Y2x1c2l2ZWx5IGJ5
IHRoZSBpb21tdSBkcml2ZXIuIFRoZQ0KPiA+PiBpbnRlbCBpb21tdSBkcml2ZXIgZW5hYmxlcyBQ
Q0kvQVRTIG9uIHRoZSBwcm9iZSBwYXRoIGFmdGVyIHRoZSBkZWZhdWx0DQo+ID4+IGRvbWFpbiBp
cyBhdHRhY2hlZC4gVGhhdCBtZWFucyB3aGVuIHRoZSBkZWZhdWx0IGRvbWFpbiBpcyBhdHRhY2hl
ZCB0bw0KPiA+PiB0aGUgZGV2aWNlLCB0aGUgYXRzX3N1cHBvcnRlZCBpcyBzZXQsIGJ1dCBhdHNf
ZW5hYmxlZCBpcyBjbGVhcmVkLiBTbyB0aGUNCj4gPj4gY2FjaGUgdGFnIGZvciB0aGUgZGV2aWNl
IFRMQiB3b24ndCBiZSBjcmVhdGVkLg0KPiA+IEkgZG9uJ3QgcXVpdGUgZ2V0IHdoeSB0aGlzIGlz
IHNwZWNpZmljIHRvIHRoZSBwcm9iZSBwYXRoIGFuZCB0aGUgZGVmYXVsdA0KPiA+IGRvbWFpbi4N
Cj4gDQo+IFRoZSBpc3N1ZSBpcyB3aXRoIHRoZSBkb21haW4gYXR0YWNoaW5nIGRldmljZSBwYXRo
LCBub3Qgc3BlY2lmaWMgdG8gdGhlDQo+IHByb2JlIG9yIGRlZmF1bHQgZG9tYWluLg0KPiANCj4g
Pg0KPiA+IGRtYXJfZG9tYWluX2F0dGFjaF9kZXZpY2UoKQ0KPiA+IHsNCj4gPiAJY2FjaGVfdGFn
X2Fzc2lnbl9kb21haW4oKTsNCj4gPiAJLy9zZXR1cCBwYXNpZCBlbnRyeSBmb3IgcHQvMXN0LzJu
ZA0KPiA+IAlpb21tdV9lbmFibGVfcGNpX2NhcHMoKTsNCj4gPiB9DQo+ID4NCj4gPiBzZWVtcyB0
aGF0IGZvciBhbGwgZG9tYWluIGF0dGFjaGVzIGFib3ZlIGlzIGNvZGVkIGluIGEgd3Jvbmcgb3Jk
ZXINCj4gPiBhcyBhdHMgaXMgZW5hYmxlZCBhZnRlciB0aGUgY2FjaGUgdGFnIGlzIGFzc2lnbmVk
Lg0KPiANCj4gWWVzLCBleGFjdGx5LiBCdXQgc2ltcGx5IGNoYW5naW5nIHRoZSBvcmRlciBpc24n
dCBmdXR1cmUtcHJvb2YsDQo+IGNvbnNpZGVyaW5nIEFUUyBjb250cm9sIHdpbGwgZXZlbnR1YWxs
eSBiZSBtb3ZlZCBvdXQgb2YgaW9tbXUgZHJpdmVycy4NCg0KSSdtIG5vdCBzdXJlIHRoZSB3YXkg
dGhpcyBwYXRjaCBnb2VzIGlzIGZ1dHVyZS1wcm9vZiBlaXRoZXIuIElkZWFsbHkgdGhlIGRldnRs
Yg0KY2FjaGUgdGFnIHNob3VsZCBhbHdheXMgYmUgYXNzaWduZWQgdG9nZXRoZXIgd2l0aCBlbmFi
bGluZyB0aGUgYXRzIGNhcGFiaWxpdHkNCnRoZW4gaW4gdGhhdCBjYXNlIHdlIHdvbid0IGhhdmUg
YSBjYXNlIGFzc2lnbmluZyBhIHRhZyB1cG9uIGluZm8tPmF0c19zdXBwb3J0ZWQNCmF0IGF0dGFj
aCBhbmQgdGhlbiBjaGVjayBpbmZvLT5hdHNfZW5hYmxlZCBydW4tdGltZSBmb3IgZmx1c2guDQoN
CmFuZCBvcmRlci13aXNlIGl0IG1ha2VzIHNsaWdodGx5IG1vcmUgc2Vuc2UgdG8gYXNzaWduIGNh
Y2hlIHRhZyBhdCBlbmQgb2YgDQp0aGUgYXR0YWNoIGZ1bmN0aW9uIGFmdGVyIGFsbCBvdGhlciBj
b25maWd1cmF0aW9ucyBoYXZlIGJlZW4gY29tcGxldGVkLg0KDQp3aXRoIHRoYXQgSSBwcmVmZXIg
dG8gYSBzaW1wbGUgZml4IGJ5IHJldmVydGluZyB0aGUgb3JkZXIgaW5zdGVhZCBvZiBhZGRpbmcN
CnVubmVjZXNzYXJ5IHJ1bi10aW1lIG92ZXJoZWFkIGZvciB1bmNsZWFyIGZ1dHVyZS4g8J+Yig0K
DQo+IA0KPiA+IHdoeSBpcyBpdCBjb25zaWRlcmVkDQo+ID4gdG8gYWZmZWN0IG9ubHkgc29tZSBk
ZXZpY2VzIGUuZy4gaW50ZWxfdnB1Pw0KPiANCj4gVGhpcyBidWcgd2FzIGRpc2NvdmVyZWQgZHVy
aW5nIHRlc3Rpbmcgb2YgdGhlIGludGVsX3ZwdSBkZXZpY2UgYW5kDQo+IGFmZmVjdHMgZGV2aWNl
cyBvdGhlciB0aGFuIHRoZSBpbnRlbF92cHUuIFRoZSBjb21taXQgbWVzc2FnZSBpcyBhIGJpdA0K
PiBjb25mdXNpbmcuIDotKQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBiYW9sdQ0KDQo=
