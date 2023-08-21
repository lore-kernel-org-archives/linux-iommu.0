Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707904C6A
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwgMWiQdSdnGed40YFxwXe3/zNcukXYv41HDVDEFWhDOVb9ixmFPZ+jbCcstV66Rvswj4gtx9ym3MWdmSEI7RQmwJ4p2tckogfBXFctcGt3snFinno01BlP76Wn3iaTTD3g/wlON4UPLzsBVldGU0lB2iX762CtAwrwYfNI7e/6zgAjybAj/apkAe4HQlu1721zXKmhtcwgt+u+RTiaR/tqzCJfE+stBqacXB+pxxM5qQYLFTQhj/sOjNStkaHgpg1/Sy246A4jDpGsc8ef2HQJTsAf3fNaU5T4wxKizDw5Ufd6SbzBMY3F6b9LXwr910H/Rvbw4cM6JEfCYKvZISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEej8FA9MnqE5fMcARGlCfPo07A6XZAd9Zf01NssLNs=;
 b=fj8v9xExPHobTydTeqTd9r60htMuicJoikucdWAo3wXlqNPmsKDUq15Gln9pkjnykdJ1RGatXP7KKy2EuhYWXBLccTUP0SLb74NAtfnYnYofWMEu1RmtAVGt+5+hYC7rO78Mo7mHKMi5g7KWhxges970ZZKWScUa2zAZvpG+nKQyinOeKmZmjNZWM4Tev9/x94qNOheCAe4hrNeqnlIsg2yj1pKw15v7Xdg46yO2gyb4hPl8/CCrsDPVEnfiK5tHTNa+F9jF+/oqbm0tdbXS6cAu+tT+ueljFaHqdgoItd8Bce0wUktN2vULtzmlwhMTyObu+Qi3rTBDROv4AqxaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEej8FA9MnqE5fMcARGlCfPo07A6XZAd9Zf01NssLNs=;
 b=gpAJzV36exBlhQJLYvGYesumF/W+zxWtyYNSib3qkTEgJwnMQ34yNELwsHVtTpnLbJmqHOiG/v6ed7MXQRwNPlcISPY3uThlxPjg5X53k3vAHbG28+/Lo7JnwNaOA6ET4qN8quaOu9IOKANC5mZvOHWGuhfv8IHYudZhEO9dFAM=
Received: from DM6PR04CA0020.namprd04.prod.outlook.com (2603:10b6:5:334::25)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 10:52:04 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::1b) by DM6PR04CA0020.outlook.office365.com
 (2603:10b6:5:334::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:52:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:51:56 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, Takashi Iwai <tiwai@suse.de>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 5/5] Revert "iommu: Fix false ownership failure on AMD systems with PASID activated"
Date: Mon, 21 Aug 2023 10:49:56 +0000
Message-ID: <20230821104956.707235-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104956.707235-1-vasant.hegde@amd.com>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a6310b-a9d1-4f20-795e-08dba234a788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BBADK33YA4UwxCV85SGoWLhBkh8SKl1eg3wS0iRwvEij2mFJha5nEQK29kXnqQuNrE4KNbqSQgpGUKweKAybQeftZriVX3su4qRlnPL4Muf273aF+uKPp6Kp/qaFIGQwKvjQbbQkK1FgOfwORLgfY9C/0+JU/OoB+X2pEk+duKiqQynESamR8ZMII5uALJIo6cOQ4gg1HrBiSuz9X7YC+pTcZIYdEsAUxky7krior8ZipEHip+luGWiWPqZDw8AgMXUIMbxKQ/oRJr3i0KKaSNkX5Bbkx/mUZx0mPmDP5VYigS4qLPW8k/rfSiK3PIEt4bWy06snYxPnfe3xW+A9sf1sFBJLzSCii4QPrPKmJqgpmtcyhtTZCdysen7AQv/dbiKXDxPtqEVQ0D50zgGTHAZlDVC9Pdo7sprj3xHSWow20XT20c3w+4vdDkZi3YIb4tZFq9bbGXl1qaza4NZmZWF+X7v5QxeELJN+yKfHDMcL85sTOuUsx4AIWD21y0hVtPQIw/G+3wohsOAPnkplyGlbf3SFEEugSCRrxw6UYMe9b5HNjS1qW031Bi2Bn/yyggaUX1AE2xqK49B8CVHB+m2fKw6AYyFJyw7i5/jhSWpxzKVLgrtoHZp1l19FSEz8p2OD53jSmXTyHlIgaVxwrVspM1qdVmrtQ1k64O68V+i/AtM2TgOY5ORwsOlDGgBrlGVOUP/LgdvHufoeaCyXszphoMxpFkZqekMTlDrLCdg4lFuIW2WCLaXIEwdJFCic4uwr+jSPm6puD33XYcHtNg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(36860700001)(1076003)(426003)(336012)(26005)(7696005)(16526019)(47076005)(83380400001)(2616005)(8936002)(5660300002)(44832011)(8676002)(4326008)(2906002)(54906003)(478600001)(110136005)(41300700001)(70586007)(316002)(70206006)(81166007)(82740400003)(40480700001)(86362001)(36756003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:52:03.4389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a6310b-a9d1-4f20-795e-08dba234a788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

This reverts commit 2380f1e8195ef612deea1dc7a3d611c5d2b9b56a.

Previous patch deprecated AMD iommu_v2 module. Hence its safe to
revert this workaround.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 25d7327e8013..d9e5cf692d5d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3062,24 +3062,6 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	return ret ?: count;
 }
 
-static bool iommu_is_default_domain(struct iommu_group *group)
-{
-	if (group->domain == group->default_domain)
-		return true;
-
-	/*
-	 * If the default domain was set to identity and it is still an identity
-	 * domain then we consider this a pass. This happens because of
-	 * amd_iommu_init_device() replacing the default idenytity domain with an
-	 * identity domain that has a different configuration for AMDGPU.
-	 */
-	if (group->default_domain &&
-	    group->default_domain->type == IOMMU_DOMAIN_IDENTITY &&
-	    group->domain && group->domain->type == IOMMU_DOMAIN_IDENTITY)
-		return true;
-	return false;
-}
-
 /**
  * iommu_device_use_default_domain() - Device driver wants to handle device
  *                                     DMA through the kernel DMA API.
@@ -3099,7 +3081,7 @@ int iommu_device_use_default_domain(struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
-		if (group->owner || !iommu_is_default_domain(group) ||
+		if (group->domain != group->default_domain || group->owner ||
 		    !xa_empty(&group->pasid_array)) {
 			ret = -EBUSY;
 			goto unlock_out;
-- 
2.31.1

