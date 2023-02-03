Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC360AD3A
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 17:37:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUtDOp72MBsIDebOjqo/YnwnO4ve6qTHXDGZ6jDXRNlHs805ciT4GfzZF5ilwP1LsCed4oEuAjiSpPQni/isOhOC96ApY23e7WZc3I9d6FHSyaF8xBVBvcO1w1+EjDwFUxNG6m5H4GEDgAxO2Ge0ukwGd+PzOcnQlU9KYsR8/nCGu2YxQE8XNDsiFbHSkS1m4kRhPqPv6udJedgOxZRicJ492iCaXrL0NKmUZ7J/9FEMSIfNyN8T3LKhG1V4vygO0xHadh/UQVKPVQGdAqm5P2F0cPRvsN/tn73Jg7MPSRAIezAyODCcC2W9ZDrp8PzaXmayO2PG03CIChyqIEQJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTd2B6dNWdXHVyIwmeiYHucFUdPP3lzfZktxvOJU4d4=;
 b=h16ZjIKXEdzMw/hYYczQcPfYEm71VgN8rxDeJlDSymJGbigmU8QDE9YDcZEv1lXYZK2qawU9D4WKA4lEzSh+2lQIv1E5gd8MkB5Ja0nTXBnqPRP8nI70RzAFthTqXwBNvX36CgrCB6A8wFGS1Jz0k9sa/XSageT+Jm3p6MWdevfV8CXoOOrlp7FSEEzhuoGWYCACuYijLMsDa/+F9TyH46rpU/RjDnfTC1lfbDNQGtSVuKL18tiG89FfW87qgJtOGuYmQyPXdac+8RrA+DOUVuYUQ4Rvhn+z5WAZl59+FrDrY6bGD9ojvQqrzxb9C4I9xRgTh/Pih/YDqAZIHFDoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTd2B6dNWdXHVyIwmeiYHucFUdPP3lzfZktxvOJU4d4=;
 b=l+9t8gtf7M57IrcX19TQzPLHsiU6iOmol+kKht+k3zK/sEf+eP4GUoTheeFv/8sxIwkko36Mmmz1VgAdKKypkkT+Vk+/uK4FhGxJMX8PkGzrw9crZYTfV5cJLUrsYiBVu4moJl1XltOtioFn5tJzRe72dVn0S/6w42LOq91QAGU=
Received: from DS7PR03CA0125.namprd03.prod.outlook.com (2603:10b6:5:3b4::10)
 by CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 17:37:11 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::19) by DS7PR03CA0125.outlook.office365.com
 (2603:10b6:5:3b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 17:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 17:37:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 11:37:07 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Matt Fagnani
	<matt.fagnani@bell.net>
Subject: [PATCH v2 3/3] iommu/amd: Improve page fault error reporting
Date: Fri, 3 Feb 2023 17:36:23 +0000
Message-ID: <20230203173623.18308-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203173623.18308-1-vasant.hegde@amd.com>
References: <20230203173623.18308-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|CH2PR12MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbb5e78-6948-48e3-4be0-08db060d479a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0niTJLN96Li8jvy7APoV7by6WM92+t3FA3q+Rln53WgkRyq/CTfbYk1GM5/W2KFHlbJ1wmbbwapwGjbU2xhV2RNfV/V3O+IBu96Oji55kLG3g6XJjFY5cLmY5FSrs5+u29w6v/0FjgECXfoBWxjLwyBsjC5CA2rJyv8eORexkwTql7DkQdl3MXA8ixpr7p9xQKnRMF9cXE1/4AYBJJSPwfouQkEHWavCIIq2Me8OOBqv2onPgbMeQFao00qs9qfSKltbpK7AiRPIvfUCsS7lCe0OPHIVQk1+KKbYX+MNrWIupYSpkYW7qfYmpEBTOQgxmofwPSEQ5Fh6PGNBAbE6ScD2D6kMcZwMUHAeDIdLwGhU9+Q8pqjEx0rUvi9xKr1oKrzlemuOSJ4uwB3LrSVS4w0Ln47C4JqmzAZb7rQZV1j1nle6NpS+lf7J0/5jF80DSbBKpLB3kudIhh7mccSkAe+PBCslLwXzT87xT6RxBjygwXspFhjscdrezx3IC03dunXK5xnndEMlyRZoPkUjkd6Flc0EbhjbtLkAmrMibnUzN2FULXGoqYNanTi8NMbafcgmXGxyFuUw9VmXEGcCy2rfJZGHFUuKeglNdpXGfl3iqOgNoNQ+5L59vACV252SSPIZ+tbUhUGmryqxGVVCH9yMSkDvPTeYFdAosP+7kCvaYHvrWKGHgCQJ4j2hTlB4mxxYFs6B86pU46vrVnVv/rlSBaHmX6qHm/jpFpRtrHup3oi1bvyFOYgXBkGL735I
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(4326008)(1076003)(186003)(26005)(8676002)(8936002)(41300700001)(6666004)(86362001)(478600001)(5660300002)(70586007)(44832011)(54906003)(336012)(36756003)(2616005)(36860700001)(2906002)(16526019)(40460700003)(40480700001)(110136005)(7696005)(356005)(82740400003)(70206006)(83380400001)(426003)(81166007)(316002)(82310400005)(47076005)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 17:37:10.7911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbb5e78-6948-48e3-4be0-08db060d479a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4969

If IOMMU domain for device group is not setup properly then we may hit
IOMMU page fault. Current page fault handler assumes that domain is
always setup and it will hit NULL pointer derefence (see below sample log).

Lets check whether domain is setup or not and log appropriate message.

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
Suggested-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes in v2:
  - Removed BUG_ON and added log message.

-Vasant

 drivers/iommu/amd/iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 26c96b821fa2..9dc41c48c29d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -558,6 +558,15 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		 * prevent logging it.
 		 */
 		if (IS_IOMMU_MEM_TRANSACTION(flags)) {
+			/* Device not attached to domain properly */
+			if (dev_data->domain == NULL) {
+				pr_err_ratelimited("Event logged [Device not attached to domain properly]\n");
+				pr_err_ratelimited("  device=%04x:%02x:%02x.%x domain=0x%04x\n",
+						   iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
+						   PCI_FUNC(devid), domain_id);
+				goto out;
+			}
+
 			if (!report_iommu_fault(&dev_data->domain->domain,
 						&pdev->dev, address,
 						IS_WRITE_REQUEST(flags) ?
-- 
2.31.1

