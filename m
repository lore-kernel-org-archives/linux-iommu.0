Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD72D8372
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457371; cv=fail; b=d0R1SuuTS1TwL86jTlw8924cW90E9tTVgMSe3VN/HxcueAknhX/qP9WOeTSwExzCNZKrzYKXXn/F/QYvnp6+ZF2OcoLiLzx81Avt6FyScXqU3RNkJ1gk17u7XqZVPM1xerl0O4V3PflJh2lv5OLRX9UErwQTBO+bWOVyh6+rO6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457371; c=relaxed/simple;
	bh=3Quf0CxSMAlmWSULneDJVUR+/XGXV2VzvmrM1GNHF3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAVbekjHzYX9sR6hC45HFK/0WPwbE22HtKKO6wvv0Klw9BqJiljHqpmDEq+dOdyviRg9FOBexgGfs1GV/kkajw0UmAB6rDDsySbYCCzi39FSRQbn7dFO8nFoi1BXnSAsDwuuGwqXGfCTWuiKwb+p8bbpIzzfo7kSNm9IfwPP9Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C4i8mtIk; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C4i8mtIk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtKS5Jkj0my2hR6zgCBCZNZ0KnEdb+IY6ap0LseHy9Qo0c5rSlHHvQy34mZSGzY0jjI9sNxxBjqIgJLF954FBttN2N3B2wSNxUlmweEaari0NUMePbSBgVogCMbQCNh2nNN90mOKucDzIKTwarNjVpeHWEAqsIrXZktC3QIStD6vipFjNBef+BOU422L/TWxYEvpF6YIzwpvq/reun3wFTSvnPfedQ1Oj3pTcHzKsL2Wh4ioHZQn5qCFhw0jT4o+Gr1Y2rCacb5bZ/FMtZxfznv6DcnPZki6JLxEBb0yIWNVySUqSCv+7WQJrEktZHnuAClkzjz6q1WW3YnS6QXLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+kUiqxtWYTWg3e1BwLTtmQz5OY17FaFR6hrabfjsrc=;
 b=oiAnq72SLzI7GkahjGpFCTbQojnFM/DKcv9iNVWzw1DV6qnlE/cpNPumFUG5kWswp7GJuCbj1nBxljQlvJXCebTEmj24gKlQHhiPgAbHra5IgSNLoZ5VVyJBfximibnl5+kH7Ar/Ex2/Kp5EbD9ubl07lu2kcQio4AM0jDV4leeUxefMP6kwCnCOKEpwG+xHE+BkZ+6w/aBykP1VON65sNGTHplFFdBysbuLH7dljN9B/qEANc84k1HqZzSy4RVVcAOMooUy4iA3laAPO6QMRvdRkv9o4NVKx7FlIoRzhbbRdTwqi1MJrxCrCSBq3a3kwvdVXi3IWxywc2PXvaA2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+kUiqxtWYTWg3e1BwLTtmQz5OY17FaFR6hrabfjsrc=;
 b=C4i8mtIkbufx390yYtLfXC1zbNCpFxUksDFYZazcIx+kaiPrWPNpJ+3zc7WnAZvoB7j5p4W/8oEvz3LfobQ834B/YDAKv9h3ro8wmvWXR/59VefUbexS5j10biKiLLME1RLqf8S/lRFh2zeS9J9Li5TCQZAipUqLI6Qg1R2xB4g=
