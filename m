Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF021A682D
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054276; cv=fail; b=ZCcN3assuQeWOQDuomqQJu53lNNVoJo+1Js7cfjlYH6jgV0X5AVqxa3Dyh+moUUfoIgxXMUIcYkyRH6uzYsWmGmchlP8av0chHC6AEkmiSzz+iNv4Qfywx+GhIbOeUoc+am7/NG2jbhQpLcto0FoG7A8mZeBeWo0JH34ufiMjpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054276; c=relaxed/simple;
	bh=+O/wCauoXbcWsAjrL2fra6Qhx8VeQOilqU7Kvzxn/rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oZIFP5zCLvgZy25z7EtrTB7GohPdcqACTy8NfqAYMBhIsYdNkzOabmZzS00VyRyxYNMIi0qCBSn5Ca4vJerryFtDHePZr+oDGedRaW3Hbm8xDalO7Mzbth8FQCXKZhzWN25tLmda9QnqLg7WyEVlq2LhL4PAcaUVwYDsG8IHAao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YN5WaKrh; arc=fail smtp.client-ip=40.107.209.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YN5WaKrh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtWTKZWz/pOpu5/HOdZHHa18tr2hMrebrb6MqbpYrdsZYNtrgt1Kme0Earam2uy3Au2yjSGV1kEXfH2Ej8P/0S3Qsg7WQxFOyCp7uQbQI7CUcPLKRRAL4F4kmCY1LXACqz+wBpbQncdyYiQs1fxarL/5fMTyr4oAShQ+cx6ulF5fQdkHckYyWeKMcnd+s0g9g619AF8MqCGxlI4Kc5SpTgWX8XPuYb8CxHWd0EvG4Lu28u+xCcyCHLKRxGWX5RDDp6zVE8NRgfaWy7Sjw0+ouOpdGTC+GRzycBJbfZ75HEU7sh1KyIM/YgLjR4kVhxx0zYsXWLdjuZ2/gmqvDCzn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lqy+tVKeznLZ4ZTjU0oHoJOvy81ubQBonnOA40JWL18=;
 b=x5kLUfBMczpoj22w4dUFBwkY78U0b+AX/9+OQoU56RctO+3l0fW+kMtfeMjb4iiRzRvh4B9DMW3RtIQ9y43MPG2iKe0oy89KG+o99qD+KPX/wTklFwZr9s+oY4CXri8ZS0odseo3q7dnJX/KvHwap5Hky7kWAwD0MHTjGmaSPNL9XzIcEDguaOD+AwyZbOK/olpa2/qpSKXQZJS71pfV/Fvj32I33iQUW7uGzWNNVCzHNAZCPskCs+uhs7RYtDRUaS/CSdI4w82Gc1cTfN2M5TvBKgRem/gH6+TQXDlM5NRrUts34mfHewMTqJZz0GK1Af2OMAxjVcfnLXlxwxlFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqy+tVKeznLZ4ZTjU0oHoJOvy81ubQBonnOA40JWL18=;
 b=YN5WaKrhxt2E5aHKIqdP2SctpbIBerjMifXUYedgiFtqddX9rjMjxKQZz4LwTFe9ndEN6g2uCHtzfavaHsU6+90sGlAbJ0iRHrSekOn0joNY1wk+Q8OTBqohUKp7YFO3s8ocj6maF4tg4YX8OGWnG3RJy3NhfjKAuPaBqcfA/cg1LGhioxb/YvH4gxfY552izyok8sJKMkwIxafFeJFE9HGL+zklJA5BFoHLNRqE2wK1rzFQMmv5vyT5oCvMgLAzA1ra1ABunHLb4YWlZFH6bVbFg5SJHp8rzt1rtfRlKbAdAwBjtHaNtvF1WOI2Vq04Yb7Hw6smaPSeIjyxffcJ2A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL4PR12MB9535.namprd12.prod.outlook.com (2603:10b6:208:591::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 11:04:31 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 11:04:31 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com"
	<praan@google.com>, Malak Marrid <mmarrid@nvidia.com>, "kees@kernel.org"
	<kees@kernel.org>, "Alexander.Grest@microsoft.com"
	<Alexander.Grest@microsoft.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "smostafa@google.com" <smostafa@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFTv1 3/3] iommu/arm-smmu-v3: Support PRI Page Request
