Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32044364EAD
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613113; cv=fail; b=rx049EWfEoQVxolkcjhp+1dLootdRD8RCYQD0GgmZEVlFSbcgBjMcetyEdC6uIm9vC7P481TqzIKgYmaPZbOgCo2jFKzx0yeU1S0pIeyjMlEr1SLhE6rrQi94lnGz/G6xnD1o05nYMlTSzJnb8JocyOyslordJeaF4LFwim6lck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613113; c=relaxed/simple;
	bh=Q3OtJK+ltXrIo6xX3nKQJ89bAp0RwqSjljqE/CjQdV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iaRkKCyqnGqmt3XX7cNQoCHywjovk1oIyAQC/u/3i2C58d5iC0Gs/ei79hb14YaXzbUg1AJ3X7f6nFwkqcjFsNoRIq98Xoy6Qas6XKpScjWXhS61YDxrqWGv3rETTe4AHx+5KQssEj9lVY/UV/+idq/x/llTJfeTbaV1+t3+nFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rEUZVhX7; arc=fail smtp.client-ip=52.101.46.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rEUZVhX7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DT16FXOzI1jrPTtRnKwCwpljF4Ohk3gLr1NAj+eWbzfvTqu8h+7okpqjz0EGrXWWX9JXI4fVH29WugoI24zbZ5Yu6ZRKci5Q9hmfS8vtU9iZyK7J1en6SWfgByhCX1zjozTMA8AQEJMFsgt0928UZO9HvVtixy0NEPvj/hbhVYgIbnVv7DMX3bIFhnEc09QCvJ4IVa+D2Ssap66LvgrZ6yqmX/5ZFLDsawaCb2ckgPtDVZ1RdgqPizcGckSvcYepModC+ZL6c5tyu8MsiTXNXgoSrrTbTgiX0siWnSv0v9w+AcDhNle7t7ysO28vq0c/sf6gwu8xkEu/JGA4b8FYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3OtJK+ltXrIo6xX3nKQJ89bAp0RwqSjljqE/CjQdV8=;
 b=FDit4ruBt0eYutc2h8zmBHCsd4gyk0U8MOKrbZkclYZnL8tET0GJpT9a8kxmmHa+RkUQVdSDsGRGseRvGis9rI7mjRhjv/+LP3S9qkcbR/gqhr2xz24SSNMZxXNuQXelOU87mCi87DszNmruWmh3pm4necz5wmenSkgQqcSn46nQB9C+xaDSigH3QFKSUfF/7RMQJLYSfYSUU1lLo/cTLvPaXFpEdDnrnG0oQjVQT8tqwus+wPKoUcuLsIPpI1Q3ad7vSXBGjZwVY1FWlsDlmf8G6XsskxQ76CatuOuVdzeL7pzSwSs3AeKEvdloEFw8BSbyNBsPDcnknWzxczVcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3OtJK+ltXrIo6xX3nKQJ89bAp0RwqSjljqE/CjQdV8=;
 b=rEUZVhX7PWaNPAMj/dkkmUAuCfCHjQOakloJ6Q/llOxMQiLkFDbeaI63kJgsrzsRyirMQhEqyUs1IszLveSSP36dQaPLA2JtNLi1AJRXkL9joA0pfwkGOFmeEj40g9MXNhjkBW18Dz4ZPFsDMr7uE80X2LwkQdsqsMZ/Oj4QwGHGe3yaP1TyuQ1oPApS0S/f22zY8otcyGGmXZeLAOZk09PUAnN37eGzD/zPD2j+LtnkwAKS0K20vsCUqOI++zFl9NOmqCwaZof1HDF0VKV4oW4ggoTaVJ33z1zGcszKydSXu1hOaZn3rkHqDyJKfhB8ouNCkAqhT8LmlaeMUMDTsg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Wed, 4 Mar
 2026 08:31:47 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 08:31:47 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH 1/2] iommu: Add device ATS not supported capability
Thread-Topic: [PATCH 1/2] iommu: Add device ATS not supported capability
Thread-Index: AQHcqx/9xdY8esoSikuycDYQSE7fLbWdZ94AgAAMy4CAAJc4IA==
Date: Wed, 4 Mar 2026 08:31:47 +0000
Message-ID:
 <CH3PR12MB7548C571DE9BCE992E8DD542AB7CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-2-skolothumtho@nvidia.com>
 <p435ycx3b27d5gpzcli2kbp4eh36fq2ufgkft3hf3rqgqfx7i6@oql6hovzwkju>
 <20260303232835.GI972761@nvidia.com>
