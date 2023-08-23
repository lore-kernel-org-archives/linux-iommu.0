Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E9C131
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9evdP5rx+/3b+DtYyDCIeutAt0BitjWnbqoe4r4YiY9vCcK+iHCzRofGuXpEp4I6P0ApETva5LqP1leLCAZx2TKuBcMmSa/FiOD8scF/j0rKnwoIp1DyOQ2wM6a8vnim95hCow6Qhsr0iJbHTzF2dnUflzaYdaowt6Qx9xual4FofTbSqybOxqqd131e4xszaavQFGcMGPenQD3gS95CToy6bpWF7EY326FbxSONn0wXeqK7by0Cht5qpO+Gr2GfzDUUUCabIX808y4lfPFofPE+JpZZRBMjk54vs5GbnEOUzjB+KPFNpWaHkxNc+dZiHDQ29B6ffFghDbBuLaC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFPjm9xABuzA47OiKsLXHs1nhCLI3OQNFLfDAhqZQmI=;
 b=lB/OQUPzjEh699vg7Kwrbja1a3q1YxVjvR6xVzB5bJfZnpUafEMhZkC1zNXasMgy+nUikqua+0c5QGQjykjCPqi9VdyXl+/N1P8SAzFFqHthV1UklhD0MSSwI6VIv4GT8hpXnwQMmPkXaQhEplTK0j+mHvfte9Z5okaPnatK8MMeyGry7181PMo1w5MZDJcNg5uM0WzjEwC8PVVtoKBIiv+fkl4RRqtKoNuGD+lGVpurJk+qNIAiiuz+2NQrRaLOsH1g+1aaVXVKVMajnk5+nvVj1yZVyUyutnuZH2tqqpOv1Rk+El8r25NTXE5mvQ2OHhd6bO2BHh3odfBhJVUDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFPjm9xABuzA47OiKsLXHs1nhCLI3OQNFLfDAhqZQmI=;
 b=C0ZbQOyIiBbrlQR5pm0KtJBnBcC9fbUTns8A76r8uxot6MIoNIAOwHMEoK8k7TzZvmvXfFBSIiPl6ZaTe1fOSOC2ouwAFbv6gPtI/8fl31xRLCSpcwWenvJNQDX3qWgseKtrNxvBkSYHh0RMOa3M53eatwMYABbXtPTjMFYTgCA=
Received: from DM6PR11CA0042.namprd11.prod.outlook.com (2603:10b6:5:14c::19)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 14:05:55 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::d) by DM6PR11CA0042.outlook.office365.com
 (2603:10b6:5:14c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 14:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 14:05:55 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 09:05:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH RESEND 04/10] iommu/amd: Add support to enable/disable SVA feature
Date: Wed, 23 Aug 2023 14:04:09 +0000
Message-ID: <20230823140415.729050-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823140415.729050-1-vasant.hegde@amd.com>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 393030d4-089e-4030-5f2f-08dba3e21151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g40COklFgkfCkybRaVyEEFLp2o7pT8S8M+ebU5yUM7m/m9i6WupX9rVM8bS7Gi3eWGQWR26IXgNh8sOGQcpeqrsN6Fup+cZ9VleMrFvvS6MDHsKQuU7f/Xlb/+ZTDbrP+Gjbpk7B70+kQxT1gHsNr8padTRZg7WL+gA+RKChX1dmWF6uI1TVJo5Amlox5vpW18ecc5a6h+Xs5pBpJdeaNJGhA2P6XFDwM0wtg1vt9nKSbjfNetOqPg/YN2Y6oHV49hUb2c28vBwD0hHip747guhwBF4WSCdL8+JPiVLG8ABR0vFdGxyZnnu5s/3VMiAfeYntsJqWpb+Ef+60ldNu99NKpggk91zg8pjEiXlTwJCJp/6jacAm3PBrhgwH8I2y7pWp4KkXNoUaBd3gIZIE26b6EHkt05DiySbV3c0ZF2aGqqz0Fx8KNqRt1t3u2Qau4E8vt328BCDku6pdz4zPAWbuHxZQq57V15QxqLqxr0LdoNvExOUCfbrBxU0AmhpaUUM10V1E3kMX9b++T2QPoJids9N4+oCrEu+RmGNcnqissqTIJhYp7PlCWW7OYLF2jLFRBmeEIjpF+AroqhUrvqzbeSyWt2en8e6k1pBNJ0EzF6zc2jkzx7w2ttAkZPOm9wwD7jq4gTDpplKFt5UfGz1kodexpdzhCKCCO0TGm1CkilYlKE8JZJeSb2jPCmIwdMAL/B3BgS1+hoTEbCaOESxkUMhmjOS3dCfgkqL5MqGxPjR+Vsl78L3RDXZw70Or48eAp5xLK7Fq9PJ3RIuyuw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(5660300002)(2616005)(7696005)(316002)(4326008)(8676002)(8936002)(54906003)(70586007)(70206006)(110136005)(40480700001)(41300700001)(26005)(1076003)(16526019)(336012)(426003)(44832011)(6666004)(478600001)(83380400001)(40460700003)(47076005)(36860700001)(86362001)(36756003)(2906002)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:05:55.0132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 393030d4-089e-4030-5f2f-08dba3e21151
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add support to enable/disable SVA feature. It will setup v2
page table mode with PASID and enables SVA.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 +++
 drivers/iommu/amd/iommu.c     | 63 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/sva.c       | 29 ++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6fdad7a54781..3f7ddf19ed72 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -46,6 +46,10 @@ bool amd_iommu_sva_supported(void);
 int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
 			    struct device *dev, ioasid_t pasid);
 void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+int amd_iommu_sva_enable(struct device *dev);
