Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B72441AB8
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 14:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=har2g/cM4shOe2unwBA0K59nXiP74vDsOPOVFrNZrt2E3J3o7GsnRb8kE7yRLy3Wf+3XWGQ2Zv2v3M+f40jY+ZB4LTSxBxN6u2+3nBE+sygY6FIi2eu9v7YGG5W4wvs8eyyOTYzzQNzf8OvUU3VARZ/GTLZLoeP+kh9DxuTEbxVmuU4nVnZCs5E3/YtIHZ/Vbqv98zM6ZqRts/5z1EDtscvkCCzlCnR3Rvv6eBDQMmHgLuTqHjqkheHw99bZhnJwvwGdIXqSzU4iQSFeT/W/CljZMjriC2fJqUMct3JkvGAvZ+q4kb8DvWYo2zNLTEsy1G17YE9YUNitQl3CxfMuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdIhoD0CoVFaztpRk9Z6tA4KipsGaPkgCqXlUliMhkc=;
 b=O43ZFAbSLXI6E1FKOODOqxgqlncVxQF6WCronkLXqLSNzLL68Lz6NY6XuerWP+wu5WS91NpYi4PFOuPXCi9A7oBEpFMLb3CXeyuKtByI7LTxgO2OXpkpnkflTXRO4FOWdqYV3tph8N/DZz4WBJi1TB/+0Plle6iCQLAMuupoLgeC7mgTvI3uISRhoVawgo25KE1ELYZyISKTUglNF1BtPxgJjaTYzVyPZG6W/kzDiGOlWg0lojRR59gHNlKBk07XpKSJ2rIqlLRwYPBV7nxRb92F4WuXKvljaEqMkhpe0VxwaGnjI3WJ9jIMu0FcxFpY3Y5R3h/Pu/VSPCz7ks1mJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdIhoD0CoVFaztpRk9Z6tA4KipsGaPkgCqXlUliMhkc=;
 b=SjqtYD9QYfklUxxHtbVeUgLGGwhwzvhMPqMiHcM/a4btnV0bV0fd9snyB9nJsj3ckgDS1+DrvCh7O2F26F9R8FcIo0+HNNExhaRnstLYVl6YnBOyf0Op4R/UE56TtlCqWYHyKYRdH/+Q5FjCLZBy3ppfIc659gpqlSDFlXmpCyw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Thu, 28 Sep
 2023 14:52:42 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 14:52:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "joro@8bytes.org" <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "Hegde, Vasant"
	<Vasant.Hegde@amd.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, "Huang2, Wei"
	<Wei.Huang2@amd.com>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Topic: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Index:
 AQHZ7G6D8C15gDSmGUyI0hSW7LwfLrAlT/OwgAAC/YCAAA660IAAF7sAgAClRgCAAKDwgIAAA8wAgAABcQCABIDlAIAFGBAA
Date: Thu, 28 Sep 2023 14:52:42 +0000
Message-ID:
 <BL1PR12MB514488501F04049C08CB71DAF7C1A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <20230922115927.GI13733@nvidia.com>
 <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
 <20230922121812.GM13733@nvidia.com> <ZRFNIsHmKpNmmOc7@8bytes.org>
