Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5416D4E6
	for <iommu@lists.linux.dev>; Wed, 31 Jul 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412261; cv=fail; b=rGB8mMAoqp0CEuy2FliLDfeD34Xmxh8u/b68ADxY7DsXITdpdfUEqHmvIZRqTK5l7f6tKAoEaPeIA1Z7NOU/EzPcm/NqgbeqOhvIfB8hXeqgV6/4yM0qqE0o6HUTn/WV4akZcxq2l0AI7wvp6RNnWVAuuOaXp8eoLoK8toffgJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412261; c=relaxed/simple;
	bh=/ULR+3xbApWQVIvRu8VOntB4k7KNq5KzIt+hWslgZNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ln/yG1xysF8UJOh602m8KX7MCgQheqhqZ6uUWGSktMjznPn5FROEwUIxo7IVAHolFcutf0hMTvxGjJn3XmSbVZ3bdTAo5ZIMRE5W3AjfQ8sg6KLGKAmfRKtXSKHhGdu43yjKkdV5Iwk+UNJ7QyjdEYAGOnb/V90C4d+TWSFjB/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjdjbhwQ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjdjbhwQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722412259; x=1753948259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ULR+3xbApWQVIvRu8VOntB4k7KNq5KzIt+hWslgZNo=;
  b=kjdjbhwQX88AhAQ7w6JEFInFy55ZbDIpu4dRWBYIrgAygKBn8vE9B4gk
   p778oknIfd0AM9Vcj9ZfMW/HOBYE93VHEkTRm2udOA7gxD0CcpMbECIGy
   PG/l6dVuKV3ufxRF2BL9AymVAk/VpABe9gZRx/03VqCZ3T9OgqzpKxSAK
   P4e1FAx8uiJBjicPZyi25IBx1j1xY/nCrGEg4PkB47ZPGf4FK8hr1zcqB
   F151g+swxUPYNpnaD77if20n7ay0ZfMcyR2pPjYDhpICunNr7L65Z82u2
   u4bMX8TBBF7qElCTPmIg54Xa5nGR8IEOnvswTweSzz9Nw4TY33IeyFmQL
   A==;
