Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139FB6BB26
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4whsVjY9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHEK9sRiAohyIjuHqA+R8nl7w+H5gxEswdDkBbc5xqMWsaY8SFLCS+TPfmDRWeUnIwaq7LO8rY3LXfE+LPM89XqseJMp0Pct9Z9vzbudGt0DspxIt5rhiGXAJ38vdFoE3BhNQSGJ0HsR0H2JQsdALDwQrU1dTUbmU47Y6/r4+cQooHz1ILg4/4WcLjw3YGD+3Yhs0/V/O6gs6VEZbrS82/RL+0UwUygFGt63niZ1GxsCJ5p8LzSke9jJm0RyNUsJ4ug7nwKZuUWp0jDTe8RdYa/5Mge+KlsHbRFbtvj4+DPntBrNMj+zJC/yYIgW0gF5V1+0iEyNvyAB26Uf3shPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1whx7Nd98a5YJ/eH+6v9E87f82Ljrsdr3jU/cNf5BPc=;
 b=ZgB0VUJ6nUHQCKbaijC6ADn9cSrSpfMMLE9IesfSrXAUQZekJfvhaT/okD9Z9i4YAZEM8M/psaL6yz3XIsuGjHd9789lojkH8jxf68TSlf6lmCyoYPGX0AlevOJZGZKPQRmS7Sol7IT+ouvAHmgl5rfGqlJRh4LAcwIzSNzb7JuH4zLLLFjeAW3+Wer8KfgD7DBs5WQP+gIQGetGs2G/MvCxTq4ZY4nIzs5VUxzcDQ8FLz43cvDqDrF6i4KApArHuQiik7PKj4/+D1GVjwAlkZZxEgj54HDh2WQ/IsPpe4TS5/ZMZvTNOSl2HvhjWgoCqmDYrMUD9Naw0NnKWYZWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1whx7Nd98a5YJ/eH+6v9E87f82Ljrsdr3jU/cNf5BPc=;
 b=4whsVjY9g3XuccvER1rzY8NAY3Ux2Q8+4mCVEVm+lnZrGPz0JPQE8IYpQGjdcz+vWSuhc0VJCnCtPHTDuEFCmLIiXmJxTo9jBZtpuQQYAN/+dmjQnJqwPzMCmc8UghzPLaToF4XRDIt3vA2wLwZnpWH2O/kiwrXEpshhwCxw0t8=
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 11:19:38 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::c3) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 11:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:19:37 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:19:33 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 11/14] iommu/amd: Add GCR3 [un]initialization function
Date: Thu, 21 Dec 2023 11:15:55 +0000
Message-ID: <20231221111558.64652-12-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1d95b3-2aa7-4d00-e729-08dc0216b7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WWzBjmL+PmX+F9Rjh5YAHiei91A+MqlcpvFKk87r+s8qXg5fZTfc99O8OVy+GAq4gLU0Ulmq+8k4dEGyTjHaJwr37VdxqLR1RSwH7y734echKryq6SHVg5oh0UlIgnDnAO4zipQRaG7sBpVX0lrIn5n18ZDTKLnY3LzKJLjmZo+jfpCHlOWYQESl69GapGr7wTI76RGOOnVacty/DqUdA3vXhIVQvXRKfG7TUG705YK5//js3sDh/iXUk9F7GrNy9F/tOpAfPXQ04dlgTvzmKWvrNyatJ6AjvwRqsiBJjFJgtOxCehdAf7bzM7WMVIJrTKmhBtMR/ANVCYT2ijg4cDaqPcR8WJ8PTHmxb3vm6lPqFLoPhLMDi1TIdKDwIcMH9qz3gB/08Znr0UEV4iYCORCelgXmlAO/XMUqPhduf7Fh1WRHJDQTF0TTWSTInhjBvyJi4VAAHjuDM97PMHZr8Re9GETCjsOyh12PaIy0OsF2yUzxKtFG0uqEqTiXDR5GAZlPilRdfbiu4lK0k8Qcyjm8RuE29znsWJieCH14+E0HV75qT3B7Dd+SaKTDCjtYsrRfH9GEStKpTPmiRo6KZPi7yazinbRSrWoK7x69G7a82fZAwas2rADz5RtwckFaYvQK3LKA8Yv+BRMa8qEnxJBO8zl25lwdEPwlIclvQJFxsx/02Mf6Ie1oFJSBiENGmntxuAceuUgVc1EUWI8D/75fuXUn/aB0CVO8YrBo5fQSvLs30VxvqEZXzudt8Q0Fr46Yw8lKd0oQLlu0if+rxg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(70586007)(70206006)(110136005)(54906003)(4326008)(8936002)(316002)(8676002)(44832011)(40460700003)(41300700001)(81166007)(336012)(426003)(47076005)(83380400001)(26005)(1076003)(2616005)(82740400003)(16526019)(5660300002)(86362001)(36756003)(356005)(6666004)(2906002)(7696005)(36860700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:19:37.5776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1d95b3-2aa7-4d00-e729-08dc0216b7e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

These functions are used in PASID to device bind path. In this path
it checks whether device GCR3 table is setup or not. If not it will
setup GCR3 table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     | 44 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index aed512c10052..7bc6d530c9a6 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -44,7 +44,10 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
+/* SVA/PASID */
 bool amd_iommu_pasid_supported(void);
+int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids);
+void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
 
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ec30cee33f3b..12ac6968c136 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -93,6 +93,11 @@ static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
 }
 
+static inline bool pdom_is_in_pt_mode(struct protection_domain *pdom)
+{
+	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
+}
+
 /*
  * Allocate per device domain ID when using V2 page table
  */
@@ -1862,6 +1867,45 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids)
+{
+	struct protection_domain *pdom = dev_data->domain;
+	int ret = 0;
+
+	lockdep_assert_held(&dev_data->lock);
+
+	/*
+	 * We cannot support PASID w/ existing v1 page table in the same domain
+	 * since it will be nested. However, existing domain w/ v2 page table
+	 * can be used for PASID.
+	 */
+	if (!pdom_is_v2_pgtbl_mode(pdom) && !pdom_is_in_pt_mode(pdom))
+		return -EOPNOTSUPP;
+
+	/* Allocate GCR3 table */
+	if (pdom_is_in_pt_mode(pdom) && dev_data->gcr3_info.gcr3_tbl == NULL) {
+		ret = setup_gcr3_table(dev_data, pasids);
+
+		/* Update device table */
+		amd_iommu_dev_update_dte(dev_data, true);
+	}
+
+	return ret;
+}
+
+void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data)
+{
+	lockdep_assert_held(&dev_data->lock);
+
+	/* Free GCR3 table */
+	if (pdom_is_in_pt_mode(dev_data->domain)) {
+		free_gcr3_table(dev_data);
+
+		/* Update device table */
+		amd_iommu_dev_update_dte(dev_data, true);
+	}
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
-- 
2.31.1

