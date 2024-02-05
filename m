Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC26199BA
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134348; cv=fail; b=E4Ct3UYz1OTgOTCqmZjEqyemtUqYeshKSco1kt0Jjyk2QjZGfqtC3VxOYGMP09GGUIoJXaF4htd0M0G8PWv3J2M4h3u6WZCp3k1nshAauXC3NwfY6CSiZFhOMI18yh695eTSgiDgrVIfD9/2kSe7z3njbJ+uQ1RdyWK9yazEEFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134348; c=relaxed/simple;
	bh=TvEiipiPadLdB8ogypc9uP3Uw7oGjAsGjUPnp9gpqbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZirUt2GSwZB2Br/4y7lSPE+/4NIwzBMHjwIcrmauMj2rbqb4UPlvWkGM6tRpquh+BuhupXetddwSHts2569XDL8uozYuzPQrOfmboaGjsZ9iHSdhiq+qatmNfDz5Z25OjDBc7w4LgVNbTzVlEgI6/oPOQ46vA0yudTqsiaAJ/xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eUff4VEf; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eUff4VEf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlPRcZTP0/Nm2V/AUWHXwb61TNnPPmPlxkQLBSlGXsczOfVVMcr4cgtM6UBwqPQbaF9gpb56xl/wDuBpCkwIbDb5TzfXWwWv2TbYNHSZG4s+nRx126irAXAMCG8bLNCXeOhHw0yBURgMyQEp7hTfNlJSZhBQhzZiFBpn2SJmmZZka2S9Q6VcCBKbPlc+55rMe3juLVqA8sj7Q2802ZQ1CzsSWzpKosUZRIqsl3YuHeRO8TDlg4B0hAX32QCfdZSUnI+Bo8ZkRHF7u0xGJX/rdgfA0zcV6NRkMQGW8RsHLGDiJTjZbxLLS87BtSDJdGDqm0dTtUBkAEqHsobPupHxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O9F9y+jlX63PNqWhkEGpjY5MD5wYaTTCI04T1EteIw=;
 b=etkq7wZxp+n8tc28GkkSfhqU1wOliVlBDWtWwSKcQRZYO4bslvlKCA0GEh4sD+/IgePSBaRWljHMCr2jhoHiVHb8S96jM/bse4dCY2LvizIxiBXI4mucYbSevpN2gIHW6uRGxQ3z0szZu4CKa1AuRaVLj6G03UbzyzMtmXtVgwYhP/3uF1S21p61d2Zp0jeCJfRupuInwiZ4IhIZmUkA37/+5VQ/9gjPGiUOqkCB1qjiGtYe4WR6bZ3q3FATmN6vVzWRDvwGd/74ZYz+P533zslQDY5uR4+64W5hBGk4/NYTRbc4Spyz4D/ZQQb+4y60EpogYE6Dc0ZQwNwt2H3Miw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O9F9y+jlX63PNqWhkEGpjY5MD5wYaTTCI04T1EteIw=;
 b=eUff4VEfJsts8CkSZ5hlKkdWLLCS2x+zLsYz1i04KyyKoRqO82xHFYh5CYtJ5nrIGM/P+rtIuZ6h5tEpIEGBb8nln+k3T/PLIoDB4fgkZLldEBrVxoAOFTU3Cf3khAoflCZKcnQInpFXDEBPNjVnmNEhGlIgcwB0Uiamj4OQFIU=
Received: from CY8PR22CA0019.namprd22.prod.outlook.com (2603:10b6:930:45::26)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 11:59:03 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::7b) by CY8PR22CA0019.outlook.office365.com
 (2603:10b6:930:45::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 11:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 11:59:02 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 05:58:59 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 06/17] iommu/amd: Use protection_domain.flags to check page table mode
Date: Mon, 5 Feb 2024 11:56:04 +0000
Message-ID: <20240205115615.6053-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc0d9b5-732c-4e1f-c370-08dc2641d891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	15ehEiyJa1UNuWYyLw2zf3wZKj0s3bWHTjI+pgQAeHhfuyPOos9VVKr/quD9uuXqtaYQ19eEN3vdbX9Re9gyBO4kH9IhgkFwg5FK7myOcECFk0Aw8ZKAFGguMa3vEBbtV7BFrXVAFjqyD75y9BxRzYdhHZKrqHlhk7rTIEUpR4Qrwd+/IpgoUcT5POGoVkym7uK2R0aTj6Ax+ccBvFR1iq4tHe1iditxWkMMQpqnTuo+XambqY7ixLBXvP+PFJcM3OWoh2Z6UwTKUSdOKHI0YyEiNI7HMBMzyqrrYCtBA0qipDqMO21/USjOah7W9jd9rWAzrLhWrJDL0Z+vHwXarCYLL5JrQkDa3WF/2XUpzxSsDL/iDFv2KBW9F03r7WU837NauKttEiXMUvpQHpWPn+WiITns48zXPpsde46TGPDpx9pjIBY0e5GiuF1udjPgL7skfU7oNcQ9RDh2sji++1U/Fen+xEUTzytzFnhhmEFykvcsLdhk/UW6TNMmfJzAgcKmGCrbmoMpZ8HfwSyuDtWVBoc1PoxbCCR3KNuzPtgQYxAziXzOTd1xuXPGOesKfPgZ64BLUBxpblci+8fDpV+XodTj2JCTz7L5W4fMXGBoGKbHRLxyWbPDUCU3LVAvEReLy26PNl3hxdDVJGjWjM+NlEUO7fqxQeAVFLgKzaPryngTfiG0YW5zNNiZJ5wePPtxVPMf2RWvrUPWjsmqqFoN2U+CBh6zf3vQq5M/9ctcl5deCUuo5Ro1B4AT9du4F4eaaNNPfan4Qi0uPvSITw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(86362001)(36756003)(478600001)(2616005)(336012)(41300700001)(426003)(81166007)(83380400001)(82740400003)(1076003)(47076005)(26005)(16526019)(2906002)(70206006)(70586007)(7696005)(110136005)(8676002)(5660300002)(54906003)(44832011)(316002)(4326008)(356005)(6666004)(36860700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:59:02.6678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc0d9b5-732c-4e1f-c370-08dc2641d891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060

Page table mode (v1, v2 or pt) is per domain property. Recently we have
enhanced protection_domain.pd_mode to track per domain page table mode.
Use that variable to check the page table mode instead of global
'amd_iommu_pgtable' in {map/unmap}_pages path.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8f718c4a0144..915ff7ecf8ee 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2315,7 +2315,7 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 	int prot = 0;
 	int ret = -EINVAL;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return -EINVAL;
 
@@ -2361,7 +2361,7 @@ static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 	size_t r;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-- 
2.31.1

