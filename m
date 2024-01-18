Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC7947F
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563287; cv=fail; b=B19TyznDVSUoctfItMKv+/R1BdL24ZeCF1gbPcQHKhxkLQD9TU4fqhw3WqDC+vA4om2bE9ltd+QcrGyrD2/BgMKB8KTHpvjtgImmQZX/0H2V4Zd9NMqywdBo8kL6eEAKLkN5W8z4sSwHPzu/4R8N4ZXBq8wv5/qzESAcN+rejQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563287; c=relaxed/simple;
	bh=xWNCWybZkRTgPGLVMWTyY7oa2X6j6kuaxg2rUWJku0Y=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=aW0XgBeXh2vOUR5oRgJoUNeCc0lS3js9LAnXNZIBWJMUCQ/ElsuYDgtcFCVM8mVTlTASUvG9xcEdZLdfEtqY1YUb7AAuqir4nvfkXfSDbraz9foQg3m75WYeJhw2cdr+FsUJ4CD+ZlQKp+nFiolF556j6P3sAOGu3Kq90DGnWFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pAenDgeU; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pAenDgeU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1b3V58ePChNSBQ++0jvcavB081DFFnMRsnqBggpegA7HsmN9Y7Y3/W2ITPd6/dGAmwP/GRQRWO9jBbbWZImjW1Xiudpvi843waFL2MtEIGseHCMe4tIhccGdT9iYXkkakX5c/zT++HXEDdFP4AZp2nb9BqQzf4L0aQkk2gVu0tcq7hBYsJgVsM1TssepJPXZAKxebXUdbEG3NnUSU3QJU9CQ68rseokSy3IlIsv5F6dICZqxsVJxuCTWKnjFzVYp7A32E6u/PeKHiUfCzMT7nY36HiBnEIlJf+4UsMLrmfiX15E/kx4CgD+7CZLswZypgQWWNR3yFfVxkygahgmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp43R7OWaRifZ5//m0d2gp0Q4xFZ+i8+iQuMfimLFDk=;
 b=bNiM/dkBnw77fO0kWTeia5KyjX4KZ1vbaQA59JTqz8gF5ysGINHaHGYMIUdnN4UR+x8QLLY/L/BB4hVriPz8pkviR7+eg2WCb7Yke6c4kOwxMgYeYNjJh/fT1dxveQ34CjRODy9tEQU8U5wCfDM8QnMHurHHDcqgzDcGExlacvTLzGUVRgGPD1pIxZcbk/kpHRFA2yzgBnPhjunqNnmzSyVuPYU4gJFMfH3TdCEqPIoHhtkNRk9saStmF/Sdc7cAvqEwWfEzJupJq807bOIMjbQ73Nc87zzbomid1VzXAT8by7EDqSPvOQ6xxXX6cVSITv01doWKedIDDzJGarFPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp43R7OWaRifZ5//m0d2gp0Q4xFZ+i8+iQuMfimLFDk=;
 b=pAenDgeULmQPEgmHKHz7Arosg87kbnM12SOWrkzKkJKyp/+MwYUjVnR6kplUohPqxdlNVD/CcLYYfYnw+ZnO7xsG4OsfFIuELzWJRSgYsFF7MZ6J8eSacb3MI5AZRVrREyShbN7p5Lhk1HLPEAh2YC/eCrWY3R7pU0B88qparQY=
Received: from SA9P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::18)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:34:43 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::66) by SA9P223CA0013.outlook.office365.com
 (2603:10b6:806:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:34:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:34:40 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 02/14] iommu/amd: Introduce per device DTE update function
Date: Thu, 18 Jan 2024 07:33:27 +0000
Message-ID: <20240118073339.6978-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 7889059e-2331-4521-de07-08dc17f7f06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MERiUjWXhb+K7AgiTm71PWq5JX/4XlZrzIpz/X2y7lffRgne98TpKxQtmKrkrEafChqp+pE1ZVgOI/yuWDNurZiIwsKg15ciRYhJ9auxouKFuGwDxLr29Up57GnRTEmZt14YHDgRhJBQQOa3SdtwyTufG0jjL7MJj1t/SrlGlFD5wTA7Nf6FUyO0ud5HydFS65peaVhNzrtUycQOE7lVJ639KC1JJZNB9IkvXWFm1AxZyi2JPIY8CW0ucxud7Mo7wNDfhLKTG0tK4lOU370EHIo7Mg84tr5Pluxv+7xY7ScbpgoxTiZiQenvzUMza8EBrC13sZn7tce78Wiaiqu5IYpnz4itc0ckNQl0sftj5N2bTwZIXGPYEPFoyhCOErs9B1K8UhIOK6EKiUBGjns0YU+HTnurSaUaM1Z4qGKoKf5t0vhaNC4mndsIzgX10k4h7zvFPdOQJLrTgeu+5ljNrr72g8H0ovD30M37cGTG9y+3LsM8mkjU7lytHIZ6mvgdndSUpx/2NKMYbNikqp2b8BzfPgs6cl0SZU8vpVcwSsz63N0AInx9m2GAIxRUBkkgOWjW4K5MSvV5bVAU3BQep7zn5MFbKW6/WluASnlpuA/x1FKbwcMkH+zQiCOtcrIiYp2QgZlTx7p2+ZbYfgZ8EDAwqH7T10mJ6A9gI3/stg9c4i+L3b2CAXGnVRtpHwN2nvslcFzG6yOAombSbOwBmKbLrv0Ay23VhfyoY0fVKdvOlXIjFHzOYTBEPQpdDRX1HUGbTvRmywcIALtRYZkylw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(86362001)(478600001)(36756003)(426003)(47076005)(26005)(336012)(356005)(81166007)(82740400003)(2616005)(83380400001)(1076003)(16526019)(36860700001)(4326008)(15650500001)(7696005)(5660300002)(110136005)(8676002)(316002)(2906002)(6666004)(8936002)(41300700001)(54906003)(70586007)(70206006)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:34:43.7170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7889059e-2331-4521-de07-08dc17f7f06c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010

Consolidate per device update and flush logic into separate function.
Also make it as global function as it will be used in subsequent series
to update the DTE.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 334394d14753..24a04731ac8b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -64,6 +64,7 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
+void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 256b5507272f..68fd1251b981 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2000,6 +2000,21 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
+/* Update and flush DTE for the given device */
+void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
+	if (set)
+		set_dte_entry(iommu, dev_data);
+	else
+		clear_dte_entry(iommu, dev_data->devid);
+
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
+	iommu_completion_wait(iommu);
+}
+
 static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
@@ -2039,10 +2054,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	}
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data);
-	clone_aliases(iommu, dev_data->dev);
-
-	device_flush_dte(dev_data);
+	amd_iommu_dev_update_dte(dev_data, true);
 
 	return ret;
 }
@@ -2061,11 +2073,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
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

