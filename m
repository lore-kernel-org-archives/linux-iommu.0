Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C577E;
	Tue,  4 Apr 2023 09:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680600083; x=1712136083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ct4ScrxuiygA1OyH5jGQ/WoSp/5rhKvgzNN+48o+R9U=;
  b=XIgYbRlcMur+d00RZMUKl4MIWHJa6GBcbRe/qGNR9qcdiYgnpt9+15az
   aX+yV8B5vtev+bM58zKucnVuGkCD2i2Fwd45uFMRmuqB0Oyzzmqi6FWyn
   XnNeVEq+cIz6QVQxoeSiwsaYNc/cEyzJOTWJnHoLJn6tocNK2dIA3XJXC
   is8f3rDxxLo5G7g9RhoDoSFe+zuv9EIHaF2ypbb51OS6XliHlZvrJC1bu
   gBvWvbwUILqW28iNjmocAD4qwZOsU0BM9Zum8/mhkOaNTwjBiyDLTLscZ
   idlA4hSrlLyCeyr8V++rXRzHbiM3BPW5Uhn76k5486IZ/dH5hR2i1KGEQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330715779"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="330715779"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="636447697"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="636447697"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 04 Apr 2023 02:21:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:21:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:21:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:21:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:21:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQXzLgcEw4/RMIH4jz+BqAXACxjwyPAXLGX6/YrRyHgC6GwK1QscDoQKuaTWtgWdvLwxsLDRRf3nnhP/6GRCLxaTxrQBEjry3tnb6k/xlNU4HC6bhjrbuUnLvAgK7iiFVEKjHc3dS3lnVp2XbU2l0qT5Get4lpijGdsUm12vrcMDx3BtN4H5XYWJ7pskFUwEuOIMuL/W2OCkgFBXHV7J2ku6FBS40fvU5sS3E6wvDqM6crTKHfJsSMLi6Q4RGyxhci9TrvjhC1kL/M9MPA4RAO7s5nxoxfWvMZNJqF3ayHezj0YFkNPTSk/mJEZpUuy9/1Z2qVqBzCp/MJ/nkEZURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct4ScrxuiygA1OyH5jGQ/WoSp/5rhKvgzNN+48o+R9U=;
 b=Syp7j4p2U2jY8IUCouUVlXWWvFRYX/+Y7CYPhhJ6fkXpgk37kI3QsT5EFba28Vcw78ilvoJXsTT1DWsQrBd4z+ElMJH7XpdXzPY4+jCX2bCRPdsdsrmxDgfPh086zXITozaUmAGfLBoBRszV2HB8a5WMAixibgfUGsSR3lLAa7JEM9bXrEV+H49jgyK/C2r8BJSH0AnPhIOKDNG3CfyNvXNZkhdr+QS21zcMEegIa1YdWmRTf1yWm5A8paN9F4RqF9Xog/2RGGMUoHZ3hH0aOyXo77F/7qnmh4DESEaffJHrKqyyAlCwbZRsrCfMk+d3wOq1y+qf0vBdpW5VhYfkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 09:21:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:21:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 08/14] iommu: Make iommu_group_do_dma_first_attach()
 work with owned groups
Thread-Topic: [PATCH v2 08/14] iommu: Make iommu_group_do_dma_first_attach()
 work with owned groups
