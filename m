Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968119CC20
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680343; cv=fail; b=tB12HpG+7ym+3OCVu4ZOtG/KsoVNPrQQK4AQbeAwIaEBgNEKjduJsu27ykn4lVzIQP0yvwN1csHXUKTAaQ/fk4n0SDo53HbYFAV6K/+7Ao4KBIe+ltEJ3khBa1+GlT/gv9RALMFxRhCok8/rQAQkpjy6vvmq2Dwyi29EigfpErw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680343; c=relaxed/simple;
	bh=tcHurTLJftStQvDzmCz/ElpR9Vq7KZWkSeExKDdmbCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJ1gUX2b9ZzhxdlhBc19wsEJ1EC9mPCnklTeJRt/JsJKrvxK77YKm/i+/qgTpwRZ7eqTo7tEtQ3fa0XAyEHWiU6Lu3NX5kA807GXZ4GFBrIkpWeKgsq9nid1rf/hyvPWl1s52Hgd5MjUskbFf3QRmAbsLzci++24rT6LMjXdA/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yQE2RVgt; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yQE2RVgt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mriu60cHOhWhMAOiE9e7n5V7ZBn/H8Mzfya2uDwUVb07mw/vWmO62N8SHNvVTFaKrGJDPm4tpUjuJlN1mclZosLkzvtliy2UigOn6aJQB3FRfVDiU4tM80mlsIOEYhkp4Cl85lCrA0UQwiDaCvKwN7ymW4woIJNNHBntat53GOQx8V1tTfqJ45pUubMNvK0TX+DsKZY09JHMbktiyFRDf0JqpBocfKl48U3fFSoh9h4Fer8SboEJskU0a3WiD2KR7dBkcijL8MFxYe6HFbfLYLOq2c+ENQeBXK+JICXgVGR/2kopqf9+OYL8jJRF3rXmLBBhWfOLl3BNoBiIt5gIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDjuVggdL9oViauV5EhOXO9CQkcjAq1Hn7vCpJG8PbY=;
 b=ucnPZJMNLsspp7+1KwzSep0+oEM7/D6ZgFZzhgXKd27oU/taHOmDR+nHe7coEMKBfBsvEnCBUaYrYuxf/ARkFEE4GAXgxJ/+Ei5yItlBVyojkH9+tQGqHbbpXpxizN4+RXeiw3Ghme9TbVDC1wmYTrjZyxRbCJHFvFQD+SvweA7mrLM3X5/RhqzItrngHvaxlDyVX/v8w6fDxRDf6Zc4oOW+0sm7PNUMDCKqF0VaXH684yeox6AOzBOdx6TJchofiKL9FEZviVNH5A3i+dpu1NUU9pjjYg3AE86udAZHpFvrRzI+xgZgwq4BUUaiEurCHn97kFjEtMh93AW0es4Y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDjuVggdL9oViauV5EhOXO9CQkcjAq1Hn7vCpJG8PbY=;
 b=yQE2RVgtZBZ8U3uEwiHr+0cWBrJSOEgvD3AsatBgTC8qxCinaTe2Kk6MuSJWscFE77x1CJmixGCteIEMXTfjTJcZStYZXzvNyG7XqsjanT5LTM3+8GbC0cCZFeeNCwT3qpYlM8uGlgVV4RHRzLav/h7vElpxH4IJJUl9RZA0B1k=
Received: from BN9PR03CA0597.namprd03.prod.outlook.com (2603:10b6:408:10d::32)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30; Wed, 23 Oct
 2024 10:45:36 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::d9) by BN9PR03CA0597.outlook.office365.com
 (2603:10b6:408:10d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 10:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:45:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:45:32 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH v4 11/12] iommu: Put domain allocation in __iommu_group_alloc_blocking_domain()
