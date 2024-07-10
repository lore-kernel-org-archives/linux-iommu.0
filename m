Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E65018F2EF
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605405; cv=fail; b=jYACnv4DoTYIIwVuXzfMjRWKv+OQYlIpu6Z3WJZkEqQkZBgZIM6pp/aUQhfqX9nv7FdsiYWip8fIeSxyMfgwJuUd3X+PqnsPPt7i8Y4a/CMqyQr7tF2XcE0PCI6uI1IosY++tnZCfpPSij+iw3rzhsap3Etf63eR7KI0bNmr1j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605405; c=relaxed/simple;
	bh=6o1Hu7AajgGjxXjMvpeKqyMMgxZWbD2PaPH2ssX0CLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J091QWJE8ZjLErEVyctF+2uwzVYvHzshDohdtUDeBSsAFAkZpUHLY37cXAaevIciksuICAZ9FElLblYXy9fpJ7aNdE+satjq9I9v+20uc9GkX9g2bne1y/ZmrJEWjpXnjlFg/kh1/6wvMNUyGIaxOaM4PPAQpFWsXi1FuHEZA5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3vZ/Bkt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3vZ/Bkt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720605404; x=1752141404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6o1Hu7AajgGjxXjMvpeKqyMMgxZWbD2PaPH2ssX0CLM=;
  b=n3vZ/BktcakDIqybdkp7YB6eHjJmvvA06bVKk6n31D+kkLhUlrlGj/rO
   0+B/X7pI6kTVRAB99kmNCr+RqTfFep7dXG+j/3R2hnTaAXPuF7v9qtCa4
   6JcQj4DEwxInSWpZzOhTH2eaSSXb3D6/2MNCC3qS3AyQ6CsPDqRKgjR/q
   6wlekFe3q2+VCDY/70k4PR7KSoU9IdwvioYXCi9T0ilKSPadZw63feJFD
   v+lfB6AI/433WJCiVEXRTN59d3E+t3JvohbedwJfUwERNBtfWSfCweGNg
   NdOAz3ueWNtFTrlEHXkgrJismaJHf3XMt01ExGyhYojW0btWvauec8VNf
   g==;
X-CSE-ConnectionGUID: OQAxXZNdRl2CiJaiMDnLOw==
X-CSE-MsgGUID: j/Dp9FByQLa+AdgNAU8kIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18119498"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="18119498"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 02:56:43 -0700
X-CSE-ConnectionGUID: +wvtr6JESIqHcQsASJ+WEg==
X-CSE-MsgGUID: bSYwVKtUTwi8J8g8x5Jbpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="52754839"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 02:56:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 02:56:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 02:56:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 02:56:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 02:56:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdvSDlM055DilB94RcQtl9qLH/eTfit63GTla2pIChxCFK/It9YhwmEclXWMU+sjsRuJUUjhhQscZUTJsHoo7E/0jmeZ9ug4csr71OXWHWU1eLtlF/VS26uhNI8SQ4ZmtIV19E5K0s5puAh8u5WA8u+zb3GFpPbTwqUuF4/zcVWveHOkMRd9n2E5U2jtkKDLm/uXb/k4Rj07q1j8uuv7390JrlejBDG5jt9NPbXMgYpL6XLt64Kl1XF/jpTB6bvpzKKPL+WKsMMdFXU6tRuORpOqek3xDxBoEzGSQR+yfg7VVDOqJM+6DCruc1R5yWBl4yQJie49D8a/kv1dOIF+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyuMFWAFA+G1WwmyMOFbfScivKN9xhe49PknjqpEhhc=;
 b=ZBLxVvY/z/E8/Rs3KskGd/XOoSJhdrE7oWpS5KRmxgBWY3yePKILosLpuo0cT0mW7weDwIOeiiAVqSyQN0c3Y7j8EME1OtG3RJfGOCNlFj0PfiLoK7W9YZX53TBRb8Zn5hMwJRM1lQkjNPN7OrzaMGd3Cqh5ud1JbSAfRBr6dpc3UoT/yvVTqIJIGL+OaSQLr6rTj/Jz8BM38QfpEPZRYuSAm2urSmX45WfT1QRtLI7YB1xW4jSWnDs0UKezQwtLALTy8nPopEyW/NoGpheAUGhBMjFohbgkisqPh0ThpqSpc0Bxlo71NaAq0SzzVVoKWP1Y5kj6TZJ2tRKG3otSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 09:56:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 09:56:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] iommu: Convert response code from failure to invalid
