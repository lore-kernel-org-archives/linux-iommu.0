Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D031F76CA
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094830; cv=fail; b=IKQdwMte7WCF2R9KJGG3XNMX+1L3aD0Be5p4m4K1Afdlpgq39EPfm/EfcHZDZ03mJbJmfD9a+qVnbV/bt7y91KenNsalM++WkOzWBWMToQaULaB1vYh6JUSPpf/dKYzVMVTqQhhpSOTMUIbfFTQ50XtQdzlqd4xkAqOi2JXzUwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094830; c=relaxed/simple;
	bh=dmgI/Dj2bAnf58wjD4gdaCevEGQP0Yj/BUjyqInim8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PaMu6M9HlLbuIBJEoJHsPPGLb64T3yk4prHz9QfK96glrhnSBJJrDly0E9aP6GIoRJu5xRusfrzLcq98bqMSnu8OQjkc/9BHotSP5mFV9K8IZaqcOoqf0DilhwHgzetLpki+Excftc/qLlbDIf8vbYig4i3qonibewNt2Aw1sWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/UotChl; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/UotChl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737094829; x=1768630829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dmgI/Dj2bAnf58wjD4gdaCevEGQP0Yj/BUjyqInim8s=;
  b=a/UotChl8HpUAbEy+zBS4qn94+aspHht5oYnDSms+Ur8ApkjTrJNBe/q
   rGq7v4aKVLdOCB2MnY3JDQ4utQDIW9NyVUZ/c2yj0CqTke7YwPaqabL8b
   3XjmZskCy+Nz4la5KIvgtujRuIZNButAOlYbvHkWb09tCfcfxmWHLdSEH
   2Fljxmx/Ljk9gpiIC8qeuB8GeqCiEguIjBRkCbMlKfIWG75xuuJmcLRo+
   7BfvYDLU81MuOh19d0NEB+L6ik58lW6KIzxBxDG5kig5qdtPUXeuf/TEs
   sgGg+lJ850ROzus/S4m1aGWzhYTlx3We/mdPqk92dlZmERlKZBZrp43DJ
   A==;
X-CSE-ConnectionGUID: HxchYb0wSo6KLfnBFdc2sQ==
X-CSE-MsgGUID: kgtf5DxWQ7yipZmmn7I0ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41281453"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="41281453"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:20:26 -0800
X-CSE-ConnectionGUID: AJcJcJMWTRer96VrR9dOmQ==
X-CSE-MsgGUID: cwKiQXhuSRuuekHJPoTtJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136595364"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 22:20:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 22:20:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 22:20:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 22:20:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5egvfyEOY6sEFnCAzxeKh1W1qGfliz1RZbDajC6HN5bFWoUVVaGGaN0ubnYqlbKQbofGsDvFmwuYLW/EEofYGhuduIWFeSeLfTPxXr8CyC03GaewwBwnbwCUcrFvak6joeXobvI4ObMwYelgNDRbpQmKBPtX4iVHnoKHRRNh5EKF4w/JOJjQkU0GYK4Dmc9fugn2kS5CI7JWs9k7L15qh6mb7vfHn3zDj0o6Vd4PXhAC3Q0D9PDSH+ARVy+WnyODCIDyQy6H5nw1Gx8RYVM91mT5/gt3nKW5rD+51XHalCHk2+gCNDM296nuXCyDqZN/bBeDSgucNOboHI/tm+LKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BASIaBTDWwSl9CSIRGtzFyKi5uOIp5KfxsWRHkV00k=;
 b=oNx/fS/VWt1sTugLaIMUL+GvGlbfyj99I6IiF7ytyWkdlOxI89q0dHshj7sEDZkV+OOasbZYfCNGz9mi162a93zLWIR5UuRRBRSy8GWUU0yWxMmtmpQXQUJuSOT0c4tJXQG/4citlt9i+yoM8XvL7/kwsxruk1Z5diYCEXxiS+yzfJ4IqlLrMpxbI7EIXpnZ5ZKlQU3Q9ohNbuqjCtQim6BlrewUOJotDj58BdSGksYCOrsk+ejQKZlMgG0i+Bd+8+bcppJDTcbuB54Hj/exhyHyVvjdH29uCSzpvhInvtBcXVR2rO5M7M2VbP/CSQr76gSEUwOxBkPGteGVRvYp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6458.namprd11.prod.outlook.com (2603:10b6:208:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 06:20:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 06:20:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc v3] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Thread-Topic: [PATCH rc v3] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Thread-Index: AQHbaISKXN9gcKW17ESIiQqTgzwiWbMaffrA
