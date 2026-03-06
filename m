Received: from SVZP279CU002.outbound.protection.outlook.com (mail-norwaywestazon11020079.outbound.protection.outlook.com [52.101.180.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60D33A9D3
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.180.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788974; cv=fail; b=CpVlTBuyO9lVmFJ8HwovNXcYvCfWJ+JFWk18s27yux7ib7F70zzxfxqYtK8ewFb+urYMrm0CmZiIPYb7AkzFz+MiVlOzrch1fIY9WGl9adRGAp8d5VsvWhK+fA9MeFzxcU+kGT/cp8CPnKlaoFRVoNmfn1xVn1HxbqcvBaUTyhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788974; c=relaxed/simple;
	bh=ZfJm2SO+lYprP23xZ3EslJF7eLMXhTNYzErQp9FNDUY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QuBq3iuhxdqJqMCpRsk9bWpxQkj/1OxM8FxvljWPcBYspfp1Qk/6Zuj3JRjbtWMuUjN4Z98FwOvcTTVLTFVHcKaPph3TGxK1D98Vi7GvRqDlFMjxzVR7a5fh7qjOMLSc25O9/8Kgf74hRyo5Uk4dA2s3e0tOPukLDvDlWqT7H/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=Q0N0s8/G; arc=fail smtp.client-ip=52.101.180.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="Q0N0s8/G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4fEBk0zn8zFMmYNkzeD9I+YWhAl5/5Fz38SwlstwXCeI5+nypZ/gc0JSv7hPBLVKGDjv1M48VKxnPdVJWDFgpCK+v+a+65XS2peZfS7XSYIAdylWG3kEVMLlBV/A0nuetYjrqw1LaBCIRIWXEHaFGi/x6kC7Y8RelSUiArwytAtHcqG2Zyeo+Cd6DvI6zmKv/+a5Z2Jc8tmgQI4ZVucQLSQlRXNGj+MFWB58aKDTc6DIdAn9BWde/YjerDD2JWITbi+3gLkq6ZoLuwpWjuIEPIcsLDEj9bM5IoCUp+S8SVS0iWDF7dKZUwDP0qOxnnQHN3kInN6JClNliHPnjIw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPNq4ob2zbym4OOMqAX8rGerN2PX3TUpxWSkV1x9/Jg=;
 b=X8Na/sc5jKJYZj/xXwDbVokKVgyzIX5+n5YxutTGIiCHx+CTNrRkxWvP/r2OnrHYWrpk5wdUrkMOamrpSXdzmAIoyahHkGRba0BVKGj0gV2loXTGKPbqKPHN33BKIuQ0eH3syH5i3R1orlUmCYWD/o6JRLQgLBcJ4uLrEIEHp6gfp3NDzePNf62/mLogX96HL1oYZw8eAZKnsC5mwMXpJBCdoI9oyiNk1cCPcABRRSYUiX8/uhdghCg3fn0ZKmR6z018jQERYzb1brJl5K1zns+XFrkZ2toJWAh15cfuxdQeR/zTrdQKUZdp0osnBYQgVp7UrajMs/3qVj0MHj5L0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPNq4ob2zbym4OOMqAX8rGerN2PX3TUpxWSkV1x9/Jg=;
 b=Q0N0s8/GHTIIveVEKpOo4dcV4u6l92CLCts/ht7VBERqsrUylYIQmqUwqaxLXMrJWK9KoY/7v8HUHncPLIPcdYMjlDUM3GfhGAepgI6HTvk91WJm1C2X5GVupVga9ELvyEsWap2ThNkbk1m8sNVFPSlKtjrQmiH7W7vAisavOf/81VbvkgaHrE0xzYaEm5qqzlFopoj5pSFuTH8wffMjzQOOH7+tCr1zJBpzTd2Il1OlaslLZ+aTBtJTEHabDLq56q3/T9RvooGB33WZExVwj4GaJxVYDjygzTuJSgCuLv5WZflV9eE6C3Qngx1NyJZQr2YZFH3v0wrSPWBl7KNOfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS5P279MB0536.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:20::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.19; Fri, 6 Mar 2026 09:22:47 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 09:22:46 +0000
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
Date: Fri,  6 Mar 2026 10:22:27 +0100
Message-ID: <20260306092230.132183-1-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0095.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3d::17) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OS5P279MB0536:EE_
X-MS-Office365-Filtering-Correlation-Id: fde3c04c-9cc9-4f07-8473-08de7b61edd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	YNMJoayl4K8jM+waKgLQPe+FkC0CF98zJRn5czOVFr97PUZlylU2MMdnSZIWCujoHtVfhvZNZODMd8TDcArY7PtZ1XJz/VB3u1c8ahrifhrzjujPX0/2QqxeteJgctKnGPf6V/apsGHe+384N0BAOYUfECMRE+li93fWxZsTbtmFGMMV496nUTPUahInrPTV0oidud+JeVCQ380IFv37MgnACd5xZx6Vy7vTmpv3uhF2tJhM3f0iiGlrML5WEK/ZFKz0fVh8BDG6PjL4iZ+BJ17/mY2oE1bhR44GI1kA3XOg7Ly9GcteekVcu2eGZ7GYp5opUO461AyMwEmAPIHVfozNN9oaB2vuF2VLUpHnIuXB5vVXlX4CMH2iXqdPBCiikjI8ztg7E6reXkSpxd1PO5nf/bZKrzkAR/DgIOPSHPJCMIdtUROYPWj8RGuKEk3PiJ7WpR9AGial8TIFtbAWaq983N4b2IHfs27kLHao80jxPf4mKdXV7tpvUQ0Ee4Vsiphwdno5QkkaW3tQUkAQH9The0dFEXGxcDK9Am/1+l9wXT253DnwsC530HAyEmWhR24ZxEaqD3yop1vW82ikW2lFH1PXOGYlbaX5+bLbjPJdz/5TiucHTGsBRauMTBnAb1jcnhQD5friUP6Mv1AgbudnKxajfRJZfEvImXyIemFNfJd8kB5R32OzZraH2Qa5RgT/iQ86R9YeZfhg4TkLPzZW7KSSGQg5ouwgL/sSHvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aMDMZits31HmfyHPLTR+HSGH576dJuzv9/nAFHll7zDgxC4Dytkpz60ZnUx3?=
 =?us-ascii?Q?/nEJFOm3dsLgehxoNkTiVdSq7hIfoRw44Xo3+5b8VxL0WG7xdii2VJRWJinU?=
 =?us-ascii?Q?xcjqboWC2hUGoxchgwQKeHRu9FfNC/xE4Yi7b3F0pPGgzjHMG3hLPKajpN5k?=
 =?us-ascii?Q?k5sdFPQPS5v/LXdmEFPkXLEzzAp1t4KcOYsGVme1y8MKfapdK76S3ZgLfniF?=
 =?us-ascii?Q?oFz5rb6BK0X3tgEXnYW50da/TMMfNlC56pJX1zXS/JLxUSYAwhnqD/0f+YFe?=
 =?us-ascii?Q?RgyO85EYPAKWezmG4OPEVbeZ1yVUJJSNNQDIzAvkUjZNxfUWtvub8/t7qPbN?=
 =?us-ascii?Q?rzffwT6+39rTpD6IYv3NgVOLRTCBQbxyu8ZJs8rRGx3NseM8/z9pW0a2UJSo?=
 =?us-ascii?Q?LS1pUW8BEZxlBxQfcw2T2SN2LZ9pBeonXx6gybmXajhc2u4Dt3JQEtcelCkz?=
 =?us-ascii?Q?y+7xGcC3GlN3fA5ajs9lFb+mpqdO61Jh+QIyPAvMNCwsjOj3YoV2ZyGYTPft?=
 =?us-ascii?Q?6Z/bA0n7bduN+WuO74x6uNQTu1PfLLoPGWRoDIwkir+sifC3Kp7whWhG8fvU?=
 =?us-ascii?Q?7BeasPsgMDxLt5l+6V772MD3cbgL5GyzGMuqKRGWMA4ad5ltSgoSsPSPn0MQ?=
 =?us-ascii?Q?NLDN/Y3UJrOjZoE1tBnxfvAQcyycbpntDSzj6BmEsXiHPpOAF53jLp79HvNi?=
 =?us-ascii?Q?qGHUCDRHgrbKy8xfKwryV1iC2/38ma4k0pDJqRxlfLq5ZmhBXuL719xfkoZp?=
 =?us-ascii?Q?6Pz2LctRZzrSLnO01vrQCKP9bpJfXmeHhiXeLc2ekbozzTouPOCGnr6WpAht?=
 =?us-ascii?Q?6nDDnO/3bCSnTpJ+dSCBDIlYh9kWM4InCVp+fllCVyPf5YcvUkWp3mzgwJKS?=
 =?us-ascii?Q?gJAqVEKAddZFZwztT6E8pzCCdhGHr3p3GT8oEBacOkSZ3LQRJwA65I07Tbd7?=
 =?us-ascii?Q?1ElJGTY2jfeZ4JmDpX2GBugQL4hVGxPXmKFslCbpuOZu5mSGpn6+uGttbove?=
 =?us-ascii?Q?X9nW3vTD1PEqFnugOm2yvNpp/grC0eqQN8SaIrDoJpZV1pISSgi2bOyukkiS?=
 =?us-ascii?Q?sK4APP/j4sK29nHEU0o2jSWntEaX7wGVzteowGqkn23llLYsfNP8UcG/ihM6?=
 =?us-ascii?Q?4oq6n2vq0LFzzyv0yWRlMW1t30GruXHex8TMmJ9xGNYufNXnkUqxLsIxBAcr?=
 =?us-ascii?Q?BuA0qjZyIGfflNcQq5ihGPMhhALaQX9PSfPhqSPImUhvmncTnqYWPBP/MnjO?=
 =?us-ascii?Q?qBbDtgCtpe2YiF4qyngfZC4KuYprusVd88Cjxnhh1vm6rjPASwPV1oUR8N7w?=
 =?us-ascii?Q?oQ6cIgO1mooeJfSuEeVZZRoBQNV8SenxlEb5CTqi/GRE6oQmJyQPt8indBoF?=
 =?us-ascii?Q?h2hTU2YOLjYmq+tqKTnrZW2X3THxFS3N1Zo49/Bm1jO/VVEGzOxkW1/545CX?=
 =?us-ascii?Q?QGNg+poUXqw/mqmXPBkn3j4VMf5sHb7q2ECyI9LjNX8XH5Ne2vvguLzoje/7?=
 =?us-ascii?Q?ZF/zxwM9c3jnCuyTHpc19rZ2IlL9Py2MsSEjqCL3jqLFX4xlq+MHAmlaKYTd?=
 =?us-ascii?Q?WQH+d4yZ1F/FZQW5azAG6Mq+msh0k+Ndrb0AazVklYqTG7szwxttcQ7I/xdE?=
 =?us-ascii?Q?4AcCSDTQw2Z4zV5x9yzuKTRb8tUu7QF9bw21h9VdOjhSzQHcpp96TJe0gVMz?=
 =?us-ascii?Q?gjQRu8bAd8KAfUjeB6ftIg2Dacjul9++4ULNW+Es7YNGNe65MYRmKv1rQHU6?=
 =?us-ascii?Q?/XdLueNG6w=3D=3D?=
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde3c04c-9cc9-4f07-8473-08de7b61edd2
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:22:46.8433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moJOc9IE3box+tZVD+4QPOqfdiY1lKoQeMUd/chdedQ22nJLc/t3UI7NuIQrgWfvOsMkrTnHM3mYPCWJR5ApEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS5P279MB0536

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
 - Rebased and applied cleanly on the IOMMU maintainers tree

Resending for visibility.

Link: https://lore.kernel.org/linux-iommu/26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com/
Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
Co-developed-by: Tore H. Larsen <torel@simula.no>
Signed-off-by: Tore H. Larsen <torel@simula.no>
Signed-off-by: Magnus Kalland <magnus@dolphinics.com>

Magnus Kalland (3):
  iommu/amd: Use raw spinlock for interrupt remapping tables
  iommu/amd: Track PCIe DMA aliases in set_remap_table_entry_alias
  iommu/amd: Invalidate IRT cache for DMA aliases

 drivers/iommu/amd/iommu.c | 52 +++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

-- 
2.43.0

