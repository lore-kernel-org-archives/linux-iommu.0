Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60A6FC7
	for <iommu@lists.linux.dev>; Wed, 26 Apr 2023 21:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCoMdC9GhkXImNZ5Q8NM8nSl1Bf+buvIE+5knwSI+PX0iQuyowQUSIF/dwK+eeGlNrHkxKgW/a7U5aHprut1r3T+iv/a7oKkMjL91dBN+Fjh3EkDnO2NF41CoINC6NTFvn0uL3Gn+telIhAqomnVdXzS+W2wKMNMnzu98AQaSHa9FhWtSRgmUrEDRFkU/yIJmQbTFE68w441K53VU7MuvFsRgAdWY9mIwKbjEmZtHclJx611Za3VJEu84kDEdXXpcDRBZxw8Wq6qSQ6ZHHT6+RtO1dAGETVOxm8FbXR/BcbEXP00Xr6ViA001wJQTvXAvy6HrXmPWc4GFS53o3ShlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnS8f2LU3R33hXZ3Zx7TZ04TjJj/1y82dkRDXSPk/B4=;
 b=jOq/8si0cHETBMQA14FsFIM2O968Tl9NMVKtQ9r9rJ0aOnhhtN76TgYgGP2lanLqEvoCSeyomzDmNhbnt7AdKCwdiu7gclcXnPEB/R73aXt1x/NfmAyRYBE6GEGslh//XOGn/xPzNFke7S6VPi626Tv2jlhwR4dSptaeD+gSUYMPjP/lWjO9iEIP0oH8M9pck+tm/5ZS+W0gdGm94Yd91GbhqgUH60DDxMYUfajeAYMga+PWPnKnm1JLJFvMp/avOC8eOMLpBjSJVVgXB4x3mQlnsZJ80MVEWldfb06jweWg5K5LeYX5FmKJ5IqmHmkMc8p72x4unFZeLHjbPnRFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnS8f2LU3R33hXZ3Zx7TZ04TjJj/1y82dkRDXSPk/B4=;
 b=RS//UCDFF0fbSzPvGJK9OU8yiXZ+V0JLOTQiFeEnM3RQaODyuNAVYinfP/hLGQDT9zJfPQxri0Ngg3+pD9vkS0DQ6JGL9LfoT9X9kswrIVU9zGYqkjwWNYFaHHn0dfG78aCONu4mPIDaKCIi3knvqKHM3mI8excGrE8pJq06Nhk=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB6892.namprd05.prod.outlook.com (2603:10b6:5:1d9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 21:04:43 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0%7]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 21:04:43 +0000
From: Nadav Amit <namit@vmware.com>
To: Jon Pan-Doh <pandoh@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sudheer
 Dantuluri <dantuluris@google.com>, Gary Zibrat <gzibrat@google.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Thread-Topic: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Thread-Index: AQHZeH5MzL7QCyjHEUuk1s9n/e4s+68+FGgA
