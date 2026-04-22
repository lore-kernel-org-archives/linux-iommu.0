Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129A36B044
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845570; cv=fail; b=UjmcuiBplkhvpePwwh8efssFEASEqHEg7dZxBqcJ9KNiI8O976BnvCosZjex31BXsBHMjvM+pkCFqzuvzIRnfd6LR7MuFaeGLLCniNWeyEtjFjyFB8SzPSGcO2Ju+MqwWvGqnTMbQE/ksyYuP8GwcMMDY38ylpMHnnogeuV2nbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845570; c=relaxed/simple;
	bh=QA71R9u6xMDmjAGA46M0/RbHtEUUj62I3NUXDHdVF50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pz+cOrNk7D8uB8ybSVsacQjbdneyXiUzySwDU8reSW4Y2li8/6Y+0czcssKbtS22/wk8QTlagq/bL2ywDRjjorCLrw/77ReW6mntuRes+Jaas0NR3HJRzaghU83Noe18IC8DZmO24r8CNkdFKDVdRPwKV/Wcrwy+dWFtLs+DeMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCjrqrgZ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCjrqrgZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776845569; x=1808381569;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QA71R9u6xMDmjAGA46M0/RbHtEUUj62I3NUXDHdVF50=;
  b=BCjrqrgZJUThm9PPQ4AW/P1f/FP6czkXqK1iA9epiLrEMHZaFL73JF2R
   oCaqkwxCFjg/MYxrZWEIcb7qkXuMrH0SoxXNnEAdTpdL4DPrPY+BRuXpl
   +4EscRuo66cCkmWoGeO0BcjKud9CL56nBBFSgFHqKK88fFGiFlT6UmJ3Y
   5jslTygw04wzM3nZdyoPP+SPzO4uz6VdDP7iMovFs+08vL0RBIg4YC7xQ
   twO0J2FOXbH/qW4tiHSUYWNgLkpsFhiiHxI+H0X3Tpt5S/x4YhEJX3Yjl
   zQ2PkopXvElTnUHztxLIK/xWNh+TCT3mOwkAvTv252++/WfCz1udxjITG
   w==;
