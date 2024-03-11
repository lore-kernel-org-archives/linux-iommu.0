Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040217557
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148237; cv=fail; b=NtlC7eR1l5uM+dtOSM3FYNau/NJNAw63DNBZjm0V0txDjOqWf6GI+BIX77KEylq5QIg0QLrLtxr9bXL5oJys2bhZPvkyGoM77EMb4/VJurpu8X1ZFwwIxP7sDuq7J7DHgY2oGUOSVzDoVk1G1G0ZPYMUxJlncF5E1bua8BGRy2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148237; c=relaxed/simple;
	bh=1zM7w3DHdYds9ZFFzdkpvFbMRfPZxee/kP0ykOiTQTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeFZ7vl0OK9gxpZYrICHDFewBluaVDUqZArmyTO5TrO13NjYOVK/RH3NEtEP4KVm6bXd8OaBBXrLkdI0TQoJYnAmF1kih3RX1nshtgzl3HcJ2zxx3A7TH+AYknzkblFXHBcBxwtgpKAWmmv1tlxbM4ewPlZAD+BirLAZ6A1dBbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NRK1QWwT; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NRK1QWwT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf371c9wkqkpo7vIoouN5pUfSF6TshhucDEoNNG/aEyXwA1g1vp7KOZdQtVpogjwlanBs0a3ZEE+cbZ9L+O1FDLl30DSHmD6Nzdk/PPrGF43N6H9djDTjL2t0EljwRYsdGOQBF3VDyqVcUY2QEPZ01t3eEE/BRp9rGyeJwz+xXmBQ3t6CHQAN7LpJjlcHEcBgissmjoV0eBeNsWahKVL+yvUqlMftf3IwzC32g3XB4jYqZh/5vnZjr3EsqNItkuxksucliI4OSFT89OdyRPBrg+5x5Tn9M592lJmwOSYZqowt5GuiJRaRJkDp9O5GfOdPkMk/G5aGVYQ0nZ6g7s6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDOEQJLYXIrkckbhOoG1Uk1wBCKP31CheTVG+QCZm1w=;
 b=YZsaarGCBJFqf7ZSSzkqIl5vfArQ/FSRG01nxmdW7JjKrgh2cfMxb6f3RvvGp/PLp0WjqV+a8V+9eKI/BVmI40hmkMQJBf4cHUsMiyEk0QQPxa4aFjntWgZ227zhBvVedaU7bl31p5/gTssQ1PSkF39HQbH0ap0RfjYC8AnOghE2F8QgL3J1hbIFr+AbwOBcOHpZMsZUEeDkmwxKH+0CD0rtHwfHev5LlpyTfnb0YNC0x5VHyBkYQtbyGiHWoEMk/+L/1cijrsouOQoGO41b0Wazlc/EQorL50QliZ85Wny3iNd/MBEN/1sLFeI3xS8RZGb+9y7MK5DV2RuoUqG0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDOEQJLYXIrkckbhOoG1Uk1wBCKP31CheTVG+QCZm1w=;
 b=NRK1QWwTbk9H/P0vRto4mtYog04FsCDeD5CfTqscPQfQk4kNiPRg6f1qAqg3wRl97nFzqAXv6vZWLGrtCZuIOMgkhLWFjFY+VAcbID8rHlo4YN4uhW6PUHzTFEG/NjEN0fAlO7c+gLBm3cL/ZxW2P0CT7zynQfVbEKRiwOghteE=
Received: from BL0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:207:3c::30)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 09:10:31 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::9) by BL0PR02CA0017.outlook.office365.com
 (2603:10b6:207:3c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 09:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:10:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:10:27 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 05/15] iommu/amd: Fix PPR interrupt processing logic
Date: Mon, 11 Mar 2024 09:08:33 +0000
Message-ID: <20240311090843.133455-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: e51dabad-2a72-4f8b-5894-08dc41ab1a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xbdrWtBJVxHpjVN4Zq7rMZCSp6jwE+c5QamfPuWGm3SOBtVpka97jm6PXsJ18B+ofFy20vqAnJ6V4xw7rRoQt2/NjHUeBjAbLnLGJL5W8t/+5wTVlOrQyEFofM42N1J27DidCbqSiM3a+9PDMGTaE3ZKv9lGI0iRgRjdaiNkXYd2UCYuR7B/BFppTb/tUOY6hFfGxu1ypOLTCRvj4J8+B0QNWD82ss4E0zg3BTJBIPtnEo1pr9ygPxoz2EPwADy7w+KlskIkXKNn9SnImKY8jBRJdTkLUm7DVv5XHs2pW7cNym3qgoxeGJrzy3W06IYAB0D98l1b650pL1fhITEmgpwGfI3Wo4JhNR2ToeDXSLzGj1WWbF5sMbYP6O7eyDJBSvw8DoS/el5HRJsdiYQvuVvHYLppr/3mvDThW7DvpcJV/JIPxr991SB/8JWrh5UBKZc7DhOWLZkoIDHtRgPZ82IjOVZDpYg5465Kxwri0/QfNXqY857QPDKBo2ty1UKG1u0y1P9mA5tj1RzxwJqcIJGsAqo1pXkrbk8xSDEvb+kMqkg9zoub5i/zXw0R/4yA+DNZiSbxFLlel9jwF38ByDG40MY4Dx8cKXD/kUCa+OXtVtzL7R/KKewDOM3YyW7ev7mpTkGGh60RK0kmavi2aFnmrnQxJ1CvKXZerJ3dnpnxdDouiagHv2emytmgYJQrDlowG2iTZx/aDjVnnOHah2NUCK2UqOKNxD5XAJNgEqDmxm7nO5ujFUHEKNhRZt55
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:10:30.8333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51dabad-2a72-4f8b-5894-08dc41ab1a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

* Do not re-read ppr head pointer as its just updated by the driver.

* Do not read PPR buffer tail pointer inside while loop. If IOMMU
  generates PPR events continuously then completing interrupt processing
  takes long time. In worst case it may cause infinite loop.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/ppr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 673fcc30f9dc..d43a616c0c36 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -104,9 +104,5 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
 		/* TODO: PPR Handler will be added when we add IOPF support */
-
-		/* Refresh ring-buffer information */
-		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 	}
 }
-- 
2.31.1

