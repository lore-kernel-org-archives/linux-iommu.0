Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54D2D8DA3
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457341; cv=fail; b=MVRgSy6y6BG/5Trpt2BMBjZW0L6nUvwo0SloqUTMbl4BbCx93+ovPSruH5HyjUdqVzoy5u135X6of6qNHmDeOzA8CHKn1nVNRkbXo9JKWX87AToes+WITrtYRBVDh4L7v7HL/beIGr9+RinnO9QVzL3JbtVcVVb7IqVTg/cdWr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457341; c=relaxed/simple;
	bh=GF+cYYvNMCSzgA/nzXAcUCm31kFqVR0uLCgkb2WnuOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRHvTZeC/06pIw5XHgsBmWwOG5YQ9WROohV18AR7WJqbvCauphfo4dbJg2ztKzygzZiyNMcVudZt5+yXhxr7f8RMGsa1zZ5tyaPIOaMF7UclnaxMTC5DifatU7NO5hyYXDKgnREp4ixFAgsbXgNqx0+q7cnFyzGiQBOyzeRqm9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q1BbWQVi; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q1BbWQVi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZKz5cptUTwC/m6esAOYNiL7nSQ3wbLCJDMdd2Dx0PuQ86voqxJk7i76OIBdWP12L4FPQT7VWFRtKl6dZiSf8u3YZDI6g+J4EipZTrS2Im0g+UGzBuAAcCXZG/rxw9qXFFVv0HZh0jcnxAH6IWgzRc2pSV9e/hbo6xbocSAkZ1Gp/knSM/sFJXjYCo8PmgBMcwgE09Crg26vveH40rnsIH6hYMLV1Mz60QE5EVegdnE6EkVR8+ve/2S5XhoyEaMzhfCuCuCvgkFDAAMc8Q/uTQ/e1VXI9B0d5+9uwY7H+kOdEQYyS++ktCnNRHx3gBmiK48Qw2yuqFbpDjih5ceUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdMLarvre61YiY7b/kjBXU7/Q19ef8ThoWTO72fth38=;
 b=dLjiJkrBU+I7xY1/ZbFrhwhc87+nXA0+TBMV348vLrBgbayVVQINqfoxNssi3Kq2UPVqp1wtDwndqGXjHg7W1ALg/eelroexF/9w2VZW1HJjXgYAr0884U8XhceT+9XrDVKLRA8jRy/CO4GDCr59g5Z/C1uhNPqwitohF6qDsDZxUqpfWn9bMD1PgnAo1rX8LdzRTV1hAORBUTmy2IR2Bh6NQgU5OEz1Vvit/5XYSxwWWp4f4saaycNSvOQSeyO8JpQuIT/b0K/wg+CYH5tejwbGGtPTGS3+V6xEnQ2XiAniff9GN4W2+p5z1f4q3Aqb2sXLspCv7YlMHDNZpmdOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdMLarvre61YiY7b/kjBXU7/Q19ef8ThoWTO72fth38=;
 b=q1BbWQViz4Mx5wzrowKNW3fIO8caIV5Tcf7qKMoGYGMMie1RGYn6KEpe03eKqwxc5ISardZtAqwb2hk+AmmjRLfGbKvkBgcq91Xm10qbQlpGVE9rG4prU0nTCcjGNitzzbhqtnS2Ch0IyXEqw+DWDBp9JtztlKz0CWXBifHbN4E=
