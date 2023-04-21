Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C3379;
	Fri, 21 Apr 2023 03:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682046348; x=1713582348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QjQYZMnVdJThJZjQT+WXJYCr8VA6Ea0X6bgBtRbc/Kc=;
  b=VFFuUWcvQX0TNo9/7At6tM7huHg1XzMXy7gmB22Ndo4cYR3w5n+APJm4
   Gx2a0Q6H9I89eJshdc/sPU4g4oPViXdvY/aFgaIt3+EPn/O6LEnBUS4GJ
   9yrpiNLzw1S0Mc6Mbc6t6Rh/w7GvHHfHetSdJn0MtGkxEvTyI39plFcVO
   g841AJxzeARkSbcpBGhGXVx16zpgGR8UxPN5yFUIPiBZDOWAo6Fwfr6QE
   eJz0G24e44oV8asiLl1xq7AG3uaE2rPHHB9n6OcjVZVmBT1S/Ui3ZPOnL
   POZUDPmNrkG3C/2+ziDJ6QKU//uhRxOzTJ8aq76jno/BwxkXMO+/4/JQK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="344659485"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="344659485"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 20:05:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="722609739"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="722609739"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2023 20:05:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 20:05:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 20:05:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 20:05:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 20:05:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftc1QUWCPFRxcWzCLiD5yrGjjD8keKiG8A0xov+8teJPy6uGy5505rqaNo0QE+SllJInSyrP86aHGLk4g6h7Dgc5IRwPdlA/A4Hu5fzT/lY4zUCp8Rz73l3ZySLKvZhT2XUlCDAQIpwgaYLkQ+Y2R3ogSQauwMRPJHjMKlaNIzwCJQ2jhoRIn5w2B+JpRrXTnZjLQaz4E3TBCxpbFapZRyDbxWirtdqFV3iV7ier7mI+es37+CjYNiBmo8yjFuxTmkgFqW8gVi1JDnn1bzrWdbs/lrAsbmwf9gZCUfdvYX21qotDAIps5MfvtN3wQbx/vqY+WPL2NwXcBvd49urnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFBBoaQlk2nrrYUnIp85nEcgXZF6TkKJvhlNrtgMPJ0=;
 b=hEs91+NUBWx65ERpjuSELB6sF6sDfMolwM+Y+6oH0CdMz5oo88tXOY6VpntHYHgJlJE7/yFZdbu2kCcXHD5fsREuB+I7N2OvYVfd5z+3slYnxpWGvqZdF0JN3ser1SktwLJwnyq+8DVuLs+Xtp0tf2qOsAeDU9NTFY/7bSaJ+TvQE9t8sCn4jfRStbVoC9dQFiLRpxpB566az0QU0z+bI6+7XqAlgzQWygQRYOYOY21Oa4H365L+4CpG6WrWboAhx5P+RE70Wx0RigpDNnoTpq3HGhMQgwOujVi/mde7xPN4IZbuw22IxNMaHN+iXxFEtPRB4pfpWu/yXwHBn9SHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 03:05:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 03:05:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>, "Nathan
 Chancellor" <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix,
 Tom" <trix@redhat.com>, Will Deacon <will@kernel.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 16/17] iommu: Remove __iommu_group_for_each_dev()
