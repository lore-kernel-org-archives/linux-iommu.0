Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841314010
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148283; cv=fail; b=alTC7uxGOc53xLChUllc81hGRfXmsBkWKd5wsfDK38MIu1i+GRgbCMCCfCWwO6VjZTeFikjL0vBVkcFdtXM1X/ruYePSPHgaGZddID4QxxZW4rp6CBSjbG9kukbXV2R1Pkf72VnBuh83O6EGa1EHy/oom2tHbKqg1v4DojtcJMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148283; c=relaxed/simple;
	bh=6PVlhQkv/iyzasNgwxst64sXoUMb3WpyKVu38sVlqMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FP9CeZv8kHVTeRekdSVV4yjvXbNDUpg11RD0bsySOXGt0qZ4nPtRPTEpx/yOaW1O0NOfug3grtHez2khindYFtAfrbNezvtqSSPc1+jkOJ2FDZjVlemKyE+P3dzjYfnJ9c6T6Ht3asQNo47od4G6rsbvOCbg/W7KaIa91pHslCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gU6nkTsQ; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gU6nkTsQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nC91eD0iGEhnzUekfgNaq1YyoXftvFdkxeKPykdZNxPRgmzK2kHN4rTcMqsQ4+QCWhVC8H57hgIoVCcih5EyhWGUGsLAa80Zazq24G9GU8x6qvYS+apckWQnJeDnVACDQFs7I14b9G6bLXNigUW5bYNcgq6UylQYZVgHC0Piq5qKHsSojM17+2aiLPQHmFA9RP9m/aBGSFhIVtOsZBPEAIEEFJfAZXYgEWEPWHcwKcd7nOj3BY6ASeO6V2DUEoPy1mmR7d0hh/fzwn+aBHy7Tsn3WRfkixGkua7vbNCNWsR0uoWWxyp8S0+6oBNoF4SjaZEtDqVFlM7wvynsZyyhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvlgFuIbnFLqSPKFmQcTC7rlENseqrla6W/y9pGz6D4=;
 b=VFwjq+IF3zJHrRL8qknaR07fL/EIZsoU9FH2yvpz9HlUXED5xdnkUBh5Tu/Lm1cmYnpCduFY+8fP4REClQ76WiUkWr94RlW++MuWw+Pw6x5avig8vUVifcAlz8VFHNdQWdaFqa85q3c5cxLf6PD+9At2/gZ6Er5ODGICFYYW7euhZuIF+1vlbU8XbJCTwM4Ho6l9A77aywMl7nOPvnlroEWeVMynbaWmhEnOFlPqp7N/1lwWwgFPa9iwCPYJxJ06zKgbsz4YWSU8+Io94YxsswQkXBUydHYEzd1i7wo3DeXijaUSFj1fUvgpR9Al2vr5PwboZpmzFEJVyNHlmW7ibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvlgFuIbnFLqSPKFmQcTC7rlENseqrla6W/y9pGz6D4=;
 b=gU6nkTsQF0Dvn+jAotw5IMomW4cJD9tN75oIJ9lcitpEcAGZuqXeb2rOr7mQJ88wircEP1sTjGv+JceiuFh9lcscRF6g9NWxUO5VYjINacUKKwGv49uT0grB169o2pj1hTzqwpgL4N9TdLg7colQ/Ng0WXk9G+6Czsw+gVFHe1A=
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 09:11:17 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::8c) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 09:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:11:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:11:14 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 08/15] iommu/amd: Enable PCI features based on attached domain capability
Date: Mon, 11 Mar 2024 09:08:36 +0000
Message-ID: <20240311090843.133455-9-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: b394c537-9494-4830-056c-08dc41ab35b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+PnbP+i2g1uFYp78aZ1+ohwBkNE2DBXihnE4Qb7ZV5SISu2IoJ69I9m4+k7r5uiej2gj+yNO+UeKtcHUMDvxf1IZKmUPWmb4dBjFLY/naFJeryuxyxpfkNyBfTHbVZZ+KXmtNdkmDW+DDdxBxUAHc0tiZ0FDAv9+9rf8st80Gljnedjpka7WkJUU3WyFu+kS6sihRjCdiYxqRzjwz6BGFWhs1fPZdL3zi7QjQD0ib7KPCH0hhTJ0xFJ+Jy4uA/enKnFQV+AT9/pRdf7MjK7UrWT1xgcSvmjHqS8WetB+IieMdR+334kK/R2E7PnEmZrNnypRf55Wa4FtTVJRAmNGD/v6wuDkAs6dcWGvdd/ac5Bs+5u3xuCUJJz4dl/rPx6Kl9ofDXuLNUBlYE8fBiyawXtVOUIINAa7x+if5jJ5c7gtz1++Z6E1gHbzjBeqcF2P1R1iM27sa+lJS0I2sGDq/+eKe0AxZBenkKV5wqBk4E3iAOnuUNy1OU0CI1wRkHVwbqYSk+68OXER4CdV4PbosdLQeZhrOEbxEQQzbY7YhzqQCP9xKADzUcc56ZAWq58fG3S5JAGT1yyyHVbfy8eW4DFI45fdHM8fjAtno0Rd55dP8Zr5DAFe9sqXhkksz2BnWEKPOyOEpPgUz3KqJrXBnMVpwYqTcjNpZcrSTn9bvPwmPSbFSr0KUtstFHpMGGx4hwv9QbbpicxvzaLpfyQr8JVw755Dos4clLCv3JQwy0FMtg/4KBpZ0ey2TD1AeDnV
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:11:17.5502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b394c537-9494-4830-056c-08dc41ab35b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

