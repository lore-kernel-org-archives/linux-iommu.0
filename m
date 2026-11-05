Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851603;
	b=hcKvULRa55ry75cjNQj3XPVWRpoW9wWoXLtangwbb1sjRNp1UPrqiUg7R9h2PDO6R0TO
	 c6Ttypyi7UXc5n7xDq/juKC9oRtfZaQKsGx2P0qiGQrh83S9yaO8RkKww1APtroRz9e4U
	 4yGulrwcPLdqzKM+mqrIv5nE882O8kabWNn+fXpJWxMzLnh+XKjfNkyocDIudKRnicKDg
	 0yvJrdc2rRt3MMfgEP6hKRPQGzxhn1x2ftNayc6DEoj/mQCgUHc5Ips4sw4oYePLgs+Mm
	 ZWE0KFdrNYUq2J62A53PQkH0Km/COtrWhTDPqyWPpLvbwRUaLlns2mi1UO7g+nH9m4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851603;
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
	bh=WpkrZWDmgY1XMk6wzAphXdvel9ReC6s4sdwGvbgfmUk=;
	b=FPW9Fc+mYs4rP3ALmj4xO5/QHp7F2U7llcRlBVmH6SsweUTBFAmi4626MKsGQfeitQC5
	 XDS4Dw6dpc9FQB4+YxXTIthG/M0ncRPPeGm3be1lpl5eSbZiJUUn+eLqgmMp2dlr8BJcK
	 24ilFRN3jhWArPaJ6EPHjawqgFKX++k35/rNtRC7O7ZSKDTHRvhzsU1Hf1Ojxpug7RrLN
	 SC9BdZjvZjABbjHdCWNTCdr70vr/u/nDNvAK/l2qcYbSsWvcbaclzR96IngUp6x9g41GJ
	 iI3Q6/i0ZhJQnKUuIH18X6i4/f5iwuOzyH3qzT7H3mX0E4tSevJEwbh9Od1miCf2L0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g6aVk6kG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.27
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591A606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9591A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g6aVk6kG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COSuERr4YUWNRrdOviSm6S8cc0nn3cOaPu3ZpihZIsEKgufT5uaUs0rwNW9PfcI/prKII3wGiKrL5Yrx+RauU/xC7Wi+a4NTV1P4h3m9u+3D8J7czq2bZuZ98+ZBGL6lUWP+zXNf0aPQ/74jrNSJlSktP0Jw6US8DSy6CERWjS+YHI3MzRNTJiFOhq38PsgjA6wrZ8a4WEjhRcMfBQKFXhSfPnp0eiEBeuMy3IARd99RuCngX9ggnLZqS9jIskPqh/YFyCjgPL7Aozau5iunUS/SipLJQvHMmNjiO+43IZZJ6dRohz793bw9hWIQUNqh5Go21BbwIwbiyQtT9QSQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpkrZWDmgY1XMk6wzAphXdvel9ReC6s4sdwGvbgfmUk=;
 b=BrhoCsWJ3asl1VPnN7TjU0+KJL6UX4gaCfOfyiikG7LVPvI2jg6xi1AZ2lSjFExZ1O3fkyhLg5NWocQ0ILmkz6Rm0wielAUm1BrBTQgPBUh4YtZKAKrxKnmkeyEDaXOFC6awZxygmNcT6U4f0IDdbHGdNhZioYwZVev7+qJb2DFL+Bug4KcKRufOcxwJjYgTeY4cxb5s4ATEFIUnr8DoROomSljlE93z3zIo/8SMBqtJL6EFng1O5MAJRKwQ/0Syra8DUjzOCRQB/3SnEoLB1F+lQMeFDiIuv9RNAcztyCn5tQIv74ra4RoewDu3x3oeYX/TPzZucpj7Y8nKfbA9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpkrZWDmgY1XMk6wzAphXdvel9ReC6s4sdwGvbgfmUk=;
 b=g6aVk6kGTAisZSkVmni6hB1Z8lhm0lsCmQVU61nX5YgKc05c1j6mvziQvEiGH5TKqbh0DB/r/TnACGSqM+Aj/TtjrRSaJW3Uk6v8ScaYeBqOk/1OxwG9F7wlEAVi8N3VIwD3UkZMmBaeOz2z6tttWWB2NYSd+/0w7ZZtRlQNjVM=
