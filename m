Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F772417C6
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011702; cv=fail; b=SUhRFw4qHFenO7pHeWh6S0fRjwelUnqunzlO2y1437dszGcz0KexhSkml0lDz7GDATcX4L2oM2CGTVIbJh7YoxYb6RhUzcY4dnfb1dMnh4b+ars9d3kjtav+bg9C84eF352JIVnycdV/rLcrA+/CAek9SveujBXyyW7CYIkPENg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011702; c=relaxed/simple;
	bh=iTE09CCYSeryEtoRAGfVV7A6m86/DM71IcUibf9d8zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxXKQd2K2s1w/UmKAoImk1IHPn0TFmRIbY+I9cRxTO2DrC2VxrA++5dp8wl1WcjyClti4DfVwoa+VJrw/2cJCWfyUqLEW3/AKBuJpZph1I/Htzeqf7AczahS0f8B4Nzwtfo4z5jYjOA3ld6vxO0X4eSyqnpCnuCLng9A4LdZFIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e9q8rgTt; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e9q8rgTt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkXOFtFulDxjxP+laXU6qNyIWdAQHJdFStdKNRyf+N0JNr0yWgVJdaEkV/6rN70L2nqS0f1VDNpkBxxakAhac/QD1kZONKvm5yLdy3a08F31BGE4QWhRWN/56pF19fsLWULEIciHguqB0IFYrsoQ8QlUSSOzPkyDTkv0Xf0IjCwZOV19wZSnZpkyJOlBIrZ96sTjWNZntCWjzK9MjCb350B3r+sFwgJ2yoCDII6FcZSTYlVwf3hwmBRUBClB6qNQWO/owQwPk9scz7xLmYj4kJArAPCc1+uf2J7ln/Zda/IHcQ9qMEpVEkRzwG9NddnD2wvAmP8oafq4wZ7glMxvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAlS5qFsEZ07oTwIkHsPwXm6KYLU6EP22U/6rswKoFg=;
 b=PcqFXCh3LOJZHA0aWvqo0s/sguuIubUtbZCw7fXaDA4Gq0y5XEPMnPuSdlpodE5q+XPM1KvxUH7YtWs3DG6oSvo0zwEMvxz05Upp/OmsIeOdfhOKKpLKt7ks8AgVAb1ZG5E0S55nudQMuZ6RY0NMQxjVBCZPI0+DGGLmXby9IdM7/OqQPy5JIY34i4T1DdEdvrneXS4XtDNgihY/JPO63G2PbDT9PPluPte5eLPLDygYR5JTTZIOUxnv+i93xHl1LqDMAIHyGr2Lb7DAzOS6tHfEoeoT7fOlyMRBTzmZnJaK8PeAb1MLq5A0BVoRp2v1Yq7LAbUkdUYEb6oeK6s/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAlS5qFsEZ07oTwIkHsPwXm6KYLU6EP22U/6rswKoFg=;
 b=e9q8rgTtjZawWgMV8XoVSHtMVZG0SzfZl8QM3alZbzT1Zrjx7ZQMnoj0g8z+yfC8X/AbH3HkXcoC3yuiiJvO58eZKpxS27t2tGANBDvErVeEbjyrj/POccJqgjEYbYXJ2Xo69Q1oy1BlrCY9mVDROYjSJ+dadckcQp8WC79R3Vo=
