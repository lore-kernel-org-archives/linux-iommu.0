Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E439658E
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941595; cv=fail; b=kX2nl/cCNjURYSz9FC9uyWQ01KVXFX6UQitwrBcfixcHkIHrfqVJgxGD+tBAXEL8Hjzw/cluKg2qyNYRZcfwJ5gIF5/B17vdxnPpkHEmlh+nNBuSWu9Wkq+2tpui1o3XmLO3e8UpFPI3wAjXDEmlqTSiUVTnTtcHY+7Q5TDfBZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941595; c=relaxed/simple;
	bh=uG9XN15hlXZGA4bMCYSn0HQBaGT4YPWbEjayyS954IE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tzYfBykzY8FB+w2icaJ6SyAebGEq3czwBHCv79A9/NddkAKKdBpleTnAZNfkk0B6FHp12Aa80f8FQBNT0QiwxFrddan6JamoBuzXlClbIlfdwofDIB7e3b7+7IJRHJiuN2rI3fifmKXPmjcelIfLGlvq+YgYtuZSfHy5zxRWWtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdBXIh1M; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdBXIh1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774941594; x=1806477594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uG9XN15hlXZGA4bMCYSn0HQBaGT4YPWbEjayyS954IE=;
  b=WdBXIh1Me6geHO+szRk2/gvPGV0jKlxHNLSvXIkpKe5bq8e0iLegVVxb
   C2aUNYRIkedZHEZ9cIIJow2zd/LvOh6vRy2XVdkEDrmDqbzbm1YAI3P1A
   36Rf+8x5hafziLNy5MXcPZPgIt64nYqoVlHEXkULFHiD2CKt2EUVSq//d
   7diB0k3MWUcsFJCN+0BADLee1dtC8g1qIyo3/NZFs3jmLOuovZNyYQtQ+
   5cBrM/NOYB7kE0jn0ZMJ52OrwAlvV7EYBhD9/ihNMfq7skMhR9ZrgPloY
   rd0nJrhfHjrKa9kZoh05RT3UrT7t/eby204hN1d9VdvdCJUit/dOUuikB
   Q==;
X-CSE-ConnectionGUID: HdIs0nMdQZSOdh/AjJw+HA==
X-CSE-MsgGUID: m4MTa4xKQX6nOPWc+iN6CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76135847"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76135847"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:19:53 -0700
X-CSE-ConnectionGUID: S4tzMeleRde99pHuXIdk/Q==
X-CSE-MsgGUID: y5uFOl8zRqqAhz1CtwkOPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="222985354"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:19:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:19:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 00:19:51 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.47)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:19:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol2SyDbIvcJaWSkJ/IOjA7I7vsbA/Z9Bj5wEXWdVN2CXrbmuH9jAlPVUxDOSkVEcGQgMXVW2bw+9fkS0eK4JyVU18XfiA19+PhT0iwF6+WS6M907FMdQRao1R/SvFWWpY0hnpCmeLlJFYPm3F/Fe40t6lT9HkOZyKhgAV2kDSzWmhT0zOjpSwFfIjwRqygVSVI6zrgPsAPLFj4j+BaSg0iB4EgddHeysxzGOBLWIapzSqb+f9prSxQ89l6VwSXIEBJ9+fJeLmlXb/icB28FaiP9GPsjCFFatZaLy39Utyqn7aCby4DyPFbagtXFd9ywKdvKrucKL0i8860j0w+Js9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG9XN15hlXZGA4bMCYSn0HQBaGT4YPWbEjayyS954IE=;
 b=f+5Muy9pC4/n+7MgychuXo/JPhvLBcT0T0Vpqsnq3+fTqU1BZit4fdTs8QthcZMO6OeebE2BJr9TAiv1x1jNqwlUfygX8iJ9at8r+YVMMN0uSHqeVvJeMRwCdggUWdJ+Ccib2NJUe/Lr3AfKBXwpx0lAA7V83o9nG24tcKCFyTUUupsgFaV0mFjxgom3aUPawnFl5Mt+qSIv2ULqMOnoXuOZyS0LjTBPRDTvY2ETMcP1QpAahZWPOf3ALcjTHhkFPCZ0uvtAIYL6sQ7qPJ/iuPHQtwwwe5Qq8bpJBa9q9O5XGJLujNea/pn4v7oFfoZfC5igiOE4VUh1VjuzeB6l3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 07:19:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:19:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] iommufd/selftest: Test dirty tracking on PASID
