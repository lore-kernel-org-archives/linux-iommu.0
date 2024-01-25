Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BF45026
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184931; cv=fail; b=AWAOuWq5TrZ3DQ0XJKEjjUeTIqXQgYhkJlRUqn7mwLPGx9Y0a3csVyuvqqOWsOuIZabgqAPUf3GsYDTW1B4Cq/tGet7qn9PzIQ5Q4mSHOiH6D0EkxNX7ByEBm9pbL8RwFcv+XGabo2UNp+9WwIQfaX/agpoBmzp2OUInJ/DKRk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184931; c=relaxed/simple;
	bh=24GJcz5wGbu0LiSvFPOrc2Xp7bdTkMOMV/PCaNXQ7mY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eB+MI2GP3gYRu/quyZyXQFU2cVAEr0WozkqIsqOAJ88K67ASMobOfZfWgF7CQ3NIbcxnPNC/dsuB+waK7rN1DvSDvKl8H3NoTWq0DDhPE9WR7az3O1PhVN0SeRRKXFRq/3oZT020oLemetm1/uwPd9jPxtL11kFpiuZmRzfBJdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tv4We29e; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tv4We29e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mavrDuCPjcNjpHrCGkUjy3Rx2I2a8BuGTWwuXd1tZbNQ9ApDrKhX980wjOeS/d44DSdhshhhf+5Tat2eUwTiIEsmniA8ZNyheOSlJI6Ny5AVXF+C78tF5CYOmIlK2C3ar8jojoUR9HvkaC9tgAhl1KOc7/orVs3eMi3zGtKtFkM6BWwjpIq5qmrXbvPSuolDZZO6ljWqb8PXCVeh+o6NnkRqAyw8lRYu6IvREqVDczJpOjkhN3suXdhxCtyNQO43VPWSQ9LDWfAcUovtH1E2R+LPV79kYDtl15HZp0u7DHl3KsqYzxwj4QxwHLzBzkTFD6Ku2NVmbu4lbHFZrqxSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSmQw84fLQIQQzGSKAMFUSMInLeGHb78R4Pl4EJC/t8=;
 b=oWAY+I8erQzRtKVwfc7C/5ku25/8bi6OkjkEoq43Nak5przziAD+HIwXCUgYUNIjLkWL2NOqtpO6ZbLgpupi0+JnuPFQVRcX2HDZ1ZTr/krNl5L66gPfBDmXetwgo4/r+aLFUcOXmJpSwN9pjzS+zy03x7KF/PIdFgY0tn9R8Kdm2tVg/6cSlwVbh3I3hTGXugvjFQLiJCLG/ng6HLCDz8mzqa96d1f73Uq/wjxalrdz37fjzrIZcrmxKbld/mokxsiiCbhrVAw6btvCErO4lJf1+b7uoLfCuTAUaCv664IRPRW7kSKvhqOe1/kh5teNP1F1QfdwpRjR8Ic8bBvl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSmQw84fLQIQQzGSKAMFUSMInLeGHb78R4Pl4EJC/t8=;
 b=Tv4We29e1GHGtJKgbSAxMwkNhLgtj0dB+w8Nur+S5asIIuMSiEiHPjXyiXYv359nuOwlf+sU9BedzcOIACPWJmn8fDTfSs1EtidI8Nolaj4gZ1hSKUBNtGs4YGSphq6dBE/lL9BnaiE/vpRUqW7hUCj4/Yg7YjbCafU5VFGNQ9Y=
Received: from BY5PR13CA0033.namprd13.prod.outlook.com (2603:10b6:a03:180::46)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 12:15:26 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::be) by BY5PR13CA0033.outlook.office365.com
 (2603:10b6:a03:180::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Thu, 25 Jan 2024 12:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 12:15:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:15:21 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 07/17] iommu/amd: Add support for device based TLB invalidation
Date: Thu, 25 Jan 2024 12:11:25 +0000
Message-ID: <20240125121135.8217-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: f5567906-68b8-4896-ae3f-08dc1d9f5056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wgbuL3XB+hwlHAKwa1sjk8B/CZsEGM01og5TxED2VCtQBkL0mbjHJ2p5rlZcOBKsGqh0YswMGg7zO2cMoECdeOUS3gXqKfQISBrnM6dBU31mb5h8OvOE8J+8qYqgu9x4UsBtO8w1FiEYrL6pO53Ip9M3KKyjvGQ67cLILQyC4SAJdZ6BbqCBrAMs3U2aqeFZKB0loi5ijc1dek6WBaPUaz0AJIuh1b93k20JLatXA+oJpiWL+BjAPcNEG5Z25Bc6GdKEO7XtGH1H/MCMiUql3hlhH2h6sTeKZOFIr2lEje46BZNVej8w2JmeOlkZiS4GaODgT4/FzVtFzPdprY+3RGfKYZ2ZlNw28aFiyUuuOlSVfMTZsxSli7t6rdNIx3teEtgUnWkUVR4GX97s0ed+BjFFYpcxL9MzTmjqbkgeHuy233I4+or+xUwVuILLzFmul8aCguerADrGUNNz/h1Uy+cuPhezks008IrvMuABglM2a8fzU7+HuacHqQgtpFd4PlzxMA9Px0mO27sXbJmafQYJWSxQtyS8aQTjHGNOBYlIPyyKboIcINE1KegSBLr9I0AOWri1I6hdvEcoXjt97ZNnX25NDoqiWS5IiO7KFt2qHghosrBX8WWgos3bkzzwRBsVjNQw0nNC56T/bJD69s+/LU7MnXe+g1sjCmO4I06CNEAmIVZkS1iYs4eJ5l4oPgyQFbyTHWhfT1w5/reKKFULTho9CBJLZ4JRsdA+iWCya4v8nFVHd0a/QNOWyN8TjKDZHcjFSf476HWjMJuHDQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(426003)(336012)(40480700001)(44832011)(478600001)(47076005)(1076003)(7696005)(16526019)(2616005)(82740400003)(26005)(83380400001)(36860700001)(81166007)(356005)(316002)(110136005)(70586007)(54906003)(70206006)(2906002)(86362001)(41300700001)(36756003)(8676002)(8936002)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:15:26.1506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5567906-68b8-4896-ae3f-08dc1d9f5056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166

Add support to invalidate TLB/IOTLB for the given device.

These functions will be used in subsequent patches where we will
introduce per device GCR3 table and SVA support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  5 +++++
 drivers/iommu/amd/iommu.c     | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 31275bc6e9e4..5e4614dbd435 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -63,6 +63,11 @@ void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
+void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
+				     ioasid_t pasid, u64 address, size_t size);
+void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
+				   ioasid_t pasid);
+
 int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
 int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 			      unsigned long cr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dac04585c7fc..7fef4d7ed4ee 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1542,6 +1542,29 @@ static void amd_iommu_domain_flush_all(struct protection_domain *domain)
 				     CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
+void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
+				     ioasid_t pasid, u64 address, size_t size)
+{
+	struct iommu_cmd cmd;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
+	build_inv_iommu_pages(&cmd, address, size,
+			      dev_data->domain->id, pasid, true);
+	iommu_queue_command(iommu, &cmd);
+
+	if (dev_data->ats_enabled)
+		device_flush_iotlb(dev_data, address, size, pasid, true);
+
+	iommu_completion_wait(iommu);
+}
+
+void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
+				   ioasid_t pasid)
+{
+	amd_iommu_dev_flush_pasid_pages(dev_data, 0,
+					CMD_INV_IOMMU_ALL_PAGES_ADDRESS, pasid);
+}
+
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
 {
 	int i;
-- 
2.31.1

