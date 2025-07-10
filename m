Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB223E25B
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132937; cv=fail; b=MRwH/i7dGTDtfZNgRhcmWmhPHg0rLohcUcL6kqtRcrsslG/ns5mk0G1358mcCLOt6NdxF7YtRnXu82iLhia05bkLOi2UZ9FvksHaw1KQ8qs54n5bS/gDYpQNIT5U2fdVQGfgWPxO8B1/33wncES9Dew3mJ+sI7s6rU8FjptytSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132937; c=relaxed/simple;
	bh=geFIaolEOkm4c00l7FK1I4b2v0tLo+a43zB44HdK3rA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RPz4LfFnv5UPd68PvayevjmX/UvGRM6/VT7pEY3CtOo05BEUH5BV6aLDWsh0yivGYBoymii05kte5FSMvEmjZk0juQjvohmIbWrFY9vH1NCz4NLXSQyE+G7rJQr4H2MAbubxJYOsqxSJ8HUdJnOwf6Kqq5aqoHqfGDu4diBqXnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEiu3WiG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEiu3WiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752132935; x=1783668935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=geFIaolEOkm4c00l7FK1I4b2v0tLo+a43zB44HdK3rA=;
  b=WEiu3WiG8CfFtMcdpvhBWRT1NQswoc7eVOXb8gSc0pI6IaydBKj2zsgt
   p+RRWEYha90ZUhihcO3bhVOGn9MnhaqDP8F45YXpBEdOfbXmk/l+tRnjA
   zbxHeLeLOzv43NxGX2X1kFBZbPEaZXttZs5/TYWZb4Uo83Syc0alXNDuG
   xPv2Y+IGtJixRIoRnk1sywU0pqtCZaMZyztBXRXE0xFDUn6oVy22xk5aa
   3VHVhxwkEjGa31bDetAyPNNLljSEjIX4OljQwP6hytH9SpZ7MgxwdfZZX
   YmD5DPWcq33mlom4ng/PDkDBLCjnn/DtiUiHkFxXmlg1YUfcUGyrJ0FWE
   Q==;
X-CSE-ConnectionGUID: K4rtkczVQliRFz+33LtLxw==
X-CSE-MsgGUID: 0pDvWv33R02d6uSd8r6alA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58174048"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="58174048"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 00:35:35 -0700
X-CSE-ConnectionGUID: DOobDfIhTfe0SlMUtaD2FA==
X-CSE-MsgGUID: slNIAAIpTJiptvQ5in5WMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="155414089"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 00:35:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 00:35:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 00:35:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.43)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 00:35:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a19u8x7njgb2zDn7Fdg46VY57YW98beHezaojs5s9kVpNzB43m53kSYCwlQ1PJTUrWVTcKX5TnkqxCPCZ7gPn9uKQPMmI9XmIGkXPo+vAB+6t47aw7HOAsQGAv7StpbxeIg9OOxMpqS27826QH/BVhqBY6Gm/8oQ7WeHD6sKygPjoBgePJXyBYpw40Rhy0ajqYgxQqKdYG1RJ3SOqlF34r5McfiT6Z67hSxx0wgwboUCxKKRUYSN3moqncNPUPyhHcX5mukyPoZqDeYEfmDMooLTYEYH3UysEGotfvSuZGXG3DgqvMXBWP19IYpb8GWiok4OdZc5W22hjCkROuqFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geFIaolEOkm4c00l7FK1I4b2v0tLo+a43zB44HdK3rA=;
 b=IpdyZW0l9BgrsdNzqwQM81UpIWn6bAb5loItzG0ybXlCFi1mog9SxcYkJbZZQMLi/iqj5fxr1/HFsR2xlyjAT6BUBztLCnwuVvGUOqSKjo4zI0983VijXZ/CotRr0dHUlZRjJ/EfAp/tzdUSuZqk+r5XSsHKkzbueBUtppowg0Gq9o2iEyf7w6qztdUpHoPi+99yJwjHDrqlmFaPAMKGOzkpa551fPHYGFicwjOmG+RMfjWy4EdDkWp7uZq4ytPmZvgPth8SyhgLEAVGfrXzDRqNGeLQrqkL03W7ySl4yVPPCIMElTTOQMVsgBdGMuFctVXNC1f+R+QX+xviY+VbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB9503.namprd11.prod.outlook.com (2603:10b6:8:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 07:35:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 07:35:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v4 2/7] iommufd: Add iommufd_object_tombstone_user()
 helper
