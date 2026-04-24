Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EC2386C3E
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022570; cv=fail; b=gd8aw2b24LKPS7Hf++QrFufyCxDNcTK0hEha2e0EsQNugKhJTgGvBkZLLUFiuXHw28VJtAhCwuC+r5HKiBarYjobNPDAXFuCKy52ABSZaZm/9tc5RoGUOxkeczlWNE6d9RhM3Kh0LEvCOyBnDmFFasb7Q740tQlqYghvHF3Aepw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022570; c=relaxed/simple;
	bh=MS1bnE/lcPxHS2a/dMjjj55O8vRWDYyH4lxRGUVSKds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8hevqx0rmsebFLTG6j228FujJIqy8k3B88+d1UkREIcSFqw2SDQxrxGVAg1qFe6fLdfhF2r4jgcQ7C7fLUqg2tYhKpSPDjb/1ZrLGb+T/4tyx8IwhRs0Nm9MH/9POvPtzWNL2Suxm2GP8pAf6LIqld8QY9AploAPkxFDgN4xp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mJ5xWhtD; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mJ5xWhtD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qmv9jwSClm3rSODU79scSkLQsDY5hw0T2XMG9otzbpg42gCJ/0HkvLem5RD5Vr5Wg3/32iJOXr0xdIK9Xmw1LSGT5ofZCQw1nVux+ls+Goi/xGUWC8MSRm/TnIxkinhTPM1pxn3wRsgiG8nwllVeLWwkfQns2s5xTPYvyts3PDVWVDANUHHgkxjRiVlPwZxTevP4vukbDtgiWDSijC7LQ7DBQcT84SuomfIbU+QQDGe84Sl7gSm0UB13+dV/YzRpNGiNtlYFpjTIbEYELRjh+E8ivV7Lz69ewozorDZwaxE2Ws5rP7DyXcfK82y2h8rMfu2cUGMzzrbS4ULxrYc26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iobC8+fBn1zRaKaB7kP1X6EpxRUnbxprao61PwXD1Ug=;
 b=AdwzucmmlbORQW/ajDdPOUrnFejGpQFkkbXRSxIt+BbB+S32OgsspDo65HXW5yV8tvsjlDQRZHolxiowiWYD5jhZNnJTjSgt/pSeifX1yR1l2KAiAU/4RUTEC2NhTYqwlf1jXNCZfuS8jG5jftqiuTGDJZ8kVB14X/D1zDRD/K8xrkn094TrjLKXruPxWxwzJmpv2VTNcP27bN704i/2sovJdjiQij6pcCDiQvlaq61zzyCdl8Wj/mMTQ1lSLg6Fvy2N3PTBkVF77JzDQV1+hX5ZrkOjftc6Wl0oiFX0UYJCgdT9+0eUBbjJyhZ6G5StEYYGzyBbEkc5684lPxFNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iobC8+fBn1zRaKaB7kP1X6EpxRUnbxprao61PwXD1Ug=;
 b=mJ5xWhtD7/9L7FlX9baquerWamXkZI2kkfmJF+o/biQcWA0I43ggZIihJ10wbfbAxAGzKxshV6ACQyaM+lCKBwJwexbpzwquIJiMyUWVtBn7nfhPs4kXm9j0eog65Gy9xpf3ZpseZiM+1Ea3RMIiexIE0ueqfQ51KTaO8CjcO1Y=
Received: from CH0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::7) by
 CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Fri, 24 Apr 2026 09:22:44 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::5) by CH0P220CA0028.outlook.office365.com
 (2603:10b6:610:ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 09:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 09:22:43 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 04:22:40 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <jon.grimm@amd.com>, <vasant.hegde@amd.com>,
	<frank.gorishek@amd.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 4/4] iommu/amd: Introduce boot option ivmd=seg:bus:dev.fun,start,size,flags
Date: Fri, 24 Apr 2026 09:22:13 +0000
Message-ID: <20260424092213.16976-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
References: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 8323da29-216f-4a59-7db2-08dea1e30a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YRdfQ8CNlhsQFi2cSkMmNMpyBV6UnfFde2+NUCBoriRohKhmG7bQ1P6cDmQ6nLc8KtO1hRNnBnbDtNg4msQPqZyfF5ccRmaXKAdZvHCC5duQHmkx0ZBzH1Q1gKOl8g5PcBt9qhe5KzBW8f3LjIAf5uI77zky2Si7FHttM0c4exBG5StHPbjiMeWqR6BjSfD79opEmN+vn2T8S0WVr+oic2WZshI+JM0eLR32AEsKl6sLGQUha7DTJty2XA8VDIFs7mYdqoepWx3IFFAQw3hHQbziUgh1B/7DjER/75k2GOCTIWdc99GPmpOn77Fhj0WuvI8VGHdIboEqsvY+0gcAGSZpBuM6LsjEG3Zgc5d8GTr0ik9HiGyKvvxVDMuHJx2tkTEMRUZn4heQRDkG7SufqvBI1k/ocZEHSeb3nDLQx0zJ8RRZ+/GDURFSxm/ilFVzPc9v4u+pZVaUNpNJskj5gv+k6AXdgX189fwNGnUL4GnZXqwb8NtemXoy+CrfbkA8SbDogMT4+F9yJdXtaQVcdTins43mkByaK5aVwv2gTGJZkkzgG+s98omyKtWMbOud/61zD9FT+BOnWpwcIjcggHsKCd/HFJaIlnU3CO5+Gln9n3lgfjgzJVAyKRVIw8gsJxN7OymwTBeakS3VTEYFf2AqSFhXNJkQU6PuFOSxE/ZUyhRIkzxh+TAuxfDtDhgeJ//NEQVY8t1iaXN8ai2y2mFEGRTVAq/l7oojMzHIctDiVyKGpONtka6QkS6pdvfBeOgX0uBKwtlFF/UkT/7LOQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rAqFIbe9NBy1AOGnPOyQJ+IPlKqzRb2BXIObwIrU3+EjA/jHuauYS40OpnSyYP+ekss59QzYifvWTfd8Le1VTFqNE+iKIKbzaRB97ca723q3x69roElbZdjuTuU4lc5vHSzR8rQ7dy3W0btUQJPiCkii3lfZ2bBByAH1/x9L39f4qLerE3BfJfCBH4Bx4VfUMgm2H4YRsqsumCjm4thynkHd30LKpvo/4UZaxSHH6Vvk6n+l76YDNMSfHH1eiqFtSRxF9+lLp64tG0uMRQ4olBfB4i5XBlxNHtH+jpD/9tMUEr7HerGzwSwNQ40DVh+sPurEuLOX6Y02OGQyLfzSgDSZIl1hF+fLbIueidb8qlIr15dqvdvmjcrmVZK8q4ZQsVj71F1ywpN0Q0KKV8BN3H3vK/e+Dm7V1/2oGIm2TrGDXop6v0lhtL+nA5Zqf/Ge
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:22:43.7251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8323da29-216f-4a59-7db2-08dea1e30a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056

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
index 9321b7cc200b..4f3387dd7fab 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -892,6 +892,20 @@ struct ivmd_entry {
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
index 4b62bb89a12c..1d51fa7d1217 100644
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
+			pr_err("%s: PCI segment %#x unavailable\n",
+			       __func__, cmd->pci_seg);
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
+			pr_err("%s: Failed to allocate ivmd entry\n", __func__);
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
+	if (sscanf(str, "%x:%x:%x.%x,%llx,%llx,%x",
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

