Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E9335BA
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075780; cv=fail; b=EnGpjr7pF0a8rt+qFwk/a62uGPXqeY1C66uuQIWbv78Eu1NMESlPqS2UaLLLJjvUTpcAvi1VV8kulOMapimJ96Z/cEHBTnS9YYNE7zwsgImt+H/7nWIQs7NnhgVeoYjYUogMwYaEO0y7kNsWzt6yEZt2w8UgDHS3atlhSmTFP+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075780; c=relaxed/simple;
	bh=jNup1hdmEaZela6TB2VvO7tz8cHJjbrTemZBuqIFzmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Su1EDpWHqeDYUGaip+WAnquF9nxW8WpqQoVqIUz2wBEVvNLUc3wd5iVWHffmMWc9uoB8s2WnMr/DYJOB/TaY4N44CzhRfrrIm8USvuGD89FOmQcncneFX7mR1gFG2f84xOmR+49ziqZy6bO0Mt/2v+tU/tgKLFc7YN9iEMYoL/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BV/arOgk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BV/arOgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741075778; x=1772611778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jNup1hdmEaZela6TB2VvO7tz8cHJjbrTemZBuqIFzmA=;
  b=BV/arOgkR3gyINwt4U00Iv7QXkWS15BgzNznD8NWWlCyil8p1exVeNq0
   z94BWGjawhL6pGaTmC0cYaWqRNX2tv6lx0URIZlG+FEl9imnjCiiyJiQy
   KAvikrkt9XpTClCZr9GllC89qaWpBtf07GXp6Mz8nsbMPq1x9Prymq9eY
   JtTb6teMVBJzIY2+4BSeAwKA9daZ76cYgnnsAc8R77nMLFMJ74RJrrGBw
   pbk97EC1NjXlhQDTwK+dol7gCvoxtnaHm2qXJvcJ1/5wI7+70uqAkGWHW
   4rdsGyh1AYD26/4bIP6UZzBFcyW6VB7ze6p0ZMgATvTihSRhdApIlUODV
   A==;
X-CSE-ConnectionGUID: oD5gtF5wTjW3NhRHFZE5tw==
X-CSE-MsgGUID: 0duoDtrKQjmTG1g5F91b0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41159131"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41159131"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:09:38 -0800
X-CSE-ConnectionGUID: u9L4Y2fEQj6B4csTddo6Bg==
X-CSE-MsgGUID: c+QjYGjvS1yf9SOVV41VBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119216651"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:09:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 00:09:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 00:09:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:09:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQ4lGuO1TcQWjCZcvcyEL01bRVbabVb7Rz93IpkFl+vptmudD2GdtKo0X8glf1Z7e4/ckNnGwCEqnqGEjpSto05KXNSbzjn3iuB+jLvKLSbjvFL/c/zgzfmbL1u+c8Er3FCIVDv1N3Fb3aqmNAETV1KykMYXQhJFpOXABYN8VstP3uUyXdfXFHDaJx8tagXuyFj9QSJw5q+1nSpXtvcy0awhJzGjmsu2W/uwjSGAKMiTCfTaYf1HGn8hFiH8pzPa8rLohIa/AfO0WoEmjrgu77uF0dcJWytSWyGjux3rxRivDzSgWfmdXTmFKTQ7rnzggThgm4TLIoRjrNXgIupd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNup1hdmEaZela6TB2VvO7tz8cHJjbrTemZBuqIFzmA=;
 b=DrOtfTCRCbZeyRGuNfn4kxIWnuwrV6evzL+q6Bj8p11pYQBm2w8K8wZhERn8+neriBdw1z16dbekdodEQVOC4BVS1BTQp62UmSsLsaiyb+N7j2GDVDIVfWzJg02hnf4eVV6TvH3MToVpEV4c+cQgGVYhjptsKKveSWrKYb3mB3LNpu7xpf5s44b/l6f5b18i+BYsRRTL1dYDIM42OaSb2WWe/4u1IFbfPPaTcahXgkUWA0Z5Wqfp3D7S+O422Df6wFV0hn/GAgEJ0TPmW3g9CkPrnLgudTCCOfKBA3FPZ54rS6daccB+Gmdfz4aZ2ZJKxoB0NdsoV6h7OaHE6If0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7952.namprd11.prod.outlook.com (2603:10b6:8:eb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.29; Tue, 4 Mar 2025 08:09:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 08:09:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 11/12] iommufd/selftest: Add test ops to test pasid
 attach/detach
Thread-Topic: [PATCH v8 11/12] iommufd/selftest: Add test ops to test pasid
 attach/detach
