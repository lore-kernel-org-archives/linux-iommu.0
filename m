Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F81746A
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 10:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0XLhMFBmi0sIHg0BMgnLVAWWNfGSxQgAXd6BQ0xkyzT9ghE23Q5qQz6p3H7GkaSpEyLB5HacII2/2h6mR4C+b8H4+oEUfZ5FWmecmSmLlyqqUX7UznvB4gRMJ0rh2K/0S8gy6qo3eMe1fJukUSVkH0/tTKCkU9VtGiKVj+xLow7nTkSFHujrzUs7DoxlTU0lx+rcgBdrJ8tpETizTo1Rvq5YFeK0tG4lEla+V6FmEbdh9YdowmIsAFfmzcvG/7Dqx4DX5RmtQbKBK0aaDs+3/6uluzE54fVLjwKoLCXpa1EiISwlbfuPPIODvRE1IVG9jnnbHC/MECbtH6b/6p2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy679PsGKRdgAaCm07/ByNB8RFd7Yujq/wr7apZd26s=;
 b=GMPYatuiBFmwb1HMcrWAR/9HekJRHyWpSgi0p7aaWHXmlsftCSGgG8iVb1FZj+BQ6ciuTq6w9Wz2jW55LKUjGf2KHGO7LmVcrLJXGcyqBqTsUMG/BYziAJWB5XJxzYW4NzX1tfILR8YP2zEfRee8/Zp3tA1fmMHiJcdY8PTvjRjqT8uEEs8JUK5CYSbOa5ZPNoJr7d35E7fAvHTgUlSHCBUASl/TqBXzquVZNbm6l1zlhf5NHBBr1Zy2Yoqf9Ige1UJl0N3SRmHb1Jf3aHI0qk8Xxzb+cpyaiLd4u5hbb2+v8ozfWTjyickWKrKMUF9MtlqlseAhl+k0jmsWtKrlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy679PsGKRdgAaCm07/ByNB8RFd7Yujq/wr7apZd26s=;
 b=slVVUN6lMMqXgy40wlTSumJ5qxh5AZbPoqF9oLGxIUPzhCdTTFt4z9LlFBeL2wHmBqvKd4OI5gBvEPVhOyrvUpl3qnYjX3DrSfAugTWQCQS87CboVoolYCCUI7crSVXx9VjO7mHXTAGu7fepxPSaGqyJFdB+q1RBBepcHSwKgcrgqTVJUj768yt0KNVWLogy1oP79tfnKs6MoDBAx3pliGCzqKy5h12qqydXFUJPVKaRgjybpKKsjtfghIJQcyx+gZfQbZCdgl4IyuGyP2bjeNccpzu+HvUCQxDDLDtsZZF3kO0g9XNxp5Ig4WTSGHShw0TuBfwf3aY/lmu5ZJ9mmg==
Received: from MN2PR22CA0024.namprd22.prod.outlook.com (2603:10b6:208:238::29)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 10:54:50 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::f0) by MN2PR22CA0024.outlook.office365.com
 (2603:10b6:208:238::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17 via Frontend Transport; Thu, 9 Mar 2023 10:54:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:39 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:38 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:38 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC: <eric.auger@redhat.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 07/14] iommu/arm-smmu-v3: Add STRTAB_STE_0_CFG_NESTED for 2-stage translation
Date: Thu, 9 Mar 2023 02:53:43 -0800
Message-ID: <cde4280f003613f01562df27c8d1b4bbbea8d915.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 3059bac4-fc4b-462c-cc6d-08db208cb4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kue/I/zPYOFUNsRCFVYTSRqIRXUz/Ww9zwHYpJS+lnMgHHFI5eAAFu3BbI1fGHPxqxUfD2PHi+Gl4VycREV4HBYaqU/zvc29M4ga3OqkM98WWqBFyEcTxwi4dfT7swbkbwTmbhI3YaXyEgCBH5Gtny/z9qdODMoBr09OLokGcUDJgi54ZFx+prv2i52KCzY2UMtkslOcRFtAjI139EqH+NtTa0rJxdwdVLmDn0wib0o2ZGE7ibfKVxZCBBCtx23m/EOkdZbpMz2zrRGJPcefcwNrUpAPhrNMnFy8QDY2fhUtPVgk64bZBeiue969orW0tRBQC6xIiuHjIv/x0Ypuh+uhPhm5HqZawNU2om8WepepOcoTUMGrLjIkKNZbA3YnoebSQ7p6N1KiNxmEHGdGS0sZqJxRF4tQTusT4jLHb2f2GiL6vdFBnwoRfNT7EQvvE2s3IzWg+g7nwLYtSibKqCUnH3l/7qgdTnW9Kd+R1P8JCeAON2kx2qvMpVmdcMCiKCrZ1OP/qsqtSvyTiqayPMvXzWP3tDTyt5kZ8StKbekkEZxer29SuO/5ku1tzD2+vM03CdCg96LvwJHU9C6i3JEnXAg1TqwW81N+wtY26ye5J0jCm9SzB0itDLz8x0a3yJC25KunTR8PwQDHrnyfz65gz1Q1g91Aikuxkm/OJMz/1d/sSklgGrTktunfRKPkM+8lgIlxh4inV8R7kEt7BGxfBw8+tSo7JM2LOPagf7ti7o1VTklh5KuTeaLZEviE
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(7636003)(2906002)(186003)(5660300002)(8936002)(36860700001)(41300700001)(7416002)(82740400003)(2616005)(26005)(86362001)(70206006)(70586007)(82310400005)(4326008)(6666004)(336012)(316002)(426003)(7696005)(110136005)(478600001)(8676002)(47076005)(36756003)(356005)(40480700001)(54906003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:49.9784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3059bac4-fc4b-462c-cc6d-08db208cb4aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966

From: Eric Auger <eric.auger@redhat.com>

The value of the STRTAB_STE_0_CFG field can be 0b111 as the configuration
for a 2-stage translation, meaning that both S1 and S2 are valid. Add it
and mark the ste_live accordingly.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 29e36448d23b..21d819979865 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1292,6 +1292,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			break;
 		case STRTAB_STE_0_CFG_S1_TRANS:
 		case STRTAB_STE_0_CFG_S2_TRANS:
+		case STRTAB_STE_0_CFG_NESTED:
 			ste_live = true;
 			break;
 		case STRTAB_STE_0_CFG_ABORT:
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 233bfc377267..1a93eeb993ea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -208,6 +208,7 @@
 #define STRTAB_STE_0_CFG_BYPASS		4
 #define STRTAB_STE_0_CFG_S1_TRANS	5
 #define STRTAB_STE_0_CFG_S2_TRANS	6
+#define STRTAB_STE_0_CFG_NESTED		7
 
 #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
 #define STRTAB_STE_0_S1FMT_LINEAR	0
-- 
2.39.2

