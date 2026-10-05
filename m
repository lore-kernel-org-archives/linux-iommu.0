Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7B3672AF
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182467; cv=fail; b=pxOUZyCiFb53fTiQ3ZioR5+cKGEvsr7eUmhKCCofSGhe55UZmSVvsqzfr4ZUaam+owGvdMXCI9BFqNHZpEWriao6WrbVcG9Ac8fOfVosuYp5Yo076KT4Tr3ClfVrWc4HzilxoWq0+wk21eJa7rJOVe8s4YalaF24YaoTca0TtlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182467; c=relaxed/simple;
	bh=Av/bZtFrojD1kfGdfb14zsxfEFKdJUOZ0NHVZz6TyII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUsZRfmjKTQR4yxe4X324HqoRuKthmHWqJM+R6Ewsv1cJc711R3EUIsTp0K1mOfjSooNPfuq87sM7u0SGNAb9auDDw8hWCjaiFhPgBhTeqQnnhw4+VrkMy/0wzFLTLGQRJkYrF3N89+8bX3Gbe037XSYsWvCxSJ672GGTtAhO9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ekD8JeAB; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ekD8JeAB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW1QclmrvuGNdmbT+GUbdIzXxzqgBIy/uH+IoM2UJuHeh/yEi5B6MKp/csL4prQDm9wzD+TtrPa7UaaCmCgFJyYx7ok1BcotgDMYSVwW3sZRiu44+WLthkOkM2GQA6wZRPuvElY6ZSOYEj8Mcto46WBpI90owkk8ry0cz0m5C1C2oWrD4hB462bwOXR13C/du6s7x8zrd+6QRWhJsRoc+d9sGewGIgcABLyZBSJh0vK+m2+c+VTa1eaWKPN/lP8Ju9/A1wLkVVaB/obvIjMPVm8sMAxCaTUdkTiyyjbAe2v/Ds5mg5Fat46D6M8tNo57ujoarHvtCb1QW+1SkvOIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=871cQwQ7ACSQIz1Grs6A69/b+ccdbPv589rfmdbBVkY=;
 b=RXZDpNBMRncTOqlWkmWleX9aE2fYY68BNloDbgQDhRxZOrF6rGJSU7vaBg9ASzLsB/h9Ja74dYUysM9UqH8EYtvi7eMvi/ADdDPMnBrvtyIElITB2+wl+f4NFc53wjL4LUOJdNwHU2LVeflv/If3iHE/fgZyY236woLEjdJTHEbz6ZLuMiyAoJeqUqGm6STa6ojxqoariz33skBz6tjICNquoSBucJ06v7PloR9UPD0TEhX5Q3kIhiQAqsjnuZhRwuDGGp3xDsHnL/ji/rIKMc0O8w98OBFO6tvmsz3HH7erE7xKVcitPtKzeo7jLh3v+zT3neBiG2LbJg+WI8CWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=871cQwQ7ACSQIz1Grs6A69/b+ccdbPv589rfmdbBVkY=;
 b=ekD8JeAB11B01Vtg1iIZDCCj/4hL1mWvmFeLllZz/K1L1JN4S8X/0aCB8O6DrN4FkU/OQ3Cv5oIP4FVbz3kWYnwWeUpDEcLMDnnfeS0bErCaD6EgwzThJh2fzAZ+bpBmU0LMv9CcpsXs5o9Ycc858TC2P+IlQ/md8vgATQ5ksss=
Received: from SJ0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:a03:33e::30)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 06:41:02 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::5a) by SJ0PR03CA0055.outlook.office365.com
 (2603:10b6:a03:33e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 06:41:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 06:41:01 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 01:40:52 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<jgg@nvidia.com>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<robin.murphy@arm.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, <pasha.tatashin@soleen.com>,
	<rppt@kernel.org>, <pratyush@kernel.org>, <skhawaja@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<kevin.tian@intel.com>, <dmatlack@google.com>, <vipinsh@google.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/7] iommu/amd: defer device attach only on a kdump boot
