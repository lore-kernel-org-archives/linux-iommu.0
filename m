Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34717369979
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929803; cv=fail; b=kuOd079Aigf3bZGyJQVMribxQvzHJKmpN3QG+Zd6SS6qKT1N+fR6mXUXAwdkqMwI1/K0aVNn7gY6MWSIDXVqzYyZ4oe2dtWywBmIeOfmJcgq3XM5EF92I1Tn43Y4VxO6t6PnKuJIQS/SxDUL9/WMFJM+lEmvOl97a6gYZzLuo9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929803; c=relaxed/simple;
	bh=fLEeYU0ZMjGoGEmwr3szm+QVpkWZ5EXJqfcC5NxHPws=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S4FsZM4Lnn8Gj7tjHxDbbrkzU6xB/+3y0Hd322ySyPQyspYmgxWUV+wRpdvI/EfDVyGzN/YhWvWtI29qpG/O/iOGgvBO+gXmU/6LCcSvE1KRov6vl+aNx/NR/kq7Rs/wKlYW7A6xVLdLslyeDhP/fu1LoxmeDWBXQXgy8w2k1m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgIoOG0j; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgIoOG0j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYLDw16fuASDsoUmoz3CWuOEawE3XX6kEkrszmthRUKYBFrr1k+AWOBKCCHftf1pdrhGn3b4cJz0gRIStrCTx+ZV4rOQ9lhka00alOMvaIP7/x0gfi7I4/qi4gG1a5NhahjJnhQtl6KCE6GgxfjECgOQ0eUvy8wuTGcLCMkoylwbddUD0s3zmdc98IUhW1jvT/5xNdpO5BsDsS02gT1KWIQc4qJVPWIobCEttd62rub1ha+EltxMGPVRa/ooAYo+UMq20WqR8Qr1vXoRtFHwQWFW/nyELmKJlUr7XtQEE9YQFCo4r+me41Rk6ZYkVnfVynk3Zx031iGTqkLKCcVcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx1mvvpa3RnvaJF3UAH17jIDZ6cDkK6x1iBhSUWm6LA=;
 b=birljcD3wtAgLeOHfprVn4rxY7OFXQpKuuFhv+noNDtife/UGQfj4AdZI1QAtQEMaUV+zmRSipVGz0vnsMJven9Di6p1J6qRLLLISi/l954F3oNJC8PilRXqBlBYEjW8AyOA2GAfVmuki7PrPdnBIbiMnhoLAfAHRWLYOUrbmbid5Bi2pco2XZRw+bZCuZwjonV+Qqm+IMTrTGRx6+Umvwly3akO0TgWZgO+l+aeDZaU0vKNI/FELk88j8ClR+P79qryI3ODqJnDDEW7FwyyxwNoyKOJd5O4oM/YOk5FxETFTXaxD3iIBCfmeBCCcuhUQZ0A0Ibd+ItlQaCyxbVdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx1mvvpa3RnvaJF3UAH17jIDZ6cDkK6x1iBhSUWm6LA=;
 b=kgIoOG0j7UiBm+YUrqEa/wlbB65BYaUtpVbsYSX94HJ/rBAIDMy/WKM99eNi/NjYC6jqdtTzda1bfKIMq3cqK3E/Eag5L0clc+jGcmrHzCvFv75FN7WZEHWjkzfurtP7GTTpJEaUOzeaR15dO2eiw1dA1nqipvyHe8EuKrvxMTeM6hejkpLTXjky/yZ/POjkA4tTHTvztq59GGFDknXdvh6r+CBL2MafkFHFQynUFJXYQat1Q7djIJa+0mGRowH4XpyMTDnbyhx2ngNLXqwagsSq6wBKXYaCNCguBaAxgBhXDLAYNKmhCxH9wpVFlm/X1+hM1FGdnabvIeQHS4RdMA==
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 10:43:17 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:334:cafe::f8) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 10:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 24 Feb 2026 10:43:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 02:43:05 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 02:43:04 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 24 Feb 2026 02:43:04 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, "Ashish
 Mhetre" <amhetre@nvidia.com>
