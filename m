Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6780298CA4
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054331; cv=fail; b=mM+LwV/9T78Y8WUbtxm8vl1NYlAN5HPtZCBN7uessxQM0lSWALCVH9n4ap9zyXhWeEw8Rr4OzpjSbr7FFd55xN1SbfSzVWIGGaH4qhC1/LUCgcpl4mP9Ra46t8XI+ptVJLNnUw5PlqFya5Dh1DduaL0yTNLIddZQxerS70fg6ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054331; c=relaxed/simple;
	bh=wxkHwguqR7b27G2jKrNKFTz9BrsCmBKm9mmCGSMuWIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVYSTp/ZSYLrpbAfVeOYiX6+Hp7woeZrf7BdmloKMYHY+FOjAzQE+RH9bBoxySkUYvdMEy5fb6Z+0HzA3YXlFSrrSFP/CUxat9maWzouBGXWrOd0m3YTzJyxH4Bus0A7Wd2ILXRKPv/KDQ2t5a7X8/n1zXuX9rOV9SEtoZCj+OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZYsqyIn5; arc=fail smtp.client-ip=52.101.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZYsqyIn5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXEAzuURK/mG7/cP5J3ip0pgDz60OeT+nw8EtRAooUdlRgIHNSrfKV4ANChju6RhhnK+L0ZkmPPtDtFUALu+cdVeG6h48tDFw7/vmbsNrJijkiMAzZRyddOfj2Pig52P6+fGReg/gV2dm2MhhFypGnTjn3HIaQrC+hvrLwfPlL233JOnU5tY9X2z7Wodd2iSsKtYZnj/PHfB8YpwbCZSou/H2cNu7VUoVFZ1MfA9K0VOyHzdV9CvDEy0rdeSb28N5dfQyHt19aycYGvgknF/Xo6WWk7oNzgffZTJIqbn742Xq+tB2h1M+7Ohg2aWSNax9Z/4YvLDgC9PIFR1Rg+uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDiYJEDSvmlcNBDGre8gX6wtxHBcG3kadFsDk6thQ68=;
 b=WI+YDvKPFf5jdoF8rHokxkFbnerlWvof2GJ2FIA5lAySUvrTy1A9W2hN2qUT/MvS4ID2K91TiCwjFQAzfaGPlTAMQAySf2mRrkTZ7JPmguRLu9I3NRdiFSBrjMJlNc2XQf+9UxJVQOF54WOQo3sJtc8b72MyhaqJWReteEfBIdtLHyD+7aW4g/XmWysdOXfFvALfUNT4t8V2FY/pO9w+x+f8qsEzWgr7v2qT9DsWGMjp2z8qcpa1fVtOgWGAPmIWOrf2gOIWTqbYOIHCRrR+6F34eJjohj8maZAAXWsE5y6i1GkRa4KKzpuI51y4feZAiiSSbdbvTcu2zJEQ0qh1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDiYJEDSvmlcNBDGre8gX6wtxHBcG3kadFsDk6thQ68=;
 b=ZYsqyIn5DjVN/l9kbRvzVc+j8Z5Y0Jno12XfPajbh83yHKGgiQ8Hj7ojkbxGs/LYnh8r2eqE3wfNVmvvJVQKXzIupOpeDDrlNtvnb49EJOikB8J81KzNBY/1SLyNb6mq/LZQGBYzdpkP9uay/YHlqvqcLnLZADVXKGriTXxlsKk=
