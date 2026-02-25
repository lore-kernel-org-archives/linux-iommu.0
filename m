Received: from SVZP279CU002.outbound.protection.outlook.com (mail-norwaywestazon11020130.outbound.protection.outlook.com [52.101.180.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F632D249E
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.180.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051029; cv=fail; b=Htp2srOAJ0uCw65gewxW+aGbaTj5l1RgEAPcH3pzecwU+xAgr0WUCwvP6V9gOJbicrMky1EGhjT80/6PfQrh4/wiuoDW384k4WEsM/+45ViGCbiCK8s0w5oeYHbuowuxx2x99I9SlccF4vRG5TLIpMBUi0095o92a69BAdDp8Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051029; c=relaxed/simple;
	bh=tR4pezvEJ0GtjqFMPl8sbeqqfhK/V26DoQbqHLr2Muw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U1821WJsmjr8BMUfeWHyNlh+z9vMPkF6EDwD88ULKwWCx1gs2pfGFd57F+GabO17lDU9W6HycfXVkSO6StdsIH4dZ5h3IUmmew+I8BZnJUksdYyDJSqwjw6AQ8rCbBaXAL2fvid/Dw8xZ4BZacW71Im9W0QbySJ+APg4QYCuSwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=jEBjEQ6x; arc=fail smtp.client-ip=52.101.180.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="jEBjEQ6x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWsadE4ao1owxnW0KI6BxucZF5cIFD5m/WoMf2nGVdOgHJA1tLqkOINSHAzQ+Wyxx6tv/PLTPNioPT5Fdhqf6/crlWVSUWLU7EFzLSvy3mFthmddEdDHJ8cy7bF4AGjhjV4afhQBo5gLGP2XaisxaKIxsjIxecoNbTrzm4kTlbke5EvvefJVdYrb7umk8ROVdwUKdqb9ibTDfsEL68CrkwZ1QJC3xIc0P8Iy6DTb+jWeutD/Ru/cbO/6izHzE3BEIkaVeYGd3ErifFb3roUzwL50GNIbiFz1nJdPn/+QGMn4EFK2vrnYtlezsDVXEhKI9rJPNJ9/W48GId7gxdn0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p98wkuaHAnUn13TEjfgb61n1oWAiowT9ykd+fXjtxU=;
 b=NZ1U6OP/DZ3KL1lKrtbc/f9IlNDKqy5Ni6p/F3JXmwG9GuPCu2sFNU/Pr1UutRnzByksTYdb/vWQvluqo99psDrzA2/czQexJrl1OEWXi4YFnXHd561cKUPqSP/Lyju8JSwmNCMmzQNujeUDM61DK7usqHt//E3D9aDbgtKF4qewhf1tckmYIHFQOJU8SPCepJzLyTUqYK7tI2W7nQEbqKvkwjEA1G26ZtbaDoowxHGTkzHzHe2YAJ2pgZzTX/YfFcIqJPJVIvUKob63boqtT8VgFbKJBJ4kMf08fUmMyePnj3KmRjinO11Lm2573kAUDBYB0UbsWERh778XKoscxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p98wkuaHAnUn13TEjfgb61n1oWAiowT9ykd+fXjtxU=;
 b=jEBjEQ6x8QRPHe4L32LLW1LXxe8sZyXStST5/MyedmKs9VamaTwjHQtFDW+nVsf0psWPuub3092bf+mNI7FUr7kDMKEyUGR3Y4gCRfsVTZaUiskcNWffEQtfdQg4mIFt/TMaIy/sKkNOeu+OxUZ6eT2ZcL9bAmlsdRYJBtlcQ4q5n4gBUlPJmVPseAqCn0pha50wmr38jm8KZDVCj4gE9lxO4X+BuxOM/0PFttdt7AujVsUheQHcKkefwTDqs55QH7pRSd21bgAYx91T9S+uISeF+gL6OZoIWL6fB5O48ELO1YH5b6KYILLMuFlYJvcUbKB4a4g+Lxk4ObNXK/BVEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS5P279MB1039.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:56::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.23; Wed, 25 Feb 2026 20:23:40 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:23:40 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dhsrivas@amd.com,
	Magnus Kalland <magnus@dolphinics.com>,
	"Lars B . Kristiansen" <larsk@dolphinics.com>,
	Jonas Markussen <jonas@dolphinics.com>,
	"Tore H . Larsen" <torel@simula.no>
Subject: [PATCH v3 0/3] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Wed, 25 Feb 2026 21:23:27 +0100
Message-ID: <20260225202330.23027-1-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0111.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3c::13) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OS5P279MB1039:EE_
X-MS-Office365-Filtering-Correlation-Id: f71435df-3401-4fe7-c41f-08de74abc3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	3vDTuDHLBwUla5RPhHCZch5YylALJKYqIYnvx+xoAl80NmyoAJmTmgCqpRYfyD9LvVtrKRGLb+xBpgzb9n6vlDAzpoKaxHZ246qv7PTi0HRMTkaaXKPPT8moCPnCMaXAno/rphpKeavE9ZnYbZb5hPsDEDxJsKlpXwLpTyY9oXFgWgMllPfvlj0ZQJ7ZCyLtvBJt0F2Pw1D1bHzICopMrvgu6geUQZlQpP6sVBoA7mSfBSQiWi9WtJFucwoKU179vNFIt7fZXVfCZS6Rff84XLa57ymvEvJqsHAT3Fgv98VjCDJoH1KJrxIzs7amR+aT4GDvitFr1vLNDIBwQJG5GEHN7cTqkgeWHmDGd5yTi180aJN3VIWR2JjjHdLbLsZ9u6LJEMP5pAjwQReYarHPugrabzbZdviMCCBaM4Fb76wSX2Jfq6zh9XlMzGN2ZrpZXWgGBs1nuz6ZWi2C5zXJmvO/gjMzScYIZxBWxCu3UpYNjUez/9EPZaQ2ErPXY6xXoDNWihQ0YOYLCqz5qVabESEputs6CMunOYF/bDUZxHGeGYLfe3Hc3JWUsAyd5nF2Xek8ICykkGsDBs3Gfgrfm/0ojDT26C/3FonaFpnITYI6QjAWkx+tlTus0J6uqlxhMS5DSypHYI9OdcVfVWTASQYUIo7oISVm/PQxzQKSWPlpVW8kTfpHHOoiTUgEod6rbeVja+aCbUn2RQBbtTTiHEvk9s0jooYFtMXh6kiq10w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D94F4Redqwl0urZb6tdD7Z1eGgO5ZYqxe2IsA5lbPmupYjcw5ufrpxxB6LIP?=
 =?us-ascii?Q?JpXd0VfiD/F8LoAFMBqebqRf2ihAhuEvIrNl7V+zfr0I/QkGPE1kj2++XVnv?=
 =?us-ascii?Q?l5HJzhn7fezpiqd2eI0rLcZxQrPYXA1wwcW6z+ErC/Oht6T1Rlt0xYRk8Fqz?=
 =?us-ascii?Q?PSfXfvhjBHAdFbIzlLuEaA2OoM9rRmDevvIZ35sbAvJv2JdEBJdtM5GVC59s?=
 =?us-ascii?Q?snGDyB69E1hMJuIYMgU8t7MHCbigyQHKubKi1+iWZZftvG8A+poB1bkum7+O?=
 =?us-ascii?Q?P3cab/1Lhm3O/iX9AzQ/SPAvAdFnzdgkxA/7hmLlSj4D6uidLmUB9wXK1gZx?=
 =?us-ascii?Q?ce0oOUasQR9GQENWcTxtuq3JfSe948kuuUy//Y71eoYSXKeqrxn2KfkwpTSN?=
 =?us-ascii?Q?oY7DvbJQ6nIYKNfdterFuxmAJIJ+Dka7QJeo9HmOJ1HxR/tOYSdGQ09jjrDV?=
 =?us-ascii?Q?WrWVBTpzezuUKB3XvKVSnH5KS2tyy9SAbkQ8uK8fxssw2eTwoB2nktC++ltQ?=
 =?us-ascii?Q?3hJurshihRjHLbfIIIGosBm0TaadCClTYyVbuUZh61xRi1ihXlTtI+LW7c/z?=
 =?us-ascii?Q?AlKAm9lriCdVqKp0hqJvmXte+3f+Oi7LO9t7/M9yx9LdX/MCRVF5OqV0o9MA?=
 =?us-ascii?Q?b8SEIjOfA8co1OYJlp9ezMl+XIv946uPAQ0VP0oZhgkwonxoxX0lU9DxzhFX?=
 =?us-ascii?Q?SHd3Ta2qhT6MpjCsuVnh/1At+4RAppcllqkOKTG9D6VLn/RoR9VAIfhPhmx5?=
 =?us-ascii?Q?Vs6mkZ2CEdsxbYw/lDT9ArnpT1vQOglCdWjt+jRn2E4NveKJPi6o4SpZibEm?=
 =?us-ascii?Q?q4kXb3lsjsfM6tNOooSrj8dVa/+YVoluJ6kRjH+taumzRJbv/eo8HP1B7Epv?=
 =?us-ascii?Q?9kz1oLqdwxXSlHcBksMXFuASAAYhVFjcvc5hfNUBzdd/7XvaOE0SaZ0IKMFq?=
 =?us-ascii?Q?jYRK9mbveheRxfaIC5kKelxY1fNOKsodMtR3DTM4Z/egNqrBMTVtsolMTK40?=
 =?us-ascii?Q?K1dxp+3hNFGZgahwOS0ftEyy5drpQ75mQ8HT02WE0IcG2gRqWH2ovjgntNs2?=
 =?us-ascii?Q?TYBGif+AmwsjBACHtitnGoBCyRnbVc+5wSFKi55RN0WsWyJLFer8I2by60Gt?=
 =?us-ascii?Q?LFzS2yoNQ6Bw58Jd82LI79QtQgaCykygvd57rICq1DqqGfEQLv32p8iEZrUY?=
 =?us-ascii?Q?pTeFkvipupadCAtbgfEnb80GRkCI3KMNL9V9W3wfGdiiPmpP/aQHn7L78rwJ?=
 =?us-ascii?Q?IkzQdHs7qHFqIsxdGimFgMlRLJPBdq+g41UphRs11qpZfXK/AUyCptc6Dz5R?=
 =?us-ascii?Q?6SA/IYZFa2UtlZcHZfKDjoCmq7TxHJ/mbdqN7vlivjWwqgLH7u4K4MWiX6eV?=
 =?us-ascii?Q?CSgWu0CCd0achVfUY1xaaEV19JhFLBGFv5raHOT1aNOP3b1L1F73IV1lJKtk?=
 =?us-ascii?Q?hLqEGZQJM1VDd5aX8MLoqAyk7WYWT9RyXn3i8ggOGQ9N+Jk6koYCGAOh3JCz?=
 =?us-ascii?Q?LWfKZl1qbNYXPmPrkToWvQroqOHlKaFDE4EcsQpC6qZuUhZMpLvu2y3kLfcD?=
 =?us-ascii?Q?uRO2nfGJg/oTkdumLWHd5QttG67lZxpxAOj+arICk1KtKikts7UUv1HNQwxF?=
 =?us-ascii?Q?jVKD8qOjivHekZWp7RcF3RyE8WJHoRV+ov1A8XvdWcqhejKs+aiQseI6zWUH?=
 =?us-ascii?Q?gKAik6oKX/ME6Vap5gRX1dSRqEe/YXicQlPp2mfcxkLBqONSHlL1HLmxcg7M?=
 =?us-ascii?Q?I0kBkEu99CSd2dBNNsuvKi+OIvp7c8jZ9tAwvP3ntHFaUvm4nEsj3rsbhzfJ?=
X-MS-Exchange-AntiSpam-MessageData-1: UmAlme1oUpxqIw==
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71435df-3401-4fe7-c41f-08de74abc3b2
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:23:40.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1mmm5QqdAJNIskBNIqxW2a6/6ozVVYACvL/pzE1D1jHXEf1hjCoUI7uVF6+D9aiFaja2GuArD33BAHG4b8JFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS5P279MB1039

DMA aliasing causes interrupt remapping table entries (IRTEs) to be shared
between multiple device IDs. See commit 3c124435e8dd
("iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping") for more
information on this. However, the AMD IOMMU driver currently invalidates
IRTE cache entries on a per-device basis whenever an IRTE is updated, not
for each alias.

This approach leaves stale IRTE cache entries when an IRTE is cached under
one DMA alias but later updated and invalidated through a different alias.
In such cases, the original device ID is never invalidated, since it is
programmed via aliasing.

This incoherency bug has been observed when IRTEs are cached for one
Non-Transparent Bridge (NTB) DMA alias, later updated via another.

Fix this by invalidating the interrupt remapping table cache for all DMA
aliases when updating an IRTE.

Changes since v2:
 - Look for aliases with pci_seg->alias_table instead of
   pci_for_each_dma_alias since we can't get the pdev (lockdep).
   Track the aliases in set_remap_table_entry_alias. Invalidate IRT cache
   for each BDF sharing alias with the given devid in
   iommu_flush_irt_and_complete.
 - Make iommu_table_lock a raw spinlock to use it when invalidating
   IRT caches.
 - Rebased and applied cleanly on the IOMMU development tree

Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
Co-developed-by: Tore H. Larsen <torel@simula.no>
Signed-off-by: Tore H. Larsen <torel@simula.no>
Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
Link: https://lore.kernel.org/linux-iommu/26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com/

Magnus Kalland (3):
  iommu/amd: Use raw spinlock for interrupt remapping tables
  iommu/amd: Track PCIe DMA aliases in set_remap_table_entry_alias
  iommu/amd: Invalidate IRT cache for DMA aliases

 drivers/iommu/amd/iommu.c | 52 +++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

-- 
2.43.0

