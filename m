Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117E1F8BDC
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075743; cv=fail; b=eYHfeKTqH7iHHeROaYxvOQDx9pbbcXMP6+0lzVaHshq9EE/KlGgFc/KXAqoQO7kT9BGbbBfcjEMn40l1tdAx4UnVYpIM2eSCsfzuaWna9RzoVb0QcsoBKpEatxHoWwJ49g7ToEDz1gFwgEqO6xw0JoBXVvqmLAVqy0Mf1SDXgQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075743; c=relaxed/simple;
	bh=GnBml+vnqp4bbfdO0/24ZWs3uqEaCAK/s2hKcEmpRDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+SSjVbklcYIRoEnbgj2W7PRyjAxRDo/41sFoYwSVQKDdfwFQArrX4rww+D2A4nGyrukjvQWUv26OoGxikg/ZxUukc4ssgjW9yi9ql22JuJWNgBCWaTOzyLggZ52uwoHzXzCsCHFA2ixY6O1eNCrZvcoovokqF93cCQsuA2Erg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V386Lkco; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V386Lkco"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741075742; x=1772611742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GnBml+vnqp4bbfdO0/24ZWs3uqEaCAK/s2hKcEmpRDM=;
  b=V386LkcofYiENSLmkgUVrJ+yn6obiex/UwvNksZY9SVVC9uq0sv8Qjzd
   E9Qsg8Mt4lItXBQzGIci4IKtCQhhMlxkBFARaG1P8LxUbh88Snt3jir33
   EyYdTh0KQ3rokGoWoJ9u6pxWawOu6xOCtAPyLM/VKQ/KCBjy72/zwbJy/
   RnXSkVtN4XHe6jsMefiGC+X+Ry47vTZtmsLtQru0/jIyppIkWJp3wHNED
   V/wTfpO5A/S/Jr57nS04W0EkEOwGx+x1mWOL8X1DJZhPofEKLsXvj6W6w
   8GjhlucX6M4q1ld/DhXwJm7d5M8HNOmSwugHHUSKUxgmwH/XxhfMtZcMC
   w==;
X-CSE-ConnectionGUID: IsNNOClvTueGjxwjFoqWxw==
X-CSE-MsgGUID: 4YqVo9xHRk+nKakeemNxIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52618955"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52618955"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:09:01 -0800
X-CSE-ConnectionGUID: QjjatHehTQGBiupgkPwBEQ==
X-CSE-MsgGUID: vIKVWrb/SpiNOyQyOoNZsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118314287"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:09:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 00:09:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 00:09:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:09:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeM0SZR78Bb1N0K85RUvrOVi4fN/IHCSqJt6mHxyz1oNUu+biprZ86HgIXEL/0sbca5wBfu/c7SaRT1tsnTjP7AXLWrQiYlIdP+GBhszXTFeTNcS7GArkH1E7yahJsjIGupnoYCT27I3OmAHz7L4WuVgyLTIWeg1rVSUqoh7fKhTUBNsIng4OpdvTu8RdLVukM0acViehc4E66cpzWur0DbB6e6mF7Mz1FGk0rd1fxxa4DCe1Fhi5KtozbJDOCIWZANBDWdvU2WA+w218/zMZCoObOC1J8rbj9m+H67x99gHMiRpPqF2a5qvTquLDl8HkiwHIJW7AMnwT+U9rFyHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnBml+vnqp4bbfdO0/24ZWs3uqEaCAK/s2hKcEmpRDM=;
 b=rKgjpbQ/XsaovDx4IjbysDW483uzjtgu08Nu0APDiktr34zttwwiG3bu+FIDbbPdGrr/hE7xrRvt2hoZ0n2kwpY3kLr0s3XloTZDfzVEPRbyir2ffsBxina8KN7o+0VqbZoaa1BpbVbKY0MMQ1NDrxFu5qvbtJOJu5K/0B4B0NyC26Uyqa7RJxiwhf29/Q8xFrYP/BEYegky27V7YGTbwVXosfx5PGpvn3KPgCXROhrlNx19WHqfTyTjWLHfqpFqcvucXc23JPdZ218DyDM4TUjM3wFDrOxtAtV5Vx8XostTq91rKz8vzmO8Hybchn9FbbO+M4MEHZCTYcWknjwp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7952.namprd11.prod.outlook.com (2603:10b6:8:eb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.29; Tue, 4 Mar 2025 08:08:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 08:08:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 10/12] iommufd/selftest: Add set_dev_pasid in mock
 iommu
Thread-Topic: [PATCH v8 10/12] iommufd/selftest: Add set_dev_pasid in mock
 iommu
