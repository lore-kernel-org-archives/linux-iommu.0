Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A454F55C9
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415309; cv=fail; b=CC0sSlLBbtheKqFnfETmXTuvr/QvTRXJZVGsgRaMcmXCOMmCeJEcTPlogfCTrab1seGIJPXq65ZplEygFgna+F2Pak+XMkF6usGHuHRSCaz+yu66sqX80kelVlsRSMqOE9V5h1XnIAIbGuzYihdaXfNWTdzuncIFpVupRY6ChKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415309; c=relaxed/simple;
	bh=1Jrtcr0/CS+OVCJf0QRPaI6CdQbaZ+GDLpJslfXZeZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhdd8zZBJ3SRy1BdLdMANnQIrxxcpr2B2pHp1mS0dL2zS3hhAgZiFrUdx0ePaZD8izRdD3Hy98peojLdUIr7TVLWMqt8vBIMbsj9b2f2cAaXmTZDMnbJ/l42cPtuWME/Bwoa43CxSJyAvcOiDpl8wqS9YLLtXVvaEQRNn2Gb87g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v5q0vG3o; arc=fail smtp.client-ip=52.101.56.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v5q0vG3o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZOBU7YxZGB3RWBhVT7EKBUJIvV35eshDy8zjTkooReJgF/3HA0F61HJHBnpWdDI2CKzF/Whv09PK1PQrHp/1pMbUgL4xQRkxhTHUUlBcmQQVA7egosU9vfbbtrTkrjdaNR1+bHK1Inh2BcFmm+G1eA2HT/OYWUYeUW7Hq9nrhfG3rg7mDjgSqrbhjV1TYdmVkYqBSNOVpBx/Gr2NLk+1GiXIk9SdRiwd4w3zSkEV2z54NqSxoQ2AVnhf6+x3tTwIdbFvZg1RRnkVwJFonhG9vXejyyS/lA21r1+ObHK/BxwVn54sjQuduARsggRxS20Uazgw5Bq8Ttv+2EMlkG4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIc3N7etWNw70yACoOjlSKAB8rRtNg0f3BDP9Jx2iHA=;
 b=QjgCjEY+cDhoLm03tZ7el7s9Hat6eWUB/iZggK9YjQuvlMoKTzJet11gwqg+QeIGNaB55F2K/GPr6qUhN6VlS2dz2RrcM1yfaEmlGjcKMnUBtLRMt+O9JUmlWpnySsAPpeh5nWvZeExd3dFuewfitumTD3gUATtoj9/PQKKDqgKqgBVXTSGGgOHkawT8ksm03X3xzvfRsDnXuX2foVINIWzIccJ3QZ1NLmjZlMi36ZVH9ZYxJ9ilv9mKr4ZeYG31XDbQr6/lyrB0RrHqlAZquz/r3Q+1//1kQ2yCEkAVsZeiLqtgSeDxj3A8QXHPtG3KsFaZ+rQMldccJEL48kPEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIc3N7etWNw70yACoOjlSKAB8rRtNg0f3BDP9Jx2iHA=;
 b=v5q0vG3ojA2qRYMd8MdtO60aV1rEyXKBZ9U9/ghTZp7Kvngue5jfer3sUaMyIo+Uzl03apEai3rIAIBFPi3PNmJIEnIjxyFNctyummQx4mUEuYfmm2I3XELOquOhwakI5u/GPCWR8re/vnqo27r0o089uPr3Y8RmwtsSh2orMok=
