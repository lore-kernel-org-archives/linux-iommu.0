Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B27227599
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014930; cv=fail; b=V9DyjmwJ7V7mb6+2hP1QePV3Vw89ngt8yiheCPM6I1wLfljUAfc8L7iXVYVWAJd4pnDNDRw5qyYrhC3IBMIr+wleWTCFZCKcaanj7aRHhzYsO+wWCxFrLAq77Q74xVrd2SQRFicZX+gB5BVZVEspRoTgHALaOzPl5yUZK2/zOGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014930; c=relaxed/simple;
	bh=NNca8cPDQ2Dvl5eBSUwxZzZiPE5OfIVDO+HhP/oGK1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5fWxLDfREK+xeGMueWwZqsweqZBQ8Kk112mlD2anolV66uioxH4XVjPxhG+nLcSGndlACjBN2m2glnsBQp9xso++qYAUCODqHb8sElNcVqTRGu0sBlL00OkYaFHoAlmOWk73pIBuOk7xHzRwIUUnUD9TtTjR7oTwns4beFpgew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HF9M/Ect; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HF9M/Ect"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCW/aa5g79oLGNUQ7+twYb832M+51Gs0w6qvd62+3UBaPHYN/19DxzSxCLdGWMKSGNahb187b9dH8eFQqTtQ5wllx5o3XnPSc2/RqOvvP09VGjdfZ0/HbCeFbDBGsCRaAN0biTigi8Qw/fFhUxYpHtFwfUeyIgihOcvFyYPALJNtYVh+dPDfHBGH5vOoMFun1n0gNI+F6RoOu9xoa5DheY9GjBsgxLFszixmVwqk0UDP0uUPH4+BpwOopiMnznm/g4cPCwqjTgD8K5sezGM/q/gC8cRkT4K07oYSwxmBaG5+BmWGbvz0U65EmGrlLxzrwgfO1b1MtXc0QPKZ2ogGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5XZEBO1DWQaC6m69U46/bRY3xM06DpH5T4dSNM5y8M=;
 b=k1mYchfe3d2Ctnzxwybz2nBfat/LTlKe9018gV2k2EcvLSVZbkA+luYGh1YMmxu1l0nKfzTAkIptIQ77o3+wpXFV2MEI0+ix+4BdfFXux1HL0Rpk/oGPRpJ4XFIZueUa+9SOMMD43R+ZxpMaYTgaHgJWgQF+60sMQ2zk9ZEHAfj/lOcr4q7olKLEyNwirw0SgGHAFyQb3BaWeiTNMA4MhLtNiCVjlcdpJ0SyzN8AF6lH1pd9V/8GibnG+bDvijCDhMwOufxMaZpFNvGUoqPyZPXwBkf0IaYdaqCrlAhk7teUpoRyrTLpZOLYPe8MKwzUsTTCUNOSBCtKK438qeZDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5XZEBO1DWQaC6m69U46/bRY3xM06DpH5T4dSNM5y8M=;
 b=HF9M/Ect5thZ5dVkWuOy0qVeVydiC/cMLvCLhZ0HOgVdeVDeZxOshZ+xFhENeJ7lRGaq97vf3m8cnr0IQAjIGHoG9DJETRcsqIzExkkkSqcusOsUa0AX7TbTYsToOgM0OVzj0K1aYmETMGFzcZ6bPwwqe7txDsFG5wkjyg73cf+IR3NYkvvipihMQYXQ5c/GrzduLhm3Np54BKll2KnQuSuW/Byqvk/eXtOawO3LkLeQh3745Hn+bBiO8K4gr3UOObMrdqqWKNkzOjq7bUiS9r/nJvblWSbMjYF1li519gqKi3h0wgFH7lyEZVneP7r8WB2S/zBIStr2/rZUcaRNyQ==
Received: from SN1PR12CA0107.namprd12.prod.outlook.com (2603:10b6:802:21::42)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 08:35:21 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::c3) by SN1PR12CA0107.outlook.office365.com
 (2603:10b6:802:21::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 08:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Mon, 7 Apr 2025 08:35:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 01:35:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 01:35:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 7 Apr 2025 01:35:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jonathanh@nvidia.com>, <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH rc 2/2] iommu/tegra241-cmdqv: Fix UAF due to re-entry of tegra241_cmdqv_remove()