Date: Mon, 5 Oct 2026 06:40:11 +0000
Message-ID: <20261005064018.1558-2-Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005064018.1558-1-Ankit.Soni@amd.com>
References: <20261005064018.1558-1-Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: f4410f77-a2f0-4651-88a1-08df22ab9f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|36860700016|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	W3H1kepr68P19d0+leh7MUYbOUt0WAb62s2ETq4j8eHjqUq2wZK8fnP3YJbwl0GDErmV18IlAPZzKf0DSZFIatwks9m/TFV3M1Ly+rDlxuD+0sWo1jMzqJcjGoCyD8yPVpUY6016PbTk70w0EriUUPOA5xQjboLPSEL1xyw1jnoCD9JLU9goGOT2uRJoXqKd8j3zLQMYPdF6N2zRBo2W23UTJXV1a9hHZqFXAF7OwFhE9Rf6lPOalY5oaTWmConAf3gxf7hhkcd7rp6beRLEFbyYC29h+UKRLCdCbcVxq1HxUSh5JArm1YujTVpZb75S8XdyI5rgmvyiBiheekMzlZPdEpMaOfcWzR9ko54VE1fuE/PpRr3FZjZgeA9lRmsexmYd1v8Z18iimRUL/6i9D7twx0HupwY7p+sT01dtN0Pg5JFvBbJ0y3dd16yHBievWG1+0EbIjJc8vvyi1V4kWme0doZSuXWetFfOHE4/HesbrasYYPnuZ5376+1OL7yQLP4KZcnwIDJMAOSFIr1R+/uMuUHbK8ynv3gm34kkDbcNMjTRyQq+p+j6OqzncKQ11RN0BRJypfGzu9OgXaJNrz2yWVWig7uX2tC9FvUL6ZyTmgCNZu1bnPBZB/VjfeEQgmpgEvgOWayhsLWzEs4CmmFB4dwI3W1w7ev8DUNEuak0femS7Iw2gpTZ5n84JTV7oglBCwc9ZfMUK1b98p0o6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f/UCWXWjk1K1h/ybvW5pV5Ei33mZ1uv4p0AG2Eex6w1WP575nvdEOg2mAyhWh3tR5V4QmUnDF0ZqgKHlORgwAdKk0DTK0GSiMIm4bEQy9ovUihbjgL0sYQtfOGX4OHBrFfhlGB0PtlkE0Q3dsLGbacAtYS0cy3TzzVPcB0hMR+yvs4IICVxiIx2yXgWG5d430NQkqXKz4R8uN952mmegNPOYS1SQfsjoEFYy9jla3c0A+NToVXExiTh2nMW1X7D7jtbf/04mW+CtR524jhYgIyUvlE4eDWUcRtMOCzVYLt8GoxHPv7vMepLTqzyopLxu7d+2q+6IBbuTNzk+S0VSpod+XR9RR34p/OBriqwGJLhatQQfHOqIfv/AC8G6VYUt2/z9JTcvgebJaGnS0JmuTqdyiBk+0icCpyMea+BPboLLvQ+Tvn5/vNSaYca0Baab
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:41:01.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4410f77-a2f0-4651-88a1-08df22ab9f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640

find_dev_data() sets defer_attach whenever the IOMMU came up already
translating. Only a kdump boot can ever complete such an attach: the
core completes it from iommu_deferred_attach(), behind a static key that
is enabled only when is_kdump_kernel().

That was harmless while a pre-enabled unit surviving driver init implied
a kdump boot. A live-update handover breaks the implication, because a
unit carrying preserved devices is deliberately left translating. The
devices behind it that were not preserved had their DTEs blocked at
shutdown, so the skipped attach never replaces the blocked entry and
they come up unable to do DMA.

Restrict the deferral to kdump, which is the only case that can complete
it.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4dc306a4b5c6..a83ce4521f7f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -31,6 +31,7 @@
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/cc_platform.h>
+#include <linux/crash_dump.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -500,7 +501,11 @@ static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
 		if (!dev_data)
 			return NULL;
 
-		if (translation_pre_enabled(iommu))
+		/*
+		 * Only a kdump boot can complete a deferred attach, so only a
+		 * kdump boot may start one.
+		 */
+		if (translation_pre_enabled(iommu) && is_kdump_kernel())
 			dev_data->defer_attach = true;
 	}
 
-- 
2.43.0

