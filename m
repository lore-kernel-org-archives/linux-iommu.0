Received: from SVZP279CU002.outbound.protection.outlook.com (mail-norwaywestazon11020099.outbound.protection.outlook.com [52.101.180.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE6A3EDADD
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.180.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300115; cv=fail; b=EgEMPBz/CTnnAk8ocLm43fUmn2DmYF6NGbC2qWS3VfqeIs26KzWCfP8Bzqt4BKRyzkYSftLOLeol8d8egSHrB/PFY3V5OdhplXoJT7YjO1Fo99hXj7gkZEnxizqzgr4mUcwt0z8nhXL1+a7Vj/Ar6EXv93wbinvBvPIcNg2Vyzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300115; c=relaxed/simple;
	bh=aclHUhR6fOuqM9XNMU9y+LDn+oulBvqdqJwmS1jE+/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DxJV3k9E5/J+OrbH1NdDf5ga7wdKbDzqF48XrwwH6KJRalykG3NKev5ymrwwVquGZm/GRJWUK3r4Vx0ZDrWSWtknpLyGY/Sgdpoz9tbZ79i9V/svxFrTw7S4qKcgg9dbhLx+fSBhvbnQiAZw2hyUSfiflW2PTpscqHAEFAetm8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=soKTKpD0; arc=fail smtp.client-ip=52.101.180.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="soKTKpD0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia1xrV0qBC1OESknujALPNvfz+z9tzVOlwwdxita+t/hZcRyPFdfK43NX5YYYNmCcV6Mj0W4HSzrnjqIPSP1CNM6xcVeARQk+pE+xSKy/i+JUI1OTbYGLxoAGMtz+OHGrWOT+v23XZGensfBY2s0p6ilqy1HKH/j1xT6OPNgkWvHfp54mSaDnKgZNzSBCy1gXRT0fMQOPIW9EdNmyvMKESI9jkexD0XcI6XgaG5CLUgd8pjAceW6p9RwglJx3NeRDm8+gqAJ6aM+OJ9y3PcROFOkbesC0oRirIWniHCsJ+8AHh8yDO/4uyQrTwCAWDgg4lKZ24kh9LmYnmVwGnCjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5GB6KgSeCAbNE8aDRB3jeW/P0OMDqkzX6KtU+mgm8g=;
 b=nExudTjilLnuY4WKLFzExvIKLA6YBULFoyVVkqFV0qFzGMUAMxgBCV3p46g7858t0xFOFG9ApAy40g+s2E8pIPLmjyQWSKyHrHjFjyODae9V0rwG+DQ2YE0rOzNAflWhqn520MyzMCby6D+ecwKscRhYU0HfgU5ehTBofFlw3CBox/qEDfw6lvBNuC4MIN5GdmC5gB8uaIZGYT91NspvcreAkMKnJKMfgRmdW6qmG7d1CdECLLOnSmhY6MSftEU8a3AyA8HzMun/xc4wjkuhRbbSaoPYNbwz0iU0SJnctC5H6o0e3GRbFBFqToGxYRXntKPW/4InsbK9HvxtVUfv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5GB6KgSeCAbNE8aDRB3jeW/P0OMDqkzX6KtU+mgm8g=;
 b=soKTKpD0pl2DiP33/du+B1CVpNPh3IJ0MbvTjtfupGWWbJzGAYMRug1AFyFm5pzZfOq66AJjCeseJcZQ5lHdHLomnqUYI901OYjZhWkvmv6fsA3Pv8XV1D13aLksSp9VED9JdWFQNu2UnHbr6QcWbrraGorFtJonwZJ+mpSCXPxt+HeVgtRDseWUl/VSR9YImdeUlYfRVZ2M2EOFUqdjXrTzSS9Q+mvo7kJr1Rv/me52/bs5iuCd8E9mU67iEyeXgf7v6/tycq2A60DKOm5P02YeruMK84aAturmSh9P5MuSTNnujC0R087ujLavDMGTi4XDUnrpWDZ/LhUbrPWCZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OSEP279MB1243.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:78::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.14; Thu, 5 Feb 2026 14:01:50 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 14:01:50 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev,
	jonas@dolphinics.com,
	larsk@dolphinics.com,
	linux-kernel@vger.kernel.org,
	magnus@dolphinics.com,
	suravee.suthikulpanit@amd.com,
	torel@simula.no,
	vasant.hegde@amd.com
Subject: [PATCH v2] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Thu,  5 Feb 2026 15:01:00 +0100
Message-ID: <20260205140059.11857-2-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fwtqfdk3m7qrazj4bfutl4grac46agtxztc3p2lqnejt2wyexu@lztyomxrm3pk>
References: <fwtqfdk3m7qrazj4bfutl4grac46agtxztc3p2lqnejt2wyexu@lztyomxrm3pk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OL1P279CA0044.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:14::13) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OSEP279MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: b87b354d-d0e8-446a-df30-08de64bf1ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CIQwBwDS2QSPOxRSYc7//+1n5w6NiwuoepXLwSw/AYpiiZ7V5Nqp8P5CCO7g?=
 =?us-ascii?Q?Sr8dtKRMsW0APhcch/ix+MUHusAZf4GBeiVpP+NxRiu0U8sXB6q1zLHo7B1i?=
 =?us-ascii?Q?oURGIILV9rWeSNaCnwPtVNhFyJvRmY8NyfjcfXvNQXfXqIjQdxhbsFixXmh6?=
 =?us-ascii?Q?8yp60+j3FcFN/PSCSb+467sCWBD0Pk6wTK36drf1QxkucE93nWIMdGoxUIts?=
 =?us-ascii?Q?z/F+/XNcYUwS8TMjgN+q4gi8T+Wyti87M55JL5J1P3KCdV138cxV/uIZncXd?=
 =?us-ascii?Q?+d+XtNpnIYVnA/GW4b3HJGakUSFz184H7bYyyeKjGz2GQfu65wR5RYi727j2?=
 =?us-ascii?Q?J1gDja46Ux4wEIVUawRZX29qS+lcZuAyEn963pFhof7kMMy74YLg9KzGfjKn?=
 =?us-ascii?Q?VqZ8ah3pFK53nXBSOZqSe/A9YlpmCtq1yw8g0fGWdrLB/BVu/LLmwvuIb503?=
 =?us-ascii?Q?iIH/95yBPz8LGgsVHGWxfgfRaTOyxWPoTADqMryoOfypAQ+E1DECMxIRmQpR?=
 =?us-ascii?Q?xjEBi1oi06UWn9M10sv9dvrdWrBiT4sBuo3wF1TsINv5LfZQMVo3VjLVXe6+?=
 =?us-ascii?Q?6VlXCJqtoz9D5LVrMG+Q0Qz4nqQv4g8lPsfd/7RYaKjtZW5kO2hwTxsJTGi3?=
 =?us-ascii?Q?cez92r+QDqaaEUhgYzldOLI4ceYwyF/gLURXi1YG2rY4pVPQlo6DMr6imftO?=
 =?us-ascii?Q?XCs8pOsN8nPA2T99tnD/+a+s5F1toRlOubNmBwEwgytoge4zmO8uCqnB2+IS?=
 =?us-ascii?Q?wMfS03LTJeefzrrF2eXSTsmMdlb280bkmrFlVULrF6GgIF++t0Jy6FoStZl6?=
 =?us-ascii?Q?mRMObJNpoxdrFe3uuYY7XCEziHPW6OwAEAr18OqcuxtMTc/ovT3WGrFWuKAX?=
 =?us-ascii?Q?UjPeaIVglpHrrK/Otne2OqAJne7q3nG7U0/oEweKXSD+Q3san3HMK2YLhgDm?=
 =?us-ascii?Q?K74O/frYanNNZi9hzWQln+c1bG+mdHu/ssVmak3FtjI+fIZlvFGGZ1UD+JAE?=
 =?us-ascii?Q?e3okhI35f6/82Dek3Ra79fFiPsgaaR2BbgVXEO5bqtiUUarTgVxlwtz0/Xwh?=
 =?us-ascii?Q?22KtggJr1yivbVEceX63EEAMn1oBWoXZ9mF5R45V08jTvkfGUJ+HsoIPaycB?=
 =?us-ascii?Q?4UuxClAGLUIJcO1jcutsi055jRktGKAMJ7BAHAxLQfL3wRKkLIYOKDCviejT?=
 =?us-ascii?Q?Y608LWoHzQXPHXqdAa2O77I1yuxu29AGRmTjeE29H37r6vPWQ/N/BeiK/uAb?=
 =?us-ascii?Q?NPGbEcwLOdTaboHXbQ/cBuoBWiU98C4+AF2pblU1sfg4zNb+QjRslAWSBhYp?=
 =?us-ascii?Q?Xrb3xGb/OCQ1noM1tjLxkdlm4Zk06iOEsk4Votz3vooNVgphFnPiEm73qU8x?=
 =?us-ascii?Q?bqlra8crQ84MjJr9NTVcvbj6EBWRMryoIAk1ZzEMNRzKzbeem0GBQDqla+Ae?=
 =?us-ascii?Q?TmWWwti++pVPBK7CSynu1+SNNhRrVhT5iy6reyu/QpQolYFD23hfIIfV2ATJ?=
 =?us-ascii?Q?3fVhdNHtIY2dH2jiqX1gqMjQQ4WXTB4TxKl2LY2yVbq0o2ssmXPb2/qwGPBZ?=
 =?us-ascii?Q?ZrG8vqqO0fjFXgVs3EM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MB2uJOok0q7tobvuakiifLUoN3tBstYA1r5Sng/LXlDa300y3NENRW0TyEzq?=
 =?us-ascii?Q?yLmBtiYrsrnxPTgmBB8FQysimRA5275ue9LWwZQsLxHMqOkgkSJpx07JFQje?=
 =?us-ascii?Q?uRoM7wx43t1LOICj+Ri803a7Omwoo4SxN6+Fb5fW8WReIt0gShdioHoEA1lU?=
 =?us-ascii?Q?GDg0bREZqabK7SIeMBiFynrOB0Dgb3TIx+WMVc4sDI4Bw86BmfWLpNto6dsL?=
 =?us-ascii?Q?bdw1gG43/xLAsN5sM1OEZJKVCu586Z8sjo9b0ipVPZOLg6pwmxqH8+kaKe8P?=
 =?us-ascii?Q?FM3QHWq8EIWtZGYcSRvxlTvYGxiaE8E+Go4UqlOedgoTsmxjGtzMZ3nVvkHO?=
 =?us-ascii?Q?wcYmQznNBwzp6uEPPmEuDpIIVfD7uvK4k3uPuFDOgP7xesiNs9sQafN+TZpj?=
 =?us-ascii?Q?hede85Mrqq2alZ63Y8P0DNmWV9K0pBS9wtUtPqdFdrAHjWeK8LIZk/10cRbL?=
 =?us-ascii?Q?b62EzqZxNng8o3JuZi0M1n+eVEQ6f7wep14AhFQWLpQD4//Mha41NXWEHZmt?=
 =?us-ascii?Q?SHSyG1tJ3l33DQnyIDOZoHJxM4cOIwQS9ce8MQwyRi/0kUs72w3FTIE/g1FJ?=
 =?us-ascii?Q?1PDeD9FjoRW5lqZ3ba8CyiCtELmYcPl786SUaJE10FwHztOI042yB/YkKq1A?=
 =?us-ascii?Q?i7EaI9hCiArFCm4LUg+KcbOZ2lc2PAzmFuS5VlDSGFlA1qnvJ7DmY3pbeQya?=
 =?us-ascii?Q?rpkw+dXUOf+Udbtdo/WCapUQJSZxN0J7ENtkklhIgauP/UmLELfB6QGmSQ3J?=
 =?us-ascii?Q?FaUc6HZh8p9hbams7uXgLmCvRrSQtpeti6019ckMaHrSFgmKa4ScRaLc1Jp4?=
 =?us-ascii?Q?qLGNc9kJCJhUtIzhRoUJ47ZPlCKBXeZS6/yeLxS5EFyR7SJBAoh0l55NHiCL?=
 =?us-ascii?Q?Flrs99QXJdw3uRPHuPcMIxSjCmbuu5LlX57ACIMnoiyNgcvPy4HU+aRsfPQH?=
 =?us-ascii?Q?yg8kfDAiT6V04F/sjgL7mHQ5iDGqIvapfXuWqHcqOo5QMXH+vSDIiefXeLXv?=
 =?us-ascii?Q?PQIY7ao6ZPCIBK1Jk52eP6aMHPjXd9jzR3JU5yxtUCBqWVyAhl4e03H6roxg?=
 =?us-ascii?Q?P3yGkvDkFYxuHdiBTMI0F6IlxN5eJAgXVrYDR2GrJBS+7eS1876qHxKFlnyV?=
 =?us-ascii?Q?jzWpWvTnD8pI9NI5EHymNDQOsgG9kN+1MDao0eQ7YMT7VhqhsOGahkVLKCnw?=
 =?us-ascii?Q?HPLc139iuTKItX5WT/ZPW0AMRA0KDHTf8CxdJbetAQFMqhV3gzZVdkfUx7EV?=
 =?us-ascii?Q?j8mAqq1sTKUtWDHunjFE3ovdN9ofahUxs+gxu7Z6GhS3CCu3YO03qRlTr89+?=
 =?us-ascii?Q?279qwYIagwr8S34FIO4T01AXujM7ohhP9D172j4sgNbcYDe8734Xiv3CkFaG?=
 =?us-ascii?Q?PkCK5THeXJvJuThtc3N0ucIjnRXxsZLTAUapdmSLzx0FZxnwwxetci7inyre?=
 =?us-ascii?Q?J4prRf3VaPzuylj2VyEhXdD0vWDOmxg1KhxpgLpxhTqsOCViywA1Qh+KDrdx?=
 =?us-ascii?Q?jwfyIlVRDJp2g3OoPaBbxZsNl05DPSIdjNUhLam5GmI23CfUzwIue40mdBxC?=
 =?us-ascii?Q?rp8RIY/f/GWtxzNFMNrWxyH4VGo5d1cm8+SCrBNhJVWCAQlbwl8jNf16ad6e?=
 =?us-ascii?Q?9WsVoftsCOJ4fZyFj/uXbHpxGt8t5Jxu45BgC4xx52DcVTz/jWjVf3wVZlOU?=
 =?us-ascii?Q?jhA5esZM2dc3N6QkKuv2UGxDq7iCJscq0q+gP8uaDeo7rFfR8zinfUPfI0s9?=
 =?us-ascii?Q?HemDgyzONg=3D=3D?=
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87b354d-d0e8-446a-df30-08de64bf1ba6
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:01:50.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AH86ugSHWzEdQXk6r5+m7NTh68GEtwVGg2bP3uVJnAKR2WC2AYDSA7n3LQrYGIXVyykdm4sWevi2fR8DxSevg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSEP279MB1243

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

Link: https://lore.kernel.org/linux-iommu/fwtqfdk3m7qrazj4bfutl4grac46agtxztc3p2lqnejt2wyexu@lztyomxrm3pk/
Signed-off-by: Magnus Kalland <magnus@dolphinics.com>

---

v2:
 - Move the lock acquire before branching
 - Call iommu_flush_dev_irt() when pdev is null
 - Handle pdev refcount in correct branch

 drivers/iommu/amd/iommu.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e1865daa1ce..b5256b28b0c8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3077,25 +3077,47 @@ const struct iommu_ops amd_iommu_ops = {
 static struct irq_chip amd_ir_chip;
 static DEFINE_SPINLOCK(iommu_table_lock);
 
+static int iommu_flush_dev_irt(struct pci_dev *unused, u16 devid, void *data)
+{
+	int ret;
+	struct iommu_cmd cmd;
+	struct amd_iommu *iommu = data;
+
+	build_inv_irt(&cmd, devid);
+	ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	return ret;
+}
+
 static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 {
 	int ret;
 	u64 data;
+	int domain = iommu->pci_seg->id;
+	unsigned int bus = PCI_BUS_NUM(devid);
+	unsigned int devfn = devid & 0xff;
 	unsigned long flags;
-	struct iommu_cmd cmd, cmd2;
+	struct iommu_cmd cmd;
+	struct pci_dev *pdev = NULL;
 
 	if (iommu->irtcachedis_enabled)
 		return;
 
-	build_inv_irt(&cmd, devid);
 	data = atomic64_inc_return(&iommu->cmd_sem_val);
-	build_completion_wait(&cmd2, iommu, data);
+	build_completion_wait(&cmd, iommu, data);
 
+	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
 	raw_spin_lock_irqsave(&iommu->lock, flags);
-	ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	if (pdev) {
+		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
+		pci_dev_put(pdev);
+	} else {
+		ret = iommu_flush_dev_irt(NULL, devid, iommu);
+	}
+
 	if (ret)
 		goto out;
-	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
+
+	ret = __iommu_queue_command_sync(iommu, &cmd, false);
 	if (ret)
 		goto out;
 	wait_on_sem(iommu, data);
-- 
2.43.0

