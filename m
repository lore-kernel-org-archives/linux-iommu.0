Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E23BCD2B
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 05:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316216; cv=fail; b=jW1vwqxKWLW9NlK5pWwcPzmQlkCutnxTEJWCBKyI8rnqUB7vWF42Ks8QdXoO1MIpiKRgZfhHiWUf+S9/Crc+nK6PUWniBRiMy75uYOqMGn8BVBPvh9+qkFIAvCVML1nd960LBJpZmTa9sub66SbXSC3KB54EsIObMzzT0VRJElA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316216; c=relaxed/simple;
	bh=7OFWn7yCfhO/Xewnxy4YPa1U/koZZnOlZZz4SM2RcFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+bHuA3lu9jbAUNt9M/G10XmRYAWvtR8+TxvAnvfk2coNGWjdCuDRDjCeZWL0p+4MBCOpd2HeO2N2lx05NeMassNw2YGhGJRbs99mhk4+DX9C/3Ep3yVQEMrZk0j7lDfzZPtFneCRnpTY68HBp61YvhEemb1LkS8wnD6PdemQ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U1MITJY+; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U1MITJY+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfmySESz51qyXpEDaAvqOGYRvXuQb3SA4yBOmg3FDAOzEHxje8pDO+qXuxSJ3JbHVP6PH2aBx3olBFDQXBfgIMJXcBHuiZiNgM4lktWBkTm/eP2SwInxasQ92DuF8ayTnEgzfgN5cmGZYljfQfoB4PODg67kdcmiX/gQpeOStePcoOYIwg/x0xzAQvln2jJ4kMtWPhqrTGrZoLdMl9ln0BUgpg7m9bTOmmy3zVm9ACw05R7YRVsJNrVIw0auG0DQBu8o6ysNrBFjcymIsGC0DAnkSQ+K2ebkPvKDQ69pHBwk4Te1gNm96QaQ0v/7q8cZUYzd6sh/lotv68yKuAfYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee91+1G87T36KekN3mUL86hACF38ALj7KCseD64t5Qg=;
 b=gQPFqhNj99r1w1TvmCV7dIadym1ucW4e0gFGrpA7mW64vSm+iRMO6Wcr4SKJN1tydPhR3Yp+6SWSbwz3CkCVwMZVL9DhOA/t6EiuY+ne7XkusOj/UIaVZP1VsPIj/WSoYCOI7XZ1Kt/MgOZec8obyFIlpbfeRh/MqJ1e6nsvpj7CK1OnQb47PtjXw8enmNRW2exNESzyHvAc2kxrMyfXsj+89hwYdIRaIzijJjpSMQHsZfL0nq9PT6/ogjn/JFCJM/oWYgGdVk9m9JIWnGY3+sQNJ2gLjFgbQG4NHCHpAw05e9ysiyN3Llyagq7MEfcr18Rb+CeNzMjAko3XIaIzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee91+1G87T36KekN3mUL86hACF38ALj7KCseD64t5Qg=;
 b=U1MITJY+vh2we6yPaeW9tJvzwwGrV9XMgB9aL7btZHlA9cCH8RSBFmqee7pPNt9cHC1xQrKTWx1zqYRra3P5G+FvtiPGPPJjX9rFx35MhsV+SawGbs0WesIfAxoV4k6twRMvdDsOBpMtT7PB3H32agWsi6KRO5szo5kG3bi2qzuBzykgVjVR2VhPDf2Bv+VZKlN6JM7z2SprHFL8cYdv1G+up/Y5/dxUq6HBArD1W6DwafV2czhSL5OQRwu4H1TdoRuI/ssX+i3l64H9qSxOdli8UoR8sLh1+MzLldS5bNO6ZQaYH9XXt5CjCVtcCgCRGNIFhA/QEpGZVWzq6ACIGQ==
Received: from CH0PR03CA0251.namprd03.prod.outlook.com (2603:10b6:610:e5::16)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 05:36:49 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::5b) by CH0PR03CA0251.outlook.office365.com
 (2603:10b6:610:e5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 05:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 05:36:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Jul
 2026 22:36:34 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Jul
 2026 22:36:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 5 Jul 2026 22:36:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] iommufd/viommu: Release the igroup lock on the vdevice_size error path
