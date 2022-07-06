Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1533C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsG2jPWmYrJLvmgFr297v0eKHp8L7bMHK0FjKnfzsQ0O6PUZ5p3mMch9Bvti6P7t4UrYpKp26mrcJFook5Ui5U4/Kv3UzH6hPpSngHaF/gSMbO/v+zi4Sdc2aRujNWzWSM3yrNSH3th3y+YGgooP8gGxAUB2pg14VpwuoyuHM7/U/k1+jzNkaYjYSAPwApmFhPB0QSz60evz/4cVFqkIh4YtMoH2jVpuxeBPdKV+mWfI8tmQ5VN8uHXefizf3Gkjil+FPUAfGMtSQ5Aoi0iTvfRgoCt2bCqdVoi3j/WGSZFL3AOfm9O7apEONf35/at4bBBw9zssxJqwYq6NlmyTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLBUHEN4LsbByLlYQLaO1PuQOXjdr9j7Ty+aRlRbqjY=;
 b=ney3YzaWfGj4N4d2/oaghhoTjdP2SUuibNyh8KhHPF8WG3PhXEpEc6CswmphirXqBPVASCojXxGwqg1ZjUtlsr7qYoUE9d3y86Iq8TF5wKr9aH/lYm9T0crK9DffiHAKdynIofRDR1li98T99VLqr8sni2ZWSzZT83LFsixFKattcU208F+zHorPw3U6jQJGNqTIKpI1VbGHLxhnlMZ2jihPyj1ksM5K/QRjfCynXm7HiayWpKJ3GNFr7vv6z8i4O3HS/dTHEKqmNFBx+nP4ByChpIPs+ipmbv9y2VRkSj5NerSsGVxBUf5WjHJ5Y5HfaLrPacm1w0sgXyHCJR0shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLBUHEN4LsbByLlYQLaO1PuQOXjdr9j7Ty+aRlRbqjY=;
 b=l5dONllBe/hC5PNr1AaEsnzvoXbCyrdO7J9U76BkzbIiWbIfRweioKheEGZ/eJo3AiMy7ubpj1jWI6ctNKf9ECcu1j5HnxRVRNlTmjCFdH4vMikjXGVgNdOq9t9lrZ3sgGQTfmiQsLC4updc2MKYHkzyZ+dpuF3xnC0oPh5MFUw=
Received: from MWHPR22CA0061.namprd22.prod.outlook.com (2603:10b6:300:12a::23)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 11:50:06 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::32) by MWHPR22CA0061.outlook.office365.com
 (2603:10b6:300:12a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22 via Frontend
 Transport; Wed, 6 Jul 2022 11:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:50:05 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:50:02 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 30/35] iommu/amd: Include PCI segment ID when initialize IOMMU
