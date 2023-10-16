Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2014002
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+DesBZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697446127; x=1728982127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=STNxAEeXmM3ZnYDTqFFrKLDWe2RQ2jLUF3h4Q3MEM74=;
  b=d+DesBZiqhCgNnDYu2aMTnaIo3TFygTCU3x9DHIVEVUDqUMoSjL6L6GL
   TYdq3kWF76GSfrcpZH86WtcIXV+iAs+tXzjPNPa/wG+y3IrrBgnwDr1+y
   Nxj7pTpuEUU2p15daV622I1L9wIseU5Ef/4vxM7zLKCG0SSzk3bFHK4op
   SF0APE7qPIT2b9bh0VvIqb4fTX0/lNFtFF55yAHjAh7bXdJLWNRs0V2z8
   DDS2u5wDhYZaYJ9hEk+vjzK7vcrc90OEy8DG6l4alymEMAKh2B1eZkmnu
   295bIOUVIibolkVVVitBTykhz2bQTUeHaRZxJdsxCewgFAd6ri5biUhd0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="388342361"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="388342361"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="732216983"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="732216983"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 01:48:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:48:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:48:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 01:48:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 01:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUzQRJ0GVTdjeyIZeGkSm80vj91lbJrsvwR+EJ8eA7Od/oM/+bvQn7H5572NIEth61l9mRiHinA2qWUVhSIWh+BpMwhA3V5m18H2fsVFKzJc6eZ805A5ym/06Stqr/eAZS2ADondiSAy1PU9uzevdw4GjlqwHwqbR47cUr8j40SBZGOl9TvSMc386UPP6eYO73AdqHcWt5s+Y4OLrv1kttnanRJbGwPFqbCTQOQRWECFLSzRLisN/wEO4Cb4hqYZzWmv02l7o/frXXxjWwXXoEeATQnHMsbUzh05M64VyNcttdjRcv8wpIa/SV98dvpD3ISB7KnisCHHU5Jc9l7nBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STNxAEeXmM3ZnYDTqFFrKLDWe2RQ2jLUF3h4Q3MEM74=;
 b=jtSs5xn9VSPgx3VldYpT1nUF927L7so3mH5JTOWOXhmopMlQ/L0Fzble/D4NQLRQ5wKRjI+9wD/dcWBYahIf3l9tjNI06I3ld22GW5ixUuUcX39Yok66AO4Bs3TxBEJa8Rkia/0xTyuHatmCci7lJR8sH8/kQFAhOXhtNqqNFmGqTifk9On+86sggWzapuQHFHpdRzExE3dCNtfT2WsOY4cNA+kB9rtPPHZ5yOtNgGAufJ3mNicwZpnLwxmucEijB9J6ENo1ko1RN/Ep7mjQARhr1W1NwI0qqLq74c8VB97dtALtRL3K1wiaUCUChwv/cU42mN0/Cjc4Nvok/1QDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6862.namprd11.prod.outlook.com (2603:10b6:303:220::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 08:48:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 08:48:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] iommufd/selftest: Rework TEST_LENGTH to test min_size
 explicitly
Thread-Topic: [PATCH] iommufd/selftest: Rework TEST_LENGTH to test min_size
 explicitly
