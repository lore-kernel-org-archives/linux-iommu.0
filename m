Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255122E004
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763363596; cv=fail; b=mjkgBchaz6mffvPF4kJ0CMt8OdO/motHru9lZEz19xD+Dj3V5fH/0Sbko9P5viuM42oIeuY1BBJmd0AVWQDHIr7mtI9jpqGz+3VfZyyZj06+PE2AnUipfC688insEd2lKFsUqDNcScGkWIXBQfhaDnDtdmBb5Q09lm/5bW6Y1oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763363596; c=relaxed/simple;
	bh=AZ6m+Hk9XrIlubGsRmRVkbhSkQe0uQTJL8iPQo8/cRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KObkHLsTPHBxIisPIfpzOB9daRbCmF6DbBE/eE7qtqAgq3OP3Q9KNmV9BgU0aIGb5Q3Wl7TXDiUGXo7IjCF45cjmYBPtn7PCCasYnRMrDLiPqALY+6Y+MMc1J6dAGQgC/TGDM73WitxVSHpO8l4S4jJ417Q2mGiDAaiDuqpwl20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyTW1PeR; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyTW1PeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763363594; x=1794899594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AZ6m+Hk9XrIlubGsRmRVkbhSkQe0uQTJL8iPQo8/cRo=;
  b=UyTW1PeRAcFM2M4vKHZtPTDB+EC7IUhQ1GGAIBd7ubjMGaZmfFo6TEV2
   +xi08oShODF0L7q388mEj8DI3NgL9fZdGoxIRp8eX6OlzR2XQxzeNESeh
   NEb4+CURbu9GVloLMa6Rc5Xs0CWGFrjVzHLtDvthVfiZMs1JHMiTpmTE0
   jBSzguNh36LXktZhHeC+pA6R9/361RsWaKLMG9qC7KMm4jOHs97CNEiDa
   oU5X0RDg4kSS9XSCngjNDrY+rsRY7CSewWr3XJcI5+hp8v+VJlHKT2mly
   SUBdqIb3B1N0SHROtCLca1hIc549a+tL0RSuI8XAKiUmco5eOs/9CLOr5
   g==;
X-CSE-ConnectionGUID: NXFpIJSsSpu3LT0z1RBlqQ==
X-CSE-MsgGUID: S6sd5v9zSsahx1PUNKt+lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76458218"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="76458218"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 23:13:13 -0800
X-CSE-ConnectionGUID: ngR5xHGVSnevVwXBTu/odw==
X-CSE-MsgGUID: ul5bxnzrSfyiMH8IU+7yLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="190529841"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 23:13:13 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 23:13:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 23:13:12 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 23:13:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0RCv45dQoaJs2fOChStl1B34zlZqtzfhjZT2iBZvHhdLgf6BKVvlSIK9GEd5a8/tG+qYlgaNg2rNWOHHVitznrsMzjA1JuszwOWLypUoHGQ2RQM0/9BzU9RJ0eyjFRaTIG/s2QvPHfIBR3ZEgi9C2eeGDBtct2suZZeL2GuzLoiXJ9Ls7ovNu8MUI/PXWWQdyoZyb4zH8Wz/wPHOdERNhBE5Z3oZ9nZa8GI8SYJ3eXxZjjfRh6JGm/ECR/V6rLdWqSyWd9iYKSo2hD4AxNvJdIwoH6HvsZU2aVx9oE8nhBTajU2UucLMzTQTUQuQto9fPSlDAfafOTNPZxJRKabDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ6m+Hk9XrIlubGsRmRVkbhSkQe0uQTJL8iPQo8/cRo=;
 b=lyOJOqa5pGwtjeZSxds/8O7jYzGC9MBjhP2UF1lIrJNSOQDDDbBEAheBOVaG3ri59lM17l7KZu6a/i1YAjk2PSAzx5/gQpFWq1PN7XjPVKi+MliiYPSqDMRVAFixU8PFVNtxPtWfhec0bDWoIIgLvzII4+UWac5Wf4bDi1LCbQaPq4BTbgWPnxS6vZM+1JQniJ4DaGTh+u9UmywdI0xcePbgqxICvOlubUaOre/yHuqIsbnWLMNtFLs6v12mXuxo4dzJBzG/voMSVNlRzyb66NYoP/G28H6tZgQFk358f1dOgfBYOztllk3QYAP5VAEkmN73EirntEJ4T/JdIi7f9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8600.namprd11.prod.outlook.com (2603:10b6:510:30a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 07:13:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 07:13:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] iommufd/iommufd_private.h: Avoid
 -Wflex-array-member-not-at-end warning
