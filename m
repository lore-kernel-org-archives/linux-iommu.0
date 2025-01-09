Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F537160
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406511; cv=fail; b=gScaIXflLI5yWM8WgLMGEqJEpjRK6RPMjnkDnIfBDmQVCSdBk/2P/cY6RiNRvVAY249UPZo6EzdGUnZkluE9IvzLz77VDsA86xCpYDNhXksr+0eMeUaeJJktDfum7QIBV4IXUSbqqP3pRydX2NLYO7mw1GvipteJ2X5nJx876+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406511; c=relaxed/simple;
	bh=nSv3Tm8eISHzolzgfF/L3n4Y48Nq5d0KtHzBoxxoiIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmRiOEeEg6i6wwku1ZhGlm39uqn2hC4k/IyrcV9//CRG9BCqA9BXXDGp7yYqN5TpYdJuJ9EXArACsdYHcyeH0onLxG6CTNwUV7zHnOpImVJjiTGK5ZxquLk/nxZDdiqbj65Lie4rTa3NEhX6wTlaQey0qvvII5QfvfIHX1qC8SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBczdNTw; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBczdNTw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736406510; x=1767942510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nSv3Tm8eISHzolzgfF/L3n4Y48Nq5d0KtHzBoxxoiIs=;
  b=nBczdNTwNFxNMQ7X650wxQXLPszZ+TZtf/XQP/I1QVV/Z75a9+13SF5N
   CLd+0yv/ryBRBvTiIetiQ1jpcCXk8r8fe8wz87AZaOO03orclgRgvjyqG
   HYBz72gc8n6F7/tEaJ7ZTQDIbPh2rfKwKcxnKH20T+XEhIEeLqWDxPeYg
   E/H1oSXWckL3c8UZborJYmOkhq8dy+8veaNXjfiNFd0GDeRrCTxbl4Bs/
   A1pXvV+OdPj1eY0yVgRqRfgd5OgcaIuaCI4mfIgON/+Uon63RkXM65BbP
   QXKYiJODEz/jFEpbSXbivKggNBRsUgylOCPmrHHmxKUWOWi+MnxUKfktD
   w==;
X-CSE-ConnectionGUID: AthhfdVcQCCykxMYcG6Wtw==
X-CSE-MsgGUID: HbjZYIz1REqfhdfGdUfG3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="54198525"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="54198525"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 23:08:22 -0800
X-CSE-ConnectionGUID: ZrhW99k3Q92sfWZFcQwXfg==
X-CSE-MsgGUID: rngcTf8fTmKXS3pwfm3taw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104195271"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 23:08:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 23:08:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 23:08:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 23:08:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBexyXaw8bVz2h9P7UbZjOYJPijTbbsU5MibjQGUJ0zsM+Dra6PFY3+5poh8gppzmbJWB3J1Zo5rzU2u/6bF0Wgnc3uKLTYO1lVhxOlzCWaLaKU4R783QI6myOZeGByHcgyCNVj6rnIOYG3p05pK5kUILzKWDDNBFVQEux+SS3+FW7o5qkTtnR9opGV+7ni8EUy9gL1GPn2CwjkJkw0WHWOirOUd5lgxQ7NG/rvZj7/2cHdnwg0/YL1tO9sLsMt7+w9mXuURZy5RDWK2r8QpIJqEnF8D1EO9e0P8UkiMannyPYL5vn5pmgFm7Ark/+BvzhgfPOIsGHQvfFE5jHJizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk233NBvUvuIauT0u14Xhm2xNq/7mqA6vp+niE1fjr4=;
 b=r7hz31J/X1i1YVeepixvSZvBELysbqw8w+NYJpNEHnbmE1wF2v0YrtRfayl76j3hQBd3FTZdGbVgru22vNzGAI7l2Yq7FHGp1P/J63u2wrr91xNUzvldCBR04tHV/P6mbau39hheIQEnZb7oT8gyO3v/OpRQfFsq8AoZlmmcrtvC6CT1dpIr03qbU3swhCusrUN3N93drH0Rby11JTB2fqGmVcjfRtVBK7fVuwO8jRjxOu3g5/dHUlP8qqRnsajNXgFxnBchY0VJXi9NZUMlIkTjZ34xAAcDWtavlGa52KUvVg0w/M/xRDIlZNXUOQQIDge34FKpFh6lPzziJcg8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Thu, 9 Jan
 2025 07:08:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 07:08:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Index: AQHbUhnUNnXzHh2m/02CvPrIPwhbUrMOJdsg
