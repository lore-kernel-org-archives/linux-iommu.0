Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8741F4175
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765121; cv=fail; b=qyU6E/8VhfsdilP6/kqhFeAvFnMZmHFSCSINkgEfnUawN6A1fIurNd0lmXCysen4ktq+ZWX/Bi3liWsoCr6PA5oQimacaXLGPFYfy2JfI6BBmpJPoYf8lcwT++zsoBMb6AKLTThy0OqLpdOR5s+5MfPzgqN8eWi0Bxuuu/p+Cb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765121; c=relaxed/simple;
	bh=az3icxDEgAt+glBcWXybBF+gXZghk15w5w9X0spIyew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VOWQpGrwIHiB6e8Ds9HbFrjN667zztJWPE4roAncDD8dPwKbjPCl+/SEaGh/GzqWoZm4pjHpqZXEzdcV1Mr9nycWAE8aurp3mEnl+esqYTqpXKOac+s23BD/E+Ex1UsSulu6EeHT01s3q3AjPqeY8zQXB6Jm7Nq23YO3ye20Wcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i73YuMdn; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i73YuMdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741765121; x=1773301121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=az3icxDEgAt+glBcWXybBF+gXZghk15w5w9X0spIyew=;
  b=i73YuMdnaCtn0kFD4M6VysQbmf0dpHhsJ2QYkkv/aNRuKVvlIAmKlFtD
   sJ71e29l9+ACkv8xCYmyBOEIkg9Z4qOa5GIGzA5XNsaRUoAy/86HcjVa+
   PVeHLl6PhmevCQurk+Y9mT1l5dqgV4yIMUr1zJYQCEGqdg4Fpti/aglnr
   Zbe8acTCn2ieND1QgKxcM50P8mgMlcpBwcj2rEawjHJw7KFdRvAGlQ1uI
   ENqYum1yuZZ8HjeCGjPtkVCrA289QbfFaJ6VzH/UTuvYCyUQbfudDxh0k
   S7O6nmclFLfC1ZnaP+McN977LvsB6V+2J8v84MeDNAmwyiRAoCElJmX0W
   w==;
X-CSE-ConnectionGUID: 00fEzBsGS/i59N8UtmRMYw==
X-CSE-MsgGUID: 7GCioX33R2WLTwG9iIFRmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53035115"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="53035115"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:38:40 -0700
X-CSE-ConnectionGUID: KvtpOKQlR9uUSU4qfd9G+w==
X-CSE-MsgGUID: 5FZ82uBbTVqfyZsGpvI3Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="125616416"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 00:38:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 00:38:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 00:38:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 00:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5X4Bbcul0o0zhIAam9T/lpK4lHBeaVyK6p61D88CLrW74mMGsEVD4FzEH8HH6lGrqcdNrc4KT/55hugzKrW6peoEYq77sdR4VvF1fc4lG8lBW16eFHmpnY072BsBtk5LWi1/e0L4YfnbbD4M6xHhz+xhj/XemOedpNhFFxDAB7ediHir7FqOanl9FY8afmNm+k1ZzkpG6C2TPWV2LFjGiPNGqq6zPSbmpvbzri+T0FUzXivy8Wh0uqHSolE4+t3E346mv/H6U/q4GAIllP+2pxKQQBo4t23Jfv+tzvGcM1gCe6tFsBGaF5w0NfYaUQf2KrCjA2BXcDvZ7qu2VlHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/MJsfE+9fdByxxVvzZQ88dHiNzefDPeTUsr8A1cxD4=;
 b=mE7sfFYaESc91jI7364lJUio1TVrDeUDm0NhrVduC4UoORVt1sWJsFAAmHlHx/xLtSUua5ZvNB5iQ7+M7h9RSQMd223h38tO+QfmfFSbKRVEpAO3K7NFuPHCbjau62ePQZh4Qg0uIj/ym3AcRllgh4yp7/NcePFOJ+HECdijYcZeyKZpVkEyvxzqGQ13lYezMvEkTVMRxJwlmsaw1Bbfm2EQn7+kgYJCdG0Dq1WonCOcS/xfwACvhqF/izjWBG4nIQ0YX0Mz5iUZVxGcNRLA2RvdOk5qUaNMIK0Sbj7aXTqT92KZTY8vapefY3245Ywegmp1ahQzPo50TxbaGzpVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 07:37:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 07:37:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] iommufd: Move iommufd_sw_msi and related functions
 to driver.c
