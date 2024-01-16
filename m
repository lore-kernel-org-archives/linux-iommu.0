Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C01C6A1
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BwYUXWxB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9c1tYiH8/5FSM3/lksC7XQikq5pt8dvdnLeMLusRRo4x2Xt+W3X+nCYKp5fVWITM1NBaZdLdnyGeO+6nMYYvR0s0LC6USjrnLL3lN5sPXBOmUV5lc8j59Kx6w1AuAk8vcpLuFl9ZczW9saUd8x6MP1bapN8akw9HWVrzBw/yENV0WIN/sf95YBgI+M2PN2btyse+M1mv7RyvLwLFlN3jWZ9eI4hF9LQVvf6JRVO/q2ES2658TAd9PrZjHKtdyHqKpzIElUg+Pi6OaDi9eMdhIZVSzAI7p7P98Dzp2oGNEeqULpmytyk5PHA0HDX8lvgfuKm4XkNzavZjUEYNY5uTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQkKSpBwPh1YOEtQYGGeD870SGxLmOJdS8s1g0LLVPY=;
 b=Nw1Hr+shkTbRhtlgMG+BHQhlRIInCUb4My916lYaNYCGPGLD9AMM90MiiWZ/aimD9IGg2pOIkofcuI+rLxTVTIijbqGV7V9fXXeDK8Be2MbeHgard9mL79hH72QBoYDFOAeQbMJL4SrDS73bvde11YRjvDPktRE7/jI32kL876HeN8psxxIy2IOPATHD3q7ZgWIhGTcCdhrrQKXjTb/XQetFrNBsAcD3lAk1EB25/hppPBaIP5wHf1QQ2/zCPbWgb1GIhZPacpeeSdsxvGoIRM/V07JbB4yITNb3hmaSU+B2v3SFYW+2ruxREZWmAzo/s1emuDK8ZwDmUXidkCGvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQkKSpBwPh1YOEtQYGGeD870SGxLmOJdS8s1g0LLVPY=;
 b=BwYUXWxBqYqSyKmiQ8y7pWcDSuz/quInODDl1PpOqHQv+4emSz44h0PSn/shtjBieyYshR+3194skK4PzRM1km3w1aZBl0hKm0jmRE0Kuasdn+rADSTd/KeptigqoO5+bMmh46QcZkGAe6mX4RRst6/URgCg46PtVZsxKBP0kxk=
Received: from BL1PR13CA0397.namprd13.prod.outlook.com (2603:10b6:208:2c2::12)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 16:57:10 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::bb) by BL1PR13CA0397.outlook.office365.com
 (2603:10b6:208:2c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22 via Frontend
 Transport; Tue, 16 Jan 2024 16:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:57:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:57:04 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 12/17] iommu/amd: Refactor attaching / detaching device functions
Date: Tue, 16 Jan 2024 16:53:30 +0000
Message-ID: <20240116165335.6043-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 64306b10-f4c9-44f8-562b-08dc16b42dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kn1One2GslyLHqJRBprZtultyzB/vyb1ymtoRFLPIxW3InqiSJstzGI3Q2TLNWtmTMHWCgIs0PNkTPvGM4/T4AgrfIu3f98WVoOWSTlweT7IIHyjM+tUaitnC/NozLMcI1VIh+xABoCuT1g0g8uCl3sgdIP6qq15AZgQyVci3fOQe6rZt9KVBrQt5UmHiXgSaoDcTt8Z1OxMLOK3YM9DmizxhCZre5anWP1605FnagEKWKBQwtZkoFbsUMQ0Tp8P8zbaOb0pK+RAagoN7q2hqPM7cIDcEo32YtgMntP0rzPS0Y2cRC3ZY0szLkYBcXQ3Xzg+K7FGtL1sawR7AbsLhcJk9hfnpwyVW+GIZzliiXxP5zFeHiJvNc157o2eMGlFH1yEa1AM5hyKK/JX4yi5Y8DoJ/NCJ0t36rMuZg67Gc7RZ0j6+s80XTad3m+exUowtLcGTT0UjbtsbNFe1+BaDMtqtOjqsqGkmzdzUO3wY+Wrmqd4ILZYboIGTo/X0Am0vnFvAz8OAxDaCUIWBZLloBWtOgAj15xGpsAk94xGGhXGi9ryeabM1bhLPunSmcmgzQlYDC4pF/GqCRjC2PP37aGlwjS7V5ZJJLAikdEGAcg8UsepHYHHo8h7YJGi/ectDEdezQ+jXX3/ak+TFxLlXPeluAFlqtNXQZB8f3b+q41+th86sxdGYV7VEdWPKDdO3u8xm/jWX6SZH+ZxDYAsZFqF7XLg6Y5rVJS4ov/vrVJzwh3WgyGuFUiImaFSkFlw0g0C9q8tVpvLC0YUtoQRTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(16526019)(2616005)(1076003)(26005)(336012)(426003)(6666004)(7696005)(36860700001)(47076005)(5660300002)(83380400001)(44832011)(4326008)(2906002)(41300700001)(478600001)(316002)(110136005)(54906003)(70586007)(70206006)(8676002)(8936002)(36756003)(86362001)(81166007)(356005)(82740400003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:57:09.6540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64306b10-f4c9-44f8-562b-08dc16b42dbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

If default domain is configured with V2 page table then setup default GCR3
with domain GCR3 pointer. So that all devices in the domain uses same page
table for translation. Also return page table setup status from do_attach()
function.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c9cf5fd03d0d..b5347acee5f3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1949,10 +1949,11 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
-static void do_attach(struct iommu_dev_data *dev_data,
-		      struct protection_domain *domain)
+static int do_attach(struct iommu_dev_data *dev_data,
+		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int ret = 0;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1970,11 +1971,28 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	if (domain_id_is_per_dev(domain))
 		dev_data->gcr3_info.domid = domain_id_alloc();
 
+	/* Init GCR3 table and update device table */
+	if (domain->pd_mode == PD_MODE_V2) {
+		/* By default, setup GCR3 table to support single PASID */
+		ret = setup_gcr3_table(dev_data->domain, 1);
+		if (ret)
+			return ret;
+
+		ret = update_gcr3(dev_data, 0,
+				  iommu_virt_to_phys(domain->iop.pgd), true);
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
@@ -1982,6 +2000,12 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
+	/* Clear GCR3 table */
+	if (domain->pd_mode == PD_MODE_V2) {
+		update_gcr3(dev_data, 0, 0, false);
+		free_gcr3_table(dev_data->domain);
+	}
+
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
@@ -2028,7 +2052,7 @@ static int attach_device(struct device *dev,
 	if (dev_is_pci(dev))
 		pdev_enable_caps(to_pci_dev(dev));
 
-	do_attach(dev_data, domain);
+	ret = do_attach(dev_data, domain);
 
 out:
 	spin_unlock(&dev_data->lock);
-- 
2.31.1

