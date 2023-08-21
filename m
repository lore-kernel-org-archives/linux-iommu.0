Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A8187B
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzdNG4tZOm+Sx8I9OBLdHKWeBLXH4x73HWoI4iYwqVt9lVhMKsMuHU7jTRbU7TQtJPxnxafVDNUtRAa61FEcwj1/Xzxw1C4JbJFpkHpFZlbd2wEIbPTicg2saeVmourUo2nZT2vQcEkVegnyyScznh7k6UxFywGSqBsnzYehnPX3PDbD0mqHmkxwfrsokWZg+sEo89EgXad2+9i/0GDydiGsC1hbsGHUZyYn+rNsFWuPy9749CdlpJ2h0r+LTVgYGLTDeN3PIe+jXxv2umezYwkkp5SMr3cKpkyx5JE2yeyAmTJ/c4cJj/Rl6k8OTVV42k7i11aoByi6XO35XpR43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GKwMpgccG9Zy49MuAeCWLnKLw8SV+k8Sl8J1GtTLHA=;
 b=Vx3eu4FGK4HPg5VCX0hwGTSTXvhaJ/g5zvEfDdJbgBPKVmG7E6+VxjIjBKWfEiUF8Vxye6lQL+PdOnUTbev8F8D3lUsgUDn1wMg6OwK6iZeAd4h9faNfQjg5EE8AIykjvlRdcB1oCQ4Rhg7QKwaDFf9WfHRIUO6C/EZt3bgsa9JD2qZdMv54e9m9vpged8xnN8pDvvqpZPLzrLPQLQ7r6wrYcznc6w4ATZsOnlt0gW/YnuJS9tlrnFgAn7NkUKsEGSmpwLYoKT9nSXc0dk9r8i0TyqtMxyf1YGHH2+doElsZZOafOL/fJBBJvNC1trRj11DHOx21tcXsYGfg0THlXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GKwMpgccG9Zy49MuAeCWLnKLw8SV+k8Sl8J1GtTLHA=;
 b=wa70r7RRlmiw/TXbba3g87DGOHMBHM/p6F7BqNByklA3GLxb1u7hF5wnj/5bc8pAzUjskjEdl6wQA9fjHpQaDRTd3O55Pw2KHtv1ebIr1+jb9RQzhWcAerys91s8Du1+uzZe+JLgrRoflL/KyizVlxj27niTsr1iSe63XbaHtDI=
Received: from SA0PR11CA0206.namprd11.prod.outlook.com (2603:10b6:806:1bc::31)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 10:44:16 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::e4) by SA0PR11CA0206.outlook.office365.com
 (2603:10b6:806:1bc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:44:15 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:44:12 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 03/14] iommu/amd: Consolidate logic to allocate protection domain
Date: Mon, 21 Aug 2023 10:42:16 +0000
Message-ID: <20230821104227.706997-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf2c3a7-b4b4-4552-5932-08dba23390db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sEVThsYtzz5lwQdrk6PemqywnyReGIykFKh9D/K6xLAYD1qjam2nrwi1g/7Ngwqbb9aUkBj2P+Plvgmvoqqav32TDGhGLROlFfEekWYxT1C7TBt39gQnszCz6ox0BKYLbq0wga4h+CcMv7lZLHXPzPEHXYPW/gSTCTuChuIsLwdnhdH73vfhVNtTYnF08fP99W3LTdUHYxUi7EBYTX2cGSDb6puhamPug2bm39kJ3thHZggLeXFjLD3muWPcDVnIfZZVRcsbagsh3+PmjUGwgVvy5rtvjOMj/7RWnPr+Qm2Q5i+7KqXpOkdLOFv4UWm+bra8JEIOfujNIEFxuZPdmzeDH1/qCwBjv6dK5JH6/Fpp7/Pg3fUaeE9iWDb4m4CcEB6lR3k7vT+Zkzayhoc5nFrpmBXgqyQZ0IK0yRs02Mzu8VkGnOX2aJSSzt2V/1xuZUTJNwn/Ud6ulS2KfDkUM0sFNj2QOv14otlvA5vm+2OFh+LXEEYNg7FeTM7rYMQxSliYq/anyyElBDKOo/uNs7jKBdnuMDQTN06t93NgHL5+95rg6rwqs18Pb7ZaIvQWeKMsNJ70D2ffbMAVF8H0ygzH2IZvfAyCjx4OgH280G/aXEDdfQA3nE0AYBkMZ4y4I2wp6OgzxLB6qnjLzKq1+6MxLgAdYViqPjdSD6ph8ma+nSmBDTj+jtrLb5jH8/ca3oxAehamA6N62h5STb0KJCLBQrd379AHq14sqE3P4x0hckjvYA2UQoixICQ3EaVG8zKpQ09Xx0JBCwIrzxq+jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:44:15.9758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf2c3a7-b4b4-4552-5932-08dba23390db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Move the logic into the common caller function to simplify the code.

No functional changes intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/iommu.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dd586f69a9d8..c2cb541b0553 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2046,12 +2046,6 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 	BUG_ON(mode < PAGE_MODE_NONE || mode > PAGE_MODE_6_LEVEL);
 
-	spin_lock_init(&domain->lock);
-	domain->id = domain_id_alloc();
-	if (!domain->id)
-		return -ENOMEM;
-	INIT_LIST_HEAD(&domain->dev_list);
-
 	if (mode != PAGE_MODE_NONE) {
 		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!pt_root) {
@@ -2067,12 +2061,6 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 static int protection_domain_init_v2(struct protection_domain *domain)
 {
-	spin_lock_init(&domain->lock);
-	domain->id = domain_id_alloc();
-	if (!domain->id)
-		return -ENOMEM;
-	INIT_LIST_HEAD(&domain->dev_list);
-
 	domain->flags |= PD_GIOV_MASK;
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
@@ -2112,6 +2100,13 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	if (!domain)
 		return NULL;
 
+	domain->id = domain_id_alloc();
+	if (!domain->id)
+		goto out_err;
+
+	spin_lock_init(&domain->lock);
+	INIT_LIST_HEAD(&domain->dev_list);
+
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
-- 
2.31.1

