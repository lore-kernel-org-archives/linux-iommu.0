Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AC3CA4B8
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420919; cv=fail; b=nkP4b+Hx0xnokUXyFh5X+rqinr8lOahZkCSLLD3TnVBRxXydzBOStLi+qQu+5oAiMGj+XGp/JZXtpyQoJhOvoDIlGdrEDESwwZSvJfMBQLUvlMDvf5QXWUYM9DBqxafSJyt5PQ+ofBg53xcLWfTB7VAeO8Z4Sr5BEpOrnMfQ2Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420919; c=relaxed/simple;
	bh=GjSanEnzm81q0hbAkHkOXWriM4Agc9zK4idwzTZnppU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FGphjJaR6ZVBdM51+e40izhtn1tDhH7xrkG9TTgfYAQ1ICrq3CBTf0uJEYbvepWow274rRrUaq7jvfyRg6+QIHiJaSMi9KqIe0djr/YJTFL/jQIeYi/WBQZz+tscKpXJt0KaaPt50ol2dK1rmTQ6U1TCN29BiVn+y9XbLkSK9Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qy2bhXir; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qy2bhXir"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJQKuVnlGk0slPQDhAAjmzLhbb37kK68hgBJtkvaR9FuzEz246FkUP1j2/ris1bzp5MJvH8yYJmn/KX68nU7+dUWRpwynVPuiUVbMWSbR0ueZZC81dT0KsI0D8RtjiP5Wa639g+BnFsoyqI6kzt1M4y834j4rE9Pt4kDPD74MMGXc7z2hAGzc7o/hcR2Cf0lp6qMES60MO88TC1zM+wzJtjkttuqyLshXyCpD5XERl6txFgb4KRuJVJwzOvYCjiBpKv8MPThDlos6/S4yr3lD65jV6IVGCsRHnLgs5d0IXfTza1B874bbZ0HSwVDaOD3KeN8IrNUGDzN6SgGwXXZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AMTYaZiokdpxuhwdaQhPj1nNurwZY0g3dJ3337AwJM=;
 b=bI07yJGIZ4BNaW+woeqj/837QTO4NoghaLo7CKoWZjQesDwOusHUdxEHzwIT7JCKS4kEUr5RtyUnyk+PoJDH/D/TBHIKTLCIID62u+gRgs7AJCsgyegeawD/xTj8WmaG8MWaEZk0y2ZPBResAT4bg+VzehJm/HtxFwJcsH1JHfyynYL8Lj3+NlbYMJCfQLwJdrmkfiKzJ4FY08tl6gr+7Nm87m5faa6u+jo6rwk72PEIjY2g13VFTg8aT1F/NhoT/TyKSj/qLNqVHYyqtHTEPmmZTRhsOBfvNhQsWWQqprCvfeZBZEKWz9Pp6rrLYGD8HIngHiuiEDUXmsOtEhppyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AMTYaZiokdpxuhwdaQhPj1nNurwZY0g3dJ3337AwJM=;
 b=Qy2bhXir7v5NWYN0C8T0O3C135gGiX2t654vdDp4Ob7Wzt542948jdHiR15FNV7yE3zJMdrtAfbWkzGmpHCMK1nPohM/9/FVL5IqF9Dnn0OfdYB52NEaDevdjNHJzmoD1QBKUCE5jDhBVJ+ZyUp9zxofScMeZtbtZAY50bijC/9LGkhJM0SYA39MwSCAtWFNJ24zyssdF2WEyJVnf+swtnHL1ZHtCXZk1bgR6qKEVBKcaAno9V0XkYOGtYZpR58wYt6lo7NRbWP3GHBOh9Q2fXUfhbUcQ3mDqHbN/6ki1mHJR3W3Pzr1zE7u0irT0yQ+LikfFPefqy8M7a8eCoBTyA==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 16:55:12 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 16:55:12 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH 1/2] iommu: Add device ATS not supported capability
Thread-Topic: [PATCH 1/2] iommu: Add device ATS not supported capability
Thread-Index: AQHcqx/9xdY8esoSikuycDYQSE7fLbWsvFOAgAAAUEA=
Date: Fri, 13 Mar 2026 16:55:12 +0000
Message-ID:
 <IA0PR12MB7555D3B5A88007C0EDA5FC51AB45A@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-2-skolothumtho@nvidia.com>
 <20260313164859.GF1704121@ziepe.ca>
