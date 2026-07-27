Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB52D94B0
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159072; cv=fail; b=bfFnfI6wvDKjBNgv+qL3Fy9rTxdTNmCL5DSchjbS8fUbg7KgJ28zHI4W8/IS70QZ1VCHMuD9PrHM5lYXQS1UZ81vLhcFYFZFZ15U5BW8GfwJuguQNPndOja8ReP5sp+xU5dxwt/NVyvR/ibP+4It2JvfcaSkp7DVfXbaKIHKvog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159072; c=relaxed/simple;
	bh=9OAFfje9yEJeUo3GV9hKdvBnh6PvfuSpzGj3nbnCsSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIh+ZeFAIJsY5PwS4VCxI19gmG8SqtoovibCfj+YrQ84QE0nCwYkYtXwlGC+PK+XNw2BrGLGkgk7yy2ZsibtaqNgbqA98obxzPWciX26RYHjSJVPKuaPJzae+CY1vFqcJHoWj7oWuhxbiUJpoGmia+RRWJV64Q2aOvdaV5a1G/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CArcV4k1; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CArcV4k1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLXvxVVeYCbvcKCxDeQMUDrwKKWDcgLMjjm+mVsMq4Hf1S4MBAGcpaNkjaGff9PwDxVSklqsHvUdILhgoBnSAG5RLxcJ/eDwFxheYF41PRg+n43R5JcsHdDBCUsJjXtnfSqxnChhUidLPqYeil2/NlasL4q46G1/bpLhaHkmKar3Mo5fdz77RvfyVhV3jDQ22hqGWtUbU15+reeRdOYO16DXp0mIf/CPK/hAKkLr1lIGYNonpUJcJw2FP5v4/gjEb4OlKdnSyqcr0WOE5o2OdfOuXwd9OtJaBFyi+frLI6JXo3sAcjjPC/t17Mm4d3jlPokp0i5QdLefwEnSv/G/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlJ8YJ1v6Wt03GLDO7gL4JXIRqw7KqNgWs6GsrGvpsc=;
 b=vOXxo2TKXdBXacn6QeOyrHkd8GCLgso0oJVm8x0u9E7KeSvC/f5GVB8Xt2WZKXzen4Y2z0/zwkNXoksCrJDCKxTxyJYgLYFpeEVbATU6CYtogG+5f+p5sEJrrX8emJ76tsZBEl7OwhAdxZu47XF/hbwb3TiE6KgryrTqihM38n8cwaRLIxBf7kEGB/XJKDVhB7QvVxLVZdQnMTLwv9rgJzEaY7qToXZOKHxPdEfOiIBP0gqLKlg93MOd9u9jOE8YdgKtcy+/lZ4Ye0JO6+As/kTtXb4py0II0K+er7y7ErPiMM4N44lzYms8HZya2nHlWUk8LGFR8QmxyH+iiJWxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlJ8YJ1v6Wt03GLDO7gL4JXIRqw7KqNgWs6GsrGvpsc=;
 b=CArcV4k11nCDTkTU309aJu8woKLbwOZ/rMvqWxzDiLQXu4TgztxT4d+2IXJwMeYMJnrMIa/MpiR8tAKSJuQxLXML5KN13y9Qt6umgfqUVbAadM9+VYtwhjfqxB/5dzc6c+/jPMm5QIKr8LEa7Jze/gBsRoqHJom9+NUHwcGeln4=
Received: from PH8PR02CA0030.namprd02.prod.outlook.com (2603:10b6:510:2da::34)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:05 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::35) by PH8PR02CA0030.outlook.office365.com
 (2603:10b6:510:2da::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:05 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:30:59 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 11/24] iommu/amd: Export amd_iommu_alloc_dev_data() helper
