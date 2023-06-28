Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904833D7
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 05:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTiVeaWONXIaO/qZvqFQPtYTdsC2qqoYdqa6pZzoPe0deZVz9F0Lu0pct2odFjnHe8TBUIifVZ2A8mkH46TpJBlQJX8nOiY4zkLPhF01i2FPgna1LbZF08fYEp8aIYAl5D/OG50ssNCR4gAHfL1kAW70REtOhlGE+59SUQZxyZIFVlgpVrDHwLGSQ7yq+42QLzeim19s8cjSwoUYuKYrhekW6pVAE/xx65nK6u3FoWaQtYXT/gCiuhdQu9gp89n7flrCSh67BfN/3kccZLAZhzsXmQtcX+FOqjCe/JefWg2wyT/H7b6czilpQ/oB++BJgWzaS2oZ2suMwa0ec3yl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72o6cGRTotS4LMZF3pccptY94wlXrOzanZ2nZ2K64Ag=;
 b=dNqCLIvxwkTnWlWqPi6ojmTQC4okXx9QLnrzrYi2Na4WhH8rcL715EM6zJlEAaX0vRDaUq836VJCdRoPI/ne0Y7Vd2XB1HRYnFG1ddlV079BocSxHacTJQzDoV0t2ksE9750oLXsA4i2yJymrHMnVrx+FAmslb1kSgGN1IY7gJigzbh4rqed5FluVdXK9KlJM6Ok9f9E7VkdJSY+QOyUe6Fn4vTSuiIwmfeOD6+lgFQ+2V2/ppAn3uTskPrcX95yNPES4Yo+J1/9BEVHDxZxQqvnmqgtrbzwvnD9lsF6ZHGb9QKy6PcZ3B98j3zl3TURUWuWBbGhsysowlKX/yNsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72o6cGRTotS4LMZF3pccptY94wlXrOzanZ2nZ2K64Ag=;
 b=UirS16YEHI8sp66+Joar8hIOITtsi3A/7dG/AuK3QB6zwfF8yCo6zUDFtFSoAuZ2HqgWpd/K1Sz5e3OORbLZHXaXecgrdvBLRTrtyTe7s0DD9OqA9Dm4xKSyJlJuPoglXONkDihFyYQfTegeNZZ3nFburoQeYniyBRieJGv1kv4=
Received: from MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 05:46:11 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::94) by MW2PR16CA0019.outlook.office365.com
 (2603:10b6:907::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19 via Frontend
 Transport; Wed, 28 Jun 2023 05:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 05:46:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 00:46:08 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/3] iommu/amd: Consolidate PPR log handling
Date: Wed, 28 Jun 2023 05:45:51 +0000
Message-ID: <20230628054554.6131-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: c72e2dd2-3f2e-461b-e415-08db779afa34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CAPOyMImHGt2UWK6OyAW8s4akA2JTv9wUFzdj0qvPTukqIz8tYuRN+K3RQ0rs8kUroI1+1YTXyduSwysjzFiprPjW6GNb9vCEFSS8pX88d1OJYQ2L/jRVZimIOxI9dsCHsbnCm0PemoDgykvBgGqKUzXrM5v8nJwOR4raBTOzhBAU8Iheklp0A2m9cuCaj2jvvr2fabNvgMXjpMNdB6eioeW+g6zGlVlabKmSM7bWsCy3of2Lz6CgU+P3QV6hcculPZcFD7UppQG4oD27FvZQ2hBIRbpbdkvfviZQqGdjmLuRTw4b5Ims7nAnio33Wr3+mS1jGxRbGzVms/v8JVPTdqA+Ej/vv5mnYJRKKU/dGoAIiVhd+iaG9ktdrnq5CtLHpRQ3e1zgyadZ7hQMRdyAujzXs8ABhCN5GDfBs6K2bV3lf6M70JXtVBsOn0jdoSTyuG1XN3cODM+RmB5So6XCXihANdSRLolH+sHjyiXd9QVnuDESBl6gOZNFR8QdKlm7CRWFW1grImnaU+sCP4KhVfi3xF6QDJMTsJ4B4svSOphWuCW+9m4cmJYmTIJ2BCD0SZDcHYSvNsRw8+pAsYkWCPOw0Ujy1B2vMf1WjdWrqMdnY4/H0riod63GxB9n7L2zQLLN0U8lkZTCyL9pVqQtbtVcMvxLzYKkBBQHMdyXztFuakb9TWmhxcBUD5sGedXfC1utFNHCdSZwEV4rLJjGXhARK0yKqtQB315INAM0ba+LAf8tZSjDg36duGSkn6/M5hsC+eUN+zoffxucdVsDg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(36860700001)(478600001)(26005)(966005)(47076005)(2906002)(7696005)(54906003)(2616005)(6666004)(83380400001)(110136005)(336012)(426003)(16526019)(1076003)(4744005)(186003)(70206006)(44832011)(5660300002)(86362001)(41300700001)(36756003)(40460700003)(356005)(82740400003)(40480700001)(70586007)(8936002)(81166007)(4326008)(316002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:46:10.7777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72e2dd2-3f2e-461b-e415-08db779afa34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Consolidate PPR log enablement related code and also enable PPR/GA
interrupt after setting up the interrupt handler.

This patch series applies on of "Interrupt handling improvements"
series.
  [1] https://lore.kernel.org/linux-iommu/20230628053222.5962-1-vasant.hegde@amd.com/T/#t

Vasant Hegde (3):
  iommu/amd: Disable PPR log/interrupt in iommu_disable()
  iommu/amd: Consolidate PPR log enablement
  iommu/amd: Enable PPR/GA interrupt after interrupt handler setup

 drivers/iommu/amd/init.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.31.1

