Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8583313272
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432743; cv=fail; b=R5Yqqf+C0ryW2yVAWZreIalu97vKSuG9Vs7FHgECj0llrOEPcu+BXR2z8Waoj/lEhtqO4FHuUE0KIebseouwo7GBrZiMpf8T02aM10vXbs8fogtmy3o55kfu1SD+CF/7xcojRWfNLrb67qKlrz6Zp/Z6Disuyxn5FwWiq66sFcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432743; c=relaxed/simple;
	bh=ehgZVQyrqxGrsoUkdajh1vjXp6CkYjdYVCPWOCOPn+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YfOQP3roZ2i5/wer0h0GtiM20g31hulhP4E0Id5XpbvB2ReaKhpOGhknO70GrTQk5Os6leaeK+6T7amMKTB8s/XMz8g1AuvebPETsb4ABFdnxIH2c24L7MNMz9lMg/u8vfEFUjAduRpB5HDTLgb5vbhF3WXsfK2WeC7sX79IGwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rab/Ydio; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rab/Ydio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786432741; x=1817968741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ehgZVQyrqxGrsoUkdajh1vjXp6CkYjdYVCPWOCOPn+8=;
  b=Rab/Ydio7nucA9QKBmXAmkKodkXcIAlVBrbLQ3q7yiLnWxuC7om4Cnw8
   WURoRkvSTo4YWHUmAPkwLesEWVW9T9ewQpznR94I2zrs3MXZgoPCLhMU5
   Yd8zyiQa1pbCOtSZVKIejXdIiPuLv5G8XUD9y+57v63qhw3aDxYJ0blYg
   D3ne+mNR2VAqG2IRo1Rd1jxXO8OaA4sGPwG0QGXA0muJkcg1jlNtTqnQ3
   uWkT2XwXgLlXrGdrqxO/uvf3H3R7Ay8BBgxTEKqenM8iOdBWoWCqgc17Y
   UUckeafFqUjPma2A7nGaYPlh2JwFeLEO25vO+WqRUMM/lJEy2JbptbZp5
   Q==;
X-CSE-ConnectionGUID: NfC+1fDATgKQ7TErl3iuww==
X-CSE-MsgGUID: gOmsiuu3Tiqa7RP2arb5PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90638203"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="90638203"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:19:01 -0700
X-CSE-ConnectionGUID: zpyk5pt2S5CgUYFEOobF/w==
X-CSE-MsgGUID: 8aniabuOTBanoKbL5LTAHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="260658388"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:19:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 00:19:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 00:19:00 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 00:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWeu97LPQRH61LFmtu8/EJ8lGUDCrvGWQfDbftULM4QLRBRbcaC/UkClpYMRfOCNHanLOtvhPedVRSedZ63Kt4EBgH25k3e6UEFpz3/fnONXO/QdomHN/5dg5OY+eMEobLgIboaNu1pQImqI1ai6xyQqJd/dcglRqmJxqU8H5bkFsGsXE8P1y5mYMWYgYedC8jOeFoUf2+6KziYKteLe5Osoh8ONYTsSf49uwII3PElBtUycrP5OjCCijRAgzJIjM3FQ7eL/OVWXaFKURgeazcPkqcByu2g/oQWGPT7KrA9TUldvVgZTCWFJbM7u54ePhCkQAMqKYmmc/4XUQhj23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFtxznEWVYm6jIaMs8CvNCDcmHR8RuTiGM2HTS+7jCQ=;
 b=uHx1GDe7xmVX125tHxgP2C6xZp2Kd82MeYxEvr9WXIXMQ84uM5eO5SBqz/Z80JsNRcMWyzxRR5bvLo3KV3cuYmvrt6xeyP1jSOJInSYASP0tJUzK3ax8U7Rsg9xR3eQMSC8wQFHsVxXjNBuOwK6ws3NydA9rorZLptyOEovFeByQWoggdDYNhXz14HFtSOYjkkJpKMlcGkP/K8kP58mB4zG8IzfmGuVO+aHj84JSSJ256CYAtC8wF0C9yZH1diHfZ/wVJ1zEVhclq8zNw/Ue9c4CKG+sochiUwJ4b30Em4qpVQOulu9vb4LzaEttM+2eFs1UwWe9Tg3q+TVOlfm/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by IA1PR11MB7919.namprd11.prod.outlook.com (2603:10b6:208:3fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 07:18:58 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 07:18:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>, "santosh.shukla@amd.com"
	<santosh.shukla@amd.com>, "Sairaj.K@amd.com" <Sairaj.K@amd.com>,
	"jay.chen@amd.com" <jay.chen@amd.com>, "wvw@google.com" <wvw@google.com>,
	"wnliu@google.com" <wnliu@google.com>, "dantuluris@google.com"
	<dantuluris@google.com>, "chriscli@google.com" <chriscli@google.com>,
	"kpsingh@google.com" <kpsingh@google.com>, "alejandro.j.jimenez@oracle.com"
	<alejandro.j.jimenez@oracle.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 00/24] iommu/amd: Introduce AMD Hardware-accelerated
 Virtualized IOMMU (vIOMMU) Support
