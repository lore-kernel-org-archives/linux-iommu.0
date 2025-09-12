Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC122D3EDA
	for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665050; cv=fail; b=XpLv/uPe6lRb8Ud1DAK0d+KbQxC5CNSqzJp9vloz4V5tjkNm0nC3W8WMaISTPNrrHgY8I3oVjfrme7WqfZIEXsnMI9OrqFXn2gXKlfl/iuM2N5p5ZZ3U+xGcWPZLnkzXyYE8FST1Ne7B+6C2TP7oPFDhuNL/Dgh2myCzcCfVqbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665050; c=relaxed/simple;
	bh=TYmVMVxuxNy2KEYfU7KqtWbcJl3AVPCPEZkI2CHhOpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kixc21zRsY0WzXqUFTpH7ca87VYqc/4FhMqpe5EYLRL1l44XZ0qSnPA7E9qVX49reuPLsgLrJXyDMs2J084asmvUPA6fdv5iH/ujQig5fzSDbA4mN7KhLmtVR7bXzFnU9OJB23cjVSHINaHRD+p2a9a3wVaJ2JSsEH5g2V+GU74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6AQMvW+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6AQMvW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757665049; x=1789201049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TYmVMVxuxNy2KEYfU7KqtWbcJl3AVPCPEZkI2CHhOpw=;
  b=R6AQMvW+dp4cJEtv8Hr8P71p41mRUFyc/MkjrLUc4L+qF3aP7QXNvlkw
   lj5Ttmmm8UhvOXxFpmRY7JuVkWsosHSIOC3RcfzhdTN2U8xIxK8ns0O6s
   tAV3SrjSBFxVggmGk/+8dXSl6DtNSzQalWXN0aPMAXyxh7SeBT8iaZyKH
   KRjjtuy+0aYrfJu9H5Z7hGKKqiv2epOxq6+HS2zhwFB/rBGrRJ36/4AfD
   S9EZlCL0CDby0CQHT8J/UbuUsB3gN6nFICJAptnUOG8Bd+w0tbf9T2JIc
   WtNr44Gat8szoacRrENrwNTUDUHAzy93yiDC0/MPEqyRgsY1Q16EzIlyt
   Q==;
