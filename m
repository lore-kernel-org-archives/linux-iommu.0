Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9675534B43F
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648620; cv=fail; b=OfNDj863CNs+ZT+4ueoXy9ABJwmx//Lvn68uT+/gvuNXiXM+wRlio8oOiw1F+vn25lAwgAWg7FVR4uVAODXOArGC5l7nOFARQ3X2rW7zgqWJMwdurpMtmtby1K0x6lBJHe0Jco+RXM23jAWb9hvzALnx6hXH9SZkleyfLesm1M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648620; c=relaxed/simple;
	bh=+HQjAXd625y2Kp9SlOepIrMYCODKUPY0BlwY0xzmOzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DMyFKPQpz5TXA3RZ9840kdeYCTshPgOd1RJdIGhkh6ihA4Os8Ra2+zT1xYCkrKMEi96Cwy8PAPG9Oe09iZjEQylVVe9/ITi2o0paWenI3XPP3/4pRvWTfEn6B2s7zxbCisKLfBy64mUU2b8SqEKxm1ndMq+L2/C0l4lTV7+ro5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DB0CPeFn; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DB0CPeFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773648619; x=1805184619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+HQjAXd625y2Kp9SlOepIrMYCODKUPY0BlwY0xzmOzk=;
  b=DB0CPeFnaa450NI0MTo71V3rISNcXebVSAR9Pjl9ibQtsRQA3sCoq7TJ
   bKg0JjLgQGz/ha0/OEFZuOTsxusJK0q3cA0pNu4LrYNJ/NlPCfR/I2aac
   FH4LJ9a4t2MHrbeCXHj5sDvROTi0zso885Q4EVcPlNuBXdcvrbrzBs3YE
   MPY6tXZ6IGxypYPslYEY80KNoXDW7pZw+2pYl7Ymwdva/P+yKxywjqYQq
   rC9cl1Sgy9Zan15wvImLnFWpOQd3MycVve5MEJg3KLhEC651nTSasUb/I
   yrnO1146/HFCA6Gl+ElnHnxuXc5OTgHA/bBdrn3JiPRVL3PFUvwkTm8x9
   A==;
