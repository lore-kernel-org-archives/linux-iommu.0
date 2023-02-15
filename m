Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79EE17F5
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 05:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1UuyC3gHOimXmNENW8fz0uYP4RNNrpmaFyjySR3mNmHz1e5a87mmZf0TekBynznsYZZJlHlL3QsaZ0Ntkm/J5sE4mhUEh/AzvmFvpDYv7Ql99SIG9LD8IEHHv4wjs2kbxX17fOhH5ZxHFEgKXHFimxi6Rkjz/KsTzgCeDRtojoX14oTgVvzWv2OoyG+uNSGdLdT8Lts7g/afgzyLfRHympcsOEz2jJET8ldVXzU70Cvs18Tdq9Qv+UU2UhuJgDwjwBy29f7gfHtDxd9D7neCktRwXxFrXqHlZ6FjxdQ9MYguJKwkTzXkPRIejzYvVEg0eDLKpfezE64BKFHAC6Yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A450avS394eP89Q08HzutBhTxb5DOBuutD5mBJ0F9Y=;
 b=dUY8cOiMnI6VQVz6xzqcFcOs0fTUD+yQAu4cyjPxe56vIOV15y4Vfslm2SjXpM8JqF4RC2q18pIRN00HPB+xeDIdEE6TYFBNFSll3TH5EvOrkd/b/L9VzecUDi0Y8KOWQTRSZhPo8ilTiRwi0MBlqa5nj5BsC/AtDXXaieLNLcJ6i/7mqCwz2n7TJB1uWzevMieY0SvLCM9vvdQcMaP48EEmK1s1IyvqANNARx2rDurs9ROqkV0Opp2J/bfhkDScK+yEtPu6FJQacbyZE/kc64l+X7NhGm/D9jsyWe2jMp+vZ1vZAHfAwYQriICyrvjtemam7qyVFp5wI2jFd1mJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A450avS394eP89Q08HzutBhTxb5DOBuutD5mBJ0F9Y=;
 b=1Cr/1YQr/MMdgrqFzMK7ISpGebLphHbJ4oj9UlA1WiNtd0+yX1AHcB5vY6W7wA811++/NF4SkMM2dVVvcDyWZ86sjflwXbs8Gxjc/3AwGrskijyzCugbRFCudb5ih1YuLdNoWC+OcyC1T6T9Xv8ucsNMVOwmt1iw4y3yB8nU9lQ=
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 05:27:55 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::9a) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 05:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Wed, 15 Feb 2023 05:27:55 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 23:27:52 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Matt Fagnani
	<matt.fagnani@bell.net>
Subject: [PATCH v3 3/3] iommu/amd: Improve page fault error reporting
Date: Wed, 15 Feb 2023 05:26:42 +0000
Message-ID: <20230215052642.6016-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215052642.6016-1-vasant.hegde@amd.com>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc06639-cfc6-497e-9707-08db0f156473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YtzxzVwOl+CJVqWOf83Dr2r2rRFnhHGx0L9RGgeDylAw8IXUthRXos1vRmtBH4VBv2AeulW7WoyqqzliogNSgAsbmqxiNxDjGoFZSghbPSS7ZohbLzvGP4QWEKqntNHPNlaEMrKgFGQClXXGGZAvE3twx3TOYhgiqQJRri8pMFw80grqf9xihGN8w2OfOsOy+hObycp5O1F+O2Cyr1oAhlSgPCcW8ynY+Ilhlb55envGVoSIZIYdI47hslzo81Ipp3l986u/ReLo6x92djrAAG6VxiCA1sG+vtYXV980Gmo31/Z0HSqkOvGs4s5PaFMkvo7KRtgrGoNJsm+kSGBadtL6e1xlzgKUSGBVI8SZ9DrihCYkkBRqxTNcB4HIEOY7moyT1rQIv5o5GDUfiwJuK7yOSc60vrUCjGlofuGs+NFAna1+XiljXkgZtO5Yp4r42xRRV5fqWPk3x4IYWwJU2NtVUJlw1EhCD4jcHAO3thzX74l72VxKQWD6WUOX2UwiAQhP+d5Vqq7LJLl/qEjC00m27GjGJ2amA5nsLNDmLTnVPp6yeJ602S3GiKWaXX+G//rTtvPU5NuuTiaGhHyqMwvc+fugXE3hAQf+YueAkPwP6P0nsB/TkeQP62NkiVaTey9EVRM0NH1/ZyMRdMIZZ170sZDvgUrByp2gH92KlMyfbOnLA3vmMHBNuwqGgQolJEN1Dhr+lvrfz83yS5LyqJc9zJD8tI+c6QuetwotF2cm7Z0/1Zcu88JLnx4Q6+X7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(40470700004)(36840700001)(46966006)(36756003)(40480700001)(6666004)(110136005)(316002)(83380400001)(54906003)(40460700003)(16526019)(186003)(26005)(2616005)(1076003)(2906002)(44832011)(5660300002)(8936002)(36860700001)(47076005)(426003)(478600001)(336012)(82740400003)(7696005)(356005)(86362001)(8676002)(4326008)(82310400005)(70586007)(81166007)(70206006)(41300700001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:27:55.6614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc06639-cfc6-497e-9707-08db0f156473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187

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

