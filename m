Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10A2AD04
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752203804; cv=fail; b=sIa1eQxhSGovZw7m3+o5nNoMnidD5jq6LrYhY2xFBI+LcDRkUoVk03XYXU4ZW8DP+8XSUkJ3InMQlE4hhQ7zzQ7Lf1MGBY0A/yqikH3H076QcbMBPEY/ikldh4be+bxtna6adObZQKC+gfswuT0t/zqDW3aVQypkXLme/RPJy8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752203804; c=relaxed/simple;
	bh=ABNosIEY573KvMyqQDy37/bamEwopVq0eK9PKn9NURI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zfp02/Q8dPrFts3ol79sIMNP2N2K5lxj1hweJ2elx39gbjjxVT0FbLE2rpYVJyvi853jbxUwfH59nXi1Y66rFBNKj3iKSBYWDlJHbVk+Ue7Wp+ihvbcQENiMLdjnNQ4GUbeTgUE21w9UI1e3nzDLZHspxPgBvasKIO9fbpXVNwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwcSqKv1; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwcSqKv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752203803; x=1783739803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ABNosIEY573KvMyqQDy37/bamEwopVq0eK9PKn9NURI=;
  b=VwcSqKv1LupZJVGth/jy2a34k/PRmyBY5wrB/fEZN4SY16UaS9Y+gcYe
   AK1ulYUfOwhj12O+e38/hTSCjO3BwCprUmhgfdYa1piJVN4Ke1ZN3dBFj
   RJ3YWyc3h7/W3IQleNmvkR8p82/IRCbPeAXWiPNgsZStWAnItzGrtz5hf
   7IoqiPkDMYLZc4S0zsfnXd2eN+XZGd/7wYm4zG+356w3Dsw7ZIqGPvZG6
   mOCRppU0vKs5abusr0B7EsDxuojkmM7OjtCIrtT7Apge5843fq21rgSLW
   h6qcf8MtFc/SaWadA5nO3lgkbmwYHiBEBjI0tLEN8Ud+ZPlpVeWZe/byz
   g==;
X-CSE-ConnectionGUID: PIDyNNIRQ+eaDXLmvCAZ/Q==
X-CSE-MsgGUID: 6i1ELRTGTZ6eCpVxTKESpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57111885"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="57111885"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:16:43 -0700
X-CSE-ConnectionGUID: q6ZOdKNHSfCaD30Ue/L2YA==
X-CSE-MsgGUID: 5zD1z4HeSjGKpOWFRGwWqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="160593917"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:16:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 20:16:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 20:16:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.87) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 20:16:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBZxjMcrrI+2pxgzBnbKmhvAmdeda0uzLk3SqmrO4vuRDCsb2KiRLB2aEnQ+yeZWKroK31ZU5+mBhqEpsEuIx2+6gDpJu7Ce37dGDotBTyogMcJhmUhOE5FTfkgicgnJWwqgxkpE7GOEFp0iBSLJCjFGzrisw+tcVth5Xah+LOxqXto8a2r76rRFi+wOnN6RjwhR7+MM5bDxkExedvNZRUrfuwkZP4WEPrWsFwOKBnOdiwY16N06wfzZW83T6iJLIe7U9L3klvBxf+PyC/NVSY4CTIi6p/Y/6OCybFsX9R21fE1N6E/gBSubYnntMtJVvfXZtkEATp8KiTkd3dmUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/i6wsdbm5AVPDGQlIDK17blCNkFvOHwOna8nooSUuU=;
 b=WKL2c+oyQ1pV1yDennBibcfub/sZfPnBpJh5KsYuTPcQwa3kvbqSl9RjYQ1riccvWYlvDUUOC2OWZquD2MIp8pNJrM59O20GdlRR6tSwy+hVFO+IFuqoIjksUZf6CniQbc/d+epArU2Gyq825ZZoGZKVAI1rGiI1M8Q10D1O+MbNdz5/S/ITJAYx5zjVGX93gCI7kqV85K4M7pw3EN9uLLk/sKQpTXw+Gpng2pgKd9UxW/Ob//I7y6/5533roKBJP05H/uWoa2IfWXhnb7USDJc/cDgJv8UKhvEXCerHOkHjWu6RysvKpte1PU3rih3FDfe5LFsc0TxW2CdvGb6axA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 03:16:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 03:16:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>
