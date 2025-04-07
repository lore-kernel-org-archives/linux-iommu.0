Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89E223301
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744003735; cv=fail; b=j6GLOFi+may9x1GmVA5aeq+9wnAq3rfHqSOk+JXaTCl/pEnEOeJCH/pYqxVgmd2rqyDjAihWJDgoteHbBVp1oy6kONZT1ddN2T0n+ZIB7P3vRhs+WxdCc+ulo+ANfYIMQizf9sn5Z7cGVUzGJC79QBj/J/sBW9P8vTJMmmItnuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744003735; c=relaxed/simple;
	bh=C/Fxkru4J5X++tDOqligkaAo4GRDfoRkgoCWCPGQxLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pArsiXXXHQ0+ph/apZ/8a1ldGl9eOjiyCAQeeN+zkDv41PzG1jW/dFVbIsJSmF2dNZlcQ8ay1KqaSiKzCzhFN4Wza5fKCFpgPCDrKVbuuD+iDbXN/s3lUk3xq6yPJEKGMJ+3MaOi/maWPEDVwAkmOxdqKWnGDO7ZHI7VyTHePRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gu6qIW5v; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gu6qIW5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744003734; x=1775539734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C/Fxkru4J5X++tDOqligkaAo4GRDfoRkgoCWCPGQxLs=;
  b=Gu6qIW5vPW2rXMoEr/iCqWr8NJbu8Y8fxaRAPKb8Bt13589MM8GaQngb
   MFgIEGOx8Fbma+17VJxQRUzrx9mhGCsCEX06a6+HLNdfJc1u1TFIv6yQS
   Sm4bVNQWImJ8Fv3G4G+CCUgm8Z3dsUiaTFm/BqNT9dxaCo3HcfiVjn4GT
   5Rv1H7csl9bWkefkyPlldb7Z9IttRPKRCJ+ogqsLQHdoZs19m3rnxfphR
   VP1WZVakhnEHyQ/xBjxfI8gGNVlZobeb2aeZHnDl/LBBjN4C1xWUCh9YA
   8YmuuUnvocWQEMyLdo2RJzyqppYpNkzxIMRUk7BNsQ2OkqCD/l+IQuu/g
   A==;
X-CSE-ConnectionGUID: 8I/qMeRTSV+vQCo2XwrKFA==
X-CSE-MsgGUID: nkatJtClQZ2BlJU3QSYENw==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45389836"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="45389836"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 22:28:53 -0700
X-CSE-ConnectionGUID: bJpjpKsITX+qh8MgEluVvA==
X-CSE-MsgGUID: Fv8wazAPTWqjxetknC5G4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="165041707"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 22:28:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 6 Apr 2025 22:28:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 6 Apr 2025 22:28:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 6 Apr 2025 22:28:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/PYp3Go+7liGOc3O4Yane1fB4izXhObCu/j0MorMFcjWZtCE4YkA3c31VDMX5+jfM+NHoGLWQIh1xE6LjRxkkZy10kIMt0wSILUQxOsRGbBqC4wVXKBYkSbS7Novuj4tiyGSdozo4eqraXXENGHIwOErb3NwxHKri7bM24Sc3TYJN2wh2ozYGadJ9aXSgSqL7JgABNWB7JMcsY1HafbuJOLvGI3e+K1OwLy3Qtxm1xZw8Ubve8gxLJZ4iD2XCoEVzZnaV5vyhVfpxev7LmGFCOMb91sRhJlp7Ztudm9FRQChWCi5UJNZyBOwHJ8c16g3Tuli66RARYeBwL7rnHd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/Fxkru4J5X++tDOqligkaAo4GRDfoRkgoCWCPGQxLs=;
 b=aKZlUFByZIzFTMaU0YsB9aIMpvW4wxHctsOn3MrLGxZsMSFF3P4hzyfdmp48o0dscbjeAehBHzL+7dlmjLc9BaU9v87btdyWTBtQOZZr7jp7brHRN/QmTZ1D952nLdgDL2Z52dhHunYwP94dISneKIvYp7s/QvqIWmpVoVu1llKCXIoAHHFNc6h1ov3quv81YlD24LPbY1fNb/LtTL6s53KfkSIjomEUqi0QgY85M+FpY9VJbcOflTfr5Jv7TkHpSJgOfi+3AzGtcCrzyz21i3VhPj4ViYFGvlFNjlvPHp/vXzfQK2+DpSXPfqOMutEBqgF2VPvx6+rjakF9exT3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 05:28:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 05:28:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3owgAIlpoCAAPkEsIAAF6wAgAANLoCAAASrgIAAABIAgAMaTACAAc13gIAClZTAgAjFdoCAAnmvAIAH/ZCAgCDFuUA=
