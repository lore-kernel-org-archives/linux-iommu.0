Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7473932F7
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571975; cv=fail; b=Zjxc+/jELIyH60lruTEbFzJj1BDy72f90t1U3VQee/FKgrv+nw9JqOudbiK2nrfGAQpmThGPVFvj/l9+TR3c46UdvIODQ7DJlHach6rVWrm/Fe4DTx9zO9zduQCwiPNGsVUUN9hcZ04OkamonaSIdqYEJza2TEI+/6vxSPQTfDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571975; c=relaxed/simple;
	bh=QQB9HLbSLQWtEHQ9TnK4phgTfnX+HVKB6147UUphuOs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uQ39EGOIz0rsAvhxLtBGSePnqY13sxFPVD28fe/W/pqkvmmYaNX4o+UeEsSIUDVYojQ6m8fDDsHDtlYa0M/NlOnh1CrqbddikRFRtcQCoDpbQN+VtjGasOELpMlFBqsQD32AZGevzGZQdHqIruQXQClG5eNNxZDxTOXF/RqfNzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qvDkFxH1; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qvDkFxH1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c43LpCk0c3sDTV5yAgxg/VutA2uct0OZiGiu4Ct3tqOvHaDHP8rb6XRo/MNN/heN+WbIX+EHGF85UhUawDJpCWk5vd6f4kz9Jdb0/ngcMW4CNQE0/Gi9R0UEhPFYFC4e2NuLeO/3oO1ew1Swxx0Jpr5gFDiK4vqrj+RQjH08wJgQtlwSc2FpkrTA/haX0X/npfsJlnV5Nc6+6B4w61+baUiwazpvAiM6bOHQh1DMWcxCNG9WAEKXfoKn5+SLaS21c0i7SuJAcK/LYz6CeqmGNDpI3sncMXR92oahUXLjzOuMQzZ9T1qpnGuvy9AdX7Upqk9b4QBUoEKaqoC7lCQbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+t/P/lga1AW7ufil5MrDViwfjIaED7Xg8Qhk9vzxkI=;
 b=dD+DCc15g+2CBQ1fvA6VQQxm71lQRcrBa65WdKVZyZa2qi3WPxx3ZzjB5ZMShfXMygXdjyFv2sz4UHZXaX+uliV2H373LKq6VDUgK9XZkldbuOQ5XwiUXi4ru+HwBwzOFZzapCxErr6HE0hpgQ0G9rEAbE9Wb91L49sy1N6TcTLDUEIKyZCbQut1WnMjv4YY6XuZ2Th48K2vQRwFRqL4eLqeyyVsdhxGrJucwe6Ah6GfSQagSSGCmgPWCHPVKdVTZe3nWJspbvMamIuM557o9yGq/8GnQywUt20dtviAjI0N64GIwBBCn80minDTlFvhrNvFdHBpMTDWq/SBJ7MD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+t/P/lga1AW7ufil5MrDViwfjIaED7Xg8Qhk9vzxkI=;
 b=qvDkFxH1NyyopoZJhS6FlkVMPVkeu5pvc+4IqyOTO6cKzfeRpfna/jUCt4iZEMIAerCg2FpEX5IIGQqsERlYg2jNRT329ZoCZeA/MwpkaMTXpX1ib4U4ObvNXA445CihrxJP/wOhXHW0hxZ1xLlSQMOz4DRB6Dsqjoxvw9cYZHuUjAOAkHXaLM3iedKDxTB4Kzt5J8z4Y/j6j8Wv7VN6ONlrOCk6RjWLts8+OBXmZ4QZFEJGP2SzM5nNmW+oDoixTfN361y1uq2Aw4LdDhlaAEejwbspPwnVpR0bC86bikP3yC7whPJatWPP+zpErtd3TA1siu9GZ4+BcdbicEd3AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11912.eurprd04.prod.outlook.com (2603:10a6:102:51a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 15:19:30 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:19:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 16 Sep 2026 23:23:34 +0800
Subject: [PATCH RFC 2/2] iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO
 in dma_iova_link()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-iommu-dma-fix-v1-2-a59a0c45ec5b@nxp.com>
References: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
In-Reply-To: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5P287CA0058.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA6PR04MB11912:EE_
X-MS-Office365-Filtering-Correlation-Id: b1487b91-08ff-4a40-1dbd-08df1405e781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zu1jfuTFOActogCwfRCkCbaQ+D80jMSH1S6462XXnRocGlx7mhn73uhtJ/KyhNIjdV9JANSQG6zXIqU6S04zpXn7dSzpVfuWmj2QxPhiEheiugzyUTZ1NdcWPWaE0mQE6aiLUSyFuAL/vUDssbjJzHdEGJ7BkxvDfTvJgmS/BSYIL9fLJoNXF+BtpD3o69kJp1gwfjkKfmd+99J9gRsAU+k3M0MNQiSZCeod3g1eFRZUvVA8bSYTGuZqeeLyeXPI0saqVHEdU1CRvdysHw0jf2ZnBLcAq2AUwpKm84qUd1lsAuHX/J9PbJzMEsv6Iq7osURx8xmDlsSjiTxA80iCoGQSUYQDoHQPJHkKFvuD8PbsnJEouwrkcN9mEZ9FYEA1HWuB53Qr9v+3X/m3ZIw7bom3NZN/+XOtZK4Gx1bKIM8LIQ8qQU051hihfGknEHEN+qw9UgQhCmwSv3zh8i1HV5qfeuuEa/+JQrda/8PEYVsgIyR8bd4DVuaC9uJ7bVVS7ao9uNlEUFs+LbzFAg0cYYNBaevIXayQFeMCDuBAfFTl+dwH9oYEWLUCGKN/bTFIdVj5n1Ey2ahU55sIO2Y215tOy3vfL/QfSM0MtJJqPsI1ehkNsRYz2cxaanwyznWH9jATQH677xunffYN0/a+Xl2EpCi4s6y0HqJdIpYuxkY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkFSKzBzZnA0TTlCL0hHWmxvQitmNVEyWHYvOVZzK0hJa0FHSFJ4b0lIUHM0?=
 =?utf-8?B?c25VeXI3MzJlWG5WdTJjanpvUWdJTjdpWVlvTmpkNWNKbGdxcDA5cmlmNkNp?=
 =?utf-8?B?ZkZhdVRKV1o1L1VKbW9zSGJqOGlobmNLSWdMQjM4TE5CY1lmWUdUbHQ2N3lS?=
 =?utf-8?B?NFR0SDZobWtud05NNjhlK2k1QlFjVFpFeVJURlU5MTNTRmZ2MWpzRWRFMGt5?=
 =?utf-8?B?b1dKdGFJK2JyRUExMDU1NFBTUG1EeGZqMmtTcktGbk9sY08xQlpBdyttME9E?=
 =?utf-8?B?bEc1VjN5YmRza0RDRFNud21JVzRwWlF1eXgrT2drSjFLSDBXd3UvNm9tS0dT?=
 =?utf-8?B?VDRqMWRIL0NEc0J4SEsyNmVSUzNoWlF4SU1tQy9LQ0s0a1dsNmttcGpoVUNx?=
 =?utf-8?B?d1lqMHVXY3I2aGxoTlNKNVZsZFZDNHRpM0VHVjJuNDJsWDdjSUIzYjFta1hV?=
 =?utf-8?B?SFlLdGdodnd1SG1TV2YwSFhxOVI5ZzJqVlpqemk3STVCQ1lJeFhJTmxnSGdC?=
 =?utf-8?B?STVPT2svbVIyS0VSbkJZNzA2T1NndDJCVDMzbGxhb0JqWVlRa2pqUFVmUUJL?=
 =?utf-8?B?QTN4YW1jTmh0VU8yM0FxdWNBRmE5cEIzeVF4QWJsWVR0a0ZjUHpwbUFpeUxl?=
 =?utf-8?B?dmhyYjRwTSs0dVk0aWc2eVBJV0MyYS81akZuWnJ0TUZEWUpGbERTN0wwSVdY?=
 =?utf-8?B?M1l0TGpiOHcxWWhrR2ZnVmp0Y25Dam15L2dJMWtnQXlWYkZlTWlFandyMjdH?=
 =?utf-8?B?NUdYWDZ5YUNmNER3OW1QUmFZOHdjZjAraUh4TjROOXp0OExDZVRsdjRKWWRW?=
 =?utf-8?B?eUJmdm5NVkpkajlPc3I3NzQrdXo1UTFUT044Q3FhMlM1S1F4cWxzWUJicUJt?=
 =?utf-8?B?SFdyVXFLa1RINmZ6Skd3dnhkN2tMSnBoTjBoejVEaVBYRUxyU1BVYXdGTWNa?=
 =?utf-8?B?dlZONmgraERud3NqUVdMRFgyN0U2aHpWbXdWcTdyY1VDYUsydStGMjI2eElh?=
 =?utf-8?B?aW5pTTdYUFJqMGtQV0UrTCsxb3E5WDFNVDF3TFU4bEl4WFl1aGNyTlY4U2px?=
 =?utf-8?B?NmRkRzI3MTR6VUVRNjNIVXZ6M255TDRBcGxuVGNlcUd0aTUzVTYxTkxJaTZv?=
 =?utf-8?B?VnhrUE9Bc3RMK1NKK3MxeDZCS3ZlekFIYjhGQnhLcDBTNEFWczZhYkgzQmpW?=
 =?utf-8?B?Ty8reE9WVXR2Vnd5b0lZcTlvdVNmZGFLWENIak1lOFJhWW1HYmd0TDFMMEZZ?=
 =?utf-8?B?THFVQm9NN3pjSTQwWlBaRW9Eb2Q2blVYa0QzQ3prM0llOWFEdERiTWhBcHF4?=
 =?utf-8?B?NHFZOU5zOUQ2enNRZnhmeFV5K2JhQWZMS2Y1ak1yYSt0TUo0dXB3TlNZM2FN?=
 =?utf-8?B?c256OC9TZkxLRmZQRTMrYUplSGdPdjBIZHF0Q3BtakRVN2ZRbWVmL2huS1Z4?=
 =?utf-8?B?OG15V0ZLVjJ5TEkzTklvN01MUHpENFFPVzRzN0tWTElIejlsamt6NnJ3RFhk?=
 =?utf-8?B?cHJFQWdFMkxHc1NxTC90ZTJtbENoR3F4SG9LcFZLNk12Ymt6bnZOOHVZK1Ay?=
 =?utf-8?B?WStpSzRWNFVKU0IxQnFpdlpCbE1GNXRVcW5aZmNkRVliUDcyWnZZY1FiY3Z0?=
 =?utf-8?B?STZoUUcza1NQSk9hekc2c1RNbGNnSFNBeGQraEx1ei9LMzFwWVhKOWFUNlpy?=
 =?utf-8?B?WStoRHRac0R4Njh3c0pjSS93WG50TTg4SmgzOVRRNUxhbGc5ZmdGQTlQdUw2?=
 =?utf-8?B?RWdzMDdZNjVoRk5MSE56K0t6cEVWd216Y21kL0FvL0Zjc0haa2pCZk5mMW5C?=
 =?utf-8?B?b2RZSmlWaXpTYS9aa1ZKOTl5MnMvTVhGTEF3dFhOK3loVUhsNGtrNUVpcUZq?=
 =?utf-8?B?dC9zQlpzYnlzMWtGbzFRZ1JoeXNla0pWUXFMY3JDbVV6K09aOCtyT2ZnMWVi?=
 =?utf-8?B?VitUWDR6QzZCWDhmcS95UHplUUQ1blEwK3FVRFdtc2xVYzI2WjRCb25RQ1F1?=
 =?utf-8?B?cHA5dE14MGRZS1VaZFh2Wk9vTE5JTHRIYUMySGRYZ09PazFSMFdBdXJmU3I2?=
 =?utf-8?B?SDVpVkdLS2RzdkRkemRUNjF5L1VEL2NnZnB2N2UybFMyemJwQi9uQU93VzRZ?=
 =?utf-8?B?blloVktxcERINkJrYk50ZGhUVE1JSVUzVGZxL1J4WnFjakUzdWNIVm5kRTlz?=
 =?utf-8?B?T2ljY3ZwYTgxL29XU0xwTXo0dHlCUzRoVEhKVDQ1dmJIdldoYnk5VnNyVzht?=
 =?utf-8?B?ZWt5MlZpZDMyVWZVc1RhN1ZXQXRQcDdZR1puaHFsNStvcEpFK25DbnE2aysv?=
 =?utf-8?B?TlNLQmY3NXVxSm4yRHN5VitwRG1nS1BhSHNweDY1eEZGRHVQSWxESDB5cTVG?=
 =?utf-8?Q?39vSZ5PVqePoEASLFbHLn3abVaUb0dNy3xsP9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1487b91-08ff-4a40-1dbd-08df1405e781
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:19:30.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWc2P1cVZ9ka6BatUExAxcU+JdLwQRpPAjD4ANZcbKLjpI86mOYz2XYrsRFKsMqrZrbPVIaIdBRamRytappbrBnFK6MCaVwcn3kWVV17CcJDKSZMkkEl8UrJ5nkZ0uZ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11912

From: Peng Fan <peng.fan@nxp.com>

Same issue as the iommu_dma_map_phys() fix: MMIO resources never need
swiotlb bounce buffering, but dma_iova_link() enters the swiotlb path
when the physical address is not page-aligned, then rejects the mapping
with -EPERM.

Move the DMA_ATTR_MMIO check before the swiotlb block so the entire bounce
path is skipped for MMIO, falling through directly to __dma_iova_link()
which creates the IOMMU mapping.

Fixes: c288d657dd515 ("iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/dma-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 26b9c2d71cd30..6807430ee3ab0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1998,9 +1998,9 @@ int dma_iova_link(struct device *dev, struct dma_iova_state *state,
 	if (!dev_is_dma_coherent(dev) && (attrs & DMA_ATTR_REQUIRE_COHERENT))
 		return -EOPNOTSUPP;
 
-	if (dev_use_swiotlb(dev, size, dir) &&
+	if (!(attrs & DMA_ATTR_MMIO) && dev_use_swiotlb(dev, size, dir) &&
 	    iova_unaligned(iovad, phys, size)) {
-		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
+		if (attrs & DMA_ATTR_REQUIRE_COHERENT)
 			return -EPERM;
 
 		return iommu_dma_iova_link_swiotlb(dev, state, phys, offset,

-- 
2.34.1

