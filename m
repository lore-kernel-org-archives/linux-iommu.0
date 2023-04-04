Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754437E;
	Tue,  4 Apr 2023 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680601166; x=1712137166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MvKW6cY00mxPZBHMk413oPfrZFJWA6LJ6SgZ701I5cw=;
  b=m7NTdsYO6BOl+XcG8gvTPfDsqY/mU9yXGg4K7Xc89NLlwLsgizRY1M+V
   DsZtNv1pWOMyYlS9s5rsczh39/UhOYRQTn+68nRrkzTHCsjmA20GwtsRl
   UA+PwrF66Ny2d/amBV1zohKN1Z+iOdcCn6fNsBi9j++BGp2AG5lG1UgA5
   +RE1Mvdx13O4TpU2LxiJGwYJERGWJ/iavVTY8JDr4I15B+gOq/Z1wVmCT
   AgnAEBf6xhKPKhQZkUDTm6B6l71ryv4u999Jq/DHhtI+yz/D/BtS1Fok7
   bN+EdUCyHLyl7VK6vdyJYqT60e3j3ENvqA9pJcH37uM27tdTN+HB4mt3/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="339623939"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="339623939"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="688826325"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="688826325"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 04 Apr 2023 02:39:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:39:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:39:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:39:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmRIEBCurO02li9QsR5InjHTkVTAOBLGLI0ZAfy23eEWARkQ0p41HMSO08e/FV3kL/MX/6drDETSqPWH/evQkrB9PXhn8SvmZk89TZ9wCStKhTzfJGJCUJ1DhJRnKkXM/rC5qK80OPZ/H/+AwlYvKhle34Mfd6WdIKu/G6PKoEkJqUEyMM4BXLItn/urTqvBK2/JL2vWkNLi6GDVd+4SVFxiKUJuvoWgDkMUCuuD5MMpNIQcIgjH78x72ovSo44QTjFykapnKWcpy3J1lgMxwvUXYKjGyMokoY8ZfAXVHJjV0sokyaJH0FrVXB5iF71XW5Yxsx+WBdpDHSubno/q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNlPqV6EFOWrdelUFIX+jfe2C5Mllg7h8vCcifgzrIM=;
 b=MC+LtCpJIULd3o9pGRkqhZCDEG3h0BEbrlBE9eqjOsfhjX4+Mci78/Df8zDzqot52jDd5P8nv1L/BmQTrbmBGzCgb5H4cyx7y2YbKOUnqtb5rLB8hANjZhTlx0ArBtt0BlypZ8y09lqZc27TLBa5MQiwpyQSL8ob9OzrXTuJH85cjvdTL9fAw1azY0Vu1wjUF+HQqm4qFltVJ4TIfKTl94sNICheznmuHc1YTQscImuNvlvGkrRTW7DOfONPZNJoecCr/Ni/9z+bzr0ZV1abJIxDPNbahRQ+LWdNocYg9RMrNy0axNmCwZKyWMKQX0uMRuMQeijZvaP2ctJ/MvYAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:39:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:39:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 11/14] iommu: Consolidate the code to calculate the
 target default domain type
Thread-Topic: [PATCH v2 11/14] iommu: Consolidate the code to calculate the
 target default domain type