Date: Fri, 17 Jan 2025 06:20:15 +0000
Message-ID: <BN9PR11MB52763118C04E83C14683CBC98C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250117020449.40598-1-nicolinc@nvidia.com>
In-Reply-To: <20250117020449.40598-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6458:EE_
x-ms-office365-filtering-correlation-id: 52ccc8fc-1fa1-4462-3d17-08dd36bf020d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WB7HndAdAgHx0IWHVDERc6avZCwTeNdG1BrYyjNnqXyUd8h+3JGy5Fe9MZDq?=
 =?us-ascii?Q?H8KXR7HoatxHbjbJC6DhYy8T4cMbgd8nS6K9VbntKdMmLxydv8rx6CQ/Dq6G?=
 =?us-ascii?Q?5mR9TGPUILN95DKPEJZM1AXReEi++qOiZbaxUBawousZ41KjvvDELxSYnYyJ?=
 =?us-ascii?Q?a3I25OHVWrjTjkfpc8J6VYKibnbHgUwGP6hi5QSX7k7i2nQI7f6xnGc85xQR?=
 =?us-ascii?Q?2s3O5IBSw6rxMAAzwhHTbeyoJT79Kve4CjSgEZkHQkG+TiH+kLuKdRJ4ZWH4?=
 =?us-ascii?Q?7anu6Rx0p2AsDi86HCzXK94t4xsmixNmEGaIOv55ftTKe/EKsDnHnaiPxJxK?=
 =?us-ascii?Q?cvXF9nfKqsHnEClZan8g7OOZoGbN02u+5dGsz6QKaJzTp9SRulIqKnYtqc3E?=
 =?us-ascii?Q?nDF0hxhP9kI0c3v8QiOfFgQCPyGds2oCKcCXxQzEDvYdGV/veiFPJlS+DwBP?=
 =?us-ascii?Q?FUeTO3/xFPnJ69OcHt3yojknH+xSu+EcwGfze/PEYdEn+fohFI5dWTEfvq/n?=
 =?us-ascii?Q?JiR/Gil+t0kk9051f8JwRnvNlSEryaq6mFrcxliPlj8X27BMaKamXB6ssZKW?=
 =?us-ascii?Q?zFHTF+diBzM+TlEUJKj47eDORerZIZ+n3uqS8/0geQ+gMQ+htjHT04UyQqhm?=
 =?us-ascii?Q?PvU5vX5tifPeK9n/V99uqr1ouv6qXXGNb6nawk0x4wXQ7Ijnrc7tPMnmQLRY?=
 =?us-ascii?Q?0Rx4zNL6J8qSV7gz3Rz38V+CcoXR91PVcm77QaB6XeluXV5McZvgD7X5INbC?=
 =?us-ascii?Q?mDeZe4KsXrDcD7AoQKl2UbLjKCTzGK4kkcd9lQuEWoOLtRbrtSM7bqiGIV/h?=
 =?us-ascii?Q?xaXzFIEahJYHMW6enCVCXIyJ7lhuGMrazKSSzLR3wxhfuSPkKNxSSJMRQyQx?=
 =?us-ascii?Q?ou3nn93s7fpWhif0nSLF7FsSCEdhuhIq7UWfZ1VAEhOxRnj2CuudLkOcdnds?=
 =?us-ascii?Q?hLoX1qVOl6Ib4IDWFvK5TxWk847ryP/b8g+C8jfQ+qgQ3/8oLRE40kVdjxCv?=
 =?us-ascii?Q?wVVQxuWyVi3Czy5Obf9KdtbPx/hE5aPox9GXwsCQ/9lCp5iACQLhwZnQJyz2?=
 =?us-ascii?Q?w3Zkp4MfVkFB4NpbuYTQJpX5KsEnvSeXKYFuZP+QASOg1X2prQrtpG2BspAi?=
 =?us-ascii?Q?uJZ6buOvgNc/KPnKjYpPXaMGPkbEPBXxsd791GCwVfR+8qRfh0YTrTZ1nyrf?=
 =?us-ascii?Q?e7PS3qf4mlrdLbXubi7ykhQGXFV5KGvQC07uwaJqhCJYjn8vtfjz/cywm3qe?=
 =?us-ascii?Q?u0je7eHFyuU+DUHgzDKw/MTje4h2LHffiqoREOvuQMPZTsIWBE2wFQRiTU+J?=
 =?us-ascii?Q?1Kdl1BR/ztAykPk2iPXmBwyq/OYw7BE7bykf9CY0S7NnerRDXHEXr5yEo28L?=
 =?us-ascii?Q?C7cyL2G8ctMi7iLsQy5r3EBi3ALDzVhrU46K7YJvLnnYzH8FGY6BOoYDBTtC?=
 =?us-ascii?Q?t5untPscRxAuu2n6cBzl8pHw5NcQY0eZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R/DosK5xROUAsGfNaNGPkQSFOJIhgXTnF03pH5J6dzuqR4tWUbB7QK0uZsgj?=
 =?us-ascii?Q?AGdzt5J7HMTOYMQjhY1ycwp+EemMAJRzPhLy03kgYgCZ1SnHLQRpYwsV3quX?=
 =?us-ascii?Q?AJygGwJbAzyEHuycNioZdz7yOcIKi0f1urOEW6VPZU4APaEJutvlRXGeQ0Aq?=
 =?us-ascii?Q?EqwzYMHeynowBdoB7G8/n8ENTQcyF3dxTf9+JMorDQY2csu4yBEIMjx3ewuQ?=
 =?us-ascii?Q?Td6mjL+G6KX1RckyFF5ePu6NCJX5mXdni665muUd/SGHrpruVsb1w7uMub7N?=
 =?us-ascii?Q?ulrwJz3mmEUcsdmtbS+9wRl36CiddRA/lqJEcg7Q3kjRdXp3HJyDzk2Athh1?=
 =?us-ascii?Q?Z5a0kHrgv2XBVKeLHMfdWl0VS2dz1xh5yv/8CBdmyvpBEH2qvAfX5046isBv?=
 =?us-ascii?Q?vlhj97EptsGS0EB3rXgDuOQnDtsFnajoTqhlNtq2HopQ0qRxPhHc6w8ZKjPM?=
 =?us-ascii?Q?NYtf3IK8uXQcnccCNhJ71c+LHMqbJC8QcgS4Ped+bV17rLwvLMQy1+mAfCFV?=
 =?us-ascii?Q?4tlSlGA+Hqd5Ynrv+HHzmYN7rcUHnF2n9okFrOzyiInloiqMlwe4GJz0PS+S?=
 =?us-ascii?Q?Egliv1VgjGBp1RkkUWteIKZMoL2KVB/qcfTrUMJRYXi+hbtWp3kUs5ia6iqc?=
 =?us-ascii?Q?eW6pGzyhmF0kXH6Fl+glnfuVGSzkU5yWMssD4Kr7UavXQ/YsQSDCDJ49x25e?=
 =?us-ascii?Q?I7pvY+pwFK60PkWFaEr0GDnRMj2vI68Nat9gX+qcljUcRCaa5XJyjbWl48Dy?=
 =?us-ascii?Q?pkO2m2GnTDsRNuCO8qLeOJkrIM7F3P1+OJB1ITrakl8jKo7Q90zfRIavOSVl?=
 =?us-ascii?Q?IeenUWcLKuKd9TI1s9YqEwzDRzJozdQensBwlQeRzoCGwOMx5JeRSEIj5h8u?=
 =?us-ascii?Q?3TORsg/SjPWK9Eo/Nc1Z5WvzRJvMnq4Pi4DkQDPPEKCTxvw7dTKm+IG/5Ihb?=
 =?us-ascii?Q?hlFDBffnSfbqqx3+EjaGnjiS+Scvd2wjJrdBU7eIt7i9lLzvBFrkObBIbW1T?=
 =?us-ascii?Q?az7t10mp6gvYaQyUWjGgdxjose+j1yYUgfftu/o6+BFO3DF0lKdztY6+r5nl?=
 =?us-ascii?Q?sBsog3dbOXyxbeOuii69u7aOGwAZmbiTi3S/yysOObJzfkJuVzjUvjbzK5Jo?=
 =?us-ascii?Q?MiMNjheI7j/ZsZmoC6nuesnYqi1obm8q0AcNuMVHPdap+xJ0axTYNDPst0oo?=
 =?us-ascii?Q?vc/N02l2N6EFgE+ctKGX2IaOI1pES9ld13bRtrkcWDRZ/MaTPAUbUYY+aN+T?=
 =?us-ascii?Q?8gy3riVvZHk21CAbKKuNYeBrA/XC1X9kR/hMD2nPXfb52kSb91m1L+Av6i3q?=
 =?us-ascii?Q?HtIVjhtMURZEtmQNRfzrQLV4MPsPSka6M3MOX45QuBl0N20PTaMMY4aFlvPh?=
 =?us-ascii?Q?M7mpwLUXLlyYllO/hizbqREVDGhdoM01Ns1gsrTpPDh21KIPoC9G/C9qMCe2?=
 =?us-ascii?Q?fRjVVkUgUmfOxA3HMEkQk/IWFh7fiWQwOucHo51CDwG5XB2c/hPD9qWm/4vU?=
 =?us-ascii?Q?OMk+GrvJKyIvwxdoZfGiM8QfV8nAoOy23QpVgFNMq16Tli54suHVPztT0Oqs?=
 =?us-ascii?Q?DotJjtqlsXsl1oP+Pc3WxqGmNmm8UxjcDLKJ3VyE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ccc8fc-1fa1-4462-3d17-08dd36bf020d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 06:20:15.7142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAQ+ivPkiWAgzX8CqicfHWKJOj9slW4dwLGMqBWoGowH0lkLUIeTls66PLCw3GWNDpDpW73W6WVz3nEWGxsgvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6458
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, January 17, 2025 10:05 AM
>=20
>  	mutex_lock(&fault->mutex);

Nit. The scope of above can be reduced too, by guarding only the
lines for fault->response.

Perhaps Jason can help adjust it when picking it in.

> +	spin_lock(&fault->lock);
>  	list_for_each_entry_safe(group, next, &fault->deliver, node) {
>  		if (group->attach_handle !=3D &handle->handle)
>  			continue;
> +		list_move(&group->node, &free_list);
> +	}
> +	spin_unlock(&fault->lock);
> +
> +	list_for_each_entry_safe(group, next, &free_list, node) {
>  		list_del(&group->node);
>  		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
>  		iopf_free_group(group);
