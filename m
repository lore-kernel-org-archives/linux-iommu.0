Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543651AA7A6
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159078; cv=fail; b=g8v3fxfPZGYJvfeI5oaFvuoHGjlsssX6trx3/A4w6xIwlsPNvlHb7KsSN9Qs22SOhHuBJWYQg0a0EusKqK3WJsRS+Tm013nUT2X90uCNslBrwNjjJFy5ULPAP11sLnxPFO4l2igJ44gk6xsgtNPZ4pguMuFIS/OTuWJ56S4YLKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159078; c=relaxed/simple;
	bh=1Nw5t+V3hG4GYVeJ9bxniQfF2BPdjgUPCEX5koQmsco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2epkuieb2PFLCWNLSITeNLbpln/Q6WVXzSkXxiZWPAwlz3CTsqMPR2kJtF1wI7tkSk8ZWm4WhZUSus5POmOSWOtcIWBCsEJqFmUoB6PS3w/edm8q1WKgHbeSBRuLhK1t15zdV+V3oEb05hYQQVYrj6F+eVxabtsFGmx6KZXOoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MFJEccS3; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MFJEccS3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ2jcp0dkEq2iBVU5lgMrWxj81F4hPZ0kZQf7yxZwxhPifVdTTTC0JchzAplL6xcOm/sHIdtss4EZ13HFE4vFnGvcHnE4xqX22nqA3jSpneRz4cdauxj6OEQYI6m61djFho+PwmBkpmYqZ7XMXMjSXozndPbffGmRILiQIjP2qGSZeHd5A79YNkZMIv2czO0+Jm396xOKGwg7b3xly5GWJHO0RVwKcNGZngKikC22NUrIjr5dUx3odSvbxMDjf0ZrHdbT5Esb//NsY5rJxBEgaSwOMb14z/J8NVyCUk2jpVnJ1gc0bzwSdzwihCktzou8aKwxYGbJB3JDz3W2GfCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OEyyjIVq/bFd6v45WAWyTY2vzwmJkfIHUDSVGtylNo=;
 b=G427CXVQzf3CfrgG7x4tm1C+Pkf+GgprTf2I3Yezu+IG9tLTSjYO0xCz7+Ui9bBrD910F0dhPqLK1Q5S/S60pLpRwmYBBgM8714FhNHjHN+KMMkORNlu2FIwHMq1PgyXX4lwivsD6kPapVfon1Gn1N1u0d8lDQe1UHgf0lR+TXBsAvX7HUI546fEm1SjvEwM5JDym7v8w331V7VcVKZiQ417R/LrdKVmfCedsOeNye8sTPaKtY7liczdDHIhL/IemiekGuy44CzhASS5OxVJcVF78q2c6I/UdwDcOP4UkfwfHJpTcvFWg76IzX8mvYV/i2GbHlO20mwIoeGdtvP9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OEyyjIVq/bFd6v45WAWyTY2vzwmJkfIHUDSVGtylNo=;
 b=MFJEccS3F3oNKU1z35WI5rFOPWz7pRD0TXabGDoxHKH3D/i2h/giENtRvCQQTvHJ/7fHHBjHEqK8uyHpJ2SLTGAcxiKvkDx7NswMZ2jxEyYKpB7JirE8Gt2/UGRXXsRCUITsl704REUwITfMZjDjUXD53K9TgU1xGy1kr9jas90=
Received: from SA0PR11CA0113.namprd11.prod.outlook.com (2603:10b6:806:d1::28)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:11 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::78) by SA0PR11CA0113.outlook.office365.com
 (2603:10b6:806:d1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:10 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:05 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 12/24] iommu/amd: Pass iommu and devid to amd_iommu_make_clear_dte()
