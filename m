Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E93B7B4
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EH6L6nMn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK3KPXHj3eTQt03XQuIDKh/JfkuXQKq82lCXnA6ttECy+TPKIWtQDvwtrDlSlwLfCHS6BGC5Uu4ccofSFrItBD6SP4kemzNb4xOG+3mnNYBWOesj4+NOgxMsdPq1SMJGcUeP4JAojlkzz8xZ88fir+nhPUuvRZpgt01qAXg/HptVxu7ocdMRDQxqQVZAMciK+FJ6krSsvKnGRZy9w11ThSrehdbCSJr+j+NYsgvE3P0tpFyXgnG9KqKlQ8Xi7IUGUcvVj42GRUUnwV/8OgXKVZR1E9Goy0e3GtrBa6p5tYIBk+ASAudaItqOFui93tsC4XXIwWc0G5OiTa9bodTEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TbxfC2U6tCLAznvSvFNeuIwXT1R+1ijvWW3GbsE/b0=;
 b=kR7zB4fAUdjTensyNwzVuOHkvGVYPev08+LWVAm0QJLDZc5PltxpjNxXVXaVY+dJse+1mxVsofhKFJBH3UVuI93cv6txxwWm42vLNnSONC76wH/OXlPHCmCZsekVuWmX9vcw2iw4XMkze/CzNNhfS6frX7AHDAFfO9Nw1DT/mGfBZdCGCQFfUr62sl3S/WiZDFTJJZWogM2zr9/b/Qz2+2dt7WnqQxh5gyrMSMrao/kd6OCS7o5vFokW+/9vnzX0RK8az/sEkNp61/ae9KphVOoIxsJuj7kK+H2LSSGG9PHN+vnaI+lRnGxcEqqOdPefwclXdX6IJxkKQCasrzqUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TbxfC2U6tCLAznvSvFNeuIwXT1R+1ijvWW3GbsE/b0=;
 b=EH6L6nMnwxRq7m1m6f3biyXLp+E3eaA8GCWp8QlUJ3N2BcnSQxaQ4e0H+ZTXIBy10JOfnK42ktQLuHLDk+70uGSqFJstIrtv+zf6unbo+m7z2T/iKcHB/LrUcYIyK64Ffy7tpuBHejxp0rhbcwWE7VWsMXvHo+sruegBeyE7vbs=
Received: from CH0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:610:b1::12)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 22 Nov
 2023 09:04:34 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:610:b1:cafe::58) by CH0PR13CA0007.outlook.office365.com
 (2603:10b6:610:b1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.12 via Frontend
 Transport; Wed, 22 Nov 2023 09:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:04:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:04:30 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 7/9] iommu/amd: Consolidate amd_iommu_domain_flush_complete() call
Date: Wed, 22 Nov 2023 09:02:13 +0000
Message-ID: <20231122090215.6191-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122090215.6191-1-vasant.hegde@amd.com>
References: <20231122090215.6191-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|PH8PR12MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 40569d43-006d-4686-5b63-08dbeb3a0bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uJ6Zg4UQeaXzGtQOpjEByHgjMwfuqRBgh5i3tJU5rg8sJWoE2vydO4oYSyxxhJvfOG1MPWF8jxQhcCz8d+lUBOS5TMJ7FcwxYWDDveV340iyLsVGF5YdqQbO7/so3MJyyIm5eCmdNtXY/bMtCW7TNxyr4AgKv4lXDaEA1IkTY1pQAVgWgdvA5gXZ/RUpRcWyJjClOuRvQx0nnjJkeSVT68VNxhyZIUH1Nm2ZbhP0jsEyZKjkr36aJVOENqQ7ZC5SIDmDgUaT1cIqOdCxx3fwwnDKKwxYtHV8rRYsLczuED3qGqgYhZ6Indb3m6ZLtly0tsMFKu58EXZG1AoxJCEPbtdGw7er3402LPBBNjfoHbENEAWAJffMSdpW+WcLIY/Ta57/WZz93zU7/rwICb6YqgGf2cYryR1HJikuUoggzJzBh32G441h0QLMT0Go77vdZtfs6bW/1kK+xhYWFnqjb4zeogTNZoeLVXeePML/437Y0aPIXlIlu5f4aIMv5UPy6s6Zac4FCsXzWzKklT9brzSV0h0KgwH2VgkdB9Xmx0ORXAu8ueQ0yNzhexO7wxe+ektwJUnu4W7pLenZAIAQA+hVoV8Jk5w2dVRZh+dHKV5PXyvagj2H+kO/saxErqKuItZpVLbLSzZJkv4nb7Ri1COla0HoCgcfSSuAo4o27E0GsU8nNAQ66rPdhEpJbMQBYRLnK1AtdTXt55JmyF0bCug7+yMNqZzYv7fjLpRGdBnCHRP/NqQdu7UcMLSDBN7m5nIPCIFBnIVvlHyrDwJ8iQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(83380400001)(336012)(26005)(44832011)(41300700001)(2616005)(36860700001)(16526019)(1076003)(426003)(5660300002)(8676002)(8936002)(47076005)(478600001)(2906002)(4326008)(6666004)(316002)(7696005)(110136005)(70206006)(70586007)(54906003)(81166007)(36756003)(356005)(86362001)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:04:34.0546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40569d43-006d-4686-5b63-08dbeb3a0bc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606

