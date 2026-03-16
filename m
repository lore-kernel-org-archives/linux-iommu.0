Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75873349B02
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645914; cv=fail; b=OLs2fbtoKA4YkJc/5HNmoQa/eAoCOGYIVlZYxpz85vTQ/xIvah5oeohQtwWZhK8wh4+bjY3nlUN1dF6UCPK9bwx6Le4dLdrt1ztc/tL1tHiQd4Ff/IBqBChd66hUhvBJ8QCS50RmC42Uya8REAMulH4X4/mCKlxTOgCuyK6jv5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645914; c=relaxed/simple;
	bh=a5axQFOCGw/9w1Mqu1k64E+sWeY2sntNS+p0XI0z56s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Why5bWlJRgbhE+Vz2KnK0AOtRGaNcQhJ60RucCJQ867VW0GPgjcm+TvoPX0RgAoSAEoH2LSEs6PS2gsbGnfN2FX4HwpAkMCory6ke7G+C1GNsdF/MOJ2Q/haLwzlbg+VhQ+dDhCNkZDzORUpv8vnotOwL2TpKhsZKYKe9XMgMpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDPW75rl; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDPW75rl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773645913; x=1805181913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a5axQFOCGw/9w1Mqu1k64E+sWeY2sntNS+p0XI0z56s=;
  b=DDPW75rlHsylmW0uvxN9EOuqwVgwKssoLwL/vivYU2qA5TLmzxASXsyx
   oLpHCQpv0vHdnKAgyc+bsrJP8wl/O/BzaYyn1m6d3lSqVbercYW1gX1+Y
   bk+YlJpjhFoC6JFNlqX4vgAWlJjcQxdl12KR6uYn2L6IDspfTBKqrdfPO
   sHKl+WcB16ymHuEQcTbEmyVcNQTMuDlpVHNJ2hZAnVSkTGrNFxLQ84k+n
   NXyc12c7LqG4YNFOpgkZn5yPNa/29Xwa6/k3Qy1fOtMN6w1LMBkKm1GGS
   EgGQaIMt0EWHQPCpFhuY8H0FAWjFxI4036DBqtknbiJmu39YcqGm5pheN
   w==;
X-CSE-ConnectionGUID: Eb+6ZzRZS+m+taAQE2CUeg==
X-CSE-MsgGUID: T/UAX4b8R92ngrkP5KHWZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="73670086"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="73670086"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:25:12 -0700
X-CSE-ConnectionGUID: cJvHp5QDQPKy6yxdVQ3sWg==
X-CSE-MsgGUID: T7F1h2GoQI6KTVq8YvhkLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="224070242"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:25:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:25:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:25:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/KlbrwrQ3wEwI2tmBRA9ODXM6EMqRxxumeYy497IZsjZmbZSh9sm/wa6P5Qj8AUC5VfFCMZlIvySy0D4PaB8Je9etSdcx7LPvIKkOXR2RqKoGEDkgYtlcR4XLGwn+s/5WnySYdi4P/OdRBNj/QgUk79NmsWRjNnqkWo+SIR+11N+F7GPKTv2swULzVl2abUzgvhDAsz1nLshKUUkau/sOxDxuGt58gUpCZWn3yFopTQpy9Wkd6h97f9ywBe5M5qZDYo3XRVpDELhKOj7h+bsrJBbrx1jiOvWTir9mRrLFgDirDSMNuiKJeavQVK+G3/u0s9VFIuwPVAiwbXSjCdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5axQFOCGw/9w1Mqu1k64E+sWeY2sntNS+p0XI0z56s=;
 b=FpKLZyyRjSCzU1fQVlyqsPhbxfRzqYq5CQ5s3mZTigLRJFx9j422l8uHYPydgnfUSGRWIizLUwmqoL4xb23xfEtSE6lfCROGimi542b7GSNffPOG4tvboexoTBskEFA1/ukSndgNvHoTmY37RuVL9MRbz9DZwKAeAIgJPCgraEa9I3SJ67ssU2VwY6g/foRgQTuTfe9dpoJTct5WQXcaQj2Y/ickiDt1sy+jhs5JJMXkugtl8Y544u7He/uPvtgc0rTz0RFzBmgKyTk82cj5Pw+Qm1BpnavlXW941V0aSNrRdKgGWnywYvRenAmzbkNcAYkPrG/xzpqYg8CmvKo9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 07:25:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 07:25:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>