Thread-Topic: [PATCH v4 2/3] iommufd: Move iommufd_sw_msi and related
 functions to driver.c
Thread-Index: AQHbjtr2a0y5Zar8H0mtcZccDPCbI7NvJYlw
Date: Wed, 12 Mar 2025 07:37:56 +0000
Message-ID: <BN9PR11MB52760908A86DDC4801619B778CD02@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6a437cf5118d17e7e4d8002ba61498ebc8376b91.1741294235.git.nicolinc@nvidia.com>
In-Reply-To: <6a437cf5118d17e7e4d8002ba61498ebc8376b91.1741294235.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7419:EE_
x-ms-office365-filtering-correlation-id: aec28ca3-3cc8-4a0e-8cfe-08dd6138ce52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0aEjzKln5yVuPs9L/Qlhm0eTlrg30e9IQOXWrE0u+NqOV0xs8wpeXhekmT+F?=
 =?us-ascii?Q?Y/9CvMHdhqQtMFyrqadlO1KSe9CxLAvinJJKCudOjjHAs+W+c3lne85SiJCK?=
 =?us-ascii?Q?XxJSw6aZqCMiwFeyRHufi6skjNnX72kU+yP+DBYfUj+zszLvhZz99BXF64wY?=
 =?us-ascii?Q?suD3kqxMe0YICf2PjiGzVnNeOtnuHiiYdA9LqKhS5dyfTFMXeBwaNFAgU/0q?=
 =?us-ascii?Q?ZZE77taX1tkJTt45d6EMFvUBvj95SW07XhX2xmQ2Gr4hcO5ffIMVnxcQKTkx?=
 =?us-ascii?Q?fc+v1OX8Lskkh5Lw6sm5VTHmKBTh22JahvcyntDK1CY7y+JIPk/QvVl/Msmy?=
 =?us-ascii?Q?R9yjG0V2uo5HRKdEfLfLCWlKGRd6s1eXk6WijEeOXdYiKyukj67Oj4xKzoFA?=
 =?us-ascii?Q?8TegO5BrZ5HiaoYJIdfokxudGPd9LTwQ7B2quhdpzQPaqJDLjdxLVlZ5YRIa?=
 =?us-ascii?Q?SP0damWbOu/33P668esSNbR8xf8SKZN5AorazmLI75YSEDEtSFdcBWgcixRo?=
 =?us-ascii?Q?TiUIl+6BpVA1GhqhA010FUilsJpiucYpTiNVfYkeZ0hNDoxVQs7AOUUSEpFd?=
 =?us-ascii?Q?uKkhaLTW27AbEro6kL85cAWkorgKgMmft1GH6/D2TPqKjY1HGaEkiAZzkOJ3?=
 =?us-ascii?Q?vvfJPk4PhQeItM9EqXLK41+qm4lIA7lXGS/F7EDEw31Ao9uyPkHyRHaO/Jxn?=
 =?us-ascii?Q?hjrzHQmwKB3zCviB4MMGq00Ss397RjPP71zFHuHIgbmpwWKRtVuuIeSBmCl4?=
 =?us-ascii?Q?SbOUVDm0OXtJPmYKOpzKHk5f3dh7E2bgSiHn++2S5GwiuIK0gJRV/GrZqhIB?=
 =?us-ascii?Q?e2zUshyygrucYj5V1Tg2puHsY3Di1GD+JGTRkYWcyMwM7EHdXzHnY0lA/paq?=
 =?us-ascii?Q?JALR8YUtfAwtFoC30dZ/DYHbK5LJH5jptyqJ6+wDcAGHfogDYdeqIYHnS/pI?=
 =?us-ascii?Q?OAoD3q254qNmfE3Rhyr9XG6qZjZ8/1P1GdACJj2Zykebg7PBp456rK1ftn/1?=
 =?us-ascii?Q?6Z2PIDk2Di9oIFyZmVJkejDnFvDyKh/RUrklDpbjHx9tW8Jcrzu3jZ7Ci9Rt?=
 =?us-ascii?Q?2R/O61JGJMNHTUa1B28aeBWjGZ1+3s8qap2PqbLeBKwTwPqs61+8cMEIavxV?=
 =?us-ascii?Q?54J/PVYBi8UynYEXXd7sv7CKP+ploqt2ahFX3RRbtTOwK8nUM2R7TGy2rGc3?=
 =?us-ascii?Q?4jmJ17WgFoWSKwxB4BP3M8/fYwpJP0YW5Z8mRmbZoZAHaC4r5rQBa/Yuyf+E?=
 =?us-ascii?Q?XvLwte/SSrbbrllPPw5gcQzReENVoKusRNFmdmAuXDgXWX+VGV06FarrRPp0?=
 =?us-ascii?Q?kA7mAk7JyUUqo2zPe2Z3n7kj4Gja11GDa6NVOtKuIZaqy8/ivcIMpjTFstT5?=
 =?us-ascii?Q?g2xb/nl7iqIrdrDw4kliI3P5tJTxDxg6xAkQ2//ILkpSiGrolK995sTf2vL7?=
 =?us-ascii?Q?YCdasGTup7Dyhbu6kzyfGCqST8gmR6ru?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CGz/01ny7BhiG67tpqVvMC48jWYkOsf6ESwDme4yjNNnDgFQEQ/T5SP3P2hK?=
 =?us-ascii?Q?49R/QIzrFyOmt59hKT+Lg08giGwTcr+anELMGwNIPsjejFseazijCfjJr4/W?=
 =?us-ascii?Q?ko2fdBZATxbhpBTZHmlC/54KfnCVXuEh0wTxw4lfvkTyFCd5foJ88k1iBZSy?=
 =?us-ascii?Q?WnYM8zEnLrnkQjcuwqYW95CEduEopYY6vn4Wd1tEZwJ8rp3p7lbn3mDMey8x?=
 =?us-ascii?Q?9dxADGS95O12s+y3/UquXKDoqbSXbocTcHfWarPMuTjKtqA9WUgLdlBnF28W?=
 =?us-ascii?Q?cWfeqE2bsSsPMCFy++3x95mizi6qxCpDD+HTYW7MbcvNO9RLcGsf5o2fU8Y6?=
 =?us-ascii?Q?qEVxi6ZyJ9TKKa4Kbncv1jwUZSN21hNR4Q22rGG9vo7Ymc3XNjvEDanGvyyE?=
 =?us-ascii?Q?RVHmQw4pruXIyAvq/c7YkendyV6jMIbcuoVKfkOlDtmClyZX9L3BYteU9GMG?=
 =?us-ascii?Q?XsqASZFelLzKk4KVNi+28QW3mLzi8WO7h3TlbiM9ldPn+qkle7SNgqqjnDhd?=
 =?us-ascii?Q?/tfNfcm+FOB6U46KgJfAmzE+TaFcERcHI9h5sXCzjV0bOWTFrzNOK9dmB7Nn?=
 =?us-ascii?Q?k3VjZ2wU/m+zgd4xiRnKE6jEEeRGNcLMwG0QPuaFAgx7fRYnsg3nSXnMdFqw?=
 =?us-ascii?Q?lRdTKtvwgM+xe8UOR1+YeR/EdNFxZ0rfo6c5axkt9v50fgL8yA7CSat1z0e2?=
 =?us-ascii?Q?GdW+1xtqWr9a1fmOUTaS2Ti+4f7qIOjShBu3vPPV6xD3piALpgR6SbK2ZWMl?=
 =?us-ascii?Q?bUgEdoKH2dKlb0mPu2j9LjACLDokh1A+n/7E4/Xd0VjCUbv/mw3lJvtnIxKM?=
 =?us-ascii?Q?j0FCAyi5BOdGxer+86Favxfyze3E4wehQ4LGo1LYd1IbWzTDjLSWitK2caxG?=
 =?us-ascii?Q?twfdTaByUxCyXeQ4yimSDXuzLDyZXQr+8o21NCQ4pv+NJHQnFtShUQR1jed+?=
 =?us-ascii?Q?A0I95P4/Ia/luHCeGRVfosp2E9AkxmTzynphK3f1EpA8vSIR4IoNH64epAOH?=
 =?us-ascii?Q?gAXD+bv7M9Q1Mhx/VfLDTONQuK7381AZiZFAHAfzGMgwYa7d7prryk61OoED?=
 =?us-ascii?Q?w/NQsig5Tg2Zx+g57K4CXKv9b10SN25j7rB+pdFHD/TDGTWCR+TW07UJL35G?=
 =?us-ascii?Q?lqDeCVq4LaQmdxe2f0nVO283YSOPI+ZhxJyCV6aSRy0tPQrk69tn1Khi89dJ?=
 =?us-ascii?Q?TT2eIdOkbjHSa3Q1VnTzySoo/A7ykp+jD5HmA8W0/vQ9bS0v1SxYzJ/dfPr2?=
 =?us-ascii?Q?kksaxPjGHSY0rKS07+Qly+lVgv8C9RLHuB14vKec5GLHAdJhHUnitP3zg+2e?=
 =?us-ascii?Q?Nv+Ahb7lxciARoM0fc+OKnnGsaHgvsd56BPb6yGsJoOw9yfHkKCj/TcCdEem?=
 =?us-ascii?Q?ftvd4kjq+/FajI9oDoCqSUaJ2oxRNhLj7idEsmXHQ2jVrEPAwRVLdmaSiete?=
 =?us-ascii?Q?ChnSLetg7Zcm+2CFMXMvaBvueRyjJS69zrLYpuAaRVF1DpXj8TCXREMQCcGo?=
 =?us-ascii?Q?/pQ+ZUz/60mpxBN8d7Co3EvCwneVmoCUcG8n670xNA4rfuGlBbkUkVKOxEJq?=
 =?us-ascii?Q?WlUnnkew+IEP4hFl6oAh/m0RmvhR35PSHvasFG8a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aec28ca3-3cc8-4a0e-8cfe-08dd6138ce52
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 07:37:56.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KldNKXYNUFjNywAWYo7RIwqNq1Em2EMb8sDCFR88NaguLjGPAO5dgSIMuet/S05/m25ppTnvL1eYTj7/qrGpuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, March 7, 2025 5:01 AM
>=20
> To provide the iommufd_sw_msi() to the iommu core that is under a
> different
> Kconfig, move it and its related functions to driver.c. Then, stub it int=
o
> the iommu-priv header. The iommufd_sw_msi_install() continues to be used
> by
> iommufd internal, so put it in the private header.
>=20
> Since this affects the module size, here is before-n-after size compariso=
n:
> [Before]
>    text	   data	    bss	    dec	    hex	filename
>   18797	    848	     56	  19701	   4cf5	drivers/iommu/iommufd/device.o
>     722	     44	      0	    766	    2fe	drivers/iommu/iommufd/driver.o
> [After]
>    text	   data	    bss	    dec	    hex	filename
>   17671	    808	     56	  18535	   4867	drivers/iommu/iommufd/device.o
>    1900	    100	      0	   2000	    7d0	drivers/iommu/iommufd/driver.o
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
