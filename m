Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B792DA779
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457399; cv=fail; b=nRXdTuYxMnQmaESa0MxOZfXK4gNI5yXVWg40zeiBAbyWMzB2TJJUoDdOjnoUlhDJ3eufFlWt+QLxwkqCUVS9O1Bm2xSWBkDSEf/JiOzZkpWiQ2uaNpw6BaF5A6v7P1gel8H43Ebm/AeEdMGMImW3+V/tEAQE4Z4tNb5/isYKLYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457399; c=relaxed/simple;
	bh=h5tEBcJuu2UaKWvV2Jb7iC9niUcLF3eGGtFFTkvwzmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2tPZHauBRZqOXCNKGq4mgE2L9aASZi+QwJjb7SKtK/X3prih88eYwRekFQVDeekujCniFef+2QEVIvsJz5oTGSXqK+k90TkE3eoQtoKn3+ej4I9nhJUe3KfO8WlDJXsPgkFkX2jWq/sSc2YabdyeZyhJMNXPyTrqBnrMsiKjO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WreItoeN; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WreItoeN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHWOTtBuNgw5TW0DEN/ZgJ9VI1WEScg4bH4Cd0CdOC5cCoJmCA6TvdRYKTm9HFzQBlhRaMph1z+EqJ4YQ2inMgY3RIWQBSaeV0YLGBX+1LpLlzUagj7c34hP/LFa4CxrpqNQxvmGKCt0ryVMM7LEitAe2HcQn4gU+gMBtR938dDH3WJdz4lt7HE8wnbFRvYiYW18N7eFnF8zQWVFJ10WLIMV/omO4MKZb92V1skxNR6kRfUq1bT1yCMuYYsa7KN/nyzxKxsV4QCZnHX5juslJLp+U1mCbVqbcH3TKzO7ThPkoMF0W659cSLLHqIicplcaxnOF3A/CYCeRWOi2duHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAyHd0osgdvj9FTO8SaZuUNIMW1jIrvcQp3g3DjVggo=;
 b=OCSjMr/9nDpxLPQFawg3v4cSdCdfQtS4D0XW0lxsImEq3TW2FsvkhVUA2+NlQx8jbIYb+CseAsGgq0KQ0SZ14xy3q+8aHAi4XU+QN4VrM6rOmON2sz5N3Vth6NP+uaEovtA48yDGn3VZEkaQf35z2I9WzeIsJHgyq6s/VW8bM1k43A2p5qxSvDCKfVQChr5dkGaoakJpKFlY7f5Ph7qhGBLHNHzw3Ls+IWwavSKCdedv43S+0S0XmNUbgUgRZQyNp0XdFq1Gx87fE2TO3B6QwCcf63JNVlwFiHGL+MDwr/USAaax/OEDFcSXVCMrx0La4G/yv1qxLwG1wTPJsYXfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAyHd0osgdvj9FTO8SaZuUNIMW1jIrvcQp3g3DjVggo=;
 b=WreItoeNZCNi/4jPME1nvg7aBweOIGIE4xC2esCK5O36I+t99ikLli218cfqlF/Vc0JABtp7/ZBwA9dcP0emPYw1L2FxrnV8wBgCLfTjjOmRckbOgXT9pV5VON5IT/cCM2ABX2WgankZDRVZKW/Q8aVD5sWSFm7aglWxE7pQ4Pk=
