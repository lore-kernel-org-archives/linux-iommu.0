Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADE47ECD3
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254930; cv=fail; b=sdH3Ha9yQ7SUW+Sc3AHRjFka09Y9dL57/w0oZfjisTDstOhV1J9+rUud6Qya2g/hLKAnwK6zX1c3odR3MwWw4X1dkx2IY1TC7LV1VGKZBAGMkvTD3+c1aXZ7Xb53koQJoi+SZfT9jS+CnxmhLoiKMtAQYbedcJ1DA3CTNEQSWDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254930; c=relaxed/simple;
	bh=ogYqw/clMOkOB1ckrf/zfyCzCuyCaDvr4ujFxPRB3D8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lndsnV8jKGKTZz+djm9i70MiUKDS0dgOW4KZDRIMKWwqPXyJrk3eCVvhe1KewmwMmNtaPIdG1wX4sxB0367HKJUMdWjMWmCSXYlbw3Zcw+I1lNLYYAKVuXoeIYllwlclb94sTmkxk0fxq7XWfmeTb+5uxV90o1TU0p9ovpQ0TKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=geolNeJU; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="geolNeJU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL4Jo2wfXTQ6wXpHdPWr61obAb0cId2WTz4Us9PXJQi/EUC99ISV6txlrBVNfNLcPgxSai3OYhw4KL+LqsDONXt9re2hEHeK5nZyZUeEI85hwCL2Om/YQ3jqfjTjOo9smgyXu0yvxMn5ts0UI2WQzuReYJdtpjGGZW9CCQ6qP9kwYuHYgnOkOkuryG3Lz59DbdVJ31GFYyj6Y8AR9D58C91UtSoQZQ3szRLUMsQQnTv3x+PbyaAQHvwdnThphzccuc5dwQzjFF5slRMQyj6/dKmwzgRtg7nBDkO/CgTfrtujhhiwAg0RC9yM/PoKNTYkAp7BWvTE4fh0uSIxzLXWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvqZeSkm3oJ4d+Xx2DKhUGGT1zzLxAeHMHvF6X7u27c=;
 b=m+p1PNZPKLrGyoTRA/XwKg8sqYT+ZF94ddbV3aNNZVXtamZ+bBbPtHfiy7SOog1pbf2jWN8PxPuo+GxcZiOyeIwDiwhvZgXLyOUy1l42vNCeCXyZMTBrot9fj0WmjShBc2uGK0XUSJ/wCo2M6fVvPNgKcbyvuLagLZ9gHlu+3YsqXISCZY5rTxA+rrCPFOrtT1oDvQ5SJ/I6R0sdUEPnaHADQswmiOrh+eJG3xTQKFRrsDAyg4Ebh5+sz0CXl6fpQRpGZkYbAY6/CGxCJ+lkphHNwPaipmmmL+8vePy5pUtX7D3kQs8jRTbJrhVtgI2j9FLpZUf1ARG83N+EmZpFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvqZeSkm3oJ4d+Xx2DKhUGGT1zzLxAeHMHvF6X7u27c=;
 b=geolNeJUdmPt3M6jq9W8LTYfQQVaUtor7t22OQPVR23HkFOlmErEK3pzuUF7xQJjE4rIUxQBFt4M2mIOVnwuvd3E9cL88oPZN2FxHQwxLd3f48swtVPCDjBp9B3pj5ppuvTv0HWoRzJC/EHxSNLu58ZP178PApfbZGTA2TABC8g=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 13:01:59 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:01:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Joerg Roedel <joro@8bytes.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, "Hegde, Vasant"
	<Vasant.Hegde@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, "open list:AMD IOMMU (AMD-VI)"
	<iommu@lists.linux.dev>, Jatin Kataria <jkataria@netflix.com>, Boqun Feng
	<boqunf@netflix.com>
Subject: RE: [PATCH v2 0/2] IOMMU Performance Optimization support
Thread-Topic: [PATCH v2 0/2] IOMMU Performance Optimization support
Thread-Index: AQHdP0hBmtbtHTdD20SCphs2nKMp5rbdtQ8AgAAV1/A=
Date: Thu, 24 Sep 2026 13:01:59 +0000
Message-ID:
 <BN9PR12MB51460F3605E485C66760735CF7812@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <arUMU5QGhb34exFV@8bytes.org>
