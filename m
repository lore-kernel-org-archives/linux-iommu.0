Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EB737DE8E
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704472; cv=fail; b=ivhQZFC0EIpjLUVxAeRhCtbLht+9vtWsCAc0lWJcVhaJMGvKCA2ZIObLv/Wocmz/aqf93zpoE+WGPtoLA3AIQZay70YC0Q+2znfCmiWMeO6YLm3UurYGR76VrZP6UMH5E5650VDmQhy88C0ZB7EnfKKzmKPKUqfgnoNykHaTi3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704472; c=relaxed/simple;
	bh=UEfvAuI+yt7lKxtLOTigEmRRT+f0tj+jUk6wC/gtNnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpF5DHgSb+p+eDjPQ0ViSSvOxx9YKRcNDnw7fpvc3f9WI29621GxIrfhhf+hphYDW6bFzBc24yWQjF6m/PVGHT2U0LzbgoaKYSgXHRzC0KsOtqPQwQyT0Fzlf24Q9AOHJEX88efVaBtCG8PkMIpcR0dgxkaD29ZTaCU8qeT2Mwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YY2FCZbL; arc=fail smtp.client-ip=52.101.193.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YY2FCZbL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCdaI0MRM24XFDXdFjecAKRQaOKs2WhgFn7C7nbH99lOX4BU3D+7xvo80vUrJCep6o1GoE8O4/7vmAAun+dUineKPFmyqlS6U1AnPTDk2r9p5o0PKsl1sXi2VWkqi0fAvGO+UflPsbvnINrXLP8ccVo017twgeZvHjUSK6IGeUhms/KiagM+T7TDmSbLXweSQX1gDV76RZPXij2EpvmteYIV+Qnm8t0c+lI1EhkcEzWX4m/DFxXTeYOQrpnxf/I2kJuwnjN8P0cPQRAhVKKBVxzd0x98b25xMK0IeOAe3NAJXeUFdVFpfUBLKVVyW8UU1C81AIJPce1MSh4xL/LHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGIkeu4b+BWyL/7zjbWeTCeDGnnOByttXLyr9Ol7dZQ=;
 b=FNHc1XO1eeEkrGNgzaPzQo3NMX/v2epL1oYgWSQKI+rWbxfbi42Edbx96bF+3Vcx0f3k0V1scU+/T+GwLqA1flwuUZbsMlFfbxUyUC9r9dpDDjrR4cD2B1QSMDH8lI6K73YUMDGzBPkY+1WdvtpMSnRYQ0K1NiGhC9axj8P4zRHH7oJ+xjlZHyl1u5nmeBAKUgbjh4FE8iavENihkyuv7vmT3eNdo8dFFoz4bZKwBUuFrHtF2EFQri++reWX0lwYWk6l6I7zzUiZA7WxGCRQ8lVyaniKu5XJdLrWebZcag3HDVtI6U4nfkSN3Hbi/SrODiT/CZJ7t7Bls9QAWAty7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGIkeu4b+BWyL/7zjbWeTCeDGnnOByttXLyr9Ol7dZQ=;
 b=YY2FCZbLV4OwFEkZi+Sx1zH1TlaJ31n5G7tsvlHERRSGw3b0/E/j7sMf6dzOzR4AfGq+ypGrAD7ZTCBJtxAPSwTIaYjCetD81hvdKGD2s3AsLLNTusV3ER3TfS7SiZG6LojFku5DRJsXtiNWQP8hzRQcJ9R9URbWK6s1gnBCL+8=
Received: from IA1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::10)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 17:01:07 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:461:cafe::9a) by IA1P220CA0004.outlook.office365.com
 (2603:10b6:208:461::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 17:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 17:01:06 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 12:01:00 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <jon.grimm@amd.com>, <vasant.hegde@amd.com>,
	<frank.gorishek@amd.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 4/4] iommu/amd: Introduce boot option ivmd=seg:bus:dev.fun,start,size,flags
