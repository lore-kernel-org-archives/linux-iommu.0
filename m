Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC12D600
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 03:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286719; cv=fail; b=E8E6VaYyUXxbSegZ3703llAym5JTjvVKF9xIwC9wqsN55m7ge+Ju+ouZAibeNETVcOnnvVSQtRW8LFx4T/W4aSTbgo+odasUtjepUo99tgU3n3eCmgERIpaO0aMQIe/k5yQ/AqZsuym/WE8Mg3rb9E/StYppsLm4R2k5rZD7MJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286719; c=relaxed/simple;
	bh=Yl8vIrPKQ5FZEf7k24SkzxqPKIRRh4O2b/4X+9qHPSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n4Oyn/YlPt4hhKKB8wW8E+TJFsyLJxaVwGZmOx9Vcc5cOWXUn/QmJzVbeLkeemWvcJ2xhkV6SkEQOPoTPwuPK+QVdx3iZ5v22Ej7MkrlQFzjmbePJ3ngkjG1laiKfZFLriJ034Di6U4FBjV9KKoX543zcMKqGk0djCUO+i9Da0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxaEWZmL; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxaEWZmL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719286718; x=1750822718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yl8vIrPKQ5FZEf7k24SkzxqPKIRRh4O2b/4X+9qHPSQ=;
  b=nxaEWZmL8LpNCo6aeRs1p35Lfwijnmg92os4UsHqvxoNZ0PlXVipcx0Z
   87+DG9xz3Ji3F8qmS0BXf5lNUGUz8A4Fz+Rm4RzHpmtLDXqxg8MDXsEYS
   5xiMWkoQSBMrPNRpHwyD03qfBLr7ela1Afhq/DaQ/QDa7qyUrbkv4DTeP
   AN+3nDHPUw967R74bNPaNdJmd/9XTIm+T+7Gfoz2OgINi5V80Vh0AoIzn
   qAW6HMg2i5D6PF+FKrdDEqnu4xeoWqXU82sbJ79Q0XIyA+YvyjONKWNVf
   SABXYHLO6sVwg0ZMpQKWOUtlaLhsDriypy2ARrWTGTPs2omo01Sx2KN11
   A==;
X-CSE-ConnectionGUID: G6SGylLuSl6uhyrNUCuhjg==
X-CSE-MsgGUID: BZ5Wk3QRQNqjn3fyOm/UAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26971762"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="26971762"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 20:38:37 -0700
X-CSE-ConnectionGUID: u4Ib7MJTT4ChPZu8/uRAtg==
X-CSE-MsgGUID: h7kO1MwFSUekazf9bqyoNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47880853"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 20:38:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 20:38:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 20:38:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 20:38:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 20:38:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVZkz+CJtXwq2HFhE9YxTg4OiLg4uvlj4IJp2Fl8W85tMssLhXTAVl01kI8jrESmvdMzPm6AKZ5gwZUa67Vd2RgkH2Miv9ZYrr4BsRpZRFWTrekZ2xRLAomjzFxkNFyahJR/buu35sPKcfGqxrjX75/vrR1kmeRQlN8aWzSDEL2oPzNQYRmdq2yDp3+bdmQYTkw11CmrBGSZIJ6im1+mDDXd1waJfrAGIxg2iApCuvKrsINAUv8wKClaVuSQUACnVa2Nyv7UI5H3ld5ysydFE8g1whxAzqlF+WGuoR9K08dSvr1oNvSqx6OjmiIUoHmbJY1N71xIrc2LPU6Wrt/F/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl8vIrPKQ5FZEf7k24SkzxqPKIRRh4O2b/4X+9qHPSQ=;
 b=KM0oOKHSrufcKZX/UY1JM35nuDutcUoOzXI7u07IJC0/GSMzGc8QnovyiPb2M4PgHA9Vj4XGCx6q4Y+QCu9gy7LXQ22+hAqJK2VrR0BlA9J+b2zxNYkIJ4+SJCx8y5IFMykmym3TeT0437BEDDZBXtwnL2ivxHlof74WBwqf5dLWjJNq+lg02b5xOfQTNyBzzEhF4/z7Zqxcc2OBGTWK3Y/jXqTiQZywMm7YUqm7YPZKVjNKBMTNrTMw6Q9nyDxl6QXzOFRafkT8D0BCDKP2jsVelOJVx1bwbjn9mSoMFHdJY5VCLx7YnlWAkCHwYqsT8RF5PT0lkFiGJ95vqyQLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 03:38:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 03:38:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Avihai
 Horon" <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v1 09/10] iommufd/iova_bitmap: Dynamic pinning on
 iova_bitmap_set()
Thread-Topic: [PATCH v1 09/10] iommufd/iova_bitmap: Dynamic pinning on
 iova_bitmap_set()