Subject: [PATCH RFC] iommu/dma: Validate page before accessing P2PDMA state
Date: Tue, 24 Feb 2026 10:42:57 +0000
Message-ID: <20260224104257.1641429-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 2704beba-e82e-41bc-2b9d-08de739184db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WE1Oka4au7e6kxGW0yS7Nfu5EPMpunD50c7Y9fSbiZjewA7Y1tHnH0SX4zue?=
 =?us-ascii?Q?KOM+lQXOqBGoYqr1UdXmWOY3iUH5evBOhU7PISGJA8Lr5jPftwaLvOHRehK6?=
 =?us-ascii?Q?DvvNk6XFVtwo7UnH6Gv19iS0mIMXHsDBNq7J/PjZTd7djTGVJB3TLt2q2pxN?=
 =?us-ascii?Q?LRyeqkTlDLQvYvnt7xMg81PoQunwgsHOFm96Wfq+8sPxGWkBz6tYMBrliEgj?=
 =?us-ascii?Q?qh7ICGj3XIxEmZnxZuOMRbqw4dqkHY2eOBl8aiYumljMIAvNDIcTPU7Tzakb?=
 =?us-ascii?Q?tb7TWqFPj0MRRyJdcSONSI+Kr7b5Yw7AVQBseHyrvwVzkLKkovLiVKsxCOtH?=
 =?us-ascii?Q?sqrUkryDeUcbRA3aF3sUrnLDGv0srvmbHym1V+e6H/PKsVHmg97bwQN3f9tS?=
 =?us-ascii?Q?fzs5rS63Sf6+6IkM2A3uhaJ8QNBFH7A1ChmVmdm0QKFxTS/xi6HBD3roNxyw?=
 =?us-ascii?Q?w710hVtyUUZvajTqVtCwtHoqf1/enoFQdEOKyVExrn6Uwd/+qUU2E6gn6qyv?=
 =?us-ascii?Q?RIwcIygJ7mi4cyhp2PQuak/0HUCZlE1Uz1kvC0qGsONcsQ1X+CRo9cZ9UGQU?=
 =?us-ascii?Q?YpHgZ72qHWk2/JTCl77IqMw+JQOGF0aWXkNDpQNLrl82Q0Lw/Fs9Y8zcPZSz?=
 =?us-ascii?Q?ZW7LC6Sy23I7fBQIYvP41P/98u0S1r1ksLhO2DCMSkHkaQPg5XRh5DLyfmLr?=
 =?us-ascii?Q?PbOVgAOr+c2mbYB7BaNJrqoOyu4plf4vyP8VUQP4oNZ93mHLDu0dcmcIZjdC?=
 =?us-ascii?Q?uMLTe/NdSIJodPgami+iMDeR9tNQAlGUbi/JTs3IMvCGF5xwrpGLRT66bs75?=
 =?us-ascii?Q?zCxq4LS+C3ediytnGjQSzWTTRronfhw1skReukWra8QOEF1OxEMPPID+1XRv?=
 =?us-ascii?Q?kVIRB09K2NEFT8Q/QEIR8KBLbo9EGXABGSvaZusGrWUZo+5dtmD7IYHx5sst?=
 =?us-ascii?Q?A43FhUY8dvg1Q+HiUI6wzmDtQ506AwennoL+eJFspJrOGYTPobRWADt78sE4?=
 =?us-ascii?Q?NG10Vtu/mWxUBqaqcaNaOY55yWKPVQWUNHacr05fT4aBqko9WbkqqLgbcgt2?=
 =?us-ascii?Q?0V2BOEt0ZugyySAVsy3SlHt6PKx79YEs4g87iG6mlmmthNn8ZaAjpyU4hCjw?=
 =?us-ascii?Q?GUkQdoVv0rqCSXGQ791FIRXjQEBbgyUCmvo/GFAOCKkyRILWH/e75midz65p?=
 =?us-ascii?Q?KakdR+2CRSaeFfZre1Tg0WE+rdq2pE+W6yiStVbX1IYU2IbBA6M/iuJfeN0l?=
 =?us-ascii?Q?zlDw7ZenHjK1FRrfo1wUiUBBqCChdPf+VqOgbZtyQ5UJIWKauZRl8DYarY5b?=
 =?us-ascii?Q?5uD+2u3h281Pt5X/3/eds/7aSo4zvet+S33bZKmlOhexPLsV8cd3t/vkiQ/t?=
 =?us-ascii?Q?Bmv9jqTq6ED8RO7ts9arfBTiMiAH18m6yoC6hfUewEru1K93IK2U5CCtxt7f?=
 =?us-ascii?Q?sYgG9vKxEfLTOUd91AbTj3L1GK8DJFYA8X4x449wQkZ7UnxE52p2JBw7B2ow?=
 =?us-ascii?Q?UaQpss4Tpy1p6yhyVoGQvhqUeWO5ZjcS7czvSIg/Q4W/KqPI6coNOcHyVHXB?=
 =?us-ascii?Q?FxoG9aBV/ocrkB/rf0OytwIA4fGlzHikV0r+PCo2pT7AyAQjlsunJUt6lBJB?=
 =?us-ascii?Q?mmwuxBf3TmV0e60NvZOQadGuL6RXth44Gd5Np6GD1xNSwH3POCRUVGQbZPN3?=
 =?us-ascii?Q?kwUxWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PYMzZhkYO16gc3roLiMQfyJlC4trS2UwH9VkyKC4vZHBG9p/5GAwsA0DdRr/vuTJmQlEnuVLeHa4tfm1qPMDfa4CGaBLQN4VUfxY2OtPLDrVmaCWz0gWMg+scRpj5LAcdA1dLiW/FPWVtu8LzvbuNHXQYtKvnL1vsuq5c8SqW5Hg2sOHYw/2gj22GysFrEUlGJ3z/IP0EFUAFlp1JaC4kz2aWIjd5jdLB90kq594klxr+fbgZQ2xvjaoWu228UtaaKdslpeDutF4Qc/kSrpDuAqygWhBz09hoR2jEebW/oQDTZGeEiXzdwagGSFYFs/Sr6bRhhI/xKnQDFmnMSEuOyIeD7Gz8GH4S8Jpw1SISwEP3wXUKSXNfAOmkLHUUgd5mKqSHCiqXsaF0it5Bhl4OmYIXFNdXP0SapujKJYUaMzZPA775Ucfn3vitaWt1uVV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 10:43:16.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2704beba-e82e-41bc-2b9d-08de739184db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

