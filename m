Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D363186E59
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108506; cv=fail; b=SVq8JNM0wXQYvPj84Ccn+ysreDGtmY+aziZrmaLBdGzmNpvZxkCMFxTLxZ7EM1GzTzS6dB95+nzSrbtaChCHt0hlOzTFMcDaWnnXF0NDW7WcBn5LZl9WfOC32pQLEcwlKTmyEw6EqGmP/K46moTEXI/OfHbWXVjbqHF3wbbBOnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108506; c=relaxed/simple;
	bh=F5U4a9Gm5+FjGzHJ5FWWxy4ydMwW5rHVdBz2k4qw6tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLqG6yUR2gRJz/M+0vH+aZnnxfQ3fShhy+zbY6EMBlJEacq/GQJ2BXVUGcrW4xfRs4t8xFBRKpUN7B2wLrS1UACJi5h0ht0iBxOj8CgDIM7tBXxKDf2ufg5og2WTlFmgKwZjW3WAMAIyvPeGbJZ9B5TazT5wvXVB496oqarXYUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zoTeuGom; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zoTeuGom"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAWeInrg4BECNnseHU6yXNglSq6ks9K/I0s2wGtuIlMvTr5IBjGvZ5lIW0Hvyoxz5cC4RvAokBcTkQx66euscEVSRFLl73VXbs131ziD8SThTq3YPgdgxM6uG/n281WxktdBwUJnJqCe/tsVyUpZP25EJu1WJPBwnfhIWn202p8/qOVdLVqBjaxnmv5/GhsdsXeWZAFlEDjM//dJiQOxA4j2N83TAWZ9903VDy+1OGZaDz32gPfOFt+xJGyzbsZ6Fbr5EwhKNJChdbtA4vdpMFmsXtdkUKxrViaGzIps2jpso7ddi2/n16j3l0GJcweyLTGf2QvbPYCxX+y0il7uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PyqDhKQKr0dOwXnPLFIkXVSUCpNtcKuxGXnd20tQP8=;
 b=s5koRj1MiUKLzp2l0aNh57j/ugwn3b/8YuTBxwVVtLyOnxtN9QTQZbVbOZo5aT+0r79//izQOzP8KGqxj5xdq9tzyCQS6xzdfZoei1WbkS/AnKCI5Tz+hDxt089rf/PDUa6l5NyZhwHKIZsuxnKnD2UEuGqMDoRUf0gjzJSvFe8T0+awQ7rnAn72XKYPVnuBUTKk4JBGs5PaKyGwBNxH3Yr4bibM+t2Dh5XjqWkAft/7tmGBuPclRwQHmdgpNsB0EtHMqfvia28qCxsAIdliL2Cy7x47tNqeDtDssPXkeYXgcFviZPPQ7TAPN3C8kLJDumIWgA1zmiaj11Pa9SbyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PyqDhKQKr0dOwXnPLFIkXVSUCpNtcKuxGXnd20tQP8=;
 b=zoTeuGomY9wKXUmcZ6EhxTLXKaSt2WUsdwfZhMZ4O7gw/yN2dhRW90EW7SbOEDlPfUqQWIZb8nOFVh5vb3eVzWqdpfffRfbVtmNlpsmSvFrB0S44X80qs0n2ZJmti7uGcPgQvTcvjKbvLhL36QCRPDGgTANeRzEe8ycSWLMSc5s=
Received: from SJ0PR03CA0128.namprd03.prod.outlook.com (2603:10b6:a03:33c::13)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 09:41:38 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:33c:cafe::ad) by SJ0PR03CA0128.outlook.office365.com
 (2603:10b6:a03:33c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Mon, 28 Oct 2024 09:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Mon, 28 Oct 2024 09:41:37 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:41:33 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH v5 11/12] iommu: Put domain allocation in __iommu_group_alloc_blocking_domain()