Received: from BN9PR03CA0624.namprd03.prod.outlook.com (2603:10b6:408:106::29)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:08:23 +0000
Received: from BN5PEPF00046987.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::ac) by BN9PR03CA0624.outlook.office365.com
 (2603:10b6:408:106::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 13:08:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF00046987.mail.protection.outlook.com (10.167.245.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 13:08:23 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 08:08:11 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iommu/amd: Honor IVINFO[PAsize] for paging domains
Date: Mon, 19 Oct 2026 13:08:00 +0000
Message-ID: <cover.1792156095.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN5PEPF00046987:EE_|SJ5PPF75EAF8F39:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e12e663-3c6c-4711-b2e1-08df2de20e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1NNv5IseDsrJHh47MRN2vRw2st8HDb4QhDGVDPCXq3kuNiEVhHs3FJgpIkbLJRkxAfF3N2yTSDYZhDUVkz7GmjkYsMYd8u4pdOQYWXB83vB/zCPRA718LwQjR+paAE8tMa9UbSsAgUgvq8dN4c0VXcPaYf/+iauzWAHPZiH/qDlxDgbjghqZ2ussYcLkaCanADJub1gyFp0voJfYb6RpMDrc3F66b+LzkpawdWtqiAEGgCk15ezoJNdWaMSe8s2e3C5ml5/ACpZNK/7Mn+7L05jKdSkd38Fo81pGZsT3UsNblf7CY6tVgvT3VXig1BWquEAVhma9yhrdv4I02hJJebT7MfVPN2bp7PuPVGgsocchhjfwpXphR4AVDaJ+JMnwvB/8kDv+OXhhEdwGThVFFQsBObjQ9YwGUBPwkMTY4gaY+snd8hFPWaYqCU7AuSQA5s/LrSoes8xGWQpStW461Sc4bsC+rFNq4jVBibDGEPp8ZNZSLW1TuvGB9zg8heHbUHsWmzdh47RQtf6JCFaTs9UBi1LFGwaPB8AfUl0wiuPqKuvZEXN7nBItkLkglcF/SrdL2Sw0k7LpJjxVf+cYDOC1LY4wFZAExD4BRDo6J4Hd5gGJdsoSIDqZ0tDGcFT5EChqASR8RN/qysWbQxtTTym79IRa2q+a1JsVDuZ3cu4KC9FdwJkUU5C8DziISdHr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GeEJCjW4oF45fMKibpp4Y4Waz3JC0co0I3iXgA8SLmUoGi7CKA5D5tZoaOFaX5pGyDj1jHVmuxuRA0CCDG9NeCzg3tbD2Ks7J+aIzwJh5AeIqr5yNx8k8KnG/+vrnW5KBUI5DYZhkP5BPq9HQtTqR27HF02asxlvUHOFLgLI7XvpqllhEZZO88fWBdqcJ9BIDcBykwi+jawnibdiKJpMhRP+8lpIdosqr9/yBmj7ZXTM3ulXoa3td2WqjdsUTDPPs0XvAL4Ebc5gDt4VxVg/IaOg+djWGVIB8VNMJS5025McpBPK7+OtLT4kNP5Ecmaw0L+XbvluViLR+SQ/RhUe8HUm0tKaMQ/pgShWpoASJnWXg1FXmbXZrRcvKK50VyTEIuthYkMqBqNmGhbBTmxsezcc6FG6aMlpX4C6izvMTOJ+BIgoIam9JuKxqJ6gYJ4u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:08:23.4355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e12e663-3c6c-4711-b2e1-08df2de20e3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046987.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39

The AMD IOMMU driver hardcodes a 52-bit output address size when it
creates paging domains. This series honors the PAsize reported in ACPI
IVRS IVinfo instead, so maps cannot exceed what firmware or a VM
advertises. Patch 1 moves page-table setup into init_pgtable_params()
after the IVHD walk, with no functional change intended. Patch 2 uses that
helper for PAsize and applies it to paging domains.

Ankit Soni (2):
  iommu/amd: Move page-table setup into init_pgtable_params()
  iommu/amd: Adhere to IVINFO[PAsize] for output address limits

 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 95 ++++++++++++++++-------------
 drivers/iommu/amd/iommu.c           |  4 +-
 4 files changed, 58 insertions(+), 43 deletions(-)


base-commit: 90201351a862182bdabfc1ad1c97b1e1b6ed5931
-- 
2.43.0