In-Reply-To: <arUMU5QGhb34exFV@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-24T13:00:59.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DS0PR12MB7779:EE_
x-ms-office365-filtering-correlation-id: 53a59fd9-2b38-45f1-a630-08df1a3c04d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 i+Fz/cAx88Amn/hU83WpdtB6wO8wUXaBQl7i1yo0NpSGVXKs+q7BgpWRYQvNJR6wNdjXmrmyCHa9X6oD0CWf6Fr7bK5qq+ghMpOr2hyLpZF5gFl3PkV7Ofac3EvzVYaQPDjANsvrKdS0WARl4qsF54U32huV2X6jpIfrPpkkcEdhJKzDimynaEADU78y0VTOUdENgeNT3En+dpda1iyNVSpqDM/Lmf/e9ow6cX0IleDCqgIFz8MUxyEUQjCds4FYFblZmC/UR9NX5A99ITZt0sXk/Drt2HfNIPd0Kd9ws40vyICB0T39R/d8rZ3el4h/YtRoHdT1QUhopD5dZ0NpBqdWIWXgNnIF+vvDDzBKvZWUBlaYQhiJtBCmyU+eQQbGO4iHdA2ClHUBR4wGe0huu3NXpQPyxuy3gcNlTGJTEzu6arLWxSPm1qXjtgyWtgqRNPdsHjDEkOT/OlM7n6y6KZnLJB25ylsgQMn2inj3LLa7MabcZoeqVUAOMbnOh0EOxM43SlPMUkYUNAXkDnjT2j//eJuQxw0zqQqN/z1yGPOisnOjZR8selFEV//t9NYYxKtzurDN37nVZw+jR5Gqws8uO3UInCuinx87oTS02TZiEJJjJGqDkD/OMJgNlr67fSm5n0KOGZdsrmu+lk7eIt7smxy0J0JywpBHfYVcIVnOPjmYuxz0k3NJZ7L+2XhPgF0XPk91djGQToEzE2iQjZgD3mjDXcSnje1XluNENgk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tpUktDFyK23UNxklAivTjDNrTUJ/1WjZqXgbqj5U195Wr5E4cxKn+Hn1Xf6+?=
 =?us-ascii?Q?rOP3E6G07ia3kBV+Hx7eFHMbqALACmMKPVOdMIFrLODYQ6VwQWEiPzeJbqsZ?=
 =?us-ascii?Q?iX0iOiOWh7zPN+qNacBW5kEXWoysbHluIMSJKgrmRybplgQ34UgSHyl4LkGP?=
 =?us-ascii?Q?69Qr053Ks53fmjdybM3f7uwWvrgpezNaQ216dHN0shPW24zWCpzc9+cyl+l5?=
 =?us-ascii?Q?+rlAYXcgfmy2zC63lNMW+Afmt4VII/YEgpYsUIWcGCge8tCqQXKlaTLdNntx?=
 =?us-ascii?Q?AgxOK17EHQ630o9gZQIWOPn+GBe2Pu59VkH3sA/y/qwnkv5u+RHPkpPKDi+H?=
 =?us-ascii?Q?fkVMy1qnpR3Oq4o8KAZyfjKkhqpFrKNDq4zSvxcShq1ZL2f01SqGa+T4ZaZT?=
 =?us-ascii?Q?T3sYzX0L449fwXw1RcBskm9sOPU+feqRoJaH1DLl2EtVwf/Pnrd0IbnA76Fq?=
 =?us-ascii?Q?uWCsigStcQ+L3rN5aKhxaNPQUAPpXEX7K/Myh0rJ0cWEQV69scDHYyVhXE+q?=
 =?us-ascii?Q?V8qCClCMSzjBrYW62M5nbuOU5tOMeKoAEgL3ek66RsbTpYe4CGVAQK8Eo1Pq?=
 =?us-ascii?Q?PAn9bvT4VY3NcRTWCqfXY7ewFT+O6TR5Ai9jZBBCGm/5GE7nrwMKPEnFhCI3?=
 =?us-ascii?Q?W2Jq2JRiKS9Uf5OB9RHk5nwkWNdUUUzsIfCTcjGwFOJndA7Ghvn0zsFxEXzk?=
 =?us-ascii?Q?f9FkNoURorw9yBYdtIpudbGUHgo4BgExe/23ZY1HHWi7tuDWeJ63Tq1vsrIo?=
 =?us-ascii?Q?gvZWIAaN76BqQdKievBacqwrKcuGejXf8dRb00Nzw/5XraxctzM7fx392MRA?=
 =?us-ascii?Q?G6xJ0iWRfrzDcKKPaBn4bhnijBHSAGmrJDiDv0L2yTIbqTk0o+p3VpGgLEwk?=
 =?us-ascii?Q?D91+ITL+PTBDarR8LV4l3fwKvqS8IUPGAgEdRRo9Z8A2t7eLE3ygdWefzuk7?=
 =?us-ascii?Q?eMrYPMd3UVp4fOCXHBeZdWRJY2QbX9sdhVL7MmT8vgoZfO8xd0hMzeSwFs/k?=
 =?us-ascii?Q?txB72KI+YAbPDcL75p6VbHvbIWV1kfaK4DuAk8LdznSmNgCO2Grum9xb47an?=
 =?us-ascii?Q?9eUcQGW98a07O6xALvbwJKr9tAoYrcgfR0wuyEG2xDHrWAnqs5BhazGm9e/l?=
 =?us-ascii?Q?yoi0JkPx9wjJ43yJUZxD5v4MFQB74IFbiuwRwD98LloXBE7bcsfPgQXMm8d4?=
 =?us-ascii?Q?m2EctGM/IiI00CvWnm2C8uysEM1E/JXsoMzr14gEW4+epUfVYsLrbzxTSTty?=
 =?us-ascii?Q?5VB0gpyIcUNfJqsHu2YzoYGnF9yELUfbR/OVLxhuk9Tcu6OZ32AYKyhLi05k?=
 =?us-ascii?Q?q0bWCe58A4qAc4o2sQp63NZnaJR+Q8TbDWaoWBj94I4Pmqlk3msFyDSk5DMt?=
 =?us-ascii?Q?OuqHJaTZPy+7ydIvjnB/44sFjWzwSEAtXsGYy9NkYJtClj7AACSDQHj1vRdA?=
 =?us-ascii?Q?XgTSvqNu8QRriBxcqMqFHrvIXG3pjaObp/bXKzuE6Cj3/e1XINvGTU4R1VYh?=
 =?us-ascii?Q?zUoouz7EOOeh1MZ/8odQEGrkiqyJLHbJoUQnysOYmdogLhRH/VZRrj05eLP4?=
 =?us-ascii?Q?0ibzoPRDYrZwAvPGIogryDwg9KPp6KKL9WxwIY0CatH/nQjhRV78p5jpLYfM?=
 =?us-ascii?Q?FEXwkAkFIZQEfphk5NbOa60/EU0qeru1W9nAauJiF3uXkFjrWBzyhraXpcjA?=
 =?us-ascii?Q?e08Ikk05tRP43zqF2AzjqfY+2hXwOGc0XVDd4pypmMZuoS1E?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a59fd9-2b38-45f1-a630-08df1a3c04d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 13:01:59.1083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuS7joksKMzwshADxoGQWTmWsP44PRrgvmpNqx6XvB2xgfLSERhBwy6CJlq8bmxYS4rXNNbj1XxmGEayjhQVbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779

