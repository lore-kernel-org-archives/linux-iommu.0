Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAEC14293
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148346; cv=fail; b=npiiEV4wlqeyqR8ei+K6zwDsnrmPKNVARr2UF1zatnAhPOEm1N+wsyQhsNAO4AnGyvre5y2VLlB1C+/1MpavErwqlykC8Oxv3GNtK2T/6zoFPeLHuwiOw+vKewwi+PcO1wLzAhU/drwY8UbwYX6km42Wl0CaEWrOkH5Ayt9wDEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148346; c=relaxed/simple;
	bh=hQhI2LuoX/7koN4VTF+KyRCY4yygjWkuJPCfVmDG7Kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOjaJTZTLM730dN024ZwNgFCqnk/Gohj3pt9H4oAtAkQ6w211wI75yUk2izhwlTtI6hqQetLJQj2730XumG7Elsv9j0n4BIVDj3MaBnuVX+l4lq3q3R4hgrpILlAacdPbwioMJf0V/eVNErNthcVKl3HLxP3vhAerbC9gg/3bHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uZK1hw8o; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uZK1hw8o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb84oGsCgKScuZy8ldqe64koKiBj3UcFc5DUmzKfy3uhCceaE1t/WTACRsy5QzVcAUnkoHtdsCIIwt8ivtkP0Uvr0u1A0gh61cjQ+z0/3nR1h6NGiBvCo4In466IfBfUZAB2z2Et/LNMjufwbdkEuYTmzJ61n2sr3xA2Rs+Xr1kzpLcTLzm1mRBowOdQpDLi31RPWTB52qiN6zeZEcS3qnLUI1vIL2fQ2EvyzgnaIOAwqhg3TYS49NFWANjsvWT8LDzT3DIggnFUTUPG13LYTvQHpSkqXiN9VFJTq9vs4WcsRSGHYWoXPstOPBBvzrywJ+vc9zccbfjGXtYlY/UvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5YAWre+mjKGg6jz6Q2VsxijiNSW0+XC+p+lXDjIFAs=;
 b=jQnQpA+M5i5vIobe0TTHqLlWrE639u/5AVRGzD9cigIRP+4AbHXje9yLjrd2aGjfI2/fxlmrb0wdE4fORpKDrXC3KsEfZq5PspPfGTD/CPPiNuD/oTOj1zBnztM9C47s6dE8TtaFgDhPQ3EVUdhiQ9GV8MNtGTZMD28HcKLVgsnhnlIdKkbg2tegifji9eLs2luat3CiScBlCfjRf83CjpcPWqbxloQDatqKNWqYU/if4hn7jzE6k0eik3f7KwnMsXtDwtfJd4vp/a3oBsjdA5FaLDmBgSrcWhX/r9yqOYv3+eFaCfcUAoJuVYpOaJKYpE6ABroRVk6FlloQEwT9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5YAWre+mjKGg6jz6Q2VsxijiNSW0+XC+p+lXDjIFAs=;
 b=uZK1hw8oZ1Gz232BCokSqLLnMYIB3Ie+3QvfahB2CC66ldYqjIVl/FKYxQSdF8oUt/vudvDCwRhXvt/zfiRIOgy8j8L9i4RjoYsDxyf5BYGXj0AdtnawAUFNq4tE5hNxSzYHarTJzBn0YSEnSrXgWOc5fKUS80aVkYo8trXFcxA=
Received: from BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::35)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 09:12:20 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::d8) by BLAP220CA0030.outlook.office365.com
 (2603:10b6:208:32c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 09:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:12:19 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:12:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 12/15] iommu/amd: Add support for enable/disable IOPF
Date: Mon, 11 Mar 2024 09:08:40 +0000
Message-ID: <20240311090843.133455-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 133b3b35-fd76-43a1-5a4e-08dc41ab5ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7uQfV7imVUuf2DsG/jxyntyidr9lbY+DaFvZyG03UTrERiyZY4ckF4ypLfUFbWUYa9FE80/4jrtwFxPXEDH1LIv7yaZzEJwSdpY+f7MntqyN1tZmn/9F7LJzuPr41H+BJFTFaQSNDmxJ5AyHpGtRvIqoihp9oyIsBTplAUdeuBgzLVU4L7UXsJS3C7bibOcBGJLzGvFnlfatX7D6XD/icTteyEtqXlnWR0LcnATk91Xzs+dTFjDRjcR9P1Hs7PZuSioEOibSy6iTslPUve2uutWXYB9mlliDKyXQtnWDWCSCqtZelPGZHTTBPIAp8f248mtlOaWXi6N9i4chaSbvJ+5feAE9OcHhxW899T/a6mjE24SyyouPTA0DaXd962873pPjG8uIQS/miNCBG64Pk0P24F+Cq01IPyhGidWo8IqArf7e+nwyl9uLprfQw7ANHXp33lfvMZgDTVovWNGw95dc8/gGVjXXWiGHbn3smXHyM6PJpBBz5s8mr5Q2v2Q3UwnFn6Xn4c10fxlNWbfBOK8soR2beBUOXxCp9O+JVj7SywZnS/PViLcCb2Ti93YjnloxGEYTVS0FD9eguQ7nH+mBS10utxjIziZixSsmeOnBNP9xOhNKEOSpjLcMAZtRMO3BSCJp9OWVSow9rkDKJtKIpRTdXgL/WAp/0gsV1IM432w1nZjKhNO29OYUuP+MoE/qqKt0N6qF3G5nDiWcP00ivSFt0V+RE4drdf1PAqzq0U8efNBF/JpT2dHO7Zdm
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:12:19.9754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 133b3b35-fd76-43a1-5a4e-08dc41ab5ae9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