Date: Mon, 28 Oct 2024 09:38:09 +0000
Message-ID: <20241028093810.5901-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028093810.5901-1-vasant.hegde@amd.com>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e87f5c-c496-412c-4110-08dcf734b835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RqxzLjqjhHk3/NwPEKUTp+hoiFcX0RMQBSyMqc1f6QdcYeQ3EhTo6TGbBC/b?=
 =?us-ascii?Q?md4c1sv8zpAQDjGNXWQgqjirKGKkARjTMnH0xaNoyZzdpw2o2Eyw4mNjBYHi?=
 =?us-ascii?Q?nlT9KKLzjm44kg0ezOTgKeCtNJ7V4C+WAhKDu9KFEmBVcgH9ed/nf9M7IAxn?=
 =?us-ascii?Q?0CJj5nUJTvJkEPIYW2bu7TeSIhTnk+ZFVl/CcSqlT05kS5GG5n6g/pQpUEsz?=
 =?us-ascii?Q?vShZhq5JAeY/UwuXGKl5rB/VWeABCj6LvYPhZgMVcO/2QJSGZM2C6Dt/Jvo0?=
 =?us-ascii?Q?IGDMvvHcCD12WzISAqjz3vq7QtTNJpjJpHAQoC7fSrDKMDwgsNrX1frMsNDD?=
 =?us-ascii?Q?QQlmINnn8JH3Hi7xaIJAcHbS05O8uUwcPLu1A0/e25wd+oZxBtgqU7GFDoPb?=
 =?us-ascii?Q?Fao5Z9vTji5hs66LaKyEPWgs6J4w106CCMMdfflg/J5e/ixy9Yltr4fM3Ncu?=
 =?us-ascii?Q?zEMXZX0fsF7QD26GQ82Rm/V4qUNLBgSuOnlKWesAdKv7Oy6XfQm8eTOvMdyJ?=
 =?us-ascii?Q?liFGk4F2a6/BrnLY/nWh+M/D9eetP/inHarggCboXWy8bDIARZODdwHe5Uji?=
 =?us-ascii?Q?VDsakOzsiPLjoH2bgrWfKlSdK7bsD/oOTiAq3L1PV5Hmvx0r80Yf7JpsQnd+?=
 =?us-ascii?Q?f72UhS10KTyv7T9z+hDT7b8b4PckOOhNzJRaFzwBJUc7NFup+KkXKcJii7rQ?=
 =?us-ascii?Q?4KXApnK1zd6UA6ivukIHyNlYFCK/DllvQ+gAmwFZ9n3PhFJOmDzb++juLj/t?=
 =?us-ascii?Q?oNTsC6cPYDANfsEwppnHdnWbyrGF584OzDu2jfHmZCjF2cQX1fSkIDC99h14?=
 =?us-ascii?Q?QxSs/oKWhoGV7YF8nB0bmHg6j83j1WVem3GkIzH5kp5jbWC0EKrHl5kdIT6q?=
 =?us-ascii?Q?iy8Q+NNulldOfKwsDOv8AM/KyBxNMenm89HUM61O+SbS7/1FzXAcUMpY12oM?=
 =?us-ascii?Q?poPEQxPK+7MvpnyfrVbx0n7LQbE4bl9lSyrDe2+54kuaEXXibWmnaN+a6RP4?=
 =?us-ascii?Q?lIoy4DvcxVFp/swTrRrqp1HIXCz5sRjhSUo3mgGxJasmGAVCGJ9dxfA3l4or?=
 =?us-ascii?Q?thUppDyzqixQrt91MAjuU5PvEZBCTGf3b7gg+7W/UfukyBBRZClApunSvleI?=
 =?us-ascii?Q?KKr6c2MBoG/8yHu6UdDZXSvltzR7n56sIF3GcLfUZGxD1ap0IePOW05feSnJ?=
 =?us-ascii?Q?m6+siwVWW07eUKYMN2FxEefeESA6WXMOk1z25NCfWkEA8lNzv51TO/c+ysyN?=
 =?us-ascii?Q?wcMvZ1taHjTnOUgoMZZlH+PmCquAzkB9wCUph9wdX4CYOzE+dTo2sMBt2yLH?=
 =?us-ascii?Q?KyqYvZ84h9QXcF2V4bU8Ev9FBpKcbNceuaE7DymSy9lrJu/pfUtb7Qmra+Th?=
 =?us-ascii?Q?/jqNvy6DGbjVWuUMmG9WuyxAILxzKM3p7EjRp4eRecebeJl33w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:41:37.8906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e87f5c-c496-412c-4110-08dcf734b835
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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