Subject: RE: [PATCH v4 3/7] iommufd: Add a pre_destroy() op for objects
Thread-Topic: [PATCH v4 3/7] iommufd: Add a pre_destroy() op for objects
Thread-Index: AQHb8IeFZvbtNefsaU2/A3f+EpS6fbQq+hSQgAChRICAAKf3EA==
Date: Fri, 11 Jul 2025 03:16:38 +0000
Message-ID: <BN9PR11MB5276F53F46F054F93C0271318C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-4-yilun.xu@linux.intel.com>
 <BN9PR11MB5276CA77E378CB3173CA76888C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250710171515.GS1599700@nvidia.com>
In-Reply-To: <20250710171515.GS1599700@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7715:EE_
x-ms-office365-filtering-correlation-id: 07786bc1-c543-4f2c-8162-08ddc029598f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xfVYbPib+s8a4Wv7t8UmVnd+MsN4vi/YE69U25fVrlkgz/EAV8ha/G6CMHSk?=
 =?us-ascii?Q?i4WFcCE0bmgZIzUY2XCzaqkhbPhU4Joq7Wi0cITwQuAfR3izWf7ieUQm5rIY?=
 =?us-ascii?Q?JUXd2kKQf5+iI1mX739I3TrKrms2VLW39l1l5UHu+HeBzSslB/8ZJQfeCkzh?=
 =?us-ascii?Q?l3hbAoGMnasoYKJJtx+7u0Ro4xHuDzLiR7CyMRucLccsbS/G1N7tW3gtFjxJ?=
 =?us-ascii?Q?OuQbRlWOyqwPzfXQee1KEHm9+or5kC2FpMWkPJMIvV+H3DZrNdyv7WnNB2vC?=
 =?us-ascii?Q?AHXKmF+3gPKnZXkkNG2NBuOn4JpCxIUGvHx9JCKwna+iIXBOGZh7s1yjIE+2?=
 =?us-ascii?Q?dKHJcJXFOXHkz9WQw+nUmlxYNTrd7d6iguYceP9fZRoIWRoCF0/PfbILOCl+?=
 =?us-ascii?Q?CNE6k6cY2+5u2bb36zkZ/XVNKvzcbW2Ub1LYxv7Fv1idKoqlar1e9UfTSifn?=
 =?us-ascii?Q?ANMxpgJ7M+VSU5upCmiYDcWUUyW8RM9+0GsVRS0TkFCfsgfPXB4s3M5VgxZQ?=
 =?us-ascii?Q?jFu26xGJiythhpMAJF88HSwYVQRwlpVKdcAaww/Dhi8mEsNHi/OwUaYwpqR8?=
 =?us-ascii?Q?zP+9Xn2yhxAd+12kJElBvbUgexsyNrj+mpIJX75UUFo1JNFmMFqeeVksCTAk?=
 =?us-ascii?Q?V5Nxq9ixo/ySkRsXXKLwsIfw9At+7ZJ3ovl9DF1X04RJyox/4db+NBgfazmW?=
 =?us-ascii?Q?tRq5GNMiG9riwuTLBXDAVvFKJezzrZp6DX/nRCy9O1GcR9+3Ua7Ts1wx0n8C?=
 =?us-ascii?Q?Ptaq2WaFf+A5pmG462tZKDS/j41Dref3jgZZeETtWfY0v4gfUElAwnb3j1w5?=
 =?us-ascii?Q?RxJWeScJsetmn1DVQr0ROEbTl9EjLjUxV0cb4XsZu5yUgubBgyrKcbdAYFhN?=
 =?us-ascii?Q?BoEb89e7JPtkM6YcgyqF1Ajibgs5GhqjcmirClzjN0KDTc2+apKnfJAFudhV?=
 =?us-ascii?Q?6oZQkGtGuAHY0XTzlgjYChPm3veBngoqtd4fe8M+OeCCa2r2h6De18tJIpon?=
 =?us-ascii?Q?J39ZQp11CwJbSkQJzqzgCP4TVJatm3O+0TDxFn3Ebkbf0PYN+AnOgNZ4dhAo?=
 =?us-ascii?Q?BBaPAIzAZZnSW/9drpIUy6+r+NHsqWmy6lomojr+TimvuBoJ6MRHW7np+cas?=
 =?us-ascii?Q?mIMMV+h6qJE8rNDmlYL4w0mQl0XLT/C+kjiXWRuPWQwXMKmQT8ZtoFk3uzMf?=
 =?us-ascii?Q?cXhzTAsXekdHXyGsfy4aXtwlO6AjZ/rK4QhwInsu5M01PljLFMClC+xMGw/c?=
 =?us-ascii?Q?eNxhJDRTH4wqjPwtypAZLuUXfpj9KzCx19/VqLr2H9lWYkkGd8/IUzIs6JAl?=
 =?us-ascii?Q?23IClNs2HZJixRt5PRPCOTX7oe5ReQK+AkccbmmPiC24nS1IDcl9yvZxzhw2?=
 =?us-ascii?Q?VMUe5g4FTj2Y/4Wn5DI5TILcpFW12Rj6C4yAAI471G5kGoa4D92XlrMcDxQg?=
 =?us-ascii?Q?WzsQCjfQD6MJWrJKvfvp/Qi4vBtxn9VSov01wdsTq8bNah5i0UWkhK92K245?=
 =?us-ascii?Q?Sl/TpA2Hsg9dTZI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AcjjIrfJLxKuHqMftDFxCDgQuE6uygqFZUlkaWr6/l41dcW9Yq4Yc3u0CR+z?=
 =?us-ascii?Q?0fWXwAZbkgJw1a+vyKkXk7mDxZkQ+No8oRWXqscpwER25h0dghzxjJzo2TkB?=
 =?us-ascii?Q?PtmRvEFSSMqzYj30sErUXx2UhvytrJZvpmSOHfKnbAhkeQWLPd191FgNI3XF?=
 =?us-ascii?Q?Gyy3bn54qRhfd9Ng82vqjyB9dQUSS0Yy1ItGEunMXQN6Pze9LQAtBJFvcpU0?=
 =?us-ascii?Q?8fR/a2EcDaGGU46lMuqXFK2DKJGv4nkWpvWdhXXhZEBDer2x4ACziSoH/27X?=
 =?us-ascii?Q?LGFnd6gfevBs05nP7eLPXnOsmAyIZ7GSYRSiW6EMeH21vpufGZci/mgVJz6n?=
 =?us-ascii?Q?5c2ZXq6ovxTb1ChumVbplbWUBy4S1vBoGyUwMaFtc+Lpe3PklCEF6e/LE1Pv?=
 =?us-ascii?Q?+8QhckYyt1+nB6n0z+vLkZx+T5b/0fMi2phmfbrvx3pmmge+94Trrd+uHrZC?=
 =?us-ascii?Q?v8Rl3sFjzcWO9Pf0GR1FVbAXi33sDmU1e9vZKbTYKL+jHDhtJjJYRGgqq6i/?=
 =?us-ascii?Q?f2wB356jwskt8A2JY0gDj63Y8/6aw3wIOFmdoqfE8OY5GZ0nRgWWaPAMLKGq?=
 =?us-ascii?Q?4CDRWImguQmmapeDTtERlce0MNYf4CBCMvhbJSj+Hfubeumre78to7JE937x?=
 =?us-ascii?Q?Y1eFc24sC73WaVUQFOK1qb0VzHEobKddvRQmARYEeuU9/XWUbauTvmVEdqGG?=
 =?us-ascii?Q?NcKjKUeEzqxSsJwgSuRrvqsCqpZNdzsyeUHImbqsefXQbLygUek6w8TWsj7/?=
 =?us-ascii?Q?w1bVZRzLw7YBoN/joMkbab/KnpppzwD/DttrzSnWDnNTj0eX7fkvF/jHGhnI?=
 =?us-ascii?Q?Z/97aoTdjLAPH6QcH4Ee9RPecUVmt81USiDrO7hP56WfcbSfrmLln7DPLNde?=
 =?us-ascii?Q?cj86S6335JHZ2NkS4M3Ji1h/IiNCFFrtIsSbiRjxtWOLt2CQna9zxNvoYsW/?=
 =?us-ascii?Q?1mrPZZS1YrwKoOEIEPsl2LhuYniRFXp83iW/RfPKoXfdMMKr37Ikc6WFqJhz?=
 =?us-ascii?Q?RuEZyoQG0iy6s9ukUnfVbm6QaZWEnncdKRTU+fZjt2NvTbEEERyxqvIfhLHB?=
 =?us-ascii?Q?gfJZWjPP949rQRFTwOpIN5B08BbMc/C4lvIRGfIfE/Iu6y1+7fakbqIoFTWq?=
 =?us-ascii?Q?0dUeFDfjNMf+hii4gF40Y0D+4u8ru588cSGdEmSfwnW9Bb/BORf58BKtjpgd?=
 =?us-ascii?Q?M259CLAX8cltPgKVUhyVuVuQKGUO0SF8vbkYZVYMsiLp9pBnZ11MCCkt5YYk?=
 =?us-ascii?Q?/MnSkZij+W+6CNm8qZpzvKVeP+GtKBPqOu2UB24qDVrCxf7MPjuA2yNTePlS?=
 =?us-ascii?Q?9XpDPLP/zLQ31VCINSij3pciRv2lYciu4Tw6V/78F/SLN5ZwzRCYhZM4MOVe?=
 =?us-ascii?Q?yO2vEbhDJRW2t+QXuhsnfLpost/b/QvUIowNPy7Cjpdb7uSMfLbwoT8v4rXl?=
 =?us-ascii?Q?aAzrF4RY4TUx2PcaD9qvW1U3R7tWoT8euHHRrC6kjjw0mMyBVdNDuxaHq8JS?=
 =?us-ascii?Q?r9Fq/g9x98rahXpPcjIzw6jURH0TpRuAUiAE+HMulYGAhkqxsR1Irmh6HjTu?=
 =?us-ascii?Q?GB765kK5QEv/CP5kicFCkFlniEfYWFf6hc5b0No0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07786bc1-c543-4f2c-8162-08ddc029598f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 03:16:38.4743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7HK4UVWdsdfBgs1eguBn1CrTfkxP1HHGhQBoyi1W+n5HWhbAZvmFaOQOKAjswe1ZzBxGYDDVo9gY1Q363rQXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, July 11, 2025 1:15 AM
