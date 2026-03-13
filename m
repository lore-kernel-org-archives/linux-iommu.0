Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A13264D6
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394672; cv=fail; b=kiSltY8JbtPlB6LisauyPy4IvkwcwPD3AVzZ+zi2HCAp0MdMchXZeeiIPxsp8dN0pJscQwNsXm5Mq5+FAhU8k9FXoA+vmdmX45Y8R2jSBR4FjrSB5qw/0grgWSuX5FU+rm/n45RrDX2my6DjwRxzUopWduYkYJe59Tpzu2LXZ8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394672; c=relaxed/simple;
	bh=O+X357iSYyhQn+HdzoaIOJQIxOy5XPtbtnjxbtBff94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tOOsKl8m0dSRx0R7uJoCydf/ktp6fDVDHeN5zGOMBS9bxw3lp0V+BZnadFvWxYH2tJOtHkLn4RQNYXsgMM6lDZWAUqk6WwZ7n119ssuHXm+y5V0yCHrAmRNeQ/aA7NvsIVLFZlHeTGowmD3NgvPmmmzCtDBuRZrkSAxiX/t31vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hXmAw5n8; arc=fail smtp.client-ip=52.101.57.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXmAw5n8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+mMV94E4u821e1Y++VAVF0HqsY+mEK96sDuO3ZKC/5GCddx3Y1psosdCzsJRq0Y4BuCi3cUt96YcCQvVL26q2MmF5KLHic/OQ8+METejV7DBJrdpWGnYJ1MB6hjUEXp/Ye1/QvYYoVNvB0+/wJIVt1LJkcTQkkkAO/qo8KPrqPXxCdOHZ3WdWQIYkuLONOWZoDi+mt/3kdyAksZdeP6s9yxbqBkc+rLOnruEW9ZSLBUqQ+zRINBFwKosX5/8OQGgPf5By4btxIaLOAe1YkeVVZLvwK7/xefM/rdTbrs3deXAVJ01dt3avTu2bpY1P4v8m0oPFkF5w+z566nctPK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAdngspIBDFZvPECOlmugWGJ8NA3z0HdNBKqEkBSb6E=;
 b=Kxk/bBGvjvH/Kyl6bTj8dYIA0IExEfB33UMi+ohkxFNNzlMqr6woBSff2pKfkpx/hVkvKJjzB/31zq4Ae6p8ZL+c9Rh7t49alEYPPWDvLFCEKuBUQHpnRYB1URdK7mP+zPG6sEHindrSO0IuwhiaqF+CWtj9l2YoOBXjFiwF08ij/qCAZ+NP3jsxiz2kiYuSjCBTg5UGvsRzaUXSZe++T0GTF3CjW2vaVO8N/9bVLcP83bdfQ7U4lvYsp09tMvKKVhdA3Nr0pG16PL7nI2T9hR+HtiwHwnnDpfwgaHpH8bQM/CvioMGkii6usY1VpMyH1fNnAdulAPbpFGgbHF9FSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAdngspIBDFZvPECOlmugWGJ8NA3z0HdNBKqEkBSb6E=;
 b=hXmAw5n8KO82+gNiIap3BuL2BNDP9cSLh7qZXHkHUHsJy903WJs1orKw352akakpzNb9KYYUM5fibMymVOLAgLLtGmvk3ZIOt6jKx4YuYELuXi5+CNjhZiltOixESg8KJVRRWrwD9mikD/HjqUHDOelyctmxJS7Us3EGOeLXAvi4KAveAVrNN8JL6w+YojznCI0tDJg3K0RD7DG/AxPsUAoOZux/77aKp1NZxq1Fym7BSnS0CC/GJ37CK0jtcCjNLG8wVDX/EPrxKyCDv5rQZQs4URwGgXU+MLBpJA/cg5TGv/Y9s5CEJJAI63+X55LBleDUeUnTFtNaY0tG9G4tJA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 09:37:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 09:37:44 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>
