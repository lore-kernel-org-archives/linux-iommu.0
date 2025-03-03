Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832E1B85FD
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970536; cv=fail; b=P2OeTFUElZR9IHELdOr0E/Lwgrv+6/CoEFYHovKXmOlxGyz0ITWtX8NEjguQSzocW12xN9cPXY+rZQbRaFozCxV90KU5cMh0X+Qvz+96jIeKn1BWjMuWE+rFXk+wpezr7I6h1b/oDCOjGc1UulJ/g6Ebq8uquTVMgDsFECk5S3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970536; c=relaxed/simple;
	bh=vB2U+mbgopE8nPmnBGhB0BfqQb3Xp2mPf5h2WWMovP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s+sdotj3YNfWnt+A0/XygB6usTEs7Ezyfr5UZZTaGqyoVDBaKYxxJCuF6S8afu042bnfAWEl1+fwMh7qQ1C9HUKpnxgE2PQpg376vNPkZEogs5omWIVeI0kyqfvId3i6eDwUift9T3Xx8pmuuCcyODa8NqSBkrev+JaBwyua0b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMMhZnJq; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMMhZnJq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740970535; x=1772506535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vB2U+mbgopE8nPmnBGhB0BfqQb3Xp2mPf5h2WWMovP4=;
  b=MMMhZnJqAcMMNIxuAqQqCoqNuscT0JbyEoN6A/4fxVn1KfaX4PFEDrYA
   Yi9FN72zEcwhk6mCjth+6sOUy8IWbOPE92Uf02VG5q3NgO1rGd07psiyd
   SZk0XZmTawXEUFtTPvZIWGc727RaB5F6RvGHc4q7O1t+HhbyycAspb2Jg
   yOwFr9QTdxHeXDgvgFkTbNRITbkfqbx6XbvDszSyUMcLMA+GbnJRh8QAb
   6gkzMjGTw63lbINSg/CZWmW/chnUNK+SGgGgky5kBVEx5QeyRNoSF7l+n
   eMLADlDfi0NSjzKYqAPDle+JIlIr5ElxAuZcLDP2xykfbdrf6/T7UTus7
   w==;
