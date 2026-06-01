Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CC3FB7F1
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346607; cv=fail; b=ajAFkYMUvuayzhtz6D3BByRZuGH2GnguT7Xi0/fl9evy2jej5ZzaS8z3h8JG0S5pw4p7NsgZ1pF99Ol+3xW9AhXJUG/N9iVZb9i9BJNRtdiysxIpej586mqIbDVcNMDR8fK8cCIy6/qj0FMzodpFxkkahkBoh16b+Um+gjNmk/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346607; c=relaxed/simple;
	bh=9PRksLTSsRtdwUuPTFPhO8pgdTnYXQSMM8MqU1Ci9uU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCxiT0y7ZABXOjoe/7kH+ruPSm6c8E+/c3s2H7mwXkCiGkBL50VQrk0FCYld/fKiLjHNEsMY9gNLLX+iKmbptoZ9eMIu25fxpws/lZnuHPHWQ+HnsCfywRUIDmS/BwBkmO5sATvPIYtD2aTCLTecQQrHtXRX+jc5yrEhfgGwGSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gra2yyVg; arc=fail smtp.client-ip=52.101.61.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gra2yyVg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlIrBAP8jOSAhaRLhLYQBMOFRKhNTSLaCtjhLsunkhg24LO5ITfROjuPOkZDfnPnHCQbnarqBpflxUc2oGtk4j98AOua6SbCAKOypu+8hmx+5g/1Wjpu1sXF5q14j03q/GDWw+/fb/5vnU35g3JxmY1eT6yWzy2BVAWaxxfvujoFIC4T01QQqp0M8U2bP+31FoXLwgl7EchHdy+8QpjKJBB8GONKjxGyqh43326U4jPT0m3H8IUvLsO0UkcirHcN0pmu+CVuxHCGCSfjX3QGLggzgffU1jbr2t8GUivlRSFaJ3IRQriC7xkDeGWBHvZaxLluq3CKNFSzHFjOAkzMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSmiSbUJWbMx2WN4bWiju1To11zMSW66yeEf+WXlsII=;
 b=rn2aWRaGQVIeFPRgZR61WC+qWjEQufUepbp5NHc7eakTa/cpS4R/nTsLF0CftmqjtESAMbgAtJd7n1P9J/RSEqQSDW2t7AUaWZbVOnFXuHSuisd/H5jDoA9c8IhtxlQsx/hAQxEMp2PwJ1HvaN2Qi+By4QrvI5pAehboqvTxn1r1soCE4Ooat8FdH89jsKR+DQV1HNoeW4HSs6Z4AnFM50KDqFGzIu70H8OZOvf7n6NCUWCevGmQx73/GgEJkzFxVJmZ1MMYk45KrURiHzCP9eaIV8BULvUNoIoDEx/PIMmkaKm8UpkfNxuuEUmYpSyDJGbcCbQ8JvPOhGp6I1xSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSmiSbUJWbMx2WN4bWiju1To11zMSW66yeEf+WXlsII=;
 b=Gra2yyVgMCeJROQPu+lRUN+wLxDDXFfVnLMmS5hnH4X8RUpB7d+HTpRkYTpT+/G5WCoyPsn/1j/kn+GJn7CZZnh8z13ah8/w0ROOwBK7FvdK31t4OeotHf2SK+CAKtPkjQQbct9XrMRatYZ3fccgyyngORjwEqBiF9rXroxK8SQ53bjkffXw7cXf6jrHBkicDq2lbHORnZon9tNWFPTkQHiqQQfe28R0BzKy5dYuofXsmuVHltq/tg5e5b9rA4W+SpJjKXJ8qdu25numOpzNWrdwOGXBeJQXrCyUaoSp1IX0Rsen29c+ZArHt353jRJAof/QPrUcH/RMmZpgnTtn6g==
Received: from CH2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:610:50::32)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 20:43:20 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::aa) by CH2PR16CA0022.outlook.office365.com
 (2603:10b6:610:50::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 20:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:43:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 13:42:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 7/7] iommufd/selftest: Cover invalid read counts on vEVENTQ FD