Received: from CH0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:610:76::14)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 23:58:38 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::9b) by CH0PR04CA0009.outlook.office365.com
 (2603:10b6:610:76::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 23:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:58:38 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:58:30 -0700
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
Subject: [PATCH v3 04/15] iommu/amd: Make amd_iommu_device_flush_dte() non-static
Date: Thu, 9 Oct 2025 23:57:44 +0000
Message-ID: <20251009235755.4497-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 348ab90a-84b1-45bd-aa38-08de078fc428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S7wZAB8G1XEyjCFNJ+MlwkURob25A9eE4M9XMPcJYjapKWqyJ6a0YSPegOjx?=
 =?us-ascii?Q?kB36mVfyehSX/1hixdGbFtMHLYOt5Jzw+kAYGOXbmC5G5bQsJRHzxUHGKN//?=
 =?us-ascii?Q?k+o3Hs8j0Ee9QMnDWqeaMPq3K6psHtSqNupk7wdmUsLs8VHX3ROBVJkniEo2?=
 =?us-ascii?Q?LfoZAOU42YvXbCxTl1nWpPSq3gIMHSqPXSdmNtgwHkmS4n4YYlyVxk0pN3ff?=
 =?us-ascii?Q?5xp8M6ipU5hDN8IMxQaFWMKhaCuqTt1YRnMuxFHYOppXM0Z0lTs9tTNDPqec?=
 =?us-ascii?Q?titbNRAcQXjrtQMaJVyRCVGuArSDJCmb7zBcVe5MqFWXI40ur/1IcZmIIB93?=
 =?us-ascii?Q?46SilcpLekTQxT52GgxDvk/Bc/VDltRIJMa+YDprx/zo5Gyx99QGPhRbaYHi?=
 =?us-ascii?Q?x7u9gdEeM61fM/uBGzAFodkmVBfLzIO/OeKGqNdx0gYHdSvKfhG9WmMZI+3y?=
 =?us-ascii?Q?nVA8U4AsUfgJ5ddzeDFDTODfhvi3vzRR3qYbsl7d/+OkkNtErL6DzVDIwFzX?=
 =?us-ascii?Q?4zepKMcXWr7mQpovCwTBhTXkA2CE2avJ89obfoT3SC9di62TI14pWY3x2Ljr?=
 =?us-ascii?Q?/Qg5oY0Vzml3npCHVdgeA713+lM50iDxLRcJyK0DamNEc6deBOFWpjbNk/6H?=
 =?us-ascii?Q?/8qE8xxbYUq+Z0Xeh8QrBkSFMLSUQPS2GwRBPTT0CV/EfuD9WO7/QSO0ZzBH?=
 =?us-ascii?Q?eN5DcajnG/VPl2P4Gngkq0VW/hsMorNYCFUDvVRjKV4AYyL3s0lYpzUe2HLb?=
 =?us-ascii?Q?l3K95vHWaZq6BJae7QUjeAyvDIObeX2t1C4ovd8n4YcMU72er2Gs1TvY72St?=
 =?us-ascii?Q?mx5nLudSqSV0QjuET+lgiCP/P5PgFTaauhxh1ZS1VbOQd6oRpVjbKKtYpu+X?=
 =?us-ascii?Q?5cheAvP6MxTZsiZhRU7SNCUfo633VAGEwmSQI9VcCk5eH6HQ/GZ8aPoKctAn?=
 =?us-ascii?Q?8EYi2gnL+7z7fFO1AcIH6gzXv/dDS4oA+8IZuDv1V+pviQLsAyPjJ7UXRIBO?=
 =?us-ascii?Q?mKTPUb3RGA3vGsjZtGQJumedYjfJjxksa+6JzXC3YhIkLs+U/5kALXZYZoYz?=
 =?us-ascii?Q?x+cTNjBbOWuUdQuWMcRsMzE/1hISpsaCqetMA+0xOZf9mTKNUHTmnehQFElI?=
 =?us-ascii?Q?u64UbL5WBIp0DmEuqARwrCqzGonWsoFqvw60x70Vs8noXyy7RvxjogPhw98F?=
 =?us-ascii?Q?XpCLooatTIR68H6qm5DJUPGJASV5unsoskrNaK8EFCywA/DAL8VM3wNf+1Az?=
 =?us-ascii?Q?Jr14b4vxEPPDf15b8mHSxYgkVAPyDcvc9lYKi0IUHMvZAilbDUM7zNf96iwp?=
 =?us-ascii?Q?bcPlkxiQc1kXs8DYJqaTtYkWP78NOiwKPYkyuQzum1yq3FgdDVKduY1VK9lL?=
 =?us-ascii?Q?qZE10dj9o22/H6V4KQqaxJRb4kqo4VMc7O5nBCVst57Wx/bD6bHygLTss3md?=
 =?us-ascii?Q?VSoOb8SZICIsaa0Q+6NK9biYjkS4EKm+pdb06BlYz58KWU1NOhYH8bQPSBva?=
 =?us-ascii?Q?1J5bl+WqmSRaTHaB0hU2uj7m3Aes5cpZB6tmqwNnk7eyysdu3qUFu4OfhKqF?=
 =?us-ascii?Q?CLG6LWA6jipkOPxiCXA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:58:38.5085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 348ab90a-84b1-45bd-aa38-08de078fc428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559

This will be reused in a new iommufd.c file for nested translation.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