Received: from BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Tue, 21 Oct 2025 01:44:07 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::74) by BL1PR13CA0334.outlook.office365.com
 (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 01:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:07 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:01 -0700
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
Subject: [PATCH v4 03/16] iommu/amd: Make amd_iommu_pdom_id_free() non-static
Date: Tue, 21 Oct 2025 01:43:11 +0000
Message-ID: <20251021014324.5837-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6a5bdc-55b1-4b62-0831-08de10435300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YO3tcJljuekON5HACdzq/aFUiUut/Q0YBXH0ROb9l9u2ZzKN1+Evww4chXTz?=
 =?us-ascii?Q?prIah4aBiH8qzM/sy5Y2SrX7fQChnPdfEpfXJeDI4KnFOcdUvPC7fLMGBUvh?=
 =?us-ascii?Q?La+oABpQ7YmXpvGdTs+wbjiUoY9eG8N7bBmkHvREpSLDcbHXMxz4QrBUMhEd?=
 =?us-ascii?Q?9xLFuFb0euJa/p6goOt+m0rVo+oewE5p6B3spJsDflIFNFs0HKJqHCSsPzqT?=
 =?us-ascii?Q?C1BWYJ3qPYiedq7LrdLVbTWe5vA7kmgEPNPIK6RY9bfsCxM6jps+F8kt7hma?=
 =?us-ascii?Q?KML5K+FTZzYBMwYcQSTxGejSxmpwHsxFWQu4z7XNK3Sm4gKyx1p10qxrbiRd?=
 =?us-ascii?Q?vx9WGNwHRSagvtp1d5pJG2lv7kEsE6ts49spSsNhsTIQ3l2oXnuIRAmEbmzJ?=
 =?us-ascii?Q?opXqv6mvBN0/aOJ6KXOwEtYH8OyioBImkETtPXJ17X6yc0/YVjYQPubtP1uI?=
 =?us-ascii?Q?eGGj/ouutZjINU/oeq+SoTRpwdFDvpYECvc/ty+R/8l734AKH9O9QmsYE0js?=
 =?us-ascii?Q?642tAqtWQPzXscVXa4DveKshk/yAindplUXsZlY7dsfSmMRlg/HIxoiYUzN7?=
 =?us-ascii?Q?fcCgklCWOUJxzPqORrU7qIZ0flbEsIidLdOYCzaPejLPayFzLS1Fj9RIHMaH?=
 =?us-ascii?Q?I4EjT8fRehLeCNiN3BTXR7smr+nS69yR4t5B3+J4Vzj5hwaBQ84FrpTVcxvl?=
 =?us-ascii?Q?Z57QMMFuROBJwqEp80fM1Rvkh9aTmvsU6OGGDLWV7lrVRAjQsVmUA9jxe/oL?=
 =?us-ascii?Q?12d9aoMwV6Kcd1/L1Be+gfZn7DxawH3U9fFmEyE1y2i8f1KqVAPrNr+7CKwP?=
 =?us-ascii?Q?k2QeBaMjaTuh0mIRGcDZ8n3+dpV1qZGDrxe+ZSsGgzf8WEeqLBAWrlA18pRt?=
 =?us-ascii?Q?LTxbL5SwID795SjO0kXVqtYlQaUfhJyMKf/B/PxOQ+E5V1nAuNeMpT2E8F46?=
 =?us-ascii?Q?HGfvZgKl0Ltto1O7I4AEgioziQTmtz7SfPFuj4Z2qr8PRh22UDes/s0AtKY4?=
 =?us-ascii?Q?DMs8Sl6PLyi06jD76NBUG5krqJpyCeJwL/q2mEgl9TE3+R9Ci45CNrLaFUbs?=
 =?us-ascii?Q?H9GaLkp1WTOnqZ1GyGMbo37r0W/vUWe+WGcJQl7EuXGiE7T+sX2/TyYmqu6x?=
 =?us-ascii?Q?HGZzKKrR3WP0iSLjymheu/Ih0FlI3or6tm57YyLGJysu+GQrrbooQTsaGx2p?=
 =?us-ascii?Q?pyX0oFlygnx+m2JWd30OXiIyGEmTag7CkXa/j5EhiHpidwX+kZXg5Y5rHzd9?=
 =?us-ascii?Q?J/9ZjGwuySHIJbRdRsc90DivjPiIVO+Kk7OMOSTSd6WAv6kASUFIOYlaGBKh?=
 =?us-ascii?Q?y7eb+7Vhr1e1rNhFpTcU5fR7tk6Mz7sBkawPcxShGnyGi4XcpzS7TfLDfGzz?=
 =?us-ascii?Q?PEG7khTS+0tgvSxYuG4UyKYuMtOj1GOvOD/CIEgiMPGoTzZ5Wyd9YW1rLCWv?=
 =?us-ascii?Q?qZANNLuFKU6EdqsOqLB12ON1Hzmyqd9LaBxnv7GMWmesxvw3qmqmzoaC3k7k?=
 =?us-ascii?Q?qFX8j0xhkEVhvm48MvlubFIBp/lr29HO6eyqcz3FRZo0V7YHpCl1hB+BRqwl?=
 =?us-ascii?Q?cd8Wk1SPr2g2rw7/XtU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:07.4128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6a5bdc-55b1-4b62-0831-08de10435300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

This will be reused in a new iommufd.c file for nested translation.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6ea549816a1f..322c8c73444a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -27,6 +27,7 @@ void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 int amd_iommu_pdom_id_alloc(void);
+void amd_iommu_pdom_id_free(int id);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 78b3e5485006..0b61059e485d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1823,7 +1823,7 @@ int amd_iommu_pdom_id_alloc(void)
 	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
 }
 
-static void pdom_id_free(int id)
+void amd_iommu_pdom_id_free(int id)
 {
 	ida_free(&pdom_ids, id);
 }
@@ -1870,7 +1870,7 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 	gcr3_info->glx = 0;
 
 	/* Free per device domain ID */
-	pdom_id_free(gcr3_info->domid);
+	amd_iommu_pdom_id_free(gcr3_info->domid);
 
 	iommu_free_pages(gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
@@ -1913,7 +1913,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 
 	gcr3_info->gcr3_tbl = iommu_alloc_pages_node_sz(nid, GFP_ATOMIC, SZ_4K);
 	if (gcr3_info->gcr3_tbl == NULL) {
-		pdom_id_free(domid);
+		amd_iommu_pdom_id_free(domid);
 		return -ENOMEM;
 	}
 
@@ -2573,7 +2573,7 @@ do_iommu_domain_alloc(struct device *dev, u32 flags,
 	domain->pd_mode = pgtable;
 	ret = pdom_setup_pgtable(domain, dev);
 	if (ret) {
-		pdom_id_free(domain->id);
+		amd_iommu_pdom_id_free(domain->id);
 		kfree(domain);
 		return ERR_PTR(ret);
 	}
@@ -2631,7 +2631,7 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 	WARN_ON(!list_empty(&domain->dev_list));
 	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
 		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
-	pdom_id_free(domain->id);
+	amd_iommu_pdom_id_free(domain->id);
 	kfree(domain);
 }
 
-- 
2.34.1

