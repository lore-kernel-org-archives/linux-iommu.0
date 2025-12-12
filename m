Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A3228CBC
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765526268; cv=fail; b=kCkIHUPRIDKTylvMgC91kH+b3EV+YNMd+RfE0tgPH6fuuqz1ZYyS2kyZJbvN/zwzQNHNhdITra17NvhXoJA8Iiad+EJBn0wtHdCHvbUqch/J5Gd/MM962iP+RudBQ6QbaXbfn9WpAOI/4izZkS1v6Jrr/XvBwEogf4itWvOpQIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765526268; c=relaxed/simple;
	bh=61eF91MvFvJcSmn53Ye/FSvdwRBULpMVcmRb9v8Jl0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LMwKD58v1pRz3vZE/fRsBK/rhnkwyOjHtErnWxPkcxFtQggvG9j2DYJKj02yDCgWZ3gnAzdzeCMKoV1eG9+//EXVUVGLyk4RoSQP8PUbAvM/QL2m54oJB40OBeadeOVup6WOfJSzlvfoSmXAkzGsvpZ2ETw+C7Ufa22Tl+P0ZOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRwe4ZZP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRwe4ZZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765526266; x=1797062266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=61eF91MvFvJcSmn53Ye/FSvdwRBULpMVcmRb9v8Jl0A=;
  b=JRwe4ZZPFLaDFv4GFLXUF0HJG6ifZR/REsTQplbebKZct3bmkOGnA4BP
   2MN8mTeTyB9moSYXze5wy6EaxRxxu25YABWkENooaaT+X0F3eJX0JKu2/
   OLXkCtXFk+B7nOKLM8Pjms44W2Jzo8ZSmFt3DUy9kGN4P/ulSao8FbR/h
   ULsNP+AUml1sjwZxhQQb7hAKZZsn6VI66lfmbv9WWm7HlLzHpmsJ5WINK
   RJCtFhj0CScl3tgHhqetrNegF4N6BSZfQnGfsf8SNl7zde2F1apgnnjCo
   mMQEWvwbLdK0tY+5i5TrcJ1LWi5k7oHRYcyj4p6nfd1yAolfyE9uxhc3X
   w==;
X-CSE-ConnectionGUID: KLvNGY3GTkK8ore7nNNkZg==
X-CSE-MsgGUID: ztg5BdtfRgqzOQhStH2wHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85121684"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="85121684"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 23:57:45 -0800
X-CSE-ConnectionGUID: jHha/nv8Sz+SlMVG+hHD3w==
X-CSE-MsgGUID: 4+QRBLUIR7WszzX8wq60FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="196926868"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 23:57:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 23:57:45 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 23:57:45 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 23:57:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op2/2hl8gsb1wmSL6egTLk2VElgElK9Rn/e6f5Shmkgd7gUdPxIMK1vlH8d3+GKmG4cC7VJ6GGT+H7589B2pqYoBlv93KuZlfCZXel5msLPcWlKHqpcrGImDrScqu19QyNFB7f6PLhJFTzKNsz7inwLud7F2BiFdzZ/jHjBoyX6CV2CIwh84tc4QFhh5aER2RfursASzUVQH/NEx07eh1aOF0ZwVVf6NoE5Bfla8CNrq8Tqv3BqO9pCvnRvTtRyTyikKqUY6BfDyCGEm/JfRlC2u8JxWDn/Md09KSk2SdxGBq8+wYA5l2b3iPqr4p5J6MSyFrEmGcCrAbT+t/fdMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJ7Tkz8rC3l9R06bXlFmIoWBMG8gzZnLQlIkXlSSFi8=;
 b=O5NGgHqqAS51w9Pd10/h4h4g4bwU0AQuKuqKBd43pTxnr6fPAcY9g5OsjJXpCzRidoTmlxEk3M/F5XD8Tfuul9mrrVDzKUOXqtzi0Z3+idL3NnTACraPWtINLzHfLpH1inZqjDSQF3bGPMySHvLwz+aPG7jDrFjpuD9ROiWdi1gkhBoRYoxR/jGVTQntQcZVEvSqeqrqNVAkUBnFX58w0kW7d5FfCCA2+A/oUbtd+/Kaa6qb3HcEvfIKkQgk/qMQ1L+BbdwUjHboA0Vr4YNGCzqZx5XcOxj5KzYeU6kh0LpdiQGfVDkbwmG+Pfbe04sDKE7m2J3/zN4JiN1H1GgZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 07:57:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 07:57:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [PATCH] iommu/vt-d: Flush piotlb for SVM and Nested domain
