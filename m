Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608A5D903
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871075; cv=fail; b=LUC8SuUBQ2bThqNc0cPEDnpr9xc3x8909CLCAnen/ABIrZdf6lj5hrBQ5JZTXHx3OdDUM2y4TPa7ELxIWbW3/3wYlldmprnX8E5BDl9dqGMmN0nD3Ghx8haHQTd6shIxbkVc9bTk1ZkF0wlWXz3dC8VtPcpYI+21JlF9mESnOdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871075; c=relaxed/simple;
	bh=L7uLh0hTzpLAzXR0UU+ORg2ErqzXFKT3UrMKkGH2AvU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ezVluj5ZgzReg15xJsE1Wbya4mPNz6QV0AmEn/Cm0gqf/S3dWYeTzlog+p15PysETXLG+s2qR51N9YljPdGuxIKzfDsdl+/y/HNU0g/DTqthwSt6oOG8Dml92MNorQ+RrZziRTGQcIDjV108b4lhbJz2p5SvF+7I0hkVWkUmc50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O2MxRszF; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O2MxRszF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuUHI+QtKkpQi2J3e+o0KvBF0SItBvvWGGh8nLkIZU8MusL1HWCuTQdbHVY4FT7S3BoZNOsAPX2xZxF3QBqSeZMslpbad2tqOCcN5KrQURzl3p7RjPXAez5qsC3sGZawdwgK9AA2B7Gp1R06XkqmCacPijOwMDF0XaG5vra9a/qQT67/eB3nwjCtHQ+9JGgyNetLJ3+Qh5+sNnFTJxbF25G5zObof3k0JNW2Rb3diVQ70VTZkA151SftUezkEeiFff88/wP+Ngld5SjjUa8L+qzDQzp+EoClLkued/W0fuO7qAY8kw1IMht010f1oDYcxZYcWyDYksuxQBaaMjkGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOjsANlL2mPr0jCLtc7tcNJXRfWhoKS+Xv1zBkWonuo=;
 b=CcdoqUhz3RN7aCPWRJQ6J4bO0uxYdf+XP42Gp02eVhm51APIi+IyzVP6yrQ2iQTykpktRRwcWGFVKMTgz4mc57YMsSkmFuH1sxfjmDXYTv+KG3GMXVyKn0YJbdFGrHr/mtb5IuvBhj41/LniyF9R4vNqFMcqaz5CS7X3VV2osCmq/+fXKyC8NlhST0umClbC24PrVcdgA7EgKHKS6Un5PzLv/ZVTtk8L+7B67+sD7hgQnwqdq1e4slCzUq2R+peGB5/kdby9Tk8UoMjwb6Ks81/PtL/lCleky8yR96AoxqV8CePqZ49i7iOoV4nYH3kRYL8+nFtUkDG25w81j5I99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOjsANlL2mPr0jCLtc7tcNJXRfWhoKS+Xv1zBkWonuo=;
 b=O2MxRszFi6zUV3aRPkqehOKBYUZYv0pvubdt90ELCXUOn2r26IV2j1DKFFkSLOLI1jfiDg0d3mMHGBEYnzw51TRH5pXd+DHcDKtHwZE152bPa8Fmp+t3/eLYQ+f5icdYVDmOWWnykjLEupLhvEoiCojzgJKIdylMxn7EfJjYtsE=
