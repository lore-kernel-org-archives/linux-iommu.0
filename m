Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAD1C30
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAwV8/HzCeZY6yWgRUEBGFaYyozUGfHSpXhn8SQzKEkyA83g9UFU6g60oQnIsZvObMG89HMppR9XtuiMrhRXIo/LYIVPsAEGO+blHQcWsa4vrOUJLx7lguobW1IfR9I2lXEjCfp3ZELKPLfDFkiWypjwy4IifWJGq95+9aWb3yiafvN+zg+lTukY06RAeRcuk8XPtah/q0D9Lxf9xpHKYu0RbhW71HwAL0k0m8BFsWgU+POMu9HaYGHCA095L+r2ujYX7EZTSrR4WyHwzUCd9EfhBUKTn9fnkYVfNUsFLLgH2WqYbSFXhfVSSZowKuaJyM05/TuaAzdTQR/9KpqlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YE2X5RT4zEbi/iaQ6PsgIm7WxjtqlTAxtNnmaiGu2ww=;
 b=hMJwLn4AZeI8BMCWIG6u0CmMSKyfEFhimhyUfxxNkI95L7dgVbbT+61gMh7l2QfqWdVcfj+cu91r0CYNsWI8qOXFkR6Jpn0wHU5B7S6qpir1SYVOWUS3eb+H0XKYF0+NedmZf4aOYRa8LCVeP3XUzGqF4p+OekY3wlsg+wY23ql+cP2FtPDyLLA2i4obmM+A+7SD3l1eRtX5n8b+rHOuWtZWgELZ87xdTzMV5EvwcJrKlKIZZwC2jLk2IoJipCfHAL+YXtn5VSQmXiFtcjpC6NxQxP2jVUoJzFpW4uizXPx8MQ9hQLOJgMQkn0h01a+0bzaTjcoUA8In+fsukXBTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE2X5RT4zEbi/iaQ6PsgIm7WxjtqlTAxtNnmaiGu2ww=;
 b=K37ukd7v+R+oluWvCSHEeuDaQgDU4OEMr5tObDxItwCJYA7LICuErHUWeqKzMKSKcM5J4hZVaXzvzeXjhDKyOHsAe1JlqyYo0XUTbMhKJYjI2CgUaTVEJsdM+V+A6dps+ZNIdoTzwmVRfnTJW8Zic19ejXEBg8siarcjXQ8+HJU=
Received: from DS7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::14) by
 SN1PR12MB2496.namprd12.prod.outlook.com (2603:10b6:802:2f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Thu, 25 Aug 2022 06:41:56 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::e7) by DS7P222CA0004.outlook.office365.com
 (2603:10b6:8:2e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Thu, 25 Aug 2022 06:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 06:41:55 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 01:41:53 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 3/9] iommu/amd: Add map/unmap_pages() iommu_domain_ops callback support
