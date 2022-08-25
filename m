Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355E1C30
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ib4n4xX5ZpEXpkw9Q2qOo5VNq0S+GNQpO2wnH4g70+1oSqh6/ujRlE7u9M6V3FsHOzLtjfRCeCAy3VvJE+iTtH7HPXErWEmsPXcuLYkVCTU71CE3iF8UDkA3r65OcXErMTJ1ScnCiK7Ibx9HxgUc8ERrIoHEFGJglaQFOF/x8uCq8WJaCMi9+r/vJjfPn9YVnIyimkOvygJFuTst21UTiaL1GGEiWPRQbrfsQBoi1JzjcpDuqDyyZWfUjmrnnWM8JlZn6f5FxfjbUyR/zlWDeSbSSmq6bEKvpa/S0bEXIfp1tYHtM4gRPlbzmDXqgaD17ZBKS2LMmRFkheuNhnTbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWs2bGfOwK4gIHhG3iNpXs7TrdZPR9Rd3gHzr1s1WM4=;
 b=FGJCIRuzUcQp6AbhOPi6A2+F1T75Dp0mSQeTIJ3SgxxOoScoteP7078JFmwFXGPkGwGO05y8j8RGt3i8jL/JuDlu0WEanvVCCnCigwA4OZgYD/u/nD+bGsmWl+50Bv9MneZYkX6VDj9YLoytMm5f41TT/DG7YosTEZ2ukk1hQLrzoVgM/nfwTmYNF6fuZaZjWk3+0Cp8e8kXcEdM4ge9Wo9di51hlqV5MX64PslKopsO/t3MurwCugIG4bIx92sPaarxUVmBTWy9wrrv6/YEIkGTcZW8A8U3jm2KH0dkPxGfCw15uXAmYDCFr6rd4Mib0OpGv4mZvvTHYRiSKXjQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWs2bGfOwK4gIHhG3iNpXs7TrdZPR9Rd3gHzr1s1WM4=;
 b=LcoJ7hqzt4bThwYRpc9RJf4BgvBbBS9yO0dkQxCT/t0vki5A7IjCYaAGg0aKbitL7+BDV1fhAaBXxikB34ECEgsI2PCDk1ohGS2ExqtoUTJCwuhfmDG/UPDY1A8IWTmpDiSixvJtxfMWG2BLCeAbzCDh2zKA0msCP8gxrDhDIqo=
Received: from DM6PR02CA0141.namprd02.prod.outlook.com (2603:10b6:5:332::8) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Thu, 25 Aug 2022 06:45:22 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::fe) by DM6PR02CA0141.outlook.office365.com
 (2603:10b6:5:332::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Thu, 25 Aug 2022 06:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 06:45:22 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 01:44:52 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 8/9] iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API
Date: Thu, 25 Aug 2022 06:39:38 +0000
Message-ID: <20220825063939.8360-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825063939.8360-1-vasant.hegde@amd.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07d363aa-4b6b-4405-3ac8-08da86656212
X-MS-TrafficTypeDiagnostic: DM4PR12MB6182:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	haakgvmb+q0RPXpZEeDTNWQtgFIkoNlv+3AEfy4afmrKLkWKEOoBNZX5zDb4Ntqkz2tDveixoJet0vw84GaM67CPIOlhNClMpyvFlARPSOfAhgk6dvwDZazXU0UD44UJ+tHbXLUCrf4RkIASRw3JHAFzcoEZ/y1EY3EdqPVeCbdB2nxQovdJ5ShZAuCNLsnhxoPzZ+rK9SwkYcGIoD8FUNW+tPrFq046o9kTAoKUZoMyBaHk5Cwkmg28E0KTOmdYJO9rEL81FWGtsGxZe42DX9tlGlfsXyToQmMJZO7tI9YxGS3Jvra5s/PB2ahxPOlLoGOovoradTKrbFcZDAO4Aa3SioJvboYXA74PipZ8opFwfuY6pRmA1prOz9clIM/u7wncd/DAeIxF7A/TTESCXi5fA8lI3Hpnp/68KVRVNupXQfqrrx4iFo7NdRr8KYXG4Khp4f08RKpAZO+dxKmdG//Svc5paGgm5TJX9gCpK89JMQjDPXFgBJOnT7pW9c3wWqZXZS0c13MJgwGxbJtZJIhiPZwer2rA3jre8oAmjWdn1e0BqugCZO+G51M4/TYVykwZU8T20o8DlYXSeLGGeDVeQ5Nu6PHG3ddmL50MsSf7Mmus913JOGQ+0wRGbdhdAXlgyEbp7/hV/QT1fXALUAyVZQZ3oqYo+pcT4g8K1dePj98PnvFOVmlQTmRKJGgtt0zJKNGwxf/atCUVLPCbi7eWNVK1kORGEblltmPHPuUU3f3hy4Rc8FeXbp3ofdmPfQqXALVSlTtyUWe4QRRaDRYwcYGEvelhojNgTdHBGUd/i7+C0jGsXowCLTDbnJjk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(40460700003)(82310400005)(86362001)(36860700001)(40480700001)(81166007)(356005)(82740400003)(70586007)(8676002)(4326008)(478600001)(5660300002)(8936002)(41300700001)(54906003)(110136005)(70206006)(316002)(16526019)(336012)(1076003)(186003)(426003)(2616005)(83380400001)(47076005)(7696005)(2906002)(44832011)(6666004)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:45:22.0433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d363aa-4b6b-4405-3ac8-08da86656212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Introduce init function for setting up DMA domain for DMA-API with
the IOMMU v2 page table.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Changes in v2:
  - Added support to change supported page sizes based on domain type.

 drivers/iommu/amd/iommu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 95081a30ffe3..d057189de2ac 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1653,6 +1653,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
+	/* Override supported page sizes */
+	if (domain->flags & PD_GIOV_MASK)
+		domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+
 	/* Update device table */
 	set_dte_entry(iommu, dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
@@ -2032,6 +2036,24 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
+static int protection_domain_init_v2(struct protection_domain *domain)
+{
+	spin_lock_init(&domain->lock);
+	domain->id = domain_id_alloc();
+	if (!domain->id)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&domain->dev_list);
+
+	domain->flags |= PD_GIOV_MASK;
+
+	if (domain_enable_v2(domain, 1)) {
+		domain_id_free(domain->id);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
@@ -2059,6 +2081,9 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
 		break;
+	case AMD_IOMMU_V2:
+		ret = protection_domain_init_v2(domain);
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.31.1

