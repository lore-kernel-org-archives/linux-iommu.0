Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065957326
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MV29lzES"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSlJ6RXiYHWoNJ4yqhD/m9SuQlOlwus18KeIsgDNh6jrO7FoNl+zYehGfFJOi3+1dCibZsHUq7jni3GmatyJNBFsoPzgSPUa20Xh/xYK07Gs5wiAHsnFCKCvisq+r9gVv4wt8RhroOxT+BNxXSjyUGM4+KBZCXcX8Y4JiYvZ/82d0GQWmg8vK4Ukhyz2Ozg8GeH+imtFNgNzZ4SX2Pkb8GpDWg2QWocYU2wOooXZk8OG3qabpOjaZdTErilRpYyMVxfA6bTyEw4jCncaS2WNzMf5mJnxlC8qlEi5L9vHAALCIM5ZrMAXf/qAGmTxkQRK8l529dNednjyoBOcspuHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKyss+WOrw9f9YP2yOpxIDEkFei7fQN5zRS6rl5VJVY=;
 b=WiWjii1QbTlkjPWbPJTIUcNOpHGvgPBOmg7yciM/v1uk6IuPwuvA5uF/zt1CB5iOZt0Yr19wGRQIMb+rUEPKoTbt7AKgTtZHlr+YGaT0SDrFbL625TNzQTyCYWcdFAcWcXZ1gQsYRbTxf6SOiamSe0rRY059gvqoy9uLUHO4aSGn4TTknRbHG4gvzxYMWuexfnfKx4IZTdK3wkRu85cjZhFw0oN5D2KKTrc0q1RGSTo7O2qsNv0NchZSO4YDCd4sJM007L0/sD3Te5Glzjmq+GqKt2fMMmvRJjpUhzObgM7dgZ0DCIuJ7KLTwpCaMLDIW+7bxSWLkWXMTFUjdc9MMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKyss+WOrw9f9YP2yOpxIDEkFei7fQN5zRS6rl5VJVY=;
 b=MV29lzES2lvM+Z26sP6IBDWYgRXMqsJhomtOB8hjYcnB+UPvDrrj+35x6r0lfsnS/M1J3MHZdzmSUPce7lzTQ+VryU0n+Yf3aX7cWxQZTe8Kxaau9L8x5v97s0UViIDyXID2M4n7fPJ5xQUrjDrrZLsJsuhrCHm7luZYVzhHLBg=
Received: from BYAPR21CA0013.namprd21.prod.outlook.com (2603:10b6:a03:114::23)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:57:10 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::4f) by BYAPR21CA0013.outlook.office365.com
 (2603:10b6:a03:114::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.4 via Frontend
 Transport; Tue, 12 Dec 2023 08:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 08:57:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:57:07 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 11/16] iommu/amd: Refactor attaching / detaching device functions