X-CSE-ConnectionGUID: /HRYgOAyS5u3soCkB6soCw==
X-CSE-MsgGUID: w0nbwjcsTDGm7JH6kA63SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89179689"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="89179689"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:12:48 -0700
X-CSE-ConnectionGUID: wAxtU8VyQT69rfrQW7KEug==
X-CSE-MsgGUID: 694sRZreRkijuLBk1G+Ajg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236289977"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:12:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 01:12:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 01:12:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 01:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KusokN7R+tVPghkJbkPI5oNfDs9ZvABjJr5FqQkPCcQcNnJUnQ3fPTFaimqChjGfx8z8b3/Z3c8SVIV9oepUbmjimhCT005AOc9XbTTjmNzk7xJu2uTQXNSeXFhx1sWzxD260zEUxzlYcFX9/BI+deYWDQ9f1/U42LZb9r5E9oZGc3n1xh5JfwbFH808Eh9OKUTvGsWyPzXGUC7Wg68N9vkrc6O7ER8x0M1DEgKVKc8AsLqiZ4NKTDyRslGPOzK1Q51KO7Z/zekQbfiuGgSwBa9uxHqoTDX7YvxL0t8FIj/W6lzrAvwzvWeVMbxergEbNGeN/I9mo/p+J5Y7VwljiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sgn+wZTUsPcHu5DWhqYdZ8M1kDr1FfPr4FZ7PARHew=;
 b=QGC3xZh1tEh8Qb3Ea6CwqUq0miRDsngDQ9dRlScQ0/TdDQsBvBp9hEvxzPliiuZrvVOWMBIKBr9C5Zk9TAA96t9zG6sqbU8v7u9quS7nnVP7igirGj5HuPlN9gjYVAtRmy0dMA8aUxzyzNHf3jiGZYWl09oDTdJl+w/eiX7kS0hu8kRkcmzupriPjesCVKjFcZp7mD3nROFMPDH9c1zNAGf5UxGKRDREx+mFxoWlU6jEmw7Zi84kh3VnEx9ESOKcUxdrBgj1ThShBvA0hzGU+C1HR6RQUdwW4QnnSAgpg85xFILsph4oyCdyNj4ktiVJfLi7z75vQ++KR0eNAjfISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB9527.namprd11.prod.outlook.com (2603:10b6:806:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 22 Apr
 2026 08:12:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 08:12:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu driver
 for noiommu
Thread-Topic: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu driver
 for noiommu
Thread-Index: AQHczFOuuqfc0SHbYUui55qaSnKQFbXhSYCQgAKI2gCABvQEUA==
Date: Wed, 22 Apr 2026 08:12:43 +0000
Message-ID: <BN9PR11MB5276DB15491F949DA7D8F0A78C2D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-2-jacob.pan@linux.microsoft.com>
	<BL1PR11MB52710F2441FB52E2D94D37868C232@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260417145946.00004418@linux.microsoft.com>
In-Reply-To: <20260417145946.00004418@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB9527:EE_
x-ms-office365-filtering-correlation-id: 11ed92d1-0ec5-4c65-1940-08dea046ee37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 6swWCNoOmdVFSeGViCHKRUICczXMK+x55bXdBNIe3kgkFM3hsScQpl+8NjdjYr6r5iM5oow9Hx+Ai+Y+u7TMB57AO/eu7mJqXhl3urgpUMMMbJLWRj4CJ4DKykR8iBJolKL6YseB4Aqzpr1HvAC7D5Ievgf+HJLs2dMoIkdhpaOiPPfVlfyWCEAFgYb3LJWMNZ8+bGLP5h29EvF5WvM1rmt3wz//SMlOroaW2Xl/7+89H7YbrOhbyIRC1dUXlFm2AaJVrf6p0+GMKY1TUD8iOkYct+xjohjW0DaubVUgJbPBG8IeRc4w6KOPNvyCHOcf5afCs6QMQTG7q0q1xokdelcfK4XZYeifEFF6lWsL0VvBATVWv28ujS4xaM8sDg2Iv9qRybZt1Ma+6HlR2ez05oP2ZEBI4jIL23xpa0cOg+YNqrneLxgJfXrU75w034o7ya1rt9Ng41WytxWFUG9Y32yVuRRD3k89dKt+AcE0BVm8fDf5E9A/cUcrI0ytLYgRIGImSsmSAEWgRymsu+nRGmoom2GoHlyKVQiA6rVieFqEXP15XTIgB1XxPidXN3tE/3ETeYknqanvt5Sy3i8spEBJA57UQCqMX04MU3uZ2JcHnbnwbc+K0qj3RVCg6LiU0YaXUN7UK8TftQh+2L9srykclm0ppPWqnwrekfngx4ls7emdeKda5eiVufC0+sx3igHlTADcwbRlz0CbSqhhiBdxxwSkxj8NdGLSFVL/rmkPq9vM8FhmDu8mu56vKf9mdBKJO3nTn2fhaK6XMF4Gm+zUW1u2bi+Vbpht4qziUv8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bOilhlQQFTFLmjFEi8MDTRGqRI4Gm6ka+gr8bTfJcDxauEe6U76XNhi4kyHZ?=
 =?us-ascii?Q?ZV8GcHMbF3ZCIrd+PF9iqisaC7vEu1To5NkJQBmtybiyCTJunZWHdPe7btpd?=
 =?us-ascii?Q?ehadqmID3IvSv2RxBEhrCMV0aFJxhl4P2lQD6yfSrmgu+XkfjPTuhLgu/FVL?=
 =?us-ascii?Q?LcPaHGvxve92YWlhfFdWnh7EzOYbqSdJ8i36negotHe9/SX6lvg7v3S5m0uf?=
 =?us-ascii?Q?u8ltxdb71FJRW8yYzDB6yms6OR9AhBIhLAxHYI8jxpiHvHqdGOFM3ViBwFIF?=
 =?us-ascii?Q?GgDVRYOx9vB/HeB2uX58JfHVV/HFfPUJvdGN6dZ9SCjghO37K2O4ACG59c6N?=
 =?us-ascii?Q?glo7GqwNXpQ1iLe199y4DLIaw6iU07rcmVBi40qspkLlGcqedK7duBZx6p+T?=
 =?us-ascii?Q?m8gUXfZs4SSE4r+GywbCFcpJE7EyLs7h7DOS50A+JcTmepf4Sr6P0LRtu7dq?=
 =?us-ascii?Q?wLTXrr+XxDS3njtXvCuBZiCELK9x2VxCfz8dv4RDiuMw0GwCGfQmCY+qb4u8?=
 =?us-ascii?Q?7h9hdvQIIPV8Pq/gnj0N7BiqWva9lx5AJUkhp9ztIsCOfY9MFA6JFZOG4e9l?=
 =?us-ascii?Q?XehZnweAsnDRvEIJtyWPQpCP2BSHjBHUkOFKGjX8rcyDmMk9lG1Gj4VwAwCg?=
 =?us-ascii?Q?t2oc00cslp7nmlp1k7UoUiLE7M8C51RPhsP/IFoU/0OFb26rvHkLKbX1FtHN?=
 =?us-ascii?Q?GnxdXrtSWhY+R1t+zGKeojfQAKkD7OZQHVdc0K29XD2PsG+KprNxuZuI/rJS?=
 =?us-ascii?Q?XgJs3r4X6QoTJ42whlyuOJj7ku2usOqYGfNuGQSQ0HjTIwwhPla3CuoVmOQG?=
 =?us-ascii?Q?z9KtfmbN2RsWI6dtQSeaVq/6Hlwnkk3sHhi8x2dxZ+IuxbMa/MEFOEHz/dch?=
 =?us-ascii?Q?Jmiujr+FU7Nbfz1BG0MBviDlPsiOEpuLFUk2JX5De8GVld9q1Kj+Dx0rk0Lv?=
 =?us-ascii?Q?OQxa+JkohdfFCWymwaHy36AGlJSyGupSi7BQ+5PjhtsvZiyHEaz0TXxnZsSj?=
 =?us-ascii?Q?E1CYZue1NN/6WwWbvHvXIVjtu+97Ttd6ndzpmFhxLRhKB09lmxEe2r0XD0nf?=
 =?us-ascii?Q?HCUUvBd5MZAhnGnIu37B3TBN++KNiESkeGxlvewZt8VbpBk3fyaPdvIx+F50?=
 =?us-ascii?Q?sofBfU+UjMKOv3nRBzY0+dzeOTIZ7gZ5dKZw21NLKvx+PASL1S/WhmJWpeFb?=
 =?us-ascii?Q?IyInNWVQm+GeJB2h9yBKdt9kULuww4hfxLTJgCsdaKO39SVpSpBtZ/OmDOuE?=
 =?us-ascii?Q?0xcVCKs8y5tqFI9PqjFcCUEXGpQXVkXI/CmS7jtiRyzJrofz2wL5AKFPPrLL?=
 =?us-ascii?Q?Q2uCMiLdEXXOb5TgWgJYoirDucLI5CIdEVRw+/Eud0on3MttzgKTLKgxUWtp?=
 =?us-ascii?Q?36Omu/QZ5scIjW9b0V8uhgp7o+NqTNfnMWXhsIJHZNoySurlpYG91AQoQihY?=
 =?us-ascii?Q?u6IYvFvr8rrDFUwKn2JkzAb84wGhF12726G7TUdbkrUHiZjS5YGHdSBnVWrD?=
 =?us-ascii?Q?adREXV0IUeZ9NNPr8/yaP8FWBUQChZhugJTJQyn+D/9aiCr+RWvVWlSwh9gF?=
 =?us-ascii?Q?jUW9Vocee41guD6nSegiHA74EOvm/P+lxuoslaTkBLliwCITOmt0uBLcGbx4?=
 =?us-ascii?Q?zE+JISGKCJzjZc/amz2rX0z/3t8M0ynX1TaSiylO2fzk/qKGlswima+GkH3J?=
 =?us-ascii?Q?4LtQ0aeAWmFknlAq2tMBTqmpR7u+78GrNsCzvmysIyWWBG6q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wUMPXGNrcLDTrIWSM54sSFO0E8HNtQP7Ef+x6R1LRWhS62v5K64Ir86Erz0JozDSuxIHJ5PMVE98ZZ20TS7q49gAX4wlcDqystg0m9ZxrNLWvdfVPiI92KsvUdTzRy/F+MnBE5hcuxP5Suobb1f5oIjxcbc3NXIKFEgFYme0XEODe5jXkEtEVQZEm9iB5CAQhQXLwuCV4Nj8ZgRlw/mAKTk1VObunz7zcdgdCwjeJBzMQadZzFExI0zQZzVV8orfS/ypIk8fJdz+HrZ0QC6YpIFyd+QOx14F1eBKmMHi90uOGXyX5+Ft9PDbMCpx+JR4BBv25uKsygVZcP5WQfkWwg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ed92d1-0ec5-4c65-1940-08dea046ee37
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 08:12:43.7302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZ6J3g9BG0vLOPRuZlC26XedHLYfqsFYaWe/QLmvzdfIsRWYhJKs/4O+k6eIf21TkPVHBPfRi1XUIHjvUuboIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9527
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Saturday, April 18, 2026 6:00 AM
>=20
> Hi Kevin,
>=20
> On Thu, 16 Apr 2026 07:25:57 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
> > > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > > Sent: Wednesday, April 15, 2026 5:14 AM
> > >
> > > +	cfg.common.features =3D
> > > +		(BIT(PT_FEAT_DYNAMIC_TOP) |
> > > BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
> > > +		 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE));
> >
> > PT_FEAT_AMDV1_ENCRYPT_TABLES is useless here.
> Technically yes but we need this flag to match forced features since we
> are sharing with the real AMDv1. Otherwise, this will fail with
> EOPNOTSUPP.
> static int pt_init_common(struct pt_common *common)
> {
> ...
> 	/* Requested features must match features compiled into this
> format */
> 	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES)
> ||
> 	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
> 	     (common->features & PT_FORCE_ENABLED_FEATURES) !=3D
> 		     PT_FORCE_ENABLED_FEATURES))
> 		return -EOPNOTSUPP;
>=20
> where in iommu_amdv1.c:
> #define PT_FORCE_ENABLED_FEATURES
> \ (BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
> \
> 	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))

Okay, make sense.

btw iommufd selftest just removed the amdv1 format (will be in 7.1). then
let's not mention it in this series.
