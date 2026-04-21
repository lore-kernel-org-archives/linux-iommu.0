Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEBD37DE84
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776758668; cv=fail; b=nIbssxUlZ+uC0OJ9514LCWAHPbWwKy7bHWGwoH5JMuilvdNnJ/Ny6dKXtxL3odjRsSO91872kklk+JyAnzGwwn3nUY9czCNLSzeuvatAUAQUxOhWXflcSjdR9K6Q7Ss0SCQZEaqjaSDSivtZhVRnXYdBTm+3V1nBCuis8onyJdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776758668; c=relaxed/simple;
	bh=VXC6cCaehkDyi/u9UtTFKXfiYFDaOsxYqBwmG9oHHqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCpYP9ROAEAoahP2wQpCb1XTdsenePVpVp9T7QMfIQAky6HUNumY+B2lA0+9TjfI9p6As2H3Ia7xXBKxyA7/JVj/FujQ+VyyLlglgm6OWEA09kOvIpW1TzbRtynL/7ykPJ6NMf2C/AyqTA918zcA0CycfhtgXVNo8YzirU+FAhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsXjq6I1; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsXjq6I1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776758666; x=1808294666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VXC6cCaehkDyi/u9UtTFKXfiYFDaOsxYqBwmG9oHHqc=;
  b=HsXjq6I1M7NK7a4/8FFN5QpIvwM3xW0I9iU4qEQZOfmwGAE5lhrK3hJB
   xnhL77C1i8wWbChp48klgIHiFVFPbPY++Ar/8dy5lSWeEA8JrV7ot1gyy
   UDGm1t6Lqmred7kDqsf6J64MK9lbT84fvDGOM03T8VB25YlMGWBn4wyCk
   +xLqxOTsW06xPAP1r11kzR/LmpVgfJCidARa01jjINuSQh/i5RZE6D38z
   H0yqZx8lzaq4kbiLIBVzxfkDnFWkJY1Kja+s7hH/+WpFRaUv7N8fm9KWY
   W8ZhGXW42qtZBexyaCFEzZs4/Di9OsrfUisbapTjsai/kBL7ZoHgu4GII
   A==;
X-CSE-ConnectionGUID: akQhLlYuTnWYPnubPCJElg==
X-CSE-MsgGUID: GhiO5LufSZ6b5JdD0pLkPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88384334"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="88384334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 01:04:26 -0700
X-CSE-ConnectionGUID: KpGi2yoPR1G7yUTNV2WxUg==
X-CSE-MsgGUID: Nm9zgKibSsCHQlA0x1tLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="235984713"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 01:04:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 01:04:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 01:04:24 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 01:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTMmCimW8gmnUWr2uot1zqffi99z9ZfbYEx/yHiMb5msJqspogLNBMsQahigbyTW950BU5DT2VyRqhGlACM4IvoQ2rx7N32WbcRp58HWuuHG2DD9H4nbtLrlZrAkkMNPUgUYBBf2vhtUSv9se5imyAQklY/niArBUEizHFzsE/GfLqBXuOBWSsAkvHb1xID2e8bipzHtJTAgEFxsiAiXUj9rS5krBegbFU5mOU9qgIFyLyYfDPJWSIA0IALUXBEmPp1TEA5FOpLkckm/EZ4f5OC6nmBTzyX037sddlwbIBHZjiJE2jxEZ0nJRWRs8Fxo114kg41acdlKWQoLGVHavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibka3ZQykaUgld7b9M4YG4Ovi3tMT2YV59LvUFplmVE=;
 b=Gwd4SvcXOrRV1FRMxyNIovGRm2UxZqbViCQZgNTlVuNA6A9bOb2H8lcH6TSFtcH3KfbGZGx3XP1XRD79z09Nh/Od7eMOHZwRb6QQlBuXCzAtrzjiqRXCkb5fXWLKZho8ZxoHdwGH9nCnX30VSVWv0c9tm0xUFH2TYR7/3vVBRBpDC0qI9QxZH+MKhy2G6lsnA6Ytqar43YBL1Av9tmZzcT0jXuuElU5hvL9zBi3ZikLWaHjcCrbkSYgnJkhFnWeVyBloxVZbZcXDV1ZCWnlKn19lZxfXKB89HAUcOhs/+bpvPl+7R1DKVgZIXW61OCfYX6t+RVk2cXtZcRxgJzfIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:04:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:04:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joerg
 Roedel" <jroedel@suse.de>