Thread-Index: AQHZYpfsuXlo0SvXGEq4rrSrut/X6q8a64QA
Date: Tue, 4 Apr 2023 09:39:08 +0000
Message-ID: <BN9PR11MB52765CCF875C64A9830A6B048C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <11-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <11-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: 3245e5dc-a509-4f17-e56a-08db34f07025
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hYq1VtQlln6XOb3Wr9Q2Cb8UoWNOfDHbtNv2k35kmqyteXVy2GGdQbi4QKBoFD2Ha8Uj90VE5Xkowpjo9Hw+h5Ewf4qyoGxlVHPZd35S+R3SNFDDAT5/qIy8ec82PUNwtZ+0cppBH8pP5hIkIFVTJ2iIjZCbiP/9bu8mpOzLh+hDO1nrjBnWy+K5EAFaL9vQgNWDeEdADAZThgulpmzvn/mm3KBPCPLA1hXxjhccCjM+LTxXXIEZRA8dCWs0PczAMpw9BUbJ9E5I8nsjJpTSt8yPb3GmNLSfQMycLMfFQHAWTgvNeDGkzgxHUJItFz+koZTphSVBED7RWttxIE6pIgdgN3l/VWknq3oUkRH5OjrcZsA0wxjW6YRMKQtnBwqIt40pTzv12ZjMwPgy3QsCHY4wz+o7wNuvvEq3JUAVDjFVWj1tuoztLpH2kEKBTuWmF6op75vPmX/KjdLi2aFBKVr0mBpatw9VFVSjMDBsx/IodFl5dMn0slmcct69D0r8Oeq+5a8tJ+X1d3Zj4BsP6K65TFnYLKkcRiuUK5CVrtJnvpnYX+BIJX6PcsWBMCloGWXh6hDXPUMtFE7+U1P6y/qD6Co+7JMgbpiXA2ph4LE1hWgDd3IYcXdeAjzGhX5Gd6MWeFFGNRrMNoTYwn7JqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(7416002)(2906002)(4744005)(83380400001)(33656002)(38070700005)(26005)(6506007)(55016003)(38100700002)(186003)(76116006)(66946007)(122000001)(921005)(9686003)(82960400001)(86362001)(41300700001)(52536014)(5660300002)(71200400001)(8676002)(7696005)(478600001)(66476007)(66446008)(64756008)(66556008)(8936002)(4326008)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NG0ME2qZRtm17QPpOhN9sIkJO0fvNX/1uWRwkfj/uk93s1ACz1b3jwfz5fcI?=
 =?us-ascii?Q?Rvu8bsQw9g5vVC/lwGS5+Cs7AzrikM5DLPBPycgzMyD7x4MZZWP4iGkXRW+5?=
 =?us-ascii?Q?S4m7J1nhLoxT/tXjujm9iZBxxIdoJRdq8qWn3m0JD0bMKWq95M/QCGI4l82+?=
 =?us-ascii?Q?p+Nm5BQ6TLNmiuO9JFcdRh0POAKA1qkzIq5zszvDDVQwbRajAT7HIYsaWO98?=
 =?us-ascii?Q?TSf04VxQKqfzPzuD4sfWVCvdc26NnzGHyj/p7QjgWxoC4bE9MdANMA1gRdSM?=
 =?us-ascii?Q?AYDiQV+S2xtarXG/ZoiIEj/0Y9oKfb5U3t1EDNb0RhlpYNb4FHjgPtkoKNkB?=
 =?us-ascii?Q?dGJvc1T9+QtDS5bZc+QmRdEjJkmtbnRHhPCaAl3vML6jD9AAgiXA+iqQxDoo?=
 =?us-ascii?Q?VrPkogUqcnyWKBtnzhw/RBsFPMUInWIbRLX7K0LQRvHPuhey/h7u6+uqdh04?=
 =?us-ascii?Q?mRm+MkhoXFSZjgkEgpWApFDMEpVoCO5/qPaMqOX3l1dkb7amv3ro9mPvoHHl?=
 =?us-ascii?Q?+bbP0PtHEXYmEPN+vs/ih+nBvpPYGgh/KN/vdtaEx8a1z1z58wA/E5pWsARN?=
 =?us-ascii?Q?Nu5rK79PfvkKSBanYP9uwhEBw7fkG3MxdadK3YYWJAo9P+NqOxuEWxObDQRu?=
 =?us-ascii?Q?sgfSJ6ZCsRA9kqx5mvI8skLaIu7MdoAdqFEmdScgvrgyAS1xEWCcdJvuY0P9?=
 =?us-ascii?Q?FTqKitpTwVo/ZmVCn8bBzJbkCIj/0cvTSZfw1jYZlPLEl6X1KViIqg6+UDdY?=
 =?us-ascii?Q?hrnDfORIBv/ob/+bEQI8QS6CKC6MO4oYYj1B2MqV/aU8L+y0IzeH+EKdPBLq?=
 =?us-ascii?Q?txbA9lk0UKWXrnVyjnF8UCkrbfwC/ajdqMXgBqUvjGh1/5/+XVWgC7tB6Hc2?=
 =?us-ascii?Q?GF+tHem7ih6SPKD62QlNQqn7jujtcBmv7FsbS985mG2erVXyiZb8fDjePwAm?=
 =?us-ascii?Q?ljF6qv3RrdKeN+UngQeffdnZAXx24tAxPuhSVAKXcW1lM2BdMONG1iTBOGz5?=
 =?us-ascii?Q?hlLqkqv+iUxVltDSt33o38+aBKImIXZs0W/Yl39gvzaEbOHTcHZ27tepfZtU?=
 =?us-ascii?Q?msoAI9xZEuVEYWp21i4isoOADHwuk6UKZXi5DUFG4/cJbTmKm2E+aCnGZI+X?=
 =?us-ascii?Q?L4yCbSMegOSZrCTVgSK6+KWOeX5f6/hiCpiLuenh4Xp4NmwDnQiWc6tIt1ev?=
 =?us-ascii?Q?+KW1FNVtxLjhGW0twBV8xSfxuoOZu8xytJNDy0IwxH2b8bXuEcqbykfOb3Zx?=
 =?us-ascii?Q?FfWMDezh1GjpaErfZwr5TBHY7XlkAtVBZJCdTOM1eT7iHJuaycp8dpyoeK5M?=
 =?us-ascii?Q?b98anKZUYZxh63tVBvQ/TENl78tR8Z1KfHqWnJtguvHv/r3CWI9vggwgjLIj?=
 =?us-ascii?Q?zq+SwuFRVtmspGZRRKV7mFwrrM8M2JJ2897bWrRbZ9Hg67PTp6y8H1sZTvxU?=
 =?us-ascii?Q?wkgn/5SlZ462/es5eOsuhBzXz6I5ow1MEFsx6IzBZHoGISumJqmWVLgjzA8/?=
 =?us-ascii?Q?O5ABO3s3QMkey0iNgtsUYpeVOPcszPLgNe4WgrKlTkdg1nTsLoxBwbpY6f4b?=
 =?us-ascii?Q?XVSNY2K6ZaWluZ+1I9YaxSpqKdfsqA8sVQZKtW86?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3245e5dc-a509-4f17-e56a-08db34f07025
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:39:08.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1IYy3ZcLGLVSMmOlRMJ171TInkTGiHkgNaZ2tPBRHnwWgynenbYX43v6fwrMeGDZIjyeygLL87029MpEYx1Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 30, 2023 7:41 AM
>
> +	for_each_group_device(group, gdev) {
> +		unsigned int type =3D iommu_get_def_domain_type(gdev-
> >dev);
> +
> +		if (best_type && type && best_type !=3D type) {
> +			if (target_type) {
> +				dev_err_ratelimited(
> +					gdev->dev,
> +					"Device cannot be in %s domain\n",
> +
> 	iommu_domain_type_str(target_type));
> +				return -1;
> +			}
> +
> +			dev_warn(
> +				gdev->dev,
> +				"Device needs domain type %s, but device %s
> in the same iommu group requires type %s - using default\n",
> +				iommu_domain_type_str(type),
> dev_name(last_dev),
> +				iommu_domain_type_str(best_type));
> +			best_type =3D 0;

well, in this case best_type is immediately overridden by following lines
then "- using default" in the warning message doesn't hold.

>  		}
> +		if (!best_type)
> +			best_type =3D type;
