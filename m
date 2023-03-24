Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B34C7E
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 07:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679642614; x=1711178614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u7a4VHb8LW2pPrMGdsXq9ygopmLb0O2k8q+pZOEJXXA=;
  b=nRxLMbK4t67+f8KlVr50+GuuNiagfdNe+MogHJE1/VJF9uUybKlTDslu
   bMeZmKHaWUhvDv4qL7OcwdOoFRe+g3cssV+QUhdUCFO2OcYcCrnZ+riXl
   GsYvRC8xRRaHWFhtX5hlqZ+8G2w474AlGQI0gXzkIh/fOQ4kJdnFmX3Ep
   HfgcSrbp6ZJG7poCgTnj9opRq17mgPq0UqphxhWWZnWSCyvynwdAd3IHa
   UvP1+5LYLP8rUxaMGyG3Nm20LtPXY51UehmZi+FFagrWPUPsy8FSSg+5b
   hzAJdBwhgV2kOh51zGDK1f38VmNrsutS28+AW08IFrhmPJQv07+eFD8PF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="328129406"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="328129406"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="826146482"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="826146482"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2023 00:23:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:23:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:23:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 00:23:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 00:23:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luj2ggQoaT8V6YjJhy8YfAtuuo2V8UNUgmJcUkz7ZM76J/xkKjrEuG80AufYGhd/4/enhN0Gijf3L2fschJsicAdQv1YbOqaya6S/C05GGinQNHhx8OFMmdjJpczpGaI3yH+5LW7y1xndFeLAx+wtKhLF+dwMHGkNNELsF+GUcmZXxpfo3FnhnCdPCx7+6VwPySYVIgrugnyuoPx7cOEOwnvrUdGAaG7nW6JAwya45gnfaDWauwoQVNxhAmE6sN8qt9MV6wFagwkcWGLPkQbhmM6bdUf0bcOzaMEnPdJrKZyKVECwJM7EVEafLg8TE2RmcLWxkR3fOwb9nrgIPV2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8TjyTpaFgrOEPwm4IjKbbrpdIt0FFXdhCw2+mYC2qc=;
 b=D0LSQKzoej+CvJYCM3eRbLDjR+CULHr+KqAfYWGUXOVhcOmTwchSLW6UhMVF8Lu71KMmszPb/l/m/XJAVAyrQkIPhlcSbPOCAwQDee/H2ENUxYshr8ih8uDPPzb3b5bGSYMt8Cwp/MMXGi3xyMvfwZzah2naC00nU+oacMzs0/e04lIBFgi97579MPFPvsoZtQTN5Gmd4oo1xMh04ZYtcKVClW6BLxOlbuXEBToU7fMqz5CbhalrhGH+Qx7IHwXb2bekeYMSduNK+HhgwTTc1yrKuMNGnyf2WoBoUecZPjDTwUXkvaxwmoHr9qucZQ+oqAc3gphSl3n0DIPtp3NmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8317.namprd11.prod.outlook.com (2603:10b6:806:38d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:23:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 07:23:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 5/9] iommu: Make iommu_group_do_dma_first_attach() simpler
Thread-Topic: [PATCH 5/9] iommu: Make iommu_group_do_dma_first_attach()
 simpler
