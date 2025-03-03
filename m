Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2583C3C
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970902; cv=fail; b=MjTfT9um0sc6aIOSUDEhEuMVd7dPa1rTGitNApbtbM2h4UAuSIFxBEzeFQjpSISR/3Pj3YH3BAvJmNAK87oAuJ7GSir15ZRFObexEhyF5EoAVa7jM1SuS+3nIT7ovFewl1VKtkI2V760ZaZTgPFrhD6rAblsIBUMp96+1V0NWUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970902; c=relaxed/simple;
	bh=Gd3v+h/c/Qp8afz9xwExXtf4Cz/1oo8EybCebeP/m3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S2IY1MGqTuUuYAbGRxKcOSaeXBaQ7SbSaR2JVKjbizZbxVvoaRVwSBJkPfR7zDmPawiIa6g55IaO4DlntaI/as/Pu3Drjda4M5LeYgzbsGjejwZh+lr7mpjZR8JT19QMc32EU5GTAAznJAGeJEIs8wA80fmGJ8RzbVGFyfvApsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aC+eP1B0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aC+eP1B0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740970901; x=1772506901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gd3v+h/c/Qp8afz9xwExXtf4Cz/1oo8EybCebeP/m3I=;
  b=aC+eP1B0MH4uaNQ+XGIMeDmYGSI0plOkVuxdEeC+871r5r3Wqvamecbi
   5AQA76Y8Yt6unvd8sURp8gQ474SELiKk7DenHr+m7pqGu6e7vbYdmTxes
   Uw6zVOxvbpcvzu3CRwVGJAxF7F9cIB5qQVvLp1Y9Ny4ITpy7fNVF3JhLa
   dVzcVAF5/ZdpWYxKBV7ARvzhA8uZmg/n1UtOPDQYUHfhjUc5nc1kzHqbx
   cfQvfSMnzHuRob1Edi+C3NS3DcpHZk83tq/3pE2erWbVV6VduvcxT7Kln
   h22dKwMaSk/o1Kf+v4Qs86Ux8bJMMqiY9nJOLxMtacrsMOkowp8o7wFNo
   A==;
