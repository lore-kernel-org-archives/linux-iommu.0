Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30615B10C
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507138; cv=fail; b=Wp5pXDBdJlgHoKhHWJ8B7QBP/DTWvuPhAiaDjCXHM2/cm0yQO1ydNXhd0MzEPDYUwa8LgqSZ5tzudKj1//rqAYcUcToUmzvraZ4GCuDjKXeRR8Olz1G7ZtD6zF+pUULevhmYfRAHDYtztv6xHwUevlzJ0FKNXztU/O388X3b0K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507138; c=relaxed/simple;
	bh=s35jOulRGrwqzVJcbZy/8Zb1F8G92E8RxmT3RSdoZzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ft4l9I93I1qELCH8DcML/ZBN7qkd9yE9QoMqOz7tORMDUKEls/Umsm7A2HLuuu3F2IGOjYJ25TsIN9tZyLz3XLfeqHvWaw1QhdpR9HojMZg9LA7n92Vr+8n2S/DqdZSVXWJvcKz4nT8gnV5D4CtwSLISrSLzqa92917VQ/p4GqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lPc+ZdzU; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lPc+ZdzU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFVVWG/7YpIt3kRZ49LyYKhmhgiF01J7HD5zcS+cYaLQ9uH6/7F+hWqNbN4WZXrqb5qRitaIKvXQZtXC5dOgE7ziPFJBShgnaTT9ecvhF9P54aFW/vdBuVOXexYYD6r8oY/4csB8vwAssCXSwbuFI5nI9IBFa3WTK1AGWl2RUcBm/HcWowp9sx3S6/694K/i0vfmzJtMZwFtT8/VUr+XIhAKWIPlTvOud9mTEJtPj0R8V00s2kHGYXRzNTLe+Osr/dR6AdIoRAZMfwnGQ4aQamMhbvLgOQXJOZlpcakS/EbvE9pScYNsT2A3J9p0VqB69okxlJXrw1YKaAcQ4MVO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nCcHvGrUZ7EKHp6Hu+0sJMtSsGWG+1DosCD07UdrEo=;
 b=Q4+9yWAPvFzE19ZHTUyaijXHCZO6apwSZ63TvZeHmQmX3gBLd0sexwH4qd8TQBhbXfzdBRUWQjzAclX/ETRGO/2jcM0WXLFobIzrtwrFJ5NJjfv9qFPr/f8Iu5Oi6ReTuquqKXw5Hc7F9VnHLErX54YbnMLtQ7qu0iSe7t/O1j9rhUa1g6wN41JKu6DoL48PE0O9EgbQ1fYHsIb21u/TE+vCHxr5YGGMprfKj/19Izx5HLckFU+chw2t8K/BPqNqKedUa2NRZ4HuadWmV8C4CqYMl28UZd0sUsJyAvIdOFu45BTYr5OaK4b2QOkEFm3ZKzPalgtPLsNlBy2IOA56hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nCcHvGrUZ7EKHp6Hu+0sJMtSsGWG+1DosCD07UdrEo=;
 b=lPc+ZdzUJ48YvAvPggpBDsOE+znDwgMW78hyT3xgzuW47xCNxdtAn1y4MPJPw4Eu9YkqcbFUH9GtjQYTz15yQnUfnMtOgA/0yWcBMuE9b/wi9vimK9Zxiuk9FFPsDpl3tOaOvh2ucRFKmgRdkUmj8Ut/yIvkmE+1Dy5h7n8GIMc=
Received: from CH5PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610:1f0::26)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 17:18:53 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::10) by CH5PR05CA0013.outlook.office365.com
 (2603:10b6:610:1f0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.14 via Frontend
 Transport; Mon, 16 Sep 2024 17:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 17:18:53 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 12:18:47 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 5/6] iommu/amd: Modify clear_dte_entry() to avoid in-place update
