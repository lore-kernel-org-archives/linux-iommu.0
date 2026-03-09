Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E138F948
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065151; cv=fail; b=WmvN3xjx8lBjLMoFYqbQS0MjPiG61xYYSt57XhY3nE1n6WpzwnE1C+7Qewb0jPW76r/P84IajTrC/bBoHw93YaUk+lgOQZv4CS3GHenLNa4hw9FcCtZGGlvd7ljRDbSy2OvV/NGX68ISHAwSBJ0foRHsLiJo2uMnUJsMHDirhlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065151; c=relaxed/simple;
	bh=UwvvdG4BlXP7vpVu4WoPYmMiOB3dNMd2NXVMsxHgjHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y070QLYclzxziVhf+ksE/hukIbbP5SLSu1xohiF/rrhAu2iPneprfFGM0GO8sMW7SFoQbVMQ+1Xjn8ra02pLh+AsP1dc0uauyyKBFZitesIbIJt/KC3hEwn7kWPCmEWdFQ4SB4i7URtPNHwzmQmFfsmu4HZLYpRb0Bx6FP97JwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UF5GPnrH; arc=fail smtp.client-ip=52.101.53.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UF5GPnrH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgYEpx8HsHfrNuOhWABS+aW/cKuW6WAra3yUq0zduHsN6uCkJtj0cTAiIwPZUvUXgMTc7KGNlpZlC8NOsTGX/TwfNN+V0DGeUJQZoUopYeiLb5LheTHLOqR+QsEHB5iwgBoodvtDwlZzuguNBuWt5X+VgSnWyG/Oe2/AyShF7iw2PQRCJn7nWdMnxOQ732Bn1+ZQw1N+jQSGOWqYDiMqAghXdr5F+wRryqYapz9PB+e8YTwPRnrrf5s/FmyRITrbO5qX99kU0e0o5ZHyuWUxDVwU10a6M9D/K89gAMbAc4QH3+wkc0YznSgufULPcg8Nd65y5Y0uRqIcYs3Cc2kqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuSXttYN0KyKDp1/D0vxGAz8ftPXFVm+qqB/VsjS4xw=;
 b=ARlsuE64SDNKLjtu98M7R3TdMS8O6o3heyeUkfywN/gKotmcxGvQ1vJHd32abZTrWG0H+nqO6QmOKaPN0akZyoz29QR0wyJDyf1bZxWurzxymdkMis++mSIZMHruA8gBHIU0CweVbkNCM25qCwWjVs9pOEp5A8y7GBwukPhAG+blHrcUjA6+HEp6Sd5AyFSRJ/ArGC+YQHwRhuxEpQEVIXFgAkakaHeAOs9goBAp3h59zyL+1xZzn+I+l9Ryhfx0YBwOpQ2MabsYQMB2kyRtiERgB0ngdXO3Anr7bltKmOwV1bCnL748Z9gm+qYKAt9ZONVUe96m29nngAxTYryasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuSXttYN0KyKDp1/D0vxGAz8ftPXFVm+qqB/VsjS4xw=;
 b=UF5GPnrH8mj7WkJDXq6e/Vknk7kq7pOdP7yKN9k3jylwZ+QJO2r6e1nFLzxGk2L//wNcRcjW++/0E0XjQIZjs3D/XsvJtOEciGBX9u49wxDulv+SWo61oEUbKkXlueIO0O9+CursEHoLZDS7MsRNRiF1blBZ/23XwWHGjGR1eAM=
