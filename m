Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86E15AC
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 01:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657674782; x=1689210782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BplByZstKumKga2ZfznAdwUFVC6nNTDb7/J6Lkho4yw=;
  b=i8zaALZwg4WNL3IIPuuey/KANtiSnRlkhtUGUqssD5kgLlhx3FdDIB+g
   V/GJgbqHeZzEi+Es3X36ClVB808g6aR6NW9ikTHphCmdHNM9dqPskhmkg
   5GE4mU9AcuI64Hwqua+pwy7AlLac40AR87/S5VAB6dDt91gkl++dFjr5S
   x/g2XEcF3JR8WKui68l3wOUxU9199eIKvoMipm1lyAa6Zp2TrjR5JCPyz
   ZBl9jaFDgIm8tqKFmfBmNbfEJBygLTlrj8Rr7eWxcTfv3inGt06Z3VQvC
   +5EeqqXvToykVyeR+rZroGzsebPLGq4Y6MKj9Qp7cXOITN5YqWdLxHNn2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="310707777"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="310707777"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 18:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="599565565"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2022 18:13:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Jul 2022 18:13:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Jul 2022 18:13:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Jul 2022 18:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXQzk3ExjSHQ62MV0UEG+2b1r+WS8/tsFfv9Ilu6qevwgN2qtu0YcRl3uC1Udgjzi1LBsUfAxikgsuDp+K/3vtdmSYEZSAqTHmvurLCyjMN00eP0gGdT2EEr5c4P0U28FQUPl0WsypZ9cFggsjq5VAjaLXJ+FepLPryhQrC5E2WEgIpm6zXd6N1BggI0kZDJL34r55uK3rmtoY870WOasSydi2LHzrP9M29EgOtxrP13+XPANvp4waLnhqVPzXBuX5XY5MueXCrmSD8HCKgZHhDv0swmhgqhd+VxVRBy4D6cMc2zKZ7+ew9KPefuIIFNN8ZW3fF94cHEZiRpJgA0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GldZgdE4lD/PnWK/mxgb2ZLsegm4KS7MC6vHirYPY58=;
 b=Eg0+CK5t5/OSdYrKVTbwbYzFLkULgWT0UVs4Mbe6eDzIvPuR+HNa+Vd45JLBntp4eG1mKrnfi/BQjLfPamZixkITMuTJr+JFkpO3dzN2/2/EzBI9Wb6+f7lwH5xZWmwXvTiw/wlankfOI/Q6HsgEpMqM8hISnH/sUHLpg8+gqarBauPOpI4WZHb/aEMQn6+lU4Ijet2VCviApZxHakxIpEEDwzgslDxnxG2H3VA82o1gm/jG3owOk/zewzAMHrvPQ6ZXuhZR97crnmEEzzgnQDRiiI+IkCi6qyqUf3vlyEW7CBilRkMAgzREwu5031SiihELeNnf+Sw9zWQoWV3lJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5888.namprd11.prod.outlook.com (2603:10b6:510:137::11)
 by CY4PR1101MB2325.namprd11.prod.outlook.com (2603:10b6:903:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 01:12:59 +0000
Received: from PH7PR11MB5888.namprd11.prod.outlook.com
 ([fe80::b584:46b1:6ec8:8411]) by PH7PR11MB5888.namprd11.prod.outlook.com
 ([fe80::b584:46b1:6ec8:8411%7]) with mapi id 15.20.5417.025; Wed, 13 Jul 2022
 01:12:59 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH] iommu/virtio: Add map/unmap_pages() callbacks
 implementation
Thread-Topic: [PATCH] iommu/virtio: Add map/unmap_pages() callbacks
 implementation
