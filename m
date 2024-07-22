Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F61EB56
	for <iommu@lists.linux.dev>; Mon, 22 Jul 2024 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649313; cv=fail; b=EpXxkXe5JAdPQ1/bPwPtNQLDCH4YckCq53ZGf3ZJMHlxSR+He+Gu8Mm7s0mAufV1wMiAZV8+DbfQ9VDXwdWVUVHy7xZaOoV7KEhp3Uf1Qk9CBMT2rgmNjMVviIbrKgBIJmbKeBRv6JMtu64rBSkTS4StRcp3iA76S6UlTK8XqmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649313; c=relaxed/simple;
	bh=vJZV18tfEtjeWGT7/2teOOJpHdA8GPG7hlFvxIvkyDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aquO9RC9cwe2jEQ2VRlSJwcDkpJ86GfRQA6T2+OtrQGB1kDrRBKH6czdqLdSiFWPVeI9sIplRmZPkKKaNmnTPjfKn87DyyulnTK0gHqAIDWzPqlr0um0NVnaG7K+d7ax4/6bo5+6th0QNbd7iAMYSVdvPImMnJhiEh9/efUZXU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZOdPSd5s; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZOdPSd5s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE2yX7x6Pglyjupu6sLrkMfLmg0GsgEvgLThvuGacGhteXtLhGxJFt1YiHtCXpuEDPOq0oiaWAyD1R1awNhqbW6N+/CPRxN8HgxpE/dMLqLH68l43KKEwluT6ppr03HvLu/cqJ/47f9mciJPDCGLm5T2lvNaxcJlV/EancQXCD3f+HoWPY1428YtNQ6Nw6jkPbVYV1re+Z703beeGTkbIwCtrwXu5s5RRwFfRMLYVFL7YAsIIBgcK3JPj81X8D0YuODWKQla9fC5g1uGeb0m+p3SH2hNDqGxjJwNHDWB9F3MbNmCFZ6mkVUxOuHFQ+uC0IOq33DAnbdo7kHR5NciYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laJd6WBC5g0eP/4cQRuqK4oDyFOs8MrY1NYNTijcngc=;
 b=VQoJLZpxLa2y90OdjwB/fvOjM17NTt43ZuAdt04tcIPQE4CwePsX2jfa+qzZSzeLuMorYfdKc1iIkjr+QxZgjnkUCf4gV53uX2AcVHFIDdob+vJY7lM06NieTKaVHLydhM/I0MD1Nia3zbUK9NZZWm08vSeTirj7oAiGXohfHhfl2NMkk5HFbx3oN8I5ELzQYnIIjVMP3mIMQdvRvZO4u30ZBXbgvqaTLOAuxVwgl9U99IJwGde7/7qgP2Gr88e5rz/cwDNNOTD/drbrsJMWJdtp0m2/dmcg1LSxJjBnw8IyU/LIvcnF9rQrn0c9gQnXgwIpHYI9lK5pNOvTxJzmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laJd6WBC5g0eP/4cQRuqK4oDyFOs8MrY1NYNTijcngc=;
 b=ZOdPSd5seHmcA65xbnYrHa6v4myMW6bdpbewXIWyuZTwhJRBjVqDU/F8F2ehRy9DRw+kztWUMVoYBOi6aOJ1Xvxm97Sw7OlNXoFpAnv6iolwvtaKd8CLONGGU607Y8fdZro8BenWZGxExoM96cNs8CZGof6J39FzyUNTxdSnfNU=
Received: from MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33) by
 BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 11:55:08 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:10c:cafe::62) by MN2PR01CA0020.outlook.office365.com
 (2603:10b6:208:10c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Mon, 22 Jul 2024 11:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 11:55:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 06:55:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH] iommu/amd: Add blocked domain support
