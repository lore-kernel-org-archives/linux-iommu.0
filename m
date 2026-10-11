Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8639C00F
	for <iommu@lists.linux.dev>; Sun, 11 Oct 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791718020; cv=fail; b=pYALyOpf1A54e4JSUNRml2BCrqrzM8Jx70g5bU4ioFcTNMxuEjvP7VYfaKpHoVtxd24H8CPHLpk4vgKInkr80Db7WT2MPk3bDf15MQgpPbHyv6mxagpOUsCZMP67fbepBvWdYGcEOq83UA8ghFAxtSiwJBspL9mreI6nm3dLHXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791718020; c=relaxed/simple;
	bh=xP4TAvsXiZQofcRNYiiMmmNv+xdQMEpcH81QZ23YqRE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=O5ofSjk0rrwC4E+HnDtJN+b/GG88/fGhoDIdVd6sj6pWbh+/grS/SCw3NyUkefhSPoJ0/GIFBAxWQLVL2aX4FVko/bqqyvIcjzEpcUT+DhB+DWtFsYr5EFr0jM1+pGc12ccYcQD/k5rLpmCdV/lFLKB/0pzpaQ0EISC4i93tu88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VK9cF9xB; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VK9cF9xB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjODp9PN9n0eFFdj7DWlkFdMC45O798gfEWBRLm6pcMGWhJQ2raBwqUhg1nHuw3BQBf8GOMOzJpmaajECTrLDu+smkm5n1WlppAMBgvxDMBchDv9PfkR49jmbHwQXMptvIOybdeTcaAQaKnLc+2JQz7WT9Tc39toQfiP/eOE1/o6hctpgXMnegibsNNEauSOUvbqOALvkK46Lf8jfCZRoK5LTqXb9No+CS0sg7WuZaZZ0FFOlI78FItuoJGs1aG1kAz/Ho1IlveUCewxUbgx3PnUzmvSgcjR9YL6nvcuw1hmnywsR3e8qqzkkB9bnZ07Q3/OjTHaTZ1HS/KiAQmMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB0eG+67WrOD+nu5Yl9dOpljx02bmMiypblsUT25l/o=;
 b=HN/TA3i8bTWfsg/jX7Rp8IKGcG3/qQc/XUWxwFzQc0KTwTLkNGsoRxjDnaS8pidaDiVtiW45ZRtQvfQS0793FDuT669BlIf4tN8HRWgl3yBmDh/H5QTRjbDE6cGwwDf7xd2pVPzxY1Ao3pyBEeVuh/S79po+2aUkCpU2Ymp58Be+beKN+KsNwZlwtx6DJdWXNVed9fLXll2rIox4c4ALefgyXbpRjqiJtWkLtXHugXg6Gw5XVvUV10tfgGqyY2aD6t6ywu0IXnLwaYfpStxuC+YpYOMrCiFzoW8z0sKlQq8RiRtrEY1ILXEuQZLPNrkAs+iyFwB3kr/TU459xt+AkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB0eG+67WrOD+nu5Yl9dOpljx02bmMiypblsUT25l/o=;
 b=VK9cF9xBW0BY/2QyQGVPtVLwaoptwEU2vQTCNGQDQuDrwfXSTZa0u0QxOGHM1Qui+85EYxpwXfMPp375kyEAiP20/UggJH/EdHhJyckHmiIwDzgRz52LkJzEvOr3qiniLSdwGsfmLtx/9+5HcGnoK6wlJurwIhtX5yQnqDYEWkL1zDjFSN1JDZDLfqi7gXy+omfVo6uuAF01ycpt+1gILPmqxz2BlF1Y8HzKP3ukqcRs5jkliAu5OrA3Y7RzMED30IFvgVtiFbVyrem8kEGlGjvhYanxz6/5t99TS43lWv8nvjfCXCtTXL618KNqMM/IRNoB9bl3nHXeFHLSo7pIXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI2PR04MB11171.eurprd04.prod.outlook.com (2603:10a6:800:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 11:26:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 11:26:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH RFC v6 0/5] iommu/arm-smmu-v3: Support shared Stream IDs
