Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85139E6DE
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411766; cv=fail; b=u5klARzGFvNWm8R30g1qGdaG9iAnu3a70BV628DKaaXMq0YR9S2ZQhdj6OS7MJ8a1on1rX25wewNBQVbTeLX5Y5AW/+B/XmJlzJt3RaH0vesIIcRGHLPhiOheoJPLH7otacM4dlGLopTwZxpI1A874SzS7LVY6IOecwef4fmGeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411766; c=relaxed/simple;
	bh=5EijOqsg65kUx60vUJckK12Pi7m/7OkciuTmucmKh8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ft3mqo2Cou+/6Jmziho9RY1PnoVujIp+zGA+Oorec8Z87au6cK5woMfXNnZtb4avZGY4kKcPoV/vwUxGdfJy5bCtYZdNBP8usxXv4V/yfHWZWuCOyltnYUO1q/hxzv/H1Lc+qkq81xbo526lxOGsgidhvmlV64W87ckfVldhBOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lZx65+OQ; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lZx65+OQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPw69nUl7bCnkwI5Po3LdN5BDAslUXiHYe+Hk61EtfTxxH++tGvQh2HUi0HNeZc8T1ZWcWg3/BzYrSt5vGjzGsQQuV6eHUlx0CLGfd/8DDbfed/fDUd2lOuO5NtX59Isc18BG6RF/5QKIMSmen/TW2yCemtEkWGxBpX3ZEtPkYxGnl4u/i8Q0hzkazu1GonLbJgUxer+6bqom3Eh2FwNnH08KMmBtwqpgTpExr+VonfI3Agk5D8D/ImYHHuiVakm1OXGahymNJOlxRBjiyuoBJWxDDg0zAiM0n/EWJUwA1DAH0q4IDymCgHvl4MXfPag3/6n6TJp+9Viaai+yk1VLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TDx6uKWhEghfaALlmUWp8U5PxwQBmlJRdfYvrbErns=;
 b=VJ5IdY6yWHPxDOpPOloKFtKh+pFSkzWUSw6gQ5J26Eyl3F8KKhgWKMYutMpM904/KzzyybsWzQ0zQlokuz0rkPRM2AdQGsCgT2F6cyzRNYrHpqvVhNI3Rs6DErSSH1Kf4VYR5oykT0VhRz5CWeWgxU5tYN7cQyGIRdvRwap5OhTNRNDBFA7MHVK75AKPIYGEPdeJpVnd2BRFc/dRhZ/pWwb1miVru2vjGyc2vzRvekthjBRDsWwhAi3J64fWhJaN0T6j1f17SnyrmhHHXLkK78RSlSFxeWRXXTfu+lHxFfhOgTj3qgA8/v8CFm6uQzsxMocvFwA/XGCL7ti6z03IEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TDx6uKWhEghfaALlmUWp8U5PxwQBmlJRdfYvrbErns=;
 b=lZx65+OQRJCeTw47mctZ0yPloPhJPzMOy5E9DTTohFwElAl5eNhftNbz1CpASncbYwhn5/JvyZFUaPLh8hV0lOWikJ7TDUoVJVTWuIsnTaSSLtUgzsDGKC2rvFW13pKtqIqechkuZSc9xluv/AVd0cvNVsrBX5zdXxbhmrD9t0w=
Received: from BN9PR03CA0272.namprd03.prod.outlook.com (2603:10b6:408:f5::7)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 14 Sep
 2026 18:49:17 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::13) by BN9PR03CA0272.outlook.office365.com
 (2603:10b6:408:f5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:49:17 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:49:11 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 10/24] iommu/amd: Pass iommu to device_flush_dte()
