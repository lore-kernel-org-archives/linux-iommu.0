Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012051.outbound.protection.outlook.com [52.103.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF24272818
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178462; cv=fail; b=pCicXM9NKl4o7czPgz+8rVACMeig1OPpvw1PCPsnppfU3O6+TmSzNSLyXReHbZGPkWI7OGKFRl/i7sfwGx0EJnDpjpWzX8y9o6d5cx7v9bP43IFnXZZpocT8UxOU9OEgk5WnNLb8r55S6p+t0462uq5zqEPOJi3w1kvFkGKAlck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178462; c=relaxed/simple;
	bh=MstXaMTQI67lSbemV0PhZpSB4xVHpSWSnq2Fq734xI0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fzZ/yL+bdXksARvxUcEO4pGlk2Gs09qM8yowDjlyxcW8fUkT+Q7iBZG7IEGxebkKC90CspqKmnEu3N6z+iPsucJvykVD1aXWwdJV7VkqNCdWf1V1JqQnEGsR8cdi5g666eDyPS/BilVOT6zR2OWtNYMLeXmS2KWMQsRAPQQmpIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=EaON4hOM; arc=fail smtp.client-ip=52.103.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="EaON4hOM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTNqo2G/vxSePyn06PXl8GO6Abm6ESpsj0CEnBv/AyszO7p0oDa93OeG2/OVyIrvdIrW5VseUDnhHiEGQaSc+z6nucvzEw0USrHBSlsMfr/8w6GG+lOYgIQGZuOdHxAK5n9vrRPlTsuJL/hsO7GwoGGu+4HgUhSzfeE/eVO6T+7h7gAXSPv7aAXyPiUWnl0/FNOdoeYyIxf0tn2udFrdVKo4PmgdB/uC6YZ32ofBBGDYRJiUy1WpX5yNTJjYsAs43QzCUvlnMRcyiumcaUV6s+2HSpS2BCoYK0hFGg7Iy3g9HwVjOaqKaidUheWf108l5Zc16FxsC0AWWogbcBFgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIL3eE5NMKknL7ijmnS2WLNpaRKVzpiCE9/+hQnB7NY=;
 b=WkyoKZZLfKRuVGqrOr+BI3MyzHXudz5WRNmZDb+Ec4djLQFa4OCLiWDFEeKJlEZUR4Ed61/qoMp/0KpAH8Ywo9lJDWXEXoN0khztT4X7eGz9NtPiCzbDU/NQrqbtMvOPSUXo2OBbDFg8d2xsR+KNT3+SyD3cie89+ndadw+xevtIEFbydIBpLr58WHUD+KgILOVXssvAtgRTe9/V0WdpsIgxlaMRAfQB00/PX003JC9xfxXC5JkA7lg3P3xJhISTToeo6Dm+qOe6ZdbGI9+RqO051tEtCFjO6xodiXt8OOluJLQOlFgHAIRym7r6/RBXwlbTeiCJyYecGo0admu6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIL3eE5NMKknL7ijmnS2WLNpaRKVzpiCE9/+hQnB7NY=;
 b=EaON4hOMD7a13Y2FaHXgTpDhlveaJSRdpWalQTmk9HpFLQF/7W/AbhVwALCzxUTeSMiexZ7dw7TgYIQHpSo+tIZreIMzo/EsBPVIKABaloVRHnyM4z3N0LAU0GJoy8FTuN+75OAfwwvKRZwl2/ej+MXe9JyFMPeKR+Yt3J0Y0cAoX+EgZCbKUA17U/M2lUYQBlr4WYDZj1yp3F0eYU0mog++TD6rFVFrt3DLXFrFSYoXXwWTOGIiqJi6pmiVQs9juk3ZWKFV0BuCCfAD9sctFpR9qrLrVm1NpbXug+wZw2q3NigEwLM60UbakZFhHXH2x2zzuH45n8izvE7FDALYlg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4597.apcprd01.prod.exchangelabs.com
 (2603:1096:101:90::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 14:00:56 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 14:00:55 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: alex@shazbot.org,
	jgg@nvidia.com,
	suravee.suthikulpanit@amd.com,
	thomas.lendacky@amd.com,
	joro@8bytes.org
Cc: kevin.tian@intel.com,
	wei.w.wang@hotmail.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH v2 0/2] iommu/amd: Avoid setting C-bit for MMIO addresses
Date: Mon,  3 Nov 2025 22:00:32 +0800
Message-ID:
 <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0345.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::6) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20251103140035.762861-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a1a8c1-4da5-49bc-2a61-08de1ae167ce
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|23021999003|461199028|5072599009|8060799015|15080799012|19110799012|10112599003|1602099012|13041999003|51005399003|40105399003|10035399007|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OtO56DFnMpaJpVJQ5R2yD3wsi4d8IsefsuKGgnR10BlKYvwSYzFzwdEaSAci?=
 =?us-ascii?Q?Kwey/Mb1WucjuurErJLDhtYQV63YGVu0dH0C69f0NYCU1Li64hFqbCLT8PVS?=
 =?us-ascii?Q?lj71d4JZLqCMjDKxbY1gvwnwVaGeVptaE3a1LmZGAn+NDWxvwIVXZPW3/C+Z?=
 =?us-ascii?Q?f0hWp5kH03UshdulT/aBPi1n1aOTKG4Rr4SM7/YYG/4nHKwEeX1sHde+qXOL?=
 =?us-ascii?Q?bNTmnn81X0V/BWPZIqg/NItBzERFUxYs531aHHVhn+ajVlhpSPpHCbYbLLxH?=
 =?us-ascii?Q?/ZXiNrfZ4Un63u6XAo1P7w4I/H6mJ6C7YiZKKDeH2IonT6rRYIc8JEdb5FrO?=
 =?us-ascii?Q?LuuWISw25kdYPSZw/TaqK9O7CM08mNmtJhv7xL3EGz4xGJ/horf/macnUHm2?=
 =?us-ascii?Q?SFTPh3V5XPn3OJJyen+U6tjQzsrINTZfue6JWVVuN6n5S0Sb/phbBkhhLM2C?=
 =?us-ascii?Q?w0wE2uoSkHEXnv/0LZCQQ4ug5SR0IDl4fDmmYwwAc6Z2/iv9ufMcUiMThGw9?=
 =?us-ascii?Q?oCji64vSynb+7unuRntAv0XpOkqxuTHsDZJ6KrI1UXAzT8aq6m0r4xLxrHyG?=
 =?us-ascii?Q?G52+X1VTEq0fBi+s6Qg3g8RBxD+yvcADxvqoFopmh5TshWiX3+nca135yCNM?=
 =?us-ascii?Q?JuXX4X5ic7XYezLHPt/ZaplBVtbFInO5WY9irdyDd5FyTj64Nq3px47jPDZi?=
 =?us-ascii?Q?TEGtyuZaEOWEDidckiLh4Rd5wB36VL0L4c2REcU8IWNWv9+EpGj+CpfTKAxl?=
 =?us-ascii?Q?kI8HDhR7KLisspyZRbn0aNcmmI0JZ7q+Em88Fr+aIS6v9ukiTWXixmufUVm+?=
 =?us-ascii?Q?x/Twc1Zvx7w1qXm4XgByQqVsBFIc0p3puTFJ06G3gDyCOx9dc/5cqgFSGLEc?=
 =?us-ascii?Q?rdrOsgj6p/2Ge8icg31L8SkdmWK7c4yE9E0Cw/FMj06PUMX4HvDy43jnkyLl?=
 =?us-ascii?Q?v+2rOKvTm6PG2jihM4Qe8vD4rKQOHoVHRKrTnrUDTpHhu/N8tz6vy4+ns9sP?=
 =?us-ascii?Q?L6WCxSM7VbtvPXAYhklDjrxJyT4VctFj7iNNyd1ZnhbAtzzxr4M1dhgDvACJ?=
 =?us-ascii?Q?yqlmEAVRNxq5NkPXxVnqZUPoGxc+/63zFbRe9N7gohLJfmmQeAINRyJ5y/0l?=
 =?us-ascii?Q?1tlPeAzp/Z/QS5OCNAqJSpjdx7Ob5ocPMOrcMJR3gZ4zi/Ypo53RuxJd431Q?=
 =?us-ascii?Q?/pNvvO9+xD1d7bfGaj9aIfFjiNAO+PcpyPTO1eCJ40hXGXxwLC0hgYpcael0?=
 =?us-ascii?Q?2C6nGsAQnCJAw6wHdTbJvkod9PgjZV/WItSKf/exJJRJ5kwQL0w7sDVcbhXX?=
 =?us-ascii?Q?6wgeNdSzjoV1RUoQzmuTZ9r2TL+lvugxlqKBPSnNV3yye191AiMzRy7K42nT?=
 =?us-ascii?Q?CQ5OIq+69MF85AwhkuHWMbeRyphOlsrm7uDeqsZCVAdrDjt4UyrbUvy+YuYh?=
 =?us-ascii?Q?e+8qQ1LVgEWxUDwAuODHEykTK41K22GV?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gmZl543zACEqWSbNwR3+0FypfdUKvT4tirhj2OATCfbcT6eW7KeexVSJUmTA?=
 =?us-ascii?Q?IdYQ8Dmhujo99c86sF9gc7P4BY8je2qgs5/b8CuuV+1e16vOJQWxyprx0Sjq?=
 =?us-ascii?Q?P8ICV2NHZLOA+HhXWhK8IHWZhAvFxaiZx2ZaR1OyqDkLTPLI2mKQcyeUsZXC?=
 =?us-ascii?Q?lVXrcEA1ePfr0+EopJm8CmtUiKNRpASlp+z+exuhNnNNi9mN0yd3WZMa67xW?=
 =?us-ascii?Q?nzrVJlrYkZV45tNlTySTnqfJa5mcaqQfVUvyxVyn6Qi3xwRg4bdAkZiW+Muv?=
 =?us-ascii?Q?j7kk/qsf7ghzC9xDA5U3eYUx4a1WCCljUIDZfIDLa5rMXS8aG7pmRJPDDQhI?=
 =?us-ascii?Q?/+XzrdZHyGb58Rixg3NnxXF6+J/ksseHh4oimdT5DlIRdbtl56yELkPqMt0g?=
 =?us-ascii?Q?PTHOSVCYaHZ33j4M2maD2PZIn1HYRHEUH4JYZctyNgx3V0iO9OLzDki4VLfP?=
 =?us-ascii?Q?nSDfCyarS+iwBcecMbX7Qnkab7B35iMxnG9REU94H+RRHwpujRyCQtPkuORx?=
 =?us-ascii?Q?m2wUYZAWfiVyAR/FJb0YtfGcov9r45k2T2RN0GRwaw5vHPZ4AsQfECtD14la?=
 =?us-ascii?Q?1L19r9vLAs+irsutA2YOoxSoOHLsM36YYvl6T2BrWScvQCbDqisPV9hCOZDW?=
 =?us-ascii?Q?SBstatPQ6eFRKD+ghJHPis0IXplwaoNfwgh3Ss0KdKGAur0jOFPkNYlRTWwn?=
 =?us-ascii?Q?7Q4QZZMArMWVj77EYskySWz5qIEFKCyCvIpLIqhgFC7fS2CLhgHJUQz+7JlR?=
 =?us-ascii?Q?6la2eQ+VH2E7Fx4wh1HujYwVZXc1yG6kcqBTuA5I4O4pfrFStUarSx99PBhg?=
 =?us-ascii?Q?0LePd8HJMA/6zIPqxvoAJqo2SW7dBluryUf3JwsneHWyJ5TXuWMKyW6F0Q1W?=
 =?us-ascii?Q?MGyBrgGzlD322UgRZ2dIZcIi7n0mvLchB1kB/bY+Fg/zvNEIdx2A/bvBw/Vf?=
 =?us-ascii?Q?32xom3SORgymFC3vgGIfF52NJbh8400rCtVEkQ888pfOpvSr3pMDW8lV9OKR?=
 =?us-ascii?Q?Us+dvVX7e5WK1We8mFWMZ63hvgTEBKMS2Xm59XPDzftnN+705FeEGw3BtkI0?=
 =?us-ascii?Q?N5v3Trd5DPSNFLGCvPWZkDOkMAHw+riVQOCPw/JZ3QAo3T4jqOa8NslT/HaF?=
 =?us-ascii?Q?Wpr4j1vJRbpCuOsxAZjsxINOEBaox2tl1PIrtdBJ/FWmtWvKK5Q/Yh7Ren11?=
 =?us-ascii?Q?lr9OB6hzM+YOk6eAJyz+F9pUDSYF0vL3o+1adfGjhCRxgOMmqUvjkSTmpAI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a1a8c1-4da5-49bc-2a61-08de1ae167ce
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:00:54.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4597

