Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1A2D879A
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299043; cv=fail; b=a8AEl+bR4gpWH1MOwk4JIK3mVpqz+pZGcMh+vpWrJ91iGNOcVND6k9+yCG/QO0diql5A5LhgXfXS7kbtRMaccP7sKUcIYXBdf1Nhah7Uoc+bk2EwQA5By4uN0Xil1BEiHbAXmaEuq4jZ03AW9zeRP5YuKseOeNy9a/puKnBXYB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299043; c=relaxed/simple;
	bh=qfYGHHyMOuV8JCYG7QmDuf+IookVTrUHs2SZfb2GN8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rULXd9oyrhioVRYfETgOoWBws+N6kaV5LJhT9edJD8CZxfFufrOJWTa21EG6CsuCYT4stBVAwMrKMxntCiilFhI/FaUsWThZPgzToFwzXrwmjSf9bjXKax9BF/3xmg107D9wDZhEhOtRH5QCK7uFbyUxtkwhGzwmY4PbdUTu4CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2N/9SGdC; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2N/9SGdC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr6DldMrdZUgGQ5ymZDhOFqDoSSveBSBBFQektikbzvT+186/A+wGk2VJyrQJqHDiqca1+ot3DRrg9JD/w6FJhDoSeo3Y52AqO5deqTJ8ScO0+LfELagXuXDiKSxFFGVBjFuLrSzf5NsYawP7lUaCrpIV+7pw98sOqTGxkvpxY3XGRtFgy+zoeRYrs7fILa1NoLHrcET3Xor3FKWKyEsTmIUWSd8pMFu0V3bWOpx8r82oqpIaGIJmeGD8NsFEK+5smb6tEQo49InLswBcQ7ek8gw9ChHpKJu/+eu8TY0gLEn0X3yUytmnS3m3BcAV99y8dnSShWk+5Zvq6efhK7Kxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omHRr1MQNQ3xmm2J+pP0B080d3DZPDdfooGic4sm7Sg=;
 b=ffPQjbkHSBMpc5Kh3aMYkDeWj2U17UT/SMSyL+CIJy2RywUFV3BN+D2HEED4wfItau9iESYkCGUHcW0hu0EA1AdO1bUVErjKaZvp0NXMEFwjh/f2GGrDLVG+6CSPitWB7Xi4WVxEo09rsDrWhKj7FfT/qKXNlncy89D1OIMogjdWslduMHkKTeQ46o9mpEQQpLUYfWKTx9SDTi++B5VHi8vvrMmfjMuwG1JQ4s/lX0ZFBE/xB8rjaII7VyE+gQ5ElgGnRPRc3ug+thENQ6RozEPN5b+JiQPUcyJTnlO/lMvVxZbEVVqAQc5y2ktx2qCuYJpGPdyS02KqN+SIOeEa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omHRr1MQNQ3xmm2J+pP0B080d3DZPDdfooGic4sm7Sg=;
 b=2N/9SGdCJGgVvt80GgQzZIzhYLefcAPvResva0dRyFYnuqedB75HsS+lUZ6Qn2GNQRVFUy/rsFuUKUCRN/c/531DsbLT2rMqqwtYh/E9tPjb81mCiVJQ5e9En/lWP/Pt5tDVXZg/NyUR+ikk+d9quYzLFn4rgOAQjMjfyeFAxLQ=
