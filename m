Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96B5221
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057074; cv=fail; b=d8OiVzKSkjbj0Eh8bocRTcBRrWTzpbc26akuijeo+0tp8VPrQxrv4n+2hvhXqqIoR1Mp296UjgcGEbbz3RGvUIYFSI1ldnsABmBqKSTSGKxyc4lTir+OxIBO+B49JosCicfdYd/KOsUmAl6nD2bWodTYBukHWFfN55k62M/Haus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057074; c=relaxed/simple;
	bh=j9tKCQAG7Wbhiw0AM2qjkS+dbxuQ5ufrq2JK3IgGt4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sb7hL662PhwgtRyBBzp2u1FVJM/ypH9fgmuNq6a/xvjXLxKEMEYBajQsBjFuznZHVTPq1JTXuor8cJIvokH0oa1rn7ueL2QsbQI4/UEtkuk39+Xa8keCqFZ3RjZECyxYmE+aBNMyG+sMjyJQIatTZ/o/XbauJR24t1Qv7sx5D9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wEMtn7WX; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wEMtn7WX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMZXwtAFEQAxmcdTHEhZQVsIJ8FwMe6CerhstZiw3Q0f7Po4EEzKIZEAlwalxi4XhQkip+w1MjL2b8g2Yu5DB4uJ/GhvJoA126qXBs2pOt5b6JE5DUPYIuS/e1Nx4AJauQlLqDkLWm6K/EuKnvzvxVF18RvKd5bg2TpUcNVYXP26GasrJjohEX77TU7yWSK5dM/V4DjIbvf+BhvrQCOAuaLn3CN89Xg+8z7Lke/NvNRFt0sLIrA8Qs3Xc0rg0FMVbUAojZvFIZBbU/NARASoCKRAI/KXxHL8CSvn85hyfZEFgVfBLmSpOW1AmBAXRXEBj03uVz3sGzF3TjIMsV7W6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0lruNF2hLDri0LHMt1gz+/WFH4Bfvn++e8Ew5NiC/0=;
 b=mCB46EJYK2WSGiLuTIHFHLLm0WoBha2YuUfeHg8pyDZm3RM081/IbK4XiJKOSp0S3sz10nBvKEGUBVH642Bu/2nlt0C9BMpvBZDtaqQcPwQUzBkNARqnVSzLITOHnsq9zjWY/jMluYXlHGoXW8UpwKeaurc6J762uYt14NdXjgIPxx0U1IEpmk1BSlt6/3rj1PzFfYPAVEng9Qcv7H82N0hIZCdznelThhxKtdjvuZmzp+y+EXGsJeBdHbleUgbWIqLMmJcNtrGMypIgLmcGp2iatNvD8TmdUkAXfRicGRg4lxxexSrL6ZndwFe5UvtJyk+2BlAjNYiPqWm7W5gbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0lruNF2hLDri0LHMt1gz+/WFH4Bfvn++e8Ew5NiC/0=;
 b=wEMtn7WXK4HOOkNsxAvV4FaWL/7sMc+A6olh0xGe516cfQubIdLW8enzzQZsDV+ShwbraPqsRB1IGjII7bNmK3YAgy9PRbR9935YdW3eultak6n+t8csh5EgDxz+XOVxBUtUfzZrfQfuCfRcIUBdtp76+6Jz9GHKqAerCRpMDLw=
Received: from MN2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:208:134::28)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Wed, 16 Oct 2024 05:37:49 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::3) by MN2PR16CA0015.outlook.office365.com
 (2603:10b6:208:134::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:37:49 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:37:46 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 06/10] iommu/amd: Reduce domain lock scope in attach device path