X-CSE-ConnectionGUID: omTtsDluRJeTOAll6SeerA==
X-CSE-MsgGUID: PUXOVGIUTGuO/5q4LC+l4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="62638161"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="62638161"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:17:28 -0700
X-CSE-ConnectionGUID: opfWhuoNSECG5X6v+186gA==
X-CSE-MsgGUID: CJDRC5aQTAeM6mztut8lyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="204907368"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:17:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 01:17:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 01:17:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.40)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 01:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THEu59lHNWT3hAHAld1l4ubsgDTMhb7Xjp0+9Tkz+aKJU3imrWKAl9G960X/R/eVrjGXCTiqcjmHIIti3hgElpGKHHjTdHU+7JN6aDI8jTQXdirfHVnrpb6Ynewvivg9C0SZ6c9+ZX0Xaw0IFkho/hmhv3shegtfMUomW+CqajZlFLNNjTC4aUhQq832q4v3VAAcK3JqT0SC+A9WdJD+ADcbfSg8WbhRvgHrnSmPy9pk4rbSJKTIl/cK9fmAWkTADt3bpV9p6BolcM24eK0+lZit1PTI7DKfFgNsQGhm6KE+nUwEnvgSLlrFiuiSkMTUWV1lKFfBFReBEGGVy1M/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxF7PJejtdr3N1VwTckZsmmjU5MhCzD4I07HrHphlSE=;
 b=FgqF4QNlZIftyXu0rVffwyMOAO3p2nHTHPa7HpuJZaEyp9RP8AyBetpyM6IGYaejJma8hm6yKE9jzxnd5rLqu/73Vw+L6iXQ7RWP9E/JjMAU9NjqyyuFTDtMY+dfgaUTxRMI0sTplQBP1ciOE1ZKONk3Siu8SWHwZH+bgJ7y2Zchoxq227ygC/F6Kwt3glYX2emt40krIHA8Da7eZTgDCzFIxNxhOYdLUacM1fps0e9yaFg/YHT91nAITXlV50kugF3KQ5aBFGTXisckFXkkLYGgd3vyRxxKQB0mWM/ScEefXJJV3dVNTBzflIye7/RjjSyBDASvTok+FijxnEg5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DS0PR11MB9503.namprd11.prod.outlook.com (2603:10b6:8:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 08:17:23 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 08:17:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jann Horn <jannh@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Alistair
 Popple" <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"security@kernel.org" <security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page
 tables
Thread-Topic: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page
 tables
Thread-Index: AQHcHil0+WjIl5Nj6UekRoJQglk8lrSE7b2AgApQXWA=
Date: Fri, 12 Sep 2025 08:17:23 +0000
Message-ID: <BL1PR11MB5271A6FA21418DD8486089AB8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-7-baolu.lu@linux.intel.com>
 <20250905184355.GR616306@nvidia.com>
In-Reply-To: <20250905184355.GR616306@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DS0PR11MB9503:EE_
x-ms-office365-filtering-correlation-id: b5ccbb5b-4203-46d4-0c59-08ddf1d4cd37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?7RJtpNH6byAGwGyoe/nXpu6gIzPe0qlW54YoAw2Njlx4u23UQBRJEzMOgzTM?=
 =?us-ascii?Q?WyI7gCLe3lILg/pyvk2d5MUQigaUf8Y7oSGhMvVFcgCW2kfusiTt9SttEUPF?=
 =?us-ascii?Q?hR5iGEmqUscZoStimPL5NkjtnJX9WB7Uchr9nS2Kqwm/zzziwkgvC8jk5fQm?=
 =?us-ascii?Q?Ax+bAJQ6uyHvvE8JRLW8Fhi1b6Fli+A5AMuvhmtZCMRntvXaRrjFghG4JTNi?=
 =?us-ascii?Q?/XvwinURQvN54ESswjMirg6f8ajbFxmpCLaUztFIwD0/+F6bquTZJUjKWyi6?=
 =?us-ascii?Q?/5qdqzsYTLnl+hCIYtQdg/iQQLOjiIq6ojY8tlpWl8ISMPXOXYruZOyuLa+G?=
 =?us-ascii?Q?StADEvsoxk3F/UJykLoxkjCDtijK9fdf10jJwJvHt4hfn6MCqdmyjUndwi8W?=
 =?us-ascii?Q?aaC2e5JoMWDYFzf7ySrevbmdu7uugw5BcgqTpMkHDEUVxTab8PTMtTlvmYaM?=
 =?us-ascii?Q?cd4/FyXDzazWDEQOcvQM+PvqhChM28QNKnWGGUISxypl0wf8kFbOXq2DHF18?=
 =?us-ascii?Q?OCvZqw55+eIcPS7rE0Be2pubOrrSJgYI63j6e8gn5sSeWFr63uK07KD+Juge?=
 =?us-ascii?Q?cxLVCOOkxziyth2oM2mSABNjdvuw35hmRuZUvX+qLyOJmd4i5yFGxaUqQ1Nd?=
 =?us-ascii?Q?5Whx8JDnaguIDfF9WmZLPwA00yODZI+JPclH1oKwEqAbwkhpERT/fCZpABrI?=
 =?us-ascii?Q?ZbqduDQ93/F96VaHyXyuZLVK5HMhN7ZHvRWLCSYKS4XnqQXuAXakxYdFwLOY?=
 =?us-ascii?Q?prNVeJK8ZtNu5mfS60rQ0mlgp2xofVllsbA4vavU/f8wEEvE0n3ngnNIQL3b?=
 =?us-ascii?Q?lz1Jw/LhRses1jwbtJtG9cx6nGpM90c/RQkHg0PG8iaFkrkt+Fk13+bJEqor?=
 =?us-ascii?Q?brftFj0+k645yeLO4ssBWOCcBse2lsGQBjkhgzQfMaqxx8RHhCoXPafTCecj?=
 =?us-ascii?Q?1vbpmEPowJoOuRnfA6inaDCjKizVujpJourP9jDNgquqlSNvfkSmVUc1p8Jm?=
 =?us-ascii?Q?64v7p3uOgb8WDMK4j4FiQVqOudX9IeTDmcqduHGMBfn7BJniOzOvHoOOf9lb?=
 =?us-ascii?Q?QSfzgPAGSC7hmT2tWk4CoqbM0+HYfmfRgmLctwe49R+5lZkYUyw9/Uc9meNd?=
 =?us-ascii?Q?PjfSca8sz385vNs4yOBvCyWII/YR5YzpxSF3YrpaOcEAZPdicnI++Vw4EKvt?=
 =?us-ascii?Q?Q8C46AKqn2J/7b5MXgVDxmvbPEaDjaBaYiFAK663t75h5PrWTKs9yN3CnCG+?=
 =?us-ascii?Q?ju8cM6hPgUvlSr2BIK5II3lNReCQ2ELtmaQEI0h1ftRQGo9+LOQ5ym0SXVzZ?=
 =?us-ascii?Q?GMBLwInzGR7fp6aRhT25FeaBiFrEOrFXuQmtX2hNNdOZ3l4sAte7fK4kWSd4?=
 =?us-ascii?Q?UWYbucSsCTPrddk4euQwICN5fvUDFnx7dkl5/rKyfyTNOqnxddJvbW9/wdQ8?=
 =?us-ascii?Q?MgQagDG4cjLGZTQ7TrOiGh2hKQ69g71wfLWivSZk8Rwx/SzdUFrsXQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9YyF43+eobaDW67drQYSLpg/qXnqRpH5ErR+1wynOfA+z0wrxk4Tn+6WfSpN?=
 =?us-ascii?Q?lRI6MN8C6xn4ncTrrvT9K5GbtTGPw7p/3lcDXnK9lWrWzeer8lviOex4LbVm?=
 =?us-ascii?Q?vl1e8RSHHpeFbfnvEW2XjIGMXQfql23SPZko2I0rnJPeSl+intMjBFija4W8?=
 =?us-ascii?Q?HEMTCAFDyPXNY8Zt4h9QZpcXVsln5UaLDJJZCNwudV1bXD9fkwqqZm0auDc6?=
 =?us-ascii?Q?919U150FINr3WOT/kKrqrygmc99UzD9xzt2VgFU4rC2hJX0BJozY+CmWP7hR?=
 =?us-ascii?Q?prA2QtwuZfG5lv6YZrKngO7x8hdgk3l0AFub47QHsLVVkdy5XPN46ElnBQO5?=
 =?us-ascii?Q?RCnmth9ugyhyMaplCGCk4ZimESnblZ4r3bPHSLs+bIt8BpNMY5CWZzfdujP7?=
 =?us-ascii?Q?sSGVH9rcZmnuHHJzvPwEu+wBN25a1scAs7ves/NQtPsGbNAecIJnrou4LMnm?=
 =?us-ascii?Q?nou06gqVDs2/SEvgBO6Z7qgmQ7J3Clv8fCn6kDntp5lRpC4eHuHwKgHs4TUc?=
 =?us-ascii?Q?WG3Fcry/jsz/pGpArdjW6GVFcVBbvhLq/tVFdcf8wlUGz/M44lx/4VzlTkif?=
 =?us-ascii?Q?hGgPqtxIzwu3Y+6hCfRLAVs5FFeChBg8lYigD+UJSASM8JyQEa3thGn4DrHR?=
 =?us-ascii?Q?NJqVnf4Ixk9GfUCstmubWBqcvuEIG+XfCPDEScjC1XJojJMC9Qx54M0sUAJ/?=
 =?us-ascii?Q?4kKlOQ70ZEBKTvhtYkI9T0Zwn0qLRNQpwOoNHvEZXavV/DnYxb4HwYQcLb9l?=
 =?us-ascii?Q?hHNSCV5wndDetnwdoFoctm9cEkAmiwFsySrgkL1uxXJ+/H3MeyQWK80+sVR5?=
 =?us-ascii?Q?AeLCxRIa9CI5JKV9sA0QhmhHOfUMYrO5G3mkfvEfe4vqzGfNNfDJfAyyo0EA?=
 =?us-ascii?Q?+7e7+Hd/PNAJiNFXS/Ljewi4ypnqBTYekYnoFEUC4QIm0pr7X/rulslfHnM4?=
 =?us-ascii?Q?PVhxhYFMRnxkcJtIgOTRmWt1EF/P7kdTa2WKOjNaugM5rjXBccUhD1cPXBnH?=
 =?us-ascii?Q?iXKbJhr9GBQfvRFis8gD9Kw9hOQrp64Nuoxxd4RdeRsCExD9RsdgOfJp5FZF?=
 =?us-ascii?Q?Oma+w173iMAvn1gLXtc70zUvM07mGo26t7HAXz+pkLiDPWWojzN3HxP1PoFA?=
 =?us-ascii?Q?iwQYGMyte3QYmSSDmYEupjr/C//B/be13YajACGl/agDhx76keXw2/loQqN2?=
 =?us-ascii?Q?QFhuiBz57Ob+mNCMJOLb+NIpx9RvVeNv/HnRZpbipqO2dtgy/7iF6cmYnIIV?=
 =?us-ascii?Q?LiHAhskOpa39g8M9lJBBXm1Uzp4BroNFfJ1Jr7wgdqGWk/3tn6fcr5ZQ5CjG?=
 =?us-ascii?Q?IiQC9HgMnpEHeq1GuziVhQwLuE2XGFF0vN3+AdORe9lmSZggi2ra0BMZUnFu?=
 =?us-ascii?Q?c4nBOm9I87K13BIDJ1DOiJvQp1w7cbrYhvG2i3R+KLDicpiw4f5HzWCD0R2R?=
 =?us-ascii?Q?TMskttGaajiZH6nGo6I5LPQdy50FdbxyCULEEknxMi7WhVW6Pukwj5zHFJgd?=
 =?us-ascii?Q?lJXPKc/GiEDNfd1KfZRsYd0kGuGtD3vK0nyJQz8hedYwh3dTWXstouOwGOty?=
 =?us-ascii?Q?EfZw99lOxxclN7XDL2buLl1rjXp1gr/5YIcxLeR9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ccbb5b-4203-46d4-0c59-08ddf1d4cd37
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 08:17:23.4412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iM8WWg+ZUk5HuT5/nRNQygkk7B5YECcY5/3iObWxVSFiMElqjVjW7ciEfNREPQoCw0n9UvY45QZvp18WV+DtBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9503
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, September 6, 2025 2:44 AM
>=20
> On Fri, Sep 05, 2025 at 01:51:01PM +0800, Lu Baolu wrote:
>=20
> > +	list_for_each_entry_safe(pt, next, &page_list, pt_list) {
> > +		list_del(&pt->pt_list);
>=20
> The list_del isn't necessary, it doesn't zero the list, just _safe
> iteration is fine.
>=20

if no list_del why need to keep the _safe iteration?=20