Date: Sun, 5 Jul 2026 22:36:09 -0700
Message-ID: <e903f775d491296a525097e2a90b3eb6a47cf2ef.1783311134.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783311134.git.nicolinc@nvidia.com>
References: <cover.1783311134.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6b6260-4a7e-46de-7421-08dedb20936a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4bX6epLLI9u4nyhHZ2F0c+yH8n4opvDAlR/nrPi5KcVdKKFKcfY920D1MtmLDigAErvMbNbHtzBsyL7uesCxvIAwEG9AycK5TkhuD1zqypBQe4/Av2eb9oyTVuS7iWbQ/pcqLPqCnXYeTsVI++/fYsnGC2bzYbAXb7yTjX8QOUY5syFd0swtZ3HFcNLxwDlfH7ZaKsq35dCyh3l2DgAoxgrAJ6ixnbcKIEmsHG+xkiw4kxaNqZpzQYAC2D+LulzynI/ZgnLVxoSwzUTX8ZHxyBTLXx1aHxnkDQV1roDRRFNC5SlLXa1h3K/ygZMNrRBODAsDwyJLcKzl6O5czBF49p8I0uZByA+JNu+v6EeOItTl7DCe7XJD9nmLSXc23kg8q5oay3BnwRBhxMfO5wdc2U1PoCYv6ca+9spqFv5TMAmtLKEJUhTDrddQ3ymyQIcnLQoKEPE3q5foyZtxw9DsFgEqcw92NOKJlsCeAXOeUPJhsQBtDZthf8WHTHYE3uSlBTL3AfkCp+UXGQgnLhiDpIZh818oXFtldn6YLBamIe8FDwoJDaIUrMYzo6Us5hWZ7L2KCl8hWYKtetpZR/F8huWO/Rq0su81gb9UV997CZGeOkqDQsXXzB7kPapiifv832MXyuHbLCaZp28DtFnOivjP4b9VWkAN28a75MrwwbNPderHyDrW3vgQW2SlqwFIkMlfwidQ1LHSxG3LGOq17w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ECtzwJGhrOZ4QSzFPOA5uaKIZwcw7Qo3nf81NA9n9IWhIlzK+rX6t+TUTprO09P8sWzSa8pINDnaGoAWn+dTn7YJC2agTmwCseEn+FfGgnTazEwGc1pv2Wt3PFc3Kig/oxmOjhDYSgmLEeMCIatazre0daH7gzcl1agZUWguAK13ZRYWouEZt6REUnOgDDRijxn+K3FRK4fYrx1KGfe0lixyjJh1p8sSH+nP8JFPPrapK+ZQZkbSNiZgzLrsAGFhehn7TUuxT4mybpiLjlp5/00BDyVDLlWLg0bXYA0oJKKeTpqfcr0A307w9PCTtZxdTqLc5TOIX+fgKvX+SZC86yo8zaYhNBnvPVl6nzb2M9H3A3CN/Vc8FtAZViCvbhFiWG3APSJTZSo1fw50WXcMHZcT3CZxbxgWDkYZ/E+tXIK13EnohVmIL4ALekjiTtsO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:36:49.0445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6b6260-4a7e-46de-7421-08dedb20936a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

iommufd_vdevice_alloc_ioctl() takes idev->igroup->lock, then validates the
driver's vdevice_size against the core structure size with a WARN_ON_ONCE.
On failure that guard jumps to out_put_idev, below out_unlock_igroup, so it
skips the mutex_unlock(), leaving the igroup lock held and deadlocking the
next vDEVICE operation on that group.

Jump to out_unlock_igroup instead.

Fixes: ed42eee797ff3 ("iommufd/viommu: Add driver-defined vDEVICE support")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 4081deda9b33d..0c12c7e352a14 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -189,7 +189,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		if (WARN_ON_ONCE(viommu->ops->vdevice_size < vdev_size ||
 				 !viommu->ops->vdevice_init)) {
 			rc = -EOPNOTSUPP;
-			goto out_put_idev;
+			goto out_unlock_igroup;
 		}
 		vdev_size = viommu->ops->vdevice_size;
 	}
-- 
2.43.0