Received: from SA1P222CA0170.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::26)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 06:09:22 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::ff) by SA1P222CA0170.outlook.office365.com
 (2603:10b6:806:3c3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 06:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:09:21 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:09:16 -0600
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
Subject: [PATCH v6 08/13] iommu/amd: Introduce struct amd_iommu_viommu
Date: Thu, 15 Jan 2026 06:08:09 +0000
Message-ID: <20260115060814.10692-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 9012e9ef-0988-4ad3-5cdf-08de53fca044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mglREs4rmMZemiHfED3Er3Wg0pygQqhiOtgySg69Ps6NH++nnd+BjuHYmW95?=
 =?us-ascii?Q?Q49fctE6yPCmoYPVzQZvuShvxOO4T2LFDuWp2E3urZMggpi9PpAr9+WyeCU5?=
 =?us-ascii?Q?3dWR7+OIrqczYeLrlzVQ4pA59zcigBE+/M2cNJgz70lAfq5dVUmZgNWlwyIX?=
 =?us-ascii?Q?mdg64ihhNJn7ShA/EvLxqIrkqFoUcBamtHwFlkfr7FP/teIPqKL93rzQr3FT?=
 =?us-ascii?Q?5/3dUqaIBSBZHF/uCOA2Rjg5tgkeXGP8lhRkp4LfbONBaOpz9ZafcNiwvMWC?=
 =?us-ascii?Q?WRkOJueNNqm2UMDKP9/QGFki39GRj0/QGVuFJixzzsxQUVCehWYHs0UNINfA?=
 =?us-ascii?Q?ihkfAXjAUGMns+OriHk26TxUaT7ZfXx5JiVRftabhZpK+4Ph3FlWNuNu1v+5?=
 =?us-ascii?Q?NnBgue/QsFxfFaMHbhcRzuR6Mv8o/RpQnf0wbQODeqzfW0CDbppK6WYfciXf?=
 =?us-ascii?Q?w276jS9a+HxxohUCPovLMBU+dzhTeboYoXBI92umuErOG8DrHLtbKFu7qYIc?=
 =?us-ascii?Q?rp7vNRqqCP22+6U2DNuDiW9g3jOY6uH8DBLrXHlawqJ/7TLSfX+PL5i+BbC9?=
 =?us-ascii?Q?pqXFNTPL/wbBr+dT9RjeTzFXJH90QWRWFYmJ9ZSdN2NbMQTx4B3tx389LXcO?=
 =?us-ascii?Q?Cpmw8PcEWyH1nWFrl+ix6xqKRGqx3tgtbYdJg9GKf8lbOCPEwrgQmwGMp33Q?=
 =?us-ascii?Q?m5qfZ30dtfUqLOddRFPEiCxLO2rL3+Uo/CWJj5vnEPktnc6hmVG4SIqXNOPw?=
 =?us-ascii?Q?Ir+uj75mexBfM+DEtg+EEeNhyNBG7ORJbTcEdZbQQYSTckrjcB4wBv49yM7s?=
 =?us-ascii?Q?glQjtvXSJNNtzGfXAk1q/B7Wn8HzDpZwhacfaMIXyXrC6IBWsja+QxWD5qpc?=
 =?us-ascii?Q?2n9cVnsStJxafAH4fihrH5wVA1E9/DDE3WNozWpABOONOCadZFmmqfXrqBzv?=
 =?us-ascii?Q?dtO/gXfEyeAlVo8/65apHUrZ58EVY8/s9xOHVkcBLjBkPz/zJwoahhbIQ7UU?=
 =?us-ascii?Q?Hbssd/pLz9bJk7m5uVw7sMz8Dq15Kj0u+h4meu2EYt25V84Nb4sNhw1co6/N?=
 =?us-ascii?Q?ScOVBSq7OvAyQv53FzWFayrnJXL8rPqWEQzGTPiMbHvi44zTXuetF/jjMWJi?=
 =?us-ascii?Q?jVvbwJckbZuF+pa0cQaeUHOIxHh2tryjjH6r80WqmpdijaifXR3N2w2wgO36?=
 =?us-ascii?Q?6s9ckRcJWpUQ+5aiMSTmVfy+R2Ntg/SKlSwrGhSXU0hAekjOWf9/SUOl6qCs?=
 =?us-ascii?Q?ubOqGwnDYEGoaN9/t2eutedOIxFp579MM981IN9K8xr1QMIG0CPd3ecZ1yzW?=
 =?us-ascii?Q?5BunZ72fTx9qjdJe9vg0MNaANxuw9xEi2eMQGSezyvTW6FoDicdPFNWUgeAu?=
 =?us-ascii?Q?mJySW2mPDnIGMmp+7btxtsYuQ7+iXwNIuBJvXoUIV3PQrVlX0AxeshkaIFKU?=
 =?us-ascii?Q?QgkdFKeLsmibH977EfgQjlwaP2s4Cg7kmAKIyAYC21yTXcNNWAlmcWZiS0Xk?=
 =?us-ascii?Q?btaEcB5ohp3+GDYX8p2pcxT6l4qDd/IXOnW0NmkS8sUR52ZLPnaKBQRXUk1x?=
 =?us-ascii?Q?WmgqkQdyvI3Z9YS40kJSNveUcMH62VyN/Zub14EcKhZZ8AnqMmVTD2GcfSEG?=
 =?us-ascii?Q?z5pnFukbb/Dl/BZ9Kfx6TGNIQOCpDEtFg9/b5jWd1h5z02+1EPgOqjNvfoi+?=
 =?us-ascii?Q?K5EQyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:09:21.8508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9012e9ef-0988-4ad3-5cdf-08de53fca044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

Which stores reference to nested parent domain assigned during the call to
struct iommu_ops.viommu_init(). Information in the nest parent is needed
when setting up the nested translation.

Note that the viommu initialization will be introduced in subsequent
commit.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++++++
 drivers/iommu/amd/iommu.c           |  2 ++
 drivers/iommu/amd/iommufd.c         | 16 ++++++++++++++++
 drivers/iommu/amd/iommufd.h         |  5 +++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d8753841cd1f..d5b3393ab3a9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
+#include <linux/iommufd.h>
 #include <linux/irqreturn.h>
 #include <linux/generic_pt/iommu.h>
 
@@ -495,6 +496,11 @@ struct pdom_iommu_info {
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
index 9b2fd852eb88..ebc96f1f564f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3116,6 +3116,8 @@ const struct iommu_ops amd_iommu_ops = {
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

