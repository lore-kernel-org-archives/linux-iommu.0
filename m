Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9D23A562
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212851; cv=fail; b=dKPT2hv77aOPJknqqGFIIBRscY60ZSXWyVYtAj59vFt++lrGBa+Z57UQXYMyhJ/u4VWZmmXdnOsEHyR6JRMI3dWn7JiezmbBJyEBA70UnVG+m3meV3tGZgARxQDZ6amAWAenwZ7A/pqMGzJx2syHiYHiinfnM8MqS/2JAWOYBuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212851; c=relaxed/simple;
	bh=CEWyC5j6WsS/UlMM+kEli/7MkpsfAJ/GEoK85PbDisE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1hfhtCkgewAJy77gA3KVjwl+4MHsFACjsHNifhMqa+5w7fQT/CrYNZJsWb64GvRE4lNB50aoFqBYnm6ZNwJu1TCBYSJJmPm/6l19bCh2EkeuN51RdrO40t5rOc9YlqLUKjSKZ/aAbcwPUlRFDJZn55oM0XftiIccumCtLar7c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xG8Nh+y0; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xG8Nh+y0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oemGvr0fj7HY5aGUV5fRIM7U9sznMS9rNnyCnWAxzJrmPJSAkTy8RRbDhtIl7BCX+uOCneQpR70c3NE/jY2P3VT/UK2tGe4ioMpd/PHdRizmu+xfjf9lyPgxR9ITuoWj77N0upIjOleD77PgEw+slYtrbzdzDWI5YkkmBgKjEOBhYxreA+QhgVhVbl4x4atfjIT57Zhb3pK85e/7ZfpIfPY9JavkiXz5FN/MjvIDNC4NzyBHTMnPSuonfQh+9bsQAjZkZq+WITRUzcLAKnjYd4jdyszrEu0JhZjxydwL6PmptwNu+sOxHNWet42qLWpwqqedaBIQE0q+W8jzdEsE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS5wuB5Ask5bMvHnB/Xl3tgJOq+RECFClpWREfs7S2o=;
 b=VjgosmS2iWAiUlzt43XuyVbv1zTsgHhhvg3eDPLWzqEyF/9jKjQlKDu9MqoGHbx1NYjc+on0+eqsFXjrlcgQhaSvNEjSgq3hi74YyO6MZG776YkcLQZg7Hnr0rnVpQhFBMFEEDX4bIDsTHR+vvdYG2qNDK5oC+iTnOSLM6lipQjA11csy8TLT8SQKisR7vtdMeO7EZF71itDt3lWJd7+5CItkfOHntKNEy+O6ykorDXyBJFl8BSupa2bhq6790+jittRL1OUTuT0Mpdsnch9UGu23IJZRapFJmzINONpXR2wkJ+JtcgE9nULYkEHJUpBpPobmApxh6wfNnNdFkEVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS5wuB5Ask5bMvHnB/Xl3tgJOq+RECFClpWREfs7S2o=;
 b=xG8Nh+y0ZpYySMAOkFLJcNNzujE1xD+M8qtod1ElBWwJi8VQo/L/e8pKrKx01SNxJwRKSKUQhItHHO7VyMQ56gSDxdmNiNJWSv5wWQHtsR6qJUfbat5eqAp5K6VX/Ayhe7YiA/To0V+k+OD9Hp3QaQiEKt5Hs7k/XjqqkSl8guc=
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:00:46 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::c8) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 12:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 12:00:46 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 07:00:34 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, "Dheeraj Kumar
 Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v4 5/8] iommu/amd: Add support for device id user input
