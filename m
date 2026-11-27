Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779607;
	b=ua8LoVT6EW93OJUK7/JJRlyHdM9upZnUyuNsBc6QjKpAHDB61VERtyUwWyiz5cjbVmWW
	 8bEfN/CYnalmy8eUKnTJq6BUgQeQsXFdXCO03b9wR5SCXuE5etD30d6iFdXt7myb9F/fy
	 eQszGSES6O26jk5Z0/1XzNkzQQ/0FrUrvp5H83OYrjp9jbsfz6mX9k6+jWp0v3SNEbz8O
	 MTo2nHGtbi44EtA6KVqX5vtEiS3nIR0CNkicBAWGy/+aYfKh+c2uQAcXZghlQx/tBS12L
	 G7O17UaTzWHMOjlHW1cqjWd2Kg7Q5dMDCVS0zaBSawH2/WyeN4T/5KP0tYELrXmlMsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779607;
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
	b=aQmFbH3iuUQIrI0XoeFy2M+w7qcw7+HaBLBXHxz1zw1shuIitESdoz4aDOVu7zhwU000
	 mqVDo2jRgCaxzIHP5Gz5XEJ9McONP7AxzkJXePpGg18+S1VGj/fAzSbBzwmzBBpj0zjhQ
	 2ddA3d6PFZCnTo6iWPjvVtnXoonvVFYQ1E6+Kk0WnjzG4kyeC8WzaI1lgWTmFm2gyK67s
	 sHTHONodnS1v4AmW7IL1gskbUl6KsxkkFlkS+2pkThrbImZR0QOH/rd7BIMOtP3AdwPP3
	 ji70rRPSuUm0x1FVDDP41d7g6Yf3qpmF8EV501b3Fzl4Y2cOuJrkQJdV0ZWWx2VFFLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OM7k0JYC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.35
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82845606A31F
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82845606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OM7k0JYC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXmpXtsEGXvapDSls9QrFhohqKqL3CeeSQEP4Vl3q8SzRgBteI2kRIyyFq5e5ZtKwS4q1mnI2yVV1drce0QGuke3etVu1x48Rdx3PrJsfXWC5N81oE8NR/ouMWQQLUEXZpaYed7vz/nTsIcMGzm+UyqaXt9YvRPgvOBahCqOcCYlxN2drgB87rQv1ols7zyuG17UqN+6MS7r4n50tD1VGBpqyA3uBIrfA+yyQcRUJWEV5VxcGaWdPJHhpJ9A/CMBMkjgg81we5225m0Xlis8UHw3oxi7flPtzgQCGDGHHmIqQnyGNbMW87yobeURCRrHbXK5HE4zXAKIBcwZbqqF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEBEBOH4hbIz0her+Q/qpjoAx8lKY3MC913TioY6OF8=;
 b=rKd6khmxbF3qwXufsWJgX2ePviKmWgq/5hDPM4I8cr7Ud78nHb4UcwX23jagsYVISCnLy4M8D/aG86N2x2k0kBCTypOot3zltl4FGB1ba21oqMt2WZ/W4Ea91GaGHG3u64s13Sv/vfieJQ4sch5aqHZjWuBiCp8uDK7VBr6m3K12QjzgaA8qk6HpX0j6BMFXoYZTyoOLCA4kc/X3C2syywWMfmRpqY1Nsf3dw4yjppAfTYkSbttdY9CXjLvacq7CZKfTcrDONeJa0m4f/evFiBIKt2ZRcp+p9uFIl3FIttB6a+/UHX3AX0SFRZ4sl4MzcofvX68ky4+QGG5nkGjnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEBEBOH4hbIz0her+Q/qpjoAx8lKY3MC913TioY6OF8=;
 b=OM7k0JYCVmEPuJb7LSIe7s8oWQNCjDDJJIo42TD0sHfXaPPOTIkWsxulYernaA9SWU9HYGdsq99AGd54oDP1j5H9usADF0LUmEZtG4vLMwN0JUcFIa2oDbG/OM0/az8SfxVG74bRNgMDlrMhTsI64REbYgabuWslHBu0gcuelYQ=
Received: from MW4PR04CA0096.namprd04.prod.outlook.com (2603:10b6:303:83::11)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 27 Nov
 2026 11:40:00 +0000
Received: from SJ1PEPF000037BB.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::8d) by MW4PR04CA0096.outlook.office365.com
 (2603:10b6:303:83::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:40:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037BB.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:39:59 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:39:54 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 RESEND 0/3] iommu/amd: Lock the device table by DeviceID
Date: Fri, 27 Nov 2026 11:39:31 +0000
Message-ID: <20261127113934.209373-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BB:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d28177-31c2-4653-9665-08df4c7b2b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|261009221227099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	myycEFc6LqVlpid9ByKle9kniEs2mE5bQ/oVtbOLUO4DgfCcsbxAzULUwj4XqniBqkQb7B/qDGXKtPVcbggof98CVyyLG1TA7p0P8K+9PsloqNreyD5ae1TvxVQbV4eLX7TQU+MYb7dFU+ihTF+swDgznRd8Xa3zfNA/MCV1FRMKVSqH+cd1m/X2+fPYr28XqFWufMp+My9ZuJgAHZ1T2z89Mj0DYyF7XKq1SW1SRBKpfKd8joEAyR5DF9FmhKwmzym+hMF4jQHSrNtbdTDW27MxTf7WCGPVl8TfFDzH/DWTjS0uhmC8wx8iQTHZvGaU2pjSh9o3T//f2F5rx7W5FIzZusCZZkOxlgVrbm8u5Uha0cUXhvQy61WOCnAOVigxbP7JIlyE3nwGv3I5n6B5zOWRheGe4z9f/K/E+laMuu24ZrTVjiAfH0DCxZHHOBHAiVogK6v6y64Ye3nCRpY8bMGID+DHm9jTGORHIjlDJmL+eV+xVLsVBB+YdvXsewcrEa9e5MX7jhqHxbnAulwSvxpvQ/JHj8ax0l6KR6eW6jYKF2HtEOS3HbxlkGfcmcm7mc1/y7vy3Hs2eXsbmVZuFiGIf28JrB/T55ON6HHGAi/xZFDMYTDYtf0HLJLIvCUU+K1+NL4maW1koiX1Lye2zOyE0olue5xQNZ9e8lC6Dbw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(261009221227099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c/NEj2SaOnKYQVmdoWLjS8tnAVFMUzrgCQ3nSYgPMUiA75EMWfQ3lbHFcfPaRgLNKpoLLFSFgVxOElRKAoI0aEFe2UhcPDzgGqCVhnRTQYtcxashebFgg5guf7kaY55VMgvzCy8umk3/Y+wp/38XMHw60THGxb+Te1JV7Ybk/P4Zy5wXID+q/XDF+YoGfHnFyQTzCAjDccMYpKPQL25grtMqge383h45A9xLPfctU5/DOVijDcgZKHdu2bF1KYpmLj1YD6Nit9wChFiOrXBjQ4JRtkS2CDIxB5NTRE5TvS+/TE4PlRQFBVYE+vEQ7hNBpAtbfZjeNLInR4yPfoCaYeOLtz1YCSiV/kZrNaf6Yu4njc8x1jKQWGlpGaqmXpq3Pnw9FE3QNsaqpK3u3gpvDRyOYEG8upmtf/xZSTfhVCjn95xM7Zt1FHhwTfkR1iz3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:39:59.9683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d28177-31c2-4653-9665-08df4c7b2b4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097

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

