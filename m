Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500275733A
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274555; cv=fail; b=kxJw/DQa9ZL1Jr/6cGqMIzqG5n4kEBH22iNB55fJu/YcaH7g+usJYDPBdh2pNVX85IGMtOAwcV44lRgoSjhm0uqIaBUs9fuNQvSkPOzlzCvaSthNk4y0WyESNUuQga/5NogmWFSeEzMKQ5i7mKZlG2X7dJchJZPzEJLqQbjhts4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274555; c=relaxed/simple;
	bh=GfZN3SwkoxfG4k+/7HvtZ+FdCi4I95DN1XaEyyxgarY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/sOi2sp3quqU3IqeN4bongodw3Bmov104aaJbWl7/vdgGA+V54xV9gFhz7FNFPATIhrb4wqp7PHBJPdC3dFR3Gbob4rQzwvmN4l7AP+GrTRTLZnTwvnQ7jO7sEpfeH7TgXXqEF1z32YG2xvdxriC02ASet1Af8dXonhATqWwJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eCCxiRsQ; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eCCxiRsQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9Ml+yFVIIOQUmpFQwHQc5h94gLlvQKQfSsnSsfpWqWXwVNRhvbCoYDlfm7YcTGTgpkYVehw5IK2fnA5kc857T9jGhYyOSSTE8wD8RAfVTQ31cMYQyiMurDqGdLMPYXg7lJvl7K2mmcvPpSn4RdO32iA/BQDBzGAWCQcoasJYCcp1+w/pzQy7BZbohdkIJjlZt7k8gdhLX63g5YvwuI06bZtBEkmBxbUdlkvDU0+e47NXQ3cA0m130pZdU/CkIgSvzNG/1SLYOciiiAWdKznNC2GsCni+Q5TGJNx7Dy6BVqk+vcssLY81v82fgB0Q77vTUPrE0Q7gqwthjOtwlIKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd/P6Jm0/LjtEB+j4JWFkGyaSdhmTMGgeAReCIF67rg=;
 b=wmemp8thkZxKI4cE2v9OoOaERENS/wnnNXVaB9c4zK1zuv+82thTbJ5/HiTZesNjEm8qwdnQST0LRg05I+qO7/frCwdqNERaQBCpDrDh/W0FRxVVmiPfziZG7ZdoTME0MtN7j7aQ+eNt6xFQE3WBaJJmxOAvA6FnKUqZqwEgtivgzN4T2EgHHAa4NzsUiMnjp65K8dvVeZpDXeiBJNXiHUSAcNOAvq/whGUapnphFKBoFa/DSjXX0lWYOephNwAhrrkEjmX//lsPeMe4o2Pbe4cfg1Q93vqwKt+Kog10xZ9NXSbPdGFB+6vhBm3Wn4MQNx5WVAZMYnzwpa5TJIe9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd/P6Jm0/LjtEB+j4JWFkGyaSdhmTMGgeAReCIF67rg=;
 b=eCCxiRsQtb+BF6qVZWoaaGGp8Lg+GYNfxeyFEeqPuT31UqNM6/WYaFl1Fy+eIkblVJ+SY/ufn+hPaimnDjht2ZFD3ijWUw34orc95XaTjgUkNS+vxsUqcO8Mp4O/O9WNimFs3NkmhdG/q6gjGDygjm90d0HIUcetfKTdFxYv4hk=
Received: from MW4PR03CA0144.namprd03.prod.outlook.com (2603:10b6:303:8c::29)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 7 Oct
 2024 04:15:50 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::eb) by MW4PR03CA0144.outlook.office365.com
 (2603:10b6:303:8c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 04:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:15:49 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:15:45 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 6/6] iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