Date: Wed, 16 Oct 2024 05:34:57 +0000
Message-ID: <20241016053501.97497-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016053501.97497-1-vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 36556ca4-76f8-4a3b-f527-08dceda4abc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AC7CknXDvQYAXPjEqez96HHTOdPnYOHaj33a2IA5nxoC5DXBbX86K/f03VnO?=
 =?us-ascii?Q?do5YyEuCmYcyVbpfP+DznZfRCY7gRPOCHdKxxcpNXzYLfwWv3zbUgGXQL6z7?=
 =?us-ascii?Q?8JK5HmAuUmyYmgqOPjba5ftipdgI/KiHiGQNoYL7gqXvGiZwkF8JYAp2TSQP?=
 =?us-ascii?Q?FG26GpOoBfvt1ncx7pAOQMkGrMm3GfJ9IuF41I2coXgKPCq3U07/IpfasdbO?=
 =?us-ascii?Q?0y9w1xMm9F5w7ZIa3MIBPXdUng6nb4saDaw0hcXOat+jBIGdekjkurffEqz3?=
 =?us-ascii?Q?qYzYynD5J10jf2HoAuYhcD3HIzvUkrAKdHjClAeWpUxm6yKWdhIZUpSB93+P?=
 =?us-ascii?Q?apd/JLkf8erKZAQ1IoEkf/q349CHJa6yoLteb8x5jOYP08j22GU681DyKm7f?=
 =?us-ascii?Q?/q7fsXGClqYUV7OiaHle6DQXtM/4dEWh+SVDPxld5v+V/V59INFrouCHJ8sJ?=
 =?us-ascii?Q?ItZcwZv+El6RxtfdUzLBBuPNkCEjKzV33NuQNQfHpZQ9HgKyl3S3hjfU151m?=
 =?us-ascii?Q?i4ksM41Wkw1s/vOeuPRstJ2ckg+L0Zbzs0ToYA+p4qoM/FEjSaUrCSgEs8PQ?=
 =?us-ascii?Q?mlzhSQPzdtMyN12TzhkjAHUd1QOEYFiHjtBWTO4Q7LCjr5G2Cgjjl3OFrBND?=
 =?us-ascii?Q?SKJDkYwUJdgfr8cef1VrYz0YMvKuxSksqOPw4zeDu4HQ8WKOF8uWksitrp41?=
 =?us-ascii?Q?+q59SQSXrBlE0y/7hNoI31dcUbhSf8tc2yPLZ6lXfDmC3namf1sFC7a0P8NP?=
 =?us-ascii?Q?B4zrNrGPO6SYw6kGXgBzd/8+rDKboaoMIcssvsN/m7eQ2tv3qp80WqZiPQYF?=
 =?us-ascii?Q?cgEEdnz7e2SmBo0JGM+4qUJtaGQUnIQ+XsTVKiNoBvO+njJR6zIEskg8DyYF?=
 =?us-ascii?Q?pydUnTOUVzi9weRkALJmU7kOzVJQEKo85bmL5tDJ4OSvXyNMaqURCG1a/xRg?=
 =?us-ascii?Q?gVM4L0QzPQjoM4smKNMI2YbqXScK4f3+Hp+bOzz2ogVMw2a83PajknzLCAvr?=
 =?us-ascii?Q?mkHNe9OaD2zhKWgU4/btoBJeHxiaRHYIrcQLTzpAij2fNxXP0Q7cFIMmXVAx?=
 =?us-ascii?Q?UTloyr2NZXTcgP9z4E55asZ8w26ouSeZKNnaXSFEBXfs4IWz5PChn4S18Qh9?=
 =?us-ascii?Q?vKCg53OL4ZhACiuBXTj9DbG1Vkpr17XmQGuvSVaKKoZmzkLkP/k9ZwQLl/bP?=
 =?us-ascii?Q?5aWTMlyA+OZbmVZp51D8i/GDnSY2hIQ2ZO56VaZgBy5hNOMorXciiRJAN//w?=
 =?us-ascii?Q?Q423GE91efvC2/yLAZ6bBziYpNRbbWgHT+Qb7ctlwiYYtuK+i1MZzzUs/Doi?=
 =?us-ascii?Q?cwobUKRmsgfoYyfnaGXcEUtTF153MhtjY+VVYJ78Cil4+jzx8fpXJD1wr50P?=
 =?us-ascii?Q?aLLUil60NFGMKwLsqf3Bt9LaIiV8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:37:49.1242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36556ca4-76f8-4a3b-f527-08dceda4abc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324