Subject: RE: [PATCH 1/2] iommu/tegra241-cmdqv: Set supports_cmd op in
 tegra241_vcmdq_hw_init()
Thread-Topic: [PATCH 1/2] iommu/tegra241-cmdqv: Set supports_cmd op in
 tegra241_vcmdq_hw_init()
Thread-Index: AQHcsoGGN4pApmoWSEeF3k5/8VyGGrWsM8EQ
Date: Fri, 13 Mar 2026 09:37:43 +0000
Message-ID:
 <CH3PR12MB7548EBC8ADC2A4C34EA06678AB45A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <cover.1773361875.git.nicolinc@nvidia.com>
 <7988aa837f02e44c0f436bb236cba0573bd8974f.1773361875.git.nicolinc@nvidia.com>
In-Reply-To:
 <7988aa837f02e44c0f436bb236cba0573bd8974f.1773361875.git.nicolinc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ1PR12MB6145:EE_
x-ms-office365-filtering-correlation-id: 87038564-6837-484c-bed7-08de80e42dac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003|7053199007;
x-microsoft-antispam-message-info:
 GN934vUZIJts+A5dfBQuRDoX2wgVg/952HS35pRYi5jibNElpEoahZlKUDRrCHKRUzfU0kgVdnTPchAqKK7+ypZX4L+7YjYblpQ3rXPTW6FTEmdR7NVxWXG26orXdjtI83DiENWQEei//IyGDHXWC0t3LGHIBYubZBgqyJ63rFgNC/l8Si5eaqsn69CbEp8z5tEnApg6N+lGXre39G/IJfXd028vT+I8PVd5o/V2BEZoWI62WCdzZTsA1LsWm6z8HARr0lFN45qaD3mr5uUy1UJtduqUszYBI67/lLOPrmYSx4KPWfN4V9U8T1Q7n7ADfWYuLwuEW52iyEFc7Dg8Rgz3o6B8Z07NruoceZ4k7UKdcme/ampeYPOZ7bEU7VFC5ShTU6vs5HBKO0E6EP+qDyZ/YspH8KwZNQ3nB86ZTeBeuzDzRK7M+sEbY9AWa/qJ/1RxIv4a4k9QqDSQgrQhQnlXTytv68W0Sn7pL4LHH3VD0mF4zkRiU2pTpP9WTy5RY7Z+45sdygKHFQer3KeHaRiB+knwNYqkVHiJ4X1swdTY3wrXv9SN82IoA6eUoEBmNa9BKt6eOcAf5uzhpZ3/b21o3g4Qu7I0fkXD7hAwv5V37zgfIpGcOfbidbevgsmFtQmFU0S5DZdOL8yAb6DL9Owqf+rOO5gADsv5tw2tD/o4vejVodN33bGx2K4btBbeUo4BMkIwkan7LhqMItqgm+vzKIt1shpwKt0d5l0HUTdYLR3lvAnNYDJQIc7cxVwMg2N4iafMQgkqI1Mh5F0uGRmlgGgpQK+q8dYJt6jb170=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uIR56yK08JgzNURzTUDAj/uvvNv9W663TfLsV3l/kEah7BfgpxqdYAT8Dix4?=
 =?us-ascii?Q?duoK6HVP+rAw26LpdvyMP/gHF8LA1gOzzntR7K1e6btG0B2yQ7e3D11CL6oE?=
 =?us-ascii?Q?/VlSLg2LSNcv06GAD/fznTQ2jZq2jgifbcWK4hhq1cyZjV4MDBD6BkK0SVQk?=
 =?us-ascii?Q?jzp/fb3ZIJi7Na5A+fCg6aRF7WH3JyVYb7gW+Dl49kqr6ZtWAfWtIKWgm2lg?=
 =?us-ascii?Q?GM/lvM+zU8xRVWR2Nca34M+EdzvKoqWkmbIDbgP6TS1vavNy/pq8sozUd5Or?=
 =?us-ascii?Q?V9oruVihHi+FMAM+HBwaDzPJGfD2GS9z+ulNTcv5PhR2VtW/e/0OO34IJwGq?=
 =?us-ascii?Q?vWIub72PcOKeq/kOsxu7z8tFfrEiiJOlRRCjMHENBGUWLq4qGCBtAUhemIh0?=
 =?us-ascii?Q?cQ72g60bYJEFfRMzRE4B7919mNqRCZ/GI2I2GBEwIsWa/O91bv3NDJMZtdcw?=
 =?us-ascii?Q?olM1PUYj3cg92YvWS7GdrBwIAVyoZerGq5QAQdmDBxIsmDlJl/2NrXsKJEoz?=
 =?us-ascii?Q?On0udVwnFiA2HWhm8JnrIwVqpoY4Nd92HYp8s0IbONxwJTiw0hy1QnOtrYIK?=
 =?us-ascii?Q?FWNJKeRl/eYJC2oP2xviQBTCNQXVuvWrQUDJKRSde7P3Qq9OJuyzBC+8JgF+?=
 =?us-ascii?Q?ggTw+YiU+SaN1XrfWuLyEnZvP88gkSWQJJtKpGrRkw3LPo1yp+JiVKOlvnBT?=
 =?us-ascii?Q?LNKPPgaa0Gvs2UU14ebTV37uqsKcVnz7VYk9Hm8rBKUygQftYpcWhffitOey?=
 =?us-ascii?Q?gCsg2syM3bEQU6gzLbS0U6CekB8hy18bfVNHs39tCjuJYdQzdUmM3leFrRHy?=
 =?us-ascii?Q?jt0COT9rSdraRymYSf6NihnfVb6aHB2lC7c58VR8B0Gnh4oA9BsLvk3iDGTS?=
 =?us-ascii?Q?V6uWmHBPjF7iLr0bcxuI1+xJopfn9b5dlgtatmBLX8vn9LFEThZUw6h5oVkQ?=
 =?us-ascii?Q?asllcqA0zTqBf+Ewd+vl78RReDCosYVDHCJz+MBEoyxoh7gE7h96b0AsFN/0?=
 =?us-ascii?Q?cBUgm5ND6PEyyuze7MGbyujb7TZ4Mo07SilbmmSBy+/hRMcdL7TusvKmPCJO?=
 =?us-ascii?Q?X+4+5f8ni58Me5iEUuFaMKSZN06/jepOX2irnXlriprnWClRDGD1X0dnk4yq?=
 =?us-ascii?Q?gvQodjtrJVjWaL98X1omr0OnYg6oOolB4fq6zq24pGMcZxzHzYjKvH0mg3g6?=
 =?us-ascii?Q?Ge+tyKmPzeXi9L6tLTHM5F90S+Qhs1sMIeFrygIsTBLSh/39mvX/sxDetOHa?=
 =?us-ascii?Q?mCWeDTwrUoA8hBhPvBuylz4VT0TkcWMb7gPDnuIsl6QY/amUSihdktR1GgJp?=
 =?us-ascii?Q?vIKNf4kmPaGE8BxE+jfKGN82ScX8HV/FwHKLJc4M3jNOM8Xz9uaY0HBFPeLv?=
 =?us-ascii?Q?FSKlLx1ysmLStqZHZ6pgoefOU0wQ6QttXuHfhM+614+bbynRXHRGdvSORocq?=
 =?us-ascii?Q?7RfevsxjU5bQGi8Xuc9E05ZNs3cQx5EGtoXdFdh7BG+vc2oBalbmxQgPE2/s?=
 =?us-ascii?Q?J1wE0bs6ZIsHiLwKzVLB5LbYrDSzcWKl66ts6oZkG60DE7BoTDBNuO3Mh/7+?=
 =?us-ascii?Q?5C8DkN14GxZTz0N0JcJhkcIXhbtuh7ZW2znmEwNXRo2SFnJEshtd67SfPLDc?=
 =?us-ascii?Q?aaP+ufVxN8VVL7jC11DqCD8CA/WoruFLOjFm7fnbCI/NpYx8s82blF/ozEfp?=
 =?us-ascii?Q?UwtifRbIWw4GzGNyI/GWj5gytcSzl0GVVuebXbEYhwRbj8bUV4++30MJg5Tc?=
 =?us-ascii?Q?29YQFpc9mw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87038564-6837-484c-bed7-08de80e42dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 09:37:44.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cK9ZxIiKBwtFkGMoC0JP/XP4fBhNhp7vs2k0cIFxbdaXkjiiTF15pWeItzkrRsvbPapuhqPTLKfnSDWAfXvbtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 13 March 2026 00:37
