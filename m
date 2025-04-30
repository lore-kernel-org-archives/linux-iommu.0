Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312322129A
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003739; cv=fail; b=M9wmZSOmqbrOkX4khOCmu4XTaUsvCZ7dTclEoQe/gQ09Ua1aqZLV8AVYMUGHI+CJ/wjdi7ybtS9/jmVvXhiy9/oKpHuiJ7EpW9z8do/zLZiPEnW15SlPEW5pFfGU2zu/mmGyy6ugeqTszbSU4GXW7r56Bbpx79vmAFhh0d+joVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003739; c=relaxed/simple;
	bh=/up83XW9ohCtRTjtZC6RKqjnjrcQ9sfZca+q1qBjtYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WM7zu/ln2imrn4LB5KkH1Y7fX1/nwi/8KOpQYlJbvMdUnSrwRmG0Kf0dgmufi7No6qf2AuP4DZfbyiR0YXG0eSBYPjZMHOg9lNxxhOsGWY0aWawmxfY7FILLnDOwE2bnppeCd+3XttMVBBfkKMKUl9Fr76U+K4Fp5vR1TyKrQnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLQYqtxz; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLQYqtxz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746003738; x=1777539738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/up83XW9ohCtRTjtZC6RKqjnjrcQ9sfZca+q1qBjtYc=;
  b=KLQYqtxzVsPpEwp+jhuqqJI90rJeoeBNRE8ydHvGUkMRxTGlo9mvWYxl
   wqRFK0H8x9Lv2Hs2iGDY+UbgIk+6tbBlkGwlRtvW6uT7TORpEp8/4AF/a
   mD0K6SCEZrUoHK5MBopJkCsCrcXiQ2rDwXz1AW+fAgR67c98YdJqh8OLV
   ZYRDLF6ibbq35nZzOAEWkDTEEQDL7rTMH83uJnibktapayDLKGcOmNCcz
   9BDL0DNga4aHGa3M4ShqyCFNIgJrBYvXcYLx5aYtVxf2KJPKvA9LbMCW0
   mWKzKV/6Qa9X/9PJ7soU97DzlG5GcuxG8uQVLvwkfitucfalE9sbGhotG
   g==;
