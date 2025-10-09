Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7929992E
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054331; cv=fail; b=Iah3zxxpNrCs6jq6k9VtzuV9JkQ2KqWaodPSGiB+/ql1dgGMpfaqmXPkOzugYVo1PmQWR6gzIJdv4NI7vS8srV6fbI735SM+WPfMGlxgaYGD4rM55/pGGj5qZ2qcTvowLL2tEd+O+QGtbiUoot01CWrqwEXNqNUmxgx9qDOjCJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054331; c=relaxed/simple;
	bh=gn6xpLP1QjIQG6ns6GPR0XtG7tjfWq8j9jgl5AS97I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFZ5euEJbfjaNgQ5CKF08f7dmi7/6OSaOt3HuGnCZiJmRzyAChabcm4gm8j5QQk2zCDpL4UOEWQ7l6cJdyjRXS5FR+/C2Y7WqLYPz50Xjs4c8CVn7z+EdTefFWx3U3v5toQ9eGatURVEWHbQ7oWB3FpCRyBoLyVnUvcdWY5nrWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ovJCpBuz; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ovJCpBuz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUzLw0Jk6dQv7d5R+nrfuKFqYwWsewKKrjJGezP3hmfnopmV+oDd6wiqQh2RR05sQLAF5x/PrN6Q2j8tkHAWXdo6zqyRCo56iTvvBWfga+JpmZxVaQk2toqXYu5JDofWTrWsbb+fV9ujp4m2u4D97Zz7FFWNgdVjD7WpzQhZJzfTgAyt4YFVgdj4sgqH3ETlOQA+nLK+opncCvKlcQS8s1/9vMl0bQv0I1lPEUr9Qpnqqc6yPe2hrEEvnMTW1LcLrDNP/c4syg4lG8qpJorxfcgWaoUontrG/MEN7FQNAzh4jiKk1rU+1i3CdCv6IXST2RTsQMS9ShoihDeaWPsl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DZhN/4ljDXwl7CFS2tNrXY+OE2PYoXg9r/V4Je9hjI=;
 b=LdxQy8b//x77AJhRbyoPaCxenzUXmOcYzZsRYN75XRMfNTNaP3l5gGmBqUa0JtpP7jDb10wDbhXgQz5+NMCSwf2bJgfDo1gwqy00C2q7BZIlvY/s66hNTeI9WC0OYx9D7uBI5fmqYYFA4Wc9HVf8JHqvKBEnlLY9L7DyOviDYjDfjdO1HLEN6AFjx3+3c96XbTM9FPJRBKuDZvIViX/kIiW0ATaiO1lmOcmlXvK2ctC414p3oELzhAo1UnNMPoszF2OdJGIR9Q7qU/ugBkifxh78ZkSNijRkyb4MWA8DLV3TShgWOMewDg99AjcY+oawzvwaETGN3MvT+znPS1xyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DZhN/4ljDXwl7CFS2tNrXY+OE2PYoXg9r/V4Je9hjI=;
 b=ovJCpBuz9crJ6ccocxhjFm91TRh1hPyaTEGRd/25cPJP8fUEGyxfVwBbTN3HvKc9Juk/K26dFI9XWOS8TGro1M2x4LKiHDHIenoSiwyMRD5aZvcj4HniaV+ObGjRZpLC72KBS3NqpGdyUSN+tCuj3UVfkk8aNdpowSVJG+6ijgw=
Received: from CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::18)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 23:58:42 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::fb) by CH5P220CA0020.outlook.office365.com
 (2603:10b6:610:1ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:58:41 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:58:36 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 05/15] iommu/amd: Make amd_iommu_update_dte256() non-static