Received: from SA1P222CA0167.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::15)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 06:08:54 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::aa) by SA1P222CA0167.outlook.office365.com
 (2603:10b6:806:3c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 06:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:08:53 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:08:47 -0600
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
Subject: [PATCH v6 03/13] iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
Date: Thu, 15 Jan 2026 06:08:04 +0000
Message-ID: <20260115060814.10692-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f15cde-eab1-43c7-965b-08de53fc8f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fwPcDdSUuJVdKuHnJYoc5R8OObXLLo9b9awC8N55132U0xRLVbxWYtjmGCLt?=
 =?us-ascii?Q?lfcXU2yQpt/UkrlnlC/x+Ppv9RL5k4BH08wWaNMFr2YwO1iC25mYK5Uwld/L?=
 =?us-ascii?Q?vJtogQQxpD419/3csFhbXry3o5vPGAcsptYtyqFJbtTA4h+SAUKXTgNRRQHH?=
 =?us-ascii?Q?XnrHWww6DxzurwqGVsmp6Py9p2rWPNSa14XNs4QQVfNZ3udYEArcW2+x6oZU?=
 =?us-ascii?Q?BmoIGsNDenbHqKKS2V7mxQIVfRenDDN4P27S8eeCHQXIPXU2i5tZwNQ9OjGw?=
 =?us-ascii?Q?GoBauptE+3KqBzJkurMy+jv9cy/mdqGwMjlxlKXPoWLvRYHGOH3n5pdIfN7G?=
 =?us-ascii?Q?ws3FMXxN87kyILiJ+24dEJqk0b/ULZL278DacxyXJz4eB2UnDXHb+FMUJGct?=
 =?us-ascii?Q?6K5LwyNDZDTd1kZSfbQn1YGLxvlfcNJ7PI4euP6DYVC1Mq6wfgLeRIEgYbqw?=
 =?us-ascii?Q?LiYrmaeNSQzF45cTRS+S4JWPj3E6Eguu9Z7eUSQvRk6CI68d7Sy2F1Q+elsU?=
 =?us-ascii?Q?LSep4fmwJg3JKcvpr1q7/LjX8VaJ+ekMeT3LSMm03Q/vlC3Q8AdPoeJ8QQcI?=
 =?us-ascii?Q?7tazYsXdWqwFAZ/PHVRBrr3KSiZ5uf9f7plnn0q+sfFUlH9WOI8FIQp3Zp1g?=
 =?us-ascii?Q?IODPRy92d/KB7dx0J/wiZaj1DWp2AqwP2y+FiRJCR84k4Zne7VHzGllEvI4Y?=
 =?us-ascii?Q?p7VZYLaSFGmFfF04Y5ai+LFzPqP51U3i+Vr2GoHKSZIiCR2V/BgJldTdNrel?=
 =?us-ascii?Q?UwbYFDjJ4/RX8ckr1dt1ro0pNRiiAqTmfLURfU7u0n/apVOoUSOitT+XPhfL?=
 =?us-ascii?Q?5V1X/ORaw3H/zjK/FCc2yLavrGUVFSGnBrnET7+AsevxWDUgEaJRfOa6xK/a?=
 =?us-ascii?Q?tlxXS+t5reN9x02L7481EEbz9fOJyChCkayV8wxEQgOKrSa6txdKue6Ce02c?=
 =?us-ascii?Q?VrI7krhMIU/o9W1FKDm2D/wYqn1t0Il0C5veibWhX7R5RtG5R2qA32l73nNw?=
 =?us-ascii?Q?sWUHqiWaiMOomnmx7L/MUD5yfjKWTgSpuwxI+cVeHVqogtXJ8rfapMnq5z1J?=
 =?us-ascii?Q?6P4jaLa5ymJanh3o+1dhyvhgKjHlkLYv942p/cFk0yKITVsw23k1FcHs0vEh?=
 =?us-ascii?Q?mxdmL8wURjPl9RQ6HK4qYdeTPsCUFYqZnouBktAVLdw1c/P/+azrh0Wb8cLa?=
 =?us-ascii?Q?3dG+mb8MBmivlaTpESuTMQB3vnKvQB44F8nffLPIuVk4HQ47WrEh0n4tDoMq?=
 =?us-ascii?Q?FPeEL5RJrBzCJu5qUhOQn5HDXBuCSdvP11GgXXHAfvEaY0nW0Fk0zCoYziw8?=
 =?us-ascii?Q?vcoQTzNmD+QEbjo+niCQXecSwd9F7ln+mllAQ/K3e8fm0xXzm0mRMIuYZALo?=
 =?us-ascii?Q?K6SaZQvYCrpu9djSWeI2WKK2V8ZNQWewWMKrCrdkaF7iG+IG0PQ5AaJ9WccH?=
 =?us-ascii?Q?cEef50nFiYDBq+8gxJpodmFEIx9T5+I7m9gffG2Wrg9fdCa4Jl+jIChFIhI+?=
 =?us-ascii?Q?6kbk5A+dKm07Sx2LKWLhEWrMzAPM2RBtF+ETtJL45i7ktvr2qFEsNADb+15X?=
 =?us-ascii?Q?CTig4AXJETgFJuDF6nl6+v7FNIye1KLEDU+a4o1ATzNsyiH/3o1g3xicUqZ9?=
 =?us-ascii?Q?9zmezkq58iwxs2YIGkWK/VsgCN5zwtc1RnAF8f6ycNbXcQYvJBlxwcyaHjCx?=
 =?us-ascii?Q?QYFb0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:08:53.1718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f15cde-eab1-43c7-965b-08de53fc8f31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287

This will be reused in a new nested.c file for nested translation.

Also, remove unused function parameter ptr.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  8 ++++++++
 drivers/iommu/amd/iommu.c     | 13 ++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b742ef1adb35..8eb5e9857079 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -190,4 +190,12 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 
+static inline void
+amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+{
+	/* All existing DTE must have V bit set */
+	new->data128[0] = DTE_FLAG_V;
+	new->data128[1] = 0;
+}
+
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2ab0f3c98425..ded8d4ba86e3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2011,14 +2011,6 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
-static void make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *ptr,
-			   struct dev_table_entry *new)
-{
-	/* All existing DTE must have V bit set */
-	new->data128[0] = DTE_FLAG_V;
-	new->data128[1] = 0;
-}
-
 /*
  * Note:
  * The old value for GCR3 table and GPT have been cleared from caller.
@@ -2068,7 +2060,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 	struct pt_iommu_amdv1_hw_info pt_info;
 
-	make_clear_dte(dev_data, dte, &new);
+	amd_iommu_make_clear_dte(dev_data, &new);
 
 	if (gcr3_info && gcr3_info->gcr3_tbl)
 		domid = dev_data->gcr3_info.domid;
@@ -2149,9 +2141,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
 	struct dev_table_entry new = {};
-	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	make_clear_dte(dev_data, dte, &new);
+	amd_iommu_make_clear_dte(dev_data, &new);
 	update_dte256(iommu, dev_data, &new);
 }
 
-- 
2.34.1

