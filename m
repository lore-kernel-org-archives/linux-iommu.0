Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681337E310
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734392; cv=fail; b=FxCvrIAquDcAtmPmygaIsuSMb28ulIrnCHBDtuocwrB51uJFiwm4ZjnRl+Ek0QBiab5CP8QYqksUtbOnaGthB+qC9oaSDAiTMPN3Dnx2tZ8AQxh/srXk4gWEcmAkftXcXctgcxg+XiT/W4CDj9yTvElrxEsxKUlqxsLO+prUgRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734392; c=relaxed/simple;
	bh=kRk85MxcPEAORIDdbxmHPCHoBAvSAL5AKo4T6IbzdZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfdJTEvHLWFveuB8bdEp6841KtQjsF9V9ALoneCiRrhC7PL6Y6BnvXRj4izIDctT0NR55+VeY03qGWT7EH3yFwFIqGzfwEo3dPKYZwQQS/ISbKs6k0PHrImG86Yj98pGQuA5Q23B2B8zZnQh7vm7Dk+H7kM8XxftS7+V2JjbDlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M/Rue5F4; arc=fail smtp.client-ip=52.101.48.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M/Rue5F4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvQTSmtQWMn9IJmnQhaiejtkypU+z/EB3S5eRzg25S1jRG/SAdgmqG4+TQM5rO94RawT9/6PEtlCHH241jTAK54dTJkZ+YAI7RzyE3R4G8JX5MKkE9WT0KilA6md2hRzHvB2T2d9kHFDvbELDzsbXPdvV8jiS2A3+nG3zSgjcuReFsmlbVBd52WK9gfgvVYeSimBrjWdEamhSyF2poakUlMhIHpqqw6acmoJluHon2e2ncImXoJ/qzJkhYc8zU088Yt2OfKXjut1Ua9GzWB70Wp5gTzzOsYZbgBcxmLcP4Aq6LidwVumHsN+azOVHi2e0PqLdU629GDXlhR0N18P6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM38idNKQ/eB4qkXYpbNTY+EKm/TuCFi5lgZaJuVGTA=;
 b=wqtmdKcHBBcNWLTxNHc5D9g1rg0ZwkVwU5EMAf+bFhpXPJIZGMFDL0eskcjK+GcioJn9vfMrQmwNwFn1BQyAEXDrmOmjsTh/Kn2e835guwiIYdb1DD0Eu1Zpfu/K+4CBpWUPb4ZgtRripoTgKPOk+8Mu5KQ/97q3sWN21mdnQ0fuMbCv2i7OwQf+Xy9SNyC7uP9XNiRpdUZjVAmP7OcE8Ekj3wzO/+OAsNC+pKdcE76SALD5aVyg4+haav+u9IJiB174yJ0XrWerzdzN+7ZBv4PzE8BcOat8pr3nrbPa+5MK1RfZC8QyHtbAY2uQ67r6lkUDhOyv68JuLJEcRmGj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM38idNKQ/eB4qkXYpbNTY+EKm/TuCFi5lgZaJuVGTA=;
 b=M/Rue5F4uwp5yyNH1yoE5mQgs27mF7RlwzWS7Wtd+WusaC9pm3sNx5I/+r7+TipnOiqM8tzFVNvRVzwQ4VE1FQgRVMjEyYAKd/iPGvmPXH4odOTQkppkGngTji1eW98MiMawm48hygmGK15Z5FP7y41uo1qMet/Cqw3P2n3N0dIpNJUVbFdsFpTH1n6Q5KU4mEZETSpP+42RQuXRa2J3fy6jsjJv/ZsgkMxvLztN1vhciYZ/tV9aP/1hH02L3Pemoqxbp/OYtbHuxtPPwuIccrkq20yw8qVwCbe6iEucnOsmGyhvmWjuEfKEqWrPRrnZi00NkEuW5rWXpDN729LHeg==