Thread-Topic: [PATCH RFTv1 3/3] iommu/arm-smmu-v3: Support PRI Page Request
Thread-Index: AQHcq0phSJcd79qivU2bpTB/nvPNkrWmEFKQ
Date: Mon, 9 Mar 2026 11:04:31 +0000
Message-ID:
 <CH3PR12MB7548107B5BF7ACF4C0568B26AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <cover.1772568590.git.nicolinc@nvidia.com>
 <ae9a953251b46b49bb0ca4289d1f3b614ba5d6d7.1772568590.git.nicolinc@nvidia.com>
In-Reply-To:
 <ae9a953251b46b49bb0ca4289d1f3b614ba5d6d7.1772568590.git.nicolinc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BL4PR12MB9535:EE_
x-ms-office365-filtering-correlation-id: 6e3226eb-f223-4bcf-0e7b-08de7dcba3b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 7wlBJ9VAonWKy96IxMIPFlVka7LelVji4sErwqHBZIDAOW6ymCJJz5FMkcIkBzi5NXWdi4EFeurvaCYRTCISJ79HxlbbMtjEO9R6C8jguzkACgjjRSHaG0FWJJnBBv+AHJwBFokqX0HhAR6eymx4Bf/w94uoPtybcvvjMk6Q1MSh+7yqa5tZdXCeD27rT7uAIWB6BXekdS3B2aJEsp8mv/yKe+CmExV/4B3gYwMopcNEIPqb/wcxAo8mwjwrf7Z7RgNltU6PcNGZ3ocRlUANyeX6fkxpPf4e3TAhzS/lMOWOVLKJlKUebHIuBP+NjXasmcRn2YNtm3TtKlhUBKikKmdwM2jxXpHE8Q4UKXvy4XGw9SbTs8ExhcXY3EQVVoYCiOhLBQSAv3wgB0tRSc16GVzU9bgl7sUAH6/PaLw7YhCItnGr5a8FfZIdmWOQdNrBO7NEF38s9ikScFQsNIvgX+zhqkbMaNerBUIFmk0+og92BJ8UL61CGEh40hY2TuHlWyinsSwBC6uIfKWNaAe4Ioh6xtZH8qk+jsFOblXE/zzho4HmbgQ3aBbpKc1ii/QgPrXOIHFwqhcqO8Lh2Lm/nGyWYpsGXqskguQPeQGHKQkSVlcmoL4kaC4BaLAVHfgubJi68mf/oAkmsXr5KumUcTIzwSQWuNKswLjulfWpRvv4QKYLobJG0JIi+VfMltkaU8fe1L67vEAjGdrBMjoAVAccPtcqeuW0bLEYjfEbvRitypZ5+cc23Lf0KQEqkcaefUpAeGJ1eWyULTGXE5Zj5uH+CM705ckMkJe402ZYaWA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y9bsQmFZfUKQIlExrWz3fxGKY1+Txlw5T8LEk4KysyjnkItSH4VHnWCYWbn3?=
 =?us-ascii?Q?qqzeKqDttqvEkhgOs9GQ5ywGrXo4c0eMe3KdodX6cleXMup75nicD2335YpT?=
 =?us-ascii?Q?qSVoaBZBA/PcJgHhXF9KCLqEwac3/Ui1nJoPbB2AkMN2uS8L8JIfrG7/KZGX?=
 =?us-ascii?Q?xUk+7ngL1e2gLWZOo5IldxKoSuG2ClrvZRJCiMSIRWUlxudMfqemQKHkg3Fa?=
 =?us-ascii?Q?OnWwrEp2AKAN3kcKFVuUKzdnQHTHRIxWzljGzRz0TFqo1zNLu628TYRI0plu?=
 =?us-ascii?Q?qZsBHYymi5QA9LFBw9rqG2OuiPTza5nB2dLL8Eu9kM8Px/KBzdPm2vUaGz52?=
 =?us-ascii?Q?2DBRDY62o0whqzQ8CX86OSGXzJ3N6PwUtIXG65YU5nGVUopLetktfSa0oadB?=
 =?us-ascii?Q?s2+XD5txlysxqMaD39eJFgug5yR4GnLc7jBxABAbalImUV+h0ttAXWSeE7qM?=
 =?us-ascii?Q?aG+0+w0pnC0blPX+85LsaeQk3EghCKHzdaaQaOC1yeA9s/7YmdPYHogeVX20?=
 =?us-ascii?Q?MXh4xtk7ptOsc+LSEaVvjKZFegzI8/rvMZekopApaUSvzjOXmPXoDGAXVBhb?=
 =?us-ascii?Q?tWNWeTCeKRus/w4OGcauOHYulb0yF42Ly1LIpOvexiy87aCiOwn6u+6nV5iq?=
 =?us-ascii?Q?wGgv2Q/4hqkvajKYZOZzq6UjTn8nHXMwg1fjs+5//2l+avzk7xSomkkWDlMH?=
 =?us-ascii?Q?sVz8ZxX4zo5prSpWEIDTLdiMbE6Jjsm005pxaNFsC/WlIrX2Bencq1+FzD9p?=
 =?us-ascii?Q?3+Tr5LtX4qMkMd/He3yOKm9RfDClZfcIcZ3tEhGQNjzhOo71GamgVn6hK15g?=
 =?us-ascii?Q?qc4xon3sWzNnGrNKwLJ4lVNoL7YAcp3zozlPE87U/3WSka2v7AkCTkdfbvf0?=
 =?us-ascii?Q?DO/44Cwcnw+iPAKUdWqHC+G7moP4daaiz0llelrdxPA47/Ijq5xuF7OjreE/?=
 =?us-ascii?Q?a3TBjFF/I65mHImOPfBKXvjqQLos+F9/lxwqGphy5T8aitpuYxVy8ZzP6bt8?=
 =?us-ascii?Q?Q0yZYG69butbkDopBPCEdkQU//Mla5AYfiScGKlTMysR6UEcxw3R981FXhkb?=
 =?us-ascii?Q?dWBLC45Wh3Nzqb21QszJcMhnrhxXSadeyKvtW6/rHhK5DuPVRDBYBQUFIVX9?=
 =?us-ascii?Q?QoDsVT9niGTMw4sJN8CQ3p894Q9h3Dv+b7+pKqIR5RbTBFKVHFXeVMTWV5Fp?=
 =?us-ascii?Q?A433s+4xolAQRkeoevCAOSf5ICAsISR/IOPADvBpLDw/8tptJAFCX8QJSO4b?=
 =?us-ascii?Q?8rzwVRsfHFbnspNg6f4k89fRJ8y/hbOZmKEY5KXfSyp4zv/dEHYLkjrcuyh0?=
 =?us-ascii?Q?z81cmeu6d6wzi22VqJJkKC5q0rRCxOH2i0yVJ9UTWQr009TbSA9w5dXGlqrf?=
 =?us-ascii?Q?Ahx4EWdSIbSs5WCH9H76tXOELuPgk0YrevaMLDWg4MA8AzP2GjMg9OjsMVul?=
 =?us-ascii?Q?PwoVKaei6vlr/pqHjaJKOLeO7/4VEUoiIL7FzvxcPT6IrYmaV2zplI6d3gaa?=
 =?us-ascii?Q?L0rLRC1ZdSZgDsPtddvM7CV5oWqdhzrt0qFdQXU6w6sppKapS5xMfbOAhgbV?=
 =?us-ascii?Q?VOXvWcWWNO7H3Mn9bTuppeuutwHETYlWhR1a1ML0gKnOvJaGr3dUXreK2ZgN?=
 =?us-ascii?Q?QmLoNV+RZjHItsjiwdOX5R7d84GKTmIaYGcY+8W78Ne15EZKTGJEaxXCY7/X?=
 =?us-ascii?Q?0tNUD/ZBFddL+pNClaJQxi6nT+nYvdeUetz89vSSWBznQ97aQzYwr7h+WJSg?=
 =?us-ascii?Q?qtmnbXHogA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3226eb-f223-4bcf-0e7b-08de7dcba3b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 11:04:31.1605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ZGkAsBtRGKttvMo3ujNcsQVEhSyvY8JPt7+tTX+P5T8V/ZWbka9DpM+h6t9wEezG5Bl6bVdGvbVRdfznLDDrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9535



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 03 March 2026 20:13
> To: will@kernel.org; robin.murphy@arm.com; Jason Gunthorpe
> <jgg@nvidia.com>
> Cc: joro@8bytes.org; praan@google.com; Malak Marrid
> <mmarrid@nvidia.com>; kees@kernel.org; Alexander.Grest@microsoft.com;
> baolu.lu@linux.intel.com; smostafa@google.com; linux-arm-
> kernel@lists.infradead.org; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: [PATCH RFTv1 3/3] iommu/arm-smmu-v3: Support PRI Page Request
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> From: Malak Marrid <mmarrid@nvidia.com>
>=20
> Now, arm_smmu_page_response() can issue CMDQ_OP_PRI_RESP for page
> requests
> from the IOPF infrastructure. Decode the page requests from the PRI queue=
,
> and report it to the IOPF infrastructure.
>=20
> This fills the final piece for PRI support.