Date: Mon, 14 Sep 2026 18:47:36 +0000
Message-ID: <20260914184750.222939-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e624c94-effd-4a61-58ce-08df1290e13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/4EOqLdayXOQtj2EizQIDtRX5Fvs3nc7UM0VqNTVU5t2booXFjCoYptAcq3lUqv9xFzy9ELrW/2NMk571EYDASWmeMBKwpmiTW6KCQpYCV3P0TSzIpZ5H/SYh8WLFdsvMsz3cA+H/xUYKYwrwNbnc3pK0hsudqFHe7b0LK2SZxQwHcX/IDiwsDh9i3Pm+SpJdngHmWdLJW8m68Y1UN6ncXUZk0+CDmp5YJaqG4QWV+JxPE9MSDf+6qssqfIf8nnzJYUrIPbTG3yAHsi+XhcOkSh20g2xxbJhbTEbK+m4xHuYd3D6Xo4C4sHEswvNHRwJ0CqaLrqRomav8u+Z8LAychBGgBvheKQLil1pfgPFKPgfqhOENp6OWtuqasdUB8jk2mpyHG4fIw/uhSWKYFDOIaUze6QGfsRFlOZChEMm/GvSp+tY5Ic482eL9Pg3kJfXySb0ZKAkWnqv7sri5fwFox/n5Mx3yvNxX+it/yFZ0l9BwnAvTSg85THU6/5ftL8wiimpJeOwTdaIGke9bLhczqkXQCYn5J4MiHybseZF7mXFWAn0ZC4hhH3HGFjc5q+iNxvkrv7akabQCTMkds4lT8btgZVRCXGvI6Zt4wAFaGblT7pzYOcB2/OqK/E8s91M6fp+fd9n/cE8hZHnf3ugKtndQlNu4woA4z0YND905DQWInIb+/fzIF8nnirp3Ceb+X+FhtvsqUAH7NvKlMx6Rw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ik1YuhTz8RT4hLLnl2FIp6uSujk8666/RrM5ykJDjouljQEkgSGw1WNhCFdZ4tVEVpSsfB1SR1r4ggT3nQVY4vPUHr6dUCbRy//iYruDS3sunNtxy2onRWJFqpd47+FsQ8OR0ILokRF5fm8/NtOjzxUXncInIIw+EfXgFlVqhIdNIQkFfXE7TK3ZknsSONHW7R5gHfjQ0wxkx401aTbmDtEYK+4C+u3vzMI4smL0VwLpYP2J0qADt1osUWnLlez+jm93JvaUb7+GET5X0ggrdxrb9VyUK4jxwVjKHeJfjeH8dCWxCB94PGVvSzK5zf8ENcnrMPTeDEO5ZlpakI1pf004Vv6ubRjFl+9Fyq2xVzokH8OHCXdtvdEsFobhs7loKuRWlvwVHfinMXCpcdgqLis5PosISYdmnKxKQEQ1AKoPslrZJO7mkl5J4jf93BwE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:49:17.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e624c94-effd-4a61-58ce-08df1290e13f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784

Take struct amd_iommu explicitly so DTE invalidation is issued on the
same IOMMU instance used to program the DTE. Also, flush each device in
amd_iommu_change_top() immediately after updating its DTE.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1a2ddfabb7cd..c7b14842a6c7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -76,7 +76,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  phys_addr_t top_paddr, unsigned int top_level);
 
-static int device_flush_dte(struct iommu_dev_data *dev_data);
+static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_data);
 
 static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 				 phys_addr_t top_paddr, unsigned int top_level);
@@ -218,7 +218,7 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 {
 	update_dte256(iommu, dev_data, new);
 	clone_aliases(iommu, dev_data->dev);
-	device_flush_dte(dev_data);
+	device_flush_dte(iommu, dev_data);
 	iommu_completion_wait(iommu);
 }
 
@@ -1817,9 +1817,8 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
 /*
  * Command send function for invalidating a device table entry
  */
-static int device_flush_dte(struct iommu_dev_data *dev_data)
+static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct pci_dev *pdev = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	u16 alias;
@@ -2788,11 +2787,9 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 		/* Update the HW references with the new level and top ptr */
 		set_dte_entry(iommu, dev_data, top_paddr, top_level);
 		clone_aliases(iommu, dev_data->dev);
+		device_flush_dte(iommu, dev_data);
 	}
 
-	list_for_each_entry(dev_data, &pdom->dev_list, list)
-		device_flush_dte(dev_data);
-
 	domain_flush_complete(pdom);
 }
 
@@ -3226,7 +3223,7 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		device_flush_dte(dev_data);
+		device_flush_dte(iommu, dev_data);
 		domain_flush = true;
 	}
 
-- 
2.34.1

