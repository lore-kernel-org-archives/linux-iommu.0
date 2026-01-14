Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A15037B3F0
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377257; cv=fail; b=BMqFbcvX2qKJlD/oLNWZT8Pqf4knI6ksw6mD0RmEpVNDFvraRqdJ4aHAjyQkkkf0RtO1UQ8rjB/y70qYMTMEfJDYF0ZahHAsq4OR7khHAAC4epyj5Pcl/YZ6gr+HBC1eJiW5FKWZFyhQkILyMnyaIc6Nr0gqnm+YwDPnQQA0jLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377257; c=relaxed/simple;
	bh=f/jmCG6K99Wmz1POlsrLmTI4fGmBvQMSUTo3Zl/qzTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JZCeYqGmguEmc9HlNS7lCQfLNkxNuWGE5rJJeWcKHQTpoxO1J0sZYXYMyDCIEBDEMrF9SgNHaCweNQoy7cKjj9+BLfnuckVgiLz8kOt3ZYvO0IOdj1K0ItoJCZ37tJqvpUU+11ND7I7lGDjOoGZK5C6m/HRNFWw10Mc/iMBM1Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLUyTSPO; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLUyTSPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768377254; x=1799913254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f/jmCG6K99Wmz1POlsrLmTI4fGmBvQMSUTo3Zl/qzTw=;
  b=VLUyTSPOsEMB6q8hpwlRCpp6hqhky9RK3+QxH1AI1OfpayzPSsr6Jz/E
   6tf8aIRb78OCaqOL7TT+DpFDKkXCtcsetrrWKCoEfo9Eo4F+u3vyn7PZD
   kl1rQF861TUBSA7nz742ymk4eAOzV8/gW2DNIflqa+luc08MZNHajXHVs
   OPIA9sPzy7QzJgWW+M9sox8lsu0q75Ga+EjHqt+3WT+LbhHU10wMuDCIw
   hblP9d2UWnpC6kNSKEcoYRucQDM6K71xLmS3ogMUnzKnP1+xOSj15Y8FJ
   kGY3zi6JEI61Ir2jx0NdA3ISviovUvIsEvjbTlTd9XBV1yFsU3mPlfrdZ
   Q==;