Commit eda8c2860ab6 ("iommu/amd: Enable device ATS/PASID/PRI capabilities
independently") changed the way it enables device capability while
attaching devices. I missed to account the attached domain capability.
Meaning if domain is not capable of handling PASID/PRI (ex: paging
domain with v1 page table) then enabling device feature is not required.

This patch enables PASID/PRI only if domain is capable of handling SVA.
Also move pci feature enablement to do_attach() function so that we make
SVA capability in one place. Finally make PRI enable/disable functions as
static functions.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 ----
 drivers/iommu/amd/iommu.c     | 22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b365c02a9694..d39141f81229 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -46,10 +46,6 @@ extern int amd_iommu_gpt_level;
 
 bool amd_iommu_pasid_supported(void);
 
-/* Device capabilities */
-int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
-void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
-
 /* GCR3 setup */
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cf727db66d61..60a14e184dcc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -399,7 +399,7 @@ static inline void pdev_disable_cap_ats(struct pci_dev *pdev)
 	}
 }
 
-int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev)
+static inline int pdev_enable_cap_pri(struct pci_dev *pdev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 	int ret = -EINVAL;
@@ -407,6 +407,9 @@ int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev)
 	if (dev_data->pri_enabled)
 		return 0;
 
+	if (!dev_data->ats_enabled)
+		return 0;
+
 	if (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) {
 		/*
 		 * First reset the PRI state of the device.
@@ -423,7 +426,7 @@ int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev)
 	return ret;
 }
 
-void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev)
+static inline void pdev_disable_cap_pri(struct pci_dev *pdev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 
@@ -465,15 +468,14 @@ static void pdev_enable_caps(struct pci_dev *pdev)
 {
 	pdev_enable_cap_ats(pdev);
 	pdev_enable_cap_pasid(pdev);
-	amd_iommu_pdev_enable_cap_pri(pdev);
-
+	pdev_enable_cap_pri(pdev);
 }
 
 static void pdev_disable_caps(struct pci_dev *pdev)
 {
 	pdev_disable_cap_ats(pdev);
 	pdev_disable_cap_pasid(pdev);
-	amd_iommu_pdev_disable_cap_pri(pdev);
+	pdev_disable_cap_pri(pdev);
 }
 
 /*
@@ -2032,6 +2034,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct pci_dev *pdev;
 	int ret = 0;
 
 	/* Update data structures */
@@ -2046,10 +2049,16 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
+	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
 	if (pdom_is_sva_capable(domain)) {
 		ret = init_gcr3_table(dev_data, domain);
 		if (ret)
 			return ret;
+
+		if (pdev)
+			pdev_enable_caps(pdev);
+	} else if (pdev) {
+		pdev_enable_cap_ats(pdev);
 	}
 
 	/* Update device table */
@@ -2104,9 +2113,6 @@ static int attach_device(struct device *dev,
 		goto out;
 	}
 
-	if (dev_is_pci(dev))
-		pdev_enable_caps(to_pci_dev(dev));
-
 	ret = do_attach(dev_data, domain);
 
 out:
-- 
2.31.1