Date: Mon, 7 Apr 2025 05:28:48 +0000
Message-ID: <BN9PR11MB5276A14C8598CCC6C58A781A8CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
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
 <4a0e64e9-57c5-4f30-97bf-00c3eafe0b8f@amd.com>
 <BN9PR11MB5276786C4BF482199872BB2E8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f728d10e-97d0-44eb-ab2f-0e40d7d5f810@amd.com>
 <BN9PR11MB5276B52073263CF1AEAE888A8CD02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0fff7dea-3a7e-4305-9ce1-066fd86537eb@amd.com>
In-Reply-To: <0fff7dea-3a7e-4305-9ce1-066fd86537eb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5942:EE_
x-ms-office365-filtering-correlation-id: 6b9c3ba5-9adc-4192-e318-08dd7595133b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WVBFTVZaTXA5dFBSMDdsN2xUYS8xVVh2L2w5YWl6Q3FzQUYzNjhUNXFtK3hs?=
 =?utf-8?B?eDZuQ0ZQVElsajBPYzhFL0cyeHF3ektBcDd5NklhSlN3eUFxd1UrejdXY0t5?=
 =?utf-8?B?SitwNk41UzRwKzNwV3p3UVoyZ1BvcWIwMmZGV3prTEQ1SUl5QTFXUUNBcjBZ?=
 =?utf-8?B?UVBpblVPbzdIK05KUkRKcUVnbSsrRmxhSXY4N1gyVkc2ZnNXdW5pSndaQzBS?=
 =?utf-8?B?M1NIUVNSV0lDSFFObWNYQW5HYlVTZFh3UGtJK2JWQ3BtQ3BHaUxHT0RMV2kx?=
 =?utf-8?B?MzBXb3hYNVJlbHlDUnluNGpPV2F2RkVHTFhBb3lFaVUwVmNleDljY0lzMXIw?=
 =?utf-8?B?UjNsWHZROG9Wc3NVRWZrdlpYOXZhQlNybS9STWtjOEIyM0xuSkhjNWdpVHl2?=
 =?utf-8?B?YXB5TnFjWU9MQk9qdTc0blN2NURwUDhyeDlZcHVoRHFraXljT0E0WlA2Qm1I?=
 =?utf-8?B?VnRFU3ZscnBJYmU5dk5KZGlTTXk5VU5uaGVRMWJzNituOUNhSUUrZHZXYm9B?=
 =?utf-8?B?N2c0Z3Vxd2UwZVpMQ2N6eXJIcG04TjRscUZaNjAvSlBZNlExWFIwanZWTUhC?=
 =?utf-8?B?WWF6VUFQR3lzUWJCaFYvbVkrMzNaNThVek1JTUxQRmwxY2wwWUpNQ1ZSc1pO?=
 =?utf-8?B?T0Z6Z055VUpPQ1dLT004bGMzaWNHbENZNU1KdzNlK3lZeTRKSlFrakNNN3FJ?=
 =?utf-8?B?UlFQR3ZzWDh5dUFNRXpDYnhxalNDN1NlYkZEV014enJuN3F3aE5HOVhpNFZt?=
 =?utf-8?B?NDdscGxlcHUwZU1OdGtFMGwreEdwbnRRc25PSVFoVlQrS0c3aUIrK3Ixek12?=
 =?utf-8?B?SjIwSVNaL1AxNE1PaXdieHFCUmNPYmNXRGo2cGZOUlR1TllEUzJuN25RaVJE?=
 =?utf-8?B?Nnh6K0hIT0VmZVNHUkhTaUkzdjBrdGY2cVUvaUwwb0ZUTFZWRVRjMjN4VUpI?=
 =?utf-8?B?cUl4eC9HT214b29TOHdsQWFBaCtPcG1NckNDQTlqQ0lKRkRieW5Td2orT3dm?=
 =?utf-8?B?WktFK2lrVGJkbS85MmxNL0didXNuWi9YckxIRC82Nnpmd2krcEtmS1k5QjZQ?=
 =?utf-8?B?Wk5EdDIwUEEyRkZpbnpzZVZINkVHRURFMFowQUliOTVSQTJIYXQ3UytGOWJF?=
 =?utf-8?B?ckF5Zjd6WVBNTWpUZFdQWUl4bmdObHNaaGlmZHJOcmlGQng3ZDBzT3orUVRL?=
 =?utf-8?B?anFNS0ZvV3M3L1RNbkE3Y21aanZKT2hKdEsvT08zR0xXdDBLMUo5bHZNSFhJ?=
 =?utf-8?B?eFJrL3czcGZlQUkyOU16a3o4YWpiZWZhVEhFYlZQUkVoZzFGLzhnNHB1Yzg5?=
 =?utf-8?B?U0VDaWx2dTdsWWtqaHordzFuNC9rRG9zdHBTT2I3UHg4eWJzTHdrbEdtdnpP?=
 =?utf-8?B?UGJlNE9nZzM1dFRwNXZMUTl4dkllVTJuUHp6a1pkUVdpbjNQSC8zS0xhWjVx?=
 =?utf-8?B?S0VFaFYyaFRrMU9FWkllWDhTVysrT2tHWTNoR0hWa2h5NmxnQk1qT3AxZC9B?=
 =?utf-8?B?TDdvV0ZOeGZSYklrVmNJbU9xa2FNaEYyeDZQSDA3Nk40bUxiT25mQ2tvZ3J3?=
 =?utf-8?B?bXFlZlo2ak5ieExldVd1OG0va1NrdE9CZjUrQm1WOUFOcmhhaXd2dm9jUk5V?=
 =?utf-8?B?VWdPZHErZTZQQW9PK2FDQmpybFJ0b2lZdjZaSTRWSDVDZitoWHdqVnJ1M1VX?=
 =?utf-8?B?OWVyS29ObThJcG52cFdSZUZiS3pYZEpTQWNGUXZIa3VOUFRLZ1RXQ2luaFdr?=
 =?utf-8?B?R1NkMGpWblVXbnFsYUIvWFVMQll4UEhJbXc5cDdVS282OU4zL2NsUDFqeTM2?=
 =?utf-8?B?cVJRRlJHaXRNaVNjRURJVlJyS2NydFZTWjZiVVJSY3I1UEdER3FsaDZkQjRO?=
 =?utf-8?B?QWFHTkZzU0czT1lIQ1FZbUluWkdqZFk4ZTl6OGhQRVlPM0cwMUw4VVdzTit0?=
 =?utf-8?Q?aqND7qF0vEmqR304T9PJdCfvGAMUJm+g?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R201Nk4rQ1c4YWdINDF1VWpDODVGMFhoeGdRL0xrZnREZ0ZTbXROUEhTZWw4?=
 =?utf-8?B?dGkvTzIxa0FDMHdJTUFqODY2eWd4TnpTc1JzT3RTNWxja1lZeU1SM2IyYmJ1?=
 =?utf-8?B?N3AwNjlTS2I1clFBZVBqWDl2N3UvTG9LeTZRVlpadEFVazhjb2ErSTQ1Zkhh?=
 =?utf-8?B?ZHdLMkJleEpxKzRJaEhUY2RuZWpiV3lmRDRyUGVPSTk3ZEtqSmNMZWUwZ1VV?=
 =?utf-8?B?QmJCSzRHVUFjaElTVVVlVWRqRE1uOGZkZXpSdm9VU1VqNzhFQ25SanJCYlRr?=
 =?utf-8?B?dkhtVzdid1FGdC8xdU9vV2lmSFVOeERWVmJIaVhSYnE1N0laS1V4Vk1PZWxu?=
 =?utf-8?B?cnkwMDZYRjI1UUFOMTUzczJqaE1oL1ZSMEtnNnF1THEzTWU5TlNoMzk0aGtE?=
 =?utf-8?B?ejQvZ0hzSVFiRGlIRHNkN1N6NjVBRENGMHVTOFRVWCszZzZOWFRVZ0krakxx?=
 =?utf-8?B?Rndpd2Y1amlvWlIyOVJHQ3VHQi9vbytoNnF2SmptOWlwRExkRUNYM1J1anJl?=
 =?utf-8?B?OTAwNHZrK1FRazNXL3puNlJSY05XblJyNm5INmo2a2RtVE1sbitSbFBNZHla?=
 =?utf-8?B?ZkxPSmVrdzhaOHU2Y3l5cENnRTJmUXd6cUFtWjVkMEcrYy9UcTVNS1AzUWhI?=
 =?utf-8?B?ZXQ1RzQ4RlpJRUJxVXVXYkp0U0VoaVNsaEp2OU1pRWxKajh1emNnZGxwY2wv?=
 =?utf-8?B?Q2RpMHJKb1hPZVlTd2hucDNpM3QwRGlJOGNucU8veVROb3dHQ0J3elY2RlV1?=
 =?utf-8?B?dU9SaGMwUXFIekZpM3lLSEZFNFFWUTZqeWpVWlpKenh4TTFhMThjSGdqdjRm?=
 =?utf-8?B?VkpZTHN1cEx2Y2lSaHUwaXQ5VWJhSjdyZUwvcVd2RXlOZnhURndmU0tRS2tv?=
 =?utf-8?B?UUJuRlpKWWNEeXpISnN5SXpkcGFpd2Q5MWtaVDE1VUhwcWJvUVpIenQwQlg2?=
 =?utf-8?B?L3B6RXQ5UHVLMmEwOEVhMXJibng2alVHUDJMbWdSM21jU2pudmlKSW9QRHpN?=
 =?utf-8?B?M1VaNjRiK0hYL1pBZXdRdzZmcUZQQmswbzc5RXJVczlDajdvWXVHQ0N1OXQy?=
 =?utf-8?B?MFlPRURhTVM2amtPUjJYNHRtR3hscHMrdVJYV205cFBJUzdDV2wvSTlFMFd6?=
 =?utf-8?B?YllDZDdaQS84bmVIakhkVEJOcnNKTjVjUmhacUtvTVhrdW83ZUZSR3Z6NCtN?=
 =?utf-8?B?N2hqaS8rQ0VyYXIzRGNHaUNhM0ovRC8wcS81eXNiTmdKd0VnQkQxSkNPV29S?=
 =?utf-8?B?UHpNVmg5UEJ3WDhkYUg2a2ZtK2N3WlFxSkxod1pCbkFJOUQxU3dMQXY5VzZS?=
 =?utf-8?B?cEJtZDd5aDlvY3JRcnQyNDkvM2d0V0xqOUo3TlBweDlKMDgvNEJJRmY3VjZ4?=
 =?utf-8?B?aW80QXAwNTlSN0J5WXI0Q2xTVURnKzNDOVdRRmpYYTIyQXArNVRsODFkZXRB?=
 =?utf-8?B?enozRXBjakZ1dTFNeWlOUWtUVW4xQXNVK3NieVFBMEQ1UFdOT3dzb0FwRUpN?=
 =?utf-8?B?V2daZUZIN0x4eHdwVmJIS1dDOHN4ZWk5Njk1dXZ3Vy9pWUdFTVB6b2VpUTE0?=
 =?utf-8?B?L3lYeHpZcldNeVVzdWVhbk5EUC9obXY0eitYb2FBc3ZuNnFUdjNWSWxJblFW?=
 =?utf-8?B?cjI2ZjN4VXJSUVdkd01mMkhEVG5EVVNGNUVrZXJob1I2Uk1QeTRHOE02Ungz?=
 =?utf-8?B?T1hKKzFFYWFWU1BDSUp6Z3FkT0wxOG1kcnZGakZGRE5UWUZKZEJHQTZLZmtL?=
 =?utf-8?B?N2FoeG5RMlpSNWM5ZEMvMVk1U0RSYTU2RXZIN09qQk9tT3NyaE5IM0tOL1BU?=
 =?utf-8?B?K2tpTUs1RU5sMUJrN3hGQk40aVVJVit6YW1DS1F6S3NSWUZkMnlIaEptMVZI?=
 =?utf-8?B?MWxZUzgyZUUzbVlheE5LNVJHVFVxYjgvZTdIQ1llVUM5MkJGL09KUFFmZk1j?=
 =?utf-8?B?Z2IxVnh6MkZsN0hKN0o0cXBWYzJhTVRRanNKZlhkSlB2QVFiZVRCMUUrdElH?=
 =?utf-8?B?RFJrbS9wMk9iNVNNMEpJT1JlYVBXT2ViVXNTRFFVWTZId01XSXQ2YUlRL05Q?=
 =?utf-8?B?Q3JsLzNzOTBva3NvdnNZZCtZa1dnbjhlbjZPcmZJUFM5UjJ5NUF2VW8yU01P?=
 =?utf-8?Q?SBXlZST2HGIqhV0lH9/aPuPGF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9c3ba5-9adc-4192-e318-08dd7595133b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 05:28:48.9493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlbdUIJdsFMFfmbpoBc0ZYUqoomWNK0CLHME5jCH7FAZmhVLj6WFMN1K5bODvdrx6jYz8k2Z0MWQg+R4eZWR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
