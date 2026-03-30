Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100753B2FD0
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860204; cv=fail; b=Dg3MhlURmrwZpFXKH8fMtsG5RVazSchf37n+9oPBgPh6tYIM2Dbf4rKkJ88yqypH3cbkZiJPrBkY0SI+ZXRj3/zPgxWws+isXylzTRT6wY/ug1SIqOUwk4WBFSMWi0dzsWJHEHjgFTt8rjZYn3m9E7/iLcA05cszc55ifbVSIrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860204; c=relaxed/simple;
	bh=4HIaQ6gX/EI5D80N44xXtk/+aE21umindZ0uqIK9lR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbQJrN53Ff95+jusikPMjzDHf1ayC5hOYXugfUl86HLr8TiSQWM/l/LFnBsO0AG/Wl99YOHPDiGQqRFr5DcVEUWUQuFXuO0doKCO73/z/L2MYCypc85DLvEgLc9JqOdip6tbhQEov8lxMTGBNArb8eLm9oj3SOo/VKJY47BWPP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nD4qH7Qp; arc=fail smtp.client-ip=40.93.195.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nD4qH7Qp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqNiuBOunzVjUUomQquPk1Wq/vVYa4LlbeZ/3ulsxSBWFwISWroPPqasFM8eMaf22M12/2H39+YczLkyssj+TqOTf1xlwIYDsJg+2rRvw97MaiKEnRE8EeC7ReUpYFJ9PKV0N55r8I1yXWPKYPCoO6cbnDP/nrZuTpBKmF3zmuYprnYZozafnyPpWvtWa2CWBAmtK4AVPpxtfsUDr4smrUrNoG/ejD5bmMUzez8CxkeOXckn3qb3SwFkwnPTHrBLSmvCrq7Tchvwy+oggIvbeeu1AyTKqx7GEtBPMjUfv1zmFm7RGEe7Ju/giKbIz788c9pWx80d9S8gGeE+voFZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wkJSPkk2nKwVFpRQ9jTFCSBhzrIrf4xcJVBP1baZTA=;
 b=CGBDjAJxuMKctD9ODKrViYjlxxJ6sUwo/c3dI+zFrT6oTZ/Gg60cN8kOKZzwO1/Bxzk1T0O9U02gbA3SSIrusphyvk91r5QaZqIOru2hEf/2VCmy4YlrDXlU0SD6J8C95Gs+euXfwx650GqctrnKfV9vxyX8+XRk3H3jyHAgnPpi5MrEhuY5V+n/DDgvzvZ27uG7kVB9ROOqjfTJ8ZN6DKBxGSA/kKqsmQ+OR98f+0HtACnNKuJGo18qkOrlKJT/bksAi98TrfYEm5TtN1on8S+wg+ZWIQ4p0evvxawgdQ9bH7iIMUVhp8cNxDcOaYB0LOrvWdMgA1J7Qs/v87VFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wkJSPkk2nKwVFpRQ9jTFCSBhzrIrf4xcJVBP1baZTA=;
 b=nD4qH7QpLTxZotX+OS+gMlr8ozdbIVqouQol2Fdak6u78JASnCQyo7lcrODOZ0U+EZkt6nWFQ53Rc7HzKkxvWeHnuUD1WBA7Y65Q+A8RyctmkMMF+qCYASsxRidLr8dQQG15cEjmt9sOXQLBU2bh0xmHBAvXhSLs5ZKbc+DVd4M=
Received: from DM6PR04CA0015.namprd04.prod.outlook.com (2603:10b6:5:334::20)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:43:19 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::ff) by DM6PR04CA0015.outlook.office365.com
 (2603:10b6:5:334::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:19 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:14 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 08/22] iommu/amd: Introduce Reset vMMIO Command
