Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0FA1A3165
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699185; cv=fail; b=W0qaDWNEJbZAHeVVB0UOZg2kvH+REvOHGLhmTPaNRpXFhEynXZwGYsLW02RgCuPths11B/31e13RrIrlDNPFl1AnRqU21WO/euooicnpWKIrk9Jf/Z0RK26yoNFjUGUJp1K4kWJ2IY+tD8ap4i66828w7rHhgzJWZ49Yq/lslGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699185; c=relaxed/simple;
	bh=TuV3zRaciHqIUT5lIg+BloYir8nUFYakPXDJ2XEIte0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DIq2jUQMIi9bNcI9q+TtoVIEwxjcozHnTOObBu2nxzP98nnw4QBIGBcbGmpT0Bnq+cGEJB8kPvYXaQ7vPHfupldovilM97r3+KuO0Us7gHPXGOFKxIgaGuk1x4DMlc50a9I6LqD3X70Mj5tqDSTI7hbuG8HUNoJsk6k8abP70bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2mr4zZF; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2mr4zZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775699184; x=1807235184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TuV3zRaciHqIUT5lIg+BloYir8nUFYakPXDJ2XEIte0=;
  b=U2mr4zZF18PQ1G8LwCmLnWi9zrAADoG5Qgf7pGPFpEmPom2C9DlvZ46P
   Ck9JE6r6EQWcbkJ5Lik4g65X2uCLUW7cqa3uoElXDFBjgxvl8MbK3d6p/
   WRXIDIUAX1rX4PB2uuNgAvOIAev69WxPfgM46MmLyW0gc5UzDEsqaeDPR
   9lut4EkRoWCvD8o07vPW7NFAedbwwUZM9pQg6h+wkVt/1bgTvyEFEP3GE
   o8A8AP4U1xIXzyrWFdnwfgBQ6x3gtptajqh1JfDwBWbul5ezQh+GM/OOu
   J5aVf9nSNCwy4YVcnZgahCWwUA4z2vq5Nd8w6yNcljhSR20qC6meirvOB
   w==;
X-CSE-ConnectionGUID: lf+qBY/kT7ineY/HFn6Y7A==
X-CSE-MsgGUID: 1Sfqxy2+QuWtlCY909xTEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88081517"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88081517"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 18:46:23 -0700
X-CSE-ConnectionGUID: 5/S6caRgTGyrGlfPhyHGkw==
X-CSE-MsgGUID: KXYm5ot9Qu6GMX6KphVnxQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 18:46:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 18:46:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 18:46:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 18:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdUV36wIuxZL67qFbJGBc5HOKrUE9Zu1cZY8wfqH6atUkSJTKm5I52rwljjmEHU7Z2dQUeJhVJ9L8ZBWHhqtBy0If7txX0rtdNni3bCaK7GIWpI+/JvmVRh28mH+cUqte/d/ytRz2xnPNdgqDR2jNJQaDi//HS903imagi6UOpTAOScVSUmyNzTVTFmE1i7BtMuCeKgL61d8LSC9YXQhD8q7GLNnoJAMPHZ6N/7tk8jQp+1+P9H2KAwUP2tkexXdOsuhYZ3tjiz3j9bheZTCsYS/AUA+7bbfLjbnsqdz3Ra4n949Ch8ngq75RGwAMeXFyydWVmGjYjeHSyszlA57Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuV3zRaciHqIUT5lIg+BloYir8nUFYakPXDJ2XEIte0=;
 b=DhSW1IRXAfJ3mBn1DYulgiMj6NOGstbOstrPdAwNmAfOLAaM+TH7oHMgyIIW/rBLoVttaSq04EdrsFAGAXT8x5cemeb71zlpoBlORv/ZYLBDRJeZFEOJ51yzjzZ3DvH2uJg/7O8QY7/lhuiqqMiZHwikg8MGpuP7BLEtaa2qOqT1TtVWnjz4UFc5oqIWsyD5sBZenaLj8qtakIdQ/a15YcFJfCcfwWYn6m8P1XJPNCUQQJg9QrR3uuFG8xQb7R0/EIwn5jQ4eYA/cDOZeMHGSQ///rKZwgNCU1rZVA1sXmVD5QIR5h5g5GvfR93KUO+bwS+ffhj4zSmylPAgsVDyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 01:46:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 01:46:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex.williamson@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH] iommu/vt-d: Restore IOMMU_CAP_CACHE_COHERENCY
Thread-Topic: [PATCH] iommu/vt-d: Restore IOMMU_CAP_CACHE_COHERENCY
Thread-Index: AQHcx4foCLufK0Tk7UGkb4IYZgVi47XV1agAgAAgBAA=
Date: Thu, 9 Apr 2026 01:46:19 +0000
Message-ID: <BN9PR11MB52763A8811E8B4F42A99E6BD8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260408184443.3077333-1-alex.williamson@nvidia.com>
 <20260408234938.GH3357077@nvidia.com>
