Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA079CE
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 14:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzTbebJ4tkSUPiszQxZxL6qFusJwcpycfxCmWqBZHlkKdPaf7OPbiXBijIIt9xbkNVOb+ZBTrByhoqWpIVIrS6haFmPbr9M3cwhGnwd1GVXcnrU+yPqWJZFErvIeJ4nX3y5fwH2AkNM2KOR5oALyNyTl7ISXLipngkFzYGbpvW6TWrv0oGeZ7BgPBVK896OiZZ4/a/BC1EDY+EGejd7X4L4KydF23NyD4w0VhALS65AWOcpLX6FEHGSZ1OvTYkobzV78CLxDCL58CM+gu+ArxAWVmvJGbAVsdMEvTQURtSkdVp9ukBT69n1T7vps8XZz7474Mw003Io57IFb5CrvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vu/nQYg0XBXa2iP73zKEmi6XRTTS0CbUXkN5t3IaLs=;
 b=lBgOMGllYSLz26yVAAitg5F2MawJU9VN+kz5VMY+nY9+rn6SXnE12kqLSDKiwWcMw/AnwgWQQn3oSYG1aIBK+yxjXnr66jA6FneH32rzd4PiXWN3y0KtZhPgnbKaU4+f+MOw01Z8CBB4XbT60eVXgLe1tL56QR0HjoGmPHMtNJryIaMHwTPhRqlHoRMkYPz7j1aMOoCczoH2yG3qRs07lRAjOeo/SP0TMonRsL6l8d00zxZean28GOD1EJVXe0meHQUHsD6NXTcvYLqSC8TIgkXu0Isye5vcukHGjtvjHvmtzYgk9sDv80habySSzR7bviVU7KSzHzTHl01RS8GrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vu/nQYg0XBXa2iP73zKEmi6XRTTS0CbUXkN5t3IaLs=;
 b=tx/gy+6sE6+UbhuUGFkst/8VY/jyBkEiSnYywiMyNEBw2f7+qRmqvWFq9PDvQBiSQdUgHYRRT4LgwUpkCzrniBmJpMCBwNtnmXx1ia4KPgUW2G9PXOttYP/MNBJpYpi9xU3YJYYkKAcdYUgzmEdSajpXXxy6k4z+VBFUNKcOBX0=