Subject: RE: [PATCH] iommu/vt-d: Fix oops due to out of scope access
Thread-Topic: [PATCH] iommu/vt-d: Fix oops due to out of scope access
Thread-Index: AQHc0Tzt2i1NCW1ce0OGS4Z84rLvJ7XpJ64g
Date: Tue, 21 Apr 2026 08:04:15 +0000
Message-ID: <BN9PR11MB5276573397EB4D4DD8820ED98C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260421031347.1408890-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260421031347.1408890-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4964:EE_
x-ms-office365-filtering-correlation-id: 9872aa88-b659-42f6-f1e8-08de9f7c9521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: IOvfVsHGzUbAMmHIMkciZH2lGRmK5mJpdJhTe3TZ11Q7ff4pO46hEWUKp9I7tyc/bHcT2Bjaj9N5o9sEVavZeZDSBqi/uNw8OJCvavNhmcTMcI/QTuKjhwk1VDkxPO7wQkTKqSYGSI2f4veiCVXHneVLRVrxliSeCqcPmK83aGJTSwrx5T0xVOP4wcmDrhAye+YEn/n7Ea+tEuKnpvu/HueXIH7xGnTqH636NAwdBiGdufPJdLY240u7boAjuo4yVakXbzzA1Q1HsNQdiTEUyBVDDh5vcqAhwYyyovnn1d45JpxbuUAxyHNS1Iw16c1w8J6+xU4yF8lLgtYPyDnnbkb3sYCiAPV6JaM8cevPU6MwtPV3TXDKCBHjYDMfp0IOrNHHnkZqNCtB8NDBzXv/sXeZyvwprIV8nIUsaT1L9oSMUpGGpvYfYfqgFXoj9s75prRb8kI4ifjFSLKFNJTbewVa2SlF26vmEl0dY8AGrXyNcBWkWzyHIBz6vO2lCh++6SR9ZLm9ek8gctIEAenVn7cX3qZlObHNn80LzEyiGK6OaFCEma9uxrpJuXFf7NrGxiWlx5LJqlsR2ILPTAM3BsLM7wg4IZQYKqHolOdbQz+idqAZTjrtECGSYneMoX8/FOlM0PQ1Zd/sqaxI28eAbY1ZHSEq7BZ4tH67tOMq0yO/ppJKlnZzgRK/Bk1lE4XOWNmhy1U1NU8s8yispCgNm5nww1pIVEYVPATwFFZ/EPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dhdkcOCUUJIKl3xPFAoMhf4JeGCfrnnUV5ClldNA2Hj1fP0fWucYd4vKwhm1?=
 =?us-ascii?Q?5AMMlN0t7GQNoWjK/wrwl+dMEEvMHoYy0vlfDShZKSLyRn7fCadygFx63pcL?=
 =?us-ascii?Q?GVSOLnwZ8eKNr5RV9v88y7XL5QIlKsaq40YzYBHZkp++BKNEUXzAJAyz5GkO?=
 =?us-ascii?Q?U3ujbTc5h9qhLSYP1O3uzPLArE9lcnar+tAWUPVEhklC6ohRisS6uh7NKAG6?=
 =?us-ascii?Q?QGZh9eGYvYvvorlNX/WPPwuptNBXKcMNAvM8/Zg7vA/r54wB286rN3QvCJ3n?=
 =?us-ascii?Q?5+mLeOGxzD/OCnIKvb1VeazqdkNVwngoCqU/Kn415vpEUrdXryHSCAIcCjbX?=
 =?us-ascii?Q?ldU6pDC+wN1U12hKerF+hgkkI+4pjP7msrMYne4K4O9odByEi3eNjlCUBKvf?=
 =?us-ascii?Q?t2U86nJKnO2YSQPfozFjXd3b6Mt9Wq+Q+tbhKa45gAuLm6HfEgidQqfDzZkN?=
 =?us-ascii?Q?6Tz4Mpk1pKgBf/bmpkOPjyVfMEZjKOUyL2L9MzW7ueG8GFw9TifvKqIRzPXB?=
 =?us-ascii?Q?Ia5RYKmVWAFKhtrF3LsJLZ3PnJcePDlpatJB42tUituIQyahIzMQFgGbMo30?=
 =?us-ascii?Q?0Tpmz9u/E1G9bFZhtmdHenlaAysZUfVeCa8VwLllpM33VyLtPYzLLJglRw6G?=
 =?us-ascii?Q?1MRn7305bm34LdO6eFCmnbdo1Eg6aNtaaDIFBcKVYgrYIDhoo9FhvuFI/Ll2?=
 =?us-ascii?Q?Vy9JEEKxROs4ixUr3qTOMR9RgX+DV8n0wHl7fMbIrRfTwiUiksWr7Bg4qcCt?=
 =?us-ascii?Q?5HEIGVegz036XyjGhtZ7hCAVu7UFcePmIStr1l0QsAy6eBz4sNzzpnHM9stY?=
 =?us-ascii?Q?t1Ta+gUOi0QDP7jIdiMx4gkUB0C4DzaX1XQdIvEYl5hbHRlBxwEa18bHb6kC?=
 =?us-ascii?Q?7cVemqeKQ3Kj50j/XjO5vqM+Lf2zTZZpMVoUXV7PP+iszMi3gmN/hzLDyOK5?=
 =?us-ascii?Q?f+q8XbF2bziIi2wSe1fFnVTgMLOvWxTJ0Hdka6psFnm3khOhrFyl2LVoV0/0?=
 =?us-ascii?Q?M5NQ/o6pRPmAAKoDv+QS6Vtt5/0SwVMe974gTVCYKNXNBdASwcIotdMtb89z?=
 =?us-ascii?Q?wiAksUwZ8+qAAdaP1QfWH+nEC1CkyO+WGNxdbM1dj8mCNfUPdMBKlboLzmrS?=
 =?us-ascii?Q?/kobgOi7kFE0EbHPSwyEY8VdZ/AzQmtY3Vkk5s0UFqN5dp5rnPEJZoyeRIuw?=
 =?us-ascii?Q?PI7IN/CsO8w5Q2VBSnNxeOUnnC8EOgxESsHtM0T9Ofj/gW13VY6fgecP/Gcb?=
 =?us-ascii?Q?NjmWc9JkW6VGaoT0sJs1Vw8idFP9VVjV2GoEHbriF4UZT133odmDQ4s1AHYP?=
 =?us-ascii?Q?W+c6gE52o0rYYbs15w+RX27cu/Noz7psrN7ZdICEUPgxfpA5XiYskhpLNNog?=
 =?us-ascii?Q?HWuNCC2S5glaRJXx9UHu5C/6pNLdpNdNT6OdDdtl72s24tK+pypDhZqgm3wa?=
 =?us-ascii?Q?ckzArSNThDS6PgBdYG2uKvwxzoWiMC8bo82Lt9Q2SzAjy8ch6KuDnOyGjV4p?=
 =?us-ascii?Q?uNT5Xjjxoo1boNR+RhC8b6sTulgar/HhrbFk6oDvIBTt8Whi9Rp4k0x9j3XA?=
 =?us-ascii?Q?15nF94E9eKxfvivD0H62n0KPojxmqd+68HG1usewsvMJqjZF8ypUXAQW7fHE?=
 =?us-ascii?Q?qf8ruEofQa3Ka3fd1rBu5CErx80Msx2xE+p+U+4GB7vE6hvZZUSqMnKipTpd?=
 =?us-ascii?Q?F/9qIlq5BvSbkKCPOpGNjHeSFGJ59se94/8Lv3ehb3ZFWLh/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CiHGSzRMBwl86GqYxOH7efnK4iXVu4IHm8aWL4NVAvsPEOybSvMTsvRkX+kWYKc8L2b8CS2PTjZooab6ctWJvH8Q+CNPep9Rb6xwsDQMNdQg/75MHFSFq4aeg0IDVLroWmYUmTJkR3vVpMbpsrwuNa/SEDCmnFoMdiG2TPHmybkALGQDYfyiIqtmd/yzOXD3XzJjC4vvOqnJjuKkSGRZA8XZcNkNJzoQWJIHHpHPzqmz9LtnBTXiz5G3xUpGnwJu3xePVJR5OlgIMSPnDHpwBlKvpMtdj/n18Rg0CAD7sCQP03YW5C4HsrHzNz8KdCCyq1CY0ZXNoM7lRkj2H5wXUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9872aa88-b659-42f6-f1e8-08de9f7c9521
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 08:04:15.9812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +V38qMcSiI0FY/aEIKFRfUFIi4Ye9xPmkXjoYmlIJDUrr05Hq1e4mPQ7juSy9qGmx0QmDskogeVWpBOSJ2Xefg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com

> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Tuesday, April 21, 2026 11:14 AM
>=20
> Below oops triggers when kill QEMU process:
>=20
>   Oops: general protection fault, probably for non-canonical address
> 0x7fffffff844eaaa7: 0000 [#1] SMP NOPTI
>   Call Trace:
>    <TASK>
>    do_raw_spin_lock+0xaa/0xc0
>    _raw_spin_lock_irqsave+0x21/0x40
>    domain_remove_dev_pasid+0x52/0x160
>    intel_nested_set_dev_pasid+0x1b9/0x1e0
>    __iommu_set_group_pasid+0x56/0x120
>    pci_dev_reset_iommu_done+0xe3/0x180
>    pcie_flr+0x65/0x160
>    __pci_reset_function_locked+0x5b/0x120
>    vfio_pci_core_close_device+0x63/0xe0 [vfio_pci_core]
>    vfio_df_close+0x4f/0xa0
>    vfio_df_unbind_iommufd+0x2d/0x60
>    vfio_device_fops_release+0x3e/0x40
>    __fput+0xe5/0x2c0
>    task_work_run+0x58/0xa0
>    do_exit+0x2c8/0x600
>    do_group_exit+0x2f/0xa0
>    get_signal+0x863/0x8c0
>    arch_do_signal_or_restart+0x24/0x100
>    exit_to_user_mode_loop+0x87/0x380
>    do_syscall_64+0x2ff/0x11e0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> The global static blocked domain is a dummy domain without corresponding
> dmar_domain structure, accessing beyond iommu_domain structure triggers
> oops easily. Fix it by return early in domain_remove_dev_pasid() like
> identity domain.

It's interesting why this doesn't hurt us in normal attach/detach paths...

>=20
> Fixes: 7d0c9da6c150 ("iommu/vt-d: Add set_dev_pasid callback for dma
> domain")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

btw Sashiko captured another issue in existing code. Could you help fix it =
too?

https://sashiko.dev/#/patchset/20260421031347.1408890-1-zhenzhong.duan%40in=
tel.com