Date: Wed, 6 Jul 2022 17:08:20 +0530
Message-ID: <20220706113825.25582-31-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dee60d2-821d-4331-aa9b-08da5f45ab42
X-MS-TrafficTypeDiagnostic: MN2PR12MB4405:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f3nVm5cB1g1iiQHYwOMp+TT5kWwEqUqvDCRneAKdkuW1n4Ef8cmhggI4Mo6dmZ54y6Aab1B69BX9GB1nXN0mD4NOzMilZ/UDg8YXZPpid/rCJOyPUgcexunQxLSnOGM2Ch04UelGX9GWNDmNSl+KpQpFN7Vg+MM4hBpygdfaWHIwxCDKrQgu/a585MS0KCdUR8OQaD1qWPD/wpTWRWW3Mp2YN8Lmziz0/aeGtV/+/kMChfKw4Bt9GgMH/U8gfhT2befpCNwAeLkb7N2Um/8u1fIPebxoWltgRTDKzz9A23MikWfiNIWYtR953hW2RDhhugNyN6ItrUIvSs7DZbBiZSaCAD0QwUA0Xw+inwSN8Vnn+6UMkVwA9ZEugW5YX+/b62yzRPKNn/rsynM5qqkWqkhG5G5QpLPDUe6ZwJaukupJLxhi1aM29td11ZqPGL4U2Af8OtPiICbfoFEqj843KZ7IgKLY5CSNFkRT8AcgoQo9LgZKAIIZkOfmaRgwn+UmJdpnDMhi2rSx6bifPkhg5XC222c4q6ZpctYxLCTFq7cr5yMVsLVa6PJvHbRT7b22DVDRFJuTrfFvRe1Y5YwqQh8RgKgTBBHvOO+M64H7SW91wZFjvDCbNYS0Fe+t6Wcso7w+x5uTaTUhQbvrjWoPtnwmjhAD/WrG84AfmsjbAK/C5pRzItOjJIGGEtoy/MTBzADcKZ0n951HMIP5a9aVesyFjprkpuJb5eq79QhL2qblR8KASXRFLLEIU7f/gCshGqJe2FkD3m7ozJySrn78md7wzqMA0ulEdBi5tgFvuJj+R79nWfj/ZbMjZY2ABT0IoeZ0Y4N2RQcw+Zi77ExXcDTf1hYDEBzhKGpKb2WEInA5dI1rDGKPj/4F/9pU3hEc
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(40470700004)(46966006)(34020700004)(36860700001)(82310400005)(478600001)(86362001)(40460700003)(82740400003)(5660300002)(8936002)(6666004)(2906002)(41300700001)(316002)(81166007)(356005)(44832011)(110136005)(70586007)(4326008)(8676002)(70206006)(426003)(47076005)(16526019)(336012)(40480700001)(186003)(54906003)(83380400001)(7696005)(26005)(36756003)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:50:05.5126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dee60d2-821d-4331-aa9b-08da5f45ab42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
Message-ID: <20220706113820.Fm7i3OapRyxOSYEf1Lrj_uEpjEl9vixcjFC1nfV0pZE@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Extend current device ID variables to 32-bit to include the 16-bit
segment ID when parsing device information from IVRS table to initialize
each IOMMU.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +-
 drivers/iommu/amd/amd_iommu_types.h |  6 ++--
 drivers/iommu/amd/init.c            | 56 +++++++++++++++--------------
 drivers/iommu/amd/quirks.c          |  4 +--
 4 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index e73bd48fc716..9b7092182ca7 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -125,7 +125,7 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
 
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct device *dev);
-extern int __init add_special_device(u8 type, u8 id, u16 *devid,
+extern int __init add_special_device(u8 type, u8 id, u32 *devid,
 				     bool cmd_line);
 
 #ifdef CONFIG_DMI
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ea238e8e6c99..1ca54803702a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -744,8 +744,8 @@ struct acpihid_map_entry {
 	struct list_head list;
 	u8 uid[ACPIHID_UID_LEN];
 	u8 hid[ACPIHID_HID_LEN];
-	u16 devid;
-	u16 root_devid;
+	u32 devid;
+	u32 root_devid;
 	bool cmd_line;
 	struct iommu_group *group;
 };
@@ -753,7 +753,7 @@ struct acpihid_map_entry {
 struct devid_map {
 	struct list_head list;
 	u8 id;
-	u16 devid;
+	u32 devid;
 	bool cmd_line;
 };
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index df8f4b9d20cd..d35081d84460 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1148,7 +1148,7 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 	amd_iommu_set_rlookup_table(iommu, devid);
 }
 
-int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
+int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line)
 {
 	struct devid_map *entry;
 	struct list_head *list;
@@ -1185,7 +1185,7 @@ int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
 	return 0;
 }
 
