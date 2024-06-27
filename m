Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50456EEAE
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719446462; cv=fail; b=g/wyBkcAy1hLohCtfBl+b0UjGwVsflO4lTw9xPzOhMBSIbfCNocZ3XRaqDuOnvVLCt/FryRogFPgeUXSJjOxwtwgbtvzLSdHMAQSldhoVZ4U3tUig/hpxUJf8Ps1DIU44BREPxiX/jRNOAyYt6TB71xWbFr3rq++rUvLyc0FjY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719446462; c=relaxed/simple;
	bh=k724o57brpz9K851F5M6cLdN5C176652QlnTFP7eWt8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LJHeDeQu4lbAE5vbEcHTVvBjhhkWGWkMEi/ZcDuOR3MY9R4TTLIIfuobcoJOemyJqmagDSyvAzCwz6+FHCozoRZNV019bdcxSsVmNFnPNzff+Pu0eUeItbYqc0asPM9cLAW7NUmhdR9uUyC8PJVbvpxTPTfvnP7ID2PQqT2fE38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU3gckWo; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU3gckWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719446460; x=1750982460;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k724o57brpz9K851F5M6cLdN5C176652QlnTFP7eWt8=;
  b=PU3gckWo626ypvDueX0cTXQ09T5S58LXYi0Y+K3kHlir4P+MQB+dmFiH
   A8yL1R3xanN5Lcy6IfGmVfTNqduydw3hYFpHq2QpTk1ThCYV3aPGRk7hl
   5rLDwv/0EdMX5s50NAepqhgYJoDAKg34lpSckM9IKdfL56qo8oAajDq3V
   jDwetSq9SQYEI+hZ0LOpEICI9GoSqk79W/ICCBdv8RYnjgm1Wm7mBL1ow
   0JXktBFdzxiSqiz1EJ2DibYhOvwfdD1Zn1moQ2nNgkZEXk4IjaLkjmlVQ
   cwFSmq7gGaplE5OIhmfxyVqPLngm1+ZKdgh9+pMSJrYaq3/+lIPFlj3Pq
   Q==;
X-CSE-ConnectionGUID: qyC2MyhCT9qdV7bzF0IAwQ==
X-CSE-MsgGUID: 8izwhUfZT2mW/6KFDBSv3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="34082489"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="34082489"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 17:01:00 -0700
X-CSE-ConnectionGUID: B3hl7SduQGSJ7Alr9HbXag==
X-CSE-MsgGUID: yl8n4w5+QDCuFH8OikfNUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="49105614"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 17:00:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 17:00:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 17:00:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 17:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4lWmDNtPndVvpovEo73x8MnIyM0+ePjp/CsiJ2APW8ti+jofcFruuynCnQtGX6asWCR3IHFrrGL8RLAtNXJauWMF319gKk0q1T84qEYnr+RunfpYScxmBImzJm1baasPcW6c1GgUzvIAN2d3xpq1qyHgCW6gpoC50MUIiDThSCWm300nMy8Of5r0p8pUKV40oWZzc4HEDWAFX0WFDef835NbTlEVLEvnaME2M89v6HD7ko/TbQTh5m51mmUAQroaOX7IjcdqYHXOrzmE/FqRIhYW56qA27OQmQi6owommOFFvZclPWURKGSWo5Yeu08Gx0zC+jq/WDwhB4re+mVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k724o57brpz9K851F5M6cLdN5C176652QlnTFP7eWt8=;
 b=MjjhoXPGC0CrUVIFXimaa/XGnlGxLb/5kt+xWYhws0DCXkJUuNqchiBlNVN/Rv8tuf86x9yrXLSKdLl1JWHPtdVPFXI6FA1NapgpaTGvgUgp5pez8mgVIknd56h0lf+L1181JLKu1SwNecket8U/t+FX6JqxMeULxIGujrgp705f4IfJAPg3FgdjiZz5a85fvzwfrOZFnokznTVIQhrJgvHfUPyiqsjggFmjqg+GGpv1yi00Y+kNClaMjklCPYCGYv3W0Ymx1PzVxqy8s4YHuamRpcgZq2zbl4ta1/LYNSrwPHt9YYv5GhAVce+TWchZvyzXITRKEA3DA1YtBOKBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 27 Jun
 2024 00:00:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 00:00:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
