Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B31E9B26
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763766; cv=fail; b=M6ZN/qIkJnLOiqMYwRxfonS1UXKDhTCuScX9XbjLw5WixtRlYiMt+jfkae2jc46GVYAhTBNA/+wdFGm1taJ4xHAIHisQFOXgtyiENlQaUsNQh7VWnweP2Tv6GFDyqazPz3FsW/DZnBrADVGQlpnlRb2645Mr1zMbaElK0nB0BmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763766; c=relaxed/simple;
	bh=JA5zGLiv1wIKZ3DNAXON9t47TsgBLY/qH+gpMHxjCuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pqh1GqtnRQ0c08FVW7JgLI0OsveqGG3FthHkFfIuNo/ZYkZtKUJw971lFt8TMmK6RKREKXhXqLrIfQH9txLts210hNoIb+NwzxiwpBLCHlm9s8cHvMVMuuNZTGdUMthtLgCDLU95rHQ3QhG3tS61Zdc39ZP8B/UYreWOZBWu4bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBxGG9tw; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBxGG9tw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741763764; x=1773299764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JA5zGLiv1wIKZ3DNAXON9t47TsgBLY/qH+gpMHxjCuc=;
  b=cBxGG9tw8/Kbn6hB44OfOnbaOY3VoLeAXLfuTKUXbGECfzZPpk3UFze8
   JKAbH6qLZDGDG+MhAzrHw8lz0v2l0WA2Cst+ZQQ+iesjeOQiUf+ceG+rH
   OcWKvwgGgk/R9QbyTi7fIkbd3LD98tsc/E47wZjb9w2ZhmLmk4QekdsiY
   5xmHJlDANRnfbGGZJFiPwxAO7EqSbbqbvAEGGv4WQDNfa2x3bMbZ9bopy
   InCx+C7S6NNF7frW3Fkz43YdYtJpR6fzoK1EznnxY7ZQsg/cXAq0j2KBN
   Ecgs+pNKH0iw7ipkLfM5SMVtlD/Hnj0qnIpL1B9Yf/sayIz5y0LKPHftE
   w==;
