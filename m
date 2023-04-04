Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D397E;
	Tue,  4 Apr 2023 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680600336; x=1712136336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yUjT8oNxyePusQ8Uj/C/f9oALaTN1/bcbXgq4mf+BnA=;
  b=gGWhMq6yClmT5O3sYZsLLsAMoGF2TPmYr2UcX1bZHzFiMm6hM6v6mG44
   7nToP6Oe5eJqbFUqMX4f7NqfRCo98is8gmU8mpvbUONK1D4SPrT40il1I
   oOHHJzW9wPOAbaRNt6HgIw08hnbLk0bTGe/ppLdKACExnEKyqbqXCgLgW
   /3BeeVqVDc78ezrlq26oLKvClfCcR/c+bKAl59zhwqCQlEA/odRTVBKz6
   x081kH3wmiVP2JJxD8T7uJ7E3dxTq6XUZwBJZBUUBTn/aKaUarHsKoE3j
   Wnaqo9dfj7D4J/stGs/RvWuPYVgBL90n16ZDpUud5wTxVpguYZzTPYbAN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="428418575"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="428418575"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="829908251"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="829908251"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2023 02:25:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:25:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:25:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:25:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpQc4nw/iq6mp2wg8tBctq2U7to5zofRlUU1yBSyJG7oezkI8OrwLb1apfwp1nFx9vSid4rT1GDi1PS1wypTfi185kAu7aF7Hg51icNB8gx098WKLp+5Sqi4CyASW0dBJ7RrElrL805X23epHpA/ZjHE3nngGmKHiH6p5SDSzxydKlr+H5Je1vWKlYXjhTqh5kRBc8dWRHN2VC5YxAA3oKMzUocQk2p4ReL2SkXUY44TbbRG93BLifSB/uyp4IaZfdsoH1RH9IxfEnUdqVriq+sfCu4TcgvVfhj/h//25IVRDYYT01qz3Rad1QJsrUQM7QRbmnrLFBU9FL8VMKnOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUjT8oNxyePusQ8Uj/C/f9oALaTN1/bcbXgq4mf+BnA=;
 b=QE9kj8H5kdzVNrrS5a0mwjuANPXMX8lLK1i6mafNHhl/UpNaHuq3DbC67xwmOMyfaN8rL+poBA6TIB7Rr5nhsMVEfySucaX0ti7paWXC81+JyQGG82FtuNUdz8SyyGYPkxRaOXfE8EnPmLbP8Gn5cZ3cBxFP9x3azpEORJDbQmxm4jcq7k0TT7XHV/9sO1ely2BlAEr4wKQ408hUjKjDJ19C1lNp87m9AV3XxnDCmQEb3+4eEdM5jUvAwldlOS4OICs3XBzezSAwXXGS5k+fQBlsgJ47geTU4+lk7lvOCRHdhgrjdp9BYSfzVIND65koKLIThXa8hmU5+NgLxjRHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:25:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:25:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 09/14] iommu: Fix iommu_probe_device() to attach the
 right domain
Thread-Topic: [PATCH v2 09/14] iommu: Fix iommu_probe_device() to attach the
 right domain