Thread-Index: AQHZ/zvOSdOpKkgN+06iM8+h/4Q1srBMHIwA
Date: Mon, 16 Oct 2023 08:48:37 +0000
Message-ID: <BN9PR11MB5276037FE9001731A8DE48228CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231015074648.24185-1-nicolinc@nvidia.com>
In-Reply-To: <20231015074648.24185-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6862:EE_
x-ms-office365-filtering-correlation-id: 7f82396a-b489-4254-1992-08dbce24b095
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjtnd/FDoX1mMUWYFaFMOAxUmYkTBLsdR1Yg2NlogQzJQ/zKZA/E6uSKX9fqllkdpR1AQXN6ZHJV8rPltGazDSSZFl3zwrsRpEzvn/fbEilrYxAb9PKgBENBG2gKkWKPv6bJsVlyfD0TQb1lFEg750D9wX6JHMkAI3pg6kZiCKQdBBtz4wfArSUDCLrWLyGyLiZUh0v6BgCLXHHqTdWSqcF966sxYKviduG1BzQBvG67A1TdSleeuQdYMW2Tai3nBHeDe+EQOl0TbqJmjFQcMqj1jboCWxKIBfCCDFSJ278uCltxyDfYxb+WQuFkSxb9QyptDXNaJ16QQ2puOgkUljIvIywvNfZbLD/EA6pvOnhAcsAVAFvpBSrrycdZTHCX9fJPyivGMMp/Wqh9Tex5MzKixArn4bvpHN3joXcanUmVjJgcf4kshlQvL019qIXJr0sxTBWXPGIRIFNVYZCRA+rSqo2L8a0qdh/l8lvTNYWl0pyo39+P4voUPk7FflCXD9bF7KYkizpaTf2o0vQNe9EJdoB8xNc2nRtVrlAvmFazS/YBmKUfuzHkMRI6GwyUVz04RJjKMO4QImpCSKpwtj3yyf4LhVlTjJP7wN9uOneKfmv3Yxv4VWmxG9KxDA7c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(66476007)(66556008)(66946007)(76116006)(64756008)(54906003)(316002)(66446008)(110136005)(26005)(7696005)(6506007)(71200400001)(9686003)(4326008)(8676002)(8936002)(5660300002)(52536014)(2906002)(4744005)(41300700001)(33656002)(86362001)(82960400001)(122000001)(38070700005)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yi+NG0jy9ZMAwhMCrzcrmVpqaQ/riuiZTfE7P5F44a+P30b4uh0QSHHjl0Uq?=
 =?us-ascii?Q?SrBDf+oHmKYxYWUYN7MFigDwEdCQZ7cOjI/W2iw/DYU7hllrIl2Wa/MgbBe/?=
 =?us-ascii?Q?SssEZVEg9xxdI8QvBeEQ5yGyxrsSZuj7sjJYcB9ZJnQVk5Pf3sfASJ7/pkqU?=
 =?us-ascii?Q?FEvY/MYLtwLn+qp+W7GmBnYj5D3Nk+BpZCMnkQKrzFA704JbdelxGo/Gfcuv?=
 =?us-ascii?Q?UCDbxo9arDjsV5qMpOEkeLqSiW+nGSTLaHRqaaCU0ssTtiEgykOfkxl2z07g?=
 =?us-ascii?Q?kIT3VxztVBL6LQbJUTt3KFIiYtYAdKi8Pe/UvYQ255/KeCQgCyrvoAj4bgng?=
 =?us-ascii?Q?gTsW+CFhlyjSWOLtKxqSPfS1mxrCCD7djBMdrTCy3fv2SDsDpt7b2Hg14q3g?=
 =?us-ascii?Q?PzTkt+wyeTov4p1fRNgeNH9tmx1ksbauQWt/F4smApISuHyGT5pxtWLzMjX1?=
 =?us-ascii?Q?+pPNn+5uMHI7WrBYJQ6LkOVKPYGVXygE0iLQ7dkQevKROtH/6j9cPM0LVS/M?=
 =?us-ascii?Q?aKfczlZeR81s8lM6obYd9cpzIlB5xGycFR/ZIJ+58OlQR2h0zxiZbwXxdscs?=
 =?us-ascii?Q?zeBerCkwiz/MZEN/wXTkz50l8Y50Vl4gkpRNHDn1aG+aNmH7Tua1qVNhxR6T?=
 =?us-ascii?Q?Ko5Z0CWwewe2cMxHEm2guXPcWUaGklBc7dLWHWwy7BDRQTc2fs3lh8BJiFeW?=
 =?us-ascii?Q?qi8ih7kaO37JCt4c29QEwGqy52k42lbGr31Xc6/fHzcwn1AI1X+szNuV3QXd?=
 =?us-ascii?Q?7YR/BC2ykL+8fogaVT4S+8IxXU3iR+2LwYW04ZTkeCLlwXn3iGMCpi2I++LO?=
 =?us-ascii?Q?aKJJzbVcyvoen/ZzD0rizTArQU3fU8skdf+dNuIVb22FRjNLgNVXcYG23lM4?=
 =?us-ascii?Q?biciuV9oPQpNqztUu6jEgQcYX9JV0zmCvbOkoXntB+aY3wBEuxTbyHyyXbaa?=
 =?us-ascii?Q?i9gjrhiOiaSmSEiqseRbYkfsIV9QaguEeA26Oz9PwYFWD2yDXKHzs0KcNUMZ?=
 =?us-ascii?Q?qp2nqhXXiwkyDBisgOEX+RMmvzu3Tj1S2iS2Q+MZSWZfv0IVkuwBUUNVQ+3G?=
 =?us-ascii?Q?oNhkaeCEtq5ZwxIMoSy1UM4RqsqSLaXCidWopz9Mg9QELef0ThIa2+ZyTTUE?=
 =?us-ascii?Q?nvfTS55Xo/wwt7hBLQ00xbE1VEiYt+7zpiPjs4iS1+XTxWbrYQ6VjpYT02ze?=
 =?us-ascii?Q?gg3UUFTlkMloUea4fliiVD+EKaAHJvRg7a8YoPwxy2AC1svUcBLH++cxKVsC?=
 =?us-ascii?Q?5GKYgydbjpMd0HsIYT83WudhNVvR94yAMlwHyr4YB4tHrI2aRq8Hm6cIUXtF?=
 =?us-ascii?Q?oZ8WAgtV6z3Q2MONIfaz/8w9y/0ZwFaaxpK5LKxtWkcAiiPgtYWl7KLIx7pZ?=
 =?us-ascii?Q?EmnVEzUx9e/PgzjQifhCbtIDpFH9SyC3YAv/OMKOMkHB5fXBN2FatgnwWEFA?=
 =?us-ascii?Q?G1NyzPSe8m1NSR88mic1DK2HvqVXRYKDmffePtqir2EfZaTi2ZHtxUdxECFQ?=
 =?us-ascii?Q?Cfzcs7Z///q306T6qDL3laaDybFbSmmXYnRKh0HZ2vKtrTfD75yKJjIwEJkQ?=
 =?us-ascii?Q?QjOVTk5rcVwY3JEbjCvYJ5xW9gCD2DufnQfJY6Gm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f82396a-b489-4254-1992-08dbce24b095
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 08:48:37.9746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0u6APqjbH4aNLB3jBdMD1fmu93AJYktyA/ZRZDeQE0vCAgXcv51tZVNMGhV2W5ddNUItVYYNgOKRtp5zoLGjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6862
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, October 15, 2023 3:47 PM
>=20
> TEST_LENGTH passing ".size =3D sizeof(struct _struct) - 1" expects -EINVA=
L
> from "if (ucmd.user_size < op->min_size)" check in iommufd_fops_ioctl().
> This has been working when min_size is exactly the size of the structure.
>=20
> However, if the size of the structure becomes larger than min_size, i.e.
> the passing size above is larger than min_size, that min_size sanity no
> longer works.
>=20
> Since the first test in TEST_LENGTH() was to test that min_size sanity
> routine, rework it to support a min_size calculation, rather than using
> the full size of the structure.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
