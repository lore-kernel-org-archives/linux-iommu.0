Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C62FD586
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179061; cv=fail; b=GFs6i8qvmPQA71sMTkWe8VBfsp7YlJiCvSQYXvqeInfcQPFYr1bzi0MDdcob0oAaVPigF5wiNdJj6MG1YxFXlwVY8wNJHbr5vbckBCTFUl9Nd0c84KVe3FFB5Izyjgh1i+vPnVJ6fibCq6p7BOc5Ldda1YzwGlTqGWmEFmq6LHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179061; c=relaxed/simple;
	bh=29OGNIxe0px1aidYozlrPjJwtPxsR9yFHOkWt6oD18g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mQELBS5SY27LTxxJOCkXH8nnBnOXOh61O3QHD1s8Ww6q24QmK7kIvQkTE9dx8nsdKV7Ou8rUrj10k2p1A5QVndNTsXl0KebGHL5h3p0RpHqIxs2QJ4ZfQOugOwdkESoFNY2KeQiAgwIQnm+j6WGngKQ1XjlfnMOooJfgB2TDDyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=prJ9D6SU; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="prJ9D6SU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bS6V8lM96NgQENujSnVg6zRfF8NMBfEC9FMy1hpH2gsBdYxkDZb6vbAYs3KXPXTIOyiz6OiAcEqV7tEMN2pO4+FKZeRMfREmTET9dHMZS7s2AYuJmpC4/cmD+9WbcNofKN6bdNe7yVR1kRwAMJCPwgqVJ9JpDJevEwVkJ7IriMxCRyyAdoz3oYIEtdE3O+kmdMc754KDiWXU78J49sJGnlt9cpJCkFROwQJ1234QJe+PCJku9xbNQWRAlKaUsIa315SGxceERq82Ejf3G5rj6W4CfJdheg1CdBvJilsTE15j7BxEsqZb2fhdYegpFiLmTrQ4jFVNw8inxnMmVQVI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvmcJ6ox4F9BTUSGvyPFQ6wauFYpZaUNgHUzgFcyb0A=;
 b=CzWdMQuJY8YmYGrbo2Z2LBuOYQvQeJFq8BQwBLn6FyhcGCWLNg5mOxe00JxpOjdKVjHW1vy8RheOmE3oc55xGMx45QUhBAHr2CGJr5/eRKLYxB7k2h30kukX6PjtVEzyNldzhKcZm5xlSzFw9B8kWb5QAMQUtIg5jTYUoXgYKof4zRlhmhgfMvYmHxafetfh2doG3a0HdBecZPbd8qTXfBuinGzh9efvCKYP9wNBMMkgwFpJnha0B02f6V9dmgXLR+h/OPbEW5VHnjtQMS/SGknxbWbdRVjWQmTx3+iShR8V4LKdreUNVV4jegoxhVREd0814GsNi36YGDdB5erIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvmcJ6ox4F9BTUSGvyPFQ6wauFYpZaUNgHUzgFcyb0A=;
 b=prJ9D6SUlcPneRWSV82Z7+pMi7kB4d1fk4qoRoGwbyfOTjczlzc8PRDm6XBTrTz+ZrY3KOM6ICErk6Y0KuLDKLf4lIf+YcZwliq+BTRXdJIWXuNY/CHZ34qBxq6WfbKBWQEvnpxBBtqVKtdVUNre8mls/wPxTM+nEta1YGpa5onk5LiJNLnOzHMHu8hmF8v4iELJkDSdtyb702cQ509V0kwuqQpQIo76J8zsywduCtR8/HqniGjfVXHt97aIk0DspWIaQbE13ZFRAvc1LcDJDjrCkN7AUuOlng2VNMmSJ6VarOfl0FBpZt5sWkiQViT7BT9wduu56N2PDpaKYVm6GQ==
Received: from MW4PR03CA0286.namprd03.prod.outlook.com (2603:10b6:303:b5::21)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Thu, 10 Jul
 2025 20:24:14 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::24) by MW4PR03CA0286.outlook.office365.com
 (2603:10b6:303:b5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Thu,
 10 Jul 2025 20:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.1 via Frontend Transport; Thu, 10 Jul 2025 20:24:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 13:24:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 13:24:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 13:24:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <yilun.xu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] iommufd: Do not allow _iommufd_object_alloc_ucmd if abort op is set