Thread-Index: AQHYllF7axJCTQ8PNE62yOK0+dTYSK17fiuA
Date: Wed, 13 Jul 2022 01:12:59 +0000
Message-ID: <PH7PR11MB58883874C9183F8A74792D3D89899@PH7PR11MB5888.namprd11.prod.outlook.com>
References: <20220713001838.17298-1-tina.zhang@intel.com>
In-Reply-To: <20220713001838.17298-1-tina.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c833f4ea-6359-4a7e-4f93-08da646cd39e
x-ms-traffictypediagnostic: CY4PR1101MB2325:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCqfD6Nzw4ONPU5fX3XdP1VxArK5JSkfNOh4+TA3p1ZZkvkfvu/oDvpHeHyGDt1g9tFyDOa/aNuO0rmEljhaSzxVCCfUmlo2q4ps8rjJmb0CE/a4iImvP14JrVZL3G7O4A/geeafCNBCgncOE+p9VEZY8NsNURlqngiRIg8p0xlBMg32vYF47DO+q+ViZ6GLuzlcA+6RONwZxJv70M3FCZ4Do8fZ7J5QWusc2jHhMizGkn43xMs+KIP8e4VD//D3Sklmef9gJPNV/FippH75rFyMoMMcKyiNKqEdTcCD8IUG+pqcfuU1wMB56MkPw2rqsXmit30nMHXdt7twic5XgN6lN1ZzPImeh7ANHvDD1DHDnmFlSv96St4uLUQ4OIAz2KN6yPeQaDrjCSSPs1s7CCxrcgfZXBGvLfjxuZDxfRxIdgEOUKESewqMTkhi3xhZt1bUbDqQRUpgVU3zHAAXlzqh7edTmn2YkJjBLcDcaYP/x5j9doXe0Kw5xodffMiHiGh632I5X1qIfCJ9H0fHa5d3CeRZYuq4E6R1dUZEjEoj3yo/mpAhpjyH2hA0JcidlV3JA0UnHoKDDsf2N8ttHcmh2bQT2DcbWG3vfw5a3HpH9OMiXGN6Ub8E/QjOrGyYZIgGqrhOqVIJHPVuRWJEFStAsjWk6knzchCFAlJJ8GiLdSmBp+8qdyEXt3oLxxdZu5B0ZjvSsNS8N6KGonIjB5pVg0M5J1rFV7Uu7UraoTBOnp5ONHsbhgdlHduBTaZPGKjfdRGxPO9EYwbtE/0dKPyLuGP41QqRx+dgbtddDAIyBYEPgBDZ50DXNJIoBzGFPITbLlnJpDzKDeL8gdjaHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5888.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(366004)(39860400002)(396003)(66556008)(6916009)(41300700001)(71200400001)(55016003)(64756008)(478600001)(8676002)(54906003)(76116006)(2906002)(4326008)(66476007)(966005)(53546011)(7696005)(186003)(6506007)(86362001)(26005)(316002)(9686003)(66946007)(33656002)(82960400001)(66446008)(8936002)(38100700002)(83380400001)(5660300002)(122000001)(38070700005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RuULRUkQQZe144uj4Tj4abZkyIv26PUtvyWwLLNRKQ/Qx3XRIhOTnjf/PUvp?=
 =?us-ascii?Q?LVIf+14JbZvqjpYWgxQxCV5xvuY1RHXC3nanfepbW6jXOi2UVnFxk9XZIB5q?=
 =?us-ascii?Q?ONs4I+rqTci4aYy/vvwN6B97Q5SuE/AfOma+8iglMmH9jmUaUWf6oiKdsa8R?=
 =?us-ascii?Q?vcrY2MgDyj6Or1foYuIM28d4MPzDZwLKuaCzgpyW9YsjnXFHJdH1k60TcPhh?=
 =?us-ascii?Q?b3p8zDYaeCeWnWcP4NoWGm60C+P9x7hY3iLO9NzTmY7I/pHVCxEGFcwjJ0Vy?=
 =?us-ascii?Q?eeoCpsLjNmQ3uvOfZadpyHtAKjsiISHZoX9NMfypX6Yx/DN18/B+XF7n0fty?=
 =?us-ascii?Q?SA55mjFDwGIKtnxe+Tc1TUv3hSrFn5oaauFkXRRBLM1AwphLS2VA9BV7bZgJ?=
 =?us-ascii?Q?99aGZfwqLdYclqbw3sjz8ZoHI2Cti0T7HqM5yGPr/wh6z8Jio+h3JjXtPm8G?=
 =?us-ascii?Q?xq+Uxyyy473jZkTxpg8hPuQQc3ikDaLNLkY0p3p1G6keFFUxiu3ZE2QJklj+?=
 =?us-ascii?Q?CteqQ7QhWZrQE/Gd7mi0xVOevErAhmeQStnajgo50dfGteaMmUaWu1dOJu/K?=
 =?us-ascii?Q?oM/DuC+JUowJBXWLE9ignIn/4OgYdbphZNekHTwEXFtAwNY+cjNBZaEMSAAx?=
 =?us-ascii?Q?h6I7F2jbu64wmcUu4yITpvfTVEEFia5nPHVBJ6UD67byCsvGdq8YPTtlEUXm?=
 =?us-ascii?Q?H0NZFlnTMiIqTiY4MUPPK84QuygVYniIAmcv2pWWbIM8DLUeeAg5wehCCmNT?=
 =?us-ascii?Q?7gATeQHggeKUOrIweK4+a1aUclXROPLSFryNgzISvlqDy1z4tu2YQLr1ttHL?=
 =?us-ascii?Q?rVzEOQg9SE2jprWDPk5VgNO6LWLar6uEM+Jv4/WDsypYMHlLjtVK3SNEUmeu?=
 =?us-ascii?Q?bENkxDYZuomFTykg9SnWIYFyRcCSbJINgjM/a8I7w7frVm8z06VxypVN0yqf?=
 =?us-ascii?Q?a5mdv4K64ssLhscR4HWooXJibyhAUNI4fvfLcVZnCl31SZQzk1JicNWoISQS?=
 =?us-ascii?Q?AwQ34J6mY6gs7Hfu6q0ZS3y+aP41f3fc5obNd+lbjADAdCtsQPJvEesm6CgT?=
 =?us-ascii?Q?BqgsLK3EymBOhfCcY76uiwu0snXkg/3cXAFrXtup2AtsVTerrII/wXrJxpDQ?=
 =?us-ascii?Q?ZELwrFJWXGxNBMyGTdbVdAfLKPDZWz2hNwqZBzRLuCeXgcV9w0x0VHeB5by0?=
 =?us-ascii?Q?CZjyhvAUp1RqCYaFwFnguTSU/iV2Hv4YljGitw66tvpIf72g1YZjVqL14cs6?=
 =?us-ascii?Q?Wv8crr6+6Gi7zeju5C2clvfqGEfJIRWl5++5hQGeAbVlNRaC9xYxOkyShjfG?=
 =?us-ascii?Q?IVph6bgOUDClY8UMMzQnmmkoEdP2IYQyIl3UKps+P0AU1bInrjdMw1PYEk8F?=
 =?us-ascii?Q?TrU1bpGBP4xir3l1V4l1F5Pca9UZtUai21aG+gvFZjHTEmX8v156RltwnXhl?=
 =?us-ascii?Q?ozwjav9gvPMOintSfE03Tt485UaqIOSbyW+O5hCt3dgDPl2FAMlINAkOwdU3?=
 =?us-ascii?Q?PiqHBkkNDajFAsLR2wVwScRu8SmEHgRVOhyszBYbMJj17ws0pnSx/BGwv31J?=
 =?us-ascii?Q?zkvHHVvDzxCmHHTO1/8RoljACnAe6JmdhZ7IDZ28?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5888.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c833f4ea-6359-4a7e-4f93-08da646cd39e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 01:12:59.5803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afLLocAa2abG1QMWWhlyrmotW8imwCPCX2uOe88BxcOlL54WpKwoUmjKbfyb88teCpIowvhFZtUHrAQlpOLRJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2325