Thread-Topic: [PATCH][next] iommufd/iommufd_private.h: Avoid
 -Wflex-array-member-not-at-end warning
Thread-Index: AQHcUjYqXE2yxK1Uxk+JgeMGYA9kqLT2frSQ
Date: Mon, 17 Nov 2025 07:13:10 +0000
Message-ID: <BN9PR11MB52763EB809B77AA1CF9125CE8CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <aRHOAwpATIE0oajj@kspp>
In-Reply-To: <aRHOAwpATIE0oajj@kspp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8600:EE_
x-ms-office365-filtering-correlation-id: 44a6aafc-c350-49c6-76fe-08de25a8c3fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?kiK4Q1y9JjGa81Wgsho00mRlYl+O4xZq7HQQuAyiFLk5Jwu0OQLeEpFnrdE5?=
 =?us-ascii?Q?dPDnogncdy+CfqAzSScAUCz0RtaaFLhyIVlQ4FHTQGp1jW0G9NU3Q6cIdWBD?=
 =?us-ascii?Q?+CtSaPnnKrS7v5Zu9nJ0FbynSmiZwOCmkvltPwWH8ExjM3A7bbGdsaUQfgwQ?=
 =?us-ascii?Q?0xCZPUhtE8o7qxF9yJDeKc0VyPSlILjZhwKtsyo0xy3jKvG3RNS2+wvOtXhW?=
 =?us-ascii?Q?WiLXPtVkcn9kC11cEnQNccJDuifCfmoCLCGGqleicVFD3WfvzWrLXFBm1Rxr?=
 =?us-ascii?Q?E3YwyiSRaOsL1Q3h5bvLueuDsvhR8qdGZonvMFcsWO2iRweUHZXZ8Hu5zPtM?=
 =?us-ascii?Q?g8wqWobODS80FVUWkHILlqtUHt6nZcJNWSbaUzpixUmim8Wzh6JUMQVjlNXu?=
 =?us-ascii?Q?9n7e19V3i25XDJLSo85NOpC7VISdWIIaeLdHJ2ERkPN6bTdE6cBAWWDP+ypP?=
 =?us-ascii?Q?rG/p9X9nehnbj433ouQgc5oh8sxO1aTKZlj8D+o3HsWCF5hUzaFCyDxTGNTx?=
 =?us-ascii?Q?GX9wGYIIVSsJpJOFWP+yiv3U4zASEBgjDvQI+nPjfqTuyEBNDTHNmqWL8y6A?=
 =?us-ascii?Q?Mcy16WAb8/GvDhV1hWZ+rA2dhk1+S0UPK2qVtZFa+8m+Et3w4RUlfvVKviGE?=
 =?us-ascii?Q?v3SPoku2rY0r1sTMTTkCDZQ7tvAclK7Uu4U0K3rvRUGWrzxFu0nwC8ZTA7LL?=
 =?us-ascii?Q?mtkRapx/Z7B5YsL++9+7FcZbfGdbvzPkejiHPaetpxFLnZ8KbNnKSf80c5hO?=
 =?us-ascii?Q?TTMaWUzXnGBrYO6ry5M7rqe3VUQ0qY58zjZHwZoSrzgTF05Z4DtJZmoT/EqE?=
 =?us-ascii?Q?hDJs427XGKITwOZNUY9q3A1/lBuq/Bw+Q77qL8D7PC+01mnIbeK3GVo+xGbv?=
 =?us-ascii?Q?yysm4RxXlg0AUh1Aog/uF1X2tWiTlUwNqJhguXUWlEvb2wEGrRukjcIuyI27?=
 =?us-ascii?Q?PQgI/c8mgpaawFi5p77S5YcLRW6bIV9FIfWCn5ofPhv4VFwhv0XhX6JTqIba?=
 =?us-ascii?Q?Kxj1iqdxS6ab6XS/yShZioOgBz08ohaLAqUcq4Te5QvqyhxhtlGUFsG0/Izr?=
 =?us-ascii?Q?7mDlCE00w0D5uQa7nrSwMIuHkp7bDOaKm2wz02IRRU83Uf/pXC/lc8WQG/qn?=
 =?us-ascii?Q?oSDsTBWiLFWYM8dzPeRZ/iBX7/JuDWGlPCSMpR5NCFy3JGl7gXLpfFgkDY2v?=
 =?us-ascii?Q?xUfeV6l7kA9GfMzIY04RdOwrln2Vet1+GBFbDAzOlv6v/mUc+yKUDMTOOoDd?=
 =?us-ascii?Q?4gmMq4uYFkTVfOlIMipy9yAgKXl8Evl6qNidJuxx2mzyt+QLk0SvpO6+Bm/z?=
 =?us-ascii?Q?QUZ8AJZfQh8gre5ls33DTdnJDqsbJ7gEPPpYlOF6+KhW4T3dszTTV5TjitnI?=
 =?us-ascii?Q?OlrEwGOzVZ9bte8yZ7GvTjnXGxyhLi7cxkfawrEkT6/LLxAb3OpCeRvx2wao?=
 =?us-ascii?Q?vEzDYtweD9ZtSy5XL4RYrqPFPg7HwfbsGGikqKWgqyIJCs4857JrItPzdSjN?=
 =?us-ascii?Q?ZoipI/WohRWGK05QJe20MkVBpdfhHjYKAxNI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9TIJA8604Powbt5OzcD3PisPewJy34BnzCVQc1i7yUNc7argZjmvClzt3Nnb?=
 =?us-ascii?Q?UCZL0xsd/dP130mieA0PTbOvImvjrv7R71u0tj4PeyigH+SEDYu0Dde9KKdT?=
 =?us-ascii?Q?JjaQ50sd/u/b7QtDekGwREsezDRwnFsabuDa5mTiKNJne5lj5TIJTF3ovEdX?=
 =?us-ascii?Q?u+r82uindkLTWJQWExVCaHRectEfFRuCDOrgI72MxkZRmyu7NBjAPMlcS9za?=
 =?us-ascii?Q?OMvjhmArZa/xybsVBcgZEUrzliMRwhCf3rdpWtGKvHkE4RYM3dngfDc4gp0X?=
 =?us-ascii?Q?4DSYD15uKzKsWKKyyTPZzKmFSviOmojyqJOyE70EitAt5zH37+Dk+b5nTPpC?=
 =?us-ascii?Q?+OIV1NRacQIVUkuMu6DFSnLPR/kYK59PPN9Ql92niFpcKmfwIPMshr1ke8QS?=
 =?us-ascii?Q?ETK2OfgjmLTVGRjNZxxLRehBMFZ/cGWR2h9l/jQjGjQ0D/HXgM8tLKTSr8Ss?=
 =?us-ascii?Q?GOYvPZDrArbSzUSnbgFgX8J9UKLwIA+gBQOU7QNdE6biPSMp9tgrL7Jkll2Y?=
 =?us-ascii?Q?hPM3evMi8E6Dqk36qf16uEcGKgq5rjWnp9Mx6Kwd4yO0oNepE+lDXZ/WVwdb?=
 =?us-ascii?Q?I+de5N1ColQwfqoh5sGpKIZxDnMMJK+N7JFv8/u7qFhhVYOmqgguutgUHra0?=
 =?us-ascii?Q?IWzp/MshJb1BRW2Pv+SHkA3gp61nxlxExPXMqZyuC7lai8J8Q5L89SosLcM+?=
 =?us-ascii?Q?EVbhVk2eU4kZd684HZpSLJYyI1mBYgrbIS/wU59Z0nvwRxSltasgS5E8eWVb?=
 =?us-ascii?Q?MF0SucXq5qGDk0YlsCrQCcsQFsP5RJEEMMWo/jWnSOIIV5GnIoDo8kRdJ8Sj?=
 =?us-ascii?Q?VqxePisfxr6ymy8Vy96NIOhn+8pUVR0HMSH3wne/CwYxGUvTxihZLBKBcr7/?=
 =?us-ascii?Q?o2FsXgF9ChAkAutqNRG6GxURjLrYEPpEontuCDUIsxJqWN3Z3aU8a0gTwcdy?=
 =?us-ascii?Q?CaDr/2DuxItyMC/FFPf84teyJ5EsPhWE2YcsgSdWAok40u8ddj8Mh8UPb7Sc?=
 =?us-ascii?Q?oA5X9j01aAPWY8UroH2g6PjvIYx1r5uC1bG6y4T8XFpeAmR5l2IyiRgRVTwS?=
 =?us-ascii?Q?UYwHYEenDEAIrEw+RcpjwvqnBariFImFAYPxc4PnD3g8eKzhrNCiatr26CZa?=
 =?us-ascii?Q?OgOjdsEkua6mR/P4NRWsZLfmxRt6qTtd4CZ5+8kD+04OybEYGab6Qxf5uFZm?=
 =?us-ascii?Q?4MVVWIlvoLdDJEzA39jVh+CuKy5PMKMe1UKbSuF71M7Engttbz1+5bj4/CGt?=
 =?us-ascii?Q?VWeUUyft8d+ys72HZDeusw3DkRZ7HYzt9WOLVUFTTYR+sKkcLYwQCTOaPtgA?=
 =?us-ascii?Q?VUHTD3lz10tp8E/+tNARZBY2Fnh5OHWEWKAPxFIDDXMCqNn6rHoJkLPOjzXt?=
 =?us-ascii?Q?6QMToUIPxYIs0MbT9KLPpL1xS+KKnZ0Rgr0UuRfkKOmbI+zNkwtPkxcT4la+?=
 =?us-ascii?Q?dgFOjhAVxRvjlroeOJeQWuX1tn0/QiD7Ca64u4zTG0g5mdFAGFObR3bD/Jhw?=
 =?us-ascii?Q?A1KZGq1p7S+skTBmrqrYrDqxfxC2ROkrt56kOsPg5lFUr3VBxG/UfOmmo69g?=
 =?us-ascii?Q?xC+vLZiqzC+RV57uJJr+0CM2BTjRpswo5ZQlb84m?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a6aafc-c350-49c6-76fe-08de25a8c3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 07:13:10.5899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyarcP9Sfrpbu4GG6GXB7HkARp1iB2vVNQ/t7+iBVpNrdLct+VXqE8lYrGS5X4pF1ae3uaku6++wBe+MOVRwXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8600
X-OriginatorOrg: intel.com

> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: Monday, November 10, 2025 7:36 PM
>=20
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>=20
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that struct iommufd_vevent is a flexible
> structure, this is a structure that contains a flexible-array
> member.
>=20
> Fix the following warning:
>=20
> drivers/iommu/iommufd/iommufd_private.h:621:31: warning: structure
> containing a flexible array member is not at the end of another structure=
 [-
> Wflex-array-member-not-at-end]
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