Thread-Topic: [PATCH 3/3] iommu: Convert response code from failure to invalid
Thread-Index: AQHa0qRTl5tVJ+50b0SpGFoIhd92g7HvtzRA
Date: Wed, 10 Jul 2024 09:56:34 +0000
Message-ID: <BN9PR11MB5276EC68D1BBB52C9E6DDE558CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-4-baolu.lu@linux.intel.com>
In-Reply-To: <20240710083341.44617-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6099:EE_
x-ms-office365-filtering-correlation-id: 24b6ae84-579e-4cc2-c747-08dca0c694ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?z06K3hStwxMYWEjLN918Xd/X/l8B3OQj3PDPnbuBRO+GyC5wxSn5wObalbZ7?=
 =?us-ascii?Q?cJ1A3Z85W5K/67GrMjcLcsjlxZjxA4OG3PJ4SLq8Iqe0A/rhnpu2dBUkwMDL?=
 =?us-ascii?Q?aP+lfnoMojxpex6Go2ctY6Cl+IjO3O6JQ++9YRTCxkBGGzN5GDr5ZH5YnMRO?=
 =?us-ascii?Q?PzTOILvYXFpIw0W3acpSHRo2+IE1AX8eiRCPQT9P3T8kO2/YB5LvYtOF/Q4J?=
 =?us-ascii?Q?YWhArWZsuQDgmPqdNxSeSSOT9xUS0Q82sNKzdehWw6xpebaPiJI+mBSsI/Of?=
 =?us-ascii?Q?nyHQ7ZzB7KfKAVZIt81xzaKryyX6zgfrHReIy/003Th0JYYDh+plzlY1mIxm?=
 =?us-ascii?Q?D2QRWgWOC6s8Hp0w/TsNAuGqfUG8GoVqwhbm9QnGxdOIc+EjrUSu/e0xl+9O?=
 =?us-ascii?Q?XSTMT5GZLENWZdWtkP5LNY1P9YaDxI4nxbYY5YvsCOKxUkoe5Cypwukg2T8B?=
 =?us-ascii?Q?o1bFRogV613Oh43zd+wViyHscqMNfOhQWWox4vTR4nu2pW0JoO+1q7AokXHc?=
 =?us-ascii?Q?55m/Ns5Ike1z0xPg/5gz3s80R3AcuRfJd7Ci9qWiINVl13thVYG3L4EnQkB1?=
 =?us-ascii?Q?duHQwMrBc3AwP74P755Cp132DmlwpT0TOWgR9vq+h1wgo+LB8vFLGWOJ5rdP?=
 =?us-ascii?Q?LKZ+2QeDegPx4cV8QQDGwPYOz9Et9KwqUVZ7CRQC75gDJj27LatjijgTKeWg?=
 =?us-ascii?Q?T3KN5pkuGVD2mOwZ+YPI5ZqT9HR6Dv+vdlDabhirgQFKQy5AkkBE8DPf9leS?=
 =?us-ascii?Q?pXWTiFgWHTSH1TwEYDjLm4Z0ktyYlpyFplfvAuHoH87Hwx70ULA3zuqETEdD?=
 =?us-ascii?Q?TwFlEDg7vDy3JL/7Vx/iLN62Igejlt72tofn0cRUkXGd9Rnfk9HqW4GkwPcB?=
 =?us-ascii?Q?5BuQR6vAVDcgGwheepJ/2B00b795vLsq3ONjg6XMAamtHd1NfHy2dj1YtiYI?=
 =?us-ascii?Q?QrxVDlt0MNwxFbzl5xncixtj6yvk8nf9ramVAb9FM+7u+b/4zXDrI85UerKJ?=
 =?us-ascii?Q?1KVQfwPo1uy1e1o2TD3w315Dr2VJX0vkts1CLMLPU2hTkcTaMwYqv3fUzre1?=
 =?us-ascii?Q?bjLJqAIQZp9iBHYdiwIDcM8a29C19wwRvJbuB+aFYGjbKD7eBFC9JJhp6inQ?=
 =?us-ascii?Q?rZSMgM8G7Ky/3fHUSxll8HYr5TWtftmm9slIoBB/v6b50cMKkj0wtDhmL0MS?=
 =?us-ascii?Q?CNMHQ1JqpKrBEpPXUcGk96HBJzsPj6vCghOgPyaIv+jrJVv6h64kU+LWbbFv?=
 =?us-ascii?Q?rL8xfL/s4++dMGC0y/jhKUoLIOJKP6f9AZTcC7srXaD5igLaywQG/dr/zbBP?=
 =?us-ascii?Q?Jb/tMhZtTbniaDT9z8kTYC6NgDHu77VG5eLncUI042Cl38zVQkdoUUz2ynAu?=
 =?us-ascii?Q?zGTeqMENX/iCeeEsElwxe1St74HFnAoKY9kz+2M/Un1bylYbxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5MfH9KkMzpaZxChcEmKMPun6wUtw6NqJkVgx99LVaIDtTzqc0WMIYNqANFhB?=
 =?us-ascii?Q?mWq2NUe1Jq79OGlyfA8msUcQVx0rNIYdDEGnsyhID7bq81bMzS0Bn7g/bvKr?=
 =?us-ascii?Q?LrQbxdncG4gqDQI4CwKka+IgAp/0WRqM+MTUIftlx6fBJ11CI97mkgYY0jiY?=
 =?us-ascii?Q?fDJQtudZ/kpyAJI2DYZj2wPagFYe1diOlcDSDAQtiMX7Jffesb+x3RnsPhUO?=
 =?us-ascii?Q?36mWZ3Gi/42V/8yz+is0l4UtKzRYgVP+JVNeuFKI+Fr39kIvOhve0NHPyXit?=
 =?us-ascii?Q?H/Jk6XWkYWvsyV/LgoIyVWhOIaVj3CsCDpZncX4iLsaoRMj3glyPvQlYHm6W?=
 =?us-ascii?Q?6iUWg9bOA6oLNkj4b3pkFVLMHgwnXpNByrJy5oo0N7AIDdgj9DnP45WfM4u5?=
 =?us-ascii?Q?HvGFQC/gqRGG4mHCB0VAN/kvrkbWUN2S9CwdXFf/pn+KeVsahoB2w2mbnoPV?=
 =?us-ascii?Q?WDX0GGwJkxUqFfTFfJl6zLiqH4QNBj1pxgmWGAAYHc7oxh8W1qB27JWE3K+P?=
 =?us-ascii?Q?BzNBmdyiDV5VP3E8kTkJ+ET+K4XKiF3Qy4ibcYIjOSLjessdt2SeTtKcjC+I?=
 =?us-ascii?Q?gsKZcx/cDuH89jpMr9co2wIBLHZCMAI05P8InBWXm1noga8hHq137per0ukI?=
 =?us-ascii?Q?KgnPKchqf1HGAaKJtGI322mQk0AF0PN6Y0qpWJmoMYmQv+G2TY0bRWmBeGWa?=
 =?us-ascii?Q?iVeYu0OriZ3WcSeFeSFv/Bz5f8LNFOtJormOHVC3qeIWUvPWP8yro5MksUu6?=
 =?us-ascii?Q?L09TXGLIMd2KvHMeLeEVBpJq0FWt1Kao0Of0gr1dy9stJpbeoBh1J8Yt2lBo?=
 =?us-ascii?Q?2fDvU27S/CxcnX6CSlDOHKUsm9yvnpeMiB+HD7pBA0iB8JbIHmcrzXnvfMwm?=
 =?us-ascii?Q?nTaIvXWkoTVIKgbQa5pliaK4w4ojnHS43mvXFzYP/CTpCS346QnZIsoGEtTE?=
 =?us-ascii?Q?cTR2jnxT1NELuJeVnkrqBUF5IIk/4ioxbVRmHm05k96qcMn+nSEfW9VBbMwe?=
 =?us-ascii?Q?oU1I/PCsXUMsc6jGQzkad/P+R1hano22I1WQ9ektBANlYEZxVVlH+/uCSHuC?=
 =?us-ascii?Q?ZXZuAwsFYqk6cMEFQ/AHqpWzSn66y8K8mCYKES5bgBYd82G1/OpYZPr3Nl5p?=
 =?us-ascii?Q?NSGtieWD00LE+/vXKmhwS5zQSO4twHqGuRYdJKUJGI1zhaShrOvYtUGYb/ay?=
 =?us-ascii?Q?3UhnP5I6IUutCgZYFXoyZXNw5N/RnvfhzY1HGlLz/hDqXR3R2I8WbvsgEBu7?=
 =?us-ascii?Q?OqA7EFWq7nqhEc+ghDJYx5A2RXy8l+h8j9QCSfxdXsSiR94JeuM1GPHMeRw8?=
 =?us-ascii?Q?ESyk1zmWEhkTq5DL0bTmCS/zb++jdgv3+pKxB9kERw9t6huMSiCstOQ8veys?=
 =?us-ascii?Q?wbxW1y76n58Q9eZiPHOHz2Al3sIwdwAs3i1Z0AUgD9J2XJS7THxJ6YmgScvj?=
 =?us-ascii?Q?f7qcKPwdGAg2Ucws7UuFLCzUsLPqutzSn23ehEDnypSTNI3gZy7iWv4JUVsK?=
 =?us-ascii?Q?GDLmNLp4sLrsRcB2zqcs8yzaQaUoqba9cOWRJXKY0jo49cO8LpHm1KIujdv1?=
 =?us-ascii?Q?kY+qc/SAMJo33qUTFjx1Ay2r2JcQqI57GSGq2zq8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b6ae84-579e-4cc2-c747-08dca0c694ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 09:56:34.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +af5sfG4vEkypRTTWfPjpGt8t9Kf/LXS+RobvUJCYH3rCeNgE3CpNs8OgUm+co7RizjF3CngLyVMAG5er5HiiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, July 10, 2024 4:34 PM
