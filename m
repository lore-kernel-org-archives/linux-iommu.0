Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013082.outbound.protection.outlook.com [52.103.74.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA924BD04
	for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275113; cv=fail; b=PirtwQ92KlvBTf3k2QIZq0B5zL1uflQEQEQlAqDXdCy1S3sWe9qYBwz0P7n2bIxeIecpNawA3S9GMH1FWUsOd1+sCviRzh9xJLFGtmuHXPKBuh/gzUO5pD4XcgZYogtMcyXlEsgf+PCq2NXlXtYTFu7lVqoqnFM8ksJVwhdXSAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275113; c=relaxed/simple;
	bh=B8ts6Z88gEwtJ5SUv5QJxjns8S/jMat2IIkV1cK4GPs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HrzsRb/bcQIYJmBvI6S4+gAxgNlEL7GL8kYTWWHqxz8yeX9iA1J3lK9s3u6Xc+lN1a13ejE/sVFBDDhItN6LpkLbei4T2WMmOBziiSRhEE+hWk5w6Hl4xlVIab87mlOglOvQcXGujwnpk4YpMEorUqUAk6o9UsX0VOFrKLoLbxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=i1pNgha/; arc=fail smtp.client-ip=52.103.74.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="i1pNgha/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDzbhdUo8DzMY/LkmCR6lTusmS7TdaoJLMTBDN6FvNmHH6b9nD8qY82gPk2p3Th1Rz7aBIY9BiHzncYjFBNtIMgv9KBpz3NoZxOHQCsrwel55a1giT//HM8Hq/U0fQZQ+MYgf5FAFgw5ZRg56H0+9sbm4Qk4MHNg6mrSrNVn/VMw4nAlDC42lpi+VnXBkYOuiahUlCL1OTtntFmIEukyjRiEfYD7hZWBfTc18+oOfF1LgSNN6CxpOHhHtm7o/A6virJFDybXglQMJF3qGNKuqFh0Lu7Ay9P34c6Nkx9pLgwkodyFXLlr6v01NnRtWRX+D7m2xh66xiuK27pxIczqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESK4Xz1JSrog1XGLNQ3YuYWaWD6y02YMpSy1BKQTTnM=;
 b=JgEW7JAmFug14uNQ3cB+2En9IaIZDDrS5wLH7WPh+8YXLLvX7fF35p4+C/MAOrc3+T9FT5zn/d55+NGJu2pVQHFNTnDbiu9BlPWmuKGi7+N3EhgvddWqg3FV2aduhpOvMIxC3PiYL8N6tk0Fe4AJQy3dqUhJNiU181bSqzdb+apt1Kh8iITRlRVmM03yOuL90DHD5niNORlT9wRh+3nR2LJi8IUJwXVI7G5xldDNQw0UtJLRHZa/c43xKr5Q4adHi1Jn1efp9rUBEZMVQBw67zN1QrYWLW7boXKelNP4PxnLLb2MOFtN385PMpeyuL0xG1amjXLvzEUXad0MgJHsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESK4Xz1JSrog1XGLNQ3YuYWaWD6y02YMpSy1BKQTTnM=;
 b=i1pNgha/qrZmUyZOEWVcpvisbVnEentAqBQaDC79G5U/eZ4TN9xm/GxYkkppy3ZJDZ311rIyncq33oJ06wwJzsUoptZ7fps9bwLFfcmF3ysWWEpLlRXtQFKRuAuamIpvWaqcN/x+cfocatgOqOCy70EilWGBKf6WpEitYYfLcEamil9Cr+vXGWea5nGrPqgAm7eFsyW08U5dEXajENpLbt+oQtgOb6QX7wrF1XRzfhhCpAW8GruLvpat56TiXMYe3YFuaBrd5L7FFIpilXyIpOcMdtHTvMC6vbgMxZl5OWiRnew0EYE6YWKMXfJ14OGSrXioqqjRUByRoaYAdJRRew==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by JH0PR01MB5947.apcprd01.prod.exchangelabs.com
 (2603:1096:990:6e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 03:05:05 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 03:05:05 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v1] iommu/amd: Set C-bit only for RAM-backed PTEs in IOMMU
 page tables
Thread-Topic: [PATCH v1] iommu/amd: Set C-bit only for RAM-backed PTEs in
 IOMMU page tables
Thread-Index: AQHcRC/z/2IcAo5ooUGdDRtk1NmW6bTP5FMAgACWJjA=
Date: Fri, 24 Oct 2025 03:05:05 +0000
Message-ID:
 <SI2PR01MB4393D52AD53469388BED8E6CDCF1A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References:
 <SI2PR01MB439358422CCAABADBEB21D7CDCF0A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251023160154.GM262900@nvidia.com>
In-Reply-To: <20251023160154.GM262900@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR01MB4393:EE_|JH0PR01MB5947:EE_
x-ms-office365-filtering-correlation-id: d7cb488f-73b1-4fd5-317d-08de12aa21f3
x-microsoft-antispam:
 BCL:0;ARA:14566002|9112599006|31061999003|12121999013|15080799012|461199028|41001999006|19110799012|13091999003|8062599012|8060799015|102099032|51005399003|40105399003|3412199025|440099028|3420499032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nOYHthZBKgElI8gPo4MiLXjwlBI5hpzisTl0KueoxryA/gXhNkUX7/xvcAy8?=
 =?us-ascii?Q?ty0wiO7YtlTLneqYwADdcMG9Ab2z4stt2pNGJsMplrhn0c+dA3PgOW1hG9E8?=
 =?us-ascii?Q?zJnpM+ZASiwOXEimiBKiYzFHLgFhGpcw6zkSa+IE33GVtjFbqWVD1Rww3dnK?=
 =?us-ascii?Q?eNsBnh73kESxQq2w104U7YmWrNZPZnqgiCBf1q2LdrZ8fsJ2lg1+yt2QrDQZ?=
 =?us-ascii?Q?AbI+xN/ZCB0Ly+MHS1MhBrTYJiGjhYZ8TWphf11aeLQqIsz3MsmRPCosvrbE?=
 =?us-ascii?Q?CNq4YJmQbETGER7HFklWnxjbu6JMUsL0KlQGrchWI/mbgDu6j+jV9YBwQrO4?=
 =?us-ascii?Q?x7HLRhvoOksJBr8IudrL0wS7CQ37SInhHy/Q50y8W1zG0ls1ooQtrMUrPYQX?=
 =?us-ascii?Q?y/c1w7i9Ly2L7B6BwTTnrwvwBLjU0GGwnWifIt8QZcnGMXNFE/Axf8+c+NM6?=
 =?us-ascii?Q?RB098VDxWaH5r6BUJrRsJxXZLLNiSUownYl1NVm8DgxiLu7hLgnFbOrs+ckK?=
 =?us-ascii?Q?vMSSrVc1JiTYmEnO1+kfduAW1A9CJgxAb36mznXvzdMXq84RgQmZKc04v9wr?=
 =?us-ascii?Q?P2yrZa41TQFDfxJ1V+bMAzOJ3v+WZicqnhS6fD3+XW1GhDanr0+uWcvc1ee5?=
 =?us-ascii?Q?Ak3cY4RRkTWE1rl3acKrYPo9BODWNgEznSI28++1cveSoKvCxq+6pQCvcpSs?=
 =?us-ascii?Q?TrmIypGiCLZl6IOU4m9czoBptCqVoqqZCovawkZrtz5KYg35t54PO2aNqP9l?=
 =?us-ascii?Q?l2r/dHY9WTUPDStF4cwVQIYqlx9iDnrShZ5U4CfmlLe10CrJOxpnej3LgY89?=
 =?us-ascii?Q?Ir1x+DxZdjw9Q7Y8R2h3Z31lAnAP8VXvikOdlUu3dlvcFsDL1aX81IoQv/X5?=
 =?us-ascii?Q?kV4KnRHXYX6hdcPl1RxTrocxa3VQdVsnb1FSWRs/JVq8xo0+YhK9BTxYOt81?=
 =?us-ascii?Q?8mUM7DMcDMt0aWLksyW0azXJVkjnAHyd+sHF7hhgdJCYB/b+5TfHCnS5+hUs?=
 =?us-ascii?Q?dPGNe1KLubLv0IpdvXe1PMESbzcHUSgXAKbuMq0pF08tBCpMc31seBnqgUCh?=
 =?us-ascii?Q?PGDDM+W231DBXlFDyitGnnG6ajWqIGY/VlhMYLb1YA5cRzTtXlTtKVER8rWJ?=
 =?us-ascii?Q?0TKfJDx9pC8y09P4qrhC0pG1bPaUJ0ZF9yehaP92LtaU+vYSIQ5gpOuZVLOZ?=
 =?us-ascii?Q?X5kIOuTYr1EKPG/DMadRHb2lGk3XqlxdUrNJL5e7Qm2tAwbJHh/kP9d7vZ+5?=
 =?us-ascii?Q?tSw9KUbtnqAIrrZCQjGQPAVLPOnfhezsy+6VxXllCY1Lkif6IjoH0K99H8kB?=
 =?us-ascii?Q?etI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qH2DtkHKMPAcGmStG5wYbK/2qsGe1kj0BR3KGeTXhmvzYX3zZsKCVlcQ4cX1?=
 =?us-ascii?Q?f6tkJ6UJXS0UxUmo2aJ8lnk05qu5PYSuAHnGcMKx98opxa7WBIiraGQxZr+4?=
 =?us-ascii?Q?BqDrDVeEZc0oTiWocqSTTm37EWSWhJyacL4X37UiCxTBEMPULLkU/bZGB5rd?=
 =?us-ascii?Q?x3tmMd/+WGz2yq+FNOPVKgdn99xl1jBJnrb2KTU8x3wGT5EN0ssbJfPZvTmZ?=
 =?us-ascii?Q?NtS5QVNqKdyTzoXmfd8KDongVOsm/wm3f/bYBfQZNEwHDUz1sNcTABD2Uc4t?=
 =?us-ascii?Q?/u7XOhvhCBhpjze4h/KOMCEU0cxdCIWNj7mrAULudJHAZk6FbHNybFaYkvCi?=
 =?us-ascii?Q?lBd4CQ9MC2onCMlmxMrdOJvUA+NbzIznER1bM+HyacVNvuD6rM+fFhhcPLE9?=
 =?us-ascii?Q?abheDc/EFbQOhWDSK+h26QI829NCnmMRuuH4boZa6TkXFnT0QYmJ6GILkyc4?=
 =?us-ascii?Q?lCN+kJSCZo4dh8aQ4OLeLzAkuhoZoOXUnXunLq/BcXz/VFxkqDCFrY4VksFw?=
 =?us-ascii?Q?kqjVta8qiZ6SSkbxa5TB5fX1MWJtB3BkWt7zntNJPAa+jqABN1HFrA+99TSW?=
 =?us-ascii?Q?0T+rwyxfyfhT6N7pvfVTJ2i2G0gQf8yCvnWKbJRux2X+a/0w/U8cdpl7GEk9?=
 =?us-ascii?Q?+qHsVEuNFlYbjl+4G43hFa5GY9MeEqCi4Cx0WmaGV0QFxsiqq6dpw3+YmP7q?=
 =?us-ascii?Q?IdS26D8QCUnioaexS3k1UGl7gTLjJkuaclXb7gm8XOGJti+4F49XGjwWNz40?=
 =?us-ascii?Q?MZkhittUrmvWDaZm1+JbZmUCuOpgsN74zrN4xr2GpsNyz9SUTUmCt84zVgyf?=
 =?us-ascii?Q?CnQlY0u0SGrSLR7tC6Ui3CkRKSJyn53+NG+9mfbikmgB3dvYdfJPll3Y5/FK?=
 =?us-ascii?Q?KShYeGiYoEN9i73guM5Bw4DkNdG+h7ZbdOY7r027XIybdSkQqsywo9ZAJbKP?=
 =?us-ascii?Q?e7EfTb6pC+iuJF1fASz9ZrDGI1IKVcIQp+tB9YtMTGHy+QqaQG8cW8fUN+nF?=
 =?us-ascii?Q?w6YF/CNv1mvKshJcoEEI6E/+FrLyj4TMb13jDpWFuIhseeYmA4yqWg1KiDnf?=
 =?us-ascii?Q?HKV4NBMKVffYwYzjaMgx99/CEMoAzn67cnURJukRLILn2hWztbTBW45fAtje?=
 =?us-ascii?Q?YCICP3bEetf8++UH7U+pqeS++AflG5Lj0q7pme5SDCNrsyb3kEZ1eMrnMdmx?=
 =?us-ascii?Q?R0C/KMACwVY5uVVRCAKXHS1uvW5OwpgXMvRaOxdToM+7pdgjjbpM/E1ZJ9g?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cb488f-73b1-4fd5-317d-08de12aa21f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 03:05:05.6497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5947

On Friday, October 24, 2025 12:02 AM, Jason Gunthorpe wrote:
> On Thu, Oct 23, 2025 at 11:15:43PM +0800, Wei Wang wrote:
> > When SME is enabled, iommu_v1_map_pages() currently sets the C-bit for
> > all physical addresses. This is correct for RAM, since the C-bit is
> > required by SME to indicate encrypted memory and ensure proper
> > encryption/decryption.
> >
> > However, applying the C-bit to MMIO addresses is incorrect. Devices
> > and PCIe switches do not interpret the C-bit currently, and doing so
> > can break PCIe peer-to-peer communication. To avoid this, only set the
> > C-bit when the physical address is backed by RAM, and leave MMIO
> mappings unchanged.
> >
> > Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with
> > memory encryption")
> > Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> > ---
> >  drivers/iommu/amd/io_pgtable.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/amd/io_pgtable.c
> > b/drivers/iommu/amd/io_pgtable.c index 70c2f5b1631b..6f395940d0a4
> > 100644
> > --- a/drivers/iommu/amd/io_pgtable.c
> > +++ b/drivers/iommu/amd/io_pgtable.c
> > @@ -353,6 +353,9 @@ static int iommu_v1_map_pages(struct
> io_pgtable_ops *ops, unsigned long iova,
> >  	if (!(prot & IOMMU_PROT_MASK))
> >  		goto out;
> >
> > +	if (sme_me_mask && page_is_ram(PHYS_PFN(paddr)))
> > +		paddr =3D __sme_set(paddr);
>=20
> It needs to use the IOMMU_MMIO flag not page_is_ram, which I think got
> mangled by the time it reached here..

Could you please elaborate how page_is_ram() would be mangled when
reaching here?
(I might not have fully understood your point. My understanding was that
the result from page_is_ram(), regarding whether a physical address
corresponds to system RAM, is stable after the system boots. One exception
would be RAM hotplug, but this is the same for the case using IOMMU_MMIO
from callers. If the stability of this result is indeed problematic, then
other users of page_is_ram() and /proc/iomem would also be at risk)

>=20
> Though broadly this points to a larger problem, the iommu domain code
> should not be trying to guess if a mapping is private or not, this needs =
to be
> passed in from higher level code which knows what state the PFN is..

Please note that this patch is not intended to add an interface allowing us=
ers
to specify whether a requested physical address is expected to be mapped as
Private or not. Instead, it implements a sanity or correctness check within=
 the
IOMMU driver to validate whether a user-supplied address _can_ be mapped
with the Private bit (RAM is the case that "can" currently, and since the d=
river
can already determine whether a PFN is RAM or not, I'm not sure why it need=
s
an interface for users to tell the driver).

Even if a need arises in the future to add a new interface for users to ind=
icate
that the IOVA->PA mapping expects a Private bit to PA, a new flag (e.g.,
IOMMU_ENCRYPT) would be more semantically appropriate than IOMMU_MMIO.
The validation introduced by this patch would still be necessary. I think t=
his check
Is essentially similar to other guardrails or gatekeeping functions at lowe=
r driver
layers.
