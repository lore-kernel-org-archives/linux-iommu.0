Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400910788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2eW8Icf939KY1XoVsldjowVWfLAZniedjY+eTKeopkD6t9gXo89xCupF4Z3+K8jpZ7AqaNB13CFYrcRLLmM1D7xJghfWJE6dXa5hRyuXWzlq9UgDP40uEkW+h2qGYrrYeVIxuwnldxzRzPtzRr8z5qD2mymPy4NuXUHs7cCSeOscKIeD71aUKmj9okjU35tlRxCadJoMt9NomTydYSA9MOO9vtJalnj/cTOZvT6yEl8sEkCsq4kAuYYubounmN5EDSY4p1gNu3tnnuwoVycwfny6JUpsVjbpfK/we61GitkBHHFnesrPvwqY1iuY2U40lj4UQ4K1VY93I9X5Ptf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Neju6+uZsilHViP9NoEGy7hB+0B5DY15if7nYWJGQe0=;
 b=GFs5rch7RdRI7G7tfU0W8+L2d1/JKASOznNatZGE4OYt+BM96vEOZmKLaKUQorit2JcHHq8EwxO7U990iFwz/7OiedURlu+f/4fQ9yp2i6ZQeddpQJxyL+qmGsrOrkYoEdeYgithAoDlzwghTjRCkXT8QkUYFtRoLc384QgS8Eih1lT6hWK1d8bj6+fEzYqW+ndjD0KKwPHQCfKaqFEuQzVOYnttD4vM0Un+FujY12Rv6PC0Rsal2lpZPwtaZ97aMLjBpKa+hw1nUSiS24stg/gNcYYHKQloqnj1Mvu2YDATRWCIKjJOlwqnPpJUhDtMhP3+tqCcn6AWUGKi7rl0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Neju6+uZsilHViP9NoEGy7hB+0B5DY15if7nYWJGQe0=;
 b=efz4fSRXX62z4sopPbHZEw5VfbsNxmvEhdbobfigE9HLxmUFrrhSXvJcWskPjjSTQmKLrZMoyCoQFpyrvlF74/culGdDmv00RLIBBegVel/loDrOqGEu9osTve8NjN8fpCwYASULFHuQzKpRbde+w6f6c0tn3boV/xyhPHEU8p0=
Received: from MW4PR03CA0216.namprd03.prod.outlook.com (2603:10b6:303:b9::11)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 10:26:42 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::d9) by MW4PR03CA0216.outlook.office365.com
 (2603:10b6:303:b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 10:26:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:26:37 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 14/14] iommu/amd: Initialize iommu_device->max_pasids
Date: Tue, 15 Aug 2023 10:22:02 +0000
Message-ID: <20230815102202.565012-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 320a5682-8c23-4be0-ca2d-08db9d7a1d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1EVVTRhRTpzD87HpSbSICHPrmZ5DwkApBjIU6tmlqnoTD+QjiwWZo4szV8vARP/o9DPW7dOxXpBROl/39nwfaMGb1yIy30OSEUruzhiJ1qHNpRSiDRPo+Ehllsgla2JcHGDE61jM0YLsRmOcqXs7HP9cO1KVwssvNvmmswl5hr5Y/qmc6o/MfcNU9XvXqcY0nS+gyj66xBnsCQDsxhG/jIeRmvKDUZegNhlxIVBnJuBIBu23bRyZ0OxWg7BTOZ/0MAMj8MC9tiARWwTdJ3EgHXLpc0qt5uclxcKGMCotSvGSjHDMpfd2evwNI0+WqXkCP8Tgnipm2Wo7VUNs2WJkLBYolGjojA68Uzwo9Hp+Fd28HtmVJkfBQOoDymrWeRnX+dq55F2+7PuBkw0sh//pEw0YkEhfUn5HRpwKnA+FtMl6JGgTSbBnCu+HnDYH+NPPueRfJSWjOOVr/ubewQ4ufzSsCBgy2bjGO/o2O24FLD9lzT148N7Bsb7qDX5IaSG6HaxSqFjH6QvePRKxJyZpu+R+ycbYZMZBIomLF5mpROfrUmAz0S6A7qdrmXAVVNmSVGHGY/+etsfgfQP/mlYrhc1s7dJuvnNJrz3O/YeKGMGxOcOD4nzd1jI/dFSs5u7XbVCj7/qzcSwtwx6+mfGrNnLVw+7zF0sdfZ+W1x4xdf86no5oSu0u9syQfQv/D4MEq7rdwhM0NzjpZno1zIUZL3ZoGc8M/nQHhUNVakTe7KxHIHvXFhbNIwuBFxOiojh8cKVYsr9ZbkpUAlrh6AvKgQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(186006)(1800799006)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(83380400001)(63350400001)(426003)(36756003)(63370400001)(336012)(47076005)(36860700001)(86362001)(40480700001)(41300700001)(478600001)(356005)(81166007)(54906003)(70586007)(70206006)(316002)(8676002)(110136005)(5660300002)(4326008)(44832011)(82740400003)(8936002)(40460700003)(2616005)(1076003)(16526019)(26005)(7696005)(6666004)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:26:40.8372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 320a5682-8c23-4be0-ca2d-08db9d7a1d85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
introduced a variable struct iommu_device.max_pasids to track max
PASIDS supported by each IOMMU.

Let us initialize this field for AMD IOMMU. IOMMU core will use this value
to set max PASIDs per device (see __iommu_probe_device()).

Also remove unused global 'amd_iommu_max_pasid' variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ---
 drivers/iommu/amd/init.c            | 9 ++-------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1d001ca11fc1..a94a0a231b33 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -886,9 +886,6 @@ extern unsigned amd_iommu_aperture_order;
 /* allocation bitmap for domain ids */
 extern unsigned long *amd_iommu_pd_alloc_bitmap;
 
-/* Smallest max PASID supported by any IOMMU in the system */
-extern u32 amd_iommu_max_pasid;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e823e10e802d..b6b6e64960ce 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -185,8 +185,6 @@ static int amd_iommus_present;
 bool amd_iommu_np_cache __read_mostly;
 bool amd_iommu_iotlb_sup __read_mostly = true;
 
-u32 amd_iommu_max_pasid __read_mostly = ~0;
-
 static bool amd_iommu_pc_present __read_mostly;
 bool amdr_ivrs_remap_support __read_mostly;
 
@@ -2081,16 +2079,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	if (check_feature(FEATURE_GT)) {
 		int glxval;
-		u32 max_pasid;
 		u64 pasmax;
 
 		pasmax = amd_iommu_efr & FEATURE_PASID_MASK;
 		pasmax >>= FEATURE_PASID_SHIFT;
-		max_pasid  = (1 << (pasmax + 1)) - 1;
-
-		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
+		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
 
-		BUG_ON(amd_iommu_max_pasid & ~PASID_MASK);
+		BUG_ON(iommu->iommu.max_pasids & ~PASID_MASK);
 
 		glxval   = amd_iommu_efr & FEATURE_GLXVAL_MASK;
 		glxval >>= FEATURE_GLXVAL_SHIFT;
-- 
2.31.1

