Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795778857;
	b=QQ6xsGuPJOe6Cr4/Vo6u6naP6s97sWFyZYeNj6UQxCDS6Z5k9XEhhD6PxjooPqPpDh4y
	 WzuTvEP9xZRSXOQVwnW0HAFdx8dhRRsigDp1Dm1BZqlQjT3fXZ0mfRNIhE9FCXm7jdQR1
	 5vVHDaXpm1l3+Ml5IQlsXzhCiANbFpOOLPBBkAlQLGx4Bd+AZtvkY1utX2rKC7meJO0vk
	 HXwiih0MxhnZqVKOa7dYpzixJoVHwJSytlNjHuoB2cJHtPvBdEl9tcFt4xb8A8LjFMDqu
	 PgUYKC/z/77/jTjav0GlzNXS3QbSfRcG875lBDqh0LRjWUN7XK64sVQaMGUovvPv/mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778857;
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
	bh=OegVPZx/u/8MJmwMALyP58bd68l3CPa8RyHXMQCHBDE=;
	b=d2GJPr4jY8Wn45ey1jYggE4ooRbxiMNgdHP8eEoN9iqkO0WCOLgE88kdCFs7wLv9tgmg
	 Hmi4/bTwua8mZ5UM/VRNEsiKMqcyAJn7qRqKfYQw+RPzfnVrofNbJtN4JWqtbhzLPd4Rx
	 sOz0fiNadXlN084HlLSUC2IoQmvOGhzaE57s2JtfzPCmoeqzWM7O0RbgLLoh/UN+teBsf
	 mVlVLRcCDCqOPDBj9k4o6bTWBpG2kohOLXZETBq1rFlM6xRzuxF06fvotHFAGOyLm5lcg
	 P//iiQuVXAs54UCrZm2MCAxkuuoEcMy4zMwOhP844e+ibqDKU9BOdAIEG2c6M4yQXXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CdXWlPVa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.36
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013036.outbound.protection.outlook.com [40.93.201.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9762606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9762606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CdXWlPVa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysnmt3fzWYgBoRYf6g0JWpjuUhQ8fPax2UApmArqQwIDj19ENY3mSRo2t/+8miDk5tSgATGsy4ST86RPEfnQRHyTqsrNaj4cFfYEZFB46mm4NeyH2ZFA1BF6dloDEmza+0O/T/CCRuo92rzzMOYCEdS7VnsKlVhwMibAW1+cG3L5JdimmZdEldD3sNW9pTDYhQdjSbgAj+PDVn9yghxpwClyw1hek7rm/pGqMSDEbxDOzuLbnA8cXQHcKCJ+Hl5E1RfJZ1M9qNl+GCVa0rxffEWgjXWDVCvIoTveKCFsAgMeigLLntKlqM91iPC7OoAClr+hQnu5o1cnjJ53dlBTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OegVPZx/u/8MJmwMALyP58bd68l3CPa8RyHXMQCHBDE=;
 b=U885LPLeONlLGFzRrxoRYi/0pbbvESmI/wQ7gHTVGadoulVXPcr2Hpu0mm4DoLoa2r+kzLdLbCzIzgUkmHaP7U0o1k3HknAH/JDNkbvmW3tVFZhUaM8a9ccy8w8OOWSd9pPhEBtJ8wGS5B5tuYUIatmiY7yLoWqTPaozR46OWtjgHglpepmSn5Zc5KrEISkA97Le8fz8jk8UAeH1vJTkcSbOlfgCB5qz73HnoUnngdFAWIkcyf2vtv5YAT0NV5CUSIVd1aa1fW0hm8HCXVbyCKwtCiSyLUCPUL9ng/XEKieNRp94ntXk5ZkGCRoDN7/IBfEt9S4LfTSbu+8BYSsx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OegVPZx/u/8MJmwMALyP58bd68l3CPa8RyHXMQCHBDE=;
 b=CdXWlPVaaAV9uu8OIVcu24JFnJ//P1l+zMJQumc3cGebW79hYbW5k/nCG0BH1zDDwHeYm5eNuKBsFOjRACJpPHv/tFV6HrhPW7XB+Ps/vTlrJ4VuApUfS+LpcOczVt8kE8DOkaCDhFXWXWmkIqWcSQB7OgvQ0ikdvLwDbg5GI+I=
Received: from MN2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:208:a8::35)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:27:32 +0000
Received: from IA0PEPF0000003A.namprd03.prod.outlook.com
 (2603:10b6:208:a8:cafe::10) by MN2PR12CA0025.outlook.office365.com
 (2603:10b6:208:a8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:27:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003A.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:27:32 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:27:29 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/4] iommu/amd: Fix init teardown and IOMMU interrupt setup