Date: Mon, 16 Sep 2024 17:18:04 +0000
Message-ID: <20240916171805.324292-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 427ea22c-d552-47f2-e28e-08dcd673a378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j672u1TvlYLh92WmUnHLhs1Dpqi9E9lHdJ3M5y8pFLaoLZL4uoAAeZ7IzeJf?=
 =?us-ascii?Q?95LTM+1sPkPkyIQRB8Vmk4dEkjrbaGNx2AgFG8R9BzJMM2Ss14lfSQTTI/di?=
 =?us-ascii?Q?tPMFs3wRG9lRrWmmCN2RkAOuXJKSBGHrEjzoqB07YuaWRb2a8IZd+GtHa6nq?=
 =?us-ascii?Q?C/4CED9H4HsSZJZy9dhoM+wKrfGHhM/S72ZswFjbi217nMyn+im1Io4KokFj?=
 =?us-ascii?Q?IcWmIQZ1nmldUpw4sYjMNd/H3wWq075lLEwgSHecGugwI6leFJiYkU/d0QM0?=
 =?us-ascii?Q?9yJfGkM5sRcFTjgI6nDh8Hh+dLjRGBoMb3JPByASuwg5NjrZB/K1mimCzA1Z?=
 =?us-ascii?Q?va7qj/QKZZFiGur2HKr9HG4JCrfVhMM17RgXx82clT3PK3mP7mQIEj62WmN8?=
 =?us-ascii?Q?aQlYo6SS3NZJMt6EHFGIrmrrCS7w1vtusW5K80ihHlI+PDTtXmBa6Uy3BjLB?=
 =?us-ascii?Q?A5enrDM/se3tNBZQvFWx47FCCYl1l+iVr31dplmhkqPv6BqX9eSlC65t4C51?=
 =?us-ascii?Q?BpA4c9cSzvgEEjxDyHZzIeMnU7FiTYhO+KR/Y1A6bpU0FcRD+CK/c4R65O9x?=
 =?us-ascii?Q?yEbXFNIJGCB2aY9W5ioW4c3qR8T52MmmlX7vSCtunZFXzNAd23wiQBJzk2/3?=
 =?us-ascii?Q?+wlM3oBtVE7UyvNojahQzsHAT9NqN7XL1nzj82CnHnf61CH+cwLp7MxKmqth?=
 =?us-ascii?Q?ez+SQLki77wJs2NCmGF9PdEwRbjBozvCyRWCcoMiKKqqVFOGOlM3Unj7KoMP?=
 =?us-ascii?Q?Ontf3xuGE3n+rb6fKRAt3xylDo3jAMX52IeCqSKrsI26uc2Zxsjs8eskDWUX?=
 =?us-ascii?Q?gqFyIZ9nvwhv7m1ac8SD79mCtqmgjAhTaZ+S03PjJS9e+qzqEar5CV6bBbCN?=
 =?us-ascii?Q?V0p4zC/KwwhgzlceHrvIJMJEdKgFoRQURcL+Xm1gFJm23ZZASbOi8dXiXu3W?=
 =?us-ascii?Q?AAzat0j9mJrJ1DYLRorut4g+VAv6a4uR2G9pStlz4IGdvUFOLm+mhETESPQc?=
 =?us-ascii?Q?8+84XHulFY9ngKeAsTFbFsOCLWEIvZIwiXn7qgi2aKexXBA8uqMMMX4APNiz?=
 =?us-ascii?Q?idrO6nipP/Ez10N6lnA3iI3OSyAkQyvA0LJtZ8GIG/LadtynDoAq48I0pvbf?=
 =?us-ascii?Q?jikJI5k1ekn+9k6ZKFDDTz+2c2GFBNVg4zbX+agss6eaaCrhXIrOvdF4QN6P?=
 =?us-ascii?Q?ZqwnGsjJ6hXexo5/IavMjf8b8e49YKgUTnKlQdJqmMsEe/Dxq9OgdiuJ5whS?=
 =?us-ascii?Q?DMp5OeUWOAMgjxva2XNpaURxand1NfktUBGzB1vMtYIZiNKjzyUPFB+Djr5J?=
 =?us-ascii?Q?IZ/gEYlFUlyLssWWlrADuoY8ge755ZYV89khAZh62P4aEm7Erp4/24ZjEieF?=
 =?us-ascii?Q?CwXvfNfTfoOyExgQezM90uAoPS7Xc2rKTr8E3iK3nGW799bgfxDOG0tyt7LC?=
 =?us-ascii?Q?gDJ/CVa7p/ImAIIxkSv4PnEIEB3+iZHk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 17:18:53.1021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 427ea22c-d552-47f2-e28e-08dcd673a378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

Lock DTE and copy value to a temporary storage before update using
cmpxchg128.

Also, refactor the function to simplify logic for applying erratum 63.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/iommu.c           | 28 ++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fea7544f8c55..db3ee094a144 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -425,6 +425,8 @@
 
 #define DTE_GPT_LEVEL_SHIFT	54
 
+#define DTE_SYSMGT_MASK		GENMASK_ULL(41, 40)
+
 #define GCR3_VALID		0x01ULL
 
 #define DTE_INTR_MASK		(~GENMASK_ULL(55, 52))
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 676742d6f19a..2df679eb61c9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2086,19 +2086,31 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 }
 
-static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
+static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry new;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
+
+	/*
+	 * Need to preserve DTE[96:106] because certain fields are
+	 * programmed using value in IVRS table from early init phase.
+	 */
+	new.data[0] = DTE_FLAG_V;
 
-	/* remove entry from the device table seen by the hardware */
-	dev_table[devid].data[0]  = DTE_FLAG_V;
+	/* Apply erratum 63 */
+	if (FIELD_GET(DTE_SYSMGT_MASK, dte->data[1]) == 0x01)
+		new.data[0] |= BIT_ULL(DEV_ENTRY_IW);
 
 	if (!amd_iommu_snp_en)
-		dev_table[devid].data[0] |= DTE_FLAG_TV;
+		new.data[0] |= DTE_FLAG_TV;
+
+	/* Need to preserve DTE[96:106] */
+	new.data[1] = dte->data[1] & DTE_FLAG_MASK;
 
-	dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	/* Need to preserve interrupt remapping information in DTE[128:255] */
+	new.data128[1] = dte->data128[1];
 
-	amd_iommu_apply_erratum_63(iommu, devid);
+	update_dte256(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
@@ -2109,7 +2121,7 @@ void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	if (set)
 		set_dte_entry(iommu, dev_data);
 	else
-		clear_dte_entry(iommu, dev_data->devid);
+		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-- 
2.34.1

