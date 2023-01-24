Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3D10F9
	for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 10:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd5XVrH5U0I3fDgyOxduLswE0Me+ucsX7oZQQ53OGhFpWbXMUZALUiLeToVlbEge3U8LhCUhQN64fx8cteCYxLNlcCJRsRRQ54dqlm1MEK90cDigkqJ5TmnGVhEgm5BhYEuK/YqI1Bn392ho3QGwh/KYR8FTS2cZN+s4gn6HRTgojZTrOlQnVqaOWb01ddop+i5QnS5y69XTMyRFkEqHos/Tjg2/TF9TZ/mJCAqwpKaElgmSevQM9P6ZjcwrDrQe0gVAYE0tSxe5yMsaIow+/mUFEg4aNNl0p5B8Y1spspWgQUA1m9SIjJh9TMm9wBfKaU5Kw3o0QPIEKD9XyaFN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0unSy1TzYrW7pzOkYl8u7spGpRTr1ktYO6oxYyQu28=;
 b=cKyHBMbFMxsbaLrFPqZceHCZWxukwWDAzyl2spR0zsaUjluH0HDgUwKilRIxLFOFgbuf0N0Seu+uulqbKDA9nLL3uNPSAEuvCqwGXILZuzsjzlR7RKM4BAExe+NOWaUU0IFCuS6+FUcAhhMCh+Z2V/nq4evDhJLpwCIYfGJDWQGwVljMYDCeJ6fd8oOm7v+2iYWf3E7XBFydXLyQcRks2RDEwQY+w2oYHsG/c4ArEQsMOo3ksQ/eMfuJ5hXdj6WFIGMyImbjwaMhNr685KbMDQVsOC5QetjYlkbKwZE6xr14OatN2moN0nUo8CWHggJgipkQ/QBagIWYy4LwrcFWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0unSy1TzYrW7pzOkYl8u7spGpRTr1ktYO6oxYyQu28=;
 b=yQ+UDFhDkimz20WHaONqk+CFBS3Tk+xi1belKb+vFeacM4K4C3Dmmc3dAxW9SlQIQ2b17XN1RPG8ANf4Cz8620zpWddDNAPSwBzF0JrgYupfx4sLa/8ZeQxswtwnW2Q/v+vSkGdDq28ziKv9vfyuduJ1+SVXyCCeewFBTJnEd0o=
Received: from DM6PR06CA0013.namprd06.prod.outlook.com (2603:10b6:5:120::26)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 10:45:30 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::38) by DM6PR06CA0013.outlook.office365.com
 (2603:10b6:5:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 10:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 10:45:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 04:45:26 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Daniel Marcovitch
	<dmarcovitch@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/3] iommu/amd/iommu_v2: Prevent scheduling new ppr notifier during unbind_pasid
Date: Tue, 24 Jan 2023 10:43:55 +0000
Message-ID: <20230124104355.119166-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 164f9762-4a0e-41e4-3f2c-08dafdf81c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+/7l1oBA5syx2aTOI1z/BVqsqpmR0u62RCfbDlmy+nHg3GPCmwDl9bg030jwYFzulckuEt9bwCueEp2pczNlH3MDUbZ4OMSYd92XIRgILGf5UjOtpVOU+AoW8iECxgyiOkg+q02xKBum7CegDjeJdjJi5aw/rNR4xZxcaU+BXfIHq3NzN92AipZmZ8+j8q2mgaTvYcYBMpCQFjcR3lHJ62FrwsPWIIlSSaPb0Av1PePaW3JFEqedc3bAPJVedxJDFlViyBtDeQRnvwUiK+0xwCbrwcefFXs/aSg+DBnHDqudfUPzpRE33Sohq9xT9rj52O0bL/U0XBnE2bNQIg5dyO1KlYC9Rqig7Z7Eh6emmI3g5sAC7hRMQveovlB+P+kihndZC5qhwp2RKPmFp9hUyboA78ORC2pjZJ5jJvHxMcQCdBdue3KjUkxkoidJd9w66Ovp3xhYhssr5024Tt/G9gKepA4n1dBt7qeXsWxdUmwOtUxbnN45T2j+4HJvYgbfceyDfxx3Vg/wsIwWbj/etNsbYGGXC1frjlbk/FFcElEkaHK7trg1fB0/r5I4eaa3agbWcYsjQ+DJFYKdbyVgFftlykCSjZGM47+Gukgqs8M/5hvCW2M0cd20ZnhAIGaHRN+9Cv0jrIfgiGBkootzUu4ZchofIRGIe7MYtoeIoK7yGt4YV//3Wi0hgFczHvd3adcIa++PiMWSdmyMzk+sGoFG/n5Bp1qxWdTsWgk3C/k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(1076003)(2616005)(356005)(81166007)(426003)(82740400003)(2906002)(82310400005)(8936002)(44832011)(336012)(66899015)(40460700003)(5660300002)(41300700001)(47076005)(4326008)(8676002)(86362001)(40480700001)(36756003)(6666004)(36860700001)(110136005)(316002)(70206006)(54906003)(70586007)(478600001)(83380400001)(26005)(16526019)(186003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 10:45:29.5089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 164f9762-4a0e-41e4-3f2c-08dafdf81c5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315

From: Daniel Marcovitch <dmarcovitch@nvidia.com>

The pasid state wait_queue / ref_count mechanism allows unbind_pasid to
wait for all outstanding ppr requests to be completed prior to freeing
pasid_state.

However, we are still missing a mechanism to prevent new ppr_notifier
being invoked after refcount has been decremented to 0, and prior to
pasid_state deallocation.

This can cause unallocated memory access.

Fixed by changing ref_count_inc to ref_count_inc_not_zero to ensure no
new ppr_handler starts after pasid has been unbound and NULL (invalid)
pasid_state is returned on zero.

Signed-off-by: Daniel Marcovitch <dmarcovitch@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 44fed4ca576f..264d9aa447c2 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -240,8 +240,13 @@ static struct pasid_state *get_pasid_state(struct device_state *dev_state,
 		goto out_unlock;
 
 	ret = *ptr;
-	if (ret)
-		refcount_inc(&ret->count);
+
+	/*
+	 * Since pasid_state creation sets initial count to 1,
+	 * a count of 0 indicates that unbind_pasid is in progress
+	 */
+	if (ret && !refcount_inc_not_zero(&ret->count))
+		ret = NULL;
 
 out_unlock:
 	spin_unlock_irqrestore(&dev_state->lock, flags);
-- 
2.31.1