Date: Mon, 22 Jul 2024 11:54:52 +0000
Message-ID: <20240722115452.5976-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 5957f2f7-ad00-4059-6796-08dcaa45225e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fSa8mbzjt9xNQTrdjZRseyz7gQC3xW3ddpYOcTeNKoAf5WEgY+5VPFS3YgKl?=
 =?us-ascii?Q?ZRUhtLs5qs/oNIUz/BkyKOkymcZBQcRDxkqlqr5RxqLkF8cRLRymLOuATQyS?=
 =?us-ascii?Q?XH4LmT9IZmWdzpta1L1oIQx6YXoEEaF4vwz5hXXPT7WueD295LJcurU2H8/A?=
 =?us-ascii?Q?RvG918vjW4FaD7bf9Mj9Out7AbD6SIzDNTXfU/SDfzZi1xV31zPGKLS0s1pF?=
 =?us-ascii?Q?A1vfsCIjQwp1ZpWL1gnM6rWDziMssiqFCqYQ2GljgJCxyv43tAVORV76TTg8?=
 =?us-ascii?Q?M8pgW88sEEDz67XyuYICfIHd7QFKjK/diSyH4q8QDhMV+/vG50sBzrw4HcFo?=
 =?us-ascii?Q?Qk6AeGKRPk1vr4KZkQlkxpv/PqQvzyDeai2NBSOppALuPgdnqIBzL74/zTdu?=
 =?us-ascii?Q?3UbFF8qC2HOqMFVJRbD8yCJ9rr8ocyaDuJmQ8NbfzhDqHAMxhy/+nAwKoKWy?=
 =?us-ascii?Q?PNR39z8a3fT7kxvd9P8mUhlOApcW0HZ1OaOZ2cIZaSqxVtqWaFIKqVjC3PdE?=
 =?us-ascii?Q?ZGxylF5xKijQUoMLQaCFR71y9g8zPHY4ZSj2+hxWIowOVYCmq60Jev40f5ZH?=
 =?us-ascii?Q?8l+GeYMx5wvxieogpaG1mm8JPwgwlHLB74j+In9473Vge0qNoTIuUOyH3/3G?=
 =?us-ascii?Q?N/eWP57imO8y+KQDq5ehlMpMtmexddKTWpP4w/b1pL/I0vo4F+vkr66VmG14?=
 =?us-ascii?Q?3VWlYwOedn2k2HqDDGRmGnU9coA4Q7Lhi82GjXW3XxAMMS5slujh1UrtQfpO?=
 =?us-ascii?Q?8CAoSiQf+4ihMcRG3CjllzEuyAyKEifwhSQvvwUjIsEeaIoe97QXB0KedU4W?=
 =?us-ascii?Q?sHsVYwmYqsdfElmNzKhjLtufgVVNmobYvje+iOUKR0zWtb4ww5K9so7Ia5SR?=
 =?us-ascii?Q?Z3vGYAgt4co5/DqD5Vt2bHD7r6AWmifubx1j7ImUTfvWAVcWoQCvjsV9yG8t?=
 =?us-ascii?Q?kSEobozpY7O4PCWIFseiwoQn1/rQaG93j/g/QFtIpmgStbv0nzSQ3Bmu2JeP?=
 =?us-ascii?Q?xmob7/vl2tbE2buOjV7/ZVQV6qqxTVnFi7FBOyD+ZqcSfgFj1Z4wuhdPSQn3?=
 =?us-ascii?Q?p4HuRNEqCeoRJ/dLk2M0fXFu39/FcNIk7Ptqy9IkPsJREh1LE65eYgXwKvUH?=
 =?us-ascii?Q?GlG5xi8omm/vVh3FgfzX6YijWYPfvV1J3zp9QkSjIeJAETAQ4kBdGoR9TYaU?=
 =?us-ascii?Q?L+uT/l2PJ0J6wai0jQ1aMKAQvx0vbvQu5EabLFDsHOLdmd5AMiNCi4YSsWB7?=
 =?us-ascii?Q?Zfev9UBKmTKumatzfWjH+PK6MxYnTglYgZjBQMJkvKArTkLNY7TkefFE1KeB?=
 =?us-ascii?Q?dd9/lLUkbXirYbhbkik0YOkeSEacnXXAHfRLS3lSABYBiQD2Y2VmDqzK7O6g?=
 =?us-ascii?Q?c0mj1lhiCXO9O8vOYbHM1BvgCzLM7+y3KQavURXKxjsDbbRj5S388kqiaywz?=
 =?us-ascii?Q?UunQeVDQmMxBHM/UkxGvwDgDOnEWUmaU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:55:08.5220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5957f2f7-ad00-4059-6796-08dcaa45225e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876

Create global blocked domain with attach device ops. It will clear the
DTE so that all DMA from device will be aborted.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b19e8c0f48fa..87c5385ce3f2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2462,6 +2462,29 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 	protection_domain_free(domain);
 }
 
+static int blocked_domain_attach_device(struct iommu_domain *domain,
+					struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (dev_data->domain)
+		detach_device(dev);
+
+	/* Clear DTE and flush the entry */
+	spin_lock(&dev_data->lock);
+	amd_iommu_dev_update_dte(dev_data, false);
+	spin_unlock(&dev_data->lock);
+
+	return 0;
+}
+
+static struct iommu_domain blocked_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev     = blocked_domain_attach_device,
+	}
+};
+
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
@@ -2859,6 +2882,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
+	.blocked_domain = &blocked_domain,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
-- 
2.31.1

