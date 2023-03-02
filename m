Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A141863
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 07:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677743165; x=1709279165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kx4SoP3t18lQQbPX/JRykBSybX3Z2/6FiavgyDVJZzo=;
  b=eBhLuNiapYrkbXtbkQ0t+gIZKUr/vP/dJ5qGIYHZlI+53+IDjF/bo8H+
   Wg+z8svgStuvA0f2gA3zLHhVwbakod3jtABL3RAp97VhsV5ngWKlFvzry
   mBgMlMA+hxSCo3cjUs25w7Tx0j+wlbHNyKxhZnfMQCSVOmE63/DzQXr+u
   PhIWOibRsZko3eIsQPzyLgyG9OQylfqK5DBKMFZskVGjgIqHvdeJ3UnxT
   uMIFnYnRwyEQgrfFJ2N/oEPVisj7L8FeH5KXX4PV4gO5UBu0WcymUUi4a
   Bwx+AYjHSTeJvuw14upk2/2EqVwQIAowMFfNCHvt7DMhiQ8gWEXRssuG0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="332129431"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="332129431"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 23:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674858684"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="674858684"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2023 23:46:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 23:46:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 23:46:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 23:46:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZebkIdoFqdLh6Ft+aqz1S36mif6+IBH6yW2lWacH2kJOd17voJb2e6VHj3yg4ZkbFjR40XGS0vTozrxIp8cpuoQ7jXn9K2zWKy4+AVNEbJhtx3TXuMvSZzvZl1pcgod7n3S1vavx20lSo3i1uzkSIDOZZfQSl6Zccj+Uw4Tm0z6sT56YwLdgzfXLRtzN1f+bJrS/KxzRbqM3WOk1T3nDPZs4qzW14E53f09UFt1eJry/zEDq22aBGmBVfutrAwU1+NGo/M4c3L3MYIZHG0npk4ugJGnOz/wNusrtTvLulboau/pTalKxW2pAGwx1a2yjO6mjQS6EzzMiqpyT30wPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx4SoP3t18lQQbPX/JRykBSybX3Z2/6FiavgyDVJZzo=;
 b=ltecUZPHmBEv5sBpDAlfnNHDRypihWgKrJtRtlDfjKEJ/9XHcg7vZUXXNqIMbEFEHsp7qYzBr93NQ3/2/0BHxOi9iklGn36bXH0qAMAxRmUHK2a4xA4o7OCqDZsXKSGalw17QDTJkuuOi6utFXpPc13hODt7Qn8ycQEsvnJ5hA9orJi4fuHEqRUKObvWTznV9onFU00YPlfL8iNAUe/FyWrihLNN/Ig+69QSEsXMieDt0p7mLfvp4edvuLIy9gxTpXvBy75ti7eBF8XVL1Flzu7FhL42VTFHxF9mB6pIiFI/OgytjHYublLlKdXgaPdF3OnVwtO4Ph+l56l2zq+OsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 07:45:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 07:45:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Nicolin Chen
	<nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 01/14] iommufd: Move isolated msi enforcement to
 iommufd_device_bind()
Thread-Topic: [PATCH 01/14] iommufd: Move isolated msi enforcement to
 iommufd_device_bind()