Date: Mon, 17 Mar 2025 17:28:27 +0530
Message-ID: <20250317115830.3416-6-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
References: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c1b551-6dc0-41dd-3712-08dd654b59e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T5STdmg+ZwWykjTCKMa0ADXsHcJAaAleYo1Zyp6/6oq7VGTkAORSjuN7+RED?=
 =?us-ascii?Q?K/9fo299KI7lrliDOTtTIefQxUfBYf6+DXTbhe7GfTHthoVWZCCDM+nlhK5n?=
 =?us-ascii?Q?TDWWlMH1Lq4vFe+cI186Mw4mI8+FRXgOv/X5u4+MSWY5rJAGzGQsZpQKm2LG?=
 =?us-ascii?Q?mzukH02SCgLHHb+Kf2xDkvq3YHmVJ9rVEqi3ZDUTpqR1oZPlcBGqRsWgV2Ck?=
 =?us-ascii?Q?rJ+knouscmxjrRPkbTSDOHOwW1YPJYOCB9DVS0cgXedKjItxsDCSPYNKMucV?=
 =?us-ascii?Q?/ahd/BP2iWHIntdn7MKv5f4FvmN9rzAkTYJ82k5rWlQ4felo5OSQkeqQCUfM?=
 =?us-ascii?Q?QwgFRXC6EcaPcF+c6f7jFPTlIcghZiEBdYqXgQ0jrCiYEhaVBEl5E3s5vJKY?=
 =?us-ascii?Q?z/2cEx2BmtUkD7ak8r+td/Nfm3hxAUfaSk9SYfwvqmgA1IzKIWFc8DMvuJpL?=
 =?us-ascii?Q?9Q2XG/soaRTDJj/9JGuI7DPW+99IrdRwkEnotuLYkevDddNbGq8h4ydhgNO0?=
 =?us-ascii?Q?WN2z/UatfyEtTNUskadvaICS4iReUKsjii/ciFE0uoGbVImM6xUi1VRJ6wyw?=
 =?us-ascii?Q?0w9X31vB3xQ6eOJa+SXg6FCrq/ftVpgxLlFrP2qXskilV6bqRSgwO/gUlFJ7?=
 =?us-ascii?Q?JCtFl4Eo5lIvkv7UD1BrU+YrV4kDbsp55FtSc7c9bsFJe9h8BB0V6XmzRbvs?=
 =?us-ascii?Q?FPMBAnbDrkMjjFCbwoRyMwRLeTWSLIFnHRAgB9NmXGZtNHYfeQdlDRH6R3r7?=
 =?us-ascii?Q?uiXdetn0Wj8GN4JO0YX/LuOLWVBhoODOJ+ZzpX2BPEYEUNdteTuFp/StZMbP?=
 =?us-ascii?Q?oHQ/92vVaiJAq2B03zASZbRTHHm1u2n+/yp8wBlQ+JdZXy9N+btZwmXhsoPq?=
 =?us-ascii?Q?28Ni7WHIQ0lSFUke3r6tvv28SJ5G24/WQFdf7rNd4tgJgOuPo+5jGOrBLwXM?=
 =?us-ascii?Q?/MMw0+jzBbNTqCrUx5dlpfCJqjSCJsvCQ9XWCK5uuTqCL/mG/1La6zJZZ5Xv?=
 =?us-ascii?Q?SdYYI7UZ/lSpbA1/i7tUeiBhOeWmaxabjhsYPUhBCw8BVy2coQ+VOGKmgXJX?=
 =?us-ascii?Q?Wfni0CpZ9pgHVGoXA9mHhWss1aU09zIXuGTrfrmeOdYP436x/N3bJlemTU51?=
 =?us-ascii?Q?ofWWtDbk5VPzZGAdnuJVHHomSLmpz8V5p/IhBUQEII4G95u3qzmqwonWVfLX?=
 =?us-ascii?Q?tRPLcKHYPiHbu7tB1uKopshJ9hnG7RA/kLvNKTHYsjUkHCefPiOQ5diGOYze?=
 =?us-ascii?Q?ZaQHhq6f/OPxKKssTtdIJz/zokcnsWFPjyaQDK/gXA1g3E6lDah6WnQiYTbH?=
 =?us-ascii?Q?YxzEpvjPK6YHJiSjsFRuYlQ3cIJU6bMSUbpcFu1kfiUiwHOv+kJAX0fa+vWU?=
 =?us-ascii?Q?zsrJUSAOtIU/YZWmstAbDdChipUeQ25lEIjKo3joAzB+SYlbGXlTXjnjktSw?=
 =?us-ascii?Q?nU5GqfMlWSc45WSBvpIJAE4C/v2TdWPYVWTSgu+tBq63/wP4Q+8Xu+QOjmp7?=
 =?us-ascii?Q?qZi8ub1s4cmxV00=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:00:46.0087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c1b551-6dc0-41dd-3712-08dd654b59e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645