Date: Wed, 26 Apr 2023 21:04:43 +0000
Message-ID: <7F4D224A-A6A0-46BF-B008-A9E488257639@vmware.com>
References: <20230426203256.237116-1-pandoh@google.com>
In-Reply-To: <20230426203256.237116-1-pandoh@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|DM6PR05MB6892:EE_
x-ms-office365-filtering-correlation-id: 6f07fedf-e4a3-4be0-fa3e-08db4699dba1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TFJlaRiNqSXlLH/ZuC8j24J4nwcrgRlWnuRs7MLr9UaJ+VIQ2Sf5lJvHO5E+r22LluETeawmZE2oz3zYXe7+YTnWKv23DdqzTtGkD16k5LincVHvWrnD8OGXIvbcSR48J8w5a2sX7tkeUiI9uLBqfSFSL2ld/S6gD3ej72xTa/9JHsZR4gEyVxM6eaZ897CLWHct6A3a+0BhwFMrIeKNMkc4wS5fhdfw9FjugXBjBQglRCepCGHWeB5jNKpRyR5mifkZBX1LjoO5tE2kubLJ+udzGpBe221Tt8RSWXElHGy21uGAG8mw7SfYsqQUBDsOjhoMCKn+NgmwPZtNELIPS6gImt7c3/gJ/8blLmTfBaJ/ZzuSwXq2H06nvYk+8czCqTNN/ngmssDxnjimsQCed5Jl/V2fQvWOFy9fgXlNIGEejhd+3t73/7T/m3sr2opSGzrj/VVSKN86rCA1J3/Kui03C2cKoQ7932aUw9RIIm1t3ZzKErYkk6/hfn1z8aUi0koEr1OezvBVQGtpGzIK1hJWzeVKPcSi3Y1t6JErplx/LQbc/u65XuHvFvg0poR/Quywl0lrJj4HXnH3W0uRJrfsDenB4GYSqXsx7TibaxqNjo/F7k236KNVEZuDYnaIfcC2ob04kJjWO1B3O+TiyQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(186003)(316002)(4326008)(6916009)(76116006)(66556008)(66476007)(66446008)(66946007)(64756008)(54906003)(6486002)(71200400001)(33656002)(86362001)(478600001)(36756003)(6512007)(53546011)(6506007)(26005)(5660300002)(2616005)(41300700001)(122000001)(2906002)(4744005)(38100700002)(38070700005)(83380400001)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9PGG2I8HXn/4x2gyqGq5a+9Igz5Wn+IfyBRUVHqaiSZxWvy0XxBR1Vk/fLZ9?=
 =?us-ascii?Q?hS0pxF4NHiDE9yCSj+OaJPy2YK4eWCYW04gcvpDD+IgljMMVku9C9sfyEac+?=
 =?us-ascii?Q?sc9nIhnl6de0T4oswBRaUyvyOd/BszJKbFmMTzjdCIyEAl7N6hNxXgs0rcSl?=
 =?us-ascii?Q?xPluoqbUrVTh7l3ehzcXd+cOGjgLUpXa5k07yEWmlUz20C2isQxwTPSYWnVV?=
 =?us-ascii?Q?0srmyqSGm4Edyj0y4KmX409eNr/EYrIw4R9jCL5y0mmYjzUer8n93DI5oOr3?=
 =?us-ascii?Q?VSycq7Wwk8gL4CKX/LhwAScpOdqO73Dnxutx/Gk9FwVlNJlq5uAOshMTdDut?=
 =?us-ascii?Q?sWc8pK4BA4w53ukQkCRaEubSWS8YrU2uXY248c9tvoEgjbNZyUBKO9j1SP2s?=
 =?us-ascii?Q?dMQSnqA2K3W0uQmlnrRsgUaNjZDYySlhEh0rcsHH9ltGTKj/7sNfyRoaXUs+?=
 =?us-ascii?Q?aE8uFGn5MXvifCXTMXqOfrZ5VuFNiLRpBYsDKo6sf59GxtxC9PUyH9Rk6JVl?=
 =?us-ascii?Q?KgwL9bdFclK4i20SZbdhYPYKlcBMV5L+C0W24/eqey59HMCYKxpNcojD+30j?=
 =?us-ascii?Q?89ysI9NSoFy8UqoCgm7YiemE5arC4DalxtNhIac8X+k6YDkXPdHdk1mJ9QmB?=
 =?us-ascii?Q?frmbc0mmQJU6Mfe00C/U1Let9MT0d+9d7aDbH/D+NScBwURGIiynfu9MGy/t?=
 =?us-ascii?Q?1hEGfu5brYzF7r0OranmxyRR/Mgjy+IrrY0D7HgBoVGHV4BDpMHgHKEW1hid?=
 =?us-ascii?Q?9BYisq4jdfCU38MCmCjVm9fbZICvKtbTIK3DNlXVjJswH5+aD4E+K6uDb8Lq?=
 =?us-ascii?Q?MaUvvRvXt5L8UpW8C5EkijxmQSaWPzwGvGfjrocFOVmfdbHLanRl+Rgd1RYs?=
 =?us-ascii?Q?HqCbtfAjULJa5PuyLIrhgAnWxn31SQ69XTU8h5ogAQ/h2VgBL+Fj7dyr1a1r?=
 =?us-ascii?Q?dz3kgPxCNK4KHF8e5yw9qLtyFLV21vq1EgCbUNf7sovVKZiupKOO0eWwHetZ?=
 =?us-ascii?Q?qrZIZE7o8xX658TkhOKKmImlT69RtNCMQm+COPSafaWdUbLRFWWiqcRQ3iS9?=
 =?us-ascii?Q?FTowiVGhLu+jCP3ul5h60BuEBeTtCPQrzEZ2llVc07nMejkOeTIxneqLI6Lv?=
 =?us-ascii?Q?/axnU/7dZ27+duPGMxqqo90UoQQNrOlQvM3705iUpBmFcItNckIMKBpxg58T?=
 =?us-ascii?Q?EmGWFI7nJrbM5yw+bOpUS+KPM8eebEwiCJqGMPueBYH9zhjBeXZv3dWkNdtO?=
 =?us-ascii?Q?nD8VojCvMyvS2UEtCGEkN/UKKu3gF7NsmCAa9lp1bTak8vcZbYlmYU3dtH1q?=
 =?us-ascii?Q?nOHVnN+IDjBre13BfGrDiD8DScNySpUGGbtMdUE5ntzjnvf9zmQGedZZlB63?=
 =?us-ascii?Q?vJ8XmyRK8eRSvRyfByEganydIHd4wXdb4T3d0+AWIKEe9hgjxt//io9rC6Y7?=
 =?us-ascii?Q?K3G56GDKOIV1STlgfk+90ccZbnzWEnJ5180EN2bsVQTdPfwcdAzLb/m86nMi?=
 =?us-ascii?Q?C6y+z1umVxL7D/GlsHA2xDUrB+zRwn7hC8+/wHCbzPgttai13Vr60gdo3aia?=
 =?us-ascii?Q?roE+MzfiJjAOr+2B/hjzknc/v5ii1FSOpcBGl6zE?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <088F9F19E337E14FA46A2C3093645D4E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f07fedf-e4a3-4be0-fa3e-08db4699dba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 21:04:43.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTsLtIcGs2X734v3Gi58ftLBjOTcA7L62vuChbGOZegYbNRkxGhRMLuntL1A9Vb5On+7JWX5NDUWxXRTfYJnnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6892



> On Apr 26, 2023, at 1:32 PM, Jon Pan-Doh <pandoh@google.com> wrote:
>=20
> When running on an AMD vIOMMU, we observed multiple invalidations (of
> decreasing power of 2 aligned sizes) when unmapping a single page.
>=20
> Domain flush takes gather bounds (end-start) as size param. However,
> gather->end is defined as the last inclusive address (start + size - 1).
> This leads to an off by 1 error.
>=20
> With this patch, verified that 1 invalidation occurs when unmapping a
> single page.
>=20
> Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM=
")
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Tested-by: Sudheer Dantuluri <dantuluris@google.com>
> Suggested-by: Gary Zibrat <gzibrat@google.com>
>=20

Sorry for that.

Acked-by: Nadav Amit <namit@vmware.com>