Received: from BY3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:254::24)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Mon, 9 Mar
 2026 14:05:43 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::16) by BY3PR05CA0019.outlook.office365.com
 (2603:10b6:a03:254::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Mon,
 9 Mar 2026 14:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:05:43 +0000
Received: from BLRANKISONI.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:05:39 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Respect VASIZE for address limits 
Date: Mon, 9 Mar 2026 14:05:26 +0000
Message-ID: <cover.1773058553.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b5f377-0d75-4e32-f2d2-08de7de4f3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	p7/pF/8eJ0D3kZ6+qqIJVK7aCVji3PUfY7+Cq/pAvZY2AcNeuXBKgGVPQvJA6XGFuTKL5/HsCFDakH2wNXFtSr2uB8LhyFwK3TxIV7skni3wdlasHj4U8ob1BWcz0IH4rFmIMzYB9dgA4SCfdazcd76iT+8ug/FTK+8Agxx7g4cRvk+eq3P39xZdwDOzd6xFAZq8DJAXM88zi58zdpgVyHInm79WHieTw5u86R2u2zv4RtxCvJ/ES5ur0hZemWBh4XIT45VwccdwAK2qFZvaFTS4iO42uVNNIWbn+fdjwxs9LHGJOx2Wm001v3i0VpwZhZJtuU+EauOmWDjiHNqaR0ZJOjE4eXOkMKijmERJFqEdMcDgUjWsvoIvkazLGZ6UVaE3Jj4F1ECUqVbf8RCrk5vIKbPEZNFaNdGo9Qcp5eMC/P+mTmh8i0v2x30nRaZdElEHiRanKqYNpzXadz7ZgIcVAqtpoEWzlUXA3HHfM56Xnz+0ExsZ4tRIgqSgRr/v4vkOlLTcMsbJ2KvS35EMUpz9LkeqlSkGQZpBRhG+lcC5eHQIMMEkUibd4IapuCNKlV+2He1jspdlogJKLdmsiKq6wichvgrzydv1ss3+Lc/BJUwnAdetxkGHwpmbv4U4sAvwcCw3MC+BHAIHIKK6WJ8Eq0FDP/ItSjRV1YyCpUSaad3W388bN7aju8CRcZhMEy7uFnysKnSq1o6/8yfnuzApOCQhyM4B8vQiTfLocgRdHXQicKGaj4rdd1GSaVj9uweUil7t6vSgyb3YoCITPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5eHEjuC5ZtEoIe+Obt2K+FcmPEVHVMU78iUx7uF6eXsu7KU5HroylXXI0iMnWp5hoA9JMAt44EnRFVv1GxhaNRe9nPFdWHLEpWA3HC7CbQ2BtRcDcvribzA+mpLJWR0RUoA7No3MoEQ3U946yqL4GP5Iet++hDR7V7gn/t9XshC5+Fz7cepYvGjg6RpQ05h8vCpcBfrc1bP1CoubzEQsHz6xzpk+fPDh+RqrsseOdMhx9DAZ48Lge2z/q+IHPitOn0GeTbBWEZH01DrSrmpM6XH0XzgjIMaXDMTHvoS0Nc5e/lw0d0cezj8Ya4tCXdZ6TK8FwIMUMfud7G0dZGFQ9DoPk4pJ1h/0CH8u0Gxkbxi9fxNmawT34yFo+UX2o2UUFOqMSuJljefXdhdwA0bJTDn4LmG5vXqzVDKx2DtA3syiLkZzt1gSaY9NbRlupug5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:05:43.1279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b5f377-0d75-4e32-f2d2-08de7de4f3f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843

The AMD IOMMU driver was only using EFR[HATS] to derive the VA size,
ignoring the IVINFO[VASIZE] limit. This could create domains that
exceed the bounds advertised by hypervisor.

Patch 1 removes PT_FEAT_DYNAMIC_TOP from PT_FORCE_ENABLED_FEATURES
to fix a spurious domain allocation failure when the VA size is small
enough that dynamic top growth is unnecessary.

Patch 2 makes the driver respect IVINFO[VASIZE] when determining the
addressable VA range.

Changes:
v3: - Remove specific value checking for vasize.
    - Add patch for PT_FORCE_ENABLED_FEATURES.

v2: - Mark ivinfo_vasize_bits() as __init.

Ankit Soni (2):
  iommu/amd: Remove PT_FEAT_DYNAMIC_TOP from PT_FORCE_ENABLED_FEATURES
  iommu/amd: Adhere to IVINFO[VASIZE] for address limits

 drivers/iommu/amd/amd_iommu.h              |  2 +-
 drivers/iommu/amd/amd_iommu_types.h        |  1 +
 drivers/iommu/amd/init.c                   | 13 +++++++++----
 drivers/iommu/amd/iommu.c                  |  3 +--
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c |  2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.43.0