Date: Thu, 10 Jul 2025 13:23:54 -0700
Message-ID: <20250710202354.1658511-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: eac4d5c0-601d-459c-cd3d-08ddbfefbccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FNeZ/OCBPn4ft/UMphycmGA1oVJjwGNUj9lbgwiIuTt+Rc8xMuFVAN/GTgB9?=
 =?us-ascii?Q?LRJn1S0opnacqJDUi/uAuPQ8OObkq+IfKgWc42gjJTLDPW9NFlRXTk8yTjpA?=
 =?us-ascii?Q?GdBbj+IZMAzwXPqXeNdS7G+8T1UDPdTxwi1U35NCgAs7jyNowl3tyKmifSLw?=
 =?us-ascii?Q?tRFvHGAJ+xn39eibek1AZVrv06dXtv59gQ8BuJhPQWhva4fx7i4enk+uvoOr?=
 =?us-ascii?Q?SBZTnz3X7ZT9LbADxot/mw3X+J7sJXp7wfys75fwlVjFAIVwKPi+MpTXzuXV?=
 =?us-ascii?Q?9rs5JCOT5EhXn5u5XIEl/lcojovEcGJ5Ildqx+IxDyD6f9BIncMZxwjjRJSj?=
 =?us-ascii?Q?Rs8NdJmRnUxaS6JcpQJfmPdfQR/Cf/82jmcSb1v2Mgg0uI+H51a9lG0qJyFo?=
 =?us-ascii?Q?2xqpBUAZAWo3eoycrOCo40VjRt75GUTmb6z05BdAYqK52XNk+qln39eeMtP6?=
 =?us-ascii?Q?1iaKk7cgQ8AzVskUc5f/dW3em4+u4ZhVkmHSZf3hhlyYZWZzm8Mx5jEQ2cmt?=
 =?us-ascii?Q?xuUWj9tPgEnkF+lGVa0tZclavw5oYZ6RlELIXSNjzeV+ozu2XV6RWxntVBqZ?=
 =?us-ascii?Q?Sw8WNeABk1gzmEku5SHu2ilqk+KsJkWxjPrxYUGxe0kjYaWJzGNY48YfoTrN?=
 =?us-ascii?Q?W49WFS1QnDr1Z6qwyGlS8afrRTAO28rFLLXetly88W3mccCfA5+VNBmUGLit?=
 =?us-ascii?Q?0mL5cnm53cgvPOWDLKc+Cwb46NN6biprobkDjDd3JISh6sBdyQsI2rnHGMTH?=
 =?us-ascii?Q?3+RBRogZ0ZGETN5944fZcW/zirpXgyoRaYup4Sbmwb48y+f3/tr7zNKoWV4Z?=
 =?us-ascii?Q?9AX9rjuKNC0oRTcGwwIZM0YKpgNk4lNyGY3RM6KJg8m7fEOgWKQY9Stj1Qp7?=
 =?us-ascii?Q?D/q5Pgyeoyu7pg/vmKR5CxSSl0bBetxWcUCViF0rI33Q1HESCuE2nXfyP9Zk?=
 =?us-ascii?Q?guZ6zccBtFBQlig5NRC9WqRXamEWmhTsfDGzQVcQobCioEPZrsJhh+K40qzk?=
 =?us-ascii?Q?nljeHrYc24c5GtI5rUKS+soMVECiT4rZJY4TMHvaOV+vnpUBNXkG+IKldvLu?=
 =?us-ascii?Q?4fxfcFafE3gXrS5S6OBxkgUCFb/OLtEp40IMkY//KqpJkFuIQOc2TUf91hmA?=
 =?us-ascii?Q?Wfdknqj2iefSjwprTfZnT8qZGCt3s91oCYBr3/dcE0cfBuG6FmtUu/H6qPyv?=
 =?us-ascii?Q?lGjbI7pNGEfrlyMDexF3aF7UMi75Gv2o0vetWdMqQ0NCVOmzZ7+m06FhlEgj?=
 =?us-ascii?Q?Njic7yQEqoyTIp1xvLrIMUU4W3q621WD2FQsY2EHctqwwWXu9oDdLOiUu9Ug?=
 =?us-ascii?Q?Q+sj6IiwYQr5M0F2CVENBtW4L649QQGj0ECW0g865ezBTAKPFQFkEvT5diu8?=
 =?us-ascii?Q?GdFR2FiTP8mp/yRvUW8tKjQGOyEX9/3Rozngqaxbv/2Uo/oseKxnj6X1RkT/?=
 =?us-ascii?Q?hS7ycijkVAaoA4ld/rlRwg35XIh6262OD3F95qsDK6g2AfJbYMUMrw3t+j+U?=
 =?us-ascii?Q?LJXxTOah+46Ti+2wohBOjbw67NxoSHSGCRRG?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 20:24:14.1730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac4d5c0-601d-459c-cd3d-08ddbfefbccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

An abort op was introduced to allow its caller to invoke it within a lock
in the caller's function. On the other hand, _iommufd_object_alloc_ucmd()
would invoke the abort op in iommufd_object_abort_and_destroy() that must
be outside the caller's lock. So, these two cannot work together.

Add a validation in the _iommufd_object_alloc_ucmd(). Pick -EOPNOTSUPP to
reject the function call, indicating that the object allocator is buggy.

Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 0fb81a905cb1..69c2195e77ca 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -71,6 +71,15 @@ struct iommufd_object *_iommufd_object_alloc_ucmd(struct iommufd_ucmd *ucmd,
 	if (WARN_ON(ucmd->new_obj))
 		return ERR_PTR(-EBUSY);
 
+	/*
+	 * An abort op means that its caller needs to invoke it within a lock in
+	 * the caller. So it doesn't work with _iommufd_object_alloc_ucmd() that
+	 * will invoke the abort op in iommufd_object_abort_and_destroy(), which
+	 * must be outside the caller's lock.
+	 */
+	if (WARN_ON(iommufd_object_ops[type].abort))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	new_obj = _iommufd_object_alloc(ucmd->ictx, size, type);
 	if (IS_ERR(new_obj))
 		return new_obj;
-- 
2.43.0