Date: Mon, 27 Jul 2026 13:29:01 +0000
Message-ID: <20260727132913.22475-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: f5734366-d33b-4ddc-ffff-08deebe3528c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|7416014|376014|82310400026|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3xe3drxocekUlLvrjOPkcUYBJC+5K8UaGrQtXxVEl70WaY7l7HKMcRBCIVeolLii1+L0Qj+wLuJb3sHfbht8dDkuWWo5l4fBYzCgNYIPRMml2I0l2i7QYFFMHQb72kKhmdDjY7hSucGIDdo64by5NUMH8agF0kCAOvvpY0Pgfp1b+s1xgduuq0sJzSvsdYr8i7s66OzRdQCElYPINZ6+XQf3iN8XSvFCqlC4+d45hh/t3hnRMD59ttaGtveARyTAJUBQsXSHlVmfRccFg68Ahf+LozGMv0jnwt75A+qJDkNLmD/J5ODQGO24UU2VBYGAtDR9NM2q69tk5Qgw+mdoXH/Y2l1wl6/WgfIuK4xPc+VdKZ6GwbDlDAM9gLxLbHeLiu9z9KiLMo4ougo/d/CNl7kMQ+uzwpoZqcBTPglDOKXxF4lHqUpb74yo8WgYGrqESnBsMbSPuG0dNSID6P/GQy2H0e8A7jzWk0JI6cliAQwlCNBcGkwZy83xtapvevrYbzDG8K7QkquYOyuz76ufNHxikaLL17mbQ89CyRgr3yZLTkGxgEHenMtCv0OWkgsaFZBfPJOEFzIeEHDSnF1rQ8wkfEsfnX71ZAukUna5tIObk+UBu3fxQxTLXlbStw1UN2guZty/j8f80nlsR4Uojt0n63sy+OMgvQpohPXL2MyH2kN9Lb7VgVuMUauVn4mGGe54yoYt6Dpu8f2wDmI09g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(7416014)(376014)(82310400026)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MSW00JKatfuxd4dERlfgzj2yYkstpOBqoUJsIfcVnAmjkB4C86WyGIIntTW8LveS/ZDou5gen2QlTdeMoLUzpjD4SzR8pNEkE4XV9Bqo04mdVUtwl3qIuK1u66O06VtVL2h6A6slyetk8+JijhKf71ExOhkDF18xyPmG/IoWzvNLTlEZyRLCC53HtCpi/bmNiHT2N1Xrcw2P/RhQ64Mx28+Kio6LdBxS2DwOewqGanj4H25sL0Tm4UtmKbQeyl7bGEW0hXOXJgu+Z8cT1eEOBY2DX0hBZrDcR6OAY6kOSMNS2Cr2oxVWWcODxQDemGZLN8R/fVznb9PZCBAr4jBG76tuSGtmD/0YGKd53hyAduv0y9WJwW9l0IpJXrybAOjSoU3YGtR5WSEf6i4CJBkoAnMxZQVmr9LXGlMU490qtunYGGXCpN1KHp2a7KWn45na
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:10.7603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5734366-d33b-4ddc-ffff-08deebe3528c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360

Take struct amd_iommu and device ID explicitly instead of deriving
the IOMMU from struct iommu_dev_data.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 6 +++---
 drivers/iommu/amd/iommu.c     | 4 ++--
 drivers/iommu/amd/nested.c    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2aece7ffac2f..aecdfe6e9796 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -217,10 +217,10 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
 static inline void
-amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+amd_iommu_make_clear_dte(struct amd_iommu *iommu, u16 devid,
+			 struct dev_table_entry *new)
 {
 	struct dev_table_entry *initial_dte;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	/* All existing DTE must have V bit set */
 	new->data128[0] = DTE_FLAG_V;
@@ -230,7 +230,7 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 	 * Restore cached persistent DTE bits, which can be set by information
 	 * in IVRS table. See set_dev_entry_from_acpi().
 	 */
-	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, devid);
 	if (initial_dte) {
 		new->data128[0] |= initial_dte->data128[0];
 		new->data128[1] |= initial_dte->data128[1];
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 081448fc7b42..d6e18a2df9c7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2237,7 +2237,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	amd_iommu_make_clear_dte(dev_data, &new);
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
 
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	if (gcr3_info->gcr3_tbl)
@@ -2269,7 +2269,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_
 {
 	struct dev_table_entry new = {};
 
-	amd_iommu_make_clear_dte(dev_data, &new);
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
 	amd_iommu_update_dte(iommu, dev_data, &new);
 }
 
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 5b902598e68a..81a5ae00225e 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -200,7 +200,7 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
 		return;
 
 	parent = ndom->viommu->parent;
-	amd_iommu_make_clear_dte(dev_data, new);
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, new);
 
 	/* Retrieve the current pagetable info via the IOMMU PT API. */
 	pt_iommu_amdv1_hw_info(&parent->amdv1, &pt_info);
-- 
2.34.1