Public

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Thursday, September 24, 2026 7:43 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
> gfx@lists.freedesktop.org; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; Hegde, Vasant
> <Vasant.Hegde@amd.com>; Will Deacon <will@kernel.org>; Robin Murphy
> <robin.murphy@arm.com>; open list:AMD IOMMU (AMD-VI)
> <iommu@lists.linux.dev>; Jatin Kataria <jkataria@netflix.com>; Boqun Feng
> <boqunf@netflix.com>
> Subject: Re: [PATCH v2 0/2] IOMMU Performance Optimization support
>
> Hi Alex,
>
> On Mon, Sep 07, 2026 at 11:12:05PM -0500, Mario Limonciello wrote:
> > Mario Limonciello (2):
> >   iommu/amd: Add PerfOpt IOMMU performance optimization support
> >   drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in
> >     identity domain
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 +++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 ++
> >  drivers/iommu/amd/amd_iommu.h              |   3 +
> >  drivers/iommu/amd/amd_iommu_types.h        |   7 +
> >  drivers/iommu/amd/init.c                   |  43 +++++
> >  drivers/iommu/amd/iommu.c                  | 214 +++++++++++++++++++++
> >  include/linux/amd-iommu.h                  |  11 ++
> >  8 files changed, 341 insertions(+)
>
> What is your preference on what tree this should go through? The IOMMU
> changes are bigger, so my preference is the iommu tree, but for that I ne=
ed
> your Ack on the GPU part. Or let me know whether you prefer this to go
> through your tree.

IOMMU tree is fine with me:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
For the series.

Alex