Thread-Topic: [PATCH] iommu/vt-d: Refactor PCI PRI enabling/disabling
 callbacks
Thread-Index: AQHat8ObQWY41YP24UCgm5nqr/HB3rHZuRFggABqV4CAALbIwA==
Date: Thu, 27 Jun 2024 00:00:56 +0000
Message-ID: <BN9PR11MB52763CC7D59269696F0C22998CD72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240606034019.42795-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E8767AB63378C81130528CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e3888b78-c787-4a2d-bd43-7dcddc2b5bb9@linux.intel.com>
In-Reply-To: <e3888b78-c787-4a2d-bd43-7dcddc2b5bb9@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4999:EE_
x-ms-office365-filtering-correlation-id: 8fcf0b93-ae1d-4377-59bc-08dc963c37ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZnoxdmdkM1NWVjAvYnM2SU9ITml4bStYM0ptRnRMckFpREt3VXJWamJReUlr?=
 =?utf-8?B?aE1WVHlOcEpvT1dYT0VZNFBmMmhxbWtMNDdzbzJoWjFISDBRUTVHMGx2R0pW?=
 =?utf-8?B?ZkptelJrbTUrNVladjdkdm9NUFB6eXQ3RUFzM2pRd1E1cnNZbElXUWk3K0pV?=
 =?utf-8?B?SHloZFNXb3ZKemtVbXdjcHB4dnpqdWZYTjN5UXF1amJXamV0ZTIwS3crSVIx?=
 =?utf-8?B?K2ZNVHlzVlpDdkYzVXo0SzRzSWJZeW1LUGJyWmJYd1NDaExTNGpuOExSWUVR?=
 =?utf-8?B?RmdXVk44UVBPZVJRVStuZTJEMSs4cGxpaXRsSUZyUm9XT3BMdWRuQlMyVWNH?=
 =?utf-8?B?Rzh5c0k0TGFUc0ZsMy90UW9ad1lCTTBYMzhELzc3bjU3WGdqYUFneXlVZHQy?=
 =?utf-8?B?aVdod2wyRDNwbUVVQ2VtZDhrZzlJdmVqNStyYjZwbklDUlZtbGdFaUVmSmtW?=
 =?utf-8?B?aGlORVhwMisxNW5QZnhaemRLVGx3ZkxyWC81Ri9GQ0wxdVBHZzlzempxTVN6?=
 =?utf-8?B?NSt1RUpBZ29sQ1ZVZ3NuT3ZBQi9LK21WUkJmZm1CRjY5Um1mRkxDc3Z3SnpJ?=
 =?utf-8?B?dG9STFZleWtkUlgxb05lNVM5S2pKMXRjendZVllxMGhMekt5WU1vcFlXd2s1?=
 =?utf-8?B?RWk4aEUvS2hmWHNvRjZ4aUZaRWZoU3haNGxlY3YwbEs4TlZFdkVZU29VVUUw?=
 =?utf-8?B?OTZnOTZjSWY0VGt1MXJnd3B0RjJadTRnL0lYc3dPQjE1VWFQcXRDUkNUMGdh?=
 =?utf-8?B?MmwxM2VlWWk0a2dXN2gxL0k4Ykovc2cvSmhTeGNDVnZnNG52aHhuazVNdTJq?=
 =?utf-8?B?dDFZSHJmb1JYOVhTTWJ4NUI0VmJnYkl2RG1zVzFzMHlJeFRQaFJUK1RJb0pt?=
 =?utf-8?B?YjlaV3ZWWFVyTGY3L2xDcnFRZ2hXZ3I5eTBTWTlHeWIrWnFMOUxpUk9Gcmls?=
 =?utf-8?B?MFV1RnpFUGdKUm05R0RrRGVGOE9UQXJkem9WMndnYUdkVXVyTVpXSjJLdFlG?=
 =?utf-8?B?TDd5T24vVzZaNDBOTjBxMTlvS0JFOXFCNllzTkl2eDFVMHdpZnh0N2Fncm0y?=
 =?utf-8?B?R09VQk5wS0NWa256cm42U1dLaWI0RnBIMHVuc1Z5TEtJcVZZaVh3SzZKYklv?=
 =?utf-8?B?NEN6QXJhNkhnYlZBU2llMWkxSmVzeVdHeW5iaTRzNWNBWFRZK2VFMG9GQ3NB?=
 =?utf-8?B?dXY3VWo0Q2ZnQldzdkdhRUlJQ1luOGYyVHpvR3B5d0o5SGZUSUczWmNtc25j?=
 =?utf-8?B?d2preE8xSG9WZ3Y0am01dlcwcklPTzJtN0pSTklQaTlhdDhWZ2dXS1IyZ3lG?=
 =?utf-8?B?KzBab3JQU0IreTY0cjZGTXlYbVU2Y3YzS0V1Uk5ZZ2xxT2E1NWJoZVBkVk4z?=
 =?utf-8?B?R2hHRHFMWHpsbllzc2wxdFI1UG01ZGNldmpxY1VjbW1hR1BWcGMxc3g5d0Nn?=
 =?utf-8?B?YlRJaGdSZm9JZy9HQk1IUnQzcUcycU5PK2lFVlZTdjZSZWlPVFR0djYxTDF0?=
 =?utf-8?B?TXd3Y2NaTFlXR1NHQWpmMGVMdmM3bmc2dHhhUm11M2NwS214M0t3anZEdTI0?=
 =?utf-8?B?TDFjSktja0lmckY1VFpKTXozUEpma1ZHVVl4NVJaV0Qyeklya3dNV1FRUDl6?=
 =?utf-8?B?N3ZsSXorb3l3TDJNY2NzZWwvSnFYb3lBcFdKSDYzeU0zbVdodURpd3NQR3RU?=
 =?utf-8?B?WW1rc2tpWWxBT2RVMDE3aG5TaFQwK3VBQkNPOHFmaGpLcy9ZMGltbzdzdmxx?=
 =?utf-8?B?aUsxVDlGWlVTWkhGa1dVM1VybEYxenpTTnR4cXNiLzg5RDk0bElMZTVTVjZs?=
 =?utf-8?Q?OJ/ecEgoGvWJgOzeOyc6GxMfXMOaeHYnqvyn8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0dORms5MnBvMDV2cTY5bUNlZFNIbFJaN2VZazljem9vM1U0MUVVZ3JPMitm?=
 =?utf-8?B?TTN2VHZLVWxIYWZ2WTNyTG1zNVh1WllYNWI1akhFdFVvWjltd280TWZ4ZFNm?=
 =?utf-8?B?bW1HQUtpTVE2TFFTa3NZYStRT1dueGZwcktTd2wvZnNOem9tMGdnUUh3aEVO?=
 =?utf-8?B?cmNUeE15dytMeXM4YWllL0VEY0E4NmxURmgrL0c5cHpTOXlwb3JPTzgzTGJM?=
 =?utf-8?B?Q1NpMENSRUdXMnovQTJCNG8yWjM2d3l3Zkl0b2l3cXVxc3RkQTJlcUE2Mzg4?=
 =?utf-8?B?QURxMFBKNFFLaXV1RXVBUmZaRk9sWG5RRWgyQTRXRHJoTUJrZ0hrbGdiSS9t?=
 =?utf-8?B?R2dGRUgrK2JsYzdXbk14WHlXejhqT1ZlKzFxTFFtVEx0ZmhhQ2ZaMmt2L05r?=
 =?utf-8?B?USt3bTk5RWlVY2ZWWjFBTTJxTkM5cGdNTHZ2TDhQTkh1S3JZd1ZTQWVqUWdU?=
 =?utf-8?B?enM1VXRUY0FsUmFJb29DVjg4QTlqZGRjREU4a1p3WStVcEFmWENkR3p6NkQ1?=
 =?utf-8?B?Um1nMHplUFBYRWQ0YXBVSG9lS3dZTTByZmI3UjRNM0Z0WHk4ZC9IeDdNaGZQ?=
 =?utf-8?B?Qlhqb1hRVTVxenloR3h3eEhVeUl5Q2F6QWVVMVczcmZwVnRGQW9lZjVnSlpt?=
 =?utf-8?B?NFVma3JZVzQ0MGxVOUhZemozWTlCaFd6NFliMWZZdW94a25Vb2hHa0R3RjlS?=
 =?utf-8?B?d0RmVlkybGIvNGxZSUR1ek1yRHI0TzlBTUZaUWxMazhtVGQ2WThpYTZKR2pV?=
 =?utf-8?B?b1lON0pHTFB3emVyRHU4UzUzbXd2UXY0OWJISXNYVzVXQ3VDTVdrY054Sytr?=
 =?utf-8?B?MjNsT1cyUERQT2hGMitxWlBxMXJlMTIwM2VjT2Y0aDV0S3ZUbGg5VG5hLzBC?=
 =?utf-8?B?Z3FhcXZXcmowaTA4OWh4RW1hOXV5SjRLc2FWK1c5RnY1VE91cmM2WnBHQ1Rt?=
 =?utf-8?B?clhPNVB6bEZIUlZyakpTU0dhYmh0NC81QUFuZ0NpNHc4SGJDUURJYXFyVm1M?=
 =?utf-8?B?Wkd2OU9wbVVkM2JmT2F5VWg3OEd1RlNVNTlpU2J6SFZXNUg2bE9oNGVQaStT?=
 =?utf-8?B?OU9hbWdCZStOS2JOd2kwa2JsdUtFZURpVkc3RjZkVTV6UHhGdVBHRHo2cit0?=
 =?utf-8?B?Si9oRkpuelgyeWR3RUxBdzdxRjZwYjBBcTRqbmJEU1VET3RkY0hMQ2RQSFJz?=
 =?utf-8?B?bzJtdnduMjk1VkI4ZUw2ZGtGUUQwaDUwOFA3M092d0thVW5wR3d5Tlhmc3Fn?=
 =?utf-8?B?TWlmTS8wZkFnVDBEVVZBTzVpOCt6ZktWTVM4b2QwaUI1QWtiSEpzazNpM2da?=
 =?utf-8?B?NStheGpKdVZoV09oYzBWUWhsMXlrSkxFZEZ0d1JidjFKRXg1MWRNaDBBSWtQ?=
 =?utf-8?B?ZG9MZHJhZlFFR0orQmFJMG5XbFBOYzBiZGRvWVlWNERpQUVVSHZ6Zk9UT1VD?=
 =?utf-8?B?YlpBQm45RDNtUDN2amt0eXpuSnNPS01vdGJ4SnZHYkozL3F3aDNKTkp1YWRi?=
 =?utf-8?B?TzZSNnRoVXZTQXdONVJGb2RZdmdJNEJSd1d1dU4rWlNoVmdDM21HT1JaL3NC?=
 =?utf-8?B?SkJaWFVmS3NyUmwzQ0ZuWVZvRitic1JNMlpNL0E0Rk1NZ2tzNUYzNUpzNzdX?=
 =?utf-8?B?U2pTQkswdXdHNkpmRlRTVk9rT0tmbk9iY1dUOCtxNXo1S2IrKzJOSm5DcDNt?=
 =?utf-8?B?ejdoeS9rTDZKVjRPUEpsRnVsYzFwWFR2TkJlaERwdlc4UmJqcm9lUUJLbmNs?=
 =?utf-8?B?dnFqK3ZSbzUzWVhlTVNrekJLSThMeFU1NGZxZG56TmxLOVBBek9mSkpKclJa?=
 =?utf-8?B?MHc5Uk9qRktWc0FtVVVVNzBOdm1meVE5R1ZSajZMMXpFV2RFWXFKZU9XRGlG?=
 =?utf-8?B?eWJhOU56blR5akRKcEhENExiaFRoMm0wVGZGWDBZTnErRUJJMGhMOU1ONVV1?=
 =?utf-8?B?OFZsZmlkTlBHOUhtOUFRUVY4R1pjV3lNOTJDcTZxUEVEbkJwYmFMbmJMaFRU?=
 =?utf-8?B?VHVqZVpSMDNyTExCSmV2WXorSzJyWXZLa2l4dmN6bTVpMDQ2OTVjZ2p3WHM0?=
 =?utf-8?B?cmxLZFlua3lkR2pXMGtSc3BBYUF5ai9CdTJSV0RIOUtVOXJsajk1N0l1czk0?=
 =?utf-8?Q?VNAdajxNYbEg2k+IxswGQNE62?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcf0b93-ae1d-4377-59bc-08dc963c37ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 00:00:56.0872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0h3BMCnFRVrpkXAJJDCpIFHl52sThzKPpCEbHZ/DIjAYejuEjLBx/54ZbWeyJ/IJJTX+H6CYh0ZoWXYqp9BJOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEp1bmUgMjYsIDIwMjQgOTowNSBQTQ0KPiANCj4gT24gMjAyNC82LzI2IDE0OjUzLCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEp1bmUgNiwgMjAyNCAxMTo0MCBBTQ0KPiA+
