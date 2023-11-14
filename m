Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAA79DE
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN/TQKmn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699931703; x=1731467703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wLwhwi3bOWICKWrYXtp3hhiVc/fG60tfyQFEH80q66U=;
  b=bN/TQKmnZ83rZd+NSQg4SUKxigPtFj9sZGmYjgFzG8eTRjymCDJISUzv
   0kb5rTo3ZZhaZHe9wLdCPUb/lO1zVDAa9LLr+XLy1EJt6uIWyDRkWdupc
   3jDEoAotevnoJZk1FhGu5RWFRcgVovAaGVkbbhwLHaiTb2wYKi67i3e8y
   7BLFPOGq136CA+XVY6osBYeBgqr80ZiZ/bMdOMg5eIvaw2g6Zb1vkxqf7
   4p2E/5DJ4WwvN9ETszrtAdelydUdDQKbDFN+VwHbQ77XlS6s/vU3fp7Wd
   kuEvMr3PFGZPaABRV7c0RDuX2+9GHyrrJlUl7SIhhg6c9ugizDDrpt6ZO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394467413"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="394467413"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 19:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="830432144"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="830432144"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 19:15:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 19:15:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 19:15:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 19:14:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYP1xRtlHDCADjXtnOIvlDL10g7mlG5CwIIaAmE6Vka5gj+r1hjXYMXiQ/6zk0oh8GKIxeHx8fZsfEOXcnrXijNDFNpv2m3NQ7FvkHtSJ4iVnqXx1fy1xtoA2Ovt5ZAkjpTgl8HgV5tK8Q2zXkMPKs11XVoIVWjSRjThiaHfVnP++DmeYaFAO2G+92fZjsBtjklz6RIHLG8hi5ZmkzU4YT+gRf54fr8B0x+3F4p6kTk67VHD6+THOxL/+en2ADGMAwqzDlYi2fAYxUza74LNNm5TRXOeVY0ro+YTsfIPPa+KpAG0vN9wN+zwcNHafI5agnOzRoR2hfOEIvrYArkxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLwhwi3bOWICKWrYXtp3hhiVc/fG60tfyQFEH80q66U=;
 b=KnzSNcOrETDosj15LgePAtwt5q96hsPMHL7R/kLjVL3lYE2kHc5tNVEoBa92GvCf+ZuDJrMbYOVxzuBLZAUo+6qesKVP/uWpfEY0IUHBlceQNxiuEeKO1MCeMmHrLzUP/bjBPl1bo5ldcrw90YOfjQU2YXGGTMsfXlXVTHbnZe/QLUPOBUDoqL98oXV6H4X9SBIXmV/PEy0ds1nRhp2ck38qagC5ti1bc74hZpSG9h0N1hdK89qxUIeAfuyVIJKyXkxJm8+z916ma0ZJMK/LiGfrUYb4qRlcos7V0h2e1jBB2qn4H9RTGSxtL3nYblFEa5pR7xoM0SfeN09/2je89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 14 Nov
 2023 03:14:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 03:14:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Thread-Topic: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Thread-Index: AQHaFpgBxWBJti3g4kChnloBJh6r1bB5JDMw