Date: Thu, 25 Aug 2022 06:39:33 +0000
Message-ID: <20220825063939.8360-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825063939.8360-1-vasant.hegde@amd.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: de60767f-1394-4bb8-e61b-08da8664e71b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2496:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PyA9C7VQ2FhmFehfWV16KPUvdbPmWVkNDo0gqhrGzC9EiftR80csBmCtDWIQ7Icvm9m517LdJaRLrte2ZOnyAcHR1r39EaUl7XujnIiJPTYCnUrp7upptR+FC3bxG61CkIYuoY6y/Fu1Y1UALihvVxt0KE22z5GeyjEBDCoeYxtJaco5KS8YkJgkmcwNB0qpFYLl0zirk0gf37l0DuR2rEsa/m5JrE0iYqVsD50uxzINUgb8lCAQE5l9Eh8G5RKRa/qzsVKK4UquMDwWTWThNf/OY3kXn1bP/+IxUuDCTcvAaTlGrXmhOPexU/6Y1khNuRHbDSAgAeILcLTtLhgb/yJScl1tigZA/sI8n6I5YxLYH/axjWdzJBIX5jSCdVz9IUkERDhdPBPAzw4V4RTZMbASM4peNLABmlGKXcrhz8jkMTszMI5jXPjPjj/NWjr7OeC3RyG9vKrItpQRXSqynu+OzD48Qrxy/HrdayWUYvikgMXQ+Wpw4WrRuwENVE1vZWPoWBQav3F3CeIrWi4bAm/+zPRaNZvU2NUfNsp01DekX29AIPJaLPpf/AOrwvnmvRB3FYDVqbLVsawHi5t3MAfVqOzdp9nrt2YuWRRHfUo9u5jUPdHEgQ72QZ9RmeRXfKJfOEPhlalKaNyHMl1s1Y0OqChOlmRoZecmhhhvbgdrOk2D20k9082s7t+noCMHn2rqp7wMSoYoSX93DChvWv7S90aIQt0cKfXS0y9RmWQxTrQHVPKEww5KHAOLykomZhlAVRliAkGblPV7elJEMn9TaghWPayQLEcrsf54k3F0vLzzaN3nLnwJKwXgju0x
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(36840700001)(40470700004)(46966006)(356005)(5660300002)(2906002)(186003)(44832011)(41300700001)(40460700003)(478600001)(7696005)(8936002)(81166007)(6666004)(86362001)(36756003)(40480700001)(82740400003)(82310400005)(1076003)(426003)(16526019)(47076005)(36860700001)(336012)(2616005)(83380400001)(26005)(70586007)(316002)(70206006)(8676002)(110136005)(54906003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:41:55.7469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de60767f-1394-4bb8-e61b-08da8664e71b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2496

Implement the map_pages() and unmap_pages() callback for the AMD IOMMU
driver to allow calls from iommu core to map and unmap multiple pages.
Also deprecate map/unmap callbacks.

Finally gatherer is not updated by iommu_v1_unmap_pages(). Hence pass
NULL instead of gather to iommu_v1_unmap_pages.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f287dca85990..c3733884377b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2174,13 +2174,13 @@ static void amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 
-	if (ops->map)
+	if (ops->map_pages)
 		domain_flush_np_cache(domain, iova, size);
 }
 
-static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
-			 phys_addr_t paddr, size_t page_size, int iommu_prot,
-			 gfp_t gfp)
+static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
+			       phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			       int iommu_prot, gfp_t gfp, size_t *mapped)
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
@@ -2196,8 +2196,10 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	if (ops->map)
-		ret = ops->map(ops, iova, paddr, page_size, prot, gfp);
+	if (ops->map_pages) {
+		ret = ops->map_pages(ops, iova, paddr, pgsize,
+				     pgcount, prot, gfp, mapped);
+	}
 
 	return ret;
 }
@@ -2223,9 +2225,9 @@ static void amd_iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 	iommu_iotlb_gather_add_range(gather, iova, size);
 }
 
-static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
-			      size_t page_size,
-			      struct iommu_iotlb_gather *gather)
+static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova,
+				    size_t pgsize, size_t pgcount,
+				    struct iommu_iotlb_gather *gather)
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
@@ -2235,9 +2237,10 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-	r = (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
+	r = (ops->unmap_pages) ? ops->unmap_pages(ops, iova, pgsize, pgcount, NULL) : 0;
 
-	amd_iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
+	if (r)
+		amd_iommu_iotlb_gather_add_page(dom, gather, iova, r);
 
 	return r;
 }
@@ -2400,8 +2403,8 @@ const struct iommu_ops amd_iommu_ops = {
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.detach_dev	= amd_iommu_detach_device,
-		.map		= amd_iommu_map,
-		.unmap		= amd_iommu_unmap,
+		.map_pages	= amd_iommu_map_pages,
+		.unmap_pages	= amd_iommu_unmap_pages,
 		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
 		.iova_to_phys	= amd_iommu_iova_to_phys,
 		.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-- 
2.31.1

