Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012052.outbound.protection.outlook.com [52.103.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7019C566
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901658; cv=fail; b=PiUcySAkI9ungKGyKMfEMpXVp+rhQ9yBsj3KDFBKzkMTn+5DvpZOHxTqyXTk4YBCgR+OU/HA9eVUmruOypTKxpLcnGdm9WYZ7/BZJPUvelayAGnSWJ2N93E4Ixr+oSKc9kXKrAHnxC3pmG1UEJ8cPplLKf9RtZZwbxXQQA7jOpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901658; c=relaxed/simple;
	bh=ZVCorPGYYYdC2iy4Tlv5i+61DjwEu1LSEJlcnUYkDgo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nbEeOoEDtMd4yyJQiAxfkVI9ArDoWKXcmDuuH5AUiYKyruOzp0qYv5Gtxr90g24Y1BsO61ZkmA0xcvlaL3xLW/liIYuOAZg4fw7cUhXV9mFUsFGHo1WbXPBcSDGmafcEIyARHAiPn6jkfdN29YNOx0WaeMtbCT98THv9R3igSVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Cld+LoZB; arc=fail smtp.client-ip=52.103.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Cld+LoZB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnke7ZVTmGuK6hQqEjqS1PWXuBrWQGGSf4ozBZ3gB4oB9Amy9yXXwvoLFoOcAdLvyfA5cQMieq3iCSashoQkCV6c7qH4to5D961Ao1Va+QmwlXbza2dw9CtrXRfaGlCGbWLrpel8y9c03A0kNhRmTrKH7e3wPw4iAHxUiAcDeiiL9itddjslTUmGgTUp6Lm/TtgXKt7dYq6SYMtGU6tTDRYfoNZqt1Y4K+V7pBugdv1P8W/bu8isDnuKYAwg+1CujEOhVZarjpuLUY3dOI1sCpk8YUCGaaKqtYmQjkMP/aw93+9+HT5Q+if6tcSUg3h1z3Y3UZetMXBdO++mbHPqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhLP9Izg5n+YRhW++JdsYMaMM41BMTQyqjsF+1bE2zw=;
 b=eum4rrDk1DiCluA0pcOEKyqpekPJ45mRwHrihWvXyEmpcZzq6XR3BahfI8kvs0VTBi+3dXxLYYKi4XxNHeGFK4pjyQ5CRxiVIJaaMihhV3si8m+js/PUaDFbJJMF0w6OWpo+kLNRCOaCv9c/ZCCeD554H+sEamOqbWKfDT70W+LfLBYcfhsogYRWYh9bWAsQhZhSOVMEcf+M3Vnox1jm5C48fB/+kC88TYynVJmZeuGiKbSVxZXRoWhIFWmllvmOHTu7hwTL3LjSB6MYHzkhHKR4tpl2K8BkpouWdrxPgnqoBFT3FoIl/O5jyJa+HJ2py7D058KFoyAf7rjm6dOp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhLP9Izg5n+YRhW++JdsYMaMM41BMTQyqjsF+1bE2zw=;
 b=Cld+LoZBD8VRsJ1tq5EdItaOV4q7W8VyDGdILvLVaA7GINokE6Mb7ar3vnA2rsrZcVfrVlbk1Os5BHrtd5iBgfmk+CendzI1sctRGA7uha8LqTWblAVI6VE89WGxa1Vt3kbVTfhUNwbPgSqa1wQ2i54V0XL6UcFErRMavB3C9Kqp68WfcZxP7vZcJvWX5VjgBwZscyz99OzKs6w0g6fD9/vDYO3EBOoz27KAC/dM7oE5xxaFXb+tWvYgZmTK0dzHQDvSCG8x5M2rzeHAW1pBOPcOQRagC4CEMfOnKD6QuBNWoTK43SVUH0hhhrUH8pQh809mmOLK22d+qrE5cZWnDQ==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by SEYPR01MB4770.apcprd01.prod.exchangelabs.com
 (2603:1096:101:b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 16:14:11 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::5145:bf70:5ca0:ee19]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::5145:bf70:5ca0:ee19%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 16:14:10 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: jgg@nvidia.com,
	kevin.tian@intel.com,
	alex@shazbot.org,
	joro@8bytes.org,
	thomas.lendacky@amd.com,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	aik@amd.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v4 0/2] iommu: Avoid setting C-bit for MMIO addresses
Date: Wed, 17 Dec 2025 00:13:45 +0800
Message-ID:
 <SEZPR01MB4399D06A044791DEA8BE43CBDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::19) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <20251216161347.1380195-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|SEYPR01MB4770:EE_