In-Reply-To: <20260408234938.GH3357077@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6516:EE_
x-ms-office365-filtering-correlation-id: a5017c55-f072-461c-d1d5-08de95d9cbec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 3J/SRf9/YjZWtV0T6tiZWYnta/nDhNN2JAJXhcGYusBcgt9gIUYKXMfRd836+VjfxBs+YWoI4Y5YTX7AmvZz9DfBKibA1XElkanSdoW4dDnGfw7GvHIBYq1XlEKelV3jmT7gQ0KzUSsvXEtRM/bK86K03FCl4HdD95uR2HTg1/oQ3Mhfp06ylh4B2N5T3iYMFEeNona2jpvCcj/dBMJShosqV4bQjyMsQttgtB1fDXOjETjUH80GLfYv5DpohKpbXkYxcxdoA3d++cVA7/z3MiqxRUOGP38wtMWDlih6LSxH5JAnZEjs7IN0TarHiL+XsWOM1LLsYuspjnKjSD8VtM5dPIOFtPeeZyMHNfcYwrhe9aWFxA4GsUmUeaitkXv/QFSe/HGYK4EKyZXCfxD7R6XW+zp7OJqoAKlYTSV66ojdodxxSea8jbyZGKFGny5/MC+UjnaMOrwi2JCGlSDxeNfUBkyVdcQwrlTUmgXbQrVy8Yg3oc05vMkXHpiquqoDq7bs5GMylW39JCZA5kM12kYF2VIS1KZodfgSWmKDDp/RvQ76WTs4Bnvl2H34QQi1uu/9FLQih57N8HiAeOlqu4rhYd0dsEEZ2G2PvVQN1BThVn6i7qY7ffoprcJSet6HSk5Ne8TvwOx1Tok5yZo6Od/lVLq/Gyd9gzvb43fjcMdoiIrhzlrevHyfjUlODoIubQEbAbT9Ipk+/4wKdXYCCSk5lpmLArh57cB8hFM5x17TwWztk1pU0mCQCvVbcPGRKvOkNNtlLcQ9HVjA+4KT9ZyOZlONH7c++KbuWUpJp4U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y00oBjRCyeoQDvhuvGbPxe3xlrqby7Q0iZeA7yRCHKjCz2djEYgBoUAfSOx6?=
 =?us-ascii?Q?3DfoYsRR9XwnoFwAzqa194d/vI+4JfY7bqs5xcBXTXWXetFq8omJx8qIOrYZ?=
 =?us-ascii?Q?zkubafqNe5aPL2dsvVwZV1FcSrAgFQ9bVM/0VNXi+SJlHe0oBw6iO4ipNBcS?=
 =?us-ascii?Q?DkZOa/ieKuWL5SxuKQUAvai2M3i3YEw9Pvbp98p1REqWngp+9k+jSuMDBkr9?=
 =?us-ascii?Q?J9MRF+avRQwUZwKf6aokdnk0gxd8tb40GdHBr0MrqC7H0in5tMPIsqS7ZOUu?=
 =?us-ascii?Q?kO9IenNMJZT7y38sQW/MtmR3D7zTFOP1G7k2fFvWRr8B/SrgK1jU+yvuk2Gk?=
 =?us-ascii?Q?CxD9TeVxrUiSSsUbngmU5s4Jv1ywjlTubX6OnB/o/VWzJ2Vbd7Y5BqzytXzM?=
 =?us-ascii?Q?k0mfvP8EH+lp0mi78Gqlo8Q5muz8T1lqBLIWTsauKoICuY45qpVqiWnCs18E?=
 =?us-ascii?Q?Ri0pwjXWB5dsS7vP4aJNt7EM2YkNZ8G8BH3s++HlI8hueVpOuXJO56b46JQe?=
 =?us-ascii?Q?T5e2ihPrUnxD+25iDqp2HzATCRht9wrPeXjEykDl8YJuZ5i5UHMqhC/hiNJG?=
 =?us-ascii?Q?AjuwNRhP001mPrGJrKtF59FLE26CbFvAngSMwBLynCWG9cobC2k331FzG3Ui?=
 =?us-ascii?Q?hGbPStmq/WvtgJlDqAngqsgPGjpmY1675lJiF3Q2fNLIGfedLVggU0XCHX66?=
 =?us-ascii?Q?7EuMr4pPL6mHxRx6/zQp34tqM8ASeAVjtMP3LePybSMTlV4suK4G9ganPFAo?=
 =?us-ascii?Q?GuiaAC716pXomYLLCIX2LCMqUYyL0bJw7TSXjwVd/pLkzZzeeBA1vZgOcRNf?=
 =?us-ascii?Q?Rz/0WJOsy4roKivsHquLo9/Rp8VZ46Go0u+Ww2krRSem+Vv/YW1vgC50AxkY?=
 =?us-ascii?Q?uAjmPHTjfhsaYEF+m1oPuhFD6dfKnhtdWAXH0WCpHgLAvY8BcjMPywQI98HL?=
 =?us-ascii?Q?ZguomhxqpR99IRCguOjVSdN3zwXQ5ztwxftJO3FyZq8bjF4+oa/XUz3sL6bt?=
 =?us-ascii?Q?7euW89yaVKu0G07PBGhIAMhrVv6/s1jmgeEGyERrWnyV4qYW0JmF6IQMVg/W?=
 =?us-ascii?Q?8oRoJqhHTZcVjBFS066zd9ofuKTPQ5X/sAsmkLVm4pMCSkunKV3s+4IaGNG9?=
 =?us-ascii?Q?f2Xiw+KnT6b4l/vwpnCv4l+6oFDp3qWxXpDiTWDF7gzqvIEOIk/yOtNrkmn/?=
 =?us-ascii?Q?7BDYe7zOP9L92PcVxYnxtlblMPWLtQlovVkhpCShBlWdMJAEHXz3onK3/i2C?=
 =?us-ascii?Q?25hdCf07lZ0FfAO7ZIQzl2YaMS8uyb7u2Gqlvpzfo3ks6UpnHLuS4wOW5YEo?=
 =?us-ascii?Q?7OshwbjVe/EI7rWj/0acj+7GyxQZm9vh6foCaeVPqygwsejWgvWpIQyQh/y1?=
 =?us-ascii?Q?xx2vf+DOg6AUmLzEWfb+9dfSbt654jEmKbFEcEATLa41OVqwvg91/kGdGXMI?=
 =?us-ascii?Q?r49D/qgx05L903oCx/WfRIfYbpkRc1uLg2VlSVauYvIhKsGdE9P1P3XKf+LF?=
 =?us-ascii?Q?JwLJ63TG8LgjkRKq3R2jVdlGEIHdQVyt78bAhReivJNHEP7PdYwyxIVEGuh8?=
 =?us-ascii?Q?XhxMX9eZmlUtYy7y8wgBevmw0kN3rqm7SChpAfWZPIaIpkPqi2/takgL3zc4?=
 =?us-ascii?Q?aNJL9AGvUX3SQMLhjZ9rrs8BzLhMqW9z/QFk8odY4tTU7rTHcYwkTv31CL3I?=
 =?us-ascii?Q?Kobfx3ITN2LMnR/e4CODLjtQA81V7v2LWonKtogeD9U+HxcV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wHPhMwQqKpc19akrYTV2OGttwfaoohcsufQzhK+8tfr05iO7NiKWB0lehsMpePYis+pDGMjPPi+BBBRPgrd+FmZd3o/30zpHvR+K9w+jKr0BWu6SEoojmSquexaFWkQAh43/IlrVhYDN+rIwXOnM24PmvVvhWA4s78znqYMNOiem2t+FvaoSuLAVqzJUznmC4y3+eDM1/cY6qbBlmBBe/bAAVITz5uBIfVMbbfwoSF2QT7ccEAG+DeRYkSrcvBHWbD9uHOLH2JuRlCUogwvCTl9rx2P+Wyw9MSEIClxX834u+B0fNSRPBtyyt9N9SadzcdsrRwd4JZbZ9xvoKoB+Rg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5017c55-f072-461c-d1d5-08de95d9cbec
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 01:46:19.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1RzCRpBiOfNGvjjQ+VCq+MyHUCatPm8G+Z74+y4clXcGCIj3POVh6Wv/X9IkOZEEnTl7xpqQRTudcKiIK+o8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 9, 2026 7:50 AM
>=20
> On Wed, Apr 08, 2026 at 12:44:42PM -0600, Alex Williamson wrote:
> > In removing IOMMU_CAP_DEFERRED_FLUSH, the below referenced commit
> > was over-eager in removing the return, resulting in the test for
> > IOMMU_CAP_CACHE_COHERENCY falling through to an irrelevant option.
> >
> > Restore dropped return.
> >
> > Fixes: 1c18a1212c77 ("iommu/dma: Always allow DMA-FQ when iommupt
> provides the iommu_domain")
> > Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
>=20
> I didn't think this was merged - I didn't get an email about it? Joerg
> I've noticed alot of silent merges from you lately is that deliberate
> or is something wrong?
>=20
> But yes this is right:
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>=20
> Kevin and I both missed it!!
>=20

yes it's missed.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