Thread-Topic: [PATCH] iommu/vt-d: Flush piotlb for SVM and Nested domain
Thread-Index: AQHcaCO9+6JRMIxbckK2Z5LI7K8xMrUdqFsw
Date: Fri, 12 Dec 2025 07:57:37 +0000
Message-ID: <BN9PR11MB5276A64C850D1D3C067DD1008CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251208091907.74719-1-yi.l.liu@intel.com>
In-Reply-To: <20251208091907.74719-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5097:EE_
x-ms-office365-filtering-correlation-id: 39c9acf8-5c70-47a7-1531-08de39541e37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?zYovCPsfaCb5FGd9xGrND49Nd9XS7tfe26DPDzLDAztptUnJeBWj/J7+NfeM?=
 =?us-ascii?Q?6evkG/U8ffKzCem24IXtZgRTkrlj0gxr+7PVOz1bsdQHXREy53Pai0CXWHys?=
 =?us-ascii?Q?jD2OCb5i7EaJOVKlxzMePS/QQMKuiC+bjpBJ0Mgtghmfe9nDvppj3DDVLNAV?=
 =?us-ascii?Q?3OZOzaPr8xsSzrf8c31pNf+vMd/irE82/jeyXvkdE2w4kU5PBjv8SMkugxdi?=
 =?us-ascii?Q?4gFYYo3CJw4J7pWjVfhjoGdfj1v0rsiaum5c+Fb6caKr9R87RXmjy0X1F1ZE?=
 =?us-ascii?Q?m7lU97bfhjQZljFdHuq4KuvRKCfni1F31YtRMFaDR87uv/PkaD3ICmKej6Sp?=
 =?us-ascii?Q?NQP5JaExMFBkkbGSI0uuvQGq1XqQlcp0p3cGKyG8KQ7QLiu13QMhn6rrI8nO?=
 =?us-ascii?Q?SruBvueLsnH6u4SxOeCrOQfhTbY3MnaGVaLcGkNTpdSY6TGR9DI2bhT61NQU?=
 =?us-ascii?Q?xK4oIVjNUTHfWwW0r1yvSxumQ/tiNusfMxaSZtv3NnIjBGp85j0/rcnOen+4?=
 =?us-ascii?Q?9R9AcYplUOrlceENiuJTEY4iQJ1kYYw0pjSf4ig3MU0IHm2mPV4iAVYcVhY0?=
 =?us-ascii?Q?xwppRfy0mYc+NSFsrw6oA1OIcNadxjZvyvNrBjSkjjSWUUdh7K32cmF7Wk7A?=
 =?us-ascii?Q?uByrLkXFm/X8cbYTrUtYI/mNF05AuJper1mpa4WFExyrtUDxoeE/kBPsQC7H?=
 =?us-ascii?Q?Cdgw65JQWQJwL7LB0xHaTKOFgJDSJUX1q8xGftNKeLEbafPscaByt60G9cw/?=
 =?us-ascii?Q?pKFLGgDpVNlGyY/fd+k6fOQ0c4b0xMBcjdBNLUg2cXMM97LNblD9pdFaJtTk?=
 =?us-ascii?Q?57Y6M7WtxsLeEM/j+Y6YU/iwpqoNBp7ThIMchwNM//E1ScsD3LC2jNAgxQrz?=
 =?us-ascii?Q?ApE92OZnrNjUxq330yFyaKS9fsw355At/wdJVwgVDT5725JYxFy4Nk7TRs0q?=
 =?us-ascii?Q?HqWREtcQm9lv6KSb+x+CMAXd3+mNI7CrA0gxyofSCVsremv0J6p5Vq8gd2aE?=
 =?us-ascii?Q?3F3y3LkJ++pBCA8WcwbZ7IQFLS4wpShF2M6fSmSByRmtlanD9ctvjMvb4p8c?=
 =?us-ascii?Q?ob77abzP6c10DSyda/rpn+GA5lvjCc84Kq8Q+FhK+NpMJoCK4esGyCEQPVBC?=
 =?us-ascii?Q?ciZl0XxdwueYLWTMf0Grc5bhvKk93y1uo+ITwCx80E+Nei56mGUuYfkEyKVy?=
 =?us-ascii?Q?2MKPVCyCaL3uLEIAJI3NNbihZGZKZQWwrOMsSL7r82iw3yBhB0ibkkTNCvKJ?=
 =?us-ascii?Q?G5BFrgnzK+/QiIwPvgBD/cHALnsvq9YHREGXkegkti2ssLWiG6srHuGpcXjM?=
 =?us-ascii?Q?f9t3uABxt31/tvWZRS4SpqSIANWrgzw+Nx/ahm1/pEsyZbfZ+XU2JrWDpNA3?=
 =?us-ascii?Q?SQN62ypRcLUPY7Lveb6e18bib4JL6Kd3+YkgEFNJGS+jiEX93trVaNxSRUrU?=
 =?us-ascii?Q?POvdB2vHSeGcI3cLdM7BdhQHTVtLnSqRGANfPVPLnxiNHCdB+zDmL2GZTGbk?=
 =?us-ascii?Q?+Q9xyfltsKj9f0mXpLUz743XaORPGnZCEiDC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CT5LdKXrCaA7dBn8cFsI+2O+BIe00DqF3J4kQ8fOUsTWy4QFYr43ndk/gPss?=
 =?us-ascii?Q?A/byTYh5+Cwq6XbJW1BIUF/tWzoC1MDa+iordgkPXPZwwGo51r9KxtBE/ouQ?=
 =?us-ascii?Q?9XUMtieTqw7Yk749s6X9eEnwm8eluRBI1QqJyS7GP40rPAT8T8vmlBlD9h/K?=
 =?us-ascii?Q?0FAFrHAIleJ/e7+ZHDCYR28JDlWm97EVpidT6/dZ7Mn9kNjdPkZyFNVEA5PS?=
 =?us-ascii?Q?foV6d/nnYr+vRXCfLyV2xOTkgArs+zITYY4f9KojZUV0ycNQFl0JFM7tBYoS?=
 =?us-ascii?Q?UGgZRDxh3us+WzLfQBqnU7gFRkExHeBCe3UwGrxtzLcdYev4iZSZNOq9/lRD?=
 =?us-ascii?Q?YSFEfClgz0SEPDGsc4fzVuFEyPjSSCDtXmuvT+wNvcQp+78srXc4ANbOP8lI?=
 =?us-ascii?Q?fEFWjY+tKoLf1cLt/eds0G07lZYeA4v5v10B1wKbBq5pJtQwBtWXXaH4IKrR?=
 =?us-ascii?Q?zWnuxTBbINPtKPEhdsgXwA7xfcaJQPomE4JDeoSUE+L1J1GCUNAAm/0EkwBM?=
 =?us-ascii?Q?yPlOP/j9q4yuUHih7iBjXH6qMOD/E27dj8dSDWBc8IY0vFSKeMYW3tWqp0Rw?=
 =?us-ascii?Q?8xG31baNtTc/OWDlkgTlWtQ4UBmsW5d5yMT1P4/K0pFpdthVLd3WEUmgPdAe?=
 =?us-ascii?Q?Ym8vtF9BdGDPsyWcPqhgtBSH22oD/k6RF4iikNafhIinLkSjw5wQJOvyAoB2?=
 =?us-ascii?Q?jiKtsOZmGymncguTpFLeAepJQ1atLvqBgnlhV8LL4QQ6MBmxXeWbyitpEU/x?=
 =?us-ascii?Q?cnDefaRH5TQoXFeRFxOzlvPyJDXTj6xt1g78921HfMfc+IN6hXStQhZPfmWv?=
 =?us-ascii?Q?+LxBIyH2zy+nKJiCpYrm1VSB51Jxdq66K6bJ+ovvQkuJTG4y+TPcdXfglnO6?=
 =?us-ascii?Q?ZgZmZGTfTxkoH08/q67QOY4atCiOUqqTQq6KmOr9Fud7OuUnMe9oNFSlu6u5?=
 =?us-ascii?Q?bTFBHTgHpHZD/UxuOxbN9qIAjvrfgysiy6Q38yVfAjg+sWiiMuUACFTPHtdL?=
 =?us-ascii?Q?kCIXgdD/HT5VfwpSIWMxRtokuLj5ltB12jDOBtYQ8NXCJ1C7+xctC1RD5lsT?=
 =?us-ascii?Q?6hxeWgxTxOK5rhnD7GES1DnJy6iYnCSc2UmFv7aUOFNGx0ASvFIdCRTi2eBy?=
 =?us-ascii?Q?rkLuu6L5KE6tYADxmNVuCam7uN4p4RbN5yuoRguqoaUOXi9rJ1j14KNTRZ3i?=
 =?us-ascii?Q?ZoNeeO8YBGMG4SVXdy+uw4RdckfsCLdJiMQz5J/gBp9qQsF3uiRzMfQa+UfD?=
 =?us-ascii?Q?9ZkQCyFTjyMXYq1JPr/Kg8389unlz/2dKxA3zBnmvT7RmdkL6Ioge1vRMbNs?=
 =?us-ascii?Q?kRWD1+iblBhHN4ca5wGpd6VvEf8nz1Aos8O+CwX40H7cF9qkVA3e7y/iXW7a?=
 =?us-ascii?Q?oYeNoEg9uiy5mzmjMQMeXffcvutB3chvy5mFwDsRub67C9QZRpDYtZ/437OW?=
 =?us-ascii?Q?XONzi1r0hU6Ms5tVlMoT4IhMYZaN5aZNxENGoauNaEK8/CbViHd4983UEpxL?=
 =?us-ascii?Q?0UmEgt1hhSrFAw2IatecjJbEfmJMftIMX8IpFLrNRIoMo6kA9g+BIYUiLMmq?=
 =?us-ascii?Q?JFZpCl+V3e1DWI1MZFRYe3X5rpTmj7d1DaEh4ren?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c9acf8-5c70-47a7-1531-08de39541e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 07:57:38.0028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKPEI5DDM+e9gq1/1cGwTI1mn5BL+ZQphJYJSRAIm+eecqzAyUgBJ7LzOuoOPiN4OYkJ/xLG6XFmkmFXP5ZXrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, December 8, 2025 5:19 PM
>=20
>  static inline bool intel_domain_is_fs_paging(struct dmar_domain *domain)
>  {
> -	return domain->domain.ops =3D=3D &intel_fs_paging_domain_ops;
> +	return (domain->domain.ops =3D=3D &intel_fs_paging_domain_ops) ||
> +	       (domain->domain.ops =3D=3D &intel_svm_domain_ops);
> +}
> +
> +static inline bool intel_domain_is_nested_paging(struct dmar_domain
> *domain)
> +{
> +	return (domain->domain.ops =3D=3D &intel_nested_domain_ops);
>  }

hmm it's confusing to have a _paging name covering svm/nesting type.

they are different types.

Instead it's clearer to introduce a new helper e.g. intel_domain_use_piotlb=
()
which covers both fs_paging, svm, and nesting types together.

and for svm/nesting just check their domain types instead of referencing
to the domain ops.