Date: Mon, 7 Oct 2024 04:13:53 +0000
Message-ID: <20241007041353.4756-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: cec7904e-ebd9-4c6f-e348-08dce686b9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dG5Z9Q4ftErB/RpCONZBgojbGS2YZVM0grtIXIsYygAbYxU6Opq3Urg4WRos?=
 =?us-ascii?Q?5TiWi1ozlfcZ4Q2TV6tXUfdNAmceLEf5EpUHbjszynOaCo7R+CfooUmB3wZN?=
 =?us-ascii?Q?DcXDsaxxW2WjFjlwYPGPpqDaXPWXnsbOeCK/6aag1a1UvpOELX8dBEyRaqct?=
 =?us-ascii?Q?WM+xjRyJbiN+wkKfujVVPIx36aNMDaTu1mUekp27PUnQYNsDmVrEUh0bw0Ur?=
 =?us-ascii?Q?Y/LoZ2p3YQEdYhDHqqCnjzq5y5l+w9wSB5StWq1P8ug2r+hQRaZGdIIlHsab?=
 =?us-ascii?Q?hP1/SCV6ZXdU+4u8MlsOanXxfXExXbDctI+MkIoDgiKSM39dnIY1sUBmXTsP?=
 =?us-ascii?Q?XYq824CWrhTs0hrA7TycBYZOAx1Hv2N7EA9vtJXEKgeTxuG5aXsnewlaQ4AO?=
 =?us-ascii?Q?LtK/D70Rhlsde++5zrS0d0XQjN6PUzz5x3AEciS8butucv7RDZvYrKRnLw1Y?=
 =?us-ascii?Q?cqXs48Pk+4YhdIz/GcOcrD10k0y7X59zvhlU4CDT0ZUWHHMKi3kZBUho6Kwj?=
 =?us-ascii?Q?0msPsgIkgdgF5hVz17//nZw5D7osVCLdY7oo1tyJ29hFnZAkL8drl+hsAAK5?=
 =?us-ascii?Q?TdI4ou2B43uHc2Ofe5tKWHXwMhiMsppyJUOvrjvapwg/YOenw4twvj3MyfVG?=
 =?us-ascii?Q?5jXGv3E8dGjDKUpGn4WmeWhZvUAXyRHmzMQXdFs/P0UkgKZHADisf1i8PRwM?=
 =?us-ascii?Q?rAL7hDJ9GPB5YnGV/P80q/MsF7p7y5FVRR0E3ajvw/2FMyzojzz5bR+XMksa?=
 =?us-ascii?Q?Tw324Kd+1Ainom8MkYslMcV7JRdxlgASxvXkwmu0A1F+JKJgwxo6uaSCM7Jz?=
 =?us-ascii?Q?FPAHrSFf+VN3fwsjbNEYB7wF0KtpPisi5i1pC5R9d7cJrWyZ6onm0Fidxpc6?=
 =?us-ascii?Q?oPPylb2mHs6sLKuUG6v+22UyPyTCqyCpCsrIJYjXbsjXi/tcfnhjeNnXxs7Y?=
 =?us-ascii?Q?GdsCYPA1XmOlvWGEwCmx24gIC/fyub1lV0I21NqGkaXtF6QXOJ2bPMyynT72?=
 =?us-ascii?Q?/KXblLAgT59qSI4arqlRHwoh8YI0zly8W8NMLzJM71Sazt1s+ILHlUqxevx7?=
 =?us-ascii?Q?WMnws/ep4L48/KrxtM24vAl+oX9OK9sBtgSFDwtZp9QZC+uI0nbloppvcSXh?=
 =?us-ascii?Q?9N/1he5l3DHSWxnTNCSuk6nxWZJDPDSXuZa8GxGw1TNyVWDBI/OSakbYeTW+?=
 =?us-ascii?Q?+UaS2RcNVjKpKvgSf3gOItiYSAwdI2XN9FSxLXok+gtVdmYaQ7Rwz0JmzYEr?=
 =?us-ascii?Q?hRD+Ippf66oLXaCG6Y38cBGEZl7KufmK6/l4918RGfjm4UDWRpwQ+nsHHqvn?=
 =?us-ascii?Q?REvuuSHxbvOi/Whw8BtEBr8ppY6ub03lxtO/42C0h1PWu/d2SknYKfx1HDlV?=
 =?us-ascii?Q?vw8M5jsAGLRfiCgsGMTswdJCisaV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:15:49.6119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cec7904e-ebd9-4c6f-e348-08dce686b9d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

When updating only within a 64-bit tuple of a DTE, just lock the DTE and
use WRITE_ONCE() because it is writing to memory read back by HW.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dd7b02b00be6..18a60b4345f1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2783,12 +2783,12 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					bool enable)
 {
 	struct protection_domain *pdomain = to_pdomain(domain);
-	struct dev_table_entry *dev_table;
+	struct dev_table_entry *dte;
 	struct iommu_dev_data *dev_data;
 	bool domain_flush = false;
 	struct amd_iommu *iommu;
 	unsigned long flags;
-	u64 pte_root;
+	u64 new;
 
 	spin_lock_irqsave(&pdomain->lock, flags);
 	if (!(pdomain->dirty_tracking ^ enable)) {
@@ -2797,16 +2797,15 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
+		spin_lock(&dev_data->dte_lock);
 		iommu = get_amd_iommu_from_dev_data(dev_data);
-
-		dev_table = get_dev_table(iommu);
-		pte_root = dev_table[dev_data->devid].data[0];
-
-		pte_root = (enable ? pte_root | DTE_FLAG_HAD :
-				     pte_root & ~DTE_FLAG_HAD);
+		dte = &get_dev_table(iommu)[dev_data->devid];
+		new = dte->data[0];
+		new = (enable ? new | DTE_FLAG_HAD : new & ~DTE_FLAG_HAD);
+		WRITE_ONCE(dte->data[0], new);
+		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		dev_table[dev_data->devid].data[0] = pte_root;
 		device_flush_dte(dev_data);
 		domain_flush = true;
 	}
@@ -3071,17 +3070,24 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 			      struct irq_remap_table *table)
 {
-	u64 dte;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	u64 new;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[devid];
+	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
+
+	if (dev_data)
+		spin_lock(&dev_data->dte_lock);
+
+	new = dte->data[2];
+	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
+	new |= iommu_virt_to_phys(table->table);
+	new |= DTE_IRQ_REMAP_INTCTL;
+	new |= DTE_INTTABLEN;
+	new |= DTE_IRQ_REMAP_ENABLE;
 
-	dte	= dev_table[devid].data[2];
-	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
-	dte	|= iommu_virt_to_phys(table->table);
-	dte	|= DTE_IRQ_REMAP_INTCTL;
-	dte	|= DTE_INTTABLEN;
-	dte	|= DTE_IRQ_REMAP_ENABLE;
+	WRITE_ONCE(dte->data[2], new);
 
-	dev_table[devid].data[2] = dte;
+	if (dev_data)
+		spin_unlock(&dev_data->dte_lock);
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
-- 
2.34.1

