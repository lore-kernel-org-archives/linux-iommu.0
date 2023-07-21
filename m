Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79451FA4;
	Fri, 21 Jul 2023 07:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689923503; x=1721459503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0B/mjO3U3XYHt+ipauqPny9b2hLE0stpx5IwRt7DDD4=;
  b=bY3Pp7amGSh/jqRjdPZxvj9filCm8MfozYsz1wLaOM9vx6h9ksxus97X
   hd08uoEbC/IF4uF19JlZ0IdnBg8uanV11WMvaLvGH7n9Zf3hr6MwsJKqp
   6/AuMVGt0IVxK24bF2d7hQ2fYWAqVzZdtRfxexAa75D6bmneGcQfFLX2c
   EWPrTcFOPdDsXrLpB3kSVxczwjgwn1omBJf/d93wFGC0fGl/MeqSkOuNz
   u8FFdRHLzfHi+b8NHdKzm3nNpMbAqjwp+UMgsf1CHDmUyZSD1qXQvDJyI
   cgJsMSETdwVZTpAkppKYU3iaZ3AUDsLe8GGl0Qt5pChs/aZ1QzxymvvxO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397844541"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="397844541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 00:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838444421"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838444421"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2023 00:11:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 00:11:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 00:11:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 00:11:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACWZ8QUWSJ7HmLGDA5EIamYdvkvbxh76llIrbtzkZwre+uu1qVduQlC+hPEDVyBEbCoeaoIrq5sc9Ik2b1nG3rmf+LGyZGJ8LMoBkgLScggIg6PZMaDULCVr3LYZ73bk0pVtPTUxTF/aB7ufViB/GiCiIunTLGHdA6nhLFXKzfK96aRzTEAwBxj5vRM+ip82fuAPYDeFr40KICQxU/ogYrQqxRkaJNriI4dL8qdxH7kxbldt6NJKfIcdGn9+3vMvnN54r9zKI3MDseoT1+PPzYC+D60B0sD0eipQzafWN+L5sJG5Da9CcbDtqKdbwpf/lqbxsJliX2llxqfG6ol4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQXAX3OTeQmBgt1tgkcnsfxLxZeu2g4+JD8SkXZF6hU=;
 b=J5l0GP1Y8EhIVP79MT3HIqGnhyYca5/agtWFzvMrzIajCkhJhM1zl4O7GkpezAuIFZ/cM4oz5jvnPWRSdEaIY34MdB1vR4gZiR5TX4+KslgBDupZKE0iPnQY32HWKaynbHDk5ieGmfia+iXwr4Hi1ho6Tx5hZ+lr+C6djjOPnCUBYD4jWn0dv7ph3JJQVHHx21DoCkk9uHKW6bxTnDLCP1WYLxfjaUesi0oTJrTFK5dbAUyhQINwXDpAqsa3pJNZvdCcrmLovlxFCgvFQpIvvRt/O/I7pv6YAP6sdjTrhENR1imIXBYka26Eveapf3TxgDYQo5L7O3qinuQeizMs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 07:10:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 07:10:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Lu Baolu <baolu.lu@linux.intel.com>, "David
 Woodhouse" <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, Orson Zhai <orsonzhai@gmail.com>, Robin Murphy
	<robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai
	<wens@csie.org>, Will Deacon <will@kernel.org>, Chunyan Zhang
	<zhang.lyra@gmail.com>