X-CSE-ConnectionGUID: ODQnjiagR2WjBYJvvkORVg==
X-CSE-MsgGUID: eSk8k8R0RCq/besjPSaEeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="37787209"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="37787209"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 00:50:59 -0700
X-CSE-ConnectionGUID: HDkZvC4/QEKklLZuQRlI9A==
X-CSE-MsgGUID: UKT8UHr/QpikR3ILFEq74A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="54852719"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 00:50:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 00:50:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 00:50:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 00:50:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuuM3XsME3exI2lJDvDDTvEGeecwpFvnoPdTsW6HvyHJzWKlWsoHg7UMmG6stHxDJQUkT+W5EEykftvn3m7nWEchIBjKlSMSXM2L3KQSQr2KePrXsJDoF0o3kxzXSGGtiWphc9AOiGkyddjIX9gqpHrLpcbfPEZO01hfDoa0Q5dfg7kw3RXUWEayLK3I5fJz5q5+6/T+BzzJaMcOl2Kw3F33FkTWY2ughSyisfb6Cghw5vfwI+lxxeCeHRa42dd1AwEdWsIfRRmvPxV/QASLlmpy6IIr3bvpwNgx8cLmzg6GiRwX34+dAz7J9n3IBFm6ULXbSgSVLKTtuuiQkBTUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ULR+3xbApWQVIvRu8VOntB4k7KNq5KzIt+hWslgZNo=;
 b=kkymZlUPU7fNhft3YZEQafqBiRXbSucekQOyytMFvcmnkjCZVOCSBdghzkG5TUMirT5LkpA7nqB3oXmbT6jQ3EkUcCDZfDUQHde3BapgfSNKX7s+5672oaikAShFiqK86/NTBAJy3+MGlIS6pQfYPut7nwVA89P8kSVKijg+p4KvHObzIgzj93S5AzZjBSYHZHwyuQCAyE/yrqT+rkX6XZDZhnyeoy7zQNfGmrSRIqnsXgC+rK2voj3jIJo0sdJzMZ24N3e9YSf0qag/hqNgjWjnGR8Ik2PZK2T94FlIOSzaozWlXFrW1n740kVFBrRljI7raitLUvZq5Gn9XpI1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6329.namprd11.prod.outlook.com (2603:10b6:510:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 07:50:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 07:50:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Thread-Topic: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Thread-Index: AQHa4UkZdMuTQ3BgnUqTgvFTxUSDHrIOBpsAgAAcOgCAAlZEcA==
Date: Wed, 31 Jul 2024 07:50:53 +0000
Message-ID: <BN9PR11MB5276B125671FEC70EDAFF50C8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
 <20240729182446.GH3371438@nvidia.com> <Zqf2HFUf/75hRcUU@Asurada-Nvidia>
In-Reply-To: <Zqf2HFUf/75hRcUU@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6329:EE_
x-ms-office365-filtering-correlation-id: 13db5218-c4df-49d7-5d67-08dcb135814b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jkGJzvNuyCgmJEXX/ElPTgsY9jBImYV/HKRJGtUHxc5GkzwKpHub6WoaHrsD?=
 =?us-ascii?Q?pwFdbhvHvOy2e/1C3sxfJulEFfaLxEwtpj5rfOg+SN4/E+/1+I5cBE+E7DLo?=
 =?us-ascii?Q?GUAf+0bfIcduGjrdFB5oVmtCZ2QDoZITBtIJImRNEgG6fHqbJnLYfbcn3JDh?=
 =?us-ascii?Q?PhD1nbomEjiGhTY2KwMHq9w1yaKdqKmYSLqDf52P8kxNMBLI6AKkFkN8wD4F?=
 =?us-ascii?Q?8mzcfPrxUdGLJJ4c4+svNV7SLF71xsKish/ij9IBVaDgT8t7ncnbjH85a+/E?=
 =?us-ascii?Q?mq6IB4FC+TvEKWiKtL64Uk8RELDBSruKLsayYHqYtWcbZiAWY/PAdmVGuAtV?=
 =?us-ascii?Q?rP+zpWmZynoaIYP/C4cKZEamXknsk+g/HDzG7bmO6R4dOMZkHt/K3V9P3yev?=
 =?us-ascii?Q?uBlZyNzlCPGEz7gO2l4bF7QlKBBJDZI5Xj8/N/SPxvx+BnuJq+D2tF5Rt4tM?=
 =?us-ascii?Q?qtxQ8USkgkQWk3sbZq9VwQfGmX33YvzE8OWUqSbWXdvFJGtDpLaqoJ0Jd/Qq?=
 =?us-ascii?Q?xrDhG8zVUc46KRCNClBtvi1GrOgwurG+86pkITxBKd5Imq/bGwicflofyems?=
 =?us-ascii?Q?9TbeO05xhMHpwZMnNPlJi42Eb/Bfe4Nh9m3JLuJQsGw8VTI1VMCHPAaRlwF+?=
 =?us-ascii?Q?EsqUO/tew8n2n4DkgGcYkYrmJtPCcPKOI3QrQWW8u83da0PYJRmui0DLNAUG?=
 =?us-ascii?Q?dusrUVgOOnMoeKowIsrxfb6H4OCme5RT+VcBQ/wo1LtF18XQ5gtkcdNpz4T4?=
 =?us-ascii?Q?eeFy/WkBQvx6PYWkAC0n2azq0pn8Pg6nJQqz3wecjqhuHYsWHDlTIVISTQXa?=
 =?us-ascii?Q?o+1WTNUNjTPNzXBlPGmK4A7FOhLLpR+qDWbgAI0QYhHdCXfDu43GCIIPf0oR?=
 =?us-ascii?Q?3LlQfaM6ajqFkEm/CEswiHl6NYXdYgZAjmXPTczsAES3QvJD5Cg6trSUHZGA?=
 =?us-ascii?Q?Qknm0E11FhYIF+7hAhJWTZZJmWC8J0GwoxdayJ6z4l+2W4GF0+CwAbZbRU96?=
 =?us-ascii?Q?DvvqU9KQpHEH0x/2SoU3vlMYRlwH8pkZd0LKi+DAwEYeEMaFA/4RuL5rXNwe?=
 =?us-ascii?Q?ch8rDDm8+G7gUzButvOWNBpymeHxc5g2v0xIf84ItnJ1AniNJ+B9QGBc8MGQ?=
 =?us-ascii?Q?ow94+vlVRS7+zHzgh8STHmJIE61dqGtmzPQ49RHB7Nxn0Lj3Rq65lhpxThJQ?=
 =?us-ascii?Q?mYVBx+tNpYsK5fQczdscvuNf6XQDC1x/UfklxEy3nQyqYkGiahKTIA7WYsNW?=
 =?us-ascii?Q?b4C2WnGr5JVUyjHnllGgcZDIlBiOYVAFKiVTczGJ2vnkjzwKRNTlY4TREObG?=
 =?us-ascii?Q?kEbIT/Hjz8eRK395Y5bFWctZqPjaUUb4Z1v43yXi5UTI7QXc6Ak/k74qCJr1?=
 =?us-ascii?Q?mOd2ijyn0OrqAa4GL3w7A4t/3TpBUIBmHicTaXch8VqoJppqzw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YM2d8TxQnnbN6uHUODmfONvN+wrs2i/svoWrD48ktZ+yD7irTmZrG/rR2s8B?=
 =?us-ascii?Q?ZbANuF6KLcqYsEhI3jf1bSeNO6mpJSTeGh534zHhudWyN8I68PC2VCQR8Kbs?=
 =?us-ascii?Q?TVMwExCgOQopk4siPYWHXd/Lz4XeLDVwxc/C3q7uehx1MEMNFas0y4N5GHIb?=
 =?us-ascii?Q?ZPi4Al/5mQk4bSXoVKNpOP455S4DEtHkElgnwDyBjdemOpxumfmWEgYVSjOi?=
 =?us-ascii?Q?ZDsyc2X/spiDD5IctivwS/SVMUt0WHUGtbtdYxENQeR8f0kz3F69IixgI/Cc?=
 =?us-ascii?Q?pHRGfQ9MiRXVqASYBa4pKlxSEd4tiQ7ym0YI3nOopUeyAiA6ztcmPphbSlNI?=
 =?us-ascii?Q?qbIXRr5mM51Zd2ssHDj/QX2/9JjTHUFw0dCZlxKwQtMmup9syw7tkECi6K4E?=
 =?us-ascii?Q?+CR0+z7udgraucNd8wl8qanxQ6fxIE8wJkmdZKO33mz7mTRd7t5hm9Ee65uo?=
 =?us-ascii?Q?nB8dW+ANBrrK3xbt7kTYHuvbixJC0jGa8iigwFxRVM7o4OKd3eFWs3OdtamA?=
 =?us-ascii?Q?2DFB9SYHxMLGs8JHqwswAdhYc7lFoE8erDVDlMMym0bvoiyRf33LFQ7NxSus?=
 =?us-ascii?Q?+B40uLWlIK1Sv90gPwlrciB1ruHpTHDbwglYBwp/Z5XnBDoLpTebJ3MTSLkB?=
 =?us-ascii?Q?zq1tnmyB9KI0zlyse9Md3PGSTqs4bHf3DoqTHDkzzsVicOWcPzN2BDK/j7tB?=
 =?us-ascii?Q?tniVqr+Rxm1sK6Y571jmyQekaDZZ01sF191Q1AVAJJ7qkCEw4lkH8mK7uKS3?=
 =?us-ascii?Q?2Akr0Z12g01MQab/Nh4eJA1Zqr26PS6PDYNGo/AqYV9gLS/Lz1IrStEMxJ3u?=
 =?us-ascii?Q?Ibt2Yh+GJBKUg6h9CSjVL7K9YMOt7YnZKD3SKG9z6zBeCHGOruLQ/Yqfrloy?=
 =?us-ascii?Q?j1v4VuTxtxe3MxL5Nnt6IuAD6U4qTQMLqoQVOR2GEBrnt43YsPPNdLXEHNq7?=
 =?us-ascii?Q?mDn0ld21ZAYTCL/M0H41dEBCrDtpehyDTMWSXKiUMOZpdJqpQY1sJtt3yLGb?=
 =?us-ascii?Q?Ke1SalX3MiUqUtwo4eY20FAjJGus44abBrWWRJXRzY1di01g+Z/39KTsPqOy?=
 =?us-ascii?Q?MxNB84V7sdAZVZEeiKC/BGPphKlu+077lgdCrB9luzvTX+cyIdqizryqIof0?=
 =?us-ascii?Q?MJCRWAAN9VPWn2Gqx5/Hcc+9+dbya4692J+rFnFwLTmvOmRbuR8Fc53VTepP?=
 =?us-ascii?Q?UU0kfiH7D+IQTj32yJU6pilIrGJ2AKZu5PUei5C1moDp5nGrjf/jyTZNeVc2?=
 =?us-ascii?Q?C7BnuXR0p1YUx5pEVJ2piJeq2Ps8sFhA/yYk5tqNvJjSYCqn4cnzuoKCrLZf?=
 =?us-ascii?Q?VrN5Jtpabyd7dtj/iOxv21SbStWQU3L4j4fwTjQwKNDDteir/4SRDEOz8uwE?=
 =?us-ascii?Q?uFJamTIvkH2zkb3ZiVWxIp+Vw2XHTCqAwp6hCZNuV81n43b1FocNg/0YBZa8?=
 =?us-ascii?Q?O6jTQh2dMg4U6Gg5mq6S/nNufw/A2YCfXMwnZwwEI9J5Gia+f6ugk3fgNXt7?=
 =?us-ascii?Q?DkpcS9a0tpuRmUzShktbMv7j8zL58kDwfhO6Np/v3wFh+W9iXrhd3sQeDs0C?=
 =?us-ascii?Q?tF4BtN8Nwy2n24k2UbrWT1f1XOs+7FB7854AF2WP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13db5218-c4df-49d7-5d67-08dcb135814b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 07:50:53.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPcPbFjDd20a5+Sds0p3fo1ABZwgO+BF8dfVAtKhJ+5ZoaZvWfE/LKXthqEb94bV7s5LtX6+7yWGEL/cCuQEBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6329
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, July 30, 2024 4:06 AM
>=20
> On Mon, Jul 29, 2024 at 03:24:46PM -0300, Jason Gunthorpe wrote:
> > On Sun, Jul 28, 2024 at 04:51:06PM -0700, Nicolin Chen wrote:
> > > IOMMU_RESV_SW_MSI is a unique region defined by an IOMMU driver.
> Though it
> > > is eventually used by a device for address translation to an MSI loca=
tion
> > > (including nested cases), practically it is a universal region across=
 all
> > > domains allocated for the IOMMU that defines it.
> > >
> > > Currently IOMMUFD core fetches and reserves the region during an
> attach to
> > > an hwpt_paging. It works with a hwpt_paging-only case, but might not
> work
> > > with a nested case where a device could directly attach to a hwpt_nes=
ted,
> > > bypassing the hwpt_paging attachment.
> >
> > Well, it does this because the attach is the only place where we have
> > *all* the devices available.
> >
> > Doing it doing allocation means you get only one device.
> >
> > So, I'd imagine more like we allocate the MSI region during allocation
> > for the device specific during allocation
> >
> > But continue to enforce that every attached device also has its MSI
> > region allocated.. Which probably just means checking that the
> > driver's reported MSI address is the same as the address during
> > allocation?
>=20
> The idea here is to treat IOMMU_RESV_SW_MSI as a per-IOMMU thing
> v.s. a per-device thing, because it's defined by SW for an IOMMU
> that doesn't have a HW MSI window. In another word, devices don't
> really matter, so long as we know which IOMMU that can be decided
> by any "one device".
>=20

The problem is that the entire reserved region interface in IOMMU is
per-device, leaving the room that though IOMMU_RESV_SW_MSI
is per-IOMMU on existing platforms there might be a new
implementation future with per-device difference.

Then we'll have trouble in the callers which assume a specific type
is per-IOMMU.

If we really want to go this route I wonder whether a per-IOMMU
get_resv_regions() API should first exist then there is a clear definition
what types are per-IOMMU and what are not.