-static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u16 *devid,
+static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u32 *devid,
 				      bool cmd_line)
 {
 	struct acpihid_map_entry *entry;
@@ -1264,7 +1264,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 {
 	u8 *p = (u8 *)h;
 	u8 *end = p, flags = 0;
-	u16 devid = 0, devid_start = 0, devid_to = 0;
+	u16 devid = 0, devid_start = 0, devid_to = 0, seg_id;
 	u32 dev_i, ext_flags = 0;
 	bool alias = false;
 	struct ivhd_entry *e;
@@ -1300,6 +1300,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 	while (p < end) {
 		e = (struct ivhd_entry *)p;
+		seg_id = pci_seg->id;
+
 		switch (e->type) {
 		case IVHD_DEV_ALL:
 
@@ -1310,9 +1312,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_SELECT:
 
-			DUMP_printk("  DEV_SELECT\t\t\t devid: %02x:%02x.%x "
+			DUMP_printk("  DEV_SELECT\t\t\t devid: %04x:%02x:%02x.%x "
 				    "flags: %02x\n",
-				    PCI_BUS_NUM(e->devid),
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags);
@@ -1323,8 +1325,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_SELECT_RANGE_START:
 
 			DUMP_printk("  DEV_SELECT_RANGE_START\t "
-				    "devid: %02x:%02x.%x flags: %02x\n",
-				    PCI_BUS_NUM(e->devid),
+				    "devid: %04x:%02x:%02x.%x flags: %02x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags);
@@ -1336,9 +1338,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_ALIAS:
 
-			DUMP_printk("  DEV_ALIAS\t\t\t devid: %02x:%02x.%x "
+			DUMP_printk("  DEV_ALIAS\t\t\t devid: %04x:%02x:%02x.%x "
 				    "flags: %02x devid_to: %02x:%02x.%x\n",
-				    PCI_BUS_NUM(e->devid),
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags,
@@ -1355,13 +1357,13 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_ALIAS_RANGE:
 
 			DUMP_printk("  DEV_ALIAS_RANGE\t\t "
-				    "devid: %02x:%02x.%x flags: %02x "
-				    "devid_to: %02x:%02x.%x\n",
-				    PCI_BUS_NUM(e->devid),
+				    "devid: %04x:%02x:%02x.%x flags: %02x "
+				    "devid_to: %04x:%02x:%02x.%x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags,
-				    PCI_BUS_NUM(e->ext >> 8),
+				    seg_id, PCI_BUS_NUM(e->ext >> 8),
 				    PCI_SLOT(e->ext >> 8),
 				    PCI_FUNC(e->ext >> 8));
 
@@ -1373,9 +1375,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_EXT_SELECT:
 
-			DUMP_printk("  DEV_EXT_SELECT\t\t devid: %02x:%02x.%x "
+			DUMP_printk("  DEV_EXT_SELECT\t\t devid: %04x:%02x:%02x.%x "
 				    "flags: %02x ext: %08x\n",
-				    PCI_BUS_NUM(e->devid),
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags, e->ext);
@@ -1387,8 +1389,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_EXT_SELECT_RANGE:
 
 			DUMP_printk("  DEV_EXT_SELECT_RANGE\t devid: "
-				    "%02x:%02x.%x flags: %02x ext: %08x\n",
-				    PCI_BUS_NUM(e->devid),
+				    "%04x:%02x:%02x.%x flags: %02x ext: %08x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags, e->ext);
@@ -1400,8 +1402,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_RANGE_END:
 
-			DUMP_printk("  DEV_RANGE_END\t\t devid: %02x:%02x.%x\n",
-				    PCI_BUS_NUM(e->devid),
+			DUMP_printk("  DEV_RANGE_END\t\t devid: %04x:%02x:%02x.%x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid));
 
@@ -1419,11 +1421,11 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_SPECIAL: {
 			u8 handle, type;
 			const char *var;
-			u16 devid;
+			u32 devid;
 			int ret;
 
 			handle = e->ext & 0xff;
-			devid  = (e->ext >>  8) & 0xffff;
+			devid = PCI_SEG_DEVID_TO_SBDF(seg_id, (e->ext >> 8));
 			type   = (e->ext >> 24) & 0xff;
 
 			if (type == IVHD_SPECIAL_IOAPIC)
@@ -1433,9 +1435,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			else
 				var = "UNKNOWN";
 
-			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %02x:%02x.%x\n",
+			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %04x:%02x:%02x.%x\n",
 				    var, (int)handle,
-				    PCI_BUS_NUM(devid),
+				    seg_id, PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
 				    PCI_FUNC(devid));
 
@@ -1453,7 +1455,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		}
 		case IVHD_DEV_ACPI_HID: {
-			u16 devid;
+			u32 devid;
 			u8 hid[ACPIHID_HID_LEN];
 			u8 uid[ACPIHID_UID_LEN];
 			int ret;
@@ -1496,9 +1498,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			}
 
-			devid = e->devid;
-			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %02x:%02x.%x\n",
-				    hid, uid,
+			devid = PCI_SEG_DEVID_TO_SBDF(seg_id, e->devid);
+			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %04x:%02x:%02x.%x\n",
+				    hid, uid, seg_id,
 				    PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
 				    PCI_FUNC(devid));
diff --git a/drivers/iommu/amd/quirks.c b/drivers/iommu/amd/quirks.c
index 5120ce4fdce3..79dbb8f33b47 100644
--- a/drivers/iommu/amd/quirks.c
+++ b/drivers/iommu/amd/quirks.c
@@ -15,7 +15,7 @@
 
 struct ivrs_quirk_entry {
 	u8 id;
-	u16 devid;
+	u32 devid;
 };
 
 enum {
@@ -49,7 +49,7 @@ static int __init ivrs_ioapic_quirk_cb(const struct dmi_system_id *d)
 	const struct ivrs_quirk_entry *i;
 
 	for (i = d->driver_data; i->id != 0 && i->devid != 0; i++)
-		add_special_device(IVHD_SPECIAL_IOAPIC, i->id, (u16 *)&i->devid, 0);
+		add_special_device(IVHD_SPECIAL_IOAPIC, i->id, (u32 *)&i->devid, 0);
 
 	return 0;
 }
-- 
2.31.1