X-CSE-ConnectionGUID: FbF6bRyqQEuF7VSV5fw65g==
X-CSE-MsgGUID: x5Q7xlOARc+KWsipwhDqlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68678088"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="68678088"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:54:13 -0800
X-CSE-ConnectionGUID: X/sLSgC7Q9W+GMmhTKdFow==
X-CSE-MsgGUID: mYr4zUxdQ0CSHTHPrFodLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209069762"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:54:12 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 23:54:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 23:54:12 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 23:54:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMTDn+7vLRJA9qHwn4peO8pRhcs+V8H8S0zuFY70gLnWVZiOiAGKClETf6LOLrgE9qbhfqgNNGWtat3vEpbCh6hNhsb7yKShfHQ3fA180GATlZI49w2uktgC2GcZiJzlf23InF8+T3AAqr/nGMKGLzL8YBnTPIEgHQ6tNRoiJpSVFKpqUQyko9SG4yje2+8aKLPZx8q/bImgx9FEJtF/XWKKJJgF74p5wmEDg+C6VIYdm8qTUeaUQHoNOluwX3fw+figXzLedrg2oKrN6ALoBBOI0xG+7hgf7WZE0VU6ukTviIihouT6QBuWQcv2wfvZThG+Azr/UjBZlh4572Imeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/jmCG6K99Wmz1POlsrLmTI4fGmBvQMSUTo3Zl/qzTw=;
 b=mOV8Ygu9ClmjUBOd8KxeT7NWX2uiGoql5JP0YMKL6PlVSgSr2AUtwsK+ZmhHyipSq9LGGLJuSKEodxkGsIuyXAVk6vEm5sYEm4zXorrymRunf9KgDkM9vCgYXHn6lJpV5vtQ9JM0E7rFh+e3m/Y1wsRdA1j34YN9D3txi7RPJGkVSxrv1ExPXWvdXkruagObDJdVPOMhnuNDytsT+9APERUG6CAEdSYejYtvCCsj4cLXovudPwXG1orHo3UjLTfTudUfwobiIQnKYiaPpXWeAvwsFh+SfIWMyPMDLiZC6yqxGurZloXyuu+HHqPNQh+X5kDyJPG36BuNePCamdNVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6545.namprd11.prod.outlook.com (2603:10b6:510:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Wed, 14 Jan
 2026 07:54:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 07:54:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
	<skhawaja@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Thread-Topic: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Thread-Index: AQHchDk4W/6+cv58J0mVdTDrdjg0/7VRR2ww
Date: Wed, 14 Jan 2026 07:54:10 +0000
Message-ID: <BN9PR11MB5276EFACF8AA21215568550F8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
In-Reply-To: <20260113030052.977366-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6545:EE_
x-ms-office365-filtering-correlation-id: ea6e280a-0b2c-4dc0-c47e-08de53421a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TDZ4RDhrQzFzWCt5WHA1azBpN1NIdFpXTzVRVTI1bEN5RXJTdU00QUU3eHRo?=
 =?utf-8?B?QUtBd2hNQktzOW05Rk0zTzNMNnQwMXA2YUxDdzZPSEcxY1NpK1RkVUgvaG82?=
 =?utf-8?B?UWlVWDdyL2JTdFh5a0pCRE5nZWh4eVVESTRRT2xKU0ZMWWk4RUhENGlzbXhW?=
 =?utf-8?B?Z2ZRTUlPTTg3Ulo1VFc1WitHck12RnBiNnhMRzdnNmRDQXpGYTNMaktGR1Ur?=
 =?utf-8?B?OTdvdlpDTWk4Y1BOQm1IMnhZY29IU0daWDZxQUk1QVNER211WmVhV1pTZ1pU?=
 =?utf-8?B?ZFlsdUlMeldtYndLM1VlSkM1UWNUanRjaGRrNVlDTi9BcWp6NFZXaU43Uk1y?=
 =?utf-8?B?YVFDSUVmN2g4ek8vL29JUTFnTkpORFlWRlBLVzY0Y1hYVWNSRUlXZXM4Q3Fp?=
 =?utf-8?B?SUFsTUI1d0Z0UmVNdUpKUEMxb3ZTSXpGVnJGaHJsblJhaVlLMkp4ZlJnWmNP?=
 =?utf-8?B?aHRLbnNCZnpkSmR3UG04NlRxRFdtWnlPYnF6bGptRytCRUVOQ0ZhK2tTa2lr?=
 =?utf-8?B?TUthb0RTK29kWVNJZ1luOW00TVVxTEw3eHVJUTYvV1dkWC9EcTIzTTdXR3pZ?=
 =?utf-8?B?bW0xOG5CbDAzU01NQlNaWCtUQktuWnlGUU5LLzRSVnJaNzh2RFlPZURUczFx?=
 =?utf-8?B?UE0zNlQ4ZkJSUDNlU1BCb2U3bFFocmFZditJMXhocHZqbDhxUGxhRHRvS1or?=
 =?utf-8?B?WWc1VFBQbEhpY0hsOEdvRnV2Y1ZhWktzMGRlc3NLZlY5cXczVEU1SVhOc0No?=
 =?utf-8?B?dVM2MmZqQU5tZVgyRXlwMDJXL1N5emF4Mkt6S0x2cHVLUk5ZZ3NnWUtnU1oz?=
 =?utf-8?B?cWpER01ldDM4NWxDaGltRDlDMVF4NjBhZTZlTEUrcnp2R1g1ZSs5T1FibE13?=
 =?utf-8?B?Vi94Zk5YbUQ4ZFZHTDBTcG5JNTJHejFDMFlZdlJCTk10RXBLYkFINXg2Y09m?=
 =?utf-8?B?ZEhZVWJKaFNrYm5EWXU5YXppTG1WcitiYlR4ZjQycFBkSEluVWlrMEt1RFFC?=
 =?utf-8?B?eDErNCt5VlRzeUtWclNJZ0lkbVlqV3cwdjBpTS80dFZZZmk0dFVCMWZ1M2cy?=
 =?utf-8?B?QVc1WUg0emc3ZlpMUzIvZ0h3ZmZnc1ZhaG5sc1VSL2RKVmR5MXNnNjhLYzJh?=
 =?utf-8?B?NEpvS01raFFPMWNNTDRWNDlBR0I1Qjg2bllIOXZZM3ZsSDVhK1RWRG4wZSs4?=
 =?utf-8?B?ZzhhTUlhRWNlbno5YUFHV1crT051NGhGNE1nTXB3dnhRZ0NQUlFIN3VVMldQ?=
 =?utf-8?B?eVFtVThwcUpERmlOSDQ1WkgvTlB0RFgyMkY3dVFoYnorak9JeTFQRHhDcE9y?=
 =?utf-8?B?TGdNTEJUOHhCd1VnalIvUGMzVnFvQ0dhMHBDaVZCRnpXbHhRanZTWDk1UzNR?=
 =?utf-8?B?TEZXUEU2UkdobEw4Qm9tYWZob2lUc0poNFBqMGV4WUMwcCsrQjJBSGY1Y1Rt?=
 =?utf-8?B?eThabGtTalhHVWlKUjIxT0h1YzkzRmhlWVV1TmliVk5FV211cmVhZWJ1L1dN?=
 =?utf-8?B?bGJJVWcvazQxTGpxenUvNFZXdTNJNGdVSWhDMzFKdEx6UGp6VGxMMDVacWdl?=
 =?utf-8?B?ZWdINWVVMUtJUEFpM1RrakVSc1FzTG1uaWEyV0JNWjNOalpzT0pwdHp2SUJM?=
 =?utf-8?B?eURHUGo0SWY2d0NGMHVwM2hmZXVMQ2k3MjlSa043T0svTlFhaGNvNFpLdTRW?=
 =?utf-8?B?dFBQUlBFN25mcGlHd3RkTjk3Vit6OWQ4Wjh4WXVpNmcvZFNBMWprQ2twN2E1?=
 =?utf-8?B?QytZMCtaRzQrdXpqZ2JvUFZPQXJvTHFIeEpkK1VxNEQyclMxWUdCeE9JdkM0?=
 =?utf-8?B?VVU2dFJUbkZBSk1QYWlEL1BKUUVZOWlnbU5oeTBVZVBxWXJHWjFLMkxJZ2dz?=
 =?utf-8?B?YWRpaUZUekNEempmcXJ6bnNLLy9BZ3J5K2MyZlNkRmloSSs1c29RdlNCSHl3?=
 =?utf-8?B?NGhjcjJXdnhSOE1CVmEwbDBlazRqaDU2STJMNGRmQVBuYlRyeVRnZGlrM3dY?=
 =?utf-8?B?dUZRMCtMVmE2WDlMOXNSYUtiU3QrRkQ5azg4OUFBMkcxblBQeUVad1hjMkhk?=
 =?utf-8?Q?xwdTaM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFUycTUxNUoxRlloZko5TStibDl5aGUySXpZZGhXNzBJL2ZRTHd1SXZ4QlBt?=
 =?utf-8?B?ZEdZL1JmUUJWMHQ5dlVHTVBYaXh1cU8rY2wxR1ZWaGNZRVV2eHVWZXN1ckRz?=
 =?utf-8?B?ZWxGc1JvY0hFK3FoRGwwY2RTRnBIOERxdXo4SFFrelRJRklGb3BENVNjVHd2?=
 =?utf-8?B?UUFITSsvM1V4dFRhV2tsbkVQVWUwd1c3bHZtcHFBLzRYeWZubUxrUE9nUHRn?=
 =?utf-8?B?MGIrdm55SWRqeVQweDgrbzB3NlpEZ29tTUxFcDQ0Q2NIcFVIRHkrRDZZOHZI?=
 =?utf-8?B?S0Y4QU1KdGJJVGxwVmM3bWJBTUZ5YUJwQ3pUS1g1YXA3bkk0cnRYeE8rUXcz?=
 =?utf-8?B?eWdIMUFES3FBcFJkRnRva001T0ZlL1kyMzdpUzRZNkJCUVlQd3BNZ1BoWVQr?=
 =?utf-8?B?UlJGY3NjcTVGMlZjR2x0c3M0L2tzM0xwZW5GUEFXeEpoWjBkOFFsbWVJaFI2?=
 =?utf-8?B?OFl1N3IwdG53UnNvTURMWTVDMTBGODJNU0tIRm5SVWRreDBTZlovZGw4UDRO?=
 =?utf-8?B?UlNUSWNFTEZmemFJVHYwYm1zTWVOL3R4alJsSDZJamYxWEtXcUFKMjgxYkRr?=
 =?utf-8?B?L2JjRU1PdG9iRmFCTGpOVXFEMzhJbGNSUkl6NUJlbjFhMHd2R2JuOHhCLzFv?=
 =?utf-8?B?RjR6Sktad0MwWGVCb3B2ZnpjclgyRkE3aCtEa3hXNzkzeEdRRWtOMmZTaEJw?=
 =?utf-8?B?cnQwcEJuOTNQYUtUTForY0lmWFpSWWw4aWYxU3FyZFd1STNkdWY5WE1zbGVZ?=
 =?utf-8?B?SXdFd1NjUm56eHhKZlo4VnErS2hwdjZ1Rnk4MWdzMVFJMlRIRG5jd3VDTFdP?=
 =?utf-8?B?UFJ6WmtZMkQ3RHZXbUlKVEhTeDBMWHNCV3UvSkd3L1lSblBYSmVJV0pYc1hy?=
 =?utf-8?B?WE1rQzVmN2JidWdvZVF1RjJHemJiS09MU2MzRG1VcTRIekdqTk5zc255Z2pn?=
 =?utf-8?B?YkU5WlZkcS8xRDBodk9wVmVHNXhic25HY3VjYmFkRU0rK1dZZUw4UVdHbnNr?=
 =?utf-8?B?RnJnTEEwMUpsNm1zcW8xZFFoNjRYVzNPNlFhOTlnQmZoRkptTThoWmgvajhW?=
 =?utf-8?B?M2NYVVRQdzZaanZzZ0c5ZENmaHpRMUJVQVBud2lGdy9Sa2FwRmRQeVliYURM?=
 =?utf-8?B?YjNRZnljRDhSNTlNOWplOHMxTUxhS25zd1dMdzczYk01K3VkUjBmdDJaNjJr?=
 =?utf-8?B?VGY2MWlRTHFYUEk4V09LWHF5Nm5LZmRlTG1wak5HSmVKNkJYTlZuZHViZXU0?=
 =?utf-8?B?bDNTN3cvNEVtZ0F3NmNyQVg3bVVBRVFweFVzeWFMU0VZbVNoY2xDRGdHUGlC?=
 =?utf-8?B?bmlNVDZMa1IvWEhkc2dxbU42VUtMUFViNGcyQ2Z3OE1xSmlSWUQrODE2a0t6?=
 =?utf-8?B?YlAyVE1KRnAvaFhGV1pzRnNqaVkyMERxU3JaUHk0MStsRnh2SFlRUEhRN05y?=
 =?utf-8?B?RzhTU0w5SnJoMTFSOGVqNFppVTVDSXhkQXYzWkNncmRIR1dXR3ppUEdPMXdO?=
 =?utf-8?B?Sy9jbjdOQndsY3lMdi9Za2xqOElFQUtldUMzMXkyczVpQ0hmSFJNWHlBQSs3?=
 =?utf-8?B?L2NYZno3NGd4NnBQSDJ5M2tlNGlaTGUzWndnaC81QzIxclZBQ21rN25lL0Ju?=
 =?utf-8?B?TEVncHpRSGdBQ3FRcXpRQk45SWtGUUJNNUJmZHJ3b2Z4a2VBWmxJN0djdkFv?=
 =?utf-8?B?SVZTSlFDWmFvMjhrZEI1SFh3bUhiRk94WlUxMjdNR1QralJJV1Z3TnJQNU55?=
 =?utf-8?B?UStBWHRvVGlKYk9Hb0hqK0VHbC9PeEVOQlFkcFNtS1I2d094Y1JEWWpPd1dp?=
 =?utf-8?B?b1JqTmczWDFYdFByREpnWjN0NHN2azNTcTY4SzVqTG5ncTBxc2JiV2tRc2dl?=
 =?utf-8?B?SStUakJwU3I0Y2VwNWNBdnIvdlRyZ0dvM3JEVkdQZ1JPWm02aVpPNDBaUXJv?=
 =?utf-8?B?djlVcFIzRUh4Y09DQXlRdGE0bWQ3aHNKTDhNOXhnclFibTE5bFhpVXYvRDIy?=
 =?utf-8?B?UDQyem15N0VqTDhoUUtWZ1pnZkhZTDJLYW1pMUQrRjYzbFQ3K0s4R21wUzhT?=
 =?utf-8?B?R1VrdktWTHQ2Z2Z6enpsdDZnSEt6RUVCUExkeG9IbHhCNk8zVmtvMWhvdDNN?=
 =?utf-8?B?OHI4RFJBZUJsL1piR2tCdUFwTGpKV1FaS1pXM1NHMmJwaDFUL0tscmliV0RY?=
 =?utf-8?B?ZHBVcExscW5SazNQNlpMK0haUDhXUm83dXl2VUptMHdqWUhiS3krS3BwUVNK?=
 =?utf-8?B?OWhkMXZuY29XREpQYitGQWg0a1hyUytlZVhHNklDMkxvRzYxeU1KMGYzWDFI?=
 =?utf-8?B?MC9nclBrTFN2TWxLdmdwVTJDRWgzWE9TNVhiYWxuc3cyTWVhTmFTdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6e280a-0b2c-4dc0-c47e-08de53421a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 07:54:10.3187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuDdbERT1slpWSLgeu4gLvQI3yAIkVsAQrMyqClvPbGhjdLtiTi0nuGSQuBMqAiLgGzNd8hrg+BAKdciGEfTXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6545
X-OriginatorOrg: intel.com

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKYW51YXJ5IDEzLCAyMDI2IDExOjAxIEFNDQo+IA0KPiBPbiBJbnRlbCBJT01NVSwgZGV2
aWNlIGNvbnRleHQgZW50cmllcyBhcmUgYWNjZXNzZWQgYnkgaGFyZHdhcmUgaW4NCj4gMTI4LWJp
dCBjaHVua3MuIEN1cnJlbnRseSwgdGhlIGRyaXZlciB1cGRhdGVzIHRoZXNlIGVudHJpZXMgYnkN
Cj4gcHJvZ3JhbW1pbmcgdGhlICdsbycgYW5kICdoaScgNjQtYml0IGZpZWxkcyBpbmRpdmlkdWFs
bHkuDQo+IA0KPiBUaGlzIGNyZWF0ZXMgYSBwb3RlbnRpYWwgcmFjZSBjb25kaXRpb24gd2hlcmUg
dGhlIElPTU1VIGhhcmR3YXJlIG1heQ0KPiBmZXRjaA0KPiBhIGNvbnRleHQgZW50cnkgd2hpbGUg
dGhlIENQVSBoYXMgb25seSBjb21wbGV0ZWQgb25lIG9mIHRoZSB0d28gNjQtYml0DQo+IHdyaXRl
cy4gVGhpcyAidG9ybiIgZW50cnkg4oCUIGNvbnNpc3Rpbmcgb2YgaGFsZi1vbGQgYW5kIGhhbGYt
bmV3IGRhdGEg4oCUDQo+IGNvdWxkIGxlYWQgdG8gdW5wcmVkaWN0YWJsZSBoYXJkd2FyZSBiZWhh
dmlvciwgZXNwZWNpYWxseSB3aGVuDQo+IHRyYW5zaXRpb25pbmcgdGhlICdQcmVzZW50JyBiaXQg
b3IgY2hhbmdpbmcgdHJhbnNsYXRpb24gdHlwZXMuDQoNCnRoaXMgaXMgbm90IGFjY3VyYXRlLiBj
b250ZXh0IGVudHJ5IGlzIDEyOGJpdHMgb25seS4gU2NhbGFibGUgY29udGV4dA0KZW50cnkgaXMg
MjU2Yml0cyBidXQgb25seSB0aGUgbG93ZXIgMTI4Yml0cyBhcmUgZGVmaW5lZC4gc28gaGFyZHdh
cmUgYWx3YXlzDQpmZXRjaGVzIHRoZSBjb250ZXh0IGVudHJ5IGF0b21pY2FsbHkuIFRoZW4gaWYg
c29mdHdhcmUgZW5zdXJlcyB0aGUgcmlnaHQNCm9yZGVyIG9mIHVwZGF0ZXMgKGNsZWFyIHByZXNl
bnQgZmlyc3QgdGhlbiBvdGhlciBiaXRzKSwgdGhlIGhhcmR3YXJlIHdvbid0DQpsb29rIGF0IHRo
ZSBwYXJ0aWFsIGVudHJ5IGFmdGVyIHNlZWluZyBwcmVzZW50PTAuDQoNCkJ1dCBub3cgYXMgRG15
dHJvIHJlcG9ydGVkIHRoZXJlIGlzIG5vIGJhcnJpZXIgaW4gcGxhY2Ugc28gdHdvIDY0Yml0cw0K
dXBkYXRlcyB0byB0aGUgY29udGV4dCBlbnRyeSBtaWdodCBiZSByZW9yZGVyZWQgc28gaHcgY291
bGQgZmV0Y2gNCmFuIGVudHJ5IHdpdGggb2xkIGxvd2VyIGhhbGYgKHByZXNlbnQ9MSkgYW5kIG5l
dyBoaWdoZXIgaGFsZi4NCg0KdGhlbiAxMjhiaXQgYXRvbWljIG9wZXJhdGlvbiBhdm9pZHMgdGhp
cyBvcmRlcmluZyBjb25jZXJuLg0KDQo+IEBAIC0xMTcwLDE5ICsxMTcwLDE5IEBAIHN0YXRpYyBp
bnQgZG9tYWluX2NvbnRleHRfbWFwcGluZ19vbmUoc3RydWN0DQo+IGRtYXJfZG9tYWluICpkb21h
aW4sDQo+ICAJCWdvdG8gb3V0X3VubG9jazsNCj4gDQo+ICAJY29waWVkX2NvbnRleHRfdGVhcl9k
b3duKGlvbW11LCBjb250ZXh0LCBidXMsIGRldmZuKTsNCj4gLQljb250ZXh0X2NsZWFyX2VudHJ5
KGNvbnRleHQpOw0KPiAtCWNvbnRleHRfc2V0X2RvbWFpbl9pZChjb250ZXh0LCBkaWQpOw0KPiAr
CWNvbnRleHRfc2V0X2RvbWFpbl9pZCgmbmV3LCBkaWQpOw0KDQpJIHdvbmRlciB3aGV0aGVyIGl0
J3MgbmVjZXNzYXJ5IHRvIHVzZSBhdG9taWMgaW4gdGhlIGF0dGFjaCBwYXRoLCBmcm9tDQpmaXgg
cC5vLnYuDQoNClRoZSBhc3N1bXB0aW9uIGlzIHRoYXQgdGhlIGNvbnRleHQgc2hvdWxkIGhhdmUg
YmVlbiBjbGVhcmVkIGFscmVhZHkNCmJlZm9yZSBjYWxsaW5nIHRoaXMgZnVuY3Rpb24gKGFuZCBm
b2xsb3dpbmcgb25lcykuIERvZXMgaXQgbWFrZSBtb3JlDQpzZW5zZSB0byBjaGVjayB0aGUgcHJl
c2VudCBiaXQsIHdhcm5pbmcgaWYgc2V0LCB0aGVuIGZhaWwgdGhlIG9wZXJhdGlvbj8NCg0KV2Ug
Y291bGQgcmVmYWN0b3IgdGhlbSB0byBkbyBhdG9taWMgdXBkYXRlLCBidXQgdGhlbiBpdCdzIGZv
ciBjbGVhbnVwDQppbnN0ZWFkIG9mIGJlaW5nIHBhcnQgb2YgYSBmaXguDQoNClRoZW4gdGhpcyBt
YXkgYmUgc3BsaXQgaW50byB0aHJlZSBwYXRjaGVzOg0KDQotIGNoYW5nZSBjb250ZXh0X2NsZWFy
X2VudHJ5KCkgdG8gYmUgYXRvbWljLCB0byBmaXggdGhlIHRlYXJkb3duIHBhdGgNCi0gYWRkIHBy
ZXNlbnQgYml0IGNoZWNrIGluIG90aGVyIGZ1bmN0aW9ucyBpbiB0aGlzIHBhdGNoLCB0byBzY3J1
dGluaXplIHRoZQ0KICBhdHRhY2ggcGF0aA0KLSBjaGFuZ2UgdGhvc2UgZnVuY3Rpb25zIHRvIGJl
IGF0b21pYywgYXMgYSBjbGVhbiB1cA0KDQpEb2VzIGl0IG1ha2Ugc2Vuc2U/DQo=