CC: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH 01/10] iommu: Remove useless group refcounting
Thread-Topic: [PATCH 01/10] iommu: Remove useless group refcounting
Thread-Index: AQHZuar/8ffxdhgup0+jp6oCKhjoRa/D0M0A
Date: Fri, 21 Jul 2023 07:10:57 +0000
Message-ID: <BN9PR11MB5276130E7AE8B0BEA43FCC6C8C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <1-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <1-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4969:EE_
x-ms-office365-filtering-correlation-id: 1b887036-35b4-4030-eca8-08db89b9a16a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ST670KN4Rzv+AqTB6V+NL5I9rq2PzKvE3dh17qLInTCT3ji6m92VCyJ3AHZ2kJbrLMDtuuipi8Old7TlA7dFQfgrsj6KLI2Z3MdJMzIeStZ9gVig+NG0kkQe4TbUQl57L+VqNcPLqYiQHu3cS6HfL81hvfRc25dw7D9vtvXrE1WyongKpsCbljV7uYoGCbaZDDgGxqefaUh1mIpEFxpMW+VGhV/kl7TGq+BXP6CuFNd8rCUJwZ1LPSFkDvgFMkPi6G0fBJvUUKf9evFjy65rXJ9s0J8cpLIoKzZz1n+ZfLHi6KUumnu9nKpu24dEZp2RRV9SEDuNT6KB+F2Wf/I0LrWVB0VMT46DZedLrBVznYATO+Mi8NCY5SiuLh0tEH23BmOt3xZHqHzbxlCDAVa5Dm+TMR+iWQoecYmeG94lbequHjlOnur5GTnl7qtlPJEr1OElytLGKhGrAfOxO8/Dl5AGH7fyZMKW9KPeT8nQvk/b1lGwt1R+dcQdmKBCS3gyhf2dwOxV13YlY2pvAT3G4KUqNa+88/yQBbXNmm+29DohLlthMIkEjSX18xietfuVJzkZn4hq9Qu7oUM7SLzxAYQTM+ENiJTdCAXhYPpBwd4UCW4MFB+dchio5yDmM2UbdNlzWjjb4iEnBY4vA3KPEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(7416002)(82960400001)(8676002)(52536014)(5660300002)(38100700002)(38070700005)(316002)(66446008)(66556008)(4326008)(64756008)(66476007)(66946007)(122000001)(76116006)(83380400001)(4744005)(8936002)(2906002)(33656002)(41300700001)(478600001)(9686003)(7696005)(55016003)(71200400001)(26005)(6506007)(110136005)(186003)(921005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k9CN8/NOWHdZsSD0nTBmz08SvSHSqJju1qekqDzlokioEem1Qci8ZOe93EL7?=
 =?us-ascii?Q?3D1wUMcWiFot28PZstTRAAUltvMMDyVeTreQWlvHtnWCQ76acD4dGzokPY2p?=
 =?us-ascii?Q?NLyc58y1myvjvQb6JFj9sJBGHanaBbYz1WM5+g7A4dOyUzHq2dRzj61ixDz1?=
 =?us-ascii?Q?JxETMR7Ly3E3kpOl7Jg0v8G0ksMVr+wmrvVpRg3iPvYHoW84IUqCL4PT8Nyx?=
 =?us-ascii?Q?5tcpPPfTEB9V5c/Llzduo+0Oqo+BYxeEXaIe0+BX/+fxZ/RH+e+rLYkbDZq2?=
 =?us-ascii?Q?cNqP/g/GUiUPtzkSJ0zdz+HAPiddiNDRoL6ZONtBFscuOLVwBSn+ri0xxRZ/?=
 =?us-ascii?Q?Nl28lDcQRAEvwr1tOusuZLqUN/mJ+BLWJjUjop3xmMQ2+ilu7b5oN2AVstuc?=
 =?us-ascii?Q?dEQk6/0o8UoAmeWkeak3yE75bij/EP8G9/sm/uWyzAW4W66BWl6RrjKuw76E?=
 =?us-ascii?Q?1M+jmbaKHx18KoZk3oOn7wVZeiumLH/9SkJdugfQfOslnS/jqL2+wikTqQyv?=
 =?us-ascii?Q?OZBqQfH14bH0zVC2RMqyNuz9FpEYel2HFYxzrvzTaHxL5jLu8lK3GoMYO0KG?=
 =?us-ascii?Q?N5lGtF6J0ekX4DLd5HnagKG+3laDfg8Kfg13fyvqLFadjoERmAlwLBrms3yQ?=
 =?us-ascii?Q?E63i8Mpq1bBltmlVRyM2UzY+zHl4JiU7QiynKmYc/Ld02S7AjP+BtmE6Uati?=
 =?us-ascii?Q?/YIZ4pPE/ubjsb5XeM0IDmwG1jnWlOdJYSFseSE9NzNx4PSj3AIRDgHsGFQe?=
 =?us-ascii?Q?IMGPZFvIZrPXAQaQh9hWGHfEs2EkfK9SYT+cVLrPsRLF7LTTpN6pbG8O/GQQ?=
 =?us-ascii?Q?xunNuvqOlQLsi99qdlkJe6pAqKHDY7Sl9o6OCvBR19FNFmoySWDL0kSmT6YU?=
 =?us-ascii?Q?wuJnLMwaCzeZ663Xej34O0PDwBlhGwTn5msEw0VVDBiPM4k75OS4hM1XXdxr?=
 =?us-ascii?Q?d/M5vIi2lhTBhQMDUIHz9t7EH4Hlb1qxEQ5cXaUIPqYhetk+qsvT25u/IO+W?=
 =?us-ascii?Q?pwYJHYkr4BL1LKtlLvhYjMOWHl5c3VFwUILkGh37/exK18pxQNKZDxfQhbO/?=
 =?us-ascii?Q?vVNRb6rdbPYHvCxdOyqi2gCy1F5s1m3tiUa6uuCvAZY/t4Zp1qQr+hRHwuO1?=
 =?us-ascii?Q?cNqT+58ztQ51RaITckD7xPcM1PQWeQ1SKh/uabTGvItM1BzWJKyau3FCn3Ig?=
 =?us-ascii?Q?OFQ4d7G3N/gkX7TTOzNBNwg27J8J4/FzyzB7Mdt6DXYMuFsd7Zj1QzGQxbKt?=
 =?us-ascii?Q?O3/Q6ibCwDoq3YT4MohxQs33O0ppzCA0zFzy6Yx+yT01lPCDn9CJUzRfsltj?=
 =?us-ascii?Q?0HwZxZti6JS6676FzpX/ILtY2SKJYX4NzMo9cDOXIN1A2QkcMrQs9Gm8pt66?=
 =?us-ascii?Q?afLjKnjydihYH1AL2Gq8pZ27t1Hu6jvPoUTySe0Ew9y38l/aGeR1NODBoaHM?=
 =?us-ascii?Q?KzJuPEH0tySvE3x9kN/4h6CfVCDdrP1hBTzccHshygYW82ih3V9AYc1flLOa?=
 =?us-ascii?Q?qPBIZcgvNQ1kOtBCtdzLhPp+FB37JkmQAk+qV69Thp1M1UCUPlTX5WvFooj1?=
 =?us-ascii?Q?Tk9ywyFCQDmfILKQQDkIgi9F5rg8Y+wf2AEyUTw6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b887036-35b4-4030-eca8-08db89b9a16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 07:10:57.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lo3j+yfRFu+jqa+hlFOJtJCYJ0qNjakVW7VW7gq3AtmPYKhj/kSi9pcrB/KcfNFWMmCM5V/h4JneaE+dkutTNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, July 19, 2023 3:06 AM
>
>  int iommu_device_use_default_domain(struct device *dev)
>  {
> -	struct iommu_group *group =3D iommu_group_get(dev);
> +	/* Caller must be a probed driver on dev */
> +	struct iommu_group *group =3D dev->iommu_group;
>  	int ret =3D 0;

this is called in the probing path by .dma_configure().

the driver hasn't been probed yet hence the rationale to not
refcount is due to device_lock() instead?
