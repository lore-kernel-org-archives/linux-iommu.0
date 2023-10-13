Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31301B272
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sEi/J2za"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmpyvZhFqlxMn7mEGJ7D+U+kd73ShoFRZ4gaKBKEGzjsZi8SSaUn+Q/IQkbLQ6sos7zKzZ7T0oZHJGFQG52lOrwhHVyYsYZbeHA7oQ40uz6F13AGDQJjC0FA02VSnfFWqqCme5G4XVU79O80V4gaqyCLcHo06lvEBTEC5TPfzoBrkqSlr55utibcUPX7oFYOZ5EjfruS1NSh7/dmJinCvJxLBL0Pio8az/1480RsR8y4+rujMrJ6hhX9ZemZWHRf2S1TyaJNs4tjsJhGU5Z/aRzwS1Z4S3WXKkAnfHIO2iNiUYcdEchJoIip3c/N8lvs4TcVGBRlxnxsiBWN9EY2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gPzM8iDUgzHRJD7hP1XwNFO/wUY24FYwhlt9bM90d4=;
 b=drOc59S8OmeSIPSZ9YiiuzDSDz6TDuPtnb+P2WBsIKCtsCNsVygLwH1xKiya0ECUA6dwhRqfXPR1PmjWsGuhQkHx42ZLIefbrhMAkaQVBbC1TUp79RkRdHrpp2eZYmgDxeZx+f5WDFVf0H8LYE2jjvJT/t+FhJPuV1W71pzxYNrefqs4DmCM0qUMqfkf1Stdsrm8xOgA0Hp17avx9dkWvKqlB20Voq6aXImYWVIorpCI4gxJHBMnV5y9y7ME0+yyrPdjjsEkgf+2P8GFiu0n6fRQoE654x8WU+7Qba8rrb5dxbO14JbBqt6uRJuKFWnND03r0J2cr0pYHjH4ehxsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gPzM8iDUgzHRJD7hP1XwNFO/wUY24FYwhlt9bM90d4=;
 b=sEi/J2zagBW6uFHDMK/alxLLmGY0oC8c5FmaexCldYfKn+oEYkUzf9iYt5mrpXcLUe5kylFk9KWJS4F1qJ6NVQCMWd5+TR7sL7udsEom3Nh5HltPrWT2gLHDocsBVZVii4AyYD2ETJPFyAUJivZrCrbnvIybMPd2aVduwaFkubQ=
Received: from SA9PR10CA0019.namprd10.prod.outlook.com (2603:10b6:806:a7::24)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Fri, 13 Oct
 2023 15:20:54 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::60) by SA9PR10CA0019.outlook.office365.com
 (2603:10b6:806:a7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 15:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:20:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:20:49 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 10/13] iommu/amd: Refactor helper function for attaching / detaching device