Thread-Topic: [PATCH v4 2/7] iommufd: Add iommufd_object_tombstone_user()
 helper
Thread-Index: AQHb8IeGDmA19bWLgEqjXZeyjES4ObQq+UDg
Date: Thu, 10 Jul 2025 07:35:32 +0000
Message-ID: <BN9PR11MB5276F93AEA81EF3955148F538C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-3-yilun.xu@linux.intel.com>
In-Reply-To: <20250709040234.1773573-3-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB9503:EE_
x-ms-office365-filtering-correlation-id: f9dcfc1f-619f-4256-173a-08ddbf845a56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mIt9pqOk2k5hLKsjNVYrIA5P7uTqypWCEoXtZZV5Ye3tQnRbncD14nZdFjlL?=
 =?us-ascii?Q?XwkcO+Bgbtyd6h6NzLUh8dPGUfGoyQUR+4AwsOkkQ5Viv3pktOcCGZ/XBreZ?=
 =?us-ascii?Q?iHXW5cG0zi7ci+w6iMExPp/K8e9Yn7ClKiqkcwb+4tnkdzseQ7h2wG57jBzD?=
 =?us-ascii?Q?33aW6+2YbnVjI/i1ogXUID8iJ+2mAov3vLAhGSQ/R6Cl9j/5gauW1WVYyz6n?=
 =?us-ascii?Q?TFLnFgveoTNOvvPeJD9+/1XduCUJqdsFVxGYD9PXSxnCcfuiwnGr1juRR8Kr?=
 =?us-ascii?Q?NDeFTISmlbrEILPBMhvebrVz7+Mp1jyalkMieHlt05MTKQOCMH/ehLlkgr4N?=
 =?us-ascii?Q?daRs3qsHdf3CNCeaB2e0PWQs4jWfOH6R7HD7NbWs3Jl91Z9go1QfRiLUDCmB?=
 =?us-ascii?Q?I8w4V8Orh+wAhL4EbVPlbpQdEx6uAbul/HAc3nPrIl7SpZ/pYEkl7fNh6Sot?=
 =?us-ascii?Q?MTt04+vlFVE8SzCCQ3u4QPQtCdl0KOJIdrh2rlNja+DqrgIezWTbrxcQ34hI?=
 =?us-ascii?Q?Obs6Zbp5D6K1vbKVDb3I0KcIjZd409xmSN1MheXhQPqzcGIscFyfgL3Sq7W3?=
 =?us-ascii?Q?ofYRYo2xxaAzRJBI1qkLs1Cvq0P7fj33eQqmXgSozMULDFihvNMnzeCQZ8Uh?=
 =?us-ascii?Q?itcjltQH1WoIuFGz0CHmr+5eIwe/Ruffodw0EaB5OCdotXNIsZDVbEEDOSJH?=
 =?us-ascii?Q?vnDQDLFNHJgoRcilprAAJzv/ddXeNxb3VkZGFCyuAv1p+rtiiILcI/FSVYtZ?=
 =?us-ascii?Q?zK+cKBG0iOlcLvL9gzO1Zfj0XShM3GPBT5rzD9PLgR4vB9cM/KsEGF3mjd1j?=
 =?us-ascii?Q?9NXZArNZyeyItFyeDEMVx+Z0+lk6Qad4k33obxvrZqJrS67m2Psdcui1LIsY?=
 =?us-ascii?Q?Vfyquqbnj4PxLd296Vj5BHVeRItvn898D7u2gF98EwDhq0J7nIiRP9xeOLax?=
 =?us-ascii?Q?8kJKP2j5LmBEUR7PqkUhON1N9qC1E+uY0hcql33vk4Jw3Av7N20uhO7BKobO?=
 =?us-ascii?Q?3GBxQeJ1iXDPFUsvolVnuG5OEyQeH0/Va+aJgPQjB893wluMLTX4mt3nq7Id?=
 =?us-ascii?Q?HTfUqboBVYiUkmq1wOuxsLismkPcb9KwXtwM3eJz4D5TZEIEHLx8iz/Dx0Zi?=
 =?us-ascii?Q?7z8hhrMOICIcu8/VTLlwTwoZIfRrhrD16irrcU2z9emclO+6SwYOVdu3Qmys?=
 =?us-ascii?Q?OtOLG8KXscK2SjjJZTXq9hKM5r21lfwogSW8d5TxACiheJV6eMgFwRfhVOjM?=
 =?us-ascii?Q?GjfJDTewWTTHwATzKniQAmlfu7gUoMR7hGFUSfm7Xkfij3rL3no03uX8VE99?=
 =?us-ascii?Q?80hIK+VpmVqHhn8/DPGiubfLNGaKJUA49kr/oIV29wZbaa5L+Bjz2cxZweaR?=
 =?us-ascii?Q?s4c/bhGTzNd3cI0rCPK7SE24KG709Q+rqe8Txq5YjbW2b/Rz3RDmFTdFQOdw?=
 =?us-ascii?Q?zYJHLT3ZKBu5MTcqGMSCemqODyNdRSO3paWXIOzhs1IE2XUEKvz8Hw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NERG4H0hSYr9SenEvcwPyZ/sHCGjBi9W2wIHt3ad4ilu97PSNefV5/fnxoWs?=
 =?us-ascii?Q?+1RMZ0wOepip1WhtgWJXQtU1+wrQ1kAbYE1AHVBjyk+pEtkIb9nEHIvTS+fL?=
 =?us-ascii?Q?efKC7Z+ambVzCX1+1EdPb3t+M7pwEc04EuNE+1jEVwxyStdyV6CYrJPxEaB4?=
 =?us-ascii?Q?cYCvMWkTd5+Jn7XS73Hsedm4ZKl69wEkjOH+A/Nd1rjnrSzUJo0hEovJfb8v?=
 =?us-ascii?Q?lRH/3B/GFPMEEVYuvYXCGqAVFn1oYgx2zeS1vj4kC54flUT1oej1qLpv9nbk?=
 =?us-ascii?Q?2PLFAag9jnuOnrrSUni1P+sA2HFXo3e9Na/CGyUiQFN9BSDKoG85VRtopBTY?=
 =?us-ascii?Q?pAJn6p92ujBsoG12deRv/svQ8B47KqmcIqBHDLShnoyF2zD7Cez3/TzUjc/I?=
 =?us-ascii?Q?P8TQG03Kgo5JZXSpydeoFoJ6GYeD7WjGN8bqxbrjA6imm/2r1PsGbF9sdbgz?=
 =?us-ascii?Q?icKMvkO5XLDDUiHQPFeYfMAYPvp2ZL4Sxwp1mTy7t5eqyAC9X5JOtqOXnzMA?=
 =?us-ascii?Q?C3/bK/fjo7c0OWdwvIw5XrqzA8t4mmxHC02dFbr2rxlW4SeI9o00AchZT/+R?=
 =?us-ascii?Q?cp+bzTjoS1H9zd4HTLNQ5ArXYoPJQAWrPjMlxllTvtJXRQxGuSJhnAbIhKYX?=
 =?us-ascii?Q?LDm8cXUlL8hsihJ0HxHYCD6lYWzAMBCtH1AzGZSQmLbn+L5MwZ9cJsRW3Jwl?=
 =?us-ascii?Q?fVG3Q7hTIt/eDAt6z9ooVunzOSJYJmCpWHCHbrTaDhMNZzhtmlIxqK1VlT5l?=
 =?us-ascii?Q?dx3jXJYK5/G8lHXCT61malrlJBoZtl3iXACXH+LhyAtxbStyqDS9ogjii9sr?=
 =?us-ascii?Q?O7WBPVIGl4ajVtdSSKDfZWHUvsld7fdW2otbzlX57mYyfY31SArx84PBysOJ?=
 =?us-ascii?Q?BkBTljpin7FOzaSYbxOZDBYz5BGHD2ORRHdYcyCW0dSfTpgWALGlCZVoVJxV?=
 =?us-ascii?Q?3nll2QRCb5mzMHFZSdHJSEvAryLbTowkUapLcibIfwwuLwlmTTNnnkpjSQhy?=
 =?us-ascii?Q?+b031M2RwVgLq3ztZ65KKhNgFb7irOfZWvtIaafntO2CTVjAmUWK6TIjSNtM?=
 =?us-ascii?Q?8W1lVK9Erys53cQshYnIIo0ap+px1DC+BAtHpdNQyCl/qFzR2Ad/1U6HEG+Z?=
 =?us-ascii?Q?WlrEAtovov7Hpnw+TNAIm17sOg7nZ08/+zc/0WWknMmVPy5YrQHw41RWQ2bT?=
 =?us-ascii?Q?jG1rGawaVWsa4lugkeKJJyyfR7RvykPNuo/wolQtt0pb/4dXm4gek8nroY50?=
 =?us-ascii?Q?qgCnntJsG0J6NMgoDDlhMAplTee4Jf1QYNW/GKbU3zAMnYX128DCFRPYHNSU?=
 =?us-ascii?Q?GqzEFGbDvLTQUNV/d0ldhM0NWnVlDvS1HsrqVTtTagLqC09pIkvcaphh1DjC?=
 =?us-ascii?Q?gjV0olYuR+DWmGVPlEOd7y+IeCN5dpiqlmwsCUAESNzPLOHNXMsgf4nl+Lkq?=
 =?us-ascii?Q?bsyLJgPu4X0nLOuaSOhQTYcZ6wxi99TUQeyDz3ZYhHkZl+p40fA6Wa45W2u4?=
 =?us-ascii?Q?nwk0YqgFAeoc8ioWa6psjzYKsBHLd9vuIbiFGh/7Q3YKQ242oHm3tJoUqPI8?=
 =?us-ascii?Q?cJicAHycF8EYuAb8UcPuRZz8F6mnwIOzQsaVTUwc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dcfc1f-619f-4256-173a-08ddbf845a56
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 07:35:32.8510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: auBrJ7jEX0Kj+kxsZweQAlzDcpYEZLyW3EEXaZUWF/KBR5lw+DSBZ9e4pqrPRz7snHQ22C7Z+7GKDggdZfkwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9503
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, July 9, 2025 12:02 PM
>=20
> Add the iommufd_object_tombstone_user() helper, which allows the caller
> to destroy an iommufd object created by userspace.
>=20
> This is useful on some destroy paths when the kernel caller finds the
> object should have been removed by userspace but is still alive. With
> this helper, the caller destroys the object but leave the object ID
> reserved (so called tombstone). The tombstone prevents repurposing the
> object ID without awareness of the original user.
>=20
> Since this happens for abnormal userspace behavior, for simplicity, the
> tombstoned object ID would be permanently leaked until
> iommufd_fops_release(). I.e. the original user gets an error when
> calling ioctl(IOMMU_DESTROY) on that ID.
>=20
> The first use case would be to ensure the iommufd_vdevice can't outlive
> the associated iommufd_device.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
