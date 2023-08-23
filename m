Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C70BA48
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 12:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOExFBUmZJbSG88rRWkPGmQeNFLmHVSK9pkzsPsZFR+jWQxhmMXQCgaBl53z7CwrQTIBPEsNTIUihpN2T8PVM4gYi2L7hsTMpQnt74QpZN0pGSYUkMLASLo1pcSQP2gDGiUCW1kfmmcetPKb7eIjpiRVw5rt4UbpPPvBjrGEb9QmG8k+WQFL4NP7n+osSuuSWXn0zbZaancTVTm6IOTw+Zt3iBJAfKXJUFfeG+QRvVizA2naFxkPz/OhSj0XbZrvPvGse0Mj451LJsugiYPh1K/Fv8HJl3O9CYLRFhGC57MVN8xy+kjYpaVYlW7sQCfUPrTrHpywR+Rxk/W29CsqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjClAeRjN6r1ixXK4sH65IE5RDVP9eOHqE2aM/hIqVs=;
 b=kZluh0PTOkvrXW0wu/yBIPVXYGCjAmPf3XB+h/Qav9+ej325+4kxZ5zsC+BkgHqnezbxWp7MAEQmxkXOw8PAY7zhC1JwfbCepzRQwm/3xdMsOJgS8UTwHpGk8sKUbvl+GX6+fdQAIr7FrZCSYaCVMPgMSkc0VTEF9BnPjCV6Wc0B5HxGgut7avS5xSRc6tK7TNpRKr9aN+qgak8SkQM8QBfvI7a248KfYXqQD/tRhDpvvB5lM8pxPUvY2o5hjX53ykZA/kB7mIs04q6eUuZ510g1NKPXQgKmQb5hJkzZ7RPst5Sp/a0frcXrOukhGZlHAg2pv4Wk4nuKBF0yriUcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjClAeRjN6r1ixXK4sH65IE5RDVP9eOHqE2aM/hIqVs=;
 b=S/TvbhTsaq2zPg7rKo63fBS3qtirPeb3PeCjTiFRech4f2DE583NgvSVVMiDs4548uVf727lp+8gnmaEId/SP4WwxLfedPlMs908UtPqw7sbTdiJiIUhAPEPbnsr36lyzVZiSXj54PEdUedOmEe7M2KHDBjyPHUOC9Q7namI/0c=
Received: from MW4PR04CA0232.namprd04.prod.outlook.com (2603:10b6:303:87::27)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 12:02:59 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::bc) by MW4PR04CA0232.outlook.office365.com
 (2603:10b6:303:87::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 12:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 12:02:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 07:02:54 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 00/10] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Date: Wed, 23 Aug 2023 12:02:10 +0000
Message-ID: <20230823120230.727935-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c69c93f-eba2-4656-01d4-08dba3d0e42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f75hgLMN0+J+qALl9ieC7jGEi3MaUOebSNlPzs/sNmNMoQh6X4z0Vn5aqFCYN90XsOF9Ul6zratIM9om9+QCPW8rCq75qQ0zb+iqZnh19tfT5tpor57uA2xSDatDMcr509lIIakY8RnpDG0xqP36umyKv2o2qJZSCkSB1/KShLdvaL2xefdYeQ2Rf+W7G9DBFjhy81+Rf3n9Hnkbp4q4J5beDM4Z9/KGD4nDISUaLLFwcXe96jxurx1Bg1Me/TNITlPBleG095jPsvCg+WWDoiXZ+4phJQATvq4ZRIBnpbAGjBc3qWTKhEmj6XabcahEGmPIh33Z9Tn5uRcvVjX+Boc6bfdZ/tJUph8g2SAKBG2hOaC4G3XQQBMBsTSMebv5YGqkNx9BwltQfWiEZq5qHGuyBLr128JL6QYhVk3GzOM0+VGkv+G8o3FDeSmV1S1jDqNF4fK1BSea04Cs3aRBRbEmwLNImT7uJv5wjvRewHd7G46M536iMXH2akE0dB43JPnVGMxP6E0BjMs9tGyZuzCAV8EyuNHaxk2Vrj85UIkDg+mqSJ/qqzHxE8yXbtgMS6ZVzaPg7sk9ChHTRJ8vGe3fY82lqEvV5J8UA6z+Rvw+85D+1X0PpLUwc5ttnlmlSJk6DfTW8u83lUFlbNLy8ymxxtsmjo9mshn7mMjbS6VtWIt9LVbsD1vEasWBIVZg5uGcQUswPM3RtxoDZvVSOi7AkWH6b/GOFDhqXtSrBic7uUpi/IfZ+iiIBW8t6TrctrNuY9vdjAJJBGKm9UZlNRQ6EvY2/w4yZSWogk57ziU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(83380400001)(40480700001)(7696005)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(47076005)(86362001)(36860700001)(8676002)(8936002)(2616005)(4326008)(70206006)(316002)(70586007)(54906003)(110136005)(478600001)(81166007)(82740400003)(356005)(6666004)(36756003)(966005)(40460700003)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:02:57.8199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c69c93f-eba2-4656-01d4-08dba3d0e42b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

This is part 4 of the 4-part series to introduce Share Virtual Address
(SVA) support for devices, which can support PCI ATS, PASID and PRI
capabilities. These devices are referred to as SVA-capable devices in
this series.

Patch series organization
-------------------------

This series is organized as following:

* Patch 1 - 2:
  Rename / add support to enable/disable features

* Patch 3 - 4:
  Introduce SVA support

* Patch 5 - 10:
  Add IOPF support

This patch series is based on top of SVA Part 3 [1].
  [1] https://lore.kernel.org/linux-iommu/20230816174031.634453-1-vasant.hegde@amd.com/

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part4_v1_v6.5_rc1


Thank you,
Vasant / Suravee


Suravee Suthikulpanit (5):
  iommu/amd: Add support to enable/disable SVA feature
  iommu/amd: Move PPR-related functions into ppr.c
  iommu/amd: Define per-IOMMU iopf_queue
  iommu/amd: Add support for page response
  iommu/amd: Introduce logic to enable/disable IOPF

Vasant Hegde (2):
  iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_sva_supported()
  iommu/amd: Initial SVA support for AMD IOMMU

Wei Huang (3):
  iommu/amd: Add support for enabling/disabling IOMMU features
  iommu/amd: Add support for add/remove device for IOPF
  iommu/amd: Add IO page fault notifier handler

 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  41 ++-
 drivers/iommu/amd/amd_iommu_types.h |  22 ++
 drivers/iommu/amd/init.c            |  72 ++----
 drivers/iommu/amd/iommu.c           | 170 ++++++++-----
 drivers/iommu/amd/ppr.c             | 377 ++++++++++++++++++++++++++++
 drivers/iommu/amd/sva.c             | 328 ++++++++++++++++++++++++
 8 files changed, 894 insertions(+), 119 deletions(-)
 create mode 100644 drivers/iommu/amd/ppr.c
 create mode 100644 drivers/iommu/amd/sva.c

-- 
2.31.1