Date: Mon, 20 Apr 2026 17:00:33 +0000
Message-ID: <20260420170033.6780-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
References: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8e9e33-521e-4f18-b9e2-08de9efe69b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	K098V4Or+RP4bks6p1zujgA9umQdJQ3Pn4oL307+Qd965+jug4xyihEPLjGtJ/Gp8YRxlEW0S2rSOugKou3Y19H2sWgQn9luVlSY0iz0n4Be0mhlwdDDBGmYlq+yacj5QnS/4foz1hnC2dYFPeveEG6bIPK3CJLbXP++0OFX50Tc1Kxl4mTfwjMSTGiDst8rpFpw3yjqb1CqEI+QyW7aLHhoV9KLrUqJS0a1s5OGiAa/IX5uerOz0Pt50iH9iicDgmsNPzMj0HuW9HxsV0YAWizthdvVtlYXfUBOBarWZFyrWW1hZJHxiR76hIUsOPWAMqxmpT+HtBysXCv1WKhuW3BUzo0pJNsArBsGi8WYd4Ti5QdFe/yaFTMxYyl3hIA49DpMyFDG/CEpnFzQ1W2HrkvpQiebSWM2ilvy7npYRqvQ1w67CVJS25pa0xZa+MbxWDgtb50Uh6uEtG39fSUOwHvXGfVCyAsROi6CXQLehYe0nT2JmR2rPxhl2FFmXCO4Ym6rvvGv1TerLei09kGdXLSwHJlE7ur4KhV1JWTW7XrJeBzwMBMASyF89x8/NcjwIRF29w9bhsnzTlBcTg+Xbo5Lvwbzu2yBKLF5E/CAbAsXIB7JwyxFJmFDm2QRJY3ykNRXwBm2tpIx8cjj8hjF2ng9SklNEU7KEIbk1N7+OUQdhiPXxgayaUmP1ynFqGOrjemumksUV0B7iEQ2BI8m473rCkpAyu5evYMorU3ecpQcIG5K4ONgt9cK8R1NwaN5f2JZiW933nVIc9m1cV5bHw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B+duiVx2B7PHrUSpJYHaBI26knsX6tFV5UURAmiiP6kjtc3Ekdc3PcEQJoRNhNwBMyHAolZKxstpurrrjhRXKvnwP21J+XrX67rEPuQWf9cbQjnFJz6vDCvQmDB7x5kFfzdaSLUETrsO2K3zBdcRrHNx2hegcoKiwz4PR9pNZIdcxahGsofM9JsvjjbObJXWqCzprK7ps385aYSfrbnMGlA89aEp5w68E+7S7dwcXUl5mIQWyrZ98a3l+Rs6gBmjt5g5dZ2BPJMu44G3BZSzx5VYsbUiaWeYHWUKE70qOcUxC8Qa1akZS4hwlOwGoqIorUw9GYu3udvDHDhyz0ljCqiCgQz9hkMx41jv5tmJQIh7x/we3+TFff1sIvzHrvV4+diDcwbmdgQCzNu6vimXbBxAVx+qC6DdoltXe3rWJLrmQftUHIJ4gJh+k8x0yLb8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:01:06.5341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8e9e33-521e-4f18-b9e2-08de9efe69b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068

IVRS table contains IVMD blocks, which allow firmware to specify memory
usage requirements to communicate to system software based on its needs
or on hardware characteristics. Each IVMD entry may be per-device, range
of devices.

Some BIOS specify incorrect or missing IVMD entry. Introduce a new ivmd
boot option to allow user to specify up-to 4 per-device IVMD entries at
boot time. The entries are stored during driver initialization, and will
be added to the per-segment ivmd_entry_map so that they can be included
during struct iommu_ops.get_resv_regions.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  16 +++
 drivers/iommu/amd/amd_iommu_types.h           |  14 +++
 drivers/iommu/amd/init.c                      | 104 +++++++++++++++++-
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a550630644..e680a258008f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2897,6 +2897,22 @@ Kernel parameters
 			  PCI device ID 00:14.5, write the parameter as:
 				ivrs_acpihid[0001:00:14.5]=AMD0020:0
 
+	ivmd		[HW,X86-64]
+			Supplement IVMD unity mapping or exclusion ranges from
+			the kernel command line (in addition to the IVRS ACPI
+			table). May be specified multiple times.
+
+			Form:
+				ivmd=segment:bus:dev.fn,start,length,flags
+
+			start and length are byte counts (decimal or 0x hex).
+			flags is the IVMD flags byte (UNITY, IR, IW, EXCL bits
+			per the AMD IOMMU specification). Use segment 0 for
+			PCI segment zero.
+
+			Example:
+				ivmd=0000:00:01.0,0xe0000000,0x100000,0xb
+
 	js=		[HW,JOY] Analog joystick
 			See Documentation/input/joydev/joystick.rst.
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e93b4b857dde..25a5bbd8ec03 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -893,6 +893,20 @@ struct ivmd_entry {
 	u8 flags;
 };
 
