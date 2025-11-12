Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C7234CFC4
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971986; cv=fail; b=CU5iP8ytObensrTkNHiK99acf44uFB/QQH5QeYsx6e3FnZChsF8faHvfHE9yZGMXYX0qc9QHGfl9wdhnIPaRc5GV+Gs2Vr2g/fqqxYORNwB3TYXgMZS6JjMcw0Xh/3CunltxeuzZhdtEBe7aeXWFf+m55e6qTgrwpyCFowPUtXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971986; c=relaxed/simple;
	bh=7oFwdt13O/qo0sOdzvODVXLttcoNse5K1A7UbIT6WnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jp5TQXKSZL6DYkh3falDmqojnYxoOWU048ga93SBiDFQHH2sXwXXAsDSQwekupwZ4FmXXuoxIduEYIqE1hfFT565pc8YX+/aBZvSAN3cY8AJ3pue0VVZ5hNEmdtCai7WvG1re3SWtrMZ64FFLCMeKLUly3wdcWcGj+FC4lX58Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LIyCbjcv; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LIyCbjcv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrBam4x7k2eDeaBxYM6qAt2XEYYI+obKWuIE85s6IpqAcPBV/RBqPsV4Ix4+XAvnjL0GSpXBNR/sI+S/11dXq3vK6tZNBvDiQtfiFewlV2v5Kc+n+JIas9blcgxSjdeI57+BZwsIb1doiPR6Jwrm6clWDwDtPSRz6JNf4cxxo4lcKMlVYU+cdERVwEUixT+kU7J5MivOfNn5GfNTuPZlbjwxVeFdCinYtQQi46/qWHpD7LhJRsIZBvFfY/RpeD0M5Vg+VQatrVXLpCWM2HlL4UrP6THfJZcSp3wMSTCIsDLKz7Khy43NXofQ+SWzudjKQsm6x+U0id0MLqMqE9iZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C2h3AT7oGZm5S1CgfTGl3UCWoSPW3OdWB2YVlFGx1E=;
 b=nR7yUZ3T0htKCF6g45NQV+OP8HNpJ+3AwuyJ3fU6YsYVwZqzUVScbZvVa9IZUF1vcAAhVbLA0LgZIx9eWMhqpQqw8x/5FM/unkOBTrAvvUY7Nl5u8t6wVzNIetfY34c9Qdyq0TFIwV/2Vul7i3qVwgZHgoKsx4pIFP41rtPm0SBmaW/K21MpQVhItCneFf4XWnwoxUgpVICrF0oMXfsTYh0eHu6xzi1RY2WpBe37s4KI5M/CP6pN+KuKo47VufihuxoxEaonyGLVWu/Rw5HrLkc9uCuuABb2mTbAyGwaItEg66bXNk5OtTkeSwH75fPv7i/W8KszfUSwx+GAuwrwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C2h3AT7oGZm5S1CgfTGl3UCWoSPW3OdWB2YVlFGx1E=;
 b=LIyCbjcvh68O67OCbEgwteB7ZBubUIhDzlUgLhHJzrrXj4U/cy7Ajmkt+op7F+0QUu9Ts2WtEY1Fz+1AuWyYTbgnAQ2NlPnOq4A4DVx+l53VQrnOMCjnplWII3OQUmcYjpJONlQe53nEMNi8Jq0u7zFmMkNS7X0/vVoX3qjsqsw=