Thread-Index: AQHZYpfw3kPB592wRkuyfl1w+Xm58K8a6Feg
Date: Tue, 4 Apr 2023 09:21:20 +0000
Message-ID: <BN9PR11MB5276DD074D271C6F194F9DC98C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <8-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <8-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4913:EE_
x-ms-office365-filtering-correlation-id: ea488428-984c-41af-01aa-08db34edf3b0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WytXgqfkuypm1ceB00xQjFY2QC2/UM8m9N8UgSr0gIqi4ynlqOOAs6W6vBq2qWY0xJmck7a9Q5RFJ8KmQOFDMCOiR+z9SLC1IlOYhTDRHW564sHm/mD8KRyL2KXu7j6F5vfYUo0xeQvuUv8I5Kyv5CQjl694kJzixE5MfDFmeLDMrFDqZMlM2cwLBZFo+JIARp00rCA9X6HMQs0B/4qymRonwHTGaR8bU4/gLbX7J3WP0XunwfsHnP6xh/XincPxcUwVKQoDCyIesVEvvLagXs3rvrPy7PMjC9lw6tOw1Aja7TsgFe6an4Xj16jcjzDhMfEzw9zqmcaUWQPyxyy695DGXTpc3qzAuZAtnqk8B7ODFZjl7qi+7Qj9eSuQ/e/Jf2u0dduQ980Z4NVfg0FSfNkOYF2UCRUQMipwsdMy/xqwlWhdv0Yem49VbKVlsWsWIq773VL9opo4eQwsTMUZR1c1yQ+H0r5uA80eZ81SjLT8uhvjNv746WgTV2LRiqMft91cjS574N1ZG16VCeIqaPHtJDRTnOT3hyuRixAoUM3ygsw3K8Yg0mxD4HVvK0mybYNkjdtn0+3FIj8ItILSkAYk+U5fgdEgZMWTtTElbHCrC9sYRm43aBcPiWGPzCJI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(26005)(6506007)(9686003)(186003)(33656002)(478600001)(110136005)(54906003)(316002)(71200400001)(7696005)(5660300002)(7416002)(8936002)(4744005)(2906002)(38070700005)(82960400001)(921005)(8676002)(66946007)(76116006)(86362001)(66476007)(4326008)(66556008)(66446008)(38100700002)(64756008)(52536014)(41300700001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nhQLeK9WoECvL7QRzXOFWYMapA28PfkA+VwoZw03q3rmVuP+1uJxL7VUYTB0?=
 =?us-ascii?Q?1MwxaFZUQeMRSLDsQnJWh1KNCItAC7X76jmlyniccYvGlnVUNoeYpUmw4p0S?=
 =?us-ascii?Q?fHJ3mFRPSA3skCOIOvgCCHQIk7mXUc4MrHLv6a58zMDWAPsRhAo6HDJi0LT2?=
 =?us-ascii?Q?C0koXIs2SKx2deJDfjXNUuf2e21Qq93ghabCK1U4jGvhgnP6SrgyML5m8nh8?=
 =?us-ascii?Q?1BgVEblawxNvSt0ENwnjTQEg67pSYgNK7TPM42oOS+ywsRib/6egJeF4s1D3?=
 =?us-ascii?Q?Wbo0hImOXyVDlFT6Il2v0bbqeJuOGyRdrWXho+5UzKhIl4FdLKvgiTuVFyze?=
 =?us-ascii?Q?DvnIPi3hw6KcrX1IGJgglAGCH57IPny2b+J/zbbIbJueHj4BUmEsP28doNM+?=
 =?us-ascii?Q?JQtz6ymHktQAT7LzuOmnU0c1RA8yoEiRPHzH0rVXYwAIXqJ60brrxLDgKqBJ?=
 =?us-ascii?Q?ZwKnQdmKgtq0EUSfkCVMyAZelViZEZ328V5U1iMG9UVMNebqjxoFBdg2mF88?=
 =?us-ascii?Q?FkL8WFUgvCKDrvxXSx6U2aRCnNTpm1rf4ufxQwWeQaGisjLvWRA2yS2fRmHH?=
 =?us-ascii?Q?egxsNrK9Omcg3LS9q+C3zshEGKc57VPpWwqXXxbZHMG8PkxLIWy6BeZH6HRu?=
 =?us-ascii?Q?WysxXHH3V7NQ4htxOeSsm94gaS47qGJxunnMWHKyzmWmwef8KSG2nai2N/Lt?=
 =?us-ascii?Q?DdfiM5u0heqRq6FPeaGs5lZu+K6zrSRiSk2dP5Wo0O+KPk/9ASTJZ3MW0eIL?=
 =?us-ascii?Q?1mmQHzpCxPcT+3N5GV/Kg85TfD10qrJKl3UXQmwUCq89/LbXX+bHlNShY30G?=
 =?us-ascii?Q?fd9Ya3b1glOh0IZMzo7NXWm9zRgDAZYldYterptaNvHmnk7VAd17KuBGmuVT?=
 =?us-ascii?Q?UTCdrNl793He1+GaHSsTMt2WXvG+KyC9uBzrCEG9HpL6ik+kOCRqei9Mt+9D?=
 =?us-ascii?Q?EqHllZz+S6DZdynhgHWISPnLvGc60dArlN5lsAPr83S5Aegkw/XK8g6PktbQ?=
 =?us-ascii?Q?nkRr489kMTg9WwgSOSZB1li4j/mddpczlzDl9f1xNxrxNC9lFLFGreU4tp8u?=
 =?us-ascii?Q?SKJp3xgorm0GTLXeaBS3SUiTcyNvCHcwHGAOLh6+IUH7Cg2fYshApJra5GkC?=
 =?us-ascii?Q?Zc9uyWozKk9/dpnWvtufhlDSyUArpj0qdCm1SV/cvDrBWemLVJzqNUq8jcGW?=
 =?us-ascii?Q?kuITnQOArMUXFz8z3/g61Ak8y1OcO8a9bOBaA5nGkbkkrEXGRQAmgnzaC3MK?=
 =?us-ascii?Q?83fGt+WeIK+oK2T5VRReCrR3mVZi8y3mM1cbLyT8MMNtNjUfLHc6UjibpPfE?=
 =?us-ascii?Q?q7n7evkaU/v+aUPpKD5BIWwbyBUcA2FN9F2uEu/h27RgT3wzEyMUQC1gvEU/?=
 =?us-ascii?Q?Z8VttodvxlEsipgkMXIjtBFXSyMPsKbTwQR367tnmI0FxbCi7GM2a8ARj54O?=
 =?us-ascii?Q?Bxcb6FtTm705zwW8XGiE78XU+/wM2x9uoiP1m3g6ywxEWD5HycvHC2IXgImz?=
 =?us-ascii?Q?9IWHGW38Ooif7U6/TguaDyaf9BlkjSPajSbGV1Eq4A/E+SeTxRyiYH2K5GOw?=
 =?us-ascii?Q?bTexuYdEei8ce0w/BO/3pFmHejoQfs8APkjReE7A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea488428-984c-41af-01aa-08db34edf3b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:21:20.2945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAbvkazSR9ziPIWNxq8tbf+Ivss2tECv0wHIg4K/IdAneNWeNo7ROdJRhw7t6C9X5D+F2FWbm17TBtlEEphWEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 30, 2023 7:41 AM
>=20
> If the group is already owned then defered attach should not be done and
> the device should be directly connected to the correct domain.
>=20
> Owned means that some driver is already bound to devices in the group and
> is operating the group possibly without DMA API support. In this case
> there would be no way to correct the mismatched domain.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
