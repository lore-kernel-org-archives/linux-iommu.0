Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779038;
	b=clW+y5bIiOodr7d/FB79XNTQBgO6hRCi6Vi3iz0N9o3tcLa36JWkrgLnULpwYei56JNB
	 /FhZNT8xz+qNhgYgKucDPiptqKm7GTyJm5bkJgvxDfUkyLvAhPAugZD504P6RO0Um0sa9
	 9YH014LqaCSlzuel83n2vTx3x6ECfKjj0qCIHJavtr3BlfMRd973K59FL19aPSZ/43vok
	 nGuLX45F7Yo/T/JuItjJa7fEgeM0YpoRymFj1VtnkHgBtCr+zZUPNYL1YPiqo8dIajDIy
	 pE/dg7olZdS5aJY7JpeomIzc5P6djnzExV3DEfIswXkh3NUQWeN2Q9svjTP0pGefdVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779038;
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
	bh=NEBEBOH4hbIz0her+Q/qpjoAx8lKY3MC913TioY6OF8=;
	b=dteDT3a/REnkPmBXNNHAYs5d+4Fvu01X+22Bn8ComxeVAvmCpHW/104459mXgOWKEyoV
	 7VicykHtU7eJbu4xmpxjDla3e+lviCv+K5XqgxGWE8q42L5EB+aogPxTSBT9HV+CRR9aS
	 nMYmyA7+iUUpCuSbXtineevsTcgnlJnx7U34Kb5nj/Ok91VVRO0UNj+rJmgU9CJFzzwlD
	 +bMbWaJnXrGCIoz7GRyPtqGihPzWijuJdlj3NOTkfHl5cr1aE1k0BccTFep7prlRG6ze/
	 DrE6wv1i6K+cZ0ZI8MSVEkHEm32Ulh/R9QP26uCINd7GN4ZNeHE1IoAYwrZOB2pJE2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ztp2w41D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.46
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E7606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D6E7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ztp2w41D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+5ZUvIt3xvIvYSQsIMtlcoMonDtWTVsSNcA6BSPd7Np/Vx3pOQDKkXtl8V8WhSh7mf1Q8DSQnqDLYO4Vof9yrydJWRdqL4x6dRS9zzZmpKB0izplg6G8t9RJMcfxeQ8naF7xpddPCfyMl70fDJtOWO6QRdXkBhzaBVOJM1empOsvgZrVNQtZzWj+8ywUvzDnsU+By++UmplLe55B81iPBpVyx/WVpWWjlXNIwSF6cmOW6fhEAV4f//V708MPIr4AW5yheSwGRyM7sIhMRHTlnM0YfM6ltlMp1dUlA4yxgGHA9CpXTfHbaaeZCKQPnGh/L95qBiO77DTArr8mg+/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEBEBOH4hbIz0her+Q/qpjoAx8lKY3MC913TioY6OF8=;
 b=vC/X8YlAd+4BpdlgHYYW/JZkGnGMKkcbls4pYoSWm+jWGCAKRZluMVNm2rkI5mKV91Jns4vEjH0R8nbCeHVmRaAKOS/MPjmmmUXt9kWQMUwo/YLlNX09R1h/CL/exrqr/9DEpgMxcMQ/uliZ9QwmZiykkZFfnKpX9/l5sKEetvZm5rMgCDP50XurUmUStaupE65vvZSu68DUrpEc7teARw65uVXvbiZ5G0v2zOgVTc4EleI9e08daIGwjt/xlHxzoguynrCm5xFdeC2h5yYfuwOyI7S7IVzllgFuao9Ryyyp+ZK/Ksrh3Inkd3FHzxaWW/4yz21DkFOAuBIQEsZ4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEBEBOH4hbIz0her+Q/qpjoAx8lKY3MC913TioY6OF8=;
 b=ztp2w41DqpjzJ7meVRIC9eiPLYe65YrGZSHg2+aEvBx/lDy/5Vw7RBZnytZdmpmYFHp3KnBobFn+CDo/t/5rXEV0wDLqwuUlkCy7DH1jwP4asmCs0Swb4w5wDfTPSz7JfZiomP3ev++iDsNrw8xqo+amqVA/HyYXKkcEO4VxB6c=