Currently attach device path takes protection domain lock followed by
dev_data lock. Most of the operations in this function is specific to
device data except pdom_attach_iommu() where it updates protection
domain structure. Hence reduce the scope of protection domain lock.

Note that this changes the locking order. Now it takes device lock
before taking domain lock (group->mutex -> dev_data->lock ->
pdom->lock). dev_data->lock is used only in device attachment path.
So changing order is fine. It will not create any issue.

Finally move numa node assignment to pdom_attach_iommu().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 49 +++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d74d3b65c939..a738d2d7f0c4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2016,16 +2016,23 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
 			     struct protection_domain *pdom)
 {
 	struct pdom_iommu_info *pdom_iommu_info, *curr;
+	struct io_pgtable_cfg *cfg = &pdom->iop.pgtbl.cfg;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&pdom->lock, flags);
 
 	pdom_iommu_info = xa_load(&pdom->iommu_array, iommu->index);
 	if (pdom_iommu_info) {
 		pdom_iommu_info->refcnt++;
-		return 0;
+		goto out_unlock;
 	}
 
 	pdom_iommu_info = kzalloc(sizeof(*pdom_iommu_info), GFP_ATOMIC);
-	if (!pdom_iommu_info)
-		return -ENOMEM;
+	if (!pdom_iommu_info) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
 
 	pdom_iommu_info->iommu = iommu;
 	pdom_iommu_info->refcnt = 1;
@@ -2034,43 +2041,52 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
 			  NULL, pdom_iommu_info, GFP_ATOMIC);
 	if (curr) {
 		kfree(pdom_iommu_info);
-		return -ENOSPC;
+		ret = -ENOSPC;
+		goto out_unlock;
 	}
 
-	return 0;
+	/* Update NUMA Node ID */
+	if (cfg->amd.nid == NUMA_NO_NODE)
+		cfg->amd.nid = dev_to_node(&iommu->dev->dev);
+
+out_unlock:
+	spin_unlock_irqrestore(&pdom->lock, flags);
+	return ret;
 }
 
 static void pdom_detach_iommu(struct amd_iommu *iommu,
 			      struct protection_domain *pdom)
 {
 	struct pdom_iommu_info *pdom_iommu_info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdom->lock, flags);
 
 	pdom_iommu_info = xa_load(&pdom->iommu_array, iommu->index);
-	if (!pdom_iommu_info)
+	if (!pdom_iommu_info) {
+		spin_unlock_irqrestore(&pdom->lock, flags);
 		return;
+	}
 
 	pdom_iommu_info->refcnt--;
 	if (pdom_iommu_info->refcnt == 0) {
 		xa_erase(&pdom->iommu_array, iommu->index);
 		kfree(pdom_iommu_info);
 	}
+
+	spin_unlock_irqrestore(&pdom->lock, flags);
 }
 
 static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-	struct io_pgtable_cfg *cfg = &domain->iop.pgtbl.cfg;
 	int ret = 0;
 
 	/* Update data structures */
 	dev_data->domain = domain;
 	list_add(&dev_data->list, &domain->dev_list);
 
-	/* Update NUMA Node ID */
-	if (cfg->amd.nid == NUMA_NO_NODE)
-		cfg->amd.nid = dev_to_node(dev_data->dev);
-
 	/* Do reference counting */
 	ret = pdom_attach_iommu(iommu, domain);
 	if (ret)
@@ -2119,11 +2135,8 @@ static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	dev_data = dev_iommu_priv_get(dev);
 
 	spin_lock(&dev_data->lock);
@@ -2138,8 +2151,6 @@ static int attach_device(struct device *dev,
 out:
 	spin_unlock(&dev_data->lock);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	return ret;
 }
 
@@ -2149,13 +2160,9 @@ static int attach_device(struct device *dev,
 static void detach_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-	unsigned long flags;
 	bool ppr = dev_data->ppr;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	spin_lock(&dev_data->lock);
 
 	/*
@@ -2179,8 +2186,6 @@ static void detach_device(struct device *dev)
 out:
 	spin_unlock(&dev_data->lock);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	/* Remove IOPF handler */
 	if (ppr)
 		amd_iommu_iopf_remove_device(iommu, dev_data);
-- 
2.31.1

