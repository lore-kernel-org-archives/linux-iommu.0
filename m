Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053E1B041A
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750051282; cv=fail; b=MrFxv1xPL24A1LmcvviwnuUwlA1Z5mRWV8ewwJDTrji2T8VQp2Ea41e8PXrGsUZSr1A3Yum7VRw78+iRx4jzAqDbrf0HD6ApnQa+O1WN2bPctTNHHXVBHEm1Fd87SDhfiijveejtReYy0NwkWTPOxZ0qeHtb9gRC8QV3SgFOT68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750051282; c=relaxed/simple;
	bh=/Nmd0u3F9vEfWwqDSqi1lJgddEMtJ5tausOjKG7z8jk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k8k+/bvvtjbXLMMCEsymdbx8zidMwt/tH6enqAjE8+yPUzDTKctuU81Outf7WvZ/bseNDWlto5H+n+/PSfnfzpr3PdLWimPPj3K1MO87qzJ+yQjCAql2M7v2+Hr+0tmmQHpO6bKWRuBcFoziZRlgNRySdHWD+5sIFkYKo1JhhcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUY7hUlr; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUY7hUlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750051280; x=1781587280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Nmd0u3F9vEfWwqDSqi1lJgddEMtJ5tausOjKG7z8jk=;
  b=GUY7hUlr2blUBIa4U0LWnMHbjJhpqC8pIi3cakYmq17jNRqtMPyOv/cQ
   wukXld+RdXDSxHRQqAHpxKZ5RFUfibqIgeTsG6JCW1tsdOgpDsQ+I+LcV
   S9OLAB7q46va2XRJIyOskwiOXHcUl7QRf/Wo1rMxzMC7sW6Q7B8Tate+c
   DrU0B2spfk76nvMKItt15hEugDfJ/0GqLGtxMkHTBRAeKJSPl99bkZf9s
   mLOcdSDDTLCYCbhnQ5WPABW/Zb4sMNrSQIeLTG2tHBRNggKwvdJRhr5QX
   CKwNZmtshjNrPBkyiXzhDJ7ZrtKka3FkzHwc6pjZ8PogQbBZr+3hS0d4h
   g==;