X-OriginatorOrg: intel.com

PiBGcm9tOiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiBTZW50OiBNb25k
YXksIE1hcmNoIDE3LCAyMDI1IDQ6NTcgUE0NCj4gPj4+DQo+ID4+PiBBY3R1YWwgYXRzIGVuYWJs
aW5nL2VuZm9yY2VtZW50IGlzIGRvbmUgYXQgYXR0YWNoIHRpbWUsIGFjY29yZGluZw0KPiA+Pj4g
dG8gYXRzX3BvbGljeS4NCj4gPj4NCj4gPj4gVGhlbiBkdXJpbmcgYXR0YWNoX2RldigpIHdlIHBh
c3MgdGhvc2UgZmxhZ3MgYXMgYXJndW1lbnQ/DQo+ID4NCj4gPiB0aGUgcG9saWN5IGlzIGFscmVh
ZHkgc3RvcmVkIGluIGlvbW11X2RldmljZSBzbyBubyBuZWVkIHRvIHBhc3MuDQo+ID4NCj4gPiBh
bmQgdGhlIGRvbWFpbiBhbHNvIGluY2x1ZGVzIHRoZSBhdHMgZmxhZyBhdCBhbGxvY2F0aW9uIHRp
bWUuDQo+ID4NCj4gPiBUaGVuIGxvb2tzIG5vIG5lZWQgdG8gcGFzcyBhZGRpdGlvbmFsIGZsYWdz
IGF0IGF0dGFjaD8NCj4gDQo+IFNvIHdoZW4gdXNlciByZXF1ZXN0IHRvIGNoYW5nZSBmcm9tIEFU
UyB0byBzZWN1cmUgQVRTIHZpYSBzeXNmcyA6DQo+ICAgd2UgdHdlYWsgaW9tbXVfZGV2IC8gZG9t
YWluIGFuZCBjYWxsIGF0dGFjaF9kZXYoKSA/DQo+IA0KDQpOby4gQXR0YWNoIGlzIHN0aWxsIGlu
aXRpYXRlZCBieSBpb21tdWZkIGFuZCB0aGlzIGlzIGp1c3QgYW4NCmF0dHJpYnV0ZSBhZmZlY3Rp
bmcgdGhlIGJlaGF2aW9yIG9mIGF0dGFjaC4NCg0KSWYgdGhlIGRldmljZSBpcyBhbHJlYWR5IGF0
dGFjaGVkIHRoZW4gcmV0dXJuIC1FQlVTWSBpbiBzeXNmcyB3cml0ZS4NCg0Kb3RoZXJ3aXNlIHVw
ZGF0ZSB0aGUgYXR0cmlidXRlIHdoaWNoIHdpbGwgdGFrZSBlZmZlY3QgYXQNCm5leHQgYXR0YWNo
Lg0K