Received: from SJ0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:a03:39c::19)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 07:59:47 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6e) by SJ0PR03CA0344.outlook.office365.com
 (2603:10b6:a03:39c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 07:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 07:59:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 00:59:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jpb@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <catalin.marinas@arm.com>,
	<praan@google.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<xueshuai@linux.alibaba.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <mshavit@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>
Subject: [PATCH v13 2/8] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
Date: Tue, 17 Mar 2026 00:59:17 -0700
Message-ID: <691686424f35e47bf1ff3f8adbcc0639341c327c.1773733797.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773733797.git.nicolinc@nvidia.com>
References: <cover.1773733797.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d35ec99-3df7-40af-dc12-08de83fb2836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fkElzNkrLBK18uhySNuUaS5hJbHRKy0CjAXNweU5iJ9k8m7YR4gGTNkstxI8SWmWbsoT86B6Qee9QHmTWAJ/NxHY8iSXKdmd8fBOLYWeWWQPpaup9C+iAJqStDLt7gv1rPdYVoU8JA4+e3NKpRbT6tp2LLMRhRRBaVxyBGxDWx2HEYvsWylB9wxHzon7NbqTsFbQ4YLBmcou3rHOMqJLrOpHQSBi8OMCKFznAzXbzlNhbzsDMYGvSCn40omOIzn8DQdkPWP1Vli+GRa2j/LFjLw+V+u9WYZth5w+Y812GjjvOwydkWVQzQKzuYTQJlv6bnMJ29LKDgUzcwvaylHkW1dxDm0W4jFvX8hpxUDdPzZiUv9DwuB8a842RhYjdUsiIKHg2zbNzGUkfjJHG8F306447ZA31GF4lS+Pi2IavcHjgq0cU55VhFCSb8xVR4EFU4qxlcfCKIWHd2SFLT1NcKuoWvJSzL+Cw9F5UqI9K2Q0fnwF2RFNyrHO/p2YmVNKht530OHZFd+YXN8GTKe5Z9W6wlVcQGZwmfKTb5zZ0hSeSoU+BSme+sNzJbVaEPl0gRPriBsYxQJ9pmOEBKjcObvb1peawXH9NTEA6/lfMTN8y1fjsa5Ri8kasENSRA8GUdrtX0bPsHRurVxGYDY3L+35Z/rEr8GEE2nNDRzw/oYnANXNvy5b3Vrt0OcsN0lhRYQ+py3VyGKce3N6efNCFAcyw61mrgWQDvvM0wJJvZmrsKuRWXHjJM/9T/jchn67JnaqSOchNmJoiSC4WjubvA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	alyDjt8+lhBU/JfWjVzEfL679jfYl508vGVYp0No6TWVr/IYkDFUBT3cNwPVUHCgHslylf38cC1DGpy/7og+sD4ZuHu7GikaIsHHQyehylAEXfjxssk+Bqjdfqw7pQ1usT3IFkTQBvymSsLTIEhM4JcgScnHurqznzDeb/R8TameCRy3OwswiWQJ4rol+3uZuJYbkp1TXtfhtQflCskxmiZb21VCGEMeXROsmm58EoCkeUuEdqNS+QaNh6jmAwUwoHgv82ImAX3bYVxWE9+iTjst8NIjC3MsLpC8asn8Jd6SF9ru2Wv4DhyHyuRmKMtXII5APnhVkv/0yTAqsFWEk2KOUs2I3YaQ2olXRqugrAqHpq9nlUBX+TjXGQ7TM0PwpgLCMxCPHzZ4N2qqQgwykb31YQ3dyEI8hL5ELyPlgYeFQ0CiOoHQtF2usYFi/roH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:59:46.7519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d35ec99-3df7-40af-dc12-08de83fb2836
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036

Both the ARM_SMMU_DOMAIN_S1 case and the SVA case use ASID, requiring ASID
based invalidation commands to flush the TLB.

Define an ARM_SMMU_DOMAIN_SVA to make the SVA case clear to share the same
path with the ARM_SMMU_DOMAIN_S1 case, which will be a part of the routine
to build a new per-domain invalidation array.

There is no function change.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3c6d65d36164f..24894b1630045 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -856,6 +856,7 @@ struct arm_smmu_master {
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
+	ARM_SMMU_DOMAIN_SVA,
 };
 
 struct arm_smmu_domain {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 59a480974d80f..6097f1f540d87 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -346,6 +346,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	 * ARM_SMMU_FEAT_RANGE_INV is present
 	 */
 	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
+	smmu_domain->stage = ARM_SMMU_DOMAIN_SVA;
 	smmu_domain->smmu = smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 606abe051e68b..117979c96b762 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3132,6 +3132,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		arm_smmu_install_ste_for_dev(master, &target);
 		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
 		break;
+	default:
+		WARN_ON(true);
+		break;
 	}
 
 	arm_smmu_attach_commit(&state);
-- 
2.43.0

