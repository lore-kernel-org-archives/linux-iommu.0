Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A5187B
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QviUV+HOZaBEFxoqZeEZCQtE7kFJQJJMQZhbW+0Vi9Y35rySwoCQoFLzUd5NpZTIJsVT7ILnDIuKfg6ulMaVxhbQ+Alrax6/vi8+fvAL/g+cJPRn9Pkj9V+VvVZt45zRRDkH+7F6l9WVyYsTuNBtZIZVkgttB4QoL8zoaQg1EneGqJTyiNQpn/KuvcroIFMHLkdl371AXBMuH2ZcFs2xIHG6Ep/G1NAuUgAqp42UAkuq0zrffUNQgxUrhS9BKwuUAp/pj+wh75yY+VBtESXs15r5wxCT3Tq3NokVZI/GE7b2ypCmg8qhnoCGElxSg19pDMteXAeOhgZRekvL75F5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a/tgbQcutTQCodVe4/5AaPNGf0mIzzk4a0t4H/iqFg=;
 b=R7YhHjGcEKEtaA27xZ1Ud5dmYExCg99nFIBzNmydr23LxZnz05PUfkgOuHMYgKmmRS9TTmuJ1M/Nq6SYc+B0q9/f5fM0JAt3fQW7+JxJlB5sEbssArntTgkupz68u22JM0JESEmWsRNNbGB6pzobmeHH88X0Pb4IpV23nn++r2+Vc5bbRTQFQEOCFdQJQHv+Ho0GpcAmaqDDCkSac6XxTxjCi/sqE7/vY/uygBGUR3fQq6jzT7+2GesY473N0UDkQh/0Df4Xn8glL4DJ9rfyACgq4UGgj8umKvt1XnMEDIb2YLLxCYIBKmevEGvFFfaf7pXG/TL2zqhY+2nL+wjdUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a/tgbQcutTQCodVe4/5AaPNGf0mIzzk4a0t4H/iqFg=;
 b=s4+clY2d8TUqHvY97kJyiOfp4FEJbdXOyuRM/ZtvKkVEBNZ72hxMXkRxMKzY2rIk0zGgaocpgcaSxnSnKGvmSRJFMqeD/uVKSB3KDvJAaIpp60Yfc6v6ymNLwfinlenwv5x0Cqz58TM1+N6ZSDS9NHVQDbZxfMPCdTc6aKLvPUE=
Received: from SA0PR11CA0195.namprd11.prod.outlook.com (2603:10b6:806:1bc::20)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:43:59 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::6f) by SA0PR11CA0195.outlook.office365.com
 (2603:10b6:806:1bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:43:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:43:56 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 02/14] iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
Date: Mon, 21 Aug 2023 10:42:15 +0000
Message-ID: <20230821104227.706997-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 1978989e-660a-415a-2bee-08dba233872e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UMgjeh/+3Hv/CBkdMAuqnrFzBk4rpkGoQ8HjCP6XtWyE6gN4vKcV1rNElhef5ErBashYD3LATnDgmCbtXzRKk8Vf1trImn74h7s1CFh/Kh4YtelqzHMTLu0WsA0KdOEfzXZU/InrCjlPCt6CcwYnvV2N2L/whrpjvhXq/a7KsygpTFCikeOhc5BgapAwpx4m6VuLsYYnmtlA3Ry2ppb3v42hfUk5fR6y+aDoeEDPweawlVSqTBo6TilafrXEKBelM26gw07vreYsLzTUknZUccxfWiQ35UEw4f6xjjFEjQky3iqB+kOaAsNvb6p6cX+ZXIxCD/ft84DMw2xDFMgl3n0E7+dD8kgR/gWb4SYhiH1KEiMb2hLO23lPiiXKcg9aXsB9yhf4+1gBXGM4v4HjTPIq/AR1510dhH2SUv2vqnx1ZpAyhU9aiNa6m5ix4WJgdk7YZrL7hWCsFwCPm5tmVG/vhnBFOl69UQj4xUTE5o+8SZ17ndKhP2fwArNUv5JBEDyMYa+I87umZFEB291vp7+z7RAg2jIc/NsH4hSZxr0v2Vr1xJ1IHF849I8Rblmummo44pHyz2NTazLkAyeF6eTuSfjdH/adB2mA/3gI0HofR55Gr6f47E1VcIU31k1UHa9nfJKhC/Pdn/8pofxZ+quZdhj8tQkRZESMKOP97edCOcldZVC7EBY3bml6u0QBbVSP53A50gKSfXvf0/vf/nc4SgERgqd6wMGlNtIyXdfcXeKbwnMHO5/i8r2t39gpA5KTAYXctKKC74IntFRQHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:43:59.7414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1978989e-660a-415a-2bee-08dba233872e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To allow inclusion in other files in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/init.c            | 10 ++++------
 drivers/iommu/amd/iommu.c           |  2 --
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 081d8d0f29d5..a8d264026f7f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -451,6 +451,10 @@
 #define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
 #define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
 
+/* Timeout stuff */
+#define LOOP_TIMEOUT		100000
+#define MMIO_STATUS_TIMEOUT	2000000
+
 extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
 	do {							\
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 45efb7e5d725..852e40b13d20 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -83,8 +83,6 @@
 #define ACPI_DEVFLAG_LINT1              0x80
 #define ACPI_DEVFLAG_ATSDIS             0x10000000
 
-#define LOOP_TIMEOUT	2000000
-
 #define IVRS_GET_SBDF_ID(seg, bus, dev, fn)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
 						 | ((dev & 0x1f) << 3) | (fn & 0x7))
 
@@ -985,14 +983,14 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_GAINT_EN);
 	iommu_feature_enable(iommu, CONTROL_GALOG_EN);
 
-	for (i = 0; i < LOOP_TIMEOUT; ++i) {
+	for (i = 0; i < MMIO_STATUS_TIMEOUT; ++i) {
 		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 		if (status & (MMIO_STATUS_GALOG_RUN_MASK))
 			break;
 		udelay(10);
 	}
 
-	if (WARN_ON(i >= LOOP_TIMEOUT))
+	if (WARN_ON(i >= MMIO_STATUS_TIMEOUT))
 		return -EINVAL;
 
 	return 0;
@@ -2900,14 +2898,14 @@ static void enable_iommus_vapic(void)
 		 * Need to set and poll check the GALOGRun bit to zero before
 		 * we can set/ modify GA Log registers safely.
 		 */
-		for (i = 0; i < LOOP_TIMEOUT; ++i) {
+		for (i = 0; i < MMIO_STATUS_TIMEOUT; ++i) {
 			status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 			if (!(status & MMIO_STATUS_GALOG_RUN_MASK))
 				break;
 			udelay(10);
 		}
 
-		if (WARN_ON(i >= LOOP_TIMEOUT))
+		if (WARN_ON(i >= MMIO_STATUS_TIMEOUT))
 			return;
 	}
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56b6cf8bf03f..dd586f69a9d8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -44,8 +44,6 @@
 
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
-#define LOOP_TIMEOUT	100000
-
 /* IO virtual address start page frame number */
 #define IOVA_START_PFN		(1)
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-- 
2.31.1