X-OriginatorOrg: intel.com

The RFC version of this patch is here: https://lore.kernel.org/all/20220412=
000322.285601-1-user@RLCP/

Thanks Jean for sharing those good comments which are updated in this versi=
on.

Regards,
-Tina

> -----Original Message-----
> From: Zhang, Tina <tina.zhang@intel.com>
> Sent: Wednesday, July 13, 2022 8:19 AM
> To: iommu@lists.linux.dev
> Cc: joro@8bytes.org; will@kernel.org; Tian, Kevin <kevin.tian@intel.com>;
> jean-philippe@linaro.org; baolu.lu@linux.intel.com; Zhang, Tina
> <tina.zhang@intel.com>
> Subject: [PATCH] iommu/virtio: Add map/unmap_pages() callbacks
> implementation
>=20
> Map/unmap_pags() allows map and unmap multiple pages of the same size
> in one call, which can improve performance by reducing the numbers of
> vmexits. With map/unmap_pages() implemented, the prior map/unmap()
> callbacks are deprecated.
>=20
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/virtio-iommu.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 25be4b822aa0..d1626e3de7f8 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -788,11 +788,13 @@ static int viommu_attach_dev(struct
> iommu_domain *domain, struct device *dev)
>  	return 0;
>  }
>=20
> -static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> -		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +static int viommu_map_pages(struct iommu_domain *domain, unsigned
> long iova,
> +			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			    int prot, gfp_t gfp, size_t *mapped)
>  {
>  	int ret;
>  	u32 flags;
> +	size_t size =3D pgsize * pgcount;
>  	u64 end =3D iova + size - 1;
>  	struct virtio_iommu_req_map map;
>  	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> @@ -823,17 +825,21 @@ static int viommu_map(struct iommu_domain
> *domain, unsigned long iova,
>  	ret =3D viommu_send_req_sync(vdomain->viommu, &map,
> sizeof(map));
>  	if (ret)
>  		viommu_del_mappings(vdomain, iova, end);
> +	else if (!ret && mapped)
> +		*mapped =3D size;
>=20
>  	return ret;
>  }
>=20
> -static size_t viommu_unmap(struct iommu_domain *domain, unsigned long
> iova,
> -			   size_t size, struct iommu_iotlb_gather *gather)
> +static size_t viommu_unmap_pages(struct iommu_domain *domain,
> unsigned long iova,
> +				 size_t pgsize, size_t pgcount,
> +				 struct iommu_iotlb_gather *gather)
>  {
>  	int ret =3D 0;
>  	size_t unmapped;
>  	struct virtio_iommu_req_unmap unmap;
>  	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> +	size_t size =3D pgsize * pgcount;
>=20
>  	unmapped =3D viommu_del_mappings(vdomain, iova, iova + size - 1);
>  	if (unmapped < size)
> @@ -1018,8 +1024,8 @@ static struct iommu_ops viommu_ops =3D {
>  	.owner			=3D THIS_MODULE,
>  	.default_domain_ops =3D &(const struct iommu_domain_ops) {
>  		.attach_dev		=3D viommu_attach_dev,
> -		.map			=3D viommu_map,
> -		.unmap			=3D viommu_unmap,
> +		.map_pages		=3D viommu_map_pages,
> +		.unmap_pages		=3D viommu_unmap_pages,
>  		.iova_to_phys		=3D viommu_iova_to_phys,
>  		.iotlb_sync		=3D viommu_iotlb_sync,
>  		.free			=3D viommu_domain_free,
> --
> 2.34.1