Date: Thu, 9 Oct 2025 23:57:45 +0000
Message-ID: <20251009235755.4497-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 948ac02d-c715-4ae6-98b0-08de078fc620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jmk7BAvSENcqRJ9JgUIDELZCQndJ14lfbZqIUr2xtMdJgaVUn8R07paqwuzc?=
 =?us-ascii?Q?AyCujNogxD5ryQF3wpgbtg7PEn48iCafXw8OIOl8rd3qNdER+nkh3jRXHSuV?=
 =?us-ascii?Q?0Tlx2Xjy0qxWSYEQh8aclsFVyzHPl1syoZhFd82H9uZg1YuDiEI8Csfsfid6?=
 =?us-ascii?Q?qVc42mwiaVGCfCU5BMKxaaWJZBVOMKAOESbg7trXiplWn/VQZgYznhN690LY?=
 =?us-ascii?Q?4Tw5FkA28se/mSKwJOxdBjwhwzbJBPx5NTubNJ9h4yIo0h4XVT0X3F6xx3Ya?=
 =?us-ascii?Q?zjXT83TRMl2Q3hLHt02ts9a0VxXf69+r5r8kmZt1EMtJgYgQ1sNjQ+jkqbyi?=
 =?us-ascii?Q?aiYHvbJmLL65BHnAn5SvSldYbXBg+ki0Jcm/xzwzeBWMb+IFg+eXCS/kYH2t?=
 =?us-ascii?Q?8bIidjLvMH8u7LnNGshKItb3xBLz5llgtnenJuRYM6gfT39Nr2WgxyllloaY?=
 =?us-ascii?Q?X/kwSjLKbJRw82nC+NC9CGCDRkscYH+Q/qQSV5PM2ob1sfLdoFEk2R3zVwzk?=
 =?us-ascii?Q?lkuGlOzUqgnqH3+1+809oaa49ycq6FDdrAAWwxOFYIlmk5ODRHQhNFsvs43M?=
 =?us-ascii?Q?jpuvOdkTkcjqaEGYGw/3vzI8hC9JLjMptMAmVqfeJSvHj1t6pgMyI+FGaSB0?=
 =?us-ascii?Q?IxrD6U6V33NPh6V2BUgJ56JcKCYziQYIMjnqyzmQj+r/sFD1g6NG/aJqjKWu?=
 =?us-ascii?Q?sWGZEtgCNlf+uVYnv2NpKb7lnEfNaUVggLpMnVXwX27oxOxQu3t67e55/ESS?=
 =?us-ascii?Q?sA8wIu1IYtAXZQ9z72QV70dLlQ8udonNNVqR+XFa0EUZT6g8P0+aFoS8mbcv?=
 =?us-ascii?Q?9xusiyF9wJi/mDONdQinC2GYixcm4Q8UDA3eL0DdMOyrHegVDKOJgp8/c9Ye?=
 =?us-ascii?Q?hdEPjGS05VQIjS00FXAzDHi2/wB5mXFKUYR7xyyKtONSm5Hm8w8Ynjeb1elP?=
 =?us-ascii?Q?JmTU7kHVtg3v4wsF5uG1kW+SxvPQ/YYogtlVDlwmb5mF34C8FdnpiohOw+xv?=
 =?us-ascii?Q?Ri6l1zLjto3kPAB9G0DvaapLW0+pnO6II00KaG1piQdGf0eLzz/h7N4/HOEx?=
 =?us-ascii?Q?o5i+0Ifxf4IXuxEte7ifUbfq7Ot+C7e/XYJPG7034LJ3HiYkVk5xcOrlMWP2?=
 =?us-ascii?Q?tf7PjG4+41DzLKW6Y+wq2rCbgRc/au2zXXGH2wXzhUf9M80yOtzVqG18i1i9?=
 =?us-ascii?Q?AXOGmLJeIrDGtHWURzuiXECk29iY3Onm2tP8evjJ36r30oj6quq4VgLJ9WNq?=
 =?us-ascii?Q?CJFaK4N0uTxx+4c65l4NReEYr4+SmTl3s7wbVHW3WdXLVKLa/p+tW30S9JCZ?=
 =?us-ascii?Q?j6QMGHod+3ki16QnwOIMyvZ34G39o24TQICai6bc82obWD4sKrd2UUMbOBDD?=
 =?us-ascii?Q?xuhwnjLSu+qefS/FRQNmExtyvn8aUNMcUd7LRIimGwC8ZzpmSG8ezgirp0o2?=
 =?us-ascii?Q?cyI4NDnjUhcSUXwVZJype4HbyXLDZS8wdZ3pGvvC+UNc79TD2/lUfZi5Taff?=
 =?us-ascii?Q?DT7Fu+4UJM5w4Xpx0FAGNx5Ui2/+0s5GYxUQvHpxfxZRghDATmuXOnUZIhoZ?=
 =?us-ascii?Q?nVeggEloNkI6fhiZ/5o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:58:41.8142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948ac02d-c715-4ae6-98b0-08de078fc620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151

This will be reused in a new iommufd.c file for nested translation.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 079fb1d44c00..eb46e8914eaf 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -190,5 +190,8 @@ struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 
 /* DTE */
 int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
+void amd_iommu_update_dte256(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data,
+			     struct dev_table_entry *new);
 
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fad74d2bc1b1..3f2c61509b60 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -132,8 +132,9 @@ static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_ent
  * This function is used only by code, which updates DMA translation part of the DTE.
  * So, only consider control bits related to DMA when updating the entry.
  */
-static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
-			  struct dev_table_entry *new)
+void amd_iommu_update_dte256(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data,
+			     struct dev_table_entry *new)
 {
 	unsigned long flags;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
@@ -413,7 +414,7 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 		ret = -EINVAL;
 		goto out;
 	}
-	update_dte256(iommu, alias_data, &new);
+	amd_iommu_update_dte256(iommu, alias_data, &new);
 
 	amd_iommu_set_rlookup_table(iommu, alias);
 out:
@@ -2109,7 +2110,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	update_dte256(iommu, dev_data, &new);
+	amd_iommu_update_dte256(iommu, dev_data, &new);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
@@ -2130,7 +2131,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
 	make_clear_dte(dev_data, dte, &new);
-	update_dte256(iommu, dev_data, &new);
+	amd_iommu_update_dte256(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
-- 
2.34.1

