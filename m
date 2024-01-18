Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD19475
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563471; cv=fail; b=NYf83cKYlVDiOOpOueAnxcHK5Pu4s7zSI3x3Ym2l1OLyXU439oz4LX7xJye29y/adIa1eF2w05Rte8uTIqbqHwwq4mrrrn4EV2ePc+Qe6WlLbJVpr1Z2i3S5tE0PeBQq3Ecxm19Kk9AShBukBVpcdwQesfrLsuKFreeDdsWXpE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563471; c=relaxed/simple;
	bh=uXyPKDGdh9uXuf0t8QeP6P/TUD1nWx1zfNT/7dbP1+g=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=tsfkWH596V9DU0Yz0bYKbOQ3Zmt1sNwl8r4OqRDr6R51WcCcCoyXcj7A6Qj1HifFVx9vnO8vrefBJiWd8T/5+7YdGDb4K64lt4cVaGa8N/yYifFcWkJjdw7h9X2GjKIsPvNGdaIEF4DfBCmI5m634Yv5G7O27O5tY1QAvPbExF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EJeNjzNW; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EJeNjzNW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i209Cf1ZkjmnyYUMQkM8ZKqdaTGzLGxNnD92VbeiJtRLBKOUbbQ7cLUui3O5+16Gy+j2IGGrOHbNGF23iT+7/usOutf0Bgo6ffmIHm27NctCjQzpzZAfouz+i2yzOcnZu5ZwORjLxN67h89nuf/B0jT/3pnAyKRcZTnC64igey+QSaguXjs8bC1Hd87pha9i/FjLi/lKxy+A4aM2XzoasLZZf/JS6mtBEXYSaRY+xsdMnCXi2TvvaDX8EFNp6oOPUVODMhE69GB/TR89rSzKo6+8t1rVJ+dIsAv9hb57Dog2MkEIr9TGIde7Pg5lutkGZufHehoNu9B0tr8Kh+XyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH4pG3nfchy5gooqZOGKz6r+spDP5eqULBM8HSDWj6Y=;
 b=OIAkxzDye9isJdNgAEClXG6eiDnUSSF+UiFMo+8xCUVNVGH5yl4/p/a+2MxbszVVTbsvpup8DXB/JkHixBfzjPAWkp40cAgQblnJnTpCt3syj4PEMxvmfuPxW7lskxJuGIS4F6TPOX3Q3XayNB18pCIoOYLBk5xXUKb6/upe1puoVRE7gY8bay4Cs8IXicF3bsgbwpgg4XQYJTFISh4BcHCDSOtdUo3Yy04jymtpKCINTQ+L30GR/rdYZtufT2XI0jjYqYh+fXMQ3skQPQSn2jiQFJC3wBGGwuS/B+h3sIgCsStdghDwXERw59QaqU8NvXbhr34e0ZL741TA3hq/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AH4pG3nfchy5gooqZOGKz6r+spDP5eqULBM8HSDWj6Y=;
 b=EJeNjzNW4HxYa+NWsVCHx7DswsTMdRDXDmRLkzduHLklKJiCyspKH7dZl5mrqIxE5GDCJbjFFQSQ5QENen022NM1nlmwiHONqLOwRNtGHBSTH+K/vf6SXbE2UEoxe0MzuVmugr4M+J2gx8MLHfRivBIXHz5697fSMsblEOHVKoU=
Received: from SA9P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::18)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Thu, 18 Jan
 2024 07:37:45 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::90) by SA9P223CA0013.outlook.office365.com
 (2603:10b6:806:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:37:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:37:41 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 08/14] iommu/amd: Add support for add/remove device for IOPF
Date: Thu, 18 Jan 2024 07:33:33 +0000
Message-ID: <20240118073339.6978-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 337c5b7d-d6a7-4ee6-1f4a-08dc17f85c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3zrFI7/zQtVSrYjcY1n8W4S+GjeP6qvRbQMCo+ci5hscailXco9Hwxx3MB45nBgPyWEd3fgu82MyrykVoZCvrJ3pGUhwl07TsYw0D2d8/Oa2zHizNYl0luEjVTyRSKCnOYqmn2NLgtldr8TCNd52a3FNw+7D0Zqeuwsg4Z3t1EI4eL7tVtUZzeGiKFIXz2smfMKOQelnNq/GXgHg18OuHOVIskMfvGOvzR6jxTtX3fm7wHNsQp30rRoDM1DANgmdWiqSU587HSSSsxAcf/BbhGL6eRXNuFbqCGw0wMfiQr2MXiFGiF50zwcpIZRIPjOFQZO7y6Fjx97SKvez4WCK7KR7XabcjA/NmyYB0/QCazVyJJqaCHbDZ+CvzMaj8z/PqX6TiN8g6L65k+YyL9ph8mT1ZXg6w0JhfxmqHUO/aZvGiIdi2fkYetse3UbUAq1FPFSSHaIzu2dSrhifnS0zdvgnNmVmndrlsGDITddipXVFnNxtwJEeZ470djaiIQEcZ5miHwAYchk9PXdL6768rdXiQVxSs7UwJiGwe2vvdQHU3ZbehQ5aUwQS503juJ8aKDp0aoD4HG1h1cT8LwxgF9uMq4quTH1BsHAZBYQRETMQOK2DSTEvHgRDv4JqGk/0q8kj48KXvqje6lwgQzhDYumRwPqkHZdcWIqz3H+aSB4RiAJuIMHNI1NNJSrN5iGZrGkW0ELxmTDc8Zgje+KUNslnIjKRI66zl2o/5ZiPyWe51V9ck68bokpBDNcJ7kbMhN097Vac/VGxI/ntnPhYDQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(4326008)(44832011)(26005)(426003)(2616005)(5660300002)(2906002)(336012)(7696005)(6666004)(16526019)(316002)(8936002)(70586007)(110136005)(70206006)(1076003)(8676002)(41300700001)(86362001)(478600001)(36756003)(36860700001)(47076005)(82740400003)(83380400001)(356005)(81166007)(54906003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:37:44.9847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 337c5b7d-d6a7-4ee6-1f4a-08dc17f85c78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891

From: Wei Huang <wei.huang2@amd.com>

Which adds/removes the device to the corresponding per-IOMMU iopf_queue.
It also registers device fault handler. These interfaces are called
from IOPF feature enable/disable path.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/ppr.c       | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c8deb22955d7..ce23ce1a1a16 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -49,6 +49,8 @@ bool amd_iommu_pasid_supported(void);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev);
+int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev);
 int amd_iommu_page_response(struct device *dev,
 			    struct iopf_fault *evt,
 			    struct iommu_page_response *resp);
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index b1751eb495fd..6b1fdda95514 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -163,3 +163,38 @@ int amd_iommu_page_response(struct device *dev,
 	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
 				      resp->grpid);
 }
+
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	if (!iommu->iopf_queue) {
+		raw_spin_unlock_irqrestore(&iommu->lock, flags);
+		return ret;
+	}
+
+	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
+
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	if (!iommu->iopf_queue) {
+		raw_spin_unlock_irqrestore(&iommu->lock, flags);
+		return -EINVAL;
+	}
+
+	iopf_queue_remove_device(iommu->iopf_queue, dev);
+
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return 0;
+}
-- 
2.31.1

