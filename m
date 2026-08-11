Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF32EC0A7
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421388; cv=fail; b=nkQjFn3kni2SQx8CCZmARWghP+/KsXCjVNEwW7CpolR2n/p3c0IIwQ1AQbnYF6/jtH+VmYw/dfoqt9VENHy8MqbnT6StJMu0IwYlhujo6r4tuGWmBlhrk6+5AVoEfxqxYbkJUOmhnxZIQKYYtRtodfqLzFTvG/WJT/BjiD9c8OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421388; c=relaxed/simple;
	bh=NXPFq3ObNAa+U12AtJz7z2xmnXn4kAiWc/Jl50Yluk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FW+ZQPd9txNZSGvtYxzQk4lYxmWTOI9Y1NIgtv1kVpc5XpDRGHlQzIiFSNrsEuNCcHcFyn4vVYByEXsl9tzhQNqTH/U0ac+wHbDcQn9CgMk95wqm6QYzXRZHixjswJuCMEvbbAMGt5t/ldLxTvjxKkBRjEsrzxnxlmUOnMsyctw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cx2oPCz2; arc=fail smtp.client-ip=40.93.194.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cx2oPCz2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opzPrpxLuF/l4APaCaqdmdODIy2NRc6xA2PelD0485rSS7rL9hCkX8iWUDpbzkGteZXi/88WEQ94ieZWghu8kN6XOfB8hhRBv3RCl2QRmqg2GfIkMkonD2aEG2UQCx/Iod/F+qL216ascM7z5mUtqNWhAYcWZ4amWvcjm1NTWoUYxjoLiKlV9fIrkVaRP3ANdXIBHraMjoZ+QzN4kVxTolRbG/LoLUqpphVr4zG1g8myZd8xS/h1VCnHpA0D2HLiVvSijKFghrjRZ7J949ec4MpeKeLpb0I+BBKffeAW9uE0znD2+5mjg5/DkhN4vYyaeqpu7ZmlWy+tsvv6QRxIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnAZ1zL4AnWiezB3QqmB5MxoWdCseI6ZMJJPfcP5ELE=;
 b=ZUqYEF3i2r8+/BTR51jYWlg3kG3egE5HignvqFkj6+TkitHxGXaWPe4UcpBJItfhG7nl9lu+cCtqThdCPKFkDqPzgh+3XElBane0aAZZfxPbwXN1qCct/qj2Buy99ZmJXgX9NCSo7Zu4Ymv+XL/UMIaYvLhHnxeT7b2j9YOWdSj06dZoBceO29oJWvIVxR8gZXnWn4Ui90CXhH6K2XY/KfsQ8gXlFOj+GPsmBO0ZWx+yEFGD4qfNRFAchbjQo2XBkmUw+lXC9R9eLexqnDiK3DfoHuELxkyGAGGQoZDUE3WybD1DhaaYZK9dTtoH+nBWfauE6/gAEwUZlupuXc8g3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnAZ1zL4AnWiezB3QqmB5MxoWdCseI6ZMJJPfcP5ELE=;
 b=cx2oPCz2lnAQUdofNjhuua7kn68MYHV5aVhyfHeWYQu2qljI7CSzq0zeeAHcnWtKHIaZbHJwjbiNSiJ0NeZm1v11axAgoawpTMikJKQctdwHK5RsJGsg76hCNIOiY/8IS4vj+fhXIXyqTVKzXv0tdG//2H9/bzp9e+isfN4LJfA=
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 04:09:41 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::83) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 04:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 04:09:40 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 23:09:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Ankit
 Soni" <Ankit.Soni@amd.com>
Subject: [PATCH v2 1/5] iommu/amd: Fix incorrect device ID in invalid PASID error message
Date: Tue, 11 Aug 2026 04:08:56 +0000
Message-ID: <20260811040900.8572-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811040900.8572-1-vasant.hegde@amd.com>
References: <20260811040900.8572-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f58ac61-e979-42c9-de1c-08def75e5de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dt9tt+xOb9NaJW4DyU2Gee8mnAcZHdW+4OkJ+kSSR/xrIt2oY1hL1K5aB5qyrAcBV+eiDwzEkdXJjQmJ4dJ1mBXrj+7M7VQJcrvHDbhIXjcfuxGvfxi5ANZYC8/zwcX4veArazC9qRuqCkHtkwnD4cdddJLYsbH0k5eBrp95DKbODGBodMY3b7+P1X60yB+i35XMv5LzjzGwTZXbHlIZzjv+9x9+JoQnfym/HENvu38IE1UAPu4uOobe45EpEgj/vbjU8TbCBzvcNF1wzRMyubNTYwPg+iASKwzpAeNiTThyN3Gfdpj3pg8MB1OfS303pOGBMtZ3q7vPsZns705127uFp3sqa09+6exdDHmYMu79VY3L6ZqriVI33bnMqnDTbYKnRzTCGvQ2uv9OJE5nr3Ksla1X6dkPqGhpiD8+qpjcbUUHxUQG0yHvOxdmuIytJ2Pgflsg4AcWvDThDxCWWoSyaXhjgenEJcpu6WUl6DIygAJ7yhTyZO1LZMO6j4/vnb7ZduL5EsHM4R06nHgi/7JxKKhGlC2ILjuQUXFmqaUlUXVIcHKj8qN5vqxzDj8ksdDY5pbhkuu1r2nC6UPIGBB3rJPEWDV2ol4d27V25RCvSIlC79kCcMI3wqZCyrX3ohUARcKIsA9wSWFfDoSfVgpdzZfsTOCKg01XoVy1msed746wHSsebHXuadKSe3MpT4ZyWQYe+/odbv83bRYpNQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S2/E13vTm/TtdcCXi8loDms8qpkLIXWes2MiUvG/pJIuJL+/lJa98+WOkiKOAQOXo2vpOKCEi8EOmbQ4G7dWYVSNLRVRawYOQoB/36sPnUWR1sl5IRD1hAeepEdIxCpIBNa9CL86Ch/LVPU1oqFMgIO1F+uS73u9YfAjbikDwWBCw8r265WXiDvDN3N1JZvO5rpFWVQ17eRmhuswHbMti+VGmvB+O/pDF8cfbNhV38bXrmq0V3EPBWGG/1XJ49zhONEKo7/9QRmRUx8eueT/CO+LFypD5cAQgynazKS8gidQLbypquqGvBZhpkuxDrTEIh+pNfiB0HOZbkM0KpzD0NlUplRiE7JF1Of974tIcrN9h+ODk11HguE4MAB0wyjpW35ch3w/fYFrZh8xpAuUs/UqZCuY1aOc0pd4WbRbAWkP8Q9w2F/vTtJEZyINmktS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 04:09:40.6950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f58ac61-e979-42c9-de1c-08def75e5de8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350

The IO page fault notifier handler logs pdev->dev.id when reporting an
invalid PASID, but pdev->dev.id is the kernel-internal device ID and
not the IOMMU device ID (BDF). Use dev_data->devid instead, which
reflects actual devid.

Fixes: 978d626b8f1a ("iommu/amd: Add IO page fault notifier handler")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/ppr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 80369ca1e316..1dde19a79e80 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -140,7 +140,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	if (event.fault.prm.pasid == 0 ||
 	    event.fault.prm.pasid >= dev_data->max_pasids) {
 		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
-				    event.fault.prm.pasid, pdev->dev.id);
+				    event.fault.prm.pasid, dev_data->devid);
 		goto out;
 	}
 
-- 
2.31.1