X-CSE-ConnectionGUID: cAyQ+uVRT8yGaJWnDjV4tw==
X-CSE-MsgGUID: O6Q3Lj/DTxONDmwmPADm6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42085092"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42085092"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:16:04 -0700
X-CSE-ConnectionGUID: uJaB8QrbQemGGVTg2HOsYA==
X-CSE-MsgGUID: zHwLxbIwR7e0dRNhopf/yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="124719149"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:16:04 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 12 Mar 2025 00:16:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Mar 2025 00:16:03 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 00:16:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHAav22QgJ/MTyfGeRycwEUxcQamFRUGKv4eRj+3N5o6YAca+r9zJLhDHW1ZCXjImIenAjpIIN/hptfnlwhNSpqCv6FyEJrcr1zosk41QXDjoNrokIPbmrqWlBL8jw9CR+Lx3gbkgP/oRHjsMjdjI1asD+rexJQrXtPebG880AGqehc0REEuGFMlithOzZpZT20EdGjlY9hnzkQu92Uv/LBwABKHnFFrGnjNYA8YOKCZlMW6WdrRq2fk1JvYNswjy+ZIqCdZEC/6xii4KNb1yAcAdMBz37vxSdntU+yR7M4Karc/LiS9Oaa/8t3eXpi4lRjrA9jAlWAVp/LJd7fcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA5zGLiv1wIKZ3DNAXON9t47TsgBLY/qH+gpMHxjCuc=;
 b=oedgMvF/MPgA3w6Htz97iRth0ZdAPB1MEfHbrT9A5SxdUWsBSFksqO2nP06iDIlYPIMZg7jNuNmmPVFgLDBejNBeV2Zj7YMhoFgOHRlBYPmVzcMLXMA7cI96ak4XaD2NXy6pRt4Cy0AkRCP0UipChJNHGyIEIm6Q7mGVum9XvTEKOK9oi5JoYQE+oHOqkSd8cyLE5ZeU4/kv6DR3II6UN2VIksDBrg1sMdHvxcEsnC+RWWI/WNiGRYmsups7phbH/bYAE9t/rR0YcZRswKFRqhIKiXIBmlZLvxP/LHZ4UGMbpiG5LyPXbMclqse/R7RhnOKegTzgjxakslWRASJFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7443.namprd11.prod.outlook.com (2603:10b6:8:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 07:16:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 07:16:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3owgAIlpoCAAPkEsIAAF6wAgAANLoCAAASrgIAAABIAgAMaTACAAc13gIAClZTAgAjFdoCAAnmvAA==
Date: Wed, 12 Mar 2025 07:15:59 +0000
Message-ID: <BN9PR11MB5276B52073263CF1AEAE888A8CD02@BN9PR11MB5276.namprd11.prod.outlook.com>
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
 <4a0e64e9-57c5-4f30-97bf-00c3eafe0b8f@amd.com>
 <BN9PR11MB5276786C4BF482199872BB2E8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f728d10e-97d0-44eb-ab2f-0e40d7d5f810@amd.com>
In-Reply-To: <f728d10e-97d0-44eb-ab2f-0e40d7d5f810@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7443:EE_
x-ms-office365-filtering-correlation-id: b98d7368-958f-4fea-b078-08dd6135bdae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TnQ2KzJacFhoVklweTNQZ0piYmJCaFVpRytocHJLQ21EZDBIc2E2N21KWEFS?=
 =?utf-8?B?SmlkT3dHM3VEWU1pcXB0REpJTkl6Ujh4MWg0ZWNCSU41Z1hKc0JxT1hOeTNw?=
 =?utf-8?B?Wk5xTGoybTFhNzlhNWpQWndIVHFQUmZHRlJmd1pJT3RSWmtJYXJYQnd5S2ZS?=
 =?utf-8?B?dTM1dVJobEp2cE5sWURmMTlTMERxeTcrRVk1d0tRWmRWZTdXaUtvR21DeXpl?=
 =?utf-8?B?VHJmM1Nuc3JWSE41RDY4RzlncXFlS1BqMzZPSUtBSjhsZEkyaFVZQmJzVDIw?=
 =?utf-8?B?YmJTS0N1bW5jWm5mcGdteGdlcWxJSjZRUHZTSkc4RVdBcnlMRTIxWEViUnZw?=
 =?utf-8?B?K29IbEIxeHIybnIvbzFRZlc2TllGdUd2WVRZSEprMHRoZithL3gxM3hoVVFQ?=
 =?utf-8?B?b3BFOVV6N3JaYithR0lNaEFsTE5PTEErL3Z3ekVXZFN2c21pb3g2WlV1VVh5?=
 =?utf-8?B?MmlrUTNYN1VUcVFRT3B0d1FReFlXME5oYk5uTjVxZm1CaDVLOFREMjRjT3V6?=
 =?utf-8?B?YU9LV29oZi9FQlRrU01iTFZhK20vSmpET3JUVVJiYVU1UjBnYVBlSldzT0VQ?=
 =?utf-8?B?MjN0Z2lQdjJ0cDE0TFlBaG5GYlRWeVdieFpTUkt4WXFyMTVJNGJmc2Mwc1FD?=
 =?utf-8?B?eFB3Z0JEZEc2bTN4N2svV2taQzhWcHFvbTZMRkNaMjlKdnZjaHdEOEJxY0g4?=
 =?utf-8?B?dDczLzU1SnAyZU12SXZ3SWFNZ044djNYRlBobzZVcnh3UnVqMVNPUHJoQjYv?=
 =?utf-8?B?clpIbmtNTkUwWkJrdXI0TTcvbU96SUtYZzF1cFFqZnU1SmdMTE1tcWJoN0Ru?=
 =?utf-8?B?dGVwSEtlZG8venhYSndQbmlITEJFb3V1L0JPellRS2dITGtSVDlYM3J0TlZy?=
 =?utf-8?B?ZkVqOTZ1ZXM4bzhwSHlVYzljRTZHMUlRajFPaXgrNzNSa0w3bkdaNTltUzN1?=
 =?utf-8?B?SHRaU3JLSTJlYVJBK0hYamFPQmxOQ1krSkt6RFBnYUlKSzBPNW81Sk5scXZa?=
 =?utf-8?B?UWRvc0NCTDUvdVVDRHA1TnFKZy9uN29qYmdMMzNNck9NQm14ckpTWVdUUkg3?=
 =?utf-8?B?cTBNVmg1bnpjelVUejBqNC85ODNBcTVINjBGWFg4VVFZNW5Lc1lhdFRrYTlK?=
 =?utf-8?B?SmR6SWZWd0pwcWhHT255V2hacHBpeHpzOEl3TnZSMnVJbElRYTRUTW50S0J4?=
 =?utf-8?B?OEtENnJSaFpOSnluRGhjcDdydVY1Nm1UbGtndUdSSVV5MTk4M2lXekR3eUZQ?=
 =?utf-8?B?RnZjcmFQK082ZHNUenFzVUFjazliNE1QS2ZFN2xXb3JESWxrSFl2OHFpODlK?=
 =?utf-8?B?Q3dIZWpTRUlzdE1QSWtSR3QySVhuSzArQ2pCZU8zOGlxZUJOblQ0SzZ3ODJi?=
 =?utf-8?B?TDI0MXlNTkp5REYzNEFrd0JWc3lJb1pWSGtKaHF5M1JXb29DTC9iRDRUNC9W?=
 =?utf-8?B?UG93endzZDYyd3JldldHMWhzMGlQM0FaTHF3Y01NMnNDdGJwUmNxVEZ5Um5S?=
 =?utf-8?B?MldEZG42K0FGL0VtU1pSWnlVK0VCZDdmeXAwdkNwTGRGTy9ReFZrVWdtTTJE?=
 =?utf-8?B?MU5zcEhjd2hEcGtXbXBsWThBSUYzMk5IV25QOHIwNGFvNmNna3F6aFBFSmc2?=
 =?utf-8?B?VVFkaGhMNzlCenJDdTdUKzZkMUUvbm5MQ0dEQ2phdDg0SndyK1lTSlMvU2tx?=
 =?utf-8?B?SW9USElHUy8xd0F3QjhxWUtQWnd2aTh6OEVmMjdsanJacHdHVXJCTmNMN0pR?=
 =?utf-8?B?cjFCT2t5ZUdFd1NMNjZXSFNEYkhUWlQrdWFpT1pnaWMwRmFHYTJQTVN2anlB?=
 =?utf-8?B?VjZGTmthaU1VWi9PTjJvR3JZbXhnVXVLaWszUGZmbG9pYnpnL2YxVGxMeG55?=
 =?utf-8?B?eTI3aFJYYW45MlVKVWxxK3RKQ2xpaUp4azlzRUt4d2Q0TzAwS3FHZVQ5TXJE?=
 =?utf-8?Q?eU99mXv2wGBwVUDuCnMM4VhN48+Ua/rU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TERSUlIxcHFxZFVpNWxRSkE5YUdFYmlqUDZjZlpvWnJNQ00vb1g3VTJDT0o5?=
 =?utf-8?B?U3AxVTIwYXNwNVBaMmdJcUFVbGlYejl2YXRFb0l6aEVkakRVblc3QUJ5Mkg5?=
 =?utf-8?B?SmdQMzRHODVGbnVQcTlGOWFHbUJZd2NLK2FXV2FQOTZ4OEZrMjVQN0toVExw?=
 =?utf-8?B?VGlUOVEzUmhldmNkZVVQaTJzVFc0SWZteFo1b3VUT2hUNGltWWxCOGJCQWlw?=
 =?utf-8?B?dSttUVdWME9ndlJ0WXdIRXFQaGhhVS95Rk4wMlRkakN0VWFzYWhDMXVWQ0xa?=
 =?utf-8?B?MVhESndTN1ZjcHYzMDJLK0FGekw5NTJTVWszS3hhYkVNeGoveHltcGlEUjEy?=
 =?utf-8?B?ckNEWXNZUm1rblVaUGpiVGdiOE10dklBS3FJNVdqMGNsUC9LWC9HK2JQUTNl?=
 =?utf-8?B?dURHelliUm5qbm02QkZCYnA1VThveTRwc1J4RC91YXBMdUNQWTJscFhtL3J1?=
 =?utf-8?B?MUZzdUpnNWgrS2EzQ3ROanBNNWJ3eS9KT1IwK0NxVlp1UHoyWjFCWC9LazE2?=
 =?utf-8?B?ZkY3dmxEUlJoeDVOcGhCOEpSRHBKZlVKeXNYTS9Mc2VSb2VLeXFtSEhBOWdt?=
 =?utf-8?B?RXpkR1RiNmczR2ZObjI2dlphd1hKU0tlUDRBUWlSUmlNSWRxNndPaWNlMFFw?=
 =?utf-8?B?eDVxNVk2TzJBZktTSHFTVEJOU0d3SnR6aElLMXRIbUkwQ2hhWDhNWGRPc2p2?=
 =?utf-8?B?ei9HRTBnSk9Nandmb0JPWGludlI0NzBnRVRpbndxZWhBQ1JYUWRscXRpc0hN?=
 =?utf-8?B?U0JZWDZlbEJEakpBWjNqSkE4ZFV3OVl2ZVZxMVRqamEwUkJFTGxiWmdxOVRt?=
 =?utf-8?B?QnNVWVI0SWV5WWVCckJBWTRqMHJ6V3grdTlKSStVQW51SHRMeGlvY3FTWjR1?=
 =?utf-8?B?Ky9JaXhReDUrZkVsSEVSaUlIZDg2Njc0d3ZSVk84aHBTT3hJenhPSnJ1c0g5?=
 =?utf-8?B?SDFHcE9RTlNGSGlvOXBLNEdmVmF3Zit6Skw5ODFGYXpvRzUvNDFOT2FCdVNy?=
 =?utf-8?B?K2l2UXVGNUdiTmVnYVJBSnRxMkZiYWVoZnVqYy9WT1QwbVdXNjhWa1Q3WHl5?=
 =?utf-8?B?VjE5ZGh4TFAzOGNCOHhLaE5EYmNiUzF3TlN4RGVPbjR5Qm5qOTBsSU9rYktV?=
 =?utf-8?B?RzVGWEU3dEFQL0xaRG1IbG1NVTJDQzBBWjZCSk8yR0hGRU5LOGpUTDlXQXhR?=
 =?utf-8?B?cjUyQzFLcm9weEx2NWg0b1U5b0ltT2JPcnljREMrbG5jbkhlam1rM3dYKzJw?=
 =?utf-8?B?WGFLYmJNeEVPcEFhenZWNTB4bEF2VExBVHpQeHBRL2M5a1lQeUFlMkJUWmM1?=
 =?utf-8?B?ZVM3Y08zNEJMbkhqcyt2R3c5cTNSMnhYMnMzdnlnUFBBMVUyS3d5R1pUNDFB?=
 =?utf-8?B?U2tmRjA5WDlUS1lpalN4Nmlxd25pVGdMZUYrYUxNSmVPeW1CQjY2REo5b1FP?=
 =?utf-8?B?eFZPYlBNU2d2ZWUreXZUU1dsUVkvZzhOcmxDUHN5KzNOWHdMYlNkR3NseCtN?=
 =?utf-8?B?b0NMK0xwQUFIQ1NLSFlEZW1lSk50RmtwamtEWkF0d1lxNnN0OW41c3VkMFNM?=
 =?utf-8?B?VDFhK3VYTWlvdnBSR3BIVlpvZWFkZEJBR2JQQU40M1V3Smh0U3NuSXd2d1A2?=
 =?utf-8?B?WDNTSlNMOG4zRWgvdVRnRndvTmpJdFl6cis2Tkk0MjN3YklmbUFnTlp1dWlY?=
 =?utf-8?B?Uy9pcG90RjU0RGtOa0RMTXB4ZEpQUEVLN0VERWlKTHQzbUh3MWFWb0RWdzZp?=
 =?utf-8?B?ZG8rMC9ZY243NEMxVlZuZU84UGpGUk94eGllNnczYWVrNGpZMndwN21idjRL?=
 =?utf-8?B?TFI0Rk1TNFoxQmRZODV5Z0ZaU2U1MXVOYkdYOGFDWklJRHZubkdlWis4VHpk?=
 =?utf-8?B?bmJ5WTNXaHRseFF0STR2bVlMZHRXN0dWQUI1dkNmY0hRaXhJT3RLVnFUbjVu?=
 =?utf-8?B?b3Z0TTRSQWN3Ky9Yb1R4U2NsSTdsMkpmeDhVUlRMdElzNnl4Um9ySzU3RWk2?=
 =?utf-8?B?blRtNy9pZHRoTnJDbWQvUUEyV00vR0NYaFNpdlVaeEJMaVk1b21ZYk5sMEdr?=
 =?utf-8?B?eTFhTHVUTnFDSHRUWXNiT3E3bVhoMC93QVcvd1M0RkRxMmtnQVByVFlJaU8w?=
 =?utf-8?Q?bZVU/pWhZ9KqdFKJEJfqSIW4T?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b98d7368-958f-4fea-b078-08dd6135bdae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 07:15:59.9668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7sgqDFbjNyn+/437u/7U8JfirATzRkQSbJQaPOnG6E4hc0Z+cxugQ6QzEN39ux0qoeAMNa73fo9HFAM0WOQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7443
X-OriginatorOrg: intel.com

PiBGcm9tOiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBNYXJjaCAxMSwgMjAyNSAxOjA3IEFNDQo+IA0KPiBPbiAzLzUvMjAyNSA4OjU0IEFNLCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogVmFzYW50IEhlZ2RlIDx2YXNhbnQuaGVnZGVA
YW1kLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBNYXJjaCAzLCAyMDI1IDc6NDIgUE0NCj4gPj4N
Cj4gPj4gUmlnaHQuIExldHMgc2VlIGlmIGJlbG93IGZsb3cgY292ZXJzIGFsbCB0aGUgcmVxdWly
ZW1lbnQNCj4gPj4gICAtIERlZmluZSBuZXcgZmxhZ3MNCj4gPj4gICAgIElPTU1VX0hXUFRfRkxB
R1NfU0FUUyAvIElPTU1VX0hXUFRfRkxBR1NfQVRTDQo+ID4NCj4gPiBTQVRTIHBvbGljeSBzaG91
bGQgYmUgbWFuYWdlZCBieSB0aGUgc3lzIGFkbWluLCB3aGlsZSBBVFMgZmVhdHVyZQ0KPiA+IGl0
c2VsZiBjYW4gYmUgb3B0ZWQgYnkgdGhlIHVzZXIuDQo+IA0KPiAidXNlciIgeW91IG1lYW4gbGlr
ZSBpb21tdWZkIGR1cmluZyBkb21haW4gYWxsb2NhdGlvbj8NCg0KeWVzDQoNCj4gPj4NCj4gPj4g
ICAtIER1cmluZyBwcm9iZSgpIGRyaXZlciB3aWxsIHVwZGF0ZSB0aGlzIGZpZWxkIChzaW1pbGFy
IHRvIG1heF9wYXNpZHMpDQo+ID4+ICAgICBJZiAoSU9NTVUgbmVlZHMgU2VjdXJlIEFUUyBhbHdh
eXMpDQo+ID4+IAlpb21tdV9kZXZpY2UtPmF0c19mbGFnID0gSU9NTVVfSFdQVF9GTEFHU19TQVRT
DQo+ID4+ICAgICBlbHNlIGlmIChkZXZpY2Ugc3VwcG9ydHMgQVRTIGFuZCBJT01NVSBzdXBwb3J0
cyBTZWN1cmUgQVRTKQ0KPiA+PiAJaW9tbXVfZGV2aWNlLT5hdHNfZmxhZyA9IElPTU1VX0hXUFRf
RkxBR1NfU0FUUyB8DQo+ID4+IElPTU1VX0hXUFRfRkxBR1NfQVRTDQo+ID4+ICAgICBlbHNlIGlm
IChkZXZpY2Ugc3VwcG9ydHMgQVRTIGFuZCBJT01NVSBzdXBwb3J0cyBBVFMpDQo+ID4+IAlpb21t
dV9kZXZpY2UtPmF0c19mbGFnID0gSU9NTVVfSFdQVF9GTEFHU19BVFMNCj4gPj4gICAgIGVsc2UN
Cj4gPj4gCWlvbW11X2RldmljZS0+YXRzX2ZsYWcgPSA8Tk8gRkxBR1M+IChNYXkgYmUgaGF2ZSBv
bmUgbW9yZSBmbGFnDQo+ID4+IElPTU1VX0hXUFRfRkxBR1NfTk9fQVRTKSA/DQo+ID4NCj4gPiBI
ZXJlIHRoZSBkZXZpY2UtPmF0c19mbGFnIHNob3VsZCBiZSBtb3JlIGFuIGF0c19wb2xpY3kgdGhp
bmc/IEF0DQo+ID4gcHJvYmUgdGltZSBpdCdzIGFzc2lnbmVkIHdpdGggYSBkZWZhdWx0IHBvbGlj
eSBhY2NvcmRpbmcgdG8gZGV2aWNlDQo+ID4gdHlwZSwgcGxhdGZvcm0gcmVxdWlyZW1lbnQsIGV0
Yy4gYW5kIGxhdGVyIGV4cG9zZWQgdmlhIHN5c2ZzIGZvcg0KPiA+IGFkbWluIG9wdC4NCj4gDQo+
IFJpZ2h0LiBXZSBjYW4gY2FsbCBpdCBhcyBhdHNfcG9saWN5IChleHBlY3RlZC9kZXNpcmVkIG1v
ZGUgYnkgSFcgZHJpdmVyKS4NCj4gU28gbm93IGNvcmUga25vd3MgSFcgcmVxdWlyZW1lbnQuIEFs
c28gZGVmYXVsdCBhbmQgZ2xvYmFsIHBvbGljeQ0KPiBlbmZvcmNlbWVudA0KPiAodmlhIGtlcm5l
bCBjb21tYW5kIGxpbmUpLg0KPiANCj4gRHVyaW5nIGRvbWFpbiBhbGxvY2F0aW9uLCB3ZSBjYW4g
ZW5mb3JjZSByZXF1aXJlZCBkb21haW4gc3BlY2lmaWMgcG9saWN5Lg0KDQp5ZXMNCg0KPiANCj4g
DQo+ID4NCj4gPiBBY3R1YWwgYXRzIGVuYWJsaW5nL2VuZm9yY2VtZW50IGlzIGRvbmUgYXQgYXR0
YWNoIHRpbWUsIGFjY29yZGluZw0KPiA+IHRvIGF0c19wb2xpY3kuDQo+IA0KPiBUaGVuIGR1cmlu
ZyBhdHRhY2hfZGV2KCkgd2UgcGFzcyB0aG9zZSBmbGFncyBhcyBhcmd1bWVudD8NCg0KdGhlIHBv
bGljeSBpcyBhbHJlYWR5IHN0b3JlZCBpbiBpb21tdV9kZXZpY2Ugc28gbm8gbmVlZCB0byBwYXNz
Lg0KDQphbmQgdGhlIGRvbWFpbiBhbHNvIGluY2x1ZGVzIHRoZSBhdHMgZmxhZyBhdCBhbGxvY2F0
aW9uIHRpbWUuDQoNClRoZW4gbG9va3Mgbm8gbmVlZCB0byBwYXNzIGFkZGl0aW9uYWwgZmxhZ3Mg
YXQgYXR0YWNoPw0KDQo+IA0KPiA+DQo+ID4+DQo+ID4+DQo+ID4+ICAgLSBCYXNlZCBvbiBkZWZh
dWx0IHNldHRpbmcsIGtlcm5lbCBjb21tYW5kIGxpbmUgb3B0aW9uIGFuZCBwcm9iZSgpIGRhdGEs
DQo+ID4+IGNvcmUNCj4gPj4gbGF5ZXIgY2FuIGFkanVzdCBBVFMgY2FwYWJpbGl0eS4gaS4gZS4N
Cj4gPj4gICAgICAtIElmIHdlIGhhdmUga2VybmVsIGNvbW1hbmQgbGluZSAoc2F5IGlvbW11LmF0
cz08eD4pLCB1c2UgdGhhdCBkYXRhDQo+IGZvcg0KPiA+PiBhbGwNCj4gPj4gQVRTIGNhcGFibGUg
ZGV2aWNlLg0KPiA+PiAgICAgIC0gSWYgbm90LCBhcHBseSBkZWZhdWx0DQo+ID4+ICAgICAgIHVu
dHJ1c3RlZCBkZXZpY2UgLT4gZm9yY2Ugc2VjdXJlIEFUUyBvciBubyBhdHMNCj4gPj4gICAgICAg
SWYgSFcgbmVlZHMgU2VjdXJlIEFUUyBhbHdheXMgLCBlbmFibGUgU2VjdXJlIEFUUw0KPiA+PiAg
ICAgICBGb3IgYWxsIG90aGVyIGNhc2VzIHVzZSBBVFMNCj4gPg0KPiA+IHRoaXMgaXMgYW4gaW50
ZXJlc3Rpbmcgb25lLCBpLmUuIHdoZXRoZXIgd2Ugc3RpbGwgd2FudCBhIGdsb2JhbCBpb21tdQ0K
PiA+IG9wdGlvbiB0byBlbmFibGUgc2F0cyBmb3IgYWxsIGFwcGxpY2FibGUgZGV2aWNlcy9kb21h
aW5zLiB0aGUgcHJvcw0KPiA+IGlzIHRoYXQgaXQgaXMgc2ltcGxlIGFuZCBhbGxvd3MgdW5kZXJs
eWluZyBkcml2ZXIgdG8gYWRkIHNhdHMgc3VwcG9ydA0KPiA+IGJlZm9yZSBhIG1vcmUgZmxleGli
bGUgc3lzZnMgaW50ZXJmYWNlIGlzIHJlYWR5LiB0aGUgZG93bnNpZGUgaXMgdGhhdA0KPiA+IGl0
J3MgdW5jbGVhciB3aGljaCBkZXZpY2UvZG9tYWluIHR5cGVzIGFyZSBhZmZlY3RlZCBieSBzYXRz
IG9uDQo+ID4gZGlmZmVyZW50IHBsYXRmb3JtcyB3L28gZGlnZ2luZyBpbnRvIHRoZSBodyBkZXRh
aWwuLi4NCj4gDQo+IEkgcHJlZmVycmVkIGdsb2JhbCBvcHRpb24gKHRoYXQncyB3aHkgdGhpcyBw
YXRjaCBhZGRlZCBhbWRfaW9tbXU9c2F0cykNCj4gYmVjYXVzZQ0KPiBhcyB5b3Ugc2FpZCBpdHMg
c2ltcGxlLCBjYW4gYmUgZW5mb3JjZWQgYXQgZ2xvYmFsIGxldmVsLiBBbHNvIHcvIHN5c2ZzIGlu
dGVyZmFjZQ0KPiB3ZSBoYXZlIHRvIHVwZGF0ZSBmb3IgZWFjaCBkZXZpY2UvZ3JvdXAgaW5kaXZp
c3VhbC4gQW5vdGhlciBkcmF3YmFjayBpcywgdy8NCj4gc3lzZnMgZmlyc3Qgd2UgaGF2ZSB0byB1
bmJpbmQgdGhlIGRyaXZlciAod2hpY2ggbWF5IG5vdCBiZSBwb3NzaWJsZSBhbHdheXMpLA0KPiBt
b2RpZnkgQVRTIHNldHRpbmcsIHRoZW4gYmluZCBkcml2ZXIgYWdhaW4uDQo+IA0KPiBJbiBTdW1t
YXJ5LCBJIHZpc3VhbGl6ZSBpdCB0aHJlZSBsZXZlbDoNCj4gICAtIERlZmF1bHQgcG9saWN5IGlt
cGxlbWVudGVkIGluIGtlcm5lbA0KPiAgIC0gR2xvYmFsIHBvbGljeSBlbmZvcmNlbWVudCBieSBh
ZG1pbiB2aWEga2VybmVsIGNvbW1hbmQgbGluZQ0KPiAgIC0gUGVyIGdyb3VwL2RldmljZSBsZXZl
bCBlbmZvcmNlbWVudCB2aWEgc3lzZnMNCg0KdGhhdCBzb3VuZHMgbGlrZSBhIHBhdGggZm9yd2Fy
ZA0KDQo+IA0KPiBEbyB3ZSBuZWVkIHNvbWV0aGluZyBmb3IgaW9tbXVmZC92ZmlvPyBXaGVyZSB1
c2VyIGNhbiB0ZWxsIGRlc2lyZWQgbW9kZQ0KPiB3aGlsZQ0KPiBhbGxvY2F0aW5nIEhXUFQgZG9t
YWlucz8NCj4gDQoNCndlIHNob3VsZCBub3QgYWxsb3cgdGhlIHVzZXIgdG8gY2hhbmdlIHRoZSBh
dHMgbW9kZS9wb2xpY3kuIEp1c3QgdGhlDQpvcHRpb24gd2hldGhlciBhIGh3cHQgbmVlZHMgYXRz
LCBpLmUuIGZyb20gZnVuY3Rpb25hbGl0eSBwLm8udi4NCg0KVGhlbiB3aGV0aGVyIHRoaXMgcmVx
dWVzdCBjYW4gYmUgc2F0aXNmaWVkIHN1YmplY3RzIGZyb20gdGhlIGF0cw0KcG9saWN5L21vZGUg
c2V0IGJ5IHRoZSBhZG1pbmlzdHJhdG9yLg0K
