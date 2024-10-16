Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540318C342
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055924; cv=fail; b=D0HSHGfKv0CkxhEh7T+k1VCsffcskIiORljg9Ad+ESwAG1PsVJF/Jzl3MS3NsgyjvGH/ianp3xtsgVygM4/9RATtcQyTS3smypC65auFLlJcnwR7QcPw+OVuDIJDgR0Oh63xTtHeaI5xNRzRmsN07yddazZYLyBlijVHvtc0pn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055924; c=relaxed/simple;
	bh=Z39Ysay9YHS+fFTZyAb/TAu1T6iy558jZjFiBqcakHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMy1GM8pal9I9La0OzVw+kpJuDaLatzQFQ4xtqgHntg2qNApu++K5smJ0W8AawNnWadtnGPssqYrBwq6STlaTKy4ZVdCBykpGjtyGmHbGm7bQ5V4Q4jYvA55u1dSSk2S+F5QFmdZBqHRlbdtXsWulFGqqfWjIqZ9JXzgDlnhZa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=km8+To9F; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="km8+To9F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqJG1sXKziSTCjh7X7HuxhQxEvp97Nmmx2SaUkn+Jsv7OgDj3JRNQVgOCFMmfLeHvyyWbpCNIOGdfjg6jMJkFXwnUEywMc2IwMHIXr7DgSlbVMUq5hDrA434+FEB1p/JzEMVlYkCqeA72JbBoNL/b4WkYTeN2uuEuQ+ABDBJDc7htywZy+fmQAJzNa8gSbM//SJWDtsKMfqxIsgZb6uwbxOL9Vz4y78DgTXkgrGy1ET/Ln8fbNYnRoFDLCG0v234zItC2veCThXG9BdO+x1tpczG1NLXwE5MBzy8UGIyv8ExtQeOyWZjlvik+CFrl+vYTjurPaNzdusEL2wW6wUPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSuhy3vPg6TiK8PS7j+QRJlguGx/PMQYoYJ6PKC9Qzk=;
 b=hQ+DmlewNUJmfXsbanMGwnxCLQGh2/AcQyM5ynE9R61fZKI9rkbIdG4gIjmJozc8ENF8XOd2lhZaOE/nItQdVCv7BG5wZcxzg1KAKakjKoXeVROMCJetM+SZgYjFCVfFik2V+k36KVCwFjpdF9KvVCtWddkRt6nNod3Ypwx/MhVymUxZsKA2yd8wWUvlACpGIPAHOyQe89iEo4v8EDli5bZ5wPK63XW4uJw1nHtPZog/yLQ1RA6rce/3zeXMHexyoGHv07lML3BkEqIDrn5NKnOl9X2LsrMPYVasuRGswRCnugTJP4uXXB6eLd+5+U9fYET5IWLe1d6TFdMH4piCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSuhy3vPg6TiK8PS7j+QRJlguGx/PMQYoYJ6PKC9Qzk=;
 b=km8+To9FLD8OxdbMTR4GJaUYo3iHN5onLNCwFr0h4iHsP8Z7dijVkTTRQy3dj/1775yYSjyzAV5hDPHOFinEXEjAxdNRlZa9ndVWOctRbR4+rDRAzFzdsMC4tLZloedsoDefMMGSf1fUpgjUe8HxTjSbrDJHFXQgxd1I9Tm5s9g=
Received: from SA1PR02CA0015.namprd02.prod.outlook.com (2603:10b6:806:2cf::19)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 05:18:39 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::37) by SA1PR02CA0015.outlook.office365.com
 (2603:10b6:806:2cf::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:18:39 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:18:34 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 6/9] iommu/amd: Introduce helper function get_dte256()
