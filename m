Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0549258CE1
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011064; cv=fail; b=RRhEK0ml+OvclJLgnpHJSApMfMym5nrQVzh+ppqo4dVgo7zpleu70ZflngW/755pO1Or9xyCFZk5D3TJ5WUJKE9SKzReNFNvvB0bUx/J3/s1mh2GjZ4Gcxsrt9xr/iwF2LhtKg0pim/fCh/Ko23BX+PEaGaTJxIiJVJZIgs4/Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011064; c=relaxed/simple;
	bh=wxkHwguqR7b27G2jKrNKFTz9BrsCmBKm9mmCGSMuWIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJg+e7lLUJ/hWymaZ9dcI71f3iyevTMtLnMZvI5+l3LHxrpjPgmA9A9F8yfqjRF9V8Nka+hbMjHOpERL/ty32RSIOgvsYE7hmyHG8p1KuVJQGuMJZ+rJhPMclAw9DxU01/zVHOLzSN21809dWj6u611VrO8moGYEnbcAgOY5IPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yN23JnTl; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yN23JnTl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tz/EtjA5u36+BaifDovIJ7sWixynVJlHmaCy8x5uf3cauQQ+Yz0Y5XpvNt95v7c8Ogn53lqHB4SviRbF6jsMSKuVMz3/spIQNIsjgvvlbyA4aE3jPH/MO24gT1Ndr40Smt92KxR1xmKTxmpXeyTtY7V6uJlLLCQ8iF0dw/YixvLjUToGcCnheapDDKtZqfNJtUK+VTZ9dpX25NsTl7VlPRiAbs3p61c9AQQhv39VDnL+/qimytBifr2ikwJ8IfUeueRLT+kyMZBc3M35AJbd4gkEFXqwW2UHCLcaYGAXoRJgcCx3qQcMk7O9vDavpxjggin2WPUk/Yf4IfjBd3xQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDiYJEDSvmlcNBDGre8gX6wtxHBcG3kadFsDk6thQ68=;
 b=VitTNxILTIkdrKoq3jnD2OKGlrzwFUyPbwIdIbBJojrPZjJmo4QrOqcCGwbiqEXNcGAgKVSsoY9Gm734cNYShPwhosiAFqNcgyAVz7ioNVplr5CXrUHMMqoetiFhyNzq5k5uWuzfoT1vpG/4FYvk+Gp6541RPspuunCaYgnIB4ub9ZlhesGpXB2WXf9uOMGDCffS1ni84187yaw3rIKy2/O2AutwQXnYVx9GODhK/jHNBITN6IfHBeJMV6OBTYLcba35lnF81p7b57RSXYIF5982kv25pILIbOob5S9q0VCGNGarw43tWQHZQvcY2DOcy9RFMwKJW4dIbIXSJCMH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDiYJEDSvmlcNBDGre8gX6wtxHBcG3kadFsDk6thQ68=;
 b=yN23JnTl+pgSzNHn++uvvDctHVfiMahFUqWaJEYimLxKIN4QxPg3TG3b3XZvL+GJpqtsxb8r46VyqbAbDKpKfk5MJ+tVp3JIMahZLk0IA1FgTYdGd3OfLOVdoOebp+gWmrEanGjS1jOIL/HHEhRIj75ITi6KlPq2YzYZrDXCkg0=