+/*
+ * IVMD-style ranges from ivrs_ivmd=... ; applied in
+ * init_memory_definitions() once per-PCI-segment
+ * ivmd_entry_map exists.
+ */
+struct ivmd_cmdline {
+	struct list_head list;
+	u16 pci_seg;
+	u16 devid;
+	u64 range_start;
+	u64 range_length;
+	u8 flags;
+};
+
 /*
  * Data structures for device handling
  */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 4b62bb89a12c..7d60143d4711 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -208,10 +208,12 @@ enum iommu_init_state {
 static struct devid_map __initdata early_ioapic_map[EARLY_MAP_SIZE];
 static struct devid_map __initdata early_hpet_map[EARLY_MAP_SIZE];
 static struct acpihid_map_entry __initdata early_acpihid_map[EARLY_MAP_SIZE];
+static struct ivmd_cmdline early_ivmd_cmdline_map[EARLY_MAP_SIZE] __initdata;
 
 static int __initdata early_ioapic_map_size;
 static int __initdata early_hpet_map_size;
 static int __initdata early_acpihid_map_size;
+static int early_ivmd_cmdline_map_size __initdata;
 
 static bool __initdata cmdline_maps;
 
@@ -2653,6 +2655,47 @@ static int __init init_ivmd_map_range(struct ivmd_header *m,
 	return 0;
 }
 
+static int __init apply_ivmd_cmdline_entries(struct acpi_table_header *ivrs_base)
+{
+	int i;
+	struct ivmd_entry *e;
+	struct amd_iommu_pci_seg *pci_seg;
+
+	for (i = 0; i < early_ivmd_cmdline_map_size; i++) {
+		struct ivmd_cmdline *cmd = &early_ivmd_cmdline_map[i];
+
+		pci_seg = get_pci_segment(cmd->pci_seg, ivrs_base);
+		if (!pci_seg) {
+			pr_err("ivmd: PCI segment %#x unavailable\n",
+			       cmd->pci_seg);
+			continue;
+		}
+
+		if (cmd->devid > pci_seg->last_bdf) {
+			pr_err("%s: requestor %#x:%#02x:%#02x.%#02x exceeds segment %#x last BDF %#x\n",
+			       __func__, cmd->pci_seg, PCI_BUS_NUM(cmd->devid),
+			       PCI_SLOT(cmd->devid), PCI_FUNC(cmd->devid),
+			       pci_seg->id, pci_seg->last_bdf);
+			continue;
+		}
+
+		e = kzalloc(sizeof(*e), GFP_KERNEL);
+		if (!e) {
+			kfree(cmd);
+			return -ENOMEM;
+		}
+
+		e->devid_start = cmd->devid;
+		e->devid_end = cmd->devid;
+		e->address_start = PAGE_ALIGN(cmd->range_start);
+		e->address_end = e->address_start + PAGE_ALIGN(cmd->range_length);
+		e->flags = cmd->flags;
+		list_add_tail(&e->list, &pci_seg->ivmd_entry_map);
+	}
+
+	return 0;
+}
+
 /* iterates over all memory definitions we find in the ACPI table */
 static int __init init_memory_definitions(struct acpi_table_header *table)
 {
@@ -2670,7 +2713,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 		p += m->length;
 	}
 
-	return 0;
+	return apply_ivmd_cmdline_entries(table);
 }
 
 /*
@@ -3812,12 +3855,71 @@ static int __init parse_ivrs_acpihid(char *str)
 	return 1;
 }
 
+/*
+ * ivmd=seg:bus:dev.fn,start,length,flags
+ *
+ * start and length are in bytes (decimal or 0x hex). flags is the IVMD flags
+ * byte (IVMD_FLAG_UNITY, IVMD_FLAG_IR, IVMD_FLAG_IW, IVMD_FLAG_EXCL). May be
+ * repeated for multiple ranges.
+ */
+static int __init parse_ivmd(char *str)
+{
+	u32 seg, bus, dev, fn;
+	unsigned long long range_start, range_len;
+	unsigned int flags;
+	struct ivmd_cmdline *cmd;
+
+	if (!str)
+		goto invalid;
+
+	if (sscanf(str, "%x:%x:%x.%x,%llu,%llu,%x",
+		   &seg, &bus, &dev, &fn, &range_start,
+		   &range_len, &flags) != 7)
+		goto invalid;
+
+	if (flags & ~IVMD_FLAG_MASK) {
+		pr_err("%s: flags %#x contains unknown flags\n", __func__, flags);
+		return 1;
+	}
+
+	if (!(flags & (IVMD_FLAG_UNITY | IVMD_FLAG_EXCL)))
+		pr_warn("%s: flags %#02x omit UNITY/EXCL; entry may have no effect\n",
+			__func__, (u8)flags);
+
+	if (early_ivmd_cmdline_map_size == EARLY_MAP_SIZE) {
+		pr_err("%s: Early IVMD command line map overflow - ignoring ivmd=%s\n",
+			__func__, str);
+		return 1;
+	}
+
+	cmd = &early_ivmd_cmdline_map[early_ivmd_cmdline_map_size];
+	early_ivmd_cmdline_map_size++;
+
+	cmd->pci_seg = (u16)seg;
+	cmd->devid = PCI_DEVID(bus & 0xff, PCI_DEVFN(dev & 0x1f, fn & 0x7));
+	cmd->range_start = range_start;
+	cmd->range_length = range_len;
+	cmd->flags = (u8)flags;
+
+	pr_info("%s: segment=%04x dev=%02x:%02x.%x start=%#llx len=%#llx flags=%#02x\n",
+		__func__, cmd->pci_seg,
+		PCI_BUS_NUM(cmd->devid), PCI_SLOT(cmd->devid),
+		PCI_FUNC(cmd->devid), range_start, range_len, cmd->flags);
+
+	return 1;
+
+invalid:
+	pr_err("Invalid command line: ivmd=%s\n", str ? str : "");
+	return 1;
+}
+
 __setup("amd_iommu_dump",	parse_amd_iommu_dump);
 __setup("amd_iommu=",		parse_amd_iommu_options);
 __setup("amd_iommu_intr=",	parse_amd_iommu_intr);
 __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
 __setup("ivrs_acpihid",		parse_ivrs_acpihid);
+__setup("ivmd=",		parse_ivmd);
 
 bool amd_iommu_pasid_supported(void)
 {
-- 
2.34.1

