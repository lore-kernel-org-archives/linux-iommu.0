Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5BC200D3
	for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527281; cv=fail; b=bPccduDQUYp0CarFPXTkwLuLCclCzmaayofaHFLrbO1+iL2pQ14EGa4hnEHKeTwq4TAFNSaBTyCwUXbOEH1ikKI+oaPSGJeWR2kdyT9OdTbWUVBaxoVB18tO7hGmUvWVTmQg38ndP7tFq5eGvynnEZ+Gf5HlcYuNKSFvUcQSrGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527281; c=relaxed/simple;
	bh=WOjAwEovxFZ/bZ9qkY3V9DGwZutwVfS6fAOAWWmudOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ylm9stZPjkkmhMIxGq5IF8BxOFFNAgn0c6D0GRZASqQXaiMaDvqSAh+5wYQE0ABMkodp0mWloaRzOE9VEPMs9cNvtg/y2IkHbRqYB1KaqbiKq3Xrd8b+G+lEyf6kqkeVHOGmQx+ZJo4l6K9OoaY/rRJeZ4zwx0JW7emMl5AI5zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nFZ8Gtew; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nFZ8Gtew"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk78SuJiV4f8glsE1vWFqzQRBMBdt1l+XXmrR2TCDiFdugtW4yC7GnOJvD3JDn9gacWRwWWQFTUf+Cbg522GEMwa+hddi6+uaClZuInNgf6FoURjS23xKqkGmDZu34Eapkr2AMZN05djxs6AmIUkwmJTwXdaSLnFlxjFbSbXOZ66qA9eLeLg1hXQGHz3hq2NcXweLLjU0McaAFHDW8VmJUlIprOt2N6+qyH8949aBO3tofT/hnTpU7jDOWwBO/38KvhrRRWswxn062lzFYALuC6L/tKG4pUbZIgF2oHosQHpugVmEw5lb/K66VeWVCDfN9niCtbsHtDBAMr92W23og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ptzgrxjctf0zy10uOO7nwpgS+Rx/MX0jp+k/s4OusyE=;
 b=OKPnZflK5heNmBQRAgn2oGA/u1B2N5lchd8sqN849RCOu6QfVPiR3p5kJqJDt4aS1aGPl5KgVW5JHfQPcRlotHaO5RF9Ky/Zp1cGZVG9uyNqfp1Lqpx7cVPsEoa4f/zIXmUZE7ghCBPqAmEg3i9m3d46Rq9nduH5nQ90uNoHXApHfrshzw29Dt+6Dob6vbftPcsKwvng90fZyuufAxGpQjuEdVdWv/XZi0bJj4Q/+MNb/bB9+OeVx2AeTQJH3UqEp+Hd45xwEl0/OVNm/3DYRnOicfPYlO85Ixs9muZuuvny6f50Tfca/zAnQHne0pI5nBlSVlumvFrBYC0E50EoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptzgrxjctf0zy10uOO7nwpgS+Rx/MX0jp+k/s4OusyE=;
 b=nFZ8Gtewx2Vpwhbkj++BTTWf/HyPhnoo71ssxQN5ujSPvmw9M8P7JddGLg1hdDJ/KFL12lwSO2Aj839a/+kzeNF4Ja4HVgbArmQLft5b9UYFr0/22gWVOEorRSWwjzxGfLOHCeIkzXmEkODyH2X3ArHfweHc+45ElsZNc+mzKbo=
Received: from BN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:408:e6::12)
 by CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 11:47:57 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:e6:cafe::c5) by BN0PR03CA0007.outlook.office365.com
 (2603:10b6:408:e6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Fri, 19 Apr 2024 11:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Fri, 19 Apr 2024 11:47:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 06:47:54 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <alexander.deucher@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Eric Wagner <ewagner12@gmail.com>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, <stable@kernel.org>
Subject: [PATCH] iommu/amd: Enhance def_domain_type to handle untrusted device
Date: Fri, 19 Apr 2024 11:47:15 +0000
Message-ID: <20240419114715.6028-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: cffd143a-626b-4a80-4d65-08dc60668ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q2yhmS7EAzgB6ZJAdHY2soy0qvRbADHrzRsKEz7meFOjdMDnX7A8/MBGLEzh3r3ygZapt7w0oDTTIRiqxY3hKZdL81eV3G/TOmVsU3GLTHCzYM04ArT/PMv8bgMCvPfT/l6fs2OD643cYi3sdbsqUYnK0tlcYKffnnsRheu2aLZG3SxmdI/q3o77iKT9OYYrEWGsjvXC+3RlcqQZ8/HHTP6XyabzXY7g2iL2y9V4jGIVcwJkIF6gEmOBvoSpq/p+oVis5SJ8G9UhTt8uy3l2NsvJVOsJDCAn+r3+8YiJkYXa+nXzSQVlks5GmJha+hqZowccNcXrixMkJgLZQLb+Blg9R7GnPBu4G6LoCsGGaIWkUHKi8b+krPS4Na+lyN1w5XjyCNAJ5EmZA1tKWk7krA26+cZJnoW40RajxFmTUIfHIsurf+9lAgmGXoU8LFZ13HQleCjsfSbaglFzAL4R4vO8tLPpT7cxgqbWK8oFhAzfQLQHc7x1i+jqT6Fftaccs7gL+WSHvqWxEDtPpda4HDJEPpeenjxeEOYmwYp7EIcWAvqnbiYLYBOnMULOcace04Io+auEtQvK9xHS+Eukk7JrnoH4qZLP0GNyUiV+fJGK6Y/YsuvTv9WQIOs9DRCKv5tKp6cajJkNCW0pqvKvC7r5PgVnpx6QiTyU8ouJac+y8xpo57cib42EvXYjY+m6eZXJPDy2EZBukNWPyUSJrzoRBGwwrcPt8gyStnZ+XWjG2TnZebko1eJXurrktbuI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 11:47:57.4293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cffd143a-626b-4a80-4d65-08dc60668ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533

Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain for
untrusted device. This always took precedence over driver's
def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
iommu_get_default_domain_type() to respect def_domain_type()") changed
the behaviour. Current code calls def_domain_type() but if it doesn't
return IOMMU_DOMAIN_DMA for untrusted device it throws error. This
results in IOMMU group (and potentially IOMMU itself) in undetermined
sstate.

This patch adds untrusted check in AMD IOMMU driver code. So that it
lets eGPUs behind Thunderbolt work again.

Fine tuning amd_iommu_def_domain_type() will be done later.

Reported-by: Eric Wagner <ewagner12@gmail.com>
Link: https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
Fixes: 59ddce4418da ("iommu: Reorganize iommu_get_default_domain_type() to respect def_domain_type()")
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: stable@kernel.org # v6.7+
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
@Eric,
  Can you please test this patch?

-Vasant

 drivers/iommu/amd/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e692217fcb28..e405714640b0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2754,6 +2754,10 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	if (!dev_data)
 		return 0;
 
+	/* Always use DMA domain for untrusted device */
+	if (to_pci_dev(dev)->untrusted)
+		return IOMMU_DOMAIN_DMA;
+
 	/*
 	 * Do not identity map IOMMUv2 capable devices when:
 	 *  - memory encryption is active, because some of those devices
-- 
2.31.1

