Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B97E
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679643024; x=1711179024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K8S0BOVRYCQBWYbgPmwExhiMH6EwYDUddggTutWGP7U=;
  b=HFqWPPIipRH0Kz5BYgKQsDc10g+ABlChRq2ygHSYFlRO3F8sug2Tr0GM
   i5idNQBlrv7ltpI+4fQrxM1EKFWtjdFQ78JoTWu+v+kLQc2gVhfR1QL4O
   txr7d6ch5x9wLB4aen9f3T3KgP2FgYinfKWHsF9IPnXD1dvqeMk4GKK6I
   mDv55ji8lmzTi8YescMklOttzLvSO23bcp9jyqodCnGY5lIY2xI5kyGP9
   Sn+c3s5Jq3jVulGxzl3y89lGH50MdUjADZlWm3vuL4dchJstOtxmh/Yc7
   lZqNtwVWUVuXcHiBg7e46CXVlAnSTyN7lh1tKRxEpjYaIj94BjpoHjZIj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323587860"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="323587860"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="856775951"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="856775951"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2023 00:30:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:30:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:30:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 00:30:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 00:30:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+zENG3Gn3VbSJ+wWE7mZTNVDABSRhv+BJYHsvtCgxqEq7O/5/Rww583K8qMhqVjFtXjViUiIGB8Xw0cdh7jKSQi5QAzANeOVm50nzgE7rrncTbqyol9uJhndC86A9hbasx81uJopP+AMkg9/9Rgzc0WgsfXf8jALnmQsNsMIRmvd43fQ1IbtXDuUEI8j9Jpgh4AJMD/BWE5OaybFycVVeUDSyNNf65mL+yQ9ADyK+ku1uwBUSKNPvz+C8gKPsdz4CVCCxmH1BnNv2zS/cqdiAX44gxByasJUuL+vMQq8vndhtwYkflQ0ymPG9vxXZUb/jdz/BiWbHOimideeiUJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8S0BOVRYCQBWYbgPmwExhiMH6EwYDUddggTutWGP7U=;
 b=kxhjA/Fjmbq3VH/J7TW7OYe/bsbpixpdEpN8NmyUVBYMRSwy4idUG8/xwJ7i+FfvaLDb2rAQJ8cWA5/dUQ623vpRyvNs9Umnll+f7yyfHFISYCqBf5TMYxj3xpphikSvuqnGNzwpZiz0GcZpaGTU/PtANNW2nm1Zj9F+hm7oP502Z2O4CIXhHeXKJ3KzzYRQy7PnI15Y8bDr1FsTsGdP5ZUfcZMMYvKXs8pgkBP0sl9TSrnPnzmzBttLyk/hLb4UtgaCM8atANbPwb7PJpEB+OohRfUV2l4SGK3AF3iZaxyDIrk8439Bue2zQv+oVjJnEK6gw22q9e829fBXKitg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:30:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 07:30:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 7/9] iommu: Remove the assignment of group->domain during
 default domain alloc
Thread-Topic: [PATCH 7/9] iommu: Remove the assignment of group->domain during
 default domain alloc