>=20
> On Thu, Jul 10, 2025 at 07:40:58AM +0000, Tian, Kevin wrote:
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Wednesday, July 9, 2025 12:03 PM
> > >
> > > Add a pre_destroy() op which gives objects a chance to clear their
> > > short term users references before destruction. This op is intended f=
or
> > > external driver created objects (e.g. idev) which does deterministic
> > > destruction.
> > >
> > > In order to manage the lifecycle of interrelated objects as well as t=
he
> > > deterministic destruction (e.g. vdev can't outlive idev, and idev
> > > destruction can't fail), short term users references are allowed to
> > > live out of an ioctl execution. An immediate use case is, vdev holds
> > > idev's short term user reference until vdev destruction completes, id=
ev
> > > leverages existing wait_shortterm mechanism to ensure it is destroyed
> > > after vdev.
> > >
> > > This extended usage makes the referenced object unable to just wait f=
or
> > > its reference gone. It needs to actively trigger the reference remova=
l,
> > > as well as prevent new references before wait. Should implement these
> > > work in pre_destroy().
> > >
> > > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> >
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> >
> > btw is it clearer to rename 'shortterm_users' as 'wait_cnt', as the
> > meaning now is beyond shortterm and is really about the need of
> > waiting?
>=20
> Probably so, as a followup change would be fine if we don't need a v5
>=20
> /*
>  * Destroy will sleep and wait for wait_cnt to go to zero. This
>  * allows concurrent users of the ID to reliably avoid causing a
>  * spurious destroy failure. Incrementing this count should either be
>  * short lived or be revoked and blocked during pre_destroy
>  */
> refcount_t wait_cnt;
>=20
> ?

Looks good