Received: from BL1PR13CA0157.namprd13.prod.outlook.com (2603:10b6:208:2bd::12)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:30:31 +0000
Received: from IA0PEPF0000003E.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::8) by BL1PR13CA0157.outlook.office365.com
 (2603:10b6:208:2bd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 11:30:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003E.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:30:30 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:30:28 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/3] iommu/amd: Lock the device table by DeviceID
Date: Fri, 27 Nov 2026 11:30:15 +0000
Message-ID: <20261127113018.209034-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003E:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 4544c03b-e6fd-4662-a771-08df4c79d7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|261022105027099003|261102123227099003|10067099003|56012099006|261026140227099003|11063799006|261028144727099003|261026121527099003|261021121427099003|261021123027099003|261009221227099003|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	sQPa5PN2clQScwK25RvWaxRK6qt6M7j/uwPC2yr7eXjT/lddMRMc4m91BHEyKV1QFuTiBCF/SwvQ+Iijl83MDlRkWgccmFXW6gq+40gH6KONUYyE5y24weh44hmVsAf9OIGk5FFSIuI1bu1qJyZ1guamKQUGFq0YXxY4XPpXKjTrN0iSLb2pfCH/UhqlZ3Tcjfz8Or3d1cI4IP6LK1F2GTMx5dAJfgbrui7gFyABYQu4d7sZtgm63LPtsFEEsQ8W4+R+B/GxSLTBl0uI//9XojbOOboo7hDtbL1inkLNBSCxTdsIJxIGx4EJWBJwTCdqqP4ycWTIb8F+d8MGgI+CSRt+MI39Cy8RUCqkIHyfpfQAoneYnukGL1Fy60T3mQX/lfmEeTIogXHwfnc6S8Lv4FauuTsNWBgOst7vLpW5sU8FWD65HgTTwNVVF9sWA5dBBYP+b+Wer65nOrABtYH45GldDzjxarn6EBwXqySILZM4M/aYa4N6185x/t9bmEd4kbe7/aMP7i70U8wKQ3ET+mlj0t3h5veDeBD2STChmf0v9y0ml4tDesTV//0uRqqGYkbhz3mNpNw6NTKyfnRFdU5b2RZK6oHAT2hblBK9+m51gcbTdU1GlnK+8dUWMjJbeSBUBRY2PP9eVo+EZSjQ4sOqj5uMHJPPOwZSMIw4dyc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(261022105027099003)(261102123227099003)(10067099003)(56012099006)(261026140227099003)(11063799006)(261028144727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261009221227099003)(261009223027099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aMUzRCp34bX+caZm1TIM9UmHMBZ3+q2AsUAYOSmZuxciBukcT70MMlbaTYGRze8XICO2X+NalkMhmfAGYUj2iOjZ+Om6iOvr3v+9QZiPHoFjaCK9thZGqoEvX16vmJEEgCR6nM6KLqzxXY+s5YstJbBEGCQ4Y1lsxfuCH7Lah3yEjqb+9pYZgaQVM6QjciFS7crm4IK3oWkgTv6xWXgel4NOLfSRDp7Xj37LJGZUNyQaU39QIPsWfYXujLadeGuQuM7a7SBQnNWX9FXSy+XCmLrVpHTeBTm/sWGGjsm6ACKFFExWXJQl4hrHO7oTDrbXhB2T2zrePtv3Pz1/I52RoAaIceuJGj1ZuWYvhO1JilTlWgs01Ww0lLbN5nqdHlM8lyAwW5bIDuFl15oMxmKw0HdxCJ3vnjVMbx0viTH4/3H4w5s4gTG3p2nto6+SEzX1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:30:30.6817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4544c03b-e6fd-4662-a771-08df4c79d7ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451

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
  https://github.com/AMDESE/linux-iommu/tree/iommu_code_audit_7.4_v2

Changes since v1:
  - Rebased on top of v7.4-rc2

v1: https://lore.kernel.org/linux-iommu/20261105040617.398870-1-vasant.hegde@amd.com/

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

