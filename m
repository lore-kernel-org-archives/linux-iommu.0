Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012053.outbound.protection.outlook.com [52.103.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDEE242D9D
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768798801; cv=fail; b=UK87mr0/hsZQGgXuy8LKGS6ynd0GIGNLz9aRzf6Cn8h5DiU7EBiTDH+Ct9vIOPtGZApD0nSRCJa5bqd49hfMsnOGiXic3d3b/vsPEBul05u+q+NJMgMP1SggBOhG3P3Jtlnw8JbNvrWOZmBV5Fjw3WCDGTF7wK2mBbk5nnMtqng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768798801; c=relaxed/simple;
	bh=F7h/vnATvG/Fx9CRPMEdjQCSQ2nsQwibg9NKB0SWhuo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IhMbI93Yxuw9bs2U5k5qxFRUZOCI5RsJ79QG6pRzKIa80Ltza5PtJaeFADMjTGPI2nn2Vox2FfXNlXnrVMXX1gELDLn0NEM0mDeGONOBuwJoBQreyQxdkTVkammUAEotKJHXlFSpPWIoswO+t498vHkhGtrnRGzsnPx/aw4XDgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=CFGPOChN; arc=fail smtp.client-ip=52.103.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="CFGPOChN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODesV3p7f/tkozzLK+aUVLRdCD9OAp9V98FNLjKhwVl9nWXtizwJsYrx3MhRVOpkmN5gGVduc+csKfkUY3AbRWOhGhWe5UFGfyP+h+F38xEmTLOoDOeEPOVLaTRTsZkElFz8ZHpKcU4DqlfQPv5YLJFxDanLpgXY4IzizUYi/Vv1iGHW4tC0iXBFL+jP0SnBNixbwIYZd+e1eb8X/yVWblC2FI0qUwtTlUq+AYSDHnAeCm24QVrITA1tutPFSBcnaG35uz8ejoBYl2jb1pyXZZMaSqVXIrz6Dhkc4fGEty1cPQf2WeDFRenc51hQ5MMAHoYFBPkIogMOl6o5mNzenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TThLexYQXfkcOspfp8nlnVL1E1yph21+1m7xx1uybg=;
 b=EQeKc5ReuLnKlenUeB1OXOJP3HRUGh5NnP/YWoClsJFLfXsFMN+q0K5t+s0PHGryjX9m4OxQ2Hq89MZncMeithFC7m5gSIAkJQOwJyaHBx4//MPf0yJsc89B9TksCKGj3/79rk7bv4yFpV68P2aKeU8acdkjc/S9UnYID9U+p67SOQ96VUZd81pY0FnH+DbLmtpjiFsuYu++irpPwqEQWmdRxFNH3YIGS7DaXDQzm4GrtLuyvE3fCzX7hoBi+a9lIW+nOSijMQ96M6+uRuPcd4cbjm6D85Wvu4Kkt1F5vK4te2ayeR/Ecew/a5MygH78tT4KWwbowQJwr4LMb7/Pig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TThLexYQXfkcOspfp8nlnVL1E1yph21+1m7xx1uybg=;
 b=CFGPOChN8PyCOdCi3CS/M6V0aWbupqzA5wy692eHXVicO93Ra//aeWdyyWANVZcvP1b2215XKtYR4Ag3bjR0vdlQOSifTxmnJzb0FTqA/+u8AIG38kFM+d1GEZNSp+0JzJ0vUi7Z1ZZgkdui4xPRguxC7AD/iutI/hPgLVEFOt7+p3irxL7LsK8glxEDV6YPPlDl7d91wwUx/89NIP2C7Uuuu+IjLziYjy0+h4Bvo4zpj5x2268Le0yzzuVfgqphfPqPy5V8nwXLeym8DhPvtPFJQ7U1oPXSDi2QaEExwxMpmHsP/12oBePs6BWwDJkJzWDru2MmKa8mi+oE5QW7cA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY1PPFBE0E41249.apcprd01.prod.exchangelabs.com
 (2603:1096:408::34a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 04:59:55 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 04:59:55 +0000
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
Subject: [PATCH v5 0/2] iommu: Avoid setting C-bit for MMIO addresses
Date: Mon, 26 Jan 2026 03:19:19 +0800
Message-ID:
 <SI2PR01MB4393C9B731ABDA050A336166DC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260125191921.831033-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY1PPFBE0E41249:EE_
X-MS-Office365-Filtering-Correlation-Id: 874accd6-68fd-4ab1-99c1-08de571795fe
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|15080799012|8060799015|51005399006|23021999003|19110799012|5062599005|37102599003|5072599009|461199028|1602099012|13041999003|10035399007|3412199025|440099028|4302099013|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jzbjyx3zSqNMqDsy8eQpsKcVyZX2c1VXytKwa7H0zS13ItMNqD36Fllh4YNu?=
 =?us-ascii?Q?fGrlrFmVfG1vfWow1kW+4RhHjXOlei9r8S3hIk6HzBS+z2I9Cekw9AeiiXRj?=
 =?us-ascii?Q?3XdJ8FPSbFPv1CHwQoIGJnt40geLTkrQ+AbNOtNVPCxTwLsEh8O+jx/z0dzH?=
 =?us-ascii?Q?egUnI54pTpNhj+kG9YrY5b8/27A0hEu30Q1BaOpyB4YQroE7JCNFvKULi4ol?=
 =?us-ascii?Q?t8HOhCiKV2gBMHByWrmX4eoftWEAcMiIGi4pPejQO+pAEUg4+Qf1DCdkUmAq?=
 =?us-ascii?Q?X7NjZsPE6G50jRAWCqNEMVfiCKnBDYRyIJjLo0MLMH8sOH7CE8ZvGKbCy7qw?=
 =?us-ascii?Q?inmL5fpXNWcO8TTClsWXlGvBqCxusJC9CmpiC8Xi+6QWMWx1u1fKuDJknToj?=
 =?us-ascii?Q?jIV4qYaAYaTSyqoQOxzcs/i9gi3lyNN/mVWr8lt4VeYGIBiytLv5M0NqkfZ3?=
 =?us-ascii?Q?BfTxztOsOkgXxu/pkcMFRgwqwNki5hgUyk1Em9ukYHQLwEDbQDrqIMHsUsHT?=
 =?us-ascii?Q?d6Ozm5cLRokW7scijg4xXrh6ZT+kbh+SXeTTOPcv793RM9pzocBhvVGuTYiR?=
 =?us-ascii?Q?d3fSWsa2o4XPYCNdM59r5HvrPOeEeR8mGGyKZMMErKMZZh8IxhLSPjw7KCU+?=
 =?us-ascii?Q?T1LxHHjsieKbvrejcXgxjVPBLcrH4GXbCTNMXY7c+TxP1Nv+GI8EfvaOkkcw?=
 =?us-ascii?Q?TB35F/STVffNQcXAdged2vQjNP53RLNNDY4qGNwDnUIwn3fo5vA3e41PuXXu?=
 =?us-ascii?Q?gcZkjiqQe92lvrjZjzB7Zv/7o0yB+nBNyo+i/XzsuQe9oh7/vSW2No3wQmWT?=
 =?us-ascii?Q?ZoVZgzBAtT1fAf4imwtKNS/MeidOqWlmFIFL3f7iSciYO5JeBblHvqIYA15+?=
 =?us-ascii?Q?jLDQlzZrkNBW6Ic/vaUd8oS3LDFBi/rxZV+zMFxgF0nc/Zs7A+p22zGjIRwC?=
 =?us-ascii?Q?Dq/j4l+zMHphCoAK3iOKqAXpYzV659M9NcGaTwxXOczQBbm+6lkqrsfXrBAf?=
 =?us-ascii?Q?bse7BtTUi49s4GMdl0b9Zo6b/PL/clqb/A9AOp/K+xriDapExgMfcQOSsJcp?=
 =?us-ascii?Q?sFn48nT5AMDWADCRIPKm/BqXTD2pqrn30MmTZNLhpZM7E/wI5FyODhIUp4Q1?=
 =?us-ascii?Q?xAtin3pXkw6Qn/ECOxfokLZ/089oI+eRb+rEKCx601um8pBhttjE4B181F8k?=
 =?us-ascii?Q?HckwtX6vOlGCgsiIIcDIABSG0DKYcCZZVSPuuV6k+7WgN5w4olLJUL32piXv?=
 =?us-ascii?Q?fYGh6Yd5l1un0F13vaMOvmPMadio3EeGVBJJcrnxV8QKmfG/1kxT4Ake51Re?=
 =?us-ascii?Q?n6JNR8Fq5e3d0Ck2CTRM8O4JYHLdZwQkL27YWTwqJxfJ92Q2L1FdX1JRi71N?=
 =?us-ascii?Q?t5VdG5f9XwAm5X+8fFbtRrN8fFG43Vp5v/YKjP4CZFRsD/SF36ctwMajcviw?=
 =?us-ascii?Q?QxctN08a2LqBoA3wUtZvOe1US8onhy6UKhiE31zjrCcF6Nbymj/7UQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hMnVY+cOp87987dPXnutEL+aaGbqw1lU6u7oB1Xul/zENQaHb7YiSWMQ23P4?=
 =?us-ascii?Q?82aFY0EpphltGvgBr++DZF824Q5DCnIrXoXNgIC2fWMXGCzoTUJ82yTK02oa?=
 =?us-ascii?Q?iZoqYQsRZbWKdv+0IsJliFOHEX4gSGqoMuIPuzreQNCszla+kFkOyCyXO+M1?=
 =?us-ascii?Q?pv1flrkFrfjAuFGluEeUC7m2pcAa1Ls6syPiU9LfpBWhdmsgIqvvXS0tLFe8?=
 =?us-ascii?Q?5+B7f3Z+kVsIagzC3Z+5XUi7QSLwk4kijxuYJHrDfU1LWNS+GSTHt4gY8Qpu?=
 =?us-ascii?Q?qf9dNk1yj0aej+mN9pPRt7J8/4z+eukFyV+Lf2rG0tyXGnnWKebFwdznfYJn?=
 =?us-ascii?Q?GLx0RVzmGgqmfZSYDU6VkVVdT2M14Z+INPZ9D0Y/i3UNNVlj1qJ40vYuDFfG?=
 =?us-ascii?Q?knLn4h8FTKIQ/Ay/ZW3H6gmO1iAhp7JwIGFpw5sJi1ldyWBZY/9scpJ/1Dyo?=
 =?us-ascii?Q?LNohHIFh7qaHd9tHuoEZEmHvdqLrqfk7A73afr3cwpXDO2y+xojuQRugF2iY?=
 =?us-ascii?Q?RPteN2MfmlbAJjdpQFi+sajeu1mi09DlZJHqQd9ZZ5WX1CgZ1wLyWbNd1OjA?=
 =?us-ascii?Q?FyvZyXu8oCGJVW4JjQKIeQQ29dQB5FBNVc1DEJr/7s2QFa5C0qV6IK6L6Ejo?=
 =?us-ascii?Q?eu3pONqM/gqrwjeN/4DLNjoD4kqCyxK5Wn7236cOgkMw22APfB9W510CYTIG?=
 =?us-ascii?Q?M4gv+aKaMSoAkwII/HH91bV3h8oif6CPfF3L1pJW0uRcGULjLzQN62OIJBAA?=
 =?us-ascii?Q?UcDCOxj73O2+CK70JRZfnWY++CYLtgYIaKY1jpGa+QfBP0LwdIlClfLXQsYz?=
 =?us-ascii?Q?I/h7FPYDClYV8uEYqzkd9mhlxffyUDzzhuHZAZDRjw/YR/H7CDJAvBmhn51c?=
 =?us-ascii?Q?lO2qqpZMVmv8MBm5wG01BddQtym34KWXkK4jBNthch/9brdetlcuPqPtfK5H?=
 =?us-ascii?Q?JJQ3LB6SSkWJWVd1mV20UL8CaH+GUUabqidKl7mX55PiygXUUHQZ1+dSsAtv?=
 =?us-ascii?Q?pwaimISjxLLv1isHl7yyQRE4KV4375URYLEN+lsLgi7AMjslkA6J6085rwxu?=
 =?us-ascii?Q?HVlKrbNqumH5gW1cjyk3IuqD93wq/X/1pv4MXPE4pndfLdR3LFH8G3/NemmA?=
 =?us-ascii?Q?dcBsWWvvGwtGdB5gUqjLs2AENylw/fbmRodpuuZ6CDXjTIn0LiVOOXEt95WG?=
 =?us-ascii?Q?oIAj4Mn0QbZFHWSXMo8wqySowMye9BCF9INzCPH6uMnJ5Fu7oC8awqqUP4eb?=
 =?us-ascii?Q?1fMWrQbdGFhFmcdfs7LkmXsREDDMAG1b+HQ1eftzllOkFPyKLP/RU1hkltEz?=
 =?us-ascii?Q?PGUz/fYPi1ZDbLf8+fGY7GxNp4UhZlTNI4KTgMSMe2z/GGyAwT+s7vq2THir?=
 =?us-ascii?Q?qTA+QNzQZkkY5Nm09o/wQ4f3eDDs?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 874accd6-68fd-4ab1-99c1-08de571795fe
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 04:59:55.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFBE0E41249

AMD APM specifies that any pages corresponding to MMIO addresses must be
configured with the C-bit clear. The current iommu implementation sets
the C-bit on all PTEs in the IOMMU page tables. This is incorrect for PTEs
backed by MMIO, and can break PCIe peer-to-peer communication when IOVA is
used. Fix this by avoiding the C-bit for MMIO-backed mappings.

v4->v5 change:
- Handle the rare case where adjacent RAM and MMIO ranges are mapped in a
  single vfio_pin_map_dma() call. vfio_pin_map_dma() issues separate
  vfio_iommu_map() calls for RAM and MMIO, and vfio_pin_pages_remote()
  sets dma->prot to indicate MMIO mappings.
  Clear IOMMU_MMIO in vfio_pin_pages_remote() when !rsvd, since valid
  MMIO mappings always have rsvd == true.
  v4 link: https://lore.kernel.org/all/SI2PR01MB439311868FBFB7DDAD19692CDCB4A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

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
 drivers/vfio/vfio_iommu_type1.c       | 15 ++++++++++-----
 3 files changed, 14 insertions(+), 7 deletions(-)


base-commit: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b
-- 
2.51.0

