Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F6F3EC6BD
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145181; cv=fail; b=Wb7v8IsFGnWCoM5iZ4iEnvaz7Q/54KVoKqJvmlfKL2wef4xRa1ToGQjJBT5k5q17RvvGadn4rx1KQNMuMxOwQKwI7RqDQoIa2udf+OFHEYcaLVZGm/TkJMSysXwsuxqlcKhknbhWYnbvCJ5zEwWIHcN7EhBXoFhR1z5g2kzjpZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145181; c=relaxed/simple;
	bh=DjOLnmQaFZW5MrK9sioTY+mtf2/HrYts5yR6LCetu6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fdS3v6ywb7y/k+NRHNWI1n19GnZXL46nGrJMsXnbxySzfQ4ZTrl+V6ptt+hlFAM9KGNGoEA92cp/3M+m2d5faIdlTDGYOCGyTKcZgASmcIYkf4RZltjTyAQ/vHNE8Ug75E0CSCXqM7OsoAwQapfe71PWO7wApehRmVRj9p8543c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nd7wOINx; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nd7wOINx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785145180; x=1816681180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DjOLnmQaFZW5MrK9sioTY+mtf2/HrYts5yR6LCetu6E=;
  b=nd7wOINx3FgQbFwADTxwkCcU4rqk1NFe8yQhQH2CIWc6lSbxgAx2vDGm
   zSPeP73fV7KZUEx9Tzs24SoowVZtKHpQsoNE2GcsAJNyEUuvxV2FQTDr5
   zCSJiexQyyP9yeWPvDQOCNuYmP4qs/0I0/1N7Jif82nL1f7Q+C+SnDFDf
   lAbsAWm332I2vfXG2qFazpfioYek71/3oO8NtGaoW2cvLZnWjgwGnHoyT
   eCbI51gN2wCG7MgnL1c7o3ZVgfNCgCe3Mv7eO+ehiAAieZj4FLh5B8Oy8
   s1OJReFxbQj3NWchYlwLhKfqYQ/0cpZzxsMQjscJb3VsxMO6aPLKSUGa5
   g==;
X-CSE-ConnectionGUID: 6nE9VwjRSh+gO7ifB4Yxmw==
X-CSE-MsgGUID: qdJBrR6mSkyF4j6PyVXTUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="96298037"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="96298037"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:39:39 -0700
X-CSE-ConnectionGUID: JrH1QhIrSpaXGqypyNc+Pw==
X-CSE-MsgGUID: fjWGPXYjR/uhpr1OBPafcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="260010136"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:39:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:39:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 02:39:32 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:39:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdBqhU63irhsvtbEzK03jWEGhYUCJeGVTsO659HP0a3tCjhWSGw/rUA1mSalfLIcxefS4Fi4gzf/0GjnSzXdKVPAp06YQwNq1T5GxtD4pcDMsEb5G9o5xNmR+x7/1n8nkSRyEtgOZnCWmFA0DRbCngOlOzpII9L4zWuOW6hgvpaEOlyj09cHI9OdCLKHoQ9N2r0PPrazP3maz0BLd2SI+JSECGpyruhlcpFNnY79DPn7RXgI9Kv6qXDeUVBKOm/Y2GCx7IdIf43MGsPjb7RMCNA3SPh4hiBlRLaXNBcRnup/XDUWw5oXuUgSTLweAPKqY7OcTODdiKIb3btYce1bjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjOLnmQaFZW5MrK9sioTY+mtf2/HrYts5yR6LCetu6E=;
 b=QB3qPa/j2CEOA2OfMPvtNnGj6jrG/eLzRq6NuWTXnSotKkXRKNrjazbwUJszI3lONdImizqd8podaZAJ/AXxiaqKxrCB0qkAR4cuIUOZPb8oCTgPXyLOD0fedEvqH+rKiqFt2o6wAi2Uev4WNZq3UWNqUWYr5FB8pU2P/r8o/m6P7fvQogrkuDZlTrB+Ka8iqMrPYu5IUPvec+eeyp7kb8WXOXOMqfXmUMCr0o2E2C+d9gMguUfEKbtfuGTBcKIPW8AlrFx2/VmjbdY+o8B8MmrG3mIzduLP/y1gkL0CxgfNzSiLnh49+EfSqc2E7E3jinpvsRYSm57UdblZVBHx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 09:39:29 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 09:39:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oliver.yang@linux.alibaba.com" <oliver.yang@linux.alibaba.com>,
	"zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH 4/4] iommupt: Return zero for invalid iova_to_phys()
 ranges
Thread-Topic: [PATCH 4/4] iommupt: Return zero for invalid iova_to_phys()
 ranges