>=20
> In the iopf deliver path, iommu_report_device_fault() currently responds
> a code of "Response Failure" to the hardware if it can't find a suitable
> iopf-capable domain where the page faults should be handled. The Response
> Failure is defined in PCI spec (section 10.4.2.1) as a catastrophic error=
,
> and the device will disable PRI for the function.
>=20
> Failing to dispatch a set of fault messages is not a catastrophic error
> and the iommu core has no code to recover the PRI once it is disabled.
>=20
> Replace it with a response code of "Invalid Response".
>=20
> Fixes: b554e396e51c ("iommu: Make iopf_group_response() return void")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/io-pgfault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index cd679c13752e..b8270ee5dcdb 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -229,7 +229,7 @@ void iommu_report_device_fault(struct device *dev,
> struct iopf_fault *evt)
>  err_abort:
>  	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
>  			     fault->prm.pasid);
> -	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
> +	iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
>  	if (group =3D=3D &abort_group)
>  		__iopf_free_group(group);
>  	else

this doesn't match the spec words on the use of INVALID:

  One or more pages within the associated PRG do not exist or
  requests access privilege(s) that cannot be granted. Unless the
  page mapping associated with the Function is altered, re-issuance
  of the associated request will never result in success.

this situation is not related to the permission of page mapping. Instead
it's a global problem applying to all functions submitting page requests
at this moment.

Though using FAILURE affects more functions sharing the PRI interface,
it also proactively avoids adding more in-fly requests to worsen the
low memory situation.

So none of the options looks perfect to me, but the existing code
responding FAILURE is more aligned to the spec?