Date: Sun, 11 Oct 2026 19:31:24 +0800
Message-Id: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIxzy2oC/3WNywrCMBREf0Xu2kjSJmnrShD8ALfiIia3NkIfJ
 G2olP67bQTd6HKGOWcm8OgsethvJnAYrLdtswS53YCuVHNHYs2SIaGJpAWTxNf1QHylHBrirSH
 I87yUmhteUliozmFpx2i8wPl0hOu79MPtgbpfXeussr5v3TP+BhbHfy8CI5QIlqU5F5QrxEMzd
 jvd1tEdxIdmlP6gxUIzWShRaJkxk37peZ5f1NHtVgEBAAA=
X-Change-ID: 20260916-smmu-shared-sid-e488f6c4d4f0
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: 837146a8-7ac8-4f99-b281-08df278a8cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|11063799006|921020|56012099006|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Jbg9/PG+kM+q/Z+FH5FHbOVSYfKm0AnSMumu84EF0O7xMYp8l2Vr5sbqXiA+Mpfw/8I3fd/toPC2I61MFOj6glBBTthTjBu5Y4oKETTu0xmg2+BtvzhcdkpSri6BxgF0m88mDK9KkFoaeXT8NKPV3CUI1j4UT4V3eRUcAl7UXMjS84bgWYUkd27ULNFu2zT9xDCCZwgxiVF0J5M3KFFIuOm2AkEx9pisWLcyRDcep2ehE5lJdTn+qOPgDimgMfuOonvdQlWhL5p+cH+UpmoOMBJYTBZ+O+znhXu47Pcp4h5lvBXCSUFVNltqJbc4M4s1K8Aq3BwXyZSWcpqEH83UZriq86VX2K84ItNhK50VzwD+7VPMznO98IlHvbS5kKNU9ha0cQXOR1ns6VxAkleEkkBthyooN4O+7OMntsRh8DdFwURbo4pn5yu5U1ccLjO8+c+Al+/XuXFFzzti/H+6mG/QWzLGe+OhCeVlOygc0kFhN/13tJvAlhp6UYo4jOEtewGVZTxV4V4jMwpf7UuRuLjZMSP6zKON94qc0Zmjv2GiZHwNpjyJOv2QrnmivQAt4CKJY6/sn9GyXWb7URv6nWzHgPL9vWjOSppyOVU9863+6xoL6vEdJs9NIW8bjTvYBXNs57Z7adsMKTSc0I8j2ydjSZE7EB3GxiE1H8R9asA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(11063799006)(921020)(56012099006)(18002099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE9nbkprZWR3Y3RjRDJnQU8xVVd1VXhSTnM1K0VWdlgvTUZlY3NidVk4eGZy?=
 =?utf-8?B?U2ZkcmRUZzVYS1lUYUU3c01NNFQwMzNRRE5uNm9oMmxWTDJkc3k1S292U3RC?=
 =?utf-8?B?QnZKNmtpaHU3dnYzdWFkTHpmazU3OHdXVVMweWtOR1dBMDY1eHZmaGE3OVpu?=
 =?utf-8?B?UktPbDRaSzBIdURURXpabTBOajU4ZXdEM3lqOWo4UnhGdktUQU9sZlkvSThK?=
 =?utf-8?B?NU9wZkVKY3pSTnpDWmR5TVkySVJhUURjYnlyQVhFK3YvYVYzOHhZSy9Bem1O?=
 =?utf-8?B?MTJneXg2NDRMd004QS96Nzh5NE00NkVFaGhjU29LWHZKMjFRdmtNVzBFbnA0?=
 =?utf-8?B?QjQ4cHMxSy9IRmFJdXNiMnlSWmoyVjAvSGNLL1VMcWhOTWdLZVBMemIrd2dH?=
 =?utf-8?B?ZVp6MlRSelY1S1pncGwrblJLczZVWkdFMzkvMXZuRUV1ZVVBa0Y4cnBIMDY4?=
 =?utf-8?B?ektqTURQUTdYSzRZVzFST2Y4cHFKeE52aXF6Q0RyL0ZPTWVmZzYzSjd5aTN2?=
 =?utf-8?B?bWI5QnNVVzlZMjhWaXV1RVIwYkUxM25UbjUzanl5bGp3ZnI3cURkd21qb29J?=
 =?utf-8?B?aWFWUENXYzhQVzVYMXlDMnl5Q0QyK3ZiUTlpWS9zZ3dBQnpMVUJaNHhOREJV?=
 =?utf-8?B?RnZMeXM5Y1UybUFHSks1bFRuK1F4bGVkWmdRS2M3cHFObzVTL2k5UUlhMW45?=
 =?utf-8?B?V1Y0WjE0TDdISmtWemlhTVl4NVZGVTNGOXVSOEthUXkwUmQzeXZSK1RLSCt0?=
 =?utf-8?B?ZGlTVjV6ZVhFSVl3VElSRG1CYnoyZjNSaTIrMzA3b1hiaGdqeVFhald3dE94?=
 =?utf-8?B?MzlrRG1SZHlvSGtjNmQ0SzdqT2FKYnZDVDBOVkdtRWhKc2Y0d1hmUDFCU1h2?=
 =?utf-8?B?UXRZSHczM3VUajNzYWE3a3R1UVFIbTM2Zk8yNWt2WmtDTnNBQzFZK2dBaWhF?=
 =?utf-8?B?ekF3eW1Zc1Vxb2MrNldrR3NZbEpmMFIwZFBQS3RsRmdoSHhrdE15NmNESmY2?=
 =?utf-8?B?QkVId3paam5aU08zUWEwSWhNVzZDWnVQeUx4WldhWWhFeERhMndqM1RlQnpT?=
 =?utf-8?B?OERrZFlKN1l5UUR3TkUxV1ZWTCswZU9ISFFITTI4c2drUDI3YjVuTkw5MmpF?=
 =?utf-8?B?ZlZzdVYxMy9tYWxkRVU3VDF4YnNBcUhKM09BZ3RoblNTTHRWbG5QY2JqVnov?=
 =?utf-8?B?b1dFbDVhOG80T2o4T2dRV3FmaUtCdW5tTTEyREEzOGNuNFc1eUxHZm9XKzdP?=
 =?utf-8?B?aC9XT054d0VOallya3FDVG9VanpFcGRCc1ZJQTRqcEtGeFMvK05nVStqWVdL?=
 =?utf-8?B?T2pmaGhhdEYwZ3kzcEx4Uks2b1Axb1NMV1RKY0tQWWRwSWt1cUwyU1BZbkFE?=
 =?utf-8?B?bjQzaGdSRFhZYzlWdnJlNU0rMVR5dm51V1l0TkhOb3FUNjR5dG9saksyNmtj?=
 =?utf-8?B?TGlDMG1NM0hOdFYwbkZIMHFBNWNpRWhHSERzUXRFMjZiZnU2Q1FibC9jOFZR?=
 =?utf-8?B?b09MYkpaUE9aQ1U1R0pPcE9SWHROWi9Mc3l5dlpPVHdDUUJLL2JKcEFnUTlj?=
 =?utf-8?B?OWZCMVJXaG1ZKzdkVEJLdmlmVnp0dTg4YjlpR0lpVUdzYmpablBaWVFwQXd5?=
 =?utf-8?B?TWhrQkRaandUa1lrbkZHM1M4VFRKMmtHSnBlZGRJVlZIVHVkVXdFT3N0K3JP?=
 =?utf-8?B?UFF1T2ErTFBtWkVVcFNGdFNrNlFPQlV5bzdETkF6cGJwY2VEZVUxMTR5NmRs?=
 =?utf-8?B?Vi9jUUc1S3RNeHliUjNpMlppYmlURndhM2p3SUFNa2tZMWYzbFdMcU1jaG5n?=
 =?utf-8?B?dWNsZWk0cFR5R2lvTElid2hnVWdVcEFubVcxUlpTN0VCc0VvRFlNREVWZnU2?=
 =?utf-8?B?RVdUVW5xRUxUUC9Oa3EzcXF3YXZWOUZrR0Q1NFhzamJITFNLMVN3VEZVRWdM?=
 =?utf-8?B?aDB1REs5d1NHb0VRSC92OUo1SHhOcUN4a1ZTVHcxZy9pZEJCMVU5eEtxL3ho?=
 =?utf-8?B?TnhiTzYwSHV3MTFaa0JRTHg4Z01BeW14Q3RXcVlJanBYVHpja29SY3hOVkFG?=
 =?utf-8?B?dnBNNnhmeiswS3RnR0pCYU1hMHFJbW9ISW9ZT2RUaWhsaDViRktOS0JsNHFJ?=
 =?utf-8?B?djJMZUYwRmlIS3VMOUN1WVhJbWRFZ0poNkpNME5DUTY2U1NlRXl4bFBFZGtl?=
 =?utf-8?B?Szc2VUo0UmdkTjNsRzQ5cW5EcVBWOVNxSVd6QWY4RTJJRUs4aVpweXlqUjUv?=
 =?utf-8?B?MGVqbFA2Y2d3Q2RDRWN1Zm16VFdaSnRWMVhRakhrWlVMVkt4SXgwNmF4bms1?=
 =?utf-8?B?RTQwMTBSVFRleWJzdk5MTWlPSkEyYyt4RFgyWDVlenJROWpKR1p5VExlWjhG?=
 =?utf-8?Q?v8nXhoF45eUo1lJMRoouN2MtkRlyByFHXHAVh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837146a8-7ac8-4f99-b281-08df278a8cf2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 11:26:53.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hP4oILOkRdN2E7fhB3EtRwuwGYBvFVwOeoagOi8DlzXpCwlD6O1Y6WwiqruyH/p9hF4NM5wV+SarRgh5FYovur2nd5Kf6y5DN0Omvz8WJbFrJ3Mo126q1np6GacQ16IV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

Changes since RFC v5:
- Rebased on next-20261009 and drop Nicolin's patch
  ("iommu/arm-smmu-v3: Don't rb_erase() a never-inserted stream node") which
  was already in tree.
- Actively deduplicate Stream IDs during insertion instead of
  storing duplicate pointers. num_streams now reflects the unique
  count, eliminating pointer-equality dedup loops from all cleanup
  paths (Robin).
- Extracted arm_smmu_find_stream() into patch 2 instead of patch 3
  to clean up the find-before-allocate code (Nicolin).
- Extracted arm_smmu_free_master_streams() helper shared between
  error rollback and arm_smmu_remove_master() (Nicolin).
- Fixed remove_master to reassign stream->master when the current
  owner departs, preventing dangling pointer (Nicolin).
- Fixed remove_master to use a for loop iterating master->streams[]
  with per-stream shared vs non-shared handling (Nicolin).
- Reset ste_installed on ABORT so domain transitions (e.g. DMA ->
  VFIO) correctly re-write the STE instead of freezing it.
- Clear stall_enabled on the first master retroactively when
  sharing is detected in arm_smmu_insert_master(), not just on
  subsequent masters at probe time.  Prevents bus lockup when
  the first master probes before sharing is known.
- Link to v5: https://lore.kernel.org/linux-iommu/20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com/

Changes since RFC v4:
- Include Nicolin's patch ("iommu/arm-smmu-v3: Don't rb_erase() a
  never-inserted stream node") to avoid conflicts in future.
  so the standalone patch 1 from v4 is dropped.
- Split old patch 2 (shared SID support) into two:
  - New patch 2: Convert streams from embedded array to individually
    allocated objects (struct arm_smmu_stream ** instead of *).
  - New patch 3: Move stream allocation inside the mutex and look up
    existing entries first (find-before-allocate), avoiding unnecessary
    allocation when the SID already exists.  Pure refactor, no
    functional change.
  - New patch 4: Add shared-SID logic on top of the refactored code.
- Duplicate-SID cleanup (bridged PCI) now uses pointer-equality dedup
  instead of RB_EMPTY_NODE checks, since streams are no longer
  pre-allocated with cleared nodes.
- Link to v4: https://lore.kernel.org/all/20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com/

Changes since RFC v3:
- Added a standalone bugfix for duplicate-SID rb_erase (new patch 1).
- Stream structures are now shared directly between masters
  instead of duplicating them (Nicolin).  No ref_count field;
  sharing is detected via list_empty(&stream->shared_masters).
- On owner removal, use rb_replace_node() + list_splice_init()
  to transfer the RB tree entry and shared_masters list to the
  next sharer, avoiding use-after-free.
- INIT_LIST_HEAD(&stream->shared_masters) moved after sort() to
  avoid list pointer corruption from bitwise memory swaps.
- Both sides of the sharing pair are checked for num_streams == 1.
- Link to v3: https://lore.kernel.org/all/20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com/

Changes since RFC v2:
- Dropped the RB tree to XArray conversion patch (Nicolin).
  The RB tree is retained as-is; a new arm_smmu_find_stream()
  helper provides stream-level lookup.
- No per-master shared_sid bool; replaced by
  list_empty(&master->shared_masters_elm) (Nicolin).
- Only SID-sharing for single SID device
- Follow Nicolin's suggestion https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
- Link to v2: https://lore.kernel.org/linux-iommu/20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com/

Changes since RFC v1:
- Revised cover letter to drop eDMA channel example (Jason).

Some SoCs have a limited number of IOMMU Stream IDs (SIDs) and
hardware that inherently shares them. For example, the NXP i.MX95
only has 64 SIDs, only 6 bits for SID in the system chip bus.
However there are many device IPs, such as SDHC, PCIE, NETC, GPU,
NPU, Display, VPU, ISP, ISI, JPEG, SATA, DMA and etc. Each Kind IP has
mutilple instances inside the SoC. So I introudce this patchset to
support shared SID.

The current ARM SMMUv3 driver rejects this with:
  "Aliasing StreamID unsupported, expect DMA to be broken"

I took comments in [1] and implement this patchset and only want to
support a very simple case that multiple platform devices share one SID.

Patch 1 converts the per-master streams array from an embedded array
of structs to an array of individually allocated pointers.  This
prepares for subsequent patches where multiple masters will point
to the same stream object.

Patch 2 moves stream allocation from upfront into the mutex-protected
loop in arm_smmu_insert_master(), using a find-before-allocate pattern:
first look up whether the SID already exists in the RB tree, only
allocate and insert a new stream when no existing entry is found.
This is a pure refactor with no functional change.

Patch 3 adds shared-SID tracking so that when a second single-SID
master registers an already-owned SID, it joins the existing
stream rather than being rejected.  The stream structure is shared
directly between masters via a linked list.  On removal, a shared
master detaches from the list; the stream and its RB tree entry
are kept alive until the last master is removed.

Patch 4 places devices that share a SID into the same IOMMU
group, ensuring they share a single IOMMU domain (required
because one STE can only point to one cd_table).

Patch 5 wires up STE write ordering (first master writes, last
master tears down) and gates features that require unambiguous
SID-to-device mapping: SVA, IOPF/stall, and vSMMU nesting are
disabled for shared-SID masters.

[1] https://lore.kernel.org/linux-iommu/DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (5):
      iommu/arm-smmu-v3: Allocate streams individually
      iommu/arm-smmu-v3: Delay stream allocation to inside the mutex
      iommu/arm-smmu-v3: Support shared SIDs in insert/remove_master
      iommu/arm-smmu-v3: Group aliasing devices into the same IOMMU group
      iommu/arm-smmu-v3: Wire up shared-SID STE ordering and feature gating

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 254 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   5 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |   2 +-
 5 files changed, 185 insertions(+), 83 deletions(-)
---
base-commit: 581e50f62f59cba2e33c72ca119d3c3f797aec9d
change-id: 20260916-smmu-shared-sid-e488f6c4d4f0

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