Call amd_iommu_domain_flush_complete() from domain_flush_pages().
That way we can remove explicit call of amd_iommu_domain_flush_complete()
from various places.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/io_pgtable.c |  1 -
 drivers/iommu/amd/iommu.c      | 21 ++++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 6c0621f6f572..ca22546e4d1a 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -425,7 +425,6 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		 * increase_address_space().
 		 */
 		amd_iommu_domain_flush_tlb_pde(dom);
-		amd_iommu_domain_flush_complete(dom);
 		spin_unlock_irqrestore(&dom->lock, flags);
 	}
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 11bc222be528..279f0da896d0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1489,6 +1489,10 @@ static void domain_flush_pages(struct protection_domain *domain,
 {
 	if (likely(!amd_iommu_np_cache)) {
 		__domain_flush_pages(domain, address, size);
+
+		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
+		amd_iommu_domain_flush_complete(domain);
+
 		return;
 	}
 
@@ -1525,6 +1529,9 @@ static void domain_flush_pages(struct protection_domain *domain,
 		address += flush_size;
 		size -= flush_size;
 	}
+
+	/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
+	amd_iommu_domain_flush_complete(domain);
 }
 
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
@@ -1558,7 +1565,6 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 
 		spin_lock_irqsave(&domain->lock, flags);
 		domain_flush_pages(domain, iova, size);
-		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
 }
@@ -1836,12 +1842,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
 
-	/* Flush IOTLB */
+	/* Flush IOTLB and wait for the flushes to finish */
 	amd_iommu_domain_flush_tlb_pde(domain);
 
-	/* Wait for the flushes to finish */
-	amd_iommu_domain_flush_complete(domain);
-
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
 	domain->dev_cnt                 -= 1;
@@ -2018,7 +2021,6 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 
 	/* Flush domain TLB(s) and wait for completion */
 	amd_iommu_domain_flush_tlb_pde(domain);
-	amd_iommu_domain_flush_complete(domain);
 }
 
 /*****************************************************************************
@@ -2451,10 +2453,9 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	/* Flush IOTLB to mark IOPTE dirty on the next translation(s) */
-	if (domain_flush) {
+	if (domain_flush)
 		amd_iommu_domain_flush_tlb_pde(pdomain);
-		amd_iommu_domain_flush_complete(pdomain);
-	}
+
 	pdomain->dirty_tracking = enable;
 	spin_unlock_irqrestore(&pdomain->lock, flags);
 
@@ -2558,7 +2559,6 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 
 	spin_lock_irqsave(&dom->lock, flags);
 	amd_iommu_domain_flush_tlb_pde(dom);
-	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
@@ -2570,7 +2570,6 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 
 	spin_lock_irqsave(&dom->lock, flags);
 	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1);
-	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
-- 
2.31.1