+int amd_iommu_sva_disable(struct device *dev);
+int amd_iommu_sva_gcr3_init(struct iommu_dev_data *dev_data, int pasids);
+int amd_iommu_sva_gcr3_uninit(struct iommu_dev_data *dev_data);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 46bb1bfdc322..4868eee4c4f9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2162,6 +2162,63 @@ static void protection_domain_free(struct protection_domain *domain)
 	kfree(domain);
 }
 
+/*******************************
+ * SVA-related helper functions
+ */
+static inline bool pdom_is_pt_mode(struct protection_domain *pdom)
+{
+	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
+}
+
+static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
+{
+	return (pdom->iop.pgd != NULL);
+}
+
+int amd_iommu_sva_gcr3_init(struct iommu_dev_data *dev_data, int pasids)
+{
+	struct protection_domain *pdom = dev_data->domain;
+	unsigned long flags;
+	int ret = 0;
+
+	/*
+	 * We cannot support SVA w/ existing v1 page table in the same domain
+	 * since it will be nested. However, existing domain w/ v2 pagetable
+	 * can be used for SVA.
+	 */
+	if (pdom->pd_mode == PD_MODE_V1)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&dev_data->lock, flags);
+
+	/* Allocate GCR3 table */
+	if (pdom_is_pt_mode(dev_data->domain))
+		ret = setup_gcr3_table(dev_data, pasids);
+
+	spin_unlock_irqrestore(&dev_data->lock, flags);
+	return ret;
+}
+
+int amd_iommu_sva_gcr3_uninit(struct iommu_dev_data *dev_data)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev_data->lock, flags);
+
+	if (gcr3_info->pasid_cnt) {
+		spin_unlock_irqrestore(&dev_data->lock, flags);
+		return -EBUSY;
+	}
+
+	/* Free GCR3 table */
+	if (pdom_is_pt_mode(dev_data->domain))
+		free_gcr3_table(dev_data);
+
+	spin_unlock_irqrestore(&dev_data->lock, flags);
+	return 0;
+}
+
 static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 {
 	u64 *pt_root = NULL;
@@ -2578,6 +2635,9 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 	int ret;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		ret = amd_iommu_sva_enable(dev);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2591,6 +2651,9 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 	int ret;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		ret = amd_iommu_sva_disable(dev);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iommu/amd/sva.c b/drivers/iommu/amd/sva.c
index c7c7e7cb5414..b4cc5b854753 100644
--- a/drivers/iommu/amd/sva.c
+++ b/drivers/iommu/amd/sva.c
@@ -297,3 +297,32 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		break;
 	}
 }
+
+int amd_iommu_sva_enable(struct device *dev)
+{
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!pdev || !iommu || !dev_data)
+		return -EINVAL;
+
+	if (!amd_iommu_sva_supported())
+		return -ENODEV;
+
+	if (!dev_data->pasid_enabled)
+		return -EINVAL;
+
+	return amd_iommu_sva_gcr3_init(dev_data, dev->iommu->max_pasids);
+}
+
+int amd_iommu_sva_disable(struct device *dev)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!iommu || !dev_data)
+		return -EINVAL;
+
+	return amd_iommu_sva_gcr3_uninit(dev_data);
+}
-- 
2.31.1