X-CSE-ConnectionGUID: fJ1GgJyuSRK4IHjcZhFHuQ==
X-CSE-MsgGUID: fdGfeMy2RKiIHLQPiZlLFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63599860"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="63599860"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:21:19 -0700
X-CSE-ConnectionGUID: eSO8NkAJQESVKVJw5cZarQ==
X-CSE-MsgGUID: FBHjTXsqQ8u7Wm9o3woP5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="149250559"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:21:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 22:21:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 15 Jun 2025 22:21:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 22:21:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtdaN5aI+KxQpeTs18HJ91FTPAAU7cTTQBbW4B9CRRZ4D+bLJcRGZ9WllCGjmjQv52zxhy7C082Ml2zOZAIsQN76vIYJZ0WnWBZ8xpYuWvP5VHHLGcqEHuJmSWope92CkU9iYLB44viysdIgzKeFfp69Nua7fcZjk4DExhw4Lgt4bOn78WONP/4J1spvc6GrnleSnqRYwNt1FYyXV9PB1SwSIHOYXNFC4j+QDoEigW16L8vq9xxRb9phdjUAgBMUlRPLrlL4rJSalgWs9YhTl8Rqs1D8baCzihhUvLBafeck4mi+mRrU8OBdJPiYcieovk2jm5XWV+ju69ISDszb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Nmd0u3F9vEfWwqDSqi1lJgddEMtJ5tausOjKG7z8jk=;
 b=cycogwV7kPiIZXXuBMm36uU435MnN4iYbssuqxTEKGAylzcoLizvZJNK5IlW9wx50yWJhYTRLIr8CNmPVNb9vPXs4LAfPmgqxM8A24QqKtKUoPaxAg26PikDfMQo6oby6Q15xbO1DPZXY52oz+Vr3Bcm63CClfmSZvSZbS2nrV/ylxlOdPU6gw0g2vS4/z0CmXuwAMHov/IvdFAREaa5npCyiA4x1OS/TgjIRKaumjQWIDSULfwXHMf9iGQ9zTv/RnPXZmt4ceeejjoWsXDiTqcSEaWztuTpkISAq9Sqv1y6u39tbw5y46Kxe3/JjB374cZ+pTxfMtH1DAyIbxqf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8528.namprd11.prod.outlook.com (2603:10b6:510:2fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 05:21:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 05:21:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
Subject: RE: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Topic: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Index: AQHb2dRy0pZb6YCA9kCQvhSriVTQbbP/KocwgACgJoCAAOcYcIAEhQUAgAASGKA=
Date: Mon, 16 Jun 2025 05:21:13 +0000
Message-ID: <BN9PR11MB5276490602166F0897E411C28C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <yq5aecvktj97.fsf@kernel.org>
In-Reply-To: <yq5aecvktj97.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8528:EE_
x-ms-office365-filtering-correlation-id: 9065db45-de83-4e4a-f3f7-08ddac959ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wtvzJDaq0C7UAjG7KrKWCrmiEacHDUQmEzFoStjQJOXhet3eXYUu51D0ZUSB?=
 =?us-ascii?Q?H0hzbEsug307theeTJ9HKjM4rzqZXl6/FeXWgIhCIcHNwnZUgmO6Qav2IuZH?=
 =?us-ascii?Q?dNSEQWh8qOGHKG1R0OHiKJKAUeDidFwQEkiqRNWw8MxbXMADc6zcSZIOCK9V?=
 =?us-ascii?Q?caik9bCnNa5bSCfVCqWJEWl9CECohy2HEvOOAlso8d2Cr55ui8OZvt+k/3Tp?=
 =?us-ascii?Q?idQnuZJZwDaXm9rs7MYhKEsmpOUaIasOKj2l7AnU9SmNsywr32pkR4uDXRQ1?=
 =?us-ascii?Q?okp4COgYTC4MSmLrDRThT7r3BfX27XAHeD6H9PmMrstfzTU9egXc1N0vTVVK?=
 =?us-ascii?Q?9eavZ6Pk/9BYjHcQ1YryqeGezDNmrgSW9gYQKiL18bwOIda0XyJ6em3ot8cv?=
 =?us-ascii?Q?3WUSiZr/gYt+h1BZgx03mCGVCEQEDvCyAKlaIJsEAcdAoI9uVq5FvOHmN4gi?=
 =?us-ascii?Q?7w2aBN7DuH2DuIZIlNgNqkkAMHcKcLXT6kab0wUV34ayzwNGz3YOk3RgNKMt?=
 =?us-ascii?Q?tJBpwtukBdbnwy5RS/nsRjau/RslH5ll8jElIF97YzE+jjzxHKRvgJsF/CMH?=
 =?us-ascii?Q?ReAfUvoWaue+FqZL7EsDf2nlCgKYbMs5y5rcD1FSNhgN/cTB7Z2P9GfxRZrz?=
 =?us-ascii?Q?F9tNh4GoT6ul1ov6MT+q09uRtvFX/IQf2Yx9qfwhd2BOm5fm9eodkkWd0CBE?=
 =?us-ascii?Q?L183Y7HnrXZF9gA9FObCI+beDBVvYvE86QQvurVdgdtGuhtbjXmshjsSmNfo?=
 =?us-ascii?Q?EmfWRsMp8O8yo3IJn+aFAZCR4QEovVi0QBkR707TWia3bZMe/gej5AYzd70P?=
 =?us-ascii?Q?vza/f/m+IyNEunDQar7TEhAz6c5IaPgiuTKpPXQ8WwicfX51czuv/lEXgBuJ?=
 =?us-ascii?Q?nXqbeNyke61/R+wMK4M5cDRcdeL3/yLifyyyYe1XKRFpoNNXk6TipO9DIP09?=
 =?us-ascii?Q?3g/Z25iyIkhCdKlV1H3SRA7naVWg8bv/OOhtOF50p67iGSqrQnYVvJ405bgB?=
 =?us-ascii?Q?Pw9Z9ryujYnkf8dpnCofb1glO7bCsNY+Wts1FzRHPeg5l1Yjc/8erawIQsln?=
 =?us-ascii?Q?DnO/RbNdgD1u15L0RkfMSNFUxksBRwGfIzGnYHlFHwUTI01Fsop/5aA1psRs?=
 =?us-ascii?Q?btLtt8E/bLK1v1JcOTF1mH/cWOVCGryEnKUkK1BWRWDdNgaTXlETErS3cD2+?=
 =?us-ascii?Q?y+3DinqUMJVkDacUBelvA16UbEQQ7QTZ3jI1CREKiipe8bZNXziNZ29g8rRC?=
 =?us-ascii?Q?/dubtsvVi99PNNqeISNYNi/ZwiIZGia/e0mQ2RnyEBoRJAbuHLLyPmO6jgPP?=
 =?us-ascii?Q?hSRuVLYFTUsVCsazQ3NcXWZ5jGah3Ot0wvDO+HQv9OlPYIJNEmC6diqdErB6?=
 =?us-ascii?Q?8DGWYbadgmamf2rMUIEGoCricGvxyzRsf/I6bFOzr/CYdYZgID4FCAgtiRCS?=
 =?us-ascii?Q?TdcuUEPEWepDf4pZG9GTvvRASkAyr2uTL2oBinueltxID4YxFI0BuFSgOb9C?=
 =?us-ascii?Q?vzHbtTrYXLhG0CI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZNe7tvRxhrxfufhxOFkxpBQHsA1UFeWOS+L0siVFSYG4ei1ZT7KlBkyhnxXz?=
 =?us-ascii?Q?7ybouoxFHsmDs+5IUQrehmiGHEGFPoi0hvElwfWI65uT0PnWmdVmwQW9sSVR?=
 =?us-ascii?Q?pEYopnNRBsivaNQu/uCQZ+7DMPC/f5DJfsqn5J+FO0wSRhocXwW1E5ybP1e6?=
 =?us-ascii?Q?HFyKi25Q53runCuwrGLIqdj6/aDf5SszmMLi+ZScV5sdF/Q0zuibrhT9o9fP?=
 =?us-ascii?Q?E5HNpUXFUNalMViBka4qbfOIv+OoOmsJj/xBGwaZ2YbfK3GjMbGcS8AaO401?=
 =?us-ascii?Q?cU0buS5TIZsYIp+8BIbw3dJrlWksRSGJs1olw4t2eO7mZCgt6djQS+Uj/UJt?=
 =?us-ascii?Q?t8aK1rSOr4vflQtTlGsJGOdmtBr3N7RUjtfJjv1VYXEIpfkpuUcoxW8xf5No?=
 =?us-ascii?Q?JyPjvkcWJWFTkDovXOEk5xpLXaHh7OWUm2k8pndSSjw9uAlnaUqv5re+IHru?=
 =?us-ascii?Q?Y9TZroVDh6RBqo6J4LY9uGy02sQo0XJM1rv/fPiY7X9Yl9WE07/GxoW4jJrj?=
 =?us-ascii?Q?nhBGWkxv7vd55wtfBnBIGoyfXypXANb5nu+n0SoEe4MEnPQ9K+dukYwwLrdo?=
 =?us-ascii?Q?kbrY32d4cTAMo/ubmTKggTG1AOiZEzw3y0C4qCKKH4NSPOe7g4VMnlCT24ez?=
 =?us-ascii?Q?dHazt5f8cqep4JU7gSLM6JN8OWW5QPFoJT8T6oR1EK7meq7xwZGX5YlWwOTZ?=
 =?us-ascii?Q?bX2YiTBBNKKMUOQ8w+mrJiJz9WklcemufKNs3ovCvZmsSWvwh7B86umZLidt?=
 =?us-ascii?Q?F8QSp1zMEURF+mREPU5KesQjIrD16MEP5bJipQAPgL5xUDKuMBQyorchwhZu?=
 =?us-ascii?Q?+KlTKmBffi3ZGnABb+LFYTse9VHdt9Ad4pzzF9+18RFDISwbFKw6IInCF3FY?=
 =?us-ascii?Q?4o9r5MG12+4fbZPfonzp5lPokd8Fxx6kzP12y79QtHWWWl4e8DQIqWn2+Z3U?=
 =?us-ascii?Q?5jdnJbPIiESDC1wQeopzQFvOxHndJyzei3trbQyj2NtZn9doPHNwzirEKgnP?=
 =?us-ascii?Q?veFtj6oJMtSxN8hVA6HYNlCUe9wp/DqQhlv+xO2uG925KWhYWbzOOrqTfFZ6?=
 =?us-ascii?Q?pm64QT58OfnbGCltMQuYJNAfzM1QcPPzguc5Ahalf6zi23NGhvFXK+xR3yVi?=
 =?us-ascii?Q?CDOq3/1e4QzeyyG1KBNjgt9lAV0duLMrrvId2f+ZHLYj9DevEEluhWg5eR6l?=
 =?us-ascii?Q?6VF2WupvxPmY4ZBhRgZDdzv+ttzF7qyrS/NAfKnlN9Yw/EBjaAyr5tgJ/VK4?=
 =?us-ascii?Q?zfPHmRgyYwFj/Udzr5PfpW+9JsaULWoRfrj4JQPUjRkR3HGpUyKDXv2fUoA0?=
 =?us-ascii?Q?xQ5OsUMqjikUwWDyWR5GSOJSj3B9QcaBDCYYSH5R56kW4lDRxbQfbsczfy2J?=
 =?us-ascii?Q?PKEbYcgwXCkR4XWFeQift92sXAhiOTsdQp1SPUfC1COx2bZQzAa1NUIZln9z?=
 =?us-ascii?Q?SmDjCEszzDPrM4df12K6R6BIIDLpV33Qh0Va/i24dzjaS9s5bPZ68oy+Cjcj?=
 =?us-ascii?Q?YisbxGN20U/6wLhvtoGkRF+ns1rVu3FO7o0ZSVlyuVEB5CtQ/CXEedENT3WJ?=
 =?us-ascii?Q?3K45BJfPofGyOgXOH90YqsWdLPbqh3amn1O2T2mW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9065db45-de83-4e4a-f3f7-08ddac959ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 05:21:13.4076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3id+4hjpyAQGpA7wco2+kBA6ONjIUuQxR4o5bvGejwzB52jycO/8qNp2tEp0MCXE8BKP6jdbHjlNwhBWF2N5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8528
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Sent: Monday, June 16, 2025 12:15 PM
>=20
> "Tian, Kevin" <kevin.tian@intel.com> writes:
>=20
> >> From: Jason Gunthorpe <jgg@ziepe.ca>
> >> Sent: Friday, June 13, 2025 1:27 AM
> >>
> >> On Thu, Jun 12, 2025 at 08:05:37AM +0000, Tian, Kevin wrote:
> >> > The initial v5 patch [1] from Nicolin was similar to what this
> >> > patch does. Jason explained [2] why it's unsafe to destroy "userspac=
e
> >> > created" objects behind the scene. And a general rule in iommufd is
> >> > to not take long term references on kernel owned objects.
> >> >
> >> > [1]
> >>
> https://lore.kernel.org/all/53025c827c44d68edb6469bfd940a8e8bc6147a5.1
> >> 729897278.git.nicolinc@nvidia.com/
> >> > [2] https://lore.kernel.org/all/20241029184801.GW6956@nvidia.com/
> >>
> >> Yes, we have a problem here where we both can't let VFIO go away while
> >> the vdevice is present nor can we let the vdevice be fully deleted.
> >>
> >> At that point it wasn't such a big deal, but the new stuff seems to
> >> make vdevice more complicated that it cannot out live the idevice.
> >>
> >> Probably the answer is to tombstone the vdevice in the xarray so the
> >> ID is still there and userspace can still destroy it while destroying
> >> everything linked to it?
> >>
> >
> > yeah that seems to be the option if the said life-cycle dependency
> > cannot be removed...
> >
> > conceptually it's still a bit unclean as the user needs to know that
> > the vdevice object is special after idevice is unbound i.e. it can only
> > be destroyed instead of supporting any other kind of operations.
> >
> > hmm if the user needs to build certain knowledge anyway can we
> > go one step further to state that the vdevice will be destroyed
> > automatically once its idevice is unbound so the user shouldn't
> > attempt to explicitly destroy it again after unbind?
>=20
> That is what this patch is does. ie, it automatically destroy the
> vdevice while unbinding the idevice.
>=20

plus update of the uAPI description if going this route