Date: Fri, 27 Nov 2026 11:27:06 +0000
Message-ID: <20261127112710.208885-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003A:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2e349c-106b-43e0-1c89-08df4c796d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261009221227099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	aD39f5dE1yOsZl0Crk3AAltKy3y9wjZZWFdtl9HgV350XGpw8EtdrsXLukTgZP/PkRaNy2/QdQRXQopNOTEJuzh4Jlff1HZPafeACssNN1VRt78pTpNtXO45NKteP7oSIqv1Y9rRD+JIxuSiEUMB9afJcVjX3K/W5Zk8V7bJPLefoauMhelWYwe9SY/07//kmoPq7ja1gzaUS1Gu3P7kp8McRr7Mey66WptHySbUEOlZF4NYEKXOrlQPbLz4zS08PwuwCDWoXX55Pqso7nCbY2BYVFeG/QyrmBAKePbK4DOpuvflTjuus0LSeXX5qYyhWWh6UOxwXnkLzmnpZQvo49mrztq6E3umElhCpDdFWLxxyk2XzCQ/vTKzYykFBp2Iclv3425VGxP74AmWp3hCTPPKXajB0PQEVqv+tUb0gEwPNLWqOyz4YbgSVp5F8FlxsqqS/IShnt3UQIuWiSc3Xp/7wkfhxUlckkmqbYv7b+g6Tpqt9dXiZOjG+d8OUXSsrKIMmZWXylI+x5fgCVJX/iH3gSJy5k57ZN8efDNMteeeQnGrDpE2iR0/0O0tGzwGREArBsECzST5d5flUETqiXGzOYyt6HQi6R7zHuHJAXHs4rxoVr8LOA2O+ubEHVjoqc9/doeo81hxn1gPM/6ukvJFo0vK+Qv75Wgv4nSw7po=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261009221227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I6tTN9dxGnH6S6LtaqtEvRVkUzrcPl+FLl6c9YLsWFmv5pi7o+boUNWm5jSUnIPsJLnjukeUJT58NRO9NtNiuOe2KTxxZzRJgY+3psOtXNmE+l4dY9LjsUa0Mjo8USE99UWlbOMGPizfJoHr/eR4wIHgVdPZDWPbitHJ7j/d1m8EvoWKa5PgWjaleFnrl/uaLWZMXZ/ls6ZWlcCHn570j1uiyE6j3xkK+yfturt7bdFcM9iM5CMAk0RbxgAmw3KDCGPqmlO+cLZsi4pP/qPXCAVbr2X7SF42+S1LWN2G6bodmNLRfIauxfXloF9IbaF/dJLGMMUE7b0ngfUBQfiTsQJWS63kdSpINuiJI7Tpz036NwvUApCcFzAAW4LfNTEvaGtAcz5Hhicb747UU98YAnjpvy0iNeFa46mBwUVzJiAP3zKv15Hx3G7S+mjKybIE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:27:32.2907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2e349c-106b-43e0-1c89-08df4c796d98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391

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

- The INTCAPXT irq domain is shared by every IOMMU and by the event,
  PPR, and GA interrupts. Removing it when one request failed tripped
  the revmap warning and left iommu_irqdomain pointing at a freed
  domain. Free only the failed IRQ, and remove the domain once its

Full series is available at :
  https://github.com/AMDESE/linux-iommu/tree/iommu_code_audit_7.4_v2

Changes since v1:
  - Rebased on top of v7.4-rc3 and updated tags
  - Dropped x2apic check patch as it needs more work to handle kdump scenario
    I will post that patch later.

v1: https://lore.kernel.org/linux-iommu/20261105040016.398718-1-vasant.hegde@amd.com/

Vasant Hegde (4):
  iommu/amd: Destroy protection domain IDs after the domains are freed
  iommu/amd: Unregister the IOMMUs before disabling them on init failure
  iommu/amd: Log error message when IOMMU interrupt setup failed
  iommu/amd: Remove the shared INTCAPXT domain only after its IRQs are
    freed

 drivers/iommu/amd/amd_iommu_types.h |  3 +
 drivers/iommu/amd/init.c            | 96 ++++++++++++++++++++++++-----
 2 files changed, 83 insertions(+), 16 deletions(-)

-- 
2.31.1

