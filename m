Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D421199385
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506000; cv=fail; b=U34I8PSQWqAWTci0+NUU4S7mmC3M/WgT0OJK4gOnQWScRy6unUlMCAMu84f+bImiK1s7Kfbf+4HXL3ObqUHwCsseGMAa6+3FN4kZFYu+GxhvhFzFe6cmCRWQp4nAs2lPMUeVR9ltwYW7Jx3rf3ZmE86bjUxgyyAFGePQOQM+CSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506000; c=relaxed/simple;
	bh=08K3AAdybMkyE/N7hhKCcBuDtP2l/ixdrNHXnHopi6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B0+wUfo7e16Qp5DWp3l2W3X7pL2sKX8FCIMfJLVHLmQAesRZOJ1pIMfXeuYTk/i6V8BmncZ9QDfhL4rwmSRIylD1ZhbzJ0ldxOiS8WR93RlNEpoOU+a6n4t7vClInJeABDsKULkylt50s5cAU4v71qj4wryh1BkVYj5NX7AdMd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IylsJwow; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IylsJwow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765505998; x=1797041998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=08K3AAdybMkyE/N7hhKCcBuDtP2l/ixdrNHXnHopi6U=;
  b=IylsJwowT56Cdu4Ap6wCuEgW8bpiOuXEWrmQxL3s9XaYHyYriKYL9g/g
   WdNLVAczissIhUSWpp8BQL7OguWnStDHdAhgJLuJHK5QBl1KhyCS1tAmB
   RBv3vHYqpKJ83LOKRy2HyGM0XKqgyMRzN5kOJD3Gc42Sz16VBDSphCnEQ
   t5LKkVbZ7Eyg2vPRHWD05F+maPEDAdiDJLcTWf5PtYgc4/IqyjvXT7fzX
   eQQRx/nbAwun+lGzgcA+bjvcipo5wG3kpRSZfTdMyrfPsijFkTWXKQUI0
   ufJB3XVfEPzcA69Xx5pPZPtMnDJw3dVtT/8MV3ChkMxpe/zjsRbxX4u0n
   Q==;