Received: from MN2PR20CA0063.namprd20.prod.outlook.com (2603:10b6:208:235::32)
 by LVUPR12MB999184.namprd12.prod.outlook.com (2603:10b6:408:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:06:36 +0000
Received: from BN3PEPF00022BBA.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::a5) by MN2PR20CA0063.outlook.office365.com
 (2603:10b6:208:235::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:06:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBA.mail.protection.outlook.com (10.167.248.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 04:06:36 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:06:32 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/3] iommu/amd: Lock the device table by DeviceID
Date: Thu, 5 Nov 2026 04:06:14 +0000
Message-ID: <20261105040617.398870-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBA:EE_|LVUPR12MB999184:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c15639-3a34-412b-00b0-08df3af22f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|10067099003|13003099007|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	D+c2Rfxpdg2wEp/F5gFfW2KAXpY3piQ8AqnPbtrXt2gCCle6tvrH4yNc8sPxE0Jlc/kQ6ns5+Jom0CeW6JuG30DnR18FC66Q8XOvB1HqcyI1SRvtckm2O55i7XPtPfvFmAfRUYApBimZoMkexMXP/ZqzDBdMxVDfABnd88bZOKhIIZ1MshUhN3oq5Y7YtB8h6awMTHqPfMOEYD+94qQSbvcmMmTcxqiQny8qyL207S7/v4P1RVhTYkCR5mOtRle6AoqZKeYZTP9Qa9krK9hFclSPPmDMpp5+er1QurKzoWecKXV3+V/rFu02c5Q63J1gR9Gi5GbIy0+xq17fWN9qIi1CJdNIJzApubZYZRou8Mi0j+WaxavsBbhfoQXE81IigmLZVVHBCrk1eeFNBanZtZfTe/YVJdq8VDSC4lXAd/v7/1meNU0EXMd5x3E/oBx4tW4+m3hEHmIPGmKFUP+cwftoHTsqT1j9+hvsfwcOKbnfRoLO+WW44tBrfLF3/3Mr5MhXURuG7HuwfgXJ3ANKsBC6+3xcr/JlwQZCosFN8CVPS6DQnPcyAheckRgBF5/nM6BTjUrKnV70x56Yp7+J7F30p9fy5tLhOrSitQ9ncUumibOGn4IpgxdJXNkKlsdHzLMWARflg5C9PsTLOd55/JuLaHz31VmxCMs3Ul5nCwg8D1Ckl33POwhfAPypaaGe7m8INmhF3QjcGsTNqeuUpQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(13003099007)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gm93dy4w0XCMijRVm/zFh5FVT6Y2zwu8mcJ6FxDPGYY1id00xtdepfDfj+Dx74xZQeuCY3c6wbAPki9ZEVcIkwipt7/FZP/8czJ0iPpy+J0WqVmD/ktBpfAiVcANhKDW6y5J6kNkDeUnjdj81rjEfVBgBFXUrS/ORcHowVs5G3tQGiCg2AAA0b4BJqdyv7ZYHJ35vxq2Qs8uf+jg+UaKFTljsEBSSVOGax5yVjqOknodirmF7aNn+2I6LoTt4W9RQLYvVShnytlYiPHtEKOe2SRldAJzTPkS9FOH6/IdVwff8OBfNeXRw04bnTk19K4qqetni/qxR2/uCpc2niSkqqW5Grw06LtsgQ9i4+eSONiavD7Ntdxa3O1QQ4Xcf9lveuwkbRXU7/o/0eA5LpoLFYBzqhXPBNujrp1dCaxlfjwf2mk9OHMWdk8xyPYcrHBz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:06:36.0829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c15639-3a34-412b-00b0-08df3af22f62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999184

The device table is indexed by DeviceID, but the lock that protects a
write lives in iommu_dev_data. A DTE can therefore be updated with no
lock when no dev_data exists. set_dte_irq_entry() skips the lock when
search_dev_data() returns NULL, and clone_alias() allocates a dev_data
for an alias DeviceID only so that it has a lock to take. That alias
object is never attached to a domain and never freed.

Move dte_lock to the PCI segment so every writer takes the same lock.
Address each slot by DeviceID instead of by a dev_data pointer, and
drop the alias allocation. A DTE update is not a fast path, so one
lock per segment is enough.

Full series including other cleanup is available at:
  https://github.com/AMDESE/linux-iommu/tree/iommu_code_audit_7.4_v1

Vasant Hegde (3):
  iommu/amd: Serialize device-table writes with one per-segment lock
  iommu/amd: Identify a DTE entry by its DeviceID
  iommu/amd: Drop the iommu_dev_data allocation for alias devices

 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            |  1 +
 drivers/iommu/amd/iommu.c           | 76 ++++++++++-------------------
 3 files changed, 29 insertions(+), 50 deletions(-)

-- 
2.31.1