Thread-Index: AQHZXC7a7xQ8URH1yUSdPMl8gYaSfa8JjIpA
Date: Fri, 24 Mar 2023 07:30:21 +0000
Message-ID: <BN9PR11MB52767610D336CCF5688D58038C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <7-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <7-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4892:EE_
x-ms-office365-filtering-correlation-id: 9cb351b9-4f43-4f68-093a-08db2c39a021
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RlHOUOzibLxLTwkh7SRT0xkv6ADHC37DEsdJGF+z992cmay3JozRUYxGcUtGWuS2IjvLH2v6dB7yiUyZhTCAfM57tm0sUFwrHXCIMU2i+aijCdOAr9ASD0Z0RuIYLeLSPbITJg8GmYhyY3ljZshfm4AM3NNg4SUOYSBxaw5om4LwTXRGMKRoTDj3quoLLpEKlfq2T5h7G9lZi1plXZYEgMoEgz+rUdpapMk5K1+ol5PByW1OI7i3UJzCC44whK28l/J7vWY6dJT7VxhL2tFme9zLFFtGMWe4TOXwwVp5xxeX1n/oRCcZZsk50F8q3skWP3UKmw05cBv9jCfsaNBeGmtMHDAfAQvxnfkZo6t0BKyhEoj515dmr49Cfz46npHMCFXUvNGReQY1hdLjtpw3u/f68bxfEBI3ooDczQlocgVlJYHeSpCICJP9BOAI8g4BsnkcfqPWYejYg8T7q23Ko4PIfA/hj2sfcWeFSC0omSA4c4PFaDgjPBlkEMAU8zIGnutGoh0bXKzBT/ooNaAdFBc2P4wfLP2u2aNRCbzSvGZmrjVsITaXGBnxvFclqyMbkAdnlRU6SWOZMsZAJ8jB8zCrLFZT/h6dpy65j8vJ90/UEF0xsayY+I9fW2bnpTFCRrObJRDtOR04KWRwcBF8WY6OpmLi4VPCfDyK5OAK+5rB/sQjmu0xmmQr+0QcrndNaxMbj4RUXbrsSAu4EEsQlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(5660300002)(122000001)(2906002)(4744005)(41300700001)(82960400001)(52536014)(8936002)(55016003)(38070700005)(86362001)(33656002)(38100700002)(478600001)(7696005)(71200400001)(26005)(9686003)(186003)(110136005)(76116006)(6506007)(66946007)(8676002)(4326008)(64756008)(66476007)(66446008)(66556008)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DFSL7N2vH7xp04BDJCvBq6uSDBRgqtH1SfPI3OmLjKm+pY/rcC62PS+jHHcR?=
 =?us-ascii?Q?Hr+ShesZNuQJU6hDz1f70Je1yVqNRYkyzDlK8yCNsapmeM3EOzCzXkUJoxCN?=
 =?us-ascii?Q?wuFQr837cj0tpmzdF1NI29JLvccw2NXcs2LvlIvosJE6iA+Q3Or1yJnuhnjj?=
 =?us-ascii?Q?UgfrKl4Y05WE2nmu7zwQ8wr5QgDHQQ6wiokjU6UE4hNgMEXU5wUPjVL3eeow?=
 =?us-ascii?Q?2Egp+D2KKqkTnJAwc4jkCn+aAHo4kYtuPOJmX20vdC3c21IVlNqB84HQ5lq6?=
 =?us-ascii?Q?AyywAlLqqSAoSBCzlzEt8rqnPBMAHI+9sZSGr8fDrqgmL2PTSR4tSUK5fa+G?=
 =?us-ascii?Q?GowkAr4IMIZ5grY7F2/Z4oA0HhugR9SrfTU0YpHnAAAGoY3Jr0/oHk5K54bm?=
 =?us-ascii?Q?dsiI6mxqfczznoMzZ0Hnu8AHzDL2RWf+UJ29SqTRRPF7WYTdSDrv0MhMQPqC?=
 =?us-ascii?Q?HDP0X/85lTuQzikFHL1pw36Zg9BMqYOlU85kIWA6TJFl1Q+qRxptjHc/iFZ1?=
 =?us-ascii?Q?ld+vN1ZtA1Gzwdj0CRCthN9g2YlHYO44WdXF9UiJVSjoqk9RYfrqFcF9cCXw?=
 =?us-ascii?Q?l6waCFnIlfyoUvC4+35ER7eG/vNjxnBwF2K8/a3MXJ9UJDeFNmBFh1Ydc1RD?=
 =?us-ascii?Q?OzGaEQ4qFVK2Uo6oUJfBVNUldNAafJQz7OGE6lHM+NJ43Ct0xX0s6SOIDKIc?=
 =?us-ascii?Q?8KCyHRRdr7FKsEMMoXg/hTul9p5cZxPnq44biI00HuU5BtzKjH9Hq7DuDkrb?=
 =?us-ascii?Q?cuMHiolbA5vtQy4ico3ZPajd9t1tay1hq6aBK0d97HvsXFi5dkgOafVkLpUf?=
 =?us-ascii?Q?n5G+/qRaekw6z9yqwPlz8t0KXqkjgGG4b+7tSXz6eqKiU9cS8Ssz1itYJmME?=
 =?us-ascii?Q?KvrWoFx14yv3oyRlO8tFCNrRmSW0vXCWT7M1CW7dw2XBMjwN1eIDbrSU16rC?=
 =?us-ascii?Q?OpSrFOARmI/xcAX5HpjOiwr/p2MG0PWEsOihHWVgRjWH+lJ2bH3MA4sBaw7/?=
 =?us-ascii?Q?MaEU9Qqc7hSQie8ddKM0HYkecQvdcZ+UVcKnNl3OtzSHZMhflszseqDwfxo4?=
 =?us-ascii?Q?EFzzC9uzAGPtLPmmTBJRHVr4QJzXezGyUPiCsDzM7mdHn3tMMsPN7sNMdhH1?=
 =?us-ascii?Q?vDSkl8iX9L+jYRKx3fl58wU37W2RvnpauxORFqbVL8pIilZnNoC8nhulxroV?=
 =?us-ascii?Q?1AtsFBzojxplHEJzbOLnTlHx3hpww9PjGHFfyGcBknQ6MuVMVAVNbY4snP7y?=
 =?us-ascii?Q?J4+HFlolXg7VnQc0dcmBfoTRHUWui3+MlBdDEnVXeQWgn/nYLJJwUBR5yMX2?=
 =?us-ascii?Q?4Qak99dGpr+D7hTm15SdpGVvrDquZcdvN+2yO5UXQLCv3y1O9BZPw+MsoSq9?=
 =?us-ascii?Q?UquaUu8SPT+L12S44X/Km+e4t5uM5QU2jQ+GrcimSto7yyKtxHVK+GHpre7/?=
 =?us-ascii?Q?58xp9m9XEksTiTzvqs8uAPn2nDKbDUuSHeP0holN72Zlce++i/nSfuKRtGl+?=
 =?us-ascii?Q?Nsd4netJF+88is5yLyQaUpcoWYWCsE0+0wP6AZyFUbH2m27K2AcULAOVx/oZ?=
 =?us-ascii?Q?lH/v/0AReKt3PGFr41hKTccRCqu3MJ+ptmKZG5qN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb351b9-4f43-4f68-093a-08db2c39a021
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:30:21.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QL4FTaHknBCvGuguAJHBCOc4dM4dT9LZYtZiwBJr9VsUdGkpGIZNoDd210nY4feIsbLRGUszhFd3gyDlDESbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:53 AM
>=20
> group->domain should only be set once all the device's drivers have
> had their ops->attach_dev() called. iommu_group_alloc_default_domain()
> doesn't do this, so it shouldn't set the value.
>=20
> The previous patches organized things so that each caller of
> iommu_group_alloc_default_domain() follows up with calling
> __iommu_group_set_domain_internal() that does set the group->domain.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