Thread-Index: AQHZSLAPMzZp/2dvcES3Vg7WyP/PIq7nJI8w
Date: Thu, 2 Mar 2023 07:45:55 +0000
Message-ID: <BN9PR11MB52760CC41FE9A62446AAF71F8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <1-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <1-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5881:EE_
x-ms-office365-filtering-correlation-id: d3038aeb-ce78-469e-0adf-08db1af227b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GMz1z5YRBCNCRsyb+RcUiOHco2oekjX2NHwPkPsubTUXvRJXama3ETJiZMf5TsA5m60iEOFFMX1qrJTtFE2GBQS4/JVizNTcrCqB67TNpqm4jslybElnXIHsn/qvAm9xX0kyLVjVQ8MTnqn63HiJDlJwRQkpSviC9LthVtaTgnPw93y6Z279hQxYGyIakTPdxL/QqYSh/HsDinLdibDXURAm3CcytkmxirzasxLR+QTwERWhgMjpcE+JMGSBsmgl4UCRMwe1APJrbszhZPkT5PLf5blGGqv6ouuaQTIZlecPmaApSfUZ7HuymVOUWY67sYLRKQSN/IJ3qrwDjDV0dkWAvG46VC62GG9R4jRXZA4E3kwlXzo0u7C1coK5dlsuX0Pgnb5iSR0ZDPW1lmZKqiw9v+36KzFPHHjpHgO4N/ODGtDrgLD229Y6u/vnXMeXngUb3PXo/71pMZBhg/ZrU7026JoO4z99RoEubsIh0gsmekxd9TosoTsnz+OELV2b4bgs5TdyKi8bPSBLh8A6M4Iaslb7t1PNUYhyClRPG8S4QItV/mKekvoodEOTj1nN2u+0JCDZYJUi4m1oN0U71gYSes/waShgSefLmM/Wp9ulgBUPxKsUG0fn5i7yytGmmkVQ0qOkMFCgte+tpBYNLeS4UH9OwfATEApWWtxDBCBq8XGo8+VFUtuKtTQLIZnLXLxxfhNha31fbwttHwYVcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199018)(5660300002)(4744005)(4326008)(66446008)(64756008)(66476007)(8936002)(41300700001)(2906002)(66946007)(76116006)(55016003)(66556008)(52536014)(8676002)(316002)(33656002)(82960400001)(122000001)(38100700002)(26005)(9686003)(6506007)(7696005)(71200400001)(186003)(107886003)(86362001)(54906003)(478600001)(110136005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0JXzwk4ONVSIl3itwgfUZ9fKBJhPWKUvS2Lk2E+0PjdHzJvjwhuyFgSe339v?=
 =?us-ascii?Q?u2lFBAT4tSIHvtidJ5y9bC1l4zREwUO5DaVwiklz2mpAwq/fpd4ikTnU7x66?=
 =?us-ascii?Q?a3Br+e+xebwFw8C8rtHT3EKH+UmyhF7udLhep4hGyDVNPPEKrKivhzkC2VHw?=
 =?us-ascii?Q?V3TSyok1yKDQfAgA/AoFy2MDZ6BbDT6X9yTkt22Rt2PPlgxVMFRf7fSvE1jk?=
 =?us-ascii?Q?HcqKYM0/Kyk5noYr1OVO7Tw3oEM3l9IlGxqDJNhi0BSF+RAo0K66AfP45GC8?=
 =?us-ascii?Q?zPv5MtqX7J+LILxln+6fg+HbOwjakWonBOhG5jrrLqEdJDC8jn0KMxFn8YBr?=
 =?us-ascii?Q?NNFFH8FDY5qMPg97dDKXmKr0K1wn0ltAvNV3xMVIJKC4HWNVsE2jN2XtGw9U?=
 =?us-ascii?Q?589e3ixeiOof4vewXH6mXB5lEglFWCMnt+E5nDajH28byRa0pjz3bxhTBu2j?=
 =?us-ascii?Q?1hyzQWf+eye9rfQe1Cq9aB2Jgz9Qsb8JMJATpqJGVSuUHZP2GsZrLRRWDNr7?=
 =?us-ascii?Q?QHCmEpWaXgEH4YaOIN+NKIg5CO3AilN1VpuiELq68UQxY0/LJwBZ6EUKo8uD?=
 =?us-ascii?Q?IQuNclU5jySI7WACVVpgd0h743yqa1JFTj6j1qTs+gm574w55Yz0Iuv8FXUP?=
 =?us-ascii?Q?oYzj7kW7Z9zoo7i0gYzsoAq7Xffs+bTusyOjEfLv/lrULp1W2OD+T0uVAx2e?=
 =?us-ascii?Q?l8NG+WwWX1zkgiOrwkhEN4aXkaKyabE2VaeacD4leBqtPYs5INcI5qBPEFns?=
 =?us-ascii?Q?28u4VQMErIf8+TEjOjqKnS3Rbt7m9eC8wgBph8qLkVSVQdlON1RnlJtVW85+?=
 =?us-ascii?Q?bhrIlWSZJ4kRNB/mJZyVV++ZWehv3DZHrQOiTKhKg7SzTrluDkIqjgAyxw8J?=
 =?us-ascii?Q?AMX32iPQCXHrwJ7JOfVGLc3bLPgkgXR2z6MwyINogAyyGNqENVFsCv23zRqb?=
 =?us-ascii?Q?Pera4oJ3w5SECiS62aBVGb8DPU/E8xpWjNzkh6w5j7BdJGymOi1N+3+ZjNI+?=
 =?us-ascii?Q?xEYmxtaaX4jT06GhRPEeKkSOuiM1Btu7VAFZ3PkjaQUTi5cTo52cIOxMptlj?=
 =?us-ascii?Q?OlJQtY9qunCiNlTWBLflZv2VrUMJSRFr7EMscn/YUiYggBS0QXCbHh8ZUeRd?=
 =?us-ascii?Q?140UOSCB3d6yNgMaRbRbaECLJ0ZpgFG1tV2UZQ2TNKsWR61mmBFO//Rg9fns?=
 =?us-ascii?Q?2TFTBsrdfeAX0U/jW3AsOQzj5FqJYBKCLBK4J0FjL3FLG6UG90T7834ciwlX?=
 =?us-ascii?Q?bFFojymTDUKVw8tS4pP/XGy4YeFYC9D3/7Dzc3WBePjn7XgfbWhCJ4wBPpbd?=
 =?us-ascii?Q?wkjjMHXj0650Ugi0vC2jVLM4N/o0VMthoTROysHFmFcxOgjlqClTA0PD8lUJ?=
 =?us-ascii?Q?uAVigN3XICw4S/ZDOlW9TzmgrGII6djv7k4uQlbU70U+YTmrDcBOYdM/XLQM?=
 =?us-ascii?Q?xbNbqwbV/6qvXZfLsNuvVUyp33cyAnrZyW9/U8ZaQOewsLJV6tUcCQgnPBdD?=
 =?us-ascii?Q?MdDMQ2yBsj/PTCwkj7WyH7V/OXZR3usNiif9ZJZM5bRImAFqoXZRDw6DsEsH?=
 =?us-ascii?Q?J5hgbha8quynyU01xHfgkvA6H2odQOH7ozt0aVa6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3038aeb-ce78-469e-0adf-08db1af227b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 07:45:55.3197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3tk8Ftusyh8/lSk1AG2n4mKfeAzpKeSg6a/MUyBRVXz4DPSnq3K1IwyV3BYBvF/vDLohq7k2QcSsBhuOOr95Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, February 25, 2023 8:28 AM
>=20
> With the recent rework this no longer needs to be done at domain
> attachment time, we know if the device is usable by iommufd when we bind
> it.
>=20
> The value of msi_device_has_isolated_msi() is not allowed to change while
> a driver is bound.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