Dumping IOMMU data structures like device table, IRT, etc., for all devices
on the system will be a lot of data dumped in a file. Also, user may want
to dump and analyze these data structures just for one or few devices. So
dumping IOMMU data structures like device table, IRT etc for all devices
is not a good approach.

Add "device id" user input to be used for dumping IOMMU data structures
like device table, IRT etc in AMD IOMMU debugfs.

eg.
1. # echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
   # cat /sys/kernel/debug/iommu/amd/devid
   Output : 0000:01:00.0

2. # echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
   # cat /sys/kernel/debug/iommu/amd/devid
   Output : 0000:01:00.0

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index d211c1343f93..de030801e236 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -16,9 +16,11 @@ static struct dentry *amd_iommu_debugfs;
 
 #define	MAX_NAME_LEN	20
 #define	OFS_IN_SZ	8
+#define	DEVID_IN_SZ	16
 
 static int mmio_offset = -1;
 static int cap_offset = -1;
+static int sbdf = -1;
 
 static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
@@ -131,6 +133,80 @@ static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_cmdbuf);
 
+static ssize_t devid_write(struct file *filp, const char __user *ubuf,
+			   size_t cnt, loff_t *ppos)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+	int seg, bus, slot, func;
+	struct amd_iommu *iommu;
+	char *srcid_ptr;
+	u16 devid;
+	int i;
+
+	sbdf = -1;
+
+	if (cnt >= DEVID_IN_SZ)
+		return -EINVAL;
+
+	srcid_ptr = memdup_user_nul(ubuf, cnt);
+	if (IS_ERR(srcid_ptr))
+		return PTR_ERR(srcid_ptr);
+
+	i = sscanf(srcid_ptr, "%x:%x:%x.%x", &seg, &bus, &slot, &func);
+	if (i != 4) {
+		i = sscanf(srcid_ptr, "%x:%x.%x", &bus, &slot, &func);
+		if (i != 3) {
+			kfree(srcid_ptr);
+			return -EINVAL;
+		}
+		seg = 0;
+	}
+
+	devid = PCI_DEVID(bus, PCI_DEVFN(slot, func));
+
+	/* Check if user device id input is a valid input */
+	for_each_pci_segment(pci_seg) {
+		if (pci_seg->id != seg)
+			continue;
+		if (devid > pci_seg->last_bdf) {
+			kfree(srcid_ptr);
+			return -EINVAL;
+		}
+		iommu = pci_seg->rlookup_table[devid];
+		if (!iommu) {
+			kfree(srcid_ptr);
+			return -ENODEV;
+		}
+		break;
+	}
+
+	if (pci_seg->id != seg) {
+		kfree(srcid_ptr);
+		return -EINVAL;
+	}
+
+	sbdf = PCI_SEG_DEVID_TO_SBDF(seg, devid);
+
+	kfree(srcid_ptr);
+
+	return cnt;
+}
+
+static int devid_show(struct seq_file *m, void *unused)
+{
+	u16 devid;
+
+	if (sbdf >= 0) {
+		devid = PCI_SBDF_TO_DEVID(sbdf);
+		seq_printf(m, "%04x:%02x:%02x:%x\n", PCI_SBDF_TO_SEGID(sbdf),
+			   PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid));
+	} else
+		seq_puts(m, "No or Invalid input provided\n");
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(devid);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -149,4 +225,6 @@ void amd_iommu_debugfs_setup(void)
 		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
 				    &iommu_cmdbuf_fops);
 	}
+	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
+			    &devid_fops);
 }
-- 
2.25.1