Received: from BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20)
 by SA5PPF50009C446.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Tue, 21 Oct
 2025 01:44:13 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::46) by BLAPR03CA0135.outlook.office365.com
 (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Tue,
 21 Oct 2025 01:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:13 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:06 -0700
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
Subject: [PATCH v4 04/16] iommu/amd: Make amd_iommu_device_flush_dte() non-static
Date: Tue, 21 Oct 2025 01:43:12 +0000
Message-ID: <20251021014324.5837-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: 480781da-5a6a-426c-b4c2-08de10435659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jXeG7CZJ8br8Re9ARZkPcUZ7IWryy+hFFganbfTJFWYpY+buJj0SnYXJDoKj?=
 =?us-ascii?Q?S6W4xW4a4njwXHAtz3QWpXRZI7Hq9ZVm/gFsCjk9WWDHXsD4WbqHVpaq+XbF?=
 =?us-ascii?Q?XwSp/0b73QLfunkjAgvQhva/BE0XHKUuRgXxWQtjIPHZ9AKbsmJ8OVsMsoM1?=
 =?us-ascii?Q?kM4iALpy9/KFcb5ygPbWy9iI0TDi7lvhfA6JJr++pMDItxqYMPYT7MFJia3p?=
 =?us-ascii?Q?MXwkk7f/L27TTRWZWHmEuD2jZmstz2+Uly2mbEWuP8hGcIAeKuJQqLrjOcWC?=
 =?us-ascii?Q?fMfTQHbqz3IkZJzY3prl4IzYvbJyUm9m9V1SxRrv5izgwgBwNvP6arK3K+54?=
 =?us-ascii?Q?qyJR6MoaZPpilyRUqfvmHfv2qhEsUyGAXWHSrLM0tkinv0z44FsFA6H5ErjQ?=
 =?us-ascii?Q?5hL/SXQdTR8FBi9reoV5NnAmaXW9Na8T6z/0kkjlMF1hytX1tuGQwaREB0X4?=
 =?us-ascii?Q?Y4J7423klxotw5UPV8O01RHYNK6kGJm7DBvzsEkrBxXBGI+fzcZ4iycFRjEx?=
 =?us-ascii?Q?XtDrnhdkd++lXz6leO5MSx/dfln3hdbbPqxNsjW6ZAGMjAnndbLLENb4p2Hj?=
 =?us-ascii?Q?FkkEF6k6BhkY5Xn9TYuNLxNhVknyLOWOFvGhlFcQ0yRHNijbi4skIayRW3MH?=
 =?us-ascii?Q?orYWeJUj64XHXC41AtLN6+pOQ7ojQqhpy+8lEgpxI2qqladT3YJQWmonKSsN?=
 =?us-ascii?Q?A7z8qLLoVhIOnXD0QNsAHNbugdkAWn8TxS0u6HkntyiKa3CDAfvy1OzMinOB?=
 =?us-ascii?Q?F+gQFn+dnfphTmLpl8AfrYNFOgYvJvqfEG+t6767QoAZhfiwUVqJ0nXrk3Pi?=
 =?us-ascii?Q?xTTVIvzuZRJRBCy5lqSws/Qtg99iZL/y++D/vO3Y2fI1sKJ1s7ulkY0EIBbN?=
 =?us-ascii?Q?dJJanvQDuBygjAeeBkeCCoBVdyDLC8JlgM4ue+gn3yy6bAcXbZKus1SN0VhP?=
 =?us-ascii?Q?sa/J4IjAANI88oxqgF+PQBmMm+HixStiLRezgym5WRBBLfjdQrtkTBZtuKqM?=
 =?us-ascii?Q?esgV/9wS2P5NCWKwA5Onvs7Kqv2CKhiMyUiuLxvc66uYeQyKNV3mQqdgnfZa?=
 =?us-ascii?Q?/lNsBwvm3HhtF5Gb8XOeESB2XZsOD30pSix4HHLSHJXtPqB5rVwam+w6TTyH?=
 =?us-ascii?Q?KpOSpp0HHTbmWqmPNqhoOhK9Glayqz8tUcEx9wemjxEWMsYxqn6jvSgfxzji?=
 =?us-ascii?Q?gI3zYzY6YSEUP4TNd28wz8VZztEO0XnHbQ/mCsjoGKKwHdxwZDe648ng3iZr?=
 =?us-ascii?Q?kH6LZf3OHBGsBNG5XgyVlVqNS3PY9l5NG9GQs22JnprHlHC/qFVAvmEWKjoN?=
 =?us-ascii?Q?INEf8I4EGpS+5AVN2FijTLFapLs0ecSFeJe/f8j4je/qUCsNVvgodnXN/0Nr?=
 =?us-ascii?Q?cbs8ALPfTdGBa+1mAac3c+bkpKTRYHTEktj7QdlfbJUGqSYUm8/2NgXQ4zbF?=
 =?us-ascii?Q?Azq9kJg/OW/wMXLZjPiZFo8/bvGl98UBFngZozxpjNgYzdanRLEy0TbzW7NJ?=
 =?us-ascii?Q?KSNQRFF1OJFTzBMinB9KXuVdDhtr4Lm3Csdi/wLALGBmCCc/QoEld9gYV4QZ?=
 =?us-ascii?Q?+SHRpSYjl3d0LgW4LZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:13.0336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 480781da-5a6a-426c-b4c2-08de10435659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446

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