Date: Wed, 16 Oct 2024 05:17:53 +0000
Message-ID: <20241016051756.4317-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 279d2c3b-6f9c-417f-395b-08dceda1fe68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1gSXleqY/jJxuUks217yTEbgwmeXq54QUCKhgS6DjbMQ4Rz8lvEduoKS4kMP?=
 =?us-ascii?Q?pbvS3ISbKpvXBxHoCsJ2J7Mja8OW84sDZ0H+2SfqoXrufz/t2yDJzyjFt0Ok?=
 =?us-ascii?Q?/X3FTgKt3EUd/iQSaofs2Z+SpCyEKEeQ9Fm6B5i827uyciuvuBi0gYoqnvYa?=
 =?us-ascii?Q?LR6Qpcy4D8Wo2AxbSKID7c2us14eyJLzSr4gek11tEO6xFGWhUuqOrAEorv0?=
 =?us-ascii?Q?cymkkjspYw/nBX2qUbYvQnIAImd4v0A243PWxBdAtnZnrTP+FPYo9m8NBACR?=
 =?us-ascii?Q?plzMz5fr7HF6LmTFVnPUs1hNnIHUtZ8jv5fzYYKa4v8edl7QHdpVa/kJmfu4?=
 =?us-ascii?Q?lCBFuuqOabSJWP2CiGrdti+E4AWWWHxjhl3nMbvf/OwUP6/mgXvgNKq3iyMK?=
 =?us-ascii?Q?sG6d8UNrt9q+CpjzdfYpwzZoKe8yjilhD+wLiSQwSv8RkGcRBFjuyygp/erN?=
 =?us-ascii?Q?FG+6KWS7QlATeP+p6Y2i2OAwOWY/1XpQQkDtEIF99K1xd2eoOUqTxkbiQgHL?=
 =?us-ascii?Q?DqX/CvP8pu5YHMQt8JnM86qoCsv42mPmXDfNuYkzwOoUfq+1mPpznxXRmjkD?=
 =?us-ascii?Q?8jc5nbY4bLXk4BUFQTmSjj82PXiKV6mvcFIQYoleIWCrgbdgpdcjgOv4Ele6?=
 =?us-ascii?Q?UdlxZTy+y+KH/NuxldYpwoC7G/KiDkaHZ9ni7Ll27h/tFVOMo6k7SIk+Vp1b?=
 =?us-ascii?Q?w0iShD0kwjsPXw1VSDK/j6dJHvg5fWCHuxjHcfB7l7qOk7qjJ4kMl/cOGEFH?=
 =?us-ascii?Q?IDK90b3kFZm6LO9tXt69C+7vY2d+3Ezv8p8U0vvpqPAbKBJPqlPQekgey9kM?=
 =?us-ascii?Q?MxbwzIWQ29us7VTY00rFhh/HBElP0aLAJgFGDKg1IVm0Egb3oj0InvniuzQa?=
 =?us-ascii?Q?UrX4YXU0/30Q7fm89oChsBcZrT9hHZO9nA0R0Z0yZtH0QRGjLXjNOK39xf+7?=
 =?us-ascii?Q?Je2JVa/rMdJ7w5Xz6XB0z9M8Y4WwDFSNTr1zeW6ukln34/fl6F+Uv8T0tFKo?=
 =?us-ascii?Q?mVwzV0gbFzNZDuldtCzQPxLrklfDvAM52yAeixDFXHkRI/CL2Z5yrGvoFJL4?=
 =?us-ascii?Q?sAowQngZb7uv2apsYjshIV3QjA6G0RRRCSbMpAiQpLRotBTw7Q+3iaPHx0Ii?=
 =?us-ascii?Q?2jczncyiCijUqSlFtOM+8hDhIpc7pFN7Ejz8sHXE/RUuX1b1Ewqex6/V4+pX?=
 =?us-ascii?Q?2oNwjbLLA9hcJ+MAbTRoSLyG15urbDapFj3h5xq6jf+v8EiN6QuS07UOM9cI?=
 =?us-ascii?Q?PYSi31RKU3odkflP63xKECAzxazvvy0LnKzC0HMTic7SvWY2ufj1+JCygrR4?=
 =?us-ascii?Q?S/1EXVb2qBFXC93MDUmz9xLVjT57OZWXzk2vYlHPzfA+3qkV6YXTv+W3Koll?=
 =?us-ascii?Q?dcDFJkvrrz575D0al4P2p9qNW9E5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:18:39.2591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279d2c3b-6f9c-417f-395b-08dceda1fe68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734

And use it in clone_alias() along with update_dte256().
Also use get_dte256() in dump_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 59 +++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1e61201baf92..c03e2d9d2990 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -185,6 +185,20 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 	spin_unlock(&dev_data->dte_lock);
 }
 
+static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+		      struct dev_table_entry *dte)
+{
+	struct dev_table_entry *ptr;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	ptr = &dev_table[dev_data->devid];
+
+	spin_lock(&dev_data->dte_lock);
+	dte->data128[0] = READ_ONCE(ptr->data128[0]);
+	dte->data128[1] = READ_ONCE(ptr->data128[1]);
+	spin_unlock(&dev_data->dte_lock);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -333,9 +347,11 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
 static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
+	struct dev_table_entry new;
 	struct amd_iommu *iommu;
-	struct dev_table_entry *dev_table;
+	struct iommu_dev_data *dev_data, *alias_data;
 	u16 devid = pci_dev_id(pdev);
+	int ret = 0;
 
 	if (devid == alias)
 		return 0;
@@ -344,13 +360,27 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	if (!iommu)
 		return 0;
 
-	amd_iommu_set_rlookup_table(iommu, alias);
-	dev_table = get_dev_table(iommu);
-	memcpy(dev_table[alias].data,
-	       dev_table[devid].data,
-	       sizeof(dev_table[alias].data));
+	/* Copy the data from pdev */
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	if (!dev_data) {
+		pr_err("%s : Failed to get dev_data for 0x%x\n", __func__, devid);
+		ret = -EINVAL;
+		goto out;
+	}
+	get_dte256(iommu, dev_data, &new);
 
-	return 0;
+	/* Setup alias */
+	alias_data = find_dev_data(iommu, alias);
+	if (!alias_data) {
+		pr_err("%s : Failed to get alias dev_data for 0x%x\n", __func__, alias);
+		ret = -EINVAL;
+		goto out;
+	}
+	update_dte256(iommu, alias_data, &new);
+
+	amd_iommu_set_rlookup_table(iommu, alias);
+out:
+	return ret;
 }
 
 static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
@@ -623,6 +653,12 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 		return -ENOMEM;
 
 	dev_data->dev = dev;
+
+	/*
+	 * The dev_iommu_priv_set() needes to be called before setup_aliases.
+	 * Otherwise, subsequent call to dev_iommu_priv_get() will fail.
+	 */
+	dev_iommu_priv_set(dev, dev_data);
 	setup_aliases(iommu, dev);
 
 	/*
@@ -636,8 +672,6 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}
 
-	dev_iommu_priv_set(dev, dev_data);
-
 	return 0;
 }
 
@@ -684,10 +718,13 @@ static void amd_iommu_uninit_device(struct device *dev)
 static void dump_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
 	int i;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry dte;
+	struct iommu_dev_data *dev_data = find_dev_data(iommu, devid);
+
+	get_dte256(iommu, dev_data, &dte);
 
 	for (i = 0; i < 4; ++i)
-		pr_err("DTE[%d]: %016llx\n", i, dev_table[devid].data[i]);
+		pr_err("DTE[%d]: %016llx\n", i, dte.data[i]);
 }
 
 static void dump_command(unsigned long phys_addr)
-- 
2.34.1

