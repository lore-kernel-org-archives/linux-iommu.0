Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFCD33F8C5
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059761; cv=fail; b=H4cxnLzstMdNnuzYMpo875Jlub36TwlfBysp/PReE+X8WoMrxUUw419bhsc8gEA6VWQ9YJBkHMXVT0CnFrulhB2yCNacythWLSgCBIbpSX8owMN7hHZlJsmPGe3zuHOJr/v8kbjYzYlWtzLErJ+3kj7gedqtYU2eG6O5loVVtNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059761; c=relaxed/simple;
	bh=6pf7+cv2kpzrtz7hRmcU10uKhKTHzuIKFF0gB+wNN88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o84jFg1jQGswmiNW+UjtuumL+R7boWKpMDajejKNgOCxXMczlaiKun2t+DCHVvCgYe+2c6cvLmTA0+ZquqeWDhyO9XFPZ/lXFl4cav7jJePLeEnP5nZj9++y2HYUgOCww3sDz9LeToIk3yejRXOOCFhIwB/I0KDJsNyF0cmab3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mascs/FO; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mascs/FO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783059760; x=1814595760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6pf7+cv2kpzrtz7hRmcU10uKhKTHzuIKFF0gB+wNN88=;
  b=Mascs/FO51ZQaiCAyy48XLSLJUmFfC679X0hk985pB4Wu+NRThsOUJnh
   Zw4U76sxVkGEBsDEnh9Cz8UbNcN1N2zRL8te1ZXDF9p4EBgGTy9ud2Eci
   ctvyxYxE+cfHr1BmD5UOrFirFeWfZ1fO+Xx4UD59S+wzKIcLvEPz1Sczf
   5aBJ4JagZ6RYg1CtiKRynk46mGw3BoZMZooKX4hKmIA5g46u8tow7rgyz
   QCWGcrvqnaAZfoCDifbdVQql2jgswO1ywjJn9ryKxdrkw0nRHZk8Jxj7H
   q7QXrPhqEXJjgTyjA1ns3btlMFsNdgzqisHCssmY0ZPoLiohob8H3CE5v
   A==;
X-CSE-ConnectionGUID: IXfOocZPRTy2VpKIbEsDwQ==
X-CSE-MsgGUID: 4eQ2AF4VTj6ZNqo1gzrGQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="109356633"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="109356633"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:22:39 -0700
X-CSE-ConnectionGUID: Lz4IVKNvSuePuG6/T2wSOw==
X-CSE-MsgGUID: YPHNmTumTqO6CyK1Ux+SiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="257366732"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:22:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:22:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 23:22:35 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:22:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfYSXyKKaWDo0CRPQ6aLi/zHRFwxf7KLQ4wt49I4zJhhYPgfJu/OZW4yq9zXBTFtZp120Psyqtshv+z+BfvaHts2wHjADvPwYHcJtgQ3NvLIwVoCvsHcHsk6b6Ss32WM2GzqRGu1TiCIWR1zA/KnNrWqKPALyovLpGwSG0tv7BnBV/7f8gU0POywFcuxrLbcgkvuXKwYEfZV1ejwa83Mv9qwpC3SF5JMgVyPV4RpBhRlSPiwVJNxZseG1JsQwYXXYmESRNH5lkTZiyqT8EWts/MbW25FY+cDuw1ZzAygBK9bGM19OUXKIb7tW10npPxh9dOLhgHokD8u9PSqe9LqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLUgc1dIxQ8zpPf+Lth8u+VgGauojS++bdW8iJNH2IU=;
 b=rOjwoKpaPD1GvY3tFx6/cXgUERt8KXCRs9Wsl3wJYxVjB25FvmlZJAv6rHZRcYA9I3CpaEjQF/F0DW4rfjlVN97louCNzKjLfdg9DHl1VZflioqcbTJVqg52GyLIbBHWEY1XZJV6ByGRsWzTqk2tAkj3Tc5tir4e7ofriVe4fK5W/EpJY8Kp47EsxPHEffmpi2YqeFA240cBEzKgTZcUeZxR3C9LQsINQYTm6LKLXF5jy1REoF+y3wo5Ca87mCVXXVpN8lIZKmH1CDJvAJvUhw8U58MU70k8Q24BecC7aTV17drLMUy8G92wLea+y4XR4Q6Km2D1Pmd247jUa6MQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:22:32 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:22:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 3/5] iommufd/selftest: Convert cache invalidation mocks
 to the core array loop
Thread-Topic: [PATCH v1 3/5] iommufd/selftest: Convert cache invalidation
 mocks to the core array loop