X-MS-Office365-Filtering-Correlation-Id: 95682aba-983f-470e-496b-08de3cbe2492
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|461199028|5072599009|5062599005|51005399006|8060799015|19110799012|23021999003|36102599003|12121999013|3412199025|4302099013|440099028|10035399007|40105399003|1602099012|13041999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/a5i6fomZUORpfhRaDWOTpxUm2zAG6turl0dL9pzI7Otkma8kAnXEZW4fwKd?=
 =?us-ascii?Q?N4S9Xfd6LZrHxeDbdH1gGfEnzAjDqT3BBpyKJrIz1os5sO0queC9TCZ7EE5L?=
 =?us-ascii?Q?PAvCsAdL+IQXAM49E+8LcwNcwxL8a10AcdSzvEW6KBVCP7l9FhntytIF8+e5?=
 =?us-ascii?Q?+W4V30OsJW8Lbj1lnclvySLeGnraCUcH3cg621bmDaXWHO9hWHoWRPdi7vGd?=
 =?us-ascii?Q?vXsUabkwYRvYQlApYwm5y85qP3pXprKPxXOLLMtA7uPLG1Q3vGzd/E9h/Foo?=
 =?us-ascii?Q?kJRY/g0xn6Ex1NCEMCj86HHE10yFDg30eemzEfaQvgKAf1eYY1oclouhhFP0?=
 =?us-ascii?Q?TtGP0QDH3HeQRTJMG9BQ2VPuMSM4BnDFiXJb238U+eWPKMu1agb0HvXRtffz?=
 =?us-ascii?Q?cZXV3KzqCGcbu7wcGkrv/Z2uxob6v753NXIEnGITHzmShDdc8/6pLZm43fs7?=
 =?us-ascii?Q?ArjhB38XoFLI477e4B95t+TzDarxtrhEDL8Gn48YqlCNzZZP8EdCtD8gsZ2n?=
 =?us-ascii?Q?io22S/TqJXTVUli2tPFXKATQNqsq1ytT9Qwpb8TAEh2j9hgTvmv6DNHVIQet?=
 =?us-ascii?Q?EsK3BYzWs0wtkUZ4F+uXw3aUF+s0TucZtV++aSwHmDf1MES/Ij3yIpxfgeaW?=
 =?us-ascii?Q?h7oe7MJ6XXvKiFO1t5fYpgTIPvGW/pp3VGWjRrXJmHB3CPXAcn5VAX8T8f9e?=
 =?us-ascii?Q?SRkCLDvuSdfAEk/y97ndcqVl1FeFcf4TKENeJ6VWBhBkMfrCn8Q6FyuZP9GZ?=
 =?us-ascii?Q?1qWa0h4PecxLYjuPfMJR2j6TYpNaw46ojtV8J8TQJdlCMlM9aThkBEUIXu99?=
 =?us-ascii?Q?e2iGjk9ubCDvHUZVdIsCZhgewLvYS349SN+wvuHQUCwDGRuIP+Sw6zvqHP1K?=
 =?us-ascii?Q?qrTbFw8bYay33D6qJUMSe66kPTb+2ctqOgvCJueWLvAzJRssb2jbk3dJSYUT?=
 =?us-ascii?Q?TI1/wNOLzqQ28RYKxvyrpXg3cYwSZalrRy1fvmKp8J+pP+dyutRnokODWwOz?=
 =?us-ascii?Q?AJ6c0Qs17mpEbUByy9yw9htcVm/AEnMeNenupSrAV80d+OtcIHicw812vueh?=
 =?us-ascii?Q?HGgVlfZ9xX5+KErC82j8IHbiEZ2wJtXOBmmbpGWAnwVC43VvSRHxhGW9PaJC?=
 =?us-ascii?Q?2yrzx9rOSjEDxIdeClKtYfZVZHgGH8dYbbkgT4dcXwww+LeHaLxKobIRmOS/?=
 =?us-ascii?Q?HLUOmhCx8pnwDIEScE0fcseLvtYCHwDFNjmSFVaNqK20uWJckBYyODvF9Hxb?=
 =?us-ascii?Q?m/jq7JldEo/xLaQOBn5BtWmSzRjr3tSM4vkuBOlN1prDSKwz1NAojZS8c+HW?=
 =?us-ascii?Q?ZgGs0xDH3EpP6hSTC75qe70dT5Yhx0VB+eKOHjOT/uG4oK6zy39hUwzt4iqD?=
 =?us-ascii?Q?jkxKATHvMnRuzSZcvUlh/qa2xlt4eUkIHLZlMeB4yAIV6kv3aATYTdv+R/8S?=
 =?us-ascii?Q?V8Afyl80V80FpdMMJK/bAXe57Q3jrFhOUzwjL54aWYOupmVcnsnlwg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xgSwBPszFIpLdBtnxLlzT0jZp6QKAftP7kFYZJSsuBmRFytQ7T1Tmpi2e7b?=
 =?us-ascii?Q?kktR2vbWTHTmZUB4VaNpp3zxzVkJaRYPblqDUhcxtdgbuTu+8EvYz7Y+HlvV?=
 =?us-ascii?Q?ZhsrPL+AjjyVTKHb7wno/t+mHcJ3U5Msrud+ffLzAT7+98smQ3k8vMLjo6dz?=
 =?us-ascii?Q?cWm2ieWunmkbV4BDuGEAWTtBcA53GJKRvpx4DQTuAIk+CZakmMgS0n0Awsr6?=
 =?us-ascii?Q?JM3+t030hZNMecDDiUnAlpSA/9avYULfRLcCuk7N9qqKeIFCy/rh3OZt2Txp?=
 =?us-ascii?Q?denpX7Dpjvxbc97k+h88UMzq/z+e57NHmEzdF2WVvpT+TyMbDAarrgvdXnU1?=
 =?us-ascii?Q?Onj58FCGjAQPuE5BtDjGnhWpp4+NMDGkkGNJL3GMhivK8rGWDryGgXBjmvUR?=
 =?us-ascii?Q?YOqiJVs29Hzs6/X89vIaDdHVT/fM2+n59jEp4HtV1fJIfczwHndmjEm8+QbO?=
 =?us-ascii?Q?a39R40E16OzvQZiI4uVdxkzumnW4VC6ODuOOdHvDqoRWWCM2nMMUJQFn1SQE?=
 =?us-ascii?Q?WzU+3y8CbddgC1GVFpCYgWBsJIOduhDg1KJYZvxcEoDpBvqX2z1PrgfJZ790?=
 =?us-ascii?Q?RxzR9eQGxf53dYo/89VXFGArwuYAeBRr4PxvL/DFjKgXffTC3R/zepYy0KyS?=
 =?us-ascii?Q?UCNnQtF3q7Tb0c4oBsrMHSPcAA4gPj4z3mbB7PTF/RCX681RonZUTttvteRy?=
 =?us-ascii?Q?9PIJ0Yzd/IBL0jJkAvCQl3rSSIdSIrWGFuA82A6rRSWnx7bi2DbenncoaUbH?=
 =?us-ascii?Q?ydewdcPQelil3kQWBHdnMlH7QOdZRjqOt0gJOz7evj160xlWXHGJ7YKmt4lP?=
 =?us-ascii?Q?mckgvA6nZRy8oHAsOC0JLUxidMUZvnHbCBZMkDdBEMdEcDZIoakUrMLV/oyU?=
 =?us-ascii?Q?ZEID345jtnklHQZIaamGDSaCbUpmXxqevL/lIXxQqsSLQnZ/769dHySuwBUl?=
 =?us-ascii?Q?CBrYQoR13O3/5qOzU8tnhI+QQAHUq5Bouw/Q/JGinibJvl8G+e8bGOzH8fhz?=
 =?us-ascii?Q?HrkerEJzSkJeat06RV0E6bPBIqCqrIb0uu2yU3A8SIhFs3cXCH3XrP3bPisF?=
 =?us-ascii?Q?cNPJCFYGbDtYU40/32MCIVzShs2C7h0qJdkp5lHftkQnreV7zpi2MIbJLTh5?=
 =?us-ascii?Q?2wljp+bcXeDV6QpWgQM0YVRlsdRO8YoMZhD9udBpvjoYGhXi0Imea+JkKLQK?=
 =?us-ascii?Q?G8vDFqmx8IoBFSDn+vz7NXnZnxVLJ5/0FHShdI9VHWP8GKQj7d/ZcdlPU8s?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 95682aba-983f-470e-496b-08de3cbe2492
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 16:14:09.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4770