Thread-Topic: [PATCH v4 16/17] iommu: Remove __iommu_group_for_each_dev()
Thread-Index: AQHZbUX1e5P+8wSfbUq6KqnnC2Foza8z4rIQgABTG4CAAOuzwA==
Date: Fri, 21 Apr 2023 03:05:42 +0000
Message-ID: <BN9PR11MB52763F495B26CF1AB29B9AD88C609@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <16-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <BL1PR11MB5271BBE89526DA4E3DBEEF2F8C639@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZEE3lQOfQPE6mDk8@nvidia.com>
In-Reply-To: <ZEE3lQOfQPE6mDk8@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7531:EE_
x-ms-office365-filtering-correlation-id: d83d99a5-fa62-41bd-786b-08db42154b08
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AAe9IIdG28vCEBRl2hPwGSsMOer6XLYGRsNPgsKqgFzut60X2F0HHoq680jSkGLWqUd7BT0QVu/IiNp/J+fg8UQ/qMbj7nDT9lo3tRqJXLLdYalFrZ7Yy1mM/0y7kSfozBx4Q79F0n6nizUJUheMkbeh3JokkvkYpZQRo8zGTaZdmnWOgAkOOyowDSGkpeJoT1jneWXlVOCKlwse8/6wQYcDF7S5j/a4QOoRjyutnlteMmNeTeyQ1khTo9fV26lrudlyz4SnUWPW1BSUbklPllaHN/GZHHzppXpStTyI3CmtF37L4Zs5LLPJ4TRAO86jtTbI4alV+wQ3I049S06HPivBvyBWbNSN+O7PPwxGkt8XbsLbtt2v0J+lCdGXA6n3DD1eRPUEjb1pGcRJ97ADEUnRlPliD5Na7xgtoEFVe3t0d1unFRjZ+ewxlD7CGcuoSSC1QCAUQEhcyz/jRjrXNBUY9pXvxnwI6BDrd+CK4HVVEWyB45kNC3mOK8jc5o/QTon0P8VYm+T5ByFU2KZufavew2nQbCWOutMG7QqEVHL9v4/CY02HZHLCDTwAqyuJvtjOjfbMX5yk3TiFc7PYaG9bqtPwHhNXG7pcjEgbBQLCSCTL3CuPVzLvxXMETjub
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(33656002)(38070700005)(86362001)(2906002)(55016003)(71200400001)(7696005)(186003)(83380400001)(6506007)(9686003)(26005)(316002)(478600001)(66556008)(66476007)(64756008)(66946007)(76116006)(66446008)(6916009)(4326008)(82960400001)(41300700001)(52536014)(7416002)(54906003)(122000001)(38100700002)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wJeumYCEgstchG9uaD1E872xtK7gXG7232TXBMOADdFh8jo8F8n5N4q8NOBV?=
 =?us-ascii?Q?dN7uOtbt8Pce5JnFipFA5TmD6mdShq8MXl0hIUK4P2ENicrORIqHg2BKBqEP?=
 =?us-ascii?Q?w3X4tFClr0xwDtbgzQQPc7UI75eqd/BOLpHk3OFjGfL84NyZz8Iua1zrmnKL?=
 =?us-ascii?Q?1uibOG2lcBTMA8WByWgIZxeX5OlmtrwsPnZzwADihPOwUVSs3IH/5IIO1QEz?=
 =?us-ascii?Q?y8/vTvnfqcbyapTjk/YMhbXUyvPwc00ASFFEAubQ7uM6/8usAybNz0Wjkmcg?=
 =?us-ascii?Q?KIhkBdYnfQw1BeY9K68DdEx6s28y5bCKi8cYtv5gYahGUo6ya6WwJuCZPTRs?=
 =?us-ascii?Q?R5AzWbpnCnfT6zK01B2IrdEmDEYDAMDRntW48XlqJh/Rrhdx2NXNZX+I6e+B?=
 =?us-ascii?Q?o6AoBiorum9H0GXXrlDERe8M2zqksfnp7Yhb6IpHRp3qVP99I5QllXrZ39jn?=
 =?us-ascii?Q?FJrbZoiWmZPsUsvjkYnkyYuEnDs3RgWW6LqS1ezwnPuRCZW33cBArFRXpypA?=
 =?us-ascii?Q?bY1t2a5+dQXzaYKNzzpA4CEvHTGsKAU9Nm3jgu9vL8GZQxPSVInDeevuNq48?=
 =?us-ascii?Q?6AKVXuHy1Yf0n+wLkxjugWBG/GtexJBaVELZNX2OeB3IlUH4ye3FCxEE/FYi?=
 =?us-ascii?Q?MLu2oHWDJ2svQx+VMHl1WhvSeR2IX87KZZfErTy/N2UySEffmZAYbRx/DL36?=
 =?us-ascii?Q?PhbwdfExR7VZF+f5FfixioaHKGiFB+oPdxWHEMJZz2e8Jf5mBPuYjRcPa6Zi?=
 =?us-ascii?Q?qwLY4Y32ejkP5N8hSBDEj5UCQUAyoot93qD0AzTf8gaVvo13RX4tWJD+kfSh?=
 =?us-ascii?Q?hHBqY/vnZNtpJRhKqkR3w4dDS2oW2CCQjWlLw6aAOQmJNum9xdGS4oakmzD5?=
 =?us-ascii?Q?dDP3ec6JPL/iURe4Bor7enoupN9fxzu/dlnwIlZDxUPqQjzRnBRgRjtNjXVC?=
 =?us-ascii?Q?x2NDN5L2Ww4k5rBH8U3LLUCLlBEE4fluAx8eMz7eAYVhefpopcsK2CVeuuGF?=
 =?us-ascii?Q?M8Zd647FRYgc1ajXHLeQHoMC9LtBKr3wZLt4t3keC3K0VPJdiTtInCC5zGCO?=
 =?us-ascii?Q?DGGB12jiE3r9myOfxv/Q9RbrbSwBDdvdiwBSL4NXVyaiXZ4EuuL1z82mQVG3?=
 =?us-ascii?Q?kiV5trf4Bs55LxjNb0hTiGhHH0MDvDzS93N6iFYXxG6glYvzkBsbrZZHsY2D?=
 =?us-ascii?Q?11WAhwYzuvzpWA3GkR2TjYIA4Rq6oNIMq1B+Ebe8AuZoiCMq/bamCKTzLP3r?=
 =?us-ascii?Q?BZ4BcqKfPCVnWyKSrSiVf4vUx99/0eKwYrsOCxwB6R9ZnPplTeW9Bb8iV3it?=
 =?us-ascii?Q?nB+OFHPfL/CNnY2fq5m8bN+EtKZ8lPTan6dcu7QubMFlM4Iz7OQaWRM+5+en?=
 =?us-ascii?Q?mCLUQWC+YxPDoJb1UICseAW0YlFs6+WhTmj4M4jWyNjU+vGCsGzHO8yH80iT?=
 =?us-ascii?Q?01kz74mm6gvwZkkQcxVcZzrpeNBBfXxJgcMd+C3joQOfTvMUWkqOB1ta2FsK?=
 =?us-ascii?Q?KaeSmdMgwQgnwP+ai8S9eZ0sFluD4ghdvOv5s9hiTKLR1r+LcKY1FSzf7nmZ?=
 =?us-ascii?Q?PEjQ7NAmSlDXtawdjWfQjI9tS/LzM0gVhPiL+jRp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d83d99a5-fa62-41bd-786b-08db42154b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 03:05:42.3353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTyU5iDb4jrpf8hpzIMwosdADqCs3y9rL4Lmh0coV/DnkYDcu5nzZqa8wpMqTb6m/NjvO+Zmxuw6IGP8A57IYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 20, 2023 9:01 PM
>=20
> On Thu, Apr 20, 2023 at 08:06:17AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, April 12, 2023 9:52 PM
> > >
> > > @@ -1858,7 +1843,15 @@ int bus_iommu_probe(struct bus_type *bus)
> > >  			return ret;
> > >  		}
> > >  		mutex_unlock(&group->mutex);
> > > -		__iommu_group_dma_finalize(group);
> > > +
> > > +		/*
> > > +		 * Mis-locked because the ops->probe_finalize() call-back of
> >
> > I guess this comment is trying to explain why the following code is
> > executed out of lock. In that case it reads clearer to me to start
> > with "Avoid mis-lock ..." and put it before mutex_unlock().
>=20
> Iit is not avoiding anything, this is deliberately locked wrong.
>=20
> We are iterating over for_each_group_device() without holding the
> required group->mutex and hope&pray nothing bad happens. We do this
> because of some bad ARM32 driver implementations of
> ops->probe_finalize that recurse into the lock.
>=20

Then add a FIXME tag there?