Subject: RE: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Thread-Topic: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Thread-Index: AQHcr7Zg2nUMA9oep0Ot8T7R69iYtLWs1POAgAA6EACAA7n1UA==
Date: Mon, 16 Mar 2026 07:25:07 +0000
Message-ID: <BN9PR11MB52760B1BFB652AE73C7DB2CB8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-4-aneesh.kumar@kernel.org>
 <20260313184957.GP1704121@ziepe.ca>
 <69b48d0a374a_b2b6100eb@dwillia2-mobl4.notmuch>
In-Reply-To: <69b48d0a374a_b2b6100eb@dwillia2-mobl4.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB7447:EE_
x-ms-office365-filtering-correlation-id: bf08416b-edad-49f8-e8eb-08de832d269c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: q4lxjSbw3n0EGmkIDA9JP9LFk/9jakrJ+cZuru08ZA+z+Vy75lP5cwq9P84azYKzCw08CsWV5f5B6A1Jj7udT0oAjO6YuIhDnzEXWF5vc6nGZHBFfvZqrmmVE/dNEDIS7DeTNUlzFgueHScbYz8uE4Pbg0KNyg9fS4aJfQ6yJVZs/IBUHQEOiNXfiAPbkSlh+H/8Gj8NX9sjdSmprgpHONqv1FA44awQIljPjQYpv39pggBc89BM29txhEX8d9asQpBdkulqJ/1clVr9aEHnVgKG1Wzt6LIHTNePrSnxViEaT+TE9X9kb+x5ukWyVfbeE5UAmTpZxdt4d1B68wSU8tFgaK3n5Zy59uUDa1JS+gy73QqGLeEMbR0fJuFL8NLyvd+TZgfrxbJC6upX/1WdN/qo9Zj69UFr9rZWjBkedaHIpt9Ju807HiBn+cemN8svm/Ue1U6ILg62kD4AwuwuqDBNJJWJb6v+9d2nY+CF8RrYL8GKZAh9eMJqHl3bB+E9YCMfLydMjjTg1PkY1aW4TVNzF6aVPK0JBBRjEh25pYYUeEdIOwDi23aRtIXs5ys50tCUxhTMYhkswkoV3Fd0EbgFk1Z69bvZWgUl5iq0l6j29+2rZJ9jl7Xn6vCDQyxFOwos4LbicOjwHKxuXLCtTQ2Rywht/muD1tvgRDKVWUMWBllQWYdY1/CJyjDaxLPuA5iPd2p0gPuTeK75uHnQBTAQVHSzgZd9TfilUqpckm0yuA94myoHC4R5WwHyKpVDOltSknfwaAcuwn7XfXlPaw1nIAmb6OWuVI/EDEwrPAA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE5SQm85cFl2RzYyRlV3SnViVHJneHBTcncyMGlUNE1tWm00STkzR1pFZjFR?=
 =?utf-8?B?aW9xbklzckRxQUlZcjA0QTlUaHEySzNJaWpPeHBKVjI2ZDF6Q1JWZlA5NXk0?=
 =?utf-8?B?T0lJMkFhNng1eGFrNG1vZEZ4d2NVOTZXQ0l3aVBFK0NnYUQ2QklSWnZCZUpQ?=
 =?utf-8?B?QXZHc0tXY3BmTzdjRVJEZ0g5TDIxL2JuYnBaS05JVitJM0pyMVRWbzJPcEpY?=
 =?utf-8?B?eDMzeTd4NXZ5Y2tWaXhHUld2R0tUTUJpRTdXNU0vdzRmejZuYlBUSlR3N1RP?=
 =?utf-8?B?bGZScGdIVm1vcHk3dTNlZkxvclF5aUhGTHZNZVRucnRsWUd1QjBFZHFFdU54?=
 =?utf-8?B?SUE5dHNZSjFCNWxJMGNyT2VKaTE4ZTFZVk1tQWd6VDVZMnpnT2pEMW9JdXEv?=
 =?utf-8?B?akZDWHhuMkV0ODNuV25HQmRYeUhqNnJidE9kbitxM3ZkOUxvVk5QTlhmd3Jy?=
 =?utf-8?B?L2hWbGFFOE1EdjlnQWxjOGZqOXJNVUpyVWFwMy9lRUltWklUR0dxZDBzY0d2?=
 =?utf-8?B?YkdleVNWa2N1RXZOdStxR2pDTk9iNFNONkxyZlVXMk0zZUo2RUh6SkVyaExl?=
 =?utf-8?B?RXNIZHZrZytSZnA0aHM2TElMdERIQ3pDKy8yb1Z4elBhVXRSZDRoa2NwZEVn?=
 =?utf-8?B?NSs0NityZXhKdFE5SDMzOWlweUlSc0NwZXVickNoSWJ2cW50TjFvN3pNaytL?=
 =?utf-8?B?VmR3bC9oVDVYbTJ6dmNJZ21lUFU1T1pLN3RkOFExODhXNXByWmtrNEVJRUtw?=
 =?utf-8?B?cncrREVBbUN1SVYrUDdpd1pBOUdjQzNSV1VCM1VZN1lPbk9WbVFBYUovaXZZ?=
 =?utf-8?B?RW1zdXUrS3d3R2Z2QzIyeVV4eXhua3picG9IcWt6c0YwLzZVU01qbzF0NU9D?=
 =?utf-8?B?V241WmVIYWVMVldTNVZvOUpmQmVsMDFVRDc2OCs5SlAwVjY0QlN4SnkxVlV3?=
 =?utf-8?B?Mlo3ZmY3SDhOaEJPK2pucTQ0MUlrYmIwUUFTTFd5anlVaEZ6c20rTXJ2TE13?=
 =?utf-8?B?Nysrb0FsMmRUNzUrMlVHR3hveG04dTFIQ2JCTVo5aEtyTFFrN3JuMS9tY0tY?=
 =?utf-8?B?ZFg4KzJRNUpuOG50SmQrVFAxZU1DSWdtbEFGK2Y3L0tQWUZxWDVDZVdYQVJz?=
 =?utf-8?B?MjROWDltdmc4TGh6NW8wNzFpNVc1UDRIUGcwbWR2VGxIUHowbUFzeGhLeXN3?=
 =?utf-8?B?Z1NjVjRjQURkQU03UTdYQnljTEZOQjN5OTFmSzQ2cVRublU0ZzZlTEc1WVp5?=
 =?utf-8?B?d0RQaDN2WUU5WGc4UFpJZXpKZXBKbXVKYVNPc3ozaTRKSEdWQTl2dUV2bkFn?=
 =?utf-8?B?OGRWMFZadVp6Vko1cUdPWjZCNEZyS3ZpSzNNaitIRzVpVldmejQvZ01kb0dC?=
 =?utf-8?B?UVp6Q2NYSDhJUkhPSUQwZTUyLytDcHV3RDhSamFKbmFnaDFwTHpBYzVnNlNU?=
 =?utf-8?B?OHJkVnZuVHlJOUpMTXhHWEFmZG5mR3MxRWZEc21McHZVbXR1RDN0MHlzMGZw?=
 =?utf-8?B?bnNzdW9WbnZaWG5DTGM4MWJZeFdRNHBZUWtTMFl1UWJ2cVU5YmVYVWVseHg1?=
 =?utf-8?B?QkYrR0Q5ZU5FbFdRSlZoQy9UcDlEYVg0cGVGK21PRTc1ZE9od1FPYWxySlBC?=
 =?utf-8?B?bVgrNHVyZlEvY3d4SGJkMjc5bFFCOGQ4M1ErNTBrbDZNN25reWJnbU94YnBv?=
 =?utf-8?B?amhmWVFidkphTk1IQ0VlRXpBaVYxS1VtQUsxSEtPVGZDejh1dFlPMXY5bFZo?=
 =?utf-8?B?TXZGQnFXNlhBY3FjZkI1bHJLYVNRR3F3aEo1NmRWWlNXaVJhcXd1bG5NSElY?=
 =?utf-8?B?K2hXMHhZVkNoMkpyeUEvdzRvdXZmaVdwVzVVeCtpQmNzL2s1bFc0a3Z1QTNv?=
 =?utf-8?B?R2hVL3lUR3ljTVl3UnBmQ1JOM0dFMVJrK200QSttNVNnWEhUVmZpWTJUM29G?=
 =?utf-8?B?SWFlRHhuQS9RY0dBbWIraVVURnNGL1NTTWF1Nk05b1Q1VDlPMlR3eS80UTFy?=
 =?utf-8?B?R1pBTm9ZSFFzM3J1UENuS1lBVnlhMENlWXR0TUJnTHZFL1pWWFp6MDNjcHFy?=
 =?utf-8?B?VUtHdWFsQ3R3TzAxb0djK2NkQmNCNWxyNGdZUzB6akt3NG5PREJGdHV3elg1?=
 =?utf-8?B?UUdNZGUxWGhKUmo0SnAzR0hBNnUxNUhFYlp1YzYyQjlINjhjeG1KaVNveTdu?=
 =?utf-8?B?YU1hQjBBdXVsUElHYzVMWGoyUzAzRVM1V2NNYjUvdVFHZ01DbitOZWRQZHI0?=
 =?utf-8?B?eC9PSEk4U3JFODErSXBBMjB6cjJQSzF4SWlpYk1sVTZHa1c5OVVJZGk5TjFJ?=
 =?utf-8?B?UW4yd1NPN3RKNGlMcVFTVXZ5ODdKbW5JVUw4c3B1Q1RXKzJvajh5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JVvRMyZLzIcDKRWpV/iuOOHPyR3unhMvMQLtAteVebxMgjpYSfji3mqrErwAvGQGNzTKSfDzJfwLQXOF3qdVPgtAlqyLB05mq0N8WW0MRkVqaoaFMmbuLDlKhHWplCBUZ4/ZAGIHQ16HNfiE0qvFRA6n1Y4fWVKcfzVmdfoqORyLzcRB52GbGsr6iJOjPBrb4FnD5ZGIO/kV1/Yna1fbZ319Gin83aMCFcw2WAiMZ1/HvjzfK6qXp4wmVcvm1lAnAXeLmh9AGLZOGHJY0GOg77AgtY301yLt/1OSndzgl6Ab73laKWWj0nYMAVyaVOvtM72c/v2c7y6KfAnzCs/f4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf08416b-edad-49f8-e8eb-08de832d269c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:25:07.7308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afuv4yUQjM9w/dzEjKPw2oRLq9dB2j5HF1sp+b+uIYYYu5oLURl+VYGXVOdY8TQgzk7APthJYG1DjNPaSbrhAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com