In-Reply-To: <20260303232835.GI972761@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA1PR12MB8641:EE_
x-ms-office365-filtering-correlation-id: 2088655a-9160-4886-b297-08de79c879a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 6AQeByc5lbrgEUgserI2JFcO+cbIvbC6k0yEmsn2jzcXHfX5rOD2LQ1+7AUJ7VsUoX+9APhxlhdlwcXaPB8ndHlhRaTdfBD6l2bHnTB4FP+E4pD2YDV2YBXalJduooKnqBo14ug91Ya07Knn1F0gcXcUaViTimPaw/TBWEow/s4DUxR01A1rbKMEbo+vmm85i7SBGQhTGU7LQSaj2N0vWIeZ5BdZ1+zCToQPldk0/EuP7JvNKzcO3by69TfECfWul7eJ+t4JqiUrfOEEyka/p5NjVhbrg1hirBQSOkVRgvDdfGrFY4v/9+sN2FQnZXa8krlSzVrb8cPh14Rt/sPeODW7B1K0GlW8jw1P8w2DpGOVSTVMYBHmeRrtuGcya2fK5Ve1fWMsXQq1IRCiePImXmDcPsfKYeWsCdCrFmNYUZ8qLm17KIA93Dy1hhiTS1rIe1E7NFt/Ogy0K2afhlAjS20RcWkexLHdIHKr5rWGuEQm/B6FqG+s3ls3RxZx9+Snj/AvjwSRc3mKFOaab+ymWlhLzQ4SAKcx4hWo/1J3ReIPrCNWaM6nAnz44cQmcIt/Z8btl9MoWyy3KQFQaU+G2efmL8fuEUKQIqAG5A+ln9fI2cp+qpEnuQ4GrrjwR81j7D+93c+ZCp25fLlVWxkh0ipjX4Cg85qWc7Di7Kj7qVZXDPmoj3scUeEDw5nnjdoGirtYT8Zr0D/dRR8BpinuGYAjgPOOytwzk9EuX6tJqmONg24+tgr8HCV5Q7BjWKedW7/hyiaB/qABB9Ecq1iAWMAefqBwQSGaLjjmnqagDlI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kIKnyA930QBx1J3YCsog04mi9mywc1EetlT3myMhouGm0ho+zMX4oEqwnvLy?=
 =?us-ascii?Q?xJmBfVARP/T29plADLgMskkEk52mMKMgDQSXH0OBdb7jOvHDP45mavkZufg6?=
 =?us-ascii?Q?SehuFHfvcgN33PMveOd31OSIlqQxw9hPFnzSi8NCPjSpGQYJkD234oCZw6nI?=
 =?us-ascii?Q?QaIRo47HnpW1IpiR0I4mQeUTw4ehxOhiBn9sS+A9Y0AIYLrSu84n4M4dzeyo?=
 =?us-ascii?Q?X1CXQBgggTfpypRXH9hVICt99/UrDhERHs8Q+eZrxNMehswt53iD0q/o00aE?=
 =?us-ascii?Q?zS3o0Y9XpzVm1m13wlFTqln+whSe27IxUGRV/0JiSChGsHgQ0uAIiVyIF/M8?=
 =?us-ascii?Q?tbS6jtBgAR3Oy2qWXlErxc4++vyBBT80Z1a6g6JsCfZ6Zc1kLz0Vfem7W+hs?=
 =?us-ascii?Q?qpYezhHvoZs0KE0rkB1eDNeIljEFM52b4PofFE5jzH82V8PElS9+SHssuKbt?=
 =?us-ascii?Q?iOHZI81ROGmQN1dQ7qhHqhs0yEdAV1ebsNlMt54dFiULB5fqfg3nUYxq+Y0U?=
 =?us-ascii?Q?AGsLl17UesroVP2EbfEiSNQmbjQZ4+SOHzuMg2ci050KYm1rvbfHYN6GUlYE?=
 =?us-ascii?Q?QZd0OsrwEOP+4h1RmRzMn7Nrua+YyRdO/p5tcodiwzal/LwYou29OS1T3SbR?=
 =?us-ascii?Q?zfBXyuOEswx9T1jEX/b/4EyQUYk7AmquaIw6Q+rStx/dFv3B+/mr2/5jEFG/?=
 =?us-ascii?Q?CPRDCtQ4SweSoOvDuKfqcdjJLbJrZ3zG7mZ1dawhjnOBVS9TIKYh0r2zkKl/?=
 =?us-ascii?Q?f/szNpdDquJUt92BYdCFGOkjapD0GyFQLvwz8vx63Tl/jXrXbzqLcn37v+Xj?=
 =?us-ascii?Q?RAvbZ6hv1Uvc5V2mE+k69vE/rNDt6Xhloj8/7F8f/g+RqxOC5D+pfQL84e/L?=
 =?us-ascii?Q?MVjSIY8GtCSybXA1xCEGtHRoQ2pSjqI2mXgIho6/68jTYNNBcB/KPsxWru1Y?=
 =?us-ascii?Q?ANsgffMGk5RTGJyB171Q+ruZc4fPLPaL4CQxf5WdxQDfTAkHX1xKfqwFw0IH?=
 =?us-ascii?Q?Yo+txYR+BVNU86PspGVLbM5z7kls4OLR5NydIYA3qxmznyVyPYaqLv5SB5Hk?=
 =?us-ascii?Q?fEnY0Q8X52Rj/hIJbR1zubHdNaIZmAfa+btSK9qOALt63pvB3QmJ7IxO8Hcn?=
 =?us-ascii?Q?2pmKl9ecPrGZ9c9SwBEffYDivQjF6cZMRJRKD2sJHuD+5Jnpc/+r+ms/KBBl?=
 =?us-ascii?Q?Xs54/e75Sdn5eZPRdL3yX2SltDvIDzt6gAYr/uKehPTi0SAQXBpRgL1PR3zi?=
 =?us-ascii?Q?IxiEMxFyaMGYbT7cnQ59JOmC8c/2f+77N0yq7ClKo5tlUt7vNGI+gxvDPuwX?=
 =?us-ascii?Q?pukj/CgfH395qLCY2v3KMrxedVQ7fKdkvs61pDMIKZSP4A/eu+hEoxO9Auwf?=
 =?us-ascii?Q?QzHZAPL/r+HzoE0Oy+gohTPjCCRnO12HevK75v92ZyjGviv6EDStSircL5Cl?=
 =?us-ascii?Q?/2V04L2tDL3luXvusuoyubr2RN3GxYwqHdlaRJmWZ3p/T0CZVzlFDqZ/NmlK?=
 =?us-ascii?Q?5yBiJDbYZSaXp9kwVRDlhZLbN7mfpx+bICBVtqzXlVET+nvP/+SsaViNbDMu?=
 =?us-ascii?Q?EAAuBdLebTaLRsoaxAL5Pljif0hFmrJ4h5UlCrOR1uz3vWklA7C13PLJ9FiG?=
 =?us-ascii?Q?mFwB/LRqWbSkF0a0chY00CNuuTvAmvacUYU05tpTcOr+vrZu3TA/WFMGbQGa?=
 =?us-ascii?Q?GpRq1Zz69cgF7Qx1k1vhGqumACyuLL7eR7QCLiVLNEIvT76qFhtafXZ9RE4W?=
 =?us-ascii?Q?oyx1G4MUYg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2088655a-9160-4886-b297-08de79c879a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 08:31:47.4149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8I2nQyUHbVyM8Lxnji1yznFu0P3IHvoiHE+H/ZKwpp9ZeTwNoQdUz7yDkMzDikcjzplV2lxfuBlZewLPbHa7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 03 March 2026 23:29