Received: from PH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::33)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 11:17:49 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::d0) by PH0P220CA0018.outlook.office365.com
 (2603:10b6:510:d3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Tue, 23 Apr 2024 11:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 11:17:49 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 06:17:45 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <alexander.deucher@amd.com>,
	<baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>, Eric Wagner
	<ewagner12@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, <stable@kernel.org>
Subject: [PATCH v2] iommu/amd: Enhance def_domain_type to handle untrusted device
Date: Tue, 23 Apr 2024 11:17:25 +0000
Message-ID: <20240423111725.5813-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1dc276-d511-4f55-ea86-08dc6387027c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o0fcL4ju1rr/naAjbOTz4/bN0RJkrJdR8Xdqg3bxv37EgU94s2mrzXxf207b?=
 =?us-ascii?Q?kHixeYFAFmKJwCkSKS2pnGcin+wNk8ZdpFIIWeaA/5oshO1ECOr/4qmIImYT?=
 =?us-ascii?Q?EbWKWSf7vbpQxJ5czZlO1R+sUht9edSVqjHei/Dvj0+EQRzVksW5273i4Lu8?=
 =?us-ascii?Q?ZvF9DDrntfo4OFU0RX1qcROToJUVmbaJ+YbSET32K8P3rNn4lu3GGYIwHclH?=
 =?us-ascii?Q?cDzRbM3D3Fv9IB3g9gK7Tir7DasemBhqoMw/x8ptvr8n5IIalBBjFAYbmUqA?=
 =?us-ascii?Q?ASiHyVun4ZaIVY4wOGtBCjQEzsq4/1Hq5dnc1o9ytVcw4RsDBX+8TYyijv8N?=
 =?us-ascii?Q?5nJDFXgLMLd+V/ZhPpDSSqwTj27XCXIgdDcBPZQlViJy2xOw7VkSYZX8gQKN?=
 =?us-ascii?Q?d3i/UL7E1X9uBrYgFTW5efeJBoa3YAAcmWGycgUwuvUPXZG0DBhWYY8/MA0V?=
 =?us-ascii?Q?m1GsAxOqVwVKx/gnQ6TPdtRb9UCTSe7k/yPWP8xoszg/2kumDd/ji9ddjxZx?=
 =?us-ascii?Q?buHZPQniow63bBQMZkh+vCYoBYZ30mY03A8llY3ESwlGlM/+cFOqF/vESmhi?=
 =?us-ascii?Q?2lzEYGkEb5cxcHP1FvtpBV8qMEs1CRF5rvVeK/s1n6754IXx7jTgTPREEJgM?=
 =?us-ascii?Q?qTTFrZueJNJt1wkDpdqvJkq+oOVy4AmjAkIsYuV8UlteLOz7d4U7lAv3+lYo?=
 =?us-ascii?Q?sn2aLB673MqcEr+3YOxdooB6s+qdk2bAvelWjgFWA39rJmXX6NBn1FsxBg9T?=
 =?us-ascii?Q?olOzhB7ltp9+AbnuwOTtKW/D7M0hdxX6rflPecvLueFj3D8MGbiXt54Xqp+H?=
 =?us-ascii?Q?bSK1rYWfaW5S4NTqW4v/0WV6WBsHNYOb0qHIwhjGcrFaKOAqdymGiBNIPGh3?=
 =?us-ascii?Q?6MSGs1IT9w0NrCKSFE5sx2pia8zhvRQYw8KLjoeTkSr6OuViyUxHslgCn+xx?=
 =?us-ascii?Q?RdG6mdSWMvPQOl/t8nmU46Gy+Yx/eBGILH1+fGLRKW/20IoWk4PkjRrQ5cnO?=
 =?us-ascii?Q?/v1IkLggR0Fklj3dX0TnlcsIeaEhpqX2jrKcFsJ8rbFz5A4CxNRCOfHgQtpq?=
 =?us-ascii?Q?m4zYmVfzqzw7Cr0vZ1UpAkR/uuq/6MVv6FJeQNoglMdPqry9qWqAK1db1wrV?=
 =?us-ascii?Q?vy/T9SDW8eo4w23fQjBTKH3NmchKz02tiOJak4eEYvR9TUg4tMsuQTc17lVI?=
 =?us-ascii?Q?aZ441doFirrmFARXfJAe46sB/XDTtb7ayqJTJv1jbt8EWTP/dn5keeG4J9PM?=
 =?us-ascii?Q?m5sgGAXhUF32Dyljr10aSMuSTJ9i3544p3xfH+DlJSLhaU9/iwAMLuD0oIhi?=
 =?us-ascii?Q?C3Iba4faVc03cW/Mk6x8yRj/VwBWMwTziE+eKyIJKvYHHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:17:49.2149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1dc276-d511-4f55-ea86-08dc6387027c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918

Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain for
untrusted device. This always took precedence over driver's
def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
iommu_get_default_domain_type() to respect def_domain_type()") changed
the behaviour. Current code calls def_domain_type() but if it doesn't
return IOMMU_DOMAIN_DMA for untrusted device it throws error. This
results in IOMMU group (and potentially IOMMU itself) in undetermined
state.

This patch adds untrusted check in AMD IOMMU driver code. So that it
allows eGPUs behind Thunderbolt work again.

Fine tuning amd_iommu_def_domain_type() will be done later.

Reported-by: Eric Wagner <ewagner12@gmail.com>
Link: https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3182
Fixes: 59ddce4418da ("iommu: Reorganize iommu_get_default_domain_type() to respect def_domain_type()")
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: stable@kernel.org # v6.7+
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes in v2:
  - Added dev_is_pci() check - Thanks Lu Baolu

-Vasant

 drivers/iommu/amd/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e692217fcb28..fb727f5b0b82 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2754,6 +2754,10 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	if (!dev_data)
 		return 0;
 
+	/* Always use DMA domain for untrusted device */
+	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+		return IOMMU_DOMAIN_DMA;
+
 	/*
 	 * Do not identity map IOMMUv2 capable devices when:
 	 *  - memory encryption is active, because some of those devices
-- 
2.31.1