Date: Thu, 9 Jan 2025 07:08:19 +0000
Message-ID: <BN9PR11MB52760CC5ADF28638E4227B8A8C132@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
In-Reply-To: <20241219132746.16193-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5872:EE_
x-ms-office365-filtering-correlation-id: 3bb027ad-596a-480e-a0dc-08dd307c6570
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2CIxl2jdl5Z/DqA2ddTQ1Np84NCmb+7VBTdbGRr7VFPRbS1aQdxy5UkrJxbP?=
 =?us-ascii?Q?3XDkjX5mhu+UQySPGEyqdvWzR14BdGl5FYFUFv6Y1EDk+RK81D/v2bF/VgGd?=
 =?us-ascii?Q?QMTIdPsh9dhSORFGavlIG2vHS5oDUpxZGrL6Rb0k/TSnwllIMrMurtZtDcJf?=
 =?us-ascii?Q?TcWm1/vkLFM6VjJHqoJwDK6CI+nt9wHJEgEIzc3mAxKgHJelU1NLQN+pNTCZ?=
 =?us-ascii?Q?4ajNmZtcon+jtCIq4jOq343hZVxfsQW86scqUSuSXC6SqvSa7UAoVT3TuVR4?=
 =?us-ascii?Q?yro7Xljm4tKOCg98TbjHziyf9Bhv0GyB3F8MLCijoYjqvLTFoh4JpZ0xvgKY?=
 =?us-ascii?Q?gpGti4Tc0VyJGM30mMFJFVXkCyq5Gr3FMq9vQaeS+l6FmWbcEUDemOyijTYG?=
 =?us-ascii?Q?jBYvJUCMf8qoHs5GUSE7WdNoFlXRA1bRrhmXJpSnzLNNAn4XkydaJRjWwS2B?=
 =?us-ascii?Q?Ut4gFVrKb5jZF0Cd6xYdJqsE67cwCEMR5qVQaOkfGHS39IAXLV+/OpHV/gwo?=
 =?us-ascii?Q?rmmI/yLiiyo50S2eZRxvcEHhhSCjIZ72zcudDLmXwoio50LJz7B4o+964g/L?=
 =?us-ascii?Q?4Yldo1E8Ql20jBs5NrTLeNT83cX3QkwnwwR87xtjV/t9pwGTRvJcF+uW8cTY?=
 =?us-ascii?Q?akBFFeBkjnCyPRjEubsHUGRuBhmCU4TOYUTEwPY5EXWt/ZmgyfPbdMTKBr1H?=
 =?us-ascii?Q?6t7fChL2NUJC9OoWMfGzHeJi3EJxWKiX9+mx4KIChldkM82ND/6VeZOt3sPh?=
 =?us-ascii?Q?47boiSgi//vgMpEns9hyUbcPBf7ePrUSuGbngwHDSkG1P2jXUlp61LXwjra6?=
 =?us-ascii?Q?OKIXOQ6U5aHHQh9cW2iZ65R4LDu/uRBNnFN8jjM3vYIY7wm8EyZLi1VRChj3?=
 =?us-ascii?Q?Eq/1ccKFoaNOeN7dNm0M4s86OmnAqaO/4OkOVlb+fXS5T+eTEoKqh3BOUIzZ?=
 =?us-ascii?Q?Ol8e3cCrH0w91/lVkmRw4v9FVtS67HXIVCujHHBWM7cYCBehHeVa0NkQ9B1y?=
 =?us-ascii?Q?4s5kuU1yWN8KcjpfyXFFaUebroMZCQyvjTUFrHSdPdzSEHSFV6mvOx0UFi2o?=
 =?us-ascii?Q?rZfd7F3Tv5QNFYkUyddDeXF44OZVh5te3+rOvjjHOG1QjtBHQx6OWaxZF1Ij?=
 =?us-ascii?Q?Z+p86dOKnWifhwDXx/y0ZXxKD89sXI9AeimMiA16HR0y2MQmwQLO/pZ7PMOe?=
 =?us-ascii?Q?oMuw3t7AfllhTtNADTUlR8H1dE7nZwfEpJJn5HdiF/Vnrf+URTRaTg96znyW?=
 =?us-ascii?Q?zFOUco9yT3lDfWeB0v+O/VPKe30NiphYVAQh4weKch/4aluPNOjG1fbTxssC?=
 =?us-ascii?Q?xlHrbga9HKurEwsWoG1Z92C7TWiTDvkQe0eFBv671OfExscbnjhllCBYctej?=
 =?us-ascii?Q?47btecWCKn3GbI8tjOwC0mdRAoyQpvZS14w624j8YRWjDBK89pJg6v9+asqW?=
 =?us-ascii?Q?EHVM9MBXilAYJhFHxiJtl/G14jz8XXwy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fB/RsyFX7LPPtnhqqtnGzJpYbcgf5hvZUkOR7G2+krJ/lZUCC3kzEifeNGQL?=
 =?us-ascii?Q?99qnExWRZz3q7XxwcROSHy8Y4NDD6Fa5RnX8a1YkPvh7KSbIeFbhFt6D+RBI?=
 =?us-ascii?Q?lCx/Qudq33b3VWboFISHuEyykTMdHqi9DpE8+MJpkbv1BNJG6Y1LqIZVOSet?=
 =?us-ascii?Q?V+ZlgInqBBxDBaayWCQQsfjI43+Y4A2s/NZlaJbFIUdyi5eu7V4cOvp09tdZ?=
 =?us-ascii?Q?3woEQGDiezTGjFIOW+NWYA/NotRXkyRm1d7Jd7iRBCH+bWVVM7nYvLmechkW?=
 =?us-ascii?Q?NW+SSYrVMMBvFu/Oyd36epSCmAGPBW/b2A1ZG4bchdbRNbuJQTC76Z6cJQCq?=
 =?us-ascii?Q?mIzJm5oiHDuZi/cGBwBpPkSDhKXMD3heONI5+WxopMXtNdNM6t7JcieVFMco?=
 =?us-ascii?Q?3TXrqQoPc86a5aFgO1Qydyg13J1HBnQscGvz9FKWrvIgwVxUmucPB/hIg67A?=
 =?us-ascii?Q?yeydVShPb2+meCSA5hoc6ZVO9ijsp+YOT9+wyvhqqr7Sl/1t39UgyDlTWZcl?=
 =?us-ascii?Q?2oPoUohTJBJZAkDGtabrPbf6cENHJZyKurLHgtNyuVThaM+46FMIso10bdII?=
 =?us-ascii?Q?+DDb/e7zFf7PHYjL/7mntnzJMNMGu87iy340PBA64JirHug+zM/jbMsVTmld?=
 =?us-ascii?Q?h7JgempAEU1sd1QTGqqSSDA8HAhz9OLaT/k2kse9EVxTa0MDDUPLXTU6kh6F?=
 =?us-ascii?Q?lSF6M83lOeWDKkzH24xCpDitLNILSN+CxbOuXXOT7K+Qm7st8+JVVb6qYoSl?=
 =?us-ascii?Q?sJ2C6SYfsQKyx0HL2KdyPzAeLHZazH5jy5kqJ0FPPF42pB8wrZ9OsS+Xa6yJ?=
 =?us-ascii?Q?RPfMOILJ+pMheP8SN6D6OFWheaAUY8AR1aN81xYodJGzQN1U0e6gkuLvY4M2?=
 =?us-ascii?Q?/B96u31H4grzf/IOtlbi+wje5xGBPs6ZFQbKA4GZbznuRrIHpWvG+QZtZ4y0?=
 =?us-ascii?Q?CcHE85/O3LH69alF70S8U8tATUgEq9CenQHs8YnCVxJFtNfvEdE4W3/yqUlE?=
 =?us-ascii?Q?GKLTR+jgRShgNdMfhelFB0g4Fun+680xZd7AG4j44+IwpdSkIRs4kiDnuhkf?=
 =?us-ascii?Q?Jjs5D0O+jmlbDtF8qrHYYG8oYieBQKY1TtEyozTg3qc095ENIxVFqC71Y84+?=
 =?us-ascii?Q?jkcQOjPq5Pm7fzVfyJ/vKdCGE6JbRxpnNdUi+HknR2iE85t3jodMlchbsmTU?=
 =?us-ascii?Q?Rt9cdK0XlHH/9RwvRmXrBKiC9Wapm8OVuI5mB2WR4k17XaoIlixSa4hydXHc?=
 =?us-ascii?Q?L0x7BVCe0nNnPxi6VHEF6/T2HIdmSyhw/XEfcIzKxOjNWM4cNK1YFB9pauSp?=
 =?us-ascii?Q?krq5XQ469Tef5iKMvrGEZcZVgsfHXVDgWOalMWv2hG3BQZP9xYGbq1o0/dKR?=
 =?us-ascii?Q?5YpSVd+Ib/2nzp1PeedEIxaK5RLN3bvXYMWQSc3ejZUgSrLRcxyF+jiJqiwH?=
 =?us-ascii?Q?dlFJXwEHXGwROk4fzhEZzjGcuIWkIyvlE7n+Xros9htParcatnCNbLR3dyao?=
 =?us-ascii?Q?GXY9MHA6aKgQELH3z31Ppaekhkila4GPK15V8qYWJftZXTg3w9Fl7lPzePmn?=
 =?us-ascii?Q?lYcKxnRN1uXWbIdTR6yTuOpWi2/JXKrgGSqNWfU2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb027ad-596a-480e-a0dc-08dd307c6570
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 07:08:19.2357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oVduUJJADJYPJ4QPIwYfr2W3DYQIgBUeeg4LBbL8NZRn06V4OXJIJ+s4b04BY2ayaKy+MOH4utWx0Lc9y2D3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 19, 2024 9:28 PM
>=20
> +/**
> + * iommu_replace_device_pasid - Replace the domain that a pasid is
> attached to
> + * @domain: the new iommu domain
> + * @dev: the attached device.
> + * @pasid: the pasid of the device.
> + * @handle: the attach handle.
> + *
> + * This API allows the pasid to switch domains. Return 0 on success, or =
an
> + * error. The pasid will keep the old configuration if replacement faile=
d.
> + * This is supposed to be used by iommufd, and iommufd can guarantee
> that
> + * both iommu_attach_device_pasid() and iommu_replace_device_pasid()
> would
> + * pass in a valid @handle.
> + */

Better explain why a valid handle is required here.

Also iommu_attach_device_pasid() allows NULL handle:

	if (handle)
		handle->domain =3D domain;
