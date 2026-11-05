Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793896439;
	b=msI8dHXixW1VZO4hrX4apFzPA8X5TMkSiY5oKAAkWHzvNmHt6ZwkkoQkrxzl1UD+dnRt
	 VQrL+sJApp1ZXWZxQzqf8Zi8B9ET4mEsQUzkaGub74Cs/eFMA6DucdFeBPRcrJ0VlrvNL
	 ya2dOcBW4Tfp9xY3Do6aCtvwCN4YhpCWlJbr8thEQJRntyUJgtWG0PTwOnS+0HelshH7x
	 ewlB/ocqxLJR7d/uLMMGeHC8lSfEbJa6WpEsO9mKJMsrK9svjGM2oPOfZtz1YBnpeH3Pa
	 3SW/eE7sIfTUm46ilh3Uk+/Ljyh/VNgKy2DqKhpLPwGdH6P+EHG7QNQbwiXA60x8zxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896439;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YhzOXauPd2EOFBgDF5ZQOa3mQfWLowpAxNtfwtd/Ga0=;
	b=u/IvFSas/KiwNcLTLYLRHLG8zFuXfwXDZpvmHwvvVpCZkesIXwueV/6E9nZo9S5U85Ad
	 UhDfHaNcuhGWgW5Pal/imb5rdJ2MJwnKb3mUoq+b0SNWjUm/DWdv9nwJPbrzHRD46mUpI
	 Qb3WHju04fWi0GEKlN3+D0xvnkGPNrn+YfylUaRbHeO0Kepecy5O/ViUv/A+9gBCXIuxy
	 Tk4HmZDyNMUD6rLS+EM50f8vkdqTnVrw2u1E23IuIePueb6fQwtVwZY57gK+qng6c3Wc/
	 HZrJrH1HKTJDe0k36uqc5zAN5p72fM3nhkb4lAGTMlFLnoELfsO1m8G21doptHf8T2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aMrqRLDQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.31
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C499606A330
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 16:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C499606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aMrqRLDQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTGouwTmHi7dTYSu3fpjWdGrKM/Re6Q10OGVqol6Ee5y3r+hCVUwUdNOzkF6QxAFC5ZRjS3EE0PV5ReZT+ydW7vZyOtuK7euMrbCvA2LNZCUhFyov1Myh7eYd1BCYSocDX+jPUWMDYFMjemefrbEtKBYP/R8Q8QD3BRSvU4ELlUPKsAX8aRCXTvixuJE9SI9EF1RY22AdfvBhUaNBcdtEZTPXDOeKqfRZY/ppMxn4RTra95NwY/Wyyol2hnPuOBQYUODWEDp3WqZA9B9fui0D3mCHy/pbsm7XoSPnAQbzl/PX29sfDDSwEhfSKh69byfxBZBIg+0aXYy4br7o9cLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhzOXauPd2EOFBgDF5ZQOa3mQfWLowpAxNtfwtd/Ga0=;
 b=vnER0Pcs905DFussu8GFGPEulDkp4Fq9HE4Wt6w7fEBpTNps/kTTjBhwzEmzwjjx4R7/WKM9M9x4g51cEoOGUv5YKhuABKYYwm6cJECwt+mz03RiV5/yccfcYb53JB6igS8cSNsnInBFT3MxUuKoDf0cIqSkUjzzZO3HEqB7bGkXEKXR4NtuH77fMKP9XRXEYeGWx5X6BZG0LVpfXOwNEkbUuu3Q7BRJg5m8jiwrIUXXjDv4Vs0zrn91PAMIzam/b2zjXTc3PFkkQ8hiITd3u8ltO5IKDFiGzJtT4iHyqHpNFiKJA5AEp3s4DEIlU0zEGkbI8sNfiunKll99EUGVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhzOXauPd2EOFBgDF5ZQOa3mQfWLowpAxNtfwtd/Ga0=;
 b=aMrqRLDQxAelFIjXUQ7JKSEvDzpGl/zww5AAm7WoS9szYp2mDbYLRy1EUuP37E61gg6xY6FjmwafJypwg7XAvTBa0ZuZ95kXeL6ZQsum02UYNk2C+a8DCnfhWS134ep8dn5Z9CASnt74F9FXZImb+eXqzTSj8aEAJyBvqZOsGp4=
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by IA5PR12MB999326.namprd12.prod.outlook.com (2603:10b6:208:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:33:55 +0000
Received: from PH5PEPF0000002B.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6b) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 16:33:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002B.mail.protection.outlook.com (10.167.243.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 16:33:54 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 10:33:52 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>
CC: <iommu@lists.linux.dev>
Subject: [PATCH 5/5] iommu/amd: Fix NULL pointer dereference for GPUs without upstream bridge
Date: Thu, 5 Nov 2026 16:32:19 +0000
Message-ID: <20261105163219.601561-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105163219.601561-1-vasant.hegde@amd.com>
References: <20261105163219.601561-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002B:EE_|IA5PR12MB999326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6bfc36-2e07-4959-00cc-08df3b5a9515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|261022075727099003|261028144727099003|261026140227099003|261021121427099003|261009223027099003|261021123027099003|261021135927099003|261026121527099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	CcglF+9tepwQ7elLnkLxhGiJZ7cGWXm3MTrbHFQq39hTvNon6CJ3ADeNyAtRW+3DmtNikctwV/Oi/0voMFQWm8DntbhXwNyHrh5Gr1hkkmThPZSvoMCcw5cUXuvDVhILjnHTflzWhkiTbg7dkQ/0Lt9FCB1RWuIDI9AUmKhjTGO9qrM7pwwL1aVHi5ne+EW+q9trXlzffx4ns4dqG0zyLUM7mNEygyxkitxGnLmTP1zKHd5/CIXS3UzRRi5mSi7jETGicb2N/PuTfag887DAeHoNzc+n+GO9+rHFMZXqjsnBHq4q4KJfLXuH80iGk6K7FUcZBTnU0yRyp7DvGJLwdRgeoRFSR4P7m5OyYt/7Y4DeUvH7+M1PkEibD8AI4vA5jv0VhKpBE7+ImHcCnsycshPmZbQ4XBypfFr5J8XwBAi2aNm2DWT+wVI1VdOD0lyqykJ3GsMEPUYdE54SyxWdyFLg5Ogiq/NAmIBnCxWipjN1GepwuoMSRgTvaZ4gc3rIcPyCQh+H7dvW8wB0Vh2B7+rG3pN42NkMFAy9gas4LC4WrVXA5kEF7GFz4Yc6VFfDqJeM+xhJZ3WQunbOAz1+n20eOBiWJEZp5pA21Liz0q9praGWmTFTqlqdz63XFydZpBqtFL1AE3GC66m+oSBxMZBMFgyxUTKzcHwnczG24qikaU4CKpm0RBHXmmNxQauwEy+IseP5ESaCW8YtO3nnrw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261022075727099003)(261028144727099003)(261026140227099003)(261021121427099003)(261009223027099003)(261021123027099003)(261021135927099003)(261026121527099003)(261102123227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V4LrWqF5XSNVqZ1y/+s/wVi1/rIqq2om0MMHB92tSM//lYBWDqbm4ZQwufqllenoNYzEqTsMPZ6KejkWK+rMoJTM8cj2Rwrl+L+CVKtkO1aGdFqDU0mKVTaXRrmt4q+O3GvlOMni3ElEn5/fGOmfbqttfBHkE01ewbcf5U5wm1+JZlg4zmgHFY5PFHmhaLNPuFuxC/d5g46MsSYGcZXWYb2FjpbtJje6qbfsfnUpQ8G7oG4z3wIHm23DXcXMsxgpIhYFULY1WX+x4nrQwnKUr1zvhv3H76tXwXXBYN5LvzW9zbTMXrU2VN8KwpXu0AzZaPMO1Fy4pGoQN65rXHau3H7e0fiT5zUNl4eXQ9zuOng2GraTiZr/ErwHGvD0X2JZjbyozvYCtZicJqlMLMgIegywChnV8rQpt7qTB5z7jPTlRGnC6ZEwkYyV8mpet3hE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:33:54.3425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6bfc36-2e07-4959-00cc-08df3b5a9515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF0000002B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999326

From: Jean-Christophe Guillain <jean-christophe@guillain.net>

pci_upstream_bridge() can return NULL for devices without an upstream
bridge. The AMD GPU identity mapping quirk dereferences the returned
pointer unconditionally, causing a kernel panic during boot.

Check the pointer before accessing the bridge vendor ID.

This fixes a boot regression on a Lenovo system with an AMD PRO
A10-9700E APU. The system now boots with AMD IOMMU enabled.

Fixes: bf5bdfd1f8d4 ("iommu/amd: Force identity mode for selected GPUs only")

Signed-off-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 91981c8a9614..41ee4ad1dcf8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3191,6 +3191,7 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
 
 static bool quirks_force_identity_mapping(struct pci_dev *pdev)
 {
+	struct pci_dev *bridge;
 	int class = pdev->class >> 8;
 
 	/* AMD GPU vendor ID */
@@ -3202,7 +3203,8 @@ static bool quirks_force_identity_mapping(struct pci_dev *pdev)
 	    class != PCI_CLASS_DISPLAY_OTHER)
 		return false;
 
-	if (pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_ATI)
+	bridge = pci_upstream_bridge(pdev);
+	if (bridge && bridge->vendor == PCI_VENDOR_ID_ATI)
 		return false;
 
 	/* It is the GPU in an APU, force identity domain */
-- 
2.31.1