Date: Tue, 14 Nov 2023 03:14:57 +0000
Message-ID: <BN9PR11MB5276394E19F542F5EAC7E0B08CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-3-baolu.lu@linux.intel.com>
In-Reply-To: <20231114011036.70142-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4830:EE_
x-ms-office365-filtering-correlation-id: d2ed30d5-14a1-4783-34d0-08dbe4bfe19a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iALjMptzY+yJtujUqunC056WVCo4hoRUsG+bRf4YBHMOiEDE5Wtq3qUqBg7PAhXC9ninqQOKJFsZMrI0shpNEzF/xojFhVLd7XzILu19ZCu/q2iK0CybgxzUOrNaXsQWQJH3FU1Yt0Ts+5sdE3k5r/fCmgnPDkFWK+oVxv6c663ftDLLxWEiKrB+ZKKZHo/pWHd3t2HuA+nnmSQ2cVcDg97h6tRBSCJOyWi+EiU2u/mTIrPwtjqsn4CMaczd5wlWZ11UoNEhfQZWGLag43nAQuNkxgpwqTI5qOPHnyfwNI6vsRe+Zfbwv3/wvrhTAx6o4MvW5Y9JuZGUBLPuMKnu15qIgIvO9aIl38M5OAMOI65h7Eqs8P2w5WCPzq7GOnx3hsDCPLwYQKlRAnrYoWjlq0ZEr5soqM3IGwyV9+0KAwJ/h8rNbp9/KTpQR5oNBvnBpDpaImc1pkP44/13yE809SvZDlyV/3Z5QsRMNutDxeIWkM+An+DfRr3CL6m9Ty8PudMilWuTLy68go8eTfMUbog1AGbTkhQcmX99BOPBP/gs/0NfZmYJaBI0JElluAJiQbJ/KrsSq8wK0hhaZnEPF0nHmVr1NazmwqnC4kXbaJa2gbinwa20A0X15WHZP0xl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(4744005)(2906002)(55016003)(83380400001)(86362001)(38070700009)(33656002)(26005)(122000001)(82960400001)(7696005)(478600001)(8676002)(52536014)(71200400001)(6506007)(4326008)(66556008)(41300700001)(8936002)(9686003)(38100700002)(66476007)(64756008)(110136005)(316002)(66946007)(54906003)(76116006)(66446008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6/ufnWYdBx8AnJozsc5dRDu6CaU24FNYZUqqfAH/SxDXmh56wjhbh0hrXXjk?=
 =?us-ascii?Q?1Njv7IvLuXRpnIAeQcJ5mmROgXncDUjiHQ4ryq34+JiqA9m1pj2d3pkIp4Fg?=
 =?us-ascii?Q?+xNemQVXkWB1WiF7IGle4TnBYDSKBcikKU4OAN4QARljptBvSbDRVxxrb2tZ?=
 =?us-ascii?Q?jCLKyecv6/e8eov3l3f5Hg4KEDU7qS99RattqzHM0y4P7b6Vqd4bHKMmXiF7?=
 =?us-ascii?Q?oqbZAVcbexlNaERLOFbfxNAZ4JcTj9lI+5Dz8lQBqb0qPtfMDQVhjfD2BLLK?=
 =?us-ascii?Q?UjqTGt7XO2X1f5p1Xz117P6mRXtCM1DQXLeeJNmmxSqWliGQB44bzbLPHO4Y?=
 =?us-ascii?Q?75Q1YYMGE6NKhmEX2BiBqkc5xYWdvpeXR2P5W3/VFkZf396nGzXlKjfloK5w?=
 =?us-ascii?Q?l5xeAshw8kD6YrOzzST83js0zpa7UFa+YvnYZT2fWlJyeYCdMeNx3GNKuO2L?=
 =?us-ascii?Q?1NbxKHh1QvA8JyiQHeVxy9gsMoLKqUxuwLD4achtfJel77o5ahD2Q61ADSOT?=
 =?us-ascii?Q?l+HyWAvgeIvwEMgYJYFoK0M8O6v1Vb5HibPH8D43zib710K1fwEXiV4ghfHX?=
 =?us-ascii?Q?3qzjP0BufrHwn+sSGGTdxdvARxhUXojMNYNW+swYfPhJq2PTUvNLqoWCLj4e?=
 =?us-ascii?Q?lEgeTCx1K6ny9AfB2s3QtDcOJnnjgvKG6vqBXTt8ZSD/2vq0xNeIyraKzqEa?=
 =?us-ascii?Q?xh6stzHmjDrOgV9OccPJ/8QCH5Wh3HaCjlLXuPWyNmVhLjYP9EBwvlLVCFsX?=
 =?us-ascii?Q?SX5cL6/TsmRf6tSZOIHzqHhptNnWySH9szL6CP3V1o7e5W1YJmJe6XQpkfZj?=
 =?us-ascii?Q?ajV7O/PkX+xSkEJ+XM4/c+amMk/5IJPNrSRShCipeCiqjCYtR6XoOjR6mbqx?=
 =?us-ascii?Q?CuzT7BRhYio2lM83azzzMHQ4GBGiRY7VwWi6ZOMUNs1p2xM2ES5pUC5fVcoG?=
 =?us-ascii?Q?b0EvNELnAvRD0Q8pd8IeYuxGH+xN+eV5/71a1vcUsTbz/vDBMBAW4eKXdeXv?=
 =?us-ascii?Q?l1B0MdxxuaxFW0EPjcpIX9WfVB+9GEpOxK7NZH+Kvu8bZkLLQmJ/uAGl1e3R?=
 =?us-ascii?Q?0C9g5sdgPtFp+hys8a6BJbBfJrjn4LHtXpNoSMQrKUAgoVlNGwSqn8GfeniW?=
 =?us-ascii?Q?YjlsXpKE8xD6SkGON/TIIOarjKkV3C6jBPxBhQmkZihj7QOzzLuCJjExYaPf?=
 =?us-ascii?Q?jgRF5xtjexoqE+x6qN6N7DNvTLiPX1Rx36jOuu1AhlYyCl1P2Oh4BaLctZhM?=
 =?us-ascii?Q?CDWvDv+MqTtyg7QYWTT/tn1Mf+Vb7Av4qmcA7PN6RpixAAJBpdRxMSvdtJuA?=
 =?us-ascii?Q?nWQsW+6OJJDim6/98EhPzb9QHmvJKLmr6PHTaMNE4w/vpQtUo3w9XFSqTVUH?=
 =?us-ascii?Q?+5zV8CA4P50CCHeNZInAw89pIWkAgApvx/QbOkgyu1/XcQQQQAXvfYv89vRq?=
 =?us-ascii?Q?nuYz4wwLn4BkiCwGC0NGJ1gBEBYJ7uepukpxbPlGB7v/kVE4UjCx7ErAsVIX?=
 =?us-ascii?Q?UAsj/5xnM4ng+mAGbuzfrdcEHUDWG/0iXeWTZjIW+K7mrwU/F/USaVrlp0R7?=
 =?us-ascii?Q?BYuThth7mcCZ1ZE87nN0jpWaHksUV0JBtXaCqNfq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ed30d5-14a1-4783-34d0-08dbe4bfe19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 03:14:57.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6K0y/nLPikVVwgQQ+jcsLDFQCKN+7lcri+ETi9RGefCdju040QecUcC2XlbzqeVRSLiJ2ZbzFquSgblUjffXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, November 14, 2023 9:11 AM
>=20
> When IOMMU hardware operates in legacy mode, the TT field of the context
> entry determines the translation type, with three supported types (Sectio=
n
> 9.3 Context Entry):
>=20
> - DMA translation without device TLB support
> - DMA translation with device TLB support
> - Passthrough mode with translated and translation requests blocked
>=20
> Device TLB support is absent when hardware is configured in passthrough
> mode.
>=20
> Disable the PCI ATS feature when IOMMU is configured for passthrough
> translation type in legacy (non-scalable) mode.
>=20
> Fixes: 0faa19a1515f ("iommu/vt-d: Decouple PASID & PRI enabling from SVA"=
)
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
