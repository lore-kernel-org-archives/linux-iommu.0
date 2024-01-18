Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B79125A6
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568646; cv=fail; b=BH/9vkXvNawh4wl6J7uTVm0QQCF0fUyxpunDV6FCnRo+LQBzau3jP7A62grGc7BZb+/c6nMk/ah8Aw+f1DPaf3mFG657O7QxW/Il7hgBVuE2rKE+1QrJPYFp9uioly6qwe4n5qPiPwc1VGMxqvlCRYrxWqzXFy1cjr6kcxgUY2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568646; c=relaxed/simple;
	bh=pR6vpW8tKkwOpVm5e4xh+x7wCk04LDoNtKGnoZENWeg=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=kM4Uz4NSSLyLm/vJIxzKa1my/5ezvUBG5g4KAqqLR0sc7IIqyGhhhqf6gFI7iQYyoaKxZw5eK19yPITgUBvuLxAxjVtqlq2kZTv2SDfelxVeLGGXE/J/wKNCuMRvHdPBxYZ/w15j89I+dLjYlNNbkaxWoMY+hI2ER2IhrRAAfMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b0vuK6i6; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b0vuK6i6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTftipY8MdvJYXH0c6u5v/OgbJe6aBnIIPpSwkqy5JX+x9pTYu9gUAlq0UKWVljC/NXnRDqhsLEoV1KN1OYLWx2rutPLSxKnXplBTy5gRRnUsfalw+1xT2ococy+6nMezmNGSPWiJZ143oiGmaM776dwPHhKw72jB/czjWmyqwZjEN+b4j5FbP+eVTh0ri1tdOcRYZl8MC8pOc16WlioePS5Vztw1BRqnFaKt6gw/82Wdr7cht1Lb9hS4RKknhQFs1x2d2XgVEPvtOje89/yNXc9QqXPYezLdntbqwxrkkCR2F389MIjjC3J62CXEW+o0LJPaCUEshN7yuGsH0Ghog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q75wSWxi3N+ICBXPVpqouxpHVWgoTskAQz7KBuugd20=;
 b=YO38JOhuMwDeAgneetDCB2EJobiEi6yk5tTaJmRYKB8qkFOHc91mp9uoHw1nbzMnRDMCUKsZes8DzilLIHUUhq4aquANnZWAUvJDpJINUq4bltyUYsLTdtkoYbmkpxu/4Va/cz1XAvJD9tIbyYSQei2Nx1pop9KmX3neQ4wEl0HOtmggKsZwJ3rajnPHPGqAL/P+oZUzcqoK10BuEKW9vireJLdYaOb9jcrK461NQCSMphbFMtqqxplyy3E81K8iW/JJJrCLcyGEPHrCwOYTe3uog7fsQIvhGKNR1Zn6kAq7Q946v3RJpO2/+QNZpf0oGJ9Bm96XEoEP5d/9ezKVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q75wSWxi3N+ICBXPVpqouxpHVWgoTskAQz7KBuugd20=;
 b=b0vuK6i6HSbBx51gRY8ntBUUMmLFWD/9X1PcLaALBMhV4yXnbgoNBK3MhJVcy8ZQQ59T6zC5mAG+fciXaV79jO9cEgxUy9dI/80zf01xIPUWBE8zPKErAavBpzPPFICiADxFA5XnSafJn3ypYcwjvDK70+HKNgC557m3ga80nAk=
Received: from DS7PR07CA0017.namprd07.prod.outlook.com (2603:10b6:5:3af::14)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 18 Jan
 2024 09:04:01 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::d7) by DS7PR07CA0017.outlook.office365.com
 (2603:10b6:5:3af::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 09:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 09:04:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 03:03:57 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 5/6] iommu/amd: Remove redundant error check in amd_iommu_probe_device()
Date: Thu, 18 Jan 2024 09:01:04 +0000
Message-ID: <20240118090105.5864-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118090105.5864-1-vasant.hegde@amd.com>
References: <20240118090105.5864-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 239ad2c7-bbdf-4a3b-8dcc-08dc180469f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lEiOTygpCPG/rM7A4bO8wscOmCUeXTvbdsCosYhU+qPhInAVOjq7/Z6WBZ8xc5LcQZLgx/eKkDbVaX9RiaW7BCWMgj7BUHmt51Tzz6I+1tSgTPfku2FCBZnWrowoubeL53USA0dmJxmF2YQc6EIiZ3kq3Phtwr8TmxQ3ylEkMLJkDa5wniCBA8lR1cMoF3zDcyBaERkMosceIBt0KyE+FuW3t+KQX+3ZDQ9BPUjhn850vjn8nJPslp5BY/wKII04/gS1Rc/8OwEmmKAHt00+KG5Hi7PJ1fjGSOu/Vg2lk62To2zI9U4k8acl5W3ZLFLSLXJZgRVlocL00OK2R1YXcYKoQCEM5JYFxmfvLSsgv2E9RapdFBp7ga01yhvH4w2CO+jJimBcfRPOOA2kxwMUWfmGZB0B7+tvOgDopEUzUU5Wq7xjdg/jHKgh2/F+Oz0jwh6m2S06MK6/DGJY/Q9ff9Hg5WLjSXTl3JMdD1VxSF4Rj4D/vxkeB7O7n8xApAcmlQ9rJg+AHRFDLSnKBsTECCVq/IjKZIqB9UtFK04rkMRvGSxSpj1H/cPI/kIyhSQTRFdDmspMvGCugzHCKuD3jMwtPHTg2f7lTVAmY7DBlGp1OUQSuHrZbzHfQaF5GmKd2zCX+AZFwiDz7sApHjNYoJyc33kwycoDE3XIv7CSIP0/dQ5N6q8fM1DdtX7nrAccaK+jyx6wIkhbygogEd65C3rZSokW+BoDmtGX/4FAHhy47dCcHyLGP8Sjw1yhmWM1D2Sx+026zbGTX1BShls7oQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(8936002)(26005)(478600001)(2616005)(6666004)(4744005)(426003)(1076003)(7696005)(336012)(44832011)(8676002)(70206006)(356005)(54906003)(47076005)(4326008)(86362001)(316002)(70586007)(82740400003)(16526019)(83380400001)(36860700001)(110136005)(2906002)(36756003)(5660300002)(81166007)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:04:01.5138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 239ad2c7-bbdf-4a3b-8dcc-08dc180469f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185

iommu_init_device() is not returning -ENOTSUPP since commit 61289cbaf6c8
("iommu/amd: Remove old alias handling code").

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6bb4f2dc5194..431febbb0fab 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2175,8 +2175,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 	ret = iommu_init_device(iommu, dev);
 	if (ret) {
-		if (ret != -ENOTSUPP)
-			dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
+		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
 		iommu_ignore_device(iommu, dev);
 	} else {
-- 
2.31.1