Thread-Index: AQHdHNKCYvqwtuptKEq771yUlIDRYraBHe9Q
Date: Mon, 27 Jul 2026 09:39:29 +0000
Message-ID: <CO1PR11MB4835DF2133EFB4401292483C8CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
 <90a86345b06d43437592da48f1d624c748c4d4ad.1785050951.git.xueshuai@linux.alibaba.com>
In-Reply-To: <90a86345b06d43437592da48f1d624c748c4d4ad.1785050951.git.xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DM4PR11MB7328:EE_
x-ms-office365-filtering-correlation-id: 3609c208-555a-4682-8644-08deebc2f4ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: rFGHQui6KQreM+ObsFxwRH1crTrGJgFDk3PTNvv/TZR9yhJCniZJSKYmGfH3R2icEjL0kJzMxy+CTxxqhrWt/2aQNTHbhaqwXLvvOCuO9ZBGLJdkmoWCce30w+Ea7OC56i9s/n7CAUYDGtB7r8Mn8f84cbdnuUPtQHPPQ2Ij39x5pyVys459ElcqGjNJ274ikpAHYX3G4mqWzSWkW8+CZcn/34sKSxBoOlxRTPs6sdUVKT9sCCjrz/Hcjil/WKK6sxGVwLPklOLF9ur1wrLATCcQIwPkrdd+aywyGy/Ut85tJfp0BwszV1/fLE4BAMfnyvvGG3LavHfw0lJspChyuQb3mqdaZjm8uwqxEVPvAZ0ywFgzJmn2nnHGy11qFdIXtYxLwGMPZJRDJyMvSZp5YR5CHyIoK4uGklK0qyGE00ttyHB7o0o1kkvwmMsS8jwtZjgYdxrMbKa96DFNq0EssnmdWXY4YOf/kfr0JhOJEPJCEaw9O9Q5zoPMW9AmV7zMffEx6f0qdtUTm71PhPhC1FLL4ySGMYolZaD5SjvvE+qSjOUY1jU2aIuSkxxDgmsip7bPchKC2wlvYxJqUOibuBB9gfzp/AXN9i7gCrV8cKiDw5/qqcTi3agt00HhKTcZUHJq0GNJ09jK7L1F3S2diH7tCKtxMnJJ+BlxAUhyWsZekiDxYXGaIdsEhubvdZcl8gP26Bwd9OMD7elVd9fmXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GWoNhKdLAeNVvm07c13H5LnPeQLVZ25OM2oK7rKynczqH8p2MGovdWkSn18F?=
 =?us-ascii?Q?/9Yyva1PoeoE0+lsl/tL1MK6bBhkar/DtlLpAt9fyTv7REd1rQz5iefkQjl5?=
 =?us-ascii?Q?WE+1tkRg/DM29ZrqkJloLuAzbuQJ3d9u6JLLsVTkyV+IRE4oT1P2o00wI05x?=
 =?us-ascii?Q?KYf+S2QjplSV1bXcoURQ/2tdni34UbZ6lWm/5+T3RrJGAeQgGFFtvb2/Caf8?=
 =?us-ascii?Q?13anVQRKjOI4k4Ukc1rGQzgXVpsRhrkntDgGQNIpB7D9EzSKHouMKNXlakFv?=
 =?us-ascii?Q?AsQCw/zfK2iUCSEVYQuPq5hk93sSPMSa2OQw44Eylb4041bOO92IV23seNb/?=
 =?us-ascii?Q?eq5Co50wernXTYJOj5jKWNForoAQpupBj5Ut/ngwu2BqbkgJ5o323e2aw8sM?=
 =?us-ascii?Q?fZ9IHxRbpgI1+UdAR2Emx3EJpoPxtIgi7ycOXcXTR7ymjNgyI0k8EO0Zr+Mp?=
 =?us-ascii?Q?zLJnq64ZJ3naPJbJcoyeOPouy+bHO7rckxRMlqUwuabT+BXyLCbVWxuDHODc?=
 =?us-ascii?Q?hsmoTgEC+/wNQFXqRR79a0blRTxzjwFnub4EFVOXwXiO4gOb9vYXRWQPKTPt?=
 =?us-ascii?Q?Np8T+qbY1/f6GE7Qkx7lZVVf9z+3kgr/8sd/mCmNoKjHPikwHOp8Rd5ukU2r?=
 =?us-ascii?Q?JYJbxRMc06YS63I27dtNy5BjNe+PP3pCnrLuWxjhjRQzztdk9rXpNjrZQyNc?=
 =?us-ascii?Q?PX310IAdUUYmt4fkeN9cJDVCQmy5QBJ7Mlyj/kuGJXGl40yFdTABV8cU7DD2?=
 =?us-ascii?Q?QXAF5SslZiCFmW6J7EghwjaDGtzCsgR1UeehxvElXjXBTG96BtqwO3caM84h?=
 =?us-ascii?Q?vcR4I6bTKQkZKpoAS21mljkCsECGCke/BWLsDB/d2tLnrOpCQ5b7jGLnnGCZ?=
 =?us-ascii?Q?Wcw+LSNjgodxbx9y0crqdRJjvetA34jFL9Xq/35tu5eAbdSUFt4W/OKN5vjg?=
 =?us-ascii?Q?c8gaUeDH9UtHbzb6HFaIl+HHaeiAruT1oZWnpDKnWGlJYt0c9YkFMt2XH77r?=
 =?us-ascii?Q?ElHAWxR3BOl4qvcdtkFIurm0eFtN3/yHjr2CJ2cHdwqvpeXBVj/j6Y2DZ7By?=
 =?us-ascii?Q?TwBNDOvYKvsOz7byxL7JPh/FF6P3IiDj91KEGnXQWoACYJNIMdP+/7Bqymdi?=
 =?us-ascii?Q?gql/LUSxKmykKjlY72l3taF9tf7YVT4BVMB344WLZ9uDMw64GRf4vuWql0ku?=
 =?us-ascii?Q?AbhPvVIuQgYrbWnQYG8cUVPH+JjoVVUFVEsRTg2kdbwfMG1n6uZFzrcmk9EP?=
 =?us-ascii?Q?wloNM8e+AHteIwG+hl24MBzwMrutR/MEo+NrQiavwYJAbpwZQUqqlncCR4Xb?=
 =?us-ascii?Q?Xwj1stTSjqenFwZePy5K0dzr8D0HB37ALxnlENTfLAsPQMpSTjhQGwpTO1On?=
 =?us-ascii?Q?EGDrhxOY6188cyTMxpbuPFRx6ccs+KXuqn97E+r83B/w0VG4OUEZamgN/EZE?=
 =?us-ascii?Q?GqISRK0Nid7LBOJ5VcW5Old476msaTic83D8REvNjTrcybLGaLCcl+uNd4su?=
 =?us-ascii?Q?EaMSZx0nsaFIBGxI9uEnFzgF2dW/1wx6UqthDa2dKRDqx9yUkRXManGgO0/k?=
 =?us-ascii?Q?NsHSoozOhBmWtliUxlK5otw/VuOrpqnXjf9z6U0LRkRQ335cUcBshyUZg3eH?=
 =?us-ascii?Q?slpHKvAhFqCRngq7IxPvAu6PJbVBI9z0uHg82PmSf67uI5h5lVTDyLzdokxf?=
 =?us-ascii?Q?z//y6lHX42Dly0tyChrm297tDknv4lDRQEFTw+F03aWv4g09/YlQpZczmGvt?=
 =?us-ascii?Q?SwkiI/oBVg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qa/plW93j/xm4+9kniCsNgaSXYnLr8Tk+J2e0dxT4DqaatRyn3Ke7aylEGsIDHn065pw7Md+eSiU2/KXLz2X/efWRVez3L/TlEI3vaNe9UYmXV6lzPUomP3H3XH+OKtUVTIk0jx6i2OhJ79B0Ta+/lgY4MYP+hWeDduwj7cxxMFVmgBxw5getZpPQSnnCgixUfVczCBDrVz4BSBrwpZoSjhV1yCNPE1Qmx/dTKCHTDDvoVjMB4jdB8biq1rfzD74yTIHS+re013ipF01k4dLEO/17MuxzzN8vccJS6Ko57PZIrjfcZlPYV7kMuFIL2+XKtW700YnCyuKRMtipa1LYA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3609c208-555a-4682-8644-08deebc2f4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 09:39:29.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RherqWHtYryFVRSwWZsx46O/MHc1jTaHXw28mTGpDi5HRTrbpo2UfBF/CdQduy4PYU+v5ySxVRipH68nJpzlgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com

> From: Shuai Xue <xueshuai@linux.alibaba.com>
> Sent: Sunday, July 26, 2026 3:44 PM
>=20
> DOMAIN_NS(iova_to_phys) returns a phys_addr_t and follows the IOMMU
> iova_to_phys() convention of returning 0 when there is no valid
> translation.
>=20
> make_range() returns a negative errno if the input IOVA cannot be
> represented by this page table format. Returning that errno directly
> casts it to phys_addr_t. Callers treat zero as no translation and use
> non-zero values as physical addresses, so this can make them consume a
> bogus physical address instead of seeing a failed translation.
>=20
> Match the page-table walk failure path and return 0 for range validation
> failures too.
>=20
> Fixes: 9d4c274cd7d5 ("iommupt: Add iova_to_phys op")
> Cc: stable@vger.kernel.org
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