When mapping scatter-gather entries that reference reserved
memory regions without struct page backing (e.g., bootloader created
carveouts), is_pci_p2pdma_page() dereferences the page pointer
returned by sg_page() without first verifying its validity.

This causes a kernel paging fault when CONFIG_PCI_P2PDMA is enabled
and dma_map_sg_attrs() is called for memory regions that have no
associated struct page:

Unable to handle kernel paging request at virtual address fffffc007d100000
  ...
  Call trace:
   iommu_dma_map_sg+0x118/0x414
   dma_map_sg_attrs+0x38/0x44

Fix this by adding a pfn_valid() check before calling
is_pci_p2pdma_page(). If the page frame number is invalid, skip the
P2PDMA check entirely as such memory cannot be P2PDMA memory anyway.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5dac64be61bb..5f45f33b23c2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1423,6 +1423,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		size_t s_length = s->length;
 		size_t pad_len = (mask - iova_len + 1) & mask;
 
+		if (!pfn_valid(page_to_pfn(sg_page(s))))
+			goto post_pci_p2pdma;
+
 		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(s))) {
 		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 			/*
@@ -1449,6 +1452,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 			goto out_restore_sg;
 		}
 
+post_pci_p2pdma:
 		sg_dma_address(s) = s_iova_off;
 		sg_dma_len(s) = s_length;
 		s->offset -= s_iova_off;
-- 
2.25.1

