Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55E28D8D1
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054320; cv=fail; b=qRQRQCNF/nVbFud3O3bw2x7D6fo1NiAQ4cWRqGPEQ7cU/JaBhSj8VNJt2oGsDBF4NQSxW/B0QRuAqXxsDEbdtYgRXeeKQjce0SrI7sXwfkcQqrgWGjHBwo06ZXl9Ag8OJIi3kcVQ40sfeWLZEbH+xxv1kCXdCG2HhHBO6Ao9nt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054320; c=relaxed/simple;
	bh=iTE09CCYSeryEtoRAGfVV7A6m86/DM71IcUibf9d8zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0c5AI6uyGBHs3Bwr+gPfUAGduPIBifG5YsoRCcF4qoh9Z8MCaKCdILkVwpB2cH6GUvd09FFuBuVJ7KpzQtgY0gGPV6kfkQrBd7Vku/LStt+m8HiK23muLG1rDc+V7RI2gtbbFBkjyyWceTVPYa50weJHDyOVcMgHzkTFG9kP1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SPISZhlh; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SPISZhlh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMI2UQnVAEcfPD/gd3zJC4+uZS23gRaAGp087JqY8Ptan5ivychZHGoclWbW6HQ1EmiWR7eVK9RWIB5vh1us9dA+DbbhOdxQ5wxNggqRZ6x0o0cV2xvALbUWfwo68ZfIW2SotwPFBr7UqZgPANpc+1akx+3Q1RIejfnRpV9lxTMN1J9YyPqyovya/uBxrF7HrsnsVLAIwTMGdye0OzrtIwQ35ky59PfxwZ08i79XOeEShKdWgAz7Z/ZUbpijLT213RbRKKQa2wrswiJrMg1pEP9S5Y32JGLvl8S8O9aGl+kC69i58NpHI47N7KcV06pGHzrgxI3tPi8xY8t3iAMvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAlS5qFsEZ07oTwIkHsPwXm6KYLU6EP22U/6rswKoFg=;
 b=qOdEESPd6Tm2kaBG6SiZtQUmGMBfVVmOTFkI4CWpmVK0zPQdR5d38mQmXxyxJjl5muPJMjCoBZVkzPsWznmJsGxbpqae52vfDwJC8sSiYkq9KE+VOVyZvegjYtREJT+5RyKC1XbIj3sCHH/bSgv7huFzjv8wtcOrYaof24SinpPoTHqO8rFLdpPJUocN7/FtA65QPFzy8oS+d8/NQ6gxd09rsj2pmB/mQwD/qJvKvGV//sPoIma+4ukK5+a1rg/xUskC1uLEXOuuB084YrX7RRwv8tNYV7FBtLwv9p0xfU79LDYO7fOEgGMi2khBMoM56hxW6suFJJyvx6YZA45Bhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAlS5qFsEZ07oTwIkHsPwXm6KYLU6EP22U/6rswKoFg=;
 b=SPISZhlhmGExDCzKtxaxVC2GCcwqshluB3woX6xPdbBPuPfgiVnXJU1SRZSvFvliuYZNpzfVzgrkmiqgMXMl8/20VUnT4xO/54kYamgwhvM6m0gdKVX8+kmYBRVfbtItClLxeaLwUOXlqineLIu1KlQzY5loYKYuMMkBZnYR0UQ=