Date: Wed, 23 Oct 2024 10:42:06 +0000
Message-ID: <20241023104207.5894-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023104207.5894-1-vasant.hegde@amd.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4b042b-a137-4949-45f1-08dcf34fd3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?elClEWgk3t4ecJeZ3zR78WMojUKXR6C+esF9L3QVRZA4Qn2yYQtOHd4fR4jf?=
 =?us-ascii?Q?NCOI6SFFcS65vbD6L8aJ1jJbIKuhhlcv4m/zvLE5YqS3laiBjTgmHaMgZqYj?=
 =?us-ascii?Q?buBFzejIJVRs9RJ9P2hoaxQXQm9AcDWZs4QMY8/FqdwYXEymI+ERwQcRuQBV?=
 =?us-ascii?Q?kIuqQwoLGH9NhHAdOZDQB5bcj8bq4Tbl2SsXBbFIGT9jv8Mi4zLb8N24MMy8?=
 =?us-ascii?Q?KUNhtH04gW+S1w8KD394cc1omnlNPU0uMuqaEQ5cccQfFUkM1acTnbJwKKvS?=
 =?us-ascii?Q?yd/dkQYEjP7CHOVPfWjapPX9dpxwwoEj9Qehf1qVzDKlnc4FGjH+/i5BsRDZ?=
 =?us-ascii?Q?R6wLzXMIEe57xW+e4+b6sJOQTw5dJ/QJifnHufoAeUGsq7wxPQYVfGqWST+C?=
 =?us-ascii?Q?RLs8tnR0AWfyWrCX+q+1Wc/9AFA2VzxE81sa/MXyxrvNNZp2CsIHIz65kdq7?=
 =?us-ascii?Q?1RuwmmCpejHJNpn9Y/W5UVPyLryg4sCPP84fkT/jUTx4EHAzzlnr7PjCxNXX?=
 =?us-ascii?Q?aCiQj5zd4WLOvdt0o6KDjIbv1yIh5+P2f7Uec6lHf5WZYHxdxC5vl23nD3Pw?=
 =?us-ascii?Q?/2AaI7V0ZSi1+LNb77kUR4wnS+oitiZY54eBLFhlC0rHLE6AhoilOOM77+tP?=
 =?us-ascii?Q?VL+nmyVRGU8Lr2xyqI5SQ79aIR5l/muYS9OQ0oUuy7zqVK3rRKgV/Ur4FnW+?=
 =?us-ascii?Q?pAgvqZ4/l/0giPuyeD7VF6vs1Ycb86pFMA/wb0582F0kaQnsribDuWck63Tm?=
 =?us-ascii?Q?ZNYwXwsBpi4R/2E7pDbyAjM2GC8ZAA1Sw0a1tr3jpLcttW5NI54FSEmXBIdE?=
 =?us-ascii?Q?EYaExcmlNbpWxgTyOErHyNwbz0O8j8L/vTzuFMti6nzUZ2fXDdmUv2fSb5yh?=
 =?us-ascii?Q?+UjGCw3rJibCvaqelRCrJaE0YeXc4NlGxnLOtFkhN9+ncuVEQs4hGK5C1xts?=
 =?us-ascii?Q?UfhSL+JdBWn2lUXXis36YxSoYKeGCpYdXDNOl9xakX52s6iJCOUFCHm9idJ5?=
 =?us-ascii?Q?2pRUDRkll1OEC7u6x0U6zzbyEFeNg1luAhKfQGrRCs0nq2P8v/HrC6hzNzDY?=
 =?us-ascii?Q?aIvKDX2CGeM+3I/RmkOADSCIzY+zwsOaGpWDAVh8lgqKAuxG70zEnANpYLHo?=
 =?us-ascii?Q?diqJEYvCskVfr48rxj8iHjtJxblgHHGrghBnDaxad46rXBPHNRKlL7Bl66Nt?=
 =?us-ascii?Q?2QK8geL3g1Lj+eUZKwqXN34HgfiZhhXvm3ElpXCfxINBK9hlwgKdbN3nUpKH?=
 =?us-ascii?Q?u/LxE4yQCc/YamvyQBxnuuYIqUfMdePq6Py5p5k3JSVEsn9XDHGYQb8ZMl9C?=
 =?us-ascii?Q?lLKTHt3oQuqyO7xf7xvrjwgKjSLa2UdYiGWiaWbUeVAIFRzzVaklICT43JZ3?=
 =?us-ascii?Q?pLoFlh4KcKdrkAXG29Pvdva0aMPPhun49p9HaMLp6ocCH0gWqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:45:36.1643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4b042b-a137-4949-45f1-08dcf34fd3e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445

From: Jason Gunthorpe <jgg@nvidia.com>

There is no longer a reason to call __iommu_domain_alloc() to allocate
the blocking domain. All drivers that support a native blocking domain
provide it via the ops, for other drivers we should call
iommu_paging_domain_alloc().

__iommu_group_alloc_blocking_domain() is the only place that allocates
an BLOCKED domain, so move the ops->blocked_domain logic there.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a7286c406170..4677b676bd0b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1985,8 +1985,6 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 
 	if (alloc_type == IOMMU_DOMAIN_IDENTITY && ops->identity_domain)
 		return ops->identity_domain;
-	else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
-		return ops->blocked_domain;
 	else if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
 		domain = ops->domain_alloc_paging(dev);
 	else if (ops->domain_alloc)
@@ -3212,22 +3210,25 @@ void iommu_device_unuse_default_domain(struct device *dev)
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 {
+	struct device *dev = iommu_group_first_dev(group);
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
 	if (group->blocking_domain)
 		return 0;
 
-	domain = __iommu_group_domain_alloc(group, IOMMU_DOMAIN_BLOCKED);
-	if (IS_ERR(domain)) {
-		/*
-		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
-		 * create an empty domain instead.
-		 */
-		domain = __iommu_group_domain_alloc(group,
-						    IOMMU_DOMAIN_UNMANAGED);
-		if (IS_ERR(domain))
-			return PTR_ERR(domain);
+	if (ops->blocked_domain) {
+		group->blocking_domain = ops->blocked_domain;
+		return 0;
 	}
+
+	/*
+	 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED create an
+	 * empty PAGING domain instead.
+	 */
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		return PTR_ERR(domain);
 	group->blocking_domain = domain;
 	return 0;
 }
-- 
2.31.1