X-CSE-ConnectionGUID: 6W76jRshR/OZKbX9SmajaQ==
X-CSE-MsgGUID: qc8SVpfdSxqe7oLmn7HZmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="78508043"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="78508043"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 01:10:15 -0700
X-CSE-ConnectionGUID: +aHRW/P8R+qqhedP9wICNg==
X-CSE-MsgGUID: VnW7DuqDRpOuMtmp7O10IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="259739560"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 01:10:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 01:10:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 01:10:14 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 01:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/HDi+ODbGyMV1TOgnz2mGkqvIE/fD5SJg82rZxn8hEeBp1w9L58aENMwSXc3lxrUZQAIBseTBbMX3TOE83D8lWIXJdO/29P4a5bbSW65QBrHh4Q/oywg9teJj9dWTMGgGna90V0rRwYroFn8U3L9uqyr9HKJLE9mBSUXLAZl6gzFhheYUAkg6S1bMXRay7X+q/IEcvg5jRpeq4AhMto37IbFpyL9AnlQhw3LHd8CJ1gtJ0APkO5VNYHLYSNHIqUxSALU1s9oAqgk2k/dVyHTdnngO++zEfdBXbX0b9DgfZgi9amkNpypsBtZqYFqTvIqRoLdWsApXTmsBDCY8b6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjOWrRje/C6A1Mhu4Cs02w5WlOAjyFZmmMXD4rokQDk=;
 b=oSBKZa1YazOLzgoopu4HsfgrAF0V5ADhkuG6PLaiYF6v0ddJcBXAuceT59rN6i5ACnE1kpRGMcU6MDNRxOHdiB78JLpMwJ/c4kMIjbtpAy5RzOjF19alnZ35uw+vFb17JFj1VsggVT8LpDUzw640n4B+Z110KG+5Sa8Zg18u6bFxrqsHFCBsOQvcdUKUaeAfU3xzEXo8hoRzJVDrOEae+Fgo5qw9o++CxEi16QgVPDAM93kwmWwQeJlV+xaHtZHzHQfJ4O0n8Q0cBWSPs2OgVN4F+8tOTumKOR8nctZHgDs1vrirGnEW+hHG679++7AgP6Dw2DFoIRtu2A39rQ8jZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6511.namprd11.prod.outlook.com (2603:10b6:930:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 08:10:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 08:10:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen
	<nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>
Subject: RE: [PATCH 2/2] iommufd: Report ATS not supported status via
 IOMMU_GET_HW_INFO
Thread-Topic: [PATCH 2/2] iommufd: Report ATS not supported status via
 IOMMU_GET_HW_INFO
Thread-Index: AQHcqx8+V8I6xojO50+EuKRWitNzWrWsvNqAgAAB1wCABCHJQA==
Date: Mon, 16 Mar 2026 08:10:11 +0000
Message-ID: <BN9PR11MB52764834DD92E35659E753478C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-3-skolothumtho@nvidia.com>
 <20260313165051.GG1704121@ziepe.ca>
 <IA0PR12MB7555081D57CC9A7663191142AB45A@IA0PR12MB7555.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB7555081D57CC9A7663191142AB45A@IA0PR12MB7555.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6511:EE_
x-ms-office365-filtering-correlation-id: 1a82301a-bd0a-46f9-745d-08de83337272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: NC3P6nd9+HS2RCUdWBH7cEc60yEZqdl/w3L8RhVPaoG1ivuu12D2U8HC2wgRJugAPbOMCOVT4Lodqpx8R86grsdY5dfNn2rHevGRnl9kynMaDfTJr3YAE/GlQpCgK7pBpGC1w4Hv9eWXRd+fpcYwTyytwqMe8SBFi5LH0LZRjn60eGelzvv64qq6Z26pWzLxoGTr0sXt3j4v+ZduNKwznrjLbW3auUMV3p6COkrJpenBycNhC/btEDOPMfOrdo5Eqm7pkMUssbgRDbSWzNP7tLndlUJvkDc4HP/o5o3H/GAf+1xt5jk24CP/nJg2jADDyF7g29a0MbEKfbQcaJkPs8siUPOCpuvALbMqEu0ZA1n9qoIyEhOz+/d8H1i9fvWrNPnJHiDLn4c3gsDJnr88YLl/U/tGjzKucTXLR+eQYaEG8OQn8dHKvsohOs6ML2uPux09mEtWkoQmfY014OyoLxgtoWIGV2LyLzYmtp+cvjEoXJdCOcQkHVynKchLsLL9/7+iJbOHTwy8tNWRmFexZP7fHZx5GL+2Bz2Sz9k4dbDsamPhwulsmJk3AHo56WGu+Kpn6bTDkN2jY9zqE5XK2R1fPdLtQg7cEStPrxzgJ6o2c7Ox0WNCkHBw8edt4eM+gpWJHJKugvzjglqvJ4tLmSjk6N1VmIhzQPJneW5vewTwurijcWXzlj+yGuN7BXwUyfTisH2D+JtRl9N28ZO+R/S3VV43aLFt5c8x2qiqMX9G7z6GafsEEUOHKxSeLWegXfYOMaEAjvS8Dnm8PyshmIclOa2rzXlvD7iRE8JtKHU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B5C3k2Txs117fWCsPgF6fT4ZkdSTEpix7rId/fuseF+mCJH7pmUZTI9gncjI?=
 =?us-ascii?Q?GdxOJOJKRNHa+HWF3izZiYmzha3jQM5mse9CQN9m35R+wr1o1tkpSvDUTQr0?=
 =?us-ascii?Q?XeSTEtuAZuxR28X8LsojHznvJydfN25O612XeP+YZh8IMKs134S+/XcCF+vp?=
 =?us-ascii?Q?GV/Hpqp8uAjdrMYGwDkkzcRS6o6IEf2916YFGN2DypVOaoyowJ+AoSrGaoKl?=
 =?us-ascii?Q?BEeT+KAQ0Tzib1pQCc2pXNGOSnRB7K7u+1mx7dnySgrNcR0jQH790L0aBxLS?=
 =?us-ascii?Q?loIulgBcA99mmTkhvqHAuFN3WORb1scj4IOSXcEd9d005RWN0FjcxYFQbgF5?=
 =?us-ascii?Q?sduS9LBpDvGygu2cqNMGNfv2tut3Clj50JwB9rBWBSWHgdY6dyLWHVM9L86w?=
 =?us-ascii?Q?WXuM6HTclau4hBF+J3Um9bm/A2lHVFHGSm58KCpREdFX5N3Il/dD+ETFhMOw?=
 =?us-ascii?Q?hR+5lPKtmIFKd0eCY9DMOBye2P+S3lEkfXGawNA6rAtBFm2WDpQvh3+b1TZP?=
 =?us-ascii?Q?5PwXDm4TEW5vQ/n4Wk+OJL7rakdX57he24kH6PY7Acz0ccAe8TbZURgY19g0?=
 =?us-ascii?Q?jav50Vw7hXddDtdmzOsvWfEQC6eYaORUM3F5HVSl+HMOpHP7VvytTZPkShvV?=
 =?us-ascii?Q?OQUuhEXFldxoKw/TrgAly70gSqU1O+XZZzlKwu3f39MZ0p/AYS4aSrWuobkU?=
 =?us-ascii?Q?Tx1qedzQabC8GiKdMi+z1ImoCVRsigqMDWglZsaGAq3VDzPqPH9LsPYYmp8Y?=
 =?us-ascii?Q?3xde012r1nXKiyYSE+dZrRznF/7Gz86sKI6Zvw/UWJnXcSthCh451/hEkxAI?=
 =?us-ascii?Q?4Hj4g1KzJPSMSe2aoHEP7xROLb6ctLvazrXLfGkfqoaERm0aveaDiuDcbBJx?=
 =?us-ascii?Q?gxb8s71UlZ1az9jBvZdy/6c2V3ErjeBEvmpp9Nto6n9L6ydQdAb5fh4cFu1j?=
 =?us-ascii?Q?v1MJiUqt2etgoidoVWorEmk5bjq3iaCmo0wfbb+4LA1ZENyqLoU/vsriiYgw?=
 =?us-ascii?Q?qcbwzQjgWDLAchRheONnTeAza9vfLoppSHyuWvMEQ7g3oy2qH5NYF/mAT01x?=
 =?us-ascii?Q?X2V1r9s/ikS0bVPYVg+xIC3URxPDpJI/10Ee9WckEF4z7AdNj8oqUHKx+gxu?=
 =?us-ascii?Q?LdXWSrv/Ju9e8biFyoLXmpqO7vZax6hycR8DaCuRZ/pU6PBed3mTzDRR7Qd7?=
 =?us-ascii?Q?2OywMOa7IhuJx1tyNc7LGrmxqe6kE1GUZhBmD85sNS6oSdBNqvR33Fx0RwO3?=
 =?us-ascii?Q?h1fJZgD5yXs+Ds1kFXQKeMhCIaP5O4IbitZYx1Tf082W4rjfb9zJ1/YYuUU7?=
 =?us-ascii?Q?62+KOufkxH4MtqO70MsOLGm+gs3xY3BX4v2ENxiH5mVv8jsvmPvdaf3J9pM2?=
 =?us-ascii?Q?e1w7CR7gfb1QXz7SDq9eurxJ9gC3sJ8kXdSR9J7WplHCh1FmPVHBsjazYjar?=
 =?us-ascii?Q?XTmhOFoKTuh+Uur6e2NusrSfa+yBxZXEHU5wiD+3iEIZ1zym/ylunD8/7QCt?=
 =?us-ascii?Q?4fZkPVwRYama2SPCsYbTnGP26/XtathxfnRuYuOJQ4hhgbl008wL01wgtTvk?=
 =?us-ascii?Q?JtAcRzYwipiOczCh6iBHSFg035/CZDD5pKSXbfNLo+BYyhRTQQGsrhik8hnC?=
 =?us-ascii?Q?K2+d+I0mXAga2hfXfI4TUqlsF47nltW6I7xTo6qlm3B8BzQOCCUfgT/Ed8gh?=
 =?us-ascii?Q?ggY97A8I710V/WIg2lP0Sd0p1zJDpPf0zRJ0TWld83bCrrJmuPad94ZElP2j?=
 =?us-ascii?Q?IuXSlILFig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: neT25+JWneBFWJ2t3uZmIsDAOUxBwnf1MhfJIj14NymC5Yk8gx1WwOpmK8aj6CUdHjS84J/epT5fdpFOTlPjAZ8t4ROMLqfOhBKhVCi5Wn2ekvgf1yMsBiqPlVjgLU5TMWWgzCRmo2Lz6xsSGk3sDZaOJlQhHcAZyu1kJG3l+icE3dP0mHfLVPwTBICqUwAsDaUu1te3zn3yhxgwJnn8r9NOqG3ATapVjux3dUCEVl89TaDRp3asDvf+JPFEQ0pGQRRVneFOIApEVWSMEE2hJYnPLN+X4wKkC7v1QCGV011SvdNSuDe98kAGt5gr8KNOQlitT0AzkOIsWs/nE1abHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a82301a-bd0a-46f9-745d-08de83337272
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 08:10:11.9732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEYmT7gOuJNsPd3mCXHEafHde3ezVltHAx+EISp1rXJSrme/KJ7LaGfX27bt7j4J5Shv9dHEOa85tGDwdEzpog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6511
X-OriginatorOrg: intel.com

> From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Sent: Saturday, March 14, 2026 12:57 AM
>=20
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: 13 March 2026 16:51
> > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; joro@8bytes.or=
g;
> > will@kernel.org; robin.murphy@arm.com; baolu.lu@linux.intel.com;
> > kevin.tian@intel.com; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Krishnakant Jaju
> > <kjaju@nvidia.com>
> > Subject: Re: [PATCH 2/2] iommufd: Report ATS not supported status via
> > IOMMU_GET_HW_INFO
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Mar 03, 2026 at 03:03:48PM +0000, Shameer Kolothum wrote:
> > > If the IOMMU driver reports that ATS is not supported for a device, s=
et
> > > the IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED flag in the returned
> > hardware
> > > capabilities.
> > >
> > > When this flag is set, ATS is not supported and not used for the devi=
ce.
> > >
> > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > > ---
> > >  include/uapi/linux/iommufd.h   | 3 +++
> > >  drivers/iommu/iommufd/device.c | 3 +++
> > >  2 files changed, 6 insertions(+)
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >
> > > diff --git a/include/uapi/linux/iommufd.h
> b/include/uapi/linux/iommufd.h
> > > index 1dafbc552d37..d85a2d3e1b40 100644
> > > --- a/include/uapi/linux/iommufd.h
> > > +++ b/include/uapi/linux/iommufd.h
> > > @@ -695,11 +695,14 @@ enum iommu_hw_info_type {
> > >   * @IOMMU_HW_CAP_PCI_PASID_PRIV: Privileged Mode Supported,
> user
> > ignores it
> > >   *                               when the struct
> > >   *                               iommu_hw_info::out_max_pasid_log2 i=
s zero.
> > > + * @IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED: ATS is not supported
> > and not used on
> > > + *                                      this device.
> >
> > Same comment to clarify what this means. Does it mean ATS can be
> > turned on if the right HWPT is attached, or does it mean ATS is on
> > right now.
>=20
> Since this one is negative : ATS is not supported and cannot be used.
>=20

If ATS is not supported by hw, it certainly cannot be used.

If ATS is supported in hw but disallowed by firmware or kernel policy,
that's "cannot be used".

I'd replace 'and' with 'or' to cover both cases.

and you could add one clarification that when this flag is cleared
ATS will be turned on when the right HWPT is attached. Then the
behavior with this bit set or cleared is both deterministic to userspace.