Date: Mon, 30 Mar 2026 08:41:52 +0000
Message-ID: <20260330084206.9251-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: 34521e2d-16d7-4af7-c37c-08de8e3864aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vSpMdIx1mQkA8VCt6BQ7d0UjbG22xJqTdm9GUMasb+GLoPnksGzIqMkHHAuviI9F7qiT2Mi2uJftoYZ8V5pC9OYqKdnsXFdOUUIaTcjgmi0P/8Q/kbEEN9GX+ALm80DPBUQnES88pou338O9gzTfH5CsXmGOtAfF3C8vLhxf9yOuKFmBBR8UdzVIR71rrHem+BDPeFzN1QwXW/PFwnwhNdplEx83qu7pyPTtLUMu2G9fSCLu0LK+0Wx2VRHXFTrT5XuTsOPIdcBN5ynMgHcZ83nC3+3sfAhdM/fVhWkPw+bkMZ62s+kbGFgnyo0Qct8/N4tP9xkZBsPIJqQv62BdJOhkm1uHrXacF8/eH4izFNkdvm1zZAq04TNEBErUyk0Kluev5QN8VzTh5oknH828mzXp8Vq+vme2fwdCcFEChRps+wvx3qWJSEj5mEVE7pT4EeupkvhMzAeHeAYVgryxiHLw6VhXsovankPPmhq0ntBhsnrWjyV0WyDGxwTCkTSvZB81F/8GULqtyqMsi4DUCY+tJiZ1+n5G3ZCodRst7el6OWFRnXg/cJXS3kwOXSB0IwpoXbTMjQ4WNJ8OjoK+UNb2LRcYTJqph/37cv0SF15zy08HaIrCoIbJUWEDzHmW58YtR/Ia45xZZ/mRBnes/GOyyM5hP+5NOeVqjhqZw7PkCYkbxxuOwqjpoY/9/pvMcdBv/EKtTREoM0v2aElVAm9ELFviJA0mNbf44ubr5L3l9mVEcnrkujzhEZ/bSk34Na+wf25jubT5Nzin2WkFmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m7bUI/saXhMgKsM7WIa9SO7zkebaQapriCJAf7POuv16/F+OfPmoULSAHDQ6h40vuwwapX92Y9gw9OS9MQ27kSrFOFMD+xT2MFwuZiETUa2mjeftRjbhR/q2CEoWh8dAAJldTkwpsiPeU05T2HlLkKBWp1ZNBswdOBNgnSagm3AXJ/O/Rw/lgDJAz7L0guOJlZG8AuQXfYyxbU8Il1MVGhV1TFFTTKCRnxcDwe3A1i+1tYxNqAxIm9dWMOKIWyPO9XN8aSObI2pueRVnQptYx8zSr7sU44XZd/CxMhCutJSPrIDFwoyaSJ6nEAF85VtZKyF25qOQ+LzNhCpKS7Hr9K50bFU3YcgRNqyUaidzBIzJpzkNOa2JX1np88jiRGh8wNKTQsMNbwzaJJA+gNGJrbqFZ+Ra3bVt5Hij2KIMIQ+I1mSkyAx1rRlHAVwCpW/B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:19.0617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34521e2d-16d7-4af7-c37c-08de8e3864aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054

Introduce new IOMMU commands for vIOMMU to reset
virtualized MMIO registers of a particular guest.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 22 ++++++++++++++++++++++
 drivers/iommu/amd/iommufd.c         |  3 +++
 4 files changed, 27 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 470e5d98c52b..f1fafa21777d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -11,6 +11,7 @@
 
 #include "amd_iommu_types.h"
 
+void iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid);
 irqreturn_t amd_iommu_int_thread(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f0e18a7dd7f2..53854a4f4307 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -221,6 +221,7 @@
 #define CMD_INV_IRT		0x05
 #define CMD_COMPLETE_PPR	0x07
 #define CMD_INV_ALL		0x08
+#define CMD_RESET_VMMIO		0x0A
 
 #define CMD_COMPL_WAIT_STORE_MASK	0x01
 #define CMD_COMPL_WAIT_INT_MASK		0x02
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 037a50397f31..191a52b657c1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1429,6 +1429,18 @@ static void build_inv_irt(struct iommu_cmd *cmd, u16 devid)
 	CMD_SET_TYPE(cmd, CMD_INV_IRT);
 }
 
+static void build_reset_vmmio(struct iommu_cmd *cmd, u16 gid,
+			      bool vcmd, bool all)
+{
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->data[0] = gid;
+	if (all)
+		cmd->data[0] |= (1 << 28);
+	if (vcmd)
+		cmd->data[0] |= (1 << 31);
+	CMD_SET_TYPE(cmd, CMD_RESET_VMMIO);
+}
+
 /*
  * Writes the command to the IOMMUs command buffer and informs the
  * hardware about the new command.
@@ -1663,6 +1675,16 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
 	}
 }
 
+void iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid)
+{
+	struct iommu_cmd cmd;
+
+	build_reset_vmmio(&cmd, gid, 1, 1);
+
+	iommu_queue_command(iommu, &cmd);
+	amd_iommu_completion_wait(iommu);
+}
+
 /*
  * Command send function for flushing on-device TLB
  */
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 5dcd3fc3ba99..06d6aa87cdcd 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -79,6 +79,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	if (ret)
 		goto err_out;
 
+	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
+	iommu_reset_vmmio(iommu, aviommu->gid);
+
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					reserved);
-- 
2.34.1