Return success from enable_feature(IOPF) path as this interface is going
away. Instead we will enable/disable IOPF support in attach/detach device
path.

In attach device path, if device is capable of PRI, then we will add it to
per IOMMU IOPF queue and enable PPR support in IOMMU. Also it will
attach device to domain even if it fails to enable PRI or add device to
IOPF queue as device can continue to work without PRI support.

In detach device patch it follows following sequence:
  - Flush the queue for the given device
  - Disable PPR support in DTE[devid]
  - Remove device from IOPF queue
  - Disable device PRI

Also add IOMMU_IOPF as dependency to AMD_IOMMU driver.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Kconfig     |  1 +
 drivers/iommu/amd/amd_iommu.h |  4 ++++
 drivers/iommu/amd/iommu.c     | 39 ++++++++++++++++++++++++++-------
 drivers/iommu/amd/ppr.c       | 41 +++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 443b2c13c37b..d563f6d496ca 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,6 +10,7 @@ config AMD_IOMMU
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
+	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8254b7479316..3eaae50dc66d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -51,6 +51,10 @@ int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
 void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 			     struct iommu_page_response *resp);
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu,
+			      struct iommu_dev_data *dev_data);
+void amd_iommu_iopf_remove_device(struct amd_iommu *iommu,
+				  struct iommu_dev_data *dev_data);
 
 /* GCR3 setup */
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6a2872b45dde..92a2df8cbdad 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2054,8 +2054,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		if (ret)
 			return ret;
 
-		if (pdev)
+		if (pdev) {
 			pdev_enable_caps(pdev);
+
+			/*
+			 * Device can continue to function even if IOPF
+			 * enablement failed. Hence in error path just
+			 * disable device PRI support.
+			 */
+			if (amd_iommu_iopf_add_device(iommu, dev_data))
+				pdev_disable_cap_pri(pdev);
+		}
 	} else if (pdev) {
 		pdev_enable_cap_ats(pdev);
 	}
@@ -2127,12 +2136,11 @@ static int attach_device(struct device *dev,
  */
 static void detach_device(struct device *dev)
 {
-	struct protection_domain *domain;
-	struct iommu_dev_data *dev_data;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct protection_domain *domain = dev_data->domain;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	unsigned long flags;
-
-	dev_data = dev_iommu_priv_get(dev);
-	domain   = dev_data->domain;
+	bool ppr = dev_data->ppr;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
@@ -2147,8 +2155,19 @@ static void detach_device(struct device *dev)
 	if (WARN_ON(!dev_data->domain))
 		goto out;
 
+	if (ppr) {
+		iopf_queue_flush_dev(dev);
+
+		/* Updated here so that it gets reflected in DTE */
+		dev_data->ppr = false;
+	}
+
 	do_detach(dev_data);
 
+	/* Remove IOPF handler */
+	if (ppr)
+		amd_iommu_iopf_remove_device(iommu, dev_data);
+
 	if (dev_is_pci(dev))
 		pdev_disable_caps(to_pci_dev(dev));
 
@@ -2811,9 +2830,11 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 static int amd_iommu_dev_enable_feature(struct device *dev,
 					enum iommu_dev_features feat)
 {
-	int ret;
+	int ret = 0;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2824,9 +2845,11 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 static int amd_iommu_dev_disable_feature(struct device *dev,
 					 enum iommu_dev_features feat)
 {
-	int ret;
+	int ret = 0;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 46d0ad13ac08..dca4bf7f704e 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -241,3 +241,44 @@ void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 {
 	amd_iommu_complete_ppr(dev, resp->pasid, resp->code, resp->grpid);
 }
+
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu,
+			      struct iommu_dev_data *dev_data)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	if (!dev_data->pri_enabled)
+		return ret;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	if (!iommu->iopf_queue) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = iopf_queue_add_device(iommu->iopf_queue, dev_data->dev);
+	if (ret)
+		goto out_unlock;
+
+	dev_data->ppr = true;
+
+out_unlock:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+/* Its assumed that caller has verified that device was added to iopf queue */
+void amd_iommu_iopf_remove_device(struct amd_iommu *iommu,
+				  struct iommu_dev_data *dev_data)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	iopf_queue_remove_device(iommu->iopf_queue, dev_data->dev);
+	dev_data->ppr = false;
+
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+}
-- 
2.31.1

