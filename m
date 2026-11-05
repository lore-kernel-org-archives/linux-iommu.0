Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851245;
	b=Ai+TxtKlFwSW2EhcCm9c0ZvhriaC5kyBLTMK7B6zbl8s/9eQofjqsT5Y8xV4+DQIVIzl
	 4UoqTZvDP4UiRySP+npqjTkH6pvZo/h9ls5LTq8eCHdRi1yfEGdISj+HRzM2J0YYRqt7C
	 ekGcjn6MnRw4VZw0MN8uxL6EyT/o2fbr5AP0HE6VYMCU0TUafdCqiqZmzIjKYuo5CLUCO
	 xfpCh04WieuuYhogWhYALWYY8RZWKgWlJ3PNaKAGJjwYMGnQOE/ZqkXm9nlaD7Bn+fH++
	 CV7bf3NeXOip8OyclRCb2x1lechKZbdM0VqvYx8AzRC6LZO8DkhC6tTfULKBjRg/gPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851245;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uSMyLBmpeqjrOZshQebRYnlLkg3hWL+Kd/9yMrE/eAQ=;
	b=thjo1AOzj2Aj7/QdGBwfI42+bko3+oDb7VTgj20/ejkN0n/OJkDa+uOTRBf7DE3To+WR
	 OMWb3CyV7sElbkrwg2I/j/UAkmm84KnybMrC9HPx5CnoDQtXNU+cosCYIu5nxls9viFBE
	 QehyND+r7NhCcAaqS5SKMUqFJxmVsDzkjVmmwH5GHt+eX0TwrekUYpUnTOrJ9L8a2BO03
	 esC6jIp90AMEuf9uxpjL19mggN7RE6VqsCEuQY99RHTzHQQ16cfxjMfJIVvaM/N4i2y2c
	 3Q7hWeD/qloP2Nsg3XKYmg09/lpUfhniP4HtnTa1qpwrPFRJGeJuDzKAwNPmg8iZpMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="lrn69/78";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.29
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6265F606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6265F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lrn69/78
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTy2t1zHP/zvZ/lvQ/9AOXWFy6CasipvgCnRjHbx7HR7gEqQRuqfH4SaHzABNyjPPRGEhu4OukXpCXHIgIzeVOpRC9ZYyW4c7tNzw1z6v2cgTWaxXpS7Bn4goVAPI73PH/dUM6oXzYZJHwErBljV+nrmd3nh0MDF7QySaLja3pBLJdaWr9wtpjPuIfKne3ZwGJdSeLvHVxxPkwpJCHg3sFLZThBehUp84b+ZEJAhLCjhUoc7xgFzZrN4v2BVb1x13yq9KwQIQvT5Uk8saNgMBQCe1q2MgmzeovuSZc6e/odbthRlEk3JnGkLENegRzpTUT0f5DzofTaDaBF7XfvF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSMyLBmpeqjrOZshQebRYnlLkg3hWL+Kd/9yMrE/eAQ=;
 b=D485nIKDlTgydio3faHXfQYcEO6iqMpdbeNaX2jJWIVPsxhj21rhhWoz9YefNFp1ea6BInj316JfSWPz66p0+IHalrfjsZV/da8GaskOfPtFaVwZmmdStuvys9z8YlK3VzvbDxxepqtYV2ct5xFDSnzVuVJvtYo/FB0GivGU48p7I1essqOhTswE8H+13Wi5mdugkEJ08XxbGJnX2gQIRCqBXmtLAGkfFUF1DCcwGso9hv2gLAj3NdR+rwRYzCUyu2nRpuTzJxqvkwOQXpHRrI38nLsMlHRQk8wQdPu11YuJCaIZYuruxjJx6Z/ivRMOoZACDAHVPkVz0VvTERYaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSMyLBmpeqjrOZshQebRYnlLkg3hWL+Kd/9yMrE/eAQ=;
 b=lrn69/78Ok01Pvp7ISvuIf0dfVq8ypyXV9Q5uK7sVWwWSvfMUP6yjrux3abd3pyP/w0/uN8UUKq2obBpQPVwkRhVe1r708MfLNumRBXvPCo6NNApJDBktd413BNXEP/yIQ0f51lPjXHKkxhwHjFqFjLOKwVS0EWDfffUD3A+NCY=
