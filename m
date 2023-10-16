Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3A18643
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LUayOPqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sotil5P3/92UX0gLy++T/QxECrvWqtnVgHTAIAj+WlXOQZMOn/gQ5v5HHFj1iAaHa8gQd5uZoj6PX7bhPXWzjflLoqxdnSeehJOACdgDgyu1CW1Z0uxQrPkXEObDw3jWsx2y3bfUV7n045qBFsYfma4rDYK0YwIl9j2Sd7HycA7k4kgHAHGKBV6Gt2ljdm/pQeCOTcH/5n4XGIcysj5If9T7TAYU6qdEcAjd6PRiKlXelJjRDNzZLWsdPQ8pc32FKNA0RHy+1trfj+6UTseP0+D5YfwfZEKNF3KWmlGwCsGJUTwHjVSf1IRSgPzOM/wbfGnTXA9erKuXvc8J62J/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr3AlIMqXh/L7LZMihIzzIeVq0U6aSZpc0tcBJ0ZpoM=;
 b=dbvcKaQohNTSLC3JR+x76RWKIR5XDteZkCqbIBRZunVK3c/PDhXzEqK/dTZAIGYYUgozqvenHFgAUbTO/aict2PC9JUsPxdsCWvHmlE1Js8reXax6xMyWJ5guJSEl35g0zGnfIJ0ahvIf3RdO86XCeI53hwK2Uom1t24/5B+BiZJUuqJhzvcrzFK9cuCmxIDJhKT19/sF9EuKIl4q7mj8vFybNMEYFy8AC+cs/yshiCouSbVcbBOYk138TeJafJUk6s9rAe+Kyzz3LRjavpO0wDdJ90CBF2HL8MSqnr5rHqoaxl6okCLY7xn9l9JUgy1+ucmYZ2AdmpgOMWKSbVt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr3AlIMqXh/L7LZMihIzzIeVq0U6aSZpc0tcBJ0ZpoM=;
 b=LUayOPqwVZL5noc3XsuyqMszVFEg1JqfQ6fTWzwAHEeIx9ynwg88xzAyfgPZ9oSMjNw6zEdWnTxJf8rr/CFtTMBpr2Pt7BQ6rPBVL4X4PHrC9gHVwfZQVqQ65arwcolNIk6KE9qbn6KQ1DMcWSsUBBYKp0rNtl4TRlKVnv5XW7Y=
Received: from BL1PR13CA0110.namprd13.prod.outlook.com (2603:10b6:208:2b9::25)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 10:45:33 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::f2) by BL1PR13CA0110.outlook.office365.com
 (2603:10b6:208:2b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Mon, 16 Oct 2023 10:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:45:33 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:45:30 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 03/12] iommu/amd: Introduce per device DTE update function
Date: Mon, 16 Oct 2023 10:43:42 +0000
Message-ID: <20231016104351.5749-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016104351.5749-1-vasant.hegde@amd.com>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM4PR12MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b66b530-c3d2-49a4-6527-08dbce350632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LHq1RTDV8GpcuO3V8Z26Ft6G4PTy+zcNYUSNNgo6owH1YzayJzuuXh6ahwgyVkwx3OGMQexkkCmTgvmk1uszAinwoLa9GAE43e22UZcze8nej21ROOQPzWlS7MRaT81vW2sBK8KnVlfP8WGcCkR0Rs6mEaYboYyNIZRv0NiJUvr4RLXrSNR02lp0Cpn/ZoQNFAgn6GkgbDCuqfxyGMr3Qsqr4/1YcWawCzxgHDjJApRsehLLXyWR0mHawQCowA+QxY9PPgEQvR6zUTbCsuxtQ/HpI/5/X327+wN4kjM8TZiGkTA50HEFyZCGaNM80Xlz/bYe2ZHtc57xzm6rYvazJLGY5LW80pxVRH3QiIcLW0wJAuLpjgsUKQREFCor4p2njJaBIVEXJDgXxSIqM3lPFNCF1wtHwrOzws3a85quw0V70Eh1JFjuSo+1YmVGxU50WusCfn9gxZ5405Q/7lg7fmXDxVqKxddqUNFUAsJnt2JC2DZu0thNRO06t3GFYCOrbkNzCMVYOiLYRLdbjghlVyDPElO0SBQhutJKhw5qkH1/Gh4WiYhyEEsY3/DZRUhBfaF9TUSuLuLHd+qETM4U7rvOlwHtAFZ82V3XD3PuiHHSoMy8w4p8uUfPo0qn1ma8L0Z4Fm050NggTlFLyHqlP3uUe1DkzmxE4QTSMh/AJ5cZmpn+kVaIntDXrhyYrPT7Tl3oQLWirW32PHOZRiFP3y1vybNam+yhfY8yVJUSf5SPEGf6sIUI71W3efFi1MBQqfQvfc64FQngm2RgpDQ9FA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(478600001)(110136005)(70586007)(70206006)(54906003)(6666004)(47076005)(356005)(83380400001)(36860700001)(82740400003)(316002)(336012)(16526019)(26005)(1076003)(7696005)(426003)(2616005)(86362001)(36756003)(41300700001)(5660300002)(81166007)(8936002)(8676002)(4326008)(44832011)(2906002)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:45:33.5142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b66b530-c3d2-49a4-6527-08dbce350632
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311