Received: from SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::13)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 06:09:51 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::b8) by SA9P221CA0008.outlook.office365.com
 (2603:10b6:806:25::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 06:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:09:51 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:09:45 -0600
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
Subject: [PATCH v6 13/13] iommu/amd: Add support for nested domain attach/detach
Date: Thu, 15 Jan 2026 06:08:14 +0000
Message-ID: <20260115060814.10692-14-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e30955f-96de-48b2-0035-08de53fcb1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HzVUpgT1AvVoM1rAUMxq76xTeW5kl3cGRgM/f4Ex/YRtQ7yYMhj9sPCGRA9s?=
 =?us-ascii?Q?gFOh79XNFh/QOVNT/yOR8IEtWEgC9JB5T2eFFN+cIABqX4Fh1P1FTLa7zDCj?=
 =?us-ascii?Q?mKyY4llLTiXzQZ69LJr3N82wy5s7y+pk+CCxf8TG+Ce0VyqvWovNfZoS8uk4?=
 =?us-ascii?Q?tK4vGmyxk1SYEZyj1oX90uyEXlQs3FdL7N5UCyyuRdNUL+RyPbcGp3TBWpQp?=
 =?us-ascii?Q?cBKBgz8R8TVh5g77yM8dRtT9MwDLhAs6tpzKfJs517zDVPmUOXwCzctmz46g?=
 =?us-ascii?Q?42wN4QZWrWzGN+8ifS8+SFMQ7OtqQMJJRoGBNkWSV0wRRTe6FJIzWQ+EEJt+?=
 =?us-ascii?Q?AQwfAOoL4Exy+E8/01TlANXwVxCXA6Vw8/ECM/g8dGQbVuGnAvA3po+OWAS5?=
 =?us-ascii?Q?rtnSy4+x17Sus/kQ7kcKguNpuzgyBQWGbJTeBoashPIgYBL6UmUw+G7Y264r?=
 =?us-ascii?Q?iQkOX5GMEBq1D4nZ20UCEE7E6TD8tmZoUuRu/py9gB+oF93Vi22aQ7EnT1U/?=
 =?us-ascii?Q?km/lWZ38/bbC3BluL22dIGZWYSKI1b1aAwQIJv5UrRY5SULkETvUJ12tV/5F?=
 =?us-ascii?Q?fKpUmB+GvMnNrrBLS3IGt0plxfXIG05dOgqYZ951AYIISBtW37E2vWvi4vPW?=
 =?us-ascii?Q?vjBmN6qxgUC48KUkJr+3g8oI4qzhf3oe9f5hRFXqMvIEgbj7Pb5Thu6JmbFd?=
 =?us-ascii?Q?0DdDjnlTNTCLskXL35T+uExqB45tIcukx6Qxu9f7vGVxrHU40EffdPIQN/j2?=
 =?us-ascii?Q?n9jtrERqwIsEPK0EZdBWIyUxh3qqYGTKRI/USTVaaHxYTJqqHK+LjnPX21xf?=
 =?us-ascii?Q?6mBkjz89kKKeoDoOBK2yRlIF0hPCL7+Yk6IWZyAJhKFG/AYdfHEON6d0/O2/?=
 =?us-ascii?Q?RQN8beJQrQrHAityWT36RKUCNYzcQilmdbkT6bPfi/ipTy+fsolwRqLLoYVQ?=
 =?us-ascii?Q?XZZ7kUZ8FvSLBPNDZfzu3vFylFnyfgprdfWlcCtLUS5R/E+ssOVtQY8Y2++/?=
 =?us-ascii?Q?ynVSWHhqWWgc3NteLmgCdrf6GKGem1xrEUD4yd6zaRggo2X775fgIevB12AL?=
 =?us-ascii?Q?ESwOGi+nHqdOoY5jfkTNIKBzLWZINnsnVm3yiv1I4WsLXzIN4sY9b6Pfe9Pe?=
 =?us-ascii?Q?XRmAmekto1c2lkRhBG2Q0nWC2VllgDP+AQF+87d4CB9OPAwd4z+PZVkVeCUi?=
 =?us-ascii?Q?bQD32pjHUkcm/o0uB6j+w8wD0rUEDSiSRGQ+9MAXdt0zQxV/y5zaVCRM67Xm?=
 =?us-ascii?Q?wlcahMYfvUXCs+TvXub9+sTrKsBF1qAZ3zqJQ1OCG+d/MQ8WFv/63/laFX8g?=
 =?us-ascii?Q?LLLs0Y31GuhNs5B+D4HkYHPttOFWmnOe1gpvupzO2UPoJFHw2KpRYRTNbr3q?=
 =?us-ascii?Q?qVhbYDdCGxxkB6CYktVFSVe+CzmfO8LMV10l43x4nllQwoOLDk0M6SW0O2bb?=
 =?us-ascii?Q?V0sZ6vvcCor+iCYVqfAfeSwqpQBWcII7hX0t4oT+R9ke/hw9tKikE/3KuHVS?=
 =?us-ascii?Q?UYzy6R9dLgDxjU5wMZQRpS4/DwflAH+d/GcLyq/NfHbZ5PapW/5YJYwod6oV?=
 =?us-ascii?Q?U9adxpYlRDg/ctBdbhd+nzBl/Sf0b+/i6CSqJYVQxm1DC10NfaCeIv7NS0qn?=
 =?us-ascii?Q?NSSaogWFfFIvncyaBuZchmxY6bf9LhUuRkhXjwux/wj7xApcQCG6f6bQzagV?=
 =?us-ascii?Q?8/jiTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:09:51.0743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e30955f-96de-48b2-0035-08de53fcb1b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623

Introduce set_dte_nested() to program guest translation settings in
the host DTE when attaches the nested domain to a device.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/nested.c | 73 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 8154a773eed8..66cc36133c8b 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -183,6 +183,78 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	return ERR_PTR(ret);
 }
 