Do we also need pci_reset_pri()/pci_enable_pri() to enable PRI on the
device side?

Also, is there a check that the device advertises PCI PRI capability
before calling iopf_queue_add_device()?

Thanks,
Shameer

> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 65 +++++++++++------
> ----
>  1 file changed, 33 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 055dde5367131..277d753c7675c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2061,40 +2061,41 @@ static irqreturn_t arm_smmu_evtq_thread(int
> irq, void *dev)
>=20
>  static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64
> *evt)
>  {
> -       u32 sid, ssid;
> -       u16 grpid;
> -       bool ssv, last;
> -
> -       sid =3D FIELD_GET(PRIQ_0_SID, evt[0]);
> -       ssv =3D FIELD_GET(PRIQ_0_SSID_V, evt[0]);
> -       ssid =3D ssv ? FIELD_GET(PRIQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
> -       last =3D FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
> -       grpid =3D FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
> -
> -       dev_info(smmu->dev, "unexpected PRI request received:\n");
> -       dev_info(smmu->dev,
> -                "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access =
at iova
> 0x%016llx\n",
> -                sid, ssid, grpid, last ? "L" : "",
> -                evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
> -                evt[0] & PRIQ_0_PERM_READ ? "R" : "",
> -                evt[0] & PRIQ_0_PERM_WRITE ? "W" : "",
> -                evt[0] & PRIQ_0_PERM_EXEC ? "X" : "",
> -                evt[1] & PRIQ_1_ADDR_MASK);
> -
> -       if (last) {
> -               struct arm_smmu_cmdq_ent cmd =3D {
> -                       .opcode                 =3D CMDQ_OP_PRI_RESP,
> -                       .substream_valid        =3D ssv,
> -                       .pri                    =3D {
> -                               .sid    =3D sid,
> -                               .ssid   =3D ssid,
> -                               .grpid  =3D grpid,
> -                               .resp   =3D PRI_RESP_DENY,
> -                       },
> -               };
> +       u32 sid =3D FIELD_GET(PRIQ_0_SID, evt[0]);
> +       struct iopf_fault iopf_fault =3D {0};
> +       struct iommu_fault *fault =3D &iopf_fault.fault;
> +       struct arm_smmu_master *master;
> +
> +       INIT_LIST_HEAD(&iopf_fault.list);
>=20
> -               arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> +       fault->type =3D IOMMU_FAULT_PAGE_REQ;
> +
> +       if (FIELD_GET(PRIQ_0_PRG_LAST, evt[0]))
> +               fault->prm.flags |=3D IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +       if (FIELD_GET(PRIQ_0_SSID_V, evt[0])) {
> +               fault->prm.flags |=3D IOMMU_FAULT_PAGE_REQUEST_PASID_VALI=
D;
> +               fault->prm.pasid =3D FIELD_GET(PRIQ_0_SSID, evt[0]);
>         }
> +
> +       fault->prm.grpid =3D FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
> +
> +       if (evt[0] & PRIQ_0_PERM_READ)
> +               fault->prm.perm |=3D IOMMU_FAULT_PERM_READ;
> +       if (evt[0] & PRIQ_0_PERM_WRITE)
> +               fault->prm.perm |=3D IOMMU_FAULT_PERM_WRITE;
> +       if (evt[0] & PRIQ_0_PERM_EXEC)
> +               fault->prm.perm |=3D IOMMU_FAULT_PERM_EXEC;
> +       if (evt[0] & PRIQ_0_PERM_PRIV)
> +               fault->prm.perm |=3D IOMMU_FAULT_PERM_PRIV;
> +
> +       fault->prm.addr =3D FIELD_GET(PRIQ_1_ADDR_MASK, evt[1]) << 12;
> +
> +       guard(mutex)(&smmu->streams_mutex);
> +       master =3D arm_smmu_find_master(smmu, sid);
> +       if (master)
> +               iommu_report_device_fault(master->dev, &iopf_fault);
> +       else
> +               dev_warn(smmu->dev, "PPR: unrecognized StreamID 0x%x\n", =
sid);
>  }
>=20
>  static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
> --
> 2.43.0
>=20

