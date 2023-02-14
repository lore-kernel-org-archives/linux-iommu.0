Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472E256A
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 05:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676354057; x=1707890057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gokGpjE8GcQ2QmdJ/+Btmqo5msaQc+/qaLU6DA+1HlI=;
  b=IMdNRnBU7XF6nG1Qaw9DpOYkmZ+lyATRX8Rr/dGR5cH4RrJ9Ifu36zGk
   JKOXiNLJB2kOxeifIvdMmR/+nICh8M+UO3aY736zoJYODtcHKi6zeQ9li
   w73uIPiPtiNTrYrq17EMCavxJi+pUSKEcr4uVN6P2HqhzNnHNw73UeAx2
   iHKe7VzMEu2eaL3SLt7HfCRlk9MRJA09xDDGcVDOmH3w0T34DC6bwdt7l
   jufgl2x/hFIfAu51hiSwruL5HL01/iNY7sIFJvGdw3FaVUQ9eYETBeLg2
   FoGulK/un+cYXYSrbqBMs71hRBsy1Nw5yiKDAcpQAZvf+0v4lekl3I1zl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="328791785"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="328791785"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 21:52:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="914616283"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="914616283"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 13 Feb 2023 21:52:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 21:52:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 21:52:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 21:52:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 21:52:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSxAgWfv6gCxD+7Tbzwmd26pP2ifUdcUfzFsY41wq7yIiKYokXCu32OLrihxYOmTLdbHtqjuSZLkyQ8gkw4X9J84VP+sLp9AqAXudtRuRvGsAjm+PVQhymVzxF0JHECez3ThiNz50hO9HERvYTr4QyMTk5D5WpDnG1d8YItxHMWPInh6eRL1l6WFxdlAuTNbDQSsWI6BsfTd5HL67vSseFeAqG4p9P0MfteqsT7Kg6yUpMs5W8tUug5qfZ6uSWssFGie+UHFhFBYLM5PBJDETBdgv6sL2DBsX+9+7J/79Vo6/BvXbv6YqCxWHBOO+oY0kcXpFfPO4gx8jTgyU0718w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gokGpjE8GcQ2QmdJ/+Btmqo5msaQc+/qaLU6DA+1HlI=;
 b=A1zKfx+r5FtYpq3NdZWbYfeKbnjWlsZ5mFNrSrw5VGJdomqEWfEHAZ+g1//HEr84P7MpVU9ifclhh7FhhXnZABA/l8Cgx66FMBl8YucZJXQrMRg0NG3eBf7pkPMQfj7lwPgM8Xwfn8Hi8sjstZV2wdvtxc6dVjvA/hPLz9T40TG1aBMx5b6MvUFhlsNlLgzxbS3xi2afqMvdJODnMsH6byV8aDi8iHeiE1Dj3LJ/yjj1ZlLEB05hEirJzCQ6H0fMZzF6Tet5GN3IdFYJWYEa09Fgb8LAhxYr4kQa+1nXfsowqvSOUH9tYSLXtat3+1ibm/SQrI9vvzJi9+YpDjImTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 05:52:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 05:52:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Yang, Lixiao" <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH 2/4] iommufd: Assert devices_lock for
 iommufd_hw_pagetable_has_group()
Thread-Topic: [PATCH 2/4] iommufd: Assert devices_lock for
 iommufd_hw_pagetable_has_group()