Date: Mon, 7 Apr 2025 01:35:00 -0700
Message-ID: <b3cebee623b4c3fc7de0aa2abcb703b9342ba33d.1744014481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744014481.git.nicolinc@nvidia.com>
References: <cover.1744014481.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a28976a-af79-4353-553e-08dd75af2206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?278eWh9pdIPKyet2W3luiS0F4YOgAlN/r19wZg+CJYpy6pEuF3ckEaIkOlbB?=
 =?us-ascii?Q?4QoqBVytB0yclipmA8F+3K7fAoUhjkKXVou7ucn6dsLWlWRnDj6ocAmfYG1m?=
 =?us-ascii?Q?nWU7o8o6WYNIWbcltGTqKQWAFzXFN1tX6TBxRUpRgLeOZnWv75MBK8dp2HA2?=
 =?us-ascii?Q?faOsgP/wMiV2vwjRfQKPYyJPeTVIbE6MCcE/ClQlSfR4/ntdX+iswRGD4D+l?=
 =?us-ascii?Q?0XYpDo1D5RsVB4U4xjxX/r3X0jqKjI8jtA7TDHB9KNXiimmqZUkglVuQlClN?=
 =?us-ascii?Q?Ayby5MTUMciloxetrosGvLdi8zt7587RSfWHxb95Ujrh8MuZW924936tFzHg?=
 =?us-ascii?Q?zbXq5dQhGT1vC8emgL/F9IQMyty3x7cy11ugl/pBiEsVFIjE/MvonddfOlRw?=
 =?us-ascii?Q?/Xy/LPwPX4rhnlKXkPk+7IP1Vk9vwtK7HkGMnbU7+ta3kU7jhrMmJD2G5JO5?=
 =?us-ascii?Q?HTpdsmUxiOR/BPcKQtSBcGc22eEQQY7BGdcA/ZmJUXFq9cBRemJDbGw48lxt?=
 =?us-ascii?Q?sLX+i7I57HFrYx56J5Eyz5xi7JEFHTgQYqpo/NOYwewlUXuUMqAqZbobGJCi?=
 =?us-ascii?Q?pB7czpyub+e5NHoJIVkYsN+i6KkXtzdRPTqTjjnDwB0akO9G69deixOnCJ6U?=
 =?us-ascii?Q?Xzoew6axXOpJ3jtD5dceB3ofJlUKlSGLKlelCoZsLzTU2sXrjhwoyYEwA/Vq?=
 =?us-ascii?Q?ftsilX8bbgyaRrica5p4oEsXnzOj8fMmziSKRhuS+sx37Hac1VFmicpmjYZS?=
 =?us-ascii?Q?++Xc/bRc4DY+OUT2HcNrGpZJwhHnvz4RChnNObV94Swl5Oo9TvPKF0uPTuAX?=
 =?us-ascii?Q?oBnx7rtUE4RIE+AonVF5kGaTY+TBRM0AVI4hTDXbpzcsNjArMrfTZsAa+sGd?=
 =?us-ascii?Q?NOhudKmj19cpNWeTPHgzIPK1EgjmNojlJ68Q8XfuBF0vs73gn1TmW3kIN+SU?=
 =?us-ascii?Q?aCWrQHbQxZyO65upSsgHalHdXAwQmKEFuHrrVzVIXMkOgiiigR1JQYjGChDJ?=
 =?us-ascii?Q?7PNDrW87i0V30J/pCgFJ8j/CyFmsCBYIgqOq610XH4IS2esB0htpJGeL8peH?=
 =?us-ascii?Q?ZlKQeYQk31qtMqZ/enSDtf40ZqTEOH76ZkTx4kC7QEgFAzgWV/PzOn7zla8d?=
 =?us-ascii?Q?lceDgclo4+wnPYV1zBoWDA7jZilKqZq5T/gdAInTr1s4hKGj4tLxO7TeXfXb?=
 =?us-ascii?Q?AJysTERKGjRTuxjrQXkJDg/lUclhpfved3ol80yQ79OcdncET2D9o1PXymAj?=
 =?us-ascii?Q?TtHwcnrEKKDI62OphoCRWIHIXReGbRzDNqS0OZE4QF44oEFZbAJAivKcZzyk?=
 =?us-ascii?Q?m4CYpl2akgXUxwcb6tZb0n66XNcH9W8pSPTXZH+yCx1DbQr87ZDO5M8onyup?=
 =?us-ascii?Q?1669A38cae/fwfUQO/Nm0x2CY/V32qFI3Y//Cag8gLtCMV/Aahkt8nFLHLND?=
 =?us-ascii?Q?R0SQRwWyDjKejIf6SAFNI9wjLSyyut1cw1yeJHINeBVkYIim1JjhXalfdD+1?=
 =?us-ascii?Q?keRN29uSaOdnfNstwCca/ASC6IHzmu0l3/DB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 08:35:20.5795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a28976a-af79-4353-553e-08dd75af2206
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657

When falling back to standard SMMU CMDQ, impl_ops must be set to NULL, so
tegra241_cmdqv_remove() will not be re-entered by arm_smmu_impl_remove(),
which will trigger a UAF.

Fixes: 483e0bd8883a ("iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index ce7be8eeb43c..8249ef087af3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -803,6 +803,7 @@ static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 	dev_info(smmu->impl_dev, "Falling back to standard SMMU CMDQ\n");
 	smmu->options &= ~ARM_SMMU_OPT_TEGRA241_CMDQV;
 	tegra241_cmdqv_remove(smmu);
+	smmu->impl_ops = NULL;
 	return 0;
 }
 
-- 
2.43.0