Date: Mon, 1 Jun 2026 13:42:38 -0700
Message-ID: <7bcd153d306f2cf04c094c728c0ebe146855072a.1780343944.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780343944.git.nicolinc@nvidia.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b30c1d9-b2fd-488e-59d9-08dec01e6ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	wUrnrPTr8iN9+DczT3YaAX9cqyLNYR6BMxjopF/aMIsvu5q816AUqNmM5Sa7yOqalfh7MGCymcO3/FyjAmjzDasGrVqEXYUP+723yZ6wb2Wf8VdRy17I9h749f46u4NaZuuA1yb1F+ELtD9MZFbct6BYePw34QKUH1SRc8EK6zJjTHv3kASp85CRid3whbH6OvuMVxo9OI3mrZRski1USwxc8UcJuxRkWCC5zXWGDNABTcGTvF2P6zzuBTb0efEzvyqgxzvcDOOVe75B0dGYAVeYYkbDIyTpU4Xmzzlbl54ptEiAgrRLFVyXezm7/FxngFYlLDtm7GXPNwB8qJJx2LvnJe86KGqkIqaphio/0Bzft52VhkYcR5Bzv7AJbZk9RB0dR4/HlYXNap2y4H8qlNnNfxOx1aJhewjt1RjzcuRqXRm+d8saWLy34jRIDH6l57rddM8mtZhFF7YJp5koohACBRd+7m1e1Jzm1n+Sa5dNgo6mM7M5BSAzu2lByLnm+zkkJGvhnWt0Fgjy5+zQA8NxQlm90phr/aqgs8T/1YeFWxnpmvyGK8oA4BvVz86aI04U5TWq/0J28sxs3+WpTeYgCflU5fUuZ1+Q6XZYcWplYU/WCkUvg8wpLaxb2VOO6kDXj+MmQQJNDL+1ExFhfiO/+eVRhmt6jSh/MAfAyYgS6aVbSZkDeM30/gwAFYG0hMUsPJZQ4leYeHlRQObz3j4ACpmdyspBELEHFvDTVxY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IK5aXMWL5nSVF4pLUdM4b2VQUhcFXMSXAbitl1y+oLoZTniZMQFLyt5O6cwKEhMKbJtdzDOljMs0mou7oVYOt/Uu5L1IJx3mJzs6qdJVASHZ2eXHesRkJ8s81ywU2OuyDl2eXRBq3gWMR/dWKHwLLL8z8kuBY6T/FDIr7CZhlQMcBXJrKIeKbgoQX17mZUqQOXmfTPiIM7a4P/JvQBDEL0Uc4puLJKEYqgDEAMJsazJlVS+Pb01dL1yNB1nea6bhCAQ3JXYTSrVlYADZwpVSYt2J6010Io8ocyvkhLIj1Iig+ShwVi1u3nfyIDf0G5SfVdw0OrJ8O+rVMjII1LspXpWCVA3N/66n/rVGvKQQhw2heCQ25b/eRNjVFLwFOyufP1rC2vqZHFimBRNK2OzQKWdGjd7uIxr2ZWI7VZpMd+ybOr2pVnkTtN2e173AvlFq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:43:20.5545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b30c1d9-b2fd-488e-59d9-08dec01e6ad4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621

The vEVENTQ file descriptor must reject reads whose buffer cannot hold
even one event record. Add selftest coverage that exercises both the
empty-queue path (the upfront size check) and the non-empty path (the
in-loop check that fires only after an event is fetched).

For iommufd_veventq_fops_read():
 - count == 0 and count < sizeof(header) on an empty vEVENTQ both
   return -EINVAL.
 - count == 0 and count == sizeof(header) on a non-empty vEVENTQ
   (event has trailing payload) both return -EINVAL.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 2e8a27dab0bb8..8d32b2f70beae 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2980,6 +2980,8 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 	uint32_t veventq_id;
 	uint32_t veventq_fd;
 	int prev_seq = -1;
+	size_t hdr_size = sizeof(struct iommufd_vevent_header);
+	char vbuf[64];
 
 	if (dev_id) {
 		/* Must allocate vdevice before attaching to a nested hwpt */
@@ -3006,11 +3008,26 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 		test_err_veventq_alloc(EEXIST, viommu_id,
 				       IOMMU_VEVENTQ_TYPE_SELFTEST, 2, NULL,
 				       NULL);
+
+		/* Invalid read counts on an empty vEVENTQ */
+		ASSERT_EQ(-1, read(veventq_fd, vbuf, 0));
+		ASSERT_EQ(EINVAL, errno);
+		ASSERT_EQ(-1, read(veventq_fd, vbuf, hdr_size - 1));
+		ASSERT_EQ(EINVAL, errno);
+
 		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
 		test_cmd_mock_domain_replace(self->stdev_id,
 					     self->nested_hwpt_id);
 		test_cmd_trigger_vevents(dev_id, 1);
+
+		/* Invalid read counts on a non-empty vEVENTQ */
+		ASSERT_EQ(-1, read(veventq_fd, vbuf, 0));
+		ASSERT_EQ(EINVAL, errno);
+		/* header fits but the event's payload doesn't */
+		ASSERT_EQ(-1, read(veventq_fd, vbuf, hdr_size));
+		ASSERT_EQ(EINVAL, errno);
+
 		test_cmd_read_vevents(veventq_fd, 1, 0x99, &prev_seq);
 		test_err_vdevice_alloc(EEXIST, viommu_id, dev_id, 0x99,
 				       &vdev_id);
-- 
2.43.0

