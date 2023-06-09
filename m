Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0214AA6
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 10:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mY+myU6Rgp/SWfTZiMRqEBiIpYLGRxXYArW2AdGREI4OYy8uKOHVouME/QrZZYcmpYWGpiK9j3Tx4aejJpBOkjG4y58onqn61qkU696r4/6X0ciJMqEdKEE2tXuWVZuqXLAUIR2SV8AwcQiFDuljb9Hh4dn4B6Ak1wLrwjXwCGFQsAposskZfHFuLdDOWEQsetft1UnG6NHdY6YUOTA71BhJz0fzeDaDT2FpVyOuAjj+In+BsyguZTLZhHfXW1F4vpJkJRjndeMf2xAsXcs3a4Uneh5gQRfi0AGdJ3nN6+LKINlDoPQqGgH8/O14bbFTPGFkEsP+NlyCucrBhBt4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdXy0Sz0RhYLjq7gBhVaXmOJZ72diuPYYILRjk8BWf0=;
 b=Sf8J800uJdc0gFjTOkaHZV/A/p7qYpmpM02JqHviR7XRZC8BDJs1KPqm0qmZVrvOdYjL+kCsABYulQoVkEbpHwbDpt4F5xIVYGXroCDpqxymnYpAI+uAjYSfObT6x5+D0i1xFSS93srK9EeIvbSCoGFyrG6vX9b6JdBOjgRdCdoE/vPxPSigVsDuB8Jr/V9eMJIRkNd9jTj2PQKEb31DQHHUPfBIojOv5CiqRmIJ15/8YMzAGVF2RuTEnmVxt/mONU2xRI97oVpRsV/iK3yfyfxHa1OcT3TC1Lx97zegCSEePnUsuaJZRvb7hQSmGa3dNv6ckMrXaNhCz16p6MrTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdXy0Sz0RhYLjq7gBhVaXmOJZ72diuPYYILRjk8BWf0=;
 b=VMoR7uuDaaFR+zebkpyS0r7fpLzFSYoUOzVzWCZIZiUOcziDBruLPJeSGmWMqg6VPS6MLNQFaGhWO/oHfqL2WDAY/9yjdPrfNr7fzTpPnfsI8PJ8n4fmfNE+kkM8o6oR6UtuIKXrcIFNPaWiwjFD5IVVIEOqLJXtg5PNvZWQgxk=
Received: from MW4PR04CA0154.namprd04.prod.outlook.com (2603:10b6:303:85::9)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Fri, 9 Jun
 2023 10:20:44 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::7b) by MW4PR04CA0154.outlook.office365.com
 (2603:10b6:303:85::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29 via Frontend
 Transport; Fri, 9 Jun 2023 10:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.27 via Frontend Transport; Fri, 9 Jun 2023 10:20:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:20:40 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 0/2] iommu/amd: Interrupt handling improvements
Date: Fri, 9 Jun 2023 10:20:23 +0000
Message-ID: <20230609102025.6498-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fabc34-da3b-45e4-27bb-08db68d32ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EU7KNX7kgu0LXp1vtKK2puJMVGW1sUpMn9PsyyFDNlw0xF7RRTaGDewyFBthTHxXt6wMv9Fxvt0Ggivo980wlZbNNVt/Sdt/z7Gz2jWq8DGq9f0OiVvJ2chbowgJ5dseF0llBqCx3/Q92TtnE1GcHkK4/PzhYYv3qWwOS7F2yeL2tHrEzGVRstg6oxsaw4pTtYoIyqwJi2prvsSxwJ46AclY/qJC21LS0OSFcUYrK2bNDuWUbU/DFp1nSxeJ+QYb/7XspGYNl1HbiKe/t42nwanPStYD1xV5MgCUkUcOW4YgGb3T4/bQMtC2LTyRNVw1DAsdcocW/2sgtE0tUJXmZZTF0xGp//4I1AuTb1jwQu7uOoN6qQpOubJrSF+Xh7Umk0iUgdgjlr1AjIgcx1q+9bIsjcTHP4q6VoneBXPb7t6IyuBLlEwfVlZwYJqxDBwGbNoeMo/tAGDBm7xU+2zEnsHQOPg+u+gmAkJsrftqvjVOqqUhTUICaCv/0SI6+r0xPsN3OFshR9pKbiwSGpnTaCjKMPvMylCZTq5lsmI3bq4sSzyyQzR0C0HAW39CeIz5hTQjy7HlfmeUdiiodlE4EjEkZWRVnuYtjaJO6RszA8AHrGHMmWshBVUPWLqyoS6rErRSI19Lb1gecdtFgwUeCsbkoflPo86ICxt93zhAKqXWc1I8WOoO06ct7OWptfMIJ9J1ftoDx2nkMCCseSTjm1y/sKxnvWFzSP7fpydwCy46lkIybWm8EKVHsEH0P7MAV7DZ5rpi0tTK3DAGslbWPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(70586007)(36860700001)(83380400001)(426003)(336012)(2616005)(47076005)(8676002)(41300700001)(8936002)(70206006)(316002)(4326008)(5660300002)(16526019)(40460700003)(44832011)(82740400003)(186003)(356005)(81166007)(36756003)(82310400005)(478600001)(966005)(54906003)(40480700001)(86362001)(1076003)(6666004)(2906002)(7696005)(4744005)(110136005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:20:43.6504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fabc34-da3b-45e4-27bb-08db68d32ef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122

AMD IOMMU has three different logs/interrupts (Event, PPR and GA).
Currently, the IOMMU driver consolidates interrupts for all three logs to
a single interrupt. This could become a bottleneck when enable GA and PPR
logs simultaneously. Hence separate these interrupt to prevent potential
performance issue.

This patch applies on top of cleanup series:
  https://lore.kernel.org/linux-iommu/20230609090631.6052-1-vasant.hegde@amd.com/T/#t

Vasant Hegde (2):
  iommu/amd: Add separate interrupt handler for PPR and GA log
  iommu/amd: Enable separate interrupt for PPR and GA log

 drivers/iommu/amd/amd_iommu.h       |  3 +
 drivers/iommu/amd/amd_iommu_types.h |  9 +++
 drivers/iommu/amd/init.c            | 48 ++++++++++----
 drivers/iommu/amd/iommu.c           | 98 ++++++++++++++++-------------
 4 files changed, 102 insertions(+), 56 deletions(-)

-- 
2.31.1

