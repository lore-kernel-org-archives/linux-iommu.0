Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066D2C6A7
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478247; cv=fail; b=U+3B3v8fZiBfDgMVCJkGdksxllaWK0nkTJp0Vc2qilWUsAMNaa2LwMkYjeHUs++v66Bf7ivBci59SkFONrHgUfDT8X7++A19b/G+MmcAWeg7Y6ywNFW2GbjoKU0XUeDuP3YxF//e+Yx9suvg+BPlsWPRaL/oJplNkItlgJXfHiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478247; c=relaxed/simple;
	bh=9i12pmCfy7zgX1rULrAlBioQlTASKg8EJochyRYHb8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SG6XXQoaEZ7YhH8npcUrdKa3NlcDj0dXcWmcR3NFc/mgF1JIO0Y6+frL0wsEYxoiawBlldPTNO0QP7AI5nxTpniFtRFAce7gFaveZCqOt0RDr+EATPgsNsxno2+F/gIG4b5yonqj3q1f4Iwz3EiIAkT9PeBAoZcNy0bQAIhuNVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yLOol1bb; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yLOol1bb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLuPcS2/reRSdDDkiDVyJJRw4ttKGRo3qM+ES0S69/r080dwvzjpTmliQeWqXa1YBXtUaeAvPjfDsGXLoRtrWV1nBBNvOF9ctJyIkdeq6a+YVmkwpIBy5FMFii/prV5Rlgf8oeJ+F5wGBO1MJQdmbMOz/yC6N8uw7nBc6hK9WL2aChBoA60+2hzHXacXc8X+s4ydWd/5DGKLUVYArGzxu1oER/XwrksZQbzBmvFT5wY/dDwGt8hS9ReBJkfnr6nhdG7X+l2/RKBLW5BOEO9NS+mw5PheGn5zU+525ezXsoYcn4ZBkjuO6VzONDQ/r+03oho7wG2kzd0Calo2mglFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfpjY/0Ic8oog7MdoHCys2elGHI8ZLrsI27He52zrtk=;
 b=RZzMvo1l6RQ9VdO4wS4RhFqqCrJ7qGwZIsjL1BwzXNcNWXEnieEchI+IGw+J/8mPDUEQMwadlKfRNlD6uPEqM/Wc5wkU6kAXUoLsKCKvNjqnM81k42Jrj1X50qrCWU+WYEnywRN0tSWhPH2qjLPEIXD1vz+mudf8iPA5vITRIhGsGZPlYVt3dTSRTG3qFTDZOJjjRo2KAg3TwaizwAswAa4E04GAd+U8qv3kKMklPo3V0+dlHPVTOuw2ggFYbFEEr97TMI7q5ZdQfHfIVETdgHRygArFBO44j045wj4/eIPzlgmjLGmBd8WLpvAHKsryIcwX/YbYyO553CKaIbdL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfpjY/0Ic8oog7MdoHCys2elGHI8ZLrsI27He52zrtk=;
 b=yLOol1bblPCZdNFeQFUaKQDFXKI4OpwQRqyLkF7xgHOCwMBmdYlPzgTsf9xfTX4M7fJpfr4Lnu4zIsiiVUtjAIQJxgeYpTyES8ebTQ+waRL0FYimCAFDx/3Q8Oc7YS1kgA2AOpyWEFTychs9Sprd0be63vBbehtAw14Rc3twwJM=
Received: from DS7PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:2a::19) by
 SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.11; Fri, 9 Feb 2024 11:30:42 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::4b) by DS7PR06CA0004.outlook.office365.com
 (2603:10b6:8:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Fri, 9 Feb 2024 11:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:30:42 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:30:39 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 03/15] iommu/amd: Add support for enabling/disabling IOMMU features
Date: Fri, 9 Feb 2024 11:29:18 +0000
Message-ID: <20240209112930.63663-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 4194a867-3924-4b5b-e3d3-08dc29628c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dg36fOJCqqli3BDE1DjaKkT3ICrulNmccdodhpqec5H5+VnoRIylb7TAST6Y/EBtFemut79QHIa9N3N48IrYIxTUh9bycEZY38ssJwVZDxvv8U+ohAnF2jKEO82b/pCz4MxStvZ6OM2qq9d/H0lKMqIryhtlzUZveq5h5OFzcsi7LxrrvSoAJqSA8JlpkiAbQPhA9XASUDdRvrmyQD3UhHEE52P5y0OE+fq1UaD5PRoQXUOWFHJSeQ1/W2FnyMU0wLgm1Lu7NKLi6vh5p7BGqnKuso3IhEY4PdFdwG4oPES07TPJCFVb8xQIUx0NFUZaEkItp2KKykMXifMVqeK8J5xlAfd4S62W2h9tQv+d5h+JSKkxwwNMHQvVZLug6Uv9JoYYPSC1veNVlYYAHcxQbUOtbnkFoN5+ABShYnRN+AEIqY+J8mqUXHYlvaXunQ/H61RwKR/pxBTnL1ZidveIvhg1iaTv3RlmdiwkHvwO+RNrPPTSb1yOqc8Xb8dnvE3EAQ7nsQwqp79eeKyehxAsaOQKu1I+ynZo5UoFKQZTw5JGD11rsxJdWr1/tqWmCmkRCpSHAhl6YK5Kp6OeGtWSVviJ2N9RBwqym/0XFQwxkx4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(478600001)(7696005)(83380400001)(1076003)(2616005)(41300700001)(16526019)(26005)(336012)(426003)(44832011)(2906002)(5660300002)(54906003)(110136005)(316002)(70586007)(70206006)(6666004)(8936002)(8676002)(4326008)(36756003)(81166007)(82740400003)(356005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:30:42.1637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4194a867-3924-4b5b-e3d3-08dc29628c9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970

From: Wei Huang <wei.huang2@amd.com>

Add support for struct iommu_ops.dev_{enable/disable}_feat. Please note
that the empty feature switches will be populated by subsequent patches.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ed8245e66098..75c2a48c60d7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2793,6 +2793,32 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
 };
 
+static int amd_iommu_dev_enable_feature(struct device *dev,
+					enum iommu_dev_features feat)
+{
+	int ret;
+
+	switch (feat) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int amd_iommu_dev_disable_feature(struct device *dev,
+					 enum iommu_dev_features feat)
+{
+	int ret;
+
+	switch (feat) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -2805,6 +2831,8 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.def_domain_type = amd_iommu_def_domain_type,
+	.dev_enable_feat = amd_iommu_dev_enable_feature,
+	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
-- 
2.31.1

