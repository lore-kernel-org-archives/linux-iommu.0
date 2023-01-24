Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D510F9
	for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 10:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZoYtnUUJKwmDfJnn3LKsLDLNRV+WvF9LwMnlTfPniDtI4p4inn/4/da6wcjGcKiPNbpf3fgfrM/LR18zVLoEbiUddbOUfDMqsyc9DKj1N/5u4lqEceYfT4VuSLTjrbeAjMvdNz/Mp4pBnWiB4R7g7F9al56gro9A3RefifnyeWbKy9KkDawQeG/MzDEw1eWgIMB+izo2jpMAcQU3wrWciau6qK2XR082sO9OF4rIIIH7Pl20s16/lqxw9iey/pX8Efk6NKKrT44IrPtLdTojUfwEhWwCjCdrz3/A0CTakGmx6+eVsdyL3Uva4LvMIm9KRPJScZA1tr1PJDld/GZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o68nGvEVNHZ0/GRLMa7iBHbrWpePkMvU5H7KEn4Afgg=;
 b=gQnChq1Ke/z7GQf3J9P0I2SMckISX3A+As/gUleNV4HQwrS/KpZY/SJ5GK5qBnunnkyBAZ5PxYXTNTru7i8A+TMG8jCeJcOX+/XWYmtRtw8m5SvNcqONGlholX6XwHfIRKdW+O9W+qUtA4ddjCP2YN7ax//5PtGDeJy5Yh0G+0+1ywTzensQ8MbdUL9Y15jW4hS00vcRrSjCbm4qwBVnv3c7I1ngHPpbKLF9pqi/mszo52+DByqkv0yVt9be2/Nv9H+/gHypJ7YbHqZl4BETrMRWo47ypo6cN8IVl9FTL9k0sYeDxBI48OFSWWGp1NUer/IXbDOz/N1zbQH3DwfmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o68nGvEVNHZ0/GRLMa7iBHbrWpePkMvU5H7KEn4Afgg=;
 b=1gjoYEsu5DN3aRuG5gAeZIa219u7wVijgXc8K/5+iOodnJG7Q+kxIVvfQ0Enop8LTtnuzEqqdAJro2qbdd4kJMH+kpBsT26rEllwb4vYgidOzVTOKMOLVH1nFMKAgs+hztMtAP5jU5RWrPlkA7LWP0tTxkpaYvI1cm6PoXvzmIU=
Received: from DM6PR11CA0006.namprd11.prod.outlook.com (2603:10b6:5:190::19)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 10:44:59 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::82) by DM6PR11CA0006.outlook.office365.com
 (2603:10b6:5:190::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 10:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 10:44:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 04:44:55 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Daniel Marcovitch
	<dmarcovitch@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/3] iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind
Date: Tue, 24 Jan 2023 10:43:53 +0000
Message-ID: <20230124104355.119166-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124104355.119166-1-vasant.hegde@amd.com>
References: <20230124104355.119166-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b930982-09e8-43b6-4606-08dafdf809ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GJGmVBZneOZ8pZhrsM3UTCtwLUTXkAc//q0oGXA7bREB8RAfFAe1L9jxliKzL83XYO9RlhHfAGrmRLtaa7k2QAk7/+LKqwoN9YrWBD7PtxgNYq4UyTnu1fp9gkkfC0Y0B5QIi4gWLnGVQkkbUSYoeF9pbhQ6bK9tYrIAuCrABy4iR5QzjsD1YuijskmCW4wxI/1tO7q6GjWZ1QEYCsX6JOtt8m0MU2FwO8WMhVLUi4axwqQi5XnG1oESTAc6WxOhxK86+Au98iPIPIBbwnru4WEmWygWarr+ZXQcJRbmaOuESGuRZtdCNp8LxAaRbi9V4yxCpb1dkXO+AgVM41EmwsFOtbK68Dhwl4mshWGRoHmw6n1ZF7FqkvQp3Mdg6QtHmG6OPcOkdggKvwd5wI/HTL3L87RRu4qMz8S+fyqdv2PQQ7uosmuU3rlXoPTRVtf8QEflo058eUDH/ylxylUReFqzU+owdV9smoJMdh8FYtIB25zi9E81grBEVS9+pA8/B2HGIcWC9zaeSRf07QlKNohzsve4TxnU9HDIMJem0Ci2eMSundcspghsF4khcH7QVaD2pBGmIY26jFbZIjHHlfaKnI8Hjjc1LOBufid3ah/8Q13Mq4sYclFOvFTvcDyqHGBNosOrnENL29GGb4BEmyQTfzENUzNWtxsKboU9v67AiknXToEi9JMzY5qW/I4+witcFlQgI+HxZvmvLOXK1Cyhar+xn70rO75xea+P+YI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(82740400003)(2906002)(86362001)(356005)(44832011)(81166007)(5660300002)(8936002)(41300700001)(4326008)(82310400005)(186003)(40460700003)(40480700001)(16526019)(8676002)(26005)(316002)(47076005)(336012)(426003)(70586007)(70206006)(2616005)(54906003)(1076003)(478600001)(7696005)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 10:44:58.5630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b930982-09e8-43b6-4606-08dafdf809ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690

From: Daniel Marcovitch <dmarcovitch@nvidia.com>

When unbinding pasid - a race condition exists vs outstanding page faults.

To prevent this, the pasid_state object contains a refcount.
    * set to 1 on pasid bind
    * incremented on each ppr notification start
    * decremented on each ppr notification done
    * decremented on pasid unbind

Since refcount_dec assumes that refcount will never reach 0:
  the current implementation causes the following to be invoked on
  pasid unbind:
        REFCOUNT_WARN("decrement hit 0; leaking memory")

Fix this issue by changing refcount_dec to refcount_dec_and_test
to explicitly handle refcount=1.

Signed-off-by: Daniel Marcovitch <dmarcovitch@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 864e4ffb6aa9..858748baae0b 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -262,8 +262,8 @@ static void put_pasid_state(struct pasid_state *pasid_state)
 
 static void put_pasid_state_wait(struct pasid_state *pasid_state)
 {
-	refcount_dec(&pasid_state->count);
-	wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
+	if (!refcount_dec_and_test(&pasid_state->count))
+		wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
 	free_pasid_state(pasid_state);
 }
 
-- 
2.31.1

