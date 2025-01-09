Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FA204C12
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409440; cv=fail; b=pvN3h28OZNAzG+i+zrg5m2WlnZIWtUFwp9P0eFwxiGZ/YAX7QKixqplWPfbXupMgZVDHd4LRMcZsStEp0cfGtQfUX0AW+Q47EFh/6xYp80hX/QiXeNxlMn03P05LlV2WB6SJL2LA+rbtkvNF8lJty4xuUSfCwKepafpKzl5PLPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409440; c=relaxed/simple;
	bh=qsCIypat5gzaemqFIlRc3cKCO/tddm45uIY82O7mZp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UIazm0W4X/QCcIq0Z4v3dpOQ9/byIwuOzz/ew/1azekUhevGfW5VDkJD97cIVgsv9A6YDPajZPFydVzpS4c0pa0kEeMjf+bGpd46M+8AveHLVJe53D0v0rI4/wnkt6jkdrdj4xpGhEM0GFwaDqxTXC0ihQBKL7EP3kRTQlmsACc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=br00HSQw; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="br00HSQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736409439; x=1767945439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qsCIypat5gzaemqFIlRc3cKCO/tddm45uIY82O7mZp4=;
  b=br00HSQwhQuDaEbDcqXsx00rNbBOxoigAhZ3c40iKuoV7KLmEILzIL0e
   jzAu6Td6TKQqJSRKhUPsUjNHrWDuDh//5zUaLd9KVINmxvmWKbfupMR2M
   Wo6qwAIfAgodJXMcCGpPfPf9h9VTpdgR4UsEC9XWcGLd8nrElJ9GYD4bi
   RQGID2NPyw2cR7a71C1z6U1n7bIxF4ZnAJ4vc3Q1TG+pWLFT1MSez/Emv
   lWVf6jlfZxpXdhW8TCU5xUcCxsyOSfshnV8k7rXVR5SjIDEN/Ju4Uxll/
   qrTd6LM7OF561NtH1bf6hNG7E+XOfEM5JAUleKaN1ZkNDJZmNVPVc56ja
   A==;
X-CSE-ConnectionGUID: T52QQmJbRr6wIa2y4kBXsg==
X-CSE-MsgGUID: IdmLBko1QbG5G6vfAohB6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47155149"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="47155149"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 23:57:18 -0800
X-CSE-ConnectionGUID: f08pv58QQ1aIQ7jLC66s7g==
X-CSE-MsgGUID: lUdtP+EOQne0a6plJ1sB8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="103139688"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 23:57:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 23:57:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 23:57:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 23:56:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgE7IuwoOgjy+cu1OTxLm9eFIiafbNuFyRQ7IoKS52UOED7D8NmUUPeH9IKoRQrn94A4KO3mMeAYfoPOXxtS914TtxNGCqmMZkeHgtnL54cvuEbubm3bYxGAxLZ4kO9Vehktf9dS+HkXLd8qWjWWknr5KG6YxxsTcm9tmxv/dbrfoWUgSbvQjFgCmkhOZ/GWwTqcdsUQVolfg/2NNMU1ijQxkwXqqv7GpKxvVrUDDajFEIhbDGH3GUSTPY3MfzLxAWUWET23QOHzReSAH+tyOlxeYl/CpW/3iYQF76uqUy4WGA2PloJ2K8fvO6X4dkyS4jXnZ8fDI95CVGKTJhLgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgSFg0RqkOZyfl+Y2lAWiNxAfb25wqL5NUqBoAi5MZ4=;
 b=AZNAyHxIIx7GZBTBqniL714DCzmYyQ7dwLwKWIoH74OdK4/VAFGW7+zmqx/kKgvk/mqBEGD9hle/sSiJP7sBG4Gs24dzZyJaXRO6q8N9ko6cAqkRJ+U+JMKbV5BdNo/6HjttrweUDI95nYR9AZUoYK9uHL8e0b2V4yn0AbyfHOc8TuVvh0eoiMIbHmmDo+FloyamWXtvmg8sgZ9dqg75B/HXHT4TzH10xfaCQcL+kku+bRaqkLO5YUW75TbsxtM12hiDLDp9u9VfcGhnaTA9frohTy0+7iuuXPF8ANxUN9R90AAuNeCgHKaNZtwfN+3k6Th+DBtbzxM0+ZYHBtTdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5003.namprd11.prod.outlook.com (2603:10b6:806:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 07:56:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 07:56:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 06/14] iommufd: Mark PASID-compatible domain