Received: from BN9PR03CA0933.namprd03.prod.outlook.com (2603:10b6:408:108::8)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 18:26:18 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::db) by BN9PR03CA0933.outlook.office365.com
 (2603:10b6:408:108::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Wed,
 12 Nov 2025 18:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:26:17 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:26:12 -0800
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 09/14] iommu/amd: Introduce struct amd_iommu_viommu
Date: Wed, 12 Nov 2025 18:25:01 +0000
Message-ID: <20251112182506.7165-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 39cae984-558f-4cc6-43a2-08de2218f87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1pd1bSvkWNB9PgQ4hEbQsW2KWIE7k1v//0bNXIANA/tdrVju4sQWUM4WNW22?=
 =?us-ascii?Q?ZsATZzQ1ip97SAOWJ3JT+mY+BNr179sdGnThmND3gFboY1NLnIZxV1hZdr+h?=
 =?us-ascii?Q?6U34KqV7i9708IfKywixTyC9sYjbp1YDnt0BnMhMl2qVYt6MEsH2bGVHKMKn?=
 =?us-ascii?Q?hsEQB9/CgoEuYG5X7lfwk5JRAWwJqxmRPXsy5he06iU0LuECxGD6WdQYBHKX?=
 =?us-ascii?Q?AOKJ+9bheedrB+GRm3D05LTbrKlf6GCipfJD6dQBxei/HtUpujY/7avQuCBp?=
 =?us-ascii?Q?/W9umvtldoqvVBYHLBnCBiPpS9LxopkLUzq2xN5w0yu+0AatbfUs2B7r/qVn?=
 =?us-ascii?Q?WHlANVZRprwL94AvOoyMxiLHnBFzHvJNnwIpSeA09oyjgZGOO8/T9/hz3qyz?=
 =?us-ascii?Q?6icbqf+0SZz+3/QGCI8Z9lm2e1F6l5wlQl83oGtyw1bh7BaW7So5QPz2PwRB?=
 =?us-ascii?Q?2ayHGEiBZKluZhpZpcjyKpQIAMy4KxndGnzTGWDoKOoCS2cslnolWDEutiBO?=
 =?us-ascii?Q?DBpw38P9/a3vF0pGTHLfENCOyb44ASJ/shzUpAubqbx/QZG0cdYGvEo97BUA?=
 =?us-ascii?Q?NKgUNGZZ1TGs0oYgRhpPFjJukJQNiC3/SRF1zKMMGjxGKzbduxCY0HEjYOXj?=
 =?us-ascii?Q?J/UUr0q5lJi4peppjQt1gNZAFx43nHueeOtbh+qmJiNNoiLmBAo67V47KD8X?=
 =?us-ascii?Q?UCq0my6Ua/ODsHHumRLjXxccXSnD3qItHF/WxSyuvMUKzvTAXqFdrck9+gsL?=
 =?us-ascii?Q?RjFGyt2PhuN2N4HSR9DJVOcbrULjSTou4nw3MIBhsgSJh4JC6YQKWwdRAQTQ?=
 =?us-ascii?Q?06IwH0qMY18EGZJoEdJQ75rhMCDXxs9pMxjrj05hcFsC1MXkyh5KJaBa5A1q?=
 =?us-ascii?Q?vXhxGBeAkGbSGwUar6IowGOZqCuWUDBMmB5MsCp6dZeM2MpAzQkwC66LyUGO?=
 =?us-ascii?Q?haNxFo3Oj7UveN3ibNyu0CApQmqh2TbwdRV3H/UV4qyNTyuBFI57vPjMgxbo?=
 =?us-ascii?Q?kTmzA7GeQX33+acVJpn9XkCcajD4LDoyTB2V+gTfde+71mY/AHSKdGLzTmMa?=
 =?us-ascii?Q?IbvT7a5c3foLvV6UpE3Q5f+bIDNyjMFQQnClATsda9E8AYk68ikTwJ3RePpP?=
 =?us-ascii?Q?Vpgo8x99gDZW0icuZYIRsIgGYvD9te/0jVG/CCurOhpG68CgxMo6cRyymC8l?=
 =?us-ascii?Q?w/n6fveycRIDZJ7rPW9ckKQtVgE+aW/tnvkeOrR7TK5dYu73yl52HUqSE1Gy?=
 =?us-ascii?Q?IVo+Jd7LV2NhN5Q5AHUJa91C7H67yOPX/ZI9bztQJP1o6TNIM4DXeUzf06Fe?=
 =?us-ascii?Q?WuB//qDzXgIChVZXW6MsgM2uLhfkx9R7iRt3MPB2AcI3z4VznChLQk66nZnL?=
 =?us-ascii?Q?rLgTXxNp9N73AvDp06J324vOjJqXeuq4MPfp8JnOpjwizXC9CGIH47Mci8a1?=
 =?us-ascii?Q?TjJEF8QUTEZHhAlJ2T6VDxYTDmBrb4XtExCn/FJXto1KNIVdisVX7BJo6GON?=
 =?us-ascii?Q?jS6nWwRmNbpTkd2zD0irdHe9uT20TswJxckOZXaDAKZLhEEJ8zhtn5b161hO?=
 =?us-ascii?Q?tufeDHgMyUv5qixFTk0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:26:17.6333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cae984-558f-4cc6-43a2-08de2218f87e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241

Which stores reference to nested parent domain assigned during the call to
struct iommu_ops.viommu_init(). Information in the nest parent is needed
when setting up the nested translation.

Note that the viommu initialization will be introduced in subsequent
commit.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++++++
 drivers/iommu/amd/iommu.c           |  2 ++
 drivers/iommu/amd/iommufd.c         | 16 ++++++++++++++++
 drivers/iommu/amd/iommufd.h         |  5 +++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d13a50fc209b..446be08c88c8 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
+#include <linux/iommufd.h>
 #include <linux/irqreturn.h>
 #include <linux/generic_pt/iommu.h>
 
@@ -490,6 +491,11 @@ struct pdom_iommu_info {
 	u32 refcnt;	/* Count of attached dev/pasid per domain/IOMMU */
 };
 
+struct amd_iommu_viommu {
+	struct iommufd_viommu core;
+	struct protection_domain *parent; /* nest parent domain for this viommu */
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e03aa8d946b3..724b8723b836 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3078,6 +3078,8 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.def_domain_type = amd_iommu_def_domain_type,
 	.page_response = amd_iommu_page_response,
+	.get_viommu_size = amd_iommufd_get_viommu_size,
+	.viommu_init = amd_iommufd_viommu_init,
 };
 
 #ifdef CONFIG_IRQ_REMAP
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 72eaaa923d04..eb6119bdcf12 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -29,3 +29,19 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
 
 	return hwinfo;
 }
+
+size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
+{
+	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
+}
+
+int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
+			    const struct iommu_user_data *user_data)
+{
+	struct protection_domain *pdom = to_pdomain(parent);
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+
+	aviommu->parent = pdom;
+
+	return 0;
+}
diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
index f880be80a30d..f05aad495b5b 100644
--- a/drivers/iommu/amd/iommufd.h
+++ b/drivers/iommu/amd/iommufd.h
@@ -8,8 +8,13 @@
 
 #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
 void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
+size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type);
+int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
+			    const struct iommu_user_data *user_data);
 #else
 #define amd_iommufd_hw_info NULL
+#define amd_iommufd_viommu_init NULL
+#define amd_iommufd_get_viommu_size NULL
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_IOMMUFD_H */
-- 
2.34.1