Thread-Index: AQHbiENFbOnoYarmXUOaKKIPLysF4LNiqN+w
Date: Tue, 4 Mar 2025 08:09:21 +0000
Message-ID: <BN9PR11MB5276870D88022C8FF01DF84E8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-12-yi.l.liu@intel.com>
In-Reply-To: <20250226114032.4591-12-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7952:EE_
x-ms-office365-filtering-correlation-id: 43117229-805c-40f1-676c-08dd5af3dea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NdxwD2C3pQuTCKbr1xkNBNhm9m/L0m1bB8S24CmdbcAmnnyklBTO26/ciUlT?=
 =?us-ascii?Q?s2hiAsMWWu2g+0aQc4FgYbKaowOr4ZcaRnjBH2VPDk5mlgvjVyU0NElXb0Re?=
 =?us-ascii?Q?9hpC3sr3I/NPjChHi1u8PkxvI31DjCAWgy85BbbxWYYS1wR+09tT4SuGj0L8?=
 =?us-ascii?Q?fZZkRFKnj/a32KIs07wSnYqVHYtbS5cRS5ssCy6/nORyCmC41MPorxAKbzhO?=
 =?us-ascii?Q?KwREMnBuDbAPnLYg/UL0Cl56YL/LGG1R4wigAe47iUpMNQ1Nn6q/1tcthpQS?=
 =?us-ascii?Q?FUy1TYzAJKAV5LWVNzr4aeHFkVXaK/Vcz28UcHNHwGYIn5PeOweE39v7lF2P?=
 =?us-ascii?Q?N5LiDVuW9+2vr2XZ98Bqtph0QN/gIu++08BzJTky6510WerQ3IeYazUeKZaw?=
 =?us-ascii?Q?kejbNS11NV4rRku09Op2FCduHvDTSqvf1x8GM9cTXHDo8mcGiCKweKKM5h1Y?=
 =?us-ascii?Q?bQm6aILYMher3q39O+9BRPc3rEFYWW65ytm6nBsq2+9jm71pIphuOSCjuHV8?=
 =?us-ascii?Q?cEUjYXGRqzrdUCDnBAG+z8xQiTQaQrtnoAmx9fPsgskR7NyWu+5qr0/YP6v9?=
 =?us-ascii?Q?hoUQNLmvIXpTL/+mU7OJJcdNbV6Yq5s74diLf/XnAx8+jUJn33YAelTR4i6Z?=
 =?us-ascii?Q?5mfMHEzcWm0kdLv7cnFccEhaUg47FLyrB+0QH/wExGqxSgjfb8yPg8QqAiUa?=
 =?us-ascii?Q?iZ0c6WKChuKB8kTqLaIr2KNkvTJ+vhKWzWmpLqI8676gRg/ZKeVukDGCDr+Z?=
 =?us-ascii?Q?fh9ieMa4+ZZZpztEpIBrYyy0ODS3feJrfP4xPpTgCtSm44Z0jDFftLU84ZM4?=
 =?us-ascii?Q?2BULKxnUsp5bN5mpWTVyqgFhtrb8wrpS3i9U/xvgUPu5657TklyFmzfirNy8?=
 =?us-ascii?Q?H2L4uEn1YDA4HIO6coVpDLRYLmdNoU21azgOR0uPCYPamM4UEszNel4M2HoM?=
 =?us-ascii?Q?bgdJxEDhyrIU7K8ZgvJP4dy0Eo/7Nqr4YwvDecUZoeNuHy++5RhZfMJBG/RP?=
 =?us-ascii?Q?vI5J+8rErx9C9q97mubffdvHB5tdOUZo2PJtfrdEzwgs5VJ748iHKDMxqV3c?=
 =?us-ascii?Q?au5TjLSpxJqlt+yFXAJNWbdVb1SB2gAaK/NNxAjRHFVtpkL3p5i6j2y4RgN3?=
 =?us-ascii?Q?x+Gx4Om0rEesZwMzXZ/UJ5tRyb4+R4hH/IlS//+6NWsPE+v0+mLc84YFnbzG?=
 =?us-ascii?Q?w4ViFdhZWAcXfIEjvPIaT5VvD6N1vyfd1DbVemV0nQR4MwtnBupSciA+PXNA?=
 =?us-ascii?Q?bafFetz7+GywLK/2gImach/mHGQsH4oBh3Iadnc3tr7F0oVmD/QpeMjMjKGL?=
 =?us-ascii?Q?F6tmxfZv2rjYQTyRxBb2TszmqWG6n6KQ+WdEf/lsmBca5Q/vjltDs8oJn+tA?=
 =?us-ascii?Q?Nwexql4tmkqn+kgEGyyhL7HNaNTDj0JObKiX7PcFfTsAAn9HRuZLHNj0u/D0?=
 =?us-ascii?Q?iQ1O+oi4wJkms4tT8FcaTVXzcdjrcjHV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w3J5J+j45Ey8kXYnZHM5Xuv5QfVMMmqbmB2zJtPORnLqxwP7kIee77+RaZur?=
 =?us-ascii?Q?qoUKBnXmExZGoRt943ZkUmuX8Lb3rPDeLI5i2T8542hClkvOnrSg+ReUehWK?=
 =?us-ascii?Q?yk9x7nye9aI76+/zmSkIKz1QeWBBAGkQN9S9+sY715HceqwrFNo2N+yIucks?=
 =?us-ascii?Q?GYxtbgBBQmaP3U/ypo5Avaz5ufrW0OLkp9+N1pGUkgLsNPDMNT32d8PCjP0V?=
 =?us-ascii?Q?TUfF7D0wjTLRbhdTr0fq8xdNPzuhCY9PBakVBklw4fP7qCZxhSIVYrwV946w?=
 =?us-ascii?Q?Xh2yl40Pdqf/+QL5/A8E6+8eQWE3ocr+M7tzYSL9nrJnj78RZ1eXqfa/AbwV?=
 =?us-ascii?Q?lkLBiQtqB7GDzoTvwzuMohAP3/ccEDqPAz6AAnn0cQxK1zPqBaineTE8g4c3?=
 =?us-ascii?Q?8da2phKgdW/uCFLIR9CSrRJ1RMYko5ENB65BqlVXO1VAeBV3fgsIsNWXcrip?=
 =?us-ascii?Q?hKqrA9XZnO1WBQi+fxQ7XQFlPJhqPK0CguIXsQ6kgzlot0r9CUthWSHj0tJ8?=
 =?us-ascii?Q?4vZ5pTqRYIjMq/ncBEajIZXiqKPHQRD+8GShU1E1YIeq6vcrzsGenvyJaMB/?=
 =?us-ascii?Q?+VLSLKpeL2P3yiL3Vo5imo6SKR0SUy6sSHenT0qwjYyG6eCggqdCDp4Rp+QK?=
 =?us-ascii?Q?Ze8gyxE0bkSr1XJIwcs1+zp8OZBzgZQ/bkwdpUX026yEaTHOIpp4ODluRlI9?=
 =?us-ascii?Q?oKnVzej/Og7sv4cragE4NOsnE2pro4m42a+euGq8elGqTm29Ktov2ashcYZr?=
 =?us-ascii?Q?wS3V4CHj67aWsgjMmAZguWu+p417rOGe7wsYnr3P9GuHLprto+o58KSZ8Jg+?=
 =?us-ascii?Q?RGTv93YiRbMUcSp5lufoHmbJ7F+1rAaGjkMI3T2b1EFZVM0OWcxMqo4xMq7i?=
 =?us-ascii?Q?kiWptMAYYkl7IBnXjpzt/nFYxQG4SjznCzEMPDoJoFL6aYCG8HbCzJ+WXtWT?=
 =?us-ascii?Q?2RinXXdXarPuoSmq7ypizkJD+jtaOYfBSxByuGI7Ko1AMuhfPap4rb4LeqW+?=
 =?us-ascii?Q?0HlgU7uMbek+mgvtbb3obzm8/VTd2UhHhhZ6pS1XkzTvfRSeoQoOqD+RJIHe?=
 =?us-ascii?Q?1pQNJa7zk9MdC4H4tNfLqnWDuXSdI3aLO+idvejEERLucmYwEb85f8twwb8j?=
 =?us-ascii?Q?Lo+GlynvYEzh2Ns4SO4F/njS6s9UuVv2+vusrB60rLE0uCi3TvV+dEmdbQhq?=
 =?us-ascii?Q?ZTjqYdNj/a8CJX2ayi6cZr4KWIqP465JicRHsCWgs+a1N1DOUxpT5w84iycu?=
 =?us-ascii?Q?2gaSjla1w44dphpMtfS6BvnfGPEFzQyu4ruhZCgkvKEdzC4/EaFuyRjc5mdR?=
 =?us-ascii?Q?xbSOo8+COsDQO7x6WvdZoJVnM5EhdUw8E17ONp1cFCzHYGEX8gKR8IgEoIqV?=
 =?us-ascii?Q?YPrrg+vO5/KrVBeYgN96FzhseFLqCkzxlDq/vMGk4xzA3mUVzk44ULqBLPrR?=
 =?us-ascii?Q?GfaPInMLWIQD0elrfZhey/jzNhUvdSndwRuRcaCTP3kBlvjmI3LCw7+fE05t?=
 =?us-ascii?Q?pxWrrV8KLbXRegOX5LhN8vdVr+3tgIE1E/x9AxvSF6/1HifJca6WQ0zOggdF?=
 =?us-ascii?Q?lZ+o8N/5GH4lwsjPTLqRuYIRqBW997PbiUao3X+l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43117229-805c-40f1-676c-08dd5af3dea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 08:09:21.4870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M41Sd350mOXH0X7I+2nnTztsyUJ7qOdBOZ/6i64edPZzOUx9e6HhL91CKKKIQl3y8NvTXrptTD26jfAIgiXYPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7952
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, February 26, 2025 7:41 PM
>=20
> This adds 5 test ops for pasid attach/replace/detach testing. There are
> ops to attach/detach pasid, and also op to check the attached domain of
> a pasid.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