Thread-Index: AQHbiENFSd3O9ZJ67kaTVMxHIf19vrNiqLyg
Date: Tue, 4 Mar 2025 08:08:57 +0000
Message-ID: <BN9PR11MB52766125CEC44772464ADE258CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-11-yi.l.liu@intel.com>
In-Reply-To: <20250226114032.4591-11-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7952:EE_
x-ms-office365-filtering-correlation-id: 762a6f47-35b7-4ebd-1706-08dd5af3d08b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?s41QrKeJK8gG58CsARl/XyyPAERYJQKYq4rkB/QiFl/jzCNxM8K/RZ/e4548?=
 =?us-ascii?Q?L3aQioQ0bHYRgjcLPOEHa1wCviJUgGVjmqHWY6ecHGg0iCEZwft0U7SaAJ9a?=
 =?us-ascii?Q?0C/e2JF36vYIL5BCGbjJxhTfD8hoZPotFo8UkfFkFtyi7yHTBejQ/sOoVtXO?=
 =?us-ascii?Q?Pi+REUwqu9QCsRod75/yh4w8iZvpjTFdtGZVougQh4VTJCq+Hvg9GkZBdJ3q?=
 =?us-ascii?Q?m58OeaHr+FWaNO2h3rln/0a5eC9iEqNG6lgcwU5t29jVKKS3vWA0eUr+feDf?=
 =?us-ascii?Q?j2JI5qkyGxJWOeHdZg/RDPtlyblxakcwiff1hQ0hmMCvOuuF4tv52txZfd4j?=
 =?us-ascii?Q?qon+JQTLlqVpqXgVboyZaX9VDoEtVqGU0T/p+IoXXKJKN7Wx0AtUKgIDHa5i?=
 =?us-ascii?Q?5Jp87QUIyQxwVOaXfzWefsICej7pDsnTN6Af67iQOanvN0SrPSyOGZz8Euez?=
 =?us-ascii?Q?pEpvnCrS/a/IJcHinql7yB+EVGsQQuEK+C/yADzsaLgorQ6sdO45coMmQE0o?=
 =?us-ascii?Q?P/NuyLWFFuczJM1VoTGiWiBkZ8c+ggLEYpW8pTEL1NWr44WJ3ETzd6ae/fUz?=
 =?us-ascii?Q?tSkBSbR4YRmSScYmHodUgySsILOmXpX2oDclROocYN4J1ymZ+TruyH58js9Q?=
 =?us-ascii?Q?a6YRxYgkvs6Bgr7ix9chKhl9rMG+so14e+yHbl/Pnl8gon6VaskJAfR42DLi?=
 =?us-ascii?Q?zgy0Z223FDRsrlLKRXY/IP3LBF9TOcgf0qShOCCOiQuInBahADZK0IqQOL7J?=
 =?us-ascii?Q?9958opsKP6ywZ12lF/FG1soVPrcVX0Rn3D94xB+VpR+z8GtzcZa/ODiGFxQH?=
 =?us-ascii?Q?r/kWscMPfk5aEekCmKbP9RGKUVeh1imR9hrSSOsy1b2t6Sr9del1zmPw55lb?=
 =?us-ascii?Q?JpQUZ1dt5zy5hNH4CK8vn8himFgX956dLS51bdamUzKbuPpxuT/llCClf8PK?=
 =?us-ascii?Q?Lyb6Zl2ViGWaPcbWuSdJpsufOvPWC564MTyC/Z9Uof+h71OYtvoyTtEXY7Qy?=
 =?us-ascii?Q?q+6tebOnxB/uy3PW/woIJ17A4HwJASXCty08Xx1WX4p/4l/yfQpvE5tdVIu4?=
 =?us-ascii?Q?1kCt8lx4LiiGi/UV0dQHjqB7/EVagxIiCUeaqei96Se5EQHZ65sKxQv3GHCW?=
 =?us-ascii?Q?fZK1wqUucbU0ctCqGbdeRFI+iCLnSLUAAYTiMsAfHpEwXoiWZig3PdT3A7Pd?=
 =?us-ascii?Q?/8nnJLfh/284cWxckg+Ly0ZS7XbjIEw/igv1RuLzu8QeUsRjSnkXM4COPwDZ?=
 =?us-ascii?Q?AO2TE0TMGhk2hOaxBhWKztD048a+ujtZBhpPEPwDNjO7BbD29L8DgrtjH67Y?=
 =?us-ascii?Q?5sQwx1p/bRLAv+YtIiqlz2M+6NsOHrvDBBOXjsntR0CwgfCoOfO5zmCttZP7?=
 =?us-ascii?Q?8oJcA+SgRyESua1z/fvwhfb5qqeWZ3SYc5bm0Fz5ny+9ntovXhryFftV2EXi?=
 =?us-ascii?Q?N+sOqP6HqXb2r52fH6zJQhz5oml7QZ96?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nl/jchA+DLAYgPMSOuxFtFQCYGhoLPUMU6ydAcPvI42jqIo9s/XHTXuDn7EV?=
 =?us-ascii?Q?5ya55XZky8FgtaOARm0mLpoMdRW9cMiYOkYxHvDBPGKxlVXvqk+AtVMazUtS?=
 =?us-ascii?Q?ZQNImSHMFHQYCCdyiwVk4yDQuVqXDG7kh640iv8fHo2Dpivu+sTpW5dJTzq9?=
 =?us-ascii?Q?WuXjxkenYZfIxp7aQdgyCK2fA2iYUilQi/gRbaw4r//qgkqMQIIv/f8is4jt?=
 =?us-ascii?Q?99yc289/N791RntSJrqiwWtGaTbkw98yXuJLbe+4zqklcp8Hb6KPvnv7O8mk?=
 =?us-ascii?Q?8HiY177ntW31UW2HWAB/H67hBPXdbNtzNvFllNufoa83kicp4dlDeXU6M0Md?=
 =?us-ascii?Q?upaULzWAKj+3zByUu10gulYg3rMu1NfweWvW65wDxwp4vqPvMqJlGLrIo5FM?=
 =?us-ascii?Q?5aUpG/GuSX9kDI1uWOmXC4sO5SL6SfLeqxIo32JYmmAmGBzkLHzLy3HM7pAb?=
 =?us-ascii?Q?i7EviNXnb2NpqxenBpZERfUymVUlWVXi72xOc3JI5fxwbOlRMKtQe1HYDWeO?=
 =?us-ascii?Q?nVRr0tIs1tglViA1Odufias2xB4mei/WZC4BNUowisahweePdNahFsS2JJw0?=
 =?us-ascii?Q?m1aCxntCnQQweXl+B3yv2x45G3zBm2YhWOa2S+PGV5b7Eeznm35Q3p8RjAst?=
 =?us-ascii?Q?wqD5sVWZpivOF9cF5o7c6Zp3O9I8tvU6s9KuGZL3iPTu26UTlCDTXpPCStKc?=
 =?us-ascii?Q?c8joP33ySxupscA2m/SwB1aQdyQtjE1OdZdZ7toPySJDP0/QxaK701RSfMvC?=
 =?us-ascii?Q?5NyJEoQEQPuZOsNCtYnU4783OWUEaRG5vnSHka0JRtnwDVpWlK/v1jbJ9k9g?=
 =?us-ascii?Q?Z1BS/ehPUEmMW50feDsry/48PDXuDJN4UbjcLu/eicLTTq3aGLfBB+yfVET1?=
 =?us-ascii?Q?N5iPHqO/1tmLL0RmAptW+JE/ltwYhEYgd/+qJcWCsdxq3LTI8FD0WgytJcoD?=
 =?us-ascii?Q?2GAF9h34q1iQaLjqr1a70SQ2WgOcHmxmUzrsA+9n5bTP3VxcI/SRo0hB3KGO?=
 =?us-ascii?Q?z5ls2Kdz45V/SnERp99e0+IAilby4vvmXQ+zZH+gnAanOfAmCR1GF/aWYkXy?=
 =?us-ascii?Q?gbx0hjnY7GZDqnkLK+2gScEZF+tq1qcCdqDJy5qD+DC81LpF7AAxhi188jH0?=
 =?us-ascii?Q?PKuosT1kCjYtHbti16wDynPuO6Qaev4isJD9QPTUCZmNHAutlq055Clnu7mx?=
 =?us-ascii?Q?fpi4shXtzTY96DX0Spgr0gUX/1yzIRIO5XnPbGtUi4JIQL3By8x1Cp119Yvl?=
 =?us-ascii?Q?iaw25cLdja+bbFt+CEJJND1T0RpY1x+BtOTKSento4y+PKYCvbLaQ355nZP+?=
 =?us-ascii?Q?LEptKQKgGDtxOb2EC5MtsPFIO4CGpZFFBaws+sktnS0pgpHDTfimfC8HkAvV?=
 =?us-ascii?Q?LaKocsXRNhnoKwcAmBxqtaVqdYAtFUKasGcxATzNpHk358BIGgFTXB2qD7IE?=
 =?us-ascii?Q?UANgRCyPosKRxlLVSFshshgh1hMDowH/TTjNB+d4PtMDvZgt46cL2aqWGBn5?=
 =?us-ascii?Q?9Xqb/xQahkg5uduh+1M8eE+KAq922EsKCwRiIG08ymglr9T1JHXIARk4v9QS?=
 =?us-ascii?Q?YKs7vHEASDSZmCPdZOUv2tj5YJIOKK9CEUVSgS+f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 762a6f47-35b7-4ebd-1706-08dd5af3d08b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 08:08:57.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zad/dU0RsspFUENZyviON4975JfMzEf45/0puoEtq3zPM3ktTRhEKyTr4sMVJC7b7Zrpgczf06O5cSic4fKQ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7952
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, February 26, 2025 7:41 PM
>=20
> The callback is needed to make pasid_attach/detach path complete for mock
> device. A nop is enough for set_dev_pasid.
>=20
> A MOCK_FLAGS_DEVICE_PASID is added to indicate a pasid-capable mock
> device
> for the pasid test cases. Other test cases will still create a non-pasid
> mock device. While the mock iommu always pretends to be pasid-capable.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