X-CSE-ConnectionGUID: U022eXILRzmW2/TPL+wLuw==
X-CSE-MsgGUID: 7906HVA7RFiv0PAtk9E9Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53239534"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53239534"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 18:55:34 -0800
X-CSE-ConnectionGUID: yyOK5q6HRB2uwcL2QBB+hw==
X-CSE-MsgGUID: 0rxbyGxqQi27335g6UH7Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118787551"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 18:55:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 2 Mar 2025 18:55:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 2 Mar 2025 18:55:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 2 Mar 2025 18:55:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqcXAvpWYgNdC7+v3KmZD9ls/J2nprLFsoACThQcS2yWRnSZYeFIjfhaB2+jvfThs5LrJCuw+5iElq8Y/UXwphh2HYdxlJ6Nizp+v/MnJ3dV8IV2HvLQHtZtxYKfvRe9JSKlgFnsHovKDQLIJfPuC43ows2/wz7Sf6klh++7+meAiNk+RqFmnGCQKqKjpTmHG4GvbA3YRnh8pX2drMJga5Fs4A7avzumKF/Ia88hQ38WSMybLDLVeJL0QwnF9hw07o30ViO9OYBkq1rZIveTHHRZM57Xd7sdadkXX4q6uuR64NSg6tSJ0Tn2Zev6BPNrZnl9MWwH9kXG35A+BTm40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m08Uqxs9l/TNWOYAlmb361MZJtCyiV3yysVPEVErbmY=;
 b=fMW8s+t5vaT1p8ioj0kri0nfh7ud0cVzNtxaCFeKj/xvSg0UK2Ou1kGT1fEBqJitOu5fIxJic34WR/u4n97jk7V5W5+PN3SrvT3G48+afHz8ThqWf+JkJRlgfLloLE5WNFip2ONp3uHl9orppHe5ImF/vu32bXY166NSiigL+XPwP4vI1JpKhyuGmK8J/850MP92HSP2Gm2NZEUUVHtDO/kJ893kp0A4k2oeS/CCyKf2u6IYEdWwUl/3yP20eXOb6F8y6uIdW3Lbgr2YdLvE+gf3m0nVs3PlIGE7M1HHN7ddCZ68qLrnSknvw8sRPAP+Xn4JqAVb9xMhIw0vZVNq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7901.namprd11.prod.outlook.com (2603:10b6:8:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 02:55:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:55:30 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
CC: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3owgAIlpoCAAYmhAIAD6loA
Date: Mon, 3 Mar 2025 02:55:30 +0000
Message-ID: <BN9PR11MB52760B287D6878AD98A1D1598CC92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <20250228145636.GL5011@ziepe.ca>
In-Reply-To: <20250228145636.GL5011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7901:EE_
x-ms-office365-filtering-correlation-id: e703a06c-701d-46f7-cd11-08dd59fedc36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZU7e2wkWQQ12bLNXEitSYCq2AR3jH++B2tEcyPuWBfPJDpF+Ly9Xf/MnPRpM?=
 =?us-ascii?Q?nWMh+swRXVjTxDQ2N+Oo6LTvsCrqVKUPgMVd9HEjzRgREVctI1xv7biTBYaa?=
 =?us-ascii?Q?++QIGki5WOHvy/UhQ849S/F5LsxebkXrvJPHE1f5orhj1E1NT9jrZoc2eEM9?=
 =?us-ascii?Q?6rOROZ2Mt+jREyignvulX10rn5TAxEhdIgLsgiDg3fFAXC+gLobF994MFufz?=
 =?us-ascii?Q?31ln6kLN9b/B/ROuDFlNF4Ep+a6HecMMAJ3X/59v/eK9n7Wit6dxoGPcVYM+?=
 =?us-ascii?Q?qXosBbiU2K9TzTlMSefE3fwS9FS/sCZy1PhvUS3G2FxeuzZ/USH1AqBBJj9E?=
 =?us-ascii?Q?qwjpWiUq6C9XHGPPOxseXFrUOW8B9dbv/rAwCU9Gj0zCZ76pzbLV33/Rv3Gm?=
 =?us-ascii?Q?HwDoHQ2/WQ7afX1Bi24M8hg+SoloTkax+JV6sIxCujmpnOSprRHOBQIwBIAy?=
 =?us-ascii?Q?7QLBwwD0dadd9MY5p5s9WqBgzMlGNWRd1lFEOCYW3e+JLLcqx80sydGKzxGV?=
 =?us-ascii?Q?EEbne9uPLsIZQlxcXre4fH8KKLoWb0yJQ/v6oMW9AjEOAZGwOIIZeawb3M1V?=
 =?us-ascii?Q?EfnJ9wcuHJWbs9DuN9wMfr398mX3ZnCyOSrlOlMD0paFgcwp3lKADBRgLK6b?=
 =?us-ascii?Q?O0eAbjNjq2rp3KhmfmsqJ2m85z0ZpDGhMRpVjgQ9ikpwdQERHWySVMF3kWkY?=
 =?us-ascii?Q?3Eomm7uUsmpBpKabCLmBdhdigtsi+S7SK5NEBBgd53ioUb+hnJRiRHXWFW3V?=
 =?us-ascii?Q?7n09uVBgdm9eW9dgSyR2T1NGM3q4ndGDOAQ1hcFSHk5M+fAiPGsu7xg5JFoz?=
 =?us-ascii?Q?5qnG/FnHNb7Z/VykktU62yVlDNvNVIDOnFv0shcDDeE44U5ZY057EWsCU/8x?=
 =?us-ascii?Q?Gzb/iLHIPwjp4nDdYiHkwtJX7Miwlc5V0EbHAx0RAB3PYglm5WvMU8sy8/7J?=
 =?us-ascii?Q?f5VzUJIH9qVuyDIs9NOzpsbyxgyDFa3v1b2nG3FaOpjdmo9aAVAUIUaIEt76?=
 =?us-ascii?Q?fUQOAJB4mMRZyX0kqSfu83hMCQiC+bUjeprMWwA5fzIvCjnJscvr8ZsixArf?=
 =?us-ascii?Q?QBOFGegHoKenV8KRaCMx9Qpue2DnshKj9NGSEhliMVKH9E3OA+1D3JPPR/9T?=
 =?us-ascii?Q?YHRdBX5cl2VNQucov4QRuhY42AHXxTu9KexY3a5tGpxX+TCRu/Vm4UGB3grs?=
 =?us-ascii?Q?wQYg7OVgRdtrPClW83AmvU7IpJSdk/XraX4ZhaInMBcBHGcn/vL1DPSP8Tah?=
 =?us-ascii?Q?9vaUvW058bTQam828klsGHlCjmNtsgu9cYI72DCV3K1A8lCbxanG6UCQa0p8?=
 =?us-ascii?Q?2gP31TQ4tfBfBtTC0MnvlUd3dDz7Y5ZfHSQAMGURVebqErFWQrOpUJHWFBNf?=
 =?us-ascii?Q?bau3HDMuRLAF+TJbCfKTAA/IxCnJTjx4UKRlHHhIjQmi1/fB4ZGCjLAPRKY1?=
 =?us-ascii?Q?TbNxz58553FbjfPh5SkpKhxfVTvf/eB8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EEQsjZnx9tFLHcPrnVp71TBySeJkaR/b4NO889KRCPykhDhQmiw78G0hUsHn?=
 =?us-ascii?Q?Y7Qz57HKugU3g9VqECfKF1h4eWhfBMwoKeT0ygVagGAasNHvCG46imP10gyr?=
 =?us-ascii?Q?ABsxyDsB2n05qhB9ico2vkxcJ0CUgneNfhIQnz8+qNROl2h0eHCWG3Oqeees?=
 =?us-ascii?Q?8exKKVfCuOgtC9qRg01EtaPAV8EW4vZFK5FRHmocsrS19IUDpZwH+9AzmXf5?=
 =?us-ascii?Q?ym6obnpNP/BXIfELmRXjA2NpNpiwzYnE5SYzQN/T2cmcOMWn7ul09rCZmPtJ?=
 =?us-ascii?Q?2svf99+7/rciMCi5kMiGYbG5lrBkVetmMnpM9hvPspIW3BxgGvdjT3NJygX3?=
 =?us-ascii?Q?vWY0iA598OsE15tGJlgQ06BA7UmpwpQiD2ONq+siG3QED8JAf//rl2Uw8y3n?=
 =?us-ascii?Q?EaFE6tTBXmx7oDwMzuozJhEi7KO5901184luvViG/h1WDCQfRi5/1xvIukMj?=
 =?us-ascii?Q?wkHG2wkeGiAcyDtnXZl02mgN9Q6gry0u7/EmH+l8WOjSTL7qjDMlvVsDzUOl?=
 =?us-ascii?Q?WMHe122G8BjosaF/NFbyU65wj+PI9E5twu+8kQ8stfOB3PlvKXO3sCMQqib/?=
 =?us-ascii?Q?49bl/8Lvu7U4IusZvLbJOWVPgTKh9qaehAT+k2UC2JD3BojoDuxlfmEkSFn9?=
 =?us-ascii?Q?29aIj3JTqd6V9DBSYOmlKrpEpP/g5bxStL3xI+K4zGtJeItABTWA17FmagbU?=
 =?us-ascii?Q?iDr7UeK8PbGze9thHQszikweHNGPQ8Hzf9RxZq3sBUmVsH4RXl8ln6PPG6Pz?=
 =?us-ascii?Q?3dvLA8n0F8Ab8OO5iZuM5ZtP4nNfGmYhqwqlL75hk2HUdwTzNY8Bg3P+1Gab?=
 =?us-ascii?Q?7s7eH3U6/y0zoCwbzhSpE06Plyi6K+SsbONZkyn1qsdJA/Rt3tEGizDchl7O?=
 =?us-ascii?Q?0Nx/xUjpHBJaA41nN/Zhv2Mx2XOfcTcOe81ZJ+N66gMon2HYTqpgb8ZzqRPd?=
 =?us-ascii?Q?sUPVZabyF9PsQ7XHNeYXaq0mHxdtwZu4LsGqUZWvY8yeZJeki+nxl3EGAyjV?=
 =?us-ascii?Q?8zB2YvmRXhjSa6UcSWeGDKIK6Cr9CWSq7WK0sArVISOGrDZ9aHLKbC4Hfk+0?=
 =?us-ascii?Q?2mkeo1/G/mTF/goNGDoMdK0Md4kQxHaP2skmGQD9z5AXBbCFS4/82KbY/tUh?=
 =?us-ascii?Q?2dJknROVoZTMtzzzpd/0gOKrNNqN3+TzSr6IaP5Ac+YR0NSsHi1YdtlyI0Mo?=
 =?us-ascii?Q?CBIC7NZPhzZd2HBEehQ5CPMBO1te/drbWYun3DSJNZxrUPt3deZRnCEKBoto?=
 =?us-ascii?Q?pQKZ1k6LMIQ+GJicaVPnpTPBLynFkg3h2cRqO3Yz1HWty4+4DgLRT6w5v9Rp?=
 =?us-ascii?Q?2p/Nuy/Rs/ATqaNCVgOZsqfhKWyaQXpaZASDSb8g+thMFn8fEoXmUwUlZaZa?=
 =?us-ascii?Q?E7hejFPyB7QWv9tJyASYHDaoTAB5E9VD1uK6hpZRFXvzpy/2niIfs9nw7ATP?=
 =?us-ascii?Q?b1R+qZiXlfAPAOsfj23VKqUqRuxiitZdkDG5Xgo0IDKQEHKOwYtQXBzDqsAb?=
 =?us-ascii?Q?1tIsSdg+562WthbVaVyI803A/X/r0ZbJGLrcY5BXHDWobvsCXlUuj0f6G+An?=
 =?us-ascii?Q?1culUieel6mgJkrZ0tQRE45L/qB7lHc7APbDac93?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e703a06c-701d-46f7-cd11-08dd59fedc36
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 02:55:30.7471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yWdwqbyCKFCPFPNATQwwQXu8sudxXAYOnAhwC557/jSKCW+MU18SZBrFdX8Cykw1/2qIuFI4rRJ9nhoqT9R0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7901
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, February 28, 2025 10:57 PM
>=20
> On Thu, Feb 27, 2025 at 08:57:45PM +0530, Vasant Hegde wrote:
>=20
> >   - If HW has a enforcement required (like AMD SNP case where Secure AT=
S
> is
> > must), enable secure ATS. But do we need some way to inform core layer?
> If yes,
> > may be have an domain ops similar to def_domain_type() ?
>=20
> Yeah I think that is probably the best option, some kind of callback
> to the drive to check if a platform forced secure ATS is neccessary.
>=20
> I assume if you need forced secure ATS then you also are disabling
> IDENTITY and disabling PASID?
>=20

Out of curiosity here. The host is untrusted in SNP case. What would
happen if untrusted host disables secure ATS after SNP is enabled?
Is the bit locked down once SNP is enabled?
