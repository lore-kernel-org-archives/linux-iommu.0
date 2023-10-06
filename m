Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593FC15C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UVhONdYa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnEtlA+iPRkovqvFwKYAd3FS7xxuUwz/Vkb51IrwTVXGTjigGdNWCRIBBLK+Qx+zn8sPrUrjozngPmhmX7R/Guxr8TBKfNCUEj/ZLhdJXHTB3GwVZ50/KkzY4TQaEnY3Yg8cnu7kSapD8guHH4LlnDZaup4uOryBvJy3T8daorEZMhwQhfn2pAtk1QTAohhxMN+H9QYKgZMwu/ZMGsEYpfwVIuVtc0iK60neXLzUMfyY/AjpIavccWdnDw4Jne3JtE39Z0IOPYh5pTKUnaeK4Hm6V2/SYTlNP0Hh24qI+24sDcCwXsCIf3///ZYGqWisWXGioXfqfzEU0V/rEA4a8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBreAkDRF1z22yiSZSA7YJ5mk1mUi2+NYdoofZlPEes=;
 b=HuiSQbgI/rMYJ9zh1SDRTrtYfSH/d06q2oUUeEOG4Ti9GYcnAfb5XrqeKQwiAIi+GtZZApifyqarkjmo3MIU0s1vnhYu6+UDRvJ6lqRMikWPDoYdlGtOzcDNhbrn1um/B/02mY5+bcqFfQ9L+RZ3jZb0rSKdbi7+yfsDW726uFBzgXAGLURTYrMcbcMZT/DKrD6UWg9rRpP97ImthNHYcCBBl0kUfIBGP/g8VuklR5iV8tY4Wa1kiaRbrU2XTbkvDNgAr8SzIzCDPnVvXpAyMantrLInpa7FK6NseCznLDp+Sg++0HBlStaHc/hpSvfOxM/uKBVHRdyJjlyJTSeW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBreAkDRF1z22yiSZSA7YJ5mk1mUi2+NYdoofZlPEes=;
 b=UVhONdYaJt1NytZzU6hKZLK4qxZpiXk16wSoRswr9lKSgDvbjfPfpgDncXGDqc+NaNbKMdayTvyTYWAY8GkcOhI7mrhJr7taG0+s4ycDCQJJ3IfmAQCeTQ/eCbzJaV03wXyOnHkct+vT6EYQJ2L/EuwCnuLWQot/QOnyocSZB3c=
Received: from MW3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:303:2b::6)
 by BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 10:19:06 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com (2603:10b6:303:2b::4)
 by MW3PR05CA0001.outlook.office365.com (2603:10b6:303:2b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.29 via Frontend Transport; Fri, 6 Oct 2023 10:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:19:05 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:19:02 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 08/13] iommu/amd: Consolidate amd_iommu_domain_flush_complete() call
Date: Fri, 6 Oct 2023 10:16:19 +0000
Message-ID: <20231006101624.5912-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BN9PR12MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 9230bd2f-6658-4ab5-201d-08dbc655abba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c6AsBvUYS3M3AAfBdAmriY5Tn+iVrENiMW8K5gznSkNIMYFoLAWlAskVr0dQ4954ATDlZKDm9uhCdCEAbS59mZC7ZYHw/cHMerK1zEHyeG+OdiTVFfBaBjb+Rbz8u3FePwjaudpJobFwZSKSHqZMzxWfnprJFlJnufWVkfFnWe54zukOGP1YWjxBiScuRNNO0TcbZ7GhT+OTotEu68pKpWwgxaSmNDIw4EimFLidu/6Yy1dteQSNsrwJV9CMy2hwMCDZqtAlAwy6h+A7PkqpUzFJ5RmxItXUqd9Nnkx3ZsAvVj4ERPEUhQm6mhF8JGLCDqnOxUHJcJN+iAp9/qKgnAnVvUg7Zu103FaWTEDjcAjLNdqn67MFUekAcy3PJMSa065QCtUlTbCUju6svYRqmQGins+dRyBpC4cEcr3y5DBD8+DjolB+oNGiHIV1y1nXSwmaDWkNj+3WIc6PxBZO5M76n1oDsi42h1UvHiWcW2kvvcTFcIRpkQdUz0GIxO4Lvv41PIV/d7rlTsKhYyKUYHWfA4lBUaisxIcFQRuP96QtsEvxbWS8mKI6R5ZfXaGIqEwpeeQKLmNaRO4zqw5buVdrW+Ifnb6hQAzdmhtDJO3yqCPv8xJvhmWiYt+TaZ5lErzftpdDl4f4xEi2f2tsLnEJRJBYj2MUkVvrja9hmj7/XZC4CppZ8gYu1RewPItsdTcu3huwJeTxezoeyuDFVkSD/3ZHtFWQrtJ+SSiTYaiKkOEjTh68mvED/+6OREu8aqjTeJUqCVCgQakf1s4xUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(83380400001)(478600001)(40480700001)(40460700003)(1076003)(356005)(82740400003)(7696005)(81166007)(36756003)(2616005)(336012)(426003)(16526019)(26005)(6666004)(70206006)(70586007)(8936002)(8676002)(54906003)(4326008)(86362001)(110136005)(47076005)(41300700001)(2906002)(316002)(36860700001)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:19:05.6960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9230bd2f-6658-4ab5-201d-08dbc655abba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321

Call amd_iommu_domain_flush_complete() from domain_flush_pages().
That way we can remove explicit call of amd_iommu_domain_flush_complete()
from various places.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/io_pgtable.c |  1 -
 drivers/iommu/amd/iommu.c      | 16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 2892aa1b4dc1..2f072c434fd9 100644
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
index 9a7f0f571862..1f695dd50fec 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1508,6 +1508,10 @@ static void domain_flush_pages(struct protection_domain *domain,
 {
 	if (likely(!amd_iommu_np_cache)) {
 		__domain_flush_pages(domain, address, size);
+
+		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
+		amd_iommu_domain_flush_complete(domain);
+
 		return;
 	}
 
@@ -1544,6 +1548,9 @@ static void domain_flush_pages(struct protection_domain *domain,
 		address += flush_size;
 		size -= flush_size;
 	}
+
+	/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
+	amd_iommu_domain_flush_complete(domain);
 }
 
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
@@ -1577,7 +1584,6 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 
 		spin_lock_irqsave(&domain->lock, flags);
 		domain_flush_pages(domain, iova, size);
-		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
 }
@@ -1852,12 +1858,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
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
@@ -2034,7 +2037,6 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 
 	/* Flush domain TLB(s) and wait for completion */
 	amd_iommu_domain_flush_tlb_pde(domain);
-	amd_iommu_domain_flush_complete(domain);
 }
 
 /*****************************************************************************
@@ -2445,7 +2447,6 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 
 	spin_lock_irqsave(&dom->lock, flags);
 	amd_iommu_domain_flush_tlb_pde(dom);
-	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
@@ -2457,7 +2458,6 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 
 	spin_lock_irqsave(&dom->lock, flags);
 	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1);
-	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
-- 
2.31.1

