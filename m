Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D51878
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 05:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8kQ4YhnvZJVAuFJbBSZPvNA14bGqKjcm9cz9eq//PdM6tzXLno0mFgq+3bsANN65Zz7gOnQJ5fpCL0SMLI/fNTy1gygio4hZOKDrER57w4QoHkxA4ysa9+cNAce15Dpt5/E9JVWO54JilnXeeNjbIw2og3SGIbvBHkldATponkCJ2S9PBi7GxrouepgaWGJc+GtyQM11JRoDMifgYNlCP7Alup+ppsYNKWIvHNSx/9cjlHWuCwEjMeLi2bkyD9muAsZU9KHQ41W6ddHxeCNWpB8w6rdjm0iYurUhtc2csSKQEnJC/2eGRYQQYd4BE1MC0TCAvA876XsIIZhNZc17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa38IV1uhq3g+ksr8U0hZ1VM3rif3Gn9SUV/HiOpNW8=;
 b=ZJ1HtUSdqoE4+hwedQfsI9kar44L2h2R/AdC+iycoeOJT4zBvxFmQAWFjcuMIb+SbRc4JjDShMHsNIuR7UrlCwpcnz0irhvvYAh1hNdow8O2xWQrlpwMDAAfZZlGfRkE/eHTyurUsziS1SByu9eEiB0GPJwgfLHRrTnsj5OpQ50m+1H/Jk+kO04pmunNKTSKJZhXWC7eZsQlb0glgpaAsYwYY5qKL/rE7mrqJwo0ocNFizMP/2C9qCqIKl1IhR3H7FOQCehXLttIx6/0uw5p9BBq/6yuWdbczPeJfo/NMVW4T3tpcETPUqSUOkXPAfMNqkc2nUmROpwcNqcewrlr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa38IV1uhq3g+ksr8U0hZ1VM3rif3Gn9SUV/HiOpNW8=;
 b=vqqc4CjrrL1NECfpRscxz4TClNd8iVu0EJzMJwESC8qjbgqM1WdhAGqhkNhdBjhBOPhVViuzaMe/SYw6w2RVpYQck/DJTyK4yebbekmK37MrGq+f7WF5+ZxVtWS26wdspaF8hDCC4XSw+oyF9ARs0disRw6643bxjIhIRdtYgqM=
Received: from BYAPR05CA0067.namprd05.prod.outlook.com (2603:10b6:a03:74::44)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 05:17:02 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:74:cafe::ed) by BYAPR05CA0067.outlook.office365.com
 (2603:10b6:a03:74::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.16 via Frontend
 Transport; Wed, 28 Jun 2023 05:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 05:17:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 00:16:58 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>,
	<jsnitsel@redhat.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 0/2] iommu/amd: Add PPR overflow support
Date: Wed, 28 Jun 2023 05:16:22 +0000
Message-ID: <20230628051624.5792-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab28212-0415-4f74-1682-08db7796e797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bfoCrC8vrX7ZBUIFYo8rPfv4ZtnNgGRfRlqF0gaM5gFU0ITgOxQs7RFooq/SGkDNAOSFGr0J3QOaZnO33o5DjfZBjLWJw410eixZQFYe7m8ddSUwXame5xRhqEmE1G657qdY7+Lj1dFXzvdI3eXCkBTLdIYda68fbLRR8FnBo0KoMI+wPjLFZBCtwhw5ZYwXKxE+jzdCD4mSXmzhviFrlNPaZALeCpNg8lPTAduD0pslKT1Wr0bhgku0Pn7r+wjILz4to5EHnFx9YASOXsCpxBBzEGk3xQZNFKMqupLRt5u0pLzJa03X2/eKaWp1GMksuDAuSL5Zwsd9iy6e+zthX48GsoZv2yuDsVU9NC6BN46QuNDMN+sQmHv9THkKe+FCzsLIKm34NdcTrnhPo+IsjMB2FpJdLlFI7Li1Guio8gNIQjhHf6PwaDXlly2teJEf0sqiWwxX3fnqDHuf+GtdlvGg3pLCbYtOrhE53V/vWcFyYysEW9vnxrh0HXqJPhoTjO5H7VqBA/WDQdcETcfeCi9klzCzsFbSnsF9mbO8g4dOSk17Q1rmbREvxJX2lJ/EQx8TDwmDBdddMMTjTOQCCgybI6wxTfrzhgJOiNbPpn4d61sZGEcM6m9N3McBO7S7irLwswTN/YBw8LonAtOPSy7fhJvfkCbZ8MPg5TzjeQIlmUElCjwbatRUKCM38fZ061naMuJoX2SKxOqCRnB8Lstq1EGJ3NuZmEoUfENl8zvCFhTdQ9eWh9gBZ24nA2hm7qrwShimyU/0HO+pLzt7iHhcUsSKgHGFPQsxWjEUE8s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(70586007)(44832011)(70206006)(316002)(478600001)(4326008)(36756003)(8936002)(8676002)(5660300002)(40460700003)(1076003)(36860700001)(86362001)(110136005)(40480700001)(2906002)(54906003)(41300700001)(82310400005)(966005)(7696005)(4744005)(426003)(186003)(47076005)(6666004)(336012)(16526019)(81166007)(356005)(83380400001)(26005)(82740400003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:17:01.6514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab28212-0415-4f74-1682-08db7796e797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996

Current IOMMU driver is lacking PPR log overflow handling. Add logic to
restart PPR log after an overflow has occurred.

Patches applies on top of iommu/next branch (commit a7a334076dd).

Changes from v2 -> v3
  - Added Review-by from Joao.

V2 : https://lore.kernel.org/linux-iommu/20230619132346.6021-1-vasant.hegde@amd.com/

Changes from v1 -> v2:
  - Updated patch description
  - Added Review-by

v1: https://lore.kernel.org/linux-iommu/20230609101746.6412-1-vasant.hegde@amd.com/

Vasant Hegde (2):
  iommu/amd: Generalize log overflow handling
  iommu/amd: Handle PPR log overflow

Vasant Hegde (2):
  iommu/amd: Generalize log overflow handling
  iommu/amd: Handle PPR log overflow

 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  5 ++-
 drivers/iommu/amd/init.c            | 60 ++++++++++++++++++++---------
 drivers/iommu/amd/iommu.c           | 13 +++++--
 4 files changed, 57 insertions(+), 22 deletions(-)

-- 
2.31.1