When SME is enabled, iommu_v1_map_pages() currently sets the C-bit for
all physical addresses. This is correct for system RAM, since the C-bit is
required by SME to indicate encrypted memory and ensure proper
encryption/decryption.

However, applying the C-bit to MMIO addresses is incorrect. Devices and
PCIe switches do not interpret the C-bit currently, and doing so can break
PCIe peer-to-peer communication. To prevent this, avoid setting the C-bit
when the physical address is backed by MMIO.

Note: this patchset only updates vfio_iommu_type1. Corresponding changes
to iommufd to pass the IOMMU_MMIO prot flag will be added if this approach
is accepted.

v1->v2 changes:
- 1 used page_is_ram() in the AMD IOMMU driver to detect non-RAM
  addresses, avoiding changes to upper-layer callers (vfio and iommufd).
  v2 instead lets upper layers explicitly indicate MMIO mappings via the
  IOMMU_MMIO prot flag. This avoids the potential overhead of
  page_is_ram(). (suggested by Jason Gunthorpe) 
  v1 link: https://lkml.org/lkml/2025/10/23/1211

Wei Wang (2):
  iommu/amd: Add IOMMU_PROT_IE flag for memory encryption
  vfio/type1: Set IOMMU_MMIO in dma->prot for MMIO-backed addresses

 drivers/iommu/amd/amd_iommu_types.h |  3 ++-
 drivers/iommu/amd/io_pgtable.c      |  7 +++++--
 drivers/iommu/amd/iommu.c           |  2 ++
 drivers/vfio/vfio_iommu_type1.c     | 14 +++++++++-----
 4 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.51.1

