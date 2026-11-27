Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779288;
	b=2nTgSAoysS9pm5ln65PXj9r6umiSTBcnB1qlPOLpskVkFyAwuPsL4IoMe6NoawhZGQon
	 HbcsKKeO9ePXpVoppmmIglZxyzfQdPM+xUQQcnbH2BIO07RxUN3TT+bBd4yjGwFxaCUSD
	 FpUcwVqvuGr9nqk6HCPKtVU/fryrOlsrXEfC2MzOZN1BHBV2rdueZaWTGbzlMTFA40iEE
	 l86YQKFI7dB4mDUvzvVVf2JlZrvVHuUX2IzYz00cx6zfGnTKk3T3uZSbLgHGArbWNBAHq
	 Ln0NZ27ZzZKGXQ6qZtHoDIactENDo5l83+jJlSarf4j0W1fFEVLYDiRZXbdCC82rbNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779288;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
	bh=2rBYHA7OM+amBdCGVz56/1vrUSkn2ijJaM//hjDL1w8=;
	b=jhOtvS2ylXKmeYZOc0i+FQqdTye/ezssIriApDJuB2thZ/cBosDme3r6hEyFTvPr4vQR
	 rTBE431LMIF4gjSZYczsU9aW7ON1Sgs9rsOkc4TOVnDQKmjlZUduEdyFfJa/tq/xWiXXJ
	 JztbApGRKV8y4JqnULJsEXU1Um01B2SXyTyIEhccj3bopyl3PVoFN7+Abwpb6ZlxHlvjt
	 3Oncne2YpNuuUr4Akrh4OPcsNrwlMsNpeqGkCzfD6OeFc+1TzkR6usMQ5QHVz2PmkxFKs
	 MiBeQYZ6D5i51xj/tNRI0yJA+KXOb47bw+e+ndbSXzUv5O1+HjcUBKhSmwKPKlZdaiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BK78W0pE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.45
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471A606A32C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2471A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BK78W0pE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6CwjyG73VEFfdgHtznCDhxMtsYBLi2jpdS7MGLG0KU33QV8gzw+KeCSHeokr8qGULciwff7lUqnlpyaPr2aaGRseTdS434Qn9sqpcVY+ccRnmGZvp85qFk42LCvfg6/In7A4/gnyn3tlyVoiDtppzosBeLOX2TG0tbn0x6vUuWqKsWv/MwrcnyEirCZEjpmhLJMTtpW7IkPul7QfrikrOUgY66wmj7+oq6qtV1r/tKRPxaC6GevmP3weV0SDJhSAV27vUMpqTE8U93dAap31L2QyhpF/GyKcSq7L/KZ1chQiwbrlkxUFZTf48DYaOVOfbK9f5izbxtOr4+o419uAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rBYHA7OM+amBdCGVz56/1vrUSkn2ijJaM//hjDL1w8=;
 b=PLGqxq8ACUHs2Uo8YnqGcwubCoV/kRBJV3xNwkKQhMTLZrHXvzYZMRhfQg1ZwngqeW0UNPjNkbEOJusxbvzr5JVN829fp0Qz+n7ulCFYmphB45O1ylI+kqq/D/S+MccM4ab7jMtQ0LwXF63/H0YYl12+KIva5jZ28VqXBCRUSgdpaH+qG7YHe1qGAZL8M3Oy18/KTG6VySkiTTUfmyx+6aFSb74cTZgomhBxTO3vYGogHk+j7niP2GIeM3i+xar+aLXgkAW6D1ZWIcvBJ2Q1DtKP+cYKTK/2BC2ky+3hzjHEkOX3t5JQBRhNkDit1PLalo5d+2OIbtWSoAiGOBrm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rBYHA7OM+amBdCGVz56/1vrUSkn2ijJaM//hjDL1w8=;
 b=BK78W0pE012YQqV+RFy4b7XxDdtqZjSwgQTXVTWNlSfqgx2hOOqepAiOAMSZC5uADKzXF3tvuSFRAXji0o18CfWpjfjS7zmaNrHl+Ng7CGk4EKVGC+hUU9r2o/d6pXSXhhGXxCkIX1o9LCPm/Z++7tzzJDZDYh/oq4V1zf4ZsMQ=