> To: will@kernel.org; robin.murphy@arm.com; Jason Gunthorpe
> <jgg@nvidia.com>; kevin.tian@intel.com
> Cc: joro@8bytes.org; linux-tegra@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org; eric.auger@redhat.com; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>
> Subject: [PATCH 1/2] iommu/tegra241-cmdqv: Set supports_cmd op in
> tegra241_vcmdq_hw_init()
>=20
> vintf->hyp_own is finalized in tegra241_vintf_hw_init(). On the other han=
d,
> tegra241_vcmdq_alloc_smmu_cmdq() is called via an init_structures callbac=
k,
> which is earlier than tegra241_vintf_hw_init().
>=20
> This results in the supports_cmd op always being set to the guest functio=
n,
> although this doesn't break any functionality nor have some noticeable pe=
rf
> impact since non-invalidation commands are not issued in the perf sensiti=
ve
> context.
>=20
> Fix this by moving supports_cmd to tegra241_vcmdq_hw_init().
>=20
> After this change,
>  - For a guest kernel, this will be a status quo
>  - For a host kernel, non-invalidation commands will be issued to VCMDQ(s=
)
>=20
> Fixes: a9d40285bdef ("iommu/tegra241-cmdqv: Limit CMDs for VCMDQs of a
> guest owned VINTF")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Closes: https://lore.kernel.org/qemu-
> devel/CH3PR12MB754836BEE54E39B30C7210C0AB44A@CH3PR12MB7548
> .namprd12.prod.outlook.com/
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

Ran few tests with QEMU toggling HYP_OWN bit, and this now enforces
that QEMU sets HYP_OWN for VCMDQ to work properly.

Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 6fe5563eaf9eb..83f6e9f6c51d6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -479,6 +479,10 @@ static int tegra241_vcmdq_hw_init(struct
> tegra241_vcmdq *vcmdq)
>  	/* Reset VCMDQ */
>  	tegra241_vcmdq_hw_deinit(vcmdq);
>=20
> +	/* vintf->hyp_own is a HW state finalized in tegra241_vintf_hw_init()
> */
> +	if (!vcmdq->vintf->hyp_own)
> +		vcmdq->cmdq.supports_cmd =3D
> tegra241_guest_vcmdq_supports_cmd;
> +
>  	/* Configure and enable VCMDQ */
>  	writeq_relaxed(vcmdq->cmdq.q.q_base,
> REG_VCMDQ_PAGE1(vcmdq, BASE));
>=20
> @@ -639,9 +643,6 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct
> tegra241_vcmdq *vcmdq)
>  	q->q_base =3D q->base_dma & VCMDQ_ADDR;
>  	q->q_base |=3D FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
>=20
> -	if (!vcmdq->vintf->hyp_own)
> -		cmdq->supports_cmd =3D
> tegra241_guest_vcmdq_supports_cmd;
> -
>  	return arm_smmu_cmdq_init(smmu, cmdq);
>  }
>=20
> --
> 2.43.0