X-CSE-ConnectionGUID: tWXb0B9yRLyuQWnWUVkpBA==
X-CSE-MsgGUID: ObLFqhKSRlmaFC5yUcSHtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53240161"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53240161"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 19:01:38 -0800
X-CSE-ConnectionGUID: XkdOphIrSsGyZqrv9xNcgA==
X-CSE-MsgGUID: eewf9C3TThSk2ZPKY4GG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="118069923"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Mar 2025 19:00:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 2 Mar 2025 19:00:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 2 Mar 2025 19:00:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 2 Mar 2025 19:00:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfPfdT4EqpAwOYuEOKHdU1vmWwQI8SS2uxAwUhJBe6I8JzF8jgzsZ5b3HIu5OU9QRht0YhIluvEQpt63zauCaBPdydxLieIPHNZWGr66W7quogeFduQ08nqO6/PIH+nwYiPYMta3tm8zOi3RfTflQ+eWqBXDpRtZ2uYybMvzombSwSglW4NxSBjgwkyEXz9Js34jnndObHiIcdaHEKXbYL/ZaX3saZBSLyftJekQqQO8sIleXIHT6+KPuVETZQ6gQKhANFCqWZq9McVZRTJfBuOE5sXmA5QjF/jLU80PUbTL2afkDy03/Vip9w1wmShHPnPMj2Pjmh9gMVsnc5J4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd3v+h/c/Qp8afz9xwExXtf4Cz/1oo8EybCebeP/m3I=;
 b=YM2vLQLRL6s867IEbNFIDuAz68ajq64ZxvGmS5G/zztDmsF/ZUu8gLY/EPflgf/jxaAkItw6Q8+6iY5k/FA1ofh7VZWBQRpvmP/R0siRHuMp0HisFL3uPFTpRhl1E+B87kMnkw8kXsLh1H0N05KelQTpQdPx1/jQ16UJG/qBu6T8pWeGy956yrfXELdCEXs+JG47jKmz7KYwH7/Dwg0UCMMfqhxZqBkV0LB/f+17l795FV9gGgO89yoyuzQhWXHRFjj49fz4B+YBPO2c8Iw6fj4fPXw59+2URLBBCrJSO/yFOTAIQ5+mdTrruvEaap4Qc1MGX45owv5JJA7uvTr95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7901.namprd11.prod.outlook.com (2603:10b6:8:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 03:00:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 03:00:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3owgAIlpoCAAPkEsIAAF6wAgAANLoCAAASrgIAAABIAgAMaTACAATqFMA==
Date: Mon, 3 Mar 2025 03:00:53 +0000
Message-ID: <BN9PR11MB5276BC7C4FD335EC5447BCA08CC92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
In-Reply-To: <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7901:EE_
x-ms-office365-filtering-correlation-id: 3ab1dd37-24bc-46d7-fa8f-08dd59ff9c7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b3hTZFlTSmFEN0ZKTmZldDVvZlM2Tlg5V2lkT0xWTUtSRit4cDdYMC8zT1lk?=
 =?utf-8?B?K3ZCRHcxVTJEWTJ5bDF2VUV6OTc4NCt1Um9ub3A0VlNaemEwVjZ0RjZVUmpy?=
 =?utf-8?B?RFBXWXpud0duWUhQb1Y3VWxTK0RySVAzNlFOYWlzTUkxWTRYeXUyTit0NWF6?=
 =?utf-8?B?QkJsWVNoajBtOGRqejk5dEh1QXlTK3N2Vk14NHVtVnEyc3ozUGJjeCs3cDdY?=
 =?utf-8?B?SE9ra2ZCK2xBeVI3ZGtXRG9MYm1QV2dzdEwxbjNidGYrTXRCcnVrckhBTCtv?=
 =?utf-8?B?VlNxVTRHTC9nbEhoQUpjeXZ0bEprTjJxRm12bk1KOWRaTWZ0anN0bTBKZzFQ?=
 =?utf-8?B?NVR4RHdLT01Vb1pleDdnY2t4cVkvYUNlK1ZWZlp2NmUyN09sVGdCbnUzaVdK?=
 =?utf-8?B?UGVKcXYrcXhVZ2Y3bXVCTEIyaUJ6d3ZtYUdyNmZWRlVIRVRMTi95M1lGZUJP?=
 =?utf-8?B?YW9BN2tBK2Z3eUQ5YkM3RHQ2WGRiS3Rib0twWDdNbjRlVjUxZXRNQU8zNGpu?=
 =?utf-8?B?M3FLckQ5RkRJWlkySkZENVB6NnJwdjkwZU9yU3IrdzdqNExFZkM4MWVlcGk1?=
 =?utf-8?B?L3B5czRXVS9lUTNjZ2xHRk1Mek52VkxRR09hM2Z2Zy9TOFBGSkdKWGcyUUlC?=
 =?utf-8?B?V1dheDI3bWhBc1RBcUg5WU9ZcU1NdlN1L1AxNEVnRC9uZGpzNlJaeTZJYnlG?=
 =?utf-8?B?WmNWbmE1YzM0dDhBanlmNWlhU1phbXRVM09udytUMkVvOGxtMXFjQXJ6eVE5?=
 =?utf-8?B?akZ6ZjBCL0wvZENicVFNT1VNS0l1djhDV2wyb3MzMWNBZDNiRlpuNk9iWFUx?=
 =?utf-8?B?WUg4N01rcmtSbEkyMFJ0TXBOaEE3akI2Qmova3JJemt1WHIyajVLaFBGU2ZM?=
 =?utf-8?B?eTJUNGpOcER4d0VETG9lbVRJQ0QvK3dTVVE4RXBsWXhoRDJvN3BXVjZ4VXcw?=
 =?utf-8?B?M1NnL0d1WXNkd1Fid0sydTVQbmJRU3BHb3ltVlNiRTZhMTB3d2pENzh1NWcv?=
 =?utf-8?B?OExVZkxmcFRPUmFncjUzcjZSZzBFcUdZSE5jOFBNWWpkQnl4Q28ydnhET05K?=
 =?utf-8?B?Wi9Dc3g0Y1AvNTFidGJ1RkhTejdRUjNLNEwyNTl4U0dXVlRxOGlVTFFYc1dZ?=
 =?utf-8?B?SHRrc2FMVDJSSkpRV0IxZHdZUFQxWDVPR3E3UkFwWC9ocFhha2ZUK2pVbFd4?=
 =?utf-8?B?c1I3alFWbTkyc1laQ0lmYkFoQ2xzOVpmbVBTUDF1ajVXR2FHTVM2a3NvTU5v?=
 =?utf-8?B?Ly9Za3dKbTQzWUp4dFZzcUMzYThEOEVoT3JLeUZ3alFHK3p1QzZLMER4UGJR?=
 =?utf-8?B?WVNydFNuaEdVL3JWd0RsUURteFZlWWRqRzhnVWNMeDlqbW90eVlDS0swSzNB?=
 =?utf-8?B?b2dHU1pKK3dZMkJLOFFEaHVhS2pMRGlOVmw2RnR1MmpramlRT21BV1RycG9q?=
 =?utf-8?B?c1BaZTNKTFN2NHJ6eWJVRVZ1S2ZjZkVLaTl6aVNPamcrTkJnSjFOTmtjUkVH?=
 =?utf-8?B?WDBLeXFkR3V6RlNWN1NQL3FRY3dFK3NJdUw0SFZTMWd5OWZLRHp4ODYxR2ty?=
 =?utf-8?B?cENsTFZYakRmcjdBQ2c1UVRCdVhaVS9kT3dveGVxUWk4bFpmOSs2TnpOMkxw?=
 =?utf-8?B?NGpzck0zN1hZM2FVMVE4M2VTYjVVYnVZd2lPcEgxaXZGbFV2RWVyWDQvY1lH?=
 =?utf-8?B?cjlMZFc4Y2FjR0U1blhmc3NvZ0o1QzRMOXIrUjVXSHVNYXJZMVgydUdLcU5T?=
 =?utf-8?B?NnpFZ3hZcGQ0eURDL2phMW85MTFYd1J1QUJiUEU4ZzdTUFZQb3o4Nzk5Zkxz?=
 =?utf-8?B?VkgwMXF4a2p5K0xLNStiaVpJS1VlSWNpT0ttWUdlM2hlRVh5K2lJSnJ2V1FT?=
 =?utf-8?B?d0Z6NkhtNTIrU3NUKytXcVZsUlhoNDJnK0ViUFV4alNWK01yUVZpWXNlQld1?=
 =?utf-8?Q?8LMh1cr0oT4yum6I2AN08fxV6fJZUc8V?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SURCVTdpYmRZbVVITWRJYUdXSGQ0MW1sMTdJeDZjcHFrWTY5Vm9rR29hRDVD?=
 =?utf-8?B?MVdBKzJBM1V1cTZ2bXd5cmJtOHB5bjA3cVloR0k2VnZhaGNwV3FVVUxLbmVB?=
 =?utf-8?B?cm9qVFVialNSSEY4RHJUUzNIKzVibU96SHk4dEhENHFvaS9KUk5qQkhVMG1C?=
 =?utf-8?B?ZVh4WE02UlFEMWhRN05oYjJzWnFSdU85bm5EZ3hSRzVoZkV6WWNPdXYyS1Fl?=
 =?utf-8?B?dkdLeTBlNlJUTFRXdVRvOUhpTW9hR0hlSEtpa1hmbGZ2Zk5VaGVSYzIxendT?=
 =?utf-8?B?Y3VSdkZGMFNXcGdUdGhiQ21UZzVwOE1YdmJheEdTa0FiQ1hYUWtLc25abmJo?=
 =?utf-8?B?VXUvQXBYYkR1cUpNNXZHRGlRYkZqYWh5L3RJUzd1eHRTMnZ1a2lOcC9ZTU9F?=
 =?utf-8?B?ZnczZjd0MDFjKytKUUpCOTZCRXhUTUl3KzJ1RjZPdkdGbytvYXNhUmVEWUlN?=
 =?utf-8?B?U09yVjBSTVFCRlhKdDlJN3hPQjhGKzdnOUgydUF0T21CM0FqTmpucGhXZlVE?=
 =?utf-8?B?YmRoSTBHU1dGN0l3RUhPZGplS3kxUzhua1NQclcrZjcxRTZzaURKTE1hTWdJ?=
 =?utf-8?B?RzdYZFppZmpZcUtOSWNQWlJTejlVSERzVlIxcHY1Vnd1ZlN4VENjTXJUaGhC?=
 =?utf-8?B?d1ppNFF1R0NSZnk0YnBVV2ozOFpnWnYrY2JJT0l3VlJkdjRHSFQ0WXZyRzBC?=
 =?utf-8?B?SGE4RTVpN1V0WnROTWpTaG0vRktYc3FsSithUXM3Tmw0UmdPZEI4VFV6WFoz?=
 =?utf-8?B?TStGUklvVm5ZS1FwN3hXdFdxTS9nRHYvVHplMml6clY2V3ZFTFRoUlJ3YUg2?=
 =?utf-8?B?M2o1TEp3QjFueUlQQTBsZnp6enZ3cnFwVDhJRHgxemY1bVRVUVdHdit3bGtr?=
 =?utf-8?B?QWthL1hkSTFlQk1EdG02OXdmUjdoMVpDZzZoTldiaVZtbTdUdEdoSmFzeXVJ?=
 =?utf-8?B?MThzNlZRZGRHV2Z2cVZ1RTA2L1lvOE90N1RkMGt5YmE5YitqTE5Kakh1TldQ?=
 =?utf-8?B?QVNPa0ZvZUpjWFBJSHJrakhGZE5xamR2U0hJcUpHb0doUXhEbVpvcG9XQ2dF?=
 =?utf-8?B?ZTEzMHR3aVAremg1d0swb1dGWG5jMmI3ZDJhSGxNQmNTSEpTZ1hqOG1HVlZZ?=
 =?utf-8?B?ZEFvOEdPcnUrL0l4Q1gxMUpjZG1BNTBNbFI2bU5GU3B5eVZrdVdWZGdXYjBU?=
 =?utf-8?B?cktlY3F6MURIcGVoNG5HVU9mN3hKOEdmR2diSjlwSHQweWRKU0RRaWZjbUxS?=
 =?utf-8?B?SnFhNnJKczQrNDlaWW55RTJ4MUU0c05lZEJpc0ZmeEVDTDhNWGptay9GeW1F?=
 =?utf-8?B?QmRTcFRMWSszNlBGN2JXTVhHRlM5ZmFmZXZmL3BkN0VvRTYvNkFCcFNZU1pM?=
 =?utf-8?B?cUpMMjBXUjRtWUY1UVM5bnQwQXpoUHp4RkRmaDh4WDlhSnhTUURmMUtiMFVw?=
 =?utf-8?B?WEdXU1RwZWZReFJPUWowT1NoTDVpMHRTYXZOb1Q2TnNYckJjZHF4RWsrOXpH?=
 =?utf-8?B?Q1hJVHoraFNHVWwxMmJka2Vpc0NJQnVMUGhBTWlUdDhqdENvUzV5V2xVTFhB?=
 =?utf-8?B?TjU4cTgzY1pwdWtRMXJWRE5BMzFMMUs5djNubDZOWjFFV1RONFIwMEtOZ1p5?=
 =?utf-8?B?bC8vR2gxdWhEZU9jOHBXN2lENmxka044M2JXS2I3bnFScTY3NENNdlhqNU9L?=
 =?utf-8?B?YUhEMXM0QVVSNDZ1bmVaczZzQ3AvV1pOdHRHOEdNR3hDWUp1UVI5VDR3UU9S?=
 =?utf-8?B?SHZFRmkyYmh2ZXBIYW9GYkVSYmNYdXhMaXJzQVE5WEVMUCtDRjBZZ21kTnlJ?=
 =?utf-8?B?YnhTUUJiU0dENVBDYzUzMnFUc2ZXM2Z5d2dZNHp2S05JYWU4MGlYK0wySWp2?=
 =?utf-8?B?UjduOVJXbHQxOUpkWWNWa3VoellVVGZTcFRYODNVNUFwSHN6ME92V2NmUjE2?=
 =?utf-8?B?ajR0V3diVHdrK0kvRFhtc2dxdkw3Y1QxRWkzVkxHZ0xJM3VlL0w4NUpGZ3A2?=
 =?utf-8?B?QmNXVVp0bEczc1hsM1ZNais5eFcxSlFTT2tDSUY3MmgwenlicG9SYU1PNkl0?=
 =?utf-8?B?QUxnaERvWmkzMzJXRjd6Z3A5YnFBcU5obFBKemdmZ3ZrMTVPVGVyaDBhajVv?=
 =?utf-8?Q?o9fFq9C0XRCg0jmTHx58oVOmH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab1dd37-24bc-46d7-fa8f-08dd59ff9c7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 03:00:53.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1aJZDxs31I7M1o3iSBjmKHqJrJr3Aw8vPtPz2q/exCsnJTQaNWrn9kuMPPLjEhn+cH53aoYz3+CrqFW7VwpMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7901
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBN
YXJjaCAyLCAyMDI1IDQ6MTEgUE0NCj4gDQo+IEknbSBhbHNvIHRoaW5raW5nIGFib3V0IHRoZSBp
bXBhY3Qgb2Ygc3VjaCBhIGtub2IuIEhvdyBzaG91bGQgd2UgZGVmaW5lDQo+IHRoaXMga25vYi4g
U2hvdWxkIHdlIGFsbG93IGl0IHRvIGRpc2FibGUvZW5hYmxlIEFUUz8gRXNwZWNpYWxseSBpbiBy
dW50aW1lLg0KPiBlLmcuIGlmIHRoZSBkZXZpY2UgaXMgaWRlbnRpZmllZCB0byBiZSBBVFMgdW50
cnVzdGVkIGJ5IHRoZSBhZG1pbiwgd2hpbGUNCj4gdGhlIGh3IGRvZXMgbm90IHN1cHBvcnQgU0FU
UywgaXQgc2VlbXMgcmVhc29uYWJsZSB0byBkaXNhYmxlIEFUUyBmb3INCj4gc3VjaCBkZXZpY2Uu
IFRoaXMgbWlnaHQgY2hhbmdlIHRoZSBkcml2ZXIgYmVoYXZpb3Igb24gQVRTIGVuYWJsaW5nLiBJ
bnRlbA0KPiBpb21tdSBkcml2ZXIgZW5hYmxlcyBBVFMgYXMgbG9uZyBhcyBpdCdzIGF2YWlsYWJs
ZSBpbiB0aGUgcHJvYmVfZGV2aWNlKCkNCj4gb3AuIFdoYXQgYWJvdXQgQU1EIGFuZCBBUk0/DQoN
Ckkgd2FzIGVudmlzaW9uaW5nIGl0IGFzIGEgcG9saWN5IGtub2IsIHdoaWNoIGNhbiBiZSB1cGRh
dGVkIG9ubHkgd2hlbg0KdGhlIGRldmljZSBpcyBub3QgYXR0YWNoZWQgdG8gYW55IGRvbWFpbi4g
VGhlcmUgaXMgYSBkZWZhdWx0IHZhbHVlIHBlcg0KZGV2aWNlLCBiYXNlZCBvbiBodyBjYXBhYmls
aXR5IGFuZCBwbGF0Zm9ybSBlbmZvcmNlbWVudCBsaWtlIFNOUC4NCg0KVGhlbiB3aGVuIGF0dGFj
aGluZyB0aGUgZGV2aWNlIHRvIGEgbmV3IGRvbWFpbiwgdHVybiBvbiBhdHMvc2F0cw0KYWNjb3Jk
aW5nIHRvIHRoZSBwb2xpY3kuDQo=