Thread-Index: AQHdCAyWrljS4ESx1Eiv1d4OolXrqLZbWGQw
Date: Fri, 3 Jul 2026 06:22:31 +0000
Message-ID: <CO1PR11MB4835D085E8C2BD6D5BED39D78CF42@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1782767398.git.nicolinc@nvidia.com>
 <0b590a04fe2d38d696d0e31e37d8afdb1b6725f2.1782767398.git.nicolinc@nvidia.com>
In-Reply-To: <0b590a04fe2d38d696d0e31e37d8afdb1b6725f2.1782767398.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|IA0PR11MB7308:EE_
x-ms-office365-filtering-correlation-id: a6977cd7-abfd-4aeb-b07d-08ded8cb7707
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|11063799006|18002099003|4143699003|5023799004|22082099003|56012099006|6133799003;
x-microsoft-antispam-message-info: lO03W9/yI59x0H5QvnlcVPLst0wUQg5zqLiY7OqMS9nxMO0POZgkvkYbaJU/gIMrOoU4RNeZDChxWPboIWb2Gf97Epnfq7BUAtwFT9RGbbV2ycUKlsHOo0wBR4F/PjgdZKQzpW/5ZPfP330kUOL6TgB9LA4t7aLj0NPE64wEUbbACJfF8hPzDRjYbIBDOXGWdA07wZtx9i1bsaWuj323gx/qwrpzytFN9R0atHFBX7FzUOKla8HjV/274emyiOLj71/GvIVxbPeIHXvsUNW6A1cjWwtBI0Sbl0iHq/W6VBXVov5yDifhyrTpKzUWi7TXt+mlk6Nu6ZAr0ai7az6dDcvOo8JaXFHxRDR8kPTbG0ZZTEadSesj52h3g2mcT5F6sOmk5Ia8k0aWhh7JIyk/NzwqdTyYcmR7uInNhz69xTY40F++EP4gJCCQAvnMheq9RlH0DvBNhaqVcgbba3S/IIAT+iVDVp8fpD/+cN+tqEh17nsvYFCpUVzho+wj0CQ5I4SX8/CLuQnil/50Rnfz8c/Is+GQ00hZBUEt+mXsas1v84nuLXiRYZ6/GxWKUnnuwEhtWpqz+x+6EqSEFxVesw4YBXy/cTgdG8nJXlFCmXw/Y2mkTWnuqr/GH+ethvrMprP/vkxCHiWJEWfhAOrxSq0ZH0UBavjcQLtG5LQ+TojTBcCjeFUvSWRIqQrhua29s3WO73DLc/uIDmHvPKOebK+RJsESvyT1rzfzIqqHQZ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(11063799006)(18002099003)(4143699003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IAWWWl+71/7LxwKp+gqPp3m9riEWWbRrYmDkzA9cvJJfhfBvGU/7+8eW9hgW?=
 =?us-ascii?Q?kL0EZ0ipCwd14Q07XiVXVSjAfOOweXOlgXfPbkhwTxucP+H1hDTCBM/S0k2/?=
 =?us-ascii?Q?nqf6c0D7S9oNMa01GAmpZ2N5V1MF8yfwtbqvErP0FhvmOksoOTN14LpLeAzF?=
 =?us-ascii?Q?tzx5b/BiG/cV2jcs3Ldu9rqqDnEC8E6oY7+C+gnmiF3P6txYqRWmPj5msGna?=
 =?us-ascii?Q?2n0u0o4hLSDqfH9Bc0Yw88oqvx6cST4lAObMXDLTxQIX85NT3y4bR+SXvaXP?=
 =?us-ascii?Q?kduebO7p9Zrunbki/EOb0TmVqU5036kLZygVpeoQBdp9jZsQDFO7ZkKQqDJ9?=
 =?us-ascii?Q?2Ud77mKZklMWqSZG0AMCLI4rjmFryfzAK28Z0/7JVolMoUx+ia5lzlf2Xduf?=
 =?us-ascii?Q?nulubKHEKIkQ6vS+AvXMeJYQT+ucHPGGhnfAjmIhV0e4rHO4keSJn3QMFcg0?=
 =?us-ascii?Q?D/JizqKgZI4UZGTnBlTVcC1VQFAXTxflxYkjuUkdor1X5GHLQf6z8nWJVWZz?=
 =?us-ascii?Q?wIkxYQDU8QHCDQUhV6Opio1lSvvfrSD1XCbaO/4paoFHWMoc9Pho8WkVoij9?=
 =?us-ascii?Q?wNgvuGx8pYSApIL0ePDtuRL/F6FjbY07v6CPL3j3kgCkYwa2PAoG+qyucBLg?=
 =?us-ascii?Q?gLSBFH+PlzNvxDZlJywmb/i8dJGwgFqLy/AeD6T+g5cEcZmhMSG0Fx7ZHKGw?=
 =?us-ascii?Q?M2Tmms4ONtwPLvfzOEcG+sys9nczQDxUdrxEy5Y4BOTF3vk8kOgHHx/XV+Xu?=
 =?us-ascii?Q?bdppWUrwIKTPq6TKCX1w+EdrfYHxBfMathIHoF0U0riZnrFERGnDq9MmTMkC?=
 =?us-ascii?Q?zGHOUI+jXQzUl2yQLZmcnoVhUS5fYhAkHGcJwON+HJ9jxTK4sAevlunXxuVH?=
 =?us-ascii?Q?7vf3Qxc4fSxo2LPmgmdHpTEMfm89vckN2hMPnG/RnKW9daw9YDZwPTx/OG1c?=
 =?us-ascii?Q?BxfDR6zZWMNicsrknZUXzB5EfdGGnG47poF6aFilbLsmkO0gN3oJs9be3EDR?=
 =?us-ascii?Q?/Dh7Z89Dol1nDJJQqYgr8PUye9TkAYDclAsx4OnX7yCEJDGdZ/NPwr6RGnCt?=
 =?us-ascii?Q?TUjmRkTZVQ4YEyJTZ2xmP4k+hrPyq2/pa0JBirBxHDi6ttSHDozXnlfuLb17?=
 =?us-ascii?Q?IKwaPn9fhN85Pk1ZSnnq1A5YjThM3Zete1kA7wG14XgGdxmZDKhubWyYb/ch?=
 =?us-ascii?Q?auW5PISpuvjSfs/LrFhfBH135cqGNH9RDxiuk6L4ptX4k2yZf1LCnS6VKA/P?=
 =?us-ascii?Q?Y5AL6eZb43RtAAAgdVHrs9SJDsK09eYAwdZst0W7mAUiAwFw9CPlN6cSYMED?=
 =?us-ascii?Q?ts+leObMxoiNmNMS0UgWjwpSaidohw0DOjtQLbxejqUzqVU9cvQdK/IUniHu?=
 =?us-ascii?Q?3SID+PfFKmraXsYfeVrsJ8JR1BHpI1kZGMyzFEPnZM8nhk0Qy6JV1YPk2yA4?=
 =?us-ascii?Q?OFodOlExuoP+mEhko0zRWjCI7Btlr83lHCr707wviq7tn0QCkiD+5vp6GNKs?=
 =?us-ascii?Q?Zw3bF/xyPaal3/jPyN6SeIW/vwt6RpoLA2XFXRVOGXgU38vyrT79DgGVJaNS?=
 =?us-ascii?Q?6LupMYUENbfd9uellcbJ26ETVvK6CJlJ/55nXettaIsMYky0y8OYPJSYk9O1?=
 =?us-ascii?Q?IQ+QpTe/u6ZKxRr3U6l2OUu92dGSlDe3ct9c2E6SfEZkqMCTQlQbzRWMMBH8?=
 =?us-ascii?Q?hu/nm0nTajKJ6gZ1eNW191jNIAuCQZCpVX6roa9FXjNUL9i/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BY/z12Q3OLUVsWxdYjYXLquwfzfeVvT1ysRGXuV2AQ5AC5DQBB0d/V/tlIs16WO4ncbqHVsr+j2s6od9E0ompVfkHLcqGu892C0aBaLgs/L0cqQWV16JKMh7WP+vPRkvw+rmBarLgCUXSYPalxvPt10yVPaUVH+0JlrPoYqOWmFI6+oa6R0G21sWEccQj/wrJstZVLy4U5JkWkQ/ZjjhJua3pDl3CKiKoEKZs5rRo/Sf2jnZHbElDO7gCi+wt07N/nuP+lCrSBhaRAeq9UneMRxtWRQyy9K6viDKna1k9lB5kb+nEfrWU3YnzkGzwp6oM0lSXVJsIwLMPxLeBOAmTQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6977cd7-abfd-4aeb-b07d-08ded8cb7707
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:22:31.9519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8ksiONz0dOu6ed/yOM6BhRalr+1/XGH15bSWQTV+TpU9/TWyMqHRENrGIJPrsh68o7dCnVc6s9s2ATcxLgtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, June 30, 2026 5:16 AM
>
> +	/*
> +	 * The core re-invokes this op for the remaining requests, so handle
> one
> +	 * request per call. A zero-length array only probes the type,
> validated
> +	 * above.
> +	 */
> +	if (!array->entry_num)
> +		goto out;
>=20

it's clearer to directly return 0 here.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