Thread-Index: AQHaxAsAuFEREkPVUUKmF4GiXLHXFbHX2hVg
Date: Tue, 25 Jun 2024 03:38:28 +0000
Message-ID: <BN9PR11MB527647553CC48B598BC79C8F8CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-10-joao.m.martins@oracle.com>
In-Reply-To: <20240621184254.45477-10-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5148:EE_
x-ms-office365-filtering-correlation-id: f8b70095-ba76-431f-6444-08dc94c84727
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?ogPuQWvLlXCqgfwuNs/CpFspyK5DUPManLj8kW8KtaBwj/RQIKJk3J9mmAsv?=
 =?us-ascii?Q?NMjqUXH2WzHitDVfLblqrCeMWtCkBl1ccOKKlrv407tk6MxLhJe/I5b3lytu?=
 =?us-ascii?Q?SWEwt3rCpHEMmk7Y6oU4hPxYS477TZvSri75YHscqsfDYfzHhJB87ASJ7igj?=
 =?us-ascii?Q?Pda89Ssy3s/VReVrfdd9Yqa3dYGmzZHxipDoy7pDJH30M+ZZnlCKw3x6LpA+?=
 =?us-ascii?Q?j5aCvzGJ/korJ6rujkezTFKtZfGsqEJaN+zq5cOrAPeJymuELHqca9slJE8X?=
 =?us-ascii?Q?ocaqKTG2OeYvQKzz063CRyiCmEI/3x1RYJUmpkukLmVXBrEkrxZ2+kmtVaIM?=
 =?us-ascii?Q?DhG4qPZsrtQgRFHu3RJSgpwSsbAZuQ3FE8j9sx+k1jJwxb8n2AipWvGSpY3f?=
 =?us-ascii?Q?gciku43gruGIxBNc6r7UZMnrqWSwyLi5DBrGvKSP7mhZPNzmSHcvKqQfFI+r?=
 =?us-ascii?Q?pitKzFyd5nmiND3QXGm+Wnan+zbN1kwUOYMztUj+XU+YMEUf6Bl9NoOmZxY8?=
 =?us-ascii?Q?95Oy2pC/ytRXuZ0AxTamNcFTcEAOksQ9tl+URMq2fa5/e5H8/F1YUo6LloCx?=
 =?us-ascii?Q?51WI4j8Dfz/Mmhpv7zMnu4tXR4dtjHSmndj1yFsw9ahvbaP5FkU9EuHZuBv0?=
 =?us-ascii?Q?eArVsVZDe/KcI320JAwOsfleQkuN6C1Owmn/vT4P5XFLQWY0uYTBKQcnzstG?=
 =?us-ascii?Q?udH0NDgP98EEhn9iv900+SvgW4I+wwilnHDhtOySvm84N0ScIGAhYY9QCSku?=
 =?us-ascii?Q?X6L8IHPJ8YehBpmBfV3DWWXqkzOJa2RtvYUtw1q6GOtfYqMJ8djPvyRMVgXJ?=
 =?us-ascii?Q?Ls5zzt1SYCjP5OP75+NYX15KYF8OUMUgiHUWNRviXOgxCLfV/Jc2U7zv+T7F?=
 =?us-ascii?Q?jwp3O40ZK37SZQecaFWddrvEhc6TVDq5QInDb6wWrXSLszKjG/QLmYVQUrnj?=
 =?us-ascii?Q?2DB3lRyXyphfDQeMmagynMOYCRTwCAauhEZn6fGb/aWyZGIAsaIQn2FQx70v?=
 =?us-ascii?Q?dKyyzGFMqmFbnecC2doQpytdZjHbjaqJJCnXY1E1Aw+Ywyhjc+B47Gb1tpQV?=
 =?us-ascii?Q?xFgzx4S7GmPSCln2/2R4aCHvNt/LVwNqa9TJrBoFHKy2JIwhNZKMc1hsGPER?=
 =?us-ascii?Q?jHN4tSoszL4tktQGdZMAcSCx4k424N/oZ1eMz+Ybho4AsptRo0lLSyyz1HAk?=
 =?us-ascii?Q?kWkyxjjtKYo81gg5Y7c9NstZNSrnP6LI5TwN4c8JNqKhoewF1SAuRQGeme6v?=
 =?us-ascii?Q?eRMGEpldnldPMeszkTcTrbcAhqcjwD5JbAitEiC2CNwQft6TBOyKOiHKggrs?=
 =?us-ascii?Q?EArCQ8FXCijKlKqlVXYIv31//qTCBH+AL+CQ6tQ56NceQJRcnsnqEPebUbWh?=
 =?us-ascii?Q?zta1Z/8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?56N8Sz016pUl08WNTHqr6m7G9f8Iyd/7I7SEeml3mTB9XkZ1XggdMGmsIIrg?=
 =?us-ascii?Q?3rGEKFmUdTplT0JVe9Xxi98yi10UrSCSvQA21Rh8vM8uFOYTxu4xeEbBH7Bm?=
 =?us-ascii?Q?hEqSMKwOHLGd0R0uHcyrXyqsumzHs8bnp6wjBjCtgBD2p89Hg/6P8vZf90G7?=
 =?us-ascii?Q?jmML/mbxe1wq5gPJbS8oEWhZnUxpN5dn4CD9gxWZkXWyUqFrOX7vb+e4TNwQ?=
 =?us-ascii?Q?VhararTN/b4c3TXYMxaa/ClyU/+S9U7qE7T9PQF0fvxgjT9hxdKw3Zebxrz0?=
 =?us-ascii?Q?/5OMcD0tEyX70DhZ2iQ1ZYSIfD/QetkUru/Bip50VuYCzxkHnIwR4qIdR1bs?=
 =?us-ascii?Q?dXXtj1dcYjZZslQ3He+JM1b3AUGJ8h+X+xUwBuJ3JwUVM5pyQ/qjH5xFooYV?=
 =?us-ascii?Q?H4XwqkEej+2pvbs0HVFeykYLcMIWt5XjO1czryZaXnVibf6CPS6sRqQbTaEz?=
 =?us-ascii?Q?T+DEfA0MKpE5AQHb+JLaTb/bEh6ExTeLxYArJBYyyXIA5JNiNl4TokeoiWPA?=
 =?us-ascii?Q?/CxqkLSyce7VWU5a+w29kSEGrSdLztLBIvMAnS1oWnNCGCHWeKbesCk3Xi0V?=
 =?us-ascii?Q?aZKeMdqT9EKr8ytuczMwwIZfcaVNOMBZ9nXlp+E/hjC8SwrtOcdm3AOql3gm?=
 =?us-ascii?Q?lkuWGt/HbPTdHfa5e9BLyZSXt8fKc5+eppcTfajdyoEqlA8pymPW/rt6Gl59?=
 =?us-ascii?Q?cPTK94sZvEBDWwPG3jzCkm3zHeuwZzjb5T++y9KrrTyxXq6rmCYRSB0FFtLK?=
 =?us-ascii?Q?DXJmtjAIBUVJY2Q4xWAnjsXudtOhePWwZdn7RloFDczjd2CFlQIh+QmRaGwe?=
 =?us-ascii?Q?oEf5W2ihrucEyX0QWS30HC7qKoCrcH60v2gOSjmWQ7wl5jsdTlyw30q/dmHx?=
 =?us-ascii?Q?bxEW7Ut0ZcyuVAc0Vwr/Q/njZaiq2UNuDyRVDGGXv/oxYdrZf60XqNHqwksC?=
 =?us-ascii?Q?UpXNQJqqOdCUsB9e60A56wjo36NfgtQun0nfJIsTQsx2LccPvPdQLjB+Fd2B?=
 =?us-ascii?Q?RVhjBN3+Vey45ZjRp5V7iRCvbrE/fHbWcsvgINaA9Vh/W3wt3/y8VslJdsJt?=
 =?us-ascii?Q?NeINtMM08Bc264xxrDCpgO0nfARVbL/KeRmrDoQn6qgt8Zw40WT1EwLMIVZX?=
 =?us-ascii?Q?OXTGLoSxeSrvjmA0NmUv25vZ6zgVMNZ3td0//kntWf5F5trjGBDuUHTb1vC6?=
 =?us-ascii?Q?K9n9TS9gT/8OL46n18k1HX7lMohXFcGgCFzqVSHjOm0YSeyUS9s1YAxN3JQg?=
 =?us-ascii?Q?RJACxgFuvSGMbZYo7Kz2UrQY9GzhiSp4uAZXLry3h7Hbps1LD/CtKVTKMahI?=
 =?us-ascii?Q?6RtoXeQN7lIWcgffYgO381tBwMti1eL0hQPBoy6CODndn99ijBn/cPe2nlr3?=
 =?us-ascii?Q?/w3QIaiOkfJ+O0NmfKE8FEiUk6I9cpmSuoaeFhV3VstK89cdm0RHofuqpaoU?=
 =?us-ascii?Q?bNvu1/W29hmG0ZC586kytBE1HWExRLX46D/hCt5k+7JMaTZ8al+t4B250qIE?=
 =?us-ascii?Q?OEtRzMJ5NI7Eh85IztD1Fsq52YtF4hGylHwdt6tqRMfvV5EZb8e3+IqayqwX?=
 =?us-ascii?Q?JES0/XjnqRydnHP4fLmYzL+kkGSXu3cLfbYToEZI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b70095-ba76-431f-6444-08dc94c84727
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 03:38:28.7539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8an2ECRIn1iTh2pIkYrUMNY/VuAZawPMM2Y9O3H6svJG6+wVwAaGESfR321SPO1w3v4D5erKefVyKBWFhHKRCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com

> From: Joao Martins <joao.m.martins@oracle.com>
> Sent: Saturday, June 22, 2024 2:43 AM
>=20
> Link: https://lore.kernel.org/linux-iommu/6b90f949-48da-4cb3-ad9a-
> ed54f1351a9a@oracle.com/
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

missed a fixed tag?
