Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B33559C9
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971945; cv=fail; b=ZrWhtqgpzoc0EpEbWCct6C//J+ZZ8KAs7m+J3Xaxjvs41vEU1FgnYQrTTrJgW292+9N6fMfs3ldxFPLYuSfQ8rTfCSV26Gxu7tTLaSjclxaeN+zZ14jOmbpxE6gVlWR8eTLloBx8iVrTtppBD5xlxYU5jKusS+IXvRIObMC2PQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971945; c=relaxed/simple;
	bh=mwBary1A+rF2JCuZ/U3UUT3W04CjEQtDKK3EuuB4Aqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCP4453K1NcAhDzMgRjXwnvR6YzyboMEswtMG3chZQpkjHH9w5I41BUPnE1/ZPnatbmDH0GH6CcwX+StrhnY0XdiW6aXGCCCVOpM+lLKCjCjayjQdeNL9l1x3BRvBSayxwCcBRH9XgNBjkSMWa3CCfGagsBnTMgC2f97W6sRJvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vclWMab5; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vclWMab5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k05basjnwxJIj5FEI6UE2lHAAscWRQvggEJCFRziwqYyHlH2lkyt+RCWJVV69Qj7+9WgRqZMEGu+pmF1wjEDcalEEPv4wZ4FRoyE9qiky10g+EkDhAdo3pAHpycs3jL8n5YBP4Dp0BWMytyYsmWxSTwoTxkkn2KXmtWqbkH05f8OHUW4bU7rLV/eDRYNMb0YjrsGatYg8Oild43yANmhR5IRBk1ejww0p/2n1QraEU8QPtOVI6hw5VcU9P+6CaqnJ0/Xkkd4xOEOyO0eliJd2M1vqaZA20EFfyw7JDtZ3SV3e3EtKkBZV22cf1U1SHiOjJJv398xXlhpd3F+ologqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Omzki7ZLq6+yzrWQ3wbKUw/t4bPxsCLs0Qjfs4lvJ/A=;
 b=mKXUqgnuCiKLesZ2v5I/EMB33NIG2ToEItQFl2jo89jYnWJs8JK4wLPJU2GWToHGDdVaCfBp+rEZ3LTl7GWjv3GlX9PeZlbNs/OWfhUcOs1mdHxoyoVbC5UazCPHu8WWWllyC3iqabZpH2/bToJ7I49GRkdAcytkPY7B1R6rAhbUDP8VHZukVQoy3dtRXAXVOLlsn4ril6HfbGZnBqwiwllV52i5dYoHeoI1QR0GE1w3x4dzwta1jygtQOBv85QCxBDkP6xgq98rGl9GTXATemTgPK6N+bU65/q9Vy/0q1k9F2m0BrmWiwKBV1ezH7vdUecwJGgDZUgNhAjPnkUZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omzki7ZLq6+yzrWQ3wbKUw/t4bPxsCLs0Qjfs4lvJ/A=;
 b=vclWMab5DGieOC/pS9l68kg7PTfSxe+NakcSQWYchw/W8JzGRwG2Hh54ke8JfSgS6GmOwn4lWngWb34InOosqBOa86QttI63IeuOQpuzGXm2DKgJYW1DwcESoVCG2/+zTAnI6cRjxQDNiJCNjc18Eiprb/hK0PY+kJshRO3qf9g=