Date: Tue, 12 Dec 2023 08:52:19 +0000
Message-ID: <20231212085224.6985-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212085224.6985-1-vasant.hegde@amd.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: e6968722-10ba-4ccb-0933-08dbfaf05395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/oAeiDiGKCwj3pYUqFtD4PAN/3Mq1Xkz7mht6+re9yauNZapaOpCfwPUQZ+E145/iI2fus29BX156cj7fViad7nM701VmCbXIoKLRXKpgZZ+iy5tTPUoShJICv8Zyn5bDuACrX2zB3uqLpWEF5bQFYn9gWEJ5qjLWTlfMJcRkw4FjIc5pN7PEJgXdCymMgG69BZM6VpcUaoQ0jyn8GMMv+nKvXEAX6zxX7qtkdclTOBA/H5KwMyenKdZArxF8q6H5WK1FQZ6p/+qlwT72uTOMywtVIUVW/+COp4OwcO42UHHxDjbNCcYj/0vUZPcS6DxmQHgdS64SfoDquTLCUaDgldSfIe4kuQwD+YkdW643ceqU5AC4k/XyduK++6Syujt1o9J1E+3k3P5I2zbKevNr58VAQZwEQsXlS8jAQlMw7AdW6ucbdyquB0qcqpLKDMQT9vDzI8F3L1GHqHGNUdm6C0q/eY+0NLUczNFJdqDZcyCzeHjHDeqIAHAG1caI6uN7tOgUU7n7jVazP/r+caBpyYoQxBNMr3ZjqZEI4Iq3HruE1dvvJO6qPlrsjJ38TRp1cBgWZ+Ikfkbh9aip1t0bAen2BMhz3rCfKiuiCuiHxRnNZD9GXNfcp1nzqrsrgwuiUR4Y08wt/pKTbJxpdXgThKbKoOfLKUEfFjGxPm1Pyd8E2WNF7Qg+PK3glK3jmizDoWk3l+pucH88N+19rVZtwc9qU+F8QpN/L9mcLVDAiFNYzihHtaul+IzxAzcEaZZjSAdsF+hZ11kc48LwIezyg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(66899024)(41300700001)(8676002)(81166007)(356005)(82740400003)(478600001)(8936002)(70586007)(70206006)(36756003)(110136005)(86362001)(54906003)(316002)(26005)(5660300002)(1076003)(7696005)(44832011)(2616005)(336012)(47076005)(36860700001)(6666004)(2906002)(83380400001)(426003)(4326008)(16526019)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:57:10.2709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6968722-10ba-4ccb-0933-08dbfaf05395
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

If default domain is configured with V2 page table then setup default GCR3
with domain GCR3 pointer. So that all devices in the domain uses same page
table for translation. Also return page table setup status from do_attach()
function.

Note that current patch configures GCR3 table with MAX supported PASIDs.
Ideally it should use 1 level PASID table as its using PASID zero only.
Later in SVA enable path it should be reconfigured to support MAX PASIDs.
This will be fixed later once SVA support is upstreamed.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 834c0a79fc17..2f4ac415e8d8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1973,10 +1973,11 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
-static void do_attach(struct iommu_dev_data *dev_data,
-		      struct protection_domain *domain)
+static int do_attach(struct iommu_dev_data *dev_data,
+		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
+	int ret = 0;
 
 	iommu = get_amd_iommu_from_dev(dev_data->dev);
 
@@ -1996,11 +1997,31 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	if (domain_id_is_per_dev(domain))
 		dev_data->domid = domain_id_alloc();
 
+	/* Init GCR3 table and update device table */
+	if (domain->pd_mode == PD_MODE_V2) {
+		/*
+		 * By default, setup GCR3 table to support MAX PASIDs
+		 * support by the IOMMU HW.
+		 */
+		ret = setup_gcr3_table(dev_data->domain, -1);
+		if (ret)
+			return ret;
+
+		ret = __set_gcr3(dev_data, 0,
+				 iommu_virt_to_phys(domain->iop.pgd));
+		if (ret) {
+			free_gcr3_table(dev_data->domain);
+			return ret;
+		}
+	}
+
 	/* Update device table */
 	set_dte_entry(iommu, dev_data);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
+
+	return ret;
 }
 
 static void do_detach(struct iommu_dev_data *dev_data)
@@ -2010,6 +2031,12 @@ static void do_detach(struct iommu_dev_data *dev_data)
 
 	iommu = get_amd_iommu_from_dev(dev_data->dev);
 
+	/* Clear GCR3 table */
+	if (domain->pd_mode == PD_MODE_V2) {
+		__clear_gcr3(dev_data, 0);
+		free_gcr3_table(dev_data->domain);
+	}
+
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
@@ -2056,7 +2083,7 @@ static int attach_device(struct device *dev,
 	if (dev_is_pci(dev))
 		pdev_enable_caps(to_pci_dev(dev));
 
-	do_attach(dev_data, domain);
+	ret = do_attach(dev_data, domain);
 
 out:
 	spin_unlock(&dev_data->lock);
-- 
2.31.1