Thread-Topic: [PATCH v4 00/24] iommu/amd: Introduce AMD Hardware-accelerated
 Virtualized IOMMU (vIOMMU) Support
Thread-Index: AQHdHcwCk2A8a0x54EKi+vHbrU162LaYhM6g
Date: Tue, 11 Aug 2026 07:18:57 +0000
Message-ID: <CO1PR11MB4835919ECE1DB0D448FEF4FC8CDD2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|IA1PR11MB7919:EE_
x-ms-office365-filtering-correlation-id: 34d86aec-c446-459f-e2fd-08def778cf49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|22082099003|18002099003|56012099006|10067099003|11063799006|6133799003;
x-microsoft-antispam-message-info: hBmmAWBdEjI1uYYGHmZqnjyFm8JpR4/3nmuAZwUdPAoaV6p4EHga2XtUkfsEKb+seaa0AGbCmgkBpD6NnBt239k6434tF9rQwtNGNzJs/Qs30kDslYvX1KWYYaHLOte7P04wTPAKP9lxjC6PmkYgr/EeCTAEUtF8WfGSYvNUdES2BL8HnO/0RMZGugQq3itun3mMN5qovkJtbHoEyMzwhQq7x6P+oy3B49kJbdvZPCENMRg1LQZLAJoOqBMaKrldLRGYqEsbdMGuNX94HXckqtMxvH7OfdZS9MCLC2NUcF7Jnqi5PIaNGUinhfLE+wt6hp8dOcOeH7WfRXEc8axFUsIFcoL27nNdcDrAEUZmqXgUcnv9N45w+mfLknWtToIuBGnt7JgYiEYjeHyPVBSLRxxlo0esMWBT4gebrpn4F3R/goL/fRC1uNgbhAj7pAFvR+9+7/JH3cpM+9pZ5dhsndX1KQ0cHIDYsxYUlDI10RqJ5bd29teyLCQLUb43hKiu8QCtVi5RinKGUICTQam8RZrXKpM7AXpt8nTfOjAzmHaj2S2BycLepJfyp9qvBggYtbBJXjCsVVFC7vJqVNQryk/RZo0UFES1UCCVDmXRUnzzDrDAxYe+M0Bh+69MbBw5HVI4uXawQ8XRdEa9egTRsTZnsZDd8Nzg24q5lAPkCiWDUHKnMNcXbRrq6rCZqVzKiZfsQPNjNr+YFz8oaXX7t9dOVh07MVIIiKtEg5+7Lg8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xvjy0fSf5jXqzDfQGhzLn+RKjRUZPLA+Ll33ckPKHudT7k8UT5jMnIzR1Hzy?=
 =?us-ascii?Q?k9+FnmywWtbDBiOhv+Vxslr0v2nBMpmwuQZ59SKJeplmaCtNC4/a8fHG8khT?=
 =?us-ascii?Q?lELb45brkub2gAYWEGzc8O+/hhbmL3SrD6ApcHuJ1vnnMsXjbob+OK8IYqz+?=
 =?us-ascii?Q?lVQEJzLzUjuRt/bC1pkBpHJgJUnmV5uPNJVia0v41mEVq3iOb8+7E1Wx/14R?=
 =?us-ascii?Q?7Xeuj57U9Irsp1itkGu6ThvKFG/oCQyHjKC20nCNfuqKnYxIbnSBTLmn5iTD?=
 =?us-ascii?Q?7rJubpfAlTFe+DjbHuoFW7HjCk0649v+9r1Anqkkio0rGFhp0dZGpn1yb/Cg?=
 =?us-ascii?Q?fNh2Y4v+DoXEau9GBo9oCFeyVBY/n+oquT0UO6pVCUD43snpMsI6V1FBglbK?=
 =?us-ascii?Q?Ea+UVUtPgRuvY9SbXj511/4Io9H0lR+DKanqA7S00pI2CYOEfpFsX4PjJkiH?=
 =?us-ascii?Q?OXVcPG7rlcJ8Nw77keQ957/k5oAuzyR4bhOPGvZrFwCgJzDZljq32TfCA3Uw?=
 =?us-ascii?Q?8FPXRRrtjiTm0B7pfIpwQXXa2oIWcL7tKPt+CV0tZfrshTdsS8iftWPuSYA9?=
 =?us-ascii?Q?1mL9jIDQV5sSULMjK1wIFLxtlLdbvUv2vYXh71xUTK+E1LqDvbf/2ZGRhmi9?=
 =?us-ascii?Q?SZysJccShOdLNlaTgI35KpDqVlREE0jDzzWxioQn+JgalDDYVKKJgKGILG4u?=
 =?us-ascii?Q?f/e2jY3syha3tF6bP+xV+FtGR7J69PBr13hnvt7VUOEMWbbT/0vhlL5Am3Ih?=
 =?us-ascii?Q?ZeIWl1MFDGhpjjJ7EnmJX5KKpQPQTSIKowcpymrLKbXlG49wRSTk99uV1Jiv?=
 =?us-ascii?Q?Pbz0tkC9Wu87Awzg38Wmk6d4vhpGLcvzgIqJ5FGGp+7XH75NAYpIwpz4cwwC?=
 =?us-ascii?Q?tRxgSxYOMemHSuR7lSyXk83Fn24xQvUAFYsRqQh+7BJLGgdOadAR1GwFmx+A?=
 =?us-ascii?Q?fMfQEjebjFQBVzV3FyfVCDnjpWPg0s8DhGKQqm5DzIrIqAt7pINTDN0sLL80?=
 =?us-ascii?Q?Bsj8pX5Dcxsro0jhAQqSthgN7za0OeZmnY32b+as2puL6YI/G8ICjaBawPRj?=
 =?us-ascii?Q?CpP9Vjw7uQbhuscvPIy/6aEpBhxUis0/A7lcT2TAhu7BBjUBe1tfTqsTOKaV?=
 =?us-ascii?Q?Q6qilVjBlz89zv18oMNksTxRizJ2FMz2/GeXpDSGOQVjT0db0akiJvuKPZng?=
 =?us-ascii?Q?xrVqGwmHXCL496s4jj7R/jwb79Q5VA1iQWxap66dg5tRJ+xpf2ZypDIdcs8F?=
 =?us-ascii?Q?N/OgYUOO2385nRc4/robX/xn9Og/H2ECzzxcrqGGJmn0XZDEOzk9W4ru5cmr?=
 =?us-ascii?Q?NwanFm7svRCXqwCj6YVO3iOsJLdXB6W999aXaLAzW84k7pJoN7o5PpgtrecQ?=
 =?us-ascii?Q?BBGAMgTdYiLd6ZOi/mxhII/PPNmMOlkFVo0jbhFsuVwF6QiW+g2E36TaDduG?=
 =?us-ascii?Q?pSNab9eA6g3Iu2KI6SvTLXiM4Um8nL2RVqnRwd2/UbkTSlipA22KyWV8qbCH?=
 =?us-ascii?Q?0HS1234WeZx71epG7lZymeAN9BI3Nc5sjvi70Be5Y0gq3wqok3HiJwlNhj/+?=
 =?us-ascii?Q?8eyLi6p9Ye/GMfgqKlGjhzdzw5f6jS2vgK6DOdwGjm0Xr73LEnBzv4GsnrkK?=
 =?us-ascii?Q?7tXOYX94DcW/Ipnvrv6MnRHRPz0Z+8tzfzoHbTlu6tP+9qci3dfbQQ8g/kDf?=
 =?us-ascii?Q?Mm1J28IxQ2M1UsPcbE10fmM54+/BkWbsJg4jRtqBgamJNuAh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ac6cwVbOxstgACpWeTEVspa0Y9lRKT+HqvvgTkJuqfQm2lU9ZOpj8LzbW/09N108lyq0DeiGraFTGqGVYhyR8zHQpcuaeVmuPjhzmspPYQFbP5qGixVK3ySW9c/ZN0MLuHbWUQZcky4j9g3u56T+tHlrxY/1fQ0O+IyMSGwnxPKSfOaBg3HVcqcjlW2+RtvQiEIrq76NTTUhRmv7bpGdc5yjox2mLJ+nPb9ss2I3SkebiCzwZWKZtizmLAmGVAT+WuNQFZAYRGL1MGTdcxYfD0T4O7jTPtpiiphcf78ArTsj9k7QvLOlb8XVCW5HtTXVzOp5nWoMMCPUYhbzzRCnfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d86aec-c446-459f-e2fd-08def778cf49
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 07:18:57.8601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzzY/EcFKbQMEyPeoy1jnQ7rWA5+wIxvn+zSekkNanMhwN8cgk/cBVsT4Bxg6j2E2RTpORkGo1hg/7gZXwnpVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7919
X-OriginatorOrg: intel.com

> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Sent: Monday, July 27, 2026 9:29 PM
>=20
> AMD IOMMU introduces the vIOMMU feature, which provides partial
> hardware
> acceleration when implementing Guest IOMMUs. This feature provides
> acceleration for guest Command Buffer, Event Log, and PPR Log. This
> eliminates the CPU overhead needed for the supporting HV intercepts and
> reduces the latency of these operations.
>=20
> When a guest attempts to access guest IOMMU MMIO registers with offsets
> between 8KB and 12KB (i.e. the 3rd 4K region) such as the Command Buffer,
> Event Log and PPR Log head and tail pointer registers, this is serviced
> directly by the IOMMU. When the IOMMU accesses a Command Buffer, PPR
> Log
> or a COMPLETION_WAIT store location in memory, it directly accesses guest
> physical memory. The HV/VMM continues to trap and emulate the IOMMU
> configuration MMIO registers between 0KB and 4KB (i.e. the 1st 4K
> region), which are primarily used during initialization.
>=20
> Additionally, the HV must initialize the vIOMMU feature, map MMIO
> resources
> between the VMs and the IOMMU, manage additional supporting data
> structures
> in memory (e.g. GPA->SPA translation DTE, Device ID and Domain ID
> mapping
> tables), and allocate/map vIOMMU Private Address region used as backing
> storage memory for the IOMMU. Support for new IOMMU command and
> events
> specifically for vIOMMU are also added.

above tells the full architecture...

[...]
>=20
> Testing done:
>   * Single/Multiple vIOMMU instances
>   * Single/Multiple VFIO devices per vIOMMU instance.

... and here seems to indicate it's a full/testable support.

But patch3 says:

"
Introduce a new global variable amd_iommu_viommu, which is used to
control the feature enablement in the driver. Currently, the feature
is default to disabled. Once the feature is fully supported, it will be
changed to enabled by default.
"

then amd_iommu_viommu is never turned on in this series, indicating
it's only a partial support.

It'd be good to clarify it plus listing the missing pieces. better with a g=
it
repo if one is interested in checking the entire logic.

btw it failed to apply in Sashiko. The review there is generally beneficial
for such a big series.

Thanks,
Kevin