Received: from BN9PR03CA0810.namprd03.prod.outlook.com (2603:10b6:408:13f::35)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:00:36 +0000
Received: from BN2PEPF0000A88E.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::7f) by BN9PR03CA0810.outlook.office365.com
 (2603:10b6:408:13f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 5
 Nov 2026 04:00:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88E.mail.protection.outlook.com (10.167.248.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 04:00:35 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:00:33 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/5] iommu/amd: Fix init teardown and IOMMU interrupt setup
Date: Thu, 5 Nov 2026 04:00:11 +0000
Message-ID: <20261105040016.398718-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88E:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: ce031583-a1f0-4ab1-ed56-08df3af15880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|10067099003|3023799007|13003099007|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	l+0Pm1j99hnNmSlKJlnxGY1yT9ZZrooo0QL0FSVpviLjBxkr0OnILa1hF8WS6vASI+Hmjnu+IEF88WOCNcvg0AIUHVBKmw/xUZUaSNGFJvGwwsosJqQxBDD3K4WOwntcikVGrKwy2ytO5Clo5R4js3KmlpZwZg9ycs5c6UcuD8tifA7XEXKo3TSNO3DVK8OXN/xobdqsq6V1jwqcR7DQTWcAEgu69lqtk0GqNYcikq/JC8ll6LYWtqaO5jeXobtg4vlrhQiRmh62hFTCT5hYKCxy8EVeu7C0u9hU2MFQr0PgXJsAJ2WM47vZw8FZ+BsD1g6vyJJXG+caXqSZeFnriMfo6gqdHhgI5livg4lH/ZiglTi2mtqH9a9LRUD2BjLXLsQUDmy+6KtOGzIV5twjQAd6hrcn6jTA4zyYtrs9uUhN02yjcIqhdY7bgQOYGhG4nnbF8o9XGZlrMwc+HQ30p2Q4zEv04FgbjvU7T/W/qvcmdnOja6hcIG2CMB3UAPwI18WQc+XthOlDqWWkaky71gorWRu7Ar8a3ocIXh7CS9/gNsoleGj6VssrRb/up2jMBi0Wylqc0w0W3gbWfB/fXP4Qz5DvZH0iN8TVDfNUJZe3AAxhX9BsuL6EBcUiwQQ4qSEd1PJdnIVfGtbsIjWyp1JUmxx5czC6/YEEYR2O1/F9ZC+z4HhBZLtF3SI8QDEwD2Femq4KdH0KrejWQLW1TA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(3023799007)(13003099007)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xMpxF9apsgLIjqQ1vV66SPL1AdkaiU8Zs7De/ou2K2WfCSSnQp7peuxrLbRvQNqI9FDpoR27VAXJIXqusyiJZa5IcnkJ8NbjVpoRT3zGVU+Lg4MvmBNfyaz6P7ATiTRRnLPkcqe4Zq4nS/QNJ9Blm5N/4CB8JGpAajrojb6lViLgZluhw9q9LOHWu0E0U1ET+nCaLT/BM9+j8qLMzP7EQTg8L/2uTVnhv46qemg7rx20WSU4J+7X07sjQJbi781f92i8NpFdaEpT+X/7QvLGNWg0QpHu/LpB27iqRRW80PXelvGQkwluisg0Dk32KfNC2LeEVTFxgchs+P6CniMo5ej/2yZZnXgqI8j9hQ9x8CAClDu2QpI313KiJHqRjVWl9qMdcgRJZvuS0aWuuxCaVgpHVXF8J6ctirctlgZ54AVytp5Bgb1a+0DrAL25Ctu+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:00:35.5839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce031583-a1f0-4ab1-ed56-08df3af15880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A88E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

Init failure tears the IOMMUs down in an order the hardware and the
protection-domain IDA cannot survive, and interrupt setup can select
XT mode or drop the shared INTCAPXT domain while IRQs are still mapped.

- free_dma_resources() destroyed the protection-domain IDA before the
  group default domains were freed, so ida_free() warned for every
  domain released during init failure. Destroy the IDA after the
  domains have released their IDs.

- The failure path disabled the IOMMUs and then unregistered them.
  Clearing a DTE queues a completion wait, and the command processor
  was already off, so every wait timed out. Unregister first, while
  the IOMMUs still accept commands, then disable the hardware.

- IVHD XTSup was treated as the mode to run in, so CONTROL_XT_EN and
  INTCAPXT were enabled even when the kernel cannot use x2APIC. Stay
  in xAPIC mode and use MSI unless x2apic_supported() is true.
  iommu_init_irq() logs the missing MSI capability and the errno when
  interrupt allocation fails.

- The INTCAPXT irq domain is shared by every IOMMU and by the event,
  PPR, and GA interrupts. Removing it when one request failed tripped
  the revmap warning and left iommu_irqdomain pointing at a freed
  domain. Free only the failed IRQ, and remove the domain once its

Full series is available at :
  https://github.com/AMDESE/linux-iommu/tree/iommu_code_audit_7.4_v1


Vasant Hegde (5):
  iommu/amd: Destroy protection domain IDs after the domains are freed
  iommu/amd: Unregister the IOMMUs before disabling them on init failure
  iommu/amd: Select XT mode only when the kernel supports x2APIC
  iommu/amd: Log error message when IOMMU interrupt setup failed
  iommu/amd: Remove the shared INTCAPXT domain only after its IRQs are freed

 drivers/iommu/amd/amd_iommu_types.h |   3 +
 drivers/iommu/amd/init.c            | 108 ++++++++++++++++++++++------
 2 files changed, 91 insertions(+), 20 deletions(-)

-- 
2.31.1