Pg0KPiA+PiArLyoNCj4gPj4gKyAqIEludmFsaWRhdGUgdGhlIGNhY2hlcyBmb3IgYSBwcmVzZW50
LXRvLXByZXNlbnQgY2hhbmdlIGluIGEgY29udGV4dA0KPiA+PiArICogdGFibGUgZW50cnkgYWNj
b3JkaW5nIHRvIHRoZSBTcGVjIDYuNS4zLjMgKEd1aWRhbmNlIHRvIFNvZnR3YXJlIGZvcg0KPiA+
PiArICogSW52YWxpZGF0aW9ucykuDQo+ID4+ICsgKg0KPiA+PiArICogU2luY2UgY29udGV4dCBl
bnRyeSBpcyBub3QgZW5jb2RlZCBieSBkb21haW4taWQgd2hlbiBvcGVyYXRpbmcgaW4NCj4gPj4g
KyAqIHNjYWxhYmxlLW1vZGUgKHJlZmVyIFNlY3Rpb24gNi4yLjEpLCB0aGlzIHBlcmZvcm1zIGNv
YXJzZXINCj4gPj4gKyAqIGludmFsaWRhdGlvbiB0aGFuIHRoZSBkb21haW4tc2VsZWN0aXZlIGdy
YW51bGFyaXR5IHJlcXVlc3RlZC4NCj4gPj4gKyAqLw0KPiA+PiArc3RhdGljIHZvaWQgaW52YWxp
ZGF0ZV9wcmVzZW50X2NvbnRleHRfY2hhbmdlKHN0cnVjdA0KPiBkZXZpY2VfZG9tYWluX2luZm8N
Cj4gPj4gKmluZm8pDQo+ID4+ICt7DQo+ID4+ICsJc3RydWN0IGludGVsX2lvbW11ICppb21tdSA9
IGluZm8tPmlvbW11Ow0KPiA+PiArDQo+ID4+ICsJaW9tbXUtPmZsdXNoLmZsdXNoX2NvbnRleHQo
aW9tbXUsIDAsIDAsIDAsDQo+ID4+IERNQV9DQ01EX0dMT0JBTF9JTlZMKTsNCj4gPj4gKwlpZiAo
c21fc3VwcG9ydGVkKGlvbW11KSkNCj4gPj4gKwkJcWlfZmx1c2hfcGFzaWRfY2FjaGUoaW9tbXUs
IDAsIFFJX1BDX0dMT0JBTCwgMCk7DQo+ID4+ICsJaW9tbXUtPmZsdXNoLmZsdXNoX2lvdGxiKGlv
bW11LCAwLCAwLCAwLCBETUFfVExCX0dMT0JBTF9GTFVTSCk7DQo+ID4+ICsJX19pb21tdV9mbHVz
aF9kZXZfaW90bGIoaW5mbywgMCwgTUFYX0FHQVdfUEZOX1dJRFRIKTsNCj4gPj4gK30NCj4gPj4g
Kw0KPiA+DQo+ID4gdGhpcyBpbnZhbGlkYXRlcyB0aGUgZW50aXJlIGNhY2hlL2lvdGxiIGZvciBh
bGwgZGV2aWNlcyBiZWhpbmQgdGhpcw0KPiA+IGlvbW11IGp1c3QgZHVlIHRvIGEgUFJJIGVuYWJs
ZS9kaXNhYmxlIG9wZXJhdGlvbiBvbiBhIHNpbmdsZQ0KPiA+IGRldmljZS4NCj4gPg0KPiA+IE5v
IHRoYXQncyB3YXkgdG9vIG11Y2guIElmIHRoZXJlIGlzIGEgYnVyZGVuIHRvIGlkZW50aWZ5IGFs
bCBhY3RpdmUNCj4gPiBESURzIHVzZWQgYnkgdGhpcyBkZXZpY2UgdGhlbiBwYXkgaXQgYW5kIHBl
bmFsaXplIG9ubHkgdGhhdCBkZXZpY2UuDQo+IA0KPiBZb3UgYXJlIHJpZ2h0LiBXZSBzaG91bGQg
bm90IHNpbXBsaWZ5IHRoZSBmbG93IGxpa2UgdGhpcy4NCj4gDQo+ID4NCj4gPiBidHcgaW4gY29u
Y2VwdCBQUkkgd2lsbCBub3QgYmUgZW5hYmxlZC9kaXNhYmxlZCB3aGVuIHRoZXJlIGFyZQ0KPiA+
IFBBU0lEcyBvZiB0aGlzIGRldmljZSBiZWluZyBhY3RpdmVseSBhdHRhY2hlZC4gU28gYXQgdGhp
cyBwb2ludA0KPiA+IHRoZXJlIHNob3VsZCBvbmx5IGJlIFJJRCB3aXRoIGF0dGFjaGVkIGRvbWFp
biB0aGVuIHdlIG9ubHkNCj4gPiBuZWVkIHRvIGZpbmQgdGhhdCBESUQgb3V0IGFuZCB1c2UgaXQg
dG8gaW52YWxpZGF0ZSByZWxhdGVkIGNhY2hlcy4NCj4gDQo+IFRoZSBhc3N1bXB0aW9uIG9mICJQ
Ukkgd2lsbCBub3QgYmUgZW5hYmxlZC9kaXNhYmxlZCB3aGVuIHRoZXJlIGFyZQ0KPiBQQVNJRHMg
b2YgdGhpcyBkZXZpY2UgYmVpbmcgYWN0aXZlbHkgYXR0YWNoZWQiIGlzIG5vdCBhbHdheXMgY29y
cmVjdC4NCj4gQm90aCB0aGUgcGFzaWQgZG9tYWluIGF0dGFjaG1lbnQgYW5kIFBSSSBhcmUgY29u
dHJvbGxlZCBieSB0aGUgZGV2aWNlDQo+IGRyaXZlciBhbmQgdGhlcmUgaXMgbm8gb3JkZXIgcnVs
ZXMgZm9yIHRoZSBkcml2ZXJzLg0KDQpZZWFoLiBOb3Qgc3VyZSBob3cgSSBnb3QgaXQgd3Jvbmcg
aW4gcHJldmlvdXMgcmVwbHkuIPCfmIoNCg0KPiANCj4gRm9yIGV4YW1wbGUsIHRoZSBpZHhkIGRy
aXZlciBhdHRhY2hlcyB0aGUgZGVmYXVsdCBkb21haW4gdG8gYSBQQVNJRCBhbmQNCj4gdXNlIGl0
IGZvciBrZXJuZWwgRU5RQ01EIGFuZCB1c2Ugb3RoZXIgUEFTSURzIGZvciBTVkEgdXNhZ2UuDQo+
IA0KPiBJIGFtIGNvbnNpZGVyaW5nIHdvcmtpbmcgb3V0IGEgZ2VuZXJpYyBoZWxwZXIgdG8gaGFu
ZGxlIGNhY2hlcyBhZnRlcg0KPiBjaGFuZ2UgdG8gYSBjb250ZXh0IGVudHJ5IHdoYXQgd2FzIHBy
ZXNlbnQuIEhvdyBkbyB5b3UgbGlrZSBiZWxvdyBjb2RlDQo+IChjb21waWxlZCBidXQgbm90IHRl
c3RlZCk/DQo+IA0KPiAvKg0KPiAgICogQ2FjaGUgaW52YWxpZGF0aW9ucyBhZnRlciBjaGFuZ2Ug
aW4gYSBjb250ZXh0IHRhYmxlIGVudHJ5IHRoYXQgd2FzDQo+IHByZXNlbnQNCj4gICAqIGFjY29y
ZGluZyB0byB0aGUgU3BlYyA2LjUuMy4zIChHdWlkYW5jZSB0byBTb2Z0d2FyZSBmb3INCj4gSW52
YWxpZGF0aW9ucykuIElmDQo+ICAgKiBJT01NVSBpcyBpbiBzY2FsYWJsZSBtb2RlIGFuZCBhbGwg
UEFTSUQgdGFibGUgZW50cmllcyBvZiB0aGUgZGV2aWNlIHdlcmUNCj4gICAqIG5vbi1wcmVzZW50
LCBzZXQgYWZmZWN0X2RvbWFpbnMgdG8gdHJ1ZS4gT3RoZXJ3aXNlLCBmYWxzZS4NCj4gICAqLw0K
PiB2b2lkIGludGVsX2NvbnRleHRfZmx1c2hfcHJlc2VudChzdHJ1Y3QgZGV2aWNlX2RvbWFpbl9p
bmZvICppbmZvLA0KPiAJCQkJIHN0cnVjdCBjb250ZXh0X2VudHJ5ICpjb250ZXh0LA0KPiAJCQkJ
IGJvb2wgYWZmZWN0X2RvbWFpbnMpDQo+IHsNCj4gCXN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUg
PSBpbmZvLT5pb21tdTsNCj4gCXUxNiBkaWQgPSBjb250ZXh0X2RvbWFpbl9pZChjb250ZXh0KTsN
Cj4gCXN0cnVjdCBwYXNpZF9lbnRyeSAqcHRlOw0KPiAJaW50IGk7DQo+IA0KPiAJYXNzZXJ0X3Nw
aW5fbG9ja2VkKCZpb21tdS0+bG9jayk7DQo+IA0KPiAJLyoNCj4gCSAqIERldmljZS1zZWxlY3Rp
dmUgY29udGV4dC1jYWNoZSBpbnZhbGlkYXRpb24uIFRoZSBEb21haW4tSUQgZmllbGQNCj4gCSAq
IG9mIHRoZSBDb250ZXh0LWNhY2hlIEludmFsaWRhdGUgRGVzY3JpcHRvciBpcyBpZ25vcmVkIGJ5
IGhhcmR3YXJlDQo+IAkgKiB3aGVuIG9wZXJhdGluZyBpbiBzY2FsYWJsZSBtb2RlLiBUaGVyZWZv
cmUgdGhlIEBkaWQgdmFsdWUNCj4gZG9lc24ndA0KPiAJICogbWF0dGVyIGluIHNjYWxhYmxlIG1v
ZGUuDQo+IAkgKi8NCj4gCWlvbW11LT5mbHVzaC5mbHVzaF9jb250ZXh0KGlvbW11LCBkaWQsIFBD
SV9ERVZJRChpbmZvLT5idXMsIGluZm8tDQo+ID5kZXZmbiksDQo+IAkJCQkgICBETUFfQ0NNRF9N
QVNLX05PQklULA0KPiBETUFfQ0NNRF9ERVZJQ0VfSU5WTCk7DQo+IA0KPiAJLyoNCj4gCSAqIEZv
ciBsZWdhY3kgbW9kZToNCj4gCSAqIC0gRG9tYWluLXNlbGVjdGl2ZSBJT1RMQiBpbnZhbGlkYXRp
b24NCj4gCSAqIC0gR2xvYmFsIERldmljZS1UTEIgaW52YWxpZGF0aW9uIHRvIGFsbCBhZmZlY3Rl
ZCBmdW5jdGlvbnMNCj4gCSAqLw0KPiAJaWYgKCFzbV9zdXBwb3J0ZWQoaW9tbXUpKSB7DQo+IAkJ
aW9tbXUtPmZsdXNoLmZsdXNoX2lvdGxiKGlvbW11LCBkaWQsIDAsIDAsDQo+IERNQV9UTEJfRFNJ
X0ZMVVNIKTsNCj4gCQlfX2lvbW11X2ZsdXNoX2Rldl9pb3RsYihpbmZvLCAwLCBNQVhfQUdBV19Q
Rk5fV0lEVEgpOw0KPiANCj4gCQlyZXR1cm47DQo+IAl9DQo+IA0KPiAJLyoNCj4gCSAqIEZvciBz
Y2FsYWJsZSBtb2RlOg0KPiAJICogLSBEb21haW4tc2VsZWN0aXZlIFBBU0lELWNhY2hlIGludmFs
aWRhdGlvbiB0byBhZmZlY3RlZCBkb21haW5zDQo+IAkgKiAtIERvbWFpbi1zZWxlY3RpdmUgSU9U
TEIgaW52YWxpZGF0aW9uIHRvIGFmZmVjdGVkIGRvbWFpbnMNCj4gCSAqIC0gR2xvYmFsIERldmlj
ZS1UTEIgaW52YWxpZGF0aW9uIHRvIGFmZmVjdGVkIGZ1bmN0aW9ucw0KPiAJICovDQo+IAlpZiAo
YWZmZWN0X2RvbWFpbnMpIHsNCj4gCQlmb3IgKGkgPSAwOyBpIDwgaW5mby0+cGFzaWRfdGFibGUt
Pm1heF9wYXNpZDsgaSsrKSB7DQo+IAkJCXB0ZSA9IGludGVsX3Bhc2lkX2dldF9lbnRyeShpbmZv
LT5kZXYsIGkpOw0KPiAJCQlpZiAoIXB0ZSB8fCAhcGFzaWRfcHRlX2lzX3ByZXNlbnQocHRlKSkN
Cj4gCQkJCWNvbnRpbnVlOw0KPiANCj4gCQkJZGlkID0gcGFzaWRfZ2V0X2RvbWFpbl9pZChwdGUp
Ow0KPiAJCQlxaV9mbHVzaF9wYXNpZF9jYWNoZShpb21tdSwgZGlkLA0KPiBRSV9QQ19BTExfUEFT
SURTLCAwKTsNCj4gCQkJaW9tbXUtPmZsdXNoLmZsdXNoX2lvdGxiKGlvbW11LCBkaWQsIDAsIDAs
DQo+IERNQV9UTEJfRFNJX0ZMVVNIKTsNCj4gCQl9DQo+IAl9DQo+IA0KPiAJX19pb21tdV9mbHVz
aF9kZXZfaW90bGIoaW5mbywgMCwgTUFYX0FHQVdfUEZOX1dJRFRIKTsNCj4gfQ0KPiANCg0KbG9v
a3MgZ29vZCB0byBtZS4NCg==