Thread-Index: AQHZXC7c63PRX/wX+kyh/W9RVC7wiq8JicsQ
Date: Fri, 24 Mar 2023 07:23:30 +0000
Message-ID: <BN9PR11MB52766008E93EA1CBEFCE5DF78C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <5-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <5-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8317:EE_
x-ms-office365-filtering-correlation-id: fea165cf-f9c8-4fa2-005d-08db2c38ab7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oo6O2gjw2P02+2BuNZgEPNDchXqy0FciGpqI7UQGyDK0odOy60g5fXLZcmqQIl1diu0WWVs71bGpva0bVXJ1VLYFoSPh2FTMEq2Nhdf4rLIl4VGGCLNe/qDOa36qjBWokvHExAQyHDhnZAwX5RhISdqaamM4CKn565lapiWAxXBnue3ZVyNzV1InidfoFSctVE96SV/2RVNEOniM3mBOKdrxUDtLmtCciz4q9jXpMjt7BHCnkgRKhkRvWYg8ubpmageK2fyQmHS0Nbfv7B/udm7jYTMDBNHM14/ZFYq8IkJngYsj6Md+O29RnJIVYZaKYpIZa2j98iGofEfyVL3U1AI9t/e/Ll0+7byTzvvmy1y3/Sv0M+fJIwB89tfGXDD+yhHEQJ0IGFbWb4zix8fLsV0c96AUNxwZHeV7LhYSToc2EPu/denzEwpNLseIIvrMzxZlMYMIpyhVhtDejGF9cGM5TjB4+4JJnv3GcnrC5DrCHrJdK3bm7xB/b4j8WUrenkPk7Q62JXF8UN9P2NieAUiLRLiRpTv8V2iTUFkZxmqdrYg5YkkILw31itnMJOR4Pc0mgB3SFm4hmi2jyKZtXEmS5rZmt4p65bzGtJ+Jid9hwQCsZZTm7dTCtFI6A+89rZ+F9Pkaat7nsDZk9ZKFDyM0kUYS2c/etS6EMqAV0dEkEGBrcqF+Oz0cbMFQB6AvvVi8JBhDGA7YuUVJHRcp7Ia8NTmzFAvhjUlPcVgD0pCHmI3pqp/W9wr0je/V2h9w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(33656002)(52536014)(8936002)(122000001)(41300700001)(66556008)(4326008)(66946007)(64756008)(66446008)(8676002)(66476007)(76116006)(316002)(478600001)(71200400001)(7696005)(54906003)(110136005)(4744005)(2906002)(5660300002)(82960400001)(86362001)(83380400001)(38070700005)(55016003)(186003)(38100700002)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oMGgrpPUTnbiYBqQnBwfOIMykyy0x7/nfBTcITQ4xNyAKY9byB3CIxLSNr4u?=
 =?us-ascii?Q?VnpQLO5bB+ZdcR1lxD3w2Rhnw9oCcGslY+cIjc2E/7VTg9x4/Jrwdk8Gjjpg?=
 =?us-ascii?Q?HiiEYetjLfNvZq9RMJ5klfiMRMpY5RASpSzE7aLjJF7RPu0hsk4mLrldl1FB?=
 =?us-ascii?Q?AGQ1w9cMu3ym0V6v2qNTgZGOq+pw4F1fYHR48vc9PTbtsmN12+iqxvTyPtHi?=
 =?us-ascii?Q?ozywzrW92RAPosTdFekJA2ajKBLGgkTULNw/u3e8c4EOnB7czZpjnrlSG/C8?=
 =?us-ascii?Q?b1CnKdjlyzYnAuqTy9ySMBn7jHRJbeph2V1JwvQa2Cbi3eUUFiOZoILIbHCH?=
 =?us-ascii?Q?yVmdQR8swqlgWo9PbhZmUxfuitbyLFyzVZGi+GGkSrYxacN9yAbLc8DAB3PT?=
 =?us-ascii?Q?ud9a0L8vby5eOwvBFR1fQBVHuTOyuhHjBQYQrqHBokfMjXZVvuhAsXSl4+bF?=
 =?us-ascii?Q?lQRXU+Hr2AeH2XsyRoUJpOdEhakUy19SB4uMMqQBxmp6zFAEl4xGtL5zF5em?=
 =?us-ascii?Q?J0M7ULpZfmO0V3M7NstTiM5voFEUZgtTQBhLf5GRHxqvFJdMOG6hcz0N3E8s?=
 =?us-ascii?Q?j2kYU/YAO65Ay8M6J7JSMJ4dDs1vprTqj3DnUk6WWdpWrkaFlva3vT4bERHw?=
 =?us-ascii?Q?ThDB3lYdsyCGRbW0/K/w9zcGrmcxhQ9Gm4vVPeCQ86/aCXBwN6tSf0wsct7/?=
 =?us-ascii?Q?Lh5Q7ceX5uTTvpWz4KsHKXN5NLWujYjza3UsyyCgR+ePwF0jOCC7qYjDRcQ4?=
 =?us-ascii?Q?zZLCtsx7qCv2fQrDGxkV230B9L7yinyFS1pmMpynjbbiRmGlt1+pI74Atthv?=
 =?us-ascii?Q?WAvLxbR+JaPnX7LkqGcObb0Y9HVnqlzhhgxB2HIOcY/trfOTChjFIyvYE9cx?=
 =?us-ascii?Q?mOpk9oS3kHgET88vnV37DasQy8IYrZrDixR0JeI59vgTassZyGXdQXHusgrw?=
 =?us-ascii?Q?GtCCFzr+GFTH/beJ89iUeL5n9kh18wZDnCzG0ib7S8QV067bJIw9eiQVz9xx?=
 =?us-ascii?Q?XX+vFIuSb6c8FJIFbQ+c8unpbucOPzt1tN3j20h55la55lYnYddxfL5oLhVX?=
 =?us-ascii?Q?QXsO2qjROcsm1cCIFF2me43f0jy2AuxPh+7ld4DidE0SI/kGJxOzidRGYqVO?=
 =?us-ascii?Q?F/2L454Qm0l5PExof/9heDdfZgHQGpfWdfTTjPD8hFPCgAV88JIgVeOeY0eH?=
 =?us-ascii?Q?fjvmW0+DERBIW94XSCr6HjjvlrdETf5YwOQqcgSDhbcTLN/53s9bKhomHYqZ?=
 =?us-ascii?Q?5m7N+ZmHC5d8EJjTK86U5sh/EO5jHlnasRWdtzHIXVO2qnayPQGGBKrFI5kB?=
 =?us-ascii?Q?GUWf4ufo2Kt/viPW4cE6Ow3cr+agOXsfMEB3ffNOedbciXJifwnbw2hESTPY?=
 =?us-ascii?Q?A0bnuj9ACybzcqd5GYeXCyOk9a7CJQ+2s6BTag3zsd7JUHLFlSE8kFxuyb5N?=
 =?us-ascii?Q?0UN5GAMo2Q29sbxxebicVde/Fv/j/XfDMy/bMPOKUWnnqmT298Lg2/gsFfP/?=
 =?us-ascii?Q?4EfUgFt+ifWVlTQaAwiTo+I1SZZAs59FCi46jtF35uIW5qKBx6SmNXdC1Wdy?=
 =?us-ascii?Q?JczbIkVFktVyjf0VJeKbGRlYDxI0lwr4XktLGX3T?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fea165cf-f9c8-4fa2-005d-08db2c38ab7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:23:30.9918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3xbXNNCBeyZAzso4tk4CyYzrjUTIIbQ5kL4nIvFe6TmA3t28gRP5dKDoqU70GQCaFDGVy/0I8aBPaUESp4/ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8317
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:53 AM
>=20
> -static int iommu_group_do_dma_first_attach(struct device *dev, void *dat=
a)
> +static int iommu_group_do_dma_first_attach(struct iommu_group *group,
> struct device *dev)
>  {
> -	struct iommu_domain *domain =3D data;
> -
> -	lockdep_assert_held(&dev->iommu_group->mutex);
> -
> -	if (iommu_is_attach_deferred(dev)) {
> -		dev->iommu->attach_deferred =3D 1;
> -		return 0;
> -	}
> -
> -	return __iommu_attach_device(domain, dev);
> +	return __iommu_device_set_domain(
> +		group, dev, group->domain,
> +		group->owner ? 0 : IOMMU_SET_DOMAIN_WITH_DEFERRED);
>  }

This changes semantics in iommu_group_add_device().

Previously it always does deferred attach no matter whether the group
has been claimed.

While this change makes sense given deferred attach only applies to
default domain, it's worthy of an explanation or probably even made
into a separate patch.