Date: Fri, 13 Oct 2023 15:16:49 +0000
Message-ID: <20231013151652.6008-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151652.6008-1-vasant.hegde@amd.com>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a26811b-a63e-4109-225a-08dbcbfffe02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3zbggnOVmGmc31amPU+3vSGn81ZAe0+685nI++4vb2Mq19swkxerNT8hRz9UO9CbYZzSU/8p6B7CBASiiTT/1NyJLtoPxbltMHpuiZYD0DFcWqcmmqmljJwBQifTlVjIwV8F/RZBSP1iWrNr9vAx2vXj9QZN3IbElg4JOogrVHNOmpD0ej+TuAOFWPeEnMrPXG/mcKfa2CjAWTKJwUDkLthKm/46SoW1rqhPZowu9miLlbLOyy8UBr0dg9eQdZDeP3uxPRS+HU0N4jI0SwepdjX+npKzMhPkVIt5q9nuD7wQiRhiVogO2rxjLqDN6A6lHt1VTWJ2/AwTO+FSPTDb6ZFNuUoDwVz3CNmzYU2nBCRRb5UfZlqznqh8XnayJ6SuzP8h/OwS5Yb+mInfj80R5y2x/qFSLpxGshe+rewbhcW/uwJmsN2Nv8HPWPbR87kjAxf2e/LTIJlO1Cq9+7A5XenBqPI0gt5cQPjHyEQNrjkT5cSaX5ZIiBUamSwfhajOMPJ+u7h3HLxmLUgsQjZ4LTFdpbxaNZmGMdgZjGFY9mHysGz4bWqNKaDFlX0Fxd9zoKT5FeLh20wIZO9Jm7eWYEu+q1IT3ZlaoOVsRh6WI1ayf1lZXS4ZmzBaNLY4U0NwpjBomO5ohU3+7mt9S6lj7E5stbOt8WdEVHWAnk1ULcWLbWhXWOXJ0GkBxtZyGvduXmGMDf2KmXL808srMvKXWpP/4IQbbcCmTvEoL0yioEQ/jeI0YcG9RWh+W7j8W/nUT4nNxnpklV9A6jqp+2QIrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(7696005)(478600001)(83380400001)(36860700001)(47076005)(36756003)(86362001)(356005)(82740400003)(81166007)(2906002)(426003)(26005)(336012)(16526019)(2616005)(1076003)(54906003)(316002)(41300700001)(70586007)(5660300002)(4326008)(110136005)(8676002)(8936002)(70206006)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:20:54.0302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a26811b-a63e-4109-225a-08dbcbfffe02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the new helper function for setting up GCR3 table.

If system is booted with V2 page table then setup default GCR3 with
domain GCR3 pointer. So that all devices in the domain uses same page
table for translation. Also return page table setup status from
do_attach() function.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 53 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1ef6cbf71926..cb24bfaa9dd0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2055,14 +2055,37 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
-static void do_attach(struct iommu_dev_data *dev_data,
-		      struct protection_domain *domain)
+static int _init_gcr3_tbl(struct iommu_dev_data *dev_data)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+
+	/* By default, GCR3 is set to support non-PASID devices. */
+	gcr3_info->giov = true;
+
+	/*
+	 * By default, setup GCR3 table to support MAX PASIDs
+	 * support by the IOMMU HW.
+	 */
+	return setup_gcr3_table(dev_data->domain, -1);
+}
+
+static inline void _destroy_gcr3_tbl(struct iommu_dev_data *dev_data)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+
+	gcr3_info->giov = false;
+	free_gcr3_table(dev_data->domain);
+}
+
+static int do_attach(struct iommu_dev_data *dev_data,
+		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
+	int ret = 0;
 
 	iommu = get_amd_iommu_from_dev(dev_data->dev);
 	if (!iommu)
-		return;
+		return -EINVAL;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -2080,11 +2103,27 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	if (domain_id_is_per_dev(domain))
 		dev_data->domid = domain_id_alloc();
 
+	/* Init GCR3 table */
+	if (domain->pd_mode == PD_MODE_V2) {
+		ret = _init_gcr3_tbl(dev_data);
+		if (ret)
+			return ret;
+
+		ret = __set_gcr3(dev_data, 0,
+				 iommu_virt_to_phys(domain->iop.pgd));
+		if (ret) {
+			_destroy_gcr3_tbl(dev_data);
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
@@ -2096,6 +2135,12 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	if (!iommu)
 		return;
 
+	/* Clear GCR3 table */
+	if (domain->pd_mode == PD_MODE_V2) {
+		__clear_gcr3(dev_data, 0);
+		_destroy_gcr3_tbl(dev_data);
+	}
+
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
@@ -2142,7 +2187,7 @@ static int attach_device(struct device *dev,
 	if (dev_is_pci(dev))
 		pdev_enable_caps(to_pci_dev(dev));
 
-	do_attach(dev_data, domain);
+	ret = do_attach(dev_data, domain);
 
 out:
 	spin_unlock(&dev_data->lock);
-- 
2.31.1