Received: from CH0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:76::22)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 23:58:32 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::6e) by CH0PR04CA0017.outlook.office365.com
 (2603:10b6:610:76::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 23:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:58:32 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:58:25 -0700
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
Subject: [PATCH v3 03/15] iommu/amd: Make amd_iommu_pdom_id_free() non-static
Date: Thu, 9 Oct 2025 23:57:43 +0000
Message-ID: <20251009235755.4497-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: f7440706-62ce-48c2-3100-08de078fc0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bPf2wgtC9wYT+3R1X2yV7uC14aN3aoQbOdcPR04aiBfNrcMQBMiCER9DkT5O?=
 =?us-ascii?Q?jcObITL/tGPAFNB9RRJ1aZmN2yARR4JyOdmiAdxRX1O2XwJ0NlN1eA0AVRp6?=
 =?us-ascii?Q?9/Rky69ICHIQVdEpBYtcerR5dA6I79qNZE3KjwsFyaz0t+M214ClPE8KvaGl?=
 =?us-ascii?Q?04CkrOmubhJMMvIBo0MD9kFItbmW9DfrBw0p/+A2jvoXqtTVl5uk7zg2nR53?=
 =?us-ascii?Q?Dq79wV21c5FPf7kXbCveoauKhi87sRvXQKJeLaEFrFlVIgbNQ0YnVbVxu126?=
 =?us-ascii?Q?yqEyDxw5GTBdSDaeDgsYViPXdNpCitFicpGbMoIg6ZAdr5Z45bqrEHk/M9Y8?=
 =?us-ascii?Q?hKMv+eBfvPtjJauWK+jpp+lHwumxAxvCDmEW/luYBPiXKJwUuJyzs4wIPSvy?=
 =?us-ascii?Q?8hVk5UA2PzPH7Qtf/PfDZkQeZxQs3FImnqUzEpUPMQFAkgpxAmXKApKHWz6Z?=
 =?us-ascii?Q?S5ieCcTwBrM/reF1OAOMz9Squik7+fFHQebm1mJMxS5ihhRLhtk8/eiPgX3k?=
 =?us-ascii?Q?TCKGz2FeIx2oqVfngdDgNynSx6/woMYhFc2qofduVUWRZ4+6OVu3WArngw2D?=
 =?us-ascii?Q?SGSv8sW7sRovpjxX6+hygvifmkwgbzhs7r3Yd0MjkQq8zBGo8gEDqrgXff+d?=
 =?us-ascii?Q?WlzK4WHxqw7JQIh9X6IXuYH5E5DjDVMKzFlW/ThWINXvreQmo0srC8BRQsIk?=
 =?us-ascii?Q?+d2KFoPmmHC+A9OUBiDEYnt+eAqP5JDrAeBhw9weda9Rbf7zn+TU/e0rza6x?=
 =?us-ascii?Q?F0VatgcNowOQ9h/JOARzbNttAb6AvEx6nRT33vmtSm3pZlCmkOzMhmUecRbO?=
 =?us-ascii?Q?tvJxaLK9yJw7EwObz10BgRSXR+msE4ghR2p8ALdmLDHFQPTQYaGYKhUDa7ju?=
 =?us-ascii?Q?nuY3CT4MishYSkKs/mAQNw56TDsutoXZN/D9kTySy0So2ijbobxkiTRWMEyS?=
 =?us-ascii?Q?w1ifzwimAX79JOgbUTTfMWF3aq3I1/B8N/LWlKgDt0LTET2PeG6g3vuE6e42?=
 =?us-ascii?Q?vT8R7QAuRo8xdupk36ghVLfuwldjrNTnoawlt2X8moJCi1M3ZlDGNvVG8WGj?=
 =?us-ascii?Q?Rll/JvI6BKwOfae3WUPd1irz/dAPFua2GjGe6PwWULimUeX5CV0FkYorQXFk?=
 =?us-ascii?Q?DR3NELsMDAeNhIOyWegxBtIC79q/qQEW/zlTZ//SoAHG2X9z2yL5UCjZ1hbS?=
 =?us-ascii?Q?v/zClaqeV1WAE2anTsnKtXKBa6Fis0zsdwOj7rGs0D23BHbUH01eKApOJdF5?=
 =?us-ascii?Q?llnkFuZiySBkNpGa2ZWUPykAzPAIMhYHw2YraCnSHGpThgQ5R4Ui8aJsFHLI?=
 =?us-ascii?Q?vVAuysKz+t/M7WYDdCRdjM3QvdwaGMoBnmBrfDlx/dT8NybPBmPy7BiAySaH?=
 =?us-ascii?Q?0ZYfZFFCCEU5hm3X94cEx9BsOg9/FOb11XA0t9akpfl5SzG8oU5hy3kFtzp7?=
 =?us-ascii?Q?67Bcc01+vo2TvYE4Eqq75+CUHcvcxpWTuqEyyK6HdIKYmSaTk5eMkBNZWroE?=
 =?us-ascii?Q?th7kSuV/KUYCz3WmNv2v1als3wJO18U0zfyWBy3gA0YGBC5LNCkfZCEB81jd?=
 =?us-ascii?Q?0M9wF6INj2KN4eBKeXc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:58:32.6475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7440706-62ce-48c2-3100-08de078fc0aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249

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

