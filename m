Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6014AA6
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 10:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5byzim/B4FVHSN+7BnERdQybUyw0yoHP+MTcOqQtpJS9EsHWWb+i+MN9K1mOyqeJUVSbSOkkpd2DD0DrkB8CM3Wn1HtvplyaJXdJFjFLb1dUHEnJTevI8DSNkKXH6MJ6Wt8G/jQEEoFo5+cC0eFHtXUrf5fmREalIyWCGyLQwo9htI7R5PZw1TJz6ggin2AedXUUYUpS/U0AALZt/LfDhQdubxj3tpnge111KaGIsiiH85Wtt7brVr64uWGzbxa99b0YFbD8h/E2eVjlfZkcPLXyzmZE3PoxD9koymxjw5puszQOYk/zQxSM6OuKSIk8PA4YgoN9IOEgzj+XMNppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws0C1ZVtiyzM9xfz7EBAAhItMzOPkCOW/80W/zHFreg=;
 b=jltItd7FRtn5gIef7elSWhmm0qHTR+A0xLXL6/MsC0gHF6UUvR8KFiAeC4W6qvvoB3qsB29O7bdsABzRgpiYoAwgHEaq4OjDhw8t0C9e/ZoUNL6cJk/oNpkyj5WYWucFVEbOApNAUj4PV+NVPkX73oTiuDnJHKe8p77qceW6PEtqupKMFSRwZ7hHFpsGHWx9Oj6Q9wYIv5R4SeDVH0rppzej1ow7gP7IZiXWypKkycgOqQ9rrA7+vHrXVy7L42Se9cUYl5GLhOSfdR+On18LnrjIQO7JE+lLn3D/xFz8QrFdwOP+d7GTNMSkOi3yK3Y7Xo5G5k/F0W7Wbthe+uT7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws0C1ZVtiyzM9xfz7EBAAhItMzOPkCOW/80W/zHFreg=;
 b=Rgd6mYpFN8pNDiQZKutn74fm23nNG9bEmy3QwvWsjo/ETeC/SCdB8v7kHGjHea2Jq9aavVdb/bLjM9V5R7uAAjZK66hZpWoHqImNm2zwDfQWcnsrozd9yYRikzITp+PReQmfp8neGY+3YyPlipFaOmyg5Q5MN9G9NkY4kP8rPvQ=
Received: from DM6PR08CA0025.namprd08.prod.outlook.com (2603:10b6:5:80::38) by
 SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 10:18:03 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::e8) by DM6PR08CA0025.outlook.office365.com
 (2603:10b6:5:80::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 10:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.25 via Frontend Transport; Fri, 9 Jun 2023 10:18:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:18:01 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 0/2] iommu/amd: Add PPR overflow support
Date: Fri, 9 Jun 2023 10:17:44 +0000
Message-ID: <20230609101746.6412-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: f16943ef-8c61-464f-ac13-08db68d2cf84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rrtkigYAI1O3XxBuXPzw7N6C4nYZNYUjsX8r7pIB5rzAaymEvkihkAEowb6xgZ7hYV8h2PErQiztOdsQcHXMs4qRSlLBYVJc1KupHyAkxsfJUgFrU4Ocnaapnos+nreLSmYywiOL00WF3yl87lculptw80WgMjuoyD+j1mZZfBtDOZXkB3ktZHXUXhlrmLJGy1d8HyMW33C5lhbgGRgvDTBQGtZYLcR36/txSUenB92ySVdtVJOHB0bfdb6iY5MPkgqOACP88uh3zx1eBn/dxBGFl+ftbS4au22RNDQPYkR0XQ1XCYPIKzJ9MYgA2ZsZznRAo59YWhLk98P9Fk4ezVrmBQVQ7lxLjmnapA+JG6hmtdZFV2cIX8oITEmTdAmJczVEgUvxBjozxU1vv7CwtFN5wzGuBYeMJEp9U8JoHhiV95adyacbESqXEkQORTzJYwQbHJZaiGfdm/GLxlcBuMtcTpbI8S2IcgOKb+bkb1+YvZLXO3MQoY8i/O8CwSjzssRLIPNJmyoRZw2GV4ktgJ3PhTNwgy7PDJ4t2NYvgbMXW6qonT4eBJz6qTNafdGTwK+6JcVTZDK6ftGBP70TT9zPMMihHKDSXw7A/fVY3yWDtSEIrjxoAfjFtpc/JI76oz7Dph5APHktaQwNt84L5b3Lr3LyQoAT6nEM9+1VDy3Yd2klyyKu3dYYiYGYQksW6mRfGtsf2R4V6PoCT2ejXRDr4ANrT/BS8M59Efp7UVluHX+9bY261Dmd9M3QerqZT1LlfCOd9nB1TTqv+kFJWQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(6666004)(36756003)(966005)(7696005)(2616005)(36860700001)(82310400005)(40480700001)(86362001)(426003)(83380400001)(47076005)(356005)(81166007)(1076003)(26005)(82740400003)(16526019)(336012)(186003)(40460700003)(8936002)(5660300002)(41300700001)(316002)(8676002)(4744005)(44832011)(2906002)(54906003)(110136005)(478600001)(70206006)(70586007)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:18:03.6119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f16943ef-8c61-464f-ac13-08db68d2cf84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749

Current IOMMU driver is lacking PPR log overflow handling. Add logic to
restart PPR log after an overflow has occurred.

This patch applies on top of cleanup series:
  https://lore.kernel.org/linux-iommu/20230609090631.6052-1-vasant.hegde@amd.com/T/#t

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