AMD APM specifies that any pages corresponding to MMIO addresses must be
configured with the C-bit clear. The current iommu implementation sets
the C-bit on all PTEs in the IOMMU page tables. This is incorrect for PTEs
backed by MMIO, and can break PCIe peer-to-peer communication when IOVA is
used. Fix this by avoiding the C-bit for MMIO-backed mappings.

v3->v4 change:
- In the 2nd patch, moved the VM_IO check into the
  if (is_invalid_reserved_pfn(*pfn)) {} code block to avoid checking it on
  error paths.
  v3 link: https://lore.kernel.org/lkml/SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v2->v3 changes:
- re-implement the iommu part based on the iommu tree which has the
  iommupt patches merged.
  v2 link: https://lore.kernel.org/lkml/SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v1->v2 changes:
- 1 used page_is_ram() in the AMD IOMMU driver to detect non-RAM
  addresses, avoiding changes to upper-layer callers (vfio and iommufd).
  v2 instead lets upper layers explicitly indicate MMIO mappings via the
  IOMMU_MMIO prot flag. This avoids the potential overhead of
  page_is_ram(). (suggested by Jason Gunthorpe) 
  v1 link: https://lore.kernel.org/lkml/SI2PR01MB439358422CCAABADBEB21D7CDCF0A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

Wei Wang (2):
  iommupt: Do not set C-bit on MMIO backed PTEs
  vfio/type1: Set IOMMU_MMIO in dma->prot for MMIO-backed addresses

 drivers/iommu/generic_pt/fmt/amdv1.h  |  3 ++-
 drivers/iommu/generic_pt/fmt/x86_64.h |  3 ++-
 drivers/vfio/vfio_iommu_type1.c       | 14 +++++++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.51.0