+static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
+			   struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+{
+	struct protection_domain *parent;
+	struct nested_domain *ndom = to_ndomain(dom);
+	struct iommu_hwpt_amd_guest *gdte = &ndom->gdte;
+	struct pt_iommu_amdv1_hw_info pt_info;
+
+	/*
+	 * The nest parent domain is attached during the call to the
+	 * struct iommu_ops.viommu_init(), which will be stored as part
+	 * of the struct amd_iommu_viommu.parent.
+	 */
+	if (WARN_ON(!ndom->viommu || !ndom->viommu->parent))
+		return;
+
+	parent = ndom->viommu->parent;
+	amd_iommu_make_clear_dte(dev_data, new);
+
+	/* Retrieve the current pagetable info via the IOMMU PT API. */
+	pt_iommu_amdv1_hw_info(&parent->amdv1, &pt_info);
+
+	/*
+	 * Use domain ID from nested domain to program DTE.
+	 * See amd_iommu_alloc_domain_nested().
+	 */
+	amd_iommu_set_dte_v1(dev_data, parent, ndom->gdom_info->hdom_id,
+			     &pt_info, new);
+
+	/* GV is required for nested page table */
+	new->data[0] |= DTE_FLAG_GV;
+
+	/* Guest PPR */
+	new->data[0] |= gdte->dte[0] & DTE_FLAG_PPR;
+
+	/* Guest translation stuff */
+	new->data[0] |= gdte->dte[0] & (DTE_GLX | DTE_FLAG_GIOV);
+
+	/* GCR3 table */
+	new->data[0] |= gdte->dte[0] & DTE_GCR3_14_12;
+	new->data[1] |= gdte->dte[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31);
+
+	/* Guest paging mode */
+	new->data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
+}
+
+static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
+				struct iommu_domain *old)
+{
+	struct dev_table_entry new = {0};
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int ret = 0;
+
+	/*
+	 * Needs to make sure PASID is not enabled
+	 * for this attach path.
+	 */
+	if (WARN_ON(dev_data->pasid_enabled))
+		return -EINVAL;
+
+	mutex_lock(&dev_data->mutex);
+
+	set_dte_nested(iommu, dom, dev_data, &new);
+
+	amd_iommu_update_dte(iommu, dev_data, &new);
+
+	mutex_unlock(&dev_data->mutex);
+
+	return ret;
+}
+
 static void nested_domain_free(struct iommu_domain *dom)
 {
 	struct guest_domain_mapping_info *curr;
@@ -217,5 +289,6 @@ static void nested_domain_free(struct iommu_domain *dom)
 }
 
 static const struct iommu_domain_ops nested_domain_ops = {
+	.attach_dev = nested_attach_device,
 	.free = nested_domain_free,
 };
-- 
2.34.1

