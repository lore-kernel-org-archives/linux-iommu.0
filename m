Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA04380FD0
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735116; cv=fail; b=qe6+iPjucW0ZCZ8Hv3BypdZlS8jnzN2bdh+VJzmfAgX/1oapCOnnwBQOuwxrLHsoRMmcpQSe2WauCx+L7ejFfdoKYTfTYwSmbxotJ3+fllTEJHhG6B8yrf6vPL0tNCHtkuU30hWLv/K527ZF7iDAG0eP9pVrWy+5Ge7VZraS2xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735116; c=relaxed/simple;
	bh=NILOLy6lFH8IslxmfVXWD9SLqQKSPiLRBvuFGpj4EyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssozgx1p4PIorZBjT30oD0qcNmZ4cjT0Jw7fqVXDCGXpKuamo5gqEkI66zuHt3JkpZOmLXX1z/k42Fkh8onWPCyZCFPFdlttb8D++ftVv2PatohelmwNzDQg4PEWPqOT++mtNhW6oKY9AhbtXYiX9CQ1F4fCnWJ1DJYzQ/Sfb7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h/BbDw/h; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h/BbDw/h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlDKlR17CJAzl/LyVD9mnjVPa5aQS/qO7b9ooJUcmpPglI0ShcLO+m9uVgvdPmB0dEqUY13RuydArIUwUOFrpctn5bxW5lOz+MJ5ASxxp4S9yA81bV/kLFjHh71BJ4TMsyQHx3tL2xFfepKihmmW0Yspcq4ZeJScojcgIrK9JuifUKjemE6vGUvp2SjF87nTZoQPr+Djlod3ZbqWznu7olwUixHZpZsg3WU9mjaY35rx2jD7f4Yi6YQ0PQUuDVEuXW3HoqeXZzdbOWIH4awygSQhZn4M9/2yOjWEZMYbk38EmVqfcouy71uIJRKAARYxFa90DP7Ng9p0DTEf4/DaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZCaLIGE+Ik+dj7lVHs2X85RvdkVjkKjxGQXKj3b1lc=;
 b=JJNDy6yayupWovoyWIteaoEkqx7ePax6NaXPvPHhtR87wptCCG7ctOdVFm/MGBq/my3WiSqkNDX1Q9cvDdLrWa2asodtdlpr707Do08wi0OwEzxiGyUSZz50YKFHc0DfgAMTo0HtdAr+XazEQCS8p4kXtQuP7+n2VHE9VlTF6uFPT9WVhPs+MWf+zS54hGg3PEOO7PGmm4bWp125mxMlYIkQwg33rsDP5Z52Nw9bPX+qfoIaVr2afrl3kzus/2NEdAoXoHgfo44I8DUwAh+4ZRNM31XdSz44O1fqj75pfbCriUR9fYwsp5442TJPsj807dAh987yhSJ50E8e+LQu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZCaLIGE+Ik+dj7lVHs2X85RvdkVjkKjxGQXKj3b1lc=;
 b=h/BbDw/hXyCfgCkdpRFq7tDXDKBre9P5cGPxRTznVKuvv/XKzBzhYj26u9dnXiAh9nuq0vYdbC0rALjPbnf+T8e+gGaDil0yppNgWx+9hc5i6OhSr6PfwGiqNut2Cy067S2pVjua8Z/K0x45PCvcEvfgDuKBMwk/C3MjifrdDOZrXlkdvvyU3N0lagE2r2NdeM0YZBWpEDKqkRxPJvZRkn27U7HOl2RaS9udFdHm0oT9R99IDoluqcVLkiHobDm6FvvYIb0xAoIvPw5LtIIGzIhyFD07Ng/pElupM12Yv5cRDAgZmn/dFusfmp9G/CbIcVBN4hkY/slYYA4LMd1w7A==
Received: from SN1PR12CA0102.namprd12.prod.outlook.com (2603:10b6:802:21::37)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 18:51:45 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::1e) by SN1PR12CA0102.outlook.office365.com
 (2603:10b6:802:21::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:51:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:51:30 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:51:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 11:51:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v3 2/4] iommufd: Move vevent memory allocation outside spinlock