Consolidate per device update and flush logic into separate function.
Also make it as global function as it will be used in subsequent series
to update the DTE.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 40 +++++++++++++++++++++--------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 0df0cb03329c..e3c7b99977c5 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -65,6 +65,7 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
+void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
 				  u64 address, size_t size);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8e5d1dcc50dc..39acf98e45dd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -79,6 +79,7 @@ static void detach_device(struct device *dev);
 
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
+static void clear_dte_entry(struct amd_iommu *iommu, u16 devid);
 
 /****************************************************************************
  *
@@ -1679,6 +1680,24 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 }
 
 
+/* Update and flush DTE for the given device */
+void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
+	if (!iommu)
+		return;
+
+	if (set)
+		set_dte_entry(iommu, dev_data);
+	else
+		clear_dte_entry(iommu, dev_data->devid);
+
+	clone_aliases(iommu, dev_data->dev);
+
+	device_flush_dte(dev_data);
+}
+
 /*
  * This function flushes the DTEs for all devices in domain
  */
@@ -1804,7 +1823,6 @@ static void free_gcr3_tbl_level2(u64 *tbl)
 static void free_gcr3_table(struct iommu_dev_data *dev_data)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	if (gcr3_info->glx == 2)
 		free_gcr3_tbl_level2(gcr3_info->gcr3_tbl);
@@ -1815,9 +1833,7 @@ static void free_gcr3_table(struct iommu_dev_data *dev_data)
 
 	gcr3_info->glx = 0;
 
-	set_dte_entry(iommu, dev_data);
-	clone_aliases(iommu, dev_data->dev);
-	device_flush_dte(dev_data);
+	amd_iommu_dev_update_dte(dev_data, true);
 
 	free_page((unsigned long)gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
@@ -1842,7 +1858,6 @@ static int get_gcr3_levels(int pasids)
 static int setup_gcr3_table(struct iommu_dev_data *dev_data, int pasids)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 	int levels = get_gcr3_levels(pasids);
 
 	if (levels > amd_iommu_max_glx_val)
@@ -1858,9 +1873,7 @@ static int setup_gcr3_table(struct iommu_dev_data *dev_data, int pasids)
 
 	gcr3_info->glx = levels;
 
-	set_dte_entry(iommu, dev_data);
-	clone_aliases(iommu, dev_data->dev);
-	device_flush_dte(dev_data);
+	amd_iommu_dev_update_dte(dev_data, true);
 
 	return 0;
 }
@@ -2138,10 +2151,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	}
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data);
-	clone_aliases(iommu, dev_data->dev);
-
-	device_flush_dte(dev_data);
+	amd_iommu_dev_update_dte(dev_data, true);
 
 	return ret;
 }
@@ -2164,11 +2174,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
-	clear_dte_entry(iommu, dev_data->devid);
-	clone_aliases(iommu, dev_data->dev);
 
-	/* Flush the DTE entry */
-	device_flush_dte(dev_data);
+	/* Clear DTE and flush the entry */
+	amd_iommu_dev_update_dte(dev_data, false);
 
 	/* Flush IOTLB and wait for the flushes to finish */
 	amd_iommu_domain_flush_all(domain);
-- 
2.31.1