Received: from SA1P222CA0041.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::15)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 06:10:37 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::49) by SA1P222CA0041.outlook.office365.com
 (2603:10b6:806:2d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 1 Oct 2025 06:10:36 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:10:30 -0700
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
Subject: [PATCH v2 04/12] iommu/amd: Make amd_iommu_device_flush_dte() non-static
Date: Wed, 1 Oct 2025 06:09:46 +0000
Message-ID: <20251001060954.5030-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: edf88680-0a65-4c62-c4b5-08de00b13d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t6BoJSzHUyTokfZI+70A6Y7b+CtkeYPgLyk02GsjbnfrNquQ0Q0MqZkDoEPM?=
 =?us-ascii?Q?QA3+ZtvIxKcwIsSbOBGiDGcTbALddRstuF+1tTYan8ecc3PYktNE2kyRjw/1?=
 =?us-ascii?Q?UmEty9zdrE13Ikvg0oQHFjgbWw4uupJ5z8zFs+al1dTtOOI02Xm9LtRr9PBM?=
 =?us-ascii?Q?va6jPP4ytI2m0uTnTwyjXIB6OKwMCH00E9YewU3pdDc3gZ+SH4QB0mJ3Lsue?=
 =?us-ascii?Q?l8Nxv3A8AVCD1LUtImWFJcpVuD4wCUtxrbinYWrji/HoevvlHm8p3wuslMpZ?=
 =?us-ascii?Q?o7mE10AZa4KZzgEOfcVwtPzsL68lplwPsg/jo+lnKMs5k+E4ygo02xb2vK+8?=
 =?us-ascii?Q?xWh1YDRWkALSzRRWpTqKRG/myAJveUXf5dtjGKF1uGC+PSZh08o9DbJoPtOD?=
 =?us-ascii?Q?LvJjFMEBpuxvfq2s/qbe8NN3Pn7wfI7bhTIOB4t57qJqL/Di+BON5i6jU5KU?=
 =?us-ascii?Q?W5Kle1EUNe7s3EAnjt/DiZ4XwhwPt/YDYsSsfYSMro28rcpZizK6STifLBvi?=
 =?us-ascii?Q?HSmzSqwZjsC9LeQQGFxcCCtSMqLz+2yqsQOruU7h30/hpQ/MEiF81LpiBx3Z?=
 =?us-ascii?Q?J/BmWoF/01EKQQJ1qVCNbMD623DpfpHC0pcqaBX3MX+6x+y2q2sXyOLQN8Yb?=
 =?us-ascii?Q?iJwp6GC2ezRX/WAQ675O4NxiJbsm6XEg2yxbeZtNiUnixwkaQ5XeZQxa28lD?=
 =?us-ascii?Q?lOyeIij8W/AQjq6rK5doIshiPPK7f95am3TlfDmPTAcycHCcdtFPZs9sP//N?=
 =?us-ascii?Q?UbYopZ28hC+53cfCfB4hh1xHdkCvqnK5ygCWwe0XetfNAVuqCZagN0xCAMG0?=
 =?us-ascii?Q?rSZTS/p1Ak/yuuaqi+/8Gb/lQJTv2AQcaa+dsJkVObsMmZCHq8+Fk6olUShe?=
 =?us-ascii?Q?BOR3TksOFqSGOm/BCEAGyyI8/Le9MEOy83GXTqts4uKCRIjb1ST2XWBZPJWV?=
 =?us-ascii?Q?/4x/hiauLM/y5pVrt2zNf4hLQCqDh5qaU3z4Tq1lRjfBKJkKZeQvjkuOlQ8v?=
 =?us-ascii?Q?YQJerXcAJmRLbEEonMp/lHdjBZBDzxyfiw81lZCcprOXNXoFSKn2MQnAOyAB?=
 =?us-ascii?Q?503tDzsTctXSY0/jkAkt093wubYyDgZtfQGiYuOJuaIqWTlv7GUyDfy6MdhA?=
 =?us-ascii?Q?faCyBu+RYumEewJl+oZW8UbC3FV5aFdEH2AeGkgumw5EuxSOKk0R4gn/GTGV?=
 =?us-ascii?Q?5/Pj0ZhfwXj4wJEPYoMDYN6NvKdxX3NCEeO6paWAm4XDkqJ0yKp0QM77fvOY?=
 =?us-ascii?Q?t2t08d1y7JYbTAc+mK62TWJYPAIOqg4WluJw/JRsYTttWZlx/hugnaTIINY2?=
 =?us-ascii?Q?EHp6qbzdq5/Z7mg4gP+ieC2dbxdUOKRzfswmk/B/d0kIwfTcQjTsZmBhdgcc?=
 =?us-ascii?Q?ah+U7UYlwhSQzpOd04+ySNm1J2Wd0HnOnnHOIA4ilWUlwwrTV1owvCsEkcW9?=
 =?us-ascii?Q?HRKxj3YEQ0OEBoVA6FQNXU5z7topu2zzbTB7xb+zEfcI2iUN0+hA9lJKPD4t?=
 =?us-ascii?Q?+F5lcHB5JfRDhiG0PrD+r5ySHIuugGCLkzrMn5X12Tqro82aEnxZ7cK8ZNDS?=
 =?us-ascii?Q?W8xnMniEY1rviVVPqSI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:10:36.5927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf88680-0a65-4c62-c4b5-08de00b13d0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077

To allow reuse in other files in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 3 +++
 drivers/iommu/amd/iommu.c     | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 322c8c73444a..079fb1d44c00 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -188,4 +188,7 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 
+/* DTE */
+int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
+
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0b61059e485d..fad74d2bc1b1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1562,7 +1562,7 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
 /*
  * Command send function for invalidating a device table entry
  */
-static int device_flush_dte(struct iommu_dev_data *dev_data)
+int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data)
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct pci_dev *pdev = NULL;
@@ -1788,7 +1788,7 @@ void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 	}
 
 	list_for_each_entry(dev_data, &domain->dev_list, list)
-		device_flush_dte(dev_data);
+		amd_iommu_device_flush_dte(dev_data);
 
 	domain_flush_complete(domain);
 }
@@ -2144,7 +2144,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
-	device_flush_dte(dev_data);
+	amd_iommu_device_flush_dte(dev_data);
 	iommu_completion_wait(iommu);
 }
 
@@ -2874,7 +2874,7 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		device_flush_dte(dev_data);
+		amd_iommu_device_flush_dte(dev_data);
 		domain_flush = true;
 	}
 
-- 
2.34.1

