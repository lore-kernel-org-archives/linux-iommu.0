Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E152D60A
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478294; cv=fail; b=gnABXe7qXqLoaD8q2agIwaF1xJ1NqS8A6TThhds3lJhGhWUd9sqhGhyraBFilPiDorW7pLgFHWupDCUrtUc/JZJP8c+LU1JKPNGvWKWfhhF9FvYkXk418/VkQ3ZVYHPEHh6ofJVM+FOs0vMIr+ptyFDSXRWveXlxArPBfTE4gfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478294; c=relaxed/simple;
	bh=KyG8X+hhfscgXmkzumM4oYfvwoTreMayEzutzi3P8Mo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0OSmoDkmxuSDE9D8h7bZe/QZo13c6LSigBUu7SvMhlCKeVF8v8N0xi5ikQjy+IT4vxb4LhPyz3L71Mlt3o/k+SDYGvBB6/oTA0OAA+kQvzCKqmn+dxLwECSVMDKOLxnf86eQPaMTyqE3kY0tx+26uX9kvQt13SyMaqT5EWSTL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W6xNxrv1; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W6xNxrv1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcDlF2OgUsPkwCMupy4EPgADfWgS0JTMtO3gvAOs9Z2UsHr6K/JxedraBNzun9fhv0YtglJ1IXgxLwkDDcqr6mj8ua6i0P2OuGsKUtfojrQJ/y18HU09C9QnJ0HRQO7jZozS4fLS78ipYF1AopNE35rghx1ElFUHnkNsqL+S9m0LMD30++JlvwL8U9DXrHf3hsSuFEGSY7XCkK7E3dHOGr8PthOju8Y8GYIYl+vvrrCs1mQqV6O3D9M9MSxXVxNn4KNYksSqE17SVuAciHOg1FeA8gSJwvFt+Sjn6ilOzkPXRaBVpQub6SHZXoEBjIzZProPaDuB1VU3L0WGSD1V2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO0X7+wXmNkJ7QkY/l5m7BMwLw3GMclHPwYquDXOD/c=;
 b=jGiCqpo1Gpo1wY7QRP7yHtSVmvYLqCmAzZ13oURZucyIJEe/aWb4xiBetoAoU7DXV+aKwWvJXy3U4DYaE8utknN3IiY3fO0URd4Tpu4HYkWpgZgGOnxikHjEfXC75Y23h5wXj5QWBEzsr2OusHL0zJJzQgwmYqVvl+6Je+QJhgnFE6vLMPWEa4YmCenwvjtdGb2+PpR+2pQET2h3hQCr7TZWG1lpdqBvi1ho+7E5Q2koRe4KNf56N6NFQtqVThCIg1J94XmS85gGRrOWby9Umqu2LyQYQIq8PYEFNLm4tNTTeG4dTAbXZ31CxvCi8I5bKIPQ4zQGceGQslRBG61s3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO0X7+wXmNkJ7QkY/l5m7BMwLw3GMclHPwYquDXOD/c=;
 b=W6xNxrv17Ge/UeQGpcDmoqpw7dMP3xXafuUh6EQcpceXTq8bLEbMT08f7ELbMvTswTEFYrMcmRY0/fd4ayRqidXcM+EdC/qpgd98JPrlsIKyPPQJ1qg0Lywn4+dR5lCmjd0kubp0ZoiFiLCpgZOnH/0puJdIwjuxPd2OeP+ixCE=
Received: from CH2PR17CA0013.namprd17.prod.outlook.com (2603:10b6:610:53::23)
 by CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Fri, 9 Feb
 2024 11:31:29 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::6d) by CH2PR17CA0013.outlook.office365.com
 (2603:10b6:610:53::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44 via Frontend
 Transport; Fri, 9 Feb 2024 11:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:31:28 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:31:26 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 06/15] iommu/amd: Introduce iommu_dev_data.max_pasids
Date: Fri, 9 Feb 2024 11:29:21 +0000
Message-ID: <20240209112930.63663-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: b68512ab-64d5-4ebb-ca80-08dc2962a87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pjf3P4Y8sHW4oADCGGvQw5hz5AtW8fPQw857nAn+zA7a80xg9QY1o+QolBZ7CKh6WFgkHCJJoct1mpquxuRr1sFoft+wWgtufdxYPKC1fEc67qNH0c/puRDRcGgG0gQRtIXdomawPUusf+EfuGPJ5EtlHHU9P63CKThdCH5NDhUMXXExJ9sfwgftTbFMf8FqzEmGT+yMhl3yi8L0fIaEJGSUN8QoNDXyHbtacHRQjEuKmbzLQA4kQoqNYAIpMCa0LtF4c4wrNNK59a54XA96OA9Gs1Qnv7AkerHzvRizMaWA5hGC5T/7ZwFx92ezJXJu4pGVz8GheK8PomNHDQBqzDib8JYAWHffucVdJLduH6Jb8sXAc/hvWkw/VMbZkNvmudlgdG1Y6z78IwbIGavSdWheQ3RiOYxGlxn/uwGer1+M+YfoyXeU+N4fjm4Qo6SlaqLs2MLSHMlVNn+7jXS77GqrMEkwcqL2LrUlx0tgSMCGNPCEMjkOSTru4jVmt6RmYnHYHSBI21u4wrWM1kYBquolfZOm6jwxSvPCOzFF4uFvtchrwx5/eJR+A8nRGNxQvHYUTHjDR3sN6WRc2TiwLJQi0P4gY4B5RTVBoS0jgvA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(41300700001)(5660300002)(16526019)(426003)(1076003)(336012)(26005)(44832011)(110136005)(70586007)(70206006)(316002)(2616005)(54906003)(86362001)(356005)(81166007)(478600001)(8676002)(4326008)(8936002)(6666004)(7696005)(82740400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:31:28.9492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b68512ab-64d5-4ebb-ca80-08dc2962a87d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361

This variable will track the number of PASIDs supported by the device.
If IOMMU or device doesn't support PASID then it will be zero.

This will be used while allocating GCR3 table to decide required number
of PASID table levels. Also in PASID bind path it will use this variable
to check whether device supports PASID or not.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d5786c33aee6..0abf590f6bc9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -821,6 +821,7 @@ struct iommu_dev_data {
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 
+	u32 max_pasids;			  /* Max supported PASIDs */
 	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int ats_qdep;
 	u8 ats_enabled  :1;		  /* ATS state */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 59fc0efce6fd..fe9c00ed7e00 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2105,6 +2105,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
 	struct amd_iommu *iommu;
+	struct iommu_dev_data *dev_data;
 	int ret;
 
 	if (!check_device(dev))
@@ -2132,6 +2133,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		iommu_dev = &iommu->iommu;
 	}
 
+	/*
+	 * If IOMMU and device supports PASID then it will contain max
+	 * supported PASIDs, else it will be zero.
+	 */
+	dev_data = dev_iommu_priv_get(dev);
+	if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
+	    pdev_pasid_supported(dev_data)) {
+		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
+					     pci_max_pasids(to_pci_dev(dev)));
+	}
+
 	iommu_completion_wait(iommu);
 
 	return iommu_dev;
-- 
2.31.1