In-Reply-To: <20260313164859.GF1704121@ziepe.ca>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|SN7PR12MB6864:EE_
x-ms-office365-filtering-correlation-id: 727bfbe8-0052-4ddc-6425-08de81214b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 KLBMD/uKAswVfzVa14Qi6Nu2L1fbRv/DMH0h3kxcAefQd7oxvchgLdx6G15hczpS0fIlgINdpLxhbjuKb7fAW0q/swDm7TA4ubwfPSjpzXTxD2QaqKMXIidpCgIgjFvHSVDwB5dzoC759skk/ikKvPMvZxORyjdfgFYabuZPK90YdfuuzMMBhdpKAbvrKWAK3yqKsPft0VJfv7UpO2WH/iA98SWkCT56xZFsPrQjiEg9X7HVUYEq7bJ8rWMVi14zsB7AlP1oY0kib1OKc/4Qbw2F0XySwTn/UpiRu0UANz37Nfrx8BSS7UvYHDNZnBVGZryAvXz2iLnZ5NN7nsJwngq3tNJaDFNFyAPn4G+hOeF/3O663IGJI421BpvkgDzgkvVXaF8+oECXSGFc+F3q4uMPaByJdUjEYhau8fCcijoVq9llOBZF5plcvqn9lu38lOAFUnxC95nHmxl7aIJbbhl3+mbcIYnsnDzgPYAO/6/7JfEFxBRCzK5BC6T5wHrEAitYuZVDYMQRYj8VOn7OzLHR0cye+TxkXVbjeBnI9keAe+3Kam3rZfCmGO67YV48+JuLuc8N3YFBcztMlacXaNX/e0djHP+UfGksXWqM2rIfwnAUHh985Ijw3jqp/fzWDgsJp2GaND1QV+M58G3PLNPxQ/2SHT/WZH0TRsFIAJyh4/+Dt92FTSzkr87AWrAzZNgMEKX8tvOsT026qX3IUS80PvsoFD71Bjfl+691cox98hYKpXoGIVq/DFNayAO7wrWrAkVPsTOaYvzJzFHcgL1eBLQtM0vRrdmMHO8pEPQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7555.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+TjUmZL7qHMO3Y3UijFvr7/oAlj67pyrTS5JK4ujq5O4r4+1kCBEL0rcdlkd?=
 =?us-ascii?Q?RBwPabRlf8TJ8UEcSCiNVWi7l0ooKURh4wAZun8pSzxvdLwHf1kFXO8tuLOV?=
 =?us-ascii?Q?TE1OR5myEc81ulWj8LV/NwzOLW2+TemYaobv/xptu/RLYvp9VyDPtRnwnYFy?=
 =?us-ascii?Q?dXIH3mtUofc0yYvl78rJjet5UKbPkpmhFezAHW7LTqVHliprwIZ9NQkHxIpj?=
 =?us-ascii?Q?qk2OZBcu42RuZvf7QTdIqQkVAJ6B8Wlcp0s+k/b3MDaxFqndNgh6wBw1WFQX?=
 =?us-ascii?Q?mXcVZgvpjdSeTFSD+T/xobfwqZHt/1l6vHAKMGgagsLUiBT9u9nM443bvg01?=
 =?us-ascii?Q?1WZK6Yjwj1j6+2cFivN8zeP4nGX7heVIvALUdOiOlgkRhLswo2AGjbZz3nO7?=
 =?us-ascii?Q?7Fod3qR58p/zu/+PCYuV+lQWey1mUBctuKDuTbHyAtyWwXRuOoRwYe/f6Eik?=
 =?us-ascii?Q?W+UjZvuoBULlDPr+mmJIpVFR0LxXl8ysZgBd13lpa9UOu2BRFsT3ggovNGx1?=
 =?us-ascii?Q?6XtY5up0IDWktnRWo7GAIm0rRQowXd/BkZHELQVg0fiAdDuJqrLvIU5I/dZc?=
 =?us-ascii?Q?22ywahqYNIRNN4IODp5UpKZw4icujQNVdd+blmUmlr9RFW6Lg7XoiHkTT00Q?=
 =?us-ascii?Q?Ce+rJd/dJbboF7Ojkehe31OIwkeO68JRYagsBkne+MZe3fI0VpVoTLtALzQP?=
 =?us-ascii?Q?fzquI08Bkd4IZSw+6ZR2sTBbb/B50kuxCccFNsbxO8ZXsle2Jhoi1lcZf0jf?=
 =?us-ascii?Q?IqVtLuuRxjmNwAi80vdBmGefVwvzKOBhAr1DGaK5YeldAugnCjxNlVsLyUKw?=
 =?us-ascii?Q?iwRUpD5FyqgIY39I9bjeJ4zqFQd/0BF7xCxoNRYc9Orpjh+8rNpTyvne6Nk8?=
 =?us-ascii?Q?aiGlzQtSzqRwoQrh6fGzJUpYpMpxFEjDylhaPMoPTffGVUxRV8Xrp+nskgpk?=
 =?us-ascii?Q?E0SQdQhWeoMbtARkCEh8FTVEsZEPB5kml/9LQK1hbzi00teoyKWXqYp/mAoG?=
 =?us-ascii?Q?MMpP5tGFxkWUZMKaUokhmrxcvvPtX9nOBOKHshdH56o4+YAeVbVA2EGB3b4b?=
 =?us-ascii?Q?y4g0MDXoKqyMaYaOlrmN1r1WANvt7oQBcTeixVyW142ZTScXpE+dd/ZM4A4M?=
 =?us-ascii?Q?ZyDXQzJOaVLfVvvedL2fVxxVYPd8uoPiARoPGMuBydVgniXDxMKgwksd+i1c?=
 =?us-ascii?Q?WFudeZR9evgXM5RiBcnTqIeGMbLlWfyTuoWsMQE2bTpurI2R8xAV4qwgJ+Hf?=
 =?us-ascii?Q?MXmIO6zzsxV1jshMXFtqzQ/bLYAy1aBonIVdqOptkmPnpWq80CmKuQ5eyv3t?=
 =?us-ascii?Q?4zeau0uprTQW6Njz9nC3uWdRAUnugmvntLVp1dwpLv/qhkdo0hPqs1iRGmTg?=
 =?us-ascii?Q?BL1/DioKm6TO7KCoYxy3JAZf9kRyuEM8w5HSHSmB7yyyUopQQ32wcAGL40rw?=
 =?us-ascii?Q?cW8rKlJokp636lPgYKN8npkVmJtdQE8fRthEJKKbzx48Hrd9bFxRIGQlJq+s?=
 =?us-ascii?Q?j+Eu6CZbFB5q5wGrfGktWDGmARuie+tRPw6H2jq8EoAH/Q5AEhyBPiQxBCM6?=
 =?us-ascii?Q?9fVvpwX6l7haVDcZhclgB5gECK3X+QrP8snq9rrBW52RfI1GyA+rgRlfXMmS?=
 =?us-ascii?Q?dxsGOw0/d+mpJrRcApJb9bgrMX9XLTbK46ieDvStUeCWWUjRbXt8gFE6YrM3?=
 =?us-ascii?Q?MWjHrtQukfFmYhKoGUb/rA2F92mSVLEF7jteytbcWF7fWR3JB32ylcpXxSHg?=
 =?us-ascii?Q?sx9fAXGzMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727bfbe8-0052-4ddc-6425-08de81214b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 16:55:12.5692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNPvWr2v2X/v1NZOclgDuZRnLwq4ct9SdKWfQeZZUwfsIxyWiqiJkSvVQi3a8Lwdp1CjXLNNqJVGnqC5l3cxLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: 13 March 2026 16:49
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; joro@8bytes.org;
> will@kernel.org; robin.murphy@arm.com; baolu.lu@linux.intel.com;
> kevin.tian@intel.com; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH 1/2] iommu: Add device ATS not supported capability
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, Mar 03, 2026 at 03:03:47PM +0000, Shameer Kolothum wrote:
> > @@ -271,6 +271,8 @@ enum iommu_cap {
> >        */
> >       IOMMU_CAP_DEFERRED_FLUSH,
> >       IOMMU_CAP_DIRTY_TRACKING,       /* IOMMU supports dirty tracking =
*/
> > +     /* ATS is not supported and not used on this device */
> > +     IOMMU_CAP_PCI_ATS_NOT_SUPPORTED,
>=20
> Actually, on second thought, the kdoc should have more details about what
> supported means.
>=20
> Does this mean ATS is available and could be turned on ?
>=20
> Or does it mean ATS is on *right now* ?
>=20
> The drivers should be changing ATS dynamically depending on what domain i=
s
> attached.
>=20
> I think the implementation follows the first option?

Yes. If we change it to IOMMU_CAP_PCI_ATS_SUPPORTED, it means ATS is
available and could be turned on. Will update.

Thanks,
Shameer