Received: from MN2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:208:239::21)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Wed, 12 Nov 2025 18:25:39 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::ec) by MN2PR08CA0016.outlook.office365.com
 (2603:10b6:208:239::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 18:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:25:38 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:25:33 -0800
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
Subject: [PATCH v5 02/14] iommu/amd: Make amd_iommu_pdom_id_alloc() non-static
Date: Wed, 12 Nov 2025 18:24:54 +0000
Message-ID: <20251112182506.7165-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: de1a5ce2-ca91-4f26-8fbe-08de2218e16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e/wse+6Ez/mOUx8j5Mu73c0XYOwSgHb7fgaPo1mmAgvP7ZoyyVSvKxK87YSp?=
 =?us-ascii?Q?oc+1W98waowfaLg+TofEa1L4SAqDOpp6cq1oWx9+HKsuyt6jeoVHzHkRHWK2?=
 =?us-ascii?Q?UGL982bzm5ym3aGL6lV2C3CTGoGsgKEBiSDdWuppOM7NhtH4JqUSIrIc7BX7?=
 =?us-ascii?Q?EH1QBGn8mXexExdhVtWGYx4Fuir0GdwNmQpC1ilH/XEaNw46zyzuayhr6HtA?=
 =?us-ascii?Q?tUMgsVSGv7b99nN+c/dlzIDUR6Hesf37Tn/Q48EuCzysOOeLkcrYxUklazSx?=
 =?us-ascii?Q?2kfvcYqVgV0gc9M8AKTqOH3CignB24MHmrRbYQ/755xHNZiS7VWYOa2UAG5z?=
 =?us-ascii?Q?qHNcfGsdwthKN6M1tNxRvkxoqNy5JkA4ftdJYJUTjgcW5PxuIe/7q3Svo7v+?=
 =?us-ascii?Q?ZdyxGmo4x7b12twrE1ZtMX00tlkQ7J7Y0VTGSMB5lvWiipOjBO9sOtc9n7AA?=
 =?us-ascii?Q?TplNsI82PDYs/h0ughdVPxY4PUtbTK65CRq5BTEqHa9jvNvP6hUkv7m4QHlq?=
 =?us-ascii?Q?Q5mc8QkIM7RICrSnXJ6snlAT8JjF9XlqHGfW84qfkJQA3JKVMeD1hAtF52Mf?=
 =?us-ascii?Q?hCQmghhx0b+PygnLUuJ1pQogMYFhnAlUUo/W6IXeF/wahd+nW7D3SzZxueas?=
 =?us-ascii?Q?UoPxBIks90rFXQ4Edcds8u1VmCk4qRmOen+ivVnO1U4qSludoIidBCOtuxVf?=
 =?us-ascii?Q?b6IAN234f/wktf3/+ILZeNOv7MCp899hcygewyqKhEyfgv0qXgmSDNRFYZ5I?=
 =?us-ascii?Q?JDMYW4u/P28Gj5XbIpph7aco9MdmmSqkKVx24pDX4/B++znjlCnxVZ/4oQcY?=
 =?us-ascii?Q?6ibEgVpq3xCNb7E+VbX2QEMXlVIYsZyUkt4V0RC0W8EgSwhccDH6oIuP33AU?=
 =?us-ascii?Q?FFJQNZtmZbhpX2PYrazbrEtX3Uxm1yW/Uz9SscUm1ywCsPlcNrk3VhZ6pMdq?=
 =?us-ascii?Q?yIKvyOk/LmU0kYSKiaCRzxtgssesJUouPa/vQdzFDmhh+Z1uy84pPSkeaF1a?=
 =?us-ascii?Q?4QOrymF4MSdydGSJKGQk7FA9QhRgD6HJ6n5x5T5ck2xeANUfktxEAKiGDbWi?=
 =?us-ascii?Q?RogPHm+IipPKiKJYd7jAoW4S2aoN0DNInDh1DQnpfqLfK8RODxhZ+xAK+XDY?=
 =?us-ascii?Q?ay+7N2FzwKEzyARp6C1XQ9tvIg0W4UK1pgX3mLfhAbLMIjlzLU/xAo9B2Wxv?=
 =?us-ascii?Q?EKxuCu2SKjw+tT3geOQZBm0AzBVpgsqk+4zQpfnzEchd1tGitWvI6GTJmYGq?=
 =?us-ascii?Q?45rqmjmdsUgfNMgMUcTrfNrVSqTANzNlDaD6CgRTsJcWe7DxHTnxUVaojIM8?=
 =?us-ascii?Q?nFZyuRhQLqpjZzHTlEcnYVFODp+C76kw0K7KuSIbvq1ZTjqchFYabrRDLDzl?=
 =?us-ascii?Q?3ZgU5OEilYAN9/4xgQm/LOzqAKr836gi77An7rv6vspRxNE3g/XAMX4CNKNW?=
 =?us-ascii?Q?3OezoLHru0evje0FPVhlHAymQpLlIo3j+eE/GmOAcIKNa2SUDw5wFUyrrzsh?=
 =?us-ascii?Q?wz+VPCzvtPY6m51PmK1GQtBJ540EMUDo7FRo4C8Wi5Rm1JqY0ks2MTpppnID?=
 =?us-ascii?Q?2PhMUKAlnEp7zdzf4Kk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:25:38.9437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1a5ce2-ca91-4f26-8fbe-08de2218e16e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021

This will be reused in a new nested.c file for nested translation.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 1 +
 drivers/iommu/amd/iommu.c     | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 25044d28f28a..a9d724d43398 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -26,6 +26,7 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
+int amd_iommu_pdom_id_alloc(void);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 02cbe82ffcf1..b42738e9d8ab 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1787,7 +1787,7 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
  *
  ****************************************************************************/
 
-static int pdom_id_alloc(void)
+int amd_iommu_pdom_id_alloc(void)
 {
 	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
 }
@@ -1875,7 +1875,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 		return -EBUSY;
 
 	/* Allocate per device domain ID */
-	domid = pdom_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0)
 		return -ENOSPC;
 	gcr3_info->domid = domid;
@@ -2478,7 +2478,7 @@ struct protection_domain *protection_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	domid = pdom_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0) {
 		kfree(domain);
 		return NULL;
@@ -2825,7 +2825,7 @@ void amd_iommu_init_identity_domain(void)
 	domain->ops = &identity_domain_ops;
 	domain->owner = &amd_iommu_ops;
 
-	identity_domain.id = pdom_id_alloc();
+	identity_domain.id = amd_iommu_pdom_id_alloc();
 
 	protection_domain_init(&identity_domain);
 }
-- 
2.34.1