Thread-Index: AQHZYpfu4i4wE1qY80ig7mpnZ4Zbuq8a6Yzg
Date: Tue, 4 Apr 2023 09:25:31 +0000
Message-ID: <BN9PR11MB5276BAD4FF65A9E395ADC4DD8C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <9-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <9-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5032:EE_
x-ms-office365-filtering-correlation-id: 819da9b4-74ff-476c-ea02-08db34ee89b2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76U+U207wbUMGdPSASrfj90wCtA7czDZE4xn+t01lkd3LKJlNtBW2gvtRqUJlBeQpuKnaoJugbD9ioBk6tHVh3OLbWookEcAp39kez2DTKnfLneZJPuPKAYzd2TqXx+paCO/Jz6T1wDTm1NfncCAEFEia+X6Icb0zjuVG4X/Dg2F4W/NXhTzOJefnD2iFZhhsyiyhLo0JT0xLJIYSQ1bBkxuwQLY0p7HUNa/lHEDe64Mb7MUmkBhMFC8oibXdvqIMZRGjL8FQg99z0Wcc1mbt0RJWMjoondz0/QBpYzyz3fvZGUXJpytWhcij0o/VDJ4IesGW3CXXqt8vVOdHDOYkkpYV4zF9EcVskw8ahl1lmO5UNMEFedNaWbaBn65GmvEuaPmR9pfccngkDr2zsUBxR1SXbYgASKUjA9o1qXSmbMR2Sh5gSTQGkOr0bzABTiQQi8J/7gBO98KGP1dfYHKyN7NfhVRqZQoVpcT/iBh8Hm2SmwPHz/0+YalF8mtc5pxYYSwDN39CDDAx/OIBXpnVs3WlB44xCLVEENS/yLUMgwOrleyF9WW0ydXiF8PABSFsApDA/NLZ1KEQZ8JlcTmJSPPugxPsWPga02mDC/3PjAwwQwiRjzUUhBUTrQaMPKs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(2906002)(86362001)(33656002)(38070700005)(55016003)(7696005)(71200400001)(186003)(9686003)(26005)(6506007)(66476007)(8676002)(66946007)(66446008)(76116006)(64756008)(66556008)(41300700001)(5660300002)(82960400001)(7416002)(921005)(122000001)(38100700002)(110136005)(54906003)(478600001)(316002)(4744005)(8936002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZtCUFxLfIs14YBtOw1IH7T6nogYfSUzIsBcpk9gWx9tbfL+XY3LVv8D0U8JH?=
 =?us-ascii?Q?eDXSmUHml2GA8Jy0TNK7ELJTRQwSANxTU65bSf1ugxaKopJFIePHybYJi5TG?=
 =?us-ascii?Q?6iLQYDZcsV6BMWaNQmP1AAh21oL4Sk1fGU/n+0+B6q9BpfxmlMk2iMRMgIIe?=
 =?us-ascii?Q?H8b8APLeBeK767gmyQt8E/jOckcRn4K+81d1MU9NBhX8hhzntjeWz2I2URYb?=
 =?us-ascii?Q?+pMnozGeW6bjVH7GNgrzAAyEBF2IWNsdnq7LCw3ZJqq8imJiCZCW3FW6JOCk?=
 =?us-ascii?Q?QsgkwyADInAIRT501KojJxbhVnpgT2pgx3bZx0CKBhZE0GOonzSDFd/1mol5?=
 =?us-ascii?Q?OyPbQ7Rrxcn4pPToC7O2Ty3wk4WZUlK5R/lceQFGSGQdPnSLyR+RSbtvfCB5?=
 =?us-ascii?Q?OXi+VMruvfw7u3U0vpU3e2Gp3vsfWbsCbCHgKIac+T9rqwPHLQEIv5ZOcTkb?=
 =?us-ascii?Q?jBMzpTUEC+YIrD3Ap8Pbzgatrh91t5YbzlRe/7TNT67/hup1IW8AEO6p8jBn?=
 =?us-ascii?Q?turZZan/zUpC8DnP+bP81/eARvDoevoNQzVoAXbfswLkmFhj0TQ7hKXTQOoa?=
 =?us-ascii?Q?JqDDRHSlq0tuI3auNkd6lOilDk8i2o+lNT2hP4xtmWDGtwxwkXGAgq2Dxkd+?=
 =?us-ascii?Q?91G3ZtSyxtkZwtlffeD+ni0pqnAOWJvICwWufIHVcZAbQqfmvpc9I9Rn6T6Y?=
 =?us-ascii?Q?018PoIJ9EpzyfukAbCUVVXwUVzLLO0J4xye714mU5fz8GtRQY71BqAnF3LPW?=
 =?us-ascii?Q?oeAnG8IW2IDlKm9Z26/UMpv3zF9jVuvT8fSwb86oq4Mm88QRQZcbt0gZwdlg?=
 =?us-ascii?Q?E7OCI7Dof0s/SjBsdu/iaUjG87pAKAa0uDG6CZR55dN8AoIHZS0qXmI3uZin?=
 =?us-ascii?Q?CmVwqcWH0xYpON77VwM5XAAeUlfOmrwMeFQd7BxleS85AR6NnSE/3IL4DUBF?=
 =?us-ascii?Q?egmdtWxGSvHnCn6J8B+wPVS4v+ThKkVt0wnQEeQ5zors/LnpLDHpbipxbbA5?=
 =?us-ascii?Q?G7L3j/sRgo9I/BEyY8FYezH0pAVhM/cJjC31PQJXRvD78CpdTogkDruq2zR8?=
 =?us-ascii?Q?XJD8yaBWpSZuA5yvD1BFsIs4cWnlm6DdDlv/QBYEnSttJhFaUrnf3ZQ5Vu4P?=
 =?us-ascii?Q?MVoWNOZrltFCkYSiZ04k2pUc4A+WSMdEGxMGzimyz2NF+Jcou8XobNet+Su/?=
 =?us-ascii?Q?6PQ9fMY3UJ55D6RrqEElK5m6cMApusJIIrwij21M3jPw8qS37DdjVgicn+bN?=
 =?us-ascii?Q?EgR+lgBK7pxaDnQiFRBxWu7SyjcWCF+BILmaMDtzqhDv0XsViykOkQ15/jN4?=
 =?us-ascii?Q?OmL/U8kNXsmY4MWxDBNTjn/eeXXzoaiC0m+mzBppqwwl+iJAcGC2QMfYUbTF?=
 =?us-ascii?Q?dUt6g0wzdGXvSt97D5rZADR/oSuPbTio3u5ffVYLSLElsohTrwOjzjdX0MWM?=
 =?us-ascii?Q?gpQuRq4p/9QZuOW3vfivY7eZbKU0SECGmtLATtHE9yQM1UmNI8Pg46S0dnIE?=
 =?us-ascii?Q?341175nIy8ZC+JPttoJxwMhpS4QnmLVxMzSj3YysayyjMl+xHwpX9Tvh1FIB?=
 =?us-ascii?Q?wlIai+l9M1GOfEaRqoCghxzN7E0CCHDJQ+xYDxC+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 819da9b4-74ff-476c-ea02-08db34ee89b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:25:31.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rt10GN6Jq7nD5KjSaFuhOFdtVJTkz31nTuYHq04u+GB2utGZnMxqS54CbalyHc25OX5V8ygRYjM7ZbuD0zr4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 30, 2023 7:41 AM
>=20
> The general invariant is that all devices in an iommu_group are attached
> to group->domain. We missed some cases here where an owned group
> would not
> get the device attached.
>=20
> Rework this logic so it follows the default domain flow of the
> bus_iommu_probe() - call iommu_alloc_default_domain(), then use
> __iommu_group_set_domain_internal() to set up all the devices.
>=20
> Finally always attach the device to the current domain if it is already
> set.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