> To: Samiullah Khawaja <skhawaja@google.com>
> Cc: Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; joro@8bytes.org;
> will@kernel.org; robin.murphy@arm.com; baolu.lu@linux.intel.com;
> kevin.tian@intel.com; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH 1/2] iommu: Add device ATS not supported capability
>=20
> On Tue, Mar 03, 2026 at 10:42:48PM +0000, Samiullah Khawaja wrote:
> > On Tue, Mar 03, 2026 at 03:03:47PM +0000, Shameer Kolothum wrote:
> > > PCIe ATS may be disabled by platform firmware, root complex limitatio=
ns,
> > > or kernel policy even when a device advertises the ATS capability in =
its
> > > PCI configuration space.
> > >
> > > Add a new IOMMU_CAP_PCI_ATS_NOT_SUPPORTED capability to allow
> IOMMU
> > > drivers to report the effective ATS decision for a device.
> >
> > nit: Maybe have IOMMU_CAP_PCI_ATS_SUPPORTED instead of the negative
> > variant of the capability. As this will affect only new users who might
> > check this capability so this does not really have to be negative.
>=20
> It is deliberately negative for UAPI reasons.
>=20
> Currently all userspace should assume ATS is supported.
>=20
> The negative means new userspace that is sensitive will still work
> correctly on old and new kernels that both return 0 as meaning ATS is
> supported.
>=20
> Perhaps this should be touched on in the commit message.

Right, this is mentioned in the cover letter. I will update the commit
message as well.

Thanks,
Shameer