Thread-Topic: [PATCH v2 4/4] iommufd/selftest: Test dirty tracking on PASID
Thread-Index: AQHcwC2a7crEPUMhmkO5GboNQHq+FbXIPRhg
Date: Tue, 31 Mar 2026 07:19:46 +0000
Message-ID: <BN9PR11MB5276A3AD373A7F2BC3D8BFB28C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260330101108.12594-1-zhenzhong.duan@intel.com>
 <20260330101108.12594-5-zhenzhong.duan@intel.com>
In-Reply-To: <20260330101108.12594-5-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB7984:EE_
x-ms-office365-filtering-correlation-id: 73f96c69-d411-447b-5151-08de8ef5e32d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ZZi7Sy1w/VMF6StCAM/3IBFRBCSs85ZA84LKtEWZSlSVcNL9uC5XHbYrroD5o7fIPnGkMPccVFXLJUIGEM9Zp5/z7VrHWpp/+QDm/Z+8DEE7D329qXWldn4GDwfLyKfHxa15lKlLnJl1NkjF+UjN4Hk2mtbMZ78W43qxdqbPhB7NtLTtgMG8gGREwYtUvlx5JUWIeHw7CCJS4zX+LKzTULlX/el5my3qZEn32PPLbxVp3L3SJLgGC1FFrrcV4OKSOYIqmwT5230zs7vzCmSlm9kxdcpUUIsHX40mvosVvQ9uJ4UkpVj88+K+4+SwckS9CNov3HHqKLWaAr7e1OGPitd9vVwRGhp/EyAXpQ4VYSch7oKgprrbtekYvFhrpSHyVjpLNiZLWHwfuJJqhSZcAxVeWAtxzR3NMsz1Grfz1BHoWyDZL4WWfKGP8iAHJ+iAVAF4JDD0nq2oEMfM3SZ+2xkz7HWwPSdfdvpQAIAXKYyh1Xxa0gOd7T3PV6/ja1huhxJQXUi3YL1zYrzqjElINPFldL4FhMdoNEx97CM6fnaq/c1umE//NpNwM+tOSe/Fyzsh3wmlVm4Pw9KVo+krdSZAeH0Sd7YjIPxHd/DN7qxe8149O3jEMDCse6JPuJPwKKepaGeEkeR+92KzcXfXF3+Nn3AES6kFaTN/8+bwwBZlfpypjU7maYM8OMPwT8bJfjOO2UPg0a1LU7AMQjHGN2fG6xqT3YdMdrMB2U7dOZyZWhxWyd6G0lO6y3lGJ9S0W9JpftAkqt1De8HRIQ8cvWgkpol+vybsWIiqrw2a3zs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bymfcsyRC91E9oWyL67YQ2GxsBMQ+WpuDNLOdVdXjt9YANJzX4YKE6FNVfIM?=
 =?us-ascii?Q?qRTbujStUn6rqDPzQUjFwaXEZPqUS+PEpX9bIN+eEYBghCCBFKFrlNyRC5ol?=
 =?us-ascii?Q?A434os+yveCqfOy0djtaXJRkQeZtgLAK36pce8j3IMv72GVk9uDdyOnKy78c?=
 =?us-ascii?Q?uYxAnU9mlh1OBB2o57KhKuNVlgE/bbaShIlBFKsYUAPbY/4O+rNG0WTLBqrM?=
 =?us-ascii?Q?IDh9cxzivwi7eqxpQ5ek/9l8PXZOuiSuFFBHlP0zY2fGGztVZEc+ZL2MjC+c?=
 =?us-ascii?Q?pXNvET05F9mtJXBir88iNabVaEJvMoxgDGhKQ/5wZGuFEtF5FbsXz1E5o1kw?=
 =?us-ascii?Q?pkcKOv88BGOGMEdsFchIC7KIiz+dFfJ+X5GBPdPjldCOoG53jikvNv2qHmJP?=
 =?us-ascii?Q?ujYnMpLrxNIX2prMcOW2tRXW0Y6qbMtG8xD4UOyDeXyzGpyhv+f/9kYgACzT?=
 =?us-ascii?Q?grv2BVfg44x0WtBd1/TrqgkDLvDdXXZ8EGKdlT3vzCZmzZy/PXcFhkwUMc38?=
 =?us-ascii?Q?LWvH2ESC92GwdU53/JR79zZ9QU7I3QbI3DlBekOmGqOZepk8aVi4yAfR2J/n?=
 =?us-ascii?Q?ebuJizOVVOQE6KScIHFFK8854g6+m59eC9weq8/uN45m3LvMFg8KeTYtBZjG?=
 =?us-ascii?Q?oGhSloPWxTjO6TBNDN/6AA6qfjj1oJnL0okLXp27T4Q9ps+rSvrJhMR0u9Pt?=
 =?us-ascii?Q?rDuMkLEJNAzp6sHyI/6RAtDk4iTp2lZejjTNi8m6gaeGTGyoHP0grygOrJLd?=
 =?us-ascii?Q?X30OM9ALSUrGS8nmNHMOY7iQXVFSHf83i7aacUOzwr5j5fWdQ/oQdIFrlTgK?=
 =?us-ascii?Q?FePY3KfpwSZc22YPU8nPIibRBpEeVMHk8gYcK8MPKpyisVoY7w09TYhFuW+H?=
 =?us-ascii?Q?dsM1GW9MQwDwoOJp4G4tQ/jvFuD4kVUSyfq6psKuYe+g5Uq71Ecv5qp5uCGa?=
 =?us-ascii?Q?XGsdXYC89eZiBRcxGNHVwzMNcC8LQ3/sYsKwTLEUesrzeWgpvkD3Vx46x41r?=
 =?us-ascii?Q?69Dp7rdn72g9wL8gtjF5rRZRRwZmoXYEk4r6PPCgXIsEX2ee6ywSbxSVYnAF?=
 =?us-ascii?Q?qFiD/KuPS+xan5KhnVF9CxGj1aOUL/DlABLFS3emxwfxsKZrUKElO7z6uNqT?=
 =?us-ascii?Q?Zb4QMFBk9XKSgGpCeFqaLAieRIQGVSZ0ffHQaWSIwM8U8rHdlS6sBvIMOn9Z?=
 =?us-ascii?Q?bw2kvT1KM0b6PfbvM+POQp4sQ+HuzZM3sbgO6YKy2ZT3mevdHd/s2gc8Ryh+?=
 =?us-ascii?Q?E0WUrt6oWwBDvrUKe0t3LTw0QkeLxpYpQj7hlTSRtm1QBij0in+gQFsIcpy9?=
 =?us-ascii?Q?gnwGtp92yOdhrk5GxLg1RQMtc/MO8Ay7hKSWf/gmt7FgxWPutiRHIdjPmCff?=
 =?us-ascii?Q?JvlZ1wCnsGrcIRy0TSlEQ4nOHJbtsLdaBW7jtSNMKEQf3mCaVE+UgXGcbnEl?=
 =?us-ascii?Q?rBleSwgH9o/qL85IKqMe5y/apSNGkYvz2I3bcegSKpZpcJ/6+s310dzTlrPz?=
 =?us-ascii?Q?3OeDb2tyG1cxtOsgIKturCDYvtF2obyPfJ0E0Q9g7dvRZacoS2QDQTdcwCGW?=
 =?us-ascii?Q?pWg/rAqwe5aFz+DH+v+xYveI468N/s/rIv2/T4P9dvsCP/8YZ3Tu881aQ0Se?=
 =?us-ascii?Q?4OlFT4OZBzUkAawYVEGXvSW+MSGyU2pC0k3lPlvAIH0CA5jqHfKJKxkxP80P?=
 =?us-ascii?Q?mFLANtAYkwLwHXXCb1GKeJP1V1ad48ePsFDuMagaNEk2ZRu8+W5c4ZV4JiJJ?=
 =?us-ascii?Q?fiQkMlZBhA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hHWNeQKfloARmbfBE8ndDBmQyThQc8riQjhdNIkFoBzfuV/14Faxa8Z/PIVtY0NqGZgZim54bD9oRPgezdzFiq78ATo59S1OiFt3kN4tKdqVUFOr1E67sbVJwgb2l5XMzlHR0066+zQNt6BeSuJLfaaxktgwuXyceyoltf1phx5qenWe7FDYIaxN2vEjfdNzPgYb+D7xFrx4kOxQCYwEKO8XhUjacZwzFCPo68OP6klN3AjR47egpA5RIKfr+2FDJue/OTCkitjB5iEzgRC+kAW727kL3t5BAor6p9jMvCClkPk+vHHtF1HurUtVKYyo9IRQKDTK+XY44gl/lrKCZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f96c69-d411-447b-5151-08de8ef5e32d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:19:46.2128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIf1C4scDFz5wwQY3+sFLKHkE6MNIyVzD5WI3qRwyykWR+ajzOInYENMImsnbDqMXk+rIxpCFAuSVI+Ej8Ptag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com

> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Monday, March 30, 2026 6:11 PM
>=20
> Add test case for dirty tracking on a domain attached to PASID, also
> confirm attachment to PASID fail if device doesn't support dirty tracking=
.
>=20
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