In-Reply-To: <ZRFNIsHmKpNmmOc7@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3d8d7f9e-af73-42f9-8dc9-b15e39093ca0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-28T14:51:59Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB8095:EE_
x-ms-office365-filtering-correlation-id: 7d05700b-686f-4d8f-be26-08dbc0329179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S3CCzvY8rCJBZQILJ+GakEPfP8htKN+onxx8wfdS7YRE6aWSjn/3GTpDQbRRNEGdrD2clN+4ZAEzJqeKoTwyPFqURcow1bWe7CSmfPKu92td8BhVfX7l+sfrrm4G0J0FAATZpz3oaaoUvKUHr2WZFCo9Yp2M+nThZldTsWUHK4b9gE5c+vaN918V4dteAtGr2WSHU7G0k5kc7twAXaBXcYaR7qdtQ85/2CUYnQ50bw8MHbBidQhHAIjy1lL7DbNdDUtrC3J/ShpZq2ZE9fTqPfUg+Ckd65vg1KCu3YC9gZedyq4wVYHwsnSUBKYy5frgLJR0nFjtWUYYhc+sjKvhv9qFzvrN4H+2y5/QA1lE6tIifSf1oR/I+2b+FlYZPe2J+JpdtWaulGS5Pi/bA8G9XJOLunkFmFYujBftOE4bA88n4AFAojAnFn4uP/EfE+fBOPi9uyjkRNWJz2s4DvV9mQn6wJ9SFtxEgv+GUBzaPaQivpAPkaYRAVeLKv5eaOpC/6W9lnc0F65miwhzxxXWt4AEye38gmuN3I6k8LFCd0zzrCVXafx4bCExrosdSyBrVnlGVfb5lI00of4H7K245zL52rmSZnFidORPpYR+314=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(9686003)(55016003)(6506007)(7696005)(122000001)(53546011)(26005)(5660300002)(4326008)(8676002)(8936002)(52536014)(86362001)(33656002)(2906002)(316002)(38100700002)(41300700001)(110136005)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(71200400001)(478600001)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BEz4vzKXi+uk51PcSDpqXKmIY5fS8Vi2tvInIHG06myjvuKiaILZrn9bOMmy?=
 =?us-ascii?Q?OQz54vpavs5/MxDx40SAeDkAUF08H60WCVc/of/8+F/ql9dAOc7kNdJuZnQz?=
 =?us-ascii?Q?8J8FQV+KGVeA62nSfMXJCkxZryaEU2KcEuAY3wXQ1Z+HIvgChBkU/wJrZ8V7?=
 =?us-ascii?Q?F3aYx/2oAY/LG776UVpa02M+H2J6W6rhjiEfxdJTrkeX10DUQg96SB4OqN5v?=
 =?us-ascii?Q?BUw344vv5EsUR+eS1L/g5p0uyEhzZRQyrFdJqH+mjUtWM5OjUQTBDuKFgjo0?=
 =?us-ascii?Q?sT0hLAl6sc36xahvuai8ffPYqnpjmehYE7x+s03EZissrLlNDwPpsOPvrDRk?=
 =?us-ascii?Q?bHoHkiLq8cr8kKt1E7CR4S1WIgSApzd3YbpQ5ytwz5lNufE8NYKISKJqtG64?=
 =?us-ascii?Q?TlBRtcgVihNvo1M5FeTqI8Wf/flu1HUf7E8+nYlO3nS62I2/2pzOuej4NgfR?=
 =?us-ascii?Q?zP2VPpTvzVTVeJpJ3YAjjNSBRNhdRnI1w05wpKoEz+SP2Wo1lKWHSaiERoPp?=
 =?us-ascii?Q?gxrBWfVahU6VFt3A2bunajrdMZzSHllbvrRt/a98dqqNp/Ke+Mc1A18bSg1y?=
 =?us-ascii?Q?bD+3bGYDkAn2ofNAJdFWkSZ52DyrOxiIArYxZBtJ0ORBitl4U5EYyfLurwts?=
 =?us-ascii?Q?cMdO1sti7FO22aavLbORRjdbw3frmUuw4O1zT1fMRVS2mEUi890hmVBPuXV9?=
 =?us-ascii?Q?Pv9ni3Ax/RQRb2UN8JbUDqoMYEpmfo2C1Z9L52TxU132+WajLBpckwsTKQe+?=
 =?us-ascii?Q?sVXQQJ1rLc+ONXtq6ebwJWg5+L2q6rA6MSD894eRw5EfH3TJppCX84G8TP35?=
 =?us-ascii?Q?UQxQ5tlrC5cPn1Hm9m374Cuf2XT7U6hnvgOMy6pBHZ6AW7OyKLErvxlM7YXd?=
 =?us-ascii?Q?CBypQNGEpTEK0EBuR0YsvYf5aGLuCT1d9CFXeIw0f1f4tY5N1jya1JFcq7NK?=
 =?us-ascii?Q?bEmd17ZqMqGsoYRnIZvsBzWoclMuHOm/8jE35ExWGk8sk6VDH/ZXEK0XeXaJ?=
 =?us-ascii?Q?5VIJr1n1083y7GK9CJoHtSatgI5mmI32LsQ9zcratlYXMN/vrlftQlcoISes?=
 =?us-ascii?Q?IPCOf0Fy2nKXhSn/5dL77Pd75IdOi+NQcssJCS/+nKN+gXZF3Cy/zDlCXFON?=
 =?us-ascii?Q?2bDJuXu9QV6LP4/iBJYINA3UN3F76ZbEAXHPfVV0Jh7g30gAKP9v8/fPqm/3?=
 =?us-ascii?Q?QkkMH2Qia9dzkepIg8n5NsIjCvsOUDqwTBaUav4pEFGNyQ7jzcpxDERSEauO?=
 =?us-ascii?Q?r9ChDsgy3oGKriZUX7jPRKGzAEFZoshpWbI9tciTM9cXsE20JI9TL12JMp8H?=
 =?us-ascii?Q?5H4X7k/ZEQk7Mrb+FPltKlwglOw3SwTZyuz/07c9rqiGvro4sy/3vlhC+NUb?=
 =?us-ascii?Q?8Ex0VfHxGMnb1guboVdwVmZS89mPFpex2I431243M72boXSuhRbgg8u5wsF5?=
 =?us-ascii?Q?r0LfPDBEYy/h/I7PJQFc9XqqHgMGnauLzPqsAW+45YufzAWfkGCx+YsSpBwW?=
 =?us-ascii?Q?66AaSdV07nepwgBAfbz4UraSzJGKDh1YLzpwojkGflVoDzJflCAos9sgmQqg?=
 =?us-ascii?Q?/nHafKmozxgopISPhF8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d05700b-686f-4d8f-be26-08dbc0329179
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 14:52:42.4177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UPMj11KPr2t6XoJFSgtfTj8M1IS4woitdHEkR6jkJG78PMzUYaiajZl1Gc4o8zz+g6nCUa7dS1nfTHvfI42CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095

[AMD Official Use Only - General]

> -----Original Message-----
> From: joro@8bytes.org <joro@8bytes.org>
> Sent: Monday, September 25, 2023 5:05 AM
> To: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Baolu Lu <baolu.lu@linux.intel.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Hegde, Vasant <Vasant.Hegde@amd.com>;
> iommu@lists.linux.dev; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; Huang2, Wei <Wei.Huang2@amd.com>;
> jsnitsel@redhat.com; Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
>
> On Fri, Sep 22, 2023 at 09:18:12AM -0300, Jason Gunthorpe wrote:
> > IMHO iommu drivers should not override this.
> >
> > I think it was a mistake that iommu drivers could override to identity
> > domains. If we need quirks then the core code should have the quirk
> > list, similar to how PCI works.
>
> Sounds reasonable, but if we transition over to an iommu core facility fo=
r
> quirks, we must do it in a way that does not cause temporary regressions =
for
> existing hardware.
>
> That being said, Alexander, can you please test this series for regressio=
ns on
> the older hardware to make sure nothing regresses there?
>

We've tested this and can confirm no regressions.

Alex