Date: Mon, 27 Jul 2026 13:29:00 +0000
Message-ID: <20260727132913.22475-12-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8ccacd-1464-4336-1f4a-08deebe34f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|36860700016|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	XHDqxT97cRw7cSIUbFpd9gmMnAQoJ5wGVezv8uDfU90mIQrlmv7eMVEl2whIg3WnIfEKG35COSV775krixr/SktBnC0EA3gY0Zwh9blW7IpPtyR2rm829Zf+mnm04oEPIqOG3lbR8sDqj0/odMBZZsDpB4kuCFHyQwRc2hvt4KaLiRJQM40n/ord7y4kJZNd4hl236UFgcRrWUsHx2Sn7W5aErhgO1IpnYsezJjO5MeRX46WKxCrLSV8AExu+K7bK4Wu0sOBj4n/Qru4VRN+AO0P3cSBYaWLmB3+YXJ5QOEhpEXCOFkAIqEZWSZLjVXaUOItFSG5i1411gcxVuECRdIxEXmur/LKipUOpZ4zvr8Lihj3ldCfN/e032BzqrFCOhnVmiUARw4A3hnLgjkt2QfyA0KEeG1WLlaK0BYrXPgC3MPwd0VmtoJQ1+bn+IgBtelHTdgP7W053ZJWJTtyLI0U4MaF8vF5HnGtvY8NverZObtzrUG6Q9WLZhc+WVXTzROeSJOiDeTGXuz4Z0D/CEAzC2Ch4FspZb+uYohMg17l84v9O8aWH5f+qu4bJjZCRNwrRiUaMrZwqBSqk41l43jV2cLnQnP71YgMb5Lj22KTJK1iyKgvf9ta/N4uzsOZFV9VEdoCyBdZFnqBBr9RYC14GQcWtmZt6bwczcaEsjp0OJnjXoadSSzlsEKiGiJVgWygewz9xqSa8vaf96Mz8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0mguPJ/QFevWkCD55BFncx8UJ0ml/3b+FxMEoSpdlmFp2k2gE+i3PS8EXbhdIvxQT1eztN/K0g3rawaTzNmWr6xMXzQJ0CbraXOFQKw4/XRT84H6r3MdXdHPXTIPsDT315iGlIZ5TFJmt1lB9dAARRdAO7hHYBugVhdLIiro97rlk6AB5Knny0riKr4TwgfSd+RxWfqbtJhDRfpal+nQx8/YxDJ8G03L1zth/38zhIdDCYyOuyYGt5zV7L19MsJh3v6PuuxuKID6iBEy/zdB3o62cNdr/K5A3LTbbdD65GJB66fVpU5VtF8p2DpZG/RpDybCexZGyKCVaapsl6vA2JHGrw33x+jFeog94CF/lMqW2n1reGbiIz8zxrzyWFkB86u9IK1tXA5tirk1CV2Xu1GOW5CFO3PVmKYaWxkid80y9eIXwY3IM54hkJXh2WPW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:05.3528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8ccacd-1464-4336-1f4a-08deebe34f55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464

AMD vIOMMU requires programming the DTE of the IOMMU device ID to set up
IPA mapping, and current DTE helper functions (for setting / clearing)
require struct iommu_dev_data.

However, the IOMMU device does not go through the normal PCI device attach
path, which would allocate the struct iommu_dev_data. So, the driver needs
to manually allocate and initialize the struct iommu_dev_data for IOMMU
in order to reuse the helper functions.

Make alloc_dev_data() available outside iommu.c so callers can allocate
struct iommu_dev_data for a given IOMMU instance and device ID without
going through the PCI device attach path.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 ++
 drivers/iommu/amd/iommu.c     | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index dfbc4a75a07f..2aece7ffac2f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -56,6 +56,8 @@ extern u8 amd_iommu_hpt_vasize;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
+struct iommu_dev_data *amd_iommu_alloc_dev_data(struct amd_iommu *iommu, u16 devid);
+
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
 struct protection_domain *protection_domain_alloc(void);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1bc232553c71..081448fc7b42 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -388,7 +388,7 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
-static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *amd_iommu_alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
@@ -510,7 +510,7 @@ static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
 	dev_data = search_dev_data(iommu, devid);
 
 	if (dev_data == NULL) {
-		dev_data = alloc_dev_data(iommu, devid);
+		dev_data = amd_iommu_alloc_dev_data(iommu, devid);
 		if (!dev_data)
 			return NULL;
 
-- 
2.34.1