PiBGcm9tOiBXaWxsaWFtcywgRGFuIEogPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2Vu
dDogU2F0dXJkYXksIE1hcmNoIDE0LCAyMDI2IDY6MTggQU0NCj4gDQo+IEphc29uIEd1bnRob3Jw
ZSB3cm90ZToNCj4gPiBPbiBNb24sIE1hciAwOSwgMjAyNiBhdCAwNDo0NzowNFBNICswNTMwLCBB
bmVlc2ggS3VtYXIgSy5WIChBcm0pDQo+IHdyb3RlOg0KPiA+ID4gKy8qKg0KPiA+ID4gKyAqIHN0
cnVjdCBpb21tdV92ZGV2aWNlX3RzbV9ndWVzdF9yZXF1ZXN0IC0NCj4gaW9jdGwoSU9NTVVfVkRF
VklDRV9UU01fR1VFU1RfUkVRVUVTVCkNCj4gPiA+ICsgKiBAc2l6ZTogc2l6ZW9mKHN0cnVjdCBp
b21tdV92ZGV2aWNlX3RzbV9ndWVzdF9yZXF1ZXN0KQ0KPiA+ID4gKyAqIEB2ZGV2aWNlX2lkOiB2
RGV2aWNlIElEIHRoZSBndWVzdCByZXF1ZXN0IGlzIGZvcg0KPiA+ID4gKyAqIEBzY29wZTogc2Nv
cGUgb2YgdHNtIGd1ZXN0IHJlcXVlc3QNCj4gPiA+ICsgKiBAcmVxX2xlbjogdGhlIGJsb2Igc2l6
ZSBmb3IgQHJlcV91cHRyLCBmaWxsZWQgYnkgZ3Vlc3QNCj4gPiA+ICsgKiBAcmVzcF9sZW46IHRo
ZSBibG9iIHNpemUgZm9yIEByZXNwX3VwdHIsIGZpbGxlZCBieSBndWVzdA0KPiA+ID4gKyAqIEBy
ZXFfdXB0cjogcmVxdWVzdCBkYXRhIGJ1ZmZlciBmaWxsZWQgYnkgZ3Vlc3QNCj4gPiA+ICsgKiBA
cmVzcF91cHRyOiByZXNwb25zZSBkYXRhIGJ1ZmZlcg0KPiA+ID4gKyAqLw0KPiA+DQo+ID4gVGhp
cyBuZWVkcyBhIG11Y2ggYmV0dGVyIGtkb2MuDQo+ID4NCj4gPiBSZWZlciB0byBzcGVjcyB0aGF0
IGRlZmluZSB0aGlzLg0KPiA+DQo+ID4gRXhwbGFpbiBXVEYgc2NvcGUgaXMNCj4gDQo+IEkgcHJv
cG9zZWQgQHNjb3BlLCB5ZXMgdGhpcyBuZWVkcyBtb3JlIGRvY3VtZW50YXRpb24sIGJ1dCByZWFs
bHkgaXQNCj4gbmVlZHMgbW9yZSBkaXNjdXNzaW9uIGZpcnN0LiBJdCB3YXMgaW5zcGlyZWQgYnkg
J2VudW0gZndjdGxfcnBjX3Njb3BlJw0KPiANCj4gR3Vlc3RzIHRoYXQgYXJlIG1vdmluZyB0aGUg
ZGV2aWNlIHRocm91Z2ggdGhlIFRESVNQIHNldHVwIHN0YXRlIG1hY2hpbmUNCj4gbmVlZCB0byBh
c2sgZm9yIGhvc3Qgc2VydmljZXMgYmVjYXVzZSBvbmx5IHRoZSBob3N0IHBhc3NlcyBtZXNzYWdl
cyBvdmVyDQo+IFNQRE0gaW4gYWxsIG9mIHRoZXNlIGFyY2hpdGVjdHVyZXMuIFRoYXQgaXMsIG9u
ZSBTUERNIHNlc3Npb24gcGVyDQo+IHBoeXNpY2FsIGRldmljZSwgbm90IHBlciBhc3NpZ25lZCB2
aXJ0dWFsIGZ1bmN0aW9uLiBJbiB0aGUgQU1EIGNhc2UNCj4gdGhlcmUgaXMgbGVzcyBndWVzdCBk
aXJlY3QgYWNjZXNzIHRvIHRoZSBUU00gc28gaXQgbmVlZHMgdG8gcGFzcw0KPiBhZGRpdGlvbmFs
IG1lc3NhZ2VzIHRoYXQgdGhlIENQVSBtb2RlIGJhc2VkIFRTTXMgZG8gbm90Lg0KPiANCj4gVGhv
c2UgcmVxdWVzdHMgYXJlIHZhcnlpbmcgZGVncmVlcyBvZjogaG9zdCBrZXJuZWwgY2FyZXMsIGhv
c3Qga2VybmVsDQo+IGRvZXMgbm90IGNhcmUgYnV0IGNhbiBzZWUgdGhlIGNvbnRlbnRzIG9mIHRo
ZSBtZXNzYWdlLCBhbmQgaG9zdCBrZXJuZWwNCj4gZG9lcyBub3QgY2FyZSBhbmQgY2FuIG5vdCBz
ZWUgdGhlIGNvbnRlbnRzIG9mIHRoZSBtZXNzYWdlIGJleW9uZA0KPiBlbnZlbG9wZS4NCg0KImhv
c3Qga2VybmVsIGNhcmVzIiBtZWFucyB0aGF0IHRoZSBob3N0IGtlcm5lbCBtYXkgY2hlY2sgQ0FQ
X1NZU19SQVdfSU8NCm9yIHRhaW50IGl0c2VsZiB0byBsaW1pdCBjb21tYW5kcyBhY2NvcmRpbmcg
dG8gdGhlIGRlc2NyaXB0aW9uIG9mDQplbnVtIHBjaV90c21fcmVxX3Njb3BlPw0KDQppbnRlcmVz
dGluZ2x5IGNvbW1pdCBjMzE2Yzc1ZDU3ZmIgKCJQQ0kvVFNNOiBBZGQgcGNpX3RzbV9ndWVzdF9y
ZXEoKQ0KZm9yIG1hbmFnaW5nIFRESXMgIikgaGFzIHRoZSBmb2xsb3dpbmcgZGVzY3JpcHRpb246
DQoNCiINCiAgICBUaGlzIHBhdGggaXMgcHVyZWx5IGEgdHJhbnNwb3J0IGZvciBtZXNzYWdlcyBm
cm9tIFRWTSB0byBwbGF0Zm9ybSBUU00uIEJ5DQogICAgZGVzaWduIHRoZSBob3N0IGtlcm5lbCBk
b2VzIG5vdCBhbmQgbXVzdCBub3QgY2FyZSBhYm91dCB0aGUgY29udGVudCBvZg0KICAgIHRoZXNl
IG1lc3NhZ2VzLiBJLmUuIHRoZSBob3N0IGtlcm5lbCBpcyBub3QgaW4gdGhlIFRDQiBvZiB0aGUg
VFZNLg0KIg0KDQpob3cgdG8gYXNzb2NpYXRlICJtdXN0IG5vdCBjYXJlIiB3aXRoIGFib3ZlICJo
b3N0IGtlcm5lbCBjYXJlcyI/DQoNCj4gDQo+IEFzIGZhciBhcyB0aGUgaG9zdCBrZXJuZWwgc2Vj
dXJpdHkgbW9kZWwgaXMgY29uY2VybmVkIHRoaXMgYmVjb21lcyBhDQo+IG9wYXF1ZSBpbXBsZW1l
bnRhdGlvbiBzcGVjaWZpYyBwYXNzdGhyb3VnaC4gU28gdGhlIHJvbGUgb2YgQHNjb3BlIGlzIHRv
DQo+IGhhdmUgdGhlIFRTTSBkcml2ZXJzIGRlY2xhcmUgdGhlIHNlY3VyaXR5IG1vZGVsIGZvciB2
YXJpb3VzIG1lc3NhZ2VzLg0KPiBQdXQgdGhlIGV4cGxpY2l0IG9udXMgb24gdGhlIGltcGxtZW50
YXRpb25zIHRvIGRlY2xhcmUgdGhhdCB0aGUNCj4gZ3Vlc3RfcmVxdWVzdCBvcGVyYXRpb24gYmVp
bmcgZXhlY3V0ZWQgaW4gcmVzcG9uc2UgdG8gYSBLVk0gZXhpdCBpcw0KPiBjb250YWluZWQgd2l0
aGluIGEgZ2l2ZW4gc2VjdXJpdHkgc2NvcGUuIFNlZSAnZW51bSBwY2lfdHNtX3JlcV9zY29wZScu
DQoNCmR1bWIgcXVlc3Rpb24gLSB3aGF0IGFib3V0IGEgbWFsaWNpb3VzIHVzZXJzcGFjZSBzcGVj
aWZpZXMgYSBzY29wZSANCndpdGggYSBzbWFsbGVyIHZhbHVlIHRoYW4gd2hhdCdzIGRlZmluZWQg
Zm9yIGEgcmVxdWVzdD8gV291bGQgKGNvdWxkKSB0aGUNCnRzbSBkcml2ZXIgdmVyaWZ5IHRoYXQg
aXTigJlzIGEgd3JvbmcgdmFsdWUgKGJ1dCBpZiBpdCBjYW4gdGhlbiB3aHkgd2UgbmVlZA0KdGhp
cyBmaWVsZCBhdCBhbGwpPw0K
