Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE003BA48
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 12:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4kuGS7Lr68cWNBfKM61TZwv/Dl/SNi4JwMBzKg4M0n5fcwIBznfncLeH+NXnBk7GfWLuK1z+gdgKCzJbM2olQQVqP1uJmzPoyu6wbLa/jCTTX7XBJO/sZKCKu3LKYPtV4mSE3kCLmi+0fbRlIzsv4c9iocwEusqqIanUBQfGuXq+6q6W/waAhZoAjAa9e9QYPi+IizveSERp5X5bRCFgrfJeaUOjxJTD/FIKocL/UMfsDL9FjRRGHK6KWzOhMqGOWhHVNX9ni4BDZRrPLxc0Q/MBbwccYIzWJmKjlmugKXG15dMVNCf2a6BN+Hpe7QTnwbheAgymxWmJkaX1tV5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3LYPKZr2nZ/s27BAM10+ctGNeW1dQjPpG0ER5krJsI=;
 b=cOrQXuo/KPpuG8L57iwVYqYVEH3lw/hq0svHAeMXildtOYutqmWTx4//HjpvKj9cWf9dv1taWhJZRoSyZMWxwqtyEhxJGWcVmby5TX/NOCOGZTNWhvKAvxVQPO/ejPxwDmwGTCjaOVVLZRX3bvVyiLla1r8A2fcOlpJeL+jepvv6vAqU8XCKVCalodBsuswa5+I+ujM8YcTLiPQygW6dooZhnFvmqt/KhjMfc0sjklWwLp3BBW0L2UsGSlDZyqiV3TW6VfCUwl+azeKy94V8pZ5ZH/GFBQAwVLv8XLaRtu/58wjxxD4Bd0cGolzWK26kW2SaIaS7UL4OVI3JB5dt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3LYPKZr2nZ/s27BAM10+ctGNeW1dQjPpG0ER5krJsI=;
 b=IPAQZHUlpzwTYcuRAKdKcU0CamsdjNK7vsG8jRmf5RYJJWoFCrYEAnHZLzFY/xhG2MR7VDAwgZM/qAhJyTRnM7QNDs3/wmELo3BHMP29YC0I3NLwh61tssKyBitjcw3exjTo4DNCY1XPHpYwmq5q5b959PtumkOfcxQo4NCcD08=
Received: from CY5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:930::9) by
 CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:51::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.26; Wed, 23 Aug 2023 12:04:35 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::28) by CY5PR13CA0023.outlook.office365.com
 (2603:10b6:930::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 23 Aug 2023 12:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 12:04:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 07:04:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>
Subject: [PATCH 03/10] dma/sdxi: Disable event log register read temporarily
Date: Wed, 23 Aug 2023 12:02:15 +0000
Message-ID: <20230823120230.727935-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120230.727935-1-vasant.hegde@amd.com>
References: <20230823120230.727935-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: b92f57dc-d8ce-4842-e63f-08dba3d11e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sh/ydM+D2od9a1Yb8C6I0qqVL56dnjNxBeGcGQxYPnwmbnA2+O6K5GosSaCPKjGbuf+l4GKCDf/i/f4Ho+L5eOs9fBzmSZOnV40rvIjal/eq8jmyhkVhCCXiiLazXN92m8sNiANuVuyvg7R5fTcXfso/ae92gtWtlbqCCaEdTrhW0G0SElaINVvDubCFu3/AN0l78SmmB40hTo8Kd05OW6RbuHN0sd7fDjNFzUoGL018MRLp5e8TZdmS9MiTpb0XNILn91EpOpBhRcC4bYkYjxZT7+ZE5SK8aFVlVD46z1RcIvwq7TV0m7lU/p4izaVHXipWYSPbQjoxL0X75jqwPdbpKv/33Nqo/aG+5opIcEYhsIXwIWwHhmAA6qQ/umc0WW01sfInsXe0r5QbOw4PPY1aQ8m7Ldh03w1Mccu4ojJAtpEPWeOxfnP+QMJLTnlQ8JcQLChLBgPiHo0VlYKyQA21v8EODNjqWTz6nCalMj584Ef4N/IRSm+LJIWl4BGI87vgfCSyDV96bo8F/UmrW0dYgjgHJz/mDtDY6PHwxuIO1s5jplhWGbxg9z8/irBruKw0jzt4Z+A9/8PQuYDW+gTTGcJB70SngHJ8gk7O7QLwks/0yA/4oQrCr+miUzYilvpu9j0SwATMEKr93xt8LPZsKcwVo/ALHWzhBP0EM/zA6lMK47I88Cuax2XOw0/pGZny66Z/uvqDDHiYfzAPjfNQxhNLKNzSP5d6fVOQ5fotLnPl3D4mGZ3Yd89M+S0CCbrD5xPFljyNakWryvK8Sw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(36756003)(478600001)(86362001)(44832011)(316002)(7696005)(54906003)(70206006)(70586007)(110136005)(6666004)(81166007)(41300700001)(8676002)(4326008)(8936002)(5660300002)(82740400003)(1076003)(356005)(26005)(2616005)(16526019)(83380400001)(336012)(426003)(40480700001)(4744005)(36860700001)(40460700003)(47076005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:04:34.9970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92f57dc-d8ce-4842-e63f-08dba3d11e0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097

From: Wei Huang <wei.huang2@amd.com>

It seems the driver is having issues during MMIO register read when
error log is triggered. This can potentially be FW issue. Let us
disable it for now.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index d51c190a3cb7..a7c3aaa3ff12 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -81,14 +81,14 @@ static void sdxi_do_cmd_complete(unsigned long data)
 
 static irqreturn_t sdxi_irq_thread(int irq, void *data)
 {
-	struct sdxi_dev *sdxi = (struct sdxi_dev *)data;
+	/*struct sdxi_dev *sdxi = (struct sdxi_dev *)data;
 	u64 status = reg_read64(sdxi->ctrl_regs + ERR_LOG_STS_OFFSET);
 
 	while (status & ERR_LOG_STATUS_MASK) {
 		printk(KERN_ERR "read status\n");
 		sdxi_handle_err(sdxi);
 		status = reg_read64(sdxi->ctrl_regs + ERR_LOG_STS_OFFSET);
-	}
+		}*/
 
 	/* sdxi_do_cmd_complete((ulong)&sdxi->tdata); */
 
-- 
2.31.1