Received: from DM6PR08CA0006.namprd08.prod.outlook.com (2603:10b6:5:80::19) by
 DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.19; Fri, 13 Jan 2023 14:02:43 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::69) by DM6PR08CA0006.outlook.office365.com
 (2603:10b6:5:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 14:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 14:02:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 08:02:40 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Matt
 Fagnani" <matt.fagnani@bell.net>
Subject: [PATCH 3/3] iommu/amd: Call BUG_ON in page fault hanlder path if domain is NULL
Date: Fri, 13 Jan 2023 13:59:56 +0000
Message-ID: <20230113135956.5788-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113135956.5788-1-vasant.hegde@amd.com>
References: <20230113135956.5788-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec823d1-ca73-4905-3ef6-08daf56ed752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gniO9iUXIYNfGu3gxr8aTOjj9LWzLp56Ck/+xVLsjdwWSVGjq5FaMhsJSNBFMktH8kbxtdWuZ0iOySja20HiYN/BgiI0BpjMrPBvb1HNYQ4sBg3qAss6u+tFZnxjnIebANpE8hWYmSRuEpquZAOjcsOgvWNsFPap4utclD9R7EbNrQ6//UegHsXCLCiXo7F19jzJ8J3cx6EgeDb3IT1zN8VpoXfE/HXWUelGMOVP/DIKZAvHoSVp0wfuOsAw27s7SyLQ7PGVHkwbC/WaXSkk0WuwORzClhLkZA90dBT0MkjZiwdvGSYHedg8Y/i0vznADZqSXTuRLYKM1ciXllnhgLU6alexoFqw+IKtdXNQTLEHYsT5ckbU2mOpSQ+iXWmVmRdyvfVq9F2eEBs1BCUjbpLJ6ZS9KomsVun7iIXTLsog2GRgCFdS/HN/r3IF7HZa7va3BXfUH+n5qYOZUrYKxHUb38j8on6l8np7RYARFINA37UVn1RQTMvSCIRGB5t2YVIeDgKRUFCIALxxst0ojzS7jHZ/PT2vKax+SkTm8dV8cQ7pYk7hknhkmSmks5ZOjKcqhzc61vOJoLvZ+mMKq5laPzm4QSulx7WtXVGhBR5+GZbm2+HIr1IhEtVmLwvkJfH+E+4mCEjN5YV6pGWDB/vYIY0NZgHYXaJ79TULxsUnW6nHAPkS4ibDAJSwOsACnNrig84N+G11XBDopiDceJBn2f0/ciGXXSSxHmmC8pZMrbK90xFXyqQIELSFp5Pk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(44832011)(8936002)(5660300002)(54906003)(41300700001)(4326008)(70206006)(70586007)(316002)(2906002)(110136005)(8676002)(478600001)(7696005)(81166007)(356005)(82740400003)(186003)(36756003)(6666004)(82310400005)(26005)(16526019)(36860700001)(336012)(426003)(47076005)(1076003)(40480700001)(40460700003)(86362001)(2616005)(83380400001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 14:02:43.3264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec823d1-ca73-4905-3ef6-08daf56ed752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414

If IOMMU domain for device group is not setup properly then we may hit
IOMMU page fault. Current page fault handler assumes that domain is
always setup and it will hit NULL pointer dereference (see below sample log).

This is mostly programming error and difficult to recover from here. Hence
call BUG_ON().

Sample log:
----------
Jan 06 02:07:52 kernel: amdgpu 0000:00:01.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 6
Jan 06 02:07:52 kernel: BUG: kernel NULL pointer dereference, address: 0000000000000058
Jan 06 02:07:52 kernel: #PF: supervisor read access in kernel mode
Jan 06 02:07:53 kernel: #PF: error_code(0x0000) - not-present page
Jan 06 02:07:53 kernel: PGD 0 P4D 0
Jan 06 02:07:53 kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
Jan 06 02:07:53 kernel: CPU: 2 PID: 56 Comm: irq/24-AMD-Vi Not tainted 6.2.0-rc2+ #89
Jan 06 02:07:53 kernel: Hardware name: xxx
Jan 06 02:07:53 kernel: RIP: 0010:report_iommu_fault+0x11/0x90
Jan 06 02:07:53 kernel: Code: 0f 0b eb cd 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 55 41 54 41 89 cc 55 48 89 d5 53 <48> 8b 47 48 48 89 f3 48 85 c0 74 64 4c 8b 47 50 e8 ea e8 4a 00 41
Jan 06 02:07:53 kernel: RSP: 0018:ffffb9b7803ebe08 EFLAGS: 00010246
Jan 06 02:07:53 kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
Jan 06 02:07:53 kernel: RDX: 00000001522e2500 RSI: ffff940cc09e30d0 RDI: 0000000000000010
Jan 06 02:07:53 kernel: RBP: 00000001522e2500 R08: ffff940cc12c2b00 R09: 0000000000000050
Jan 06 02:07:53 kernel: R10: ffff940cc021e000 R11: 0000000000000000 R12: 0000000000000000
Jan 06 02:07:53 kernel: R13: ffff940cc005b000 R14: 0000000000000008 R15: 0000000000000000
Jan 06 02:07:53 kernel: FS:  0000000000000000(0000) GS:ffff940db7500000(0000) knlGS:0000000000000000
Jan 06 02:07:53 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 06 02:07:53 kernel: CR2: 0000000000000058 CR3: 000000010230a000 CR4: 00000000001506e0
Jan 06 02:07:53 kernel: Call Trace:
Jan 06 02:07:53 kernel:  <TASK>
Jan 06 02:07:53 kernel:  amd_iommu_int_thread+0x60c/0x760
Jan 06 02:07:53 kernel:  ? __pfx_irq_thread_fn+0x10/0x10
Jan 06 02:07:53 kernel:  irq_thread_fn+0x1f/0x60
Jan 06 02:07:53 kernel:  irq_thread+0xea/0x1a0
Jan 06 02:07:53 kernel:  ? preempt_count_add+0x6a/0xa0
Jan 06 02:07:53 kernel:  ? __pfx_irq_thread_dtor+0x10/0x10
Jan 06 02:07:53 kernel:  ? __pfx_irq_thread+0x10/0x10
Jan 06 02:07:53 kernel:  kthread+0xe9/0x110
Jan 06 02:07:53 kernel:  ? __pfx_kthread+0x10/0x10
Jan 06 02:07:53 kernel:  ret_from_fork+0x2c/0x50
Jan 06 02:07:53 kernel:  </TASK>

Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 26c96b821fa2..2421acba08c7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -558,6 +558,9 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		 * prevent logging it.
 		 */
 		if (IS_IOMMU_MEM_TRANSACTION(flags)) {
+			/* Device not attached to domain properly */
+			BUG_ON(dev_data->domain == NULL);
+
 			if (!report_iommu_fault(&dev_data->domain->domain,
 						&pdev->dev, address,
 						IS_WRITE_REQUEST(flags) ?
-- 
2.31.1