Received: from DS7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::14) by
 SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:34:39 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::16) by DS7P220CA0007.outlook.office365.com
 (2603:10b6:8:1ca::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:34:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:34:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:34:38 -0600
Received: from kali.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:34:36 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/3] iommu/amd: Various fixes to interrupt handler code path
Date: Fri, 27 Nov 2026 11:34:21 +0000
Message-ID: <20261127113424.209190-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: aec0af95-d5a5-4cb0-ca4d-08df4c7a6bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|11063799006|56012099006|10067099003|261102123227099003|261026140227099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261022105027099003|261009221227099003|18002099003|261009223027099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	yN5DkN/MuxwMGJJeU6RZVA/UP31sr+NupfAuintqu+k2bbgNxMr1RJQr3N1EQEm1ZjP6NOZ/COrOMUcGR68Jhggse1zi/6ANCG/WYaQ6NwhH9xY+IEMbUm8aYxLLwtyZY0i01v7oSCVLm5CzGD6moH7rp1gi6d5X9Hge7vzo1OgGVyhRi4pNO1UDy526Bv7ZjdcJZk+B0jsDZboHQ3wUOUzTjCKjw+X82Lc7HFNZgL9wgUls3xbppNpiLvqqsENr5SVW/nSPog90KlCEyskDg9Wnn7TEzDDmCE4FpX1pgSlZZHPN5fOlIS6xUElkRMRlbOb4I9ItTmmmlCKMTiiZpZ4b3xKA3MGH+upU49tEovLdttRaNWLjnqm7LOwZpwQxI4r34PFJHHH1reTU8xncqA/soOZhXvj/HEtEMZYlGA63Mneh4AfavevlUzRrbC3tiWFWzXKXTSnZc/UcrtQEoQIAUj4XId4Yxbvl9mYCjY/hUnhTPJQFvb53IamXLZBxAzNlG0MTQTD/iFh9L8zTERMs2x+MlcQCmbuTwR4Q6q8PjUtBXWBN+V4lm51dP909wtmZUamhxVIrpGzwnV8twFjMmgVGhDFzV8fqIoeIcSvUYJ2tnBp+tNGcWhSpbXpD4xq01A8teYcOR/cVmYoRmB01cxutuKkcX2y9HVLpRx8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(261102123227099003)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261022105027099003)(261009221227099003)(18002099003)(261009223027099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	44TYNi3ingMv8ze+7+9md1V8lkTS+GHUjLQV8PnJ0aJ0iqCZh9kZitsgpjG2PScj0KAI11NRnn+132yrmQ5Z/5hqdjO1IvTwubx4YtCrDWxA8OcCfexBrxkgJULDSf4vE1oc6lkt4+HNBQoTNBSwDS2iKcGj5VZOiXThZ45cD4xBwJ+k0V/arKyqtgpZCkQUUbVO05slWVWOKUe7pBRVO3oqM0btUL7U243ApHEtL7Z62y2nMJNVMcxSKhb9sUPiqZDSc5UcaUs0kxlVDxJSXmiM5dIPxPDHZA9JbyYA9iIDrk/qVfSaoNCauGk/9/hOM9Cf8d2GlOljSiuOyA+BGNYh71cnSQyFx7crmjp921HgukhVzxEuGRbuD6rzwCufYXmOTcZ7HjQWngW1ZreE8rX6RrW+p0Gn4+giika3MEOMKNlyKriGRjAThb8o72Uf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:34:38.7089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec0af95-d5a5-4cb0-ca4d-08df4c7a6bc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025

Two of the handlers race their teardown. amd_iommu_report_page_fault()
reads dev_data->domain with no lock, while detach_device() clears and
frees that domain under dev_data->mutex. The GA log notifier is loaded
twice outside an RCU read-side section, so synchronize_rcu() on
unregister does not cover the call.

The I/O page-fault case also returns before the event slot is zeroed,
so the entry is decoded again. Print the raw event before decoding it,
so fields the decoder does not know about stay visible.

Full series including other cleanup is available at :
  https://github.com/AMDESE/linux-iommu/tree/iommu_code_audit_7.4_v2

This series is made with the help of AI (Cursor).

Changes since v1:
  - Droped "iommu/amd: Call the GA log notifier inside an RCU read section"
    as we have similar patch from Li.
  - Rebased on top of v7.4-rc3.

V1: https://lore.kernel.org/linux-iommu/20261105041603.399016-1-vasant.hegde@amd.com/

Vasant Hegde (3):
  iommu/amd: Clear the event log entry after reporting an I/O page fault
  iommu/amd: Hold the device mutex across a page-fault report
  iommu/amd: Log raw event log

 drivers/iommu/amd/iommu.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.31.1