X-CSE-ConnectionGUID: dw2yjSCORNyr18O05ITPUQ==
X-CSE-MsgGUID: 3+cbcBLsQI6DeT58OhbiMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="35268159"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="35268159"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 02:02:16 -0700
X-CSE-ConnectionGUID: jO2yhyBBQy+s6W0egFw1rA==
X-CSE-MsgGUID: SbiajIeIRBed8pqfQA2K3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="165008941"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 02:02:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 02:02:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 02:02:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 02:02:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJFmS8FyqPqjmnMK5y4Ag3mIMsnNwnPLoNgfXMeks3Zgqv8sc9jakjhmC2XVm0bRpV8D7t6yY42xRuBHETwWLsa3QoHeMMW5b3oMc/q8LvgZ/EJap7EeX6ABQYbOjr4ERFtanHt9nFAnrkQ1eJGCvCFChX/svnjGdtmCxur6c7O4jCiwUNfpt6VWGJy+chnOkexGvDkLben1ZXQn4u/xicmRB/8T0LeumjCQG/xafxJTYGUAykLxLslgAGxz7WAthFMVEfJOdEPnq+CWQEIrgkAY/67JVFfyNItU4NPm4isGweMaQ2Ztip2BQq07JELug4ExsAiIRaebbJGsmehisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/up83XW9ohCtRTjtZC6RKqjnjrcQ9sfZca+q1qBjtYc=;
 b=cH28oJNbUixEyo3u42kxnhiDAFO24NmPjVDpprWO45yz0jf7MAYJm+tTFeRzRvMF7AM7s1jIgi/aU7iAKXa5Tm91o35jIb4Plwlw5aXjUHYVL1QnlSKgJvdADIOAXy2U57grKuWIvPKEzo9OT+N3DqDc4Qx5EknSdTeTWSuZGa90m4RKCG40pPm2XHD3MVO/GHYl29TcGh35wDgqt2uVXFh7USc1qxRT3wvMiEROUFf7OPAcsoV7ppfPlfRPv4MS/TCiyuNa8Jew7CR7Wxr8jaTQrWPaFkjhVshwqd5nO/3+mWau9aoh+NHI56LRu91qm7ttXKGnjZH5/gUNZo+UKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6911.namprd11.prod.outlook.com (2603:10b6:303:22d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 09:01:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 09:01:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu: Cleanup comments for dev_enable/disable_feat
Thread-Topic: [PATCH 1/1] iommu: Cleanup comments for dev_enable/disable_feat
Thread-Index: AQHbuXrrdDv9gPQm7UCCkaheDG8SC7O76dww
Date: Wed, 30 Apr 2025 09:01:29 +0000
Message-ID: <BN9PR11MB5276D21A9839FC066E45032D8C832@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250430025249.2371751-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250430025249.2371751-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6911:EE_
x-ms-office365-filtering-correlation-id: d8a1c0ce-0444-4dc1-21d1-08dd87c59860
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/2GN356bVs47qPJecegBU5OVCDRzefhbJJhzAouYu74uvmV6QK/KIELHs0wy?=
 =?us-ascii?Q?53UWTl7os29K4vIUsTRaB0kLLT/+BQnfDb1oKJ8pRWPNfRCoeBq6Aj2QFDyb?=
 =?us-ascii?Q?xPlwREcc1+PaWkCAbogiO9i3HbP+5AeEJw4AeTkdR1hB+fBpqJVQJlCnVRsf?=
 =?us-ascii?Q?lHtM4q3kk6Jd//5NJNmSd46YvPdgmVGTTVDed54IaXDdHz49IXwiUv+cq7wk?=
 =?us-ascii?Q?EACjAcRfk6nS5UG7vMkkyK5joCGAZ3djYgW+N5gnrLMRgDu9ofSpsfsOJrD4?=
 =?us-ascii?Q?UuHmUk6MXxelx8FY8WqXzwpSB467lbdUN+nJou5UfkTqTbrIOT2q6OtUafzL?=
 =?us-ascii?Q?RvkbHgfMnSilZobv96X5/SHDPcxT1Qw6umYimcBUKH0K5xjMcR49YrXh2AMB?=
 =?us-ascii?Q?3iUXToA+6FDk3PjRo7Ub+n1pjvceXnghdU8GwtG/kfpJLMIbKJdI7xCLzFfA?=
 =?us-ascii?Q?YPS1Hk6uDyry3+4WfJ+2QXOnk3TmlhjqUK1+ex90FV6x/jD55D69izdFZv9T?=
 =?us-ascii?Q?fjt6Z/Y3NVKhZfJ0bTKGWp3tx8sy9p+ycMqvmibukWeGJdB3c+7sZcSoxbd/?=
 =?us-ascii?Q?zFptMOaVWOvgSJUXnY++E5tZ/siLywg3u6Xc1oT4PSOdI9ag8qU6cCnZNFeq?=
 =?us-ascii?Q?VAQhJRZLP3bOnE4hLyqXNHRYS0ttw7BGOdVuI6ralgQi/ZWtOsqeyHpdtBQA?=
 =?us-ascii?Q?NBeIhPkw7zhPOjZ8GQqwms+A1KY4VaRc9axOyEDiN2gQ7b60opfqtmw9Saub?=
 =?us-ascii?Q?OnutYK4SaEoYU2MQScrXescwA6OgX6zDtm5z91jN/tpLOYMN+vzKgN6LdUoj?=
 =?us-ascii?Q?cGgUzqRXICoerDNZzpibLppU3bEm6ie332Hf8paS8bT0GikYknE0JrzJhgcL?=
 =?us-ascii?Q?D4qaRttTqrT0kivST1tPy7evh3NdDUuq5Sfd5J0+dpjuLodfh9oSN5t8gUt5?=
 =?us-ascii?Q?SWMhQCAOxLWVdAv/pt1PMihwdoewiwjdpYpiJ71A00j7ORP3pnYEqeFYjcQo?=
 =?us-ascii?Q?cX2iOcKqbx2NL7jxGniwHuxCH6MgosoJ4R3JokYg0WKLA9qk+vIGeDNRwaiM?=
 =?us-ascii?Q?Ozsxn4deseqszLgoVYMMqGxzbIHu1KuxrtwZgZ6e3WZEHtho07ucnM6UaE7Z?=
 =?us-ascii?Q?LHIGrNHvayPcB3S7vn+FiVoyKHOOBX28eGcsdt4ZTQLBH6kv30v8eydpGvoY?=
 =?us-ascii?Q?HUiAClkOD49Z96O3rmbpTQLOlWseyU2jiNkcsqoXSpXO2J1cJFYPsMzRscoh?=
 =?us-ascii?Q?oHAB+9KrfCbHfDkdsVfbZiQbUR1qSBv9h8jp8NAADatGMDiqC6hJjxfRIz+Q?=
 =?us-ascii?Q?Wan8k66sIOLId+PzCJc3FFRLI5S0ILXcI8XHWJ0zLPbtnLbmaq/mEb3O8Qrf?=
 =?us-ascii?Q?3sIN5fbBu9fSft7tcb5g0ZBJqzZmys9MCQvhQSKuVBg4RizSFIV2y3k8P0oK?=
 =?us-ascii?Q?DKJsL4UjlKlM1NFQK2Xf5kZvimwl9utkwWh2tkmRk9JPumlTC5GE8A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lT+w/gMmMKjLiZuwbwEEnX2EG9252xdFglR5OiJvYd8GWCdZObNctkc7h0OB?=
 =?us-ascii?Q?eDnSKuU1d4PoF0AqKJo4xd7Jb1cyPJ43oCJ9WZSjbGnpdHz7rG+0Si/g1a6S?=
 =?us-ascii?Q?w3rSePpC5GvNSp/uOI9XKFlz79BiAA0MX4AuPTIu+rdbhBrpll3r5yk8N3O3?=
 =?us-ascii?Q?jRPYticPN4o6S9+HE8gUFUPG1UQ3dPNbxNguEBfnKf3aHzpsqH7YqnvSf3t2?=
 =?us-ascii?Q?RfnkdJyZh5OImJiHDRw6DEKklW+Z9Yh2Lu4PZW2E9itLD7/Akrx1FtENeIPb?=
 =?us-ascii?Q?LWBx4yY8u5NDgBcPBkRunf6/XYdy5ESfdDn/WMBY7Mcaic2EmqkjIg9sp1uJ?=
 =?us-ascii?Q?O2f6GVweHp583K2bH5h78ZQSFflBTjkl7HYHQWXWLojMU2lsETtVQZ6wW5zm?=
 =?us-ascii?Q?fyl2eTLFzjRPLfwKoAzbeUKXRfiM5zeLf24n/NVaQCIApozUeZXVm7EwqkjS?=
 =?us-ascii?Q?uI/kbIdS2PY8qe6Is5MPq8rjh56tvSgt1CGYag1osoPbVa4KUeZP33WXXjEv?=
 =?us-ascii?Q?jhC1HYg9iwnM4afNolWIFqU6Hfg767FW0VKk3SDHDVAORkVDAsu7XnfprZZb?=
 =?us-ascii?Q?Xt7Ex7SmseWlw7lv0Tw+pb3Zo/CC3dQYE6VkF/bt3CjtiQMraIdutiHBxBUC?=
 =?us-ascii?Q?cSC8EzUHccfLWmMqU9bDM7MsN9EcfMBD55WRwsTA6Znpb9qYggFtRVbT/tFV?=
 =?us-ascii?Q?7CHinuSSoEpOKQyt/m+CfaPZO0ri+uGI8jWAA0F2IP6QsfXXVvsFZCjHwOhj?=
 =?us-ascii?Q?P7nncCByIu61HOPLDylAoYY8olvi1pEs2YYWsGf3Qd9v6mMLjcbr43EVUfhq?=
 =?us-ascii?Q?seiYs7QxNyAA91lXDneO6H9Az9GeUElx+lRcJFhCZMsFHGZneeXw3dsm641j?=
 =?us-ascii?Q?UASdXbu0yRPHuoCnd5MtvjdVM3cvXkw/t0kRHfUhh0H+vOp1WPAVGrW9nPaD?=
 =?us-ascii?Q?Obtl86o0l5xzSrUT7XARl9IkLZF7oRqWv6IvT6lzUl1ESszo1u34FsXPkXq8?=
 =?us-ascii?Q?FXq2Pd0ZEQHMV6p2Ja+viIVUmqdqjcbMm1rhIsuJt/+dzEKcFFUgdy8Te6bA?=
 =?us-ascii?Q?nHu407GUUE7DVhk2npvB9WVhV1lXDefE9D1VtZJ3rFgk2ofGTydeka05e7G7?=
 =?us-ascii?Q?CpcRbBKTAqMS+unyZYFUBwlaEY2+oR5rmd92N/TE8f5BNcLSoJY/ttRLQCi8?=
 =?us-ascii?Q?72CmOSUg6nfXkkQnr2O+iXYkwcjyQEGqjLRC6vn+wKkUwyMemtWGNHRNaLg+?=
 =?us-ascii?Q?BhBTGFqd/JoLa1prtU5o6VXh5E5hkEbdSJDVVqRQiRVHQKoCaSGPc/jYRO8N?=
 =?us-ascii?Q?CAh/e8T821xOmbRjLs8JDDdjB0TZrKN4oYryn9m0DGgBejaIv633v5a5OhtY?=
 =?us-ascii?Q?ORESvGd+WKNecJNlRQIzt+PfFgnP8MhSd8ee9h/J/s3vNx1u6R/QtvM6GAm1?=
 =?us-ascii?Q?8FJw81F7XVt9r/b0n2xRIu1tSLYNMvWePOxXtYOncmPiZFF6lZFaiJYQuP7/?=
 =?us-ascii?Q?7dIotYROh4fjggm8r0JdNSuNMP08+6ig0utr2oLqwrYZGnT/ToZfBL9fa/AE?=
 =?us-ascii?Q?jv/WzZ5jCixnBBBsgcLfNPTmjwDXh1PS0gLYxs3q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a1c0ce-0444-4dc1-21d1-08dd87c59860
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 09:01:29.1081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiMnDZp+f7kVYoLkx285x7YABtVMzzVfzLIf425csWBlAsnkjBY0T3bMdDc8uMrPJrqARYkLrx/272p8jyoCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6911
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 30, 2025 10:53 AM
>=20
> The dev_enable/disable_feat ops have been removed by commit
> <f984fb09e60e> ("iommu: Remove iommu_dev_enable/disable_feature()").
> Cleanup the comments to make the code clean.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