Thread-Index: AQHZP9WSUspexFdp5Umokro0U4wppq7N8TlA
Date: Tue, 14 Feb 2023 05:52:14 +0000
Message-ID: <BN9PR11MB5276CDD7AC71B50E35CC1C598CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <2-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <2-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5079:EE_
x-ms-office365-filtering-correlation-id: c275191d-e4c2-4e30-f31b-08db0e4f9f4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YADIGb+b71CP/As5b+v7ZpfKSeojij8Ibpum0yIl+1uHna9hCs+nrxMSBpd/wsT0Td41DVEP4vbFR9GvrUEkdZ9IFQjKRHQM2ZEnUJ8MGTTJamkfm3Hyj7PEjo28GZ5m2HwaNdS6uhnOrQsr8JkivFk9GfvLqbB8qWJe8Rqs8zCNYNLQWjdliQd5QHReK0zuek9pNlr7bAPM1EvPzHFlIl/8ir+WXwvZn7HXK0bpJrUBzoN0nL/lokaYhEaOHcUI04DY0RFujhrQihHW8x0yCi8KKkiI0abZq3SYQcPTqaCVl3zkhuQZN1YoXhlhSLbsWit3NNyNydRsit4gX79qZut1XFQPtMlfFLzRwlEZ1Kcw5PM+b19Lv44sUzkhXJOzKaYOaP5VRh2doZqwRYY6xkn9HLJ+rHp/9c+ZXNTSu0dtw8bfnkK8lEF3EurXL9ZvxEr7Iy6KsACyJhN48NfhK0yAxgh6o2hhlQRkIDScbvAcTVoTJboLxZSNe2IxMEJlKm/EFP7iNpWJDxn4DmzUlkUldvs4roGtGQ45AFtCk7hrpVVBMrc1u372ZQVvBIt4YPSlqs3laLwugcMsx5ymOEbVsXEeIZYWj90virZ1wYAHmwVBT9iUjj7dzxOcXCFJGX4nkNAu+1rsUq01+rM4u1ENg3SS4r/lYGrga0ecGAZxcIMc0GeLBPUknncFUrVLy7ctUnbTKAtNX8SxkjfJ5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199018)(38070700005)(66446008)(41300700001)(316002)(54906003)(83380400001)(66946007)(64756008)(66476007)(52536014)(8936002)(5660300002)(66556008)(8676002)(478600001)(4326008)(110136005)(107886003)(76116006)(6506007)(186003)(26005)(7696005)(9686003)(33656002)(558084003)(55016003)(86362001)(2906002)(82960400001)(38100700002)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w4DFf2sjcVIIzjl/Qt0Tldrkf1PO3XyZus9TFcwnHBc8KndCeMigSoAblIqa?=
 =?us-ascii?Q?1PCWQCZgIC8uBzlLms4zSeFWi1l1prnhOjj1DZAaRZL8E2bdIPNbqaGWacN9?=
 =?us-ascii?Q?E9LAc+0yG6typb541A61OZhQZK58q8fXAkvG+V6YbRh5bTLpKltnKpSIgSCq?=
 =?us-ascii?Q?0P0trytUA5HrxhqwehMcbRp34EE9qbDHVA2JwqPAfnzOXeLRbrMSZ9roKnVi?=
 =?us-ascii?Q?HrjHEh6QS3I+f5AlcUFb/Ri8DZyFR0+xseM0zo8JjWl28YVp34VgytSUXF8x?=
 =?us-ascii?Q?5LD6RejgM80AOA7C0CfVXJUAzpZW3MFcQiqo1Zc5H5xzDnLheLjd7qLx8yaS?=
 =?us-ascii?Q?18k7LKikhXNJNSK4ypH+RKlyVDjivwWjq51vTFzjtEcpsgTzGHtHwvmX8CVM?=
 =?us-ascii?Q?z8pP6+M7bHGNpSFBoU7tdoaAlIvieRFDZQcPE4kl5HPGiBRjRwZ98hou/K5W?=
 =?us-ascii?Q?OPPf02669CiDEaQidygZAXr6Bj88z6vGn7UX4zKKh4Oo6sS2i4zsvbmILeiq?=
 =?us-ascii?Q?DeKf+HcVBWDtZwbkOD/t6B0B//0qXSW51S4RYDkzhSf5dZ9ObWEixRr4bFyu?=
 =?us-ascii?Q?iIZKlYGbrz6bIzUR9aVBai8USm9DgsE7+jzPqExBDp+/qpoI7m5qvNqxzAfh?=
 =?us-ascii?Q?DKLnlxdNCQ/YMheqj5IiAKuBKmlDxJ5/3hQjPMginf5tfzQ2LLxLsuEIIB0u?=
 =?us-ascii?Q?u75yUhGgvk1Q1fZ8eeW8PiXLVwEDGFgE+kMRrmldCxSW5Ka8UY1E02knSD4e?=
 =?us-ascii?Q?7HhRit3UgE51U+QpJxjjqf2yQBc+IZ41J7ij814Er3p2AWiZaukI7kOhQFXl?=
 =?us-ascii?Q?KsNrVjMuWR8sDSMUNILRfZHLvmeLq+GNkksHypeea+Nt2TMJBQg/TuW+C+ro?=
 =?us-ascii?Q?Th3InKKTP/0YAcQJPE3OocGHxehh3uoSisvEogN1PbU1Fbz0U5MuUYlKQwTE?=
 =?us-ascii?Q?ryaq6+BVzQWPj2wFUE7Jr4jMVU5ewl2oq0F8LUUR4SeIw5VABEd0l2/8rs19?=
 =?us-ascii?Q?jG8bhfu4kKExJ38z6AjF6qmVvqg92p2IvtkG4BluYgrdyxpgBElOYMeE2AF+?=
 =?us-ascii?Q?O6+j3glVrv2x9Wl9ZMSKw/OANYpNl/z3YjKjGlulhwm2vwyiJtP1VkYt9NdF?=
 =?us-ascii?Q?pSfJAe5DCh7Jvk5ZnRJbFxqNT2ijpEbFj2naOikntpNucA/xPIy4OeWrfcw4?=
 =?us-ascii?Q?ZuTSdof1P/Oo6tnlW3ZLqdnzw2l0VatNf64R6MY2wCzFuhrPcZfHprPgHFMY?=
 =?us-ascii?Q?/kIG/h1NXOq8g3DP4QfaNp2VfPdhDtL5bxjJPZS2SWPP/NtdiBHgTpoMoEzM?=
 =?us-ascii?Q?/ZJ0muvW5beyiyD8dxzzKKoGcsaBGTIPkQVuY6BFINN4stx3VoqUc6iNRYlI?=
 =?us-ascii?Q?EbenjfibDqKHL/v1duq6CtI+OlqTlWcF1S3aoKDhWHKjVQevcQIpcspKsHSJ?=
 =?us-ascii?Q?VQx7zE6o+7RIm+8LQQ13NCZeyUkPbYMROah6/qpfmkeIbsrb4ExSqhzhzdsf?=
 =?us-ascii?Q?Ledl2VTbs6HqdLeycsQ+JNypIkrUP6TKGfZY8vyB1p5ai0ceFRYzaZwaWts5?=
 =?us-ascii?Q?XtAW6rEXlUfJmDDuP4O/qvBKh7eRM0QU28wAnBv4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c275191d-e4c2-4e30-f31b-08db0e4f9f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 05:52:14.0439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckGN9mjCPHdRsagmi3kQ16/dv41uFB9OGk+WH8X508mhvm/GwPBkTUE8PmVZJ+OYIPLCTRZcNkr7pLB76pxnSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 14, 2023 2:03 AM
>=20
> The hwpt->devices list is locked by this, make it clearer.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
