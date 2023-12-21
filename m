Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239E6ABB3
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KCsMpr7f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giYjqhBtqoVjSKIN3EFIvLHNKpylKJkpMbfD3ymbiHkb7h5Ry+pdiyFEKIdzeujTcXoXCyty7+GMGPaT+A/Kf363J49Nb8DB88vs9hvLUxrpGCuol0tAQC2C8peGzvRuc7Y4ew5Zji7ftJ/Ya8NC/exZXwRAOzA4pcK4wKq8gXH+EHgzgvtZ4k5/D3isQ9gQxc96uHIo8AKueRyyLON+wMH9Bd09PDzM8Na/nXIKQdNA79p9/MJbsZUk1oKGlkVHqnq0gdfdu53nE+WLZOfYSdMiW36no+BwqWQEOevFVlD7w2PT87jwDuSx5yPT2IMlzkeMuWWI6IBo1Gg5s4ggrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iTdFMnF9nN3P0pcfKQBJGArMstNZW6gFwkzPom0bRk=;
 b=bsaLgYCs8kKUL5hI9PgyxrznEwI6/QKWlNqDjciApwjK57y6v7cklWcELKDB1kPRa6sjC+f72JJ37NXsxmVdyvq6HRmt0THyqYAuYv9phO1TY0W46fVxvighMdSOmS5rJpnY6XKu/zwjBCWEvCiChNNBwQNUFZz/KvuNAB8XfISf/w+9hWBbdihREqMRCaEtHfKuKAW6JCm860MgOjdxQWFldalgTVd6dCdvHj1yDOR3ieYQJSNUcZNUgEmd2I+civGDvxDV+93hzOOV+bc7jR+3aYtTMF2Dn9mU7aFQ/Bfone05SHOs6U+8Aym0Y15JeCIdIlo6NED8fLy78GuA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iTdFMnF9nN3P0pcfKQBJGArMstNZW6gFwkzPom0bRk=;
 b=KCsMpr7f6D2CGafjpPp3c52q5MYuOIBC9Ll4AF+cOr9pUINI5zaaM8C2zqOTh/FzlWprG5xqc8KSv+nzqn6+6ePUYFyo0s54jUIqIDg8c6QZXp4sJYb2SdS4OBva8iS+SkL78X4iLMsm0SNNXTOyQuY+4haBMa1wcUEo79ung98=
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 11:18:29 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::7e) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 11:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:18:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:18:26 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 07/14] iommu/amd: Add support for page response
Date: Thu, 21 Dec 2023 11:15:51 +0000
Message-ID: <20231221111558.64652-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221111558.64652-1-vasant.hegde@amd.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM4PR12MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: ce35272f-fa50-4b9a-052e-08dc02168f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b36h2n5xkzAxLZPxes1tXJvoY53L58t4/h5c5U+M4eFMz9lsjtsFUMgQ3tYYUiLC8w3qifz3zQMX1pr3ElLfnwRxpztsKXQ1uR3dGDnegXR3Im1xFXw991Ge+7oJ8J+q/BC0GtywPkygCfZcMzxAE6QIoBPfo8HGDkS+bbDNUC3aUbsBX+t0zYfS+wX63D9kgjOSmGG1mb6bVlNCArMygp1jA+evWr1fr6EQaOF4BZF49w9z/DYWemgRLwOXCuB7uQdOFOT+g9YfZUdxIfMu52ugTi+ro2bOFrNn5FXjvqbpDt2ppwUbtc7hP0asWxi9Qi+mHKzosekYzMUh/6TX/zyO1RL+Ezf2S778uDd7r3ZO30xtS67We/6UyxqCNYDdP6bsSHZQ+1mIdRIu836OUy+2icp8MgRXuqM5bJtapC290jCRWpocrSNWpCzNq/CpTkix1UzOq73kyozsrutPEJvOT6IlzepDTIj+za8TpLgjWDaQsbN3I/05+0b1E/EMnvWI3ER/I0Q1vWIP3ukg08pLlJKpZjTG/2Jf/Bw7owqimnEu0o+3kO/XWlpECcHudG/khkBjotn1NAAT/7bklh7oU5ZZjOs2ddDE+VW4IrcUYarH6IyM/qAQnfK1El0GxGGRLfBnJu+67ogUmuW6MYOZzHJ2F2QpskcdvpYu2eh/eQRvepo/QuLuUIDLybQsM8VVgL5bMEtcou1vn1zJd2aySIGMo/MR7RFBDPmITjxbmbYjOimr9O+4qxPhDTr3eQpwTEKIe/x5yKIvhyaXgQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(2906002)(6666004)(86362001)(36756003)(356005)(7696005)(478600001)(36860700001)(26005)(83380400001)(47076005)(16526019)(82740400003)(2616005)(1076003)(336012)(426003)(81166007)(41300700001)(5660300002)(54906003)(110136005)(70586007)(70206006)(40480700001)(316002)(4326008)(8676002)(8936002)(40460700003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:18:29.2324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce35272f-fa50-4b9a-052e-08dc02168f2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This generates AMD IOMMU COMPLETE_PPR_REQUEST for the specified device
with the specified PRI Response Code.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     |  1 +
 drivers/iommu/amd/ppr.c       | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index cfbb4a332f6e..065f6b8ec183 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -49,6 +49,9 @@ bool amd_iommu_pasid_supported(void);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+int amd_iommu_page_response(struct device *dev,
+			    struct iopf_fault *evt,
+			    struct iommu_page_response *resp);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e4dae14c7d00..2913b7e701cb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2817,6 +2817,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
+	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 1eb0b737afb5..b1751eb495fd 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -148,3 +148,18 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
 
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 }
+
+int amd_iommu_page_response(struct device *dev,
+			    struct iopf_fault *evt,
+			    struct iommu_page_response *resp)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	pdev = to_pci_dev(dev);
+
+	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
+				      resp->grpid);
+}
-- 
2.31.1