X-CSE-ConnectionGUID: BFKLC6q+S/uOHGRUVnLcTg==
X-CSE-MsgGUID: Ai/jiDD0QIytFWd6/L8lBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67233173"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67233173"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:19:58 -0800
X-CSE-ConnectionGUID: /KqG1kDMTtmHua/TYilisQ==
X-CSE-MsgGUID: NBmqmFS8SbWRJ49EsbDv7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="228021230"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:19:57 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 18:19:56 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 18:19:56 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 18:19:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQRPiL8WtHRLn+pAetMvw7zOV5foUOdpMfiVQk8nslDIqHfEFnagjwQDgLtLua0W0qNVxFfjev56+bvlneSDZujI+Qcp3ht272tX12MnYButZvEOvE6uO+mo06ATF9uuPjaMGSr//D009H1SOizlhXsga4VsYNq0wJuc4zSjTA8E8FhUFj8xNDwFwVHt7U/GqNiC2c2dz3eJMY+t2Dww5iFsEk9wvV6osHyM1jfr9LoM0ypoA4+RPsb04L5133mu095psePeV/sYw6r3X8noYe1aB09PH2QXeZ1hVUkFuABoI8Zx35Sjd9Gy/fkUsVKnO3Nk6SQrGRn1SHVqVXZmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08K3AAdybMkyE/N7hhKCcBuDtP2l/ixdrNHXnHopi6U=;
 b=dtntLTSK+dsjAIVT2Nc2xmyiJVvgIXoEYaW2TA+SwpU2zF+oV428lhqrNC/ymYxn2JPzxR753SsKuF5qcQstQuuPowFNbh/ly8tbs45kv9Oh2z9LzR5s3o0hYsxDUnTvSBmuaB8yvL/yVdsEVH+rhKoIU2beAALk7QNUQIN7e3LFA9V5NGC84VptOQJAhVubeNFiNI49VvrozxDZK0GBoDYYiDsz8SzVt8KD8Nz3HVBOANE/jvg55nIdfC/qNBo9Ce60/svbp8UZsFXFoSZFxn7JAO5rE7LkPPevlX0YrrCE2HdY2hQvFbShbTq7Vl2wPu8Kf4ZJU1zig2eI1wUZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH3PPFF1A08ABF9.namprd11.prod.outlook.com (2603:10b6:518:1::d5f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 02:19:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 02:19:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Wei Wang <wei.w.wang@hotmail.com>, "alex@shazbot.org" <alex@shazbot.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>
CC: "aik@amd.com" <aik@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v3 1/2] iommupt: Do not set C-bit on MMIO backed PTEs
Thread-Topic: [PATCH v3 1/2] iommupt: Do not set C-bit on MMIO backed PTEs
Thread-Index: AQHcVLXXJqxzmZZbXUSb3yK3RS3Og7UdcfQw
Date: Fri, 12 Dec 2025 02:19:52 +0000
Message-ID: <BN9PR11MB5276976F1211E23C78FF353C8CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393D642190C5C04A0543236DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
In-Reply-To: <SI2PR01MB4393D642190C5C04A0543236DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH3PPFF1A08ABF9:EE_
x-ms-office365-filtering-correlation-id: 5047eb6e-c55e-4c84-86b5-08de3924ef33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?J+GMcJvfUHcArNrXItdyKtSZN5y1wW8H9xX+S9ptThGV4kflpSkj0krLdDvg?=
 =?us-ascii?Q?KsQvPXjbSKMZ+ahtCVI2AwUk7vh+zz6rac+BNLzYIhh/sPX4JyoJ9HzcM/2Q?=
 =?us-ascii?Q?kImHQEGqTYZ2CfSwK0GJOFVVvob1RNKqTyiHYNAjTyGm17WlAAHsR6bCWnaG?=
 =?us-ascii?Q?i4y2iUjMMpGVlfN76wX8Y1dM2/yKIAFybe3g2G/eePSbR/p5wB8U26IER+qA?=
 =?us-ascii?Q?TUoE393lJdy5odUb1He0SpHVyhoNDo+bbstftG6dApsWGM7k1cYYM9GXm0N5?=
 =?us-ascii?Q?6RbaA6ywNRDTdYhc0GGXUMIuh5oj0urvikU2gI+noeZjxynJZP9gjVZ52Z7V?=
 =?us-ascii?Q?aIF7flosVNEcIHJcbhl4JYcWjc1EBsRYWqpDGCkyKXqOgoVBDvBXUeskXmSW?=
 =?us-ascii?Q?b9pJqR3NPEULKtrquMeSXIeh8jlSYIq9MsK3wWljnEC3ykUYyuzqI2xaHkdM?=
 =?us-ascii?Q?ruk7dhkd+jrex1Ow9OcCojg7TiJd0r3cXFelnyBTLlDokogoWazV4h5BHr5c?=
 =?us-ascii?Q?slZ7Jcf5C0bj9Z3d0UoOBuO9iOgCrF7ODvAP6/0DfIGkQEyD1oFzXJIzVLF5?=
 =?us-ascii?Q?gRfPznsh7XBvAS6K2fBXGpU98ZZIfV3oeOkgMEitUd94KoJySPChEznUwoWl?=
 =?us-ascii?Q?59+/2P48hOWNfWiNrlmrJw0tAW0/8gu2im7Nnf7KGU6a9/o8ZmcJPPGkQCpS?=
 =?us-ascii?Q?Ot3zapaw5djWW9A0/xx8lyS8fhUV+Kih0iSu1pVmftz8cmm87fP7rJwr6qvn?=
 =?us-ascii?Q?H8x6226c+o49KDbeDbzZtU7bPrKIgaEa2Hz/ryLVjrLmpWjSIcautH+ZCJGg?=
 =?us-ascii?Q?cUV1+KwTB3eJT990oifxLiUIPxeCxU/buafdmx+xS416FkYEsfYDx27BPSAs?=
 =?us-ascii?Q?byQPbZ2IgWHlQjFullyoRGfAOyrJTvYq3zUApqreJ72ia4jm8zStI7OinkTb?=
 =?us-ascii?Q?t6H8S+donAhD3zXHNANNVsy9cHGl2AdHGtRRLY3wJLoovhmHiwjtfj1cBmXA?=
 =?us-ascii?Q?CTrUz/DXxa2BoAM2NvcFnArVj0k+6g+e3zl7Ng8DTV7/JCWw4BhaJ2t7VnEx?=
 =?us-ascii?Q?I6OeCvnepSg8WmlrYPOLXQy+dtyYMi2+QOoEO3Q1uVJNqUPWVmY20FIzU6uA?=
 =?us-ascii?Q?WPLH1bgDIGXTSrmi7d1MijqSlNyLWGPUc705rOaMRwKEDAqtdAqF8FChBs/a?=
 =?us-ascii?Q?RZGYMjnmgrpm+VUlBl6s4cYG17ssm9GGdgSK9NKxi2Osr3NlZM5idtR1+4d1?=
 =?us-ascii?Q?C7xdUWlvhPT7TBqpw2X0ap2RMs9kP8KTadJ2xBQ7xTS4CyTrYppEgQBn7TWq?=
 =?us-ascii?Q?1K9zPMlVxDAQ8bJuTcvDXNU/OXpMjt2c7uilyYN2T/YA+vQzNpwHfsiT2S0U?=
 =?us-ascii?Q?Ent7u7dFAWY98SqEzu6DTx44MoSuFMaxmXH6eoE+0V4Ve4f/85e32vnUzRcH?=
 =?us-ascii?Q?vRcIhbdRD9nRANBfC0mokuJfyzoIo1ZzaVRcnWurGFZBujp62zacgyBDIFDm?=
 =?us-ascii?Q?GfkYo7AxxVG1GGkiBHPPLG+13DXtVDy73FNV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ceAC+d+LB0q2lOaD2Qaz66wBqCAzECpacq9dSRLXL7vlaKkYG0/udI/AwBKu?=
 =?us-ascii?Q?ggH5/EAdG2tAQMpPasm4io45TUTqOjABsjaD3Vtpz1haRencZiFa+Gh4l3GK?=
 =?us-ascii?Q?/Vf5W4IEk2H+cGeA9E4qxge2czhMsvRQrar80ThNIdYHHchzHpdqL57kHttY?=
 =?us-ascii?Q?ibW6XyqYntXbxMLGPKF12MyjOhvcYG+cw/qlzjPnSiocJk7ShVPo6J0ekUrA?=
 =?us-ascii?Q?CWj0ZYP/A6WCWWVVOnSoBHZ/oiP6ND1C7vQPQ3RTWXtyaKI73ng3+GM1dmUQ?=
 =?us-ascii?Q?2Z9j9eUpB2BxbF5mlUMneIq+Mqgmg51RO1bFJ+fsLTaihkjinrqMRxObXUzG?=
 =?us-ascii?Q?X2i1bc80N8Z1wq7bElMIV/MYIXJb5Thn83lBSjKnHm++8UxL+NkrTNA+llRt?=
 =?us-ascii?Q?60vC9vl9PMLDdvKM98X234MBAToQKNUgXJMtkvn729CxCz4RxAuiWuvlEgLP?=
 =?us-ascii?Q?+YARZwkT7HgQraRdq7QceCbX9PoJkdTnysGPeEmF3h736Zv++LsLkorKnyy9?=
 =?us-ascii?Q?/TAjVE0no3JzUWliwYhbmTqmldNz06F6OKSkhJLB4zXp0NI33/28wKz+848O?=
 =?us-ascii?Q?NkpEJ3R4ZEA4/RK0zO0W1SFXPFFWDJgJvIB2eQ20rnEPu7GnBfR8JOpixyWi?=
 =?us-ascii?Q?elFrFxWjp0LtQlN0ryKcNhmRZ+Y3k8NP7b1/EyoytXcXgqI0SG8gKvXWKjRC?=
 =?us-ascii?Q?Yu0vEfesKhR3cr2KVkdMRIa1IxVUnhtP6Z4Bd55b7mSZK/AuaQp93N0yi+rc?=
 =?us-ascii?Q?qq32h6vJYH54mFWhq4W5vCGg0Msz48HVcz456CJX1DV3MTz3qhBSGa5Vg5vo?=
 =?us-ascii?Q?YDPbDodr57Udtrxybpxwiov5+DGSe82TyMKXpbgYB3ZmU4CFgHG3d+Z2OXEm?=
 =?us-ascii?Q?qxYe4EJYfW410VTGiQJLjkcVKBL3mX8aRz1RG5O191pzXGuoYdMwUghJZkZx?=
 =?us-ascii?Q?GcTBTfAuS2q71aXR3r6fgv3S8CGyaGia4Pawqh/y38rxzZFGhv4LTqstNI5y?=
 =?us-ascii?Q?wJDiWeHErk+va57+lxrgwPVDtXeClyLfBJMHEBCmR3D3B0I8Y7ge/L75EDh1?=
 =?us-ascii?Q?4M1/+IBUZHfxQRoauf+ZBkSRkFfYbPlg1yadsZTIDzaALB6T1sJmNInsazYr?=
 =?us-ascii?Q?AM7+zBBqVMlAYcipkRycWAcXbbVKUDkLlfyhpxwNc65rU9slX5C+4Wy/cUra?=
 =?us-ascii?Q?ppz0nbsKlWLpa7sTwYvT3V+vUR0wgVd1wl/8x2wCZ4Ug719LunQhhzl167Cw?=
 =?us-ascii?Q?92arepgBktu+fwEUuMlp1wLXnohI2TFWfEuVlqs+2Y5sUL1V+BLF6ef6xh5W?=
 =?us-ascii?Q?4jx7JajibjTAzNYAOMuywGHqvxtSKcxlf3WjOw75d+g218ciheMKs/J2IVJA?=
 =?us-ascii?Q?w+3LRkUCSXlvCmPxTuWUD5LvzjTT5CGjG+Zid8rf60XnWd6IDDCFTHGfzzrm?=
 =?us-ascii?Q?9uRytIn0NTpODJPjU0WSIvgxbe6mAroBrCDSE+rK8hEvJW7Pb3Kv+C1VlFaJ?=
 =?us-ascii?Q?nH+nWxk75ME2I76Ekxg7tq6OWycThtJ5WL8RLobTORVDAnI6YsGbZQU8MoUg?=
 =?us-ascii?Q?V3t6d88e2fUwWW7ioXeGbvDobKgcpAdzsgKkwaAy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5047eb6e-c55e-4c84-86b5-08de3924ef33
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 02:19:52.7347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3Hb9Gjno2yTcCYjYOJjGuvYB++bbG7N3DgLug1NBPnC1Zc+30e9V3z0iYIWMUYzq/ZI6UnlK0TtceF8Jbx7CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF1A08ABF9
X-OriginatorOrg: intel.com

> From: Wei Wang <wei.w.wang@hotmail.com>
> Sent: Thursday, November 13, 2025 11:54 PM
>=20
> AMD Secure Memory Encryption (SME) marks individual memory pages as
> encrypted by setting the C-bit in page table entries. According to the
> AMD APM,any pages corresponding to MMIO addresses must be configured
> with the C-bit clear.
>=20
> The current *_iommu_set_prot() implementation sets the C-bit on all PTEs
> in the IOMMU page tables. This is incorrect for PTEs backed by MMIO, and
> can break PCIe peer-to-peer communication when IOVA is used. Fix this by
> avoiding the C-bit for MMIO-backed mappings.
>=20
> For amdv2 IOMMU page tables, there is a usage scenario for GVA->GPA
> mappings, and for the trusted MMIO in the TEE-IO case, the C-bit will nee=
d
> to be added to GPA. However, SNP guests do not yet support vIOMMU, and
> the
> trusted MMIO support is not ready in upstream. Adding the C-bit for trust=
ed
> MMIO can be considered once those features land.
>=20
> Fixes: 879ced2bab1b ("iommupt: Add the AMD IOMMU v1 page table
> format")
> Fixes: aef5de756ea8 ("iommupt: Add the x86 64 bit page table format")
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