Thread-Topic: [PATCH v6 06/14] iommufd: Mark PASID-compatible domain
Thread-Index: AQHbUhnQ8Bw3U4UaOEq55XVs2/4TY7MOMveA
Date: Thu, 9 Jan 2025 07:56:53 +0000
Message-ID: <BN9PR11MB5276050571F4124F7AA677CB8C132@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-7-yi.l.liu@intel.com>
In-Reply-To: <20241219132746.16193-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5003:EE_
x-ms-office365-filtering-correlation-id: a40cd6e8-05d0-488e-f67b-08dd30832e66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3i61EpTAUzINqACk/tU/EV3MfZARG/TQ/THMtB/F+w11BkLeMzDCG1NktpIe?=
 =?us-ascii?Q?312RR0L1TFlnhXxbne88fh0vznN7EoIQ4onqYMTc+q+zn/jjbUOTwXHBDscE?=
 =?us-ascii?Q?HTQ0xG3aloONldKpB2mnekV3MBIfvEPKA0rr7kXx9yFfVDkInBcev2jftuSW?=
 =?us-ascii?Q?UqvsebxciwnarOfZe1m2uEypz8EAgQQU9/n6KpJrT+Kbsf6Aw/X2tgyqBafk?=
 =?us-ascii?Q?R30+DaPVCnv+jcj0h9fAc4jrIS2VQfMNxwWL8fn0BurrQHrFM/dluuqkYS2Q?=
 =?us-ascii?Q?n98+XGRBhgMRhf+z85tksCkrBKCK2n4WxnkVZ/3c93/hbiLsDC9B/p01pgRr?=
 =?us-ascii?Q?xm2xO7mHw06DusaBgxOB3h0VMqhZZmNRLug2N5O1Hy+DoHW9qw5pXl0mV3E1?=
 =?us-ascii?Q?wOtu9bwD4pfjYrTxxPNyudH+sy34Jq/C9RVUxjTKct2KLv9n8XbVcbGnqSKd?=
 =?us-ascii?Q?TmKH4+rLWRhnTv5w3JTtMZaGLS7vgITTVTikChrALKHeQ+0KvNww+3igtBQV?=
 =?us-ascii?Q?RNyZcjgcC8mOrwzaSotv3AyFXnMv7pXzckOz9s36/WlFjax7uySxCzXR5vZI?=
 =?us-ascii?Q?LA1kfzbuvsLAlyBi/JjNOacjdsKuVHU65UUpASQ5pFFA9BBCJSAhbIPZjLBF?=
 =?us-ascii?Q?TlbthfIXikNZG9yTiqvDtx7q0PaUKPgL9/4ieNN92w4oivfXJcqwcTCgiSOa?=
 =?us-ascii?Q?OV4kIRlN6H+UIbe2veKBEaEHc0yos4rRJ5yGwF3VvlCiCzTfSq8VqBW1Wiir?=
 =?us-ascii?Q?gDuHK4jXRAmR8dDIri4NjgsQf+50bEnB8mphBu8Hi7X7PJewGI7Drw7Mv7Z+?=
 =?us-ascii?Q?LUQvV086sz8R6s5NFD4dlyw+nFO4/UyC8uQlIthTPTxdCMeZaivU6NUt9Fzu?=
 =?us-ascii?Q?UcVQ3Fj5LcahDHexiufKLDwcd6FU7SxSwtHcM1JB5+DU9koDrp4TZxHvHc2d?=
 =?us-ascii?Q?U3RbGHirSyHy17eIFY3H01XJ4eagUi6wApp511RVpo+pRpb82Jih6hn5b3Rm?=
 =?us-ascii?Q?OusjyiTo+KiZKZNMp9S4rc0SY7C1eR7lh39cCztT1MmCnWUcm3HSSLToGglF?=
 =?us-ascii?Q?yF3D8zyA+0L0LCLvy1kf0WxB9pUZX41srgpOjCCraQhOWqCi+cxFvzFSRsnu?=
 =?us-ascii?Q?jJ2hBk5YicI1XXi4NamCniD13fB459uxM3R7auRGo1+aPgSE1SoiJuIbXKmm?=
 =?us-ascii?Q?2jHbki/AuJuOWcUStB3C/n1OGeODtILWPH8CSy66QeF2Li6V7rkUjffyVV/h?=
 =?us-ascii?Q?AQ81IbW8tu8d9REQo5T3cgKkEbdt/G6bI4XQjyT6JwUGWfJIzFW+4I57jMhJ?=
 =?us-ascii?Q?ixskS6xPF+hFgx3KunajE53JJqCGEWgEDeYUKKiCSxE/PIaG9bFmvKwANueT?=
 =?us-ascii?Q?bzNlWsMuzIe6uZyeVYVk8kzf9eJ2C65IjLUpPYwpYBUTIC5WGJV8+E3URtAG?=
 =?us-ascii?Q?knQl7RD7syFBb1y/ZE2YOJYR2lmhD9SD?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3qDVYYpBUSnD9o6oAi5UHJgl9MV2UuZiiKS5BnRJfUj6hyL7OjPWtoj0vZzF?=
 =?us-ascii?Q?Mt4Fd4ateOFcJBFiGzYSxTvEgZ/AY2VQcu00MXlrN3YnOyI24gFMpxA9xAnE?=
 =?us-ascii?Q?1xXIyTQ7kLVPIciof8+NCKykFekgYCuOtMFNBv+u+c3cpNinYhuhrqJnZNh8?=
 =?us-ascii?Q?7ffaCU/+0a0Yd1YogVor+ZGhI6EINHOtrFQihW0025xeQk/+3fOjIBJyuzDf?=
 =?us-ascii?Q?R+eJDMGXbkFuBxe/olANYjJ5aqFEXEEAEzKCuScvM6BIwwqa15SMC73sm5u3?=
 =?us-ascii?Q?f4Yh7TfzoXIwHvMll9+OQQukwN66LjrP3C6wf7KpzN/6TzOe3+8OUDMpXs8Y?=
 =?us-ascii?Q?eZ3N5HPlLT8WDvuIYtDNhy7B2uXU8wb05yMB6UsuycRp2k1Xu6gZiKgBPsL9?=
 =?us-ascii?Q?LG880s5nUR0du94PuX6pbUpLRaYtAiiN7tY0WMNoXicsV8P/hSzrAFhV7qHu?=
 =?us-ascii?Q?LkipoP/52IYc+pfSpfYI0dDC5QqYRIZfhTgGVdd+xgQ53TCdfapZW5JHMufb?=
 =?us-ascii?Q?qHAJtUsE6FvZU84KqAFeJ/aj5AC4m2vGNocBSwb1HwWRzaGsBXhpbxnfbRCB?=
 =?us-ascii?Q?ZJPTQYxkyd046rL9BYxN4kfewvyrdZtTgzAv6Gjm0vZN4onBgInwBC82W01i?=
 =?us-ascii?Q?tNnQ0XgNUlQ3au5EkPmUp8ggEZlkiJ5an8BFAzjcHi664oFa2Y1IDK+3AlqG?=
 =?us-ascii?Q?bViyPtblpMTlMagHFjui89CdQlzH/zN5yw6A66t7Tj/T+SyH098WOxPqLNjL?=
 =?us-ascii?Q?DCk4jO4gozEY8zbNLdaDltM9dmgyry68WsKLDOLvD2jbTVj6mO4Osdullh9q?=
 =?us-ascii?Q?h4NX4xSLItDMHh+L0FTDNT47756M3hsnm/ymVaWn/D2JFi3QRwFKLms1U7E2?=
 =?us-ascii?Q?T3cSHO0RTFil7wRoxG/Smx0Khb1+AROFpwa2I8/edvbc9OiDoa94Czq3bYGn?=
 =?us-ascii?Q?iC4eFUIGRgQEN7/Ftjf+GjQsn4atVUz/KfPeUmd2hAenmfsu4BnHFPDQ8jE7?=
 =?us-ascii?Q?UthgPZY8SPz6twA02L8o5aAGeB9S2w7XYVNO71u56Z1CTCms14StOFMmgWRp?=
 =?us-ascii?Q?5vtWW14rcEUnCD4mAUr65jSNQkL1U40LC9Fa4LJFRsfo6Qym8/0U43qEqgFw?=
 =?us-ascii?Q?51ctqGpEAmR9WI8DUH9/srJhCQgO1HT9KHsbsG8qoQyRkzqGtgCrCbHTeNTH?=
 =?us-ascii?Q?NI0zdOmySCZcZJG+u+myjqDcvW92nPupOpNOn0nZmeSo5RC5m6pdCsYXAd8E?=
 =?us-ascii?Q?xLGaGccmCpSVizKRRuTiagbsSDoLx1uUenVyADjS7ltOhGwRZVpyTnZiQr/P?=
 =?us-ascii?Q?mbqvgstjiLJIToHl1wPxpelaxyxVJRYscHFUJnHNnRDV4ZNwXE4oPVL2bQkT?=
 =?us-ascii?Q?kCW/53D3E8WKKAcOfQ0Z2uJgpUr5CK5F1GnLyUx2WsR7lLwpFlKZgBqpX+Wo?=
 =?us-ascii?Q?Z2Nuho2Yg6aMrHKrrWe4ozizkGjaPuEIG/jQDUrVhg0gpyp4W5ochWKaW0Al?=
 =?us-ascii?Q?VszGv0tHcH216hT0y/1DE92Uc2iCEuZIyu0A8Ug07pr89YikfBhPHuJOFxuf?=
 =?us-ascii?Q?A5muV1ncBeZJPBokzZg7wzMvwB8oIaBA/ZJwohY2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a40cd6e8-05d0-488e-f67b-08dd30832e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 07:56:53.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCxtL5o5KPqHZzdbz+I1f2NvdjogzS0cFwhNebpTReRdVzJXf+lNvCYFc+iHGf5gRDQcI2hAOQU8qaCTqZOaMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 19, 2024 9:28 PM
>=20
> AMD IOMMU requires attaching PASID-compatible domains to PASID-
> capable
> devices. This includes the domains attached to RID and PASIDs. Related
> discussions in link [1] and [2].  ARM has similar requirement but does
> not need extra hint from iommufd, Intel does not have this requirement
> but can live up with it. Hence, iommufd is going to enforce this
> requirement as it's general requirement.=20

Clearly general requirement is not a reason from the description. Instead
we just want to lift it to be a general requirement as doing so is not
harmful to other vendors.

> Mark the PASID-capable domains
> to prepare for adding this enforcement when PASID support is added.
>=20
> [1] https://lore.kernel.org/linux-
> iommu/20240709182303.GK14050@ziepe.ca/
> [2] https://lore.kernel.org/linux-
> iommu/20240822124433.GD3468552@ziepe.ca/
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