Date: Mon, 25 May 2026 11:51:22 -0700
Message-ID: <ac2d7ab700eca8bbaea62b3e1e327d21249bb9a8.1779734952.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779734952.git.nicolinc@nvidia.com>
References: <cover.1779734952.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fb1f1f-b16a-4918-f939-08deba8eab0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	cLTHkCS7Xle6qNLE9pq3LOWK1P/+izpGHF1BwT0c2sSj2Qydhsl9cylL1phLNuaa4CxrFs2X3SHdUxur69OLjYuLzTbYaDbfGDphkc23aWQDZA4ADnO2RsvdXjGOy+aKluU7nNkHI9D0AtXsiPAx664DEq3sF1qWeNQZ1fPYPRcIRP/eBve4W9Fy1H4ajicc8jyvsbDtRXH5yjtZGptanC2f4irSFg2hrnfq8tcnDkG4ds7Y5NZRjHD4CibIRzW7Ov+3fwemQ686rsVxza2y9NlWeW2esUgFYCQuP09j1fEYFcw77+gmcBvjsNULyfO6xQjvAcoXbxuClFRZbt7IvhNa3pzwsnMbrwAmtVLqgEYgC9LyN233W68SuGIYiprhe0DT2N4U6POFHnV8nlQ/FKMot6Jm+5oGyO9kHM6RjYqP0s+94ldeMsDFmQJlsU6UCLIdGY3A34DyAdszGzYwY6VhE97LxNvYDbnXOGyHG97wOlwEUMWDHHj5QNriSysb/MdP3lP0B+JwH+F2VdYMx/KNQ03uKF5TouRLbX8EXgQWOdaNPKZAkAQxO43Qfeea+I/6tjjQf7DLNLyGojMg0SBAalkcxOWpBtQNisuOXU5qFNdbCwgD55kH+yBqQRa1JZDScfIJtmY5JRXgU47td7i4WCCJktPxzNRL2mEBDzX8B/0ksnETO50bH3PVoklJp+OLBKs6iiOMo4fXTchZ6MTfp2m1ytw4F4QIqBnw9I0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BVAMPV2pvDwyr0X37hjMy7EZjmiaEdZT/zzZk/Z+uKNCH7gWPEcqpo4Ra76ON4jQZww5L99dcVpigfWr7PKpn2JsTCyTkSiLVAcK4o9OMbk8Mq+PLH0soljX66Fu4vNiBQhkzFyg8kwI8mMxvEiOQqH8h+t8MKA7az5tnzKsMc2t+x++htTa0ecuQod4LGxas08gVGX/HTf4Aqoezff21u7PkjdOqk+LDsLL3zNrJKHztuQfwdflJ/O3V7iDHT9+TmekJ3GHJTwDPIIr9tgXUQq+/ChZ0ZTGDrnFYLGsH1F4SZy8KGkUXjFjU9cHqlxxSn48vcFi8EoECbSMK6LztYd8eiX0QzRB9VW872EL+ncusFrX+oy5ZiCGipnTtQli4BWpsSlu5mEwG/FNwtBxaI3aSO3n2YGf3VI2CSF0GcTkSU+Tcd2sUaRtsgNUZ59n
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:51:44.9714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fb1f1f-b16a-4918-f939-08deba8eab0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

The veventq memory allocation happens inside the spinlock. Given its depth
is decided by the user space, this leaves a vulnerability, where userspace
can allocate large queues to exhaust atomic memory reserves.

Move the allocation outside the spinlock and use GFP_NOWAIT, which can fail
fast under memory pressure without dipping into the GFP_ATOMIC reserves or
direct-reclaiming from the threaded IRQ handler. On allocation failure,
queue the lost_events_header (so userspace learns of the drop) and return
-ENOMEM so the caller learns of the kernel-side memory pressure.

This is intentionally distinct from the queue-overflow path, which also
queues the lost_events_header but returns 0: a full queue is an expected
userspace-pacing condition rather than a kernel error.

A subsequent change will cap the upper bound of the veventq_depth.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/driver.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 61e6b02601d1a..3b8067976eac0 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -149,15 +149,18 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		goto out_unlock_veventqs;
 	}
 
-	spin_lock(&veventq->common.lock);
-	if (veventq->num_events == veventq->depth) {
+	/* Pre-allocate to avoid GFP_ATOMIC; use GFP_NOWAIT to avoid sleeping */
+	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_NOWAIT);
+	if (!vevent) {
+		spin_lock(&veventq->common.lock);
 		vevent = &veventq->lost_events_header;
+		rc = -ENOMEM;
 		goto out_set_header;
 	}
 
-	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_ATOMIC);
-	if (!vevent) {
-		rc = -ENOMEM;
+	spin_lock(&veventq->common.lock);
+	if (veventq->num_events == veventq->depth) {
+		kfree(vevent);
 		vevent = &veventq->lost_events_header;
 		goto out_set_header;
 	}
-- 
2.43.0

