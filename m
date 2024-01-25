Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904253EA62
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185025; cv=fail; b=bys7tZ5NpgFu08eUyrzVBWeOibI6t/sqb1KJ2VK0aDNcNNXpYMg1c7gs8n8s79OcjNkUwBiW6NsxMLVCA7hOsHh8mq4rBuaW5QF4sYYYNjLJD9Eib4fG3i3lhoc+CP/EtDq5Rk2SP9xszDwLZcEXYV31saY5HRBVwsObhv6nJEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185025; c=relaxed/simple;
	bh=ss4MEO9cDfotgPW0/HLcBNq17CL377JmaZcZ0wq+yKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnnRBZo2PyFBh1M1c8xt+U0dVdy3raXfkOzmF/Efhq2E5X9gO0W8fSoumHY2Plc7St/jSI2qIfTK6G/GifstaFXAgV0RlTKF8J5R2gjAYvP3ya/QUvWkbzXj04ON5bopvzOkhByibr679NEaYmJIz3cy90Ja+PoBbp2yTQmaGDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G6Iv7xhR; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G6Iv7xhR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acCumgwHxpfFkBJjHC2Euhw2L5jOIA33PuvAROW3k0oMG/h0kaGQNlvj9uk/E/i38/b9Ljdud8jgOE4NRy2a87MoPD4BttyfOh7dcGpxDNoMIZA0WTpLqfqc2inF+ETzSnNzX8E8HamnYY25PhZad+OtZA5wPsfGoPrmuQsPR00EuWUa59FtxKu484VmAP68yT+oxi8lPh2RMnXxnK7uplttKJabynp88MDwAMrVpdNGXa8gfkQn8HU5Uki6OCQApsx7qxgJusttAC7w9gMnWV5yfrWsSN3/WFqk0fSQs8+CB2HV4u+D7BBe1ogByZcxgfSXIFnJXX+r3tjGPRktgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fkD1dbj+6KljqfIG/b7Cqsru3J5KxkvW/MPDugceu4=;
 b=nYz6EDUQgEg5x1tuFvGRYq3daiYSoMRti8AQph+2Pv5vi+QpC0Qf5kdbV8s9pXQ2BM1qHogKo5akYarzI41QPfvDvIzPsneqVbbVfHB9tKg6Rm8ooSnuFoIy2oB3Bd5fG1dKIJImUZ+8RMDsIO4ChzAnNkAOeyTjkVlUhMF+ylhwC97Rkp6FNU+9bPCZW2eM3KFZjChIZn9Vg9wx3OMsSFZThFf9B244mGoPUVnI4aimn7l+vS7fPW4ZYbWLEis0vrE1v1JL4U7wThBUphobOqZjDUFR8ULqZp++zjwv9zI1+ZU82hODRF76h04gQPJ1/j/37QcOL5dwCdcurt8rgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fkD1dbj+6KljqfIG/b7Cqsru3J5KxkvW/MPDugceu4=;
 b=G6Iv7xhRwmWExIUaRW0zUkTAh5AnL1zQGJvUU/+Q8cFqqDdiIBnpKu8eQoe8provJ/f/bVa3JZ9IU73wqNet4hqsrQfuHJvdJH5DmHo9SX46nKLvQEKHfHpTLpgxEM1W+Mhtv3Rwrx8XevhEzSnFPC6MTMlEkvI+fzsz4isSUXI=
Received: from BY5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:180::41)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 12:17:01 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::5) by BY5PR13CA0028.outlook.office365.com
 (2603:10b6:a03:180::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Thu, 25 Jan 2024 12:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 12:17:00 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:16:57 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 11/17] iommu/amd: Refactor attaching / detaching device functions
Date: Thu, 25 Jan 2024 12:11:29 +0000
Message-ID: <20240125121135.8217-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DM4PR12MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8f0cd0-f94d-4a8e-1e5c-08dc1d9f8871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dtZO6B+5p09j9e2cRRtKoeMdIWA06c3uiuQZ1OG9lYtj60D4x8AaVv7mmd8y1/YwPnzubMoGyhr+8CzPR3uNUF0uALNJg2mUUqvhmU9YXM9DC4Y4kA7bXtBb1hp3VZHMvZBZWTzXXgIUnrzkh0BZQG4gVrG6A7ZGrP56U7nbv1ZpXIlXoVKEvktYS0XQ3NwZnMNFVGY+Gfl9bJ/HFhffwoNZbp5LYZ95Kfw9ssTRQ/HxYeOzTYv1qOCmzLwx1AjoajAbrWR1/lbupBt+wDqKRMPeJXaoI9YQirXFprPHIq1oN3YgL/uxkfdUhV05BUAR6E2rb8MkIh/N0iuh8rpL2dru8aDfzVoUTeTCDkErMEd7Wk5EEdFG8ObuzFX7LM/4SSbvJB0W02chiJkELkee8ig8eMlmB81ti3OWwJ1Y6RwTVyi2g9ieFg1kdRUIn/3/WQL+e5Qy5U3ck/szlDhBlvgdoQmJnNMmNQDMP3xTaparO7mWuUVUC6ChkleyMlJy7QicrQNKZz0wFh/ph1RToIhwpfeWG18tG8gB10CBjWHUT2FRFP7Bop/IMwEzGE9Rzk1I9T2xCo/mC5NWO7YjZwuicAHu8S7DRnlCBz5XF79uRk8iLl6LW5+htRuKe05kLXQ8XcVkus7WQanqKnMdHYflnSWJEzYZxrQLhyyVVg6vpMqhx3XNSMnUqse0V4IY9Txek1lwGFkIF+rm+5pRFxp2iENASqCFHtgo7Q4dQ7/RZD2nOXtVKKYnhIp16fo+tSuWUo6UQvsI7a0hps3N6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(26005)(70206006)(1076003)(70586007)(426003)(110136005)(5660300002)(316002)(36860700001)(4326008)(6666004)(2616005)(8676002)(16526019)(336012)(8936002)(54906003)(83380400001)(44832011)(2906002)(47076005)(81166007)(356005)(478600001)(7696005)(36756003)(41300700001)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:17:00.4325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8f0cd0-f94d-4a8e-1e5c-08dc1d9f8871
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246

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
index c1bd152df9e7..6d35f40c7daa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1903,10 +1903,11 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
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
@@ -1920,11 +1921,28 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
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
@@ -1932,6 +1950,12 @@ static void do_detach(struct iommu_dev_data *dev_data)
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
@@ -1974,7 +1998,7 @@ static int attach_device(struct device *dev,
 	if (dev_is_pci(dev))
 		pdev_enable_caps(to_pci_dev(dev));
 
-	do_attach(dev_data, domain);
+	ret = do_attach(dev_data, domain);
 
 out:
 	spin_unlock(&dev_data->lock);
-- 
2.31.1

